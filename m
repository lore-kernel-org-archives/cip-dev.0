Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C5CA0FE9
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 11:10:35 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.61693.1756206626706631510
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 04:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KLWH0cPH;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb72d5409so915668666b.0
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756206625; x=1756811425; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci8euxCDn+nkGIsA+0XEcrGucCG+qJ8SLfEdtnFlyX8=;
        b=KLWH0cPH9gS/nRHhc8eZri3FGRSnnPQNvPgcuLqftF44vjPJYnPlEZ9qcdOQ3qG0R6
         E1WU4+6cKFm4OxGqQgyCDAAC5ISQzCL+eA7Yxl95+tfUdVp5t+W9SUkndz0jl0gR0R3c
         Z8ff7u898+B5oaiKp0qavJYwoc05/T7ywnejtN0xMRKx8v2RtlgkO0lkZyt4GoZzC1H+
         rd0aYRggc+7aZlM//SfeEODolAkKxgXioNsMrFOlvQJ93umHBVc1kpZs84F0p2srJcqY
         Fuh92jEWoUNLa6O/kuaHD2YpIG52NqUlNpjBK08LjS9N/s/ag5hU5kjBFcXpVeZV2/VN
         vZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206625; x=1756811425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci8euxCDn+nkGIsA+0XEcrGucCG+qJ8SLfEdtnFlyX8=;
        b=u/exD805egF8HIuv27TWF8M4weV9/PpQ1vjqnZOVMoLQm2EZCq/4j3bX7VGIe7LK5s
         jWlfkc7Vv/fgzdO3w2+M54jiDUTvcStF3WJxM358er4zMpJ6zAE9+VAogjx/+ghm+oJS
         Mb+2ogfmGdrpXQLL2dyeLIyihyOdABFCwu/jVrTpnmMJunmwqXExEZ0phcGxfg/lS30L
         zAKnbaKtg8XFkWmAR9CsEzV7iMta+1YWkf8M8v24sWadqk4fSA2tRHuo6e/xQwBvLUb6
         ctwOUQ23a+hte1yEqw3CzimcsP42Fbc+4AhaQbBegDDm2lg0KScCoQQxMqSjJiXFwYa+
         qL0w==
X-Forwarded-Encrypted: i=1; AJvYcCWs/DWcPfZMCHcIrvxTHWu1tKy1mBAnhCD5hLhkCRnSqJx8Pbay3eI7RNJN82kQUjcPojnKxWVE@lists.cip-project.org
X-Gm-Message-State: AOJu0YwoVSmRMJsNIkpiEwAy36rda3EPhUqNoa2oX5yL6m7YW0i/ZqAs
	ZPkBJM1mmXSolqPDEvmfw0aZUHLUZZfBSkNljhRpCOqG7oAV0oUWbrlmsHt5EXd4Q/zK98ysMyX
	+l+/j
X-Gm-Gg: ASbGncvJXws35ilXk7eSdbKzVKCBNiyr4bHytrnu3qtFKhoXDzVhRM3IoawChFcjOup
	U57TDiGYkUpjF/roWT6JFRSTzdZ4qGlnensWZiRpT9V0dhcRxeUGLof3F9NIMZf9EZm4si9nL3r
	/2AuMIoBYmTaQ/sFm6G1hNeUvu+q0xfwExlwdtGtoz7YHH4lVqcgfyZXAv8z4Y4M5HFPHhIdD7s
	bTVhRS6sk+TEhXVLlYCdBI4RTjkiBZfMwLtE97P1sa5VcTL1hfBMR7bartL9B2vZJZT/e3O/RqS
	48rCbyhrfv+dVrbSvYbaCD+lGRSMTxCqwj9fyH+dC3iUnNj1JQ5ZEYrgrKMLqUqgk9an6XkI9b0
	l/a833+GzGzCfe8/YTBc+s+5iTQ/OIFjfnywKMNzYyRvprOeLnHuGjhwXozf5ikUj0oIi1pnuoi
	9oD0PtW8bo3HSeCwWXnw==
X-Google-Smtp-Source: AGHT+IEiXgkgAT5UUOxJlAzkKlfZ9EDfFwQmmfZeqWtt8ZF/75IOy9VwRwCV9uV/JCB+QiNcf+VH3w==
X-Received: by 2002:a17:906:6a02:b0:afc:f12b:8a85 with SMTP id a640c23a62f3a-afe2958a89cmr1417991666b.34.1756206624975;
        Tue, 26 Aug 2025 04:10:24 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:f276:8e0c:6e17:2570])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49313e46sm764576966b.99.2025.08.26.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:10:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases
Date: Tue, 26 Aug 2025 14:10:16 +0300
Message-ID: <20250826111016.143286-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 11:10:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19965

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

Hi,

This patch is already integrated in v6.12 CIP.

Thank you,
Claudiu

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


