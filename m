From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Tue, 1 Oct 2019 12:55:11 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/32] Add HDMI support to EK874
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <OSAPR01MB3234E12C0DB5ABB671552AB4929D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Fabrizio,


> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: Tuesday, October 1, 2019 5:25 PM
> To: cip-dev at lists.cip-project.org
> Cc: iwamatsu nobuhiro(?? ?? ????????)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel at denx.de; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Subject: [cip-dev][PATCH 4.19.y-cip 00/32] Add HDMI support to EK874
> 
> Dear All,
> 
> this series adds HDMI video and audio support to the EK874 board.

I will check this seriese.

Best regards,
  Nobuhiro


> 
> Thanks,
> Fab
> 
> Christophe JAILLET (1):
>   drm: rcar-du: Fix the return value in case of error in
>     'rcar_du_crtc_set_crc_source()'
> 
> Fabrizio Castro (10):
>   media: vsp1: Add RZ/G support
>   media: dt-bindings: media: renesas-fcp: Add RZ/G2 support
>   dt-bindings: display: renesas: du: Document r8a774c0 bindings
>   dt-bindings: display: renesas: lvds: Document r8a774c0 bindings
>   drm: rcar-du: Add r8a774c0 device support
>   drm: rcar-du: lvds: add R8A774C0 support
>   arm64: dts: renesas: r8a774c0: Add display output support
>   arm64: defconfig: Enable TDA19988
>   arm64: dts: renesas: cat874: Add HDMI video support
>   arm64: dts: renesas: cat874: Add HDMI audio
> 
> Jacopo Mondi (1):
>   drm: rcar-du: Improve non-DPLL clock selection
> 
> Laurent Pinchart (17):
>   dt-bindings: display: renesas: lvds: Add EXTAL and DU_DOTCLKIN clocks
>   drm: rcar-du: lvds: D3/E3 support
>   drm: rcar-du: Perform the initial CRTC setup from rcar_du_crtc_get()
>   drm: rcar-du: Use LVDS PLL clock as dot clock when possible
>   drm: rcar-du: Move CRTC outputs bitmask to private CRTC state
>   drm: rcar-du: Simplify encoder registration
>   drm: rcar-du: lvds: Don't fail probe if output is not connected on
>     D3/E3
>   drm: rcar-du: lvds: Add API to enable/disable clock output
>   drm: rcar-du: Turn LVDS clock output on/off for DPAD0 output on D3/E3
>   drm: rcar-du: lvds: Fix post-DLL divider calculation
>   drm: rcar-du: lvds: Adjust operating frequency for D3 and E3
>   drm: rcar-du: Enable configurable DPAD0 routing on Gen3
>   drm: rcar-du: Fix vblank initialization
>   drm: rcar-du: Fix external clock error checks
>   drm: rcar-du: Reject modes that fail CRTC timing requirements
>   drm: rcar-du: Disable unused DPAD outputs
>   drm: rcar-du: Replace EXT_CTRL_REGS feature flag with generation check
> 
> Mauro Carvalho Chehab (1):
>   media: use strscpy() instead of strlcpy()
> 
> Noralf Tr?nnes (1):
>   drm/rcar-du: Use drm_fbdev_generic_setup()
> 
> Thomas Zimmermann (1):
>   drm/rcar-du: Replace drm_dev_unref with drm_dev_put
> 
>  .../bindings/display/bridge/renesas,lvds.txt       |  12 +-
>  .../devicetree/bindings/display/renesas,du.txt     |   2 +
>  .../devicetree/bindings/media/renesas,fcp.txt      |   5 +-
>  .../devicetree/bindings/media/renesas,vsp1.txt     |   6 +-
>  arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    | 137 +++++++
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 167 ++++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/gpu/drm/Makefile                           |   2 +-
>  drivers/gpu/drm/rcar-du/Kconfig                    |   1 +
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c             | 294
> +++++++++-----
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   7 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  55 +--
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h              |  14 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |  14 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |   3 +-
>  drivers/gpu/drm/rcar-du/rcar_du_group.c            | 132 ++++--
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c              | 109 ++---
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |   1 -
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                | 441
> ++++++++++++++++++---
>  drivers/gpu/drm/rcar-du/rcar_lvds.h                |  27 ++
>  drivers/gpu/drm/rcar-du/rcar_lvds_regs.h           |  43 +-
>  drivers/media/platform/vsp1/vsp1_drv.c             |   2 +-
>  22 files changed, 1163 insertions(+), 312 deletions(-)  create mode
> 100644 drivers/gpu/drm/rcar-du/rcar_lvds.h
> 
> --
> 2.7.4
