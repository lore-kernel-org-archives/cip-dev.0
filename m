Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1D1C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.10312.1746783241709018524
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g2DxwQ0R;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb615228a4so574861266b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783240; x=1747388040; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxoWuKvXJpwzkCEPhOOPbN8U/7Gf9JMsLW6BVF4H2Zo=;
        b=g2DxwQ0ROTPOyaHFhmUrGk/GTfubrmZNsceTwSvpf8UT+0OQGxbQ0jFCKg9nKk5aho
         XfpQTNtfBNtexTnZonE+TouMn1Zsfiin94RnaZCoZZj/n2TE3z5F/mJKxtE740uOHZE7
         4M3FLgVMupMk+E551MFzv6QDclW3LTSnC2ib5XlnlyDgF1kca1P16StJL64pOFWBxt64
         Irr0jRpK+BHyhA+Sqn1da6b604TVJDQXm9OqPaWIMZDFsQS75yf4Ed8jR+jJj4mIDJZO
         JnPRIXyOqGIJzuwp0u920xd9j1xaHgoOwanpJg8PJNpe5EWNXBb5R8k6MG2W2EjuhVOa
         2HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783240; x=1747388040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxoWuKvXJpwzkCEPhOOPbN8U/7Gf9JMsLW6BVF4H2Zo=;
        b=le89MN+O35HkUOWf65efFBj1VKotYhms8B2mUSavy+zFIw9YZ8eJkSYXvRhhRWoLln
         wydHOV1Qj/VhDUFiZAeAZkrG4U1c9ZgaXtRKSwAlhqgsjhmVhPSgKYS9NuYZ8fk/q/Au
         w0jvUdBKXUcZdpoOMSPkgyR9OwNIm+fhWomX7E6zuiz7hqpE7OC2HrHvwP3JOvbjK8VB
         tPvFxtKreL2UqqUV7DsgmDFwQIEXc9APo4Nx3z8wXhipA3msIWt4j+huEvNe+TlMQIUT
         HdBHaqEYlQ+O0MbU536vXvosEcChwq0Bep77AeeDfHVSwUFr92HNOoQFoFbkObbHZnlq
         I/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHeA/2ze+DYD8mvq+IM2kof/CmLVcn7B87gTbErXH737XIwZejTJ7x+LVDXZBir7PEyeajAAYA@lists.cip-project.org
X-Gm-Message-State: AOJu0YyqcMzOie9/LqlCS9LzwFUWCyd3AYjF7NaxxRCnw1fE/YMZEtEZ
	m58pXA2rGWFQz2xEJ223CiGHitjs2hIt9kuZ9CXHovKzviVUPQI02OdWaKgE3R8=
X-Gm-Gg: ASbGncvBrSGt2tHf1a8DZ0JaboerKlcnaPbX59hoEuHx6+fChRfy1kLFCgvftOqBCGV
	1kXVBKU/93dj1r/B1fLUjJS7YcrXmXUZ9FAaxXyYYT3z7Jf0gQN7enn9pcm2oUcRkipiR2qxhIR
	465E5iyhd2hzb0qlD+yZQqIr6gJLiqc+DnOgdtE2rZi7nOwWWdzCr/6qywjPi7lY0W8JCWTBud5
	lbbc9bJwr3C/caTFs6JksDQPM6VuiolNawJ2Ow1PolArH6dZaCjJu93FTaQlhiANVhd8a+LC36X
	LEIhkTiv61BGp3mPDIYNqn3y/qpQjuT//UFC2R0lw4KzYh6BmtUyBoEwpbvSCw36rZmWDdi/3KL
	mVLee
X-Google-Smtp-Source: AGHT+IH439sqty7OJCqLubWi7YmL0E0dCQGe73R0oFx2dr5j4wbWZTKhbI099qGflyJuhGhmkgq8GQ==
X-Received: by 2002:a17:907:7f89:b0:ad2:2127:c379 with SMTP id a640c23a62f3a-ad221288bcfmr128387366b.0.1746783239979;
        Fri, 09 May 2025 02:33:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 27/34] ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
Date: Fri,  9 May 2025 12:33:11 +0300
Message-ID: <20250509093318.4014916-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18844

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c28dac5d3a6e87615d4c8e50f574c320172a3d55 upstream.

Remove the DMA description, as it duplicates content from
../dma/renesas,rz-dma.yaml. Additionally, remove the MID/RID examples
mentioned in the dropped description (this information is already
documented in the hardware manual).

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-19-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml         | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 2863b10ef12a..94e2e3abdaf0 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -54,24 +54,6 @@ properties:
   dmas:
     minItems: 1
     maxItems: 2
-    description:
-      The first cell represents a phandle to dmac.
-      The second cell specifies the encoded MID/RID values of the SSI port
-      connected to the DMA client and the slave channel configuration
-      parameters.
-      bits[0:9]   - Specifies MID/RID value of a SSI channel as below
-                    MID/RID value of SSI rx0 = 0x256
-                    MID/RID value of SSI tx0 = 0x255
-                    MID/RID value of SSI rx1 = 0x25a
-                    MID/RID value of SSI tx1 = 0x259
-                    MID/RID value of SSI rt2 = 0x25f
-                    MID/RID value of SSI rx3 = 0x262
-                    MID/RID value of SSI tx3 = 0x261
-      bit[10]     - HIEN = 1, Detects a request in response to the rising edge
-                    of the signal
-      bit[11]     - LVL = 0, Detects based on the edge
-      bits[12:14] - AM = 2, Bus cycle mode
-      bit[15]     - TM = 0, Single transfer mode
 
   dma-names:
     oneOf:
-- 
2.43.0


