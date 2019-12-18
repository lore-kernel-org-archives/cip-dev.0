From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Dec 2019 20:28:06 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 03/39] soc: renesas: Add Renesas
 R8A774B1 config option
In-Reply-To: <1576668829-59767-4-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
 <1576668829-59767-4-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191218192806.GA15353@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Add configuration option for the RZ/G2N (R8A774B1) SoC.

Normally, config option should be close to the end of the series
(having it in the begining can be surprising during the bisect, for
example).

Best regards,
								Pavel

> +++ b/arch/arm64/Kconfig.platforms
> @@ -195,6 +195,12 @@ config ARCH_R8A774A1
>  	help
>  	  This enables support for the Renesas RZ/G2M SoC.
>  
> +config ARCH_R8A774B1
> +	bool "Renesas RZ/G2N SoC Platform"
> +	depends on ARCH_RENESAS
> +	help
> +	  This enables support for the Renesas RZ/G2N SoC.
> +
>  config ARCH_R8A774C0
>  	bool "Renesas RZ/G2E SoC Platform"
>  	depends on ARCH_RENESAS

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191218/d25d1055/attachment.sig>
