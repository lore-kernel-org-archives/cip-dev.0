Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1EF3C275
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15561.1773066367569380820
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KJLzvlnA;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b190easo5518837f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066366; x=1773671166; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh/QcXWNowvX06nTYJwNBYl7WgeXYrLELsc48R5qLpg=;
        b=KJLzvlnAP//3veU+NbETAAzYB46OpISaz9r1UEYUxo3dhmbJdG+llI/4F6cGKm6S41
         DyiUHB75HYBn+8vHoUsjXOAjKbfaLfSizwGHh31p+Y1/DTGvUeicK2ii+LKG2rr+fGjw
         n/uGE8+UI/uoTdPy5JsoTUXcH0D91MGYUVNYWND4IeOEP1r1BSQ5iTZL+Y3Yk4Goh8o8
         LGo6+JzXc1CVzaq9UTobkj3qqBKDsLQoeQkLh/CTgCB+Ey9iMz7SF6+nRsgY5qw5yPyN
         amNIK3Gx/Xj+jbpgHYm52YPkL2mDB7BUF7nfjpPU74CI7Z5oXNaHFQff1uYLw+KGH224
         m82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066366; x=1773671166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xh/QcXWNowvX06nTYJwNBYl7WgeXYrLELsc48R5qLpg=;
        b=TsW4Tw87xdo10/I9+/YFrnSfM8PWbhWWqGiwLKlLnzijWS+jCJMkROKGquJ/fskwq6
         9p3z/8el4bXV5qXXJ3GAKdCbRmGQ994DL0PCfUSPiQuZWGsywbv+jSQPreIYxasPLj4p
         qt84+XVvJbcmN2qgea2aJ8pqspcJGDNFE9ll2gbgtcFnQ56gCRXwa5A8odimYhwEUyJh
         68vfdLc3s5+R0n5NMNdICisDiKCYTElMZKC6D7QHwljZCwuNkYofGv9t5A5AJSwbilS9
         dLAzYuJKPEH3mRTBRT8CR3NT8Qx/8VwTFt1uANIPO6VifH0Zq8W+shGFT6jZQHz3hyOl
         dobw==
X-Gm-Message-State: AOJu0Yy9v8HOWDncuP1MiqHl6GX11TJ/DedFB5gRrbgeFAuGkVD2KCNT
	+IGdM+UGOQKq/uKwopjdVPQML+JneeDV88g5/G933IhtwCF7V1FuzrvQa1+/ZA==
X-Gm-Gg: ATEYQzywJ9H3RHbqwaf9GwrQXrR+BMyHnkjE0QZ6kjOQQrl3LJsZV4tDhFmsJkBQSOE
	3eLodfUiN5MTnRn1jcOQE9J/8ZHV1+Nm5Il83S09aetm4OORNXTyT+IM1opNSj9IZRB+kvhjndx
	ED+cyITIDmj895rjRi4WtzU8KoA9FKh6fhpNyjWEL2ZbOyK4eD5p8Zfa3HEgZeiI/xZ1Ig6DSiq
	7icWkSbSzNZj4XJd7h5ohHNDoRy0wAg+z1RhKQ2UV2vkzPLR+RIBNMCn02PBZNMRKseDTHnPGNY
	4ZgxwMLsD08iWhupPiv2PBu0peFRFBfz9oXOwuYg4n9Kdm26jGGpSTV2nxoZMFpv4WZ54VsFzdi
	RDda4kGzSCkG1HTN4+tWppMcHumlCtWz7gL+afnu/GR+briSmRzgy2gaqLtaU1Jrso+K+FusTG8
	uFw9UtgimSpvTWg6n6FLHln7hwcN4eU/oj1IM5/4ZkNg==
X-Received: by 2002:a05:6000:4205:b0:439:bf2f:122f with SMTP id ffacd0b85a97d-439da67bf3bmr19305464f8f.45.1773066365652;
        Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 26/29] arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
Date: Mon,  9 Mar 2026 14:25:26 +0000
Message-ID: <20260309142549.987737-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22194

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
index ed6fcdc337a0..a612c9784f1e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -35,6 +35,12 @@ / {
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


