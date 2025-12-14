Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA7D59D99
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24305.1765714591300262554
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CVRC7xYJ;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so26476715e9.3
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714589; x=1766319389; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bD7fo6AkoFMBFa79fGCBETtqzNmFLSJdAfeTCdA3lg=;
        b=CVRC7xYJmSXgqyi1dFuNZhJF0eFcX8Rjv8/WKDpcbzMrRqDcW7Zuwayu1nwL91n8K3
         /HG5/5TBWI23GkCKDP73UkgnSPG5sx3qWOYU4xo1ayo26fSLw/Zqet2tqzpKMtTSxWIh
         cWXGZwYYJ5a9H5h6Cs5B5WotNtjCdSVTNjt0981YxDtJ04SdMIu71lVzLZMAD28uGJhf
         T3lPPLfnuDZC96dU9fZ6IG490iWPJf6VSzwgSOaQBIblC7a3F6t7jwchn4bTRgmewhrp
         Q+zQ9gH9wbk2IsBAaJnoxPhWT8DYb2Z4xS76UG55Dk7lbgVYg6RaNPxl8BkasjX6vsEP
         wfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714589; x=1766319389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bD7fo6AkoFMBFa79fGCBETtqzNmFLSJdAfeTCdA3lg=;
        b=HHOxxCc5AF+4h8h6BQr/PG1XihYxuFCnlFSsSsn8VuKys3+rw5c0IbFQl6dgDVVsib
         TAiWXsQUaNHdKiqz2f3G01ifkhfquMnSqy2EGqlO8AbE+kNJlEFvkJZISZJbU1CR6Uic
         +PhhDAH3AOhqOJd9+l/M5huAONFDCPzPcAPreNTK/QFa3UBh0uuxEjxoLHJJ1JBLh/XU
         CvVMNnAi5meXfX9xJfGbXezfa4BzPXAgJOJUtpy8HYxDNTPSNRb+Erwh3wiJ6P+KRDwf
         WHVzlNv3ezOBJYVBd9yvXDiGbPyE6Fkmo5pXgJX4riV5a0Tb78E1zTB10HaPTw43RhFD
         NpTA==
X-Gm-Message-State: AOJu0YzdQaiHFIQZipDcNIaCQhdMpU3slzcc3/2TW6Sq5U/STk2RzWla
	Yiyr6O58z3YAW2np0lz6Zw2d48r9BCG4Vn5Chuw6L/bsSjLCENblwKMZLkPN3g==
X-Gm-Gg: AY/fxX7/3jFjTdyB5l7hVk6ovVItJHWXee4RGgdDjy8bKBKoZEk34ecDwsD+K7MxU+s
	XZl++cqAGxc0TQ6Dckb2qNEFKkMg/c+42EdizW8yzQjlK26zuYeZcnTutw6ZECetWZlkWrVEsyQ
	7Xj/sVvW6SKV4TWkWBoYtZM6PrdM/AabepCE2qi2n5N2/g5xmsbxFnHeJsyLEJkWRzKU05+M9kB
	pEyfyfZA4ZaamAmODomDV0Cc1MLhDWRt04680Vn8/SrCW+q558F7NTNxxuK0jE9ZUToIrwwyE3/
	yP2hUBakHm4DdBHtzs9goPRQ3+HmHaypOj9+4L23fQmduN/wopJiTZJR0b+k2yItV0DlYfTzgb9
	CNkphS15k9yLyagWjUr4EUKH1E0vGFIef77Dm1F/dotBQ6riiPHAtBGymiNQh0qX1m93T7NkFgZ
	GQjYat+AwaQafKkwLepvZda8LWPO2nN/ZAFXNzjy+21uSDtcqR1+gLEmn0fC9ggQZhiwTmomU=
X-Google-Smtp-Source: AGHT+IHsdj/uIj+b2bL19iRbWkuFmFdpdeMdRuBte2ztDJkzhiYGWorFghib1weSWlTzGQGfm53cyg==
X-Received: by 2002:a05:600c:470a:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-47a8f916db9mr74967545e9.36.1765714589378;
        Sun, 14 Dec 2025 04:16:29 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3352a0sm49112485e9.0.2025.12.14.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:16:29 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling mode
Date: Sun, 14 Dec 2025 12:16:18 +0000
Message-ID: <20251214121627.4656-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21025

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 709fe7aa5aaf8047b528561a0082db8a3a29010c ]

Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250730164618.233117-3-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1dcaa050f264..5652979e09ed 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -107,7 +107,8 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
-			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
-- 
2.43.0


