Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D67C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 06:04:51 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25065.1785132288184552516
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2026 23:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s5oykOOq;
 spf=pass (domain: siemens.com, ip: 52.101.69.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpQhWH5kZZ7RZEQpXt616S4irTyDS4a2bYMBWw3teORfg1qBcBm94MqFPieDKmuop4p/MciobyACjX7xBLxaIepIkfGpngKpsEGEHQDyA7l+2fQpt/Oj1hTtFNnFDwut5grOHy22Meul9B1CxN7Yp+5os1q2e0SR0Uao/m61D9p08boHnRl+VR9zmB+u0bbbsFf1bqQ2aFhP0rs+wUEotqrX2wVP7V+sGYlqr+3kAMh5mNjznU+/Ws7KfGkxf0YZWIJzA3jH0Q2hh+Ky28xNMrPKIIpW7AmZzizNstYqT+H7G2C4y2SYkcFs4VegaxkiksFiKVm6vScBydHgF4CSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYNuJ1qSvsmFnXhNk4+EcRi8VMXIp+anGv8ai4ftJnk=;
 b=qg3PUo7412J/by+N61wRgmF0q2pkxB7eWoWfpsL5kDCs/ewekfIfXieEXVqB4u265MGIv1XtNBhkc0e3CoFMICXMGsRIiY4MYPZHwqSA7IiOuUoLrXYJSabnVvyF116shKAEOsfdlkWLxwa3XaUVr+bU3cQAK/UF6D5+wHuHkg6XZp28pkhsdNtZv2BYFKBGDoJM/Ab38YSI1HnfCjC9gBNtbFcZVs9fM2/yNdB9D5CrbrrvtaDX25XRVJvMWPdVAQAe0p8k4v3LNLMHepZ4zcbTbW26/lWRPMda/u0FzQ9h/LFNNlOu49dq/ZkH6azOObLlPBgT3f6KJGWMzEgSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYNuJ1qSvsmFnXhNk4+EcRi8VMXIp+anGv8ai4ftJnk=;
 b=s5oykOOqR5cglEWR30wRdspiLIUzvl9foIZmRmdnWVyBciWskG0Tm0OPJvZmaaHM/Ji359MVWDn3gcQjy/U0xaOAZsrLeXySXctBKFwdlMNq2sNhFCgbHMShIbpnkALPxvHNVsn02lh/sUzTpCphyJCoc1vHyugfVjqJRLK8o0tKu9DTwQjpmvyf+vUAQZJ8Y3YNrqrcn8AAwMgNYhBRKf+wZ+b5ZDoSmW9YOZb91xkDOEhg+zMTHwCUz/rkz52R3xqyj3ph2SIo2N1NnCD/utkbSYv73MrJhkD+B5mrMtBFCqaDf6uFkkj7h8sCzen5g+WD7eyJxooT3SSelkyc0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:04:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:04:41 +0000
Message-ID: <8f864151-9303-4ec5-9459-9d326cbd75eb@siemens.com>
Date: Mon, 27 Jul 2026 08:04:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] .gitlab-ci.yml: Override default
 release with sid
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
References: <20260723050940.2447738-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <666ae976-6e22-476b-8d20-9cccf13e1dcd@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <666ae976-6e22-476b-8d20-9cccf13e1dcd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 673ae80b-c2a1-4804-ee4c-08deeba4f2c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|4143699003|10067099003|56012099006|6133799003|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	iWtu8zEpHNgn7WvPfo0JEEpGH932QvhSAR6pzJbouK+Vq8O3HCaukBQ3Z3Ko/6U94rvdyjS1jhwPT6GLRzV6SzlE0GyaH3j2oMu1HPDqWDFHEQNZbwFAWOyi83cJ9E914lDvB5qioX4eu/x9vDVuxIYFTeF6eOvHxxIhiPjCuDoZegFRZYh5isbmXiUzHMv4xiuAgiw4/2hN9gf7Wv/IM1OeHnCNOBQRZ3F8hMVk3ui0hO7Ye/QDeEI8gQc0RugYIjx5WjKimcxmcVehtqYM3G6YrU0chGIZWJA92KT+rFS+E8y0aU+uUGwN14jvWWk2xAExyKJQW8VFjL3vvrqCF/K+6BN9z4bKz0N00zMP4IeHvNhA25k/Prch3cftWgdCv52Bu3awmVCHpuP2kp3lMcXK5sV/xEiWnxpDLDy5/wL35kIOK5BZakisHuLDDYkRozDaE7HCLUfQ9WyWjvSPO8vXGRWVF10UYn9JTJokbjRk/2TgES9Dr8h7vq+mXB6InHj+nk0RJ8vI0JIiCjbIybIsffDRbQ5r9fBDttv0MMYasyk4tuSYoIHmybJ2qCFnVJeq/l/axdF/U8y3D5sEJa86GUsjDAUUXoxtndMh2/1kpv0csNjdOdUp8/dR0G12etzZzGJaO2XjAi+CZI334YiWxVvKVO6Ua9Lf6T4iLRU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFFxclhMdlI1a2cwWEY4NEtWUWNSNlowdlhXY1FFVHlqQXRmc2dySVFkMzNV?=
 =?utf-8?B?V3JwMlFQZzNMVng2bnNCZFZXai8ySUpXeDJLV2k5enk4YkYwbFNpTktYMlBC?=
 =?utf-8?B?ZHl1ZzRhZzlQbUN5K2hkOHB0SlcvNjRaWW90SjhmMlpRWFJSQjdsb0dtT2o3?=
 =?utf-8?B?MnV0RVBqTEtoYzVmUWk1OHdBYURLNkh1Ukg2SW1ZMjlkaTJpbXFKTWJPd0JL?=
 =?utf-8?B?SEl5L2NWODZoeVlYTTBGcmlCYXFhMGFIdXhtMkg2OUpLUU9iYTh5QldqSGt0?=
 =?utf-8?B?aUxnVjEwdmtXRHk5ZGVRSTV5MzJtMkhTZVpsT0ZxNG5xbzNhUHNFM29RZlFs?=
 =?utf-8?B?SEtuRkZJNTdGdHlvaUZnNWtreThQbmhZdUxvUG45T0IvOGdJWUZxR2RKbFV6?=
 =?utf-8?B?S0ltZUxQb3h3TkVWbEduVndWRThJWUpseDducGZIelljUnZGOURkeitWd25O?=
 =?utf-8?B?VnBDME9SeC93dldiZExDSVB6bVBleG5YK0N3anljZTJJR0Vmd0gzS3h3N1dr?=
 =?utf-8?B?RkxVUHZhRnBUZWNGOGxpSnNOZzhHaCtnQzVMeFBraFBBU0U2cWpzMjRyS1p2?=
 =?utf-8?B?R3RxZitlWmtCcTNzRE1DdW9MeXZWQVJhTjBjNGFXK3A4UHdzanNXdTJNckpz?=
 =?utf-8?B?dHM0ejFydnRvcUF2eGJOZ2R6V2dxSTBhaTVMQ3dkYm8yU2lmbmJabUhFK0ww?=
 =?utf-8?B?K29sMWwrTWdOcm94SkZtU3RQV2p1MnVVWEs5WkpRaWN0cWQ1VjBvSDZ3RzBK?=
 =?utf-8?B?N0ZveWVFeGg3blR5dWQ5TllmalBrYU1KQUpIY01acHlBKzZjU3NXTDRVYVBB?=
 =?utf-8?B?Wk5tdHEyakV5SEZjZUJxZndmck9xMEhCRTlVNUpMTk5zdHhjWjNHc0ttbS9n?=
 =?utf-8?B?ZHh6VEoxankrRzhyU3laK1lmWGtvbTBtSWNxRXNwZmVDdFozV2syejNKT25u?=
 =?utf-8?B?NFZwaGpOQmJJa2NFckRZRk1xTUVrSHl1enpyYnVxSnE5MFR3R3lNNG5NSzZV?=
 =?utf-8?B?QVYxOXFoWjFRdlF4dWNHb1BvbjJDMjJmTGtJbjdYZWZHQmNmam16a1lvRFpO?=
 =?utf-8?B?eFVQd3pRUXhPTlZ3ZVpzS2pkeUZOVU9EZjNKQzlYWXk0cGVPTGxYT0U4UC90?=
 =?utf-8?B?MzBEVU5wRkZBdE05Z2dLUHdTQXJFcUEzSlRGemdtV0I2cVlXRmxZemZtYmVI?=
 =?utf-8?B?dzB3UEl3N0NjMVBHNm5EcGkvdWZjUFFIRlAzdXNNUmZtZS8zYWs0ZVhiZ2kw?=
 =?utf-8?B?bU11OW5mOGt4eTYxOEdSK1JaSWg4Vld2QUo1V3ptRGtDVXo2dmVPb2lVZ09q?=
 =?utf-8?B?cUlSWmpZQW80VW5ncDBQUjU2S3JkSjc5bUg2S1VUczd4UFJZZmt6bXNYOG1t?=
 =?utf-8?B?dmRkb0Y3cUFja1hQbWpNYnRKek1HMElNOGlvczQ3dTVET0puZHdKaTRkdmd1?=
 =?utf-8?B?Sll3N3NQRlJnL3VhYmt2NytpRUZDSGdqOFIwNno1RHp0Z2tTNk9CUmRxbDd2?=
 =?utf-8?B?NWFsdVUza1lDajhhelBWTTFEa2VxMWozcjEvb2UrM0FwTDEwa09XSnpEOWdH?=
 =?utf-8?B?K1F1NGF5UkhLZHlhVllLalRmOHVsTG1ZVndUeE1UWmdMUjM4WW90VVFhbWZD?=
 =?utf-8?B?cWxWRDNNZER5TTFkelAwTVlabVFDL29LV3orQzlKeFBNNTFlWmNuVFBaUHVH?=
 =?utf-8?B?TDZHUmFMRm1ZWnIxT3NhVmxac1Q1T3JxK3czRE1Za2ZLUkd0c1RyNkZpNGgy?=
 =?utf-8?B?OEhsR2s1SE1qYkZ2d2VKZ3V1WkZ1OHVidnlCSUw2b1NHaDZ3VmFKOFNBdVpC?=
 =?utf-8?B?NUJVcHVCMkxVK0IwNDM3WHArdTU0YlNTcEplWDQrSzErdDkzTkkwekpyblZF?=
 =?utf-8?B?STFxMHBEWjJ0V3hQY2J4SlVoeC9sYU5yM2paN1Bqd2FZOHBJRkRmSHhrSExx?=
 =?utf-8?B?SDE1VTE3TVc5c3hEU25Hc0V5SlpsMWR2UE9hOElSdFdPVm0yNmdjeHNqYnI0?=
 =?utf-8?B?WVorUkFkQTNzY050VnI2RTF4eDFUUlZjTVZsSHh1SFlrNkxoQWp6dk1jRjZV?=
 =?utf-8?B?bFBHWENvMTZoTDNxMHMvK1JOUE1pWXVRQndHcm5weWk0VlpmbHpnUTNoWWJh?=
 =?utf-8?B?R1NqcmZoeEUycHdnZHlvK1Z2WHA4NUZPelNPY2VqTGtiK0FRTnJ6Y3BaN0dX?=
 =?utf-8?B?TmlzM1VDeDBwdWJMMVhBeVppUGtGZ1RuWDBNMUdzYlJVbGRvcmVoN0FpYkNy?=
 =?utf-8?B?d1p1TFNTZVhqNmQzU2syVG9QOTJvUEl5aXM3S1VoTU1KblhOeEEvTHJjT04x?=
 =?utf-8?B?UmxZNWVXOHR4Vjh4WVpwV2x5RlN5eVFNMmJkVFNBV1JCeFZKb2wzZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673ae80b-c2a1-4804-ee4c-08deeba4f2c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:04:41.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwkF65jHW/NW+vKpJMBQ705FNnbhOnobI5h7TAWK3oCXs0/ZIoOCNSQVGqkAAqGo9fuJxA0ph0R0+odKoVjm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 06:04:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23749

On 23.07.26 12:47, Jan Kiszka wrote:
> On 23.07.26 07:09, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>
>> By default, the release is set to trixie, pass release as sid to
>> override it for sid based test targets.
>>
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>> ---
>>  .gitlab-ci.yml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 5a20ad6..b53def4 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -740,6 +740,7 @@ test:qemu-amd64-IEC-sid:
>>     - .test-cip-core-sid
>>    variables:
>>      target: qemu-amd64
>> +    release: sid
>>      test_function: IEC
>>      iec_test_timeout: 40
>>  
>> @@ -749,6 +750,7 @@ test:qemu-arm64-IEC-sid:
>>    needs: ["build:qemu-arm64-base-sid"]
>>    variables:
>>      target: qemu-arm64
>> +    release: sid
>>      test_function: IEC
>>      iec_test_timeout: 40
>>  
>> @@ -758,6 +760,7 @@ test:qemu-arm-IEC-sid:
>>    needs: ["build:qemu-arm-base-sid"]
>>    variables:
>>      target: qemu-arm
>> +    release: sid
>>      test_function: IEC
>>      iec_test_timeout: 40
>>  
> 
> Thanks, applied with a slightly adjusted subject ("Actually set release
> to sid for sid targets").
> 

But what is now the expected state of the pipeline? It's currently
failing in all tests:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2704797364

Is this due to changes in sid or due to still missing patches to the CI
infrastructure?

Please also have a look at the even more important inclusion of forky
soon. This is where we need to be ready for testing  as well. Could
become part of those weekly runs as well, at least until it goes into
stabilization in spring next year.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

