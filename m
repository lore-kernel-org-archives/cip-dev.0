Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092DC7618D
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 06:12:23 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.58])
 by mx.groups.io with SMTP id smtpd.web11.152172.1680761535919205852
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 23:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jn0mXnh4;
 spf=pass (domain: siemens.com, ip: 40.107.7.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC6p1DUt9USn3Kusy9nKb3hm+e6BAL1hfgJp6YkAW5HC7bieqt8fUdwrbnkNtGeUp+Xcoga3gbKYK8ngxhWSildEs1dJldOjGzkafiHFf+3jCxGP2SW9eNQAzO6NmUReggNJ/bDayXyCmaztdgPK8qtaT3S0uAbF++9dankDaX/ImBuJHzusQW7NJ8nRuHOxEigqYXutobAAvvPicqPDGJaMXJd7FuA1KtsPz/Hvngr6a8HOfjQh069hqCI3ANQnjuuiK0wwmppSjx5LQkTl6dyhf464fK9C1ffPTEs381tUFPPrYz54S4fur7zHit5l/XwzQbDDdX8efX3XDHFqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHWlpodYFBvaIWl5GyyJZW4LWjIbn5Pna2b+PaTraVU=;
 b=lXM6OdrOnBfu6hJy78hqdl7srSX69YpVhwspD3d+V4xidc5q8HWjBhjAhSdPoyAjh1I+KLkMZbOLzEvWmKX2oUPDi/8x2QLDGmjIFdgeg6KSmyYhSCcwfKlUFnX2ikH8QMHNRlAB8pVYRf5fqvFdGPT4G1ii2foKvbnZXYB0+x3RETj1PsO0zy3HC/NsdpLErwztiWPAWodqLAez61ZyUAHeo+W6amPpLEtsmWbFDO2dOyQLJoQDuM1YIj7aRii4IsJcB17GMmWTUps9WLG8JWALZ119F3buttAci3ieuhara5K67noZZlBMs91OrwkU2H9YjJhM+i/pznZBfK/Hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHWlpodYFBvaIWl5GyyJZW4LWjIbn5Pna2b+PaTraVU=;
 b=Jn0mXnh4MTv1kAhCI+ioRDV8dtti/WG5QjluKTHWRq5VkcVE6hKZ1F+jMTNlUIjvAdX1FnAEfiRD0ptOw60hKvnyaNEs218zp0xs7hcKJRLwLhwwFpQBgaMxHcCURsajM6XDg6cieo1KTUINVRU16F+7iIAQ+4hm7xakI1ikrxdPyGd1dpqDjPqV40xdyxVxratqqnVspmRpu/+TMfG49+ssIVe8CRgtASSHr1vP43aiyFLaaAaJZeEh+dw3xZ3wI2ryVRJ3US7khHsWiwCWi4Mb23BIodGv5oYpHcSp7ziNsmtZPdFAb/LuhTLzhGHBFQM4NaaAvgBjXNcmSsKb3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Thu, 6 Apr
 2023 06:12:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6298.014; Thu, 6 Apr 2023
 06:12:12 +0000
Message-ID: <4c5b64c6-71ac-a3d0-1881-df583332d04d@siemens.com>
Date: Thu, 6 Apr 2023 08:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0274d3fb-6e2a-4d19-f752-08db3665dcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HFUDSKoUwxMd5ZiV7HhfoLbA2Bp4F6Iyx32ofKzcZWxj8mqs9e9JQ+F+3EgbKiizqqUfwf4QTnAhUm1GbMRHsC+5U2WMHTTBx7q45O4naXxtz8fsBo+hjQIG6fxW52oX0vWGfIZPWecSJFKmHGYpzZ3lR9GslP1qgRgdQM84WYRGzCKNQ+6xsE2Nzz+Eq0Mlm2pUf6UUVZ3Fnkt7M14QjP8WFmM4WkaXDj+Xw96h8r4KOudeB8404ePILaUAAGdq5InP4a0ezABLwk8AINGpJgryNaSdencf6tRgFQFrCUKjOr9F/m5D22KdRAtas8pmO4ueBcx8lkIDSjn3xmOPGdeB7ChLi6+me0IhQYsIokVWqdiKcHZGsUwQ+i3nGCYvcU7D0KlFh/vnPUv34sQRNqj41wpg5//FPnZpx9/VE3l3aRWTLfUcuuDXEtHmzRO6fw3VXPYPjIwwa5OoeYyo0fIj62DCulUSW1DwzR30FPxT+SwttVEjFvgevFeNWzZ6SGH5C/L6VOh2WduKAIAHoPQRsJuz/bfQ0hjoN+qGYE2LGtWcRiYX2l/yeDztVNDCA4gfBrB58YtIDANOVK+s38zeuE9jw/5mJ3f4yftwqqDfQlZZxywOMdywicdkpzKzIrHqE3ns8XOrdvtvo7DIcoAYAQtqlyVGZEX56/kVNxE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(8936002)(478600001)(4744005)(66556008)(41300700001)(8676002)(6916009)(66476007)(5660300002)(316002)(82960400001)(38100700002)(44832011)(6512007)(83380400001)(966005)(2616005)(6486002)(6506007)(26005)(66946007)(186003)(86362001)(36756003)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3U5dXEvQjVBWGZQMTlzU0lSQWEweFdCc21hY1RzLytPMmJSNldpRHAzTzRp?=
 =?utf-8?B?VjRwMlBZS1FiQUhBdEYxdTlDODkrYTd3Z01lMmNqT2hacHB1bTdUMGJsTXR3?=
 =?utf-8?B?UFlNS0dRTXRUM3VuUHN5ZXZWSkZReFI2Z0N0SXNvTVFuUGlLL3FiNzVjb01V?=
 =?utf-8?B?TzBBQVJja1Z5ZjUvNHJOejcxZjBhT0tXZGRlZmFMWWVEbjZtS29JaWRvakNy?=
 =?utf-8?B?eFI5OFdNbWphODhMbWtUR2VmQkdUd0FqZ29iVndmWmFiVW85WFMzazBsSU05?=
 =?utf-8?B?akJxdytsUU1oc1BiSlhub0o0dGNkT2JlMDRRMUlaRHZmQlVyRE14QTA3RDhW?=
 =?utf-8?B?TW5CaUNaak12cXR3YmNEU2JhZjNtRUYzb3pVNE1hditpckQ3OHVlQnRUTVNO?=
 =?utf-8?B?Zittb1Y5djZCKzhUYmJxajUzVXpzbGh5WXRKN1BvbVNGTm9TNXNOaTJremxl?=
 =?utf-8?B?bC95dm5FMy83TkdDK0ozZlZjZTk5TmYwK0F5di9HbmxKeWdKMkd6c1h1RXMz?=
 =?utf-8?B?NmV2UmRFNzhqam5JcU9nVHNqZlA4RmJmUUIxQWQrVW9POTl6WFk4Unc4WW9T?=
 =?utf-8?B?TFB3bzZrYnFhUlQwdU5WeHNXenV0SExmM01hRFVFU0FOKy9VRnVzVTBXdTNB?=
 =?utf-8?B?aEJFNFNvbStrUmg3TkZYNjlDeng0NURtZkRkYnp4elZ0WVpoLzdWNk9nT1Nj?=
 =?utf-8?B?d0l1bzVXOTNBWDVyanJ0VjgwQ1k1cmx6bXhtcUxVbzBsbmJlazcyaUhyY2cz?=
 =?utf-8?B?MVJXYmcva3ROaUQyNU9idnRpclhMZUVvRGxPaHUxZlh3bTV5THUyV2VkaytM?=
 =?utf-8?B?TUJDODV0bFRscHpZSVBFaVJrNUVpa2RmK1M2MzUwaWxJQUY0TmlqZmJtTkcw?=
 =?utf-8?B?UDhySUFRbFh6Qm41cVQ4aEpKWmxBamlFVzc2MExybkc1Rm9jZG1BTHovSnoy?=
 =?utf-8?B?WU9HYmRTd1h4OC9MNkhjMWpvZ0d3RHR0cUlXM1lRZXRaK3NsMmpLVjhpV3Ja?=
 =?utf-8?B?b3hjdkV0RXBKQkxEaVNUVDZxdjR1eEVNWllvbkNlb1dtNjNvWEJoMFYrVHFy?=
 =?utf-8?B?WW5ES1lrOWE4UFp4cC9RNTIrTHlCUi9TRnk3UzZJVFRvVEdiT0Z3Ti81UHE0?=
 =?utf-8?B?V3RqUHQxUlBJcVdkSmJ3YVVZVWhSNjBESW9QM3pvNFY2ck9QSTNSS0M0RFdR?=
 =?utf-8?B?NnpFRnMwdVFEVitNQ05HeE1CNXlzclZYaFRYRStUQkRTT25aa0dSYnd0R1dN?=
 =?utf-8?B?RFZ1VHNvTFlML2JIY0hnVW9QV0dGaHNnSTJYY2V4TjhRaGo3LzIxZU5HYkRl?=
 =?utf-8?B?UDZBbUhCVnJ5dXFmUm1KTjR0OGNuM3V6QnRzOVB4Q1QxMnVTbFU3OWxzVTdN?=
 =?utf-8?B?L1F5d01tS3BYbW04MzFsdkQ4TFZqWGNwZmJzUTUzQjA0Zm0vZmJ1SmFoUmQw?=
 =?utf-8?B?U08vTHVoMTRGcXcxQ3Y0NE9wa0hJamdZNkJaNTJiMDNzUE5UQk5HaGorazFN?=
 =?utf-8?B?elBtam5kVXFMNmlEaU4yeUQrY2pSbTVpT1dYUkkwRisvTngySWZKZ2RNZDBp?=
 =?utf-8?B?bEd1WlJhQUlzUUUvbFJlK0xPdFU2MUdrMEFyRVE1NHFvQU9rU3BSaklmV0ZC?=
 =?utf-8?B?R0pIaktBZlJCN2p4Q0l0bnVEaGxRK3M2aXpYUzVseUE3Y09BZ3pkZTk4bWg2?=
 =?utf-8?B?YVBlS2hxeDRpMUdTUE1wWDFnODlsMWh1UE1lTFE0ZGVYRHd6K2RzVjBzQ3RH?=
 =?utf-8?B?YzdLRlRidWk4MHlxcnlOcTFybmw0NjliOE4zeUdSQnhNVU9PODBRN3lpaExW?=
 =?utf-8?B?MlFoaU16elgwT0pHb3o3citvUjd6a01kY2NIamtYSXEwczV5WXE3RHY2aHVE?=
 =?utf-8?B?VXRYQmN3VUY1WXgrVXFWdDFQaE9JMXBpN0JSM0VSalFPWTN4cCtIUjkyaDVi?=
 =?utf-8?B?SmFBSUdPdTVzWGo3ZGZSYTBoMXR4SktZVkhkc1JVZ2FKWnZaeUFNU0xJMVZi?=
 =?utf-8?B?VmpKaTkxU3U5RWVtMFVDQis0MnM0amh5SUZ1OXNGUlRmdFZxWVdyVHJBTkFo?=
 =?utf-8?B?dDBKRy9Cai9vQlZzZnVJWHhldTFFNkdKdTVPSHhNU0k2REJmYjZ6TnIydUxY?=
 =?utf-8?B?SjB4dVVOemhFeVVUUDluejFNaTRsL1ZCcWZSbmJTT1F2S2crZHFXVWNCRWpM?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0274d3fb-6e2a-4d19-f752-08db3665dcc2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:12:12.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7PZucGvd7qjI8WQHoUkd2YM8VNj/yHFOretTWE/LBx3+yixxKxLdW1ptswFusOWuOKKugHiKF+qj7koPPUbHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7733
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Apr 2023 06:12:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11187

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00 (!!!):

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=4&day=6&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/03/cip.2023-03-30-12.01.log.html

* Action items
  1. reach out to Greg regarding LTS (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

