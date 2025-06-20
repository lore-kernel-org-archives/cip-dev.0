Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B523C7115C
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 01:10:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.146.1750381811157661236
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 18:10:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=c8e9LJC2;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381801;x=1751591401;bh=Ste5a9umI3kJtXRgSJE5CM/JE2VIKdpsHauZHo5nXfo=;b=c8e
	9LJC2jbXpjz02ywt/83HPBJRFo4zleexhWHhb6h/xmv5p50aS4VEmtdUDI98rk/N+th0RIzgHCKUR
	NgUa93p7bMaHDVDtY5fgFGHq8ZNFjam91qjFsQ0EKRs31Ta8QSRN9dP9zkWraThZipxzOeyi5BCwU
	CZw2X4yDJEjIkf+NV8Df4xRGMjC4AO/QpEsFx62lfSf7tfinmCTQPyC/Xb5gVJunTAcI01+44UCD/
	IUWrnufC1BOCayj0BNIjAtX7dfHuAg6jAVwvJCFTifIAxs9NQa0ZNFPBYGkg8t+n1561UjH8Y56xV
	CYPh0hkXmIR/xOrMpAQMHCpUOL7rXYw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55K1A1aQ3100969; Fri, 20 Jun 2025 10:10:01 +0900
X-Iguazu-Qid: 2yAbAvUQOulDXivw6K
X-Iguazu-QSIG: v=2; s=0; t=1750381800; q=2yAbAvUQOulDXivw6K; m=EU1J//4IWXVMwh2b9xms/ykRkJoXSRHSVj9VxIlX7SE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 55K19wnb701107
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:09:59 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 6.6 1/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Fri, 20 Jun 2025 10:09:55 +0900
X-TSB-HOP2: ON
Message-Id: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:10:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19141

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
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 96451c8a815c..4867ff28c97e 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -385,7 +385,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <6500>;
+		reset-deassert-us = <13000>;
 	};
 };
 
-- 
2.25.1



