Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE96C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 11 Jul 2024 11:41:20 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.65])
 by mx.groups.io with SMTP id smtpd.web10.9808.1720698072208601819
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jul 2024 04:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mUVOsUqK;
 spf=pass (domain: siemens.com, ip: 40.107.247.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czjjQ5Lt0iExRDG/lkBZ3rG2ZMvrJfmcVQnj5nY2Hh66QJHRx1pwANAtKPKDyAxwdYV2w+ewMEB7AX+px5Mm3NFL5ygOB4SsJWjkbdfCBwFjMjaKS9DRjwGpdp9WR1UUxHJB8sI1vxEGWHaZNoXvnY+nTpCfQqueg5VoR3VwD254MCm5mvHteKGTJ/ix65BaAgms4JY3Jd04NSXJXHB6XUftNsfcnKWoC3HWvQgHMozns4qKtTyelC1F/UueiC+hTI5trgv7Htp5jRFA4G8yg9qzjm2KSyCJZX0vzh/mgdZD+K8ji72gBmkApWhPWuP/fHFHQOi5mPZDT7tsKcfUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lN6pATyLvHEuGR8MaHbm1/u++0fNp4hiC61SKUhlT4=;
 b=tTpJZiBvYEgKQs+GxFbHbqb9YD7K3Onl7M/lSNSxRSwDcosFen5srG+gQTEHUqXhN2q1dTyFyRJL5Z+QZpOPMFDY3Yon48LbTGhsiUS+W5IsmxydX//LP37pSQGQ0DjbUEHCKvUmG62tcL5wvicPfyn/Ta7xgR6yXkcL6lzOOokJp0mv3QZXYAk7+SSawsx2/zKv2xeZ/C129co3CVdr7k3jXtuGvMotlQQ+H0kPy3upE/XB5P51hqqKQkGC9YqrYMZqX2EFdOcJtISXDTvxe4nV+z3K5S5pjJDUEx4viLV5geSV9bPGaryDoxLgCNkRVIW+bze7wImNNrQG/lXCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lN6pATyLvHEuGR8MaHbm1/u++0fNp4hiC61SKUhlT4=;
 b=mUVOsUqKuBXWbrvjopywbo+VgsdyVMoOXGf4CTWNGqu3Y8zc0z+D5RFwUyXSdgPRJohz06mXjIfTCTSCJxWzP6V37KSIqslhQYxdMnQ9VIUI3FfwVWQlcJShqss21c0+xCznX+EeshPpnPQrEpVRddBN8qfh6bny6Jrx0ZbqC6rV1V0jOFZOMfAcCeKsm7fFda5vqvGpGfgB8A2C6sHV2GWy2+X1cLdSP0OeuSLPUZvze36SpuMvLMmOUp25IGNz+8URMwpYAwChIUpkgARCTMOVdGvhVziHoQKs4oGWOdCKoVr7n/rmhTe8rz6b6y0nnoSOpwB8ml8FmF/RZUMVGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 11:41:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 11:41:08 +0000
Message-ID: <0a5b7ddd-f045-4f95-b57f-88204f66d134@siemens.com>
Date: Thu, 11 Jul 2024 13:41:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3353:EE_
X-MS-Office365-Filtering-Correlation-Id: 93da0f9c-adf2-456c-dd90-08dca19e5b2e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cUlkNFExRk5TdEEzd2FUWXVOZXNvNEkrb0FnR1hNU0NKem5PRkxYVVRLWWNP?=
 =?utf-8?B?MGw0TWdhRHhudG5EN3NsSHRBY09Sb3k0bW93SGVLMkV3RWNodjRvcUx6WlFs?=
 =?utf-8?B?cy9hRTVTby9Sd2dtS3FyM0JlZzBXSnlNU0dWYXQyODBLWUhLVzNtK1JMZEtX?=
 =?utf-8?B?WUZIV3NWZStBMGlKY3ZHSmxMY0lxQ0puSm93VUpmeFB4UU03UTRkMGtvTUw0?=
 =?utf-8?B?LzFvbVR5anViM0QvN2dIeUF4Ynp2bEFTb0dyZXVVR0VwRUc2NHcwbFBlQ1FZ?=
 =?utf-8?B?ekEzMlNFNGxEbDFqelJMendxb0IrZjhFeVBqc0RZeDlHQ21aaWFveXNIY01N?=
 =?utf-8?B?bXROSDlkbU1NM3VlQjlSQ1lKTkdza3JFSDF5UkdITGVoVE8raUt4ckMyZzI0?=
 =?utf-8?B?UkhvYWh4eENBY05JNGlERVBOR253QzBVK1ZrUituUkxrdXZMaEtWaWNPTjl2?=
 =?utf-8?B?Q1M3akFpWXpTajR2Z1I1eVBDYXkrRWk3WU9URGFmU09VN0dmNzZZelFZSzZk?=
 =?utf-8?B?NVNuRUphZzRQa3ZFTCs2MjBvRldBSWZsT1A2bUQ3aGV6M0hwT25wV0hJckRU?=
 =?utf-8?B?VkdsaFpxYWFVQUdtOXhMZHF1UTdWa1c2UGdrc0dobGpBVWp4RzJ4blM2QzFP?=
 =?utf-8?B?UytoK2hQM0VBVHJ4VkFuOE9uZ01BNWFxdm9tdTdKNzJNdGM0bGlxK211WnNX?=
 =?utf-8?B?RDYxMXdNbDNGNXg5V0dhZTRzdE9tNlgxVzZVQlp4OC91Yk43c2hNczg5Rm53?=
 =?utf-8?B?a21HdmhvamtYWVk5YzRlZEwyOCtTMjdYUzJ2UGEra3JmZThFMDBiUzBIKzRT?=
 =?utf-8?B?L242ZUNzVnRpYU5rT1U5UUEwNTgxNTFveXBRd2Y3TzJjTzFjUi9oM29xa0c0?=
 =?utf-8?B?NjBEN1cxcG1lOE5qMzdvSEhBRkxndUNoNU9IN2FZOUpFUG95cVI1ZVBmUEo2?=
 =?utf-8?B?SWJSS2xJZ21jU0JsNWQvZUtlK2xRaHF5T2d1aWdHemV2Sy9xODlxdW1IQWhB?=
 =?utf-8?B?UFJKcGliOGUyQjVjZlJyc3Fyc0ZCVEE1a082WG9IZElBeFFkbFQ5Qkp0eGRw?=
 =?utf-8?B?amducy9GbTBYNnFrSitmNWhWRWtXbklueUdNc3IvS3lZUE50K0xIZnJkUGto?=
 =?utf-8?B?L2N0RTJhOHpQVzU2QWtrTTY3TGpxdHZNZkd3ZENJZm5SQXR3MkY0T1psOTlz?=
 =?utf-8?B?aHMvVm12dUp6Qm1hOHhyc3JQVmNyL3JpS1VTcElHWm1PRU1uaEJjSEltZHdm?=
 =?utf-8?B?L3ZUYURmOCtSN0RuSEdXcXByaE4xd2tWTWVuaGVWcks0TDVvVDI0MmtjVTk4?=
 =?utf-8?B?OG1qazg5NFBIaGxOQ2ZMZVl0Und5MkVXS3FnMXlEUDFLLzZoOFZGSFEwbGxz?=
 =?utf-8?B?K2tpZWlpdFVmTmZMbmtrL0l6c3ZCZmI3RlFUTGNlQXhLOU5nQW03UTdNVGZY?=
 =?utf-8?B?M3k0NEk0ODJQeUdRK01QQTJ5ZVBBN3RhTHNpTWw1RnFhT3VZc09kYkRJT0Nx?=
 =?utf-8?B?RWx1UDd2UWpOMlJSbCtzNEJ1b3pXM2ZrSUJmT3lYUmlrVC90ZmV1SW95SUxx?=
 =?utf-8?B?WVRCKzJPSlpCYzNzWDVlSTFzOENNeStIN3RKMmNONkZXMFpuVFgvTHpQTzRJ?=
 =?utf-8?B?TTBpaHZ5ZkFFV1lvMWh1cnJiQ05QUEh2L0ZDOEpOZUhGU3V3YWlhZ3ZjbGJZ?=
 =?utf-8?B?dHlUK2tZcE0ybGtUUHBrNU0zVGpqbm5lR2RRa2ZIWC9ONm9DblBEbUZGZGpq?=
 =?utf-8?Q?QBzYVLXaLUHHI7GVRQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmhTc2g5TnVWeWY4LzcvQlFIMlN3dEJwbWoyNHZPbDVVL2xxRUtUT1pZeEd3?=
 =?utf-8?B?TWdlSHpDYkJkZjdUSjB2VU82ZzQ2ZkpSWjFOelpYRkoySEc4NjAwUWpVWlRW?=
 =?utf-8?B?N2pteFNJcmpVeWZTR1hkU0ZMdTIyNVZGRTVwdHQ0dlhuSCtwek1DVGJTQ3hG?=
 =?utf-8?B?ZFR3UHdqbEdubE1OZUZzeElYd3o1RjhOTDRwa0x2VlJyYjkrWVNtaHZOZ3hj?=
 =?utf-8?B?UEFXTnoxOGdjejl3TzBOOWRSUzdKY0Z5TnlkbWJsUG1NSXpQQ1JDdjlocnNG?=
 =?utf-8?B?NW1yODNKR1REYVBxckJidlFPY2NIcGZlcE14RFA3NGtCck5VMGRnL0lQTnhC?=
 =?utf-8?B?WHRxNXBzTUYzOFM2UDdIUkE5V0trTSt3a052dHd3RENqRDZVcDUyMHJIZVBz?=
 =?utf-8?B?VHdCNzR3RzlXeXlDQjhiWEZhSUl5M3ZJb0xyb2xCbXoyOTRaU3pEUXBzbkg3?=
 =?utf-8?B?Q2RFL2lWbDJtVDNCQnJCenhWbnZwOHBWTUQxaHErQ1doTHFBcmo2a09wZTI1?=
 =?utf-8?B?OGg5enRUemIxL1YvMjRrTDFNcVNLNGJMcEt4SGcvT1JWQVhqdWNDWnJGelU0?=
 =?utf-8?B?TzFTZmNlN2dzcmpmc3VoK0V3VityMmp4eEtDaWIrTC9EVFNGekdMbkVDSFpJ?=
 =?utf-8?B?bDYxaTJnU2ExQWpEN1pTemRDRDIzM1d0UnU4emlzTGRUa3JEZS9PV3g3OWVM?=
 =?utf-8?B?Sk01Tlo3RXZ5T015WjhGRGhDeFMrK3VHdVlCN292NlNTUlgwM3VrOGRpRUVp?=
 =?utf-8?B?RTNyeWFmUUh1aFdzbExxeWZTQzU2NlpUVUVqaS85Z25lT2FieHgyc2JtZm9h?=
 =?utf-8?B?ZDVMVzk5TTk0YzlSZ2tBZ1lCa3NCSFNiU3NDbnBUNFhtdWdmZWludDJXazAy?=
 =?utf-8?B?OGpZa1RGcEFUdmU4UXBtY2ZheXhJWFFDb3lLNTY2eTErOFJEVytyWWgxdk5h?=
 =?utf-8?B?Rjc0NVVIK2dSelBGWlRLbXN0OHBHU2VKc2tPRmZTNWtXV0laN1hXakJIalZ6?=
 =?utf-8?B?WmJZN3VndXJoRCtRS3dGOUN0ME9lQitKMzBkNWlZVjE1ZUZ4VkJ3Y2RJVTB0?=
 =?utf-8?B?b0pYRWkvdTFncEZpbmRnT09ldmdackZRY05hemtHYk91UnlpN01jNWZ4VGIy?=
 =?utf-8?B?UlFwTkxyWWNPL1E5NkI2YUFVR3VQcjcyUm83RjZsT2Q3WWV6b3BkeTJkY1NR?=
 =?utf-8?B?VVAvZmQ2TUhqM2ZlZU5YVTRmdXEyVWlaVWM5NlB6Q2ZDK1gzNXFvajFha3NE?=
 =?utf-8?B?c3RtWUo4bEgwdU55MUNkZm1IL2QzLzg2TTV0K1R5WWk3R3FKNU1RN2s2cUJz?=
 =?utf-8?B?NlJMWHlEWFdTVUZ5bFZSUjRGZHo0MFdFZlFYWEswZWM4MkJ2WHdtS1pmNm8x?=
 =?utf-8?B?cXRsdVU3a090c3V3VERrbU0xRU1KM2szdWJQZ1ZSR2FJd1pQVkJMMk1GUmNq?=
 =?utf-8?B?OVd2NGtySEVlMjJvdHdKcTc2aHRPQys5MFNnL0tOM0xEc05ubU9rOS9KU09s?=
 =?utf-8?B?bzREc2JhVkpEc2o1R2ZkWlhjUFJhZ25Ba1BVMmUxOEdZMkFtMUtRK3ExS215?=
 =?utf-8?B?Y1JWZGtkSFlza1NtQkg1NjY2WUwybEdWVmdhYW1BQTd4OW40RUtyYkJybDVu?=
 =?utf-8?B?WUZZQkdOVDVpeXRSZGNiaDVDRmhMRUR1bW5Cb3Uyd25uUVJFNFZFRW04MjI5?=
 =?utf-8?B?bHBSVE1icnlKQ0txSzE3ZVhyK1czd3BMMzVpRkovRzZzbkUxOWpCaWZIc2d3?=
 =?utf-8?B?Yk4zb1ZOTk5Dd213MTY0WnFoNzNid3Mvbi8xSURwTWNMVk13Ym54cmFRYlIw?=
 =?utf-8?B?MlBVODdpY04wbi9HeFVFSDJ6VlBxQlBxYkR4cjAvMDhIVVB5S3RYcVVsblNM?=
 =?utf-8?B?UkQ3VEVOMmowcDVCNXB1aEN5WEh5WWxzWTFMd0gyRUgva3lYNXl5R1VkRThG?=
 =?utf-8?B?anI5TzFCdmtPQ0N2MWphdm8wY3JETTBGOGNmMnhLbmVwMEd3VkhJR2N3aldZ?=
 =?utf-8?B?bkRNTzFSTEVWQUZkQVZnT0NKOHhmRnB4MDBvNHZtbVJoMmNTR2JFZ2E2WmhD?=
 =?utf-8?B?MnJkRjgzTVNUZDVWY1c3TkJuemZVVktKakF4dFR1b3pEVnFONkQ2bEVYSmd2?=
 =?utf-8?B?SWVlSStRYzJLWkxVbmJxZVE2U0grY2dPbEs2bFJmRkplb0lTU1E5SU5tREFt?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da0f9c-adf2-456c-dd90-08dca19e5b2e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:41:08.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5CiN/FN09vPjb42OQTdS1o4kqd/1tXfz0bfWaibNVI2mfPjtBVXOtXnNPfYfPomqKfp9Bx76F7qtZHoWqoBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jul 2024 11:41:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16450

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=7&day=11&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/07/cip.2024-07-04-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul  8 09:35:34 AM UTC 2024
  limit date: Wed Aug  7 09:35:34 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
  limit date: Fri Aug  9 07:05:27 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 10 04:51:56 AM UTC 2024
  limit date: Fri Aug  9 04:51:56 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Jul 10 04:44:51 AM UTC 2024
  limit date: Thu Jul 25 04:44:51 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jul 10 10:22:07 AM UTC 2024
  limit date: Fri Aug  9 10:22:07 AM UTC 2024
  Status: On track

