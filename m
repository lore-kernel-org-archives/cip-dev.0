Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC65EC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 07:16:58 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.71])
 by mx.groups.io with SMTP id smtpd.web11.4204.1668064612282664502
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Nov 2022 23:16:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=axGmYyUm;
 spf=pass (domain: siemens.com, ip: 40.107.103.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeTj4RB90qm5CUAaoUKUCcZOSiKXlEfwBINNXyJcpQdlaMa20yK3YBRTrrN8PNxO6e0coXXgDn4VZxavOF9g1Iei34szOIQ94ZDOriz7BRPx6bkLeFQ1Irr9LKUTjSKnrireZFSXRERv1D6ALUNqdYuyhGH8EUQLJecG1yOLZHte9z90dRN17wAKwwZo5iCp/UuTy+weET/SkMmhdrvpe8mOSZ8SKX60isJdZujQNEqc02CH199+Cdcy6wzR7BYCQxxJw4n6WRaSrv68ZdR5yc9hKLhfehYldp8qr1B6a9aPivCzDBiFlH0Tj4+RYVRPyww+QmVeTbl1LPkbmlC+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS6q5WORDfeMI1cG4vaNKYb4OyQB8Q5ChspfLCZkcOo=;
 b=j4UC7mdXGYEjOluCPbx2/BwvSEbBjzRMdBPuQIpcpZ5BdBWqsTdZC0FKrPrQKedKk0dqBsaotNtmwYo1Hf9pM8uHZ5k4cq8v2BQWJ8VixRiSYp/rat9ep5wcnYIz6aUQTHIean4qiZA6oB0C8sNuqrOOVsdtLPjCHD+xraMoCCpJquCRC2P6Br54blcDGZcM2liqgegRq07ESCQPs971gnce1X0Sodhq9pa3MwrKHhdbqPSnl+mt8nfxMYGHxAGOClp/3WFtV+zWNfgItbnY+YcimQ+TU1CwuIfGO1acE7+4jN/QBBsp3EiRNqtPK0+f0lARkIuvbPR5l9wyAzV8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS6q5WORDfeMI1cG4vaNKYb4OyQB8Q5ChspfLCZkcOo=;
 b=axGmYyUmXcaBkl2lg6TfLA+oYN6fi3SX+cWdVcUUok39PqKojxiYqA2MRNzL9raS3pu0D1T08Fo56ZCxTa+i7qMGFbUa0OM9cK+0XqJTWTop3mjJVFQIdJVmYweo6h3o+6L/k2J+m7ScI5cqhINEL6kHIXwmpoUQDnlOjz6VBJdddnPcTlO8hQ2pnBAjLuXQc/7xVgJJf1y3U3rtt59JDXBtCwwM4ecPkIQ8X5JvdYMcMvfs/6SF3KDWtnKuX0bLlb2smpWaKjPLO8y4x+5Sj1bAVhxvm0SmXh3rsfh82iXobxnYKhQOgERjQZd9GceMwTvGjXQLxWx5Z+wGNNeTdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 07:16:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 07:16:48 +0000
Message-ID: <43e3ee09-7756-d356-df2d-d674d7da3404@siemens.com>
Date: Thu, 10 Nov 2022 08:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 76383fd0-8f8d-4868-d97f-08dac2eb882d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q3QFMVRVnVRrsjFUWHZM7exn43PCP1DpMAW1o8qehmYJlOmyAj+RztlN6RNrUVOahQLa2TzORhh5Q1j2m/snSOS+MfnoQzVKjEqJG3sRu/5PvXGqtk6g4mU5fIKeWpmsKjQdGWkFHGvHe9qEtIJjEzklHJYcdaV1/oPOiWn8ipfd5urvaZPlpG7YKQkxbgissDOjePEx/6yDt5PFbjd1uNe0R3CJZKDNaeRuJJMCjCuM4g4r+t/tM0YqXLyD8hy2+SsKrUZ/MMFHzuhANF9907tW7YNacYtq35RaMmYDIKp4vB7EtJXFHFE4NUO42W86kSUI4O+0u47slUcNAhyHeq50oWD4aL/2Tgo7WqMvxIyKU9N2sinh3rM/4W0jGVVC0gx2HV7O30ksADf86bG7wcRKtQBQuf4T5b9hAps+KCVrG+0A0gSPSvRy6NE4/BF0K5ZeL2G53ZqaUjDVtnpzZbZHWEzJJteuaBvB5nuMGiy3FrrCCPupdK/XQtvm0O3RGvTIxrQhHe0r2q1rqzSJJFDIYLs9MXf+BTpRJ+EqqjFscBSp/gVzP/8i8JG8PUd/t1Me9AG3c+qbXxB1/pQT0n0owvPLZHzNUzTZaiY8pDwc09ZgB20Pl5ZoUQheBrVkuCack1jjhdMLL/XXdzNz+sb8l5uzGymMSQU3811NnIIe4ij8MCkH4sJTJTAACJQVbqB1Ne6jpvXytCXQcNOEPTSdr2szdCj7aq2XuTEGOxr4hAYeB/P/+EAJYnjAd5i+bpFqK84jcnS4QC8LGCuJgLK26iPR37vLwhQUPo9eNG7WeSUeFyKyJmq++EijeFlf7mE7C/XqnmaHOVEZwfcmhw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(82960400001)(36756003)(31696002)(86362001)(8676002)(66946007)(66476007)(6512007)(26005)(41300700001)(8936002)(186003)(5660300002)(966005)(478600001)(2616005)(6916009)(4744005)(6486002)(66556008)(316002)(6506007)(44832011)(83380400001)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ky9ndjBsanFwNTVNKzhLQXVNZ0h0Sk9GSHpWbEtHYkg2MjhjR1N1VlJzM20w?=
 =?utf-8?B?R1BtblJKRVJ1SWtpZmhLa3Blekl3VW5XdXUxU3pPRW5ORzdDZTgrdCtTU3hP?=
 =?utf-8?B?OHd2ZFlDd25TcGRjVGxOM0NaRmxES1FJNFpFQ1BwNDZ4UkdmZEVkM3YzRkVy?=
 =?utf-8?B?OGZqcUlYK3gyOWczR1pZSDZnQ2wwNkd0NnA3SG5QOGk1cTgzUlhsS0prcXJx?=
 =?utf-8?B?d0I0bmFsaFhwUGl3am9URjV6VE5TMnNNNWtyWkdLZEZnMmlPT2FaVFlPN0w2?=
 =?utf-8?B?cVI5QXZNT2N5NkFlcEZPRFpSNmxSVXlEY0Z6eDd0Yk80RHNha1NwWXFwdjRR?=
 =?utf-8?B?UWl1M1RuY3BENXNURWxmNi9rNlB1VHZDYXNKaURqbTE3SFkyTVV0Slg5ZjhY?=
 =?utf-8?B?QzFaSzlVdXR1S1hhYzB5djlaVnluQSt4VWVGSjBsMzZ5ZExoR0dHbDVtVk1Y?=
 =?utf-8?B?UUZRcUhvV3h0K2p6S2g5UUl5YW82cmRCTDREdVJVaGdMTXJJdklTUm1aMDQ4?=
 =?utf-8?B?MmNZNjdJT3lOcVF3aG9XcTZnQ1ArbmJQMmNJSDI3OWk4c0xRK0ZKYk1OUkJ5?=
 =?utf-8?B?clhpT1dWNkdFN282QkZNVEVYV0xqM1M4QzFzTmQ3K0gxNXpwa2dJc2ZsMWNl?=
 =?utf-8?B?QVJaMUpZNUxjSTBFaDRIb3JpZFN0NUJ0NWxEWm4yV3pOd0tvcjAzRzJoYjc3?=
 =?utf-8?B?WnY5SEw3bVNhcXpER3ZrL0ViMkxESVFxZzlzSUpTUDNIaXZCci9PcXUwckZS?=
 =?utf-8?B?bCtRdzZjWVNyKzV3MmgxWUYrL2F1MTdNM1UvVExqTDBWMGhseUlBa1JpNFJV?=
 =?utf-8?B?bGZ1bFg1VlBKNHdkREErM2JreWk5Mlo0QitZWSt4Q3FselpGcm9tMWFlYm1t?=
 =?utf-8?B?aGt2VmNJL0RFZlIxYkFsRGd3YnQzYkphaU5vZzhBS1JXSnFIcThBcXNETlVl?=
 =?utf-8?B?N0JhRkRmNmcxUGF3MFF5dHpKeEZtSEovNVNGVEpIcUZybWQ4bTd3bmw1NHU5?=
 =?utf-8?B?ZCtPck1YaDJBNU03WGxUWUUvUWphSlJEckVpWnZFWWFnbjFqWFVyQVA2SW83?=
 =?utf-8?B?WG1taDkxb0MxQ3hpV2UwYitZREQwTVE3ajlUN2lFdWdCMnI1Wklod05QZURo?=
 =?utf-8?B?cjNocjN6NGNJUGw4SmlYR20rTm1FV1hFUkNTR04wZGVJYWFNOHBoZXVQMjNa?=
 =?utf-8?B?aWJxT1pTdWhHQjhBRTdHbWt4RlBIMkJneVJHakd5ZzJMZys2Yy8vbW9rZmVD?=
 =?utf-8?B?eXBhSVFqSTEzM1dDRWFySjBkZjZCVHZkRWd3NHVreHNiY0ZIZEx4WEplQVdJ?=
 =?utf-8?B?Z0p0Q3ZGQk5rNncwQzBBRlJsOWppMXBRdjdLY2hmUityNWJTa2hCc2ZwdnZy?=
 =?utf-8?B?WEk4d3JqSXhudmJjamdHSWRxVnBEVmpBV3hFQjNTZ29INDRqWkN1V2ptUUhv?=
 =?utf-8?B?M25IZnROQ3dKc3BEV2NCMTEyNUNYUWVVdUZxb0UvdzgvTmlXYnZqaW43Zlk1?=
 =?utf-8?B?TUVMKzJ4bFArc3RnU1BWZkJ6SHczMU5YM1FkNUdVUlZmYmRVdXNxMzYrMEpj?=
 =?utf-8?B?QUFLWmtZd0pFNW45UXJROTlMeTQ2MWNuaExPUU01THN3TS94VmdVTmpuWkYx?=
 =?utf-8?B?NUcxTE9PaHB6NWd0Q3NGYTRzeTg0T2d1b1pOZXl1c1J6QU9QeGtwM1dGWUVl?=
 =?utf-8?B?b0JIcjZoSFFFeVVFYmZidVp4SDVYUWNlRHRQaHBuVERwVExRc0lnMGl5emMr?=
 =?utf-8?B?bEhRRncyUkZRcHNWc0hsMkZ0ZC9Mb2VVMUV1SHJYRDhNVG5lRTRkQjdwZVo4?=
 =?utf-8?B?Uytjc0YzU0owSHlsSldCZHlZclNWZ3Fob1Yvb3orZlJ2alVMMThSRmN3dEZL?=
 =?utf-8?B?VTdPd3YrOWdmaEdjeGluNi9VNEcrTjhrSDZDYldrYlBlL1A0Tmh5V0hyc3Bu?=
 =?utf-8?B?YmFZTk9lN1R4dndvc3p2eFkrNFpnZDdVdjY3S2J6U0ZrbU15bDVvYzZWR3N5?=
 =?utf-8?B?SjFORlRNVFNBN0t5RFhuMFNsMlZnSTNiWjBjT0ZydFZlRTBjWkxpL1JmaXha?=
 =?utf-8?B?VGpZV0ZFSTN0M0Q4WHJhWW5oUVowMFNXcjZ5cXNkYnYzMzF1OG9SMGwzVXlK?=
 =?utf-8?B?NDlsWTVFaWVtK2VoMitzeTBYeUhwWDlKODdRSFZGWGV0VDlOUXpIVTVPMzY3?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76383fd0-8f8d-4868-d97f-08dac2eb882d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 07:16:48.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9QZ3JfVLUVGHuII5TqsQDH8zjigBfG2+zPMWDfPQXXyOipAUDWaGjZm64V86bBBuZcO2mu5b4orWYA/Z1UDTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7496
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 07:16:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9992

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=10&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/11/cip.2022-11-03-12.02.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
  2. Create MR for disabling smc test in qemu - iwamatsu
* Kernel maintenance updates
* Kernel testing
* AOB
  - actively communicating deviations from the kernel release schedule

Jan

