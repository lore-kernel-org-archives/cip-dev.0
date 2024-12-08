Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A4E77173
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 17:30:47 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web11.82466.1733679040407827582
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 09:30:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t1alrr64;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHY7lGUral0a7Pfxu31LHlRQCBy1c40jg+idI+Jn+EkRvcLWiXZ9L7ys7LiO9qiNq1KRAUdyO8VCOoApHtkhBGP3yfyyu/e38Vz5ggpyRUl0zBlkVJJ1HaT9F8CWWePk1P15JCMceHElLNwVarA8I8pSU0FZXlBP/450X20ipvlT65RkyFDNDYX7guPeKYQbEiCLJfpgCsR9mRFN75HYLXPks+f7d8P5XlxIZUqUDXqe1rsUj0ZqVuIPtiAbGvxWNloa4eBIWKBeNRU5SWDJ33QZ5SURUpvhv4LcNWcpSAeqWOQ6yUr3MhoHbIsAVvn13vwIxUC7goqVGGGaYjimyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS3g36VELAgqb4/FFhWHsGr0MwTIAg1BelH3UsCIqZY=;
 b=CpuSLIfNuGnkz3IyfuQHzx81Z9y0sxYduZ8IKzaxpUXsXEZlyFn5ni1/pQpHBYjzub4bq7siJh+A3Err124oHiN+acqzd7wEeY4yBAq5ooxcAtz1zJXX0tUZnVF+T2rJvx3MPz1UdfplG0Y0A7Luarb3iEfVaAQsu3Okczu9/tWMfSk+ncPK2fp8AMPA3iGhXiCl2BVhfP80c5GpkZ9/HYNBce5LVYn2Wx+Ifj4I5DTYYBifGzqcY6zKiJkM5sBJylxWYX8E+PyakvdOIr3Vj6nCnI629bBhurLCe7z1cwE4cooh3tSeWIL0GTF97t0JtGFG+irulYbEFPhqXs5SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS3g36VELAgqb4/FFhWHsGr0MwTIAg1BelH3UsCIqZY=;
 b=t1alrr64mFQ+oRO3NlPf2q51WXcEEJgH6aybJL8Vo5MaHV8/PvWIw+TCowkRbreHFzeDZCEJOqr9Gs6MzCMKJdp9qSFGmAutYwyXKn35cxpBl56NYo79sOo1JRTixCOQV10f8icRmt8oSX4Uk/PK3CbOwhI4RwlwKqJfCruJJW2XiP/puI9EXQ2bDLz6LTldY+C8In3jZccQKlMCdhs3VJG6eJO3tnC1i74xoNFNta3J9tVrNg9aTuDXFVq4g5Y5hO/yxkCX6oMEvfDrax05rTIhGBzd962ozd26XuH9e1O52FO+ad7cwg+gD2idRZ7pswXhKzjXe+a4MmtBZ+J49A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Sun, 8 Dec
 2024 17:30:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Sun, 8 Dec 2024
 17:30:35 +0000
Message-ID: <5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com>
Date: Sun, 8 Dec 2024 18:30:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv:
 Switch to cip_merged_defconfig
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
 <20241126151751.1747275-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241126151751.1747275-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 387837fc-7862-467f-6d16-08dd17ae064f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q1hDTHFJbVJncnZwQUtJSjVxNXNhdGN1UUNWYk9iZEJLWUpKUjlHUmt6SzNR?=
 =?utf-8?B?SWE0V1BpTG1MeW1pZm5aOUdZcVBSeUZQWlI1Nnc1SWtYKzZSTFNGbC9CdkRH?=
 =?utf-8?B?QkJzOUJMYmhnNmQzOHNuMDdzZE9NeERMOFN3Y2hWUnF4Vmc4dDZISWpQOFBx?=
 =?utf-8?B?VkZMYjljNWVJNGp1Njh2QWtSUXBUbDFjcy9yQi9BaWh4M2VHWkNnMzRBT01a?=
 =?utf-8?B?N1JtbG5pUFR1a3JBVmk1bjl5WnQ0ZUY5cVRScDdnVG81Z1E4ZFpLK0VXcjRZ?=
 =?utf-8?B?Qm1NdHUzZUlnRU5qZW5OaXZ5UElxSWtNM3NJVkNjNjkrTmc4MWVpZWY0a2Rt?=
 =?utf-8?B?eUV0NjBXcldlbFIvQk45UXFDdnJzaFhQOXB6TUVmUnB3bURjVnVMN2x5TEdY?=
 =?utf-8?B?Q0hoYXB2VzRmczBiTW1DMjNvTFN0S0l6S1grZm5JNDBjeGk0RkdNaFo3RTIr?=
 =?utf-8?B?NXBldDhkVlE3Qis0Q0JlQlMxV0tVSUU0RUt3Vmd2ZmFJemtVTkZDejMrTVBa?=
 =?utf-8?B?ZHM0dzJrREdPY0tFYmFhQkZ3NXZ3aWh3QlRsOTdvcTFIMm1qQUhEVXMyd3pu?=
 =?utf-8?B?eDNFQzdKTUxDVzFUbWlweTQ1TkVNS3FPdHlHMS9jZTF1dTVFRHR4c3ZmMkhy?=
 =?utf-8?B?ajI0bjVaZFdoc2VpMWZ5b2xJRzFBSy94R0t2Y1pCOXJRbEx4Ukl4OVRKaVhX?=
 =?utf-8?B?QTljQWUyYTRjMzZNcUtwQWtmWnZDbmFBQTREOHcrdlhqWDFHRG1yTVFaK2NJ?=
 =?utf-8?B?bWRPVTVDSDdSQ3Z2WEZwNlhFZktkOU5meSt6UUptR1FMSVRqWSszVUREZUdr?=
 =?utf-8?B?VnZuS2poeUlYdGxwZUJLekhtR0hURlVMc3pQczRiWjExN3Y5WTRjVk9DcDBk?=
 =?utf-8?B?ZytoVmY4WGs0RWhGSVo2NDdBdkNVRkhDSVVNeUpNcmpYbFNqV0p0QjVaM0Nw?=
 =?utf-8?B?aDdlekJuSnJrbk1UdkNoQlAwdWxwVzNlaDFQaFptMFBGL1gwVFUzcU1GK0J2?=
 =?utf-8?B?dDlndkJ5WlhoaTF4WDhQRUpQaUJSNnhsYjRQd0JQQzluL1Ftd01EK0xjQnVI?=
 =?utf-8?B?cGxvTE0wLzFmYytHZ1c2KzltQUp6NzBMczh2d0NJTEpZUEFVMUp3YUwwYVA2?=
 =?utf-8?B?NEhMTEhldFFmaEJjRUV3c1NtOWZRWStCcFZZdTFuSlIyY2tnOFZVdVNENGpI?=
 =?utf-8?B?UXc1NUx4eFhzWk90WVMrMk44QzEyZkJCbjRaU3pkQWIrdlZWbzJZTHFHVjFh?=
 =?utf-8?B?bUdBOWtDWUd2K09BMlF3bXpmTUgvNmdJWUxCRHdlTmhXYXhMaCtxdy9WQUY4?=
 =?utf-8?B?VEh3NjkvcURoMkxNZThmQUxjaDN1Y3BpK2pjVU9PN0ZmSVJPckdjdUJNVVYz?=
 =?utf-8?B?Z21kYml3VmNIZjhzMEdJUXNMSm4vbS9HMHp4eDJLMDZqdHZ2UnNjd0M4aTlK?=
 =?utf-8?B?UjNCOVdmeW9sblNMc3pZbGdnUStONTNUVCtNMWhXdnpia1U4UFNtMW9LdW9G?=
 =?utf-8?B?WTV0RlpOaEtmMXRFNjlYalJPc1FXOUtHVXVPYXI5N09tSVBldGg4LytIbkZv?=
 =?utf-8?B?MlgrSU54YlU2bkdtSUZDYWxvTGkyVWY1SUpmM0EyUjRLMk9WUHdZMStONWdZ?=
 =?utf-8?B?L3p1SFN1QkpNYnBiL3ExYU1lcEt3ZDNILzBuUG02dDdBZFI5L2VlUFh1dTFm?=
 =?utf-8?B?K3VGRHM1RmFaRGNKTWtrNlhMRzlHYVFRc0dwd01qYVhhdFp6VlZ0OHNkUjhC?=
 =?utf-8?B?MEZHSkVxYk1rRE1TSXdaRUltSTVjNWw2c2lTU3QzN3JJamFOTnp0NUZnQllh?=
 =?utf-8?Q?6mfbLeD5ZAAC5DQ3CC9GvomB9b35t3gxl8OjQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akV2UkgrS2xWZzVBR1pzakxFQ1VXSkVRZDJpdjBocmhZNFpiWjZtalNLaFFL?=
 =?utf-8?B?NmF2aGNMa29INE14RjlZS2FYQTV6VnhSeDFtSDJZeEJON2FFejZrM3paZEpD?=
 =?utf-8?B?QnB3UFZwZVQ5dWMrbE96NS9WRVdBL29NcUJ0NUdzSkkyQmxMZ3VLYjZUY3cz?=
 =?utf-8?B?bXNrVFpVTFI5VWlQbmc5dS9OQzZjUnY4VVliV3ZGYXJVYVFiYWgxbkdNazcz?=
 =?utf-8?B?bzVOUjljVGVvYmlRMzdET3ZoWGc2RTkrYjdwVDI2YytRV2ZZaHM0RGR3b1Vo?=
 =?utf-8?B?cmJiejdXa0x2MW92N0JDU1BFWS9tTkxjekU2VGxoSWZJQmRqNVp1OERJeVEy?=
 =?utf-8?B?L0ErVzQyakxXampkWTEyQlRCUnZBZCthdjFIckU2NnpxY0VrTXJaV29MazlX?=
 =?utf-8?B?RlZkbXFSQll3UnFNQVN4QTF1bGVIeWJGc0pYbnZyUUoyVGNGcFRuSDY0YXJD?=
 =?utf-8?B?V3V6RUpSL0dEczZJZ29SYzhrTEpsbGtMRHFrMGhYTDV4MjYxUTg1SDlJV1FE?=
 =?utf-8?B?eVBaYkM5elA2YjVXRXZQK3EybVNxMng4SXNIOEExUjR0UzZPMzQrbjdMNVVl?=
 =?utf-8?B?b3p4RVFwamhzUzhsakhoVGdRRTZSMHNlZFo2WXJNQnhTczN6K00xVURLT2lN?=
 =?utf-8?B?Y1Vud080VFJ5RUFYbmlVRm1mYVp5T3ZUcVJFYm1VNjdEL1FDcXpRYXVlb1BX?=
 =?utf-8?B?MGNQaml3MytSRk5VcUQ1cVRKZDY0c2RZc1JOM0VmcXpiV201bjQrOWxwbDZr?=
 =?utf-8?B?MkFjRitzdzNCcEJSUlZJa2dtZ1Y2S0llRkxiK05DM0pzdU1ISTJDWXZlRVho?=
 =?utf-8?B?K1pTS1VUNmRkc0ZRb0RHQUMza2YydlVwNzBCcFhuRzlGMXhKR3o4WlR2QzFi?=
 =?utf-8?B?TWo0UzFCQTNIUHU1dHNoRUZNOUVvQVRRTXBWN2hBRTAzanVHQ3ZMSy8wQjhr?=
 =?utf-8?B?V3QyTjk2VlhRWFF5cXRJZy9GcytFcXovZWdSZGhOSllqNFBaRFJEQjk1V2JB?=
 =?utf-8?B?RC9jb0tDZFpraDVIK3A1czI5UzlkQWdNd2k5aHI0eFhoWlV6cmpoL3ZxanA4?=
 =?utf-8?B?emNvRHhUMjdTR01oQzA3SWZjRHhsVVJBcHJPQzhSQWdaMHVuZ2x4UzFZbXh1?=
 =?utf-8?B?SGhTRDgydzdjeXNyMGtFZmR3L0gvd0IzQ1JuWWEwQWZoUncyT3djYXhZUmhK?=
 =?utf-8?B?TE9IUGhvSEd5QVcwMUo4V2M5anBXZTE5Uk53amFEc09XRHp0SmJPSER1UXUx?=
 =?utf-8?B?VVVLMUFlM1dSUlM5aFJuUnlIMTl1RFRGTnIrT3pXckxKejIyZkxaWTJmYVI0?=
 =?utf-8?B?ZGlFbFlXRzQvdGg4LzI4b2hmLzlpZWlxMld5THl5VG1uL0s4MHRsMjFSeStl?=
 =?utf-8?B?RkRneUV6QXBQOEQwbVZjK0puSzg2MWRGRFFJVW9DcXJSbUw2T0JwRDRLUlJ1?=
 =?utf-8?B?MjFkMThlV1VibWJRTGFXMkZHMU94bXpzY2t2bjdDejlENFFKK1F3VWdJOFIy?=
 =?utf-8?B?ZmhOaU9PT3k2T0J6N0h1K280bUZHalpsWTlUMGJmaGJFTS8vMDhaZE5wdk5a?=
 =?utf-8?B?L1V6bTJpYzYzSzMvWXVxcG9IUElKODBneW9qZlpvVU1vc21Zd21QVHlLZnJ3?=
 =?utf-8?B?MmRWZVFzcGRZcDJiWEkrSTd5Vm8ybmRGM2piaU0vK2pzd2ZSWHl2RWhML0xt?=
 =?utf-8?B?bm1FcVBwN3AvWEloL3lCWCtZSy9rV05zMjZ5WHg1c3d4TnJYT1BYOVlpNVNo?=
 =?utf-8?B?VHhUbDdKSWY4WmhKRHljLzg3UkM5M1VvdFExMFZQS3plaTI0c3VrTDdFS0pW?=
 =?utf-8?B?UWpmZ3Q0bk9pOG9DM013Y2lnUmNVbStHMlhDL2UxNTF2OGpSTk1qQ3Q4M2Yx?=
 =?utf-8?B?RWNqN1pJTmdGem5ZaWI0cEtERU9PMERzdGhpeHVBL2tBVW5uK3NVMk9DR0JI?=
 =?utf-8?B?SjF3OHlkbE5kVGFYbU5PTGhibUkyTW5OT1Z4Z1N4WEpUK0ZGU0xRUEZRN0V0?=
 =?utf-8?B?UnVzb3Jzc29hMCsyRzRlSlk1clNidWVxYVpqckFvRDIvenM1L0FuR3lTVGFC?=
 =?utf-8?B?WDhTdWFmZTFzSU43TGFSZm9JMFVSaEVnbStRYnpoV2haVHJ0UU9oRU5kUm5Q?=
 =?utf-8?Q?1qktF9M1extw321w2CBv7g3TP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387837fc-7862-467f-6d16-08dd17ae064f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 17:30:35.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Eh4n0EJkixadjGTMbjIM+uueINg0f3SFWt8GfAFtEPwK6tWVrz6gUmEYa9gM+DgqHqJQyIsRtfvLDD6BmMpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 17:30:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17376

On 26.11.24 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to pick up all common features someone brings into the
> merged config, like we already do for qemu-amd64.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/qemu-arm.conf     | 2 +-
>  conf/machine/qemu-arm64.conf   | 2 +-
>  conf/machine/qemu-riscv64.conf | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index d2dd81f..17c0883 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
>  
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
>  

At least for 6.1, cip_merged_defconfig lacks CONFIG_AUDIT, causing some
test case failures [1]. Did you rerun the generation for all archs and
versions?

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8580918327

-- 
Siemens AG, Technology
Linux Expert Center

