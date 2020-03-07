require_relative "../../lib/b32"
require "minitest/autorun"

describe 'B32' do
  describe ".encode with no arguments" do
    it "returns an argument error" do
      assert_raises ArgumentError do
        B32.encode
      end
    end
  end

  describe ".encode32 given a non-string" do
    it "returns a type error" do
      assert_raises TypeError do
        B32.encode(-1)
      end
    end
  end

  describe ".encode32 given a string" do
    it "returns the base32 of the string" do
      str = "hello world! 平仮名"
      result = B32.encode(str)
      assert_equal 'NBSWY3DPEB3W64TMMQQSBZNZWPSLXLXFSCGQ====', result
    end

    it "returns the base32 of the string" do
      str = "\x98\xEF\r^\xCA\xE1)\xAA\x95>9\xB6?\x9E\x81,a\x00D_U\x8B&W\xC0"
      result = B32.encode(str)
      assert_equal "TDXQ2XWK4EU2VFJ6HG3D7HUBFRQQARC7KWFSMV6A", result
    end
  end

  describe ".decode32 given an encoded string" do
    it "returns the decoded string" do
      str = "hello world! 平仮名"
      encoded = B32.encode(str)
      assert_equal str, B32.decode(encoded)
    end

    it "returns the decoded string" do
      str = "\x98\xEF\r^\xCA\xE1)\xAA\x95>9\xB6?\x9E\x81,a\x00D_U\x8B&W\xC0"
      encoded = B32.encode(str)
      assert_equal str, B32.decode(encoded)
    end

    it "returns the decoded string" do
      str = 'TDWTRGT6GVWCV7GRWFNI45S53PGOJBKNUE======'
      result = B32.decode(str)
      message = ['98ED389A7E356C2AFCD1B15A8E765DDBCCE4854DA1'].pack('H*')
      assert_equal message, result
    end
  end
end
