Class Net::DNS::Resolver::ArgumentError
Class Net::DNS::Resolver::DnsTimeout
Class Net::DNS::Resolver::Error
Class Net::DNS::Resolver::NoResponseError
Class Net::DNS::Resolver::TcpTimeout
Class Net::DNS::Resolver::UdpTimeout



res = Net::DNS::Resolver.new(:nameservers => "172.16.1.1",
                               :recursive => false,
                               :retry => 10)




packet = res.query("www.google.com")

puts packet
