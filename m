Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC41C44507
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:04 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9211.1783944240293974858
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 05:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iiHQ/AAu;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-476d8e647e9so3134834f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944238; x=1784549038; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/aK0DdpvT9u8vElZntwqS6TY6T/TXqZif4wEX9W63Q=;
        b=iiHQ/AAushFN7oQfGbn1ZcR6m2wzyczEUujfvjQmcQgfmVMRs1VlXvhbnhYJb9VU2C
         TR3DIYQR3yWjMx99IWWdLQiSSXgbTqY0Dc6DRO+WfRqDA66GHOYOZn8zhpJciY+EvUn2
         MNqpip9o/10ajMUsB+D3fpLNRz5oEFuTOkXG2cnVvXXbQnej7Z02HrP1h6bMAHjAl8P0
         8o17VF8r6ik9WzHOgtFcVYE0I8zls0CrCEVVY2Ol56SZN7cAMiXOicdct2HATV3FCN62
         edvj3hhQ69/hqTkd/ymTU7+uo7OqT2YYwR+XXfC/O9519OEAheftenOH/GPmcbAbgxbu
         Jo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944238; x=1784549038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/aK0DdpvT9u8vElZntwqS6TY6T/TXqZif4wEX9W63Q=;
        b=Om9YYD6hpqb1Kt4c4O4FaHtbrYEKeXgzgNnpWO2N2Ho0Dr71nRuge4jpJw1PAFWFC6
         sm0VB3JjkrqdWS5+5JW8TZ8RAHDNO3bgggzZbWlIyISg0FNEuFvIpWuFhWkWQovka2FW
         NWB0Qbn4FKF+OJLy8K7SNdKzySP3JYbAfBI5jEWAZG2hkeGCEDWAp7rwZKlmiY/olQma
         a9ss48KRAfLLSyrP2UWA5A290JPlvw+UUePqd32a1jBSjkrHlUsGF9cyicQfmMMhXyrz
         9vQbKYIyD3u8/D52Js7Tk1u6fQh4/Lvsp+189HoUfu5Rm4z/vMEixFNoTdntDLQBlQBw
         AT0g==
X-Gm-Message-State: AOJu0YzN6Jra5ICxCHn6/Tonn8gwD8gtDmSbjYvH3n7BqQyD5fe2deS4
	ZGEFnv4yBueyxjjq0KRYkOiMi+IoOLp52AY/VUoObhCF+A4fOXphV5eFSh3MnRKl
X-Gm-Gg: AfdE7cloPb8aSxUfzFA8wc1VPRxJX5IvdyXoaWFuZ5vmqprrsuiid32KrSQO1dFtDKs
	EvLdcdAMP8kYUP29I8KWtQz9gP/jR+Wle/Bft3JUecEdRryKbo1vyKTDZlklkGI7B7ns5q4kQU9
	kOceTPPIToJwEQZxha+PaGIlG1q+FUfuN81dG5YQ5jGTXKNV1BCVpHi5qq3FsHsHUk+cbijATen
	Z1Hz9Zgx0gZalKAs4lq+U2dVjjK4hsUY2BGqmz+RalHtil0WWwBpkKU/GXCx3grV6CCadNwelx/
	c6Yg+9OoGZVgI4n/3Lpf6FtojEh3PFqwqnO5PR0ot5sBhdKd2er8VQawgIUoB+K4l2cGeYiuR42
	C5vO3mX/DStK5QEpIe2GOQxhDXObCEnRDFVYQ2Ze/Pj6hJbbYcv3wlnshAshlgG+u5Ko1sNw+DP
	NBq1T8torB7y2ETye8/daO+uqYhWRMop7orLjGdQ==
X-Received: by 2002:a05:600d:109:b0:493:e8bc:a75b with SMTP id 5b1f17b1804b1-493f882b13cmr58323105e9.30.1783944238344;
        Mon, 13 Jul 2026 05:03:58 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm322910705e9.9.2026.07.13.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:03:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/4] arm64: dts: renesas: r9a07g044: Add max-frequency to SDHI nodes
Date: Mon, 13 Jul 2026 13:03:51 +0100
Message-ID: <20260713120354.29288-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 12:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23565

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
index 3fcce6324097..e14728d70cfb 100644
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


