Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6AC41513
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 12:57:42 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.56])
 by mx.groups.io with SMTP id smtpd.web10.6988.1720789046418024875
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 05:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=m/TvXijO;
 spf=pass (domain: siemens.com, ip: 40.107.103.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5Ug3JfMJMxgbcqEUoMwzAr2xoPfnx/qCdc78PmiXba4PEwbr0ao1E5643AGSaJOQ6Ekf/V4gcnJ++FyxSeeQ20tOgWrx7njnzRFHO28AX6670ybx/PbwxK2Iz6VVUhRAZlrNnhQgHNCuK37i0Yumyv/rsB9QywXEyAE9yleRLpZuzSo7qOvQ2j9vgrf5M+sMTBEmgqCtYTv6et/JYKJ3u6jgSDIndAcvmsBvXWu6avqKG5wC7PgIoT6Rf3D0p3+QYu9QjhK9YSpWc5kY9mqeQQS6aTeHA1xREuJiDbu3ziAatkBeoJhuivXx3oGooT78lawEuFiS08jAEqOEJXd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQ/0rcbbzmjTXpMel6be+vxi9sCYrGA37X8c0THVzc=;
 b=wO8LsBwZQMeAlstVV7x7bCD0yZ7/p/yZOvgOyBbJ4eaBqrwQpvKbJG0pJ29chBkH8E7/2fR93BigTSJaP7kc1Zmc+Ciw9ZBxt1UBlF/2TuBjkp8i4jNf397lfkBAjXRQiHNqcmceK06BbPoe/4Nh3mG00EobPDyN1PyQViEW10Xe79RQ+Zvnx0nTLAC5smnsjP65HoSfzVtod6jmmP4GyZzEiypmkZZEDdDx9+x/OUuk38G/tf3bLylwNbDaTNBdz97NE/b5S+ACBpg6f7yWktTvvg1m4i979FiRnZ8H4JixqDmjTmer4ZVvnKA0BwOxyj7iQHwLPo+SoA19eTRckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQ/0rcbbzmjTXpMel6be+vxi9sCYrGA37X8c0THVzc=;
 b=m/TvXijOhIiu/fwZP8oVoDevtHQxi9AkQtiawXQgUsbU5zY3vJX7CK7G6J2NlGYRTDlsHwP1/zE81QFsWRrVfI+7/vNMDjnS26R4sF/m5azsM/3EWO+8pZokacW1NIhb3ZOgqMXtAi8WZYgPINOLzPx2stprCErTxKvkIj8DiAKhKe4A+bUV06vmuCIqHLodTVuwI3oYCvAQDKCTuKBX8pTyBSUbdulPzkli4/aj0EkzGqjMzHMjKjA8trb0EvEw4pie24cpDQBviBjbzJkc/vEZKVs6tduFAFrZHOkvrUmRFohS45OBbfdaZ6q90ANQfZ+LlrHp4T9tgwCKgd6Khg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AS2PR10MB6750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 12:57:23 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 12:57:23 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v2 2/4] initramfs-crypt-hook: Ensure that full losetup executable is provided
Date: Fri, 12 Jul 2024 14:57:11 +0200
Message-ID: <20240712125713.2066512-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712125713.2066512-1-stefan-koch@siemens.com>
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|AS2PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 494edb73-93d4-4b44-97af-08dca2722c8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5j/Twb4ak63o0jST5y55v4gpm5qpI9CcMyyed0YhnfOzYikEdhA4K/HDFk3w?=
 =?us-ascii?Q?paxuAG3fgV6Qh1yEQj4Tvx8ssFjLLyaXkv8JU21axV8KzVpvu7jKsGtA3hyU?=
 =?us-ascii?Q?o+RfOYc7HpgJPxSJSS2CjbNqQwvS82GFNRlG4m7V1oud39z5qeEjcTUiFT3D?=
 =?us-ascii?Q?YuU5bTRoEd+YIfmQ9qt1Uc4jAKa+t68jlVmaBc4VDzoYHFPJfB6hd6osxyTd?=
 =?us-ascii?Q?0vYFJFc2LSp0mZW0XdY2W30AWFjdEFbgqDhoC1KIJjPWMUtuXti1X4jk1yrW?=
 =?us-ascii?Q?XaDdQ0/TH+k/DZRosubjo40kxUdYkDYEqMuHfRGY1cJfxC9axO5N+Kthk7ws?=
 =?us-ascii?Q?jsNw0TnU6I1kRidIVwOFxhmKE7y8wwMVpO/HjoDf0vXRnLTRSqe7wderX/yw?=
 =?us-ascii?Q?8hwQPDIqMgDpngVLKWNkgDqEL6t/582vHXWNyjnTi/0wMZDuqfpjlK07Vc16?=
 =?us-ascii?Q?SfhmmQjWFo8AfzD0Uu/iHjvhueX98rV9XE7I5js0tEpHMpWASu+z5Qar+RQc?=
 =?us-ascii?Q?w9xEoO6KTuiVlItMiOxCMhqr2ghsXVhDXtzABGQqPFEI14hJrYVTXcOO/CrQ?=
 =?us-ascii?Q?fCCpqQUEmsJm9PR6P1mGat8MUZIDDA1ie4tobUaZ1AV+zskz268vQfTAWill?=
 =?us-ascii?Q?k+3oUwcIJ4bFT0UqbcHascN0eYjECOAFnQ4dSgJzti7xxCrH+rwCvKds8IzW?=
 =?us-ascii?Q?9HJmd1XhB2cO5t7QQ8iANyHX29TIYXpHWkAZ5s8S1wrn3VcNxhAgVNTKipIZ?=
 =?us-ascii?Q?qxH4cMgU096heHlDkpwWJtoBLK57+NmwXn7q1HOYkGVmL7RdteIBGNkhMVTw?=
 =?us-ascii?Q?tTGQ9EL1UsTqjgBIGE3aJl3XPkVYPntEHIgOTsLTp2NLTF5N34d3cq3wkwNH?=
 =?us-ascii?Q?s7HYrIfJmqWD8nDfDtgVSexJWW9agJ73a7vbF+5+kceZJYTIk2mSYRmPiHQW?=
 =?us-ascii?Q?yIViePX166ELXvSgtJ/1BgBTeMuAH6lUIsqQ/AgEMViYZFSphBc+nB3+93aS?=
 =?us-ascii?Q?/gmY0ozPQOYRyuNiHOC237a9jF2XSGlrfx9DtgnCddWWDnRE37jx2D57yD3P?=
 =?us-ascii?Q?M3cTsgcQSRu7ID9mDDn1kmsYDm2nCJb7eqSztJLcK02BuMsoEmDBfriSwSOw?=
 =?us-ascii?Q?fCwBOlh71Bqad27ytSvI2KhVHqPOtidYssFmBbXAVsDLRRBYYv4lMVc+sR86?=
 =?us-ascii?Q?WQaUtuyIsUSUlApweWrmtu/OfEuoFLnlfQl3wb1ScR36oDdI9wMwS87TJ8dN?=
 =?us-ascii?Q?oTswJ3SDurEzGAntLwdiS9KsRwZgAd2dziPD2U+YCWll7+xHkhUGYLvmZw5m?=
 =?us-ascii?Q?FZTnVI/d0e0jg4UzXtUjMmNHowTmEo+4yeFLdH1E6wUljQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AuMKXAFWW1EVABqm/wiazfpC+5WQKqG15KxIPv72KpwWqU6PKflDxvhIcDKp?=
 =?us-ascii?Q?9UUTnzQ7JCwM27cafCOK99KdMVqMYTF5k9k4ukRDnb27HEf8j6b1bpuWeq2U?=
 =?us-ascii?Q?TVYPpFb3KLdk8vcYeWeXrpBxLM+VyV7AfLB9cGVJxiPpddGkYehKFNPiIpbd?=
 =?us-ascii?Q?J6jDcVBx4D9hgzKtx4TVTywglhph1AHsDIbtVJemIp81nJCG9H0Q8F3nxz+s?=
 =?us-ascii?Q?Qx0toiNy4OMHuZ/eYXDC1TvfiKb284B9lnY2RpON9E2pcZVzZG6PpZxLZ9gX?=
 =?us-ascii?Q?2ZryGRWf2fMikxG9t+AWaPcnAXp711utoUWUw86EN9hRMHNx3lIAYcrjQtDu?=
 =?us-ascii?Q?WR8eN+E3QEcFXnoaV2vNX1o13bIUdmjfR66pvjuJHdBrMoeFGpNr+240uj4h?=
 =?us-ascii?Q?psVlhlpudbAv3Zb/UCWyWCq0qzqRVzOImSBweMTMJzEPlYDGeLmiXtaBQ5J/?=
 =?us-ascii?Q?XAe6d4jYgPF9j4Z6GhZ/lYRuBKjUeRqIu7KTpAMpUbK/9kgDF91a7DTBHIEu?=
 =?us-ascii?Q?V5nsg5vl3IB8PYEoeqBlrYhgU4iGnD42maQ0PIOOJm3Ddgk+uJ2rx6gdKzBk?=
 =?us-ascii?Q?raaOFG6JCQIRsZdbDi6SW+0YeJ27flS465nWpf/ef86/adXO7XFAuDQu5Lqs?=
 =?us-ascii?Q?76mV1zpBJ3tKGlAreO30dWKufcHjAKJkLCf2vxJRLdmPiUsLxt8F+JCLbeHr?=
 =?us-ascii?Q?CQLfRbUQOCgRrWirLf1mJDoYcMgmuOeFQUF1V8rXDZFnrZWlFj+zuLQ9Hf19?=
 =?us-ascii?Q?BxDTM05sMlc8p9iVFSrgpl9CkGBh3yA1aYHzREmQWIn8enaUe7lL6yDpK4ju?=
 =?us-ascii?Q?+e4YEJm5FkNdH5REhzI+pov+aJ/Nrkn2IhsO0RWm9Uj9/uhjtce7gmM9cnA9?=
 =?us-ascii?Q?07e8YUrqhKfjz28GhENUlSWOKsD6W2nML6jWLIzSM4LhsQsZrrQPBR+jt91A?=
 =?us-ascii?Q?/6Du9YeMM+uzdpbcuyEuoBQoM5S+uvyfzBZDs5tW08ytezpyok0mX1nOk/LX?=
 =?us-ascii?Q?Kr5BddKPzwnEyNoe4mmtpEEC4NBkx51p0KSl78bHpw1k8DyMPjduW8QBuzDw?=
 =?us-ascii?Q?96u4a09oycLklLqh+ES8cjrwZwx+Y2W/IHxxiQvzxrq6f0zmoQMZbsd2Pe+B?=
 =?us-ascii?Q?GvtS+GI1wn+Fmr8GQIkgzXsh0aYDqFbwucqDJzryPjFen2vh57paNS9nVvbf?=
 =?us-ascii?Q?yKn9eRbGERCXm3U8M1Tm97uhps3uaLD6TNHuPz215TzoADp4269gk8+/Ulp4?=
 =?us-ascii?Q?agOSZ5FJxfvLHvG+sGYfDRThE6PRYmDdTFLFAxXGfLVy7gYZx3+Ez3k5DYvk?=
 =?us-ascii?Q?8lxgRf/bbuzRRJOo/S27wAqfcJwcv6oa2tTQxdRLoxGwP+stoXrz6vN/Xjqt?=
 =?us-ascii?Q?U3jweEwU9SFeY1IMH+v9tEa3gKR0b7DR1sEoKcSt+YpfiGUO39LxlbyTsnRL?=
 =?us-ascii?Q?mof+XvFLodAmbXgh/wXERy+VGUlKojPsa7qq6l94wdoTnbuzbH34zW2MRqwB?=
 =?us-ascii?Q?FFThPnzrMNRuiWrW3RsDceEhkfwTDOnNyE+HitUCcs0j7CIZENsCjIUd9kiv?=
 =?us-ascii?Q?4P2RWtFGU/Ipih05lGpVGOAtJ7S2tL2OaWqx5MjPk3ivzS2XpxVrLAS16jOa?=
 =?us-ascii?Q?rY6z3VITB7elbXXbwtkv/MQ6xPbn9rxvQCXkJWsubvcYCm9/3VIDAAoIKL4k?=
 =?us-ascii?Q?umwyTw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494edb73-93d4-4b44-97af-08dca2722c8a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:57:23.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwunAQrPuR8HciMYXyYqpE+K7FQEk5gFKXsQOPSh8LzWVPShpbDRMp2Z59mBXfsJltfcXv8ka+xbM1XsC3WVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 12:57:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16480

- Avoids that busybox losetup is used that
  doesn't support the "--sizelimit" parameter.

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


