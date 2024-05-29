Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED1CC27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8721.1716970491604596866
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=m8/RFLt9;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4202ca70289so15149655e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970490; x=1717575290; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7p3Yt7Zbc+T1RZ8oQXpb2sjryr9tDTG8GkBnjVhjlY=;
        b=m8/RFLt9J0hkq0QRJqlvLWrf81zMyDhRO4e+bQzbX3g4YJi5fNKuos44HuCR+AlQ+J
         Xcp7uSOFS9YyVkxhPaDqbW8bxYkY7jyWV2i6dKaiqRXc64lxAQU4ZuNkhZhZ+KUivnfg
         AOztMnWDucfTRt7HWGGjvFDkHYR0eUs6ZCR84EkI/JpWWIFaT9/ANAYU1OjvudHXKIRQ
         DRFGg/nUJn97atH14DRG0OLkoS241nLTlhVISGaYphGIawxKttiQAb6a4dKhFzdeMr0W
         IQgmw87zst7+tdmhfZUT5bsvNEXNwweFkmzS3iajsikmt90qyCLzven1VlP7wHeyJWp4
         /lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970490; x=1717575290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7p3Yt7Zbc+T1RZ8oQXpb2sjryr9tDTG8GkBnjVhjlY=;
        b=AlkHl9r7SIs9drzHEABcwdINBQKZ8vqUx2pip50gZmPA558Yg4t3P0scuTz495JJHg
         vFO20uzps2XIemPAJStRm1vKHNhJ9iiX7MwKEy9Al3Nvnr60M9t9ScRPMhcUAtShxaGw
         iN0RjGLArqbeOclC1XhanPAG2rkkCe1cur7MvuE/JtbWPWd0aofvZjOSe1q9FRS/5MVf
         wkWpCeG0cD8ZgeSZiw0IE/6coDUJQW/vZMbNcumiiLTHLEaBz90nu9lbRt9Ciirv+dKl
         VkpkxIR9eIY9ahCWOx9bm6IBHnH5mvBqt654Ruj5KD9KsOkkiVRhksBe44LJEgYThk/T
         ZFtA==
X-Gm-Message-State: AOJu0YyjmSaQoLQ34bGTSK86iiZg5DShBLXSY5ZB5P6wXnnIGOQuf4P4
	MZ9jjSosWjlRzVLZQFt212wA4P+578KM2eK9+MFuEBG8rWyYYF2ArpPJjFBrSQHLKXnqCEysuPp
	4MLQ=
X-Google-Smtp-Source: AGHT+IETU2lGyJvTKWsVJ+GOmwwYze7zjqZxJq0PVYp2rxcmRPlviV1/cERTV0jECf5kBQErf1jPeg==
X-Received: by 2002:a7b:c00c:0:b0:419:f31e:267c with SMTP id 5b1f17b1804b1-421089d18fcmr105098435e9.7.1716970490102;
        Wed, 29 May 2024 01:14:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 08/33] dt-bindings: net: renesas,etheravb: Document RZ/G3S support
Date: Wed, 29 May 2024 11:14:09 +0300
Message-Id: <20240529081434.639519-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16036

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 060baa9b90d4e14eac7123abc563070dd30b21a2 upstream.

Document Ethernet RZ/G3S support. Ethernet IP is similar to the one
available on RZ/G2L devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 3f41294f5997..fa4775461f5f 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -58,6 +58,7 @@ properties:
               - renesas,r9a07g043-gbeth # RZ/G2UL
               - renesas,r9a07g044-gbeth # RZ/G2{L,LC}
               - renesas,r9a07g054-gbeth # RZ/V2L
+              - renesas,r9a08g045-gbeth # RZ/G3S
           - const: renesas,rzg2l-gbeth  # RZ/{G2L,G2UL,V2L} family
 
   reg: true
-- 
2.39.2


