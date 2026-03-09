Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E610EF3714
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:43 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9257.1773043897253487692
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ozsibp15;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso16029265e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043895; x=1773648695; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W76wgDrfPpQ2sy9m8fT18S+bkJTZIKN2LE6XEmhI+ag=;
        b=Ozsibp15nkKbhYfIVMC57jxI/3hEQk52wl7EUgj+VQOA6CZaU2q74X99Kbzzp17IYI
         VgwOucKc5lJoT0jYhyhA/fBdweKpTSo0bKfTTZGUMPT7EsfiLblcHnzs7RoB3ey4tDGz
         tK4Vo0sHYuqeZJxMceHKEf2MUcx4twQAErUcRE4mkCSbtn1RkNrrDZhxBEvb0ca3vz7N
         HPr/OplvVCtgUNeBWUd+zEaUvxkJowHfzVfUUsupZVf0sq4cPTdoKxrxKYCFiLEx88cJ
         W+ybaD/hfJgz5Q8+QJTkMPCz9sg4/nzjugleCrn9JPWeG7qAb0K1emdWsNi424mS/lS9
         SV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043895; x=1773648695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W76wgDrfPpQ2sy9m8fT18S+bkJTZIKN2LE6XEmhI+ag=;
        b=lPkkmRbJeeHjrmvb1Vy529f5xkcOsm/fZA2M1FY7bftLoxxViz8avWiXzsPd65s3+x
         hmHVt6fvwT1R1Jc0O7hMCMUM8OLhTlsU9IjulJ1Qys9JyVbTmIFeWVOUn2Mm2nA4ksGM
         GgHDyiEP3/2DZ9bcvjW5TP5ckr9JfeHHUoKeFw5WxixXSYeYoFWoOUDgH5fBaUpJbM95
         P032N22MgcDLrzIczgB4h4MtoacPG/SQDwyFHtbTtMC/8sjHa+PQE0TxZGgpEJE8IX7J
         pSoNOEJAZKWTVulzsT0z3v6lQZzHP8Kfu9DLrXgAZlFGDihLISRx+rYhi1mXH1KcgDXy
         z9tQ==
X-Gm-Message-State: AOJu0YwSo3AgYFvnnVQH3RgIsx04VHbIDZYfdjd4P+QPEkUQIEV+vD+t
	s9KyqL9VHKfkQEwTF2i63rMVWfjovfkN/Iqr3rb1ecBMz67myBxFlN3yYeXuUw==
X-Gm-Gg: ATEYQzzFZaljk5gkc8BvV1J9efK+SA0rsKazWBNdewj8c+vod6s0nI+b5QrWrbEzAhF
	zdkrGg5l5mXbFRPkbo+oiB/2nYJMt30sV3KtpSsne/0IgtDeuhRoZKnJGU9h5K6ufMhH8RDhvMx
	YV4bxj0T7K1KVfdq+9f4783yU6oEmnxTQmDZKdhzCIuPQ0fpPt+XLXHdSueCEkeqd5GRBTdeFYB
	Ni7EtN6ROxvgDYPbdKAq34baUTBcGOlEBFxjuoaGZHX2uTNTJnVcA3MJN0zeLkBlzu4ec4p1M7f
	zi6VkewNXx54oYCHrBzkMQdBRNE1UPUyhMByQcU+LAQAXfv0u8HXcQUhphVLh2z9lVX6+EUUGWv
	X84Wyhc14iiKNBd46esKmwsRzaA63/F/orAyQhbKwmq4tNdPkUYA84OhLqDmUiPVnsgKfdlvHfm
	dm6hnWeJTkYfQ4US2m6GVfLHFyEVmJWbqSgrGLohw8qfvLDOnsaagmGk+UUZg=
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-4853dfc073cmr16345815e9.21.1773043894962;
        Mon, 09 Mar 2026 01:11:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 5/6] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
Date: Mon,  9 Mar 2026 08:11:25 +0000
Message-ID: <20260309081129.154109-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22159

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
index 3be1bff284a3..70bd639bebc1 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -120,6 +120,11 @@ properties:
 
   resets: true
 
+  reset-names:
+    items:
+      - const: rstp_n
+      - const: rstc_n
+
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -193,13 +198,6 @@ allOf:
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
@@ -237,13 +235,6 @@ allOf:
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
@@ -289,6 +280,20 @@ allOf:
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


