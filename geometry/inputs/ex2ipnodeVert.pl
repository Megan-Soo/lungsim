#!/usr/bin/perl

# This function reads a exnode file and converts it to an ipnode file.
# This is problem specific in that basis function will be set to 1 and
# this is a 1D basis function.

use strict;

my ($line, $filename, $exnodefile, $ipnodefile);
my ($COUNT, $group, $NumberofNodes, $node);
my ($coord, $nj, $i, $nderiv, $nversn, $nv, $xyz);
my ($deriv, $deriv1, $deriv2, $deriv12, $deriv3, $deriv13, $deriv23, $deriv123);

$filename = $ARGV[0];
$exnodefile = "$filename.exnode";
$ipnodefile = "$filename.ipnode";
my $offset; # = $ARGV[1];
my $nocross = 0; #the default is to write out cross-derivative values

for my $N (0..@ARGV-1)
{
    if($ARGV[$N] =~ /nocross/) {$nocross = 1;}
    if($ARGV[$N] =~ /-o/) {$offset = $ARGV[$N+1];}
}

### Open exnode file ###
open EXNODE, "<$exnodefile" or die "\033[31mError: Can't open exnode file\033[0m ";

# Reading "Group name"
$line= <EXNODE>;
if ($line =~ / Group name:/){
  $line=~/\s*Group name:\s*(\w*)\s*/i;
  $group=$1;
}else{
  die "\033[31mError: \"Group name\" not found in exnode header\033[0m ";
}
print "Group name: $group\n";

$NumberofNodes=0;
$line = <EXNODE>;
while ($line) {
    if ($line =~ /Derivatives=(\S*)/) {
	$deriv = $1;
	if($deriv > $nderiv) {$nderiv = $deriv};
    }

    if ($line =~ /\s*Node:\s*(\S*)/) {
	$NumberofNodes=$NumberofNodes+1; 
    }
    $line=<EXNODE>;    
}
print "Total number of nodes = $NumberofNodes\n";

close EXNODE;

$nj=3; #specific for 3 coordinates

#print "Enter basis function number:";
#$nb=1; #basis function=1
#$nb = <STDIN>;
#print "nj $nj \n";

### Exporting to ipnode ## 
### Open ipnode file
open IPNODE, ">$ipnodefile" or die "\033[31mError: Can't open ipnode file\033[0m ";
### Open exnode file ###
open EXNODE, "<$exnodefile" or die "\033[31mError: Can't open exnode file\033[0m ";

### Write ipnode header
print IPNODE " CMISS Version 1.21 ipnode File Version 2\n";
print IPNODE " Heading: $group\n\n";
printf IPNODE " The number of nodes is [%5d]: %5d\n",$NumberofNodes,$NumberofNodes;
printf IPNODE " Number of coordinates [%2d]: %2d\n",$nj,$nj;
for ($i=1;$i<=$nj;$i++){
  print IPNODE " Do you want prompting for different versions of nj=$i [N]? Y\n";
}
for ($i=1;$i<=$nj;$i++){
  print IPNODE " The number of derivatives for coordinate $i is [0]: $nderiv \n";
}

### Loop over nodes
### Read exnode data
#$NumberofNodes=0;
#$COUNT=2600; #Node number you want to start with
$COUNT=0;

$nversn = 1;
$line = <EXNODE>;
while ($line) {

    if ($line =~ /Versions=(\S*)/){
	$nversn=$1;
	}
    if ($line =~ /\s*Node:\s*(\S*)/) {
	#$NumberofNodes=$NumberofNodes+1;
	$COUNT=$COUNT+1;
	print IPNODE "\n";
	$node = $1 - $offset;
	printf IPNODE " Node number [%5d]: %5d\n",$node,$node;
	for ($i=1;$i<=$nj;$i++){
	    printf IPNODE " The number of versions for nj=$i is [1]:  $nversn \n";
	    for ($nv = 1; $nv <=$nversn; $nv++){
		if($nversn > 1){
		    printf IPNODE " For version number $nv: \n";
		}
		$coord = <EXNODE>;
		if($nderiv == 0){
		    if($coord =~/\s+(\S+.\S+E\+\S+)\s+/){
			$xyz = $1;
		    }elsif($coord =~ /\s+(\S+.\S+e\+\S+)\s+/){
			$xyz = $1;
		    }elsif($coord =~ /\s+(\S*)/){
			$xyz = $1;
		    }
		}
                if($nocross == 1){
		    $deriv12 = 0;
		    $deriv13 = 0;
		    $deriv23 = 0;
		    $deriv123 = 0;
		}
		printf IPNODE " The Xj(%1d) coordinate is [ 0.00000E+00]: $xyz \n",$i;
		if($nderiv == 1){
		    printf IPNODE " The derivative wrt direction 1 is [ 0.00000E+00]:      $deriv1 \n";
		}
	    }
	}
    }
    $line = <EXNODE>;    
}
### End Loop over nodes

### Close files
close IPNODE;
close EXNODE;


