From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 12:50:06 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] phy: renesas:
 rcar-gen3-usb2: add conditions for uses_otg_pins == false
In-Reply-To: <20190716120519.GG24157@amd>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
	<1563199312-18842-6-git-send-email-biju.das@bp.renesas.com>
	<20190716120519.GG24157@amd>
Message-ID: <OSBPR01MB21031A6A614BDD3D3BDEF045B8CE0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

HI Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 16, 2019 1:05 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 05/12] phy: renesas: rcar-gen3-usb2:
> add conditions for uses_otg_pins == false
> 
> Hi!
> 
> > @@ -212,6 +212,9 @@ static void
> > rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
> >
> >  static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)  {
> > +	if (!ch->uses_otg_pins)
> > +		return (ch->dr_mode == USB_DR_MODE_HOST) ? false :
> true;
> 
> I'd write this as
> 
>     "return ch->dr_mode != USB_DR_MODE_HOST;"
> 
> I'll take the patch, anyway, but there's room for future cleanup.

Yes I agree.  There is a room for improvement in future.

Regards,
Biju
