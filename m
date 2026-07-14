Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C3C44507
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:50 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6791.1784024320898501604
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 03:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YJyRbMMD;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f2e39e81so16633235e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024319; x=1784629119; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBR+qs4BFmaiYMx0pVtCcVbp8GP63s5KepIEaEmKUec=;
        b=YJyRbMMDUjED7mTA3CfDXQFL4VL7yB2p//IkDiDiClCksci7MXEP6tRnsxXLIX+VeT
         noety1ezSItka8yT2pEAB2AljTwhS8AdoD1UMnyzPwYR53K3Z8I0ZYGlYjQniIAwrrwR
         f5yap+cMWsiXotNGqIZgzXQcCuSj/kxkedn0p0HFiCyTI0KaM3kJKHnK5gxFpxioaLfs
         49aXwky1rUpik0B1YfisDpl7TCNi7gO/uhSVjJTA5K6yYA2/cbfZuZe0BwQsixseZTdn
         t0hldOl/lJhNRalM/YdqsWcYU4pChZsnA4eUWD+gPYqIoEIU7c18KITO7QKGtbAWMRWe
         pZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024319; x=1784629119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBR+qs4BFmaiYMx0pVtCcVbp8GP63s5KepIEaEmKUec=;
        b=ivWgzJbVM/YfhBMxthm1qws08eychlUM+icOtl+MD9zdOv76bMeTdzc8Xece2/ctBr
         ww9QvlzM8MIOzlHH7P/+rwATCsMgSFM0RlJavndZPMe11qlSf/Fw44BH47WfkxfnpfRc
         3OnyTpZl4X0/Uc71TTGMk4mhbpCx1uvNMbTdhpeHdLkwpDQlJO2+Cp0niyRkIw4R+EKW
         ega5Md8FLZoQ1CCaEla8B8Q94FhLJKdUHCb2daaabnvOoB+3p0QsBDbT6bxDX9K+gfZE
         J74y2RmaA+ZQEwkMDCT5zFv8mQ5D69bmVDW11Ld63YB82m0itHiX7Gm3DpLAab3hbJ2j
         9SKQ==
X-Gm-Message-State: AOJu0YzGFfAz+7lTUz+B3giTwpF3Bdm7IFWsFrIhuGxUPbPPrRcBD/wn
	m4UmZ5ACnBOsFY8MqAbdvjFycUA8bT2MpYvmVXbQJc5uBZxwYW0v43+QqIYEyyEQ
X-Gm-Gg: AfdE7cmaaEELzJwK0n9KuEnJeM4aEq4p3jn0zseKWBnMzNE3shUKmfPvQFOxxF5V1tv
	U+EHvAPmQBdNFcPku4AqwcKHFdazxqVvdh1fedSNRJz0eoIT3k+xmdLq3UxEnimvk85IshHeotd
	uJQqY5rO6792NAaARocVvfU3i628v4nwDZvD3718pwxzWbT6QpEmKCFVIvHUeQmJZugzhapGeFE
	NxBff5taIDpyzjdRgbC43U+P9yKrbPUh4QWBunRi/W7gd8FiGruoDq4Bh85jJDBNz+6svxUF+6m
	32O3OCd2Z3blivBf+4y2AgtYD/4yUoIxBZZKSbwCL3HQLa3mlyV7M1dwOFPjD4LoAGb1g8bWPIG
	laT1C/N2ldidqDWRGRuUcrJjqd7onvmJ03cmXMgr4CiWqBNd3s1/wzV/mhyZI2d7oNjt9ywSC+b
	EeTsvlIqO6gYnWyQ+MIxqrbopM4viHL6GReAcS
X-Received: by 2002:a05:600c:1d06:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4946baacd33mr45349015e9.11.1784024318880;
        Tue, 14 Jul 2026 03:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6218:8bce:b637:b72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2e8f07sm59103145e9.7.2026.07.14.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:18:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/3] arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes
Date: Tue, 14 Jul 2026 11:18:30 +0100
Message-ID: <20260714101836.8039-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
References: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 10:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23579

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f82892de7f4878f54a4035be06f3acc6e6449616 ]

Add the max-frequency property set to 133333333 Hz (133.33 MHz) to both
SDHI0 and SDHI1 MMC controller nodes in the RZ/{G2UL,Five} (r9a07g043)
device tree, increasing performance by ca. 33%.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520115144.60067-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 593c66b27ad1..ff5f6b9c1e74 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -655,6 +655,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G043_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G043_SDHI0_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -671,6 +672,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G043_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G043_SDHI1_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
-- 
2.43.0


