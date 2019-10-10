From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 10:38:29 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 2/3] arm64: dts: renesas:
 hihope-common: Add BT support
In-Reply-To: <20191010073809.GA23033@amd>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
	<1570689915-14149-3-git-send-email-biju.das@bp.renesas.com>
	<20191010073809.GA23033@amd>
Message-ID: <OSBPR01MB2103041EDEE03E98D257A360B8940@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for feedback.

> Subject: Re: [PATCH 4.19.y-cip 2/3] arm64: dts: renesas: hihope-common:
> Add BT support
> 
> Hi!
> 
> > commit d112c20925443b4a8876b101e5b7b13ef105057e upstream.
> >
> > This patch enables BT support for the HiHope RZ/G2[MN] boards.
> 
> > +++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> > @@ -31,6 +32,13 @@
> >  	leds {
> >  		compatible = "gpio-leds";
> >
> > +		bt_active_led {
> > +			label = "blue:bt";
> 
> It would be good to change this to "blue:bluetooth", for consistency with
> include/dt-bindings/leds/common.h . It will change names in the sysfs.

Can you please me point to the right file? There is nothing related to "blue:bluetooth",
Mentioned in include/dt-bindings/leds/common.h

Cheers,
Biju
