Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367DBC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 12:21:18 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web11.19228.1714393274591244926
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 05:21:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JECJACd9;
 spf=pass (domain: siemens.com, ip: 40.107.104.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6ma5wLzsGgybbaJIuTk9frL8qRXAh1vSyA+AMj8VZ7Dav6eUoVYNr1kwBxPYMXsZbBiWiiRHYHBJRFZ0Yt81V+nSJYqkUlUuF2GxFWM4DKqejXIp0tDbmmfCYSRmTLuK1o0Wo7jSvGnVXuExb27yKn6myrAH9lnKrgccf5q5cfbWDM1VmcK6Kos0LY5JQUKrS0YD0CQGP2LgkmzZikGdOzMOR30hjt5bRX5N/Pm7uGJQAZNwm7NcvO7/lD944ly5Y95Mlom702AyUcs+AxO5OmyAd7Ge4iGcEGN4kMa/XFYz1fk0slhJd94mR8Z7u5qYBTmKdFZbmdfP3g5D2VCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4sLAMFMjCH2SXBB9n81IompnqDf8fwITORuu7hzp+g=;
 b=H84WBI9dwzLWycknAhav98EkIQKBPWhsLxwZnFvG60lD+jYiR6WHNvmN2H5mkBpY7QHJ3cK4SVDgy6GUb9VVR9TIIdFjsJ+LUjYLjmwNf3AKjxmU5a8RfGrPpwnfEnGWur3Rhc5bv6cz8ucONKxj7s7in0KmESsknT2MlaMgT8dPsup/dslV7fDxwgpbRg14YnaRsMrxk7HyFemtLeS+sxRYcTOgKgnxv2AeAAGXLoosmE3WRaQeTyqTG4QTfLQ6RdzYODSJ2FQF/bFY44UoF/wo1ToRLh+hi/i7VC9LPrRUqYuTOArv0TFGv1mRvOrdl5Yq77dwb43youZ/GUgHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4sLAMFMjCH2SXBB9n81IompnqDf8fwITORuu7hzp+g=;
 b=JECJACd9u+nvU0hOS6pUhKLDDDJuFOXqeVnV4gYSFUFqOEOSvT98F23IJK7HNDYTUOGhVTKKSTeBG8S0ltFQyJwGdA3EeZaQz4eUBJcORMK1D46yUpzibxdn8WOJgunxlrvM6nl+4GWdQfFQsosNxZ6O25obaEFV2wYzzE6u4ycyW7CMRGlWFQGDrKYSuoOwuzIjvl6EcR6TdUJLf0voscPVriyxWIu68Q6JL8OZZ3BczGhL4zHxo52jHEMcbCVfOdWtd0yj5jgBiIYQ4n4aY3TL5CQdPGKvRkMF407oasCQ3lxYtPGsj7UKEekEj/AM7SXpE027IUq7Ew6iuVaEFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:21:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:21:11 +0000
Message-ID: <c6370a66-bdeb-4ee7-87cd-f08e8ad17119@siemens.com>
Date: Mon, 29 Apr 2024 14:21:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 2/3] swupdate.bbclass: Generate swu for
 delta updates
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-3-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240425094444.404036-3-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6620de63-64be-407e-2fc7-08dc6846db2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTl1R1ZadjNmVlRpNGJLcG4rQlYvUGJGRnU3VHg3QUxTdXhGWSttZW1idDhN?=
 =?utf-8?B?NHA3Z1FUblJXeDVhRWF6QWswZk0yVmI3WEdzWDltMVNTZWlLZWpTbHFXOVAx?=
 =?utf-8?B?UlZDZXk3b0I0ekd3UFlKNVQ3R2tTaXhKNkVGNm5pWEwrUkFBeEdNZXJUZFZ3?=
 =?utf-8?B?ZWpEcTB0aVRLRVJTNkxaQWk0aDdrUTNGOVNoZEFDWVlvUlpDd1l6dUg5Wlhj?=
 =?utf-8?B?b1Y0YUdHRmdaWlgzL2x5TUZTRmF0UXM1bW5zT2dBb1JqQnIrQ3FBZ0RzSE5o?=
 =?utf-8?B?dVh4a3NEalhiRVdtK1FySVdwYnNTMUI1MmM4S2IrQUxzazJPWjZPazRWWnhK?=
 =?utf-8?B?ZE16d1ZFd0Rmd2twdDVOSUZodDJoQWZTRm1ic1RXZnRabVZ4TC9LSEhVVGR5?=
 =?utf-8?B?TWFoWUJvbkdYbUhrdm05K1VlcFdpSnVlbUVISlpmMU5CdFU4Y3M1cVZycWRW?=
 =?utf-8?B?MFJEZzJidHBWb3JNU09ZWkxpZ1ZacXdRSE5HNzJPSUp2TXBaaEUxdU5VTkZD?=
 =?utf-8?B?SXNmUXZtcVJ2bTJFcG5hY0NtVUhLTGxrdVJqYnVnaWVZQTRidGlPY0wrcFRt?=
 =?utf-8?B?K0c2QkxlNTBQQWcxSEdBMHA4YmhCUmVkUXFudHVQOGVIekhtWnlwMXRKNUZv?=
 =?utf-8?B?WU1qNGNtdnFrVnRwVCtsclYrQ0ZUeWNSQlZpbHlqN1JCUWRsMlFQZUtDeEJQ?=
 =?utf-8?B?M1UxWE1sUkJrSmpEZmhacXZJYVFiSktYazNma0czdzE4SUU0OHRvWkZQMisw?=
 =?utf-8?B?OG13RUMwbUlRWW1ZS25xejREb2RjVXpBVzdoNDRmY0RDU21pQkFoTkdjWDZq?=
 =?utf-8?B?aThmQW1GMUdEMTBlVTJ2SkVqUnJEdVB4TWEwWUtjMGpPN0lnT1B2RWFhNERp?=
 =?utf-8?B?SmNQaCt3UE1NYWoveFNlMFN1WllscFArK1lSZHJIMExEY2xjT1JHVU02M1hL?=
 =?utf-8?B?c3lpQ0I5c2s1Rkdxa01XbUVtdVpxbG9wTmc2dHpvUmdxMW0yMEtxVzNFcW0y?=
 =?utf-8?B?bVpyVXMxSkVHK0hYOVFtbUQwMnVHV2M5WUp5U3VHdjU3V0plZWlqU09iWURI?=
 =?utf-8?B?U3ZPSzM3Vys1MzdyTTFXZytadHNSMm1kTG1mRzZNTGNBaXlOaHNzYmZzWVF3?=
 =?utf-8?B?TXp3ZHU0SkRRRXU2LzZreWlnVHhCWHByam9lWXdlN1dBbmZGUGttOEVyMkY5?=
 =?utf-8?B?bU04STROa2RVS05GOElGYTREd3VLTWJieW13YzUrS09yREtxeUNhMnp6U1M2?=
 =?utf-8?B?eHJaMlNXdUhRN3ZKbVg2eW90dG9FR2F3WHMyZjdpTmpEM2dCbVpjVHdnY2hU?=
 =?utf-8?B?ak5NQ2J5c1BXVStJZUZ3dEpWVDlsNktBMURlVnZPQWJVcThZQ28wK05LQ2x2?=
 =?utf-8?B?b3RsMUxMRGQzRlRRdHp5RnhlVXpxbk1VMTdxSkZDSkFyY0hEU1ZMaEdSOVRQ?=
 =?utf-8?B?VzBFYk1tYkN3ZzMxaVFISU00dS9XSGlRUTZQaExHWTlTajZhelBCdDZWS3hX?=
 =?utf-8?B?eThBRlBYSFY5UHV5dkFhR0FRMUFPRWg2NnVQUExjcGw3SXh5YXY3UStibXh1?=
 =?utf-8?B?ODZydUZhdmhncjRpSVhMSGszaXlma1RGMTZuMUpQb2Nlc1d3WTdPdHdjV2Y5?=
 =?utf-8?B?WlVxVjVlamRsMVVlRWJRSkU2TkNhZmUydHdralF5N0JoY1JnNGdROGgxM2wz?=
 =?utf-8?B?Ty8xMzc3QlFyazhGRFNRU0Mrd0hpNkhnc3ZjalZZQSt6R09uMmRKYjVBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ym1HclRTc043THAySFJPZm8wUXFadzZYaDNSSmFFQzdGbWhUZS9INXFKWWtX?=
 =?utf-8?B?dGZtZkJ2TGhMc2JldDBsQW1VQmdwbkdXWnBiakhRazBqaXd3VStqSm82bVpY?=
 =?utf-8?B?dGV0blM0MnRwdTh4VER3dG5vWHF1YUZJS3dVL3Q2d0YyUTBoeEd3NU5qRFlh?=
 =?utf-8?B?L213SzRkWW1qS211NkJIMVdYWFpFR09vRGp3RmswM3l6RG4yeHZKN1lBUkkw?=
 =?utf-8?B?b0NzM0w0M1BsWGFhSEs1S3BBVy96OU8xS21Hay9tK0pwK0lGMmhaSFlLWWFp?=
 =?utf-8?B?bnFEeGRvcGFiV2dyREo4VUt3SXZaV1VCa2FOeWxSNW56YTZJcjhqNEJQM3E5?=
 =?utf-8?B?cFA2WFVqd2NvV08zMG5CYjlQSVFqdkxiRUlTTXlpdndOZ3VtU29RN0ErWGJD?=
 =?utf-8?B?ZEdaU0psZ3VRKytPNDYvWHBDZGZ0V09JcGcvcXpmS3A2d05pZ2QwOTR5RGxN?=
 =?utf-8?B?VWRwTGErb0I0aTF3WFdKZ1p6eU5aYmZHa3FHVENtcEI0Uk9RMklEay9kbm9s?=
 =?utf-8?B?V2psaXhjU0FRRjFFZzdBQVJITlY1cmxkcEd2T2Q1eXVva0E0aXN5cDI1bDhs?=
 =?utf-8?B?SFZiYUFFOVBHSWl1akp2azhOT3J1VXVaUSsvb2lFamRpM0lseUVNV0pJbitP?=
 =?utf-8?B?Z0dHQWN4cmVXeEpvSlpQbmduUHJqUmRXcG5ScG5SaGpET0JFU2kzU1pObmRn?=
 =?utf-8?B?VnJ3UzVYK1ZFSXNhNXlUSWYyQ1FWRHVRcGxFREUzSVBmU3NvYnMyWkJ6Smdm?=
 =?utf-8?B?UFFWekdEYSt5a2NTK0FmMWZyT1JmM0FIY2pZSit5V1pLR0tTSkw4bjFSc1JF?=
 =?utf-8?B?RUZNMC9FcytHbUxaRmlGR2Y2VWs5SmZheDRFdUlaa0grajQ0SThoVTdudGky?=
 =?utf-8?B?WnNWZTMyT25NZzE2QmxjbXY5aVIvVHBvc2pyeGRmN0NuaGdOU1hvWGthSkJF?=
 =?utf-8?B?d2RJeE04cTZPQmQ2V3pTdkxSU0tXUVVpS2pRdXVscHNsaTFKay80NWFJVDBo?=
 =?utf-8?B?cVMvZFJpVTVVY3pBalRBRm9PME0vOGtGMUVCU3o4Y3pUU2Z1dzNjSlB5OTVo?=
 =?utf-8?B?V0l0UDBwWVJRa0hMaWNnVlZtUWJRRGJjSjR5ZkdJcW43eWlpQnlGVVZyNWVu?=
 =?utf-8?B?UnpwQTNoQll1cHEyMVduaVEzNzB0cWVZejFUVm5GS0VocnRIb084UitldEhl?=
 =?utf-8?B?RjJsMmNJVTRURnlXdE9Wem5XS2RBWnJyRjFCa0hGK0l2ZG9jSkh6VWFaYU01?=
 =?utf-8?B?V2hQMm9vVGNqdmZHdXlCaUpaQU03dW1RK3lvdmtkVVNQZEZtZDZSMDVXT2lX?=
 =?utf-8?B?WVdJMjVBRDhNeDNoY3FlTkN2MXZwd1hjRWI0VmlhUUZ6U3o3TDFrYWE4S0w5?=
 =?utf-8?B?QzRTajVxL2NNK3RSbXlDZnFvOEdpYlpEcmxWWmkxNHpxNklhZXlPMk0rTFkv?=
 =?utf-8?B?MjczQi9DcG82dVdYRWFaa0d5d3JBbUxZZ01sNXBBR0s2YmRURFliREZZUjg2?=
 =?utf-8?B?UVdNMmR5VEJGNEwrZm9NQUxEQVFlMExKZVJoYjMwUHpkWkhIVVBacUhod25X?=
 =?utf-8?B?MWtwTWxvb1NUZ2ZPNjFlZ2ZKL2ZnR3NvS3NGeTRXemxKb2tvcHQyU3pVR1l3?=
 =?utf-8?B?YVh4OEdWcVFwemprdHB4am5QeEVSUFhzSTdIVDdrYUN1b3h4NUxQWC8vMEhm?=
 =?utf-8?B?cG55c0p1SHljYUs0cVFMR2t3aTIxSzB4ekRSRWxTbk9PSitneWN6OEtXQXZu?=
 =?utf-8?B?R1IxaVB2ZFE3MzhYZTdHdmN5aWtZdVF2eFhjQi9UQllBTFBhV3JRS2s3TGZl?=
 =?utf-8?B?b1RRSHJHT3J0TkdpZ2hWZGxkSURZMHFDZks4eU5XU0pvcGk0Yk9EOGR4Ykhu?=
 =?utf-8?B?VXBPUGtPTXh2SSt6TnZHSnNrb05GWkhocE9ZSyswT2FhbEdXbC8vL0puM0NL?=
 =?utf-8?B?ZVpXU3NOZjNZYjhvbE10VmFsVmVwQi8xTnB2SitrZmtNakl3RFY4bG1YTXVu?=
 =?utf-8?B?aDBUZ3hWRzlRc0ZraTBkcTVPUVBUNHJoUTgzUjhpR215R0pUc1lCK1FqMUht?=
 =?utf-8?B?VGh2TFZDNG0wZHlyWUg5Z24vbkFlQmpHYjdWZlpOVFhtYVpuNENzOXdRSjZv?=
 =?utf-8?B?d3BKTWRuMkxZQThYaFpnVkY1NS9DQ21UOFNsa2d5NnlJeXZpb09Sd1RoSmZ4?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6620de63-64be-407e-2fc7-08dc6846db2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:21:11.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8Vn+0QE7vvSMokwfegYd7hV0Nfr0k0zBg1NR4+HlhMYBNyU8+m0XVOzu5kpeNTa2xglEsR/eLImOs/TC3Hrjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3475
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 12:21:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15777

On 25.04.24 11:44, Adithya Balakumar wrote:
> This allows the creation of a swu file for delta update when a delta
> update is chosen through the DELTA_UPDATE_TYPE variable
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  classes/swupdate.bbclass                    | 27 ++++++++++++++++++---
>  recipes-core/images/swu/sw-description.tmpl |  5 ++--
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 1a7cd4d..e320014 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -26,17 +26,21 @@ SWU_EBG_UPDATE ?= ""
>  SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
>  SWU_BOOTLOADER ??= "ebg"
>  SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
> +SWU_DELTA_UPDATE_ARTIFACT = "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
> +SWU_ROOTFS_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_ARTIFACT}' if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk"  else '${SWU_ROOTFS_PARTITION_NAME}'}"

Please break this line ("\") so stay samewhere around 100 chars max.

>  
>  SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
> -SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
> +SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_ARTIFACT_NAME}"
>  SWU_SIGNED ??= ""
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "cms"
>  
>  SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>  
> -IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> +SWU_UPDATE_ARTIFACT_TYPE = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> +SWU_DELTA_UPDATE_ARTIFACT_TYPE = "delta_update${@get_swu_compression_type(d)}"
> +IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" else '${SWU_UPDATE_ARTIFACT_TYPE}' }"

Also this line would be more readable if split over two.

>  IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> @@ -47,7 +51,7 @@ IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>  IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
>  IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>  IMAGE_TEMPLATE_VARS:swu = " \
> -    SWU_ROOTFS_PARTITION_NAME \
> +    SWU_ROOTFS_ARTIFACT_NAME \
>      TARGET_IMAGE_UUID \
>      ABROOTFS_PART_UUID_A \
>      ABROOTFS_PART_UUID_B \
> @@ -58,6 +62,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_FILE_NODES \
>      SWU_BOOTLOADER_FILE_NODE \
>      SWU_SCRIPTS_NODE \
> +    SWU_DELTA_UPDATE_PROPERTIES \
>      "
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
> @@ -148,6 +153,22 @@ python add_scripts_node() {
>      d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>  }
>  
> +SWU_EXTEND_SW_DESCRIPTION += "add_swu_delta_update_properties"
> +python add_swu_delta_update_properties() {
> +    delta_type = d.getVar('DELTA_UPDATE_TYPE')
> +    swu_delta_update_properties = ""
> +    if delta_type == "rdiff":
> +        swu_delta_update_properties =  'chainhandler = "rdiff_image";'
> +    elif delta_type == "zchunk":
> +        zck_url = d.getVar('DELTA_ZCK_URL')
> +        swu_delta_update_properties = f"""
> +                        chainhandler = "delta";
> +                        url = "{zck_url}";
> +                        zckloglevel = "error";
> +        """
> +    d.setVar('SWU_DELTA_UPDATE_PROPERTIES', swu_delta_update_properties)
> +}
> +
>  # convert between swupdate compressor name and imagetype extension
>  def get_swu_compression_type(d):
>      swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> index 88cb475..f438d99 100644
> --- a/recipes-core/images/swu/sw-description.tmpl
> +++ b/recipes-core/images/swu/sw-description.tmpl
> @@ -14,15 +14,16 @@ software =
>      name = "${SWU_NAME}";
>      ${SWU_HW_COMPAT_NODE}
>      images: ({
> -            filename = "${SWU_ROOTFS_PARTITION_NAME}";
> +            filename = "${SWU_ROOTFS_ARTIFACT_NAME}";
>              device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
>              type = "roundrobin";
>              ${SWU_COMPRESSION_NODE}
>              properties: {
>                          subtype = "image";
>                          configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
> +			${SWU_DELTA_UPDATE_PROPERTIES}

You are using tabs here, please switch to spaces.

>              };
> -            sha256 = "${SWU_ROOTFS_PARTITION_NAME}-sha256";
> +            sha256 = "${SWU_ROOTFS_ARTIFACT_NAME}-sha256";
>      });
>      files: ({
>              filename = "linux.efi";

Jan

-- 
Siemens AG, Technology
Linux Expert Center


