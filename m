Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0148D1061219
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18746.1773227210414889667
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=afaii1Hw;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso46014295e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227209; x=1773832009; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0hmsBUXJakQy2I4RDc7/Jlb+q48VZovXccxRxjL3x4=;
        b=afaii1Hwyl6dIK6b0FdF53ZaDWEHmzxXGX+lmWQCAwOBm+1wspZmGNTtvAxAXFF/xn
         j69EI47JTifbmt3oeDKPUC/klIS1WZLPcBwN5R1dLRQ1D1L2rLTXaG006y5oHbdxNkvM
         RJ2Az+cp8Nf3PPlbvKBuch5aNXqzgA3OfgzFCokRCrDr8e4L1mdQMnWYIW50DHdnFEGH
         ZQqlEx60iPAB6csAf0vuTJ0rz251E6T1HPJtBmUMdf5+5DjiccyrB6fgwtaiKmARnxNp
         j3JZXEk0LKuEUaAUrH3uq70yyWh9l1YqyOI3AXfCaTpn5PuOrSEmJc3G5WRAVwszRAB1
         B9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227209; x=1773832009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0hmsBUXJakQy2I4RDc7/Jlb+q48VZovXccxRxjL3x4=;
        b=mIFWrMZ7ZiLHRyouUkkrZNam1fR0jxNyuhlQ5QdaV4NdTGOKI07osVfUmNLxjyh+nJ
         OZFgNBgnxlUqrNTFU7PHNmgcivN5fWXXNtOu/B6fG/1io/zOfMvXhG6KBHnfsPJ4jukW
         wxM6zXreJbEyHx9CeKXRvQhu10ehVqllt2L7chIh3vXYEViBp1fnERnr3IH0sgbopgsd
         5UuEIc9MbDewFIZrGhnk3Z50iN98SSPtHvSyHs5n0YvpoWwjRAHskdyIhqRrQniS3eNJ
         wTOPxKxxnDScXCxenS+f/CjIfuqGv7HyVp0VKEqwkcH6Fy9SNvoDIXq222uN3PKp+YvQ
         NBbw==
X-Gm-Message-State: AOJu0Ywnv1jj4wfXFF/WV0p4qfPQtgxYTPYVtNcLUYdcjviPBfvGhWrV
	L15cgMoNabgaN/4F06W2S9DLSMSCTcwFkpSIx0El33Rilw3WBRLR/sbExhaUSD8HQwia2fWqizI
	CSZ6s
X-Gm-Gg: ATEYQzx04fP9Qfwg5T3sdt9ZixAotKBU9STXfXAw8ekxrQKkQ1IMzGZG8O/WZp312aj
	avCc6oIco+3F5eeAdRBISx49z3LLjbRiIC82HnUrqeeC8ijPcxeePI++ZQWXStWtBJY3aSYUn18
	aZZVB9Esdgi7FlcVNkqOyQ5KMApEoBVDJDpvMWRKIOkOFAL7GVhKvF6k0JZrLz2DJKMiO+rRo67
	BqWsnvR1YMKIByRq2jSog80RsZzpQj6T++MT6DO3/p/zc+IHuOO6XHqBEONq3gWcPHw6aNO71Zc
	9iOZxyqo2TSD6sA0thg13qtukpW8JVpu8EXBslyMXwUGlJQZmDaQLQzxZ2/aBvTL6ppXX9sOZnb
	N4f1kE3JiXFUYCO3Y5C+ykau4dFImaXRZGq5PlL7XZwZ5F+9CWAwD+J8O7eGg/zyvcSvYwavVKk
	DjsX1nhpWvRGeW7yrP7TF4OJwd5iRSZFajFZ2wvx9+6/E9H865+HJq
X-Received: by 2002:a05:600c:a4b:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-4854b0a4a92mr38276415e9.7.1773227208760;
        Wed, 11 Mar 2026 04:06:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 11/13] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 11 Mar 2026 13:06:31 +0200
Message-ID: <20260311110633.1938579-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22337

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
index 6f25ab617982..982f17aafbc5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -168,6 +168,11 @@ a0 80 30 30 9c
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


