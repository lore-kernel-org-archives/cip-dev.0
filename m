From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 7 Nov 2017 11:40:06 +0900
Subject: [cip-dev] B@D network setup
In-Reply-To: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
References: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
Message-ID: <008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Daniel Wagner
> Sent: Monday, November 06, 2017 6:50 PM
> To: Robert Marshall
> Cc: cip-dev at lists.cip-project.org
> Subject: [cip-dev] B at D network setup
> 
> Hi Robert,
> 
> Finally I found some time to test/setup the B at D VM. I struggle a bit
> with the network setup. If I understand it correctly, the VM needs to be
> bridged to the main network:
> 
>   # Forward port 8888 for the internal REST server
>   config.vm.network :forwarded_port, guest: 8888, host: 8888
>   # Forward port 8010 for the Storage Server
>   config.vm.network :forwarded_port, guest: 8010, host: 8010
>   # Forward port 5000 for the KernelCI Frontend Web Server
>   config.vm.network :forwarded_port, guest: 5000, host: 5000
>   # Forward port 80 for the http Lava Frontend Web Server
>   config.vm.network :forwarded_port, guest: 8080, host: 8080
>   # Forward port 443 for the https Lava Frontend Web Server
>   config.vm.network :forwarded_port, guest: 443, host: 4443
>   # Configure network accessibility for tftp server
>   config.vm.network "public_network", use_dhcp_assigned_default_route: true
> 
> 
> At least the documentation is pointing in this direction:
> 
> """
> Public Networks
> 
> Network identifier: public_network
> 
> Vagrant public networks are less private than private networks, and the
> exact meaning actually varies from provider to provider, hence the
> ambiguous definition. The idea is that while private networks should
> never allow the general public access to your machine, public networks can.
> 
> Confused? We kind of are, too. It is likely that public networks will be
> replaced by :bridged in a future release, since that is in general what
> should be done with public networks, and providers that do not support
> bridging generally do not have any other features that map to public
> networks either.
> """
> 
> This is a problem in our corporate network. I am not allowed to attach
> devices to our network without permission. That normally means I need a
> certificate for Ethernet port authentication. This will not really work
> with TFTP booting.
> 
> Furthermore, I wouldn't be surprised if your switches are filtering the
> BOOTP/DHCP protocol out. Sysadmins usually are not too happy if a rouge
> BOOTP/DHCP servers are active in the network.
> 
> So my question is, couldn't we add additional network interface, e.g.
> USB Ethernet adapter, and attach the device under test to this
> interface? I don't know if Vagrant is offering such an option. In the
> past I've done this with Qemu.

If your network is using the MAC address for authentication you could also 
put the MAC address of your USB ethernet adapter into the Virtualbox 
ethernet interface (adapter 2).

Thanks,
Daniel
