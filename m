Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8FC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:45 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.8627.1716970243939489050
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jm1Uj6OP;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ab1d7243fso728721e87.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970242; x=1717575042; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPIKBNyCl8VUcE+QUb7XbIh3zv0j3Z0RUKgx58pE5H0=;
        b=Jm1Uj6OP+ohV4Xaj0kN0vkubEFiMIw3Q9P2BkZmmvitFn2mzTSbBGn+0kXE5h8a9oy
         jnn2PQqmLkOAfkQ8ZKyslbjQ9qNc/me6dDbwpXhn30TtmGATIxHNe5GD6g8dmlWGBRlw
         RI1jJhNu7BUsF/r+lWP3qZ2WNcUmjWMjqaHURsTdb6LlVsxR9dkj/FfdBxQz98vqhCs9
         s0MIAv+4ukINwRyJjuU7SZRan/T+ceM2vszdlP4VZlVEukvs2EYVXRobQylHmukOxNPV
         Mm4Fyr5r2Y4X9v4EkX2c2LEtXVs3s1DZCT/vGM9FYlYYvQvWt3EkoOaQGlJEHtBguQ7Q
         h62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970242; x=1717575042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPIKBNyCl8VUcE+QUb7XbIh3zv0j3Z0RUKgx58pE5H0=;
        b=pjl/WEVr3yGaM6kiPY1Y5CyjPdQHdG/Vy/xz9bTPOKgw7oH0/G97q9I36ACqtiw3kQ
         PfcuboxaJvKX3uc12LYeRMEk2CWou7R19zv0AvRMB2u4/coGyZW0pp8xn6IAfUlv52ag
         VMsn6ZelGMruR6GIz7bGkczVNBCXAalkCYxnBoP7i0YQnci5kmifHuy5rl+yPhGBQcxr
         Oelov/m/Zz8sJRgkSLl5aWea+9tc1Y5ixgBbvRVZqmF1NB5gwXk7Qhle1XQROy0GgA3L
         XPUExykTNW14a36b3H7y5tzW6w4GyrC6vpr13aNq8k8DLwgS1wudsoAqXbwfzvMFACsQ
         fQUQ==
X-Gm-Message-State: AOJu0YwB3qrtrThGUBg9IF5UXG++9sIkEGvdaFD1DRuABTjFxp6IShjj
	dvEG3ww2StBr/nSVj8DRQYkbxp9cylQBFE4D6OZyVSW0hb4RoIMPjJfxIX1JhOg=
X-Google-Smtp-Source: AGHT+IHS/SGLa6zBFE0InQr6hcL6oM7RnE1z4oljheDpp6noAd1QeKGl33xUFu51zQy64mnska0cXQ==
X-Received: by 2002:a05:6512:12ca:b0:52a:f9bf:737b with SMTP id 2adb3069b0e04-52af9bf75bcmr837741e87.27.1716970241947;
        Wed, 29 May 2024 01:10:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 00/47] Add Ethernet support for Renesas RZ/G3S SoC
Date: Wed, 29 May 2024 11:09:52 +0300
Message-Id: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15980

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds Ethernet support for Renesas RZ/G3S SoC. Ethernet driver
has been enhanced with runtime PM support. The suspend to RAM support
was also improved.

Series is split as follows:
- patch   01:    add clock and reset support for the Ethernet IPs
- patches 02-07: add pinctrl support for the Ethernet IPs
- patches 08-43: add support for suspend to RAM and runtime PM on
                 the Ethernet driver; in this set there are many preparatory
		 patches for runtime PM support (as runtime PM enable/disables
		 the Ethernet module clock and this influences the Ethernet
		 module state leanding to registers setup being lost)
		 along with improvements
- patches 45-47: add device tree support

Thank you,
Claudiu Beznea

Biju Das (2):
  ravb: Add Rx checksum offload support for GbEth
  ravb: Add Tx checksum offload support for GbEth

Christophe JAILLET (1):
  ravb: Use GFP_KERNEL instead of GFP_ATOMIC when possible

Claudiu Beznea (36):
  clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH1
  pinctrl: renesas: rzg2l: Move arg and index in the main function block
  pinctrl: renesas: rzg2l: Add pin configuration support for pinmux
    groups
  pinctrl: renesas: rzg2l: Add support to select power source for
    Ethernet pins
  pinctrl: renesas: rzg2l: Add output enable support
  pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
  pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
  net: ravb: Check return value of reset_control_deassert()
  net: ravb: Make write access to CXR35 first before accessing other
    EMAC registers
  net: ravb: Stop DMA in case of failures on ravb_open()
  net: ravb: Keep reverse order of operations in ravb_remove()
  net: ravb: Wait for operating mode to be applied
  dt-bindings: net: renesas,etheravb: Document RZ/G3S support
  net: ravb: Let IP-specific receive function to interrogate descriptors
  net: ravb: Rely on PM domain to enable gptp_clk
  net: ravb: Make reset controller support mandatory
  net: ravb: Assert/de-assert reset on suspend/resume
  net: ravb: Move reference clock enable/disable on runtime PM APIs
  net: ravb: Move getting/requesting IRQs in the probe() method
  net: ravb: Split GTI computation and set operations
  net: ravb: Move delay mode set in the driver's ndo_open API
  net: ravb: Move DBAT configuration to the driver's ndo_open API
  net: ravb: Move PTP initialization in the driver's ndo_open API for
    ccc_gac platorms
  net: ravb: Set config mode in ndo_open and reset mode in ndo_close
  net: ravb: Simplify ravb_suspend()
  net: ravb: Simplify ravb_resume()
  net: ravb: Get rid of the temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Move the update of ndev->features to ravb_set_features()
  net: ravb: Do not apply features to hardware if the interface is down
  net: ravb: Add runtime PM support
  arm64: dts: renesas: r9a08g045: Add Ethernet nodes
  arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to select
    on-board functionalities
  arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
  arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs

Geert Uytterhoeven (1):
  net: ravb: Fix registered interrupt names

Paul Barker (3):
  net: ravb: Count packets instead of descriptors in GbEth RX path
  net: ravb: Fix GbEth jumbo packet RX checksum handling
  net: ravb: Fix RX byte accounting for jumbo packets

Sergey Shtylyov (1):
  ravb: ravb_close() always returns 0

Yang Li (1):
  ethernet: renesas: Use div64_ul instead of do_div

Yoshihiro Shimoda (1):
  net: ravb: Fix lack of register setting after system resumed for Gen3

YueHaibing (1):
  ravb: Fix potential use-after-free in ravb_rx_gbeth()

 .../bindings/net/renesas,etheravb.yaml        |    1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   38 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  177 ++-
 drivers/clk/renesas/r9a08g045-cpg.c           |   10 +
 drivers/net/ethernet/renesas/Kconfig          |    1 +
 drivers/net/ethernet/renesas/ravb.h           |   40 +-
 drivers/net/ethernet/renesas/ravb_main.c      | 1074 ++++++++++-------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  164 ++-
 8 files changed, 1030 insertions(+), 475 deletions(-)

-- 
2.39.2


