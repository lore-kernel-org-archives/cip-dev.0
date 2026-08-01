Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24FC54FCD
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:24 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2461.1785575714014898923
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HSQOzbOs;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so2265265e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575712; x=1786180512; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0dfAiJjvRNHVWw1CbFjW0kd9HjkNxi81cjN9sabVF0=;
        b=HSQOzbOstZ4HuLCZiaECGifXxoi5FO/Y5MGhlyuLvPUOkA9VGzeS84+zfgQHz8OXj4
         FH6fc5Z5RMCyfFhDEwenxCI4kz9LOlBbeKeeXB1PA++kgWMIbMjDFZSKHr3HN7IBH8E+
         jXTKYY9D9sV6NezDZM0sUECBDkK7dQ4jGw2I6HuoE7WESo8HmVczfr9ndTayM8CGMhEh
         7iaI5VYpkKz0rOH6X0QgV0bha2efDq07q/RJorHjqUWaXBJ973s8ciFhkliP6aTpH6Dk
         XPzYfipFyhWTVzXtt3EUHfLeRoYpvLR/EHf/aiG2J5OayiYL1+nShs1Z9t01Dg1bOR65
         Mjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575712; x=1786180512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0dfAiJjvRNHVWw1CbFjW0kd9HjkNxi81cjN9sabVF0=;
        b=DwTBPqznVbzYSHs22XfWvHWsbijrPX+FfYUSe8n/GQeE5xRq9/8ryUvpsLWv26qNvq
         Q/mNQWla+mqFLcPDikMwR4jAlYqAfpWZTMHrtpemTq0+ws+qs4TgBzHAyHwcp4rvh5tV
         XSpdwRSrpu7IRwmNVCfFki6rDlNeDlko1lI6myPTR8ls3dgB0kLlQdJKl7R9UYQxH5Oo
         vDNrub5027c9bXhv6JNGYFz275haxjnjVaE8Mp8p5GYNBbhELet+tB0PXFdYWKuMiAuH
         XfsnF/isPtDY3m5/KjLKFUgonsADhJoYWpbQT7xEdlJ/JboCw7D6Xi37f6HtTPfJVLAR
         WcSA==
X-Gm-Message-State: AOJu0YxRNjFwuD1hk5gfZPkjdpbAj+FA2BVSbKCO8kXtDkV1zJWpUmhn
	7rhPqidf5/EpS1Stp/lpOBUePUSbGGuVwrwyufHHkzBjLa2uixpsFkKQarksJQ==
X-Gm-Gg: AR+sD10FnqlLa4mc6e8517QQlHp6kQnWSBQarwfMSJk/dnp9ZYBPyIOveAeRpXVMgXR
	q+PBkqxU//B6OMBTNVnv7hadnGih6zdlfrcJZdjtAqqIt5wHJ+wogJoD6MVnTMdIy8YxMVubbaO
	lGwiDebbHcIz/iMuoDRAzCt/JaDj8FG8NKspD1eqCna9ZCJW1J7lJbfHKb9ccUr/1eoU5houVin
	prLdLAPtbWoAxB3wBbzjADX4F5U2JAHZ45hK483Ug2NdQXBBaB7T1xTE97BdiziurDyrONs5+G+
	Pc5IjN8Yp4ibia/Stk8i5531ArQFpzghLaHcha+SzZvFKE6n4RH/Xd0vnLk3JglqVv1jic5+Gta
	tybbbVuTp93LDcClGGcMnRQP4JV0XgeyopS+jJuSh6U1CidrszxHm/Dpg2y8LD4VlVsFHLRkDAb
	i7kGpYySDBsTtrsu/+ehOzzWqTYWtdKbmTjc6lK12iZwgr2QNWlHTyOHirr52IA7+moEtBYjjRJ
	XViKJdaK9xv0Q==
X-Received: by 2002:a05:600c:46ce:b0:498:ee7:e403 with SMTP id 5b1f17b1804b1-4980ee7e7dfmr22177695e9.19.1785575712237;
        Sat, 01 Aug 2026 02:15:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:11 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/19] arm64: dts: renesas: rzg3l-smarc-som: Enable Versa clock generator
Date: Sat,  1 Aug 2026 10:14:47 +0100
Message-ID: <20260801091458.14026-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23843

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 80e32321c3df7bec3029725c526935493939f34c ]

The RZ/G3L SMARC SoM has a Versa 5P35023B clock generator to generate
the following clocks:
  - ref: Not connected,
  - se1: AUDIO_MCK (11.2896 or 12.2880 MHz),
  - se2: RZ_AUDIO_CLK_B (11.2896 MHz),
  - se3: RZ_AUDIO_CLK_C (12.2880 MHz),
  - diff{1,1B}: ET{0,1}_PHY_CLK (25 MHz),
  - diff2{2,2B}: Not connected.

Enable the Vversa 5P35023B clock generator on the RZ/G3L SoM DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260528074615.91110-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 17bf44778398..5e58e08e7fad 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -40,6 +40,12 @@ memory@48000000 {
 		/* First 128MiB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 &eth0 {
@@ -75,6 +81,18 @@ &extal_clk {
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
+
+	versa3: clock-generator@68 {
+		compatible = "renesas,5p35023";
+		reg = <0x68>;
+		#clock-cells = <1>;
+		clocks = <&x2_clk>;
+
+		assigned-clocks = <&versa3 1>, <&versa3 2>,
+				  <&versa3 3>, <&versa3 4>;
+		assigned-clock-rates = <12288000>, <11289600>,
+				       <12288000>, <25000000>;
+	};
 };
 
 &mdio0 {
-- 
2.43.0


