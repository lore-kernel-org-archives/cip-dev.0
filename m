Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6AC05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.15322.1713514731631364612
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J6HOVQ1k;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso187681966b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514730; x=1714119530; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mkFkQS6gotqcznSxj5dR8RyNIXVmzqDCUxcRVXI3Qw=;
        b=J6HOVQ1k8XDl3ujOrjEFj+DTaVgSbPahJapNUNnET8kwMAtENrgL0Ev6OUjKS0mwjV
         eEtvlpEXc3vs1D5TACvVVSChWSXaiANgBeF4Wjhd2Ccmy0NuzWG8EPX5RGEi7uPbm0PI
         VMU0z/wn8EjRF70p/VOtzFjVKhUH6pWQH8cJsY+OY6fudif6MkRPY3VjRSnNj1Ygj3kP
         2WLayFkRLtCOYVqCR468gcHAw5+oANTkmZSUb3Sfi982osUjRKu0YeT7gYlFCS03DUWP
         SlveFZHWGIWFg0kkg+duufgcCzls0dvRmzXY6R1ZRJnG9o72Zf4dEvLG38V0/DTtTY/L
         uGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514730; x=1714119530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mkFkQS6gotqcznSxj5dR8RyNIXVmzqDCUxcRVXI3Qw=;
        b=b5Y7Vt9srSwk46/0BfuLq0Q2gObuFyMrWc39qu6wp9TrhcsD6b0vtiJwAlW6bA8kFY
         CKC5EB/kuaf4jIFuTLE5TlfPwTwCHR6erMUKkCvY8FzQX0f3SmelPuGsp8j6zrFwwZt+
         S/LyaCWBumkl9xlisBbIDFrqYmUt/q1G5bx5lbk3z+8c3Yx0W4sdJshEWXYbf+4yXB4T
         tC3RtxCtl2QnOLk95zdfvs+Xxk6RcjX6plcfq5qJuAkgQADdiq0qk1VPizI1O8wS3ZgU
         420dUgfIruNYwxqxSO48iliQeNm+DRIodFToH60KoMNOhHdHUz/BHigZcWYHeYUoOH0u
         EXHA==
X-Gm-Message-State: AOJu0YwdcSNtxCarZW+F91X3GmWqqSEni2guA5bTFCx/WjGPzNOC5FBJ
	aTVgZuribgvXXTJCNsCzXNvAcVBakaDJXH5qRkR/+nLm+vvgRbNevMYEisONBaE=
X-Google-Smtp-Source: AGHT+IGLplGBdb7aSfqMfCHQYAcFRgYdIQw3WDIkX3QTDZ7/tuQv4rvm637AQIUSSyEm1DNWuSXSfw==
X-Received: by 2002:a17:906:3414:b0:a52:6fca:3ff0 with SMTP id c20-20020a170906341400b00a526fca3ff0mr956761ejb.30.1713514730041;
        Fri, 19 Apr 2024 01:18:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 43/53] dt-bindings: soc: renesas: Document SMARC Carrier-II EVK
Date: Fri, 19 Apr 2024 11:17:32 +0300
Message-Id: <20240419081742.3496709-44-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15630

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6042f5365bee167ac27d02454f5cba403747277a upstream.

Document the Renesas SMARC Carrier-II EVK board which is based on the
Renesas RZ/G3S SMARC SoM.  The SMARC Carrier-II EVK consists of an
RZ/G3S SoM module and a SMARC Carrier-II carrier board; the SoM module
sits on top of the carrier board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-27-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index ea995b9c77e8..76be05de1788 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -346,6 +346,13 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ SMARC Carrier-II Evaluation Kit
+        items:
+          - const: renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC SoM
+          - const: renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


