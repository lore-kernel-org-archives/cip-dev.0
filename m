Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB246C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:59:24 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web11.119077.1699527554063753245
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 02:59:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J/G2swFw;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+r9k5U1+sVWrfAuUFCT7uHoaXs9N28Ge+/BuOtA6Y6fnE40LQDRqyfySSotHUMdfyC+q+E/IRZJRoMPG+Q/wEBnlHvQUM4jXqCjyyAq2jg6p1fD2qQcijmwSTT+ghGt/xQaqgGQ9PckMva15Et9sRqetrxHt03b1ZbnRec2n8H1+avyHbdA3n2U3WS+bhuSwNeEHMBunfcPQwDnn6LAovJes46G0sARygYiH0+daBwZs2K3Rr66HdzR69A6m+04wkl+KdwnIOC+dhyAAepguWybWSdrcoJiyMKOMleD3BfmGNV23BCAtOhq5ZgmMFhVEYu80WY+3XJrZjTNGbmNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HohRWpChwphduq1H6+HVBGnMDGNTl3GJAY9etPk1zdc=;
 b=iRPBEnpFMdqsoSL42XuC/OZzmn8pSENUL+yOBFVCTVm3cj2DS32muNUzfzbd4RHzTBQmcexRmIjcEs//ym5bQjDcv9X+1eHAvUgtS/FKaBkGXKoCK1xygZu3VwhKFMe3pEfC0lGH3GHXddqbswiPRfTqFgz39Q551WC2WusQKd7RDlNpfdmhSR+ZzeGv/gFMff4e2rIcS3L8tnHbOM/q8mo/0hcwixPvhzez437YA0fyZkzGN2wBre6PcTeZznAhRbeePmisb0DU5kM0XSdKwLKOIyiaYKb596qL4df6fqcRYzkDZYwmu0+XUvaGzmBvTcasdIXYwu2BDcHXj7smkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HohRWpChwphduq1H6+HVBGnMDGNTl3GJAY9etPk1zdc=;
 b=J/G2swFwmtlim7v+TaYbMQhqVMrxUQgrB9ACPVlVopO1l12iEhrZInUh3Gs5mBny+N4YrJc9DgjsN7AgODmRVR1Lfl53tyG6AQS47ajxfM2u/GkY7MgpIITcV1EJlifvvBJrTC7iGzGfo8cdEGNBEeRUNXb/jHIO94FQrR6V0lbi3kDdZiYgR9L+eIZwbGb55CNEOi31+H9gqV2KuZ4UIaalSARPTq/Q9f6rmq3I6iZAMWLMbfhdPBPTc858t/mHFLJNdavio3TNU1nLHxilrORrlUXmFCLx8K/7lP7xFt1kAv0tMD83TnkmE3783ibVtfQ5Mw3opbGlP93O6U48gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 10:59:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 10:59:10 +0000
Message-ID: <9cf0706c-be08-407f-8eb6-4cb8dbc11df7@siemens.com>
Date: Thu, 9 Nov 2023 11:59:08 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: f50583b9-2b28-48d1-2c01-08dbe112e72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lfoceb7sbh6Aur4BKqLFsBBsX+RVYsTB87l0K980sjVtz5QhBKmTvEv79N1nTBiz2zVjQp1L4QLc8OV52zC6LAKD/gNO7i/i2Fs7Jex+Oq3EbUV++1EzzU3pNvyBNk5H4eEfiRl4xRFHZkyu/N5vlspjtGT6ZplSicYEDsGE11EMwTsKTIOkRY6g55XKBaCxqQRbomBJ1lOh8NX/XSSWenUZnSWFxsbe+tS2DNCcep+sYjkl364S2rektgF47XO0R1JvjTu6bicNfkua2Zg7tuotzqMlwKKi5qMpH8qLeXGMkawyxXhOvG/V3nzDzxJ1lkWxd48I82Bi2NYWLm+QRKCrL5kQFzgDEBAzKRNsXdyku3Y2q4p/dtZie0jT7HQ6KgFRNYy+1LODGxGBaYB3HOsknn7fkr9tpKwhlFovRRBpxNj6FO0Wzewq6DqPAFRLOVQ0Ju9Q4JC4tS0RF7fshsEJbpveemCqsE4jbDckiynBVNHUlSxXCQfBJMG/L7hwHpAmk/Bk306qWfPuimPzBQDMEuzG98TuO1QQt2PTH+XQItvpivcq4HKwtYaTks1Vh6DZolAioL1g0Qr3e1yptkoR5Tl5Dtb4z30cJrLAxjzlZxSZHqZ22DGU0+9Sk2/JZj7srLV4VlVHgkI4S5RuIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(478600001)(6486002)(966005)(82960400001)(41300700001)(4744005)(2906002)(2616005)(26005)(83380400001)(6506007)(6512007)(86362001)(31696002)(5660300002)(44832011)(66556008)(66946007)(66476007)(316002)(36756003)(8676002)(38100700002)(8936002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K25WN2pQMDA3VzFOd3pNNFdVN3laRE5TNGJVV0dDaWlvTUFXd3JXbEwvQ2I5?=
 =?utf-8?B?bnhLK3E2SFBZL3RLOHBxV09QVWRCc2JheEs4RXNYS0FPa1A4SkNQZi9lZ1RR?=
 =?utf-8?B?d2NTVWpmY2VmbUZkLzFxVlA0VEw0dzlwL3piVzZNYVdTcHZ5clN2TGNlUUw4?=
 =?utf-8?B?RXJxUVh5T3MwcVdaWUlobkxIRHd0R0FwTlorVGkwVG5rQXJxQjR4amd0SGZL?=
 =?utf-8?B?V3lVbVpqZDcvNHhNSVFPaVZHU24vRkFoazlNUHV0MkMvV2Eyc0NZM2c5eWlD?=
 =?utf-8?B?MGdpcWJWb2hxVkt6d3BaVEVLNXR5aGtvUWhEVEVuVjhmc3lxN0xQQ0RUdVRx?=
 =?utf-8?B?cVNLV28xN0VvM05MQkg5SlUyWXVGdTFOS2JyKzIwN0R3b295dElPOGpRTWcz?=
 =?utf-8?B?WFEzRnpmdFVURzJFcjlBVUZVdFRzNjMrTjJQeTROa2wrTDI1c1R2Rmd0OWtq?=
 =?utf-8?B?NWR0Mk9jYVFGcERsb3M5MEh3OUNYMHhwTDh6ekI1T0tkUldZTHlEdEpvY1ZY?=
 =?utf-8?B?aVVzbTE3dVlEUllBNWgrcEFidHNuQ0VpUEQ5NU9McDhsckJHaDdqTklBRFor?=
 =?utf-8?B?UmpZcXorZDNYTW1OWFFmRGdXUWNtTEE3RUd1VytKYmJQV0lOSG9LVnNDRG00?=
 =?utf-8?B?ZndCaWUwZlcxYU9pRkErUDR2bTVRb2pVOHZQckl3b3BrRkJWSnlGVFJ2ejZa?=
 =?utf-8?B?L3Q2MkNaeE9xNjZtU2Y1akFGMm45U05CWEdwd1lzTzE2VFBDdEk4UndUWkpT?=
 =?utf-8?B?dkFJYkUxZVpIcGV3d3VlOWdCYWMxZmlJT0FOODJMZVpGcHUxOStWaVQxcU5Q?=
 =?utf-8?B?QVdqTWN3aGpIK2NHTzYzamJEb3g3dXlVY3B0cW85R2FsVmR6RHFOVXBCTmZR?=
 =?utf-8?B?WkIyRXUrNFNLc2lGdXhYWFY1RTJjL3lvTDNwNExmQ09HQ2FDek1GeE9zRzdG?=
 =?utf-8?B?NWhybXpiZDQ2S1AxSHBzSHRyTDhuZDNiU1VLVWdiaWd5TUZYVmpnTmdXTXZM?=
 =?utf-8?B?VjJRY1RIWlZPdXI4ZGlTZDlNUFZXRTZLamc2ZDF1VENGaFErQWlrSVo5Qit1?=
 =?utf-8?B?b0I1aVZsUDFOb1VNZE9EQk82UmxKbit0My9DdVJnZjNZRGpTcnRuWmg0RXlu?=
 =?utf-8?B?NG1GeDBMakg0T2Z3ZEJzMzZhOTJHTkVpcFpnaXVpMm5ya0FYVW95ZkdrSTJK?=
 =?utf-8?B?SDNtRnh5MGF4UzVNM3lFTmVGQzV2YSs0T25pVnlQWkwrbXhEMUlxSjd2LzR2?=
 =?utf-8?B?aGFuUDh4Z1FUeDA5djhQd3owSlRCK3NoelVJZklBd21ReFF2RlVEWW9nUktp?=
 =?utf-8?B?WjFRTGF3ZWpCKzFWeFFDa29CaDZPZW9PRWhiN2RuTVU2eTBScjZFRkMvNTEz?=
 =?utf-8?B?bUR0U1JQZWx3R2ozZmk4T3JmeFI4bzRKdTI3ZWNaSE9wZnVkeVZobWtTUkox?=
 =?utf-8?B?MjNtMjNpY1JGWjkvSVBoTmdyWE5JTk83M0tTTTFqeVFoSWk2d25VdWRlV1Fp?=
 =?utf-8?B?dzJBQS8yM1kxazl6TXFqQytUWWRXSCt6RkF1Y0FZQ081RHlvQmhPWlhybzl1?=
 =?utf-8?B?ejJmTlZKWFRXaTE2QlVXZVdpU2QxbWtZWmk2R2hxYzJCUXU3SUdNdDE1YURs?=
 =?utf-8?B?MUVBOGtzYzErMmFkVXJhT3RQWFBzd1pRdUg3d2NYTE1Gc1JjNFZTVWJDNkxw?=
 =?utf-8?B?aHczOTltYjl4Y0szZEZlWS8yS1RrVWZWWFlPZ0ljWm5lbXhTc3BwTzV5QnpM?=
 =?utf-8?B?Y3ZzcEh4MnUxaTB1ZW93ZDhqd3h0TGxocXFwRStUdk15d0Nid1ovaUd5Tm1X?=
 =?utf-8?B?Rlh5U2grVjZzbjB1R3Z6NVY5eHZEQU5FQ3pXUktYM0FvamxBV3RNUStmTElj?=
 =?utf-8?B?YzMvS1ZRdldCQVNLZFNhSyszeEl0KzJ2YURnY0ZFUXlPbXk1RlpIV21wU0s5?=
 =?utf-8?B?YlBISnNDeXE3UGpXb2RRZ1dVNzhGUmE5Z3k0L2VkZ1Z2Tk54a3A1VU9wdDhx?=
 =?utf-8?B?WDJmZDdjZGpBOGRMTVhWT3l1QUlodmNEN1MwcW9zcEdxNjdFelc0TXRlSldC?=
 =?utf-8?B?V1BGZFh6ejdoQ1VyQzR2WUIxQUtML3FKK2JUbDE2L0hFdXZ1TmxIWmFOK3h3?=
 =?utf-8?Q?dG3X4oN6/ZtCHGQGfCqjiq8Ai?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50583b9-2b28-48d1-2c01-08dbe112e72e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 10:59:10.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPGh6NmrYbo9VVaGVw7bntFyi/tl0wV2gqNBhlRzPxUV/Fcx8LRZ1BBXWsSqN3Vlv5ylFvF9SyqA9T9rFjekGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 10:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13547

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=11&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

NOTE the changes due to Europe moving to winter time and us following this.

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-02-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

