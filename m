From: pavel@denx.de (Pavel Machek)
Date: Fri, 30 Aug 2019 00:31:16 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 00/51] Fast forward sh-pfc
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190829223116.GA31270@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> v1 had build time issues on ARM with shmobile_defconfig, this series
> includes the patches to fix those issues (and some cosmetic improvements
> while at it).
> The troublesome SoC specific pinctrl drivers are not related to the
> SoCs looked after by CIP, therefore we would not be testing those
> fixes on real HW.
> I am not sure this series is worth applying due to the amount of untested
> changes, and yet on the other hand it would facilitate future development.
> I would like to hear your thoughts about this, Pavel? Chris? Biju?
> Ben?

Ok, so 1-41 is already applied. I applied 43 and 44, as that should
fix the build. ...it did not.

I reviewed the rest of patches, and do not see anything obviously
wrong. They would affect dts, and I see value in keeping that
compatible between 4.19 and mainline.

And ... it is "just" 8 patches now, and they won't do damage outside
of shmobile. I applied them, and it fixed the build problem on the
gitlab.

Please take a look and let me know if something is still broken. (We
can still revert whole series).

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190830/350c4eb2/attachment-0001.sig>
