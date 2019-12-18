From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Dec 2019 20:32:34 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc:
 Fix power request conflicts
In-Reply-To: <1576668829-59767-9-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
 <1576668829-59767-9-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191218193234.GB15353@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This register does not exist on R-Car H3 ES1.x and ES2.x.
> 
> Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

So you are storing bitfield in the pointer, ok.

> -	{ .soc_id = "r8a7795", .revision = "ES1.*" },
> +#define HAS_A2VC0	BIT(0)		/* Power domain A2VC0 is present */
> +#define NO_EXTMASK	BIT(1)		/* Missing SYSCEXTMASK register */
> +
> +static const struct soc_device_attribute r8a7795_quirks_match[] __initconst = {
> +	{
> +		.soc_id = "r8a7795", .revision = "ES1.*",
> +		.data = (void *)(HAS_A2VC0 | NO_EXTMASK),
> +	}, {
> +		.soc_id = "r8a7795", .revision = "ES2.*",
> +		.data = (void *)(NO_EXTMASK),
> +	},
>  	{ /* sentinel */ }
>  };
>  
>  static int __init r8a7795_sysc_init(void)
>  {
> -	if (!soc_device_match(r8a7795es1))
> +	const struct soc_device_attribute *attr;
> +	u32 quirks = 0;
> +
> +	attr = soc_device_match(r8a7795_quirks_match);
> +	if (attr)
> +		quirks = (uintptr_t)attr->data;

But now you do strange dance with types. I'd understand quirks being
unsigned long (because that's same size as void *). I also could
understand quirks being uintptr_t in the first place (but we normally
use unsigned long for that in the kernel).

But having it as u32, then casting it over uintptr_t is strange.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191218/47b76ee8/attachment.sig>
