From: pavel@denx.de (Pavel Machek)
Date: Sat, 6 Apr 2019 12:38:35 +0200
Subject: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
 "delayed" replies
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <20190406103835.GA15362@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> When running dhcp tests using the 4.4.y (and 4.4.y-cip kernel as well), I
> encountered an issue where the dhcp client in the kernel could not get an
> IP address when multiple network devices were enabled. It seems that the
> current implementation of the dhcp client in the 4.4 kernel is send dhcp
> request via device 1 -> wait <1s for response from server on device 1 ->
> if no response, switch to device 2 -> repeat process on device 2 ...etc.
> When the dhcp server is slow to respond, this means it is impossible to get
> a dhcp address.
> 
> This series backported from upstream fixes the issue, is it possible
> to apply this to 4.4.y and/or 4.4.y-cip?

Ok, so first patch adds support for using "delayed" DHCP replies, then
there are three more patches to fix up issues it creates.

Which tells me that maybe this is not quite suitable for -stable.

How long do your dhcp servers take to reply? Can you solve the problem
some other way, like for example increasing timeouts?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190406/635ad643/attachment.sig>
