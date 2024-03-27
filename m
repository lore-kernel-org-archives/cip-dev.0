Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72712CD12AF
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.32663.1711528513929863117
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YRpZomMw;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-414866f92beso20775045e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528512; x=1712133312; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwbB8/kJYegBWC/HzBvBliFlh6la8wIkeN8GjWhgOYk=;
        b=YRpZomMwzlWn8b6t7w390OFL9krqEiWeZHQ9hjnP5+IkVKhf1A5UaC+AZLJZxgRS8A
         eSabBVjVvZNaqcIjFu1xscxG1i6OUCROs5IgtNK2CVwdAT0zvlkkWzs0lAlzcjSqV+vq
         szJleaQkIKhbiku96Xo43hm4WJcA0A9vjDcnN5F8pTnekTttOz9PShBq7rQ6OqS9Eeiu
         mtd29dHYBdgRL6srP8j9qiKkwdayatGIXvp1bfO1wAJot3WjBxyWA+U+3mGLQ7VWftqF
         ui8GZkENfJhOOuq3y5mD1Pl+Bfd1AWcxFV3Pb79X0vdIe4gVqP9zR0p0lKrYTiFWtMS9
         G3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528512; x=1712133312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwbB8/kJYegBWC/HzBvBliFlh6la8wIkeN8GjWhgOYk=;
        b=BJN7MmVKc5ZD40X469UCfBEWniWOWztre/JIPr2Jrlr5oFX/n4NFPTY8mnZjjvIrHL
         a+Ela6gdf/6greIYE4d8eWxzWQSe6PB/IBoL9bKV2xdU5UD4tTC1xeD1vaLCUEsdA0dV
         C/nHAfArGn7BpLRidhrJk1clDn+HWpweFzVo8H5/v5cklAqVtynMY5MPP9Ki7gjxoNfM
         DwfF3fByukKsd1QWj1Ymqaj7MdHYK6izi7O4eF68HV8GR/bIByOepPHno3xTAxPvMlI+
         nvPbuno3K6vpKDmuF1HY83zKf6uKH8lAD9RcU/x3wraUNYfuTjYjAM8QcAdrd7BsjDJw
         7ouA==
X-Gm-Message-State: AOJu0YxxQtfiaXJqGqE1OH+aq8SZET8ZQMEneyQdaYyF4xuM5g4rQQ8j
	wb98xUbGdzgKkqZqSbYQjmsNeO8VYHyiFkM/W7549p1LksTzPEwXhfd0JyD6hrA=
X-Google-Smtp-Source: AGHT+IHqm+yBSxi9nZLaBT65wAF7KCKWXH1a4YWZcKbMkDKJSJ4m/QzCp5sEsJgYL7WldOvEOGveKQ==
X-Received: by 2002:a05:600c:3149:b0:413:3160:840f with SMTP id h9-20020a05600c314900b004133160840fmr1381081wmo.0.1711528512249;
        Wed, 27 Mar 2024 01:35:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 02/13] irqchip: remove MODULE_LICENSE in non-modules
Date: Wed, 27 Mar 2024 10:34:57 +0200
Message-Id: <20240327083508.2229567-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15456

From: Nick Alcock <nick.alcock@oracle.com>

commit e3f1f02548adbf973af29c6ee6304a45121bff03 upstream.

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0922e7ca04fa..6390d1d78f2e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -391,4 +391,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.2


