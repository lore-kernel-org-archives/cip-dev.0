Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A8EC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 04:54:41 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.73])
 by mx.groups.io with SMTP id smtpd.web11.7266.1746766476029766063
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 21:54:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qROJNKRZ;
 spf=pass (domain: siemens.com, ip: 40.107.249.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpe1XibGpo8ZuS7g7XpWZFIeLn0pealN8AefVZ7Ex3xShuSZ7zrwI2yI5qEmqacqAtym05LGc7gX76nnv8YqW2fr2MUxyRqcLjSL4NdYvjpU5ttU/Hc5XNCtet8X6BVyxEaOCY9+msAYfgL4e1TZhvjJqU7IJ9RpE9WeuPL0Koz3altxkVVumWZIoBFuEi9FQfhDzCCsKogrD5E68ZG5rrCFHlUjZ5gEgYLHst4sPPtoaWy9gTfeaVuOKzRQ5TEZ1M5wargsbmSfLkv5fqGT8SHC9v3jU/fsodgi8AoWS4Jo8SD3jHzADTAAcYHTsEPMxPb3WcuvK6j8ZMzW9O16dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzhGxxj4usxjCyjEphS2pCqWePXZ5crkG+/jOMl7p/M=;
 b=WP4ceePfgtrh1UC7Md6AP4Mmws6JSjLrmuQn+14TBC/a9IFgIU9sswU8PvWWqwd5E7uis4Q7vahG0vLNoGNZBUco/Ay4z0scNIPwbCOds+NRwPdYX/mFskEenrXF3FaHt4y5R0haYhplKhiP9eY7GZg/oXahd7fdocAAHSTtTUDL2BbLq1KRFwgJ/6N/0YcXk6S2z4FP3Ul/qvKuObsY6ry5hwWoCpiyMy3Kv7L01bwJsKR15xMX/6tGiUcrwA3v7e/KV4kHD4xj/zx/Xel+hV7s1/QnOv+6lj792h6Vi4c4+tiG347xpco5saVjAQoki3LXRf2pw4/77eRpXSWADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzhGxxj4usxjCyjEphS2pCqWePXZ5crkG+/jOMl7p/M=;
 b=qROJNKRZoul4BJFXZwBynL+bd8lAAvQzvLytphqfM68Pa6WZX9jYgTA0OD1YfJYStshGIpKKXZ5zgZ2YN7OIEd1tQOx8aka8UYnIN1PWJMEGOg0V4uZ0NNagiJE9m2+9w2XiueSXSSY/HBOLBXwtBxiU9j44p/gu8wcuWl1NY2fWvPFYTJMsEyM+BUeKO77te9i0BdU/EsGSeAhL1/E8LlFsczd3bOxmOMbthY695vpu/hyyLpI+6VFqYAQsiY9P3oVpeZHqtQGnntA8pC/FO7UcXC0mHrgQ2nUIAZPE4ZWl+AAE5FDTzC8aq497gDE0u+52yo4GLMPi2cQOcq714w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7431.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 04:54:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 04:54:32 +0000
Message-ID: <135b9579-f0f9-496f-90a3-dff084aba3d5@siemens.com>
Date: Fri, 9 May 2025 06:54:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip98-rt55,
 4.19.325-cip120, 6.1.134-cip41-rt22, 6.1.137-cip42
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: a15bc59f-df92-4f28-5abc-08dd8eb59662
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N2FKZW5FRGk5cDFmNEpvWTdYUHNwMGtoaXB5RGt5V3dsbGJWZVV5aEtQOG5Q?=
 =?utf-8?B?Wm5tb0syTWt1N05aeXg2YnVaQUdlRVU2eTVjT2t3V0NtaWx5REpSRjdkSFEw?=
 =?utf-8?B?RVBlQ2JONG9PUTRJc0pCNjNwVWlLeXVJMk1NNWdrY3RzZHdDWjFBVVNaUVk5?=
 =?utf-8?B?VXdLQ0gzWGpQU0xJMGpGMjlOcWJwNXZlNkRJWlhTcWlVemRHemZWRXlVRkNI?=
 =?utf-8?B?alA0cDFvdVdoZVRXSThHaGwxOFZOYkY4SzZHVHZOaHZCMnplVGV4T05HZkEw?=
 =?utf-8?B?d0xqa3duelllM2pscHpTNUtqQ1JkRXNjMXlZWSt0M1dqNWtWaTdnVkV5emxO?=
 =?utf-8?B?ekg4YTdNcG9iK2twU3JadTI2UVZIamNnUTI0VkI0N3dPcFRPczRrTW5qWC9P?=
 =?utf-8?B?T3ZNTVFFWjgvYVl5WmFvYjdyOUFNMmRENm9YaGVmZjh3aEtjWnFSeWNrVEY3?=
 =?utf-8?B?TTIwcFQvZ1BUcVdpa29mYU1HdEM0ZmJyL0VhWWRmZTMxR0pWZ01PdXhPcHFp?=
 =?utf-8?B?amVZSkNwUlZCS3pkL0dFUEVOUmFkdDhrellFdlByaWRIOEUrQVlQdjE2RDlN?=
 =?utf-8?B?ZlpvbDRTalZaUFREcWw2QXdsejN4N2ZZcThhNVhSeDJ4dnZ0Nll2ellFQ09j?=
 =?utf-8?B?U1p4UHBNVllLWlI3ZkdXcS9xTlNkSlNvbFpyOUFLa2N0MFJhYnVzZTZxNWEv?=
 =?utf-8?B?MWlNL0JkUEpmVVE4aFA5dTZqMVNYNzQ2UVpiZ0NGQzlIUTRzQmtRK0xBSWlF?=
 =?utf-8?B?SDNnZHlxZTRndXFtNytKZCs0MEl1T3QrSGZGR0xueUt4Mk04cFEzT3pIYW94?=
 =?utf-8?B?dGRHZ0Y0SUNXSmNESDJ5Qy9HbWRpOE1oVlcwTTZRYlNQOTRoUU5zNDM2aldj?=
 =?utf-8?B?WDVVd3F5V3lhekR5K3Y5T2VHajB6c3B1QVU4eUpmVExaZVFNSmFqaSs4eldv?=
 =?utf-8?B?UWh0bFdxSjVzd1dqOUtTUGpMd0ppeXVCVXh3OXNvR3hiZGgwdk5reXZoQ2xj?=
 =?utf-8?B?eGlSaEN6M2ZhWWJneDlPOTF2RWI3dmt5NzBTTm9SVy94dklPQjBOa24wMlhT?=
 =?utf-8?B?VDFsRERSZ2Y2dHpPd0RyNnY1ZXF0d2NEZVVmdGJ6SWxuV1N1S2hCcGVOOHpu?=
 =?utf-8?B?SUtJQktJQ09FbHVuV2RQTnZvMGV1Y3dlWXMrcFFvNnFKU2ZTclNnS0RiNVpi?=
 =?utf-8?B?akZYY2txRnAxTVF1U3ErNDdjQ2pKc3k5b1ZHUkk0cW5hZ1BGQmlQK0hDUUFz?=
 =?utf-8?B?VzBva3I1czJvYTYrMGNVOWJUWDlvMU9qRzVpYVlXWW0rOWU5eHBaNFBIWlZS?=
 =?utf-8?B?K1o0aU1VcHY0QU5qbytBUTBqYlRvL0Y2eDlpdHhtL3pURlEyY0ZEcnRJY3ho?=
 =?utf-8?B?YlBZV3lJMUhCOHZzK05GODNtTG5UM29TOW50cXFwSEpjcTRGMjFUendhMndO?=
 =?utf-8?B?RVdrU2hvNmhvVkdHRUNQeURTSjdkaDc2QnhpNnFONVRUQ00xOFovMjdGSzJi?=
 =?utf-8?B?QUxjODlybHVtbzdVVVc3amFvVDV1dEM1clVlYjZJZkk2MkkvSi9RK3d0WmFO?=
 =?utf-8?B?RUFmUmk0V1lOL05JczE1aVYyYmZlWlhMRG5VY1BFb0RQN0FVeHJ6STRFYU1M?=
 =?utf-8?B?MUpKdDdLWm1vOERuSENZb1pDYlZwMmIwUVBsMGxWdnVWNGlwTVRITFJ6c1cv?=
 =?utf-8?B?eHNCSmxTODhtQmhFbHBUTXBJbmMyc050UVRXRmtRUnVCa0RidTJqeWMzYnRG?=
 =?utf-8?B?YnQ2dW5jZ0xXeFhLcDVYa204TCsrSU9UbUk2aEhCV0swZ01ISmlqanFiUVdF?=
 =?utf-8?B?dzIyc2RZU0pYMzdYeXA4SWdEUFcrSmt0YldyTm9jTEUvMElENy9uSmNmWFR2?=
 =?utf-8?B?V28wTTRKSkJDdUFxZFZCTzBLbjcraHZvUXJIT0pFbXd4Vmc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEVpSWROTjhpWE13Yi9WWWdQWFl1RXpyVnIvcEVwaVc0clVhOHFDTmMzR2Zs?=
 =?utf-8?B?ek9HNlpyR0NNNVFlaWY0R1VtcCtpZHZlbStQb0hXMWs5OGthU1pON1lyMXpm?=
 =?utf-8?B?bHNoUjYzVGlkalduSmFQQnhyRFZJUjAxaDkzOHpnRENDWWZQMFg3WFpGV0Zn?=
 =?utf-8?B?aEFlWHVFWEM0ZG1zQVBOeTdDUmtQM1Y1ZFhzeXJxR3NKVFlrVXcvSVFPL29N?=
 =?utf-8?B?T0FBa21nMzBhV2p4TUVUUWVrT1BkV0dzMTY0VnJwTW04c2szWnRwZ0ViTUFJ?=
 =?utf-8?B?ZmRhYk9TblRRTTdwRVMxN3lveGpCVXJ6R1hPSXRYNHl2ZStFZE1UTUxqbzJZ?=
 =?utf-8?B?WnVUQ1FVRVhvYW5RclREQXZvcmhWbEFGV21OZkJkQzZSODNDYWdkZVZEU05X?=
 =?utf-8?B?b25TSmxaRGtUTDlIWmxhL1NiOE0xanozN3JUOGRLa09HZFhjYUczNEVobVMy?=
 =?utf-8?B?M1dSbVVzVlJ6THBxMUVmazh1M21jYWxJaVk1akNLV2lNbmxpWmlFNjV6OEVr?=
 =?utf-8?B?M3NicnVLUHdaSlhRUFVlQnVLckZEMG5nYkduTTZwSWt2dUVYeVVveU1PblB6?=
 =?utf-8?B?Q0F3SFdENnQzVHczV3dEdGVjNlBPcmNaSU9vcEpTc0JteTdCZ1pITENnMy9W?=
 =?utf-8?B?UzUxWkVuS0hyMkpPaGo2cFZFb2VaNzlMQ1J4OWNSVktHRW5xTnhmRG5oUnZD?=
 =?utf-8?B?VEl6YWgzNW5WdlhiQ3ZCakltWXltZElHR3E1MnY4MUpBRE1JMExOWVJURE14?=
 =?utf-8?B?Y0o0SDQveklRUFZsUUhiUUNKMFJzNGE5NWhpWVBVckV1M2N2a3B4dWEyVTA0?=
 =?utf-8?B?RWl5MWdHQkR6WkZjUFFWeEJuKzdWcjhheWxhYTFYL1lTdzJlTE1YMEdDeUNu?=
 =?utf-8?B?d0NFU250alZpWmRSRWQwaFRSU2RHT0RFd2NsRFRhMXVpMHNQRURBcng4eHlG?=
 =?utf-8?B?UThWaVY4YkJEYzB6bjZpVlZHWitUdE5HSGQrWnIyK3VHczJVa3dRd0lYM2Nm?=
 =?utf-8?B?N0RJcG9FNXptaGExdmVldXJINzZyUmZ2MmJUd0xwT21DaTVJNktqV2U4c0xi?=
 =?utf-8?B?Umt0YVkxZ29oMmVCdjJCSWNlZ1lSNXh2YVprdU9qZ3JCMy81RVVTUXhEMVNk?=
 =?utf-8?B?bDJ6RyttZUlweU9heCtQOHpmM1NkeEdibGd1T3VXRkwrcGNGSmNqbk9DVUV5?=
 =?utf-8?B?VVFIZmlyNStuTkUydlpkOXYwTHU0KysxM1VXUjRCZXorbm1sVHdPR0ZKdzN2?=
 =?utf-8?B?NU5INDVadm84NWhMdTRRRXMzYUY2TVorelNpWUJFclZIWUJqRGZXd0JEMk1o?=
 =?utf-8?B?WkhEekJ5THlTcStVdzdrb1AvMFlxUTZXR0RXSVRJc2h6a1ZTS1NvUFR0azAv?=
 =?utf-8?B?cDdnK1BTN3ltUXZSdituV3RJMDQ5UVFWUkhkT3ZZVzhURFhHKzJ4OU56L3lC?=
 =?utf-8?B?WVNydkRudkJVR0EvTWpTc2FxTktQMlhXbEs0ZS9LQTdsYkFPQUVlL3pmQi9E?=
 =?utf-8?B?REZNM3BmN1JlOW5IV3l3aHZoM1NWdU92eVFUbGxuL1NBYWV5b0hVNmpaSUNw?=
 =?utf-8?B?RG1TaFI5VDlFOXNXMC9udzYzSTNvNm5pVVpScXBoRTFTdkJLRFdBRSthZU5x?=
 =?utf-8?B?S1l2b2l1SkdabHZUUGQxdkc2ZEFmck9qYTNFNGVyTmdxODFuREVYNUlwdEs0?=
 =?utf-8?B?cVd1SEU0MjkzQk13TkVXbEV2b3ltcVA3bEM0WENpWkU3ZXVvdXd2OEtPM2pN?=
 =?utf-8?B?aG1xQWZsVUE1OHdrYTJONSt3anFPZk9CQW9TSFgwV0tvTkJJSjR6ZnQ4ZzlW?=
 =?utf-8?B?V1FsN0JlcU1iZThVL3RBQ1p2SE1sdWtHRk5hYklrOEJaWFRXUHM1YktiaVJt?=
 =?utf-8?B?WXJOZTljQjFxa2hUYSs4QzdGTDFKRmZXclJVSjJ2aENRRzBncExJMEV0WGZm?=
 =?utf-8?B?dllRU3Vua0laR1EvZWtWZVhrZ2JRRXRkSXdXM1VJUDg1eGlvclFEa0J1TWN6?=
 =?utf-8?B?NHVNaWF3VEVaWVNFODB5OXpMUmorNGZJRE4zcStSVjhBbnhVcmFNczRyZk9m?=
 =?utf-8?B?a3pCZW9UakZsckpUNmIzaU9DTkRWeS9HRDNneWFzSm1ZS1FMQm1DVXordTgw?=
 =?utf-8?B?b1FScHFsajlIR0NMUEE3b3QvRnphMmY3TTMvM0ZER2wzUXpIcW40M1NnbTJ1?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15bc59f-df92-4f28-5abc-08dd8eb59662
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 04:54:32.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6EcpSKyOOWLRnKWTVormCy1h5/Hf7QuUqRonUoIG1ZtO3YxIVwFm9yD0Ojt7ApXFLAshsDzYf5BOE1rGmvonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 04:54:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18785

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip97-rt54.bb => linux-cip-rt_4.4.302-cip98-rt55.bb} | 2 +-
 ...6.1.132-cip40-rt21.bb => linux-cip-rt_6.1.134-cip41-rt22.bb} | 2 +-
 ...inux-cip_4.19.325-cip119.bb => linux-cip_4.19.325-cip120.bb} | 2 +-
 .../{linux-cip_6.1.134-cip41.bb => linux-cip_6.1.137-cip42.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip97-rt54.bb => linux-cip-rt_4.4.302-cip98-rt55.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.132-cip40-rt21.bb => linux-cip-rt_6.1.134-cip41-rt22.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip119.bb => linux-cip_4.19.325-cip120.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.134-cip41.bb => linux-cip_6.1.137-cip42.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
index 6d4f6ea4..f66c06ea 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip97-rt54.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "bda79ae2ec79d9f56c958703a0cb774d472a722c224b9f1f5239e3b820298b63"
+SRC_URI[sha256sum] = "70e223852d3a7f711dd511524243df512dcc7799010004b4d99e0acf1f95866a"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
index e151c1c8..eafe09b8 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.132-cip40-rt21.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "788e9169d1b41132ff980a6b6120cca5ae5d951ea9d01c26c6d40a82e0835e83"
+SRC_URI[sha256sum] = "8582da7b30925237cf4905988aefe0a8de23bb4e7546e6ebb998419ee121fa7e"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip119.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip119.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
index 4c6a1cca..9bdf79c0 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip119.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "fa4074ce57bcbc0b33502e9af8c3999cc3059cb3a51454293126bdc90a944606"
+SRC_URI[sha256sum] = "9149d5ce9bd1a27ebb67358db8c81ef5c3e960c196007d501b731295ce8f7f69"
diff --git a/recipes-kernel/linux/linux-cip_6.1.134-cip41.bb b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.134-cip41.bb
rename to recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
index 7ffc745b..124c205d 100644
--- a/recipes-kernel/linux/linux-cip_6.1.134-cip41.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "ce52d230840ff625fe14a0ebc094c181a869f7004ff3fe28bad393d627d1dd67"
+SRC_URI[sha256sum] = "05e279c5e955e96c85be7f8b19b3cd7aba109343d7837bbfa9b9a1b6362ecf2b"
-- 
2.43.0

