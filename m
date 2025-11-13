Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BCCD5BB4
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:14:57 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20433.1763028887041618804
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:14:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=aN4W8cM9;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.51, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quHGaGOtqksBBIbOqjuPzTS2k186b6w5vfju9lh59UVEZdpdq6oK5jL9oRCAx/DuuUUmt45O1lMnGzA2/ipTM6koKPUcmNUxmK1pk4EMSsMlm1n24FVODA1D9/jhkkEL3UGwwfDgduyVLRgaoTHYhUTcCZbJwulfzZo7kdcSf6mK70QtLOqXjrHknxxB7pVxKr0TNFh2F/0fascp2ajNmqsS7Mb5w1GkjdQz8H+STB79b+aQfg3ui/IBd7v3UYlTGPg8xx9c4ODYuGf2xp+LRNrQPd3TwqnOz8UhNNjQ4dJbI2DcLz58JUFUIk8HSu9LohnpgtCybgxL90zFQeFTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knqd0PNdBaN3k0ZVLM/3jYhCul6xEQX1RHSV6WEF/2g=;
 b=q9fB97M5vCV3jHU9HolkMjBJFR6ZP3M5iahYfwrcyha5N40OiLTlK4ZivhxEU9ha2f8xZzESWsQkQBDCeHvexJjjObuuFeysU1UXDUgRFfAZ2eWBsmlQAI1TumAOsulmTTBM/j/drInipjbqo+XFM5idzDBmrXedoENcDRk1jKZHO60trjqNkBry10kUZbq/ad1vH/CHUw3vc71l1nTbmpNCqysAyhgp4rkW+5A2KANF6mMVw8SML+CoTa8g+/AZRBINx11U1FcdMPMI3S6lCEAotGVvbKcADw7Ekb1MLHsfSIifrB/Fg0L1fN4sYh4vsyrooGa/41nJDb9wfPUgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knqd0PNdBaN3k0ZVLM/3jYhCul6xEQX1RHSV6WEF/2g=;
 b=aN4W8cM9d3JN+d/JyIJbE2yX8QFqFv3t2EBRZzAKRPFgSTreSf6PWZh7CIwPap7F1DYf22wcJcAe7Ae93Ijx/8BAzckjyZ1AHZSohSX31BNjlkYEyYqTv2CkzQwZsmO5mObkrnF3Eif32xf7wVyuUU0nAvYo9arBhLsK039ZXY8=
Received: from CH5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:1f1::7)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:14:44 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::80) by CH5PR03CA0006.outlook.office365.com
 (2603:10b6:610:1f1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:14:42 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:38 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:14:38 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAES1U058943;
	Thu, 13 Nov 2025 04:14:37 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 5/5] ti-am62px-sk: enable data encryption with optee-ftpm
Date: Thu, 13 Nov 2025 15:44:25 +0530
Message-ID: <20251113101425.1177129-6-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113101425.1177129-1-s-adivi@ti.com>
References: <20251113101425.1177129-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e32741-f51b-4d3f-b19d-08de229d76b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7ModbnodnGxO+VPB9TfSjFebWTKjWZlKPoyHTF1IrJiMxLXsKZbQnIImbinh?=
 =?us-ascii?Q?9w+E5VPA7kTotsp9xAnkXlSIt/QnSojhhaX2a9jqmHWfM6BM9nrj2O4beEUp?=
 =?us-ascii?Q?NH+zehRAosjdAiJLWyJF+263wXUcUY/6DeieW+/pRTIH5ewA8JJB9mXkinuG?=
 =?us-ascii?Q?Z9SDgQ2TmzegxKXJaqUG/nq2KrzBj/6vltqt8sM6ufYkd+yQzPtNG7BKXIIO?=
 =?us-ascii?Q?AjZIjSiw9awF9t7cTfzFEaA+vxX/ZUZkL73ozZGI55rbZiW2eKXmPAWn076x?=
 =?us-ascii?Q?6xVQZY28dJU8ieLmy5PBK7rjp6BU77FBBP7Pk53eQ9hVNg2/X/+CBBfsBuJM?=
 =?us-ascii?Q?VkZAl8tpA3M1WZZ4KyM1HsypaTEKFxgVYBV+Lf8xBY6yTj+67udJbKn6snSD?=
 =?us-ascii?Q?fnFHOLsFnl9GLkSfTcO5HxkZMttpa/BMIhKD2vSmp0fJmHe3HhfiQkDvTT87?=
 =?us-ascii?Q?Xc5w5AZnz7OYM/zbqcLVV6MJqekzwUwONMT5YU4RKZzy3EKkbdadnWxCQ6i9?=
 =?us-ascii?Q?pLyZYE6i+fY3sYlz9ief8jw1mQvejFrdt1CqjfVkQy7yPGKNCOAW+mnZn9jB?=
 =?us-ascii?Q?saU2KTDmdsVXGD5b8wVfhEnMJN5ZtdjaXI4Bm+qfi3oyr2al0xiNuGQNaDra?=
 =?us-ascii?Q?Cj0KZ7vi5e5+F8XjhncYSlfMAEf1Evca3WbsjfcgaEpSzki4rOtrf/HzuEw8?=
 =?us-ascii?Q?iJEJMNynP5+Px3kMMdtotpXLU3EDRNer8dj8PeC+Ns7qTiDtVVM85v8Qw9EA?=
 =?us-ascii?Q?JJGxLk25zZaTklSnN7CJVvspKLwxxah4wP26Wm6x3+iwvm9PsQkG1KsRcYoO?=
 =?us-ascii?Q?whd25H4J8VaQEvNCUFegy+bTDexXyfdxJ+CZM+pyXRQiv8FEXotgb2BM0QE1?=
 =?us-ascii?Q?0c8giwAW+dc20CVU0La3wwXGxk7cMHWu3t5ULlsRB32uKWv5poXa12eSzF/m?=
 =?us-ascii?Q?ATIIEsGugMvr798CMHeGfw77UsNks/GKujTcX2JK7zcxCvyE2xiwpEkL0fzE?=
 =?us-ascii?Q?0Nrf2iP9C9eR8S7no9GzUe2WZ8Xq60v8NvjiveKyZ7pOOtpPf6jtITO5dBoN?=
 =?us-ascii?Q?j1s4AYp8+W9e0kKfO6YH2b24LhZAFwbcns+5gOPC3+niLrbZJIszb32x+4AY?=
 =?us-ascii?Q?i1zBQDMn8gFsymAOvet36XrD8M2xhjgK2rgpMsFZHUH47TFVYCLGBhEganXA?=
 =?us-ascii?Q?5TIY7HU0OAIcJw9ilL5mYMS1/npXUL2vDRdc45TIajNnXp661JslS/26JdcU?=
 =?us-ascii?Q?1PP9Z4zKyKFaDKPgDuKxCft3XvMH30fllB+ZEV56KZ+SF33815S3+NO9gZBa?=
 =?us-ascii?Q?22q039cB/zO5/JoGOeA56PjIkjZKg38CwKAgm7UCpKUehLmB214Gqi4Ys6ob?=
 =?us-ascii?Q?wJ9rkrU5MelO6z9wCJ7Z/y56TaN5ANGZ9XJq+7CwzkC5GADWGBNCTpUmMl5V?=
 =?us-ascii?Q?qvOLVQnvt9ezYSuXC5SA7No3faCvqGoD8HJWqRIHRrchNLqzPVS+rISw/hdt?=
 =?us-ascii?Q?6vCXMoYZom4lVziTWN4rJT2F8TtLDRZ05x3LuVTHu6/obwKvxM6oHIA1T2EK?=
 =?us-ascii?Q?+Wky9S9ymhz2v5zjDC0=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:14:42.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e32741-f51b-4d3f-b19d-08de229d76b0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20526

- Add new recipe for optee-os-tadevkit, optee-ftpm
- Integrate OPTEE-fTPM, StMM for data encryption
- Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  3 ++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 16 +++++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |  5 +++-
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  4 +++
 7 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-=
ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg

diff --git a/Kconfig b/Kconfig
index c02ac94..536162d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -105,6 +105,9 @@ config TARGET_TI_AM62PX_SK
 	select ARCH_ARM64
 	select HAS_SWUPDATE
 	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
+	select HAS_OPTEE
+	select FTPM_STMM
=20
 endchoice
=20
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b=
8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
new file mode 100644
index 0000000..2cfff21
--- /dev/null
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
@@ -0,0 +1,28 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/optee-ftpm/optee-ftpm.inc
+
+SRC_URI +=3D " \
+    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;download=
filename=3Doptee_ftpm-${SRCREV}.tar.gz \
+    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.ta=
r.gz;name=3Dms-tpm;downloadfilename=3Dms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz=
 \
+    "
+SRCREV =3D "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
+SRCREV_ms-tpm =3D "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
+
+SRC_URI[sha256sum] =3D "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795=
c0bf7488a4cac6"
+SRC_URI[ms-tpm.sha256sum] =3D "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb=
734bf28f8904ae30494a4"
+
+S =3D "${WORKDIR}/optee_ftpm-${SRCREV}"
+MS_TPM_20_REF_DIR =3D "ms-tpm-20-ref-${SRCREV_ms-tpm}"
+
+OPTEE_NAME =3D "ti-k3"
+
+TA_CPU =3D "cortex-a53"
+TA_DEV_KIT_DIR =3D "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/recipe=
s-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
new file mode 100644
index 0000000..6e396fa
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
@@ -0,0 +1,13 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+OPTEE_ENABLE_APPS =3D "0"
+
+require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
+require optee-os-ti-k3_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/opt=
ee-os/optee-os-ti-k3_4.8.0.bb
index f8cd973..e73a7bf 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
@@ -9,3 +9,19 @@
=20
 require recipes-bsp/optee-os/optee-os-custom.inc
 require optee-os-ti-k3_${PV}.inc
+
+# StMM integration, required by UEFI auth variable management
+DEPENDS:append:optee-with-apps =3D " edk2-standalonemm-rpmb"
+DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", edk2-standalonemm-rpmb"
+OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
+	CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd \
+	"
+
+# OP-TEE fTPM integration
+DEPENDS:append:optee-with-apps =3D " optee-ftpm-${OPTEE_NAME}"
+DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", optee-ftpm-${OPTEE_NAME=
}"
+FTPM_UUID =3D "bc50d971-d4c9-42c4-82cb-343fb7f37896"
+OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
+	CFG_EARLY_TA=3Dy \
+	EARLY_TA_PATHS=3D/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped=
.elf \
+	"
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/op=
tee-os/optee-os-ti-k3_4.8.0.inc
index 444f6b3..5ee5020 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
@@ -21,7 +21,10 @@ OPTEE_EXTRA_BUILDARGS +=3D " \
 	CFG_ARM64_core=3Dy \
 	CFG_USER_TA_TARGETS=3Dta_arm64 \
 	TEE_IMPL_VERSION=3D${PV} \
-	CFG_TEE_CORE_LOG_LEVEL=3D1 \
+	CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1 \
+	CFG_CORE_DYN_SHM=3Dy CFG_CORE_HEAP_SIZE=3D524288 \
+	CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
+	CONFIG_INSECURE=3Dy \
 	"
=20
 DEBIAN_BUILD_DEPENDS +=3D ", device-tree-compiler, python3-cryptography:na=
tive"
diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/fil=
es/ti-extra.cfg
new file mode 100644
index 0000000..faff390
--- /dev/null
+++ b/recipes-bsp/u-boot/files/ti-extra.cfg
@@ -0,0 +1,19 @@
+### FTPM + RPMB + StandaloneMM setup
+CONFIG_TEE=3Dy
+CONFIG_OPTEE=3Dy
+CONFIG_OPTEE_SERVICE_DISCOVERY=3Dy
+CONFIG_TPM=3Dy
+CONFIG_TPM_V2=3Dy
+CONFIG_CMD_TPM=3Dy
+CONFIG_TPM2_FTPM_TEE=3Dy
+CONFIG_CMD_OPTEE_RPMB=3Dy
+CONFIG_SUPPORT_EMMC_RPMB=3Dy
+CONFIG_EFI_MM_COMM_TEE=3Dy
+CONFIG_MEASURED_BOOT=3Dy
+CONFIG_CMD_NVEDIT_EFI=3Dy
+CONFIG_CMD_MMC_RPMB=3Dy
+CONFIG_EFI_TCG2_PROTOCOL=3Dn
+CONFIG_BOOTCOMMAND=3D"setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing =
1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
+
+# workaround for v2025.07
+CONFIG_USB_STORAGE=3Dy
diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bs=
p/u-boot/u-boot-ti-am62px-sk_2025.07.bb
index 8f8d0ff..9a1d641 100644
--- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -20,6 +20,7 @@ SRC_URI +=3D " \
 	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=3Dt=
i-fs-firmware-am62px-hs-enc.bin;name=3Dam62p-sysfw-enc-hs \
 	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downlo=
adfilename=3Dipc_echo_testb_mcu1_0_release_strip.xer5f;name=3Dam62p-dm \
 	file://rules-${MACHINE} \
+	file://ti-extra.cfg \
 	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
 	"
=20
@@ -58,4 +59,7 @@ do_prepare_build:append() {
     cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-s=
ysfw
     mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
     cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIR=
MWARE}/ti-dm/am62pxx
+
+    sed -ni '/### TI extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
--=20
2.34.1


