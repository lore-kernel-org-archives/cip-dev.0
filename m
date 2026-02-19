Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A898E9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 06:51:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8734.1771483864315826150
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Feb 2026 22:51:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cLszzbJ1;
 spf=pass (domain: siemens.com, ip: 52.101.72.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7oyug2X20jyY4ybtT+7gHqB3ajiY2QVrWfjSiRD+smF9UY8i13FrhGfnSlXdev8pNKpBN8qTZSzvN6p9sldlDRvAeJK+Ay2d2ZUlRMw7UQwePmAnou0koeMn1EQzEEuKe95ZiCh6827Mg4HSZ3CwyFqd1UwLH+iAqEw7UtlUtBGVC9QndBXeq/Vt1FDYEkWq95oxv7k7W8ZUZeozSgvbAdYdvf14kCaqtSrAiBMS4NJQOvnrb5EjSYZiZldYDdT0CTqBEgpbGg1vNJ20jm0kU2LgqfZkUgSxkKDZ78QlekCYmONEBX+3iTxquHxrn5bQwSTFBiXGq8kI2gV5rT34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXuVHmsYV8eJsAOo7BMQboQGHrlDxtTl/QecEdYyMFk=;
 b=xVCvkk91912qMpgoDHArfG6qNE/Bky8Gic0hS93D7ms1RRWNSSigUoaCEkfQZmVt0tot0vkPs3F/MMcxk3kpp7LqvLUahvwbYU4fNH5yd+y7lfbOe6ag0xuDkVPvbwQ4eKP1I8auFqnlCAowxDue8xnJcLDbA54JX74OQzPo/Q7FUrZO4H5dMqSH3Nx0jSr1Y6UJZ61VM2m2B2CPNJzQNAvJTRIF8D8c7sKqqtHVhOXuXrsJc+ZWHMs2XD7k1JCLcDBKpS9qVYyyVYLul6CDOZwnObQkIHU7GVsBXFe/F+K5FpsOOZy3ZwTai1M4zEA/8fsv/jkDW947yK0/LSLt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXuVHmsYV8eJsAOo7BMQboQGHrlDxtTl/QecEdYyMFk=;
 b=cLszzbJ1GfnE94nSKyvuj/DOYv2qxSkMslzN3v3EKEqaGi93BI4QU0MOmIrcXdT7RDhhU9C2J6ArQEFUJNUH1BjnnVIvHh8lwq+0gSZy8VGT4AN/vHl0FzahQjzwnaCek+b1D+k0/GOhHEdJkKzDXV0ERzi7+lw4gIb4+FxRkYufXQxF1HrEKtKQlGTp+koJ2VhvejM0aFCFK2/U7JtG+3R3zgW9K2a76fvSb+ggTCk+kVzdfw+PodetxELoN2DkgNzJXovg6pFRZHrjNydmmCQBqt8rR32ssbeizHdtfn4W9ZuXG+KAN6GS9GnFdWIavJ/LsWroZRxRXKFcUiOyaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 06:51:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 06:51:00 +0000
Message-ID: <79ec7880-394d-4e29-a213-9c23de51785d@siemens.com>
Date: Thu, 19 Feb 2026 07:50:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4010:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cb298d-8405-4333-bead-08de6f833e03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VUIyOWNZUDRHb2VQVHQzSWxPZy9YZXhKSFA3bE96Wm1kejhwaDZTbUNaQUNE?=
 =?utf-8?B?bFlDSlk1bDhjNzBuQVA1Ylp6UkNZSW10NnFDcDNFbWhjcFRLV1JRK2JTa1dK?=
 =?utf-8?B?V0NyTm5xYVJNYVdpMEdER0tnOGZUaWR2MWVLd1ROZ1RYSG4yWXg2M2dvaDFs?=
 =?utf-8?B?dGo1NldmZnI1S1JCWEtLbFl0L1ZHN1ErSi9JQVB1ZElRdlBUUmxSR3A5VlRP?=
 =?utf-8?B?RmNXdzhGR2VqTUdrRUFzRDhOZnlpYkRaRGpoR0JVQXNzNnNESUtQTVdUb1ZV?=
 =?utf-8?B?c1lFc0R1cEpPcmhIVzdTSVMraDJFRkg5bXdpM3lhNFpydHhKRFNEYXhiNlZL?=
 =?utf-8?B?M0hyNmZtM3EwNTNIUUQwd3pFV29zd01lbEc5Zk1tdnd1YWFXWFMxOFZDU3VI?=
 =?utf-8?B?OEV4cmEycm5pUTE0QmQzK3VoQVUvRlBRU3RzZnZwQm4wcFI3VjhTVERSWnow?=
 =?utf-8?B?THFOTGhnbWZ3UExHTXViZ3h5MTVOc3lIbVJJbDFVWGExWDFBd1lYYm1HQ0dQ?=
 =?utf-8?B?S05sNkxZMmhvYnUycExCWHd2cWMxM3hMWG5Qdy96TXFDNGpXYzNoVFU5L2FS?=
 =?utf-8?B?VFpXdXVJN1hVZEhHeHZ5dVAxdkNRMlRKcTlFN3VIVjlORmIxdy9qMG54U0ZF?=
 =?utf-8?B?N09sVzRwL1RRVHc3U2VIWlVoRlBUdkZFNFoxMDRUM3FEUXBqeXEwbEZpajh0?=
 =?utf-8?B?VW4zM29tU3pad3lGdWhseGhGb3BQeTlKa3BUSGZreS9Kc3lVSHFLWkM2QVJB?=
 =?utf-8?B?N1JmRlZweHd1LzJuWkF4c2dhZUJnQ2U4U0t6dzk4SGx6VEpIMGcyWExvb2Jr?=
 =?utf-8?B?YXBpTEgxWlAzSUZzTm0rWWxtVHNPRzR0VlFVb2ZCOWdXalY3a3VxWHZZRENh?=
 =?utf-8?B?anNYN1EreHJmZ29xelRueHpKZmh6MHZRZ2ExZSt6Z2Z2M2NrVkd0c0grMEh3?=
 =?utf-8?B?aTMzY29vUWpRT3dGT0ROVmlpK2FmcEkvVmZ3azE3eWwyY1lrK3ljRnZjNXNF?=
 =?utf-8?B?MDA3cS9iVlpYbVJSZGdCcnZ3WC9hakdLdmFHYjArc2UzVzNmcG9Fa2NCQWxr?=
 =?utf-8?B?cUk5eWlCOVAxSzNFZU5aYi9FbnloNFFkNXo0VlRsbzJrUTY4MklxMmYvT2Fy?=
 =?utf-8?B?VFZwdXdvN1kxQzVOazBieFZNY090SnV0TGlYZTdLNkNzbThGbEhoYkxFcmFD?=
 =?utf-8?B?NDdkSmgwSGNDUjlGRlNLSjRaVzFudjYyamRDZ0I4WTl3K3pSeW0zZnA4dWpr?=
 =?utf-8?B?WGtwRG9vUElnVlVqMnJkaXF4eU40azVJaE5YQmJ4UEpoTisvSEFsZUhkL3lp?=
 =?utf-8?B?cHlwdS9QWS9WampnTHEranFYTDRRT2kycWFhQmVzQnBCTlJxbWdWUFZiZTZw?=
 =?utf-8?B?NEJ3VDNqMEpIVFFDbnZPSm42dnFmYmNVMFI3YUIxTDRLbFdLYWErenZabWd0?=
 =?utf-8?B?ckgrWms1RGVZR2d5c0VLL2tpd3VSeUZReU05eVBMZG1McGxLMytRSUU2ZGNr?=
 =?utf-8?B?VnlQcDBNaDVBWGRMM1FDUmFsYU1OR20xMU9zZXIxVzBVamwxMk1sa1IzOU0y?=
 =?utf-8?B?K2loTnZHSE5EMXlMVXJMcURrc3JyN2NOUENLaFdhUVYralY2L3BnZy93a2ht?=
 =?utf-8?B?WjdKOW5Pd0ROaGNid1V2UTA2QXBBQ2NhVEY4a2E2cnVNQzJBNVRNdmhHUHcz?=
 =?utf-8?B?VFdPZFlHa1M0R2liUWJNODNRaHZITmpKWjBvRloybkJxZzVvTlJJNURoaVI1?=
 =?utf-8?B?QWFUTFdXNnhzNW5PeHU0QUxFL0NrWTNQazEzeEhtd1E1S1dCZzhUVFRkeGgr?=
 =?utf-8?B?K21nZEkyUnNDOGpBTGZlWVdKYnNTT01lL1JLZWFTYXVLaC9FNFptbDBZS1hm?=
 =?utf-8?B?MVhOdC9IaTc0eForZnFqRm1wMUYzMThYVjJmTlF2YWdua1lqMGhpdWZWdzBp?=
 =?utf-8?B?cWYyekVySnJIeTdpbWdLeW5MaUxPa3hhK1hoUitQaDFuU3lvWjBQd01xL3Y3?=
 =?utf-8?B?b2VYVzFOSUlJN1BUK1BLS1hqM0RvV1BKamh4dTdhUnBqM2ZBWWZ0eWp4RnFB?=
 =?utf-8?Q?rRXhEQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YktJSllQNGVRcjJvdnlUWnNmeUJqRlkzREFUTjdsSFVnQlF0MTFxT2xINHBz?=
 =?utf-8?B?T0R0T3BDMStIUkdZTkwzdVdOSDM3bGZVOUNiU3gxTktOd2VPN1dqYklqa3lh?=
 =?utf-8?B?WXM4SnN0SUZUdzlPRWE2YnhvaUNkTk95L2ZENG1YT2lNOXVuQUh0WlNrNm9C?=
 =?utf-8?B?cmNaR2tDUmJzU0Y2OXlCV0dWdy9EWVByY3pEUmpIODh1blJ1bEFadTNwbXBD?=
 =?utf-8?B?ZTU2RG5XYVNCQkFXbEYzaXhJSVVkSGVPSS9UZHV1RVVQYzRSVjQ3c0tNNElE?=
 =?utf-8?B?UzQ1cTZkL2FpY0tYcVo4SHpPSkZ5OGdvNWpKcXJiSXJielNHRlhnUmRWbjJ3?=
 =?utf-8?B?cVRlMk9kWGpmakczWnBDRndPZlAyYXRwTjMzMG5xWm5GY3R5K09KeUFEOGdB?=
 =?utf-8?B?Y29UVnhkK1FSZHEvZTgvQnJ3YTAxcGljZzhnNTM4bWVPTnRRWktXYURhQnhT?=
 =?utf-8?B?NGkvd1N4UDNlejE5bWhGSDJrYnJGbkdBcEVFbjhwSnNUSFdHcXIzSThQQjI0?=
 =?utf-8?B?N0RZTjRTSXZBeTFuYUpPMDNoSjJ0dndoQXIzRXR2NHhRVXZSNmJlMkpoWEJN?=
 =?utf-8?B?TlVac2hZUjFrT3FhTEc1Mkhzb2FHVGFFQ05VdzJHOWdkVk41TlFnWVFPTjc2?=
 =?utf-8?B?MDhLU3BKMURENmFieUNLc0l5ai96d25vVHEraVBkVjhmWGhSOHRqWHIrT2dw?=
 =?utf-8?B?VFZTL01ocnhZR3ZMQktPTnIzbS9wV1dYclREMUFVLzNhTlQzS1lSRkdWY2p0?=
 =?utf-8?B?dVZSaUZENjA3dGRwdWdLL09TU1JYQnVKcVZtK2NMSkdRODFabTZOdklPa2k0?=
 =?utf-8?B?aDBXRWExL011OHY4OUg3ajM0YWViYmM0TjlUWFI5Tm9GTGVuZEtIRXNmWUln?=
 =?utf-8?B?NTZ1UmRldDYwZWVDS1pTYXB5Z1g2aGRvUzJmczZOSFNMT2ppMGtDRG82YVh4?=
 =?utf-8?B?Mkp1R0xTN05KS2RHQUtRTlEzM0RMeHVBdkNMWHBzcFV5TFVYU3NtVTl0RzJT?=
 =?utf-8?B?YnM2UHZ4enIvdWJTV1FmTlp1RitlRWZORVBWOHVpcCtwamN0VHM0cnVqa2w5?=
 =?utf-8?B?S3BpcG1JY29FL2pPWC83ZzZCbjIvbmRYcTFqaU55NGsrRW5FRVo1SlorTHY3?=
 =?utf-8?B?dCsrTSs2eWlIR09memtPWlRPQnFaQW5PT2Nzc2tTM2ZyeHZoU1AyMUcxRjRx?=
 =?utf-8?B?QkVxTk1Wb21EMmJxeFI4UVljRWFtZzJoUHN0NXo0azZPMXJGRTNmUGg5Q0Jp?=
 =?utf-8?B?MGkyakxwZG5WWERqSUlUbU1Ob1hDdmMycHAyRWxvR3h0MnVIZmxCT3F2Sjht?=
 =?utf-8?B?ditNb2R2VVhjMXp6Vkp4Y3hKalU4NlF2YjMyNjExZUZOZ0ZQbW41VVNtUUlj?=
 =?utf-8?B?Mi81cFhlN2JHbUdZaWNzSFNja2dIaW9RcVZlNkpqU2Evd3hqOCtVOVhSc0FI?=
 =?utf-8?B?cTJoSU4wS09WL1ZyWkRlWXpEVHJzNTFhNjVDWkYwa3BMTTJoTHd4MGp3WkJE?=
 =?utf-8?B?U2JDQStqTUpaQVNjS3ZNNGxYL0dOZ0Rmb0Nsci93M25YK2JJemYwUTJXV3Vj?=
 =?utf-8?B?d1R6N1hkb0Rkdi9sUzhUTm05NjYxdk1HZ1NTOUVqQ2tsTytSOS94NHBURm01?=
 =?utf-8?B?QWN5UjBnQW55NkhhRE5tc2czdkx2SHVXaTZvUFRHeVh1WHhYRjNNUkpSOFRy?=
 =?utf-8?B?eEh4dU9McmtEcFBEMURDeFI2cENMck80WmFMQWh3bElZSFRkVlgvQXZmL1Za?=
 =?utf-8?B?dmtFNnZQUVg4dUMwdnVsS3daVmFkWW1WdVM3Y0xQU3V4T2w1dGh1ZXptbWlY?=
 =?utf-8?B?NjJ1MTVlZzhTQ1RlVnZUeC81YXZ1Vzc3VGtXNGhWYzNjdUx2RUZabVhCOWRy?=
 =?utf-8?B?alF0eEtSeDdpR0htR2RiNTFYR0V1aUwwanZDSzR2N2daTjhwRWtOTCttZVBs?=
 =?utf-8?B?ZUM5dGtqVjdqSDFNcmxMU0wxSVF6TXpkUFB4MUVXdktZVENMSkNUc1U4UVAz?=
 =?utf-8?B?YnkxMUlwMFBidFRiUUQ3c29NM0NJODNZdnRWdGxLYmdpaEpacmxkaW4zV3d4?=
 =?utf-8?B?T21yZFNhSG95M09MS3ltTDlmWWFlRVdsK2VUZGNoazR3STQ3K25nd1ZMdXBu?=
 =?utf-8?B?Z0VIUlNBRWp3TTlZMTVXaEVDSG9qOTViR3RQL2pyd2xRNnhicy94YnlIdjVK?=
 =?utf-8?B?dytIQ2ZxNURlSng0MmllV3ZNYUlsajdObUJmTkpuT2lxVk9ZOWYvNWV2YXIw?=
 =?utf-8?B?TTVWaDFFUWZISzgxZ2huaGJ2ZHFpMUlGL280bHEyNXlSY0RjTHRicHlLTDJn?=
 =?utf-8?B?RFNIdk5wQmk0ZHB1QTJXcU9TM1pYYk1rYzRKa2N6MmcyYWNSbUZPdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cb298d-8405-4333-bead-08de6f833e03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:51:00.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHSq3vANZK/rvdPsPVpyYsOAc2TePZ3RgAIyuvHm4dPYxPS93d1o4T1TL+AfWAVcWjkQ0n4hki8HyI5lNjEtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4010
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 06:51:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21895

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=2&day=19&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/02/cip.2026-02-12-12.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - any further comments on
    https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/2c2fcf8082a3f69eef81f4f3d204473d7879ad1b

Jan

[*]
Date the data is created: Thu Feb 19 06:47:57 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Feb  4 01:55:28 AM UTC 2026
  limit date: Fri Mar  6 01:55:28 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sun Jan 11 09:55:11 AM UTC 2026
  limit date: Thu Mar 12 09:55:11 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jan 29 04:48:14 AM UTC 2026
  limit date: Sat Feb 28 04:48:14 AM UTC 2026
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
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Feb 13 12:25:20 AM UTC 2026
  limit date: Sun Mar 15 12:25:20 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Feb  5 10:58:13 AM UTC 2026
  limit date: Mon Apr  6 10:58:13 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Feb 12 10:21:35 PM UTC 2026
  limit date: Fri Feb 27 10:21:35 PM UTC 2026
  Status: On track

