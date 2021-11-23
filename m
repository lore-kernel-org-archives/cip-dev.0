Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83DFC433F5
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 18:25:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15345.1637691789082346069
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 10:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.87,258,1631545200";
   d="scan'208";a="101167957"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Nov 2021 03:23:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 97F8F400C44C;
	Wed, 24 Nov 2021 03:23:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][RESEND PATCH 2/2] conf: hihope-rzg2m: Enable
 tools and firmware for testing WiFi
Date: Tue, 23 Nov 2021 18:23:02 +0000
Message-Id: <20211123182302.8976-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123182302.8976-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211123182302.8976-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 18:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6983

HiHope RZ/G2M platform has WiFi module (WL1837) which requires additional
firmware (provided by firmware-ti-connectivity) for the chip to work.

This patch enables tools and firmware required for testing WiFi on
HiHope RZ/G2M platform.

Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 conf/machine/hihope-rzg2m.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index a2ae03d..4f4ee81 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -17,3 +17,6 @@ KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
 DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
+
+WIRELESS_FIRMWARE_PACKAGE = "firmware-ti-connectivity"
+INSTALL_WIRELESS_TOOLS ?= "1"
-- 
2.17.1


