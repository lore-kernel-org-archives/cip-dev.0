From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 12:57:37 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/12] phy: renesas:
 rcar-gen3-usb2: unify OBINTEN handling
In-Reply-To: <20190716120313.GF24157@amd>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
	<1563199312-18842-5-git-send-email-biju.das@bp.renesas.com>
	<20190716120313.GF24157@amd>
Message-ID: <OSBPR01MB2103FE3E76AC5DD095D2CE95B8CE0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 16, 2019 1:03 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 04/12] phy: renesas: rcar-gen3-usb2:
> unify OBINTEN handling
> 
> Hi!
> 
> > commit 7ab0305d4d7725699169e21cdc4f6c8759c32feb upstream.
> >
> > This patch unifies the OBINTEN handling to clean-up the code.
> 
> 
> > @@ -145,6 +145,18 @@ static void rcar_gen3_enable_vbus_ctrl(struct
> rcar_gen3_chan *ch, int vbus)
> >  	writel(val, usb2_base + USB2_ADPCTRL);  }
> >
> > +static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int
> > +enable) {
> > +	void __iomem *usb2_base = ch->base;
> > +	u32 val = readl(usb2_base + USB2_OBINTEN);
> > +
> > +	if (enable)
> > +		val |= USB2_OBINT_BITS;
> > +	else
> > +		val &= ~USB2_OBINT_BITS;
> > +	writel(val, usb2_base + USB2_OBINTEN); }
> > +
> >
> >  static void rcar_gen3_init_from_a_peri_to_a_host(struct
> > rcar_gen3_chan *ch)  {
> > -	void __iomem *usb2_base = ch->base;
> > -	u32 val;
> > -
> > -	val = readl(usb2_base + USB2_OBINTEN);
> > -	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> > +	rcar_gen3_control_otg_irq(ch, 0);
> >
> >  	rcar_gen3_enable_vbus_ctrl(ch, 1);
> >  	rcar_gen3_init_for_host(ch);
> >
> > -	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> > +	rcar_gen3_control_otg_irq(ch, 1);
> >  }
> 
> This actually removes optimalization: old code would avoid reading
> USB2_OBINTEN twice. I guess it is not a problem

I agree, it removes optimization compared to the old code, But on the hand, this code is not frequently used and  the code is much cleaner.

Regards,
Biju 
