From: pavel@denx.de (Pavel Machek)
Date: Fri, 22 Nov 2019 11:09:17 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 03/17] mmc: renesas-sdhi: rename
 sh_mobile_sdhi.c => renesas_sdhi_core.c
In-Reply-To: <1574341247-46652-4-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-4-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191122100917.GD30479@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Simon Horman <horms+renesas@verge.net.au>
> 
> commit b5b6a5f4f06c0624886b2166e2e8580327f0b943 upstream.
> 
> Rename the source file SDHI. A follow-up patch will make it a library
> file used by a different top-level module file.
> 
> The name "renesas" is chosen as the SDHI driver is applicable to a wider
> range of SoCs than SH-Mobile it seems to be a more appropriate name.
> However, the SDHI driver source itself, is left as sh_mobile_sdhi to
> avoid unnecessary churn.
> 
> the name "core" was chosen to reflect the desired role of this file,
> to provide core functionality to the sdhi driver. A follow-up patch will
> move the file into that role.
> 
> Internal symbols have also been renamed to reflect the filename change.
> 
> The .name member of struct platform_driver and parameter to
> MODULE_ALIAS() have not been changed in order to avoid the complication
> of potentially breaking SH SoCs which still use platform drivers.

Ok, so this is a big rename.

>  drivers/mmc/host/renesas_sdhi_core.c | 741 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sh_mobile_sdhi.c    | 746 -----------------------------------

But there are subtle changes inside. Please avoid doing that when
renaming.

I guess array->entry and the cleanup are okay, but can you verify the
other two, quoted below?

Thanks and best regards,
								Pavel

-static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] =
 {
 -       {
 -               .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
 -       },
 +static const struct renesas_sdhi_of_data of_default_cfg = {
 +       .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
  };

(Array -> single entry).

+static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
...
-       .capabilities   = MMC_CAP_SD_HIGHSPEED,
+       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,

(Capability change.)

-       ret = pinctrl_select_state(priv->pinctrl, pin_state);
-       if (ret)
-               return ret;
-
-       return 0;
+       return pinctrl_select_state(priv->pinctrl, pin_state);

(Unrelated cleanup.)

@@ -511,13 +505,14 @@ static int sh_mobile_sdhi_write16_hook(struct
...	
        case CTL_DMA_ENABLE:
 -               return sh_mobile_sdhi_wait_idle(host);
+       case EXT_ACC:
+               return renesas_sdhi_wait_idle(host);
        }
		
(Additional case handled in a switch).

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191122/2ee1c9a0/attachment-0001.sig>
