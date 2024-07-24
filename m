Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9BC3DA70
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 09:12:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.6600.1721812365654207111
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 02:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212548611"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 18:12:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 67F744215B95;
	Wed, 24 Jul 2024 18:12:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/1] Revert "Add missing cache-level properties"
Date: Wed, 24 Jul 2024 10:12:36 +0100
Message-ID: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 09:12:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16611

The patch series revert the commit f703a1ddec6a ("arm64: dts: renesas:
rzg2l: Add missing cache-level properties") as it is triggering a warning
on linux-6.1.y-cip "cacheinfo: Unable to detect cache hierarchy for CPU 0"

The the proper fix needs backporting generic/architecture-specific changes
to support the "cache-level" in device tree.

Mainline patch[1]-[5] fixes the warning message, but there is drop in
ethernet rx performance on RZ/G2L SoCs and also triggers another warning
message "Early cacheinfo failed, ret = -2" on RZ/G2{H,M,N,E} family

patch [6]->[9] fixes the above  warning message. Still we left out with
ethernet rx performance on RZ/G2L SoCs, which needs backporting further
patches.
Since [1]->[9] impacts all architectures, it is better not to backport
these patches on linux-6.1.y-cip.

[1] commit c3719bd9 ("cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation")
[2] commit fa4d566a ("ACPI: PPTT: Remove acpi_find_cache_levels()")
[3] commit bd500361 ("ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()")
[4] commit 5944ce09("arch_topology: Build cacheinfo from primary CPU")
[5] commit 6a249151 ("Revert "riscv: Set more data to cacheinfo"")
[6] commit 3da72e18 ("cacheinfo: Decrement refcount in cache_setup_of_node()")
[7] commit ecaef469 ("cacheinfo: Initialize variables in fetch_cache_info()")
[8] commit c931680c("cacheinfo: Add arm64 early level initializer implementation")
[9] commit 6539cffa("cacheinfo: Add arch specific early level initializer")

Biju Das (1):
  Revert "arm64: dts: renesas: rzg2l: Add missing cache-level
    properties"

 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 1 -
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 1 -
 3 files changed, 3 deletions(-)

-- 
2.43.0


