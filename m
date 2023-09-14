Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FDAEDE995
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 08:35:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.7103.1694680537229088673
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Sep 2023 01:35:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mrBqGAHW;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knojs8qgTsKuWXzaPgIQ0e8YiiqGPbXGUTo1j2JsHeF1Xpnr1q+TlK7bn1yv1CxZKIlOvUDgIIL0nAAqHqyBuxT91LLSqzWh/Fplr4QbP8aJkFM1sqc8eXXyVnke6CXcG/yUKjwsdaRxq++vaVfZvrNaJmBxpQ6FPvuwiLVH4OtATV5PfqYYBkKOylzgfH8V0utGLhZnQuGRnmwfPVGAmdzHkrU/evQvTAIS2OjzDUw0Nr4bctvIvrPl6tEfxMGrll0r+qIgZ9oCzv6xFvQhx/1Zw6r2qjRkLuT9h0L9498KoSG/x325iascQbsKlaVeqGfRY03dzFjpUkR9FdtrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bVZse1pUy3XZtbCbHMOO6atpOCISXADKn+N6bWMQtk=;
 b=iwO3ywrWTSuIjg4Td3SFeZq90LnPaIzemp532fnUKeUFGUS7iXL8tXnsNAIFfiCYrnWzm/gyae05a4hVKaiASyQ+ZNepdGfUwu0X43Ruod6Wtj42ZvfaLkLjSaP3bXoYQTF1tDz4EYaQxTgoQU1J78aRF4po/Nful+oAf0K2gVrH2LZ+fhEzmf1ZQNyxbcko9VZJeg7+TPyjnLAb5eQc86/JzfKHz9ONNfWPtzjPoWUUp6FEglwlpA8Jefed98eqkSU/rdJMpokmWQI8Yw6pBIfIvvYj7D2nDb96/nCnCzkZNxl41fEQKU66yeAJ/CjA1B2d8XgXMTqqSM21ctDHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bVZse1pUy3XZtbCbHMOO6atpOCISXADKn+N6bWMQtk=;
 b=mrBqGAHW+VNkbOTDwI2Ro6gZ6ZxG7ovsArPH5czYjrM0oyfsUgw+43joeZFgbbRFJuvO1X3maQqrdV90RCigTIrum0bLJtmhWdGRJ0PU8R7p0jjJQKnNaWmjW0AnKOQAo4CUWTItGcVvbNrwxt4MjsmNaOdk9SwmyMWOtaavJgZoURuxyAPApW2mWQKeU6n4WLfkVHS8AhdjLGVcIuZbFDPeltsO+NwdKIE0JD6CqtAGe/MSAgg8vEJLcu0IzOGPCEKwpmACw9z4Sz/gxVT/o+7bf0w2waq+G9tqP6/0Hi8BP69FXmFxbbQvVAt5sSNAl+zINKETppJC+9BPqxAURA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 08:35:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:35:34 +0000
Message-ID: <230df1b6-0189-4f47-8edf-d30cfd82d4b4@siemens.com>
Date: Thu, 14 Sep 2023 14:05:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <b0a75a9c-727a-4af0-b3df-d28dda57515e@siemens.com>
In-Reply-To: <b0a75a9c-727a-4af0-b3df-d28dda57515e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:610:5b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcbf05b-ce1c-47e8-9c59-08dbb4fd9043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KvuWDYFkpp3sTYEHUmWwuYUlia556BzQZb7NS9/qgWRkb3oGwwher884PPmXUBwzBLl2y/4ovDywq24tRbGEC4PBkuGtaYekx5NPSZYScbA8H6/B4p/8frtYf/u4iE6IP2LYm8MRgwvIAU4AM9KWNTceBnauYMMauEnzTNuT9VeqjrPOFNg6e6sSsKgZJ5Q8G9yFrNr2W+EXvceQmFhOZxM1M+izYI6khQh3/MrtxEGMPm49Do7+Br4f6dJu25V/OYfImblKSQL2HPlJ0IHq7iqYn9Tf36UbRkzKmPEt5hLcS3Qxk6uYrSmiw4kFnbf2JmsE0+cmoQzrC+JhBzc/dno+F0g25Q/aARymL94GreSUQwvdDA2CfiKJCCsHFgdCRy3CMO0oVPT6sTLyU4bRH2lg2JmHG8VWL4KCQNC6moTXnJi8qYTk1IRv9/BV3RGZ1ArD9lFH5VkGRXkFalTfAK6gi475Xws3V6NPG7GwJXObi8Qy5lO7He4zEksoAvYqdcrrEhxoIbYS2SvdEVN/lhb2erv1WME+UGw3qYKd7gH9EPWMithIPfQI+5NCGb+nSXeigKrEsDsMP9LP2NHR/hVztIYQKsmle3i23nfg8mAUCUFU7x+EIAQgHsHFBKooesBfFyF3T666BNsPIb1Gew==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(186009)(451199024)(1800799009)(31696002)(86362001)(8936002)(8676002)(5660300002)(2906002)(4744005)(44832011)(36756003)(6506007)(53546011)(6666004)(6486002)(82960400001)(2616005)(38100700002)(966005)(478600001)(26005)(6512007)(83380400001)(31686004)(66476007)(41300700001)(6916009)(316002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHpCdU1tc3FxazgxN1NMU0RvKzVzM1RkY1dVZ0ZqSnlXY2VIMWhFcmM4MitQ?=
 =?utf-8?B?NWM4QVpYQ0k5YWhybk50UjJOYjZHWDlvbW5hUU5ja3J6L3BPM0w3a1R1N2lD?=
 =?utf-8?B?SldITkpVSEwrRHdURHI0TDZGN3hpTDc4aWxUSVhzaGxZaWRtYzJnRURVdWcr?=
 =?utf-8?B?UHFiWHhCUUhCUHZ6bVZHVTcraWhOeC84TXVEcWdUM21yalJDUm82cVYrd0FK?=
 =?utf-8?B?Uk1DcHRIMG5vRzNKbDV3czVsbGlwWC9HTXpTNHhVajBTaHp0R3I3a0IwdkFS?=
 =?utf-8?B?TVFyYVVWbzRZem4wN1IzSjhoQnNNZVlmMzJ3MVpWSVF1TUpWc2RoeEdKMWll?=
 =?utf-8?B?RUs0VWQ3RGpoWjYrTGg0cFl0WkR0OVlGKzYrSGhsSUdlemVkT3A1Tmt0ZVlQ?=
 =?utf-8?B?TGM2bmJkWEh3WjNJNHZKRTM5MDlPdnhZWklqS25ncEFqRDRZUVI1V1ZMZmc2?=
 =?utf-8?B?QVZWbkhUZk9pTmh4VlVBbVlLSUVTd3VYeFF1OWNxeXEyTk8zNm9yYUdXN1hn?=
 =?utf-8?B?Ujh5RUN1WkFuZExtZUxHOWwxZy85enk5aVhtV290aHY3cmF6VmxYbmFRM1pM?=
 =?utf-8?B?YjB2ZVdHcU12dUdVdWxqUldoZWhzckl6R2dZZVNleHFXclZIY0lXZEpmRHpH?=
 =?utf-8?B?L3NWSThzMVlUbk5WS1AzNUxYT2ZWYURuUFVpMVJqY0VqT1ZmdS90RnFYMitu?=
 =?utf-8?B?aE9kalh5VEpzc0RMMm9PTUd3VWhHUGtvOHNmRThSMFZRQW9SVFZ3eVFxVXoy?=
 =?utf-8?B?MlJ0SnYyc1lEaVNDL2JqVUthM3RiRmVGWjczQjdNK1VxbjVPNEgxYmV1b0x6?=
 =?utf-8?B?ZHBtTHc3R3lGNnJvcFNJVkFvTW9UVllYWkZ6OU5LMGVZT3NiZXh6dHV1TVJt?=
 =?utf-8?B?L2FNQlJNSXg4NXkvRjVBNng3d1lUV2FjWHBXMkc3dDdaNmlNTkhnaVEwOENn?=
 =?utf-8?B?eWNEMlNZcmVMdm9tbjFrb2FPMHB1UWdFQ3J2RFZQem55Y2dQZVNHVDZJcDJq?=
 =?utf-8?B?RjZaciszeWpoRjBITDZzcEZYVDk1dXh0UlJsOU01OWpZMWdtYTdnTk1MMXl2?=
 =?utf-8?B?N0hVZHhJNExWZERnVlpOeWZQMFFnOHc0aEk3QUJBVUhCUExoR1ZUKzRZaWZI?=
 =?utf-8?B?bWw1OWgzVGZYbFVlb3o0dTlEWWw2RFZSNHU5cGhhbUswencrSFo1eTE5ZkV4?=
 =?utf-8?B?aUR6TkErTWRTZGV1c1AySkRmMlFCdlc0bXd2TVdTR0hhOEN3S0JHenUxSEhU?=
 =?utf-8?B?OW90L1R2aFQ0bHVNbm45a2hZY3RVcm1sZDNRWENQUnBjZFpKUU9yTVppTUNm?=
 =?utf-8?B?N2VWQXBJRWcvWjJ0QzVRRjFUVkVzcWV4SjFGR1d4a282NHk2K0llMmlwL1po?=
 =?utf-8?B?QVc1R0dUOVRoNytFdmJmTHlXbnM0cHYxUllacU1weThTUFNNT1crWllpclYr?=
 =?utf-8?B?QVZKOHhnYzd1TW1qNXVSZmNFcVFCL05FVWVkWTVqWkxDZkJ3RGV5MEZqb2Fq?=
 =?utf-8?B?bk92STM3SWgzVWpCNnBDQUNjK2o4WVNzQlhRdFBWb0k3NG11eUJ3Mm5mOXA1?=
 =?utf-8?B?Z0U5UHZaU0dUNHVBTmhXYkR3eTFjUlFQTlU4ay9ka2J4dDJZQ3g4Q2Vxall6?=
 =?utf-8?B?d2JVL3F0RWFOc3ZxenJBV1krMmhER1dKZnh6Nk15WVdQNzdKbHRTZ2g5dEpy?=
 =?utf-8?B?Z1hHNTIreUd2ajJieEF6R3ZXaU9TQXhkRGRqeHlYcFB5Mlh2a1VQdjZlaWwy?=
 =?utf-8?B?aVRYMGI4a1A5Uk0ya3Q1N0c1ZVd2YU1uWjhaVnRacGx4T25RM1pXYjlkdVlQ?=
 =?utf-8?B?ZDRjWW1TUCtGdDdUUHo1U1FKTlhyRm9WOXNEemgzdEprQSt0clhtVTZ0bzdH?=
 =?utf-8?B?QnQ2R2t1dnF5ZW41TmtJeGpaMUVsdWcwcFNuc0g2QmVYbm5FN1NCTG53Tnk2?=
 =?utf-8?B?d0xZTEFLRXNTZzd3MVpTT241Uk4yS2RKMG9mLzF2ZWlxSUpuVTl1OE5mTURJ?=
 =?utf-8?B?Mm0xcUk0Tk4xai9ySDFMZXhDdUU3UThUYjRiQmo1Y3ZVMVlxQnE5Zm1yOE85?=
 =?utf-8?B?eEhLb0V4SEljSUNCY09sOVNMY1JZMlQycGR4L2loV2NOQ2F3RFVRTkdhZDJN?=
 =?utf-8?B?YVp6Vzk0Um1vTmxWRTUzMnd4R08zblNzSlZNZTcyUmRjMzZhc2FONGhQTWRR?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcbf05b-ce1c-47e8-9c59-08dbb4fd9043
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:35:34.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkUaKXR2r/BqlVkZNfgF95gmLXbYKp5dXgLkEf8EgZzx9MqbNQ86mIgqliIIADXbPZMm8kixZuvsMbYtbYJvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 08:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13132

On 14.09.23 11:56, Jan Kiszka wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=9&day=14&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/09/cip.2023-09-07-12.02.log.html
> 
> * Action items
>   1. create kernelci pipeline for buster images (arisut)
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1
> * Kernel testing
> * AOB
>   - kernel.org tarball uploads

- Request from security WG to tag CVE emails with something like
  "kernel-cve-report"

Jan

-- 
Siemens AG, Technology
Linux Expert Center


