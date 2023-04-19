Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EEC77B73
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 12:20:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web10.35945.1681906848037289349
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 05:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LEBuPTBq;
 spf=pass (domain: siemens.com, ip: 40.107.22.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV4449+RrbVT2mWXkMogo2osWERikcP0FEG0z0hSUlcW2DHv7mI5Q0h1exNMNyobaOChdgMKT0PCTeOvvSWo6j2MYqX3GgT2wpe8CrFhsjWd+21TVrcEFHO+5F2Ve0bXvN2AIImaTllM3x7JUZzsAbd/KSfQ7M33rGZREVY+KO08EGpW2J+6YkYrt/I3lqbYqeh7oIW1l2Rxta/ucEbbZfYLBYHUo6ldfVPRe9BmXeoo0dLZl0HK426OVcw1Sb+m2K/HnVxG+qAxS3iIAn2fnN8T39AhSOu/oX49ZfjLSaGBAhiRcXZ2puJbwAY9C3Ab4vCDG5dMvY2HxG7nSkZvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnLbjJXLj/cBcap/cq1CAhndpN3EcUkkO1f9VNL8jGw=;
 b=INN+ply9JHWSifOWBVKvccHiG3HNWXPK3nvLIC0uV6tJ+flZ1bR3wVdTutUuxMKyFtxq4zRXKcF62DVVOOCp3gQjMhe9tzgovJoPjxA2tJsl09UKmD7upo6l89w7Yl9cjHgxNqJzez9Rsj/SoIhhhmUFn0NGg618jSFvUjTeWnZs6fm0waGRYJWv/C+9weZ3kfU9yfkpUiQVVD6wpv7zdVd5xG/ygEasivOg+4608o3q/E8TyBUUVytx7EngTMI86ysa4Qpu2DqZMQKzZUut/qEjV5CDSh6K7+R5BfLwgOmkIeLqAxCXELyvKG6epFBkCpMf+kYAcDbY0K1/yO1DNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnLbjJXLj/cBcap/cq1CAhndpN3EcUkkO1f9VNL8jGw=;
 b=LEBuPTBqiH+UNONzX8oZANZSH66vOAx3kUTtoUufp72d0JnVG1WvHzfwp6Al70beXk7PL/tpeKZEvXchhZaedCq/rY8Qa80HizgJgXpmveU6uaL0PLIEL5wTP8cnml8YmzBDubYR+u+uLsSqr11JiFQuHC/dYhZMego55CS7R6imEontFnseEIb7d+Lxc1U8bUr4FD6hmfLyHC7r50EBjoyRUA7oYtUd4YmJqVmSF98oI8jy/qU9v5VzpLw2T1ACqknuym3JsYDQRGWZdBGloXt2nyKI1NizuPm72hhUVJJRzs9HJIE5Vt2uOntFTMcyOu+k6+sF2B9LLXPenIV3/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 12:20:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 12:20:45 +0000
Message-ID: <a8b641c2-c664-9230-ac9d-dcf64a7f936d@siemens.com>
Date: Wed, 19 Apr 2023 14:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE
 instead IMAGE_INITRD
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: b252c9c0-9265-46a0-1dc0-08db40d0802e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r6bmO1PaFN0czPgPwjNIGYNNv3sDbwuxPK8jXzRLVS2CXA0oqA6FiMADUfTj+v8kxv5S6zhSoxqDayMVRs0A0NxMKRiofXyciF6sk2hNN0wwK5zIusUdCq9WAtlGPDexj85Xa82A9sfQqhDcthxwQ6JT17Yo3gr0kxnr1WzzAPpAuZKhM3qJi3xysIl74aM4wHV0CfkkPAuFDVNHQzR+1f0PMknr0fehJDhwqYeE7eyKi1AxJk/scawcqX2KMyjSqE+eTlWyPAgy8PWUb8zj1uvFmDk0BI3Q+yKwPToUwEgKLr1fhlChsQ2fVnGYH7N5nSsJgepxa0wvmPF57kvitj3YwZB9SP4BTRSsohwMaFuoG7wz6bRgRNfqYdP6W3MKSHvGdl1GAG6OPs4AcE/2OQ8tvCu+At4rIxLe7P/thNNAE2G6hMtbEza117hxlRyJbdy4kkb79BDP4IWc39Fg48JK/CKWbu6+my4CmpLbX9ZQwxI0UQIoZK1TrDCt7UMbhnL8mB3G3YxqNSl3isBQ7M2EH4y2EF3D/qN7UBC9/SAdbbAe4a17+alBEfdcfc7G/sTOeALqtmDlJ5or0QVy3J560ell4GrJcuQfMZixMr22MqgAV36jY7w34l5nOX5CikWH7Oh4aIf3lsVt7nnYpveFaGLwWH1LXIOTOj/qQJY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(5660300002)(31696002)(478600001)(316002)(41300700001)(8936002)(66946007)(82960400001)(66556008)(66476007)(8676002)(38100700002)(53546011)(26005)(6512007)(6506007)(2906002)(186003)(44832011)(31686004)(36756003)(83380400001)(2616005)(86362001)(6666004)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OS8zRU9QSnYweFhvQzRnd0huZ1RQRHZFc2tJTUxwMWlBQmhLdFMxRVI1eGhn?=
 =?utf-8?B?RldCVi81Y28yN3JiM1EyMmJxOW85MlJZcCs4QnlEUUdsNmdTOWJUbEo5TWdC?=
 =?utf-8?B?SUxNNHVhUEp3c2E2S2RFUFZTRmdmdEZkUG4rUWRqR2xiVVNlaUNzODRybEVv?=
 =?utf-8?B?ZVM4MU1zbDhGWUVNSXE5bGRES2JvVTdPVmtiZTAzSHlpd2lXbThpaVlaT09I?=
 =?utf-8?B?djRJb0o2ejEvNWkxZTY0STRxS3VnR0Y3SXMweXNzenMzNnhCN1VMWWc4eWJI?=
 =?utf-8?B?Wmx2b054ajFMcHE3Z3hYbEhJZXJkWllKRUl1bkQ3N1JsbUo4QlNzTEp5R0N4?=
 =?utf-8?B?RDZlV0laY1YxL1NPRXpaNVR4K3ZVZ21vbFhFRDlmajdadUVQVnZWcFVPb21r?=
 =?utf-8?B?blAwd09NT1JZa01VZGc1cmRHamdIcjNvTUx4ZnJQVUZUMzkyTy9HYmN1UXgv?=
 =?utf-8?B?d3k0V2hzR3F3MDNyazNCTjB0UTUyUGlNSnNJNDZSTTZyMFpUY2NXb1U3ZEFV?=
 =?utf-8?B?bytBNGJOdDNHOUY2WTFqTWk5OWFXYUtlMXZpejc3ODQ0eFZGWVZwaVVNRzFH?=
 =?utf-8?B?Z21nWnBuY2ljc3lPRXg1eFE5dVFFNzRKMFpLb1ZLQmcxd05nUU9tY1pqdmFF?=
 =?utf-8?B?cngrQnV4b2ZOR2FsLzZxMEwrREFqazdlb2pTR0E0R2tHTnhydzcrYkEyb1Va?=
 =?utf-8?B?ZnRRUkpJdnpZUFJwQVB3RDVRUGZhUlRlcjRwMDhieC9ST2NJdWp1cEZGcWtT?=
 =?utf-8?B?cnZiVXpTUy9jVm5nQUkwYXBsWjJCL2dHTm1wVlZDSmsrQTFEbE0xOG1jbmJx?=
 =?utf-8?B?TFJHUFpBazlQcWpWaUVENk9RRXpkeGF5YXlzSUtiUDN0RWlMWVp1VDdsQy9W?=
 =?utf-8?B?dkZLMEtST3h6MXZLcUxlaFp5TzdmSFJ2ckZLb01yOGpMWHI0eFhTSVZ3RFNB?=
 =?utf-8?B?NGJNb3F5bUtkQ2pPN0N5SkF6RTJPbXZkZFhkQ1BGdERjZWNYTE1EWVgwZnB1?=
 =?utf-8?B?WXU1cS9jaWIySzNKTmZtRVRTY2N5ayt3Mk40bXA5d3EzZHJ3UWdqY0pzNjhH?=
 =?utf-8?B?V095bXcwNmNtd1FPMjBRS2ZsTHg1cGVVdzVIQjdMT1JLTGFZL0d2RDlMQlZW?=
 =?utf-8?B?UG5SeHpUSEd2cDNadzJmSXJFa216ZVk0MXhmZmpQN05HL25zRUZIN0JDd1Vi?=
 =?utf-8?B?cGZvWXhuS3N4OGNIYi9UcEJSRkdtTENkL1d3S0w4YkMzQ0R3dG1QVjRZUGN4?=
 =?utf-8?B?NldNZlI2YUhsd3FBQVVkYkwvNTVlb0hKR2NxUnBJUUZpeFdMQ1RpL28zNmth?=
 =?utf-8?B?enRsS0lyNk1UYmR5cWtFcFYzeW9tRlpzbWhxMkl4Sm5IRnBDVDZxMHQwYk01?=
 =?utf-8?B?cXcyUWIwTFJCbUhxL2xmSWVtT3R0R2U5UGJQd0xPdTVtZ3RSKzBubDBUV3VQ?=
 =?utf-8?B?ZWtiTnROVW9RdDh4SDJWc2JWUDFuYlp5M2ppQWRLOVFvWTR2M2E5SHV4YmJz?=
 =?utf-8?B?VDU0eTQyUWVwTXFPZjNETFBZYTBjQWVGcFg0RUNMbFREaXFabVFXKzdFZ2V0?=
 =?utf-8?B?cVBKUzdGNlNNL1BoN0ZuWkt1Nnkra3Z3WmRQc2J4MGgzb040Z3dTSUZTU25v?=
 =?utf-8?B?dlordmR6RnB2UnZXNzl4Ky9nYlBUdGlIN21Gcms5VlhaV0JoMGRxYTRiMVpW?=
 =?utf-8?B?Q0FqeFdRUnlBcjdsVUFvQlNLRTN1ZjlxY01HRkFPSWlrbjR1ZUxlbE9mTEdh?=
 =?utf-8?B?N3NEWGgxRTFVRk1qdGlyd1I2ZzM2b0hhWSs4S28xbkhPcXpYaDRwdm1aYTRa?=
 =?utf-8?B?YUVOWG55L1ZpVnJvZS8xTXU2MWR2Q1NOU2QwdXQwdEx3NlFnTlhYZit4cUtG?=
 =?utf-8?B?cHl0UVlvVDNBb3RTbVloMGZnUjI3M3hHMERKMmV4bzhnWHd1RGJvSVdyRTJ1?=
 =?utf-8?B?L2NSUUttVENxRy9MakJmamtoRFhuNWxWY0ZsM09CNDg4R1l3Nk5nZ1MvSHZB?=
 =?utf-8?B?SHBJNTQ4bGNXKzZkZGFNMTIydHdWRExpTnM2MUJuaFJ5cnRueUt0K1BYOGZJ?=
 =?utf-8?B?ak9RUEtqczMxR2pJQXJYU01RaFJZZnllRkVnai9NTzdvQzQvUkpQV2pNWGNz?=
 =?utf-8?Q?cGTy8bGaivl6ziJjp79S3sFcm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b252c9c0-9265-46a0-1dc0-08db40d0802e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:20:45.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCKBA6hmk+73g3tybYWa3+Cqp0QmeHpw2ff/HpdrKHGNz88k7AHm8lhAoQLESbJe+cDdRIx6cuwNg1htoEoygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7886
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 12:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11231

On 19.04.23 12:29, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With commit https://github.com/ilbers/isar/commit/f0608683fd18f96319332f2ea3827536bd2fd761 the variable
> INITRD_DEPLOY_FILE should be used for creating the wic image,  see [1].
> 
> [1]: https://github.com/ilbers/isar/blob/master/RECIPE-API-CHANGELOG.md#working-with-a-custom-initramfs
> 

What's the impact of not doing this so far?

Ja

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/efibootguard.inc                | 2 +-
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index cdf5558..1de452a 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -12,5 +12,5 @@
>  IMAGE_INSTALL:append = " efibootguard"
>  WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
> -WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
>  IMAGE_FSTYPES += "wic"
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 0de28ca..7435b22 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -60,9 +60,9 @@ class EfibootguardBootPlugin(SourcePlugin):
>              kernel_image = "vmlinuz"
>          boot_image = kernel_image
>  
> -        initrd_image = get_bitbake_var("INITRD_IMAGE")
> +        initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
>          if not initrd_image:
> -            msger.warning("INITRD_IMAGE not set\n")
> +            msger.warning("INITRD_DEPLOY_FILE not set\n")
>              initrd_image = "initrd.img"
>          bootloader = creator.ks.bootloader
>  

-- 
Siemens AG, Technology
Competence Center Embedded Linux


