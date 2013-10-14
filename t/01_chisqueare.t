use Test::More;
use Test::ChiSquare;
use Statistics::Distributions;


subtest 'chisquare' => sub {
    is Test::ChiSquare::chisquare( 50, 50 ), 0, 'perfect match';
    is Test::ChiSquare::chisquare( 50, 40 ), 2.5;
};

subtest 'chisquare_from_data' => sub {
    is Test::ChiSquare::chisquare_from_data( [ [ 15, 15 ], [ 30, 30 ], [ 55, 55 ] ] ), 0, 'perfect match';
    my $chisquare = Test::ChiSquare::chisquare_from_data( [ [ 15, 13 ], [ 30, 35 ], [ 55, 52 ] ] );
    ok( $chisquare > 1.195 && $chisquare < 1.196 ), 'nearly 1.19505494505495';
};

subtest 'judgement_chisquare' => sub {
    ok(Test::ChiSquare::judgement_chisquare( [ [ 50, 50 ], [ 50, 50 ] ], 0.05), 'ok' );
    ok(Test::ChiSquare::judgement_chisquare( [ [ 50, 45 ], [ 50, 55 ] ], 0.05), 'ok' );
    ok(! Test::ChiSquare::judgement_chisquare( [ [ 50, 40 ], [ 50, 60 ] ], 0.05), 'not ok' );

    ok(Test::ChiSquare::judgement_chisquare( [ [ 15, 13 ], [ 30, 35 ], [ 35, 34 ], [ 20, 18 ] ], 0.05), 'ok' );
    ok(! Test::ChiSquare::judgement_chisquare( [ [ 15, 18 ], [ 30, 40 ], [ 35, 29 ], [ 20, 13 ] ], 0.05), 'not ok' );
};

subtest 'chisquare_ok' => sub {
    chisquare_ok( [ [ 50, 50 ], [ 50, 50 ] ], 0.05, 'ok' );
    chisquare_ok( [ [ 50, 45 ], [ 50, 55 ] ], 0.05, 'ok' );

    chisquare_ok( [ [ 15, 13 ], [ 30, 35 ], [ 35, 34 ], [ 20, 18 ] ], 0.05, 'ok' );
};

done_testing();

