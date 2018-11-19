#!/usr/bin/perl

##########################################
# FileName: matrixAdjacentValues.pl
# Description: Generate matrix Adjacent Values
#
# CreatedBy: Kiran Babu Chinnam on 20-11-2018
# ModifiedBy: Kiran Babu Chinnam on 20-11-2018
##########################################

use strict;
use warnings;
use POSIX;
use Data::Dumper;

print "enter value for M:";
chomp(my $m = <>);
print "enter value for N:";
chomp(my $n = <>);

my $num = $m*$n;

if($m < 1 || $n < 1 || $m > 100 || $n >100){
	
	print "value of m and n should be between 1 and 100.\n";
	exit(2);
}

#########################################
# M x N Matrix assignment  
#########################################
my @mat;
my %mhash;
my $i = 0;
my $key = 0;
for my $v (0..$num){
	
	$i++;
	push @mat,floor(rand($num));
	
	if($i == $n){
		push @{$mhash{$key}},@mat;
		@mat = ();
		$i = 0;
		$key++;
	}
}

#########################################
# print M x N Matrix 
#########################################
print "\nThe base Matrix is:\n";
print "[  ", join "  ",@{$mhash{$_}}, "]\n" for (sort {$a <=> $b} keys %mhash);


#########################################
# Prompt user for value to print adjacent elements 
#########################################
print "\nenter the number for adjucent elements:";
chomp(my $ad = <>);

if($ad > $num-1 || $ad < 0){

	print "Value for Adjucents is out of Range.\n";
	exit(1);
}


#########################################
# Find and print adjacent elements 
#########################################
my @output;

for my $row (sort {$a <=> $b} keys %mhash){
		
	my @inn = @{$mhash{$row}};
	my $col = 0;
	
	for my $val (@inn){

		if($val == $ad){
		
			if($row-1 != -1){
			
				#fetch previous row's adjacent elements, if any
				push @output,$mhash{$row-1}->[$col-1] if($col-1 != -1);
				push @output,$mhash{$row-1}->[$col];
				push @output,$mhash{$row-1}->[$col+1] if($col+1 < $n);

			}
			
			#fetch current row's adjacent elements, if any
			push @output,$inn[$col-1] if($col-1) != -1;
			push @output,$inn[$col+1] if($col+1) < $n;
			
			if($row+1 < $m){

				#fetch next row's adjacent elements, if any
				push @output,$mhash{$row+1}->[$col-1] if($col-1 != -1);
				push @output,$mhash{$row+1}->[$col];
				push @output,$mhash{$row+1}->[$col+1] if($col+1 < $n);
			}
			
			print "\nAdjucent elements are:\t",join " ", @output,"\n"; 
			exit(0);
		}
		$col++;
	}
}