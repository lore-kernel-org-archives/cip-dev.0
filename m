Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D46C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:00 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.41719.1737546774104889205
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jjTKkGbl;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43634b570c1so49589425e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546772; x=1738151572; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiWwby+0nhz5r1URk4IPI41lZP5NmYIaMigly9M0E/E=;
        b=jjTKkGbli8BAqF9e39KfTVuDmxQZdEjNfqo7DOwOofK62huaVQfLHh6mWpd0QxadzO
         WE+/alo8F7ib3riQpKI38yZ+zqptG0jGSfls4JvOXAfaYWqovXzPlZLHbLwb58Gb2FS/
         8V4mBMKh7JYnCqwPIHhglEdkjVfZkwWik8lBP8Hd4lRXeQiHVOCNyidyiwk4GJi795Uc
         4oRYXGHAycPpQ8MzchhEWWqPTdRjPQCSJU9GfBaZaIyK2q2bW6oEzQDyInTZLP+xF/gh
         EOREVhKgdevp9JvfuOf1zOfASksUAMxuPa7XqSMDGAr8aN+nS1wNIZbI87U6q76DGAqS
         mXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546772; x=1738151572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiWwby+0nhz5r1URk4IPI41lZP5NmYIaMigly9M0E/E=;
        b=cjpMpqVx1ZshN1kCsDhuO3Oljg/kUgBqhrw5/c4K+dGzDWEDWG/UjZJjy62RaOuyrh
         baAIGqZ9X5fX7TxYSvVGrYk7vjwReo7pSwg+zZ8I7GFM1qaof+RUmyuEthUTliNV+Z+c
         RKeH8FHPar4+xXMVRezAPm65mfS3hHBU/eN4KCUtyEsWGhERhFsxSMuIp02HLTksrKIQ
         2yXbogxS0MKjQO3Mum4PabWnWw05MNOACsiCt7C20xKU/isF46tqcmBWTFiLb0Ug3/Md
         kN/Daj5/H1hkTodhgUT97NYXqCi15BeczncOOHrmdoL67QPuDkQesJs7AAVlrsmNHCTC
         PVrg==
X-Forwarded-Encrypted: i=1; AJvYcCUjd7owzaq2WAc5Dl38jZa/M1CPaIxG7V8k6Z5vzEqxraRy2rA3PQqB1Hi1/quw0rH33px1eo2r@lists.cip-project.org
X-Gm-Message-State: AOJu0YwlBDFPeVv91qkGg0t3RY42stcYoiKgDAsHeD7GFzZOfWkvewrW
	dbQ9BS7tiXECRWnRhuuG4NMAaiVngTaBzP8Ecv+bVMS8ozKxfi5aI6aWUiiO/w8=
X-Gm-Gg: ASbGncs6y1P16FFmy1JLPtMBS7bjir9bsGnlmms3M84MMOFTVrDA+2VGNcgL4hgySwU
	9jYIHWMzvFFpO3Js1in/m3+sw4iz2ml+di40yFudu4Wh/mdnFQcycivXM/7I0h+NZoNunX7pV3N
	VUA+96xGm0fk5yam0I0z5yMtZF7ZuymezPSCw8HaWqIgxV8zZ+lAA3Sk5GSsS1yCID+mn7qvc6j
	USJt2d9xpHbGa7Ot039hoKCsvRM/FBA9G3kbHhTwQhqGuM5F7ol7o8zg0jETmILNgKESoSheesK
	ueSAMAUe11HXi8RDBiQrTeI=
X-Google-Smtp-Source: AGHT+IGZlVBqhuKqMflo0EoiEMPy/uQusgp2X/zmywzZyO1oiBvxSyzKcpvkHhKqCG2F70v4FciCaA==
X-Received: by 2002:a05:600c:4f42:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-438913cf805mr206261185e9.7.1737546772490;
        Wed, 22 Jan 2025 03:52:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 16/16] arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
Date: Wed, 22 Jan 2025 13:52:30 +0200
Message-ID: <20250122115230.2885344-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17594

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c520bbb523304ba98de9ffeeb0ef289921434125 upstream.

Enable the Renesas VBATTB clock and RTCA-3 RTC drivers.  These are
available on the Renesas RZ/G3S SoC.  VBATTB is the clock provider for
the RTC counter.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping only RTC and VBATTB flags]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 297d671306ce..14a6a6978714 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -854,6 +854,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_RENESAS_RTCA3=m
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
@@ -926,6 +927,7 @@ CONFIG_SM_GCC_8250=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_QCOM_HFPLL=y
+CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_RENESAS_OSTM=y
-- 
2.43.0


