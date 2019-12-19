From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 19 Dec 2019 07:43:23 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc:
 Fix power request conflicts
In-Reply-To: <20191218193234.GB15353@amd>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
 <1576668829-59767-9-git-send-email-biju.das@bp.renesas.com>
 <20191218193234.GB15353@amd>
Message-ID: <OSBPR01MB2103CCD07F5187D51623EF7CB8520@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

I am adding Dien and Geert to provide feedback on you r questions

Regards,
Bij

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, December 18, 2019 7:33 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Marian-Cristian Rotariu
> <marian-cristian.rotariu.rb@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc: Fix power
> request conflicts
> 
> Hi!
> 
> > This register does not exist on R-Car H3 ES1.x and ES2.x.
> >
> > Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.
> 
> So you are storing bitfield in the pointer, ok.
> 
> > -	{ .soc_id = "r8a7795", .revision = "ES1.*" },
> > +#define HAS_A2VC0	BIT(0)		/* Power domain A2VC0 is
> present */
> > +#define NO_EXTMASK	BIT(1)		/* Missing SYSCEXTMASK
> register */
> > +
> > +static const struct soc_device_attribute r8a7795_quirks_match[]
> __initconst = {
> > +	{
> > +		.soc_id = "r8a7795", .revision = "ES1.*",
> > +		.data = (void *)(HAS_A2VC0 | NO_EXTMASK),
> > +	}, {
> > +		.soc_id = "r8a7795", .revision = "ES2.*",
> > +		.data = (void *)(NO_EXTMASK),
> > +	},
> >  	{ /* sentinel */ }
> >  };
> >
> >  static int __init r8a7795_sysc_init(void)  {
> > -	if (!soc_device_match(r8a7795es1))
> > +	const struct soc_device_attribute *attr;
> > +	u32 quirks = 0;
> > +
> > +	attr = soc_device_match(r8a7795_quirks_match);
> > +	if (attr)
> > +		quirks = (uintptr_t)attr->data;
> 
> But now you do strange dance with types. I'd understand quirks being
> unsigned long (because that's same size as void *). I also could understand
> quirks being uintptr_t in the first place (but we normally use unsigned long
> for that in the kernel).
> 
> But having it as u32, then casting it over uintptr_t is strange.
> 


Dien, Geert,

Could you please share your thoughts on Pavel's comments?

Regards,
Biju
