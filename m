Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D0C6FA8E
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 07:03:38 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.46])
 by mx.groups.io with SMTP id smtpd.web11.9388.1677740614206986320
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Mar 2023 23:03:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fkMfKQ6q;
 spf=pass (domain: siemens.com, ip: 40.107.247.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwUbN8i2z8VYHCEjClsRKWoxUhYtH5Wd/WHm9kEFa5IaZfwBD34C1HlBRpiX1qSV2IWW9qZ+jd5Gj3AbontP/JBfsRHR3q5ekEPYbWYnyLcSW/ivX2xYu49yZGRMu8P8UNI8sQLBKpiWfoTwVgSa7m8e1W/Vo2GXG//6/tHIJf7KlIjNk8TaBKV/+j4PS2zb3XnJsfqGVKp1o+jjL95zw/ZprFWjtwU6BBGlNLCZuLfIycVztz5wy9LNEjeHQczd5xk+bUt8ee22uhv2RLyuKGws0to6OJLVkK1CEZUiYkRKMRb3nXeOsQSweHXKBdOSksO9/Dn5eSJ3MGuDefP/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZgCOLj+DnV+AnsIT+crFscqWuE5o6xBHTRYtuSVSyQ=;
 b=obnhRNyz/q0fKM09UEmajyhgUP+Sgiv8VLfQgiFGT10nQc25FX5m0ToIdxTWyz6U9KoYpCD3P/xI0GaFVi4e1VCtZsxtbLTopxHgLGdNGh9NVAb0PRL9ASBVPUlQL6qWTzN6Do9HH5lzyvCgD//SuNB9fxmXY8i5DGRhzYATwL5z3DjgJG4zNyw1Le4k+cBgdiMRvfVHBvgMK2URZ83NkbstDveGLdjLjpIdYoJl5fT5uWgp0NtgP/Br17OERxAJqZMSjZkqX1ehhPCBPxwmz9lc65v4dhYqbzxfqUOR241Rfs3asy26adtR+XVJuAcFuFqPNXgAOdHQlFiEWpKAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZgCOLj+DnV+AnsIT+crFscqWuE5o6xBHTRYtuSVSyQ=;
 b=fkMfKQ6q/eB+nnILB4rHV4vlGVro9b0UVYVnAwGCKBjBhQs+CdCS+x9WSKfx8JOlTvMGpT+zKe4R3NEijodvmp3/p2axNkvnvoOoZY7T+/GdezG982bfU9Ev+83G17ZMT3NvIcQm56091O0BKEjNWqpnHTZUBkK9Lpxtragk0RWyzKiYsUiCFenRL1ISnGtDAwIFChSv9pvhm8Ywjcv6Nd1FOaicOb8v6klVLVMHQ87mwfZKrUNIib7lihbegl86WaGyX/U84Z13OAQ4ePeO6G5EVq2Q8pEzOA5sazFD0+ozoHEQqdpfU7op83MxuiQfJneLGFl/lvT+Xh7MeMGKaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Thu, 2 Mar
 2023 07:03:31 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::594b:ae3e:61db:a398]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::594b:ae3e:61db:a398%6]) with mapi id 15.20.6178.006; Thu, 2 Mar 2023
 07:03:30 +0000
Message-ID: <685613a5-0a92-3403-2051-aa2b5fc01034@siemens.com>
Date: Thu, 2 Mar 2023 08:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6fc980-9724-498a-efd1-08db1aec3af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MoiM36k2Utvk7i83llt4kEe8655Fz9E0m8dfLy8/SuQRdkcfP3CEl2uJrmpItCbxmpnNntWrL5YTNcqL5loJwrQ5mpUUrKUHo6OmqQbp4uydIfZ8E5FiNMmRjo1R2CZHUxM6XjGy+4vIdnKwH3pk+5QtLuqcPLdHEht8fr6/fWptxyQTTMhu4QNgkqOJ7uRHMepwyXtOpdLuTkI8RizKWKPzyMt9aeIvFzdRMaAd4konowzfcw0tcW0kuwVXL/GJIFHGu7MNP7e1J3We7IgT3Fl1V77oCbe/tj8NYah4Rxlp7okGpzctiUFZHiZaLu7FwZO7tNrqXjytSXsDD/6IKvlgCtyzOM7xndH0Adx5qOCGd+1ye4dFicOXGgoFErijs1TSB4XEJAKw6x0JWnInYd6L/Yao60TSqsJZjM1ADQu/nHAn0/dTvoIZ9xb9BnFG3P4RljDYSnxOAljm1Z4RRCl+CeznH6V5WLUVCJ6obNnK6xT6u0ToThCWLQ2+lfLUqOUG6JqqR+J6jzu3dXtOXvkTfjQl75JcomgC0l6Wdv3HClU8S7xBDhzPrx4MnTikkzj5KP89ZWy/Lw74ZyDwbJSNxPUjEUrulmfxGkjpAW4nKUKcJ35lRdM0UzxDGQYYlOrPyPjNJC9olt/MqTm49fZsNdljlMc+qtouML5jQQbtIlext1kWhJ2gSsw7S3PKw87718BNnnvgNnlolajiEqJVptFjTOaDb69bLDIYxOBgIsdPzUHT38hLVfF2hY5/ccoHJ2h+Vd6eIui+lPCWEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(6486002)(966005)(186003)(26005)(83380400001)(6506007)(6512007)(2616005)(2906002)(36756003)(316002)(478600001)(44832011)(41300700001)(4744005)(8936002)(82960400001)(6916009)(8676002)(66556008)(5660300002)(66476007)(38100700002)(66946007)(31686004)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmluR3VFMVJFYy8xeU9WZy82eXdybHdPcTRsSS81d3NSSkd2dEFmQjFPZ0JD?=
 =?utf-8?B?Q0ZtU2NRZHlIdTYyRzZTMEF4MVdGZjhQSzdXY2JGdDA2cTF1RWZxSUNmcEcv?=
 =?utf-8?B?QW9zeUNrSFFoL0RXZW9xSFpOZXdUQ29zMjZ6RmcyZUJmclNFK29BZ25YOWFR?=
 =?utf-8?B?UzQ3aTJ3MnFNV242TTVHMm9wS1hEUVBLTkV6elJmdkxybDV1SjFqNFl1WWlW?=
 =?utf-8?B?RGhicTB2U1FTdllHc0NqVVJxNUw3eEl0czIyWGdhVHZYcFpSdS9tSVJvMUc0?=
 =?utf-8?B?YXp0ZjNMcHNvRWY0a0JUcDE4U3lkSklaaGF2bzRLcGJ6M0wybVluL2EyazVP?=
 =?utf-8?B?ZWQzTVZhd09YeVRtQWdTWEF5TllhV3ZJc2ROdHdvdjRqSXg2dmlDSkdoRCt3?=
 =?utf-8?B?ZjRuUkpIQlRRRzczajF0WUtNblNmaXRvOFJONEFKQmFBNFBBYlVrK2tCV1Q3?=
 =?utf-8?B?clBkTjV4d01zcGhKMTNGTHFUTUhWbmRtWGhoSlhEbHFyN1VIbDdNU1dQcit1?=
 =?utf-8?B?am9FUUszOHJjMy9wVFh1azhxdU9jcGhIblVMdlAxRFZIbHlFZEEySFduV1k3?=
 =?utf-8?B?SGJWVlNkS0ZQYk9YRnFtL2FmQTZpVWNnY01CdVJ1QzVaRTNSMjdCL1k4Q2xR?=
 =?utf-8?B?REJmSVZsTU1iTjd3SjRic1d2Z3pRODVZeE1RaE0xOFgwQS9MMXN1cGIxN0di?=
 =?utf-8?B?UU50bFlQM1BCQ1ZyMXZRSFZUUUxVb0k5dVZ3QnpUYjEwT3hvVkExc2phTUdR?=
 =?utf-8?B?ZUJ3S0l2blFqejBXMStWNDF6WElsWXIyMkV5aE11TUpqRVdBU3JYem5zSThu?=
 =?utf-8?B?aWd4bjRlZndKZjl2aUZMamxSUlRrdW9Xc0lGMlBzMmVNM2tISnFJYitRQytD?=
 =?utf-8?B?bUZ3VjE1VEJOeU1ZVEhZUkdYQXp4Q01pTDBlVElzMTJsOWo2blBLTWZoVkdh?=
 =?utf-8?B?d2tmSWFqTmhnSFM5Q0dVMWdqM1BhZlN4Y2ZGZXBkd0lmekdnNDc4VjJPYy9p?=
 =?utf-8?B?emdDNVcwZzNoV2RXQlNkbzhZSzRrYk5OSFcwcWYxSGx4YWZoWXhJVmpMYThw?=
 =?utf-8?B?SjhHT2FncDhOWlc3Z1QwSFFEVkVMdDh3YUhSUTFVa2l6S2RiNEdJWmg0WW90?=
 =?utf-8?B?WDkrMjJHOGVuVmJ1MC9lazkzbGlVTTFOOFlDRThLSy93VFpOYXlBbTVENHpi?=
 =?utf-8?B?OHlmUll5Q0V2WXNVNFozZ2ZaMC83QnpYNFQ0MERucnlSMFNUSzdqOXdWUnlt?=
 =?utf-8?B?aExSRUVpcldnWmJsL0FqOVdzYkVnMllYb1grdDIzMFNIcytTbGV2ZSthdmdM?=
 =?utf-8?B?WkoreVlrUzNtbHUrRjhYeHpDcWNta0xwdldrTU9DMUVMZ2JBTmI1SlREdS9W?=
 =?utf-8?B?Nkx4MXFwbWNxUzJFdGhYTkRCaTMzblRuK0ZseUhrdWRDZWRlc0JEdW94cDZR?=
 =?utf-8?B?eDJxUy9PMmVKL0xlWlFuWFAyUmIrMWxXNFpDNi95ZEt5ZUlmaFhWZmpzWVhO?=
 =?utf-8?B?YUh3SkJCZzV1MVpaVzYxMFNJdHBlZDc0S1Uvand2SUpuOURFRWFkcTczbFph?=
 =?utf-8?B?cmtqQWhMRGQzWG4xQXBqVGJ1ZXdyWER3U0dWQ0g2bmcxWDkrRG54VEYzQlBP?=
 =?utf-8?B?dzF5SFpKdjN5alhrdHVzTnNESlc0SzJGRi84OFpSUU05VVhHWEljeEJlN1FD?=
 =?utf-8?B?S0E5RmE3Ni9DWU1nV01SRWFab1AzWG91TGNjN1hrc3F1OHI5NThFYy8yUE1n?=
 =?utf-8?B?dzdVT0E5alNLN3pQd1M4T1dzaUEvRTZPTzZDK1ZQNEVSTDlhM0NhN1VmdFpl?=
 =?utf-8?B?QWxQQzJLaE83OFV2UWJCejFUK1Ava3k5cHJpZHcwNlova08xNVF6aWpCdTBI?=
 =?utf-8?B?SXlJTjY1b1FsSHp3OWtzMTJaaEdTa3lVcGxYVGZDRE9vbFNaY0NhNi9EcFZh?=
 =?utf-8?B?bFdqTkoxUlcvZC9OeDBpU3dvTGNwb0tXOThqMHlsaXVrV2ZUYTZVbWhqUDZu?=
 =?utf-8?B?VTVoQjNKY3BiSnNibUhlaEM1YnNnS1BnSXlNblJTUTI4a0ZQbzFpWmtkVURI?=
 =?utf-8?B?SFZsSnhwZ3dNakdsRnc3MitlOFdtZG1HbGpXYTc4b1kxNmdmanFudms4NW5s?=
 =?utf-8?B?b0MxZDd2eVZIbEh6RW1uV3VkOWpYSy96cUkzbGtaSkROQXNrQW1NNS8rUVNC?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6fc980-9724-498a-efd1-08db1aec3af1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:03:30.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7+XZ6VjA6OIMaKLww2hfxUx++H/tmZBHkItco3K8J9QzOLDnkbHB0fg9YivgDaYG8ERSArA4szeVDfK+ZzjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6843
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 07:03:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10872

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=3&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/02/cip.2023-02-23-13.03.log.html

* Action items
  1. enable more stable trees for testing (patersonc)
  2. report 6.1 test plan to LKML (pavel, depends on 1.)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

