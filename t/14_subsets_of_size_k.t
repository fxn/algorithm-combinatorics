use strict;
use warnings;

use FindBin qw($Bin);
use lib $Bin;

use Test::More qw(no_plan);

use Algorithm::Combinatorics qw(subsets);
use Tester;

my $tester = Tester->__new(\&subsets);

my (@result, @expected);

# ---------------------------------------------------------------------

eval { subsets() };
ok($@, '');

eval { subsets(1) };
ok($@, '');

# ---------------------------------------------------------------------

@expected = ([]);
$tester->__test(\@expected, [], 0);

@expected = ([]);
$tester->__test(\@expected, [1, 2], 0);

# ---------------------------------------------------------------------

@expected = (["foo"]);
$tester->__test(\@expected, ["foo"], 1);

# ---------------------------------------------------------------------

@expected = (["foo"], ["bar"]);
$tester->__test(\@expected, ["foo", "bar"], 1);

# ---------------------------------------------------------------------

@expected = (["foo", "bar"]);
$tester->__test(\@expected, ["foo", "bar"], 2);

# ---------------------------------------------------------------------

@expected = (
    ["foo", "bar"],
    ["foo", "baz"],
    ["bar", "baz"],
);
$tester->__test(\@expected, ["foo", "bar", "baz"], 2);

# ---------------------------------------------------------------------

@expected = (
    ["foo", "bar", "baz"],
    ["foo", "bar", "zoo"],
    ["foo", "baz", "zoo"],
    ["bar", "baz", "zoo"],
);
$tester->__test(\@expected, ["foo", "bar", "baz", "zoo"], 3);

# ----------------------------------------------------------------------

@expected = (
    [1, 2, 3],
    [1, 2, 4],
    [1, 2, 5],
    [1, 3, 4],
    [1, 3, 5],
    [1, 4, 5],
    [2, 3, 4],
    [2, 3, 5],
    [2, 4, 5],
    [3, 4, 5],
);
$tester->__test(\@expected, [1..5], 3);

# ----------------------------------------------------------------------

my $nsubsets = 0;
my $iter = subsets([1..20], 15);
while (my $c = $iter->next) {
    ++$nsubsets;
}
is($nsubsets, 15504, "");
