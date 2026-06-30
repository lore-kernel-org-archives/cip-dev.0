Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EEC4450B
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19446.1782820147381811380
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FsdTvvun;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so3785457f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820146; x=1783424946; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hISQxhCbnB7SwvHWbGn2nivhAEnDpbB6eyoB2IoQ6uc=;
        b=FsdTvvunS4oppAeigoX0+lNtknPzypVpkUaauA2f/xpfCFn6jsx4nBJm17AmWxSvR4
         akicPeQgMdiriarPURyIPmUlOQsCjp5Xd0ZsPoH1zhv69zMH6DiIc0VktViSpTftCR2V
         oQuWxz35PCyruItpqXpHaUXQ2CyHUvIPQWpfoG4V51SNTwhlSoVvzS6Al239qlryW3Xy
         i7Z7cCKqDUbHBnTpe8IdAisi4HnK2o6dagUELRc+YN9BJmcqpgYDXLwb1t3/jHpJLtVT
         MUgdgOOJ8P6LhCN+7SySijfJP0NbWU/ZYH4adyTmsg8TbDV/xIVC5Hv9Hog3vD9SR5qP
         5oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820146; x=1783424946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hISQxhCbnB7SwvHWbGn2nivhAEnDpbB6eyoB2IoQ6uc=;
        b=pw0ARNoy4T51gzP3Pa1l8LzlER5ToLd9EUbYC8/TikFF3SeBSnrKF/lJOqJqH22bec
         zERP8/Yhiuc96F5C8m0HK0QcmQP0XalSjjPKHko/lz8x8mF0KwczyIqvojGoruy7z/5p
         ThFf6BdWVa5N4rxjCwMC645rTybMuasH/181BYWd27qu8HQ9tQZRgoZDYV93W4vwrJl5
         tSibXNowVrxLuZW5WksrT91EGCHsb89ZwYn+GJEuRjAnVPqo1UrNIi8ciTUyf+QSYWWv
         BcY6H+Hibgd8mTBmSmJ629rvQfFuYMgBoQz+BRW0smuOGSQ7UbQh6w82wnTlVmAJur36
         qYsw==
X-Gm-Message-State: AOJu0YzGyVLydVWucmg/qaDTkrRzWCC2vTDuQyii2yN8UWg4HtRBcVBM
	uGsVYhW2hnek2WeiYVXviZ8KgBizRS6k43hEXSB7kqCHsTNgP+B0m9Mw7WH9pK1U
X-Gm-Gg: AfdE7cl1SaJ7UKPr0uZmzciODoNOVSxMC/GtfVmt/23S5UHaDDCpl1I0+QMzxZMm88E
	XkEBmD5XeHkzH1LVGFtd0A+usC/LXv+ge2hchdnzmyp/Gtt9Tv3DawMagbwYOvl1f+jDaow/swk
	UbeSNOL7RaqglMy1d0mBn9vWHbHtgH12ipoxNU1bdCU7U6UppD2qVSUoJCmdtgLyE21cCvTRjyz
	TdDD6FQ3NhStS9NkPmoKIbLddUzd6hdprOhwuha3dT71lBB2A4ZjtN+0VO+Ld0W2LFtQE5ixKhL
	681o/NjONtWfwLCK6YP8Pd0Q7WlPLUuiaF0rtCHXne/hX7X1QulBeWEK8xdZqzdUNytIdfhq9QE
	XubAHc+dOThYjcMp7GWdBhLyVoOjxaGR5nGmQ9EB//O4HfruthcWfywcobvL46cKUp2gka2iBre
	wR4J5Varox20m+bUBJlK1dXDjYgoKFRNpf3ydBDw==
X-Received: by 2002:a5d:5c89:0:b0:474:8aad:2f8 with SMTP id ffacd0b85a97d-47553028380mr4711344f8f.41.1782820145475;
        Tue, 30 Jun 2026 04:49:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 39/39] arm64: dts: renesas: r9a08g046: Add OPP table
Date: Tue, 30 Jun 2026 12:47:58 +0100
Message-ID: <20260630114813.92739-40-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23363

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 60f8dfd33c1c7daade9846207be735c7f4fd802d ]

Add OPP table for RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430125342.439755-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 236a675231e5..e52498b3a745 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -14,6 +14,42 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		opp-37500000 {
+			opp-hz = /bits/ 64 <37500000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -24,6 +60,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@100 {
@@ -32,6 +70,8 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC1>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@200 {
@@ -40,6 +80,8 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC2>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@300 {
@@ -48,6 +90,8 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC3>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L3_CA55: cache-controller-0 {
-- 
2.43.0


