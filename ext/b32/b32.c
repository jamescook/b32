#include <stdlib.h>
#include <ruby.h>
#include <ruby/encoding.h>
#include "base32.h"
#include <ctype.h>


static VALUE m_B32;
static VALUE e_DecodeError;

static VALUE
b32_encode(int argc, VALUE* argv, VALUE self)
{
  VALUE input;
  const unsigned char* src;
  size_t srclen;
  rb_scan_args(argc, argv, "1", &input);

  if (TYPE(input) != T_STRING) {
    rb_raise(rb_eTypeError, "expected a String");
  }

  src = (unsigned char*) StringValuePtr(input);
  srclen = BASE32_LEN(RSTRING_LEN(input));

  unsigned char dest[srclen];
  base32_encode(src, RSTRING_LEN(input), dest);
  return rb_utf8_str_new((const char*) dest, srclen );
}

static VALUE
b32_decode(int argc, VALUE *argv, VALUE self)
{
  VALUE input;
  const unsigned char* src;
  size_t input_len, estimate_len;

  rb_scan_args(argc, argv, "1", &input);

  if (TYPE(input) != T_STRING) {
    rb_raise(rb_eTypeError, "expected a String");
  }

  src = (unsigned char*) StringValuePtr(input);
  input_len = RSTRING_LEN(input);
  estimate_len = UNBASE32_LEN(input_len);
  unsigned char out[estimate_len];

  base32_decode(src, out);

  return rb_utf8_str_new_cstr((const char*) out);
}

void
Init_b32() {
  m_B32 = rb_define_module("B32");
    
  e_DecodeError = rb_define_class_under(m_B32, "DecodeError", rb_eStandardError);
  rb_define_module_function(m_B32, "encode", b32_encode, -1);
  rb_define_module_function(m_B32, "decode", b32_decode, -1);
}
