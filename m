From: pavel@denx.de (Pavel Machek)
Date: Wed, 28 Aug 2019 13:02:02 +0200
Subject: [cip-dev] [PATCH 4.4.y-cip 03/17] phy: rcar-gen3-usb2: Add
 R-Car Gen3 USB2 PHY driver
In-Reply-To: <1566982115-11148-4-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
	<1566982115-11148-4-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190828110202.GA8052@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> --- /dev/null
> +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> @@ -0,0 +1,217 @@
> +/*
> + * Renesas R-Car Gen3 for USB2.0 PHY driver
> + *
> + * Copyright (C) 2015 Renesas Electronics Corporation
> + *
> + * This is based on the phy-rcar-gen2 driver:
> + * Copyright (C) 2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

I see the mainline version already uses SPDX. Is there reason for
older version to be backported?


> +	/*
> +	 * TODO: To reduce power consuming, this driver should set the SUSPM
> +	 *	after the PHY detects ID pin as peripheral.
> +	 */

Plus I don't see the TODO in the mainline version.

> +	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "usb2_host");
> +	channel->usb2.base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(channel->usb2.base))
> +		return PTR_ERR(channel->usb2.base);
> +
> +	/* "hsusb" memory resource is optional */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsusb");
> +
> +	/* To avoid error message by devm_ioremap_resource() */
> +	if (res) {
> +		channel->hsusb.base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(channel->hsusb.base))
> +			channel->hsusb.base = NULL;
> +	}

What is going on here? If ioremap fails for some transient reason, do
we want to continue without the resource?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190828/61a21905/attachment.sig>
