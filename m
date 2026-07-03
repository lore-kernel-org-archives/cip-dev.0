Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FDAC44506
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89973.1783076373987317621
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kXmz9n22;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46ed4f66256so393220f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076372; x=1783681172; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/36eXRW3q3GOHfHtmRyvIoDZSfo1x1gFXkws1+u/JE=;
        b=kXmz9n22Uak7ENzqiXiM6g6/s4Qngea2dj97/bAaESJwlYBOOgXfaWHIszoL47bRl8
         gGxL0vvT5BeJvG5P6exCL34CDI3KNykr2rg8PLBzq+UsLCN/Sq1crnQ0UrknKbsLQktL
         v6aeb8VZ9Lk/h+EfK9FDlOO+Ih4u4KI1M9OTZNDuQuuFX5cneAfHJts5wV5niXVFGIlP
         HdNye427EdvRnywjTRiclBDc6F9soATGqI/UK/nPPLmFBFnESYmzKQXyJDbaHvQSZaPE
         ql52nqVPwD9QQz86V8LpRnMo7Iy7/gP72idUDcCN0nCMYv0TvqOJ4kvCMilBeDogFGoK
         hthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076372; x=1783681172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/36eXRW3q3GOHfHtmRyvIoDZSfo1x1gFXkws1+u/JE=;
        b=IJVEx5KdPYIv0HL7ytWQT4/zAjDTd70P6M6Bw/kQoi43ZSTdNN8zMowGH0D4z+Yy75
         9avyrMIa0iwbSeOaPjgkTl5eLhGcR53vSUOQqWm8hpkKdBJxOaiKfKkhTZHjArr3lFYR
         BfJUT17d20GBQiUQBPbxhClg/vEe/2cI1StJSlNYNg9z0ViH94KrsPO8xO77M73EQXZ5
         z90uTvZytxxWpUZLq5dhdboCze7CF3hHPJ8kFdC5AVkxnWt/Gmf8c1KmBgZFJmetEcEd
         UHQvN2T9x+W+8oInooFVsQKn9t+luUKgs6T97dVA/gFSwCpqcHzQ2r8UhmfAPUWBN4em
         NqKA==
X-Gm-Message-State: AOJu0YyfEZuF+4JP3jFpOkrghV+gyqqHuuxa6JPwEPJxUkLm8KZoYLPP
	Sc39DM3fHnYe/rfDy3piz0HJA/5KTVtwT6ZsVL8UWTX7kcVg4P0pqFdnM7j6Ydna
X-Gm-Gg: AfdE7ck5KIeMHgcSfFty7vIGjDjX576Strp3qqipyHLa1XjHdxxQ1TiGvnmW2SS/cVj
	1dZB9aikftVApktf5HrkTulM+srAc++zyCc0Xuc5pNiIl8YfZD+WdTkm76bTUu61iu8RcgZbfVv
	Bh/MQQ2aA2beraY3uLew3m3YzrtKVQLzpX16vJe4ah8os+yE3454TyYWrjbRT4lbV6RDUpyfs33
	d1MlE2Cl8N+4WsJ8uqciPFhiHIHn2AWbKH/IvTtYEgwsH2d9GglmD8NwRZK9lIWKILJWFUzIZqc
	NXksIFaPgJY5zDEaR9u13SaPbtk1Vt7gCDJyXJVuUgZDgVl0Qsk3HtfJxAvFTDq95WM6YDgibg1
	XlKLnmF1e1XUgiIW8Q1sDXgINw7tIGB6Y+vX2Th62o1dK3j7lWsgIOfOKSOOdEaKHYtjW8m5RIy
	M+mNRDIIeWk0Y18zVQMCmq
X-Received: by 2002:adf:ea82:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-4775be03177mr11978886f8f.37.1783076372122;
        Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/23] arm64: dts: renesas: Add pinctrl reset-names for RZ/G2L and RZ/V2H family SoCs
Date: Fri,  3 Jul 2026 11:59:07 +0100
Message-ID: <20260703105923.251255-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23435

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 998dd840cc7a54df214bc1a3751d5ad334e7dad1 ]

Add reset-names properties to the pin control nodes for
RZ/{G2L,G2UL,G3E,G3S} and RZ/{V2H,V2L,V2N} SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260317101627.174491-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 593c66b27ad1..ded4f1f11d60 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -604,6 +604,7 @@ pinctrl: pinctrl@11030000 {
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
 				 <&cpg R9A07G043_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
+			reset-names = "rstn", "port", "spare";
 		};
 
 		dmac: dma-controller@11820000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 6b1c77cd8261..0e712c55c4af 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -902,6 +902,7 @@ pinctrl: pinctrl@11030000 {
 			resets = <&cpg R9A07G044_GPIO_RSTN>,
 				 <&cpg R9A07G044_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G044_GPIO_SPARE_RESETN>;
+			reset-names = "rstn", "port", "spare";
 		};
 
 		irqc: interrupt-controller@110a0000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 01f59914dd09..f215b9d0f7b6 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -910,6 +910,7 @@ pinctrl: pinctrl@11030000 {
 			resets = <&cpg R9A07G054_GPIO_RSTN>,
 				 <&cpg R9A07G054_GPIO_PORT_RESETN>,
 				 <&cpg R9A07G054_GPIO_SPARE_RESETN>;
+			reset-names = "rstn", "port", "spare";
 		};
 
 		irqc: interrupt-controller@110a0000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index cb7dae9f7dd6..7a5f339728d5 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -497,6 +497,7 @@ pinctrl: pinctrl@11030000 {
 			resets = <&cpg R9A08G045_GPIO_RSTN>,
 				 <&cpg R9A08G045_GPIO_PORT_RESETN>,
 				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
+			reset-names = "rstn", "port", "spare";
 		};
 
 		irqc: interrupt-controller@11050000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 10b7b8a5c236..ec5e1132d9e1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -265,6 +265,7 @@ pinctrl: pinctrl@10410000 {
 			interrupt-parent = <&icu>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0xa5>, <&cpg 0xa6>;
+			reset-names = "main", "error";
 		};
 
 		cpg: clock-controller@10420000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index e312dd1d7ac9..eb2d8ab64b5c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -283,6 +283,7 @@ pinctrl: pinctrl@10410000 {
 			gpio-ranges = <&pinctrl 0 0 96>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0xa5>, <&cpg 0xa6>;
+			reset-names = "main", "error";
 		};
 
 		cpg: clock-controller@10420000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 7d0ee6ef4d20..0d36754ebe0c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -265,6 +265,7 @@ pinctrl: pinctrl@10410000 {
 			interrupt-parent = <&icu>;
 			power-domains = <&cpg>;
 			resets = <&cpg 0xa5>, <&cpg 0xa6>;
+			reset-names = "main", "error";
 		};
 
 		cpg: clock-controller@10420000 {
-- 
2.43.0


