Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAF3C6FD1D
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 09:46:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.75])
 by mx.groups.io with SMTP id smtpd.web10.68555.1679564770543124697
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 02:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BmUC4Jq1;
 spf=pass (domain: siemens.com, ip: 40.107.20.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSBaypD6dDNyO5/wAxailPHKRI9A9dJEqHqJM60uC5/EXKREawuW+839H/1wpb+mq56NA+I8dDRyXe00bmb5/ahdy3uRgSZBvcB8PuSMKMeH3ASYFPsZWgcGmquLg+OBQSIKWyjp+gcdERF3Ua9FB57KiITLzo+mkr4D10Y24nuPuWR9J2trL6uVhiyZ7AMp3Mxi4RseE1lI+weEp9yeZA4c1oH02FHMKeNtM24f77KTWm3tv+wm8TVzlkhcJVH75uKHPSiMuI7RNvur1iMOT14vLSX7f2HUDPjDWEMJ3l6tH70XQ0ko60yv6GVL2kgn9f3ND9NcgQJIlJKncMg4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeMHRVKTPIPdfLp2ei3AzrKwk4C63Apa/qyDrM/GiaA=;
 b=AOdugF3+JDx2PJWREPMhBiusw9tDgWX887xAfZLsU4VUtDs/USJiKkIYxafVLomTsbSZk+l0ABh4bxfMJT9VGnOgDQsTrcgScvUj0lwL9tQFxHohjhbrX38Bv7Ul36ANbpkOQyB8od8xYHAyZ4Gfylte59pgFxqgDCBK9RY6c8gqwLPtE9fL+/XWUjqxs0H8urkfYP9Y6cuCgOaxzOGwxUafp5DvRaeBdlZAHeFJ2IgcGtLkNd3a8dGXCdaQ3r5O7pAqtJFxG13Q4HfAcf1bpltUkle/WkuB+AyXDGtfOEJuDDFqldHhKkU0q378/g+mlYbqYarkHvlBk+jgdYvBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeMHRVKTPIPdfLp2ei3AzrKwk4C63Apa/qyDrM/GiaA=;
 b=BmUC4Jq1ulVrYYXHnCyOBTVrw+pAB9sv2gJSK9mYOoYaKD0MorC/gS6Zc1bY6Bqbga3iWHjIEquPrRHMhXmpgqV/ObDAPZqMlR1F7NsZRSRo02E7Inesu/qHsn5669Fz8x27sM5D0RNS7nNoOlTtbENHz0yTDNeCClcTUI2jVhrucGsWO/6I6jMXR2r5nLUzr0g0imhF2nA0PbKuSCa92F4ZFlLCXjzgoecdRtPil0n9hJ0TTDpru13pXDG04jksj+PFffrMglFRxkNBJZ+1pq0NgxHFgmsCAmKIEiBGnsAfeBVk4hWzyqhvCRt6J2/eYeBEffIwQFdy3/X0ECmroA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Thu, 23 Mar
 2023 09:46:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Thu, 23 Mar 2023
 09:46:07 +0000
Message-ID: <9c2b2281-611c-1888-4837-c40531769005@siemens.com>
Date: Thu, 23 Mar 2023 10:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0193.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: e248376b-44b2-40ea-5454-08db2b836d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	okj/xKlyq68cXYd5uytGoNXN2rZrl+qoIWtqeLJXsfJPnwEPqGWzERUzYfwXwA4vpHduxCDAuv/wjJ5T2laRvZL+PDlWo7Thu3F8BT75TwWRjDusBEcTfLN5YHFqjLVEpGTSl2IX6oZ2vMBBBacorfwmm33/OKEz/fSX7KPixSLyKQL+S8c3HapOq044FjTwojKBM+coEP2+v7y0avkBYhbaro+icUryHUBSkhWQGLiPpHYlA/g09Swm6NN0lizPWcQGbh3OAhAB4nYA0Qr5CE8akO8bj3GcHRVFy55IWGSqJAoA7uxVZFl2QMNSgyNzjgrW7CFbA0MAg1U/fly351CC2sO5hd3DHa/m+pE0XY1SZNRBjsPAw+N4Id8mMl5WDLkMAbbiYe0JKIj24rTAv726If+uOZGl1OdKQW+NtQkFhrobj3o7wyMWQYW+11jqODaYzIghdTgFyfKyQL1aGGdO0bxOAiXHJ/8LaUoa2NFpEj5clZJ47zwvR8ZetZtDePT2o3OpWHYSNpbzNxcs/FRu+YsMGRa+POEGGAvvgoWWSPSm5lj0ygwKDrsyNxptJC3cA0A+ivUdc2NNhOKPVxMPkdANSthYJHePGEK3oNJFKbro0y45AHXD0wo9rfV80GfkHTY+ImuMiX0atvIxesIFI4/vuzMnL695+sGsOjut0kPI7miIdrZT2XE4VMZFtKNzZ55Z7anTqXIPx+rLr7hHgh71SsEv5O+jPYXs1Kftz9/XRWKiViVn91P66WGc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(82960400001)(66476007)(66556008)(41300700001)(36756003)(6666004)(186003)(83380400001)(5660300002)(4744005)(6506007)(8936002)(44832011)(6916009)(31686004)(966005)(2616005)(316002)(6486002)(86362001)(2906002)(26005)(478600001)(31696002)(66946007)(8676002)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkxFdWtITHZxb0hFcExHbGI2ZUJDaytqNUFkVGlrVDlkTk1lZWg5Wk1MWUtp?=
 =?utf-8?B?c0lFbGo1UWxQR0VaaHRheVNYMkdUd2dPNGtjekFIUkZyOTYxbFFLQy9HV3Np?=
 =?utf-8?B?SWFwRGh3V3hmMGw2SVNCS01Rcmd0dlFnVXJSYjVCRitlYUd1WURTN0ZuSEhE?=
 =?utf-8?B?V2RRSnFzMC8xRGw5MXhhTFZ6SzVxckxMZDNyTEluM2cvRHNqRkRyYWViVUov?=
 =?utf-8?B?QjYyOUl1aWJhbVN3empPZ0huTWVTRHJEUC9HT0VUeUJkcisxT1MrOFFqZFdF?=
 =?utf-8?B?bi85bEpHbmFTTTkwdkJMWnlZMjRxQkZmbDA2Z3FlOXNkRVlMZUdUcGp2OE9Q?=
 =?utf-8?B?aHdVekhUcXprVDZ5YTkwZkxSRU1xQmVZbTFmY3Eva1RZRHBMQzBTQW84V2FU?=
 =?utf-8?B?UitmdWlGVDJ0VzRxNzJLd1BCVHJXWFJ3eWt3UXRvazBxQnBvekRsZm85aDdk?=
 =?utf-8?B?LzhnRlMxZFpNQjJEOXlvMWxUN0VjUjVTK0xSTDhpNk1Jc1ZGTXI5OWtxUnVr?=
 =?utf-8?B?WmdVbFJNYzJCQTl1NmprMmJaUGR5aWNVTTIvUTJKTnZJWmV1WlMxampNVEVE?=
 =?utf-8?B?U2l5T2k5bzdUM2R6VjdKRU05MzNBS3dQV3B4NDNqbE9FbmxMWU9vRVFGRnlp?=
 =?utf-8?B?bGpBdjh2dVVwaEVWY3ArY3RwakcvalhURlpJWVBNeGI1WGUzb0xLV0U2dGRa?=
 =?utf-8?B?azNzR3FzcnUvL0JoSFVtbDdOVmE5OHpkUXU0NXhzcG5SWWJBNEdUTTJLbnpE?=
 =?utf-8?B?UnF2c1Q0cXZnOHZPN1JyaCtBcjNhN244bEZyQWFRcC9pOGE1QUhNdmg3bTVr?=
 =?utf-8?B?MVpQZEJGcG10dUNYanF2NmRyU2xEOHNMdTBWa3d0VTVvaE8zSy9lK3Fnd1Bn?=
 =?utf-8?B?MHcxZ0NoMk91UDdwVnc2aUF1QjhmQzB0VWVHUnRWeHcxWnpuUXk4MDNwN3ZD?=
 =?utf-8?B?R3VmMkwrMUNBeDJ1Tks3YktXRUlubVVoZGtBOXJNelgzd0pidEEyQjlPZ0tt?=
 =?utf-8?B?amZLR2trK25HNjJkOEo1YytOdWVTUkdtVk1tcnNsd1BwYi9oTFJ4MXl6K3c3?=
 =?utf-8?B?VWxYMzYwc3VoYnErRk0zT2hPRUY1aWdNQ0toUDZBbEpmUEhBditDeDVUbnJw?=
 =?utf-8?B?RGFmM0dPZTVWQllWVkdqQnU3NTFMN3M2bHh0a0hBNW1PWnVmdGxseVYxYzBh?=
 =?utf-8?B?QzY0SmV6OUtWR0QxTXU1S3dBSERLdXRuQmNudGR0VlpqN3BGK0FSczRWbU9s?=
 =?utf-8?B?N0J5N0t2TEx0Z1JLR0tRZ2dsbEtqejhtMzBPTy9la0piVEJXMENxOHZQdHNt?=
 =?utf-8?B?bzZhbWowbkJCWHY0Tll6S2QyQm1ielFicFl2ZGN1OWNqVk95TWs0ZnBhUXRW?=
 =?utf-8?B?ejBsNStoMzJ3ZFBxb0xsMjNoYWJsVnZyT3R3V1JlZklrNGpmaklyVHNKeXFI?=
 =?utf-8?B?Z1E0UzJxdTQ3b3BYamYyMVpQOXVZeFVsd3ErSFdVZkdKTHVJcHY3US9kaHVN?=
 =?utf-8?B?YXREVC9lcEt5NUFzYXJPdm4vZHBQd08xbGdBTE04RzdIaTBmZHVFWHVEN1lO?=
 =?utf-8?B?czRrS2xzNXdKWEVNLytLK1g1UUk0SnBiRlRtUGdVQlc0S3lodGh5emg2VDZL?=
 =?utf-8?B?TUUyM0ZJdDZuUWJGdTR1YVJwUWJPRE9FNWhKVTdrVHYxZEV5dHhsTThRdk9Z?=
 =?utf-8?B?aCtBWkswanF4WEN6d2tEK0pYbmZ1cStLYmEyZ1JidjVXYkUvTGV1VGFiZlNC?=
 =?utf-8?B?Umx5RHFzTHFiRkY2R3dHS24zTDlCQU1FdzhESmYvV2pMYTJJbWhMTFlhT0k2?=
 =?utf-8?B?K0ZLTmdlRVQ1WmdCT3ZUeFZuODVzd0Y2K2tEN3RCSC8xNHpXeWZUWGRDbk5G?=
 =?utf-8?B?YlRySkFpd0xnUWJackpVNzBtVzhEeUtWNDhDdklLMklWaXBTN001a2h0REtP?=
 =?utf-8?B?L0JneW1XZ1BwcktVa1pFY05YSUJTNTdtUHNpdmJSV0s0aEJSUmtCZERKdkRr?=
 =?utf-8?B?bFhsWUY0Nkc4Tkh2T0c5RE5IcXNzUEtJK1VyY1BLSmNtVVBPVVAzc1hpYkVG?=
 =?utf-8?B?djBPalZBaVRnZTlyWFkrUG56M3QvNXBzRlZoZWJGTmJPRSswejJTeXNVNjRL?=
 =?utf-8?B?V3c0SkdKc2hVbWdST1R1ek8vZVRDSFdpQlN2aktLckJQdmtVeGI4UVgwVUw0?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e248376b-44b2-40ea-5454-08db2b836d31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:07.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMD5Af+Rn3QoEsNd/Nk/J4Kcx8rjn5fGXeuebjNPzHIXoFP1+8eer5WCIbM3fmWZV1ffKmV0lcVhLuql0S+RMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5622
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 09:46:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11098

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=3&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/03/cip.2023-03-16-13.02.log.html

* Action items
  1. clarify usage of .sources files in cip-kernel-config (patersonc)
  2. reach out to Greg regarding LTS (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB
  - who can run the meeting next week?

Jan

