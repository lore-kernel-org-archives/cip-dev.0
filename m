Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F143FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 05:08:24 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13518.1777525695129565529
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Apr 2026 22:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NGy/0Bok;
 spf=pass (domain: siemens.com, ip: 52.101.66.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXYRzA3sQlQZ0ZUTJT8iq4NhS9jxqnp5b93v3TacBpHZ5FvUZeDgoUW09Hdw2s0Z+2QoUK+rl1jQall2rjAJKxyPG1TvLFzLZnBbeUlJfoVUF2lAPbsBHt0wDYVyoX6C6g8HBn9nGjQi6WBlYnB8L0fhKS5lLU7FroIeMyEIFm1GaqYABW5MRYztdXbbnVo6Xg1WGx3QJoahU/XjeOMWbYSQHvoaES3fu7elGIuc9985OAocGGqmCy+xbBpQ+ltRkNcJCxY8y33GcgVomAz0WZ5lurjVUYOFtUi3W6Qelm22h7bL7HGMUjFSo996mxaM/dEYGtcIYHqhsHErCgOtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dErEqoWXqupyWKfeYzaD9aQe/kTv63R3ZkgY3iP9hm0=;
 b=R+nCY6S9P8G8aJQ+57pX02ze5nw4Mc+kgvCCS8wQOQAf0idRA8bpfwjqzyZH+wRjBDTKc+gUS189yrTtrJKlB2R0TXXYi4ZSkVSfnUc5n/RLDx4Mg7ZDMe57jtLSTbA8EUMMxhklDy8cQQwhvDY1PNDbmr9hMb1GzXbn6RKjQ4Ql6SDWtRI65ZRdb7fS0CitCGJ51+bNK7QhYrWHw2En0Tce0bY0bItMCqEwTbJRILPmJLLF9CkLIpVyCtTAcxrK2vtzLaMLCcxyF4pRpmH3Mcf01TCOVRd9kLf8w13UMA/7mQtaK3eTjBg4i8nm/hVgN5O7Efy3xLG+Xi2H9VdDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dErEqoWXqupyWKfeYzaD9aQe/kTv63R3ZkgY3iP9hm0=;
 b=NGy/0BokDvkj+vInvgNa9wWZBEdAC0pjhRGHZ08EnYFXr1F+U6UmkYIF7VDCFbZqtjlI49FNP4pXs7lUsn895jBUpB8S2Xm+0rHff82SroX4p98M9AY8PYQEC+DZXPX2+ZgaATqnodgFHcC64FquZXS0j65WLKbUCoXjDWMjSJEG6ncJWifVkCylcqSOAkRdg6w+cZXwLAymlNQxqW+uUXVFWkWITdi0QFDQkw/AUP1H3deaE2qtGNZIrvd+gv7ipdIylxyPsQYx8GnBP/VwPqgOUfQrEmRwVcK5+VVvja3tcqpnMDdeRHX5KtOrVlVDTbQ6eJPLBvHRp5FHchudKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 05:08:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 05:08:11 +0000
Message-ID: <502eac7d-b4a7-4c74-8c87-66d1009c43ea@siemens.com>
Date: Thu, 30 Apr 2026 07:08:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3868:EE_
X-MS-Office365-Filtering-Correlation-Id: 724e0124-3ecc-4222-e08a-08dea676797d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	JFgLGls2/6xFZFpMXx+T4BAXFa87Ztbm2/NasP3lbYIs3Iq6qGjRT50LJe+qKE57RpdFJwQZ6jLcRhw0U+oMa9o8kq1Xw9kZX4kVvYeZ+BXOFo2y1fQWNaxMay4dyDz19IVMbKuHoFO7B9IVklIZRpcKaojKqx98t8B7bXia+lUJxhIvIcobkD3fPzA5E0JqPzhahQi9Z2hsCe/tDRn1CHb9bgApHJHNT2UfhAk80k1vfR94Jhdockwf63mAg37eENnl/USqTcV974trgYa+Grwv/lY2JkQZcoyiksr6H4vbCQItDpf10dLCcPi6l1JJPJiQ1zOFoPcf//k0c6fwwh+n4VPaO6w8pREz+0TkMbfy8nOlMmBbwEvlU23z5h4Cbf0gmdZkgmC4w07ZuOsz9Sh6j7/b4gu/A0PIpaLg4fKPci+n6WbXio2RJbiK1YS/RbQZ2fsm6PNCoZmVOrB4y0QbRVIgXOLhIGHCL2tvYhGpO0juFIHyp4zI6Jpy+vF4jYwx33CVy3okeYgnbz3leDugBNr68/em5M2RKa2tosW2ZZJ26jS8485YVGCyl6Gfc03qxtLSMmOYGSQ0KS8uDT5aTCJSo6LYFBb6WOCLpaT3d2Zxz1O8S7tjCp2XmkC+/5xD3AiTTNPqZJ9MKNi+VZNHWhLIgaBrnx3hFQ6N7uaEocRyuxu0pF65cLWZTReS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czZ0VDYwQkxYeXptK0NJWm1DYXVhbmFWUUJXUXNUbkRhUWRaNWR1WExOU1ZG?=
 =?utf-8?B?MUhMQVZvVkNadmxrWWR5R2tkUURqVGVpMzR3R1YzNVZxaUZWTXpsRFo4bUla?=
 =?utf-8?B?UFhmZHRxMTRLNVA4eVJTN2R6REJxOWZwTlkzaFM3aXNRQ3R3akZtaGxsRitl?=
 =?utf-8?B?VVo2eVNXdUlFanl6QjZPSVY4N3dDbWZPMVNmekx1TDR0OG5uV3ZQZ1IyYklk?=
 =?utf-8?B?TFNTRXoydk5pdGpZNXozVDRTMThBT29iN3N3aUk4b1pjSURTMFVtSW53WWdE?=
 =?utf-8?B?STZsVUNRVmgwcHdLTjIrSkszWEFWRVZhUzZvYXlYZ3Jsb3hPQVJCMWN5ZWNC?=
 =?utf-8?B?cWd1Z1BocjVGalg2STZ3MitGcnByZWVtRUREWnZWanoxMHlWRm9OdDJ6MG1s?=
 =?utf-8?B?cE1KSU5rbXBGVU5QZlFqeHRRRkVqMjBrL05BMUdINlJtZzRGb3UyQ2hIZVlU?=
 =?utf-8?B?WGEralJXNERwYUxxTC8vcUs3ZXloQjhRWkovdHNZWWgxYnFkYTA1Sk0rN0RO?=
 =?utf-8?B?Z2NneXVoM1hkcHhMVk9HcWJTcUI1WjgrcHFOS3lKd2xrNlpKRVNoWEhnSmRJ?=
 =?utf-8?B?RVRPRGZreVE5cHE0ME91VHQ3alJreVhEZU1PV25veFpoaVNhMlJ2SGNjY2FY?=
 =?utf-8?B?MGxmdm1qWmpFd3ZDSjZ3bkNPSXBjOWJWd0xDQnhrMEN0RGRlZGVCL0JRK1NT?=
 =?utf-8?B?VDZlSERPNVdzL0xGSXo2ZDN6K21uU1Erc1RpdnFNSzlxYmJOV0JPUFhyQjA1?=
 =?utf-8?B?SFFWaEQ3bnNDa0VvYWFzYlBVSkdjanMzYXhFNGwzOWJFZDBJczVkTFVqTXla?=
 =?utf-8?B?TlFFanJRcTE4dUMrdzFBUDRuVE4zeU5BNWE5NndFNzBLRUovdnVxVmg5VXZz?=
 =?utf-8?B?V0VwTW0wM0dvbHNvUzBsTm1GcmY3VEJPZ0NFaFlyNU5JOWVIVExQYnRpY2dz?=
 =?utf-8?B?NnFRWEtmcFJRdjQ0bHE3aVhZVy9nTHp6aXhhc25pa05XZllJTnhHQ2VrL3J6?=
 =?utf-8?B?UzZoUXFBRjVpck9ybjlkZDBZSkxUUXFVWmlwNWgvOHpNOFM1MTNzbStLSnVl?=
 =?utf-8?B?a0ZMUWZiUTUrYmZtZzdHbXdvVmthYzcyM1p3NW9WcEtlUjR5MkFrQmtPZjA2?=
 =?utf-8?B?OXdZL3dIbFVYTmlSc294TnROTDNKSmtCSXc2UnhmeTVGbVpBL3FDcUM1UXgz?=
 =?utf-8?B?OG5rZ2pUU2JqNWpERmROMndCMEFyWkRhY0pMdVFZemovUXdtditMa1UxSXgw?=
 =?utf-8?B?SXd2OXFrWkhKQWxxUy91R0VNQXcxR1hsSVJ0QXczZmE5Z1c5eUpGU080WlQ3?=
 =?utf-8?B?OU9GVlBRNzV1OUk5WHJ0T0xiYkxZYUdHUTN1WFljcTlrZXdIYWlVeUFrSG5S?=
 =?utf-8?B?R0dSU21HVWl5TUFQdENlaVA5L0p2eVZubHNRbGlHQTA0WUloaDdSM2lMRVpo?=
 =?utf-8?B?a1NSNFoxSEpYNDFsYVJzb2xEYXptT05jYVNLUFFiY3NINktWR0FlbDNkbnVY?=
 =?utf-8?B?U2daR0Z4ODBwVC9PclZwRFFXc2Y5c2lCYUx3M0tubStoTkt1WXlpMUZnNjZi?=
 =?utf-8?B?Y0s0U1B0a3phNXp2T0Z1cm1ITjBjTFdNVWNZWXRZWVRvT3ozNU1sY2VBL1dz?=
 =?utf-8?B?NmJ5LzFTRWpJa3hYd2QrQTNja0dMZE83cisxeDdNMVF3bHMxWDRnbTB1NjMz?=
 =?utf-8?B?NWtNRkRTYzJFQW51OWVqR2VNMWpGQzVZS1h3S251S0tyclVZZm1lQW9VV1dY?=
 =?utf-8?B?YXU4SXJVcnNoZk10SGZ1YTVXQ05PM2g3Uk5ueDZveWpEdy9hSjFuOTdteDNP?=
 =?utf-8?B?N2NuVVphcHVpdEdFOVBORGszZkdhN2dHb0tXSjB0NGk2S1Q4U2t0UEdjYm5E?=
 =?utf-8?B?bjBjbmtpNlBLSXovSEN1amxsb0l3cEpzQ0RQRWlHQmxQRWxsSkxNSHI0NUFw?=
 =?utf-8?B?UzhEREp1bisybHk4UDU3Tzl2SnRVN1NySkFHMU5TL3lQRGRnOWhmQlpzWjVZ?=
 =?utf-8?B?SW1wdnBuNWhMY1FYdEhSMWJkQ21lUkVSTkdqeE9CWU1IQ1JEVWI3UmtyVVZO?=
 =?utf-8?B?R3JxSUU0Szh1Zm1VSDB3YitJS3JwTWlOL3d1Sy8yejl2TlN4OWFRdVR1ZGpT?=
 =?utf-8?B?UjVQbkxNZmFvR2dZOHdvR2NseWFuVHMwZWJsSmF6OG81ZUJ4R0VKMmtzMGgz?=
 =?utf-8?B?UDVXTVdTdzVCRWR1M2J3aGRrNThJQVlGV2NqaVNESGdHMUNJYkMvZktZNWVx?=
 =?utf-8?B?ZEtJdUMyVmcrQVNwL3FqelVJYm5heUNBYTNtNUd2UzJ0Z3U4eCtpUHVFZUZR?=
 =?utf-8?B?OVdnUnVDd09TQVd5a0ZMYkZQV01NVTRVeGROenJWdEpKODllTHQ1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724e0124-3ecc-4222-e08a-08dea676797d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:08:10.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CRT35yIhaz9NdjMdzbJBgCGwv3DdfNq7XP4Iqz9uzz+/W/zu4p4kQSVKNc099ld7/D1YKO+ConL0MBWYfSjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3868
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 05:08:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22823

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=4&day=30&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/04/cip.2026-04-23-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - feedback on kernel config extensions
     https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/b94a3e47914ed86265978feed0f2814ec32bf5de

Jan

[*]
Date the data is created: Thu Apr 30 05:02:39 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Apr 24 06:54:09 AM UTC 2026
  limit date: Sun May 24 06:54:09 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Sun Apr 12 05:58:25 AM UTC 2026
  limit date: Tue May 12 05:58:25 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Apr  9 08:04:37 AM UTC 2026
  limit date: Mon Jun  8 08:04:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Apr 13 07:54:47 AM UTC 2026
  limit date: Wed May 13 07:54:47 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Sun Apr 26 11:57:26 PM UTC 2026
  limit date: Tue May 26 11:57:26 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Sun Apr 26 09:34:43 PM UTC 2026
  limit date: Mon May 11 09:34:43 PM UTC 2026
  Status: On track

