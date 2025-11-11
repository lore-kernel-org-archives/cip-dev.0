Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869DCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:40 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (SJ2PR03CU001.outbound.protection.outlook.com [52.101.43.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22184.1762879537966424501
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=lw+/zCZs;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.43.53, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIb6Ba3fp99ec8yURPEHQVD/8QXwFygGXIb8EkgDVDmEUMyhtFH/4effZtGzLj05tLHIyF6lFe5Rm9FDuEKKRXUa+qqO+Yh+OA+93VcpjCVzPwG6J/F5gHaI5tRatQUQ+9sBR9QREL/HZKBg3z/E4KiikGejTYl0Ort76HzsZ3mSx0iMfcgm/qSjRP3uu5q6sCWN7I/phAm2YZq0IrVnbPtdxG40myDsEakHr2X+W1AxmKqkWqOeMts6OsmlRcbUZngNwnn3rlHgbxi1ZwWAmStDD3sp0pRXD0kZHbddeyrMt7xzSLhTNctU62qIzv4XMSwHh9fxZfN0VGpjZmchxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5CwSVbhtmjsfr+JQQX1yxgk+EiNm/4fLyib47UFFAU=;
 b=R5ql/WXNKqWMK9uHOl3Re4dSh7iSEw4OoHWoPOAnLQAL4TVqHL5HI4KawheVyGTwgrhzy+Tva+455W11wvo+zvOlbN7WxhOIOekxbDAvMtabwPKTlEY6XMg865n4UlQMXFh2ZzmSRYoJT1cS0PXuZlz6+dqUfr03HAGjweOVYyIutOcee71toLSud052+ATP5EIOzvk7+opBEhnbL7ILDnELzs1MCBHKCCunmmu443zFlRbfdCoiYVrGwtethllwA1yPC3Syf2aTe1OzuAbf0bqev1VCufdgJDkCBOmwpcUTA7ZzIzx7+5IyF0fCVRODklNBQOTfQFg45B7pT341kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5CwSVbhtmjsfr+JQQX1yxgk+EiNm/4fLyib47UFFAU=;
 b=lw+/zCZsPPWPn6MotrUfPQLv8bRkLRE1T4aEjusvDHrfNBL4/9jglna69Iz6UCG79cQxMKhcAKpAxZlNocbF1mn7Wg40/LNE+KQdd5CtUzdLDSERCflOCUgZLo9GpdCM3hyQL+Sqy1zqScSDu8uxtkiyleAiDNqfJjkWLB3mmLo=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by DS4PPF6ABE13187.namprd10.prod.outlook.com (2603:10b6:f:fc00::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:45:33 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a3) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 16:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:32 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:28 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:28 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9H1255613;
	Tue, 11 Nov 2025 10:45:27 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 5/5] ti-am62px-sk: enable data encryption with optee-ftpm
Date: Tue, 11 Nov 2025 22:15:08 +0530
Message-ID: <20251111164508.1707234-6-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111164508.1707234-1-s-adivi@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS4PPF6ABE13187:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ef3d9a-0721-4a5f-587c-08de2141bb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ljn0gaiLPjarNQTPLm2NKI+ibj+57wHU9COfgTGYpTz+iodlCOvyFqwAJCpl?=
 =?us-ascii?Q?8iEeQp7089temetdN6qIdXnAMZppzn+qp8RyrdkWhPPzNuKmYh/oGbDjMjZA?=
 =?us-ascii?Q?49s4rfmx+ByXrLjjAWA0LpsuKm7XZshhRHCAB+14ASMch0owvi5I7ZvmKUXD?=
 =?us-ascii?Q?hNDeQM+UnkOtMqc/cABfnpkXReKH5F7kYk02kDZ0Q8jLuTKhtu3tqsezNAwZ?=
 =?us-ascii?Q?hqkbXz/UvpsUX4WJyy6sWO7GB7FAmw5c/u/tAQnbiMv51H15TFxQLj5UuYIJ?=
 =?us-ascii?Q?+tof4323yLQR8vnzOMKPSWdMhQ+3eDBiGCpICbZSnh6+vrO8jQxy95Mt/fEq?=
 =?us-ascii?Q?I3schOj8EB0aMGtWXaTSV+SzIQjV8eGMIGcq8JMuEkAiow12v+4T6uPkK2sD?=
 =?us-ascii?Q?w4iL8RvseJS5gJqFco85zVInPapJ05e1IOhh7FIEaQnlYgy4D1D2xEIz6owG?=
 =?us-ascii?Q?nipjqB/MOxgEov14mSyct+uEOpoN4izXc8pIFcwfUFUxEuSXsQ7OUtFCf8PI?=
 =?us-ascii?Q?MlzzKtvX9t5DOdlXfn9SEdh6BthSgfSWVHc/k+Q3NMuel4usbDD1E/D3vKUS?=
 =?us-ascii?Q?ZmEX2k6Lo7aD6KUZRpNjBd8noKKJpp5BVQDxImdvF1aNSGVWUfccVDvN4VT9?=
 =?us-ascii?Q?FX3H2mEqolRHvBk2JNVUgN/42EgHwXqzGjPRxRfamYhdl4+jAKjfJwQBbfnq?=
 =?us-ascii?Q?BxklvIVanTI6TaT8KpPD9h6ggOHJ9WhA20g+k/Txi752fvut6CRRdQgvsHrr?=
 =?us-ascii?Q?hscc5xdLLMilz3lB9mTTyrHwC2xUb3IdggkjJpYy39b3QxqPCRibHz3WKmiu?=
 =?us-ascii?Q?sOrysq90aceOBqGtV6k8uVyHjAEZui1R5pJKOrM99G13dyRhqeiYX1j8S30J?=
 =?us-ascii?Q?PQVPMx8P/ktp+kvpkzojlhztTJgHmkzas13lbhq0EDCUAWFUw+Nxw4pTgroh?=
 =?us-ascii?Q?y6zepqrc2Ck+34iynwEee6zjxKcU5y1gLKNeuEXOo4ViMtg94aHMBAIcTg3P?=
 =?us-ascii?Q?Jc/HNzoH2N65NEctlhYO0RbtBe6fUoZJrF1lqDFkMxs3moMJjTweJkwQ9OWi?=
 =?us-ascii?Q?eP7r9Jz3iSqaCoE82bBAjkg4YnVD2CkdIT0EL/IU1t01PiUe9bpRboCud3SE?=
 =?us-ascii?Q?6P3XiyUSADL0J/SchbAkd/fAvt/TkDir+IxftBU2pYjfsEPi7sPaGVn+EdBl?=
 =?us-ascii?Q?D7S+LP2HAouwRPQPndOHecCUABwpuZ22BSZhzgU60OfzZylCb9pzyLtFmDye?=
 =?us-ascii?Q?uKJmjyq3eyLw4BrTnHsuZpyKM6mU55heXH39kNXWm9oaKDuD/NWMxIerSgAp?=
 =?us-ascii?Q?wR64k6ZF56eLo/+RrtOQVVioztKvuWY0D1T8ufzIDR3zbTB1f0qlH2Ao+c+N?=
 =?us-ascii?Q?UCS5dMqrJ8kUwAlIJJglJ49Pm9vVV1RAVPJaX42CbKcLNY6e77doJGLjSmSM?=
 =?us-ascii?Q?kPl/ednQEU0txuyim2HH1GzMW+gkYQdHBkGinu204Cg7fJmH4iINrEFp0r7t?=
 =?us-ascii?Q?bbuJvfd9FKLZXvKIyxDKEB9b0J/qS15bEfDPiLjvodUmyywXUa2Fj4qb/dQl?=
 =?us-ascii?Q?K1eQ7m2jvrp4NV5rAnI=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:32.8332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ef3d9a-0721-4a5f-587c-08de2141bb27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6ABE13187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20500

- Add new recipe for optee-os-tadevkit, optee-ftpm
- Integrate OPTEE-fTPM, StMM for data encryption
- Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  4 +++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 16 +++++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |  5 +++-
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  4 +++
 7 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-=
ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg

diff --git a/Kconfig b/Kconfig
index 3fd1efe..dfe3e58 100644
--- a/Kconfig
+++ b/Kconfig
@@ -113,6 +113,10 @@ config TARGET_TI_AM62PX_SK
 	select ARCH_ARM64
 	select HAS_SWUPDATE
 	select HAS_SECURE_BOOT
+	select HAS_DATA_ENCRYPTION
+	select HAS_FULL_ENCRYPTION
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
index bac1413..08abe91 100644
--- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -20,6 +20,7 @@ SRC_URI +=3D " \
 	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=3Dt=
i-fs-firmware-am62px-hs-enc.bin;name=3Dam62p-sysfw-enc-hs \
 	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downlo=
adfilename=3Dipc_echo_testb_mcu1_0_release_strip.xer5f;name=3Dam62p-dm \
 	file://rules-ti.tmpl \
+	file://ti-extra.cfg \
 	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
 	"
=20
@@ -55,6 +56,9 @@ do_prepare_build:append() {
     cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-s=
ysfw
     mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
     cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIR=
MWARE}/ti-dm/am62pxx
+
+    sed -ni '/### TI extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
=20
 TEMPLATE_VARS +=3D "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
--=20
2.34.1


