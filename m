Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23080.1792676427354872779
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 06:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OHTIV2bR;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-487049569b6so1291723f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676425; x=1793281225; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0MQXbBR3ERCrFs2O7t73QVVe9vHQgXixWu/8VUEvRc=;
        b=OHTIV2bRa+dt4CSMpCbvmFh5djk3ktkqhl4cEeGe1fnoQ+bQ5vJKxCdOL7OE1Lo3+l
         t7GC20720zF7Xh4JtD6yS2pQrmsNMkXAhkFeFgqVRl4AOSDsXN+m6B0SBnGyfbWZuVJV
         5tCxkXrl2TSvYCujXZ2+3rNByix5YC23pU23Nrr3/tdIa/NoY3IW9g3tPU0yTRr39bkd
         tBHyU7hu6rjNIvvdZrqx45V7FCtw6IFR72eq10lf114gpYcmmjYTTVsJbRkueWAcb1bh
         wrnd9w358QCn2B1Y4xEH949D1YKvMqwQZdPcruOUDo3bKL1rljbWGmYgEg5PvkWpXqoL
         Tx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676425; x=1793281225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0MQXbBR3ERCrFs2O7t73QVVe9vHQgXixWu/8VUEvRc=;
        b=ESLlpLTtqLrYOZG8OVmmpNANzfSGCqLLk7tTVxyoG3W60MVlz2SH+XSlk9NPG86fEA
         /O7bg5LBIUw8XfXP/kdFJQXpSJYdJuenXG1cXbnRDNOA+nDsyET4ZXcd+dLLFk4wR5Oe
         0PjnaNO4/Ei2UyXd5RX45QobOD9XBylxbFwA6AElLUeMHZKLOktMz+fO/CzCozdr50e5
         EfV4W9JSx3fad5IKHCJMb/VTIfx98MqsPVuBX9TgIASvwipclKDP8LHNE6a06OZtNMbQ
         RgeS2XxBufhnbn1e6MT6wgh5VI0Ah8C4V/jfHB4BuCj4Kxrqm5EJRttSUrz3cfZ9M3jL
         Jvog==
X-Gm-Message-State: AFq9FYKV6mQQZIaRPEki9QVCzD2dAcaw37crVID76oJxn6dPtj2FTvHw
	tgarEUJaTX7z1/qrs3qqlCpdcQgEwruNuABzgMd+kDYqH3/YOa3Sx3Kcjo8K4Q==
X-Gm-Gg: AYBFou0+RlDC31Chx287GjTEATBnhO1gfonKlLpzrLH+MYY9W8Yz4vhrkg3UjFPJLUj
	rbGfhOuq54udLNT8NTWcz55yErASg3q373QQSbd4NYDcyuPO6Y6kS4BSZU6iY/P3Leq62ded4D0
	jbZCXMmc2Ad7SRcl5KqtdWW9jzakLmalm24Jvn8Vk/KBm/UsG0s/Kjq1deQhEPJc5yGB5OX5sDB
	X0+UsunTjLLJ3wi/aPoaPxfKGDP8ETy3fAUUg6eE2bmsYiWCs+U+Lm0X1aUT99/ZIjNaqV0iWAQ
	XBFOmPkscI074qs7ja5kQZZq09TYSUPMaWX59Giy6CRwQmzADuWBtu7hhQlDiHwp+MdjbgpciYY
	DhlyANlvIXGkWbnZBhUzRbBbk2+BXJy37f60Arzhzhj1tbOUaTgvMr2k89/kYd+WDVHpZi1lF/G
	01pJZJ+bkBMbsql/IyD29MPPfPOsUrZ6XlcAEHqt1npEZMpr3u/lwBgYcHc0YXqqlprOyVMUFRd
	LwMlln4kJMOnO4FqpcAKr0U8EH/IfaNc7Pbskmc5Aw/Yxc6Ntm3d+O9JCp+nO0pqdqP9d51wI1a
	O94fANYjvnZTbsaUMyXzT0ytIEZBsnS5uRqBnv+P+Ob5NPj4WD4=
X-Received: by 2002:a05:600c:5391:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4a1fdd23e21mr111721595e9.19.1792676425143;
        Thu, 22 Oct 2026 06:40:25 -0700 (PDT)
Return-Path: <biju.das.au@gmail.com>
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3c4e:ba43:9a8e:7e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm82888415e9.2.2026.10.22.06.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:40:24 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/5] dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
Date: Thu, 22 Oct 2026 14:40:10 +0100
Message-ID: <20261022134021.217964-2-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134021.217964-1-biju.das.au@gmail.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 13:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24510
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6672462c97ed29f1cf04317663ae0bffff261c3b ]

Document the serial communication interface (RSCI) used on the Renesas
RZ/G3L (R9A08G046) SoC. This SoC integrates the same RSCI IP block as
the RZ/G3E (R9A09G047), but it has 3 clocks compared to 6 clocks on
the RZ/G3E SoC. The RZ/G3L has a single TCLK with internal dividers,
whereas the RZ/G3E has explicit clocks for TCLK and its dividers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260312082708.98835-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 1f8cee8171de3..9e2460f546824 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a08g046-rsci # RZ/G3L
           - renesas,r9a09g047-rsci # RZ/G3E
           - renesas,r9a09g077-rsci # RZ/T2H
 
@@ -139,6 +140,31 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-rsci
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

