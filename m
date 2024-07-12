Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB5C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:35:21 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web10.3962.1720776915633789500
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:35:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ch+24esa;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSzEaC0t9ijzazPbrbmy0aRAE/k0cq6c+cQsXCG1FQKtqpOXLhdzLA1Tfp65xTwoba+CQ9/C8X2UAqZ2SzXZFWdT3OALcX6w7dlAqM7TfjqYG7Q8d61Ju4S1wYD5iMandjXkM6/pEdmyHjnazNhgKUn/kN+VUmCNPkUzPe0EEylFhWk26qWe6kGq96sVQ+lD7SDLHMb9ZTVkU2NTyFOfGa4lUKcR5pW8IB9+wYpARmMP1+o5bRRp5xrtU5fnrAX24JIIOmLPYBnMF6SDazRcDpELDy9C9V7Ec7Iu8xVuhW1bXc37XvT0PjD1DSsBvg+TqD+hGmtdm3TpvLKilww3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbfmYAb8jSABVtOqICY+V/0rJ3PWzal0/L+sHycZ2H8=;
 b=Bau1gaE7h6LDgYoCGAs5gy7Epjrrs6QmZPYX00TVPtOqMX5kRX1YGy1o1P1FDC8fY41F/Py9EB2P4jQzNP1On7xokxV2GJxaw4GYAJgDyWh22XZhR50L9rN0InaPeT8Y0STkaNIJ64/aFKv7MgHbvRp6gvbqboys9poTQQH/Fp15q3t2k6BxqLy5dymPnovaKCRvN+viSfqhT6wnBfLiHg8Udo+MzZwEosKx2EQIXhK38BDVts48h609/38c6leZpsqmysH8KvERg+n5xuAGR7FMmUK88Hpa2/+j55fBOO/Er2p1kqZjcvQlF71yxjJmDPjsW/Gk7Ov5SgFk0KuAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbfmYAb8jSABVtOqICY+V/0rJ3PWzal0/L+sHycZ2H8=;
 b=Ch+24esa/C5mZTzPcV4udBllJ+5gYDPLEOMiKi+me3TX1QG8oW5q5U5Tk/yX/Hf57+P2N1VDUl0BHa6zznSHKFIJT7gg/h/X/XLM+tXfhrKJ6Ck4poGivV0VxwTVGugWWkMVZv4doHwNkBPkVp6UMgm/doDcbL1GHH81CjoOY+FItyKdYRfn3NTFRPxxnKOApGW1qd8Rpu4RFx21BcAdOExvqN4d1ssN7EDglq/ZM7PIjhKHvNDXT3p5si71TYeKpSmhLUKtFdX44/u9cOzgd6fOMlLLKRo0WodhuMcxQsjq9QV/LFP2/qphfqq7rcpFFKQwcvFaeVHYRujq5fbnvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 09:35:12 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:35:12 +0000
Message-ID: <19c640b9-f57a-457d-ab8f-21dda545547f@siemens.com>
Date: Fri, 12 Jul 2024 11:35:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] classes, recipes-initramfs: remove do
 prefix for adding task
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240423153532.175546-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240423153532.175546-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb50ccd-71cc-4157-c6cc-08dca255edd5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vkp1TTJFc0tUWHovWllqbVJiVGlhbmRmYVBYT05RRnoveERKYStKRnJGNURW?=
 =?utf-8?B?aHlqenhWVjBkN0FKK09sa1JnbElNYUtSeHlMMmZZVGFVdDQweTdRUW1BZmpw?=
 =?utf-8?B?bjZobUxkZEgydzhOZ2hydXRyRnFzY2VBb1FhazlsV3hTUmZ1anZGankxTFFY?=
 =?utf-8?B?a3Jva21COGVybm5TT0pOdVUwWHFkS2ExV2Q3b1ZaSWNIYU1LbTI5TFptSTRw?=
 =?utf-8?B?emphMU9MeVRUYU1aVDR4SExWd1JwWEZycnlNUjZNZkRhU2wwbVR6ejBKUTBp?=
 =?utf-8?B?a2NLdU93djVjNnF3em1kSEJoN1BmMk5RUzdBdW0rVXVUdXdvU3UwRnUzL3N2?=
 =?utf-8?B?NWtROWpJdURGdlBnWVgwVmYwYk8vVTZOOGM3Uk03bU5yV1FsR3RUSWMwbU9r?=
 =?utf-8?B?NFljTEI0ZDlPL1dCTGRHQnVVRWFKUVdNZXp2ZVFhdEUrTG1ZOFdOOXN6ZnBU?=
 =?utf-8?B?aWk0ZDRqU3NrSmNPdDdSMEpPRjBBaGhKWUhySFFKeCtuSGNtc3NMV3Z3bGpj?=
 =?utf-8?B?a0w4UUxrM3BYVUtIdW5xUzdlS1BpcEFic3RkaHJOL2w1REEvb2JqNkJjVHg2?=
 =?utf-8?B?aHlzZUd6eFVIaUNvaVdSTHBFOVEzYk1MSzlTd3V1NUcxVG9rZFFHek9SL1BE?=
 =?utf-8?B?NTZhZVZzZUpxV1UzM3paNFNFejRQenFqdTFOUHRsMmlDallVZHZoZ1JJMVFq?=
 =?utf-8?B?c2gyYm45aHBuU3hraE5yVG9zY3dCQmVPcEFqd2ZZbnZOcXVwbnh2MFovL21P?=
 =?utf-8?B?b1JGWFR2TTk3TzNuYWRGZGlvQzR0bHNQcnprZFBvVUhZYkQzMTBYU1l4UGVQ?=
 =?utf-8?B?VGNONnVKZnkrU2NEdDFLWnh0eFlPNlFENEdvUUY3eGJPSVNJcjQxZVJ1a1ps?=
 =?utf-8?B?Q2R3N0FqTGFLc3E4OUp5eXZsczhUYU56WE9BTjVlVDc1cHRxTmhCMjQ4OERy?=
 =?utf-8?B?d2tzT0ROakJHeWpNRW8ybWZ3RmN3Snl3RzJMU2czdGtKNEM5aW9EbWJMS2t6?=
 =?utf-8?B?aE5SWlBpUU1iSUd1WlNVWk83TkVFZS9abTAwck9rV1VvbmFQa20yeGwrN21n?=
 =?utf-8?B?d1hjNVZJRzdiOE1ZZVdCbitEUERxZjI5SmcvVktpSFp2c1Y4QVFZMGhLQ09s?=
 =?utf-8?B?aFlwM2xidjBrZ1lTcFlrVWp2ZmpCbjYxa05Gelk3bERwaHNsYm5uZGgvNHg0?=
 =?utf-8?B?WDVoMXpPTmJpck5XN09RMzVpWUZabERRQWhQREs0RzlFZjBrVkExUHRpM3R1?=
 =?utf-8?B?bTcrTjNoNFo1ZWVHY21ma3B1VDExRjdzR1pZZS84d3pNYW1sV1RXNURnRW9Z?=
 =?utf-8?B?UG5KWC9YY2U5K2xDWCtNeWI2bzhyTWJMbXppekhvR0REd203Qi9nbCtsdnRI?=
 =?utf-8?B?UmxjNGlCS3N5YlQ3QTZhazNHNFR4R3o5TUU0cWd2L3pwWGtBbTd2OE1aZUdy?=
 =?utf-8?B?Q21rdVBSRVdNVkx5bmVDZE5xekx6bjlIRUlBa2NGN2RiYzVBdXZSZmtPVXR5?=
 =?utf-8?B?ekxIbUl1WXU0VitrbEMzWWFnelJ5MndubXlXZ0NFc2ZyL1FrMHZwYUl0UTBT?=
 =?utf-8?B?U3NIaVZaUmVGdDh6MzhPbzcxcGg1QXFGVVgyT0ZVTko0RXNTbTlubGhrWjdu?=
 =?utf-8?B?dnBWZXdSL2pRRmRJa1BUUG1FeHJ2L0xCL2pDQTVadVFSVXE4bVVld05aNlAx?=
 =?utf-8?B?ZW13SUwwUWoyTDJCZGxYWkRid3Q3R2hQUmt0Yzdsa21hU0JhRjYzM3YvbGRE?=
 =?utf-8?B?OXBPME5nM2NCUVJIc1JJcW5Xayt0RDhGcWtjYlIzTXZRYlVDclhXRVh0RDRs?=
 =?utf-8?B?eHV4eTNJcDBzNGRldFZSZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHNtd0NNNWlqTUxlOTVtQjA0RzVZcm13cE1iVHJENGdCTWFOVGhOdVdQNUJC?=
 =?utf-8?B?ZTVpVmI3RGNwT0RZdmxkMjlzWFFaQlhPNXM4b2s3bjdHVXU5dllQaU9iSEl2?=
 =?utf-8?B?TlVmbG90bVhpazhZeHZ0cXpaWUJGdjVPU2k2QW11WnBlVjNZQXZFRC9KRHR0?=
 =?utf-8?B?bEJUVnViMFRRcE9SeFJFVFp0YUN3dWxERWJ5d0RYSGJEUG9mckZwZHpBby8w?=
 =?utf-8?B?WnpKaW5kcGFrSW1kVnp1SWRVU0VwSytKT1JFNVMzT2Z3UUNJRmRnNWNjSnBt?=
 =?utf-8?B?TmVKYmhueXlzVTZuNFFMWnRwZ1c5M0FXMlFPQkFFY1pPeFNGTWovN1ozYk9Q?=
 =?utf-8?B?Nnh2Q0M5eFZUdGZpSjdGclRVbXNXMzVMUDhackVyQWdtQWI5c0lDNUxGN0s1?=
 =?utf-8?B?L3ZFdFhCUE8weXNWNXVlQ3VyR2NQZDRrRDZsWmkvem5LY0o2N2J4NDd5ZUhv?=
 =?utf-8?B?U0kybHBTcERaUkV6bVpWU0dIRVlDaGhGYm5LUC9hM0h6YjAyY093RVZKbkY3?=
 =?utf-8?B?M2c2UXZONVpEOFowWjJtcERrYXpRVlFkQnZBdllTYTAyWElBUWpQRzgxekZq?=
 =?utf-8?B?Nmw0bkltKzY0VVM0M1RFRWdYMUZabFJNdHdlekd1a1pOdzFFUGhIT09mM1ZI?=
 =?utf-8?B?enBUaEYzdVVJZWdhUkNSRVdnT3dIa0M1RlZRc2phbjIyMit1MmF6ZHNtdktB?=
 =?utf-8?B?T2txUHF6K1VpaXpNektSbkFOS0FkMWVPbG13THlJeGg3dWhQdCtzRlFsbXlx?=
 =?utf-8?B?MUYzTU1hMEorZnh2RmI2ek5LMXJzU0paSWduWXVabnpiU1pjeFFidVBNWVkv?=
 =?utf-8?B?cGhqUGJTdmlFMFNsNmIxN0JUcUZiMk53MmNXTTZPYkVya283UWdFamR1SzBu?=
 =?utf-8?B?OVlqOHpIUXA3cVo5cExKSllac2dBRnNrWndlWnhlOTYvdmdyTHltbW9HZmRO?=
 =?utf-8?B?cmJqWmVISTlGOEZaZXIwM2NxbmdTS0tuQ29PazU4NS8wNUJibmZaYWpROU02?=
 =?utf-8?B?Sjh1Y0NtcTh6QStsUk4yRzVTTXVJV2t3aW0vUzluS0ZoZC9Vdm1UNDZqZFhD?=
 =?utf-8?B?Mm0vREtRM0lUY09ubkZZNlRhUFBsNzZqMFlHc1phTTRoWFpVZElTTy9GOEtZ?=
 =?utf-8?B?ek5YMjhHaHFURml2NmxxOStGTmdmT1d5d2dRKytZQllrTE50aU5iRUFlM2wv?=
 =?utf-8?B?K0Yrb2ZVbUlrR1A0cmhQeFIwMGZ5S0xLenlmb0tPdkM5TUdHTVVJWDk3SXdO?=
 =?utf-8?B?dThjMC9wOTluN3ZVQk13VkdVdERsYW9HVkljbVlhcEVicHc4VVpMZ2kwaDBL?=
 =?utf-8?B?bHAyRFI5NEtDNkRXekU1U1Evc245VSt4bldUa1JPb1ptdjl5TTRqclczOHU5?=
 =?utf-8?B?ckFYa2Z0NHM3L2c1VGc0M2RuR1NJTDhTTXZOZmh0OG9ZemltZTluU0ZkMkhB?=
 =?utf-8?B?eENyWjMxM1JsK2k0S0cxZjJMODdPNHZCb0FpdTk2aC9NZ1pjSHhYTEVqU3hH?=
 =?utf-8?B?aThGTUswd29qbll1bzdBZ2tFMjBWcGltdGRWTEJnblkzR0c0VFEzaFZrRTBo?=
 =?utf-8?B?WHZKYk91Sm9HRXhVYklVdmZibnlWRzBiMTBaWGMvajk4dGdHUElxV09QWjNT?=
 =?utf-8?B?UFRCcnE3VTYzS3BTUi84TzdEUVRTd2FzWE1Mc0UyeCthd1hEZDM5NisvcUk1?=
 =?utf-8?B?THEwajl5bnVaNXM5WndTZ1ozTGR0ZWk3Zyt2aUtIOCs4c1BIcVNqVVE2UHRE?=
 =?utf-8?B?UnF3NjhaeFhvbVo3cXB4ODE4ZXNUczhTQU5zcEcrN2kxT0E0cE9Idmp4S1ND?=
 =?utf-8?B?SmZMYTJVcElYd3hac3JXbmxBWG9tK1RVMEJxNFU2ZUxXenpuZld5bk9KZkhJ?=
 =?utf-8?B?emJEdUZwSDZ4dGRUemsrdk5tTGEzcWNQSDlPUG56L3R4Ny9xOW1Id2hodkNq?=
 =?utf-8?B?bFI3NXF1L09SUlRZZDkvTFBEUDI3bzBnR0duU0tNM0h5bjQ5czZuU1RxazVu?=
 =?utf-8?B?aVVkVUp6eS9Eamd6SzJDSmlvcElORjk0cHFTZURaeHdTcW9qOGJGRmIza3BD?=
 =?utf-8?B?OThPS1h3Y3FLZDBYYkRxT3djSjQ1Szc5TGY0ZzNqU25yUmFOaDZHMVZMMVhp?=
 =?utf-8?B?dnJzdWNhOHBjTHp0ck91M2RRWkVoQVpwajBhcjl2dG04bXpEeHdId2N0c3or?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb50ccd-71cc-4157-c6cc-08dca255edd5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:35:12.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMyurMKghSDGDPw5rSKjrF1OkBwmfeQ08h2TwZzBiqZxZv6LkTf7BJHriIi2dpWItL7UBHU52fdM+MkvT0fpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8558
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16469

On 23.04.24 17:35, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Try to follow the same pattern as bitbake recommended to add the task
> using addtask directive, only we corrected the style apart from there is no functional changes.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes/delta-update.bbclass                                  | 2 +-
>  classes/deploy-firmware.bbclass                               | 4 ++--
>  classes/swupdate.bbclass                                      | 2 +-
>  classes/verity.bbclass                                        | 4 ++--
>  .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb        | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
> index c2df266..ae2453d 100644
> --- a/classes/delta-update.bbclass
> +++ b/classes/delta-update.bbclass
> @@ -96,4 +96,4 @@ IMAGE_CMD:delta_update() {
>      esac
>  }
>  
> -addtask do_image_delta_update before do_image_swu after do_image_wic
> +addtask image_delta_update before do_image_swu after do_image_wic
> diff --git a/classes/deploy-firmware.bbclass b/classes/deploy-firmware.bbclass
> index a4b754a..aad7277 100644
> --- a/classes/deploy-firmware.bbclass
> +++ b/classes/deploy-firmware.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023
> +# Copyright (c) Siemens AG, 2024
>  #
>  # Authors:
>  #  Felix Moessbauer <felix.moessbauer@siemens.com>
> @@ -27,6 +27,6 @@ do_deploy_firmware() {
>  python do_deploy_firmware_setscene () {
>      sstate_setscene(d)
>  }
> -addtask do_deploy_firmware_setscene
> +addtask deploy_firmware_setscene
>  
>  addtask deploy_firmware after do_dpkg_build before do_deploy_deb
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index e91238d..0fd6329 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -71,7 +71,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      "
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
> -addtask do_transform_template after do_generate_image_uuid
> +addtask transform_template after do_generate_image_uuid
>  
>  python do_extend_sw_description() {
>      cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 9030c84..93dcd31 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -104,4 +104,4 @@ IMAGE_CMD:verity() {
>          >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>      create_verity_env_file
>  }
> -addtask do_image_verity after do_generate_image_uuid
> +addtask image_verity after do_generate_image_uuid
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> index 3fc63ed..526a8d6 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -53,4 +53,4 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/verity"
>  }
>  
> -addtask do_install after do_transform_template
> +addtask install after do_transform_template

Thanks, applied - after searching for it for a while again due to the
wrong timestamp used. Patches can get lost because of that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


