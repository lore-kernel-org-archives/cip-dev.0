Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62805C7EE23
	for <webhook@archiver.kernel.org>; Thu,  8 Jun 2023 06:08:57 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web10.2792.1686204532922386161
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jun 2023 23:08:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZntiGJ6i;
 spf=pass (domain: siemens.com, ip: 40.107.20.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS3I2PC8J1oDQyF1aBLlwb7ZTitQLQMY1jUEcYWR6UVa8oK/bLy6euEuukWENZXJA1Ed6HG7Sf1zbzLN7atBHAJO1LV3TqYuqhRQvcdjrf24ooWsCNYfj6yay4D89XBFRv+QC9+RLD155Th4iCIw2hcIrkdhVwKdKtCZpUMjUD9ao3pzw+Ocz2fWgD1HK++nVFsh2/Bw8oPvdyJMWnIBsxherUlzfDjWelAKVXSry98t1l0jd6GVOkIUrLhvdNd1l7SC0+zHJ497UNWDtphHBvND4+mjEUXl6EPH2syJFQJBY/XrDzn4P9BwxbAtDg+q6VfRWIwQ+p6gJKq+3jLd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV6JwNKP0YQHnr2iv6/CPnR0CQgRc98YtQf9miwdLM8=;
 b=N+CIWsoXcksHUYb9yqmeP+9IXXULHNxkNUZpLYEgPftwGNBlBWon1ysO8117UqGbwzVUy2uX+vq0XKck3I/sOTH2MWsx/pGsR8p2mdgRHeIVbwu3p5fW1fDsmC+r2rfxrvMN9kg9WizCT9f8YkyD98dSp9dcmM0j+GEqTLBvPE81EVd5jU6sEy6k/cAbX5VYT4dO5cw1tzfmo87D85UMvnbenWogjYbn6AIqBKOMPxmSoQdHPFBahkTSBW4KtEZiNc0w68ypHBDEJsAAcOCEiRGG5Va/oLrrpXSFHkkgouPIY9O128MXfOqfJrJ5rk3Eyar3VkYdhFdNXFZefPFK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV6JwNKP0YQHnr2iv6/CPnR0CQgRc98YtQf9miwdLM8=;
 b=ZntiGJ6iE5W4l3mgIaLt1rlg9Qi0NltTzpAgQ5b+LyqpU6BQWfFXvN4Xjg98M08ezJMxGxjttRe0N4Jod1LQZAeoebYulp+bgNMQ45lMoBK3FrNTtXoU2ve1BVoA73MCLBSk0AzjnKzKLrYRpCVkEIKGDYjwxmNxJcPMpWjDC5lio+Nx0KAAUGJwdZni7vL73Qpf81T4JGE+GiuAlG5p6AkOtRSrI1LDcysETSatY7b38/7PMhcJTVHyrCVm76G/NSzt0hj60XY7bMA4SbBdr3ffaXtoLhZWO0qH1LtnFvlYvkCO9ePhMQkxfxcukKq50iI3DKK13pbrDId3PaDaRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:635::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:08:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 06:08:51 +0000
Message-ID: <117e6320-f3b5-633c-98b1-f7f51e1333f3@siemens.com>
Date: Thu, 8 Jun 2023 08:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1289d3-5f78-428f-bafd-08db67e6d512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g3ZFkgjFbM872d1LDBtUMj32ss3M80ahRn9TWhxoHeTAqlwjEZliAz1N/sfS8dQKvyQeK+wLupz7pKK/JIhqGXYBpZwq/AICKyzotahhvWFb3bGvrKSDtgK6GSN3xYWV15EUsDn3nLBrRCsqgzXNyVIA6xmSS4Hr/zEAdziIhV7rWA+a3QXCKAgnnNhTLDdQAJxJNA3/xMJRM0ooTI5AMYeSx5ifpM9V6G82+4vHgmPn98G0PYcpAiUvc4b3yNPSEHyFxl9/6Kfc+7QZU0mXwE2LERPZRwgGzI2iGC0ip3hO25od0e2WRgmjRqr1nGJWNLTtWGK2Ygbxq7nyraDGAjLeI5OFLJnm3WzyZB7Gqd2P8kfJOZ8+xgzznHTjvB4Pq+33me49dE1j7lJhOalIII2pTeUmqbGgL3323J1whtxzmII24H4qhVK44cvZcdV5mWeu+NarCdk6ak3a/R98U7MiwCqeBg5umqhtc/Wu0AseWGYBGCm2NSkZyi4N5BRvhX82XTo3eUZG0F3W+8RzP0LiObn/xSnwlr7GlRVqjLAuee2dr1DmKQ5X/qDi9scEv8GJA7TT2RsPR2HtlVpKKpAENOIAQ+5RXJLVymAJtmuAiyXT+yWGYb8jGfGAnan5CI9EoigmBUPIk3wABQ+gZQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8676002)(186003)(8936002)(316002)(478600001)(6486002)(41300700001)(6666004)(5660300002)(966005)(6506007)(31686004)(26005)(44832011)(6512007)(66476007)(6916009)(66556008)(66946007)(83380400001)(2616005)(2906002)(4744005)(38100700002)(82960400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1hxSFRrbXg3UXI0cUVWNHlLZ2NjaXBmaE4wWTdNalZtV3I4Y2JxT2F4TnZU?=
 =?utf-8?B?VzlhWGZVYklHbWJLNG01aUVmblJqclowY3B5L3FQenlQNmpsVGtIc1Q3aFpZ?=
 =?utf-8?B?V3hjREZJMngvYzQyb0lGN213cGc3L1AyV3RCdWRCL0RjQVd1aS9NbDRMOS9x?=
 =?utf-8?B?ZnlxYWpiQ3gvT0FadWV2VkdwMXBQN0t0OFFvYlJqbyt1NkxuTXBoc1NKd3p1?=
 =?utf-8?B?RjR1b0lQWDAxc2VGbHZydGZpYjFMempMa3ZRZnFXaG9UcDk1MHk5Q1NzYzdZ?=
 =?utf-8?B?Rm1zZUl4MFRBSFNUZC9CRUUrZklDVUJ4aWp6YlRsaENSeVhyVjBoakQvVGRk?=
 =?utf-8?B?a3ZPWjEzNklTTjJYTU5QNUlkRk9ZOW9ocjAzRVhtT3Y2TVV1V1dzanVBL0Ji?=
 =?utf-8?B?VTQ5RURTbjRTb1Q4UUlBK2RYR3FGREpvTjZPb1JqbzlFMEN4V29RQ1ZkTzRP?=
 =?utf-8?B?S2lZUkZPc3Y4NGNOVG4vcEtsaDRWZk44YTNkTVRRaU51WU1tTmUrNEpNUWZF?=
 =?utf-8?B?UGhuYTh6R0ptNmE1NUFkU3FQdVBvZ1FaVmMwSC84bFVjSzArRjI2WVFLZ1lU?=
 =?utf-8?B?SmlWQm1OSzUrUWhVMlpna1ZpQm5USUc1Mm5DVG5UNEM3SThaeEVEOFBScDk0?=
 =?utf-8?B?a3VZSUYyVnZXYkhidFZFSVZtMlgxNDVMZTZYN2Q1QXBseEJidjZxd3U4RTRP?=
 =?utf-8?B?Ny8reGZLQ3RXank5aVdkUERRb1FNVXhqZlF2NTU5NGdJdVk3WUxkQjNSVmlu?=
 =?utf-8?B?OVJUYzEyRmxIdEc5RmI3Q3dJaldXNE5kbUlvNkY5dXp5Z0hRSko0WGpCd0xV?=
 =?utf-8?B?alA3VVE1MklpK3A5M3dVcU02d3dlU1ErNTc0YWhNY1ZPRlJqTnBzL2d2ajF0?=
 =?utf-8?B?TElxMThpQk41aTlkMk9ZZDhZUUZ3a3NEREVXbTUvMk8zVmNzMDZCcFZ4NDl1?=
 =?utf-8?B?SGEzOUJFQjVGa2FYdG56QjJVc0lscTcyTjJmd1Y5L09oSDNEd3pUSHhBMlRr?=
 =?utf-8?B?QnVJMmx0Mksra1dCNDBNVUY4ZkVGYTExc20yNW41OS9sMmhnYklWNjFNeStj?=
 =?utf-8?B?RGVRT3kwbzhWUFVCUHE5cVBreWIvbERPc251S0lEclNuMHhTeW9FSlAzNC91?=
 =?utf-8?B?SFN5dG1UeEJMWWEyYVAzMDhOaHJ5bjB4Y0RkRWFsQTVCZWU3emVoek10TW9K?=
 =?utf-8?B?emNMT3F0eXZKZnlqcGtKdTQ0QlBabWVHbTNvVm80dnV3YmpHeUJnOEY5dUp0?=
 =?utf-8?B?c2czdXF1WE9PNmJWUkFIWDZMM2JHdVV6ZlZEVjdKT1ZDOXR4LzMyZzh2YmEy?=
 =?utf-8?B?cjJXVEMyYUVxTVZWSURzY3gxbGd0eExsY01RTFZqeEVOZWJ3bVFCd1g0Uk0z?=
 =?utf-8?B?aGJGa1BaSW50c1V5aTM2NXNpRFUxRmZnb05sa2VqV1NTRWp2VjB6OGZRYjVR?=
 =?utf-8?B?ckttUFcrZWlybVJXdjNnVndOa1ppK0FvWWRJQ0VoQUtWSnZVeGswMC9TWWpn?=
 =?utf-8?B?blJCYXhLZkw2RjJwVDRoT05oajY5R3FCaXpvbXRGSitCM3VWVlJEOWUvbkVk?=
 =?utf-8?B?SlR2dDljTmhFUGZjc0o2QjJjTzgzQWowMFNBNnNoeDFkLyt0QjlqZEx4alRH?=
 =?utf-8?B?c2tYSUZJa1NzR2hleEg5L3F2M0pNeXFoZFMyYXFHd1owekg4bDlpZFAvL1g0?=
 =?utf-8?B?dm81cU1UK0RQd0tHYkJpVnA2UFdWeis4K1BpY2NJdmhrYlA0emNYZ0UvbEE0?=
 =?utf-8?B?Mys0czE2WXpzYndQUVBFMk9lQlpIQVBMTGVJMzhVMTBWWW5DaGRXVytnV0Nj?=
 =?utf-8?B?SEIzUGk0a1FkSHFiSnI1U1l0Y1hLVDArQmhCc21SR0pwQ21mQWdKdTgzVkFS?=
 =?utf-8?B?d1puc0haTVBiUVBBWG1FWWJYVmdIdEJhTHlCQVh0ZVQzOUM5aFRHTm9xdVJB?=
 =?utf-8?B?NVBZQU04eXV2SEE3MHU1OTlqb01tZlp4TUdWVDc1c0ZuV3VSTnZrODQwTm0y?=
 =?utf-8?B?aTZtZXRiN0xNd0lyYTBMWUhyMG9vTVZsbjJsRXRFMldNbjNYdjB2ak9xU3dN?=
 =?utf-8?B?R1RVSFZsclVZZEJPbW15OXNjQmFlKzhGYVA2ZGlGOXlTZFI2ZjZoK1FyNm1D?=
 =?utf-8?B?ak8rVkQvT3B4bDFZd2NXUFZEWkxyVWJOQWlnbzk0dWdQd0lwMUxRTHQxdCt4?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1289d3-5f78-428f-bafd-08db67e6d512
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:08:51.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHfXigzkjy9nfqOTKqrhv22SGKEH2u4p7beHX7cXwSsYIzd8jUWmL3vb3krFIzrmeDloJEjvqP2KeqFcBXHE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7662
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jun 2023 06:08:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11929

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=6&day=8&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/06/cip.2023-06-01-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  [- 6.1]
* Kernel testing
* AOB

Jan

