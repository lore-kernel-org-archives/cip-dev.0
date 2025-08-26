Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDCCA0EFA
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 11:10:15 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.61688.1756206608409302387
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 04:10:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kISyXgTu;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so11315139a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756206606; x=1756811406; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHpOMyfei6CLwkzRS7JmyRQI5+3+x1GPmgYsLVnTlrk=;
        b=kISyXgTuPeM0X8XWvO6Dehlldc/+rxdv1cEjSGRKbbBPMkGB3vwK1rM4QK23kg76jz
         loHo8FhbSAQY/ev937p46v8cqzVKL5jclcgc6gKth/1EjeNfpnkzjXNRc+Ghlli/90nJ
         EVRaYYwTWOxu2SNIuWLPKffPWdxOxQAMLGTQQCAWJbRspXIGMjilOq/If25658Bk4F4A
         YTbRCRGQh6F8asY3uO2NJd0KHBkdUVRZBEuWGxUM4q0hfs50Yrr6y6GPOXiIi7DkaiH1
         0mIfxEuPYEbNx9OJMQhRP/B6CvPBC74rCxu0UIGd40A0hGZDwhHIGItC7Lff5ED3JdYB
         hPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206606; x=1756811406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHpOMyfei6CLwkzRS7JmyRQI5+3+x1GPmgYsLVnTlrk=;
        b=BhHAGaUNsq/28kkj4umdTm9KhDIolvNRla5+q7OFvUZsYWXJzgSBrvcNPL8E3sUyfT
         na5dO2UKWUgf3l/1dT5IO5pej3KiXO+XwnX7U/ZfIj6tqBrNSdZ2SQISY+SAb75vb8m5
         BLI84rR+52a260Ns3VipTyQyIZqK06vR8PryAfxTpUT+OLyCUwZvlkOscif+tPnwAO2c
         05dhSvDCex1Z8V6Xdg09CFEr9UyL7SyMGTgaHzNG8M8TOWGmd8yz2s9fS8RmkjjqCr0D
         QrE6FXQXtCmGA936BotCqduYSP8k4f8CrWAkvngB39LR0W+hBnwIyg7DTOPoO/sKDdIT
         uzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdBuxPra8lxku/f3Ut3c+lbY9FKB5/xPxL4xxkqZse42mTo9DsJBx1Pu2JH+Q//QVfGWX6UtLZ@lists.cip-project.org
X-Gm-Message-State: AOJu0YzSpFJhfS9x5S0BdK3gRMIumEw7Wbm+1iZNwsvOxg0o9InFv6Mc
	aD7J05tXJeujFkQTOTavSBkb4QYudJBtnN4QBCC1Yhth9T4LVPVECCZ30UACs5siXgA=
X-Gm-Gg: ASbGnctDSY11eEkzaruqMJgfBrSkhnVYbIFZrvFWiA5ZX16tw3ZDMqGOBS2Dgf5er7s
	gOOhhybxuItYcxrTGRLLB8p7FOL3xsnxBMV43gb1/Pc7JzV6gWb3c6Gr4jWfpG0Eu/u0NJ7NLNQ
	8HhU1/zrh8eu9leR003O4Wron5OeF2QBlpUBw49dw+n/XSleFspbI9osREY3r+E5YPmcgHHPTCa
	tYHnMx7LPmlRbcVhLJuNrrf0xytT8Bu8FbDWLSIjP9qjZrcDf3YyuczoEKW52xO0OIxHidnS5po
	ys/Gj/Kmzp4lN3nHl0bQUu1gfbaEwFJnUtUySCux+0H7iMaKU0i1/eZ4ymvkY18GFnflF5j6PZy
	BHfVFzlCRWG/oCF6jH1EuwOCZeM2DOTmVcXj6LVaxp/nNSJ5T2AUZNsVzywVeiwRV2cdDIi6HpD
	RziNl4O4atyaSq0+iYTSdBACR89LSF
X-Google-Smtp-Source: AGHT+IGKBUBUH6pqwzn+BFdKDVzs5+Ln7G5IANdKHwqE4gyyC5dpa5xA8cpqyV+qBT56YABbcwlVqg==
X-Received: by 2002:a17:906:f582:b0:ad2:e08:e9e2 with SMTP id a640c23a62f3a-afeafec9809mr108303466b.27.1756206606256;
        Tue, 26 Aug 2025 04:10:06 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:f276:8e0c:6e17:2570])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe9c908431sm182679766b.92.2025.08.26.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:10:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases
Date: Tue, 26 Aug 2025 14:10:03 +0300
Message-ID: <20250826111003.143245-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 11:10:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19964

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X={0, 1,
..., N}) aliases to update the DTB with the MAC addresses.  The
ethernetX or ethX aliases are not used by the Linux RAVB driver.

Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 3f050a28f2a7..3d707c9c6e46 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -20,8 +20,8 @@ aliases {
 #if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
 #else
-		eth0 = &eth0;
-		eth1 = &eth1;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 #endif
 	};
 
-- 
2.43.0


