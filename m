From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 17 Jul 2019 06:59:45 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas:
 r8a774c0-cat874: Add LEDs support
In-Reply-To: <20190716202602.GC9557@amd>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-2-git-send-email-biju.das@bp.renesas.com>
	<20190716202602.GC9557@amd>
Message-ID: <OSBPR01MB2103E19170D82D9CC3B651D7B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas: r8a774c0-
> cat874: Add LEDs support
> 
> Hi!
> 
> > index f08778e..af396bb 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> > @@ -22,6 +22,30 @@
> >  		stdout-path = "serial0:115200n8";
> >  	};
> >
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led0 {
> > +			gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
> > +			label = "LED0";
> > +		};
> > +
> > +		led1 {
> > +			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
> > +			label = "LED1";
> > +		};
> > +
> > +		led2 {
> > +			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
> > +			label = "LED2";
> > +		};
> > +
> > +		led3 {
> > +			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
> > +			label = "LED3";
> > +		};
> > +	};
> 
> With my LED maintainer hat on... these are not exactly useful LED names. Do
> they have any fixed meaning? Are they labeled on the board?
> What color are they?

It is labelled as LED0 label on the board and green colour. 

Basically this board is as per 96boards CE specification
System and User LEDs
The following LEDs shall be present on the board.
The LEDs shall be of the specified size, color and location.
The User LEDs shall be directly programmable from the SoC.
1. WiFi activity LED Yellow Type: 0603 SMD
2. Bluetooth activity LED Blue Type: 0603 SMD
3. User LEDs x4 Green Type: 0603 SMD
Other LEDs and UI interfaces are optional.

As a LED maintainer, What is your recommendation for mainline?

1) label = "LED0"; --> based on the label on the board

2) label = " gren:LED0 "; --> based on the colour and label on the board.

3) label = " green:user1";--> based on the colour and label as per 96 boards CE specification.

Regards,
Biju
