Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6620C4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:49:02 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.85])
 by mx.groups.io with SMTP id smtpd.web11.22465.1668977334826336138
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uHX5SrzJ;
 spf=pass (domain: siemens.com, ip: 40.107.6.85, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcMkgb086a+cfGkf1s8/D+iNNOAVJkcS5Wfvq9KhwI1soPejhXmq1Wlt3mOcM+0vZFcX0egetO83D/NJsGcB2PEavJ4U7qmBorUfNOg1tyHJboW4ATDchDCQOWmp7vchE6ydH73zpBEICMGitTK9tXU80bBz2j3qGKxRirItnRAfuGp1GOhRlSOxXECDsAc26TY5lgkR/nCJFHAzm/+ru/VUvto3pMF6w872eA8RP9XgaBQtDFO3ktW0y9A6SVSbdqql5K+NHi3dnrtlQG/5pqUYZIHMTkvyTwXfmO9zKfPCOIvNAm5O9CEMRkPDuaDhJz360dDfYU3T+RnpkemItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqfvyF6RD9nWdDYRry5FxZOhSCc5UYvo4G6EgFXT3Ms=;
 b=aZfjBmDxE75IwdcD42TA2ZH5P6sxcW9ViTvIi16z3EJ5ync4M35i6Dxj5Qrxjh8z5VGvSQZ6/LCWb1+mQuZSXD9nu5Uh3J+Fr4SkbykSsTfmiS5+07NSD5KFOp5CaXRgivR+zJGYLwfivfaMjXAAodPjp0tTTUniTlsb1XbMgXUqMzdQt9mXVlls1W2dqCvZrQYO59s1FcOS2K9Z0y9roSodXfaWpy+u0C1wymfh5wPErpq6DOoLkQ/if9KeRfeA/YfiuYFV/tNQ30S98lc72nVWAd0KAgr/B8N/8MxBbdekt2Ge0Fb5Xxpr+jx+uh4B7DzUBbCx8NfJaZ/N9GV7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqfvyF6RD9nWdDYRry5FxZOhSCc5UYvo4G6EgFXT3Ms=;
 b=uHX5SrzJQHQSMgLgA7lHRjOuXPzy6czLSa707hnyFHEELuNYkFAp7qOtF5LPSLxLdGzCLypfJbWaUfRExzD2UrN49ASyUhxoLdWz6lJ0O8FSap/rghgI0kVyywry2MAoAjH+7Y+lj90rVltTS0r2VoWeNKHahxD1uYuFw2cn9xPoxp3/raLHXhhcututueExP0KmoM7YF4vN1zMWvFEuwY5Je2IkO4tbm662LG6QaoFIx/kDTI9ZIQ6hXSXRBdywpW5fWRx7T1BbBVeSEQ5nXU4U4lur4tfK3Y5zh+JL4LlIiyJl2DQ49nXiDECJ+9EwIHQ0WtHEEra91mzHaUcBzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:48:52 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:48:52 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 2/8] add recipe for optee qemu arm64
Date: Sun, 20 Nov 2022 21:47:05 +0100
Message-ID: <20221120204711.5826-3-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2a9a8a-dd68-4fe7-57f5-08dacb38a245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hLL7FLGWh1u3TOcWj7sNVprixzJUUf0gEerSb9P4b6EI15KHrwifu6o/xV3yvhDCyjBnHiJy+lTriv5S+Dz7DRm9t/iKEsEz7i+0PXq5o+spqLMzLexvpWPiH3fXo2MDFd8kOnWvV7oM4Vx46QFbtERSslWucRrDUBBZ06QsYApU+G47Ra8xGhCdiY9sFPlwjgoOfwJ4MyCdHp+RRY44HK1/hoQEMJofxQovEIlAwu3Rz2Cvi9fXcZINYEJpPDmyEbpUrYpom2ikujlAZCHaJhNrxQkbbdkFc0x/IP1BPBoBDfmMpVLu9j/ENRV0WjFeCAAjygmw3vuHQctmVJd0optWsrxaqyW6d5xOoRLy4dtko/4yuE0mdWNMJVugNR4HhI9CPCx6xUjZcKooUpXRu7EDMcjbFUpulw2YzkBdADwgVNKvqfZBaloy9Mfs2W02GfLuvioUHT/E72y+5ZDMNJobxPsvKRd3XzOQ/KVRFC6JTK1WMBJecTeV5WCqkar/5pZMm9YCOIZTUXgjJfC5t4iMglZGrPKy0QfGYo5v6+tCjuaijngF1EPlxvoyb+8oFy293/xQ0FLEYnW0rfV/gEUPiJzJlYZz7L3Wt/fqbuLi4419S78IhyDwV6kg6CEAswHLhQs7ZhqFaVUTLW1iTW6aoShW8bZu9efMMYubFlk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WFTvI0SrJq8Gwfk9FY6VTLV6KypQlcyKCEDQdMuZz/9OvpQdbGvAN7zxmXGA?=
 =?us-ascii?Q?Ab+hMhqsIpCYMBIk+xy6UVvqBDeQQYmeViPdiAQXTiDGwsl9OuBv6Kp7OKCM?=
 =?us-ascii?Q?92ppQP5TBFZgXkbxbZzfyZQGpEUZl4Lc69FYqDJ2iE+0mbajFs0vUb3naki5?=
 =?us-ascii?Q?eqk29NAK6GyScjPiITZvqk4kAj+OsDOa/WpXEhscUnOIoZWmA/I/WBmjvcwp?=
 =?us-ascii?Q?b30XhJquHCnt4v0z9AzUHtCYcmdHotoYzdpfyTSDg2Mdd4X6qevWDXImtLvK?=
 =?us-ascii?Q?u0/oGLGUmcnFtSBOji6aMlP3SAnrj+PtGH0tPBsAgxQMk3w7xUKN4DEemGO2?=
 =?us-ascii?Q?LnGc5moWH6XyIqP7GCSOxd2BGza2mp6oTLvMnDNVvGF974YdcLl78IReEhJf?=
 =?us-ascii?Q?Q2FLD7aSsPXOYP7xG39AIeUezhzdVz9Lf3Im7H0zYrGDvce23eadqTIBToHA?=
 =?us-ascii?Q?xPtk5MvlAfNIEB9WiG6QdcRwl9ET3vPTawubTuhs+8TQ/PeGU6U/cUEb8Gg+?=
 =?us-ascii?Q?PKfXxglWgONkNvuZLaJZfFiSjLHeS1HWrRa+7J/Kep4syOw0uKXrdRoN2zdb?=
 =?us-ascii?Q?ku6po0sNJWN7cHEzoOA8pUzA6P81jXTyc24wLI4jG7AI0QzqS6vgGOb1ziCY?=
 =?us-ascii?Q?f1j8R5aoaZ+Ax52lYbsQ4JKqVIV52fRYEZD0X+g2HfTZLsOCNNX60fIlvdB1?=
 =?us-ascii?Q?duogcd3hNCz6DW7S/xwUP3HNR7SaQkucmlVhOjKang71cpAg8iNJrltEDi8O?=
 =?us-ascii?Q?WJN7BhOpDyX5E7vjAlMsZSXpQ/EKL981s5OCoLwHasj2GaGfmAYNVWwRUzQM?=
 =?us-ascii?Q?b4nyVz6vsgoV3iAsrigZXNbEaTD4UmZxwp3GjjOosLs3cqmQIR5Dv7X5i6Pt?=
 =?us-ascii?Q?pt4hRDYIIh/u4viv13VcD4bFJJsNAAt/Z+Btg7BiVIJ8bcbo8p8P0d8CRUXc?=
 =?us-ascii?Q?N0NMVmx3IccuWpd1lEBHHwmNJprow2nFty4bVyZc5RenY90DVYugDF972c/E?=
 =?us-ascii?Q?5dNqoXadUxs2aeM5mEn/IlhSvwWlVqNh6IZcmKKju8hRCEChfMpcoIWeY9nI?=
 =?us-ascii?Q?Ny96DfimsHMgW51G6UU6FjhyZaWJQl30OGs4ED385WWMp+OPd6+aWSXBCaDX?=
 =?us-ascii?Q?uSReZEjrhAsutyJIpqSSrbO9u+XGVM/Q3eG/w04VJYd183qusN0ZoqprU/I/?=
 =?us-ascii?Q?5KuK2rxiWOfaObgf7zizMg71G4ddJGCDx9YowiNxnDrdpTrrUry5fh1gSaNx?=
 =?us-ascii?Q?oztrKAxPeLLtel92iYJPZoCoGSOREj+s79YtQORxEAYGGd0LwH8C/VthuC8F?=
 =?us-ascii?Q?/i4yqBIVNjMAXQkIa+/n7xI0BmNdTW1zxDADmsopmnjHtjjTjhZIH+D0/yxg?=
 =?us-ascii?Q?ABElUw7IP1fUwVdNRCFWHACN9iVet+LcselgZfifISD15+evy5Qw62kpu1kq?=
 =?us-ascii?Q?o0ilzmOMJUZuW4HPZcaGBvpWlGT2qqlzrCnDtp1YAS26X6J7SxQj2yY8FeQp?=
 =?us-ascii?Q?0j0WLxgx0tmdDVziM2MODhpZ+oD916VuOMhEy1rgTwdn/0tFeHLM+L9rzcvw?=
 =?us-ascii?Q?CuCj8YsnF9Au0vgfoVr0gYRRBckr/aeXSsC07BDs4CFLUy/i/x5J7IIeSUks?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a9a8a-dd68-4fe7-57f5-08dacb38a245
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:48:52.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIBu1ExS867Tf3o/ZNWxMtLBw6wR6U1CgpgZmGzWcaudjLz9FhSK9GemxhCvlKSJiqNv9XkNsxriKp3MpmTHWW8cZFPEDRo0h3h/pnu0oSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10055

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


