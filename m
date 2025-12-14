Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C2D5B172
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24312.1765714236916408834
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jX6fFCHe;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775ae77516so30393015e9.1
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714235; x=1766319035; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFpN1Fcgl0fqXLmrb7UUHVPeZqTzvyHJvB+sneVzmAM=;
        b=jX6fFCHeQYDbTb1YDFk7htgPEgQlgHMN3n4NMw0Wm1pjT2UoO+AmI0r+PnjmYsD9SU
         e4iwpg8coUPwBSQK9f+bl6Cgl2vqDBCtZJq1hrLZQafKwd9qZDi9uc84IBoS88WFPZ3k
         fFrEUS9bQwG+sW9eAqIekOoqx6YlotkThfEDNKmrogCOkU9RiGezW8TmS3pOQfc10nSM
         ehib3S+DsE/9Au4bYttXBn/mc4zdbftxUcFyPQPa1EMR8BRkHzVUBfyYwS3BB9W4jlpi
         3V9zRXfKh46pxO9gAjVUOnHWIDz2FXIn5HP5GpDBQkECf38MmdKu2+WUu7BhaSDJmI7w
         wg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714235; x=1766319035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFpN1Fcgl0fqXLmrb7UUHVPeZqTzvyHJvB+sneVzmAM=;
        b=Aj2sppDUyXMIkuQPT4oSDK76NWT8PkjXns9Jhpg3fshjl3AzTxJTc58pGm3LvFQS2C
         +gB0+H7qxAnD3wdYzB+Lpix6GgsKEn9j4XAyfO0IQ4CmdAYtjRUxlISAghtuk38mI7VS
         TdCMA4kr396N3/YIPVManPwGxT9VPIFeC1X0LvZTxfb7dKJnmWuSH1iTxpsw+Ecjiryo
         nPLC2UEsojq7JKW+8TOC4tsd2jRjDcx0Ob2fktIVFzwtdpVY5+miZ5p2GUJononrNMaP
         cIxe2u1HLcBTM42sCLE5jo0aQHPzDxXpJQk3PkD/NDfpbZ+KKEadubY8hEMFMTBz1fte
         0/0A==
X-Gm-Message-State: AOJu0Yz4FQ+mppi1fU4XMtH5tdRg+Aj+L7QXMdtR6vywsRjRLTc/YxS4
	a+Nea+fu/fyg+U+Q1Q+XiolU20ZIlYJOo383m+Vknlyu2dA6DJsbbAoTZLM2IA==
X-Gm-Gg: AY/fxX4GFKwO31Ayy/atakap3SmUJDIbGxXnWqhve9s7ES8aSM/VwWX8GmFB8rV07Cm
	n7HX90mmtNsoJiHUO4jNcIroIeqOfnKKvtPYgocbp6RKjSWykzSCU8Me2/ME9rm42GCVaRBJNxj
	ftAsg9jY2gJIubzD9NrGWxh6u3ZcP8eXdJl7e1N467xmz/BHXe8eqFg/5GF/7lbI6cvBRDI9t7z
	lHQ9DECO5CCOQfpKcDkLk1C4cZ8oQrFzsP8hfkbwVZ279l48LymFaeJsVuu8dINcXeMyynVh0pu
	a7TnegHZwO6333gef84H1GXOK2JWqTsBVK/dOj8ejQiMPzTnZduU5i6YxRPsUa8298mX59Q/eTB
	5bDyHKZWANFUSXNbHmBC88wElN52VP1ewdtnzVUVyh/Tu2qN63W03169zEjvTjXSa9OfEOoZHQD
	j0eWNUz/HZDIEpeU6T0d8cIO98TrFnknEF5K4bd9TbwUt4ylssi0RD5m/zLw/9mZBIuVs4Jq8=
X-Google-Smtp-Source: AGHT+IFxKP8A0RIklbNoivZPvb7KazvNP7MBsS9LhyhG/Qlt8GhayqhcTUxtWiEoW6sfBhjsXM9xCQ==
X-Received: by 2002:a05:600c:4711:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47a8f90d1eemr79407265e9.31.1765714234941;
        Sun, 14 Dec 2025 04:10:34 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4e9sm158768465e9.2.2025.12.14.04.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:10:34 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/3] Add 64-bit polling support
Date: Sun, 14 Dec 2025 12:10:28 +0000
Message-ID: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21018

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
 include/linux/mfd/tmio.h                      |  3 ++
 5 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.43.0


