Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF89F3383D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73454.1773746271468829656
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XBhh3zmM;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so6832025e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746270; x=1774351070; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB00BJ83oMTBJI2B5dmJ8HBI7S9cAMtaelHKwakz4TA=;
        b=XBhh3zmM7rx3dM7NpmBlt/TSysLCbm0I6vLMfIB0ZqJhdpyy+KtYsX+uqHfoxTn9a9
         mCw+eUM/a9oDgW0vuH9HvXQfJiHgs0G2xDhVYZ9yXa2PDTLgijUMUCnJ2Mv4xLvFunHv
         Tn8GAUb2Dye3QVDHJeV0aWpVbGyiWiUM5TyV5gvIunTSjrk6zi7jb3a1GpDGAhQ/guXH
         URv/Ol2oObVnZHVpkX0EbnueL0dypmOOvcp0xGyayUCxBm5wy5Nao1re7w1kibOvoLyK
         SIzB0WOHqfK9aTrj7jQkK6FMwsQ3qTvjrePknWZVRBu7Rm/YnOjPGW/KUDbVJbTDXRmn
         kcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746270; x=1774351070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SB00BJ83oMTBJI2B5dmJ8HBI7S9cAMtaelHKwakz4TA=;
        b=LFw1yyPboe1S27zZCpfIq7k4rZrI1i6B2WzSV16YwsBLc7TKpJK5ItR3K9GihbjpWX
         qNJbzGgpzTLRuuUvMQQ2Pb812SvTeYKIkduO+CtMVWQosdI+n0gOFfvg7arqgqkfWVis
         RNcnp0SMsJu/ix0K8gdUae0O5nqyp+ihvOyZDtUR0AVUbXM8OzW3vptvUL5TXO+xc7Qb
         LUglyavDVbdUO3wWWicelA1ajgI4Y7U6UONC1XIFYrjUrNA0xe4xIOR+sZEOmaKOvd2t
         6xk/+x0OyyZinrLeFzKMb2zJRfZPhPpsp6pGtxl8kKKrmF6CcfrIYxL6+dhNM1UGOjhH
         ltSA==
X-Gm-Message-State: AOJu0Yx92RctaCzNYieXPpZIobf/IlW095mltM3QFPHeT4lWPiZ0/h77
	2N6TrikBBd+uxUe+d+s4fBpM1Vh7Nbckm2K0wiAU1w4ITn83Onoa3EitttIYhg==
X-Gm-Gg: ATEYQzxFZnC/N5ZilsHBZgDyz/E7FQVIVPSE+R10AS0XrbjutbkKpiZuEXF2ABNdzEQ
	UqzXTsHRD5h6/fEHAqpApbkSiAK76WGL8wBEZqLLHUc1/L6m7P9osS8TUA+cuGC/JZyyWVwvsX0
	lLSOelQrywe3+YfjRnXiXgT9Z8qD/oXtomsLMHerAVvHMtmCgDKRcIGPcDV3i4S+J4WPWl6L50q
	EDSysCMNc+TE7vipblyKq/JjxTx9b/8ntkqITAYd/y1p60cBlo5TDhhhGQR1wErz4m/EfAdUnVc
	GLmhN0JuBqCrP2Sq2k62YYSPwgYlhUdLoTShxaASHmuX1cUvL74Eu8bQCxk6g3GdvplX+fHfsA3
	s5zpD5DIum/jBy6CDtl2Z4ctQg6XCzcCXV2AbucdcyNIBEZtIyGdBWXrJO+BLU8TP7WGaVdoEca
	CiePl8Ktx8NEByNGm6Z0uRq9DBG3g6DN7Xv9v+tdFYV/zguv+B
X-Received: by 2002:a05:600c:a09:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-485566ddac0mr292271465e9.14.1773746269434;
        Tue, 17 Mar 2026 04:17:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:49 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 38/39] arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
Date: Tue, 17 Mar 2026 11:17:03 +0000
Message-ID: <20260317111718.281633-39-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22471

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ccf2044987b41dc589de6a86b35d3a4f8ea14762 ]

SMARC2 board dtsi is common for multiple SoCs. So Move aliases
to board DTS as SoC may have different IPs for a given alias.
eg: RZ/G3S does not have RSCI interface.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251129185203.380002-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 6 ++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi    | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index d20ab1183d89..8847dd8ba00c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -38,6 +38,12 @@ / {
 	compatible = "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
 		     "renesas,r9a09g047e57", "renesas,r9a09g047";
 
+	aliases {
+		i2c0 = &i2c0;
+		serial3 = &scif0;
+		mmc1 = &sdhi1;
+	};
+
 	vqmmc_sd1_pvdd: regulator-vqmmc-sd1-pvdd {
 		compatible = "regulator-gpio";
 		regulator-name = "SD1_PVDD";
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index 58561da3007a..a296c2c1c7ab 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -37,12 +37,6 @@ chosen {
 		stdout-path = "serial3:115200n8";
 	};
 
-	aliases {
-		i2c0 = &i2c0;
-		serial3 = &scif0;
-		mmc1 = &sdhi1;
-	};
-
 	can_transceiver0: can-phy0 {
 		compatible = "ti,tcan1042";
 		#phy-cells = <0>;
-- 
2.43.0


