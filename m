Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C5BC433FE
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 06:58:20 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.70])
 by mx.groups.io with SMTP id smtpd.web09.16599.1667458697066542600
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Nov 2022 23:58:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ng5WYzyf;
 spf=pass (domain: siemens.com, ip: 40.107.6.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ8TYb1EHSiXSuAPLa78STujjgxwn85AsuW8uMisB2EoVKUW+SpwaanU8dJQNwOuompbzyYwjATXH/9Cn4Xm1dwJNnDODLkRQDdi6QtiNC5K2Lq/+AOq/4ULPKUpj5qHtERXce0MPNqH0uLAQT4KSj/QwsOPI7cwQA24tGzgIooYuZuzPb6nmy/uSazsB71arn4D+fR1ZC+n94St0X2E0E6qy647e1yMQhnwWh4Mogk3zGzFqFKt+Sr5jMT0IGhxbTaKfCofaXOlDyvlcq9V4miIPLBydJAJKS3hQsyliKM3fi6w8rMFmJ9gZpkg4PgN5uyG8peD1FdYP5EDKYAEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Di0IQ11T94FovY6KInAw7x0Di4Gkv5dWZEA43xYGs=;
 b=fbx0cTxNNc1K+SspzdnEYkCbKnTjfvl1+yw/fZV7vpZa21znYgtazT2n93h3xSevvO3umMXNJr+2DAWp8uYMk/ZBufmFEKObLfDB4jx7pWt2Q+FygerrQJ2p3+47OvysTfTVtRpytQHyllFp+6uqc7IvbDF3V4rw0inrHosXkg1WxCsWyTQ7TevdZjQgisf15vpAb8J4iNdckdUI/rCAfMeU84YhCJSD59nN2GFmfQqw1JuJ5GAfPUF3BW7QpFCgeLGjSZWhQQV19ZC4/Skkw5SrsaFC8zEJaFd7stP4EgVXCZlepat+uG6GdGieYZiCuzo5WPHwGP2pIs0mWZuqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Di0IQ11T94FovY6KInAw7x0Di4Gkv5dWZEA43xYGs=;
 b=Ng5WYzyfXzoH878V4E24TADsaG2Nxwo6dYZv0mGe7nniKp9U+S5cfPePkozyn77AZoXB9XKmn2j0eXowac8GBvHrqIxbHHwML/lFGHgbTYyjHerxw1swzmuvKdXn+ccFTG5PQ9KjWzPCs20DMoCnQQ1mzO4a4AJ/ZYAwWmauL8/4na0uPeVXq14CMZAxz8dZhJNUWBNpklVARhN+A06seqXzkEfxHT9twcTCNNpaiVDxbwfrC8pHs/jcBLOAv9JFDoPRk18qa/LSucM3d37vHjYp9R8ClYor4fFWfVpde2KJR32uICWaQbpI9v1rjC62asAhDS4IknsOfacmXs81+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:58:13 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7%9]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 06:58:13 +0000
Message-ID: <6acccc21-df28-0aa0-f6fa-34d63021b0c0@siemens.com>
Date: Thu, 3 Nov 2022 07:58:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3591:EE_
X-MS-Office365-Filtering-Correlation-Id: 94edf3fa-c4d5-42f8-60fa-08dabd68c6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f9CpNy3bnDEOhQL0RDFuZFaf+keSOVIWe552SO4m1PXHA+12ejxdE1+VBuCo+3AT8cd9Gd63ppjzHlPDhHC74/h5dLVTj+of8y7dj16l5BW6O3Ike063z6Pvl2qpkWqwyo1vPY69aRyj8bFa8XBgY5xkvJ6NfSLY6Q3ef6/arTSos6D4g9vaqjB+FirLsroNLsES/SAjb217I9Jn8G2rR91dhp3ZRK1JSsEzFjBsTmodSnGeljOT3drTKoIwx8Ls+9sm+uXWMqK/JDE8kkuPqoXMw1UlHBhIQ3quBYvRqwLXFd4cX/bVSuZjkYsFGyR1Pw41LpBfWU7GpA5NSoXBkS3okr7eRPMFHScoe3d43sDOkitsjFYea7NIXQTwcxlsvpoly3+xXL/INKqnypZUHbE8Tu+apiy5MD/CvmZBjnuDX/rbitCL6H321OFaYTexAkf5f/rsaY2MHY7qIMQUmkv6jyo0Oz/mfEEnoswY8weaPTqu7mvUHXOlTK2zKMPAJHrzw8sWq7EM+j+GAQAAvIA/jRdPGGA4zO4XU+bZzPhudtySnyDqncYLYk+i5v+9dDzea7m+RwPXNO1vUEHsosE6U7Nurf3vTvgkdfoaopXgUfnUze94hemGtGRx699tEwMzXwUqNKpkQf1r9uyeRdAdZ+61pLyTVL1CWpT7Y2CU2QWVKh4KTBzeKb7lHfhtgFXnMh7t+ordSQBrKtD8QNKaUaVi1OjqUT0zvHwsZ3csOCqKHmcXtyyWYI7vpjYYIXjVc3r+XkIKAZ95C95nkvRyhvZcjrZ7mR5moosTMqDCUx3NlFCVW+4dyd7/uHYz7ADduSQIYueQGYPW3OuEtw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(31686004)(36756003)(4001150100001)(38100700002)(5660300002)(8676002)(4744005)(44832011)(82960400001)(2906002)(83380400001)(31696002)(86362001)(2616005)(6512007)(316002)(26005)(186003)(478600001)(6916009)(6486002)(966005)(66476007)(41300700001)(66556008)(8936002)(66946007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzJsYlRKbXlpMDNINS8yK2ZqekNyWWhlS0J2ZFQ3d0kyZnJsMEg2NFUwT1Nr?=
 =?utf-8?B?SWtrdUFOZ3lVc3dTemtqSVo5Yi9lRTIwenRUS0syNklUNzB3bGs5OW55dkVk?=
 =?utf-8?B?VytwUjJNQm8rOSt1M0FVMytjQWhFZW9HQmtwcHk2Y0MrUHk2cldwMHpDZC8r?=
 =?utf-8?B?cG04OURSaEIrVG0zS1QzdEZPclovNE5UQndZaXpEdld1YlVDYWdIbURzVHF4?=
 =?utf-8?B?bVBTYVhWSXhKYzhvQmhoYzZCbE9uenhGWTRCaFNIb1B5WktobjZyTm9MNlVo?=
 =?utf-8?B?dlg5VDBxZCtuR2lNREI4MUNpNGZTRmN6Ri9UK3pMS2lSU2xoTVFMWWJSbDhX?=
 =?utf-8?B?UW9DbHVOYVFodkxvWlpBRk1oMkZXdEhLak1uOCtsMG0zZjdYMU5mTlZYN2FN?=
 =?utf-8?B?S1RmODFWV3cwRjRBdVRaZ2pQRnNZbXg0Y0lsZFp5aXcwTk4ybHN1YXlFd2l4?=
 =?utf-8?B?a0hWSWZaUjM3cHZ3S0xScXBwMDdYN1VsWUtlbys3eS9SNE1nSWRmSlNrRklP?=
 =?utf-8?B?YWovR2ZuNEVUaS93QWtEK0xobVR0UTNXUzJEVFlTczVYS1h1alp2ZTJaSTlB?=
 =?utf-8?B?WHBiS0ZsQUJ5TDlxNU9sOHVjTStZWGVKWFZ1K0Mzd29QMFRpNTNpaG1GVjA0?=
 =?utf-8?B?QmJ0Vk8rT0EvMjVqZlZvSHdCNEdSR2pPMUdsdlYybUc0WURjcXJ3YUZiYlIz?=
 =?utf-8?B?c01xKzRjc2Y2MFRha1NFN3dERENiOVNWbkVDZ25PaEZWLytjWGVGYnI3N0xI?=
 =?utf-8?B?YmgvNkxGcSt5dE1oU0dnOXV2R2RuYmRhYkZoVHRCZ2FXVVVEd2NlWjgyUDhY?=
 =?utf-8?B?OVlvbGFEeHpjVng4T3BqOEpFQTNmQ1FuSEVqZWhIUXpkSHVzVGhydDNWQytv?=
 =?utf-8?B?Smc4U1loNzFWL3hPTEpQNW1GK2Z5a1R4RXNIaTNQN2dlZ2w1VTlsWUpSYnV6?=
 =?utf-8?B?c25oRHpYN2l2QURIN3ZZaHlHS0xoNnhIMVlOUHRXN2RjM1JXVHFzZ2VUeTVK?=
 =?utf-8?B?enJzVlFBSlQ1emhud0ZIQzVKNWNteFZYbW9yaExpK3JxR3NGVE4wYjNiSW51?=
 =?utf-8?B?MlFkekt2YkpIUGdSa3ZJYjVzeTZIOHNxU0dVbnpzd2NMbmh5M0FaRFhYamRO?=
 =?utf-8?B?clVtN2U5TW5DaGZ1cSt1NDY3QXZod1UzQndyeW9MMVc5emhjbi9IRzJKZHQz?=
 =?utf-8?B?VjVqeXJaa3FzbUVlRkdvMktnWGpSbE1vbzhaMm0rMGFoeWgvNFpyWDlMMktF?=
 =?utf-8?B?bkxZWmU2U0NEMEFrRzBFYU1BeHlNc2dYSUhVTHkrMkZQNXhIOFEwQ2VCeFAw?=
 =?utf-8?B?ZDhKTENRdHBqTUppak1qUDNvTmJMV1ZMVE95Z0l1RVRuSVBZOHVDQ0Q5cjdC?=
 =?utf-8?B?cEJ0dEJkVy8zZk5YTWdYWk5RdjRHTWpRV3JzUFhuWUhvMUkzVjVkRDNBaG5q?=
 =?utf-8?B?N3NJR1lQZU1hT2E4aDdQbGhBRkVrbE9yOTRLUnA0RHZDTjlFOVVCMUZCcElU?=
 =?utf-8?B?NE5EUk0vR2N6QkdmeFp2bHh6d25reUlqbmdXSDkwM012NHFWam5qVnBQeGhX?=
 =?utf-8?B?c0U5SzZ5NmY0NFIvK0pzaG9HRENmaGpRRm9Xa0JhSGd2QjExcE1ZdlNnSlBJ?=
 =?utf-8?B?Wm1ZaitNU0VoUnJ5T1JqU1cxVjZuZlhLanRyQkdKVVZqaVQybjB4cUxZR3JB?=
 =?utf-8?B?TlpnM3RqUWdxMkZZL2w1dG9zYzN5VVNXbE5saWk0Z2JiT2xiUi9SZCt6WGhs?=
 =?utf-8?B?aUQwcjRFOUtNQm8zWFRLdWZsOEl5MitTcUFKVlA4dkxHemFkYzZVcTVUOTVj?=
 =?utf-8?B?ODkxREtsc2tMVzZtcWIxdDMzSTlmeUZVMFZ2S1NIaTU4VHBmY2JLRE1ValhO?=
 =?utf-8?B?czBrQjNwQjRFTGRRSjZLOGlZdm1TTUFGZHIyRXRzM2YxNHJNTXRObVdiQTVR?=
 =?utf-8?B?Nm80M3BlUEYvd0F0NFM3c3JtNmtBSWJqQXg1VmlvWUpJN3V1MzU1MFVjM0t0?=
 =?utf-8?B?ZlhaME1wcXBPZkRFSmpJMVE4OHFETFk1U3F0TVY0VCs3bEVOOGl1bGVUejZL?=
 =?utf-8?B?eEd6K050OVNVUGJDckduK05GYXhQODZieElpOFE0U0VuT2c5UWh3N003SHZ4?=
 =?utf-8?B?NmZHeUVxTkF1VzhWY2tyV3NpMFl6cmxKTXBneitRZWErTDJkMzNML0srRzN0?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94edf3fa-c4d5-42f8-60fa-08dabd68c6d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:58:13.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzJF7KwjbmQpJH3kOoT9MdAfhqzN0cqFzV/dl5eQ1vzAYzNdDhIknDgbToWvM7h8TyXgDoKsZvQ4nVDt/GImSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 06:58:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9896

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=3&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

*** NOTE: the DST-related shifting for Europe! ***

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/10/cip.2022-10-27-12.02.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

