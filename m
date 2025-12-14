Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D1D5B175
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24313.1765714237339794814
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WuuvUt0P;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so29335705e9.2
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714235; x=1766319035; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KcvNRDQGsvFQv/TPLtqcfvQxqYJ5IZnBQExlOxKP6s=;
        b=WuuvUt0P7SZwKok5Oo5ddgrVvULgDWJM6x/jV2uDc/zi4ZNE7qjRdgUHkemhP+WeMI
         HNgv8w1DgFZtrFkIouAhYaTNiuWAQC+WO9N6JjfrYfoktlFSz+aslclVLeYYyEx5mOyO
         7UHjNQf1MdR+q69HIjYexwTp8ZTfdZbBBo39DTzzMJjRPShn4tYA1grY/VHSh0uKYLEK
         0req5Uno1XrvFPhhh164rhBxTqTlkjfNNVlfZyNfJ8SNjkbuGWTu9N3N6cAIOIHxZsso
         acAAbnx1GyEj2wFJdVBfm1qXwDOd8PcOVaavoI6DCXC45WIihquzqZbxZ4gcy+3t6KxS
         Xi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714235; x=1766319035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KcvNRDQGsvFQv/TPLtqcfvQxqYJ5IZnBQExlOxKP6s=;
        b=etis3ZrOawJPVeyThUC8p+89IbT4+ixrA9xiL/d80PfSEo6OJbiogpWeDV3Ii7OszF
         XAp7fkdLRof5EU9xPCUMVUPDlm6i+MHsPnuchjqZZOlil0jEarkySvvntgQMS72Z4Th6
         X+DaJYX92VrUkbEoz0dAylNKzdHsW/5jndunqXHsmyN8jOfD+r/rIUgFQZ23dnTN7eFu
         PL5xVsOA8TbF/u9HbWBr23qWr+P4QAke0S/dq/f0R1LD87XJNhOF1jabMrOhx3ivBxnL
         aDf3d861sKZnTVA7jD0y1ljv9mGWBdOlne94PN8w7Z9HgNQzTU7z8w/3QjW4fDBs6fDV
         knUw==
X-Gm-Message-State: AOJu0YyfzqxBFTniIuhgClLBTcNd5GiBH/u1fA7+YurB8zOe/RDYjFgf
	dpV0W+c8IZ7OR2XjVgj+fy4IGjc9H6m6uYSavr7PN/cZr9CTWWObrDyosFx3+A==
X-Gm-Gg: AY/fxX4/z8e4ciY8Ds84NbpVbt1Zt8lfaJgmyrsJUryRpuPwSY0c3KS95E+PViNsyuc
	OSYHbggNN7IhuQA6QuvImQ7un/sY8nRaIkjOyOGse/meiPWNusxzfH3EA4cRDhZT05Eaq7tYQXR
	opGSJ2DG/Gvh9TAwZDmlecjDdZslu/j+afdhbotAw7A/fWTMoKIWN6eYT/Cmwza9CbXVpe+I4ah
	Jnuvbf3ucvg3qtAFQNjRIyisy5qMcdUlwhxqEouT4DTxqiOXQafkd5frwfrXoGkFLJMXLpjmVPC
	g2B7wg1K0y9dZIMpMsGXwfdAxNOvtqG44w4dUfmGGdhmjCEijk8jFij87GcN/LKiST7rtCtQKDW
	atItzZ54XLWxj8sGjcK1NLZ53RzhJ7prPOfT9v5PP3IhBM2QbehexhXeQEHWGTZlhQEAi2Zasbb
	yYZOA1a9zmtpl5VwhlQ6cG/Ejnmc6cQ/peAUhVFqfuurFIlniJFF4iuKqqs2VJLeejRsSmTCE=
X-Google-Smtp-Source: AGHT+IEJ7/GQjIJ8a3NA4KyGRkuyn9vgUV3mwJPnoJEon1LkO6JSyWYMzFikNiMiab6ZLxTvVCA++g==
X-Received: by 2002:a05:600c:4ed0:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47a8f90ea5fmr90660965e9.30.1765714235453;
        Sun, 14 Dec 2025 04:10:35 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4e9sm158768465e9.2.2025.12.14.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:10:35 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/3] mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
Date: Sun, 14 Dec 2025 12:10:29 +0000
Message-ID: <20251214121034.4352-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21019

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
index 86bf13fa8bde..c7c94caea3d8 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -16,6 +16,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
@@ -258,6 +259,20 @@ static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
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
index 7283252aa07b..929f92d17ac4 100644
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


