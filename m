Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A7CC38A2D
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:28:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.66])
 by mx.groups.io with SMTP id smtpd.web09.18502.1666614511977565809
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:28:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JEAOzrfC;
 spf=pass (domain: siemens.com, ip: 40.107.22.66, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyM35ZpqgbYhj1QJQYU64H1ILeRcjVU39cxJlKDV7WQfRShZVCVRb4R78OkC6bn9bIXenooV8iSp2W6QeORK4fFm6HW1+hgkQNueuS4ES7iKT+q+nB6CTksxg8RkykIaQWgDfbf7A6+8cGNqIIrS0yj9NNknMjA9CzYIFgJj/BATZoCl4qW78VwBov0cNApbJHnKbXDfaCnxUQJAiusYxd+TRWLNsWbPEFYSbAHrQce5IuoCx4Gl43S9G2TBWVU8J+KwqaPAMI+lR7nx+vMW3sP3xlJMtoxjrbRvQGMbbhy9mMwZj/oTq5izUkPJXlkv4xjirjH+M4DqCAK5+Msp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6BLZa1QtdIvgZOrIj+zfhKXHIGsSSeE5LjDIGIpm3I=;
 b=KI/msnJ+hz9IpBWQRSLl//5XdyqppLaM9fdE7E9inWc7yaQByz4dBfg/HCvUdcRs67/Oy8g7UpkXlcFsvkzg+WKLOsegQOntZSk7MeeiIkvIYbQjtuRChgJ2dykzo2LoZ1CjVNfDiiqjPGA6rMdBaCBrCA0HkOqVEdo3IMQU5/LUZgRpMMHXc2NQPwXcMC+5P0+J86c/OaT28w1o/sD/KR/s1BaGIqu53xr9Iv49DT3lMUJAFHbTFT3jZcz0Vgd8krEfHKLXcpCPpEOAxhODsltC3sIR1iW90w6m7HUlJid/vQqjRmh5ZCqQwvvIlWdIMkNT8BnsHdEBBku4aodZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6BLZa1QtdIvgZOrIj+zfhKXHIGsSSeE5LjDIGIpm3I=;
 b=JEAOzrfCa5DjDgru6Df6dmqgCP+s2DPTmqhLNf10ElJ6g7lkiqRacn5e97RoPqcZSgk0fz/ePPtZpYmH4kWApcc6IvVVbceIImSsI7CzBlfII5FmHCtIQJIA3amdfd6DPjOcPUoRkc+LYiW9Amncu7p/DAC3XV9ttXNjo5aUTZlZ5bx+cnDCoeKa+rAWNdGuSADyhFK66P+TCIAMnU2AqNK9T+zUA0Xk4i/LRJ+mjYHPwyV1fy3BQ0F2jfRisVK60VH02SB/UB4QTfi9mFcZT4bk943IkbXCyc1Y2te8qwQlGX0u3+7s+o23S+EBP3gphd4IizrOzOwBH9hemjZa5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PAXPR10MB5783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 12:28:28 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:28:28 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 5/8] add recipe for trusted firmware a qemu arm64
Date: Mon, 24 Oct 2022 14:27:22 +0200
Message-ID: <20221024122725.383791-6-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0105.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::46) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|PAXPR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 278d2f2c-609d-4482-4565-08dab5bb413d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+NHGxdtOmFcBCKcB/WeXT2jnY26nw7JoARwHg2DuF+lZg+5zbTGAmy9uPn0TAeQn+waEmYR2o4IzarkFzBxYzH0mWWYWkyV335jje9+3X4fzz/wxeN79OcfDBUepV/sgl6BBYArNsPHQhdyiN9cQa7V00p2TMpVGFVl/gCwkEoFOkKPMPuepqEhdXqObQ7hgXLmoszWrSBf1FYKjUzytat9atj+y7ZP8/AspTOT+rS3I17T/WsW+dTIO/d8Tfcua7DfciVLxO+D47f1SaJXwWTy7INnST3r+Di9bmoDzRg5s64A/J/V+Rc5p0NaqFZrrkxVKkO4YeyLFrGvm7oGjO3lpqxTpEYzReCi0GaGGV1y5pXAdtIWvs09BXB/0r7bAmtTl4iPdQrIqI2+F2qR6VTqbxanDleIfRlDTGmL2Smvqd6F1XvxvNpc03tQQ4GXV1Ijgq9dJGP2XaD6u/Fxhyfz64Lvdw1vFZxWCzkXUnQM1cdROFNaTIDFoJo3ERLfQJlYOcZ1xDRc8nPlSttv3AC0FWe5k76WAmOzYhVph0POfbhXqgN45WAf2qimIN1l9p79W9CBJPIab0zCIet/irwsbeFiwCoSTVMFkt7pfXm5RqSeGluA02TslGp3yTvwO921UOx/vaER9uVSqNMDmN50QhAhbGISmUcJtihepxiuLJ8QTXYfIEE1liv8T1XkbGakUPMOb76zz3YK6SPHvQYbArT+1g/4XzAPmHrtw8iM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6486002)(5660300002)(186003)(2616005)(316002)(2906002)(1076003)(86362001)(38100700002)(6916009)(6512007)(4326008)(8936002)(66476007)(107886003)(8676002)(478600001)(9686003)(26005)(66946007)(6666004)(6506007)(36756003)(66556008)(82960400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eZnPGecsmlwutk4EeFGqCN10mWz2R4SBStHgX5rMWQ5TNII9rvJZZzTqt78e?=
 =?us-ascii?Q?mC27mg0MHF4Q6qOIF+4O3YNHxGZOfaw4Xr+jko2Zxqm3YcAc4NoN6CMg4ZSr?=
 =?us-ascii?Q?AyFjF10eX3BenOS/6YuEOvC2gLuYA4jFb11PH7o/fTtGTpZhIQNaVr+w6mD7?=
 =?us-ascii?Q?tnUlDKixUvH0ijwD0EkMJBuBKOB1D3Ob+c+OWQFi/+Ym8MTsE7iaDENO+K2N?=
 =?us-ascii?Q?BOgmDICm9VCZbAABct3GM1GNUp0yaVecF5OuO9S7wopkRdFaoqDFH+0JNm26?=
 =?us-ascii?Q?S6l5goLbAPNfzL7jOYNwzOOyQh73PBZ8MQFiMpDv5cu2yZ4dGG8qDcKm5oQ2?=
 =?us-ascii?Q?mYodnBkR6nCbHtFt0W0oL7RuluPO6cwvTuUf+I37uXYo6bNJ5zInR1z4qbPQ?=
 =?us-ascii?Q?yegkbTl2LaQ2U8VN+WQ9ri2oaECaUapPasCe9EOsbeIlyYRePRJblzQl566z?=
 =?us-ascii?Q?PFazRPPzL9oVGxCAnlDxaNyA7FysXb/5eGVTW+SauW9jXIOIZfh0DA8Y1mQ5?=
 =?us-ascii?Q?229ulWbbdVwKGjcKJHo9tTv0bQgKiK/saq6MUmeiCL3hAQRLdUZUW1fwqtHv?=
 =?us-ascii?Q?s5potNAoFYCB09LOv9YofjLrmmUHWuKp+JT35NiIxSsoXTRMk2hHdfkrrj6a?=
 =?us-ascii?Q?gIKiACmp+FM2M4v2QNHF+bu8i/m7+qfyN0+JdR/IucVt92XbV5zI1rg7aSQL?=
 =?us-ascii?Q?F2BLGP8j2jh1/Bc0H2pItEXwhauEW/WoW+htROaSa+szBDfvB7Lkrk8mivT9?=
 =?us-ascii?Q?Q8otU5iiN15rxFYo1fFoRkSF+GBhlQKqHbVEqh5RYjEvcTYtY4qGUcs27kgO?=
 =?us-ascii?Q?O5hSB5lyD3fHzRK+lLFg7RM8yHAmcqGC6dMuCyT1/iU4drqCXLJ6ziyioQoE?=
 =?us-ascii?Q?r83TxdC1JU9iXeqQgFIImdPZI++4qfXLs3wwd8muOsep2Lwtq4GJu478HzdB?=
 =?us-ascii?Q?3ichwBrfm+ADiAnXwTGc7C/+FbJOxSYuL8L9w4KTAEKkPMJA8jBzBXBELIAW?=
 =?us-ascii?Q?U+vPePUCzw1iZ3I02rIF/zDO/Wc1Jgkn2XakuQPAaU0wDE+FLdTZhqsiHQt7?=
 =?us-ascii?Q?U3atZNcYCd2+AKJNMw4vuQj/OSoH1bQ2RxrmUk5lBvIWSbTxEJ9roOlWqzON?=
 =?us-ascii?Q?kJb4sTUtfnmILdLNjMh8R8746RZZejusx3RDJWtpUjidFdqVTrZuPK4ncIo8?=
 =?us-ascii?Q?zUaM2me+A0GXr6ClwH6CJV92MSNyY6UYsngeFXxlM3Qbib/jQSoYhJus9g7P?=
 =?us-ascii?Q?p78Csp/VM8AUIA5zRw/aZ4SUm6A5l1+AhFLjQ9xsmsqkN9/QxqavnISNQKTD?=
 =?us-ascii?Q?T4UNZaixWc6XtH6C08Cvngdyi4wiuV9EtTqEFDx8JDlAv4fhn4LyFjTSh2tA?=
 =?us-ascii?Q?83YWMo8xSTdxvrl/BXMACJoueqrdqeJ5tTIS1va0ou7HHrjJxDaQjcG94mH9?=
 =?us-ascii?Q?ESPRNaosKEQcN/aUL+MkrxGWQVMfBMC9wGoxdqLgDMlySwNk0UwkrIMYbRfy?=
 =?us-ascii?Q?HffrV6nSzQc08Tctu/G39EuKwAuVbFajKlpSBDZgcR7reFVoWsFiiJDKjSV9?=
 =?us-ascii?Q?U8LX6OqkxhrxI6cd5hYkPqiuIHq9HsiIVy5xFCkaT4oQIUafKiR1Ohtcc3UW?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278d2f2c-609d-4482-4565-08dab5bb413d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:28:28.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS/9Frnu1nb5Ldb0XCcc0T79RiCd1fnZ5McJJjeKcve15tEbLOvQnv6vsgk8zLxP/z2z6dC9GMrNh9VZX867Awn68qRL73jCj39m1biN1lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:28:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9809

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to generate the needed binary to start a secure boot qemu =
with integrated optee and active RPMB replay protected memory emulation wit=
hin u-boot

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../trusted-firmware-a-qemu-arm64_2.7.0.bb    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-=
arm64_2.7.0.bb

diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2=
.7.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.=
0.bb
new file mode 100644
index 000000000..791089a21
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
@@ -0,0 +1,61 @@
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
+            git://review.trustedfirmware.org/TF-A/trusted-firmware-a;branc=
h=3Dmaster;protocol=3Dhttps;destsuffix=3Dgit;rev=3Dv${PV} "
+
+S =3D "${WORKDIR}/git"
+
+DEPENDS =3D "optee-os-${MACHINE} u-boot-qemu-arm64"
+DEBIAN_BUILD_DEPENDS   +=3D " \
+    debhelper(>=3D 11~), \
+    optee-os-${MACHINE}, \
+    u-boot-qemu-arm64, \
+    libssl-dev, "
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
+TF_A_BINARIES =3D "release/bl1.bin release/fip.bin"
+
+ISAR_CROSS_COMPILE =3D "0"
+
+do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${=
DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/bl1.bin" \
+        > "${DEPLOY_DIR_IMAGE}/bl1.bin"
+
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${=
DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/fip.bin" \
+        > "${DEPLOY_DIR_IMAGE}/fip.bin"
+
+    dd if=3D"${DEPLOY_DIR_IMAGE}/bl1.bin" of=3D"${DEPLOY_DIR_IMAGE}/flash.=
bin" bs=3D4096 conv=3Dnotrunc
+    dd if=3D"${DEPLOY_DIR_IMAGE}/fip.bin" of=3D"${DEPLOY_DIR_IMAGE}/flash.=
bin" seek=3D64 bs=3D4096 conv=3Dnotrunc
+}
+
+addtask deploy after do_dpkg_build before do_deploy_deb
\ No newline at end of file
--=20
2.30.2


