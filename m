Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A94C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 07:23:40 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.82])
 by mx.groups.io with SMTP id smtpd.web10.10292.1670657013700819694
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 23:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gY7FlVkd;
 spf=pass (domain: siemens.com, ip: 40.107.7.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFaOKY68wtM34FKIm42CrqHC8vCCEhopDLN43VhxVMpZY4KEPpdv/l5NE+2DqWsZXilSSTvIWWmugK+tVWgr4CCYZCV35AqZhfGy3BPcOmol+2umJFL92Kx3rIODc097X0RaOtbB0H2bPtw05ngT4kgtXKN4m2e+aVvvOyTigkBusrrl+rZs+sLsqxhEpshq24y+OYZdaw4IGfNjaCRemq7X5OrpNs7DtxnvPL+I2WJa02aog42bkIZi8F3qliJ6WbpXqBEluB+IhXiL2Gtt28rFxfq03lGoeNF3ZO3RegvSnxUn7d+HHSJD/lAAeaCSfLPW5qHp7RmT49YOZhuX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNdEQYK1G25HG9DH5XjtefhJCYiP/rHod9KYg+bYty0=;
 b=nwrKIMUVr4/LC86RtNcMv6uRGqIjblrDn4CMDFXvr9Qwy8uKO7tUBf0DDP5JQQ+jajjVSG4aBY8pMaMJA93FV21KrA1a/hdxm3IkVBY5fx1rSZ87qBalR7Eag0Nr/cT+agJ4OgAaOomU9eJGdvzEVk4TQnjR0Q2QXPJH1umVKYj64P18jFv3Im6JgT5SOyNmj59GHVYzqGIBP/xLGgJfkyHI1P05weYPmkw+gUV57zv5pAZ9p6c1DnTHqYUkUtBh2/PAFnokV31sVH+37RidDzxSxcfRtySlQArJV8IoiS0buyPLfqiJOS+uEveBX2z5JNg75HhG7ih4lOzjl2WyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNdEQYK1G25HG9DH5XjtefhJCYiP/rHod9KYg+bYty0=;
 b=gY7FlVkdS+qIPTWpoIKoFW8akdGhxHoCKmlkW4WASGo5jyZ43TWsifqCGJ+0pFxBR6SU3rjFfL7vin/qoe4f4t5vavmRMtdZIhu2ThF/h/bt3vx4XS7ijZfyjHTb02j0duB1AxEXUIBjp9XutDG1ZGYRLFiHV7BIlwwJPAHWkRgzb7kOxeFnbRnVHv1nj4O9ojBWCe+tgLccj4jjacVTmHvdHf++ubkH2PN/4tsnKh1Y/FzWg821M4ExhZY/9yGGbA31HI25jXtiBPLnsbDk5cmZpOK8pZ0vSxjx/sOaauuu+3TNLisY4npBzCsprNmLwRx98lIq44LtSlomNoHsbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 07:23:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 07:23:29 +0000
Message-ID: <b38ebaa1-bb3f-f2d8-b200-0cdd18cf07cd@siemens.com>
Date: Sat, 10 Dec 2022 08:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Content-Language: en-US
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Hung Tran <hung.tran.jy@renesas.com>
References: <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <1263180941.78238.1665650193479@webmail.strato.com>
 <20221013214737.GC14791@duo.ucw.cz>
 <OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4598a3a6-709d-49b6-8127-08dada7f6ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4u0RKkW/WtRmH87D45C9XsTflj2GHGpIIIpzY0Mwf3l7+awfZB0nd4WOMbH0gSFVHTfWkYYX49BocfksnvESBT4VcSlYakWL4tEy1MBUKfq48HriB+Zqm7MLWJJfyZaKCZ+yKJ4A8+PaV12P/q/Mon/0RWWgemD+Kz7S0FPAN7ZnxPyk1itiJXzBRLzfOvthlxhg3F9nLYgHsV9LTeeU/ha68aabAvhuYlAVjx8ZJgBXyGc+9yv+4BzvFsvqUr7+yvJMgvlaU5vHGStqJ+QCcFgsYuf+ivmGd5d8pP8+Yve5qtnAadgqwR/TMzIHTY37EzsHLLefl8avwtC3X4WHTw006L2fjb2bR5KY8j2vLj0GgK8aGCDg3P0SmrhZ/GbA7dSkWBRhUbjYZldvwd7P7RLDW680r8NmNmfQTWjMQWjkIVgv0oTcPLNGOS6Z0jY2oMjHawwopfFlLRFDPHBPHReoUq219zhWg5P2QGXmPmQl2sLKwcAW5qCLGzWDULTDykIj+Uni+dxWHKPB1sbVDgK5vpP2hPFSGxOyPZL7NSzYkz/TzW64EL8YRpJnvotTbTLwnSTHWbPgGOv3oeQFkr9GtdA1pqvlB+4VrHo3nelLtn05Sz8tSq824s7u8e1CL+YFzhoR6of/EPh4Ry4HNxJtGf2Sf1a21bxZrVBuhbl0ABkqrBlY9wwxSDabQWHs++BarXURNYAA9YKBySpC2slGjRSFZ2JFlAMe6HTfG/5BKxt0ytB4eZwU6rKrypmS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(41300700001)(83380400001)(54906003)(66556008)(66946007)(66476007)(8676002)(4326008)(316002)(2906002)(31696002)(86362001)(44832011)(8936002)(36756003)(38100700002)(82960400001)(5660300002)(31686004)(6666004)(6506007)(53546011)(966005)(6486002)(478600001)(2616005)(110136005)(26005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnU2aHBoRTl1OWU0R1E2b0xFNVpzempxQnpLb1VBN1ZnRDkyWTZWa0NYWm56?=
 =?utf-8?B?WkpXWENjbHFUZHhuNjZlNjMvaFl3N0l2cEg1N0MxY08vbmhFYlNwOWRBd2M5?=
 =?utf-8?B?N25sN0VBRFJhYllFV2ZOeUJVWVpjSTl2UkE1Wnp1K2FsZ3dxQis2dERycTRu?=
 =?utf-8?B?Y29JRklzU005QkhZV29iNWVHQzlHMXhzM0xNbGZWU2FlTVcxUWpvSkZIRTJV?=
 =?utf-8?B?bmJocExITkVveC9NMHh3TURpcEg2bWFaa3VxajRzYkhwRXpxZTl0aXVIeVZw?=
 =?utf-8?B?cUZMZVV3dUhVeWtqYmhudDZIYitYdmRoZUpJL042VmVBKzVnaXVHQ05KZ0ZC?=
 =?utf-8?B?QkF1QnVxYk9zOUpMdXVGUi82NEpaQVRLL3V2ZHVZL3A5ZjVEWkxXVkN5MWpU?=
 =?utf-8?B?YTJRcFJSTFlCaVo4KzRCRmswM1JKOE51RHZad0lwT0VaZVF4UC9CbDd6WUhT?=
 =?utf-8?B?emJiTVlhSlYxQVJEcVpkY21abU1MRmhsaW1NRDdNNzByeTNpbk1yY1c0eHB0?=
 =?utf-8?B?c3ptMDFHeFdQczFncnJsdGpwTlJQU3JRUzMzMnd6ZFBoUHN4ZS9Na2lWWmpX?=
 =?utf-8?B?WWk5QXREYmFzVjRKZDJwSHNHeGpLQ29wbjlyYnFrSmJXMGZlVzZ1SzFHRlJr?=
 =?utf-8?B?cUJZM1VUbXBCa21LK2trc0VIRS9IcE9oVFFVTTVzQWR6Rjl2TjMvbjFDakJB?=
 =?utf-8?B?WjR1MDVXVmsxK2FXK29pb3FzR1F3Zyt2V3QwRExaSUhKRDNab2hHdzBmODlN?=
 =?utf-8?B?UlgxSkQwNWo0NTV5UnY2RmxkcEdnVVd2enZMNWY5Ujc1a3RLR2pIVUNFK2dW?=
 =?utf-8?B?RHhuVksrRElPSS9CajJoWWZRREVuYmZ1OS9lK1M5eHdoWDRhUWxLeWx3dUNw?=
 =?utf-8?B?Qm45MmV4SkdObHhZYjVyczNRRkdteElOblFzQjlYMGRKTy9tVVNOZUV5SzJ5?=
 =?utf-8?B?K200c29KZ0FPc1NNR0VlVkRZT0xqUHMyUUpCbG44aHQ1ZWVFZ3c0eVQzZ3BY?=
 =?utf-8?B?bTgxN0dEYjIyYkNUZmpPcVMxa1ZvS3Y3dmgrc3hVTjlJWi9haFRINWZhZW1S?=
 =?utf-8?B?VU5OK0Nxd1NDMFFWd2k3ei84ekd1bnhyZ0tOeXBjckRzU1RVWUhZNERpaElF?=
 =?utf-8?B?enVkR2J4R1hJbnhJdUV0QStqc0VPcENOZ0dJZVdnQ0tKY2FwOFNhcFFvVTRy?=
 =?utf-8?B?alZxU0N1bHplYjIzQUczZ1VGTFh2VHRGVmdMNkJJaFEyVk1CQ24rT3VXLzds?=
 =?utf-8?B?TUk4ZnRxeHhTK2wwUGFxbC91ZW5ja1hnWkE1SWhtS1RSKzBMR0R2S2tiRTR5?=
 =?utf-8?B?YlBVemdvVnpJRG1ENWdjdkxqcVM3UVdjT25FMG5GVW1qeEI5Mm5hMFFmU3Fu?=
 =?utf-8?B?SnNJa2UyeVFXUktaMWt6a1pwKzlUSFNNRzVaQVNkSDdsQ1BKZFd2VUJrRWZs?=
 =?utf-8?B?MHdyNGFJdXRoaGd1Y1ZPbWxqOG9DcWtDeTlqcmlhWTh0d1g3N2MrSjNhdG15?=
 =?utf-8?B?YjBodE5nbkVZOTJ0TUpPcnI1U01aU3JuVmdPUzdnazkrai9JbE1mbHZXTVpn?=
 =?utf-8?B?ei9LamtHZjFqejQxeTBhWUt4eDU5WDQ4VTEydzMvWW4rS2NIRDJ0VkxJdTlj?=
 =?utf-8?B?RnN5eE5kS0sybVJ4SmVqcURIYkl3RVU1VFQyZ29aR1VMbExNOSszQ1lvejF2?=
 =?utf-8?B?OTdjUmNJN2x1OC95M1RHUVhjK0VndU41YytodlVQei9RWUhVY3Y2Y2U2SG50?=
 =?utf-8?B?bWtrbkZxUlNWZzN4WSsvL1QxVVZJMkQydEZuMjFaTCszT2dtRlFDK3dQZUFI?=
 =?utf-8?B?OEo5VXMrRjR3L0tpVzhObnJicDRudnI0OUgycXVreFpSZncxTW1WV3BhcFlk?=
 =?utf-8?B?eVhDdW9QTDkrdkhMQ1hiNklkby9SalFGRjlVUVB5S3lWQkJwQWFZa0lSREtm?=
 =?utf-8?B?WWFTakgwbit6VVoySE5vQk00T3pzQlR1SmlQNVNtYk1kOWdpUElVaHprYUJm?=
 =?utf-8?B?dndUZThqRnJCZ0xDdCt4VUZSdnhwSHhqVnNzbWsrNm16UGZIODRtOUtLOU02?=
 =?utf-8?B?d2d6ZDBHU2F1S0hFQnVka05BZTRqSjQva3NhZWQ4cnl5Rk5qMkNFQjI1UVdJ?=
 =?utf-8?B?NWRMNUt0bCtmbzR3WWRyZWoxQ1RPbTJRb0NjS3hJY3hRU2RaVFdRUklvd0Vl?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598a3a6-709d-49b6-8127-08dada7f6ecc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 07:23:29.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwS9BCfAeWUFIvnzVs58HhaVYwdsKtxHIrNYCbT4sUhPDGNYqv7oOWHOgUbJeUKMDFLeBf0FBlPz2y3HvQm0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3138
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 07:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10194

On 29.11.22 19:57, Prabhakar Mahadev Lad wrote:
> Hi All,
> 
>> -----Original Message-----
>> From: Pavel Machek <pavel@denx.de>
>> Sent: 13 October 2022 22:48
>> To: Ulrich Hecht <uli@fpond.eu>
>> Cc: cip-dev@lists.cip-project.org; Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
>> Jan Kiszka <jan.kiszka@siemens.com>; Florian Bezdeka <florian.bezdeka@siemens.com>; Chris Paterson
>> <Chris.Paterson2@renesas.com>; Hung Tran <hung.tran.jy@renesas.com>; Pavel Machek <pavel@denx.de>
>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing isar-cip-core for RZ/Five
>>
>> Hi!
>>
>>>> On 10/12/2022 11:50 AM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>>>> I did a quick test with the patches pointed by Florian but unfortunately ldconfig still fails.
>>>
>>> I did some experiments on RZ/Five with this issue, and I'm almost positive that there is something
>> wrong (or doesn't work as documented) with the icache handling on this SoC.
>>>
>>> 1. The issue only affects non-PIE executables (there are very few of those, basically just ldconfig,
>> gcc, cpp and gcov* on the Debian system), and it occurs very early during the execution of the
>> program. According to the datasheet, the cache on the ax45mp-1c core is virtually indexed, so it is
>> unlikely that a PIE executable will ever hit anything in the cache when newly loaded, but it is much
>> more likely with non-PIE executables.
>>>
>>
>> This is very good observation. Thanks!
>>
>> And indeed it looks like _any_ non-PIE executable fails. See:
>>
> 
> Just a brief about the issue and solution:
> 
> TEXT_START_ADDR is the start of text segment of an application. This is being set to 0x10000 for RISCV platforms.
> 
> So when an application is compiled with the static flag the load would start from 0x10000 - xyz (depending on size of the application)
> 
> Entry point 0x101c0
> There are 5 program headers, starting at offset 64Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000000000 0x0000000000010000 0x0000000000010000
>                  0x0000000000059b48 0x0000000000059b48  R E    0x1000
>   LOAD           0x0000000000059b60 0x000000000006ab60 0x000000000006ab60
>                  0x0000000000001f68 0x0000000000003528  RW     0x1000
> So for the above application which is compiled statically we can see the entry point is 0x101c0 and load 0x0000000000010000.
> 
> Andes cores have local memories ILM and DLM that are mapped in the region H'0_0003_0000 - H'0_0004_FFFF on the RZ/Five SoC. When the virtual address falls in this range the MMU doesnt trigger a page fault and assume the virtual address as physical address and hence the application fails to run (panics somewhere).
> 
> So to avoid this issue we set the TEXT_START_ADDR to 0x50000 so that virtual address of any statically compiled application doesnt fall in the range of H'0_0003_0000 - H'0_0004_FFFF.
> 
> Elf file type is EXEC (Executable file)
> Entry point 0x504e4
> There are 5 program headers, starting at offset 64
> 
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000000000 0x0000000000050000 0x0000000000050000
>                  0x0000000000057dc8 0x0000000000057dc8  R E    0x1000
>   LOAD           0x00000000000585b8 0x00000000000a95b8 0x00000000000a95b8
>                  0x0000000000004ee0 0x00000000000064b0  RW     0x1000
>   NOTE           0x0000000000000158 0x0000000000050158 0x0000000000050158
>                  0x0000000000000044 0x0000000000000044  R      0x4
> 
> So now with the fix for statically compiled application we can see its offsetted and entry point is 0x504e4 and load is at 0x0000000000050000. So with this we are for sure the MMU will always trigger a page fault.
> 
> I have attached a patch for binutils to the email. We plan to upstream this patch to binutils soon. 
> 

Good that the issue is understood and likely solved now. Make sure to
upstream this as quickly as possible. It targets a fundamental tool and
requires recompilation of many components. And Debian will freeze the
toolchain in early January - although:

"It is unlikely that the release arch of bookworm will include riscv64."
[1] :(

Jan

[1] https://lists.debian.org/debian-riscv/2022/12/msg00009.html

-- 
Siemens AG, Technology
Competence Center Embedded Linux


