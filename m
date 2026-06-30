Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04389C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:46 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19418.1782820120184865121
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gvLDJ6XR;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so1776037f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820118; x=1783424918; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txViDiXYaPuHlvCo/dN8tdcPwgb2KhhgnQ6sDXX1/50=;
        b=gvLDJ6XRMCHPtKpi1EJeJSMP+rGZB3uNRsR9snMo2yVrOTjhD6aXBsOgiTsKD7f7qr
         AHKgsqLi6CYoEiGcQTdJuuCRsVyJWk0uIsZv8Z4oTzw4qJ2j3huyVNrB3CFqUBr9D8Nu
         VeyesSaYT8JgDbBrUJEEsyEBz1kYan/scBojloHqfbsc8mzhOB+2w6uYxmUIjKq7Edfg
         LSZCBZVBG9Rf373I/8WPYcmBnf8EmdM2lCUknHk/Zr1WxwH5S8SUnO8DLnNqbskDDIO1
         LbhHPpjaoUnEP+XzbRXQkPSHCAmbCt52u/4t4A6GU6xPbH4J04SRkTsHgqWUH2MmiAGg
         EOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820118; x=1783424918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txViDiXYaPuHlvCo/dN8tdcPwgb2KhhgnQ6sDXX1/50=;
        b=TBBu4ABYQt8YuTRl5u6fJFz4+/nkqhNzvAyJvwc9UnscxRcTW8etxOAnSNBgG3HPK9
         voOd8i9AsjNVBShkvVVjBz+FsWZ4iRkZLpjAud89wkqh46gx+E1AGfSPwe506FLYvknw
         UnG/wL3YB5/rugcRkC+wtNe3WkYS2ssjgBPbw4+XKfYjuv8uhuj/lsyo99XDA9EdKSU+
         +Od20Dd2S3K+lIHqvveAca3oqBoT1T/eJWRcreL6WQ5KB8D0XNqC1TpKjoXjdac0ei+7
         lv6/MlndiaFnVZ4FWajdXltz4rH81pigoNvFM/tY8O7yEfl0pca5ZAAOOWrMG8vKLOux
         eP4w==
X-Gm-Message-State: AOJu0YxMQ7LGHH3alNbdXiqiHg+3IjzwrkNkKCodbXF4aNfxNqXSWqJH
	8/Hi6eH6tq/VbZAa2ZKOGSgdOFWgDBKGHyds0mbhfLBG95mQtiOWEdG1wrcv1hyq
X-Gm-Gg: AfdE7cl8Cicmt04GWebVOFbWxtgqHuBpOQDLiXL2fiByoCKDObNwMYFXKbi8OUtc4iz
	d4eh9QrwLVCaFzBqHzI9oh/M9uzu0kgoTZrX8nfk11642ex94O35N93+WGHxvzSSdYddt5zAdaW
	KN1zplUz2j/PcQFCsAuIUOPBNcFFjwZ3MS5tPzCT23DM38Tca0kKj6DFQTZGL/vGP83lgJuvgsW
	BGH/qc+P3GajWyty+MglK3fW0UkCtobA/V39eXXeS0i+ceISWtNnm8gyDkquN9h5LUGs3P3N3XM
	9yo3vfmn7c5N8UoyuOFXby6bIRrx45kTGF9svijTgVgllP/n4joJNdSPe1vr5rrsWzEJoTXsY/1
	GaUzydgeCUUR5Fsp/LH7mZyRrSEo2Ub2KSvkkL4ILo1FLAeU2u9R1t808ajuXa46U7eRpBwdk/s
	da3E11tbQE+ANiAgdrOnXAkBKDi0TZseETsoMYSg==
X-Received: by 2002:a05:6000:2884:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-475530280ccmr4567819f8f.28.1782820118205;
        Tue, 30 Jun 2026 04:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/39] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx,rx} clocks
Date: Tue, 30 Jun 2026 12:47:22 +0100
Message-ID: <20260630114813.92739-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23327

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d2adcbdae5f6d4da445f32ea61f21fdd146670d9 ]

As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
to control the RMII{tx, rx} clocks. Document the rmii{tx.rx} clocks for
RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260203104541.264759-1-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Biju: Squashed commit 114508a89ddc12b50497c03747aa3c44195ca830 after
 removing the Sophgo SG2044 documentation as it is not present on 6.12.y]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/net/renesas,rzv2h-gbeth.yaml      | 8 ++++++--
 Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index fb60f745a1ff..2125b5ddf73d 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -58,6 +58,8 @@ properties:
           - description: TX clock phase-shifted by 180 degrees
           - description: RX clock phase-shifted by 180 degrees
           - description: RMII clock
+          - description: RMII TX clock
+          - description: RMII RX clock
 
         minItems: 7
 
@@ -77,6 +79,8 @@ properties:
           - const: tx-180
           - const: rx-180
           - const: rmii
+          - const: rmii_tx
+          - const: rmii_rx
 
         minItems: 7
 
@@ -170,10 +174,10 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 8
+          minItems: 10
 
         clock-names:
-          minItems: 8
+          minItems: 10
 
         interrupts:
           minItems: 15
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4ae68ab70dee..0deb5d43f8cc 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -31,6 +31,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -98,6 +99,7 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
@@ -638,6 +640,7 @@ allOf:
                 - snps,dwmac-4.20a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
+                - snps,dwmac-5.30a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
-- 
2.43.0


