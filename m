Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB531C369D9
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:02:24 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.40950.1745816481823976598
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cumM5pMV;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acae7e7587dso658557266b.2
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816480; x=1746421280; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLK4FWi3z5/ERGW29Q5WBQ7D/yL2ySlqFQlNza1zPm0=;
        b=cumM5pMVC7EoJxQXMCVnl2V3CYFiUG1X4pQi4e6/XGTqikwet1M3G3/vaetf3idQIk
         hzc7SijoInd46/bwjZy2vyVHWnK21iB67L2AEmobaSb8opN906lW5pyVkfGeEaN5yKXS
         2xyspZwK5dADe7rU+5Up6BN6NMqXSGFCkuHFg9tdMm8IJDj8qXAVqiRAg5wYJs/UOrrs
         MBqg0rrTuo2rtsmRhctUR+KKMHLJwpgQl36lLAqeT8oSBnQsX6jkA9zZltlMRftWXyoC
         Hj/dYwXmacwhvxlth+JOgvSfZTKL9fH7JauQfNUZ4mWS5ZmkKxr4oWtANljkAs8yGuht
         6UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816480; x=1746421280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLK4FWi3z5/ERGW29Q5WBQ7D/yL2ySlqFQlNza1zPm0=;
        b=QNlueN0YQCiwqX3C/2s3khoAORiR1vn4syYsE2TMmjYWNpVNDsl5StATbxGUY1dd2b
         jHW5bwCsX1GKzz+Kwl1qTy8hKDO5k2/S4rUUPBTt3qCTDXoXI/3TDfLMOiBiRG9tODbk
         SyQYDe+I7RoYngutjuACXq4SwGbFrNAACsc7RUTczAKgPgJC6P7MD2QCti8oLcvadMEy
         HY1tN/sgYYhP3ksxb6fjlG2QmW1w6mOLvqMaIhCOkrsMQ1fkGOj7cnz4C2FyszDN3+hh
         XjSvcKQPjNYGESaVkF4/UlQl8A/oU9HXTfgUUr8keD4G42XIvHozNri+5UGboRhxzoc5
         Fklg==
X-Forwarded-Encrypted: i=1; AJvYcCXqHJmQKWXt1euisZePgXnRgw22lSfU3nFb8oiB9mt+zlkVhWQKozNhh6k/OuGHQB7xqRwf7gn7@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz57PoYowGjjkVLT8FBbYo428XOuWPiEOK0Xvr07hAHbdRp5vaL
	dzD6GCM3xjcr8INBxHiS5ZjUd/x+a7mVsC5dTNPDOwEwo5rUKNNL7szIT/AWI14=
X-Gm-Gg: ASbGncsw848SzXr6pmul7CAh5+jpn+YcuSX4u9s6gJap23powQPt+hu4TipbpZ8OVOL
	lvWWO5LJZNV1LvHkEuEx/2G4WtcMU+9ncBSbT+MjVMLN5p47MnPZeomBRRNJhsisoa32eYz7ft7
	J2cDridyLC6lMt3m0ix/i8/rqbh+CgN5piV/J3MvJK7BLasRqeR5kmZb/PN0TDoBFv/SG4HYnjS
	HB/TiaV9b5Q7lj8VVWke1cRewxjIF/gNQkTsSDzku9JVqug2rv5DJGHdHmzVlgpnynQ3vePqy2K
	2QWWUwz66XoYpKfoxKfVK93SxEkhHeVw806/rfFm8jpPQ0VweRcnjQl+CziagEqelX9wEG4=
X-Google-Smtp-Source: AGHT+IG2M5hlbOweyA2QuzMsX0KB/mSSASlpY5WNe2hW9UYDzjGvbpWe8G34hIIynTzqazZty3JIDQ==
X-Received: by 2002:a17:907:9492:b0:aca:cac7:28e2 with SMTP id a640c23a62f3a-ace71399bdcmr961508766b.40.1745816480239;
        Sun, 27 Apr 2025 22:01:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cfe8sm566055866b.17.2025.04.27.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:01:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
Date: Mon, 28 Apr 2025 08:01:15 +0300
Message-ID: <20250428050116.3081804-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18675

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7492b2f89cf6d83e2a68400c43be25bd8d4cff4b upstream.

Document the Renesas RZ/G3S DMAC block. This is identical to the one found
on the RZ/G2L SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 7e472f3d6087..6e7b4b6af0b0 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r9a07g043-dmac # RZ/G2UL
           - renesas,r9a07g044-dmac # RZ/G2{L,LC}
           - renesas,r9a07g054-dmac # RZ/V2L
+          - renesas,r9a08g045-dmac # RZ/G3S
       - const: renesas,rz-dmac
 
   reg:
-- 
2.43.0


