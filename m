Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D6C5518F
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:14 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2460.1785575712324654681
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=E3pKnPCQ;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so5263965e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575710; x=1786180510; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bis5NNy0+qsQsmMrsg7nEdPnp/IFRopV4dfX0pIV3OA=;
        b=E3pKnPCQhIJylftwI7ZGG+Xgq3mg30ltIirrTit6bSes4JifIcDnUTWe5ciZHTeg6R
         AEzn+DQELq1UIK67dKSGtftqL0SgyI6orjUwqKuHyheRaNk8X2goWbvBZzBf1WlY1P+U
         P3atPYu+b1EMXP1YCyLHjKwwWC/3Z1S2iMQwNHcU1/gX2+8Su4n8ut45sHziFXadBzwC
         rOlt3iEU4ZBfWxQMYYwCF4E/u1VaGe5Zm17GH/RQ65CkQYxZ6sgtmbuZaZ7Sv02k4ZBU
         yXqDyD65qCRtnGyZNXIlH+FAkCms2yLv0+n1GUFn1Y1t6NcHhfztWle8XxRZxMOoYio6
         7Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575710; x=1786180510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bis5NNy0+qsQsmMrsg7nEdPnp/IFRopV4dfX0pIV3OA=;
        b=YXoGDrv2nlXjPE7rBjrqbrRPYk+jR03Dn9jgqXl8mxONyNzyWXbCOiPIp5n5U77Kxv
         qFl2MbUEN63Ai+l1ElixnodYXF6LUXhbXHSdUXB9mNz3LQaCrgQdVjKbDOVhKv7TtVAn
         8JwoOYIzbuv/+N/Uv5n2yGeaRP9nndvypoJ55Ow3SfraoOIYZ5qzz6MMwlI8z8xWFJMm
         sfZXfoIY7Vjxka/XAzhjYDOPFjo1i6GIRFPs785B2xQhdbRH3AyTFU26g5axkB73FwlO
         eo2fapV1dAvv4nS69JpkBYWq6dudMjVD+uLi7eilVjuhUVTl2jWyLUgOkL82Erh7TclU
         bclw==
X-Gm-Message-State: AOJu0YxuV8VpFaYyR1TzYk4djRWrSUYNGg+5KHj8Inb4Mhy8Gdofjaey
	FsQFXmYkaJZEyWjqxi5C2M4cwH0hEsHMWvSmHEzJxOzPuM6x9QeCxeJppCuCkQ==
X-Gm-Gg: AR+sD13zmqVGNiDy54bIldMcTymXBCR2xUmHUWvq5wOC6aPrAOOq8F9d+eadWSbus4Y
	1rP+Ln6J+qb7vNRl7DHCZ3E1bAOz0k4YQpu1bbj/ZHPagXDPhDLO+MZQr7SFyRMVc9NZIF13lwY
	JzJ+f/dh1wqHIrEOMYIAYk+54gnpS1J/lIAK8qBff8uk6290JhuBccaXiBsyZHKlajCqGxvOR0J
	FvHLdnGCziuZ2kkCocm95KL70RRQsWqSFjVp2sytHASwuWUBAqbGDalnWqj0azd2wMfl431Tw5m
	H8qxlfXemSWvS6nvOF1CNdNEOMPgub7PGn8ob0cCxrqEPtuSleWQ/iH9Y2gvcL7pX3TMpCxTyf9
	qxqQGA4jC7mzPo7rXRr6+/ittE7lF02LNGKe4uhVZ80eZqklrVOQtCxsUxgWNNEXXI2HXsK8cfX
	UksS5GsmQNi76hbu/gG6oQX7j7hbZg53hXu8P2KVxhfix7IW15Xl979y1hlOyN7JwKa1+S7ohR0
	QtdeJuzivXgy//XvINoKcWb
X-Received: by 2002:a05:600c:d5:b0:495:6713:9a40 with SMTP id 5b1f17b1804b1-4980c6950a6mr23132535e9.18.1785575710535;
        Sat, 01 Aug 2026 02:15:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/19] arm64: dts: renesas: r9a08g046: Add audio clock nodes
Date: Sat,  1 Aug 2026 10:14:45 +0100
Message-ID: <20260801091458.14026-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23841

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit e014a2299806b8724358f7e13579c9384a19435c ]

Add audio_clk1 and audio_clk2 fixed-clock nodes to the RZ/G3L (r9a08g046)
SoC DTSI. These clocks are external to the SoC and their frequencies are
board-dependent, so they are defined with clock-frequency = <0> as
placeholders that must be overridden in board-level DTS files.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505123708.134069-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 70f820f14335..4bb156dc3b23 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -14,6 +14,20 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	audio_clk1: audio1-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
+	audio_clk2: audio2-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
 	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 
-- 
2.43.0


