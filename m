Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC75C4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:22:41 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web12.5881.1666171354036525480
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=n932iX8C;
 spf=pass (domain: siemens.com, ip: 40.107.8.85, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oppy93iXO0HR4JIPP3+aMC9QP7A9Fuo15h8hM1mUs8oK/4asvBvCRvgUdoE1mWoV/E6645eNzhD7uCx8dl/3qNKQrnZ/fjVHs/m13oQ75UDG+W5ZWEt8ZSLeAqToZLMN+VT01mEB6pCOkWreSz0Dpdjt7JxN2fRbi41mW7fGetSfZuA4nx2paw4td8XoO8PPwmI2yoTHFUGqWJdjAQIjgrVqU5xFzWNslVEgCzOE036tISIuINfRaS7LpH87xGf50/DJ/9C1PEZ552sR6hKMyM4WwOVBiQchNulI32zjU1RnCU7/TFB8Kga/WjZA/a65b5dU9ERMfdC5XPwY0RujwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reWrLijoqm7tHKQoUIM4VDBkk2N/FcX9+PxS8fbvo0g=;
 b=T0/Z3seCnmKMckPQ2PDqxGVjFcAs2+WrBUDBTCeRlJb99JfcAuc5sg/RvrTDWYyV1mm6i6hUgdtxbdSbwYQdgsc2GbjpFaW8/zg5z9U8OClSzCl/xDBZKmdeOTIUc0uPzlNkh3/2lYnbH69eT3ZwWnXV/uouuAQcnZGt+bJcez+EsIs+v4DevrFF7HWs/aRLjZnOpVRmcfTk+ccJ9Xirle6V+qQaRacHVzqG/eDgr/Reoon36LEtB8FvKH+5dS+VYeJMBNLHq2w+03m2JOWDwWfHNlLPjLvm08qp045BU3EXFDLkQdJN/951tOi5vCl5r2WhgB6KVlV/35IkdZjWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reWrLijoqm7tHKQoUIM4VDBkk2N/FcX9+PxS8fbvo0g=;
 b=n932iX8C5VxOZM7HYdyW/pKAlOs564pitDJUuc19ALe24rbVx3VOBauFe0L+yalVAqOoNKMPRE7jSuMHDioPSJ4TFk3QCcybKG9FzvCLS2iYRgjCnMNxZFd/PtMLpCrb452UfvuZjZLgV2Da9nYO27NxMpGckTYy9ptgqEF3Z2VG6rebI72p7mA5wH7cI9eFk4h3pFdtovTVOy9LThuxiRIiCCMqD88mpVxDsiqWbF4uoun5lTPofbisdI2bLz7Hioi0ZlkpxXck0U7lthZKq+7UzTJ0mWo1V+6q81IiqXDPf205JwPiliKJyTqeiBbng8v9DW80Cv1k6dV/UugDgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by GV1PR10MB5867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:22:30 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:22:29 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Date: Wed, 19 Oct 2022 11:21:12 +0200
Message-ID: <20221019092117.5291-2-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::24) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|GV1PR10MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cd49e7-935b-4ac9-49be-08dab1b37218
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qdAwnj4dwF5dYy0goxUOunTptlkxVLWnXZ6lv+OGU5qjkWkHAN4Mj/Erg4mInq7+bMPEIRx5V8sTUbSuNgOlqcuDF29XE3/N67+is48X8Xwr6BI164OlBilG/lJuCY3PyOYPPVgLeaV8qbkRCMolDDlyGASKrnNbuViPQP+Tw6OMS0HgCqiniUN0jmrcQ1XGL3BkOV26jB6Nr+8ClRpy0L2s20Sb3Zz26UilWMvlC8oun56pu27PsKJK6I99crWO5ri48zstd9f/vV+2Sa9HzHuR1MXeOaV0r/RQ25kWUHgoRQAW+e7uXQhVaLytksePN/MuY44eQSdspZQ80WJkyE2XG80PUZZIKECi5FmP9kCEBFRXDpao3Yr7wzZ4tLIa9fg2fJZhQbYAopVc8U/Hyr01Ommpcnn5BKecqdLV3U4Y7tlmGGgM6MQkiP538o6pa82BL6cxnk7vk8zYfnFg0aBN2ZWfdrgQ2P1JXl7F/pFKmTCpkOtRCKKywkYcofL65qQOD+7bzLw85ZCviDVbZW+wSnW+mRe8Cwh8Uqb6qkWPIBqZ7n2HL+hr1t6tQwh1BQ+6inLVg5qjpIlN4VWnV3oKxGvLuONQFrsJ8nJNbaGGr1mSLIrSos82J9YHYyN27p4M0syEJUpqu0u0qoyfdHwuqhLsHMDMIdjT7p7+ZWHG7xxqCDloco3RHNvzHICWyxHKTUCvYzrT3Zt8tvMdz7Cro7dGjYOUivu6YWXnquwDpsaBCeR0ArCLFVUapfwCYOidvTSgXU6nyspZQfAcUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(41300700001)(8936002)(26005)(82960400001)(9686003)(6512007)(36756003)(38100700002)(186003)(1076003)(2906002)(2616005)(5660300002)(83380400001)(478600001)(66946007)(66556008)(66476007)(8676002)(4326008)(107886003)(6666004)(6506007)(86362001)(316002)(966005)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vplcKXiGXjMlgAy5UuaMfMtuGz3i0lEFC8rRMvV4Vm8ZsT4SGww1w5xGWFJG?=
 =?us-ascii?Q?eMcU81JByleJShRNvNEkFgNlJk7ThAdSZjdw9FxQVCeRbULjJXlh+07Eo1j9?=
 =?us-ascii?Q?Qnr876ajHFBJm8EkXqUm55zBMrrcww8NquDmJrW5+Loff1Fi2IUYiJiZDODe?=
 =?us-ascii?Q?pNlt3jyCUrwyeJy5Q68/eLOq3b0QJPJUkprkOuA4ynkade4VrTtX44rEnH9+?=
 =?us-ascii?Q?UFeCRXzr69H2YtRPryAD2T9QxuCA9+0T58cS+nW1Du0kAVWkHe3VBdMUpeFT?=
 =?us-ascii?Q?qEGYcO0cXQemb4IolyhGXLyiV+4yxPr24lbxvS6lUF1xcI+5g56CTv+PeQRM?=
 =?us-ascii?Q?J4m2NNDdDmsQnFFTilBc45wdkA6HbJqLa2Wu2ouDmrstCeNit+R5hqfhmfK2?=
 =?us-ascii?Q?cC5sTF0KXgbJhF2+r5JbET68rs4g8Mglamz9CfXTbgQiWQj8dBS8PqPDe74B?=
 =?us-ascii?Q?UoirFNTzPxiEh6nS/kn9KCM1pIYv5iRfVqtSGLjjlVf1FsKsFEYYfobMMCz4?=
 =?us-ascii?Q?SUvCmIiHwLPa5nEu74AEdTpZ41LoB8e/xwM2XN9mx2AToixCZDwouyI6Fhm1?=
 =?us-ascii?Q?9MZFH1gCzo7ydk8Y+tgRneveVPKLmlnGJDsl/c84035xbfV4R/BFPDTfQ0gQ?=
 =?us-ascii?Q?faPJCdFKMEiDIZivBIRXNr6jNRwo5EkwPoInOd5YO+ERoN7NbTiBvtFxAXqq?=
 =?us-ascii?Q?ptWTEknxmCRWIbadBX9iHddDJ5pN7ni2Mg80HtlNFTytIVCLTSXqUuVGnnnN?=
 =?us-ascii?Q?EPzkil8Puf3v4WPZsoGyPf1fG1TGQl3oqc8sghDnvFgpBKuNec8zBSV2+Qos?=
 =?us-ascii?Q?+0/6rQX5et2O7zO7nP4LcZt1C9oPCFQmqc10wKGzNyNIahcCbnnINuG31KCP?=
 =?us-ascii?Q?nvTM+kZdKUfFJ97LC89LMbjq6okqbPggbBTMTuzr9bu3Q6gXb+LHIZowSukn?=
 =?us-ascii?Q?OFAZKRD4Ae4sAudvvfU1DoGtzM5ymIKSD9ZuYBSCSC3aSF5nlJ6DMRu144l6?=
 =?us-ascii?Q?6nnfn+gZhnbrki0lFh3J/C+0npZpzAtEOI9CE5dYwwCKlJPIJCF4bXkkt1eV?=
 =?us-ascii?Q?BiDLGgJ33qaW3/bujKgPwYw9iw8eNP3qSrzATKJjjjg6m70EZuuI7gj9XOPe?=
 =?us-ascii?Q?MmFCFbRzYLQNWwpoLLFNMZJnLFD5chZCOf1deSVfph7sl7jHheZeDrEXvJEo?=
 =?us-ascii?Q?04ey8LwPcVKIUQEPRyYfxKiJYPDBln7c01AFNWNyixma1mYvg4izfqyHsQsW?=
 =?us-ascii?Q?tJsL5XmVHCzEeK2MrlW/vQvZxT+TFbQbi0URqlFeZsSPdj+9v4dOhjIz+fVp?=
 =?us-ascii?Q?f6satUreeznyV8zl9d9ULY8mO6HH2wUjD2sO9MBdCNVbObIioQpK+l7d+BQv?=
 =?us-ascii?Q?KUlBbJkriwNWlRxQTjwwEP03r/0z4Pkgd2GFA28NOrhCxSgVBdAvfEsJNZ3c?=
 =?us-ascii?Q?tHYDduBFgxjYmyQ//1X4oPEL9FMYN8Shz2ZtS6bXCAiGMJ/aqEkKwf9eneYP?=
 =?us-ascii?Q?PQ0QfBOUJ+b9yFXBLXczefe5kGYQrvAvll+i5UYo4HgTOuWs/hEOusM3QclU?=
 =?us-ascii?Q?XNFmO6DsBtiv0FAKwNuhr0m7P2Ly0pNZ2hPuL9LA0Uwc/ItNPG704m0YV/4Q?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cd49e7-935b-4ac9-49be-08dab1b37218
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:22:29.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxAVtWP1+b9neURJi9FxCXJcnvM5Ra+Rcg+G+0+OWkar3E77xLzeUhxVTcQn6I0ztLH/q509SSk9Z0Ambanw+lALiBd++guCSWui7obvw98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5867
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:22:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9776

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to create the BL32_AP_MM.fd binary by edk2 which is needed=
 for the qemu optee generation as dependencie.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/edk2/edk2_202205.bb              | 34 ++++++++++++
 recipes-bsp/edk2/files/debian/changelog.tmpl |  6 +++
 recipes-bsp/edk2/files/debian/compat         |  1 +
 recipes-bsp/edk2/files/debian/control.tmpl   | 14 +++++
 recipes-bsp/edk2/files/debian/edk2.install   |  2 +
 recipes-bsp/edk2/files/debian/rules.tmpl     | 55 ++++++++++++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 recipes-bsp/edk2/edk2_202205.bb
 create mode 100644 recipes-bsp/edk2/files/debian/changelog.tmpl
 create mode 100644 recipes-bsp/edk2/files/debian/compat
 create mode 100644 recipes-bsp/edk2/files/debian/control.tmpl
 create mode 100644 recipes-bsp/edk2/files/debian/edk2.install
 create mode 100755 recipes-bsp/edk2/files/debian/rules.tmpl

diff --git a/recipes-bsp/edk2/edk2_202205.bb b/recipes-bsp/edk2/edk2_202205=
.bb
new file mode 100644
index 000000000..5a773bf77
--- /dev/null
+++ b/recipes-bsp/edk2/edk2_202205.bb
@@ -0,0 +1,34 @@
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
l=3Dhttps;destsuffix=3Dgit/edk2;rev=3Dedk2-stable${PV} \
+            git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps=
;destsuffix=3Dgit/edk2-platforms;rev=3D3b896d1a325686de3942723c42f286090453=
e37a \
+            file://debian \
+            "
+S =3D "${WORKDIR}/git"
+
+BUILD_DEPENDS   +=3D ""
+
+TEMPLATE_FILES =3D "debian/changelog.tmpl debian/control.tmpl debian/rules=
.tmpl"
+TEMPLATE_VARS +=3D "BUILD_DEPENDS S"
+
+ISAR_CROSS_COMPILE =3D "0"
+
+do_prepare_build() {
+    cp -R ${WORKDIR}/debian ${S}
+    deb_add_changelog
+}
\ No newline at end of file
diff --git a/recipes-bsp/edk2/files/debian/changelog.tmpl b/recipes-bsp/edk=
2/files/debian/changelog.tmpl
new file mode 100644
index 000000000..8d74dfe7a
--- /dev/null
+++ b/recipes-bsp/edk2/files/debian/changelog.tmpl
@@ -0,0 +1,6 @@
+${PN} (${PV}) unstable; urgency=3Dmedium
+
+  * EDK2
+
+ --   =20
+
diff --git a/recipes-bsp/edk2/files/debian/compat b/recipes-bsp/edk2/files/=
debian/compat
new file mode 100644
index 000000000..f599e28b8
--- /dev/null
+++ b/recipes-bsp/edk2/files/debian/compat
@@ -0,0 +1 @@
+10
diff --git a/recipes-bsp/edk2/files/debian/control.tmpl b/recipes-bsp/edk2/=
files/debian/control.tmpl
new file mode 100644
index 000000000..1f1bad7c8
--- /dev/null
+++ b/recipes-bsp/edk2/files/debian/control.tmpl
@@ -0,0 +1,14 @@
+Source: ${PN}
+Section: base
+Priority: optional
+Standards-Version: 3.9.6
+Build-Depends: ${BUILD_DEPENDS}, python3, dh-python, uuid-dev
+Homepage: ${HOMEPAGE}
+Maintainer: ${MAINTAINER}
+
+Package: ${PN}
+Depends: ${shlibs:Depends}
+Section: base
+Architecture: ${DISTRO_ARCH}
+Priority: required
+Description: ${DESCRIPTION}
\ No newline at end of file
diff --git a/recipes-bsp/edk2/files/debian/edk2.install b/recipes-bsp/edk2/=
files/debian/edk2.install
new file mode 100644
index 000000000..e5cadccf3
--- /dev/null
+++ b/recipes-bsp/edk2/files/debian/edk2.install
@@ -0,0 +1,2 @@
+#! /usr/bin/dh-exec
+Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2
\ No newline at end of file
diff --git a/recipes-bsp/edk2/files/debian/rules.tmpl b/recipes-bsp/edk2/fi=
les/debian/rules.tmpl
new file mode 100755
index 000000000..11e4ae8cd
--- /dev/null
+++ b/recipes-bsp/edk2/files/debian/rules.tmpl
@@ -0,0 +1,55 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2022
+#
+# SPDX-License-Identifier: MIT
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
+export GCC5_$(TARGET_ARCH)_PREFIX=3D$(DEB_HOST_GNU_TYPE)-
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
+	make -C edk2/BaseTools
+
+	build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(she=
ll nproc)
+
+override_dh_auto_install:
+
+override_dh_auto_test:
+
+override_dh_strip:
+
+%:
+	dh $@ --with python3 --no-parallel
--=20
2.30.2


