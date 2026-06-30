Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA4C44508
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19445.1782820146583691661
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LBLgq1Tu;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47248615e4dso2720202f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820145; x=1783424945; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZntixcw2um+EP7Ce3MTBgHS1Z7wynQrN+ilTXwGiSE=;
        b=LBLgq1Tu8S60MKxz+RkchM/4qdtdnnefPqLkt1OTnFtFUD7lTqL+Hbi717NLfXiBz4
         KVa/klFozt4ATft/ND+dfhZg9AHA+uP1Jquyhs2X04ZDmyKwSFQdjUeC3czqKLyJjnks
         mFYKXpqIYpZ7E0JpEy5O3OXBMYNpunPEZ21+/97bzxVo/oUKahCxS6b5sXIvAoTG6HGn
         w1R5eMF+ukVSIV+ersryrval726H2I01XKPRJG/npYTzAwDDBhoxoGYhuYT3SxktAVe+
         4nXO9CqDeXPbu4tMZkj2VFgCwymBliBBIOj96OlSBFStPacrsC6glF1IstQspyUJoHMq
         rj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820145; x=1783424945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZntixcw2um+EP7Ce3MTBgHS1Z7wynQrN+ilTXwGiSE=;
        b=VO165hbVPiLnKLGL/afts6M2AlP1HKgegDD/Chh/vcs7hl+tBRidRHfbXqnuocO6yT
         ps0IAAFR9fhLfq6SBq2jhW6LpnB95LijEz/HaNrsQt+CWBZvJ/VE1r0+5cACAXJFoRs7
         hee/9yM2tr55eO/Mj2Z+lcoDAxttV8HfygPQ2uy2MfztF/Cyf8mamNTHpRR4Jiqs1FwK
         5KhrR1fc/HxUD7A6YO83ZZ0D+3h+sHQXHPwHRrrFAlVkU8yzYdun4QpdPlUE+sjjhi8V
         vbiUz85ekaltScwKH6ydvFtpu7NP/yPGqhP79z8UmBtksLzCBJ+r2oqYcsI8TYNkk7wL
         yVQQ==
X-Gm-Message-State: AOJu0YzPoIWHT2N2F7WtGPs9lb0tCcgEIk3meDf3vEqiTKNTYcT0uqCQ
	MEpTimH+8j5IuNEy+khtA9vqxGA0L2pQhMnfB4oWYB8G9YJmnBtc7NVlASvopKgk
X-Gm-Gg: AfdE7ckUoKneuE6F9xytrxDG/149YwWAon7mRmUVpmt/3E4CmGRVPx8pbokFnd0ed2H
	mLLy3M79rxlVzQXx2hLK9y0v7MscO5KTwWt43ROtjdRwDv4T/Z0I5hS2pTzYiK9rI64ffRU6heL
	6/7QVIPCBrY/gHg5AODEcbSc1fOLm7BkuBjtlVFw5qYP/x6h+7o7epNCBiPKWRnGcWYQ4zkMPRz
	qUqMCRlrOU88cij1hpYwKBjoT+AtZPv5dpfQgjIAZ+2Dss/IE6sl5tGn6NzndUFETFPzbLz39+4
	YwNBn3kWjOvIkWBdXIUapgqbXnuO5V45N4fdBk+lO4NMybucB4Y7UU35AE8sX+F9R5JwEXfuArZ
	YnuWLcFl2awPlv45WBNdUPvgX3fyhMka1JKnZtRR3VNlZPw/PvEuQlxxC8VC8cbpaSvWUIU7MMZ
	ccKT2GktLHEdw6rJL53ijAmI7pN22NLQ55gAOL1dxbMfpVRGn7
X-Received: by 2002:a05:6000:46cf:b0:46d:d6e0:9cc8 with SMTP id ffacd0b85a97d-4765a4acf1fmr154571f8f.46.1782820144727;
        Tue, 30 Jun 2026 04:49:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 38/39] arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface
Date: Tue, 30 Jun 2026 12:47:57 +0100
Message-ID: <20260630114813.92739-39-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23362

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ab47929332551a4b2a9d38f5e31e1d9ab6a99c1a ]

Enable the Gigabit Ethernet Interfaces (GBETH0) populated on the RZ/G3L
SMARC EVK. The eth1, pincontrol definitions and hotplug support will be
added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326111953.31024-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index ab4950671c7c..fb781d9035aa 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -8,6 +8,10 @@
 / {
 	compatible = "renesas,rzg3l-smarcm", "renesas,r9a08g046l48", "renesas,r9a08g046";
 
+	aliases {
+		ethernet0 = &eth0;
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MiB is reserved for secure area. */
@@ -15,6 +19,36 @@ memory@48000000 {
 	};
 };
 
+&eth0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+
+	status = "okay";
+};
+
+&eth0_rxc_rx_clk {
+	clock-frequency = <125000000>;
+};
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
+
+&mdio0 {
+	phy0: ethernet-phy@7 {
+		compatible = "ethernet-phy-id0022.1640";
+		reg = <7>;
+		rxc-skew-psec = <1400>;
+		txc-skew-psec = <1400>;
+		rxdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
-- 
2.43.0


