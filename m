Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4CEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:17:56 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web11.8725.1687432672142410798
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:17:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,263,1681200000"; 
   d="scan'208";a="9668616"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 22 Jun 2023 03:17:50 -0800
IronPort-SDR: L3/ri8dOVpFMPzE73jPMNZUfrc3mZXasWOcT229pRLt8IB918AjfJ9Bcvb+fLIe+GJb5NCT0cU
 VOPIy5lQ4AEmiv5fLixiGjUXxKYo7nURe8LHUDecLJpX2A4GEDaFW923JIGHZmxuAMR4AO+P3w
 YXy1BRyuxHKxedS15VL6IlsVa07R/jB81gyglv6CFmzvoRfFf+HZbjhK4eN7ER5R2OeRHCgbqE
 Mdkvnb3sgsQg21v4iJ3CPKpgavoXJkW6DFOr8bD/2BXG9hbR5zQ2Wiz83BJY3TZHf7q6rXdpq6
 N0c=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-kernel/linux: update cip-kernels to latest one
Date: Thu, 22 Jun 2023 16:47:28 +0530
Message-ID: <20230622111728.1436562-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12120

From: Srinuvasan A <srinuvasan.a@siemens.com>

Now downstream layer needs the base version of 5.10 should be same for RT and
Non-RT kernels, hence update to the very latest one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 ...10.179-cip32-rt13.bb => linux-cip-rt_5.10.184-cip36-rt14.bb} | 2 +-
 ...{linux-cip_5.10.182-cip35.bb => linux-cip_5.10.184-cip36.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.179-cip32-rt13.bb => linux-cip-rt_5.10.184-cip36-rt14.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.182-cip35.bb => linux-cip_5.10.184-cip36.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb b/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
index 83f387e..044f55b 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.179-cip32-rt13.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.184-cip36-rt14.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "2106be5c70ee7d0074fb6767265a3613ce593dc4a5a46dcc6bf98697f251ebfd"
+SRC_URI[sha256sum] = "f45c47c9944c53920d483eb9b9be205e42c7d0af89f8c8c9bc0d3fb56a95e5c8"
diff --git a/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb b/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
rename to recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
index 86020b6..433a6ad 100644
--- a/recipes-kernel/linux/linux-cip_5.10.182-cip35.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.184-cip36.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "cc25a9303eb46f39ae882df646ba3c544494ae136e05812b1d1e7ebf9e8db28a"
+SRC_URI[sha256sum] = "a6405d852023099891f8d0530bf332c6cdba7654d6497ce83452df6ec1293152"
-- 
2.34.1


