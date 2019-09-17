From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:28 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 00/32] Add PCIe and HDMI support to
	HiHope RZ/G2M
Message-ID: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series adds HDMI and PCIe support for the HiHope RZ/G2M board.

v1->v2:
* Rebased on top of latest linux-4.19.y-cip branch

Thanks,
Fab

Biju Das (14):
  dt-bindings: PCI: rcar: Add device tree support for r8a774a1
  dt-bindings: display: renesas: du: Document the r8a774a1 bindings
  dt-bindings: display: renesas: lvds: Document r8a774a1 bindings
  drm: rcar-du: Add R8A774A1 support
  drm: rcar-du: lvds: Add r8a774a1 support
  arm64: dts: renesas: r8a774a1: Add PCIe device nodes
  arm64: dts: renesas: hihope-common: Declare pcie bus clock
  arm64: dts: renesas: hihope-rzg2-ex: Enable PCIe support
  arm64: dts: renesas: r8a774a1: Add VSP instances
  arm64: dts: renesas: r8a774a1: Add DU device to DT
  arm64: dts: renesas: r8a774a1: Add FDP1 instance
  arm64: dts: renesas: r8a774a1: Tie SYS-DMAC to IPMMU-DS0/1
  arm64: dts: renesas: r8a774a1: Tie Audio-DMAC to IPMMU-MP
  arm64: dts: renesas: r8a774a1: Connect Ethernet-AVB to IPMMU-DS0

Fabrizio Castro (3):
  dt-bindings: display: renesas: Add r8a774a1 support
  arm64: dts: renesas: r8a774a1: Add HDMI encoder instance
  arm64: dts: renesas: hihope-common: Add HDMI support

Jacopo Mondi (1):
  drm: rcar-du: Rename and document dpll_ch field

Kieran Bingham (3):
  drm: rcar-du: Refactor Feature and Quirk definitions
  drm: rcar-du: Add interlaced feature flag
  drm: rcar-du: Support interlaced video output through vsp1

Koji Matsuoka (1):
  drm: rcar-du: Add support for missing pixel formats

Laurent Pinchart (6):
  drm: rcar-du: dw-hdmi: Reject modes with a too high clock frequency
  drm: rcar-du: Cache DSYSR value to ensure known initial value
  drm: rcar-du: Don't use TV sync mode when not supported by the
    hardware
  drm: rcar-du: Rework clock configuration based on hardware limits
  drm: rcar-du: Store V4L2 fourcc in rcar_du_format_info structure
  drm: rcar-du: Update framebuffer pitch and alignment limits for Gen3

Marek Vasut (3):
  PCI: rcar: Replace unsigned long with u32/unsigned int in register
    accessors
  PCI: rcar: Replace various variable types with unsigned ones for
    register values
  PCI: rcar: Clean up debug messages

Wolfram Sang (1):
  PCI: rcar: Do not shadow the 'irq' variable

 .../bindings/display/bridge/renesas,dw-hdmi.txt    |   4 +-
 .../bindings/display/bridge/renesas,lvds.txt       |   1 +
 .../devicetree/bindings/display/renesas,du.txt     |   2 +
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     |  65 ++++++
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |   8 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 255 +++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             | 168 ++++++++------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   5 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  79 +++++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |  13 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |   7 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |  92 +++++++-
 drivers/gpu/drm/rcar-du/rcar_du_kms.h              |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |  46 +---
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |  15 ++
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   1 +
 drivers/pci/controller/pcie-rcar.c                 |  40 ++--
 18 files changed, 641 insertions(+), 162 deletions(-)

-- 
2.7.4
