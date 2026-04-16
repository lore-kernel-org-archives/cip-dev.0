Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF196F8D753
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:31:16 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15680.1776349864213353104
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VEBI0g69;
 spf=pass (domain: siemens.com, ip: 52.101.84.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S52+PmeokVXepZ/kuXJbeAgxdRpYIRX2M/zzVYaMVTUr/sMuYLZUC22RNig9MX2hhI3JnjjfPtgScw8KwcqLOOwBayHpeVed+Cm2uRvl1Jhg/WXiWSmJrlP6nZf+TrqqUSNEDkM2tGFFjOVNNDeTxhDql2IMy6hWRLrzzXhnu4/PhoT/YTL+z2F3KbfErINOFj3tjQmV9iYABMXZk8MeI4KR5N2JaXq830M2nYgX2V6c7QG9/2/LPNBgi5c2XSnl3Lw82p+P4oKqPPASgLa/Jel0YJ44M+rp/95/7JxnyTlx3EDfuBQvZQph/NHW3SqvMZpC3jSA+YQ1sBjrW2eAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2BlNTMT1TgfjK1Cgp+U71BdnnFyXsyNH8BG9RwkOTo=;
 b=isgwbBPFWYhcOyC0uYrsGIDsgQzXPF+sfwau7wNUytg4Imp3HgsZwURfB+kax5mYXqGXmsiqt7MnQlj1ffurdyjsrX/WN2lNqsRQgyGMeXn/vU3vcTNFjW2XpTeHMglFb67xkByOcdll/Sefxm0bNdd1g6KT4eZ9k5VNbmHqHMcn+hNIzp6T8hfU1/DGIJSFlJp2VaNOi/vqyDpptJlZtcujWM1/WUbuUtyU9DVFh6xoQ14IA840KqFTE1ja7YLFGUjAEHrFFB3GCtW3Kt9jO+tpOzyrG2mctLzrtU0IoHi7/C3wnoEZa7VNdOykqNHkMrJtrYdeHBaXLHlh6wJFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2BlNTMT1TgfjK1Cgp+U71BdnnFyXsyNH8BG9RwkOTo=;
 b=VEBI0g69IpxvK0YSNoKO51ji6OTYDDM+Hg9yID0nVhh+Nun6wnSxkDsoeJcQHcfyx9MUWkAKNx2iRQHXu77YzgYLEEgbtYk1b3H7Fp61OoPmexE/foLxiIpCKTZYOwaCZz8ixDx1DFUaoZ1lNQtGTAg2appNb34yFfKl3nOWA08kaDHpP8cU+f8NDVP27ri0ly99rXLdtvLsk88CnIcGxFW6c55Ub3R0orjuKnPEB39AAMfDOeRBM7hYPLxbjMImCxZMM1WhT73gw8ITyaC9hnTIioAR5lBrcx7nSg0iTCruarxsWrAbBW0bSLa8y7ncemtwYNHKHPUb5y4PxFmHWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:31:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 14:31:02 +0000
Message-ID: <5ef1959e-26bd-4065-a2d2-76ef7998e43e@siemens.com>
Date: Thu, 16 Apr 2026 16:31:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip131,
 4.19.325-cip130-rt47, 5.10.252-cip71, 6.1.167-cip53[-rt29], 6.12.80-cip20
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e1b05c-3f35-448d-32d2-08de9bc4c95f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	3AWoX0Gu+AL4ZbvtPSfHCyjcvvgPo1ekvKVkqMV/GvEJ9DLm5whphmOcWs0XG5nNVtVWsQkaj9Yd0P9MiEGFAkIfHw2M+xlHKrv/w6jvqZB6qh+K9m3+/1VUTzPcohKP4WhH5X9nOjwihGt/Yb7QXVnrK+rvtC3KxH05UOCL1f037dSU3p3FgR3YTOFAlkMdRYJ08TG034r/oV0wIiHSZB64rWAHAj+bW3Djj27jB+7YhvsF21iJNIgDKawNSna3QWE8oFh1tXMQR7RABFSjIyeL8xvoI+4gI1MNH1ztl4n8vrzT/2bLlwPZlBtkOMG+t63PN6jXX72pq6rVGfjNY43wDrz1HL9lcNnHePY8iBZfeS/7htJzFkAXe+IEqdGd7v9rHaIefcYm2BG1nb7VXWqZbvRE5Gaw4f8Yww6TmNsl9nMRxm0QgU5AyqlU7/zg13o8WDW6fX8Y9Tc1DobOaaIkH1dRt44pvQgYe/gZ04tQHRRjnLlGkrwYg2NioLE5sWhw42tInXg1ya7uZBaDX9fAxXr5zTe7fvt3dcx5B8P+y99p/vtUiUKOuhN9P7dOMjgZCRfViEt8O112NkC/Ee4WvUMUU8IGmHzqapT/olCDETV3y2Oekea4mhme8A+fJNPgAliRHnLmMg0keRWwPbJpoko5q62XXTR3S0kw1ktNYpHtDpqr4EAD7CpSTbpGMLJgXZOhwhekTvzAhaaz1AF0PogOmDxD6MEwprbRe+M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXhKTXNmQjlCM3cweTRidmNRaE5IaitwS1VQZXJaVzJTdjhGdDgwR1p3QmtY?=
 =?utf-8?B?dGtSb0VoeVNDcE9uWE1pTW8xcFZpa2xKaEVWWEppVDdpN1AwRCtibVZsbDho?=
 =?utf-8?B?ZWhQMEFZWmJJVGNtSTU3U2Y0dUhVazlrR1RSbEYzR1FKcytKN2U2dDRVRlZX?=
 =?utf-8?B?NXIvMXhIa2dkUDlTYVM5eFE1VWVwM0NaSFZJL084YjNLblpEQXR5RU9nSTVB?=
 =?utf-8?B?VS9jTXkrUkZtOHBjOExrL3Y4RGNIVkNzMVBHUG9XRzk4N2lubWxHcVNUWFEv?=
 =?utf-8?B?OEl6UFEySmVpVkFqRVlBNGlhMzhxQkRJZVh2Mm5KTW9NOGp5MG5rTVc0TG1h?=
 =?utf-8?B?RzlXb29IZjBnUFRTb2R2QnkwZVpYS3V2SHo4ZXpyQUVxcnpZc0hQdHBYUTFU?=
 =?utf-8?B?Y09JUUFwczJ1REZERml0NkxCUzRBQmQ5eWtMK1BQSVhsS3pKbGoydElVU0No?=
 =?utf-8?B?c3VNYWwwdmd5bURydno4Y0VVWVUvcmkyaStuNG1rcUg5MU9UbjBxRkkwVkhn?=
 =?utf-8?B?c3N5TzhmaWsxWUcyUHk5Y3kyaSsrSjQ0UzJYc2Y0QllyY3lGTnJjNXJ1aXVG?=
 =?utf-8?B?TVlUbkZFc2JyZkExOGg1UUJnNU52S3FGVVg5bjJkbytxM2p1Z0w1cmRhWDJp?=
 =?utf-8?B?VTBRNkQrdW5DOWZvT3Y3WEhEUzZ1cDBRZzhjQVg5RklKTlo5czRLUkpic1hD?=
 =?utf-8?B?SzkwTzNBSkQ5NVV4K2tySGpWcmlnNkg0Ymtyb2hUT2x6Q3RCNEl0bWt1cmVQ?=
 =?utf-8?B?OXhvZkZxa2ZDWDkzV1RGdUJ0Rm9GQnNYTFlGMjBDMHkyKzYwcGdDTzFQY3po?=
 =?utf-8?B?eG1Vc0VHeWVYTTMxL3dVK3JRQUpJTEM0dk9BV2gvUkphbWRMeWs4WUhtTkM5?=
 =?utf-8?B?VnVxRjJ4R3NYMHc5WE1YQzhjaWR5bnNYeTRYdmtBc1VrTjV6ODZZNlFhVlpP?=
 =?utf-8?B?cjNPN1p0Q3U1b2ZCVXhtejBvNmFWcXd4RTVlaEgrRGMvZGlZTGJyTjZMNGZ3?=
 =?utf-8?B?WmVGRXVTbE9HYVFmZ1BXVjdBSjJWdUJqOHUzZTBKdWRpam1hRmFQdzN3YXF5?=
 =?utf-8?B?eUNXM0FMbnZiM2N6Q2h6cWFnY3hPRkNmMlJMZFdXZ0NOTkpUaG56VldXOCtC?=
 =?utf-8?B?NjIvckNvY01pNGRya2dNMzR2dVdnYUovaEJQOExiNStzQno3enhFUis0eUE3?=
 =?utf-8?B?QkE5V21EeDNlZFp0cVNrQjJTNjA4M25UNkFkdmo0YjBJUkYzM3FXaXpYTS84?=
 =?utf-8?B?SXQ1YUJlSnYwbEU4cGx5Z1l2VnRYWExndW53TFBUclIydzVjRUZZQzJTT2dM?=
 =?utf-8?B?MGJlS3JMWWYycWxOOWZ3Q3ZXYjk5Q0Y1UmRyVC9MbnhCZC9XaWI2amdGMmFy?=
 =?utf-8?B?UzQ2bUpBbU01eHBzOWpiUTRWcE1GL3lSQWQ4cyt1c3loOERQbVFRaHlnK29V?=
 =?utf-8?B?OHpwOWRmZzBpaExPMTdyTFVCS0dCMnhucktDbXpKVGpWVXp6alJCYXZPTVoz?=
 =?utf-8?B?cXBjK1NweFdpNUI0cVZ1QlhkTFF3SWhWUVdjTm15ZlMzWkxuRytrWGRaSk1R?=
 =?utf-8?B?RDh4WVpIS0N0T0Q0TzNHWmdZbEtmZlg4alpES2dkdSttQ3czeHk1QWR0QmlV?=
 =?utf-8?B?clhHVmxCaTBsNHpyekNHR3BqQ3hRcUNEQnlHTVFZRnY0ZFdDT3NDNFk2OTZD?=
 =?utf-8?B?dzdRM1J1TUNFOHJNaytRWkh5VHNUU0NpT2piUmhsUUdNRnJWQWdGaG9HTFpO?=
 =?utf-8?B?aEczOFpoNTJIaFNZQjVuamRMZ1craTEvNTA1MFVIQUxTbGMvZUphaWh1TW82?=
 =?utf-8?B?ZktqZERwK0lHVW5OLzN2eXlYcGhaSmRWNjlhMUhtZjVlaVdnR1RBS2NucDFC?=
 =?utf-8?B?Q3BhdUxVd0tHaG14Tk1FYVNienA3THBmWEVDcGF6c1BwcXZ6enhUUHpPTTgx?=
 =?utf-8?B?RWJTajRkR25YUzZmNVZ0dllneENHY1BTUVNjZll4NDRnWjJ4WEJkWlloQUlG?=
 =?utf-8?B?TGNFUWpKYW5pcC9vUHpPdm9uMjBVVE9oR3ZoRFFhbWR3L2V5L25VTTBvcGZt?=
 =?utf-8?B?UHdKbndFd01nVU1wa0RxT1BISW5UY0RVRUlXSTBWcTBjR1gvMnBKQ2kyK3RT?=
 =?utf-8?B?VmU3SkN3NDNncytvcXY4dDBlbTFmd3BzeEtCbzgzOHJsZVpOZlVCeGxQcUFm?=
 =?utf-8?B?NGpRUnNGR1hvWVFRa0s3WklaWXdCQS9GTVJzczJlYmM3Wi83UWZoRi9GNEts?=
 =?utf-8?B?QUxubEM0d2hsbC80U3d4OW5GTU55dVFVMCtBRW5ic29McWJQMUJ2a0Y1UXlq?=
 =?utf-8?B?TXRNN25ubDFhcnUwT3lKSmEveFhrMEFyQTZ0ZjRkV1lXdFNvVUVDZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e1b05c-3f35-448d-32d2-08de9bc4c95f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:31:02.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF5oFz4vyJDfQhOs6IjRyA5s5moxUl6ohLTW1Qr7MuQVvJTZ4Orq8OS9THi1nQFmnmOJ/6QExaJ4hDgg36vk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:31:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22744

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip128-rt46.bb => linux-cip-rt_4.19.325-cip130-rt47.bb} | 2 +-
 ...-cip_6.1.164-cip52.bb => linux-cip-rt_6.1.167-cip53-rt29.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb              | 1 +
 ...inux-cip_4.19.325-cip130.bb => linux-cip_4.19.325-cip131.bb} | 2 +-
 ...{linux-cip_5.10.251-cip70.bb => linux-cip_5.10.252-cip71.bb} | 2 +-
 ...-cip-rt_6.1.164-cip52-rt28.bb => linux-cip_6.1.167-cip53.bb} | 2 +-
 .../{linux-cip_6.12.78-cip19.bb => linux-cip_6.12.80-cip20.bb}  | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip128-rt46.bb => linux-cip-rt_4.19.325-cip130-rt47.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.164-cip52.bb => linux-cip-rt_6.1.167-cip53-rt29.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip130.bb => linux-cip_4.19.325-cip131.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.251-cip70.bb => linux-cip_5.10.252-cip71.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.164-cip52-rt28.bb => linux-cip_6.1.167-cip53.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.78-cip19.bb => linux-cip_6.12.80-cip20.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
index 797fb2fd..4ab07e35 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip130-rt47.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "0539a3a10ae010acb15803832986bc4a6cf403b75a6a289f9e045679add7f216"
+SRC_URI[sha256sum] = "15950e3c757037ceaf02d19f64519618fa7f1119905e6f975f7ae3658c1d5b6e"
diff --git a/recipes-kernel/linux/linux-cip_6.1.164-cip52.bb b/recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.164-cip52.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb
index 8a044e8a..52a2b585 100644
--- a/recipes-kernel/linux/linux-cip_6.1.164-cip52.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d2ab87160abf545624e34acf5fa908325b99f324f9a4b1d4fe23f2f33389768d"
+SRC_URI[sha256sum] = "a9066c102875e05f34fa9192d87f204f5ff3f5a237fd0d210e3fe3179a5eefea"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb b/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
deleted file mode 120000
index 683ea576..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.78-cip19.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.78-cip19.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb b/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
new file mode 120000
index 00000000..6d9f41e6
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.80-cip20.bb
@@ -0,0 +1 @@
+linux-cip_6.12.80-cip20.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip130.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip131.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip130.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip131.bb
index 83a9877e..3f6fc67e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip130.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip131.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "756cb32219556daa2c2e2f87718c3ea4e561cefa5224e178810a58d542187349"
+SRC_URI[sha256sum] = "02a5a31d21ce3edcc2de6b012df98dbb9ac60269ef2e35a214f0fd47e373df62"
diff --git a/recipes-kernel/linux/linux-cip_5.10.251-cip70.bb b/recipes-kernel/linux/linux-cip_5.10.252-cip71.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.251-cip70.bb
rename to recipes-kernel/linux/linux-cip_5.10.252-cip71.bb
index 63c6716f..10ce1733 100644
--- a/recipes-kernel/linux/linux-cip_5.10.251-cip70.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.252-cip71.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "c4553da39c63f299df7c9b86294fc821afe28bb623bf017ed72a76f47d96c134"
+SRC_URI[sha256sum] = "e98481884e1364406b217b320ba8c0bd15f534b71831ede2e505ffa95e1f946b"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb b/recipes-kernel/linux/linux-cip_6.1.167-cip53.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb
rename to recipes-kernel/linux/linux-cip_6.1.167-cip53.bb
index d73e90da..a332dfa9 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.167-cip53.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "db608e0a9cdba7acd288f8fb3cd4dbbac76feaa6a3d7adfb466b7b3033181a66"
+SRC_URI[sha256sum] = "9ea8ea5da3ec1c75b36210537d850cf41024655fca8fb412ef425dc82abc0b0b"
diff --git a/recipes-kernel/linux/linux-cip_6.12.78-cip19.bb b/recipes-kernel/linux/linux-cip_6.12.80-cip20.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.78-cip19.bb
rename to recipes-kernel/linux/linux-cip_6.12.80-cip20.bb
index 003487bb..15e2192d 100644
--- a/recipes-kernel/linux/linux-cip_6.12.78-cip19.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.80-cip20.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "059a3370bde268861bf30b76bd5ac6fa4869ec7d623f97a5a3c955c6bcd73d72"
+SRC_URI[sha256sum] = "851df39e8535f3cd60fbfd8500696abd704344288d7abcd7dbf4fb96b988ee3f"
-- 
2.47.3

