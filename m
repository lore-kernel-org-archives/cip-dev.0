Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC52105D29D
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18665.1773227078214799881
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=idxYVEM7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso45992395e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227077; x=1773831877; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ACFjrkYmE4dTQsu+IUf7TrbBzNeYdaMNfennkwwOpU=;
        b=idxYVEM7zjc0E+sFtoCkzR7yOHJSvNlaCQbcCWcpcwGJUARkgKyMCNRSctdmEcGHpi
         +IjKA9hHWAt6cG9TRA4ZT+5Wk6aSA3x/Q9vkhBCMx3aSkudeUQqy67+jpmW16ieljZsr
         Wx6l56tm1GBhC4POWDiw1z74xIUChyLLrJpmRtVHndyqzpkg1lRgmGWeHe4dQT9lFazz
         o9SVVZT1kq+q/bvML5rNrdaWE53CPCn7SI6u326YR0PXawOFy0Z4M9x1V5aGZ2Be812R
         dhaeZr9xg+eAHgbFq/2+Umy6C4bivBBId1EKN9NbRCMAViENX6ltaHpTSmXkl+LF1ErF
         V9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227077; x=1773831877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ACFjrkYmE4dTQsu+IUf7TrbBzNeYdaMNfennkwwOpU=;
        b=GqBmFHWB99iT7WpK4WxD1a4hbXa8KyKvZCLkXBmIRPQC6JKTOO8wAOhRcMTo+T1ZH9
         EibI0efI21dEdTYSzPrfQUrfaFY16CXm09jSRt12n//pjKENoZVUuL8DEOvXTW62K8Mz
         8aXv6+lAU3v62Ek6IZvTRXZ+BLWxGTd7xpZc2LACtAw0ZS+v3TRJlxaNhqvhjL21VosC
         3EX3O6vhdo78e0qbAn9mDUqEBMsFissUf6ufrd7ug32yyVRJhxhMRw4rMRfTbMWpscER
         sov6LfbO5LpFREQ8x0E+4L15BDXoREUPrB80HgK6Y/98kvondDqNsMG06KdHiN2AzObF
         /ddg==
X-Gm-Message-State: AOJu0Yzva99VPIRriroKTabCtYmOL3fViJancUsfW3gBNPOecC9H3EhN
	LJeGYlsh1D1Txj1ax9xZ+c2ZG3CrvbuZ71A6IES8iO+JPlZdVThlUXDfFWohPXccPDK279lo64y
	cUbUT
X-Gm-Gg: ATEYQzwoLdHF64cHTptMAVf25Ye8KbUPYoB75VLOHsIe3hGKS7uvAQ1mD/EEzZsuJ9l
	t7GJOT1LAAH0hbv7KgGsbMDSQD3DL+TAL1hy7E0R0JGDaIP4rZ0pa9+cbLn0kc0NXQDbOOHYRbl
	avbqBygGuarLhGUNi1rsKUV1RBvQQ+Wv95NgB+218m04y3AYOmasy45Kua8DiqiFBmXlbEQdVqV
	eLB3JpHX4cLrIImI6jJW6QjU5kaTBTTzO59vTuGHooS15DiM/hjh/Ce6vnBkYlTvjSvzvDL9x1Y
	EKh9F+qQV6hm8YNhpf+7DAIhjcB4S1/5EdK/fpk7UKa44NSYOdSaifRptVbdHRCKJ78un48CvNl
	wbbuAvqFixryJxI1tJcDkwQ30B8rfpoNZUiMsNeFGajLRrWUMGmuJ5wrXzX9UF2wV5biXLj6P7t
	xCp7GVXSH6UQ7glPnljjFR+24Sv6WCl8wsWzvLL0UaXi/rGGO4aApr
X-Received: by 2002:a05:600c:19cf:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-4854b0fe9e4mr34406965e9.22.1773227076063;
        Wed, 11 Mar 2026 04:04:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 27/28] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Wed, 11 Mar 2026 13:03:56 +0200
Message-ID: <20260311110357.1938200-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22306

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 73b73af99a49fd7bf0515741734660973fa2002a upstream.

The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
support.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping I2C1 and USB nodes as these
 are not present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index c8800c41b4e7..203656961bdf 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -123,6 +123,12 @@ da7212: codec@1a {
 	};
 };
 
+&pcie {
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
@@ -150,6 +156,11 @@ key-3-gpio-hog {
 		line-name = "key-3-gpio-irq";
 	};
 
+	pcie_pins: pcie {
+		pinmux = <RZG2L_PORT_PINMUX(13, 2, 2)>, /* PCIE_RST_OUT_B */
+			 <RZG2L_PORT_PINMUX(13, 3, 2)>; /* PCIE_CLKREQ_B */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.43.0


