Return-Path: <SRS0=0Qcc=CG=lists.cip-project.org=bounce+64572+5294+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807CC433E6
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10A4208D5
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZmZtrrmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10A4208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5294+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4NPPYY4521723xN5TR7az9yX; Fri, 28 Aug 2020 09:07:44 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45487.1598629321421552654
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804696"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:06 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39B79400C4F0;
	Sat, 29 Aug 2020 00:42:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 04/30] ARM: shmobile: r8a7742: Add clock index macros for DT sources
Date: Fri, 28 Aug 2020 16:41:29 +0100
Message-Id: <20200828154155.5827-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hn2ZGJfEG6XMrmWs5kJrqcR9x4520388AA=
Content-Type: multipart/mixed; boundary="wyIZQ5iUA0EFxKb1fOdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630864;
 bh=rUTa0gPMkBO0hwi5OD0/1H7gNCH7jT9WYX0QK4Ak95Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZmZtrrmo/endX+YwFwdR728bpo5Qz8E6vRrXvSQAIwoWVWhFT7FcSXg/cd0e7I0S1iu
 nrT9RQGtFbA6rwlFqdnDhTONP1dGQO/7E51L1l4ChOP/jnYeEbZThpAitLnViAJNlf6eO
 tthlP7IRDLDwunl2i4aeOihfBStebkIkE4Y=

--wyIZQ5iUA0EFxKb1fOdS

Add macros usable by device tree sources to reference r8a7742 clocks by
index.

Unfortunately there is nothing that we can backport from mainline
for this, as the architecture of the clock driver has changed
quite dramatically over time.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/dt-bindings/clock/r8a7742-clock.h | 165 ++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7742-clock.h

diff --git a/include/dt-bindings/clock/r8a7742-clock.h b/include/dt-bindings/clock/r8a7742-clock.h
new file mode 100644
index 000000000000..52a6d6bc4f2a
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7742-clock.h
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ * Copyright 2013 Ideas On Board SPRL
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7742_H__
+#define __DT_BINDINGS_CLOCK_R8A7742_H__
+
+/* CPG */
+#define R8A7742_CLK_MAIN		0
+#define R8A7742_CLK_PLL0		1
+#define R8A7742_CLK_PLL1		2
+#define R8A7742_CLK_PLL3		3
+#define R8A7742_CLK_LB			4
+#define R8A7742_CLK_QSPI		5
+#define R8A7742_CLK_SDH			6
+#define R8A7742_CLK_SD0			7
+#define R8A7742_CLK_SD1			8
+#define R8A7742_CLK_Z			9
+#define R8A7742_CLK_Z2			10
+#define R8A7742_CLK_RCAN		11
+
+/* MSTP0 */
+#define R8A7742_CLK_MSIOF0		0
+
+/* MSTP1 */
+#define R8A7742_CLK_VCP1		0
+#define R8A7742_CLK_VCP0		1
+#define R8A7742_CLK_VPC1		2
+#define R8A7742_CLK_VPC0		3
+#define R8A7742_CLK_TMU1		11
+#define R8A7742_CLK_3DG			12
+#define R8A7742_CLK_2DDMAC		15
+#define R8A7742_CLK_FDP1_2		17
+#define R8A7742_CLK_FDP1_1		18
+#define R8A7742_CLK_FDP1_0		19
+#define R8A7742_CLK_TMU3		21
+#define R8A7742_CLK_TMU2		22
+#define R8A7742_CLK_CMT0		24
+#define R8A7742_CLK_TMU0		25
+#define R8A7742_CLK_VSP1_DU1		27
+#define R8A7742_CLK_VSP1_DU0		28
+#define R8A7742_CLK_VSP1_R		30
+#define R8A7742_CLK_VSP1_S		31
+
+/* MSTP2 */
+#define R8A7742_CLK_SCIFA2		2
+#define R8A7742_CLK_SCIFA1		3
+#define R8A7742_CLK_SCIFA0		4
+#define R8A7742_CLK_MSIOF2		5
+#define R8A7742_CLK_SCIFB0		6
+#define R8A7742_CLK_SCIFB1		7
+#define R8A7742_CLK_MSIOF1		8
+#define R8A7742_CLK_MSIOF3		15
+#define R8A7742_CLK_SCIFB2		16
+#define R8A7742_CLK_SYS_DMAC1		18
+#define R8A7742_CLK_SYS_DMAC0		19
+
+/* MSTP3 */
+#define R8A7742_CLK_IIC2		0
+#define R8A7742_CLK_TPU0		4
+#define R8A7742_CLK_MMCIF1		5
+#define R8A7742_CLK_SCIF2		10
+#define R8A7742_CLK_SDHI3		11
+#define R8A7742_CLK_SDHI2		12
+#define R8A7742_CLK_SDHI1		13
+#define R8A7742_CLK_SDHI0		14
+#define R8A7742_CLK_MMCIF0		15
+#define R8A7742_CLK_IIC0		18
+#define R8A7742_CLK_PCIEC		19
+#define R8A7742_CLK_IIC1		23
+#define R8A7742_CLK_SSUSB		28
+#define R8A7742_CLK_CMT1		29
+#define R8A7742_CLK_USBDMAC0		30
+#define R8A7742_CLK_USBDMAC1		31
+
+/* MSTP4 */
+#define R8A7742_CLK_RWDT		2
+#define R8A7742_CLK_IRQC		7
+#define R8A7742_CLK_INTC_SYS		8
+
+/* MSTP5 */
+#define R8A7742_CLK_AUDIO_DMAC1		1
+#define R8A7742_CLK_AUDIO_DMAC0		2
+#define R8A7742_CLK_THERMAL		22
+#define R8A7742_CLK_PWM			23
+
+/* MSTP7 */
+#define R8A7742_CLK_EHCI		3
+#define R8A7742_CLK_HSUSB		4
+#define R8A7742_CLK_HSCIF1		16
+#define R8A7742_CLK_HSCIF0		17
+#define R8A7742_CLK_SCIF1		20
+#define R8A7742_CLK_SCIF0		21
+#define R8A7742_CLK_DU2			22
+#define R8A7742_CLK_DU1			23
+#define R8A7742_CLK_DU0			24
+#define R8A7742_CLK_LVDS1		25
+#define R8A7742_CLK_LVDS0		26
+
+/* MSTP8 */
+#define R8A7742_CLK_R_GP2D		7
+#define R8A7742_CLK_VIN3		8
+#define R8A7742_CLK_VIN2		9
+#define R8A7742_CLK_VIN1		10
+#define R8A7742_CLK_VIN0		11
+#define R8A7742_CLK_ETHERAVB		12
+#define R8A7742_CLK_ETHER		13
+#define R8A7742_CLK_SATA1		14
+#define R8A7742_CLK_SATA0		15
+#define R8A7742_CLK_IMR_X2_1		20
+#define R8A7742_CLK_IMR_X2_0		21
+#define R8A7742_CLK_IMR_LSX2_1		22
+#define R8A7742_CLK_IMR_LSX2_0		23
+
+/* MSTP9 */
+#define R8A7742_CLK_GPIO5		7
+#define R8A7742_CLK_GPIO4		8
+#define R8A7742_CLK_GPIO3		9
+#define R8A7742_CLK_GPIO2		10
+#define R8A7742_CLK_GPIO1		11
+#define R8A7742_CLK_GPIO0		12
+#define R8A7742_CLK_RCAN1		15
+#define R8A7742_CLK_RCAN0		16
+#define R8A7742_CLK_QSPI_MOD		17
+#define R8A7742_CLK_IICDVFS		26
+#define R8A7742_CLK_I2C3		28
+#define R8A7742_CLK_I2C2		29
+#define R8A7742_CLK_I2C1		30
+#define R8A7742_CLK_I2C0		31
+
+/* MSTP10 */
+#define R8A7742_CLK_SSI_ALL		5
+#define R8A7742_CLK_SSI9		6
+#define R8A7742_CLK_SSI8		7
+#define R8A7742_CLK_SSI7		8
+#define R8A7742_CLK_SSI6		9
+#define R8A7742_CLK_SSI5		10
+#define R8A7742_CLK_SSI4		11
+#define R8A7742_CLK_SSI3		12
+#define R8A7742_CLK_SSI2		13
+#define R8A7742_CLK_SSI1		14
+#define R8A7742_CLK_SSI0		15
+#define R8A7742_CLK_SCU_ALL		17
+#define R8A7742_CLK_SCU_DVC1		18
+#define R8A7742_CLK_SCU_DVC0		19
+#define R8A7742_CLK_SCU_CTU1_MIX1	20
+#define R8A7742_CLK_SCU_CTU0_MIX0	21
+#define R8A7742_CLK_SCU_SRC9		22
+#define R8A7742_CLK_SCU_SRC8		23
+#define R8A7742_CLK_SCU_SRC7		24
+#define R8A7742_CLK_SCU_SRC6		25
+#define R8A7742_CLK_SCU_SRC5		26
+#define R8A7742_CLK_SCU_SRC4		27
+#define R8A7742_CLK_SCU_SRC3		28
+#define R8A7742_CLK_SCU_SRC2		29
+#define R8A7742_CLK_SCU_SRC1		30
+#define R8A7742_CLK_SCU_SRC0		31
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7742_H__ */
-- 
2.17.1


--wyIZQ5iUA0EFxKb1fOdS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5294): https://lists.cip-project.org/g/cip-dev/message=
/5294
Mute This Topic: https://lists.cip-project.org/mt/76477077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wyIZQ5iUA0EFxKb1fOdS--
