From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 22 Jun 2019 22:07:14 +0200
Subject: [cip-dev] [RFC] Script to find used sources in the kernel
In-Reply-To: <1561048077.21054.46.camel@codethink.co.uk>
References: <1561048077.21054.46.camel@codethink.co.uk>
Message-ID: <20190622200714.GA19211@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> There are a couple of open questions, on which I would like to hear
> other's opinions:
> 
> * Should the source lists be added to the repository or not?  If they
>   are added, then they should not be changed by the standard "all" and
>   "clean" targets.
>   I tend to think that they should be added, because they take a long
>   time to generate and require cross-compilers etc. to be installed.

I believe they should go to the repository, because we may want to
manually adjust the lists.

I don't believe "example" configurations we have necessarily have
enabled all the options "final products" may need. If some common
option (vfat?) is not enabled in our configurations, because it is not
hardware specific and not needed for testing, we may still want to
review it, because it is common enough that someone will need it...

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190622/b2c00791/attachment.sig>
