Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7045C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89144.1783073289801339088
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=P5q5W0bx;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493be1b9682so3080485e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073288; x=1783678088; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq0RMJE68cu/fnuX/CxJuamnn8fJSeuVm84GJ/jP7wA=;
        b=P5q5W0bxsFQMc1rL4HbPL1XotVZJW/SIIDwMc/oa+6d9bBR2VJUKVPHaHhnfRl5Y1f
         0g2Ytv6bvCKjkr1rr8Yr4HD9XEwEVGLSnCmb0hTguSJqU5bOYom22qE+i7foGGfegyXL
         LKVbTDmHcDjdufSNoqB8VglZA1l28nD/cQRmR1oau1gV9sFXURIon6MF2zmYEstU3RTX
         8oqWhZNYFJfwd50jvqgR2JrHd3UBmEKrKe9V+h7nyz62tIUCfVBIy4TWbbIrQOp7Kaw0
         SiqUCs/Q+OmeqYNZkANB/0gIfb5sBjVoHpuDRkGk/bKqgHpG2B6X1xYHfWS6Ers3D4Mi
         2lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073288; x=1783678088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mq0RMJE68cu/fnuX/CxJuamnn8fJSeuVm84GJ/jP7wA=;
        b=PXlnRsmL5fp91GXQxmwFVcKLDA5/ZPhdZDqCyAHE+w3fjXjzDKuNfy6LNO8MLQHeZR
         ZcGUWBP0qCyanJ0lajhjR+syjpIRNPZGcBgYHeoigZcza5pK9qQ0dPZ3fQ2kdgA6+Ede
         Fl19EqEdipw+3QVtDV/hxn+Lzos0inxo8DgvEcv4ytTVt8Ae+qXP62wNOkBmotiUs6rR
         gfdAK/gxTQ62ULwNqd4uWqhZMCafox//v/Iaboj0yERWxQKFtvnkTGFFfhlSr6wJbYrB
         12VWwXIiZXFXnc6PxwG0tmAqSdXy6U33vX/nkAv39pWWj0vICGFcPtDMrKWLtixfx2LP
         IuYA==
X-Gm-Message-State: AOJu0YzyEhdJNJSBKfk0fTkLa/IRz02+SgXGhuFRxKoKmRuRddBXKvgT
	lZa4tUF/kRcLKJlLw/vZgWrlU2WLbSlw9MIgtBnNLWs3cuBHjy2HKjj7Dd8dgy6D
X-Gm-Gg: AfdE7cnBz65LkJqUNgwLUfFu4BWoKw5TOKI7nYra7jsdQGGyRYVgqc1oIY5W/5wNhrz
	MxoYWbn2TZ5bskQRH9zuOdW8UfLY5cJyAlGZMzOi5/X3WB2xFYCHi5YbBl8RMqVnzNuWU7RVndi
	to3iiQCU/pU3jYIhec1HsyLR9+99go/I+M6so8FwSWS8Ltxz8ITkxJozF1LRXi7/c29VXPyBM9Y
	5T5lMkGgGOOrXSnZdKotqhgO0A/eSLcaBwUhn5ShTCNLwCKLSu5mC66lBxlxClObBg/ZOF8tJzk
	gJgeAPy7V7Udr10mt6slw4MilckKzmkLk4IuGmxj38hoa+N7SngH/E246PvihgJojb92T+qjy8B
	Cy6PR7Wt3Ddy9+gPP0S42hqq0x42/c5feYYmSxD3gPiprZ4aEFYxm1v7q6lXXsGgvkU8geZjFhI
	ao9SuK+VA4SwS4yMi5ZcCJ
X-Received: by 2002:a05:600d:8649:20b0:493:a607:f3b8 with SMTP id 5b1f17b1804b1-493c2ac7199mr105369665e9.0.1783073287776;
        Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/26] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Use pattern for interrupt-names
Date: Fri,  3 Jul 2026 11:07:39 +0100
Message-ID: <20260703100756.238233-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23412

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 7b7d32d93e9879480ec6f00b9310b2d64c2161db ]

Simplify the bindings by using pattern property for interrupt-names.
It also allows to change the ordering of interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 120 ++++--------------
 1 file changed, 23 insertions(+), 97 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 44b6ae5fc802..a0b57d808639 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -48,107 +48,33 @@ properties:
 
   interrupts:
     minItems: 45
-    items:
-      - description: NMI interrupt
-      - description: IRQ0 interrupt
-      - description: IRQ1 interrupt
-      - description: IRQ2 interrupt
-      - description: IRQ3 interrupt
-      - description: IRQ4 interrupt
-      - description: IRQ5 interrupt
-      - description: IRQ6 interrupt
-      - description: IRQ7 interrupt
-      - description: GPIO interrupt, TINT0
-      - description: GPIO interrupt, TINT1
-      - description: GPIO interrupt, TINT2
-      - description: GPIO interrupt, TINT3
-      - description: GPIO interrupt, TINT4
-      - description: GPIO interrupt, TINT5
-      - description: GPIO interrupt, TINT6
-      - description: GPIO interrupt, TINT7
-      - description: GPIO interrupt, TINT8
-      - description: GPIO interrupt, TINT9
-      - description: GPIO interrupt, TINT10
-      - description: GPIO interrupt, TINT11
-      - description: GPIO interrupt, TINT12
-      - description: GPIO interrupt, TINT13
-      - description: GPIO interrupt, TINT14
-      - description: GPIO interrupt, TINT15
-      - description: GPIO interrupt, TINT16
-      - description: GPIO interrupt, TINT17
-      - description: GPIO interrupt, TINT18
-      - description: GPIO interrupt, TINT19
-      - description: GPIO interrupt, TINT20
-      - description: GPIO interrupt, TINT21
-      - description: GPIO interrupt, TINT22
-      - description: GPIO interrupt, TINT23
-      - description: GPIO interrupt, TINT24
-      - description: GPIO interrupt, TINT25
-      - description: GPIO interrupt, TINT26
-      - description: GPIO interrupt, TINT27
-      - description: GPIO interrupt, TINT28
-      - description: GPIO interrupt, TINT29
-      - description: GPIO interrupt, TINT30
-      - description: GPIO interrupt, TINT31
-      - description: Bus error interrupt
-      - description: ECCRAM0 or combined ECCRAM0/1 1bit error interrupt
-      - description: ECCRAM0 or combined ECCRAM0/1 2bit error interrupt
-      - description: ECCRAM0 or combined ECCRAM0/1 error overflow interrupt
-      - description: ECCRAM1 1bit error interrupt
-      - description: ECCRAM1 2bit error interrupt
-      - description: ECCRAM1 error overflow interrupt
+    maxItems: 48
 
   interrupt-names:
     minItems: 45
+    maxItems: 48
     items:
-      - const: nmi
-      - const: irq0
-      - const: irq1
-      - const: irq2
-      - const: irq3
-      - const: irq4
-      - const: irq5
-      - const: irq6
-      - const: irq7
-      - const: tint0
-      - const: tint1
-      - const: tint2
-      - const: tint3
-      - const: tint4
-      - const: tint5
-      - const: tint6
-      - const: tint7
-      - const: tint8
-      - const: tint9
-      - const: tint10
-      - const: tint11
-      - const: tint12
-      - const: tint13
-      - const: tint14
-      - const: tint15
-      - const: tint16
-      - const: tint17
-      - const: tint18
-      - const: tint19
-      - const: tint20
-      - const: tint21
-      - const: tint22
-      - const: tint23
-      - const: tint24
-      - const: tint25
-      - const: tint26
-      - const: tint27
-      - const: tint28
-      - const: tint29
-      - const: tint30
-      - const: tint31
-      - const: bus-err
-      - const: ec7tie1-0
-      - const: ec7tie2-0
-      - const: ec7tiovf-0
-      - const: ec7tie1-1
-      - const: ec7tie2-1
-      - const: ec7tiovf-1
+      oneOf:
+        - description: NMI interrupt
+          const: nmi
+        - description: External IRQ interrupt
+          pattern: '^irq([0-7])$'
+        - description: GPIO interrupt
+          pattern: '^tint([0-9]|1[0-9]|2[0-9]|3[0-1])$'
+        - description: Bus error interrupt
+          const: bus-err
+        - description: ECCRAM0 or combined ECCRAM0/1 1bit error interrupt
+          const: ec7tie1-0
+        - description: ECCRAM0 or combined ECCRAM0/1 2bit error interrupt
+          const: ec7tie2-0
+        - description: ECCRAM0 or combined ECCRAM0/1 error overflow interrupt
+          const: ec7tiovf-0
+        - description: ECCRAM1 1bit error interrupt
+          const: ec7tie1-1
+        - description: ECCRAM1 2bit error interrupt
+          const: ec7tie2-1
+        - description: ECCRAM1 error overflow interrupt
+          const: ec7tiovf-1
 
   clocks:
     maxItems: 2
-- 
2.43.0


