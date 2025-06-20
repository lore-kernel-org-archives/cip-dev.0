Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21268C7115A
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 01:13:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.206.1750382000127561287
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 18:13:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ppPbkhMU;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381993;x=1751591593;bh=NzJOLWvfP/b0wc4yEyWAZhVA0QX3yCX/uRq3DgIU3x8=;b=ppP
	bkhMUprdoIF1tztauAhWxVO8Ya+P9vs1vc/7YBzcp1fL3mWO/qKg0PEfAL1H4pLkQrzqSTxQ+0Ulm
	O2cUA/KTwlATEfTXATOlVo9SNNXLEixtAAz+4NS6oEwcFThLJFG4DZiVg/l6hdttkBlMs8/ZMmBRD
	/zKiin1DSonFQBx5n4nN/BIU0kXg6DY2wfl3LToVmvMKNEVyBwcgMNkCH+9P8g2zahXYODOhAa+rk
	jixh87ZbG6SxCct7qP50/Jda5vEDggEXID43/BnMiRpwwtztFkB+obsYkbEoN+FsD8aGaUgjzioTR
	5+OuIpHkvQYIJztgbJSpIm69Vnohvig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 55K1DCf42096276; Fri, 20 Jun 2025 10:13:12 +0900
X-Iguazu-Qid: 2yAbuzQy4Iz5cB0YaG
X-Iguazu-QSIG: v=2; s=0; t=1750381992; q=2yAbuzQy4Iz5cB0YaG; m=SCEi35ATu/n9AU9UUhSNgpwAvAR9tu8CSFu+oTCtygM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 55K1DB85708390
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:13:11 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org, Shengyu Qu <wiagn233@outlook.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 - 6.1 1/3] ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
Date: Fri, 20 Jun 2025 10:13:05 +0900
X-TSB-HOP2: ON
Message-Id: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:13:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19143

From: Shengyu Qu <wiagn233@outlook.com>

commit 623cef652768860bd5f205fb7b741be278585fba upstream.

This patch adds ethernet PHY reset GPIO config for Beaglebone Black
series boards with revision C3. This fixes a random phy startup failure
bug discussed at [1]. The GPIO pin used for reset is not used on older
revisions, so it is ok to apply to all board revisions. The reset timing
was discussed and tested at [2].

[1] https://forum.digikey.com/t/ethernet-device-is-not-detecting-on-ubuntu-20-04-lts-on-bbg/19948
[2] https://forum.beagleboard.org/t/recognizing-a-beaglebone-black-rev-c3-board/31249/

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Message-ID: <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 02e04a12a270..e2efc4256bcb 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -145,6 +145,8 @@
 			/* MDIO */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -153,6 +155,8 @@
 			/* MDIO reset value */
 			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			/* Added to support GPIO controlled PHY reset */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
@@ -377,6 +381,10 @@
 
 	ethphy0: ethernet-phy@0 {
 		reg = <0>;
+		/* Support GPIO reset on revision C3 boards */
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <300>;
+		reset-deassert-us = <6500>;
 	};
 };
 
-- 
2.25.1



