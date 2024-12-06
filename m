Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F2E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:45:20 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.69])
 by mx.groups.io with SMTP id smtpd.web10.33497.1733478311734445277
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:45:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cExISaSS;
 spf=pass (domain: siemens.com, ip: 40.107.249.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMOD8CqSg7LsPLARhlKJhm/W0NbbeOqaUbH/vSTI6ioYJeDT0tXcV9oZDkuZCyOuHyQPTFdltDOxLWlIrhvcVv9dN7C+yVUdHBHgO3Jba5DLGM+ds6pwVNznbc1+J/oLO8lTovAC2ntCC82hn84Co4Wrxj3P46ITM35RE6payfV1Tspnp7ZAEjGsTfHQV8txQ2gmRy+woR+fMksz294yfrppkx2fcRRtZ4k5iTzu6KsO+9N3t6eGU/7TESYuWqJi5nNgqmqwe/dOUihZmxFrqWibLgKK5EeoniOv0VHhniXcqNTUh69zGEgXiPFOdukspDPDGFF7vjRW3uSObQu5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkIn3asIp4tpuS1J1tOF7LrGqjNGK/TjAKifZQz4apI=;
 b=Bx6DBImbiptcNXRKU1YnHvRozxrssO3MEzgDVCvWwZOd6FHFLf5y0dgJux5Tsg8nBxAeTXzvmabEzNa8IwHO/VxigSNvQyD/G73bxwLGpwTY283qo/EaeVezbSM9sikScZTOZxPG0+CQ/tTiHeD3meawuArh8nuzsUuVdlyAXuAozyycUgMBV6X93piSbT6GKD2iFekV2TqNwJgfoxhFQzA6wdK5VwP190a+icF6otohR1+YpGCYm7vpDLn6a+xgEiMtmxy+oUBF4fKFXV8KY0VUFfEy9yJnPuQnmuZPmEmR5vmSGBNaV1yPR2uTmd5XhhKqUsEfBChYOjlqcBuXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkIn3asIp4tpuS1J1tOF7LrGqjNGK/TjAKifZQz4apI=;
 b=cExISaSScbQ0XziQDgb2Qq1r2XVHbQktHuG0iE+gEJCHEMxrKbrH+ZuYBmPHAwkjJcwrtF16emPOsVQqNWIc9vAgnARCueO64JiSjodOBB34Pkaxj267O9GG98hqCzB9QWWck4uvCkJFT450BuflKs+oxQr5c4Cdw8OxNirQs3hpSKlyrik/VuH+5ytZHENOUWtTg/dSsdrvlE4zHw+50KgIdTib/GQs79dnEtjPYIU4xElSND9FdWkQ+y4IVpeNd19rDS09j2qV7TWIHroHVGjzU/FSPdOoq6qqEeNFZDfy6bMLzmWIvest2GqiBNXrGmvQa8xO92WXf9izEAXVoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.10; Fri, 6 Dec
 2024 09:45:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:45:08 +0000
Message-ID: <19299b12-b12b-4625-9693-863d03908ca2@siemens.com>
Date: Fri, 6 Dec 2024 10:45:07 +0100
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
 <be4356ab-7c42-4766-a06a-8de8f1cd9c71@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <be4356ab-7c42-4766-a06a-8de8f1cd9c71@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fd5e50-8d25-44c7-8a43-08dd15daab74
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkFLV2pyQWpqYlF3cFdTYWl5d3pMUXFGM0J4VGQvZU13UDlQTmtlSHlUMUdG?=
 =?utf-8?B?UGRCMkhHYlpWTDRWR1dENGRjWS9JUTZuaFdrR3dZZnN5YlpySmhqZGFJVTVh?=
 =?utf-8?B?a2hKeW54SGoydGw0cjhTbkRkMGVzMDhMeGN0ODlMaUpXc3IxS1RZbjBMQWQ1?=
 =?utf-8?B?RzdFcjdCNUpqMmZkelBGaW9XNkkrNVV2MDBOakc2UmFmbktob1RUcTVmeXQy?=
 =?utf-8?B?NUxyYWs2Zkp1REkvT2xVZ0JHZGNWRi85TjdqdmJsU1MvbHppbmFqSXp5SzBz?=
 =?utf-8?B?RlZDenFGUndqaWN6OWoxdzZMRUVKOTM3bjFhYmRBYVdoNDNEcGZTYTlONG5K?=
 =?utf-8?B?NFFkMzVTVVBSZ0ExRVZDbVlrdGRad3lyR09FdXA1QTREV1B2Q2JMREdlblFL?=
 =?utf-8?B?NXF3SHVlZXMxdnFzdTVHVmE5M0JHY3RqL002RWtLM1JhZlAyWVJJdXBnQUtG?=
 =?utf-8?B?TCtUNmJDK21EQmloR2JVeWtKR1dXMTZtdmRtdk5kU2JrWUlKcEc2Wm5FNkE5?=
 =?utf-8?B?aUdNbGtEaDdqdWtEdjFicUhMS01lZFY2dWNyS2x2SURDVGViVkwvTE50WDRK?=
 =?utf-8?B?dFJGeW40TS9kSS84ZXBoUXFzSG03VzlxVUFJUkNTSVdQY1lJa3hqVnQvNHVo?=
 =?utf-8?B?REI1dUdQT2JyMDFiUEpVajB5NHZXMFlZOFdzaGUveGVwMk0zKy8wUjdJS2dl?=
 =?utf-8?B?WVdiYVRiQUk1aDNjczB4MXNRNTc1V2k2dmk1SkhWYzMyb1pWK3RGOGpaVXpD?=
 =?utf-8?B?VmJBVDh5clphbVFGTzh3aFdZcjc5aVRsWXFGcjF6MEFQMTNyQlBoaXVLaVBr?=
 =?utf-8?B?ZTlOOXRKRlN2ekNwa3BHazZtWVZBWVRSSmdFUit3SEdiSVlJeHc3OFAybDFG?=
 =?utf-8?B?R3lVNlBYZ0FKODkrV1IwSXpuRWc5a1hHeHZiWE9wQnhrVWs5amhxUm1tS0p4?=
 =?utf-8?B?aE1sL05raWF5QUdHc3N5eThvRS9CaWMvTHhOeWkvM2ltclhpaHhSSnE4UkRa?=
 =?utf-8?B?cHg0U25VZXA5UlZXZWgydFVQNkdvZ1loODhQaGtHTW1zRmNaOWxSSHAxVTVN?=
 =?utf-8?B?NmpiQS92ZlVXRWZZdUtWQVVZR2tNbmhTZFdzWWtFYzRpTHRSWnFrZHJ1TGpq?=
 =?utf-8?B?eFE4dlh1L2Fja09TOU9ZR2tLVkR3UVAxR0JDd2VkL1oydXhNQjlUaTZNYW9l?=
 =?utf-8?B?WHgzdnUvQ1ZiVDlabjdvMEZVaXFvaDc2Rk5rNFBDTElDR1U0bFBqL0xrRWNx?=
 =?utf-8?B?enEybnQvdVdjMS9PT0o2VlIyZDRCVTdsVEpqL1lBcm43emNhTmpNbXlqY0s4?=
 =?utf-8?B?N0V4OG04VEVvb04xYzlnZ3JVUVBXaEFYVFNQbHprTFRtYXpaV2ZCTzB6V05o?=
 =?utf-8?B?Yk5mbTdpc3BLcmpLVTNEbEwrYlRweDBZR0hORWVoNFdISnlhOWdZN1FNNlda?=
 =?utf-8?B?RW1kazdCQTJaTktYUHZMUnR4QktlT3NmOHZiOTZqbzI1MHMxVW5MZEIrUFNH?=
 =?utf-8?B?bjVRMis5cVp6bWh4V3FhcXZvaGc2UkRvQWE4Q3dRYnUrY25tQUdTZ1hsdkZj?=
 =?utf-8?B?eXJqL2ViT0o2UXEzbHgvcGRhM09ZU1llcjV3V3hQbTdxdFlJbERrQ1ZuMnZn?=
 =?utf-8?B?S0g1MjlOY0c5YzVIaUlOQzd1K240eExodFJzN2VPTHd6MnlaMjdBWTZKVVBD?=
 =?utf-8?B?aUx2SWowZTh6UGZKcUswOFJVNFZ5NkJnQTUzN1Q5eFN4bm5XUWczMThWK1pV?=
 =?utf-8?B?c2tCR1dvc3FkSVdPL1VUb3Q5MXZQdERTOHZtcDVXWHBkcTRNRGhUamxNUWd6?=
 =?utf-8?B?VGxzNkluQm9SVzNIOE1kdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FycmpYZ28yYmc4cGdBaFJmTWNZV3BHYWJjRXE1R0R2NXIzaE5yUEYwNTdr?=
 =?utf-8?B?NCszcnd0MFkvT0xuVVNRcVN1cEQwNVptN3VzR0RCU3d4M0FlMGxoUGM1Yk42?=
 =?utf-8?B?N1hQZi9PWEp3bVg1S3QwSUlGZVNSNktvUFY1QWoxcUx0R0x1WVNNZ2FIaURa?=
 =?utf-8?B?UkhFSmh0VkhKVG5sU3dYbWpsYUxWYTRqMXlUSk02U1JqU0JrYzhtUXBkRkFl?=
 =?utf-8?B?RDlLVCtzWXRwZXd1aTRwQ21NK2R3bnM4THFqZXVpaUNnWjhQOEdmVVlzMHRn?=
 =?utf-8?B?QWR4bjRUK2VNcmIxSkFZL1RPdUxkeEtTME1GY2tKMlYwNDFlTVlYQldYY1Zr?=
 =?utf-8?B?SXJjcmRJMEo0Mk9KNk1ac29ZSG94K0xMQ0NYQkZuNFJOWnJTUXdvVVdhL09Z?=
 =?utf-8?B?M2lYRVRhcWdmN3hweVhCUnVJWXFIL2RNN0VGMTFMZStkcS82OWlvbWk4MUZq?=
 =?utf-8?B?VGdnMTZyZXFhUEZVbGJaZTRxbzJBS0Q1cGRsMUtLS1dYNlkrVVB1ZXMzQ09o?=
 =?utf-8?B?QlBRbnZ3czJCWEwvM01odXFFbEowLzBOcmRpQ3hZM3hXRHVBcDdZaVZlbDdH?=
 =?utf-8?B?RkV5Q2w0OGVnMFFiZ2c3UDdRQzlUcEVqcG5ibGdVemtyZnZxaHJKZWJmYXVP?=
 =?utf-8?B?bUNlY1A0c28xM2FYZFU5dFRLK01tMWp2WEtRVEpSRkNpYjluL0hhUFVMZkcx?=
 =?utf-8?B?WGNWMVd5bU1VV3dmbFBrRURvbngxMjBBVnJ5UWxVUmY1SVZNSTRhdjNjWDhm?=
 =?utf-8?B?K2R3VFlDam9NTk5hN3lWN2gwZndBRVBsNWVNbnNGSEhPUFc5MU5NN2tBeTM2?=
 =?utf-8?B?UE1JUGNIZ0l2NFA0NWpYd0JBakVRMUg3TXJsUDVUZFN6TnBNV0FjeUJPbG5x?=
 =?utf-8?B?cFFiOWtHcWNVeVlOOHVjMjBaWlhGMVhmYWVpSkFRRXo0dWhJQTM2YWs1N2pC?=
 =?utf-8?B?Zkc0S2hDRCtoLzNCSE0zYklRZGhPNWZUekZLbWxwL0JoY1JiQUZNWmFoTmVL?=
 =?utf-8?B?ajZCUldvNXRHT0VTWFJkakpubUJudzZkOUJGY3BYNmx6am1ySUtXZk4reEQy?=
 =?utf-8?B?N1pGdTlnbWtydGw0V2h5R2NmTWd6anRCNG9WMG1SZytKd3ZvbksrQkIxOVJY?=
 =?utf-8?B?VlRaZ1RHU2xxKzRBd0QxWlV4NkFyWDNEeVNwMDE3WjVYT3ZyZnRUSks2dGpt?=
 =?utf-8?B?QlFYYjNXMjB1UzhHT0hVRURLMTFmRGcrbGE2MWdSUndNZWRvVStLQnVIbDlO?=
 =?utf-8?B?dzYxMkUyMVlRUjE1Y08vd3BnamdJTmdLaFZ2Mm9SMjZaWTlVUURqM3I4OTdx?=
 =?utf-8?B?emExOFRkeEUwRlMxdStHdnk5NFhRbndJRU1UVS9LY2NBYjV2T2ZvWTZ5TzRZ?=
 =?utf-8?B?NStEbjZDQ2RaTThvcGd3WndPeGoyd1oxMTFoNXA0cTc5RHhFaXhza3c0Vm42?=
 =?utf-8?B?NjlXWERQTXo2djdpTjhobTJHL1MwdVZtNk9RRkZRRFJvcDBFeWkxTW5pcUpq?=
 =?utf-8?B?L0VvUnVXUEdvSFRBbGR5NnV1K3J3MmhDWit0Tk5sMVZXVklqeVhYRHgzOENR?=
 =?utf-8?B?bHI0TFYvRDVkR3EwVHZMaUpMZEJhQ1JmcFFQaElmY0duZENycWw1NjJZL29w?=
 =?utf-8?B?OWQ1SHZSQkU3OUZ1a0ZJUVN1NTU1TGZ3Q3Y2cE1PVThmcU1UeDRoNjhrT0lk?=
 =?utf-8?B?MHhvVGlaeFFsQ3Z3M3lIazE3ZVl6S2crR0VJNnVPWjlIZXJ3OFdTTEU4ckhR?=
 =?utf-8?B?RnA0QmFRNDlRWHRucGZ5UTludkhXOUlLdjFXS1hJOW11a2QrQlM4UDMySkhX?=
 =?utf-8?B?dDFyamJQYkRUT2taeDBiajZ5L09IeFFOaDhCQlNQTTd3N2daam1DMGZyUGdh?=
 =?utf-8?B?VjdpckxWNEtSaXhIbU5lWTh0UmhmNnlaSnR2RlFvTzlmQlpsWGNseUFNdGFM?=
 =?utf-8?B?cHIrMnlzWkpTWEVROFRtZWptZkZHQmRIbW1LaFkxLzl0OEU5REJlNGNKaUdB?=
 =?utf-8?B?eWw2ekZsWGZsK1VXbHlGdFdwVjNLTit6SFVTbDg1TjZqcUFocTl6MkN0Y3hB?=
 =?utf-8?B?aDRNWDVCQUlDamZhRzhVb0NEcFdXRVcvRncwWk5qNjU0ME1tandNY2RrVVpq?=
 =?utf-8?Q?Dy6dXnRrjgg8arR7GbnXKupgo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd5e50-8d25-44c7-8a43-08dd15daab74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:45:08.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9p9cY/rdwYTa2ACP7dDpIgjpHMzEDug24O7+guVmPUcM7IpisjgjHhc2r7YE43ou0Pdk6DqbGZyUsepWBB5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:45:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17360

On 06.12.24 09:59, Jan Kiszka wrote:
> On 06.12.24 09:24, Jan Kiszka wrote:
>> On 05.12.24 11:05, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>
>>>> This avoids that the running Linux can still access the partition keys=
 and possibly leak them. In the future, we may better address that by measu=
re boot.
>>>
>>> Makes sense to lock the key once we leave initramfs
>>>
>>>>
>>>> Suggested-by: Fabian Bl=C3=A4se <fabian.blaese@siemens-healthineers.co=
m>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  .../initramfs-crypt-hook/files/local-top-complete              | 3 ++=
+
>>>>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb           | 2 +-
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-co=
mplete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>>> index 834dea22..4bcb4277 100644
>>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>>> @@ -258,6 +258,9 @@ for partition_set in $partition_sets; do
>>>>  	finalize_tpm2_encryption "$part_device"
>>>>  done
>>>> =20
>>>> +# invalidate PCR7 to lock access to the disk keys tpm2_pcrextend=20
>>>> +7:sha1=3D1111111111111111111111111111111111111111,sha256=3D1111111111=
111111
>>>> +111111111111111111111111111111111111111111111111
>>>> +
>>>
>>> From TCG Platform Firmware Profile Spec [1]:=20
>>>
>>> "Integrity measurements of the pre-OS environment MUST NOT be extended =
to the PCRs allocated to the
>>> operating system. Any Host Platform configuration change that occurs af=
ter the Host Platform transfers
>>> control to an operating system, or while resuming from other power stat=
es, is the purview of the operating
>>> system and measurements of those events are extended to the PCRs alloca=
ted to the operating system.
>>> PCR[0-7] are exclusively for the use of platform firmware. Operating sy=
stem and OS present software
>>> should never use those PCRs"
>>>
>>> Since systemd uses PCR 11 to measure things done in initramfs, includin=
g events like
>>> enter-initrd and leave-initrd, I recommend binding to PCR 11 in additio=
n to PCR 7 to lock.
>>>
>>> Working on a patch...
>>>
>>
>> Looking forward!
>>
>=20
> There is one catch, though: We will have to extend the key binding from
> PCR7 to 7+11. That will not work for existing deployments using only
> PCR7. We would have to make this configurable, I suppose.
>=20

This likely needs some more thoughts and possibly controls. I'm dropping
this patch for now so that we are not rushing something into the
upcoming release which will cause more headaches than benefits.

Jan

--=20
Siemens AG, Technology
Linux Expert Center

