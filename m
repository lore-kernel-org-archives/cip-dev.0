Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A127C2BD09
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 06:36:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.63])
 by mx.groups.io with SMTP id smtpd.web10.32224.1721025361091170802
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Jul 2024 23:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bQqq4XY/;
 spf=pass (domain: siemens.com, ip: 40.107.22.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djR6HT5uC+0VOD2UvLfHEcWniLU8BVX7QjS/QdulEaDCbiy5ri1gc0lDNXKuRR+EqK/8Fa7oI6Bsk3ZaHO0KOda2lmSoN+hwgYeocsjiwYPe1Lv7j5HKGQ54GvjgcKQshOYOCeM7AMc9xK6xQecVKQn53piL0dZoAifELoS6K+tr/zG5cGI2jnbHlGE3IYaXaIewOUkdqCqwGHjh8lbzNzyi8BsBxe0U2XdMDhxXgDk08OZfxGAJ4XAxeV17gQj7+6R7npmqsWYpvixQW8qv3O0CpRtOAv1bpcNfLOaYKZFUF/7HvzfAkeqHipJ6ccfRw9CxI0yfkrwx3xnjdFzQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG2On31GXHipElsWWI1WslElDa1mXBXTlEpDyZ6J9ok=;
 b=XSNSxQdbdVwJI2Y7VLq0Z9hlsUi4Bvj1Hyjl7VT73nHME25viA0miz/PyIizQZgYrPBgJWfK9xVEFbreokWFHbX8SnSyauAmS5aGAG8W1BGBv6cSesgBoWOmbA7KeETGI1ElAbNwrP9IhUol+o7a2suLC9rpmYO1+dKlKojOuUWmuNcoVPi4dUKhTu9OsVkZ03MFtd31tK6jdN73NtJugm206xD6Xg/898RwQb9Y6c8TYVtwLsAEudGY8az2UWoqMO9z9B2C8SfdWOm4SbwhY/XSgaQ0bSHJrTk5PRFU/mbTOZxenmIKoBe396LNdzcIlWzTQCLYY+hqhksgwDA+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG2On31GXHipElsWWI1WslElDa1mXBXTlEpDyZ6J9ok=;
 b=bQqq4XY/MChNkAqjHEUjvljTs/BjiDEUgfFu6yweM25nfzCQxndhHIp940G9gTUIU0djX7Hj9uU/x0QOgmuL9AlcwUR8z+IMec0+QgTxZb3+8s6xi0zG7p+mgGkqS3dhlkcUff31uwW/amou0569TaRESK975kYA+UK5tjMm7LKWFjdUjXURO/fLuN52g1Gq0ySkt0OabQUS5x3+5Y/clHLXTFJ+118bSOKn4ytYAQzewlEHiDXqYepSearyi1vg6yXk2r5Mh5DGaBU7M1YjOhVpjECKuXTDCsRURZw253ivrLbNoZtR0bw1D6SZomI95axgP/oWjEVj6OOLnJBl0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 06:35:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 06:35:56 +0000
Message-ID: <a868be1f-b8ea-4d93-9263-dec248b72fe5@siemens.com>
Date: Mon, 15 Jul 2024 08:35:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip89,
 4.19.317-cip111[-rt37]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c9cbe3-bb2a-43bf-6c75-08dca49861f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?THdCdDlPaVVaeGFQanMyT3d6ZzFRWFNhYUdaT0NDRGpNS01sbCtnVjRDN1g5?=
 =?utf-8?B?QVltbzV6R2w5ckExNnpYS0NEY1ErclN4UTA5T1dsd1hRbkowYm9VcEJvNUxa?=
 =?utf-8?B?MXhOQlZGWGpZVFN1UGdCaFZaUGdBRjhLZUlFNC9tRzFXNjR4VTQyVjkxYngv?=
 =?utf-8?B?R3BWVnFIcHJiNEpiczViRDhnaXVzeHBVSHdrZmo2Nlpvc3VVZlNOVUhJYmlD?=
 =?utf-8?B?ZHVSSkZmbk5GYS9DY2YwdWdMOXJabzdUc2phZGI1aVlhWE4zYzlKWlcycnJV?=
 =?utf-8?B?UXUva1JQeFFkNUtkdzlScjBpV0ppQ3k0ZTlxczlCNGtEaXJ6M1Z0bFRhelY3?=
 =?utf-8?B?Z05qQWx5ZFBFZklNZVNtZkxiRjBTb1NQSTdtaFFEOHdRRXd1UGp1VlBPTXFI?=
 =?utf-8?B?RTBWRHVPazZRdEFjSkxxY2JQNkdCVXI1OGRDQVNmcHV5TWpOTXAwcG1pdUxt?=
 =?utf-8?B?UXA0dmVzRkIrRkNFa21qeXZJVnprTnF1emdxOTJzTnRpOURPNi9yWWRvRDJk?=
 =?utf-8?B?RDVoQXdUdU4yTGgwVmpRci95T0FjT2RLdENoYUs0cFhvenoyalNpam9tVjQ5?=
 =?utf-8?B?K29Yb2twdlAwcEV4Q1AxVEg4VmYrbFc3OHNxS3MyR1J5V1QwSyt6K1VleDFq?=
 =?utf-8?B?cmFkVk1mRlh3SS9IVHcrZytHUzZEYmRzbjh0VnQxSm91Q1hzbGNNOTdVR1JZ?=
 =?utf-8?B?Kzh6dnh0cGdoOVhVVWlRQVY4U2YrLzNOMm1KYys1YWdBQTh2OGJWVjhGNjhk?=
 =?utf-8?B?SnVoZVRMMWdPeldIQVY0UWxLcUpOUi9MRUl6Y3c5NXBkOVptbEUzYS9VdU82?=
 =?utf-8?B?a3RhVTlmL0RGek42QTJKeFlLeDJmUGVqUE51WUZEaDJwTmxHWTQvdUFORlVy?=
 =?utf-8?B?RzFUbFY2Mk1tTmhwYm5TVzd3cFFKcngrWEJMMWZJVzFXeVZVSzYybHAwb1ZU?=
 =?utf-8?B?bzkwUWEvWEl3NUtkYjQraUw1cktOaFpESmtjajQ4K3pHcncwRXZxSDRCYnp1?=
 =?utf-8?B?ZnVxQVRlVjBKV3dkNlZiNVBpNE12QjZLamRrQmN0MW81V3M1OHNzVXFRMzZK?=
 =?utf-8?B?WnBCRkw5eE1Sd01jSml1TlprYUkzUHR3aWNyeXBqUjBjZ1orUk01dnZBSmhI?=
 =?utf-8?B?VTRNNXlLYUV5M1o5cXB6TmkvME5BS3ppRGFEbXB6aU9uaVB2bEFvOHNNNmdU?=
 =?utf-8?B?OXJFM2VEdTExSm9aQUhCeEIxVlN1UjRSNndadiswdThFTys3VmZjcExYanpo?=
 =?utf-8?B?RkRpZkpZcDZaV1NPZ2dCTFp1eWtpdnQvUUMzQm9MT2Z1OE5FWlM0TnBXRERX?=
 =?utf-8?B?Nml4TDMrUENJeTBXZzNOYUtWYTg1cVdueUVCZ0FjUkVlUHJxZUd3NWxxWDJo?=
 =?utf-8?B?V210VFhkck0zUE9aTGIvbDh3aWNUOW53d3Z0MHMwbnRDNG4rdW1ZU1NDMlBk?=
 =?utf-8?B?V3ZIRWtRMFAxbWxuaXVwajZzN0cwNWovbGRud0xDMDdxVVRFVTdzbTNWYU1C?=
 =?utf-8?B?RUZuakNDUDJ0YVpudFBqLys4cXh4VVd4MDI1eXdVNjlDS242OWN0akJJdGJl?=
 =?utf-8?B?ZndaN2o1SC8rQVo4b2xiMHBScExldEpFV1FxR3NXNkJpQlZCWHhlQWUrbSs4?=
 =?utf-8?B?eVR6WUxQUFdnakt5RDBFcnNjeUt3NDE1RUpYWnNuV2szWDJIbWJxeTF5U2lJ?=
 =?utf-8?B?cHlpT3ljdFhiOUM3Zm1yMDVUVW5kTU9YNHlScUdubW94bE01Mmc2V2xYcFl2?=
 =?utf-8?B?dUQrbnBSZ3VpcHZWeHJ2clJTc3VYUmhoaDgvdXRZalJrYVMyQUhKS3BpcFJY?=
 =?utf-8?B?WkZvU0ZiVG15djZSamZHUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ym9sM29yWFpBMEt5OWlnTW9TQmxKSjFObE9oYlZwZjd1bFlPSTM4SG1QREkw?=
 =?utf-8?B?ZTRtSXlsc3dwd09KZFBBdWhrSFZFMGpRVXBYbUhHbTZ0d1lqazI5bGdkcGRH?=
 =?utf-8?B?MEJ0QWU0MkxTc3M0SlZmRkdkWDd3REQ0SVduNTRDb2I1a1AxZmJNandOT3h5?=
 =?utf-8?B?TW5vdVgxL3Joby9NalA3Sy8ra2thUjN0UWZQWHcrZWxPVU5YeWJyMTBjNkNY?=
 =?utf-8?B?aVhYUmVPT0JTV3BhQk1DNm45dTUxYU5vNW13TTYzN0FJdm5JK05PVUJTcllU?=
 =?utf-8?B?R2V6ZHo4VVpXQVhtWHpJUEdCTG8vYnZlVmRMSTFLcUZQZzEza3IvZlExR09B?=
 =?utf-8?B?S1FKU1AwL2NaaCs0M0UyNE40VmVTa3FMZ2VtQ215WFpIMStqcEo1RmRlNHZy?=
 =?utf-8?B?TStVV1hnbVpxdFBHOUw0SXFDL2I3OEZ1dC9mbUVJNEZJaU5jdEpIdVJaRDI3?=
 =?utf-8?B?SC9IMVkwNldsYm4veGtVT09LdVp4Q1AvbzVCd2lINVdhS080NUo2QXQrWHcy?=
 =?utf-8?B?RXZjZG9EMHc5eGg2OGVEcGNBWCt3Rk9ROTMvcDRTSW9MaDJ0K010QW1QQWJQ?=
 =?utf-8?B?MDViTkVobkRJVHJ3QjcxOXdseGlHT05EbUV5Sy9rT3lDc1lXTEUwWGxUQWtY?=
 =?utf-8?B?OGJZMFVpN003OVVGV0owaGF4aW53d0JyNHRvYmtPYkFRSHFJL0dHblE5cXdz?=
 =?utf-8?B?UmhWb3VjdzJHWDllOWIvU3hYRlB4MTlzWisvbDN0a2RLMVYwRmxuWUo1MExi?=
 =?utf-8?B?MXlxSXlTT1htN2xWbndxY3Y5ZE8vdzFJTW04R0lHdmRab1pyUWNaOCtlK1NE?=
 =?utf-8?B?em1JRWliNHNjaTVmSFc1S2dFYjZoa2s1WXRBMGZLcVpwSFBDcERhc0hybG9K?=
 =?utf-8?B?VE1BYmd0dHpMTFQ0ZlVBbVRMNCsxWlo4ZHI4Y1F1NVl5YU9ScFVKTVl5a2w2?=
 =?utf-8?B?TVo0TWZhOUdMclo0TlcrdG5oV2wwendFZlM5ODJhcDNQekR4a3F2cHE3SlZI?=
 =?utf-8?B?L1NMWXN0VHBaQVVqTU5Id0J3M1VBN1QxMnJVbEg5V1dNZ3RiaGFMQ2x0ZVBC?=
 =?utf-8?B?bUtJQ0lXdEFCdFhqZ0w2eE81ZXI0VHJZSE96aElYa3piRjFhK29sbGpTNlFa?=
 =?utf-8?B?SGhIQzB5OUxLVDBmMkdTS1BydlkyNXNpcDJzZ0M0LzRtNTdtL2hLSmZxTmxJ?=
 =?utf-8?B?cDVwTFAyV3orVUxFMCtMWS95am5kV0duM1pQWlM4Z0R3L096a0o2WEZZNXFs?=
 =?utf-8?B?U3FZZEJDV3RjRmdJZnh6TGo1Mjg3UURoODhvaFBZeTZuZEZXMlQyRUM1Mnky?=
 =?utf-8?B?bUVWelpSYWVBL09DUTZiY21DQXNXa2dQdnJZb1BoVFZSU2txMGFRWGpXUkZx?=
 =?utf-8?B?RHphOVdxbHlIb2QyZTNYVGhBNTY1V0Z2REFHS0VHVk5rZXB4TVhyMXltbGVw?=
 =?utf-8?B?aHNJMDQ5bzRvVi9EdVlPWEs3aG9NWGF4alRock9sSWYwTnBWZlJlMjR5SDN2?=
 =?utf-8?B?eS9FVy9jSUgvZ0g0em1LWlFoeTZHNHhpTWxQVTg4ejNKMXZSNGVkcU1qVkE4?=
 =?utf-8?B?NDhuYitBaFhZNXpieUgwVzZwM1hXVkJKVDJhMDR3V2x3TjV4WTNmTlpKQnZG?=
 =?utf-8?B?QXhLK3BKYkwvN3FENDNXMlYzdnNNNS9hTVZ0ZVVvd0haS1JrSVVJWUQ0elFm?=
 =?utf-8?B?Q202OFN6VVlIVEk4ZW9DL0R3Zy9GMGJCeFZPZzIwRGEyS3ovTTV5L29IcUQ3?=
 =?utf-8?B?bnRiQmV3L2NjeDFpUWhBeC9zSTFiOHRXQ2NDWjR1cjBrWGJxbk5RZVNvckVJ?=
 =?utf-8?B?ZVRSM0g1UCsxUlBEWEhXUmZaeWo3UWFaUDd3T1U2WkF4dnJxZm0ydTJ5elMz?=
 =?utf-8?B?VXRkMjIvbklKWHY3eDljNmhBMTZlVnRuc21WWmdDSmw2UkRJd1ZKSGNTSCtL?=
 =?utf-8?B?NnVQQzl3c0tsdlo1Q1d3OFBXRlhrT2lweWdjMHdaQ0F1SFRubmY4V1RDUU1Q?=
 =?utf-8?B?b1l0T2VDUk9JUGRFZCtLQUpNaUZyK3I0Q09GdkdVUkpVTWI3d1hVVmExUFFT?=
 =?utf-8?B?YldwcHlHaHNUbGc2UFN0L3dyLytHZU9zQlFTZW93VVJybDhHdzhEaGd0YVl4?=
 =?utf-8?Q?fEAR36YqKEuo7/5HkD+omU9W3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c9cbe3-bb2a-43bf-6c75-08dca49861f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 06:35:56.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBzj+rCsJ+yXv7Vvsn9nqsfCEAl/MHDHpbjWe8niszfCAQaYE4NwX4FP63yJ6yo4SDNjA8OcU8Bb8JJ0ocYoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 06:36:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16487

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....312-cip109-rt36.bb => linux-cip-rt_4.19.317-cip111-rt37.bb} | 2 +-
 ...t_6.1.92-cip22-rt12.bb => linux-cip-rt_6.1.96-cip24-rt13.bb} | 2 +-
 ...inux-cip_4.19.315-cip110.bb => linux-cip_4.19.317-cip111.bb} | 2 +-
 .../{linux-cip_4.4.302-cip88.bb => linux-cip_4.4.302-cip89.bb}  | 2 +-
 ...{linux-cip_5.10.218-cip49.bb => linux-cip_5.10.221-cip50.bb} | 2 +-
 .../{linux-cip_6.1.94-cip23.bb => linux-cip_6.1.96-cip24.bb}    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.312-cip109-rt36.bb => linux-cip-rt_4.19.317-cip111-rt37.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.92-cip22-rt12.bb => linux-cip-rt_6.1.96-cip24-rt13.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.315-cip110.bb => linux-cip_4.19.317-cip111.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip88.bb => linux-cip_4.4.302-cip89.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.218-cip49.bb => linux-cip_5.10.221-cip50.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.94-cip23.bb => linux-cip_6.1.96-cip24.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb b/recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb
index 9fbac343..b8c2e5f0 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.312-cip109-rt36.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.317-cip111-rt37.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "95cc4750293f594921577d97751f8e32787f55c7dda07e19ca2731cbe487daef"
+SRC_URI[sha256sum] = "693b37345f7411f4f5b81e2f01cad279d23186c3d633938bb4e8f06637ebde3f"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb b/recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb
index 86f18e12..a6c27921 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.92-cip22-rt12.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "bf7750b483488f7e272043a64c0075121f355c44d23ba7a35190e25fa7a6000d"
+SRC_URI[sha256sum] = "5c82d799d5a24f97e00fdc6bdbcbf1b3cc66cf87f9c48f3192201d3d8b00c60e"
diff --git a/recipes-kernel/linux/linux-cip_4.19.315-cip110.bb b/recipes-kernel/linux/linux-cip_4.19.317-cip111.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.315-cip110.bb
rename to recipes-kernel/linux/linux-cip_4.19.317-cip111.bb
index 98c9711e..42634e9e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.315-cip110.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.317-cip111.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "12b2ff61f305151f324b6d502ae1f52ddffeb961a7bac5d60eb250928c666383"
+SRC_URI[sha256sum] = "c426f71ad3c781cb545804577808b79d11a43c8ce639cf3edda27252d0fdfb5a"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip88.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip89.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip88.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip89.bb
index 6316b018..e8c9b87f 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip88.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip89.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5135f05d426126ec6776198ccc9eb1679785a9b6b52d5ccdba1c71373bea50aa"
+SRC_URI[sha256sum] = "6732ac0e7260d91eb3aa15818629eb48b192a2a2d44ad283c797576e77c1daa7"
diff --git a/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb b/recipes-kernel/linux/linux-cip_5.10.221-cip50.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
rename to recipes-kernel/linux/linux-cip_5.10.221-cip50.bb
index b532d408..bb801467 100644
--- a/recipes-kernel/linux/linux-cip_5.10.218-cip49.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.221-cip50.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "b9ea6a4f6f7f18d3d1abad24be311e3dcbf4b1ce3d08e600eb100a46b069b0c4"
+SRC_URI[sha256sum] = "089962bcaf2b627ef11ba97b3ec6da0e6db5203ff9dc1882570998d6d7977b66"
diff --git a/recipes-kernel/linux/linux-cip_6.1.94-cip23.bb b/recipes-kernel/linux/linux-cip_6.1.96-cip24.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.94-cip23.bb
rename to recipes-kernel/linux/linux-cip_6.1.96-cip24.bb
index 70e13005..ddcb2ee7 100644
--- a/recipes-kernel/linux/linux-cip_6.1.94-cip23.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.96-cip24.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "38c6f43cea9b703e979100c68169dd703f0fa04af7635ca01ffd1cd4efddcdc2"
+SRC_URI[sha256sum] = "48649290e51a0651c286a108804d3474bb2cca7d7c285c24f5d543736929fdcc"
-- 
2.43.0

