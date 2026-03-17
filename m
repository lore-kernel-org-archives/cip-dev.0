Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE5FD875A
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73775.1773747412950593135
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q7FaWiKV;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso51165715e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747411; x=1774352211; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEd2jVNqBUsFLVRV/jP35yB5r7EEUO4eoOsIYayaB+M=;
        b=Q7FaWiKVmUesin0TtCK7mjIpu2rG6X3kX+8Q+ftDGPSVD1MNhHAtExjQhuhJ0ZKdrk
         WdnGJvMFhbBjETbwVfsRY+/6PhXVxebxhxwgWfHq9IKqVizcBbv/lgY2EnJ4jq5lGOTh
         77N+OQB63VmmPtlkaSjAumk/2pptyf/i6lgTwc/qVrBLbKhGJ1Ru0BkcT3KTCe4TZI11
         63VmrSv1Efr4nRPk1snYUxp0UeQ2EvFXCk1ecXz+eAMpEP0yKrHHmL8r8uXQCUjVtz2+
         RNiDSCeTycJhlYM1K6NdsMCMMG/Fo/ww0E3ncPWHAGcrtr7CALAOnbH62PSxKhc9PHOr
         k9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747411; x=1774352211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEd2jVNqBUsFLVRV/jP35yB5r7EEUO4eoOsIYayaB+M=;
        b=pFacZCerGfVmPsXlglJOILECIeZ5giuF74gRR+7dKcTC8VT4JxfTQOkSzihWCkmjpS
         Kt/plegyrekp0Lc8ZUAJ3GZ4SnJiqNDszq31d/LBrMStNeloFkPn7ARp7aYUOWkOqtQn
         tsq5CATmOaHiuui3KMv2nPF0IYqBe3ufsb1iCxHQ6rQKFlpqPRmI0mCHa6bT4zaLVAu5
         Wyth/Wk7ccOFyJTeui32LtYB4eWBSe//aYGr2xubEfh5+ITFPa0oJHCUtNNLHDN2sMMC
         24L1JUlpU2TmN+OOr5Q+jSGJS9Fhe2PKwh6SdBE0asDl39ziy9OMKbGCXX1mZlMXz0A/
         pPsQ==
X-Gm-Message-State: AOJu0YxZukXonEBHlCWfPb7H7+domv6ISbzT4nxna3ovelkUiuqbDsVZ
	71qVuy1jTcmGY+xyPzUq/Ctp6XsbMiiPFP9h/M5ZfqanpkZg8vQJ1keNkYTPAQ==
X-Gm-Gg: ATEYQzz5twMeuq64DsED12GJhCW39qUB4pNgD1ZJ7btGPPvLl8mbo6KXggJzMzEBPsn
	LF0lE4GL9z6BT44blKjUg/ZUucsLEM6qZCWkTEV00lYzwClenI3B8P4kiYMJN1GGik5MW2qRRd+
	FC6Y2FBfIcYCllPfKJu/kumMU7rXgqTivkITrteydMi3/GGQadr+4cgZD/qJak1vt5rtJJUd7Zh
	4Lr4TR9bBHJXhsx2wevop5I4eXFaYtBR6mH8iN6VpL1O6ItMf37ZQvn2ulqP4jTxmKuVMtjdlZr
	A+69tu9ZMrjTYjjj9+0vlYoFSxBJlO5z+ZlgaesNmJPkUG/Mdl42qiE1RiMVKE+pwPgS4Iibn92
	MsWqco7lI97w8B/b0eadfEQz0D/3WLatJ4XhNG1ujvww0v2pSfXgtfKu982NUz+wdF+idoc08mX
	e8i9e7u/KrTtYFaN7CsqZueD70nsT1jGRjXxlMV0BAC8p6CZv5
X-Received: by 2002:a05:600c:1d0f:b0:485:309c:2984 with SMTP id 5b1f17b1804b1-485566d2dfbmr282088445e9.13.1773747411011;
        Tue, 17 Mar 2026 04:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/11] arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
Date: Tue, 17 Mar 2026 11:36:37 +0000
Message-ID: <20260317113643.311192-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22484

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
index f7868029f19a..8ee74d3d05d1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -204,6 +204,11 @@ sd1-data {
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
@@ -250,3 +255,8 @@ &sdhi1 {
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


