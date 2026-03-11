Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B010611E9
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18663.1773227075918321739
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OZDeWgkw;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853aec185aso29746325e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227074; x=1773831874; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NNL2XyqENI0EKBU20jSCL3P1jA5fu/vpAAMFO4h/Z0=;
        b=OZDeWgkwZDVJk8t39ABRUmzJNZv3ofJrD5hJtZXpbvLoXuCJzk2SThbicC2uDX8J+9
         BoDxoWGDAgUrRmAFvp9SXZLOPG8DuzCqUaMZ3+D3vMA3HiMLxHQqvIs5K/1B5WGhnbSY
         9ultxc6RMgfYGF0ce6vCs1rkIracfleGFKKF9KMTSIbLWxjUjBIoIw47K2GUXc7BNwDH
         4YDXnzyBd5BXkrn7MfYWYuVhfeQn3oLvqjtPPqd2So6if2Ok7/r2CJzbAtMH5yfGVYEf
         rRk9g3mBZZaJbub/sVySXct9CxbzHyfq6msyrGBX3VLxFviLfo1qW5cIgjgMgi+UBQ78
         XuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227074; x=1773831874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NNL2XyqENI0EKBU20jSCL3P1jA5fu/vpAAMFO4h/Z0=;
        b=MbcYxqcA+X+T3qM08FIZmntAlaa6vzMIT7SKNKkL7VZpClmp+CUOI1huV8O7q7QpNJ
         44NcbCSZkwP4SiJa8CWeA+Farnptk0h6VpmJsGGKhgtwjXbGe0p/RzuTJcdy9eZ0o+/8
         x8xZ+VBHZ/fu051Jglv0Z7OBktre/Nl98o5YnKW0b9QejVu/txzd+cDRTD/9PNdaEQB+
         FKuSFHJdOWFQvfDb3nwMr5wA5hTy+U8xKG3U7Qr9nwvpyTHYvdW1et72O4SIdl5tQsYD
         HyeW/lWrafLP3AG1W3kocYMAQXpY0lV7MZ9T2QMLAzxgh7ACdIbhZM8RLTfm0dSzyOyN
         BsBQ==
X-Gm-Message-State: AOJu0YwGa+A0KlAw14ryI1Y2kt8lSVhM4wdG1FKRaiGGYSd+rO1G4ic1
	A5O3pzJFh9L+4yCiCWyKUe56yt+CHvQ6jfaaEVNGKhMJ79o4EsrxDF4FVYHOBbw9dVoFTr89M4D
	wixvA
X-Gm-Gg: ATEYQzyl2xToigIVAuHeHwTdKSIj1MvQjoHc+pX5SR2QP94VSPbgOmctAuJhlZy2VRf
	Wk8E0UQrHgqi+H/N56TjKsOuxcP0bK0cqQF9fSp07Ds0nTIXE/CslaAK0jKtkVG9VwgcJvr0hAo
	3fvc5K2HEyrA03/2EZFbdctMjvY+8lThgx6qWU0oggGNwsBFNLoVFlt5e6V53L3Hi+b1aj8idOv
	UnUquQt3XQgfqt+qtN+w47znY2KII/eIWAPSxo9XPZhBamY2e7UyvGGLoHITA4TWxnfm2kmxr3S
	/La7EwmdG3ceYe5rcWy2RCVUXOp00mfiRhn42GJxAdjLhkWHnX0avfj+ScLYwQKGtAs35HZ1gJH
	fqdywW07WDelClDHMnEgq3K2Mq5ja1w31WE0IT9l+C/khGiSJmvuoug66mDJw/FtoyePGhF0sS+
	0kH5kz78kD9exJVfy3Rs1Gbbm8ZUSGFRSwAM9uF3xUkrXoQeVeuvSj6x/iyOOIDWA=
X-Received: by 2002:a05:600c:4693:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-4854b100eeemr35313065e9.19.1773227074228;
        Wed, 11 Mar 2026 04:04:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 26/28] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 11 Mar 2026 13:03:55 +0200
Message-ID: <20260311110357.1938200-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22305

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1a66160fb28abcd228f69e00bb183a4749f23805 upstream.

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 7c40532fc869..b11f2e49748b 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -170,6 +170,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


