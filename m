Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58830C3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 13:46:38 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.73])
 by mx.groups.io with SMTP id smtpd.web11.38326.1721051196428950637
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 06:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Ur5pCfgM;
 spf=pass (domain: siemens.com, ip: 40.107.104.73, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWdzBVecWs+KQ/oWrld6yR6cC68ZLxCEeJeahIwZIW0MJvza1G4fEwdp+w+1BP2aa3ey4r7YYUUUqf/VNQFS9sEdyZsHiBhCmrscd0BXKJz587bxHHmkFsajTRjOsz1PTtV73ieWvrHxl95vA/n/lcTPvF5IBmN2VCcQ1EXXMtaIXqTnpNzB7rDlHYaMB/NQo/JwXdSa6WNP9I0+UJlVwaYeuaJv1YePl6/DZbYn4IWttmZu5nvGbtMkpdPgBt7XPa5pjAc9zB/sAtUa97Wy85WwNoaqpa85guI9pwAB9FZyln7yUeI6gAghdn8Rz4MxLcAeXzzTBHGcqP1TsNnl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2HS2yeK4UxUP8QZvBXkhssTVQTrl5h0dl2AL/cTsaE=;
 b=uacRlz5hylmPtnyE1yQk9At17PErFdvMCshDeQeEcDi4zmh0RUjcm9A04RPSjoXBvjlIcOs27pykzlQYMftfpI4cpFj2gwlROQFIC+pj9x9WgDrjcc+Bd5NRYAGWuKE0YpO92EtmLQIlB+rgvqoVhOJB2EZSpdMZf4cS9eS3Z9FGQxJDXmtnxNA1cGfRf1zxSGBqEKs4tA6zPbp6ngGwX19seiLD1u4C1PMfw3Nl9/xauOXBfy5RjZLZRgzjCsxSdZXeFq0WDvKzTFQwSuw8nZV+8jVE3DhDeQOSqL+eqSUfQItXuOMD4MX3Ih0mZgrxcXLxhhZdKCmeK+EcFNwu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2HS2yeK4UxUP8QZvBXkhssTVQTrl5h0dl2AL/cTsaE=;
 b=Ur5pCfgMo2tjja5iUOwrsCifYErWzVA6m+kDQEcRQGA0QtAMH07YVTdsyKs8N0NFOIm6aynv1Ng2fiub173UHTZY4ihb77zpxTplLQouhHneceARfjPp7VsUo8e4ssNLr1rlvXuDRzt1peVjnL0CnZA85NuRAzJv+ETNbA89iPZc4Prith0S6JW8RyOJNbog5I0YKjbcWCL5lncUup6NPgeU18vl4iF+SQkbeD6cjDLw4285ckiziKluDqS1f1nU9AseKDqcQ/3jFoplul1q+/Drjv0uBvqGWaQ+yj9z0uiolVOTIwnnU+1+0Ijw3D86fm/v+GU367KR7IamjXPk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:46:35 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 13:46:34 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 2/4] initramfs-crypt-hook: Provide full losetup executable
Date: Mon, 15 Jul 2024 15:46:28 +0200
Message-ID: <20240715134630.1640160-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715134630.1640160-1-stefan-koch@siemens.com>
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 349a7b6a-a68f-4f5a-dd29-08dca4d48aa4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8AaJFvB1lFKMWCdul+9AEY6uhD7VhXLDDvuHW4XczkByGaOPJ/77+Ib49g0a?=
 =?us-ascii?Q?f4o8DTqpcZLNneVkZZfLaB8xtA0eax9XdIloM8ETV+uWhDJl303xKhcJmPEX?=
 =?us-ascii?Q?NkY6sv7UhoZU8ffKBD7IyYFHZlmpT6az5UZj3LJKOe1Hm7cdf2LSR3vpBMyt?=
 =?us-ascii?Q?1stiegC/plVrW0cocY0EVYlsGhGInupVeoNBQ09E8GOtCLqvZTT12QqXrSCn?=
 =?us-ascii?Q?JiRDRcm3szCWZq/qQTubzkS07Jpa0ZETfm7UKoi9cJyFS6IYMT86O7NjlJfF?=
 =?us-ascii?Q?fI7n2e1IuoJPb6gzxIPzI2eHqNeaf6M6UtwAioaJN0UvDTSgAnYyyuwomS5v?=
 =?us-ascii?Q?oo0fyZ3qM28mA4F6z8svMrB6T5pKj9eqYi4iAf8Ow/gMcaVDV9PUhhVInaPk?=
 =?us-ascii?Q?iNQkppFB5gy3bCHtiq+F9zl3wOqK5iVq1627Gyt2l9TX4c/3BHpvnUNNcstK?=
 =?us-ascii?Q?H2GBsoJUaKHEJuSBKEDiZZfkWGA0O83h0PIILGJtnYEebyDOxY8J16gPeFUZ?=
 =?us-ascii?Q?6hk+kfHTMehaizk2UQHSlgJwnYuqdP3cnldrTfg46cNS59BpH+tNIzt0Sbp3?=
 =?us-ascii?Q?I75mjgJs+eIzljrrNPvUt3Q3t/lRt9twIHHz/cj4Md0zPmJydQmlMpXbWAoC?=
 =?us-ascii?Q?B3RT0XjlQmJckgIBfhcTBQTEBT3X9JBxAGu19KpciEUtyzb/PCkCJfvKjUAu?=
 =?us-ascii?Q?mDKKHnIXXORzcYL+NbumEaj2r0JeIX0oHI8D+9/P8Uyl73jTrISLkpOMhK0v?=
 =?us-ascii?Q?BIBKbisq2mHEOqmYNp5YE8sSETT/23U2kCbR/kVvhNDpm/bySCp+DaVKiKpa?=
 =?us-ascii?Q?WarsFsG6SDPFEGUs5uN0xDif315GLUPYgm73aH6KIKZX8oEjtNEies5iINnn?=
 =?us-ascii?Q?D/5NQ/0Zjl/pTHr5WBfqwrRtmtpcoKY03pdYXe5RmKJ3wrHdTi9nq4C1RAja?=
 =?us-ascii?Q?4kuN0lCVrs7gRS5tF++Z0uyTlH2N20YDURESfVHp2ORnCu5v0+3aSywTyYPN?=
 =?us-ascii?Q?eAQfSVjWmfN85S8Wg33m9T7JOKJCqP5Q9i4reSBc/OHJnqwg0VLu6bAbAbbo?=
 =?us-ascii?Q?a2k44k780nWtSvjbFYP/YCa1W2LQ7eTK9zfh7o+ubAjx//p2KW2CBV+DEa88?=
 =?us-ascii?Q?96Ol5Kv33FxXD20kZRXBIKd7Sh2lwPluVqE/AEab8T7nomcK0XtPOiZwZHpO?=
 =?us-ascii?Q?esq+DNwAVAkG9zQmpBrgYPOrlWixIVTSThFOK1ZJLcV+TxZW5ScOdwAoHZ5S?=
 =?us-ascii?Q?QgZ2ZHotOd2XyEF/Cxb6SNh+GLA93eYWXaoQ1gwEu0Z5i8SujC5iy45DKgOf?=
 =?us-ascii?Q?g/JoaVcvGL3b83Vxhl3KhYiA1R8yrKr1TvWdtKOqYIlqGA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PseQpGngzQKWU5Fy54IWaFblU73nX8XGB7GmR5p9wsgUkcP39dxsN1XY7dfh?=
 =?us-ascii?Q?8wtMDxPBPJX2Imi5YDljXz0pL9QA84xbSrCuirjz4T+xkm8KsTsdU+xwKHsT?=
 =?us-ascii?Q?xmYKrQYPEWk43IR14V8lIn8/4MrJgjeEATiQjPYLwffAjjf3PrNaJmFlVTQK?=
 =?us-ascii?Q?8La/XkbdfCayVui8Wem7drBm6bmpiSD0XMI9V/4gmg+IholfA7c2UugPtkBA?=
 =?us-ascii?Q?r5NHD/49rt6vGu+6DOkguxpcENPa5WcgW6Taxoq9iI8Avg+5uLLwCQdGpysf?=
 =?us-ascii?Q?oUQtrNEmuwf2UsQDrjaeooO0Wp94AsLiAvR8WzIIZ2krvhzQ8YOpVC2hrFMu?=
 =?us-ascii?Q?E3s/dXGq1F2m4W0V5iT3EW58d+MZe86rIyd0u3VnByN6N6Dua7tVx/dUsrUu?=
 =?us-ascii?Q?4EII8qneKKlzSFqdtTmkrIo6BJI3jeMfxDNrFlFsIk7A/kPDz4pF5yzTKo29?=
 =?us-ascii?Q?qbHSMVS7A83sDy7sOathxwnhs2uqbESsvNwqJUxGz72W7EmqIbY5xAvctBWc?=
 =?us-ascii?Q?CuplvUEWPgLTSRL5juLhNYf0mu2xxUU7ntjC3BxcL7NA8bh0c2XWttgqod+6?=
 =?us-ascii?Q?/G+hurkHtcHKu3OkEoILB2vOypwNm7n9ZKDiPJBLdheTfuS0GIFcoUlsaGE0?=
 =?us-ascii?Q?yYWdW+tfg0hbDn/J8OrRbvDT4DMtzIj6TeamOD1gqudFGeTLXgCQtYgUcjYQ?=
 =?us-ascii?Q?SiNpR6rmGkkOJUJCymypQHqcOHnA80KAdnWJ9xS7wGb1fz8RlrQx6Y87az8M?=
 =?us-ascii?Q?d5v0p/SJhaMc7FuuFic+muCTKO/NMQRLa9qttQA3BMuadLw4nJQuDb9Jtp6Q?=
 =?us-ascii?Q?mi5xXnVe+WUto3j3kBdeeltkuvY3T06qnndkAggY0ysQCsAAirvep16wa8D4?=
 =?us-ascii?Q?EZ1AkrkBQEQL1ey/lsx9smpwkwBPLwONB9UxisCePKKSRMA+bbn0B8LZC2JM?=
 =?us-ascii?Q?MO7FUZ3vOEW2GHNYP7X5CLvtsAg1vH+VRua2/5xw8LEw5kggDosbPH4YX8mh?=
 =?us-ascii?Q?q9LBsM6RgU8E621nuSJAz3oMRnQDVzVZXf7/Rtak3Wkx+kRr6ksGfwOhAnuN?=
 =?us-ascii?Q?AkTZuFSL7Bi/xwHbc/Ogpu4AbQdX8tRIaezKhrd+6OZWFKiRQTpzBbxphiKh?=
 =?us-ascii?Q?KPHMcDV4OvIvi11WV2U0lADsLK6nJtVFRuw0xOgKskVLJp9+dym6G30r66Fv?=
 =?us-ascii?Q?7618L54utvcqwcXgjLajaHXHpCljOtxHD2rBN8HFucEcs7UdYx7kp8iAY/To?=
 =?us-ascii?Q?3q2TtsEFQoingowGNDIbExLT0za/ItMaT0pI970TMHEYckt8iqux5w2hZo1S?=
 =?us-ascii?Q?R6BW5LorqQtbtO096PoABTJkwrhHJasysk8S+RvO1mq1WEt5nhCC+Esx599T?=
 =?us-ascii?Q?suaDuFBU2esAppYcVb3Ll3O3mMbzprT1Ggcpg+zibroC47ZAjr1r6JPWYQnK?=
 =?us-ascii?Q?QzQWGisa0xo/FNEkDA/wtGpXegb+L3tByJIJN4OAtHovUih1gwGGYuqozR6f?=
 =?us-ascii?Q?WN6sKmG41N6rwgQd6SKLgxKm7Xi0zrYurxR3pohQWLmGpZeRcJVjayRAJUAj?=
 =?us-ascii?Q?DnPxPDOyZwSRIInS23bNiIei98oIHYwg9AZ2ZWAc73FkOQsj52XiULrnBCCw?=
 =?us-ascii?Q?0kbQgCOFTi1gTkja0kdtK4HE4BTgfi8wCdj0Kchi5zfM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349a7b6a-a68f-4f5a-dd29-08dca4d48aa4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:46:34.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHj9QYsCDWKoxX/ZkCR5gTS1dZ1juK+KahNC/ynA+Uoodgsyx0Zn+Rk7zqJDsqZuNv+p9HKqbn0WWs5ZwrMFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 13:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16495

- Avoids using a busybox losetup executable that
  doesn't support the "--sizelimit" parameter
- The "--sizelimit" parameter is needed for introducing
  speed-up of disk reencryption with the following commit

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partit=
ion.systemd.hook
index be8c117..1e8c74c 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
@@ -47,6 +47,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep no=
t found"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found=
"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not fou=
nd"
+copy_exec /usr/sbin/losetup /usr/local/sbin/losetup || hook_error "/usr/sb=
in/losetup not found"
 copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cry=
ptenroll not found"
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/syst=
emd/systemd-cryptsetup not found"
 copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm=
2_pcrread"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 72de5b6..3497d95 100644
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
--=20
2.39.2


