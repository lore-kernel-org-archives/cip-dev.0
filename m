Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3EF106704F
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:42 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24721.1773329733393771000
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KdOt8yfY;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so15166095e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329731; x=1773934531; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rgLxOlKkDXwpLyLIpUZn0DqvELTxGWEBagBsAkhLz8=;
        b=KdOt8yfYbJQ9Q2bC2UwlBUHNbRoyWmq1Li+Ik0Jhe1HjMJ12pfd+W1wXAafegqGjkH
         a/sHNanbpmWYbJ9dPOIgN8kOCu4ANmziI8QQXRUkU8hTpHE/904g8uixCVng06dSbu5R
         gJkUieR6XloEhxLwdh5jG7eX87NjqfddUAe1xmWVgVK4bKinvapNrFGQiMoUiKEHTTo/
         fgxDI8Ve/Zka2JLCNA2XW16wTgXhReOvgyNr/s81hyhFmR/oK0xZ3xz3+Zfi65Bxp4fQ
         LyZ7s7R59GqoB2eCGoKbw055CT7IFeEG87UACZSigCSYtiGH+tmpNtq30BPXfygGs0+2
         B0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329731; x=1773934531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rgLxOlKkDXwpLyLIpUZn0DqvELTxGWEBagBsAkhLz8=;
        b=wVNjr1sx9RSbxZjKnLPm3BqId3lMfHsrX+glXtC9hP4FbZIwXvgOjhj1RGf3mq0osF
         Y6AC0uASD6GizYtbt6OKTJuNgXvoeCWdAYBZAT+Vgwep7ieEaGsh9935p7bz1tg1PenT
         RZQtzNoitWR5aO8Dh+0qJNxdcWXEy6waEWKodkEbBk7Zc4JcwC8IZYRQBwSnEynOSzCW
         C6FF52mH9ou5ferpzjsohU246I5vBXzxBkEd8+wNvQRCOLwrJMKFrEIsPvuvJM85V1Ce
         KIAQ9pt5Bog8XNLoZ0PpK1u3bN5FSHERy7+zlTJSYTZi+J4LcfVmE9bol3A5E4eY9KTR
         ib6w==
X-Gm-Message-State: AOJu0YzJtSUw6nlAwDCvZcH7hG4sQFjnhNGHiZQtihgPUu/DHVKBDDfC
	G/1ujwNs61o5w2mB7gQgEmAN4S0FP92yXiEr/IG8t0nPz/htmKEmvD4glBHo3g==
X-Gm-Gg: ATEYQzxuxiCyBsrdi6cncuFyy4eM/mTekKIptnV5YN49oieNIVzg78JSWLRLOvfekdY
	Az4LnBJ9HlXMVQd/vk7YhELNmFIjPgChB9NiptYVVjKauBQjI/Gy69SKPbKdDcEdpYzCwtogDoJ
	j0+jPNj/0bDkw6gKS8KhmwCGfv622SN7MzKBGGfGKUZShgLlnE5fJx9TnWfj1ZuHi4ozhn8YXPy
	E0Sw/eeBMpmnjN6fRfOhoZEUHyiK7ffA15Wnwn9tadJJRLCph+LyQrxBzEhL7j2sueDY7zW7dek
	67xIa/xPVFnph+fuVOhVLX5kJ9oauDaKNzaE+erNJIhS2APMgKPBRWkA8m7UZHFu8k1rNKz4r/S
	4acboP6zcZSmhGnA4pTBp9Jg4rr+eMhVaPQBBmcLDw8XdKizbAw3m9LW9JNr295OLh904N9zgdA
	Ezu03jNNxRgz38bI5lCCNpR5ieAcpKJIKK7UxX8/A8HD8KAbQ=
X-Received: by 2002:a05:600c:4fd6:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-4854b0a53b7mr122525375e9.6.1773329731458;
        Thu, 12 Mar 2026 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/11] arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
Date: Thu, 12 Mar 2026 15:35:15 +0000
Message-ID: <20260312153522.1131675-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22366

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6ea91acf0f67a7e6dd1e899955346e00778d7b0f ]

Enable USB3.2 Gen2 Host controller(a.k.a USB3HOST) on the RZ/G3E SMARC EVK
platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250916150255.4231-9-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 10 ++++++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi    |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 342b885006e9..696903dc7a63 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -196,6 +196,11 @@ sd1-data {
 				 <RZG3E_PORT_PINMUX(G, 5, 1)>; /* SD1DAT3 */
 		};
 	};
+
+	usb3_pins: usb3 {
+		pinmux = <RZG3E_PORT_PINMUX(4, 1, 12)>, /* USB30_VBUSEN */
+			 <RZG3E_PORT_PINMUX(4, 0, 12)>; /* USB30_OVRCURN */
+	};
 };
 
 #if SW_SER0_PMOD && SW_SER2_EN
@@ -242,3 +247,8 @@ &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&vqmmc_sd1_pvdd>;
 };
+
+&xhci {
+	pinctrl-0 = <&usb3_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index 69c0101ff7f5..b607b5d6c259 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -107,3 +107,11 @@ &sdhi1 {
 
 	status = "okay";
 };
+
+&usb3_phy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
-- 
2.43.0


