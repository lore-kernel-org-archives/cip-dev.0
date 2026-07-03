Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD13C4450F
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90787.1783076375506724681
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rmu+N9ZL;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-471eeac43bfso489462f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076374; x=1783681174; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IONUdg+LZmaToKPuXriAQxtlMu9R2xBHRksOrEyRdaE=;
        b=rmu+N9ZL7scabgPP5QWBmYkVNuS8SpLzp40C0U7NPD/qLQeQPrjctsEUw+IacynlXb
         Cw/EpvDdF/LJ1OZ3LL/rC5EI8mH0ikZb4VQodkqZJjlBJ/zluLtY3Ix3K+CqVWR5bfIm
         NW0dRMC2qcb7K9UNOPZ1j0Q3NBzkS3KlR5xxMiJnxEOyTf2H3GUmVr4kQshQLqgi3Aw7
         QDAQxoRFUXGFJ+dxT20oGkcm0oZTXe0Cb+jFzVTP+iurPObEFeZuMeM/1Y2owZhSf239
         4Pl8F5cHz+Ra0r4T7tPmMpompcOQzCPacvKXnIyXIQFa7WBlLKwcarcrFeR4DwbFv2Ko
         t/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076374; x=1783681174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IONUdg+LZmaToKPuXriAQxtlMu9R2xBHRksOrEyRdaE=;
        b=rCy9B3GmJWEK2tZDyK1lWZN2fwZ/jPQjhkxjtqIU8D3M82wY7yQtWehowzllZST11h
         v7AoP26H7Y3SCQ2iDprepTIvMdMDxcJQ9r2ayuxhX2vqu+6wxjJnSDsZ2q0M2LCXwiHZ
         qIcy8M0UgwK8E4smk/eoAGpsFLYSIP0GOV19rLOKPo9geNinx2cLBHH+Eh8UdA7dgBYx
         6iCRWzGiSDKkz/ld60DKM7HjS4MrshPoPoNa9gMsEVmKG5QvkJeJqa7ibMlm4RJoPPkt
         SALE/oxRtlEjSmdzBHujCt3B175iD4LFs+GDClR3aSv5bhyh6V2wUMg0SMY2LDczbzuE
         9+4w==
X-Gm-Message-State: AOJu0YwN8h68KEXwKtMwk+4D1Bxuu9rA7hOwIVFRD8Jh58c4QyWRejb7
	7+hp0BG0+uxLLOYDx3PIhWVZp+ZQL9p6SLUfYBIvDV9KJLRnucSl/KMMW4l9n39D
X-Gm-Gg: AfdE7cnsh2+Q/zkV35Hj5vYi3Rb+Ogp9zAX27xABg/5WBCB3jYeZauDC0RLUg4IBNJv
	H8Xs+bPJKZ7etXDxpwkv8Z1FCCzyb3JATiK+HQA8Anc3cN8xPb29n3Dgb8nJ5H/Q3MM9oZSKX3n
	fS32Vy9u6x2Ky4FruXVoHMe7lUeQ1pykyIjuYcKrnhXkGIPqwqiF06ar2LJCDvw42s0BEN7Zew/
	92c6f6VKSIzZc7LW4HbarIx/JXbLW8ts04+dtsWPKXE3oemnsyl83EpuZmVfOjkltyMej6j0if3
	Yk9xlDt8//RiIRlwNHiXfhMa+HySHYaJxB/mX4oXPPfhbRHpPp7teDvWPbbZiQbRFfPOE7hXJu7
	dpaYaSeZpV+/2e+la7a5Y6KFci4qeC3pAK1ISoKeU7o5jmQlxo7W4n1fyNwF2BHDfWkXHG6EnlM
	IPLCfnApo894H0/FkbO84vNQqxd/hEfqQ=
X-Received: by 2002:a05:6000:2506:b0:475:69ce:ac4a with SMTP id ffacd0b85a97d-4775a100fc5mr14528788f8f.33.1783076373646;
        Fri, 03 Jul 2026 03:59:33 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/23] arm64: dts: renesas: r9a08g046: Add pincontrol node
Date: Fri,  3 Jul 2026 11:59:10 +0100
Message-ID: <20260703105923.251255-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23438

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ea82a68bb33691ea16188b6b9bef15cde874a193 ]

Add pincontrol node to RZ/G3L ("R9A08G046") SoC DTSI and set the icu as
the interrupt-parent of the pin controller to route GPIO interrupts
through the IA55 interrupt controller.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430125342.439755-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 232a0e299df7..0cedf5a38291 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -204,10 +204,21 @@ sysc: system-controller@11020000 {
 		};
 
 		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a08g046-pinctrl";
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			/* placeholder */
+			gpio-ranges = <&pinctrl 0 0 232>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&icu>;
+			clocks = <&cpg CPG_MOD R9A08G046_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_GPIO_RSTN>,
+				 <&cpg R9A08G046_GPIO_PORT_RESETN>,
+				 <&cpg R9A08G046_GPIO_SPARE_RESETN>;
+			reset-names = "rstn", "port", "spare";
+			renesas,clonech = <&sysc 0xe2c>;
 		};
 
 		icu: interrupt-controller@11050000 {
-- 
2.43.0


