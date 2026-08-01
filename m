Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C802C54FCD
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:26 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2465.1785575716795268045
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gglSREDK;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f6de72faso3385915e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575715; x=1786180515; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEv8aUu6PYEOtRfyVOLwbz5xooNaIGEkmbNVzmWEyq0=;
        b=gglSREDKtRaCb1G9Zyd9W8B/aiZbUBKBxU4qXw2tkhbFGxznWqhUiPVk+txGt7JHgz
         quKIxLjR8y9IRl4ntOm7V00W4as8V2ccTTR6hxmhq6lZk8llEQkOf3PFhoSFxS4p5BAv
         f2PccZsM0ABcAJ14SmXOlRKkI3f4djFTD+N92qDtZ/QOFTr5HHCLGBENqbTFeQ9Xg+vK
         40Z54I4lmKvGzkooHKo1h53XBpttbjrD3PpjtSCDr88Ga+UVOH3eTaOOGwWBdSPlHFiR
         0rY8kV+pfN54CC2acJ0sI41X/xTJ/ZjQIedYZz/bJVP6JjH8zvGqUt+38ejAgaWiSBG3
         KIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575715; x=1786180515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEv8aUu6PYEOtRfyVOLwbz5xooNaIGEkmbNVzmWEyq0=;
        b=Sf8qhaV0oUPecz5aEdZybj05ahIdsQ8VnIvYBJSdSyxuymEd08GKVf9pugDZ+Dp4Fo
         3JnYh4qEcSx+CrWoCI945l45mskHAkgL/7EmZ+5FPTW7LLPc7rtk1JO2dtp5ec3oXfQu
         DTFQD9eRU9ofeI76qs655Dgy9XMP1ag4E90mBgzqN21HeILniWshNiutNLoTaAL45T90
         MsTMbzalP8y7FtWVYl5Y7DadoDGF1TjBgF/JxXPpH1dwfI+8LKfb2dXJMrvei8QWQ8tX
         4VhN9FsTw0/rtyCvb+FS2S6W4cBu0IIr0INyn+jpbdgwgIBsxj+f7htlgWZvQTzpdJ4D
         hTzg==
X-Gm-Message-State: AOJu0YxOJlxhhGMIrJOEZpvDzhCOo4qUo+EEKN/U12yzByl5PM0D+AN7
	pyDmh/cdf57Y3T/yYgDN7DTCCzPRRcU4plY2rQQub5vw8ao0JmhJvyT7CIFSGw==
X-Gm-Gg: AR+sD13EzGIU3yPQ0CC1q7ohxoQl9RyMUYxUg1ft/uG3ywBi20LWVQG7R7HjBCgjdMS
	fhfqxWGQ8vRbQjdRIKhAY6ePUpGvTOHkfMssm+W2c3r6SDFGDwWd80jOwZXUBcv0dnscEdE9ala
	kuAJnGS2YPufNf70Dxj5hz1+4OK2El0O19cQMb+Pk/jojtJ4BxRA1WKmfVuaJCVJJ/cvHakQG0W
	kIA68kDdU3slCmOMcJRSLJrwvuSj+ofRtf7ZS9shs+/GoD0N0/W8Fz02pkLNXaZYr1bq4nHC+SQ
	LqGbhPU8PcaqW1PdA/46yVUiL27rJUL7JZIcnxs7oLth6bVZuixPaFZ3M6GlZ/w6cBaqL9qVw0L
	lrxEhLbuXK5WJy8OIeOiR6CGHmlrTntDCe1ctJoSNRrG5HQZULtjhrV3czKAFA0i83iG/nNjaZz
	FQi7XHtrDR3Tg75+zDhDowrTqb5R0nwiPGGbuGOEbLbvYJLvF/PCP7B5NVQQWN/YKTwYJ588W9t
	QqiIzOf/AnRY1hnoOS3V8ce
X-Received: by 2002:a05:600c:3506:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4980eb8e287mr24071305e9.2.1785575715060;
        Sat, 01 Aug 2026 02:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/19] arm64: dts: renesas: rzg3e-smarc-som: Sort GMAC pinmux entries
Date: Sat,  1 Aug 2026 10:14:50 +0100
Message-ID: <20260801091458.14026-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23846

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0bbc248fa2cc834392f128bfd127a03f6dbe9d55 ]

Sort the pinmux entries for both GMAC ctrl nodes in port order (A/B/C and
D/E/F respectively) and remove the extra blank line before the second
pinmux assignment.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260524092016.46346-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 49 +++++++++----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index 0eb0c6e92fd5..f1320ba90aa4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -195,20 +195,20 @@ clk {
 		};
 
 		ctrl {
-			pinmux = <RZG3E_PORT_PINMUX(A, 1, 1)>, /* MDC */
-				 <RZG3E_PORT_PINMUX(A, 0, 1)>, /* MDIO */
-				 <RZG3E_PORT_PINMUX(C, 2, 15)>, /* PHY_INTR (IRQ2) */
-				 <RZG3E_PORT_PINMUX(C, 1, 1)>, /* RXD3 */
-				 <RZG3E_PORT_PINMUX(C, 0, 1)>, /* RXD2 */
-				 <RZG3E_PORT_PINMUX(B, 7, 1)>, /* RXD1 */
-				 <RZG3E_PORT_PINMUX(B, 6, 1)>, /* RXD0 */
-				 <RZG3E_PORT_PINMUX(B, 0, 1)>, /* RXC */
+			pinmux = <RZG3E_PORT_PINMUX(A, 0, 1)>, /* MDIO */
+				 <RZG3E_PORT_PINMUX(A, 1, 1)>, /* MDC */
 				 <RZG3E_PORT_PINMUX(A, 2, 1)>, /* RX_CTL */
-				 <RZG3E_PORT_PINMUX(B, 5, 1)>, /* TXD3 */
-				 <RZG3E_PORT_PINMUX(B, 4, 1)>, /* TXD2 */
-				 <RZG3E_PORT_PINMUX(B, 3, 1)>, /* TXD1 */
+				 <RZG3E_PORT_PINMUX(A, 3, 1)>, /* TX_CTL */
+				 <RZG3E_PORT_PINMUX(B, 0, 1)>, /* RXC */
 				 <RZG3E_PORT_PINMUX(B, 2, 1)>, /* TXD0 */
-				 <RZG3E_PORT_PINMUX(A, 3, 1)>; /* TX_CTL */
+				 <RZG3E_PORT_PINMUX(B, 3, 1)>, /* TXD1 */
+				 <RZG3E_PORT_PINMUX(B, 4, 1)>, /* TXD2 */
+				 <RZG3E_PORT_PINMUX(B, 5, 1)>, /* TXD3 */
+				 <RZG3E_PORT_PINMUX(B, 6, 1)>, /* RXD0 */
+				 <RZG3E_PORT_PINMUX(B, 7, 1)>, /* RXD1 */
+				 <RZG3E_PORT_PINMUX(C, 0, 1)>, /* RXD2 */
+				 <RZG3E_PORT_PINMUX(C, 1, 1)>, /* RXD3 */
+				 <RZG3E_PORT_PINMUX(C, 2, 15)>; /* PHY_INTR (IRQ2) */
 		};
 	};
 
@@ -219,21 +219,20 @@ clk {
 		};
 
 		ctrl {
-
-			pinmux = <RZG3E_PORT_PINMUX(D, 1, 1)>, /* MDC */
-				 <RZG3E_PORT_PINMUX(D, 0, 1)>, /* MDIO */
-				 <RZG3E_PORT_PINMUX(F, 2, 15)>, /* PHY_INTR (IRQ15) */
-				 <RZG3E_PORT_PINMUX(F, 1, 1)>, /* RXD3 */
-				 <RZG3E_PORT_PINMUX(F, 0, 1)>, /* RXD2 */
-				 <RZG3E_PORT_PINMUX(E, 7, 1)>, /* RXD1 */
-				 <RZG3E_PORT_PINMUX(E, 6, 1)>, /* RXD0 */
-				 <RZG3E_PORT_PINMUX(E, 0, 1)>, /* RXC */
+			pinmux = <RZG3E_PORT_PINMUX(D, 0, 1)>, /* MDIO */
+				 <RZG3E_PORT_PINMUX(D, 1, 1)>, /* MDC */
 				 <RZG3E_PORT_PINMUX(D, 2, 1)>, /* RX_CTL */
-				 <RZG3E_PORT_PINMUX(E, 5, 1)>, /* TXD3 */
-				 <RZG3E_PORT_PINMUX(E, 4, 1)>, /* TXD2 */
-				 <RZG3E_PORT_PINMUX(E, 3, 1)>, /* TXD1 */
+				 <RZG3E_PORT_PINMUX(D, 3, 1)>, /* TX_CTL */
+				 <RZG3E_PORT_PINMUX(E, 0, 1)>, /* RXC */
 				 <RZG3E_PORT_PINMUX(E, 2, 1)>, /* TXD0 */
-				 <RZG3E_PORT_PINMUX(D, 3, 1)>; /* TX_CTL */
+				 <RZG3E_PORT_PINMUX(E, 3, 1)>, /* TXD1 */
+				 <RZG3E_PORT_PINMUX(E, 4, 1)>, /* TXD2 */
+				 <RZG3E_PORT_PINMUX(E, 5, 1)>, /* TXD3 */
+				 <RZG3E_PORT_PINMUX(E, 6, 1)>, /* RXD0 */
+				 <RZG3E_PORT_PINMUX(E, 7, 1)>, /* RXD1 */
+				 <RZG3E_PORT_PINMUX(F, 0, 1)>, /* RXD2 */
+				 <RZG3E_PORT_PINMUX(F, 1, 1)>, /* RXD3 */
+				 <RZG3E_PORT_PINMUX(F, 2, 15)>; /* PHY_INTR (IRQ15) */
 		};
 	};
 
-- 
2.43.0


