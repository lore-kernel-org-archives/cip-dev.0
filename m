Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4FCEF3715
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:43 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9240.1773043894454099022
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TO7Pqadx;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so18315445e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043893; x=1773648693; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+clHL807DC65xKdLDevb2T1f0PBfNN1u1PxwRu+HSA=;
        b=TO7PqadxXthlljhniRxduCu8x3V732YGMYRD+LDKq2R5Nabk5RhpqDohZKTOBvufHt
         CNH0Ah9heCEzEJFTjMPA06HDisMLf8DZ8BS4c4TdDWknWzpcWEnV2Wwqhp1/geQWpl4m
         IuP7dW604Xc59mkR6DzmRUPm82j53Bla5RnQofBY4u30rrNcy+QKVhrfuVpRrxSFwKev
         wTJ4TZV3Bz8L5lDG8FSF5kzC0undJGq8fg6INuOpuU8q4y2vWJd1H3fi8eYKbS/4tBJV
         ASMiB/tsbUQuXO2xq4BfcCqrmFZGcBWX/robiO5m3vCqKGH7mi58BU2O4zBg5R1HvujG
         GetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043893; x=1773648693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+clHL807DC65xKdLDevb2T1f0PBfNN1u1PxwRu+HSA=;
        b=DHHf980WL55RGFDugeiZPICfQjDdjEZrzlmKZEPLuGsmpvcPnGuEInjDsRt131UV+j
         +q5JRPpCvfPH1w5Imwb+KXMLtPz68BKspgH7ck1HtwnamOJRs04MEZFUTrw9wemWkKlr
         JsdjIn9XqUHkIJWMB1jqmhmOsobF8Jux2XCg5LUsg/AK7U9z1HPX9EzX5Ca3qX23bWgN
         Jn6J/QJBbeY63kH/b7pTQSJN1ja07/lQRhqaH2IM8R+NQbtUs+KDjKjgC8G34syMiVGE
         YC1vhbt2JFZVanyZzk9sk8Olyg9hhT72rToxZyQn3gWoBYuLs5SdjTbkoG4tDuZwe5ad
         qW6w==
X-Gm-Message-State: AOJu0YyetmY92aepQa/GICuVigddYqMnUe9GqXMrU4ycJeUbUaK73xZC
	+rCQf+03VDltlbdTtj39JkG2BhC6JgP9RrLRtJUqjPsLxRKgzJT4Vcj0GsXASg==
X-Gm-Gg: ATEYQzxnChqw1U5whZhXP3NY3b8wVB1v5PLVQ+hPq3EC2hUPTPBwLMdbupX9fiusClQ
	MEHVmfcH0A2Ln93YzxfhHF4Qm29oSgv0uzUWIU7gtUzADQoK25hWYh4tOculck/mK4T2RFxEkXG
	T8hMVxzHWmJ6jly7qohnKgDeKmJECdYklWYnjaZTaeNg7FTJfZ97OyVrPyH5nLFxfppcfSNuWlE
	y+7FH8G3SHNBIsW4aMcAs2ntjHi7IRA5UPIlMY3WOLWJ9tUkGHL3idAUEBBXNEAg4CCFzeZtjnc
	0zD85pf40TCwfHgDdSmb7thlNX3HocHJoxVOhtP8PrQpZK5FKbVVFrGgoEUUd4Iyv08KsEt/Xfr
	pEfq88+EVpgWfPOw4WH9CEjI/QOCs1ExUL3KAOp+PZ8elM5pAhW1eAvZEicDEVS1FUe8KT6Dk64
	uFOIg42EV1ocHL7BdmtX7vsS+lEjTJlVwI8CnE2dDVzcxehtmG
X-Received: by 2002:a05:600c:3d90:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48526930a4fmr163640935e9.12.1773043892510;
        Mon, 09 Mar 2026 01:11:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/6] irqchip/renesas-rzv2h: Remove unneeded includes
Date: Mon,  9 Mar 2026 08:11:22 +0000
Message-ID: <20260309081129.154109-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22157

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
index f826b680a286..118c1fc177f6 100644
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


