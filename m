Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0CAECAAA1
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:27:57 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web09.18483.1666614470799964762
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Pqh44uvd;
 spf=pass (domain: siemens.com, ip: 40.107.7.57, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZA3CFbUKJW5Ha0u/dohwhqxZwroedpk43QwyhaOFT13v8L4574NmAse/xEkoyQNbbgGwh9efc69tI9Ir5T+1hXR5Kpg5sNufsuxXLym2vNqoqQhI7fZEW3JA8flUs4GUVOiFAYgaWV2XMIPn0r46R2K//WGpPLMlwZn28IT0mFf9X8UxDWsxfEiXyGQ18zcj+d86ukpCRw3Mfbf/OJ5cBiAU0iFGkoQ71QNwEDhlwC13w7qv8/rlLa3s5wyiAbtir+I789pzYepk0TGCcd2iA2GdawiPIW+cx13ieIgOMMznuTzVmCM/yXeId9l3/JKAWsqlaVlvNiZYkSHMIDHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPozscQVLR3OJKIM27XvhkrVUAUKKTfU93qw4bWk5Wo=;
 b=CFAcrg3Ouggpmzc1RFH6dX4UtdPWbhn9g7iEY0gHcGaPTg4JC8Ir1TSoSv9jB1fzDHviUYe1XKOxeMC35uiENHI1gHYztnSLVIZ58fiEBJZb+550vXsbB96O8KCK+gNXk6/YYe5JTPkd7eW+inys0Cz6anBQpuPqRtw43hEKMJSXy+gyEGENbhWpxG29QfuSsFeqhyeuA+DtEdMhzMBznF3oEoY8IL7dzGZAXuZmboDeBPMHb6ax/CWymEBOt55W1oijI17x/poSaOnrrbtDXL0F9vwml1s6hjSxcIon5e6mFnOK43vJHjZI7aSFdv99MN5HIrdPCLfij1V+r7fuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPozscQVLR3OJKIM27XvhkrVUAUKKTfU93qw4bWk5Wo=;
 b=Pqh44uvduVZDxQlvorLLiRFm9EeeEdIhp8wPQRQS9aP2A9L9NSB4L0IdLVlwIKWZezMc79p3ZuJM9cF8DCjaqT+JBt2UR+s8ljCa6x71+RLwoKqBXvLLkw4u9RCec3AgjmfOuoNxMRDEAGsQ3cv7TH0+I2U0VPlNQOhPaUnlB0sOQjUYG5wkSmJyzIeqOe4sqd8RaUUVkWymM/fRMKM9RRP67lw3wm/25N0Mv4q9nLVwyGEf+h0GOAFoSomd3NokOwyeLvT1QMcdR34V8Sr4I/R/ek1+XNoGykqSPXC7u54ohM7+Cvk9Zb3SPuoG2DRyqme0vpWeW2Uvq/otMe6+fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Mon, 24 Oct
 2022 12:27:47 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:27:47 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 1/8] add recipe for edk2
Date: Mon, 24 Oct 2022 14:27:18 +0200
Message-ID: <20221024122725.383791-2-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0567.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::35) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|AM9PR10MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: fe02d85f-5ce7-4039-1e32-08dab5bb28c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FlJ/CMdtpROzktjIqWfX+MjfI3EImTsiAehHoJmjI/zFnUUqNQpategL8sN9qdf3mlNzKKFN1bWwAKQCfUDoHSbt+w/o6/gWov2WmSUG2vaKf6oqBM4r48uSEK9DgZ2hVAtE1IADqbCpNZbz7GF5Oplgae3LKIfuXaWB+VGGdsjHBlUKY27xCcUIBaZ2Or9Y/qvXqCTfWvpSWTyoqJuSY1baZkNZjUulixd8hZv0J7IyV0YNlCY8sZG2Gg8k8odQv0Mo7tZ3eKN2FKah84tquuLYqoIRk0s6rUQ8KjcBNIkT0tni22fiIgdbYeB87U9CRhIvco8qc2/yGIjHg8H1YYo0RVnkBeqneUcrAMFn6QkNaiLq8RxfxaDYJMGdbioF5g0JTyqdl8U5FVg45Xu+bSg60sBdTlbNN70aJlRrLoKMqmXWLKSVbxFNeSJ3zYc7hLTWgiwzyxMG7XByucuM9xSRHBaqVz2nPYxkTgle64gpwp2CZz9md3o+5BcUhYTtAy2gVzJpo+KUSAwr44puXoElClxpKi4UfWMrp8nY+iEY0IqejU4IaR+CrSA1cI2wtY8AY8x1t79nbuUGyli7UW6mg9N4oXIvBcza+Gl6A+zyJUBNO//GBvVuUCnM3DTY8fzCLMGuuPrPz1c6FSQU1Dkbxt8WDCnQpt4zafOJUgzr35C4EUPL/Z05HbmFsAi2KhOW31bAJyxmqijvSa1T/tz0otoxMpEcEycHyfU7pf1rsYa+6gut57ipHmBUMThNOhpDg/pOmk+77+7K23LzLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(82960400001)(966005)(86362001)(4326008)(6486002)(8676002)(5660300002)(186003)(9686003)(66946007)(83380400001)(6512007)(478600001)(26005)(38100700002)(2906002)(36756003)(2616005)(8936002)(6666004)(316002)(6506007)(41300700001)(66556008)(66476007)(107886003)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8rg1YF53KD15tDqnUYJuNC1cloYTwa/IcPLSi0QXl8UcgY6mjcTLry/m62/t?=
 =?us-ascii?Q?VI/0xmLqa2QZ1BhsEefjDjm/7sFBoR27BtQnwSYhmb7PjgRwZ4+XcYldyrge?=
 =?us-ascii?Q?wBiwzau5xP1ML6R2hxdzajOmJQRPemGad/FKAQJsHPyNcZ1qPgXRgnY4vRM7?=
 =?us-ascii?Q?NVRgTbgWIGT7v/ruLN1h4fSoNcxs+5EGSVtFFqzOpypyMxHNxLQkMB5X1rhP?=
 =?us-ascii?Q?mhlthnnn8RBkN8aXZtlwDr/S+DXqRRovOhFL6EjULZMi5OT26tHInlXQheC7?=
 =?us-ascii?Q?Swu9Box+KRQTcGbcRBRi3LWuUQTNH8RoBZkPplsKpZpds7XaEstlZi8VhSLO?=
 =?us-ascii?Q?3B5ksgh805RknVFujg8FcmZRxJaFHvG6CeDI5XFT3UsOmaQRwGE0JM38mMCP?=
 =?us-ascii?Q?Yz+KrFzg7e01/VMKg1cpf827HRwCjht16BzNUfrJTh6DO6007u+N2r5LZkkD?=
 =?us-ascii?Q?jWyDKKRbcrCgxlj5TT121E5EzdfIAg/t+uWT22nE9keroihUfIu9PnUJIwqX?=
 =?us-ascii?Q?0LmDeTrtFZbX/0pFmfrqsFzHvv27KaiyDrcDjx12EqBUJtKxs/f11YEi9yt3?=
 =?us-ascii?Q?2MvJY5cdnxFfqoyWPgOYLVSbV2gTg/0bNelwk7MrLJ91Z7MCoGHUD/2tgxUf?=
 =?us-ascii?Q?Z9jv6EXVxTSdANvIkvI3Ce9PU9QNCsXzm8AAJczCtxwkySJaB7kFV2dINRm3?=
 =?us-ascii?Q?qZ00Fhpuz5RabouELKOVJsf29QR6iZ/L+GT3mQ4vWnV+5Iqce6XQtiIyIS6J?=
 =?us-ascii?Q?OZOLFbwElhfQbCVy93WZ4rEYe37r6LXISO7bWccE5rEZawSU1l1pnE6Zc45e?=
 =?us-ascii?Q?pTukpeTH9zzjC3iyPT+McCmEKLnXiU+PEYdak4qKjk5zC98ch2qlCLefdOey?=
 =?us-ascii?Q?YHZ8gdUSU+foGX2ijooiNrenLwWRJXWHghCMJlSAYPgUIJYPBCRmOnWfD2ag?=
 =?us-ascii?Q?X/hWm0ctjZntRANLARx3DZbyZ1gn57Un1yG2d8H0DQSxkFaOHqxZrnamxqsz?=
 =?us-ascii?Q?GEVvzvJbWXGtjv8L/zS9Zwe/f9W7Oqdw3M3Slre4YB3sRoU4BZ+pY6jueA6x?=
 =?us-ascii?Q?0t+2UYKjm0+6S/uSHaUb2T/msJiVB/ydzFGw8mSCSgSjMT6omeX1xSyORqgh?=
 =?us-ascii?Q?lz73sv6ZjOX0pDJBsZ/3oqjp9lTne/J7zdaoeNoIc858Kez4NUvIGLRCJBZl?=
 =?us-ascii?Q?yKi0XDal12ph+9mcXjAiqbT1tLqcjCjAAC7edIG+lEJhnqE4hurbvA1eHIN0?=
 =?us-ascii?Q?hX2PrQ793Ld6LDamwIYxI69koeiU8WSep/SAd6yHVlneP0SyuBHaXFTL1DK8?=
 =?us-ascii?Q?kYRo+jll9WWQrGKySaJSSTS9JKp6u1y31K427jKkP5wn90gf0GNbj4Vapnbt?=
 =?us-ascii?Q?2D9ZpsjGcSfr5+fG5Dsup0MdgtxSrgzl9NzCgQhFwWKFgkJUUG9JRPvOslxa?=
 =?us-ascii?Q?Zv6YPBY8o5g86aMUrBs3TjMTmdzWoM7yKOEfauu1BI1W2B3TjSCYNrUzlx0n?=
 =?us-ascii?Q?2rwQavfGpk3DzLmMl8Cs6OSMqnGYBzmrSQCza8Ty4fnzWrnhQISg8wko7w7+?=
 =?us-ascii?Q?4IDfTeh0JESWpnxRJQPfL+sLdi2KkOqBykebafwEQqC3UoKVTVgAHuTx036B?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe02d85f-5ce7-4039-1e32-08dab5bb28c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:27:47.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0rvmaTUHDJwr34XTVEWIokddnXWs58G8kGaVLpCfiVXuO4sZahD81wBs/EOpqP47eZLbrKGWFo7jneMOzXE60nUfW7s6Fmc1WFguFm3D/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:27:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9805

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to create the BL32_AP_MM.fd binary by edk2 which is needed=
 for the qemu optee generation as dependency.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/edk2/edk2_202205.bb   | 43 ++++++++++++++++++++++
 recipes-bsp/edk2/files/rules.tmpl | 61 +++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 recipes-bsp/edk2/edk2_202205.bb
 create mode 100755 recipes-bsp/edk2/files/rules.tmpl

diff --git a/recipes-bsp/edk2/edk2_202205.bb b/recipes-bsp/edk2/edk2_202205=
.bb
new file mode 100644
index 000000000..056b612ce
--- /dev/null
+++ b/recipes-bsp/edk2/edk2_202205.bb
@@ -0,0 +1,43 @@
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
+SRC_URI =3D "gitsm://github.com/tianocore/edk2.git;branch=3Dmaster;protoco=
l=3Dhttps;destsuffix=3Dgit/edk2;name=3Dedk2 \
+    git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
fix=3Dgit/edk2-platforms;name=3Dedk2-platforms \
+    file://rules.tmpl \
+    "
+SRCREV_edk2 =3D "edk2-stable${PV}"
+SRCREV_edk2-platforms =3D "3b896d1a325686de3942723c42f286090453e37a"
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
+    rm -f ${S}/debian/edk2.install
+    for binary in ${EDK2_BINARIES}; do
+        echo "$binary /usr/lib/edk2/" >> \
+            ${S}/debian/edk2.install
+    done
+}
diff --git a/recipes-bsp/edk2/files/rules.tmpl b/recipes-bsp/edk2/files/rul=
es.tmpl
new file mode 100755
index 000000000..0a09c50e8
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
+	dh $@ --with python3 --no-parallel
--=20
2.30.2


