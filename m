Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E598C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.30783.1641817416038646453
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011109"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9230842AC9F0;
	Mon, 10 Jan 2022 21:23:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/61] Add Ethernet support to RZ/G2L
Date: Mon, 10 Jan 2022 12:22:30 +0000
Message-Id: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7365

Hi All,

This patch series adds Ethernet support to RZ/G2L SoC and enables ETH support
on RZ/G2L SMARC EVK.

All the patches have been cherry picked from v5.16-rc8.

Patches apply on top of [0].

[0] https://patchwork.kernel.org/project/cip-dev/cover/
20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Adam Ford (3):
  dt-bindings: net: renesas,etheravb: Add additional clocks
  net: ethernet: ravb: Enable optional refclk
  net: ethernet: ravb: Fix release of refclk

Biju Das (53):
  dt-bindings: net: renesas,etheravb: Document Gigabit Ethernet IP
  dt-bindings: net: renesas,etheravb: Drop "int_" prefix and "_n" suffix
    from interrupt names
  ravb: Fix a typo in comment
  ravb: Use unsigned int for num_tx_desc variable in struct ravb_private
  ravb: Add struct ravb_hw_info to driver data
  ravb: Add aligned_tx to struct ravb_hw_info
  ravb: Add max_rx_len to struct ravb_hw_info
  ravb: Add stats_len to struct ravb_hw_info
  ravb: Add gstrings_stats and gstrings_size to struct ravb_hw_info
  ravb: Add net_features and net_hw_features to struct ravb_hw_info
  ravb: Add internal delay hw feature to struct ravb_hw_info
  ravb: Add tx_counters to struct ravb_hw_info
  ravb: Remove the macros NUM_TX_DESC_GEN[23]
  ravb: Add multi_irq to struct ravb_hw_info
  ravb: Add no_ptp_cfg_active to struct ravb_hw_info
  ravb: Add ptp_cfg_active to struct ravb_hw_info
  ravb: Factorise ravb_ring_free function
  ravb: Factorise ravb_ring_format function
  ravb: Factorise ravb_ring_init function
  ravb: Factorise ravb_rx function
  ravb: Factorise ravb_adjust_link function
  ravb: Factorise ravb_set_features
  ravb: Factorise ravb_dmac_init function
  ravb: Factorise ravb_emac_init function
  ravb: Add reset support
  ravb: Rename "ravb_set_features_rx_csum" function to
    "ravb_set_features_rcar"
  ravb: Rename "no_ptp_cfg_active" and "ptp_cfg_active" variables
  ravb: Add nc_queue to struct ravb_hw_info
  ravb: Add support for RZ/G2L SoC
  ravb: Initialize GbEthernet DMAC
  ravb: Exclude gPTP feature support for RZ/G2L
  ravb: Add tsrq to struct ravb_hw_info
  ravb: Add magic_pkt to struct ravb_hw_info
  ravb: Add half_duplex to struct ravb_hw_info
  ravb: Remove extra TAB
  ravb: Initialize GbEthernet E-MAC
  ravb: Add rx_max_buf_size to struct ravb_hw_info
  ravb: Use ALIGN macro for max_rx_len
  ravb: Fillup ravb_alloc_rx_desc_gbeth() stub
  ravb: Fillup ravb_rx_ring_free_gbeth() stub
  ravb: Fillup ravb_rx_ring_format_gbeth() stub
  ravb: Fillup ravb_rx_gbeth() stub
  ravb: Add carrier_counters to struct ravb_hw_info
  ravb: Add support to retrieve stats for GbEthernet
  ravb: Rename "tsrq" variable
  ravb: Optimize ravb_emac_init_gbeth function
  ravb: Rename "nc_queue" feature bit
  ravb: Update ravb_emac_init_gbeth()
  ravb: Fix typo AVB->DMAC
  clk: renesas: r9a07g044: Add ethernet clock sources
  clk: renesas: r9a07g044: Add GbEthernet clock/reset
  arm64: dts: renesas: r9a07g044: Add GbEthernet nodes
  arm64: dts: renesas: rzg2l-smarc-som: Enable Ethernet

Geert Uytterhoeven (2):
  dt-bindings: net: renesas,etheravb: Fix optional second clock name
  ravb: Remove checks for unsupported internal delay modes

Sergey Shtylyov (2):
  ravb: remove APSR_DM
  ravb: update "undocumented" annotations

Yang Yingliang (1):
  net: ethernet: ravb: Use devm_platform_get_and_ioremap_resource()

 .../bindings/net/renesas,etheravb.yaml        |  50 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  40 +
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  97 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   1 -
 drivers/clk/renesas/r9a07g044-cpg.c           |  29 +-
 drivers/clk/renesas/rzg2l-cpg.h               |   3 +
 drivers/net/ethernet/renesas/ravb.h           | 116 +-
 drivers/net/ethernet/renesas/ravb_main.c      | 991 ++++++++++++++----
 drivers/net/ethernet/renesas/ravb_ptp.c       |   8 +-
 9 files changed, 1082 insertions(+), 253 deletions(-)

-- 
2.17.1


