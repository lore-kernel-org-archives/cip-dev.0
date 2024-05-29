Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE0C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:16 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.8643.1716970270826544824
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JHo5UJXn;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so14239135e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970269; x=1717575069; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnT2S8vkX4/wbL0SpQXQF1PihpfeVTCdCPhxT94z0kA=;
        b=JHo5UJXnJ8m948Z2uwEsEkmZRspJPqVyfmlcLPPLn6Bdsa/UaVrZhuCHKzI+mC7u4m
         ZDDAQbn/uqsYgLU2lITwsLqNOiRYLhc9se2koLdgDSbdRQ2CU7p7jXgoUJc9vg9Z1d1x
         dFFLj/gthAlegr6ZyeTZmyqAw/n1NijNEFF1Lp21jAiL1wf5Vs4MHYMMg9ckpSw3HxHA
         eCZjpHtjF3gkPZdVKtdTlaB1+vc6djBPUqCstLDgK/8eD07F+L+RX8YMyFAGyqBUORIu
         1YLi3yYi1qmIIc2BoFHjLa4J9pJQca9IdNylTWGWLDOWZyhCLfGTQPhy4nrwIpR/8MLx
         w+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970269; x=1717575069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnT2S8vkX4/wbL0SpQXQF1PihpfeVTCdCPhxT94z0kA=;
        b=CqaIqYeZU1jguirRsZV0vJBDceMl0n2tvBgnSWFGYTHWwy6sVEkMb+I69z9Q7oWJvU
         dFnznRb8DAkAeqM0f6ccoVksmY7HWuArT076LIvwC3WSTimqvNsPR7aErJrp3/ToMv67
         3qCqqioZM8AeKpZCRFnsa9Z2GrnQEk419d7gpHErOrb2M42mpUZ/4tvmBkmEDjWwo9Yp
         5gJ7qAjjPghkVbuf5xqePWKHu7ou0opYL+rbZjuupsvRQXdJbQ+XXHG8K1LfWyQ5YjNu
         ELFq9W8szcVZa/ReGx89wSRdMhU1Ip6gWp5YdA9WcmsZMarRqOqUanX1RyDLLFhgouyd
         Nn6g==
X-Gm-Message-State: AOJu0Yz4I7xWHjzuTZBzjMGPVwS22Uimt/usb2ipNXKyX0pTW/BjJGSm
	S6oon78B2wq54OWBvCiaOI12Uj0+4z82XTt62bm410AzugtcDPAAPZFIlR32ec0=
X-Google-Smtp-Source: AGHT+IE0+by0Pbvf6GSMasi8momIZbATc4ud8PoE5agJuCNXXsqZE1L6aE9Tp63Qsw467MzMwMUiLw==
X-Received: by 2002:a05:600c:5110:b0:421:15f:186a with SMTP id 5b1f17b1804b1-42108a12b4fmr99673735e9.39.1716970269327;
        Wed, 29 May 2024 01:11:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 16/47] ethernet: renesas: Use div64_ul instead of do_div
Date: Wed, 29 May 2024 11:10:08 +0300
Message-Id: <20240529081039.639010-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15996

From: Yang Li <yang.lee@linux.alibaba.com>

commit d9f31aeaa1e5aefa68130878af3c3513d41c1e2d upstream.

do_div() does a 64-by-32 division. Here the divisor is an
unsigned long which on some platforms is 64 bit wide. So use
div64_ul instead of do_div to avoid a possible truncation.

Eliminate the following coccicheck warning:
./drivers/net/ethernet/renesas/ravb_main.c:2492:1-7: WARNING:
do_div() does a 64-by-32 division, please consider using div64_ul
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/1637228883-100100-1-git-send-email-yang.lee@linux.alibaba.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 6cc3dc8d85f4..9b6594ef011b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -30,8 +30,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 #include <linux/reset.h>
-
-#include <asm/div64.h>
+#include <linux/math64.h>
 
 #include "ravb.h"
 
@@ -2563,8 +2562,7 @@ static int ravb_set_gti(struct net_device *ndev)
 	if (!rate)
 		return -EINVAL;
 
-	inc = 1000000000ULL << 20;
-	do_div(inc, rate);
+	inc = div64_ul(1000000000ULL << 20, rate);
 
 	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
 		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
-- 
2.39.2


