Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C488CCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10055.1762416652021325341
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=p7rgIUEs;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711b95226dso7338405e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416650; x=1763021450; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+QZUOYWqTGsSIWqXH394yjZM6uhQ1Hm12lO7qHRsvU=;
        b=p7rgIUEsLhUcOlt8yB2rt/bDD/arJ3UgxqAgrHaNH370+2IbaTkvnu87Y9/owKC7on
         ntJo8QyCOsvEsd5IRpAqOaXikh8fAOXKuzi+ad2EnseoENujhlQwfxde2n05r/XIQuXR
         tnwqxR4yh0UsANWKxxiPE31gR3XQh4DwQOcaDxwlLF4W5w0czS69t3ehucGSeFBGvs1K
         EZ9lnZEEkxaKZSkds0o2IPhp/fCQvD2+EkSZPNCJ4zZsJ/k7IKPTuzyJnyNQd+hbJdwE
         MH95l18PVqKwPfXM8juoihr+43pk+idXHBoVZR0HdnCJ6hzzLbWxns0iyevXKq4RMQoE
         OkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416650; x=1763021450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+QZUOYWqTGsSIWqXH394yjZM6uhQ1Hm12lO7qHRsvU=;
        b=NoqUyKCCsoI226/g/aVfEIUVd//jV0fhFbnvY8iKyskzBrOcIBa44rE4b3egREl3F3
         3AJhKZ1zdzKmVBaci6y6AJ4OmtXMRx9aARfPrL49Ots3FTq7JbFjgwH4qyyv/xPZHiCN
         n+Sy7ye9eavHS3K+/ZWtxm0FJJpOE5+cNuB/tO2xBT1MuBD8drpn0RYOLJuw/fvWrsVu
         tiTA/KepnQC4x8TbFtG60YaTxZ0IeNKKZEG61CzixM8BzRWD277TlyN5CbWJ/BaAaR5H
         m+JhU1VG+sgE9jc1CiAQzNKak5Hc9zx87gO17oDux0X4J3YgbKrSuxaFZr/0wKvihOay
         B6iw==
X-Forwarded-Encrypted: i=1; AJvYcCX55sREhumR8HSFwUatvjudeBHotcM2MmvF0ehmpsaX+PKteBiEKGu6/vyodPgB+lk30DfxQctH@lists.cip-project.org
X-Gm-Message-State: AOJu0Yze2JVRNWb9bsH6z8qhgqjGYijIf8IKPAI3tK7pYM2d3D3FGNzV
	Y4V4C4E0BrcSY4yuN+BPXRfFBcUwypmC5Tcv0urExoG045lLrRA9UII5JM2+Sgda+FQ=
X-Gm-Gg: ASbGncuXGYW8kBcQ40je4rP7xG4tQ/TaMujIH7fbA4WuZ385YqDlWGT0eh60ELw8lED
	WbpblWxpC+KTceby3G/kEK+pe4MA9otMbKfXIcRWfTC+uHi1bOb0UtC5US4hjrmiBy3ZpDS8vML
	/6ul7h/x3fw5+iBDauxxP20AwVDz5PWW01t8LzaFr4nOOXmsQzcdrNY0L9fdZCMmfePLRFgu+u2
	O5tnt7iM9e5G9WA+b73EU/O9TiTvF9i9dexnHCT2WE+9fnFLyc4cD1lCesXyrGyvavuzA2leyR4
	OMC3MFqvB5Np9WLbVCNDknL4Pnfg+r3dtbByJVqTyhbXFPHYd/rr2c5rJeOTLNPIAiSluhrvcJm
	6HoQTcdMAFNH7Kot0ktmAliO4V3miPs600x75X/d38G3kysdgFIvUyNNSgA1fqXVi4Zkjd0j96O
	7D4FiTW/lxWOLbpyYxvLvQ84enr/3n77o2Lze4jpTd
X-Google-Smtp-Source: AGHT+IGephKmPJxmhvfH3wWkctxHeB7gflJJ4HUauWlz/wIvk37TBvNV1zDWy6xvHREjzNMyO+Fb5g==
X-Received: by 2002:a05:600c:4e01:b0:476:4efc:8edc with SMTP id 5b1f17b1804b1-4775cdc570cmr60196115e9.15.1762416650239;
        Thu, 06 Nov 2025 00:10:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/23] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu,  6 Nov 2025 10:10:25 +0200
Message-ID: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20369

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

Claudiu Beznea (23):
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
  clk: renesas: r9a07g04[34]: Use tabs instead of spaces

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  18 +-
 drivers/amba/bus.c                            |   4 +-
 drivers/base/auxiliary.c                      |   8 +-
 drivers/base/dd.c                             |   3 +
 drivers/base/platform.c                       |   8 +-
 drivers/base/power/common.c                   |  29 +-
 drivers/clk/qcom/apcs-sdx55.c                 |   2 +-
 drivers/clk/renesas/r9a07g043-cpg.c           | 140 +++---
 drivers/clk/renesas/r9a07g044-cpg.c           | 176 +++----
 drivers/clk/renesas/r9a08g045-cpg.c           | 246 ++++-----
 drivers/clk/renesas/r9a09g011-cpg.c           | 116 ++---
 drivers/clk/renesas/rzg2l-cpg.c               | 476 ++++++++++--------
 drivers/clk/renesas/rzg2l-cpg.h               |  71 +--
 drivers/gpu/drm/display/drm_dp_aux_bus.c      |   2 +-
 drivers/i2c/i2c-core-base.c                   |   9 +-
 drivers/mmc/core/sdio_bus.c                   |   8 +-
 drivers/rpmsg/rpmsg_core.c                    |   6 +-
 drivers/soundwire/bus_type.c                  |   5 +-
 drivers/spi/spi.c                             |   8 +-
 drivers/tty/serdev/core.c                     |   8 +-
 include/dt-bindings/clock/r9a07g043-cpg.h     |  53 --
 include/dt-bindings/clock/r9a07g044-cpg.h     |  58 ---
 include/dt-bindings/clock/r9a07g054-cpg.h     |  58 ---
 include/dt-bindings/clock/r9a08g045-cpg.h     |  70 ---
 include/linux/pm.h                            |   1 +
 include/linux/pm_domain.h                     |  15 +-
 26 files changed, 688 insertions(+), 910 deletions(-)

-- 
2.43.0


