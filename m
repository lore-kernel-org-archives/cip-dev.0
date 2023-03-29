Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C15C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 08:24:54 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.19361.1680078289582079789
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Mar 2023 01:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="744027"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 29 Mar 2023 00:24:46 -0800
IronPort-SDR: AXdukP+9W0dZtZUhiBFGBXH78T0WsT0YbWbzblhcog5MeN8mcxCEaY09TKV32mQRT7fuDKFyNR
 X+Calvg0kCgbPp9qSDI8q1Ksum+wm3cRHUURHyM9jsShY+jHaFuTW4h+38VhZD/IFPKR1r+39B
 3or7zMaEOJZ+gUmoUCMh6dLFuEBN3rZb/CT8GirZa2h5I59If86iaakgLJHyXxqDWpDs2VRJUv
 dP7iJGwoTDFsrcSDGppHF4JRyozizGQ2kIRTe7QhgcHHQVh2ucxMK11nB+FHX5074MLdn3r8wD
 pzM=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] make postinst script report all potential errors
Date: Wed, 29 Mar 2023 13:54:26 +0530
Message-ID: <20230329082426.355870-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 08:24:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11124

From: Srinuvasan A <srinuvasan.a@siemens.com>

Let us try and make sure that all bits we have are executed as expected.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 recipes-core/home-fs/files/postinst                 | 2 ++
 recipes-core/security-customizations/files/postinst | 2 ++
 recipes-core/tmp-fs/files/postinst                  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
index f6184d6..ab0db84 100755
--- a/recipes-core/home-fs/files/postinst
+++ b/recipes-core/home-fs/files/postinst
@@ -1,3 +1,5 @@
 #!/bin/sh
 
+set -e
+
 deb-systemd-helper enable home.mount  || true
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 167bab1..77a2713 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -4,6 +4,8 @@
 # Security Package configurations
 #
 
+set -e
+
 echo "CIP Core Security Image (login: root/Cipsecurity@123)" > /etc/issue
 
 HOSTNAME=demo
diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
index da41046..39067f1 100755
--- a/recipes-core/tmp-fs/files/postinst
+++ b/recipes-core/tmp-fs/files/postinst
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+set -e
+
 if [ ! -e /etc/systemd/system/tmp.mount ]; then
     cp /usr/share/systemd/tmp.mount /etc/systemd/system/tmp.mount
 fi
-- 
2.34.1


