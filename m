Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F9C9EC94
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:59:13 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33194.1768226347400208900
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 05:59:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vxcd52V8;
 spf=pass (domain: siemens.com, ip: 40.107.162.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWE9x9soYtEhIvj0d05WMiCRuB6FUWZJLTNMkrAec5eWNNJzUXxvXKsWusgcwzoPbdhoudsPDQs908DJKcyfYlyhG2mZrbRzogFSQzI7x6DuPu7fC0j+bryTfmLtkuE5k35JNhsYAbGRFWiCyX+95izR7FK/SFW+jeOsAvbUfQvquSG/Fjjyk/1DVJbiS+Fxt7+MG+eR8RgtAlXMrP/gi78WkDHTQnJBIdnaLzu/FPNmIR4AAFepRzRuoQBs2RoaKsICggT87grc4EfAm/WTyb23NSNFx2m2zX6Dt7Vqg3zFPlH+oB7opuc5zc6geSqJgps97HE2DvU4Rq+PyWt7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W6V0ijtJC7DzMXwiIHc9fnM5dfJUHpWC2yp6X/Um+c=;
 b=wHROoh8+9ZkWLFN3G+0QxMuLpubLEwlhn+1u6v09cc5LYJILEzE5TlwXShcRZWbkTFZ14nclwZq43QHn2XpWTIb26RQWIlQOelMhbXE3CVJodxle+bhmzjOGlenjlBra2S9UIn5zTAtn8WD0tzblbPz9GfUVw92k/V847NI47Mbg2dmX9ZgqKy0fz9+gn/sa2dS0mbb6XInyk9Cead3isdZDurGAvgQJ7sGyjNKyXW0U1C6k+kHteYDjZBYtBwSE9nYeuiyer0VhQMlLvx9g42Fqe7H1ETIv9SbJcL8tGOkITkPffuA9d73YOhN+JZX3tjih7QplCTWta3qukLAA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W6V0ijtJC7DzMXwiIHc9fnM5dfJUHpWC2yp6X/Um+c=;
 b=vxcd52V8HIFnVQQelZthjIinWwB1hgopXsvSw+cHQTum8IdIMdPH29eAzg++xCxk0BeT4oZJJcrjuJ50L8DO2iqpUEr9EdTHRxAXalhnx0Y8oWCEmB9R+4q90YoXNxlZYKkMibfjb7pB1nAjm9YIZci8MScx4KGi3GZmsxRqcfIgQNgseAJTTe7F/vJhaqOzGtcsYCQ6k/rdtGLunBr3/ikURZ0nHHV3arFZL8ftkv3PE5oWDZ+sZNnLQYbuEitGK7E0dZy0dGPZg3uNwa/HkjA7OZJwOz4Hgk9y46/TdSo9hPtXzTtGlRnfZN6RpXOBWX+eDuNmU5WhYS7iy+WyBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:59:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:59:02 +0000
Message-ID: <b211ca2c-033f-427f-ac3c-9e9d2a16acf1@siemens.com>
Date: Mon, 12 Jan 2026 14:59:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v5.10.247-cip68-rt30
To: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <aWLVHnFYQWsNWmjj@duo.ucw.cz>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aWLVHnFYQWsNWmjj@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: d782b7b9-1b17-4f42-9906-08de51e2be10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YjJHSGtVSjJIbmxnS21JRS9FdDN4dFJRWXEycjJkMFg1dnBRemprUVZEaTB5?=
 =?utf-8?B?cUg1bTdKYWE4ckl0dks0RkNxQ25LbDB5ZU82bENYV0svRm1QRTRPTEFqNG1s?=
 =?utf-8?B?aTZZdVJOZXNXS2ErY1dldXBWMTRTem01RUVXR1VTSTlSRU80VEUwV29KMXk5?=
 =?utf-8?B?dm5pWlpXREdKNXBpaVVjQVVhSXQzTm8rb0JPWXVDai9SOVJFK0NoSnowSy9y?=
 =?utf-8?B?d3dFYWZ6ODA1ZHRucEU4VU1DSHkxKys0YUs2SWJPaTJYNDBKQzR0STNtbTJu?=
 =?utf-8?B?SUVkSzBINkdPc0svVFNvcE5taU42a21LRG9uUnh2VkdLNFJodGZEUGhpY1Ft?=
 =?utf-8?B?eW15OElUZXJYQTlLWVVRWVdia3FDc0ZZaitwY2pZZ3VEUE5vNHNjNkpwbVdi?=
 =?utf-8?B?TnpraUlyUlJQdU5Xd2h5RTBTdHJucDBwOFpPS3JnUGE3cUw4N2tBWXlKM1NJ?=
 =?utf-8?B?WjVIZGJLTVFPWFFOQTNHcElkSk1wYjF6d2VmVHk1U1VsWmthT1ZlU1drNCtx?=
 =?utf-8?B?bEkvaEtWNjZ1RldGUEtOOUFJeU84UGo2VTU4b1Y3MGhQVnByZENOTkozN2hk?=
 =?utf-8?B?RWt2MkRyZWhQV3V6UGpSTmpYZnZCL2J4Tk5SSzNPUXd6UWZyRTZnNm40S1Ra?=
 =?utf-8?B?R2RhU09Udy9ZSDZObytWSFlOalc2L0labGZ3Y0lpTTBPZmJmM1lIU3JaNkp0?=
 =?utf-8?B?QzhiVXlBVTRnU2tWSko5QVgrVW5nQWFLUzVsUHZmVml2OEN0VnJhMHNTNUFF?=
 =?utf-8?B?Tnhva3J2RzhXS09GNEZhSUtiemdHbTBNMXJBUEpYWEN5M3kvWDhJVlgrc3pX?=
 =?utf-8?B?VFBrSEVaTG9ackJyYW9IU3VkRFhNcERhcisrZE5TUDVmcWFxbDJzSFVUU2lP?=
 =?utf-8?B?QUFQVlhqeU5sNFl6UERQTUwvdzNmVnpET1BTcUh2cTdlMm14ZEJYZjlvek9Z?=
 =?utf-8?B?U2QrY3h5MkJ6UGVYL1l3ZWovWHNQWi9uck14TlV5bzZIQ3BSUkRBNWlxZHdJ?=
 =?utf-8?B?bEdqRHNWdklxUUJqblRjNGk5ZVhXSHFqVW04ck8vNWp0Ukg1cVlMVFc5Mm1J?=
 =?utf-8?B?Y1BZU0k4VjVGQVNOc0gwNGJSTnBMcWxmbjkwZVhSeEd3bkZEVFo2N3BXajJ0?=
 =?utf-8?B?UEhhenkxTFJ2U0hlTituVTRoVFNWZTg3R3BXMUNyc01uWFlnRWNDK1ludTRv?=
 =?utf-8?B?YnBsbnlIbXBta2ZtYUpRQzQ5SjQ3OWNHOWhMQlhjWlkxbmppR1JXS3I4M2Vr?=
 =?utf-8?B?ZW9oVHAzRzNZM0JSQ1lXU1JyVUZhcy9oaG0zZ1hzRU9NMGxIZU1Jdmk3clQ5?=
 =?utf-8?B?VDRaMCtTWFFtd1p0aStYUExhR1BlTG4wUlZVRStubVZuMGpORjNPcStwc1Fy?=
 =?utf-8?B?SjlHZGJia1lEUG5jbys0ck52WEFPZitDaGNFaUFtMFd5NFMzbVZvVjF1SDBG?=
 =?utf-8?B?ZWNMQXhTU3hieGpHRG9kYVZXUWlNRVJ2UzlkdGViK1dnUmQzY3ZQRmRLRGcy?=
 =?utf-8?B?WUhhL1ZQRXBKNTBIMGxDT3llQXVzSm9ZTnp4aTdHOFJEZGFzdFJxc0dPNENJ?=
 =?utf-8?B?dmN4V0ZEYVdoZlFpYVFMMjNLUkJ2ZlVtTWYvTy9TaXdkTldvSjJncjZRTnY1?=
 =?utf-8?B?SEk0S0RQNDJkUUFwQlFZMUlmUThUMUdDQWE4STVQSStybnd5UUpSNWkvbGh5?=
 =?utf-8?B?UG5XZnEvRFV5Vm9veHdiclAwQ1Fua2N1YklsbGo2Ykw3dlVhdHVKSG0zZlhK?=
 =?utf-8?B?N0VhL2ZxZ0hVcVZMWHlEbVpzdnZ1YVhxdEQrdzB1Ymxrczd5cWZNWStVblB0?=
 =?utf-8?B?U0M1UE9BT2VRMVBGeXZObDI0ZE1lQklEVmt0NmMwY2ZrbmpEWnlKbWNMWTRR?=
 =?utf-8?B?eTNLbVNjcSszM3l6L1NuY1RTb3VvclpGNm5oaGRsNTdlQVRmb1NGcTlhQTVj?=
 =?utf-8?Q?trYf4dioCccpU/INfHbrtekY/oxeghMF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEU0b3NTaElNZG40TkQ2MU1FaUREeXlSMnJRR1FsdXZJOVlTMzZoSHg5OXhE?=
 =?utf-8?B?R2p6K0JUTXB1Nmp1aStJRnEvYUs0MDA4THcwV1dGZkNuREFlV0VuekdpZVV0?=
 =?utf-8?B?ZWxCRnBWdk43LzdhcEd4WSs4ZUhaVTU0ZEY3SUJ3UFNUZ2xVRFFVQXhNUHFR?=
 =?utf-8?B?MFcvblBVRHYwVWFwM0ZqTjdHeUhRekw3ZjJrY0JiU0V4c2t6OUVDNTdhWGwv?=
 =?utf-8?B?bW8vMGlUK1RNMXc0VXVNek9Zd3V6WDY2N3M5NnJzcE95UkkrYjluZjBBUXlh?=
 =?utf-8?B?N0IyMmFCWW5uZnUyV2h3VE0wMFdZRUVrVUtXTUI5aVRQOHdlMUtnL21Sa2kr?=
 =?utf-8?B?LzFJVExmNjM1WDljbk1JSFh0ampKUzZMWkRmeEZlZ1hBQ09jYW0zcmpxeFdq?=
 =?utf-8?B?UUJLMEQwcjViamY2eEJYWHNUM1BkT090Z2RFYy82amJjZmJLNGVHWDU0dE1h?=
 =?utf-8?B?ZUJOMjA0bnJ6UUxtSmsyM0tYTnN0eEdXZU1BcWNmRnVwaWsrM0UrcUNJcXQ1?=
 =?utf-8?B?ekM5Ykw2RGdabC9ONXZDVmYyblU0TnVvbEljZUtZUnRMbHRFMFAvb1Rxd2ht?=
 =?utf-8?B?TXVlZC9SRWVrU1E4bUdEaFpIZ3puVm9qODdLQXJzY29YMjFJWDJFcjN2c1Zo?=
 =?utf-8?B?YVRUdEpnTTdidXlLWWdtR3pmSTAyQVNDR3BST3dSR3pGamlZRHRqb1M2K3Fn?=
 =?utf-8?B?MlpKUGx1QkEyOEJZWkJjKzdtRVRqQ2lvTktVc1dVWHVZcEJEZlFXNkd5a2Rs?=
 =?utf-8?B?bW1qNkV4bVhyLzBKOHFBMkRTdHdyazRpOWU3WGdaa2hSY3U2eUxvbVN6LzJO?=
 =?utf-8?B?OVQ5UTZUbmZPSy9QRHh5SVJaN0lXTU9oVmFOdUZIVTU5UU9FQ09TM3crUEEw?=
 =?utf-8?B?cTVpZlpBMEJoZTVHa0FMTzBKMjVMTWFmb05RZXVkWVFNOEtBTTVsazg4ZTRP?=
 =?utf-8?B?RUxva0NJNlNBMW1mTisvc0xRTkNqZ1pGakVxcDRMSkhtZ1lMTzBhMDhoZk56?=
 =?utf-8?B?cXROeDE4MDd1cFJQZTJ6UUJWSk5majNwWmFhcCtPa21YMzkxUzA3Q0pvOFhZ?=
 =?utf-8?B?b2x1U2xzNHdkVUsrUnlvRExRNFUyMHplQ3lBNEZqS0ovVVlRUGxjMnFXUFNY?=
 =?utf-8?B?OXo3ZElwMStId3o2RDlOSldDTXNzNE0xem82VDFKb0ZKUnRCc3N3aG9PdDhD?=
 =?utf-8?B?Q3FKNjNKV1RxZ0ZieExITjA3bWNyRWpmbTFyOTNOYWFIZHJ0Qk5zUU5OK24y?=
 =?utf-8?B?U1ZXSkJ1M3oxbE44RTNYRzFxUjJtRVFSbkJEY3Mza2J1RlpLdHA1NDI4cGhF?=
 =?utf-8?B?OTY3bXNmdkRnNkl1elg5eDdRU2haMUJLVW5NOFMrMERuV3Z2ckNZUjRoY1lV?=
 =?utf-8?B?ODUzT3EyV1NuZmJHZS96UUh3Qmd0VTYzYkE4TTF0blZjR3g4c3VGTFpqV2xN?=
 =?utf-8?B?RzhuT1kzdjdNazlSRXNQYVVoVy9VME5neHFJOTBoajFsVHVzdFRvV1FOMCs0?=
 =?utf-8?B?SFVqaUJ5OXhwODl5S0lLK0N4QlhCN3lrbkRTLzR5MkdDRTBaVEd4NzdDU0xh?=
 =?utf-8?B?VUp4MU9tQWw5OGJydWRnVzBIcnBpMHNXSk5VVlJmOVhyWGxpeFgzTmxyc0oy?=
 =?utf-8?B?aHhza0J1a0dDRmU1SHVzZ2lla0ZReTVYOXE1dGpqeEJVZEZBeXFTQTRlRlZ3?=
 =?utf-8?B?ck1tZDNuUGdabC84ZU1HelZvZ3Fia3BvRTNrVnRFcnFkRlkwM1JhNlI2dEY2?=
 =?utf-8?B?bHlTbmZ5cC8venJlT01ob0xpNFkxVytkaDFneHRrZFNXYXhQL045eXYvd1RS?=
 =?utf-8?B?TldNeDY2MmFmY2pLYXNBeHZibUxocmF1UGVVOUFDTVUrYXlhOFU5VkRJK1Jx?=
 =?utf-8?B?UCtSMFAzMWR5YVUzdDFnbEVZSHg4L1c3ZHdzak5nV2xZYnd2RTgrV3hsRWNP?=
 =?utf-8?B?ZFdKQjFCb2w3ZHZRZTZFdDBMbzA0TzJJVE5XZXpJQzJwZG5Nb3dNYkxaL2NP?=
 =?utf-8?B?V1NhOEhidnRWVDY4alBqQXFtOHZIQUVEODBzUXI3c2ViQUJvWVNTMXRZbE9P?=
 =?utf-8?B?ZXJndFE1Umt2MW5BUGJhSW1sTzVQMjZSNHNnb2kzTnp4b2VPUEllRXRxZGNQ?=
 =?utf-8?B?aFVxMnJjRWdHKzBPdkVDTzA5Z01uMndMU210a0hDMFVMV3owcHIxL09HZlVO?=
 =?utf-8?B?M0xmOHFxaGhjRFBkUjhjdndBUHgvY0t5SENDOUJ3bWh0aXIzeHBJTTZTZm56?=
 =?utf-8?B?YUF6SzBHU1FHUTIzV2hlVW51aUQwUldpUlIwS29ZWTRQVy9ZZmdFRG4wN25E?=
 =?utf-8?B?RmlFcW1Bbjg4TG1NYkJFcWxsenhrcVY4YmZaeVd2alJCU3liUlFDUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d782b7b9-1b17-4f42-9906-08de51e2be10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:59:02.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCnqETNH3SMI9Eeo3tBMYCvRUheB0wsUBvgdu2kIHbXVa+4ilpj4s72zFW+4RX9O3jFPYBgyptU+P+cflXvvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jan 2026 13:59:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21532

On 10.01.26 23:39, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase
> 
> And their content should be identical. There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 

Could it be that you forgot to upload the tarball?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

