Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DED5B176
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24255.1765714237733373305
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:10:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PcwZ6ayj;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so27465685e9.3
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714236; x=1766319036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vykkFRwlsJZY8J7Rdp+/Orr/vycAgJdTAGcoT6qTt5E=;
        b=PcwZ6ayjQ5g3qINXf64w/6H4EZ+3723OhjmuSVLJNeeUdy6Vv+2oG2ufaR7rRR3krz
         0b2YbAJ53yh8CjP855GRurZQj3E3p6iqNIzLiY6tPyEJgQWckaBnPyqio4vdfyWdXejv
         Rkaz3gGzMwb4SmPHX5cJB0Lb4aHz7r8LE9538QDhSYz8bG3n3I+6NG6+QPU6W+jKmNOj
         bksCjFSc4REETesxvzSZnkrosMyJ5ADNjuqa/ioRrI+QuwTzVn2XTBwc/s0P5Ceqnf81
         PiELIkCFcRroJ+2FzvjbazyJpJzznbOJjNzhUAjQ44fmpGmmsDD23DgLMcb6QIrgyTEx
         sHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714236; x=1766319036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vykkFRwlsJZY8J7Rdp+/Orr/vycAgJdTAGcoT6qTt5E=;
        b=HtHlKnYPJ0/cLLoDJyr13gtXYDuhKAWuzmUbxvoDcWkOblGGYn9EuwB2qGzBHLHQCb
         s0rkmLDraWBYDg5OVD8fUkDOvtQTjsS0KMzkaRGmksjWMPLdjDm0QbDbpHKETJ9lyL5/
         OpckMzMj6RDp/E1M9WdOZdvcgr+pxjwOyN4Wbx+1AvHz/9zhtfCYGV+oSGD7sE1Lpgoe
         /Ef2HMqPJvYOfmB5oI8DY+oMIm/xKrLXHhjC7Y7OPkgWltLGaFAk/ihW14SYbLhw6hd5
         vSpz1/ekI/RZyFZL6MWD3xbmOParIu6ATqvuZEvR3GE9CUhWDvoyCpkOrimQDvdtrvRR
         6W/Q==
X-Gm-Message-State: AOJu0Yz7opaPAKfFgO670ty3iqcxTyaVhSfip3VqeZdDtsdRYtt+6jZC
	gu/86mrskSBcYJESCf9F9WQHHae12CHQHBP+esdYK8hY5xPdFq8n9SEBal/KyA==
X-Gm-Gg: AY/fxX4lUZyXoJXhnLC1ZgCVVZmCNHTkSJg1CzUufrkoPmywIdXEeueD3MoTM0uhnJH
	mGY9ODo+Vx7VanI7tskngu6sC5oEWc58s8dtYxpMrfztd3wWxAXX7RXSTtge323Dv6STsU3bk7T
	aS6d0Khjdce6KB8EEcxH3Dn+Zadkpc6zN2px1X12qaGsRzwu16PiQpcCgRjugjBiYwhQB94HLeb
	8E3n+P1Mn5OHrvwK6G183Q/DE/QHlEoHxDEZ1MAhqnUsmbB0MrDnIg63/Gg120LosgQNjnjn60b
	/q0uuapIXt3aPaurNOJ2W+B62Go+++KWyoJYQ+MYDrX8RFjhQqVKLriMiL6G2B92RmEbl9LsKVr
	1BoX2priVkeuGJ7ZvI81+JZjuuhjHAXl9qLqDjAdSN/cnRYYkrC8EMA54vSP3eCq36edjj47PL4
	RxRlNdW98wM8ohJlX7CvaUwLd04JinSGk8DzwhvzxcBdAuB66h5fcPI6lftWWw1wzWwl66Gyw=
X-Google-Smtp-Source: AGHT+IEVKVLwAcPlFyf/FFfrb1Fn9Bmk9Sb5cdnivN5kdqPOjbENKVUKO8VY/nkFdO0qCgBhYR8nug==
X-Received: by 2002:a05:600c:46cf:b0:477:a3d1:aafb with SMTP id 5b1f17b1804b1-47a8f90d757mr82595155e9.29.1765714235875;
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
Subject: [PATCH 6.1.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling mode
Date: Sun, 14 Dec 2025 12:10:30 +0000
Message-ID: <20251214121034.4352-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21020

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
index 56fa2bc7146d..6044e20ea36a 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -106,7 +106,8 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 
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


