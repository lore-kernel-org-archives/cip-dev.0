Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF9CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:25 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10056.1762416742289557243
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=er5BT9Oa;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso422407f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416741; x=1763021541; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CCAF5flrrhDTY1gnIyClfeB1x1TbjZnNI6l5irMt7I=;
        b=er5BT9OacofuE9CvkBqRtK9uGqxHmK9XbpvuwlxzsI1nrJo+M+YLWTjMaNj9/7O2fN
         iumwJTvYj7FuS07c82/uEA77DTOs2lcgxBFtIoohRjhvMjgCAxrghAjo6+wQvwVFjSye
         b7StauEVfpvSqIIYmDqDT6keh+HECK5z/2gRkdqE+OaFtkeriavzWnJ7c4P2YY+tY4A8
         XNzk4HUNia15+sEuus+ysAzFNVQ3cBEvbLH1gB2b9a7a5i6U32p0+tpCQzx/LFJWEasA
         wfoRTo0dQvSMM2af2TOsRyrPFOaE3FHko+eXPnwUtp7Sx4KfjfD37UjI4RPmfJEGvxpI
         kOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416741; x=1763021541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CCAF5flrrhDTY1gnIyClfeB1x1TbjZnNI6l5irMt7I=;
        b=JSjlJuxM6vUwmzlQHH4FF6djAsuLkXiPnee8EdP9TdV5H3wFBzbFFd6TnDaEMSDV3a
         +rK9P7UejJ1X67h9podWQqJzYtJny6UhNGoInIS3GFaTZ4Rl4W0+PQK1g5GjiPFl+NvJ
         N4c7HK869W4Dtj5PYEYNO0r9pIyXx1DSYhu2fKCPOdcUMQTEjc+OO2c4UeWwlH3ViL1N
         22+Z7wJxQnx9G+Hr1sCw+gstDk2G0uLtSNrIyjfzRjZfzqZIk6zQiB21grPZmyJ25n50
         PZMRqhCT113kGX+VngnfQLzYmlkqyvHkSZQag62LnpjYDQBK1yaen88saVbq+B025NDR
         1CfA==
X-Forwarded-Encrypted: i=1; AJvYcCVv3J5eUwDsVHf2O8r4xELCz7x7wvx+62vlYbd0tyICJmGrfQpCuY1OxAsdwakdPwlEpR02iWnj@lists.cip-project.org
X-Gm-Message-State: AOJu0YyfnFsbANj4inSVq27Qg4v4Rbd2QYnNN+ywWQDBwUdzKkxHW7xP
	IROXGlf6bqDiqu/ac1Mtnfafd77palt5mrHGsKefifzV66mIRKnfsyyDtGPlN7pRvw0/kcnyej9
	II9KS+OI=
X-Gm-Gg: ASbGnctIQknyfMFWMir1KyBMjO4QDJRYu4F1B76rgmbKVSz9V+57kOujWLsF3NcDMXu
	E5/i+S2U5vVpiLl5hZ1aAtiNJ60rjVfk8m4hYEcxipGpH1XLMYpTcIzSQQlMDjZh1BaLo0MFDyu
	wXvdsSv80AjsM/TnFkJxNNGKCYQU6d3jdKN84f5tgb5qAYjkllwD37oabBWH0BJWOU5rccSukHM
	6o9uA3AbN88tnvsPVVE0E1xJEP+1T9rhTjdHh9cwYXoN0gpBV4dqAfueI39HGijaid3pxNqQdJm
	BMlRZdv+SStOcgufvpxfYsRoDftNjfYKJo9YuIX66Xy/InA+RN15PjGsRrQeaxL2kUwK8o/sKty
	or9rp3MqBQ+Q31sBuIMYlZPTDlfdeBTa+DB69mwiAEhbBLdEsSpcs7DS/4BDzdPRe2628e7+DOE
	2pminBBkI01NBbsn6WA82jxW/2KM38lA==
X-Google-Smtp-Source: AGHT+IHpdEwCkWF8UuwXm58D7PP/ZQlgy8l/ZxjSZ0vBf34b5wJW4e0SrJcRx0Dzo1ncoW1hDAuHQw==
X-Received: by 2002:a05:6000:40c7:b0:429:ca7f:8d6f with SMTP id ffacd0b85a97d-429eb16cf27mr2197981f8f.15.1762416740684;
        Thu, 06 Nov 2025 00:12:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  6 Nov 2025 10:11:56 +0200
Message-ID: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20417

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

Claudiu Beznea (21):
  PM: domains: Add flags to specify power on attach/detach
  PM: domains: Add helper to check for PM domain detach on unbind
    cleanup
  PM: domains: Detach on device_unbind_cleanup()
  driver core: platform: Drop dev_pm_domain_detach() call
  mmc: sdio: Drop dev_pm_domain_detach() call
  spi: Drop dev_pm_domain_detach() call
  rpmsg: core: Drop dev_pm_domain_detach() call
  soundwire: bus: Drop dev_pm_domain_detach() call
  serdev: Drop dev_pm_domain_detach() call
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
  clk: renesas: r9a07g04[34]: Use tabs instead of spaces

Michael Ellerman (1):
  of: Add of_machine_compatible_match()

 drivers/amba/bus.c                  |   4 +-
 drivers/base/dd.c                   |   7 +
 drivers/base/platform.c             |   8 +-
 drivers/base/power/common.c         |  29 ++-
 drivers/clk/renesas/r9a07g043-cpg.c | 140 +++++++-------
 drivers/clk/renesas/r9a07g044-cpg.c | 176 ++++++++---------
 drivers/clk/renesas/r9a08g045-cpg.c | 139 +++++++++-----
 drivers/clk/renesas/r9a09g011-cpg.c |  92 ++++-----
 drivers/clk/renesas/rzg2l-cpg.c     | 285 ++++++++++++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h     |  28 ++-
 drivers/i2c/i2c-core-base.c         |   9 +-
 drivers/mmc/core/sdio_bus.c         |   8 +-
 drivers/of/base.c                   |  21 ++
 drivers/rpmsg/rpmsg_core.c          |   6 +-
 drivers/soundwire/bus_type.c        |   8 +-
 drivers/spi/spi.c                   |   8 +-
 drivers/tty/serdev/core.c           |   8 +-
 include/linux/of.h                  |   6 +
 include/linux/pm.h                  |   1 +
 include/linux/pm_domain.h           |  20 +-
 20 files changed, 705 insertions(+), 298 deletions(-)

-- 
2.43.0


