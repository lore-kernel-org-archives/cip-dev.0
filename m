Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CAC28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 08:12:18 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.18])
 by mx.groups.io with SMTP id smtpd.web11.9460.1741853537328999939
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 01:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ELZFSuyZ;
 spf=pass (domain: siemens.com, ip: 52.101.66.18, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp4pcB2940SRs9JbNwWaOJPxBP+23/QR4tRgcZGSVV7dYymic60vhpjJ7Ek5n9zmwhB4DesH58L0IkLapTqXo+cM0yzyBvp/2vdpEz9oKR3N2GdrPX+txP0f+Cz9Og8LaKX7HGhvuc0Rus1Kz5oCy8Acjh73lBMvbTY+Q2htRzuU8NDhM0C21oNJP+MuYZ+FmfB/5x+ZUmlFZTvbzX2Tkmynx4TNEso3iju4AL4+eo3GsjBhsNACzaMg0ZVGzt95KLp7fSl9f04bFGRB2oBg+efLvVpuKw8C8/GvwC6+Wyrc1pQz08qncLzGN3kk0qdc9HdlvyaORVVfBVQ8t4KDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcn0YfofHyMV46C0/ec9uLoXLo8pn7rUR0nwSenoSJg=;
 b=T5c7R0LqwEaSvpiBQEyBJ2JFRgnvXivv05f8lucMfM2BKgw0+2/BOyyQYNlk/SHQqYsQX0kFbij5nntu/7Ze8QupEuAiTjG5oOYA3I8Yzs7wTtx6aMpK8NASwoZ2L4xvuHFZbxiP7M9v/IV6YAkycwq623dx23vEDBbK5t8pEKBwcIo1KXO928sptOlxNeRc8rtINC8OefUSZP969HYURE1xVhB0bhGbXhegcJuWP6mmpB+jlkav/mA7fJ8tvgXrvbnv/OYIZSkIxAf05+1DgCrrSVusv9OJZWpEfc5Seu/sbSm5AMBK6Q9xOJ9K/SfNFvDP7qhp6VPwHxbJ56y00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcn0YfofHyMV46C0/ec9uLoXLo8pn7rUR0nwSenoSJg=;
 b=ELZFSuyZB4+D2JEsN6heMzd01HBgYCvqE4ltp+JPpdnzrhYmR/L4l+j5yGCNLpQhxR52nTmj0zZsXdFXw42irzl+2iO07PlSvu0bCJvnlSDOHCzsN7nVWy5tOQIgMfhtgZLA72mAc+I0msucsWFC8hKEJ9/iL0l72QfC96WNSpYP95aimbNHkrzfmDci1vBC4TxpVFsgSx9lhoBH66RPAZpNYVsn4n7g6jGxdunOc0YDeYw3sGS5cpehB2aaf21xRxX6+Jf2hxE2XDG1HtHZXFmOyb89znSoVCSYbxKaizbRjADbkx7Coggrd99WAAj3lMOX/0vqpPgP66Plr5w84w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 08:12:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:12:13 +0000
Message-ID: <af8dfdbc-27bc-4337-b899-03236bd23638@siemens.com>
Date: Thu, 13 Mar 2025 09:12:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f32235f4-e177-4ba3-a716-08dd6206c2f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ckhKRzJlR3g0YlZ0OWdrbGp1d0gyZ1BLMkJrRmhoMWxnb1RHM1VnNDB3Z3FN?=
 =?utf-8?B?YlZGdzNxbGt2dkdUOGpMZk1YTDdiUnYvbTU1NDdUQlAycnU3K21HWkZCaTZM?=
 =?utf-8?B?VEVnRVEwNDUwRjQyUmlRNkpuVktHNzMrOWM0YWw4N0RlQ0tPdEZUZ0lvWjZE?=
 =?utf-8?B?ek5nd1ZYV1BPMVkwbFlwaFhGejBrOEZqdkE4dWJoSkNtY0RYdGsrallqdDZ4?=
 =?utf-8?B?YkJ1ZjRDL2lzUHlwUkpZYVNFV0hWZkNqRzR5bnJNQlV4QVpWMGwxREVyMnlB?=
 =?utf-8?B?cDl1eW9LU2I2dll5L04vbDNyU0ltQk1uZWRPMjhYcjlNZWZ4YnRMUXovV1ZJ?=
 =?utf-8?B?eVZrd0lsN21qYXRscWhaeXNsdEsyWk45NFJkaHhGZDRMQ25BRS9YTUJmYUhj?=
 =?utf-8?B?elFwUEhnK3JzZHNhamZ2Q3BPNXRzNlc2dGRKMHFZSmdBeEFaeWtQYnFPdnBF?=
 =?utf-8?B?UWlwM0FBa3NMV3NsTlVjaHBmbldKejMxaUxhZ2JIY0tMWXVYQlI3MXAyL0pr?=
 =?utf-8?B?RXJyZmZFNGVsc0dJeDdCOElNYzIrYXdhSy9JU1d0K1VaR2VJd1RWaUNvSkp1?=
 =?utf-8?B?d3BMREoyL0paWHdUUktmTjRyYzJONUdPdUhjUjF5WXpldk8vQVBZVmN5RDZq?=
 =?utf-8?B?ZEE1QXpUQUVOekVNaWZjdkE3YkxmQ3FVL25MRFA0czZtZDBBQjBJcXYvVkRs?=
 =?utf-8?B?Nk9aNUpLd0pVcU1NY0RzQ2ZtOUdNbDRFdytweS9hbmJZbEp2YmRyakdoMStJ?=
 =?utf-8?B?K1FEZnlnUHI2OGZBWm5GVzNrSFJ5b1RtUlJ5TGZtRjU3RlF4R2t0VjJ6cWxa?=
 =?utf-8?B?L1JGaHRRRFlWendsQkU5YWZ0aXVsc0ZWRHdRYklwekNsWW1sVmdDT1ZDN2RY?=
 =?utf-8?B?SDFNcURBVEdhb2RmT2pZVWNocndlWWk0Mkl0aFlFV0tPcUo3K3oxaUxKeStC?=
 =?utf-8?B?amI5c05RVmFZZDljVW11RURRMjBjcGt3dWRMTnpwQ2hLbzM2UUxia0pjVGVo?=
 =?utf-8?B?bEErYjk4OTdxTkxhK3NjWThlZUdXVnZzcU1lSmVUNVl2YzUwMEQrbHhJc0Yw?=
 =?utf-8?B?TVptcTVOZHJHT1FGYzJKeDNKK2pINnB6S3lrTEVXbVczTDlWSlZVSWxFVU9w?=
 =?utf-8?B?Q0FSS1ZiRXQyS2xVdUFJWm9yV3dmeVl5cG1RU3Vkc0Y0cm1RM2NmbnRVY1dh?=
 =?utf-8?B?NDh6ektITHFsTHROcnAza2tLbEk3eTIreTlhaG43V1BhQ2dua1hobmVldEV3?=
 =?utf-8?B?UFNycDBRMkZWdGRMajdwSEdaY3FWRE9wRm9vZ3NPSzJpU3lEUDhlWlJJOHNq?=
 =?utf-8?B?WDJLUC9NRG9iRzFEK1MwS3pRbUJOY3RKa2tPOE5DZnJKVGdDQkN2bEdZd1FK?=
 =?utf-8?B?ZHB6VVMyamhWMXQ1bWtwUllXQlNGbnVuNDRkeS9EcXErd0pjU25TZ2xRTnFs?=
 =?utf-8?B?S1Fjblh0NVRFMVdiWHNqOGxaOWFMOUpFOUJpNXo2K1JINXVBY29MNGtOM3Br?=
 =?utf-8?B?ejZlVi9PVFp1eTlJbjllSkdFUDVXK0s5YlNXMVR2bjRDYWFrd29JbTUzKys0?=
 =?utf-8?B?NFYrNVBIaGhpMUdiZGVOL1dxaEJtYTk2bUdCc0w5UjZEbFd6U04vQnpWei8v?=
 =?utf-8?B?VU5oYzBHRHhrZU54NU9EbXVxOEE5SXpNTTBaaU0xRHlvTXBEeFM5c2VLay9o?=
 =?utf-8?B?QzFRelcxV251VkpwMWg3SUllTkdHWEIzWTFsK2ZmTXlEcmlnMmN0QlVZVEdE?=
 =?utf-8?Q?qjoxPFx3htK+tHT4l42u898rbgpwucfXa9cfFyj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3N5YzNrU0pTenZ4QnZRZzdjTlN2NFBEMlc1a0syYVZ3eGxrNkJPVXBzOEFP?=
 =?utf-8?B?eHZQcmRGYnFuViswMzFLWXExcDdIMTNwTlJSbUVNdWFHWC9IUk9ldVA3SlJj?=
 =?utf-8?B?N0dDMFV1R3crMUxqZElqdFU0S04xUkpOcGVuNHozclhCbm1iLy9KRHN5dzJH?=
 =?utf-8?B?eS9NZWZXbHdFQ0NKcjhIdGl1ajZ1WG9wTlk0WTl3L0JEYzhGQ2ZFdFZ0SFFS?=
 =?utf-8?B?K2tuRFU3aEpZeGxPRGFHbFhiU0NQVmFvd3BXZnIxUldNNy9SNURCOUUvRDFq?=
 =?utf-8?B?Q3dDUmdLNGp6QWloenRLTTZ6cTFJeWVQenZ0MHhhNVVLTTR6SWx2VkszaVFO?=
 =?utf-8?B?WXFodU1tVFArKzZwbTdraXhaTjBndS9ZSzRrcWtFbnFUQVJ6QVhTMnZVeXVW?=
 =?utf-8?B?aVdRWk0xMHViL0UrbE9mWUVEdnNNcmxPMEI2d1dkTzdqalFPODRCcTNxUkV4?=
 =?utf-8?B?Qk9CY3BxNUMyQkRuWHI3MlhCWk1sQVhRQXBvMUM5QUkyQ3F5aXhNWGM4UGJi?=
 =?utf-8?B?R2VuZ1p3a21JNnM2N25zWXNQdEJQalY1eS9SUytENnZlbi9Hc3dVc2pRQmdE?=
 =?utf-8?B?aU13R2FFSTc3bVU2N3VhUHZPZkVoZDNsZFFvOGI1bHplY3dsRzRWWURMbWFP?=
 =?utf-8?B?bG9tNENqQXZ6bElTNVNicThnNUttWXBYRW9TYVBvcEhVVkVWbXNMeDdLc3JG?=
 =?utf-8?B?SUlHT3krSDNQWmpKVG5vaTJYZHlMWGFJTzJRSCtIQ3NhMyswcHMwbytzYkp1?=
 =?utf-8?B?R2RPR1ZWZlVjdVoyakJRU3FQRGhyT05TckowYU50ZmNiM0lJekVTamRVMCtD?=
 =?utf-8?B?ZktsZXF5OWl3VTJJc1lkbDBDclo4bDRQQTN5WEtqMllFSFdLYy9GSjVDZGZt?=
 =?utf-8?B?MGhvN1NqS1o5bG5XNVJ3Q2RDaURKUFVwUmFTclNKZi91TU8xSENieUtHY2VO?=
 =?utf-8?B?TkhxeERkY2UyQWN6UzJ2Vkp3N2RvbzlRa0gvQ29adUVBWE04S1RYR2hlcEcy?=
 =?utf-8?B?MCtzYWJFRzRNaXZsSXdrZVhpcFo3YnBIY3laNk1BL1RreXV4RER6SlNIVkFr?=
 =?utf-8?B?Ti9VajFodjl5bWduY2VKOFpmeFFDbzJZbkZlTlVBZTcySEdLUWYyR1hKV2w5?=
 =?utf-8?B?emxHelo3RDc5YW1SR1huSlhQWlVTdEUvY2ZOSTZqWDhTb0lBOTV1VnBBMXFZ?=
 =?utf-8?B?UXM3SXhZbzhUS3oxK05mZkQ4STdDSzM3RG1DRmF2ME9ETFQvRFNsaFZJOVlL?=
 =?utf-8?B?Ky9udnFyYmVQc2RtcHp6L1JUdEtlem1KUjBYbG1HSXlwMWo5dEpkTW9Hc0NY?=
 =?utf-8?B?c3lVdWxFZUZnUEMxZ3kxMEhkeG96SWZCdGltbXdsMnBoNFo1ZmJLTjJ3YkhU?=
 =?utf-8?B?ZkNmckFNOWoreWxqMWNzSXorNFFPMXJObC9aZWc4WU1vSUdhWldqYmNyUVpJ?=
 =?utf-8?B?aTFoYWNHWXZhTkVPczdteWJMckFiTmhFdEhNTzdnMzhoak14SE13SjczWVBY?=
 =?utf-8?B?dEZBVzFlbDN5YkxIY2xHWUZsQTNtOWxONXo0R2MrK2dGUGJ3OXdmV0xvVU1M?=
 =?utf-8?B?Z0w4SFBSdnBZSk5WTmMxMFZnTTVQZTljRGdsSG5KTDhaNm5ZRUlXSEk3Tmpn?=
 =?utf-8?B?blFEaTcxVzdJZXpseCs4aHBGa3p0N0hvb3liZXIwOHR2WkV3UDRoT0p4ZWNl?=
 =?utf-8?B?VWlnU2tqWnRLbUVpUXA5RmhJVzFtdDZDRmRMbHp4cXhKT1VzclMvUmhONWkw?=
 =?utf-8?B?U0RnajZPWjN0OTF1T1crY1I1blc3NmlxT2ZBVlFWLy9HdDduenBxNTlnK0Q1?=
 =?utf-8?B?VkRWVEZoc2hITld0WXlLaERLMDZZNnhKMXVndE8vUDRnSXFMSlhoS2gvU0x1?=
 =?utf-8?B?bWVra1lBS3Y4MUdyY05NZGxDSnkwNWpJb0hQZHFEMDBrdVQxOHdySmNGZjFU?=
 =?utf-8?B?WjIrYWRDbmwvNWk3M0Z1OVl0akpUVmJJN2FyVWwxZ0lady80dFo1RGZBTmNU?=
 =?utf-8?B?ZWhrV1BWVXFMaWwzVVJwSVU1RFZ2YmRYbEtwYmJ1RnYrdFZxNmQrU1VHTk1F?=
 =?utf-8?B?RUd5SGl6bDA1WDhQcGpxM3pjY2pyVzBENFRXaUUyVE5YY1cxNGJ1RjJTSHk1?=
 =?utf-8?Q?NNixHlHhDlOiG8x4AoqLZmkW9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32235f4-e177-4ba3-a716-08dd6206c2f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:12:13.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NvR8Y+8ZahlUoQpxpoPXdmnb7wb9YO4RLn6o2KmpWxuD55XMtJi2OKKdwlL6LiX1gx9nKFyHnhzEK0km3/bmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 08:12:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18184

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=3&day=13&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/03/cip.2025-03-06-13.02.log.html

* Action items
  - share release scripts/procedures [pavel, iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - backup host for meeting on March 20

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
  limit date: Sat Mar 15 07:52:32 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Mar 11 09:13:42 AM UTC 2025
  limit date: Thu Apr 10 09:13:42 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Feb 13 10:01:34 PM UTC 2025
  limit date: Sat Mar 15 10:01:34 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Mar  5 05:05:09 AM UTC 2025
  limit date: Thu Mar 20 05:05:09 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: On track

