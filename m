Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75958C531C7
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 10:47:58 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20756.1784803673747682757
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2026 03:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eLxnUgZn;
 spf=pass (domain: siemens.com, ip: 52.101.69.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSE43BHtN/SbhLHGuMY62Avi1aDYt8lTuQG8/1Yj1AFp37ioL2+qRfABZ8zlEdvCu6NnenQlbW3NS3zTpAtOHkAfKeUvqygHE9wEXhAgu26qV2jKtQRxBnseKeO+kE2kwawtlmpaFUGg81UKHWp0915JPa4/9U5B8mf7LCGmD2Nt8BNZY7K9fiqgok+2w4fY1KV+nNK/Tb4p3PtbNc5/9Xc9hbfM9mo9Cn2H3gHLvzcVn/VeobkPsIACRRBjAAkJ1547SRArhvN6sbiyG/0FzUinfYkPtGymWAUMrSLu04PiTvIsCXnltkLtCSc4sUWvpmnHXnZR47/DWb+vSNY5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8JqXaLEZnyl8aVcZi+a2Ep2QSQKVeuo6kRK3Kl1ZnU=;
 b=KwJCRqF22bxXA3I0cgG61s8yPWBx7gfp/Bk0eLyDPgKLRFp9U2ylJl9+yZIztsBWdIlENG5XzA8n72wiXVePoPySwMGkjupwCWAyRy2TLd6HxBchiP/NGkx1ic4prJk3QVS4Kc2kClmnHut8q+vz5MDAhN/HDXF3J+3INFB+gmMo/P7XvRSEerTHIUpML1IfZgAmxRCn/YsbW66UuSxEYbgIoSinYP2rGcQx6ngc5hqhAqinm9MGJXlLZQc5waT5sn7BcQYseghjHTyYsrV5FPdKJmIHZn1XoHWbH00ZTBfUE4ARLmsiWAx6D78Ig2zbk/CyH1ynprTakHWp6yexxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8JqXaLEZnyl8aVcZi+a2Ep2QSQKVeuo6kRK3Kl1ZnU=;
 b=eLxnUgZnbBjuYXfxq71M5pmBRIiasRen/gZVtNx1QG0vumweugRJnpHJCkSccn08e/sZuwIsLAZfL9rYBzX/fgvGoSAJHLwn7iVGm2wbnhKoOnZszT6q1TexXCuHfTjO8BtjLkivt8PsvUZITHfV0LNmNkBQnFSU9vDaZZ8W0aBTkh1DUyQYxYBayoqnbG2FzyYxr9amil8RMD1+z0z0FuPkjGMFWH24o8rmHHgfsCTT02Awz2Q0GqmwwDNLOEyaMUduKcAuAm+VCZDZpuBlPuDIzA6UKHo6RPsXgHiIWaZJjXx7HqQMysuOWUF9JA15sxyCNrZdRlIbvfMQZd2BRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:47:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:47:50 +0000
Message-ID: <666ae976-6e22-476b-8d20-9cccf13e1dcd@siemens.com>
Date: Thu, 23 Jul 2026 12:47:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] .gitlab-ci.yml: Override default
 release with sid
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
References: <20260723050940.2447738-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260723050940.2447738-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 20668d84-8c9c-4146-fd90-08dee8a7d717
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	9esXzJFno3J2cbjpGAsHpU/prOhYdHlbaPU8VggX2b3xPTQYWO6QiCNFm5flqF4Kn1xpwz/7r8mcfOv3+mdGILcBE0Njlru+fzxIbKv4F2H5T23kB6CikZMCGigpX0vDQ9neFcstQ4ppoMdzhUYDiAHbmtLh4FyGBBoHSRnMxyGL8wRh4qNTs83cUoZj/LbfHmqwD7KWV2NTTSRjeFvuP+cegSDuSrMyS5M+79Q9SPUH/gIjBPcX/te8+qBH2zQ1vZtxFzsOZJ2Mtp+eLI+XeIKbAJHBI8EmtFs+cfUnfn4/V0gQkTzihPgoI0AT4P9d0I9242y4Ssv0oZEqxeGJ9xvpnSmHOAA36YHz2i2PBNc4tEcWrWPsH0QjD3UbLIvPJCmsMpzAfv6MRb1l5zyncQo2Pq1+XIXDuzBA/c52uCmB+PYVO4Nx690pN6g51M7bEQs6qsKvK8q8gBdqGvHb2WCILcAbycEYJudIMKIpP8jT1Fzyug9NrySNmUd/LxPtZuRvSR4EwWXIAxTKHzapOaf+bJJh2Tl2sp1HS6iCNSGMAbnOtchoZb6w60OVxrVbSdhPT/vlli/z9K6uYs+7Z4Twu5NpBXDaP2ZqrQR6cdxgm+DsspL76JUvC+g/TIDgfSMIK1lua0+f1krgyytDLZ+i61Br3hSRmBxgKEvkJJ8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGIza3F5TE0vL1h5bHcxKys0WmtlUldsQm9MdGtqZkpZWkthWE4wUDJ5ckZV?=
 =?utf-8?B?QkQ3UEtLVUlSRWdZRUtZaEFyZERWQ3dBb01Fc1IrdmxiYU5iallZRkpVbFhE?=
 =?utf-8?B?R0JlT01IRlJYSVJ6SmNDbkc4cmVGUVl0K1VnOTh5UkUzZ21VOXk1TUd3dDJw?=
 =?utf-8?B?eWV1cW9UY1JTaTBMVDFrSXpieVN6QWpEUzZ2R2Z0T2RSeko2NTB4cUdKaVRi?=
 =?utf-8?B?M205Y3VlMmlxOWFsY0s3eTlTL1lOeU9ndDVkWEFDVDV1aDhvQ2JMVTBMTkNU?=
 =?utf-8?B?WVJYYjdKNTV2aFlMN25zRE12MHRFdEYvUWYxUjRqVmtaejJDS2hhUnVoeUhm?=
 =?utf-8?B?UnlXNkZMM1RuV0RkTmlMTWNlQy9yTVg1cU5aTXhidXFYNStXSkQ3Nzk4TFJu?=
 =?utf-8?B?dDFkVm1uaDlNNTJqTWl6SkNENkVYOTFLZkJiOGFlSjBvdzQrdDRIeW5ZZTRh?=
 =?utf-8?B?Y3F4NG9IRTA4U25rSDY3NWsrU21mc2RoZVdkSlk5ODlqR0xma2tJUFhYSlY4?=
 =?utf-8?B?Z3NCa3NDd3JKTXJKdjJXQ24vYmNWZWlxZHorc3dDK2t5R0h5YWNZd3U5S1Vz?=
 =?utf-8?B?SkcvVFNySmVZM3FIb3FRZDJhNWh3SDhKcGE0L0JYM3VvamxoMWc3ZVUxblM4?=
 =?utf-8?B?WTgxbEIrNFJTdFN4VEFjdE5IRjRhNllSbE4wOXZMdXN2NWRNU3Z3MDJsYSsw?=
 =?utf-8?B?b0hFd2RaVUFqTGdad3BwRE9oSmY5NEwrNEc4a1BLTUUySkdIdEZzZkY5MHpi?=
 =?utf-8?B?YVdKYnczR296SFk4cFBjZDhzdXgvUHplTWxyay9VQUwvejFPa01tUjdBbGxU?=
 =?utf-8?B?aDNFd1R3SDFObmdiQmk3ZkRCdC95WXhVVlAvMVJDa20vTjFDNEM5Zjl4aStq?=
 =?utf-8?B?ODNyQlNMRjdHNkt4TnVTL1V6Y0dMcjlXclE4RmFnbWhOM2JQNjMrRWVsd3k1?=
 =?utf-8?B?czhHK2RBaFVhdmdUYkhicmtnVUd2QWxYdVBqQ29zY3oyNHNwdVhCbWJQUjlI?=
 =?utf-8?B?OXNLaWkySmRSamh4R1N3bzlBNkVQZm8weFRyMDBxMDhtVjBaNDh3ampRY0cz?=
 =?utf-8?B?VGZpRWdETC9pK0hOaFJra2xxejg4MEk5ZlZjOEpiOThZbFZPOUkxMFV4OFdW?=
 =?utf-8?B?Z0ZQaXJMQmdPRjQ5Y1R3WVJHdU9DbjVWdmpiazZaaHNrQ2Npdlo5WDFEc2R5?=
 =?utf-8?B?WmZHQU1zRmw0UEZmaHpSczNnZmt5Qjc3Vjd6Szc1NG94MVNCVFdsb1J1d1dQ?=
 =?utf-8?B?Kys5SHFsKy84eHhpeFNra0NORTQ0czdqaDBUa0ZLb1pWSTRUdUN0R055VmVi?=
 =?utf-8?B?RXQ0dVMvdUZVTVd3NkZJTWJZRXhJYkZITktYQ0M4TzFodXlEN2NpVVNZUkRo?=
 =?utf-8?B?UGF5S0N1Y0YxOE0vZFZFbFdrZ2dQSEozTHhwdXRSMEV1Rkl0eFdxb0xnZzZM?=
 =?utf-8?B?Mk1JMGRtODdTTzZBNS9RSVUwTEVMcURocVEyWkVNVWlSQTFNenlsRFNFM3VE?=
 =?utf-8?B?dnhuYjhRSVVlNVdQdjc1MDZwVTQ5RjlDMk13dWxKYnN5Z0R3N1dKTVljcnFy?=
 =?utf-8?B?amdZcWVLdE5IVVFScnNaTkNaN1QvY1U2ZDN0NWswT2p3QXUwcFFwK0RkZXgr?=
 =?utf-8?B?YTZ4c3lrbGZMd2pXdDluUzdsSjFBTGpVRkdTY2RuRFpzd0hQUittUW1KblpT?=
 =?utf-8?B?NDFFczJYUjI5TDhveXFlOUk0b2E1Sk95dU4rR1REbGNMMSt4eEdTd0tEQzBh?=
 =?utf-8?B?Y3FhQ2ZlVFNOOXVieGJ5UFZEVkovdTcyUFJMWWNFT0lSNnYvMVhFQXBCWTUw?=
 =?utf-8?B?MmdkRzd3MFNsNHpHZUVCSGU3aWFYYXRNTWxicktKZlF0dnJHTEcyWERUSEEw?=
 =?utf-8?B?UUNUUXp1Wk9rWjFKOVNNUnR2Rk82cFVjWlhNV2NJaThPZ0ZoKzQ4QUJVQ1JX?=
 =?utf-8?B?bndjcXcyY1BwWHhKek1MMWZPaXFpVUpCNDB4cG1WekxmVm9oNUpVNXNXNnNr?=
 =?utf-8?B?QXdjdEc1L05iczBWdzVoTXd4OEdnbjVUK3NKbXZNUWNaSzN3RFVlRG85aDRw?=
 =?utf-8?B?c2prTitidTAxZTQwakJMREkwYW1VYUhPMnRpWExuSjBKYXN1aEpFeHlpQU9W?=
 =?utf-8?B?YlAyZ0hra1hVQ3VVWGJlOEU5Mld1Q0tXSVh4MTB4RGdKaDY5YUREQU5tRHpx?=
 =?utf-8?B?YVE3QUdLUnlWVFpDc1hPWTMrQ0h4MkRjQUc1eHhJNVRYS3M1amkxWG5NUGFy?=
 =?utf-8?B?OU5PYjFQcTFweVJheFRzZy9JdC9qRkovUGRyaDFiTWZoemlqeElPa0FWb1dV?=
 =?utf-8?B?Q29sOGJQblpsNXRrTXJCeEhuV3lmRVk4ZkFyMXdiTGIwTk1HUXFTZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20668d84-8c9c-4146-fd90-08dee8a7d717
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:47:50.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwHSpPXqVUztfj8JV2AHtFGjpREL1sHxhbEmb1TjBOub0XHR02btO86GRgO+0rBz7av/ZHUMzYSMgVHEllSnXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 10:47:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23727

On 23.07.26 07:09, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> By default, the release is set to trixie, pass release as sid to
> override it for sid based test targets.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5a20ad6..b53def4 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -740,6 +740,7 @@ test:qemu-amd64-IEC-sid:
>     - .test-cip-core-sid
>    variables:
>      target: qemu-amd64
> +    release: sid
>      test_function: IEC
>      iec_test_timeout: 40
>  
> @@ -749,6 +750,7 @@ test:qemu-arm64-IEC-sid:
>    needs: ["build:qemu-arm64-base-sid"]
>    variables:
>      target: qemu-arm64
> +    release: sid
>      test_function: IEC
>      iec_test_timeout: 40
>  
> @@ -758,6 +760,7 @@ test:qemu-arm-IEC-sid:
>    needs: ["build:qemu-arm-base-sid"]
>    variables:
>      target: qemu-arm
> +    release: sid
>      test_function: IEC
>      iec_test_timeout: 40
>  

Thanks, applied with a slightly adjusted subject ("Actually set release
to sid for sid targets").

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

