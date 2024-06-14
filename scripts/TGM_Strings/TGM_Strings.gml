
/// Feather ignore all

/// @desc Converts all string characters to a character. Useful for passwords.
/// @param {string} str Text string.
/// @param {string} char The character to convert.
/// @returns {string} 
function string_password(str, char="*") {
	return string_repeat(char, string_length(str));
}

/// @desc Adds some zeros to the string.
/// @param {string} str Text string.
/// @param {real} zero_amount The amount of zeros to be added.
/// @returns {string} 
function string_zeros(str, zero_amount) {
	return string_replace_all(string_format(str, zero_amount, 0), " ", "0");
}

/// @desc Add an ellipsis to the string if it is longer than the given width.
/// @param {string} str Text string.
/// @param {real} width The maximum text width.
/// @returns {string} 
function string_limit(str, width) {
	var _len = width / string_width("M");
	return string_width(str) < width ? str : string_copy(str, 1, _len) + "...";
}

/// @desc Add an ellipsis to the string if it is longer than the given width, for non-monospace fonts.
/// @param {string} str Text string.
/// @param {real} width The maximum text width.
/// @returns {string} 
function string_limit_nonmono(str, width) {
	if (string_width(str) < width) return str;
	var _str = "", _char = "",
	i = 1, isize = string_length(str), _ww = 0;
	repeat(isize) {
		_char = string_char_at(str, i);
		_ww += string_width(_char);
		if (_ww < width) _str += _char;
		++i;
	}
	return _str + "...";
}

/// @desc Leave each character in the string with random case.
/// @param {string} str Text string.
/// @param {bool} first_is_upper Is the first letter uppercase?
/// @param {real} sequence Sequence in which the letters will be changed.
/// @param {bool} skip_char Define if will skip a character.
/// @param {string} char The character to skip.
/// @returns {string} 
function string_random_letter_case(str, first_is_upper=true, sequence=1, skip_char=true, char=" ") {
	var _str_final = "", _f1 = undefined, _f2 = undefined;
	if (first_is_upper) {
		_f1 = string_lower;
		_f2 = string_upper;
	} else {
		_f1 = string_upper;
		_f2 = string_lower;
	}
	var i = 1, isize = string_length(str), _index = 1;
	repeat(isize) {
		var _char = string_char_at(str, i);
		_str_final += (_index % (sequence+1) == 0) ? _f1(_char) : _f2(_char);
		if (!skip_char || _char != char) _index++;
		++i;
	}
	return _str_final;
}

/// @desc Capitalize the first letter of the string
/// @param {string} str Text string.
/// @returns {string} 
function string_first_letter_upper_case(str) {
	var _string = string_lower(str),
	_str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(_string, i);
		_str_final += (i == 1) ? string_upper(_char) : _char;
		++i;
	}
	return _str_final;
}

/// @desc Capitalizes each word in the string.
/// @param {string} str Text string.
/// @returns {string} 
function string_word_first_letter_upper_case(str) {
	var _string = string_lower(str),
	_str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(_string, i);
		var _pchar = string_char_at(_string, i-1);
		_str_final += (_pchar == " " || i == 1) ? string_upper(_char) : _char;
		++i;
	}
	return _str_final;
}

/// @desc Uppercase letters become lowercase and vice-versa.
/// @param {string} str Text string.
/// @returns {string} 
function string_case_reverse(str) {
	var _str_final = "",
	i = 1, isize = string_length(str);
	repeat(isize) {
		var _char = string_char_at(str, i),
		_char_upper = string_upper(_char),
		_char_lower = string_lower(_char);
		_str_final += (_char == _char_upper) ? _char_lower : _char_upper;
		++i;
	}
	return _str_final;
}

/// @desc Put string characters in reverse order.
/// @param {string} str Text string.
/// @returns {string} 
function string_reverse(str) {
	var n = string_byte_length(str);
	var b1 = buffer_create(1024, buffer_grow, 1);
	var b2 = buffer_create(1024, buffer_grow, 1);
	if (buffer_get_size(b1) <= n) {
	    buffer_resize(b1, n + 1);
	    buffer_resize(b2, n + 1);
	}
	//
	buffer_seek(b1, buffer_seek_start, 0);
	buffer_write(b1, buffer_text, str);
	buffer_seek(b1, buffer_seek_start, 0);
	var i = n;
	while (buffer_tell(b1) < n) {
	    var c = buffer_read(b1, buffer_u8), k;
	    if (c < $80) {
	        buffer_poke(b2, --i, buffer_u8, c);
	    } else if (c < $E0) {
	        c |= buffer_read(b1, buffer_u8) << 8;
	        i -= 2; buffer_poke(b2, i, buffer_u16, c);
	    } else if (c < $F0) {
	        k = buffer_read(b1, buffer_u16);
	        i -= 3;
	        buffer_poke(b2, i + 1, buffer_u16, k);
	        buffer_poke(b2, i, buffer_u8, c);
	    } else {
	        buffer_seek(b1, buffer_seek_relative, -1);
	        c = buffer_read(b1, buffer_u32);
	        i -= 4;
	        buffer_poke(b2, i, buffer_u32, c);
	    }
	}
	buffer_poke(b1, n, buffer_u8, 0);
	buffer_seek(b2, buffer_seek_start, 0);
	return buffer_read(b2, buffer_string);
}