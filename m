From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  9 Mar 2018 09:57:04 +0000
Subject: [cip-dev] [PATCH 4/4] ARM: shmobile: enable XHCI_RCAR in defconfig
In-Reply-To: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520589424-15807-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ae6b99bc6928d13856172f287ee21be2eac39673)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 2e79332..30a3424 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -162,6 +162,8 @@ CONFIG_SND_SOC_RSRC_CARD=y
 CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_RCAR=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
-- 
2.7.4
