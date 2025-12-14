Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A60BD5B171
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24304.1765714590888676838
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A7O5Hl3i;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso11212655e9.1
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714589; x=1766319389; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQM4qZCuQ3K0iZMaG2mFgWr2wMK0Gql2Plrrfzp9rS8=;
        b=A7O5Hl3iT4CXRDC38lWipZOaHuZKFSxUBCaEaf1ddcgj6kIKPx5cxMBJVSRUAskdjD
         DXhMbIpX8GKzFF+99UEDnoWLX0i7NNmKGeTINj/rbZ5AOGj37eJPfQhHxfG7P5uN38y1
         abdyRQijOujJYOeJrj4rYGBx2zZF2rKoQMSfXC24rJNWzhaq/QdVT9E6YidWOcFhtDK7
         d2FBYr8LI0g+xxbOivSupJ6hzJfZ+NGC6Pj3bupMsrWtyEl8XNbCOh+E8QNxcVjbbVTV
         xWtcZBCX2YmHe79fCRRePjMMIgerJ3Zkgmiqz1D6hdfXaLXIXOKtAkoVijUNZR/C1lB6
         +IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714589; x=1766319389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQM4qZCuQ3K0iZMaG2mFgWr2wMK0Gql2Plrrfzp9rS8=;
        b=ww2DtXCsHgxOKze9ADExgQ4sjSjnvMq3WpyuDf2sO61flXI92CZL+gu8vemoUL73tj
         0ThAIdW5ycjYEtm4WNbNJXwp3MCk4/H5XrT6lRki3dsjVrY96vdwPpElk2oQ0IZe9hfe
         aPqLZcxPFVpksSjWcEU+yysoovxpnzk2g1H8afrL0InzprStaQcu+soyQMFyqjVL+6hL
         THQFu1NcAVIG6xgsG7vzvWihbF+un5d7ugMNPsRGbAnQSYPUW5PLTfjVJB6mebsqy15x
         qLaEqjc2SW8g+/MOMybZAMEG6qMHn+eiCpqUvQ91sMP6E8nEi9+YOZJ4nvY6xwzqzf02
         rlVQ==
X-Gm-Message-State: AOJu0YxgDiAApaNc3cFsLVmIt/4AOllWKjPtzEp+CwxrF2b1WDviB/0K
	qCj2JhUZuAq3nlPzEsYeBY5qWF5fAQpTxOUvEpx6gIrh9hQXKcclEA/s7bh/dA==
X-Gm-Gg: AY/fxX4CsrV/eePoOXACw3CRONXY5TmJELA+OfGk6s3XoKqPPEqJKkZiviwqt3uQakh
	pnu7kpVZ1kaAdxFVcFqedFEEKxEXZ0+M5OMbxfJJZolso8E6gDzIZKsIasGKNv8e+0gJZBmaaVB
	NrvYYmVLE1R3ztTC010HsVtnrZU1QRSyxfELZkUlJzbIYbXQ9TOHYGw9/lBr0eSOMqboDg7HUFg
	aaZvbHvXCKAuDZlM5Vs4UR91/vkH85wayQIcZ37hYmI0Hh/ungYDTRVZS+NP/lJBfGmnTHziiPt
	tVTwhyNIG79lyGZ6e6kmzgMnVClKqcHFpI8wm0MBKgyK3wSJCD6H83wupANlySKjIceFKAG8JfE
	S134FtWaU0FGWgBw+8Mtpo5iKZKpprRJM41lqByIUD8XCixD4e/BNCKIYnoxt+H/ElY2g2gcFsy
	A++xz9FtFW5M7cQZGACLrh1T+AKo0tsWqyWNT/h0e72FFyG2WBPXrNppCooQjQ6nOU7g6HV2U+n
	hYzS9RL8A==
X-Google-Smtp-Source: AGHT+IHeUTS6MbHK3GcTEtpIgwSjVpbJeI5OvW5sdxP3JAArMGvJRRllagoTkgnaOEmRSV/soxrsvg==
X-Received: by 2002:a05:600c:c172:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-47a8f915c34mr70509305e9.34.1765714588922;
        Sun, 14 Dec 2025 04:16:28 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3352a0sm49112485e9.0.2025.12.14.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:16:28 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/3] mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
Date: Sun, 14 Dec 2025 12:16:17 +0000
Message-ID: <20251214121627.4656-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21024

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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h        | 15 ++++++++++++++
 drivers/mmc/host/tmio_mmc_core.c   | 33 ++++++++++++++++++++++++++++++
 include/linux/platform_data/tmio.h |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 41787ea77a13..a7263eb10450 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -16,6 +16,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
@@ -242,6 +243,20 @@ static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
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
index 45a474ccab1c..6b12607fd167 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -351,6 +351,39 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
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
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index b060124ba1ae..426291713b83 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -47,6 +47,9 @@
 /* Some controllers have a CBSY bit */
 #define TMIO_MMC_HAVE_CBSY		BIT(11)
 
+/* Some controllers have a 64-bit wide data port register */
+#define TMIO_MMC_64BIT_DATA_PORT	BIT(12)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0


