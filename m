Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55DC41513
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:12:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web11.3144.1720771916444724822
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:11:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MSuubvOY;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGyd36AdazlRd33673OKfd1y5x/Zrn5QPzaT5bQwLISxbH9rPcZJsfDFPtqO1pxieRwlkC/Q2QmA2zPRdK3LAamCqL8rr/izo1SsWof5CR5+PR5nHG70DgWIr3IWMDWByrrZvPkQ4pxObVbMdQ7FoLjWKzddpxyX1sKS9fiQXGN8E3pPr3QsqUDeXvlfY3cQmvSVsVvASV4yfwK0vzWnKlGttuzTucael1bxCjm2q4qkrMTV6cLshrvd75iPlGi/Q0pn8dGe9kAa2P+PbrJsZ+IPg2+T+RBJDuc8Mg6UY0ZkPb/TdttFEPhgRg4ZTgOUjMkBfApoy+gvBD9jPknM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6Olq5WmYhCV+JPRggHGElGTMrH37yZQVKTAZBi2My0=;
 b=JGSxGhH7CL1Q+3Kp8EBDgjJwY6sDmAjc8kO+0RhMlv5MGViVjPZiVQegJiH/l7F5vdIwEDit0DZavBkfH6LrtWPTYcBcT1cRzCxSB6R2jE6b4Oxdb2PtViYvYvh2JE8aA2HOaoIKxBBoDGAIwO5cZwQQck/u2Oc7YagP+C+rSXwhmfhfFdNYM0RBBvGecglLXhVdh9xyMi2ZFu/lZlu/CE1o5g4PZFfdDbZDwBklSLBS+e1wlqfKFSWQDe9KoCf/4LedlGJ/3DJkGYGAzCLEBbrPvpGF/NTa2A3bk1tm/eYPfNofBcCXJQYSMqeMsuJFf+D9rYi/UbLGy1FVa+Nd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Olq5WmYhCV+JPRggHGElGTMrH37yZQVKTAZBi2My0=;
 b=MSuubvOYuDS7gSk3Ofvys7Q1/yNH7Q2I9TUwyoA2PM6gZcH0VhkCw0wo48eLMD2riTfbnekUBuKb8GxDfaY48WyoCQgqtsvzRvHue+diF+a+RDx4JPwJD1gaMg0wuGN8ZkV4r407q5S3Qqe67uPAvxzMyT2Yo+1cgTVf/tovDNM5jY6vn+ROp3jzwhV4HexyBIcsQ8kxGSVwC3ic4d0tbT5v09jRUD8mCcdNA7vyDyXmnW8QmXFGDzQwzhcBj+CrOTxNzRI3gsQcqe4sUya+Aysu2FKx87rUMhlkLEreKHPpA/NYcvWLlpuPF3L/3Le8DxCvFCQCLU2Zg0jzOaTfTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GVXPR10MB8316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 08:11:53 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:11:53 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH 2/4] initramfs-crypt-hook: Provide full losetup executable
Date: Fri, 12 Jul 2024 10:11:41 +0200
Message-ID: <20240712081143.1376952-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712081143.1376952-1-stefan-koch@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GVXPR10MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b4c631-f4b1-4b68-ccb8-08dca24a4a30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rryN3Qk4Cknkb6coW0XAm4gOa7Sfm7FdqL3qaUDXqKRliiYTGElGPtUCPzKN?=
 =?us-ascii?Q?dT6lFCEyVHy5xDYNSm0XD7g4AQ8U/K9/j+ZX0D3BwLFOLJQ0GXkePa5dJoSy?=
 =?us-ascii?Q?wKj4HPwH93k8E0fnpP4lsu1xu7ChOOnsbnKODkpm5LUGGK7P1t21QJt9HUww?=
 =?us-ascii?Q?Ne1CA1DKmUYuyO1uxcpxCvxAZtyAT3T/xcQZDx7+OcO0CXgVgJZE/tnQ9rhS?=
 =?us-ascii?Q?+cgjWlIVuqXjo11hrIsIPuPdKfCJbuiw9Fk2BFaJggiAZ+3l4MC0N8Ut/gxh?=
 =?us-ascii?Q?lAAiHSYLsyVvefLkPbAspEvPmoveBH5mtG28gIi2m5VG6HOi/84HomE1sohc?=
 =?us-ascii?Q?jyM05NVJO8nRvuI4up0x5KeTzp6/oO19YY8McUE1rwMsyEAe+ZMhDmIQp0JR?=
 =?us-ascii?Q?o8AqCLG4Mym7CZnY9Se4I4e6I3sxcNQ1OG6rAHohddehwlX9J622CE4IFX2v?=
 =?us-ascii?Q?oySPnGdQToxlEInrjTXfgIQ3vttyShwhD4W9DqFxjFWM8E2qSAGlgEJWH3by?=
 =?us-ascii?Q?T/K67wV7rQ+K4SMWIk39WOm72lROvrwQi+Ft0fbL8c6+4Ly5/Y/I9E5YbNWJ?=
 =?us-ascii?Q?hzh9S0uTYAqP+GN7552SAC8TjKWeJ5OPLPQgiSRIv0s0rpLcpqxJtCxAxKbx?=
 =?us-ascii?Q?1Ck6c7h26RVjaTkb3/ra8bWsZvguT7nSyIPJKC5sHMEoGZPaAaNlfyRykfnB?=
 =?us-ascii?Q?wdQOxwYTRqOJ845mkxRQ6RnstnQzMclxMbRs3KLyNEKMqagdWdFgVkLW5KjP?=
 =?us-ascii?Q?wybkJmUIsYLMuCGbvkTDap1BtC26KSV6kkKVCkiwdyR4Xm4hGcQJ9LArQs9I?=
 =?us-ascii?Q?Oyl01EcgH0RxfjP2tDxbt0vGPbhJ0Bj7OKsz7NwD5dKSZlT9dEz9SYquzRAU?=
 =?us-ascii?Q?qSoAWGBCJPPhXxW4rQoaTp7A58bpODAQhlIcEmLLYB3BBgj6ys0I6zFDXMXB?=
 =?us-ascii?Q?gCT6MCpH3hEXiYB4BonHU41VQ6GRAg/7MW1GaxjR/7FQTgEWHJsOjlobb6YR?=
 =?us-ascii?Q?4OnuHXz53b+9bEPrxr2iOeFibLL5/2mGFggfh/IxQHN73+t6RkrSCkvp7dD5?=
 =?us-ascii?Q?TjUItLf27xevAyO8Wg0w/QiOGwgCXEekrb4OIfFXqKuRtSN/1QwXABMQdqfb?=
 =?us-ascii?Q?FdpB/mlaWrMZ+2IQEytyjQmeNKvlpTDid71YoC9wwW1cHPhSqHjXrsTzpB2u?=
 =?us-ascii?Q?TAL9qIzsqqn2gPGh2n5BA3slJReaFAiBpJGPld9wZyqwB2i99dnJW8uWwSWc?=
 =?us-ascii?Q?Rau2QRht+/5V+5qfF4o5k3zCmZ/KAn/R0zutTK46tWDtfu3MwoNVD3l0xP78?=
 =?us-ascii?Q?Y4DBwlMUhut2QUbfyGcGZC+wMqAjd0N4Sqitakxdtv+j7Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QGaf+ec7+r5lIdI/FXfdBhbvXr2kNFQUFlOc8fnXmPl4MznM1bU3IxCDC8+w?=
 =?us-ascii?Q?Qc25W943Znd44qk2e2qCVpqkjrkVKc8cgxeOS1P/ePGgxsHuoOqVQ4QHzNk/?=
 =?us-ascii?Q?LlhzZ5s551Bcz/khl+5z2GA3bojdQFDKsI9Hu6Tt+Gm9Wivgp+Zxxu/HAKsh?=
 =?us-ascii?Q?fkuONvcCrTg/0a0OoIW4o+N+qkw20yG3YE/WnCfCfRwU5eUtscirj2cGECIs?=
 =?us-ascii?Q?dJS3K7HgZ0qgqmskoW3hwPPEfgGiKDkMSir436xa9zuqkoVpI2RufVkmmVug?=
 =?us-ascii?Q?EGXg1ZzYuiyTSk0ETcEvDsdo1N4n+nKLStBPuiIXeS9XWLLS04XaItG6GRik?=
 =?us-ascii?Q?WMi72/d72hNB4ApaddrfPR0BlcSHeUqgJd6VF17QmIu+qhbjaRjH0uin9xE4?=
 =?us-ascii?Q?3T82PtqzCR3i98CB8iJTMwGvuutAfthsGtLoU48R3kVddI04d7VJh12k2y4b?=
 =?us-ascii?Q?3cNBG5GaWvW8SRM1zc0uQxvK3xjZPEKgAw6M+7CXfrYNwP8T4lH3QjT/0spt?=
 =?us-ascii?Q?UIsh9NDZC2pmHIfIO1xTmMxa3u3TGAI5RCMhXJuRgdDG1EnIG97THcbaSlKJ?=
 =?us-ascii?Q?pgB3xCz/5mW2WhQFcXMOGFSwQP0uykbs7ISuKgXImG/ek906W1utvKuG3S55?=
 =?us-ascii?Q?r2fO6vflrVxRQMnocCSQoRKL7JVSEGyDoTam2X5Jo7kD3eT9ejtNIYPARMNX?=
 =?us-ascii?Q?r/BIJuNbVGfPC3/54fqrq/terade2+BHNTY2vKVlPq1lMG4HeqoxmeH3/oZj?=
 =?us-ascii?Q?FZhix0zqx2HEqPscJ94+nEYH7sS0YuEB6FOcN7Es/ZSvGfQ8wd8Ttt9xWCu3?=
 =?us-ascii?Q?X19yODQyyQvha6hNFjKopMPbv1SMom9VHgqKNKe3DRE/otTCxZgXjmnzB4f8?=
 =?us-ascii?Q?cA6tlml51RS858kbCHcXFD0HLKsBrnqm5mZX9bs4JvJ56QQJTUM9vthhpyxp?=
 =?us-ascii?Q?IMRqDWUb2aUg5BtaEe/RBbp65pOI4LZPajNB8tSCluHhDT1JKSOHsgJigy+k?=
 =?us-ascii?Q?DTUVugnk6eTknRE2zAJQZNac5P/lwrOLT66knU7eap6zg5cDEMnLpRAXUMkA?=
 =?us-ascii?Q?xHi7uZYjjFGKC8JfOm1qiWD+32BKGzPZHLb437mAcoV3BkjTos/ux3BFRzBL?=
 =?us-ascii?Q?sFl8seAnVrhVEmRoZaznbn6GVpxF2FbxVDEHPDH0or+9q1w2E2zSMr3DrKKF?=
 =?us-ascii?Q?L78vHd6cOvD951U0UGXi2+ulecz7csIuRmkwT5R6+qZoFbW7869gYwP9ah+R?=
 =?us-ascii?Q?l1RPBaNlmSEvQVrDulUzS0xMg9GRMBgcmzxaf6KwrO4wC29jVE5wfNfFEZmk?=
 =?us-ascii?Q?CbKhDmsla5OYfq+6cjn1x6+fTii9/ALFzcO2rx1nK9TZCUwkxlC+Cs6ZEOSB?=
 =?us-ascii?Q?WldRbs7t0TXYlAdA+j+Ddsw9S/Xc++76Xu1TfyhpqlSIxN28LqwzRF4M6o6Q?=
 =?us-ascii?Q?bFTeHyHpCJGsU3i42C+1gbNBmgKnSZEBaOk/laO4Kv+7KGjZ0L1tgeD7fSoD?=
 =?us-ascii?Q?EhrezAluFNq/AK4zPh7YYK75qlFHOOy6aMQM7BL7JonsTXCiF/IMBJBGey+Y?=
 =?us-ascii?Q?e+t1gTI96S8+tLrzdeI5CWE+1SXlB0UH9XZYiYWC8UUXE4MrYYS0y8/Na6CJ?=
 =?us-ascii?Q?RIbY2zS2lTy3Q5lcWZrD3aRy5L8cDKud9DN2SJWQxFU5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b4c631-f4b1-4b68-ccb8-08dca24a4a30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:11:53.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSdBrMyWokMFXbT7+e67ayWUJCX2NhrcB3XmS7tSfbhaQr/8fX96MbPv8DBuoLiHXA9q1a7VDbecwQiRZbtSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8316
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:12:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16459

- The busybox losetup doesn't support "--sizelimit" parameter

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
 .../files/encrypt_partition.systemd.hook                     | 4 ++++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb         | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index bb93361..72033d1 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -5,3 +5,4 @@ WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
+LOSETUP_PATH=3D"${CRYPT_LOSETUP_PATH}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index be8c117..2ace533 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -19,6 +19,9 @@ esac
=20
 . /usr/share/initramfs-tools/hook-functions
=20
+# get configuration variables
+. /usr/share/encrypt_partition/encrypt_partition.env
+
 hook_error() {
     echo "(ERROR): $1" >&2
     exit 1
@@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep no=
t found"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found=
"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not fou=
nd"
+copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error "/usr/sbin/loset=
up not found"
 copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cry=
ptenroll not found"
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/syst=
emd/systemd-cryptsetup not found"
 copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm=
2_pcrread"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 72de5b6..1679133 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
=20
 inherit dpkg-raw
-DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup, \
+DEBIAN_DEPENDS =3D "initramfs-tools, mount, cryptsetup, \
     awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
     libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
     e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
@@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:ree=
ncrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the fi=
lesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+# Path to full (non-busybox) losetup binary
+CRYPT_LOSETUP_PATH ??=3D "/usr/local/sbin/losetup"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
@@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
=20
 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    CRYPT_LOSETUP_PATH \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
=20
--=20
2.39.2


