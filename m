Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D67CF65C9
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:44:15 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16762.1769420652290153247
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:44:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hch9kg2C;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.65, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4359a316d89so3190130f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420651; x=1770025451; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRsRv6UzAL63b59+AdF1m5OkQvVhBSeoCa0DUhwb6LM=;
        b=hch9kg2CqSCThZMdPWDj0b08GDpG+f+JY01YtHPvX1o7HEFHWVGBgXsHPrSg0XoB5G
         pJlcPJjFkXNXB4k5lCsQFGSBhMvkThWDRg9ZF/Deq7FETdSXBIz4QOuD8u7QHsn+6sQI
         ekXcZhP509yQXOzgkmoqWehQQlL5XYFBzG7U5EJ7zegyEma0l1VM43Y1/vPsZSAhjHNP
         e664o6KNcRQKg/bP7gq2zm6hojY+FquEOhiR+cKJDrVadQMm90rR+BrvMR/DA3PY6T6s
         exRdKK6NSc7RjLiVwEIw6lIvnetsS8K/N/0LyjjyCo/mR8v3bnet8FjUz8IO+jrF3LEQ
         +TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420651; x=1770025451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRsRv6UzAL63b59+AdF1m5OkQvVhBSeoCa0DUhwb6LM=;
        b=UkXV6JSQ0EnLePjKRH/cJrwBedJOIqfmDqzmx+8c0NzMjCLNg6wRgzwnpcdqcgaabM
         mzSq+rAVhgEu+MSCVJ8BLj+Gi5ig/pK+uoVsO6OX16bwVgZmcu62ZEAkMexTNzF532aA
         1sk1UhTG6ZQphB8Jcn0NndjUFRb6QKn89Evy3yZsTERN/XGQ0MVo1MReZYbw3S3lW+1W
         h84UHsTlcm/UufUQ/TenqZsAA/buXOsj3CGWYn85K5aDARUWFP++a5H2suzvVDbyi9Fu
         bKnBAxjT/3v/Itn9VIO52HXa7NZD6PAmZ5Romoblk2dbnBiwbqMhrf+DA6xjO6LOt7W9
         Hs1A==
X-Gm-Message-State: AOJu0YztBQJH0x8bhxyPHXCIZxLfsQ3hrvimE7xma/iWC7IbY7WAw4/p
	YP7yL0xvu/6dVzM0SQ4WXPY/V5LUcZ6gTDeTRZ77hydNMgWpHyeTQqL8C3RgKlTriPI=
X-Gm-Gg: AZuq6aLk37FTzXwxMZxQ4ZcrhvUPQag/hJDTT5JdFZgcCkiqpKD3RDsOaw4X6o3hwF1
	AfMpCuT3zbmJKm5kw3TbhzN+cnLLStigI9YtIsziUV8p2zsS0hblw4XbKIgcpQE0LVDP8WmIWOX
	6XqdZEr3k43fCBeiz3QMhYfuIo6DpHdDRevmZa4dMNaYfWsIiU6td28Kmr9dixBuBl7TaXjrt92
	4a73r2ouHX/257Y2543b6tTIun0XRmpMtzIn8XfupYuvmYvKUbq0u2JWOYupoZlYqwE0TvRZr7w
	1b/GEmLTlOqyVq3fRF/gVLDimUxC3bx9idB3/Y3OlgmurqHgJaoFFbWQtyPmXuFc6ULMf1trmQk
	QMBIOicK7zGTGVef9kHx6shSz1WcE8iU7PMA1RD6fWgP9arg4bpn6phv6ul4YSSaaA1IvV9q/YI
	BSIzOb9rAw53umabG2ywZejq6eTfwurYTgm6nBZ/4=
X-Received: by 2002:a05:6000:184a:b0:430:ff0c:3615 with SMTP id ffacd0b85a97d-435ca13d0e3mr7845728f8f.53.1769420650574;
        Mon, 26 Jan 2026 01:44:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm29675520f8f.32.2026.01.26.01.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:44:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Date: Mon, 26 Jan 2026 11:44:06 +0200
Message-ID: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:44:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21716

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports patches to control the reset signal of the Renesas
SDHI IP during probe and suspend/resume.

Thank you,
Claudiu

Claudiu Beznea (3):
  mmc: renesas_sdhi: Deassert the reset signal on probe
  mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
    and pm_ptr()
  mmc: renesas_sdhi: Add suspend/resume hooks

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 39 ++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 12 +++---
 drivers/mmc/host/tmio_mmc.h                   |  2 -
 4 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.43.0


