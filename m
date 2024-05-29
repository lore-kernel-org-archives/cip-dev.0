Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE98C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:47 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.8715.1716970478406863630
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MQwjDE8p;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.182, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso24590181fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970476; x=1717575276; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4jl9u+betXOSOvlgJWt+0qzJKEU5eEiiW7Exxu+Zco=;
        b=MQwjDE8pNrgLZPJCHgOX7Jdz+acMgHmn6K4RGMgyABK7ggzPcMD37BszMEbPfyU26m
         E2VQOSjpqewEo1kBERCfYxfTkwP4PNLUVzQGiOi8iBO6iwGAd63BdCQ54nZXWIem3Znu
         +pRIxGzcsvYwqlrRMNhNn259aOiRh8bCZnvkf2Kz9zeQPjpvJzeBvtgep/LLE+hdUHXo
         ezKnhYx6MMgpHJau66JOsRDamLEjXE+4x7XEg3oGn6yDT61YfBdi4F2Eal1BMqB17FSs
         yG6jPT7/Celu14UM9R/Rzxw+7Em1KsMTkifniwjUPrVh2eRnfnCesTkm/AJkTQG1EYYG
         +srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970476; x=1717575276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4jl9u+betXOSOvlgJWt+0qzJKEU5eEiiW7Exxu+Zco=;
        b=Kco9UitgXYQ5AkN4wn8oLdN33g830Py1mf2yR9fDV9n25RoOzkJlSoGv/+98dapoOy
         nfEwRmCnxLFNFcG8x+fGDHQx1HN8ZQM7S+UN8VfW/EkUmG38QH/1ozE5rCLpd03Op5IJ
         oP2wyL1wVBBv0X/YIaZi7kLDfEetaHfJcllTihfxL/lF1pYfIE1ua6Njzh5RHe/HPw6Y
         vfYAx1OS0eY3+KrisQfup1SDiTBSZaPmq2nrWGjdpjL/vJFLZZur6gpyk6M1dL3kgfGd
         NI/ZGlCmS7Y4Ax+qpGWtHrmnmpuhf5Gz/YLrj5QpAt9EWpKej3p9OEiFQTxjI5z0SZ6f
         7ogA==
X-Gm-Message-State: AOJu0Yyh3ISgmIFOAoVsxK+ac4RoUlb5GkwrTBXtQ8WkwPJvsAvbCfQH
	pGIe+pmSD3K3RVrXSpekqmlMLvhumWpFFDXYZNlZGh0mGmgO4PKa12TpvHPTpG34xqr/SXgbuf8
	8xzI=
X-Google-Smtp-Source: AGHT+IFPOojtjQi/l0/RgOrImXupRIJ/s0OBdMdtBgqpJ8fVLfyI5BYRfLUW5BYx6VMlZIWIYbUzQA==
X-Received: by 2002:a2e:98c5:0:b0:2e9:8679:137a with SMTP id 38308e7fff4ca-2e986791446mr33362771fa.44.1716970476525;
        Wed, 29 May 2024 01:14:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 00/33] Add Ethernet support for Renesas RZ/G3S SoC
Date: Wed, 29 May 2024 11:14:01 +0300
Message-Id: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16028

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds Ethernet support for Renesas RZ/G3S SoC. Ethernet driver
has been enhanced with runtime PM support. The suspend to RAM support
was also improved.

Series is split as follows:
- patch   01:    add clock and reset support for the Ethernet IPs
- patches 02-07: add pinctrl support for the Ethernet IPs
- patches 08-29: add support for suspend to RAM and runtime PM on
                 the Ethernet driver; in this set there are many preparatory
		 patches for runtime PM support (as runtime PM enable/disables
		 the Ethernet module clock and this influences the Ethernet
		 module state leanding to registers setup being lost)
		 along with improvements
- patches 30-33: add device tree support

Thank you,
Claudiu Beznea

Biju Das (2):
  ravb: Add Rx checksum offload support for GbEth
  ravb: Add Tx checksum offload support for GbEth

Claudiu Beznea (30):
  clk: renesas: r9a08g045: Add clock and reset support for ETH0 and ETH1
  pinctrl: renesas: rzg2l: Move arg and index in the main function block
  pinctrl: renesas: rzg2l: Add pin configuration support for pinmux
    groups
  pinctrl: renesas: rzg2l: Add support to select power source for
    Ethernet pins
  pinctrl: renesas: rzg2l: Add output enable support
  pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
  pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
  dt-bindings: net: renesas,etheravb: Document RZ/G3S support
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

 .../bindings/net/renesas,etheravb.yaml        |   1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  38 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 177 +++-
 drivers/clk/renesas/r9a08g045-cpg.c           |  10 +
 drivers/net/ethernet/renesas/Kconfig          |   1 +
 drivers/net/ethernet/renesas/ravb.h           |  40 +-
 drivers/net/ethernet/renesas/ravb_main.c      | 947 +++++++++++-------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 164 ++-
 8 files changed, 960 insertions(+), 418 deletions(-)

-- 
2.39.2


