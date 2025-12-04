Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD7D29F97
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50881.1764872163866021697
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NK0rTH3l;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so11780325e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872162; x=1765476962; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XI77bz+HHb0zVjyzRP6MYNPzweSQzQuoxrocGaQsys=;
        b=NK0rTH3lkVXheXUjbi0mxbsOWZHHk4WO/tyOPMcZCxyDBRNCK58jemoA5rZeQ3Fk7D
         1vfrxGULdubDcx6HcluAg+zArUy+OlHF/1EIs794zBWynTWlpPCBF7QxXRkzrntwK8Ie
         XqK4msaNd9qIutkEZC2uvxuLBrBwdwhcQRbh+oBQ/PX5M4+RJ9zs6wR1SjUC2hwXARKh
         OLQmXYEyVlytopW+MJiUDje2xOEjFHqnb3FdfhheJOk5NMK56DccbqVPGGZeAbuOjkhq
         GIoxraeAkIGMur1X2agQU+jD4+/waaG81+yGt+9ZBAVcyWP0DXV7xRZcsIAXvd9TDnxO
         Cq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872162; x=1765476962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XI77bz+HHb0zVjyzRP6MYNPzweSQzQuoxrocGaQsys=;
        b=Lvt1mfCNFRxBtBWvb518dIyHOQwPcXbETQhFnlEXcqzFjwCLG61xgUqAZF1D7rwdbW
         TZeju7Hgipkr2rlPag/9HoSsh+rUxCUOSnAiz4WAKCu+EJtrmLo0ymq61VZorZPDpeLj
         kiS31UoZjO+zYSyH5nHfod2fOY4Q77+qUKr71FbG9TfxCrlguHNCsy0My0AbUzMPbwct
         FHiOE60GXRgK3S6YvT107J8p6YSvwQfUV0N5Lv2kY8ZbQyg1aouWtJThaAv3ebWGlpJj
         kZUwuVwIa34EWGTyqQoLYxAnNF6I+yIKyDLPIvzahsAXZuQOPELz77jztTs/cxdqh2+a
         DShA==
X-Forwarded-Encrypted: i=1; AJvYcCU30DAUm/U9SyNfTCLWzvXLxuvIB/6W/awaRT4tWF1qRL0gxHlS5e4dE9XmOip0WnETUnY4+HmF@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy3JDSLsj09lRA+J9hJiccUagmvmSGq9lssgWKVd5mFjSc5ccMs
	MfHxh9sKrNKMrfjeCWYhB0L3T/wM5EA/mKz/cMrAIzBwkc0VIkzhTj2DolITL22ENqw=
X-Gm-Gg: ASbGncuPoTMPFeWTm5KCwvUhehuzqDZ9lYFE3YobLEqoYMGVrw8/J0rkiQsFrf8Uo0S
	/I6EyTGNZtOUnj+TDJ+/X20a/4nWBx1CHb3dY9SJbo/wNEXebViVuO26bmQDMqaOALiMe70xzRO
	4SzO1Eb8iH/U1uH4Bakxc4qSVTVlBdeOV26AZZlkoH8g3IRQjFcEDRicBoydKX4520WETjcekmY
	ZX6FUbkUDbRzmilQBmAv9yGki/zJK6p1DW8oHl8ysBu0TmBGciZ3bwoRaUS+wi08EX5RIbgXJwp
	XOrWDXhnxaBz0ixzkChpoGWsWXbbZZpH39D02sNEDz0MtUEFnsyK756aa/3XG/BhE/2mu7jfnQ6
	FBveyMmdeh0vlrCmavAs1O8JJq6AJ/K/m73Plh5oUewONkFPJPiUAX55yJmon9hsouWd80vftRn
	ukvReiZcp+DkHbHBD2U7luyozZ5dmuVzLtlzh6QwzY
X-Google-Smtp-Source: AGHT+IFNP1jFJ9R4k0gzYLSRMvYZZgldvtqXPii/qw08w59eXopw+HJj1l7r7o8AwVgwLImBjWHxYA==
X-Received: by 2002:a05:600c:4216:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47933beb24amr3714185e9.17.1764872162128;
        Thu, 04 Dec 2025 10:16:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  4 Dec 2025 20:15:41 +0200
Message-ID: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20886

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

Claudiu Beznea (19):
  PM: domains: Add flags to specify power on attach/detach
  PM: domains: Add helper to check for PM domain detach on unbind
    cleanup
  PM: domains: Detach on device_unbind_cleanup()
  driver core: platform: Drop dev_pm_domain_detach() call
  mmc: sdio: Drop dev_pm_domain_detach() call
  spi: Drop dev_pm_domain_detach() call
  driver core: auxiliary bus: Drop dev_pm_domain_detach() call
  i2c: core: Drop dev_pm_domain_detach() call
  clk: renesas: rzg2l: Move pointers after hw member
  clk: renesas: rzg2l: Add macro to loop through module clocks
  clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable API
  clk: renesas: r9a08g045: Drop power domain instantiation
  clk: renesas: rzg2l: Drop MSTOP based power domain support
  dt-bindings: clock: rzg2l: Drop power domain IDs
  Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update
    #power-domain-cells = <1> for RZ/G3S"
  clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
  clk: renesas: r9a08g045: Add MSTOP for GPIO
  clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
  clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
 drivers/amba/bus.c                            |   4 +-
 drivers/base/auxiliary.c                      |   8 +-
 drivers/base/dd.c                             |   3 +
 drivers/base/platform.c                       |   8 +-
 drivers/base/power/common.c                   |  29 +-
 drivers/clk/qcom/apcs-sdx55.c                 |   2 +-
 drivers/clk/renesas/r9a07g043-cpg.c           | 132 ++---
 drivers/clk/renesas/r9a07g044-cpg.c           | 168 +++----
 drivers/clk/renesas/r9a08g045-cpg.c           | 246 ++++-----
 drivers/clk/renesas/r9a09g011-cpg.c           | 116 ++---
 drivers/clk/renesas/rzg2l-cpg.c               | 476 ++++++++++--------
 drivers/clk/renesas/rzg2l-cpg.h               |  71 +--
 drivers/gpu/drm/display/drm_dp_aux_bus.c      |   2 +-
 drivers/i2c/i2c-core-base.c                   |   9 +-
 drivers/mmc/core/sdio_bus.c                   |   8 +-
 drivers/rpmsg/rpmsg_core.c                    |   2 +-
 drivers/soundwire/bus_type.c                  |   2 +-
 drivers/spi/spi.c                             |   8 +-
 drivers/tty/serdev/core.c                     |   2 +-
 include/dt-bindings/clock/r9a07g043-cpg.h     |  53 --
 include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ---
 include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ---
 include/dt-bindings/clock/r9a08g045-cpg.h     |  70 ---
 include/linux/pm.h                            |   1 +
 include/linux/pm_domain.h                     |  15 +-
 26 files changed, 671 insertions(+), 898 deletions(-)

-- 
2.43.0


