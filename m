Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD434C433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 09:22:51 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.89])
 by mx.groups.io with SMTP id smtpd.web09.5844.1666171362978657059
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 02:22:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HEWUbAEq;
 spf=pass (domain: siemens.com, ip: 40.107.2.89, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho8y7pD3kpt7FVMmFx7/nHhBj7Ndg+BTB6iGJmwkOkimhC51Pn6eLf0yWmn+2BdDX8wtdq2cubkMdGrVFqwfVukz3QrTjJa6ftMPYWmTiJ9VCSAqMP/KRcR+RC4/Q28tLWmr6lxjrelKOc2SnRMkPKn+Yg+WVw0d1pW92NX+ZQt1tsBIEomtLQBPCkgoQCuK91QrhlPKfkfbdBvQ0pAl8cZ49sCyOFdKduEfMIW05QGucFP2DfT6pIV+hDS8GhIjnJjk8xK/cXPjvgxzqWKl2MFUXbvp9DwBOzCQ5IFqVnka6TOEpNyqbwQk+wwQo8G92w5/Jxhy/BMw1bxFXXDWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6BLZa1QtdIvgZOrIj+zfhKXHIGsSSeE5LjDIGIpm3I=;
 b=jRK8Lltj+09VsbUFITHn8iHpEXAwrntvCbzhQ6PUG2R6BhZ5OzrKqQUdwzO3o8bpe9N3j/SuxCxkaU4B5081BfxzPhWfzCHc+io0psspvVRvJLVIFUxGSnOBnQo0/cVIs6fufC+WuDsKiOdB5DuOQF3Y6bZEbbb8eToUNhLknB8A3E9Efskb36v3KqL9eTd9VC37CZQATbd1vnhcT1K3MkJkkR/ZBzJNccir4Sb2Hv7O2cs3BedpSdY2rOZfgERo9pVMSKHlGlFppifK+a7OOaNHfcA6ff+tjzACAl/ilOrSG197nsSFaghCvQdj91BB2czHeVT6qDWJukAnnpB4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6BLZa1QtdIvgZOrIj+zfhKXHIGsSSeE5LjDIGIpm3I=;
 b=HEWUbAEqB1qmfTwbe1+PTTpvmYDBPJEVWKN2Tdb2K70Ab23qjIkg6J3LQzFyVUm6hLLxT6mZdMaL/okVSyXxJ4SwbNDHT1gyTj4r2BjwQuik2kC139tccoHMq1pdF81BSVsnZoLCVSg5ewdDkqmHWuMIg+MGL7hPWQmLeg3DD/a6Lp41nNyhXqvvsosvMOgItJ6WEr5cxteIA7LF5Bst7/AFeXhvcMm5m7vZmGXJClWccVbQfWriwlEpjfj28sDUKPgJGUsH7QXKi6qPuzdG9geHhAvkbSFc9APuGn4111v5p7iLzSSE/eq7+KspOYcuXWVlA0k/bUghEP6NU6JaVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB5873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 09:22:40 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:22:40 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 3/7] add recipe for trusted firmware a qemu arm64
Date: Wed, 19 Oct 2022 11:21:13 +0200
Message-ID: <20221019092117.5291-3-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019092117.5291-1-sven.schultschik@siemens.com>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0101CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::18) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: d0466877-36dc-4ac7-80b4-08dab1b37828
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HhjEsiNItdZjFBVYVMfFmypRU9RQnvAHHXJv6Js0T+93VhUOVGjZ4lIDX4319n8RPp6KWRLnEeSVJzJMUG8hKdacxKE/6ZPSm6q7FffnZQO41XGZseqEsBuOXLzrku+3IsEOxDM8Sh0YqKz/5k9carD5XH3x4WRFEzK8LaCpfEQJesbHIG2MRfL1H5P4GpwfjchJzZrcbBSF6qs06jDjyhX4NQniAfN732N0LhJD8UDS95+gNdH7h2me/gz73dm4CcDRYpXle9RYETmqes96+ZnB5PhmkGZo28O51CCuP5bE5GZ4G+IbtZzITQC9huMqnLp8Ji2emdVTjSLe78Z7HaALCYaHDIbg08rgLF5SYI1rlm/vh+huQWCxETd7rq+p3Z8Hr90fHbCxTcpuD5qeDdxl7FYVPRfpELejhWAfOicOEUCxxCL6jgnHZRtDxyWBaKb/QPfI/Vtl5AvKMQPLy8hmdlMk+GWTWBz7+Wx8VUi9BEuWO7ztbI56148LSc9Qgtm5U3ZysexxhUDLNQuy5FY+0IXezs4wnpBjv+fDtqTMM1y5H8sVd5O8RmzGJ6+N7wAeSVekpiYr/clNiO03Mevplddqnzv3W2Om22Vk94uflFj0bsQO7bbO4zlAIm7MheeeHb60WkS/vGd+PpULjD75PxcEr4c2o6S2AHQVSDgV+HzqsflvqRkFuBINBuVVKojx2q8KXiFDbCtMb6NLBJj8bdA3L8LTKHq7eE69lXM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(36756003)(86362001)(2906002)(82960400001)(5660300002)(38100700002)(2616005)(6486002)(186003)(1076003)(316002)(66946007)(66556008)(6512007)(66476007)(9686003)(6506007)(478600001)(8676002)(6916009)(26005)(4326008)(41300700001)(8936002)(107886003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mOI8d+YVqrX8j4i0UB2Sh8CQ/2gTEdEHdxOmk3Q8XUqLlXB3YWGUM7aM6i0y?=
 =?us-ascii?Q?ZDk/LBZPsTCoUaYBk/GWCBKDlRmZw0+YDjjH/opy48gAsnYC/2sSZa7bsPVk?=
 =?us-ascii?Q?b2GWHzS8/YQ9CLENlU1Tdz5LlLFqY77cgQGprnYEHrMthKAOpGErXscgVnmo?=
 =?us-ascii?Q?sWLmGmUhMAY9Y2H02yufmaBBDAC5tg1OkGeAMOh/ZRh7smmF2TR23LoNo210?=
 =?us-ascii?Q?NGrZtgSl/K+ywFrrV2EAZnjKdNjsqbkbmLmwiLcJ3P+/uwA2VAdGXazW8yPJ?=
 =?us-ascii?Q?pRBE5H4UCtfuhVkC+x5AMqHYsyM806dOCBffR0sMJpyPxpmTULFxerw0otsf?=
 =?us-ascii?Q?06qIEQVPMZf8MWKwYf4CHhsF0+nuih56+pabNl+EcxlPut5vis47oThb1SG/?=
 =?us-ascii?Q?2vtcyC6QRqY1Gtf5h6NcMmNvfDyY5dRftaWyTuNU7q3eE6SdTbMZoBqXxqsW?=
 =?us-ascii?Q?1EqfVaYPj1zIaZHfKiGxV7Q9eT5rlTm5nsyUPd5b5d6k1lDuz95+uSLtu0VY?=
 =?us-ascii?Q?H5kmoA4CzbFWKaRPJyOxHuHBVqAdBRFj9/g9OLKuRPyi+3WYntGrQmb6DlVF?=
 =?us-ascii?Q?e5SMnpps0mhYrIibgfnKf/REVl8+5xc559FehePEwOjyduApMOVwpb5QX8vg?=
 =?us-ascii?Q?+8m4Mix8fa3TeiV7l3HSHLpCwYkTiZ11Yw+Ly1R7vICuiI/JEkwFLHmhryQS?=
 =?us-ascii?Q?kMnc+JGgsJM6sI28n/+IA99FPQ77fKYYk6/ohawDu5DtaByCYZz9+x+7e09n?=
 =?us-ascii?Q?20xXwMIRMPxTupO4MUUTE8BN7ug/0KZTc1JeZbjOrf9KuWM/kmEJtk0KxZpf?=
 =?us-ascii?Q?g+dc9G2fNzDVuqCGiFKf7brxw/hcouPbDfBlskOmJhsO31SLpe+v2FzfEqq0?=
 =?us-ascii?Q?u+87HVMZtrWvSymCBdGCOcuXAH7DL30TR6uW7jzxAqVovhJrhpj3Kvb97ZSG?=
 =?us-ascii?Q?w7GXN2naOq3Y/UBI1FWvt7Gxi9aQpNKrsnnMhDTaK2IH/gHfNH5x6vmwT7xN?=
 =?us-ascii?Q?u3xaoqO+e22J+e4cTyuvKohlEhLCThq0WiBA1CSkFP0TE3iho9XbhdqlBcBi?=
 =?us-ascii?Q?dR/dbvVRIqQjwO9S6IQImDGnerQHr1kiJwIbr38uxKcQ0D4E8V3eYjyp3ieM?=
 =?us-ascii?Q?QRoT+InANjd+RzTKxSWhMEayYRgxNoJBainAbeWfQS56xnUYOHwSMkDK6eoJ?=
 =?us-ascii?Q?psMi/QOeJ9AGuP7IelggpAoHofgU8FAAuF9PYliauMDYgjoTk+Noj/nFkK55?=
 =?us-ascii?Q?g+uALcaKONMyCQ5GHwBuOKe0vjijlG2UwycvVOSn8RDfZ+KF+4GDGRwgpjd4?=
 =?us-ascii?Q?mPyNvd00yWfgZc6EsKXnjD1SJw5GPqO/QReGYYYVnedl6STeFMxPJ5+169Ok?=
 =?us-ascii?Q?Af2+Wf2OyTSzm6tAndNPgag8m0B6AlHqF1ML0DiMPAggN3lgTh0eUhNeSbg9?=
 =?us-ascii?Q?KBLKSb6FN/LFv5FXpG/lZbZ4NLNh50mGooUUQDG2mK47mLedc93KgTKICtYj?=
 =?us-ascii?Q?g6PpnfdRVtEGFtQnC3Qr5jUXsdaF46ywjoFEZemM6Oao82DAulNaGMZAJNEo?=
 =?us-ascii?Q?7QeZlUbGPF1p7ulNcMDtQg0jQSibl0yqkLwCWTUcs7rjwxCIGkzmf9nZyNaY?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0466877-36dc-4ac7-80b4-08dab1b37828
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:22:40.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj6U5Txolpg5unOoLVYGdhbMpgkbBkC5BAcd+YuGpangX/k277TeU1lV/C/u/2z+RX2owNXM0Zdm6pOJQprAqHTU29kOiAApAbqBldxXGXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 09:22:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9777

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


