Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41325D24473
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50470.1764872059439534384
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rC0bN2kP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477563e28a3so10052775e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872058; x=1765476858; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moTaCw6GbltjBRMoIMz0q01myZ+aIhhd5b9HQQvTUHc=;
        b=rC0bN2kPBrfPI2AJwWGI/qhrPoC9hjrqa9uTrpvqVKK/4jxDvl4An3KumqzBmUr8OO
         W6cFxtnskUYUXlHFq/hPRu02wxr3BRct+Ws9utMoFYk3pRzit8+9z4giEdBwzChjfWff
         gpoT5eb/du3WLgAJf1fBwD3pzSWXWMjCnLYMLF63bxTDMW4JYt6AIVNbMqk/xvvmzFgr
         3jNzAnfvcYMlwlrid1sZ/bE5OVOkkxKReOtBqM+GE0BHGzZvIIPlhz7geHfjevC/p84C
         1bwrNGHbIxg3O9XBrdzBkI+tQsjTei2NCdEYo/wm0ORwaLdGhiUaFvP2O/xGQ4xLNNtz
         +Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872058; x=1765476858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moTaCw6GbltjBRMoIMz0q01myZ+aIhhd5b9HQQvTUHc=;
        b=NVsyZ3eFn1la6ZItHVighiqYF5WhZUkwoXlTLK82BEOYs9vAlqVL6VDHM33DatPaqN
         Kyd/6nYsvg+t6oEms3R3jSxZoD6ZyTEoE0Jz3YjvlP7QYTslpMUAJzWZlNSNNBAEcW0Y
         61pCsW5OZAnipgykpM0++XQKGj0BWlvpwfkxjE/crZhKXgi+FZ5hCoo2FSFTAowRsxgx
         Aep+sQK5lVg1ccetFWpR/MWOpWNaulEixsYTSEaIvjVnBJj7emK5d/pGMAQReFCQfCFA
         FBk7djhh1wxjcRLOH2xIRsedDXbymJCKk5mwXqQ1MAirEzypzxGoq6RK9AEnv/V0vzIk
         lBiw==
X-Forwarded-Encrypted: i=1; AJvYcCWEdjU7RjqXnc6xArP/9Iy2a9oGbxD0L7ugzALkYeaGsBFKH8WB5JgACPMAjljuQz/uNAadj2sk@lists.cip-project.org
X-Gm-Message-State: AOJu0YzwaKyg4QRKFYP7hulsvnOTx6yC/xHZwJyhZFSo8Rnm3Wt+8poX
	2i/DuGxJpWf0b6yEJjCQZDga+G6XUHPhhJ4jLtm+d5kgmShHorymw4J4npBzMqfVD+4=
X-Gm-Gg: ASbGncv/Xi1q8uIv6XazAvgH3hgcOdOW2ShlPF2Q8saHHZv9qL9gD/8EeHg24AzeRPv
	zjrpUk/e5LKXngHUPXrn9Fcs/HjpVIIbE+c+k5E9cc8A5GX9+RtFWcykj5UROiYmTnSGxo0nmJx
	WV4iwYn+Ucotgk3VPa0YqdtJJQRZsBLqUvKnUzwvo1ol7GBZCRfcYvjuRj0pTQEGkIaNco0kaj/
	iTuPtbWETZXSKQNptkGG0fq/NIFg23zC1a4M7T3+B/9NtQFDErf4Q040TZm2mWv1idhKd3NWhBh
	k/Z+WVrs9P6Yz4fjq90OAUise1RXUqMIxE/k9aLgHpcUfhppxRp6FOZ2bQ4p8Dooki+sxTQxoxU
	0dqUycBLv5LwvsPCq3TxFQ/gYCDx0tBnZL06j7PjSsZb4sDSx1Aa5cCgtd0ahxxi8aCO/d0vHKy
	6xETQd/ee5ORdRlc/I+rcMorY5lu4ggIMDU3c1iM1c
X-Google-Smtp-Source: AGHT+IEQkP7i2iO1+4Wkd5VQGd9FAzQUUMdy2T1wl+AkE9tRfYMvVb9VYeMrKSKfJB2yI5RfG9SN7g==
X-Received: by 2002:a05:600c:42d6:b0:477:9d31:9f76 with SMTP id 5b1f17b1804b1-4792eb5d657mr32400115e9.12.1764872057669;
        Thu, 04 Dec 2025 10:14:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 00/18] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  4 Dec 2025 20:13:57 +0200
Message-ID: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20847

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the MSTOP (Module Stop) support for the Renesas
RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.

The purpose of MSTOP is to reduce power consumption by stopping
unnecessary module's functions.

If any master accesses a module that has the clock stopped and the
MSTOP bit set, a bus error will occur.

Due to this, to avoid CPU generating synchronous aborts, changes
to PM domain specific code were needed. The changes backported in
this series were adjusted to be executed only for the above
mentioned Renesas SoCs.

Please share your thoughts on this approach.

Thank you,
Claudiu

Changes in v2:
- dropped patches:
-- rpmsg: core: Drop dev_pm_domain_detach() call
-- soundwire: bus: Drop dev_pm_domain_detach() call
-- serdev: Drop dev_pm_domain_detach() call
-- clk: renesas: r9a07g04[34]: Use tabs instead of spaces

Claudiu Beznea (17):
  PM: domains: Add flags to specify power on attach/detach
  PM: domains: Add helper to check for PM domain detach on unbind
    cleanup
  PM: domains: Detach on device_unbind_cleanup()
  driver core: platform: Drop dev_pm_domain_detach() call
  mmc: sdio: Drop dev_pm_domain_detach() call
  spi: Drop dev_pm_domain_detach() call
  i2c: core: Drop dev_pm_domain_detach() call
  clk: renesas: rzg2l: Extend power domain support
  clk: renesas: rzg2l: Postpone updating priv->clks[]
  clk: renesas: rzg2l: Move pointers after hw member
  clk: renesas: rzg2l: Add macro to loop through module clocks
  clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable API
  clk: renesas: r9a08g045: Drop power domain instantiation
  clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
  clk: renesas: r9a08g045: Add MSTOP for GPIO
  clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
  clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL

Michael Ellerman (1):
  of: Add of_machine_compatible_match()

 drivers/amba/bus.c                  |   4 +-
 drivers/base/dd.c                   |   7 +
 drivers/base/platform.c             |   8 +-
 drivers/base/power/common.c         |  29 ++-
 drivers/clk/renesas/r9a07g043-cpg.c | 132 ++++++-------
 drivers/clk/renesas/r9a07g044-cpg.c | 168 ++++++++--------
 drivers/clk/renesas/r9a08g045-cpg.c | 139 +++++++++-----
 drivers/clk/renesas/r9a09g011-cpg.c |  92 ++++-----
 drivers/clk/renesas/rzg2l-cpg.c     | 285 ++++++++++++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h     |  28 ++-
 drivers/i2c/i2c-core-base.c         |   9 +-
 drivers/mmc/core/sdio_bus.c         |   8 +-
 drivers/of/base.c                   |  21 ++
 drivers/rpmsg/rpmsg_core.c          |   2 +-
 drivers/soundwire/bus_type.c        |   2 +-
 drivers/spi/spi.c                   |   8 +-
 drivers/tty/serdev/core.c           |   2 +-
 include/linux/of.h                  |   6 +
 include/linux/pm.h                  |   1 +
 include/linux/pm_domain.h           |  20 +-
 20 files changed, 686 insertions(+), 285 deletions(-)

-- 
2.43.0


