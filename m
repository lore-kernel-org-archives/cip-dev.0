Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7615E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 09:21:37 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.25])
 by mx.groups.io with SMTP id smtpd.web11.44167.1736414494980858215
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 01:21:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dthkL/Tj;
 spf=pass (domain: siemens.com, ip: 52.101.67.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UU1+Dux+nIXyomUEGZPVbK0ijXZCsDDTMvJDh6b8LACraoI8LbOawRQyJuDa1pFX8em3DelRySJi0V9eU+uuexeIRoip7iyPxpAvCnmsStaHemC6KkELOmgGaVW7Da3Va+QSyy72t3Kqhw5ga3pEa0kf6pIc6p0Lb9YPgo8gS0zu2auAdEpXB/gxZ2M6jTEnNJhIpK7qBQ0a5a7/nmlnz4ZdARyY9d0J5leP2IJiU6OXpYEXsLtu6K2uXYlzWMYTN8DmSjvUHvTNL+UrhdibIPrbxkVNN+mUXeWF6uEQ9iSDNqKguVpIe3MgY8G3MjCSDbx1ndXTV7YY7j38q/reYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax8SNPwjC41Yla4JVpUe15zMDeZW6UV+HS39m4Tppb0=;
 b=j01XjCsBkE1J2NlGxKOLtrnc/KIkcAUJVLevnJ3M47s7cVC3pAICj4aj3o59cvZi8drIYHyRrqNe8ecQkIh7QTPOqws6jAJIB1PgkbLNrJT8GEJcXcas+Em34xnJ62bbry3QZB6hcOtvGAIwxAIYEtswOyM90w3cxw3TV2Xvc9Di/usmiwjGGoD2r4UAXLv7A+SRpLvrrfHw4Q5PTXSgcGJKd9R9YavrDDG7osk9n8UjLeudiTbzHaXVtROkyFH+1Dm2DXsi5Fhs8R7/0O0OTudrLWx/8tbh9z9hbEIqoJFPq0+UvnVKNRCea3yWHTdWaIId7BWRphupKMvFcFWPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax8SNPwjC41Yla4JVpUe15zMDeZW6UV+HS39m4Tppb0=;
 b=dthkL/TjtMAKwarFGSHFRIa1prjapjoRmLmswaC2h3L3qGaWuhKJS73k5Ac9D9sRn3XMqio3UWFMai7Jc/6tGyui3ImOxTTyL2KG5D/PQ9KbpimkmDPSjA/55r6y/v20MUu+nmqFLGovWkbskIG4dWOqwz99ETgZCS3KmWicXJJ0MvYCDUbN6phTHtN905Cd2ulSo3H1xRsccvF1c0KPGpeMIyUjlkayYd9DYQr/fMwZ0jFbtkvAF/NpmssSA2SgTMqNWEeA+5Ta0hFg1PhvMd1nyIVmyiZzlg20dnQum+xPT7GlDIKQNc/58uDyYa9WufmFd99JEYMwDbHCrD2vJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3494.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 09:21:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 09:21:30 +0000
Message-ID: <2dd26384-8f5f-49d2-9389-08e436a9db39@siemens.com>
Date: Thu, 9 Jan 2025 10:21:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3494:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f7409d-9c7f-459f-f240-08dd308f00a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZC9Xejk5ck9lRTluMjg2VEM3ZVRQRWJHZ0NTUk9NMUljUXFOdnZ1bFNJd3RB?=
 =?utf-8?B?d2tZajJjMlVRZDNOSThia25VcGE1bGNuM2VuTkhUcHJyb0dTenNkdEd0OFI1?=
 =?utf-8?B?SDBOaDNKNU9YbUJNNFdLQXVxY1I0dGlJaUJWTldmWU8xRUVBdVZYWHpMRWpY?=
 =?utf-8?B?YVlWcXNiVUcxeTFYY2RCaFFob2pVWmlsb0FZaHNRdXI2Y2xyWW1VclgyZTBH?=
 =?utf-8?B?cnY2bTQ0cXZ4U01WOEFaM0tNUk1wTEw5TzJwZWdJNkJOTGpBa2JJTVE1YlAw?=
 =?utf-8?B?YXV1VTBHOEU5cEFHbGpIUGxMcDRmM244SW9TSEx6QWlDeXoxT3BmVVNyUEt2?=
 =?utf-8?B?RE8wc1BsLytCQmFOTGovQStNNFhsWkZRZjFXdnFNWURtRStDb0xQbHd4NUhW?=
 =?utf-8?B?MGVhV2E3cmF6OVNGS2FtcURFZlNPWUZkZ0VDaUVmY3NFTlVmUEFyM25zWEVT?=
 =?utf-8?B?bmVhV0NLQ08zeU9QWStVVEJHSUc3RjlxWTBBNHNlNGI0UGdYRDM1WUZIYVhT?=
 =?utf-8?B?UzcvOXY0MWRxMUNXRnZybUxCTzBna3RpYWlVRzBtQlBmZkFHbGR0MWt0clkx?=
 =?utf-8?B?THdlYzJoQVQ4NVJhaFhzUmFqWTh6azNlUVFuRkovZFJhMnVybUV1M2Jsd1Ri?=
 =?utf-8?B?R0hkZlRZRGhVemdKWVFMakJqY1g3VVZuck1raE13OTZaMmNLRmNiMFRHaXdS?=
 =?utf-8?B?Tlc4SkYvdUVGK0NreWtFQzNRdlNkV3lFVjlUMjROU1ZRSndFMW9lQWtOcHZG?=
 =?utf-8?B?YmFqdXZMSGs1SEVaY1dDa2JxRExMK0FleVQwMks2VnNZZjNzQTRSNFc2K2FG?=
 =?utf-8?B?ajJUdmp4aExkVDMvRVZmbURlWFgrY3ZJSFcrYTlrMDJKQjM4VUtmNGlzbzNK?=
 =?utf-8?B?MldHTTJUdU5Cc1pURms4cndUekRyZmVLdDIrWUtJbUhTRlk2dHNMVVJucEFB?=
 =?utf-8?B?ODhlRDIvQjhWci8yYjVEbW5zazZuV1A0eXdTU21sdWlRK2V6YzM0VkdTNk1Z?=
 =?utf-8?B?T2t6RHdqZkdxSjlzbm0wL1NMTXd1ZjB6NEVLZnFXTXBGQzhmZWhzcnVYekw0?=
 =?utf-8?B?SkZaS0hXaWR3WTNaRUZzajRjMktzUWNQOXBnQ3pWNm5EQjRTVndpb3pWMTFP?=
 =?utf-8?B?Nm5EOFpSUHBONUIyS3N2aUk0UllLQjhxSHI1dy9hVFE0WXk0cXRoa05yNlBx?=
 =?utf-8?B?a0QxYjUvWHJoc1I5OVcweDcrVTFoN0ExMEpHUWdxMDFTSmFRaHlGYmV4c0hG?=
 =?utf-8?B?dHd4OEowa2ludVZUYVpob2c3dTl2K2RrNis3eHdnY1N1L0U2VHAzSTNBVDJu?=
 =?utf-8?B?bW5aZmpoL0duSzJzcWhGd1NmRWI2ZHpLOFd0QUMybFh2dnQ4MWVMS0F2d1B3?=
 =?utf-8?B?aHBJbHVXTTNmaWs0UHMwRWR4OXBzOTN5VndIaXpNNVJwZFFIMzhyRitRZm5R?=
 =?utf-8?B?dE9nb0NtZDhsRG03RTdzT1k2T2NadUFUUkxjdzJTOERvdmc3eUZweXBBejFu?=
 =?utf-8?B?UWxRWjQ5RUNhcHBXL20waXV4TVFlRHVxSnRjdTJtNkxLelVyRUloNlFYOG9L?=
 =?utf-8?B?N1JMU0Vzc3M3NWtnRVJCQ0IyU3VuTTFkdkROaFduRWt4c1RSTHdkdEpFS2Ez?=
 =?utf-8?B?M3ZxMGlvZHBaNnBrNHR2bEZLMWt4VmdlbmNHdld3ZjI2QnF0M1VzeFFGWks5?=
 =?utf-8?B?OUo1Tm9XTVBIVC80aVRhSUVwQVBramlQK1dwNmgyRHlOaXNkODNLeFpXdVlo?=
 =?utf-8?B?OVNWdVQzaHZueTI4dUxTaG5lTS9zOERwQ05KNmVZYlBxS3V3NDNTd1VzU0ho?=
 =?utf-8?B?Y1BsSlUwSHpkdXZVOWRoQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzhhOWllM0pkRTYzM3ZkbFVNL21WMXQ5czBJOVI5NC9iZFA0VHQ0bFl6Y2Ju?=
 =?utf-8?B?QllBa3ptMXN2a3FtdkRtYjQzQ1ZPSWpHSHlCZ1JLeXBZTWlXZzFFay9wNVJm?=
 =?utf-8?B?SWgwTWJzejFuZy9wRkNVek9veHp3dXo2bEk2Nk03bDlqRVJrNEkrOFBPTThs?=
 =?utf-8?B?M1lqVUEvTHlFVVgwK2Z3NHFoaFAvL3BaSkxHd1Y2clVUamZYUzZnN255UmZs?=
 =?utf-8?B?d1ErcXgzTTBSK3I3MVhObjJpVmw1bTVHenhxM2Jzd0dmeTZmbktuUHR4WjRq?=
 =?utf-8?B?OVVZaDRPMm5XWE1BSEdvZENZcmtScGpQSkdyL0xLbVlsN1VKLzdOTXNhblJs?=
 =?utf-8?B?dGhsVFF4cy9jdFRKcm9MdjdyVmhOUjdvUzRSWnVJQ1FncFNJZm1XT3R4bEdw?=
 =?utf-8?B?UDFsN2xUVXZPeVY2NjFmanVWNjRFcGQzNTFPOU9KSzNhWjFzcXB2MEVwc204?=
 =?utf-8?B?cCtpdHVOSjFLSnRoZE1kMGJVdHBPNG5Wc1d5SmRNclUvaUN4T2JUclVoWURL?=
 =?utf-8?B?blFGRHBjR3VWTmc1b0xYMGIzSmE4ak02V1BaU3RiTnRkdG95VlhCYkE1TGVn?=
 =?utf-8?B?MXN1YnBKQ0xTa2FYOUh2UzcwQ2YwcW0yVlY2UXBCVGJtb2x0U1BvUHJUV24r?=
 =?utf-8?B?ZjJxTC9QR0UrWFRnSHdVUEdTQU1uNG5LNmxRU2U3VkRjM3ZJYU9qOFBCQmxw?=
 =?utf-8?B?YTBJUXllVHI2M1R4WkJpMjVUaHhrUkx2Skg1K1AxOVl6UVNUSklCQVh4Z0Zy?=
 =?utf-8?B?dnIrR2NsbUFvRnh4cEo2LzZsSU5aVnlNRk1OdE0vdVI0Z2dUZzF1UGJpbnVh?=
 =?utf-8?B?WmJ0M3BLOWVwSERCbm11cGN4U0NmMjhQTkRhdlNmLzZiU2VsMjM5UXBFTXIy?=
 =?utf-8?B?S2lTay9sT1RQdUoySW9xb1EvUEtVbTZ5TFZpVU9NSWphT0ZnZjlJdXJvTHpD?=
 =?utf-8?B?YVhhR1dhNkZzVFA1dCt6cVJ3a1FaVVdJZld4azVnd2lYY1YxODZia2Y1aVdB?=
 =?utf-8?B?OTFEc0NUbTlyRjZZdWozd3NRVzlIU2g5UDlHNDhGQ3EweGJ5VDZCQm1GTEh3?=
 =?utf-8?B?czIycEtveFZLMG52cnJ0RGZZU1YvRlo3d2IxZEFPcFhLS1ZzbzdENVgycE8z?=
 =?utf-8?B?RjcvdUY5dUdna0MwVm04MWV4K1JqSTlXKzZjZzhiRjQ5WndHOGxnNHo4c2xt?=
 =?utf-8?B?T01uMmthSUcrYjNsOENZbS9jL0FOUUxGWjNJSEZwc2xVNzRnZVFrc3NoM2xa?=
 =?utf-8?B?U2U2TWlqSmxpdlZxUjFVSlVQTHg4SzlvWlZKNTRaN3pPekx0d2xtNUtLOGUy?=
 =?utf-8?B?UmNTWVVqUFROWE9ZcEJvOTBIT3pGbmM1VHlZOHVDWS9qV1V2eHZJRnl1QmdJ?=
 =?utf-8?B?K29RcldjZHZ5Vkd1WGhtdEdTeDlJOE9paERBSXhzUmxySEVWU0czVFlNeGlZ?=
 =?utf-8?B?SUs2VDl3d29NOWxKdHVkaTdEbSt5SWUvWDAyVDZrY3p1ZFVlWGRaK1RpM1dC?=
 =?utf-8?B?czhOK28zdE5wbmVLSXh0KytMS1RvVGJxN3JHTHJqNnp6RUJCblBhNy9aMGJO?=
 =?utf-8?B?aDQ5WFV5cThNZ1IzQUdIZWlLbWhrbVlJbjlMTGlLME5LdEdPVjlRanBSaGQz?=
 =?utf-8?B?U3c1QzVBNGNOYXVJVzZ1cXVqcTg2M1NQT3dFSStZZklZZkhUako1dnFWTDUy?=
 =?utf-8?B?Y2NNaFgxVndZajhQS3hEYkF6K0MzRlBmR3hXSk0yTTFybVZQK1ptSE4rekFU?=
 =?utf-8?B?NXBhSWYxQkYvalE1dUZGOXdWQndIa2IrVVRyUUNVbEx0TXV3MVNBREdYM1pl?=
 =?utf-8?B?Z3E2OHRQV0RySlBTTkdoV0VreDBPMGh5SCtCU1MwOTRKREJoNTlxT0g3Y1pO?=
 =?utf-8?B?SHVrVTVuZVBsODBZcWxkYitqMFdnYVpsVnNyblgvemRUTUtzZWtyYzVTL2p4?=
 =?utf-8?B?cTRTWENiT0tiZ0NBZ0c1Z0swbWtzaTc0enZCZ3FENkJscnh0MmNLTXNTM3hn?=
 =?utf-8?B?aStkSzVoTnpZQld5cGhwVVNqRFFUVFhqYWJwdGI3UVNmU1BzYnlRZnZZVkFM?=
 =?utf-8?B?RE44cnA1VFRHQ0IyRGJ0UlZGdFdmaWFWSURCTmIxeCtJVUhsWXVFQjJxT1pT?=
 =?utf-8?B?SnBHM3l3QjdXbUF6SllBaVRtS2dxREtnT2ozTisxV21tbW1FVmt6MnZZUzFD?=
 =?utf-8?B?U1laNUk4dlpkUTE0aTc5ZWZpVHB4SElKa0E4UkxCWHFOQlIybUlibXNDWjVy?=
 =?utf-8?B?RkRqMG40ODJYZ2xycWJ3ZnR0WGF3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f7409d-9c7f-459f-f240-08dd308f00a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:21:30.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSWkqdz3ImlJHM0M3F4e7Q6H7CApakLyOA/x9U5bsl5WND1ZUmt1RrDEIlkUkXHMfA6RubztN2RePbTD69jZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3494
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 09:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17511

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=1&day=9&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/01/cip.2025-01-02-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Dec 29 08:41:22 AM UTC 2024
  limit date: Tue Jan 28 08:41:22 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
  limit date: Mon Jan  6 07:05:01 PM UTC 2025
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
  limit date: Fri Feb  7 12:30:02 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
  limit date: Fri Jan 10 05:28:57 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Dec 26 12:50:29 PM UTC 2024
  limit date: Fri Jan 10 12:50:29 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Dec 12 10:20:12 AM UTC 2024
  limit date: Sat Jan 11 10:20:12 AM UTC 2025
  Status: On track

