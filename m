From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 28 Oct 2019 09:36:09 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 39/57] ASoC: rsnd: remove RSND_REG_
	from rsnd_reg
In-Reply-To: <20191025120338.GA32430@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-40-git-send-email-biju.das@bp.renesas.com>
	<20191025120338.GA32430@amd>
Message-ID: <87lft54sg6.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Pavel

> > +#define SRCIN_TIMSEL(i)		(SRCIN_TIMSEL0 + (i))
> > +#define SRCOUT_TIMSEL(i)	(SRCOUT_TIMSEL0 + (i))
> > +#define CTU_SVxxR(i, j)		(CTU_SV00R + (i * 8) + (j))
> > +#define DVC_VOLxR(i)		(DVC_VOL0R + (i))
> > +#define AUDIO_CLK_SEL(i)	(AUDIO_CLK_SEL0 + (i))
> > +#define SSI_BUSIF_MODE(i)	(SSI_BUSIF0_MODE + (i))
> > +#define SSI_BUSIF_ADINR(i)	(SSI_BUSIF0_ADINR + (i))
> > +#define SSI_BUSIF_DALIGN(i)	(SSI_BUSIF0_DALIGN + (i))
> > +#define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))
> 
> Would it still make sense to test that i is in expected range?
> 
> #define CHECK_RANGE(i) ({ WARN_ON(i<0 || i>4); i; })
> #define SRCIN_TIMSEL(i)              (SRCIN_TIMSEL0 + (i))

Which range ?? for SRCIN ?
I'm not sure it make sense. Can you send use case ??

Thank you for your help !!
Best regards
---
Kuninori Morimoto
