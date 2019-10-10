From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 07:45:06 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 2/3] arm64: dts: renesas:
 hihope-common: Add BT support
In-Reply-To: <20191010073809.GA23033@amd>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
	<1570689915-14149-3-git-send-email-biju.das@bp.renesas.com>
	<20191010073809.GA23033@amd>
Message-ID: <OSBPR01MB21039E1C0824103B47FDAFC5B8940@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, October 10, 2019 8:38 AM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
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

As you mentioned, I agree we should fix this in mainline first and then backported to cip.

Cherrs,
Biju

> It would be good to change this to "blue:bluetooth", for consistency with
> include/dt-bindings/leds/common.h . It will change names in the sysfs.
> 
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
