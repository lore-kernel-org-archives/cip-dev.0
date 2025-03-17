Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5886C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:57:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.7])
 by mx.groups.io with SMTP id smtpd.web11.48648.1742205462127439639
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 02:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pfyL3QbG;
 spf=pass (domain: siemens.com, ip: 52.101.66.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoN2rAzuiIVM3/98RjUhSchOyyHT7nYHFlZLTxv2pID/hMP7STuUZwWSEfwiiHsLfNbt/QGcYtNE3soL3Sddbj95/H3qDOHFfLSmWZ81763396ztiUWj+48RQxomcbpthlkl9dzjalaiHsNV4JMvoLQDIda0jCItVZ0H/AUNSOY1+aQySr0QtsINWi26U8OuuR1Hlta5X85txdXmTQGNwJosmfxiudKtxG/NxIsY65Sncld/VXtTLVyy54PHWgl98vvLaL+7fy8ZQS9UXYJppELWn7dAVR2MRpY1Gdj4cdp7lo91bCgBCWA6emKBt8jltymoIq55sjq23Z7kZybH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h26OUeQZrtq10lb0ZGo0Iesb8Qq0rpNZGM9S1EY2X2I=;
 b=u1oessaapEd0uu5LxSIzb04nBGF9toAXtXH/Yi2kpaQYcHusLRQ2hbNn/woKDOloqh3RDiJFGGNCLyagSjrEGAJsJXiBOI2vyIOw1dd9hPmxntQG880Y4FZvlgPhS8NkqdGjWeEAUGOx/J1CyxtbUSYmeyoZHCyIEoe6rjJdF7LTnmnjftp+BNzWERTmfsTuvZsPq/iEPCbxzyI1c2sPk4LfaUpkMcnptXH0M9b+GM8ir3gJ2hPFrd1TRLHKaoEsOjNKTuIfu0FpHdpENFHdvfW6oNZ4Vhg6kYXFiasC3PV8dN+7tu6FZAd4mHrhhF+aRtKuWMbjPS1wloHXKFPK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h26OUeQZrtq10lb0ZGo0Iesb8Qq0rpNZGM9S1EY2X2I=;
 b=pfyL3QbGk5rct+EDv4xyrMFfwaaOHiB4Pe6gVnE0vDNQFOGAR2jf4L/Nlrczsnmc9InhP/ogFZqt9Qb4st0ETuJkHfCjVzvMJjbPrILucHuo1Zr8SupXYUj8SKwqDz6MSWF8WHAAKnkwYK8BGk3iKZ7xVyyWrspVNrfOsR4I16MjD4yPLQuLKpp4cMqgIEovljDAKYDPh8RnBO6mg1CPqS0djMr/WAPpbv3/M+cXYBf5+rakmNInNqw7XFyAmki3f+KEysfai+p99A547ZsWvEFldrDUgN5S860QzxR8vTdV6zBwFnf4Y+iXnz1HyolHpctJVYSI+/4daGoC7PtA0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Mon, 17 Mar
 2025 09:57:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:57:38 +0000
Message-ID: <7554ef00-6a86-41a4-837a-183681f9e1a0@siemens.com>
Date: Mon, 17 Mar 2025 10:57:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Mailing list inventing addresses for people
To: Paul Barker <paul.barker.ct@bp.renesas.com>, Pavel Machek
 <pavel@denx.de>, Michael Adler <michael.adler@siemens.com>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@kernel.org>
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
 <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
 <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
 <e38f2f2f-e51a-4c4d-95b5-f9f952e5fd09@bp.renesas.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e38f2f2f-e51a-4c4d-95b5-f9f952e5fd09@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3331:EE_
X-MS-Office365-Filtering-Correlation-Id: f335e409-4739-4422-b78b-08dd653a2626
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U0JwZ0tOZjluaENycTJlUmxSWTdUS2E1ZHFFTXJYSzdISSswTTNzK0VXME9p?=
 =?utf-8?B?VnkvU25Sa2Q4MnpPN3JGZk5DdjcrcEcxSXA4QllnakV3VUZ1S1cvWWg1NUhB?=
 =?utf-8?B?TFJJMk5qTndsaXdFWTRqSVo0bFpIMHQ2MFdGbHVvSnBwZ0dreSs4b3ZyYkg5?=
 =?utf-8?B?aWdrMldlTmxDZVJDSGJzdjBEeTRaaDVCajkwbXp0OVNobjczSSt1VktDaktM?=
 =?utf-8?B?TVlxS0lMYW9MZStXYnhLS3hVZ0ttZHpRdjVCUTVoS1JWVlVUU2VEcy9lZ3lU?=
 =?utf-8?B?S0lIUDJISURHdms0clN1aVNmbU8vSlo1dFVSMUg4NG5CUDlVTUVuNnNQYXZ4?=
 =?utf-8?B?WForOU1kN3lFbGRsUEVkZHNrVnJmb1Jhdk5DdmVYTEhxako4QXRwRjdSZFRi?=
 =?utf-8?B?bTk5V00yWE5QaXNXM21FMXpGdzY3ZHdBeGtMek5vRHlvQnRUcmJBWnBXTVpE?=
 =?utf-8?B?WmQ3Yy9XbVVKVDFLUWtSUUoraGVMa25wa3NrVk9OdWxSb0ZrZGVoRFd3THpP?=
 =?utf-8?B?TjRQazZHM2tKb2dUWWxlenBTNmxXRkdidk1hWmRTMjk1RHFKVDRSVWlUMlBk?=
 =?utf-8?B?VnhpY0ordkFjTXlocXU2K0E5SXFkSG9xWGhrMFZoa2Z4TU0ySHFYMm5QN0Q1?=
 =?utf-8?B?ZlBiaytSeUdtNjI4RzFaQUNQeG1qUzNPMnBLMENjSEwrTjZiMGZRNkJsQ0cz?=
 =?utf-8?B?RkhEY3NBeURHSG9sWW1lQldSWG9zdmJienJWc2k1TXJUL0Z3Z3pyaWJPYUtX?=
 =?utf-8?B?TU9OUE9kcVYwZTdLUnU2eTlOcENwQU5FVWZiVTZFcGNLbDQ0T1kzcDc1UTBu?=
 =?utf-8?B?NFBaL3l5RXNvMkxOaFZaWGZMVUVtaUZVR09ST2VvZUJ0SEJJbFExbVU0aERF?=
 =?utf-8?B?OUlvOTVLeU9GSEtzNkpMeUQ3SlZ2SExGNFQ3VnhxZURRV1pDQ0RTd2dsME5E?=
 =?utf-8?B?RHlucWROanJLOG5wM01rZ0lIOHlteURJbnU4VHl3TEtNM0lFZjVqU2FZV3lO?=
 =?utf-8?B?bkFPcjdPWG53UWxpOEVXcFduaVc3WjEvVkNubFVnU2o4RzFwRWpQZk1lZ0ZL?=
 =?utf-8?B?d0tjeXlVci82MTI1TUNDTVIyNnpnM1p1cEtIaFY2WUd1WDZWS3VyVkdKakx6?=
 =?utf-8?B?UWxOTE1MMERxZWdNa2JuQlorZFMvN1BPR3kyaXgxelFXVzJkN0hOaExsTktJ?=
 =?utf-8?B?T0VTenJIT3BFc2tVNXBqR1UwRHNJOGJmSFRPdGcySGc4aFA5QXN1VWlNTXo5?=
 =?utf-8?B?YmF1by8zUFNLbW1oWHhzNXo0KzFjWXdNeU92Sit6UUtjRzF4WXJSc2lzWkFW?=
 =?utf-8?B?a3F3MUNPRFZKMGgxRGFFWXVRZDF1MnZZd29OcGlZY1NWR2pta3lvZ1BOWmRX?=
 =?utf-8?B?MitucXdVZVpLK09QVy9vb2tOQnkxR1QvYnJiYXRjajdocnZRbmdkTmx1MVd3?=
 =?utf-8?B?TWtVUldqV3VHYUh1OCttQXNuUFpaVkxTR2drSzJWY3VtS0tiM0Z3T2t2VDQ2?=
 =?utf-8?B?YnVxSGcrR0xsb0E4STc1bm1aT2VmcURqQTFtWm4rZlpGaFpoa2dLRHlPWjEy?=
 =?utf-8?B?SEFBVFo0Qm5CWlpPUGdwSjQyZnVYOGtmaGVFZDZVU2lhZ0lERW9mOEx0NXNx?=
 =?utf-8?B?enlUTXlWcytQcEdmbHk5Y2FTaG8zaFRRWmRhb2xWbXdkR2ZkeGpQZVRnYWZa?=
 =?utf-8?B?cHFEcUJmRkhlUnZSMWIvN0sxNTRaL05zUTliK2xWMkx1Tkk2QUhhelZTQ3pV?=
 =?utf-8?B?OXRmUi82NTlZZjF1dlNGSWJOaGFsM3FVYi9KNS9wbCsxYU5JUk1DVnlsek56?=
 =?utf-8?B?dXpFMDQ0YVJGUnE4czg5UWpkcVNtMEFyOTVpSG8yNjU2UnBWS283dkJRQndM?=
 =?utf-8?Q?S3OWleRGGbSKF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGNJZnpCdkJORVNpczhNN1FXbCtxemFQVTBiNnhRelVjREFvSEw1WHRUVkpP?=
 =?utf-8?B?bEF0RkFpaWh0bTZxMHB6bCtsanM1QVo0NU9LV1lwK2NJNm9XYWN3SGp0VGtC?=
 =?utf-8?B?VXV6MmtXOHVOazRvOEhZYkl5Mm01eENJajIyTFhuamtVZTJRU1RQMTE3bHQz?=
 =?utf-8?B?akRaT2FVelpCRHNuekJnQ1JwV0w3b2hRQlJ1VzN3QTN5V2xKZ1YyUGovcmJz?=
 =?utf-8?B?QlFvU3NuTzlsR3RZOTcvUVhqN3VGc1RHcnZVK0xER0t1VWp3MUpzOHhmR1VR?=
 =?utf-8?B?VmNDSlBFb01IY3dFOWhBVDJ3Z01xOEk1SFc1b3RjVGtuRzNjQ1RXWnJVOUlv?=
 =?utf-8?B?S1g3MlRHNDNMWWtIMDRIb3pQRkhFaFVlY1UyejZVMVBsWWFDQUJteGkyZ0V6?=
 =?utf-8?B?bzRyMWNwOWoyNTcvWFlCYUZJVzhkTnhjYWVXaU1yNWtaOEdTNDFIWmZ1bFdY?=
 =?utf-8?B?SVYrTGZYdVFzd1c0SFgybTZzbGRWbDVHaU1kVFByb01XWk11VlZRMTkvRXJI?=
 =?utf-8?B?d1VyaVhUeGJuam90RWZoYVVzV1FnaVVtUXk3NXBKS25tdE9HVEh0aUpQdnND?=
 =?utf-8?B?ckhPZUplR3lUak9xUG1Vb2hmWGxnOVpZc0xFdml1S1UwMndBSjRWN0lYU2tB?=
 =?utf-8?B?dXV2N2Fha2tTWk0wQVFTUEJlZU1BdW10aURlSzVkSGFHNkVMcnZnUzQvUk51?=
 =?utf-8?B?ekJYY0g2WTgrSE5jdHVmeXFRK2tCNVd4M1hDSXlGa3RJTWMxRWN5UlZPR0tq?=
 =?utf-8?B?QlZ4bm9kLzRpUjIzYTEwV0NBV1g0ejVwWm1EYXkweXlTejhrUTZUY3JsVDJF?=
 =?utf-8?B?S0JOZG9oWlR4dm5QSFhWT0x2LzVsbjdIMjUzaXVRdElnZW1nenNVMHVPdi9w?=
 =?utf-8?B?YUtKbTd1Vk5zYTl6ZGY4aExCUVNFNG5qSk4vNEdUTDFYMXV6dzVyYjNBOVNz?=
 =?utf-8?B?V2xXS2FGWEtlVnMybVpac0xmKzFoajUwNUE1ZGloNVMwMCtUblY5K2YvZG5l?=
 =?utf-8?B?VmtKTjhGeldWdi9rYXJRbzZqd2UrZVNGaEg5UUNpSmJTSFgvREdFZWIxbVA1?=
 =?utf-8?B?NzA0SGdGSUVqNldyallsdEpKVDQvNTd4NW1hWWFoL1UvUDc4RWg0S0M3VElB?=
 =?utf-8?B?NUliQ0UwRHJHUDJuSm1aQ1pFaWRhMVQvL1d2a1JCc01ycWd5Z2tTNEZhcDlS?=
 =?utf-8?B?cjNVZUoyaWRUallydThVMzR4NnRjalROZGppZ3k3ZGVNTDhJeStvTU90WmFu?=
 =?utf-8?B?Y1pOU2psZzhQTnJ2MXlMbFRSVzlTa2tzazFjTjN3aCtCb0piOEZXaG12TkFt?=
 =?utf-8?B?UlBsMFhqZmRKU3g5QTN3NTkzKzcvMnUrbDJVMlkzYS9YRVRJK3lMYmdhNjUr?=
 =?utf-8?B?cEZ4ek9CR3JJRjVFU1p0VXRLT3JiSWwrNVc0cDBzaGN4S1BKK2x4MGJXa0ky?=
 =?utf-8?B?WW4rR1crVU4zSkFRNFR3cklZZ1ZVMVZ0Tmhxcm8wU0kwQ1VWWXowcTBWczRv?=
 =?utf-8?B?bHVEVDBqR1lKMEdJU1VvWHYwTlNxRG5rODB2N01yVkNpRDJUdGZ0RHJFRTJn?=
 =?utf-8?B?RUhoWnBnNnpXS09rT0liUGdpQlFXREhqcGN4WmhNZ2FpaHZla1ZPSm0xUE5Q?=
 =?utf-8?B?U2lOWjNEWFJmdWNWQWNod3doL2E5enBkY0NGM1RpVE5MZzNLMkVnWFRxc1l3?=
 =?utf-8?B?QmFwR1J6RGF5V0cwbzZrVE85dkRYYlpTL2NTT2hrcmdIaGhoL2FUMkJNNmRs?=
 =?utf-8?B?SG9ndm45aFBoUnZqNnRDTTB5aFJTRmxXT3Y0cTdvT2VISGNraEgrZmxRS3A0?=
 =?utf-8?B?dEl3MlFIQkhjVGRzYmpoK0JHTU9jNG1sYll2QndIV0V1eHVFSXMvL01DKzJs?=
 =?utf-8?B?UEZQRUZGdlZVRS91ODl2Z1JVcmtheTNuYzgrbTUzVkZzSEljVGJOMFNlRFZi?=
 =?utf-8?B?VWo5V1lpMHE3Z3liV0d6UldNVzVCcjFSR1ZPYlR5QjFWdlRleFlLU0V5RWVm?=
 =?utf-8?B?dWhMT3dvd3lQRjUzYzFPNU11Rmg1bDlnbEdYNzdLYkhkdDNLTDBFMUFFeXNs?=
 =?utf-8?B?U0E4OVExTFYrVFZ4OUdLUEp2a2J5UUUwZjNlNTdtL0tKZDhPL0hWNjVNaWtJ?=
 =?utf-8?B?UzN6Nml2NHFZemluQmxmKzFpQU55RVBtZmcvQm55WGIyc0RWMFFyZS92NUtG?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f335e409-4739-4422-b78b-08dd653a2626
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:57:38.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tjQ3LAkEQYndhwVyBfcSZ8sVNR3ActtxbNPPTsaXrrM8xZQrbgPQB3A3pjPjiLKihZdOD/KoQEi2k/WeTMGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 09:57:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18225

On 17.03.25 10:35, Paul Barker wrote:
> On 13/03/2025 13:56, Pavel Machek wrote:
>> Hi!
>>
>>> maybe it depends on the mail client what is actually being shown to the user.
>>> For example, I see the following mail headers (and my mail client ignores the Resent-From header):
>>>
>>> ...
>>> From: "Pavel Machek via lists.cip-project.org" <pavel=denx.de@lists.cip-project.org>
>>> Resent-From: pavel@denx.de
>>> ...
>>>
>>> Do you mean that with "invented address"?
>>
>> Well -- this one is not my email address: pavel=denx.de@lists.cip-project.org 
>>
>> This one is: pavel@denx.de
>>
>> I don't want people to bookmark pavel=denx.de@lists.cip-project.org ,
>> for example.
>>
>> We talked about it on IRC: http://ircbot.wl.linuxfoundation.org/meetings/cip/2025/03/cip.2025-03-13-13.01.log.html
>>
>> The mangled address + reply-to to the list means that it is impossible
>> to send direct reply to the user, which we agreed is "not
>> optimal". From the irc discussion it looked like address mangling is
>> now common feature due to DMARC/DKIM.
> 
> I don't tend to notice these as I fetch messages from lore.kernel.org
> where there is no mangling.
> 

Same for me (nntp primarily, patchwork would be another option).

> These mangled email addresses seem to be creeping into commits though -
> compare the email on lore [1] with the commit [2]. The email has:
> 
>     From: Paul Barker <paul.barker.ct@bp.renesas.com>
> 
> But the commit now has:
> 
>     Author: Paul Barker via lists.cip-project.org <paul.barker.ct=bp.renesas.com@lists.cip-project.org>
> 
> I think we should be careful with these.
> 

Indeed. Happened to me in the past as well, but now I have local tooling
in place that warns here when it checks from: against signed-off-by.

Jan

PS: Pavel, you wanted to forward a message to me where the sender is
mangled and the "reply-to" is set to the list.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

