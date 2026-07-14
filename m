Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC5C44508
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:50 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6748.1784024321736308421
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 03:18:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JowjJiZA;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9240295e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024320; x=1784629120; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlWG7M1/okhJXB13Np/GnX4mck/CXg64/hc41BnGTnE=;
        b=JowjJiZAonkSNSOO3br3Za9AGYPEhHOp65/8gAcz8ujmbgsvvWuJhHojF7tGrDGPG4
         CcUAXLknz/A57ivGQOeD48i6czicj5gCyT+DkypqfIWf7DHacvJM6xTyKXh390VTfgbx
         laSrHvFQ732Yun+HURQPW6Hxgo7X/efG1SKAMnkJvKoiB6VjXAIESc1z7C0rwpd15nr6
         QmOlnRtCrU2RVH95HUPC3VjwDrKhODmUOlFixO2hl7i6z6ad9swx+l7Gkz/aK+zW6/og
         3eF77MC9/Zxd3ApCPve+opFhQI4/qoDbebKFLg7BN31Lc8HiAnKPYrJ+Z/z9k5lhFxVo
         +mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024320; x=1784629120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlWG7M1/okhJXB13Np/GnX4mck/CXg64/hc41BnGTnE=;
        b=Yy30RZidh5k0V4vVPgI40xi1Uz7LxIy0I5PTr+ng387jX11TUIJE1f15+Hr40tAKdF
         X0XHr8P7karnf0vP9uO0vTPmeyU5hdVWVilS2RZ5kbuSj2sAzplmTIv7lSa/LLu9kBM3
         SNml53h50kmuo2gQ1YnfYW4uisNvOtRUKOvY4YgerGalCQOo3+37AhAcpq3cSR8dil49
         GNicIoU4l5LRpEb7DYFRQvmjl7YZP1dsTtZIqe9K0qN0CTCiEQ0gypXDI1qnCnhauwBh
         gHYAQi3dhZX7k3xWTERoQTwr3swPugkjB/2mF0RJTodiHrSqXzzyVL7KWCRpbBbk4mtH
         kYtA==
X-Gm-Message-State: AOJu0YzQSIsI8HkeDlREO33hTWmXUMrk7AI2318YnVQ96i86UgOL5n6t
	jOJkfWrTtsoH2SAIqvW3N2FIhlQOGEm4s+lY3ZLIYIBab9xB7Jrfl445PRsizXUZ
X-Gm-Gg: AfdE7clTeh/+Hs4CDQQDGzL89waErXCNWJaTJExULM82FlQeEvMEDS7KIsHKTFqMmxo
	zMnt07pKvcC6/VW/0r/k94L8vaUJ994BLpfv3Kdxg8d2TxjaAXtiPv7AV5HgmgBTkEpzjwFAh+N
	j4/7nLBn5JOb3kpZ8gSZcLvW/scqRKBeAkx43GdgnZHhyaIDhrpMMgpXcZgeINRZZzt//tbBnL3
	XlvUB8EObAZv653yPatKC/d77HyDfebUFobwGXxDQIVK5AZBxpcCsRDqB9uKLHm3CkhhNZwlRaD
	WtDKq7pTnwwB5G12XqMxHGmjynfkwrUdC+Iex9u0IcTG3ByNv37H+GLmGUtyfsf6FAg/qZVg6oU
	AR0P3Y3ac94lkQA292k6sxOJtnBzyxaiCwCfk9P5DU5ruLFCicTTn4Aa7dclzFDJBJJH/k1Qz9V
	r0UL1RzSzs6tnWnQniU2HPGgjHsO5eZ1SoXXBK
X-Received: by 2002:a05:600c:37c9:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4953a5271e3mr541185e9.5.1784024319554;
        Tue, 14 Jul 2026 03:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6218:8bce:b637:b72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2e8f07sm59103145e9.7.2026.07.14.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:18:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/3] arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
Date: Tue, 14 Jul 2026 11:18:31 +0100
Message-ID: <20260714101836.8039-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
References: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 10:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23580

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 1b3c392bd655af31a414fc82382cec13e090a997 ]

Add the max-frequency property set to 133333333 Hz (133.33 MHz) to both
SDHI0 and SDHI1 MMC controller nodes in the RZ/{G2L,G2LC} (r9a07g044)
device tree, increasing performance by ca. 33%.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520115144.60067-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 6b1c77cd8261..90f4d9d8c62a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1059,6 +1059,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G044_SDHI0_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -1075,6 +1076,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G044_SDHI1_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
-- 
2.43.0


