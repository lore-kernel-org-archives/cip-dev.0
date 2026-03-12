Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABFFED2D8
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 06:39:06 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15745.1773297540125357632
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 23:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PNufOTVm;
 spf=pass (domain: siemens.com, ip: 40.107.130.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzOOjdcaqUBByVE7fs1QAskL9nGfGkXk1PeoydV2BC+2c/V6IAybBvfp9kdfAbG9UNCZVE/rc8dfkSzgsdj8jxKchkH+kK1t63IWdDNQa1q3mN4PvVQKHu3xRlCLGOi5GsDAqFHnA0tJgUrdzlCpOONVM5+Gmq/PirLbT9p0weOIsJABhEx81HYeCFEUDtE3voe3frPacqjUecV4mUIa6gR1ZKvC+vkQdFaR63+TzKgxss9Avlea3Q5uGPN7xpPi8heO/o46fr0UUnkueTxCRxtLkkx6UjKYxXocXkTbvDBHKfti/pEllUQE4lqMQFDqHBWOd01R+kJr+DojVAe36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G1pC2Sem4hAOvtTLviLGrB0tpghCn636hREXF+UG98=;
 b=q57GxNgwPFHajzdu3ReoZAcoeaMNE6ZGdlme/7WVzw7nh5SZruefqDHb1PWGGn7JrspZBjZfXsL4jhl/MXJBc/wZRQc8s9xbHjG5dbyWXQ+AkgT2++xHWnvJxgJ4QyPXVl1Gohfii3nHv9vH1OflcrcspXCSTJPzemgVLtsSvSmVrtluhDKt3vetfkmuGoZe1u9Jmy+tq4s4W0KASfDideFRa5ZjEiqAV12TXT0dCPnQqfDn3DOOoGIo0/KwOvX2ESDp7fCQ78s5hQIP7FauaJjM5tDPy2VEq3iAMMMiwAbMPrOZNBEpTPMgu8/ye+G5+YzwQFdk3k7YYArku8yL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G1pC2Sem4hAOvtTLviLGrB0tpghCn636hREXF+UG98=;
 b=PNufOTVmopGkQPnAXoqWEBl4cojETNBoTCHnRrCA0XEfXcKh6F0Fv1kf8A4MU02THhMApcFIdRoX+YThBGhf9AJO8wRDL/Z2Wod2GUQhbkZNek25qYeYniydQxv+ZPeJpyUnegTcxgR3Knd4sUNGWwzvnXLL7XpzdlR8bwFISOpzmAUF0mW6SqN98ohJ5R7VQRRtQeQ+IVr/ksMLsZ7Wlqm3kTU9u/IoMCiM772oQ0bNSncBYthv2C1Ycp1uvvl5zx9g5PZlly6ASkh2l3ls3uWEgf2jLzHEF11kyRkJ5QFwDCaqv7k7pJ1/01jMEEJadQkO9x5chIcUdtu2jfyEVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 06:38:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 06:38:56 +0000
Message-ID: <641c6c12-7fe4-4f30-b071-fbea2b07c882@siemens.com>
Date: Thu, 12 Mar 2026 07:38:54 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9d7508-884f-4da9-57fe-08de80020882
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	bnSFVYh34IufIYLS2HIcBqRk3VVljlk7wpLqC//pEeps36Zlmm7Bwhs1S1Qw5o9MHo/NcjOzCazNHOJMb39k7vfVxj5Le/Rx8e9vZ3FkRE3cX/J+IfAwa3HpON8vwvVgoNOpSfyH/yy99EodgRlcy4gO8BnUcLKcBWct4N9GcEEUJGnW1FWXrJcrEJzwlkewH3Rt7eKOdI7/8KI6I3C267DGTTiXxizlrdrXT5u/9OC8CNBStFXmGkk9X3YzdxsTDH3Rhl+gTWvGIrpLAdQ2YlBwYjKoJ9MQ3MHgBUnP3EEVlBXFhAZtu17LqfmhhhuRJ/SyqyuhQTOtqHuyVG/zCsOJ0kmh9weeMd7eUn5aOYcORgnsZgDSiJ1oiCXOLIZNqGdoOXDJjGTSQ31+Ee6ggHlEIthol9c3ddbsZlUS2/mu4hjq1ucjI+cqgWr7rieyAUt5QFWTC7yaPVoim/FFrUZEagmPmVXZePCc/9XnzmWrakYTc3AEhG7SESGGTTCnn1FOrVr1fJGob9P91wRvMqTfRUA7qyVe8taubcUha8LUzhWOgzt/t3rdmRA98+eRgIxBFyKhV8Dros49XitnON9desFuifzioDZIIrWwUOOBgTuzeOrjtuoVQd0YE15q2diH+ytB1XECeRnY1Gl8N7xVkvylWRRb59crTb5BzfJRD3FELFWbG/SFUUrRXCR6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUVQazVqT1BtMnBmTXpxV3JXOHYyZHdYdHNpS3c0OW9mVFJrZ2IrQlhEOUE3?=
 =?utf-8?B?MC9wcDY1LzRScTN6UHg4Zm85ZDh2T01aWTdvd1Z2K3JFaXVQVE9mVWIxOWgr?=
 =?utf-8?B?Zmw0dlFIdUNyMjhRTURmM2xQNTA4VEtyWG1DU3BVLzdXS3ZzdnVJaVAwb1Jo?=
 =?utf-8?B?RGJuMmRJUERnczIwTHE5aUl1UUduWEVOZW5mUnBMOXQ2MXZxVE9abDBCVXF0?=
 =?utf-8?B?ZG90MmVGL2tjcU5xR2VTQzc4bmwveFVVengxUVdJTzZlOEprSXZnUGUrNUpJ?=
 =?utf-8?B?OTJQdk91bjlweDhNaE5xdkE2dzBnMmZyRVdaV1Zyd0ZXVmhCNXZxL05iTDBX?=
 =?utf-8?B?dEVpNVBVdkQ2c0VHaEhZQXg2YkJYWUx6eVB6dVBJSVdiQk1TMmpUbThUbjdT?=
 =?utf-8?B?QUlaZjhRazNQcVBRZXlxcERIUXMyUTBrMTdCRXZYVzNqZG9QQm1JMVBvdzNl?=
 =?utf-8?B?V3FzcitZVVBTMXpxbkpYSGprVytkR05ZTnQ0QWp3eFVocm1mSnpwL2xQdXlO?=
 =?utf-8?B?NEg5T3lPYStwMi96anFsbC9hUmxDcGwxK3ZvVzBKRWFHM3lHcEVFNG9RcTdy?=
 =?utf-8?B?YmxDdURiRjVxTUoxakJuUzlUeWFxNTJ4ZFBBRDFCZ3JUL0locXEzbng5RzlO?=
 =?utf-8?B?SnRtazRzTTlKWkpWK095Zm1DTmNwekNDbWs5OVJKZ0FnamtURnFzZGwrbkp3?=
 =?utf-8?B?eVJLZFlyRUdtTk9sNE9laEtDcFJ2d0JXRmhNOTh5aEhDS2UzRlJ0SDN4Y0VM?=
 =?utf-8?B?cnl1NVpEU1pITUZMOFhKNXlteGprSk5PVThZUEIwQzIyTy9mZDdIQ3dTMFNy?=
 =?utf-8?B?Ym5vdEpUZHdFaTM5OHlqd2wxRXkyaXVFMEc1MHZxRCsyUy9XcjlXdU5xNkxk?=
 =?utf-8?B?N3U4Wm5RcUh6SG9wc1YzVm1PQ3JHRnBjOU1Nb3FmTGI1VDFKelBMMndsTW1w?=
 =?utf-8?B?cm1QK2FXOVN3R2hTcTMzbSsrekx0Y3h3dGRiWXltOGJ6ZXFDRGxKSG5vcjcw?=
 =?utf-8?B?T3YvWU5oNE8xL0ZIUmM0eVgvQ1dqWUZVY2Z4T1B5VEM1cFJwNFVac0d4d0Jp?=
 =?utf-8?B?TUt5dmw1MGxSa2t1bmZwQ2VsZXB4dnVYdXhnai8xOU1SMTViaGlsdTFPelpz?=
 =?utf-8?B?VTQ1eXgrVldGN1cya0MvRkZSSEZxd1Q0NUNISTNCYlZTb0VhL21ieThSZ2RX?=
 =?utf-8?B?MU56S1JHYTk4bktGYU1tbU15bExwZGNyTVVjaVpCckRxRTBFcHltVlZDSkRZ?=
 =?utf-8?B?bjMraUcyRGhabHNqTFNBaW90ZzE0UzBzb0x5bExobkxNY2llaDdrVDBQYUdo?=
 =?utf-8?B?WVpPbjNXUVdTV1VzRFhNVzJOei96bEwxTWdFYk9ycmFqZzFzNHQrQUwwZ0sy?=
 =?utf-8?B?b2JXVk01R0VZRExaRlBGNUhUS0NXQ0hPb0Y4bHpZQmMzN1lwcld6ODNVeThS?=
 =?utf-8?B?RGRKMVFtd1pxQTVhcFQrbC9mN0tjVXRTWGZyVkh0aVRqWjdTSElTc0M0LzVG?=
 =?utf-8?B?aDVMVDlySm9UdmFFaEdkTVZHRXBYU3BQdFRqL3VBbG8wQUYwMFZTblpyS1hJ?=
 =?utf-8?B?WWNOV1IzQkRyMjdhSm5ZdVNvMUNvUGh5d25BNk5iRFY1ak5ucGVEOEdVei9Z?=
 =?utf-8?B?Sm5SL3dvTVhKUnMzc3FhcUhjamFDUGdXU1JVb2Znem1UcldUSkR2Y2k5TXZ4?=
 =?utf-8?B?cll5Z2pYSnBkWmJlZFF4VVYvdUNyd1k1OHNJcXN3TmdlaFp3MjJ1NENHR0hz?=
 =?utf-8?B?bDhENTJNUE9OR1ErZk5yaWhvUzJGVDM4d3RaNHBlWENLNEFncmV6SlVPWGcy?=
 =?utf-8?B?VFpsN25xbTc4RE5XdWNWKzNNaUREUS9wVzI3L3hPdC9rZjJqNHAwSWFaQVdt?=
 =?utf-8?B?MEprOHMwcWpyQUx2b09yUlFGcnhORS9NZlpvNmZwa2hLZS9aV1RCOFI2dHlL?=
 =?utf-8?B?bXpZVDhHbGx4Q2dRMkhTTkR3dGhETHQ3dm02SXBPMTNhSXhGVy9lMDFxTHVT?=
 =?utf-8?B?cnh4Tit2UloyQmorVGlSMkVXOGZad3pCdFZ0d1dpTXFKSmV5MzJEK3pIaFBI?=
 =?utf-8?B?WTJiUEtPelVjU0RKamhkYzREL0ZmOUNBdUpKaUFKa3oyZEJ2bXhJcTBtWlJ6?=
 =?utf-8?B?ck93OTAvM3dLcDlJWXhxVXBwdk1DTTFhWEM2ZWJkVkJGVE1PdVhtY2FhSWVI?=
 =?utf-8?B?OUlYZzROL0dqMyt3WXBGTUFUQ3RWQXFQd3UwcWV4VlIycWRUREdBS1U2YzdK?=
 =?utf-8?B?Q1FrZENNK0RmRjkzSGZhVGdVNHRCclIyK2NGTldOVmxycHV5L3lmNUk1YWVJ?=
 =?utf-8?B?TXJyT0dtKzUwM01DV2JVeFNlRDFDYU5SSHptUjZ6WHZzQ3RtUE1kdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d7508-884f-4da9-57fe-08de80020882
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:38:55.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33ANBcWyEQsJvViRt0AQ0PGQ1UE6+KrT9l99SmfnN6Mu79CLt8LE5NxvyClRpQyLnX4ES7ggHDeIb5dlyFKXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 06:39:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22353

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=3&day=12&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/03/cip.2026-03-05-12.01.log.html

* Action items
   - enhance wiki around board support backports [jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Mar 12 06:38:37 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:05:13 AM UTC 2026
  limit date: Fri Apr 10 03:05:13 AM UTC 2026
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
  Status: *Late*
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Feb 24 08:55:46 AM UTC 2026
  limit date: Thu Mar 26 08:55:46 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 24 11:47:33 AM UTC 2026
  limit date: Sat Apr 25 11:47:33 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Mon Mar  9 07:35:00 AM UTC 2026
  limit date: Tue Mar 24 07:35:00 AM UTC 2026
  Status: On track

