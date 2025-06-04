Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55588C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:24:01 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.13340.1749032631427801715
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=m7ztE5Cs;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad891bb0957so1170163666b.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032630; x=1749637430; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9gp67D8ekUnnXloOZZKkO31Qh7bvFbhwMesMp+cxCM=;
        b=m7ztE5Cs8HUqxbda2i8VcSrwK78h6fGYgZ0qdcKoKPMWdik6vLWcIw98y3hwyOQEfl
         X6cfUURpEjxkttkWqrPuIMgIiMJOJhP363r79FEaEXbVGtpodI5bu5SFfbFqNMxGytrm
         ECIbIC+qkosCLK1y/8iYSpkAgZQN89r6MV3b5PSj0rXErhfHQUwgrVrVrWTiPDFcbhMm
         oW9X5ZeLEDQ4C4A1rncZC7E4+jjhE69PbUjt9bqfVO1j2ZeKEoMTUK+mE+WrI6hQuvWU
         9aTemC0uNMeG4Tcx0aZ+I4TXbyUU5e+5iPcNJKlPDP7VNceDFLuygoXvT+wPJ5FW1f4k
         t6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032630; x=1749637430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9gp67D8ekUnnXloOZZKkO31Qh7bvFbhwMesMp+cxCM=;
        b=VsSoSTKSxock97O6V841FHwKhtyIzXpLyhK0rjOCkaCeZH7w48r/BLzRBmf/+Lh05N
         Lv67WBzjWYHog/O40yh9e8VlKirQp7XL/BVWXC1dWhBXcfbxAxXWm3MrwhibJZiaQy8e
         vfYuyHhfaOf/sc3OCwM2YwpL/ppksHlRDhR0q1VuVUpUdOc6fGjWG6/F4H9rl/UBkcoV
         d3y1VTVMiFj0YUJYi9s1uPduFLEpzP/wbnN5JB40h4RWjp41R51Y0fUlKgqummUC9w32
         D5ykya2evN9JagPGfvOCiVwPI3u73cAccSx2xeXLVgLD4QlxWk/vlSep2h423BTz5S3E
         8k0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFWQtVMLNH4m+Bd5xI+eIWMAEDCQI5GAcLkZf/vY684PK+/U68Pf6kvdeweXLyNHhjC79DNRx6@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzfnpo4Dv2H2rO7kzzOg+/Pg52OvUz2kKUAS5WGlR9UDeTFRdlB
	0C4rbTRWcuuj/L5qQlv2NS2UylmqaakjfWxoOh8ws5MIS8RpKXa8NWB+1JIYO4FFAgA=
X-Gm-Gg: ASbGncsi3euTEEqtfH9/c5GNUlTfatyjCbvWv73LUlt24tasH5LOFsMp6pKXCLv30af
	I1lhmAwS8lrxXsMTZa/CzItxq1csCvGfI7hIeb8Nq2MxvZU/Iyp6psIA+8cqjynOtXRTjIMlG0v
	Jfum02TIyF9I9P8oEi9VU5+13G2rjwUEzTikPuOVhdwb88WfaiiNSQ9TfDaK6aEDibhmi6P7BD2
	hm0pEx9xbl8OKkkCdS/HjcLgaq92zKfvn7U7qOWuwJyNpFS+XSafRZ3idgaUvYSH6ZafGDXpQwc
	hWTSosK2B2Et8cCGZKf4YW8BSv9vAv0hByUAtFG1LYpTEvYNKsUSaXGfstqNSWdmF1armiU+cs5
	yT+97Xg==
X-Google-Smtp-Source: AGHT+IEF0Ywe+cL+eAa+sV52E0T3OS842+inZCI4W3bdgUEofPjjfLEouf+z537eozekiM1TZvLphQ==
X-Received: by 2002:a17:907:7e9d:b0:ad8:9e80:6bc6 with SMTP id a640c23a62f3a-addf8d5adf3mr171302566b.22.1749032629796;
        Wed, 04 Jun 2025 03:23:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 5/8] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Wed,  4 Jun 2025 13:23:38 +0300
Message-ID: <20250604102341.2524186-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19006

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 08811b984f5af8eeda4fb157894fe9bf230ec1e1 upstream.

The debug serial of the RZ/G3S is SCIF0 which is routed on the Renesas
RZ SMARC Carrier II board on the SER3_UART. Use serial3 alias for it for
better hardware description. Along with it, the chosen properties were
moved to the device tree corresponding to the RZ SMARC Carrier II board.

Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
Fixes: d1ae4200bb26 ("arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 -----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 4c594773c4b8..bdf1507fd2d0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -43,11 +43,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 244f77925239..3c810db81861 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.43.0


