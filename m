From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 24 Apr 2019 18:44:39 +0200
Subject: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
 "delayed" replies
In-Reply-To: <20190406135350.GA2935@sasha-vm>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<20190406135350.GA2935@sasha-vm>
Message-ID: <20190424164439.GB21916@kroah.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sat, Apr 06, 2019 at 09:53:50AM -0400, Sasha Levin wrote:
> On Fri, Apr 05, 2019 at 11:47:31AM +0100, Patryk Mungai wrote:
> > Dear All,
> > 
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
> This is something that seems more suited for the CIP kernel as it adds
> new functionality.

I agree, this is a new feature.  If someone wants this, they should use
a newer kernel please.  Like 4.19.y :)

thanks,

greg k-h
