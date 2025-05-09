Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A989C3ABD2
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:34 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.10285.1746783206969741150
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oOvIFX+R;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso3833571a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783205; x=1747388005; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oRBZi6fnEKUpN49iKQ10XGs8Zid9IPNxLBJ8qnb3VE=;
        b=oOvIFX+RAExnytXO4ZIZhtZoqIqnYagXZPxgDDfwvBP9sL2w5L0CVH2BpEJ6DdWCbY
         JJ1ezzFivsMRgv0gPe10R5DfrCKVaq6gR9uyUNdBG5vJtz3wLaFXTM1Xrw6s4ef1HswA
         7DOK5JGG4UGG/RaCzpG9ISREFCEhsZadC/8DwR2Y3/la/cEvJx+vN2nmBKE3jEoAVjD0
         7b9rews2sah0DYjcGUQe0iqe6x1C8FIoNfejaSqS2ZV6fQ85+o1ITf0UIKeMujoCHZPP
         Ryw/yoTL1fKqan1P/JKAWv06fPM+XjvxM5vK7lmK92q61Ud4SVBewQt+qi7puY2Iv/+k
         4n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783205; x=1747388005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oRBZi6fnEKUpN49iKQ10XGs8Zid9IPNxLBJ8qnb3VE=;
        b=H507gOSMBCBN8kSn8uBF0KIB5lSo6pJTyOA36gVhDrBZaEIWTd+fncZQvti+StQuNR
         UJynoLAjWhZbonNuQW5f08sZjPpykXA/s0ubxw3HhGzkLruA1KadzJJgpkOVqBnThEoB
         w2hT9nAZoDrHbXYJWWBukwdewt9pwHRhxS048L11tD1a3p+/PZZm5Clb29A+a1GZ04HD
         wrCeKoOR0E0LpR0aynprNd+R1K7dwJDnmIm/gVnmz9R3QNXEIu1Nl0y9iRcWGBlMR7CG
         4uenVRAF+nX6fM8MoXkEBRaZhSQVW1dM241cIgMqyjBo2161Eyme7SF9kJBLyuMmrS1g
         EDpg==
X-Forwarded-Encrypted: i=1; AJvYcCWIxNKTizwSPXl0GPmWRSQ8VRqNTz8DV2g1Gdnb45WFZjcAiAguekhr3EsBmSvI5NPdp+w9YKqS@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzyjj2p0xQDSUzRF9Kdmkm3Gv+FSYmL9MxzIcsfKb2smUE3oWjR
	sfxePxWAuV6bHVHd2MORXNjN80Ite3/hSfjJWfiLBx2ZO3cR5rTQXLSMlAMblU8=
X-Gm-Gg: ASbGnctW4A8Mp5AevaPTdmXcnXnAG08MEQk8Qtv7Lt3lXo2Je3UAE4fhRRPBoOCW21B
	sxYxE0bQ9WH5jLn4Vew+SfkMb0pnQVXtApgKGPO+55F/i0X3wVdVHREHaBqyvqTlCPGCc6aruli
	X+SRnKMpkmdbqw77+kwnU9tYbpJ40TO/hRul+LvmibWpiv96c4SBTiAfU00iULFCUzgViN3D9/y
	SssDpIbxZ7AP4mcIW11U+35H7HoG0VyAEDDTHWhzMEmhF4b68csD+CMahWE99FBNanti7iphFqC
	LR7lpPFviDBPAPPjtVzjefFMxhmGrGNS6EBZIWG09M0nlpHSaNAM6Fv/UF61isr4nj9EQCvyc5p
	cqqVm
X-Google-Smtp-Source: AGHT+IEpMmpILkt3KXanOInemKSbqSEmBh9sLOta1ynyyWk+fvW0RlSqEifr+QXNAVkCR1gPX8yDtg==
X-Received: by 2002:a05:6402:4409:b0:5fa:e2bf:5491 with SMTP id 4fb4d7f45d1cf-5fc351ddd98mr5449058a12.11.1746783205366;
        Fri, 09 May 2025 02:33:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/34] ASoC: da7213: Populate max_register to regmap_config
Date: Fri,  9 May 2025 12:32:48 +0300
Message-ID: <20250509093318.4014916-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18821

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
index f2bbee15c06e..85ff374cb646 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2122,6 +2122,7 @@ static const struct regmap_config da7213_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
+	.max_register = DA7213_TONE_GEN_OFF_PER,
 	.reg_defaults = da7213_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(da7213_reg_defaults),
 	.volatile_reg = da7213_volatile_register,
-- 
2.43.0


