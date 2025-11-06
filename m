Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E3CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10026.1762416696625546081
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hgIYX2oa;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c19b5de4so578280f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416695; x=1763021495; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs1agP/MiETOg6zQ811KfbUwc1MPXfWpwEHGghW2RHc=;
        b=hgIYX2oao7hf+JH524QtFX7b8kxPEix66c0xx3LnEVyJDh9hqq7QvgCNUXxobEhQP7
         vkr1R0J+OvQAYf5xSjCqgIz16M7CCLc2Gq18qAKCoP7xat50EnwPujfOD3RgYdnwVHqi
         0axeHHbxU/X6SZ3J7eT+qlpDOouA2GIYa73lvFM9yRpf1r3HmtcRTSBmBVNyucMtqvuz
         n7S65b5BBn/sC4xpJt4gQaVeBzFGQ96SMHaDDxdA+0SDF2JTqU/4/FZDLUeOqhQFYcmx
         dL4KaHNfhk/Bmk11zzjD6BJctnNMjWE1A3INnLDPDkbwAlOJB5/JY/Z+C1by39SO5iri
         XMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416695; x=1763021495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs1agP/MiETOg6zQ811KfbUwc1MPXfWpwEHGghW2RHc=;
        b=FJ6oeDHxN3SF72ef9hYd4vErXHlMLOJhRpteJGiqrTG//R14PghNGzxXPOR1CRpsC5
         iEBW7fAXvws425B5utDXTd5yDhjD9kKe+SkqpR/aYyKWOLcnZkLN4B6N8+19qWOXQVlB
         +aCBefqk1K9B/xPF6OjdeqqiDfqIJDl1cxEM8Un3ZC2WfQs0acK40QuoaaLwBU9/nz9f
         kmqWXMO5lCwpNTMtCiLEXzWaNqvvcM8tqxcRSyih6btsLrbIBXJKILvBps7DNekB2XEw
         yT5H4EVKDAhnow2M3SXpOwMBvIg71DlboAkqEUu5sZnDLfGG2UoRc/wMsM08lfskyQD+
         QV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8nr7k3t2u1TVvSr8GmHlaeZwrUo3ZN+F+8tv551JqUHzIKD7iFXRpSfFsdhds8VGg7MukMY0g@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx5oFMpuQXtgPxlbC4Rf+tFBhLAyXu8B7UU43TElDfgYuke4R1P
	AjnUiy7y1Rko8QszpSdnZGbNfNYkQuDe0JcXd1jTZjOhuI53iE5efbhzY+scx74U5VG9+j6zN51
	SiV7Rr98=
X-Gm-Gg: ASbGncvcmsNjoWChlhJN+c6259oMEpVYX8vNhmPFcWm43ar/S/e1azVilYGnIx2MM6J
	30jBycdEzgL20vbZkSc+WWha5kU0utP0g3MphBmksDQtL/3MtO0VqyUrgrLYJ3sxoenExxbN0xy
	A9qUimxydt8XaliUwaeWQD3INy1TIzTGh/hPRLTxf6A7QCAl23Xq8cDqj0PHUhCBF/XD8Ui76aC
	7pijd43F9B3ztcswLGmdxrwN8D2Q92no84/XXRbuW2p2bS/th6LR8icgDEnK5l0Wap1N5xFNzL2
	vaHvlW+NpSwPAc1K9/PhfIvBZWUpFhVZaQpFvQmvzNeY55M3g2ftYZJY1RcJya4kFp8n0mnpSdu
	p/r4LzhJTGC627GK6VshJAmwZPzbP8mDCoYdRSeUiXiPWeBAW7xie1Th9GPfOYvD2htW2luGXTG
	RInZuiujxqD5ggrVW4f/Xm5fJDppFk6KsHfN5AkLah
X-Google-Smtp-Source: AGHT+IH8b4Du7KbeGAbU+9El3lXa4ChapE1XFPP7za5WFMYUW8Sp8+ZzApqMErd0lPbd/b2bEajjdQ==
X-Received: by 2002:a5d:5f45:0:b0:429:cbdc:86e with SMTP id ffacd0b85a97d-429e32e92f2mr5465549f8f.18.1762416694917;
        Thu, 06 Nov 2025 00:11:34 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/23] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  6 Nov 2025 10:11:09 +0200
Message-ID: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20393

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


Claudiu Beznea (22):
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
  driver core: auxiliary bus: Drop dev_pm_domain_detach() call
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

 drivers/amba/bus.c                       |   4 +-
 drivers/base/auxiliary.c                 |   8 +-
 drivers/base/dd.c                        |   3 +
 drivers/base/platform.c                  |   8 +-
 drivers/base/power/common.c              |  29 ++-
 drivers/clk/qcom/apcs-sdx55.c            |   2 +-
 drivers/clk/renesas/r9a07g043-cpg.c      | 140 ++++++------
 drivers/clk/renesas/r9a07g044-cpg.c      | 176 +++++++-------
 drivers/clk/renesas/r9a08g045-cpg.c      | 139 ++++++++----
 drivers/clk/renesas/r9a09g011-cpg.c      |  92 ++++----
 drivers/clk/renesas/rzg2l-cpg.c          | 278 +++++++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h          |  28 ++-
 drivers/gpu/drm/display/drm_dp_aux_bus.c |   2 +-
 drivers/i2c/i2c-core-base.c              |   9 +-
 drivers/mmc/core/sdio_bus.c              |   8 +-
 drivers/of/base.c                        |  21 ++
 drivers/rpmsg/rpmsg_core.c               |   6 +-
 drivers/soundwire/bus_type.c             |   8 +-
 drivers/spi/spi.c                        |   8 +-
 drivers/tty/serdev/core.c                |   8 +-
 include/linux/of.h                       |   6 +
 include/linux/pm.h                       |   1 +
 include/linux/pm_domain.h                |  20 +-
 23 files changed, 700 insertions(+), 304 deletions(-)

-- 
2.43.0


