Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88816CD12B2
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.32308.1711527517518814466
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mEXJXJCp;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-414925ba716so4909935e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527516; x=1712132316; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY19XSvTqDrgS5pUGk6GR0HeloReM8o4NL88k0VnWS4=;
        b=mEXJXJCpNyGIe/jebOC6xNgnX4dhUWn2SiiRJiorEscBu9WrUwJ/0Y2hbYTBKfmVdz
         CsgQqntuyfsHo9P1q5pmmmFF2+YbZw0Y1EQHSsXlvKx2ZM1KgFIFqhJkl1Ik6WhmWCUO
         kGY5lwvw3GX0N8JFzRY2QmNVsaDFskgYJHljbELdyTpf7Zb4TAcehn24lHRseAlt4oHz
         1TmUIOKn6V5zMt19cSgRDZ3WuqIXSrWdO5J+p71ZRb4C9Ddchc4tD0HyuSl9lo5Qxqka
         HWmweAnqqPl0HPiYgIvDyDBN6I4KkIXqgFIQHEmAfxQ/hPkKw+izT3O6TeM9PlfBihan
         yAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527516; x=1712132316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY19XSvTqDrgS5pUGk6GR0HeloReM8o4NL88k0VnWS4=;
        b=ZlNB50d3NwOr+cWXtXZhmkX6GBUK65qKUAO5TATlFOO2Fx8jrrIrxkv+2dJe8DdYa9
         4/bjp1FOFARMMAMoX23uyth6lgo4yPb0sbCL+DKpoptWr5xkqtQxdLyKrzs51KTJP/56
         ZM0v5kkTET66rEMXavvYSCvW22DJVSG+7KKBCHKJW9IA0C+rFx1cYHj78ifE3v48hUuV
         Ir/BXeeSUKW1K6KZKgv2BH5o3oXW63e6+sdcG+RTjecYkaAv+uFykmWeC5jKZ4alu3f/
         lDIwUYaTOLHa8iQfglI4pXCUEcMlVHogbLrxBgAisHGWouaN3RU5+XrbGGDUBL/59ENe
         gbug==
X-Gm-Message-State: AOJu0YxY5gfY4UDs/Q9zMGWxVmmDaafB+AGVnqoi2eLf65URYfQj1+QN
	Hqoe1lrMY+WOysZ01R5BPCkTGTRUyTwq4tK/17AjsilL5yDM5L0qv+D87TBMKzw=
X-Google-Smtp-Source: AGHT+IHjalQ7fJzb+nK6R4k7jCcYRJ5WKz45QqnNA394pw41xvfsFh8RLlZIVZEpdE6VYDXsjIQ9NA==
X-Received: by 2002:a05:600c:310f:b0:414:8fe0:2d16 with SMTP id g15-20020a05600c310f00b004148fe02d16mr2658050wmo.37.1711527516048;
        Wed, 27 Mar 2024 01:18:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 32/36] arm64: dts: renesas: r9a07g054: Update pinctrl node to handle GPIO interrupts
Date: Wed, 27 Mar 2024 10:17:52 +0200
Message-Id: <20240327081756.2228036-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15449

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b2c9af5f47522ae9a6665e98d5ff657972a4db97 upstream.

Add required properties in pinctrl node to handle GPIO interrupts.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718195651.7711-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 9a856dda9fa7..a432134e1f0a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -774,6 +774,10 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			#address-cells = <2>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&irqc>;
+			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
 			clocks = <&cpg CPG_MOD R9A07G054_GPIO_HCLK>;
 			power-domains = <&cpg>;
-- 
2.39.2


