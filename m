From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 15 Aug 2019 11:35:12 +0200
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] staging: m57621-mmc:
 delete driver from the tree.
In-Reply-To: <bff48726-afc7-0676-b189-dad8ca1d559a@siemens.com>
References: <bff48726-afc7-0676-b189-dad8ca1d559a@siemens.com>
Message-ID: <20190815093512.GA10735@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The license text in this driver is "interesting" and not really obvious
> that it is supposed to be able to be distributed in the kernel source
> tree.  Yes, the MODULE_LICENSE() text says GPL, so it's probably ok, but
> to be safe, I am deleting this driver.  I will be glad to add it back if
> the license is properly sorted out, but for now, this isn't worth the
> potential risk, I should have never taken it in the first place.

Thanks for a patch, applied to 4.19-cip. It will appear in 4.19-cip-rt
during the next update.

If you want to see it in -cip-rt sooner, let me know.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190815/a0e31af3/attachment.sig>
