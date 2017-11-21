From: albert.aribaud@3adev.fr (Albert ARIBAUD)
Date: Tue, 21 Nov 2017 22:51:35 +0100
Subject: [cip-dev] B@D Vagrant install stalls at "Setting up net-tools"
In-Reply-To: <871skt5oly.fsf@ctlt579.codethink.co.uk>
References: <20171119183030.7815aa8e.albert.aribaud@3adev.fr>
	<871skt5oly.fsf@ctlt579.codethink.co.uk>
Message-ID: <20171121225135.2731d951.albert.aribaud@3adev.fr>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Robert,

Le Mon, 20 Nov 2017 08:41:13 +0000, Robert Marshall
<robert.marshall@codethink.co.uk> a ?crit :

> Albert
> 
> Thanks for this report, see inline for comments
> 
> Albert ARIBAUD <albert.aribaud@3adev.fr> writes:
> 
> > Hello all,
> >
> > I am trying to install B at D, building the VM  myself (method #2), on a
> > Xubuntu 17.04 host.
> >
> > I am following the indications from
> >
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-from-scratch-using-vagrant-15
> >
> > So I clone
> > https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev
> >
> > Then cd into board-at-desk-single-dev and do a
> >
> > $ vagrant up
> >
> > But when the install process reaches this line:
> >  
> > ==> default: Setting up net-tools (1.60+git20161116.90da8a0-1) ...  
> >
> > there is no progress any more -- but no error message either.  
> 
> In the sample output, at this point we have
> 
> ==> default: Setting up net-tools (1.60+git20161116.90da8a0-1) ...
> ==> default: Reading package lists...
> ==> default: Building dependency tree...
> ==> default: Reading state information...
> ==> default: The following NEW packages will be installed:
> ==> default:   bc
> ==> default: 0 upgraded, 1 newly installed, 0 to remove and 1 not
> upgraded. ==> default: Need to get 105 kB of archives.  
> 
> So in your case it doesn't progress past that first line which is
> strange. As there's package installs before that. How is your machine
> connected to the internet, is there a web proxy?

No proxy, the LAN provides native IPv6 connectivity and NAT for IPv4.
but your question made me think about one possible cause: all machines
on the LAN get their IPv4 from a local DHCP server which has a strict
static lease policy.

The host has a static lease assigned, but the VM did not initially,
and apparently, not getting a DHCP lease is cause for a long (possibly
indefinite) stalling.

I had added a lease in the DHCP server while the VM was stalling, and
in the DHCP server logs I had seen the VM trying DHCP again and getting
a lease eventually, but it remained stalled.

So I halted and destroyed it, then created it again, thinking that this
time it would get the lease right away, but it kept stalling.

Only today have I realized that the VM might be generating its Ethernet
address randomly at every "up" -- and it was -- so it would always fail
getting a lease.

So I modified ./VagrantFile to give the VM a fixed MAC address for
which I set up a DHCP lease, and this time the VM went past the
"Setting up net-tools" line.

I'll see if the setup survives VM 'reboots' and 'power cycles'.

> > I have checked that prerequisites for B at D are satisfied on the host.
> >
> > Is this stalling a known issue? Should I stick to using the prebuilt VM
> > for now rather than build it myself?  
> 
> I've not seen it before but using the prebuilt VM might be an easier
> workaround

The prebuilt VM would certainly have had the same issue at first (no
declared lease) but might indeed be slightly easier to deal with, as
(I suspect) its MAC address(es) would not vary in case of a reinstall,
so I can create a DHCP lease for it once and for all... until the
prebuilt VM is updated on the CIP side, with possibly a new MAC address.

Thanks for your help!

> Robert

Cordialement,
Albert ARIBAUD
3ADEV
