Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC84C71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 05:06:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.24])
 by mx.groups.io with SMTP id smtpd.web11.5628.1749704783623166874
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 22:06:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KGUL0id2;
 spf=pass (domain: siemens.com, ip: 40.107.130.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTzmpwUigL1m4/tEKx2/uDIeWWUXsm9JtB4lKOXc8xoUB7FpOTpm56u17eo8LEPynWjwi+IfeG9PtRZgfPYGcFK9klbtcuoYYAgIq1rC5CPLqbYRr72XMPoj96evcZrvZJvvMNA845SLyPTDqzr1/6OXev92XX4FvBPjKWmbsMtpw6dUZSbAkg2sdZVAK+KI0kXF0845FuPhNb/EDxr98p5taVdrDpvHj5BR+X0f8yMYSK/jJN5cGRF4zRjSKJBtRs/FkSzh70nq/Mu/EGnwMUVtWm0V5IxpQdqGpy+1maFEjgAWCn8rdrR1DrKpnwCl6rtenURGrjiD2sHyDWp3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgUewwj9hZK2GtByPYOKQQq+9zd3ajLKaFtYgi0ApWA=;
 b=cBbe8q45+j/haUuBGyAKr435Ca/kjuaK/uhJVlh8OHqNH6JSvQSEitMMfHhZbtApXInmPOqmfqkOIpryUBBN0ASiO8wnW56H/lUvaoI/l5pWHCULq8usqMolh4xqZuZ6ODrKnchoPRGFAuwbLQRYHqnKcjryEAkO9nbMP3saiDY7t13TOkZmp3OYebkLc6qPXKVTggpZYyvNK8fhf9moYeVunYdXwgDAFBTf1nSW+0LY2W3hNfJxoUlMR0nKTPgNbvuNyut4s7k3tjRYc2/qwZVldoe9c+1qOCkrViIJ33VrJvMbmUux/B0EV0ZWHICyO9iBKSn4Mk+VpGoI9TqCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgUewwj9hZK2GtByPYOKQQq+9zd3ajLKaFtYgi0ApWA=;
 b=KGUL0id2jjQCM2kB9XPl6vKZ5FF0J8IRHvx/tlnZ5dplhUZc06OuGgiikV1DcuEymagTS/DuSDjyB7bFi2eIOafsw+Ca7VbAEq5y8vIHuJxPOHZOmwmC7hQKa7AgWsX/2LLR2Yw8VLYHqX56iHgZwTQwIdrBVEdH204/HN5qmyY7k/aQv5fssmlcj7nmlw7TzPo1CfBEzrswkFU/jkJJAouXqqZ0Q02T3AwAZ8AsZw2NZdI4ZGBUSl3NBBOr6zQCbU2xMN468hPfQfFX4igolpfncHKpMxeyAd7COeS0OgS0Jt6Ys48/stJIeY/mJYU0QdjTyzrhEpIYn2jdp7uthA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:587::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Thu, 12 Jun
 2025 05:06:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 05:06:19 +0000
Message-ID: <e307400f-c6f1-4c60-b221-323f47d7b5e5@siemens.com>
Date: Thu, 12 Jun 2025 07:06:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: bce649e6-9928-425e-e93c-08dda96ede27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eWhPNDlGdGxPck9pY0pONTczZzZYamFVSHhEWmpJYlhmZVB3OHN1TW1oZ2hU?=
 =?utf-8?B?UTV2OTY4ZlZGSWh0aVJWUVNwRldBN1hyVnEreTdWNzB4K3N0bnJmd1pnWUIz?=
 =?utf-8?B?T1E5aUdCeW9GV2tWcDhWTmt1akJNNDJRYUU4UXZNRFlSR0t4aCtiZUJRdjVU?=
 =?utf-8?B?eFc1ZWY3YWphcWZUTWFQZ3VhbEVaaElneC9yVzUwMGtTWDRpSEI1OWVUR21T?=
 =?utf-8?B?UEFlTDBxRTdEb215eWg4NnN5dWswUjg0bU9WRWtDeHZkZXRBVHRldStGUDFr?=
 =?utf-8?B?ekRCbmM4b2ZnVEgybnpySlVTU2hXRXA0aHdMM2ZDd2pWWXM2azloUkpWVUhE?=
 =?utf-8?B?WjF1d2V1NWxZV3A2OXZvU3V2TDhkTkdEbjhUZWhvTzZuNlpOZVEzcE02T0V3?=
 =?utf-8?B?MWdaNGVhTzdBL2hKRTY5dW5aQ2I2WHpGelRva1JZazV3d2UxdTV6Wkc5cVhG?=
 =?utf-8?B?QzExcVo0cHloM0dnMDFFUkh0N1Z5REpoVmFCMS9PdHh1QlN4cTU2NWtUNkRX?=
 =?utf-8?B?NVBldlVGb0l2RU9zNVhwckU1ZXlVcktnRTdNSGVEcDU4WWZuQnYwY1VZejh5?=
 =?utf-8?B?RGxtQzRINmsxS0tTSkFuVEN3YS9aSDlKaW4rb0F6ZGdHZHkxS2xCS1hoRVpO?=
 =?utf-8?B?VGpkaEREZ2NlU0Q3QjhyMDFUTWlHZ1g4QkdqcU9hcUZtUmFENDd0SDhneExy?=
 =?utf-8?B?b3ZGQUJrTFlZRzJpOXNpRjM5SjMzL2JzUDRWVDN0WGRUc0gwVk9qTmpBUHhs?=
 =?utf-8?B?d1YyOFpFU1V5ZlBDVWVnY0ZDdzVBM0R4MnovSXZmMlF6bEN5bXJyanFDdDF6?=
 =?utf-8?B?Y3JGUHpRbVNLZXkvOFNpYXJVV2hSdjh5RXBMeEEzK2JXbFRRRzNUT2E2aWdK?=
 =?utf-8?B?dHAyZ2lPTGdiOGYxaWRqYVd5WEtKTEJNa0t3aThWMDF6ZXE4OHNmQW9Ta1lL?=
 =?utf-8?B?bGpRcmZ4a2VyV1BDM2JMVlR2RXZUV2oydmZxWUw1UE9RdlB4ZGlaQ0JETEtx?=
 =?utf-8?B?bU5jd1lpZ2tHTXBiNFVUYjVlUm11Y1VWZHMrbjlqVFNNaWFHRXdYTEhMM0VE?=
 =?utf-8?B?R3dZVVlGZVBSblBKd1k0SmR1VzdQMFRtZ05YOWVQQldIcHBINEVzQ0swRzYx?=
 =?utf-8?B?MXBwbFBPTlUxWEJuWlhjMEtnUjNlQi9RMkJSVC9aNjFKakd2OGYySys3Uk9W?=
 =?utf-8?B?NDlMUGxNUlVCTFZ4L3pLR3E3UFV0TzhOTTJFT3FOYjhsOXJNSjRBaDdyaWpw?=
 =?utf-8?B?VjRvbGFBKzJLMEhnYmZoZGRLc3VLeGJIaGJtb1lIYUpUdGIrN2RJa3NHWlBY?=
 =?utf-8?B?WnkxL2d6Wm51cnNDNDlQNnUreTdXMDErbFB6d0JwdkJWa2RvRUNCcExVdlJG?=
 =?utf-8?B?aVFlSG5QVExEWjNrOTJlQTJSUU1kK2p3NmJtOGRUcHVxWVg4S1Zqb0l5WCtR?=
 =?utf-8?B?SnU5K0FZMjRZdXB1RCt5QjUyaFg4bmMydFlNZURhSmZrTXJEM3JOZUU3SS9t?=
 =?utf-8?B?cVJyemVqOXo3dkFOelR3anU1aUtLUksyZGpFdHVuMlMxdFQ5VHNqdlRLYTVh?=
 =?utf-8?B?MXh1V01ON01kZVdMS040UExqUnU5amZTRXZyTGRkUkl1VlJtWmZLMHZBOVMy?=
 =?utf-8?B?czJGNUxOQW1NcnlFOVdqbDU0YWZHa2h4dFR0d2cyTThhdlFSaWFlbmFwNHZw?=
 =?utf-8?B?VmUvTU9XWkI2ZnV1STNGa1FNVk50dWRMeXU4TzFhamo0Qm9lNmZ3R2ZZNURn?=
 =?utf-8?B?K21ncnZvSXdKZkI0ZTZuVlZiSlVVNXZkc2pRRUkzdmhvZllUb3kvV3FaTXMz?=
 =?utf-8?Q?iPc8jDo8jspbvmZPO5CVSoe/Ip6+ThaTWOVj0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVlxSy9ENWFLMG8weGZ6MjZiTzZDczNYM1p0NDZqcGFSSDZZVWd4YUlEdHVB?=
 =?utf-8?B?ekxiTnlTZ0p2UE1ORUNyckVWU1Ewa1ZiQ2tvclV6UWhYNmpoR1lNOVorb1NJ?=
 =?utf-8?B?cnZEM0tmc1kxZU5RMFJvMXc0ZjV2Tk9PK1o0b2JOSktwMTFEVmFFNk5OWVQr?=
 =?utf-8?B?cWNtZ2tXa0toS0N0aXpYWnJsMTkzVFRpZGc0dUVGZmdHeC9oWXhNbFRDSGJT?=
 =?utf-8?B?ZXRRaWgvT3NHTXM0SmZMdFFDYXJxWmZMMTEva3k5MXpVM01FamNLNGk1TTJk?=
 =?utf-8?B?VW5MQVhaK1djbzhKcGNwNHdTUEtHYlhrUk5hUDJrUnRHQklPbnI3bmQ2cnFx?=
 =?utf-8?B?OVBhSGVxNlVsRHRjYkRjRUVpLzJHTkFLUnVCa3A4dHNsZzZKRHRWUnhySjBq?=
 =?utf-8?B?Rkx3Wkt3VFZTdmI5L3hTaGViTXFVa2lHa0RzZ3pkY3gzRjVaTTkzMWRIM0pU?=
 =?utf-8?B?b0RTRUFISmd6ckNibE1RemdoVnB4c2lXL1pLdnluNVJVZ2hGRUNFTmxKYllp?=
 =?utf-8?B?d0lURldGa3VoanFycEdxSitqV3g3NC9kaURRNDlnSHhRejF1eTNzeGp0clUr?=
 =?utf-8?B?RkdiUXZPM3VOckRFNUlzbklKcmNRcVFQNjVlRHhNUmVxQUc1M3FZWndjUzJ1?=
 =?utf-8?B?SnVoYzVObXZQSis1K2JhWkFqM3F5SngwbzZxWThtN0QrL0ExQXZqUVNkdWth?=
 =?utf-8?B?WXdrZWlmb2hndzFKa0hxSTNqRWN0TUJKbVlCZk9mMThpQUJiOGlDSGV3dnZH?=
 =?utf-8?B?aVhxV2dFSDU0Yisvcng0d2gwSkFnNW4vdzZrcjAzQUIxdzJlMlBHQTVadW80?=
 =?utf-8?B?ekJNRHhuZUN0NlZMRWhSd2Zkdy9ic2lPQVhuZWYvRUg4VEVFSzZ6L3JMakx3?=
 =?utf-8?B?UWEzN21hZ09ra3pGMmFMUEhnajZ3WXdjbGFpSXJpaTY0YzcrdkFmcWlxNWdC?=
 =?utf-8?B?QVc1YkFNa1J5Y29XYjVSSVR3VE5JNVEyb2VvQTZGMTZQcFlPcXo2eTJUbmV6?=
 =?utf-8?B?UVhkdlFCbGVBbEIydGZmZ3gxYW1SNzFhTXVJbU0zN2lJK3NVZHhUR0psWVk0?=
 =?utf-8?B?c2VxYmJoVElsOU9kcXNDcDUzMmI1ZTFjd3gxWlN6OE94andORU5iR1FEa0JN?=
 =?utf-8?B?NG0rMFU4OXo0Tkl3OGNJZVpncmM0aUl1UUtjL3VDRkxIQWdlaGFkUG5aMnF6?=
 =?utf-8?B?bXhmNlcvcUs2OEQrb2xoSjBxUjRXZHRCL1JKRk1BdktMem02Tlo0RDJpVEZi?=
 =?utf-8?B?bjQxNFAzV2MzcEhCWURKWHcwUmtudHdXMFNXUXlOOFpSNDJVWkRaWlpJeEt0?=
 =?utf-8?B?L1NiZVROdFdQVmZUMXNJUXdyL2hXSDZpV1RrS1p1SVgyM1dOenpJaUZnSTJM?=
 =?utf-8?B?ZitTUXRwUmsxNU9ZbXYxa0s2VERNSGpOVHBFY2ZiUTlJTnJFc2V4ZzY3bSt4?=
 =?utf-8?B?eDVTTUxDSnd1TEo0TCtwdFBqV0paVkxDZFJqcG5uNGJPZmpoSnRGMC8zdHVO?=
 =?utf-8?B?MUFUYnlQWkRDWmhVNTNOdTczWFdyTFoyS1VwUW4vdFdpU3kzN3dFWnZQKzg3?=
 =?utf-8?B?SERZY3VPR0RTN21kT3NTS1piMjNDd2pEeXV1U3BBL0FnL1E0bXl3d1ZlUUFI?=
 =?utf-8?B?Um9qR0JXWWFsMGNxUWJFS3NldUtSZm5CMTBsdkJHS3hmdkVZc1FHVG9PazNv?=
 =?utf-8?B?alUrbC9LeWE4MEFHMmpGQnNhM29SeEx3V2VCZDM1dytFTVh3UnZKc0ZUV0d6?=
 =?utf-8?B?TmNmc1gyMkpuQUNrQ1lVVGVWb1BUNENSeENtKzJSMUF4b1kya3dOZ0Q0ZWg4?=
 =?utf-8?B?ajZtWjYvSHllSVhGeExRNFk3Yzlhb2VHMHdZTFd4VjZzUkxiOEFZRnQ4cDFt?=
 =?utf-8?B?NGFqbVh4c0k1RnlPOTVEc0YzMXVoYlNtRnJxK1VRZEdQeFdNaklkNFl3YTF4?=
 =?utf-8?B?WDB0b2FTS2NWN3FIZGNKSmJQWWpvT1BQZGI4RnJ3VXpKdDc2VXpZdFIrbGxO?=
 =?utf-8?B?ejdiejVveVdlZXNBdC9Ybk82L2FuZ0U1UFlWWUxyNjVSd3B6d0JLclhKWVoz?=
 =?utf-8?B?Y2ZtNnNibEVweUlBYlNNR1NYZDNnckw3ZU5lMDJIcjQ1N1dNUW9kaVhvc2w1?=
 =?utf-8?B?SGkrd29obEhkSitPeDRqdWJwMUo5WVo1UXIzVDI5VUpNRWQyeGJ4REdQVHZL?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce649e6-9928-425e-e93c-08dda96ede27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 05:06:19.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwF2D/EjxDCQpY8AkBIEi4Qzmz3L2Xb7VpdxP7MAzbvQWFUjeP3qiF1qA8UktGNupbhNrHS9X9RZ7LTW3uo8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6159
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jun 2025 05:06:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19038

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=6&day=12&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/06/cip.2025-06-05-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jun 12 05:05:51 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu May 15 09:59:23 AM UTC 2025
  limit date: Sat Jun 14 09:59:23 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Apr 29 11:30:23 AM UTC 2025
  limit date: Sat Jun 28 11:30:23 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jun 11 08:39:43 AM UTC 2025
  limit date: Fri Jul 11 08:39:43 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed May 21 07:22:16 PM UTC 2025
  limit date: Sun Jul 20 07:22:16 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed May 14 09:48:14 PM UTC 2025
  limit date: Fri Jun 13 09:48:14 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu May 15 12:41:24 PM UTC 2025
  limit date: Mon Jul 14 12:41:24 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Jun 11 02:12:44 AM UTC 2025
  limit date: Fri Jul 11 02:12:44 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon May  5 07:36:59 AM UTC 2025
  limit date: Fri Jul  4 07:36:59 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Jun  5 02:14:36 AM UTC 2025
  limit date: Fri Jun 20 02:14:36 AM UTC 2025
  Status: On track

