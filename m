Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249DD41C23
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 09:22:50 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.44])
 by mx.groups.io with SMTP id smtpd.web11.7863.1731489763520593240
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 01:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0DpPrtee;
 spf=pass (domain: siemens.com, ip: 40.107.159.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URxsdccz41gV6P7Y1OdgjizpDC8rWrgkxAUSU781nfI4AjrDvxRIFA7R6nTZLTyWAd1WH/oqiJ8rccBx1K4lUzkpSSmp7AGaqYcjX5K4USV0HDIjhK2lWnLK9PNz5SfLqnGGqzaDclZid/N01H7oA4+WQ35M+wLFPT8fT3NeEWf2dMcGQrLmKeyL7m6L1AKu0SP0EX4DZDDVnPhcXi7e4U5JN9Qs8DLOX9eJPxyP703zJIowce16+LZ4sZQ03TtYjbGg83cL02tKhH5NbVZjDy1RGP9awNOnRr/43Mm1mMtne+GQcVRe3swzRyXgNnGa0ohhoUqRYx8qmPAxiegPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=annGoS354KWIE2B3dMy0vnqDS7dilFEH9K9ROc/d8tc=;
 b=IxABbjvkrXVUizLBiMtkui9CKfop0CenyRYW0khUr6gsvwwZ3u0sGiqJ9Y9Go5PqBsJwYZrfZJ1KPCywdFkdWURBiOvLkKhySQVQSNb3F8pzBimFzslO5vaakdFo9ra/2CVF2m/H3JW3tW1RAiD35s33BA6f5G0/UmDP/wlPgBNWqQDy5HKydRuMf+FuNi5m3HvA2b49QtJdPENxX0NsOxATS9W+BVLQpYfGb9ST1KXMHqBsyWVphnivWn4T8QV4ClIvVrw1DfACv1tSJgTeW7G19wWG7UPx1hi7u+Zb1t0jCoXLRk4RQ8io04YwjCV+eAgvzscPlOGbfP5grvD5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=annGoS354KWIE2B3dMy0vnqDS7dilFEH9K9ROc/d8tc=;
 b=0DpPrteeQ6EM2PYxeoVfAJExoJmeSnCC6GrUohvUDW2w80hR0WW/9N86L+aGv6v/GtI54fzoMQS//n7VaHYlp+J5aBBbWFSgkoYPirH2TeR7fO+178pcbKHNYrpbn2n/9fbvP1peuBBKaJ1B2fYH5uIw705Lpxzi6yT3kttZ6v7JRHbE1dCjI+q8XcggaNBehqYczjzjIUiVL/VUHbLyC8+YYwIheG2NOhrD8WZXhWfYb9/eG4HfCiB39x1h44F1ulx1baK96DMSUOfTodJI3tRp08FJcvrv4K+4r7TddQB7tHOGiUDKJvq82qOcPnMdtvd9R4QMElAk6rwB80kgzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 09:22:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:22:39 +0000
Message-ID: <f7cd3b0c-bccf-423e-aeb5-5bf7036d3f52@siemens.com>
Date: Wed, 13 Nov 2024 10:22:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.323-cip114,
 5.10.229-cip54
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: efb24446-fb76-464f-62ab-08dd03c4b857
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N2hKamlMKzlOK3Y2bzB4NGtNcGpzdTRMeHpvMURtMUdUTlBIUjF3cjNGVnNQ?=
 =?utf-8?B?SG4wQ3V0WVpqS0p0Qm1mRmlSYnFDcWx2dDBpMzlMaEp6VjFUUGtKbmZCR3B6?=
 =?utf-8?B?NG9GZlk3VmpTeWZTUkl4RTNSSTZLa1NMUllRL044YklNOXJTNmROVDFBdytU?=
 =?utf-8?B?ZjFmYTc5OVU3dFNzeElMUnZmTm9MNUdlSUZReW9ZTU9WSWRVOThTT04yOVhZ?=
 =?utf-8?B?WVFqRXZSZkx2cnBOWEJvd1RzcG9DenV6VUZLZFN3aitINzZPVUlUWlZoZ1Bo?=
 =?utf-8?B?TFpYT1NzdjZRdmQ5QmZUZVM0cENVRkMrUlpsdnRhTTRtY3FoS0pIbTZoeVRF?=
 =?utf-8?B?NytZOTZyNFRlR1ZXaFk3blBKWEJwZXZDMHhKaHB0N3cxNUErMTlOVVZZS2VV?=
 =?utf-8?B?c1BONFl6YTYzc3k2NkFPaElyU2dMaWxrRDdKWDlGWjBrU0VFYktwNjR4Q2Zh?=
 =?utf-8?B?R0FKcnJaQWhzS1kxc2l2Y3d6NE5ROWZoTHVlZExVYncvR3dlMTI0YkFRdEhG?=
 =?utf-8?B?Ky9WRC9hV3JxSm8yNGJsU0VPeGNMMk9OdGdwNGZ1VTh3YU5jUFNzZHE2UE05?=
 =?utf-8?B?VnB2dVFuV0hPaGpaQ1ZwYXlnejNCdEswU1dCa2FKZjhOYnRLQ0xkRTRjZTBz?=
 =?utf-8?B?REJHR2RScjJuM2wzUk5VVlB2dVcwczB6OEs2V3dWWEhUZ1FPbGpFelFQZlk3?=
 =?utf-8?B?Q2oxKytGd2d1bFZMOEo4c0RFY28zNG01ZjgzRUxxN3ZsNmEwczZsMzl1UVRa?=
 =?utf-8?B?UTdhUSt5T1I4eHdYaFpoOHYxTXQycFdZaUtIWGJLQkltTU1ZUWZWaFJKMWtG?=
 =?utf-8?B?OCtTWVVRZnlTMkNKcmNBSFBld3ZwTHd5dHgzRVIweWVlUEpkeFlLbEJaU3kr?=
 =?utf-8?B?ai96VEc3UG1TZGNOZ1l0MXdaM21WQUlGaTFqUWwxbldMeDhWZnVYTHRKVFhZ?=
 =?utf-8?B?Q01pRkU2QmpmMGRRTThQR1FWazdIaWVJaWRkcnpKZ3pHUUw0d0EyWGpNZGR3?=
 =?utf-8?B?VVNPVGtqY3JNeVo2KzlETk1lTlVod3lpNGF3THc3ZHY4MHRzNWJ1anJMdGVL?=
 =?utf-8?B?SmpnQmFiYWo5TUJMR09UWURCWGhxV0hiOE9nVm5zTzM2TmFmVTFuNmc3dlVB?=
 =?utf-8?B?c3FQVTV5VEFqWWpRRGdUbklyUzhnOW5TZ1V2NzFqTXVTK2YwWW1XRjJmaFVy?=
 =?utf-8?B?YWdyd1ZhSEJrZEFLbTFrVWg2U2Q3ei91L1ozWm0wMlZaanZHQ2tjcHY0ZkVO?=
 =?utf-8?B?V3ZrYmNDbE9haXZ4QjNDbWFwTDhpS3dibHZKSmU3QTdDU2M5QlY4U2VTN3cz?=
 =?utf-8?B?YnRJNWVpcnZlMVNqQ1phbFdpeDFhOVBhckZzbDgvRnBxNEVUYkVvcU5McUVn?=
 =?utf-8?B?aHhkYkFOT1ZFMW1rZmY1aVpkUThCTlUxbzBnMW5YTFNxeGtRcFc2bmk2MGxm?=
 =?utf-8?B?NlhtMStyVTFYY2p6Y0l1V2JCZnlpaGQrRlpJTkVmTlFQc0xta0UwNzVIVkVZ?=
 =?utf-8?B?OGJ0c2tOaVovdjdoWWxCdUx5OHFTREJrdnJYVFAxaVFFQVhkN3J2aVRCR0pG?=
 =?utf-8?B?OTZ3b3FQOXI0N3p1aTdJT3pCeFZqNldmZnh4THo0VjlEMG5wTWUwcnhLU0NO?=
 =?utf-8?B?SDNJTks0a2k4TVFPclQxTXdKKysyWUlyNmpEQTFoak5ja1BQZTJodHRjY2lU?=
 =?utf-8?B?OEVUcWdCWmNGbzRhRDgzSVltL2txandVSm1YN204eHJtQU9xclJBVGZOQjIy?=
 =?utf-8?Q?equuH4cYEdd5YUpqCW9F5heMric/Lwwc0MM0vzS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFhVWDVtWE55SWV2L3NMcC9oYjYyTDNnbUt5WWptNFRoVlpZSXRmU3lhOTda?=
 =?utf-8?B?ZTYxZzRhM2RIbE82T0QwamhYVllPVFhHSDFlc0dWUUVKK2lFUWxQby8zSkxJ?=
 =?utf-8?B?VkNQMFQ0QXVnZVlkdE9udHhqaHNDcXhvQWpHY3gwSlZJS3hXYlhwUGx5QmFa?=
 =?utf-8?B?SXRIdjRxb1lDUWNTMXoxaTlTUjdiT1ZCNkZoMjVlQ0tMc2VGd3FHaXlrWUo4?=
 =?utf-8?B?OGVPNklVOU1SbzJ0d3RFN2pMUVRxSFRnSHQ5cnladmpSSFduYk0ybGZ4aDJD?=
 =?utf-8?B?RHFiNFg1R1gzSU1JNDJMTkRadFpQR21NQ0hQeE53bmlIS3ZCcEd0Wk15UVJT?=
 =?utf-8?B?djNiTG0vZmF1QXVsdjFuUFlQTHNZNk83d0hQNGROMHpJbVNBbU1IZlhLSVBN?=
 =?utf-8?B?emFlNkZ0OXpjWEZCcVVLUm1OZUxMMnJqQnhzY0c2azdrTEJ4cFBMR3dIdDJj?=
 =?utf-8?B?WnRPVHRqQWszTngweFVVdEw2bFFoNW84TVcyZ0I0SFRwS2tsRFdyMmpDV1VM?=
 =?utf-8?B?bURyRG4wL3hub0d6UDEyd3Q2MGNwN1d6THViVEI0RlBrQ0FVTTA4TTlYNXdX?=
 =?utf-8?B?bGZLVFF1QkVVYVJtTVBHOTVGNFRCdEZodEpXRC8yTGVjNDR2M2djd2gxRHo0?=
 =?utf-8?B?SGVwNG0xVGdkaUZJWnBNd0xncFQ4SGhFTm5aUHZaWXJLTCs5LzFzMXEwQ3hh?=
 =?utf-8?B?NCtNTTRVSURJZ0VZY0x1eXBRQkJWTytmWUZadjVhN1VheFZLTlNLRUtoNXli?=
 =?utf-8?B?YTJvZkZBM0QvZmhqeUhoaG5XcUQySG84ZEowbGkyNWxPZlhxZDcxZWpKY3dI?=
 =?utf-8?B?d3VBNXFydVFVNW9BNnl0TUlDNFJ3Uk51dzRURDRFSTBXYm9Cdjk2emlMZ0F5?=
 =?utf-8?B?aDc5WGRsTEQ5MXN0QXY0TGFKR0lkdVltbys0NFBlZldHaXRrRUNlMCtjdGJ5?=
 =?utf-8?B?TWc4cWlWZlB6TU9HWWgrZWVtVHdkdmh6ZjJxTnRDODR0QW92NVI4cW4rZ1FD?=
 =?utf-8?B?QUtUWXZiR00wZ1RvK2JmSFNOUXlodGpsZTRYbFRlY1orK3IrZmF2NitscEZp?=
 =?utf-8?B?SHpWeC9NekNQUUdxaCt4akxoTjZuR2RaTW0wd0hzNkJrSmRIcFdDOWFKb2tw?=
 =?utf-8?B?VUVtNWhFT29MZ0VzWVNPMVhoM0M2YUJ3bitEbUw2K05FdUQydFhuRTdsTHRh?=
 =?utf-8?B?ekxyZlJMbW5WL0ZHQUVJMGdyZTBBV0pDdHpuR2tWV0pCc3doUjVZcFpFWnlq?=
 =?utf-8?B?eW9FcThyamVKd0xiaXIxUWlZMVFxd0VNV2JpVGZHYmpBTTM3bUxXUmFza0ZU?=
 =?utf-8?B?TUJGVWNUNi81ZjJGT3ZaeFVwcmZpc2s3TkRRbjl2R1JPa3Z6UHlOVTdYMG1I?=
 =?utf-8?B?aUZneW83SEJCZmw2WFFaeW5QVHBYQXBObUpoWG1BQ0E1S1dsOEpiVzg4SS9O?=
 =?utf-8?B?WXZtY2ZCSXZHeHZxbHNOUzIzelJvd1RBK2RJWWVuV2tmQ0JyTnNTd3dPeEh5?=
 =?utf-8?B?UktmWmEzdEE5T3U2clBPZk42MjgwdmhvT1lMNmk5eUhaZ1UrUFRNbFF4WDJv?=
 =?utf-8?B?MEI2QlI0enR0WWMzaXdFN0MwTG56Qis3Y1ZEb1dVRkc3YXpEUzB1cjFZcUkv?=
 =?utf-8?B?a1VqYVZzRU96MmVOM0RLUnZwOFdySlIvNEswVkhoaC9jUlB2VWlaaDFzV2xw?=
 =?utf-8?B?OXJqOWtnV0kwbysvM1hlNG1hTm00T1hoc3NXQWtGZDZOOVF6eHF4bkhGNXRp?=
 =?utf-8?B?Q3hHREN2c1NIY2M4bS9UM01QUDRrNFFjUFJteUdsWFo0L2htOUgrYkxmZGU4?=
 =?utf-8?B?NUdJWDZVNzZVUVR4UUxzWHRESlc2UEhJUGt5bHlCcW5sN3J5c29RT1lMVFFt?=
 =?utf-8?B?bSswdFRJV2hLN3doS3RxeHYrekdLd3poV1M4MkI2Rmh6WXQzUVd2OTcyUjl5?=
 =?utf-8?B?WE9wWTZCeVVObG1FQ05VbDRtV25SeUJQNGVDcFA3YkwwUENCS0ZRZnZMdUhw?=
 =?utf-8?B?eFZ4Nk55Tm5obVdMZllwWjB5OGczSWppM2RtSDEreFZEalBHbUJ6aVp5aEVI?=
 =?utf-8?B?MVgyazBnUTFmVDlxcnU5MGF0YVVBbWJuTHA4bEhGRis0aDFQQjI0ajBFSjRC?=
 =?utf-8?Q?XU0IfxBg1XrS0Up68HssppR2Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb24446-fb76-464f-62ab-08dd03c4b857
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:22:39.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfSpR772K1IN/0i1MLAgRnZoxojV9nWfSqx4lf31g+uSXofiT+rvkcv578zYMIY0IK5uGeBxIiN9xTciIfAhrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6997
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 09:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17246

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.111-cip29-rt16.bb => linux-cip-rt_6.1.112-cip30-rt17.bb} | 2 +-
 ...inux-cip_4.19.322-cip113.bb => linux-cip_4.19.323-cip114.bb} | 2 +-
 ...{linux-cip_5.10.226-cip53.bb => linux-cip_5.10.229-cip54.bb} | 2 +-
 .../{linux-cip_6.1.112-cip30.bb => linux-cip_6.1.115-cip31.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.111-cip29-rt16.bb => linux-cip-rt_6.1.112-cip30-rt17.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.322-cip113.bb => linux-cip_4.19.323-cip114.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.226-cip53.bb => linux-cip_5.10.229-cip54.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.112-cip30.bb => linux-cip_6.1.115-cip31.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb b/recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb
index f424735d..483a8411 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.111-cip29-rt16.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "486d7c3dc921101a9ec29e829b9d31dd0c1f46533591c7ace572cf201939e2cb"
+SRC_URI[sha256sum] = "93f8d61b68d4e4b2d2a7f756e5e19839f320b539173f30874f2939ca8f37d39d"
diff --git a/recipes-kernel/linux/linux-cip_4.19.322-cip113.bb b/recipes-kernel/linux/linux-cip_4.19.323-cip114.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.322-cip113.bb
rename to recipes-kernel/linux/linux-cip_4.19.323-cip114.bb
index 61b3fb70..37101884 100644
--- a/recipes-kernel/linux/linux-cip_4.19.322-cip113.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.323-cip114.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "c968af618a23cce994806597446c1a40624b52034ce77c2879a5677af8de66c6"
+SRC_URI[sha256sum] = "c93bb88417e0a4e13db22476f0d77cd3bb512a78ec413b8bd1986fae75ca6e48"
diff --git a/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb b/recipes-kernel/linux/linux-cip_5.10.229-cip54.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
rename to recipes-kernel/linux/linux-cip_5.10.229-cip54.bb
index 59aed56e..b66b6a46 100644
--- a/recipes-kernel/linux/linux-cip_5.10.226-cip53.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.229-cip54.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d85672e4b94d54c9e79dc7f35942354efbb5b463ee6be067bf36eb220f187f02"
+SRC_URI[sha256sum] = "04c87684c909a11ce385364611d6dc22705edb66e21fa02836f930af1458914a"
diff --git a/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb b/recipes-kernel/linux/linux-cip_6.1.115-cip31.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
rename to recipes-kernel/linux/linux-cip_6.1.115-cip31.bb
index 870e0601..46944a8c 100644
--- a/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.115-cip31.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "70681787bee6c1057d002b440e3682656306aacc723ebffeebda1bf41da47882"
+SRC_URI[sha256sum] = "a6661d623c565feacadd3702f5bc6b34d76db0cb47122a7d7e336af46ca262a7"
-- 
2.43.0


-- 
Siemens AG, Technology
Linux Expert Center

