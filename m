Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C38C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:50 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6749.1784024321959760269
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 03:18:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gMqy00xx;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso31996595e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024320; x=1784629120; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhW6WL26EbKDwg2e+wXcJiUB2YIDPuN8CXjwLYt4hBo=;
        b=gMqy00xx3sI5yzILO9XhlhNKmWXqtFGboAFswOgNz28Vkvi6ug0uiuUwd6ml2ucudz
         Jj9EBNcmNOYNEBiywptXUnugM45ysLPBn1ow/P7KR+yqBRcey3FHdLcbGA6juYdTf7SM
         qLimsr5i3nIUnCiAnp2gn0NHf8CsMKVt6gDpedJ0AzQJuCKCZdmogpAexxh4TXd0ILVk
         VlKNtr0xKIAZVScDUvkcCZLzn/ILqxl6XkWPlFV1ZAvfBr97Lt8p3d9z0Yptf0eut6yC
         SHF9ohHh/YfGP6kskYFfeDkMWjuhOCGL8rXyohTSemsNm2Jx7VO1NNbfuFRqSW4nHHdY
         uPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024320; x=1784629120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhW6WL26EbKDwg2e+wXcJiUB2YIDPuN8CXjwLYt4hBo=;
        b=gEz9rZjrVm92enKANJAyOlaO/viDxPWh6QDAHic1XkhANCKMmZUnEE9lLfYBp74+zQ
         NLmAbGQGA4b92dwKetnmNbjmbX/+jYbmMKVa62TgMlTIeLcGVSsxPhlHosDPPIg1gh00
         rYmmdLyW3TG2duIOeW8CDxIXMEOu8sLJY4LPSdYhFyEnNuxHjEQH/10EZA1eqCd/4Idx
         A2IWIyrrr1EeVo7xIqhLtmEZFX9Q2CW75uFsgwR+E7BLJ7H0zYye4ShBNO8Car1Uv32v
         cSjBQn49AGjezRBWdYijv8l6q5wsynzlPJkwn8JkefrvaUCBEBw9mxPTV0864Up4G5+w
         JROQ==
X-Gm-Message-State: AOJu0Yx1cTfIPYVde718zjyu/uwuIqG/sMhCeIHcgtVdZ25mrf8h6NjQ
	pbugtXdccvmpyevURU3Wse+p1khaWYTHuH7TqI6BFBnwXGwEJ1YIpQY9c6DYdW94
X-Gm-Gg: AfdE7cnxw+o9jREr8tu4wgpazppLwPyFNOCHW26dL4S8kQNtzE+lEWfS1nbapKvloOF
	E8VZIBs+CY8RFZxiZe0sZONAhPCXpe2u0Fdf4fE7AieNWFUIC+luHI6AsXolmwDsId6nn1/pb0y
	B9vKx156BCaMuSvXzv+xVdqUe1gdUAUIi5Q5m05f0RgAFIFh58AHWblAW8vzpGf36gGfRjvBSFd
	NHG6rmcyC87U05x5q4Z3xeHB0IcZ1596dDXa3JSkM+JN7CQFB0ptUO+sGpHjSeh6bcqjXq3T67B
	ZAFd+wDuJgrn0/8HJe/oXp1zIIhoPY/1jf/a8zIxuFR9zTa578wZ5mW+7cm4kJwncFpnfxZGqwF
	rRQE4mQaSZA3g0OE/uZC/xaHmBDdCMofWOoDEJvnURG6BVcVnHT69ZzQqc1CYMgpzXl6RXlMCqb
	52NfmDJZMEYpT8TElezHyBvYGzSL9ZkTiFaCXo
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr133386355e9.26.1784024320092;
        Tue, 14 Jul 2026 03:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6218:8bce:b637:b72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2e8f07sm59103145e9.7.2026.07.14.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:18:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/3] arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes
Date: Tue, 14 Jul 2026 11:18:32 +0100
Message-ID: <20260714101836.8039-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
References: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 10:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23581

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit dcbbb1266043d1d7ca1f129d2ca58a6ce8e04cbb ]

Add the max-frequency property set to 133333333 Hz (133.33 MHz) to both
SDHI0 and SDHI1 MMC controller nodes in the RZ/V2L (r9a07g054) device
tree, increasing performance by ca. 33%.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520115144.60067-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 01f59914dd09..19b5c083d601 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1067,6 +1067,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G054_SDHI0_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -1083,6 +1084,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G054_SDHI1_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
-- 
2.43.0


