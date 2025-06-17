Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12FFC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 10:06:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.58])
 by mx.groups.io with SMTP id smtpd.web10.15102.1750154804206796347
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 03:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CXct9K1+;
 spf=pass (domain: siemens.com, ip: 52.101.84.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8k6yLCyzjJ5PIeWdmzxBQa1ZMkp8omAY/ZcP5ay6K7G2pPNlcHP5DzjZ8OPfne6NQfRNbFD9SSoMfHTgFF1f5Wlnn/gCt+cIUniaOs2vUH/VOetEFSQ2ibtwcLXa5HHU+Rht64DE9aR4857qDFthFu0hNOi189gvYTZOp5bYL4uOUPtaVnBC2R5ZGkJwo2jnrexVewtOy56A325gJUuSQNxIVZNFO9penuJWtBysxrCK2onIrRsyYqwqDxylQf4g+eQjQH9NibiV5e+yHEPXRu1my35Ox2OU8mlibRkgiIama9eI0aFoRDctrmSvtnliy6k+4O3AqMhTfjVhH9AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uad2BPdfB93jEF+EK0murEBYMoYPthoz/X/UfClOGuM=;
 b=X12bk4FX3UodsOu95W44280ffivYruN4VHPcBtFshzi4nrTP9Qh5xtA50tFMzDIRhAX7Qm3a919HdjZ3G1kymC9wZJ4NkvKkPKobVKn2MElWYPJibFZAqOLe/QBjd6zBeDgYKEA/vSzdUIsSO8NT62lbVhQWYdhd7cfVOIWzmcTfaXFnjlkLCPbNwQsboagIqyNlit6YVH/0JoF+BwzKVyDIsWrilBPXkIDYm0c7YqG9cMcjtwzocGuQduchTnpMbt5pL92k0cLcrtpwk8d1fqD6MDmAEEr0hJQhSGD8bbZJYS7CfzO+5JJl1fz4n2U4fodAnjgB3FukVhx7N+D0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uad2BPdfB93jEF+EK0murEBYMoYPthoz/X/UfClOGuM=;
 b=CXct9K1+w22mEZQDiZ3cL67JkqApmg3mldaX90DNgEQ35UoWOfJ7KqAmAVJGypXRopcBiSrdUoDBRBQFjhmKVZKBHE9mxKv2vZhwGEHGcba0z6vzkzJdhkkIyKSuvC+lHhwflqQqfbSpTsBH8JTxxsSVTe2nzZE95mpbfoFsemeA/qc2EqZb1GdZc9xpeYnoZPniyWqye9a1DZfmCqfEu8XWUppdMctSs4rbbBBmpFJLtqjzogktidOf7nX8jUKlE1/GXXPdZrjU5BBSlWJzrv7xsjePKykuIXMhGX0BzTLMjgar+b5z+N1Np5FXbTY/enQ3qAflSH+bJSt4lR29qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 10:06:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 10:06:40 +0000
Message-ID: <8b5114bc-63d6-4cf5-91b4-fcbdef85e25a@siemens.com>
Date: Tue, 17 Jun 2025 12:06:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci.yml: Increase IEC test timeout
 for real hardware(M-COM).
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250617093642.1320442-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250617093642.1320442-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caab88e-6780-419e-9182-08ddad86a77a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NVhkc0xIKzdWaVdDV3kvOXA0NWFKaG5YelJOSXRNaXpJQnBUcmJZdzFwb1dJ?=
 =?utf-8?B?cFg5K1RYekZWaVh6a1YzdGhqekEzaERnUkJUNlV0STZHTEdYQnprMEludks0?=
 =?utf-8?B?MFB5Tko4Zm1LZlplSzJ4VXZEamY1T2NNNUlRamlMOFpKbU40VHZ3TVNQUkVq?=
 =?utf-8?B?ditIZWJ5SFVxNVdJVkczUFI4OUtmODZnR2F1NkhsVmg5UXdpZzBLUFQ1aXVS?=
 =?utf-8?B?WGhkSmNNYmdEUGhCc0tDSm9pb1MybHVXUWR0a2pObzBLejJLYXhEUEp2QjRv?=
 =?utf-8?B?QStSNXpxUzhMSjVxR1cwbC81alJjVDQ1aW9wZ2x4ekptbFNoYktaVXVENWNG?=
 =?utf-8?B?ZWh2by9HelhoakxtVzExU0duRC85VGlDd2MyaklRbURwTmZiVVBzaVpRMzVy?=
 =?utf-8?B?YTVEdmcxUVRUT3dXbkJMVjk0N3pNc2RZcjBKdlArNnA4WHhteC9lYlFZYTdt?=
 =?utf-8?B?bGY4Q0dKWWJoM2xTVjFIRWd4UjBTcXl2ZHpjU3lMNmdNRmtxNWxwbHYxaGt3?=
 =?utf-8?B?eFd5cFVxZFNyVzhZUmxBbnN6MlMwWlRZUzVzMXhLTDA1OENRNnAvd0M3ZG52?=
 =?utf-8?B?TjJnSU5vVjV5Yzh2Sy9TS2hkeE5MSWFrbnV4MlhxMU5xd3NER3ZjYlhhTmtr?=
 =?utf-8?B?R29uWWVVNTFkTkRsU0RjOXljd3gxejBiclFsODJUQ3pyWCtXVGJEVXRuQUFU?=
 =?utf-8?B?WGRYZXdvNHlVRXdQOFNSS1NvY2RaMERubjhnQmtQcUdnb0t6UWx1blRVSTlu?=
 =?utf-8?B?dVdOWUNuWGVqdXBLY29KRWYrbmFnMkRVRDZSNUR3ejhRZmNQMlB0K2FQV2sv?=
 =?utf-8?B?cEo0Z0NwR2R1NCtaS04rTXE5emJnMVBIVXdpTjNNQ0pINWQrUjhLRTloWGs2?=
 =?utf-8?B?SWRWaEpsUkxCbGlKRXBMMGZDTTRmKzlFKzhyRmNYWUE5TGFqTjVRcGdVUDF3?=
 =?utf-8?B?V0NDZnEvY1RxM0lDaGF4ZE1pRGp5aVBwMHdMaUFlTURyRmwwcWtTVkh4d0hI?=
 =?utf-8?B?djhkOGVBK1NoUGtaNGtDMWVCUkxKamtycTFhWXFEWEM2VGJsWlVBQld6bUwz?=
 =?utf-8?B?Q1VBd2VkeXdEakZvZm1jaUwwRUtiOUVLMUR4aisyVFBYcGh1cW1vOElSMEEz?=
 =?utf-8?B?ejhmWTY5ZnpIZ3pxcmw4OHFUNDltWWRCT2wvWXloQTk2aW1PaXJXMERjMk1G?=
 =?utf-8?B?U2NKVzlOWlhJVTJheDBaWkhnRDNuNEhzc2VlNUFiTm1wYVBiUUV2TE1vN05D?=
 =?utf-8?B?UmhqV09IeFZnZHhEN1BldWFvZEVZYXYxN0VzMFBEdllNRVZkb0J1S3NCYm5R?=
 =?utf-8?B?RDBwa0ljejJiTnZTV1VYS3VSWm1JTC9WYlJ5UC9mYVZDd3RMSGpkMDN4dDBn?=
 =?utf-8?B?WWhhVzVQS0d0bnVyaXJPL0tORHpIWm12bmRCTmFvWnUyTTlVZUZHQjlhNVNl?=
 =?utf-8?B?WGtJVUlubGt2dEFReEJWOVNSWWFPNmYvYzV1b0tZOUVKakJubGI5MVJNUWpv?=
 =?utf-8?B?WWFmcDgyOTFIdGFPS0kwaENRcThRQnJCMlc2enFGSFlGVldmR09YbmdrYmIz?=
 =?utf-8?B?TUNBeVYyRlorOGJlbkVLTG4zYmNOQVdjbXIzR3AwbkEzVjVLWjNCaUpRNWE1?=
 =?utf-8?B?UmtyUzRrMWFKMUlibE5NOUFJaWlqMWVsN0Zta1BIMk5jYnQvK0JjeXV5V2VV?=
 =?utf-8?B?aUpEYldsTmUzVlEzZjB4NGIyZjF0TlBrLzY3RUJDTERLeHRLNmJ0eUUwRUly?=
 =?utf-8?B?WHdPWlE0Uy9yT1hSNE9zM1ZsWGN0ZVNYblJiUVVVczF6QUVlaVNaRjRCT042?=
 =?utf-8?Q?UEKM5dbND66gPan4qY+SrPwfAF5nYBh6ueqo8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2JycVZYYzgyakRrcURFeW9jMVUwUzg5RWV4M0cvQmkrUDBKM21VUllwSnNR?=
 =?utf-8?B?REZhaU5VeUtSUk9jRlhjV1BWNUdkT0RZdU1SS3Z0TzFaK1p5VkkvaCtvWGtR?=
 =?utf-8?B?MDdwbXZEd2FmTXNLT3ZmckJSOEduMmFFbUVhbzdZUS9pTWJhaHpaVDNYUVpU?=
 =?utf-8?B?Y01MUXpTS1N6MzJsNDlnWmVZTE8xdlhlTEFYTXN3VzRqaVNZODZ0LzU1MGto?=
 =?utf-8?B?Ny9FRStqZXFyOHlNY29vMFNqd29WbmxJNEdhQ0lBTkpRcGJyUW5kVmh6cmYr?=
 =?utf-8?B?RWFNVlNxaTlNTzQ2SDJjNGZ1djRuVmdUV3R6a1RmMDdpcjFKMWhnU0Y4cE4z?=
 =?utf-8?B?UTlCNm5BVXdJemZiZG1zL21ZbDYyc3NGTUdTb21EcXh4NmQreVBUZlVybDlH?=
 =?utf-8?B?Zzd3bU1WRW9DWlpGYVlFTWppdUdHb3dTeUU2YlFPLzhqZ1Y1ZkM1RzBESWg2?=
 =?utf-8?B?ZkhPTDhFdWtyZ1U5VEtLVXpBS25YUXJxeW5QVTdnb3BvbXhDamZpZUJQWk15?=
 =?utf-8?B?M25zUFdTVEh6YnFENk5FbFowYk5ObHMyaXlYZXFlS2hxN2JyZGwvOVc3NURU?=
 =?utf-8?B?alQzOFU3ajl2eFFzUWN6VENHY25KSUo5S05Tcm55T2dRNXVLN2NTcmFnN1RI?=
 =?utf-8?B?cFF0ZER5OGhjQnl3Zyt1YThkYXQ4b2k4ZXhZeHdmZStsa2VHYmhtYUMvK0RN?=
 =?utf-8?B?Tmc2OFloZmRSTXh6b0JZZERnRXN2SkN5STFwenFUejlRd2J2dVVqQUhPcFJt?=
 =?utf-8?B?OWx3U2kvOXFvdzdKOHFvZjlOd1lNWXJnZnptTkVuNk5PbXJKWittS0VROVBa?=
 =?utf-8?B?WEZjNU93SlVybDF3cEdNWU1UUmROYkpJYzV5ejMySnBWdytSNXNjYlA0N09s?=
 =?utf-8?B?WTlaaWJyK2FMYUhpMWpHYStVV2RobnNBWTJ0U0FkTE1oYng1UzZ1V2YxaHlI?=
 =?utf-8?B?UmhkUE1OZ2xGelIrTmNLVXRDRndWZU1UbzdjZXB0bEk3aE11L2NIWXREamlC?=
 =?utf-8?B?UEQxUnlURXk2eFRNdW9uSzVwRldjNjd0QWpzS3lsM0UrZEZKWVIyc1c1QVNq?=
 =?utf-8?B?aUdKVmFJRGRNOGQ4Q0JLYUxSM0NLY2NORlpiTkpQR3E0Nm9kTm1EMHJTbFF5?=
 =?utf-8?B?QkxBWHNKNmhCZFNhd3pUdW95ZCtkSk9mOFF2V0k2blFpc2lMZk5HTFZFNlpt?=
 =?utf-8?B?SHZpTWRCcjlvc3Urd2g3QmhUY0NycVBBb3dmQ1VLOWErTko1QWVEcXRnQ3NN?=
 =?utf-8?B?U1ZkZC9RTHBQb1M2ZUZhbzhOSGwzWks2cUEvZ3lLbUFNWFlHcFc2UzVXNXh6?=
 =?utf-8?B?UHREVEtOQWNscjdEQ1lkMlJaWUVpa3NISTFrS3RPRzFpYWJUV2pzV2FLaCt6?=
 =?utf-8?B?WjlXQnVxRWVPVVZneXM2dVBWSmJvcTJNWGVTOUZySlZMZU9hKytGUTUzNUp5?=
 =?utf-8?B?NjBKL1ZMT1lKcnhLR1poUFdGU3pINHlWaElXU2Z5TmZVWksrbWZONlMyTWlR?=
 =?utf-8?B?NFB1Ni9CbVlCZlVEeEpoYzhWWlVTVzFtQ25HUkhNZGl6NXduc2VjTGtRdEsr?=
 =?utf-8?B?dTlEY25zdnlHbGwxV2IwYkZLb2dJZnlMQ1ZtK2FUTkxMbFE4Tm10ZmFYSGpR?=
 =?utf-8?B?ejBBQmlvMTVKMUpjaGVZaGNXNkhZbXRSZkx1eEpBeHJLS0dkck0zYkFqQmlw?=
 =?utf-8?B?WGRTK1FOWmppUjNpditFa0t3aFJ4YVoyMmpFeUpWYzRNT1dSTktJZVl1R2lB?=
 =?utf-8?B?MUNTVkpHdy9ocXRhWDhjWHVBd2EySDIrWTNLVzdXd3J0bXdrTVZoUFJCNUZP?=
 =?utf-8?B?RWNoN3h4bDBPUWZPV1VHZTNWWnZiY0VjYlJCSjdnUjAwbENhOU1vODQ4RDln?=
 =?utf-8?B?dlhmZUFQRmFPVUlXaEJHNitwVmZqVzFBenYxRGg3ZmFTWjArcUkzNk1XQWx5?=
 =?utf-8?B?TE1va3N0Nk0wRXg4YVpDOEM2UjNHWnNCZHFWTWJrc2VOT0h6eW5DcVQwQzFP?=
 =?utf-8?B?d2Y2OGtGL2pQWTJLT2NrTGViaG1JZXRDcFMzaTNBYWpUOXdWUTdsM2JRSnZS?=
 =?utf-8?B?NUE0RytYMGZUV0RvRXZUaXhyVVhqZkQwb1hGa0lTUHBoSUROS0pVVzZ3azBn?=
 =?utf-8?B?RWI0TU92a25aQkttN1dSZWJMWmRCVC9kbVBRNytKdGFIMGVwRVlpcm1BOUxE?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caab88e-6780-419e-9182-08ddad86a77a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:06:40.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEJPJKEFO7wv1aKnyn2JjJrCZ/HKdu/eMmTQL1v2bKMLjTiHeS5LPwD4YrlsP5IXKTPEvh+FNL9p8ziNUHNR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9028
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 10:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19119

On 17.06.25 11:36, Shivanand Kunijadar wrote:
> Sometimes the current timeout of 60 mins for IEC tests execution for M-COM
> device on LAVA lab is not sufficient. The gitlab CI job fails due to timeout
> issue. Increase timeout to 120 min to avoid CI job failures.
> 
> It's a temporary fix, so need to explore the reason for the longer runtime
> in LAVA setup for M-COM.
> 
> [1] https://lava.ciplatform.org/scheduler/job/1281301
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ca52a05..f7a8127 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -458,7 +458,7 @@ test:x86-uefi-IEC:
>    variables:
>      target: x86-uefi
>      test_function: IEC
> -    iec_test_timeout: 60
> +    iec_test_timeout: 120
>  
>  test:qemu-amd64-secure-boot-unsigned-kernel:
>    extends:

Thanks, applied.

We are suspecting that our reduced I/O performance of the M-COM setup up
(due to USB disk emulation) is the major reason for the longer test
runs. Not ultimately confirmed yet, though.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

