use inc::Module::Install;
name 'Test-ChiSquare';
all_from 'lib/Test/ChiSquare.pm';

requires 'Statistics::Distributions';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
