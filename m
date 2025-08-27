Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC95C8303F
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 03:58:19 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.6978.1756267091586158371
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 20:58:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jXd4KaeW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so48291985e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756267090; x=1756871890; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ7kz6awYX7mcrfdhwLXj66LsmUSrX6YD0AyethMpYg=;
        b=jXd4KaeWst3guh/i1sb3PWxPJCt1hDjig+WAeuV0ihZUmEY+PEf5NOi9/cA4Ol6hAt
         U8Wqn9/LIELkE9DNpYpwlm8UjA3jpEUPbuhKRhbp8gZLmBaHZHxCYnFRhC1syGSeWRtG
         MxyLsbneGeadIbbUsoxX9Bva5Q+sJO+BsGXZXWLkTPhCwqQLGkzM4IKp9djeVpHUzsRM
         Q0Xj67v98REunIda5YgU/+Q4RQNvMMCXBzjYPv1mrco2bKkCSxh++59Q8G2IwmJGF9pn
         W/0gq6f2rw+ISM3U9khr4re0Gr8dCbnvQokrs4nsPXhtfu0eI9Y0R5NC8wA2ngD9/70n
         ij1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756267090; x=1756871890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ7kz6awYX7mcrfdhwLXj66LsmUSrX6YD0AyethMpYg=;
        b=CiaImYybBPzcydtQFiHr4DIi40nYVwh5X+3lWssC/aSLy6YUdx3MH9wwfVgLPGQQDp
         Ga19eopkR1nfU4t9SnX42ZbJMUhJ1JboYvZ0GCq3BxP6FfRHCYR8RcPLWPchAg2uSslk
         7xsznj+K2O4513x/5M73yF+qvWbQ4JGVKaGtFVmwqeKjY0T1eoCUb4g8TJy8BL8FzHPm
         jxe4WWLFIflIa4Nq2gRqyNkp6wp01VysK9Nza3yVgqc9gF4NTSIHkkL0/eR2H/vmFk8Y
         7fXCaiU6MrBJt3nmP6Skbb4IefaZP7yQAo2dC1QLb4V0lBMYbB5catpJM/u0E0mAO26a
         1sSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5pNxnn+gU/YEWTabGnfnz4cULdxlp4VkpM4dh1mVO3PC2mbjgBwNwTg0vosg0JAwwb90ggJPv@lists.cip-project.org
X-Gm-Message-State: AOJu0YwcVtuS/WxvPb8OuNkb+h0D/z41PQozh3LweGrp5TIZzLlSa9/M
	Rs6PXzfiC3idxDCkJAgGM12bXllyE85OxURSm+Fl0ZvBi7W/FV43OLjIzbUryCnFVw4=
X-Gm-Gg: ASbGnct04GZ8lGFPEiGGGT13aO+/iXn8NX1RX7m+3Dg0r0oVKpPte66Cht9MyiBHfQq
	7xSeoKLpUNy5aN9oaTxmJqi7VG94XnJGr4v6ZgJHjRoTepFHoUH8nW+oH9TV+N6cMAew6D6yGu5
	RsG8mUzqcfwsfCzNMw8WgzRUIfg7s+oKjrFkRL2nmHEgXNBs/7SoT/G6x5KmePUiSS0pxm8rM8C
	MUTwHkMJZ6sY+veOn7K6g6Am+3jO2Hfhal5nRBqfrUjIBeZ2s5DzkGDsrA84pO9FNg87TWC6k23
	wGiQJfUa/7JuQ0RJ7ZZqg7Utekd+lHxKrS+32Ss10GuFjeWGa0n4Ou/miGhIw8N/9b3PyTgTD0R
	ROpRLLjCUqRe2wbYFiQwSD4xiKqh5YzcHDF45aCAF4JrdEahMO0yEeriks9F/DrMP2BeDMkv7Wg
	3eNRyCpQ==
X-Google-Smtp-Source: AGHT+IHg/9hGlS2QD9d1GV+HPDqrD7MvAGRlSXFtdZbKa7X5xeqmYamn3dOaxluAqqi/fHHJpK+v+w==
X-Received: by 2002:a05:600c:c87:b0:45b:47e1:ef76 with SMTP id 5b1f17b1804b1-45b517dfe11mr138184135e9.37.1756267089965;
        Tue, 26 Aug 2025 20:58:09 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:8b1:3f01:309c:b069])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66cfafc2sm25342275e9.9.2025.08.26.20.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 20:58:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases
Date: Wed, 27 Aug 2025 06:58:01 +0300
Message-ID: <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 03:58:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19968

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


