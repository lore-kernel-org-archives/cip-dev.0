Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60426E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 08:59:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.46])
 by mx.groups.io with SMTP id smtpd.web10.33047.1733475552753957256
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 00:59:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=D+mEB7wJ;
 spf=pass (domain: siemens.com, ip: 40.107.20.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3HWTbIGJTPbOsYuCzV5/4gQHPa71xdDGweN3711uNwFrhlc0Mk0nOXIf3gHH2gb8XdIDEtaj2aHdUq4i28UQR9llHTZy6t3wgAcq4r5fb0BXxXGHXX+mrehxPP/8IDBGVnRlZybpnHr7MNtvFjfcFI7NeqCQhtFoMUsj+zxfvIu40FiIkCwIfE1XRIQ6qT3TGbop3A7IlYoxJgOKGjxviBe+jUrnC4lGpX0v4dbhfvfd2YEwpoVShg8M7XQfCD/wh9zAOwxotZDnjHkrXFirdwOdZlSz6ugzqBKLKQaryOUfRHQMiI+43UfYEsdbcdp/OCJR9Md+BebhaZeagry1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZmbufrglNYqoCDbe9iZEeT8yFEL+MRR1uy6Q0fVyLg=;
 b=chsDRdWSx1GaD/wkwkHJVnqVsKyWcMekNqsufy2VtXRT3XsWlPYqoFpMx4WMr1fyWjADK/fxuQ6dCd0fQJ8JR9xI9Qt2eheAjNQhOn6JfNDaSF1jcyQOAOEByUGjbbpFiEuSoYRsSok5FdhpNCXH1gOmECBhf7IiuXpauQt0SGp95R4rhcgrGeA4DHGg0ikwddVZz/E2au9CEBIr+eyA4IJ36GdUyYs9H1HGcD22Jk5XKY+D2/ucEPPAid07z/ufMe5mp7O/QSwhAcmPToe1wgTapEEBCc+2XDZpQS1tFFn4bOReqtB0lQgMeH6OhJiUH8zgnPeubZDkVe5r2P0mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZmbufrglNYqoCDbe9iZEeT8yFEL+MRR1uy6Q0fVyLg=;
 b=D+mEB7wJzM07uBKGLH4CiBwPvC6+rUD1F/9GzEeQkKmZ8JzxemuWbzBEt++wefFyE+XTeV+yGLHtak/OikHan9ffW4bHsfE//8zR3A1dlA+tuoD9YM+f2KCRpS/XwQZ/cAY77pQ1FEbjPzRNOvN230c+agwNs0SFTwPI3WsHnOJGwkv/lJXJSsaXrCqpYmVDrYglFl+r3HQqeFIaCgZPziyH/O1QpO4LT3kudYmSUi+0w5sNgElSUNiir24tqO7cGPzlBNuuDArbFfjHTUfceFMKmWH8bqoulW8UpA7mJ7rN/M25dIGJ543x2to+Rs67uCpT0Zcxs6hB9OPBjYjwiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:262::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 08:59:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:59:09 +0000
Message-ID: <be4356ab-7c42-4766-a06a-8de8f1cd9c71@siemens.com>
Date: Fri, 6 Dec 2024 09:59:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 10/10] initramfs-crypt-hook: invalidate
 PCR7 after unlocking partitions
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
CC: =?UTF-8?Q?Bl=C3=A4se=2C_Fabian?= <fabian.blaese@siemens-healthineers.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
 <cc43a620895a8ddcf6745c7eb4564344ecdf74af.1733151072.git.jan.kiszka@siemens.com>
 <AM7PR10MB33200735E8FEECBF4CF8023086302@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0508b098-c584-4abe-aa26-cd56539ad097@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0508b098-c584-4abe-aa26-cd56539ad097@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:208:be::49) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 37995c5f-1b6a-464f-51e4-08dd15d43f2c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUtXYVJXYm5ac3ZLR2UycHpGVVlIVEJFdnk2ZnpXaXNUeE82VGc3VmVsVTdM?=
 =?utf-8?B?ODZnNkRkeTdrRFI3RHgzUk9MckNmQk02Q0g4V2tzRVJYRDQ2dGlBaU9LK200?=
 =?utf-8?B?OHBVUnR2aWFUak5JZzg2ekZGblhyL3ZUd1VPbnBpdXZkMmdISkxwWVRLNTht?=
 =?utf-8?B?b3Z4RnZVY25lV0NzVzVaOUwvZXd5UTNGNnZsb3ZvTjNZeGx5NHhiQlNIUXRr?=
 =?utf-8?B?NkZja0JkYXZjckJ2dE16d2gycXlTczVndDFjTjlCdVZsa3p1clZ1OHpveUdz?=
 =?utf-8?B?a2pxekRXcndaZU11TmxzbVFxTjAyUEVVRFJtbU5OQ1BaazhZSkNwRjJjeTkz?=
 =?utf-8?B?V04xYlZRbjJHTHhrV3c5WGV0dlEzWllTOFNFZ3UxTjJUZmYwbERmRHhOVisv?=
 =?utf-8?B?emF4dVYyN3grV2lqNjJsOXRYdXRScXJFTk5QOUo5V0hnRGJIOWVheXRQZyt5?=
 =?utf-8?B?UnlGNkpHY2M4bXhOOEsvckt1cG9RZTFqOWZiUU1FMGphZmRnTGtzSDlxOFhN?=
 =?utf-8?B?aGFtS3ZBVktzZ1ZaM0hhdFMzWmxjaUtSMVJrR01DYk9obUc5Sm9DY2lVYzky?=
 =?utf-8?B?dkJDSlNNayt6cTNCZG11NE4xblZnZE1jSHhSeUJmZkhweVFMcEp6aEQvSno3?=
 =?utf-8?B?ZVZWWmZFVXdoTUxmVWVmcTYrOFAwOXdkS25NUlUxN2h0TXZSSlltWmZvN3BB?=
 =?utf-8?B?TUVJaS9LUUVxcmFMRkYwU01HMGVyeDhvNUNaMUdsOUdVSFkvM1RZVGlFNDJm?=
 =?utf-8?B?Zk0zdk5OTWQyMDlNNmZCSkxDOU85cWtYN0RnczhYZGc5MklLZ3pRL2JnY1pV?=
 =?utf-8?B?K3UvYjk2SDJtVjd2eW5ZKzJOaGhpNWd0UE9ITlRObFZ4Y21JQUl0YlY4OVNU?=
 =?utf-8?B?Vm15ZEpmN2hjVnlqdWJ5VHF1cFY5c28xT3hRRXRXOXlJUmQ0T2I0OGdXS1h0?=
 =?utf-8?B?b2lwRUN3c3FLbzF5SjFkUWxMY295Qk1HdGpmNXJQMzJUL1c5RmFmL1ZmckVG?=
 =?utf-8?B?aERoeUtJU1ZXOEo1bm5FejE2T2tkU05TWmtHS2V5N09UdlArbjk5RmFvVlVB?=
 =?utf-8?B?aGlJVkRxTncxaEp1dzY1amkxYW1nUkN0WkplZ05IcDZpcDNDMFdVbHZxNll1?=
 =?utf-8?B?SGtXamhhdUwzMG4zZFhMYk41UzcxSzFYbHlMQUZralFDUXhiQUt2c1BweUww?=
 =?utf-8?B?YWlENkZFc3lCMVkrUkZ2V3dLQlphT1czR2l0MndPUzlCOC9TK25nUG01OHVi?=
 =?utf-8?B?eG80ZXlxSC84LzBJTWgzRWl4OUg3YzE0RkRRY0REbzBXZ1JTRTN2STZNS05W?=
 =?utf-8?B?MFplMWRMWXh6ZCs0dW0rYWREcjhSZ1FoY3RoUUtMdHF5WUI4Mms4L1dudGFM?=
 =?utf-8?B?M2x6Q0FCK2Z3ZnFVTzdXYXY3QzBpS3VnamdGZjVYdCtIMzl4TCtPdzZzdVQ1?=
 =?utf-8?B?N1pWclF6U3FubW1YdjdKVWJBN0ZSNzVLZ1VQam95T0MyN0FPaUFQMDlneTYy?=
 =?utf-8?B?MFVwbUlWL0I4QnJCTXYxMU5WeHlWbkNsa0x0Vlh2YVM3UDF3ZHhuQnNURUEw?=
 =?utf-8?B?YTQ5TG9ROXRnWVB3V2NNOE1peEpXbkJCWlZtN28zaDZhRE0wVUdQcW8zSzhp?=
 =?utf-8?B?bFplM1liUy8zdWNwVENPcDlEREYxSldyTkljZDRGMnM2M25PNHdha0kvZXQ4?=
 =?utf-8?B?SEhBU1ZzS1E2U1E1K0g2ZUtyZGRZY3BIVXQraVJUMXV1ZkhWNlE5VUZRU3Fz?=
 =?utf-8?B?eWtDeVNhMlg0QjJqeU54UVplOVZnVnZveXVLbVZiSzRRUDRqbGg2V3FqMGtO?=
 =?utf-8?B?WkZheURXbi81T25BemJ4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlRoWEpJdk1rakdsTm5XL0xEaFRSODBTcHpqR3lTcUp2Z2JORjk3SjFOMlls?=
 =?utf-8?B?V2pIYk5lblR4aUtPdnd4K1Vjd1I5UzFtRXVDNmVkMk8rSDJxZEY3QXVuVDNp?=
 =?utf-8?B?ajc4dHA1dE1KMktWRXFoSmRETVZZODBEY2xmVGdaU1Z3SVcyREw4WCszcU53?=
 =?utf-8?B?d3pQZndiRGNUbmtYTGJzdGRyTXpUZHpUQ0ZjVXlTaFY2RlVwemRyNmpIOHQ5?=
 =?utf-8?B?MDZuNVRHVWw5TElxS25BbXd4b013eEFjanJlRkMxZkQ1V0tDRmtUbndmRTdQ?=
 =?utf-8?B?cXdtRTZpQzN0MVpzKzRYcGRUbWZRZ0pMN1JpVzlPNVlkUXl3MmNoN0RocWVp?=
 =?utf-8?B?cXh0WldpUEpBZlVNZ0NidGNHZzJ0aWJlUjNhdXYzdmNwb1NoclpYdzQ3QmQ4?=
 =?utf-8?B?ejcyeUxFVHhWdkozTFZzd0pENzVnQkFocGlSdXUxU25md1RpNDhyWVJyakd4?=
 =?utf-8?B?MUo2K1U0dFhsTnMybUdodlRDSHJJMHJDQlRjQmdNUDBIQnluQnZ3VWtqQlQz?=
 =?utf-8?B?V2pMdTZnUTQ0NStUUkl1aGJ2TlFFeDU2ZXB6dTVTQWdTR0RpNVo2dEIxTVdh?=
 =?utf-8?B?L1NoVlB6R241akVLbTBKMnQzR2dsenZaRHQxemZsajYxd0RJTmxRSTU5UnYx?=
 =?utf-8?B?MTd2b3hWMnJwVG9VWGNXOUVUVXNwVHcrcHVPN1lKK1UwalVmOHBRaGhTWnpK?=
 =?utf-8?B?NnF0MlVvdjdpQ0swbloyR0QyOEFma2xJVW5EeUd5dklFdUJaSDVjSUIyVEEy?=
 =?utf-8?B?VmVGMjVodVdaUVNuZHR6NWg1eWpwcXpLRmEvaHJnSEJCclExbmp3cjVEVUFr?=
 =?utf-8?B?NlFPeU9rZVBIZEk3K0hhOUptWUFaQk1rNTVwbXIvNDFaODJJZW5vQXhHTElv?=
 =?utf-8?B?VGY1K2xKYkVVMkk0eUcxMWlhSFBwYXpoRmRLUnNSa3hKcDRORHRmbysyZTda?=
 =?utf-8?B?aUliQm1UcFR6aGd4cVZxa3N4dFlCbm9Ca1psWUhySC84TkJwenZEaVVMR2ds?=
 =?utf-8?B?WDZSME5nV0Z4K1FoVzR4NzIzRW5mZitpZVRXT0MzaVMrOGV4dVEzMjBCZ2Nq?=
 =?utf-8?B?WmM4VC9HSUJicHRLbzR4bXlUK2QwYUhDelgra0Fid0VQMjZEQkNIR0N2RXdm?=
 =?utf-8?B?ZkNoOVdmTFNXMmd2RDJrbGdHb3dMWmw1bzIzckk4TE9kcHdnd1B4SFE2MVdS?=
 =?utf-8?B?TDNSRm9DVHl0YTlJRjQ3M1pRa2pDdlYrR3E4QzI3M2dWcXlnUjhBMUlERmJ4?=
 =?utf-8?B?OFJ4MGRLMWRWY3Y4czcxTjRuU0pwMnZQTkxXSWxKUGVXUXh6M2RSaUtMSnNM?=
 =?utf-8?B?Q0hWRUFRTTZOVEJCb3Zyb3hCbi9yNFkzLzVHZDRaeUJaNXdaV2poMnErd1My?=
 =?utf-8?B?Zzg4YURmZ1dyUkhUazczTmxBTGs0bWNqbjA3a0dROHBkK0lCU2ptN2E2V1dS?=
 =?utf-8?B?NnhZYUNheWg1UU53Zm1Ddk5rb0tERERuZkE5eHpBS1lhZTNQelpCMnBGTDR4?=
 =?utf-8?B?S1dBWHQ5MHp0dVFCVi9pZ1M2VWsrS0h4Zk83Y2JWSGcvWGZiV05LdTdMMVBm?=
 =?utf-8?B?eVY5R1FiSk81SVZaZHpVTnlvUGwveFpacmU3aW5CcDdSMDF3YlhvaEU1dHly?=
 =?utf-8?B?STNhemlaTjJLdTM3bW9Da2pxWGt6NUFCbDBRZElwZnNQc3NQbG1HUjJhbDht?=
 =?utf-8?B?aWIvbXk2WG9xRkVETGx2R2hqbytBTTVpU3BURXNUb1FpMllpTXFLbUpyU1pm?=
 =?utf-8?B?dDVUeTFSMlVKdlVHL2NjUVpaeDIxNlB1TlkrY2g0NEt2dytnSWNKQVpDMzhF?=
 =?utf-8?B?NzJHNktwN2FRZUUwdi9odU5pT3RXNTgxSkNDL1VPalBEWHRmY3VnWjkrTVZy?=
 =?utf-8?B?eHZGOXJ5Y1NGa2V5QWord2Y1eW00SmdoajIxRGVkY3dnYjVlYTJhRC9nSlIr?=
 =?utf-8?B?NlREZCtWUGFDakVBUjMxQ1Q2Q3lDK0JxMmg1eCt2L3J1MWpsdHpUR05LNDBG?=
 =?utf-8?B?ZGxWS0FYYU5ycDg4K3lVam1PUGhyRmxKRnk3ZVRjNDNRZ201NWMvUTc4ay9L?=
 =?utf-8?B?SHRuSTNRQmw0Vm51TWdKb1RGbXJ2VmtUREFvZStnMTRLYjBzSXdjSHpsSFdB?=
 =?utf-8?Q?JLMZwxgRrh6Mh2m9jeZhWv6U5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37995c5f-1b6a-464f-51e4-08dd15d43f2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:59:09.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKxv7u8v9/7HH28ukfekrnlP87HZmWfes9tD/qR33LzkmlqkRF1PoL/t/PZBCsqwL6YZHsLGEk9p2MhhL5wHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 08:59:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17333

On 06.12.24 09:24, Jan Kiszka wrote:
> On 05.12.24 11:05, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>
>>> This avoids that the running Linux can still access the partition keys =
and possibly leak them. In the future, we may better address that by measur=
e boot.
>>
>> Makes sense to lock the key once we leave initramfs
>>
>>>
>>> Suggested-by: Fabian Bl=C3=A4se <fabian.blaese@siemens-healthineers.com=
>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  .../initramfs-crypt-hook/files/local-top-complete              | 3 +++
>>>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb           | 2 +-
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-com=
plete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> index 834dea22..4bcb4277 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -258,6 +258,9 @@ for partition_set in $partition_sets; do
>>>  	finalize_tpm2_encryption "$part_device"
>>>  done
>>> =20
>>> +# invalidate PCR7 to lock access to the disk keys tpm2_pcrextend=20
>>> +7:sha1=3D1111111111111111111111111111111111111111,sha256=3D11111111111=
11111
>>> +111111111111111111111111111111111111111111111111
>>> +
>>
>> From TCG Platform Firmware Profile Spec [1]:=20
>>
>> "Integrity measurements of the pre-OS environment MUST NOT be extended t=
o the PCRs allocated to the
>> operating system. Any Host Platform configuration change that occurs aft=
er the Host Platform transfers
>> control to an operating system, or while resuming from other power state=
s, is the purview of the operating
>> system and measurements of those events are extended to the PCRs allocat=
ed to the operating system.
>> PCR[0-7] are exclusively for the use of platform firmware. Operating sys=
tem and OS present software
>> should never use those PCRs"
>>
>> Since systemd uses PCR 11 to measure things done in initramfs, including=
 events like
>> enter-initrd and leave-initrd, I recommend binding to PCR 11 in addition=
 to PCR 7 to lock.
>>
>> Working on a patch...
>>
>=20
> Looking forward!
>=20

There is one catch, though: We will have to extend the key binding from
PCR7 to 7+11. That will not work for existing deployments using only
PCR7. We would have to make this configurable, I suppose.

Jan

--=20
Siemens AG, Technology
Linux Expert Center

