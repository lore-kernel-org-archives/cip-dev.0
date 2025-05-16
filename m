Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A6C3ABD8
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 09:31:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web10.9357.1747387898850596671
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 May 2025 02:31:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cKm4ISMi;
 spf=pass (domain: siemens.com, ip: 40.107.21.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSkPH4V9ptYRRXdkvegyIHnYLfCMvzlm/p+w4xRHMNd1ATTe04JTM3dprD9lflsdbIkQAWWgHf/cZC592EtSvb5RbH131Vyx/mLManlaJVDhW6+FCO6gyIm/EgC1MrWdqMVEFCsQRTnAYZBXoXy3eLZwS8cEhhGMySs0K6kM7BVND2D+VdVfp23RLQjQXE5f9ypJzEH1ceLhHTp7JfZ4xwrt0WTa5+hCr0hbbvFUmkcr450T7o4rEd9HwnurOQwVCa2WXMKJcSoA3IMabxzyYDQMFELlCvnuOf9wjDj6S+L3GpIfVZ0hXxWsG0ZG5lm+wBb+XMft7kZ/fum7sR9S7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTdit6jrXwyjcSE0NBx6MNBb52w27sKEaMT5cLSrID0=;
 b=kd+BW7Sr+MVekM5BDZP1cxSzTd+ea0bsPhZl+q6fzMSqHhu+EtWEbSw9jLv4g4zfYiHkjzWdIgMTXNQ+lYMFWQ1IqumZV52Ln/p4fZ54Heo63ol+4n31FFCk25GSIfkUiH2I2XG50VJS2eU/caIcvAdlBn0MammUoFQVPU1cVufHcUj7InlxqU5MH4n/XSq9n/sC5shVTwRyRfxbUY/V3q1qbci6zFzetOr8+T7JMqxheqB/wpxiQvj8Jo4lOiX6IEh6sv4d7vWHsUXJuaHZEzYM0gp6tNZS/ZU1yjReGvscjFndnXZ+idstgCp/IVbjfNxhQ9U37jWHKjxTrc5ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTdit6jrXwyjcSE0NBx6MNBb52w27sKEaMT5cLSrID0=;
 b=cKm4ISMia5LrX3fpoBza5waiH+sXO1amuCuNz3+HI02dtMKC0LHsGv/iyP/pQeVtjXQrwEpzs60Wx3yrpb2g4xjzU/qWwBlZF+5rf/yUvNwUAFdIp2jJPhbyxYp+GqWRmNrduPZKN5Kue70VSgWvvoRUWP+pgiOz6G4FOS2TMRtPr7F3g+d6pI3l2Nkz1J4GmkFrfnnBCBJbxyAx/DYDrKPYdmFvDdRSsbsIRYgtesaljLysJrh0KakMy9v+YliqC5r4BGnio89lKUZJa21VDm1kS3MKEzLc7xmU8Lj9I1P9WFLU+ZCOi1jjo7TCBK8lq9TKGSB285xwFkgU4P+1Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 09:31:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:31:34 +0000
Message-ID: <46d217f4-b34b-4f75-80f7-04431d6f28a0@siemens.com>
Date: Fri, 16 May 2025 11:31:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip99,
 5.10.237-cip60-[rt26]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4678f9e7-dfb4-40ac-bba8-08dd945c72c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1psYWVrcG5ycWVWcEpXUmZVWUVZdXk0elhzaFE3Y0pQTWFZWXNYR3dvVjJr?=
 =?utf-8?B?RzI0V2pQMnhTR1VNV3JjMmM1YlZ2UlA4T09KcnJBRWhsQUhUd2RwS2daR2Vp?=
 =?utf-8?B?b0kzS01Ock54VnB1SUNsUmp2bW4yR0hrRUVZVUZKQW5mZUVEcW1ld29SRXlm?=
 =?utf-8?B?UnFUZnFNYkpKNmcvc2YvVFNzVEgzSGJUbzNnL2NaeGNVSXltKzdoUGd2cUNY?=
 =?utf-8?B?UFBVMDg0K3V2cU5YVklJeWxCNFMwbEs1TWJhYU9uYmxGTUxKN3lhKzlMY3NM?=
 =?utf-8?B?cXhkZHVqNE9CeXZPeXBPd3NyYkxZSDN6RTJDdUJmdlZBUTlzMlE0MmlHdjJU?=
 =?utf-8?B?M1d0TWR6akRONWZGWnd0SEcrV2I3U0s4cEdsNWVjR2NsQ2FUZTM2cmhrbGdO?=
 =?utf-8?B?ejlqSVh6Rk9lb0xjSEZFRmRORXZKdEx4bG5IWWxrendBM01vcFNrNjdvRUxy?=
 =?utf-8?B?R0FyRmd1c2dQcDNFSDlhbW5hOXl1N2lFSy9VMW1GTTQyRk1HVHN3c1YyV3FI?=
 =?utf-8?B?Y3N3cUhiUWU2TXhQUnJ1UmxRcFlmbG12MHRnNmlTU3luMXpFOVVpRE9US1px?=
 =?utf-8?B?ck1CNDB6RlUxTC9LVHhNeS9sUU5IQVBxWnRGcXQ2VHBRVVlWbjRUMTFJczJ4?=
 =?utf-8?B?SUg5dkJ4aXl5UkwrenEyQ2FOWVhCbS9QVDBjQTRoazZLVmhxeGI0TzhFUUFm?=
 =?utf-8?B?enRVNEtTQTlRRmw5aVpuUkxyQjhxQXdsb255TUtDcjd5eU5pZlF6cSt6WTZ3?=
 =?utf-8?B?bmk4MWVxeVZXU2gwTXF5dHM5THVZTTdmRmlKWHhuMXd0UXZkeFhhcXpKRUt3?=
 =?utf-8?B?YlZGVHNqN1BabzVYTDh6elBpU2pVQk9CK2UwWTFKNkhqdDZocEQ4TlorYW91?=
 =?utf-8?B?bmhiZ0p3YnVDTk90d3J3ZDVEbVQzNFM3M1A1eVJWbTdEVyttVnBqVnZQb3Zo?=
 =?utf-8?B?Yk0zaEErYXpMUWhycDUwaDUxMUJKbFdpZkJBaXEzN2tvTGtWNGhtdzZaRmIw?=
 =?utf-8?B?ZHJ4WndhY214ZDVBR0VwWVJSSCs2M3VBdFNPcVFEdWdBRW1RS2FBUHVINXk0?=
 =?utf-8?B?eUVHaE1JVUtUek52bFg2QjdyaDAya01mVWxSVDdlUE5Cbkxpa3VsNTRPMUI4?=
 =?utf-8?B?ZEVLQXhpbG5jMU5FQWtiN3YvVW9ZemE3U21wcGUrNVJoZkdOejFYVDl1dytv?=
 =?utf-8?B?dGJCTnRyVnhOTnovaWcwL3RvUWRNa09jUXpiemQ5V2lhOHhsTWZRUGI3S3k0?=
 =?utf-8?B?ZDgydGhQSE5yK0lMaThXbFpGbDBIMCtROTBIUlpPalQyRW9jaTFTZkJyYWlO?=
 =?utf-8?B?S004KzNWMUpPREFnRWtkRnNVWVZkeW1hdEU2bnZSdmNDMjlyQkdEUTRZbFVG?=
 =?utf-8?B?aGNqTm92WGJ6WUhKeWFGWDR4czIyNkNmbU8wSHVWZ05sR2dFUkZTb0Z1RElG?=
 =?utf-8?B?bmxzT1NmTUkzUk1GTFk4ZDVTSVhway9waTJqUGRmTmdSNW1WeTBmMVY0bjdw?=
 =?utf-8?B?T29kck5TTFMwR202TjE2VllCeDlBNWpFTnJuTFBwS1dyWUZBSXI3eS9BT0Zj?=
 =?utf-8?B?dlp3MXlCa1BJWUdVelRvZ0V5a1hCb0dQYWRTdFBYNWFqd2VaMU82ME1DSDdl?=
 =?utf-8?B?RmRXb3ErVzRaWUpRM3U3enN2SkpVdVZJYzhVdC9nSDlkRDNlUmJCZnkwUXJj?=
 =?utf-8?B?WS9JYWU0eFJqUFErRzYzZ2hXa29XQ0RJWCsrWG1XdUw1TUNYWGdzaGJ1Y29G?=
 =?utf-8?B?MUZUVGNrcTF3eUtzZ1BRM3B6N0xPbUFkVW1aOHFrbW9sWDVOUURJVDJIN09M?=
 =?utf-8?B?MDdDazc2UXBnUi8rc2VuTlhBV05kbkRhWjlUR3krVHNYajZMeTdUay9XMVEw?=
 =?utf-8?B?cU50cWhFcHFXdXJQUFVKb1B2K1R3NHBDdG9SQ0hCTVkrWjQzSVlXc1dtbjM3?=
 =?utf-8?Q?rQjOphBbopg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWpDS0ZrdHdEY1NsSDJHM3I0dXliWk9HbHp6dGVNVDlzQzRpVXBhQ0hWVVpn?=
 =?utf-8?B?NWxES0pMUFJGWDR4NDVTcG5nUi9UK0xSdnZtSldpY0ptTVh4end6VlQwNXgx?=
 =?utf-8?B?SThmKzlBZWpvQ3VkQmdDTUFRRDhjS1A4TG5uOVZXRktNVFdrTStSOTJFOXBx?=
 =?utf-8?B?cHpjbWhkcmpKc0ZDRlZScXN1V2sycVljUnVhK3h6RFRrVEdscEx1WU5wbWJN?=
 =?utf-8?B?RlBmSmFvY0hIcWIrK2lEWVVrajNMUG5XOU04M2dWVFRmNkhsTndNckI1Q0RR?=
 =?utf-8?B?dUhya1J3eSttSUprYjIyR1FaMGZ3M3ltSFhPM1dZbzBpSmxRem11YjJVajk3?=
 =?utf-8?B?ZWk4emlXTzJrMHNENklDcjQ0bWNtRnNNaEg5WlpPQlR0N2cyK2hTWGdtNDVW?=
 =?utf-8?B?emVyUWNiZUF1RCtOVmhUWExEbmxBaVdTVE9vSXdnZjY5M1FXRGpMK0pJS1lW?=
 =?utf-8?B?OWFFaUs2L1d5bklKTGN5bEtzaE9adDQ2MkszYzVpRXdtYVJFMFVxc1dzeStk?=
 =?utf-8?B?ZnA2MW9La08zbU1QUTJYMXFITEo0b2c2Y1dRb0pZbjMxK3RHeVppcVM5V0Nn?=
 =?utf-8?B?MUEzQlY5TFllZ0J6R05CckpIWUNRdnAyYnh6QXdoTHcvUGF6ektYaSs0Skhs?=
 =?utf-8?B?TERNaEZoREtFQlgraXZOQmk1bGJISERTNVJ6dXpsSWdtaHhJZCtGWEFEc0xo?=
 =?utf-8?B?U3lIc2dQTG5zUjQwQ1NqK0sybDhKZ0Mrb0lBVXM5YW1HWFJSU0ZJTkExRUhU?=
 =?utf-8?B?K0tuR3o2TnBTeEpuTDBIZXJYVk0yeVhBNmFUZ096Qlc5TS9ZYmQyajYyR01E?=
 =?utf-8?B?T0tRYjNmVlI3enZNTndvZ1VLMEc0TUN0c3F0ZHV3U0RrRDVUc1NBU0orZEY5?=
 =?utf-8?B?WGpkSWY2ZkdUa0k5K3RsTlF4U09nc1ZMZ295MlFVdjlWTUZMeFlHaHloMllD?=
 =?utf-8?B?VW53N2ZsbzBFa2U0N3NWeE9OZXUyU2VLNzUwdVN2NEFuMEE2dlBPTi94U0Vt?=
 =?utf-8?B?TzcrQ2lBVW1Sc2RVOGxVUCtaZHEreVpnd0EwL2svTTF3VlhFODBKdHRvSS9P?=
 =?utf-8?B?WTdNaW03bi9mSmJ5RXVHem9FeVZwYVFMTEd1aXUydjM5Ykd4TGNOMkxTRW92?=
 =?utf-8?B?YzRBQUlLa1Y1WFdZUEQwbTNVSlgvT2ttUXQzd29ObG84bkE4L1hudVBvTnZ4?=
 =?utf-8?B?aGR6YWlSNjc4RnFINTJvWXBqcW9XWTVsNXozVjZrcXdmdkVRK0I4blZJTEtO?=
 =?utf-8?B?WkxLYnJ2TWxuVzV5NGRSWTBGeFVIb1hoNS9YL3c5ZmVpcVpJRTd4SzBCQWd5?=
 =?utf-8?B?YkdITTZkRWpXSnlCclBBVjJtWk0vSUEyZnZZckpZdW94ODJrL2dlOWJjWnZj?=
 =?utf-8?B?c3phTHRBQUhXcVlFdXoxTnRXRWlqKzN0Nk14R1pXczl5RDVzMU1OVjJ2SWNZ?=
 =?utf-8?B?UnhhSDFSREp3d0lZSVRJZ1hXNWF4aDNDL1hnMzFwZldWLzJyME5SSXZpU2tV?=
 =?utf-8?B?aWZGemM1MU45RHpmYzdpRVBTOGhzNG9xQ21HS2syNWVWOXpoWkswdjNvUHdK?=
 =?utf-8?B?NEl0T0lMR253NmhuRE1aK1J5ak9VdFY3L2Q0ZnR2U1dCT3BrY0NmWHE2Sko2?=
 =?utf-8?B?b3FHNDBhem1vVWhQek53cTdsY3l2SG5NYVRHRkd2d2Q3cmxtejU0OWZJOVdW?=
 =?utf-8?B?TmwvMGlJY29jL0NqUjlCZU1LZFF2OUorZURwdWVVREFLbVFIaUp4YmFQMHNN?=
 =?utf-8?B?VUVTa3ZUZ1ZDMTI3MHpBN09IeCtZdStnNmtRUWlXbk9Sc3BPanFvZGErNUxP?=
 =?utf-8?B?QlJhNXJacVprTy9OWkV0dTNCc2xVb21YckZtQzVEcVcrR29hMDNNd3ZQNkZv?=
 =?utf-8?B?SnVBUTE3UmpTZTRnK2RLYXV4cVJUUGhTS1lZbWVxdzBJd0dHVW95d0toMjkv?=
 =?utf-8?B?U295RTk0cWtpRTlmU3UySUtFUlBCMkVFVzhMRmtXWDNzc0FmbThQekxLV2RK?=
 =?utf-8?B?RUEvRVA3UUc2M0JTcXNscngybWllMlNpUHdFS0JEeHZSdisxek9vaDlxeEJM?=
 =?utf-8?B?eHB6RDRuUHdXZDgwSXJoZlVETmdRWWtnWXF3cHRhcWRnbVljR3ZIU3hnM2lz?=
 =?utf-8?B?amRhNmxqQzJhNUhaZVUzVmVieURDenliVmtXZlVESnozVVhWYTQ3NFZObFJR?=
 =?utf-8?Q?tMqtUFCUoSSjCN56kazD9w69j6hgC9GMCYYhsP3plpBW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4678f9e7-dfb4-40ac-bba8-08dd945c72c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:31:34.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alabKMUY6qEo6hn/U+EJojiuF3uVOe9YsanqoW6YGLsvxvsblLrEjxhxHZCimZ1n5L8E3JdBCz57FsPL0SNyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 May 2025 09:31:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18921

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.234-cip57-rt25.bb => linux-cip-rt_5.10.237-cip60-rt26.bb} | 2 +-
 .../{linux-cip_4.4.302-cip98.bb => linux-cip_4.4.302-cip99.bb}  | 2 +-
 ...{linux-cip_5.10.236-cip59.bb => linux-cip_5.10.237-cip60.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.234-cip57-rt25.bb => linux-cip-rt_5.10.237-cip60-rt26.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip98.bb => linux-cip_4.4.302-cip99.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.236-cip59.bb => linux-cip_5.10.237-cip60.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
index e4ca8394..212b0937 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "96dbd4ee8e782387faf8bdb4065c7c95733fd320d79d0fb387b9c5824e8a0e92"
+SRC_URI[sha256sum] = "e2d8fae539c6429e1680b9875b6b6c16792ee20a85d47b6f8c8227ef679c9886"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip98.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip98.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
index 07fcbf95..4eea2e79 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip98.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "6d9676ddff825d5a54bdc0a05a7438ed9904add5bfd1c16605933be92be5c004"
+SRC_URI[sha256sum] = "ecc90814484dff84dae3f25ac2da7eb9156dc43c18acf2e806dc71ed4800b558"
diff --git a/recipes-kernel/linux/linux-cip_5.10.236-cip59.bb b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.236-cip59.bb
rename to recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
index 5944fa6f..7cad5613 100644
--- a/recipes-kernel/linux/linux-cip_5.10.236-cip59.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7736cc18c665e9574d954eb58e1420abc2eebb17333c0b7508f2ed15e829c2a5"
+SRC_URI[sha256sum] = "be99dae17d2989965dc6dae2092067332f9965df0dcee8b7d517b823aac67990"
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

