From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 12:50:36 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 30/57] ASoC: rsnd: add SSIU BUSIF
	support
In-Reply-To: <1571295929-47286-31-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-31-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020105036.GD18709@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch removes its settings from Document, but driver is still
> keeping compatibility. Thus, old DT style is still working.
> But, to avoid confusing, it doesn't indicate old compatibility things on
> Document. New SoC should have SSIU on DT from this patch.

I'm not sure which Document this talks about:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  sound/soc/sh/rcar/core.c |   1 +
>  sound/soc/sh/rcar/dma.c  |  37 ++++++++--
>  sound/soc/sh/rcar/rsnd.h |   6 +-
>  sound/soc/sh/rcar/ssi.c  |  22 +++---
>  sound/soc/sh/rcar/ssiu.c | 178 +++++++++++++++++++++++++++++++++++++++++++----
>  5 files changed, 215 insertions(+), 29 deletions(-)

Patch does not seem to be changing any documentation.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/61c40343/attachment.sig>
