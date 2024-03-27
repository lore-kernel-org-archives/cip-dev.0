Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B71CD12B7
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.32435.1711527493842010970
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kfjotgiq;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41495e79e03so539305e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527492; x=1712132292; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOASrUG9Xg5XJ0dSCzpqmVP2f0ij29BfLpm4VinzX/I=;
        b=kfjotgiqpVWSU/hnTCHD2zMJF17cn9Kvo6D1SuDG21AP9AYjU6oxsd4pvRVIq5ewId
         jttqsnNOQq0HMNlRlSR1M17uG9fFWIyy4gyuLFOiQOdLo8YaSJX8j7WHYVSCw+mvk3XY
         iS27X7fQWzCtBb957ANfSiCWgJZ7ogyOdLboNK9X27XxOUCD7hLojuB6hNo1sKhNiqx+
         Hl5ncoAIyxxU8Ngzksm9cuzwuuf97tczYRkKkj4ar0AYdOqWtepbpk/dP0x3BQGWb77e
         LDU6KRFOg8Z3NmxsjIbJw4FkYJlpJHRmCEci0drkkbJ5TcA6Fke/puM0ZXdM3xWCMo1e
         IfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527492; x=1712132292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOASrUG9Xg5XJ0dSCzpqmVP2f0ij29BfLpm4VinzX/I=;
        b=inYUECEtjW9CvBOU4JJIfDir4aOex6FQ9rLX0XwukjQSDJAWBh54aIXCFECqU/3Zg8
         41IeriBKFQBKcbpiI9TgJLaWFTDYktRK+zB5mWKmPiMljqOSbk3WW68LapjFF/BSaP/c
         OmAdMyP2T4UL+jGwKZCwpG3s/FT0y3+8oS6DkFgIXxNLPiAhhhGMrW8/fYg1u7lvJr3i
         YoL3jDD63wUelzfRnksPR/6Xgka5UAz8b1VaZOa91y93NFTj7hUG5Ir+jzm0QZrgFDEZ
         GVBDQloQrxGpXPY5ryzYMRNeTIM1y7GvUiXFdn3+GRh4hKJiPg6UvmIHRyN32KaK5H0q
         4G/g==
X-Gm-Message-State: AOJu0YyOa83ryjsvt6JF1VB+PvTlLUHXEYF8o/7F+GzpoJ8s/rdpuktj
	FIMXuM+w9VQB4N8tKhe/9qhkqjk11HK5sGL3Pc/CZ0xMd1iHJLbOgkqIHvd9oHo=
X-Google-Smtp-Source: AGHT+IFGbR6Vmnz/AA29aXdCgf/OzcIURKrcJAsZS4b83uY1+oYn+JlW8PnX9vtYJVXx31GmAlo40Q==
X-Received: by 2002:a05:600c:1d29:b0:414:5ed4:6ee0 with SMTP id l41-20020a05600c1d2900b004145ed46ee0mr2557719wms.29.1711527492349;
        Wed, 27 Mar 2024 01:18:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 12/36] irqchip: remove MODULE_LICENSE in non-modules
Date: Wed, 27 Mar 2024 10:17:32 +0200
Message-Id: <20240327081756.2228036-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15429

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
index cf99cd6b41c4..17c9f8fd41a8 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -391,4 +391,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.2


