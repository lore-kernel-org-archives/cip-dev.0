Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A5C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.10368.1746783329444233969
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oq2Y8hkA;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acbb85ce788so222850466b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783328; x=1747388128; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxoWuKvXJpwzkCEPhOOPbN8U/7Gf9JMsLW6BVF4H2Zo=;
        b=oq2Y8hkA7Lsk1vWERZ+fZf5DPoe7pkNerHhDIlQEk9qZKud0RT5mnVCrfCevqrl6bv
         t4GcOR6/EZ6PPUMevUlDIGzu69zJAU8eQC+04RHozJJMIGhuYF326ixv6NWXsuzYqwD5
         oB3udD5tU/OADKznJPrmZ/btszRhzQCP/Htqhq+nzZ9NR9dARreKd43nAGWQrv8SucEm
         ir+1EexmQg1B5XafUalC0y76RZ/RKEz0qgxCrL2zcBB5C3bvD1J6ah4CGZYDcFtFYI9e
         mWfuAk4hcbsILB3U6QiVqJyIoNITKQo4RPcGeCiAqlIk+ZpeqE5MxbTHT4Q1l0u4AOWG
         E6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783328; x=1747388128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxoWuKvXJpwzkCEPhOOPbN8U/7Gf9JMsLW6BVF4H2Zo=;
        b=YFqpg9rb5f6mSoVRTKIMPRY5D1MN0mYfpEYz9j9eTv2cbGnvH+uvkxANvZgUw9CQxr
         HAcvQduPD8D3rkkL+0teRHJUGclVLjBBmaIoxVtfsBSkrxS+1XiNGu9EI/5Rk2tzr1Oh
         6MEJr1h9hVT+JGxTDssJyCPTQh29D13QP/siNJFKysHMceIKi84A9v6O8BWGeY5Byzl7
         6DxNSNkcO9uoDurDvsj8dKNMuYS8cTb0kkdf4ZAl+miJRxvjyLfoUNlME7M/VdH1g1ER
         6MJqjEm8h/kSgZPhHBiNVyX2Xf19l1d8cTCX+teSWbQB6W/Zfj7EElAMd95VGQH2B7ao
         9FFg==
X-Forwarded-Encrypted: i=1; AJvYcCUoQsMl+B9VGO1wXc+YZ1nt2aoZ2TzF48ZZE8i2H+xtjGCl2ZXzxEq9GNqYi3LL+fULUaB7nsK+@lists.cip-project.org
X-Gm-Message-State: AOJu0YyCaSCCAugM+Zy77bZJmkBNpg8l/uXv6zMh+KMa0ZqcOBstYDxK
	WnJGv272pjqZj7+NjfsZYQ8hcO1Nq4OomAqdMBjAW7qlD6wBzY+JV2arzJ7Kngw=
X-Gm-Gg: ASbGncs4B5N39ppUw8VpAZf8ubBUi9O3EKh77VFZ+doFbq2KEYywwg6vbdnOHNUKNAu
	73zueCuqE8maDfr3NK9gRBZxumwa6+EhSCJ79ugn7ez6DG9Wq1y7RvcN2e6IIa0sMG+EIoQYtz1
	yAnwIGp3tCLPNcf+RUrzMMLir4v0CytqlL4uNxrDVc/pbcmCKNZsEa19rbT7Pu+2rLEV6+BC7DY
	wYEVY1jYwNnpQEiy028LObK8BKjYa2nSAb9dko0FnB1m42blqQp9vRe4J0tVu0CutXvl7OQNW7D
	jUE03hpzgRll2Wq8hLu1u80MkQE5UHUShq4AK+yrjoZn0q3Dxge3bI9pxvRnEHbpDONqudTbs9n
	rPA4r
X-Google-Smtp-Source: AGHT+IHB+4hp+bXgICztrr9/V515ZB0BV2DDDDVK07fBRoxyH0D7ulxqEowKkAabwcuFKThQjzlNFg==
X-Received: by 2002:a17:907:3e8c:b0:aca:de15:f2ad with SMTP id a640c23a62f3a-ad2192befc8mr239249066b.60.1746783327864;
        Fri, 09 May 2025 02:35:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 30/37] ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
Date: Fri,  9 May 2025 12:34:35 +0300
Message-ID: <20250509093442.4015145-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18882

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


