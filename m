Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11580C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:21:14 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34987.1702041664809802815
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="185800401"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Dec 2023 22:21:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E9AF400297E;
	Fri,  8 Dec 2023 22:21:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 24/25] drm: [HACK DO NOT APPLY] Add RZ/G2L DU Support
Date: Fri,  8 Dec 2023 13:20:06 +0000
Message-Id: <20231208132007.108762-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:21:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13967

The LCD controller is composed of Frame Compression Processor (FCPVD),
Video Signal Processor (VSPD), and Display Unit (DU).

It has DPI/DSI interfaces and supports a maximum resolution of 1080p
along with 2 RPFs to support the blending of two picture layers and
raster operations (ROPs).

The DU module is connected to VSPD. Add RZ/G2L DU support for RZ/G2L
alike SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/Kconfig                  |   2 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/rz-du/Kconfig            |  22 ++
 drivers/gpu/drm/rz-du/Makefile           |   8 +
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c    | 432 +++++++++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h    |  91 +++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.c     | 187 ++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.h     |  85 +++++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c | 121 +++++++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h |  33 ++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.c     | 389 ++++++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.h     |  43 +++
 drivers/gpu/drm/rz-du/rzg2l_du_regs.h    |  67 ++++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c     | 428 ++++++++++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h     |  96 +++++
 15 files changed, 2005 insertions(+)
 create mode 100644 drivers/gpu/drm/rz-du/Kconfig
 create mode 100644 drivers/gpu/drm/rz-du/Makefile
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_regs.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 4e9b3a95fa7c..d7cb0896b6d0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -321,6 +321,8 @@ source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 
 source "drivers/gpu/drm/rcar-du/Kconfig"
 
+source "drivers/gpu/drm/rz-du/Kconfig"
+
 source "drivers/gpu/drm/shmobile/Kconfig"
 
 source "drivers/gpu/drm/sun4i/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 81569009f884..8d70ac239907 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_DRM_AST) += ast/
 obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
 obj-y			+= rcar-du/
+obj-y			+= rz-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-y			+= omapdrm/
 obj-$(CONFIG_DRM_SUN4I) += sun4i/
diff --git a/drivers/gpu/drm/rz-du/Kconfig b/drivers/gpu/drm/rz-du/Kconfig
new file mode 100644
index 000000000000..e5336bb705bb
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_RZG2L_DU
+	tristate "DRM Support for RZ/G2L Display Unit"
+	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on DRM && OF
+	depends on ARM || ARM64
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_GEM_CMA_HELPER
+	select VIDEOMODE_HELPERS
+	help
+	  Choose this option if you have an RZ/G2L alike chipset.
+	  If M is selected the module will be called rzg2l-du-drm.
+
+config DRM_RCAR_VSP
+	bool "R-Car DU VSP Compositor Support" if ARM
+	default y if ARM64
+	depends on DRM_RCAR_DU
+	depends on VIDEO_RENESAS_VSP1=y || (VIDEO_RENESAS_VSP1 && DRM_RCAR_DU=m) || (VIDEO_RENESAS_VSP1 && DRM_RZG2L_DU=m)
+	help
+	  Enable support to expose the R-Car VSP Compositor as KMS planes.
diff --git a/drivers/gpu/drm/rz-du/Makefile b/drivers/gpu/drm/rz-du/Makefile
new file mode 100644
index 000000000000..2cdf3ccd0459
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+rzg2l-du-drm-y := rzg2l_du_crtc.o \
+		  rzg2l_du_drv.o \
+		  rzg2l_du_encoder.o \
+		  rzg2l_du_kms.o \
+
+rzg2l-du-drm-$(CONFIG_DRM_RCAR_VSP)	+= rzg2l_du_vsp.o
+obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
new file mode 100644
index 000000000000..113fd6bc4d90
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit CRTCs
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_crtc.c
+ */
+
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drm_vblank.h>
+
+#include "rzg2l_du_crtc.h"
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_encoder.h"
+#include "rzg2l_du_kms.h"
+#include "rzg2l_du_vsp.h"
+
+#define DU_MCR0			0x00
+#define DU_MCR0_DI_EN		BIT(8)
+
+#define DU_DITR0		0x10
+#define DU_DITR0_DEMD_HIGH	(BIT(8) | BIT(9))
+#define DU_DITR0_VSPOL		BIT(16)
+#define DU_DITR0_HSPOL		BIT(17)
+
+#define DU_DITR1		0x14
+#define DU_DITR1_VSA(x)		((x) << 0)
+#define DU_DITR1_VACTIVE(x)	((x) << 16)
+
+#define DU_DITR2		0x18
+#define DU_DITR2_VBP(x)		((x) << 0)
+#define DU_DITR2_VFP(x)		((x) << 16)
+
+#define DU_DITR3		0x1c
+#define DU_DITR3_HSA(x)		((x) << 0)
+#define DU_DITR3_HACTIVE(x)	((x) << 16)
+
+#define DU_DITR4		0x20
+#define DU_DITR4_HBP(x)		((x) << 0)
+#define DU_DITR4_HFP(x)		((x) << 16)
+
+#define DU_MCR1			0x40
+#define DU_MCR1_PB_AUTOCLR	BIT(16)
+
+#define DU_PBCR0		0x4c
+#define DU_PBCR0_PB_DEP(x)	((x) << 0)
+
+/* -----------------------------------------------------------------------------
+ * Hardware Setup
+ */
+
+static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
+{
+	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
+	unsigned long mode_clock = mode->clock * 1000;
+	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
+	struct rzg2l_du_device *rcdu = rcrtc->dev;
+
+	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
+	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
+
+	ditr0 = (DU_DITR0_DEMD_HIGH
+	      | ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DU_DITR0_VSPOL : 0)
+	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DU_DITR0_HSPOL : 0));
+
+	ditr1 = DU_DITR1_VSA(mode->vsync_end - mode->vsync_start)
+	      | DU_DITR1_VACTIVE(mode->vdisplay);
+
+	ditr2 = DU_DITR2_VBP(mode->vtotal - mode->vsync_end)
+	      | DU_DITR2_VFP(mode->vsync_start - mode->vdisplay);
+
+	ditr3 = DU_DITR3_HSA(mode->hsync_end - mode->hsync_start)
+	      | DU_DITR3_HACTIVE(mode->hdisplay);
+
+	ditr4 = DU_DITR4_HBP(mode->htotal - mode->hsync_end)
+	      | DU_DITR4_HFP(mode->hsync_start - mode->hdisplay);
+
+	pbcr0 = DU_PBCR0_PB_DEP(0x1f);
+
+	writel(ditr0, rcdu->mmio + DU_DITR0);
+	writel(ditr1, rcdu->mmio + DU_DITR1);
+	writel(ditr2, rcdu->mmio + DU_DITR2);
+	writel(ditr3, rcdu->mmio + DU_DITR3);
+	writel(ditr4, rcdu->mmio + DU_DITR4);
+	writel(pbcr0, rcdu->mmio + DU_PBCR0);
+
+	/* Enable auto clear */
+	writel(DU_MCR1_PB_AUTOCLR, rcdu->mmio + DU_MCR1);
+}
+
+/* -----------------------------------------------------------------------------
+ * Page Flip
+ */
+
+void rzg2l_du_crtc_finish_page_flip(struct rzg2l_du_crtc *rcrtc)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	event = rcrtc->event;
+	rcrtc->event = NULL;
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	if (!event)
+		return;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	drm_crtc_send_vblank_event(&rcrtc->crtc, event);
+	wake_up(&rcrtc->flip_wait);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	drm_crtc_vblank_put(&rcrtc->crtc);
+}
+
+static bool rzg2l_du_crtc_page_flip_pending(struct rzg2l_du_crtc *rcrtc)
+{
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+	bool pending;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	pending = rcrtc->event;
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	return pending;
+}
+
+static void rzg2l_du_crtc_wait_page_flip(struct rzg2l_du_crtc *rcrtc)
+{
+	struct rzg2l_du_device *rcdu = rcrtc->dev;
+
+	if (wait_event_timeout(rcrtc->flip_wait,
+			       !rzg2l_du_crtc_page_flip_pending(rcrtc),
+			       msecs_to_jiffies(50)))
+		return;
+
+	dev_warn(rcdu->dev, "page flip timeout\n");
+
+	rzg2l_du_crtc_finish_page_flip(rcrtc);
+}
+
+/* -----------------------------------------------------------------------------
+ * Start/Stop and Suspend/Resume
+ */
+
+static void rzg2l_du_crtc_setup(struct rzg2l_du_crtc *rcrtc)
+{
+	/* Configure display timings and output routing */
+	rzg2l_du_crtc_set_display_timing(rcrtc);
+
+	/* Enable the VSP compositor. */
+	rzg2l_du_vsp_enable(rcrtc);
+
+	/* Turn vertical blanking interrupt reporting on. */
+	drm_crtc_vblank_on(&rcrtc->crtc);
+}
+
+static int rzg2l_du_crtc_get(struct rzg2l_du_crtc *rcrtc)
+{
+	int ret;
+
+	/*
+	 * Guard against double-get, as the function is called from both the
+	 * .atomic_enable() and .atomic_flush() handlers.
+	 */
+	if (rcrtc->initialized)
+		return 0;
+
+	ret = clk_prepare_enable(rcrtc->rzg2l_clocks.aclk);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(rcrtc->rzg2l_clocks.pclk);
+	if (ret < 0)
+		goto error_bus_clock;
+
+	ret = reset_control_deassert(rcrtc->rstc);
+	if (ret < 0)
+		goto error_peri_clock;
+
+	rzg2l_du_crtc_setup(rcrtc);
+	rcrtc->initialized = true;
+
+	return 0;
+
+error_peri_clock:
+	clk_disable_unprepare(rcrtc->rzg2l_clocks.pclk);
+error_bus_clock:
+	clk_disable_unprepare(rcrtc->rzg2l_clocks.aclk);
+	return ret;
+}
+
+static void rzg2l_du_crtc_put(struct rzg2l_du_crtc *rcrtc)
+{
+	clk_disable_unprepare(rcrtc->rzg2l_clocks.dclk);
+	reset_control_assert(rcrtc->rstc);
+	clk_disable_unprepare(rcrtc->rzg2l_clocks.pclk);
+	clk_disable_unprepare(rcrtc->rzg2l_clocks.aclk);
+
+	rcrtc->initialized = false;
+}
+
+static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
+{
+	struct rzg2l_du_device *rcdu = rcrtc->dev;
+
+	writel(start ? DU_MCR0_DI_EN : 0, rcdu->mmio + DU_MCR0);
+}
+
+static void rzg2l_du_crtc_start(struct rzg2l_du_crtc *rcrtc)
+{
+	rzg2l_du_start_stop(rcrtc, true);
+}
+
+static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
+{
+	struct drm_crtc *crtc = &rcrtc->crtc;
+
+	/*
+	 * Disable vertical blanking interrupt reporting. We first need to wait
+	 * for page flip completion before stopping the CRTC as userspace
+	 * expects page flips to eventually complete.
+	 */
+	rzg2l_du_crtc_wait_page_flip(rcrtc);
+	drm_crtc_vblank_off(crtc);
+
+	/* Disable the VSP compositor. */
+	rzg2l_du_vsp_disable(rcrtc);
+
+	rzg2l_du_start_stop(rcrtc, false);
+}
+
+/* -----------------------------------------------------------------------------
+ * CRTC Functions
+ */
+
+static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
+					struct drm_crtc_state *old_state)
+{
+	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
+
+	rzg2l_du_crtc_get(rcrtc);
+
+	rzg2l_du_crtc_start(rcrtc);
+}
+
+static void rzg2l_du_crtc_atomic_disable(struct drm_crtc *crtc,
+					 struct drm_crtc_state *old_state)
+{
+	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
+
+	rzg2l_du_crtc_stop(rcrtc);
+	rzg2l_du_crtc_put(rcrtc);
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+}
+
+static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,
+				       struct drm_crtc_state *old_crtc_state)
+{
+	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+
+	WARN_ON(!crtc->state->enable);
+
+	/*
+	 * If a mode set is in progress we can be called with the CRTC disabled.
+	 * We thus need to first get and setup the CRTC in order to configure
+	 * planes. We must *not* put the CRTC, as it must be kept awake until
+	 * the .atomic_enable() call that will follow. The get operation in
+	 * .atomic_enable() will in that case be a no-op, and the CRTC will be
+	 * put later in .atomic_disable().
+	 */
+	rzg2l_du_crtc_get(rcrtc);
+
+	if (crtc->state->event) {
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		rcrtc->event = crtc->state->event;
+		crtc->state->event = NULL;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
+
+	rzg2l_du_vsp_atomic_flush(rcrtc);
+}
+
+static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
+	.atomic_flush = rzg2l_du_crtc_atomic_flush,
+	.atomic_enable = rzg2l_du_crtc_atomic_enable,
+	.atomic_disable = rzg2l_du_crtc_atomic_disable,
+};
+
+static struct drm_crtc_state *
+rzg2l_du_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct rzg2l_du_crtc_state *state;
+	struct rzg2l_du_crtc_state *copy;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	state = to_rzg2l_crtc_state(crtc->state);
+	copy = kmemdup(state, sizeof(*state), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &copy->state);
+
+	return &copy->state;
+}
+
+static void rzg2l_du_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					       struct drm_crtc_state *state)
+{
+	__drm_atomic_helper_crtc_destroy_state(state);
+	kfree(to_rzg2l_crtc_state(state));
+}
+
+static void rzg2l_du_crtc_reset(struct drm_crtc *crtc)
+{
+	struct rzg2l_du_crtc_state *state;
+
+	if (crtc->state) {
+		rzg2l_du_crtc_atomic_destroy_state(crtc, crtc->state);
+		crtc->state = NULL;
+	}
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	__drm_atomic_helper_crtc_reset(crtc, &state->state);
+}
+
+static int rzg2l_du_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
+
+	rcrtc->vblank_enable = true;
+
+	return 0;
+}
+
+static void rzg2l_du_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
+
+	rcrtc->vblank_enable = false;
+}
+
+static const struct drm_crtc_funcs crtc_funcs_rz = {
+	.reset = rzg2l_du_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = rzg2l_du_crtc_atomic_duplicate_state,
+	.atomic_destroy_state = rzg2l_du_crtc_atomic_destroy_state,
+	.enable_vblank = rzg2l_du_crtc_enable_vblank,
+	.disable_vblank = rzg2l_du_crtc_disable_vblank,
+};
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
+int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
+{
+	struct rzg2l_du_crtc *rcrtc = &rcdu->crtcs[0];
+	struct drm_crtc *crtc = &rcrtc->crtc;
+	struct drm_plane *primary;
+	int ret;
+
+	rcrtc->rstc = devm_reset_control_get_shared(rcdu->dev, NULL);
+	if (IS_ERR(rcrtc->rstc)) {
+		dev_err(rcdu->dev, "can't get cpg reset\n");
+		return PTR_ERR(rcrtc->rstc);
+	}
+
+	rcrtc->rzg2l_clocks.aclk = devm_clk_get(rcdu->dev, "aclk");
+	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
+		dev_err(rcdu->dev, "no axi clock for DU\n");
+		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
+	}
+
+	rcrtc->rzg2l_clocks.pclk = devm_clk_get(rcdu->dev, "pclk");
+	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
+		dev_err(rcdu->dev, "no peripheral clock for DU\n");
+		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
+	}
+
+	rcrtc->rzg2l_clocks.dclk = devm_clk_get(rcdu->dev, "vclk");
+	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
+		dev_err(rcdu->dev, "no video clock for DU\n");
+		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
+	}
+
+	init_waitqueue_head(&rcrtc->flip_wait);
+	rcrtc->dev = rcdu;
+
+	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe].plane;
+
+	ret = drm_crtc_init_with_planes(rcdu->ddev, crtc, primary, NULL,
+					&crtc_funcs_rz, NULL);
+	if (ret < 0)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_crtc.h b/drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
new file mode 100644
index 000000000000..637ae182c4a6
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L Display Unit CRTCs
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_crtc.h
+ */
+
+#ifndef __RZG2L_DU_CRTC_H__
+#define __RZG2L_DU_CRTC_H__
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_writeback.h>
+
+#include <media/vsp1.h>
+
+struct clk;
+struct reset_control;
+struct rzg2l_du_vsp;
+struct rzg2l_du_format_info;
+
+/**
+ * struct rzg2l_du_crtc - the CRTC, representing a DU superposition processor
+ * @crtc: base DRM CRTC
+ * @dev: the DU device
+ * @initialized: whether the CRTC has been initialized and clocks enabled
+ * @vblank_enable: whether vblank events are enabled on this CRTC
+ * @event: event to post when the pending page flip completes
+ * @flip_wait: wait queue used to signal page flip completion
+ * @vsp: VSP feeding video to this CRTC
+ * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
+ * @rstc: reset controller
+ * @rzg2l_clocks: the bus, main and video clock
+ */
+struct rzg2l_du_crtc {
+	struct drm_crtc crtc;
+
+	struct rzg2l_du_device *dev;
+	bool initialized;
+
+	bool vblank_enable;
+	struct drm_pending_vblank_event *event;
+	wait_queue_head_t flip_wait;
+
+	struct rzg2l_du_vsp *vsp;
+	unsigned int vsp_pipe;
+
+	const char *const *sources;
+	unsigned int sources_count;
+
+	struct reset_control *rstc;
+	struct {
+		struct clk *aclk;
+		struct clk *pclk;
+		struct clk *dclk;
+	} rzg2l_clocks;
+};
+
+static inline struct rzg2l_du_crtc *to_rzg2l_crtc(struct drm_crtc *c)
+{
+	return container_of(c, struct rzg2l_du_crtc, crtc);
+}
+
+/**
+ * struct rzg2l_du_crtc_state - Driver-specific CRTC state
+ * @state: base DRM CRTC state
+ * @crc: CRC computation configuration
+ * @outputs: bitmask of the outputs (enum rzg2l_du_output) driven by this CRTC
+ */
+struct rzg2l_du_crtc_state {
+	struct drm_crtc_state state;
+
+	struct vsp1_du_crc_config crc;
+	unsigned int outputs;
+};
+
+static inline struct rzg2l_du_crtc_state *to_rzg2l_crtc_state(struct drm_crtc_state *s)
+{
+	return container_of(s, struct rzg2l_du_crtc_state, state);
+}
+
+int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu);
+
+void rzg2l_du_crtc_finish_page_flip(struct rzg2l_du_crtc *rcrtc);
+
+#endif /* __RZG2L_DU_CRTC_H__ */
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/rz-du/rzg2l_du_drv.c
new file mode 100644
index 000000000000..f80830d68fb6
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_drv.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit DRM driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_drv.c
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_probe_helper.h>
+
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_kms.h"
+
+/* -----------------------------------------------------------------------------
+ * Device Information
+ */
+
+static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_crtcs = BIT(0),
+			.port = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(0),
+			.port = 1,
+		}
+	}
+};
+
+static const struct of_device_id rzg2l_du_of_table[] = {
+	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rzg2l_du_of_table);
+
+const char *rzg2l_du_output_name(enum rzg2l_du_output output)
+{
+	static const char * const names[] = {
+		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
+		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
+	};
+
+	if (output >= ARRAY_SIZE(names))
+		return "UNKNOWN";
+
+	return names[output];
+}
+
+/* -----------------------------------------------------------------------------
+ * DRM operations
+ */
+
+DEFINE_DRM_GEM_CMA_FOPS(rzg2l_du_fops);
+
+static const struct drm_driver rzg2l_du_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(rzg2l_du_dumb_create),
+	.fops			= &rzg2l_du_fops,
+	.name			= "rzg2l-du",
+	.desc			= "Renesas RZ/G2L Display Unit",
+	.date			= "20230410",
+	.major			= 1,
+	.minor			= 0,
+};
+
+/* -----------------------------------------------------------------------------
+ * Platform driver
+ */
+
+static int rzg2l_du_remove(struct platform_device *pdev)
+{
+	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
+	struct drm_device *ddev = rcdu->ddev;
+
+	drm_dev_unregister(ddev);
+	drm_atomic_helper_shutdown(ddev);
+
+	drm_kms_helper_poll_fini(ddev);
+
+	return 0;
+}
+
+static void rzg2l_du_shutdown(struct platform_device *pdev)
+{
+	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(rcdu->ddev);
+}
+
+static int rzg2l_du_probe(struct platform_device *pdev)
+{
+	struct rzg2l_du_device *rcdu;
+	struct drm_device *ddev;
+	int ret;
+
+	/* Allocate and initialize the RZ/G2L device structure. */
+	rcdu = devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
+	if (rcdu == NULL)
+		return -ENOMEM;
+
+	rcdu->dev = &pdev->dev;
+	rcdu->info = of_device_get_match_data(rcdu->dev);
+
+	platform_set_drvdata(pdev, rcdu);
+
+	/* I/O resources */
+	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rcdu->mmio))
+		return PTR_ERR(rcdu->mmio);
+
+	/*
+	 * When sourcing frames from a VSP the DU doesn't perform any memory
+	 * access so set the DMA coherent mask to 40 bits to accept all buffers.
+	 */
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
+
+	/* DRM/KMS objects */
+	ddev = drm_dev_alloc(&rzg2l_du_driver, &pdev->dev);
+	if (IS_ERR(ddev))
+		return PTR_ERR(ddev);
+
+	rcdu->ddev = ddev;
+	ddev->dev_private = rcdu;
+
+	ret = rzg2l_du_modeset_init(rcdu);
+	if (ret < 0) {
+		/*
+		 * Don't use dev_err_probe(), as it would overwrite the probe
+		 * deferral reason recorded in rzg2l_du_modeset_init().
+		 */
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to initialize DRM/KMS (%d)\n", ret);
+		goto error;
+	}
+
+	ddev->irq_enabled = 1;
+	/*
+	 * Register the DRM device with the core and the connectors with
+	 * sysfs.
+	 */
+	ret = drm_dev_register(ddev, 0);
+	if (ret)
+		goto error;
+
+	DRM_INFO("Device %s probed\n", dev_name(&pdev->dev));
+
+	drm_fbdev_generic_setup(ddev, 32);
+
+	return 0;
+
+error:
+	drm_kms_helper_poll_fini(rcdu->ddev);
+	return ret;
+}
+
+static struct platform_driver rzg2l_du_platform_driver = {
+	.probe		= rzg2l_du_probe,
+	.remove	= rzg2l_du_remove,
+	.shutdown	= rzg2l_du_shutdown,
+	.driver		= {
+		.name	= "rzg2l-du",
+		.of_match_table = rzg2l_du_of_table,
+	},
+};
+
+module_platform_driver(rzg2l_du_platform_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L Display Unit DRM Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/rz-du/rzg2l_du_drv.h
new file mode 100644
index 000000000000..c02fe37f2457
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_drv.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L Display Unit DRM driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_drv.h
+ */
+
+#ifndef __RZG2L_DU_DRV_H__
+#define __RZG2L_DU_DRV_H__
+
+#include <linux/kernel.h>
+
+#include <drm/drm_device.h>
+
+#include "rzg2l_du_crtc.h"
+#include "rzg2l_du_vsp.h"
+
+struct device;
+struct drm_bridge;
+struct drm_property;
+
+enum rzg2l_du_output {
+	RZG2L_DU_OUTPUT_DSI0,
+	RZG2L_DU_OUTPUT_DPAD0,
+	RZG2L_DU_OUTPUT_MAX,
+};
+
+/*
+ * struct rzg2l_du_output_routing - Output routing specification
+ * @possible_crtcs: bitmask of possible CRTCs for the output
+ * @port: device tree port number corresponding to this output route
+ *
+ * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
+ * specify the valid SoC outputs, which CRTCs can drive the output, and the type
+ * of in-SoC encoder for the output.
+ */
+struct rzg2l_du_output_routing {
+	unsigned int possible_crtcs;
+	unsigned int port;
+};
+
+/*
+ * struct rzg2l_du_device_info - DU model-specific information
+ * @channels_mask: bit mask of available DU channels
+ * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
+ */
+struct rzg2l_du_device_info {
+	unsigned int channels_mask;
+	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
+};
+
+#define RZG2L_DU_MAX_CRTCS		1
+#define RZG2L_DU_MAX_VSPS		1
+#define RZG2L_DU_MAX_DSI		1
+
+struct rzg2l_du_device {
+	struct device *dev;
+	const struct rzg2l_du_device_info *info;
+
+	void __iomem *mmio;
+
+	struct drm_device *ddev;
+
+	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
+	unsigned int num_crtcs;
+
+	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];
+	struct drm_bridge *dsi[RZG2L_DU_MAX_DSI];
+
+	struct {
+		struct drm_property *colorkey;
+	} props;
+
+};
+
+static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
+{
+	return container_of(dev, struct rzg2l_du_device, ddev);
+}
+
+const char *rzg2l_du_output_name(enum rzg2l_du_output output);
+
+#endif /* __RZG2L_DU_DRV_H__ */
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
new file mode 100644
index 000000000000..37e3f2e46516
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit Encoder
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_encoder.c
+ */
+
+#include <linux/export.h>
+#include <linux/of.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_simple_kms_helper.h>
+
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_encoder.h"
+
+/* -----------------------------------------------------------------------------
+ * Encoder
+ */
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+};
+
+static unsigned int rzg2l_du_encoder_count_ports(struct device_node *node)
+{
+	struct device_node *ports;
+	struct device_node *port;
+	unsigned int num_ports = 0;
+
+	ports = of_get_child_by_name(node, "ports");
+	if (!ports)
+		ports = of_node_get(node);
+
+	for_each_child_of_node(ports, port) {
+		if (of_node_name_eq(port, "port"))
+			num_ports++;
+	}
+
+	of_node_put(ports);
+
+	return num_ports;
+}
+
+int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
+			  enum rzg2l_du_output output,
+			  struct device_node *enc_node)
+{
+	struct rzg2l_du_encoder *renc;
+	struct drm_encoder *encoder;
+	struct drm_bridge *bridge;
+	int ret;
+
+	renc = devm_kzalloc(rcdu->dev, sizeof(*renc), GFP_KERNEL);
+	if (renc == NULL)
+		return -ENOMEM;
+
+	renc->output = output;
+	encoder = rzg2l_encoder_to_drm_encoder(renc);
+
+	dev_err(rcdu->dev, "initializing encoder %pOF for output %u\n",
+		enc_node, output);
+
+	/*
+	 * Locate the DRM bridge from the DT node. For the DPAD outputs, if the
+	 * DT node has a single port, assume that it describes a panel and
+	 * create a panel bridge.
+	 */
+	if (output == RZG2L_DU_OUTPUT_DPAD0 &&
+	    rzg2l_du_encoder_count_ports(enc_node) == 1) {
+		struct drm_panel *panel = of_drm_find_panel(enc_node);
+
+		if (IS_ERR(panel))
+			return PTR_ERR(panel);
+
+		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
+							 DRM_MODE_CONNECTOR_DPI);
+		if (IS_ERR(bridge))
+			return PTR_ERR(bridge);
+	} else {
+		bridge = of_drm_find_bridge(enc_node);
+		if (!bridge)
+			return -EPROBE_DEFER;
+
+		if (output == RZG2L_DU_OUTPUT_DSI0)
+			rcdu->dsi[output - RZG2L_DU_OUTPUT_DSI0] = bridge;
+	}
+
+	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
+		enc_node, rzg2l_du_output_name(output));
+
+	ret = drm_simple_encoder_init(rcdu->ddev, encoder,
+				      DRM_MODE_ENCODER_NONE);
+	if (ret < 0)
+		goto done;
+
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+
+	/*
+	 * Attach the bridge to the encoder. The bridge will create the
+	 * connector.
+	 */
+	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
+	if (ret) {
+		drm_encoder_cleanup(encoder);
+		return ret;
+	}
+
+done:
+	if (ret < 0) {
+		if (encoder->name)
+			encoder->funcs->destroy(encoder);
+		devm_kfree(rcdu->dev, renc);
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
new file mode 100644
index 000000000000..04c870f1c09c
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L Display Unit Encoder
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_encoder.h
+ */
+
+#ifndef __RZG2L_DU_ENCODER_H__
+#define __RZG2L_DU_ENCODER_H__
+
+#include <drm/drm_encoder.h>
+
+struct rzg2l_du_device;
+
+struct rzg2l_du_encoder {
+	struct drm_encoder base;
+	enum rzg2l_du_output output;
+};
+
+static inline struct rzg2l_du_encoder *to_rzg2l_encoder(struct drm_encoder *e)
+{
+	return container_of(e, struct rzg2l_du_encoder, base);
+}
+
+#define rzg2l_encoder_to_drm_encoder(e)	(&(e)->base)
+
+int rzg2l_du_encoder_init(struct rzg2l_du_device *rcdu,
+			  enum rzg2l_du_output output,
+			  struct device_node *enc_node);
+
+#endif /* __RZG2L_DU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/rz-du/rzg2l_du_kms.c
new file mode 100644
index 000000000000..fab74f20969e
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_kms.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit Mode Setting
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_kms.c
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+
+#include <linux/device.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+
+#include "rzg2l_du_crtc.h"
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_encoder.h"
+#include "rzg2l_du_kms.h"
+#include "rzg2l_du_vsp.h"
+
+/* -----------------------------------------------------------------------------
+ * Format helpers
+ */
+
+static const struct rzg2l_du_format_info rzg2l_du_format_infos[] = {
+	{
+		.fourcc = DRM_FORMAT_XRGB8888,
+		.v4l2 = V4L2_PIX_FMT_XBGR32,
+		.bpp = 32,
+		.planes = 1,
+		.hsub = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ARGB8888,
+		.v4l2 = V4L2_PIX_FMT_ABGR32,
+		.bpp = 32,
+		.planes = 1,
+		.hsub = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGB888,
+		.v4l2 = V4L2_PIX_FMT_BGR24,
+		.bpp = 24,
+		.planes = 1,
+		.hsub = 1,
+	}
+};
+
+const struct rzg2l_du_format_info *rzg2l_du_format_info(u32 fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rzg2l_du_format_infos); ++i) {
+		if (rzg2l_du_format_infos[i].fourcc == fourcc)
+			return &rzg2l_du_format_infos[i];
+	}
+
+	return NULL;
+}
+
+/* -----------------------------------------------------------------------------
+ * Frame buffer
+ */
+
+int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
+			 struct drm_mode_create_dumb *args)
+{
+	unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	unsigned int align = 16 * args->bpp / 8;
+
+	args->pitch = roundup(min_pitch, align);
+
+	return drm_gem_cma_dumb_create_internal(file, dev, args);
+}
+
+static struct drm_framebuffer *
+rzg2l_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		   const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	const struct rzg2l_du_format_info *format;
+	unsigned int max_pitch;
+
+	format = rzg2l_du_format_info(mode_cmd->pixel_format);
+	if (!format) {
+		dev_dbg(dev->dev, "unsupported pixel format %p4cc\n",
+			&mode_cmd->pixel_format);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * On RZ/G2L the memory interface is handled by the VSP that limits the
+	 * pitch to 65535 bytes.
+	 */
+	max_pitch = 65535;
+	if (mode_cmd->pitches[0] > max_pitch) {
+		dev_dbg(dev->dev, "invalid pitch value %u\n",
+			mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return drm_gem_fb_create(dev, file_priv, mode_cmd);
+}
+
+/* -----------------------------------------------------------------------------
+ * Atomic Check and Update
+ */
+
+static void rzg2l_du_atomic_commit_tail(struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev = old_state->dev;
+
+	/* Apply the atomic update. */
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_commit_hw_done(old_state);
+	drm_atomic_helper_wait_for_flip_done(dev, old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
+static const struct drm_mode_config_helper_funcs rzg2l_du_mode_config_helper = {
+	.atomic_commit_tail = rzg2l_du_atomic_commit_tail,
+};
+
+static const struct drm_mode_config_funcs rzg2l_du_mode_config_funcs = {
+	.fb_create = rzg2l_du_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static int rzg2l_du_encoders_init_one(struct rzg2l_du_device *rcdu,
+				      enum rzg2l_du_output output,
+				      struct of_endpoint *ep)
+{
+	struct device_node *entity;
+	int ret;
+
+	/* Locate the connected entity and initialize the encoder. */
+	entity = of_graph_get_remote_port_parent(ep->local_node);
+	if (!entity) {
+		dev_dbg(rcdu->dev, "unconnected endpoint %pOF, skipping\n",
+			ep->local_node);
+		return -ENODEV;
+	}
+
+	if (!of_device_is_available(entity)) {
+		dev_dbg(rcdu->dev,
+			"connected entity %pOF is disabled, skipping\n",
+			entity);
+		of_node_put(entity);
+		return -ENODEV;
+	}
+
+	ret = rzg2l_du_encoder_init(rcdu, output, entity);
+	if (ret && ret != -EPROBE_DEFER && ret != -ENOLINK)
+		dev_warn(rcdu->dev,
+			 "failed to initialize encoder %pOF on output %s (%d), skipping\n",
+			 entity, rzg2l_du_output_name(output), ret);
+
+	of_node_put(entity);
+
+	return ret;
+}
+
+static int rzg2l_du_encoders_init(struct rzg2l_du_device *rcdu)
+{
+	struct device_node *np = rcdu->dev->of_node;
+	struct device_node *ep_node;
+	unsigned int num_encoders = 0;
+
+	/*
+	 * Iterate over the endpoints and create one encoder for each output
+	 * pipeline.
+	 */
+	for_each_endpoint_of_node(np, ep_node) {
+		enum rzg2l_du_output output;
+		struct of_endpoint ep;
+		unsigned int i;
+		int ret;
+
+		ret = of_graph_parse_endpoint(ep_node, &ep);
+		if (ret < 0) {
+			of_node_put(ep_node);
+			return ret;
+		}
+
+		/* Find the output route corresponding to the port number. */
+		for (i = 0; i < RZG2L_DU_OUTPUT_MAX; ++i) {
+			if (rcdu->info->routes[i].port == ep.port) {
+				output = i;
+				break;
+			}
+		}
+
+		if (i == RZG2L_DU_OUTPUT_MAX) {
+			dev_warn(rcdu->dev,
+				 "port %u references unexisting output, skipping\n",
+				 ep.port);
+			continue;
+		}
+
+		/* Process the output pipeline. */
+		ret = rzg2l_du_encoders_init_one(rcdu, output, &ep);
+		if (ret < 0) {
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(ep_node);
+				return ret;
+			}
+
+			continue;
+		}
+
+		num_encoders++;
+	}
+
+	return num_encoders;
+}
+
+static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
+{
+	const struct device_node *np = rcdu->dev->of_node;
+	const char *vsps_prop_name = "renesas,vsps";
+	struct of_phandle_args args;
+	struct {
+		struct device_node *np;
+		unsigned int crtcs_mask;
+	} vsps[RZG2L_DU_MAX_VSPS] = { { NULL, }, };
+	unsigned int vsps_count = 0;
+	unsigned int cells;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * First parse the DT vsps property to populate the list of VSPs. Each
+	 * entry contains a pointer to the VSP DT node and a bitmask of the
+	 * connected DU CRTCs.
+	 */
+	ret = of_property_count_u32_elems(np, vsps_prop_name);
+	cells = ret / rcdu->num_crtcs - 1;
+	if (cells != 1)
+		return -EINVAL;
+
+	for (i = 0; i < rcdu->num_crtcs; ++i) {
+		unsigned int j;
+
+		ret = of_parse_phandle_with_fixed_args(np, vsps_prop_name,
+						       cells, i, &args);
+		if (ret < 0)
+			goto done;
+
+		/*
+		 * Add the VSP to the list or update the corresponding existing
+		 * entry if the VSP has already been added.
+		 */
+		for (j = 0; j < vsps_count; ++j) {
+			if (vsps[j].np == args.np)
+				break;
+		}
+
+		if (j < vsps_count)
+			of_node_put(args.np);
+		else
+			vsps[vsps_count++].np = args.np;
+
+		vsps[j].crtcs_mask |= BIT(i);
+
+		/*
+		 * Store the VSP pointer and pipe index in the CRTC. If the
+		 * second cell of the 'renesas,vsps' specifier isn't present,
+		 * default to 0 to remain compatible with older DT bindings.
+		 */
+		rcdu->crtcs[i].vsp = &rcdu->vsps[j];
+		rcdu->crtcs[i].vsp_pipe = cells >= 1 ? args.args[0] : 0;
+	}
+
+	/*
+	 * Then initialize all the VSPs from the node pointers and CRTCs bitmask
+	 * computed previously.
+	 */
+	for (i = 0; i < vsps_count; ++i) {
+		struct rzg2l_du_vsp *vsp = &rcdu->vsps[i];
+
+		vsp->index = i;
+		vsp->dev = rcdu;
+
+		ret = rzg2l_du_vsp_init(vsp, vsps[i].np, vsps[i].crtcs_mask);
+		if (ret)
+			goto done;
+	}
+
+done:
+	for (i = 0; i < ARRAY_SIZE(vsps); ++i)
+		of_node_put(vsps[i].np);
+
+	return ret;
+}
+
+int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
+{
+	struct drm_device *dev = rcdu->ddev;
+	struct drm_encoder *encoder;
+	unsigned int num_encoders;
+	int ret;
+
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.normalize_zpos = true;
+	dev->mode_config.funcs = &rzg2l_du_mode_config_funcs;
+	dev->mode_config.helper_private = &rzg2l_du_mode_config_helper;
+
+	/*
+	 * The RZ DU uses the VSP1 for memory access, and is limited
+	 * to frame sizes of 1920x1080.
+	 */
+	dev->mode_config.max_width = 1920;
+	dev->mode_config.max_height = 1080;
+
+	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
+
+	/*
+	 * Initialize vertical blanking interrupts handling. Start with vblank
+	 * disabled for all CRTCs.
+	 */
+	ret = drm_vblank_init(dev, rcdu->num_crtcs);
+	if (ret < 0)
+		return ret;
+
+	/* Initialize the compositors. */
+	ret = rzg2l_du_vsps_init(rcdu);
+	if (ret < 0)
+		return ret;
+
+	/* Create the CRTCs. */
+	ret = rzg2l_du_crtc_create(rcdu);
+	if (ret < 0)
+		return ret;
+
+	/* Initialize the encoders. */
+	ret = rzg2l_du_encoders_init(rcdu);
+	if (ret < 0)
+		return dev_err_probe(rcdu->dev, ret,
+				     "failed to initialize encoders\n");
+
+	if (ret == 0) {
+		dev_err(rcdu->dev, "error: no encoder could be initialized\n");
+		return -EINVAL;
+	}
+
+	num_encoders = ret;
+
+	/*
+	 * Set the possible CRTCs and possible clones. There's always at least
+	 * one way for all encoders to clone each other, set all bits in the
+	 * possible clones field.
+	 */
+	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
+		struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+		const struct rzg2l_du_output_routing *route =
+			&rcdu->info->routes[renc->output];
+
+		encoder->possible_crtcs = route->possible_crtcs;
+		encoder->possible_clones = (1 << num_encoders) - 1;
+	}
+
+	drm_mode_config_reset(dev);
+
+	drm_kms_helper_poll_init(dev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_kms.h b/drivers/gpu/drm/rz-du/rzg2l_du_kms.h
new file mode 100644
index 000000000000..876e97cfbf45
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_kms.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L Display Unit Mode Setting
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_kms.h
+ */
+
+#ifndef __RZG2L_DU_KMS_H__
+#define __RZG2L_DU_KMS_H__
+
+#include <linux/types.h>
+
+struct dma_buf_attachment;
+struct drm_file;
+struct drm_device;
+struct drm_gem_object;
+struct drm_mode_create_dumb;
+struct rzg2l_du_device;
+struct sg_table;
+
+struct rzg2l_du_format_info {
+	u32 fourcc;
+	u32 v4l2;
+	unsigned int bpp;
+	unsigned int planes;
+	unsigned int hsub;
+};
+
+const struct rzg2l_du_format_info *rzg2l_du_format_info(u32 fourcc);
+
+int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu);
+
+int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
+			 struct drm_mode_create_dumb *args);
+
+struct drm_gem_object *
+rzg2l_du_gem_prime_import_sg_table(struct drm_device *dev,
+				   struct dma_buf_attachment *attach,
+				   struct sg_table *sgt);
+
+#endif /* __RZG2L_DU_KMS_H__ */
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_regs.h b/drivers/gpu/drm/rz-du/rzg2l_du_regs.h
new file mode 100644
index 000000000000..a0ca05abb5a8
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_regs.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RZ/G2L Display Unit Registers Definitions
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ */
+
+#ifndef __RZG2L_DU_REGS_H__
+#define __RZG2L_DU_REGS_H__
+
+/* -----------------------------------------------------------------------------
+ * Display Control Registers
+ */
+
+#define DU_MCR0			0x00
+#define DU_MCR0_DPI_OE		BIT(0)
+#define DU_MCR0_DI_EN		BIT(8)
+#define DU_MCR0_PB_CLR		BIT(16)
+
+#define DU_MSR0			0x04
+#define DU_MSR0_ST_DI_BSY	BIT(8)
+#define DU_MSR0_ST_PB_WFULL	BIT(16)
+#define DU_MSR0_ST_PB_WINIT	BIT(18)
+#define DU_MSR0_ST_PB_REMPTY	BIT(20)
+#define DU_MSR0_ST_PB_RUF	BIT(21)
+#define DU_MSR0_ST_PB_RINIT	BIT(22)
+
+#define DU_MSR1			0x08
+
+#define DU_IMR0			0x0c
+#define DU_MSR0_IM_PB_RUF	BIT(0)
+
+#define DU_DITR0		0x10
+#define DU_DITR0_DPI_CLKMD	BIT(0)
+#define DU_DITR0_DEMD_LOW	0x0
+#define DU_DITR0_DEMD_HIGH	(BIT(8) | BIT(9))
+#define DU_DITR0_VSPOL		BIT(16)
+#define DU_DITR0_HSPOL		BIT(17)
+
+#define DU_DITR1		0x14
+#define DU_DITR1_VSA(x)		((x) << 0)
+#define DU_DITR1_VACTIVE(x)	((x) << 16)
+
+#define DU_DITR2		0x18
+#define DU_DITR2_VBP(x)		((x) << 0)
+#define DU_DITR2_VFP(x)		((x) << 16)
+
+#define DU_DITR3		0x1c
+#define DU_DITR3_HSA(x)		((x) << 0)
+#define DU_DITR3_HACTIVE(x)	((x) << 16)
+
+#define DU_DITR4		0x20
+#define DU_DITR4_HBP(x)		((x) << 0)
+#define DU_DITR4_HFP(x)		((x) << 16)
+
+#define DU_DITR5		0x24
+#define DU_DITR5_VSFT(x)	((x) << 0)
+#define DU_DITR5_HSFT(x)	((x) << 16)
+
+#define DU_MCR1			0x40
+#define DU_MCR1_PB_AUTOCLR	BIT(16)
+
+#define DU_PBCR0		0x4c
+#define DU_PBCR0_PB_DEP(x)	((x) << 0)
+
+#endif /* __RZG2L_DU_REGS_H__ */
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
new file mode 100644
index 000000000000..ced080f5267e
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit VSP-Based Compositor
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_vsp.c
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_plane_helper.h>
+
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_platform.h>
+#include <linux/scatterlist.h>
+#include <linux/videodev2.h>
+
+#include <media/vsp1.h>
+
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_kms.h"
+#include "rzg2l_du_vsp.h"
+
+static void rzg2l_du_vsp_complete(void *private, unsigned int status, u32 crc)
+{
+	struct rzg2l_du_crtc *crtc = private;
+
+	if (crtc->vblank_enable)
+		drm_crtc_handle_vblank(&crtc->crtc);
+
+	if (status & VSP1_DU_STATUS_COMPLETE)
+		rzg2l_du_crtc_finish_page_flip(crtc);
+
+	drm_crtc_add_crc_entry(&crtc->crtc, false, 0, &crc);
+}
+
+void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc)
+{
+	const struct drm_display_mode *mode = &crtc->crtc.state->adjusted_mode;
+	struct vsp1_du_lif_config cfg = {
+		.width = mode->hdisplay,
+		.height = mode->vdisplay,
+		.interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE,
+		.callback = rzg2l_du_vsp_complete,
+		.callback_data = crtc,
+	};
+
+	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
+}
+
+void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc)
+{
+	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
+}
+
+void rzg2l_du_vsp_atomic_begin(struct rzg2l_du_crtc *crtc)
+{
+	vsp1_du_atomic_begin(crtc->vsp->vsp, crtc->vsp_pipe);
+}
+
+void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
+{
+	struct vsp1_du_atomic_pipe_config cfg = { { 0, } };
+	struct rzg2l_du_crtc_state *state;
+
+	state = to_rzg2l_crtc_state(crtc->crtc.state);
+
+	vsp1_du_atomic_flush(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
+}
+
+static const u32 rzg2l_du_vsp_formats[] = {
+	DRM_FORMAT_RGB332,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_XRGB4444,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU444,
+};
+
+static void rzg2l_du_vsp_plane_setup(struct rzg2l_du_vsp_plane *plane)
+{
+	struct rzg2l_du_vsp_plane_state *state =
+		to_rzg2l_vsp_plane_state(plane->plane.state);
+	struct rzg2l_du_crtc *crtc = to_rzg2l_crtc(state->state.crtc);
+	struct drm_framebuffer *fb = plane->plane.state->fb;
+	const struct rzg2l_du_format_info *format;
+	struct vsp1_du_atomic_config cfg = {
+		.pixelformat = 0,
+		.pitch = fb->pitches[0],
+		.alpha = state->state.alpha >> 8,
+		.zpos = state->state.zpos,
+	};
+	u32 fourcc = state->format->fourcc;
+	unsigned int i;
+
+	cfg.src.left = state->state.src.x1 >> 16;
+	cfg.src.top = state->state.src.y1 >> 16;
+	cfg.src.width = drm_rect_width(&state->state.src) >> 16;
+	cfg.src.height = drm_rect_height(&state->state.src) >> 16;
+
+	cfg.dst.left = state->state.dst.x1;
+	cfg.dst.top = state->state.dst.y1;
+	cfg.dst.width = drm_rect_width(&state->state.dst);
+	cfg.dst.height = drm_rect_height(&state->state.dst);
+
+	for (i = 0; i < state->format->planes; ++i)
+		cfg.mem[i] = sg_dma_address(state->sg_tables[i].sgl)
+			   + fb->offsets[i];
+
+	if (state->state.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE) {
+		switch (fourcc) {
+		case DRM_FORMAT_ARGB1555:
+			fourcc = DRM_FORMAT_XRGB1555;
+			break;
+
+		case DRM_FORMAT_ARGB4444:
+			fourcc = DRM_FORMAT_XRGB4444;
+			break;
+
+		case DRM_FORMAT_ARGB8888:
+			fourcc = DRM_FORMAT_XRGB8888;
+			break;
+		}
+	}
+
+	format = rzg2l_du_format_info(fourcc);
+	cfg.pixelformat = format->v4l2;
+
+	vsp1_du_atomic_update(plane->vsp->vsp, crtc->vsp_pipe,
+			      plane->index, &cfg);
+}
+
+int rzg2l_du_vsp_map_fb(struct rzg2l_du_vsp *vsp, struct drm_framebuffer *fb,
+			struct sg_table sg_tables[3])
+{
+	struct rzg2l_du_device *rcdu = vsp->dev;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < fb->format->num_planes; ++i) {
+		struct drm_gem_cma_object *gem = drm_fb_cma_get_gem_obj(fb, i);
+		struct sg_table *sgt = &sg_tables[i];
+
+		ret = dma_get_sgtable(rcdu->dev, sgt, gem->vaddr, gem->paddr,
+				      gem->base.size);
+		if (ret)
+			goto fail;
+
+		ret = vsp1_du_map_sg(vsp->vsp, sgt);
+		if (ret) {
+			sg_free_table(sgt);
+			goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	while (i--) {
+		struct sg_table *sgt = &sg_tables[i];
+
+		vsp1_du_unmap_sg(vsp->vsp, sgt);
+		sg_free_table(sgt);
+	}
+
+	return ret;
+}
+
+static int rzg2l_du_vsp_plane_prepare_fb(struct drm_plane *plane,
+					 struct drm_plane_state *state)
+{
+	struct rzg2l_du_vsp_plane_state *rstate = to_rzg2l_vsp_plane_state(state);
+	struct rzg2l_du_vsp *vsp = to_rzg2l_vsp_plane(plane)->vsp;
+	int ret;
+
+	/*
+	 * There's no need to prepare (and unprepare) the framebuffer when the
+	 * plane is not visible, as it will not be displayed.
+	 */
+	if (!state->visible)
+		return 0;
+
+	ret = rzg2l_du_vsp_map_fb(vsp, state->fb, rstate->sg_tables);
+	if (ret < 0)
+		return ret;
+
+	return drm_gem_fb_prepare_fb(plane, state);
+}
+
+void rzg2l_du_vsp_unmap_fb(struct rzg2l_du_vsp *vsp, struct drm_framebuffer *fb,
+			   struct sg_table sg_tables[3])
+{
+	unsigned int i;
+
+	for (i = 0; i < fb->format->num_planes; ++i) {
+		struct sg_table *sgt = &sg_tables[i];
+
+		vsp1_du_unmap_sg(vsp->vsp, sgt);
+		sg_free_table(sgt);
+	}
+}
+
+static void rzg2l_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	struct rzg2l_du_vsp_plane_state *rstate = to_rzg2l_vsp_plane_state(state);
+	struct rzg2l_du_vsp *vsp = to_rzg2l_vsp_plane(plane)->vsp;
+
+	if (!state->visible)
+		return;
+
+	rzg2l_du_vsp_unmap_fb(vsp, state->fb, rstate->sg_tables);
+}
+
+static int __rzg2l_du_vsp_plane_atomic_check(struct drm_plane *plane,
+					     struct drm_plane_state *state,
+					     const struct rzg2l_du_format_info **format)
+{
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	if (!state->crtc) {
+		/*
+		 * The visible field is not reset by the DRM core but only
+		 * updated by drm_atomic_helper_check_plane_state, set it
+		 * manually.
+		 */
+		state->visible = false;
+		*format = NULL;
+		return 0;
+	}
+
+	crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
+	ret = drm_atomic_helper_check_plane_state(state, crtc_state,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  true, true);
+	if (ret < 0)
+		return ret;
+
+	if (!state->visible) {
+		*format = NULL;
+		return 0;
+	}
+
+	*format = rzg2l_du_format_info(state->fb->format->format);
+
+	return 0;
+}
+
+static int rzg2l_du_vsp_plane_atomic_check(struct drm_plane *plane,
+					   struct drm_plane_state *state)
+{
+	struct rzg2l_du_vsp_plane_state *rstate = to_rzg2l_vsp_plane_state(state);
+
+	return __rzg2l_du_vsp_plane_atomic_check(plane, state, &rstate->format);
+}
+
+static void rzg2l_du_vsp_plane_atomic_update(struct drm_plane *plane,
+					     struct drm_plane_state *old_state)
+{
+	struct rzg2l_du_vsp_plane *rplane = to_rzg2l_vsp_plane(plane);
+	struct rzg2l_du_crtc *crtc = to_rzg2l_crtc(old_state->crtc);
+
+	if (plane->state->visible)
+		rzg2l_du_vsp_plane_setup(rplane);
+	else if (old_state->crtc)
+		vsp1_du_atomic_update(rplane->vsp->vsp, crtc->vsp_pipe,
+				      rplane->index, NULL);
+}
+
+static const struct drm_plane_helper_funcs rzg2l_du_vsp_plane_helper_funcs = {
+	.prepare_fb = rzg2l_du_vsp_plane_prepare_fb,
+	.cleanup_fb = rzg2l_du_vsp_plane_cleanup_fb,
+	.atomic_check = rzg2l_du_vsp_plane_atomic_check,
+	.atomic_update = rzg2l_du_vsp_plane_atomic_update,
+};
+
+static struct drm_plane_state *
+rzg2l_du_vsp_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct rzg2l_du_vsp_plane_state *copy;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	copy = kzalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
+
+	return &copy->state;
+}
+
+static void rzg2l_du_vsp_plane_atomic_destroy_state(struct drm_plane *plane,
+						    struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(to_rzg2l_vsp_plane_state(state));
+}
+
+static void rzg2l_du_vsp_plane_reset(struct drm_plane *plane)
+{
+	struct rzg2l_du_vsp_plane_state *state;
+
+	if (plane->state) {
+		rzg2l_du_vsp_plane_atomic_destroy_state(plane, plane->state);
+		plane->state = NULL;
+	}
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	__drm_atomic_helper_plane_reset(plane, &state->state);
+	state->state.zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
+}
+
+static const struct drm_plane_funcs rzg2l_du_vsp_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.reset = rzg2l_du_vsp_plane_reset,
+	.destroy = drm_plane_cleanup,
+	.atomic_duplicate_state = rzg2l_du_vsp_plane_atomic_duplicate_state,
+	.atomic_destroy_state = rzg2l_du_vsp_plane_atomic_destroy_state,
+};
+
+static void rzg2l_du_vsp_cleanup(struct drm_device *dev, void *res)
+{
+	struct rzg2l_du_vsp *vsp = res;
+	unsigned int i;
+
+	for (i = 0; i < vsp->num_planes; ++i) {
+		struct rzg2l_du_vsp_plane *plane = &vsp->planes[i];
+
+		drm_plane_cleanup(&plane->plane);
+	}
+
+	kfree(vsp->planes);
+
+	put_device(vsp->vsp);
+}
+
+int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
+		      unsigned int crtcs)
+{
+	struct rzg2l_du_device *rcdu = vsp->dev;
+	struct platform_device *pdev;
+	unsigned int num_crtcs = hweight32(crtcs);
+	unsigned int num_planes = 2;
+	unsigned int i;
+	int ret;
+
+	/* Find the VSP device and initialize it. */
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return -ENXIO;
+
+	vsp->vsp = &pdev->dev;
+
+	ret = drmm_add_action_or_reset(rcdu->ddev, rzg2l_du_vsp_cleanup, vsp);
+	if (ret < 0)
+		return ret;
+
+	ret = vsp1_du_init(vsp->vsp);
+	if (ret < 0)
+		return ret;
+
+	vsp->planes = kcalloc(num_planes, sizeof(*vsp->planes), GFP_KERNEL);
+	if (!vsp->planes)
+		return -ENOMEM;
+
+	for (i = 0; i < num_planes; ++i) {
+		enum drm_plane_type type = i < num_crtcs
+					 ? DRM_PLANE_TYPE_PRIMARY
+					 : DRM_PLANE_TYPE_OVERLAY;
+		struct rzg2l_du_vsp_plane *plane = &vsp->planes[i];
+
+		plane->vsp = vsp;
+		plane->index = i;
+		ret = drm_universal_plane_init(rcdu->ddev, &plane->plane,
+					       crtcs, &rzg2l_du_vsp_plane_funcs,
+					       rzg2l_du_vsp_formats,
+					       ARRAY_SIZE(rzg2l_du_vsp_formats),
+					       NULL, type, NULL);
+		if (ret < 0)
+			return ret;
+
+		drm_plane_helper_add(&plane->plane,
+				     &rzg2l_du_vsp_plane_helper_funcs);
+
+		vsp->num_planes++;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/rz-du/rzg2l_du_vsp.h
new file mode 100644
index 000000000000..591dc06cd928
--- /dev/null
+++ b/drivers/gpu/drm/rz-du/rzg2l_du_vsp.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RZ/G2L Display Unit VSP-Based Compositor
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Based on rcar_du_vsp.h
+ */
+
+#ifndef __RZG2L_DU_VSP_H__
+#define __RZG2L_DU_VSP_H__
+
+#include <drm/drm_plane.h>
+#include <linux/scatterlist.h>
+
+struct device;
+struct drm_framebuffer;
+struct rzg2l_du_device;
+struct rzg2l_du_format_info;
+struct rzg2l_du_vsp;
+
+struct rzg2l_du_vsp_plane {
+	struct drm_plane plane;
+	struct rzg2l_du_vsp *vsp;
+	unsigned int index;
+};
+
+struct rzg2l_du_vsp {
+	unsigned int index;
+	struct device *vsp;
+	struct rzg2l_du_device *dev;
+	struct rzg2l_du_vsp_plane *planes;
+	unsigned int num_planes;
+};
+
+static inline struct rzg2l_du_vsp_plane *to_rzg2l_vsp_plane(struct drm_plane *p)
+{
+	return container_of(p, struct rzg2l_du_vsp_plane, plane);
+}
+
+/**
+ * struct rzg2l_du_vsp_plane_state - Driver-specific plane state
+ * @state: base DRM plane state
+ * @format: information about the pixel format used by the plane
+ * @sg_tables: scatter-gather tables for the frame buffer memory
+ */
+struct rzg2l_du_vsp_plane_state {
+	struct drm_plane_state state;
+
+	const struct rzg2l_du_format_info *format;
+	struct sg_table sg_tables[3];
+};
+
+static inline struct rzg2l_du_vsp_plane_state *
+to_rzg2l_vsp_plane_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct rzg2l_du_vsp_plane_state, state);
+}
+
+#ifdef CONFIG_DRM_RCAR_VSP
+int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
+		      unsigned int crtcs);
+void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc);
+void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc);
+void rzg2l_du_vsp_atomic_begin(struct rzg2l_du_crtc *crtc);
+void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc);
+int rzg2l_du_vsp_map_fb(struct rzg2l_du_vsp *vsp, struct drm_framebuffer *fb,
+			struct sg_table sg_tables[3]);
+void rzg2l_du_vsp_unmap_fb(struct rzg2l_du_vsp *vsp, struct drm_framebuffer *fb,
+			   struct sg_table sg_tables[3]);
+#else
+static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
+				    unsigned int crtcs)
+{
+	return -ENXIO;
+}
+
+static inline void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc) { };
+static inline void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc) { };
+static inline void rzg2l_du_vsp_atomic_begin(struct rzg2l_du_crtc *crtc) { };
+static inline void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc) { };
+static inline int rzg2l_du_vsp_map_fb(struct rzg2l_du_vsp *vsp,
+				      struct drm_framebuffer *fb,
+				      struct sg_table sg_tables[3])
+{
+	return -ENXIO;
+}
+
+static inline void rzg2l_du_vsp_unmap_fb(struct rzg2l_du_vsp *vsp,
+					 struct drm_framebuffer *fb,
+					 struct sg_table sg_tables[3])
+{
+}
+#endif
+
+#endif /* __RZG2L_DU_VSP_H__ */
-- 
2.25.1


