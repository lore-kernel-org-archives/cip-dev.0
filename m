Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B5EF370D
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:42 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9258.1773043897346194843
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=StEdfhw/;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852ff06541so16108315e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043895; x=1773648695; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha1cUCeft29sn1o/iOrC/9hvhZaNqZo673De7TDnn9o=;
        b=StEdfhw/+BQVLfHn4M0BKwsnVX/OihzQoeVFXAW8GWwj3gD9AssIl/mpPdf91f658m
         vWiX5ok+h94geCfzXxpW7oNojxSGiEGlwCmt70lZ1MDtECc5S5rqN0t/aYSava3/AB45
         S3ZhjdExNNAApXWCR/g/YwLx/tZoNh8hLJ6x1IKkscQVOqAv7JDTtjI3WVMaR5304OrF
         6XRgNTU7zjfhis0+rT2+r60Tn/4BtJyUZRqdovHq49GauZpOf9FN10oSQNSlYFVXoNIJ
         kU9XeXI8as/gLdAb8wUbCmnlItHHZneztfwmDUan/ZqwzNHvd328oyc+X3+zKLlfJtVK
         jxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043895; x=1773648695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ha1cUCeft29sn1o/iOrC/9hvhZaNqZo673De7TDnn9o=;
        b=kbjcnqHjEs5M4Po+dLfRtxRpBOPEnIHQ40ShD9B3QiIveOyiB9RKSpk49P2xnPpeKg
         W8BAfc0PvbgEWw0yzMOtTDq4+zBiR1h5RFafrgPDm+uO+qzO4clbcFGz5ZPdvm/L4iIW
         qRnvYxc3wqxXuchp1si0a5itkr1s/JxDn+Vqx5IHpJVZ0ItGoAgSpAM0a02H/D2Hwgch
         AB+ksv0s9adCg8pFB+pZu9PtdeiNYANkGuiGWpvlnhUf1mjZ86DMmm0awNSn8YAuxpj2
         94CEgG+vYIaUuHlzYSNWnE/OxKWrDL5LjH3/MTf/F/6RyuusjjyHpAlFl4rLhMfS5U/G
         2Nig==
X-Gm-Message-State: AOJu0YzhpglYp4Onj7nrjB2aBz1atM2RuzCGUO4qj4njNb0EQCS11OQD
	EMIwT8QeA+ClTm6ozavgWZKqLqJJb0FtKSSZf7/bFreC/2P9Y5NpQMqgZAK0kw==
X-Gm-Gg: ATEYQzwnTF68yDD4IjvPD1znjDaihyODbX9S/yJx6I8s3VgQt30ii8lYPtXCG9P4yr8
	KimVmUyVwNpmFpnWtgmymW3bi+NsP/wzcEiE9PhsP0G73ZPvHyG2uhJA4NM/KjeaJhmdfZI6LFX
	Cm7PX18DhL9xzlZsURoerA3jriT8x1eluuJJnZYCLQf+N8dUtQNLjdHv8dsphSA11UKA42AzAWG
	1STZLAYhWFzoLHUmS4725ynuMxNQ7LbyT9zV0FM9yaYf8QXQridqFegbjDskz1p4wqV5HRkf+rq
	kaGlzFZaHTnxqVuGPncIdY7KVIQPDEFQI8WJ1DHxj+usqb/KDQRO+RcptDx9HHI7igYMFRPX000
	Ho0zX9KzOgcRhN5hyWbHMSbbfMAR9Qz/6QSonX6YicygdjHA2ixEplPHu7pBb6ZzrQ+hLpp/wr/
	3/7J6NZ3l6MxkvRnEjXJNE8U9OumVXlI7fsBlG6/4b2HoxdGOn
X-Received: by 2002:a05:600c:19ca:b0:485:3d43:7c9a with SMTP id 5b1f17b1804b1-4853d437d40mr18612225e9.25.1773043894112;
        Mon, 09 Mar 2026 01:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/6] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Mon,  9 Mar 2026 08:11:24 +0000
Message-ID: <20260309081129.154109-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22160

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 1766de15a571662fcd9c0a870de3a06890142a1e ]

The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
Classical CAN frame format is disabled. Document renesas,fd-only to handle
this mode. As these SoCs support 3 modes, update the description of
renesas,no-can-fd property and disallow it for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20251126155911.320563-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 46215e0b0930..3be1bff284a3 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -123,9 +123,17 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN FD only mode (default) or
-      Classical CAN only mode.  The mode is global to all channels.
-      Specify this property to put the controller in Classical CAN only mode.
+      The controller can operate in either CAN-FD mode (default) or FD-Only
+      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
+      property to put the controller in Classical CAN mode.
+
+  renesas,fd-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
+      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
+      communication in Classical CAN frame format is disabled. Specify this
+      property to put the controller in FD-Only mode.
 
   assigned-clocks:
     description:
@@ -257,6 +265,30 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,no-can-fd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,fd-only
+    then:
+      properties:
+        renesas,no-can-fd: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


