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
        B32.encode -1
      end
    end
  end

  describe ".encode32 given a string" do
    it "returns the base32 of the string" do
      str = "hello world! 平仮名"
      result = B32.encode(str)
      assert_equal 'NBSWY3DPEB3W64TMMQQSBZNZWPSLXLXFSCGQ====', result
    end
  end

  describe ".decode32 given an encoded string" do
    it "returns the decoded string" do
      str = "hello world! 平仮名"
      encoded = B32.encode(str)
      assert_equal str, B32.decode(encoded)
    end
  end

  describe ".decode32 given an invalid base32 string" do
    it "raises an error" do
      skip("TODO")
      str = "I am not base32 encoded"
      assert_raises B32::DecodeError do
         B32.decode(str)
      end
    end
  end
end
