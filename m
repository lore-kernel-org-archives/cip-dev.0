Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D057C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 11:08:18 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web11.8597.1748948895539125857
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 04:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uUE/J4O4;
 spf=pass (domain: siemens.com, ip: 40.107.20.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgbe29mwjyCUwnVf3lN+TR54HupY/1vPSUfCuCUwTrZedF3BUZReC1QoP0FSet5LD86jd5dYpKO33cDltn95FAwY3jsWgDqdGZH34VuQdIC9QZ7ap7EBYpWRYsuec+YzVfkEULZH5FJEel8lPIYm/YUqC9QDeBw959a4sq67SfrcdzJtzIxpFftkssNCvP7rSkEHGNrUUtu708GyVv9Te5WzzLYpzC2tKAw8CF48/2Bdlxo7r9pLChiwEymNFO39BfCqXvI02wdZrkflPDw8iPssJpzl/Et6NBZqZtylS+3ydXEhLSWcrKpZV+oO2M+VSXjTyRvYhoQIZrlRI1JaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvCDqAeYBCsus1Gyt+AcJZoZENzUq4sDO4Hgu/nn0mg=;
 b=cO095ky0So+lA/WHpJPtbhAMqCYgqDNcwxJp30cq+PfujpeLFm2H8nn5brtsH3j/xI9kdc9g8+t4sTbW9xkcGjGTMdTdhn2M7LmwVU375WORvtbzczzkhyTWTzA1hiyHdXCRhHlgJasbEu0ppMzd2uBmBW3x6Huood+auRizO73b6LmbeHj+Hw7XZSYr0wxKJgymDhn+P0xc/AToHtFkBvCd2EhS/pz3Dbua8/M0/6/4kZ4qIOnnHNcBv+e0eCSA3i56s6jAt97zTQgHCbg5roHZfXGlFVOW/ikRqbnVKg/CycmC8y82P2KNy+xzUwNV+a6NkupI9NOsbFm6cMswkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvCDqAeYBCsus1Gyt+AcJZoZENzUq4sDO4Hgu/nn0mg=;
 b=uUE/J4O44VMIror13XZbVMt8URJ+CJc6lxxj7YAz4TmQQfL7OZfZw9C+T+QixKjk0mJet2OrjyzmR9/HqeL//5YkNBuEbLaK0wAYYqUo3PpmTVopVXUYxJPuisacVmU3NFHr9BxOVlnzBhOvqXzHJpLag78AGzBnYAMirvg+v2ALBZNDAmkvfigDWHGrr4Agmr4gj6+cmFV1koKynAQ1dDEhj9ElJdB/69tMGG7L/LDWmgdSYyZjzOKsoIXsGNyjIw2pM5J5opLRg4ChNHmDa9n6Ubh+L3+yo33KzT+TmXq4/+JdRaMF3yonrlU4I1fgdLVnwOgBQm2gL4Zr8Q2ojg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 11:08:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:08:12 +0000
Message-ID: <540f59f7-6e6d-4a64-b780-84e3b0bd9379@siemens.com>
Date: Tue, 3 Jun 2025 13:08:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org
References: <aDggNAAp1mnSfQja@duo.ucw.cz>
 <ce5c2a9f-8f9d-4266-8c0d-ceb62dd61405@siemens.com>
 <aD6zm+UdQn1RSRSj@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aD6zm+UdQn1RSRSj@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 79eb9e0a-f157-4e76-f3cd-08dda28eee45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d25JTkx2SDl5WEhWY1VFYmNwVzBLRWdpQmhzYWNIT2x0TlpSYnRaeGxKVGYv?=
 =?utf-8?B?cE5IeS9hU0tyN2dWcjNYV0Vaem1rUDhVTWoyUExlRnJUdm1JVHZFMGRRM3J6?=
 =?utf-8?B?dzJKRndDZllSSHNCbGVuVDBPQlk0cGFvOEJrZHhjQVBpbDNnUHJiRlV2cFNR?=
 =?utf-8?B?RWhzMHl2VVU4T0NlWkJYNHRUTkFIK2RTYS9nNmsyM3N1UXUreEhrZFdHWDN6?=
 =?utf-8?B?N1loYmpEL0orSnVGMEpjSGp5K1MzUmQ1UGRJWEZUOWZ3WEl3cFl0U2w3Z2Vh?=
 =?utf-8?B?aVBHTW9KZGwwRFYwYkFBaHoyVEo4UkIrc2ZuSU1mWUlML0J1UHhURjRzRXdL?=
 =?utf-8?B?UHYvWjEyMjUxTmdwOHMzSUxrTXNTNWpmL1VDRXByQUZFeC9COFIrK1lrM1Rx?=
 =?utf-8?B?MUNxSGZZM0tUWFo3YXptZ0hieEtVRkxkaDZWS0luVjJvVFUyN0x0Um10N1VK?=
 =?utf-8?B?OEczUHE0eXJNdzdZQkZ5RWpUUDRLSkF5cC9xWTYwUWdvTGRsa2VENFJZVWtN?=
 =?utf-8?B?cXJ6YTBub00vMjJnOU82eHRPZjlyRjMxTmlTOXozYlQrcGRWLy9KWXg5Y0NE?=
 =?utf-8?B?TWZJblMrb2tkSVEvRndramdsNDEwbXZEZVdYMzNwMnE2ZTRNb29lZ1dQeU5j?=
 =?utf-8?B?a2hzeHBWWjJyalhYQ0FtV2xzcGRmczhxV1Q0WXp2KzBtS1dSdnhuZ1B1cEtq?=
 =?utf-8?B?VnhCdGl1eDIwNWN5djVwaU5YdTNBMllpcUNCZ0swN1pIY1RyYmRpMk51Z3Np?=
 =?utf-8?B?Q2U4d2x4dmltOXBmb3o5Z2traTdITHVMVDZjM1ZmenVjOW4xY3VkdDVLZW52?=
 =?utf-8?B?ZFVvbUVmc0FlSkdOUG1VMjU3SEo2d2JidGJlWndUVGhqWGJnNmdpM3ZiY3ow?=
 =?utf-8?B?cXg3MW1mOXRTZlZmRjRKUjRmV0xzRHpuaWs3ZjRpOTJ3Wjdsb1JZU3owSTV1?=
 =?utf-8?B?QXRCSlhNRDRING5HRGdwQzZsTFNQVTQ3VHVTWGdQcElXRng1V0NWcFRDeld6?=
 =?utf-8?B?SDZWWlFmNW9uMytsclZESTFQYmRCU2FjVXNhRWh0MDdUWHI4alVRK1MxZUYy?=
 =?utf-8?B?SGdtWnRqTURWQ2FtQWVjUEppWVdlK1dacTdIWlFlOWpmbGNxWHY2NFpZOHI5?=
 =?utf-8?B?QW01ZFU3dEhVdVZxbXVIZUZCNXB1Y1h6SzNXT2QxODFWQk1UdkQ4aHZ1bEVj?=
 =?utf-8?B?K3ZTc1dPUDExc3pxc0N0RnhRcVJmelg4MEZNWjlTQmZvcFU3c2RSVGhSdTI0?=
 =?utf-8?B?Nlh0eUY5bytqMDl1a0VMUnlTYzFXMWl0ZytGNFJXV1BQZGp2by9IZk1uM0wv?=
 =?utf-8?B?U0Zsblo3N1BVNDFFMTM3V2ZjQ1JUbVhCMVJKakdEMWMrVzdTQ2toOXVhN0xi?=
 =?utf-8?B?R3NuYWkwWFlzNFBySEpFT3VDNnpITG02WEtpYnNvd084bVRYdzJzNVVrOGVS?=
 =?utf-8?B?OGVyNmwrNUE1MEdBbUdlSFlCVXk3TlBBVDVEbXUvZXJWcnlwTWNubDIyZ3hR?=
 =?utf-8?B?TlI2WXZ6d3BSMUU2R0JyVEc3b1RGbks4TC9TeE0wOU4yWEpZL0hzdWVEUWNj?=
 =?utf-8?B?VHd0VTZWSHFybzZCSithMzFOVk81VytvcEtXOW5EYnAwSlpnZjN3OXJZVERE?=
 =?utf-8?B?dXNaL05id3cvU1FRUTljVGwrd3l6Z2cwVDNQeVVQbEZaZHlPSWltdjNybEQy?=
 =?utf-8?B?R01MRlpGRlN4eFVxaGhNaUtMOUgyL3FvVlM2b0RBbXkvcnU0bytoYmlkUGMz?=
 =?utf-8?B?NGY5TWJOMHIwcXQrMnZ4ZXAraml0VzRoaTdMekpobnFmMHI1enRhR3dFdnZa?=
 =?utf-8?Q?77ubI/vsgUTjC3LNvYK1Nox26jbNMxRvyyty0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEhocFcwNmJXTmM5RC9ockhOZ3ViSWhiK2JhaVBvb2dFM2lqU1RjSG1yOHpq?=
 =?utf-8?B?QSt0T3ZLdUh2YjRPQVplNHBaVTlaUmRraFFaV21ZelZ0NWlsNWMrV0diSHZE?=
 =?utf-8?B?a0N0T0ZKQnFoaEFXc2pGOVV5R2ZCM3psa1E0REEySmZOZnpoRThZZjArejVP?=
 =?utf-8?B?VEVnVnkrQVZEdjgwdGxMQUFJYXh2eVlFN0o1RFRCdkQ4QlhyUHkvNFRMY2NO?=
 =?utf-8?B?T1ZmUHBQZEsvVm0wT1FBQklzTHJrSXpqMk1xV1N0QUMvL21YZWpvT3pUcnBS?=
 =?utf-8?B?TVBmakxJMmpkMGNSVFZyNGhpRGp4TjAvaDNxd09ReERTd0xCQ2VTRjREVVdj?=
 =?utf-8?B?SlJ3ZUlYOHNOd0V5TlJjb2RiTG4rS1A5R3MyU0FpdEFhM3pPck5yVjV4dW51?=
 =?utf-8?B?NjFqRmJTMXlpT1hhdDBRZGxMbUNvWk5FYnhJb0E0a1c4T3dOdUw2U2EyOUpC?=
 =?utf-8?B?aHAyZ084ZVFoS2FnUjVCUjJVekQ5LzduSnJVaWtRZG5FVEZuemJZcTYvR3ZV?=
 =?utf-8?B?N2JyRUJPeHNZQXlIS0NEaGxvZWhHbEY4aC9kcWxpcFYrWmVIUzlXNGRKTUVZ?=
 =?utf-8?B?eEdCcXRyUDRtUlkxQ1d6eDdWZkhSNDk4VmVOdDF1UzVvc0w5MFpCMkg3M21Z?=
 =?utf-8?B?WEJTNTBIMHN3YmRKZG9oQ0ZlZDJ2QnRKcDBRUEdpckFlUWNDZTdmRmxrNE9B?=
 =?utf-8?B?UkorNzFhSDNmcDF4Z1YvSUpUelJJMm9zaGlMTDYwTGhXMlFIVUZta2Juc29q?=
 =?utf-8?B?c1ZpZ1ZRcnY0czhLVTdpL0laRVdINjRQdy9NMHNqa2lGQmFoL2xDWmgzQnox?=
 =?utf-8?B?VkxnVFBpRTZnUDNwRjhwTzVLcmgwT3U2ek1xOGdVbDRTK3kxODBBVzllRXFu?=
 =?utf-8?B?ay9aa0JpcmVzVWo1L2hzMFh4dnYzeUs2a1ZMWFhsTnBERzhmMVpub05mTG80?=
 =?utf-8?B?N0t6N0t6WW1RZHhERW1GUC81bW9qVzlLcUZWTWc1QSthWVpOOTVreTlLNGZo?=
 =?utf-8?B?ZGE0SmcyZmpLWjBwekhRaHBEZDRVNGRhVTJSVHJyQ3IySitQcW9pWE16ckZO?=
 =?utf-8?B?TEFBb1VlSE81N2NUT2h1dmpxbDk2RmZCNzIxMUgxclhndWhqUGZyelBNRVFF?=
 =?utf-8?B?Y1p4Smpwb1I4N0RNZHRRUG1XMlpoQjJML29DTnBjR29qV014OHhpNlcyL1hs?=
 =?utf-8?B?MzJlc1ZPOHdjdVA2bG8vNXhzSDA4WDJoWTh2NVhyNWVBOTZoTmJNZzF1dkVz?=
 =?utf-8?B?N3VqWDNiSFJwSFhOb2lRRVpkbDlxTXcvLzJWUG95MXA0ODd6S0E1bDlobEhU?=
 =?utf-8?B?NWVSWHZyZDB3SlU0TFRxU0ZNby9JelhBaUl6aG80RFZZVG4zbEdVM1JiOWlH?=
 =?utf-8?B?S1U2ZHhFdzY5WnlvdXN6di9aRmpXTGdNQm5pdC9JQnhkOThyVDVuZzgvcW9K?=
 =?utf-8?B?WXR6bGhGNVhiNGdrUE16aUd2bEJjaXRpWmVhQWd6WTR4Q2I0RTdRMG5pUS9k?=
 =?utf-8?B?U0phQnN2OGpiaTVRSU1TL2VWUzlwVmQyWHMvUzZzK3dtZ20wbm5ud1BVbjNW?=
 =?utf-8?B?ekFyTWhETWxpTWJZa3c4T2VaSk1MREI3WmVaZXpNa3N4OVpiQzFacXg2cS8w?=
 =?utf-8?B?b2JoMzRiMnl2WVVzckg4Z3FOL2Q0VEdmbVlrQUlHMjNRSGF3SnJUMUxINHJQ?=
 =?utf-8?B?cEN3dHdBZlVuVWtPV2grdXBmSzMySW5oTXEwekR3TWd1aGx0clJEWHh5R0ZM?=
 =?utf-8?B?QUZFMEQ2V3cxK3NEZjdtR2xKL0lta05JOFlpckNOWEN1aW16Q3BVUk9hTmJZ?=
 =?utf-8?B?MFVBaEpZVkR0cWxIZHhhdTBzV2p6OVR5ZXJSZW8yVVNjVzhrRE03VHJVOVhx?=
 =?utf-8?B?elZwZHFVWWpUUC8rT0dwQ3RWaVBGRk1EM2plVHhWOU1XSlY1RFQvUjhJUDFh?=
 =?utf-8?B?M2hKcU1mL0cxRnh0cDE3ai9VdzE5Q0IyOUpYUklyMDluVW5EWDRnZ1g2QTRt?=
 =?utf-8?B?VjFEVHBzRXR2cm84N0JBNnkrRlR0VWcxSFNwOUxSQWVPYnowekpXRTRIaVc0?=
 =?utf-8?B?ODFoQnNhY05kNGpUTnNhUEpKOVRnR3p6T0FDMXp1SDVXS2NFdURIZmJMY3ly?=
 =?utf-8?Q?i3hL9EbM+B61kvGrBT7bbvzjk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eb9e0a-f157-4e76-f3cd-08dda28eee45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:08:12.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObxWwCSUOAGfbX34jG/HqnDQyYkTdOqo3O09QC5tvhTNe/zjHvGTJUi0um0GfLwrzGiUeTOxaZrZlZz+yKXHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 11:08:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18994

On 03.06.25 10:34, Pavel Machek wrote:
> Hi!
> 
>>> Kindly be reminded to attend the weekly meeting through IRC to discuss
>>> technical topics with CIP kernel today. Our channel is the following:
>>>
>>>     irc:irc.libera.chat:6667/cip
>>>
>>> The IRC meeting is scheduled to UTC (GMT) 13:00, or in about 4 hours.
>>>
>>> Last meeting minutes:
>>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-22-13.01.log.html
>>>
>>> * Action items
>>> * Kernel maintenance updates
>>> * Kernel release status [*]
>>> * Kernel testing
>>> * AOB
>>
>> I cannot find the recording at
>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/ - were there
>> technical issues with bot, or didn't the meeting took place?
> 
> I did not manage to start a meeting, and we only noticed when meeting
> ended. Sorry about that. The log is at:
> 
> https://ircbot.wl.linuxfoundation.org/logs/%23cip/%23cip.2025-05-29.log.html
> 

OK, thanks.

FWIW, "#startmeeting CIP IRC weekly meeting" should have been the magic
spell to start.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

