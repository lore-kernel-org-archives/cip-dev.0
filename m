Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E1C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 08:46:55 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.40])
 by mx.groups.io with SMTP id smtpd.web10.19044.1677833213820138666
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 00:46:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ARImKOXN;
 spf=pass (domain: siemens.com, ip: 40.107.14.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwlbzTE4T3YdWSsQd1eXWIBvT9TvlzWyEVeQCBC0LAhOHuj1lRWoNidXLihRg4Iq5K5UBeIiwx+VrXkzdFa/OrK+vSB6nxkS/lL2C8H+8o8ndAtIEzGWpNtk4Y/KIqsHh4pGchIxLncR4zH+RvGzGnJc2AoRUgrchf1uJUCn6HWeCognSLU/tySQszG9siesWtqS1JyNnkakwBbd5Mmcxg3a5IJ/xYV8c2COJT+dovRk1oldJgESM/lr1Idmap1Tli7GC4PtvKgLUTREeJ44Vm8VglLTWmy6gtF3G9ihOXFh96f9tcLc0UQF3fgxKI/E2XhrNYqsHdZ6w+idx1mEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GEgq6P61tVSGWfasar+Uyu+cZEEXOynUhpFNQAA1gM=;
 b=Egzj+8bj/qbUapHdJFMibqz65fgRWzRgb8KTBOT5qlLUVUctOz6IngyegQXpeHNx3KnrYUzXzOcffirreDwnYu8az1uHwFrG5E5msxOa1k8VaFce6vVWhYIMWet3DWALrOQnuv8G4JKBZKUp+7qGi0Zhc/LFGDOxoiMpdQHq/J1VOreJv8adunAIovfSQTcNYJkGqUgek7VMgNnePNjT0gAZMw1rEDgMyeNct/n8pYPf/09plQkF2A+/LemCW47hBsWM0lstkCmlyXq/ZdrYVTrgapgIICdK78AqH1+qA4Fu1MH8Dp4vXlwO3dPM8BHLwdmdKiMvMMOpWcmKQ72XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GEgq6P61tVSGWfasar+Uyu+cZEEXOynUhpFNQAA1gM=;
 b=ARImKOXNBJHUXX3JZz8MqhE+8TRf2F5iA7OFkCEXarJIlJtL4n5jB8HCyuD+1DiWPXWTRxBuG4Uumm2UbKHLT7SAFMOY1HMkDYBrjx9oWOnQYNGZp1uD8yv8zrN4ktLEzKEcvkRfaS10C9hk+CgiZ2Rh3h7QKHka8IiM16UTJOuf2sMe8ZeT7Bco24Tq2DfrPjuDvVxP2tPn0THoE93DQjjfbp4eSwE2GS1Psg5kl7cEZm5hjTkt0OkaK54iAvUtXoY683upoh6WybuHq/zyf640zDBxERdyOuKxmyqd8XDSFRNod34zP0vhec80picgc4Wduiv/FL29RqemeGcA1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Fri, 3 Mar
 2023 08:46:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 08:46:50 +0000
Message-ID: <1fa52523-4d52-dae0-5a5a-9ca2afca5047@siemens.com>
Date: Fri, 3 Mar 2023 09:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 7/9] add linux 6.1 mainline kernel
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-8-felix.moessbauer@siemens.com>
 <d75f99a2-c08a-c309-e2f9-b013c2a25af2@siemens.com>
 <c75becc16061aad113a342b0597a82720a60a9bc.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <c75becc16061aad113a342b0597a82720a60a9bc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: fc423d7e-38cf-47a3-5dc8-08db1bc3d49f
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ggpMyGEOjgt12fIvwOVCznNzt7aLAj1Nf+mIRzn7v5OZUmYIey4cY7zwTOTHIbscemiTvPDBIkz0J4xrwhiao+lTkK/rEyQzIuX3Lf3Oi+bZx+DjNB+NgdPZNqC1c1hoKrXhKVywSzB3TJW0ckFo7tkGRzAym7xJDE+NFXdfy98rwM6xmkKuC6KspPWLyruvvAQ5Sf7NtXzHXaQ49qzKo6ezkpUirD8bWIl/OfWvNElkziM5Zkde9jS2Hxzvos1QElLtfTi3x6Y62Ghk2dZHIkR166+UsdxzelTWxSDx//0mtNbjXJzzD49vZEG/CKEK759KVPdA53IaGJK+orgt6HkkFmxh5ON8ZRbL0PjNgOjfWW0wI1WuHR5bJNGG0S6lzIX6RdMVJvMjeo9HxOJu9qe7XYtniZnRFI4Avvf5d3U9huLfeUF0NrXEEuAuhClqFQGsfnfNlEhRwa3PK55V1G2CaqqiG/rSWKHI6fD1uTH7pgAQ4Ldd8qeMX701aSpiwBfUrUm146L4+dUiqeExqRYh2YLDlh3vH3KiSWRJN+ARQyK/SpkGTx9HSUj/cKidpt95QbXvgMpIop2NTTTBtS7429K4eE7jxHaMaj0UtbYezZsJ3/W+nj/pLYLPU8kWGAVlDWnuzyRsC67rIsFZ5OdyxQ0KK805FJpLooJFEKcDd9C/u+87B5RwsGX3BDZDOoYwVgv/hSFAp2StsQUNGeC5ysLVyx+/UFuyM5YM9LM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(31686004)(83380400001)(66899018)(107886003)(6666004)(36756003)(86362001)(38100700002)(82960400001)(478600001)(8936002)(5660300002)(31696002)(66946007)(2616005)(26005)(186003)(53546011)(6506007)(6486002)(6512007)(2906002)(44832011)(66476007)(66556008)(8676002)(4326008)(316002)(110136005)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHVXdkJKMVpaUlAxYVdQVDlEbFI4RTI5TG1GaEZSWTBxczNKRVJpWXJ2d1lq?=
 =?utf-8?B?aWJzdUdXTWpxNjVleEI3L3ZabmVCOEs3dVcyRUN1dEgwamxodndNdWI0V01n?=
 =?utf-8?B?bWtzY1FrUnhrcDZERHNUUndtRjc0eFVCazlpVGRiRStMRVVFK1ZNeXRtaWRm?=
 =?utf-8?B?WVZuYktsK0dPL1lySDZLVWREWWhwazhhRDJQYlBPbkRRMXlHYUFUWEdqekVD?=
 =?utf-8?B?UG0vbUZLQktxM05sUVNwZ0t3WGtEOVZ2UUk5SCtnN2UzOFBKY3dnWmFkcDU2?=
 =?utf-8?B?UzVYRHVMWTlwZVNwNHF0Ry9xZlVDTzNiL1FTU0pESFdlczZ2cG5GTFl1WDlT?=
 =?utf-8?B?ZGdndlFZcXVla2NrSWNHVnVpUlh5TE5HZUhXZm1ZSzVBK2NDQXRVMlptZ1pn?=
 =?utf-8?B?eGRMS2I1T1o0ZnE2d2E4QjVGM3k5Vm9jOU1LczNLaFpYMTN5K3Jnc3NTUzFj?=
 =?utf-8?B?WXBxcXZYTWhReEVJd1FYa1lBaTQxUFdRUkR2ak5xelorVXcyMFkvSFgxcU9a?=
 =?utf-8?B?eGhLYzRxdFBISzZ5cVVVZll2dzB5c1ZqRnJWWnNxdEdlWm90d3JRZ2NrNlhx?=
 =?utf-8?B?TW1wbHVMRWtadytEVXNaempuRWU3RE9GQW16VUxuV3VzZXZIKzFxL090TStm?=
 =?utf-8?B?a01ZSlZoditWWjlVUGw5cGZ6SVhaNXJKdXlyQ3FWWVJBSWs5ZkpFNWE0TlJD?=
 =?utf-8?B?M0t1OFN2UkkrYTFhT2NHOTVhUEVCYlQxaW80WFlJZUl2a0N5bVM2bXBJazg1?=
 =?utf-8?B?M3BQTUY2U2xiM1UzRitURW8xOGhSWFJQRXlCdzgzQ291ZXhuTXJwOWNiV2I5?=
 =?utf-8?B?TW85UXU0dWVSRWFjZ2RvVEFlbEVMNjFkSGthayt6T01Bd29BY2xHVkRCQWVC?=
 =?utf-8?B?ckNGMlNibGtybjVKUlJjRFh2cmYwRTU0SklwOU82OWlQK2xaNmdJcHp6c0NC?=
 =?utf-8?B?OTRha0pkUkRFOHdhTENuRmNSTk5mMzFnckFXZHVSZFFzMEkrY3lHZ0dneGxl?=
 =?utf-8?B?enB0RFBCNlVWMTdFRTBTaEExeWU3QXlUZ2VPd1JtQU9kYW5RQitZVllnNHRW?=
 =?utf-8?B?QXdUVFJOSDhRSHdYUmlyTUs1WHY1dkpDR3FDWG9CdHhRNHBQWG1yTUhJdGFS?=
 =?utf-8?B?Vm9zQWRLcEtaUWdMaHd3aklGeHlidGlBUkhEc1VFQ0FOeFZYYVlZNURMOTBt?=
 =?utf-8?B?cDFocWU2RVNTOVFJSTE2QllCc2RQc08zbk05ZG12RS9HQTBUM0VJR25nTWZZ?=
 =?utf-8?B?Wkhqd00zektiOHpDMnRQeldEVGVlV2tyaENMYjE3L3dZS2pqbXBSazJmbmNo?=
 =?utf-8?B?R0t6Y0xOa3RidDN1UXJQMUh3V21RWW9jUkMzWjQ0RStISmxDd0pCcmpFa2Nk?=
 =?utf-8?B?Y1ZNcnhIdTdURmFlajhmRWhaeGFjbmtuVkR1Z3JBUEJRbnR2VTQxcjFmdHp3?=
 =?utf-8?B?OFhwaHlJUExkd0IwekNTOCt6N1BkOUZKejdvb0lWQ25ZWU96S3U0dTJSeDlk?=
 =?utf-8?B?bEVYcHVMTmlVa05sMUFVT3N0N056WFhaMDdzWHNEN01NUFdOZFBrMm1RbnlI?=
 =?utf-8?B?Y2lnZ0V2YWlGRTlzZThXRVdqZlVEbjJjODFuWGZ0VHBmUlcwMHhlcEVOZG1y?=
 =?utf-8?B?K1ZqWWZkYUJYUUVqZVdCcW1wS3lxOFdLZWw4Q3BvN1lLRlY2Slpac01lVnV6?=
 =?utf-8?B?WExKdGppYUwramxZN0xGTXNNUzY3MVB0VHlzOWQ4eklpTm5oSjI0Q1MzNWJq?=
 =?utf-8?B?NlNMTDRsYnhUalZIVnNKcVRjYlo2VU5qSUgvbW9MNVR0ck9jbnhmTGVENzU0?=
 =?utf-8?B?VEF1b3kybWJ1YlplY2ZYdEkzeWJSQTQxUkppVW9QZ29vUmRvdWMzMk9YT0pt?=
 =?utf-8?B?L1c3b2h5STUrUzMvWG0vQjNqM2szVjBqWU1LVGZPelJzV0orVHQ2UytsS04v?=
 =?utf-8?B?eGMwZGFmM2xsMkZadFc0QjdXNHRwS0NlZ2ZqTkdFOXgvZmN4TzlGNnFnSTNl?=
 =?utf-8?B?bk9oR2Zod05VaC94Z1locDRXeFNSbS9yV1FkRnFGeEppMHhhMUFzNEtVaXNE?=
 =?utf-8?B?VndFWG9pQi9xaVI1dHROZ2FNNjViWG1MS3k5VHhXYjdPNitJSHVoc2VMRlFI?=
 =?utf-8?B?Qmo1TjdNUUZPb0FrcXZDb2Y1Nm1CNmU4UjBNYUdzd1BMUmEzVk1JK3BSb1M5?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc423d7e-38cf-47a3-5dc8-08db1bc3d49f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:46:50.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O77fRXh2TE9uzuptTtf/WXq/3TxcS705JOtS/f8D47dEFjafHKUHzh2RRYhE3QL6nVZ7ZUp0Tlol8jtGG+rIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7645
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 08:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10897

On 03.03.23 09:40, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-03-03 at 08:19 +0100, Jan Kiszka wrote:
>> On 02.03.23 16:26, Felix Moessbauer wrote:
>>> This patch adds the vanilla 6.1 linux kernel for testing and for
>>> boards
>>> which need a more recent kernel than what CIP can offer.
>>> The kernel can be selected from the menu, similar to the other
>>> kernels.
>>> As defconfig, we always use the kernels internal configuration,
>>> because
>>> there is no cip-kernel-config for that version yet. In addition,
>>> the
>>> squashfs knob is selected to support the swupdate pattern without
>>> any
>>> modifications.
>>
>> We just decided in CIP to start 6.1-cip development, so we could also
>> start filling cip-kernel-config with related 6.1 entries, already
>> including additional knobs we need. Actually, I suspect you could add
>> squashfs to the 5.10 riscv defconfig and use that for now, avoiding
>> the
>> snippet here.
> 
> I could, but I don't like to mix up versions here: Having a 6.1 kernel
> with a defconfig that is written for 5.10 feels somehow strange. That's
> why I decided to start with the plain defconfig from the kernel and
> just add what was missing.
> 
> As this squashfs=m default bit us now for many times (e.g. required
> distro kernels), I'm thinking about simply always adding the initramfs
> hook. In case squashfs is already enabled, a modprobe does not hurt
> anyways.

Makes sense.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


