Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AE9C02191
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.41715.1737546769254663018
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YYx37m08;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so69948825e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546768; x=1738151568; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpY6aUw8jKaqqqyJQi/haLQ/BQuR2SB2uD3rtboN7og=;
        b=YYx37m08zsAojfr0B50yzex9guNJz7Au9YEY3ntDRjhsBGcykjZ5BSd5ArlBQKZMZO
         qhuWnnNKMwX0SLMmrnz8mO9WGU2s7ufKBzaWZ4lKtEWrYx5lryuVHBhy5WIPgxaadlTU
         luAnaKl3++IhgkkDPaDwesyNd7b6lQIbCrywfwnN0BQ2L69xtwq3np3KzTX4A6nY6XvY
         vav6aMXux3pr9CyFjyRAmAWHKutP4mdndk2cUT+iFJW9kC2G88gFFseRrnrVksSLhCCS
         pOXDZ2rMkiSdo3ptXUdviwL/9OemoFEPC7bbdYQ7Aax+FuR5htPVueZAT1ilkVbMjDUA
         vbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546768; x=1738151568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpY6aUw8jKaqqqyJQi/haLQ/BQuR2SB2uD3rtboN7og=;
        b=Y591lufUmuelDOF/y77h4faELahr2hvzacvMBE39IQ+dlBh0YNj3JH94kFqakHP5pn
         YLJ0HvBbhSTK6hHMpB5Z9y4QnZ9Kv5C/GIYjnoE/DAgZG4gbF0T6HQ8u6g3skx6Hxdo0
         VFlQg+vaYNqhjjU0oc4u8poZTdfQKOSMmp5CK+A7s/gXpm6Y8vXgquVScPHeY1UNP4d6
         /VKiDAe4k8vkikjF5RTU5lc302X0B0lY3BLPZnG6uutn/5kPuQdvwB3z4O/PpGzA4O4G
         i1bZWNIr9dRNMLzqtCR+iE+PbNmnAACl+FlRkVIJja6ScI34p+o0kXGjkq3YNK0aCt76
         kZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQlAwY6d5lsGgDSwLXXqf4SjIYVDYD1P09wd6yavxKZAiuS7XLmoBQxRuexqQ6HxV6CRn5/lS0@lists.cip-project.org
X-Gm-Message-State: AOJu0YxEnRd4sozUg7A9EZ3z4iEv9jMEplQyNhMgbhLPgR1ISDlVm4gU
	AHWzugew3l6Tbnf/bFJ5DfrxVkVWhcBkLlYNVWT+A49c/LDts8bUDWolW9JtXvE=
X-Gm-Gg: ASbGncuzm5y0lzSlCFFIqz6kpjX++3OXRN96A0VEFix25nnmpwEYZGKw1bgQdsOzcDD
	+Yz8ZrmlCChFJKjuSrW9BYjnZ2HgOLuRcGbu+4D5inLR/n08glRGkGodF6bqvb0ywVnrSF0rxW5
	GY9np0boUtHzwozY3S32LPRZxKj3VmanioknQlbGfizx+WfVEcApW4JZBJmYwpejTMg3fzGxIEx
	L5qilE5HpOkrg+cvxp07tyoGpmWSOmWEMkKx/oVfM2+nrJ5mGL4GWU+kApBMZOio8XZSEe0DKSe
	fnfTPwC8MJ9L6ILwhSCIgDw=
X-Google-Smtp-Source: AGHT+IHoUUzh+AXlXW7p+NbZPU9DIygm5ewpfqaU1xmoznJU/kidY41T/nGWikXA5P/yCz9V7V0hNQ==
X-Received: by 2002:a05:600c:8a4:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-438a2400e95mr139249775e9.2.1737546767676;
        Wed, 22 Jan 2025 03:52:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 12/16] arm64: dts: renesas: r9a08g045: Add VBATTB node
Date: Wed, 22 Jan 2025 13:52:26 +0200
Message-ID: <20250122115230.2885344-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17590

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 23c44956bce5aa79c060fc3e5d51843735e6eda6 upstream.

Add the DT node for the VBATTB IP along with DT bindings for the clock
it provides.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


