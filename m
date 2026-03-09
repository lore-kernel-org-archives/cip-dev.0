Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02386EF36FE
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:21 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9057.1773042679639003944
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hmoRYO0W;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439af7d77f0so7179655f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042677; x=1773647477; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2zKA+empTk4Nj4qgWLwVFLD7KZtHj7ZadIkI/zk3Z8=;
        b=hmoRYO0WyrVw7e8AdAPNfJx0D8qqMDr81XIQspR8osobRQy4lOqOtu7bG5kJSlaNpF
         5iVUdulhUwvsLHLMCpCdofPhV/XYPAg5RbEpDyed2k0mEzN8KpvMkkJhnCARMVPDNkVa
         q3jIzl+sotlxw185aVFaa5wrBfWn+2KXv7z2nXmodBnzv8wwteaOp41BdyJe5+1VDyku
         RLtHQ0p3GUmVtB5q/mGxMAOYvFsC3ilptPLg2OSIvIhRBc82hSArZUxiK+/BMSiEzp2f
         XkspxKYp2WFvX/Y6ycY3LIvXkTERRl87jiP28JhGVfKVg8KJKzs3heqxipeybMEp2/0J
         H7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042677; x=1773647477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2zKA+empTk4Nj4qgWLwVFLD7KZtHj7ZadIkI/zk3Z8=;
        b=tQhu+K6YfTsOrIaTFA7PwbV170JLqgobvJ0mnqzuu91bS+5kXCSU9+cYAW3uRqtmeM
         VBwht4Mycevak3WYCK0ANtT3/7uYQOMjMqv5awX7OdQdYVSowRcWILnQpLDV7sTWZ/WR
         U8I1vXoNLfkhDj/myGZlajrnGh8j64nze/K/edaCNbF2nY/mXLjdRjz2xFH9jL+YMt3G
         YwlR2op4NDz79PAqvZtg7k7lkfvTb//xevrUE1rpoCofqbDbXvLEP0ekMSZDoRTesEFI
         0s0Nflj9DAVN/vA4JTuy7i0tpHkYk6X0BAHdRRHcaBmT8glFFC95I9n9pR+MKeLL7uoX
         kDAA==
X-Gm-Message-State: AOJu0YzMAGcMHwwbzF94C4qmBZZcaG7H8etUM/RUC/sESL9vjLH5i+PR
	HTwTrXwwzEMd6+KfUwaluQuRFDqj4ZqSLS9/tY5VJLZ450fxZ1kWZ8+bsxKbOw==
X-Gm-Gg: ATEYQzx87jfz8ZYdXM21+ITClaC9lDs5tm9VUHc4efJvcYLUq11aLyBlliokexWqAPF
	RgqA3W2p1GvgSS4BRrNXcT0rdihaxT7IM1LQZFFuZftqcJfHqF6QFZ4t33K8qv2d6eEkgDaIIkH
	LYp2EeYOAq6d6N7ABexvbqeYEiBJdvIeJ9DAGRq3YrNKZ5slqsnVi7X5y1W+xVQSixNXWfJazGX
	qevlFAGLa9fXvBHVUFY8box0Tj7WhVmCyjFZhomjM4hJMq2vBHMuLd6JLfGcHzP/+Jw+cZWG7SV
	v/maCRYbj85H32a6XKhWYIAG1zBcSpMQi6SF2xHSVwc0BOctQhtkM3m+8wGRO68lUgO++4qGDnS
	PGO9O7BOANU94REd50HOmCumQbe3W+jF81S0O0qeVzaCoprRxJoMZLmUSZ8QvtFLXWuf+6ZrXXZ
	UwN4TuGchHTcnaWMgfXqAWgysrPrvculuFNlU1B3Ba6UhtKIvn
X-Received: by 2002:a05:6000:22c4:b0:439:a897:6515 with SMTP id ffacd0b85a97d-439da67c000mr17526498f8f.36.1773042677383;
        Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/6] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Mon,  9 Mar 2026 07:51:06 +0000
Message-ID: <20260309075112.35445-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22152

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
index f4ac21c68427..e129bdceef84 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -125,9 +125,17 @@ properties:
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
@@ -267,6 +275,30 @@ allOf:
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


