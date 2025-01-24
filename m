Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC27C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:11 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.7457.1737709262639073443
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=d1zI1KQy;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so351061366b.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709261; x=1738314061; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vvR9nVgFLP1C+uBrhg2+HXv6HH+PsmPNjlZ0WNrWs8=;
        b=d1zI1KQyMRWQBO1YclGgWx0nU6H7LzaIlG8QgkTV+hwy77yEDla+d8MihT7gHEHiuu
         rcipB6ZBkjIKi/I057ls/hWSupJIfP4+s//HqrrbudFg3dwlzPJbY50F9U1dMjf0VEy1
         YIEThDFzFnnYgcPA6AlWHkQEmawqURvuD7OvTs6/SThl48uBhA7B3Zl+TKnpdWSygVWl
         2/REi2eF2m7Fdt+s8Zo1PFRZ9a53g6YEWZzbRvjNhgDlK+1PXNUzs4Yh87odk0dD9HN3
         pxGgUQyRpN6DjnC7ug7FyRoEOMtDovxQCG1KY7ja2OdWpgFJ7zoS1VhWPIP8/Sc/qksg
         3uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709261; x=1738314061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vvR9nVgFLP1C+uBrhg2+HXv6HH+PsmPNjlZ0WNrWs8=;
        b=nHqZJc4FiUl26F3zErwp1cf9Br6SP6tTiXNGam+ruJbXVVgbbWy251UazK40reFWs0
         EKH1Lfr0iHXuXC9QQB2fvR7bqn4z+u0ngwHu4uyPxkvGxPVfIuoMQPVmiwHwKdm8AcEA
         B9BOwHb5ie5hDmqMgiXMA2QYeQr0JrM/JFAAHKJN+ihPnuzRteMPcUCtM+83kXOKHMyo
         SaU/9OwEVO1wEe4RCi9h3sWcWJD+wyEHPl929xOIwPwy+EjPjf6kgfbdGuvFPBxFSKxq
         vrWXpecBKUkSZBjeEWy1KxXfT71sFmj4NUnqXSmMx/GbCKsjlWMw5G9HPAmZTv48zgyt
         ROGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOFIAOItY1y+OUB+P9AL7t4V7G0Yh3rq0LuaskT6aQF1Zi99AG6egpUp0o18EuxfwzAFc8b4gj@lists.cip-project.org
X-Gm-Message-State: AOJu0YzZMhfkw/7ECHMWicFmgiUn6saEn5tsWe7aLOv6OtZH/MoYgrK9
	UgwqNnWgMOFN0CHBzF+tFIzSyEfn5Ad6cerHEXHzZFq54B8EnEZbh1lzMh3K8xA=
X-Gm-Gg: ASbGncuaEnUB+a7ALT57mPbe6jG8mhkwjWlPAZ37mcZikHM64+nKyUg54fbrz1Ric3U
	P9CkxgRgUBIo8WaUhirBZARmEWPR4mTVa6NqykIV7iJDzHkJ22pWcs3/ZkhzerRbnzk5jM2vYdy
	y9iw2aglDMXTTUV+2QGlFqFTfNX/Uj76izzyTGSEbpVlbeBxXjfhaMdnFSdmDxVtZ+DVliBVmzm
	xMC+Xt6OAdDPDD58stHqKzHFUW44onB3NXuvgr4A1qXPevqGO+PMMg/e3VR9eO23MtjlXUUOA1o
	qCFWwbPG0PfK4PlvurIcKuYfnU3mJjsSOw==
X-Google-Smtp-Source: AGHT+IEGrDBiVEN2DZSwQwZOwd30lN/RTeaMkJzoz9RANctjkasG8H/LCWwCa2UOYmV0Z/qNQV4Hrw==
X-Received: by 2002:a17:906:1ec5:b0:ab6:37c3:381d with SMTP id a640c23a62f3a-ab637c344e2mr1182276866b.24.1737709260651;
        Fri, 24 Jan 2025 01:01:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:59 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 12/16] arm64: dts: renesas: r9a08g045: Add VBATTB node
Date: Fri, 24 Jan 2025 11:00:37 +0200
Message-ID: <20250124090041.1401132-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17649

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 23c44956bce5aa79c060fc3e5d51843735e6eda6 upstream.

Add the DT node for the VBATTB IP along with DT bindings for the clock
it provides.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
[claudiu.beznea: the backported patch has references for i2c nodes;
 the i2c nodes are not available in v5.10 cip, thus fixed conflict by
 dropping the i2c nodes]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index f5f3f4f4c8d6..7bc8969a7b5a 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -72,6 +72,18 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		vbattb: clock-controller@1005c000 {
+			compatible = "renesas,r9a08g045-vbattb";
+			reg = <0 0x1005c000 0 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+			clock-names = "bclk", "rtx";
+			#clock-cells = <1>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
@@ -296,4 +308,11 @@ timer {
 				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	vbattb_xtal: vbattb-xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
 };
-- 
2.43.0


