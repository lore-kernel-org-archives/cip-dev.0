Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.890.1795020089858829884
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:41:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=phvsbUJi;
 spf=pass (domain: siemens.com, ip: 52.101.83.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtCZkttStuaBeIcDdN9HwIxf8RZgw5KJk0HhWomv0/kudhM2db4VcGlom/2/6EyNG5Jj9gGDsNkVVs4FTbDcobR6yRmuHw71td66I0LJy0Ii+SV6f9gDoS2GoaceE2RpI9CLgv3jo4t96QaMhCnCYgqFhiLWotjmSoz7/YjO2P2sapJFHpErqx1OJZWAu4VyFHZF8xN12PkjuHEXuzOaLacljlQGoyDRLZNKNvYM4xreD3f2qs+RIbYPT2iaklnMxVTkMyJ4G0x7AvlhavOX3JNiUG7YiBAKSf5KFOYi12zoltKIhVjGEjNowVOJcwtbuIHVy6zpJzMM0h8EWMb04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnurN+EG72HLyr/nrJYjyudwi5N1mqqTyhZN7lkYajo=;
 b=AdDWKuvOtZ4mxChIhPJgrAoR7iYQJgnPnO0RMZlbcC/rUSVdwSjYpHVqIjVGJU5dB5SnmSkUpY+J4N9rgOHTj/1TlaFJlBwlOJdApXtdUZEpb0utXIyIagm8rRkbg7r1zskZjXZCRrB3xIBjGzAqwS/Jdzz4BoH5jH/ZLhrxGolnlTkpWEkVXm69HHLpx5uzgsnWHP//rTTas9Es0z9euJp5bRMckFIx2FN1YrzNyu9hzaYFThZ6RuEF13vWSa8Q5uRBpsCRqcELSC2IOyxO/yljooIuIiT24ZzKQrwG71K/KRdJY71jnu87AKR67eqHl0z4CkAQ2PgJ9xxyTL7wXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnurN+EG72HLyr/nrJYjyudwi5N1mqqTyhZN7lkYajo=;
 b=phvsbUJil4NhGsFqOkWjcWsLmS1bTFEiqRiZJMB4Gs9FD4qxpuzH18Ng2HZJ5t3IVF1i77UeLkcTmNYOskWFinLK/vBUOTA48PIDHg0LWG4s3o9TouaGFYn+tq5qTSJB1bDDy+46zH5BIkExMaUeXjljnhfAnSHHDZxUacNE385yZiLLy4j3Bwz+6WBFR330x8TnSlYxmzVfuFqUjlo8Ij2DNjwIpa51cI9DJCsBDA96nz39700vCMunyrpUt86cpmkoJ1fUAavU3nC+gheOxXMZi0h18hyE3W4K8vzSuCRBqoIY1QykXVidkQpO7YHYo5WM4+fJYKuGpg0y0LfCgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 16:41:24 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Wed, 18 Nov 2026
 16:41:23 +0000
Message-ID: <f37d9f15-1ce7-4aa8-a925-6a4f3889b4ae@siemens.com>
Date: Wed, 18 Nov 2026 17:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Drop ext4 build as default
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261118125450.620231-1-quirin.gylstorff@siemens.com>
 <8906c84c-2b82-4a3b-a83d-844dbc061936@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <8906c84c-2b82-4a3b-a83d-844dbc061936@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 73110f83-7b19-4743-ad93-08df4592c824
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|55112099003|11063799006|4143699003|10067099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261022115727099003|261026121527099003|261021123027099003|56012099006|261021121427099003|261102123227099003|261009223027099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: xR1QkJ0xHw/E5/QfXAiHDphflxmUIqoCxLJsXnByF5wn6uSyx3ZpTyGnh1AxzFfDdUVVBnvZ3DKctC2qVCxKOwIPU+vaIRadHMI6P5iSV7OVwnyoNEdxQsMsFcor9iPvP/aZtle6xMzy8x6PQ6kCEWKNLU92hdmlM7+3RIa1/cockEYVLKuON2CupPq4geige7Wx1/Tpvfmbt1+iWiJWWaGjnrn4TQts0rKxrh/MlaMgPVQfkGW31bOiEAFZwShB2LZbyk07iRyyqM5NSvIogt8q+7UT1TJuwwOA6Pg+qHhCWMgxT9rZAQNYw/NnjtfFFP6t+4IuFAgu6XtUO3r4DAYgjF5kfUjpa1CXqqCaJ4Gtv5aanwcMRCoSejgBCVkgV7awd0ZlkuvknfYjiJ6s8u53p6JeHPmLs50bzZnNgMFz5xKxBolS+C9dIRa7Fz/a5e7OxqqZ8ykWIczJRlyCAH5+IbccLAKqCIxm7gpgSt+eUuA6l6KHE6O30aXkyd2vJTbcSVkpz/SG1Zikprekcxfz+6GdipLsM/2/mHM5ghmUHfuNxo3W4wyZPutSv6/LhfAggAEYNmh8i23P7TdEkaWCbBfD53BQWPFqn3FwXS19opkPhv34dlG/tLAZbVPV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(11063799006)(4143699003)(10067099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022115727099003)(261026121527099003)(261021123027099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXpDU0hIaWpVY3lTRmtQejN2SW1vSjdmOTNmNWp5Rm8zYW0zMkp0eUFFMy9P?=
 =?utf-8?B?MVppZHZ5QjRoa0Nxb2hwUUNyYkVIV2dISlZtTDRPM29CL3V4N2V1dzJsbEZx?=
 =?utf-8?B?VFlHOEZTQmJHZFVLWjdRL0RQMTAzRHVrOHB3MVRGTllTQkFvcUIxUGdMcmtF?=
 =?utf-8?B?Z3JNTFUvbU1iYy9kck1GbGxrNnlySlZuWDdjVTBMRnh5VUNOMGFhRkRZdS9y?=
 =?utf-8?B?SS8zNXZwaHhUTjkraVcxMENZUjZiRnNSZGxWeEx4L2dvWmdxVVlDVXZHMUZy?=
 =?utf-8?B?dFBLc1dwT21mQ0EwRjZ0V2hHdXlQS2UxRGRkU1Y2L0pLaFc4TTlXOUppLzFP?=
 =?utf-8?B?Wk9jbnVrOWMxNW5wQkxVck81TmlsclRlTjRKMms1eDNTMVdXT2hZK1NNTTV3?=
 =?utf-8?B?UGJ5M0l2NHVxZzI1MTlXOFhSRXAzcUhZVXhEc0dlaHRpWjk3VGh3TmV5TTFI?=
 =?utf-8?B?V0tmVlk3NHZsVTJrMEsvS1M4U3NXK2dhSjBxUGp4T3VjRGhHai95VklkUXcr?=
 =?utf-8?B?eDR1K3hubnJpdzlJZkIraXNFUjZBd2ovZG9Oc1RjKzBuaklHZldKdjlVTmtS?=
 =?utf-8?B?SnQ5TkJVaWNyNXpFeE4rNUNyeUJ5OGROKzBFNTYyV1h4dnpzU1c1VU5CcExL?=
 =?utf-8?B?ZFRXMUk0eW9YQ1JJbElJUXZhaFVxcXFrZWVvbVRCZExWZElhS3YzUThqWXY2?=
 =?utf-8?B?STlmQWgra3l4RjYyTkFlY2RDN1NyS29uYy96K0M4V2RPQVdSbGRtb0grbk01?=
 =?utf-8?B?dkE4ZlJldmladTc0d2RrUk5ZY2EzZXpsc1BrQ3BYaVRhOHdibkovbGJ4MGd1?=
 =?utf-8?B?L1FCMGdYcWRlZUM2TmNYZWIrSkJJUTE3R1JJUi9RMFZaQURXeXZnd3dZUzE0?=
 =?utf-8?B?NlpiZ3lZL29KbEpJbzA1STlxbS8rZllOTWlFYVdpN21RUkwxd042clJqSHgv?=
 =?utf-8?B?K0phRGxFYjVCTHJWU0RORmJteDVGREVvaEVxSklBYU4yOUpOUVpleklTaUp5?=
 =?utf-8?B?TUFHanAwdmVVWlVDaWZndllIZENDTUttNGNIV0Q4LzJaYTFjdTBneHIwV0VS?=
 =?utf-8?B?Z2RqdXlERFRMVkhkWTM4bCsyU08rUjFKNmNFRnFSSk5aN0tnMlNKZVZzR1hX?=
 =?utf-8?B?ZDlUMjRoSHFZblA1aHBDWkUzSlRPeWRuUUtQWDdYYXFHcjM4Q21MU1hWUU16?=
 =?utf-8?B?dEhQcWV6YTNReENNWHhvS296Y3hQcWNzY0ZJZHFGUzBhVFFQMEErR0tUR1Br?=
 =?utf-8?B?djFGWC8veklhd004cUZPOXNocmdWY2RJdEJhSGhtMEt1YW00d1dXWkxZeUVx?=
 =?utf-8?B?dDM4QzlHeEhQa0ttQmVOVE1CVmpkT2IxZElTL1NvN0JxYlhiTm5QYkhBcVE3?=
 =?utf-8?B?enBCbjVmVkxIdmVvYk1zdVRsVGVHTVA3d0FsSWdQWWlJNkMzL2RGZERweWxr?=
 =?utf-8?B?cUhPSWJnMnNIRmQ3SzZrd05OU3ZDRXJ0NnRvaSs1Q2NuRnROV1ZuKzZYRTZw?=
 =?utf-8?B?ZnhOa1dIV1JScVhEQ2NNOU5acXlkajdnb1BXRzIrMzlrZFBnQmcyUFdUTWRD?=
 =?utf-8?B?U1ZBRG1hcG9la2ZWTXZlTkcrZ0RKWE83U212Y0xnR0k3bHRaY1BVR0E0YXAz?=
 =?utf-8?B?R2ZrUVZJZHdiSXV3amV6M3N6YjYxQW9aL2pzeW54TkNuUlh0WUN0V3YwU0hm?=
 =?utf-8?B?SUNLZFdPcDNxZ0IzdFRLKy9LZ1VEVUgxdmc4SU9hSndQK2xzZURFU1dKSVU3?=
 =?utf-8?B?OXY2MFg3Q1JmVmowOStJTjhXNm5Hb3Nlc2NKVHR3TEhaREdDNGFValBQdmhY?=
 =?utf-8?B?Q2F3bGZXclIxRmd0SzJsV2x4ajI1RFVaaFl3bjR0OXI1bEplTVZLejh6Q0Zi?=
 =?utf-8?B?NWQ4NVdYcXdPNE9rbDRLR3lSc0VSZXRpYlpLYlRaUXFPenhuRnRad1VQSjVa?=
 =?utf-8?B?amx2R3hXK2xwcG5OM2NyRjdYZld5Vm9oWjJlYU1lZUJjQXZ3OVJiUDBPY05P?=
 =?utf-8?B?dWk4ajNYRUtQL3Qzb3A2VFpMWC92SFVXMldwYU5wZ0E5ZUNGaVQ3SnN5alBF?=
 =?utf-8?B?MnphWjZBaC96YUNDcGZQcElwTCt6dmQzSWlNVUx1b0ExYnFVQTJaZ0h4cmcx?=
 =?utf-8?B?bkhyc2VhMmYvdXp0VjV6U2tGV1pYb0YyeU4vN0JRNUxoTXpaQjl4OTNQNyt4?=
 =?utf-8?B?c3ZJTjBBK3ZUanorQjBrcm03MDJlNUdjdTloaUNsU3Q2a3pjL3haL3FEa1JP?=
 =?utf-8?B?ditoaVY0alcybzBQbys3UTlPQ3I2dEt6MlNJVm1PY0dYZDVORkxOdVRoazl3?=
 =?utf-8?B?RTdBSnRWOWZZZElBUHovV2NESDhsVlFzd0tpTlBaWCtsNlVWRkdkcnVaNThK?=
 =?utf-8?Q?Ai42G1ty/KuJn2mk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73110f83-7b19-4743-ad93-08df4592c824
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:41:23.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9pR3tEZKlp2cb94GLltwUerCaYA1pUOvakE0T8oxgN63s8OXq1+enGWmUhyrijPoGr0LRQ90xj7Pydh/13mPfEb4+Si6bolhqNt10sxmDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:41:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24962



On 11/18/26 1:57 PM, Jan Kiszka wrote:
> On 18.11.26 13:54, Quirin Gylstorff wrote:
>> Only the no-kernel builds and qemu-risc64 require the ext4 build.
>> Make wic the default and set ext4 via a kas option.
>>
> 
> What would be the benefit? Or is anything broken with the current setup?
> Not voting against the chance, just looking for a reasoning in the
> commit message.

This is original a fix for 
https://github.com/ilbers/isar/commit/6393523290ee4bf108dc7b0a4337720dbf4602c8 
as it removed all intermediate images in our case wic is a intermediate 
type of swu.

Felix recommended  in the meantime the revert of that commit.

I still posted it as most of our builds do not use ext4 as an artifact.

Quirin

> 
> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> This needs an ack from Chris and/or Iwamatsu-san
>>
>>   .gitlab-ci.yml                 |  3 ++-
>>   conf/machine/qemu-amd64.conf   |  2 +-
>>   conf/machine/qemu-arm.conf     |  2 +-
>>   conf/machine/qemu-arm64.conf   |  2 +-
>>   conf/machine/qemu-riscv64.conf |  2 +-
>>   kas/opt/ebg-swu.yml            |  5 -----
>>   kas/opt/ext4.yml               | 18 ++++++++++++++++++
>>   7 files changed, 24 insertions(+), 10 deletions(-)
>>   create mode 100644 kas/opt/ext4.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index bf21e744..b9a2895e 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -71,7 +71,7 @@ default:
>>       - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>>       - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>>       - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>> -    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
>> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml:kas/opt/ext4.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>>       - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; fi
>> @@ -173,6 +173,7 @@ build:qemu-riscv64:
>>     variables:
>>       target: qemu-riscv64
>>       use_rt: disable
>> +    extension: ext4
>>   
>>   build:beaglev-fire:
>>     extends:
>> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
>> index 748aaa33..09b322b6 100644
>> --- a/conf/machine/qemu-amd64.conf
>> +++ b/conf/machine/qemu-amd64.conf
>> @@ -8,7 +8,7 @@
>>   
>>   DISTRO_ARCH = "amd64"
>>   
>> -IMAGE_FSTYPES ?= "ext4"
>> +IMAGE_FSTYPES ?= "wic"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   
>>   PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
>> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
>> index e0fe9603..f689a85b 100644
>> --- a/conf/machine/qemu-arm.conf
>> +++ b/conf/machine/qemu-arm.conf
>> @@ -9,7 +9,7 @@
>>   
>>   DISTRO_ARCH = "armhf"
>>   
>> -IMAGE_FSTYPES ?= "ext4"
>> +IMAGE_FSTYPES ?= "wic"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   
>>   # watchdog is not yet supported in our QEMU executor for this platform, disable it
>> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
>> index 314d1430..24afedfa 100644
>> --- a/conf/machine/qemu-arm64.conf
>> +++ b/conf/machine/qemu-arm64.conf
>> @@ -8,7 +8,7 @@
>>   
>>   DISTRO_ARCH = "arm64"
>>   
>> -IMAGE_FSTYPES ?= "ext4"
>> +IMAGE_FSTYPES ?= "wic"
>>   IMAGE_FSTYPES:append:ftpm-stmm = " qemu-emmc"
>>   
>>   USE_CIP_KERNEL_CONFIG = "1"
>> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
>> index 2158a964..44975e29 100644
>> --- a/conf/machine/qemu-riscv64.conf
>> +++ b/conf/machine/qemu-riscv64.conf
>> @@ -11,7 +11,7 @@
>>   
>>   DISTRO_ARCH = "riscv64"
>>   
>> -IMAGE_FSTYPES ?= "ext4"
>> +IMAGE_FSTYPES ?= "wic"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   
>>   # watchdog is not yet supported in our QEMU executor for this platform, disable it
>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
>> index bf540796..e28f523a 100644
>> --- a/kas/opt/ebg-swu.yml
>> +++ b/kas/opt/ebg-swu.yml
>> @@ -30,8 +30,3 @@ local_conf_header:
>>       IMAGER_BUILD_DEPS:append:qemu-arm64 = " ${QEMU_ARM64_FIRMWARE}"
>>       IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
>>       IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
>> -  drop-ext4-images: |
>> -    IMAGE_FSTYPES:remove:qemu-amd64 = "ext4"
>> -    IMAGE_FSTYPES:remove:qemu-arm64 = "ext4"
>> -    IMAGE_FSTYPES:remove:qemu-arm = "ext4"
>> -    IMAGE_FSTYPES:remove:qemu-riscv64 = "ext4"
>> diff --git a/kas/opt/ext4.yml b/kas/opt/ext4.yml
>> new file mode 100644
>> index 00000000..b9a3a80e
>> --- /dev/null
>> +++ b/kas/opt/ext4.yml
>> @@ -0,0 +1,18 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 23
>> +
>> +local_conf_header:
>> +  ext4-image: |
>> +    IMAGE_FSTYPES = "ext4"
>> +
> 
> 

