Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F04C0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.41718.1737546772836929301
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gbCT/GDd;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4368a293339so77917665e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546771; x=1738151571; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=gbCT/GDdG2cPk0Ua6sIvUmby2cPTtIdbnGsgRFz7BRZRqQnYo1LZ1tZ2/1Wxk54OfP
         1BOhqFfmiQl6j1sMFz96/jKxQwy8EDhoJJqrgDoQkupwrHY69ZO66GmM4MMZA1Xk5OXP
         XbapYUj0XHv61xC9hrb7lc1WifMVLyG7X8+f8hCTX+PaYM9K0D5oZgtF90faUYpT+4Cn
         v29PosQTfG5FuEK7I9YHTyb44HgMWgD8T021Y1AA8g+eWZPEDrA/9Zd1GI3GvCr/gsXR
         ij6NGdA4URemoG1ErmGE6GZkUXc0oJWIphURylakKUYrAu3BvGRffpm/MS0/hJ9JBG4L
         vmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546771; x=1738151571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=uanAA9vSKe0bemFlcOMCcA2PZ3Br553JREL+YqED0x+BD/qYTr3fQxK3HdbNrEOM3y
         aJ5wVncw7fvYUjOD3s6PFYS1sMDUV0CA2gT++iVot6uoJ3SOPr5zsiden8jBeYG/7KuX
         Q4N5fvKE0DNnWOtI5S215vlJSs8E+5vSG9VDNH5izv3bUvQ1NL0CHwqbUTkeqW6MUoSU
         NPjNsY+J3yfHdmsmfYueH6u+schG9j31/fIA9gWSWeFOLTJPFc49mNLOSk24FUdQjZlD
         pUIraej2iavSWY7EimthtYQQuqenGGWlTzzFjgMuMQuXJnPxsMkuQSGtB9moEVOBGGLh
         hHqA==
X-Forwarded-Encrypted: i=1; AJvYcCX3RN2dFM2WHHYyPgcuvqanFksxrm2PyLKzC17o57s1ayt3Xy7ti+cV/4krFO2/fRr8hhfCRbTM@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy3j26LCf+Qr+nqAWjZwdQbN3dvHwbc+9hP3b7t+pHekHhPigEb
	PacEMhgbHBpbxJgaT+jk4YT/uzleLHOdu8AK3jVR7lkVXjWpMGINbkMSiYRXbM2odRZI/eHne4W
	t
X-Gm-Gg: ASbGncsFs05CSiyonUQDW8dlBe2ZHT3dfQC82Q/2d5m24aeczZIaeiM1R1yeI0BT+1Q
	otFMuoTfIg5uNlzRolUC2nZfcEnEy3SNcai7eNjODbgqcpEA30QT8LdTEdkP7L7fZvpewQ5ypsl
	91w11XSTXdyNJQ6QDI5P/EwerQnYkwPMm0Wmc1vkKvf0togLtexvtJtAv5UNgiYpgA79nBBbJMi
	y8HmFhNc8jzLm21z5RcrkMXf0pUqGxlsv8TnBnF8itoBjUfD0bxjxLfHRnT27f7VYnBxHRlUNNN
	ppXmrfX/L4iRO4G/Gse2IAI=
X-Google-Smtp-Source: AGHT+IGypMvfvxMefeHG3AOQJme8FWutTvv+a+kEgV0QSm9qilFwgraYggo1GGMpfSDn/YOyx4cZ5Q==
X-Received: by 2002:a05:600c:1988:b0:434:fddf:5bfa with SMTP id 5b1f17b1804b1-438913bf072mr190379275e9.2.1737546771293;
        Wed, 22 Jan 2025 03:52:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 15/16] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Wed, 22 Jan 2025 13:52:29 +0200
Message-ID: <20250122115230.2885344-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17593

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


