Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA35C55AB9
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:58:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45075.1785769114383332092
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 07:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BApzmTAA;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49553515a8bso35164275e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769112; x=1786373912; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6oQgSfKU8eEf0LPbgWK4YkmdbZFrI4ELvnhvSLqZoc=;
        b=BApzmTAAzEm6ZBGNiWjked77DdHsSzcymFFpAOpqAgHoXYE/o6fmrQeKcGL4QQCmy5
         u9gxXnU2No3y2i9bcX2JZSTo2+jLpPm/nkL+3PoMP804b2+zu8bouyYYPougHLEvLtOi
         QPjFcm09m7gY5eP/5F6JAam5OLHpSsvYvbwFh+uvs4ImHCxA93Kfh678bChEH6MUB1x+
         KO0+A2bQ3QXA813o6Ot1cJRwC6UAdg0glmaMtTDYmcoXzRwJWllFVhuE+7qGVwETHHaE
         KkTV762FTJcna5xYiq97HDNfX0hYrZoVwJUnULKYurPpWRTyP4+4HwWdJCD64X0ndKw6
         R/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769112; x=1786373912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O6oQgSfKU8eEf0LPbgWK4YkmdbZFrI4ELvnhvSLqZoc=;
        b=IEXfYUHuuRi/TA3s8QR5/oSZzRs4vrh6Kw8+WC8IForuIbjqhwdbWGDZ2PTQUDKSW6
         fGpBEblUpLrQRBONL1+2dwvkdwU9rHjoaLfAs32pd3ewhy6CvWP2pQkkpP5SY9lPrQNo
         KnHf0OlE0XM5p+4YzTyT6nW2JgNbYnQXVJWR/hL0REZ49/lbnf+gEjmraQMJ/4dCHNl1
         kcuKQB6ZYVdWML5gySX8vo17fSBbDIesbdXDmVYDVRWRi3oQxEgq7UVw2I8TYpoB642J
         JXGPznAuda+Xt1tCXSarF3fFjlCxticlVYfeWSWoSYP2tbUPO0++SfQEFDOA7gHA3Qxj
         Ia1g==
X-Gm-Message-State: AOJu0Yxg0PQj6/Pp0bBy4l+wGgn46h+1fbieRuNMDMTKEkC/S8YLxvEy
	BAf75+kOpttG2JcocB+2DNaZ45D3lXggl0QdBr0gpCjpOdarw5mC/9XXrUrTiw==
X-Gm-Gg: AR+sD106aOlAL7cvP5A1bMVVWtvA9L3Kcx496Y2bsPdGqtA7EcnqajKi9iF+BfGGY2O
	qgWz94IC1wmzP0rkXBNxmAoS67qzFV/nJPLS34wdfwXThXeWfgEkVr6srm870jhJGnHW3mhTsWh
	xBa198Z7ZrSzNr669CAiM/jrgwWJwHSHr4XigWxCq8qKldGPGPbc39N1Q29B0SXlaTtHDZZff69
	m8ZDOlz6AxK25iL6qoGOF+XJHAHqfqhInmeaQHOgQbbrI3SaSu2p+oAnRXdDz2GDFZyYnblUSw8
	9ZoMwgICX5rOiqdILvwZx0nwyvsEwnjUqESDTR4dIHeFsqplvYfFfZ/0hzzk/exVFBVYNSUlXEy
	ccTXuufQ0XVYA7r4CBb7r5gTqCurT+nHDZGdyoqmlDoiM0GQKCuVhxv+zGffqg4O0TXxWQhujsH
	zwzUbPX1Hu4eLjd9UrILQloSSBGFmDcRfSYgwmy9jhimFqgwcd4GHat/3+Hc37/7qAvGyf
X-Received: by 2002:a05:600c:19cf:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-4980c674808mr216000515e9.14.1785769112167;
        Mon, 03 Aug 2026 07:58:32 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:ff9b:eff9:a8e1:4fd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm224754315e9.0.2026.08.03.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:58:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/7] dt-bindings: i2c: renesas,riic: Document the R9A08G046 support
Date: Mon,  3 Aug 2026 15:58:17 +0100
Message-ID: <20260803145831.91924-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 14:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23856

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 58ea47a30b7dd2053545d5e7cae37b640b0dc442 ]

Document the Renesas RZ/G3L (R9A08G046) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G057).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 6876eade431b..ae1f71eadc66 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - renesas,riic-r9a08g045   # RZ/G3S
+              - renesas,riic-r9a08g046   # RZ/G3L
               - renesas,riic-r9a09g047   # RZ/G3E
               - renesas,riic-r9a09g056   # RZ/V2N
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
-- 
2.43.0


