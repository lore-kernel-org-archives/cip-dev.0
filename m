Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BDC83F27
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 09:49:32 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web10.8503.1753177768683595485
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jul 2025 02:49:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=lW6RSv5k;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M9nSXX1019496;
	Tue, 22 Jul 2025 04:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753177768;
	bh=Fi+67ygu/Mqs5IT90L91eT/ejrTTVdqGzOX1CRLWqbY=;
	h=From:To:Subject:Date;
	b=lW6RSv5k6ednROCEqZzbJAUPOZlbCsWIPToss7USIwVMm5sJ1UE6WmtVIzjb3ZlR4
	 8M7gq1LPBiuoDXdvgVAgLDcSwcdYbyZh3Uf23RJOn9/+P0279W8757PGMZVBVo62Pf
	 ibh3q+VpsbCHP+vzKwAQczT3pv9Z/k97KQ85OWnA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M9nRMx4010962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 04:49:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 04:49:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 04:49:27 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M9nPjS1138912;
	Tue, 22 Jul 2025 04:49:26 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
        <jan.kiszka@siemens.com>
Subject: [cip-dev] [PATCH 6.12.y-cip] arm64: dts: k3-am62p: Add Microsoft fTPM node
Date: Tue, 22 Jul 2025 15:19:13 +0530
Message-ID: <20250722094913.1696068-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Jul 2025 09:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19570

Add a node for Microsoft firmware-based TPM.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b..91b9ec44fa437 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -29,6 +29,11 @@ psci: psci {
 			compatible = "arm,psci-1.0";
 			method = "smc";
 		};
+
+		tpm@0 {
+			compatible = "microsoft,ftpm";
+			status = "okay";
+		};
 	};
 
 	a53_timer0: timer-cl0-cpu0 {
-- 
2.34.1


