Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35CD33A1E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:01 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31286.1768466095932051490
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:34:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=m3ioNvgv;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so893147a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466094; x=1769070894; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe+jcd+fd7LWtoevILdaTuzML2/CaBpo1ANquGzuq94=;
        b=m3ioNvgvQ/8+kyh74CXvQjQegIgo3+9/LSaJhUdvuSzDCgazKTnoXn0icoJ+/dWcUt
         ZDeAj/bTh0KkH14OP9JsKc7VVX8gZQLNdE9XMURspEaAcG7TpJjhB3nL6x6okOGKbWwg
         GYjfG6cbjyN0L5otZPSHlJt2/YTWeaLvpddTU5+GFDdsdsttsxqbleBR+zRcuAkHVqRN
         7GeVTvRZ3BwF2jzoROiO/pDCkzqjJZEBID92C1s0eL5vy7DONFLWFUHSMv7ZUjrseKuW
         T5zFuyT9niEUNk/xRgszjq6uOpFPmcM1LYModMHpsagj/e1O2e51478bsQbVCnqzU2mf
         AX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466094; x=1769070894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe+jcd+fd7LWtoevILdaTuzML2/CaBpo1ANquGzuq94=;
        b=IMRQiuQRpEfjg7QNyhZMff31+wlx5aHVMxNFFbWTakJaSes7tTc1SL00rP6yDpakpY
         ZyFesqw7WZBZFaAFl9WJYGqzFssB9WjqS5vI/wJ442v0xVi0B5eAQl6c1mKu4pNxE61T
         m4EwU552kuU6+tIQxcEHw0Z/w/WiIGhDjDhybbTFvTPs1InQXa2wmskKOPN06vJLyNt6
         GcLkyA5HqQo25yS8wOFms36JzyZav3lQYP6TqCMhBuo9w2v0u9jayB9FLvAindxkX3cC
         j0KbEV6Z/S6Iz3cO46rRze0ZEeF+BgkO3ivBPVnyhBxPAf6DLlQyzYJa/+dbVIRYXB36
         eidA==
X-Gm-Message-State: AOJu0YyHSXziU9htJTngyPued9eMon28EvRgVZ272I5KQa5FAi07UUX5
	3DF+yc6XLg8di2GNIton6bxHvYwFGjBElOSXOjDdAmDLJl1g1HuW06i0iUp5P/CvOZ0=
X-Gm-Gg: AY/fxX6sgPuD9XXuc9EmsN559/5pviB+neC5o0EZqWzL2QztpXjBgP4X39JwbJLCxht
	BhOPJ3BLLhFyYbOxGlmENbVWrN1eEQPfhwSqOmmoIZaNiny9/nv6hIbMzBbyVV9CqgJ6qkTBPAD
	nLJfFiOpNVdlk+OiDlkSpoq7YFob+6qU/GZ2Hxzb8FBkKDFm2fKYq6nJ39leXaLacikXxy8nA/e
	o7ahzvjJlhRqBYKRibbr3tP5QKtXlCwaVAT+F/m+58EkGP40wNedLoWRdw7ocQbHAONmWpg1vOQ
	cQPNv2KkUgjfSXHz6I9zP6Vvof0oXfLIGp3YtfuMPMO/Ag4AocEAV5mmmNGh9usCw7arlXe3bnW
	5Fzielbi+ZHZVGoJ1ECe5GrG9D0/+hkOO4fAShcAR2iUJ51lI1Jx0FSlcke8eGWoNhl/rVWul2U
	T8nH1nRvd5aZ7u57eEiCUzxqOLqcZ6ZWGthi0SZONiCSTfb4/tAD9CjwLLndnWM3iycg==
X-Received: by 2002:a05:6402:2756:b0:650:f4dd:182c with SMTP id 4fb4d7f45d1cf-653ec45b056mr4038278a12.23.1768466094312;
        Thu, 15 Jan 2026 00:34:54 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:34:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu, 15 Jan 2026 10:34:32 +0200
Message-ID: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21580

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

Changes in v3:
- kept RZ/G3S TSU clock as it is now integrated in v6.1 CIP 

Changes in v2:
- dropped patches:
-- rpmsg: core: Drop dev_pm_domain_detach() call
-- soundwire: bus: Drop dev_pm_domain_detach() call
-- serdev: Drop dev_pm_domain_detach() call
-- clk: renesas: r9a07g04[34]: Use tabs instead of spaces

Claudiu Beznea (18):
  PM: domains: Add flags to specify power on attach/detach
  PM: domains: Add helper to check for PM domain detach on unbind
    cleanup
  PM: domains: Detach on device_unbind_cleanup()
  driver core: platform: Drop dev_pm_domain_detach() call
  mmc: sdio: Drop dev_pm_domain_detach() call
  spi: Drop dev_pm_domain_detach() call
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

Michael Ellerman (1):
  of: Add of_machine_compatible_match()

 drivers/amba/bus.c                       |   4 +-
 drivers/base/auxiliary.c                 |   8 +-
 drivers/base/dd.c                        |   3 +
 drivers/base/platform.c                  |   8 +-
 drivers/base/power/common.c              |  29 ++-
 drivers/clk/qcom/apcs-sdx55.c            |   2 +-
 drivers/clk/renesas/r9a07g043-cpg.c      | 132 +++++------
 drivers/clk/renesas/r9a07g044-cpg.c      | 168 +++++++-------
 drivers/clk/renesas/r9a08g045-cpg.c      | 142 ++++++++----
 drivers/clk/renesas/r9a09g011-cpg.c      |  92 ++++----
 drivers/clk/renesas/rzg2l-cpg.c          | 278 +++++++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h          |  28 ++-
 drivers/gpu/drm/display/drm_dp_aux_bus.c |   2 +-
 drivers/i2c/i2c-core-base.c              |   9 +-
 drivers/mmc/core/sdio_bus.c              |   8 +-
 drivers/of/base.c                        |  21 ++
 drivers/rpmsg/rpmsg_core.c               |   2 +-
 drivers/soundwire/bus_type.c             |   2 +-
 drivers/spi/spi.c                        |   8 +-
 drivers/tty/serdev/core.c                |   2 +-
 include/linux/of.h                       |   6 +
 include/linux/pm.h                       |   1 +
 include/linux/pm_domain.h                |  20 +-
 23 files changed, 683 insertions(+), 292 deletions(-)

-- 
2.43.0


