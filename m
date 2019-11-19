From: pavel@denx.de (Pavel Machek)
Date: Tue, 19 Nov 2019 23:27:57 +0100
Subject: [cip-dev] Renesas changes pending in v4.19.85-rc
Message-ID: <20191119222757.GA8413@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

v4.19.85-rc (available at
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
)

contains at least 6 patches that look relevant to Renesas
boards. They look ok to me, but you know more about Renesas hardware
than i do, and maybe second set of eyes would be useful. (Also... you
will not have to backport these :-) )

 | e80fc88a837a 441f61e3aa9e | ARM: dts: rcar: Correct SATA device sizes to 2 MiB
 | fd2d5f44efa2 e3da41a6c28f | arm64: dts: renesas: salvator-common: adv748x: Override secondary addresses
 | 0872c56d9d73 4d76ad7d9de0 | arm64: dts: renesas: r8a77965: Attach the SYS-DMAC to the IPMMU
 | 3d9c5d05904b 99584d93e301 | arm64: dts: renesas: r8a77965: Fix HS-USB compatible
 | 070df3e61d15 7a590fe31748 | arm64: dts: renesas: r8a77965: Fix clock/reset for usb2_phy1
 | f2ecd2865105 09938ea9d136 | phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191119/c53c9365/attachment.sig>
