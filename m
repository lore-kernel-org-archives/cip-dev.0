Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F9C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 07:24:39 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.60])
 by mx.groups.io with SMTP id smtpd.web10.9953.1721287474716668180
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 00:24:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fwOjXm33;
 spf=pass (domain: siemens.com, ip: 40.107.20.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKDEymLYCFuAVw1DWIfkVzdTLarlCN1Eh/ZaZGlQcFVvHWPl9q/TfPiLadplhUE2gQ5BU5EVj9QjHO3wlvOG9SFoZAU2+O10b9by5njPEPv9pzvv4AW1kX7UOiM5ikUQitUUySwrn9ujM4ak6AwYoK6ostSLRD6g0Xg0NvZbGG5M/qiX5xU71P76HPcRM7ToKeBYUxFxcsUlXAldFpOtL0kfd7iGcyD9uN0qcZ2m18tmHkcTcZdgL1V4pXYRZ4qhW+cRg0PgecTjXL5VH7Lh9fjVbF9vCP+vLXbLkYPeFPs7WAzPYFStimaSci1GeWM5f4W04QCdRBQYgLDUccqTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6qR6D0DiciOzEl8sWsnqK4+aR+14jXUXAxGxQA3OIw=;
 b=VVxkJr27dh2qRmAkIVO9TmSpMBDScht/6mmzEDhu2A5IrjtM1xILYT7uvRJ2iswH9d21sYPXDaQzECHkxew6ze9ycV8OLjwE06JWVpGSPcpCnMIdW2rWd44iLWLJ6bLWQgYqTBVjazu1DeF6fXXnufkzL6gh+w/7YdfkK0lGxRZU/fotH7mX/Rns9sgeuA4yiuczyMkylajcjJSnJzEeGBHbl1+2FhOjClXzdylsP2TyTvIwPGtfFVYEL9FkE/rC1MfMhsv2d0BFopVD01HhDPKfNQ3aQt70H4veOYbhWfeWunU6SCg8gS6mhQx2I4pm3mgERgEjD4rIKgs7fBq2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6qR6D0DiciOzEl8sWsnqK4+aR+14jXUXAxGxQA3OIw=;
 b=fwOjXm33rNE+ZOK3JHDUF1KfQNisLI7pEaYKY+sKOUteejnRc0ifIOSqz++cvOQpxw8v4fu/ytrB6wNb4S3VKVlmjioVJJ7/rLRCbLEWkWgnmCvuli0/I5BegY+PV1tbvQcKqgnjOJfTzKK5rNPFdRkqeo2kVdvsyNiV1m8+BN3vXC75fc/8z5REWq04N+HLuE4+d3Cph971V39XW0TnfZYTOvmn2nmtNGO3x4c0x0jqExHUQl0gGTfIrEERTjwDGPc+QMfT8R58pdnDwKpGpcCSsF+nD/S56fc7TgRpjfggJEB/j6tDYO81JV+3rrqKZ/kzPmEYYKHgV74iyF/mqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 07:24:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:24:30 +0000
Message-ID: <cf7be37a-273c-4bfe-8bef-638fad42cdae@siemens.com>
Date: Thu, 18 Jul 2024 09:24:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee8a670-6d9c-49b2-b36f-08dca6faa9e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajI2ZWlQVjNpUmVjVU1BTys3OHcyLzc4SEZaUmxGZmg1dXQ4ci9KSXhVV2hv?=
 =?utf-8?B?M2R1RmMzeFZFSWlxRGMraFBTVkVqMllsTjhxT01Ra0UyOFU5bG1VWkowbmlK?=
 =?utf-8?B?WmZ1cW52YkpvVC8wZnFGbURiYjhYa3BQVXZkWU1zWEFKM0x5WW1pTm84OEVK?=
 =?utf-8?B?bVlVUU5hSG5jR3BUS3FYVEZYQVk4a2tBcThHeVN6Q212K2VVODQzYmlZbEN2?=
 =?utf-8?B?eklyWFRSV3hWZ2JhdEJyZk9aRWZmWE83TmRWREFGQ3FRc1JpcE5MVk9rYzkw?=
 =?utf-8?B?ZlpTUXFsdndIb0tlcUdZdUVyckNQbDZscFpWd1JWdVpvM2dGWTJEdVNJdjRU?=
 =?utf-8?B?bzdvbkQrK0VNbTF5Qk00SFdlbEE1ZnBIZ29NLy9STi9aWE5uR2NPY2RMM3VU?=
 =?utf-8?B?OVpTak1kdHA3anVrVGdtODIxdjc0NmR0NGlGZzVodXc2d1gwM2ZKRndoc0dz?=
 =?utf-8?B?M3ltOHp4OU81NnFYQnc2Sm1GaGVEUitXcHY4OEpZVlU3aHNMODJGSEViUWQx?=
 =?utf-8?B?emM0SVdFd2FCY2VDOVRvKzBNRXhSUDZDYVRDaHlhTk90UTh4aUhmSGpRYUxw?=
 =?utf-8?B?Z1U2WC9sVm1HVTZ4RkR5YWhzWStwdFVKaE9tdUtpWEVmK3I3VmtQQVFjUks4?=
 =?utf-8?B?WTdEYWMzK1p5YXFpbW5qRVpZTG0vbWRpTm1IKzdhbGNUY0lWS3JCVm14c2k4?=
 =?utf-8?B?TmJSK3FhRmlqZllxM0NKRWY0QmhOR0JFZi9tdHBqWjJtcEhSbkpXUUlMNnRE?=
 =?utf-8?B?eis3dEZnUjBzS2ptMlQwOUJ4c00zcGFrYXpBV3hqMjJBZkt2MzNkdWszbDYz?=
 =?utf-8?B?U2RYdDRLcmxuOGpCK1ZXTm5NK1pqUmd3RXdhWm5sdTA5c1M5eUJlZ0NKOVBW?=
 =?utf-8?B?SU41cE5DU2ZkTWdsbmNTR2RpbkJ3dnZCN25GREkwRFFBTEt0ZHpzbENyQUUy?=
 =?utf-8?B?QmlpN1RqZDVvRS9rTVZvNFpJZmtVUWsyYkxIQVVNVkdVQmIvRnNKOGNhZWs2?=
 =?utf-8?B?dHNHTS8xREw2cG0rd25ZcEtBNXo4dzFEaE9ETE1qWVRmcmtURnlHSVBCb0xL?=
 =?utf-8?B?MXVqUTJTOEhra0NZNTl1Y04rUVZrRkM3QXJsallxN2kzcFF0M2tYQ2xPZnFT?=
 =?utf-8?B?cjZOeC9FM1I4NmpWR2JCdmJLWUdWSkN1QXJ1Ump2Z29yRUZFM1lmMlZvLzJB?=
 =?utf-8?B?dEdWSTJ6NVlLSjZiRE1KYTI1dU5sS3liVW43VVNuNVd4b0pCWlIrdFNXZThZ?=
 =?utf-8?B?aWEvTTNYQm5yUDVlVkl2S0xaWGhwczY5MzZteFRPb0NLQnplSHZ4Vzd2STJT?=
 =?utf-8?B?c2V3dGpjY1B0VjJrc2lYZTRDV1Jxa3hoOWVqSENoNzBGYVVadzRoU25DMXMw?=
 =?utf-8?B?MFZMNWNDWkZVZmRrNXFDeWV3bEVHU1p4dEUzUnVKVWJEd0dWWkx4YjRKOTVl?=
 =?utf-8?B?STRTUUh6cjh3UWtSK2JsT1hzalZTWU0zWVJnMktseE5FVnc5a0pEZ3JUUFhC?=
 =?utf-8?B?L05wRzJHMjlvYjZpM2xKcmZGTncvVG5JOGk3VlRpUWIzRHZUeWkvbUNvNVFl?=
 =?utf-8?B?NWszNkgwOGoxT0lvM2ZmSzFpN09Jb2xZZHUxMklBUndhc1QyTGlxcktrZFZL?=
 =?utf-8?B?VHU5QUhFVmZZeWFGcW5zTmZ1MmtKbXIyK21rRWNsUnh4WjEvN0hEdXcvYXhJ?=
 =?utf-8?B?N25BM1BnNU4xT05ha2d5ZXdiSGxMSEs2WDJmLzBzeHhRWkRSZUw2V05QekVW?=
 =?utf-8?Q?zA7zRDVarf9T91nGXs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTFTYWtEOVRLeGI2ZC90MU1McktVeTZSUnlrOC9yT3psYVQyQ3BCMEQwRzBW?=
 =?utf-8?B?SkRNT0VwNmJVRllMK01xYTRJNitQNjZqY1lRdTRtaVdHR2EvQllwWXFsQUFp?=
 =?utf-8?B?SWhOTStlcE9YQkpTU3YzVFhxS2NvK3R6ZU9WTlQ0SzNqYXpUUVd0b0NHYU5u?=
 =?utf-8?B?Wm4vcVAzdTNvSzRDeTIvbitkRHhQZjdlczRQVk5KUGl1VG11U0dJN3hzWVpk?=
 =?utf-8?B?RjVwdDY0R0NROEZ4VFA0N2dNS1ZTYVZMbklDbFBvSk5mSnd5TkVkOVYxeDRj?=
 =?utf-8?B?QVdSN2ZaM2pvKzVjdGRXUjgvTTN1VXFJZmJYMmZTR0tTWnQyL0l4NkFYdjNU?=
 =?utf-8?B?ejNMeWlqaG9tMTJidW1NbHJOUTVxYnJFNFhjQktlWC9Nd2JIcUtDOGJtSWFQ?=
 =?utf-8?B?dTlEcTQ5ZzZwQ3JjK0hvMEhvQUVjaWdCN1NMRTN3QmR0YTlMaVZoYU01Z0kz?=
 =?utf-8?B?cTh0ViswSmcvNHc0TytRTE1zaG9IUHp3K1N0M1NENDErREliQ3doNFpQR2xj?=
 =?utf-8?B?ZVd5Q0EzWW5zbDZyMEpuRVljNGQyT1RJemNPQzdBN3JQVXRwTGo2RTFPRW1Z?=
 =?utf-8?B?ZGpCRXRhVEF0OEV6dmptVWZZbTB4WUJXamlhWlZJOUNoS3F3T2ZFYUROSU81?=
 =?utf-8?B?N3RLTDgwZUlOMnA2aURMeFRCN1UrSWlFYVd0T0RNTkY0ZzVjOXdYYTkranV4?=
 =?utf-8?B?b1kzWFlZTTlUNzJuYVgvY3hjbWZVK3BTYnZuRmpXMnNjY1p6Ny94WXdZTWZR?=
 =?utf-8?B?YVpCUDNpSlkrQjhYV1ZNT0dzeGNUNlFUSnp2T3BmclkyQjhyc0hQVkcrTmlP?=
 =?utf-8?B?L01ORTEyUFYwTTlML0srOUMrNGUyWDZmUDZqcTlad0hhMzdaSXFLVms0RCtS?=
 =?utf-8?B?VW1Nc3o1Z2hTZE1XQUN2bXBxYWRUVEtpS1h4RzVNRytiRVp5enVMUTh4cFgz?=
 =?utf-8?B?SEpLRUJSQzJ4TEFtQm00WmVNVHV5VUQ4TlZzNEQ5YnFPV1dVKzBHWGVXUzZi?=
 =?utf-8?B?L0w3ZkN1VHRSM2lvQjJaWWFRN3NFWTlzMnNqakdNQkszakJ2dVZ4Z21RWkQz?=
 =?utf-8?B?VCthcWhkSFcwbjZtd3BwYU5VbFdMSDVVZkVZTng1d3lHVEJUSHJWSW1RSFJa?=
 =?utf-8?B?eWIra2toT2F4R25IRFNseHFYL0R4ZDhNeEZLRlAxemRQOXhkQTlxZnlyZTQ5?=
 =?utf-8?B?WkhVaXpXRmV5U1pSL0pWVUpBVFNla0ZBVzVsMkNJMUNIV0xuSS9ENHdaakJE?=
 =?utf-8?B?NWJ4T2JqcXNnUHpWeGNyYkdDRjN1amRNSFRTaXoxREg3NC85N25mNmhaQWFu?=
 =?utf-8?B?VkdTYnJSRy9IaHYvL0NFRTJ4KzJRZnQ3dnc1d1dsdVZ4MTd3cDVsUFM3Z29q?=
 =?utf-8?B?TXpIL3laWVJmZUloMmNrZzJWYXR2K3dHUXpERVp5cCt6bzFUVG55eXlNWktH?=
 =?utf-8?B?REZEWERObzJnTG9XT3lxSWJGWHdwM2ViaGJQWHFja0pNWVByV3NuRnVudEVL?=
 =?utf-8?B?UVJobG1wVHp6cG1lTUticysycDRXVll4UWxLRTBUS05HWnEzRFNNeThYaEwv?=
 =?utf-8?B?UlNUbHlHVFQvclp5ZkFDRUxDaFFQdjc5WFlFcHBYeStTZG9nMW1iS3dOOUxi?=
 =?utf-8?B?alJTNmtza1ZHUU9EVGVSWE0wUGp1RUxLTWlvdmpYNGxPSU5Xd3VCRWw3bmc3?=
 =?utf-8?B?UUhGYUQzSHlVY01wSnFmWGJvTjZEbmNyTm9neitid1NEb1RMZThTRlpxcmRX?=
 =?utf-8?B?S0hLT0lhaGdMNVJEYVAwMEk4RUpvVStTeTdzcUpqcjdvUmFrTWZNc2U2aGFr?=
 =?utf-8?B?YTl0VWUvVmt5RVQ2OHhtQ2V6Rk5TR2JHL1N5bjFZWDZFSWg3dndJVFB4ZWJm?=
 =?utf-8?B?QVh3N0dJelNsTFR6VFp4OU1VOVhFUUcyVmI3UkRIVWJ1bTRPQWxnYmtseGVh?=
 =?utf-8?B?MVJhaTUrQWhGQkJKUkY3VzJKQ1NNWXJ6aFdLUGo2d250aTZwZFc5SDVHZFdq?=
 =?utf-8?B?RUp0ZEtRajRlaFR2TWhsL1h4NlZXcDVLZmxZV0ZJZXRtbHpqYlJ3d1ovVlND?=
 =?utf-8?B?OFZHTm5oR2h3cnc5bzBTQmxFS09vbXN1UWVlQmZwLzJyVFJRU3orY2lCUmtU?=
 =?utf-8?B?Q0RZaHNxM2NLVGNCbmpkYWVUdGMxSDgySkV6ckJMclVqYUpUOWZabnp6bmp6?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee8a670-6d9c-49b2-b36f-08dca6faa9e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 07:24:30.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPq427AWLlcfMezhPhE3+RVPDKV93G7i6RBiYwjVmAauc4KrVl/6dvv43sHIiAuhA176+dScL7fREhunf3srpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 07:24:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16574

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=7&day=18&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/07/cip.2024-07-11-13.04.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - alternates for next two meetings

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul  8 09:35:34 AM UTC 2024
  limit date: Wed Aug  7 09:35:34 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
  limit date: Fri Aug  9 07:05:27 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
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

