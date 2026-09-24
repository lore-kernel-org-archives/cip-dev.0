Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDCBC98320
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:52 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2959.1790237567856386127
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Wg93/1CP;
 spf=pass (domain: siemens.com, ip: 52.101.66.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgyNuifBENUAub7J+bX0l5AIYpr/NTZ4Z/VJS4METUSdalP2utpfxA6j+Ls3Mho2gWYVCEuRwLV6eD//vk3ENbX28aj0OhiKxMBds2qEqqpzyUZtu8C5NUKfQR1rUOSWHuV2wctn4SrvL2DAlQpAg5Ll/IIMAtiHlf/yUrFjQ7Hg4XdzN3WnCbUyF0blPN1b1p7ROiPJATosu+9fkFp4Yaq7gkqVRMj8HBuF5yhgrxRgxt5n4biK7hjscy31WXPVLLSJmlr6e8dfsdllfxHFVnMVDJtGsOpOt/wv8jYy/Nk4FaCZcW/mFFNspbgrVKqFGI1v8Z00aXVPPmSqqjVy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=LTJTupFOjl6WEKPZRsa7208H5ejiVhjUFOc3X7IkOALo/xmt4mlnVEuKn2tfIR4/sWoN0z+v5IGLj4u/EU2wyW8Vdc3B9Q/Jvxu9MDskv26Gpb6FJ+bxEUENBHSxw04PvYDcr5teS5U0qIRxQync8JdwPcahcs1zD+Ztowu/Ycw/u5s833sggv9yz+akee6u+CkoxF7XmhRDBli7irk4QEa77hkEtKc/4uYbuZjbppv8amwGyWZnyEcr0XVRjhrfoqq26mRStsJ50Rk0d/macRJ6mg3BIDfQR2+iGHerAS2+A3iMnvHjkclfvrr4OTN/o/aWjZ2ylCPCNT16KaSZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=Wg93/1CPXqFkQSEk1rvL5+ktzamdPGmlXHBMPjR2Gm4uwXCoDWdqPLR8kaSguYivmOH0SlXNHXOEi5NUdcHz0LUJMBpjYCdbQe8VUfPBWnIAOUY++pyxOuA/WAcOaQOwevD80ErhKrsD0E2koTacY+PVW8Im8G864dlgVo1SnBGjuuBQJhaV5izNOSHllPuy6c5xPOit7blvBuz4LXVAk/nGdKeo4RLmWdaUc22SSlby+rMBIj/AU7cDvTA5DjR/pVKTwSitW3U4HJG+XFQfB4jtDTIUif4Xa3N6VS9MgSdIatbBHuqQHvrr5d5de0RxYl51bmL4WEM+sG3GjQty/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:41 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:41 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 08/14] Apply hardening configuration to the kernel
Date: Thu, 24 Sep 2026 10:12:17 +0200
Message-ID: <20260924081226.2844456-9-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dcce0e-dbc9-4c60-1088-08df1a139a1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xg4vD5SG8hP9U8M4MZCBGNcSeUVC2xApuglmAo9KQZPSlQcnttH4WfKMZJkOaAfkI5nwfZoHUtwzboTSe71TwtGr/MD4sPhuvMKrmSCFvBtt7b/Ip9vDYwL/DDKC5w3MYiulkv4Is+xwqimFA1UrvHwVySS5ZK1s6Q9l2n+/BybbpG9cT+NNOJwnwxyFYTouYCxjNYkWvw+/JsFj5Kq1nrJJEL17J3w+fqgeUrMHJUuE/WbdxfItpV0l1BZ1KxKywPMCaCFxm8ThWe5eYNPscsRotbc0PJLbxt7Mc+xvJvBcLk05LEw5ZN/XGwYW63k66o7YNavdwTrDQ+n43q7gYEvjBj8GonOs3R+wBj3dMlXr4dRYi9UlDUsn1oZh2EtyZ57mjqx4hCoJWzu9dSaZOABYns1x6DVnYUJAZO+MpjvmwVis0wJd2wOGPKFbmWr5JvPl8NY5/n4tCaWoCswwIcAElSDJqn27FDymuiI1QfItWn5ABtAvEZweGJ6Jhu9E+f9ZRzcBD5ZlXenOK0+Dm7AGQvK9in7IId/dgsBzaNo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J/N31hF7EeLz8CBoFTqHJbOj/N/gUxWSQOE7E3ypZICCwJNHye3IxRJgQ+j4?=
 =?us-ascii?Q?G4ktcGCiXNt484+f69H7uHmdaw56RGONS0aFD9W3PXBtRB7S7HvlHTDyI03B?=
 =?us-ascii?Q?UKT+nkfa+a24TWSuFy1h569KqH59M9HrzIfCZB9YXV7IvM6OzUwH8h0xqc9x?=
 =?us-ascii?Q?bgTZMqpwiNEy3TPQFKtgOIfTWN15VgAqPVNY2a/obGofQJzj7Yu7TrYv5J9n?=
 =?us-ascii?Q?dZFfT/9vSaaX961n9x20hMJugK3wFqN358+jM/urFug/7DBRTWZLqryeahGi?=
 =?us-ascii?Q?mBdryC7QMu1ogE53cypKCdAff7/bVOcBPvm3Y07wp8i6SNhjTO37YsnZDbQT?=
 =?us-ascii?Q?yQz1rZ5jCSn/20WY/8r/wKLrDiACE6Q1KalYjPHL9BjXmEDtVFYmw1JU/ceG?=
 =?us-ascii?Q?g8gdrsvv7LhD8MKyTN+ogP2DIUXHaEp59x67Ue1WZaVyW38TkjBTPA4J5GSD?=
 =?us-ascii?Q?LuyRuc++3qoTXMITRI/QP1uIiiQmHdwj/pfs4lc/OIKUV6Ov2aeABir59ym4?=
 =?us-ascii?Q?MtVlOL07bwSLfHPPz7mItp/KwYdYk77Dt8HQxbGy5gC1rTNUQfnY3RyYQGDP?=
 =?us-ascii?Q?w/+LKqXk5Ro3abnTQzZX9mySAxgDh6qE9ULWBCrsUXqsA6mlcWIM9LumaZEP?=
 =?us-ascii?Q?2TviAyzwiCFPTZoTLDwEHgQB7CvDiTTRMQXYSwLtb+49wpmcL8A6o8MnFIrH?=
 =?us-ascii?Q?6CwxL8h+7ueJXkMMyF5aLZEk4hc0idbyzBpQnj0XeknbpJ4E8LW41wizIUyR?=
 =?us-ascii?Q?ZKlHoJV+GXKm1ttuQasuWfxA/M5HxD3gldHhqqLWVGHKsYox+OzWGJ7vj6Sf?=
 =?us-ascii?Q?f5SjRGvCGpsIpcgpLdJ3D01efd3l2+l8sxrrS06t0Ihxcsq/GjA5fVxnZoYY?=
 =?us-ascii?Q?r1LRRqQ0+wxtoIm2GkIrgb7EYX7bHrbPKAOpKGohUTCYmz+/xHmz0RuLEmZx?=
 =?us-ascii?Q?kFFH6FnsHIQHOB8YFDt13MiKHkmZxyjvYgvxF4c1mY8rwrtyE2mQLwLMdt2Q?=
 =?us-ascii?Q?dOhSvj8emjG7QYAmJnMv3adHDlcZvDwEzKUYOynw0m/KrE+iQ6pwMYBrFbas?=
 =?us-ascii?Q?ZOc755ekFo56iRoYGXujb3/cnHb//F0q4xRKbz0aw31k2fJgyaMVUbk44wac?=
 =?us-ascii?Q?5Sk7e26jkiQc74geq6SEjydhgyfsnzTTloLVJLJDksA++c1PhfUGhKoGconU?=
 =?us-ascii?Q?lL0QuxCYz0xNbSdwZmuLoVHL3QEa8ZNxn2SIi59riEtELauFN3ZoVSjQ6IIT?=
 =?us-ascii?Q?RFU/v6Ni7mEcGGBN2HDCZ1+PCAvjH6DQJWzuIkqzZleTaOzSC+L56C0uGM9W?=
 =?us-ascii?Q?2hJy6OeJAFohFxIBHvmMnljrM4VkrPayLBSkYpK3BNrMWc7/4dG8/ql92IHr?=
 =?us-ascii?Q?Ws9z7eKg80RQFlCH1yWu4FE54OPaVHoi0nOgmnmB/9vvWplUeKl5sseOdpA5?=
 =?us-ascii?Q?HgPnQJiBfZb05rx90EeeZ5tifkkwXXdMEi6IRNVaM3+QpO8N4ybDRqEwyf2T?=
 =?us-ascii?Q?EKTheM9W8Qfyg12xTkUXMZHTJU+kyik3LTgs0BTSCHVvKJiC20KPtIQkoHYa?=
 =?us-ascii?Q?LzMa57YpkzK/bEsKDLE8VMZmkJSzHJSOWO47dEjUvuwXJzlwt/uqQH5C1LGU?=
 =?us-ascii?Q?GfPjAtC62ipWSCUHTW66y5EyONR22bI5mCwmzBBBk9ZU96uFy11FZYhqnrfW?=
 =?us-ascii?Q?py3z9JdIyWBAH4L7ghnVxJ0QdGUiMJCjNqNOu+9uixVs0Wu6ZDt2S6O8FuHh?=
 =?us-ascii?Q?R8B0wA+5JjjtPJOE85sRBN72Wmrmtag=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dcce0e-dbc9-4c60-1088-08df1a139a1e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:40.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mQR/UW1KiOaS8szf11jFrKeXbDS9kVCjC6Go7uwQEfwf6nq8oqSpGtsNfyQuo2w7etRBBa09Bl9tcvJvelqzWujeZPTH4h3+EhQlRrzyZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24298

Use the provided kernel hardening configuration options in the kernel
build.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
new file mode 100644
index 00000000..9ad8f080
--- /dev/null
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+OVERRIDES:append =3D "${@':kernel-hardening' if bb.utils.to_boolean(d.getV=
ar('CIP_CIS_HARDENING')) else ''}"
+
+KERNEL_CONFIG_FRAGMENTS:append:kernel-hardening =3D " hardening.kernel.cfg=
"
+
+do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do_deploy_hardening=
' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+do_dpkg_source:prepend:kernel-hardening() {
+    cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
+}
--=20
2.55.0


