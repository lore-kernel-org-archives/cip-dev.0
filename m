From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai Ndungu)
Date: Tue, 9 Apr 2019 09:10:23 +0000
Subject: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
 "delayed" replies
In-Reply-To: <20190406103835.GA15362@amd>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<20190406103835.GA15362@amd>
Message-ID: <OSBPR01MB205544A5365C6EDEFA5C9B95E92D0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> -----Original Message-----
> From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> Behalf Of Pavel Machek
> Sent: 06 April 2019 11:39
> To: Patryk Mungai Ndungu <patryk.mungai-ndungu.kx@renesas.com>
> Cc: stable at vger.kernel.org; davem at davemloft.net; cip-dev at lists.cip-
> project.org
> Subject: Re: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
> "delayed" replies
> 
> Hi!
> 
> > When running dhcp tests using the 4.4.y (and 4.4.y-cip kernel as well), I
> > encountered an issue where the dhcp client in the kernel could not get an
> > IP address when multiple network devices were enabled. It seems that the
> > current implementation of the dhcp client in the 4.4 kernel is send dhcp
> > request via device 1 -> wait <1s for response from server on device 1 ->
> > if no response, switch to device 2 -> repeat process on device 2 ...etc.
> > When the dhcp server is slow to respond, this means it is impossible to get
> > a dhcp address.
> >
> > This series backported from upstream fixes the issue, is it possible
> > to apply this to 4.4.y and/or 4.4.y-cip?
> 
> Ok, so first patch adds support for using "delayed" DHCP replies, then
> there are three more patches to fix up issues it creates.
> 
> Which tells me that maybe this is not quite suitable for -stable.
> 
> How long do your dhcp servers take to reply? 

It varies: the fastest reply I've seen is 0.12931s, the slowest is in the region is just over 1.007s.
In the tests I've run, I measured the time between the kernel sending out the DHCP request and receiving a DHCP offer from the server. After running 50 tests, in around half of them, it takes just over 1s for the DHCP offer to arrive. But this is rarely over 1s +1 jiffie, hence why I think the code is able to cope with it most of the time.

However, the DHCP servers network is not at all loaded (at most only has 4 devices trying to connect to it at once), and yet I've seen this failure multiple times, so I'm not sure what would happen in a loaded network.
I think at least for CIP we need a kernel that is able to cope with however long the server takes to reply.

> Can you solve the problem
> some other way, like for example increasing timeouts?

I've tried increasing CONF_INTER_TIMEOUT to 2Hz and I haven't seen it fail in 50 boots. Though this is an simple workaround, it can prolong boot up time and the DHCP client is still time dependent with regards to listening for a reply on a network device.

Thanks,
Patryk

> 
> Thanks,
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
