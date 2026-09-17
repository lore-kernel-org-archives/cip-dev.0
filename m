Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2407FC982CD
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 06:10:28 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33271.1789625420331211099
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2026 23:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hd2Es/xx;
 spf=pass (domain: siemens.com, ip: 52.101.84.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbemJQSolv/ICfe3Vsmr5P9hEopa7N7Qh3FqbTWvu1VRyxhOoHoV11ACIU5tQJuODjQY8OJii6/y8SGAVTboNwEsXhqH81jq/aoRIrvJXkTNkXKiy8cAxN3PuFb6S/XX2TGtEGUf+bpMaTv08ZSdGx7r8HZsmL0URoqQ579JUBT1ZeXU4HSn7uzwhg6w1Tc1JlB1GtQdQOx/PxdUwwsLRaTuItMHgohDzfnp7cZrAJa1J3AvrsepFT8NNzpMpyNRaEMfDPHGxvIrwgnl2j6k3l5iQTW01mL3xbMS/rBkMksBhhEDxolShd70X06D5DeXrjyXDZiaNOK21LoUFQZfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX+FS30O4CQeKU2Vy9ioMvRzR+60gqKGfviuQ7qa+18=;
 b=d3S6tt3n0Vu3t7a3AnwQp2siAwHHps2r4mRxE4LuovKHExQn8sbPP6o8KLVAE7wwUEVOgqiv2UNXFZlAY/E5EDWqEcAIu0jffz45SVeqWQ3P40bKkKZ6E75QPxkk8HwFaiuE/weXaixR+6l32GvTX4WhAWbcyOPqrUi+bUvvz2YEuHcUkigl8Xue8zUI/P3PPIs27w4JweMJuO57HBnFLeymge13ixhNEKe6moJdFbTK1m4x+1NkAtNjPMUGMA80p07KhGGaaLGr8yCswl6cTVu6YctJgUDvNgq3nJJpP2Ucu8c77cqPNkCyaZelZ7Tm4bfBzRjMll7CKc/x8ivu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX+FS30O4CQeKU2Vy9ioMvRzR+60gqKGfviuQ7qa+18=;
 b=hd2Es/xx960WQ9NG+AArP2+a1IXnIy+HhSh0ZpHnG37h3L43X2amMYZ2GGNo98/8qdm7zr8T2/nBLocjyHb5jonbxlQK4QUEBNb1YDv8DvMOcghVZjzVhDWyuhk4tm/NhILdwUMukH/Q9bSYvvY6fB1vkAc/fOCcCXYrTmoMYvKIJqWoEKCQ5SBxIG4/YWe0HngNWJ4Geh5iOS05dHPaPAigJbANgKd8Dtn69iBjVJGxyARs/Ynqwp/O5Zj127cA3RuAP6jGogbyRJfTvPIUzJCxOuWQi0RU35sKILL4Pm5n0uiVFSF/NQFhkR5L2BHZZ8bKQPhptyaFjECBP8+G6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 06:10:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 06:10:16 +0000
Message-ID: <8ac636e4-e300-4f80-aec7-e32bc880699b@siemens.com>
Date: Thu, 17 Sep 2026 08:10:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1288e2c4-d4d7-4c09-c9d7-08df148257fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	psbpoh36VxeqEwyP8wMxs6LfmZrD0V1xKRbZk8EE7KJHsaolMI5p7BrJJKfN7knHe1ERXay5AMnkJXrn16rcpJ83CL82ZPGxsgQqSAgnOmd4t9cAoHAndNj7aznAuCb4S9wS1qk7mVgRDSNvFNOl6VJdbCO53WwF52s1JHRAZOIdNI5D+RyVXuPpAhuXEU/NJFILOdLl90mOrYev/oiyUOZr7vpPm+XTHpGXEXtf5yzj9mtGE5EtWlO29wNoxDpKXupJfwLl1Fo7KyMojIl7MjghkcYe6q7ie6bRCZWwbUkUS3DnNdLaUKwoismImTqZMdCEOozRgl3rBafSx3sy9K3yfzt8dd1GjFzZXBNj3vX7vBXjMqfkxRGXc8bF5YtY+5EIpQRmFlyoNUal/i3phbJb0ZIJir/RszkUqNuYJe39Rq8G3KhY978sG1VRJbWoEBA/m70JXlIdtcHo8mgZeJKqSk/vrQ5iw1+M2uXvmhlMM5gRTYnC3YY/vit83tfmKkWRIUkTbcT7UIckrcQH6eAXArY7R3HLZzwcwd3MaP5ym0IF6H8PoAvtY3LQuc3V+danlxW2seQiGQ+GSYOlVPhqOfWkaFU0QbYsRUykjDI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWlhMWRjV0VjelZIUjJrZjRsQzM3bllpSU5uMXZlTFJQWVl2Y3dJTWxYa0F1?=
 =?utf-8?B?Q0RuV2g2RW9MQkliUlpJK0xYT25GNmRUTGlVYVA1cnZpRGlGdjltL1ZPSVNW?=
 =?utf-8?B?T1pYZkp2eWFqSkhDNnFZSkpVRGZNaktGSWxQWktwandiZVMvREJBQytma21F?=
 =?utf-8?B?dER2aHNtanZqTkloZFdJYlpwc1JoNWgvWmMyeWNzb0FIVXdwbGFYdk8vZDB3?=
 =?utf-8?B?ZGhuaVUvM1o2K28xZGQ3THRiYVBoMjV0ZGxBelpDT3k0UnFxZUlZa1RZTGN4?=
 =?utf-8?B?ZVhNRVB0QzNiYklMUmU4L0tNZ3JlSmkvM0R6bG0wRXRQaEpTaE05Nm1pMHZ3?=
 =?utf-8?B?eDQzY2J4Tm81UkNnY1VRS3U4K2tuMXhWOWtGNDBldjdMais5Sm1WMDJ5V2tr?=
 =?utf-8?B?Ui9qMmNmaXZaUzZJckYyU1RwdWlXR1NzRjkwcktuQncrakJ0UnRqYjV4RkVD?=
 =?utf-8?B?MXZNNWFxYm9VVkZPYmQ1c3IvVjZrUGJLbEM5bEYvUWdOYy92d05HMmVuOXY2?=
 =?utf-8?B?Y3hWeEdZY1crOTAva3VDOFA1Q0tUTE04dW5ZQ2Vpek1EOXBZdzdGY3RYakgx?=
 =?utf-8?B?Q0RNYlNpT1FpM0FYR0tLanI1YU9rMGxsUGZvb3pzZmsvemFMMldlZ1FRSUJk?=
 =?utf-8?B?RHBXdlQxSTlxNDJtSUQ5VDU1OXJ5OWpqZjQyZHBwTzdOUWR1Yk5GdzhwMkQ1?=
 =?utf-8?B?QXczL1FTbFVPNy9oVWE2emFxcHRvTmhzd2xHZ2I3WE1QK3B1MkVxazFoT1Rl?=
 =?utf-8?B?UUYzV0R3OUFyMWl2ZVRaQUZkMWJaVmlHeUlpQk84M2RBWG1vdjhGNkw3aEsx?=
 =?utf-8?B?MGFlT1JuNlIvd3NhYXN5RzBNcDVaVG9QU1pxNVJCR1RrOWxYVzE1dGxNbEUy?=
 =?utf-8?B?NTZVa0lQU3pXcWpHbnBMQ2VFbjc2SHhOY1duSkVtMEk1clFCVTlTWEVNczBR?=
 =?utf-8?B?SE5zc0JFcWxmNUVCRW0weGNlV2I1UC92ckE5S2ZmSGtsbTZscENVS3RLRkdu?=
 =?utf-8?B?TzVUZDVCUkFQUUNsNDJjam5lY2lyV2g4K2l2UUFmNzRhRVo1SUVrNmpRUERZ?=
 =?utf-8?B?SzJvZG1hdlNKOUl4SmdTUktJRDlHRncxdGJtdExVdFlOejBiT1hGcGVLaFYy?=
 =?utf-8?B?eVF0ZjZ2aUk4TUtIa0JESW01ZDRzTW4zT0Nkdk5XTjVmQXl4Ni96TnNKRVli?=
 =?utf-8?B?Vk5qTW1Od0U2TEx6Y3Awb3pvcDUyUzgweHBhbU0zeDhleVRzcWd0M0tPek1B?=
 =?utf-8?B?ZkxPeWVBRnBUSHIwaDRIeG0vNGhMMmNjTU9aeWFGR0NaNG5GZmY5a2ExZHhi?=
 =?utf-8?B?cFF4Mit3SVhibkJCbHJPVlJsNGxYcnZDV081QWdSTjhLTisycGwyRlZYaWhU?=
 =?utf-8?B?ZzNLVmsvZmJtazF0d2F2K3h5N1pyT0xXWkdvMFl5b293MzFJcDQ0S3NjekJv?=
 =?utf-8?B?aXpzdW5COWRtZi9rS3dINFFYRWRxaXNETlVWNUNINDhpZTV6OFpzVGhWWHZv?=
 =?utf-8?B?V2VDSzNHdXlqRmtPRkN6Uk5ZQ3BiNDd0Z09Dc3JGN1JzWFo3L1o5M1dvcUdE?=
 =?utf-8?B?dXZUbE9KQkhaUWMvMHpXQm95d2Y5b2hDMllqbEt1b3pONy8vSFkrRk1qenVX?=
 =?utf-8?B?aTV4WSs0S2JQY1VsMG5uWldXMldBcXZyRS9PaE13NkdpaE42OWxxTHZRbWVr?=
 =?utf-8?B?dGlnYmpYcjlPYlREODJiR2JKcjJzcm04UWs5bFJUL3JlajFRTDM3UEc5UDJk?=
 =?utf-8?B?bUNUUWF5ckFEelJ0dHFkYzF4UmhodTZxOEt2L1BsYUVla0t4RVpBdWxjU01P?=
 =?utf-8?B?dGVZT3F3OW02d2xMcGhSSFZrVlJCb0tTUEF2akJoV2wxem1FcHlBYUpmY29u?=
 =?utf-8?B?YzV1RnYyeVA5Qkc4bktidGdVZk9jRVpzZXExQ3VQUHlRQW9ERm1LaFoyNUh2?=
 =?utf-8?B?WWlDa2hCUEZSUDIyT256QldsNlV1RTFMSGZrVHNGWnlyb0xJdS9kajNqWVFt?=
 =?utf-8?B?T21UdU95b205Q0VqTit0ZU5zOUdnS2xCMU1QNUJlU2dHM3pmL1phT3hyV095?=
 =?utf-8?B?UyszTEpnUGVWZE5uK0xOT0txVGt3VkhEandoMDhISGFvWVc3QVZCSGkvZmQx?=
 =?utf-8?B?a1BlVFlPWlh6ak8vRWZhNXpjWnM4Z3Q5dFVEOHRjZGduV3BBY3Iyeit1anZ1?=
 =?utf-8?B?bDZaUUc0VXlQR3FwckpSZXZ3a0JVbVdSc0UvdnZIVTRDNjNlRWRSb0NwOVVY?=
 =?utf-8?B?TEE1VlY0OEJ1bURjOTd0MEVCQjlCOG1FR1ZXSzlseTNSTURmd0xCbjJmS3FW?=
 =?utf-8?B?aVhMVWt5YkxYcmV6SEhSSDV5QnVWMVFjZWdObUtrMHVkTWZFcENvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1288e2c4-d4d7-4c09-c9d7-08df148257fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 06:10:16.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r9Pvi7T8a6WU4qTbVnjZic106coSGDlsoBzZFPX5AkCUL0MeMn9WEg+VZZ3sjuSXUlz35wHStBiY8bwMDcmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9736
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 06:10:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24195

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=9&day=17&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/09/cip.2026-09-10-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - SECURITY.md
  - LLM review tool: updates, feedback

Jan

[*]
Date the data is created: Thu Sep 17 06:07:43 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip114
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip113-rt62
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip134-rt49
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.268-cip77
  latest version release date: Fri Sep 11 06:54:50 AM UTC 2026
  limit date: Sun Oct 11 06:54:50 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.260-cip75-rt33
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: *Late*
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.187-cip60
  latest version release date: Fri Sep 11 10:35:49 PM UTC 2026
  limit date: Sun Oct 11 10:35:49 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.182-cip59-rt31
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.108-cip31
  latest version release date: Fri Sep  4 12:46:01 PM UTC 2026
  limit date: Sat Sep 19 12:46:01 PM UTC 2026
  Status: On track

