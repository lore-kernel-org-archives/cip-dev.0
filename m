Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB28D5B173
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24386.1765714590479016724
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:16:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vghs3TWW;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775895d69cso10159775e9.0
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714588; x=1766319388; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X58vvix3iTedcnZETlrW0C32vILbQbjYXzFGL+RXfbI=;
        b=Vghs3TWWQI6zfm5ALboaEoc2uZn/e7D6MhnqIg6AaAZONsdQOng8UZvhh/9fORs7s6
         I3JZr1pOifUSH5SmTf/hIVPseapgXxzz1ZYVjYw42MDWJmLwoWRC8NUKyFU0iAwzxXmL
         2UBTgNXANQn+bzW3KbQghpLo/j4x/nkfaB8ljtXokPtTSpTZneXlF4rB+iAk5pqwejuM
         aHlmk4VqHooAat7JuQY8Sb3R2yxO+ZK1SGbD3bDsQSAAjXN1/j+VzEQ8zLrTcU1A3qoK
         WxLijdsuWpDmYpRx5nT09q27D3KPqUGr4YSEfHdmF6nDdoFINTpfEm7dQFU2LePXh7mm
         oZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714588; x=1766319388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X58vvix3iTedcnZETlrW0C32vILbQbjYXzFGL+RXfbI=;
        b=H2M9cvRYD90tQiYNDPzOM4kQq9LZfO0d6QaPIXeiLOGPhQJ8DyLvGI+pbEX0qg0fPx
         F+qiAqOfb7DeRciAwVjFP4mzih4PF5Fs4kE8d8PmEk7e541TVfMObrXh3ixJbIMOov+6
         agGPSRsVMv9m6AGmZUhIQYSZHPmhC8BmO2r/1wqj7KgVOj2I1/TO8Jr0VhzkVRYORHWt
         o0NntpTsQkfj9n3pHcBrVoLKNxnrhApoHnid3UFt3KPkcWN9QO98cFxNc8Y5ZgieZj8I
         bB4ovuO6jdREhdCNSpEWRot4cPwlvVti2q4RfBK09UHf0rggqIqi92IDPJGhUpduXXFv
         KHsw==
X-Gm-Message-State: AOJu0Yy8A0YB/JC1N4hVNqm36GEmB9R/Lk5f46aWQCBraSjelvNpwi5H
	oBkfCG8S4CLbF2KzBOvMBWNrvYb5855Sofs7WTlBDG4ouTg6Nv00HyLp51ht2A==
X-Gm-Gg: AY/fxX4myqzzPjRnyQg4L8HY538hcg9fxE8KuzeJ8CB+KKQZ5aTxbn4aV26W6OE8qAZ
	LYWCkarTOd0CYB6oG/OZcZlKyUr3V+hsdx6nq9lQ9NS0zzvDudubPO9FNn4049+TDeJfTtF1+NF
	q03iD59bko4JDKvWBSSMAfHXihGAWXrOetkJuCU7WNhmzL1tTkI30YZBUfcvJbeY+veqJMbvec5
	K0qKwxt39fYIvMPObglNQtKo0d6anafMOI/MW0C1Qlq/+9TMdOLI9a9YEouHuc8qrI1XiC96bHV
	ZpsJQanyOzfLhbbwlPXjloHpDybpegTibEpusiz0N69EPkUMUgv85/tgA58nyzP+qj/0nu4gmBk
	4Km28WYjvII7pk4lDnISACfUfWZ/xk/F0q9oz0544f9dlwBKesSSRoHX+NH0HjyNFiT3HE3695A
	xTwpA2XjVW3rSqYOMNkfpyj+sBLxrg5XQfK04pYK6QsnK1LjMWmCsnLhU4+gfujDupf5KVEEo=
X-Google-Smtp-Source: AGHT+IHywr5APX55A61+2cHir+sBea+nt3BeIYET5uIwRpowBv+N7ZApy3yaZORANxLNTS0g7wx0uw==
X-Received: by 2002:a05:600c:3e0d:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47a8f907acamr75334675e9.20.1765714588514;
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
Subject: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling support
Date: Sun, 14 Dec 2025 12:16:16 +0000
Message-ID: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21023

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
During testing it is found that, if the DMA buffer is not aligned to 128
bit it fallback to PIO mode. In such cases, 64-bit access is much more
efficient than the current 16-bit.

Biju Das (3):
  mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
  mmc: renesas_sdhi: Enable 64-bit polling mode
  mmc: renesas_sdhi: Replace magic number '0xff' in
    renesas_sdhi_set_clock()

 drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
 drivers/mmc/host/tmio_mmc_core.c              | 33 +++++++++++++++++++
 include/linux/platform_data/tmio.h            |  3 ++
 5 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.43.0


