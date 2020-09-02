Return-Path: <SRS0=cuRD=CL=lists.cip-project.org=bounce+64572+5378+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA25C2BC11
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01CB208C7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f44XA5E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CB208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5378+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CEM5YY4521723xximjhCXKDQ; Wed, 02 Sep 2020 09:06:41 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11147.1599062725125566061
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:36 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="55980499"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A536240062CD;
	Thu,  3 Sep 2020 01:05:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/5] ARM: dts: renesas: Fix SD Card/eMMC interface device node names
Date: Wed,  2 Sep 2020 17:05:13 +0100
Message-Id: <20200902160517.5181-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oMKuY14GoZfPrBOQQox4waUHx4520388AA=
Content-Type: multipart/mixed; boundary="OEDVDLPbF0LbbS3N4gZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062801;
 bh=cGqDP4FeixfMW7OVqNaRuqvAkaO/4ciTG6Z1cljVvdI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f44XA5E9ZNY9hktV4sDA57l5eTZCxZTeUltBCUSG8nfe9kQxSryxf41qSo/gp5mNXMV
 03Knq8aphJv2On9AVWDvTHuRtC+3zTuO+PraeUnuumRB5PhdUItA4qrl0OeHuE9nYzFwt
 cEefeE8d9us1bEEh6KnF88s8W5auYRbGwUE=

--OEDVDLPbF0LbbS3N4gZx

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit d8293670ae46e84973c974ea5745527e90a8afbb upstream.

Fix the device node names as "mmc@".

Fixes: 66474697923c ("ARM: dts: r7s72100: add sdhi to device tree")
Fixes: a49f76cddaee ("ARM: dts: r7s9210: Add SDHI support")
Fixes: 43304a5f5106 ("ARM: shmobile: r8a73a4: tidyup DT node naming")
Fixes: 7d907894bfe3 ("ARM: shmobile: r8a7740: tidyup DT node naming")
Fixes: 3ab2ea5fd1ce ("ARM: dts: r8a7742: Add SDHI nodes")
Fixes: 63ce8a617b51 ("ARM: dts: r8a7743: Add SDHI controllers")
Fixes: b591e323b271 ("ARM: dts: r8a7744: Add SDHI nodes")
Fixes: d83010f87ab3 ("ARM: dts: r8a7744: Initial SoC device tree")
Fixes: 7079131ef9b9 ("ARM: dts: r8a7745: Add SDHI controllers")
Fixes: 0485da788028 ("ARM: dts: r8a77470: Add SDHI1 support")
Fixes: 15aa5a95e820 ("ARM: dts: r8a77470: Add SDHI0 support")
Fixes: f068cc816015 ("ARM: dts: r8a77470: Add SDHI2 support")
Fixes: 14e1d9147d96 ("ARM: shmobile: r8a7778: tidyup DT node naming")
Fixes: 2624705ceb7b ("ARM: shmobile: r8a7779: tidyup DT node naming")
Fixes: b718aa448378 ("ARM: shmobile: r8a7790: tidyup DT node naming")
Fixes: b7ed8a0dd4f1 ("ARM: shmobile: Add SDHI devices to r8a7791 DTSI")
Fixes: ce01b14ecf19 ("ARM: dts: r8a7792: add SDHI support")
Fixes: fc9ee228f500 ("ARM: dts: r8a7793: Add SDHI controllers")
Fixes: b8e8ea127d00 ("ARM: shmobile: r8a7794: add SDHI DT support")
Fixes: 33f6be3bf6b7 ("ARM: shmobile: sh73a0: tidyup DT node naming")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1594382936-14114-1-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Ported the changes only for RZG1[HMNEC] SoC's]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi  | 8 ++++----
 arch/arm/boot/dts/r8a7743.dtsi  | 6 +++---
 arch/arm/boot/dts/r8a7744.dtsi  | 6 +++---
 arch/arm/boot/dts/r8a7745.dtsi  | 6 +++---
 arch/arm/boot/dts/r8a77470.dtsi | 6 +++---
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index f4d571b4a4db..fd4da0d6269e 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -955,7 +955,7 @@
 			status = "disabled";
 		};
 
-		sdhi0: sd@ee100000 {
+		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee100000 0 0x328>;
@@ -969,7 +969,7 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@ee120000 {
+		sdhi1: mmc@ee120000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee120000 0 0x328>;
@@ -983,7 +983,7 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd@ee140000 {
+		sdhi2: mmc@ee140000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee140000 0 0x100>;
@@ -997,7 +997,7 @@
 			status = "disabled";
 		};
 
-		sdhi3: sd@ee160000 {
+		sdhi3: mmc@ee160000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee160000 0 0x100>;
diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 9ea92a367e86..aff5ebbdb4bd 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -902,7 +902,7 @@
 			status = "disabled";
 		};
 
-		sdhi0: sd@ee100000 {
+		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7743";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
@@ -915,7 +915,7 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@ee140000 {
+		sdhi1: mmc@ee140000 {
 			compatible = "renesas,sdhi-r8a7743";
 			reg = <0 0xee140000 0 0x100>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
@@ -928,7 +928,7 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd@ee160000 {
+		sdhi2: mmc@ee160000 {
 			compatible = "renesas,sdhi-r8a7743";
 			reg = <0 0xee160000 0 0x100>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 9e1885ce4948..079f46f17049 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1360,7 +1360,7 @@
 			};
 		};
 
-		sdhi0: sd@ee100000 {
+		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7744";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
@@ -1373,7 +1373,7 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@ee140000 {
+		sdhi1: mmc@ee140000 {
 			compatible = "renesas,sdhi-r8a7744";
 			reg = <0 0xee140000 0 0x100>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
@@ -1386,7 +1386,7 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd@ee160000 {
+		sdhi2: mmc@ee160000 {
 			compatible = "renesas,sdhi-r8a7744";
 			reg = <0 0xee160000 0 0x100>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 54b556b34663..5f603d9eafea 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1211,7 +1211,7 @@
 			};
 		};
 
-		sdhi0: sd@ee100000 {
+		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7745";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
@@ -1224,7 +1224,7 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@ee140000 {
+		sdhi1: mmc@ee140000 {
 			compatible = "renesas,sdhi-r8a7745";
 			reg = <0 0xee140000 0 0x100>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
@@ -1237,7 +1237,7 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd@ee160000 {
+		sdhi2: mmc@ee160000 {
 			compatible = "renesas,sdhi-r8a7745";
 			reg = <0 0xee160000 0 0x100>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index dc345754ce61..1057bff76cc8 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -664,7 +664,7 @@
 			status = "disabled";
 		};
 
-		sdhi0: sd@ee100000 {
+		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee100000 0 0x328>;
@@ -678,7 +678,7 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@ee300000 {
+		sdhi1: mmc@ee300000 {
 			compatible = "renesas,sdhi-mmc-r8a77470";
 			reg = <0 0xee300000 0 0x2000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
@@ -688,7 +688,7 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd@ee160000 {
+		sdhi2: mmc@ee160000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee160000 0 0x328>;
-- 
2.17.1


--OEDVDLPbF0LbbS3N4gZx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5378): https://lists.cip-project.org/g/cip-dev/message=
/5378
Mute This Topic: https://lists.cip-project.org/mt/76585845/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--OEDVDLPbF0LbbS3N4gZx--
