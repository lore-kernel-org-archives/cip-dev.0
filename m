Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49322104BEC5
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:28 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17340.1773223517860147074
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e+2AblDq;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534e9076fso26489355e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223516; x=1773828316; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh/QcXWNowvX06nTYJwNBYl7WgeXYrLELsc48R5qLpg=;
        b=e+2AblDqjIQj7rfO/I5UxZhhB44eCF98Bw1Jyoq8ohqUI4clOlMx2fODcb4sAQ5z3/
         2X7JkOQ1yDnQDoFfevRQARq/KPtDYtwJmGV72thnbAgOjSwgWcGx4ex1rHiqHxIk4QLy
         slL3Sua9gZlNJhXTSksSM+FGYEFUDLdSm1gDjBwYXk5Bbncv5M4QsALzX2fKBSw/YOKC
         YEZjqBVoAxQY4+/UxLvWZ05yHiOADxbeNWOork2dpmvDvXyWDDvF+le4cVm5GzAn7HA7
         2v8qEV+2a9d2nBH6zSWMFJPZKHfngwtRb1gg85bnmVXGiVrNtamH3BwmyrNiAiHXQLSU
         eFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223516; x=1773828316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xh/QcXWNowvX06nTYJwNBYl7WgeXYrLELsc48R5qLpg=;
        b=YWvLQFBjcpnAlp+QGw0mNTNWsRuLR0pOFk8YWXMt6cVn01L4GHSOEIVztdkXHGRELz
         ZIjVCsqym9SvCpkS+TAOGJ8letOlF+z19NiUBbnfIF+E4ZWgqECy7PGyUZh01TCr8Bxy
         bpHdSiPj9K4XatfD32e6d/OO7DIhC1BDoy+3dSzGcX6zUKTKLXeH+0ZkowHC9ANsmWEK
         su/bjBTiSI7mWB3tEdOribCajRD39ZWvqxTwUfzUs74m9fMHbsZhX4M199Y0Q+ximXHc
         pSHlYA34CLLF1l6z0jdhcgd5xUxhIDL1nfrPV0QO179IfV0ZJqqF5IkuK/f7XCTr0EYj
         AcZQ==
X-Gm-Message-State: AOJu0YxsZZDknFneXeJw/g02lk6pQL5a5sa2bg6sGF5WW37edsaVDpgc
	PPoYENUyYSee8EvTCegbhEsCqK3j0joyH1oXicY5Cl8ntbXj2oha8FT7QA81Aw==
X-Gm-Gg: ATEYQzwQYw9NAfPzo3vPPGpapmZnb5Lq7nz6yHote7c7zIQ3K0b+NNHrcioaSeYKNuo
	Um3mi6SSqw30i0aFG/Bma3iXn18WGGGJ76AZkcR0SY5Z94qkK7N+j9AwZFb/kme77FiTHuNkkW2
	vZPYxh2vKge1WkuIknHqxOtRkddWBuZMGC/cSvv85BJYxxmgXZ2ypo9H7Z6dtVQD0jv5jcCjE0H
	z5GbTIcHCH9ZGnEXlfGH9gfxjoanjZb+475xVO9FpaZYTv0iUswL5cQZhMDdugmRr4UE9y+uuXH
	YxBSuWFwS6xYg1pCsaPA1IhKPZ9aw17wG5T+f8pbctLEtcVWa5PlHhs8ms+0BcLIX8fAdsIx9uy
	UVlnyvtzS58Ote1V1jG0v7LKJwgR1NXfYcsnLkZsYUXyWo98qEOgnh1QGKVRkDVWAYXN3Tdktb4
	YpJ9eWiAhur2AYjKrbLSqARUu2OVT2CgWMbdpWYwllKA==
X-Received: by 2002:a05:600c:c4b7:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-4854b0a5669mr29100845e9.7.1773223515864;
        Wed, 11 Mar 2026 03:05:15 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:15 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 26/27] arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
Date: Wed, 11 Mar 2026 10:04:45 +0000
Message-ID: <20260311100458.162447-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22272

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


