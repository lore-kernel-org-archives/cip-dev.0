Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A2EEB563
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 08:29:01 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.63])
 by mx.groups.io with SMTP id smtpd.web11.43364.1726129740249827669
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 01:29:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JENrB3Gh;
 spf=pass (domain: siemens.com, ip: 40.107.20.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3PtxsqYWFB1q0FMnUJ9t0N8IPCcwgxEmSzUtgcRY7n1c0m3jx/YCHWt5wIeI5hfOYUyTvEkbOGyrl26A5hZaHMIpolZrH9o6YHAX8pV1wCawwM+cB0pJ6A7sIKqbBTvtfLieh9milRcdKidkraSKL1NBRVU7bgyETLWuT8KRPUh/9f/N0dkuA1D/tBFm4KvhZpASB2AD6fgB7qo21t37wFUVSzwrjprfhOsVa74EdK25pkrJ+8pUHyoKbBrHKXitVdmwg++gjDXCJ7sXAU9/3oAU/S+NF4EO24Pmvyje72WbGsK7gh44tZIB805/8+UN4U+1zQqZAx4V/dtLlnREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdqmPeKkRSlZ3kzR7frcQU13G/ZInF6xJh325UP2sm8=;
 b=EZNXuE/wedEg91CmT/FgHOWqm4p1SS+aG65v/US3AA/75/H9VeGzWuAs1t500uOMTjywxMYTjF+dA7kmyDYwooHHahVJvRC/x8gfSWdG/IuYFKFj5wF9/Fae+Z83J96E1DAzdn1hHtRh9Po0CcPsFZEI69oIAhBK7ue87CFFR3Q+99EBSw8V45E3TRZEwnCh1qHumNypmiSaAv0lzk9cGT7uuwI1IhmKdq/hnAkpN9oYDa8PkEz0fSGkTivztHs/Xg0d21oALjArYeFJWEcBw9y9Ky7gn8Bf4hfKjscme29p4qRfFcivUnt9E2hBXRszqvlNkS7F2Lvhh8q1U6914g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdqmPeKkRSlZ3kzR7frcQU13G/ZInF6xJh325UP2sm8=;
 b=JENrB3GhUjpGA4B/xQ8RHkJfn8QrikswiifuMfpIeiN1ZZ2ufKJAc70OMaEAgijaj8yMK6xLiP+kx5LZ1jG8pW36bYIdTzggMGndyiNfhP8DOQ5oQ1wPpBVP5Shgj7rfwmQaJm/I0aM/ohXliOUgPR1lNAJIQyGa/nfXwKDGRlCaiObzin0xI9S7gXHpK9CPgBgpqAJJsUqTjL3DHiaZIviyzM+0OEbytRtE0B1K8C6YT49qO/wsEjpAA5Vzfxp7Ib53jIPxtl9YDjVW/wJiEy3He+dV7dmfNMHzfcOwViKDCkv+nO/anvPgzSpOGT9Hjh62BSWJ9EsidplYRDmTvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:563::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 08:28:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 08:28:57 +0000
Message-ID: <23531056-b2d7-4b83-9df6-797d7ac6b814@siemens.com>
Date: Thu, 12 Sep 2024 10:28:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 215af5fa-ed9f-4778-c93a-08dcd304f1d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K21yS3VkSGRuTU41ZzVUOVlEOFoxMmx3OVVhRTRrVXVURzArTTJNVDBLUnRU?=
 =?utf-8?B?QlBzeEtIdVh5Zmg1OGQ4MkJlQURCV0hHOTV6VnFRZkJ1SFFOclRmQm83aXlx?=
 =?utf-8?B?U2MzaU91WDljRkpOOHM1Vis1TmUzZWVocDhnK3h1eEFFcWhFSW55WktNV040?=
 =?utf-8?B?K1loQjVDS0V6eWxVRVo0WGphSmJFbjFndjBsZjQyenh4ZGNzdnVzbGhLQ0dV?=
 =?utf-8?B?U1E0S3I4bFVYWEdndHp4dW5sNmlTMDZ1RkQ3cEdoejkvRGg3R2M0eGMxQlky?=
 =?utf-8?B?MG11QUF1VEhrU3ZZZzZyUVpWQjFQbzNSNmtQbGRsZ3Y5Ynh3aC9VTXhVMHc0?=
 =?utf-8?B?Z05vYytuQWsrT3dkM0Y2UWxvQWt6ZGg4TUpOOWhOb2ZWR2g5SitjVENRMGU5?=
 =?utf-8?B?anBNWHc1WWhoQUxRYnYyUVRDN3U5Ym0rM2RsTHJ1Wk5adGFRSkRxZG84NTVy?=
 =?utf-8?B?anA2b2p1cDZKU0ZzTEJsTDM3QzhBSTBHKy9hc2JQWlBlTFhaWU1ZTFdjNXEr?=
 =?utf-8?B?cVdlRWFyeElLVTJORE9MSlgvTmVqa0FQbnhOZGUxN0VZU05NYmlPQjZ1M2U0?=
 =?utf-8?B?OEhQOHgzcU5xNDZzTXA0eVduZzg2OHFtSGJCUmpnam5Id3FTZzVkekp6SDVK?=
 =?utf-8?B?TEQ0bXRRUVFETWJ3UC9kdkwxcW9xNGx1dm9Kb1QwNGF4dGwrdE9leTViWExy?=
 =?utf-8?B?d3R2cjE4Y0ZvczRBYmQrOURlK0tnL3hGQ2dRV25odVlseHN0WUh1ODI4R2t6?=
 =?utf-8?B?K2ZrU3lPaW5ZUUhTa2N0VkJ4Skp0YXB4cWZRNml1OGNmS2l2eklSM05zNUhI?=
 =?utf-8?B?emU4eEpaaGdRMDZFQnBzaDhkSmlGa2tBL3gycnZPWHFycWh4Rjh1KzZka2wz?=
 =?utf-8?B?K1h0REF3eitlbWFITGM5NlY2dWxqQ0Q1ZTlGZmZHbHpqQURuSWJja3VsbWJD?=
 =?utf-8?B?QjVyY3I4UXB5UGM0aGF3K3U1U1ZVdUUzK3lmbEhZbU81NGtJcURlYjcxMHhV?=
 =?utf-8?B?cklPdWttdTlxbEhoZ21sZ2Rnc1d5TURRMzZWN3FUYVNWNVphdkxHWWVTbVN4?=
 =?utf-8?B?aWhiZFFid1JSR3l0cXptYlVqSG9CWFhCbWk3aHQwNnNvNFA4cTBLMzBlNFRH?=
 =?utf-8?B?cTJ0Nit4WUE5a2JPOGorOGxNTnF4aW5rRFMwOUhmWlBrYm1yTGNQczdHaTdL?=
 =?utf-8?B?YWcyVGg2RnJ2dnFRWUtiVkJ1VnBTOFRlUnkzUU9ES0NVa28waVowZEY3S1Zq?=
 =?utf-8?B?M3QxS1V6R2tHZ3NhcTJrUzB3b2ZkdVhJMGxqcmZQVVFjWnBrcEFtYnlLb2da?=
 =?utf-8?B?VmdRRmtucE82VkxxVUpMY1ZpdHk4THQ2RHZLOGFhbGhLQjZSNjRHM2VST1h4?=
 =?utf-8?B?KzlubUpxZzExbVFxaEFrUytoY3I1WlJOU242c0pLRHhIdmI3WllOZXBRTkc3?=
 =?utf-8?B?SEJDVjFUWnhKazRxR1ByQmxza0VjUEpPNGw2RjVsK0oxemR2ZnYzRWZpYmYz?=
 =?utf-8?B?c2ZEY3RLeUp3NGRqSmtIUWhCbXJzdEVIeGJaRFI4VW9oRm1Xd05jb250dXM1?=
 =?utf-8?B?YUNscXNLVHpTSjJIUjg5bnFta1NhZ1B6MWNRdEpSbWtFUmRZaUNrdFA0ekN2?=
 =?utf-8?B?UEZQekd4TGIvZ1gwa0NxZU9samVhaGhkbms0eEw2emxFdUFBN25nQVpmTDF6?=
 =?utf-8?B?amwrbG9yUHVMWlJoeFl4YU1IZUNuMlRid21obkxkV1NEeWt3ZEZwNHp2T0E3?=
 =?utf-8?Q?WnZBrAXOQpf3gco7oU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V29WaDNncWNobTV1R1FHS1NaUjIxVjNEblRjdXA3L3g3a201Y3lmSWhKY1Za?=
 =?utf-8?B?Yldpb2kwUmh6L21vTnNEOHdzMmR6STJUUWIzNnI0cWtoemk2T1hzK3BPTDdl?=
 =?utf-8?B?TE5jT3c1dkxjWnhZa0NQUjY2NmdJVzJYNVN0dGszZHVkcmxVQ3FYNUYrRlFz?=
 =?utf-8?B?T1FGYTBTWUpxUHJQaFo1am9ZbGpyR3V5Ry9rNDV2SXpGeUdVdTdzT082eVpo?=
 =?utf-8?B?akYveDd4MXZaNmxGejRKYWtuMG1jeEtOdjkwSmI0RGVHaXJSNXZyanpHeCtp?=
 =?utf-8?B?U1ZLZVRLTWlacU9GNHpSV2pxd3c1eTZLQ0FuWnNnQjl3TlFyUG1zdWxiTkhT?=
 =?utf-8?B?NEI5ajQxVGFzSkI1RWJBOGF5TFViVDhCbFNkN3gxUkhxL3MzTWtudkU5RGEy?=
 =?utf-8?B?Q3JmTVV0amw3VDMvTTBibjh3QjIvc2hoRXBEclBqZjl3Sm15UFVrYVREUzE2?=
 =?utf-8?B?M0hwQjhwOGdIVmVvc0piMHp0MUpNVmloNWNXUTVlVFA2YWxmZkI2UmZIQzQ4?=
 =?utf-8?B?TTRGZTgyV1hUS0U3MyszMUhtNUZzOTdsaWZKU2VSbGtrOU5xOE9EWE5waGZQ?=
 =?utf-8?B?Ymx1VVlQZVRveWlCc0NMdHRpVDJKWHJZazZydFlGWnJvaVRCc3UzNVVqZ0R4?=
 =?utf-8?B?UFdoamd3NmtqL0pSS25ScXhiektBREVzcS8xQUxZNnJId3Z0ZnA2cFF1c09C?=
 =?utf-8?B?bEkrYktDNm9zSnI0d0V4NTloRC9BQ2NrazFHZUd2WE1WSnFLaVplaGNkM2o5?=
 =?utf-8?B?bkNjMVV0QU5nUkJzK016U2ZTelhjRVp0VTdVV1ZmZlVvb1VYaE9WTmN3cHh2?=
 =?utf-8?B?VmdJVGRmeXdNVWovRkRGbnFBK3EwYnhvRVVtQ3RVaWVLTzZCVzArUTI0SkFi?=
 =?utf-8?B?U1VNMVUwYkJ5MHc0TG5ZMk9LOVM0RmYvR3o0V2ZIdVBwcXhrdjc0a21aYmlj?=
 =?utf-8?B?cXN0eFFtMEZWY0YzL3Y5VkhrNTc0NEFnSGpOalM2NUcrYVpoVHBGOHVTSEdt?=
 =?utf-8?B?QXZMRW83a0hmeXhjUm9lWnZKSnZtS0VKOGJ1NWpYZFNNSUlaZWVpT3pBeGx2?=
 =?utf-8?B?VEh0elk1amlvbkJWVDREL002MWNMRnp1UG5hMStsbjZNOTgzMVVTVFJEbDBU?=
 =?utf-8?B?RTlRQlEvNGNyZ0o1aUh0TFF6VExQdUVTbDh5RWx0ejdNVW1VNFB5Q0hZTlZp?=
 =?utf-8?B?ZkJabitobHVrcEJiRjNrRHM1ZnVWbGFlZzNNRUVURzJOeTNuZEVkelc5UjU4?=
 =?utf-8?B?aUJUZmhXV3hkak1RcUsycVQxbFE5MlFra2xXMTBGN0hKYVFRUHJETkErdm5C?=
 =?utf-8?B?NkNHVGdnQ0p6NUtJc0IvQnVDOUdXRVlFTDdaOGJTSTMzZUswVnAxUXFEMGRL?=
 =?utf-8?B?Qk5BS01JSENNSm5CdzNMYm9WQ3VTQ253UlBhR1BOQ2F3Slh2Z2N4Vndvb2No?=
 =?utf-8?B?MUR3MTVzZzBLUGR6Ty9ZWTAxbTltWGNyUkRGMWpIcUgzcUhWMEV4Z2s2enFW?=
 =?utf-8?B?Vk9JQllFeGRpOXY0dzBidzRxMjZKTkV4eGovQWYzYVNSOFFzbk5LT3pLNFZs?=
 =?utf-8?B?VVRWSUN0UFlaLzJOZUo4NFkwSDh0MlJoRURiM2FJUzdBbFViVmNBT2wyeFRl?=
 =?utf-8?B?RGVqNkRDLzdrMFMzWnV1SFBmZ3V4dTR6RmFkUnphdDBjeE45REgwOFBXL0R5?=
 =?utf-8?B?TDRKWCtSVkZ5Rmp4NnhwYlpMQkM1S29YcXNkck9SdFhKSG5tcEdPMko5SG9k?=
 =?utf-8?B?SURzSkJuUlM5MG9ZWkoxR0xSQ2szT1plczhpWmt3SHpncEFjTE15RTJ0eXkz?=
 =?utf-8?B?NTVPL2ovV0F5UDJFSitDVXJoNkJpSEVLWk0wK0VtLzBuRG9COCtnODNLZi9J?=
 =?utf-8?B?cVhCeUgwbWRCY3ZwT1VlbnFtaFZ5UzFDNUpWRTVvZUNMRHNndVUrYkl0bUVF?=
 =?utf-8?B?Tzh3ZnJLMHllVjhXR3pzckE4VVZEclo1MWNnZGQ2UEZ5SlhYRTBCbUlMYU90?=
 =?utf-8?B?NUMzbXFQeFZndjVFaHNuOUE5V24rdVBLVlUya0Z2TGR2bkQ5S3cvRGE1elhO?=
 =?utf-8?B?Tm13dERiVXVtTFYyejAvM3d3eTlMSzJURWpNWmpzaHlnM3g4dStJeXNjVXoy?=
 =?utf-8?B?UWNGaWpiUFFtT0MreGQ3RDJ2MUFzcXRkRkJKVVhOdUVqZ1BYS2g1dGxtdW9i?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215af5fa-ed9f-4778-c93a-08dcd304f1d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:28:57.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VllQFGrif3WO0TLFLI+uD6qs8xl1cyQewHLAJQceUuz6yVqN5UAZaDj+vOo0+xhXOT22NSxCrb2586knPM1agQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 08:29:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16888

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=9&day=12&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/09/cip.2024-09-05-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep 12 08:28:23 AM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Sep  6 01:15:20 PM UTC 2024
  limit date: Sun Oct  6 01:15:20 PM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 19 09:14:08 AM UTC 2024
  limit date: Wed Sep 18 09:14:08 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Sep  6 10:08:05 PM UTC 2024
  limit date: Sun Oct  6 10:08:05 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Sep  6 10:03:04 PM UTC 2024
  limit date: Sat Sep 21 10:03:04 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sat Sep  7 01:00:42 PM UTC 2024
  limit date: Mon Oct  7 01:00:42 PM UTC 2024
  Status: On track

