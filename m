Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF2C282DE
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 06:50:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.67])
 by mx.groups.io with SMTP id smtpd.web10.6931.1741243792958396757
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 22:49:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OcI8Hwn3;
 spf=pass (domain: siemens.com, ip: 40.107.247.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA3h8gRbqXNxWSU1fwl1JLxGSn1IsZk4JbPwpqPHy4AEZ2S5rbMA6FsI+CRXNt7VPD+bS+UEWHfwwQNsoRLD65vRSH7qAqs9TclfdtBraDoiNA1qtDPQvyMqpC6AHb/Xsl/MU6FPzHyIXR0w9c59abyI4Kqi2nxsyBhX4GRPWGhDmHZX+ARqbvSf9b/mNy7oZ3wIEf1xFzqtJmpdEDYi/tS3Isg69zfmghicWR0Yh5vKsBd0TFLikRsAxgdABtethQ0fzIMm7yrBpQ2faIcQpLQXrnpXTtIAuMiCGZ+DGu/W4SsR6khcW2Y4hURB7Zif8HcZR1R6asm3XmC5txzu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5fWAMYqPOQ0O1hLuisZLJgYf7pxViNntAt0omqPEB8=;
 b=my/BqthPh9nPzH2i2xJjhBkQw0+Q4zAvM2ovntzoDeY7j30LMewD5W83b1Lz8b9ZVd1CfD4veirpevbX1liLz9ufqgrXKdyOlEWCALNuC/AucEooHqgGUmf2tFXlm08CoDTVl8+ic+wy0qhmnrOxMoQJ3aPsOSHD1GjggEI6dr5WzOUjEc06dZXDuF9npGBvXtMGZvm9DMZst7Jmag9HOcZ9cSDbHXSe0MKmMbBUfaDPbGSI/lloahqJIl5P8p3g3fE0aWlAAaeDfC54PDqSwMLNnZurbvfBq9DdzYiEMTQTwfv6RPdG1Z/Nz1fvNPiQmPHxAlhrpxefSp5eaNQrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5fWAMYqPOQ0O1hLuisZLJgYf7pxViNntAt0omqPEB8=;
 b=OcI8Hwn3ZbFTtWlVc0cIhT8brA5Xik3Sy9D8L/w69mOgWb3Ju2r4e5NNhUqSslgY9E0E9sQfn67oAu2bSdCP+2miibiMJ5kxKSwEGT/G6FO+k/2GkazZxd7m0YmcVJgra7CO6KZ7JQ9GimRxnvIb1qFgFHo0kGOQa4664ePKCkC48Cuy7UFQ6hbHpe5vGBbVvncEzSHA6ezXYaN6+St4l0WUeflitbjpCVSnW7RLUDNvzrO7BVDXbG+eOUFlwXMeL2XaBFhIyRZuIdMG9SUT4oLQDbV/yW4//TJbpQz5EbsbVxKJ1kdcXdSzu3T9G46E5d3KeUTzNwx34ej4/EVLKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8464.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 06:49:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 06:49:49 +0000
Message-ID: <0eb43241-5211-4dff-87db-cd6086e69c2f@siemens.com>
Date: Thu, 6 Mar 2025 07:49:48 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b94c6c5-f9a8-4e6f-b6ab-08dd5c7b1724
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3VkSkVSeVBqV3V6bHZxSGtqd1ZOcUhtZ0lkeGdhY0RZMXRqV1lRekI0a25q?=
 =?utf-8?B?U0p2cHFuN2M5eHYzWDZDdlBpUGtHYjZhbmw0dUNZeHBMR1FoaUtjMVhDZlh0?=
 =?utf-8?B?M0pwaW5UeS9Mc3AvcXhrNGVQa3hoV0VlVDlhakRnTWU0NHUxNjk0NUsvamVR?=
 =?utf-8?B?VUd6bytMN3Z6UHo5VlViclBLYng4NnBKajRWekNKMmhVSG9QYWEvSkFFNmVP?=
 =?utf-8?B?V2kvQnY2SkdDenhvTkRCYkpCak9BMFgvZzA1d2d5TDV3MXUwVWhVM09QcUp0?=
 =?utf-8?B?NXJOWjRKd3ZTQS9FY1JYNDhqYStteklZcFluTHNVblY2WXVmYkJmT2xiWGEx?=
 =?utf-8?B?dDYyQit6TnhDZXdFcTM5MHd0bUVVYklqUjMyTng0NjJYTXhNb1pKVk82elBX?=
 =?utf-8?B?TUVuWWJ0YnRzb3hBUGtVb3pXVy9Sb0ZKeDkyY0xiMXdzRzN1MFQrS3cxbHNx?=
 =?utf-8?B?akk2OXRud2xBWnRqQjlDd2ltRFFQckVQQ1l5S0d0cjA3TG8vWk10a0ZEbkU3?=
 =?utf-8?B?eGlMaEFIVDZkbDMzN2JDSEdreThiMnN3N2N6a2J2R1E2Z1BObVFQSHVCalUx?=
 =?utf-8?B?RGJ0SGZtNnNWaHJ3M3FTWDdGTWhKR3h6enFaV3dMU2VBdzNtdExWWDVOQjJM?=
 =?utf-8?B?emNaUzU0YXBaREJ6Y2ZzMXZWRTI2emt5TGREQ2xXZTVDM1owSitVWGZLa1BS?=
 =?utf-8?B?VnFTT1ZlbWtqRzcxRTVGbWJwMGZHWDRkZ3ZUMzYvN0Vua1pMaU1nTE9SNndn?=
 =?utf-8?B?dThjYklKcDd4T2Y0NXd1VnVFNzh1ZVZTcFYxSFlCYTVERmdEOGJEVTYxZnZl?=
 =?utf-8?B?dHVqeHlNYTk4WXh3bkYydCs5Q21YN21LMmIzVEFFTk0rSEprcUJVVDNwN1Bi?=
 =?utf-8?B?N2FGODBSUmllNVZWWitKbUtMd1R6SlFxcDJUOVFSbTNrWjc0VjRFemNNd2Jn?=
 =?utf-8?B?bTl1NGJSZXJmbG85MkhtZW44RTY3UnZGRGxaTThGcHRMcmhXUW13MkVhVkEy?=
 =?utf-8?B?Ti8xeFJRMnBWNHZKdlEvWGJPWkM5czhyRUs3YTZ3akxuZzVoYnFtOXoyb2lZ?=
 =?utf-8?B?L0JoL0Vwc3plNUhJUmpMU3VtWHBvRTRtc3dGWThIVk5acFdhSHBlbGYyS2NF?=
 =?utf-8?B?S1AxRnF2L2pMM2NBclVtY2Vqa2NVdWVtVlFlT21tRDBMand0NGF0d0taeHpy?=
 =?utf-8?B?SGFzZ3NJNWVVRVhIa3EvUnBpcG04aTBPQnlFRGxEZG94VGphSkk1dUd4VkJj?=
 =?utf-8?B?dlVNcFp2ZG1ZblF2bTBpcWZodSsyUFNtZEZCN0R0UkxMcTBDMEJhNWRKRGRU?=
 =?utf-8?B?MStQbm5KRTA0OU5vYStWSXB4YWE0a0IxeThCZTZvOUVzd2VhMytnNWt1NTlL?=
 =?utf-8?B?b0ovK2hlMWROVGhOY09oaWhXaGZZOHVFcVc4T0hIb0Y1amxCWWFKRFdKd1dQ?=
 =?utf-8?B?RWl5dHlRWHVCNWdTTnlRUXlZTEdrNTQ4VTRNOUpPbzhWVFV1YmxaOVJGQWlu?=
 =?utf-8?B?SVhZQWZSNUVzaW01c3BQUm9YU3paUWJsVTR6WXBSWUZGUFRzaExIdzRIZmFx?=
 =?utf-8?B?NXcwaFJJejl1WGl4K0pyYldZZ0ZDZmVsRThyVEZDMG9VazlIK1hMNnlTdlR6?=
 =?utf-8?B?dTdZNGMzSXZabTRmL2xhVExLc0J0YVNUL3ZXcHRaQXp1RnY4eUI5SFdKbWtC?=
 =?utf-8?B?V2FxUjFCY0FCWklLQVI2aVIvd3hzQmJGZkU4STAxTFZoRFlDeFRFR1pyMlF4?=
 =?utf-8?B?Ly9oSmppZy91N3J4ZzFxMFBPa1dabUF6WUpzZ3UvK0lGSzNlK0phZmcwUDAz?=
 =?utf-8?B?cjdlV0NENk1oYjJRRjRBQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTJ1Um5rZHNaUUk4Y0RWeHgwMXpYVHBDMFNsWlZ5SXhEZ081cTdpNVh4T1oy?=
 =?utf-8?B?aFlEYnlxU3daS0pwY29QSnQ1OFJWbjV4WE9nbWZMOXBPU2YwMnZzRVNMR0px?=
 =?utf-8?B?OGJrUllReEp5L0gxcjR5a2V6SE82UGhodFJGZVZ1d09WZlRrZG0wUVM1akpj?=
 =?utf-8?B?ai9HMXhhR0ZFQ3crSlQ1NUl2cXloK2ZNOVc4SkN1MFVXcENUdkZQVVZqKzJK?=
 =?utf-8?B?OUprWWM4NzRxeG4wSWdpWHZBUFRYakpaQkN5d0VkUXBQNm02WnNUU2I3bFpi?=
 =?utf-8?B?L1ZjTjNFaGprWE9WUVlSMjFpRElQcnZCL0JoQ0pxK1RqSzJwZjBDMnIxZ2ZR?=
 =?utf-8?B?OWNqaks0RUF3TWl3RWVrNDVhbmRreCtKMEdzbjFlMy9MK015ZHRqSWZ4WS9I?=
 =?utf-8?B?THVmdUNSUnZLWHF5c2VEbnF6dTVHWHM4VEdXeEdRbCtSQ2VKWmZKNTZxOHpG?=
 =?utf-8?B?cm9WY0NuZjRIMmlBWG93UDJ1eCt6clpWS1k5RjdIZ1Rndjd2SS8zem8rSUZX?=
 =?utf-8?B?aHlUQjVkYUhMSUN5ZWdtbUxhdzdCa3FudEFRaER5ZTFueGN5M0sybUFoYVlS?=
 =?utf-8?B?Rm1WMUNTME9ieDBsTkJCaHNUbmFPRmpMOU9CajdKRzNBak5rbTdXY2JiM2NI?=
 =?utf-8?B?cVNpbHlhVzhJSktFZUZHc1IzeHphdWg2TEpqS1JCY1NtcTJMWHY0N2I3Kysw?=
 =?utf-8?B?a05oVGRURmFRd2JNS2pjR0tyQ3V3dkNDMHM4UWpld1ZzUUxXQ28xcWhleU1n?=
 =?utf-8?B?TXBiMjdGRDdrN2pJRkhlcGMwRC9Bc2I0VWcyL09lSEpuWWlHZ1Nva211VnZT?=
 =?utf-8?B?ZlhRRnNkUUZwblBSM0JhOVJzQnRYUWxBMDhKUnRjNW4rdzhOd2R5V05qRGdB?=
 =?utf-8?B?WkRzYjdJQ2NXTlVFK1kxSmptR0RHOVM1WWh0ekI3c1N4c1l0bTVpZDQ4ZW40?=
 =?utf-8?B?M2RZQXEzQVBLcmFoYUU2OWZYS1IxY0pnT2MwVXJtbHRCRFBiZkJyTEM2Z2Y5?=
 =?utf-8?B?ZXJwSk0wZnBHWjRablI1b1pkd0IraWg3cm9ZSmlLb1ZmOEc3ZFQ5TmNZc1pL?=
 =?utf-8?B?cE53MkJSYW12RGdvNUR1R2VGbG1MU1l0bDlCZmVtR3Y4L0dsWGdOTk4xbVpE?=
 =?utf-8?B?dXZRZUU2YUhnTEZZTVhYMkxjYTRZZkZ0M3U2Rkt3cUxCeUhPZWt1RGN1MGFx?=
 =?utf-8?B?VSsyQ3BORzZzaC83cHQ0TkwvSG9zNU5KOHBTaXllSG1INzdFa3l5QTJsZE1S?=
 =?utf-8?B?U09EbnVMMG5VWWZtUzB4NEs0Q3R3NVIyUXRlTlcyZURHbDRZMnlKNEhPckwz?=
 =?utf-8?B?Q2pmNGVhUnF3cXBCRUMwNDN2QWhmNHROZzFkK2ZVUW13VFpPOWZHVmgyeStw?=
 =?utf-8?B?WmlGcTNqd3dqU0Rrblh2SFROb3JsbmZVY01WNEJiVnhhRGMyZXlKckE4OENp?=
 =?utf-8?B?N0JlY3luZzdpVFdFTXBFajZXRU5OdVMrTWU1ZnNLS1lRa0pjelhVRzhZandK?=
 =?utf-8?B?UThyQjltQ3ZyNkxHZkcyTWhjUm5rVU1zd0ZTeUVwMUpKb1dIajEyNThqckQ0?=
 =?utf-8?B?R3h1cnphbXpuSW5jcFZjMi9QVEpDOUp5NkZNUUVmSjExRmRuNGc3MmNNZVNt?=
 =?utf-8?B?alBrZ2dPeG5zZ3R0TUdBYnk3Ukl0L0VicU9CY2FicWNXYUZ1N2JVRHpuMWVF?=
 =?utf-8?B?SEtSdU5XRlRyWHJhUjZjamhCa3JkOW1hTk4vdEcwYVVGbTBJRi9RWXdNWkZj?=
 =?utf-8?B?azBDemIxcDF5b094NmhPMWYybGFlRlV5ZGVraEg3WUdrMFFzYUQ0dUhnNWZ2?=
 =?utf-8?B?WnFHbVJHakZpTGkvZXp6cElSeUtvcmlLUllGa2RkcWFHUE9adTlmNUQ1WUpu?=
 =?utf-8?B?b25rVFhTUlV5QXZFc0Uzc29KWVIySjJWSkQzTzhNVWlZaTU1WWswYUxiVElk?=
 =?utf-8?B?MVRMdWE2c3JtaENObWJVai9vSEk5QUdSdlpPcGhLZERqUjJiVURzMEhUbXZP?=
 =?utf-8?B?b1Jvb2d2eUlXWXpXTkdtQzFmblR5M1krM1JLNUVkRVZHWkxtRDNHaXQxcUsx?=
 =?utf-8?B?NXpRU0h3NUR2YXpQVzJacTZodkRUVVBjdWFTdEZPcXErMWlmODJxREZiKzJt?=
 =?utf-8?Q?fd5xSPLWJwuQdQiET9dYUBPvv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b94c6c5-f9a8-4e6f-b6ab-08dd5c7b1724
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:49:49.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2K+SvszIYcrwe+w2mGQXkRL+VW2Y3xC3bXxN8FjL9LiNBFDW+3ujmXIoxPFtEyeXfmO9/pP4Zqub/5OrRtaXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8464
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 06:50:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18050

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=3&day=6&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/02/cip.2025-02-27-13.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
 - input for extended TSC meeting
    - status/reflection on self-maintenance of 2 kernels
    - status 6.12
    - feedback / next steps CVE triage tooling
    - anything else?

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Feb 13 07:52:32 AM UTC 2025
  limit date: Sat Mar 15 07:52:32 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Tue Feb 18 08:21:29 AM UTC 2025
  limit date: Sat Apr 19 08:21:29 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Feb 10 02:15:53 AM UTC 2025
  limit date: Wed Mar 12 02:15:53 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Feb 13 10:01:34 PM UTC 2025
  limit date: Sat Mar 15 10:01:34 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Mar  5 05:05:09 AM UTC 2025
  limit date: Thu Mar 20 05:05:09 AM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Fri Feb 14 05:24:30 PM UTC 2025
  limit date: Sun Mar 16 05:24:30 PM UTC 2025
  Status: On track

