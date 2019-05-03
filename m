From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 3 May 2019 09:34:56 +0000
Subject: [cip-dev] [PATCH 4.19.y 02/29] iommu/ipmmu-vmsa: Modify
 ipmmu_slave_whitelist() to check SoC revisions
In-Reply-To: <20190502212731.GB19728@amd>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556706143-11898-3-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190502212731.GB19728@amd>
Message-ID: <TY1PR01MB1770796FB6BEBE0DE40A420DC0350@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

Thank you for your feedback!

> From: Pavel Machek <pavel@denx.de>
> Sent: 02 May 2019 22:28
> Subject: Re: [cip-dev] [PATCH 4.19.y 02/29] iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to check SoC revisions
> 
> Hi!
> 
> > commit b7ee92c6ff0e023a473b2500d771f6bf504fcc1a upstream.
> >
> > Some R-Car Gen3 SoCs has hardware restrictions on the IPMMU. So,
> > to check whether this R-Car Gen3 SoC can use the IPMMU correctly,
> > this patch modifies the ipmmu_slave_whitelist().
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> >
> 
> >  static int ipmmu_of_xlate(struct device *dev,
> >  			  struct of_phandle_args *spec)
> >  {
> > -	/* For R-Car Gen3 use a white list to opt-in slave devices */
> > -	if (soc_device_match(soc_rcar_gen3) && !ipmmu_slave_whitelist(dev))
> > +	if (!ipmmu_slave_whitelist(dev))
> >  		return -ENODEV;
> >
> 
> I just want to make sure "soc_device_match(soc_rcar_gen3) &&" deletion
> is intentional here...

It is. I wasn't sure about backporting patch 807596491d33d016e420d217cf1350aef2d2b3f7,
but It didn't seem to add any value, what's your take on that?

Thanks,
Fab

> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
