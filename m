Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2873D1CA29
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 05:28:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.81])
 by mx.groups.io with SMTP id smtpd.web11.10928.1730784493929626656
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Nov 2024 21:28:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HbX8uA55;
 spf=pass (domain: siemens.com, ip: 40.107.22.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G17ueuL8UE9JARH6o/p7YjUEtzyF1uYCyin25ae+GMxHtOy5dGdZbrRjf1ADX2tw1bLkpnzy3kO1qg2gDZVBzp9MdA9WtIN80xnyX9Cwe3YI3HgebdwovwcUmIMQ0arMlEiYvrnvyUoLPCjP+18FQ7ax/ujTZRp7gzHslwSqS/BkLhL+P2y+zTvgoxJjFLLagH2uxeR6HCkvyT6svycRNx8IRBli218CVnmxn/fzk+BxzNQnga6B6XTETesEXNfBBxBIr4ev4B2ka3u3HSh+JGVgoURcXC+plvc8h1dDQdFWNxIHQN/vZnxzeRJrn7Sev5+yBk6z1fvYewY3wL7ihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFgjY/uRgVASlwB7rVLDd5Bou8uN1ZbWlmL2LnbjEW8=;
 b=iLsp1BorX/xG99lgBmpRjMKXnz8zzOPQKa7egj7TSZIiaPNNcLn/CmHvLVN96db0lI0QMFZe7Zh4ep5wsYxlamXwLjBoADG4eH72qUlfBuoZH/hh6VDarqO7fdazh5ytk4AGz8vxX4UnrHQ9htFmKzntsh47VQefiNJPG6F58GMC27WFCS27HF63yXMYjCml2Ry/4T+wiWn4kqU4eK9Ch1ZNOARSn4FLafNj1tbkOKSqmYKc9UZKwYmvhgeS11A1IQlIFcgsF1xmCP5Vzo6fd4J28JdvkEkqYbUFRTNiMFzYSpSmiLydZz+zevBYr5XyY0AjZzxOKfbH7mo6OXTpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFgjY/uRgVASlwB7rVLDd5Bou8uN1ZbWlmL2LnbjEW8=;
 b=HbX8uA55wxigW/ekiu7FXw5vbtSh3uV7ru1W+JdzbupG4OCpdBBHRO9pNIRY1TnTr6DIYGi0bqBD2nvhZnpmklCo8pCUHASCVY66z9cs92NzDhvG6Tijoemr3xPK9R11WW9BKGz6oSNoAHb76LnMCF1v2sSfxr6Zhns1+zJHtGS+30ABUyyevGB92Nzxl08HbSqkuv+FS6uz/z0V9SBZCOTfvtd3P0OEkbX9JGwQKjtOJLWjUCOtSYQ8JMVwGqXLttcex2Vd1TYxwogH5yPMdAqcPVIGy/nR4k313K9bj1IGUP/RyMTSORuFGAq06UmW471bYzmBeVtZhEolgI8OAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3624.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 05:28:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 05:28:10 +0000
Message-ID: <eed5f54e-5b35-4c97-98de-dac1f9c33caf@siemens.com>
Date: Tue, 5 Nov 2024 06:28:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3624:EE_
X-MS-Office365-Filtering-Correlation-Id: 245df9ea-dd86-47af-9089-08dcfd5aa2d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b1JxdHpRS2Y0M3BLUkVmeWg2RFhuZk5BMEkzWk9DZi9yTWV0RmJYeDZFWE0x?=
 =?utf-8?B?N3phZnBLMGdiQkkwYXJxNVcrcEdDWFdBR1UzVDVaS0dEaGRKaTdUazd3WVd0?=
 =?utf-8?B?MDNqTFhjdXRnNjJtZ1c3K3FnUERyZVFVNlJXY1l4OEpIeVN3V3JEMkdjRzdt?=
 =?utf-8?B?cDVRcjl0UHJjYllqYUd6R3F2emRpanExanVKRXVOTmxWY1ZMSzg4aUc4c0lF?=
 =?utf-8?B?UnZCODloMHdpQTRMQ2ZzTW1sOWt2a2c3cmFPcXlORzVqcUxTUjd4eHJJc2NS?=
 =?utf-8?B?QUFkR1g3TjcxQ1dNSVNFYVNoM2E5b0xmeHlxNkFFUy8xYUx3dzhadFNaQ3FN?=
 =?utf-8?B?cWhvSmhDYit2bzVZMlFzYXRPV0JMMkRNVm0xR0hrdmFrNUFDWXR1aDNCMDFq?=
 =?utf-8?B?c2NLRklOQS9IYXJEUElHbWZDaG5zTytOdzBCUXdjUmUrZi9ITGlGMUg5NGdU?=
 =?utf-8?B?NDBONFBvRERvM2ZtMDYyUmE1MW12QVh0bEZicTE4Y3M3cmlEcnJzaXkwYUZY?=
 =?utf-8?B?WFhsM2ZmVTVaaFlZU3ZEZmRuamJpZnkzQUR5QzEwZ0RKcnpoZ2loSUVxUVRV?=
 =?utf-8?B?ZHYyMVBvajZOMmVnODFhNDJQd0NxcHh3VjFMc0N5Q01JM0c2cWpmdlQrbmVU?=
 =?utf-8?B?YnNWa1ZmZWFYZGJDc1BlTWExNG82YncySmlqUFpVVXFLcWRXYzg2aklCNGZa?=
 =?utf-8?B?TW0wTHphSkI3eGlVdmczODI3MHNpNHRVcGU2ZHl0c21mQm5zOTBpSzlENFVY?=
 =?utf-8?B?WU1JN3EveStJT0NIRUYweGVqa05HbnU4cTlFaDh2RisxQWg2YlVYTGZLV3JV?=
 =?utf-8?B?aHRnTEt3TmhROUVNSHFaQmMyZFpiMytidjQwMjRNeGtTZXZWaTNsR3JCUGg2?=
 =?utf-8?B?cHFmM1U4RUhJNjNyaGVRRi9PUVBRdUc0cFVLNW1kcDdXSS9qUzFXdTVleVBm?=
 =?utf-8?B?cUtOakFjK2hjYnlMM0hTTldwZ0pTR00wUXVxUUp2bG9xSGF5NzhqQXl1d3FZ?=
 =?utf-8?B?OGNBMlcyNVB2andiNXFSMi91Q0t6VUl6WE5wcDlQa0pGRVRYNnpwREYzWmVW?=
 =?utf-8?B?QVhlMzdjcldxa3dSWDlTSEVjeUVoQUo4MVhIeWVsUm9ucHk5NWtyaXN5Y2Jm?=
 =?utf-8?B?MFFkWmZXMDE4UDhUVTFzVE5jRWExeUVLMnFiR2g4WTRObFBNUDlydHhCSXoz?=
 =?utf-8?B?NXdaTFVZZHEzSTFFcS92b05penRxRUZJQUlzREZOZkoyU1NJajJLdnY4c1dt?=
 =?utf-8?B?Y20xd3MwNk5xY0VDK1FIMXBJOGtQVzlLQVRrN1ZzVzRrSllBYVZFUlAxbzJv?=
 =?utf-8?B?eU0waHYzQUdBMFJXSHpCUzdubWgxSWR4WDhvSXh0ZlUzVUdYY0lQZW4wZ0Zi?=
 =?utf-8?B?Z2tOQW5ESVcyOXN3c2hmSWZtMy8vczNqVWZBcUp0R21kZ1FPdXRhWlVBSmRz?=
 =?utf-8?B?WTNSYzMrZ3dQelZTMGFzVnBaQjZCVm9OQWVDYmZzUmlaVzdJM1ltd2l0aUsv?=
 =?utf-8?B?T2lPTnFoaHAxTTdnZUdhcHBZMHhOTW8vMDNBUVF4VGhud3ZBbm9KRTlSdEYw?=
 =?utf-8?B?TjQ2OHZTTXhZQTd3dXBGandjM3NyVEFXMS8xZCsrMjFQVFByWkN1QlhpU0tp?=
 =?utf-8?B?VTdJbkNscjNRak5tb1BZTXBWanIveVhHUURwaVhKK1FzY216VVYvclN3aHJR?=
 =?utf-8?Q?RK1a4t1JeJwA2XkcanXX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckt3UGhhVVZ2eFBpTXVBQ09SZGZrb0s5Z1BOaTAwQmZFKzJLOG05ek05SmIv?=
 =?utf-8?B?c1VVeGUxa0JMc2RmRnpnUDVKR3dVaEJzU2lWdUtoL0psWWhTQjJJeTVxTytX?=
 =?utf-8?B?MUtrd2huVjZidXRXbkU4QjNWTVc1MzFVYUh0VmVaRVgxZ3JMNk8yaHNndmhO?=
 =?utf-8?B?U2J6YXp2dml6dVVnQ3A0d1FLMXpMV0JzeTlhSXBTMHJyU2FnZmtjOEpyN2tN?=
 =?utf-8?B?M0JSclNMZDlGUmREbit0aXhuMWorQk1ZUVZRd0VRWTNFN3d1Y1FFNjJQc3A3?=
 =?utf-8?B?NTM0cEF6a1k2WHdKME82TlhjQStSZEZFVmFzMDB5ZWxUNVlpVlNwUWxxRXJM?=
 =?utf-8?B?QmkwV1BpK0MzVGt5NmhGMFFvSHYzL1haTkV2OHhJQ1FiR1JqMmRsTTYyRlNL?=
 =?utf-8?B?ekI1c2JZSVZRRy9mQitZZWVjei9pSmFpdEc4VGZ0TmZRajU5MXFPOS8vZEpt?=
 =?utf-8?B?MXp5VDdQYkZYNXBmbi9vMVpNenRseEovZ25zejB3RWxsOFV4QnhxN3hjdktY?=
 =?utf-8?B?R2dGOGJ5aHFsSWc0QjhES1FGWE9MSXp2dUxLNkt2ZStKZFMrNjJ4K29vTUZM?=
 =?utf-8?B?UDFTblViOHd1cnRkYzk4TjN1aGx6UGRCaXhCT2RuUjdxeDlyeE81cFRPeWhv?=
 =?utf-8?B?ZjhHNGhRejFiaEUraU10VlB5Y3RoaEpmRDU3L1k4aWd3Z2NyK2JYTS9qS2ZQ?=
 =?utf-8?B?M1JSc3hiUzhOQzFlZkI5eFljdk5tdTdUZUdWU3h0NUFtUjRJSWJURVd6amdK?=
 =?utf-8?B?SkRLRzB3Y0loMzRtamF1WVB3VHkrMDVBZEZwNmp1N0oyQ2dHbkcwaEdHZXZs?=
 =?utf-8?B?NTc5UU51eDZ5TElTWXZHWUM1Zk9TZmhzVnJXVmZpS3RmRWt3K0drVEVUYnJ6?=
 =?utf-8?B?YURXdzBUdm5IaFQrZzM0aVVRZkNrRW1pNHd0TlkxL2R5OE1XNndxZ2FSK05Q?=
 =?utf-8?B?NFBqaFh6RFl0UnpmQ0RyQ3YxK09BM2pGR1hCZEpRVVFiYzVkS29FQks0VWlC?=
 =?utf-8?B?SlNzQWJFR2NOQ2QxQmRNSUM0ZC9HdVc5ZXBNb25LZzBIVWtwSHJvMU5vMlNX?=
 =?utf-8?B?ZFJQUDZ5WmJ6YkpEL0FqVk1EWHY5aDNXVVFCOExRV29XN0VsVVdIczBkWHVX?=
 =?utf-8?B?aTVMVTgvY3hpazRTNHdBOWcwT3RnSWxaNk42ZGJUUWprMFZYQnBXbWhWMlpC?=
 =?utf-8?B?M3NlUFJZcnljcXBzMmRjalNBbFBrQTd0RG5ZNy9uY0dBWUlHYVVtT0wrNWxJ?=
 =?utf-8?B?T3VvM0xrMjdMQXplYjduTEo1bCtISVpxWnFWaEdZS2p4RGkvVGVRazFySHhh?=
 =?utf-8?B?OCsyWHdmMGRjU3BtWVpLeWdnOWVTeEExRDhReDR5LytZdlN3WjBDZHgxU29h?=
 =?utf-8?B?VzAwbE1LamRNc2JYeDJtKzhhMUlqcFFtU24yZk5zcTN2MUJMNzNGRGlVMmFW?=
 =?utf-8?B?L3BHY28wbVJEWnRFNHVWRU1vYUt3eXV3eEJVUmZjdVkxNWY2eGpFZXh1OTRy?=
 =?utf-8?B?VEpEKy80VzRiTytLck53RXc4Qi9JS1htcDgyQ1ZJR3p1WFFSMkFRTUtQVFp5?=
 =?utf-8?B?NDBHT3BZNG5ULy9nKzA0c0pMZmF0NXNiS0d1Z0traXF3RTBHSkZ1ZlJCeWk4?=
 =?utf-8?B?TVQ2Uk52MXV1amFCZ2dDaU1hODhTMGJCWnZEQXNMK3hCK2VVbWtmRjdxQ3Fn?=
 =?utf-8?B?NDlpM0RscS9vdm5oVjFKN3U0ZHFBOG0yWXJPTUNZcG51SDFJWFFraDdmMW9G?=
 =?utf-8?B?MTIzZmM5VEx1MmNKY2NQWjR4Skx6VUJQd1oxcEsyUklGWkpXdmpLNE5MdUcx?=
 =?utf-8?B?SWNDd1IreGxZK29xdFdBbHRocFB5NnJQQkJvdEMzcFhDUWRFdy9uT2l2a0xH?=
 =?utf-8?B?cmZRWVY2QkxQSkdCYjQ2OE9MZmN4cW1NU05BT213Rkt1MTR2aUdHaEE5bDd5?=
 =?utf-8?B?NjYvQzFUSkp2bFU0Y0FLcUF1ZEdYNnFHdUdEa0o0V1pJd25Ocm1BdkduR3k5?=
 =?utf-8?B?NkxsQ2p0QTZDQ2l1SllidXh4NWdRK1VSV3BhbjgvenN0NTdCbndkM3Z0QXBU?=
 =?utf-8?B?em8vTlpWY0FZYk1vV2Z6ZVNmUGVEQWI5OTRZUlpISDVEaVR0ZUQ5VFQ3c0d6?=
 =?utf-8?Q?o31VkUgwD89Cs783f96T4n6/c?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245df9ea-dd86-47af-9089-08dcfd5aa2d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:28:10.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpK1JKytVAQ1/NiM4BXww/Vi+tCmoayacwyZd7J57DZ8mYg8pFQYUsfgj1pUgluhOcy4Ur9WEBYWCmtZS/M6fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3624
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 05:28:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17169

On 24.10.24 18:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>    Unfortunately, I could not find such library anywhere! - Therefore, expand on first boot and similar,
>>>    still won't work for current disk encryption implementations for buster and bullseye.
>>
>> There is no clevis library as clevis is more or less a bunch of shell scripts. If you want use expand-on-first boot with clevis a solution would be to extract the passphrase, see [1],  from the tpm2 partition enter it via a environment variable.
>>
>> [1]:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.tpm2.encryption.md?ref_type=heads#steps-to-convert-clevis-to-systemd
>>
> 
> That means a bigger effort on `expand-on-first-boot` script than just setting
> the correct package dependencies!
> 
> Currently, we are using systemd based cryptenroll in our project.
> So there is not too much motivation digging into clevis for that use case.
> 
> Still, I think fixing the issue for bookworm (systemd-tmp2) is better than not fixing it at all.
> 
> 
>>> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES ?= ""
>>> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions ?= "\
>>> +    cryptsetup, \
>>> +    libtss2-esys-3.0.2-0, \
>>> +    libtss2-rc0, \
>>> +    libtss2-mu0 \
>>> +    "
>>> +
>>> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions:buster ?= "\
>>> +    cryptsetup, \
>>> +    libtss2-esys0 \
>>> +    "
> 
> If we fix it only for systemd-tpm2, it's questionable if the additional dependencies
> for bullseye and buster should be added to `ADDITIONAL_DISK_ENCRYPTION_PACKAGES`.
> 

But then we wouldn't be able to apply patch 2 of this series anymore.
And we really need some consolidation now because trixie will grow the
dependency variants even further: append "t64" to the tpm2-tss packages,
they are now using 64-bit time_t.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

