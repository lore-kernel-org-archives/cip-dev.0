Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFABC4332F
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 07:11:01 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.41])
 by mx.groups.io with SMTP id smtpd.web11.10067.1668669058129575165
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Nov 2022 23:10:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B7t7Duf3;
 spf=pass (domain: siemens.com, ip: 40.107.7.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1fCgD8Ieyn7n6rOLnwcHZT4JDGlhDGPNGha2c7k+k2hC+DtBTbWCVEOlTRXuLPUyZj3F7PDn7Fakoc6mFafX2qsTa0etIDZVh+14T6AH0tDElkLzNqBEJaTAFvs78gk0WT8EkisgmkpcxBYhdgSiM2m482LLSUcLQvF8M5xOstylA0OUbnNh6A6IE51Uxv1y+7Skvqhrw3EIefsP4sL4gaE4f52HAcJuteE8Kzfnq5l0RU2KvDq2wdaOiQsd1I4k88OHSMm4/byPeoJXlbdudFT5H1WXSluEsCrRaOvy+jP20++woDg2Qbfk+ZgySMazv1AUh+Uudl6Qc/DGeKDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb2KMh6UAg0Q4B5e31lWgjJVvPEjW1M28uLWEw7SlQA=;
 b=k7iH3dY/bU0n5dX/o4A/0nFnAv20MGCOsQgBwvvAnyjk4Q33aeCK4Xf87zFfOQ3/id6Ss2C20rSZ20SxMxQOoBf7duWYwtNJ8xKGRpw0yb01VPAg3ZAOkP3uilZbi6LerBrFXuvprcyghB584MJU/J0xGeWpIdEgmVqb1Nv62knenqASAnkjRQh1pXG0yPC7eeZGh5s0OQPAsN/lvY60e2sznIePUjqwxITkXccFxS/bKbD7BKMYyXHlUc+Nnbl8CSBSxbJRSTVdz+VqiLROn2Ri3GDqWTULJJm6bFUEQMcOJAqTMkmfO7V/wOxDW8WWxKsvYclxiJZd0IBM024O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb2KMh6UAg0Q4B5e31lWgjJVvPEjW1M28uLWEw7SlQA=;
 b=B7t7Duf3OYxTrq2w46otV8bGVSwAyy5WFGLCQX9o5Lb6rD2hQKMV13BE4xZtWy2E1txTva0DMSfP3j9fXORxmYdEzYxXRy+RpakFHNUV1peQ6vu1cNIOOAIt2tqQyPRTYUBZ53FQK8Ab2nb9/8+q4/zdMcNgvpim4xAGq8XZYPskRdsKdyKoMLAmFczDgrYbXGPy5e+X5YwQK49nHXA+/SbZ43QeBaPOILfskPUZFUKEfURwbuTHg0IyOExoRDdPfy9g0xnga52CayD/U72x99B1OC9yanQB5kpQe+SMVkMuPcrnuQZRYNE9OdQZK9qG7Fm9pdDjfGaYS1zmAhHhZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:10:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 07:10:54 +0000
Message-ID: <4a37a4a2-f39b-0b31-ca09-f9f8391cd520@siemens.com>
Date: Thu, 17 Nov 2022 08:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3841:EE_
X-MS-Office365-Filtering-Correlation-Id: cb799b69-e990-49fd-b43d-08dac86ade26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N+Gbwh9cJLqwN72q5Xc86vwEtAZBHITUp5k/ZFx/gDS60zV1c9WJIbp+rSGdXV8vddrhNNrzz9EcNvIC5lK2r26/6umu8l+kJ9S5N1b2NTOSM6yXA48rARO4L9iwh1egWKm5MiVz26Xt76ev312KSO5JA6KoLQ5DB5u9Zdz+ylN/9lQ8gNAtouO/VMpwWZwQ0WODyYrPlst6n6PeN7QsR0ODoj5hw/ipeYa28WkM21s+w0tZzBDs0NfP2bJkwI+HxpXIK1IYRyZbCbkVC5IE3pL8Dn7562e5pHMtvDVYNGY8mO2vUhhNIX2gabXy1TAJeSzf84amNmOUfX4ub/cDa4BU/s+XBEVtwCvjE3h5S21U4uIkDLhUeE4MmvHDUfQeeoQi/ZANdmr/qehNVHb3cSkYdN0n2XJt0js8NHa7KmjyUFMuEbEyDsnNjza2y4FBf7dqRgz7J9bnkD2WMC8s2BkAltQXG+VQre4jxghzmE6Owe6ej6+KtwEfaaqG1h3KsbkHNV1mSCavX9zFJ7jl0oQ3OTjuWW8ECxlpPJqC29GE9WAEormXkaTTqRYaJZWb0ya+IUWcXTxs1Yi87KKR4LZAZQLZ48L79X+R2TKwosOw7uhkUXhbh26gtWNauDQaZHfDxXkGZmxTiJn2VhF9YC4O0k99mp1oV0QCRP5VYfA34P3KIQdsqny0ybjMQOlHcB37LnukYlKb545XRiYxDcT7V4k9qr1dU8zrurv+nH6YaZjBJ0wuLTNcZEUBGPlD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(31686004)(36756003)(31696002)(86362001)(38100700002)(83380400001)(5660300002)(44832011)(4744005)(2906002)(4001150100001)(6512007)(186003)(26005)(2616005)(82960400001)(6506007)(6916009)(966005)(6486002)(66556008)(41300700001)(66946007)(66476007)(316002)(478600001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnhhZzZjZGE5SmdqSHlsVm4zcUR4M0JpOFF5bWl2SHZnRkFQSUtFd0ozV2FW?=
 =?utf-8?B?SHJ2UTg4YTFqWURoOWpxZUxkNDZPdDNUem0veUZkbEliYy8zUlV6aXRHejJk?=
 =?utf-8?B?aFB3OU9HMjhhdnA4TlVYVTdhVnJKZ3hmaGdYZkF3djBaZ0lTLzlCOXlNanRZ?=
 =?utf-8?B?d2RldFFkRG5ERXFCd05nMDFYMDRIQld2V3JUYXZpYlNQQkR4bmVJQlNMakNj?=
 =?utf-8?B?dUduZHhtdnUxYUVVWVBWeTBLRlVMdDF2NlZqbXkySW1ubjFlVnp1d2VuNXpk?=
 =?utf-8?B?YWtSWDUwMXdJU0cwZXE2UW9raW53aEp2L3RJNlpjbWdOa2ZzR1BlbVI1M1ZX?=
 =?utf-8?B?N2ViYzZsS1JuWnRTN1BDaFhHRjk5NTlYT3V5UURLdkRqQlVHRVlSMUlCQTls?=
 =?utf-8?B?YkFNaEVsaEh4aEp6OFRmMk1LQUNheno5aVpRTkx0cDRIWXowQThxMG15L2Fj?=
 =?utf-8?B?VjBEc3Z6NXI2ZFB4NWtSQk5WRktjb1dJdGlMMW5GQ3lEcExkL2hkQmMrRm9N?=
 =?utf-8?B?NC9FYlB2UFlqNWFYZlg3NmdYQTBONm43NHNRSWZRejhsdkRzQ1pIaWhad2lY?=
 =?utf-8?B?L1o4N2liM1cxdnVBZFNlbG1vcXZEZ3REZnM2UW5qbXdnRklvV0ZpMnpLS1A4?=
 =?utf-8?B?OVdaSFVOR2UrcERhaWIvL2hHcUNSS001d2k0a00xalFUVWtybnRuUkxpbU12?=
 =?utf-8?B?VmtxTUIxTGlYQzArMUc3bEFXTTc2Z3AwTGFORzFYaU9HV0lBL1pkUEhFeGRS?=
 =?utf-8?B?ZDdZWWpXRk5KcFllMm9hN0ZwWmp3cm15K2JNUHp6bGdxdWE4amZsVVNPRDR1?=
 =?utf-8?B?c3AvazQ1eEt3NEdKMmV0V3lya0JTcGJRVzZTdjNmL2ZqaWgyL0I0VlBIcDM5?=
 =?utf-8?B?aktjSTdSWFh0S2d1ZUM0UjdrQmhrTjFaSGIveUI5U2prT2lDSkUreG5WUVhW?=
 =?utf-8?B?OW5IblJBbDE1MytDSU1TNVFaZmEzbWloTGtnekNnZkpuK28rTGpxcm1GdFpa?=
 =?utf-8?B?R0NHSWg5ckFhMzBIZVFUdVRrdERLcTJxc283YnNNMFJ0S21wajJwaStMNXoy?=
 =?utf-8?B?QXZ2RjU1azNFTkt0UVozaDlnU25oMnhCQVZpcnNqQ05WbFhia0kvTHZubGt4?=
 =?utf-8?B?ekVaTGVEOHFyZnYrY1VGdytwUWk0aUoyb0lkWENpYis4U05FZmFhdHBnKytr?=
 =?utf-8?B?ZldBNENqT0JuZFM4QkVCZTczanlJTGJsWkRuSzM3V05UMmMwMml0N0dDVjNE?=
 =?utf-8?B?L2lhRjVNYUhzRkZ6UGNkclhPOFZianVXVVJwWmxFcWNDdGZLMUozMDY5Z0VY?=
 =?utf-8?B?VSszREV6eHI1bkRFUTJuR3dVZ1hOY01uTE5nMWY2QlIxSExMeCsvVk9GdDk5?=
 =?utf-8?B?Z2FJOTBBaFFRU00yckZmRHFpcFlrR29PSVNxZUkvSWkwRFdrUGdVU1d1UkZr?=
 =?utf-8?B?dE5WaDZ2Zm50MkxEeEJCRTdtZTlpWC9sL0pBd0xYTTF5ODY4M0NWVEF4R3c0?=
 =?utf-8?B?aTJSSWNFSjQrN0lyTTFJbzAyWGJZbnRaMnhObERrSCtrZlNEM0hQZC96UFhS?=
 =?utf-8?B?V1p5Nll5aWZsN282TkFvVmVuUGNuWExpdk1Dd01qMVJKbHZEYU1Vdnd1aTQr?=
 =?utf-8?B?Vy8rRlV5aU5DTHpKc29WVmtReDQwOC9XV1dzMDIzNmk3amZtN08yblk3dDhC?=
 =?utf-8?B?RVNpcEIxdFUwUThudGF6dXVqTUZ6OVZrWUR4RVNnU1pBK1QrK0FzcEs2ZlNN?=
 =?utf-8?B?VEF0SnpOdHE3UGpseVI4OUhMRkpZRDh3YkNyVnlTV1ZxSW1xdncrOXI2Tyta?=
 =?utf-8?B?c0lTemdzQXZVS3VtUTFSMk5jTVhBaGJnTC9pZkttYSttN2YrUSthbFpBdHJy?=
 =?utf-8?B?enBQa2M0bkpFdUNZUVhPeCtnNldMeDlDVXhyUk82NUF3Vmg1YVpjZXozWTl3?=
 =?utf-8?B?TGk1MWl4cE55WjhySDh4S1FId3pkbENBRlBWSll6cWVrNzVUWkRWYTdJS25s?=
 =?utf-8?B?c016RTM0QngyNCtvM1QzRlFlNmcxZ20vMk5xb211UktqTlJLYzVRZ29rbEpv?=
 =?utf-8?B?TjlmODRxb0txNmRRc2p0eHAvTnBKWURTdHNFNnRQQWJXbHM4cllCOXlraVQ5?=
 =?utf-8?B?TzdGTXROeU52ZmZMcER0NFVRczAycloxUkJna3A0NU9lK0xXMWtKcTMySGV0?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb799b69-e990-49fd-b43d-08dac86ade26
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:10:54.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVBHyV5r2/JicqH5xii/sLTLaSIG8EfRjefGnN1b4Oc2XTUICl6CxeI+Y/7B9GXAgjP4Zy19UD72SG6furSc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Nov 2022 07:11:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10051

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=17&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/11/cip.2022-11-10-12.03.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
  2. Create MR for disabling smc test in qemu - iwamatsu
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

