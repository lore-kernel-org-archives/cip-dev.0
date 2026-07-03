Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6335C43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:38 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89976.1783076375919434712
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=b2mPM5QJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-471eee9b7d5so102196f8f.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076374; x=1783681174; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rl0ZgS1pK9WQAdfxiE1KOh2aSmJwuG4hUk+2meLyAo=;
        b=b2mPM5QJqajPRx2ZjZ8P4gi9GuxL9lu3y208SxtgQeEOp3ALaa43tLf6mNEB4LL4vb
         gf8LKr9ZabGewRSE4tw/KXlkOLLzRM7k/SRAqvJSerrF3NYL9YKNYaYBzxRU33HYm3dS
         wU+OWCbiKkii7KM/QAYT3+DD6FNExiJ6rZ+jKHzFdWqB9z+VIANfSIgwBBsveTjXPSlj
         uSCLTrLFGBbgg2c+tvLRTuOR6q+pqEFkmCMVUqiYQMSOuj9GF8i6L68IUN6yQ1tuPCDU
         uyNVwd24WPG+fqwbfH7QweujzEbrpS1nCz3Dz+K5NaW7onYN7dMYwsScfVQ3LHWVO3bq
         DEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076374; x=1783681174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rl0ZgS1pK9WQAdfxiE1KOh2aSmJwuG4hUk+2meLyAo=;
        b=mub27pZG/D8CHRfB+dEzNwSEzxNKCxdKnJJ2DtU5JThhFglVcTgqSyghtKhaZ9MBmH
         4F+wtKSCzJjnczPd3c+mY44+IMSRCvSQPs7Cwakefd1QnSJ4iOLa2gicCZYPU12fCLbi
         aPObfggB2SFv/fhiLsswP/sNUhy5BnF49Z1jLhEeGSBBMySJIe1Shr+Zct6nfNQ7H5eX
         4nu5RyOODBkS/NQH7YB7ZTQPhqJrco64LXrfCXYhSpHoG9nRSYOSIOwGpxaOgYGF5rgn
         bwkZrm3/JRqSdOUPj2mPkgWLhWsTfjKw61+nNq9N1Hn+Kkl+31kVC2f2rW6AvesfIW4b
         LHSA==
X-Gm-Message-State: AOJu0Yy8l+dl6CrfVr4MaxbktMc5ETYQkm1njPK+ACyO9FQXMFYT//AF
	GrurIFdFYyGAC/STMrZGBFOha5KgW7fqF7asLqe+V2KmqOEDyn1wPS1JjjPUEZ2K
X-Gm-Gg: AfdE7cl2fOPbChEc0iRSEaEFf+lru3+9SwLLMkG98MNWfnrfiUw6mi4CVSZBVv6IDDg
	i3YDDACpUZnk3aGQWBqEsnR2/JMDPAVVFR1It2KP9Hx3lnphHsA6N06cjgxqE1YVVBpgAgYVQVV
	/2BBVZh2LwbiW7LpKY6ctAlpZrRF9vQazO1gtOuqy4xXoFLIK7p/hKq6xGGuGHMO76KMME+W2u3
	jKDxvZarTV9ZAd4hL9WZx1pGYWukzidB22KF/hjkTIf5YjuC4u/u6TdGUEdTJfT0ji5eKK4JqNY
	Pn+AdcF7ASr71IFvNgEeWtozg2gN7ck4qeE0hSE3mzqUmaw43/fe2446gRgkxkn8WSUxjEgnSOD
	V+jwG0jgn3MPBqXmgVtfB2GX3RH3wOKLYmpSMwOhizR38moElskl/cJMD9iKyV1knsTnK2tOl1P
	A+X8q9/N8hH7PwuSgK56qItaN9a87ggQ0=
X-Received: by 2002:a05:6000:41e9:b0:475:f0c2:5afa with SMTP id ffacd0b85a97d-4775aba911emr14064684f8f.48.1783076374044;
        Fri, 03 Jul 2026 03:59:34 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/23] arm64: dts: renesas: r9a08g046l48-smarc: Add SCIF0 pincontrol
Date: Fri,  3 Jul 2026 11:59:11 +0100
Message-ID: <20260703105923.251255-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23439

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cdc8ef62ae6d04d2ba6a9226bc432168d06ad9a5 ]

Add device node for SCIF0 pincontrol.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430125342.439755-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index 86db86335d5e..acead2b1c842 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -35,3 +35,15 @@ &keys {
 	/delete-node/ key-2;
 	/delete-node/ key-3;
 };
+
+&pinctrl {
+	scif0_pins: scif0 {
+		pins = "SCIF0_TXD", "SCIF0_RXD";
+		power-source = <1800>;
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+};
-- 
2.43.0


