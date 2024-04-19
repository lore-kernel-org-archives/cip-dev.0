Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95279C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 16:29:13 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.25886.1713544150940487896
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 09:29:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yYWA5jp3;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc7/j8QTud9u6sGIbIXL4v39cdZB8OwcEunAXY4pZtrTH0LMUfDdB31aUnzWZM721uOWXstPGqJQKGe8Yjtmh30Bbop7J/i7/aiqK6zpK2tj9/r3zxQm4af8I0gfAhpelqs70di86VaBQiJUSIJjBjmGbI484qo5ZYc3vUd3jIAviKsyPPRfocbczB3LYPHMrkrh1QAFQ9gRwJti04m88rKgF0Ii2xI33Kz6ijk2nPJimWsKpFGGREycNOCektfvXLI//pLZaIkX6G1IUSER17GuHoVJXklF/Sa3p8B2sAwjDFjZ5oitb6kSQmkaSEWXnoKBBAgEPmm1JAsDh0fxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTgaUUyNQatX3xRClIEvIEHc6WhPbzXkUgyhpOuMbfA=;
 b=kAas2KXmJjVWrIHIgBK4VGqQKQ1UJ2qEFon/yteq7NKL4tKp5Ti4JWknRzs/Z2uUimbrtammAVu2Jcq2LP0o5UBMt498P+RnVkVa2y5va82r2g8LDYmPyZENzr6UA+Va/B7zO087SuwuS9QtKO7CxPLOtN9XoOmt45HMNUFU+BaqjPmAYDbyddQYa/tUvkaJcabbV+snd6qbQy4J4ObCN6vU/e9vPvRgA0uNGp3Ig8YAvC2ja3arF7XMAtxQ2jl+nXO4BwXOZaOiZlWczaCyVUkLZ4PCbmzNYJSs5QyAYCuJDkQyLHioMy1NtP5aPKVud06i+VYYapNAH0TNLNPF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTgaUUyNQatX3xRClIEvIEHc6WhPbzXkUgyhpOuMbfA=;
 b=yYWA5jp3JC+c7lcCOvdY3Z3w+0CgQW4Spid8Eej0rEzaL5XNAg+FFoh2mqHPYem752+b8R/02vobh+4Y/7LAVqX8wZdnSNtLbFwUN8IF/PIurlLALZ3haLzB2il06sy70urkfFqogsaDG00bJZ/JVXO4sB5MWIH5nnDTPh39hjAYaEdhv+T8fs3HURBhN1HSGP8mlozpR3KpcXGF16oDg4kRbuFtsu7l8QGyBevi/KQ6w91CvIJ4nIPS3Lwfe/bw7Wo+OO2KGhmK4WJww1zVrdPHE3n/b0V/ewpNkyCFyg/+wZVwivjLOeYuOcl9SPN+dEa6KdZrrvXhfpzmQ89H5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:29:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:29:06 +0000
Message-ID: <857fecc8-ce88-4c94-a46e-a69198348ddb@siemens.com>
Date: Fri, 19 Apr 2024 09:29:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/7] wic/*: Add part-labels to
 system partition
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, johnxw@amazon.com,
 cip-dev@lists.cip-project.org
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
 <20240419082036.2389583-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240419082036.2389583-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 519b0527-fb7e-42d8-4956-08dc608dd565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N2NaWXZMM1dJK2NHRlBNaDJ4ODl2dWdOR3Bhc25wMmE0TWJBT3VFVzNyNzln?=
 =?utf-8?B?RzhaT1FxSWhmd2Q1cHhIOXFaazdYcXB2YWJQbVFtOWI4Z3dNY1pseitaZjRY?=
 =?utf-8?B?elFudDdDTnlGaWs4aWtnS3hzazRhdkRIMExxRVZjK1RURmVoSUlOalRteWpQ?=
 =?utf-8?B?enhuWG5oTDliVEhiVG13Z294bHVMOEl2SXVMVDhIZmJOM3hMUlMxUzYyZUtN?=
 =?utf-8?B?YUdHd0Q2V3haYU1OTlZoQzNLNW1RZ0Nhdno5Y2Z2MHJycTJIWE9pa3pwTysx?=
 =?utf-8?B?MWhTWWlha2gzOXIvQ0loUzBYaFhmSkY0Q0NIekk5T1hOYWF5SGpMK0lGOEpF?=
 =?utf-8?B?emp0eXQ2eWZYL1Y5MkFnQzNJanp6eEVUZCtHQTJrdXVTL3VWa2RGWTFvWTQr?=
 =?utf-8?B?MDY2SHFsN0xuN0RBRVREaEpScGltZ3loR3J1VWZvcVdWbndscys0VGN5WGg5?=
 =?utf-8?B?OWtlZCszanVFUlNIUEd5WE5CaFhTT3ZmT21UVG56MDR3S0hkUEo2SEFGUU9r?=
 =?utf-8?B?ZHZJYTlvQVJFNC9YVFZYS2FQKzZqOE5ZN1FXWnlCam5yeCtJRk9odm5KSTVF?=
 =?utf-8?B?QmF0dFlYaTlBZ21mU2JhajhIU0hhanM3ZkJBSkhhSU55Q1NnMUg5NzJVNFJU?=
 =?utf-8?B?Z2FxdUZkMCtUcmd0dlhGSzcycStFQ005MTUvL0J1Q2xNSXhVeGhJNkc5aU9T?=
 =?utf-8?B?SVB6Tzl3ZjgxNE4wenV0NStwcXNwbDRXWXNpdXVHd1AxWDdJYXB4bGtWQ3pV?=
 =?utf-8?B?NEVPcWtRMnUwOGN2U210QW01RUFMZUJRaGNRTWdoejRxN3B2WmdTSU9vTmJ0?=
 =?utf-8?B?T1pYaVVpQ2QrbmV6ZUpqTm0vYjdzcDZ3bzdhd2t0UzBzaTFackJtdlFlSDJ0?=
 =?utf-8?B?TElTVzdkT05kWkZqaDVuRU40OWwyd3dMWGJpU2xFNnhEaWQ5aVU0SUoyM1g4?=
 =?utf-8?B?ZXVvMTROYzNJS3hsQ3VYcTNMK0JlTkZMV25oQVkwUk1CWnBhZ2tFS3VvU0V4?=
 =?utf-8?B?ZTY2UzV4QlhSK1Bia05URXNlMmppQk11c3VLUU52MitZaWNDczErNE9zUVRt?=
 =?utf-8?B?cE4vYnZxcUYxMW5Gc0tpbTVPMStZQ3pQeXJBWlQzNFZreWZwRGRUenZIYXZI?=
 =?utf-8?B?K0ZaMHovamN3MllRYWM1MHJMWURvcTNxcnBSN28xY2ROVlc1azlQRHdBcTh5?=
 =?utf-8?B?Wm9ISWV5cmJTMCt5d3gxUFhKbzNuRjJmMWpsdk9DbC9ZQi9SRkZXb1d6a1Vj?=
 =?utf-8?B?ME93S2ZUVEdjQTNDeVc0UEo2bGVlSENaYjNPMVRiQXpvUnNsVktFSmNCUTF2?=
 =?utf-8?B?dzhaUlRXM1lMZU4xbjJVdk83QUZQL1A4RUFqYTVOYTNzQnFVSG42R1J0UE9o?=
 =?utf-8?B?dHdFMVM3RlVZbTJsQ2VidVl2QktSZVF0cjl6S0RyR1B5OEZtakhIZWtYK0hw?=
 =?utf-8?B?aGgwaFJ6Q0F6T2pyVnVsZVY5ZzZ1N0NIREZSVE5SeXF1T3VuaXJad2NSTzBY?=
 =?utf-8?B?MTdBUTBxY3p1Tk83V1hUcVR1dlJ6bHNFc1JLRnc4SURqcEdyMkVqOStvRjJq?=
 =?utf-8?B?eE5GZUJOK3RoanRYbTMzcC9rWDZJdlVQZGVtdm1QN3N5T2VXai9FU2kxdVpJ?=
 =?utf-8?B?c2FTUVh3d1ZhWFMrbE1iMU8rL0IyQW5FV3UzbTlEdndOZFVHODJvODNuNlV3?=
 =?utf-8?B?SC9DSUUwWTZ1LzRmb01sU0lNYUJZbnQ2MWh1RjRPL1A0c2VlaEhKRjhRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emUxczN0aFp1K2xsT2VSc2VlNzZ6b0hSV2dCbUM0RWJSeDQzRFN5b2xxUHJZ?=
 =?utf-8?B?bVZzZURYWVRYZ3JuSjNUMXU1V3NWT1JycUdQTll2MFkveUhuUVhUcWszS3Aw?=
 =?utf-8?B?bktZdXQzeW1MWWJkM2hvbHg1b1RyYitnN0tBdHdnaU9LY3RvUGZDQXhnK2E2?=
 =?utf-8?B?WEMyVnR6NFFQMmZRYWpkZ3NOakkxZUhlS0syUzc2RFI0NjN2UmdueWpCRGxB?=
 =?utf-8?B?RWY2dnBpQ0xBcm5HV25DN21TQ09sSWlTWTNheW16clFsdkZJazNSS1Jna2hS?=
 =?utf-8?B?VmM4UWE2eEtHallqa1pWZ29qcVp3N1REWGtTQUVCMmZKMktURlRMY1lXdE1r?=
 =?utf-8?B?WGxCd2cvSUEvaHMrak5Ocml2Z0gxMXl3UG9YUnhCdkFwejJVRDJXSGlUaDNU?=
 =?utf-8?B?dEp6R0FaY2owaFVvV1hLcjllZ1JmUEFZVitXVmdNMG5NbVJNanU2TGMvN0la?=
 =?utf-8?B?d0Z2bHZFMWtWUkFUZm56ZnJlWE9xdU5ibEpSRWNCNlZ5MHRmZXgwYXdKYm9K?=
 =?utf-8?B?bjJRbDNlQWhELzRZRHl2Um56SzJHc3oySlljaHNvN2RvMjg3UWlOUUVJRUd0?=
 =?utf-8?B?MXRCNW1iTWg1WTR6c1ZtZ0FTc3ltUjNPR0JydmRJZUpackVlNTI0Qk1DdVMz?=
 =?utf-8?B?OWUwVFV6YWo4VTQ3eFJ5YjZwMmVwZkRGY2NweUUrcHV1ZW80a1pIUXp6SVpt?=
 =?utf-8?B?SVUwMVFid2dqZUZSOEx0OGd1WnhQWXVNTjNpN3M5QmNlT0JnZlRoaUI5WW9u?=
 =?utf-8?B?M2t5VlZoQTlxeUtTcGFTNjFJMkhHbVUrMTFmZW40U1plUVE4L2VveDBndFBu?=
 =?utf-8?B?TG5kOWlWc0RVUXJiWklBQUszZS9Kd0N1YUN0N1Q0OUowUXppVnJiMVZnUlF6?=
 =?utf-8?B?Nk52bVA3Z0VMb1c4c2NsMHBlaFQwK0FUMkRVdWNka1QzS2o5RnBoZmZ5Z1Y1?=
 =?utf-8?B?Z3hNREQ2Y0toMjlFeWRVQlB6b01ScjY5VDBpMDVmR2FCY0VVc0oxdktYL25J?=
 =?utf-8?B?OUhVelZXNnBIUVprbEFjeXZvTno0ZTRrVVhFVlRaMmNVMWQ4c3dNRXhXU2Z4?=
 =?utf-8?B?UkdDTFNFWjk2YlJLRFJ6RTVVWGZWTnZRRStXMVUxQnJxdW16Z2VUeVFvZFdv?=
 =?utf-8?B?Q2ltb2Nja2Y3K1N0QUNIS2UwWFFqRkNOYkdwamZlSTFIV1ZISnEvQVpuKzRO?=
 =?utf-8?B?NjcxRUFBanFxQ0ZZeFFCZ0RTMGVNaGNDWE51Zml0akgwVE85cFhpNGJRN3JH?=
 =?utf-8?B?c1BUMlIxcUJETVhXWDBFbmtySkN6SEk3L3BpMW12Nm5DbDNKdHBxOGtxR2wv?=
 =?utf-8?B?Y3NBc1NqeXZ2TUpYZnhSMCtlOFE1SWZrRkZWc0lPRUhvaFlwYld2T2VpWjVu?=
 =?utf-8?B?dndMZndIUHNUUjVxbnlQcVoxbDF0ZG1aMTFQWlZxK3pGdk9nVzRZTDdVZWU1?=
 =?utf-8?B?Uk5wQklJQ1lMUHNha0JSaDVBbWN6SVlueVZnVmpnTEhGNVIrMFpES0R6OGN0?=
 =?utf-8?B?TjROdWtiNWNxL1UwODhSbE5MTldvaEltcjREdzh3bE5oNGwvcHhOMzg0R1VC?=
 =?utf-8?B?VmxOcGRiQnZIWG1Xc3NFcEtwZ3AwMTVDeWdtWVBlUldndEkzdkZyRTMycmVz?=
 =?utf-8?B?U2c0TnVMaGpKSFZuNmhoR2ZaN3M2ZDdUOTVXSmpBcjUxOVUxb3lvcGNzbWM2?=
 =?utf-8?B?WXlacVpuZXNYUzB2a3hZbGNqbWxVaE9oSkRKTGhkdFVQckNLWUZpTUYzbS9l?=
 =?utf-8?B?a2tjOEtIRTNla0dmNW94ZGZvMmlqc0J1SFNzYTluYU9hVnBhZHBLbzdoR1VY?=
 =?utf-8?B?cDlTcHpER2RGZnlqYldnYXJyS01JYTJWbGhsak8yL25iN0Q5ZWJNT0F5UG5i?=
 =?utf-8?B?RjVVeXZtREpjUjA4OFVMVlRYNm85REo0QkExTksyMHFET2M1UzBoM3M3c2VM?=
 =?utf-8?B?VGY5bUFQczQ5bzVsZEdrM1haUmdTNzIwL3E1cEoySHZBaDEyNWxTK2NicFdo?=
 =?utf-8?B?VnQ5Ui80akVEY2Jua2R1U3VxWFU1TWIxOEdqOVRZTUlOZ0dacFFSWXlDZ01D?=
 =?utf-8?B?ajRkOU0xaTRoZHEreVdZSnFEUkhydVZqUjFuYTlqNkhncWxJTHYycUdVUVlZ?=
 =?utf-8?Q?hPLPJB2OY9xDJpsf1ShkxFLUc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519b0527-fb7e-42d8-4956-08dc608dd565
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:29:06.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2DeL7fq1bltSXisP5gwa8NIZUDzvBkF30k5vBzXpXrZI2UWYLCdhaajRVGCc0L5ollqgzOoow1Y9tQl4w64Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 16:29:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15701

On 19.04.24 10:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 

Reasoning missing.

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-efibootguard.wks.in                   | 4 ++--
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index e9c04b9..b5772c2 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index 9227a71..164e8a9 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index ef40d70..0f4d637 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 01f395d..00d627d 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 942c3e1..6f03420 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 6934977..1704ded 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 6382ff7..4c0484f 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  
>  # home and var are extra partitions
>  

-- 
Siemens AG, Technology
Linux Expert Center


