From: pavel@denx.de (Pavel Machek)
Date: Wed, 28 Aug 2019 13:12:09 +0200
Subject: [cip-dev] [PATCH 4.4.y-cip 05/17] phy: phy-rcar-gen2: Add
 support for r8a77470
In-Reply-To: <1566982115-11148-6-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
	<1566982115-11148-6-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190828111209.GB8052@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

PHYS_PER_CHANNEL is 2.

> +	const u32 (*select_value)[PHYS_PER_CHANNEL];

This is ... quite "interesting" declaration. Does it actually match
the arrays below?

If I read it correctly:

   const u32 (...)[PHYS_PER_CHANNEL]

this is array of two items.

> +static const u32 pci_select_value[][PHYS_PER_CHANNEL] = {
> +	[0]	= { USBHS_UGCTRL2_USB0SEL_PCI, USBHS_UGCTRL2_USB0SEL_HS_USB },
> +	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI, USBHS_UGCTRL2_USB2SEL_USB30 },
> +};

But here we have three items (0, 1 and 2), yet we are assigning that
to same pointer.

Correct me if I'm wrong.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190828/559202eb/attachment.sig>
