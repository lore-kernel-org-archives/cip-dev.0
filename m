Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0390CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:13:07 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8478.1778148778646937994
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 03:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PUvhWUOq;
 spf=pass (domain: siemens.com, ip: 52.101.72.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym0ROmNmK9zQ9phO6biSclK3nXW98DnXn4Y6jWybNrXSEkTRNWhylDAIJUoUUg+CDhZRIPvSJVdgYT12dS+uS2i5dPg6j0G9ss+ijcCvdp2aDE5DlvW4Ql+rOPsk8jKc+QA0Ik2FRd7nZAVUQ/B2XWSFBZEZ+8Dysb5PAOu4MYgwV83waJXp7IaHpmeuNrzgHe6tXYN9PJgsiFQ0Vcce/iSLTYR49S+DBW00KweBseoqiBYLIhdkKyfNx5XZEaG5Ir/X0LGgydAEmxQA/k6eZ1nGWx79yW7ogX/2v05HAGcLH8hOkt9GS4k7fxwIJgw/enbPTk0Jw60ZnglmDRi+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4SgEpkFQo2QIz4dpppIBPovzxZqat0dsF3+Pblgffg=;
 b=Hhquyt72lJzaseszMoDoxMb9uSy6a/wov81cM+cdKyjr9FmZ7E2WFxVr/PGF8NdowdD9Caojlj+H/Ig6dco4HS7QObipQspdVQJZsFLpu8rZJIBYjS+4U47U7g/2Cd76Tp8pO7TVYNMvqL/Hlbi6kcHnVwszK2IciF6se1jqfBisUZdoD3eny1rEmjvY7R5Ekl1X5U+hSWotlm3YAMBEo1HKsZRbO2RoNbhFiz9G0/eAE9/azOUqD5t0VGIIaFRg4qA3EU2I2N5igg0Syhpd5t2z7VugcVgqk/g9+kyHWYwpKMv44rbal+dhtP5X+pYgUUlxe8W4mP1z7CagRgK8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4SgEpkFQo2QIz4dpppIBPovzxZqat0dsF3+Pblgffg=;
 b=PUvhWUOqXuTfq0zKHYIZ+XheLVNCOD4dethUq4+dt9gbpxk6RNBpwGh0N0qYM2Q0SkGQzCbGMkPoAEngv1C8dad3AzKBqtd8L8TymL44u45YdTPO0zyXY3S7gto6OOyGbauWTelEGNNmAqcr4X4wD+/FiOrsA1xNBdl3j0aaQdeeuQP5xR9FhTkhbeju+LrM4R2cPUn2QhLJiCywvSHq2AJTe3dDhT+4qAAU9A64XpG0iu0mvLTTxDNhD6AwfyAoNqaEQUmXdArwM3a5ZNcTSQXHQX2ZXDd87LOPS6UOC+i4mcF3L6lInEqv1InCQP/zGv+i6tLj1GVJVVGBln9kpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:12:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 10:12:54 +0000
Message-ID: <c195608f-1c51-40b2-a2ba-32c42cac3af6@siemens.com>
Date: Thu, 7 May 2026 12:12:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Remove SQUAD support
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <1f472e98-7716-4a58-9a3e-dacef81056dd@siemens.com>
 <OSZPR01MB81235D1A7F96B60299663BD4B73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB81235D1A7F96B60299663BD4B73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: feaeac0f-4f18-46aa-0436-08deac2133f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	qd3whIeuVBT9P7WOwn5R4V2BaYkf2Bk8ACumSh4YpLbiml20I5cawBNQTkBAK22Xo7/zhcKo7ErSPBKc2C9pQrynHp3cTZ08DgqBKCuN87VYT3tvoQUpgup3uw0luOSyxwkENFy8dP89pjOM8Xr8C2imm3jF+L6Tajk/BP1EPlW9hHz2COjr3pZuj2ZczgMs8jXkrIBquqn5bR6vPW5a9PsRDurUL3epTx3kMf7Xbc2vMfz07BDtW4datStKVafb90kIyPp0vdixDFP8S3VC551zG1T2RsK1BqPZWTSXhL87xJjjJ04s3FIAxC8lWzSsIkeyXm/HiUFvZTYv+LOp0Cr+YklnEpvnL4wnd9g5ScY6xj/3RwXvTx440j0nD+xoBE4Vn2Ski4HzL+E5mfeLHX+VNeb5InTe7yNogFiphTJcakyd704WKW5k7dkLy7Tj9Y5znQ4qvjH2KDf8JMLhsTHujJmWxS0XOceP2BAlQ39ScPI23TDpsMsqtqAFx/7pwJ3cNifYKpK5kwZ++gcZ3AZWJRNQmulNues+wKeKqVzFTmyZJFrD+YrJvStkEERCqmdj0YOvbSmtyCfTnrs4baIULrP2InvmMhyZ9rQ1jge/twyA1oXPEVpznIJcuxaF6REKT5bePxABf8YsOCCn7Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cW1VZm11eVhwR28rSVAzaHA5Um1idFVVYkx6clJrWDlnbWdSaTBUbDhvVjds?=
 =?utf-8?B?aElUb2lVbEVycXlDUnFndzVOTjB4SHFtY01ZREhHNWJPaytPTlFqcmhQcXlU?=
 =?utf-8?B?Rmt1YnFIekxQYzB6RFNyTUN3bXdrNXY0Wm1INUFOcGRmRFNzeUxzYnc0dTEx?=
 =?utf-8?B?Q0lXbmt0YlM2bzFNcmZtcVg3SUxsMWRJOWRIRFlLWjA2NmY5eHAwOGZ5eDV2?=
 =?utf-8?B?ZllpRVVNS0UvaHJBTWNTYVlMcEFrUUlMSEd4N0N1clZmbENvcVNaM3lxT3Bh?=
 =?utf-8?B?K2J5RzlRbThRY1AzVkx5VlN2NnBSR3VyaUtRcUgwSEkyb0Jvb2Y1ZzI1RHhF?=
 =?utf-8?B?NnhINFcveEJaNmcvcWd4a1lkTXVBQVN6NUI0RlhHOHlRRnBuMU1LOENraXNa?=
 =?utf-8?B?TDZrMFE5OERoaGdEdlhPbnlBZHkvUzcwU0NYWXphdFFORy93SEt5OGs1ejBu?=
 =?utf-8?B?WjhTQklTVGk1dE5USTV4M1o0RnFMOEJQZ2IyZnd2TmpFclRnOElEN1Y4eVJ1?=
 =?utf-8?B?eDFVTUZzTjh2Y0NDK2cyY0Z3N0lhYndVTzF4c2hsSE13L280MXlYbUVMTW1u?=
 =?utf-8?B?NUZtLzBKY2xXNkZJVytzdEtFdUlXV0xyZmJneVQ3TlBLbnVZbytUSjhVWHZp?=
 =?utf-8?B?VmRRd1NiSHpwTWEzZDdjRUN1UHpxcGwxVlJRL3JXYVlkUHVjeHlqM3Mwcjc0?=
 =?utf-8?B?cXAyNE1tUWdPOWM2N0xVTGVZZTIzOEdMS1FiMk5FZWkxdXdtQjhHa1Nkdy9Z?=
 =?utf-8?B?ajZ3cTBQU3RlalVZMng5VVdEYit6b0FNYWVURmptaXdaMGNLN0Q5SFhFeHpB?=
 =?utf-8?B?Q1VvRU9MaVUrMmRVVFAyTDRWa2xqNnQ2VE96RGZLTDhnOVIrb2tjai81R0dy?=
 =?utf-8?B?U3V1eERTelc0ZUhYOTlnaUQvdFU5aTNmdWU3SWFPVklTN1Y0bEk1eGI2azc2?=
 =?utf-8?B?RHpnbTkyMHh0ZVdIdW53WTRDLzJGR3FLcmFvd1dhZis0SGVJTHhsVU9jR042?=
 =?utf-8?B?V2RxaUF2RXV1MTZSSGt2cDhLbndOcDlhYTNCRHA2QTl1MFFyTUpIUFpzL0pk?=
 =?utf-8?B?YkhKRFFpVGovOWl0MU9JZS9QVEFrR3J4dkN0dkFLNWdWVnNoelZhdTBiRUYx?=
 =?utf-8?B?bUZMcGh0Q0lCVWw4OS9KM09rbDNWSkVaWTJVdG9YNStZbjNIZkZjR1F2ZEVF?=
 =?utf-8?B?Wmk4ckFXdE55MDRUMERtL3lCeGJ4cm9HczM3QW9tdXB0SzNHUElaYUg4b1Vo?=
 =?utf-8?B?Mk5kdlF6cTVpc3BndytaTkdHTSs1NnFzZk5qaC9PcjVQT3JoWVF2bmpydEJZ?=
 =?utf-8?B?a1N5b3hDRHQ2OXRYYWxlVjExLzZJZHh3aGxJbU5kR0V0VGE2Y3RZNGJQN1BK?=
 =?utf-8?B?ZW01UG10UE8zNGhtajloREtJNWNuZUFvNkhKa3hBL0ZIRHZpMWVQTzNwOE9P?=
 =?utf-8?B?QjF3Nnd1bWNrcG91WW81Njc3VE1HQTR4QmhrZTROUlJZUFZWbXZpcjF6TEd0?=
 =?utf-8?B?b3g3M3c1L2hOMWE2ZURMSHlsUWVLcHZWeGRORU9PSEgwdnd3WkFBYTEyWkxU?=
 =?utf-8?B?ZzRTaFF5aVRFUVdueHVZWEhhRWtYaktUTDJyMFlnMlloMHA1M0hmdTAyckxP?=
 =?utf-8?B?eWJ2S3hVUzR1TGFicmFmTnNOSHBRcUtiZml4TXVjZTR5eHlEZnpvZWVWVFNp?=
 =?utf-8?B?VlpxVjlvLzh3bG8vMGFvTDFYV09nOXJsSEY5SkVDUzVhSkExUlFnNzI4WXBH?=
 =?utf-8?B?MHF5b0FCbXFHM0t3TytYcHRQNjQxWEVtQi82NkRIbXlOOHdZZFFrZkE4NE5y?=
 =?utf-8?B?UEhtVnQ0ek10ZXUwSUxMbVc3TkpMaWxJQ0hid3BiMDFsdTgzY2lZc0R4bHRs?=
 =?utf-8?B?WFNDSUdaZGREeGJJOVRvRVZLMHB5NmJJWE13NkRjSFQ2TlQxVVM1ZjlXbVZG?=
 =?utf-8?B?ZTZ1aFpLRzFTS2pxVS9ueXc4VmVRR0tYNmtFUWVRZ01aa3UvalJpeDl0a3FB?=
 =?utf-8?B?b2FpaUpyb296SDRBZUNHcHdWWDhiSHM1VDUvOVM0d245UkR5NEZ4WDl3MklG?=
 =?utf-8?B?UlVZaDk2REliVHJhVVJRYlduTk1abDIvZTVscHA0cGRMbTU2NzVoWlR4ZW51?=
 =?utf-8?B?RlIzcHhTaHVhbXJtUlkrY0YrYmY1eXg0YytkcUN0aWZpWkxBYy96aU5ua1ZN?=
 =?utf-8?B?K2dMOGFNeWJGaU1GN1J1SERBcUdJZzZ6dGo2S2wyekhuU0tUNEwzRmI3UGtl?=
 =?utf-8?B?R1c1ZjdrMmVONWJia01IdzdzVGI1MVk5bExyamd0VmMzTE5FRjhSK3puRzVV?=
 =?utf-8?B?ZTFleTE1QzhYN3BCVUV0TWhaSHRFdTJxbVNUTDJqdEVyV0VEWU1xQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaeac0f-4f18-46aa-0436-08deac2133f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:12:54.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dct6E+zxskZrIwYCrUj17wSSZzO4tCGK3VNxids7ID5C1xybVAFTbwBHBGw8IQM3EpkdGi2tC/J+XaWfAoOcTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5737
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 10:13:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22899

On 07.05.26 12:06, Chris Paterson wrote:
> Hello Jan,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: 07 May 2026 10:09
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This was apparently broken for much longer than we recently noticed -
>> and no one missed it. Time to retire it.
> 
> Ack.
> 
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  doc/README.lava-testing.md                    |  2 +-
>>  .../linux/linux-cip_6.12.85-cip22.bb          | 14 ++++++
> 
> Was this change included in this commit by mistake?
> 

Oops, indeed, thanks for noticing (was my local RT-ARM experiment).

Jan

> Kind regards, Chris
> 
>>  scripts/submit_lava.sh                        | 47 -------------------
>>  3 files changed, 15 insertions(+), 48 deletions(-)
>>
>> diff --git a/doc/README.lava-testing.md b/doc/README.lava-testing.md
>> index 04da723c..c8c606e7 100644
>> --- a/doc/README.lava-testing.md
>> +++ b/doc/README.lava-testing.md
>> @@ -1,6 +1,6 @@
>>  # CIP Core functionality testing with LAVA
>>
>> -This document explains how SWUpdate, Secure boot and IEC layer are being
>> tested using LAVA. The tests/templates directory contains functionality
>> based templates which are extended to LAVA job definitions which tests the
>> respective functionality on QEMU amd64, arm64 and arm architectures. CI
>> jobs run until the final health of all the submitted jobs is reported.
>> Test results are also pushed to [CIP SQUAD
>> platform](https://squad.ciplatform.org/cip-core/).
>> +This document explains how SWUpdate, Secure boot and IEC layer are being
>> tested using LAVA. The tests/templates directory contains functionality
>> based templates which are extended to LAVA job definitions which tests the
>> respective functionality on QEMU amd64, arm64 and arm architectures. CI
>> jobs run until the final health of all the submitted jobs is reported.
>>
>>  ## Templates
>>
>> diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-
>> kernel/linux/linux-cip_6.12.85-cip22.bb
>> index fecdba28..ce8d514f 100644
>> --- a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
>> +++ b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
>> @@ -8,3 +8,17 @@
>>  require linux-cip-release.inc
>>
>>  SRC_URI[sha256sum] =
>> "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
>> +
>> +SRC_URI += " \
>> +    file://0001-ARM-group-is_permission_fault-with-
>> is_translation_fa.patch \
>> +    file://0002-ARM-allow-__do_kernel_fault-to-report-execution-of-
>> m.patch \
>> +    file://0003-ARM-fix-hash_name-fault.patch \
>> +    file://0004-ARM-fix-branch-predictor-hardening.patch \
>> +    file://0005-ARM-9459-1-Disable-jump-label-on-PREEMPT_RT.patch \
>> +    file://0006-ARM-ensure-interrupts-are-enabled-in-
>> __do_user_fault.patch \
>> +    file://0007-ARM-move-vmalloc-lazy-page-table-population.patch \
>> +    file://0008-ARM-move-is_permission_fault-and-
>> is_translation_faul.patch \
>> +    file://0009-ARM-use-BIT-and-GENMASK-for-fault-status-register-
>> fi.patch \
>> +    file://0010-ARM-move-FSR-fault-status-definitions-before-fsr_fs.patch
>> \
>> +    file://0011-ARM-provide-individual-is_translation_fault-and-
>> is_p.patch \
>> +    file://0012-ARM-9463-1-Allow-to-enable-RT.patch"
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
>> index 958a4e98..11f3a5c7 100755
>> --- a/scripts/submit_lava.sh
>> +++ b/scripts/submit_lava.sh
>> @@ -14,9 +14,6 @@ LAVA_TEMPLATES="tests/templates"
>>  LAVA_JOBS_URL="https://${CIP_LAVA_LAB_SERVER:-
>> lava.ciplatform.org}/scheduler/job"
>>
>> LAVA_API_URL="https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LA
>> B_SERVER:-lava.ciplatform.org}/api/v0.2"
>>  LAVACLI_ARGS="--uri
>> https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-
>> lava.ciplatform.org}/RPC2"
>> -SQUAD_GROUP="cip-core"
>> -SQUAD_WATCH_JOBS_URL="${CIP_SQUAD_URL}/api/watchjob"
>> -SQUAD_LAVA_BACKEND="${CIP_SQUAD_LAVA_BACKEND:-cip}"
>>  PROJECT_URL="https://s3.eu-central-1.amazonaws.com/download2.cip-
>> project.org/cip-core"
>>
>>  WORK_DIR=$(pwd)
>> @@ -235,48 +232,6 @@ create_job_mcom () {
>>  	    -i "${job_dir}/${1}_${2}.yml"
>>  }
>>
>> -# This method attaches SQUAD watch job to the submitted LAVA job
>> -# $1: LAVA Job ID
>> -submit_squad_watch_job(){
>> -# SQUAD watch job submission
>> -	local ret
>> -	if [ -z ${CIP_SQUAD_LAB_TOKEN+x} ]; then
>> -		echo "SQUAD_LAB_TOKEN not found, omitting SQUAD results
>> reporting!"
>> -		return 0
>> -	fi
>> -
>> -	if [ "$TEST" = "swupdate" ] || [ "$TEST" = "kernel-panic" ] || [
>> "$TEST" = "initramfs-crash" ]; then
>> -		SQUAD_PROJECT="swupdate-testing"
>> -	elif [ "$TEST" = "secure-boot" ]; then
>> -		SQUAD_PROJECT="secure-boot-testing"
>> -	elif [ "$TEST" = "IEC" ]; then
>> -		SQUAD_PROJECT="iec-layer-testing"
>> -	else
>> -		echo "Unable to host results in available CIP Core SQUAD
>> projects"
>> -		return 1
>> -	fi
>> -
>> -	local ENV="${SQUAD_PROJECT}_${TARGET}"
>> -	local
>> squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJECT}/${COMMIT_
>> REF}/${ENV}"
>> -	ret=$(curl --max-time 10 --silent \
>> -		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
>> -		--form backend="$SQUAD_LAVA_BACKEND" \
>> -		--form testjob_id="$1" \
>> -		--form metadata='{"device": "'"${DEVICE}"'", "CI pipeline":
>> "'"${CI_PIPELINE_URL}"'", "CI job": "'"${CI_JOB_URL}"'"}' \
>> -		"$squad_url")
>> -
>> -	if [[ $ret != [0-9]* ]]
>> -	then
>> -		echo "Something went wrong with SQUAD watch job submission.
>> SQUAD returned:"
>> -		echo "${ret}"
>> -		echo "SQUAD URL: ${squad_url}"
>> -		echo "SQUAD Backend: ${SQUAD_LAVA_BACKEND}"
>> -		echo "LAVA Job Id: $1"
>> -	else
>> -		echo "SQUAD watch job submitted successfully as #${ret}."
>> -	fi
>> -}
>> -
>>  # $1: Job definition file
>>  submit_job() {
>>          # First check if respective device is online
>> @@ -306,8 +261,6 @@ submit_job() {
>>  				| cut -d ":" -f 2 \
>>  				| awk '{$1=$1};1')
>>
>> -			submit_squad_watch_job "${ret}"
>> -
>>  			# shellcheck disable=2086
>>  			lavacli $LAVACLI_ARGS jobs logs "${ret}"
>>  			# shellcheck disable=2086
>> --
>> 2.47.3


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

