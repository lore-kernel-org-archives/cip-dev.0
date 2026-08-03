Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15685C55179
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45077.1785769116640221915
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lyl80Ixc;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-496b7622a83so14508255e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769115; x=1786373915; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lor6yB4eGzJ0qUlHKOtA9P3a/FZ4zMAqkqDpFbG20YE=;
        b=lyl80IxczA+tpL34ir2n/zuBYZv+s27PsHOs4sVy2dQv3qHG4prm+36ddRgJmGanKY
         IxGdSgOtodS2VdnDDX/JmDCxwEJRSK4Z90ho8a7IhADLf5QZEaQ9ZDd+RrK1flDis4mT
         PF/Nqh61d2aEylTHuXed++Ga2aXa2sWnuEk9pT2sCyzli0ctdr2wPWv7ZJi0mbsIuE5g
         hEhVM9EWliNUW2h9zez4z2Yc5s8nkPIiE760Wo0t5sUhWWjZIxrNhwnN+PEYs7mF4OLL
         EkyeWnaupmdTnWRWfFrSu6IMyTZn6iZwVnPhgjHT6eYvIsYcBUHOmS1JMaT1amXXo4B3
         Mt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769115; x=1786373915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lor6yB4eGzJ0qUlHKOtA9P3a/FZ4zMAqkqDpFbG20YE=;
        b=CExgka9a/cFkITFLVNS5JrS0KoyQoMGy5ACT+kc/lVPuQZlpb4dsjehgSdxV6lTXJQ
         9bh8QS3i8LQax76A83JtqqOoLjZhv+BGs+Ghclxswg/pKGZFCckoRRiAu8L2nNMMGdC+
         WV73ceGW1Hegk6aOYDMUHMfxYdg+1ny/scos5/ihQ6DK5PGBAkKLpQMJj2+rC3mR3ahb
         oqJJLA/YtUwX+FXbXQh1BexD0IIwznlopoyc0Asf00KzIb27QlC0WgicqybvzHE7+kVh
         WtF/KTxfdwCDwcdM3siGK6Rqo6NvbXO5EYiMv/l2ylFb/64AUoN66PlwUb7xlB0Rh7T2
         inlA==
X-Gm-Message-State: AOJu0YxhbSV2dHGauT/3VBMiPCeqe13Jt5cbK6yqNi9JywP7pta7pV37
	D9ZBDqtkJHZUfPnC0/nXTWgqSaVUZX3gMP9wueYtbcFiXWU+Y/rQCglGVrobhw==
X-Gm-Gg: AR+sD12IG0qxR2yCSadfGXcAMXdr38j+n69gGmm3BDZv4V1QMWRMoQAbhAVMDnGTENv
	rGclnJhLAWW7YzXVaKOixwUxt/+/UG5306hobxuN9Vt2vfnOlg8exHuAInbcknZHF2SgJ6eo9dQ
	bYvZ+1iFiKxrWinQrAgIcBTPi5ZDt5QWb52HK/+p512qhR0o/T9yeqcJpSd9WnKBfDG0ptYuC4F
	I/Wryu+8TKv8wW1CqVpxbNbkNarJOmA3SBSfmhnRNGx21R5mSZ5xvW5w88bYxL8/WFwF7BulFXG
	uKmC5N2si6Va6cqNEFi9y3VlP8LTpr3/uTJb2plTMUDs04QSqxnmZJXacBf0n4TMceZBR1XBqnl
	k2t57HHC2g4YFOlrsS3u6W0JVeDiAdSpBns4BOSzhAUOlEnkE9QkUtjeKP3AYWjyrjBcYZZLTRP
	CTfZd+Sb/otE4LuC16C9bTMznwqmfyBG84LGwzNdNycblIn3uWQCDEmmNMjVhQMWwzKeiS
X-Received: by 2002:a05:600c:3550:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-4980c679513mr231719765e9.17.1785769114697;
        Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 7/7] dt-bindings: watchdog: renesas,wdt: Document RZ/G3L support
Date: Mon,  3 Aug 2026 15:58:23 +0100
Message-ID: <20260803145831.91924-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23861

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 587d5a3778e9fd25e327435b58b609487a692115 ]

Document the support for the watchdog IP available on RZ/G3L SoC. The
watchdog IP available on RZ/G3L SoC is identical to the one found on
RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20260206112227.233229-1-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
index a4d06c9c8b86..40b4fb26d9c5 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml
@@ -18,6 +18,7 @@ properties:
               - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
               - renesas,r9a07g054-wdt    # RZ/V2L
               - renesas,r9a08g045-wdt    # RZ/G3S
+              - renesas,r9a08g046-wdt    # RZ/G3L
           - const: renesas,rzg2l-wdt
 
       - items:
-- 
2.43.0


