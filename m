Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F91C7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 01:13:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.208.1750382004512020058
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 18:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=xGITznBV;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1750381994;x=1751591594;bh=XtX+
	io/IcD0dCnLVDFticywsyiaRb6sWCyon/+LD6aU=;b=xGITznBVUv6f2kQnm73HqjzsOoj5GIGPXO
	mr1hJkjCzQdaTfYT4oMoU9ORsoV56bnXNTY8GG2XYQ7790zMPVMF8IYVDLza8vQcoof79Uruhv5aj
	lzoVkxCLPoa8j0Ux/CY1M6egkCPdOsQA9DHXLxbCvS0AL7fIaWaR+JRez20rAfKyFOQLPJKTOOExB
	JLJqxHbklrGDdlNHX3416C10QAEaqsuOIjDF0nxlKI0Vnd02Rid6ZmqHkVPT23R2mNBkZaGOvrUB5
	wOrU0D5SRShJwhxOQgBJpi9l7Jr8oaoqfP27TmUBp4vFdYLNYaehAWxYvFQvQcFBstRzUDdL0CfNQ
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55K1DD7l043984; Fri, 20 Jun 2025 10:13:13 +0900
X-Iguazu-Qid: 2rWhEqwpmMMDo9Nahm
X-Iguazu-QSIG: v=2; s=0; t=1750381993; q=2rWhEqwpmMMDo9Nahm; m=3Dkr/BaQSEyyLQWciD/IXWkxv4Zm7bHOEDCS1Sc+9Gg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55K1DBxX425524
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:13:12 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 - 6.1 2/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Fri, 20 Jun 2025 10:13:06 +0900
X-TSB-HOP2: ON
Message-Id: <1750381987-6825-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:13:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19144

From: Colin Foster <colin.foster@in-advantage.com>

commit b9bf5612610aa7e38d58fee16f489814db251c01 upstream.

Prior to commit df16c1c51d81 ("net: phy: mdio_device: Reset device only
when necessary") MDIO reset deasserts were performed twice during boot.
Now that the second deassert is no longer performed, device probe
failures happen due to the change in timing with the following error
message:

SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5

Restore the original effective timing, which resolves the probe
failures.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
Link: https://lore.kernel.org/r/20240531183817.2698445-1-colin.foster@in-advantage.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e2efc4256bcb..b58b8b76724b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -384,7 +384,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <6500>;
+		reset-deassert-us = <13000>;
 	};
 };
 
-- 
2.25.1



