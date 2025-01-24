Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0ACC0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:11 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.7459.1737709267305770103
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=I+HnWjdG;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso1983805a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709266; x=1738314066; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+z8rDJB5ksnUk72JegiGb9Xcvdr9FNKs59p2tUBp7s=;
        b=I+HnWjdGiVM6yJ9Lt3ryX2JQCxRGhoXyvPE0jL7nQ0kLRZmkS918fv5vLCfKPNbt2J
         w3XHhX1hZPl6Mejbpaf7WuKhIuYP4Xp77hDMcoGnALzWGNa3rrjczfAk1WMdLz9lheHJ
         jZSHKCpu3En+IB7/Zlt5GC0/7e4NfNxIJnewGU7vihBROFeXc1sod0y4/I34EIocarQT
         JDAQbHlDrqYzhvtj71eY0hGDUfMlgFdALa8dmbwg3bnrHPCaXBEdEPPU8ZUs4WQHVpob
         Uedv7ZqLvwKotOyfkG44+PPD2Lar5rPFfNoTHeAQbl3ChkP19i3JcpyQdwO/yHXstq91
         pZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709266; x=1738314066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+z8rDJB5ksnUk72JegiGb9Xcvdr9FNKs59p2tUBp7s=;
        b=PMOI+lkEvF6YcC0gOd3m4B8wdtzjP6D/CPr+umXMLnlDNipL0QtvX8s7KSbeVz39mY
         PuIidb1OH4OvlX6asiGrNT1WYGnIkjx10v2RHrWTcJT/MZ+oYbuv7QC19+VIljmZODdG
         oD/UbazgaVbbUErm97Hvu8wShsJLZJiyJ1xIewiSCZv3YPvi5ii12JWKf9o6AMORm4Im
         HSjcM041RuERxAiCrhHhlyoeWXVVRvbKifaQS0BsunSepOnPWymB6AU8db9LRcibD/2r
         O0QhuJlQ0/n5q1iBFKnu9Y5nl8u3H/glecHCLpdhbAGBjApymtGFpVAaH1K7Jwn+1hs4
         0u2g==
X-Forwarded-Encrypted: i=1; AJvYcCUJl3/saRGs75Y7JuwoqYYxIqPm7ruwjo+Hj5VucaG4QEnaibCBvdsFuFmFuNw12AqhBOUSJF4W@lists.cip-project.org
X-Gm-Message-State: AOJu0YxnaL9hyPncRO4fFclMbznKkkPvhWcOsyIvxzLuJvaBYb5J+Jfz
	1JYEOrzOvGStohmgdZ6gTpXPQpTwIDEtFGP+bj5+hogVxcwtyEBlj2A2EEaNVBE=
X-Gm-Gg: ASbGncuKUyT2/wHbwzQqrHozyI7SQBaS86oyV04n9f+bf0sERHAOKFYcW2dJjx0yavk
	fbzInreYRMYLmqcr/TYUP/sA+nTT3YX741XO+bUSL8I65IG3rApJ4QD6Pt5dAuGm731tL/tgt3C
	BIeOofb3pCU2tdtRlM9B0xQQWjoVMHnpOkBzY6Ymn5xtrPVK+3XB+mRnxA0x/UGYPbFhV3zsm8g
	QOjKfpkoU1Kb1YR+vb7wh0854rxNTTQLKnXHjEI2kZu+KtJ/+Fp2EyzVX5Zdommy2qPJRIwRgFB
	UXnOgpPfT3eyOKKcuC+06eeQgcbjyI1EHw==
X-Google-Smtp-Source: AGHT+IGb2Vf/9jNINvHWhFmWVXOPn3cSfMVlDJwH4rL6Yl+LNAFolXauZhaWiw15KeB7DSFSTeXRog==
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id a640c23a62f3a-ab38b2e71e0mr2632279766b.31.1737709265703;
        Fri, 24 Jan 2025 01:01:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:01:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 16/16] arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
Date: Fri, 24 Jan 2025 11:00:41 +0200
Message-ID: <20250124090041.1401132-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17653

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c520bbb523304ba98de9ffeeb0ef289921434125 upstream.

Enable the Renesas VBATTB clock and RTCA-3 RTC drivers.  These are
available on the Renesas RZ/G3S SoC.  VBATTB is the clock provider for
the RTC counter.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
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


