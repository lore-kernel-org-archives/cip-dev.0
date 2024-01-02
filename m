Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30EAC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 16:40:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.55])
 by mx.groups.io with SMTP id smtpd.web11.33034.1704213611818837002
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 08:40:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VQE16nmR;
 spf=pass (domain: siemens.com, ip: 40.107.247.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjOtUVCzyftk9ob+GiJw0aLnHZxL5ZpH7NCgPTfUwQJyWXhMTnWDdXGEUZT2YRWxGVWLWXGNVXD/yBBQBmoPFUGw5e6fs+GTbrAdcMiK/OOLBxGyjt1k0EYGogrjgliZ3P9ggKCYs4Tv7de5AFxOy3akLz0+BrZzZzEPLOQhiePbOvEJrBgWak0KNpJzzOP1Diqnl8uLxUP93w7dQh5OFW1agcRNLfKZ4VB6GRPvLMmhanN0m+R5vZpsKiiXKg488FOOLKjqGyIyRcPqPXxK3CDTj4QnKKIlWmfRm2TgxH8M92Mwm5RDFoG89LWCPEaeeEeKYlrUvpNSwbOdAmOqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycxLj3S8hi6TIKNfuu3wQAGeauoKtEGbCa1tUhxG8ME=;
 b=C621C42zkMGl+Je80tgjhZNLAly/6T4WinzJl/yDObEDqvr3u/yhl3AuloNb0Lqh2kcklHdxbLye0HKWNbUvii9A7pIpOfTHuNiS9/YbNqvV7fKZXxtRGkaOyzCYF+aKmBZRF7oLcBwb9HKjrguOmCzViELfpzbXJQlOWBAmpamQ/UZzaEIAPnsiYZtBrIHvOUSmOD3LxID5V5ykzZ9QP+61+xociLxuvohbmKGS+ZibTRTgfSTVISwSVJKR+630yhp09vm9U7kmLdZuDTMt91ZSDxcSV8tECcl9M0gxH8s0Kq7iKLfUEST9/CaLu8kVRHzgcJl0n0luNWHdVFhXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycxLj3S8hi6TIKNfuu3wQAGeauoKtEGbCa1tUhxG8ME=;
 b=VQE16nmRF6j+i1GMcqw9mSbTW9fNoLXkW2g0NFDnoJ7lcIHauWN/oRdISnH978w2qPNh8Yi5LMiHeGBFigtaPmzWxBuDStglGYo7rTpFHI2ttpSOZl4cMK+2hFh1seANHwzBaiAPy+NNbIIShahPMlKKXeDcbPRC8di2FLC/j7Mc3oSxxCIjdELdW1L/+lL5Uqv7SpkSl4Jm8kqZijQsMMyJ7wZ4p5UBGAvrRcY8tKauAnwW45uMnDCpyjw1pVaK7i6MjAKheJKdKaXYJm2J6pPpywwXZP8dYwZD4AngqaSgkK2tOrc2nHOp30N0DIGoyxVHKOYpaUc4gbTuQ8i0ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:40:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:40:08 +0000
Message-ID: <6f1c5d79-a5a0-4bac-8df7-5c6d08f98644@siemens.com>
Date: Tue, 2 Jan 2024 17:40:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
 <OSZPR01MB6816A87ADFCB148C8F45958FB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSZPR01MB6816A87ADFCB148C8F45958FB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3750:EE_
X-MS-Office365-Filtering-Correlation-Id: a01550eb-bdf4-4ed4-b24a-08dc0bb17af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	itTANCWPaaw+ULHrhOXPME6gJJn9jHwCRmC++DT65lXwc5+OZ2NQMUooa49B8eqRZ+PH27tIBnjlm4sCFagG17/AdVRBlbkhUW6ah7abVMrSSgJFlZ7bytgo25cQtFry3S1sc+9V8OKlBbn332ByIpXITmE1Xm+Sa0d/VWizq0SuldKRaiA/jHs+QUgTNLwwfZ9ITT1OXCR3DORAGM8uJZNQfeHhnbZRTnz8nD/4EtjQaaUxbR4FLuOh7zDdM0akuTZn0ygIl/3UXOLrh1+XRwbGP/IUiBT75FFvXG3s8nYYaBs+War1pckZmSjTxy7d8JtI5lU1LSwMKhgWsCQhuONbTePv7FyY5sJL+Pdm1USDY++0XcTaTSP44AnGLRGKbnsV8pfKLURIbEtz97Jda9IS1asa53Co7c+2/ce7kc0pmqvnD/coQFDwEHR345wjrmcLPCwP5GVALdkEwaw976k7Pe0eq6cRhlG1X37r+AtnHX5CD3Prl7KoKGlzHbPFcrdrxNjFux8I6w1KQgvgoGW9pamvbC7ZqbFtUtzJOkh9pd1AIIgIwVJfi6W/E12PrNLDjzD90t52nloUZ8SmEO+tuJgMXF16XlaEqqkwHadBtgEjtlz9L3wnO4x03xcuskZad6zM6yuGBRSYybBxAQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(2616005)(82960400001)(83380400001)(38100700002)(66946007)(110136005)(66556008)(36756003)(66476007)(54906003)(316002)(478600001)(6486002)(966005)(31696002)(86362001)(5660300002)(2906002)(31686004)(44832011)(8676002)(8936002)(4326008)(6512007)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wmw5dzZuTk9mek4wRHNwdTFQUmVER2hlL0M0TkJUQkJNQ0ROT01wWEFCdk8y?=
 =?utf-8?B?NzVlUXE0OU5lNUNQTkdEcmxjMy9VUndlKzJWZDNsNi9NUzFpWlBuOSs2OE9M?=
 =?utf-8?B?MVJ6STNSS2ZKWFB0QzJnWHcvM0NFN25BUm1Zc3dGbFlTelFCeUhhcnZIU2xz?=
 =?utf-8?B?SUFTWjZqTk51N3BKSEo4aXNNWSs2MjZkQWcxbmdWQ2dFcW9xdjErclRKYWJL?=
 =?utf-8?B?SXNZWERWWWxhcE80ZG4reVFQTW04alJUeTUvNFlNWkttREZoYWdpSFBnZ1Z4?=
 =?utf-8?B?OXF4dkZ3WTVSOHZwQWJKclR4TTd2TVdua1RiNjFOcENyd3MvN3E2djNTdGhX?=
 =?utf-8?B?SkVWeEhQM3EwN2dpVEtLd3ZJbEhjSCtRY2lGSjU0R0U1SjdnSXRXcnQ2MFVY?=
 =?utf-8?B?d2NQY3drUzFsbGZDK21mK25TR0dONDRvaEV5SnRLOGU5SmxXcjcwaEdlTWty?=
 =?utf-8?B?LzVtUlJUZ1o1cGRJbGVJMlc3eVdDaHJhVFRBRG1jYVRlWGxhOFJYSGdPaFpK?=
 =?utf-8?B?MHpRZWxoQW1ST0tlSk10Q2M4N1VNaTdnZ2RwKy8yK1BPa3l5dHk5cURGdzF5?=
 =?utf-8?B?alQ5SkdxK1RKOGN2dklWVFRwL21KaXBGME5lOWJqUE9iQjRubERCaURHRlVp?=
 =?utf-8?B?OU9WTTVYTDhzaVYvZUxOVTYyQ3kvWjNvWE9aejlBay9XUC94Y056c2dMWDI4?=
 =?utf-8?B?dk1va1graHZ3akNSeDlJcllMUVBCejVpQlEvU2txN2M5UWluQm1UMkhtOXMx?=
 =?utf-8?B?d1FKTS8wOWg3enl4dGtQcCs2VzVxTzBoTFFNYkRsRmd2eEw3RVNJclU3U213?=
 =?utf-8?B?Vlh4dVV4N0dCK2JRSjlrdCt1ZG9RWEJKazg3aUc3NW9GQkFWQjVOUkR2Zmpj?=
 =?utf-8?B?Yk9kd3NtMUhBNm9hbjVvVXdQbUY3UGt0WTVybC9tdExNbGhSMmN1cUNzL0wy?=
 =?utf-8?B?OVRKNWhNQW1SaGtWN3V6TVJwZThCenlNenl6WHRZNFJZMXppRExkdkZyVEZR?=
 =?utf-8?B?WUh0YXhYL3hCUkF5dzBnREEvd0pJOHB1TWN2Q0V0eUFZcldPdElaV1BjWUpj?=
 =?utf-8?B?Rzh1THZaZ2t3SWYrNkJUdDBWSlZ2MSt1YU9XUmF2bGVGRHpUelNhRjBXTlZJ?=
 =?utf-8?B?ZzJZTW1iNlF3N2RRd05HekljQSt6Q1RqNWtDVUtLR1RGT1ovUFo0TnJ4N2dp?=
 =?utf-8?B?QytrMjNOMEdONzk1Vlk0LytMcVFFeEI5bGxpOEhTSDM0WmNXaytPaU1TblRx?=
 =?utf-8?B?U0kyeU9Ia091bU5xR2NCU1cvLzFwYVAwSFBOcE1CbUJwdzB4eWxJRExnQ0Ri?=
 =?utf-8?B?dzNHOC9QZURDK2JTazUvY25TNVl2SHVDd0JFakFjTG5lT1VEMnF5b25HWm5j?=
 =?utf-8?B?dTNPMk5rYUg5ZlFZc3VqdStJZFdWUHdUYW55cGZIemN5ZWFrTlAyN1lWOEU1?=
 =?utf-8?B?QWViSlNON0YvYk9kZkUxQXMyeDlFc0pEWU5QWHdLT0tBandOeEw0S2xKYm1a?=
 =?utf-8?B?bCt3U1ZzTzlzV0xFQlFmVlJnRTYrTXFDMlN1RDNzRDMraW4wTXJYaGdGeUE3?=
 =?utf-8?B?YnM4UjFsSDlWcDJjbW05cWhIT3JFRzVPbExURHJQRmJuOGRvQjErVnZGYXJY?=
 =?utf-8?B?QlJEY0IwSitSMGNSZkRvY1N3b1U5Z0FETnZzY005bGxLNmFHS1JrT2JGRXRM?=
 =?utf-8?B?R2V6TlR1Sk5McWlIK2t0NFdjcXJPbVV2S29TZnUvRVVwb1ZGZG9RYzdZWVRn?=
 =?utf-8?B?MzduTmM4SzlEbFZid2Mwb1FHVno1S3pXZXk5dmc0ZkZmQkhXeG45dzREKzk0?=
 =?utf-8?B?VmVaYW5LalN4bGFWKzFycmlGcU00SEYvTm1scmo3WVFTdFBOLzVwT0Z3c1VP?=
 =?utf-8?B?dEgyVUFVMWJRV3ZOY2lpWTkyQkpzcGdISnVXS3B6MkM5Y0I2TGdzRzJTVkJl?=
 =?utf-8?B?bWhpaTVhTm1wVVhPblRpUVZMTEprdVZmY1FVR2k2NytZakU2MUw4cTI3QzFP?=
 =?utf-8?B?YmhCOHZOTmxYdXc4blR4Y0VkMmJyblhZVW5iTDQyKzUrdTNWcUZiSmZNZ2RO?=
 =?utf-8?B?ckdDUHVpWVNNWFVaVXI5QkU0VmI2OFVrU3pkdkdqT0VFakxXOWVncXJneElZ?=
 =?utf-8?B?Ui9CNjBkenRJUWRTUkZNMXJveWFQMHk1TTIxMEJxdmZDbWdPcTF5UUtCNFJl?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01550eb-bdf4-4ed4-b24a-08dc0bb17af3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:40:08.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohU2g0/sVYkVyt99cQVLM8sp/aExNFKdVN913tjiKs18UB87hElkx5E+RSh6feDaQXSUSWBrM3PbbIyQvEpoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 16:40:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14232

On 02.01.24 15:14, Chris Paterson wrote:
> Hello Jan,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Tuesday, January 2, 2024 8:09 AM
>>
>> On 27.12.23 17:18, Prabhakar Mahadev Lad wrote:
>>> Hi,
>>>
>>>> Hi!
>>>>
>>>>> Sending this series as an RFC mainly beacuse, as the kernel image is
>>>>> not generic to all RISC-V platforms as the HW is noncoherent.
>>>>
>>>> Does the hardware also have the "low memory does not work in
>> userspace" problem? How is that handled?
>>>>
>>> For the local memory issues (ILM/DLM (Instruction/Data local memory)) we
>> will need a similar patch [0] to cip-isar-core. Note the cip-isar-core image built
>> with this change [0] can be used on other RISC-V platforms.
>>>
>>>
>> https://githu
>> b.com%2Fprabhakarlad%2Fmeta-
>> riscv%2Fcommit%2Fda749379155980d1f906d8632432f35a01a9c9a1&data=05
>> %7C02%7Cchris.paterson2%40renesas.com%7Ca5d360a701164419501808dc0
>> b6a1e2b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6383977975
>> 99811411%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=dY
>> DnQGyt5JgcvbN2tCqYh7Ba6Tt8vEKooUjU0qBJ2do%3D&reserved=0
>>>
>>
>> Just to emphasize this (again):
>>
>> Debian is not Yocto, buildroot or Gentoo, and we are not done by
>> patching and rebuilding the toolchain. Unless you can also provide a
>> reasonably short list of packages that require rebuilding after that
>> patch is applied to binutils, it will not be practically feasible to
>> address this hardware design issue via something like isar-cip-core.
> 
> Perhaps we can come up with a small list of packages, at least to get CIP core working.
> If this is the case, would CIP want to compile these packages separately as part of isar-cip-core builds?
> Or would we (Renesas) need to compile them separately and pull them in during a normal isar-cip-core build?
> 

Depends on the length of the list and size (build-time) of the packages.

> I seem to remember you saying that RISC-V cross-compilation for Debian is broken. Do you know if this is still the case? 

I worked around the issue for now, waiting for review:
https://groups.google.com/g/isar-users/c/0QBjhzcs3ac

Once isar accepted it, isar-cip-core will pick it up quickly.

> 
> So perhaps some options for now, in order:
> 1) Add support for RZ/Five to linux-cip and don't test at all 
> 2) Add support for RZ/Five to linux-cip and rely on Renesas' internal CI to test (similar to other non-official CIP reference platforms from Renesas)
> 3) Add support for RZ/Five to linux-cip and run limited testing with Renesas' Poky BSP
> 4a) Add support for RZ/Five to linux-cip, Renesas compiles binutils etc. specifically for RZ/Five, isar-cip-core pulls in the Renesas packages specifically for RZ/Five, or
> 4b) Add support for RZ/Five to linux-cip, patch isar-cip-core to compile binutils etc. specifically for RZ/Five
> 
> Options 1-3 would mean RZ/Five would _not_ become an official CIP reference platform.
> Option 4 _may_ open up the possibility for RZ/Five to become an official reference platform.
> 
> I'd at least like to get 1-2, perhaps 3 working in the short term based on this RFC series, if there are no objections from the CIP maintainers.
> 
>>
>> It would be better - not only having Debian but also other distros in
>> mind - to look for a kernel/firmware-based workaround, even if ugly and
>> potentially slower.
> 
> It probably would be better, however sadly we haven't been able to come up with such a workaround.

Is there information missing when an access to the invalid virtual
address happens, or is the implementation of a complete instruction
emulator not realistic?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


