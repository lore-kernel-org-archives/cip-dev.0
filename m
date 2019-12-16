From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 16 Dec 2019 13:27:54 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip] net: davinci_cpdma: use dma_addr_t
 for DMA address
In-Reply-To: <OSAPR01MB3234810F3C1ACEB6DD43294792540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <20191213205656.GA2788@duo.ucw.cz>
 <OSAPR01MB3234810F3C1ACEB6DD43294792540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <20191216122754.GA20005@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > I have this in 4.4-rt-cip, and it would make my life easier if I applied
> > it to 4.4-cip. Would that be ok to do?
> 
> I think your suggestion is good because the cip-rt branch is based on the
> cip branch.

I applied the patch to 4.4-cip, and builds should be ok. I'd prefer
not to push it to 4.4-stable, but it might make sense for 4.4-rt. Let
me investigate.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191216/410e8f6b/attachment.sig>
