Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE12C55175
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2480.1785575710501304397
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=b8adIXd2;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954afac04bso6556435e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575709; x=1786180509; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VvfKZUrutMOOzNBKrUB88plIUCS+q8GwHxzqu0X4KuQ=;
        b=b8adIXd2jhrGlU9uulGyydnOClNPFBg0tRBDZP3h3VXF3djZjrjhNVVA7RLJuL1B1k
         S6yh0v8LbUO1RNzn0n1uLf5eGmjDMG0bdN04TTkKNG62Zw+pGMFAIGmVP+I/U75Dv4yE
         zD11PmYa/ljw+kiRNiH+SSmwLdd+T2wWgODkwuZEty9WQ+3JKS7F8r8y2KP2QPhq/eQi
         AY2cbrEZoDztKQp/ljRyoocMPi0uf39BR4R3/bg85O/HRcDolXdK8KIIwdpQSBhGxGzI
         vqQJsjP9nr8VlkfB1CQKdmexGxLmfdd0EKj8JjlLjbFzzWumtCezB7LAuvpYuU6RTH8l
         8y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575709; x=1786180509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VvfKZUrutMOOzNBKrUB88plIUCS+q8GwHxzqu0X4KuQ=;
        b=Gl5QnKA7QxiTs/mWiv5EzqsWiecnwM4OxBtnKQsvWw1URH0jnQFARu9dL5x1DVZHRE
         K1IQcUnRTKf39daofIMhyVYyLTryCBZekYnpZGB2YMMg9o/xClK0S/kuJgueseW5Adol
         NeWYPofTa2eyAtxg/RPBohySKelwDjq0Uy2qZK2M+qOf4z7PuRlDzfnc2MGjOidqG68i
         BQPTCT8ewDFP0g1TGdlbm9+JQqnU9KC5Y92peHGAnbxNaQWiGMTqo7iCmP74BqeHfEm1
         fG1iPKxIrKrDwfc3BYzwV+Drd9UY2B3rKGQcmVNkTD2eOjq+CmTu7oP+WgbaU9fHxxkV
         xNLw==
X-Gm-Message-State: AOJu0YzhdySyD7Cj/PD9IaqKYonZiw3ZpAu+J31Wz4R9PznKR4JAh60U
	bfQgyHKysBeqwkCeJ0iF+zTUbHdr9Lxc9oSBBbr5vnduvzyC1ZQLEGs6ooHxzA==
X-Gm-Gg: AR+sD10/ChgkrxXb4IIkoygPl/od+6TkGlV+KbqR2rZ+fThOttoHHefM5Yl1kuIpRhz
	rRRqQeLyh5IGPR55/RSfxKQkMK4Yf+pWRDT9PRPAJ0fseiYhsRuU6iBciXv/2UuErUq9Hb/pgPw
	rl9oyyKRd3ZVsSSG0jdITVdg+wCdRLXWLq0tiIFoSXEUUrydflBtjBE3yf5zSMaPRb/WKNgPCst
	LO6WYkB1lXOEeEsZOS3aMmf+OV8kbANpKNx9Vf9XLxl0r+6LkJzMXvYsE4oTUWRwqTI4zMnUPBa
	q2MseSgAz5iq3VSqnw/5PANMUsuG9lZOf66YnBX8R2FJi83ccJmglb6ws9LLEbt8j2CDS55F/FD
	RwGjp+RY5cUDACSkVtxr2zKw/NhE5zrV8GiQrZ0MKn2VD7Hl+LqaQGVnryFqryrwHi1uUd/RD1C
	U/lYs2DKiyCxkM1wV/nhN6/8mYZaTArrNMpgIVUNtX0pwqmzr/imA49QsLTef75GxX269SW7HWQ
	DPENpB9iLw4Y9nRIqIiUYH72w==
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4980c66c926mr35956445e9.3.1785575708675;
        Sat, 01 Aug 2026 02:15:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/19] arm64: dts: renesas: r9a08g046: Add DMAC node
Date: Sat,  1 Aug 2026 10:14:43 +0100
Message-ID: <20260801091458.14026-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23839

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0df7429fcb8360caa6d2b05c9efa217daa966279 ]

Add the DMA controller device tree node for the RZ/G3L (r9a08g046) SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505123708.134069-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 323e7d107a19..5f8eb93da3c1 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -482,6 +482,43 @@ icu: interrupt-controller@11050000 {
 			resets = <&cpg R9A08G046_IA55_RESETN>;
 		};
 
+		dmac: dma-controller@11820000 {
+			compatible = "renesas,r9a08g046-dmac", "renesas,rz-dmac";
+			reg = <0 0x11820000 0 0x10000>,
+			      <0 0x11830000 0 0x10000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 155 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 161 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 165 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD R9A08G046_DMAC_ACLK>,
+				 <&cpg CPG_MOD R9A08G046_DMAC_PCLK>;
+			clock-names = "main", "register";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_DMAC_ARESETN>,
+				 <&cpg R9A08G046_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		sdhi1: mmc@11c10000 {
 			reg = <0x0 0x11c10000 0 0x10000>;
 			/* placeholder */
-- 
2.43.0


