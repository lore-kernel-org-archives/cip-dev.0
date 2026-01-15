Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FBFD33A35
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:11 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31321.1768466169222707298
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=N7T+4RJ7;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso866740a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466168; x=1769070968; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbHr18MOZvgyMFyzDvP7UlzSW7uL1MJAxp656M0JXZY=;
        b=N7T+4RJ7kZ05DmkeFLyHeDvIW63RZ/ZrffkRZ8wBFeUU+6TPCD/8R3pN527qMlogZ4
         F39Z5B+LV1GP4Eaeq4Y3T0l+axlpnginAxSfA0YlLFIQE9wijPIVPm3bYcxSdlw2CZwn
         aiLjgvq4ccgKE3XWKgZvFUp3KMo00If2RCupYFY0ud8C9C6HJX37tGgejrQr8DtAhGUl
         /KnLI6i8oOKKrq96OihbYmT2TJonhsucuCp6hPtTHZSc673I8f8w2oscD1vaJV3mfOdo
         OPbSKyEcweYOBiIaScIMcrV0EDzz73zI/xuxavf+CpqjlCFZl9XLlOXDK4oVuCthrgnx
         fN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466168; x=1769070968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbHr18MOZvgyMFyzDvP7UlzSW7uL1MJAxp656M0JXZY=;
        b=DVeKTAjaTypiqoauOoCi+Ds+ejF0BzB+Ps0UrcNMut84sbU609qYQonTHi/ZMyrAg+
         euhVwM3+wKIjqMwYP6hcGxmevAqhjxDDXp4YIm3MPJgqdPHIHhOBOi0LY8KnQscnosEE
         K8Oi99WvdHqcJHikwt2vTzSWgbOj5CoJgJmOwl0OkLaXLHEtQbVX5KDKVlkoNdb2PjI+
         T2wP45bBrh4VLcPI0XqQ5T5MbeiUWmiLei/mjGifmJM4GWMBbB/fIDSrsjV9Q5bzqzk0
         OpdGpAHOPKtlkbx4zYKIOK1GaKTJPZqqQLbi3D7k9h/Y+AAGHqEheN1RIMaOP1gQ0d9M
         o0/g==
X-Gm-Message-State: AOJu0YxqNscHbjzRzTuqiAJ7WQMar5S+dAgdnFF9Jf36jqNIe4bAWlTg
	2waHChzloAQ621InhHXf88x7yMkCeXnjaohl6aQaInlKqW9scmkLJMD1V8fcTKceZZY=
X-Gm-Gg: AY/fxX5q5ApZupTI4ZH3bztOWLlhoIFBKhQrGMuxfiru4U+BkI1lrgqlPhRAIm5qgCz
	L/99vQqCILp6d1HTu5EUF3sgH1pc386SL3monBm2u3uW2gXhENjnqyqw+Pct4VQUZKyTDSNPl2M
	0pAZpUlUluz5ZFVE8HFM4W0n0Ab92+QoKlU2GXmN/HkqxAjh/w/KU6YGUNB56aE6DMMAUN5A5z0
	XAqBmPG+mPZVhgKKDnYRo0kkCliwgSiGaFSP3lZsuREKZ5Z7Kmn9hK9LDGcYK1uizQjToBQRoup
	XmFcSwKu6g592YM0fb2ELuhxQqmlqy40l79LNMuQ7rzZp5kTg1/F6hlvw5VywaiHIXINNDjeBJJ
	7mVfRWAmOyPusW16qMF2y+THBwJQA9jn3VXQkmUFM3ZbaF9TCZBGAEl2sxqpKwUOJEWYQrba3kW
	D++OzQtpI6fycaND3ljaCidv3MS3s5pFPxFO3ExyfCzi2zONq/fwjDd+FxTaiWiV+faHY86TpyB
	Uma
X-Received: by 2002:a05:6402:35c4:b0:64d:4894:774c with SMTP id 4fb4d7f45d1cf-653ec0fae18mr4204799a12.7.1768466167583;
        Thu, 15 Jan 2026 00:36:07 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu, 15 Jan 2026 10:35:44 +0200
Message-ID: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21600

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
- kept RZ/G3S TSU clock as it is now integrated in v6.12 CIP 

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
 drivers/clk/renesas/r9a08g045-cpg.c           | 252 ++++------
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
 26 files changed, 673 insertions(+), 902 deletions(-)

-- 
2.43.0


