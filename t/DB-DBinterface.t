# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl DB-DBinterface.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 10 };
use DB::DBinterface;

sub prin
{
	my $text = shift;
	print STDERR $text;
}

prin("\n\n====================================\n!! Following test need a database !!\n====================================\n");
prin("do you want to continue (if you don't have database accessible now you'd better to skip this test) (y/n) : ");
my $rep = <STDIN>;
if($rep =~ /^y/)
{
	prin("\n\nYou must have create, update, alter and select rights on the database !\n\n");
	prin("Please fill the following informations :\nDATABASE HOST : ");
	my $dbhost = <STDIN>;
	chomp $dbhost;
	prin("DATABASE USER : ");
	my $dbuser = <STDIN>;
	chomp $dbuser;
	prin("DATABASE PASSWORD : ");
	my $dbpwd = <STDIN>;
	chomp $dbpwd;
	prin("DATABASE NAME : ");
	my $db = <STDIN>;
	chomp $db;
	prin("DATABASE DBI DRIVER : ");
	my $dbi = <STDIN>;
	chomp $dbi;
	my $dbo= DB::DBinterface->new_h(
		DBHOST => $dbhost,
		DBUSER=> $dbuser,
		DBPASSWORD => $dbpwd,
		DATABASE => $db,
		DBTYPE => $dbi
	);
	ok(defined $dbo);
	my $type = ref $dbo;
	ok($type eq 'DB::DBinterface');
	ok($dbo->DBupdate("CREATE TABLE test_db_dbinterface (id tinyint, name varchar(100))"));
	ok(my ($enc_text) = $dbo->DBencode('ip-wm',"test DB::DBinterface"));
	ok($dbo->DBupdate("INSERT INTO test_db_dbinterface VALUES(1,'$enc_text')"));
	ok(my @results = $dbo->DBselect("SELECT * FROM test_db_dbinterface"));
	ok($results[0]->{name} eq 'test DB__ddot____ddot__DBinterface');
	ok(my ($dec_text) = $dbo->DBdecode('ip-wm',$results[0]->{name}));
	ok($dec_text eq 'test DB::DBinterface');
	ok($dbo->DBupdate("DROP TABLE test_db_dbinterface"));
}
else
{
	for(my $k=0;$k<10;$k++)
	{
		ok(1);
	}
}


#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.