Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D013FEA83A
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 09:23:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18493.1774430626481476095
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 02:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FJ3LfiWg;
 spf=pass (domain: siemens.com, ip: 52.101.65.64, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2TftMr4IZpXG7h3/CzEnDuyx9+xQ30AJe3IhF6sAdEs53/a0iUPdBVYR9Oc6u+cNWy8kOVWJ3k/JZz0rjHo6gBGa+qMR1cNr30vpSlT4NuRZUtigbXVnCnGcAKONkXQ/yljoVofYfSEBdS3TBipGpgrkc3/u0iazhAqCr+7JQO4OLe51zHldhrsdy8g+lqVupnhtRSy3dsl5lbwtgRaxtFoDZ1REcpDiAPlZtYTQGeGSe1blv5GGVN5IoPia+SayzmeYeyGeBh4w96wtvc5PXWhVlexzo2Lx0tkGV7gbvEN9qbSXROoHKm6rRxjjd4YpkSX2gF0C/y+hMV/ae2Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBOem84wWKGptaPbtdkKqojWx3h23C4mPo8TjVoR0eg=;
 b=eWDrrZYmChF8WsW8kraJn7VQMYmTURKRlL8tC3xfk9fdDS9Gu8dvMe8AYhQU+YBzR+nN25fRiTj5kAOBxQB7zkSxVbfPBctBkG2ryZd3iQKc1giuJ5Ek/i6nqiQJfD+0MhwnwfM7NWfjWyXq/8xSacX3AtQ6DmzVfmwpyVXhLEuOpD6XKQGyq8HIRc2warUhTChyM8DU75PixWSqx0Ky2ElS2RMFmxoRP8bOvd7rAzvr34gZpBtgapYVVnRKiCLhApmBPRNmxK2FVwlaYSZo5X8Fw6vUI16vfAKFnXrepKeElsWJ2bKJNp6rSP3Oy6vF2O4TUK6BkaFqsMNDwI7z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBOem84wWKGptaPbtdkKqojWx3h23C4mPo8TjVoR0eg=;
 b=FJ3LfiWg5pAh0c7mYSGR7Ta0SDl/J21Rdfo4jmuDecHPUeBZpCiBXPkur6sYYvKacBh3+da2B2ZlHJkpeikhoQuMsZTmgOZB8uJp2fSYrHpMhrk0LFXklF/MgKvdKYUE7YLzvlqSEkMhllveZA6OrnCOrRjAyqSZfolsdztpQ7CjvRjpo4o7Nl3lemofZ/91NV1MSTFwcA5wV/GMUD2KxVNugUYpKD/jlONt5y/Fp1apKeBDZW+QZWNuGW1TkOxrosgBwTz/8jzsCrSKnb08qHziDW82eYj2bM5jlZwsf4nBd3bfOmA9wqvLW3OGIuY9d48GudGWtI46rnABmwmu+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by DU0PR10MB6932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 09:23:42 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 09:23:42 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] chore: add efibootguard to imager bom on affected images
Date: Wed, 25 Mar 2026 10:23:33 +0100
Message-ID: <20260325092333.1651628-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
References: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6823:EE_|DU0PR10MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5dca99-35ff-44de-e768-08de8a50350f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|22082099003|56012099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FJJ9/8L8mAQaNvUK5ygQRvEXjiZZLZ+RqzP9yEp/QMnjBPcROKpd63s7ddohSBr6YjgxaHZ0uauBBCjBSnIAYSe+esl8iFDt81QRWGlDUd1UY0AW8vyuPiile4OnNMC/vb7IcEAZjVU7PIvWgf3dMqMXLl+a2JrBM33KuOJNczbVYgpzeyvvWp6Mmw9eKhLvjeXolVf/RPmV7MDovFInJfPGAfL47UbUt6fcBj0JURycklx3tZe5jW8GtWssby2hTjRLsb/OTPNO0AM9BKaiBnfUqKQ7PMwTakcDsyqa5LJaDszpIbVPUZfXItTvyKJAULoRUsdui8VwrFgLaZReWwVM2qSCPHzvZGtQ0IEHqWdPgIDRfu5Gv+cbxozfNhxVsRONeF5MNgPjZuz0HQvot45IRLTmAqI6JP12L3c29yNDJUANSjwerLf/n9UzSDszs/X+g6/X4GEsAh+rPoUaZeTHfN7v2OCwRb743vEHjbUJvZsAs5Dp0mUGIXyUYJZ2OLVskc7/dHKvlDZcNyJ1CTiw4uyeuN6Cd/9vAfEzgRnss+mWeVwC1MbLXbVcsOumoXK/YxlyGHUfMmv1O8kPOabnIHGm9EGvuzwDut8lncsCZKnYohFish0RkFZzO5aKf1dEoYoMTkXEPO8thZGluYGlxZdRsKv938hCfyJCpgKRvMNDBpXnDWFFztx1MliMwzUqhEKiySHbAOv8s8hV1ilhLWIc+OHj3tmUBaWxazw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(22082099003)(56012099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ojx5NehaOFALdWGMqjgUqa82joy9mToKTxuvC4LZWweDchh/JpY16oyey81q?=
 =?us-ascii?Q?MUJVu6M1s5w7Pi24CqK1Tb735iTvvwBp3mUGEYSUKCQvnYynPNxqGvifLoDW?=
 =?us-ascii?Q?hAVfVG2QGTvXZ3+WJS+IXKbXdyw8dyh2TVGBV6lIKQWIuXk+Am1xoRXN8NeL?=
 =?us-ascii?Q?KeqxuJVTCxSeKIrHFz2dZGzAYFFDE8BI0MKcca6Vb6pNlxV/Q50Fzw4WUN/c?=
 =?us-ascii?Q?89ZiHNIy3ohR/jdQphcN1af0ILiBpHGWvS4xgfvBgKkwY5oivZPY0EB5kr3F?=
 =?us-ascii?Q?INiCj0rRvvizDPwWNTzuAGWfVfu6TZjVbB6mGycRLJjj53NhKyDRmqsXIK+B?=
 =?us-ascii?Q?h7NB0ROdGwLZjqmmrKX4r+sle+jPO86RtJQam3GHPNhCBoIBdsODAfc6jhkj?=
 =?us-ascii?Q?2URepVH6KcGrJ8DJhihDD5tUPLRqnuEoTTn5LeaHs2aBOx6ugGXow7ggt+YT?=
 =?us-ascii?Q?vxqAmtY00YFumcqzD3cLPgc8cX5O5mX0UZ3y+KzoXxj0lUtS8Ly6Wyuxro1a?=
 =?us-ascii?Q?zxDfnQvD2qWlGO7LtHlIbMMBVLxVB+CzIdKcE8LHws6i+r+xPKTDYltwZZWy?=
 =?us-ascii?Q?InLJdeVq8wil98CkFVoeP/5Uakg1Nen0A2lAG3J5Hpk2GCMXyex9+kV3fQ6t?=
 =?us-ascii?Q?LGep0AyNtIa7gy85C3a5BN5ez+q5LIynAU+mtTVmYzu1mEM+2G/Kj8Fn/5GZ?=
 =?us-ascii?Q?9mCpl7wa4TugctkyuEqvqGcw+azUiME51QroUoxZdJ7v209Qw0dtTvLqmyV0?=
 =?us-ascii?Q?JSK3f0fcDBrfVT/EsO0nbjZt1ZJK1FNJmtbiWe+0cYmDYrjlIJVoK6cYxN3J?=
 =?us-ascii?Q?Vnj9ZldCkrx2e+MKDFmUrjiDM6OAqUgd/YXPHB+5unpZQ1CskSaWwp64g8ib?=
 =?us-ascii?Q?I19NJb5wgFj6SO+4sXLAVZWf5x48NTz2HefYQLqtCZBd8ot4B0+P3gB0jKGV?=
 =?us-ascii?Q?Rih8om5mudW+jmDOMMKFqIBdx9fxIeOE+BiMHcc84BSdEB9wS3CB8bufErw4?=
 =?us-ascii?Q?IbYBGXRkbl16ovNu7zPIYHhGiUwBkIxE6FyyruZIOpe3zZzOx3fj7HIAFb0c?=
 =?us-ascii?Q?oZbBeb6KMRoD1ePODZVIkTA5J0ft57gPAVY6UwqIbl1ilOoKbdWX/FO+lNbQ?=
 =?us-ascii?Q?OnwiNtGDA42mjqfyTb5UYTCIWOGL9N//q2vYW5NMh8c2T5Yr0yGneW+SMJl8?=
 =?us-ascii?Q?Nllxd8jiQ1nyGYpDYg1UYHZkE9gX6ogRS6wB1iFlr9L5DH8lLwl7YQgvjQ7d?=
 =?us-ascii?Q?CuH0b7fZElKRf1jOhWnu/UCUN1uckqdCZ7YBETUD3xkjfTBugrruiR+sA8wv?=
 =?us-ascii?Q?jwEK/7L/iUEr5mLoyc52c+/S+eUKBRwKBJp2EMdnvtrdV9mMZ/aFQ533qE8g?=
 =?us-ascii?Q?HNPSR4G4j43BVfZ0xeQefkTBqlmsuGvR3Q4EPevLT0exNLQyTi4MqEcCQ5AG?=
 =?us-ascii?Q?J2duGBt2V+iQdsrAKxpLVcgtPFUhYCBYxwLqjeVlcX1QzxMyILr4R6Qog+ch?=
 =?us-ascii?Q?Qkdmx2NO/b24IAgfPCGSIlzEQ4hZHpopw7ZGPpXpfQeLW9dfXA7TxDSvNVTc?=
 =?us-ascii?Q?oRqynFxOKbxQaWEhIzGCxROhhfCQQ5/Lrlq3NJeY/DjPGkga1AHz9lkGyHhl?=
 =?us-ascii?Q?Uc/rPgel1/UzDXGDQCcYxZdFKU67gc+jnaXOYwoYLnxnZO5YX9iskEPbgVtq?=
 =?us-ascii?Q?Fdu2IPZZWYzTRuc3/OGFoBo3/vr3gTC0yY8+Dk8oxUmvmfOGvlonTeA325S5?=
 =?us-ascii?Q?u9/NAC471ICit0GhYxb2iHBNsZ1tVplkBWaZVWNHWtbef+Acd4KhH1YZ+lg9?=
X-MS-Exchange-AntiSpam-MessageData-1: giWmS5fKZZhnE1AzRIUPDj33zhxEzCIlhHM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5dca99-35ff-44de-e768-08de8a50350f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:23:42.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVNWdF6URVKRoqVpvUqiyksC0zdoeuWKdT/GOhuw8f/4PXYYCyvpKhlp0pZPia/ay3ZfsG5vrL/SMaLFNEJGZ9gFrCLL0qKWBEI5ETqLQV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 09:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22562

Efibootguard is installed during imaging and then parts of it are copied
to the boot partition (e.g. the efi loader). We now reflect that by
adding it to the imager bom, which also is added to the SBOM.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-core/images/swupdate-efibootguard.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/i=
mages/swupdate-efibootguard.inc
index a332dbe..2a7afe9 100644
--- a/recipes-core/images/swupdate-efibootguard.inc
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -11,6 +11,7 @@
=20
 IMAGE_INSTALL:append =3D " efibootguard-tools libebgenv0"
 IMAGER_INSTALL:wic:append =3D " efibootguard:${DISTRO_ARCH} efibootguard-t=
ools:${DISTRO_ARCH}"
+IMAGER_BOM:wic:append =3D " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?=3D "60"
 WICVARS +=3D "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_A=
RCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append =3D " wic"
--=20
2.53.0


