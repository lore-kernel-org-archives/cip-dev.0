From: pavel@denx.de (Pavel Machek)
Date: Thu, 29 Aug 2019 10:09:14 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 07/41] pinctrl: sh-pfc: Absorb
 enum IDs in PINMUX_CFG_REG() macro
In-Reply-To: <1566991328-25476-8-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1566991328-25476-8-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190829080914.GC10041@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit efca8da0c5fcc7f5617bab769faa595f7efdc593 upstream.
> 
> Currently the PINMUX_CFG_REG() macro must be followed by initialization
> data, specifying all enum IDs.  Hence the macro itself does not know
> anything about the enum IDs, preventing the macro from performing any
> validation on it.
> 
> Make the macro accept the enum IDs as a parameter, and update all users.
> Note that array data enclosed by curly braces cannot be passed to a
> macro as a parameter, hence the enum IDs are wrapped using a new macro
> GROUPS().

The macro is called "GROUP" and we already have macros with same name
(but different functionality) in the tree.

One of the other uses is ./arch/sh/kernel/cpu/sh4a/setup-sh7734.c. Not
sure if it is huge problem, but it might be a bit confusing...

./drivers/pinctrl/sirf/pinctrl-atlas7.c:#define GROUP(n, p)  \
./drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h:#define GROUP(grp, f)
./drivers/pinctrl/meson/pinctrl-meson8-pmx.h:#define GROUP(grp, r, b)
./drivers/input/rmi4/rmi_driver.h:#define GROUP(_attrs) { \
./arch/sh/kernel/cpu/sh4a/setup-sh7734.c:#define GROUP 0

Best regards,
								Pavel

> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -118,20 +118,24 @@ struct pinmux_cfg_reg {
>  	const u8 *var_field_width;
>  };
>  
> +#define GROUP(...)	__VA_ARGS__
> +

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190829/28286036/attachment.sig>
