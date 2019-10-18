From: pavel@denx.de (Pavel Machek)
Date: Fri, 18 Oct 2019 23:49:44 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 00/57] Audio improvements/SSIU
	BUSIF/
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191018214944.GA2766@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This patch add support for SSIU BUSIF/ TDM split mode. Also it
> fixes some of audio issues.
> 
> This patch series is based on linux-4.19.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.

>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 251 +++++++++-
>  include/sound/soc-dpcm.h                           |  10 +
>  include/sound/soc.h                                |   7 +
>  sound/soc/fsl/fsl_asrc_dma.c                       |   2 +-
>  sound/soc/intel/boards/kbl_rt5663_max98927.c       |   5 +-
>  .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   5 +-
...
>  sound/soc/meson/axg-card.c                         |   6 +-
>  sound/soc/soc-compress.c                           |   4 +-
>  sound/soc/soc-core.c                               |  38 +-
>  sound/soc/soc-dapm.c                               |  14 +-
>  sound/soc/soc-pcm.c                                | 239 +++++-----
>  28 files changed, 1867 insertions(+), 1150 deletions(-)

Ok, this is quite a lot of changes, some of them questionable, and
some of them to the shared code.

What is "SSIU BUSIF/ TDM split mode" and why is it important? Is it
possible to identify which patches fix existing issues, and what
issues those are?

I'll post comments on individual patches later, but it would be really
useful to have a big picture.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191018/c0db7cf5/attachment.sig>
