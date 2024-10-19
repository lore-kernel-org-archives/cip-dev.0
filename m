Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB06D3E1BC
	for <webhook@archiver.kernel.org>; Sat, 19 Oct 2024 07:12:11 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.64])
 by mx.groups.io with SMTP id smtpd.web10.2206.1729321929952015033
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Oct 2024 00:12:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kckXh/1E;
 spf=pass (domain: siemens.com, ip: 40.107.241.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrc6iwJFgZz7C4C5t/5fzhlZsHmE6CIJbz3UwUEVZCMDXRJXE9o/kPCPKudxA3qMWoNt0oGLss0axw1ypE42+fOCt1qp1FHoY4vPn2Up7yOkNB7FTN3NbjaVZwYOLcawKMVnzy8tCQHOXr9ceSn33Q00zYTMcMrEYpYZl1VfShMAUZ34Wh+N7VpormkCpRZlzMIxvjttZuI3aimnDjgReamQPoLr3Z5I8n0Ens0K+Gjo5pN+zpjVJaMNO3pOVBa9m512CXCjcL5bX66qFjdkBiRPwkTarFzQxXP0Dt1R4zbtWhQvF6cLIxWPSiZDdnBdBP67GWtuKqM1vJRHVz+ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHJcGT0t/Fezn9XMP1dEpdvc6z7JoKyLsM/MRJHIv7A=;
 b=ieu06cjy60//2RtbWlPYIRMXl22knknNU9VLAMyki4GxR/kJUg4Bjun88E/8E82WDtCuKMq3Kv2KPfaR9jAhzDHl9M5gDoBs6Ro7qr8EJYjvlq7rwtO5jrsIGlCPkIEEbeQtEh9Lw4ee3VPUoRj5NWeihgKcmcqB9BC1zee+ZVuLlKZvfR97LBLRImoJ7ppuVgfXlqT9zRAhWJYkqz5KZToPqmQENPBRfLfHdacGo9TUgWGDw7aaHt/F5MFtYTSvK2i7aVUvNnFErURu8gwXDJ7am/0S7IVKk+UHRfxkklC0s5dKxW0Iz9ql63eKmAwn+BJ86dT3e7nOdRXAosa9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHJcGT0t/Fezn9XMP1dEpdvc6z7JoKyLsM/MRJHIv7A=;
 b=kckXh/1EBTvfM0xsoWvWFA1qRhIOVDddbs6XDqox2I4luuz0O63EzbxrmSV3Si5MXEVY5A2WejNepohLgTXdMn/qWomYuoyCauUHG6Y34/rVAN7XVctIUYO0UTTJjwL8y32h5tTxYVwmcZVrHxirvzUYSbwdUNw5K7GaGaSRUkPO08UhGbpPd3/W7097/Pm4f5qZfYod+mIui6YQjbRCpQkp5O0pcx/jw04dB7wG4pkkS0V/HE3Br3MX1X+wsi02MZM9WJ8EKlkEXpzoswm5FvLAq8UsK09oo5d4XddLYaAfYKTgakQGlEWalzw3YfQBTjFEgYIOY0A9Ihd5YF27iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.10; Sat, 19 Oct
 2024 07:12:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.011; Sat, 19 Oct 2024
 07:12:05 +0000
Message-ID: <d6bf0fe1-77b1-4726-8584-0736e006e430@siemens.com>
Date: Sat, 19 Oct 2024 09:12:03 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cfcbbf-1630-44db-c2dd-08dcf00d5612
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFlCamVwc3ViSE0waFI4QnNtWllEQ201cjhncnE3ZHpvMWJSeFJ4dGhpUERq?=
 =?utf-8?B?VkZFMVlYMWRXR05VWHBWbGYwcDIzSEY5TjZyMUZ0RVRRSkhHVmNLZTduQ25K?=
 =?utf-8?B?UWlpVTJ6MU8weU5QZnpQRDl5aEVsMW93Vk5TanNMVHRKUmVUTW14YlY5SkVq?=
 =?utf-8?B?TjNGM0xXOHhZUmJDOFFRK0gzYyt0dytxMy9TTWdhc3FLYy82SUFNM1pBTSsz?=
 =?utf-8?B?TzRFcGpZTElhMkF5YVlIczRjME1aUUF6MGxDQU5Pa3lkNmFGWDJYL2V6VWJm?=
 =?utf-8?B?K1QyaXd0LzkyenJXUzk1QklxbTBqT0dnNW50b1ZNWEZjUmVqM3ZyTlFhLzBr?=
 =?utf-8?B?azlFa3duL25XYy82ZlhoQkh0K1NzZkpvbEI4U0hnQ2tTakFyNHhiWGJpemto?=
 =?utf-8?B?dytURzc0UWxsZFJqR2hNMmw5dmRaUStURThCdkZnQ1JmaTMraFpJODRTZm1Q?=
 =?utf-8?B?UGdScGNucFhNR2I4U0NUVXkxRXN5dDJZMHMzbDVxVmlSRnNpYU5TZHhMa0F3?=
 =?utf-8?B?N3d3MGdSenlHWVlWVHRLdmV0S1ZzVmNYRU9CSWx3bWJzQjh6OXRNRnFPOE5y?=
 =?utf-8?B?WHQ1azB5L0lxZ2tEWFdxUm01TjRsd21VUXB3aEljTDJIWHBTajIrLzc3bnVs?=
 =?utf-8?B?MUhMZG9JS091dmZWOWJpNThLTktFM0tJaitjaGpKdFpwUDdaT0h6Q1N4NmVx?=
 =?utf-8?B?MFJkL1g0RHgySDN5TE9tdDloUUIybXI0dW1iaE5rNWp2ZDRIZ3M4YThGK2Rq?=
 =?utf-8?B?eXlxOHptS0lOaHEvM09SUXRqREYwdjJXODhYUWVRWmVweXFvN2VVMVZHOFZ0?=
 =?utf-8?B?UUtIcWliTGRUK1FlVkJQY3ZTY0NzTEpqeTJIZTNLVi9mVnFpTGl5REtzMkdy?=
 =?utf-8?B?SUR2MWQ1bWZYSm9kMlBhaERDK0NSSE0vNU1pRGtRRnNJaHBqR0Q4T2FtUlY3?=
 =?utf-8?B?bUw4T1NzN21Pc3p2ckFMWjAyajY3N1ozWk0yUXhQNjhzaVU1Y1RzQSt6Y3c2?=
 =?utf-8?B?L2dYQUpVbThYa2k1cjhhOWxRV25BVzVMK2drUXYweG1ROEJIN0ZkdWZBS0VD?=
 =?utf-8?B?NlplT1lmM1BMUDBsRVhGWGMvRjhjamUrOGZhU2Q1R2p6L1VOenpLT0c3NVJj?=
 =?utf-8?B?M1BWUEg3cTNnNXIwa1RwaVBZVktHR3pta2FxTzBrNDhzbGcvaVZDL2xCbTZ5?=
 =?utf-8?B?ekF3M24yS3pJVXh0Z2hhTVh5dnoxT1UxTzRNM3c4eEY0VEdrNldLZFBqemVZ?=
 =?utf-8?B?MUZMNTJvL21BcUVaM2w0cVZ4R1J2VnVoTmx5dkdiN0szVHVURGVMSDFMMzY3?=
 =?utf-8?B?bkNoNXZEVDhMaFhzUzEzZWwvd3g4TDhtMUNwV29OeXVOcmZqZ3d6SmNJZ24w?=
 =?utf-8?B?WmhLbHNQdlZDeGoyM0ZjYVAyWWJyTUZzcWN1TnRJeGREQnpWd204d0N5aUJs?=
 =?utf-8?B?eHAxODJOcFVqZGRKVnEyRC9XY2JkOVc0dXJvRzdMbE8yT2tLMGQySThIaTRW?=
 =?utf-8?B?SUF6a2JqSEMxRlovTnBaODYrdGFRSFJJYU1IN0lNRUNDU01FRVZjakszRmNp?=
 =?utf-8?B?YnBVeGJ2VWV4OHVyc3VYcGt5QVRRVlZidU5qdkVjTERWVEVTYUdFYy9yMk5j?=
 =?utf-8?B?Ulg4VXFTNitObkxubVQ3R1pqcTlWQXRWOXVqcFB3UlQ2OXppM1ZXSHJOK2ox?=
 =?utf-8?B?d3YrWXNNUmZXcU9MRGthZWtCQnJiUlpyVGhwbFErLzFlVWRHb2YxdUk2QXVZ?=
 =?utf-8?Q?6c6zaggtV6DzoiVruxv1eWtrYf/258aU3H0zvUS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDZWTjdNMllFYldtUU1EMGI2eHdQNXNTK1VxQUVFZUFDQnMzT29WcnFDVHRq?=
 =?utf-8?B?Umk3K282ZWJNZFU5WkhBZU9FS09vV2h3bjRTMVpBQXF3dTZaZXNzbUJybTAy?=
 =?utf-8?B?Tkx2VjRUVG5IU1NXRENnNHlUZzNuMWlGaWxmQXprYytkZ2ZzMXdjcVZkSTU1?=
 =?utf-8?B?d0dsTkJkOEV6OFAreWNzQU4yWUVEUExNYmdkN09hSTVrUUh3dEpKZ2FMN1pm?=
 =?utf-8?B?QVNteGIrMUloSWFyLzIzaG5uSXZZRWU0YXYvazRJVXZONThWd0t1Vks4cWpE?=
 =?utf-8?B?Z0cyV2FzN1RJMGlaa3NiT01jS3JmQVpZVWhqblVndzU5bmFZVzU4NjYrc1Vn?=
 =?utf-8?B?eHFpcnVqcGJBRlBua0E3NEZJTHQ1T3VuMkRGemtJL2tkNFFPRW5GQzVKQmUz?=
 =?utf-8?B?WHZoOS9Na1NvVVFWZno3cnd3YnFJOG5uelFSRlhhZmpEVC84NWdndEVHMnRL?=
 =?utf-8?B?ZzZ2blM1KytDM2Nka0xkSm9TbzJFWE5mbVlWUU1pU0kwcGxVSkxUQmxZTk9U?=
 =?utf-8?B?VlZVRW54U0xnbDd1NGdKOUhOdGlpOG5rVXZmdmZCR0U4LzNiQnl3RTQrcUtj?=
 =?utf-8?B?dlFKYm8waXJ1MURXV01mVE1IOE1BMWFxNWkvdURnaDZUQjZidDZqcnBtT0VI?=
 =?utf-8?B?OXl0ZDBGYy9sUlh0bFNKRnFmcDFwL3lkdmZQSThpVFd0cmF0d0JORUxQeDVB?=
 =?utf-8?B?a0w4TFlNRHByY3ZOUEMrNWc1NWJxS2pITUVOcmlyMlhZYk9hV0NnNWFadnpl?=
 =?utf-8?B?QjVjMGdra3pnUGNsbkZPOCsvRTJNV1hWQVlPY0VGWGswRFVzSktzN0NDRzFV?=
 =?utf-8?B?dEhzdGV4VEVhSFYydDVLRVZYN3hnZ3NSeVZuTWpUSzJraVRlWnV6Sm1WaG1P?=
 =?utf-8?B?T21wM1JqZUtvYU05V0dIbm1TeHZKVTlOSmVtYnFzWWszRjFZR3dXWnFJaldm?=
 =?utf-8?B?Y1FvdFN3Tzhwb0dSOVNpOEUvaEhLcmpJSk9vNkNSM28yUGpYS2VzaVdHb21v?=
 =?utf-8?B?Z0k0YmR0Ly9hanZDWVZkZnNMVk84STlUNWhTSVloY0hESEQ5TVRPYmsvZ21S?=
 =?utf-8?B?aWJCZDRRT2NOYTlsYnpkVjl0VmhlUm95eHhRc21ucmMvZVFUQXNCcGhpdDVM?=
 =?utf-8?B?Sk5GL2k4M21OQ2VIS1VJZzV0TUFNSUlVcmRvbkVHMk5ZRFN6MGx3S2ZxYlNt?=
 =?utf-8?B?ZmtEM0tLUGEwNm1xRWgzV0hNUDNOY2pBbXJXbDZNQy94a3orM3lQR3RQZ3Zx?=
 =?utf-8?B?UHYvdzA3RTBEajdNbWxXWVJpeHM3UlFpN280QTVmc2xZUzh0TzlnTnBuMFdy?=
 =?utf-8?B?UVA2Qno5aktyTnd2Vy9EcW5YWVhMRTFIVWtNOHNUYlpES2hRQzVZMXdXYkRl?=
 =?utf-8?B?Y3E4a1Y5T09VU1RmTlJYei8wY3FlVlpKWFJEcE04ZUI4U2s4UkZiU3RmblFR?=
 =?utf-8?B?cnFsY1plZXAvM0RMaFZDZisycFdNSnVQa1NQTmNzVW14T0dkZlc5dm5oRXdm?=
 =?utf-8?B?MnA5Wkw5Mkg2WGxlUTM0SE5JRzdpNElhb3ZmS2J0V05MOE1DN0Z5YUluejBV?=
 =?utf-8?B?TjhCOUlLWnBpVW5sTEYyZ3lpM0xWQTdSdWJFa3I0bzl0ckdWbCtLeE1lOEFm?=
 =?utf-8?B?a25tYklQblI0N1U1cnBNaTdZb0IveTh2Tk5ObmZCSVIxV2N3TzgxUml2MTNO?=
 =?utf-8?B?cVJKWE9IS3RIYUova21sTnN4dWlxSlhsY0RWSytUVytkL1NSU0lhVjF1YVI5?=
 =?utf-8?B?MkdVb1hHeFkrM3NYNWp4QmxRS21FSktvMEdsa3hPTSthUVU5bVJyaDlvSHNP?=
 =?utf-8?B?S1RJTEJBTHVUb1U4Z3JudjBrRWxRbE5pU2NsZlFzb09ZNi9leDluQmpWTXNI?=
 =?utf-8?B?L3RiRFJya05JY0orVXBSUmk2Z1FYMjQ0dlk2aDFlTEZFRzhKQXRiaUd5a29y?=
 =?utf-8?B?amtoZlUzN2lTZnZJRHFqcEFRQlAvQ0xpS2NjSmZKeXRrVFZqN1ZwdkJ5Uk5u?=
 =?utf-8?B?WDIyMFFEeHJYUUZPQkxMZ0hlSmV1VXpzWVlBUHdvci9wcmVIT1BYY2hxZmND?=
 =?utf-8?B?T1hDNlhNZnFGV2RwNjJWdm4yQ1pIMlNNNkhtSXRNTk8vcTBzaStJdGhVWUh5?=
 =?utf-8?Q?a2xV9kP0srkHvi918Fazzxrpl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cfcbbf-1630-44db-c2dd-08dcf00d5612
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 07:12:05.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kyordn4zT3dZ00UMxQD6H5TIp4en/Z0CdNsxOqNeOSaNwR2HeioyzW5RNMJl0ax+s/4v8s+yZoU5JYft01jUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6398
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Oct 2024 07:12:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17053

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows the drop the meanwhile merged patches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...king-the-build-when-mounts-are-no-lo.patch |  64 -----------
 ...002-rootfs-Provide-rootfs_do_umounts.patch | 105 ------------------
 ...Add-missing-umounts-after-generation.patch |  29 -----
 ...ng-umounts-in-rootfs_postprocess-and.patch |  74 ------------
 kas-cip.yml                                   |  16 +--
 5 files changed, 1 insertion(+), 287 deletions(-)
 delete mode 100644 isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
 delete mode 100644 isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
 delete mode 100644 isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
 delete mode 100644 isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch

diff --git a/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch b/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
deleted file mode 100644
index 8e650445..00000000
--- a/isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
+++ /dev/null
@@ -1,64 +0,0 @@
-From 84fdccc3223d31bded29dd5adf86948f6cf83e81 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 1 Oct 2024 16:52:26 +0200
-Subject: [PATCH 1/4] image: Avoid breaking the build when mounts are no longer
- present on umount
-
-This does not seem to trigger yet because we always have those
-mountpoints present. But if that is no longer the case, we will bail out
-when mountpoint fails due to the set -e.
-
-Fixes: 165519a7b314 ("sudo: Fail on the first error")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/image.bbclass | 25 ++++++++++++++++---------
- 1 file changed, 16 insertions(+), 9 deletions(-)
-
-diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
-index 0c162aa3..9d5b782a 100644
---- a/meta/classes/image.bbclass
-+++ b/meta/classes/image.bbclass
-@@ -418,24 +418,31 @@ do_rootfs_finalize() {
-                 -maxdepth 1 -name 'qemu-*-static' -type f -delete
-         fi
- 
--        mountpoint -q '${ROOTFSDIR}/isar-apt' && \
--            umount '${ROOTFSDIR}/isar-apt' && \
-+        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
-+            umount '${ROOTFSDIR}/isar-apt'
-             rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
-+        fi
- 
--        mountpoint -q '${ROOTFSDIR}/base-apt' && \
--            umount '${ROOTFSDIR}/base-apt' && \
-+        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
-+            umount '${ROOTFSDIR}/base-apt'
-             rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
-+        fi
- 
--        mountpoint -q '${ROOTFSDIR}/dev/pts' && \
-+        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
-             umount '${ROOTFSDIR}/dev/pts'
--        mountpoint -q '${ROOTFSDIR}/dev/shm' && \
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
-             umount '${ROOTFSDIR}/dev/shm'
--        mountpoint -q '${ROOTFSDIR}/dev' && \
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/dev'; then
-             umount '${ROOTFSDIR}/dev'
--        mountpoint -q '${ROOTFSDIR}/proc' && \
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/proc'; then
-             umount '${ROOTFSDIR}/proc'
--        mountpoint -q '${ROOTFSDIR}/sys' && \
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/sys'; then
-             umount '${ROOTFSDIR}/sys'
-+        fi
- 
-         if [ -e "${ROOTFSDIR}/etc/apt/sources-list" ]; then
-             mv "${ROOTFSDIR}/etc/apt/sources-list" \
--- 
-2.43.0
-
diff --git a/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch b/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
deleted file mode 100644
index 6ac2af36..00000000
--- a/isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
+++ /dev/null
@@ -1,105 +0,0 @@
-From 79155ddf156e073a98315bf2f35f7ca0f5ba3a77 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 1 Oct 2024 17:08:24 +0200
-Subject: [PATCH 2/4] rootfs: Provide rootfs_do_umounts
-
-This will be used more frequently soon to avoid dangling mounts.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/image.bbclass  | 28 ++--------------------------
- meta/classes/rootfs.bbclass | 32 ++++++++++++++++++++++++++++++++
- 2 files changed, 34 insertions(+), 26 deletions(-)
-
-diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
-index 9d5b782a..1eb974e8 100644
---- a/meta/classes/image.bbclass
-+++ b/meta/classes/image.bbclass
-@@ -405,6 +405,8 @@ def apt_list_files(d):
- IMAGE_LISTS = "${@ ' '.join(apt_list_files(d)) }"
- 
- do_rootfs_finalize() {
-+    rootfs_do_umounts
-+
-     sudo -s <<'EOSUDO'
-         set -e
- 
-@@ -418,32 +420,6 @@ do_rootfs_finalize() {
-                 -maxdepth 1 -name 'qemu-*-static' -type f -delete
-         fi
- 
--        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
--            umount '${ROOTFSDIR}/isar-apt'
--            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
--        fi
--
--        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
--            umount '${ROOTFSDIR}/base-apt'
--            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
--        fi
--
--        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
--            umount '${ROOTFSDIR}/dev/pts'
--        fi
--        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
--            umount '${ROOTFSDIR}/dev/shm'
--        fi
--        if mountpoint -q '${ROOTFSDIR}/dev'; then
--            umount '${ROOTFSDIR}/dev'
--        fi
--        if mountpoint -q '${ROOTFSDIR}/proc'; then
--            umount '${ROOTFSDIR}/proc'
--        fi
--        if mountpoint -q '${ROOTFSDIR}/sys'; then
--            umount '${ROOTFSDIR}/sys'
--        fi
--
-         if [ -e "${ROOTFSDIR}/etc/apt/sources-list" ]; then
-             mv "${ROOTFSDIR}/etc/apt/sources-list" \
-                 "${ROOTFSDIR}/etc/apt/sources.list.d/bootstrap.list"
-diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
-index f0abd795..ef40cbdf 100644
---- a/meta/classes/rootfs.bbclass
-+++ b/meta/classes/rootfs.bbclass
-@@ -65,6 +65,38 @@ rootfs_do_mounts() {
- EOSUDO
- }
- 
-+rootfs_do_umounts() {
-+    sudo -s <<'EOSUDO'
-+        set -e
-+        if mountpoint -q '${ROOTFSDIR}/isar-apt'; then
-+            umount '${ROOTFSDIR}/isar-apt'
-+            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/isar-apt
-+        fi
-+
-+        if mountpoint -q '${ROOTFSDIR}/base-apt'; then
-+            umount '${ROOTFSDIR}/base-apt'
-+            rmdir --ignore-fail-on-non-empty ${ROOTFSDIR}/base-apt
-+        fi
-+
-+        if mountpoint -q '${ROOTFSDIR}/dev/pts'; then
-+            umount '${ROOTFSDIR}/dev/pts'
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/dev/shm'; then
-+            umount '${ROOTFSDIR}/dev/shm'
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/dev'; then
-+            umount '${ROOTFSDIR}/dev'
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/proc'; then
-+            umount '${ROOTFSDIR}/proc'
-+        fi
-+        if mountpoint -q '${ROOTFSDIR}/sys'; then
-+            umount '${ROOTFSDIR}/sys'
-+        fi
-+
-+EOSUDO
-+}
-+
- rootfs_do_qemu() {
-     if [ '${@repr(d.getVar('ROOTFS_ARCH') == d.getVar('HOST_ARCH'))}' = 'False' ]
-     then
--- 
-2.43.0
-
diff --git a/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch b/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
deleted file mode 100644
index 0f2770aa..00000000
--- a/isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
+++ /dev/null
@@ -1,29 +0,0 @@
-From 78e8ecbaab9dcf887e46e52d220647ad838b4d4b Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 30 Sep 2024 20:46:50 +0200
-Subject: [PATCH 3/4] initramfs: Add missing umounts after generation
-
-Failing to unmount what was mounted via rootfs_do_mounts can cause
-troubles on rebuilds.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/initramfs.bbclass | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/meta/classes/initramfs.bbclass b/meta/classes/initramfs.bbclass
-index 6886b95a..42013356 100644
---- a/meta/classes/initramfs.bbclass
-+++ b/meta/classes/initramfs.bbclass
-@@ -45,6 +45,8 @@ do_generate_initramfs() {
-           update-initramfs -u -v ;  \
-         fi'
- 
-+    rootfs_do_umounts
-+
-     if [ ! -e "${INITRAMFS_ROOTFS}/initrd.img" ]; then
-         bberror "No initramfs was found after generation!"
-     fi
--- 
-2.43.0
-
diff --git a/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch b/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
deleted file mode 100644
index 2f6b9d09..00000000
--- a/isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
+++ /dev/null
@@ -1,74 +0,0 @@
-From 55d8292d600e1d29fdf3f7eecc36f7c2ad6b0671 Mon Sep 17 00:00:00 2001
-From: Florian Bezdeka <florian.bezdeka@siemens.com>
-Date: Wed, 2 Oct 2024 22:31:55 +0200
-Subject: [PATCH 4/4] rootfs: Add missing umounts in rootfs_postprocess() and
- rootfs_install()
-
-Calls to rootfs_do_mounts should always be paired with calls to
-rootfs_do_umounts.
-
-In case there was an exception thrown within the try blocks they will be
-re-raised after the finally block has been processed. This way we try to
-avoid leaking mounts but unmounting might still fail. In any case we
-tried our best to clean up.
-
-Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
----
- meta/classes/rootfs.bbclass | 31 +++++++++++++++++++------------
- 1 file changed, 19 insertions(+), 12 deletions(-)
-
-diff --git a/meta/classes/rootfs.bbclass b/meta/classes/rootfs.bbclass
-index ef40cbdf..c7011508 100644
---- a/meta/classes/rootfs.bbclass
-+++ b/meta/classes/rootfs.bbclass
-@@ -248,18 +248,21 @@ python do_rootfs_install() {
-     progress_reporter = bb.progress.MultiStageProgressReporter(d, stage_weights)
-     d.rootfs_progress = progress_reporter
- 
--    for cmd in cmds:
--        progress_reporter.next_stage()
-+    try:
-+        for cmd in cmds:
-+            progress_reporter.next_stage()
- 
--        if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "acquire-before":
--            lock = bb.utils.lockfile(d.getVar("REPO_ISAR_DIR") + "/isar.lock",
--                                     shared=True)
-+            if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "acquire-before":
-+                lock = bb.utils.lockfile(d.getVar("REPO_ISAR_DIR") + "/isar.lock",
-+                                         shared=True)
- 
--        bb.build.exec_func(cmd, d)
-+            bb.build.exec_func(cmd, d)
- 
--        if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "release-after":
--            bb.utils.unlockfile(lock)
--    progress_reporter.finish()
-+            if (d.getVarFlag(cmd, 'isar-apt-lock') or "") == "release-after":
-+                bb.utils.unlockfile(lock)
-+            progress_reporter.finish()
-+    finally:
-+        bb.build.exec_func('rootfs_do_umounts', d)
- }
- addtask rootfs_install before do_rootfs_postprocess after do_unpack
- 
-@@ -379,9 +382,13 @@ python do_rootfs_postprocess() {
-     if cmds is None or not cmds.strip():
-         return
-     cmds = cmds.split()
--    for i, cmd in enumerate(cmds):
--        bb.build.exec_func(cmd, d)
--        progress_reporter.update(int(i / len(cmds) * 100))
-+
-+    try:
-+        for i, cmd in enumerate(cmds):
-+            bb.build.exec_func(cmd, d)
-+            progress_reporter.update(int(i / len(cmds) * 100))
-+    finally:
-+        bb.build.exec_func('rootfs_do_umounts', d)
- }
- addtask rootfs_postprocess before do_rootfs after do_unpack
- 
--- 
-2.43.0
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 7e9ece38..73c467ed 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -17,26 +17,12 @@ target: cip-core-image
 
 build_system: isar
 
-defaults:
-  repos:
-    patches:
-      repo: cip-core
-
 repos:
   cip-core:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 36b04737a07baafc5af64cdc8aa61fad13fb494a
-    patches:
-      01:
-        path: isar-patches/0001-image-Avoid-breaking-the-build-when-mounts-are-no-lo.patch
-      02:
-        path: isar-patches/0002-rootfs-Provide-rootfs_do_umounts.patch
-      03:
-        path: isar-patches/0003-initramfs-Add-missing-umounts-after-generation.patch
-      04:
-        path: isar-patches/0004-rootfs-Add-missing-umounts-in-rootfs_postprocess-and.patch
+    commit: 8c9bdd3cb0ac93aa46552d4554bafaea5d1d7d13
     layers:
       meta:
 
-- 
2.43.0

