Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94CCC531CB
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 07:51:18 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18611.1784793075078893190
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2026 00:51:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d68ktYTV;
 spf=pass (domain: siemens.com, ip: 52.101.65.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFU24j+Va38fefyF5w3JGtMc0qMtCNQ8OQeV8VczWKgvxwADpjtyGMHLHVFzuI8EGIdLeHrq1XUz/pWXsP5rtUYdcPGzqsDM0yTfL6EKTsGFgNOkyGIlahxfpTVeNWL6FSXBZ1FdJ6Mklt7H5ZLDfz5wlxoXjxX75xDWpQCwS/fz+imzss0QjRD2xceCEapsUBImygVpU7UPai1kMP4xvuki4VnONpgHMQ7d9mgg8nMDv3WYT6vR5tk+UN2zqB/yx0YzCw543pglwGxc6G5w/zkFOV+6da8rIvrEy58VDA588x2s3a0ArHCkmwjSdfF5mrszafhbL+4orKg2j3xATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN8GjU45yyQcCNyFEd+ye0vXOrpYNbQTG9N/AXII6zc=;
 b=sJyv3LeWsywnrIKuCYRgsrmQIuC5FNdhYT5QbNHnKj2CB9YPmwYydkJbtK2oZ76C2jb257VBwKVp6CfxWLjexQm/22RBz7kC73bkCBnGUYKN6xASi0wFTZYMSaBMGHVIXArTe+ly/j9016rRxPqTpLLz+JbwlbEMIBMokaw8anrslVC6NOUNKAa1RQ5O6me+iV3OWEmqNCf1Jw5ReRlHs+8gHPZ2grhZZAXnjeZ1qc5srz3GFiS8hfsDIMvWqNTRvBLKe+pLYZSGGFmxit5+OVkfTmShyU40N9jYQjR6HyMYUQYbTBWMG6JeXtt1UU94sl3M1hVEYgjIkf2mxZ/qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN8GjU45yyQcCNyFEd+ye0vXOrpYNbQTG9N/AXII6zc=;
 b=d68ktYTVIrXmuex9LgjEhu4f4N3cOoqZ0c4xofkFOs1CaScw2rBuSm2a9NLV0PpZvK6o0YFspbLH1agVL8UDyJE//tlATLzVa07kjrequ4ip0ZdLRWit984sCe2NtVo9Z6GXM7EUXkr6yFWB3dW3eK4GpkumX0dm0rFvvPg+P19ZiWTCijA53r8RPeG0dkkwOfXrW2WF4ch/mm15SHSSFKvPtJOCXBkyKwPLGjUKYXN8hhUnYiUhZNk+N4Y8H17BLwCussdDs4V3g2TPbkmkJOpuA4RGtlZ53JDVYiklz1DemCpXaN7IrIkGv08n49HI9AisTTja5YawJoXi1BGt9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 07:51:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 07:51:11 +0000
Message-ID: <247f5584-9f55-40e7-8826-9f12f4f61ed1@siemens.com>
Date: Thu, 23 Jul 2026 09:51:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3913:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ee714f-9269-4956-bf35-08dee88f297e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|10067099003|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	L7CqEtrj9c1oZAsfyTTXWLKSqIR/GG6M7yU84o1b+HsrlPD4T3Ubv+HKCj32bkdhaANLr2GwdwweX2ZBdKsKiCGCm2ObhXvwaOV0tTDb8DAJzuvTZRDvvn6+nTA+BnPHSAK5y90ufpKuDAa5Z21M1o6ctDM7LOHhpFO8P2KCKlTR2wVONMb0lLMNyvUAltKZkIpNrEkYKPnY+eoRUIu0NU1KHtACIxZFdGGhpNbpdYlYHlOWPMEl4KBjNwh+SQq4pItVHrl/l3sNwlwxz9/XgllZA+HlUAIPxO1us6TOILTNQKfUE0cNytNqRe4oHuVO7dvF5FtsM4kG7q6STBDyCH99H9OlhI0ulwsleq58DsLqJNqx9cuuyd5su3HVGVyF3rrH35ZWyw73RvrD16OmBTH+gzG573wA+DGKkqKiOw9ZN/l5VsL1/C+ow1yagBk0w1th4T7WV6srSSqIU09JrDxlxcvHlCvReE4wpJJ3+gIovT52S5SRnMgltLUJjamB13d6bQxSkH4oqKe/JtynjZhwQjwcJABFKepS+wDytR4yJ3qOYT3xtwlbbWtzv37yQ2oTqihZXczen6AlwMiDK6VGMs98trKcTGnG0HmfjobacuzRt/g93MTwSWkx9AuX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkVjdE9PL3pNWm1XZ3JhR3puWTNtNDBaZGtuOXdoUFpQK3RuTjBOSnYrTzdj?=
 =?utf-8?B?c0k3UXJiS0xSRlptakFoNlpZSmh1OUVYc2JTVThGZCs3RmNxbHUyTkNrV0JO?=
 =?utf-8?B?YkJNOU83bU5BeFZqRlhXK3A0VkNBekM4eDRSUXIrc2tPdy9wZTJpUDE5azdW?=
 =?utf-8?B?OTJIeUNFa0NGK1p2bW1jM1Q5YmYwUlhSVGlCOEZNQXVYU2JCeklxMTlzSGV3?=
 =?utf-8?B?TVJlZ3dJM3pZcVVORTRQb1lHSlhYTjJSamhuT3VZVFBTTERId1JSc080R3NJ?=
 =?utf-8?B?UFdqcnBQSGFGV3UwOHpOT212cDh3MmVvVFJudHkzTnlITWp0emVGa2syaUlF?=
 =?utf-8?B?OWNyNnVCSkE0WS8rd21UaVZyY0srRUxhM29PMUVzZ3BpSi9KM0RnMmRmczh0?=
 =?utf-8?B?ZEpGSzlxZkpXYjRyOVpJREVSRi9HcjdPZDBQYVQwZ0lNaVNZWHNTQ1hDRFYw?=
 =?utf-8?B?ZzhjWjVCckpoMjNrd2lqOHhrdVo3LzhyYkFzY0YxS0tTdVlKbERobnNhVXor?=
 =?utf-8?B?STMwbTNWNXVyY1g2dVBGL1k0MUEzTmNjeTRVbmE5TzNad1hOem5HVUhvaWhD?=
 =?utf-8?B?NWcvV1pwY25BZ0c2bzRaSm5ORVJrOVpjbTNoaHVzODVKWmNUNVp0T1hkTjlw?=
 =?utf-8?B?eExSNklMY3hVUDBpdkxnaCtCUWdwK2g3MUY5Zk0xYVZhZHZHek9sLzVOWmVF?=
 =?utf-8?B?Nk04dEhqUHlGSnduYlg5eWx5SUJWdFRJWnhJSjhpUXZWRWhoR1IzZnV3ZFM4?=
 =?utf-8?B?MkQ5UnQ0R0tPVDNKMkIwS0lLSEFzK3Jkc21aeXUvdVIyTjRIOWJ5VGUzdUF6?=
 =?utf-8?B?TmYwVkljY3lxdnkxYWd0Y2xwME5kbk1OMTNBQ2V3Um1hMEc4WnptVC80MzQ0?=
 =?utf-8?B?YU5zZkNUc1JaTXRxR3pMbUw5ekh6R0VpeEErTVlxS1JTNVB2Qi9OVnl5R2Qv?=
 =?utf-8?B?Tld6QlloTlVGTCtob3VUTGp6RkVMVWFDenV6NWZadjlSMHpNNTIrNVorZGYz?=
 =?utf-8?B?K0JvUzB2dHZFRk0zclZXQUNUVXJob2cwNmphM0NwNFBaSGRNbVU4VHZPSEVi?=
 =?utf-8?B?SzVLWGZ6RHZhWUVjUDBVMGRLcDBCVDVGZENlZjArUnJ1V0U4dngzclNjc3Zw?=
 =?utf-8?B?TTVmbHFEMEp4Ky82WVJFV3lRK3FyNTB1NTRQUHJaR09tV055cFRSMWl6TWpm?=
 =?utf-8?B?YXNNRTN6UW1TREdmbzREMUtYQjdxR0NRWG5qbFQxd000dzJsTUFKZkF0NFRM?=
 =?utf-8?B?dDNzZC8xWVNtTGRvR1U2b3NNYmVGZDU1bDlvMTNxWk9jOWlDZWJBOGl5Vi9z?=
 =?utf-8?B?MVlYd2R3Y0dtL3BPMlVKL2FiR3JJb0tRMC9Bd3k5RXVsTW5EbmgrVTd4Vlk0?=
 =?utf-8?B?NzRpTWNZZzhWdEZIblk2RjQrak96SSszcERGMDFUSVVjYmFNRnY0cGwvdnhS?=
 =?utf-8?B?a1lUSUpLL0IyVXZ0ZHBORThLUlRMTVpZTlNyN1RBUURpYTNBTzFxRFBaaUVE?=
 =?utf-8?B?L0JodGJ4MEloSXBMait3Um9QNFJzUG81cEp3elZ2SVl3Q2gvTi9JcjJrenZW?=
 =?utf-8?B?UXNHNWNrSUlMTlpPOG1uTU51cGxXZlBMYTNOTWd6TDJIUjRFeWcvcUNrOVhY?=
 =?utf-8?B?UVQ2eTZJSDVsTStweDlXYzFublZIYjRBV2dKb2pjUmRXc3R6U0o0Mm13bitl?=
 =?utf-8?B?Zm9PQ3JIM1g3a3lZQXR1b01iZG5LZ0RZZU9SeDl0OGcvcWhyTzdwcTJtVGN2?=
 =?utf-8?B?QzJBNU12ejI4QlVOVjd3b0d3TDRnYlRNbmhHbHJjb2hDd3hTZVpOd3liZ0oz?=
 =?utf-8?B?UGh5RW5PM1ZNOXRtWFJGSVNvN2VRT2lucDJSWjVpR2FidXNKNE42b0NvcXFv?=
 =?utf-8?B?YXRrTEgrVk9xWTZsajJYWlV6L3M0Q0lpRTRoZE9Pc081djZGaU55QmROdVI5?=
 =?utf-8?B?NEV1NnRNNnZSak4ySW1vSFBuelVqb1VHNFVEUUhiMHY3R2FyTUsrUEtMbHpW?=
 =?utf-8?B?MWFGb3NPZkh1RFIvMmg3WkJQNmdPbWlONzZ0aGd1VkF5WG1ZOHMxUVFwTU9h?=
 =?utf-8?B?YS9aSDlySGs3RVJsVngweXZtTGRtbXF5OGN5bkV6T3BaSDBEREQ2ZFZwTFFO?=
 =?utf-8?B?VHhLTzYzV1NVNitSNDhxa2MrVVQ3dFlyOUxwaFB5UE9IUWpmS09LZDZpZ01m?=
 =?utf-8?B?cFBLcHB0UTg4ZWswK3ZZdENsUFdjeDJrendXeXdqYVZUQzJMTHV3KythUm9i?=
 =?utf-8?B?eTBnZEJlV1NDQndSa1BJaWFuakdndno1OTZNa2g0bDhYQ01oOWRhM0c5WUNk?=
 =?utf-8?B?cEtnZTN2Z1RUWW9YK1ludnUxM0NpVGZWQ0ZDNWtOVEJTeTRCVm9YNERKQ20w?=
 =?utf-8?Q?szbOOmjRgAHgXqF0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ee714f-9269-4956-bf35-08dee88f297e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:51:10.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/C6VDb/Pfbuk1f3R8dRxBFzqafnlSE3N8SiFEtY7dmH8LbLhsisKRvwtFyZbeOz2CdwYRnekhdt7e0B5C8r+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 07:51:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23724

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=7&day=23&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/07/cip.2026-07-16-12.01.log.html

* Action items
   - start blogpost draft [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status update AI-based backport review setup

Jan

[*]
Date the data is created: Thu Jul 23 07:50:33 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul 20 10:00:31 AM UTC 2026
  limit date: Wed Aug 19 10:00:31 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Jun 29 09:22:22 AM UTC 2026
  limit date: Wed Jul 29 09:22:22 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jul 10 06:12:25 AM UTC 2026
  limit date: Sun Aug  9 06:12:25 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 21 10:45:07 AM UTC 2026
  limit date: Thu Aug 20 10:45:07 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jul 10 09:06:07 PM UTC 2026
  limit date: Sat Jul 25 09:06:07 PM UTC 2026
  Status: On track

