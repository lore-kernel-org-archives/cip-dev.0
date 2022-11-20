Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDBFC4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:49:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.73])
 by mx.groups.io with SMTP id smtpd.web11.22496.1668977391549596601
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:49:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pw+HQcZw;
 spf=pass (domain: siemens.com, ip: 40.107.6.73, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgWABP7VMERou0yVkIKmWc/A509+60Y63BrE61etAKOKdiCU3ks3sm0cEYdW+bqZf0cofvqVW2TP3b+A6MGGqMzq0XCsokTQI4VAvWDS4CwXvHLuwffru2tCA30/LvLVpq5YtsNyZ7FVp73hC/3J3OH+S7mOk+ZAMjU5zqk4LkEAefmfj0VkCUVvqlWs0N2bj4siFG3ctcfrSnP2Kyh6b5Xkx8Z47dQ3BP/1OxVlO/AGUbLEcwzOzw/R+zRilfJuUxpZpqhjQG8B68Gfn9t2WIya5NzTkfSorbL1nzhDDihjHNbDnGVY+mZqPVipgE5eJMreVmbrLog26ysQUqV+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVV0ib9XRhyO+bm66mtM2NOd7l1HRjVAWcICguQiQks=;
 b=T0PPDqU2abN7SKXB+1k1yklJJO3rtIOR5MExy1OipSeLzoy6M79a1ko+XoHF8T5ZAuFrapqm7QXTCQNp/aDosHu0SM1E8lO1bT3Kx71lb7FOwB2zyLUrdW9rNZq/AK11V4ZEDHPfZm0NDoFt/xwnCPpxFLlrsXZiwqO4r4V3uRWSmMPcrsmHlHftCfIGSKw3pnqS+osIBMbCFqDjVm1cJ5AQSnowGQehc2w4+9PERF74uXhGcpvXpDL0TwJDQF0kya/AxibqBlycdk4S/WkyHpxjDOCnFGhlwLvFXAba9h9yq4+tPltA88d14omfW1CRzA9fzp+K3PI4+EEblW8DXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVV0ib9XRhyO+bm66mtM2NOd7l1HRjVAWcICguQiQks=;
 b=pw+HQcZwsM5hfHJpSgGtG7mdgyo2zyloKb+T7tVBL+D023x8Y5KJma63/upuV2eiSosP1RF0NmiYH76BOy2BoszPFROOb6dT6bIGunLNh/XODrJSV+sdHFWFmCRrz9u2iX+UqyPe09KaKGChAj4vW/y5blH9eGtMXlZeDJxpSXCwv61KkQ1+l7amBvpT6LSfyuswdNF6VcpylWOgV1bQu2o6BapApwtP16lWCXYAcLnYEQm938X85Mb00YspblmPkm24OtgJQaXGtDeNqdTFDxwLFDxkFdTT9zU/ygqg1/Ra2fcOSRDdutCi7wSnGtoXz3omSlqFv4a3Yu30RQRBpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:49:49 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:49:49 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 5/8] add recipe for trusted firmware a qemu arm64
Date: Sun, 20 Nov 2022 21:47:08 +0100
Message-ID: <20221120204711.5826-6-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa1c3ce-c04f-450e-a14e-08dacb38c414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mUNb8wdww2pe9VkWxkx/vPJrjmFMxpvibyLIrg0vpE21mx4jZYvgp0Q+MOg1CEqS2OlQ6c5siBrYrDqu7Nsg5SrbMMdlA0ZVilEvLud0x/eqTYivD7RVQ307lmUVd+sH8cS2gSrG7vjOpaSFQtluWYKWVONDkQxAXa8AqNZLH+G1YmLQ60UOtCUCWJpM5z365IZ0pLdeDv7Gn2MbvfVUVXpeKHQ1/JBF/6X52gR2SBwXuvuuBDYF4vxYLtK3L7NXIBzPpSRhxjtGnpMT7H6Uog/CRD48YizAaleuK/LcMEIPUmRaph7vVwm40r5m/e8TGK8VSMp968q6onaa6xVg1TbI4Xggdt6mGwMtudxheh4NuBeasyDSHoazuD8OlPP917FodJsC4GDRRCRrVeIImAhsVZbvu7UNtwkq+pfrO7uOhNY0pFY1bkF3GSksgcFavA5GQXOsDCLkiMDSpeQpQfy44vx7GkKyIXmlW1zWZ4Pq5eEhRWUeD/F8kbDUVGUjaDLvEYe8dSVxX3T5bfANVKu8HosVbzw8pjyBpOxM7cU7xtc4npKotmdnT1/uMe9fVfMPOd9du6+i2JE40lnGZyS4QktbywBe0emERu+DpOZS75Uq6SQnOFG1RIX+IrjtxzM+1unrmmnQnOTJCt3/3vXopSbLEBttzduCMOjzUqo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(966005)(26005)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oy2E+jR/kcC/TrH0P+hT5E/sX09uKs/Yc74qe3eB6yyBwCqLp3wr9wOQnMmc?=
 =?us-ascii?Q?nJ/+cLtP5gHNL2tiUx9o5jFmUy39aFN4K7bHuUZZaGghtu/h4ieY1y9XvDXr?=
 =?us-ascii?Q?DMZHDCnnuiozy1J1f3MmR7ipeobIVFMCjhHHPRsyy9LY4jH8e3ZrAVGMP0dQ?=
 =?us-ascii?Q?LGlA82mssud2U+lvjciV9iQS3BqImG4vktrkFtIvg2kZk7OJUALNPz2pj8JU?=
 =?us-ascii?Q?pyY4157w8z4XLQu1QWeyA4Sje8SmRsWcBuof4mZIo6ven+xKEYRq1hH2KNxN?=
 =?us-ascii?Q?bKfe1+7ehqEQjMnOlg2gkFsRtkNrRY+uWFMrXU6unGLslgVOzhKg5vtMkgM2?=
 =?us-ascii?Q?WXToiun5fAsBGyZGzX7tba65mpPTY+4XddLAlPuH6j2QvItQYoIPLkp1JSZn?=
 =?us-ascii?Q?t68HEr3CRyouLU1nYREJ2AxSf1zVdeGx7xi8uBiQ/A13r9rLYox/2F9OVHsG?=
 =?us-ascii?Q?aOurWE6/1crTuE7sVKfP3zcJARwNoZ8msFYlvd+b1PGymcFrePd6RnZJ8YMV?=
 =?us-ascii?Q?gU4oQlaXFZ0UwIxej1Vz8cw+ETiTVKQUoPDmTqvOX5gLIqoaqWPXd/HxpqUO?=
 =?us-ascii?Q?tA+tvn6SRupnirWA0VYHg3/l9jIGCvxpkiH6QFlRR+t63wsPKkyJXEZ2hfmv?=
 =?us-ascii?Q?eEpWUbb8EKQ2p8XnBXoWOIBxZOTv9hIoFzxQxXBzv2/428yjcsptrA+najST?=
 =?us-ascii?Q?hQvXqMXksSz9Z5u6gQOBHhsqELIPF7o3Fv/QZBbDvul2tLqxLSqR+PY3wEoB?=
 =?us-ascii?Q?WrDGfbuKjmvGpJGUtfAYNndwjtkjLluS2zeFJSbrX+Wu4g0hUfptkpBQ1dlY?=
 =?us-ascii?Q?qU4zSK7nb887JNDFQvBh/4BYNW1Cm/maJrhC89GcF8NUVz9nWjQSI9n3Th5l?=
 =?us-ascii?Q?gtiuePOmTGNDCd4Od0bwu5chKsTzaNjup3MdSepMT1UzPGrr+DM3Rf6hPoUy?=
 =?us-ascii?Q?ISDrgaHNv0468Ytzc/6f81249ZGP3kGEjkeV51AOByYY9TR4NVic6ThiF95r?=
 =?us-ascii?Q?tjCSRi7oTGiliS1M44YOafMxjlBbZMvPnIfsBe29j4PPw7f5eiVeVAr+XQ5r?=
 =?us-ascii?Q?14jGIGFtrN/VnvmURuSa8w+u8mXBU40+g25pUFRSzNpwQkAypz882mLKIkty?=
 =?us-ascii?Q?RShQ7YCNyehr2SR2/W6104UPNlo9wLJ5pYONTGq/vhgfgSKnnt6qs8+zUKKV?=
 =?us-ascii?Q?1p9WBjgI4U4az8t4yymYFvtJonlMMhohSrdDpnDBSNFjq/2hHwS7xF6GOYiK?=
 =?us-ascii?Q?J4d3xMLDJxdfQWwy+TKKL3BKM8lt7cXQA7/GrLM1Q31+BLltQtrEyj17AEi5?=
 =?us-ascii?Q?IZ4gfPzCqRHw8R05r3/lUC4jBXLWCexiARtiPEY9UzyYxbhRPtCSiXrFnsMA?=
 =?us-ascii?Q?SX2iqaWjPHycqvGy08Ah/DMFjRnzvglwxvo1sYfjUy383/2F+Bp2CQNKwaRm?=
 =?us-ascii?Q?HBySkQoLOd4ttk8r/tA8TzrJT2wwZRTsgT8sSVgUugL+2ufOZ6pLnkVKMzYo?=
 =?us-ascii?Q?an1ZR+Ytx8odZno4XBtsEbSlyQf8VHV/ehFGIz6oT8wE7Dn0MEh5tsrmFZSf?=
 =?us-ascii?Q?XRuBP3uTA+ZpYIpXYSqEXPDPaNbjCqEKswRyoqmo57gQZ8g/4/d6nHpTVIOW?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa1c3ce-c04f-450e-a14e-08dacb38c414
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:49:49.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTgIintI3W3anPfwW19tYqbKnZ4lzRb6whOlpW4ZhTqER2Hz5QTUSAFqff8+9NBpP5Wkp8J0ze3aHzTKovQn8zLFwAX1by1I70h2tgJQOpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:49:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10058

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to generate the needed binary to start a secure boot qemu =
with integrated optee and active RPMB replay protected memory emulation wit=
hin u-boot

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
 .../trusted-firmware-a/files/rules.tmpl       | 22 +++++++
 .../trusted-firmware-a-qemu-arm64_2.7.0.bb    | 62 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100755 recipes-bsp/trusted-firmware-a/files/rules.tmpl
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-=
arm64_2.7.0.bb

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index e92ea5e..6732095 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -26,6 +26,7 @@ local_conf_header:
=20
   secure-boot: |
     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
+    IMAGER_BUILD_DEPS_append_qemu-arm64 =3D " trusted-firmware-a-qemu-arm6=
4"
     IMAGER_INSTALL +=3D "ebg-secure-boot-signer"
     # Use snakeoil keys
     PREFERRED_PROVIDER_secure-boot-secrets =3D "secure-boot-snakeoil"
diff --git a/recipes-bsp/trusted-firmware-a/files/rules.tmpl b/recipes-bsp/=
trusted-firmware-a/files/rules.tmpl
new file mode 100755
index 0000000..45eb00b
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/files/rules.tmpl
@@ -0,0 +1,22 @@
+#!/usr/bin/make -f
+
+# Debian rules for custom Trusted Firmware A build
+#
+# This software is a part of ISAR.
+# Copyright (c) Siemens AG, 2020
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=3D$(DEB_HOST_GNU_TYPE)-
+endif
+
+override_dh_auto_build:
+	CFLAGS=3D LDFLAGS=3D $(MAKE) $(PARALLEL_MAKE) PLAT=3D${TF_A_PLATFORM} \
+		${TF_A_EXTRA_BUILDARGS}
+
+	dd if=3D"build/${TF_A_PLATFORM}/release/bl1.bin" of=3D"build/${TF_A_PLATF=
ORM}/release/flash.bin" bs=3D4096 conv=3Dnotrunc
+	dd if=3D"build/${TF_A_PLATFORM}/release/fip.bin" of=3D"build/${TF_A_PLATF=
ORM}/release/flash.bin" seek=3D64 bs=3D4096 conv=3Dnotrunc
+
+%:
+	dh $@
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2=
.7.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.=
0.bb
new file mode 100644
index 0000000..fcb2729
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
@@ -0,0 +1,62 @@
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
+HOMEPAGE =3D "https://www.trustedfirmware.org/projects/tf-a/"
+MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
+LICENSE =3D "BSD-3-Clause"
+
+require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+
+SRC_URI +=3D " \
+            https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/sn=
apshot/trusted-firmware-a-${PV}.tar.gz \
+            file://rules.tmpl"
+
+SRC_URI[sha256sum] =3D "553eeca87d4296cdf37361079d1a6446d4b36da16bc25feadd=
7e465537e7bd4d"
+
+S =3D "${WORKDIR}/trusted-firmware-a-${PV}"
+
+DEPENDS =3D "optee-os-${MACHINE} u-boot-qemu-arm64"
+DEBIAN_BUILD_DEPENDS   +=3D " \
+    debhelper(>=3D 11~), \
+    optee-os-${MACHINE}, \
+    u-boot-qemu-arm64, \
+    libssl-dev:native, "
+
+TEMPLATE_FILES +=3D "rules.tmpl"
+
+TEEHEADER =3D "/usr/lib/optee-os/${MACHINE}/tee-header_v2.bin"
+TEEPAGER =3D "/usr/lib/optee-os/${MACHINE}/tee-pager_v2.bin"
+TEEPAGEABLE =3D "/usr/lib/optee-os/${MACHINE}/tee-pageable_v2.bin"
+BL33 =3D "/usr/lib/u-boot/${MACHINE}/u-boot.bin"
+
+TF_A_EXTRA_BUILDARGS =3D "BL32=3D${TEEHEADER} \
+        BL32_EXTRA1=3D${TEEPAGER} \
+        BL32_EXTRA2=3D${TEEPAGEABLE} \
+        BL33=3D${BL33} \
+        BL32_RAM_LOCATION=3Dtdram SPD=3Dopteed ${DEBUG} all fip"
+
+TF_A_PLATFORM =3D "qemu"
+
+TF_A_BINARIES =3D "release/flash.bin"
+
+do_prepare_build_append() {
+    rm -f ${S}/rules
+    cp ${WORKDIR}/rules ${S}/debian/
+}
+
+do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${=
DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/flash.bin" \
+        > "${DEPLOY_DIR_IMAGE}/flash.bin"
+}
+
+addtask deploy after do_dpkg_build before do_deploy_deb
\ No newline at end of file
--=20
2.30.2


