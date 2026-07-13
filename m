Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CFC43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:04 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9209.1783944238865270524
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 05:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Mp2zdRH0;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ec555a26so19989865e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944237; x=1784549037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lav9os6m65ur8JdfpOxe1dktYsVQIHDfaA4JY+VnAQo=;
        b=Mp2zdRH01J8OT2rJqVxYckyrEYQ0YwoQAlJkxzw2AFF8R+rWQfTS1B0h5SvJg/0iQH
         e3vitrktvB9aDqnfIywNnFftGtJ4TXYpNIdieoxdFAMcaqh85XbwuyE8WPPvkYr5oa83
         qUhH9zkk9/5Au91DXpHIKcJkAArO7KsruswFmMMN/u9iXUoYUBPzojjRYv8NHW9eeb2R
         DoKWAgCja0d4oiGIDEhu2P9CzsBWxMgSVIYAsKWXqCCt2tJk+OgSdw2xzT7kr+iUf48F
         iR0r6Zi2lRnylhhY0CYL5gajG5riAMRpEhY6A5Z4rCuh52ATX+MQ2MatpatAM2v2jyhj
         rNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944237; x=1784549037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lav9os6m65ur8JdfpOxe1dktYsVQIHDfaA4JY+VnAQo=;
        b=bSBUV0eECBQdJjF1xPhY683iAU4jpqCHYFq7V+rTetrCZNs5pEeLj0lTqLfF87rTrg
         k8qLxqAhfmCxZyIlAUNGXNBs2mzFycfm4gRB8A5u7gL1qDNcvrfMPQqxIg8E0e2qB21Z
         j9Fz9yMVgw9ObVcuYEW1ss7EDOKMRew5ZvacTLs3kEEC1AzOtu2mMIXqWxuWaml9y09y
         DMih4RQd1D+oBcH3d64hP7nCj/f0x23U51FfFpLJH1Yt6tajQ+q7dm35lvLSjKPmKjT8
         J4ZmnECtIoal06yYNYhbKyllc1LwP3n98fBJ+ivhFaa6k7bIkkjRlAH4v4H38ufPAWO1
         vcZA==
X-Gm-Message-State: AOJu0YwpNjNUzhJ1Y2T+5AgMiRujkC7ql3QecEEJJ7N5BDWP3xA8vAT5
	Y0mJMp1lCfpVY0p9Jksw+Rr6n0sEPB46wu+l4NxTCMXBdg4/PqeoKqtjDqyIIujI
X-Gm-Gg: AfdE7ckQE8MSJ43a24ofWr4WrMSKDNC6AWaGTPcPGwsLOKrFWRPtMGxEjGeL1GHW+vG
	5hEPVvIbANQ5XcgkIYP73T9n+oQuwpJUBqCQ3ocUZscHEJZdddM+AIPNIG1YBFwYS4sTWi0SXs7
	qM4pyacJxQn9YcwUhPE3o5STiKHSQew5iS+x6KR/U6KZU4cwUJBDYRpoAUGITjnRs36/DfPnggC
	4Om1e/x1XfzS3mano14neeUWfFfwZq1mdMauOUpKaMublfGwZxS+Vyii3k+Cs4CFLUa8wPgavWh
	w0ceyVle4C8dFNkAwykJ2Xov8VumrKXUIYaLxCiux2NeKgybeU4JxceOlu2cwDyLB0B1Gq5yuoZ
	JeGtVlI54cF+HzUPvTEAxs+STI0kbejEn8DT9WDkYjZ+eiZbR3Om6hBtit5enNT8k1gYL2Evk2v
	qcQL2MBCLsyv2lQ7nze+SiL6Om78Ib6rXNyhS+zQ==
X-Received: by 2002:a05:600c:3e0d:b0:493:f5bf:4deb with SMTP id 5b1f17b1804b1-493f8818c63mr98325915e9.25.1783944236908;
        Mon, 13 Jul 2026 05:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm322910705e9.9.2026.07.13.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:56 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/4] arm64: dts: renesas: r9a07g043: Add max-frequency to SDHI nodes
Date: Mon, 13 Jul 2026 13:03:49 +0100
Message-ID: <20260713120354.29288-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 12:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23563

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
index 7b07bcb3be88..5aff8345d690 100644
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


