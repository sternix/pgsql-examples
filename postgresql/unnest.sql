select unnest(string_to_array('Bu bir string ifade',' ')) as words;

words
--------
 Bu
 bir
 string
 ifade