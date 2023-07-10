Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B725EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 14:06:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.45])
 by mx.groups.io with SMTP id smtpd.web11.40377.1688997952119677359
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 07:05:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TRD44yOu;
 spf=pass (domain: siemens.com, ip: 40.107.20.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic43bzSeAEnr0U5Nv++bBCVHa9uWHNhv0nXZn+ZuzZ5cfTyuiYf4RF5lCeTVlC4N9MZVrQiUOe5ekgCbfBVSvIvXs8wwKBgdmf/4ZnY1ixmQF80DyM95G/I1iwaABwosZFzc0B1/rFYhwhuMyo3VgNUtfQV/FaOigtT8S+97JuickKd4EsuKsZqmtMwHuWNsoHrdLDotedYQFWtcWCqSFuYFp3Wmkc+KnP0YzxbooTw43u5X0hAej/7V9UgoVL9HLLkJhLgRgIjYp2EIseICuyMv3BsBUdOn69hzi0Md59h6zeya3B1Gjjbrh4jyQNWBRpWpyGNZKAwDhNjzhngxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc8vwT20ZN1uqW0nFyzFEO4vBOkXi8NMMRBQKfqhNcA=;
 b=h6t40RfjsTZ1X1nUJSHQTIddt5jprJvYcfh8OE/Z6l41iThK4YobIYgutGC/QXhOWSLMC2jlSPDR4PJdwheC4lJj6X0v1EkYPSLUCp/Eo6onvO2DiK4Sq5Owbhwsh/2+kTZ51SAKqeMnmo6ljoXhkJdwhrwZRF8xWFzUIfWc/MuYfsb+v6xxIrmEDEj1Tt6i+maj2mBs3EnvCFkPTwn0Zu0YJXyTZZUoi1XbIMUp30CxhtArVQpHICEfGO9TG8Orc23jB37PFhi1Kos0nJf1Vxr7JEygtKPaL7TPRslNL1osn5EmUXEN7Uqn5/E7/zm9/mU7K/W511nMAAcGQSiVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc8vwT20ZN1uqW0nFyzFEO4vBOkXi8NMMRBQKfqhNcA=;
 b=TRD44yOu4yrZCQ6ZWe3N4pzLVIHqVfqzjR6mLy36xnUtONUQ02DxK1seyypUbqMBY0O5cWcXBuSqfUmSwyhDD4trGqZguBQ0o10p/EfgyJgVcEvCbt6E79YLTfQI4H+B0lZxhDvaewBxjz/OCjbnQslfF9+/w6cfxHAlpaHsXLe28XlnbrsR8n9EPc2AdFC0W77YJtEnOUuHmHKRW4ScyKzO8bfkjIuiJ+CY1Dp56ZLNJ2a9D2yv9vtXaz5pZaTx3AEB21aYThAF6yifToQmkzieD40+N56kOp90moqACCioAlGOgjGnVpluyrKrjMRh5z8MH9Jmi0FVO3MHFGEiLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:05:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:05:49 +0000
Message-ID: <e2f603cf-2c19-398c-c10e-5eb25e55f98e@siemens.com>
Date: Mon, 10 Jul 2023 16:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to
 latest one
Content-Language: en-US
To: "Arjunan, Srinu (DI SW CAS ES LI PBU RSOL)" <srinuvasan.a@siemens.com>,
 Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
 <1a507755-e6db-3ef1-ff0f-cf863de4e2af@siemens.com>
 <PUZPR06MB574771EFF5FD7AC1026120898830A@PUZPR06MB5747.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PUZPR06MB574771EFF5FD7AC1026120898830A@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:610:10e::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8cfcfc-12ce-41ea-61dd-08db814ec380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	le5hBpjdFvn0IYLFEQ6nIkDrJ5HdzY7Va3e7qg+UMoY84QEHFPmmpgznlAmG0/GELhaUMgNJVolri2npZqd+bx88RuXeU/ljRJQJO8jKiy7K1IVq5iyFdwTG8pT0YdiwNk6ELMsAiDoMjNE7c5fqj8vnzEiOX/A+iKLsrYaAyTOqMDvobXe830CTjcNTsH0rX2EMjeFkmGP3xNK4j88j09Uta5MQMvwg7+tqy5GJxkE/3iZEQeZkPq3rsQgewetv8fTmTB/w/Sn+G3XynDpZf+KfZ+h6HYsabBI6zbVf1m2+76teQTMC3nu6SH854Rl8MkkZM08oJDYQG/lsnfzWMN84oOJr7bddeHBP7LeUsl70slH1K7IF9Eq+cXIyAbkYG0twesgPY0PrR+Svf9p6c3b/fChkfmp2ZH7Dqbs8NqHdqo+oTAEpyCQJstvwHZGM+HyCN5g3dBBCBNgx2wz5X0mayqRUEw4A/nXNDvRovroeQcYtuhqPU81B/wOGC4rlALakHxMqLRFnZv++xqQPQzzFWGQg+NtapZkHv07NQ9W+CphfkSkJgm5Xp69FZU0HxXTgf9lZJbs5de0WlXIXt6JAQpqZrIl1BsLVxn67+QNgETPnZbMhBDkyevM00DxZRP1CZI0K/s1KvwN60dKWDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(31696002)(38100700002)(82960400001)(31686004)(36756003)(6666004)(6486002)(110136005)(53546011)(26005)(6506007)(186003)(6512007)(2616005)(44832011)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(15650500001)(66476007)(8676002)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGFnMEpDUkx0WEl2VjlBeSt5ZlhqanJDMzJZR1N6V2JidzY4VWcremM5QmYy?=
 =?utf-8?B?dGtrVUQ4bmxmTk9ycmg3ZHB5eXBia2dXMEVGbUg2dWZLSExNYTBubkRRaTlJ?=
 =?utf-8?B?RFViQlJ0UVlqUlh6VE5xL0UrdzdialQ2d0QwRzV2d2ZmQjE4eFlHNWsweVhk?=
 =?utf-8?B?ckpSK0pEemoveVJxRGVLVjBXUUtGNHVHeUFFNC9naHRuZHJDN1ZKNjdQSG1K?=
 =?utf-8?B?UDhQVkw5VzdpY1lHbWtsSGlvZWt6V0trZmRyMVlDMEdRTWgxbHFUOXNDK3F2?=
 =?utf-8?B?b2xDSDJlWmFBRHJZbGthT0dzMjUwWWM3RWNHRVVxL3VKWHZXczFTd1A4OGRM?=
 =?utf-8?B?QjA1dUJZNlhhNUx0RC9xWmplMlNaVThFRVRWUHZpMTZDMFZ1WWJhUSt2VENQ?=
 =?utf-8?B?cW9zNXRDWk5Eeit3Ullwa1VKNHN1Z2k4Vytpd3NLbFdyU09GZ1BWT3V1ZDVG?=
 =?utf-8?B?UHBkaFVtT3V4QWN0N2lNdnVDVDhhZGsvU1B3dkFvUEJEMjFocU5zaklSTFgr?=
 =?utf-8?B?cTZmRjJOYlN6WHJHK3hJSWJrb2s0cVZlS2ZkWjZwMS9FNndJN2h0dlhzZkdv?=
 =?utf-8?B?NmwwVHhGMkRLTmE5U0JBMjV4eCswK0xKRmxmSHZFQzZLaDFITDVVMStlazcx?=
 =?utf-8?B?ZXZVYkI4MlV2MlMxaTlXUVZ5Snkyank3a0J3VkdNRzNJT2hFWWM3UTdMZ3dS?=
 =?utf-8?B?TXIzTWpyNSs5a1VJYjFyM3AvMGVZZjRWU3VuZzBSUGJZY211OFQ1cG9WUk5k?=
 =?utf-8?B?NGFrQUFiL1kwZEwrVjg5eHVmZzhGZlhBRDFjR01qd09BRVVjKytMaXdUN0lY?=
 =?utf-8?B?bnExeVAxOWhJMnQ2VTRlSEJ6Z1kvNEFLdFRPTzdLeWg2cVBrMFZCV1luSVFF?=
 =?utf-8?B?MlJVOFkvQS9hbHRiUktneDNQZVdLRUxkdWl1NWViRnQ3YzdHQUZscDRtbEpi?=
 =?utf-8?B?aWZlbnJzUUdvb1NiTDFpRUVDV3dGcnVqZkhESjdNMWJaUVBXS3Y5anZSaDZN?=
 =?utf-8?B?cEhveWpNd09selJjQ3YvbWJaTC82ZWhZRGU1dUhTVmdsR2dZbjF1YlZBNW1k?=
 =?utf-8?B?Q0c3K0ttTVE4V1VWcGd3eEw0V1N0UEg4ajA1eFF2TTlFN3FmZlB0dEowM2lZ?=
 =?utf-8?B?UGsxckJONS82T1crUTNRVlNCdE85b0o1V0JJM1k4ZTJjb2p2U2ViL2FiYnFN?=
 =?utf-8?B?a095MzFxbU4zRWI4V1NRVTlyUlpPMEpwdE9WZVpYc0R2OHZ5UkRQaDIzKzJP?=
 =?utf-8?B?TmpQamNqTm1nRWhIbi9ZczRxeGRZb0tKcWVKd2d3U1AxNEptZXdSOW5tbVR2?=
 =?utf-8?B?d0JvekJVVjlsODNkN3BBcHJnWUFQOTRWdGJhemVmMDlTUmtENFJRcU1DeFhl?=
 =?utf-8?B?VkFreXgzTXMwaHFrRGhjT0ZWb3IzcTZzT0RRWS9SZSsrOW9OL0t4WWJabk5w?=
 =?utf-8?B?eTVRY2U5dEhKTFV3enFxUEd2U1BmUTBGQWhPTGRURVI0UUwzZVdnVmpBcEdq?=
 =?utf-8?B?eUFVZyt2Q2RrVG9rZk93MVBLTVlmSjh5UEsvblplZGlCTENXQXVtMldJWXdH?=
 =?utf-8?B?bDluQ0YwK1JqTWg4M1lkWklHU1VaMFdpTEZTaldCVzZaTFdUelhhUmMwRStk?=
 =?utf-8?B?d3N6STBHVUFpcFJSZVNBcXNXSEN3d2plNmFpYUJwNVFJQUIzZW1vR2ZSR1lv?=
 =?utf-8?B?YXFzQnNBL1poTmgzVk9jZG1OcDRmTEQvekJqWWlDa0owMmJxK09PZ3JYMkxm?=
 =?utf-8?B?VzFnTUdWU3QyR2VvU0dHNVhNSEhtTmlVY1pzL2kxL0g0aFdTZGoyeFh5UEU1?=
 =?utf-8?B?bXQvQUdobkVOR0I0N3VsREROVTNDZHgrWU5qOUs2ZEdhSUIyMitYSE5abUR2?=
 =?utf-8?B?SVdaS3NnRjJRMHpPS0taejM5M2VDVDBCWStiYWxBdm9XckVjM21MVXIvc21B?=
 =?utf-8?B?amNHNnBLR2pRY3EzTlp6S0Vkam5hYmlnbngxK3l4SnNPNkpuSmVZaExmU3Vo?=
 =?utf-8?B?OHhkaWcxYVZTZkhKbkFnZWkzcXRmam5IczM1K0lWdWxvR0NJMWIwNmRhekl2?=
 =?utf-8?B?aW10VVJVTWRtMTBWSUIreUVqU2FqTEd5UlNYQ2pLTmh1OTFvaEl1bDFTNEox?=
 =?utf-8?B?cmNOTlArRVN6dW5BM2VWclBiNFprcCtYWmt2eURlTFdDLzl2N2pzbnJrUFlk?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8cfcfc-12ce-41ea-61dd-08db814ec380
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:05:49.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM58lrcwFnSyfpV3CRdCulyL566KJ2QKbhV+i3uPWg82QOwShIQe6EESZIkPe9PV2uv5//HhMiRV/ZWv2hL3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 14:06:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12297

On 10.07.23 15:49, Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) wrote:
> Yes, it is 1.5.5-3 for [bookworm, trixie, sid], however They added multi-arch support and release the new one.
> I forwarded to you the email reg the discussion with Felix.
> 

Ok, thanks for the info. Merged to next.

Jan

> Many thanks,
> Srinuvasan.A
> 
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com> 
> Sent: 10 July 2023 19:10
> To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>; cip-dev@lists.cip-project.org
> Cc: Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) <srinuvasan.a@siemens.com>
> Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to latest one
> 
> On 10.07.23 14:27, Srinuvasan Arjunan wrote:
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>
>> Update shelltab to latest one.
>>
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>>  ...001-Lower-requirements-on-setuptools.patch | 79 ++++++++++++++-----
>>  recipes-python/shtab/files/rules              | 21 -----
>>  recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------
>>  recipes-python/shtab/python3-shtab_1.5.5-4.bb | 28 +++++++
>>  4 files changed, 87 insertions(+), 77 deletions(-)  delete mode 
>> 100755 recipes-python/shtab/files/rules  delete mode 100644 
>> recipes-python/shtab/python3-shtab_1.4.2.bb
>>  create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-4.bb
> 
> Debian (even sid) is at 1.5.5-3 - what is 1.5.5-4, an upcoming update?
> 
> Otherwise, nice update.
> 
> Jan
> 
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


