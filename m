Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C7DC433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:29:45 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web11.23210.1669217380593700312
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:29:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tfIFW5dw;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOLboHnaynamH5gE/sp/2jSWI4Z8C1wqNJdjCJcLY0b8X9cLZIqD4Ae3XNz+apQioW+aQbhc/9ze5o9FK+y1kf6tr6vz1Qa8DlmIyEow8GhOjI2jLR4nnds+ZcBC9ciX/4WertAFrE5FRoEIoXd2QNftCXzg9WdT6Dt+VA10Fs55o9YP2PXjIXVM5zGSP6IH2d0PNvuRhBvHMPly2TYGiJ4rVJ7qasl/+nYeHNgeKirPIbNZ5V82N/0lCuRokY0lyKXpmkOfttlYcOTSiVyr3FLtGt0YzvrSo8sNwcgHX1Q6YcnUtIckAbsTGXc3JNvM2HAsscOJ0HaNqejvSaWcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqfvyF6RD9nWdDYRry5FxZOhSCc5UYvo4G6EgFXT3Ms=;
 b=CTi9ZAg/t1cYf25qQH51mGj3nC2onV0fbTHEWO8JK1ChUkn+3v1hl3wKe9VrOK8fzBu3MZwqJmEDbrcWmAXGTYLUHQLX5PG/lalOH0IJIkJoEK+C+SVTQdgh+Cc+GPr3FQWxy2R5FDcjc661wq641HxCrEREP/xVqTMTHtnoX0e6AztN37NVq7Rth68hyVL32SjbuhuZNTeMtWaCgkSUfJJ0/HEFslW0gBrnlx4SokJtUNpj8w/H2kpF8e5eJqMd8QxUv4gnRtnGrAhMuT2Mv+Ho05C9FCVabvOEAman+ueYUarGqRE2GD0j9AKZ3nif3ExptdXai794YeRnyvRbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqfvyF6RD9nWdDYRry5FxZOhSCc5UYvo4G6EgFXT3Ms=;
 b=tfIFW5dwMdU7lpol6uEBHY9RAN0D+hAYj5DD0bui7D54WT1NjUU3GnvUiXm54MuFAuktWqt6JgQ8sNL+LLQNhSO88tW5hqXZnwu+w/Yc0QPxF0GRKOZLzthsbz6jt/LzaY+klbvC1acENEn1vVxqm/IyyihMyZ8ib7DLh5qHO/v9lFtPHMdT4Nj/cK6gk/6iFdQTvN6lTxhSvXhGmgNLcnEL9eBT/eNmeNkvjNOaBNYLUTudqrhLhUX/JkARfqyCWIPNQHdXdVB1JmXQxb1Dg3HTRssYOmwysadyDWJhlz71YBzy5qIcUg7YiAjGEjMywHKzqpsjMkMVNZesiAOnWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:29:37 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:29:37 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 2/7] add recipe for optee qemu arm64
Date: Wed, 23 Nov 2022 16:29:01 +0100
Message-ID: <20221123152906.75323-3-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1774c422-3f3f-404b-cf37-08dacd678830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ul4+LjKH6xWXRIJ9XfJ5lVJcN6kJm/cSlnR3vNGJ43vAS+Fx2PVUYptmHTygcPGU89ql9BQVM7MagAKA3YSf7+qZPOT3KZ40X+YHGkKYjAdE4gFYhEygDFQ6Oo/JE9aLI53GqCJc5wNXnuNmDWIIXeaFMFe3nJFu+f9qHjjG73HyNnLEWsJI4ogc++5z1As2WWc1whoGtxRO4BLuiAOKOH7p2k/eR19u4ohzHu1dRB/AXL/zYnS71w+p3vrs6n0Rl9Bm6UI+7JLJn0O2PaeUxub/aFZhieiRpXt2qCCr7BzCVm1q5lDZDK4QR62qG+J8CzZP5h/Pdgt0yrgoYzkL+FV5OtbGRLOLBqvkEdUVwdeJaUbD8yOKwYh804XXFVDUv/ftrW9VZyoPPDKKpssBsGDJuW68PygF681AZF9/LyljWeBG3Ell6sU22tyTwGsbO+wHg1SB1jLq34Dq12UfpzDbP8SnP7i7IDbUGJqMJA8/TTdPGwU8P9VYv4aC69KfYxg6bvv3a+9mkK2W1L2yOMi/2wsHXiPatZWodOYer8OhjY5TbM8ok3A61U7/mOW8w/45btvEdlcIf4YZGjcJGsiyM2EOdjBltagG97GA37qcgyB6JwdS0mYMKmylk/N2uq8ClvEnUVzs3Bl4rK3p3rLiWWPzsBRQ3K33oioDnY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(6666004)(41300700001)(107886003)(478600001)(6486002)(9686003)(4326008)(66476007)(316002)(8676002)(1076003)(8936002)(26005)(66556008)(66946007)(186003)(5660300002)(36756003)(6506007)(82960400001)(6916009)(55236004)(2616005)(86362001)(2906002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vc73/GGM3Zie+dS0oWqjOnc8y9vWUlrq+yx4KxqpwGFL/VTPoQq+NGJBdanT?=
 =?us-ascii?Q?BuYxPiXCvhgh5dE0THBlXu8MeWbsqjxE4kPseBRkXvtmzlV+jZFiNt7mG00q?=
 =?us-ascii?Q?nOILrK3iZ6bKOEbA91KeAbxuzAmQXVzT+x6Wnqjd67a5gyj2RefeeivDlLeG?=
 =?us-ascii?Q?MIHsYONv0jc1yyrP9kbDoMw9zdjvaOUb4138nRvfO6rVOwhVIDHB1tz1IvrS?=
 =?us-ascii?Q?HuADN2rcRK8hkoY8oXwCY5zhLW8CDvjp6cJDn6bTKwUTTeUe4EnGWBRZybbF?=
 =?us-ascii?Q?AVlKVQZ+KumocxwIj0QrqnwCIb+Sq77kAbVRxC6bO1PdRNCo7akh/2uMRwET?=
 =?us-ascii?Q?kQUgU9JPW2ddEu/sEvvTRnqew0h8k0mJP0XcMogewdqt5/VGglrgZI/MsdXe?=
 =?us-ascii?Q?SLi3F5BYb2Ru+qnzENF0YqYI1I7By3yGRZKhJ7HjmjPA/mjAhO2Ol+M7nvOr?=
 =?us-ascii?Q?o3+aDLFeZCtivmIDuyZdqtjHMI5ezBrwAUIknmdSJ0FD8diRn2BR8u7/SjYB?=
 =?us-ascii?Q?4UyvqhCXmUKtyoeHuxxW4Oql/HGsOM6GZDfT4zKkYJbcQiPlkhAg6CHsJTNb?=
 =?us-ascii?Q?KdhlJvVo7nLwnCwZvhrnNxvBm8GBfEeBLwA0BcaXv9zApXXDtp3g99TPqOTA?=
 =?us-ascii?Q?fGhccSXN9ZP+WuNaK/wd8nZRuo+Sb7nOW7iDodAgudxSyzcwCsFCVxEhY7F4?=
 =?us-ascii?Q?ocx3uOPHNOT6fQX8Y0GlLenLo6ValpOHXg1fJS1UAnHvOCVzJiUaxpWnDy/U?=
 =?us-ascii?Q?9yvBG/UIO8+CDYZdYkZntrAPccnvLWGm1P70EExrwh1xkPBkPeSnlQcewzfN?=
 =?us-ascii?Q?O2jRYYtIdWbYTTiiK4CMKuqPCQzue11qFdbONewL1u0BvHfZqJT0Ys76T4x1?=
 =?us-ascii?Q?0Kvd/ygcnjrQ7Olas2Y8RJZnKVuqio7pxn5ooIH+Xz8blpWsxiZpBRh6h/gD?=
 =?us-ascii?Q?eNut4pHlczGzFJkeaSberrXRhFEsvdfLBgsC5rWscaVX6MXS9DCZK7Yk4jdX?=
 =?us-ascii?Q?AjagU3QXIrcImWZBcRX+DLaQBhb9UkZG5raRA7+eDPMJx5CMJhYHTfKwu5q7?=
 =?us-ascii?Q?wpHhxZbX0Pgtg6aB2mWAnHa9Tga4LQC3q5LL8nRXMykJ+DVVZIXWEPXn3iWO?=
 =?us-ascii?Q?wvrqk0uhOG4ESLZ2vBrPRPSszLbrmGEr2Rd+zb72YmylwPKug4A46hWJN6Db?=
 =?us-ascii?Q?H8g42AIXsNsiYIKYxFnFSTSk/TvQKaSuBJ9NI+GR77Isdm++nCqg3CGeFGBF?=
 =?us-ascii?Q?GezrZc4mPAVQ/d8NcblNtzQpynjKD53q250/qsdmGJKV5+Bj+1KYGrIEUOfg?=
 =?us-ascii?Q?9EsPVPWEA4mGm9jFwnmeiwtPh76ThaVcrxoNZ6uDqVAtagJjA+u0lk3p3DyX?=
 =?us-ascii?Q?7vlEOZ1XBE8Ww06Xff6UJeWccMhA0rb0D+PRWA5kt08Vmo7AAc/XYXNE94Ly?=
 =?us-ascii?Q?ZMBDBHzWx9K3l+O8KYHaxu0xH+opTOe1wLsA2HNY6MHvtme4sFfdJcbyGd6v?=
 =?us-ascii?Q?uYXsvzlYjkExtHZToa6rDASzwYGxBsXW+2WjPYUDN875Rw4/An+2UmIqNOGy?=
 =?us-ascii?Q?LJoJyqrZpB4QyK/d+BpuzV+FCpW0nk0x0LiPmKSqchcAoMmPXJkxQ4QPBaW9?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774c422-3f3f-404b-cf37-08dacd678830
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:29:37.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M+s8JFzcEHVSaAXI3KZG0zTuJubYP3v9P2swny7/21JMFknTmziRsNig8Ompq9422z1WDGzg0TbbR/ULAVm0i2SeI+DlTKCce/2wi7cbFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:29:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10092

From: Sven Schultschik <sven.schultschik@siemens.com>

The recipe provides the possibility to create optee-os binaries for use ins=
ide of an qemu secureboot setup with edk2, rpmb, u-boot and uefi

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb

diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb b/recipes-bsp=
/op-tee/optee-os-qemu-arm64_3.17.0.bb
new file mode 100644
index 0000000..2568c0a
--- /dev/null
+++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
@@ -0,0 +1,54 @@
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
+    git://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protocol=3Dhttps"
+SRCREV =3D "${PV}"
+
+S =3D "${WORKDIR}/git"
+
+OPTEE_PLATFORM =3D "vexpress-qemu_armv8a"
+
+OPTEE_BINARIES =3D "tee-header_v2.bin \
+    tee-pager_v2.bin \
+    tee-pageable_v2.bin"
+
+DEPENDS =3D "edk2-platformstandalonemmrpmb"
+DEBIAN_BUILD_DEPENDS +=3D " ,\
+    debhelper(>=3D 11~), \
+    cpio, \
+    python3-cryptography:native, \
+    python3-serial:native, \
+    device-tree-compiler, \
+    edk2-platformstandalonemmrpmb, \
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
+do_prepare_build_append() {
+    # $(ARCH) is the CPU architecture to be built.=20
+    # Currently, the only supported value is arm for 32-bit or 64-bit Armv=
7-A or Armv8-A.=20
+    # Please note that contrary to the Linux kernel, $(ARCH) should not be=
 set to arm64 for 64-bit builds.=20
+    sed -i \
+        "s/\$(MAKE)/ARCH=3D\"arm\" CROSS_COMPILE32=3Darm-linux-gnueabihf- =
CROSS_COMPILE64=3Daarch64-linux-gnu- \$(MAKE)/g" \
+        ${S}/debian/rules
+}
--=20
2.30.2


