Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30973FD7087
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73597.1773746262792951189
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KDdpE9JV;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48539d21b76so40084525e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746261; x=1774351061; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYfKiNCci0DlFj8lHxiY6LJWg9sE8Z89gxQ1K9uUs6k=;
        b=KDdpE9JVk+9CQAwADmU87iiC3/WfKIDu49SpNDc4Is0Luvahl4BfXJju3TozhVfnsU
         bKv4UjSwPKqznM/pOfmG3T49IO2mRunZbbL0Aojw6mbqF6VVqu8inBYO6xN2XgiKz6Uh
         yn0vu5rJ9RDLD5NoeaiugWDDy6gxrdvFpAnWSGuZYcscRNqY8hjux52V4ODPr+0lXe4W
         QkzlG/ksIRuHOIqzDLoSPrmPmRFEE0hOc0bIuQWt41W4yK7RZUr0jWkzeN5Gm8N2iXin
         6yblPYWcXQttdD9kdcYz+QuCudMIbLH0IgI9prvj9iEgOKzD8ce/bodqXsRW9Ud8mkM4
         NBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746261; x=1774351061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYfKiNCci0DlFj8lHxiY6LJWg9sE8Z89gxQ1K9uUs6k=;
        b=gNIENz3CHEUZo49zNHg+syvUKowx7FPiDLfOadcD5YhHBNXr3NIk95rCY53oFJYEbP
         ospOcy2rA6clysmrE3La5FTXg94YT3sV4EfiQoqeEqfIpX3XLZiFRnmOgmMTTVSDhv/2
         /UefW3zd+VMMWQE93SniWfRKXCjaM9idkCzW/7HG/6h+bbCbOYuaQaJ+gm7GjqFHb5E7
         HxdM6biZt1LzfoD5jREZwmd9nKuNN57/4ahDfXtWkv2MiamdeJNPeMMODmYryl1wYo6h
         FQy/ueAr95Rzi6FO67HD07XpJ/AQptU204b0xZSywmuKurQP71k1pmi1tHY6W3m0URGY
         pjLg==
X-Gm-Message-State: AOJu0YyIxij3yN5j8Ewcn1Crf1rqFvAu1EM8pwKTQqVITlUytemDJuvB
	DpUHMgrBWKLaORgtG6apEoKq2NrJarxr60tBhw2zQAUzv5c/HOlgcu3vvHK62Q==
X-Gm-Gg: ATEYQzxTn1W6nEyJ+M4hM398K0C1iR/iEHkaixKzV9OyNXaBgKBZCMbakJXnCG8Wrx4
	b0cKenx1MqoqjLHMnWryv4+CEV9y2SpsKS90eCgkL3oTERA08hSoJLighiZOD/hN91LV6PD5icT
	MFfZ0zgCgN8RBSiQu9hoPMIUpGz6c2HQnTwBg0mYxKkgpvJOiwj3xNx9gushzvnHmM3bEziSOuC
	JpOurSZUEcBcpt/UnoXXDFvIoGg/ZtlQ3P8PUx0sQZUCMF8d5Bf2sF+HBL4DtyqDZ6OZos5kdMh
	YJzyhUDwRMi73wlKyolSKvyqSA1LNI0glVPJO9rJGZT+TnendtdI/3o+DNBd46PMqpueSZTIXuU
	LqR6T1LylMbf8+aV3aW5Cedmg+sce+zd1GXGSGDzTfd9ZJhRuObnbAwnuOn9Vu1JNBWmhUjxNnY
	jSIoOcdWAd+LDFEKfbBFw69eLFgx18Wj566KM8GAk41AslFcL5
X-Received: by 2002:a05:600c:c162:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-485566cf8b9mr262419835e9.7.1773746260738;
        Tue, 17 Mar 2026 04:17:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:40 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 26/39] serial: rsci: Drop unused macro DCR
Date: Tue, 17 Mar 2026 11:16:51 +0000
Message-ID: <20260317111718.281633-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22459

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 36816a033dd41fda415ae0696931d6bfe87671a2 ]

Drop unused macro DCR and its bit definition.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-8-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 6ba2413bfd8a..891c33eb5e9f 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS(SH_SCI);
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS(SH_SCI);
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0


