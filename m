Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCAC433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:29:35 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web10.22945.1669217370655511712
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WCCuj64j;
 spf=pass (domain: siemens.com, ip: 40.107.8.79, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8m15OqmevI2mY4uk0N0zR7jzZsUoTs4nzwvlI/+EgsAARB8yNNU30I/5wkBV/kuaff3/MhYfBEV2M8Zh6+XB/Xa5xs873Zk3j2Gi7UGelwtYAIosn7qZhOV3Q9Rd9y7u6ohtJSo5HFBNGUQFqEYiVA7bBF9PiV3BHf4OkhTOOnUlNK0JNIp7JT132xUdLDqJhdNeSJmlBK9/j9ACRaJ7yHcx1kQ5+S6vrtqF6Rw7QqDAmA6SFBkh5qiO1h/xrEfe3Ap+0tc4f7YUlaGLq89QCxvzmSyrWx9PmGw0No+/TJg+PJAHXXuF7zNggVfnJBUjW4WLCo18eIJdV6vJ0dEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL68QCWGeED+kpttQOM0+vg1Bg+XyDS1QDHV3W3qhF0=;
 b=Jf3h9gsDJHcu9REmkrL6XxiiY+E2e00y7QHfDuUzKm5bpkVqSuszUMAPEfx93OnrmIVKcF5p4CxYtf2Yxn3sf74/nKDdcIrq+X9Lu704TqsaE7OdDW7iPOIm9OfAHMokPHWpBCFvZZT4ZYUMSvUdXuj+gWH2lgHhLbeLiLEazrHAFQlWvLISLjMWGSVTojVKvbDauXhs6Drmtz4Uv/BbNbGJzWadX3htVTczVp75NBk4YQ3lCkaOrwFRz/fykHa5ZcNFasMyX4rqWXeU4/9JK4Gnf0K67a57iq7mLo0VDAc78mKnilSPFhWAWxDh2PzCeRI0RykqHQ4GtF4f9zeyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL68QCWGeED+kpttQOM0+vg1Bg+XyDS1QDHV3W3qhF0=;
 b=WCCuj64jxq6bRnrPR7ZvAdPOURJmkE6UmvjvMQfqYAErSk43LqZopjwqOXQuf2qzNWACQ5CmCbVlbsWauLeBUwev/FjGYF2sNs/x6AoJchNABhMEH7/qukXgYYuAdTqafiXAjy3mgK+wjfde3EvdLV10riEGntSdAhtC5H4Gi0qcJp5sZnip4V6EtLOVCvbgjZ29ojG9exULakT1gwsMVbDlQAgwPHJHHV7ChF5aJPdXFia4lj2cO2ZQ82E/9yHsoppRsImN+nreoMN+jpNE+j0Px4AwLQPkCSe+TG7eeqzpUShtIiHNfTsl7oLcEB9/+2h4kJjVR4zTSieO6GU1Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DB9PR10MB7244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 15:29:27 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:29:27 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 1/7] add recipe for edk2
Date: Wed, 23 Nov 2022 16:29:00 +0100
Message-ID: <20221123152906.75323-2-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DB9PR10MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7287bfeb-a762-4fb3-a1c2-08dacd678235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mUrV+agQGLBU2bcH4bG82b1TGi005BvDATaVZ/k/76Z1tW7hkcOFiBtcglyJEUngAyYeh247LhIDN4i1PjvAfnjBPAkmH45qAcAsbV1LuD1ySM0PBqF9FHziRK3hwMX7RV5+WxsYIyqY/YmQRU7ceKasZX/riwYXp8AVd8kaJDZwFuyj8+EKXhzbNwqZIZTDLUXnyeHbViz2PoZeOkj9MKsrZEf1iI2XpB/aA45okA1xgJnTkngIqOyX8/2mU/SWXimVQcXzg33j0nB4812601JwW50aN+dUbdk4/BuvZDdfaITa+ttTjWdAXH6zNaPELuJCrRj7ZP5S33okBZQ/p9uLJc5Yg9coikQHgK5bqG6PnvWq/LrsMK+mdnu3sazbhSq+PHOXuZkYOT5oczeZ59uzfxrnVw8PQEf/0S5N1LQyDsOIQWuroEVxvX/PIAyh9IAAIHRuACnaeesBAzYtbra/dSOUHNp2utPn6HfAoKl1CK6nNEcIDnWtx5aq8EeHlFXr/IA2AWrXFQlFJCMyRoBZ+HXfw0/W7b3H56F5tZG27yi6z/fbwtQGcm+2yFQdtXiUsLMZH0Tx2e8lKzMgasfw5XDFTvjfMjHdko0wk8FyJfU342V8iYGOaU7pmMZlAyfz2UbhPNH+1v/RWb2HMNksSfo2O9Wi9bsaL7M5wUwffGPKsTgGfj7DGtqQ71tca0C/JYTA0pw3MUb4OqQovw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(478600001)(66476007)(26005)(6916009)(316002)(2616005)(6512007)(5660300002)(8676002)(9686003)(66946007)(4326008)(66556008)(6506007)(55236004)(82960400001)(186003)(41300700001)(1076003)(38100700002)(36756003)(8936002)(83380400001)(107886003)(6666004)(86362001)(2906002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dQHxLZp6PFOFWCPoTEC4abZOA/3dnT7tYPhXutOSgbWyxP/2RzUbgvNXap4f?=
 =?us-ascii?Q?ksRA3FG5Yvz2rtX2a0MobrG437DHT8xo4JHMit6NsFRnGQcWSFMfBZG3FbZ3?=
 =?us-ascii?Q?6M8coyAJNqwfVJB0X1yOQIEQlNhPFvJ+jYNtZAYaXKXNPjL8zXQM8u1YpcSX?=
 =?us-ascii?Q?UliTv2ueT8cLUySCveVrdEYoAxkVR6StNdopG8uGJk/pwijiKIz5lcMih0dS?=
 =?us-ascii?Q?oyQaxSq4KFDBFFCtoiliki2t4YgtQrJNImAvVKnHi2rkb+AjZRz+kk3lxnAM?=
 =?us-ascii?Q?z83r0Y0dvT4KQAGTA3jgfr2WociwD5e5f6HW/uj3uO2r7PWZnzh9I07mEtvK?=
 =?us-ascii?Q?NT3d6+ArYv235dYZHLv8ht5ECuHmlJDvvxJdWJ32KNrVp1yWLD5nip/LnO/A?=
 =?us-ascii?Q?+X5BQB2QYq5hsR6tnEhMr6n/uZyShxWpu0YkMybUvqihzXyEj532y8DK2zrW?=
 =?us-ascii?Q?nLJfvBaeCdhcV2uiJgqjby3d2V5Us1/7J2w/q9iL7roj6/KDh10HAW7eoFBe?=
 =?us-ascii?Q?dqNfXB9vGLp3scfksEG3NwjCE0mRKaDPGxbk91XJpZHp/C/OK0BABiGvpFoL?=
 =?us-ascii?Q?Cl2z3nT14erE86c+9Ti5Kt1ZW39Udw7GjRzcREj9Bq6t4/uL0P0cQnI8jPAg?=
 =?us-ascii?Q?KMZ2//qEbdlBkVvUyjya2dDctIrxbJ8HwZYa6RiriP/Be+Xy7Phci2t/bmoG?=
 =?us-ascii?Q?a8mpLeA38heKZp/S/6XsfSEGPAXNhyYjSfNhcMfOI2eJkGql1WAT4G6SHKvl?=
 =?us-ascii?Q?bSVkMGDd93aaPYfICHGUp3Ohoq/NQpGin4DcB/LzN9jBxfnSILjzegNGgFvE?=
 =?us-ascii?Q?GbIm9TGBbISdgqgiolVaNAVHnJkRvql6pERKlfwctvAoO/nC3oF+og5POG41?=
 =?us-ascii?Q?yOTWlFioS1AwAutTgZUY46fukdkGiRTKo8qnJOYczMr/kEQQVWY2h3alZiGR?=
 =?us-ascii?Q?AplC8hozK8L8oI5vS9esP6CrBKw8CHxSE/Tn1/LGOJdg0+3ehTFz/UHqNZbB?=
 =?us-ascii?Q?m3tn7LF6fEba/z3CHvj+kR4kWQp7TpPN02wlM8WPcsEuqixLzUlWDutXgTP/?=
 =?us-ascii?Q?De1YMuHw6Er99agyepm8eQrzhLe6UtzZQG0/qMrPyhYt7VP5GQu67Z2ARIFj?=
 =?us-ascii?Q?sGMp9+UPF8lZpSBw/t5i6mvwkKVF503iZOaWTnN8RGZYZ3J1FEzqiprud2/+?=
 =?us-ascii?Q?xE+l5gjCoQ+PzpTxDLOwZ1cJA64O3/Qk6OyqrLRdOunyBYs/YCPEJ1IMsuoS?=
 =?us-ascii?Q?IzlikddWwLflzg6hI4R7LxU6mJL4fzu8J6lI5t2Fq9RRbvlv0zMn8pAF4aff?=
 =?us-ascii?Q?TNh0qoTEgTn05yOsFqKTTKtB2Q50V3wWbqxgwYy8XPnMrbUJKEeaWvbdtfhQ?=
 =?us-ascii?Q?Admy+L8QQ/cvY0jYL6gbx2F9yuf58sUh0Z0GYbgWBL26iteP3yO2OF1GkaZF?=
 =?us-ascii?Q?6XhLUaCoTRJT0bb3B89W7XU/eV7mdaIEfdQH/0AM86KIVY15Veg3j36YSJQe?=
 =?us-ascii?Q?SkACnrItxqP+jk72z3oBZ6JvEARPYgcahx26yQKrmu0QzIWyOOHdOYMZrdIQ?=
 =?us-ascii?Q?V3BBT4UNdsARi9WmeJ3Gv3zfn85szUDDxgmXpOkYpIsAOfxKh4CN+fK4dgTv?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7287bfeb-a762-4fb3-a1c2-08dacd678235
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:29:27.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d8+nRTWD2o+MbfgbRgEBUHoNjofuAwWhmhj0iwYoPx4Ls/ZmI9JU0gaVmYFqPqqvI287g881kw3e20XXnd1bk8ydHFAIQnIRI4qycxtHB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7244
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:29:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10091

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


