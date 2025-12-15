Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB95D5B175
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:53:25 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47822.1765803200068381152
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GhA237h3;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so43177195e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 04:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803198; x=1766407998; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O48Hq+Lbusp8U4sDpc9OisJ4bVqukuQGjXTRfLuPsLU=;
        b=GhA237h3I7jdC23yI4edAEx7eVA3nE10vIHFz7OzrSagUiRo6vtkl/TLqn8W9uQGXH
         X52m1c5CoP2uWDEk5ImwbOY5lqHtOEwAczPX5jgd6vXNPJ6Rv65L8u6Y2kTKJLkmzqlh
         WCotgDquImSXzYzaBJEjGzjDoCiJhz85lME3Mq+WUG5A2PmgnvN/0wpNs+ciO2mNfsRk
         bt21CsrahteTgfTU8xkD4aY3aXx0fFRbOPWH36FXA4eNUQDAZSXofy+s17rTm5PkZCuQ
         wP3KV9AB00IQSKi9PKmmTqWuaWAgmcNYOOUulOSjmXQ994ZaIjtxL0ZXGuXFpLduvMRk
         zSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803198; x=1766407998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O48Hq+Lbusp8U4sDpc9OisJ4bVqukuQGjXTRfLuPsLU=;
        b=ic4BxZJecl7kuHc7KVzv2A9lOjOuV4VcafWib5X9xzi1uegOo68Ax4II9zQRc5fMXW
         /mqOzVBOUjXloPAbA1CusWvOs5GPJA7vijgEX5laF/B94WQi7Ln89OKhHK/mmrV10M7C
         /d3hUDU4ZTahl6z4U/2E0JVsXtC+HHyGGgubytha1zrk91tVuKIoHK8ujvSloMRVvwFt
         67wQGjKHrJ0KcrpTexXoMqjv4oWioPHoMxnYKRECr1R9qzRf8q6Xn6DF5jmUdVST7Qeb
         IpfBn5M5qF/OcKo3jlYHbnlJXPtcF078/6/1bRrwfx2tnL7ZEODcncCDoNoXN2RPrkjw
         ZVwg==
X-Gm-Message-State: AOJu0Yy5fWedMqr6xKeRnHtgkxirMnNj+fpkY7Aq/V/PnWNDrzjIZy2D
	WuG48AHE6ifsiVw7ZQoDG4ToOtyL1XQJhP/AhlFPrhyRqPPLHTUU0kLErnqUtg==
X-Gm-Gg: AY/fxX4jtUP4TrwzsgWzurfMvXZK6aum5XpZ2lnwYPIOazayTSSqnz9lQdr6/V3Kgzz
	BhGuLWMFDHLU/r2CFvXJRCV9FH9h0ODJzNB29NmzXFOl/pS+z9+uGxOi/ej5xVo0s9/t1xYy6yo
	xf9e0pdiFtFTM8KCBGFIILs6sOYPTHhTvLfhaLg3AXRwchwXa2iweuneTlCgbsdnP6U9j5jAXCA
	aIQcK3xnSWpwm0YDLCaHTqGHKAIXf0zkuh4JPWaAq0BzBmxzrvp/pTZpzBwdAWoYPi3+msGxgIY
	tnGafm59K3c6q9t0h+cHs3nKCc+rfO3ro9hqFfiPzRnnMQcNUCEDyqa9yFpilifZa22QlGxm21i
	5tXXP+ipGfHG0Pcxq3uROvFiYvG1CQr7bntoI4nGJi7QosmVT7sEOVibDm3sSllr0HnQo5DRsVR
	Mc8vAbEo2xZNOjw1PSDLYVTTlePTSr1ZoMElnPXRe2hTODbg==
X-Google-Smtp-Source: AGHT+IFeS7lzlD0XbzFfixUE//EyDYfG9c6d2+DWXPT33IpZETW3u3vzEDFwFiOBEeFI47eQc+Yslg==
X-Received: by 2002:a05:600c:8b6d:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47a8f914528mr100896645e9.37.1765803198101;
        Mon, 15 Dec 2025 04:53:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:73b2:9197:2aa3:716f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm13820577f8f.32.2025.12.15.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:53:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/3] mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
Date: Mon, 15 Dec 2025 12:53:00 +0000
Message-ID: <20251215125316.137879-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:53:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21057

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 74f44ad07d1063933c237a7db16f6a4036643d60 ]

As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
During testing it is found that, if the DMA buffer is not aligned to 128
bit it fallback to PIO mode. In such cases, 64-bit access is much more
efficient than the current 16-bit.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250730164618.233117-2-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Biju: Moved the macro definition from platform_data/tmio.h->mfd/tmio.h]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      | 15 +++++++++++++++
 drivers/mmc/host/tmio_mmc_core.c | 33 ++++++++++++++++++++++++++++++++
 include/linux/mfd/tmio.h         |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index da63193dd45b..92e9bfd92bf7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -16,6 +16,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
@@ -251,6 +252,20 @@ static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
 	ioread32_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
+#ifdef CONFIG_64BIT
+static inline void sd_ctrl_read64_rep(struct tmio_mmc_host *host, int addr,
+				      u64 *buf, int count)
+{
+	readsq(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
+static inline void sd_ctrl_write64_rep(struct tmio_mmc_host *host, int addr,
+				       const u64 *buf, int count)
+{
+	writesq(host->ctl + (addr << host->bus_shift), buf, count);
+}
+#endif
+
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
 				   u16 val)
 {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7bc292e78100..a000ce001994 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -350,6 +350,39 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
 	/*
 	 * Transfer the data
 	 */
+#ifdef CONFIG_64BIT
+	if (host->pdata->flags & TMIO_MMC_64BIT_DATA_PORT) {
+		u64 *buf64 = (u64 *)buf;
+		u64 data = 0;
+
+		if (count >= 8) {
+			if (is_read)
+				sd_ctrl_read64_rep(host, CTL_SD_DATA_PORT,
+						   buf64, count >> 3);
+			else
+				sd_ctrl_write64_rep(host, CTL_SD_DATA_PORT,
+						    buf64, count >> 3);
+		}
+
+		/* if count was multiple of 8 */
+		if (!(count & 0x7))
+			return;
+
+		buf64 += count >> 3;
+		count %= 8;
+
+		if (is_read) {
+			sd_ctrl_read64_rep(host, CTL_SD_DATA_PORT, &data, 1);
+			memcpy(buf64, &data, count);
+		} else {
+			memcpy(&data, buf64, count);
+			sd_ctrl_write64_rep(host, CTL_SD_DATA_PORT, &data, 1);
+		}
+
+		return;
+	}
+#endif
+
 	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
 		u32 data = 0;
 		u32 *buf32 = (u32 *)buf;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 27264fe4b3b9..566cc9ad0363 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -84,6 +84,9 @@
 /* Some controllers have a CBSY bit */
 #define TMIO_MMC_HAVE_CBSY		BIT(11)
 
+/* Some controllers have a 64-bit wide data port register */
+#define TMIO_MMC_64BIT_DATA_PORT	BIT(12)
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
-- 
2.43.0


