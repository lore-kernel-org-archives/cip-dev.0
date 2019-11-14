From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 16:20:40 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/57] Audio improvements/SSIU
	BUSIF/
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <OSBPR01MB210394BC6579421417D6F0ECB8710@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel and others,

Thanks for the feedback.

Can you please suggest, how you want to handle this patch set? 

regards,
Biju

> Subject: [PATCH 4.19.y-cip 00/57] Audio improvements/SSIU BUSIF/
> 
> This patch add support for SSIU BUSIF/ TDM split mode. Also it fixes some of
> audio issues.
> 
> This patch series is based on linux-4.19.y-cip and all the patches in this series
> are cherry-picked from linux rc tree.
> 
> Dmytro Prokopchuk (1):
>   ASoC: rsnd: fixup SSI clock during suspend/resume modes
> 
> Dragos Tarcatu (2):
>   ASoC: rsnd: add support for 16/24 bit slot widths
>   ASoC: rsnd: add support for 8 bit S8 format
> 
> Fabrizio Castro (1):
>   arm64: dts: renesas: r8a774a1: Add SSIU support for sound
> 
> Jiada Wang (12):
>   ASoC: rsnd: add warning message to rsnd_kctrl_accept_runtime()
>   ASoC: rsnd: remove is_play parameter from hw_rule function
>   ASoC: rsnd: ssi: Fix issue in dma data address assignment
>   ASoC: rsnd: ssi: Check runtime channel number rather than hw_params
>   ASoc: rsnd: dma: Calculate dma address with consider of BUSIF
>   ASoc: rsnd: dma: Calculate PDMACHCRE with consider of BUSIF
>   ASoC: rsnd: ssiu: Support BUSIF other than BUSIF0
>   ASoC: rsnd: ssiu: Support to init different BUSIF instance
>   ASoC: rsnd: ssiu: correct shift bit for ssiu9
>   ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register address
>   ASoC: rsnd: src: Avoid a potential deadlock
>   ASoC: rsnd: src: fix compiler warnings
> 
> Kuninori Morimoto (37):
>   ASoC: rsnd: merge .nolock_start and .prepare
>   ASoC: rsnd: gen: use tab instead of white-space
>   ASoC: rsnd: don't use %p for dev_dbg()
>   ASoC: add for_each_rtd_codec_dai() macro
>   ASoC: convert for_each_rtd_codec_dai() for missing part
>   ASoC: add for_each_dpcm_fe() macro
>   ASoC: add for_each_dpcm_be() macro
>   ASoC: rsnd: use 32bit TDM width as default
>   ASoC: rsnd: enable TDM settings for SSI parent
>   ASoC: rsnd: tidyup SSICR::SWSP for TDM
>   ASoC: rsnd: move .get_status under rsnd_mod_ops
>   ASoC: rsnd: add .get_id/.get_id_sub
>   ASoC: rsnd: rsnd_mod_name() handles both name and ID
>   ASoC: rsnd: remove endpoint bidirectional check
>   ASoC: rsnd: rename rsnd_runtime_is_ssi_xxx()
>   ASoC: rsnd: use defined io_playback/io_capture
>   ASoC: rsnd: move HDMI information from ssi.c to core.c
>   ASoC: rsnd: handle DPCM converted rate/chan under core
>   ASoC: rsnd: add SSIU BUSIF support
>   ASoC: rsnd: add TDM Split mode support
>   ASoC: rsnd: use ring buffer for rsnd_mod_name()
>   ASoC: rsnd: tidyup rsnd_parse_connect_ssiu_compatible()
>   ASoC: rsnd: makes rsnd_ssi_is_dma_mode() static
>   ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()
>   ASoC: rsnd: indicates Channel and Mode for debug
>   ASoC: rsnd: fixup mod ID for CTU regmap read/write
>   ASoC: rsnd: add missing TDM Split mode support for simple-card
>   ASoC: rsnd: remove RSND_REG_ from rsnd_reg
>   ASoC: rsnd: update BSDSR/BSDISR handling
>   ASoC: rsnd: fixup MIX kctrl registration
>   ASoC: rsnd: synchronize connection check for simple-card/audio-graph
>   ASoC: rsnd: fixup TDM Split mode check for CTU
>   ASoC: rsnd: fixup 6ch settings to 8ch
>   ASoC: rsnd: move pcm_new from snd_soc_component_driver to
>     snd_soc_dai_driver
>   ASoC: rsnd: ssiu: tidyup SSI_MODE1/2 settings
>   ASoC: rsnd: add missing pin sharing with SSI9
>   ASoC: rsnd: do error check after rsnd_channel_normalization()
> 
> Nilkanth Ahirrao (1):
>   ASoC: rsnd: fixup mod ID calculation in rsnd_ctu_probe_
> 
> Takashi Iwai (2):
>   ASoC: sh: Avoid passing NULL to memory allocators
>   ASoC: sh: Drop superfluous PCM preallocation error checks
> 
> Timo Wischer (1):
>   ASoC: rsnd: Support hw_free() callback at DAI level
> 
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 251 +++++++++-
>  include/sound/soc-dpcm.h                           |  10 +
>  include/sound/soc.h                                |   7 +
>  sound/soc/fsl/fsl_asrc_dma.c                       |   2 +-
>  sound/soc/intel/boards/kbl_rt5663_max98927.c       |   5 +-
>  .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   5 +-
>  sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   5 +-
>  sound/soc/meson/axg-card.c                         |   6 +-
>  sound/soc/sh/fsi.c                                 |   3 +-
>  sound/soc/sh/rcar/adg.c                            |  43 +-
>  sound/soc/sh/rcar/cmd.c                            |  11 +-
>  sound/soc/sh/rcar/core.c                           | 531 ++++++++++++++-------
>  sound/soc/sh/rcar/ctu.c                            | 140 ++----
>  sound/soc/sh/rcar/dma.c                            | 185 ++++---
>  sound/soc/sh/rcar/dvc.c                            |  21 +-
>  sound/soc/sh/rcar/gen.c                            | 106 +++-
>  sound/soc/sh/rcar/mix.c                            |   3 +-
>  sound/soc/sh/rcar/rsnd.h                           | 440 ++++++++++-------
>  sound/soc/sh/rcar/src.c                            | 175 ++++---
>  sound/soc/sh/rcar/ssi.c                            | 372 +++++++--------
>  sound/soc/sh/rcar/ssiu.c                           | 376 +++++++++++----
>  sound/soc/sh/siu_pcm.c                             |  15 +-
>  sound/soc/soc-compress.c                           |   4 +-
>  sound/soc/soc-core.c                               |  38 +-
>  sound/soc/soc-dapm.c                               |  14 +-
>  sound/soc/soc-pcm.c                                | 239 +++++-----
>  28 files changed, 1867 insertions(+), 1150 deletions(-)
> 
> --
> 2.7.4
