From: pavel@denx.de (Pavel Machek)
Date: Fri, 25 Oct 2019 14:03:38 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 39/57] ASoC: rsnd: remove RSND_REG_
 from rsnd_reg
In-Reply-To: <1571295929-47286-40-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-40-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191025120338.GA32430@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit b7169ddea2f2a90538f606688adf4948f2da82ce upstream.
> 
> Current rsnd is using RSND_REG_xxx for register naming,
> and using RSND_REG_##f style macro for read/write.
> The biggest reason why it uses this style is that
> we can avoid non-existing register access.
> But, its demerit is sequential register access code will
> be very ugly.
> Current rsnd driver is well tested, so, let's remove RSND_REG_
> from rsnd_reg, and cleanup sequential register access code.

> +#define SRCIN_TIMSEL(i)		(SRCIN_TIMSEL0 + (i))
> +#define SRCOUT_TIMSEL(i)	(SRCOUT_TIMSEL0 + (i))
> +#define CTU_SVxxR(i, j)		(CTU_SV00R + (i * 8) + (j))
> +#define DVC_VOLxR(i)		(DVC_VOL0R + (i))
> +#define AUDIO_CLK_SEL(i)	(AUDIO_CLK_SEL0 + (i))
> +#define SSI_BUSIF_MODE(i)	(SSI_BUSIF0_MODE + (i))
> +#define SSI_BUSIF_ADINR(i)	(SSI_BUSIF0_ADINR + (i))
> +#define SSI_BUSIF_DALIGN(i)	(SSI_BUSIF0_DALIGN + (i))
> +#define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))

Would it still make sense to test that i is in expected range?

#define CHECK_RANGE(i) ({ WARN_ON(i<0 || i>4); i; })
#define SRCIN_TIMSEL(i)              (SRCIN_TIMSEL0 + (i))
...

Thanks and best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191025/71f59fad/attachment.sig>
