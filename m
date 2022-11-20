Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C828FC4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:48:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.69])
 by mx.groups.io with SMTP id smtpd.web11.22460.1668977322351510124
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LE11pevv;
 spf=pass (domain: siemens.com, ip: 40.107.6.69, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI38VG7Y+6fsOV7tWFT2A/IPt9PnBywg7V9GoyaknajvVhQFXRkJ+YgJHYHZjOJiFMy8cNoREz+5d8QtxrP3BzSW4oIuszo/L86dj/RHu9iRrTObodOMUb55KkPixlpGm4MrL+rmJeEfUeV1J8VmLe636eYqMtDHEDWaARoaJU2g4YjiU7p81Y9z3soRkw0gzit8vvK+KMXLEtp7m/35rtKhTmyRSfWvOlleDUyS0NhK8DqEBHk2echJc+Ll5ufkY+isjmLdGdkWjYf/jEVAMIsDAymsP+9ER1t5N+ejh8SDdpVj0cAzzhMn+rbi9hZ8jv9l8UcWQNAXRO1FRvSMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL68QCWGeED+kpttQOM0+vg1Bg+XyDS1QDHV3W3qhF0=;
 b=O4yeBOr4hfka1Jm/RGBmuLlPOjFJeaozX9hA6SoO4GKfwY5R3PZSUQxK5mJBpGTtd+c3MIaXwiAArgfVFDf7DKS2Acun1Rt35DNONj5CWgWy5xyBsZjlzljt1Wyv4lZ1bx7RCclmfstRuxCjKXKJz3tNR8S/9Z0ix1cFiw5L+Bqc9+zEPMbOPQoxvVbllcNP7w9GP6jxj0iP3a6eneltrpIX/YaRKeTyHLs4nXBL2cG1TaRRNOLn5k8z6iCc9+Yo8HI0Qgj7YwuLFV9hDbwdPQTGdunZdQtegVztMm7N+x0o9CYlgbHhUJlzjxE/BjMDa7gZEu4+bATJC1EIcCKMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL68QCWGeED+kpttQOM0+vg1Bg+XyDS1QDHV3W3qhF0=;
 b=LE11pevv7flWwQFDTLnjjygJOZnUhSAXHZYI93Vg1p1NS2tGnWOZvjNdILuxLxLMMKIJXAQ0l3T+Wjy34pmdgQnSQoDEK0pN8ByBCNTMDfNG7tcp20t4rzFj8+d18zBQ+BLh5nuM+4boE9T4Zx4bw6sth98/28NsRL0tgVGZTfkZQZHgxpuHFrL/kOP95nVk3P6MUu+z83MjTa7L4L5GmuFWlyqJWuJaNnQMPTdhgwzxt75O0O9AoRCtSaUUQAJYkFuVuR00ltNRGAY5po0jfyxPw6Ji8GkfbSdLSNXQP4tXuQ8kttVcwuxNUbA/vWxeiNGkgar79gKKvVP8eOIM5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:48:40 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:48:39 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 1/8] add recipe for edk2
Date: Sun, 20 Nov 2022 21:47:04 +0100
Message-ID: <20221120204711.5826-2-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: ca42e1a6-fa64-4538-e9a2-08dacb389a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nO1EsCDaFYX0MGkmAO9WP6Ej21MdgLDCnoUOGnSYqSWegLnLzNeSLZcL6FQKJVVVMJoXQAse30s3enLosrVaPGhco9AIT5Nec3kKRHJHAQqxa5+5KKBrmLHp1TxC+HmX9dOgTq1LYECzD1hAAqHDeQA9sB1XGXeXuqutuw/X28N7aQk+nnqIX/VjtI5KyKix1CpoFnapGsLiSLUfSWevpcSMBmy4KCDa33+5Eih2V4GBYLOZrgoTksjadENCKVQ3CNvC7RWg6P21/VnuEDRT3MKVbOhdE43w0R7ftMOEQ3irCeT1rc14bmQvyIG4mYp6UZU7IhSg2Pz7go3lbzNve5GiLRJSoTeYB3DiaxJoeR20HP/hSBENhBU+u6wfIVO09Su0INb/4ZWV7/ID6aErDqDaL+N3nCZgZGCHLYyx1bie63yUCAPEtjA4666kch09vBUQxBorLL0Ld0+FKiWOrAmSoj04dRkG66cecktimAp5LW0BffhjvViUweX69JMlEjW3lDwm3TuhRGtL3eyIirLtPgLEg3AihBInYG2Lvfe4gfhieZBlg0iHp0OBgPZOcdnWbxpbWp+TZlUa7fAh4XbdkqIeBzfxPy0KtV85G5Nx+60prIyVcfoTPlC7ay0TjSP2hAVkWHRSt/rYZq1YkqvD1vSfSrYhCA0Wp9k8RHUrtyNx8DjiEO6pRrf1lffOXJntNJBc/SDHu7/bzP9cnA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(966005)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xtP0pnawp+iJjA//pmJBoGVl6tDNiirsOiO91nT6TZ8d4Loce1WvgxGx28HM?=
 =?us-ascii?Q?F2jZ2YRNNfrPJXVxhojKmBGRi22q8lEcKiUTYWDrEs76NKjH3o3W3zo7cyCl?=
 =?us-ascii?Q?wQkmiy/gZj8LMHuPhvHh/uok+ukR6R+JLWREHGps7lfrivgunV5uQZny61OU?=
 =?us-ascii?Q?VOLLKyhH1xNUv2UrmMCLwsZg1XFOQuE30yM7v4bKVcaYYXJD0cT3sZ3lDTYD?=
 =?us-ascii?Q?FoSmNflh4pyfiwv2ptfr+fTDh1Omj6roGkR3wQ66RYowmdBYMcrhH8x7Mor/?=
 =?us-ascii?Q?h/oTbABlMaEpLfgPjt3nZE7KTgUao33Y8ZVgqaKgtHNRRXznBiM6+YhVaxYQ?=
 =?us-ascii?Q?iUab6Uqmk89MSzvH15cHDf4p0TrHP59nHmCBT6l+k7Bzuh1NtOKA6zK0YBug?=
 =?us-ascii?Q?+Nk2Q9NUq/xFbJo8ouCKipVhlotws5qFb/iMf5w5xiT3xu9Lohi3agjzJ7CF?=
 =?us-ascii?Q?l3635br/BLCXs6adBUeNCH3XsilqOhnM0dTJ/6Hs2Eu53VlKDyDJBaBvFgS1?=
 =?us-ascii?Q?68iLKKZxJAhPvIdFGrN1S29uKzm5Gom7p38dLN4ndf2E9LrLHvaHX9rvJTFn?=
 =?us-ascii?Q?4rZBMgxtKxoNRxRsLTUBeP+SVTFXEAfhjWrqEyGtun8XZs/8oqaBjGFBZl9f?=
 =?us-ascii?Q?IQ4Hp7C4sdXhNKe3lOUHi1q+0pUVVfiXXH/nj0b6LUrMR25Q+b4tH5bjJqc3?=
 =?us-ascii?Q?uR4DpthwPNh9SkqDrtBRL0wu8mvTkerKJZ6arDbnU2QTRHtL6921DfN1+mEP?=
 =?us-ascii?Q?9pFHj+dD9Ud5fkUs+uYzsKnCwifNBi1WHvuFF5sTCsCINQZfg0FhZbtmMnqO?=
 =?us-ascii?Q?ATkuqVPoJwGfT+qOe6MsI55u2eR5/OVFD6scDXdJK+xWeBdpZnYqlSSbm5bD?=
 =?us-ascii?Q?rnsD0lC+CvWZDSLFBexunouyXbHkHtQv4ltqi3B9GxQTkc3Q27pqGDt8IrvZ?=
 =?us-ascii?Q?c4rnDP+hmiggRK1IHWjmhXPplIkxEje/Pb0OoCeAEmVdwL/5YPhFELB49yGO?=
 =?us-ascii?Q?7AfpE2nRM6OfESztxVlUScQswvERkOYTq5BITWJA+kIdRWksKIMTImCnBP9/?=
 =?us-ascii?Q?tmqAOK98cv0xyErzMqkh51vJU/K2lQbjhzZQtDhtCPjpUgSdUX+B5y/IS1jT?=
 =?us-ascii?Q?E+4URvNkBOFwuaUmitE/FjUfvOgrspB/gy5+cvpclwWpv8yFIL3JA1CsIm8k?=
 =?us-ascii?Q?8KAF548PvU7IAuHRCH6G/80VwwfeIZDu/9BszAJ8GPb8eldGACQqDI5g8FNc?=
 =?us-ascii?Q?sETGWZRzcJiAE27re8ZtGL/v0itI+BavHA7ofXPybj2wT2uxyEzSBNUBXcyo?=
 =?us-ascii?Q?/CkvFAWuPsXdSh6WniLgFSiJQhZ1LA0tXT4wDJGjPrlz79iUMCeGTp5OUoLm?=
 =?us-ascii?Q?s5m/GhlDCXnSZhsCu8YBfK5+0HcYH+rrC55Kq/yZZPkHmIEkGiV4vbEvAMv0?=
 =?us-ascii?Q?PFCweI6Cv+Raf1vdDlg2YLLOsX68t/9/EwIvA9qYBTJJRsbVUY05/yACLPOJ?=
 =?us-ascii?Q?WcMU0k7sgmc67+22gXb1F3jaNAt3pXa+sdil/T5UPvfUoJic9ScFMB07HtL0?=
 =?us-ascii?Q?4OPXAIJzDG35SLLjfNpLDJXktQk4lUPc/jSudPQiCys2WYYMdByyQUOgoITn?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca42e1a6-fa64-4538-e9a2-08dacb389a6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:48:39.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBA+bmihQ6rTMjt282qJE8gXFnqUhlBBUGhL1WJnZmRXmLFINvpMLafLCXPElNUl4mdkDaiuq2z2Dilk8g7h9VC7wen+C57qhFfHUtC8pB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10054

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to create the BL32_AP_MM.fd binary by edk2 which is needed=
 for the qemu optee generation as dependency.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../edk2/edk2-platformstandalonemmrpmb.inc    | 56 +++++++++++++++++
 .../edk2-platformstandalonemmrpmb_202205.bb   | 12 ++++
 recipes-bsp/edk2/files/rules.tmpl             | 61 +++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
 create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.b=
b
 create mode 100755 recipes-bsp/edk2/files/rules.tmpl

diff --git a/recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc b/recipes-b=
sp/edk2/edk2-platformstandalonemmrpmb.inc
new file mode 100644
index 0000000..3277cc8
--- /dev/null
+++ b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
@@ -0,0 +1,56 @@
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
+HOMEPAGE =3D "https://github.com/tianocore/edk2"
+MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
+LICENSE =3D "BSD-2-Clause-Patent"
+
+inherit dpkg
+
+SRC_URI =3D "https://github.com/tianocore/edk2/archive/refs/tags/edk2-stab=
le${PV}.tar.gz;name=3Dedk2 \
+    https://github.com/google/brotli/archive/${SRC_REV_brotli}.tar.gz;name=
=3Dbrotli \
+    https://github.com/openssl/openssl/archive/refs/tags/${SRC_REV_openssl=
}.tar.gz;name=3Dopenssl \
+    git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
fix=3Dgit/edk2-platforms;name=3Dedk2-platforms \
+    file://rules.tmpl \
+    "
+SRC_URI[edk2.sha256sum] =3D "e6cf93bae78b30a10732b8afb5cc438735dc9ec976ae6=
5d12dab041c18bb7987"
+SRC_URI[brotli.sha256sum] =3D "6d6cacce05086b7debe75127415ff9c3661849f564f=
e2f5f3b0383d48aa4ed77"
+SRC_URI[openssl.sha256sum] =3D "6b2d2440ced8c802aaa61475919f0870ec556694c4=
66ebea460e35ea2b14839e"
+
+SRC_REV_brotli          =3D "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
+SRC_REV_openssl         =3D "OpenSSL_1_1_1n"
+SRCREV_edk2-platforms   =3D "3b896d1a325686de3942723c42f286090453e37a"
+
+S =3D "${WORKDIR}/git"
+
+DEBIAN_BUILD_DEPENDS =3D "python3:native, dh-python, uuid-dev:native"
+
+EDK2_BINARIES ?=3D "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd"
+
+BUILD_DEPENDS   +=3D ""
+
+TEMPLATE_FILES =3D "rules.tmpl"
+
+do_prepare_build() {
+    deb_debianize
+
+    mkdir -p ${S}/edk2
+    cp -a ${WORKDIR}/edk2-edk2-stable${PV}/* "${S}/edk2/"
+    cp -a ${WORKDIR}/brotli-${SRC_REV_brotli}/* "${S}/edk2/BaseTools/Sourc=
e/C/BrotliCompress/brotli"
+    cp -a ${WORKDIR}/brotli-${SRC_REV_brotli}/* "${S}/edk2/MdeModulePkg/Li=
brary/BrotliCustomDecompressLib/brotli"
+    cp -a ${WORKDIR}/openssl-${SRC_REV_openssl}/* "${S}/edk2/CryptoPkg/Lib=
rary/OpensslLib/openssl"
+
+    rm -f ${S}/debian/edk2.install
+    for binary in ${EDK2_BINARIES}; do
+        echo "$binary /usr/lib/edk2/" >> \
+            ${S}/debian/edk2-platformstandalonemmrpmb.install
+    done
+}
diff --git a/recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb b/rec=
ipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb
new file mode 100644
index 0000000..84761c9
--- /dev/null
+++ b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb
@@ -0,0 +1,12 @@
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
+require edk2-platformstandalonemmrpmb.inc
diff --git a/recipes-bsp/edk2/files/rules.tmpl b/recipes-bsp/edk2/files/rul=
es.tmpl
new file mode 100755
index 0000000..388e49a
--- /dev/null
+++ b/recipes-bsp/edk2/files/rules.tmpl
@@ -0,0 +1,61 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2022
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=3D$(DEB_HOST_GNU_TYPE)-
+endif
+
+export WORKSPACE=3D$(shell pwd)
+export PACKAGES_PATH=3D$(WORKSPACE)/edk2:$(WORKSPACE)/edk2-platforms
+export ACTIVE_PLATFORM=3D"Platform/StandaloneMm/PlatformStandaloneMmPkg/Pl=
atformStandaloneMmRpmb.dsc"
+
+# https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cro=
ss-compiling
+ifeq (arm64,$(DEB_TARGET_ARCH))
+export TARGET_ARCH =3D 'AARCH64'
+else ifeq ((armhf,$(DEB_TARGET_ARCH))
+export TARGET_ARCH =3D 'ARM'
+else ifeq ((amd64,$(DEB_TARGET_ARCH))
+export TARGET_ARCH =3D 'X64'
+else ifeq ((i386,$(DEB_TARGET_ARCH))
+export TARGET_ARCH =3D 'IA32'
+else
+$(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
+endif
+# When cross-compiling, or building with a different version of the compil=
er than
+# the default `gcc`, we additionally need to inform the
+# build command which toolchain to use. We do this by setting the environm=
ent
+# variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
+# **GCC5_AARCH64_PREFIX**.
+# export GCC5_AARCH64_PREFIX=3Daarch64-linux-gnu-
+# using export here at TOP Level does not work, because
+# GCC5_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
+# Therefore it is set right before the build command
+# export GCC5_$(TARGET_ARCH)_PREFIX=3D$(DEB_HOST_GNU_TYPE)-
+
+
+export SHELL=3D/bin/bash
+
+# ENV Vars which should get set by edksetup.sh
+export PYTHON_COMMAND=3Dpython3
+export PYTHONHASHSEED=3D1
+export CONF_PATH=3D$(WORKSPACE)/edk2/Conf
+export EDK_TOOLS_PATH=3D$(WORKSPACE)/edk2/BaseTools
+export PATH=3D$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKS=
PACE)/edk2/BaseTools/BinWrappers/PosixLike::/usr/local/sbin:/usr/local/bin:=
/usr/sbin:/usr/bin:/sbin:/bin
+
+override_dh_auto_build:
+	source edk2/edksetup.sh --reconfig
+
+	CFLAGS=3D LDFLAGS=3D  make -C edk2/BaseTools
+
+	(export GCC5_$(TARGET_ARCH)_PREFIX=3D$(DEB_HOST_GNU_TYPE)- && \
+		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(sh=
ell nproc))
+
+override_dh_auto_install:
+
+override_dh_auto_test:
+
+%:
+	dh $@ --no-parallel
--=20
2.30.2


