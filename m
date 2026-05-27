Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDCACD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 23:18:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33476.1779923909568451289
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 16:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tBEY5oQN;
 spf=pass (domain: siemens.com, ip: 40.107.159.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcsQntZQCFwE705LfwvtmXSDmNJRbDHIT1RodeePL+6/4qiq53iHMy13NNu0GO8cr5oJKElWgWTOU62QG/6XN3+jCe0mPkaIPcjOrjV7q9bM0HRYJzJwNu9qdmC8Cm3Yey32DNVWqe7dbvOvz88sjK3LSxnpH9NuXnEuKwn8QRnRsEmsGWoYN8BKNDEAoigqzAzUWzoQ6J7YQwycbBCQ+hA8LiGdCX0CsP9TqTccU1mY10LLJRi/+VFh1fwoaV3zAfhZpvtj9ETsYEOXb00mEz1BrRo/1pNuyMbZRf3eKQJ5FNUM654w+GnY2B2yqd9/9NZXSsNb5zY38iHCRZ4GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IkuMEKAffBBdyeF9nktxBk3OLT/yxPi8lk2fP1FarI=;
 b=TsVBdU9A62pP16nlsy3q3wb81Dg3Q17ZiqKWclIyolhU6+NiLMeMQSV5ntOzh32iLk2VAI5X6RIR5Wp5HrPNnuAPjMd3+WUYJNVwoW5HIvLmDHaas+sdPSuPcd3pawNe9SpqcjVFFRycxwGgBeIp/vyYJjHJp7Y8kRMhi4Y+LCEQi3zhxCWVGm58GDe9HLUUo3HzmO1pjmFsZ4FXn20sFzo+KVK7tlt4Kd7KD4gCYMDjsOo5pXovv1Ay+phN6WgSR+dTHV9FaTAGS8/GGzosYcl8yu9EdJzDOuobi/tKqe9R3k8gBhGPLKLJrUyTRR2Ad2BeMDjCpQ1b7WdzTzcg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IkuMEKAffBBdyeF9nktxBk3OLT/yxPi8lk2fP1FarI=;
 b=tBEY5oQNviR6D3GVYMp/szMmghlxs2E1qhSgdgJK6PkyHZM1k4xsb5n44C1I7Io8G2pJngemrJwNl7vqRa0tte9hhBiQaEEnxE8Hrdqq5y3/oolkvP03P8BiAkHJ27wV2+g9tvcOU1UImoebih81PqI46JEdxkDzWHPm7apLHe0s2TyCdlOSp4egI1VJwhfP1F//gSDWahVr75Mwgf5Wugcz76c53XKmvbQ0Xnlo1ydkcTLlDzlVyrGPzfg4stmHFaGDnqxBF/jLeVwBDwT0KNyzbA4nTFeKOnH3OeXbIvH0kCQPJ33j0B4j47+0iRZdl4MfT0dX2kCGNX5usjrnEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:18:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 23:18:23 +0000
Message-ID: <ee790f7b-6e1e-4dc4-91f3-f93c3fba4d33@siemens.com>
Date: Thu, 28 May 2026 01:18:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3200:EE_
X-MS-Office365-Filtering-Correlation-Id: beb46ec5-cc70-4fec-0589-08debc463f9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/DwPtPSzFqGiPnQ6mrzP/06NpTXxzBuZtKesDc1YWglkLxP0sO3Wnz6JdETjp3XedaOXuyFzkxI5AXzcrgtoemdaoroRE/D/m7RtH8UGF4I2r+jpkDoeNDsZjyBsAlk3GcuLr4JllEFSCqLD6xNzZ+BN75iqjL9yZxIBAQ102Oywig3bbU0P3kFqkHRsZZArx77ZjY7kgKtUFfAWic8Zcy6t1Q0Oq1CZwBp+6QkLb8mOXEGIfcqbnO9tKzcUwjQ4N0SpFpCpcwJ2mbq3AJjoVedvx3YAu8CS3OmikBlfOzqO73Fy8V6HQjR02+lJKnmzx3Lpxuarq7qMBDVqn+mGGpercgJfNTf08r1db2JuGXep0UW21I45RyDdUcajqUBIQntM8/P282fx9XYc7+NdWGkrkuof0WqYlXU5v3sAhDAygRH5PQBgIJtUc4HP5770mGAK0DadkogBQDZQQGoiHDI9jH2GxmDwc3OsoaLGjsYyFDD0KC06gBlB8ESBAWRnXXdY31XFF6T/P39cpciTm+WyPZ0ocqsVklbfuS6AtA0PvJWWUvm3D5AAkCpj+cATrUuk7PnYKCCE2opibwyvvEnIx6xya3JCI4U0RUOp44dkMhtDv6kaN/mJZBLYefDBHdBJgn4Jnmv5HnA+Hnl+EA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1BTZkI3TVBhNWZBV3krc3lHYVppMFoxV3NtM0lsVHV4ZjRNNHhkMGxJNHVS?=
 =?utf-8?B?VVJxNFIrT2NtQ210Q1FPVDhmK0FrMHo2MEFQUUFzczArc1hWb2djODFvRTRW?=
 =?utf-8?B?VzE4VHBvOENGTUdRS1EzV05ldU5DZVBMNTIrRGJyTENuc2xJczAwVnJELzBT?=
 =?utf-8?B?N1ZnOHNnV3J2RFhoMWkrYVAvVW1iU1FPV0t6L2o1ZVR1TkM5U2pGcFhFVlJX?=
 =?utf-8?B?NldIYkwxSTVIS041ZVo2eEdiejQzOGFqRThxbzZhY1N0V0VhZm1JNDlvZzNH?=
 =?utf-8?B?QnRpU2FKUFpzQWg0Sk1DSyszOFpSVFJOY0Y1R3Y2K1RSc0lXVldWV2F6Ym5y?=
 =?utf-8?B?T1QzNXkySG5SbVlhSUlVWTdRUzBOdW50cWNQLzQxVnB0cnZBbnM0bk5KVTZh?=
 =?utf-8?B?aEhVRU1Sb2dHVFFoRXNwOW1OdHpiZW1XdDlYSm5pa3pqZEo3QkNwMkpnMVFs?=
 =?utf-8?B?RDNHcm13QkZSeFNoQ25ocldCREFuUUdWb2ZOQXZrZnZ1bStBbFFiOXRmL0d0?=
 =?utf-8?B?SnFuNXBCQzQwOEZJbXJNUnh1eFZGejBhU25ONWVWT0xUdUUyaHBzY2JqRStY?=
 =?utf-8?B?MFpBbStvWWcvU1c5Y2tXY1NSV1BTWDZXazU3TDQrU0pYS053ck1xR3g3QTRx?=
 =?utf-8?B?dFU1MnhFWndCdU1PSGVrLzdmbTNUZWlLUW1WRk9KMXBaL05QTnErNnh5cFpu?=
 =?utf-8?B?elZ6ckt1Sm5IWitPOU5DTFdVL3JSV0I5Ym4weVJhSklBWWRqUDZkREM5Vmlz?=
 =?utf-8?B?OGFIc0RhbEM1NU5jVEFWR0hVdGpSbU1aTHdiNExBbzFFbC81WUk4QTk0bEtn?=
 =?utf-8?B?alYzaXhzdXdvcjcvMzZaOWRPbHNXWHU0S0xNcFd1OUFwcUUzOXF6RGt1Ym54?=
 =?utf-8?B?TTJqaUI2SEIwd0RCZi9tQ2thVi9zc25Ocy93ZkE1L3hPWDZxSjZ0d1FCdCty?=
 =?utf-8?B?WitTbHg2MmUvMytmRlJkdFRMOTQ4dzZSTDI2eGdkNjQrQThMQXdMTEFLWXl2?=
 =?utf-8?B?dHBDYkFMRzRaU1BRY1E4Mm5HbmN3MnV6MUtPUGNxWUtSTFFpclhWMnRTYSts?=
 =?utf-8?B?TG5LWFUySlZVTE5oRWR3WHlDYWt0cE5vNGRQVE9oQ3dVQ09RYVVlWFNkb3Y0?=
 =?utf-8?B?OGpuR2Y4cGFlQkhZZTdON2Z1d1RoM3ZkWGdSUmdzaXB6ZnJPQXQ5eW5UVjJK?=
 =?utf-8?B?c3IwZ2RwaWIzR1phUXJ5VVhManMzVXBzMVpJMDVLbVRIdGRLVnhnUjk5U3da?=
 =?utf-8?B?WlBsK1l2Z29obnlselQ3UElZck1md2lnbldCNFVXOXVNalZOeGFCOWd0NnRT?=
 =?utf-8?B?QXh4M2MzVms5Qk5zOTNnRkxmZWh5akR1bnkzTE1NVFJkbmxwUzRudW4yTHRY?=
 =?utf-8?B?TE1XaWtydE5idk1MYXp3cFIwWjJXNnJIZ1gxZTlZSmJFWC9lWE44eEd6RWZs?=
 =?utf-8?B?SjV0QVZKUExuRHpqdlhZRHdTSFRyd2xySUtsekgxRGVPVlVIVjRsTnZNVVdm?=
 =?utf-8?B?aU1IVkgvVzRKRHR2clZPMC8rVzFaL1hFRFZoeGxWcG9QQmVHTGhKYjlvYjZ2?=
 =?utf-8?B?Zk41QVkwYVFjMWVCSVJUZW9TZWprWlVwL0wydStrN1hSL1VYbVBYb1ZTaFZX?=
 =?utf-8?B?MEFpcnFoWmVFRnNhOTNDUnlLRXI1SWFPS1JBV2dDOCt5Nm53WEkzZk45NG9l?=
 =?utf-8?B?M2xrMGRyVEN3RUpqR21DT2htN282bzZZSzNOYmVkaXQ3U05zaTlvRnpFZ2RP?=
 =?utf-8?B?SHFZOWo5ZTJ1c282V1YrclZXUFBSMjNtZnMwRTQ3NjJZMGFTdGdQc0VDaGYz?=
 =?utf-8?B?bjJGZEdUV1QvL2hwaHdUaWFCUFlCbjFVaThQQ0J5OVUyT2VzS0pjOTMxWDND?=
 =?utf-8?B?KzdVTkFGeFczM0NqbmlmNmRtSEFMSG5JVmRsUVN4eGx2eHZsaUxqNC9RZVNp?=
 =?utf-8?B?RHNuWHlYeDlrcGRKd2ZPVU9oajN6a0g0elB5KzR3VEZZQjZvMWNYY0tGK0ZV?=
 =?utf-8?B?TkUrbDltUmZSUUFabmFOdXIyU3ZvSHVYK1JkZGRsbkw5SmVicWhhOWh4dTRV?=
 =?utf-8?B?Y0lDRWwvbjBqNXNlWGJQckFyOGVnUjZpZStIYmVRK0QrNWJEOHJYTDV5U3kz?=
 =?utf-8?B?VGVLUzJ5K0xIb2ZHL3k1NTVvVVBtTVE1dHhuK1ZUUTZ3aVlEQ0tJWC93eDdV?=
 =?utf-8?B?T1ZqN2NydTY4dXcxanYwQm9pQlo3MW4wcTBFeHZzdTlMdG8zblJRbjgrMCs5?=
 =?utf-8?B?NTVXY2xvanc5Ym05YlFJd0VqVnl6SWRWNTBwL3JLNkJDaVA0L3VSQUxHeld1?=
 =?utf-8?B?dEp5NzlIOVBKdnRDUEk4dXg5Nlg1YzZEemdLUU14Z1YzOHhxRk5MZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb46ec5-cc70-4fec-0589-08debc463f9f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:18:23.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXVAAFkclBmOkzNSASgs2/heSDfSbFlLvSw1+XNCpPBuqKSskSwyMHFthCmhcVw9D6HaTvlvFV2en+qTs7/ggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3200
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 23:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23030

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=5&day=28&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/05/cip.2026-05-21-12.06.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Wed May 27 11:16:26 PM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue May 19 02:53:20 PM UTC 2026
  limit date: Thu Jun 18 02:53:20 PM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May  7 11:06:48 AM UTC 2026
  limit date: Sat Jun  6 11:06:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri May 15 10:25:33 PM UTC 2026
  limit date: Sun Jun 14 10:25:33 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri May 15 10:28:23 PM UTC 2026
  limit date: Sun Jun 14 10:28:23 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu May 21 11:47:46 PM UTC 2026
  limit date: Fri Jun  5 11:47:46 PM UTC 2026
  Status: On track

