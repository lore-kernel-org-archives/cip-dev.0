Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4762C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:53 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.10345.1746783169264039260
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PEcO1k4M;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so2763172a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783168; x=1747387968; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAkZS10GDFmKZdnMFN6p0ueE4CI4VTXBgufGYsx9ccA=;
        b=PEcO1k4MmHzPO/fAUk5GioyDocW0SvGO/U810LyXdjeDD6+2ydQgsSVRZBVp23KaqP
         y+Bxyw8QFBtAR24tTbAjFfYAa2xCjDvrC0cGCHKh+6CeOh+a1oVmLdHvwCVTX+j44cMj
         fd6rXLFnbCW0sfEhoSuHo/pwyuOsVQgoABbbNjNzOxziBA4ppyPfm/FgAyYsDFqbFjvG
         4S7bQok46N2KgxzAI/n3izAcTczCwHahpG1JDIZV43JFW4C52y9l9+oxwkkm+1a54Q+t
         gjsTwBUdLsQfncAI3INpiwERtKfskdPpuv5xjLhXbDjVoW6Qt7qLMB+xubmGB86FvvhL
         mOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783168; x=1747387968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAkZS10GDFmKZdnMFN6p0ueE4CI4VTXBgufGYsx9ccA=;
        b=s/bemLEpVniASaXUXadkhjRr2Fk4/ah2jAHU3PnNPumSROXsLL0uZT3wPUGav2f3eY
         rJ4WEmR4vEcX08M9z352caa73c848t3qrUVx4CasKwQcQFD1uahXYBkEtA+Yq1QdY1uA
         D/9nTqPZ51ShsApLYm4yIav0kXIFcmE4VgRPbVfaUAPyhxISz13ALLHaxiMixCNIanqf
         +fON540UT+bDASdLPvXSV6AJGmyG+D5rtYIkjBvqF7iQauT6ya0zpFt+0+Cvj8q+ENZD
         AoFNgJKL7ORGJbjA6H0TYvEw5a7BOlg8T1SlnmNSZ7I+uW2mFgRj1uDyEHvfFHAB91np
         oW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXo4JqsDnSEyz9bMdqnnRg+r7MK5F2DrTXqUypQm0U7Sgl/+OXPzs4rNGWzoa1kRzS9uoDvLwAK@lists.cip-project.org
X-Gm-Message-State: AOJu0YztyPDcPm4bPjKf6nT+9V7l8k/Uq7Pt0HK/w//jME3o0vro13Wm
	5yDmJ7zJaBePLUoO9PEZe8gjv7blsCkMbuAtMrbMG6X9lDwsld90x9qz5aG+ET+lOAzcu+ShXFc
	t
X-Gm-Gg: ASbGncs22cSz54i9r+aTcYtqaF3oWgtal90kZIC5Jf+qdMmCjAsxbK5OyeA83Pm/73T
	Of3ZhnE01hOsIkJiODyCnS4GkZ/iH0CN5gZ5xvWnStfK4SXWtKaZPqBaiUelWXcXapAh75QN0ZO
	FEx3xrZicI9RxAyRX7lt6wg+vUERTlXqDs5fJeq0q5C2/yzhEl3DazzuSdmMqB3vybShWs3MkZx
	zF1+J2DC/8LmP9CJMA6JS+SAC9T+oYYc6SknerLleUtC269wcYJTJfvCSQqY4msY/ypD0h8NTaJ
	y/iI9TREXXH77fG9NORGlPbFh1VsHI/wwgbkUyQMM3maIKCrjUUzwZ4/8Xg5cp6RHfcv4w==
X-Google-Smtp-Source: AGHT+IGbuBD/yhzdPfW3+R0K9f9qtkAgmrDYG0rIDeOxsBkBvoXdukcQw7OEhcS+DifUQ8p2noC8aw==
X-Received: by 2002:a05:6402:354e:b0:5f7:eaf0:8849 with SMTP id 4fb4d7f45d1cf-5fca0770858mr2059691a12.16.1746783167571;
        Fri, 09 May 2025 02:32:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 29/29] arm64: dts: renesas: rzg3s-smarc: Add sound card
Date: Fri,  9 May 2025 12:32:03 +0300
Message-ID: <20250509093203.4014750-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18816

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 24bfc042ba3dc3692e206ff060eb22733b6d3ac0 upstream.

Add sound card with SSI3 as CPU DAI and DA7212 as codec DAI.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-25-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 68dd3b608516..3c810db81861 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -52,6 +52,23 @@ key-3 {
 		};
 	};
 
+	snd_rzg3s: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&cpu_dai>;
+		simple-audio-card,frame-master = <&cpu_dai>;
+		simple-audio-card,mclk-fs = <256>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssi3>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&da7212>;
+			clocks = <&versa3 1>;
+		};
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
-- 
2.43.0


