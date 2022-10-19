Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57FC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:21:42 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.45])
 by mx.groups.io with SMTP id smtpd.web09.5834.1666171294003091095
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:21:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=paMhVoaA;
 spf=pass (domain: siemens.com, ip: 40.107.14.45, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImKKmRKDaOmSEl7pSGfOCQ7JQwoGr0KmfWSTZ0V3o5W+chcnWDeKPCWcHyrQo3RRmvCe6IzD7iAKv0QbA8RDPehF2VBk+e5Qm6AbU2n7ZKcNkerYAV/mvMwhLRN8O6LAgfvOZuHVCWmupTQTRihGx8dl7h24Blhna8vbKO/W34yF/VvfUQo4cLsEMs4YkdZJ5TJD2Mg/F5D1+lrL9AXymJtIy3OW46aacyvoYsV+IXR1U92YxuWBtulVMMMTOV+KuWCh2QnDf6JYMROyReGceNG0OEMKSU4TuQwFtGUyZJxmRIwrEWOBCD/pKkjrYJDqCAj2uYOEWD24vskYFEAUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSJQDfC2/f5qsWRe2U3SlxvyBeFYRbVAP2N/VC2SqVY=;
 b=DiaJ4VO+TUQRdJpYDHdBDqpK2xgA+dFxkK17dcHcLgHbF05GdrPcQ5+aip3Ue2EqLggcQVrjy69gtqrrX/skE8PXTqe4drer03+WZbLY4gsnbArq4fUWftr98TpD/Ylz9MjXdJwlkQk50PfoTqxJHwjZFIAKwBnKmqxEgMVtRycBeQT582wpUva5BUo3/A7T/v1+u0cGhvb4LBMuOGv3pOuVeuYtdjft5OjFOV0z5dkliprV6ZpP1pUaS9rwMhjdcVwUsP2V7gaIsa8pvVwDJan6lf3I3wpvlZdMbYmtGDBJO+I8J+jya2E8n1Lzw4k117kOuppYW01n7q0+weYSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSJQDfC2/f5qsWRe2U3SlxvyBeFYRbVAP2N/VC2SqVY=;
 b=paMhVoaAy2Mz3cUof1mUgPkYbySS0b37qX1M/jkg56Ll65zTDsB7ME03mCPt8misdR4NonNdWxqB09O/WS0ZK330KIYMrBXnAVkeGbG6o3cw6gLusRtDeDP41lM4fKUf4Iu3pCUCItNfQVxZ33ppjAnSWv/tdCTAWnaiVVuL/4wr924V7NvlAjqmbuuMV1wj5jcnau0VBFcVqf+R7lLcgbFtBsL8z9u1Vgjmg9coLFoKJt+8etwwipp6HlGs79FLf5EK3N0KnrgwJDX5MfTdF2MLtMfXbfKqsd+AdFjHAlWU7VVtzl03WDEBGQicSoCjQ6fSOtsd8QU0iyB/qS4iKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by GV1PR10MB5867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:21:30 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:21:30 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Date: Wed, 19 Oct 2022 11:21:11 +0200
Message-ID: <20221019092117.5291-1-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM7PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::28) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|GV1PR10MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: a461f2d5-3669-4ddb-1dd3-08dab1b34ec9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IyzlX0/ZS8MdC2yxHqV/CS/FqwKNS0BhIB71Se0Uv6L3/cfhVRo9U3odzFPM3a5ax95B5JXnOzLbWUfmzyb7sI2FSOPe7Ht1Hw8A5aLU7YXiuiVXJ2kxtw/XsB/wUm9qEM3Xhbt+NTSbR8XHLtuXXDoe7XdcNOLiO/U5IMXknKiszFJNuPlybGc5dUEvrlmQeDfqzfnA9gFNwSfUSuU4Y5Cm6ydU7OBC+z/baqpQqPHVc36ZA4UOBtWq2i7To0ak0zvN+NFiLxUWjm33bY9Z0T4CAAIuR4sli6VaA6gBaggyipdxgAIMhAaOrq5EJ84kWAAn0q5bj005Xn0Eh/BG0cbS8Ayvx69dVeofq8QKqMxoGZFMR3Pk/9cllwt6wktn0unBBMm0/+v5I+artDCsLGjn6dZJ0A7v21vB/xrCj0znXXaYROJ83yTkkp9kDsrb1a+s68Jo77zGmH8QyUgo86VmASX+Mxi7ooYN+jd72DvvNJJoEoVtCqNys7WEuyzKzVuW/oCnDC4AtdPrQcbUOQpljHVjKTI0lIdDcHnKePbXmD+BnHw9fUIBXnlP+ytDoyTAUn2oCXkSyD0/8iZbKHK9QpzIfJbMuHFYoSjjCYacnDAYkr7yjs4HXr2/6XAf8JMXZavAwC+bY8XmCRi+f+HXafsJVukiCNN5b+lLmdtzHRIuADp2mmVzBVYQ61WLdkq5lGu5QX43i1CKFfnGZwC2ED9UDX2C2r3lPApcbj0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(41300700001)(8936002)(26005)(82960400001)(9686003)(6512007)(36756003)(38100700002)(186003)(1076003)(2906002)(2616005)(5660300002)(83380400001)(478600001)(66946007)(66556008)(66476007)(8676002)(4326008)(107886003)(6666004)(6506007)(86362001)(316002)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fkCsbxHTyvvDWjNuFRAGNS7gtQRxdvBvxfb6lQCfiBg3EzrvxANe0LCcv1my?=
 =?us-ascii?Q?psgsTbF+OzocXHTv3x91eqkZ9ekzKYHeoSj6eA0FvNhbEiiLpnE4IdPWmRB3?=
 =?us-ascii?Q?EpoAsmrNxOY+u78cPDel1rKkcbsFVjQu8v5C83sScng54BO4W2Sv7KHs6TZU?=
 =?us-ascii?Q?/zO1M2XzlxTRIaGw/ZX8ymJUA25Rl4Pqfxl177Bu33YCbBpUwiWqV84GhqSw?=
 =?us-ascii?Q?UDg522dECpmnMbl433w0sNEiyz7AyO/TBKdLr6HXkRmXHOsBdtgAl2FU0jWI?=
 =?us-ascii?Q?NkD1ks1y4/dz5QORkJa6EefV2GJK5aJjW+X3pkb6ykspj7Ipp4Ys4xBafaUH?=
 =?us-ascii?Q?FbFhIK5rMb+H0kk+eyYtgbh6I+fZ/JDnZDnPw2y6+xuCKPU9K2iikk0ygckS?=
 =?us-ascii?Q?XLxLMEFJ8FA0AZGnnowAjCB56ERobogH9pz2wNtvoaFnwsL1TATsSxsRZQC8?=
 =?us-ascii?Q?+ROB44W6eybIIOpDW0SqOIjJXO0SGqUsIOVSzDCmS7ixxoMJ4U4wwwdeIfs+?=
 =?us-ascii?Q?LZodufJK6u0v9cK5ASSltXg3Wdrz1M/WRqMx13Q/8cDNFHuel3H5tVYoXFnN?=
 =?us-ascii?Q?wmGhUsSOkM0OJ2hpqQgHFucbiRccPxL2nSqZn1tqZ3uw/bwGq2PuLyfnNVXi?=
 =?us-ascii?Q?eGr12JHKUZuXebzX71AL/Zg5QED5C9Myzkw04bxCA2hzK9PvFz/wmVHPIsM5?=
 =?us-ascii?Q?jBrIrri+ztl08EecyX4ms7/SYk+lyT6t8emyWUJ0uxmXzf/LcH3GZ4m64crH?=
 =?us-ascii?Q?4ogzHLg04/LHjbpIX9LIw5bH/+qqsdqMISiZKTPUEEkMLz2yqielmapy5Yok?=
 =?us-ascii?Q?vry9KLKxIGs7N8R6Ce8qsrM3kA0y5zRarItGENSTCip3mpKhXSX1I7cNpQC4?=
 =?us-ascii?Q?zmli2MrHxUZRL826bKCwmjg369rAfXiG4WcJYMbmdv+TUPYIi1UHRFUIP6iS?=
 =?us-ascii?Q?jV3fohb/tW4MkUMA3xVif3yJPxE8Q+hgH258J1v0N7jDye/nO784KtwueKJp?=
 =?us-ascii?Q?1eSKxTLwyRpNWkj4M+zpQXaBHgfxhvcahSOhu1PGy+ezAbXWSzhIcgfuwdqD?=
 =?us-ascii?Q?3NtIrKu4YGh4biMnOHgHr64yPjwwL0bU+uKsH0qQKkr+mJKghsZia4ykMcmp?=
 =?us-ascii?Q?H+Dkg29Finc1hl1Wm0fXWxYlM4uAudOq3969KMCypo3Jt2AupLWs1UgplgHb?=
 =?us-ascii?Q?hpRKMpg4ex2uOko8p9V2D1cl+sQzhfLGAQjaGa5Z+piw/eJ+q9oWQNFaNzXT?=
 =?us-ascii?Q?tUP94ff+LUv+7uZcM/236UfiWfnEqABjrOhllgvRiijSidH/Kt40Q6qFrrR3?=
 =?us-ascii?Q?gW5JXmgy3nKMqsfCF5BLg8KQ+ynvhXtHeUDx/cwrDQ+3AQVf0YNB5aiRmlL9?=
 =?us-ascii?Q?DxNHwnZ8CQdcjo/r29G6KjhFAMUYyB9wD9U0JLHy/GFOWo/fwW5MIm74sWdu?=
 =?us-ascii?Q?RM/zALtCsO22gj6OKp6C35t6Lzhg/xfPvTH1T7t068y8U9S0wmUEyNndI0Ux?=
 =?us-ascii?Q?Wf0GfBb8aUqA6I65b/bmVYPl27dhcircNovuTX3TCjxUqiH4kZxS6d9bCPAr?=
 =?us-ascii?Q?XuFUKeK+gZ+ZjkxGTxMCg09fI6WzAzWfTQAzO7q4kQsWDoLkKAzSsW3U09gW?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a461f2d5-3669-4ddb-1dd3-08dab1b34ec9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:21:30.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUB2tA+fEn1HLPwRhQeZzS39vP6d39WvTiVvmhMIffw3AfTWmejKkkguAtcUgC7h3V0ye7tH5yqZ/Dk2S8H5ktrclzij11AbXwUEu+9wxrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:21:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9775

From: Sven Schultschik <sven.schultschik@siemens.com>

The recipe provides the possibility to create optee-os binaries for use ins=
ide of an qemu secureboot setup with edk2, rpmb, u-boot and uefi

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 57 +++++++++++++++++++
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  7 +++
 recipes-bsp/u-boot/u-boot-common.inc          |  6 +-
 3 files changed, 67 insertions(+), 3 deletions(-)
 create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb

diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb b/recipes-bsp=
/op-tee/optee-os-qemu-arm64_3.17.0.bb
new file mode 100644
index 000000000..5e60041af
--- /dev/null
+++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
@@ -0,0 +1,57 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Sven Schultschik <sven.schultschik@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+HOMEPAGE =3D "https://github.com/OP-TEE/optee_os"
+MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
+LICENSE =3D "BSD-2-Clause"
+
+require recipes-bsp/optee-os/optee-os-custom.inc
+
+SRC_URI +=3D " \
+            gitsm://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protoco=
l=3Dhttps;destsuffix=3Dgit;rev=3D${PV}"
+
+S =3D "${WORKDIR}/git"
+
+OPTEE_PLATFORM =3D "vexpress-qemu_armv8a"
+
+OPTEE_BINARIES =3D "tee-header_v2.bin \
+    tee-pager_v2.bin \
+    tee-pageable_v2.bin"
+
+DEPENDS =3D "edk2"
+DEBIAN_BUILD_DEPENDS +=3D " ,\
+    debhelper(>=3D 11~), \
+    build-essential, \
+    cpio, \
+    python3-cryptography, \
+    python3-pycryptodome, \
+    python3-serial, \
+    device-tree-compiler, \
+    edk2, \
+    gcc-arm-linux-gnueabihf,"
+
+OPTEE_EXTRA_BUILDARGS =3D "CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd CFG=
_RPMB_FS=3Dy \
+        CFG_RPMB_FS_DEV_ID=3D0 CFG_CORE_HEAP_SIZE=3D524288 CFG_RPMB_WRITE_=
KEY=3D1 \
+        CFG_CORE_DYN_SHM=3Dy CFG_RPMB_TESTKEY=3Dy \
+        CFG_REE_FS=3Dn\
+        CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1 CFG_SCTLR_ALIG=
NMENT_CHECK=3Dn \
+        CFG_ARM64_core=3Dy CFG_CORE_ARM64_PA_BITS=3D48"
+
+ISAR_CROSS_COMPILE =3D "0"
+
+dpkg_runbuild_prepend() {
+    # $(ARCH) is the CPU architecture to be built.=20
+    # Currently, the only supported value is arm for 32-bit or 64-bit Armv=
7-A or Armv8-A.=20
+    # Please note that contrary to the Linux kernel, $(ARCH) should not be=
 set to arm64 for 64-bit builds.=20
+    export ARCH=3D"arm"
+    export CROSS_COMPILE32=3Darm-linux-gnueabihf-
+    export CROSS_COMPILE64=3Daarch64-linux-gnu-
+}
\ No newline at end of file
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 956dcbfed..8e6428238 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=3Dy
 CONFIG_EFI_SECURE_BOOT=3Dy
+### OPTEE config
+CONFIG_CMD_OPTEE_RPMB=3Dy
+CONFIG_MMC=3Dy
+CONFIG_SUPPORT_EMMC_RPMB=3Dy
+CONFIG_TEE=3Dy
+CONFIG_OPTEE=3Dy
+CONFIG_EFI_MM_COMM_TEE=3Dy
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-bo=
ot-common.inc
index 60f0da361..7fe4d3fad 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -25,12 +25,12 @@ DEBIAN_BUILD_DEPENDS +=3D ", libssl-dev:native, libssl-=
dev:${DISTRO_ARCH}"
=20
 DEBIAN_BUILD_DEPENDS_append_secureboot =3D ", \
     openssl, pesign, secure-boot-secrets, python3-openssl:native"
-DEPENDS_append_secureboot =3D " secure-boot-secrets"
+DEPENDS_append_secureboot =3D " secure-boot-secrets optee-os-${MACHINE}"
=20
 TEMPLATE_FILES_append_secureboot =3D " secure-boot.cfg.tmpl"
 TEMPLATE_VARS_append_secureboot =3D " EFI_ARCH"
=20
 do_prepare_build_append_secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
-    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
-}
+    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}   =20
+}
\ No newline at end of file
--=20
2.30.2


