Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36471C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963125"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:08 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 847C2419E62E;
	Fri, 19 May 2023 17:21:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 03/23] arm64: dts: renesas: r9a09g011: Reword ethernet status
Date: Fri, 19 May 2023 09:20:38 +0100
Message-Id: <20230519082058.109760-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11535

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 11ffdcdfa2125859b298f9a66f9eefba493a37c0 upstream.

Although of_fdt_device_is_available returns true when the DT
property "status" is assigned "ok" or "okay", and false for every
other value, it's become common practice to assign "disabled"
when we want of_fdt_device_is_available to return false.
For some reason, the status property of the ethernet node was
assigned "disable" when originally added to the kernel. Change
it to "disabled" for consistency.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230118135259.19249-1-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 3ef4f7eb1a2f..dc7862549246 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -110,7 +110,7 @@ avb: ethernet@a3300000 {
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		cpg: clock-controller@a3500000 {
-- 
2.25.1


