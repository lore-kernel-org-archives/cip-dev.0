Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA9109E540
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:18 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15557.1774342628500484805
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 01:57:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=hoVK5nKF;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.201.42, mailfrom: kamlesh@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2szfm4hiB4MpM4UGBQ+G/tXu1vLIVeJqvwVrkA5w8NcV3lNoRCk+oIM0s8mEbG56EX7QHOOfa2uAQWguj5NbbRWHLxMZjwp4neLLBpFErGjeJKwzNxv+dw6nSujcdyaR6YWR1Gix7muJ13Fi+P3qBlMTK6IL/dttP5Unf8WeyGJ/S1YqvR3p3dLoGsoieTR7baEEtgwLbGiZciilNEqylrR9RAnsQ+LiI1QhdDF2LeI8Mq4VNgnPiN8VzAIOIuvL67QLUM2URfiyfWrS3A6C1er1EkPAlAFIN1v+PEno/r2q4NZ2Wuafua+GY1LFBIoHeL8ntdrIoeVKpI+burJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCzfHE5NS3ep39DdFoq4O6NZn8NCqcCP4AT35ZtwvJA=;
 b=hXUxb+NmpInS4A70lmp9UoFctQigag65jtxCBswVu+ys7TZ2fqluvDH2fp4+wP0sAzuRIjBlmMtfP967nD4ZMdK1JxPk3NNwLW0gG17mvqVupcqntzDbmza8e7B2rCASNMYp783zkidPzfkth8RUcdFee5CmmZMZH1wn90SjWDHFg95Pz0NIT1JRHit+iObiTZehqr6QOLMu21JCiGgkjcSDZvsRsNTOHxW6mXgCXm8okJBfQOArVnprycp5zhaAmC/mZRWNMiqbZmmF+K2/j+E7El9P6LOR6oiBki9rWMTqNQHM53K4WYXWR77ioP/BAi1oqXWdAsOjDYInT/Ev/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCzfHE5NS3ep39DdFoq4O6NZn8NCqcCP4AT35ZtwvJA=;
 b=hoVK5nKFZM/ARoqTV3Xqav6ei/a43AnAXUKSCGr947d1nvlQbSLfxX8KMXADMYPe2lUo0X/6WWNoyR1P9rKpuGM9ekKGTSEWdALwx+6D5OiB4tH4sSYWdqbIYa3o1C68Ge0c9IARQl9o8sOTiF/ju8zRftHFm4UG8LR9GtFo64U=
Received: from BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::7)
 by CYYPR10MB7568.namprd10.prod.outlook.com (2603:10b6:930:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:41:19 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::96) by BL1P223CA0038.outlook.office365.com
 (2603:10b6:208:5b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:41:18 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 03:41:17 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 03:41:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 03:41:17 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62O8fFkj1840162;
	Tue, 24 Mar 2026 03:41:16 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Tue, 24 Mar 2026 14:10:53 +0530
Subject: [PATCH isar-cip-core v2] *: Add SPDX-License-Identifier MIT header
MIME-Version: 1.0
Message-ID: <20260324-license-v2-1-1ca6dd83f0e8@ti.com>
X-B4-Tracking: v=1; b=H4sIABROwmkC/2WNywrCMBBFf6XM2pE8SFBX/od00U4ndkCbkpSil
 Py7IVuXh3s494DMSTjDrTsg8S5Z4lLBnDqgeViejDJVBqOMV1Z7fAnxkhnJBZrYen2ZDFR7TRz
 k00oPkDwkJFmRYmLo6zxL3mL6tp9dN+kvuWvU6MZR2WtwipS7b3Km+Ia+lPIDTnJRS6oAAAA=
To: <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<pavel@denx.de>, <jan.kiszka@siemens.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774341675; l=36107;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=JjGKSjymD2YtdlCx3SCwFJ6ib4chxEqGG8ViUYht91I=;
 b=GxJ1t8HwPdurIzsG1/99iK8E7ARnaxbVDNhYZ6CDyAyw/EL5K42Cv8osUP6636i6X0qQijehI
 h7MOPSbeR2LBQWQcdF4hYRtQbfmh77mEzrXOxKUPYrRa75Oq5stf1Xr
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CYYPR10MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: b32e2d1a-0810-4c63-eb25-08de89811e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	/DWrdpdI1mWfUAKig1bQ0HaG2HQ2v40CsF+E99dbARklCqJC5EN/6inUSjQ72s7kMkYL6lIfsPBQ+8x19K0xbFMm5udR+NI4ZBqWvykfeYfgIQ3cMITUApMRUEZKF97FBHQW+KzLCom4HIzI81rVmfJDMd1y6twIZNgPMMi0twTg/amyF3AF7KY+O7H1sAazXlmHw9l+Igvtj88IMr7g32YwOcJVKa9RUJBA51tUtHet8IOsWy/5vvrT06vqPJYQ6MA3PrRxEO/j7lphhMJg47U1qku6cpOS8iobuuy+KMANmunJ+9yZXZLD2AQZii9MZm3obQIvABREnOnytlzz0xgJNVOig12besNK4UWs/cAhxIN+53ji79qEVbXLIz8yVFQoRrQmKlPdTCseB3QZAFPkxHzIWe7pwlmS3CjjHoE0jnMbsf0VJhmzzvF8nMjAO/owA65a7mbhkRb6aS3pnOIoy+1esUUt7ryEFeoKMUpWj8C080ntuDYO2YYwP6VzBZl+rMU2MmalQxjjT/kayUwqbMF7FL0i7vGIrk3gET9QFfnsdv0BkjO6qNDhmanv3w+Eyjl1cvGNFofytLvOHwybxRDG9h90KbxxtRcz3nuUcE0ATr5ZuZwq4iTilqCSqhyS3TtRWz/4iQ/cpdki+qW+I2nqNlhipJ5YFbW+7As8epaKO2PYVMVQz4JyGeH1NNL5kbwNfqyvDPqZr7x0k9WsbnsLQVGPiFPMEXq6TYc=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JufSCuU+2+eUqfxvy/JWa5h1WVAD7PRUacstUhk5C8u2+Auo/4PpKHSypr3EdKfUwmjHN2uVfXDZ9k/A5LiJujxfv0KfYZirVHbFEMkC2VKeiv5CqLPw7L7mNHD/nC2CLs6XaoCHT43v2ZSkHFO4zN8oj7yumRR1qy/AZuQ6/mndERfzztDPpd52zkqj4WKRHp5JLvINsGwWnCQ5L9ApVpMqPHVzdhk6c+NQcQWooviZnRFgAHmN5Q+KR+8FbdBuxWoftxjl1kDny7fG0p19CPqpTJG0bFkvhfLiXxZbyAzcWfos57yLgyzmI2V47/3f4cuw/Y2PHIIqV8WS2PwcslfCO0oCiMhgdEkY1R6DPKuDlc3SQZu1czMmcBa2NhHAo9YKQ1tNvTlxe2S7YY9moWIXu4ziqa3hJyCgR4dUhD74xAdpu2L53Gabb67R/HEu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:41:18.1477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32e2d1a-0810-4c63-eb25-08de89811e29
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7568
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 03:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22573

Add missing license headers to configuration, template, script,
and wic partition layout files to make licensing consistent
across the repository.

Command Used:
git ls-files | xargs grep -rL SPDX-License-Identifier

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v2:
- added license to remaining files
- Link to v1: https://lore.kernel.org/r/20260316-license-v1-1-5bb039f50c05@ti.com
---
 conf/distro/debian-bullseye-backports.list                                       | 3 +++
 conf/distro/debian-buster-backports.list                                         | 3 +++
 conf/distro/preferences.ovmf-snakeoil.conf                                       | 3 +++
 conf/distro/preferences.swupdate-bullseye-backports.conf                         | 3 +++
 recipes-bsp/u-boot/files/ftpm-stmm.cfg                                           | 3 +++
 recipes-bsp/u-boot/files/no-grub-workaround.cfg                                  | 3 +++
 recipes-bsp/u-boot/files/qemu-extra.cfg                                          | 3 +++
 recipes-bsp/u-boot/files/secure-boot.cfg                                         | 3 +++
 recipes-bsp/u-boot/files/ti-extra.cfg                                            | 3 +++
 recipes-core/customizations/files/99-silent-printk.conf                          | 3 +++
 recipes-core/customizations/files/99-watchdog.conf                               | 3 +++
 recipes-core/customizations/files/ssh-permit-root.conf                           | 3 +++
 recipes-core/home-fs/files/home.mount                                            | 3 +++
 recipes-core/home-fs/files/postinst                                              | 3 +++
 recipes-core/immutable-rootfs/files/95-disable-package-updates.preset            | 3 +++
 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl               | 3 +++
 recipes-core/immutable-rootfs/files/postinst                                     | 3 +++
 recipes-core/journald-config/files/persistent-journal.conf                       | 3 +++
 recipes-core/kernel-panic/files/sysrq-panic.service                              | 3 +++
 recipes-core/ltp/files/debian/control.tmpl                                       | 3 +++
 recipes-core/ltp/files/debian/rules                                              | 3 +++
 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl               | 3 +++
 recipes-core/security-customizations/files/postinst                              | 2 ++
 recipes-core/security-customizations/files/ssh-pam-remote.conf                   | 3 +++
 recipes-core/security-customizations/files/ssh-remote-session-term.conf          | 3 +++
 recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl                   | 3 +++
 recipes-core/swupdate-config/files/hwrevision.tmpl                               | 3 +++
 recipes-core/swupdate-config/files/swupdate.cfg                                  | 3 +++
 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini | 3 +++
 recipes-core/tmp-fs/files/postinst                                               | 3 +++
 recipes-devtools/swupdate-signer/files/sign-swu-cms                              | 3 +++
 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl          | 3 +++
 recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf                      | 3 +++
 recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl   | 2 ++
 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl              | 3 +++
 recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl                 | 2 ++
 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script    | 2 ++
 recipes-kernel/linux/files/no-module-signing.cfg                                 | 3 +++
 recipes-kernel/linux/files/no-tpm-hwrng.cfg                                      | 3 +++
 recipes-kernel/linux/files/preempt-rt.cfg                                        | 3 +++
 recipes-security/fail2ban-config/files/systemd-defaults.conf                     | 3 +++
 scripts/deploy-cip-core.sh                                                       | 3 +++
 scripts/generate-sb-db-from-existing-certificate.sh                              | 3 +++
 scripts/generate_secure_boot_keys.sh                                             | 3 +++
 scripts/start-efishell.sh                                                        | 3 +++
 scripts/submit_lava.sh                                                           | 3 +++
 scripts/update-linux-cip.sh                                                      | 3 +++
 scripts/update-ltp.sh                                                            | 3 +++
 tests/templates/IEC_template.yml                                                 | 3 +++
 tests/templates/secureboot_corrupt_rootfs_steps.yml                              | 3 +++
 tests/templates/secureboot_negative_test.yml                                     | 3 +++
 tests/templates/secureboot_template.yml                                          | 3 +++
 tests/templates/secureboot_unsigned_bootloader_steps.yml                         | 3 +++
 tests/templates/secureboot_unsigned_kernel_steps.yml                             | 3 +++
 tests/templates/swupdate-test-action-M-COM.yml                                   | 3 +++
 tests/templates/swupdate_corrupt_swu_artifact_steps.yml                          | 3 +++
 tests/templates/swupdate_corrupt_swu_steps.yml                                   | 3 +++
 tests/templates/swupdate_negative_test.yml                                       | 3 +++
 tests/templates/swupdate_reboot_without_confirm.yml                              | 3 +++
 tests/templates/swupdate_same_uuid_steps.yml                                     | 3 +++
 tests/templates/swupdate_template.yml                                            | 3 +++
 wic/ebg-signed-sysparts.inc                                                      | 3 +++
 wic/ebg-sysparts.inc                                                             | 3 +++
 wic/hihope-rzg2m-efibootguard.wks.in                                             | 3 +++
 wic/qemu-arm64-efibootguard-secureboot.wks.in                                    | 3 +++
 wic/qemu-arm64-efibootguard.wks.in                                               | 3 +++
 wic/qemu-riscv64-efibootguard.wks.in                                             | 3 +++
 wic/x86-uefi-efibootguard-secureboot.wks.in                                      | 3 +++
 wic/x86-uefi-efibootguard.wks.in                                                 | 3 +++
 69 files changed, 203 insertions(+)

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
index 1594907..6107928 100644
--- a/conf/distro/debian-bullseye-backports.list
+++ b/conf/distro/debian-bullseye-backports.list
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 deb http://archive.debian.org/debian bullseye-backports main contrib non-free
diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
index 7134a35..842019e 100644
--- a/conf/distro/debian-buster-backports.list
+++ b/conf/distro/debian-buster-backports.list
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 deb http://archive.debian.org/debian buster-backports main contrib non-free
diff --git a/conf/distro/preferences.ovmf-snakeoil.conf b/conf/distro/preferences.ovmf-snakeoil.conf
index b51d1d4..25b7da4 100644
--- a/conf/distro/preferences.ovmf-snakeoil.conf
+++ b/conf/distro/preferences.ovmf-snakeoil.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 Package: ovmf
 Pin: release n=buster-backports
 Pin-Priority: 801
diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
index c5f6685..da307cd 100644
--- a/conf/distro/preferences.swupdate-bullseye-backports.conf
+++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 Package: dh-nodejs
 Pin: release n=bullseye-backports
 Pin-Priority: 801
diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
index af5da93..a6fe2a3 100644
--- a/recipes-bsp/u-boot/files/ftpm-stmm.cfg
+++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 ### Enable OPTEE, fTPM and StMM
 CONFIG_TEE=y
 CONFIG_OPTEE=y
diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
index dc09edd..8a01ff6 100644
--- a/recipes-bsp/u-boot/files/no-grub-workaround.cfg
+++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
@@ -1,2 +1,5 @@
+#
+# SPDX-License-Identifier: MIT
+#
 ### Disable grub workaround
 # CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
index e643db7..5380ad8 100644
--- a/recipes-bsp/u-boot/files/qemu-extra.cfg
+++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 ### QEMU extra config
 CONFIG_MMC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 694356f..7b09a53 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 ### Secure boot config
 # CONFIG_BOOTSTD_DEFAULTS is not set
 # CONFIG_BOOTMETH_CROS is not set
diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
index c10d046..9500055 100644
--- a/recipes-bsp/u-boot/files/ti-extra.cfg
+++ b/recipes-bsp/u-boot/files/ti-extra.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 ### FTPM + RPMB + StandaloneMM setup
 CONFIG_OPTEE_SERVICE_DISCOVERY=y
 CONFIG_TPM=y
diff --git a/recipes-core/customizations/files/99-silent-printk.conf b/recipes-core/customizations/files/99-silent-printk.conf
index ad24d3a..c5b3799 100644
--- a/recipes-core/customizations/files/99-silent-printk.conf
+++ b/recipes-core/customizations/files/99-silent-printk.conf
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 kernel.printk = 3 4 1 3
diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-core/customizations/files/99-watchdog.conf
index c02756d..1f38c55 100644
--- a/recipes-core/customizations/files/99-watchdog.conf
+++ b/recipes-core/customizations/files/99-watchdog.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [Manager]
 RuntimeWatchdogSec=60s
 ShutdownWatchdogSec=60s
diff --git a/recipes-core/customizations/files/ssh-permit-root.conf b/recipes-core/customizations/files/ssh-permit-root.conf
index 1073982..ab26ab5 100644
--- a/recipes-core/customizations/files/ssh-permit-root.conf
+++ b/recipes-core/customizations/files/ssh-permit-root.conf
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 PermitRootLogin yes
diff --git a/recipes-core/home-fs/files/home.mount b/recipes-core/home-fs/files/home.mount
index 062517a..653495c 100644
--- a/recipes-core/home-fs/files/home.mount
+++ b/recipes-core/home-fs/files/home.mount
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [Unit]
 Description=Mount /home partition
 Before=local-fs.target
diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
index ab0db84..904aa73 100755
--- a/recipes-core/home-fs/files/postinst
+++ b/recipes-core/home-fs/files/postinst
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
index 7e6e9ef..b3b52ce 100644
--- a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
+++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 disable apt-daily.timer
 disable apt-daily-upgrade.timer
 disable dpkg-db-backup.timer
diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
index e6d25d2..4cdfc6f 100644
--- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
+++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
 d /var/log/audit 0700 root adm -
 d /var/lib/apt 0755 root root -
diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
index a6e1962..3b8071e 100644
--- a/recipes-core/immutable-rootfs/files/postinst
+++ b/recipes-core/immutable-rootfs/files/postinst
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
index 21dfde0..3e3419f 100644
--- a/recipes-core/journald-config/files/persistent-journal.conf
+++ b/recipes-core/journald-config/files/persistent-journal.conf
@@ -1,2 +1,5 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [Journal]
 Storage=persistent
diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
index 4f199fe..e892165 100644
--- a/recipes-core/kernel-panic/files/sysrq-panic.service
+++ b/recipes-core/kernel-panic/files/sysrq-panic.service
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [Unit]
 Description=sysrq panic
 
diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
index 0bfc0c2..a7d0087 100644
--- a/recipes-core/ltp/files/debian/control.tmpl
+++ b/recipes-core/ltp/files/debian/control.tmpl
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 Source: ltp-full
 Section: embedded
 Priority: optional
diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
index 4e1747c..32d3c29 100755
--- a/recipes-core/ltp/files/debian/rules
+++ b/recipes-core/ltp/files/debian/rules
@@ -1,4 +1,7 @@
 #!/usr/bin/make -f
+#
+# SPDX-License-Identifier: MIT
+#
 export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
 export DEB_BUILD_MAINT_OPTIONS=hardening=-branch
 
diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
index 92e4a30..1821f92 100644
--- a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
+++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
@@ -1,2 +1,5 @@
+#
+# SPDX-License-Identifier: MIT
+#
 L /home - - - - /var/home
 C /var/home - - - - ${IMMUTABLE_DATA_DIR}/home
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index f8ebf9e..788e225 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -3,6 +3,8 @@
 # CIP Security, generic profile
 # Security Package configurations
 #
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-core/security-customizations/files/ssh-pam-remote.conf
index d460b0c..ea120b2 100644
--- a/recipes-core/security-customizations/files/ssh-pam-remote.conf
+++ b/recipes-core/security-customizations/files/ssh-pam-remote.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # Enable PAM configuration for Remote Session
 ChallengeResponseAuthentication yes
 KbdInteractiveAuthentication yes
diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
index d11b92e..171ea9b 100644
--- a/recipes-core/security-customizations/files/ssh-remote-session-term.conf
+++ b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # CR2.6: Remote session termination
 # Terminate remote session after inactive time period
 
diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
index 744b426..f750f3d 100644
--- a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
+++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
index 1eb0996..b937200 100644
--- a/recipes-core/swupdate-config/files/hwrevision.tmpl
+++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
@@ -1 +1,4 @@
+#
+# SPDX-License-Identifier: MIT
+#
 cip-${MACHINE} ${MACHINE_HW_VERSION}
diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
index 3e2b45c..5c05fbe 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 globals :
 {
     bootloader = "ebg";
diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
index 58271da..8f93cc9 100644
--- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
+++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [image]
 chainhandler=raw
 
diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
index 39067f1..ae0f74a 100755
--- a/recipes-core/tmp-fs/files/postinst
+++ b/recipes-core/tmp-fs/files/postinst
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 
 set -e
 
diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
index cb0cd4a..bc1ec13 100644
--- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
+++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 in_file=$1
 out_file=$2
 inkey="/usr/share/swupdate-signing/swupdate-sign.key"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index bb93361..452714d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 PARTITIONS="${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
 SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
index d4c8981..8e087f2 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
+++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # we don't have a dictionary in the initramfs
 # this solves the error "Password generation failed - required entropy too low for settings"
 dictcheck = 0
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
index f0ad40c..94b5f8b 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
@@ -7,6 +7,8 @@
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
+# SPDX-License-Identifier: MIT
+#
 . /usr/share/factory-reset/reset-env
 
 . /scripts/cip-initramfs-functions
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
index d3e18a2..07e2376 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -1,3 +1,6 @@
 #!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
 INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index bce588c..8a697f8 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -7,6 +7,8 @@
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
+# SPDX-License-Identifier: MIT
+#
 
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
index 0cd084b..11ca731 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
@@ -7,6 +7,8 @@
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
 #
+# SPDX-License-Identifier: MIT
+#
 
 partition_fstype="$1"
 ovl_partition_device="$2"
diff --git a/recipes-kernel/linux/files/no-module-signing.cfg b/recipes-kernel/linux/files/no-module-signing.cfg
index ab54f68..064ef9c 100644
--- a/recipes-kernel/linux/files/no-module-signing.cfg
+++ b/recipes-kernel/linux/files/no-module-signing.cfg
@@ -1,2 +1,5 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # CONFIG_SECURITY_LOCKDOWN_LSM is not set
 # CONFIG_MODULE_SIG is not set
diff --git a/recipes-kernel/linux/files/no-tpm-hwrng.cfg b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
index ab46cd8..08e98ff 100644
--- a/recipes-kernel/linux/files/no-tpm-hwrng.cfg
+++ b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
@@ -1,2 +1,5 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # see https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/
 # CONFIG_HW_RANDOM_TPM is not set
diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
index afbf53d..f558365 100644
--- a/recipes-kernel/linux/files/preempt-rt.cfg
+++ b/recipes-kernel/linux/files/preempt-rt.cfg
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # >= 5.10
 CONFIG_EXPERT=y
 CONFIG_PREEMPT_RT=y
diff --git a/recipes-security/fail2ban-config/files/systemd-defaults.conf b/recipes-security/fail2ban-config/files/systemd-defaults.conf
index 16e0d5e..32a8e48 100644
--- a/recipes-security/fail2ban-config/files/systemd-defaults.conf
+++ b/recipes-security/fail2ban-config/files/systemd-defaults.conf
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 [DEFAULT]
 
 syslog_backend = systemd
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
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index c35878f..8210598 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # default partition layout EFI Boot Guard usage, signed version
 
 # EFI partition containing efibootguard bootloader binary
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 0290024..b7f1afa 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index fdbad14..99c8d10 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
 # long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
 
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 941a552..88eb91c 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 21c0b24..117c47c 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # short-description: arm64 with EFI Boot Guard and SWUpdate
 # long-description: Disk image for arm64 machines with EFI Boot Guard and SWUpdate
 
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 948c67d..a5dd09b 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # short-description: riscv64 with EFI Boot Guard and SWUpdate
 # long-description: Disk image for riscv64 machines with EFI Boot Guard and SWUpdate
 
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
index 2af3e58..f15f9e0 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 3640ecf..982a87a 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
 # short-description: x86 with EFI Boot Guard and SWUpdate
 # long-description: Disk image for x86 machines with EFI Boot Guard and SWUpdate
 

---
base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
change-id: 20260316-license-c5fcde3618d2

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>


