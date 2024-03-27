Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC15CD129C
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.32445.1711527510937425671
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lcv476db;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41494c43058so1887625e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527509; x=1712132309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J13GT5CFKd8XNBCAXRaaqJ905F64BPOCzVVdHk3M9XE=;
        b=lcv476dbwBjIpLDAf0PIyLy6tIfILaHFOEPNLgLjIoFKBzuoEnkv8R9Rbt/CLJNt4i
         afUSvYwkbm/MyjyWbBPmgD4QqFjpe8hvl3zGt0h2T1hDjcLQ9t0K0Pe10+SWYrFa0DsX
         mzspoGwX/pV9NP4QLHM0jOx9RwvsS5DFD6G/FakyAvsl5RxvSi4ysDMWQObcl078wXIJ
         ZIomh6mFy2FWi18mmVH8pde/CH3byp1KZXeSTl/O532djTFnaMA0skaMSR2XlIkJ5c9R
         MJbMcoLelAr8gFof6cdhPjReovXmkedHwbanSppqiixGYY0NJOXMUgjciOn+JmLJINfB
         OW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527509; x=1712132309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J13GT5CFKd8XNBCAXRaaqJ905F64BPOCzVVdHk3M9XE=;
        b=BoStTBQa1QTGEa5wWDlq5WtEi9pVmyl+vK6gZURDQiyeLpSMDLA1/hbDb/rMkiKcgZ
         g5PGa+BuVTaL3icsUrt0W5tS6fsf9j5F3rYu9h7eJtaUm9zCZeb8o9qm6LoTBBi2YTj3
         hvmVf7juG9hrcQLx/yncakhAM+arih1mBSTpzAaiaPLDeHCxUOC8Ge+gxF0QCbSZOMSl
         EFNoqolg96G8rhMYhbsyZtugAEMSHGXhf5wWprXgzWqnHhm08miFtaTKlvetAIHQy7hQ
         cBHETsv7FuZpSJrbt3WH0oOrDDBOKYFOsvzpZERk/cAZJP7tbvE72EmvjGmWnzu2ct/E
         i7Sw==
X-Gm-Message-State: AOJu0Yzng0i+RbiepCYF3CtG6aO3UHHx/+MxtlxSH/NUFu/HhVxSo1yE
	243fwQm731HNULy2Fw9isZpyG8d/wiwhkmhWWb+9wzo0wvgAFeT89WTpwzxvQpo=
X-Google-Smtp-Source: AGHT+IFmr8WoPSSH++XsTP0OltMdVdtsWxJdpT2oarjjst16JVzTy94ELyNIMx0cAVNaeTR2d2WlBw==
X-Received: by 2002:a05:600c:444a:b0:414:9075:114a with SMTP id v10-20020a05600c444a00b004149075114amr2391208wmn.2.1711527509472;
        Wed, 27 Mar 2024 01:18:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 26/36] soc: renesas: Kconfig: Enable IRQC driver for RZ/G2L SoC
Date: Wed, 27 Mar 2024 10:17:46 +0200
Message-Id: <20240327081756.2228036-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15443

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 41a21e578da4986685f013d45454a12457f01180 upstream.

Select RENESAS_RZG2L_IRQC config option if ARCH_RZG2L is enabled
so that IRQC driver is enabled on RZ/G2L (and alike) SoC's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718192824.7246-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index d8d0d37948ad..6256fd3b6efd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -44,6 +44,7 @@ config ARCH_RZG2L
 	bool
 	select PM
 	select PM_GENERIC_DOMAINS
+	select RENESAS_RZG2L_IRQC
 
 config ARCH_RZN1
 	bool
-- 
2.39.2


