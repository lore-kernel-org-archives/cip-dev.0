Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436BF109E540
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 02:59:58 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46163.1773651037108401753
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 01:50:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=VHW8tRdu;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.46.23, mailfrom: kamlesh@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amzUStZOwz4Ms7wJSMaAAZIeYnIlnf1aTr+qYEdLtI4Oo7AqcDZ/65xISp4q6GTJz4vST9amjjRp2ZFYqSLo930UnwJJfX367XPcz52jkTGJAd6lrB2d65qBRWDKxpHuqDtnMCFG8Jx1VAKKGVlasN2VCbhVa0nCLC1tv0BzZoVqU0gfXGwgyvmcGO8V2cBcXa/olKniPP71ZBa2/KMWmla5J4KzqvM12dbAnTMNg7Rl0bYIB7GgPL6Kacevk+KtKCXdhZK/Zktx2p968+kYlELy7iAAL71T+RvwiMBxMY1DKW2OIsxM/pOb1JeyV3uPe4UEkzoyfTrBeqN7fxivQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGDJBk+AZqN0IkecUyhOc+SSyWymZcWkGdvKuk2VjxM=;
 b=lNjGdFDfaxiu5aR5yasr7XKz4xpNese7ZqtgKOkIWriRv85fxQNS98+vcQjPjsinAPlY+7Y2FZdSpM+QZw0RfFnWY00w4TXabWXS9sATlaF2Fb5usjwGkb2InUo5+Vnc26WxGWMygXQdRolv6z02JY6Qj4vi8GbURh9LHLyx2EA7ZC/OUQPlBTayGzkjrP3vkjHqV3V47AUXsd8Wkx4wAjF826qLJ3Atui3LT9PM7lD+dxd8N1CMaVOk21yV0YVietyGofHipq/hvfDAFqjKR91ECqt8Nq1SWvmlKlNGZBFirYhr462JxmSkcawDdQCYrY4nKjHtjFCaw1n7cXaYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGDJBk+AZqN0IkecUyhOc+SSyWymZcWkGdvKuk2VjxM=;
 b=VHW8tRdujQbvTMHx3ZRzXn9ZWHzKC0mFLT52dyrSyplTvZ4DxWCv+RGFAgK/s0upFTbjV8n+AlP8UmmaWCym8oI4aD+JJH5tGN8qofb186uP7NlZo0VVufPQQ2L6CInzxcefv3J6WasLznRLYHYA5tqZI0A3Pry/++3MHj3hGyc=
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Mon, 16 Mar
 2026 08:35:40 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::63) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 08:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:35:39 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 03:34:58 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 03:34:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 03:34:57 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62G8YuWa963912;
	Mon, 16 Mar 2026 03:34:57 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Mon, 16 Mar 2026 14:04:43 +0530
Subject: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT header
MIME-Version: 1.0
Message-ID: <20260316-license-v1-1-5bb039f50c05@ti.com>
X-B4-Tracking: v=1; b=H4sIAKLAt2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mz3ZzM5NS84lTdZNO05JRUYzNDixQjJaDqgqLUtMwKsEnRsbW1ANp
 BHTlZAAAA
To: <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<pavel@denx.de>, <jan.kiszka@siemens.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773650096; l=10458;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=Pw4HQ7r206KtNrLgH1QgSCZg3M0wxC8Ezaixbv7HXn0=;
 b=aM/GC2bMB8Ue7+xnyKMEQbqzDzaDhTlopO6WQ5/82Twbk1qRotz8+58BWHne/0hd6SL9BSfTR
 4yM5N/s3rT3BfMZdXGq4E+uAQ61XqWzEWvWx33bi0LRnQlGSMkntjbD
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bc4e48-e8cc-4679-ace0-08de833700d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
 uJRc8xhrEXCsAfFyndwRKt5HlXeStWfocCgRbXJb1gv17oETeivGBS5lKNdanmf2Ai/2p7kptV/8BOxyCwqYaRQ8QSND+CFaZ90yFRU8xLMVQ8p+w2ibMkk2N5ehu0Sl91afta/cilCSUAGWqdkWjsduOY3G1AH2op3eq5/96TMWBUKFzgfEuFeAUX0o382bX3bPLgJSVmP3UfpUHsQRJO3hzFhSNaWkq1NqWi9wACGTxhBDXUkV+aDLv+bW4kT4xJrwShnwIIBzPwk5To++2gcwWdcUtpURy8Qvg5Hyi1zg+IGPEe1qeXi7Z4mJvj2nx0pesXz1tTjmnuV6rNEf7GqoAlP4W015t+rIahECXfr7fqIAhb0PNcXWrz8RNig7GoWHTEzb0Ljl2QhXCUkVgSvJZ1Ze6ZqVGRSwL2ZgVys3uIQ9YQixlKQLIq00D1/Bdc9T75DVy5GndcnLiU20sK2VurqmUDBSLWMH7uhY7qmyS3t7zAliGwKjRUPa/uuYEhGpsL27oU53xIm2VklgClgZglxDQwT23UEwhw6XEoDjCUxjtCkIL+iRd50t2VQ8Rb6hI0j1XXzWJH3RYox0udf7etrj3uu89cfdvQKBkFYu0x84clFwP2atWsGvKNz4lOfh7PITwvFSVHxiSjTMXCnLqVf15LqXa4mTgZv4BrbcmZMIO684d0q+ZGbqK47kiFFsTI/omvELeYGNqtjlsG9wGnJGN66FMVyHej5rSuAHdQY4Cb2FPhtVDDXETtDrIk3VqJZoJgnLgzfcPThQzw==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 boL+fCxI3RMNgsbx5JP0Qgv2jeqhUhxjiwgbl3ydC4FqpL0ZpT+nS93lN901pn3buZFxL+ioD2EguLzrQMq5r9aeLm9kObcbq1NIod5tbuv5Pd1XmBV+Ewz8qFHxoZuyma8gaghS66u7Ve5fgHg639cjvvOgVY2MzGeD+L4vp7f5YFjVx8veKIKybV5JaaDs+zC3l6phcVZWeskdP9yEzjWps0t9hhwCiPJhUKY85n5V8G/PE45zmBsLJo7bvdFmSlx6CA+Aj009zsHCizfAGo5FIvr5eZAscblZtvaeXneGBX82OH4VT7JtJ86qaX9sRRtkdCeWEO0vDuFqqO2iPvao8uhWXifcIXUgkRyuaQJA2sNL9/GjKCr9A2WFDggvuJ0KGo5V2xQqy8sZ5IAteWM3g8TmD0i/CzYQyUkZIZXJpVfN01pBv+U0EfrEp9Z7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:35:39.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bc4e48-e8cc-4679-ace0-08de833700d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 02:59:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22571

Add missing license headers to shell scripts and YAML test
templates.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 scripts/deploy-cip-core.sh                               | 3 +++
 scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
 scripts/generate_secure_boot_keys.sh                     | 3 +++
 scripts/start-efishell.sh                                | 3 +++
 scripts/submit_lava.sh                                   | 3 +++
 scripts/update-linux-cip.sh                              | 3 +++
 scripts/update-ltp.sh                                    | 3 +++
 tests/templates/IEC_template.yml                         | 3 +++
 tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
 tests/templates/secureboot_negative_test.yml             | 3 +++
 tests/templates/secureboot_template.yml                  | 3 +++
 tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
 tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
 tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
 tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
 tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
 tests/templates/swupdate_negative_test.yml               | 3 +++
 tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
 tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
 tests/templates/swupdate_template.yml                    | 3 +++
 20 files changed, 60 insertions(+)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 623c216..1e08e47 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
index dddd9b5..42d09dd 100755
--- a/scripts/generate-sb-db-from-existing-certificate.sh
+++ b/scripts/generate-sb-db-from-existing-certificate.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
index 8be0569..28ae34c 100755
--- a/scripts/generate_secure_boot_keys.sh
+++ b/scripts/generate_secure_boot_keys.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
index fff8a6a..86e2ddd 100755
--- a/scripts/start-efishell.sh
+++ b/scripts/start-efishell.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index b3180a1..a4d20ec 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -1,4 +1,7 @@
 #!/bin/bash
+#
+# SPDX-License-Identifier: MIT
+#
 # Copyright (C) 2024, Renesas Electronics Europe GmbH
 # Chris Paterson <chris.paterson2@renesas.com>
 # Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index 5fbfa57..df306b2 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -1,4 +1,7 @@
 #!/bin/bash
+#
+# SPDX-License-Identifier: MIT
+#
 REPO_ROOT=$(git rev-parse --show-toplevel)
 pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
 
diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
index dc8b947..321cc3c 100755
--- a/scripts/update-ltp.sh
+++ b/scripts/update-ltp.sh
@@ -1,4 +1,7 @@
 #!/bin/bash
+#
+# SPDX-License-Identifier: MIT
+#
 
 REPO_ROOT=$(git rev-parse --show-toplevel)
 pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index f8558cd..148f07e 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 device_type: qemu
 job_name: #architecture# IEC layer testing
 timeouts:
diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
index b6f6628..5c47b30 100644
--- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
+++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
           - "apt-get update"
           - "apt install -y fdisk"
           - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
index 2fcdbfa..a8e4226 100644
--- a/tests/templates/secureboot_negative_test.yml
+++ b/tests/templates/secureboot_negative_test.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 device_type: qemu
 job_name: #architecture# secure boot testing
 timeouts:
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index e29b64a..0a075e2 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 device_type: qemu
 job_name: #architecture# secure boot testing
 timeouts:
diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
index 8d64b05..f4f4043 100644
--- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
+++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
           - "apt-get update"
           - "apt install --yes guestfish sbsigntool"
           - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
index f097ed6..6ab334a 100644
--- a/tests/templates/secureboot_unsigned_kernel_steps.yml
+++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
           - "apt-get update"
           - "apt install --yes guestfish sbsigntool"
           - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
index 56ff106..69c9cb7 100644
--- a/tests/templates/swupdate-test-action-M-COM.yml
+++ b/tests/templates/swupdate-test-action-M-COM.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # TEST BLOCK 1
 # Fail the job if software update application failed
 - test:
diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
index 2fad3fd..043867e 100644
--- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
+++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
             - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
             - mkdir -p swu
             - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
index 74c9217..3cdb793 100644
--- a/tests/templates/swupdate_corrupt_swu_steps.yml
+++ b/tests/templates/swupdate_corrupt_swu_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
             - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
             - mkdir -p swu
             - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
index bb79b07..250eaa8 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 device_type: qemu
 job_name: #architecture# software update testing
 timeouts:
diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
index bfad106..074eb1a 100644
--- a/tests/templates/swupdate_reboot_without_confirm.yml
+++ b/tests/templates/swupdate_reboot_without_confirm.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # qemu-swtpm.sock will be gone after soft reboot.
 # So the swtpm socket need to be started again for proper reboot
 # To start the swtpm daemon, first the existing one should be killed
diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
index 3ff2e02..8329055 100644
--- a/tests/templates/swupdate_same_uuid_steps.yml
+++ b/tests/templates/swupdate_same_uuid_steps.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
             - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
             - mkdir -p swu
             - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index e1f71a9..9a3366b 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 device_type: qemu
 job_name: #architecture# software update testing
 timeouts:

---
base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
change-id: 20260316-license-c5fcde3618d2

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>


