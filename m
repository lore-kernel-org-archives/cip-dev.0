Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B669C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:41 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.7441.1737709233018754483
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iMCRrAin;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363ae65100so19370605e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709231; x=1738314031; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdoaaBkruq8UaBR6aG2nxEBiJ4gLHmsErL0xCb1P+ys=;
        b=iMCRrAin3ZRDk5YR6xsyMHQHYfAX4jhMn21UoTRbtLHPIjHK9znJB2D6bJl7pV5lTx
         pQuFnxlSLV+I1bZppRoSKRTxER2DOB2rjmBeNf+i0Y41cA7H6x0pIYafCmfoWdcGeTRH
         xeivq+wUegM6il6yp/oAmcwdDSHJfoVoP+ZHQTFLW0mSB91IkC80NPBRh9j2g9td9x4M
         M4YFSRK0DdxzWGILxNmSNzL/DUPMq3GhwmgOEBjMBEc+QronmAISXxHbceZw4UCA6jEm
         dDiHQl0CNws7LFE+GXgmcrWe6N/i05E5vVafGHRtADxj8msN7kRb/rUrtBya80DE93m+
         ocvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709231; x=1738314031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdoaaBkruq8UaBR6aG2nxEBiJ4gLHmsErL0xCb1P+ys=;
        b=GsX8dQa8iD47Q07jn1rm2wF8NFRo9NOpDqDl804KrPzBGlV0EA10X+6cWX37Fb4diu
         oLKwz+mQUhz/rpUym3Y0dyL8Dbx+agMsF/9Lo16L6OWGGnpASgJ6kh1p6lLTF8595APi
         FBbbScNu7rI3WVGYhTJxW3MFY0em2smAdmZcyMAjHpJ3r3rboXTPnj8hBhus0EVo26ey
         qUIvzAOicLB53pCnQo+U5vmuydrORcjmJLx0024QnmSpObzGDdj/GphG4Q/H/Zql+bW/
         MKir5DLK+Qo+KUcrIkjuo/7Vso103iYPRdQR8rq5/gSqTi9iZMpxWs9y1y2LhO2HCqkZ
         DdXA==
X-Forwarded-Encrypted: i=1; AJvYcCXOeuA/mL7YNPAk/z6ICT+2hoxJLMmyzbrgFgnt9de6ipv9lJp2yAoX+bFa/7g+f8vkCSCpqEgi@lists.cip-project.org
X-Gm-Message-State: AOJu0YxbTvOGlYtl0xmr1uCcmWbLmTt813TKHNuIGDN3VLYsdNgfc1JI
	huzUeNFnB0//sGPByX41TPEoLVnS3ik9QmdXjelnhaufofAeVZ7Nw4yxvkfXDjk=
X-Gm-Gg: ASbGncsgxifhZZbtsGDvkUVZEabt/TMdAkw2EmvJ9lProGvhPqj/lmb+P9bBcPnwc/x
	pRVc7FG2SWsviwSdogvjrY8HvXw7HC7dGPqptBuLjtBdsunkdhzNcZaRmOYmEzynNuhjPXr/VVL
	sYZChmQPz7/KPmwxfw+bVx5S8WOc6xB0l3lQbBJqYqOVmCBx82EoRRCjIB/Vkj2EQ8tszwuXgNS
	jWI7+Zwu4H49VCPr/+K/Kenx7C48JXRjqlmlypqFcJg5l6a3HJGeYcsHRj6yAQu6fPFz9gRRzfS
	wFk32RSPUxhT6oiditBXLFcNCoEsBOTOJw==
X-Google-Smtp-Source: AGHT+IGCTMy5ViNwtQ2l6ka4lHJiZSoV06UtoYt9QAzQxUWaRuSh88aDvPlEq3j+uD1a2nnywgetZA==
X-Received: by 2002:a05:600c:3d96:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-4389143b5dbmr255301105e9.24.1737709231327;
        Fri, 24 Jan 2025 01:00:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 14/14] arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
Date: Fri, 24 Jan 2025 11:00:05 +0200
Message-ID: <20250124090008.1401077-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17636

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c520bbb523304ba98de9ffeeb0ef289921434125 upstream.

Enable the Renesas VBATTB clock and RTCA-3 RTC drivers.  These are
available on the Renesas RZ/G3S SoC.  VBATTB is the clock provider for
the RTC counter.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping CONFIG_RTC_DRV_TI_K3=m
 and CONFIG_TEGRA186_TIMER=y; although drivers for these are avaiable in
 the v6.1.y cip they were not enabled in the previous arm64 defconfig]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6f644364b743..a15bfa82fe59 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1016,6 +1016,7 @@ CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_RENESAS_RTCA3=m
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
@@ -1104,6 +1105,7 @@ CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
+CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_RENESAS_OSTM=y
-- 
2.43.0


