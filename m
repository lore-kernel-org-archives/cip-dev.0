Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FFBD65546
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11773.1765967551198548768
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YAbGM5my;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7a72874af1so857944266b.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967549; x=1766572349; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoDTATrC7cwwE5fs3JFF8XP6XpQMxngsgflx6GWM2mI=;
        b=YAbGM5myHcpbCeb8agJydQd3bZKZRQlNTgV0jb0VPLIUi1OFORT2A65ui2zGLwwD9m
         /Ge9JD3KbLefIQsq6GBwmqx7qgPTG50XD6uALKSFmHI7OIKFxknlyIqWFuvPsKBHYQey
         mvXyjwZ2gNC6zdROm2FVjQR1nHh5u2RLKKaVJu+aLm5lVtd33i3GtTSFZbwtpAa6OCFR
         uh2CM4GQZGOHc8+BE7Nw7oRErcVk+l0lH3+EIdgPytBmdTcaPI8aR90evns5nHW6Ih+y
         7vaRZpcmILeeCFLPDKCwCIrWqYr8Rs1eoW2+orvrKexwBB7TBRPmSv3SUxiGHcgTqTip
         A2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967549; x=1766572349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KoDTATrC7cwwE5fs3JFF8XP6XpQMxngsgflx6GWM2mI=;
        b=aULwK5i5Yk3advvwYa3qDLHIKm4x9jXLIgtlogLPf56fcQ4Mt2S/Jk2vRGbPbN58mv
         iAD74gO6z0vgSr0uKr/lpQe+PSGDuh2MnbO4HV31Wx8iFyWvKBknpZrhAjEhWQlVNyQa
         XMR6sJ04mbqqEcI6l8W3nhFvy4+0XSLK1btW+w6//Yvnjab1qlZ461pTxd/U3MtMrvUX
         I8c244sUHEorLrO4AuM4ircj+wJGXOFiNWe29XlnGNSVNU6ndV8xGeU2PcQu19D5W5WW
         90y+ABsvd621s5d5X2ydoc1YuI5du1VEH/nAJ/Kr3hMQukzMYkMPXPYj+xzwfcjs+V5n
         Q1BA==
X-Forwarded-Encrypted: i=1; AJvYcCW7B1ArCmOxwVs4ZIASaOKwiG+vvJ4pmJebS3Cs22rsSZ7+jNuqW0ni9nI7bvCf62fvdJvwUgQ+@lists.cip-project.org
X-Gm-Message-State: AOJu0YxTcVs6C0csV5GVpq1s+JY7V4A6y3FO9nZ0jhz7wpX39Lv35ClV
	L8nIS4/z5ef0ofFDHEoBqj/pc5wdnTBFTy7im3NaFuG/2VsQaCSKb2M9KC3/0bTfyjXn9De5BYF
	TG7uG
X-Gm-Gg: AY/fxX79FHwD+5FWd2DtLx96x9NdUSZe3oh6JPWSXJ253i5Kjk30fPC/Tw2dBdg5Tbk
	zIotddr1X5TgOxwCjxmKxQDuYpB9QmCaiOV3O5cSwlZ4r5JFzhmr56OuOH7gaPBYPor7HcoSV+S
	T4WrqOjKeDdc9omLlLvu6Jz08QwlG6HcyV+Spg9cggq/RAIvEkb/KR6Gn0Me2V/W2Lw5iqw96v2
	k16r/zDDYTHLEIiljnQUP6YjpjIFWoRpfVw3oFsTw8qMdCXZvTSbY8wvEWsGNz04wqMXl4B8Hhu
	L3pBF9Uq8HKOqmryNBWRi/XlHpF3eN5t+DQHn+DBlaF9IweahNTnH3eklnW47P+zvdb0z9LbhjU
	KnD3006U3D4XA6i9qeiU496AtytfmaZDxgwnz78MU5zwp39z57n9m64NNA2ZpNABbfFfCY0mlaZ
	1eiZPoUnjiU6u1UoUDdbo/6r4xr6X2TDW6anr+Ncej
X-Google-Smtp-Source: AGHT+IFzfBXIAkSUyiiuyMRGnVDXrsqgynjgRYwPW0OtgR3urS31pNkYYXT+iKGE4dASOqqDT0w3EQ==
X-Received: by 2002:a17:906:9f8b:b0:b72:d56f:3468 with SMTP id a640c23a62f3a-b7d23a67b4dmr1830451066b.50.1765967549421;
        Wed, 17 Dec 2025 02:32:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 4/6] arm64: dts: renesas: r9a08g045: Add OPP table
Date: Wed, 17 Dec 2025 12:32:20 +0200
Message-ID: <20251217103222.4183089-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21117

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b6f4b126b2471211f35720d8e976b65044e13020 upstream.

Add OPP table for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128145616.2691841-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index d1e228b439df..0364f89776e6 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -28,6 +28,33 @@ audio_clk2: audio2-clk {
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-137500000 {
+			opp-hz = /bits/ 64 <137500000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -40,6 +67,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L3_CA55: cache-controller-0 {
-- 
2.43.0


