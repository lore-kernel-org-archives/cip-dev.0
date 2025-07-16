Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F9FC83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 14:21:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.48])
 by mx.groups.io with SMTP id smtpd.web10.23561.1752675708899974883
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jul 2025 07:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xJJXNXXB;
 spf=pass (domain: siemens.com, ip: 40.107.162.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqvRuX+YrCzhImerjEaiDRZW4ySPD1sNyR+fRes1bY/qx/3CIS5udhComKQpkrySuKH6Bg64x3SXT1Qa09MqKmXTtTqNsGCZUFE4K223nZUwjOJ5KK5iM89HyW/6a9ncdQxsV3uPkH6hWnFFs/RYybQMiwKrc9AOL/yXxj91+I+NsF3k9wDt9u5Tx8cpHCjMFMY28xch3kOmMJngcBKpKfKUgOzpQ48LG6dKDizDtnKs5v9zONc9MG5DHC8qW13vHHp5618b2DbAFJOGfyP9khjI/4qTUgXft/fqO4/SHjX73fqLvDOPpb5EYJkfP+vA1u1yiqioGIngS93ne4y/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs6J3ad1qevpx8ZfnqGYv3uTJzKFsIBT0tzzRWE7ek0=;
 b=Adyb5z29n5jE/p97zjJdejde00dRoaLzZgr1I79zMuSKrJOpa30CXlkq8gtxirBcAbuVYBmVX6z6SPRe8h/mhgB9wpzQ4L9v5X4vzbGRpTGHQcYshKje4yFWENceF5SHKBV6Lw6lY7ufOmYKJMRVZ7eSTN7VUStcNeIH8bjE4vvk/lv/jasrjzuL+sPsdTzS/lmE6eW1A3CNjO8Whfuqm8U0DvM4cFpuH6f935+izu8c84s2XvlDnna2kzy4XashLrgZbVSswxQa+XSIT2nU5Upc+ixeZDvnl+k45F7IeSfb2yaQZkHeeG1R/Hku8EANgDfAkqPzNOwzheGGn2zXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs6J3ad1qevpx8ZfnqGYv3uTJzKFsIBT0tzzRWE7ek0=;
 b=xJJXNXXBE1mF1RZMZTJa5ZYJwlXnlkTkIUrPmsoEaZjpm16D1qQzeaKHBuuR+5GU2YFst0CSxPC5LJEo6Pz0WCHRpzHXUgwrT6qXB/x2dhGgnnhGnxIkiOyZb5PHlfDXFPjvQSetiuVmJXOhu3pqYmJsjsIp+kpnAnCFhMJCY5kVAhRCnV5NRjo8Dq2VA6MQR40fbbEuvLalheaPWTQbihSi1BFTwRLGqZAJhmDXhFnIPHjsBqUHdEZ76XE2yN18mGBj5BjEuT87b4r1De7L0BAWAG4Gml4JJ/7WnPOkf5ZyEm4MxYzCPiHbU7KpeKe4xwWS5Wgi0HKChS/Kh8HxUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 14:21:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 14:21:43 +0000
Message-ID: <09a15fdf-852e-4850-b192-d5c98ae74041@siemens.com>
Date: Wed, 16 Jul 2025 16:21:40 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.239-cip62 and
 6.1.145-cip44
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0067.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1fa1f8-4b19-463b-2791-08ddc47416e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2pubCtXYnhUMXQ1cStkODVOaGNQNjFsTThEbFI5TGszSWZkSW5vcGZLZmxK?=
 =?utf-8?B?SnZPclg0NmJqUEJva0FMRUVqcy9RV0pYdXdGWlg5aGZRL01iMnRNVFJnc3ht?=
 =?utf-8?B?Nit3U0pJT3NKK0p4eEhEMEE1TEVocEwwbjFoY0svZm1UYlZlbko1RStXS1cw?=
 =?utf-8?B?ZDA5WEdZZ3N6ZWIyQjlNMlE0eVEyUVdkYkJUYVA0Vzd4T1p3dk0zcXdVQlVl?=
 =?utf-8?B?SFpCNWNMRHpTZ0F1c3Jra2NrRnFRNVJxRjdRSWZIc3hkSnAzanU2WEtMUFhs?=
 =?utf-8?B?amNSWUZuWEdEcDlaSXJsVlo2WSs2VzYyajlZcmIrcklGWGw5QzVrNVZqNloz?=
 =?utf-8?B?MGlKT2xwUGF6TjZGbi9aUE8yOTdPR1FXbHEweFI4ZTM0UDk3QXRSeWNVblNK?=
 =?utf-8?B?Ujh5VzdMQXBlZnRTWW5NTkZwUkxZZmdJQkpBcmJrc3BtWWthN2lObHRhT0FT?=
 =?utf-8?B?VDVrOHRhNyt4R3JLRlBMd0U2azY1QmxmeW1Zajg0cEhrWEFzT2FIeEZMRWYy?=
 =?utf-8?B?ajdMc1JYQ2xTZTFkUFV4NzVwSlFHZS9Jd29mU2V4SlR3YnAydktCdVYwSkJo?=
 =?utf-8?B?ZUUzS2ZJL3Rqci9lMDNjajN3UUlxcGpDc25NdUJPWFFBVEVjSU5HY1Z1RWVz?=
 =?utf-8?B?eU5LbGhFRGRUdzVZZWpyMlRvcW5XQ0hGSS92aVFtWktTUTR4M0dzVGhDdzZr?=
 =?utf-8?B?RlZCcGZZanRQU0xlTDVRWGpwdEFNMWoxcmZZUEhYMHROYWVHZHhhQXprZlNk?=
 =?utf-8?B?Rlo2eU54SVNuRURvdElDYU4xVzdwWDJZdUZOalRVZE04UlAvOUYyanZhbmdB?=
 =?utf-8?B?cHh6VlFhTkNUM1dMbGY3RDhDY0tmK0NUQkQ5dGZ4YjJGK2IvMjV3QVBqS244?=
 =?utf-8?B?WWF6WVl4bEN3MVYvcVNneEFCQ3ZZS3FEbDgvTjhYUG9hY04rbkJyZjVpdjVv?=
 =?utf-8?B?UUF5TzVQZG1pcnBlZStBS2lxcmFSNmxiOFVhU3k2UnpBZWQvbzNMNzNDVjFN?=
 =?utf-8?B?TzBNZFV1N1BRbFNGTytMMVRjNTJVdy9BZ0JwMGRFbDc4cmVsWnBONHRna1lZ?=
 =?utf-8?B?dUtEam5PekdST2RkZDBPWW41ajlKSmZoU1k4RlBJNW1KSzlHRmNqNFI1eDRo?=
 =?utf-8?B?QmxtSkRkRU9Ieitsd2wweVM1UzVaVGl5VVlkUERBTXdjbjAzL0FIMmRsU01E?=
 =?utf-8?B?cE54NDBEelV2ZUJSdExoQUhTM2gwV1N2aU1FczNhbzFpK3hJRE03VENqa1E3?=
 =?utf-8?B?OGwvZlF3d2Z2OGhrRUE4UFhMbktlVFlKUktqUnFLbUc2YnVuSko1MlBCMERh?=
 =?utf-8?B?RnpORzhlZHFkTEtWVU1mNitPbWhqOXF6dWQ3U1pXbnhyd1ZlYU40bnBKMUlS?=
 =?utf-8?B?UVU1WGgxUjNNb3RSZTVQWVhiRWJvNTluTU9vN3p6dTNyekpOS1N4Z292YXpZ?=
 =?utf-8?B?N3dzdlNtelI5VllkOVN3TXAycXFIMWwzREVubE1tL2ZGbjhVa2Y0ZXRUc25J?=
 =?utf-8?B?Y0dhckU1bVp1WlJTRktWR1lqc0trWmxFYjcvT0YydmNwQVNNU0liODlsS2V0?=
 =?utf-8?B?cDcrNlBWaWkwbzlwNUY4SFEySitjcXRLeFJudXlSTHdHa29aMGFuSW5rMDla?=
 =?utf-8?B?K2I0NG1MS1dick1heWdiZi9wMytOMVZQRnIxYjdjeW9lL2RjQjVVelBYUlc4?=
 =?utf-8?B?ZXdlb3JrMVN5WGxaSVVnbERWaVV3dWM0blcwYm1LSzE5bjc5ZVZQdzFZRUl1?=
 =?utf-8?B?cXdUZmh6NUxmSmloZkU2SEVwZGgxS0V3ZVRSVm80NjhyUCtOR1kwdEh4cGFB?=
 =?utf-8?B?UjduTXRFLzEwRFFzNTFWSEdBUFV2VVBNbnRRMTJsTXpkOHc3dktlRDdWaFhT?=
 =?utf-8?B?dXQ5cUZZbnpWbEI1WmZwYmhrYk8va2tycUF0N2ppaUZlczJSVW5TcTl6RTNx?=
 =?utf-8?Q?VOpTeOoo2SU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Lzg3QmloazdmTWI4bEw3UWN3U0FRL0xLbHF3MW1uMGxxVDBUb21vZE9Rbm5v?=
 =?utf-8?B?R0E3ZVNVOFgva2Iwejd6NW43VDNuaFpIRlBaVjhsRkFzVk52dzM5T1lvRXRv?=
 =?utf-8?B?UlRpZldnOVY0eGZJYnlRMi9VMFFvODl6cXRZTWYrY09raGE5WEp6cWljd2lG?=
 =?utf-8?B?R01vMU1KQ2MyeGVSSTYydHhpWFFrZk1HemJ6SmhuRGc0aHBwTDFpRFNmRU1R?=
 =?utf-8?B?TmVDSU5WbVhHemFSTXo4UE9yeUd2dE5EUnJkVzdneHZxcEk1US9zdE9BNEVn?=
 =?utf-8?B?WUxEeEowVll0UXRBc2dqRkZJUVVESGw4M0FSZVltVnpyT1JOcXUrRGNyYjZ4?=
 =?utf-8?B?T3h2VjhaM3R4c2ZLWHlRWjliUEtpdzBEUTFXUHU3dXhTWHpvSWJsRDV1MVBn?=
 =?utf-8?B?TzRIcXkyQ3BvS2pOUjMranQ4TndIQ1g2RnJIN0Q5TFhSRlpLcjJNTjZTVTlX?=
 =?utf-8?B?OGlBUHIwYkI2Z1l1WXhlTkRlbmxzRWpCNDYvTURhMXMyRE1OazdKc3NYZW1L?=
 =?utf-8?B?VUYyeDFvMW4vRlpyOTJqR1RQbk00VS9NeTVuM2Q3cFVOU2hjTHpzNnF4b2xL?=
 =?utf-8?B?ZENsQm94cjVnbTdrTUVHV3BseituTi9kNzZQdmNJak52SUtrMjA1Tm9sNTg3?=
 =?utf-8?B?c2hVbFB4ME5FVndSMElINHE5b0Z2L1dRVVowTFdvWmJsN0FBYjRHTnI2Yk4w?=
 =?utf-8?B?Q3pwYldTT3JpZDF2YWdHSERCZFkrMTVWaWJRVlJtTEVoaWVlVWx1V3hhdEVN?=
 =?utf-8?B?RytzSHM1ZEkrSnArMTVwN3VNZDJNV2RqdUFnUDVVcWRrU2wvK0xObXhYeVJY?=
 =?utf-8?B?N3hzNnphcFp1RHVvREZOSkt5NC9TYlE5UnBINzR3UndqbDhXa2dvWU1jUE5V?=
 =?utf-8?B?d2F0T0VJNFBTZ0VkNHRsQlZEZk1EZ0l1NmU1dDUzVTkrUElrT1I5b3RvekNO?=
 =?utf-8?B?UTZNTUtkL3Z0MzJCUnZJVmpQbXdmaW85Z2xqVlNjN1d0RXJZQ2tJTlR3NXVj?=
 =?utf-8?B?QWhZSGd1blozc25MSmF6d1lPZmNTeGt5ai9kSk9wRWRvYmVtUTdVZzZQRFBJ?=
 =?utf-8?B?TUwxWWM3VzFLNXgrYTBYQ3lJWkdzTTAwWTJRbEhCMFFjcnlxMG03eFA3bWdS?=
 =?utf-8?B?QlROU1pCMElkT2c4QzNpSkVQNVJZbGhSNklKdC9xQ3kyTnVmcVNNSlRObDgv?=
 =?utf-8?B?bTJlTzlERm5xV3IrYTFDZ2RZazRPbzlYMGc3ejU1VGdTalkrcDhLTzRhVERB?=
 =?utf-8?B?QTNSTnBMenpBcnpBeS9rSDd1TzJINUVQYzNqNlcvNS8rRDFHaFJISnl4K3BD?=
 =?utf-8?B?L3hCUStCcnN0TUhHZ3oxaURHaXlLNWRSQnFzVzRCNHNNUUFxL015aEJpWW9W?=
 =?utf-8?B?dEVLdzRyUEFZa1A0NWo1TDNoWU44Q1Y3d2ZCak9WYm1TRE85RG5rV1dINGIy?=
 =?utf-8?B?R2JkVXMrT25NYkZYQk9uSUJGa1l3NUd5cUhwdis3WkU3ci9maDVKcTBRTFRr?=
 =?utf-8?B?WFdSQWlJWXRrNTAveHA2TEROYjh2ZVMyM3l2NWFCSDliKzZjZVFYTXk2L2p6?=
 =?utf-8?B?Q1hVcEdDcytYeHV5N2NtSTMxLzB0SG8rUkswMWgzYURXdEQ1TEZZM0FtTUdS?=
 =?utf-8?B?YWk5ZzFpc0JHeVh2WTZZdjhjMmd1bk8rd3czL2xFU2Nnb1NwU1pkWUk0SHdn?=
 =?utf-8?B?cTdrcW9UVmg3K0hvTFVqWmFqZDl1WnpWUzh6M0VjTUptWWh3b3A5eUwvaUw3?=
 =?utf-8?B?eU83ZDY2YW5oeGVNSko3TlgwSGhtbEJ5Z0E4QWVxTVNXR3lzVS9yQWRxR1lN?=
 =?utf-8?B?bkt6QlhIcnNSZFFUZjFPWm9tSTVUVmVvdFFwMnNyQkhHM2drdlN5Y0c0OFN1?=
 =?utf-8?B?TGZ4Qk1oR0ZHeitITVl3djdJVS9Jell0Z0R6WWpoU3RzaFJCVUtHbzlKTys4?=
 =?utf-8?B?dEZJQkJNNkJIS0pFTlNyMExzOUYwd1NkOFdXeEZ3ejlmTyt1R2ZLWGlmbU9y?=
 =?utf-8?B?dzZhUUZtN3pmQzFTOGZvMkppSllWeW9xYVZMNUJKNm01d203aWUzZ0JwOURj?=
 =?utf-8?B?MDErUU9GTlFtMXlEcG5JL2FPU0J0QllOZ1c0S0g5cTloVXcwMGRmamp3ZlhL?=
 =?utf-8?Q?C2SknFey53wiGZxfahEn3WXs4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1fa1f8-4b19-463b-2791-08ddc47416e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:21:43.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sBGfQ+qDAINQpWzt92IaenSg5M2JnAVvRcBZ2jR18nBVt1GjdxoYqmdaRtnZjU4aumDwugLYDWta73LMwZppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6100
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 14:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19548

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_5.10.238-cip61.bb => linux-cip_5.10.239-cip62.bb} | 2 +-
 .../{linux-cip_6.1.141-cip43.bb => linux-cip_6.1.145-cip44.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_5.10.238-cip61.bb => linux-cip_5.10.239-cip62.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.141-cip43.bb => linux-cip_6.1.145-cip44.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_5.10.238-cip61.bb b/recipes-kernel/linux/linux-cip_5.10.239-cip62.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.238-cip61.bb
rename to recipes-kernel/linux/linux-cip_5.10.239-cip62.bb
index c46d3343..b2dfb4da 100644
--- a/recipes-kernel/linux/linux-cip_5.10.238-cip61.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.239-cip62.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "baffc5d9a487b168fe12ff539f48f53618a64c296a1d409789f556537f04e8f6"
+SRC_URI[sha256sum] = "13925dd65f12b38832340a654226becade5c2118f94d86a022b386231ca57998"
diff --git a/recipes-kernel/linux/linux-cip_6.1.141-cip43.bb b/recipes-kernel/linux/linux-cip_6.1.145-cip44.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.141-cip43.bb
rename to recipes-kernel/linux/linux-cip_6.1.145-cip44.bb
index 25773c39..1234d096 100644
--- a/recipes-kernel/linux/linux-cip_6.1.141-cip43.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.145-cip44.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "e7de47f1bb910da28a5d4fd4887757909f00850dd0cdc40f1731b5fa85a329b0"
+SRC_URI[sha256sum] = "9e701e770dcaae87736c8a442021eef7d57c09aa70ae093c20531d70fc94b089"
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

