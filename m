Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ECAC7115C
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 01:13:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.207.1750382004312049735
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 18:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=PoYffyj0;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381994;x=1751591594;bh=FhRKMKy05lVhxnfWHm0ZMgiK7k34GCLaWDFii4P6do8=;b=PoY
	ffyj0r0st2vuklIbUlo9cweVsHcrTPSuv+AR0mhROOHW/ZxpOkcmQUoMYPSKxHImKPNbn+/hUIpQD
	596AGqa42Vu6kqJZbvF3Sn18Kj4UdL+XJaC3ro46SjTch5U8YbB81+cwcbW3tsBexMStSUdlveTwA
	EepKkz4/YbkbZwOw9CUQpv+qB4uQBz7Jz4mUOEraTnEPRPC7Q40cvDsNj45mi/BG2bsAQD5oOlcbp
	sP+ZXqK4UxI9WFez3uSpVV0FRmljpbz4RHLdkNmB1yXpETqG1fo2BzFABaairV2NeWMN2cBK1pgS8
	R4aLdYF4P4HmwhBmr9ks8PYunklEaUg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 55K1DD2C3089032; Fri, 20 Jun 2025 10:13:14 +0900
X-Iguazu-Qid: 2rWhMjEQLsOAC1MWsF
X-Iguazu-QSIG: v=2; s=0; t=1750381993; q=2rWhMjEQLsOAC1MWsF; m=oVBygeYAFUgJDtA21ONfH+Ai2IIZkDYvtYTC7HrnQLw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 55K1DB8J1124427
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:13:12 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 - 6.1 3/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Fri, 20 Jun 2025 10:13:07 +0900
X-TSB-HOP2: ON
Message-Id: <1750381987-6825-3-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:13:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19145

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
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index b58b8b76724b..bfd26ebd7b9e 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -384,7 +384,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <13000>;
+		reset-deassert-us = <50000>;
 	};
 };
 
-- 
2.25.1



