From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 16:34:33 +0000
Subject: [cip-dev] [PATCH 57/62] thermal: rcar: enable to use
	thermal-zone on DT
In-Reply-To: <1527694144.2289.10.camel@codethink.co.uk>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
	<1525964931-14960-58-git-send-email-biju.das@bp.renesas.com>
	<1526065917.6671.30.camel@codethink.co.uk>
	<OSBPR01MB21031EC0D28B91DAFEF38990B8950@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<1527694144.2289.10.camel@codethink.co.uk>
Message-ID: <OSBPR01MB21036D9A72AC74C2F5EB2A23B86C0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

Thanks for the feedback.

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 30 May 2018 16:29
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org
> Subject: Re: [PATCH 57/62] thermal: rcar: enable to use thermal-zone on DT
>
> On Mon, 2018-05-21 at 13:46 +0000, Biju Das wrote:
> > Hi Ben,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH 57/62] thermal: rcar: enable to use thermal-zone
> > > on DT
> > >
> > > On Thu, 2018-05-10 at 16:08 +0100, Biju Das wrote:
> > > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > >
> > > > This patch enables to use thermal-zone on DT if it was calles as
> > > > "renesas,rcar-thermal-gen2".
> > > > Previous style (= non thermal-zone) is still supported by
> > > > "renesas,rcar-thermal" to keep compatibility for "git bisect".
> > > >
> > > > Signed-off-by: Kuninori Morimoto
> > > > <kuninori.morimoto.gx@renesas.com>
> > > > Signed-off-by: Eduardo Valentin <edubezval@gmail.com> (cherry
> > > > picked from commit 8b477ea56383dc8b838f1f8b506e4571c14ceb30)
> > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > [...]
> > > > --- a/drivers/thermal/rcar_thermal.c
> > > > +++ b/drivers/thermal/rcar_thermal.c
> > >
> > > [...]
> > > > @@ -463,7 +492,13 @@ static int rcar_thermal_probe(struct
> > >
> > > platform_device *pdev)
> > > >  if (ret < 0)
> > > >  goto error_unregister;
> > > >
> > > > -priv->zone = thermal_zone_device_register("rcar_thermal",
> > > > +if (of_data == USE_OF_THERMAL)
> > > > +priv->zone = thermal_zone_of_sensor_register(
> > > > +dev, i, priv,
> > > > +
> > >
> > > &rcar_thermal_zone_of_ops);
> > >
> > > Doesn't this require a corresponding change to use
> > > thermal_zone_of_sensor_unregister()?
> >
> > As per  the commit(d4b23c5c434a) message
> "devm_thermal_zone_of_sensor_register() case doesn't need to
> call   thermal_zone_device_unregister()"
> >
> > We are not using devm version of thermal_zone_of_sensor_register, so  I
> guess the below commit is not required.
> > d4b23c5c434a ("thermal: rcar_thermal: don't call
> > thermal_zone_device_unregister when USE_OF_THERMAL")
>
> Even so, it is wrong to use thermal_zone_of_sensor_register() and then
> thermal_zone_device_unregister().
>
> > > It looks like this was fixed upstream by commits 5e325868aa59
> > > ("thermal: convert rcar_thermal to use
> > > devm_thermal_zone_of_sensor_register") and d4b23c5c434a ("thermal:
> > > rcar_thermal: don't call thermal_zone_device_unregister when
> > > USE_OF_THERMAL").
> >
> > The commit 5e325868aa59 ("thermal: convert rcar_thermal to use
> > devm_thermal_zone_of_sensor_register")
> > depend upon the commit e498b4984 ("thermal: of-thermal: Add devm
> > version of  thermal_zone_of_sensor_register") which is outside the scope
> of renesas thermal driver.
> >
> >  Are you ok for backporting the above patch? If yes, then it make sense to
> backport the commits 5e325868aa59 and d4b23c5c434a.
>
> Yes, I think this is OK.  Commit e498b4984 doesn't change any existing
> functions so it should be safe to add.

Shall I send only thermal related patches  or do you want me to send V2 with 65 patches?
Please let me know.

Regards,
Biju



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
