From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 12:19:50 +0100
Subject: [cip-dev] [PATCH 0/7] Add HDMI support to iwg20d
Message-ID: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Ben,

this series adds HDMI video output to iWave's iwg20d board.

I had to take out interrupt (hotplug) support from the hdmi DT node as
it looks like commit 9183e45db7774716d056319c237a4185baba19c7 introduced
"connector" data field with struct adv7511, but drm_connector_init was
left behind, and as such connector.dev is NULL, and that causes issues
to function adv7511_hpd_work, preventing HDMI hotplug from working
properly.

While investigating HDMI hotplugging, I have found out that when using
a GPIO purely as an interrupt source the corresponding GPIO module
clock is not enabled, therefore this series backports the fix for this.
I yet have to check if this fix is any good to 4.4 LTS, I'll send it to
stable at vger.kernel.org in case it works for 4.4 LTS too.

This series applies on top of tag v4.4.126-cip22.

Thanks,
Fab

Fabrizio Castro (4):
  dt-bindings: display: rcar-du: Document R8A774[35] DU
  drm: rcar-du: Add R8A7743 support
  ARM: dts: r8a7743: Add DU support
  ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI video output

Geert Uytterhoeven (1):
  gpio: rcar: Add Runtime PM handling for interrupts

Linus Walleij (1):
  gpio: rcar: use gpiochip data pointer

Niklas S?derlund (1):
  ARM: shmobile: defconfig: Enable CMA for DMA

 .../devicetree/bindings/display/renesas,du.txt     | 24 ++++---
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           | 73 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     | 30 +++++++++
 arch/arm/configs/shmobile_defconfig                |  3 +
 drivers/gpio/gpio-rcar.c                           | 75 ++++++++++++++++------
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 23 +++++++
 6 files changed, 197 insertions(+), 31 deletions(-)

-- 
2.7.4
