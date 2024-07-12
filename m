Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17874C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 12:57:42 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.54])
 by mx.groups.io with SMTP id smtpd.web11.7061.1720789051607481907
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 05:57:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fQQlj60K;
 spf=pass (domain: siemens.com, ip: 40.107.22.54, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtiZJZYEWI+/4I9Nms+csUIx0yMSCSuXJ630iujWWwNEckILupbHMem3SfmHPaZ5jc0/shiBIpK1vxwz9O7Oh5Htbrugcm2eixxDkcM1p6V0Zz2KuP2B0oisoy4Hm6sOCgAI/I08N67WycCeau9v+aTfbyqOlDKc1qGo3hM04e28ejy1kgg476wU1N7c1J5Dsv3wUGsXZ5SRC8mX0Ju0I2q44vC0laIleBgm2PjBXhgfBHvlNPtxWjlwJ0Iq0om3p/Mp0CIcU3Htywj6FDMx6+nP+iQYWkLqEPz7D4yWK3UXTwcdNp7b2nrmZmllbJd1wQqH0hDeJlspHNh14lsqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh23SGjVeAGUQ7fYmDH/4QReXYbWs7qDEPWCrtZ+yXU=;
 b=WzFx3FGXkqpgenrhuvxhGI5ha6Fg9rQDi5PqkXFNlF5V2VibY6G0vXanKNelaqI/RIxCbWmdWd/bqQDRre/zLTViNykaZ2OjTvjMwEnNW6uKKtXKEZ55fGbXVDMaYPVS3Q4GbDDm+mWIIy/5KYJH//Go5f2AFsSa98IvLb/fJmRzF/ifixG8xGGFzWmTWZSAsljiimjGuOYLkEsushSrAq1fGHex2cy/qOMU0SEOT6BE9bAie3C9kFfRu4Mia+tdJ2TgCdPS5XvQ1HeSOlk/+c/lNqRaxHSCc4Ta1gvP5Ij3hN47cHIM7kgEIY8XQfl1LIXK77+KQ2Xx+zeXhsbz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh23SGjVeAGUQ7fYmDH/4QReXYbWs7qDEPWCrtZ+yXU=;
 b=fQQlj60KMjmYfKZJ++nzzsOParlSy6SovEc1PiZH0sMrbRmoiJRlFnxw4f3CdGiHOm0CbNqUaW0U766aXNEeHK3nZX58k+IbEsUsLQX/Jpm6crBVYGXmQNMAz96wtZMmlK05ZIfGtJtWg6h995kqlT6yvsIpC04D0M0EqNbILmjnP/kKQZ/WQkfzlVtSOt+JF2ob2RzwujLuxtc8uHFMS92UTz0IpID1VMrELx/5/TLtQXRxJjj+9pOWUukO4lGMRdSv/QEI6KwqsXX9bTQe4QGINReUVfFKbPHdGzqhP+PSwHt77r1TJCsFDB6zsNVxUfutLCW5XU6H9FF8w8CI/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 12:57:28 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 12:57:28 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v2 4/4] initramfs-crypt-hook: Extend README.md for CRYPT_FAST_REENCRYPTION mechanism
Date: Fri, 12 Jul 2024 14:57:13 +0200
Message-ID: <20240712125713.2066512-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712125713.2066512-1-stefan-koch@siemens.com>
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|AM7PR10MB3175:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2dfb3f-c124-4cfa-fae3-08dca2722f56
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iEDbWgiOZexGIPqc3MjDKIrDlHJxLWn3Np82SUAeFdV1o4PWf396Jw67k4XY?=
 =?us-ascii?Q?SmOD9IysqbJBHHUhMsAdPZpfv5FMeMoUAUwkwqYBTGpBKpTn+9u86Ndh3aWB?=
 =?us-ascii?Q?imoPjTYLlRQ217aSKRPXaoJ+4AiqyAwwgefjmLftl3ZZxAYnEhhmFqPqe4r9?=
 =?us-ascii?Q?/og3QWyZIx7ECXg5NuIK8BRFNq4gSrDjnmlM5Jgoj70nkofOnMV9hjGFvi/Y?=
 =?us-ascii?Q?p7pSIxkFsfL9GpH9dKePVgDt5IXmX2Kn7qDFBANkSiYvE7TdR2e+MpPs7HAv?=
 =?us-ascii?Q?vkmd0x5Wc4x64TwD39Yc79SwfLp2Z4eae3hDAJ/5wydmjwfsIXxOc8J/xShE?=
 =?us-ascii?Q?gW51M/einYy2CUkEiL0D5fu0M4nztn/3NhDCPrzUF9jnjKg1kN11DXkFiBKB?=
 =?us-ascii?Q?ov5ThmlWl//hIu/53Pcew5Gr4XCCN9tZ+5nNQkrfQxcjRVdT7SL5GKOSpb1V?=
 =?us-ascii?Q?f0H83//GbiY4xESDdRb5ALvAvPTXUHwHVdxTYT5f4oRofctAmY/CFIdHZG1u?=
 =?us-ascii?Q?MPyozJrJpGvYJ5oDvJpKOUJXs5LUrpa035ys7ZoLKHf7O/v68oukqzVqf47l?=
 =?us-ascii?Q?jnzHPNsHl6uM8JQhou5UFCarGzgc/QvsLdXwF+SHFn6tQGvMeoimk+ILzbrO?=
 =?us-ascii?Q?IatVsxDhyHn3JGpYD8eBgFb6EIwv61adONH/HHF4y5mI31PbZC/25wp0HlKv?=
 =?us-ascii?Q?zS4vlsdhjB2woa2z0ETI7+2KP4E8aZrsNx0wuVQ7I83iBIM4x3S40/7Mz8UU?=
 =?us-ascii?Q?HdlQoW2HcSaMhvGouZKnUdLz1FTagm5yt890lIKWJoC9xSuAKOH3uSIGYZ2w?=
 =?us-ascii?Q?hIZzzbkzH5OipcWNFAqYat3BAJDiCe7OUV+MdVWRxE7gj6+1tM27rx73NWZq?=
 =?us-ascii?Q?SOskEvn32l8IOf9n8aQ+kndKKwbBzjd+y09tZqlC2mYE9uJvYZWLCAWPVPXv?=
 =?us-ascii?Q?8J9EWvqGlJazxS22BF+CqJ5rXsCIPmOX6uSS3cqMeNKwG+pLdpXZ885q6NxU?=
 =?us-ascii?Q?bP5ICUbhaKilTZVRAOH30JLNVNluikhdqYGiA4z+/c/B/a4HRjG4UwbBJVOM?=
 =?us-ascii?Q?YUvBe8YysfcGF2HZLhf/C4g2dKP25ulaOP2/9gVJKmSBaAEAcT4XDhoKNaF8?=
 =?us-ascii?Q?RH38eOmWagxXfshK0N3mio7Fpz+HnuuHea3iwoWOKn+Gtr8TjHOn4Lz5PXjM?=
 =?us-ascii?Q?zDDVrprW7cmnzhuP/Tifk4Bmw720xfk5jDhGFuosHOwUNMFOF40Ja/HBd0o0?=
 =?us-ascii?Q?XjFkLdt7pdrpV81RvSkwj0W5KHRu+R5vO3h0dpMIXW8l9R8hPPtZusLqtUAh?=
 =?us-ascii?Q?fJfHVV142ICBhhOtq1uEyJ3U4NzMBLx7xDv8T6gEY9XSeg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8wnXU/1Oyh2o7qLQ9cfy7Z8a2Ec6jmXJ7bAog4O4hVFZ25MUUDVLctUp2egl?=
 =?us-ascii?Q?5XPKU6KJX1MpNfIHjM73sdpMks5/k6FSjX6CabnssUfwt8WKiWrk8vLTFp5J?=
 =?us-ascii?Q?o8DzDCoLE741MmT3pcqVSKm4HjBCGNHUipgEiAG2ihanMTNUi7EO7jkXe7Kf?=
 =?us-ascii?Q?IsTaJQyj+JyrgJAzB6AryCH2Qd5OHlYhnWSoHcbi0548RwkQCq9IYOx28WGG?=
 =?us-ascii?Q?1W6HMM2yRLz0zuAhcPGqpcpSe4Pvmka/knuA/726Tp32SzGkFf0ISysOQzTM?=
 =?us-ascii?Q?0od+B3ASRJvt8+h8z10uPn5rqVZjCzAoeYddDZ8K6+VGzAbxqBOEwwB9BvT7?=
 =?us-ascii?Q?t98MtPHModP+PtHZsk/BF2hM5RTq+cQqczSX8p3od4eFUN5W6PYUVKmdKHs5?=
 =?us-ascii?Q?jhUXY2s346WQ9ZJnYHme4iwnX8wIdAReOs1Gx0EUFOxXSLGRqe/nCwJ6/h04?=
 =?us-ascii?Q?uQrt/6XxDy0VntwW99Rgwk0fgbIzGoZ/SilvEopBw2QuXFUKZ+SUWxZjVdp5?=
 =?us-ascii?Q?Mbp2m0SDYtxU9VrL6efj1Yc+WQ6Wt6pzLRdiYv1tCL2vZ9fnBdTb90Bv00Rv?=
 =?us-ascii?Q?SVmzeJvK85R1QnMi+4zccLoY9PN3FYnmVan+AXrlNxpHVqJhD3wLQmb0Y7Vo?=
 =?us-ascii?Q?RlLUMbWPueCpSpVjiJJfPGSnENhgxY3X3v7GFQFMIRmTWlW2yAjWdmc+cSTl?=
 =?us-ascii?Q?QsxFktIXnmneXBlpt14hW6dP2GPX5J7gX0dyBOhXaJD+IzW8zRGzAbtoh+Lt?=
 =?us-ascii?Q?Rj0NXcpMLOAzrChrnIpQjB/GSYE2dKS3JqIOyY22hmIQOyC3+B4V0ARx/EwM?=
 =?us-ascii?Q?dSCyc3SEuKCtMrcoDWOayi9c6L7emVuMdClo/4SJ1yuTTctZvY6XUCccQnHw?=
 =?us-ascii?Q?lPqpAcK0T8/VJnpCbg6SwyYOB4ym3aFh0weRN3N5ZsK7FFaiq2dQOgaSoTM7?=
 =?us-ascii?Q?TolMW1FYp3g0/G4j5nFa651nut0iMXtAn7OA5b/GS+G5n+akMLJutZ7tQdA2?=
 =?us-ascii?Q?vM2wpypvo1wpJ2XMeiryegTU1LJ4+QiKGccHPNz77WeMAsJGq+VQkT/5bqlw?=
 =?us-ascii?Q?zQpEi7C2K0aEMmxTnV48oz0v3TaEXt2Dmy8HtzGoVOI/KNhfrlUraCNii4xg?=
 =?us-ascii?Q?Ywo5mxvcgxMhxIiXIXzhdJh5x7MS8oMb9HwicQycqZscPFkrh0TqRZt7HnFn?=
 =?us-ascii?Q?qLTFhFoN44iuA94gWs+L1Dl3N9h7l7DOJ/PvzEP5BF92RbkiicWANncAc7el?=
 =?us-ascii?Q?qTIg/tLBT6EvbT3g2NfqC6j935vVf3PIerezk04Cjk4M4K1+U7khw5XadBsT?=
 =?us-ascii?Q?pW7/LE5v4QSPxE6LUPQuIXTQwO4r2podtrFaV4XvOQKN1fI0QyEgb+prGr+v?=
 =?us-ascii?Q?nwZEfz2J7jQkNw36BIOweBcrCPDSKkGs+vbc+ZVROU/79I1nMtMNT3wgZgsg?=
 =?us-ascii?Q?Kp4dROkzFPPdIy/AOAzpEVtnFfHlh/yGe6ieZc9bMiqIPr38ovVGCqL6prsw?=
 =?us-ascii?Q?c13r2h60EGs+0TDWUDvtvBEXl4MxgBokDGKCVQ6btoiveGfKYT2nriYXQ69t?=
 =?us-ascii?Q?YUtoi8nXCKjv+DQ/r9gMNxMEY+Eq+VS3OToWA7WNBKg+qfSI0WDo4vK5DPyg?=
 =?us-ascii?Q?Qz5Zuab6ojK5Pw9pX/Fo9HqLTH/DEXu3gGYk+m9QENkuam+DmY/Ey5/4pyyy?=
 =?us-ascii?Q?IboqVQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2dfb3f-c124-4cfa-fae3-08dca2722f56
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:57:28.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1bcbzXuiuwPC9xmCB4D2TMcO9Whv9RgyoTKTW1YM3+JILduiqxqicPvOoU/0OZNfO8Oud9v9q7OjxW9hdwfqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 12:57:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16482

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 doc/README.tpm2.encryption.md | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 3f7e89f..a1e6dd3 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -38,6 +38,7 @@ or by adding using the following command line build:
 The initramfs-crypt-hook recipe has the following variables which can be o=
verwritten during image build:
 - CRYPT_PARTITIONS
 - CRYPT_CREATE_FILE_SYSTEM_CMD
+- CRYPT_FAST_REENCRYPTION
=20
 ### CRYPT_PARTITIONS
=20
@@ -58,6 +59,36 @@ The mountpoint is empty as the root partition is mounted=
  by a seperate initramf
 Both partitions are encrypted during first boot. The initramfs hook opens =
`${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
 during boot.
=20
+#### Speed-up disk-reencryption (`CRYPT_FAST_REENCRYPTION`)
+
+As the `reencrypt` mechanism doesn't work at file system level
+so it wouldn't detect used and free blocks.
+This means that the block-wise reencryption process could
+take a very long time depending on the partition size.
+
+Using the `format` mechanism instead of the `reencrypt` one
+would delete all existing data (without wiping). This would be very fast,
+because it doesn't matter whether a block is used or free.
+
+Set `CRYPT_FAST_REENCRYPTION` to `"1"` to speed-up the `reencrypt` process=
.
+So, this would be done:
+- Obtain used space of the unencrypted userdata partition
+- Shrink the partition and resize it to the size of used space (minimum si=
ze)
+- reencrypt the userdata partition now with smaller size
+- Expand the encrypted userdata partition back to the maximum possible siz=
e
+
+Some disk encryption implementations like within the Debian installer
+will overwrite the entire partition with random data for security reasons
+(e.g. wiping old already deleted data, hiding metadata, etc.).
+
+However, this speed-up lacks the described security benefit of implicit da=
ta overwrite.
+So for security reasons, it behaves identical to the `format` option
+(there is no support for explicit random overwrite within initramfs-crypt-=
hook).
+
+Keep in mind that a power loss while reencryption will cause data loss.
+The key is only enrolled after fully succeeded reencryption, yet.
+So, no recovery from already encrypted data would be possible.
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
=20
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create=
 a new file system on a newly
--=20
2.39.2


