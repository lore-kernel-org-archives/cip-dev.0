Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B9FD7083
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73589.1773746255338133793
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H3rEL0Tj;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853aec185aso46146835e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746253; x=1774351053; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v02Fwu9sl7mg/62g5mINXKau9nGtzkO+qnPHe/BWsI=;
        b=H3rEL0TjiqTfxaTgDvn3mcYFJCbJ4Fxe6JWRWk3OSe8IWHj1dIwsptrv5PyQwyYOqk
         IZZz90gryspfpiBFD/qP7FLJpAWYW3+VXbImDunsAI9RzuURb2EFEXBrrdq9e+pmH1SG
         iShIJQXLJXwBEab8Y7/OC4D624XYM4EuJ93V2ntJuJsZjE5Zw4GF35dnShanZfu+MNID
         /WSBL6oq7fv/kVsM+BZe8nB2AECENZ38VdRSBRNQ7YnPE0fj454RFAcgWBpcYkFhocMG
         nIwPGE/ntZTt/n5VDyJEk6NjlTsayUa3gbfk7MUDqSpywWRgSpQKLN/RSKIexZ8hWOUr
         O+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746253; x=1774351053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8v02Fwu9sl7mg/62g5mINXKau9nGtzkO+qnPHe/BWsI=;
        b=SclgGoa5w+m41cBnZj0SDrUI93bJn0Lw9ZOy2TmPclQ/+ur4gciXVNPCo/xG36kU/L
         Nfq0bEGCQOk+1Us0pL6OCT8qRVufq+Nf2JY5HU+ohOJibwlIxhTd7hU8pjnGpcEu9sCk
         pFiqCDTjYl4JLkmGzQhzGJD2+kmqrsl9zkiQnv6aDpl8v99C3fHGuIGX2l7ynf/hvbZP
         VNDUpJwEhK20WiVLwp9+IoCJ8jv8g9lnZQn+AXV/Yx2pTFXDT+BqM1HfBdznAoEaVd/9
         plyI4U3Hnh80P7yw58F+9LIMHQHcp+UOhZCD1iWUI5nMfEjmIUo6bD9MKlW9pRax+Kom
         afRg==
X-Gm-Message-State: AOJu0YwlpcONZnh4C8Qx5SDQCWTycDfJ9sY3MHhscPsYiGb/pJby+egj
	piUG2qTk3e5giVdngyLf83vrKG/Be3XKUqlEGV6URgrGMw6f23WtIGR+q44fhA==
X-Gm-Gg: ATEYQzzCce5yBV8avLlFIip32LMyn/dsrU85BHPeZQR0VSs8wQcRXiDaqxLLWTxTTDb
	GIZakItlZDGomkbXEVCOP68fogjzdnfthjqcZNQKJQUIraLlWIc1kCJ3XgZlCGGRX5I6x7hqbhC
	MQd787x4FauNGet39FMh9+1pha1ceYDOjR+Kv/uH899G/Hpdjt7XjpljKzffH8mfnwmc6d0RL7f
	o4BMxwwAv0YUHWf2KtJfDOerx9uGk6Kf7ov2mUVoP6pdpimcH4VO/zxRDGXllo+kAX+s5zhJCb9
	l1MXPBVLX51l/l3PArh+nbCi1HHHp4YTAXJjJpTjy7vRSheGcwuzmvm2KY03XmGCxUqkfBiZ8UN
	2VLM31xa7sV9+vOdUorhNk8KnRASI6EUaISNiS40SZZTMvWrMhVYEBHlmHr0fM+Mi/PQT8Jn8fH
	9luBdBtks55K4pMPTipKL9MqSv2EhEqaCMF1uuWnO1bzaDeoXL
X-Received: by 2002:a05:600c:5251:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-485566cdc17mr270748135e9.7.1773746253352;
        Tue, 17 Mar 2026 04:17:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 17/39] serial: sh-sci: Sort include files alphabetically
Date: Tue, 17 Mar 2026 11:16:42 +0000
Message-ID: <20260317111718.281633-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22450

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
index 69425071d1f2..6ae2e54b5bec 100644
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
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -51,14 +51,14 @@
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


