#!/usr/bin/perl
use DBI;
use strict;
use warnings;


## ._____________________________________________________________________________________________.
## |                                                                                             |
#   This script was hacked together from random crap found on the interwebs by NoTerminal.
#   Most of the configuration work can be done in this box. You also will need to create a 
#   backup user in your mysql database and give her appropriate permissions. The backup user
#   will need select, reload, show_db, and lock_tables
#
my $destDir=$ARGV[1];       # path to backup files
my $localServerName=$ARGV[0];       # the name of the server that this script is running on
my $user=$ARGV[2];                # mysql user with permissions to dump the database
my $p=$ARGV[3];                   # password for mysql user
my $exitStatus = 0;
#
#
#
## |                                                                                             |
## ._____________________________________________________________________________________________.

if ($#ARGV == -1)
{
        print "\n","usage: dbbackup.pl [local server name] [destination dir] [mysql user] [mysql pass]\n\n";
        $exitStatus=1;
}
else
{

my $dbh = DBI->connect('dbi:mysql:information_schema:localhost:3306', $user, $p)or die;

my $databases = $dbh->selectcol_arrayref('show databases') or die;

foreach my $dbName (@$databases)
{
        if (($dbName ne "performance_schema") && ($dbName ne "information_schema") && ($dbName ne "mysql"))
        {
                `mysqldump -u $user -p$p $dbName > $destDir/$dbName.sql`;
                $exitStatus=$exitStatus + ${^CHILD_ERROR_NATIVE};  #this variable stores the exit result of the backtick'd command
                print "archiving ", $dbName, "\n";
        }
}
print "done!\n";

}

exit($exitStatus);
