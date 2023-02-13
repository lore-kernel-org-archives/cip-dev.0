Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C8DC636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:45:48 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.50])
 by mx.groups.io with SMTP id smtpd.web11.16037.1676299541493629868
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 06:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LUYE2Fck;
 spf=pass (domain: siemens.com, ip: 40.107.105.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYyYFsr7DCiLJkwNA9232RmgjDLnvT3F2smCd8NNN50ly1LkRGPtTcKQ7FpOCKeAW90nkOsiczPmz3Z8OunE49oGeH3uLAi7M0N4sP3DF09ik3+TE8w2MkFe6aYYQWPOONhaCDGd2pBGGtPbgfN52u4rSpBSIpmMOOOoALQCZTpDG5AVhuJCFghzR3YJfnMZffANLfvtZn4VxZ+NA7mFPK6xh1yHUGWLlUG5PJIJYcCMv2hldBEa0NberOdGLZqPXQqm+mHdOPToj5CONLDGLr5xWoQ3l7U/LTEISENM2tECQdULrK7t3BIDA+wNR3OtdeT0SnyAz4Z3IO/SBOZFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCi1Cf92ocsZHX9tFaK+AXqOLaIEDU4Wo9Wm8MGN3Go=;
 b=ZHYQW8tKVhRbN/VBvyeVCtmnVduPKd4fhcIop8EnIWdgIb1MuQO4tp0XxzowmF/fvLAyoSi/EGxHmJPMiddir+5EqqQl7liQ26kVu52uy0Ac3cNPGL8TQ0AniZpRKlxWtORWYd9+0/2hESxE00Bs88+DGuhl8lmTReRJVLzbSqTlWUHdgKJaqQobo8VurhBZo8+/YAQCzXyfsbjupzyWXHv3zm7vgcCbjdvw/YaI762qM2Os0INdA8vStgQwvMh3WyJWvE3uHy7lCfGkWk+DrNlGtzm0Z4iYXXQ8ULUNHT3WPwoA/ghXKwNooAmCX6GAINrf0iGRShTWtb5td10NAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCi1Cf92ocsZHX9tFaK+AXqOLaIEDU4Wo9Wm8MGN3Go=;
 b=LUYE2Fck8ufGcLQYMLKETUKfQgGzf0xITeZHZ0C/8m+1WtF3MlM84VwxuZ2v5CJKpo2q/EMQpi1h0juVwbSxYMevwcxExowvXXfydpUG6EFx6vuMJMn9qumS+sL/KHv+BkwepScB4vbG2NPqyzobU0ppqZ47TtQ+xUMfeNCQvslo/7/j+zuO/KlI3m9VA5fefFyGrxBgqiraCjUK0ew78b4+be17Y6q/BoS/3kRbqD6V6EIUmt9AQngsdMBLMy1aXNsqMdvXrF05vLFaoTNkfUYLetd5rmpeW55oyfHjLnZRocXm1vsqBM0ruiNqmhakpwjK/zUV3uK0DV6PZhXs+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 14:45:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:45:38 +0000
Message-ID: <938b99f4-a7c9-ed00-1005-0b2f0a489fbe@siemens.com>
Date: Mon, 13 Feb 2023 15:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 3/3] wic(ebg): add support for riscv64
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
 <20230213085741.1242658-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230213085741.1242658-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3266:EE_
X-MS-Office365-Filtering-Correlation-Id: c05ce281-f8c6-4f95-9744-08db0dd0f86b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Dw90/pV6lRie2i014Pbkc63TUaQutc1NQjMe2xHA9NWnJSaO8BiCy6aJHNLTh/ftJm1SEcpPlJdfCC+eRD6FDyCayPbaO9q3QO67M6MOnRkhOu1c3hv18jocY2Ujlh/09IIKN1FXslOJAbnZ42s4SG9HUZciocVtTpHG8+3uwXLS40TySN1DOb/JSjf784rX/7Yq8g6jDU7JOZIpby5/mNgr5St/sIY/RWF6MS70vWdwo3H7utxtL9wiCM4UdskUbARfYxquSrNPXr+Kz+tUrZDAmRoH0rWtI7Csf35n6d/UVrDfVIDcvQR2bsoXdEZ/mXEZYEN4wmR0tdPWSkMcxi93oM4mdyrkx+6ZWj9uqEPxLh7SljuNXUAsJboJra6Bu0ASJkVHOtw6y9wqQf6+zJsEAaZTIHifagauqOJfGpPpVerH1hj5mhoBT6HappdujHQXs4Fof2n4kqGp1cXgf2cawkGyHZrEEN9x5dauSKm7u+eS5/leGSkX5+Q5yhALHC5RTrfJO/rzoeuaddL6f0Hya+WbbCfNx3s04DaPsHnI3tqK173xLc+xhkONuX/xCpaTKjOQDuNQlfZtaz/NpgoP5Y9OXZYJtmrkl0tmVlQerBqUyWcAw395Z2AdkLut3Fi378pJNor63TWv59qmNgrToOnNUOim20UE2VLetsH8OV8mvCyySZbv5PSborTH2Pns4gbPKCmayPi+ArSAb+zQW/t5fwFmnTPhskAsoI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199018)(5660300002)(8936002)(44832011)(66556008)(66946007)(66476007)(8676002)(83380400001)(41300700001)(316002)(4326008)(82960400001)(86362001)(38100700002)(107886003)(26005)(186003)(6512007)(53546011)(6506007)(6666004)(31686004)(31696002)(2616005)(478600001)(36756003)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V29CeHp5T1QrUWg2QnYxMWVlWGxYTkhwaWpRQ0ludGgySFEzYTI5M1BnY2Zu?=
 =?utf-8?B?dzNaODJOTlFXZGFuREtCTmhqM2FveWlBd2FXWEtKVmh3QlRrRERLYkw1SFgw?=
 =?utf-8?B?dkM5eUVsMG1CWm9GMHVaeit1VGpVYXZyTTZZR3BCT1VRNFZxWWJWRXlSSEJN?=
 =?utf-8?B?czJ3NmtXaXhrVzRLdi9JSTBTSEhBbWo4S3NrWXNWenp4Q0xFcVoyWk5HUmpq?=
 =?utf-8?B?cExUMXI4STNndmpCdFNpekM3YUlUSXYrb3BjeE9iSk03SitQNzNZcEJUelJO?=
 =?utf-8?B?QlIvejdDOEVKa3JSelpNV01UaEM1WW5QeFZjeElDWmxmWmZ5VUQ1OUdHVmZ3?=
 =?utf-8?B?TW1zNmRlMERZcUZnTTFxSmF5WlgrN0VzMXN4djZoaytnejl3WWhMZC93M28x?=
 =?utf-8?B?Nnd1UmtaTDFHU05mWTAxZlh4UjlKMkFZUEJJVHJFNDZyOExwa1IwSmFUZkFE?=
 =?utf-8?B?YlB4Q25SaEd6YUtxcTBCWDkwOXd6dU5FUDBiRDIwNXdYMFFwejNZdUdSVkRk?=
 =?utf-8?B?akdHTzdBUTE0aStrcEQ0U2RweWRqZk04UmNZSktnYVNwVzFjYlRhcFo5bjJO?=
 =?utf-8?B?SDdUcENwcEEyWDlORDVYbndKWkdLNVFDZUZkeGdXNzFkVXUwMWlhSmIydGVG?=
 =?utf-8?B?dVgzV2M5UHFMb2YvOE1BMVZ6d09wWFluZVpGaFR4SVB0bUVTQjg5NHlPVFEv?=
 =?utf-8?B?RlhsSHIzUC9pdWZqTm11SFYrTkRFbmE5d2JUSTJrWjA0WGdqZ1NtRXpaUFlN?=
 =?utf-8?B?eWlKSVMyTVlpWlF3VU5WbmhNNU9OQUFER002bEc1SytQTEt6dGhTbGUxNnE5?=
 =?utf-8?B?OTFudTVRdXorRmdmQk8vdFhuclZ1WlRoTUlmWU1aUnhaVTBFeVdSVXVOUE5N?=
 =?utf-8?B?M0xaK2FRZ2UxeTYwN1gxNklObDZYbHl0LzhzdzlSYXZuY0xuSW5seWZkaUxx?=
 =?utf-8?B?N3FsQTZXN1VOTUM5aktYUFdBRVJjVjk4eDZNTERrNWNHcEtiWXlmZHE2T0h6?=
 =?utf-8?B?LzdpOWFHeGIzS0hlZGNpbkVNYVVjK0xpZ1JsZmhmNHhadUh0RDNidE1jQnAz?=
 =?utf-8?B?dXNwTXhieGlPU0ZHcDJ1S2F6d2s4V2wyUlliRVlQR1I5WVdaV3BwdlBHSWky?=
 =?utf-8?B?N0lMMU1HRTgyL3U1bjJnbEhiOW1DeUJyVzNKclN1ZFJEZTR5VXlQYk5SVkU5?=
 =?utf-8?B?dzZESWJ1Zy81VkR1TnNZRjF6RzE1ZFFwQmNhU2VCM1RhWHVRWGc3endOSnhk?=
 =?utf-8?B?RnpYVXdmZ0JVbi9nVlU1eXVQakM1bDhNVzhWTmRuckx6WWtseUlPWGlYVEhh?=
 =?utf-8?B?YUlpYlJIM0QwUzNZMmtlejB4WU1ra0pZZFVtQmU4K1RFT044K2ZPQXpMeElI?=
 =?utf-8?B?VTl6aUFWWnZzclJKbFA3NGZRb0Zyc1cvSFRQQm5tYWtoZEFGODlXMVZ5a2Vz?=
 =?utf-8?B?djR6ajNaTXUvK01tMGZHYldlZnNNWnlMb3VtVTNQekg3V0dhVnVwck9mU241?=
 =?utf-8?B?SllzVmhJV2JLenhIZmVFWDhndmp3SlZybWxraU9PRUVHd2tXTnk1TlpFZ2lu?=
 =?utf-8?B?V3RuYThjYVdwNXFrejhaTFQwUUh6QllhcWJLN1lSRUt5aE5NT0lMVjNrTDVl?=
 =?utf-8?B?WHdoSXlodVRRUzg5S0M2K0hVNzg1RDZCL3pVbURuTjh1OVNaSkZ2RnB0SXZT?=
 =?utf-8?B?KzZBcUpkUUxEMkZwdUpZYlh4ZUl6UzBGaUZ5VW9WcnczUHBnV1FNRlpDM3JY?=
 =?utf-8?B?dldZMlFSMG9kTzA1eGhHSXo5UDZJRmVCVjVtOUhtY2FNYW1oYkJlYjBRQitv?=
 =?utf-8?B?KzFnRGdiZmVXcVRCdHJ6dDdBaE5XWHVBT0x4d3hlbW1wSytabmk3VjZGTE9Y?=
 =?utf-8?B?QVNvQW5qTUxpTmpKMlAzL3RlL3dLYkJTRWJkY1NiOVR4YTZhQWNWMjF6Q1Fz?=
 =?utf-8?B?U3RvV2Zid2MzTURjbTExbG92VnVrS1hHNjBsWU5rSVNGcnZ5ZVhha2EwYWc1?=
 =?utf-8?B?SFU4aDZBQS9VQzc5dWtUNEdyYVhEanZidlpZemNzbHFNSkxHWEkzeVhNQUEy?=
 =?utf-8?B?MGFGY2REZ3dDaFBFd1dtb2VHcE42aUpSV28ybEc0VUV2U0xNTTEycFpjL3Vp?=
 =?utf-8?B?aWgvSEFCK1huNEkzMWt6dFVwam1XcE1EZ3Q2QnNoSUJ2N0JNeFROdjlqUTFN?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05ce281-f8c6-4f95-9744-08db0dd0f86b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:45:37.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpkhAuSW6g76EvBIfIL5AhTyA37d1bFPrJLG3+c6GzvH9J3cjGVBrRTGtzz9MBRlVa9KzyNTlXJSvAog779t6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3266
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 14:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10680

On 13.02.23 09:57, Felix Moessbauer wrote:
> This patch adds the mapping between the efi architecture and the distro
> architecture for riscv64.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 6 ++++--
>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 3d6b2d7..0de28ca 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -185,13 +185,15 @@ class EfibootguardBootPlugin(SourcePlugin):
>              "amd64": "x64",
>              "arm64": "aa64",
>              "armhf": "arm",
> -            "i386": "ia32"
> +            "i386": "ia32",
> +            "riscv64" : "riscv64"
>          }
>          distro_to_lib_arch = {
>              "amd64": "x86_64-linux-gnu",
>              "arm64": "aarch64-linux-gnu",
>              "armhf": "arm-linux-gnueabihf",
> -            "i386": "i386-linux-gnu"
> +            "i386": "i386-linux-gnu",
> +            "riscv64": "riscv64-linux-gnu",
>          }
>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 2d16fe3..d6cdf0f 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -56,14 +56,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
>              "amd64": "x64",
>              "arm64": "aa64",
>              "armhf": "arm",
> -            "i386": "ia32"
> +            "i386": "ia32",
> +            "riscv64" : "riscv64"
>          }
>  
>          distro_to_lib_arch = {
>              "amd64": "x86_64-linux-gnu",
>              "arm64": "aarch64-linux-gnu",
>              "armhf": "arm-linux-gnueabihf",
> -            "i386": "i386-linux-gnu"
> +            "i386": "i386-linux-gnu",
> +            "riscv64": "riscv64-linux-gnu",
>          }
>  
>          distro_arch = get_bitbake_var("DISTRO_ARCH")

Now, does the swupdate image work with that already? Can we enabled it
in Kconfig then? Or are there more changes still needed?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


