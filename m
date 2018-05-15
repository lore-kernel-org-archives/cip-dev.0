From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 10:03:29 +0000
Subject: [cip-dev] [PATCH 57/62] thermal: rcar: enable to use
	thermal-zone on DT
In-Reply-To: <1526065917.6671.30.camel@codethink.co.uk>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
	<1525964931-14960-58-git-send-email-biju.das@bp.renesas.com>
	<1526065917.6671.30.camel@codethink.co.uk>
Message-ID: <TY1PR01MB177068C06F78A4FCEA8FF9B8C0930@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 11 May 2018 20:12
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org
> Subject: Re: [PATCH 57/62] thermal: rcar: enable to use thermal-zone on DT
>
> On Thu, 2018-05-10 at 16:08 +0100, Biju Das wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch enables to use thermal-zone on DT if it was calles as
> > "renesas,rcar-thermal-gen2".
> > Previous style (= non thermal-zone) is still supported by
> > "renesas,rcar-thermal" to keep compatibility for "git bisect".
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > (cherry picked from commit 8b477ea56383dc8b838f1f8b506e4571c14ceb30)
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> [...]
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> [...]
> > @@ -463,7 +492,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >  if (ret < 0)
> >  goto error_unregister;
> >
> > -priv->zone = thermal_zone_device_register("rcar_thermal",
> > +if (of_data == USE_OF_THERMAL)
> > +priv->zone = thermal_zone_of_sensor_register(
> > +dev, i, priv,
> > +&rcar_thermal_zone_of_ops);
>
> Doesn't this require a corresponding change to use
> thermal_zone_of_sensor_unregister()?

That's a good catch!

>
> It looks like this was fixed upstream by commits 5e325868aa59
> ("thermal: convert rcar_thermal to use
> devm_thermal_zone_of_sensor_register") and d4b23c5c434a ("thermal:
> rcar_thermal: don't call thermal_zone_device_unregister when
> USE_OF_THERMAL").

Thank you for the pointers, we will into them and we will send a v2.

Thank you for your help!

Cheers,
Fab

>
> Ben.
>
> > +else
> > +priv->zone = thermal_zone_device_register(
> > +"rcar_thermal",
> >  1, 0, priv,
> >  &rcar_thermal_zone_ops, NULL, 0,
> >  idle);
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
