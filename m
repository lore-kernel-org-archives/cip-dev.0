Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E5EFD23F
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 05:22:48 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64171.1772083361546743481
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 21:22:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qNEIh47s;
 spf=pass (domain: siemens.com, ip: 52.101.72.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCEvJe1L0ZjdpIgPQVM/7rWnLBnXCeHPciy/a4FFDXUBf2hlE2W5iecZ9vcLSoyBw0WVWfjWz/oN/Qke4l7Lq6hy3fKBsFTtydPx9Fqs3fAruVEkH3VOXQZsDMLI5SREy9Fw9IFMlgnJLTJEWUFrjanbQjSpvsdrvYK0RECOqzbCf7QnvdwwE7w6c5GPdLCjWDdQqd3Oi0P9zIKupB2/xc+IcnG0UDjukAyieFYuuuFD5WzKFaYFKZqdD+Sk55OWV8X5+j8GLjCZFrE0/iQWXt0ZK519AnQR+rPjChG6WCGH0ONZ1UhbrKY1HudOYWXiI9Jr9AfMJU/NffwFk+K/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbXkJH4dPdPCkGYdfniNGIFr5lpfkvLqDF8/+0vHGfM=;
 b=oadGSpjSK8A0CSSDIMa9wUSBf5yP/o05+5fwbKfMUKBZF8I45sbLWXxkxSKSDUm9+GRGo3ssiNwWREG/R8OgYAcgrKGUyO0QyXTX2PsgoAHnBHUSJv4Vxp1cee28HaDSF27A32NsujI7zL+zM1pvLx+vNV70mxeX0WGHobak+svY0rRUNFY3BBbpAIhSDFcmxPqvxASV5YbOnpBu2ClW3NdOndt20fzgpp9Hag98VlZSDKBr4pr6M5aLQi366jUkQf6p33bKitzDQ1q6CFDDZZnPmFqs5abst7AgUGikJaYvTnl+ReMR83AldxWX4110Rn4WSpGYaRhmAnqUPZNTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbXkJH4dPdPCkGYdfniNGIFr5lpfkvLqDF8/+0vHGfM=;
 b=qNEIh47sIIeEJbEZaDhsKyQnpDt19LDN67DvatupqumuwyVpzj4MTZO/LD6N5vxyXD5iTB8JfausUhRm4dGMqN/Il4kA0BNXtXx71qmFqTegIBHq7uXsBoihHT+bCbkfSLR8Lm0dZd9VmF2H3Jez9jBUeo/OXo0/N5hkLX1rK0qYHd+UZzlILewxuxLhUlWCy5jturkZc1I61sJOiIpnSmICz9Y4ejNM7BBFOpEX9d7JnUT1s20vDvSNlKnLf+UNUD0/6B1SjoJnbI7Qd0+hyGImJfEApDQZseqf+Iv2teklZab8CBbZWknmO8Qbw+hVrUHfzh/rqEzSNhNjMIqfCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 05:22:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 05:22:37 +0000
Message-ID: <56e4d26f-fed8-430a-afdb-30b59901c5c8@siemens.com>
Date: Thu, 26 Feb 2026 06:22:37 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c074ac-813f-4cc3-1b5d-08de74f70dcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	oY6r+nUPGUeTFmOOk4Aj31hnClEcXdwaPYHiXNo9GxwK3KamH0u/pTnpxGmGv+A+jUmE2SjQQ+7e9XNl319OsYX2bdwrBqa0zDWT9Tye9ukS/yDeuAsItc6gSDaQD0wBdQH6RHgWU4eTT4MHcRX9glnjd+dTdiOLaHF6rx78WdxD29S1vfHH/BBSfQxJ+GDj90epMl2n+DpskbraXnXc9jNE6kK96KZRAs2TdAcBMayKWxUj31HH9jpPTk4/9N+qZtwBxJXgwd7JF9o6IwLOMXh4Xy6eUm9ZzkglOfPcGSGGMMAkSGCQsUz3zwVikko8+0cJWxavbHE05Jxm+DVt55UCuAaG5MiHQ1+0eQU/OKWpnvLugjt62dxZL5VjDtDQP7OFoR7Ff69k8Y2La6qtIHJNvsvd9V83VrhdFU/tMp1oSYpYQcjIntEntqgkjqRT9DYRL9/WUjhW6d6klUKYsJ7K+gOiV+/vn7nqFKF3NHYH9HnejB28SrJJ6HVKgO2IFHySwKfBzmpa1Q1349O8HpGj/43bBzNw48A5Zf3oDQRk/pxqHPprz/hmuFk8XrDtQrUfemMzi9kVvDxrM9i4NHa1V7qP1XxvLhVi8EvvL5QmGR/typpqErpY6IjYEdbM3m+tvyqqX52imGZ6zF8cmv8RD9Xc1u/TSPxPvgi7rowADUAr6sI4wOIEwoz2AdB9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWsrcXBHZDZlYkNqSm5GMlJpQ0Z4N29CVnhmQlBRME1wOEx1ekV0azgyVk1J?=
 =?utf-8?B?S1EwaFpkRWJFdEJxVE90SW4vWVZxQStseGtNUlVGTUZaQXl0TTd2bE5pYksy?=
 =?utf-8?B?MTJOT3JlU3NJKzg2UXhjWVBaNzVCamtrWXJLaUlHTEc2Q3RGNnl5TzFHeTBm?=
 =?utf-8?B?K0hWbGhrM2czOWxXd1JpVkNGa1JyZ0liMGlKWExlWTNFUE0rZlRyWk1rUXo4?=
 =?utf-8?B?aE9rdWpKRzQ1dHltWFZWYjRnV3FpNnhjQWJEOVRJNUNXYmJ4YmZaTTZsbVhY?=
 =?utf-8?B?N2tXVXprUGxwSjlWaXFyTGZwN3pzZ2Rqcit1TG8vLy9TanVBL24vdTl0R2x5?=
 =?utf-8?B?ZTQvUEpaSWgvc2NiZGQzTTVNajM4Qm5leWQrOFB1bTRJT2tVcnE0aUpGR0JO?=
 =?utf-8?B?V3VzVzF5b0VLQ2pYQjNpSDFUeG5ZTDlXcUNHL0t4clRLSTdBQ1ZNMnVOY05w?=
 =?utf-8?B?UnYvUkZMSlQxeGdFYjVTOXUrekMxWVBTMENpRzZzNitrbVMvYVZ6UXdGckhO?=
 =?utf-8?B?VUplaE4xdWlVY3B4U0ZMV3dIZEJYUDRLV1lxVldVcm03Z09xQTFJWE1UcTVq?=
 =?utf-8?B?RkNyMFRzNnMzaWFaWVZ3R05zUTh5YmlsdCtqclRGNTAwMGpMSE1rY2JRQ21W?=
 =?utf-8?B?OGRzZlFXWGZ0eFpjbXBLb0o4b3ZLT21nYzVNdFNHc1pmYTYyMDVwUC91dmJZ?=
 =?utf-8?B?WjhpNm42VFJNVVhoeVhQOWlWaGlEMHltdytFTFgxZy9oTm5tSGNIWjM4WVk1?=
 =?utf-8?B?WVZrdWJBcm1FeEtlKzF0YjlmWHl6YVM5T0tHSTgyaUdnZCtJbEErQ2szcGhv?=
 =?utf-8?B?Y2ZxWFpMcjNIOE00cHdpRDI4amRzUUNaSk82UFJJUysrZm9DdE1MNzI5eXZD?=
 =?utf-8?B?VUxCTWkycFBqUkNvMWc4eWp3a05xdm0wcmkyU2ZMUjFRbU51L2ZZcUpaOXk3?=
 =?utf-8?B?N084eVovZWlTUzJiVW05bEJ4eGRTbVpZOEVnS2dTMldKTUg0SmM5S1AwUG9C?=
 =?utf-8?B?VzllRHZjMGtPMWtYelFZdkZNMVIvcEErWitHL0FFV0lRVmQ1bnIvS2dLaXNk?=
 =?utf-8?B?YTk3eTdGZk8waGFZU2lpRzNYTWdVcFZjYnZzMXRDRTFqVHgyWnpZUEFnYlJI?=
 =?utf-8?B?OGVKREt6UUlyRjhCdEVjNHZKUjJ3UE9iMFVDbmlpSXRUcXNiNmlBeTREcTl1?=
 =?utf-8?B?b1RQekdjNXVUOTZzaWVYcm9YajR2dGtMQ1hESVNWYkxFa1VXQk1iMWU5d2ly?=
 =?utf-8?B?Z21Pdk53bmdub2llZmN3MWdsejVHWlE0YnpVbkZ1ZUE5UWhjbGNFb2tYVlVO?=
 =?utf-8?B?MnJZYzhHZTM0Uk1HL3g0SzFYQlA3bUoyampOZFVFNkxORmh4SmN4dWRVclRG?=
 =?utf-8?B?MUwwY212ck9rOUtEanRDWFZCZXdzZ0RNQm43YytsZ0cvd2wyNjcwVENUMHFU?=
 =?utf-8?B?T0xhNStXVTRhYVFpY1h5NzIyMFczRUhnbGJ0V1dqVmJhYk4vaG5IL05PMFk0?=
 =?utf-8?B?djlWdHc5R1d2YXc1Q0F6bWY1WktVcEovNUdqYzlTWncrMWNqNVpMcWxwZVdM?=
 =?utf-8?B?NmZ3M0N5TWRJSzEyRW95dU9OOEdqTjBRMUsyZ3gzNHI5OGlzOVNoSkdZSkFE?=
 =?utf-8?B?bzJTd0xXMytodm1xa2U4aGVaVFpuc2plL3I2RkVrdE1obGJvVDc0dXVTeFpl?=
 =?utf-8?B?ZVI2QnB6MlhHNW5jVkY3RlAwSU5RbmUwSUFXNGs5dkVjSUwwU3NyQk9VQ0ti?=
 =?utf-8?B?eGx4T0xTVjM2aHFleWJ0aEE4bFpCVmNhRTFPdFJvdTRNNnpyZGpuTHZtUDM4?=
 =?utf-8?B?QTlpSGhsTGMyZUpPL3RQVkE4R2xUdEpSRzhUUWdGOGdsVFVsdjVuS0xlN3VD?=
 =?utf-8?B?c25mMkV3U2RvRVY3aTBERGE4N2lpL3VYNEwxR0VWZGdMNXhScFZkUVlnU1NY?=
 =?utf-8?B?VnBFOWp5TUhiV1U0Rm40N1BUcWVSWWVNTjVpcFVSd1EvbW0rWlk2ckIycUpT?=
 =?utf-8?B?N3FHR0M0K3hXdlREdXBGaGdsWk8wWTdONnFkOU16M2g0NXEwSEFjbnpnTkt0?=
 =?utf-8?B?K1N2cUtLUm9kNWFNM1Bpai9nUms0c1BsS01mY2dMQjByU1R6aFNzbHBZMDMr?=
 =?utf-8?B?NG53RVdzQzZMN2ZCZXorSHpnWjlkY2MveHVCN3MzZytXdjJDOFFPK3U5Tno2?=
 =?utf-8?B?aTRrNHBFZ1JzWmJaK0JtczZlSWxXcnZDcVBlT2JxTnNzK0VKUlZuM2xGS2tL?=
 =?utf-8?B?RTFXS3A4OEgwK3FCZkRjdkllM0dTWkZpZndUNXhqSWgrM1N5aDVVOTJzelN3?=
 =?utf-8?B?SjZnTldoTmRVTG5lV3ltekk2NzBPYjdXM1hjYzJqaGRObXB6NFZldz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c074ac-813f-4cc3-1b5d-08de74f70dcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:22:37.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ0OvVEi/q+kO85wTN2GCk0NBmbOMTpsJ81VEV6Y1/dYzQAu2sJ+4cBbtiZ/Y2QICkMjqqkGfcCIefuwnZNSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 05:22:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21989

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=2&day=26&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/02/cip.2026-02-19-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Feb 26 05:10:50 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Feb  4 01:55:28 AM UTC 2026
  limit date: Fri Mar  6 01:55:28 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 23 03:28:28 AM UTC 2026
  limit date: Wed Mar 25 03:28:28 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Feb  4 10:41:33 AM UTC 2026
  limit date: Sun Apr  5 10:41:33 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Feb 13 12:33:43 AM UTC 2026
  limit date: Sun Mar 15 12:33:43 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Jan 10 07:38:46 PM UTC 2026
  limit date: Wed Mar 11 07:38:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Feb 24 08:55:46 AM UTC 2026
  limit date: Thu Mar 26 08:55:46 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Feb 12 10:21:35 PM UTC 2026
  limit date: Fri Feb 27 10:21:35 PM UTC 2026
  Status: On track

