From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 11:04:13 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/17] mmc: renesas-sdhi: rename
 sh_mobile_sdhi.c => renesas_sdhi_core.c
In-Reply-To: <20191122100917.GD30479@amd>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-4-git-send-email-biju.das@bp.renesas.com>
 <20191122100917.GD30479@amd>
Message-ID: <OSBPR01MB21037829719AED4A98989B2EB8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,
Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 03/17] mmc: renesas-sdhi: rename
> sh_mobile_sdhi.c => renesas_sdhi_core.c
> 
> Hi!
> 
> > From: Simon Horman <horms+renesas@verge.net.au>
> >
> > commit b5b6a5f4f06c0624886b2166e2e8580327f0b943 upstream.
> >
> > Rename the source file SDHI. A follow-up patch will make it a library
> > file used by a different top-level module file.
> >
> > The name "renesas" is chosen as the SDHI driver is applicable to a
> > wider range of SoCs than SH-Mobile it seems to be a more appropriate
> name.
> > However, the SDHI driver source itself, is left as sh_mobile_sdhi to
> > avoid unnecessary churn.
> >
> > the name "core" was chosen to reflect the desired role of this file,
> > to provide core functionality to the sdhi driver. A follow-up patch
> > will move the file into that role.
> >
> > Internal symbols have also been renamed to reflect the filename change.
> >
> > The .name member of struct platform_driver and parameter to
> > MODULE_ALIAS() have not been changed in order to avoid the
> > complication of potentially breaking SH SoCs which still use platform
> drivers.
> 
> Ok, so this is a big rename.
> 
> >  drivers/mmc/host/renesas_sdhi_core.c | 741
> ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sh_mobile_sdhi.c    | 746 -----------------------------------
> 
> But there are subtle changes inside. Please avoid doing that when renaming.
> 
> I guess array->entry and the cleanup are okay, but can you verify the other
> two, quoted below?
> 
> Thanks and best regards,
> 								Pavel
> 
> -static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] =  {
>  -       {
>  -               .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
>  -       },
>  +static const struct renesas_sdhi_of_data of_default_cfg = {
>  +       .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
>   };
> 
> (Array -> single entry).

Looks like to avoid confusion, We need to backport  the patch
13bbd8af65895c524c27850495fadf23449f9f3d (mmc: sh_mobile_sdhi: don't use array for DT configs)

What do you think?

> +static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
> ...
> -       .capabilities   = MMC_CAP_SD_HIGHSPEED,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> 
> (Capability change.)

Looks like to avoid confusion, We need to backport  the patch
685d29ef1783af0049c4aeeec43722e410d5845d (mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3)
What do you think?

> -       ret = pinctrl_select_state(priv->pinctrl, pin_state);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> +       return pinctrl_select_state(priv->pinctrl, pin_state);
> 
> (Unrelated cleanup.)

Looks like to avoid confusion, We need to backport  the patch
2272c841ee301402ea7a01fc727619af1f97f0cc (mmc: sh_mobile_sdhi: simplify code for voltage switching)
What do you think?

> 
> @@ -511,13 +505,14 @@ static int sh_mobile_sdhi_write16_hook(struct
> ...
>         case CTL_DMA_ENABLE:
>  -               return sh_mobile_sdhi_wait_idle(host);
> +       case EXT_ACC:
> +               return renesas_sdhi_wait_idle(host)
>         }
> 
> (Additional case handled in a switch).

Looks like to avoid confusion, We need to backport  the patch
13bbd8af65895c524c27850495fadf23449f9f3d (mmc: sh_mobile_sdhi: don't use array for DT configs)
What do you think?

Regards,
Biju
