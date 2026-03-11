Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F3A1062868
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18355.1773227211527802520
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ap6zlkvp;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so9674073f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227210; x=1773832010; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWRq4G3NzMCaUS6MCqi+YI0IZAeEUDyojfMp3bXTVI4=;
        b=ap6zlkvpxwbodXnkeAKPQ1CPUIa1FgJCv5vWDrjdzMQ309Ju6/UZy3KZ8PP4f0ki69
         fBkbvBCCrggAgGhXnFQSb/ByE4HTXzaXsSQuDeB5lK2sY56yvzbS0ajBKaqiDwvfFwqq
         SQRPYp9pAuqBW9KcjKTblAEFaH5Djff4VHGoHhteKwsSC2IYte/uHXpe0NSLC/wPcPLB
         z05yTojoy8B7gFBgqGqEhAfzPO6G9TIeNs9iCP0+9GKZopNLI+oXj5tyuEh2dW9ewtk2
         pvKz14LK79xBi0e7uPXxMZxcPzvVSU+5+pgfRycKCGR+TBcWa5NLXJFa3qc4fHYsbcj8
         hQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227210; x=1773832010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWRq4G3NzMCaUS6MCqi+YI0IZAeEUDyojfMp3bXTVI4=;
        b=OhdUAAF11xn4+gQ9Gsc3M+GWbUp47pDh7bK0SDB71+yplIU5ThzOXUw1rTwBNGQH/T
         C3QzNA4EWbYq97JDlAMLgx7L5Vcp5VSzQYptmP5c7XYzT+S4IeFlvDzbb28OQMpaJtqW
         DWnnWBGwFtTNv0h0THuT+tH6tjhyyPqRbAdUNjVacIpgi7INsQoE5krB2DzoPK+8MMP5
         Gjy+lgE6ThhKM24ou/Bzl7F032wKefgfYbYqAfNiP8uQWcw6daPB51bM8uMuavaN2OAw
         SlGHLMxrK4Qmm4hER2xB5XETXWt3rfx7ZZM3r+TZ51yWOssoDgnFpoDgqphH5U4PVGsL
         h3uw==
X-Gm-Message-State: AOJu0Yy4ZtwaJ++6gxCsSOFIQxEG5L808NZFYXSr72MP+SBqmVIvjprR
	gI4usWK8HybfICVvBL9nychIpPDhE7d4Maquc6LiL6zzLzBsUPww8tH8pENMZONay7E=
X-Gm-Gg: ATEYQzx2rBw/zkXYeYBKSSkrWtEwlQJF8tJJWQ2A/VlaEvC8TXa/b/wZi6CIKPzBFCd
	OuzP/gT3VC1sy1TAJQvF+8FDXwnuX6MThsGqKy3h9ZMhkBurBjpiE6FM1v/zd3C3VrU6x59k0w4
	clm50+lvWNCgtWMYNktPjtJwKUW9uhVgcx1jwsX05RO0Zp4VXbexAu+zOD1F2Q1jlHYQW06I/oB
	m4Drv/rBw++cAf9xW1jv82wxGcukfHYqPqyX+bSf1JLT52TBS8/fDDzvyyK00MQDlDiwTuW2wK4
	mCnJAKrLzIHu7WJBm4C5xbbeA8hIonAL2++mS1EAGsfIN3QgGb4WZTh5T1CkdQYv7kHJeqRIAWa
	HWaB8R3Cj5I1kBfE82GxVwZpinnElmwV3YxKhvmGJtF9H81dsKotmuMTKEgv2tamiOtEI1G9osG
	hdk+rXFf0mQe+FNoGG5yq46raAdYg79dbgyOJGkrCziJ6PcJzvOZ9a
X-Received: by 2002:a05:6000:40dc:b0:439:cbb7:3c19 with SMTP id ffacd0b85a97d-439f8206f86mr4025140f8f.27.1773227209894;
        Wed, 11 Mar 2026 04:06:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/13] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Wed, 11 Mar 2026 13:06:32 +0200
Message-ID: <20260311110633.1938579-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22338

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
 are not present in v6.12 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index db05c28a8f6c..d90f65a7d79b 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -122,6 +122,12 @@ da7212: codec@1a {
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
@@ -149,6 +155,11 @@ key-3-gpio-hog {
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


