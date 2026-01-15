Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66010D33A0D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:41 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31248.1768466017698681720
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P1NkzFvx;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so1005532a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466016; x=1769070816; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snJz/7q5/AmFa8/79kHE21/4ylRcRB1MU+D2Q595cqU=;
        b=P1NkzFvxkBbO5w7his726mMsF9httMZ0BwkCRjYCnjhf6BYA+Ti4FvNmKGzlqTK15k
         gWPABEpDpZTeh46GiIefH1eVXogthtJJDHuifRVUSOOgcD6vbntjZ3IPxC8bTrpMT106
         vc4OEJ6U9ePzyWWW+IhqKdzlrtIl/JrRYnHd9hcFSJ11SQUIxXYkn69CfCu7RFXzbsyJ
         pF7Sc6pa1+gd0++XPJoD62O7Wa3aakkUriQaPcx/9/gZEmeFtYXDzQKY9O/O4XLlpWnH
         S7XfYuF++v/ZPBVir7lk29Gun9y11m9+mlUJ7pVnD5mD9nCRGCiVdl/d2cjiiF6O+Oma
         h86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466016; x=1769070816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snJz/7q5/AmFa8/79kHE21/4ylRcRB1MU+D2Q595cqU=;
        b=YAClP+fX8TShfbYxz1wtts6dxsNwWq2mr3WSxZ71h1Y7ZJCnlwz6+kFmHAH/j/Py34
         cC5QfBR3wi7p4ZyHuFSj9VGC5nfmT7KT+rpWWL1d2EgRwguKkun2F7dBJUqubGz1+wXp
         8NpvETdJv7+s+KVVxT2EUAs0IZTTxUSNoAQMsSinNIrna35Vz0jSgdjD3+vlpgGOWOGZ
         PNeNHLbmWVyRhg0pO9II5nRVggFYfvYZYZ4h7lefIM2i+EGmSVdc2TLEJhR70bx4jrS2
         enqatrFRcgGFG8v74DFij+H78hpIlaTS5wmjokfmvXt5ztWFsGl7CY3CZu1CyLlAk3PX
         RRTg==
X-Gm-Message-State: AOJu0Ywom+mCQpN9ZaUjPu39WKBET+XJcbuv1qKp0AtluQpsc5IJ/c7T
	nwpsxEi6gOiKe6OHSPctn/g81jYpUglNHeWIneMbHj+kcLbCchUzQX35FEF7VZmjKts=
X-Gm-Gg: AY/fxX45KeTFuiaPF1u6LfL98q86ArJcOmMeJ1pAHy06nsRMVX6EFQ78nBOWSSK+BDZ
	RK1RxYLoQu2RcmkSZJsj7fU0KCT+zStqC9JXx/JRJTC+IWnyWHq8X+4ZPt2bB2JtsK5gfDFL1af
	OBFp9dLMfNKx39Zho9Z8Graq4cu7os0uUBpY/dLLxVCHxcKk3ryAMOgXt8wrJzMgtOherRHTm6q
	sNZUokkNuoJB6tic5g6u8FbJ7PX8YxJVtkROU6jeLl/+SeUDeGWo8eKeyIoLyZoTt8KNa/Sse7q
	3jM9JcvmkE1cqvcTwMWps7bhpwc/jYhusZMe6oMIvCnifEkGecjkPuDtAtFSEQKgh9bGzy4kZKB
	d9rEwfVJToWoa4Z1iC/jObvzgawIzEZtnJv4+Fxsxh0HUimjMsQDADxsvPmrGzbswWluhyrzC/h
	vAztEa+R2CjYph5SNy1QB8fIgulpOXKeT8IQF2EtiIttF4lx377OplHffd1J45MExE8AghEo9VK
	452
X-Received: by 2002:a17:907:c28:b0:b83:3773:e72a with SMTP id a640c23a62f3a-b8760fe7f50mr453622966b.1.1768466015617;
        Thu, 15 Jan 2026 00:33:35 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 00/18] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}: Backport MSTOP support
Date: Thu, 15 Jan 2026 10:33:14 +0200
Message-ID: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21561

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
- kept RZ/G3S TSU clock as it is now integrated in v5.10 CIP 

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
 drivers/clk/renesas/r9a08g045-cpg.c | 142 +++++++++-----
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
 20 files changed, 688 insertions(+), 286 deletions(-)

-- 
2.43.0


