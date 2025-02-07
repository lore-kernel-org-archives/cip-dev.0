Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFDC02196
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 10:11:51 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.35])
 by mx.groups.io with SMTP id smtpd.web10.66165.1738923102554135112
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 02:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EGHtyYfu;
 spf=pass (domain: siemens.com, ip: 40.107.159.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYXDN0EcicZuZJsLFzT3jot9Vv7SeA4vP4Bh1Lmol4N8uRF51AlIgM5FuPOPfRdbflje6CwQqH94mkUd+k2VJ5iaRplssQdf4EUXtzVTGfclMUxWT9ZJrDBkDvqbAsnp3QO+A2k6HXOHeHwjc5ViXA93YHz/lN0SIS2hrtDR2iXpcQL//5Wmr4HLywXBiz+dO5sERSlJqMggVCYUzOnnrwGM1rz0ycOA5efxwSvP8/0OA6EYmensWZSDlntd+nzDHokjsQhYYQyUCZ4q1SupYpsb69iHzJ/+QWaKnW4UA2sOHe89LSY9laYbPR5Z9yc14m9U313E5njJirglUqzXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcOnOsXGYaQjYVGOybxTIpcmDW1yU0CH9MCm2aUH8nk=;
 b=X0AVO+nxmjmJ4gHDA2eJysPPSkLUDPsaasPA6Ux0qNNWbIP4vNpBwb93yr+ST9tvexROBHgkQTfQ702MkJn5aoEX0XDx/v8H8GBotlngye8Pe3OPEMh0EO2nwk5zX14aX9sAuE+YJXZUa1Tx/+Xymn/iOtAw/WARTgGe6wnlqc284aAZlHwBSG0Z/tzRQQQgIEOE52o8JzLoHyg8uzHvyP7xC7VdE30MMcI4sB7sNFmUfAXLqexhwDVNf3kipYHMu2fJrMXec/b7H++dSpXXBZ+an3f9JR61DWRt3Bx9co5UR/dSCkQr3427vIrBNbwBCf51u1thfVeCiey8T80lEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcOnOsXGYaQjYVGOybxTIpcmDW1yU0CH9MCm2aUH8nk=;
 b=EGHtyYfu/9AnKTInf9cpxBtWSWqLrWJhjXFkGtLqoWpqwkYfOkYdNNi4AW6vxXQwrgxY/+DIt0ANxHrzLjw/xUy7mBsN5i4uUTCLBJ1wnlFT40FUYS6RxULYYwO+p3GQsKKs49n/7Il3Y4rdnn5dzjjP+Iv3rRVVyXBBxmByvOuA/75oG43C84fQWtZ7mvQY4PqZ2UH643aezzDmGk2YzVWd2gi97p5AR9k/iUlLxO3xuTJaGPk9SLP6gdQBTDoCjjfgzWrxAXgPKRy5XV7jxat4Ho8dbiwT6HKhexBcoSptVSH9d2wZKv3JtplYcietkS06ItsTcGXirnHRHsJWdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Fri, 7 Feb
 2025 10:11:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 10:11:38 +0000
Message-ID: <df4181d3-2452-434f-a31e-4d9c821e0390@siemens.com>
Date: Fri, 7 Feb 2025 11:11:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kas: Update to release 4.7
To: Michael Adler <michael.adler@siemens.com>, cip-dev@lists.cip-project.org
References: <20250206132546.177943-1-michael.adler@siemens.com>
 <20250206132546.177943-2-michael.adler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250206132546.177943-2-michael.adler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e39eff8-0b42-43fb-c6fd-08dd475fcf5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c3ZhY0NqdUgwRHBJcEtLaXo4YUk3Mlg0aG5valBUeHYva1JHVGlObExCeFJo?=
 =?utf-8?B?MEk0VldCMUJkU1l6V3VNbytnaFJ0UXQ4Mk9sMk1IOUxpRkhwNDB4TitoU0FW?=
 =?utf-8?B?WTdqM0xVYzZ4bDBLWlBtR0h2dlB0RmtldlBnL0VmTHo5RDc4L211NC9Kejhl?=
 =?utf-8?B?NVRWSHFlOWQyV2dFVlVrSUVxbjhQRzl2MzkwWjRyL2xhWTZpU1BvdFl3blZU?=
 =?utf-8?B?MzNTbjF5ODdTK2YwMDZyOUszMlRxRnRjUDlmYWFTeGVDd2ZWQ1R6UWhDVE51?=
 =?utf-8?B?T2lWYWdac21NM3BvVzFwYm5BMkpRVlFSZWNxUk9kNXFxeGZoZHhXV1dEWE04?=
 =?utf-8?B?QzVQRkI4Y3NEL0R1NXkzNzFqWXk1b1FFTmNzY1dFMzJ1VXZQWVVyU3NJZlQr?=
 =?utf-8?B?dmFTMjdBZ09rWWpjUGp4WTJNK2hIQm9IOVZrdktNNFh5Q05IRm1pVzh1STNK?=
 =?utf-8?B?K2x4VklOTFN1aHgwZjVHaGNGUmNkWTJuNUhwY3VKcTJHQWYvVWhDMTNYcURF?=
 =?utf-8?B?a2VOQlZ5bmloRE1vaGNmdXNxR0RnQ1FUbEJaS3dZZVRKQlpDTEdWYWZVekRp?=
 =?utf-8?B?cWlPS2VUbm9EV2lTN0dVS0tFelQxZTRzMFByV003WDMxUkJPdnEyOGFjVW5X?=
 =?utf-8?B?aFlCbm1XK2lDaXlxMkRSOEJLcXhWMndHWmJBTHE4bnpEbXYzTzF6bDZaZW0r?=
 =?utf-8?B?UUk5QnNuWk9KZjlvUGphMVBZWVdDbkZOekFmNUYvSkVkaE11VUM2M0tJWkYy?=
 =?utf-8?B?aVVQZ0tSSiswbzZ4RDZvMGJmL3lJTjkxNHpRdExpRG9UakVEd29ydDBOaFAx?=
 =?utf-8?B?djJ0MDI2UUprSGVDL2x1VUhjNDJQY0VXYjRqVExrMXJBMUczZTRIM0g5RWpM?=
 =?utf-8?B?RzdrWnRwRU45c01wQm1PbmtyeHl0WW40TEx5Tyt6ZXZiSXorRnBVdXBtb2Z2?=
 =?utf-8?B?TzV6dHQ5VkFNcTk4RkR5Uk5NditsOGlHNVB2NGtaaS93VUtVVnkrM0FiazJv?=
 =?utf-8?B?Q3dXWjBoRnZkdmQ2dDFPZzdQL3N5TklVYnBUY1RDN2FtOVBkNG9vNDN6cEwv?=
 =?utf-8?B?QkdoTWQyZjhQQXRCYjllV1dpR2VKVmIxaGUyVXZ2OUZSM1B1bEZid2xtZEdW?=
 =?utf-8?B?RDNDblVSZmZnYWxpWjZGZkt3c1FYRWNYTmFtQVFaR1YxUTNPbUROTm9Tc3J5?=
 =?utf-8?B?V1p6NFRxQXU2OXZYQVFXU2FzUktPcmxZTVQwd0g0dCtlZ1kvRWVkQ25PSFcr?=
 =?utf-8?B?UE1SZWRkcmNlSWNWeWdDSE81ZFNNcjRUeDhrejhGMDVNZkFWSnVObUVjOFEw?=
 =?utf-8?B?S0MxdmRXZmRmNDZNSEtPQVFqSm1HaTVXUG9reFFYMUoySlpFZWErNUNPWjBj?=
 =?utf-8?B?NUhPQlNSU2tmelNLOUplN3VmMmFqWTc2WnB6d1Z2SUwrQzgrcVkxaGtjYXlO?=
 =?utf-8?B?UkxJRVA0UEdWa2tBRTFQQzIzTWNVSzl2d2VDL242dDBCQW5lN3RKaVQvZUVD?=
 =?utf-8?B?L2V5a2dKNWY2VHQwT3NvWWZYZ09vNThBZUI1UVhtUHNXcllyd1VYT0srNHN2?=
 =?utf-8?B?UmNzTlhzbVE4THZ0amcrQUJiR1dqWlk1eEV4V1JxS2Z2eTJOY0trMUphOHF5?=
 =?utf-8?B?NjlITHJKUmI3VlEraHpDb2VGam1tWXJhMjZ4ZndiVHJtdVJyc3pWRDczWjE0?=
 =?utf-8?B?WDhBRlhzMDFZaVhyYlExcENDVnhCSUEyR3NWVldMQTgxei9TU3dYQmREN0Fr?=
 =?utf-8?B?NWhmWmRmTzROKzZtZzNtQUFIRWRmMjFWVlF2NHJ0TStBVFd4TTNWZUtRSENS?=
 =?utf-8?B?MFlpQ1pNTWViMzBXZ2t5UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTBMYXB1SWNSVlFSOHRpVi9hbnJLTFdUM09heHgra1QwcktKL2RHQTUwSnBB?=
 =?utf-8?B?d1BIMzVwZlBoZmR4V1hXWXFZc1FjVXJibGVTR2greFFhZkVRczBMbnNyUC9v?=
 =?utf-8?B?K3dDZnVYOWdaT3MwaHpKdnFKMmQ5dmxRYXZxdE92Q1hxUUVMQVkvQzBrSmpN?=
 =?utf-8?B?VG1HL0FXRERTZnR0WGw2ajZIVlVvOHhTSVdxRVBmM0JsTEhPNjk1cFNUaHRq?=
 =?utf-8?B?RDR1ZXNrUktZbEhQOXA1Y0pYaUx6TEhtL1ZUWjUyRHVacFBKSjc4Tlo2UWNQ?=
 =?utf-8?B?R0xBd05aNDY1aGhzRUEva0ZRVnhLQTJzUGxpQVRBMjd1TWNhTEJRN2U1NUUy?=
 =?utf-8?B?b0EvcUZFTkFyd3NsdUlQQmlsUnhqSlF6TjkwRE13VzBPN05uTUR2UkhmUlRO?=
 =?utf-8?B?SFo1WnY1NkZuZDJtVXY3aUNCTGlmc0hQMUFxWmsyWmlEcTdGM28zTExGY2NC?=
 =?utf-8?B?Ni9xL3ZJR3U5WEE3OGhjdVd0Wk5mc3F4Mk1CQTIra3lrQzBIWE9PL1hKOEh6?=
 =?utf-8?B?MHJGM1BmUEZwSjJybnE2eWhaVHFJdSsyWVczeSsxTGczTWpoQXhLV2l1bGlS?=
 =?utf-8?B?dEJPa3BlU1RyVU9zQzdkZHp3ZWc3WkxXUlh6N0Vhc0tnelk5b09xU2w0eFQ3?=
 =?utf-8?B?ZlNvWHdkcnA1c0haRXd2V05GdHJqWkJwaE00azJnSjNheWNjaG5WUGRqNW5v?=
 =?utf-8?B?aWZka0NXTVRIOGE2cTExNExwYzlkY05waUM4dzZwUWE1a25PNG5QSkxKa0lm?=
 =?utf-8?B?SXV3dzZCR04vd05QckFTUUcvekdzTndBWmpDQ3RLVnRMeENoYmhwVGl6Tmp5?=
 =?utf-8?B?Vmh0eTU0eXNuQW4xdGV3VWdKSXR0L00xZlV3OFljRHVIcTNROVQwdDJxbmdE?=
 =?utf-8?B?NjhVRjRuNTZhTlkzSEdYSTdMWnA3WTFoS1pxTzVTUnIxMmplSUFvKzRwdGtH?=
 =?utf-8?B?YUVZMWJDdmttR0hYcjdpL3pya1crcEtPTTlncEVzMDRla082eVhJaldFc1U3?=
 =?utf-8?B?UWFmSEE1NzJYRW10MmtPeVNndVhUZXV2NUJlNVFjbmhrOGh0UWtYNzYxMldS?=
 =?utf-8?B?K3FnTXMvcmUzc0J2Y0hpUUg2TWpFSUp2bjRJTVJreFVnTExVRWJ0OXE5QUdl?=
 =?utf-8?B?eVRCN2RLYlRYQUFOblh4V04vZ1hsVTZWdlVrOGZ0ekVRbXNGQnZoMnRieDIv?=
 =?utf-8?B?U2t4RCtzZ3llN05oaEp1UFVoVnRGNHQyTUZpa2dhbDBqNDQ5aS9BdW1nR3ky?=
 =?utf-8?B?ZnhKdlloQjJrcy9lMHZXcGhpUnM4MVRXR0dZL0dRdU8wakFqeFFEZ0s1NG01?=
 =?utf-8?B?QU1qM28zSE8vZTlIcnRkYzJ4TnZUemFEZ3NGZEdvWHBhNkl3KzQ4UGs5V3VS?=
 =?utf-8?B?QzJNbDBiaS9DSDVyd3ZMZDVIeCtic085L25TSlFwWEE3WGJMWm5iUVRFc2dD?=
 =?utf-8?B?UTVEekRtY2VIenJUMGJqRE52UVh3Q0gyQnQweXFUdmRkekQ0YTdFbFE2b0RS?=
 =?utf-8?B?RnVTcWpoOHk3NXFXcmU0SDRMbmJWYUk3QlVqMVp4UkhtMEVVSGNNQVFYUEJK?=
 =?utf-8?B?OER3YzhvWVVETUFrNVVZZjkxR2pUUmV3ekoxeFpBbzZINEx6a1p5c0xzNlJk?=
 =?utf-8?B?YldxQkxKMGNBMktJUW1hOFl0cDkzbkhuZUNVYlpjcjhCdDR6Q1pLRGV4MFI3?=
 =?utf-8?B?WjNsbVNsbGgvTVB4cmhkYkkxb1I4eFNaOWdvRkhIYnF6U0NXc2FmMVJwVk1B?=
 =?utf-8?B?b1FydS95K25HSytjUENsVkZaelJwUzdyL1p1eEtGVXBKVWx3eFJRaUI1cUt4?=
 =?utf-8?B?QTFwdUl4YURyQ2JzelhGY1BiaHQ4b0ovM2FLLzR3WEl6bjZrRE0xbVhWdmhF?=
 =?utf-8?B?ZlBEMW1uZm8zR0MwSTVVUDVpN2VQUUl2Y1VFVEtsZ1lLNnhIOEJNTURyTFpN?=
 =?utf-8?B?RU9DRW93dEd2MExncXJHRUF4WGxBWkV4b2ZTU3lkK1VLc1BtVk9IUTlDRU9R?=
 =?utf-8?B?QVFzSU9FaGw4akFRQ0xxcmtzdlo0UW5icE9pa1A1dmk2WDdKUWZhdDV4cVdx?=
 =?utf-8?B?K3pvMUZwVlhlK093ZkY1ZjBNK3V6T1AwQjZUOERER1dyMmxTR1NMQ1huQlhm?=
 =?utf-8?B?YnlXRVFabUJmdTZjMjVnSk9WbzJlK04xaTljRFpPbDd5Rnk2dUVzYUlrb2Ns?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e39eff8-0b42-43fb-c6fd-08dd475fcf5c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:11:38.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k86/Bva9jN6Eh0rTPoOCDBLeio0shjZiZ9RubNl3gO42Gt4cpQtf15ZixBUrgEGqFyBttsSc9oHODGAKuYfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6222
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 10:11:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17770

On 06.02.25 14:25, Michael Adler wrote:
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  kas-container | 99 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 78 insertions(+), 21 deletions(-)
> 
> diff --git a/kas-container b/kas-container
> index 6b2131c..d6118b9 100755
> --- a/kas-container
> +++ b/kas-container
> @@ -27,24 +27,28 @@
>  
>  set -e
>  
> -KAS_IMAGE_VERSION_DEFAULT="4.5"
> +KAS_IMAGE_VERSION_DEFAULT="4.7"
>  KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
>  KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
>  KAS_CONTAINER_SELF_NAME="$(basename "$0")"
>  
> +# usage [exit_code]
>  usage()
>  {
> +	EXIT_CODE="$1"
>  	SELF="${KAS_CONTAINER_SELF_NAME}"
> +
>  	printf "%b" "Usage: ${SELF} [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
> -	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
> +	printf "%b" "       ${SELF} [OPTIONS] { checkout | dump | lock } [KASOPTIONS] [KASFILE]\n"
>  	printf "%b" "       ${SELF} [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
> -	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall} [KASFILE]\n"
> +	printf "%b" "       ${SELF} [OPTIONS] { clean | cleansstate | cleanall } [KASFILE]\n"
>  	printf "%b" "       ${SELF} [OPTIONS] menu [KCONFIG]\n"
>  	printf "%b" "\nPositional arguments:\n"
>  	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
>  	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
>  	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
>  	printf "%b" "    \t\t\tof config to stdout.\n"
> +	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
>  	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
>  	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
>  	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
> @@ -63,9 +67,7 @@ usage()
>  	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
>  			"container runtime\n"
>  	printf "%b" "\t\t\tfor running the build.\n"
> -	printf "%b" "-d\t\t\tPrint debug output (deprecated, use -l debug).\n"
>  	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
> -	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
>  	printf "%b" "--version\t\tprint program version.\n"
>  	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
>  	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
> @@ -80,28 +82,39 @@ usage()
>  		    "\t\t\t(default for build command)\n"
>  	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
>  		    "\t\t\t(default for shell command)\n"
> +	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
>  	printf "%b" "\n"
>  	printf "%b" "You can force the use of podman over docker using " \
>  		    "KAS_CONTAINER_ENGINE=podman.\n"
> -	exit 1
> +
> +	exit "${EXIT_CODE:-1}"
>  }
>  
> -fatal_error(){
> +fatal_error()
> +{
>  	echo "${KAS_CONTAINER_SELF_NAME}: Error: $*" >&2
>  	exit 1
>  }
>  
> -warning(){
> +warning()
> +{
>  	echo "${KAS_CONTAINER_SELF_NAME}: Warning: $*" >&2
>  }
>  
> +debug(){
> +	if [ -n "${KAS_VERBOSE}" ]; then
> +		echo "${KAS_CONTAINER_SELF_NAME}: Debug: $*" >&2
> +	fi
> +}
> +
>  trace()
>  {
>  	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
>  	"$@"
>  }
>  
> -enable_isar_mode() {
> +enable_isar_mode()
> +{
>  	if [ -n "${ISAR_MODE}" ]; then
>  		return
>  	fi
> @@ -118,7 +131,8 @@ enable_isar_mode() {
>  	fi
>  }
>  
> -enable_oe_mode() {
> +enable_oe_mode()
> +{
>  	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
>  		# The container entry point expects that the current userid
>  		# calling "podman run" has a 1:1 mapping
> @@ -126,7 +140,23 @@ enable_oe_mode() {
>  	fi
>  }
>  
> -run_clean() {
> +enable_unpriv_userns_docker()
> +{
> +	if [ -f /etc/os-release ] && grep -q 'NAME="Ubuntu"' /etc/os-release &&
> +	   [ -f /proc/sys/kernel/apparmor_restrict_unprivileged_userns ] &&
> +	   [ "$(cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns)" = "1" ]; then
> +		if [ -f /etc/apparmor.d/rootlesskit ]; then
> +			debug "AppArmor restricts unprivileged userns, using \"rootlesskit\" profile"
> +			KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt apparmor=rootlesskit"
> +		else
> +			warning "AppArmor restricts unprivileged userns but no suitable apparmor " \
> +			        "profile found. Consider setting apparmor_restrict_unprivileged_userns=0"
> +		fi
> +	fi
> +}
> +
> +run_clean()
> +{
>  	if [ -n "${KAS_ISAR_ARGS}" ]; then
>  		# SC2086: Double quote to prevent globbing and word splitting.
>  		# shellcheck disable=2086
> @@ -149,7 +179,17 @@ run_clean() {
>  	fi
>  }
>  
> -set_container_image_var() {
> +KAS_GIT_OVERLAY_FILE=""
> +kas_container_cleanup()
> +{
> +	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
> +		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
> +	fi
> +}
> +trap kas_container_cleanup EXIT INT TERM
> +
> +set_container_image_var()
> +{
>  	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
>  	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
>  	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
> @@ -158,8 +198,10 @@ set_container_image_var() {
>  }
>  
>  KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
> -# KAS_WORK_DIR needs to exist for the subsequent code
> -trace mkdir -p "${KAS_WORK_DIR}"
> +if ! [ -d "${KAS_WORK_DIR}" ]; then
> +	fatal_error "KAS_WORK_DIR '${KAS_WORK_DIR}' is not a directory"
> +fi
> +
>  KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
>  trace mkdir -p "${KAS_BUILD_DIR}"
>  
> @@ -192,6 +234,7 @@ KAS_RUNTIME_ARGS="--log-driver=none --user=root"
>  case "${KAS_CONTAINER_ENGINE}" in
>  docker)
>  	KAS_CONTAINER_COMMAND="docker"
> +	enable_unpriv_userns_docker
>  	;;
>  podman)
>  	KAS_CONTAINER_COMMAND="podman"
> @@ -269,11 +312,6 @@ while [ $# -gt 0 ]; do
>  		KAS_REPO_MOUNT_OPT="rw"
>  		shift 1
>  		;;
> -	-v | -d)
> -		KAS_VERBOSE=1
> -		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -d"
> -		shift 1
> -		;;
>  	-l | --log-level)
>  		if [ "$2" = "debug" ]; then
>  			KAS_VERBOSE=1
> @@ -285,6 +323,9 @@ while [ $# -gt 0 ]; do
>  		echo "${KAS_CONTAINER_SELF_NAME} $KAS_IMAGE_VERSION_DEFAULT"
>  		exit 0
>  		;;
> +	-h | --help)
> +		usage 0
> +		;;
>  	--*)
>  		usage
>  		;;
> @@ -293,7 +334,7 @@ while [ $# -gt 0 ]; do
>  		shift 1
>  		break
>  		;;
> -	shell)
> +	shell|lock)
>  		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
>  		KAS_CMD=$1
>  		shift 1
> @@ -459,6 +500,22 @@ set -- "$@" -v "${KAS_REPO_DIR}:/repo:${KAS_REPO_MOUNT_OPT}" \
>  	-e KAS_BUILD_DIR=/build \
>  	-e USER_ID="$(id -u)" -e GROUP_ID="$(id -g)" --rm --init
>  
> +if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
> +	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
> +	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
> +	# we have to mount the common dir in the container to make git work
> +	# The mount path inside the container is different from the host path. Hence, we over-mount
> +	# the .git file to point to the correct path.
> +	KAS_GIT_OVERLAY_FILE=$(mktemp)
> +	sed "s|gitdir: ${git_com_dir}/|gitdir: /repo-common/|" "${KAS_REPO_DIR}/.git" > "${KAS_GIT_OVERLAY_FILE}"
> +	set -- "$@" -v "${git_com_dir}:/repo-common:${KAS_REPO_MOUNT_OPT}" \
> +		-v "${KAS_GIT_OVERLAY_FILE}:/repo/.git:ro"
> +	# if the workdir is the same as the repo dir, it is the same shared worktree
> +	if [ "${KAS_WORK_DIR}" = "${KAS_REPO_DIR}" ]; then
> +		set -- "$@" -v "${KAS_GIT_OVERLAY_FILE}:/work/.git:ro"
> +	fi
> +fi
> +
>  if [ -n "${KAS_SSH_DIR}" ] ; then
>  	if [ ! -d "${KAS_SSH_DIR}" ]; then
>  		fatal_error "passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
> @@ -484,7 +541,7 @@ if [ -n "${KAS_AWS_DIR}" ] ; then
>  fi
>  if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
>  	if [ ! -f "${AWS_WEB_IDENTITY_TOKEN_FILE}" ]; then
> -		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a directory"
> +		echo "Passed AWS_WEB_IDENTITY_TOKEN_FILE '${AWS_WEB_IDENTITY_TOKEN_FILE}' is not a file"
>  		exit 1
>  	fi
>  	set -- "$@" -v "$(readlink -fv "${AWS_WEB_IDENTITY_TOKEN_FILE}")":/var/kas/userdata/.aws/web_identity_token:ro \

Thanks, applied both as one patch to keep the update atomic as in the past.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

