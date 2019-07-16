From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 22:26:02 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas:
 r8a774c0-cat874: Add LEDs support
In-Reply-To: <1563200930-39297-2-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716202602.GC9557@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> index f08778e..af396bb 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> @@ -22,6 +22,30 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led0 {
> +			gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
> +			label = "LED0";
> +		};
> +
> +		led1 {
> +			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
> +			label = "LED1";
> +		};
> +
> +		led2 {
> +			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
> +			label = "LED2";
> +		};
> +
> +		led3 {
> +			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
> +			label = "LED3";
> +		};
> +	};

With my LED maintainer hat on... these are not exactly useful LED
names. Do they have any fixed meaning? Are they labeled on the board?
What color are they?

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/6f76ff3f/attachment.sig>
