Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C499C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 16:56:55 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.62])
 by mx.groups.io with SMTP id smtpd.web11.11.1716483407889131633
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 09:56:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ly76uznE;
 spf=pass (domain: siemens.com, ip: 40.107.105.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu5IqiQPXYzU5dKdGsru50YMMNKYEq85Dn30wjeFXUFyGoR55c6EuKzEZpTJrDRkvRYdkKcyKhPH2TxXNDpPIpptIZxHz3JlcddZgJh8f4zCmRJqapkV94ah1TYnvxRqXiMAB3FiyYXmv0pS0WOglLIa/N09GfUqR2RcvF4/1ZT68MRMWFXE8DUzu6DKWoM5pm0KGcsX8thsCJqH5X5PR/hrHanxRjYO/7/bIUeWo3CBSMe3HPzoKLXxRadgdr1FJ3YGJSwcG5iy/s1Bu1+Eisg5vDD4dexVEsqzSmq0rJ+bHztzUI3XSMpLYsVXrbYaJD1BNk8TygYO41eoEJmgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhcaic44inSXeYi0dZciwtJ+oESZCtWtrT9TwQvX7qc=;
 b=f8v+5eWzgUZJ32qheVc7lu7pK76/jLycnNAaCpOecOjfLzpl+krMxin5EZcD7gPEBvHitqM24aQ4N+ZUiJG7kqp3hfoMGMn1JGfx7EPZSGE94ys552S4MV2LLqQJT/ei2yTUnS8B9Li1p3nzHHtwcGsUpqxWFCeBkqtheGcIH+oIm5yiJDsZGwyRIXeD9ZYKyVDtQMRa+ZMI9OtDjKcLBnZsanV5eTT5n5YBFNzNJ/6HF4vHbcHqG/G3+m8VJPicjmUU2Eux3LYRDdB4zJUbSxW0H5joDiUgUD8ehwaWBue5RvKhC7kKMizOUrNk6I3FLiqt8X51TKHca0D5O01YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhcaic44inSXeYi0dZciwtJ+oESZCtWtrT9TwQvX7qc=;
 b=ly76uznEWYHtnyQPQqwt+mhEIZHY8cLX43bgG7BKe47/g13eVqAfUyp4nwhs/fmob/GpCYLktwiDWKG4WbYHyM28SYZuPryeBc5Lt0u85FNlq+vwP+jyJ666UtBsBgJmdw6a3xDMIApVj0EFy6ZMbKMR+CU3vMTYmbmrjOD46xlfnyHmvDQyZ1tligqIvg6sAyHfDgJ9RHHXoYcgQYW8BPRyMRAmtHzrrLNThDen3+T3sgyPsjE/yzIqL0bgD7bqK60CZyneBHICx0oJ5rAx3ECg8HllnBjsCxY4RwxFlSaFXJVwA/aIvXio8MBtZDfnYt9R+JVNqVWHZrDY8q4MzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 16:56:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 16:56:44 +0000
Message-ID: <7eb6ec4e-fc57-4725-852e-1b1e1fcc1b86@siemens.com>
Date: Thu, 23 May 2024 18:56:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] cip-core-images: Make ISAR_RELEASE_CMD
 available to them all
Content-Language: en-US
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1eddae-b7bb-4a45-bac2-08dc7b4953c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWIvTDEyT2RIeUpCVGFjTlZJMXpsSFNuRDBPQWVuU2IwTnNGRkRyMEl6dlRY?=
 =?utf-8?B?NGQvTjgxcEdGYVYzV2dLb0NHZzAvSjNjaU5UYVppUHpTM0RtWkVkU1VnNEdN?=
 =?utf-8?B?REVFekpKUzlGN2dud3N2MnJqOFRuK2VLQmZvOGtySG11dDQ1c2gzOGpOM0ZO?=
 =?utf-8?B?emJUK01SMXVuUHpRK3V0Q2F6TkJxT2tNLy9PSitWTm00am5jajBreDBadExG?=
 =?utf-8?B?ZElkYk01Vm5PbGNtRGl3d1p0dzJjdzcxYUE2Wm4zeTdESUgyL1UwWmhhUkNq?=
 =?utf-8?B?ZmNGMmNXbHRYeEdiYWRkK2szblIyM21PbURQUm8xZVl5bStacWVYSDZkZVdS?=
 =?utf-8?B?WHQxQ3dlRmgvcE1memFXMHpjM0ZPaTYwcFhJbmVrRmM2c0lZVWdQbThaMlJq?=
 =?utf-8?B?R3h2MnZhamplTFRadnRQcFB6S0hoRzkyRjd1N0pISFQyenljUUxGSHdyOGph?=
 =?utf-8?B?NnR4UVJJRUpieTF0NWozZ1BOZExYcGtuWW5kc2VHcEVBVDF1YytpMjRmV3Yv?=
 =?utf-8?B?SDdnSFpiMFJ1RjE4TEdnZDMwZmVJSTh2dWNuQUlYTi9DTDFBRWo4WC9Fa3BK?=
 =?utf-8?B?dzMzVHVaTytEL3A2ZFZSVzRIdkJMdk4rZDhzeUpHeWRzS3dDSXBncTlZK084?=
 =?utf-8?B?ZFc4Q2RnejRQT2pRRVBDQmlCdlhGNExXbEhCN3R5QWtZaENNazgzY1JOT0k3?=
 =?utf-8?B?d1luTDVYWGtRcTM2elRWN25ndFd3S3ByOWJpc0pySmRpR0VYT3NRRmdLd3dZ?=
 =?utf-8?B?T0FkSTZjd1gzWHRySllxbVJ2YTYrNExTTlJDQjFIakttUzB1ZG9yb1B4c1hF?=
 =?utf-8?B?YXg0TzFGMGVYVHRDZzBXWGFHb0VhNnhIdSt1MkR1UThjSTBaVGZ5a24zb2Q5?=
 =?utf-8?B?YmEzK0o1bGVVaHk5ejE2OE11ZkFXM3JSQnJDeDhqeGtlRGlrTlZaQnVFc3I3?=
 =?utf-8?B?ZXkrL0tBZkZtWXMwbFRJN2FrdVBPbTUzQi83Q2puaXFDQUVYK09kQkJFSFZH?=
 =?utf-8?B?N21SbFpBUURLMVM4cHBUcWZtUXdSSFJIWlZKMTlrTUIzelBUSi9VTU5Ba3VY?=
 =?utf-8?B?THVsSmQ5VDA4SW4vNlh2b0s2WDRLeGlGdGk4d3d0R1k1MHJnc0kzcDIxWjl6?=
 =?utf-8?B?V0wxcVZkcEVqNlZWT2JOMmI2SkFwRUh0dE1zR3lTVW1TY3lGMXdvQys5VmpY?=
 =?utf-8?B?NkMzMFV1WUE0a1pyL1ZFY1dDY2JUdmsxZ044SzZiUmJwWk0xa2ZwVXN4SHJ6?=
 =?utf-8?B?cVc0V3luSEEvQlhHN0JqMlNvMGpNSkhTYjV1czlBdDdnQWVJMTFrV2tpd3NL?=
 =?utf-8?B?REtuOGZ0Q3ZpTHdDcEpoOTJZZ1lMU0FsaWt6K1lET1BUaHI4NFQ2T0hkMUVY?=
 =?utf-8?B?SVRrVWpNa0wvMjhwUVZKOTNERTNFTHdyT2xuTS9ZUXdtdkNvN216blNNS2Vq?=
 =?utf-8?B?Y1ovTHp4L1F0Nm5FVEJjNlpZRlFSVkZmUjlnRDMvTnJhRmI5aTBWV2g0SkM0?=
 =?utf-8?B?dGhjS24vQXg3NkEvZjdPR3NwT2x4ZEFtTEV2OU1od2tOakpneFlBNm1La3ov?=
 =?utf-8?B?SFpwNnFxaEtHek1iY0RKMk9MdWV0RmNRSi9SNExMaTlCY3NHbkdrdjc4K1l2?=
 =?utf-8?Q?rUIXykgiOPPIYXTlItlIfaaZyI9ETgN8v6wGWOChTLi4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDkvbVlQVkgybkZkbFVKREZaaWRPRzlIait3WjQvSktlejRsUUROMGhjYk1M?=
 =?utf-8?B?Mno0Z0cyN2hHeVgvMG5Pa3JMc3JKVmMyK2thRSszSkx6M1VWcW4xdGppZnZq?=
 =?utf-8?B?aW1PclJqcHFmdE1iWlBqbGxFeG9vbGRUSXJyYWJLaTk3WVRCS2ozamp2M3VV?=
 =?utf-8?B?TUFUT0ptczNCSTl3Yk9oNG9CZ0YxTVUyV2l5dnNxS2x6WFRzUVdhRFhDUXhJ?=
 =?utf-8?B?Njd4L0hCanl1K2V2Ymc3a1hYem1SN3Fid3JPVU9vRkUzaU9BWFV4YkJ4NzFr?=
 =?utf-8?B?QzhtVTk0QURLdVhsSzJaSkViNkdGZXprdENLTEt2VTNjQWd2dW5qcEowbm1h?=
 =?utf-8?B?eGV6SmJ2cmpNeUJBUlVieVVhZTRSUk5rcTBJZDFYNC9vU1hzdnQ3Rzdsank0?=
 =?utf-8?B?U0ZoUHRYNEg1cWprTWsxblVnY2U3Uzc0L2tteWxDOExVRVZOUUg0Tmtsb3Ew?=
 =?utf-8?B?WkZORVdIejg0akJIWE1NejVaNW5DODV5bGtNd21MWlZtWTNha0ZKV0N1bUZ0?=
 =?utf-8?B?SlRGcnlva2paNVk1V1hxUHVnM1hlWWtKNVVvVlpnbk9XZUlhWk9kczdEb0JE?=
 =?utf-8?B?cVd3dG5qMFNkTjJzMmZGZEJjb01Ma2pWT3R1TWg5SzBGTTUxVkZVY1J3OFNu?=
 =?utf-8?B?THRad0hZS3J6VnpvSHllc1Q5MUxqTG5xa0VPb0NOSExHdTFZaHlmNFZNN0Uz?=
 =?utf-8?B?czBDaElQN2tIU0RjRlhOR1ZFc1BjaWMzYWVJTDJhUEJJbW81S2VNOVBMRmRS?=
 =?utf-8?B?cVFtakwwQk5SK1l6Y1VNTmJkNk1FQTBiNkMrcGxKTEM0T2hIQ2NyVGtveGIx?=
 =?utf-8?B?RFhpcE1MOVNaaW5UYmFEYmZ3aC9tQ2hlQ3ZzSDh1VXYvYkZteDVQT3l0R0or?=
 =?utf-8?B?ZFRLKytKLzNscnBuZlFSSEpONU4zODdWVlc1VzRnUHIyVXY1a3RnL0RSaGh2?=
 =?utf-8?B?QnJtcVMrSFo0YTZqY2JSL09nYTBva1dOZUhJWE9sNHBqWW5QcE12RXYweWRD?=
 =?utf-8?B?SHVqK1lTSTlPZFBRS0xHazkvcS9kb2hIVmFsRXlUNnZLTlhFUTJsaVMycmZr?=
 =?utf-8?B?bk9SdWptUHorUDg2KzNMZEJ0aTcvQzBSMWdaM3VnZHZtWG5oa3J6RTNpUXh0?=
 =?utf-8?B?QWNyaVdWTk5TZmtLamtGNlRYRXZrWjlJcElOc3doeUJpNkFRZDVoaWNENm1a?=
 =?utf-8?B?alUvclorTFZCdmQ0NlZuV1pmTUJQT0VORGFhOExhWXU1NWtudVA2YW4vWGdN?=
 =?utf-8?B?a3l5WTN1Um0zaUE3YzhUUlViMFJOUmpGOFAxMFg5YXRXU2pseTlmSDZhUE1m?=
 =?utf-8?B?SnZPUmVyd3ZvRi8wSmRzKzdDYXhGWWxqcmNTU1FLaytXM1pKcU5UZGhuamJV?=
 =?utf-8?B?UXJlN2l1cmVkOFUvU2J5dlRSeW5lV1lOQ1hxUVVWRUp2WUw5SCt5KzBJak5z?=
 =?utf-8?B?U1lsRXpyY29Gd1UzZ2pqMThOSVFRaVNBVEhrVnhGdllCM3BFanAvcjdUa1Fm?=
 =?utf-8?B?ZzdDdnpTVno1MTdzVHhQK01lc1M4c3lOdXJwWVA2NkVFVFpPck00LzBVL3VI?=
 =?utf-8?B?NDdSMzRJREdBWGpjSDVjdmxabWhkZS8xa0JjR0lkOXdyNko3OFRCZWtpZUdw?=
 =?utf-8?B?eHBjOU1VaVVockUxVmt6S3JOTjlHYUh2SUlwbEJ1NEtiQlpEdzk3SkF5bWlX?=
 =?utf-8?B?M0RQVXBmTnA5blRwM0pQYTNiSlI1Tk5rdU1IQitXcWxyMkREMjlnSVl5U0E0?=
 =?utf-8?B?cko1QTNwMU0yMSs3Rk16Z2lJOFQrbk0zT0h3emFTRDUwdzgwSU53elFaZ0Qv?=
 =?utf-8?B?N2xHaHUxWXp2TCtBYitWcyt5LzBVbHNuNWZXWCtBNWNTektUczJRQmhObmJZ?=
 =?utf-8?B?aWdpQzF0L1JVRHVrTjhUZllmK3FHa1p2SUhuNmJ2Wndud0kzWXorS3hHd2I2?=
 =?utf-8?B?VVB0NDJPbzJ0RGRpMmp0RitXbG5ieERYMEZHWk9CQTA2YTZCZzFoWEJnVi81?=
 =?utf-8?B?cVozR3VBWnZNb00xemI0MWJUNDdESDZwR09iYWhLRkdSRWdyTlRBbFk0SnBx?=
 =?utf-8?B?dHgzSHBYRnFXeW9WV2Q3bVA3WGJKemE4Q1d3eVhnVUl6R2QxVVhHTmlGYVND?=
 =?utf-8?B?d2xBVXltNCtNTURGUkVTNmh2N2MzdHZyMXgvQWpIazh0eDA5ZlF3SHdFZEo0?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1eddae-b7bb-4a45-bac2-08dc7b4953c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 16:56:44.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPtxZrf+zcVDxlvMPxtnSaPEunMtCjQisI9T13UG8cIuMfaFfKX3ypCGfRaEctJ6L1/hkR5ZmSoANyfAY+0sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5370
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 16:56:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15938

From: Jan Kiszka <jan.kiszka@siemens.com>

This was missing so far and was also impacting the reproducibility test.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Here, e.g., are the reproducibility improvements visible:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6923388188

Still not green, though, but not longer rootfs issues.

 recipes-core/images/cip-core-image-kernelci.bb         |  2 +-
 recipes-core/images/cip-core-image-security.bb         |  2 +-
 recipes-core/images/cip-core-image.bb                  |  3 +--
 .../images/{cip-core-image.bb => cip-core-image.inc}   | 10 ++--------
 4 files changed, 5 insertions(+), 12 deletions(-)
 copy recipes-core/images/{cip-core-image.bb => cip-core-image.inc} (54%)

diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
index 479c14c9..849c0761 100644
--- a/recipes-core/images/cip-core-image-kernelci.bb
+++ b/recipes-core/images/cip-core-image-kernelci.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit image
+require cip-core-image.inc
 
 DESCRIPTION = "CIP Core image for KernelCI"
 
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 525a3464..eea50ee7 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit image
+require cip-core-image.inc
 
 DESCRIPTION = "CIP Core image including security packages"
 
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 0ec72208..4a9cea9d 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -9,9 +9,8 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit image
+require cip-core-image.inc
 
-ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.inc
similarity index 54%
copy from recipes-core/images/cip-core-image.bb
copy to recipes-core/images/cip-core-image.inc
index 0ec72208..7b0f7b04 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.inc
@@ -1,7 +1,7 @@
 #
-# CIP Core, generic profile
+# CIP Core
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,9 +12,3 @@
 inherit image
 
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
-DESCRIPTION = "CIP Core image"
-
-IMAGE_INSTALL += "customizations"
-
-CIP_IMAGE_OPTIONS ?= ""
-require ${CIP_IMAGE_OPTIONS}
-- 
2.43.0

