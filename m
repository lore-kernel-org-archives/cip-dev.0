Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B93D29F83
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:38 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50848.1764872134799666566
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qDq4YdiG;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477b91680f8so12484885e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872133; x=1765476933; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+I6k84+gLKNUH8h0NuqNJYR42lzDAdRZ0VUMBNJP8Dg=;
        b=qDq4YdiGTEKfooGFF+63IYljv1id9BRIG+SzWGYTaSQOW6sF+1hpWoIvA+bo7SXo3S
         iWEyZ/MBKVFzofovjAgZdt7sOcfspmyCN1cqeOK6ZjgiJaQEurEF858GE06XP5VA6uyR
         VpLJRY1GwCEFFPPdMwaSAQRkov1iJSMZS2BgVGOAu50vnQxH0XxPljpzQzfd92cqOL6N
         vCPlFwdneXSN7RTieXAj+bbRFqAWepzNT0bM7fPYsf2x7TQUBNr2LbCPyoZKVhy1GOva
         SkVd9XOJuPvzFzV34F+QUOZ/GAnvnc3wd8RuLdco3BCz5oSPNlUh0rRZM2CHR79A+Eni
         oc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872133; x=1765476933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I6k84+gLKNUH8h0NuqNJYR42lzDAdRZ0VUMBNJP8Dg=;
        b=LcYdQrWdkqg6Z0QJp+v1Iy+1ZeLaNvEd+VzkOehI+9kyjqvkv08oXsxVkcsmekdPLn
         Wfx7HrtiVcwk5v2lHWn9fRlJ6c6mhJbMU2+v9PPBX6ZO+LbKqGT421bEkfcAmpMHHvFa
         kcxEZfVmhrMXdyyNq//PXTbsUpYR+ZCIyZvGgQhinT3Wznvf9HaLcq5c6vdtHYdndIfu
         hUMewtM4AIkdQhoxpbeIAgmhsKCE+U/FVWEvowIx6+qTwKv9DzHlaRfEi1tukL5DWc3M
         H22ICRi0Ti4T4hOOMpAeEGY104+uwXNSDn4sMBiVESw+6PxGBP0wTTJCDtYzS0SN+KHH
         nahg==
X-Forwarded-Encrypted: i=1; AJvYcCWrBUKi/UZ8RrfbonUdJws0CcMkoeC4vWrp/YKgMuo4kewCQ9GnNteE+lo+Iu/JF54K33Jl1hrM@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz3dGSV6YlvZlRKeL1/YmLVPC8USkUkySItx0du1d6jaZrbXRoq
	YVNpP9+5FIvgeZ90lcJ4FiUGcPxiQMoK1qilvIE2VV8ApJ+3MaOwLqS8FksnpoyQq5E=
X-Gm-Gg: ASbGnct3eDmezMbEEBgzdSxCsL0CdDvk1VfG/1KyXwS/QQTfEfQvjyj+Y5rPUf07Xto
	AfiXshy3Jqa+i6/aiePRfI/8HTdZZTZ33+UZJDgLFoy+v50XQw+SvjEvn3XS/sDhTMqSz7Gkqv8
	Ioo/Ppm+OTb/4Bk4kPOkpB2Y/C0TrjtLBbBxBgzHJ2sNwy2QVB8lP62FBLxzb5+LUUpZDCawsBY
	AJvczWY93zlsWrpnsATkXwGeufvc2M48UuECfIzwA5V0dI9KrtNdcHu/IfrZQOZINe8ZyiKsWtk
	IW5n4US2ubi9/sKkQ2GlGoaqY2Vfmv0SNgIX108LbParMC4VP+Sgg9qjkLyqVC6LCkJO4wYh4ZD
	p7GBGHtVtnLoQMcmA/+SOo4sIN2eT1Hd7DmXGPCPtO0lbqRPjgVxo/Pmh7ccmn766Ua7TUKfnZ7
	P0a9NKoxZMjFD/lA67VP8gzqTYVUwke03vS5PYxcMT
X-Google-Smtp-Source: AGHT+IHA+jCmggrZnO3h09NDKtmUNOcVfYFpXfdivtAvw5WudZPyHxm8LeLLXIdi76H4Zjc1wE/PGg==
X-Received: by 2002:a05:600c:5491:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4792af3e01bmr68317455e9.26.1764872133230;
        Thu, 04 Dec 2025 10:15:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  4 Dec 2025 20:15:11 +0200
Message-ID: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20866

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
 drivers/clk/renesas/r9a08g045-cpg.c      | 139 ++++++++----
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
 23 files changed, 681 insertions(+), 291 deletions(-)

-- 
2.43.0


