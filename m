Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC65F3C271
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:25:57 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15525.1773066356064375326
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XtUwkVsM;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so19672095e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066354; x=1773671154; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNgw0DHw03iANe55vl4U+qqNoMZz4mvYbEz8Kh4vTys=;
        b=XtUwkVsMNBOddtvuARzP5TEX4JT7Jo+ciElPx12vb3TO9Vsr3/tsJEkqnbdPOi8Xzb
         mddHAVCwtfS2Y+ixEFc2mH+J/G1gBeiCzNXb1lFAG8dvmbhVJbQt8PbJbkNucrL/hTjy
         K2Ea5ynnO40BYIh18Ctb/afatsz7hS/PrJm6GCq+XaQmsAYEqCX9iuJYzoOv5yHDQI3E
         Fm5INHDrpiUqnzYSJXRHQC89qK9bnskj2NDK0OdRSxnCnpakJ43Wma0i+Pf0WsKSzOpp
         RrMzs9maYhaAyxFDacoNm+1ExjHwFAofzsj3A3wjuCjmtkAikq8L7Zme4RH69SLM8AiJ
         00DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066354; x=1773671154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNgw0DHw03iANe55vl4U+qqNoMZz4mvYbEz8Kh4vTys=;
        b=ZfgijQ1mt85uNazv0wZK0XJ5F/+Ey/sVKHzx9jpxjFauMEecAIzfu8KfZg1HcuJS5I
         kzJl5i/ZJMtwz92uKulXrhMt2oClgyfLGcOt7XddwN3IdYWDfiMipEAQb6VP3Gnx4bO8
         ot5WgETwO5m6zzjzqKuIBDLOkT9n1B2l564Tw2qY70LEWqCNruneD3mLfgENCHDChhU6
         dF+1UgqpBmoHKlLWp9ByQ0ilRvH7YWByoW8XgkcNQRlGl/82y+dpmgfpN+1/Ez+7xa4e
         4SlE4oOWN5Q2ReRo7JYA+/P2BaXFYDaiqTdmZHHDjDr+YK6CXKapMwaEZiP8Lp+4dz4o
         4TXQ==
X-Gm-Message-State: AOJu0YwKN2XavvCBybHvQ9lLSnK+H/Etr1a/E8SaO1Abn9zRgKjwIUQo
	84P1dcEyGVbFA52fRtoK4YKiubKVITbiNzZf+c2yURjFizJRota4fpDIPLuU1w==
X-Gm-Gg: ATEYQzx2GO2RNgaq10xiUtyto42GsZUMmi2G4LHhhjIQOmwCu9KE/PoQ59xTN9t+xOc
	/OM15ge7L48iJOfgsfwixGPpLWTQwa2VP8jJ/4nqB5asNmXGIRGb/KE/DmcsdYR00DaKPJiqOCy
	tFmL4fQ90yKLKfjZn6ViT/76UvtnRhNu8x3CyeOp6+KMBI4U6TzF+YDM3Gg7IfdPr25mARfZ4ii
	AYbJVBgtexq8aotx2f0ABxW64+W2hNTtHfToUsVlQIzT7HXl3kt1cv4OgubOA28GVs+b0aFup0E
	KRPpLyYbLjl0X4s3NWbO4wJo9dVpY/v5WEEzMiynWI9QXFjkvTel4TzUbW2GtFn6ZZ8ZmF3TYny
	lq0SGOIp7ctErYhms0k42J1EzNl2mFiWmI+ILiDqrDgGWmZ9DoXpKPLSAKxZA1aaKG3Ra5/wPEI
	fsAltF564L4WqrjJYte8cy3ygjqOqfqVA=
X-Received: by 2002:a05:6000:4313:b0:439:c122:4fd5 with SMTP id ffacd0b85a97d-439da65d6camr19431065f8f.15.1773066353975;
        Mon, 09 Mar 2026 07:25:53 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/29] serial: sh-sci: Sort include files alphabetically
Date: Mon,  9 Mar 2026 14:25:06 +0000
Message-ID: <20260309142549.987737-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22174

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 8e2c0a9f12edb7f05b3b60f02e03dc319ba7ccbf ]

Sort the include lines alphabetically, no impact on code behavior.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251023104313.210989-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index caa98b1257d4..ceb16b964f63 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -19,11 +19,11 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/ctype.h>
 #include <linux/cpufreq.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
-#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -32,8 +32,8 @@
 #include <linux/ktime.h>
 #include <linux/major.h>
 #include <linux/minmax.h>
-#include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -50,14 +50,14 @@
 #include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
-#include <asm/sh_bios.h>
 #include <asm/platform_early.h>
+#include <asm/sh_bios.h>
 #endif
 
 #include "rsci.h"
 #include "serial_mctrl_gpio.h"
-#include "sh-sci.h"
 #include "sh-sci-common.h"
+#include "sh-sci.h"
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
-- 
2.43.0


