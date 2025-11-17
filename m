Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BECE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 15:59:24 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12783.1763395153708209467
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 07:59:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YMhN23lJ;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.70.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYt1rqcODLUJ5tntbTI0lcWm90BRzIIdeTeWYqY9lNDdapLpnEjmBzKj3lKfXPEmxEvdXuHENA+7kmUrS7FlyYRYn4lR99hjJa+ykfnwb4NPvLHFdiqOD67GuPeNpV6F2NDi3gZxuv7G/X9QVfroznkKAVqwScBAGNLznFLPjIp+6Ejj2npk18NdsSHgNwrQKZ8xUEWlDGS+XwTQqsY0aOB1wu/vNz1w4EnwmIbMsmkhdqZACV9sF9g0D9v9vaQ0keYJCHZ4ZVZy+XLTXBMvT0OKjocj2867hnzyn2h3pczj0I560CibLexJ8lHcNBujJC4YU4BjpxQGtaQ7zVRxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6kggiEBcKhRJ8VKq0bHMVlCkjghKBbMUkN80SKyjb4=;
 b=R3bJVoKR7c9zkrbZRZl1ukVh95NEpw9+w/PIkYny5B8l++drIANxGxN3oTUd/fhFAwglXFSI11CXF+6MEOmkzJwWCXiwTq7bf3oN2MA/IIDO6/ipk7nMhAslr0MdY3SeNFEWgfvkFkbGxIAP5yXRlBJUFVU2oALFFN3dHl56t/latbczb8GXC8z+HMjZICukD4tKQrfXJgmTO+/WST4nuJHAQdial5R5mr8I8JmT6FaNify06qZSJIAgsnSX6/GpfiZydpvr+nLfZPpCVAjlCVKA9OtEoBHwfNuGNk3q2cn9ZiFHOW5UvegG9D9r0KBKI1e7t2ggWAS2sTgp4TLzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kggiEBcKhRJ8VKq0bHMVlCkjghKBbMUkN80SKyjb4=;
 b=YMhN23lJTsjeRr5DaPcsiONq8wGMHwpTScYIfe/5SEuO+UEsX9H1M+sWhBWs1bx7H9uKULe3W+eM/jVtUw82kziA0oXjfU3s5lMLbl7OsY8RC2YB4A8URvQ2du5vAE5/baHowf82E9QOn8840nlb4LZ2EhK2/OJG1JZnTX84ueo3KobwRln9T/K4XWy5mAqJxt4kNV0AVvW9tnicZcoSXUXotCsGRKtFACmBialTjbya8Z6QMcoxx/5rsG+Sf87KetB2qaVY1aCyopnzdpFF8NDaiPP8GqklBubK7mV0NZWe/jbISdqXVI1E7vAeJSoM4jwjwoBUapfOMkW9rpLEfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 15:59:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 15:59:08 +0000
Message-ID: <21c328a5-ab4e-4678-adf2-cf34fa341869@siemens.com>
Date: Mon, 17 Nov 2025 16:59:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing on hihope-rzg2m
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
 <6917d2e7-3445-46f8-b2f5-16e2054f232c@siemens.com>
 <TY3PR01MB113469798E540974DD8DB122286C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <3c30e594-f15d-4ffe-9bfd-dd3106eadccf@siemens.com>
 <1878CF846EDE16DE.1122728@lists.cip-project.org>
 <TY3PR01MB11346F3057953F4BA3E2496D986C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <14aaf102-4691-4db4-8be1-7aa636037edb@siemens.com>
 <ce277bc4-bdaf-4afb-ae07-cfa26b9bc1aa@siemens.com>
 <1878D60B4F37418B.1122728@lists.cip-project.org>
 <TY3PR01MB11346C98E41038E409E918BAC86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <6c72fd70-d257-40dd-8660-0ce08ca8300c@siemens.com>
 <TY3PR01MB11346F5D7C84D66F2B0292CAF86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11346F5D7C84D66F2B0292CAF86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: c0115f65-56da-497b-38a7-08de25f23e22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cFZtOEVjV1FYSWJXWWZNWE1KK1JOeS9HUW9ETGxEcHUvOG1JTlhVWEtFdjBK?=
 =?utf-8?B?d050TG5OdksvSkFkbElnV0pIbG9TSWNGUGR6YjhOZzMrQlduaWJnVFZCOC9o?=
 =?utf-8?B?cVNrMmw3TjhteVFrenFrNVJFMGhlSDNuK0Y3Z2JBRk93S3M5aDlybWlRN0FB?=
 =?utf-8?B?M1lsSkhON2dZb3NtSUFlS3VhS0xFMHlOcFhEVlloS1dzcTEycklyUzZRVmdJ?=
 =?utf-8?B?THdBLzdVU1Bmci8wUDVZemE2dW1HMDd2Mkt4bE0rODl2MWx5dG5BT3hSQ09V?=
 =?utf-8?B?T2hSZmppR20zcVZ3TnJTZ3Jnc1FNbUt5dEJUTmZ2aDdOdytaa1ZXTC9TWWRK?=
 =?utf-8?B?bmNuVlJqejRrTzUrVlpFbzcyWHAvRVVmUEpIV3ZUcGlvNmV3RUc1a1JEM2Rx?=
 =?utf-8?B?MmNLTE1LWFU5QXhuZzcxVFNMaHRTRW9sYm96TGZIRU80UUh2V1lCelBTWTJy?=
 =?utf-8?B?TFI4Szl3S3U5VXFVNFcwNmxPQXoyekFZR0dLa3dDaXFCc3JBQ3lGa3dWcmlU?=
 =?utf-8?B?aERTYWtBK1VVTkZEcDNLajZyak1aMmtvQ0x5eXpCZFptMTgraFl5elpUZVBl?=
 =?utf-8?B?S1RhckxYbUZ6TG9OQWJIeXgxMkdEeHk4VVFyRWhUdFBpSWRRYU1YY0VqeUZ1?=
 =?utf-8?B?aktnaFp0dTd3bkpId0xMaDhNZXBqcjhGbFBxRTlMTmZ3ZXY5MnVvTlVNQkdz?=
 =?utf-8?B?bFlJZ1YvK1ZyRkQ2Q1NtQjdJenhQYnNtSHhmc0JuZFBmcENIM0NBUlZ2R2xB?=
 =?utf-8?B?TzhSVm41VHk0Y3FiaXd5NzFNVXE0MkwrQWJhMDU3bWZZSEhJbXY3NXU5QlhK?=
 =?utf-8?B?V1VOUkNTOXZjZE96NlhzNnI3R0RzL0QzV2cwRXVWOXo4L3g4MkVvYnEva1JW?=
 =?utf-8?B?WnYvdGRacEY4NW1YL2lIWTgwYzVXNVd1anhkOEVzL0NSV1R6QXVseFJuOStz?=
 =?utf-8?B?d2ZvOUs5RlcrVmxnemdXcDVOZFlMMVgrRkN5QUtKdDM5bHVHUFFDa2xmUXIz?=
 =?utf-8?B?RE9CRjIzeVBiRU5OK3RicnhCejdZNm9XYVlMdjR1WDJZMk1JQkV1WXA3VXo4?=
 =?utf-8?B?cFNLRHZHMFMweGJTRlJJSTVIcFJibDhFWGl2K1V4aGxsMnNmVzRYcHh3c3lC?=
 =?utf-8?B?RUdyVjBzRVRYNnpEVDlWSlFmOUUwZXlYSFJjU1ZMMEppQ3lWUlFBZVFMbldG?=
 =?utf-8?B?bXYrcEs0U0VZOUJ0bFc2bEF6YjBYdE9TSEt0T2Nhdm0wVllNUzJweStCekdj?=
 =?utf-8?B?d1JZdUdXZzZWMkJmWkN4SzFqUE5OaHgrWHdGQklkVlZ5eEkxUGsvK1JicEZt?=
 =?utf-8?B?RFFRd3BNYlp6UlJyLy9mTHlLNVY3aE5wKzlLcHdjUm84YU5yYTlzYjhmVEJ0?=
 =?utf-8?B?a0xwRWwzTDdiRGZhWVhjeHJNOWxudWdocW5lYTNqRE1UaDM5MzVsdC8zR05p?=
 =?utf-8?B?WUZkNXNPcHpiTVYvb0FZdmlQZkdCeVp5QkRSc2RVNVBPRlVwK3ByczAzcmV4?=
 =?utf-8?B?dUxMbnVtTk9aVXpYMldodStMTFljNmltSmt2UDRUTVpWTzB2U3BlZW9XeERG?=
 =?utf-8?B?RXIyTHFSTDZLdWJkRk5ldWlOTmlqTFFwcDZKMG5qeFpaL3BxU3hzS0FYYlZM?=
 =?utf-8?B?OStPU2s2ZWthRXhLVlliellDQWpoMnBRek5QQjRCdC9WbHRSMWRvNklJWDZ4?=
 =?utf-8?B?dkFQNld4cU1wT0VRMlFQSDNJYjJ2cVhCOXdNNE5abnJjQm9iY0lBQUFGZXky?=
 =?utf-8?B?V2tXRUNSOFRhN2Q0L0lmZWxCTXR5cmp5RnlxSlFyZzV3MFpLeEVDTWV4em0z?=
 =?utf-8?B?TkJmd1JRbm1BVDNwdVVOTmkrNG1JelRLSkNmUytRZCtncVRDZ3YvbFVqSW9o?=
 =?utf-8?B?anJhVFIwQ29oNmxqNlY0cUVXeHkzZzhEdm55VHE2MXliVlE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFlnaEF3VHpWaTUyUUtXWlFPelRMU21FYXYxWFRDVmpFVnNyM0pDbEpvOFNv?=
 =?utf-8?B?alZ1QjNIbUtST0hWTFV4bmNMT1huQWRqY0hjSWZ3eGgvUFVPc1Q2am1ySEhR?=
 =?utf-8?B?OVhGSDAzakg3UFh2ZHk1WStXRnY1YkljK2phcWtCWTFKeXhLeGtpby9paFU5?=
 =?utf-8?B?RHUrTURlakJWY0huTFFOMnUrOHNGeHJIWHdJUXc2MnFPU2FwV2plUEFwQXVn?=
 =?utf-8?B?Z2NtVjZoc3l4MEtZSHZ6Q3hob0FEaXRRcUV4T0MrU3huTzlFTXRCTGVxK0Q3?=
 =?utf-8?B?NC9YSE9wTmludStWVzFwNkFBQXNLU3VOdFdrYmFCMGJKYUwwNEd1cXYzS09Q?=
 =?utf-8?B?ZmRMNUc4SUREeGk5Uno2WE5vMUorNjAzS3JLRmFSY1ptTEFZQmE5ZFh6T0hl?=
 =?utf-8?B?em9JbHFnWGo3Q2lVOXFNd2hKWHJRTXBlS05BR2hnRUFISUYrdVc0WHBnZVN5?=
 =?utf-8?B?Y2ZWK1BEQXdNNEU0UldIbytBbDhZWEV4TFIrNjJhNHlHeVNMT3lGSFVLbkNh?=
 =?utf-8?B?ZXF6WFVHbklTdHpHdklYa1VOM2pneEdGSUdDNklIcm4vUHV2MnFjNHBCckxD?=
 =?utf-8?B?VUhPaHdyUDRXZWJJYXFDYWxLUEwxSjhXYU9iUytNd1F1VUVGalpPZFpnY2l2?=
 =?utf-8?B?ZUIveDE1TGVQdnAvVGd2WVFiTmgzK0JzN1VlNzdkb2YyZXdiUTkzVTkxL2lP?=
 =?utf-8?B?czVhVC9DTGhwbS9POHJLZE5FOE5icGg0SHpySzFJeDFYTEgwS1VUWlNWQkRo?=
 =?utf-8?B?TFR2UVhRMm9tTXJwVDdrQ0sxL0FoVHYwdjdkMFdLcTBETnR4cklsWVhzRkRU?=
 =?utf-8?B?czVRUHhWZVlSekU0SGNoUitzK3NGZlJINWl6cTEvb29CN3FQS3NWdjFWNmJy?=
 =?utf-8?B?cFhpUTA3UXRRdW9pSUlOOTIyT3BCT213VnpZRjhOc1VWYVo0UHlBL1NqOEhu?=
 =?utf-8?B?M2Q3d3dXVXYxS0FiaWFMZkM2NjY5SnptQldHem5zNTJ3OE1NaE1tNnNyS1VF?=
 =?utf-8?B?MGozV0ZHUWRVMU9Obmp3R3FLSTlocEhjOVhDWmlCc1pSTXVHaDhuZFUxWlVG?=
 =?utf-8?B?Q25HNVRVTWFudkJTZE9wNVpZeGpHMktTYnJ6V3N2eUpJblVNZzJudC9lSzk1?=
 =?utf-8?B?QzhxejdOYzFBWTdjaDJWZ200UnBCL0VwUzNUeUlPNnJTRG1FallGTk5HNUJo?=
 =?utf-8?B?K0M1RE5STWNkZ3NvSys3SDJpR09OVjJ3MTAwTlJlQklaSGxHcWNLSXVzcVNz?=
 =?utf-8?B?elp3QlVZYUJwRSt0eU5XMmJ1dzJaSVBtVE0zNGl1djRKNTAvakpFVGk5TmE3?=
 =?utf-8?B?ZUF5cDJpcVlsdWpTdzlVSmt5Q0dwcTVTYlJKOXpsRkRhazNidGw3aXg3eElM?=
 =?utf-8?B?M0plbXRMc2h1YW4xUk9XTlhaTitLckpyQ2VFb0MwN2dPdDNjb3hTVXBUMTNi?=
 =?utf-8?B?UlZiNnBybG1lU1ZwdG9ud2FoNEJVcXZiS3A1QmpKOTVEMDFldjN5bXNkTWJx?=
 =?utf-8?B?NTF2UnJpdTM2cmVvK0RJLzRHL3NhK1NjZEY4dll6cnpnRGExY3JTQkg4NjdK?=
 =?utf-8?B?MXFEZ2V6RXVIeng2aksreHRTLzYxWDlPQjdRRThlYnorZGIzcUxyUzBXVHM4?=
 =?utf-8?B?RVFtS0k5VjJMcUpKeVl5QlQxcFJHTmFueUR2YTFvRE9LZ3k5OHc1Y0MrT1gy?=
 =?utf-8?B?dStOZGJOMUw2NVpTOXZoQk13aWFlcGRzVXNiOEdMTlExVWZQWTJkZEt2OERm?=
 =?utf-8?B?SW9xenNkZm41WTNTNUJrT2dkQlBtOEx5NVJvb2VRL1BmT29rNFJIM2FubzBq?=
 =?utf-8?B?YW8vRjJEWkJsSDZOdDBDUHlhaGtYejJvVnYxRnhIeU85TFE5dU5meThCZkFm?=
 =?utf-8?B?OVpZTGxvc2hxSE1uQ3ZUNkJXRHlhdjR1Qzl4ZkxGSHBuaGpjcEI1TC9xTElH?=
 =?utf-8?B?TFBSWUlVcGJxREZtQU02M3VLZXF1b3A4OEplRFZyVXF1SGx0RHNCOUJKRUhN?=
 =?utf-8?B?VHJrQWMyOUdWd0cwMEJDSTZ5WkVGMnhXVlpEMDRKRDhWd0Jqb2FNNWFPV3FL?=
 =?utf-8?B?ejlmSHdnWVRZMzlmK2NtU0oxNEgvVFBkVC9qV0FFS3JOcUpvYXhqOXJoYlNJ?=
 =?utf-8?B?VU0zY3BzanpaMTh3SXpZMVB0ZFZGQVlScU1JdXRhMjRIZm84dUcwZ2NrZjFy?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0115f65-56da-497b-38a7-08de25f23e22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:59:08.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1ZLIvKY1MJXWztpWMqhWUbj12hCGXJsXqsCVcHc5wkqpq1kgcFeLPW9PABHQjOkyB3BDqyzSs+eOQTaKZYfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 15:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20594

On 17.11.25 16:57, Biju Das wrote:
>>>>>> Yep, this is basically what I got now as well... after switching back
>>>>>> from cip_merged_defconfig to renesas_defconfig for 6.12.
>>>>>>
>>>>>> We /may/ have another config merging issue, adding Quirin, but maybe
>>>>>> you, Biju, could help us identifying the config options that flipped in
>>>>>> the wrong direction. My first guess is that something which needs to be
>>>>>> built-in is now a module (or worse).
>>>>>>
>>>>>
>>>>> Or are we enabling more, but maybe not enough?
>>>>>
>>>>> +CONFIG_DWMAC_GENERIC=m
>>>>> +CONFIG_DWMAC_RENESAS_GBETH=m
>>>>>
>>>>> Those match on "renesas" and "difference" between the two configs. Then
>>>>> our merging of configs would not be the one to blame.
>>>>
>>>> Yes, newer platforms(RZ/G3E, RZ/V2H) need these configs.
>>>> We will be adding more configs.
>>>
>>> We use CONFIG_STMMAC_ETH=m aswell
>>>
>>
>> But adding more configs should not cause delays and warnings on other
>> boards. Something is not right yet, please investigate.
> 
> Can you please explain " should not cause delays and warnings on other
> boards" ?
> 
> Where do you find this issue?
> 

https://lava.ciplatform.org/scheduler/job/1329386#L791 and when tested
with cip_merged_defconfig locally (isar-cip-core image).

Jan
-- 
Siemens AG, Foundational Technologies
Linux Expert Center

