Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91671C282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.13398.1740670464074608951
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: yZX6nEJRSruBVwgq6eoeog==
X-CSE-MsgGUID: 8oKHoLICRDSE/uFuiMwp4w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:22 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E5C7E402CEAC;
	Fri, 28 Feb 2025 00:34:20 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6 support
Date: Thu, 27 Feb 2025 15:34:01 +0000
Message-ID: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17964

This patch series backports recent ravb driver improvements to CIP
6.1.y.

Paul Barker (12):
  net: ravb: Fix maximum TX frame size for GbEth devices
  net: ravb: Fix R-Car RX frame size limit
  net: ravb: Factor out checksum offload enable bits
  net: ravb: Disable IP header RX checksum offloading
  net: ravb: Drop IP protocol check from RX csum verification
  net: ravb: Combine if conditions in RX csum validation
  net: ravb: Simplify types in RX csum validation
  net: ravb: Disable IP header TX checksum offloading
  net: ravb: Simplify UDP TX checksum offload
  net: ravb: Enable IPv6 RX checksum offloading for GbEth
  net: ravb: Enable IPv6 TX checksum offload for GbEth
  net: ravb: Add VLAN checksum support

 drivers/net/ethernet/renesas/ravb.h      |   7 ++
 drivers/net/ethernet/renesas/ravb_main.c | 120 +++++++++++++----------
 2 files changed, 77 insertions(+), 50 deletions(-)

-- 
2.43.0


