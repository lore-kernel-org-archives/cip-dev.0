Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FDC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:55 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.10337.1746783292920624114
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Oorn4uxO;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acacb8743a7so321522866b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783291; x=1747388091; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuI1L4XG9JCPrAZb1VBo11Jf0/wYsEL9cazaEZ/IAdc=;
        b=Oorn4uxOKi6vOinw5PmMAxJsYNTB2U9dCbRtORHYp9wMztwzRqrf9RhHiTJG5AZCyt
         3NwBIet+F8/+ekQn1tIKO3RDeof71S5E27LRYRSXaG6AR+2nYV2rMaNdGMLP+gW4qmxi
         xEf6B5inrSza/OhZCdzfb998tK5dPflF4jexU9fIrf+QK/Rm+08mH+3ae6q4+jVwA0iE
         Q6IA+D000WYkUvB4RiRBMT6mwjKUIOcY5Fw/NQ+pHeXdgbNKD8luDdGMCGQKt3JFwMgh
         eRrmGzSRHSCuhuM6nvTmuPMDYy7rbMOkeDOYSR0NxR+L+naR3X9YaMzBh+7NNpfUh5go
         /n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783291; x=1747388091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuI1L4XG9JCPrAZb1VBo11Jf0/wYsEL9cazaEZ/IAdc=;
        b=GZym2gjJxT6wwZm9SFzGlbUbjhX3W6eqFB5ySQu2TiJRsTY4cBUja9aR+QCGUIawVp
         cpljw9ey+HRUbvKBjz4oKGD8dcNeFpObHWhKbXogu5i/w5Fjt+knwYPvw1Qk/qdTp0Bl
         x7kgyn8NUJDW4/SyYBDgmIYd7rlxP5JVrQg8sdAu4e39na12T9rxCZ63bRfW3/jF4pUH
         tHyrvMqal5vYY5x/F8cpFSsGI0+eFgxlQW5cm3fu1olIlVKk2UHsGg6vgpV52CuUHNLH
         +xDvp8YvMnZ62RKR20IRnt4WvFdsnXWsMqMiLjGe99w9W+3W/XFXmhjpkeTvPfcFkiE1
         /4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0GiDuhd7zGdaJcUpjgpQyYLU0zp0VzooybqThzyr5jTPn5438/V2Rje8coL9v7ttFYuDGQgUC@lists.cip-project.org
X-Gm-Message-State: AOJu0YxQYvkkp9deiqGTL5j/XWkgdmayXQKtsXiyK3BsXPkwaxJm8Skl
	1lSBE1OAzeuoClXPFfLJFweXRBWjsd+T5GMd17K8svcQ6Z8xjIavvbBut4qInk0=
X-Gm-Gg: ASbGncv2TkwcjNADErHHMLlI3O4rofs8T7x3DZYl88JkJcim+KjzyX6zph7i2PJtWKW
	UveftmCNC3jKik6axGbYOURh+h9reuNiROxDv1P4S92MYSnKKR4jIxm6JA3Lfl6MerzAZR0PqwF
	wNJO/pIGQTMlob91kXcNfPou7igdlbiRK9+HfdgkH0uNUO1y8415oUnNlTVEDqUKSVBudhfbduY
	gQy3mcAjknEs/c60Lj4NVk3fmdeBAVaWqHZ/kWAqM5mbkAVnXA3KSuD6a+b7xT7gwct9KeUBuKR
	PTCIbWR6/T0Ja98hSSxKstEzP940s95yCMEnL9wS+9fUkA9QfOzPpgiNcMV4pqTQSPjaCQ==
X-Google-Smtp-Source: AGHT+IGVTP6L4IHUoBBfZAyX0FNE3dDX359kf8ojF61/298PAlaBtoMoavjj10zF3WRWPpQMr3lTjw==
X-Received: by 2002:a17:907:a4c6:b0:ad2:175b:9db with SMTP id a640c23a62f3a-ad21b16e27cmr251959666b.8.1746783290773;
        Fri, 09 May 2025 02:34:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/37] ASoC: da7213: Populate max_register to regmap_config
Date: Fri,  9 May 2025 12:34:10 +0300
Message-ID: <20250509093442.4015145-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18857

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9d4f9f6a7bb1afbde57d08c98f2db4ff019ee19d upstream.

On the Renesas RZ/G3S SMARC Carrier II board having a DA7212 codec (using
da7213 driver) connected to one SSIF-2 available on the Renesas RZ/G3S SoC
it has been discovered that using the runtime PM API for suspend/resume
(as will be proposed in the following commits) leads to the codec not
being propertly initialized after resume. This is because w/o
max_register populated to regmap_config the regcache_rbtree_sync()
breaks on base_reg > max condition and the regcache_sync_block() call is
skipped.

Fixes: ef5c2eba2412 ("ASoC: codecs: Add da7213 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-23-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 911348ba8ad7..d4b0e48f818c 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2119,6 +2119,7 @@ static const struct regmap_config da7213_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
+	.max_register = DA7213_TONE_GEN_OFF_PER,
 	.reg_defaults = da7213_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(da7213_reg_defaults),
 	.volatile_reg = da7213_volatile_register,
-- 
2.43.0


