Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD4EF3700
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:20 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9080.1773042677856943834
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sy4hHOye;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c56e822eso5733564f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042676; x=1773647476; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZTXixhdI2mCbKM3NgoYsHJE3LYbW02LKAfjvipLPIM=;
        b=Sy4hHOyeNgORp3/0lZTS5qOWT3RaRgzU5UXt/wEMqUk0MX+oz59LF3vgjPlVLrN7Bn
         EDgkgrWFC+o5ogAfxN0N2HSY05EI9W71+honJ6MdMsPJWPoiTxHogiyWUYQUgbGdLKFG
         J88uy2HNY9iXmC5lUTqSZFV59Sqoj2+r6M4rVoOI9X/8yJQC2wBmILVUzmb71JEheiJw
         wecDLvpK9d6jsPBIgyftg1u0ietctFAQ7bYhKHqJ0VEMhnN6VEtqqmPkbloHV4o1QcWx
         1f5QM/06ckJ9vBg5JhTIBWkskdhZuaOevGcSLZIESwXD86Led0pReIbcpAjaDUhXHbMX
         E1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042676; x=1773647476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZTXixhdI2mCbKM3NgoYsHJE3LYbW02LKAfjvipLPIM=;
        b=e/MZ5KpbUiA2Zt41AUnpdrPXOzaGLbKVTmwiYB9d+pNb8YmbFSrPpVpIFBc1LuLlRF
         6coBLGEJHLBbL223NCHGoThj0R3XbrUIChruPJZ3HGmLVLPVLqjpLKy4+AY3Cfam5Def
         qP3IOQKI2kwfyGUqg2l+4/IbjdkIWTkCGJs7M/LeCCX8rIa9yScvCvIHqQHgBpfz/AeC
         0c2RhxlUtRg1sNQOWgK56x4GdHBS77uAjMyNcQW3zCzbCn4vsf5SGP0apYYUMgjBmFmi
         sus3/QUdLC7NlO3TaG0e6/L6F4qPRr4Y6AbS7f8a9BAcKJ033qfkWfPrY+KD34+5YJIm
         qkKA==
X-Gm-Message-State: AOJu0YxsyT5Dwccdacw27vSbPbDkshoOZWH34FjYUegkTzn2BHiUa2Ef
	HXWAnxwppkfXcq7GKjmtCfSus9RvEgDkJpNK/Z2m4T7UUa8smcHNepRaTvyXcA==
X-Gm-Gg: ATEYQzx8O8BILyuWELiqKUhubWDQekrhM8KwbfHXl5SNcUpl0HoC494Unafaf2vz6+y
	w7QaHXETqbxj0Q5cUZCQh2oN/NEGq6uYiGTpn2n3m+dkdtLWXc17nGtrcccUD/Zr+9/DPOmd8KD
	t/EqDiDHl+HNNTRpzfqjNzh0D5mFiBhUTLuNHGdbl9omIywgkEJjtwWHrvzpfeFve00aC8YuVki
	7zEuSfNfvEOiNVvETTXhw+aveuMDcj7qr4mYsWnLKLUPn3OB3/i8geiSgmGY1DcAqj1qrpyK0BC
	QFuiL9t3u26WuanzD9L2HmzRYAx+D7Kl7zGZha6BaPp7Uuc6PUPgfzbLq7bFXd4Lx0sXn6Y6H+i
	x+mL7cz/IBi4KB0qK0UBqZfHan+WPNWvineh3k3fDbiVv7Z6TVjwELp++P/0gSNYGIa+4uzIqdn
	jqUmYRU4ICA6Cu8bTBzymnT68bczZbRTvEb1ZBbNCPXtHbJcoctgxUylM1T1Q=
X-Received: by 2002:a05:6000:178b:b0:439:b7c9:2edc with SMTP id ffacd0b85a97d-439da8902f6mr18327914f8f.48.1773042675600;
        Mon, 09 Mar 2026 00:51:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:15 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/6] irqchip/renesas-rzv2h: Remove unneeded includes
Date: Mon,  9 Mar 2026 07:51:04 +0000
Message-ID: <20260309075112.35445-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22150

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 41a5f82885e152c364e587ab30df4e582e96b73a ]

The RZ/V2H ICU driver does not use clocks, of_address, or syscore.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d4fbffc39af2eaa7bc50a0a97ffb3a22e3c4cb6a.1751446168.git.geert+renesas@glider.be

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index ea67da9459b7..6096199cce52 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -11,18 +11,15 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqdomain.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
-#include <linux/syscore_ops.h>
 
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1
-- 
2.43.0


