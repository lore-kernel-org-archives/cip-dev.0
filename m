Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2550CAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 10:27:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.40])
 by mx.groups.io with SMTP id smtpd.web10.14119.1758882457463043903
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Sep 2025 03:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OzkegBNW;
 spf=pass (domain: siemens.com, ip: 40.107.130.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuMQc7uNFx+Fp9jhWK5giZdlM0oUOODGzNZAoUbq0SiR+k7XzC8M6GtETpUykr4wN6TUNnIZOtPlK6OuDvqFMfWUdUE8Rdt8+klRTGgIA9KSPvyoLIh57UgQheIDezxbrJpLXPOe2wgVRTsGIyl/42b/9fYU9UMTvB3XOJKjGw5mRTQSXYk363kKc5FFJVrcQr4Jd2DI1HKSGyb5zOY98BXG5uUZnhK/ruD3ezFMLgvoddlcEgLlFx7TgX3TaaMXqsvT04Xp0R3o7bFtZ4bm/BbQnsGvb6PcXfMhujz86Qzw4jYI94Z/ZgdR8rGXvG95nv4ze/4cYaQRB1NpNPkIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS9a9amp3aeTeCWovyCcDsO4n/PvhW7ngE5sbnKTb5I=;
 b=zLgqVTMLlRlgB3zdjdeeHSZn9qih7RSpUHYg4PhkABTNsXZFtdzhRRykEodGcM6zoO01eS4eFP+Hm0z34aLMth8q3xnQYJh7ornFK0GfzvMh+1CXqyrlI5cHcMMq1VwlxE3Xzs/SHDtF1l/73coT8d/PwK7m4Q9/nkSvK4mYjzTTOyvF3kKU0N7SSmMIJ5kwiD5abeE5z3oZjI4fKbXr2noVNX5PYCX8vhBDueZ5QRtvhz1iqT3zMtnmL1tSnihKBZonE5+4qFtfHKB7TcYmvLg8wdmWMqrAwcvDkjZxXqxJpjVAbZSoR4kc/aHIasZY7zpLh8dtvDz+Jhuxc1dspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS9a9amp3aeTeCWovyCcDsO4n/PvhW7ngE5sbnKTb5I=;
 b=OzkegBNWFm7C1wgKk86QkNhIZNjUOAlRgRTuM6zXF1v7jzt5Apn9s4zEsCrHiCtnLNw0FTz50SoOwrVYG0BSuEwf1Gf2tTCwVnHwu0V7vVDOrZaaWRzLmsTVZUIXFYFb9yPpE1+iRxJ7lfeKjorSJq8BqfR1qE94tp5E9aG9E7/iVCHtquGoKYQY6hutXWBGVVmCR477VuD7KOsoLWnVm4G/nM9+SLTzcNiFviCE+XMVvISbiE4WOhs6/MhlVUuavR+zu6kg8A1mV4iZAJMxwMjSy/EvY7X1onEDW5kisIiYh/nToXErhbBXb725i1iv8JuuPXl4I/91VNRCfBUkgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:27:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 10:27:31 +0000
Message-ID: <e6511af3-6dfd-4176-ba1d-6379535775a0@siemens.com>
Date: Fri, 26 Sep 2025 12:27:30 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip124-rt44 and
 6.12.48-cip9
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 165e90f3-a2dd-41be-ec0a-08ddfce74d0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?anFqMklQQkVJeXBJOTRDNkY1YUVzQ21vekk4U0psa1NENXk1dWs0aVNuNVVM?=
 =?utf-8?B?ZDROZU1FcU8va0JCK1poV0RENjhZVkZKUGJIdzhFV2E2ZTcxcjU5N2ZyazVK?=
 =?utf-8?B?VnZGZVh1aHNqREs0S0lKcDFLbzdSSU41cnVlU0tFTjNSdGlOSzU2dWVvSlFv?=
 =?utf-8?B?ZlBTTGdwRDRsYnYwSXlpUHo5cEJ5clAySEQrd0RPeXVraXpEU29tV1EzN3VN?=
 =?utf-8?B?cHJTQlg0elhTMlozOHhEWlArTWVFaWhLOWtzZ3RXWlA5S1RKNmZzTDZtUDVD?=
 =?utf-8?B?OFVwSWkvcmlrTU9xY1g4MUs4OVJzdER1MjdSOFlYVHpPdFp0SVB2Z0d6U0Ns?=
 =?utf-8?B?RkF4WGpjc0lzSEh4MGswZXNDMzhteVZER2RUZHZnYUZZQm84RzZYSnEzU1dv?=
 =?utf-8?B?N0gycWtscGYwclFQK09KSDhQWWo2NWprZWVTM2o4SktUZnNxcm1CbVN6RVZH?=
 =?utf-8?B?eS9ybXVGRk56WGJvcEFid2VOai9SSXZEcUpQdVBZdHc3a3M2VXJMdlRoWkVJ?=
 =?utf-8?B?R0NZWjREMzgxL3pNczB3NTgrWUd6Z1JGR3Z1dEFjczdzK1BST1ZGVmRzL1JJ?=
 =?utf-8?B?NHNkMWpyNmo5NkdPY3RKa2VZT1phbmVFdFJtUHRBM2QvRmh0SzlZWkxxSGlv?=
 =?utf-8?B?Qm1VdFFGekdlVElWUXQxaTdKVk9sL2VaVGVnYm5xaW5mdHVsTUcySFFxejBr?=
 =?utf-8?B?UXcwN1pxbzZvZ0luOEtZeVpxbTdQZHVwSmd6aUN6ckJkbGtnRjVoSEU3NmdL?=
 =?utf-8?B?WDJ4QTJnaWlRdlZuY3Jtbnh6MHpFN21QNFpaaGdCSjVkUzE3bmVGTnl1aVpa?=
 =?utf-8?B?Z3hieHdQQWJxNEs0N1NxV2J3RFlhRUN6ZVA2U1NUeG1SaDQvYkF6MzM2TTZS?=
 =?utf-8?B?bVFBc2JhdUJRaHdPdU9DTndJQ2pmb3YwQnJxaUU4dU1jRHdWMjh5bFZzbkQ0?=
 =?utf-8?B?TENtbVJBRlBqK2JXS1JVaEFwanJpT1FmV0x0SStJL0lPR3BQRnVieWdOU2Nw?=
 =?utf-8?B?MHM3MjNYVWx0aGI4WVVZTDVIcDVjb3FQSi9HTlllbExaWklMUHQrVFhDdjBw?=
 =?utf-8?B?aktuNW53OWdvZUJ3SWVsY2ZPdmpHdlRRQ1hocGEvWVlwNXBXeGQwWEx6SUVM?=
 =?utf-8?B?VGJTYm56WlJUdnVLblgrWFVBOXZKeExBNGdpeU1mVnR1cVVHTk50YldVMmZV?=
 =?utf-8?B?bGpEaENXTXhaTU1wbEpqb1pEM1lkVjdzRXR0U0lkMElQcHljWTJydGs0R3J1?=
 =?utf-8?B?bGFCbm1uRWN6dDZBNHkvQnRzeEx2N1JMRTNTSmtRNXJhZzJmWnI1R2w0R1NQ?=
 =?utf-8?B?YjlZNmh6dXFRcHpQNTBlcHVvVndlWUlPVVRHMWxXbmJ5T2JjMWRxTFA5MTk4?=
 =?utf-8?B?TkJOSW96RkpuWVM3YkZlVk1Da3dnY2NhSVNsOUhnMnNuOEVVekVXczM3T0o5?=
 =?utf-8?B?K0tmTWlHQmNmMzFOYTV4WHAvd2QrNlZlTVIxU05aQ0VRcU5zK3N6YXdOVzBC?=
 =?utf-8?B?SGc4RlZvdDlrc0l5MGcyRlBscmswQ0xKYUpzSWxoWnJtNjNkM2V4OEU2Wloz?=
 =?utf-8?B?d2JCZDBaSng1SEk4T0ZSOWhkOWtDcDErUzMzNm5uUnlzTE9yWGpoWnIyTHZ4?=
 =?utf-8?B?RDJkU2EwaUlyQklveTNKS0piUG9PNjN3Wm1zSUZWTk9hemJmN0daQlRlUXdN?=
 =?utf-8?B?RWxyUjBlR25lRHlpNGZETlZSS1lJK3NEd1FyNXcxaFdCZ0hMOEJmeFEvSm9D?=
 =?utf-8?B?TVNsSHA2dWcwdy9UVFpNMWdrNmhDdTBnVE55SWpSMm9obkVDNDdrWFhXcE1p?=
 =?utf-8?B?OURGNlBtOGNYUHFENElKdVFLcGV0VFhUWkRCd200eU4xbzJqVERXeVYrR2Ry?=
 =?utf-8?B?V3RWa21UcWdzRWtlZU51NngwNnJxc2UzcGpTK3VmWERxR29GOWpYa0NuWUdV?=
 =?utf-8?Q?c4eIFkbnmtFS8n+Qe+vMsP9GjLY6oZ00?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0JtNlkwRVh2dTNEQlR4RFRoZHNPVFpiNU9JT3RVWElVU1dWQTVoRVNHSnZN?=
 =?utf-8?B?V0RLMkRIQndwSk5vVi9lSGFQbDV5SEpFdzM0RUxGemJ2cU5iZ2lnZHpvekFh?=
 =?utf-8?B?b056c0pDNEQvT0VnUWpUaldWQnIwTnd5TlJUN3VqUjI1MVhCNU1DWVliU251?=
 =?utf-8?B?SVJVdytpdmdHOFBicEtTeDVtdWkxNUhaM1o5bUxkWmxNdEpJc2ZxRHUzNmk1?=
 =?utf-8?B?UGdaT3h1WWxUWW9MNkZJN0E1U3dkODNoVTFiS0tZOUtzNVhna2xpcHB1TTA5?=
 =?utf-8?B?YXFXNUNrbGFwVlFvNzRNTmx1Vjc3N2FUUS8xK1RHSkp6Z1dINXlPOWprVmZZ?=
 =?utf-8?B?aG1LZXU1UjV5ZWxZTGFsWXVyUW5aQTFsZlFuYUlCYVhodGxSQ2MrZkNJSFVy?=
 =?utf-8?B?ZWN6YUN6TDdwVlZJVjU4NDJjd3QwSHBLc1REOHM2amxUMjBYcmxoUytvNVZ0?=
 =?utf-8?B?dFk4bHQ4Wkc1SkNHNjlsUFVsRjhFNHp4bktOdDBxTis2SzhNWmRJYU13ckdL?=
 =?utf-8?B?VStackJlOXphbVFvT2hTNTlKVmpNMHQ1Tkhyd04zZHQyN2RCaHg5YTJOTDJr?=
 =?utf-8?B?dUZXdTNFYzZNaFhKaGFWYnNjWjR6UFM4QUE3clhIMEcwaWdjbEV6WU91Qjdr?=
 =?utf-8?B?Mk9yb1pNdi9YTHZHMTduQVRkcXFqaDcyampJUTJ3Ylk3RVNFRVRQSHpWU1cx?=
 =?utf-8?B?aWkzdGVmVkxFNDlVcjFUTE5WL0VnZUxLOWtzYlBBVXdUUmdoK0VjTXFhUXpy?=
 =?utf-8?B?NkVXTDBvbVp2eExDTzNiN1ZrRXNvTGU2RnpnYnFUT21IUXhWMjJNL1NxTlVz?=
 =?utf-8?B?MTdOMW80bFdUdzR4SW50UEt4eDlXdkgrdzdVSysxbGhjTC9ySVBZSEpHNE9x?=
 =?utf-8?B?SDVGbzUwblJnMVppRlNJb2MxSXo1MkpLcUtFSmZtS0Z1TFVZYTdlNng3cW8x?=
 =?utf-8?B?VWJRSWNUdlBldnVGdExoUTJYRmVKNldrcy9NVThiWEJjNEo0SnJZNjlrelVF?=
 =?utf-8?B?REFaYzRPbGxncjRYRUpFelFHT0lqUS9SaVNGSDRKUGg5N2hWUjVRUEtBTEw0?=
 =?utf-8?B?cngrbWVvSG5xSmFrdEp3dWd3NitZZUZxMkpOWmY2R1BhUThCdUlidHh2ci9W?=
 =?utf-8?B?ZG9VaTJ3OHRFUlIvTGh4WW9GS0hvWjNiQll5UUVta0g2WFB2UVI5OHVmQkpa?=
 =?utf-8?B?eGZhN1gzSXRhd2ZVZW9xVFJQNS9PRnJMOFdnM2pMMXNQS3d0L2ozTmszeDZq?=
 =?utf-8?B?RzkrbjNVRTZ5YmVZeXhUWGF4dS84b216M0dJSFlFNkR3czFaL2M2VEwvak5E?=
 =?utf-8?B?U3dQQU5TM1JVeEdCakVycXB5UmhBQUZ2Y3QwVElIc0tYZzY0by9EbHZ4VGJo?=
 =?utf-8?B?ZFFnSHRXRVVBZmI3MWtSc3duWDRReUdoTy9SZXloOWlEOE54d1BUMEZhVHV2?=
 =?utf-8?B?RXczc2Z6TlpZTysraE1zdHNnNm9pV3RtTlkreXYvbTZMcWFCTkhvekVxU052?=
 =?utf-8?B?S2trMlR3eVZaZUZvajZ4TWFjdHB2UFNLTVRwNitqdURFdlVQTjJJUWZnTlM1?=
 =?utf-8?B?d2F4azJZTEtPT1haa1AzK1c5N25uZkhEYXRoQWpvRHhMNXZLc0FVYWpHak8r?=
 =?utf-8?B?dUtEYXl0bU5jVGpZK3hWZU1Nd1RWZ1VsbmYvanBDMFBqZFp3TEN3cTIxbUkr?=
 =?utf-8?B?dDlRaXlrTXVjZGFrNVF0SFZWUXRjVUQyemVlR2NOeTd1eW90QUQzazZkRGRt?=
 =?utf-8?B?K2RVelRFS2YzV1FSVjN1dmdRVGZtL2tzcmFHTVI2c1BTUXlXd3JJeWJqZ2x6?=
 =?utf-8?B?ZFVFZWxLUnRzR3F1c1pIVjcyei91QXhiVnkvSXh4dTMwTEw2SWV4dUZBc0do?=
 =?utf-8?B?Nmo3dkJjcGFVY2NrdFlrRW1pTGYzMWtkZHkrajFDOGhrZXU3MTBpTVRHTmlW?=
 =?utf-8?B?cllKbCtscXRHMERJVG1nQ3V3SXp2dG9iZjRkU29waUtZN2hleGo4b1VLejJu?=
 =?utf-8?B?UmJmZ0FRdVE5SHF3TmlZWDBWR3d0K0pVQ21HZXJXaWV6Rkk0QlZETWdHdXdw?=
 =?utf-8?B?LzZsWk04VnQrYmxUb3M4dW5HL1BlM3R0aTVualpoT09wUktIck1MRUhlY3JQ?=
 =?utf-8?Q?glFUCOa0mjGQM1xazv/ZQwGF+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e90f3-a2dd-41be-ec0a-08ddfce74d0f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:27:31.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eVLBGwFg9/zvfKg6y9PI8KdOj2Pw6q0HAkUA/Z7mk9O4FANJ2ylgJQaUiwVMufJUvcLkEpLDFGHoUP2kG+Y9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6290
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Sep 2025 10:27:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20147

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip122-rt43.bb => linux-cip-rt_4.19.325-cip124-rt44.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb               | 1 +
 .../{linux-cip_6.12.46-cip8.bb => linux-cip_6.12.48-cip9.bb}    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip122-rt43.bb => linux-cip-rt_4.19.325-cip124-rt44.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
 rename recipes-kernel/linux/{linux-cip_6.12.46-cip8.bb => linux-cip_6.12.48-cip9.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip122-rt43.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip122-rt43.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb
index d843899b..026dcd7a 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip122-rt43.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip124-rt44.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "90e25b2144793c3328ce84acad73b2b0b6e318b4761ae4a350235251fa9f2b0e"
+SRC_URI[sha256sum] = "b04d0d24e9a3cf192784f9f5e6dafd2332b40f55b2066e55f5cd18962b99cf1e"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb b/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
deleted file mode 120000
index 07b718bb..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.46-cip8.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.46-cip8.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb b/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
new file mode 120000
index 00000000..aacb13b0
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.48-cip9.bb
@@ -0,0 +1 @@
+linux-cip_6.12.48-cip9.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.46-cip8.bb b/recipes-kernel/linux/linux-cip_6.12.48-cip9.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.46-cip8.bb
rename to recipes-kernel/linux/linux-cip_6.12.48-cip9.bb
index dbda1fe6..e50f42a0 100644
--- a/recipes-kernel/linux/linux-cip_6.12.46-cip8.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.48-cip9.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "5a6ffd6c3c98e578c066d3e0864ac12cdbabd5dfdad1f86ee9eb532099db5f14"
+SRC_URI[sha256sum] = "66b016c46f369496c1993267efba83725b548a40ed0826d067691e89ea0a4aab"
-- 
2.51.0

