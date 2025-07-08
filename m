Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738BC83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 17:26:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.53])
 by mx.groups.io with SMTP id smtpd.web11.2178.1751995616465879482
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Jul 2025 10:26:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vA1Js4eN;
 spf=pass (domain: siemens.com, ip: 52.101.65.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ/744qxwJW/XjKcS1lMVTFPteDpMkMzamskPyYvg8/V9AUf3Phs7rKQDT1Xhw2o6Nn1KIby+r3ra8FqMYqg/M7pXQoU2OrIjNnNu1PftDTaOtiPI16+x0s/UQMvNs69XRJQ9KBuWnVvM7vdAaf3bu9GYwdZafjsPogHHkI5nq3aUgTLnqea2a4F+BtACa2EZBZP9CQjA/QvCoCSnABKxOwKJ6rg6vJIMS0hMTnKHt8TGKBGucyL1e9Vnb9/QFhbkr21cKFxIOLbDCcxrtWxMQ0b94cKgKdH0V/3nZZpg2eEEGwxv7vrPKtQoDPfeeZNFTzG+GaFJjtJGZpFGYpOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15rPkHN9nhgKrDB2dU/Mh9ZdgMtI7A4NFX3kcuaUNcI=;
 b=Q8MXYHXGTiTZMzAmPGOB+gvtHbrh2zbsSXIz/EclWEeNzxEtfPtuNirUzxJ7rGerVJV7Cooxf815UcxJi0vh/PvLbJz/R2v2pJr3CFy1V4GVayoaT8cjuSLL1oWCCP26J7MP2B5eR/O1PDdCD3NXHnEJUIAVAUx3TmxPzAHW3BODOkvOkUST9/2zXnLCJjxxWAsnNo+8XzQxQs+sagaGOW9cpQ/NP1aeMAYHCqEOdR5VsF6Pahxaqm34FcskdEGHVO9sGoifbx38jN+3sJOHVQ8w0doM9QMmGIzvDNxBb/DyOUXIaO0Qvn3wGoqz2cyERSw59SSY8uqGihHM5Yv+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15rPkHN9nhgKrDB2dU/Mh9ZdgMtI7A4NFX3kcuaUNcI=;
 b=vA1Js4eNaeRL505zPkAzRgA6C4dUxgU0boQyZ31H2QKLMrpVcedxySuGS3M2/7YwGQK31kyeEhGQhtQbsnRSrYDneu2+186AmxPnui//ZJ01/lsnTR1eWxMSgTh9+GPUozcw9W6Pu0HaZlAE3bIFBL7JvhzZa2NIL8xnHfAD2q4oZ6TiqVnZ96yGpF5KKDGawpk1nG3924JqCwdcy2ZK6MOePH8TIVX9PAgnQOQ3KoRXljhCJ6EIZU0vVePUpfe1tSIM7BP1cPwz4YqVNCGKJGadwPMTCnDwXniNLl6qK407brWAYLTS/8mPLuwxP2LTHL369YLV00zwMm5rCNvw/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:448::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 17:26:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 17:26:53 +0000
Message-ID: <33c356d2-524a-4dc4-8eac-87eca1031b4d@siemens.com>
Date: Tue, 8 Jul 2025 19:26:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic: Fix boot by PARTUUID for bbb,
 hihope-rzg2m and iwg20m
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Cc: Nikola Trifunovic <nikola@trifunovic.at>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <a4b992d3-eb46-4cf1-8e22-87024d969618@siemens.com>
 <TYYPR01MB151324A65957196E1E8306B5EB74EA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB151324A65957196E1E8306B5EB74EA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: aa960562-dbd8-4f49-891d-08ddbe44a177
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2M5aUM0TWxucFlJdURORlZVSDdyZk4vclhYVnZIVDh6NUxNYU1YWlBTWjlt?=
 =?utf-8?B?elA2eUd3T0dlTEpuOUNWK0g1dlV3ejJ6TDd5OFY2Q3Y4dytHSTFPaWpqcG1h?=
 =?utf-8?B?UDhYdnB1SXpINUdWL3FSZ085THFZaTFUbW1zRVltSFlnV2RIWldReUZhQi9r?=
 =?utf-8?B?bDM3WE52WGI5a0JjSGdmVU9vYS8zaEU2Y3YwVm5MSElvejhHcGtTL0Z5Mnk5?=
 =?utf-8?B?U21wb1AxUHp4SXJtR2VrWTgrdkMxbkk4QlZtdFM4d29HUStiVXYvbTZxUXB1?=
 =?utf-8?B?OFJSbkxBekFhZ1BhK0JCZ1dFbnpmV25JeEJDSHZTaG5GQ2tGUW5nU2REbHor?=
 =?utf-8?B?U0JZT0RjdzRDZjdaUzlobU90WlNsaXlHcTIwdmY4b2lYbEV6L051UHY3UkRn?=
 =?utf-8?B?UGZWZ2dMaEx2WmFQZUJSYTFzYnNacjlUYml3YlVGUDcwOElVaXZrNmJxTjND?=
 =?utf-8?B?cXZQcmtpYk8yWmdrRlRTQ2VTOTJTbkdwYStlSFpnZTRSNzN2YU5QdnkwQ0Vi?=
 =?utf-8?B?K0prRlAxMmp3R0NlNDhMTTJQYXhIcW90U1dwWHdVRzF5L3JsSVFwbnhFYVRY?=
 =?utf-8?B?RjRXVTRMS3NHeFcrejR4aFVrNzRwN2JoWGw5RVkxVnlsMDlOWDJKTE5ZN094?=
 =?utf-8?B?ZWl5VGxNRmdhaDlXT0x2RnlaSGx0V3psWHJxVElQY0JzRkE5K0g0ZStHNGVU?=
 =?utf-8?B?cW15c3NtQ3B1V3ExcEFyS3ZDYmFGTGNPaDkxK3N5clVVUkRZTHNLVWlxYjNu?=
 =?utf-8?B?ejB0Uk9nQkRaQzlSL3ZhLysxeENkbm95UUg1Mk1oWjRJMWh4UThRWkFia2V1?=
 =?utf-8?B?NUdaVUx0U2ZnWDNMNFFPb0sxT3BFZGpXOWtZRGYwcU5WUTA4eHJDRUZlZnB6?=
 =?utf-8?B?SVozU2xkbUJBVlF2Q1VJRHIrUForSmdURVowOTE0cTJsRGx6dk1adjhCVXJM?=
 =?utf-8?B?dWplRFZXTHhZTFgzaHRJQnR4OC84d2xVVEVyMjVmVjNCSXU0dVdjZGxOWnFw?=
 =?utf-8?B?cWlxUXFwSUIxN1J5UGZFcVBXUU9DYWw1dFlXZEtGMkg2UGRyMk9iZTdFWEYx?=
 =?utf-8?B?cU9ZcHppS3R0S1VUQm1tMGRmVEQ1Rjk4SThOUlo3ZzRMUFBPNlppMlkyTzdi?=
 =?utf-8?B?NTR5TVdOMVpPN3U3c0FGSnVkbVBHdnBUVDFnZ1Z2TjNwTjlpaklxYmErWkhW?=
 =?utf-8?B?aGgzRTRVdDR2RGprVnVrS0JTZGRweFBrdmF1QUdsM0RYVkc1SDFlcjZnakpZ?=
 =?utf-8?B?Z1psYnY1NDRnV0tjaTFuckc3NGhwS1lwQ0RoWkF1SmkzcFQxQXlwd1JzYVpk?=
 =?utf-8?B?OE1ORWZMRU1xYWtoMDlXUWs2cWw3SXFXalNLTFFMZFc4U2xYZ0JWai9aV2E0?=
 =?utf-8?B?NGZOaGdjdXNESFpuaUJFbHE3YzJrUVFjaU1ZSk55Y1BQeHlDVlZ0bytNQnRk?=
 =?utf-8?B?dkFFNUIzS3Z5eWJ1S2toWTU1WSt0bk1HelA0R2lDb1RxSk9iZzV4T0RUclZQ?=
 =?utf-8?B?MnFINi83bW1XTTRCc1ZadVBxaWhLMThFSVJtYlB1eTA5NEZMRWgrRHpxelFD?=
 =?utf-8?B?bGp5TFg2TFpOR1lRRjlpUGJsLzBpTkRpOGtJS09yYXFyYTYzb3AwdmRmUE40?=
 =?utf-8?B?MDB5OWJVU3pqNmsvUXJ3STZQUHEvQlo0K2VNT1grb1BpTE05bm5DYmhrbnhU?=
 =?utf-8?B?RXlpVzJIaEVxMldCTHRwWFdMU0d4T3VVVnUweTFaYXZSMW1FT20rS1lDU2p5?=
 =?utf-8?B?Qk5janYzZVNPZTljQnJFYmlyVFBHVGdvcEZ2ZEx3eWVTWUNjYkFLSFdONm9n?=
 =?utf-8?B?b1pTbmdDYnJnbGhiTE9td0F4NjZlRTZQdmJxYlVMc1ZmQkJzNUNadmpHb083?=
 =?utf-8?B?U3lwMDY4Y1cxTWFGc3k4eE9YY0ErbFJuYityYThDaW5ST1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHBON3lwVTB6TElRUFRUS3ZPV0hBZG1nUGpCUWVVVjhqUlExQzVHTEFicUor?=
 =?utf-8?B?ejJUM1gyRk4wd1pmbUJ0OHRtV2pvY1NxUGV2bGp3c1lvZkZTcXRLYzQ4MWNF?=
 =?utf-8?B?YWR5Rmd0clhVUEdzN1lqVXJKYitub1MyWHhvQVpGTW01OXFzdURtcWMybzNZ?=
 =?utf-8?B?QXJ3ZmlNbnUwem5wc05id21MTHpFMEVMaXRCYS9FU3g1QkdGbDBSVkxIQ3g0?=
 =?utf-8?B?RTg4TWNBcDdISnUrWEdEZjlpSm1leXRXTlpqMjlwK0ovSlFpUkNkZUxteVRT?=
 =?utf-8?B?N0RDN2svRXVXcW53dmxDc1B3a2t0enU4NlYybnJWRnVxczZyZjYwdUJTRkND?=
 =?utf-8?B?S0Y3RmQyaFZldlg2WUhMblUrN3k0ZlRkdzNWdlpXNDlvTnZDakxJL20zeTc0?=
 =?utf-8?B?d29HcTVwS1lMZXFrV1hDa3JSSzRRTkpmQStSUWF5YW1ESG85NEdraVUwVDZJ?=
 =?utf-8?B?a0pjMjJuK0hVbURQZU5JbGRIV3ByWlFwYStleXpuVnlhNlZmVFFjR0h2SzUz?=
 =?utf-8?B?Q1h4U01yM0xuMkRzaitNZzFlOFcxZVJGdDFFZ29jYzVVV1pLR3ErZElDNnBZ?=
 =?utf-8?B?UFFnZ1hjZHNtODh5VFJxN3Z1K2VES2pTZFNXVmdXdDh5QWdjMzIyV0VDL2dq?=
 =?utf-8?B?eHAzcWcwd2Y5TzV0NVJQOSszMWZaV3IyOGY3cTJkOU5HRGpPMlRoL1JGKzV2?=
 =?utf-8?B?Z1gyZjR0L0ZGUDdLTEdJdlZmUTl1dHowSGRoQ0JHNkN4MkxHZWx4aFV0eFdu?=
 =?utf-8?B?bGN3NkFVMXJDZVR3MmlxY0hhRzNwbGpKYTk0bzkySm1EeTlzNXRMZ3NTSC9h?=
 =?utf-8?B?ZUl1RGdPY2t3WmJTTzF2OTlTUnljWENPZFI2Rk44SVc0SXFrRnE0ZUprQ0xE?=
 =?utf-8?B?dS85cVlZQWNKVW4yZ2NNQS9wN29FMkdMd1ZsTU5MY3g2WDhiY3lUMzJnQTdo?=
 =?utf-8?B?UE0zNTRlZi9rSWRKT0dNbUdHLzFXa1c4OExsY0I2MTF5YzhkaUNLdUpaZUQ1?=
 =?utf-8?B?UGEySTMrdjNHSEdtNHZIV3hNa2F1WkJkSFAwS29WamlvbW5lSzBHMUZDOUZs?=
 =?utf-8?B?VEt0NU1RNHJBK0ZXVjJRUXg1OUJ5eHNnZWszTklvOWlIQzJMMklqNFdDYUU0?=
 =?utf-8?B?QUIwd2ovRk1mcEFnanJKR095VXpjTHhYUUNyUFppWmxLT3Uybm9ZN3orU1pO?=
 =?utf-8?B?d1BUbjBGa01KaWk0NS9pcHV6ZTNNemlsMVg4bnhaNzE0cGIwdWNzSHRlZGRv?=
 =?utf-8?B?QmdteWo1MWxNOUhZeFZ0N1pLTTJ4akx6dzIveU5FTjR0bU1jNTdXMUlrb0c3?=
 =?utf-8?B?RXZSNjA3TTZja0x1VERjRmtUR3V4YVk4bEF1a3VUNldoMEtSd1p5RkNtOUxB?=
 =?utf-8?B?a1FqczBtN21GbEFQck9qd3RQdkNSZXJuZWsrUzE1YUIzYm1Wdi9EWHFSZzNl?=
 =?utf-8?B?T2V6cVFuU3JCTGJpblVGSHZFSGttTWhlSXdydjdvdWhKbWlzeFhFcStoVmNt?=
 =?utf-8?B?MlF0ZzhLZFRDL25lTEVOTmNDL2tJVmxjakp3VEFacHNjWWNwQ3VsL1loZnRO?=
 =?utf-8?B?akVYb2hJNk40WlZpK2FKa3h3UVI2ZjVFR0RSL21ybHNWYWZWRW9HUjY3blV5?=
 =?utf-8?B?OXBaQlcvbDJvUlIxdC84bEkwU1p0YkU4MTRyMDY0Q1ZJd25TY3hLUnhhWlZ0?=
 =?utf-8?B?bkVramlrVExhQUxQaHlINlZDWjdCQ1VUMlZmSjlhYklpMjNzTlJoVU1PZEZn?=
 =?utf-8?B?OTlCc2s4RUEySmM4N29TbWJ3NnloNVhFR2JZakxMYUdPYW9VQ2txd2RrWVdH?=
 =?utf-8?B?ZVpXaE1nQ1RyNHkyQ3g3M0VRNUxqb293alZKSlA4NFh5d04wU0dpZ083Ymtk?=
 =?utf-8?B?UU9tMVhhYzluamROMC9NMkZGZE9NQURTS0xwVEFCZmlpT3JCMDVuNnJqTTAv?=
 =?utf-8?B?VVlNbzdDRWRMK0Z3UnJKUENiaDlvNkI4ZGRValFOQ0dzMmJ4SDJhUnhSRmp4?=
 =?utf-8?B?WXZ6UFBjdGo4YldUdGNKVnNQSmFGaGl5UnU1TzRiWml0dmtuM3lTUnN1U3kz?=
 =?utf-8?B?ZHBTY0QzRHA0QVBnNWI2dUlSNmdoZmF6Y0sxM2ZFSjdBc1g0Y01rYjJSc0dh?=
 =?utf-8?Q?uGTmeg9OiqT2nY9RKHZ1O2eWE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa960562-dbd8-4f49-891d-08ddbe44a177
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:26:53.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8szN3phXMpCi2yJubB5C/i3gQ4vr6Mw7KxoALFAziWKjId5h5surQysckko11n/vF7TpV4+eqfqvFLB7lcy+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Jul 2025 17:26:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19389

On 08.07.25 17:52, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 02 July 2025 08:08
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Using a full UUID for rootfs selection requires a GPT. Otherwise, the
>> partition table will only store a short ID while the initramfs is
>> looking for the full one.
>>
>> Reported-by: Nikola Trifunovic <nikola@trifunovic.at>
>> Fixes: 38703cb8e44f ("wic: Set fixed partition UUID values")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> I don't have the Renesas boards in reach. Could someone confirm that the
>> U-Boot setups we aim at with the integration (not covered in isar-cip-
>> core) do support GPT? I strongly suspect that, but just to be sure.
> 
> hihope-rzg2m _should_ be okay, however iwg20m likely doesn't have the correct u-boot configs enabled.
> We'll try and get both boards updated in the next couple of weeks to support what you need.
> 

We could also address that via documentation so far
(doc/README_iwg20m.md). Actual on-board tests with isar-cip-core are not
run anywhere right now, are they?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

