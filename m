Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B460C4450A
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:06 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9369.1783944239558865897
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 05:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fyXusklZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2630652f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944238; x=1784549038; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1Uegw+zdT5hMY37Lqod0kphxnCPek0IMfst8Dy7kvg=;
        b=fyXusklZMxeIQZ10Sj+GmAcrs03Ew06uasNi4l5xgV0OliynEFuYjSO169xviJkoTa
         sUoXHeBjbjNImRcY50RUJrZCgZlGSJYE7xJEN38IsXhxYZDBbygUYQkW8HqN0z/HMsol
         QRpVIhCuLLf71Y7SI58RyXRhKxRvc2M91atFu00OJbw7tDFQvPUu37yKqOPhDaFXXzTJ
         EUJcaqylFePG1nHaIiQk+BRrOqC2B6ZMVmgDzQDorymKY31CQ+IejhOjH3fI1j8OUMxU
         T/xdiCJrNDdzaKLpyIgMCnrG/KjqKBAHhs+u7R9efyOLa86knorBkdtBrrAv9+I33SlN
         0o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944238; x=1784549038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1Uegw+zdT5hMY37Lqod0kphxnCPek0IMfst8Dy7kvg=;
        b=P/g5kaNQfojesoqNhJTloh8D2lraRHUQ+KUo3KpGvq1LvgRc0k17pMGe5Of0X8rpPN
         Rm3CRcRoB3vccj7gO9sxug2/K6EIaYAW5Ez0/ZEvOix8N1yYBrzicRZp+Q3bQqIN/A0y
         LcZto2aJlC/to55WzGk3NVs7MklHgamNPuLvv47ukrTEYVBLCejoKVNsiCNMD3Ae9Q92
         Yrmm6TneanGbRSNsr2fFU4qWDVlRpCaOgp1LO2hh8TpoQmZWXBvMRktuaEQ3QjDamx+I
         1FhtlQMi629xEliW72ev44yj9css2HkFkG2AXyJc3I71HkbvXggeBMHf3c7uBQ3CljC3
         8GGw==
X-Gm-Message-State: AOJu0YzSXhjJI3XQ9O+iNR1/f52Fjwy+EbvI5/oe6AvUrPHnH9ysp+IW
	h6CImjr/gF0dQY4sVfgBB5RSsU67P3t1r3vzCALk8/HsleW3MrfIOJIBaNiX0JOn
X-Gm-Gg: AfdE7cnCIQ7iilPOyX36ZoaexLpzZzC4p+QyL4TmBtY0Btgyu6YRTJQDR9CV6xWLuzE
	mxzWjrrbRtz+8YcSfM6D8BCoqrfTLYjmH9gu01f15Vp9KaEyofS3oIPDQhXizpLNy7Z7WV9R9rV
	ppaZv3PPXsj8JZNoSgoyFRKppMPe4hIC7aQM5ATzs3bd7gHE+n1fyVPn2CpqJ6w1IqR/+9PnJTR
	uMNZD+ruPoLyJvOHzB3nFqaOUk/6ggyJh2eK6oGVq7tuKrahfJertRkeeWXwQViMxNtY/RMczX/
	cLKUlUR1fw2K6C51hym+lkIDEZVcHECDUty7ctL6B1wMSSfhSug0LbqgORXTOKHZXkO24bDHgkS
	o//2AkSeTcmRi8SHI/z+17sKv9RympT8WfBju5BxD9QbbAnvnHlSr2ygWfAAFuOnFTmXX3giYy3
	WtlunFOO5YeQKNNmfnPKSDwbSZ1euMz0RstI/JEg==
X-Received: by 2002:a05:600c:4f8a:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-493f87e6e9cmr91196835e9.15.1783944237607;
        Mon, 13 Jul 2026 05:03:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm322910705e9.9.2026.07.13.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/4] arm64: dts: renesas: r9a07g044: Rename SDHI clocks
Date: Mon, 13 Jul 2026 13:03:50 +0100
Message-ID: <20260713120354.29288-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 12:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23564

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fee3eae1334a454a8c2e16313a374cc53ff722d8 ]

Rename the below SDHI clocks to match with the clocks used in driver.

     imclk->core
     clk_hs->clkh
     imclk2->cd

Also re-arrange the clocks to match with the sorting order used in the
binding document.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20211122103905.14439-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 327e7bf983a7..3fcce6324097 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1055,10 +1055,10 @@ sdhi0: mmc@11c00000 {
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK>,
-				 <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI0_ACLK>;
-			clock-names = "imclk", "imclk2", "clk_hs", "aclk";
+			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G044_SDHI0_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -1071,10 +1071,10 @@ sdhi1: mmc@11c10000 {
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK>,
-				 <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI1_ACLK>;
-			clock-names = "imclk", "imclk2", "clk_hs", "aclk";
+			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A07G044_SDHI1_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
-- 
2.43.0


