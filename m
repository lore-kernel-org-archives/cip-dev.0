Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4040C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 10:16:19 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.64])
 by mx.groups.io with SMTP id smtpd.web11.44158.1718878575433382794
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 03:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gsAWMEsJ;
 spf=pass (domain: siemens.com, ip: 40.107.21.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDJI/mK3Lu/FehsmHXR9rQ5JFhK/81tyqPLf3IEfzQ+UQ7jT2fFeVkuS0zJPgXRaRYajWfT8T7BRUe0Hdc/zErianNfJxQmYK+yvcQu99DMjAQ1ekscRvH82DdlITyPYsTQiGg+a7UJUZxNWm0yiiAjiYwG4AuUW6kfaeOfHVzoE86b1OUMijwV9sMB1KUrhIx+P1mhJqAw3lKq22vtRjatuB5aQzI6UmMNTe2BdEvzlKoh48lzfS1C2PIO1i4TEcr6/XwQJywxZOY+UkbYmccREf84o5JWIXgYuXhjHym+gB0jlekQCQjQ2v0U6/XSq7Yf1EFw+oxb6e410OBkpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZJ82YqEi1GnoZ4PoIThds2qyaym2vG50KBIFiPn4+E=;
 b=aM1OQnMGA0uqooUIHqv7Rsmze1N7ZfoAKy5SUDADDVlTViNfoAyD+R3qGBYAOb5hb+rgEN9VR0smNi7bVmnfCWzXK+xlOQyfe8U2vtU9FQFLhPwVsfvpSpgmwHNy+Ok9yzs9p3+DvH3Jyp/rCgP9BBnhrT50SBex8PoEX4G/HrjpZtRlpc0kvuHmnrRLs0ACM/7NzTyC/ZSjIQUQbptZIxuV+NK39CFynQNtX+QjBDqXPQwmhz50CMWAdsUqu6SxMc2e1M+JNKmi4fMUvuIalPfmh6Z/b7aDM5DrlBVg1TcvrfDkOqSMJYoBHIUKpu4B/TQxVqMdiqpNlU9RAsLnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZJ82YqEi1GnoZ4PoIThds2qyaym2vG50KBIFiPn4+E=;
 b=gsAWMEsJF5VnVOyyOW9K5gj3QwTaDy5P08pnL1WeamwfEgmEra7Z7aE3z8WBoUhe/dkPsgOHpGpOehPr8Pci4xcXEh5RVyJa2R+tuxCSKQorQhdoHg19Ok09LDitvD7yjzMJpxIR7IZ2J/MeG11q3zdDGpdx53cauQp4FYuIYaesUfoBOi/2iyP+57OgHXRRHbEvr3u8OsdhVkwoMVOiZzETlk3+8Gyx0URSAZ3EEh7dGh1gZk+plzTS9nJElC0h4bBMP7D/K96XOCWWhyoue3U1nqvA1egVrfV2vj6PjtVGvssbV+5slDzu/IBCcFXTJR1tckrMDnMjPab6y5gxpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 10:16:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 10:16:12 +0000
Message-ID: <44b51bcf-83f1-4cad-8aa9-cc94f439c5ba@siemens.com>
Date: Thu, 20 Jun 2024 12:16:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:610:33::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 904b4c1f-9436-4ee6-913b-08dc91120277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MkxPNUtxV1FyZG9Va0U3eUZrYVNmZGFQSWcyTEl2eklGM05GZ3hXTGxYYWVX?=
 =?utf-8?B?MHFWa1pZcVBVZlVzZEFxeGplekhLdk9ZeHpvY3BRbGNqbDluMUY5MlVndFE2?=
 =?utf-8?B?eXhZOGswckF1QkhTd0d3cUFkL0VKdVFwSVBzdkVJZy9zUGNxNjZtbm8yckNa?=
 =?utf-8?B?SkJNbDdZU3E2M1JtUFpvWDFWVFVMK2wrUjMvSVBTeCtMN0FRSHdNVlBFVGJw?=
 =?utf-8?B?Y3dvbU5pNVdScGlxTzZpNm5xcEtrYWdqRXk2dzJPNkRTT0VDOC9PckFWc2wy?=
 =?utf-8?B?SUcxd3dMTWllUis0eThMb20vQ3M1SXhsMXRIdG1XUlBTaU9NQ1VXaWhSL2h1?=
 =?utf-8?B?NlNqNnhNUEFzL0dEVWE3My9JUHpXUkFYd3BoR1UwOXRuTXJkLzQ3VUpqZVZp?=
 =?utf-8?B?bXhoSytSL0c3S3UrMXhETWo3eDRRRGRRdmZ2eFJiYkdCWUpmSEpnMFczL2dR?=
 =?utf-8?B?RkhGKzFneGNZcEJvU3p2Y0pQaDYvVXRxSkN3b2ExRDlHMXA0blF6REtZd3Ns?=
 =?utf-8?B?c3V6OTNxR3JDUG92dFBSVEM0TUlzWXcwU2d5cFZvenY0NzUyQUZhNkl0UHJE?=
 =?utf-8?B?NHc0MzhkK3dsSkYyUUFKQS9yeGw3Y2lnMlJaS3pPZnoyZk9rd2RQQi9hTUIv?=
 =?utf-8?B?ZC9xNTJYQ0ttZ3ExS0toSVNJNzJQVkx0UVFuTFF6bDZhQ1Nwa0pWOENYa3FJ?=
 =?utf-8?B?R3dMbnVLWE5tUnBieDNCdWRjRi9zblVGbElKN1hGTUtPc1plLzBhcDVPN1dh?=
 =?utf-8?B?M3VTcDFKejBYSEpjOXRIczZOSVJudGM2ajRCWk4ySVNVcnFUYWRoUm9CaDUv?=
 =?utf-8?B?SGVRL1krV25nZ0NCOWU1NXoyVmhZbFlxRDJYa0NHemdSSERmUVBvaGRFbmhn?=
 =?utf-8?B?SUwrWHg5S2p2dHF5ZGYyeFdYQXQvUHh4ZFowVWVnQmhtTEIxTmtTTkVFRVBX?=
 =?utf-8?B?MHA5VjRkU3FIMlNpaVJsWndQZnRxdWRCbFovYWk0MWd2ekhOajZkUTl1VkZo?=
 =?utf-8?B?NFhFQ24vVE9SUUc4RldHMDhONlUvY0x4WUN5RlB4T3BYemdBRUlISHZ1ZS9P?=
 =?utf-8?B?UzhvT09RY3FwVzRzQk5Fc2RFVUZoNlRWL3RjV2VvRkE4SVNlclBjQi9Cd1d2?=
 =?utf-8?B?YkYvVFpVQzdGR3QzdDhKWXhJOC9WZkRwamdyQ1kvRnBqWFhlalpLdy93dDdD?=
 =?utf-8?B?NUZETzBsVTZPT0EzWjVDQ0d3eUdxOEhLZmVGN3FOaDlLa1hvNGFCNFRGUWJB?=
 =?utf-8?B?am5FeWo1T1JmNmhMK2FtQ2NtWGdHbWRGdDRCZHRLV2xHMlIrNmprYlJoVXBv?=
 =?utf-8?B?T2FLRm5lRnN6N3BiQUZabHNsMUVjTStrRyt3R0RhOHc1QnpCclc2MEJ4V1Va?=
 =?utf-8?B?Tm1rdWE4TUN3R1pWY0hZbHNXUHpabFpjTHJCQzgyVTNtVENlZkFaSVpmZ24w?=
 =?utf-8?B?R2NWb1NFaGdZRUl0cG8vVjdDSGlEZTlXcHc2VFJpYVcvaWtUeDdPdFlpRVdE?=
 =?utf-8?B?MHU1aVo4YzA5K09wQ0pjVnZMalU4M0M3UVFCVGJ6TE5jaFVKckE3eUFDWThT?=
 =?utf-8?B?SGdHcmdwUmpKQWJvTnNDZVp5ZklMcElmbHI4UUVya0V6OTZkNC92RU9DUmU5?=
 =?utf-8?B?MndTbUxkUXROVHRNM3E5ejJ4cDJOUmZuOHFia2hiTnJFSXZiTU5JM29HS2Zt?=
 =?utf-8?Q?GYy1PExsC6kBBND9cwkV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RW15bUp3MVZNUVBucENNY0RoNlhUSWhoMS9iWW1HQkNBVmlUSlpYYWxvR2la?=
 =?utf-8?B?WkxzSGNxdVEyT0JNVWtZb1pxcW5rVXJUVUw5MGdMMVE5NEU4OHBPckh3TnJJ?=
 =?utf-8?B?V1JmYlV5TWZkTW5QYm54T0lpaUd1RUZRU2NmM1UxUmVhZlQ4REVBSjZDSlVS?=
 =?utf-8?B?S3VzNUt5SDBGbytuMzZWZjRyMUp0eDJaNU4zdzF2RWZlaFRuWmFlVWRLZ3hy?=
 =?utf-8?B?RUVSeDA4YVV0N0dIUzJ0V3B5WTE5OUJVZjlzQlZjMFdsVG9leTdqS3EvMnZK?=
 =?utf-8?B?enJvODZLdGxOelhYcHBrRUh3Slo1VFFyUE1uSGt2cTRNZzVOREhYZVU5bDJo?=
 =?utf-8?B?N2YwejhzQmlSZGR0VmdoTzBtZTl1N1g1Y09hSloxQzhDcWc0dFZ4aUtjcDRN?=
 =?utf-8?B?RU5yV05RaFhGTGo2Vkc4YnlGQ2ZVSU1sVjNSUjc5VHpoRFYxRmNPM25TM0FF?=
 =?utf-8?B?dk1HaVF0TkZwc2Q1cnJ0UGpmdVJENkZTTTF0RWs5cmVPeS9MTUhON3pxd1Jy?=
 =?utf-8?B?cGpuYTU5WUdOM2ZtaThnMTkrdUdBR2xMU0RRdVpQVU02aitiUmZoVStuYSsw?=
 =?utf-8?B?U21WSGx4OXZIV2toQjdpTXpWYUlFejlTNUxRaVFkaU5yTnhBK0lsNWpqaHNH?=
 =?utf-8?B?RXRoZ3dNcEZvZHc0T1VnWlpyNVhvdDNrQkRRVC9UdHU3YTJQSXdvS1BLMGt1?=
 =?utf-8?B?RVNtTk45SG9wMk80WDhZeGZ5OGJuT2ZHWFhUMldRSG52eWFJQmxJZG5KRW9w?=
 =?utf-8?B?Y1ZaREpqMUdYZ25vMWJUZFB3c2s1VHlqSXJOamo5cHBmT1kzSDVvZ3V6QVdN?=
 =?utf-8?B?UXZDczQ1aHh1dDEvQTNleExtUmh4M1BWTGQ4cHpwZmgzVFVVM3c4RVZnN1l3?=
 =?utf-8?B?UExwd2krc3FxSmtQcnh5cDFHMlp6enNDcW1yTHRFSkJ5NU9WOEx4OS9EMXlT?=
 =?utf-8?B?eVkzb0d5NkRWT1J3UnpzSHF5VjRUOUlETUhYclBxVFE0RG9BWjVxTkhtQVdX?=
 =?utf-8?B?WHlSemkxaDRkMithLzdldERJa0l1SlJjTHJ5YkZwU3RwR2tVZzBLK0hqTk9p?=
 =?utf-8?B?RTB5NWRIQ3JLeHptTENmaXl1OFY3V01teGp0dHNZWWN2MUduSGd6ekllYUJV?=
 =?utf-8?B?Mm5HeFhnWnJjNGVGdDFVZERsZTU3aXNka1FJNnFMMXU5QXQ3RERrenYvTmpQ?=
 =?utf-8?B?Q1ZXQ2xLUFFYSm5mUlMrUmZtQUh3UlZZQUVjemtuK1FmTXlIQ1NkWFpPS211?=
 =?utf-8?B?ZFdZUzhpK3czVVpTSkNWaUxNbTdRakxzekZaSWFoZUFQdG8zV001Vk40ZWJF?=
 =?utf-8?B?NDBwMDlQSUZuRWhZSFVselpPOHJkQjRRRlRLS3pNZkhkdTArL3pVMlZRczN3?=
 =?utf-8?B?WnJnU0hSK0hGK1dKRTg3czd6WWZtSTFncVNkbWdLQXA3OUY1akNKd21FbVNC?=
 =?utf-8?B?TDQwd0k1SzNvZmlmV2U3SFhCZHh3Q2UvdHVxQjVjY09McG85TzVyL05ESjIz?=
 =?utf-8?B?T0M2RXNncTVMOTFSRW5WSzJKSTh6U1BMS3Y1RUVjSlpRb3VNNUE5M0ZydjFV?=
 =?utf-8?B?b1BvNW5ld0Y2UHlNcHVwUURPYld2Z1IwVE5mZ1ltVExhLzArMjBtWTZvVnVW?=
 =?utf-8?B?YXBTOUJONHpqNUhVVFlYbkhLcUcvbVNwZXVNeWphaVdScHRVblZkb1VtVitT?=
 =?utf-8?B?Y0VtaUl1VjNYbnVhS0J2ZXBPWUJNeGtkUzY5c21LN1c2MzhSN2NFbkVQcVhh?=
 =?utf-8?B?RC9uTjhVYUhzcm1Wd2hXSStodEtqRUgrYTlQcklKVzhiNzVOemRlYzdJci9V?=
 =?utf-8?B?V0hqcXlSNVVoZUlkcGVta1NSVXNsYUFEQmJ5SVZZWjRRZVRMb0JUSTZIK3ht?=
 =?utf-8?B?dkJKdDNWaHZ6V1FLbmFoUEJ6NERkTWhvSmx1MTJHaVY2WFdsa3FxMmdMM2pk?=
 =?utf-8?B?UWlNQ3hiL3Ewa1hVZEgveGQrTHQrY2NFck91RXJCTWoyTkFmZzBiL3JxTXF4?=
 =?utf-8?B?VDdMaGxpSElDZEs0eUVhb0pHNmJTZXluVExUbjhBeUFwNHJIb0RjSlZ4dDdM?=
 =?utf-8?B?M0J2MVZGYy8vS0VabUE5eEFnOUgxUDhaeHhkQnlKVlJnaXNaK3VoZVc2cUlC?=
 =?utf-8?B?ZlkwT2tpZkdJNHRKVmNWM2F6cmhjZG5FMmxPS2hDTGVRRHZBWis5UWo5Uzg0?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904b4c1f-9436-4ee6-913b-08dc91120277
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:16:11.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGvIf3Nl393OPXl4ANVZgBuGPjGjXaaULjGwSI7Gu+IGd7a+TaaUa8u3E0fmULIUR3CW3y69a72g5FlqX5/qHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 10:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16303

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=6&day=20&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/06/cip.2024-06-13-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jun 17 08:01:45 AM UTC 2024
  limit date: Wed Jul 17 08:01:45 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jun  6 12:19:51 PM UTC 2024
  limit date: Sat Jul  6 12:19:51 PM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jun  5 08:14:01 PM UTC 2024
  limit date: Fri Jul  5 08:14:01 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jun  4 01:28:02 PM UTC 2024
  limit date: Wed Jun 19 01:28:02 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue Jun  4 09:25:36 PM UTC 2024
  limit date: Thu Jul  4 09:25:36 PM UTC 2024
  Status: On track

