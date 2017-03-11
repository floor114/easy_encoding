require 'easy_encoding/base'

module EasyEncoding
  class ShannonFano < Base
    private

    def generate_codes!
      divide_and_encode(frequencies)
    end

    def divide_and_encode(hash)
      return if hash.size == 1
      return_hash = Hash.new('')

      right_hash = hash.clone
      left_hash  = {}

      old_diff = right_hash.values.reduce(:+)
      move_key_value!(left_hash, right_hash)
      right_summ = right_hash.values.reduce(:+)
      left_summ  = left_hash.values.reduce(:+)

      new_diff = (left_summ - right_summ).abs

      while new_diff < old_diff
        break if right_hash.size == 1
        left_summ, right_summ = left_right_summ(left_hash, right_hash)
        old_diff, new_diff = recalculate_diffs(left_summ, right_summ, new_diff)
        move_key_value!(left_hash, right_hash) if old_diff >= new_diff
      end

      merge_codes!(left_hash, right_hash, return_hash)
      walk_hash!(left_hash, return_hash)
      walk_hash!(right_hash, return_hash)

      return_hash
    end

    def move_key_value!(left_hash, right_hash)
      left_hash[right_hash.keys[0]] = right_hash.delete(right_hash.keys[0])
    end

    def left_right_summ(left_hash, right_hash)
      right_summ = right_hash.values[1..-1].reduce(:+)
      left_summ  = left_hash.values.reduce(:+) + right_hash.values[0]

      [left_summ, right_summ]
    end

    def recalculate_diffs(left_summ, right_summ, diff)
      old_diff = diff
      new_diff = (left_summ - right_summ).abs

      [old_diff, new_diff]
    end

    def merge_codes!(left_hash, right_hash, return_hash)
      left_hash.keys.each { |key| return_hash[key] += EasyEncoding.configuration.left_node_symbol }
      right_hash.keys.each { |key| return_hash[key] += EasyEncoding.configuration.right_node_symbol }
    end

    def walk_hash!(hash, return_hash)
      return_hash.merge!(divide_and_encode(hash)) { |_, val1, val2| val1 + val2 } if hash.size != 1
    end
  end
end
