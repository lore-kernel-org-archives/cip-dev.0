Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9DC369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 06:03:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.62])
 by mx.groups.io with SMTP id smtpd.web11.8677.1745474576287832540
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 23:02:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=E9PfTMds;
 spf=pass (domain: siemens.com, ip: 40.107.22.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXDXJif0Q3edFpTclxDiyKrPQx4ccd28EEdEgfdEadGQafQKk/ilP0zjugv9yH89kqk3fd7iQNcL+SB1LgaBJ5i8daGsfuTq9Ji+ZruhEdU46hnNlSzs2XS3GvWvOvVFixtNUtFeQIUpcrILZxkuuQeGQjkUAqXRAtOAUE1eQHzWf25G4heq2nD9fulPgJx3jSs9eA3WdqV9ScIaQRK3uJmm9kjDF13ISyODEoWS/7xdFYkOFINCAkeXfpCHw/JbCt46KFKByUM4NuQNfQTXzKY0Psx8qd8qI+gFxGL+9yrL4S9diZYb9I2xN1oq0Xk59KlZsjq1rh20vIVlyVeSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bow08mR6I1A6l0C1gK3tbKhbvRI8WCLNse5V12gf4bQ=;
 b=uE1hX8XeeKYyDlTchHVEQ4Luotg36tJHjWysJtyTi0eoam2TEY4wd1hiX1gLK9MRUnejazTNwBOO3xW3t/u76E2IlsAyRpCY3cIfTLUodHm9F3r7dubUgcu0WU6xzpT5QPOEMkKTDAi1G9ge0kVJjoBBFKW0SKk9GZhXRlCTRsSxhTh6CHi7VIA7AMvbzUnB4MbtjYBGskTQG5UCiGZF5iFL3agTdOPBDwZvt4W5fmbPpKPC/m9Nn5hnS6gQVEYzzhhKpOdphMU7CbO5WJvbwwKFrWdvz6299rE0sMaJJANQsb4/TrkWCyQ+BAdI4XuP64y+SxdVHxPIl021VbY8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bow08mR6I1A6l0C1gK3tbKhbvRI8WCLNse5V12gf4bQ=;
 b=E9PfTMdsoF0Aj/oN6WVGhIbdW0mb9La/+fm+bArBrno1c8nhCScBLtES0CwCHwH0laHwzBojxgSrXRR3gni1Vn+CJQFtvFwcN90m6MbSEkQQapbPZAnSMlm1cDb/gfhd6ASBV7bfpdby8iN9UfDphUUxKPoDvZ9yPD438gnbj3FVTzzbfmWbTln4zmKSAPYbZMK7S5AY2BMtrhFSM7NRB6zaq1GQT9VYs+Q8YUksF62h2UeOj9EzInvEShX9kDATp2HMwi86dA5KXpxutqSdhmDaFanZ03WC5r9lQ4pEWZ3LDSWDwxh5yCfiHgkm3oWf8NA+2CWFobagREx/esWcpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 06:02:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:02:53 +0000
Message-ID: <700258ee-195e-40e9-a77e-be4f1ae338a4@siemens.com>
Date: Thu, 24 Apr 2025 08:02:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3627:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e94c28-5a4f-4046-198f-08dd82f5a6a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHR3dWNXZzhuQ2xGS0YxSWNBM0NJc2xzTERTaU1DdEU1UWd1cXUydEdYaG1Z?=
 =?utf-8?B?THZOQVlaUjBZRk96UFhaOGV6UFZsWXJqVFM5NDd1c1l0bkV1UWplZ3dYc2JD?=
 =?utf-8?B?SDNGVDNIZXpKUEt5Y1RTS051ZHhNTkRYRlF5cmlTQ2VyRVRPd0VLcEpHZWdH?=
 =?utf-8?B?eU1mQk5NOVFITFR5dWtyZ1M3L3pIb3pqK0JBZ3ZiQnlkT1ZnQWw3dmFjaE5z?=
 =?utf-8?B?NDgyZE1XWFlrRUVxa0lyYkRvb1ltWEJUdHJPOTBOTndDZlZmS013Sy9PSFpp?=
 =?utf-8?B?Q3BvUkhLSlZkR3dkRFozOWhRaUFsVTdBUGd1OER4NHQ2RHU2blhOcWk3Vjli?=
 =?utf-8?B?bHZBN2haMGhEdEs2azFHblRIR0U0TE5YNHQ5THhqRUdYeDduSSsrczV2U0U4?=
 =?utf-8?B?eWhreCtXSWtNcGxWMEtlNFViRGhZMDNrWUk4Nitkcm5DNWQ5OThSWkZlMWdx?=
 =?utf-8?B?RlVXVHVTSTkzSUJnQlJSSDBYbmFYVkQ5SnlkUytxTVo2OCtkV0lETythNGpD?=
 =?utf-8?B?bDZ5eGdvblhGd0NXSmJUM09ZSmRPUlExcU0xR2V3K0hPa2wrV3NJVm9oaG5m?=
 =?utf-8?B?dURMZTZ0NXFIWjdScFliT01jai9ZM0ZhM050Y1paUDFUTkJKTUppTzNxTXox?=
 =?utf-8?B?M0xzdXN4ZURlR3ZoRXdDTjVNWmQzV0ZNdVIrNW5SYllkSU5NVld0eWtiSnMz?=
 =?utf-8?B?N2hyVEVlWHU1eXdveWZ3c0lrdWhFS1VMaHh6dEF0RHBZZ1d5Rk56ZVN3YVYz?=
 =?utf-8?B?NzcwRXlWUWtkRzg0WXdGR3g0SnNmMGlmdnFMY1VvaWpQenIyeEJLcGpQZ25t?=
 =?utf-8?B?T2F0VjF1OGN4dldOT2xkLy90TWdsTVp2Mk5rb2l1Zno3MmRIVGcvM1FpMUpR?=
 =?utf-8?B?RHE3eTIya29acS9xUFBNaHpuZzROcjEvUGJGQm5hU2s5eXhodkk1OHB3UjI3?=
 =?utf-8?B?M2I4c2JuSFdJc2dpd0RIQmF4YUIwSmxOSkFsS1d4UTdyU2tnckdFQjJTTXgv?=
 =?utf-8?B?TDB0WWVvUm0yUks1bzVjVjl6RExHaWI0NG4rMWg0eXpvcGVzMjdVMDJNT2sy?=
 =?utf-8?B?OFR6UkpUeCtuMStVOG5rcUFaTGxIVlV3cUtsZmN5VWtkWXhUcDA5Wi9BV3Bj?=
 =?utf-8?B?aGQvZU1wS2llMDNBYmhqTUVPbkRqdThXRmx4ZkxxTlhpMVBENVFzYlNrMFR0?=
 =?utf-8?B?a3paZE1xUjVvUG1lVTdpZFZtenZyZzRtTGg2N2VZdy8rZVVuZ3NPTHIvYitV?=
 =?utf-8?B?Q2tWU0NuenJBY1EvK1JPa2VYOTkveWVzR2dZeGl1ZTMyUCs1SktScGxVRFpO?=
 =?utf-8?B?YlNDM1NsQTlvY1JSeExlb1B6ZUNiWWNPN28xVDNEQXlQN0ZJSGxrYUxTaGI2?=
 =?utf-8?B?SDQzQnlESzVuZ0JOVVd1UVArWDkzeC8vdmZERjhGSVJ4TGlXbUFGd2l6dWVI?=
 =?utf-8?B?cWNTQVJ5YW8yZC9RdkRLMFYyR01OTDZuYnhJc1BtTlpoUUZ2QUx4QXExOGlS?=
 =?utf-8?B?MFUxZXJIeGFnRjZsN2FxQ3VKczN6TElBS3BjU1VmTjA3L1B6b2NBKy9ZL09a?=
 =?utf-8?B?bFppS2lNU0I4NnRxK1ZuYmxaMXdFSmp1blFrWnB0UEtMcitFYVZOU3VwZU5i?=
 =?utf-8?B?K2NiQVNBUm9JU2ZaQlpxemZMMVZjWG1RUitCTlUxei9NKzErRmlQTkVBZEg3?=
 =?utf-8?B?UUV2a3FoNk84c2hlVURqUHFieEtsYVpuc2RrOXVYb0lrMGd5TXF2TE1rdDhn?=
 =?utf-8?B?S3ROTmhHeE1YN0xvYk0xKytoOFpaaFhCVndJODlEZ2RsZldJdmJteHdzd2lP?=
 =?utf-8?Q?PvV+6WkF3nPB/HHKCgGi/v6ngTIWGEnTAC5YM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGw3VzMyZDdEYUVScUNnT24vdkREdUFWVEJHaGcxajlEeHkxYkt1UGI5UlV4?=
 =?utf-8?B?TXpTWXUzV1h0MWhDWWU3OTlkSzBMbWh5d1dEVGN5NGZodFEySEFTTDhSODZr?=
 =?utf-8?B?cFBSU0dKWlFzc2RpOUFrT3hKNHk2NElnU1NvZ2lGR1Q0RUFGY0tFdXhnTW1S?=
 =?utf-8?B?SERWYURMNGJQVVgrclhoZUpLNHZyTGd4UXhhVEZHcnNnbi9XZkJsSUQxZVhn?=
 =?utf-8?B?NkRrZDhCRTk5ck9FWVJ2ZGhBNUdwQ3JCcEFqVGEyL0tvK0gvOUZjVGo2cnFv?=
 =?utf-8?B?Y0d1V055T2svdk1qbDRTWGJtRmdFdklhZ0c0TGFEOFZ2dlhsQnAxNGIzSFJq?=
 =?utf-8?B?R3hHMzI0WnVTeUNGV0hzcGhVZ3JabFlvMFNMc1JscTM0RHNBdENKMlNuek5s?=
 =?utf-8?B?SjYrOXQrSEg5VHMveHRKK3VnMEJTelpWZEt6cC9UMzd5UTljZVE5RXE1Z0tL?=
 =?utf-8?B?MTBwSVgzanRHUU5ubG5zRmpIOXN2RWpFc3NzVUxUODI2TnJkYVBnb0piTlRn?=
 =?utf-8?B?a25zd2lTUGdxc0tXNCtmZm1hblN0V3ZhZVBoWWhLbGtKcG1kbVJTNENCeUZy?=
 =?utf-8?B?NTNXRzdJSFUvWnYwUzdOUHhremFsOFBjSXNMOU1vdnh3N2FPTXZ0YTlqZWhQ?=
 =?utf-8?B?a1FQUnR6WkNvYWNVcUJqV2liYjFSeWlGR0JuK09lcEdqQzRlZjRmY3dYbFZw?=
 =?utf-8?B?V1NHanZqNDM1alBKZk5GSDFxOUF1L3FESWt5TXJQdVlKUTZYN203L1J4ZHFL?=
 =?utf-8?B?M25sbXJqZnAxWFhIdHhva3lwRkVUUlZOVXE2MlRHelNMei9HMS96ZHRybnJq?=
 =?utf-8?B?aG1FQXlybTUwQ0lVR3FyOE5MViswblpEZ1hyTWNYZ2xqems5Mk5helU4anJD?=
 =?utf-8?B?QlRubDQwaTlrSXh2UUVjOXI3WWdxMmZtUXAyVm9YelJ6ZWhQN2hDZk1wdFAx?=
 =?utf-8?B?RWtiVm5lZGpuR2s4ZWlhOU16SmRyYlpQWUE2ZHVGMVpaN1RsQ0JKVjhpbkpi?=
 =?utf-8?B?STMwb0R1K09qL0ZvSEZCU0s2aGRYUXdjYm9YRFAzcEt2Nm9lbjNoRzNMTTcy?=
 =?utf-8?B?WkNubmlENllZMGxYT3JIaFZlc1Jza1IzUVV5NUdtYjdYYXlXK0V2aUxNT2lK?=
 =?utf-8?B?MmhOTWlJc0JLanR3eklOUTkxZ3hGTVJteWd4V2RyOXNPRVBVQkR2RlpQM3py?=
 =?utf-8?B?MWFRbDJNTWN0OE4zblV0VDdqc2F1SUVJcVZQUUJTWnZ4YVNCc25WWFpXKzdF?=
 =?utf-8?B?VkU0bVRJYUt4Mm1VWVlPRkFJOGZObDByRHAxOXBZVmJxV1lmVCtNT2x1Q0ZN?=
 =?utf-8?B?SG1lcTcrcWYrbkV6OURsVnR5M2RpYXhhSzVIbmRsWEptdGppbEhHNFp2aHVI?=
 =?utf-8?B?VGtIZ3BXekJmaXJkR0dGNk9OMnBFNHA1WUxKVzRVNC9USTUxY1JTYWs4amJj?=
 =?utf-8?B?dzJKUU1EOGM5VFJvWlQ5QkV2WmwwbVF0MTNJM0JRY1RISVhYVzJVRkRlOFZC?=
 =?utf-8?B?MWJ6aUpvYWFzQmhscXRLV0JjTVMzQ2FxeHJJU2JEL1pYclJrUnZCMmhyZlV0?=
 =?utf-8?B?dlBzWC8yRHp6RFlzakF4OWdHTFVVdDNPcTVRdzRsMjZyYkowZlB1eTJOOFFS?=
 =?utf-8?B?dlAwVFNLb0hVV1ZXY29SbmFFN2VmdnZGVG9wajhpWElKb2dacTZmZndxQ1Bl?=
 =?utf-8?B?QWN3N0JzTEY5ZDVZN1oxbzdCWm5SRGw4YVExWEg2UmhaLzU1Wnl2aFVKWE5a?=
 =?utf-8?B?RndxU0ttUXk3eWFHQnRTSUhOS3BJd0NtU3p5VGd2ekx6ZUwyZWNxV2dYbVpz?=
 =?utf-8?B?V3gyY3djVHpWSnl3U3BId1lhcWpHcGF4eHl6MmZNN1o4bHkrR3IvejZOSEpI?=
 =?utf-8?B?QXdnUGFiS3piTG8vMDBIR1FkRmF4RzNIcGhybm5jZjFwSUhiOUxuMU1sS0pV?=
 =?utf-8?B?M1hJeHlvZTJMdyt1dXk5QkRTRldLMHpWOWVHTWJ2Z2JSdTVRRE5mVWtNbXdk?=
 =?utf-8?B?TTZYWkpNOVNuTlZSTmdEZE1HMStHWjNBT3UvTUl0NVlOWmdqWlIzdkhsZ21u?=
 =?utf-8?B?TmhDTC9USUphM3ZNUm55N0hsMGtWRCtsOGd6Mms1RmJQcDFQeGdQUVZOY0dI?=
 =?utf-8?Q?67+BAblm3LSRmRQkh3jAAzEDB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e94c28-5a4f-4046-198f-08dd82f5a6a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:02:53.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUTZisO1q6GIWp1RrtGzBWgjc+VWLVvOATHP8sowBLKm6seL94S8T78F+9vJdbTqZGsQbtIXCDuy9j+iUiuHiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 06:03:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18593

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=4&day=24&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/04/cip.2025-04-17-13.01.log.html

* Action items
  - write docs for release scripts [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Apr 23 09:15:22 AM UTC 2025
  limit date: Fri May 23 09:15:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Apr 23 11:10:00 AM UTC 2025
  limit date: Sun Jun 22 11:10:00 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Apr  7 12:49:49 PM UTC 2025
  limit date: Wed May  7 12:49:49 PM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Mar 19 01:02:44 PM UTC 2025
  limit date: Sun May 18 01:02:44 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Apr 18 04:57:16 AM UTC 2025
  limit date: Sun May 18 04:57:16 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 17 09:54:04 PM UTC 2025
  limit date: Fri May 16 09:54:04 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Apr 18 12:23:18 AM UTC 2025
  limit date: Sat May  3 12:23:18 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Apr  3 11:32:00 AM UTC 2025
  limit date: Sat May  3 11:32:00 AM UTC 2025
  Status: On track

