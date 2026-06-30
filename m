Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D0C44500
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:46 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19420.1782820125784302456
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CkMbADC2;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-461edb387ddso4283642f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820124; x=1783424924; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1Byp9fwbUIDgP5OT9snTVMx07SY3tSX4rRSnBtZ1A0=;
        b=CkMbADC2SL2qiR3S3gZuzSIgkOvWpNelY1TAYDHkJAKzg4oj3xJ6CkdEoqyac/Mgy8
         2H7uTYYmSUkbWiG8cTVNIjCZuHqsDP8pXiRf6t/QvHK/PBoPlypkFhpXHNmfgKm+v8y1
         klXlul+02RwDEPgR0Ph9cvrakD3KaI0SJr3pjFMduMQ29hs39brTD4NADu35ftI1YdP2
         qjJ9okqDvXH8wbq4puhYWfiwIkFj0+uan4xk/qQRLqavgye8kWHcWkCNyBQ636KZFeDT
         5Vi57Gt9GTh/hq6M6wJKk2Be3xx+BaFuwPY2qRoD/U3RAcNbTC5O/nnfbd7Xx2w5qmNX
         SSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820124; x=1783424924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1Byp9fwbUIDgP5OT9snTVMx07SY3tSX4rRSnBtZ1A0=;
        b=kySi/S39sOCPtbuEpNX2/Mws4JDnGzsz2yP3eaT5WtHIo2MCuNT+BwG7pmiZinJbgn
         s4TyH/YUNsnloQ4tVBFbrgKUFp54ZaH8zqRcVERYOjAjpvRSSD4Hl6x2VLgxCzEIHUSE
         CtOk7XgA5RxwyVe7vbJOOpexVexMvakGQ7YZr+/VEgtbq+LGsi4tmYHuAjXFFKV+fcYd
         /803Cyh7fAFQKSX6gOvOvo6tFftnkYEO1CX7v3avYaQDGtkLouNV6xUVnYFWAr52V2xd
         BOTVygvv2QRBbOf9y2g7kj2uCoeX0HdagxSYxaa+EAbdm8lwCqptvsu/eMsCM4rwDHaQ
         48rQ==
X-Gm-Message-State: AOJu0YxlrDqF08Vo+CMdSdlnGppLEbXA/pot+O0p/ThRxf6W5BCMKYyg
	tSqQql5CmmjT1Nk42DElkBv7S+RACGLx5RR2Fpm3K7HJvfZyNCjAgLpURbCqIvGH
X-Gm-Gg: AfdE7ckBC6LgYYBD0mE53jOgnulIm6sO0qsB0UZoCOz5qzLIU9f8aDTsWcqZWqtnpEc
	5Awqg5l0I7xavXPDFHmaV7/+Ml4Avhi2FtTL1YKb0w1NqUak3WKR0NbUQ3qW5Njgm7IY2tCui1n
	kiWR+hQMknkVCbSox1ZNmPQnZ8QHeivG3LCFRWY/tghEEWmFDDxvnFtx34+Bf0TZF2zjuJaNuj5
	krTwICTTRcIdUuFG611I1a3n9KyJHmA8F+CYKLlbBhMBM900EBvj24aYoD9utBtsQ5kB5UfPjz+
	6PNPefZ/ep4LSqE7UC7yd2FtrrOlMYDAyKAazYXcWWrMsjwXkncd8ca8D3wpjroGvH78E4sz1mk
	9zMjzuD88gnlwNPkilGBp8QSRwnDTy53idDwQuuDernunUcGThn17skSuq8J79+CbKA6MsqLoAX
	GgL+TzZbgTtzXBhJT6/w1fzwUbWeSLAJVeuJk1UA==
X-Received: by 2002:adf:e542:0:b0:473:673e:3836 with SMTP id ffacd0b85a97d-475524a8898mr3712571f8f.28.1782820124007;
        Tue, 30 Jun 2026 04:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/39] dt-bindings: soc: renesas: Document RZ/G3L SoC variants, SMARC SoM and Carrier-II EVK
Date: Tue, 30 Jun 2026 12:47:26 +0100
Message-ID: <20260630114813.92739-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23331

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 56c828dff9ff5e787e74d901e8b530a36b8941da ]

Document Renesas RZ/G3L (R9A08G046) SoC variants and the Renesas RZ/G3L
SMARC Carrier-II EVK board which is based on the Renesas RZ/G3L SMARC SoM.
The RZ/G3L SMARC Carrier-II EVK consists of an RZ/G3L SoM module and a
SMARC Carrier-II carrier board.  The SoM module sits on top of the carrier
board.

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260203103031.247435-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 2006c6975b30..b0ac451abf6c 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -519,6 +519,19 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ/G3L (R9A08G046)
+        items:
+          - enum:
+              - renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - enum:
+              - renesas,rzg3l-smarcm # RZ/G3L SMARC Module (SoM)
+          - enum:
+              - renesas,r9a08g046l26 # Dual Cortex-A55 + Cortex-M33 + GE3D/VCP (14mm LFBGA)
+              - renesas,r9a08g046l28 # Dual Cortex-A55 + Cortex-M33 + GE3D/VCP (17mm LFBGA)
+              - renesas,r9a08g046l46 # Quad Cortex-A55 + Cortex-M33 + GE3D/VCP (14mm LFBGA)
+              - renesas,r9a08g046l48 # Quad Cortex-A55 + Cortex-M33 + GE3D/VCP (17mm LFBGA)
+          - const: renesas,r9a08g046
+
       - description: RZ/V2M (R9A09G011)
         items:
           - enum:
-- 
2.43.0


