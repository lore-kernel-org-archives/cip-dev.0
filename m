Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C3C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 15:25:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.37])
 by mx.groups.io with SMTP id smtpd.web10.41120.1741620352170061051
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 08:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g9Az8hop;
 spf=pass (domain: siemens.com, ip: 52.101.67.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIkAcnb5aNMkXzyecqxdchzG0gCWT7VnZgalFwsiPUjC54NeqYAnZI9Y+QxsKZ1pI7IL7WTMAgzr2ffdHV5vjak72TtvuKTnU6ofNEF6/bpWsYVmzGB4FmgvVHsbQ4IhjmcF70EdLL7KLEtjKpFuiCeYDNr47rzcfsR3E1USbj+KmN9YZ5/RknfhZ6OSJifgYr8MGA/oYpUOwNI7inNV794b+OBgXNizIQ6pDmhzpdguQg+uU+t0BF+4jhJN1BMwUDQdo5fc8KoCEoh6LjAHYtrLAo1XVYvqjg/ptg2XXDyIbqd2X+bAd2zLiwT9cCNSso5MmVkhOfmOCaVEno8nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvwWRnpy6EWQzJi9YRZ6RSiWcr4y7r+yAvVwlBmyC/k=;
 b=NDWyvJCHzKyuAfZM12MNMlOtsZXX/Y3SP2LROhOhy23wfMdi3wL6E46SGhXgZZ0kRHEVQbJOyDtkyDnlFY0S/BuKYJKoyGFwdlztdpXfoe8lB3FYsKAk9R1YK2m+5f+90Je1n9Acw2nw+YrDjdqA2rNT8rBCwP8EVwoimSYT4Xh/apTx0264zGpysCZ7m4lj2Tw/O+VZ55drqzGd3Wjy5WhEb8n4SE9sF9DQomsBN+kyPdZ1jvFwOsKgaNGn6RZrJFAteUjnKgdx4JsTowq1HEmFxKbxFsoEtiAmnlezWEWTtALMcdMy40QHISdRVjgfVBvoBVJX5MrhmY8aTxGncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvwWRnpy6EWQzJi9YRZ6RSiWcr4y7r+yAvVwlBmyC/k=;
 b=g9Az8hopp5rcckAjRlL82eY6pMpWesWT1jSA9MfqtWyDx1wVz/DtJiwHctl9EV2JMf26XTO0XR1lOtMC4wW2vSTfPqokEb/feU0pJtJ90u+3K85AoH38NuhG4tpPIZ1OTsjG/lSqqoSC4htmxM3eriFOHX4AqGryQKz2EJQd0J7DKGjHimy1IXcCTkuJHBvVcx+ex54b0jYThbGaeNAv59Su1wfE/mu7Aizlh1t71N/24d2+IUqw6q7k2ITwnRzMDy4fBFwUNV9igHSfzcfPPg/F85Bg9DDeK3ylJFRtRG1VMqHPUKmGmbNo9cHLPMQ0rSJ+CBQiChKvllGToTZxLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 15:25:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:25:47 +0000
Message-ID: <47b0340b-9a66-48db-92af-9e00ed81df7c@siemens.com>
Date: Mon, 10 Mar 2025 16:25:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
To: Claudius Heine <ch@denx.de>,
 "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
 <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <602ce0bb-ada2-4eb4-87e8-e917a2388c65@denx.de>
 <cf030a84-ccb9-4cba-b5c6-d117ebc66620@siemens.com>
 <f7c75d07-efd4-407e-8c11-ee95484f4865@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f7c75d07-efd4-407e-8c11-ee95484f4865@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bc558e-4ad1-4a6e-38ee-08dd5fe7d300
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?em92bzNSbFBoUXRUVlhwT0h6N3RBWnVLTjRKMEs0TTdPanhNdzMxbUMrSk9y?=
 =?utf-8?B?YWJpMjdPTkQyTFBHV1YxalZSYTBzRkNuMEpwbW84WWhFcmdhVE5XcTNYZVlr?=
 =?utf-8?B?aXFOaHEyUEpKUkYvQnJqd2hHdXhoMDEvUnQwMEhRT1h1cmQ3UnR0NzFqclh1?=
 =?utf-8?B?SStmNTQ3Q2JSbjBET2xvWTcxUVJBM1RpWXMzN0xvT0Vqc2lZencxOUJ4bzZi?=
 =?utf-8?B?djRyR1ZCQ2pqcVowOHFFdDA3K1REdHVrQ1hRa3pVd2k5QkVRbVRzbUg5bHFp?=
 =?utf-8?B?NzFJQ3pqZ3Z5ZEdkQ0ZFalkvZ1dqdWtnTENSdGhhL0d2OFkvZzNadFUrbmpO?=
 =?utf-8?B?NW54ZjkrYmQxKzZYMVFDTHg4TSs5NlhoQkhwT01wRWdYSUFIOXgxaWZnakg3?=
 =?utf-8?B?djkzNzY2VDlYQnFHbmNmQ0JnOUdERzFnZytvcjd4cTNia2YzaEptSWp2ODNL?=
 =?utf-8?B?aTJ6Wkt2OTVRaHlhVDhwdWFwRFNPNitocDc4aDRuUXc4Sld0N0NLUXdQZDhO?=
 =?utf-8?B?REVmVkg1aTd4QldWNTA2NHJzT0VydXowbFc5Y3QxNlVubWhoWUJDUFhlOHJn?=
 =?utf-8?B?YTcyMUo5N0ZuaWczNTZHVTR4UENxMXJ5WXVOTjg4UVhDSUFwMVZMeVJUS3hK?=
 =?utf-8?B?SjViYVdlQmtZVlBOL2toRGtMWHdUVWo1M1YzY0pZTlBrMGFUeGVLTDE3UmFS?=
 =?utf-8?B?bE1wQ0UxNWN0aEdoQTBwUTlLNTVSZEdDQTJJNHR6TDBNTXN4RUFlREcybFRZ?=
 =?utf-8?B?UlVPbVN1TlVqeEtZb1ZmSmNJTll5eGYxU2tGWFlSejc0MSs0UlFJUHN0K296?=
 =?utf-8?B?QjNsbDMxWjc0ZW14KzhMdnIxTkUvTGlXSDBmK0k2b3VGL2xDQzdwZlRVRzFG?=
 =?utf-8?B?L2tyYmdRQUZwVVRHVmNnTmtHQkY2SUhGU09URzdOZng3akIyaTVzWjRhaldx?=
 =?utf-8?B?bnpuR0JneTQzazU4L1MyUDhqVndBcWkrY2dnQ2svZ1NPZnl2OFcvTFFuYU9r?=
 =?utf-8?B?dmxFZGhYM0VVSEx4L2VBZFRzdTBTT3E1K3BiTTViRXFSMmVwS0J6T1Vtd0NK?=
 =?utf-8?B?TW9RdmtpdFAyS0JIRmxjQnliV045YnkvK1A5VGtpN3NxcUI1L002ZUdoZUMw?=
 =?utf-8?B?MkxLOFQvN3FpdDZqR3RXY1lHdFp2QVNnSHNlbnpha01EYmIzM0tBMm5wa2pr?=
 =?utf-8?B?bnMwcm9GY1hWb3FIYmRXdFd3TFJmdXNoRFgxMlFzYXlNNHhRbkJPV29UbTdK?=
 =?utf-8?B?dENQcEZLN1VHL3g3ZVd6U0EvTzlXU2tDQ2M4aGY3OE5UQVhTMVpvWnhhNzBT?=
 =?utf-8?B?QUtJSkR0RVkwVEo1eXJxVG5MRlE0RlUyWG5WQlFlUVZqUWtFdUdnR2h0VGJK?=
 =?utf-8?B?VDJSSVp0dlRlZCt1M3I4TTczNFUrK0p6akVjWGNuUVNwVmFCbUpLMWVvaHhk?=
 =?utf-8?B?eUNNKzRmTWZqME5oY3R6UzZzY0duanVsWGZGVFAvU2NheEJiUVlMUkI1QzVJ?=
 =?utf-8?B?KzZieWpvOWlKSlpvT2hsSE5veWI3OEQ0MFpIcE8za0dKSEw5VG43Ujlybm1x?=
 =?utf-8?B?c3NxVGo5bHlPblFpSm93K1U4QlZNdTgzYjlmS3l6Y3g0SG5aN2I1Y0dXVTJv?=
 =?utf-8?B?bDZGVHArNWN4QW4vRkxleHJaL3Juc2R6M0xBSHdrb0swaVdvWlJTQnhCR1JZ?=
 =?utf-8?B?ZXdXY2QzY1k2MCtHMjN5b3U4MzhwYWp3M2I5dmJkbFdIVzMzWDRObkxqckti?=
 =?utf-8?B?SW1UZWorQW44VkRlcDdKN1pjVWJHdXk4a0MrbExEdk5MU010NnpGNk4yZVdK?=
 =?utf-8?B?Yy9WQm9qT1M1RnExZTE0Um83cWV6cnpqWXJaRDVxeWg5ZldPQ0t5dEpkRHpY?=
 =?utf-8?Q?4XcKXt3Iq5/3C?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzJ0RlpwNlRya2dJNHdrTGJWVXMvQmNkVWVhVnBYYm0zU1p5eFVnR0h2cXhx?=
 =?utf-8?B?Rm1odnRtUEU3T09rbTlCVzllZzVxSzFWWjRMU0FacDY4NDZwWmoybWtpVm92?=
 =?utf-8?B?d2tmQVFvOCt5aVkzUFRQSzZIODFqUmdnOStBeVhGQXQwRE1SNXpoNXZCcjdF?=
 =?utf-8?B?SHFIemt3R1Z3K2tnNThtUDdQSkFxdDZ0M0ZYSStPUWF3aE9ycWtwNHVmUUxv?=
 =?utf-8?B?REdxK1M3U2p3Q3VlOUFyMy96RXlFY1ZFSDZ3Vk9PZExsNkJGS3ZIMXpyY2lm?=
 =?utf-8?B?Mzc2SDk1WnFEdmYwM0pKNFFleHJxbFBWOTZhM0hPZTlQWnAvaDMraGhtV0Jr?=
 =?utf-8?B?WWhsNHNPVzQ5alVzYjMzcXN6OGFocVlRZmdVbGwrYU1kUlhQbTFkdldJVjNr?=
 =?utf-8?B?bWNqWXdtK0srTUNYNjFSZDBhTEVLZlRjMzhPallrNTFReUc5MVFsWi9FQVpK?=
 =?utf-8?B?WFNoUWVHVmIxVXhVbUtSY3Z4WVpsNlY5TkNDSTFXSGVsOFZCN2p6U1JTbCtN?=
 =?utf-8?B?UmRPQXVPYmlRaGIxWjl6eUoyZHRPUXZRbWd0TVdhWHpzUVhNck1Xb01zK3A1?=
 =?utf-8?B?cW9LVHR1ZnBpRW96Z0ZHY1hSbUJmbWJERXpSTzFHaVgzMkNiUkNmaEY1bU40?=
 =?utf-8?B?TkxIbERwTFhXb2JuY0xXSVAzRXYrTEVIYkdlanNvc0lUekJjZVFyN0dUaTJw?=
 =?utf-8?B?Ti9OYVFrcklEaWs0UDBnNXZCSDBSaU1KL2Ywb3R2T0V5YVpzWW5vZ2Jpa204?=
 =?utf-8?B?cnZkK1VGMkpmbUlJVm11Zi9kVTRsYXc0YUtER09ka2JsR3UxZVgrNkc5bk9s?=
 =?utf-8?B?WXlYK1R1VlY4S0ZCblhYNldlNTdac0N4YXNYWklDeHlMYkVDRml2c2U4ekhK?=
 =?utf-8?B?MFlsc01zeFFWTEtkRDVHd3V0OGUxME53aGhoTlAxSEZnWFdBNk5iZ2xqVFZi?=
 =?utf-8?B?VndjY1l0cGVYMVlNZlFOZHVwQ2dFOEZKKzhMQ2dpNnJsVldaOTY0cVV4QTVP?=
 =?utf-8?B?RHFtKy9zUXJzazkveGE4bVNsVjloWkR5U3pXa2Z6TDZYTkNWRmZxVis2dnA5?=
 =?utf-8?B?SzZMUnVmbFNRdVhqeHQrODhxZHBveU9wWFUrKzhXOTVhRjd5QW1XVkpHSUF6?=
 =?utf-8?B?VFN6TWQ4ZDRBbldxKzMzek40aklmcEdBVGcwMFZxbVhjV0RlSVZDOXVMd1Av?=
 =?utf-8?B?d0pTNEV4MmZ6cW9Ja3p4OHptVm0wbkFoVm9GejcvMDI1M0ZZTmtENzlWdkpK?=
 =?utf-8?B?VVVRRU9ySDRBUzlRZGU2Zkx4MVN1VFdoRTVoa1V2WDhIQ2ZxWWpBQnp1UjFY?=
 =?utf-8?B?T1BjU21VNlA4dGNML0pYSXJSVkxsVDZkMnBnd3hwT1RRUGkzL0Q0emdYMFZn?=
 =?utf-8?B?RU5uUkNGVWNUOCttVDZCU3JReDZwWDMvcE81aEkxWmhZd3hISVFjeGFSeUpX?=
 =?utf-8?B?VTVWZW91RXYySTU1bHFQaGluQmxJTVBIajA2Qm01RHJjelJweEdoTzdKM3FU?=
 =?utf-8?B?eS9KQXYvNTdmL1V0ankwUDZ0M3dzQmlZZWpabDV4MVhsZG94N3ArRFhZVnQr?=
 =?utf-8?B?c0JyVkVtM0MxaDRxeStXUjUyUWlhU0pjWmxROU5uZnBheW4ycmhmU255cHhI?=
 =?utf-8?B?TC9zcTZJcEdRN2VJd0JBYUIrYmNyR2FYRjVZVitCbHMwcEowRmFTUUZlTm1Y?=
 =?utf-8?B?UnRSaDU5WWdjdThzUjU1RHNCT2FxR3FGTmdiTXY4TlRqekFQbjE2bWI3RGdW?=
 =?utf-8?B?U0FkcEFyRFZhK0lvNnZqcnNqdEpETHNTOXpwMmxlSWVhSzVVOUxpV0x2L2tw?=
 =?utf-8?B?cTNud2loVVF3ZktubVE5M1hwY2NrQzNuckg4WGtna0JWV0lPOGh0THQ3d01D?=
 =?utf-8?B?MVJNcjVWcGhrRlNQeERCWURVS2ZjTUx1QUdjRmQrQkRPMjJ0VFAzSFFaSERM?=
 =?utf-8?B?cUlhNVJCemQwMVdXSU9PbVlVcGtCSVZzdWpQaDM3S0h1ZUc2cXpXaktOeGJS?=
 =?utf-8?B?QmtxSUxpbUszMXF3eWNrQy9hZ2VFN0dPZlJNUkJyT0JTZnFEWFNZSFpiNElQ?=
 =?utf-8?B?K0hjT3FyNUlVSHhITlh5eTNIQ1B3dUZwZEljK0tmVHB5bXFxQWVsL1h5ZUo2?=
 =?utf-8?Q?Xhc1C7Cgmu5h4r1rdi6uGC7OQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bc558e-4ad1-4a6e-38ee-08dd5fe7d300
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:25:47.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqo9YAgX7E+lps/oT7643dcMqehcKBmaBV/BrcdxLYhvwkR7FUuNBQ7c4A4tSFpG93u5KCJA724WWLDuZAp4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 15:25:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18077

On 10.03.25 13:52, Claudius Heine wrote:
> Hi Jan,
> 
> On 2025-03-06 12:20 pm, Jan Kiszka wrote:
>>>>> Security wise the partially encrypted volume, with a static temporary
>>>>> encryption key can be considered the same as the un-encrypted
>>>>> partition that was there before the system has booted. So using a
>>>>> known temporary encryption key should not affect the system security
>>>>> in that way.
>>>> For new devices, during device bootstrapping / setup that's probably
>>>> true,
>>>> but such assumption is not generalizable!
>>>> But even if it was, once the device is in the field, probably
>>>> sensitive data is
>>>> added during onboarding or gathered during operation.
>>>>
>>>> Thus, once the volume key is retrieved (as described above) attackers
>>>> could
>>>> potentially unencrypt content after years, getting access to sensitive
>>>> data which
>>>> wasn't there initially.
>>> That is true, I wasn't considering that.
>>>
>>> I guess the only real option would be to try to use the TPM2 to generate
>>> a static key... I will have to research how that works.
>>>
>> Exactly. The question is why we cannot generate the final key already
>> before the encryption starts, ie. eliminate any temporary keys.
> 
> That would probably require patching cryptsetup and/or systemd-cryptenroll.
> 

Should at least be discussed upstream.

> I however managed to encrypt and store a password PCR protected in the
> TPM2 using tpm2-tools, so maybe that would be another way.
> 
> So far I tested this setup only in qemu+swtpm, and will test in on real
> hardware next.

That could become a cip workaround until the tools are more flexible.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

