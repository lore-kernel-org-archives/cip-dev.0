Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D89EC3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 10:20:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web10.14761.1704277233848737262
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 02:20:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EVkORoA+;
 spf=pass (domain: siemens.com, ip: 40.107.20.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E59re2jDceix4d2ktlUtr/0cjM1LKwlmHWTlYrf5JboYksn5ZQnPc9TRQMMEd4vj9tD2wYHtob9JSRpPF/Roj13fEXtai9cQFnDQ4F9uDa0VkkSqIZG49KdEJfYE3nHLekK75k9K7RYuZVja/geHa5N9/ryFh4ZKCwvnfCLjsN9D0zqihNIdB2jVrwVPpHmM344e3XrgFyJwwY+Vzfmx0Ga1dkTXXmeDgRPmALgtcaKDTAmdbmXKsXGEwRQRlc9KDg2BVx+QFPCH2ggspIajzrMt8KBgFOk7j23QHftrlljAUXoTnq8gy8hwBliW5yiIZcL0JfIImf+VURaadvQOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nzWGDxmtb0xVUEWDpbghKP5AOAOBs7miXTUu82RLBo=;
 b=PBOitG6ONPtbtEztfBOGkOjYsdZhYVxOieT40ERIayGfrZnJcCo7zQQO7bzypAaB93NmuhGmX+s85dC5bnCiHWfGTTN2YCK/iAfalV/pmSScq1NuYpsMb/NK0BfOaGJbPtgpcH9JIvUpbDoifHIo+oravI4yi3Da/2oBONX1VBwQayIC+SNBiD227JyIDBmv3xVm9Nt3utI3a1C20Zf3CqNZPpL4qpU7Uzw8xgDO6Jt6ONaGF9fLAuyAjP8rLPx1RjLTdFjEWhcberdhpNsEK/hK51nYMVkfBst5A3s8qGW2+Bk9lB0KUF84WPMCUIoW6gTRPAkXW92FOnfAEGhaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nzWGDxmtb0xVUEWDpbghKP5AOAOBs7miXTUu82RLBo=;
 b=EVkORoA+TWgd8jV+4WGKt2OM1wYVOAx3+8UbAjfky+n2SJjatAY5xFMmJt3vBb8208jnJWGv3cGCyhNjOqPBIO2SI4UH5dBt8hkqngOQhKCaby7uvrhvC6Yrg2Aq6do3LT0BmzMnn2YklQupFmeIMF403FiDVhwcvDkO7iIbfW9HYF2eMv+Wjf28uiHlf4nMlne5Ipvqa2dzVWoYhxBpWPOF5a9Z2LLaplkQ+JDyKi4XVPw3Fmv4CyRRjyxtvDDPUlPdoFXHza8dYbXB9pfsp1QNtsG32ff7kWAyzXz6Zck/tLC/J8IxTUjBDSGWuoZGptziWaKSv9KIrCZ8IypkHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:20:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:20:29 +0000
Message-ID: <37a5340d-16db-4965-b643-e744a8936d15@siemens.com>
Date: Wed, 3 Jan 2024 11:20:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Content-Language: en-US
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
 <OSZPR01MB6816A87ADFCB148C8F45958FB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
 <6f1c5d79-a5a0-4bac-8df7-5c6d08f98644@siemens.com>
 <OSZPR01MB70193C0057170A3D8E629A9FAA61A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSZPR01MB70193C0057170A3D8E629A9FAA61A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 22748003-dd99-4553-73e0-08dc0c459c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TescI5XznoM5ZMo/ztsv5pDWX69lQcNkCBkbj5aFgHmfWOFNQMJ8EOUH6zJ2lyJFGC1JjH+UmDybAEth/M8dUH1oPvo8/s3m0FseCGdOEFwqbAWcE57+RLdliPdEltu8bVgFOmU5FHUDoHGlrw3lIfF6D6FsWQEcYKypNEINVxBAnA5kOCpV+WP1EDGQFGYtbSoX+NTbXN36vgHLxh0UtfyhQ1BwoMKMU3MlHzlMJdyAKIZ6D3MuigcUUCOZBkQoiAqUD6wjAOEjjXnGFjJA0Vy78u+Aw443kBYfqlwbjQPbACgNwG+b9+avwi2icKkh14vR3bkU23VjzwO7ITF57bT6CLxs9Bq2DG+jlCmI+QmZPEBZlPn5WTjVRIMqK/XShQ+5ev9kzzxRxRIhqQfObg1ZuYgjiD6JmPrIMlQbmxrQoV1JrRkobOiawbIQqLRaiWCR8YDZBkGh4ZEx8UEGDTyo+YkSsiUygGSyTfWDN2RAuZEpkyoPvKjj+1WCn1WZxdrsB8foG6CmG0Dc1bUY/evYzlRAlCIr847t4ByJvlimhfSg+qprHxucsqSA8J9shiITQCgMsJaC+3dVahjpe/JsbrtPWMh7XFQ2zjz3XK10gqlNkxn1RSPC6X+YKoeg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(4326008)(5660300002)(26005)(2616005)(31686004)(44832011)(86362001)(82960400001)(31696002)(38100700002)(54906003)(110136005)(6512007)(6506007)(316002)(36756003)(2906002)(83380400001)(8676002)(53546011)(478600001)(66556008)(66946007)(66476007)(8936002)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djlTV1IvS2lQcUNLMHU4S3BNZHFXbWg1eFBXUG5Xa1kzb3IrQzNpWUpiYm4v?=
 =?utf-8?B?R3BqTHNkUksvbkxzRTJEZ2lPdDFpNEJVYUxoU1VUaTh6QXhjODZERk5hc2Qy?=
 =?utf-8?B?K3Bzc1c0YzJaMk9NSkppanUwUzlqRHRtQ0xWRUIwSmZPbWM3aDVOMjNKT0F2?=
 =?utf-8?B?WTM4WHVxS2NOYnErVUE0NC8vMXFpQjczblJKZEVVcHRWYXcyb2J0S3lSd21i?=
 =?utf-8?B?TEdYSUtOelN0a2lsRWhyeDNLTUlWNlk2eExtVit0WTlKQ01iMEFQSjVwWFlu?=
 =?utf-8?B?aXpXTkZmN1Y3YnpjVElwYllQcTRJcm9tWEhjR1I0QlV1SmJVZjJzcXVENk9Z?=
 =?utf-8?B?K1JHbXlzMmxOUG5FUUJFM0RrSFJ3L21RdEtiOVFNYm9sdmorMlVjNHZEcVlq?=
 =?utf-8?B?ckczaUVEcWRIREhDcmZ4K0hEU2szWlFNaDIzVzZrbkVDYS82enVxMVVXbEpl?=
 =?utf-8?B?RERJeDh0OVFja0RQSncxQ0w1VitoaFEvbUw5QThXSVFDemJwMG5zVGVka082?=
 =?utf-8?B?WFljem94RXlOemhVUjVJN2RNWW5jejgwRVFOU0VJSCtEdFRNSnhXTnR3bTVi?=
 =?utf-8?B?YXdhT0dZenRNQUVmZW9qZ05qNzNxR0JyV0lxOCtYaFRLUWRCc09lWU5Xb2ZI?=
 =?utf-8?B?c1hLZDQ1Z0N4WVN0WGhINnBUMmtMVzFLYmpBYlMzdDJOUXpQTTg2YVFjc0hW?=
 =?utf-8?B?YnVNNnJOeTNOTGFXMk45UC9IMTJKbjlMRUI2UEcxSmRwaXRlT0NqbmF3VGhM?=
 =?utf-8?B?QXpjY3E5eU85bnZvSEhDTkRmN0t1Y01SWnlDb1BnWmRtSG4yUVMvb01Ndmd0?=
 =?utf-8?B?VGNuMndhVGhLdmVBNjVQb2dYRVlSRFNUVFlONkRMdDJQVmxqZUthNnJqU1k3?=
 =?utf-8?B?cFNvclJGVFJ5eVRSc3ZHY0RHYWltRGErRXZMY1BFeFozN040MXg3aWFuYzV6?=
 =?utf-8?B?a0tGY3ZENGZKbVRZaEV2SExWOUJJMGxSRHZYYTd1NzQ4VXRjbWZvcDNpSmhk?=
 =?utf-8?B?TFEwNHlXekFSY1NXc1IwZWFvRzhkTFZqenVuY1ZjQUVKMUJKSHpBV3V0aGhn?=
 =?utf-8?B?V2NlVnBaTXEyRVFnVlpBa1hsWUxMVi9xbjYzYkdOWGF4eVI4enJBK3FWNy80?=
 =?utf-8?B?OHdaNG9UNTNJK20vbEhIc0FnUkdJeHB5TjdvcTdObHVlZUp1WGJ0TTVHUXN1?=
 =?utf-8?B?OXhiQTA4NzVrN3F4Y2hvZUlsQWFLUEFaalF6SnVESm1rNVVJYzVVOXJVb3lT?=
 =?utf-8?B?RUkvTHY2U2tEZFI1TmZZcXpwa2tZNjlwTlRjK21MVFgyVnlmR1hQUUFaMERx?=
 =?utf-8?B?K01PbzR2YzRtZUw0MmlSb05iUjB3VE93VlpRTDBXS2YrNndjemlSNjBlL3ow?=
 =?utf-8?B?aW9USGZjdm1KMnFMTXFiZUQ3aExDZkZQRDZUak1hYm9wR0p2Y0UyN2xoZzRK?=
 =?utf-8?B?eGw2Szl3Y01SNUx6VWdJb1kvSGtNMlFHNWEza1ovNW1FU2lsSVJqYkpmYkJp?=
 =?utf-8?B?aUk3b2g1dGFhUmtQSmk5OXNmUkl3M3EwV2V6d083WVk3V04rWGc4OFJwZXpM?=
 =?utf-8?B?K2huRnVrdjZuT2R0YVZNMEZGY0x6MTNkOFhpMURrSHNWYmJjUU1xL0M0dWli?=
 =?utf-8?B?TmZ6Y3pwdmNZdUNINW5aTnRQQVBkV0hZalVEbG9wRjRjYzF0VWZuSmtuMTIr?=
 =?utf-8?B?TjF1Mzc0RVZNQk9wdysxYTltUWFWeVA1OXlKeDJhOEZGeVlqRUd3MmdKeGlQ?=
 =?utf-8?B?bTl5cmhPdEZpcDRlcU0vUk5RMGI2MlRHck5iVnhwaHJNTjlZQW9hWFpiamRk?=
 =?utf-8?B?K0RCV0JCR3N6aE53WGcxQTJ5Smp3amRUMGhPWWs5N0ZUK3hEQ1praXRIbkVn?=
 =?utf-8?B?eW83N21kY1JYdXN6TSs2bmNmL3EzOElURGZSTkRBN1IxRFZOWEI3K1lqNmQx?=
 =?utf-8?B?V1Fob244czh3QW1jQXh4Z2hGS1RGRkhleG1IT0pVaUtMVGxlWlJLOHhvL1gr?=
 =?utf-8?B?cDZKNGRZWFlITzM0VjNGdXY4T2RjYUYzUG5OZ3RHcjdoWUZXTTFrUWNNWlFQ?=
 =?utf-8?B?ZkJZbGJYZ3ZWODZMbGkzZ2tmTDYyR2pHeGF0SkRPYmNGdjVhNEp4ekhGMHpz?=
 =?utf-8?B?ZW5zMXk5M2FVZVNKNHpINHdybElhOEVzOUhPTnlIZkUyMWM4allKV3lRaUdu?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22748003-dd99-4553-73e0-08dc0c459c76
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:20:29.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEjbP9ZVtYdoQoiYDLR5nu9O6wc3aQFWsFmk1Pucd7etPlyotr4myrgjHGQfPjuf8Oe+39A1XTQwOxNLrPmWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 10:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14244

On 02.01.24 23:09, Prabhakar Mahadev Lad wrote:
> Hi,
> 
>> On 02.01.24 15:14, Chris Paterson wrote:
>>> Hello Jan,
>>>
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Jan Kiszka via lists.cip-project.org
>>>> Sent: Tuesday, January 2, 2024 8:09 AM
>>>>
>>>> On 27.12.23 17:18, Prabhakar Mahadev Lad wrote:
>>>>> Hi,
>>>>>
>>>>>> Hi!
>>>>>>
>>>>>>> Sending this series as an RFC mainly beacuse, as the kernel image
>>>>>>> is not generic to all RISC-V platforms as the HW is noncoherent.
>>>>>>
>>>>>> Does the hardware also have the "low memory does not work in
>>>> userspace" problem? How is that handled?
>>>>>>
>>>>> For the local memory issues (ILM/DLM (Instruction/Data local
>>>>> memory)) we
>>>> will need a similar patch [0] to cip-isar-core. Note the
>>>> cip-isar-core image built with this change [0] can be used on other RISC-V platforms.
>>>>>
>>>>>
>>>> https://githu
>>>> b.com%2Fprabhakarlad%2Fmeta-
>>>> riscv%2Fcommit%2Fda749379155980d1f906d8632432f35a01a9c9a1&data=05
>>>> %7C02%7Cchris.paterson2%40renesas.com%7Ca5d360a701164419501808dc0
>>>> b6a1e2b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6383977975
>>>> 99811411%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>>>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=dY
>>>> DnQGyt5JgcvbN2tCqYh7Ba6Tt8vEKooUjU0qBJ2do%3D&reserved=0
>>>>>
>>>>
>>>> Just to emphasize this (again):
>>>>
>>>> Debian is not Yocto, buildroot or Gentoo, and we are not done by
>>>> patching and rebuilding the toolchain. Unless you can also provide a
>>>> reasonably short list of packages that require rebuilding after that
>>>> patch is applied to binutils, it will not be practically feasible to
>>>> address this hardware design issue via something like isar-cip-core.
>>>
>>> Perhaps we can come up with a small list of packages, at least to get CIP core working.
>>> If this is the case, would CIP want to compile these packages separately as part of isar-cip-core
>> builds?
>>> Or would we (Renesas) need to compile them separately and pull them in during a normal isar-cip-core
>> build?
>>>
>>
>> Depends on the length of the list and size (build-time) of the packages.
>>
>>> I seem to remember you saying that RISC-V cross-compilation for Debian is broken. Do you know if
>> this is still the case?
>>
>> I worked around the issue for now, waiting for review:
>> https://groups.google.com/g/isar-
>> users%2Fc%2F0QBjhzcs3ac&data=05%7C02%7Cprabhakar.mahadev-
>> lad.rj%40bp.renesas.com%7C5eea955a6b3e43edc6f108dc0bb17ec1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%
>> 7C638398104168344805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
>> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3BOCfdyyKWJJtw1KF21pMIaZpuEoZoOSEG4JXKd7oLc%3D&reserved=0
>>
>> Once isar accepted it, isar-cip-core will pick it up quickly.
>>
>>>
>>> So perhaps some options for now, in order:
>>> 1) Add support for RZ/Five to linux-cip and don't test at all
>>> 2) Add support for RZ/Five to linux-cip and rely on Renesas' internal
>>> CI to test (similar to other non-official CIP reference platforms from
>>> Renesas)
>>> 3) Add support for RZ/Five to linux-cip and run limited testing with
>>> Renesas' Poky BSP
>>> 4a) Add support for RZ/Five to linux-cip, Renesas compiles binutils
>>> etc. specifically for RZ/Five, isar-cip-core pulls in the Renesas
>>> packages specifically for RZ/Five, or
>>> 4b) Add support for RZ/Five to linux-cip, patch isar-cip-core to
>>> compile binutils etc. specifically for RZ/Five
>>>
>>> Options 1-3 would mean RZ/Five would _not_ become an official CIP reference platform.
>>> Option 4 _may_ open up the possibility for RZ/Five to become an official reference platform.
>>>
>>> I'd at least like to get 1-2, perhaps 3 working in the short term based on this RFC series, if there
>> are no objections from the CIP maintainers.
>>>
>>>>
>>>> It would be better - not only having Debian but also other distros in
>>>> mind - to look for a kernel/firmware-based workaround, even if ugly
>>>> and potentially slower.
>>>
>>> It probably would be better, however sadly we haven't been able to come up with such a workaround.
>>
>> Is there information missing when an access to the invalid virtual address happens, or is the
>> implementation of a complete instruction emulator not realistic?
>>
> The virtual address here is valid, its just that it doesn't go through the cache/MMU therefore the virtual address matches physical address. (This happens for region 0x30000 - 0x4ffff hence we shifted to the start address to 0x50000 in binutils as pointed previously)

So it's not valid for userspace because it can't be used in reality.

> 
> Can you please elaborate on "implementation of a complete instruction emulator not realistic?"

Given that the MMU is not respected for those magic virtual addresses,
the only way to permit userspace to use them is trap-and-emulate: If
userspace reads/writes from the virtual=physical address, emulate those
accesses. Same when it places code into that region. That's similar to
MMIO access emulation under KVM, rather more like early real mode
emulation in KVM on x86 CPUs that didn't support real mode in VMs. Look
at what linux/arch/x86/kvm/emulate.c has.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


