Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C762C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.10357.1746783310425556248
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oYLawJR/;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac345bd8e13so273311166b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783309; x=1747388109; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWWW+r3I13VsjnIkhw3ZTNhi61SinnMYLXrApzsFQNs=;
        b=oYLawJR/3uqqnZZ6A3p3CpN+NajtIyipxMbB+EdC3GPX96lQs5NIcWEHNwD+zaECVU
         Zdr6ljtVv+Bti7py29wHo7Yf3FAAHenGw0GHQY/HQjnRjGgkRZXfgLiiecdbVJFibkRG
         agJHWiy03ylL2A5KOsSbT344KcPmp1BVLpE5KJEbCwvTzjXWmfd316598M38PxUW1bvk
         jTNKJtsrRtmHYz3S2qk02mh0WpZvTN7Q2TaITqsQbhqOQcdqUUEhmMBvUBfdRX2NMRNB
         MkFtJX30/QrSsP0s/pIQ+KQJlesdi2/M9mOHYScxyZDE2SPsWK9GbEHrx3k/luqD0kXH
         sWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783309; x=1747388109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWWW+r3I13VsjnIkhw3ZTNhi61SinnMYLXrApzsFQNs=;
        b=vBPNE+Syfma+XTv0xzsi+2hg3X7x6iaHkXV5zvL6cnW0VOnL0KKE+0O+n5bYkRbT+H
         Q4qMDjOn8PneC7DHBQk3Ffx1yymOrfOJiWOQGZN9cZrU3zCPedmRKJAvkIjDbtQE/JrX
         mKZfP+XAGirbQgflpcGtqxpPlYnJ9Z1OkbPDB1eTMU0ugZh7FH6WJ+QkRaoDgEv5M2xe
         NjAIhmWVslbKfK5nkhFhbzq407Xl+ZYYcI6JgBJBMvnfKUywbQIHXAhCKJ5lM0ED6XND
         eJ+5te6kWi++Eqa5Wp6ZpbHYXGGtO7pJJoNRBXwD3GkbCJe5yZyZH/8tG4Dc+mh0IxVg
         Bb2g==
X-Forwarded-Encrypted: i=1; AJvYcCUxhdg3Dj3f3HsVOEUTLFt/WwvE7nMQz3VHrWRa1qM125L4R+fZ47L3BxhgDx9Ki/2MtDbfiVA6@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4SHcMgJXw9rns6lB5dJBAcv+kgl76s3mp/8jv2qoKQVsJYb0f
	Mst+OxScgk+MacHxetfR2+tAeXFKaQMKtJN0oVkHS2+gHkCSz9hc4XIkzS21oGE=
X-Gm-Gg: ASbGncuAhkXrntGb7CKowNS8KNkCjhv5Z8vxcqDq02+6E/tqPWkbWIM5mrAidD5cSRD
	CsYnP7dIB2vqPGGFCXyBRR8iYs/wtiBEt8nEc01Q43Z/JWXGMmuIecGlHqVE3IV9oO0IPBACabc
	qknva+qqqmXDedouzwpeN20ri5sIjnAfFfOD/uTop+E1E2UUmw0vd3Bt2pEuaGNhWlkOOTrasxP
	KrYdRGpzusfA/ZjFNt79Pm8zZGDOaa2LKSWb6+GoA6tdmbp3nVz8A+hYaThHt1eYfRppqYn2L6H
	dGgu1LdTOKAFNteLiKh3Cw5GH/C7D8cYIGI0lQY4WOheQGCXec0q9AZREjVtJZYLASALWQ==
X-Google-Smtp-Source: AGHT+IEo3cT8PILAatb3bSL3MAdvMY8dANzBqHc0UV2kDD3Q164/+ImDlY6qkO6xoFbSyh9U5WYTjA==
X-Received: by 2002:a17:907:968b:b0:ad2:2417:12d2 with SMTP id a640c23a62f3a-ad224173b1cmr95146266b.42.1746783308818;
        Fri, 09 May 2025 02:35:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 18/37] ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
Date: Fri,  9 May 2025 12:34:23 +0300
Message-ID: <20250509093442.4015145-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18870

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 100c6b22d6c70adabdf45dcb346d7d853bff6a30 upstream.

The SSI_RATES macro covers 8KHz-48KHz audio frequencies. Update macro
comment to reflect it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 9b99a0318572..5828d059262f 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -72,7 +72,7 @@
 #define PREALLOC_BUFFER		(SZ_32K)
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
-#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-44.1kHz */
+#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
 #define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
-- 
2.43.0


