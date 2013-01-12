use Net::DNS;

my $res = Net::DNS::Resolver(:nameservers => "129.71.1.1",
                              :recursive => false,
                              :retry => 10)
my $query = $res.search("update.symantec.com");

print address
