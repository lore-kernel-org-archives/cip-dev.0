Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0410611E0
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18281.1773227070575037844
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=h799Meba;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so43310335e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227069; x=1773831869; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owkRQWqPAf/zTE+3+JgqkVmA6xvqdIFx857DQZR3d44=;
        b=h799Meba3Dvvireud6rW4DB1JdcHPJc+N4i/LE8mMcimjHg0HMseJxn5KTFhhW534h
         7ciTJdEz/20IlWIUQ284ttTq0KHkpaqBqkmYsDyKWm2QHggcM91k1PZxVlnu8BzJ5nF2
         SABTABwOwqxUUPtfBEdaVcupwgg+jshIsOwE2fP4G2Lkdkgd3VT/Iox6hk1zMZGhsUab
         kDQjB1hzlsYx55+2+MSvn20D8N0hM2/1mEes1PVooGCag+x1tS4sP5CYj0CLujyCSGB/
         iEQm5k3bMEFGNHh3bWznrOfYdzV49IcrsURwn45rZVpxIE4/F2Bgty5WRNwpce5AVgR9
         8OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227069; x=1773831869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owkRQWqPAf/zTE+3+JgqkVmA6xvqdIFx857DQZR3d44=;
        b=FxvLjWxw/fzgquE/sWQreETzTS4EZ26AL+KdBV+hQFKg5ttOvYTAGw0tOEvsTBZwK1
         KTyYsfzlw+oCoUmYvMxPSkvOTm70YPAqe67NnrE0McrZtGO+hyE/e4PH07GhpOEWt6s3
         csbBtDZq5R76QHYQ63E3AvH5wYTqgmFmIao4tg5X+2s79xh9uKNdpmwmZA7RvvGcEe6n
         XSlKBdIZs+OlGSuX9t7i2JUIWYuTqx/YH0e0KpqbS0mfdYkVMITPQBbGsKwXLl6H10dY
         Z7JGelePXiiqp70Trok1NPJ5CRyw5cvp6Rm5L8nLndoVv66pJ71E0IfyjQFDq1GE08iG
         luEQ==
X-Gm-Message-State: AOJu0Yy/Mi1uJpgOJOzYa68RFlLcay7jFu/R8xX/zJlAHmIivhr3E8pa
	fTGxGf6+Qxo0yv28RiM+le1u2NpISs6WLeWjLWuh2ZwR39IhvnKmK2+4SOi6qKtS2t4=
X-Gm-Gg: ATEYQzwcE77c2KIjP7qTvPGbCRVC0/Nj6EJkqX3Mgu6zsoEbaPXzWkZA14LZ0Jr75P1
	zceD5cvLPf8H92U8CVGWFdezbHZ/m8L3VBHhxuh3dN48CvJngDOLc5i7DsMVBPmvjSkMDzQaAOA
	fBaKqfa72sBqlfn//MMzuzKTPF+hfcFDzakirtrLekCJSCcxfsm4bJXrYEo2kED8/ptTH0+eX6A
	GlAhMNc6HHLzqJOFAsr+aEYNsLlk4ehZfNlx+trZ7LPV02sKwrh0swS2KVtIHIufHFRHA54AHm9
	YgkIeAunJBxJBIXAocPCoca41DbVrY6zfIKvY6Cp0eCgUAFIITK2Pwh+w1rcan4q1jHa41wNTDY
	624l4CMhP8O+QAMXsSkpajFGD3WcLJBtRyrO3M+3lBOTSFZaPz3lcj3B7E9AvxoqRy8pJ5U1yqQ
	05Mal41eYqSz2mDpZk1jGWbHIaIPEUwqpwp9aSaCQSCmQfsPlTo7jf
X-Received: by 2002:a05:600c:1f86:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-4854b12c1f1mr35131315e9.33.1773227068655;
        Wed, 11 Mar 2026 04:04:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 23/28] arm64: dts: renesas: r9a08g045: Enable SYS node
Date: Wed, 11 Mar 2026 13:03:52 +0200
Message-ID: <20260311110357.1938200-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22302

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 495af7647560c2b3a9c3107ea81dfd7d7c8a38c0 upstream.

Enable the System Controller.  It is needed for SoC identification.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250123170508.13578-8-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index e56f1bf311ec..ddb2477675ec 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -481,7 +481,6 @@ sysc: system-controller@11020000 {
 				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
-			status = "disabled";
 		};
 
 		pinctrl: pinctrl@11030000 {
-- 
2.43.0


