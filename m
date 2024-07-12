Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EBFC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 12:57:32 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.56])
 by mx.groups.io with SMTP id smtpd.web10.6988.1720789046418024875
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 05:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gFBz+O3e;
 spf=pass (domain: siemens.com, ip: 40.107.103.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2mmf36+RL/ATlhyXLsDRw8Rl/sTLt8KjtkUuS8cH9qDU0al+bB397wKg93BXGgBxNq+oa1bmE7QJSRvf7/8PRhGqrXbiUa5BmhzvnPTLeGoxUbD33VFcuWjvgauDjdLoLaW+UPyszL+4Kir1egIz8KhdRlFP2Ee/iovWIK6Asuu5FFYSqRjofIIjUyyvOXfdU8XLrtw8lQVBuEdqcn9J4rJgUK6Px16wyZlabSCiPIbJhAfsXbEPv98E3LcJIzXzjGPSx1CbOU+926kG6L9O6DEa2wYOAtylegOZoas8vKTi83Yfzhn5AMlP2yEWU+4DHoBtQ4nZCbK2FfVXzfFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYn4JOvIXPthT8iiZXv18HcGcdJ1vjPbsauCGTz7ZeY=;
 b=JQvYIW9y/OfYzBd/uotr06afj7+5TXcFyZyGLOYnk72vK8fcFVtxMr9yHOWr159++WD3TgFAh3pOcSu4fTuui4zQE023mf5BcjQc73I1sdgBg+kaN6IGMRfosisZIpqq4t6WBM79lfRStRALBlDw3C1EfoflBsoa6XS9w7R1bEJwv4LDIv2vJLlKGIoxg2hgTiKJAy7YcVePUADgDD4dxbQXnk2/BUxaaHpff5WcCpSB0HpCaUGUe7OktinIGQxGvP7U5eU+qJfAdCuLmHjlsCt3WiNn/Watjg06RchFLPY8bcY3fFFtCCPDYw/IrvCa0ZraWzWF2CiAnXonQC4jFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYn4JOvIXPthT8iiZXv18HcGcdJ1vjPbsauCGTz7ZeY=;
 b=gFBz+O3eSlQ9/pqfD7kimhWuhbCK6sHSUr2CZe4/jDTqUJnXqTvedScTEDI2fjTPFU49418z9dxvXB36wezXqvghtg6NIbjw83wnKfVVVB/IYBvPbMYBBgkNTFkp2LMor1t/RZAzovW/s8TrvYEqiQvp0bd5VHEn+hQaTPM3jtcX2OJdGkqVH48uZlPKrVtWW1S+FTF1TGpx9th5AmMZUtYZcmHA7Qrj4SMhx3Oj4twNxmnSYTNfPp6qScEfVF6uS0xBZfeyLyHnNGQZdB9Tk23hlMOxKYkyiXawgV7Lux1+FxnicoFoHAPtt0MmiJBVXd5NsVfM6wK+9eMgX+mj1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AS2PR10MB6750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 12:57:26 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 12:57:26 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v2 3/4] initramfs-crypt-hook: Allow speed-up of disk-reencryption
Date: Fri, 12 Jul 2024 14:57:12 +0200
Message-ID: <20240712125713.2066512-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712125713.2066512-1-stefan-koch@siemens.com>
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::15) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|AS2PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 433fc735-25e5-4b84-2e43-08dca2722e0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+hUy1yBdW/IoJ6P+64Mm0lVW+p0y0/vfw7R2B6WJnLCC8vgp4b4THp3luAQ4?=
 =?us-ascii?Q?dpmmRRuLYddFEfWl5n7E6vkQtBPJwF3zK8KUBqOxMV7csxXsBvabbuURelMU?=
 =?us-ascii?Q?p3NAAtQixRe9JMo9DgGlBfDTeJmhZ75pXw03x6yCmGfzXBbQZglqwq2f7bfa?=
 =?us-ascii?Q?xN4e2CQSMBEJJ/vQ0TF+nllF90U9UjjHp1Lq5iEIXoXLVlgqJ/IDxxqWHc3K?=
 =?us-ascii?Q?/xtAorjOuwNpvJ3u6Hvb0eL0caMxmMo8OxsbNYXQGNA7eUZmMrbDJqeB5jW8?=
 =?us-ascii?Q?orBXqMaH0jcnNwftZd+Q8+MrDINAFdaOKkd7twCI0g94yp74BTapZYAG0H1/?=
 =?us-ascii?Q?KBIooOAkVRZjQX3g1LXhyZJY2WbUwAb5S+nggnChieqMkKeKcWJeFlSMGKEY?=
 =?us-ascii?Q?2xW3d1FGdsU9c7KeYgr2VhbmNjUlOi3MoHfehMDeRglZmjgOHdMerUTGLSTg?=
 =?us-ascii?Q?0QTFBYq/C2EDcWzlDEkiTY5oebq8zIbHoddTR3GY94wHpDf4zhsokZiaAI+k?=
 =?us-ascii?Q?06GEqGweG4mP8nwa0scAusFu98dssSddWgRRkRSNwQR8Egpbs1r1iV6QInI7?=
 =?us-ascii?Q?zn24VvQuMsuCbprWdkBTRn8pkqSI397bBqR0IKfJRUX4ShuaxfmP9Jc/AKHm?=
 =?us-ascii?Q?kCnaQtM+kZALRSllfSShIcE5RpuuVbs6juktVBPQU3rL32zUD4ucHo9J+HnF?=
 =?us-ascii?Q?wyDW//kHknOLhcZj+SLTccIdjbWvkQ+Ff89WF/sUZTOPls/cREg30b6DQpf1?=
 =?us-ascii?Q?oNbTwiq+pX9KSiWB128mNjzRsN8kskkh9ABKBi+B7rCrpwYfD7A2+VjtA3G0?=
 =?us-ascii?Q?Vp2ytXDOCquQl7Oimh+ylGT6NsD1cFtE6C+eI2kVjsXJ4xHE8/fdlzPVWfCb?=
 =?us-ascii?Q?7XH16I2Mxo2YbDHEJFWhQpEX86tkjU9w480cMFGFHPydcWjD/A3AdfRd/RQs?=
 =?us-ascii?Q?R0wXfBfIiEG+JSbMfrWj+B2P2ekXLHbookj68v0IZ+9H+hE1ySUsMYmYCe0m?=
 =?us-ascii?Q?70hbvDWX9zNv8oRY9K0NIM5As9Al85+GmHAWDUn3lfdLcMA+rTnXuup4d4/q?=
 =?us-ascii?Q?BUz45ktPKuP++xl+T6pNdPmINVXndTUa1D22lr9e0/7u9APnhe3Uz0Que/og?=
 =?us-ascii?Q?IcJJJfLsjGXYB0obk3FXXJud3eTogtZT9SHOXXwiZHjLyVDRQDBT9em7CBMZ?=
 =?us-ascii?Q?YcSRIKzymc+eG4lDFtOOCJIUlPkjDN3j7J/KDIGFom0PyGkopkaiM0JoSjI/?=
 =?us-ascii?Q?GnmxR/ybRmR+6LzRPuJRZrlFjNx+DXd9WJC5SgwZ2yloA5WRdhW1euwu1D75?=
 =?us-ascii?Q?9bNIae7Q2/vaER72LREHkDse6Lri7CQd4feBTTlqSJFaOQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lUy/pCStk7tL/sUmIzxEn13BdRAo9LxgNWorFGcvq1L4xB2bHU1DPOxKHTIc?=
 =?us-ascii?Q?Izwl9CtTp81jdC0yKrlYALyDFDRl2s6zb8z6KjG7MANrgNnsNenGBLTAUeI2?=
 =?us-ascii?Q?6V5y1722JBJUlHsiZy7vp7r4/T/69agKDFyWE+EwDHyC88HQUKHh7HCTnMrU?=
 =?us-ascii?Q?Ko5P0m8C53nt0UMJjLO+eTg3SWrAcS3r21arIV338xPQyiT2SHu2gTBrIVEV?=
 =?us-ascii?Q?MsQanOx6Yc6OpfT4tgVGYw9xN5dUbQ4MYfbtcYXnF/33NSifDfj7CSpQiAhV?=
 =?us-ascii?Q?hgWRl6nHrZ8mkuT2tzakE7/PGHxbavgzdABD5lB64wIOVKPR+KYXMaxsetxz?=
 =?us-ascii?Q?MaR21cs4kmIfroa52eaOSeBs+4JfCU+0TBJ9C6J2KoQL/t044EpKilHLNxUS?=
 =?us-ascii?Q?lfjXwyQAZUtlTZnZJ0CjxadrR8HGadxt6vApE6W05Psu5iGY22hgr7m1DGlY?=
 =?us-ascii?Q?CcsmRjD8VceA5JD7TlirobNYxlfzBjZXzpsx5/XQKTxPpCEmKwdN1wIfCRFv?=
 =?us-ascii?Q?RhRKwtbDrdAZmPENcdBFuilraojlSUHJqRaebR+SgXcjtgM6DPJDt0BVxNZw?=
 =?us-ascii?Q?zJjpZLYua11uyq8CW/oV1A+uU/XdnHzTQ77G1okcm0/YdIz+2Ad1btMuE3iD?=
 =?us-ascii?Q?InhaVvDns9/Ed/ZUaW8tkRDmA4bObVrtTE3pdpHrbtGx+CMuXk2NU0cqldvn?=
 =?us-ascii?Q?Tn5FCF946fu5E/MltKJNsJGl84QWKWRzITMaMTAXA+RKPkzyOiPtcZHeUC5+?=
 =?us-ascii?Q?Aav3bmPeQOVmw3TRNQMWaaP+sywoDiLxRcoLlO7Q+YcDi8Ka0AH8rTuziY8g?=
 =?us-ascii?Q?OLiVKPeqP9NDKQ1e5K/yn0hrfaO2Sj5/H+qH9P8AIMaIIu27hOPFJmzHpBnH?=
 =?us-ascii?Q?cBP+D0sH/uVKUu2WT9qUuarlcS6TyqprHrCfNyY9uHbp8rJJhHOEpckae4vv?=
 =?us-ascii?Q?A2hzhIvwpMOnXE7IgQhadiBNojudddQMENJ/G+25hX8Pr/ezTZ2XmR2OZxlY?=
 =?us-ascii?Q?cTiU37J9YyOghrx8U1Wd3+6ypwnlDYzEIu4NMN5FakEgYWHLH47iu3YAE2Mz?=
 =?us-ascii?Q?X4cI19myxU+IPGX5wZAZZi418z/dXuRNDTyQelqCm+cLi0MVdriXUfVlIcrc?=
 =?us-ascii?Q?uVvuD85iKgEn8xVfdYQL7tfK3QzdF3GTS4jo64sFuKcD+bxiPoCE9IXDLpfK?=
 =?us-ascii?Q?3wgqJV6nU/+sSglMH4UFiV5s1m7WU+O8O27TZR+DBUmkvtu173NOBe1gefgF?=
 =?us-ascii?Q?D3jIxnQO2VfeWA9/PV6d+bbNbV6vDrWdm9x+9uWYTJ4Alnjyi9JiWsyDG4Cn?=
 =?us-ascii?Q?tJQ5J2UndhQaTezAordxYPWlNJEOT+59FYlnXvPntvPMiO4cdL+PhudLqZ3K?=
 =?us-ascii?Q?8hENKBtUFn1sfpo1HJXwSsdiVpKE/FWnja3vnf7q9PDIlJE+Npig0cEFsz/s?=
 =?us-ascii?Q?nFfPHu4dmkx1svNEZJj8km7NOf7D5OB98QQUXVQj6lJ8EZOputBVYaV8gdP1?=
 =?us-ascii?Q?9MhlRfQKsMXl6msnFHpu64PN8GK5/EDLaJp6eqCx3AZuMbI7XHBUbLspcsz3?=
 =?us-ascii?Q?JNzpD/Zrk6cL/v1jS6tZ9MTW9wm3qhbc+qaLVP5a2VYQSZ+k4mX8LNKcRftI?=
 =?us-ascii?Q?V6ftQUXAmqVBCOAEZzy5durc9PPyKy6rIkh9mDLeV+/do8oxWfTjKOHKSuok?=
 =?us-ascii?Q?KINQrQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433fc735-25e5-4b84-2e43-08dca2722e0b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:57:26.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J8hnzSol4ma5P96qrmPQcflZfutx5nkJ20HhSzFLwESfLwi8yYWoSmUSngUP2dbmZit8OZndkODZUpVfhPo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 12:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16481

As the reencrypt mechanism doesn't work at file system level
so it wouldn't detect used and free blocks.
This means that the block-wise reencryption process could
take a very long time depending on the partition size.

Using the format mechanism instead of the reencrypt one
would delete all existing data (without wiping). This would be very fast,
because it doesn't matter whether a block is used or free.

Set CRYPT_FAST_REENCRYPTION to "1" to speed-up the reencrypt process.
So, this would be done:
- Obtain used space of the unencrypted userdata partition
- Shrink the partition and resize it to the size of used space (minimum siz=
e)
- reencrypt the userdata partition now with smaller size
- Expand the encrypted userdata partition back to the maximum possible size

Some disk encryption implementations like within the Debian installer
will overwrite the entire partition with random data for security reasons
(e.g. wiping old already deleted data, hiding metadata, etc.).

However, this speed-up lacks the described security benefit of implicit dat=
a overwrite.
So for security reasons, it behaves identical to the format option
(there is no support for explicit random overwrite within initramfs-crypt-h=
ook).

Keep in mind that a power loss while reencryption will cause data loss
(with or without fast reencryption).
The key is only enrolled after fully succeeded reencryption, yet.
So, no recovery from already encrypted data would be possible.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../files/encrypt_partition.env.tmpl          |  1 +
 .../files/encrypt_partition.script            | 50 ++++++++++++++++---
 .../initramfs-crypt-hook_0.2.bb               |  9 +++-
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 72033d1..9f3df4f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -6,3 +6,4 @@ HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
 LOSETUP_PATH=3D"${CRYPT_LOSETUP_PATH}"
+FAST_REENCRYPTION=3D"${CRYPT_FAST_REENCRYPTION}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index f943aea..e768b54 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -62,13 +62,16 @@ service_watchdog() {
 }
=20
 reencrypt_existing_partition() {
+	reencrypt_device=3D"$1"
 	part_size_blocks=3D"$(cat /sys/class/block/"$(awk -v dev=3D"$1" 'BEGIN{sp=
lit(dev,a,"/"); print a[3]}' )"/size)"
-	# reduce the filesystem and partition by 32M to fit the LUKS header
+	part_size_in_kb=3D"$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
+
 	partition_fstype=3D$(get_fstype "${1}")
+	# reduce the filesystem and partition by 32M to fit the LUKS header
 	reduce_device_size=3D32768
-	reduced_size=3D"$(expr "$part_size_blocks" - 65536 )"
-	reduced_size_in_byte=3D"$(expr "$reduced_size" \* 512)"
-	reduced_size_in_kb=3D"$(expr "$reduced_size_in_byte" / 1024)K"
+	reduce_device_size_blocks=3D"$(expr "$reduce_device_size" \* 2)" # 512 by=
te blocks
+	reduced_size=3D"$(expr "$part_size_blocks" - "$reduce_device_size_blocks"=
 )"
+	reduced_size_in_kb=3D"$(expr "$reduced_size" / 2)" # blocksize 512 byte
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -84,9 +87,31 @@ EOF
 		if ! cryptsetup luksUUID "$1" &> /dev/null; then
 			e2fsck -p -f "$1"
 		fi
-		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		# shrink partition temporarily to minimum
+		min_size_fsblocks=3D"$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
+		if [ "$FAST_REENCRYPTION" =3D "1" ] && loop_device=3D"$("$LOSETUP_PATH" =
-f)" && [ -n "$min_size_fsblocks" ]; then
+			# set encrypted size for expanding step
+			encrypted_size_in_kb=3D"$reduced_size_in_kb"
+			# minimum partition size
+			min_size_in_kb=3D"$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 b=
yte
+			# shrinked partition size (reduce_size + minimum partition size)
+			reduced_size_in_kb=3D"$(expr "$reduce_device_size" + "$min_size_in_kb")=
"
+			# set loop device as reencrypt device
+			reencrypt_device=3D"$loop_device"
+		else
+			# continue with default reencryption in failure case
+			FAST_REENCRYPTION=3D"0"
+		fi
+
+		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
+
+		if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+			# use temporarily loop device to simulate shrinked device
+			# because cryptsetup uses device size at reducing
+			"$LOSETUP_PATH" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1=
"
+		fi
 		;;
 	squashfs|swap|"")
 		[ "$debug" =3D "y" ] && echo "skip disk resize as it is not supported or=
 unnecessary for fstype: '$partition_fstype'"
@@ -96,9 +121,14 @@ EOF
 		;;
 	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_devic=
e_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_devic=
e_size"k "$reencrypt_device" < "$2"
 	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_d=
evice_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_d=
evice_size"k "$reencrypt_device" < "$2"
+	fi
+
+	if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+		# remove temporarily loop device
+		"$LOSETUP_PATH" -d "$loop_device"
 	fi
 }
 for candidate in /dev/tpm*; do
@@ -182,6 +212,12 @@ for partition_set in $partition_sets; do
 			reencrypt_existing_partition "$part_device" "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_alg=
orithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+			if [ "$FAST_REENCRYPTION" =3D "1" ]; then
+				# expand encrypted partition to maximum
+				/usr/sbin/cryptsetup resize "$decrypted_part"
+				# expand filesystem within encrypted layer to maximum
+				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
+			fi
 			log_end_msg
 		;;
 		"format")
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 1679133..6ac77a2 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -59,6 +59,13 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:re=
encrypt"
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Path to full (non-busybox) losetup binary
 CRYPT_LOSETUP_PATH ??=3D "/usr/local/sbin/losetup"
+# Fast reencryption state
+# It uses temporary partition resize,
+# consider security and data reliablity aspects when enabling
+# (e.g. wiping old already deleted data, hiding metadata, etc.)
+# Keep in mind that a power loss while reencryption will cause data loss
+# (with or without fast reencryption).
+CRYPT_FAST_REENCRYPTION ??=3D "0"
 # Timeout for creating / re-encrypting partitions on first boot
 CRYPT_SETUP_TIMEOUT ??=3D "600"
 # Watchdog to service during the initial setup of the crypto partitions
@@ -70,7 +77,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
=20
 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
-    CRYPT_LOSETUP_PATH \
+    CRYPT_LOSETUP_PATH CRYPT_FAST_REENCRYPTION \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
=20
--=20
2.39.2


