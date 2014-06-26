#!/usr/bin/perl -pi

# Too many \color directives (generated by DIFdel/addbegin/end)
# confuse xetex, producing errors:
# WARNING ** Color stack overflow. Just ignore.
# and resulting in corrupted color in output.
# As a work-around, detect cases where it's safe, and replace \color with
# \textcolor.
# As a result, number of \color directives goes does sufficiently
# enough to avoid the overflow error.

s/\\DIFdelbegin \\DIFdel{([^}]*)}\\DIFdelend/\\DIFdeltext{$1}/;
s/\\DIFaddbegin \\DIFadd{([^}]*)}\\DIFaddend/\\DIFaddtext{$1}/;

# external \color does not seem to apply to footnotes.
# detect and replace with \color within footnotes

if (m/\\DIFaddbegin/) {
	$diffadd=1;
}
if (m/\\DIFaddend/) {
	$diffadd=0;
}
if (m/\\DIFdelbegin/) {
	$diffdel=1;
}
if (m/\\DIFdelend/) {
	$diffdel=0;
}

if ($diffadd) {
s/(\\footnote\s*{)/$1\\DIFaddbegin{}/;
}

if ($diffdel) {
s/(\\footnote\s*{)/$1\\DIFdelbegin{}/;
}