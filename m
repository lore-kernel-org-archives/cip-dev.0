Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A629C7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 01:10:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.144.1750381816608927513
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 18:10:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=xwdWGhte;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381803;x=1751591403;bh=pRpjLzaDNQia2HV5nrTBtjzyGA3g7X7KMR1a3Kr/jO0=;b=xwd
	WGhte1G5wj1xzedbNWKeyxtCSdVvI1HDlRgjlX3EeD6c52wwz5xPqxsu+yUWAniSbenx0ct54qE/U
	akBF0ZTUEYE9y6/TQQFSjuDASqRs8lcvBIddN193CrYOIs6gmWL3XAq1GSEgB0GFF+AOqjntToIlu
	RcNbgNPMbxqu2u9Kt69EStBY3wQdr1wqouSU3hp5kWr5gTyjbPE81gxgfRJbIrkSboN1+g+UWddcz
	bQ2XnJYarpPTfk7MMmdq6P5pTs2f1V5Sd3BGKs5WA6AW6WNwjjCXsPdRmJOMAvJnbw6RlUWBAFk4o
	tp7FGpSdSdPyF45pPyT3naOst0MWTVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55K1A2ee028458; Fri, 20 Jun 2025 10:10:03 +0900
X-Iguazu-Qid: 2rWhWAeBn5ajNtr3aP
X-Iguazu-QSIG: v=2; s=0; t=1750381802; q=2rWhWAeBn5ajNtr3aP; m=HK/zbaNcpy4GWO+YGRXgVsiug2xIMBuyG5FUkTjBUF8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 55K1A0oB1115216
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:10:01 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 6.6 2/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Fri, 20 Jun 2025 10:09:56 +0900
X-TSB-HOP2: ON
Message-Id: <1750381796-6607-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:10:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19142

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 929d8490f8790164f5f63671c1c58d6c50411cb2 upstream.

Commit b9bf5612610aa7e3 ("ARM: dts: am335x-bone-common: Increase MDIO
reset deassert time") already increased the MDIO reset deassert delay
from 6.5 to 13 ms, but this may still cause Ethernet PHY probe failures:

    SMSC LAN8710/LAN8720 4a101000.mdio:00: probe with driver SMSC LAN8710/LAN8720 failed with error -5

On BeagleBone Black Rev. C3, ETH_RESETn is controlled by an open-drain
AND gate.  It is pulled high by a 10K resistor, and has a 4.7µF
capacitor to ground, giving an RC time constant of 47ms.  As it takes
0.7RC to charge the capacitor above the threshold voltage of a CMOS
input (VDD/2), the delay should be at least 33ms.  Considering the
typical tolerance of 20% on capacitors, 40ms would be safer.  Add an
additional safety margin and settle for 50ms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/9002a58daa1b2983f39815b748ee9d2f8dcc4829.1730366936.git.geert+renesas@glider.be
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 4867ff28c97e..27e73e745e25 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -385,7 +385,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <13000>;
+		reset-deassert-us = <50000>;
 	};
 };
 
-- 
2.25.1



