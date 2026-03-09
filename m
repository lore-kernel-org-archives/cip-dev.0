Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8350AEF3706
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:22 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9058.1773042680310811175
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Bx4v3A63;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48370174e18so69076915e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042678; x=1773647478; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQj793/iyt/dIaY5ZG4NalJOnSDhRvV6mYiHKBST5vo=;
        b=Bx4v3A631AVoBmB98v7B7MBDyHl4+98/c5qF1JbG3AZ03NUPfn1OYL9Fc3wt/qriTt
         uhtM6MzPBKYhE4QibLOYFWRzkryPtaRRT/pteUF6EIqA9ooN5BDoOobLwpO2HbtUjoun
         GZC0cZ9YbOV0MeJlsSYeyZlR7KC6B8YmtwmBnNxf/1ig7nf1GZ+yv08E9FA6u5VSxwRX
         Vrtr+YKcEHkFQfUCQKUkBjwbplxDbBnzeMMEXARNINOH0IoRAS5f7GKWphsKQIQjsbhK
         AT7kq3WdAsz2UbzEyeI9noZybC4gYm445+zllYIoTwcYGXcsjNx2nnPzCNK9/TATDzWI
         lnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042678; x=1773647478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQj793/iyt/dIaY5ZG4NalJOnSDhRvV6mYiHKBST5vo=;
        b=N5hBpdjDBGZOrMG1QUdU0+zVWXBsVvmuDCn+G5n1mEZsoNJr0mBE1QFwjst+GBd6bL
         BEu0gulbmlGbiA9YGPhkxy/KnG6rS4uCtP0hvSqPvtF169IrjMNYbIM+fX4d5CdEfAT5
         Fxd6g4ttiCypsjZ2D6SowKJshQH8KxzAwIZRStS2OO9LPRIIciwAUGduWyjGGpvOQmu0
         tRHXADfpTIBCk3Q/FhO0H+lvpbNtcO6/D/Jlhv6/ePFnpy7Plja15P+ALIb1aqU9E99G
         /mm1z48mXJBke7yrT275UoXGBnzbxLRqMCyfLCNYI7J7DsPBzKotAuJhdRe2h49bYP7r
         HEKQ==
X-Gm-Message-State: AOJu0Yx6j1uURnFPkpBEOHsbo2JuAm2s6eMdAQqqpENo+tNAFnDTbg9Y
	jLor3fsk4iA5D04Qjy+ntg+Uj1xRR8r2zjbvJkP6/AUNXfZPl/d8CYsHTLxvcw==
X-Gm-Gg: ATEYQzzts/DC1j7mEOZ1QUd9wFK1Ib2MpdVal97N0gL+cmJM7iwVIuY/8yzgaJnI8fc
	zVvmpSHO/9vKHETPMoVV1OV4pFPrUvFT71+yRxgXdujsFHcwW43YMRJNap7lRwpxAC4HFOI5w9W
	ysMHZB2uL5hLDvcmmpZuZLH3zIvDCmZKSaIkPa5t5taSaTkpdCVurJpJDtg8ef10YWK7ihAZXlE
	BmfD6qlCP1XBsEOXdcUAQ2LS8hrWRPO7CE9zWULS/rerUMdkAfXu6zJqTlW/bo8STNm3fx66L/p
	Mq7k8pMa/sRJMdWTrUEUobyOZLgL9x1WKTbDvgU6NoHXMi0NqyWNB+W5hwdJDZRScj+zX6eog9L
	HES6fzjxeQj/kSHfZ1QoYiz1nQeEV5gzfkRwmypfkNO6flDfnbTpiWIJyYhzWVFoHOajNGANFfy
	xRe3Q/58I6Tj/mhUgi+FiSPQrXYA4BVwoLHw92OTThKL2YzTbj
X-Received: by 2002:a05:600c:1e88:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-485269182b5mr191450115e9.6.1773042677951;
        Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/6] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
Date: Mon,  9 Mar 2026 07:51:07 +0000
Message-ID: <20260309075112.35445-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22153

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit af6b427c7ad096724da7399b180dc3bb9f033322 ]

Specify the expected reset-names for the Renesas CAN-FD controller on
RZ/G2L and RZ/G3E SoCs.

The reset names rstp_n and rstc_n are defined in the SoC hardware manual
and are already used by the driver since commit 76e9353a80e9 ("can:
rcar_canfd: Add support for RZ/G2L family"). The reset-names property
existed previously but was dropped by commit 466c8ef7b66b ("dt-bindings:
can: renesas,rcar-canfd: Simplify the conditional schema").

Restore and constrain reset-names in the binding so DT schema checks
match the actual hardware requirements and driver expectations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260114154525.3169992-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index e129bdceef84..9bfd4f44e4d4 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -122,6 +122,11 @@ properties:
 
   resets: true
 
+  reset-names:
+    items:
+      - const: rstp_n
+      - const: rstc_n
+
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -195,13 +200,6 @@ allOf:
           minItems: 2
           maxItems: 2
 
-        reset-names:
-          minItems: 2
-          maxItems: 2
-
-      required:
-        - reset-names
-
   - if:
       properties:
         compatible:
@@ -239,13 +237,6 @@ allOf:
           minItems: 2
           maxItems: 2
 
-        reset-names:
-          minItems: 2
-          maxItems: 2
-
-      required:
-        - reset-names
-
   - if:
       properties:
         compatible:
@@ -299,6 +290,20 @@ allOf:
       properties:
         renesas,no-can-fd: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g047-canfd
+              - renesas,rzg2l-canfd
+    then:
+      required:
+        - reset-names
+    else:
+      properties:
+        reset-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


