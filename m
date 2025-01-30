Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E3C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:34:08 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.40])
 by mx.groups.io with SMTP id smtpd.web11.11993.1738229647146998946
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:34:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yk+0Pz2E;
 spf=pass (domain: siemens.com, ip: 40.107.20.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fawkwh0Ntl55ctpni3I59Z3k+fXBtsVNSDEawoYWLh2lCialYRxZCJkTVFQVpobeWSPhQhTpRslRt3sGEZjLqmj0ep9B7N7F6dv3RyayFp38B3jG8IDle9F4crtRIRvwlSmsuBHef0sNyr7HSAFeWz6csmJ3FFZWt/2BfrPjDhsxeyl71/CqlGMGyrsFf+Bz03eNpMX/vF9aSSVrhk448sHxWxm0lsX9GCJr1KeCq09endqp6RdSl14y23Wgpx0HuSTknlzSZRKyEOjQnKTcJ6kIpwF+0Ljb/Fs+tY8LjSTSNqXzjFnUZvSkjxHZbYCZungWUaiTE0pLDV/MxsOY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJr8qMdBi1OYLWtD+91BsMI1L6+Bv2DrwocfFhcNo4A=;
 b=hPEUoOzp4sRYHstI91Owkhg8X2+nkxbPJLqpkcIcBeEk/RDZFSzXfTCoZYPaAcKr9q4YelPPo6qf8+kYONl1xIE+M9tXpUvvgAg+qPL8rSNGFBZGHsDjMFdSApbU5QVwkwTTiqrkKVMe8TcVmLJj44CRIfQtnDb18gQylKW16kl60+WTGiz9M4clHI2x035MxNMye4YapuIwKNKkQ8Ah1mNemlj0DNjM4QTWTiBbb00kuWP2g9ri4E/bWuseY6LFLOyrmnlwSvKwBXaLhx1raQ9KSbz/IGUkPFL5ya2aKbvvNiO2JkfxN5pREuNaQ0EpFZQ/dRewPBWidfdcCuPTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJr8qMdBi1OYLWtD+91BsMI1L6+Bv2DrwocfFhcNo4A=;
 b=yk+0Pz2EN4Y8szwcAC4nwXCzt+jFIKQO8WKMenaE26XsgZ1lTgxcfMBrbaaE/1Eqo3/KQ2Wifvxjj9tgaUvPHCQSqm5SLKG7ASJQz/QQZm/pL/rVwnekbOXeCcR72AmfQRX7rD/+Pg4LI4fY+B0HKA9cIVPk8VIE/GCl6Fr8Z3mFUo6SKhMg6SrlJhqy0wIBL9W47GOYXefOVk+UZ0Rj//7NvIUpBRY0UmPOrEyQrPfxwZj9rF0xxgE/X9e3Exsb0iRy7znbNfubiL87Q6UVorx9Gwx506SRywjwjHUvHo0NwnDKVUfERym5ZE+wS1NHZIcKGOPLzSLL6Aiv5Vcj/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:34:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:34:04 +0000
Message-ID: <62351585-3aa3-490b-9174-4c7bc9e79e50@siemens.com>
Date: Thu, 30 Jan 2025 10:34:03 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3750:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0f9fdc-430d-4c5c-4328-08dd41113c96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eTdWR1FGUkNkcDgvN3R2MVN3NFE1Y3ZzdUFJLzRGb21DMjM0VkpsN0RBZW9w?=
 =?utf-8?B?OHJZR2lCcGdsVnlBZEFkajE2TXV6RU1tMWxzY1M2TlpzdTVyN1pzL1REdVVR?=
 =?utf-8?B?UTZNMzBXRGl4Q3JuVjlsU1N1MS93V3UzQzVubnlLRnpQcW03b2lmaVRwbUdH?=
 =?utf-8?B?ZXgwdHV4WnFhTWtSdmhaWGYySnZkRnJuL1JFMGlsd1RjdUJBdUVJMklGZTF0?=
 =?utf-8?B?Y3ZnQlloZDduV2VlcFJldWlqNWlpeUhHY3R2a2tmM2RvWUNHYmpLTHpQME52?=
 =?utf-8?B?Zm91NzZpKzZiaDJ5SVJ5czBNQ2xPcGxOMVgzV01XQ2FYNVNwRk9lUUNQQk1s?=
 =?utf-8?B?OGxvdHJlRm1TNmJUOUNxOWJmSmNLaDFDWll0WEVpSmVESW45aEY5YmRZNk5K?=
 =?utf-8?B?dXJxTit4dlB1LzRZNjQzLzVtUm5OZGs2NnBwRlFnelh6bDZxd1BOMG00a3pV?=
 =?utf-8?B?Smg0dXQyQzBCMVVlMmMvRiswUjhFQUF5VUZ3b2tnVDd0cW9uU0E5SXIxT2sx?=
 =?utf-8?B?Vm5KVTJJNzhoeUlSVHUrckNMUUt0VDlHQlNtMzVvT3dFWU9yYWxXRWo1UU1h?=
 =?utf-8?B?Wi9iWDBMWmV4WHpaem1UbWJmdjRPOVNRNVRyUFZoNjFLTTNTMzlRY3ZMYmZo?=
 =?utf-8?B?RHdpQ1FKeWkvQ3lUTi9xV2hNOEpGMjd4V25xN1M4ZUxrQ1VpL0tmYUE3b3Vh?=
 =?utf-8?B?YmpKU3U2dnZuaVo0UDZwUHVrelNFL2JpUWRaUm1Gd0xlLzVWdU1HcFlXM0Nq?=
 =?utf-8?B?Zytkc1VVMFVCNlFWNHl0Rzd4dGliVDNPbjUwN3hHNHA2V0drZ3pwOURzdTB0?=
 =?utf-8?B?aFVPNzdYQ3ZXVFd4YTVrdjVqc3JGMG1ONnR1MXBqM0JOMXJDVnNDQ2hJOVJ0?=
 =?utf-8?B?RDJLMFYzR3hGbHpEMlIrYnhyalRzU3U3akVuNXBMeEJxbmR2VVV1a0RBTUV2?=
 =?utf-8?B?TnBoSnhtSlI5eUVLL3R1WVhjVUQ5N3h3Qis0NUdpQ0pqYTZIU1lTRXdhdTg5?=
 =?utf-8?B?a1lLMUNkb2pzRllPdVJCK0ozT09WKzdja3VHZXNla1BNclBtVUc3Z3NNbHUw?=
 =?utf-8?B?aERjR1RQVjY0YzQ2UUM2dDMxR1FZbGhlOHhEUTFFT292SU5LTFNaTWVaUXFB?=
 =?utf-8?B?YldxaVZBbmpZeUdlVWM5RkZIQUpCWkl5eUV4aDJDZzBOakxzSVBlblV2RERs?=
 =?utf-8?B?UVdtZndEbGZmejByc05tQTY1cmdtYWNiWjRmOVVucFFYcWNxTWNhQnRIOW5O?=
 =?utf-8?B?YzJDMEtONXZnbE5ERGs5VHk1VlV4UjYxaDFRSE5tNktZb3ZlR3QwNGh6U2tp?=
 =?utf-8?B?VFk4L2cyajZyZDJNSkkwd0NlVmlDMWluSWR5QlJCMDNVdEtaZTRJZFBuRnBs?=
 =?utf-8?B?Znl4VUl3dTFwdHBnOElvbCtGNzVRY21RbnZ4c1NaMlhSdTVieWJwU1RLNE9i?=
 =?utf-8?B?eXNkWmZ1aWFZOU1kcGFmMFlFZlFQdndQMjRMNW9XRERVN0I3VXFMZjFkdDZM?=
 =?utf-8?B?ZUxwSGlJWGtaajBJUm1wOEVXR2VUM2dCSWdYNHQvQ3lDQWpLTDN0M1JsZCsx?=
 =?utf-8?B?Rm9nZFFocHdSS2wwWTBnOG9wZ0hlYmZwdC9RVjM4Q1RTVGQzcVZpMHNlZUZF?=
 =?utf-8?B?a0xvWEsyZ1FvaCtEVGk0cnRaT3BRbWZBeUdwUnFSd3lOdk1Kb0dBUTQ2eWVH?=
 =?utf-8?B?cjRaNXBMcUtoRjJ6bndrUkNVLzNMczMxc0h1YUNLbGNsb1RIdUdEUnlqZTVs?=
 =?utf-8?B?RmtuTHBzaVVab0E3WnV2elpwamIvMnVHeE9md0VRYXlTTFFCdWV6SHNhalEx?=
 =?utf-8?B?dkJjdlFvcHNjaXBjSGplUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUZCNFJTL3MyTzhiTWdjR2VyWGpOR3ltUW51LzladWhVaHFOakRSL1Q4OXV3?=
 =?utf-8?B?Slp1QkRldDBEcUNMaFRCNE9YTzFHbnB3a2hNandPQUlXellPeG9KUzlRSlkw?=
 =?utf-8?B?RE4vcXpRNjlyV0lBVVYvYzgveWhYSHMya3IwUzRzTUlseW9uN1hLeUdrbXpk?=
 =?utf-8?B?U2xHeTZESklqaE5YcTB2TlBQSUtoLyszY01vMWJybnJaK2pMNnpMMlk1SEVF?=
 =?utf-8?B?SDRzWTU5a3N2ZlFyc2VTb3g3c1dTdXk1U08vRmtVd3dVZlEyaUFnd2RsZVNM?=
 =?utf-8?B?akM2SkZrSjEwZnVmclVjNWpjL0NCeld1aXVEeC85T2dQR3VvODNndUd1YjRG?=
 =?utf-8?B?c1pwQy9KNkVYOW5rOHVEbVlrVkxvbWNVcVhKR1RMczlQR2RaeTdYblBVNnpU?=
 =?utf-8?B?SjF3amdQL09hL3dLbE9FamVaOGdoeStqdlhBY0VxTEdBSlM0NHpyWUNBZ3pk?=
 =?utf-8?B?eHd2eXdIN2NDemVlUlc5Y3JISFBGaWpCVW1ueEQ5dXhwaE81Y0I0RVNaM0NW?=
 =?utf-8?B?VGF5T2YxTUI3dW0zM3M1Um8vT0VkVU9Tdzd3dVhHU3hpTjZkSVl6QWVPNTU0?=
 =?utf-8?B?NlJkbEhERkJNQVpQS2E0MGp4OG9sbG50ekhQa2FhUjBNbEtHd1k1UXN5ZGlL?=
 =?utf-8?B?UXV2ZjlwWUdnaW9XVm4wVCtFbUdTMkUwb3FJUW9GT05HbFpsakRjTTVOdGVQ?=
 =?utf-8?B?N1ZYYzlSQlJYd1F0cDBvVUh5TFJVUGNPNitCZ3dtdWRFOEt3QlhGQ0IrbUhk?=
 =?utf-8?B?UjVUcEhDcnRXSi9hNCtXNFFVUEoyNmNrWWhzSTlrUUZmTGI2eXJtQnd2Zm9Q?=
 =?utf-8?B?MkVhcktoTi9wZHBIcXVCbHA5elhuR1ZmRngrcDNCcTE4b2h2RnlPbkJLbWVi?=
 =?utf-8?B?c3Jmc2VpOU1KQ3EzblZzVkZxRkFHckNGL3o0c09nZWRsbWx1SHhrRDFkQmZx?=
 =?utf-8?B?R29xejVOOGRMRXQyYnIrUlBjcitHQk1jQW9NMzcrK2tnS0tHeEV4YmwrUHBj?=
 =?utf-8?B?OUl1amJzcGVmcWxuTmhQbkNaT3hMMEpiU2VpbzdLclVPUUgvVU4yWTBmeEk5?=
 =?utf-8?B?c2NtMlRnbVdlOUNTeTdFNzRtVjhUNlFsTVZuK1cvSnB2Rmp6SVdRQVE5enQv?=
 =?utf-8?B?c2RnNEE4R0VEZU1QSEF4c2ZvS3RlWFYzbHdoZTB4dVhyem5YVHdlTm0zai9F?=
 =?utf-8?B?ZTBUaXRJSWxDMkF0S2dibnhlVjBZeTkvZzhPVktyZktXRHp2bDlmZmt0b0lE?=
 =?utf-8?B?VDdDNkpVQTBDeEZGaU1kVmZsSUNGa1B0eWpmRE1wYzZWTmt4VXZEK3MxbTR2?=
 =?utf-8?B?ZlRpa05XZzdpc3RVZHp6SHV4aU9ZSHRheHM5bzR6YXBteWNSUmxUZVoxY2N0?=
 =?utf-8?B?RCtPSWRxZDRDK2Rya1ZqdFR2eFk4VjludU9uUnFSNGN4WFRacnFkV3dZOHpr?=
 =?utf-8?B?MlR6K2VNVkJlK1UzVGJyOEw3TXVJdUcwdGZmUWd6dlN2TVZZU2Y5Q2pTV2Zs?=
 =?utf-8?B?Zm9EWFpQWFEwUnMxcTVicUg1MlhMNFAydHUvV1BTRE9jVndNb1NWQ2hIdVJH?=
 =?utf-8?B?RTJQUHkvVnpOdmtlNkd4MXBwU0x5UThzdnErZjliWHF2dE9mRkEwRkFSS3hD?=
 =?utf-8?B?bC9LM3F6TjZVL0RndWRiNUxtRFplWXlUT0prUkNyUVQvZDVDVXdjSlhQK3k0?=
 =?utf-8?B?TkFxdlg3WExFb3pxZ25NUVNQVEtQaEI3Q0RjNVh0eXJ6MFdhTERESHM0b2dE?=
 =?utf-8?B?RkpzSnh1Rzh2aytXS1puaFcvMStKcWNRSHAzOExZVm54ckJRQzBSVDVLcStW?=
 =?utf-8?B?SnY5UXpXZVVVT0dEdE44Mk5sZGREKzlGSXFhRW8rYlRDOUo5OFNIUHVURmx1?=
 =?utf-8?B?YXpIQjgxdlpIUXpVZjI3Y1BYdVJwTk1DY3ZHY2FkQlkyV052ZzVFR3NWc0pr?=
 =?utf-8?B?ZFkvdkpnTVdyUk9PeDNPeUl1VWsvc0MwUkRseXdEM2FrSjNta0U1UVZRYU5t?=
 =?utf-8?B?Z3Bna1NjSEYvYys3Tno1WUczeDVhYjZJeUFJVFFMSzVsS1pNRGs1RmNreHh4?=
 =?utf-8?B?QTgzRWpqbXRNZmFraFZSYXhNVnFpUkRVMk52SnJkb1VPb1pLRTIwWkhNNUVU?=
 =?utf-8?B?MnZpTjZQNS9icC9CQ2Y3Q0tMQi9Hc2ZzSWxnMzRuUld2WFplMmlwc29NR2Rt?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0f9fdc-430d-4c5c-4328-08dd41113c96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:34:04.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIpZfWqjpzOgM5FWfm+5lA0CGXcjyyYcmjD9F8m3F4R5yF5wSrTTE+avRU2RhX8Fi5k96oP2Q7gIHFEauam5eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:34:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17696

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=1&day=30&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/01/cip.2025-01-23-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Dec 29 08:41:22 AM UTC 2024
  limit date: Tue Jan 28 08:41:22 AM UTC 2025
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:33:46 AM UTC 2025
  limit date: Thu Feb 13 02:33:46 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:41:29 AM UTC 2025
  limit date: Thu Feb 13 02:41:29 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jan 28 09:48:17 PM UTC 2025
  limit date: Wed Feb 12 09:48:17 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jan 29 09:12:10 AM UTC 2025
  limit date: Fri Feb 28 09:12:10 AM UTC 2025
  Status: On track

