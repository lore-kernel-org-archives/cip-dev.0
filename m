Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E60C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:41:53 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.22])
 by mx.groups.io with SMTP id smtpd.web10.20613.1751452902302747145
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:41:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vegZ/WUJ;
 spf=pass (domain: siemens.com, ip: 52.101.69.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUUaabSvjWpup4xv3HV5JCzdWntYn1LmEUo6vRL9dxFDdLVCnHMv7ptUh5gxPmw0sDq2QrudcISI71LV6SAscKP4OJ0Ua+/AMIn+V5tJWdxnDlBZ1utn1gJguKf5zeyhZVtm8BAjQME419l8SLJxi+hEi+rCaZdVrMTrpWdUCAZimWq6j+xgOFrR7Ccda77v2CopBqjzs2BGyXwV9xQoQ2IP3hpNaE4KLGKZ11VMxrpW0GHI+7DSvJyKSOdjsSyw1p2OnFpajeJCqaxVMr4WjwX1g3mQ8qF5jX6Sc+CJBdHn42clNOor+Os3yMVI4tI/lUN2QR9Q9fO2lHQmJDRGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aF44vDZyNOa1zCa/03xPu7uMLQEuUIIB9fgPl0n7zk=;
 b=EY1KQCadpMfa5JfSvOtYb75sxJzkjo2vdcV5AF6nTtGnbaiLeIqJaVDg4Gvr929NfLX1CHJZN4duNTdE/zRiEQs+KmTtyzgIz8DC++ZSFq7rn6mLkv++azuZ65q7zFFdpUQW+aKxVppkoonieuwJKjpyMmANNnmCS2Mt98xXm+rC318mofQer3tMt1xfSgYZqoFKDqfumoom1PfRCB/U6P2HUPErWB/vWfVk9tq76g63z3x77Eca8e8Hcz9v4ggGb5KNIaT+u1wsbVgaNf/k20fDabHwEgqRnwcWnBqWAtuptyc5SLXCk92FI9mxWcpKBp4obeXVBIbLrSf5maGcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aF44vDZyNOa1zCa/03xPu7uMLQEuUIIB9fgPl0n7zk=;
 b=vegZ/WUJnr3JO9/a2CM0xaEAIPTCkR9qu9Tq62pXPjW40iBO8KYekGZ+LKfJTGIOcwxcRgJBnmsyAWhsueIJBS3beyRzV9a2jE57LigRhNG3XGQ+pd5mdrnxGugcRk+m6zxc4tsfiHbEw+kpeKVDOTY9+dBY7sQoWUNjKFMe3jQf+LzAZ94LfJCj8atT5XWAhGIc/dXQSgjKPtW46scD/AM7MwO52Sl26NT/rkDNNpbqVIzk0fUhxD3KX1VXdKcYowbRUgoJIxNwGMduc3HaRLFsRwCw8tK4Q1e4gjsY52cOZrtLcqu5/UzlR4f2Ya/h1kxCsy9zlM1TOyhY9vcojQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:41:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 10:41:38 +0000
Message-ID: <a2690fd3-ae21-4f76-91df-8457a95ae22e@siemens.com>
Date: Wed, 2 Jul 2025 12:41:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Exclude building 6.12-based images
 for the IWG20D
Content-Language: en-US
Cc: Chris Paterson <Chris.Paterson2@renesas.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: d95444bb-5238-41d1-b16e-08ddb95505f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NEVqSVp6SkdOS2ZhKzRHc1dGWDFvcW4rWnpCTHBsazV5Rk5GQU1CMGIrZ0Vk?=
 =?utf-8?B?aGVEbHRWWElXVm5Fb1ZpeFV0VVBxcUpnamZ0WnM1UXNCcFI3N3lkOTQrSDc2?=
 =?utf-8?B?dGJVUFdvVHRHMm5ScFp5dFZxL2tneGdzY0dvMjNaelJodVNONmFOaFo0Y2g4?=
 =?utf-8?B?cWtzcldMYTZ4TFFjOVdUVGh3eTFjMEY1R3RuY3cxNDRDTnVsdkxjSVExM2NW?=
 =?utf-8?B?Y05OOTkxdDE0VDRqMEdFckJsazc0VndxbDMzOHc5TjdJRTREa2NTSjQ0bjlQ?=
 =?utf-8?B?MUxRZGp3M2NnU2FVK0xKa2JSQ1Vrd1o2U0RPblpFNFZETjlwUXl1bFpGZG91?=
 =?utf-8?B?RzF2L0FzenpWK3V2MFdYZFpQelluenUrWVBPQTZvL2d0cE40Y0Y2OGZ6TnVn?=
 =?utf-8?B?MUtHcExJMXhwN1c3bUZFeXNCNEdIVVdqMFk1TmNFR1N4RUJ5YkErOVVzSXdl?=
 =?utf-8?B?andTOHRBQktEUjNGRngxMkdZa2F4TFFlemp2NFBMZkxPSFZIWUdzdklzZFkz?=
 =?utf-8?B?YmFLUGlxNE5aVHUzU3l5NmlFSlRXdnE4QUJxQnhURHpjalY0dHM0dUtFUFJH?=
 =?utf-8?B?Z1YzcUg2emVWRUJ4eUhMT0I3UHBqdGYrTzZka2N4K0w3YUZGUHVWbm5PeU55?=
 =?utf-8?B?clZycFkxYmhma2dJMlhNQ1hPTFdoTHBMTTdrdjlYL2duQW9BSC9BclphZ3E1?=
 =?utf-8?B?TjVGV2l6WURYUnpMbktkTStPZTQwUG90Z0YzZlVwUlNyN0wzUW5JR1VPRVRO?=
 =?utf-8?B?dXcxdi9jbnhmT21tNGJyamJkMWZnTTNqSVRETjdQSm5LUm5jdEJ3UURaZDBh?=
 =?utf-8?B?ZmNySXVvdVhXb1BUNHU0WDdvMWZuWExMbjJXSjJrK2ZTK3ZaWU0rQWFUVW9Y?=
 =?utf-8?B?MGsyVmJuNnhUZ3lNR2w1VklxclZvRTNRK0xac0xuczNGdk9Uak5jc1hjYWhu?=
 =?utf-8?B?WFFaSFhqV2V0bVBSSndaOFBNS256Q1hFVS8zRUlzc3ArTWpzb2JGZkRxZDVj?=
 =?utf-8?B?QmxiZXlkek9jNUhlN200S25UbmpueVYzNVB4UlZIcjFnUlorcTZ5czJSb3dU?=
 =?utf-8?B?bzZNNUM3TTdGM1VvQnZMMHZkRU1UNnBGRnpHUC9lakZOSWhMYUF2bzRNdGd5?=
 =?utf-8?B?UzlwZmVoUGJBWWQ1UWtRWnFSVzVGSnVvZ3Y0SlRoelFRczVzUDRBaWJkQmxw?=
 =?utf-8?B?OE1OTE81cUtoTVFPajJhOEluWTQvVTg3SnRpSll6QThiVFkzWUMzVFdmd1JJ?=
 =?utf-8?B?YktNbU81UkhyZ3F4TFRpZTNIbGdZQXNKODB6Z3RoQkF0cDN6TTdHSHVraERR?=
 =?utf-8?B?ZkRFcW5SMEI4c2l4R2szandPTFNyamJsLy9ldVBUN1pOclhrSTVFeFphMVZU?=
 =?utf-8?B?QSsyV2tUMkJXbTJuUXU0R2dkYWFjYVdvU2lrbGJSa1ZoZklDNHFOWSswRmpK?=
 =?utf-8?B?RTlCM0F5NktWazJ5VnhaczB4Q3Z2TEh3K2ZKZE1zWEw3eEJkVkRNcUFObjNP?=
 =?utf-8?B?aGxIbTFhQVhoK0x0cXMrY3pORHpXVkZTRk1zSUMrY0xnNE0zQ3FDWVh5YlhK?=
 =?utf-8?B?RnJ0STFyYjVyWVNDMTE4VEl4SVVhNTkxZEJXMDZQNzlHR0N6ZmF4VldJWTMw?=
 =?utf-8?B?aWpwOWQvN3QrODFaN1UvVTlWQzhGUytDM05QaFoyMG85VEpVYkdOV2FUVlA3?=
 =?utf-8?B?TnBhczJDZW4yMml6VTdOOEd1UnQxaUxsbTMwOG1qSTBZeXgwbjg4WCtoNkh5?=
 =?utf-8?B?ZWlGdjNsR20rR2xLMGpoMExTejlKSkxJVmdBNUtVYzRpZkFqT09RSEQ4TTdy?=
 =?utf-8?B?dnFsTExQbnVrNVVacGFJajBGS1dGaFpxUW50QVZhQ0l5WWJ1UzlFVDZraGhO?=
 =?utf-8?B?M3R0cVpIMTFJcWRDN2c4eTMwU2FUMU41cWpyZFpFRDg0MGgxdUIzeWxmcVYr?=
 =?utf-8?Q?I9ZQRG9mvGE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OG10Ry9OV2pjTkhGdVF2bG1XbmJiTWhQMG9XMUowdVBpMXJwK00wdGNmY3RK?=
 =?utf-8?B?MnAwZ09jRkk0WTJ5UlRPTWE1WkF4ZmgrTElqYm4xVzhoR2RoamZObzV0Wi9p?=
 =?utf-8?B?VzZPc3ppWklrekxqbWxSbGdaQkx5cy81S295N0k2OEhSOThTcDV4V0JZUzVn?=
 =?utf-8?B?SkNnSzJod1BtMW9pUkhBMFVLNDJEbjQ1aDdKUmtBK0FuL1BRYS9NaGJ0Y3ly?=
 =?utf-8?B?M0Q0NlNRbHhKajZUS0FiUWRVczlhL2FUKzBKaFVRYTZIMG15bm51MTFSSzRM?=
 =?utf-8?B?bnZ0K3NxMzdjaFBXV281ZllkQ1ZoZmNJVFQyQmUzQ0IvUlljSWlQenlvN2ZP?=
 =?utf-8?B?bjNWb0xra1g2ZWlicnBwNkpyemVWVWJlT0poL3MwcVV5SkRJSENmU2g1VlFZ?=
 =?utf-8?B?bkU4MmpuSWtkYmM5ZXFMOGQyZGoyKzBsNjVJT2ZSMnFrVHRnRmZWMmZxN1Nr?=
 =?utf-8?B?V1N0aHFZRWJGYVpNY05sL3l6UllTdUhibHlVcG9FUUs2dW9Jd2ovUVl6TGw3?=
 =?utf-8?B?UDR1U3VrU3h3d0k2eG5PYlVOcVZkSGswdnFGYi9rQ2Y5OGQ0N1hWczBOZXMy?=
 =?utf-8?B?akxvSEJ6M1k3NGliamV0aHNaMWk3anlMQkdvcjdlZ3pObmZjbFRMdW9wWklk?=
 =?utf-8?B?a1dScnpMUUhXdjJjME1rM3VWSGIzVVY5V081Wko4eVBpUi83eDNUU3lhVExC?=
 =?utf-8?B?SForMHpHMmtQSEtxNk1CQzdkLzZoSVUwSG5DT1lId3FyZHdZbWFkSW1YZkNS?=
 =?utf-8?B?Qk5qb2hUUkErVC94NzB2MVNLN09SRXpsdU41NFZVTWovaTRHMUswZ1dUR3Ry?=
 =?utf-8?B?LzMxeEc5UDBEVWFkbXdYWmpDNFlnbkNGL3REZnZhY1dXYWd3OEZPQVFrQ2cr?=
 =?utf-8?B?eXlNbGNzN2d6anF0R0NSZDR6ejFuV1MxK2hMTDI4N2NjSk1GUVVNSHdJQTN6?=
 =?utf-8?B?ME9uYmgzeW91SmRhVk1rbENuWWJORksybmtMc2dFSHdCMzlobjljRkI2Uncy?=
 =?utf-8?B?NG9BUmdoZWoveTE4NzR2NTR4RnB1RGNSQnYrTzVSV2lLZldnZGVDTkR4TUtE?=
 =?utf-8?B?UTNPcE1TUW1yMVhyT3c2a2lOdTRWcjQ3dkhGdlRxbDZQaEVkSUczZGVSMXM2?=
 =?utf-8?B?ZTB4OXF3dVloY2xMQVhUeWZ4MVlJcm1VY3lPZkxDdjJSRFRiZC9EcnN3VmFP?=
 =?utf-8?B?aWhVM0NqSmo1bG5kbGgreWI4Y3k4RU1DZFg4eEwrR1lZY1pRV3pPV2JhSSty?=
 =?utf-8?B?WGdPOTl4S1dmUThVamxZbjllTGNLZWNqeVRsSzJUYmExdW42N2xHRnp6MGE4?=
 =?utf-8?B?NGhmQVJGOTZPK1ZPSWpFRlZWNnhXdU8rdG5uVHVubjlrbWdmN3BCTFptMDlt?=
 =?utf-8?B?bTdNbzBCckd3SnI2RGxSZ2o1d3IyMUJ6V0poZVgyaVV1UXB3ZmdwS2c4OEJi?=
 =?utf-8?B?S08zWFRsQUJpeEorekh3UFE5MW1ueC81Zjd2T0R1UzZLSVFmdTV4eFYvWDVU?=
 =?utf-8?B?SUdtQjA5K2p4ZzA5NUNoK3dEaVRQb2ZiTGU3REkyMmlGa0NuWjF0UTYxQ0JV?=
 =?utf-8?B?YzFlRGdpZlh4dlZJVXI5L0wwVXhhRTF5d1JaZVNuT2s1dDNTSjNlSGVFY1h1?=
 =?utf-8?B?OSs2WUFtL3l6clBpNFVIdmdrUUFFVDY2alBIVitZYkZmQ0toaGFTZ3hJR2VL?=
 =?utf-8?B?a0tCeUFsT2tDck9kdTVMa1NKczN0ZVBiZ0M3OENZaUFmbTV3UW9yZ25aZzdM?=
 =?utf-8?B?Ym1OOHVZTFcxeE5hWWlhZXN2SGNTNktyeExFT01Rbmh0RDlUZkkrdjRrRnlG?=
 =?utf-8?B?MERHc2JhV05mWis2U2pWZ0xDQXFVbzFJTDMyeWluMExyVWRpZTJqUTdsUE41?=
 =?utf-8?B?RHk5cTBzV0E1NENGZVFVRTFlV2ZlRHZzRzRITHJ3cHlnNE5BbzZRbnlMM1lv?=
 =?utf-8?B?RTJxYmRGSWhMWXJydmFDN1MrN2hyWUo4T2hHbkt5blBld2p5dmExd2YxVU1l?=
 =?utf-8?B?NU9BVHNQOFI2cmJLUlhrQ1RORzY4WEdhK2l5b21ObUNReG5KM2lzUDZHakVE?=
 =?utf-8?B?dFkyYythZTNTdEhFRno3cjQxaE5FZ2haVjBiT2kvV0ZrNDJ3QXZZZFhSSmMv?=
 =?utf-8?B?Uk1Hb0ZGajhZWGlNdTlWeklMMUxlQlVtZ0t2cDVTcEpBZ2NnaFBEWFRmV3JN?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95444bb-5238-41d1-b16e-08ddb95505f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:41:38.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToCu1vQdA/FUQXI2T5MhO6+EByMz4QcXG5edQVMS8a28JpVk7m/+j/Ok0P6TdCrrof4Uwip0acY7uW88g3iw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:41:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19312

From: Jan Kiszka <jan.kiszka@siemens.com>

This target is not going to be supported with 6.12-cip, therefore has no
kernel config and cannot be built.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 582ceddc..e0788926 100644
--- a/Kconfig
+++ b/Kconfig
@@ -112,6 +112,7 @@ config KERNEL_6_1
 
 config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
+	depends on !TARGET_IWG20D
 
 endchoice
 
-- 
2.43.0


