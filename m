Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDCC4332F
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 06:19:19 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web10.126813.1671085155649768609
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Dec 2022 22:19:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T57f3+Dg;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeY410juWoEBNECeeqWxZtDuYxX6cjsdpy18J5tqS6uM69Dl+hdSwAdz1xuGrM5TULq1BKknoi5Zp9SdphF7n6MML7hBskjLZSIR0eGkz6VOqirgCywUjMH5ArwJrbXYQ4NwEEUCLDWhCgWZ/60Nu+eCSz9mpnQs31Gt+0cDBzfNpxXIi4avJYj+wHYdM66HP215uSA2f04uSGugSkPri+nvHCRmWv3r4BHf8SGbKHLvUmt0HzcFBUsExWnCtzY5xNJezad2mW48N9kWkXFmdvISwi5fOvqiiPv033/PtznHDPolwrBD+M/GFCfRp68zVmBC32SsB0YylJCmAGriIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTR2uUUK0FyK54uIubkGA5DLw+GHMfElmyZ1wBPRTv0=;
 b=LiKZzcAfsZbLe2puAAxhUAFSez3UkVu588mVwClRqMlsFONiUQ7DxuGMSA5Pwq9aUoWG0TJsqTQhoLoDscdl/7LwGr0K7ipjERNOpo4wkp+NuBLccne/E90ylkoCO8mo3vUosxZ3KPLD5wqTcchAUcA9aqi2ldTyAY65a/P1abIZVtm55SBN5RYKStjUM7nWxEeYUqNngovPeG/i72rw35UTSYx0AD/4x4y3zVcM9Iflk8MjiPZU6uqnUyU72TFqHjMY6fTqkgXpw8/lKN8CzlvPxx+W7lGe/MIFudlWI8bd01nQwHft2AFjiuUwKEjZfTF6a9/OyI+W87vzXWBObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTR2uUUK0FyK54uIubkGA5DLw+GHMfElmyZ1wBPRTv0=;
 b=T57f3+DgPjn4CnwHt0Egf3/QzLY71UBYacQg4OqEyslrwveWhNvqMZ+TWfK13zLROK4H8bIfgcVnLfn72bKTfnfGaHy8gkrBrb/e1S75pTNq0Nqr2HYC63buKMJW/so6kO6g4o4hYVBeWbn2Vq/2TX/bA1yuKAHT8ETA9Bn4vQXx0BwkkLQO6Z+cqdBtRgduXmw6KhaHFEWhG+SbtPExDxyNx89GcVYETZcm6BHDOg/aDUTWFbSKKSLZdOSMETlrITINGuT+maSHHoeC6o3ncuqQtIFkm3bP0WJG/1UA5aSgD45mOzOQ0eW67Xwv5qVFCdQKZZbpx6LvhSjQfgJpbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 06:19:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 06:19:12 +0000
Message-ID: <5fbc358e-32a4-f64c-4af8-842a1344cb8d@siemens.com>
Date: Thu, 15 Dec 2022 07:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a209fb1-c56c-4531-a476-08dade64488f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tujJjB8+eiuB5Hr1m38HeI8/ZZe1wmKeXn1QtKnXmtvbNJtokGCsOz2xFfEBBMdu2QWou/f6zDz6p4NQ01I/4fvd4RzCbYE6fysxCo3dOD9Dg1G7/YbxPDrNAYgffPDEziPC7yC9/LAWj+tVvKwDdGglTj/VLetAfU566+TgI3ZDOvuc+HiSigj9thS+L+wS04qbLIMBuIKH3V3AdnCZkTJ/i5l69IQt3e98s31EhHFLcG7Fdis76GHnF1N7qQAI1It8DGFD0tnxQiHOwELkVa5aHQapNMGp8FEGl+xCvoJ93MvrOG2LINjBdZmACNbdr7/FL8xs8Yj1PouZOd9m/l6wRKs1AWqxGlj6tqNpAwZEd58QSzEtI5cA2lBfBsV8iTkG3d63E6D1rMFKX+4K9/WUSjC8dAcKu74TUddnBFpBw1U1fyJMIi2+C+PKwATB14SUR2Z9vd0Vik0mF5OivmNmQIy/0SKEQEbv3AQtRarYjgKJvyR7RzCD+iP4HUSC5yv5Hmm9O4MHgVRZLyOVJKmEG1eirUEx+Q5SIYbt/ZlZ0gRJQ6cpVMm4Po2E8lM1EM+VnyRqfCtaTYNlHc7NWukxpJ3klcf8r9bfiK2+WpW6vVAYvw26MDGlTby8HvI7wJrM2iO/6hMG9N1iNEvk/PPaCHMIGNFHqtrUgcihsdNsx2dbqMV1T+FT87ZP37BMNOtdBqNc6N76D5IXLcUdN9KqSvlgraw86A5FxwJog783hq6PQH+XhVMXEW99j0dsx+0V5XFQUszYWSIzoGKMw7BeCR+VOCNPXKwkOcxhsRbuQ7de36GU7ntvFTlI8N2X
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(41300700001)(66476007)(44832011)(8936002)(83380400001)(4744005)(66946007)(66556008)(8676002)(5660300002)(2616005)(6666004)(86362001)(38100700002)(31696002)(82960400001)(31686004)(478600001)(6512007)(316002)(186003)(26005)(2906002)(36756003)(6506007)(966005)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2FXTjU5cTJoaTJBdVJSUUxvY1lqMXBjdFRaR1RVcjEzaUREQ1JhMFNMUjUr?=
 =?utf-8?B?Z095L3dGZzRYWkZjeERYcXFJcmpXTE9POVBNYW8vQ0hrbGJtMDN6SEM0OTVK?=
 =?utf-8?B?eGM2MExiYUVNMlJvcGY5cTNJd2pkaVFTTTRob291U3ViTmRLekkrdFVMZTlh?=
 =?utf-8?B?K2dGWEtkN2xPYVZLSVkwN01wbWVaa0IyQTFFcHRGVmlqcnBIVHAzaVhVUnRK?=
 =?utf-8?B?bk9ja3l5VzFyeUYwWjgzNWlySHE0TERtdjRaenFMK2pSR2k5T1J1VlhjdUNN?=
 =?utf-8?B?WHA1WjlZRC9vOGFrTHF2dm1YT2luVi8vNTQvSXJTZFFKdjUyWlQ4eDFmVlhL?=
 =?utf-8?B?UGlTbXJzdFgwb0twZTNRQWFJdW4yVytWL3BmbFY0aGdtZXVoaXBGSFVqalU3?=
 =?utf-8?B?YkIzdVdBSEVwWjFCNmxmclNKTlVRbkE1ZDNpaFhLRTFkeVBpTEZsR0FNT0Vp?=
 =?utf-8?B?ZUd1S1BEMnV5MG9Ia2VpVnlRTDVSZm01ZUxPNHpiVHdBanYrcU5ybnJ5L0Vm?=
 =?utf-8?B?MkpuZXJlOU45WkRPT0FHM0pNRjhRQ3ZWSklDOHREV2VObnkyeUV0bjU4ZFVY?=
 =?utf-8?B?UnMyQkdCMFozcHl5Y2hMVmh0Q211bGRKYm5UWmE0emtSclR0MnRrTDBLN0VC?=
 =?utf-8?B?SDF3MVhHZGF5QnprVVA5dTF2NG5BZk9YaUtsSzdUV2dZTzFpelprL1RwbnNw?=
 =?utf-8?B?TWRCSlkzYkd4ckZzTkpNY2NVUDBBSTErdDRHQk90cGt5a0dBL1RlTEV5VHBV?=
 =?utf-8?B?NUZUSzNNZS9KbFNYTEYzNDZIN2FHOXRwWkRqUXo2QUJQUFZKcG5zakVpYXNB?=
 =?utf-8?B?OElSNWhlYVRpUm51bXNZaTZyZE9kVHJ3RXM3VWpmbkp1QllFMDEzY1czbkJi?=
 =?utf-8?B?cmxUUVpIODN2M2orcm9Qc3ZsZEp4bU1Zdm5QTWV2dENVUVlGRnVTQk9ySFVa?=
 =?utf-8?B?dkF6T3pVQjFDQTIvczRLbVhPUUo0WkNkaG1KMEJvVEczMFNybWFvNEFRYVNj?=
 =?utf-8?B?T3c2SjUwOWczU3gxcjZhSHRNN3FqL0VjYWYxczBiQXdiclNDSk02WEw5aGFu?=
 =?utf-8?B?RXljdGNIbUUwcjlRTmo0ZzFNVHRMVm1XSkw3QWh3ODFVb3lSa2ZxYXc4T0lG?=
 =?utf-8?B?Zjl0TUt5cW1KUWJ1SHZCaGFiZVI2WWVoUTJXaGNyR2pTS3JQbVBYdXhmL0Nx?=
 =?utf-8?B?U0RkaHJYWC8rVmxOU0twT1A0S2psOXNmNkxpby9sdjdObWRPeUVuUm9jaXE4?=
 =?utf-8?B?ZCtJWFJDa3pDVlJrWEFYZ1dncFY0MU9xay9pdHlSSW1kMmJvM3NLMFNRd3or?=
 =?utf-8?B?ci9ORllYeGxsVTZEanE4dHJPVkkreG9VMGVRcHlCTFBTK25CYnpwSXZvQUd3?=
 =?utf-8?B?WEdaMDgwdTBUMVFrREhyTWZlTnVGOUpkUDB2aTd0RjFHUXNLZmlncFk4cDBv?=
 =?utf-8?B?c1JadlhzOHR6Z3dweW9EaWlLOFAvOFREaVJGaUlzamg5ZE1zU0FlTDBjUXlM?=
 =?utf-8?B?SENsQ1ZNZkRZTDhNSFZJMTdlampFWHNuK2xuamxhOGxySlhrMC9pZnIyNVo4?=
 =?utf-8?B?MjBCNlBhSEEvdkpvamxyRjJBeUVENnczQytjN2w0VnhJdmZUYUpML3I4MEE4?=
 =?utf-8?B?WE8rTWJPQ24rZVBnakoxYUVIa3NPM0ljNDhIa2ZONzZHTXlPaUdVRTdubVdB?=
 =?utf-8?B?ZTN4MjRLVGhUaGJ0YWg4YmJUQnB4cFJNVG82aE1wRGFuNXcyVTFEWHJ4emww?=
 =?utf-8?B?YjN5Uk45NEFCcmM2VktzZzFRK1dQd1lvNTB2bmR6aVNiN0J1M3l6a0cvWW8r?=
 =?utf-8?B?TEQya2ROU2RqR2FaMlJhK2Z6SG1KSmJCN3hzY0pVS3NnYVVaZnBkRGc3c2Nn?=
 =?utf-8?B?UXR2L08vVXJHR0ZlRnNLTzVIZE9IUkJ6ODZ4enAwYjZIWDBSeUVwdDF1NUU4?=
 =?utf-8?B?Qi9uY1FOZlp1OHRPbmhGKytMY1d0c21kanByVTdnTVN1akNqT2ZyMjhnUnZK?=
 =?utf-8?B?V3NwWXZncG1RYVc5SEprOFNzQWFhaXgzZ3RmL3FVSStxS09wdXE0eWQvQzdV?=
 =?utf-8?B?cUI4WmdjRnBWeEFiTlRwbGlKMHM1VDZYdW9xSXB6ZWJzNmlvTmtJbkNEN2xI?=
 =?utf-8?B?ZmhWVWhpOGkvUCtvR1F0cUhKL1FQc2lGMzJVaDlsZW9FYUhsUkN2cUJwZHcy?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a209fb1-c56c-4531-a476-08dade64488f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 06:19:12.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjC7aGbZttcwyPX2gDXpLHJ2LqjcDl9o8MO0O5a33RVv208q9lB8vpwlxexZrwiEBG/lB6sEW9n/b6GcCb2xNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 06:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10231

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=12&day=15&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/12/cip.2022-12-08-12.02.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB
  - upcoming holiday season

Jan

