Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35945C41513
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:32:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.44])
 by mx.groups.io with SMTP id smtpd.web10.12257.1721298740012609024
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:32:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nNYwfK0I;
 spf=pass (domain: siemens.com, ip: 40.107.249.44, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeiDXoDuzABkfh0xjcVdWeIuHp0uD1jyyYlk1KE6ZQxtfsP1yHc7oesKwuh4vs5VvfKCegK8I0lvvqSgpytHtXFJ0y6JKlMw/0KgiU63Af8liCLsIOEVncRl+poJLAJkvIGVhj9VgKcy+XcHG6inUXrbuGyoLX4/cqpv0le6wvitF9C4jDyDgUkvk1iyGTV/7aZW7p+18fYl2kR8VovAw8BC7C5+MdryEvhNN3ayG9gmCXor8v/F8AXzOPCfwvXAS7dOs5DbcxMRosiaDb6iafB8OLj6R+mA0bwCdxqyLqPc+IyHNuIR9fcBL+5S9T9CcP7dtliZUFFEncw5Ohf4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=KY99/zTHFnxw2QRhMV9zrMdakjT9nD+TpHOuimVVxIs+NUii88r2ZVeUuPivUGV6WFVnCVS0fOBoPnPPc0FWkQSnTjI7cCtb4kO3oHuGTY2/QC7BAWFWnyLARgn05WMof4uAE2MHecYYk8GlFDqVbJBYIpIBXbTyBwwdK8JI3k5BwVefJD+lHnJBu4R0XiBbn+MZmeRSZUKXluJnR/DHE4vwxJPgn06r+kOnlz0NomxeMax7lYgTZt1Ka6eNIoZsBkd8pPDnJNPwMvreJJoyrM5VLwCuN58wggPflk/1mLyXTbNuoSRdY7dGMTOC3kWFWflcGiwdDAl7NdwRO5xgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=nNYwfK0ImKzkL8x40MJlN1NcKoctc0dJ6HmESWoi4CWT3iKDSmi3UUV0bIOVtgFCGk7ZXzWCoXl8XksAxoaKY1eiznfrE35GkCp1vt4Hvt541IGP4M2MA0qoFjMqMdO4CwUvvEBpx2meCBn6a4pe+k/bzY6wFU9WevwzrSGHAspsuf1bvvtN5952fQ3KLAq+DrpEYj8azNsMKK582kpnSZhIRkALtUvMWPO1pE0baC+AzhPFuNoonzqohP2bAKIvAfldVhGVjWSjjQHqumo2gk5JjMr6DnvQ5d7OKwC/mKaTbl6JkMhYMbD2minBm3wuCFH9Mnbi9elR6J8pItEfhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PA1PR10MB8389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Thu, 18 Jul
 2024 10:32:17 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 10:32:17 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 1/4] initramfs-crypt-hook: Do not attempt to repair a partially encrypted filesystem
Date: Thu, 18 Jul 2024 12:32:11 +0200
Message-ID: <20240718103214.1583403-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|PA1PR10MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab5dbfd-cfb1-4eeb-582c-08dca714e581
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9/AvlPZ68g1Xx8pP1wvc2KgD3f48uTxBdFg5L0zA7Mx7xqxHbzmFR7iXKdQm?=
 =?us-ascii?Q?iq9kD+kkLzzd5q2JkZI2WCc5dvnPsKOgxvQXi3Nss8TTEcqks6dgL/yrR/s2?=
 =?us-ascii?Q?ZNiQEt5Qz+blrJajQ/IQjbEg4BwU7CGwJJQPNtRJNw2giuI6V/xWPUhE0rzu?=
 =?us-ascii?Q?BdEY/aVOlbsLV6qsZJOHCQVsEGqII6cEU/jVD2Ill5GLbX+U4r4DoamHC9Ty?=
 =?us-ascii?Q?sFXhlTUHiGqA2hz5tPXaTJj0anIlh5XU4w0OgNPqJaOjNIyxAKqInUhYD52P?=
 =?us-ascii?Q?nPLI1Z8OLjiXCFi6AXvaMy1l5VsLDAoAzF3wUEilYBRV77C+spnEY7DGezCT?=
 =?us-ascii?Q?Fw7Nmz3HJjMBalKAXKP0VKwC5beZ7heax8w+Wn0OngLhf3JQ6+MKJZGFaK/y?=
 =?us-ascii?Q?pvpL21/wdjCfqzDhDnnXJWqV0YTx965clJXShTx8I5uDtsmyu7j+n93x8l0T?=
 =?us-ascii?Q?7XNJO6cEE9eaTXOF0l5ZSowCgHPYwl5IHGU/93ipfFSKEYg+ZF0nj1lR3lFl?=
 =?us-ascii?Q?kyUFtbrvuw1JgMZ2v5UdOoQjh5PyifEaGOe7uWBPzz4sqkNqbYl8BG11kpot?=
 =?us-ascii?Q?ZiUzdwU1QcDF/tNbpZQgMJsMSFLpxennh7trsV4FGn2XKeXzpUs3oG6x/Gh7?=
 =?us-ascii?Q?+iTXO6anjnHpQPqfWinNGtE/pKwI/UdaJfca0daIARTa0T92bdrkTSPNng2x?=
 =?us-ascii?Q?RF8htVH67hKkQQ30CUFqChuRRVqUjYgEaB+yq4YQC4jsb5hMXrvtQOV8Wlrp?=
 =?us-ascii?Q?aISiMjOCXFka3T/PjGXouvbCTxykrFVobQu1g4oPJ81img4eSrGTASrGb8S/?=
 =?us-ascii?Q?jmSfN1lzjYtsXi0WCSjO0euHd/4p+3rNKG4mQJNvQ6pxLq8p84tWGgeph8yT?=
 =?us-ascii?Q?esEei+oDgVWKR27NsgM4K1WylljlFvCvJx0P90uZkkhf3wr5o/plZBgX4K2C?=
 =?us-ascii?Q?/djHYimxi1rlTj6Ff0KyE7pYRtL/Lxz2QPr4g/ZXPQxTTmDZyr4f7e+XTIw8?=
 =?us-ascii?Q?IB5iIVDdftwT9L+7vRsGPctwYYtnLmGClSFJpGEh2GxewhYng6zaJVmUAJfZ?=
 =?us-ascii?Q?4Iz85+zSDOi06DCpSSemynmyvNpP/INeQwv5a6AtWOI4S8bJtBKhQRbJdMMa?=
 =?us-ascii?Q?Mod7sph1HMlUAtKgxWhEX53GruwJH3U1dyk9X9Imo/tQ+Z+7FEfw162+VIlj?=
 =?us-ascii?Q?3dAICGUTDliXxmlmf6ssM/7eKeWGpKh9/HSGhmAM21QBDkfk+MrEqWdEaxQ9?=
 =?us-ascii?Q?y/CiVwpdHWa77XF9Ju//TS/TJ+PaehEo6TE0IZv+TvdPrJiVsdoPWYUnvVSf?=
 =?us-ascii?Q?pbakKPs2CC7kOj34FycGTDt447awMnT2B0bXSOp74IYYpA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X/h32aEk6MoWUjc53YtZnJgvSWGJykBLSNfKiIT+7OVMLRTAnHO+qgW8saJ9?=
 =?us-ascii?Q?S8i2XfFPoutbyt/Euy8eF0PCDYdToWDqAR4RZOr7QU2rHr+Lbmo7NQZAJYPz?=
 =?us-ascii?Q?RPBbGhYL1GOsmexcL0NG6t2dzdM69KR9xYEDQTTDCL6PAI7nwGVVlA3vOnbH?=
 =?us-ascii?Q?VA8RNe2b3spCt4hpsqZ+UQukoLWzJmbqpWI6DM7K6wDLp9GiemlFKixuQ3MS?=
 =?us-ascii?Q?2B6b21hC1LaP8tE30PtRZVtFffnmeqBQ/Ug47BCej4Gb5mpW58ViG/LDWZv9?=
 =?us-ascii?Q?OMv5qiXWYAIDjBY5MoOW7VDPAijfYTp/i+fILgq/E/6OQgTcZCueb2Kpif6U?=
 =?us-ascii?Q?SsDmKnGiA7NqMpa6XdfOqWJlcZz+5EYXskxBGcWJwPIzxCTksv3KEcfNiRFK?=
 =?us-ascii?Q?+qi2it2cYGnCYutP4/HLkTEfhKiIiqd3sXKXBzdVhafcvJGnWo9OAhwxt7/w?=
 =?us-ascii?Q?gFc2Cj/O7iKcUMShVMoKJ0UlOWlPYfJnMKa/RkxDb+E1+2DrN0yb8n4vukMi?=
 =?us-ascii?Q?EHR61LronPkFWmmzOCzIfkNY5/Dzmv1dabN51ykwtRbx7XJjMFwfTI+nHMhd?=
 =?us-ascii?Q?4iQmIgv+7Z2lBm4IyqDVFvOeQ/3tSGcFk9pOY2GonDAnDyClSPE35y84PN7s?=
 =?us-ascii?Q?O7rq9YrcwvLYqg/ndurWDPWBZkH//7O2mhOIkJzfCSZXREab23KUYzf5lIGm?=
 =?us-ascii?Q?4qTcBqqnTuLMnn7tYQq5tfn7UgHzXkFqzNMfOSJZ/kKD/zQHcVz2yqC24HK/?=
 =?us-ascii?Q?QRU86POrA/SJI/EHGuhAkMIAGuqIFP9T3LHFh/2IeFn2ouTbGKaGD7z3ArVs?=
 =?us-ascii?Q?TaQGzEhrMmsVLVZFs6bXcOBWtJdj8Awh36KOCxiW+7Uk7r8ChVnwsbY/yfa1?=
 =?us-ascii?Q?TuX94Nxi81j7OQ+0zsQ2LhT2PVDKq6gBgNtIcJ3jeLd6iYG8lrZs3ZbXs1ab?=
 =?us-ascii?Q?NpBsjeLRqtjK7LbWSNUgrfbt0FjJ9XaSJL+wJkwXV0w6q+u/ckMhjf1vwwKc?=
 =?us-ascii?Q?mMTtlFVSysyLaC8PULI9Mx0DDL8uCo7n4zkXyLJjpmhBQqeECSvYsnNKTjVE?=
 =?us-ascii?Q?MciF+rcYCOmDSOj+w2JwlnnmbIqPwAfbboo4NbwrGY0VBh7KbfRQtnnG9lpP?=
 =?us-ascii?Q?Jt6KGgLeSCLBb0KdsFy1cH2BQnfC5LadiEwKeGX/o3Pdz30qJbBROilm9g1t?=
 =?us-ascii?Q?tcltr58w3bOMk02P9j5pFExpDswMSPhGOHOrepYrW0/Dg0iEbX7bxWra3ERT?=
 =?us-ascii?Q?TM71iLionfVj2nR1iLOkY38id1zJoZNx66fGTUOYqukZWZI8w6WHYKs9Vngm?=
 =?us-ascii?Q?ZBee93nIOFN8rmmogOLQJccgMenEgT27WMeK+wjgCHSWsSMotEud9SQxQnLT?=
 =?us-ascii?Q?kzymEC4ABayRu3+rIvmH4ex0KLwqaMOb2BcrQ40+1pHzH64WeXrqdUPyKaVF?=
 =?us-ascii?Q?CPQwrau+vealaPVL/TgOE4o9Q4Fo9TMb+gSubaON9NeDyKOxJH7G+HS+4KAs?=
 =?us-ascii?Q?m2K8+o2sjk493ae1OUwf6vBsM7tfv70zdebLifu07ccBRKT3gkqUYFXoLH2N?=
 =?us-ascii?Q?78rJfvfkahLTUPeKRqa2Imo5bJ+mZZ31fpDJwuCesQ5tgEBQymfbpaL0lbl8?=
 =?us-ascii?Q?ll/dEpY5L79UrDM5zWjb44F9BR/7Q5XSfsIO2B1HIFaj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab5dbfd-cfb1-4eeb-582c-08dca714e581
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:32:17.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr8FX5s4hZqykDVDNWKj/FxeehP9vd6skUgaT6Dtyj5tdy4/XMZMnnRlAm7IPNyAc4PJEj4gspd1oDB+5OZN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16579

Avoids that e2fsck will repair the partially rencrypted
filesystem after power-loss while reencryption.

In general, cryptsetup is capable to resume a partial encryption,
but there is no key available to unlock the partial encrypted data, yet.
The key is enrolled only after fully succeeded reencryption, yet.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index ff4c135..f943aea 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -77,7 +77,13 @@ reencrypt_existing_partition() {
 [options]
 	broken_system_clock=3Dtrue
 EOF
-		e2fsck -p -f "$1"
+		# ensure that filesystem is clean otherwise resize2fs will fail
+		# do not attempt to repair a partially encrypted filesystem
+		# ensure that there is no attempt to
+		# repair a partially encrypted filesystem
+		if ! cryptsetup luksUUID "$1" &> /dev/null; then
+			e2fsck -p -f "$1"
+		fi
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
--=20
2.39.2


