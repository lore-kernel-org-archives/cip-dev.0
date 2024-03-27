Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBADCD129A
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.32307.1711527515144671758
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IE7QonBk;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41494714fd1so2173675e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527513; x=1712132313; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoguOZ8/L9Z2H+HkxVDx9xniVHZvbKhOowel1bUX5J0=;
        b=IE7QonBkV88Kxj2rFrR8ZRaGFQM9M1Q9CeICibkCubrp5U7688a+O6AIuOynoysdqo
         cG+Df50psgLasvYjYmaAwQwdzQnDCE4gLjH7SySvuvuGEFsf2MRzXwgUTFLENZSQda1H
         nXyjMUDfbdXxNViDejY2n0wgOkx4aAb+MWxOUdoApk1A8JNLXdsO974Fj6JeUPSE5ZVj
         6o6WiaYTYBgYTmhzmH+E7vbPJYxcANN8okZskakVP4sOhscn0cEV5zNuUrgNg0oz1jZM
         iqfwaFL/e6lY1S4amlyp2tX3gbMkaqfCabgZTcyAdsstXm+Kej+sD8HDCLNXxWaBUxMg
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527513; x=1712132313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoguOZ8/L9Z2H+HkxVDx9xniVHZvbKhOowel1bUX5J0=;
        b=cZD0/TecgIwYtYcGoLZdbmCR94iqC+Zsd1vC1IvOeV/TJrrqJNI2QOknb+5wvfd3E0
         YqFBQSFbm6KvsTLOu1KwZIeRG6ohSY+oI5haeqJRjYyd+SXcM9/r5rTHxoOju5mDbryk
         O6t+3g2TNuV0jpEvX/99a3YBcpch2LUHqoFpyahe7i3j2TIsBEDpE7siv8bx1vrPk9ou
         fY07a3m2PI1IEp0t05pVjiWRoTWGz78f590fsNVzV5DjMb9iREl1I2wTfuZIl7A+qs+0
         pet/vWXhwmSrbQLbLh1e0j1QhU2zOoYrzxCVIwrxedWQBu6shd67MrEAbFds9r1JtbzE
         4qJQ==
X-Gm-Message-State: AOJu0YzlglBSE8Fk08wcZxjQY4xQWhdUm6YDBlbdL4cVEEtMA5t3x+Fk
	75ARSc4Pbi68MTJvF4kboE/6fAWEDePgCpoKM2eL5aKcpMC2N2Bqii8/GMmOk1g=
X-Google-Smtp-Source: AGHT+IFmZJmKZ6yhN4AaKRpbkL5c4fKR6NX/KMxIMBOVUmthEQCyck3Fhrzn+noo+WXsvDfpjWfszw==
X-Received: by 2002:a05:600c:21cc:b0:414:8d7:682f with SMTP id x12-20020a05600c21cc00b0041408d7682fmr2456949wmj.10.1711527513655;
        Wed, 27 Mar 2024 01:18:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 30/36] arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO interrupts
Date: Wed, 27 Mar 2024 10:17:50 +0200
Message-Id: <20240327081756.2228036-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15447

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 85169df721078bf90fb0fc3bf15e4743fea45b2d upstream.

Add required properties in pinctrl node to handle GPIO interrupts.

Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
continues without waiting for IRQC to probe.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 1d3867aabfa9..8721f4c9fa0f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -596,6 +596,8 @@ pinctrl: pinctrl@11030000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&pinctrl 0 0 152>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index a6e777aee02e..ebaaf82edeca 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -48,6 +48,10 @@ timer {
 	};
 };
 
+&pinctrl {
+	interrupt-parent = <&irqc>;
+};
+
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.39.2


