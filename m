Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E8ECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:28:43 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web11.50634.1725881313161515461
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=c3MCko3k;
 spf=pass (domain: siemens.com, ip: 40.107.21.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/lVbxaRgV1YkcdVOwh100pqk83xVrjFvrfEEHv4iwxUrXRoo7IYkinUcW9UL0o2Kz6XHJLHeIU/IODS3E0IjQySsh82j3KDQ58xswaNBHG97ICo2ck04IJwVNXMpRbtUCEiTLtVeGwS+bSucS9xVQusPKEnHeo2dqvHIdhGjZ5n+S1H2xsj4G8cI9gsvTSktZFahirg+RdxE5Lvr1VVcxIjggj7yKNRWFtaURlp7UplqETytTc/6l1Y/mVAUzNnvX+OU8mBgpuuBKhqhnbnCfu95M/fdlR5C65xIQqE+f7eFK4SPj5NSYSI1JUMeHbybAra5q4A31Uw5v7mCVfUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYBk7y4UK0vlLzG0x52ptLd6QKeRa3Mgzb4HczNe6mk=;
 b=jNp1VRWloylJ53FSVg9gSkmaoo1y/TFBPzFbtJ/xTC01zVuBxPVVC0hih0Swx3ESlhPmotUFt5XN+Cpw9MK+hV25sbwCTNWakIv8GOMxoLfyxhg3pVwyRZXngpYTnLeOBQScSt+BsUZijS5UApIXl7fvsLRlqu6D8GVl6KbnGym7INmeolmo5Qz3BqT3z83BSPKQYqRUjaqxq+0jF1QjRVqKIVUQ7N82WIZoGSAF+xjfZ9+EaIeS8v+1c31pyygzPDB5V41KS1PP1A5iEPWnP0DQE/t+QkyhUvKIDRUvtBF0AYiZPw91XPa4BmmlWlq1ZLnlf8yXGXBs1Px3w9qWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYBk7y4UK0vlLzG0x52ptLd6QKeRa3Mgzb4HczNe6mk=;
 b=c3MCko3kqLXyHTEtjD6NuVYMJ9LQ+OMkCsGG5k4ZhjtspfSTcylIHsluF3QfDUSj0MIb7uDagm1t4jWyKexmwrgGYl8X5PS8NsiP666R8vX6li2sVNSSWOIkyQMBeZqup8cOoPAyrg2zU/am+Md4Qm58RETLrqQvbUSyoBSjD6Nnzo6WlYD/jrwlTZJ/vbzFc6ZYUuyyhHNPj4qGQ9QgBD0/6dI3d/AkJRc+nVBm25KgzaXNGVyR0EPTmNj2wyQi6dhR5rN2tJVV5f3OxV/bKRwlRE4hW+L1KapEsMjpO6XOvrcIGQtx6jfS4kgk3PM/UbSPWpvymW9UE/z4bo7+Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6204.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 11:28:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:28:28 +0000
Message-ID: <b0a99189-e1f9-4c35-8985-48d59ad8fca0@siemens.com>
Date: Mon, 9 Sep 2024 13:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scripts/lib/wic/plugins/source: Use F-string instead
 of traditional .format() and modulo(%) methods
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <7d88ba27-c520-4636-963f-94feef36567f@siemens.com>
 <20240909111536.900805-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240909111536.900805-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:610:75::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: e35649af-e99b-434d-8d7e-08dcd0c286df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N2htTEVZR0xQaFcwK3Ayc3NjREI1Y0VBRUxJU04vRkVmaVdIODJMYkZ5N0FU?=
 =?utf-8?B?dlBvaFZ5VXZGTGdBOXQrRFNBYUtQN2VGc1J0enJrc3lva01iUG5tZ1U2dGVr?=
 =?utf-8?B?cWpoUHJ4UjZYMmtuUTA4Unl1dEVkWDFqMC8vSDQyZnJPMGJXU0pIR3NkUDR4?=
 =?utf-8?B?VUNqckcyOWNnOE9naFRBaHpWQ0FsdjlRZEtZNGsrb2ZBSWorWklBVnNPZFR3?=
 =?utf-8?B?aGszVm5xeS9iWnpzbmNLa0ZwS1VMY0hKcW5DT3Bacm45aWFZajVUck5Qc0RB?=
 =?utf-8?B?dXhYNlF2anZrSytJZ1VaN2dqaWpITGdieUFheVZ3UDZ1Yjl0ODJoTHdYZU8w?=
 =?utf-8?B?RFFBalEwaXdLSWRNV0tDVmdkNXp5L2QxOWFmNmt6L1RWT3pLWVI3aHpWOTFF?=
 =?utf-8?B?T3o4TkZqdmxBZGNiSENBSjJ5T0poZEFyWmtsNmNhTFYzRzg4a045a09uc0lP?=
 =?utf-8?B?NldkcEFiV0VWQk9Nb1JHQnRncExTS3pkZUxFVGZtZzFSUlJMME1oVkxheWRa?=
 =?utf-8?B?dEVwRkJuTVJiTEwzckVKdXJHeFZ6OUFNTFVmaEQxd0hKREZhV2pMTXF6ZnVY?=
 =?utf-8?B?RS9OOCtZdHlxZ3hNb3pxT2RtQ09iRk5FK3JXeGJlZCt6TlRpK20xZCt1Z2Vz?=
 =?utf-8?B?NWdYQ2pSNVB6dlIrSHVHd0cxVzBkRUZIRjVsaURJMkNncG45WEFFenhkYjVl?=
 =?utf-8?B?ODFoWXZTU2dJRytLYjBaWDFyVklKWXAxR3lITVVCTHZnemRhVXhyczBTdFhH?=
 =?utf-8?B?VHNSRlBiYnRtRFFEdDZuajFSNVFkemN4RWhIYUw2Q0t0bGFvTTZIVEowNG1W?=
 =?utf-8?B?ZFp1OHR6Zjdwd2gyTUtNSXZ3V2lmTTIxRllrQVlZdDF4VzJZWFhPZ3VrdHFZ?=
 =?utf-8?B?UXMyWk8zVk42cE1XZURYZm9JdjRuSCtiREF6TVVqeEVwOGdXY043bTEvM2tn?=
 =?utf-8?B?Q0laWGpCR1FMVU92cCs2ZXZvUGpPalg0d1JwOHNzVXh1Qm9BWlQ4WTBRZHVo?=
 =?utf-8?B?a2c2RkpQazZpVGI5cTJWUVFZQnI1cTQwdTZKQm5hY3ljaitzd2psUjJyeHla?=
 =?utf-8?B?RHBaYjgrMXZoc0o3dmdLK2ZCdXloYlVhUDY1VitNSUo2eXVvSWprVklHcEx6?=
 =?utf-8?B?Q05kblZoV1NxaU5reFRITUhveWhudUhxc09WcW9LSVN2SGJINUlnMlh2ajMr?=
 =?utf-8?B?dU5ZbmFrOEFnN3JvZ2lEeHlVWnR1NW04UXl0cG8zZ0NNVmZtM29hendBZ2xy?=
 =?utf-8?B?Z2NIcHNtb2phY2JKV001WnVnUlgzbWRoaE1Wa1p4UDFYVHIzalFJOWxwY2p3?=
 =?utf-8?B?anRmSVo5K0tOS2w5ZDMvMlpFWEE0QmhyUEhCNEJySW1PbzcrUTdDaUR3ZjR5?=
 =?utf-8?B?ek1qL3ZaNjNCN1RoM3llRGc4U29wL0FITGR4UytEQmw2YTFrQzc2RWM1dDRk?=
 =?utf-8?B?NXRWeFFQWnZpb1Z2Zlc5Y1BUVndwRTRodHJ6Ny9paE9LM2FvR1ZuYmF0NUpM?=
 =?utf-8?B?d0UxOURMZi9OTFk2Q0FJendFbENqM0xhVVZCVEhwRDRmT01zQVQ5bWQybFBU?=
 =?utf-8?B?cEsxQlNGREdZc1Jiemx0NWdFUzE2OTNnRDJRRnQvalQzQVlXUkRxUmN4SzA3?=
 =?utf-8?B?bDBuU3R1ajQ0UXF4cVB0UXo3U3kxOU9aVW83Q1R0bVJBakdmd2huWXErVVZ0?=
 =?utf-8?B?d0dtbXNtdkhhL2pMcUtHczl6eVIwL29DRFZWdTk1YWduUWl1Y1JXQ1FmN1hm?=
 =?utf-8?B?L0tuWUxyMUJvZklRWFl0RzA3QjZjQXVHWlI0d0l1a1dseDZnK3RFQ0JqTGtB?=
 =?utf-8?B?SzBtR3c4R1RudGh1NEUxZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXIwVUMyYWFLaWUrdlJicXpEcUEyak9LQnN5dzR1UUJyNmtOZEdWWmhINjBS?=
 =?utf-8?B?aTc0MnB6ZkJqK3RqTUtxTi8rTTg0T3k3YnFOMEpIdS9TVHlBWHNmMnVuKzla?=
 =?utf-8?B?aHNscXVhSjlHNjRTa012OU5VWFFmWnJHVUs2RUxzMHhoSTNxbzAzeXBCNG9W?=
 =?utf-8?B?c1B1amdwRHhWK0xJSjIvOFp3OE9ZelU2T0FLSGxlWkdIRkI3MlhpaXFtZ2ov?=
 =?utf-8?B?ZDk2aWJvOEthM0hoY2s4V3dzSTZsS3lrVTdYMDR3dGMxa2pDdlJxOSs5SEFu?=
 =?utf-8?B?NnZST2lGLzRGcXdXa3c1Z1VOQWVxdVo1Zi96RTgwL0NKcmthdTBhWXJNbERl?=
 =?utf-8?B?TFdvTHdESEZHZXVaQ3d6WDRjYjNiL08wK1RqNXJWWXJuQ2F2SWZ1OStMSWs1?=
 =?utf-8?B?MHhxVk0wNXFIdjdSRDI0OXVHSXJjM3BMdUwxSDFrYy9McEJsME9hbEQ1dGVx?=
 =?utf-8?B?MW5LR01rbGhlUUpIeGQ5SmE1N0tpQVVVK3Erb3ErUHp1WTRhSFBSZUpOenRT?=
 =?utf-8?B?UnJQOGdSekJ0NFBwTUpvUTBUSU8wSnhSLy9pb1lxOEtPTEhiL2NCanBFekI2?=
 =?utf-8?B?cXFabS9HRVJkMWl6SGZXS25VUzBtTFdQcnhFR2ZFa3BCV0ZBbDNWZmkySjBu?=
 =?utf-8?B?SDhUMVM5dG5DU2E4V3hsbXVxc2JXb2FscUhhUmY4cWI5RDNWcUNIaWVtRlh2?=
 =?utf-8?B?TTgweFh4TTJsVDBPM3AwekJPak5jUHBJWWFkVUoybmp2akVjdEo3QTFoOUtC?=
 =?utf-8?B?RjFkR1FlQnZWZHEvK2k4SjRyZmdxN3puSW1qTXZ6REZMV0JyK0VjeC9EL1F3?=
 =?utf-8?B?emlmZWNiUWdWVENja2FEMllSZzhRSFhEUFdLQ0NmY3B0OFZlRXFJZ3I1ZGk1?=
 =?utf-8?B?V2svcXdyN0taS0l3Nk9UMXFTUExMRXpuY3ZVR1FpcUhMYmxMSkF4S3FQS05q?=
 =?utf-8?B?YUJWMGFKTkdVTFRmRjZYOUN5cHlYQmc4eTJJL2xiS082YytZYnJ3Y2szY2RZ?=
 =?utf-8?B?SG1lYTU5bzJ3bExMVUNrZlhwdFJaZ1FHU1ozbnVXV3poZXozK0ZNdFFuRUEy?=
 =?utf-8?B?SVRKOHB3ek4rdTFNTTJQQURiOTNPNGpBZ2ord0tidDRSc0xmZExLd1gxSXg5?=
 =?utf-8?B?S3l3VUJ0b1Y5VlN6UkdCZ2M3ZHIzREVPREI4NXlEUzNkYWRvUC90VFIvZEd5?=
 =?utf-8?B?bW9Zbm1FbXZjVjY3TFBUeVo0ejQzbm9tWWk5aVJRTGZxM282NnJyaUIxU1Rq?=
 =?utf-8?B?L0NtUDU5OUtRUFdlQVlEbnNaOThxRFVXSlF1WUpOanJxOXROb2JINHV4NWt2?=
 =?utf-8?B?MVRtVVFLTjRkM2Q0bjJuOFkyZUdHYmRzeFBoZjRlcDNiSlBGMWdhcjNUdmI2?=
 =?utf-8?B?N3pka2RmZTR5MEtWL0pGVmdWYWNHTlhTRzI3dmIzWlJwWGlrS3ROMmJsd1RY?=
 =?utf-8?B?M1pGeG5pWVZNV1Y5RUtyNkNDTzRFYkxSZ0tRdnZiM3ZaN1lCRXVsS2ZLbnkz?=
 =?utf-8?B?bnVYdXhDV29VQkZ5V0daRXBJSytaV2NYT1YwL3kzNFdNUnJOWUN2VzVBR0Q1?=
 =?utf-8?B?SDFwcTJlbENGelVuSUdLVWpSSXhEbHJqVEJRRXVLM3NnN1Q3K0RtckR4TWx3?=
 =?utf-8?B?cXpGbHlPSVZyTDhxKzkzRUhvQVh5NWl6eDNUVHh6SmQvdlFvby92elNPSVRS?=
 =?utf-8?B?UDNQVG80dmVuNDBaYnVTbW9EQkQwdDEzWXNhUzQ5ajlraTh5Y3JRS2MyRlNx?=
 =?utf-8?B?U2QrSm8xaksvNkx6NXgybUdzbnArdTY3VE9YeGxGWEl3bUV6MHpISXlWRFpE?=
 =?utf-8?B?Ly9qQUg5dTRjOTFHSHpQSmw3MUFhVGEvWjZjUjN2aDA1bnZVV0lGcDRYRVpl?=
 =?utf-8?B?SkpYWGtPNk01c1FjZkhpUno4ZFBrYkFuR3JuVEpnc2VtK0dnQ0FzNnczMjRz?=
 =?utf-8?B?S3gveEU0TGhHcVBETHdMdEtWRXJNcndNUVdmQStwS3VHSmdqbjZJOVBPMUZI?=
 =?utf-8?B?NE5zclNZTkE3aHBKeS92QlMvQzhIVXplRWZrTm1xVnpPUDB3TEF3b042QStl?=
 =?utf-8?B?NGxHMFNNWjJQUjhLaCtJMDJRdnBZM2ZPcitQRk5uYmM4bTZrK2NsanhsUVFx?=
 =?utf-8?B?MWw2Yy9FanBPRzBGOUpOOUpzQ0lLazNOenRyZVFvSUdpaWdXakwvRzBKZGpn?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35649af-e99b-434d-8d7e-08dcd0c286df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:28:28.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOEPBPf/SZ1BW/2UfqYIeulA4t9+otE3VLNoPP7U4/6V7dnGT/vRt/iyrBQTJrgUUYumkRF+bsZ1BSYxZVri0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6204
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:28:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16871

On 09.09.24 13:15, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> Use f string for string interpolation and formatting instead of traditional .format() and modulo (%)
> method.
> 
> f-strings are generally preferred due to their readability,simplicity and efficiency,
> and moreover there is no functional changes apart from the optimization.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  .../wic/plugins/source/efibootguard-boot.py   | 73 ++++++++-----------
>  .../wic/plugins/source/efibootguard-efi.py    | 37 +++-------
>  2 files changed, 40 insertions(+), 70 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..5292037 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -103,34 +103,32 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  exit(1)
>              root_dev = root_dev.replace(":", "=")
>  
> -            cmdline += " root=%s rw " % root_dev
> +            cmdline += f' root={root_dev} rw'
>              boot_files.append(kernel_image)
>              boot_files.append(initrd_image)
> -            cmdline += "initrd=%s" % initrd_image if initrd_image else ""
> +            cmdline += f'initrd={initrd_image}' if initrd_image else ""
>  
> -        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
> -                                             part.label, part.lineno)
> -        create_dir_cmd = "install -d %s" % part_rootfs_dir
> +        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
> +        create_dir_cmd = f'install -d {part_rootfs_dir}'
>          exec_cmd(create_dir_cmd)
>  
>          cwd = os.getcwd()
>          os.chdir(part_rootfs_dir)
> -        config_cmd = '/usr/bin/bg_setenv -f . -k "C:%s:%s" %s -r %s -w %s' \
> -            % (
> -                part.label.upper(),
> -                boot_image,
> -                '-a "%s"' % cmdline if unified_kernel != 'y' else '',
> -                source_params.get("revision", 1),
> -                wdog_timeout
> -            )
> +        cmdline = f'-a "{cmdline}"' if unified_kernel != 'y' else ''

Better not reuse "cmdline" here as variable name. It's confusing at
best, even if it may work. "cmdline_opt" or so.

> +        config_cmd = ('/usr/bin/bg_setenv -f . -k '
> +	              f'"C:{part.label.upper()}:{boot_image}" '
> +	              f'{cmdline} '
> +	              f'-r {source_params.get("revision", 1)} '
> +	              f'-w {wdog_timeout}')
>          exec_cmd(config_cmd, True)
>          os.chdir(cwd)
>  
>          boot_files = list(filter(None, boot_files))
>          for boot_file in boot_files:
> -            if os.path.isfile("%s/%s" % (kernel_dir, kernel_image)):
> -                install_cmd = "install -m 0644 %s/%s %s/%s" % \
> -                    (kernel_dir, boot_file, part_rootfs_dir, boot_file)
> +            if os.path.isfile(f'{kernel_dir}/{kernel_image}'):
> +                install_cmd = ('install -m 0644 '
> +			       f'{kernel_dir}/{boot_file} '
> +			       f'{part_rootfs_dir}/{boot_file}')
>                  exec_cmd(install_cmd)
>              else:
>                  msger.error("file %s not found in directory %s",
> @@ -143,14 +141,13 @@ class EfibootguardBootPlugin(SourcePlugin):
>      def _create_img(cls, part_rootfs_dir, part, cr_workdir,
>                      native_sysroot, oe_builddir):
>          # Write label as utf-16le to EFILABEL file
> -        with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
> +        with open(f'{part_rootfs_dir}/EFILABEL', 'wb') as filedescriptor:
>              filedescriptor.write(part.label.upper().encode("utf-16le"))
> -
> -        bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> +        bootimg = f'{cr_workdir}/{part.label}.{part.lineno}.img'
>  
>          part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)
> -        du_cmd = "du -Lbks %s" % bootimg
> +        du_cmd = f'du -Lbks {bootimg}'
>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>  
>          part.size = bootimg_size
> @@ -170,29 +167,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>              msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
>              exit(1)
>  
> -        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
> -            .format(rootfs_path=rootfs_path,
> -                    libpath=libarch,
> -                    efiarch=efiarch)
> +        efistub = f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kernel-stub{efiarch}.efi'
>          uefi_kernel_name = "linux.efi"
> -        uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
> -            .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
> -        kernel = "{deploy_dir}/{kernel_image}"\
> -            .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
> -        initrd = "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
> -        cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
> -            -c "{cmdline}" -i {initrd}'.format(
> -                cmdline=cmdline,
> -                kernel=kernel,
> -                initrd=initrd,
> -                efistub=efistub,
> -                uefi_kernel_file=uefi_kernel_file)
> +        uefi_kernel_file = f'{deploy_dir}/{uefi_kernel_name}'
> +        kernel = f'{deploy_dir}/{kernel_image}'
> +        initrd = f'{deploy_dir}/{initrd_image}'
> +        cmd = ('bg_gen_unified_kernel '
> +	       f'{efistub} '
> +	       f'{kernel} '
> +	       f'{uefi_kernel_file} '
> +	       f'-c "{cmdline}" '
> +	       f'-i {initrd}')
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> -                    deploy_dir=deploy_dir,
> -                    dtb_file=os.path.basename(dtb))
> +                dtb_file=os.path.basename(dtb)

style: var = value

> +                cmd += f' -d {deploy_dir}/{dtb_files}'

Subtle regression, good that I manually reviewed once more:
dtb_file, not dtb_files.

>          exec_cmd(cmd, as_shell=True)
>  
>          cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
> @@ -206,9 +195,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>              msger.info("sign with script %s", sign_script)
>              orig_signee = signee + ".unsigned"
>              os.rename(signee, orig_signee)
> -            sign_cmd = "{sign_script} {orig_signee} {signee}"\
> -                .format(sign_script=sign_script, orig_signee=orig_signee,
> -                        signee=signee)
> +            sign_cmd = f'{sign_script} {orig_signee} {signee}'
>              exec_cmd(sign_cmd)
>          elif sign_script and not os.path.exists(sign_script):
>              msger.error("Could not find script %s", sign_script)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..5d65ffc 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -73,38 +73,28 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          creator.deploy_dir = deploy_dir
>  
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
> -                        libpath=libarch,
> -                        efiarch=efiarch)
> -        part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
> -                                             part.label,
> -                                             part.lineno)
> -        create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
> +        bootloader = f'/usr/lib/{libarch}/efibootguard/efibootguard{efiarch}.efi'
> +        part_rootfs_dir = f'{cr_workdir}/disk/{part.label}.{part.lineno}'
> +        create_dir_cmd = f'install -d {part_rootfs_dir}/EFI/BOOT'
>          exec_cmd(create_dir_cmd)
>  
> -        name = "boot{}.efi".format(efiarch)
> +        name = f'boot{efiarch}.efi'
>  
>          signed_bootloader = cls._sign_file(name,
>                                             bootloader,
>                                             cr_workdir,
>                                             source_params)
> -        cp_cmd = "cp %s/%s %s/EFI/BOOT/%s" % (cr_workdir,
> -                                              signed_bootloader,
> -                                              part_rootfs_dir,
> -                                              name)
> +        cp_cmd = f'cp {cr_workdir}/{signed_bootloader} {part_rootfs_dir}/EFI/BOOT/{name}'
>          exec_cmd(cp_cmd, True)
>  
> -        cp_to_deploy_cmd = "cp %s/%s %s/%s" % (cr_workdir,
> -                                               signed_bootloader,
> -                                               deploy_dir,
> -                                               name)
> +        cp_to_deploy_cmd = f'cp {cr_workdir}/{signed_bootloader} {deploy_dir}/{name}'
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> -        efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
> +        efi_part_image = f'{cr_workdir}/{part.label}.{part.lineno}.img'
>          part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)
>  
> -        du_cmd = "du -Lbks %s" % efi_part_image
> +        du_cmd = f'du -Lbks {efi_part_image}'
>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
>  
>          part.size = efi_part_image_size
> @@ -116,11 +106,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          sign_script = source_params.get("signwith")
>          if sign_script and os.path.exists(sign_script):
>              work_name = name.replace(".efi", ".signed.efi")
> -            sign_cmd = "{sign_script} {signee} \
> -            {cr_workdir}/{work_name}".format(sign_script=sign_script,
> -                                             signee=signee,
> -                                             cr_workdir=cr_workdir,
> -                                             work_name=work_name)
> +            sign_cmd = f'{sign_script} {signee} {cr_workdir}/{work_name}'
>              exec_cmd(sign_cmd)
>          elif sign_script and not os.path.exists(sign_script):
>              msger.error("Could not find script %s", sign_script)
> @@ -128,9 +114,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          else:
>              # if we do nothing copy the signee to the work directory
>              work_name = name
> -            cp_cmd = "cp {signee} {cr_workdir}/{work_name}".format(
> -                signee=signee,
> -                cr_workdir=cr_workdir,
> -                work_name=work_name)
> +            cp_cmd = f'cp {signee} {cr_workdir}/{work_name}'
>              exec_cmd(cp_cmd)
>          return work_name

Please also test once more to ensure that we really covered the corner
cases well. E.g., use a downstream layer to broaden the test coverage.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


