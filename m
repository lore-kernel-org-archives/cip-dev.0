Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B6C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 07:48:27 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.124892.1680680906137344658
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 00:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1480188"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 04 Apr 2023 23:48:21 -0800
IronPort-SDR: 1J0q12Gy7fVu6h63LO9pJmdfQmJMGPppFPKuM4CiSPw57yddXxRh3BgykSepLnElHw+Cc30/t0
 7Y9EBw7SNoOdWPkxoZinmyO4rdFz/TYzSJViNFwLdogtOpkQdI4uQJ/FszppfFqsrlbA2KtJwH
 ch2Gr4iPRysU10o4CGWEX2mdRlOoxkMkPpfMdGHVyBHWP11RaycBozpmWQBdVtxpJjqyK5zgyO
 VcFgM5OeJYFXuvGDdbLaMmcucUT22WABzG2rCLLTpOZf0apZeb1rGyuokp/DLZSLHiFS8YOsyY
 Z48=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-core][PATCH] make script report all potential errors
Date: Wed, 5 Apr 2023 13:17:56 +0530
Message-ID: <20230405074756.600213-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 07:48:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11176

From: Srinuvasan A <srinuvasan_a@mentor.com>

Let us try and make sure that all bits we have are executed as expected.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 scripts/generate-sb-db-from-existing-certificate.sh | 3 +++
 scripts/generate_secure_boot_keys.sh                | 3 +++
 scripts/start-efishell.sh                           | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
index 035f189..ddaf4c9 100755
--- a/scripts/generate-sb-db-from-existing-certificate.sh
+++ b/scripts/generate-sb-db-from-existing-certificate.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+
+set -e
+
 name=${SB_NAME:-snakeoil}
 keydir=${SB_KEYDIR:-./keys}
 if [ ! -d  ${keydir} ]; then
diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
index 8d3f8c0..4988a68 100755
--- a/scripts/generate_secure_boot_keys.sh
+++ b/scripts/generate_secure_boot_keys.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+
+set -e
+
 name=${SB_NAME:-demo}
 keydir=${SB_KEYDIR:-./keys}
 if [ ! -d  ${keydir} ]; then
diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
index 980b9cc..cc8dc58 100755
--- a/scripts/start-efishell.sh
+++ b/scripts/start-efishell.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+
+set -e
+
 ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE_4M.secboot.fd}
 ovmf_vars=${OVMF_VARS:-./OVMF_VARS_4M.fd}
 DISK=$1
-- 
2.34.1


