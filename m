From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:29 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 11/17] ARM: shmobile: Enable USB [EO]HCI
	HCD PLATFORM support in shmobile_defconfig
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b266731b76d5c33c0f6d781c449e43ad9991fb70 upstream.

The USB [EO]HCI controller on RZ/G1C SoC doesn't have PCI bridge like
other R-Car Gen2 devices. So enable generic USB [EO]HCI HCD PLATFORM
support in shmobile_defconfig.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b1dd3037..6f5522f 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -173,7 +173,9 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_RCAR=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_RCAR_PHY=y
-- 
2.7.4
