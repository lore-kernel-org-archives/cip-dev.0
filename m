Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FFCE7A9B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:38 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com (BYAPR05CU005.outbound.protection.outlook.com [52.101.85.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13979.1763111135514485147
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=RjWA8N0q;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.85.11, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dADzeKbB24Gia0WHfeSbA+wYkMZESxCx97FhULSLadSAe8xQRfccKu2RLK9xBZmidN53Cx8EUl0HrOICvxri6CL4QSPyeLWa+qmafNIwSLy4H+sszxV6pO2FEQTZjehNsM15lbfC+InQ7cVu5drcw7EiXlDXGtTXpPZ8z8gg874KLK4AKImu/EY9FxfIQ3/3L9uVjX1Uba4ZejAsjhi44R7GyJQgStFiPGPD0ZB5uFEIUlOtZwwwGjIPRrPwpYAlQG6ixTzq/nk8yFwRAoZkRuQTEFihpGiAvAEVJaMWB8qSEMp+qmXUvyrEmZCzDW8Iug4NccWcM1SFNzZ79haeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQV8L0TMf/LbOFma+J4nFTe2DRDjK/35tF69mwMM0vI=;
 b=XkyGea994mrW+beivCYiTvTNenyvkkgpIzmIul/aY50QuuNa+zFhgbb7D98Lo0x/tTx0lKG5L4AXOwtszCwK+AEKfm48doM58pcoXc/o73TRex0uHqCGz0q25PYjD5nw17lUk2g5lf6Kr+pSiqfbxESBWmGtn9xBu5prnih8u78IHga2XZJdBXxq66kmP9LsDkI2hp9VAQxNvBrdk2pptrw+MOf6ScSYHvEOU8nEV0+2av0cR34qdz/scC6GyAA3bjg1asEXLZbitX4kUTbIPLyhTG96xrBRHCr0IISetgauY4yuNCSCwcAMaHPZEsCrsLDhptTr9EqCoO/I8Q4WQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQV8L0TMf/LbOFma+J4nFTe2DRDjK/35tF69mwMM0vI=;
 b=RjWA8N0qeo2Lxdr+amZMGxXgCWDKEgOKvm7otVvosPoGTGOvNdDiCe1A150bJVdROTyEIU5vfstOKx+zcU6Ir5fxSaoDtTqlvmZA+CGEYbQKhtpK21K9ve2JiSeb/VR149LwzW1eSEAZtx0khE8DLv4llgDoqWxEeulkbQr3CGM=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by SA6PR10MB8038.namprd10.prod.outlook.com (2603:10b6:806:43c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 09:05:30 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::d9) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Fri,
 14 Nov 2025 09:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:05:29 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:23 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:05:23 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE95E1P1718804;
	Fri, 14 Nov 2025 03:05:22 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v5 4/4] ti-am62px-sk: Add support for secureboot & data encryption
Date: Fri, 14 Nov 2025 14:35:09 +0530
Message-ID: <20251114090509.2935933-5-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090509.2935933-1-s-adivi@ti.com>
References: <20251114090509.2935933-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA6PR10MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dd2c2e-55b5-4dcc-96b6-08de235cf572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?js9My46QVOIqc5wAze2hKZgsChaN3by429TxeDHhrFw3zQHTnx1IsL0SGLyC?=
 =?us-ascii?Q?T76PHRj60X3d52jEpgHtMiTbSSYGsvoiAYFkcF2hSBjf6ofyhWDjtiIeagpT?=
 =?us-ascii?Q?SF2KbIec5Ouzq16pfGPtNPLEpniQyruGF8yH8VDt5+5HjFEFH84xGWpwSwWm?=
 =?us-ascii?Q?oDitmWk8EYMmJPEjike8KhEYsBJi1StI3l3uQ5goEIDT8/eRxc5LIN5uq0D1?=
 =?us-ascii?Q?v+WjKG21KlqXclpQ6/Y/+pZ9VfMhreZHyxfipF++wFqY1x3T42DHYmfV0qV7?=
 =?us-ascii?Q?JL/OL1omDqinC7tTfEJxeLxAzwkCvszGsQcaNNE5C2SSbITohb078Q39332H?=
 =?us-ascii?Q?tdCTdckgNp3GN1IqelwCUmqrF5ZragWSUR9DddbBzBCm525UetRZfcg5CnA1?=
 =?us-ascii?Q?rvuke0G5KWdkgHIDFBXmThBg/s9Kt/b7zcEFZM+V//2wACi//EdiGOTUP5DL?=
 =?us-ascii?Q?dfUO9lWkcFXIkAJsLYIfhhUCvR6iC4kSfz9MMxS6ZrXfLDr/icZIDhVAPCWg?=
 =?us-ascii?Q?7d/TYh0v4mJ/fsIsRIqwL5X8veChL1IkaJORRUJ/7OsCsoM6RuTmzfPvg61Q?=
 =?us-ascii?Q?wcN1ef2tZ4hj2rx5oq6vWT3fWu+IoLhI0R56lpwupLl9cbRKzfj8nYg4kegc?=
 =?us-ascii?Q?VrW2bGqfIzQGiSPS4kudMkdCqnnTo93wx935TLc2K+W4LRSlESQyrUrGXd7E?=
 =?us-ascii?Q?mAfWQXvemFMkvfLUI1n+37tr6OBkBWatQKbkcucs3C2xbn4A1TXy7W1snbB6?=
 =?us-ascii?Q?KqhHtV6Obpmcijuuhg206HjjngXn6AVB3rDXpB5axcW8VZg3J8Q1ZycgEFT5?=
 =?us-ascii?Q?izKPHqbxTjT2gyDhD8e5FFn6M9Fxr+qDYG23HBfjzH2YCsZPmHWmnDfFzEqw?=
 =?us-ascii?Q?w9VvhToJbcwhE/Ozle/AvAHQZs9VHDuvH2A7S/1WgLn36wwELp/XezxalV0G?=
 =?us-ascii?Q?BDAWUShhZomkuw2v0A/K7Fd7AJ2j/GSOZjh90BNOpiI4lYxfYYSsyCW+00YF?=
 =?us-ascii?Q?SDtQ7j4qlTGGCcOhtZjNIVuTfFE7REpPqRrUEp4TDe6TcYslg6cObcsb8TKI?=
 =?us-ascii?Q?xgBUzgI5O9Jq6yhR+0s31xOIIipa/YRBbthmneFS3oL13oWYXeY56+Zhf79B?=
 =?us-ascii?Q?P4o2jWzsWjJ5f6/XePMiiMCQ49UTISo1p1uAsHNhcJtq0on/WMTmOA0a/gH7?=
 =?us-ascii?Q?uF3aAtbF5zXB4ZC1IZEHRmzogbZmK+tQ3mRadJVBJI5VWUuTLLhskA03Piol?=
 =?us-ascii?Q?d7gDEHaaqYEU3a+jmINUhYgO2PaNURwnNwqti2wqJWxmzCQasV7Q2iYgJfV/?=
 =?us-ascii?Q?OtOOppIy9Dzun9og4s5cin+78u2oI3uYJ8SYmosppRIQ3qjc1C+ECbzta8hi?=
 =?us-ascii?Q?A73gUAiiWGsDChl2LuDs+HB0pBho0p4lYMUDxvtzHyn+vq20DxSvLncZ/9Jw?=
 =?us-ascii?Q?bUXTjBixcsjiS0Xq7M6FSicC3T0PVo08sdDRM+xqCUqlU4DcrVee8CU88ql0?=
 =?us-ascii?Q?GRwfcnYLZ41NN+xeRYI5F+/n1QMiCUyVZD2IPvx1GAqboJaix6CoiwXZY8+W?=
 =?us-ascii?Q?5j+YmTBpSzn/Q9ou+bQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:29.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dd2c2e-55b5-4dcc-96b6-08de235cf572
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20542

- Add new recipe for optee-os-tadevkit, optee-ftpm
- Integrate OPTEE-fTPM, StMM
- Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs
- Update Kconfig to enable secureboot
- Add wks file for use with secureboot

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  4 +++
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++++++++
 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 16 +++++++++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |  5 +++-
 recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  4 +++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++
 8 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-=
ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index d322a94..536162d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -104,6 +104,10 @@ config TARGET_TI_AM62PX_SK
 	bool "Texas Instruments AM62Px SK"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
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
index 8fecee8..b97b70f 100644
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
@@ -56,4 +57,7 @@ do_prepare_build:append() {
     cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIR=
MWARE}/ti-dm/am62pxx
=20
     cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
+
+    sed -ni '/### TI extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62p=
x-sk-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..52fcb09
--- /dev/null
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -0,0 +1,23 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# Boot partition containing Bootloader binaries
+part /boot/firmware --source bootimg-partition --fstype=3Dvfat --label fir=
mware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 =
--use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+
+include ebg-signed-sysparts.inc
+
+# ABROOTFS partitions
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name system=
b
+
+# var and optional home are extra partitions
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 512M --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4=
261fa32d9
+${WIC_HOME_PARTITION}
+
+bootloader --ptable gpt --source hybrid-boot --timeout=3D0 --append "rootw=
ait rw console=3DttyS2,115200n8"
--=20
2.34.1


