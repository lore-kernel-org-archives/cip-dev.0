Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E16C44501
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:06 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9212.1783944241858503263
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 05:04:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g22nZpe/;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d70879764so1916274f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944240; x=1784549040; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VRtE6RtAIOUjA5MdKpnZuMOo7A2E0tqgUVdFyA5GrI=;
        b=g22nZpe/A8VsvdHKGVIXALlvsC2hbdKJSsJyrScW0uRHG2iikt2cMk5xVezCEribMw
         wlmuhTQlI0Cogamr0/fZG+RBFPIFymVGg/s1yQkxzGf2NMNhrrKgR/F0WvWhwWY2TKEX
         dmDTrFNqxOrQF1c1dDmxCJ/WcRnDwnUze99OHgKILLYLW6a/E4nqm8QFnbps2Rb28q5I
         CiaJ1sWDHYTMLmzv4WWdurpPY93T9SwBiz7Hh8A1HqivxOJKdKrRwVilf707898H2R4D
         fmwdIuyLx3Gqv97dHlQ825cYaePxxDzuHWbfbo+v0jV4jhfIDwQx7rbn9NXnLbaDa0S2
         1WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944240; x=1784549040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4VRtE6RtAIOUjA5MdKpnZuMOo7A2E0tqgUVdFyA5GrI=;
        b=h0qgm8NPGDKT4pvKDSK3NdpAqDNvZz+Qi8P3KiGpfGYAdCnOo2XFqo+GhSvL+dPB/N
         j1qnvDDyjefRMMDcEnYlbMQIf0OzQ/ofjusRCfXpftuelxLN8Z9+Dk85e+MuZtOXyfox
         XULE4zzblZe01Mq+ZCU4gTORm6OMNm7BqUCi68NZtuj7XEUteLoBue9NMWzS5DnKjpXN
         mVIFdRS1J1WnsWlc7IKS3IHocIZx1BQokoSXPdw7KSxWlgTG83DFc3mDT6DSBQBNW33x
         gMYcl9rYhKXdRcQkpS2lbBYIybsbTbU8nAyET/OOdJD7W1muqipnOaYENe7pxnIy5Fvg
         uWOg==
X-Gm-Message-State: AOJu0YwU6SI0oFiQmEUll/vmfeKLy75tJNaOwXla1N35hOdn8jZ7hk7x
	pk7K+rA87xG8Q6Ieoguf5ByOBkB/bp60YuOa3Q+kewyGy0cLJ2evlgEvaoTlFSvh
X-Gm-Gg: AfdE7cktONeAQ3nEsl7jUXOtbNoNUtGXyAmxEg5juU2ucwYpfNhZqlMczfoaLOjcJGt
	hA4bG/t9JzEwaZtYln4Hrs5cRh4ynW0xY6O93LdLNBtsilpKKY9NmyVCK0ERcKmej/vS6EatoW3
	PrM2OMvZriRq/ts3TAWeBG86+dvuor1VgpXIyH62dFzzUtjQdqSep0IdRxhZT+zD8JXEcxnx46k
	fh1Gby+Nne00yo+g90VDAdtUKUsUPblZ/dF1bFNwqknbwFqSYMJUWBun6ToUVXKXiL2JOVc0G3V
	P0eCuMgBU9FzsUd9/JJwvQxBoGcy9ZbVjP8SEnU7/PNgEUeVa4cj25MXO3vJt+dlprOZQNgSaL6
	itxvflFk2GFF2PwuQypmwqBLRU6PQHujne3ORBqy66ZmzT47rJHjc0nmzJuWdnDFyfxSYr2n7c/
	/2veXj/I5OvSk7MRL+cPl6qiChoTUwBoP6s8UC9w==
X-Received: by 2002:a05:600c:8b35:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-493f87ebd6cmr95122765e9.13.1783944239897;
        Mon, 13 Jul 2026 05:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm322910705e9.9.2026.07.13.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/4] arm64: dts: renesas: r9a07g054: Add max-frequency to SDHI nodes
Date: Mon, 13 Jul 2026 13:03:52 +0100
Message-ID: <20260713120354.29288-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 12:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23566

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit dcbbb1266043d1d7ca1f129d2ca58a6ce8e04cbb ]

Add the max-frequency property set to 133333333 Hz (133.33 MHz) to both
SDHI0 and SDHI1 MMC controller nodes in the RZ/V2L (r9a07g054) device
tree, increasing performance by ca. 33%.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520115144.60067-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 4417135c5134..60f82f403fed 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1067,6 +1067,7 @@ sdhi0: mmc@11c00000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G054_SDHI0_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -1083,6 +1084,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A07G054_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
+			max-frequency = <133333333>;
 			resets = <&cpg R9A07G054_SDHI1_IXRST>;
 			power-domains = <&cpg>;
 			status = "disabled";
-- 
2.43.0


