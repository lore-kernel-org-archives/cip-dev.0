Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A5C4332F
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 07:14:02 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.83])
 by mx.groups.io with SMTP id smtpd.web10.10063.1668669240810894149
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Nov 2022 23:14:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g93LEZOw;
 spf=pass (domain: siemens.com, ip: 40.107.13.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU+k29Am6kJdgyD1nYDTpwAZrtIY2zoK3OvymxRwHR4DbgFiHDBT77VPQtW9ooMZt7eWE5FhhOrddxITccgiOneIBaBzYaFt522wUwI5y9CkTpW9Ay7E+8M9gafXvWtTLsGUyFoiQ6R1nbozxvkLeBYx1RyTeE1DFZhwkILdcskIxtQZoB14o8ZwwENJzNJdDEUTsWcoCvlVoc5jHA9P4ng++lgEK927GKdsRE41aurbuDfpN4zKFwO1AZcWV7ws/k9Jufqp/VWW2jP4+ZJ8gYnzLrIjIGKJJHdwaUje3mgcQlOnB7leB8qn5o8Ijh694wx3/ugwLxUBJDlvzX9K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkb0g8ZRogn16NwnEG76QwrAbU2hkww5HwP15oCGBy8=;
 b=WYc+oScVySR/XzI8bRUB2inmFEppsVyKdkZh9U5yPRL8A4JTB9okvwVGNTHl2Taov6dXSKtoPxGaKgvfbcI2c0hWnb6bCaMc91Vm0lYDM10IcsuhXII/n4MiXAK8UxNQplO8Hr3kWjbtlTtp6XILqnMjCj/FPg+OZi8aRtiXosT24dEDybmVfb+XscWxX7a2j22TAhzVY/OkLqMgKPIwn0UvdpHMbVofntg+dXCYPgI9VOyPPwKnn4haUEFCc9Rnm0qeLll2ReK28jH3r/DAOCtX8Gcri179DJ9OUQQJAveyfAg0B3DS0aIBrnPP5ZBXnxwF5VG6ImeHoVTnAFKI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkb0g8ZRogn16NwnEG76QwrAbU2hkww5HwP15oCGBy8=;
 b=g93LEZOwVMLiibylOh8difzm421e2lFaL3ly89p0gs3GiuYKKrVul7b6O9YpjLCwVARE4z/W/fsF89taO7JwQRXlAQCtW5IRzLqd4/SbP1+bxR6+Tf5EipV9cKERcNxaI2z4WLCv/qb6yocCVxlou/uQ2uoTxwItnr4Zg7tbTP7CrLZzoe33AD9GNUBnvGv5CKMYZ/PBFANnMNHJKlk0PYkfVMVBgZezymLW0D+raUDguxz6qvHQSFsXG/4G7pBJ84B4wog4bdtbbSv9Qus134VBKlaC7xYKSL/V0Fxb6+udDEI8Us3QEH8o3+GIBUVfjUn65WsxyjXHcXIU53se/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 07:13:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 07:13:57 +0000
Message-ID: <6f3e462e-c9eb-1186-09dc-1358103cfe31@siemens.com>
Date: Thu, 17 Nov 2022 08:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: CIP IRC weekly meeting today on libera.chat
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <4a37a4a2-f39b-0b31-ca09-f9f8391cd520@siemens.com>
In-Reply-To: <4a37a4a2-f39b-0b31-ca09-f9f8391cd520@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c32991-71bd-4555-8486-08dac86b4b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LpkahHePf7wevRdKiA64CHG/QlIY5js6XZV1EA30i8V6171qvc78lULZEtRP33gIY+AU7vnrVrAIScTAFghVExbPblI5htrKCVl+fsqd6EuNjSVreENoGgm4N441Bc/AaTZwdvTCTKVQZAgo1jVu2N34InVHizrZy1NonPMQNwLIydeuIlCJDwbqs59CI4izUi6AjIxAYhJhwD1F7SuWfpEfiqyAq4WjuOpsulDa+a4w65f8eaFZnpe1Uf1RN3uh8OJ0GAbxfIW3F5qSz6AvPxtJXfrT7EUSUjFdkh+9R7e7T15LVBXDiqvuYwQ+rO8aWaTONE2eQh/sqKOHqbFY0uUFJ7fN9SJ7NNw21QgVzrGgN1HmX3fBc9owtn+syxRfrCZ5/8rc7lTuHejVcixCVa5X/WM20WBRRQBGbrzjjhk6TiDvpY66TzgfUxSa6xDs+qWGs3MW7zZDKG1JfRXmPjEMHCiLe/M3HJ6hzskU47Fj/KC1ETWuT4IE83aXsHSh19jyDAwIcUbkCDv85yJnQjgQw2vEdc1yaaisav/AS6Blzrwf97NowLOlBehaucwLenN4yOSBXYc7Por3kjgaXaUdzk3GYD+J/D0asBe98N85oEW/yvF5Y1P6zFV1I/I4NP4FVihdxBi1vUWUK9X96sSxy4eCxUpBSfX4ICQ+m9sciydzPYTwxW0614ZnSsf1pisbGpyrntDxqHW7eGEGIV9XTVH/HH3ZVI+0ItgbHpQuacHF40jk7Y/97evnFThc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(83380400001)(86362001)(31696002)(6486002)(82960400001)(38100700002)(478600001)(6506007)(53546011)(66946007)(8676002)(41300700001)(6916009)(66476007)(316002)(186003)(2616005)(6512007)(26005)(66556008)(44832011)(8936002)(2906002)(5660300002)(4001150100001)(36756003)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVB4c0lTbmxVRHJlbGVBMnNKMGpOWUZNbFlCUk9UNUZNQnlaNGNybit6MkRh?=
 =?utf-8?B?em04dmU1V1RDc2NJTW85Q1NQbUdKci9LUDBySytoSzZOT2NHWUdtU3dGZ0Ir?=
 =?utf-8?B?K1pTVkdYRzdQMHpQMDMxbFhVL0NmbFFQaUk5dXRxMm5keGlrcGZWRVBZbDRK?=
 =?utf-8?B?Y1ViSEdKODlwN0Yxa2FTUFBpM2dNeEVjQjlWQjYvWWFsOU1kN2FsZnVxTTAy?=
 =?utf-8?B?ZW9OS1BOS09LOEREbVQwMlhpcTBmUTdUN3BQN09pRzdpaEJPZzJlVFVCYUpQ?=
 =?utf-8?B?WEF6Ymw3ZEhCRWViYk8wcVlpeXZhY2EzSFFZZ3FPMzBmUEdORzZIdkRISjBn?=
 =?utf-8?B?V0hmRzlaYXhmVzFFVG5mdFI0V2ZxbXVRUmtLekxvVUo5NDBLVzB2bnhrRFZh?=
 =?utf-8?B?bDc0eGdLVTJsbEI3Ym10SjhUTmk3RnZSMXRmL2JoZmUxRzdwajB4ekNUdVNQ?=
 =?utf-8?B?VVdHcWtrRmdpUW1RQVAwYmd0aGs5ZFhCNS9KbzNwcDhoYjV0eFc2UGFoNzJu?=
 =?utf-8?B?REdEalJHT1FhSjU3Y2Y1WDBoaEU5MEZBUFhtMlZ1QlNRR0dFOXV2MmxYYVQ3?=
 =?utf-8?B?cSsxVlpGZDNTSXQ2N2ZuQ3A1TjA4TkNVWGUvN0R4alp1dTlhaXhQNUFJczlE?=
 =?utf-8?B?ZW53OXBpU0FCOUpZalZKbWdkMDlNeWpRWlBIa2I2V2tJOURVVlZnVWJTUy9C?=
 =?utf-8?B?MmxOSVBieDJzUmVsSFROVGl4MXBDSXpiL0xRTkNGRFR0cnJpVjFMMHFaVUp3?=
 =?utf-8?B?K3dqOUFHS0R0bGJtTEFUZWpqUlk4U29aN094Q0VXMG1lZkdnRTFQQVEwYVd2?=
 =?utf-8?B?VEViR1VXbzlNQ3doTW5OcE02a0szSlErN0VpTVlWVjIxVG0xaGNCUmt5UWpD?=
 =?utf-8?B?SWhrLzVURGRKc1BtWkdMRFZKRVF5Q3BWOUg4Y2ZlNlJVOG5LVnpjTHBRY3E0?=
 =?utf-8?B?WHgyNThDb0x4Q3B2dnc4cUVFVUpvUlR1cEVIc3l6U2lWNTh2UnZCYUpGSExP?=
 =?utf-8?B?NzBGOXVtS3BTYURoWENBNkl6aXZzRW4yWlFEK2ZaVnoxUitZWERYMUhEU2hk?=
 =?utf-8?B?TlRrVnl2YUlBdEJyUTIxc3cwRXo1akhJVGlpQ3dDdnBzdVBvZENPd1ZJTDU3?=
 =?utf-8?B?VXQxWG1td2p5S1c3ZzNRUEpMVVNER0pxODhYdi9GbnN0RlczY2NFUXdGUWY2?=
 =?utf-8?B?MDNvN0ljaW9Zc0UrWjdFdVJQcEFzRUpJck1MZGR3R0M5RmRqZEs3T2lvM2pj?=
 =?utf-8?B?MlB2UWdrQTNJUm0yS3RORys3L3doUUVOdDdWL0gzenFHeTA1SXNQZjN1YXht?=
 =?utf-8?B?QndpaDB2N283dU5VMHZIMkpOK1lDc3c1cmRiRSs3dFpFdlNaSWxNL0JucjhZ?=
 =?utf-8?B?b3pzWWhsOUdybHNEWFdIRmc1NTdBUHF1ZjJwczgxK1ArQnlwRy9rWmdvVWJN?=
 =?utf-8?B?TjEyZEV5emxYREZPUWREWjRqSS9BaUFUZVFQbDdtenVNSWl3N0RVRHpVQ0ZN?=
 =?utf-8?B?QUlZbGxUV2hKNWhSMTJSNkh4UFVhZy9jZG9hS0x6RC9Rd0R6RGxrZnJTKzZD?=
 =?utf-8?B?YjBGRlJZbGZXaUMyblN3UEJpZExGelVXUnZ2VEJ1cUZ6VDczVWhSRms1clRM?=
 =?utf-8?B?bjZVQUMybnJrY3h6MFBjWk1USHEyeGRIbnNqd2hyUEZ5eWJIVUluUjBLdTNk?=
 =?utf-8?B?QURWMkF6RUIwSmFtUnY1d3ozWU8xZ2N6MS9SM3NxMTJSM3JWMitGK3Qza0pa?=
 =?utf-8?B?SnZBejRweXE2SjU3OTNPd3hpQmZHNDUyRUlYZUM2TG81S2hqcFdvZ2pCSVJs?=
 =?utf-8?B?ZEFPV3VUdjdqUnE3WDk0YlRxZnhxNDNnQXNTZm9zNFhRYTlMTkgvVXp1Ryti?=
 =?utf-8?B?S1ByREo4TThTZ3ZJRFlnTGFkOEdZZ2F4Q2w5VjVzYi9VY1JiZHJpTTZMQ241?=
 =?utf-8?B?RFJoSW5NeStMN0RZNXlmVWl2RDdOSVAvNENzNGdTVndyc1BVczFKUWxyK3Ni?=
 =?utf-8?B?REtsUWJQTkZNTlFRaVdrc0w2NDlZNXpzWTVua3pGeHE2UkoyVE9tMlNiWEta?=
 =?utf-8?B?UlhldjlPZnBxNVBVa3VUUHVNZlBEbGFSQlI2bFlnYWVlZWJ2dEw1MVNJam9N?=
 =?utf-8?Q?lfCgeWq9jJjm9i/6mVfPRIwlO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c32991-71bd-4555-8486-08dac86b4b11
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:13:57.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1uqM9HFOugXtOB81uMjMLRyEiwCNAXrTV1tAkoYLNJL4nVgrDSyXtyjkv+DIwfnrApiDKRXUnEs8u8tflikYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3654
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Nov 2022 07:14:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10052

On 17.11.22 08:10, Jan Kiszka wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=17&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     12:00     13:00     20:00     21:00
> 

Just checking my agenda for today, and I might still be stuck in lunch
break at the beginning of the meeting. Please start without me in that case!

Jan

> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/11/cip.2022-11-10-12.03.log.html
> 
> * Action items
>   1. Add qemu-riscv to cip-kernel-config - patersonc
>   2. Create MR for disabling smc test in qemu - iwamatsu
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
> * Kernel testing
> * AOB
> 
> Jan


