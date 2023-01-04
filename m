Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E864C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:36:03 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.57])
 by mx.groups.io with SMTP id smtpd.web11.12059.1672839359424915862
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:35:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=so8FCNBo;
 spf=pass (domain: siemens.com, ip: 40.107.6.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNDLKUjkoy8Yf0EZLH58qBLJHHnjIZ2aamt0JN1zVXgOlFQxSarlxc94DPLibsRhhwgISe7vSJODtxyx/XPCRnIIE+lH7ZKJclcZaq3znt6ZBWqOurRcZvz1MISfL/lnq6cIa3QbADLyfGf83Sg3cjMQIRvl1/URUbamvBCYxibz09ryhmy7MxRRI5iZlG3W+JISfnHlgP6AKDJzsGW1yzXWTT3HWGz93kC3O89PmsU0m1o+oAVQm4QSzubtoUVCJVBOAb58uZ57fQTOZ529IosfiiqRntkh9JEkEyPGBLkTf/xPuZzL6HvJmlvo+Vs9cuCPuZx5bU89ukgmCdb23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXCOuNbXwKFRYbUi+/ghwNBOcQjfp8zYYDdlTLhhR5I=;
 b=cOUM84u0IazEpEm+Cn3E1rrt95LL2AJqjMxuT+gz+HszuOfIkxK/aPr5cZhW41crYD0122Cxm4VEsb9TpBCzL9M+puBY3PH7jOkimStx3ftV5kfgvYUFurgSKp+vG6KHCsO+peLVWsdkYkdVGFeO0fCQ4uEDpWFrHrJg3bWYnUVh/7ebCT4R0Bf/DPmicd3liX1W+jdJYthQ2P4SGiup2YTaQQuKr5E2kp7OPd3cyNn1SlxUSNmalbRF/H32LX92smjfLYeAZHYyha0dsNH91Myie/K1xIU1vobLF4duS32F/4G/O9rRNzmBPsxgtkt0K8JQtgj/vB5I6BIbJ79Ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXCOuNbXwKFRYbUi+/ghwNBOcQjfp8zYYDdlTLhhR5I=;
 b=so8FCNBoryTnDjW58OeE7ykp0ZDpuXGyzaTqDrAq97JcENRvroBHAQAyOPRokgasgKdJWJPaE+fbqTjpBQpVYA1eqYmFmtpI2jn/sTVlIGM3YZCu9+b0MLx3ibCYld+pMMJu2sJfVQxbVcNJRi0KAiFER/82gNORRtdfZNZ4pU+H+MBI1PpJ5is7vnpRFEMmLDvkuDf5zziML475aHfmI92vMi0nG7Vca1ilDyT8nZjr6xOHmY+B7b6v4sJyKUd+N9LhyHbdjw4OlqwPjXnUCYhDnjthDdPihZr0Gk+IJjmlojr2AwEYvdDMUFi7BsOM/+zQ3G4o+gkJiDUzQSu3zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:35:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:35:56 +0000
Message-ID: <69ad7a27-f81d-cb61-0bbc-747c3ca8bfc4@siemens.com>
Date: Wed, 4 Jan 2023 14:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH v2 0/1] root home dir package
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, cip-dev@lists.cip-project.org
Cc: work@hennsch.de, Wang Jing <wangjing@siemens.com>
References: <20230104125103.9089-1-work@hennsch.de>
 <20230104140251.52df8822@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230104140251.52df8822@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c0d2d-d865-4812-3706-08daee589bd8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0ebyrohBIU3Vj23yynvqd+En9G6twXYLND3mPvOefdwRAm1IOqCUam4pBdqH1nVExU2WQ8JdZ1xW8rdcZCnVXoPrwUXeNL+d5k/RSZewlDH0YRM9B+YJX1PxKAFTxkmhz/WfAHaNgpkR1emieGVevpwv8HMgTh+wDc+lVLWFDnP6nI6Ykk5fvNxqBPz16PVjt9oaujq3FmvBfBZJYvC+0JaoHxU+z4+AV+qO85/XuNzxhHYfRQMlvlrDwWIcLNVgU+HfH2qUV9lWGuCVeYRp0xB5SxcJo5ryrtKI0TaLB/3AruF8B/6ToiF1lZg45g22glUkIs5qx4mcLGM7/accH1tKums9qjVEMHLW5mlrX9eHRIrUZbl7WcNnhfzZokjlgNdz2r6U8GaMk3+3YoDtlKGNRAnnJPU7TCA5i1YOxSqvTYtN15hz4kjSm7dx7iOSl93QxahK1MlP90bhzq8g4/UTouEAqHjV1StatjMO1CM4p5AuVHOjIDe8tU6zaRzKhrK7qgEuf32E/DzEuB1FA0xRAYQZBzWs8kMkaaSPQ+RNbIY4pNP245tIVAi6deERoObwSjWnge3Njoy3wkZfDYBF7MXl8DOCNLewQwN3BrHrsmYQOi8985TJLH6ezXpmOrpU6Ciwst8qnXS8GRC86ex15q6r4Bel7ZVa5LCdxecgr9Cik+Oyg/RVNc9NekoGb6vfshdhUMM8pFjfe+Tx8WF6aEB1ZN8zndBkmLwWKaw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(82960400001)(36756003)(31696002)(86362001)(38100700002)(6506007)(53546011)(66946007)(66476007)(6486002)(2616005)(66556008)(478600001)(6512007)(26005)(186003)(107886003)(31686004)(6666004)(2906002)(316002)(8936002)(8676002)(4326008)(83380400001)(44832011)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2dxb01na1lZSEZvU3Rxbk1VTVZJNDJKT3YzbDdOT0d0eU1MVnc5bE1ncHZO?=
 =?utf-8?B?RGIyTys4NERqUkp3QzQvUmx2SFJmTDFxWnVxSURiQjhXODdVNmpsTStRS1Ax?=
 =?utf-8?B?ajJGMDlBaXNGREEyTkFhQlNNS0VpbjliWmVGSldZYTl6MjNEWS94Q2w3b0Fs?=
 =?utf-8?B?bkYxUG5PVVZrd0x3OXFYQ3ZVMnBsbytucCtWbUQycUJ0VGk4Y0pNKzR1dy9z?=
 =?utf-8?B?by9LQ09qUVRwNW9ydVVXTHU0akV0aXRDN1A4NkNLdFBSZWNHTDJuUVFNdXVN?=
 =?utf-8?B?NFMzM3lUYlpPSzdOSDUyck9rYTNqSXhEUWdMdFZlSVBkb3M0UWg4YitSM3VB?=
 =?utf-8?B?UnNHa1pHSmFjSWRqU05BcDl3Q09SSmpLTFYvbVdmVHVMRGtKKy9LczVNUGg4?=
 =?utf-8?B?aW9uVEpsdjM5R3VJVytlajM3SnRNREh3UXUzTGNjRjRtbEZIdjh3TVdpcnVQ?=
 =?utf-8?B?aDZIWFplekFZQlhRTVpwY2tpQVd4UHR5M0xzR0VRT1oycEw3aU5WcUlud2JI?=
 =?utf-8?B?eERoRzFsd2ZRcDhBWDI4cWRmNVRWM0g4cHhTUkdVaGNrbGM4MDJpY1JtcWhR?=
 =?utf-8?B?bUFPVWkvTnIzaWVnK0h4d3FkcUp3MGVDaDhyRUQzV3ZNQld3RU4xT3hYdnNh?=
 =?utf-8?B?c1V0bW12NStQZVJnLzkvZms2Q3gzcHR4QTZqb0ZWeEZHQ012UnJXK2Zud0x2?=
 =?utf-8?B?aWhoWWE5bkU0S1BwcHJjcVZsMFJMd3poNmY3em9TRE95T3ZYS2ZtRkxRekxT?=
 =?utf-8?B?Y0RVK254cTVBSjVtMk1pOFBVTUhHV3RNb2pJUmlPdjlzZU1YMVpObjd6R21V?=
 =?utf-8?B?M0hESFFPc3JMSGI4ZmZoYW1tV0VqeXpVa0V6c0N0MmUwQW90NmFyRzFMRjEy?=
 =?utf-8?B?elhQSmtHTGVEb2VPZk93WnEvNlVEdFgvKzdYWEhwZHhXckJMUFJZd3dsZWxQ?=
 =?utf-8?B?QnVwaUZ3VVltREVNVHlFaUl3TmljQy8yUUszRFNDa2hvV0M0dGg5SEZMNW82?=
 =?utf-8?B?dWF0K1ByZHFrNi9hajhPT1FCd2h1dzBXL1drQkhYc3FWUE5KSVpRcmFrM0Ju?=
 =?utf-8?B?am9zZzhjUTN5SG1Da2g1UVlWd0dEM1ROcVpDTzVxb0piUVNSTlkrbDNEMSs0?=
 =?utf-8?B?SnZWKzdWQWo3MXZXbUUwemp2UllQbjQ2UXZqYmlKVVFzMlRidzMyN0VDTW5F?=
 =?utf-8?B?YWhQL0o3cDlSdVlsd1orYWVyNGI5dnVqRnJ6WWM0TkZZVVhzRldHWUl5SDM2?=
 =?utf-8?B?aHE1QVRGOFpnQVIvb2RTWTNTd0VZcy9wRkhiL1U5RzZYTGVPNDI1V25mc0Nn?=
 =?utf-8?B?ZldvamFyeGR6RVVsN3QwODErZFpObFVaenRVK2Q0S0VPUG13bHdwWmVPNWNa?=
 =?utf-8?B?S3M1RmVtenRpY1FOY1l4MEZyV1h5dWRFSVJkNldOdTJjUjcyZ2R4YWlEWHNm?=
 =?utf-8?B?anc4OE1TZmJMa3V2bnBZWTFXYWNnZys3b3FMSmdYMFY5emozcnpCS25ZZkJi?=
 =?utf-8?B?bEZxc2hlblYzYlNvdklkeS9ydHNyRzk2RTVtRnk4WDFyQnllR2lldHAyRktF?=
 =?utf-8?B?VzAzRk8zSGk2VXBNU3ZjVEVUK0FaYzZEcTRIWlBZajR1eExxWEgyWDNOaU05?=
 =?utf-8?B?T0FMVXlUakdpbHloSnNueGVYcXcxSCtybUo5RWRhVHlpdnRyZHhxaXc3eDhB?=
 =?utf-8?B?TU9wWEFNMTlubldIMklCT3kzYWtpa1dCWlErcWdWQVdGRk0va3hYOU84R0Rq?=
 =?utf-8?B?WnNkZ2VyWGw3cUtOYzJMUkNqMCtZa2k3VzE0NFZFOWZnQ2RCMXV0YjY0ZGtR?=
 =?utf-8?B?RXJhdXJubytKVDZMOEU3YmRzblVxaTd0V0cvekZNY0dCNWFqa0hud3FLb1Vn?=
 =?utf-8?B?OG55Y0tuQmNOa25YTHBXZmJLeVVmNjRERkQyWEwrbHMrS3BoWXhKYXdzUzYx?=
 =?utf-8?B?RjdwQUpiakRJVHNTOGdnYjQ2N3pNamtzUUEwcDdPVVloVTdsR3R6WiszK21C?=
 =?utf-8?B?K1ZUbzljUEFrZUU3QWZhSHVQWG1JNmRBQUZiamNicXFpaHFJNU55UmE3ekha?=
 =?utf-8?B?VUZiWk0wbzlyd2cyRzQvTmxrOXMyVnVBSHE3MFRSUFNLUTd5aHJkOEYyOUla?=
 =?utf-8?B?TmVzYlRva0wrTWJNY0lOMTR2TXAwYTNxNUx4Nlp3RmhMQUpsUnc1bmRGYkpU?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c0d2d-d865-4812-3706-08daee589bd8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:35:56.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b/XQxy5llJmJctnrl5zTNKLdHxv2/qT1c1ix09cTDH7lcC1I4a6CMl/kNMBTKGSFbwPR9J/bONt3Z8AnQX5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6892
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10313

On 04.01.23 14:02, Henning Schild wrote:
> I again had problems getting mails on the list, that is why i sent this
> twice.
> 
> Once with a "Reply-to" and later without it, because i got mail back
> telling me that the remote hung up because it classified the mail as
> SPAM. No details why ...
> 
> I bet none of this is on the list ... again, but at least using that
> other mail infra i got some feedback.

This one made it, even through to kernel.org, but not the real series.

Jan

> 
> Henning
> 
> Am Wed,  4 Jan 2023 13:51:02 +0100
> schrieb Henning Schild <work@hennsch.de>:
> 
>> From: Henning Schild <henning.schild@siemens.com>
>>
>> changes since v1:
>>  - add missing copyright header
>>  - update copyright date
>>  - rename recipe to include PV 0.1
>>
>> This patch is now coming stand alone as it was not merged with the
>> rest of v1. It is based on next
>>
>> Henning Schild (1):
>>   change-root-homedir: split root home move into own package
>>
>>  .../change-root-homedir_0.1.bb                | 15 +++++++++++++
>>  .../change-root-homedir/files/postinst        | 21
>> +++++++++++++++++++ recipes-core/customizations/common.inc        |
>> 5 +++-- recipes-core/customizations/files/postinst    |  8 -------
>>  4 files changed, 39 insertions(+), 10 deletions(-)
>>  create mode 100644
>> recipes-core/change-root-homedir/change-root-homedir_0.1.bb create
>> mode 100644 recipes-core/change-root-homedir/files/postinst
>>
> 
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


