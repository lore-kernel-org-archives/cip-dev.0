From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 24 Aug 2018 18:28:44 +0100
Subject: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform boot
 support from src.c
In-Reply-To: <1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1535131724.2902.38.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri, 2018-08-10 at 10:52 +0100, Fabrizio Castro wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> No board is using Renesas sound driver via platform boot now.
> This means all user is using DT boot. Platform boot support is
> no longer needed. But, it strongly depends on platform boot style.
> This patch removes platform boot support from src.c
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> (cherry picked from commit adf6a6815952c6c6092ae15e27c1b782fd96c6a3)
> (reworked to fit the context)
[...]

This isn't a sufficient explanation of the backporting change.  The
upstream version appears to remove all use of struct
rsnd_src_platform_info from the driver, but this version extends the
use of that structure.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
