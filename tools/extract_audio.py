import os
import struct

# Splits each audio bank's track data into one .bin per track and prints the
# INCBIN list to paste into the bank's .asm.
#
# TABLE FORMAT (at $4460 in every audio bank, so offset $460 into the bank):
#
#   +0        word: distance from HERE to the start of the sfx pointer list
#   +2        the music pointer list
#   +2+sfx    the sfx pointer list
#
# Every pointer is stored RELATIVE TO ITS OWN ADDRESS, not to the start of the
# table:
#
#     target = address_of_word + word
#
# so entry i resolves to (2 + 2*i + word), NOT (2 + word). Getting this wrong
# still tiles the region - consecutive slices remain adjacent, so the extracted
# files still concatenate back into a byte-perfect ROM - but every boundary after
# the first drifts 2 bytes further into the previous track, and the labels stop
# lining up with real track starts.

BANKS = [0x21, 0x22, 0x23, 0x24]
TABLE_OFF = 0x460          # $4460 - $4000
BANK_SIZE = 0x4000


def load_bank(bank):
    return open('./banks/bank_0{:02x}.bin'.format(bank), 'rb').read()


def read_word(data, off):
    return struct.unpack('<H', data[off:off + 2])[0]


def data_end(bank_bytes):
    """First byte of the zero padding that follows the last track."""
    end = len(bank_bytes)
    while end > 0 and bank_bytes[end - 1] == 0:
        end -= 1
    return end


def collect_pointers(bank_bytes):
    """Returns (offsets, kinds): resolved bank-relative offsets, and 'music'
    or 'sfx' for each."""
    sfx_list = TABLE_OFF + read_word(bank_bytes, TABLE_OFF)

    offsets, kinds = [], []
    word_at = TABLE_OFF + 2
    kind = 'music'
    # The music list runs until the sfx list starts; the sfx list runs until the
    # first track's data, which is the lowest target any pointer resolves to.
    first_target = None
    while first_target is None or word_at < first_target:
        if kind == 'music' and word_at >= sfx_list:
            kind = 'sfx'
        target = word_at + read_word(bank_bytes, word_at)
        if first_target is None or target < first_target:
            first_target = target
        offsets.append(target)
        kinds.append(kind)
        word_at += 2
    return offsets, kinds


def main():
    os.makedirs('./banks/audio', exist_ok=True)

    seen = {}          # blob bytes -> (bank_str, addr_str)
    total_blobs = 0

    for bank in BANKS:
        bank_str = '{:02x}'.format(bank)
        out_dir = './banks/audio/bank_' + bank_str
        os.makedirs(out_dir, exist_ok=True)

        data = load_bank(bank)
        end = data_end(data)
        offsets, kinds = collect_pointers(data)

        # A track runs to the next DISTINCT start. Several ids can share one
        # track, in which case they resolve to the same offset and only one
        # file is written.
        bounds = sorted(set(offsets)) + [end]

        n_music = kinds.count('music')
        print('bank {}: {} music + {} sfx entries -> {} tracks, data ends ${:04X}'
              .format(bank_str, n_music, len(kinds) - n_music,
                      len(bounds) - 1, 0x4000 + end))

        ids_at = {}
        for i, off in enumerate(offsets):
            index = i if kinds[i] == 'music' else i - n_music
            ids_at.setdefault(off, []).append('{} ${:02X}'.format(kinds[i], index))

        listing = []
        for i in range(len(bounds) - 1):
            start, stop = bounds[i], bounds[i + 1]
            blob = data[start:stop]
            addr_str = '{:04x}'.format(0x4000 + start)
            who = ' / '.join(ids_at.get(start, ['unreferenced']))

            if blob in seen:
                src_bank, src_addr = seen[blob]
            else:
                seen[blob] = (bank_str, addr_str)
                src_bank, src_addr = bank_str, addr_str
                with open('{}/audio_{}_{}.bin'.format(out_dir, bank_str, addr_str), 'wb') as f:
                    f.write(blob)
                total_blobs += 1

            listing.append(
                'audio_{}_{}:{}; {}\n    INCBIN "data/audio/bank_{}/audio_{}_{}.bin"\n'
                .format(bank_str, addr_str,
                        ' ' * max(1, 24 - len(addr_str)), who,
                        src_bank, src_bank, src_addr))

        with open(out_dir + '/text.txt', 'w') as f:
            f.write(''.join(listing))

        # Every byte between the first track and the end of the data must be
        # covered exactly once, or a boundary is wrong.
        rebuilt = b''.join(data[bounds[i]:bounds[i + 1]] for i in range(len(bounds) - 1))
        assert rebuilt == data[bounds[0]:end], 'bank {} slices do not tile'.format(bank_str)

    print('{} unique track files'.format(total_blobs))


if __name__ == '__main__':
    main()
