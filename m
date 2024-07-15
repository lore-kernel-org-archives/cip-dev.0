Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFC5C3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 09:34:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.62])
 by mx.groups.io with SMTP id smtpd.web10.34247.1721036070418753569
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 02:34:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cS5MCF71;
 spf=pass (domain: siemens.com, ip: 40.107.241.62, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJpWZp7LHn8Stmaci//NRHuqpA09n3/eI0gCFDuX25kosdiicO3t859VKqfMdoeVSoZ9cyIWsym7jH6PY2M3pgAvfhoUhx3ZThCCChVIb66Evw3iR6htkXQ5O4kEPXVBFmWDdEvmwD6IZnXQOHjHQpYvqsiRsuLjtOkriH0wGnH4GwFWEgudclyEhAGLo3SSn8gXrblF7+NRzlcdzMaISRib1Nsrrrb5AAzFIqd8HG8+Pfd92RDNndxM3C8rK8DYP5MLGM4KyQCvaAPX+r5EF7foMzFnrY4lc+EtH0qEodaKUeTVAoORFNmCahNTnmPc9/JIDEU7qOmia7/wZGMXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SkI8w3rPwepuBGHuWc6NfKzmp4VWAyYdX4/qwS3w28=;
 b=vgEboDSSeSVABpwZpgmB6wwIRWYf9btMQiGq13xrJQEHbSYq0fxcUiORKg5A4HSWOylsv3EnMtsIbrgtBYlYgkEURyaGcgBdWVipkmStZEwRcb6Ceqvhh36Hdcdx0ebXanNcUb70BlLY6KvopuJnGTos6uQDMyB0Ebb+uBpRTAnnCiQZhxG+WCYoB62CZZScj+SYW5e01VJEnqJXB16TG1Ao9dMBLZ08ughu659lfG+OoDPmMzCuA/kf25hZixG2j4XbftzJmAOj98VyPt4ZgnydlOpEmBYr7jW5OvgITK2yoPJ6lMhG6ZgRjBRozaO7unZRZGMnehap3Ih7eFDR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SkI8w3rPwepuBGHuWc6NfKzmp4VWAyYdX4/qwS3w28=;
 b=cS5MCF710Ld/vulQAU+dj2mO3gPLmT3a774x8NEk0V20JDir6lOKmEGS4f/5jI3zbrNTUqWiHnBJEs2OK2IB5dFajVRo8yoyX3QPeQQkIq6eTrVxGFheas/cirJ7zeLw7vS9BuHJ4Fwopjf7T7D/cpu5/ylBV1HpFFqLvYh1sQdB+w1fV1K1YFSg1KsnGCSB2sNPqbRr4vMsUQOrRzjM464IOm9pic/5F/rpg0ziT9WDs45j6DAQ7GQGkJXsbGa8Lgjp3Bz9UEX3wxI3MHLUsdONyD9tT6WztdLV13p1/eq2mwBBb55MlxxR6Pm8fI+04Jvb6H14BoqGz2sTIGzWHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DB8PR10MB3355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 09:34:26 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 09:34:26 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup executable
Date: Mon, 15 Jul 2024 11:34:24 +0200
Message-ID: <20240715093424.632716-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|DB8PR10MB3355:EE_
X-MS-Office365-Filtering-Correlation-Id: d48f3c06-8ab7-4198-0e3d-08dca4b151c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A3uZJvrA7J5jTiYywFGCkIZie2aQQTkYo8f8L7Fr7goSYLl5Xq1KKhs77ncx?=
 =?us-ascii?Q?9dkRrBG3nj3tuxiN9P7L+1Nwjc1/dSeURvWdU6dJJRju7187564dyV/xEkrk?=
 =?us-ascii?Q?8Vw1dNYwPL8aCPGblg0Mx+5CrK+eZ29WCScnmHDac+DFJNbHVkCANNn9Olz8?=
 =?us-ascii?Q?SbMcPVTJa9BnwSClgGNShtGZ6INzzJHlIc3f76b648k9xHt6r319e0Skmex9?=
 =?us-ascii?Q?NhZeOQJpmsAp4wSbuAHMbQAKEUOOFP0Twj4E7iQNha69rVbhzamPxBLd6Dwj?=
 =?us-ascii?Q?tBq74yLX4qvGd1xWk+lHxI363iGi3ap3Wqjzqi8UzawAVpTc+yJrbew0WGJR?=
 =?us-ascii?Q?sPcMTLIIc7UWxirs8+LPtVhitMkOkeidFs+znjL3KcszOSUopxTxPzpRek4P?=
 =?us-ascii?Q?Dcf4lHl3pAGRMO8iSGIjgZP4di7XVPbI1VsW1Np5IWVrEJfmTwfDs/UhBk9r?=
 =?us-ascii?Q?b7h4iFXVZU5xFZ9+FlqSwak22POw6YY5CBBajj2PYBGulqeZH7Jbbw+Q3jK5?=
 =?us-ascii?Q?NLQXJnn35T8k7uSYlKSBGMMZpmmweVc9qAmhfE8P/tcX0cgm9kLqMfL+4ahx?=
 =?us-ascii?Q?EhGY83IGDUGlviy3bEPnQ1q6ppCcPk13SEiP1LPjGkTmeXK17wplQVFZdJAc?=
 =?us-ascii?Q?9ews8H4tXl9Zvx6kZZYVSxJs2UwnYOsmL1nqWfwYTiIChIQIJiRB3k7bf7D6?=
 =?us-ascii?Q?qpXQK++oJowHCLWi0Zri//Ll6b8u0NwpUOd/B5On9ZW8nxrnQEGlu0HcqC8S?=
 =?us-ascii?Q?hWqA2c+w4TxK4kxmKMRiPWO18mmeuKVKLEtMMQrZbXQf6cQgUUQ9kGjnxPgQ?=
 =?us-ascii?Q?43GPtLxcBsTzdqJebN+oo18/A3cKpWPx/GuBXObAruQLK5iLyWxE0GPBa061?=
 =?us-ascii?Q?ZLKBSJvSyL63krw6hZl6ZIU3U36KxvuL1RLv8SdZRRJUa7Mp+8GSy1ul62Dt?=
 =?us-ascii?Q?P1yr0GZcdeQ10bLSFb/2Xexd2CoUUR1HHXQA2LPBwzPhSr9kBkehGXinhKJn?=
 =?us-ascii?Q?TIZKVbV2d1rxKyM5jss3I/u6Gsfss/3Bqo2CWVhBfOA8LP+TahusKjbEjp+l?=
 =?us-ascii?Q?M8xdJYmeTVNvH6NC+QRlFyHiswP1mbhTNhVe/+FVEKTCzE3lg2d2d7xH1CJD?=
 =?us-ascii?Q?APsEeCZE+aB4+fppNkPMvps2+3H0Dc0V9vmyKP4zc4xmWB+k1kSxKqjJbU4p?=
 =?us-ascii?Q?TzsxTlNgzzgFGee7f/PSIOmZvNkzDFW6LrPOS5suf8C9pImSA++6pBV4C4Tt?=
 =?us-ascii?Q?Ljch/e4jmbu9q15t7k6s9QLY/FLitJzf72l63Q/WN3s7BZWaMInk/e7lChVY?=
 =?us-ascii?Q?N6yQ81d7oZ3YMEceznwkjbd1HqOlhvDFcVRmSpBlihDXRA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6+IWQpmlt6ahLSTa+C9vIU1NASd+oGHrYraAQ0gVyB5rIgunXRlryTF5JUG1?=
 =?us-ascii?Q?OYh2+TmyxRofzyvpctHtd0EkaI3966zfxOpr1MecirJKQoa0EsiWPmoqvUe3?=
 =?us-ascii?Q?dBr0tEn67LqK4a1vKmX5Rfcyr7GUlVpBba7wc46GENrgBdnojH0eJhaHG6YO?=
 =?us-ascii?Q?nkHdtew6gRQCv0y5GSGLvrhwZLfERjDKujHHNjcRiREQZfbeuKF4IVYarj9W?=
 =?us-ascii?Q?N1/ReiL86jLskQWEiKMsg+bKP0qi/7i1kMhHaWCSNwcDDZWczJNE+BKHfopO?=
 =?us-ascii?Q?LjEPhLIjSTQoKcgrIYKFDyJwkBE6m8az9jkjBclox7VM4woW6hQAvK4hGkW/?=
 =?us-ascii?Q?FwOkr27yNBANQkegYGJOBeMBuPCBzuc72bk5DKlYSIe1CU2T5+bh4Aurnj/5?=
 =?us-ascii?Q?EzLUe3D+LV+/8R+LXdhRnHmSH6SqDyV8RAfSKqLH9hEES3KGAi/9oiPwfbkv?=
 =?us-ascii?Q?LbSat3OU6UN87CnSR5OIEP9EGndSpwjD5DwIGDyy82dRLEtEJySclFFBKa+/?=
 =?us-ascii?Q?jNVEedMBFE+T/SdjSSIbwo1Y7ZY/LG1BbbU9Q+J386EuV9dm9I/5840kJwjT?=
 =?us-ascii?Q?2b+VEAY9JInZ+IySDP8I5btI6iH2Jg95mlirHiysaPRS/pKM6faPH9FRDl1G?=
 =?us-ascii?Q?/QH9Ok7CMmBF4J89pbCyJ7iAmkXM7ghO++EdCLeOksCi6AoAUT0zb/6nr5IR?=
 =?us-ascii?Q?97M0U8ZL1U0zBEvYZVEyv+gSqzCSnv8wEU7rkdzZ+zB8oFmWIi9RCkPJOO+b?=
 =?us-ascii?Q?jd8NiTEXeJ36s0P7B5B2gxX8l/0VagRhKcNRHFDfJeMPj02x/0DhADaG3sd5?=
 =?us-ascii?Q?rm2srsSkY2SK37EAI8RwwkABVGHMqk8ujeJgCuu6im0lbFXiu836Bx0dGgM1?=
 =?us-ascii?Q?RdPuIwqxojG59CExlwSUCBTI4+WxxEhJP5g1aQzzJ5qJVrKYNMBGjlayNWGN?=
 =?us-ascii?Q?w3ZKM0GKdYKdvBW7Jap2eczKdFHpx1+1/v5iNBXaYpmz/ZWyDdlDJRg+W9MK?=
 =?us-ascii?Q?qR3I1c0SO5oMh/6UP9PVTfR1Ks2MwkED5jXvf6zBTM3hZR5JyRN8wHjkVatY?=
 =?us-ascii?Q?O2rCIs88DMXihOWkFOwA5L2ZT79w6oFtilNwry2dD3uy6jGCdGY/fhj3s/BX?=
 =?us-ascii?Q?2vV/y3HeBxuGSogQB+2MRftIeK4ut50WnQdwuG1EA4ISyVSPJGWg7Bn1OHDo?=
 =?us-ascii?Q?FNA4wJE3kWnTpx4lSC8zd0GsUysoSSrOSmNPHGgjmv1gVOhxYVG7vPdc3M7M?=
 =?us-ascii?Q?m1MJqCgghLmCz7L38E1cAD7ZJeqbv57Q3TIC4Kniu8pK3+HOleAeXb6F8uVj?=
 =?us-ascii?Q?47u1Mt+7ZLyyz0IDU5p0u1cSqROrrOheIa8uHQQ9c2VtSj6hvEi/xvysqwRt?=
 =?us-ascii?Q?4al9NYP8urraWzXsGnXs0bwf61QStB+2FBSDc7Io9MmQ0XJCxSKcjSNf/8yK?=
 =?us-ascii?Q?fSJ5n5TqiSjhOxICBePO8lrBhiky+VXxAy7FbXs0tRmCPeTynOZ1SkzhpULL?=
 =?us-ascii?Q?m1zzCqEa8iKis/NvFF+hM2gbA0+zGgxYJtJxfnHb8zmiTONpO3YSS2Zy5BK0?=
 =?us-ascii?Q?1kPafQjtoboGZyP5oa3GOloW7hifhDyrm7E7buLhfS8HrQdeGExyFW0jViqA?=
 =?us-ascii?Q?RVL1sCIeRnJiQU8vbHPusWmf/prJLrRZ5AfQ7ZwCRvzm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48f3c06-8ab7-4198-0e3d-08dca4b151c2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 09:34:26.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/tjWPj9qSiZJnS/IfuLpF+GhsTjH1m7zw7sF+81xCk3tKxUy1kEI17zwE6r7fz6EMpCNOtGygz5CaZIKUpU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3355
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 09:34:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16488

- Avoids using a busybox losetup executable that
  doesn't support the "--sizelimit" parameter
- The "--sizelimit" parameter is needed for introducing
  speed-up of disk reencryption with the following commit

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


