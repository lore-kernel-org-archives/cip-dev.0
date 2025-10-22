Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE538CCD1BB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 14:22:55 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.15])
 by mx.groups.io with SMTP id smtpd.web11.10780.1761142969258380315
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Oct 2025 07:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LQkSlKGL;
 spf=pass (domain: siemens.com, ip: 40.107.159.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5NYeI16FS4O3S7eFDNkjRxrI9JmKN98tJQfhEiwXIU1jCQR2iyDENZvqBwAmfUd+4xYd8kNjc52g6fL6qPngM7gZIegcNaLA3bFa/od03I1n18umq0aQ1l3ZTCWCap03bOnLobijvWoFUPPgeaJOIOLAOucN4ADzb92sRaOzQEvPNYjEPQlCgzNYl09e/vNMeBuCxLvP32BQ1rerTgl8jn1ZG+cEpZrcXLleF3KocypLzt8/fPJG7oYsYxGWJ+PdYbB4yJAePr7V62V1iSl6HikDzkeTvUJM2wlTNgD9PNfEktATrBHdcSAIdlLCCzSp7xDoW24ruWyEkKWMUT5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLyOUR6Pz8SWUulbvX0FlG+SgnTgFHECBC86rbUelRA=;
 b=ry/xyH1l67+o8iuUBK01eGOnYMAhZ+NhOpkyiT78nPSaUmXWFKxNegpNnQhjY4OpABPuvoC2pxdnkSsJfR5+a6+U/721zE3VlPMA0dIuS7pCJqFNvTcrwYvt9cq61sL5p3JKQbsmitL7l9X/4dk+Rqh62SyM/2+zS/aI/AAPInP8RTf5kwUHYKVWOGdYmjjRVqTudnE7HqT0bRsNqOfUe6OMDqsez+6o8mktdTiSvAlPCv3ZTM39kRYhWl7QlEL6TVdJKbaltULeKVqGAgxQzJfx2miNnwlc48gU1/v3DzqIv+oK/czKJqusvsfsZniyB5+e8o19cPnNCTJ5CwI1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLyOUR6Pz8SWUulbvX0FlG+SgnTgFHECBC86rbUelRA=;
 b=LQkSlKGLgAoINPhjVJznMdLLox94c3DAYk1+Q+HdsuiD2d3c+FerGgfnI1MGHfusW76R3KLywBXK5GmeOuNhzPHgVn9FETCkABCCwndt+xNxLvSt33Sag4O2P2WVjXWhRI5A6cYC/jQo5aF/LFxYBFhTMOQQ3xlBB3+qV59BIPky49+ET3Qoyfc/QKZT8pQ/NtYS3LuEuJ0KU9m6kbvvUoVGjBEsqQmI5js4dT0HzvYfYmdJaoj/fIWFACj2mF+5MRnES8ZQ1suTyhwTzRlkNY6zA5xDymsMTsWBxbtyVxnUk/CDAeCfH8zme1iIbVLszTqAms5W0c6cGVBK++QcBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:22:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:22:43 +0000
Message-ID: <6ab0d410-0186-4577-9a56-32ba159d7d2a@siemens.com>
Date: Wed, 22 Oct 2025 16:22:40 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip125 and
 6.1.155-cip47[-rt25]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:610:11a::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b58c25-a0cb-4de9-8738-08de1176771e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aS9nT1Q1R3BjdVNmR2Y2QVplcjhCZE9aaVdQUUk0MEZqODJjM0lJcHZrU2RE?=
 =?utf-8?B?TDlkZjYzOHRwR2pOaFUweENFU09MVGxFRkUzanI2MkRtb2Znd2oxM1cyTVZz?=
 =?utf-8?B?di9QTlRlbGh5QnZOSXN1YTRjaVE5VzMxM093QkMxa25FMjgzU3ZwMDlqaXB0?=
 =?utf-8?B?WEp4TTQ5dGp0VWFYTVJNUEJ6RlVMdUFLdzBBY29sUVRYYXVnTHZHUk5ESDZH?=
 =?utf-8?B?UWdwRDNIcmxYSVA4MUIwU3ZiS2dzOUlHbUdRczRIUEd2ODlzZUFodEUrRzFq?=
 =?utf-8?B?dFZrQ3B3ZlJDV0ZTQitlYkYvbTBINFozaUkwYndSRUpvKzhlSlVlb21wblJI?=
 =?utf-8?B?U2Zqcm15QzgrNVRXb0M3cVBOektxbnhhZCtFL2kxY0VLMlIya0lqVG5ad0h4?=
 =?utf-8?B?S1hMZUZYdnNzYW9JTjdnd2EwV1hUUGlUbXZpTlNvaGx4U0lZbk9WYlZlenpz?=
 =?utf-8?B?L3g5bUZPQ05oVFhOWUVaQnFYMURCK1NORUc4dXAxQ3ZPRTJzS29xczh3ZDY1?=
 =?utf-8?B?RE9iczBGeWpKU0VPbktKZDRBamo0MXVkRWZORW9oR0o1WkhiSlVzeGFidkJn?=
 =?utf-8?B?Rm11S3ZmT2FDajhJZGNnaHFsTk1KRlhqUXJEc2U5ZzN1NG1BM3pHK21aeTZN?=
 =?utf-8?B?SFZ3OXNIOFd0eDg2MGxUZTBqVFFGMmgwRFJuZUdyd0N3TmFJcllNK2Y5TnIw?=
 =?utf-8?B?aENncjRNcFNkeTZGbitpRjhkU1lYeU5hd3hiZUNiMk1BVE03Rk1XRU5XYWdi?=
 =?utf-8?B?ZzRUNWJTWlRtbk9iVUN6N0kybkxlYmlOLzUxTVhjVFpVdUhMVkszckNPa0Rt?=
 =?utf-8?B?N2tqQmEzallFOTNvc1YwbGVhb1hRQTB1ZFhaYWlrdU5zOXM4VWlUZDRONGJ5?=
 =?utf-8?B?UHdjRXJPaWFVTXhqNm0wUnVYMXU1WXpwb3VBV1J3clJTZENjc1grbWlCWG9E?=
 =?utf-8?B?bmw4ZzBOSWFaanhQbmhPS2dmNE1EaFF1NGhXUWxHNWkydnlXU2M1Umd3NlVw?=
 =?utf-8?B?QkRId3kzN2FRSW1jNzIvWU4xWkFrN1FLTzJvQlU5VjBzdlFVVERCUDU5NmZR?=
 =?utf-8?B?NGRlcEx6UHh0UCtKd2lNc3JlNXlsY2wrTGxuUWhNQjBZaVVMQWlDVXRzbkNx?=
 =?utf-8?B?SjBVOGVlTmJvVzFaajFZd3ppQVZaZ2xDWUlsWVNyMlk2VXJPU0ROL2FFSjI5?=
 =?utf-8?B?ZFhYRGxESmlyTWJyU21XclBicmtiWjV3VWZlY042WWNZbUM0M2RwQVpXOFlI?=
 =?utf-8?B?MnB1UXQ0dlg3MGhJa3pLSmhsRytJdGkvdGJBekMvTElSYTRTakthaE9la2ht?=
 =?utf-8?B?bzZqNHpqRjZITE5ZVEM4WXpKOHh4YStxV0VnOFFkSjlTVEtRTWs4RnNBTmEz?=
 =?utf-8?B?UHQraHY5WFNhNy9BMGpXRG9SY3cvODhVN0NjWFBxbTVJNkxiMllibkwxRWN6?=
 =?utf-8?B?TDluQW92Zy9NNEVIaW1ZNk1zYUFSTWZqVjR4UzYwTkpHRXBpNlRoRitaOTJt?=
 =?utf-8?B?aVFuQy9XT1Z6RzdGb3crTm84UXJKUUdpR1RnUG45UFgzUWhkc2NIQVZ0RDhy?=
 =?utf-8?B?dVM2NlNkOHFPK3pjNDBGU3NEQ0ZycngxUlZreDlQaTVsMktsLzA3b094SnA3?=
 =?utf-8?B?ZmJMMENTdVVTams0SDU4bVVaYUZjTUVMUDczeVQrakkvbzJVZnVhQktCdklE?=
 =?utf-8?B?cVlCZkZWTERXcXBRV3U5M1ZmZjQ2bDNPMDk2TEFuUnRSczVsMkhHYVo1SEN6?=
 =?utf-8?B?dkhnQWswMEJLWFdOWlBzZnVvcHZROEpDcGprZEY3bnpmTitxbE1zK1V6aWFV?=
 =?utf-8?B?UGUyK3BGSkw2dTJlTVJWUjdJVHdxMlRsbk5MUVJaUXd6T2d4SEd1eTdwNWR0?=
 =?utf-8?B?S0lMeDhYcU04cHNkUmhvVjg1RjQ5U0psQ1pNUjk3Y3ZYTmxaMzFyV2NGZ2hG?=
 =?utf-8?Q?lcreOCyMkdxi7wVQpZwuyjY/7stYJ7ya?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sytleit0RVpYcUNpUUVDVHZkTGtrbXFMRTF1cHl3anpTaWJIdGIwdkZlTm5J?=
 =?utf-8?B?U0MxaGE4UERlbVIrUit3RVdsb0YzRENyTFc4TVBWWXVGMGJmdDAvVG1sSlFB?=
 =?utf-8?B?Z2F0OU5EOXY4R1JRTUZ5MFpjNnNHV3FLeUN0dXdxcWM5T0ZiS1VSdXFKRm5k?=
 =?utf-8?B?RDg3ZnJwanUrMFhhZFVWNlpDSFlPQkw0WENJR2lkSjFlOEJPM0pGaG5oK1c0?=
 =?utf-8?B?d0ZjYzVxYWNiWDdoT2kraWFRVzJjRUJvZ2hXaERPQUZjZlhiUi8wME8yTFJ1?=
 =?utf-8?B?SmlDV3BmZWx2aXJ5NHdxMC8zMS9PRTFZUDN0b2xyeDAyM1RrZ3N2MkVnZWkv?=
 =?utf-8?B?cy95RzJlbGZDQ1pqTDF3KzNPRElpYnFQTHE1SS9VZ3RsZitCMFJ0ekozSEYx?=
 =?utf-8?B?WUdzZlpxcjFzak12eXVMUmlIQWZwcG52eXB4Mnp3VTBWd2NUUmdINXRCbXc4?=
 =?utf-8?B?cFF2cG5oNzVFeXY4dXJMQ0FlRktlTzdEYWUwTWsySXBXZy9POHU1SVdDQjlK?=
 =?utf-8?B?UmdYRko4OEJUN0VJdC9TQjVkRkxqY3dDWnlPWGd4N05GRndUOHBSZGtKQ3lX?=
 =?utf-8?B?ZG1EZy8rYXk5MnEwUGJnYks2VzBRYklmanNHLzAyZ053LzREMFFybWJzQW5n?=
 =?utf-8?B?S201OFhUSXY3dzVRZUhKSXlCcHFLSDNmTzVwT0NTSTZSakpzNmVTQ1hWRGVW?=
 =?utf-8?B?Y3Y5VlJGd2VOeVZESnFYd0Z5OGVrUlhFYmlaclFGdGE1cmVsWEp0Qll5dlAr?=
 =?utf-8?B?eGtEejVlcTVGaGZuWWJqOUdkM1lMQzdzVVk1dkFXdGtSem9XYjFqNVc3dCtJ?=
 =?utf-8?B?N2dvT2RkSzJoTndWUmFRdFg5ZEtjaTA0dmErUUFLZ21PR3VGbWdzS3RadnpP?=
 =?utf-8?B?N0dGZnJ5WXBhKy95UXBha3YrTnhDM3NVSGxDMU52S29GMkRoNG41VWJZWmFO?=
 =?utf-8?B?T00raW5uaElBTXV4bFVKcFlsVXgvbFNEdGpnSWIxcVB2OGJsTFRFVXJtQ2hF?=
 =?utf-8?B?U3hKMXNSM016dmw1Q1YxT3hpdjdZUGJ6Z1FCNU9veDNFSGtTR1Jhd1l5ZXRv?=
 =?utf-8?B?SzZCN2k4MzBGSXh1cXh5SlpWa3U2T0E5MCtpYjhnU3U1Z1RmSFRWYXNDM0R5?=
 =?utf-8?B?RDEvN0FudXVGc1pXTFFZZDY5UmJzKzBWNUYyVzkyWVVJUk45dmRnSGFNWnln?=
 =?utf-8?B?MXFzb0wwbEExNEtxWWVRRER2YU50Um02M3ArM0tHVmtlSHJ6SVQyT0Z1bzlw?=
 =?utf-8?B?RnJhazhWM3N0NW8vNHpqMm5YZ2dRZE9VcHg4dDZRV1RnM01UcXJodUVPNlli?=
 =?utf-8?B?N2d6NGVHZUJ3cjZxWmR6SFR0Ui8vemtCZHpvWStDVUYwRUdDVjlNa0tLaWRR?=
 =?utf-8?B?SUpoWllwdCtpbjJiV3kvNjdLTUFQNUZlY2N4U25jWDF4S0tCNE1LRVVXeGNh?=
 =?utf-8?B?VzhhM1JrbW05eHNINCs5Sm5yQXliQzNTdk5GYXhLUU5xdnRLMkJpd21aNjRS?=
 =?utf-8?B?WHA1b0NvZDBuMnhGN2NZL0NtU09YcTEzRFBqN2JsRHNLekd2NjFabFBSczNF?=
 =?utf-8?B?Sk5LYlBabzRrcmlWR1RKeGZmcjIzeWJvWEJnZ1hkaXhhZ0dQeXhWYmV6MU96?=
 =?utf-8?B?cVpxN3ZVb0NFSi94MkJXQ0hXdmVDcEVpanZOM0I2U2JSZTFydU1iQUxCQWhx?=
 =?utf-8?B?MjJZbGQ5STZSWXRmVG0vVkpIZXptMnBBWkRReWZuN3graHg1SXlFZkp2S2hy?=
 =?utf-8?B?UnRaeDAyakRPN3pPSGNBWVo3eitWR05TVmZodGNMelk2bitSTE1BYVRHUTVa?=
 =?utf-8?B?akM2cTVXOVZwSVJPTW9ieS9mcW42c0FyZXVEK2o3RGs0SVJTSnJwZ2xxb0dh?=
 =?utf-8?B?VVhPK1M0VTlnd0I3K2swMVFnSDZEeDd0MFlrRkRSR1ZaeVZnNE1CMHcyYUNr?=
 =?utf-8?B?QVU2YmtNQ3BYMUZ3Q0F6OEt4ODIrVHAzZ2hRMG5EQ2Znc0p6Lyt1R0E2ZS90?=
 =?utf-8?B?OGhCa3pPTE0rdEFGTS9Nc2VkdEJsanAwOEdiUkEra3JtYlJjcW9uem9qOHVZ?=
 =?utf-8?B?K0U5ZUpxcTFZTFI2dVpRbUYwVlpGQzN2THZseUVwanhGMHNFOTlEK3AybmtT?=
 =?utf-8?B?VXQ0VTVyOTI2ekwzZ1diVTdkd0Y2Zytwd0swZk5QVFhhaVRBY1hGamtmckJU?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b58c25-a0cb-4de9-8738-08de1176771e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:22:43.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu7/61vlliEm6ypERPbyzQyuwafpv/lHs3U5VSoP52Ke27RMtJRJV2ljzBOGMQpzgQgfjy26zjKocquqX+nv8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Oct 2025 14:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20212

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.151-cip46-rt24.bb => linux-cip-rt_6.1.155-cip47-rt25.bb} | 2 +-
 ...inux-cip_4.19.325-cip124.bb => linux-cip_4.19.325-cip125.bb} | 2 +-
 .../{linux-cip_6.1.151-cip46.bb => linux-cip_6.1.155-cip47.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.151-cip46-rt24.bb => linux-cip-rt_6.1.155-cip47-rt25.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip124.bb => linux-cip_4.19.325-cip125.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.151-cip46.bb => linux-cip_6.1.155-cip47.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb b/recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb
index 79ca1996..0edb2a38 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.151-cip46-rt24.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "52eaf229fbe6f601ac1e5288ac70ae118486db6c317e78b42cb2e4fef93e66e8"
+SRC_URI[sha256sum] = "f9bc9fdacf78719926d7e6d92575f2dc1b975b359b73e375c92541aabc3b623a"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip124.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip125.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip124.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip125.bb
index 946c709e..c4337411 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip124.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip125.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "fc5004889dc159a59b6c6b85146584ad3393149efbff34ad8b25288fbd792b78"
+SRC_URI[sha256sum] = "d8824967145bbfbb926e16e4c065f43cea2c31a41a2047d44d8a8de66eac5ab1"
diff --git a/recipes-kernel/linux/linux-cip_6.1.151-cip46.bb b/recipes-kernel/linux/linux-cip_6.1.155-cip47.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.151-cip46.bb
rename to recipes-kernel/linux/linux-cip_6.1.155-cip47.bb
index 402dbba6..8d1bd1b7 100644
--- a/recipes-kernel/linux/linux-cip_6.1.151-cip46.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.155-cip47.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1dffd99104ce9c9b75d387f345bbd3a5c2e5f9ae112315c5fe1c830c38c4299b"
+SRC_URI[sha256sum] = "a04254f036c472bd0656d6013ee9be27d4aea31d43ba558af08dd1d4081c4ebc"
-- 
2.51.0

