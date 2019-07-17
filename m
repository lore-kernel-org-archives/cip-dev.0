From: pavel@denx.de (Pavel Machek)
Date: Wed, 17 Jul 2019 11:39:30 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas:
 r8a774c0-cat874: Add LEDs support
In-Reply-To: <OSBPR01MB2103E19170D82D9CC3B651D7B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-2-git-send-email-biju.das@bp.renesas.com>
	<20190716202602.GC9557@amd>
	<OSBPR01MB2103E19170D82D9CC3B651D7B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20190717093930.GA5105@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > +		led3 {
> > > +			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
> > > +			label = "LED3";
> > > +		};
> > > +	};
> > 
> > With my LED maintainer hat on... these are not exactly useful LED names. Do
> > they have any fixed meaning? Are they labeled on the board?
> > What color are they?
> 
> It is labelled as LED0 label on the board and green colour. 
> 
> Basically this board is as per 96boards CE specification
> System and User LEDs
> The following LEDs shall be present on the board.
> The LEDs shall be of the specified size, color and location.
> The User LEDs shall be directly programmable from the SoC.
> 1. WiFi activity LED Yellow Type: 0603 SMD
> 2. Bluetooth activity LED Blue Type: 0603 SMD
> 3. User LEDs x4 Green Type: 0603 SMD
> Other LEDs and UI interfaces are optional.
> 
> As a LED maintainer, What is your recommendation for mainline?
> 
> 1) label = "LED0"; --> based on the label on the board
> 
> 2) label = " gren:LED0 "; --> based on the colour and label on the board.
> 
> 3) label = " green:user1";--> based on the colour and label as per 96 boards CE specification.

Lets make it "green:user1".

Thank you,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/cdaad348/attachment-0001.sig>
