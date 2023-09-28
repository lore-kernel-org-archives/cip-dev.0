Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED9CE7AFF
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 06:24:11 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.41])
 by mx.groups.io with SMTP id smtpd.web11.8146.1695882248258115359
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 23:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mL0pa+MU;
 spf=pass (domain: siemens.com, ip: 40.107.15.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmW3CufJwUkiqjBLHoS8rOIGYlPX0v6IaxIAnJKPZOHeirQEhS/oWAmYXwoVcFfvLuD1IcUVGPDSFM2BQtwFI7KuTkpFy6iZu/UMHhAoI0FC9aulEenzNxwpDvjdwQS6fJ+CV7jWMESrRU2327aK6V8y6DqwFwfSbnI/g77CEIyw/dgBNqWRL30FevP+wDH/IW417iSaCvnnBJrTckcSiFaZxwtDyHBWUOSPQo1AYqc2oJ5NGEuQ5MKvH2OhQ/TyLLDxIuNX/sdysRf5v4tzFUkrtXaCdw5C/2Oi+z6n1maanL9zYv7goxNG1u+myU2aBG0M1mGA2b4lfWPeD9r+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfN0CtouAAQR4ZJhBmyaxmo80WbrmVBUqS/5L+qMIi8=;
 b=AgG8hXMLtftyIRiTP8LVvOp0swtCsRG8T6aN87URtTl31WwVhlAkaXWkBNEF3J2fmz0Nf/B/Dgk46PrNHNjzunn6lAoHbcIV10zCLOPAXvoiQJtNtwoJH0sF7WRIL7ZFTPnDF0UdOsKJw0FuZQpuXvvs4H50QZSR7evmg822byswvqruJIiKHv0Jzoe5w6qtdFtrVjKnkg5jIFQ55F0W8Rh9XdIa479HNeBH1ZlOXIILoEQzu86XF17mTB704zAiOeOu2ERH4C9/vBnkDgU5nn1e/fSZIy5TWCRbrSNtNo2dsAKYQiURNe5e2fIU/SVfhsKj59GGZ0N6StXgdJ9QKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfN0CtouAAQR4ZJhBmyaxmo80WbrmVBUqS/5L+qMIi8=;
 b=mL0pa+MUUsi2Hx+20rsgbhZ7sBvol2BPMTRzN7lwsRSmlrd03LvlWmSVb00VoUERJIoiRuPaZLSt5XEUDBg/j1XD4ueEdsBJBHHrW641Z6dKL9WmVlQshnIAxPP4yNf9BWJe6sRyt2L/q9m4kPXaALatfJxVOBsAOvBvAhhaCbkvsHCF66VQVn4A3z4Y0D9YUAMLOKUMQRYYskwVYqQ2byXwDkzvnh82kyglckxOmqBUlzw5w3oGv19hQ215DjuRe0qEn1Z9izB2KLSkyyNkceF1P+hgsIkCdDVVnKxKcgMx8LtzF8NrjoPfDnY1NUfFjy2Eoysj0ZT4I8+LdrMAzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:475::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 06:24:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 06:24:05 +0000
Message-ID: <c607ba79-bf71-4057-addf-d7c069b574d6@siemens.com>
Date: Thu, 28 Sep 2023 08:23:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:610:60::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: c7042371-3832-421e-7eb8-08dbbfeb83c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z8es3Qzk1VB151PVfd0DWZGWjSNJgKQEY8BlVLrvRfBtpCUzJJpVkpk3UF7js0ADxDpJWLpT94DGB8wHngdS22X/WMJ34KIkSLbCdpiw6X6of1gG0jDzAK/XjsnYUZnQss4x25U43GILNB+OTmeGcSQ45UwhZgbv1IB6+8WxS43IYPuUi4tziznys6mqyoXLw+9AtlLgKMdHOJO01zsOjSwyc21myF300sxC6hvPSuYS5ZlWjJmBNoo8aPx6fw4FWTrvWPEqHbtrTlnwyZd4BRl2NJ5WZN3oCAZnZ/LrYch1t/oWLIvuu48XLuVaeEWnIJVbqdaVDJRnqngcbsAQXn1ho0lVv6qoaBCyBCTr1OYnCezPyUC0rQCFqAHvFTKlaJClDtfeDJwzPMtEotX7U6xNVIzh6lSlJu0SzGsaeQVBRfQ/+x8WvI4alTbkgb76G2WK3VJDvSr6Ys7+fNt/Zk9yYMq/65UNgJNORxV8QkLRZf/1kdR3UWlDxnugfukcSMp4t3jFlo/7sZVLYSquTx62EDpQLxm7ULLOFpD73JuHWKsZ5gaJ0nY2nyytA8TKRXEbfxbC9XN5l/pR70WUYiElcAzkoge7obSFMvUbpGbloZp1oGs5xepM1Pkv+vrmTFHHY0+tNfGVJ+gYrySmww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(36756003)(2906002)(31696002)(86362001)(31686004)(6486002)(6506007)(966005)(5660300002)(316002)(26005)(44832011)(66476007)(66556008)(6512007)(2616005)(8676002)(6916009)(478600001)(41300700001)(8936002)(66946007)(82960400001)(83380400001)(38100700002)(6666004)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3hGZWU3dnlDdFBLNENQQU1JZXk0YVJyalBUMzRtTUxyd1RkTWEvUTJsZzZ4?=
 =?utf-8?B?eU44cEhPYk5Za1lXeFpxNnlRcnoxaWd1Z3pkOFdWZlZlWjNlTUpEVnFLczYv?=
 =?utf-8?B?UDQ2NDl1QVNNT3hIYkFSNHE5QWVpNkV1MTN0eTRPV1p0VldzbmJPV0U3QS92?=
 =?utf-8?B?dFlsdXVzUThqTmttS3h0UjVzZnFmZEhqUnU2NVBvL3NjT3grR1doNlhqNnl0?=
 =?utf-8?B?dmxVb0VDbWpwbHV1a3BpQ1JuSUJxRWhLcFNiWDhEeUsxb1E0UjlMNHV4VDIw?=
 =?utf-8?B?TzhzVVpJbWN3ZkZpSWNwajVITUROYTFMelJsK1dYbTNvRDVjbVMrUlEva0ds?=
 =?utf-8?B?a1lhVk5oeXRSM256amNmeG92WG1zQVVxSmkwWVgweGxhOURYZ04wYWlLcWFQ?=
 =?utf-8?B?ajh3YS9yMFQvK3BvSHBvdUdoV1RmWFRqOVpyYWlTR2JwK2tVYkxLSGl2aEp6?=
 =?utf-8?B?cWhodkRvS2xoallDOVR1R0Q1S0FpMlhrb200RmJRRlhjL0FPdEJKUGxNNTc1?=
 =?utf-8?B?UGVFL0Z4dGJzZWJyWGRpY29EK0NsL1VCQUU0YjFFR25BdWY2RXJxQWsydHp5?=
 =?utf-8?B?YTV5ZFE4aFJnayt6QjBoWmtNUThodEF3ckg4bFFqT2pJUTV1WWE5SjhMa3dU?=
 =?utf-8?B?eG9mbU5XTklrVFgvZlFPUjZlV29ITFFBYXB0clh1NkVKdVBoakFNNEIzVysv?=
 =?utf-8?B?dHJHTkpheXBOeEx5aWFMT2tJaDhvMnp1QW5ncURhakFHNmFWRnJtQ3VxMXFt?=
 =?utf-8?B?TjlFZSt2a0UvWWc4a3ZyZ3FjVEpudmRYanlDb2pkeE5iNGw2eEdFSWt0QWo5?=
 =?utf-8?B?USt5dllFbzNXNGVqaWtVNUdOcjJabnFRY3JYalJWV0MrS3NFK29RajU0bGc3?=
 =?utf-8?B?OUhuZkRjaWV4N3NkK0RQMzVHZTc0NDNVeUZ3UEhwNTNRenc4QnlRZXNpUDlB?=
 =?utf-8?B?Vko0dG9vakNmdUhWUmFyTVIrSDBWODVzQjNtR0pPK2JkRHYxZXB6ZEc1YlJV?=
 =?utf-8?B?NXRiOHBpbUEwcEk0L1VmN2g3TUh3eGhNeXJDVng2cmdzcTRmcFJWbTFtSHo0?=
 =?utf-8?B?MytDZ3MraHp2MUZrNnIvR0F5b216cSt1eVZEZzBGQVFZeVVZaVFZYlZMVVJk?=
 =?utf-8?B?TXoyV0NCeG1sVE1xaXR2VlFvNk9XMjBzS3RuU3VVT25Tdm4wVkZHRmJ5VEdS?=
 =?utf-8?B?dUJsQ0R4TWExQTZ1d0FKYkI4VXZvdlRRRWhlSEhCeTNaTStSeC9XMHFzT240?=
 =?utf-8?B?dzVMeVlLRFl5SUVFZE45bVIzNm8zODNUc2dsMzZ0UUszYjE3WkNpTnN2UEl5?=
 =?utf-8?B?VTlVelg4S2RlZ1ZMSXZyRkZpRGtOSGVZWTloODZsU1JXUlQrOHBkYWpQWC9v?=
 =?utf-8?B?czMxMDFYVjUyV0pTbU1uNUIzRDRwbVNBT3lXSnVFUWx6WDJRc2s1WGZ1ZWl4?=
 =?utf-8?B?TERYb0k0SllGbnZXVDk2Z3VyWjBFcEwrays0SDNPb055RUN1cFIwSGozV2lG?=
 =?utf-8?B?Y1FlOTNFM1BjNDNjcWY0K0V1RllGa212YU8yTlBMS0J4R3JlblNySiszcHR1?=
 =?utf-8?B?emhWUDVrM25tcEozdEs3aEJIV1RiZFhTY2xPV2hDOUo3RW5LMXFOdjNaUXlt?=
 =?utf-8?B?cDhGN052MGZoUjRnRXV4NkhKUlptOTF0ZTNOakFzdHhod3A0YVNnVVcwR2tD?=
 =?utf-8?B?aEI3bGkrMWVsekNNTUVzR0w3cmVwNVgrdzJHdlNJT096M2FhK2U2N1Nsa21V?=
 =?utf-8?B?RXRkK3RWUnQ4NmlXbXE4TlRybDZobVZPMStUWm5VWG8xVDlJUklhZURuUldw?=
 =?utf-8?B?NDVlUnZRbXBDMVY0U0l1TVhPM0RYbGpsRFg1WXh0TUNtTzBJczRBRXBLMXVN?=
 =?utf-8?B?YjdpRkhnMDNCT2w5RStITzJ3NnRRMjdHVzdqNHQ2d0tXcTA2RE0wdnJTRUQ4?=
 =?utf-8?B?a2hiWFQ4NnVrQk8vRjA0bFNXa0JMS1l0MllsVzdrS2dXdk9ORXFTOHZ2Tm1N?=
 =?utf-8?B?QTZJNXdFdnlJeGR1UFBYLzdkL1NVQU9VUHY3a1pUQ2YvMVlZZXdLQXRqM1Bp?=
 =?utf-8?B?bDlHbkYvYXpaY3FlVmdub3dsaUVtVFp0RkhUQXh2WjR4VDdidlBEbGIvTDB6?=
 =?utf-8?B?TFBiSXRPRS9uR0NmdjByeVh4R3dDTFBKN3IxQlcrY0hudHpFSCtiM055Y21l?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7042371-3832-421e-7eb8-08dbbfeb83c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:24:05.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhFPc+4+4aCKIsT+qj1vQIfI94X2V2NCrzSrR5JyTth0I7pgYYVFkKCVzILAQs03ffnyz7DWbJKLHmKhPwWhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6754
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 06:24:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13240

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=9&day=28&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/09/cip.2023-09-21-12.03.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

