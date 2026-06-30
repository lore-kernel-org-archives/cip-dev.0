Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B13C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:36 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19064.1782820108782283564
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KE8NN2OA;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-472493849a3so2487685f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820107; x=1783424907; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asy+krBxEjHu+kbwmloqJts1t5EkLXcM+GPd0epvWoc=;
        b=KE8NN2OAjxbuptvNUU8pIfNsP/CrCGZkS7LJHIbyL2NEhPurvnks2WX7mI60uLsDx+
         Gi+Droaaa1kz+jiLeFlQkDzaLh15s6Vw13NXIsVdfcCQO6fn4QZKGddlWo7xqBy6JHE4
         NWG4gedddQCVu78+JG2mEEqkJhAF8I64Jt8XJVUyENm4f9JjsnBz4ON23LQjsGvuqqSu
         yCHMK4kdQnIGfpG1Z3Ie1UhGxxcpv2Jr3ToUGfPh8RoLKk1Zoi3D68u9c7JmXwuH81ft
         CEAxvoMeUBft2OHsNrGZIetJs3qB/hYHs35LqAfMEyZVAmMKkV4ptA0w8yf/xxgtWd6B
         36wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820107; x=1783424907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Asy+krBxEjHu+kbwmloqJts1t5EkLXcM+GPd0epvWoc=;
        b=gEX9TLOqHtkuonn4yF0hpI5magXSqz1wiWuPingIdvySEgvnkr/IodHrL3OB4+F443
         +4nBvh/qQlQO5ImSLEJu1SmmFZ0/E8G2LAFzwqYzMFhzmR4dyldi6qPXY82M2wyEFh87
         KdBxrOP1faqb77oUfM2SBtzz7R8167que9/w+K2hHyYB1B0n2ruLOl4mtn17Nf2g9ifq
         70p+UNnDoepRjfumnnuVmfd73GcZSXKiIoPbkeXmI0D5sXIB8sVHbxNqrrx900nvvV/E
         d1s2pC6WVnh/Wdumm9qPqZ3MDmJT0miEkzS40vwr/t8mQvXaHgBwFDU1My0+s5r6+f54
         s7Vw==
X-Gm-Message-State: AOJu0YwQXNHCv7EgHhYQSvfBLZDcUHW1kGdf1ygyn/m8U6VEhKZrTdv6
	uu0vGBMML/3rU5v1hrrPNNSonXeYSlQcHz3c4rS7fiORNwiDD6XULxha04CNQq95
X-Gm-Gg: AfdE7cl6X5RHTb8WZDVOCQgDkfm8rAFIdTL6oexegMdOi9TX/Qzd1/Ed9aV2T7aLMj1
	qiBU3Vup2DCf1N5oaADimMpxZ64SF+wnuJSO5ThVSpktYPeofaSY/yz3pUtWk2uHBrpy4b5U4bg
	iGJbsSeaciep6KMTwZECUHeGdxFh45fE308Xt/qiPXuc1ooU9A/LBKll85pklouberxDebRl5eK
	iE8+38OdojNoaOrM2PKsqUHVMib7+bvb/8F4TpzqpXRjTjnBxkRIaCA4l7biM8kE4YQe7VO1Uay
	PEV5MrM3jGuTa4BCqWqi2kTNE61nh1UkekWVEC/NcNUlqWZYHhWKwgWrfHRFgGljaVtxIUXtvBj
	J9avARNxuRoqlztx8ABUqasN3Gl7EcsBhaeIldAOeEAL8ImBpWe9dcjbXR40bjw5/3DHc6GhTD/
	PoR9ZOYc8cWpc7PUAzhW+ZARaUVkyhhlp5XCeXNw==
X-Received: by 2002:a05:6000:4687:b0:475:2171:abe with SMTP id ffacd0b85a97d-47552a6917cmr3681700f8f.35.1782820106188;
        Tue, 30 Jun 2026 04:48:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:22 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/39] dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:20 +0100
Message-ID: <20260630114813.92739-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23325

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b05bebaa60e4e58f36631f41a73716edd8c56d3e ]

Add SCIF binding documentation for Renesas RZ/G3L SoC. SCIF block on the
RZ/G3L is identical to one found on the RZ/G3S SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://patch.msgid.link/20260120125232.349708-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 24819b204ebf..9a71061112e8 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,7 @@ properties:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
               - renesas,scif-r9a08g045      # RZ/G3S
+              - renesas,scif-r9a08g046      # RZ/G3L
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
       - const: renesas,scif-r9a09g057       # RZ/V2H(P)
-- 
2.43.0


