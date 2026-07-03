Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F30C43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:28 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90771.1783076366651340890
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IHlO8IUi;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so290498f8f.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076365; x=1783681165; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvIQ0bJeP3eaGkaVDOleaYQWyss5TTQPEzCSYngB5dc=;
        b=IHlO8IUipy0g97i7AT8SHurCC6KRUmpBKVmFRANnnygLHmR7HsZ1vKQ+3shiEc+1Lg
         nhl5zEEW2/pZ59gimeorOk4SLT3TuczDGpO+WBEQYQ3WFj8Og2bh40h0g3gHfx4uvVZ7
         rGYGXH5b6tXRsHjFM2cn7/EKa2Zj857R+yWhjgSi24Li2y/PwabqVGM+4mliAneQb876
         vFN/jvicxbF6UedfM3eNzvFL1zBbW64pjJmK2hODH4xIQpMpdimyd8/kuVWTOnc3t7As
         hgZLoSEpW6lobpMbEPU69BBQ4Br0orl0SO08B1EG84NAZXYR4Nb75UFCR4Phfzqh1yw9
         Wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076365; x=1783681165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvIQ0bJeP3eaGkaVDOleaYQWyss5TTQPEzCSYngB5dc=;
        b=Qara5hZSy7dN9U4h/1V+2r9HN8jO3U8IfLSOVCSttwWlx5eBvve4CqSkX94vsPO8ia
         gpZWpzWrhW5A///9Wqz16D1CcYsimK2Hti8Rd6yRu6FdjhGDDWZjCvcMnPacLR6sJ/Zs
         kBDhQFtmyRnuxvCRNP2k9lGT17towYgt6UkZGwe8Q/3SGnWOh/ARTlp0Yv7Z916G1BOZ
         KiOM4vpXJu8uYCS96ftpQEJo/wnZfgHQp12377g9P8PHKb609GMPVazGbCMwP+LxPVEJ
         aB53Hb4wjzsIDDlJfMqFr/VzaM9UtIMbH7eqpBuDV3oVQzSEOnHR5ZHfejIBOnq1dhFK
         krhA==
X-Gm-Message-State: AOJu0YzSy4f2cx+OMFb7SqALXA5DM4x+Cto9nYrss53uyyHasI+W8kbI
	/llLys4q/zLZFMrh1evP4D3Br/9U1Kdb+9yGWhIFcrvlZKl/sCHpb2amboWJPPMu
X-Gm-Gg: AfdE7clPO3u6TGRYPlY466w7Qt16hHZN+kkzzGjVi0CjX+mvNPGas8+FDMAhPEX1uGY
	joNq4UoOWwWHmoYFpkUHNl60YkblHQk7VCqgHXcqo1RDregqdPnM96L1CPjC4yCREmxxcYEIGhB
	V7soUZd4CYKn5liEmZC4t/aieY414saKkufLrGrYF3oW+mgmyotbwBgDGawHekKR34+LH0cSh8G
	r1X7DhQ2qMbBpVwyYKXEi/XlB88xaPTLFuaCNjwzCk/fZ6IOS8JDYQ+8Zwa9QIXrdUP01QChk6U
	sFmcTvYhRw4HUMdMvT33Ar4+OhtXM02lh97xNhqLWWJOso2VWmse6qkRzGhNL7+0iLcGqBYfQft
	mRD1HIH9heERMquPkagnVo6UK3AQVctXm46DbKqk1wNxHe2RmO+nBh1C0IsjVVjLOjCdWjDB1o9
	+LZTITWSQ0xJI0n7jPe2PG
X-Received: by 2002:a5d:5f42:0:b0:46b:cab9:f697 with SMTP id ffacd0b85a97d-47758bca818mr12844667f8f.24.1783076364777;
        Fri, 03 Jul 2026 03:59:24 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:24 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/23] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document reset-names
Date: Fri,  3 Jul 2026 11:58:52 +0100
Message-ID: <20260703105923.251255-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23420

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9c45ef9a84bd18cbd2052d5e64b2144018f5bb32 ]

All SoCs have multiple resets.  Document the reset-names property.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260317101627.174491-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 0cd00eb436dc..b6d39aea86dc 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -78,6 +78,16 @@ properties:
           - description: PFC main reset
           - description: Reset for the control register related to WDTUDFCA and WDTUDFFCM pins
 
+  reset-names:
+    oneOf:
+      - items:
+          - const: rstn
+          - const: port
+          - const: spare
+      - items:
+          - const: main
+          - const: error
+
 additionalProperties:
   anyOf:
     - type: object
@@ -166,10 +176,14 @@ allOf:
       properties:
         resets:
           maxItems: 2
+        reset-names:
+          maxItems: 2
     else:
       properties:
         resets:
           minItems: 3
+        reset-names:
+          minItems: 3
 
 required:
   - compatible
@@ -201,6 +215,7 @@ examples:
             resets = <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
                      <&cpg R9A07G044_GPIO_SPARE_RESETN>;
+            reset-names = "rstn", "port", "spare";
             power-domains = <&cpg>;
 
             scif0_pins: serial0 {
-- 
2.43.0


