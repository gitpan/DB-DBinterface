package DB::DBinterface;

use 5.006001;
use strict;
use warnings;
use DBI;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use DB::DBinterface ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	DBencode DBdecode
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.95';

sub new
{
	shift ;
	my @arg= @_ ;
	#print join ' !! ',@arg,"\n" ;
        my $self= {};
	$self->{'DBHOST'} = '127.0.0.1' ;
        $self->{'DBUSER'}= undef;
        $self->{'DBPASSWORD'} = undef;
        $self->{'DATABASE'} = undef;
        $self->{'LAST_ERROR'} = undef;
        $self->{'DBTYPE'} = 'mysql';
	$self->{'AutoExit'} = 1 ;
	for (my $k=0;$k<=$#arg;$k=$k+2)
	{
		#print "\$arg[$k] : $arg[$k]\n\$arg[$k+1] : $arg[$k+1]\n";
		$self->{"$arg[$k]"} = $arg[$k+1];
	}
	unless (defined($self->{'LAST_ERROR'})){$self->{'LAST_ERROR'} = 'undef' ;}
	bless $self;
	if (defined($self->{'DBHOST'}) && defined($self->{'DBUSER'}) && defined($self->{'DBPASSWORD'}))
	{
		return $self;
	}
	else
	{
		print STDERR "[ DB::DBinterface ] parameters undefined (DBHOST or DBUSER or DBPASSWORD)\n";
		return undef; 
	}
}

sub new_h
{
	my $class = shift ;
	my @arg= @_ ;
	#print join ' !! ',@arg,"\n" ;
        my $self= {};
	$self->{'DBHOST'} = '127.0.0.1' ;
        $self->{'DBUSER'}= undef;
        $self->{'DBPASSWORD'} = undef;
        $self->{'DATABASE'} = undef;
        $self->{'LAST_ERROR'} = undef;
        $self->{'DBTYPE'} = 'mysql';
	$self->{'AutoExit'} = 1 ;
	for (my $k=0;$k<=$#arg;$k=$k+2)
	{
		#print "\$arg[$k] : $arg[$k]\n\$arg[$k+1] : $arg[$k+1]\n";
		$self->{"$arg[$k]"} = $arg[$k+1];
	}
	unless (defined($self->{'LAST_ERROR'})){$self->{'LAST_ERROR'} = 'undef' ;}
	bless($self,$class);
	if (defined($self->{'DBHOST'}) && defined($self->{'DBUSER'}) && defined($self->{'DBPASSWORD'}))
	{
		return $self;
	}
	else
	{
		print STDERR "[ DB::DBinterface ] parameters undefined (DBHOST or DBUSER or DBPASSWORD)\n";
		return undef; 
	}
}
sub DBencode
{
	shift;
	my ($charset, @text) = @_ ;
	if ($charset eq 'ip-wm' or $charset eq 'ip-wm-fr')
	{
		for(my $k=0; $k<=$#text; $k++)
                {
                        #$text[$k]=~ s//____/g;
			$text[$k]=~ s/'/__qt__/g;
			$text[$k]=~ s/;/__pv__/g;
			$text[$k]=~ s/`/__bks__/g;
			$text[$k]=~ s/"/__guill__/g;
			$text[$k]=~ s/\./__dot__/g;
                        $text[$k]=~ s/,/__vir__/g;
                        $text[$k]=~ s/:/__ddot__/g;
                        $text[$k]=~ s/</__lt__/g;
                        $text[$k]=~ s/>/__gt__/g;
                        $text[$k]=~ s/=/__eq__/g;
                        $text[$k]=~ s/\n/__nl__/g;
                        $text[$k]=~ s/\t/__tab__/g;
                        $text[$k]=~ s/\r/__cr__/g;
                        $text[$k]=~ s/\|/__pipe__/g;
                        $text[$k]=~ s/&/__ec__/g;
                        $text[$k]=~ s/!/__pe__/g;
                        $text[$k]=~ s/\?/__pi__/g;
                        $text[$k]=~ s/\+/__pl__/g;
                        $text[$k]=~ s/-/__mn__/g;
                        $text[$k]=~ s/\*/__mul__/g;
                        $text[$k]=~ s/\//__sl__/g;
                        $text[$k]=~ s/\\/__bksl__/g;
                        $text[$k]=~ s/\0/__nb__/g;
                        $text[$k]=~ s/@/__aro__/g;
                        $text[$k]=~ s/\$/__dol__/g;
                        $text[$k]=~ s/£/__ls__/g;
                        $text[$k]=~ s/§/_ds__/g;
                        $text[$k]=~ s/%/__prct__/g;
                        $text[$k]=~ s/#/__diese__/g;
                        $text[$k]=~ s/\(/__opar__/g;
                        $text[$k]=~ s/\)/__fpar__/g;
                        $text[$k]=~ s/\[/__ocr__/g;
                        $text[$k]=~ s/\]/__fcr__/g;
                        $text[$k]=~ s/\{/__oac__/g;
                        $text[$k]=~ s/\}/__fac__/g;
                        $text[$k]=~ s/°/__de__/g;
                }
	}
        if ($charset eq 'ip-wm-fr')
        {
		for(my $k=0; $k<=$#text; $k++)
                {
			$text[$k]=~ s/é/__eaig__/g;
			$text[$k]=~ s/è/__egr__/g;
                	$text[$k]=~ s/à/__agr__/g;
                	$text[$k]=~ s/â/__acir__/g;
                	$text[$k]=~ s/ä/__atr__/g;
                	$text[$k]=~ s/ê/__ecir__/g;
                	$text[$k]=~ s/ë/__etr__/g;
                	$text[$k]=~ s/î/__icr___/g;
                	$text[$k]=~ s/ï/__itr___/g;
                	$text[$k]=~ s/ô/__ocir__/g;
                	$text[$k]=~ s/ö/__otr__/g;
                	$text[$k]=~ s/ù/__ugr__/g;
                	$text[$k]=~ s/û/__ucir__/g;
                	$text[$k]=~ s/ü/__utr__/g;
                	$text[$k]=~ s/ÿ/__ytr__/g;
                	$text[$k]=~ s/ç/__ccd__/g;
                	#$text[$k]=~ s//____/g;
		}
	}
	return @text ;
}

sub DBdecode
{
	shift;
	my ($charset,@text) = @_ ;
	if ($charset eq 'ip-wm' or $charset eq 'ip-wm-fr')
        {
                for(my $k=0; $k<=$#text; $k++)
                {
                        #$text[$k]=~ s//____/g;
                        $text[$k]=~ s/__qt__/'/g;
                        $text[$k]=~ s/__pv__/;/g;
                        $text[$k]=~ s/__bks__/`/g;
                        $text[$k]=~ s/__guill__/"/g;
                        $text[$k]=~ s/__dot__/\./g;
                        $text[$k]=~ s/__vir__/,/g;
                        $text[$k]=~ s/__ddot__/:/g;
                        $text[$k]=~ s/__lt__/</g;
                        $text[$k]=~ s/__gt__/>/g;
                        $text[$k]=~ s/__eq__/=/g;
                        $text[$k]=~ s/__nl__/\n/g;
                        $text[$k]=~ s/__tab__/\t/g;
                        $text[$k]=~ s/__cr__/\r/g;
                        $text[$k]=~ s/__pipe__/\|/g;
                        $text[$k]=~ s/__ec__/&/g;
                        $text[$k]=~ s/__pe__/!/g;
                        $text[$k]=~ s/__pi__/\?/g;
                        $text[$k]=~ s/__pl__/\+/g;
                        $text[$k]=~ s/__mn__/-/g;
                        $text[$k]=~ s/__mul__/\*/g;
                        $text[$k]=~ s/__sl__/\//g; #/
                        $text[$k]=~ s/__bksl__/\\/g;
                        $text[$k]=~ s/__nb__/\0/g;
                        $text[$k]=~ s/__aro__/@/g;
                        $text[$k]=~ s/__dol__/\$/g;
                        $text[$k]=~ s/__ls__/£/g;
                        $text[$k]=~ s/__ds__/§/g;
                        $text[$k]=~ s/__prct__/%/g;
                        $text[$k]=~ s/__diese__/#/g;
                        $text[$k]=~ s/__opar__/\(/g;
                        $text[$k]=~ s/__fpar__/\)/g;
                        $text[$k]=~ s/__ocr__/\[/g;
                        $text[$k]=~ s/__fcr__/\]/g;
                        $text[$k]=~ s/__oac__/\{/g;
                        $text[$k]=~ s/__fac__/\}/g;
                        $text[$k]=~ s/__de__/°/g;
                }
        }
	if ($charset eq 'ip-wm-fr')
        {
                for(my $k=0; $k<=$#text; $k++)
                {
                        $text[$k]=~ s/__eaig__/é/g;
                        $text[$k]=~ s/__egr__/è/g;
                        $text[$k]=~ s/__agr__/à/g;
                        $text[$k]=~ s/__acir__/â/g;
                        $text[$k]=~ s/__atr__/ä/g;
                        $text[$k]=~ s/__ecir__/ê/g;
                        $text[$k]=~ s/__etr__/ë/g;
                        $text[$k]=~ s/__icr___/î/g;
                        $text[$k]=~ s/__itr___/ï/g;
                        $text[$k]=~ s/__ocir__/ô/g;
                        $text[$k]=~ s/__otr__/ö/g;
                        $text[$k]=~ s/__ugr__/ù/g;
                        $text[$k]=~ s/__ucir__/û/g;
                        $text[$k]=~ s/__utr__/ü/g;
                        $text[$k]=~ s/__ytr__/ÿ/g;
                        $text[$k]=~ s/__ccd__/ç/g ;
                        #$text[$k]=~ s//____/g;
                }
        }
        return @text ;
}
sub setDBHOST
{
	my $self = shift;
	my $value = shift;
	$self->{'DBHOST'} = $value;
}
sub getDBHOST
{
	my $self = shift;
	return $self->{'DBHOST'};
}
sub setDBUSER
{
	my $self = shift;
	my $value = shift;
	$self->{'DBUSER'} = $value;
}
sub getDBUSER
{
	my $self = shift;
	return $self->{'DBUSER'};
}
sub setDBPASSWORD
{
	my $self = shift;
	my $value = shift;
	$self->{'DBPASSWORD'} = $value;
}
sub getDBPASSWORD
{
	my $self = shift;
	return $self->{'DBPASSWORD'};
}
sub setDATABASE
{
	my $self = shift;
	my $value = shift;
	$self->{'DATABASE'} = $value;
}
sub getDATABASE
{
	my $self = shift;
	return $self->{'DATABASE'};
}
sub setError
{
	my ($self,$err) = @_ ;
	$self->{'LAST_ERROR'} = $err ;
	#print "[ Debug setError ] LAST_ERROR : ",$self->{'LAST_ERROR'},", err : $err\n" ;
	if ($self->{'AutoExit'} == 1)
	{
		$self->error() ;
	}
}

sub error
{
	my $self = shift ;
	unless(defined($self))
	{
		die "[ DB::DBinterface ] Can't catch the last error (maybe new() was not correctly ended ?)\n" ;
	}
	if (defined($self->{'LAST_ERROR'}))
	{
		die $self->{'LAST_ERROR'},"\n";
	}
	return 1 ;
}

sub debugTrace
{
	my $self = shift ;
	print "DBHOST = ",$self->{'DBHOST'},"\n" ;
	print "DBUSER = ",$self->{'DBUSER'},"\n" ;
        print "DBPASSWORD = ",$self->{'DBPASSWORD'},"\n" ;
        print "DATABASE = ",$self->{'DATABASE'},"\n" ;
        print "LAST_ERROR = ",$self->{'LAST_ERROR'},"\n" if (defined($self->{'LAST_ERROR'})) or print "LAST_ERROR= undef\n";
        print "DBTYPE = ",$self->{'DBTYPE'},"\n" ;
}

sub creerTab
{
        my ($ref_st,@tabli)=@_;
        my $tmp=$ref_st;
        @tabli=(@tabli,$tmp);
        return (@tabli);
}

sub testCtrl
{
	my ($ctrl) = shift ;
	if (defined($ctrl))
	{
		return undef ;
	}
	return 1;
}

sub DBselect
{
	my $self = shift ;
        my ($req)=@_;
        my @struct=();
	my $ctrlerr = undef ;
        my $login_db= $self->{'DBUSER'};
        my $password_db=$self->{'DBPASSWORD'};
	my $db = undef ;
	$db = $self->{'DATABASE'} if(defined($self->{'DATABASE'})) ;
        $db = 'mysql' unless(defined($self->{'DATABASE'})) ;
	my $host = $self->{'DBHOST'};
	print "DBI:$self->{'DBTYPE'}:database=$db;host=$host\n";
	my $dbi_driver = $self->{'DBTYPE'};
        my $dbh = DBI->connect("DBI:$dbi_driver:database=$db;host=$host",$login_db, $password_db,{'RaiseError' => 0, AutoCommit => 1}) or $ctrlerr=1;
	if (defined($ctrlerr) && $ctrlerr == 1)
	{
		#print "ERREUR \n";
		$self->setError("[ DB::DBinterface ] can't connect to the database with parameter : DBHOST : $host, DATABASE : $db, DBUSER : $login_db, DBPASSWORD : $password_db\n");
		return undef ;
	}
        my $sth=$dbh->prepare($req) or $ctrlerr=1;
	if (defined($ctrlerr) && $ctrlerr == 1)
        {
                $self->setError("[ DB::DBinterface ] can't prepare the current request : $req\n");
                return undef ;
        }
        $sth->execute() or $ctrlerr=1;
	if (defined($ctrlerr) && $ctrlerr == 1)
        {
                $self->setError("[ DB::DBinterface ] can't execute the SQL request : $req.\n");
                return undef ;
        }
        while (my $ref = $sth->fetchrow_hashref())
        {
                my %str=();
                my %toto=();
                %str = %$ref;
                %toto=%str;
                @struct=creerTab(\%toto,@struct);
        }
        $sth->finish();
        $dbh->disconnect();
        return @struct;
}

sub DBupdate
{
        # iperlGal
	my $self = shift ;
        my ($reqete)=@_;
        my $login_db= $self->{'DBUSER'};
        my $password_db= $self->{'DBPASSWORD'};
	my $db = undef ;
	$db = $self->{'DATABASE'} if(defined($self->{'DATABASE'})) ;
	$db = 'mysql' unless(defined($self->{'DATABASE'})) ; 
        my $host = $self->{'DBHOST'};
        my $dbh = DBI->connect("DBI:$self->{'DBTYPE'}:database=$db;host=$host",$login_db, $password_db,{'RaiseError' => 0, AutoCommit => 1}) or  $self->setError("[ ERREUR ] erreur de connexion base de donnée\n");
        $dbh->do($reqete) or $self->setError("[ ERREUR ] requete SQL : $reqete\n");
        $dbh->disconnect();
}

sub getHashShemaFromTable
{
	my $self = shift ;
        my ($table_name) = @_;
	my @test = $self->DBselect("describe $table_name");
	my %ret_hash = (
		'Field' => '',
		'Type' => ''
		);
	for(my $k=0; $k<= $#test; $k++)
	{
		my $ref = $test[$k] ;
		my %hash = %$ref;
		foreach my $a (keys(%hash))
		{
			$ret_hash{Field} .= "$hash{$a}," if($a=~ /Field/);
			$ret_hash{Type} .= "$hash{$a}," if($a=~ /Type/);
		}
	}
	chop $ret_hash{Field};
	chop $ret_hash{Type};
	return %ret_hash ;
}

sub getRefTabShemaFromTable
{
	my $self = shift ;
        my ($table_name) = @_;
	my @test = $self->DBselect("describe test_back");
	my @ret_tab = ();
	for(my $k=0; $k<= $#test; $k++)
	{
		my $ref = $test[$k] ;
		my %hash = %$ref;
		foreach my $a (keys(%hash))
		{
			$ret_tab[$k]->{Field} = $hash{$a} if($a=~ /Field/);
			$ret_tab[$k]->{Type} = $hash{$a} if($a=~ /Type/);
		}
	}
	return @ret_tab ;
}

sub availableMethods
{
	my $self = shift;
	printf("Available methods for DB::DBinterface are :\n
	new -> constructor when used alone
	new_h -> constructor when used in other class (heritate form)
	setDBHOST(VALUE) -> accessor for setting DBHOST
	getDBHOST -> accessor for getting value of DBHOST
	setDBUSER(VALUE) -> accessor for setting DBUSER
	getDBUSER -> accessor for getting value of DBUSER
	setDBPASSWORD(VALUE) -> accessor for setting DBPASSWORD
	getDBPASSWORD -> accessor for getting value of DBPASSWORD
	setDATABASE(VALUE) -> accessor for setting DBDATABASE
	getDATABASE -> accessor for getting value of DBDATABASE
	debugTrace -> a method wich print debug informations
	DBselect(REQUEST) -> execute the SQL request REQUEST (only for ``SELECT'' request)
	DBupdate(REQUEST) -> execute the SQL request REQUEST (all but ``SELECT'' request)
	getShemaHashFromTable(TABLE) -> execute a ``describe'' SQL request on TABLE and return a hash with to key : Field and Type (values are separated by a coma)
	getRefTabShemaFromTable(TABLE) -> execute a ``describe'' SQL request on TABLE and return a table wich contain ref on hash with 2 keys : Field and Type.
	\n
	");
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

DB::DBinterface - Perl extension for really simply access to database

=head1 SYNOPSIS

  use DB::DBinterface;
  use strict;
  my $dbo = DB::DBinterface(
  	DBUSER => 'user' ,
	DBPASSWORD => 'p4ssw0rd',
        DBHOST => '192.168.0.20',
        DATABASE => 'my_database',
	DBTYPE => 'mysql'
  );
  my @results = $dbo->DBselect("SELECT * FROM users");
  $dbo->DBupdate("CREATE TABLE my_table (id_table tinyint, name_table varchar(200)");
  $dbo->DBupdate("INSERT INTO my_table VALUES(1,'toto')");
  my @results = $dbo->DBselect("SELECT * FROM my_table");
  print "====> Results for my_table <====\n\nID\tTABLE NAME\n---------------\n";
  foreach my $a (@results)
  {
  	print "$a->{id_table}\t$a->{name_table}";
  }
  my @tab = $dbo->getRefTabShemaFromTable('my_table');
  print "Field for 'my_table' : $tab[0]->{Field}\n";
  my %schema = $dbo->getShemaHashFromTable('my_table');
  print "Type for 'my_table' : $schema{Type}\n";
  print 

=head1 DESCRIPTION

DB::DBinterface provide an interface to DBI and DBD::* modules. It used DBI, so you might install it and the corresponding DBD driver if necessary. 

=head1 FUNCTIONS


=item * DBencode(CHARSET,(TEXT|$TEXT|@TEXT)) :

Encode text to escape characters wich can be dangerous in an ``SQL injection'' attack.

Availables CHARSET are :
	
	ip-wm
	
	ip-wm-fr

Return a table containing decoded text.

=item * DBencode(CHARSET,(TEXT|$TEXT|@TEXT)) :

Decode TEXT wich have been encoded with DNencode for CHARSET. Return a table containing decoded text.

You can also use this two functions like methods ($dbo->DBecode('ip-wm',"toto is beautifull ;-)");

=head1 METHODS


=item * new :

 constructor when used alone. Arguments are :
 	DBHOST : IP adress or hostname of the database (default is 127.0.0.1)
	
        DBUSER : A username wich is authoryzed to connect to database (default is undef)
	
        DBPASSWORD : The password associates with DBUSER (default is undef)
	
        DATABASE : the database name (default is undef)
        
	DBTYPE : the DBI driver name (default is 'mysql')

	
=item * new_h :

 constructor when used in other class (heritate form)

=item * setDBHOST(VALUE) :

 accessor for setting DBHOST

=item * getDBHOST :

 accessor for getting value of DBHOST

=item * setDBUSER(VALUE) :

 accessor for setting DBUSER

=item * getDBUSER :

 accessor for getting value of DBUSER

=item * setDBPASSWORD(VALUE) :

 accessor for setting DBPASSWORD

=item * getDBPASSWORD :

 accessor for getting value of DBPASSWORD

=item * setDATABASE(VALUE) :

 accessor for setting DBDATABASE

=item * getDATABASE :

 accessor for getting value of DBDATABASE

=item * debugTrace :

 a method wich print debug informations

=item * DBselect(REQUEST) :

 execute the SQL request REQUEST (only for ``SELECT-like'' request). Returned a table wich contain references on hash table create by a call to the DBI method : fetchrow_hashref()

=item * DBupdate(REQUEST) :

 execute the SQL request REQUEST (all but ``SELECT-like'' request)

=item * getShemaHashFromTable(TABLE) :

 execute a ``describe'' SQL request on TABLE and return a hash with to key : Field and Type (values are separated by a coma)

=item * getRefTabShemaFromTable(TABLE) :

 execute a ``describe'' SQL request on TABLE and return a table wich contain ref on hash with 2 keys : Field and Type.

=head1 AUTHOR

DUPUIS Arnaud, E<lt>a.dupuis@infinityperl.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by DUPUIS Arnaud

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.


=cut
