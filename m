Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E255C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 15:07:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.16399.1693408064462298542
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Aug 2023 08:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YXQ2Xtct;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3sBVhS/E6NOF7Q3QBlZCR+nzbl0ytrNmPDQKUAjW2gQYKNm6BotFxEHA8lothmOad1rBCiLcENiL/vBH1sBAuttGxNpatpRa2zRlXriNpmcs8awkHxf+SO1FMQol/6aeIkvKZdZ5j9ZPmGNZesQHeKlcyEX2T9y4QR63h8sB5IJlgb6gADx7msaKw4OvV+lpPvUbuMG9VHngznT47y4VpFYVFcNTMMYTP8FuRmnHRjkz33Y8P1UAdA6aDrUnbetQ7y8RBPh/uFLIgCAI5gvGCq4trPcCCdJz5Fsupp5v3BVkzco4Wzt9L0/FOn1aczhduMSAPXq1QIdctexolVC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SkJZP08ewLTTUCKsGGPmoWH2TEv3TV/VnFA1eUUp5s=;
 b=TckoNxQAfK/gqqSOebcINdRmksUhB1F3GN4I+yBaBkiBpjUskIqgkUBXYJd5PAcrFQQzYFyLTPg38lxHgqG8f1yMk5yZeJtJoPl6/4O7q8E1Rm/pOi1HeWG5kV1PmjF9si0qZSEkmNqVb3TOIRBxzBnwT4qe27AJoqsECMddv80qO+BxmvSwJFpOpCxcZIi3Xme3+6YgcAQJDMJdewKS2RPLwGTu82cu9PNOBGOwPLhpuoZUpdiuDrk2glFDcbHz8cqYJ90AnUwehd9Trws84GKshMNEQbgvzLyVEnt5b24uRm0hB/oY49rVJvJI70+9uQyHICLuh5MBzC85qjQfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SkJZP08ewLTTUCKsGGPmoWH2TEv3TV/VnFA1eUUp5s=;
 b=YXQ2Xtct3a8Yn2zh325ZUBPIpmx6OloElT2F5+CgYYBeBOOSHHAlJJYDRmm8bJMu2SUNtGdzuaODsf/teAdEzD7RYiP6vjAcYENrXrsaWwFZyFAgeOUduh6lXiG9P0VAQ6987XR0PzkP5pQoyIEEKJ0w+ECRAnsHeyCRoO6HvRRYdrM1L7e7cXh3jO2LOB9/6isgBdKSp+TB4l1HDFUAgAsByc7VCgDJYDK9avs6HiLrCrBQnE4OkTX7iBrUGyxLQRLHynkWAA2K/4hZQLRKnor5aP8s6ctHHUV6Swjg7Ll2YwDW3IrSfsi7ZjMU1f+HNlcQ/JqBVVxk+4TjeEcLOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:07:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:07:40 +0000
Message-ID: <b5def4f8-61fd-4238-892a-5cfae8bf9960@siemens.com>
Date: Wed, 30 Aug 2023 17:07:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with git.kernel.org snapshots in CI
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
 <695be8e9-14a7-46a0-afc9-00aeb182d4cd@siemens.com>
In-Reply-To: <695be8e9-14a7-46a0-afc9-00aeb182d4cd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4bc633-8763-4aec-d359-08dba96adaab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w4RS+xV/uadGMifyq5/oE3nHXfdiZkLRAFbDpw8VPBCGPY8IU6KvVn0jifNMYd5QDJ6ZPKse38PXVGh36CEx3Ta8j/GJMHVOIeZnyfo1swJXL80JnJs8/sJSPLbJOXucu553gsX4K+xIr28oJDAgyfqcUI92CLLLAIf9qqBO8pXLbgMjK3GDMWJbmgtEtGFZzg+s9Ll2fuTrg4FH6TuVGYOEPuXK2AxQ3ZwxRmwiS3etIpikW2+bSCp52jBy93H29L9gIIvx+2D2NHUR0ws/ibxBvXwa9AXqbld1dRiMiJHTjbbs91tio5UIDDcKm85XTNt2mOF1TqdJntyauWYX28V2AVO853C+OQbY3QZXDOnr0/K27Jge2IrKo9w06Nvi7EyxzpQ9xYAbG7BGbKeRabHtwsxa6w/EYqcC9CoZnpxAtD5o+dk5tV9Q+lZiWCaXeUMUbBY/nTn0n5bWlzY3PhQPLIK13qkmz4hoQWwdFcdrMeV+VvERcJxZzeCfijpfEVkfSgUYETbKd23MXEuH9NDz0CurvdyHVFYTH5C8PWZZBEGqwWTfbKCD9C5beZQD31eQ2SZHOHvTPwIofy2d0NWNY2L9mPtktdP+FMCsf526Oc9rr+cB85n5CyWH7pNnjgGSyKi5pDc2vond0zwTfA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(66556008)(36756003)(6916009)(2906002)(66946007)(316002)(66476007)(41300700001)(53546011)(6512007)(44832011)(6666004)(6506007)(5660300002)(6486002)(26005)(31686004)(83380400001)(2616005)(31696002)(86362001)(966005)(38100700002)(8936002)(478600001)(8676002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFZ5a2gzaFBKOU5PUmtvYXZtSlJ3cjA4QTkvd2psQmQ5Q04zOVBiYVJ3NGp0?=
 =?utf-8?B?K2dVYWtRRXZ6b3liQVhzVlBTQmNJUnAxTTNVSk1UT2k2dnIrbFg2TjdLZ3cr?=
 =?utf-8?B?V2NqUHNVQkZKQ1NteXFoNjlHbzVnMm85dk9NTzVnZzlVMi93Wk9RdUNKclJV?=
 =?utf-8?B?NDNIOE9RM2dtUHA3djJsVnRlWFdOU1E2TWY0Q29EZnhvQlM5MXdqbU13TjU0?=
 =?utf-8?B?VVNFdmRLZTBrNDBLM0FoQjBDVFNuODBENVM5Y0ZFY1pjYlZteWZvUWs3WnJE?=
 =?utf-8?B?YVVaSnRKbWc1NTl4OTAvOTNSY3A0M3hhMzNRdk5OT0p2emxYeE84c2U5eVhF?=
 =?utf-8?B?b3FSdEY1aS9aRnVtRWRDZ25xUGYxRHZoRUQ1V2xKQmppcDdjMm0ycXVvUjFh?=
 =?utf-8?B?VERWeXZNT0F4bWtUeXdkeUNGRjJtbk96TFVrd3dHb2NvcGhxRUF3L3c5ZGV2?=
 =?utf-8?B?M1M0ZEYwbkZXVE1tNUtRdXZ4RXd1aUxZZ012SVVwaEo4d0YrYlltRlBsN1Nt?=
 =?utf-8?B?cERqTDlseG0vNWVzcGZHd01zZk8raDJpdjY4NEg5STlacGc4MDdJaGZpRWlL?=
 =?utf-8?B?anpEWjZNRFVnU05EUXloenROMHZIejlYMjJyejBrem02WEtsUGV5SHQ4NlBO?=
 =?utf-8?B?d1VYMTJEdDlRVE1vYU4yYTM5eFdtMnFZbmFyRFhlUEVCMjAwUWQ3VHZJSTEy?=
 =?utf-8?B?OURVK01jUG9rU3RPMXcrNlRhZkZTU2xEOFBqN3F2clZVSU1FL0t1UXZZMjNt?=
 =?utf-8?B?bWlBZFB5YThBQ3RYTm5nRk9vMlUvMmlFZWh1OHNhbWR6WFNKdmQzajZlNnF0?=
 =?utf-8?B?VjNtdmtxRW1ZUWx2ZlJHNnZkcGpKVERhaTNiMVRFYllWM0h6alBxbW9EbDBX?=
 =?utf-8?B?a0EzQ3M5Q1pqQUc3S1VrUklHL2RvWHU0T21VVGEvTVZrTlpGRUtCeDFQSk11?=
 =?utf-8?B?YzVudnpjZEZpS09NSzMzcXk1K0JERk54aGx6M1hIdFJZM3BhMVlPY0FCZ0VF?=
 =?utf-8?B?aXNXVHd4blU3S2JJbFFZenNZVDFKQzlwUWdhOStwdC9VbUhqd25PUllXa1U1?=
 =?utf-8?B?Z0tZMGRWa0tKcnNWcy9kN0xwb1pUaVFDTDE0V3c4NHh2alhFbFQzaWs4UUs2?=
 =?utf-8?B?Wm1QK0FpNkVnVVlwUC8vdHpjOEhJRGtFclplekxIS0VydlNYdE44RWtHclZF?=
 =?utf-8?B?RjlUWGtaK3pvM2thVFRCOS9nZVhSTW9QNEZUamVyQ2VMMXU0ZjczVTlyS1lH?=
 =?utf-8?B?K24rVk9RZG5hUktIQ1A5VkFFM0NpMitGSWE4b1F3dDNwZk0zV01iZVY5Smhk?=
 =?utf-8?B?S3ZlNGJuekk5L0E1eFdXWTdtWGd6akVtdG5sUmhaaUxlYzJZRVBCdXN5alRF?=
 =?utf-8?B?RWdFS2NaM1V0ZldRM1hQZkRSLy9LNGt1blpCeFBiWmNscy9NTXNVWks2Tnlo?=
 =?utf-8?B?d2RDSTVKR0hVcUl1aTUrdUhSTG5kT2NMM0tLZTJCSktaN05yb1g4c3M2K0F5?=
 =?utf-8?B?UGt0V3RxaE5kUHRQdW1JdExrdTZGUk5kdnR5RzkzYWZ4Q0lNUFdEYlI4SFh0?=
 =?utf-8?B?Rng1TThHd05NSmx1Ti9CTzFIclNFU2ZOKzF6RXlZU21Ha2ZtL1FyREhIa3V3?=
 =?utf-8?B?a1pkeDJaY1RIdVRDTXh5aElnVXEzWHJHdlhHN1hoeVNXVG1UZTZRakZkaVly?=
 =?utf-8?B?Qk12dk10YmR5M2lIWmZKeVBjNUp1ZUpjbWJIY1ZoK0RpaUZ3RzMvRVBzczND?=
 =?utf-8?B?UW5KQTVCeGJ1Q2d2MC9Jc2xJTjNoakJ6Um85SFJqNFRuamwvWDk0dWNrSDJO?=
 =?utf-8?B?Yy92eGZCekdIWmVOMFNjVTVsZzFKemY2TGo2azM1MXpUZzU0UmNWMWc4Q3FH?=
 =?utf-8?B?WFdZOE8zSC9ldVEyci9FL0tXb0YzTHVSaVloQjgwQ25GNVpzOEExVkw1dGha?=
 =?utf-8?B?Ty9WTDJmYXhCWHdiNk92Q3RtcHJKSjBDbSt5M1dPZHcyaXdtNkxWdEI2cVI3?=
 =?utf-8?B?UFNrMjMrZU1RanpVMGFMWnZBcVZiaGdaNFBVcHdwMUdUNGlYQW1OeFZUMG1K?=
 =?utf-8?B?SURQY2QyQ3RjQ2ZUVCswVC9Oa3hnTnd1VjExd1RzUlU2OXBMQXVDNW1qZk5i?=
 =?utf-8?B?RWV5Q1VVdkdGakFLSkpLRnYzZEk4ODNYWEliTnhSb3VoSS93Y1JDT01ZMEhS?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4bc633-8763-4aec-d359-08dba96adaab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:07:40.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VFuDzl6ArAQh7Xjab2nDJdFNzGeoFinQ0m/JZiu/g7fFeja8rxSGaMvm1neKsHeX5Twy85lhIQjg+GI7a55zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 15:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12916

On 19.08.23 13:49, Jan Kiszka wrote:
> On 16.08.23 09:54, Jan Kiszka wrote:
>> Hi all,
>>
>> isar-cip-core jobs are frequently failing due to fetching issues of
>> archive snapshots from git.kernel.org, see e.g.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4881160724
>>
>> Retrying those generally resolves this again.
>>
>> I think we tried gitlab as mirror in the past, but that also failed
>> under CI load. Do we have any other alternatives? Would it make sense to
>> make the tarballs as regular downloads somewhere available?
> 
> What would surely help is having a download area - maybe on kernel.org?
> - for ready-to-fetch tarballs of our kernel releases. Would that be of
> any value beyond our own CI? I suspect uncached downstream CI would also
> benefit.
> 
> Download caching would obviously be another option.
> 
> Thoughts? Other ideas?
> 

Ping on this after we had a discussion in the TSC call yesterday. It's
breaking way too often now.

Options we may have:

- ask for download area on kernel.org
- host our own downloads on s3
- try out a git mirror (and its snapshot support) under
  https://github.com/cip-project
- use download caches in CI (and suggest downstream to do so as well)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


