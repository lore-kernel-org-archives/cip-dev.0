Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B698C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:41 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.7440.1737709231799602478
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SwTzmwJK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso11922265e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709230; x=1738314030; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=SwTzmwJKSEknanGvFEGpBMvKrykkH5f74d9H3xKnk02ducbGWF7KD1LzGkwRjip79Q
         MopiHc2yKstlGY0kMbnFodVtoK2Qmbi2g59HGNNiazAhnnpS09t/4MrtjmGnRQbFaXh/
         AKj4Ghtt9wfJpsmjAcbfXCB5LzJEeV5H1aMEOv7cpQL1g0osA3ClpN7XIDB2rHd0LpBY
         MNiubaGW/Wd12CMHGHGvOqpcfodkD4Cv6NGNeJNJv54P+pRcPEZ3tyEoJm5JRJUEWx8n
         uW3COe33lwbfJCAQtysZY5Gyp2NgSv3L5sjbHk+I5iqrMsF6yK2HShAmxsQAvX34kUlK
         tC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709230; x=1738314030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=qOwy59mrcUlg05ZeeRuekdwkNmaT/khRcJSVIUq4u8o3qV8dbBXHpa68QnV32vVxtZ
         LNf9/84aTJq9vzLluW58B1mP2A/ySjm5Pjtnmkgd+a3A/RH4oE+yJGxpukJexBK7LQi1
         wiIwdj9yiTEiCOdjtyVNMzirO1Xad+85eBtrCTsgmvKC4ZuWI1OADxEGYc+WNEcJiWS6
         mEOJpSpTZHNKD8ZjpINm2BBuumxonLl6eNNehPqrnN9lgBgJ/YLZfNkPkLRXywkN7e5X
         tTaQpSWlGXMHAJxow09Sx74P9aAx25D4tgvtDuBnlnLpjs6+RZmJmlkmFpOyH/92HfwF
         c88g==
X-Forwarded-Encrypted: i=1; AJvYcCX6vHNGclAhmt1w1X6hLQCX+P9QD4Po7VfbAixaeGN1cYasqySHGxZ/wsZw6XWhAhR0LtxfoNEI@lists.cip-project.org
X-Gm-Message-State: AOJu0YyXu9Xgz/2xaO2ouf5euBejycn3e3GLTx7VTkK8Q/snh3mvNk3/
	c5tqHSlaXxxzdHLUnITbzvY2BtKV0C4oogtF1xQyHnATQDqpBcWSEVGq6McGLxY=
X-Gm-Gg: ASbGnct4AwYuvT6iLAY6728BzRBWIFVMFHJdxhNnpL7P+d9Ia4ovUnPLokjW6bKI69z
	IbDlw7ocI/vJOw5a9jCj+t3tPZaWpdxseYKwqNYDfpfva9RBT0FIbmYPHCB9J8+yjb6kPCygVyw
	/V2JYmxe6GCEhzggCqOnI9lAmmS63VdMXOtIEs9WR4FFMVsSABGfP2LY59r5rMvq9hqHugOVls9
	A6uOSW3jqRWV0jPfSpi2C1lL9VFqiRylomyqA/bYmbWWem14Y74IOpNR5uj4Hxf8njKvzMvjAjj
	8ZHKIqA/IOJ6Q9QYtAjLZIkGsa5BFtEX8A==
X-Google-Smtp-Source: AGHT+IHfHlNUT3ZVLyfQvsR2W6W+AD3US3cGS4DwxW9vR21eX/cQi0c78LjxMm+4OYznvu60mLKguA==
X-Received: by 2002:a05:600c:4e0c:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-438b88568e8mr59144255e9.8.1737709230231;
        Fri, 24 Jan 2025 01:00:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 13/14] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Fri, 24 Jan 2025 11:00:04 +0200
Message-ID: <20250124090008.1401077-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17635

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0cd647cd53db0315361e41056e10739a5ee1e668 upstream.

Enable RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 67178d8c4108..b07d9251d182 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -342,6 +342,10 @@ mux {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &vbattb {
 	assigned-clocks = <&vbattb VBATTB_MUX>;
 	assigned-clock-parents = <&vbattb VBATTB_XC>;
-- 
2.43.0


