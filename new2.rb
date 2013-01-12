class Net::DNS
res = Net::DNS::Resolver.new(:nameservers => "129.71.1.1",
                               :recursive => false,
                               :retry => 10);
my $query = $res.search("host.example.com");

print $rr
