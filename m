Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA14E67482
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:10 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78271.1766402229244456213
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hig+5R2H;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b804646c718so277235166b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402227; x=1767007027; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGADKP57AZajxwcDaBdSfoNW7vRgbbfbjxhdLqO7xDM=;
        b=hig+5R2HKGjKNelYuNlH59/j9G4z/zDadVG5d5Nn4eyDTWtJE0v0uVSySSKqeW6zYB
         09Vb6MV5BASFvO3mEoIZAIyGCKb73vBmS0ut6+Cl5go7k3ndCEsTwYU3653xRR4mMEc/
         50Ev1kNtxrpTn25k7Bda7ZbYndQQANDcdvIS4v4FHNHiMUbpJSdgFH/MlZTnS5dedLcw
         Dw6vmWUK7RDcw5vKqXgwkCuhevoOnexQpPVaGb9aE0z0Fm80nlNUSByGC9x73ENkncri
         IVxCs7lxbW3ZzRl3oAoX8S663q87HoBlMlJXr8GKt4c7FpwZ1G+/E/068MImk4eOXJ7B
         WXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402227; x=1767007027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGADKP57AZajxwcDaBdSfoNW7vRgbbfbjxhdLqO7xDM=;
        b=DsKea+hbeT1YYKuxxzu2Yr4h53QLsZcaN4E30q/dvIGhHaHEW1UbjRMxFQpLZaddO8
         0qt7pBwBOe8+jDy7ajLCLGe7Xv/LGKkf5/9kUic+9F+rOmziT7paZnD9R1vfvz7cxI60
         yLKDTXJyj8sNOHZ4QLsyli7JlV+UanF5/iJheZG2HBuPuPhDD2tm44BJ7xkedxEk8EIL
         xZa1hlKz1b68N465xQhNpEgdfM+Az8cvSezkojOTaRU9LZeYo1MWuEvqNg2zJ3iGQgYc
         6SoRz6fySZsMtbMB3XzULzMhR6bLtY2xqo59QTFdaC42utVm7FDL3fqTCZwKpprpbCEn
         vHog==
X-Gm-Message-State: AOJu0YxeIP0Z2Djhdb5XgKKkgPrE9Eoj+phFb+4AniMUZtFr/uSxQQJd
	IJcclw6VtH83KK79/0DkzZ428QA0QeGTDWfZos8g2NbQAY32+gkGtx1eZCp2aQ==
X-Gm-Gg: AY/fxX5csalWy3fa/S7SHc6GhSYHB4jsOSU124Dqkn4GD6NnkO1lHusN3LSG+JoiADj
	1S12q7H+OwnNK+4vFfCnrFs55fSEA7Y18xBKS2Hxe/DIx3jW/c4i1Os8g6kvWEqH4mlUlBx46b0
	j5syVwUxLwHpYpnOJu0VZNG4Z07SePR7IJXIjSh5pXc+vWIz+AZHEaAJCWjqwtm2FdA1T3L5Yf0
	vrZBJpgVJrUbzbdN4U+tjm2rMhuOzPJSl6BZzyiNL36GWkOaiB9otsW+TqIEPFSbwjl69kEvYaa
	YAZjmH3n7ms6Y2EPQmGPfXc1LvW4UDwwF2f8lapyfJmQ1a+dBorLnBTgQ4r8kWkD0P0a6VwJsF5
	+t12egV+4oO1t6tnn/Ui0P1VAb9fyy5RtS/RKGzmVjyKnkwXPaQFbidnFsTD59ZQ+AahMeK/SGG
	hEtUwgj0XrS82Bv5GoebpUwwy1vkfj4UwiV/Y=
X-Google-Smtp-Source: AGHT+IGb2oNoXkU/mIF0MfvV/4H/FuDbywmQ7VPLwbjagjeH/HlX5f0OMNmszjMwLFtLIVXAPAbZHg==
X-Received: by 2002:a17:907:5c8:b0:b73:544d:b963 with SMTP id a640c23a62f3a-b8036ecf4c0mr1046902566b.13.1766402226152;
        Mon, 22 Dec 2025 03:17:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:05 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/24] Add suspend/resume support for RZ/G3E CANFD
Date: Mon, 22 Dec 2025 11:16:32 +0000
Message-ID: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21188

From: Biju Das <biju.das.jz@bp.renesas.com>

Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
powers down the SoC. After resume, reinitialize the hardware for
CANFD operations. All the patches in this series are cherry picked
from mainline.

Biju Das (7):
  can: rcar_canfd: Drop unused macros
  can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
  can: rcar_canfd: Update RCANFD_CFG_* macros
  can: rcar_canfd: Simplify nominal bit rate config
  can: rcar_canfd: Simplify data bit rate config
  can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
  can: rcar_canfd: Fix CAN-FD mode as default

Geert Uytterhoeven (17):
  can: rcar_canfd: Consistently use ndev for net_device pointers
  can: rcar_canfd: Remove bittiming debug prints
  can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
  can: rcar_canfd: Add helper variable dev to
    rcar_canfd_reset_controller()
  can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
  can: rcar_canfd: Repurpose f_dcfg base for other registers
  can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
  can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
  can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not
    FD
  can: rcar_canfd: Add support for Transceiver Delay Compensation
  can: rcar_canfd: Describe channel-specific FD registers using C struct
  can: rcar_canfd: Invert reset assert order
  can: rcar_canfd: Invert global vs. channel teardown
  can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
  can: rcar_canfd: Invert CAN clock and close_candev() order
  can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  can: rcar_canfd: Add suspend/resume support

 drivers/net/can/rcar/rcar_canfd.c | 672 +++++++++++++++++-------------
 1 file changed, 381 insertions(+), 291 deletions(-)

-- 
2.43.0


