///@category Special Scripts
///@title Strings

///@func string_to_array(string)
///@desc Converts a string to an array
///@param {string} string The string to convert the array to
///@return {Array<String>}
function string_to_array(str)
{
	forceinline
	var i = 1, len = string_length(str), arr = array_create(len, "");
	repeat len arr[i] = string_copy(str, i++, 1);
	return arr;
}
///@func array_to_string(array)
///@desc Converts a array to a string
///@param {Array<string>} array The array to convert the string to
///@return {string}
function array_to_string(arr)
{
	forceinline
	var i = 0, txt = "";
	repeat array_length(arr) txt += arr[i++];
	return txt;
}
///@func string_replace_unicode(string)
///@desc replaces all Unicode escapes in a string with corresponding characters
///@return {string}
function string_replace_unicode(str) {
	forceinline
    var ucode_idx = string_pos_ext("\\u", str, 0);
    while ucode_idx >= 1
	{
        // replace a Unicode escape with its corresponding character
        var hex = string_copy(str, ucode_idx + 2, 4),
			character = chr_from_hex(hex);
        str = string_copy(str, 1, ucode_idx - 1) + character + string_delete(str, 1, ucode_idx + 3);
        // the next Unicode sequence will be after the recently found one
        ucode_idx = string_pos_ext("\\u", str, ucode_idx);
    }
    return str;
}
///@func chr_from_hex(string)
///@dec parses a hexadecimal number to a corresponding character
///@return {string}
function chr_from_hex(str) {
	forceinline
    str = string_upper(str);
    var result = 0, length = string_length(str);
    for (var i = 1; i <= length; i++) {
        var c = string_char_at(str, i), val = string_pos(c, "0123456789ABCDEF")-1;
        result = (result << 4) + val;
    }
    return chr(result);
}
///@func dec_to_hex(decimal, digits)
///@desc Returns a given value as a string of hexadecimal digits.
///Hexadecimal strings can be padded to a minimum length.
///Note: If the given value is negative, it will
///be converted using its two's complement form.
///@param {real} dec integer
///@param {real} len minimum number of digits
///@return {string}
function dec_to_hex(dec, len = 1) 
{
	forceinline
    var hex = "";

    if (dec < 0) {
        len = max(len, ceil(logn(16, 2 * abs(dec))));
    }

    static dig = "0123456789ABCDEF";
    while (len-- || dec) {
        hex = string_char_at(dig, (dec & $F) + 1) + hex;
        dec = dec >> 4;
    }

    return hex;
}
///@func buffer_read_utf8(buffer)
///@desc Reads a utf8 string from a buffer
///@param {Id.Buffer} buffer The buffer to read from
///@return {real}
function buffer_read_utf8(_buffer) { // To help read UTF8 strings
	aggressive_forceinline
	var _value = buffer_read(_buffer, buffer_u8);
	if ((_value & 0xE0) == 0xC0) { //two-byte
		_value  = (_value & 0x1F) <<  6;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F);
	} else if ((_value & 0xF0) == 0xE0) { //three-byte
		_value  = ( _value & 0x0F) << 12;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) <<  6;
		_value +=  buffer_read(_buffer, buffer_u8) & 0x3F;
	} else if ((_value & 0xF8) == 0xF0)  { //four-byte
		_value  = (_value & 0x07) << 18;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) << 12;
		_value += (buffer_read(_buffer, buffer_u8) & 0x3F) <<  6;
		_value +=  buffer_read(_buffer, buffer_u8) & 0x3F;
	}
		
	return _value;	
}
///@func string_lower_buffer(string)
///@desc Lowers a string using the buffer method, this is faster than the built-in string_lower()
///@param {string} string The string to lower the cases of
///@return {string}
//Credits to TabularElf
function string_lower_buffer(_string) {
	aggressive_forceinline
	static _strBuffer = buffer_create(1024, buffer_grow, 1);
	
	// Exit early
	var _len = string_byte_length(_string)
	if (_len == 0) return _string;
	
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	buffer_write(_strBuffer, buffer_text, _string);
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	repeat(_len) {
		var _value = buffer_read_utf8(_strBuffer);
		if (_value >= 0x41) && (_value <= 0x5A) {
			buffer_seek(_strBuffer, buffer_seek_relative, -1);
			buffer_write(_strBuffer, buffer_u8, _value + 32);
		}
	}
	
	buffer_write(_strBuffer, buffer_u8, 0); // NULL byte, so we can read back what we've changed.
	buffer_seek(_strBuffer, buffer_seek_start, 0);
	return buffer_read(_strBuffer, buffer_text);
}