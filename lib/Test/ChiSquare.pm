package Test::ChiSquare;

our $VERSION = '0.01';

use strict;
use warnings;
use base qw/Test::Builder::Module/;

use Statistics::Distributions;
use Test::More;

our @EXPORT = qw/chisquare_ok/;

sub chisquare_ok {
    my ($data, $p, $description) = @_;

    my $builder = __PACKAGE__->builder();
    return $builder->ok( judgement_chisquare($data, $p), $description);
}

sub judgement_chisquare {
    my ($data, $p) = @_;

    my $chisquare = chisquare_from_data($data);

    my $observed_count = scalar @{$data};
    my $k = get_degrees_freedom($observed_count);
    my $chisquare_distribution = Statistics::Distributions::chisqrdistr($k, $p);

    return ($chisquare < $chisquare_distribution);
}

sub get_degrees_freedom {
    my $observed_count = shift;
    return $observed_count - 1;
}

sub chisquare_from_data {
    my ($data) = @_;
    
    my $chisquare = 0;
    for my $values (@{$data}) {
        $chisquare += chisquare($values->[0], $values->[1]);
    }

    return $chisquare;
}


sub chisquare {
    my ($observed, $expected) = @_;
    return (($observed - $expected) ** 2) / $expected
}


1;
__END__

=head1 NAME

Test::ChiSquare -

=head1 SYNOPSIS

  use Test::ChiSquare;

=head1 DESCRIPTION

Test::ChiSquare is

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
