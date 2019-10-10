From: pavel@denx.de (Pavel Machek)
Date: Thu, 10 Oct 2019 09:38:10 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 2/3] arm64: dts: renesas:
 hihope-common: Add BT support
In-Reply-To: <1570689915-14149-3-git-send-email-biju.das@bp.renesas.com>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
	<1570689915-14149-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191010073809.GA23033@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit d112c20925443b4a8876b101e5b7b13ef105057e upstream.
> 
> This patch enables BT support for the HiHope RZ/G2[MN] boards.

> +++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> @@ -31,6 +32,13 @@
>  	leds {
>  		compatible = "gpio-leds";
>  
> +		bt_active_led {
> +			label = "blue:bt";

It would be good to change this to "blue:bluetooth", for consistency
with include/dt-bindings/leds/common.h . It will change names in the
sysfs.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191010/0b1bbd64/attachment.sig>
