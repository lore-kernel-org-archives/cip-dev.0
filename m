From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 12:20:35 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/17] phy: rcar-gen3-usb2: Add
 R-Car Gen3 USB2 PHY driver
In-Reply-To: <20190828110202.GA8052@amd>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
	<1566982115-11148-4-git-send-email-biju.das@bp.renesas.com>
	<20190828110202.GA8052@amd>
Message-ID: <OSBPR01MB21038D85562526F8F4DA886CB8A30@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.4.y-cip 03/17] phy: rcar-gen3-usb2: Add R-Car
> Gen3 USB2 PHY driver
> 
> Hi!
> 
> > --- /dev/null
> > +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> > @@ -0,0 +1,217 @@
> > +/*
> > + * Renesas R-Car Gen3 for USB2.0 PHY driver
> > + *
> > + * Copyright (C) 2015 Renesas Electronics Corporation
> > + *
> > + * This is based on the phy-rcar-gen2 driver:
> > + * Copyright (C) 2014 Renesas Solutions Corp.
> > + * Copyright (C) 2014 Cogent Embedded, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> 
> I see the mainline version already uses SPDX. Is there reason for older
> version to be backported?
> 

I have backported the commit "f3b5a8d9b50d71b8c9fb72aa9c8ea948ad1a4ef9" phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver (Linux 4.7 kernel)
This has the  file path (drivers/phy/phy-rcar-gen3-usb2.c) which is inline with (Linux 4.4 kernel), instead of the later versions (drivers/phy/renesas/ phy-rcar-gen3-usb2.c)

Only RZ/G1C driver uses Gen3 phy driver, it is basically for initializing timing/interrupt generation registers for {ehci,ohci}-platform driver.

The original patch doesn't use SPDX, that is the reason. 

> 
> > +	/*
> > +	 * TODO: To reduce power consuming, this driver should set the
> SUSPM
> > +	 *	after the PHY detects ID pin as peripheral.
> > +	 */
> 
> Plus I don't see the TODO in the mainline version.

The original commit has this comment ("f3b5a8d9b50d71b8c9fb72aa9c8ea948ad1a4ef9" phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver).
Moreover RZ/G1C SoC doesn't use  hsusb block of this driver .

> > +	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> > +	if (!channel)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "usb2_host");
> > +	channel->usb2.base = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(channel->usb2.base))
> > +		return PTR_ERR(channel->usb2.base);
> > +
> > +	/* "hsusb" memory resource is optional */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "hsusb");[>] :q!

> > +
> > +	/* To avoid error message by devm_ioremap_resource() */
> > +	if (res) {
> > +		channel->hsusb.base = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(channel->hsusb.base))
> > +			channel->hsusb.base = NULL;
> > +	}
> 
> What is going on here? If ioremap fails for some transient reason, do we
> want to continue without the resource?

RZ/G1C doesn't use the hsusb block of this driver. So it is ok.
The purpose of this driver  is to initialize some registers of SoC specific to use the {ehci,ohci}-platform driver.

I hope this helps.
    
Regards,
Biju
