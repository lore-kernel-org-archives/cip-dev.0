Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6C6CA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:19:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Gm2Kwtej;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtevWZ6CQic5LafRcTgtxE+8luoXnr4PHbkMjbYU1tMOESSHwXuC7Hj+v5CwZ7b2s2d7F7IC3CHZY7RAN9eRBrsRHe7VqbRVVwOIY33p14hcYwbxx1NhvYcWk8emVyf/6Vvyi+dpYt9z3WDPdC6iLo1zURvW4KhTHLxAD6nTS0aJ7mB9c+cDNU5XKEVwIIG6jQz11WAm61PX00g14TteqJCbNv+UrtDAPAYwipz8qrKtVwVjjR6zMrc8j3T+BmP4DGXUX2aCGgl3gg217Umqum5HORRvS+zPbAkriD83rb/x4NdLgcgvcH6xKqIwxvW/mbzAWVm2QVHnc/TA3r5WPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcJs1MCurGOZ95HyfVs6PXPUzelhMfDOuAQFQOdjfdA=;
 b=UvkPSK2EymheeQCvDiaG8sCLkNeBtrFxnBP/vrMZ8UVAK+I14Qetao8Tpg4HIqWpoGBrPYIaJgPZmJ60XJLRl5EPNOfEuRksImrHQohuvh/h1KhArYwDNqo5bfrUoB2Jj7BP0IB4Y15sc6gcJDblWE6kpJisU7LjXaA+4xZW/TmnoUdaI+otcwaIMolVQnvFzW3iI6QuFhjHTuDV+cn/a3JoaxP3L1wkt0KOqFqHwHd0LEVW0j1U1qeDdjrwBKDAO+uotQuxK4TrXUDQaN1DrhIj8Fhl1NWSCkGoIsu2b3Nq6f3KG2lI9gBCGJSyATRdsG1tV9SRXqCtFqmFT7Y3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcJs1MCurGOZ95HyfVs6PXPUzelhMfDOuAQFQOdjfdA=;
 b=Gm2Kwtej8LMH8wtyMSQlzRomuI3diHJU4xDwTsWvjMqHzAKg15f1sM76+a9pwRtf6E7PlHq2JCmConRxCpOUsiZJeY3IP4fC3oP+K+3yr2JAuucIXiUNlI77ruUaxqx/2xRpIndruwj4VcWjGQ6A7+Tvd4ZyJWRaI5sp4DTlXrNpT8Lv9c43EA2qRQMAZZgKeqpqaAXLCVQwXmhuHsdyaWQ4G6mLF5+xXv2mQDU/kdAMyHMjwnRhFLtkisCO/WCyd7AU7rXNyRrID/zEt53BLSVG8UHYKaBXEhvJ7m/nqYObmmeUPnLh4+cQ2tR0SUHjGWXc6qYjl5I0iKuKS1hmGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:48 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 02/11] swupdate: add RO_ROOTFS_VERITY to select a dm-verity rootfs
Date: Fri,  2 Oct 2026 13:18:49 +0200
Message-ID: <20261002111938.3600786-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 56514139-f7b1-4904-9812-08df20771122
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	1us0F7033RrWDp3eRknNHToy/Modd9D6g58mtVcDPwi4OY2lxEcoR2soKQCzuwsNhjPf6YayEIAu/Bas6v3q6lyx6IoGUF0q7xPem8Ia55Ds1Yp0ZyFMen89idTyQ/loSfFh9YdX+ftqV2M4W352dOzdGPEj2Qzqfpog57oGmw9+RkX38Vr6H8rbivPQHGEFiQu1Vy5KCf0UnHiV2xDO0KyoIeZfwUzkgMWNlTnUUgxxiP6P9H/7XPTjQkfTRp+z239lcJezC6beDrOtODuWPwsRVNrkVer4hmRkDkDX+U+rg/sCI7ILkKvob/AYST0LjeN+CR+E45ouMFYItWyAI3qLNMvEMIjuKdLNeWOmrLPQnHCzgHsm8oZthmW6MSTr67+Q4L+3RIC7JWvX+rqRwb39M6JEtN29OYn/hVQ7zDz9J53Tqf2pG1rz/04Zped60yw4mutEFfngYlURJRkJWBwcuhFaAWKRg00BfZW9tdQC5pbtasl00LCM/6ydVcnyudE1miQcv5eJ21QVnPyb8izlpXA4Y1it4R+pz76niOIbqw4gUHeyPkzxGdoMzvTc0RV0ekJn3Qlz7fDpqWkfPiOXmfpjshiRadG5KefB8xnTcTZIeqvGRO8LH7H9umKeFXeyFTnwx/t/tvi8IikedFD/PjsexOaRl4htbjGw1mQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2QZvnZycn0cUUCtY3s4OdJ39EAmbCgZ9M+tOCBb5KJFk/ls6huUKhtgnM8ZQ?=
 =?us-ascii?Q?iQPiI0kSrY398+M9+TTZePHWR1Az4+otaDzBRjxVh9YYsSEF8mDjYUqwEZdz?=
 =?us-ascii?Q?2QPpte2G4shKQjD5FAX+cFwuuInvKxgBJRvSrvEjyJ3fnOknOUKVB6fqQYM/?=
 =?us-ascii?Q?67uJf6u71j0XJNCeqd77llKrP5/GXACXazPqHTTFmEEogIZKr8BwkiR5uEDH?=
 =?us-ascii?Q?wwWDn2+fYg8NotojTxGsG1lnpiDf/WANY/kiZNGZl3F9WY5GQBMdOIf9EJcK?=
 =?us-ascii?Q?VKTvGxOVutTqGTAQuq54TzMv5Y6RhPDJqMrvK/4K2dnkkDiBZUgYEi39gncC?=
 =?us-ascii?Q?ixhFFtlS4PCF7oV/nKpAc0EToLb9PmwywB1yabqW93DzXDkDRT/VV/EFgGdQ?=
 =?us-ascii?Q?zJNHt26KQf2ASbZUB3Ji6Psw66ZBmV6BUPEQ3RFVEGjGwgtCq2KGKdX1b1fD?=
 =?us-ascii?Q?sBjnWJFeDmQBnDGvLDVjzCtj/6qsi2MZHU1ehrj6+9tW2VzU6FuPDVvtI6UE?=
 =?us-ascii?Q?C+XBPKjdmSEIISZ36YFzu3B37TRQQpeEfyEi208rZha5HM3JqIA0Ef1zI3yj?=
 =?us-ascii?Q?RuHy6KhLOyWBA5XjDEoNRVS+Z0LvcpSBVeSsLrQmzbhzdYOTJIvxDwlCjklX?=
 =?us-ascii?Q?0Z+KFnKRj0uUrkGgwfd76MX/sSn4+RlNt2QGNIG/nnfO1TVk4PXoL4hz5Xgh?=
 =?us-ascii?Q?GjWlY1+5bDtgjNgXl1NFM4PbimKr6DCEeQsrd5tZQmnxKiupmzBcpzkpQbx8?=
 =?us-ascii?Q?gZvdYa7KSPP02s0Jpat8hqVHDGDTEQLdKo3jK1TRx6URDfS/BsXKctpQSwmt?=
 =?us-ascii?Q?DVBnDHwDbxQWegq2e7FkrAWc4g5z/0LJ/RdKOdtwAl7Gh2rZS1OfqjBCdGuP?=
 =?us-ascii?Q?gf9EcSzm3HS08KUZti5UT31y3u2ov2NTrn9vcJeYtJOIIkQpwsXEbQp3KOsL?=
 =?us-ascii?Q?3q90hj84GH2F03bheKi3ItE0rqnkyKHxSmDvNG4+GzgVQtoqpbcYAj1qpm+A?=
 =?us-ascii?Q?Vph1zjJgsfl/NH7BoUc1q/tQLL2piaBDfewiWH+nFQQPvPPZFcBc53m7KQ/Y?=
 =?us-ascii?Q?uFphgDLjhgVvEIl/uOSy29fd9N3TA4D9rpLyOYxRMdRddHGZysqJ3+oXdXTc?=
 =?us-ascii?Q?lsSu9bU1G3BpoOUSnQ3bKUQzYiX6llfd53p2Fzh/mMgWvwPbmCRE+rmYSaj8?=
 =?us-ascii?Q?S3oz+kNHve11AiOnCN9vMQ8F91p1PUF08wsQDuwmp0KhNpHbzz8q3bhiyni4?=
 =?us-ascii?Q?kktZh3PS4E2/4i5QgAY3FCR6BHgPY2oKR7PdBWqAiXglkOoIE5FXfIKRn3KH?=
 =?us-ascii?Q?O1Hb0o9Rd/vlG+vWXCDZVWybZii5s40Cz+3UG4o2Vcg6YXO3aEKkTe+vOv5B?=
 =?us-ascii?Q?8RF8OhQgCz20tFi/94AnsWYqktJWumkHuxlqB7mi+gL4Lq3qmto+zKOMtT0B?=
 =?us-ascii?Q?v4VwNi/7+rMxCkVHpons3JvenCu5FKpCm6eyHr/4gs6yBJeSm98FIaA8o7er?=
 =?us-ascii?Q?G7frgrYzeBtde0+oRk5T3CtMBvThG4DFg7MHni1ZP1XPULiVuOH1DvWFXZVT?=
 =?us-ascii?Q?ZtNZnBx5aEnCnJKYgQdxMA/6/9WyEnvC1j08MaLh7UErMTUK0gFKxpZ4Z73a?=
 =?us-ascii?Q?NMaFj6EVpI3Iza2/WLWEieaEt/280KayP3R+BnsUvZpIXZyDnCst41OFIFtO?=
 =?us-ascii?Q?IP1KBikjgjaVn6kKR0Bpi6Tqq/TxwZFDrQzHoPxRy5+d//Rr1Ny7nPtzWCVK?=
 =?us-ascii?Q?PVWAZVdgqwef6t/SR3MLmerpAqTdlh4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56514139-f7b1-4904-9812-08df20771122
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:47.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BsE96fLFcI0KNYQVRaXa09YSbN+grdoaITt+K962tlN5pEK2LrPN1RCjbk7L9uwDlc5JWB21CAF+NZJZcofgpBXVMdOcwv19RPYTGLmRMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:19:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24405

RO_ROOTFS_VERITY replaces setting IMAGE_TYPEDEP and SWU_ROOTFS_TYPE in
the kas option files. If set, the wic image depends on the verity image
and SWU_ROOTFS_TYPE defaults to verity.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 3 +++
 classes-recipe/swupdate.bbclass         | 3 ++-
 doc/README.secureboot.md                | 3 +--
 kas/opt/ebg-secure-boot-snakeoil.yml    | 3 +--
 recipes-core/images/swupdate.inc        | 1 +
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 1690ecb2..70152de2 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -9,6 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
=20
+# Protect the read-only rootfs with dm-verity.
+RO_ROOTFS_VERITY ??=3D "0"
+
 INITRAMFS_RECIPE ?=3D "cip-core-initramfs"
 IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbcl=
ass
index b5b5273b..ba0ddd7d 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -11,7 +11,8 @@
 # SPDX-License-Identifier: MIT
=20
 RO_ROOTFS_TYPE ??=3D "squashfs"
-SWU_ROOTFS_TYPE ?=3D "${RO_ROOTFS_TYPE}"
+RO_ROOTFS_VERITY ??=3D "0"
+SWU_ROOTFS_TYPE ?=3D "${@'verity' if bb.utils.to_boolean(d.getVar('RO_ROOT=
FS_VERITY')) else d.getVar('RO_ROOTFS_TYPE')}"
 SWU_ROOTFS_NAME ?=3D "${IMAGE_FULLNAME}"
 SWU_KERNEL_NAME ?=3D "linux.efi"
 # compression type as defined by swupdate (zlib or zstd). Set to empty str=
ing to disable compression
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2a387f07..0f8ef04b 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -158,8 +158,7 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    RO_ROOTFS_VERITY =3D "1"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index a5814666..b03980d2 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -17,8 +17,7 @@ header:
 local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES =3D "wic"
-    IMAGE_TYPEDEP:wic +=3D "verity"
-    SWU_ROOTFS_TYPE =3D "verity"
+    RO_ROOTFS_VERITY =3D "1"
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
=20
   secure-boot: |
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdat=
e.inc
index 006d6220..361dd5e0 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -22,6 +22,7 @@ python __anonymous() {
 include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
=20
 IMAGE_TYPEDEP:wic +=3D "${RO_ROOTFS_TYPE}"
+IMAGE_TYPEDEP:wic +=3D "${@'verity' if bb.utils.to_boolean(d.getVar('RO_RO=
OTFS_VERITY')) else ''}"
 IMAGE_FSTYPES:append =3D " swu"
 # input is already compressed
 SWU_COMPRESSION_TYPE =3D ""
--=20
2.55.0


