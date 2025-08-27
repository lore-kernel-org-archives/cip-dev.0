Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA7CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 03:58:19 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.7166.1756267090676720493
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 20:58:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ITufJZfQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso54342055e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 20:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756267089; x=1756871889; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ7kz6awYX7mcrfdhwLXj66LsmUSrX6YD0AyethMpYg=;
        b=ITufJZfQ6Jgx+qWWUK3TtFXwM+w1jH0XIeU0DMTgyisTFR8qiA6w8wQ/WVTWWly48P
         zJn2U6JJRFcobYcJU6kBNpwGmGe3RGXO/apHsdwB75PJCzhoPraI2FrZZOwcNr5Ikye2
         l/wI/VDwjoURQsqjVQtblhppCMtOYmO1Vv1qLtAdd0Er8m7lsQ+A8Q4jJznzmL/FFeK2
         Wr7h7LRt1xVc2388mHPi/OdS2oL8wDyV+3uYEgIKyJX13ur02xU5ufzmZBYD+m1XHsLy
         IPjRTGetZ+9jei2ULdX+vLCULv5SeZUgdVOhwExOxnf4JMo7AnjZe49VM7B8Vsw2P6gr
         FigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756267089; x=1756871889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ7kz6awYX7mcrfdhwLXj66LsmUSrX6YD0AyethMpYg=;
        b=vy8urDgWxbaUReOAm+Qn2/YpaDwZUVmTuVlh6n6oGB7S2cXPYWJWY63JFm0A00RMaq
         d2mgSgmOSDFth+gpPGWWoxJ9mNgz35efjxiWbkENA+CLpamUkurb9NNnXU9mHCa617na
         kApPDxXwLziCVWwGfmSlqyA4IV/yR1jA/iWidMhfL2/VFgBOQQuN4kwUofGUTr6+eWq1
         ttXUmTdWOKi+0qvRDlt1RcXW6qLYHKhWTXi0PdJcz3Et45469dKbqxEOWdWLxJzIDTpq
         ktbWezrVkiSdylEMqFahtNnxUTpAR57xj41Hqc2rStZmyz6xHtK1y8KeRFvSfifZxi3X
         bhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3GUqUEV9iNwdJgz+NpZc40Fptgb1SFAQBT/VCc2F8FojOlXC/yaXfTYU6XrMWZweztpjngdFg@lists.cip-project.org
X-Gm-Message-State: AOJu0YxdNPMkcFX5KcoHz5tu4H1u3ylznPW2oKIUp2namAwnSvI+zdc/
	6ZOX7Ofsl2XjFNK86alt02DPFi17KcZPkrOzwyslwptLMEeOCXtyRKEXNwTBuPIEYJ0=
X-Gm-Gg: ASbGnctUekCz24aX9VYWCNeuQJ9LmqSaV6VQPhtIYSaiIUQMZx0Gr3VonHkglnb5Uhx
	srewgqlKGIFkOWGiQHobTPFIDExkk+aSBaWg6VpABYoIsBYKQunZktIAqty/fJtYs54EVciMcMX
	1htbxXP+UR+335IFw88zrvQDHbxpqxhqwaanHQBbMJyFAleX96MYwPnZVWWL7Xwm8kvavsbKiy5
	WBIPvWpjVQacVkRAqramsdTvdrYqwJKEMYBtMmHhTCn58UuWjAhl/gntgI+F7RYlfpMHy5GQAr6
	yUCuVvy1mU7NtEGAkIRkTq9rAMRFxHEnXa0oCTeOfclyaKLcGRjAmo8ZSKAW6PLOvGmaPwBTTBB
	2yMMy4SdGGC/SVWZztgRf/WAHcFK1ET4a6S8Wc707pZO/YCpMajCcThfGC12Ox7QwlTT5dZpD90
	8qWhd8GqeFFvDAdxKM
X-Google-Smtp-Source: AGHT+IEmjAFjCuI2JtzzOo4dxUlGpWypcpEygPOG7VYHtP5WoLIW1jVGmprin3bvFaIBCMhWIQzmrQ==
X-Received: by 2002:a05:600c:3b2a:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b5179f3d1mr220796615e9.16.1756267088880;
        Tue, 26 Aug 2025 20:58:08 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:8b1:3f01:309c:b069])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66cfafc2sm25342275e9.9.2025.08.26.20.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 20:58:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases
Date: Wed, 27 Aug 2025 06:58:00 +0300
Message-ID: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 03:58:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19967

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.

Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X={0, 1,
..., N}) aliases to update the DTB with the MAC addresses.  The
ethernetX or ethX aliases are not used by the Linux RAVB driver.

Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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


