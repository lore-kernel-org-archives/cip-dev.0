Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA2C3F6B0
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054405"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7FFE2400D4DE;
	Tue,  2 Aug 2022 20:09:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 20/24] arm64: dts: renesas: Add initial device tree
 for RZ/V2L SMARC EVK
Date: Tue,  2 Aug 2022 12:08:46 +0100
Message-Id: <20220802110850.1496057-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9017

commit f91c4c74796acca0a5a3bde747948a844eb2c30b upstream.

Add basic support for the RZ/V2L SMARC EVK (based on R9A07G054L2):
- memory
- External input clock
- CPG
- Pin controller
- SCIF
- GbEthernet
- Audio Clock

It shares the same carrier board with RZ/G2L with the same pin mapping.
Delete the gpio-hog nodes from pinctrl as they will be added later when
the functionality has been tested.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220110134659.30424-12-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    | 25 +++++++++++++++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  2 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  2 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  2 +-
 5 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 962a66332236..8815c5eb4cfc 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -59,3 +59,5 @@ dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
+
+dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
new file mode 100644
index 000000000000..39ef55bfe0c3
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC EVK board
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g054l2.dtsi"
+#include "rzg2l-smarc-som.dtsi"
+#include "rzg2l-smarc-pinfunction.dtsi"
+#include "rzg2l-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g054l2";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g054l2", "renesas,r9a07g054";
+};
+
+&pinctrl {
+	/delete-node/ can0-stb;
+	/delete-node/ can1-stb;
+	/delete-node/ gpio-sd0-pwr-en-hog;
+	/delete-node/ sd0-dev-sel-hog;
+	/delete-node/ sd1-pwr-en-hog;
+};
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
index 71d83e447670..2ef217445f72 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC pincontrol parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC pincontrol parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 41fdae7ba66b..879375c0395e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC SOM common parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC SOM common parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 46abb29718cc..78034f36156d 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC EVK common parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC EVK common parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.25.1


