Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B7C5DF82
	for <webhook@archiver.kernel.org>; Thu, 20 Aug 2026 05:47:25 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.861.1787204839239529933
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2026 22:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zMvhOtmw;
 spf=pass (domain: siemens.com, ip: 52.101.72.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvyE5r+Av6W5n7nbJtLzh+yxyupxgKknMg8sCmZGNngfQVyWgN8xCTMv8079FiJgKG8YbCD20t2A4mlKGMk+mBWeXEehzg1SvmfLvIIoY1yLpOoiLW0e+UOZhF97/BaSGWE5MNU2yKgnf85SGoPmrOxnij6DGzwnlCg9UdGBobVYBjjMzsEJx0mi+dXM3MalE3SJl8YhLktgpMjCtD6rCQGfklxVOUtgKp6M5CCxERgNOKeYpeVrzGXjHqtpXLaot8BeWRcSmBg14nD5fVTaT6bopAO9exJwaLPTrJgoGUc56SabFXdVmX7xTRiXo1sk5VP0BO4KAmzrF+Qd/SP2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Vb/Bu1WkZfDTNauUxzXKL4TFKSlftbkF0CFGNt1Ic=;
 b=BWQLbPWaPvwdL/cd4hwavoxgGim359dAYg64YKwUjl0VAb2FWs0A1kD+CGOOmnCJ9Lkvnh2Q3KZHB9vajMoaykrPIoOUxq3Hvgxyws1jRC1C71XpzUKnG/QyLf4FAT+q6Dx8jGeyyp5uRVck8N8o53FORWvuwlw9qkKITUj9gbdUbjVYh3FQfTKDTOTeOiK/ei+3w50YxzhFee6GYha4dEXkq5dtJmiLjFeG8NImxBgQ8gtA4Z+Ev2DF0XJQTLor5oVRWGBsnANhGzm/Ul2289JkYpjpMh7NgvMKqPLU/unk3wBxXj43PBXcZAJj14f1rbIal3Y3jUattAP0vTUg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Vb/Bu1WkZfDTNauUxzXKL4TFKSlftbkF0CFGNt1Ic=;
 b=zMvhOtmwuOawr7sX3u7KZJ1u8PYpU1mivMSlFMzD5pHAcuny6WDcTeIlJu6flRWGv6UPBWf8aJpf7DWL5s92KYeEd5X5AqjJ4eKxGCR5+4IK/Zz52ZRbHGvW7P9LmKPlv0Ijcbe2pgzB5cyUIvDlvmD6De5RkBHtR8tx/pIyGX7JT3NDGEkUOBujB4MbK0A+3OSHjn5JFOpgwU2Tm5x2Z36LWCQCFuEwDIyUeDDvFrcVxBVen91Sd6khE1q2vVeHQF78mvab3lLuQZSlGOv1zUICXofY7PXiwLRadZmKl/mUett5VMeeoPO5XgMNoaOumUOFq1qQ4wbSd3/L93ekbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:554::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 05:47:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:47:15 +0000
Message-ID: <ee26664a-37a5-4b7d-9170-b9b907484030@siemens.com>
Date: Thu, 20 Aug 2026 07:47:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f9966e-daca-4e83-1514-08defe7e7d2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|55112099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	wGTkVYQuJJPUt0GNmmUAniYQdGdQAVNwpMS7tDG+QR9Y9nm/FxNea7jq8IZezNRGpn44ZGk9kyRBma+ky/GKGQkwNO/9eyNUI/IhzeUpW9AkVQYTTGLp7Y9tz8c/cmYGCMDCdcb3pwohO5XBNOFu1/dM4cJ6KTA+LuY24a5un3UKTFxZSDld4JbkQE7zmLq5WXCqRDBSs9xmLs7FLqSH8+IwhiUr98kk6p9uGA0S1bLIXWW79nqbdvpe/wSGtQ4VKsDPQXVUNdAAkmmMsjcWtc2CkhvkxVbRea67EDq5h3czUb6BexWC6AyX7JRXMTRn+vXr/R3tVBdanRRVwB+2T2nC+fXCHLz88JaKNh7tJmSniloX4CxwOc+wHReIpKN2GQCkymaL37UaJ4/OPekAhtlt11HnIIyB1w10Ro1RHiMng8Nm8deYAd5NauuDoIhhpuYpNpdawZRenelE2uceeEKndf1C1qrU/06EpZIiXJHADZbUEqU/iB0Qki5hqgAWNZaYlWV0oliGKbhglGYg93OayN5D4t0xOJAESbYtqVGab3jWP6o5GUumlpSD5s4LMTxhAbOZr1WFZ87/ZrtWeCXnmDOj200p5lf4Nj9bWPY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(55112099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzAwN084RFFBMEJGb1NGbDVqMzREWVlNM0FwbzZWNis1RzNmSWF0ejBya29B?=
 =?utf-8?B?ZDJ2SFpxSTV0aTQ1ZTh6d202WStiSDNmaDRpREhxTEdqT3BLMWlrN1doL0tu?=
 =?utf-8?B?QUJCc05kbmRpakV4OWFGUmRUTUR2RjBEdWd0QTR0YW5kdnI2RWdVWjQrZjgy?=
 =?utf-8?B?cjRjYnVFdHcxOXZ2dXhGOTkvTHBQYUVwanpvSjFaZVJrUGpCelRLamJuQ0s5?=
 =?utf-8?B?WVhkcVNEdlN3U0hicEwwS2FpMGo3RE5yV0Y1Wi9UOCtXVExwSkExQkFZV05i?=
 =?utf-8?B?eXNNZElnVkZDYitpTWJ0T3RDeHJHNVNDeXlhN09GenVsZlNuUmx3d05wRjJh?=
 =?utf-8?B?WENEd083T3dxdHFCSk5nV1JVUFp1UWJEZUhQQjRobGlkdXZEU0Z5aU9icU5H?=
 =?utf-8?B?ckhXbnVYV0RIdFZPOU0yV3JoUlZOVXl5RFcxZFZyZGRPWXAvMFU0Z2FyMnJ1?=
 =?utf-8?B?d1BvbGhnYmtJa1RlMFJZM3hEelBrSHU3dWlrc201M3N2OHlaMnBBaXpCd3FT?=
 =?utf-8?B?WWF4RzNsVkxtL1VSblo4L1pjZ21sayt3Q0xsNEVHL1lPUjJjbU9FVXFsQnh1?=
 =?utf-8?B?U1V1VlFZVS9TNlpDeStjbHE5VVhqMkhjMG9KME9kTHAxdjRLNVVwT1l6MDZ3?=
 =?utf-8?B?Slh2RHNGTVpEQ3hMTGhXai9ZYkNTbjh4aUF4T0FicTFkZ1VicTdjTlpYVHlJ?=
 =?utf-8?B?VHBWcmMvalBJcFBjQ05DQmJId1lZaFVyL2thS1Y4UVIvV3NhSHBSak5Wclh4?=
 =?utf-8?B?a1BPVHNEZEVFdlV1SFRWa0RmbWlGSVBvY0ZEeW1aSW1rdW4wWFBhV0l2QTRa?=
 =?utf-8?B?Vm8rOElZUXNPZDAwbnN4REo4SHRIemM0UlEzSnA3eXJwcXpWVUUra1RHMlVF?=
 =?utf-8?B?Z3hWUXRPM0tnNlY0NC9tRzBKVyt1UFhLRlhpeFZUdStxTW52RXFnZnFNcUE0?=
 =?utf-8?B?QUVsZG5PcGpGK3ZSS3Y1bGF1QlhYQkxDSVR2V2hlNGlZUzRjeFVITkRmRWNz?=
 =?utf-8?B?RG1aOXpUbnNpOEFIcXorSmhNWWpaQ3JqWDg3QUVFaWtrSXZrZ0NrZTkyRUJT?=
 =?utf-8?B?WC9icVR3MFkyV1FVUnlnaVFCYUxZd2NCT1FodVlXdSs3V0srckd3akhUcmhJ?=
 =?utf-8?B?Sy9iNFdXZWZ5cHh6QkRGdjVoM0ZKWWpKeUFlbWpzWnhzelZFQ2tnSWhQcnJx?=
 =?utf-8?B?TFdweVJNVVNNVUJKSXpnQnpZcHBBU3VDZVMyWVpvcnl2R3J0b216dCtPU1J2?=
 =?utf-8?B?UlMwRk84ZlJMODhqUGRDcnM3U2RxV0piQmhTMlc2WjFQTHFtUE9NZUREVCtH?=
 =?utf-8?B?b2VJc0gveGFuT3huUEhTNnIvRW54WFJFbFZ6TW9qdzQxaUllYjh3ZGR3T0gr?=
 =?utf-8?B?a0Q4U3YyWmZBemhCZUhoVm4vNTZWUi9TaFZzeTBsNnBvVFhuMy9aeW1NWXlr?=
 =?utf-8?B?Q0s2eDRVenBRWTgyN1JERUZFTTRWQ2VOS2hYaVZWaE9KeE5XTGFjUlJtYnRv?=
 =?utf-8?B?b3UybTBPWU9xSWFCb01FdWFFWUFWbytBeFpkMEJWQmRhSnZZenZMM0MrZy9h?=
 =?utf-8?B?N0Y5NnJIS3UwRDlmbVA5UXlXd1AveWdUMjIzVm9Mb201QUYwUDU5eldRV3BR?=
 =?utf-8?B?ZmxMOWxCcDRWOXY5TWNmS0ZaT3E0S2VRTnJud256cmQ3UkxVT0xIZVRBWWVL?=
 =?utf-8?B?OXNkS0YyOWwrVE0rTldNcXdWU3o1aDJ5cjRhT25Ed2FQbWdJQlgwUUoxM3Vq?=
 =?utf-8?B?WGRGQmxqVDRWRTRvV0tSdjFDQXZQbkkvWVY2VS9MVmJpM282clhKblRWek1M?=
 =?utf-8?B?OFM2UHdZUXBkYW1zdWZsNnh1ODJDbmRiVFN0UDAwN2xEcGpZbXc4TFIvek9N?=
 =?utf-8?B?MGRKWW5BL29zZEV2Ly9LblVXWTV3bWJ3VytyRDRJbnhRbzlsOXVyRkltMHFr?=
 =?utf-8?B?OU1yZWtvUmFWY2dOSEl1YkM3RDZSYkUyNXRzTll4akFhcmQ3NTRLQmpOTHRD?=
 =?utf-8?B?bUxNUnUzT2Z4ZFllSVJPYzIrZDljTVhCS1liVkw4VG4yanNzNGZxUUVDMUV4?=
 =?utf-8?B?UlAwVmRLaG11ZDl2MndvQVRwWjhnSWZrazZ2SGVLQXBWRlh2b2V2RnZvUVps?=
 =?utf-8?B?Nk5oU2ozWFJQWXJvOGdsRUc2NGxMM0V3d0pWNnFUZHBDYWEvck96UW94TldT?=
 =?utf-8?B?RmlMMXhmZlpRekVWQjEvTDk2Q3VGMjhRV3FQQlpNSmF5dXlzUE8rVW9lMUdB?=
 =?utf-8?B?VVVmSng1aFNSL0EyRWF2dDFFa3ZyWnIyYXFPVEpBbTRYeTRIZTB3YWczSFE4?=
 =?utf-8?B?N01BaGhVTlV0eEc5clZWem9XdHV3d25GbjVPT0d5bVJHbXh4VldlUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f9966e-daca-4e83-1514-08defe7e7d2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:47:15.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlQkclSqsk3I8gt1prb0oBkI+/1vercegJB3+AIFFMU7hTTcJ+lkqVP8UAWFd27YDtGOVQP9GIJJHRwXC+nDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Aug 2026 05:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23953

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=8&day=20&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/08/cip.2026-08-13-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - AI review tool news

Jan

[*]
Date the data is created: Thu Aug 20 05:46:38 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
  limit date: Sun Sep  6 04:22:30 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
  limit date: Sun Sep  6 08:15:19 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: *Late*
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Aug  7 03:53:04 AM UTC 2026
  limit date: Sat Aug 22 03:53:04 AM UTC 2026
  Status: On track

