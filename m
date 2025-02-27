Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C12C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12484.1740668247211775388
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: JiT6F6UURrST996jDdf8PA==
X-CSE-MsgGUID: OL18atU9TKGKYNUyJj6Wjw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:25 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E31A743439F2;
	Thu, 27 Feb 2025 23:57:23 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/11] ravb backports: MTU fix, VLAN & IPv6 support
Date: Thu, 27 Feb 2025 14:57:09 +0000
Message-ID: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17951

This patch series backports recent ravb driver improvements to CIP
5.10.y.

Paul Barker (11):
  net: ravb: Fix maximum TX frame size for GbEth devices
  net: ravb: Fix R-Car RX frame size limit
  net: ravb: Factor out checksum offload enable bits
  net: ravb: Disable IP header RX checksum offloading
  net: ravb: Drop IP protocol check from RX csum verification
  net: ravb: Simplify types in RX csum validation
  net: ravb: Disable IP header TX checksum offloading
  net: ravb: Simplify UDP TX checksum offload
  net: ravb: Enable IPv6 RX checksum offloading for GbEth
  net: ravb: Enable IPv6 TX checksum offload for GbEth
  net: ravb: Add VLAN checksum support

 drivers/net/ethernet/renesas/ravb.h      |   7 ++
 drivers/net/ethernet/renesas/ravb_main.c | 105 ++++++++++++++---------
 2 files changed, 72 insertions(+), 40 deletions(-)

-- 
2.43.0


