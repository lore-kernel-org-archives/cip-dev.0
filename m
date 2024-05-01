Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C74C4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 20:54:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.59])
 by mx.groups.io with SMTP id smtpd.web10.7878.1714596861684260197
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 May 2024 13:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oSDNjpph;
 spf=pass (domain: siemens.com, ip: 40.107.7.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxPHDlaEPzXMnmXfcskUPsNqE9E+zy15yeZiMahn9fmR2s4AAN8KZdvAHsyFsl69fm4Uxrz0yfcbqdxxkd9GplsCpilucLv5gCE675hsbSUQ1NVXB8rJDUl+qLF3I73w4zF/xplz0Ey3ooQmQnyOWEiVJpzwqKg09B9X2MOTren/mOjQQF5kTwHV44/7oDL7/C6JDtIHM0dPE9urhaV34Hh1RgRvj4YHhdFS78B1Ibo68/VvFWGMtQgPxDzlKNj3GNeNgZDGFPC7yfRmANyuTbSFHurkZl4SuJ0wzYAK6WWqVifDM74wCeMSrpgZID/vDGbrkPGo+qQ6NvVo5Rix4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQHZEKaMrhdwbh7GhJ07BAvniub7CHMex2VIVNM6yGY=;
 b=J5JPYgY/lq028xMy5RV5PF+8SI4bxxJjM9I8Y5Jd4EJEobLqJrBoEFKAy0pbqa9ntDZimgUfOmEvn7cNIijOcZf2qD4xoOY4qM1couWF4teY0xe6BbZtKWhu40X2/tudYHCacAZkNmKsWxQ+AwmYIJXrBh5WSnjBOngDSEMFmsW4XyGdM0zeSGBWYUpxebncD4cRJ/z9O5PdyJfTkAZowbW6kL+GWIIn/qkd7Fa3GGFKeE+2sMpWewd33g4qTwarDVdUNDl9+vqVx/Ob/2SyDkh+6fAXF6Qw9CNK2LHKaxwlfEepP4TY5WBHBJqcd1hMP2nKjkiMrxjRr4BgqXw4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQHZEKaMrhdwbh7GhJ07BAvniub7CHMex2VIVNM6yGY=;
 b=oSDNjpphcgsh0OBlin2t0+CpamloA2q4j6Ada44AZ2QB1CZvWo9pttzVrmuAVu1LtvUtcErROBDDqZM39YJ/T+rVGqg88UBAjCAUfcb6Uf/J4uL97sKjyPrveHK6eXxH3UsAE57VNpBQBHpadIrJVuVeyDnWEiIEkW8x1hFBirTN9oY7wiSlYMLyym0WR2QBT03OHQISmTVwo3jAXD8+7s+94v03yrzFjOHLO5dVJgj3v0FRargMD1iiWIu+3RZrYqVP/iI4gWl0NkQueCb1WgA+SHDEGyOAoc0jKHu6LPyOhMrnPY2+q8ldohrlvzCVm96+Blz++/MjaSPkKBIdtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 20:54:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 20:54:17 +0000
Message-ID: <edcf5d93-d624-4a09-a613-4bc66f197b6c@siemens.com>
Date: Wed, 1 May 2024 22:54:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH v3] update ISAR to latest version
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
 <20240501120001.855311-1-kumar.rakesh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240501120001.855311-1-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c4c8d4-f2f2-4a19-12eb-08dc6a20ddf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UXVUb1p2bWIvLzhBbXJTVjJsclJyS09qUzdnMFJFWEZjMTBQaW0xQUl6dnVr?=
 =?utf-8?B?dmt2YVd6b3VFalFleHdwejFPZ3lOeHhZZXFGUWVzM1hOOGd6SzF6Q3BLeHg0?=
 =?utf-8?B?RHZrYjYrSEZnT2VSSENvZzgySWtnc0JDR25JUjFRUkN4UjM0aW9tWVRWN2Nh?=
 =?utf-8?B?dVowSGp2VnlnWDdWUmxVME9Ec3VLVHo3NC9KTTlCQzhOWndKc1pEeUxzd0hP?=
 =?utf-8?B?WVdiVnZXYy9BdklrUlNKWWlQSDdveVRCeDRXU2VYRlhjTEFIbjh0VnJlSEpV?=
 =?utf-8?B?ZDVjenhyL1VQaGpucURoNDl6bTRoNmU0VHlPczhDcldVWXp5Nyt6dXhvVUxR?=
 =?utf-8?B?VHpYMDNNWElaa3hlUlRtdENMT3MyUU4zOEY1SURWZ1JpTzdXR3BIbWtnOWF0?=
 =?utf-8?B?cmlFd1BvWkNHRlJGeUJ5VTNSVnBLY0VmZlVQNDh5clFkRVhRZUtoVFpYZ05Q?=
 =?utf-8?B?MlQwbjBSVnBVa2JaeU5XSUxpYU5pd3ZsWk5vU1d1YVdMN1o5M0dRN0Q0cjB5?=
 =?utf-8?B?WjdyN0J2SkNhR1lMQzFkd2IwVGt6L1RBMklzM2lMWCs1VUpTUUJGSHd4dXg0?=
 =?utf-8?B?U1lteXBocmlvZk96TnFLYm9HbXpORS9EejY0ZHoyakRmOWNPSkJpREJBdUpH?=
 =?utf-8?B?ZEZNYjAvUVlaMWJCaWdGVktrRkZEUmVRMGFFelFTb3lwTmZSdGdSalZ2MFl1?=
 =?utf-8?B?cllLOU9SN3kwWTdHUCs1QjBERG5nZmV1WUpPcUdVR2FPMURucFNUQllDTHN1?=
 =?utf-8?B?ZTQrRzBjdERibXFQSTY5ZTc5dDdKMUxodDJCREMyYmEvY04wUk5RNjVhZmFn?=
 =?utf-8?B?T3RYajkvdW9nRzhRM2ZnVGZZRjVzQ0lmY01QUERhZVhEK1NWNWRGRjNYN2Uv?=
 =?utf-8?B?TWdvSTUrcGlWTmxYbFZvaFpaTFhocnVyWmIxSHZ0c0M1KzkzWUJJdFIxeDRj?=
 =?utf-8?B?bEltWUdGRzlSYjJoWGozazVhdzFVaSthY21CVEMrRE1zdU5yVFZHa3VPU0g2?=
 =?utf-8?B?VmVGVy94a3RmZXRFMHM0T2hFME1kenJaZmtsK1puN3V4S0JlM0h5S0Y0VVQv?=
 =?utf-8?B?bUxWZmdnQXlrZzk5c1ptNENCZ20zOGQwSjR2Y21IelphOE55cktiLzl4R3BT?=
 =?utf-8?B?Y0dVdjlBcVMycFBuTkVBL1AzU1grV1ExSW1lalpMdkJqZ1BsWlVCQmJrMU5l?=
 =?utf-8?B?cFFaK1BMNHg5WVEwYW1WSnN0cEJtcTYvSUFFQUlBRHdaaWV4TERxakFwQnBa?=
 =?utf-8?B?c0FIOC9KYlU1VTBRTHlqRjlyaWJJTzY2d2JhRktCOXkyYm5wL0hIb1ZIbnBj?=
 =?utf-8?B?ZUVLRExPSnRyVm1YemI2L0FleDI4UVF6U2JORElYam9ZVjZ5c29FbXhhcXo4?=
 =?utf-8?B?b1grZUxIUDVhaXVQenlCSWcweHFCR3lCRUNBQ1ZWVFpGYmpNZW5zM2RHYitT?=
 =?utf-8?B?dDhwWHJSd1lUY2N2RVl3NGUrU2FWKzR2Visxa0tuWWJxamFuZG1FYUpScVJw?=
 =?utf-8?B?bnA0Y1U3a21RK0pWQWlpdUp2OVp4Z0V2TGE1bUErZnQxcUsyVDU2dWk3dk1p?=
 =?utf-8?B?ZlNXS2VOU2g5OEFiNm1jNzJFd1VxR0RzWmR6M3hCSkxJUzU5Sk5scEkxVzJn?=
 =?utf-8?B?WUVXYTRRUldxWW9tekNwQ0lpcTBZdS8weW9NQzByNWYwd3Yvc3lJMkFCYjEz?=
 =?utf-8?B?ZHNsUllpK05EMi9WZE4rcEp1Q0FiQW5XYm03ZEI1UXJRSG90NGt0UzJnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUhUSG9FMFJEVWJZbDNZV214KzF4QjgwMm1Ua1k3eDhUNzB0RVNSQ2hvS0Za?=
 =?utf-8?B?NHZyR1BKOFR3RTFvenNxYlVYM1M1NWsvWUU0TFgrMEZ6SUhDZnl4ZkFncWRC?=
 =?utf-8?B?alA4aFJ3clhjc2k4QnlHYlh2VzZBT3J1dzJ0Qmsrc3ZBY1cyMHRYNEZpTTIr?=
 =?utf-8?B?WERVL0NBQmMvTExjV0VuTWJlTkFtYVF2bHVVSC8wUlIvTjVKeUV5ZHk5L0Zp?=
 =?utf-8?B?WHJpUUVaSGs2MzdTVkZtN2RUWlVrYmZtOGRwdzY4azZZTE10SzJJZkFESFNF?=
 =?utf-8?B?U0ZlSGowaXZjd09xek5acDE0dmtadXU4M25wQVRQclJWcUdveGJpTVBoc0Z3?=
 =?utf-8?B?LzVzWjZ1UjMwRlNiaUhhbkwrN1plQmJvbEptc1BBK09XWGZBUHdTcDU1MHJQ?=
 =?utf-8?B?RVpqanlzY1RTVFo5RWl0SjBzcnZxa0tORFdCVlI0UDNMT2FjTGRaVitWYTE0?=
 =?utf-8?B?b24xcDBMVlhYd0RkK1Q3cndCV2NiWEp1aUdDVTlLWkNuTnJWMVQwTytLR0xS?=
 =?utf-8?B?K3hGTTJFK1BjaS96cWhwQzdHakdQdXJoYjMxWmZ5UkMwaGhFZVV6UW8vVXQ1?=
 =?utf-8?B?RGU5Q2hYZmQzVnFwUUFsa1BNTmc4SlNvK2ZKZ0FNL1MrYm00M3B2eXg3djVw?=
 =?utf-8?B?TzFFYlVpblp6TnZrdjBlaEJ6NGJIeFBxMVc3NGVLdE82SytyWlN6VGlOSU01?=
 =?utf-8?B?NkNONTJzMmtoU3ZKRzF4NnJpR0J5dU5oa3FMTmQrYmpuOXFkeTdJaWlyNlhO?=
 =?utf-8?B?NlpqQ3ZKZnB5TlFvR0JLblNLdGRQNWxvRXBkMlhsVS92L0g0eXNRL3hjOHRM?=
 =?utf-8?B?UExxcHBINVJJejJ1bGZqMi9ndkdKeVg1ZWxYcnhmNUwweUNUcnpjVWQ3NHpl?=
 =?utf-8?B?VmpmWEhUS0ViNHdwek84NXY2ZDFkb2hWVk9KYk1TeHBNelpQV3VPLzZaNUIy?=
 =?utf-8?B?WGpuZkxVTGtacDVWZ0x1cVpPb05CQUp3Vm40Ny9GWXJHeTRQV1BuUkkwR2hV?=
 =?utf-8?B?OU5ReWdMME1uUUdCRXlKbmlxTEtXOEEwK29sQXBGWW9Ja29rVnlseWZ4ZTNn?=
 =?utf-8?B?UzhVMHZKd3hiRFB5VDZZODNrcUNVaUVsZmVsZGo1cUhFSlBSVnlUd3dZckRF?=
 =?utf-8?B?Q09wSWs0cnU3Q1l3YnllWGt2ZVh2TXkzWmJPMUxnK2Y1M3hrVjU2Vi83eW5q?=
 =?utf-8?B?MGEyRDdQRkxWTWRqN0Fob2dzcWdpV0UrZTg3ZnRmbnl3Nk5QMEdWUUsyOEFy?=
 =?utf-8?B?RjY1aTc4bjJDRkdsWW5ZZGtPd0hLMm9BY3RPUTJVRUE0Y2E1K2U2ei9tTjNl?=
 =?utf-8?B?ck4vUlZJaGJyQ2NucE5XZnFyY1M0MG56N0UvYkFhVXE4czFldWdyZDZxNWN1?=
 =?utf-8?B?bnp4NmtSSWVnOUJEQ0VIUlBMQmcwRWRhR0QwcDJwRHZDU3krTXRPQzVBRHNQ?=
 =?utf-8?B?SG1IR2dwK3RsNW1YdmtnRVJNbXNlNWxXajVCV085cllzcC9WcityOFkydTlB?=
 =?utf-8?B?SkljbklvMnRjeFFpQy9FdWxUaGYrVmVRN2JzdVJ1bVVQajduUGptVGVZNk5l?=
 =?utf-8?B?TXNwZkhUYVNNb1YyVXljcUhwdHd2RytkUUtPa0Iva3NYV1ByaXFzWCtPbWdt?=
 =?utf-8?B?S1psOEtVVmo4WkQ3VEcyQ3o3bU1xdUJUUGtOVEdTME54RWNPSEhSQzlyV1Rm?=
 =?utf-8?B?MVBqREovK041bUJZMTJzZElpU1ZnbXZpa0dlYVBhQUpHcVFDcmI0QUliWkJW?=
 =?utf-8?B?Q2dBMVpkVTZDUXNaU3A1K3UvV3QwMHdZZzlrNXRnRzJyK1FDMGY0REhOalI3?=
 =?utf-8?B?M2JyVjBuL3FpV2JQQUxHR1hCTk9NaG02c1VEbjVySk1mTUVERHNUQkc2cS9s?=
 =?utf-8?B?N1Z6c2FRWFhjc3c2UWF1dkRvQWQ2SVR6UllNV1lOcXI2UHFSMlJ5b21zZTV2?=
 =?utf-8?B?ZG9SQ3ZPZk8rM2I0bHVoTWpnZmJhcHZFM0ZteU45ZUdhcUwyMksrOWlBOG45?=
 =?utf-8?B?TVRQNjFtL0VMQXR5Sjlsb1M2aXNjWTBkS1lUUUxvVi9WZ3pKOVd0R3pINEVv?=
 =?utf-8?B?NGh1cU03ME5nS3Vadk1neUhyRm41eHg4Wmg4czBacnNPL3E2Uy9US3oya1Yw?=
 =?utf-8?Q?HIT1Q+hKXRLCyAVj4gd6B4Lqx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4c8d4-f2f2-4a19-12eb-08dc6a20ddf4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 20:54:17.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMpjZws7EFnN9eHDxxY7RER7+i97GLxh/TKHM8iKhJVx6qUAZJQM7QuNbHi5Pku0VvCNEFm7kgXMD+3AcETHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 May 2024 20:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15789

On 01.05.24 14:00, Rakesh Kumar wrote:
> One of the changes is DEBIAN_PROVIDES, which is required to
> resolve the duplicate Provides problem in secure-boot-secrets
> to ensure that the build process completes successfully.
> 
> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
> ---
>  kas-cip.yml                                                   | 2 +-
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc  | 4 +---
>  .../swupdate-certificates/swupdate-certificates-key.inc       | 4 +---
>  .../swupdate-certificates/swupdate-certificates.inc           | 4 +---
>  4 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 2c3c8b0..1b97bd5 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
> +    commit: 36c711e4ed6d5ca3c8ab71ffb4a51e78615aa1f0

This requires also SOURCE_DATE_EPOCHE-related changes:

| FATAL ERROR: SOURCE_DATE_EPOCH and command line options can't be used at the same time to set timestamp(s)
NOTE: recipe cip-core-image-1.0-r0: task do_image_squashfs: Failed

I suspect we can simply drop the source_epoch block from kas-cip.yml 
now. Felix?

>      layers:
>        meta:
>  
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 2164b12..00b2a38 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -14,6 +14,7 @@ inherit dpkg-raw
>  DPKG_ARCH = "all"
>  DEBIAN_MULTI_ARCH = "foreign"
>  PROVIDES += "secure-boot-secrets"
> +DEBIAN_PROVIDES = "${PROVIDES}"

This statement is not equivalent to the original code - and it is 
broken. PROVIDES also contains the -native variants that make no sense 
to Debian, and the separator would also be wrong. I missed this while 
reviewing but you should have found it while testing. Which 
configurations did you actually test?

>  
>  SB_KEY ??= ""
>  SB_CERT ??= ""
> @@ -31,6 +32,3 @@ do_install() {
>      install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
>  }
>  
> -do_prepare_build:append() {
> -    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
> -}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 944c2dc..459e288 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
>  DPKG_ARCH = "all"
>  PROVIDES += "swupdate-certificates-key"
> +DEBIAN_PROVIDES = "${PROVIDES}"
>  
>  SWU_SIGN_KEY ??= ""
>  SWU_SIGN_SCRIPT ??= "sign-swu-cms"
> @@ -35,6 +36,3 @@ do_install() {
>      install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
>  }
>  
> -do_prepare_build:append() {
> -    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
> -}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index dec9a83..02f43e6 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -16,6 +16,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  DPKG_ARCH = "all"
>  DEBIAN_MULTI_ARCH = "foreign"
>  PROVIDES += "swupdate-certificates"
> +DEBIAN_PROVIDES = "${PROVIDES}"
>  
>  SWU_SIGN_CERT ??= ""
>  
> @@ -30,6 +31,3 @@ do_install() {
>      install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
>  }
>  
> -do_prepare_build:append() {
> -    echo "Provides: swupdate-certificates" >> ${S}/debian/control
> -}

Jan

-- 
Siemens AG, Technology
Linux Expert Center


