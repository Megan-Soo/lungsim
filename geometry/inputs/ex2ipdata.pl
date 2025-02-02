#!/usr/bin/perl

# This function reads a exdata file and converts it to an ipdata file.

use strict;

my ($line, $filename, $exdatafile, $ipdatafile);
my ($COUNT);
my (@coord, $nj);

$filename = $ARGV[0];
$exdatafile = "$filename.exdata";
$ipdatafile = "$filename.ipdata";

### Exporting to ipdata ## 
### Open ipdata file
open IPDATA, ">$ipdatafile" or die "\033[31mError: Can't open ipdata file\033[0m ";
### Open exdata file ###
open EXDATA, "<$exdatafile" or die "\033[31mError: Can't open exdata file\033[0m ";

print IPDATA " converted from exdata \n";
$COUNT = 0;
$line = <EXDATA>;
while ($line) {

    if ($line =~ /\s*Node:\s+(\d+)/) {
#	$COUNT=$COUNT+1;
	my $node = $1;
	$line = <EXDATA>;
	chomp $line;
	my @list = split(/ +/,$line);
	my $nlist = scalar(@list);
#        if ($line =~ /\s*(\S+)\s*(\S+)\s*(\S+)/) {
	if($nlist == 4){
	    $coord[0] = $list[1];
	    $coord[1] = $list[2];
	    $coord[2] = $list[3];
	}else{
#	    $coord[0] = chomp $line;
	    $coord[0] = $list[1];
	    $line = <EXDATA>;
	    chomp $line;
	    @list = split(/ +/,$line);
	    $coord[1] = $list[1];
#	    $coord[1] =  $line;
	    $line = <EXDATA>;
	    chomp $line;
	    @list = split(/ +/,$line);
	    $nlist = scalar(@list);
	    $coord[2] = $list[1];
#	    $coord[2] =  $line;

	}

#	for ($nj = 0; $nj < 3; $nj++){
#	    $coord[$nj] = <EXDATA>;
#	    chomp $coord[$nj];
#	}
	print IPDATA " $node $coord[0] $coord[1] $coord[2] 1.0 1.0 1.0 \n";
#	print IPDATA " $COUNT $coord[0] $coord[1] $coord[2] 1.0 1.0 1.0 \n";

#	chomp($line);
#	print IPDATA " $COUNT $line 1.0 1.0 1.0 \n";
    }
    $line = <EXDATA>;    
}
### End Loop over datas

### Close files
close IPDATA;
close EXDATA;


