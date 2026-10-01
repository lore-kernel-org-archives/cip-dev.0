Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9986CA5FA5
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 09:41:29 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7224.1790847680960742772
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 02:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JZ9t23OC;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G241pgn5VUKHO2dfvSj3XXUvr9+XpW9CA0fobx7nKawQtZrVdqodJ1+oxHQSHsIOk3wzAqXj3e5nZmYI06HT9tVbhTxqSk21HDwdKGCb4V3MkYwAemyAdInN6kjxuRRKxmfhR4e4FiapKneSUiDT/MO1nGwqJ1A7ihejX/NSJzpUWigQuUJKsa/KicXhSMIJ3uqx4upThGw+uPKExrtvsM+IZZl7p7GleVOcjq2mK1Va52Sfa8LVMCl6Nz2xVFNgNo1H1lOD8Ky0/ztyv6ZCtQQBnXCy4uYKRIlsem5pQj0FgcOMS+LOBjQ8cB3OHxWraOy5VwBfVWGIyGJouzHfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuDyAAbRKq00Euhe+JAeNjCMYoTIDMKglWtGcDV/m1o=;
 b=h4jwp3o8W3rgJg9T5XCgnHSopKqiISxGMhnLRxrBW+KleWiuNQZNvBz+lGy71SMqXW/2+5K+93woc6+sNISWiwDXaYWbDr//VqRHlEVSLMijFYfKOhav17AkunsjYuQQRipE7ec5we4y0gLO+oo0No0JBwJvYAVoHQN36NoDZ/KMef34uFFT11YtxfOLrvH1XkgBzPezPO+NDiZlQTApGr8Ag0llzhnhJKTW3NXkBjJY3ruGaldV1F8wmnbZe1JKTD/V1vKJQt58oocl/fl2Wrd4OpX/FMcizgC2IY0cBbimWLQpNJ86Vgxpp7CmrHWJjqEVXUEIcL08xJpxy5i5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuDyAAbRKq00Euhe+JAeNjCMYoTIDMKglWtGcDV/m1o=;
 b=JZ9t23OCtTs3/+Bh/eK3KY63fUuukcDDt7IaXKnkHWAZLapmPlr5NtsxmKWOdmsAb4UNsS78AzIMk82Jxvhuh56PuSmNUxPKUe1HfA0IlwI3TVQF2aP0Mp74HYywYsMqhKun9ldBEO37XEgP5lJYhjcIB7kCS4heIZg5IdiIdNUNNkCshRsBz7VqLGdwMaNj8DcqFR0b1UNjmRmx1Chft11xTQ4xDn7VHXy47Ucjpg7odzwkrW79j8X7xysVksChvBnhqpntuKTVPQW+L49eZSH4Aa2M+bqpnu35MICnIfO/QDOhdrHIG6eZ67HWoqbz7jr5Qs+YlkSif295vK4wyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by BESPR10MB426457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 09:41:16 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 09:41:16 +0000
Message-ID: <029504a1-bc85-4008-92b2-3eab2d845ed7@siemens.com>
Date: Thu, 1 Oct 2026 11:41:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 7/7] initramfs-crypt-hook: Prevent
 encryption without secure boot
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <eee0dd79f2b78a061ee9a097d68a9e27cc805731.1787722904.git.jan.kiszka@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <eee0dd79f2b78a061ee9a097d68a9e27cc805731.1787722904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|BESPR10MB426457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2038af07-6f67-4795-d563-08df1fa02330
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	fP+wnr5NNokR12xJKsckHWnBhzBND7gbxqwDJpXeeLCuAuK/KDzvXeH5pWw3JefKq1pC8r81rSzGd8h6GvXElsVEA+DR0zcPL4vA6wVMk86nj9gJYpHEbw04mI5V1gVYXSrhBIiQXNO/5mp36hD2W4jHJ3PhtXjNp19KbeWdHrfni4d3k+91fcq3xLE2smmAug2xQjbYKLrv6HLpNSjUEeWnxUltmlWLYk75e9eudtEQhwNYXHLLJXe8lPMekKyKLMPZ1dcxPU624LIRy5QrwWSpad5zYeGkNjfSuXCl6auLSpdfSjwHsLF3pBBMOxP2MgLRs68A4c9GPWWqjkhKxBtnxqjx3xai1iy8AoMacjimGSCeKxAd/OtLhKW+bMV20VmcOtIRokLa4qJmcLghutp/EfPsocW0NvU2WyBlzupD8pANKf63fBOh4nh/ZM40+SG1W8WQVawOSd8HbV6ZaArWEXCx4nuUHJdT05NHSOLWhWjNJ1EF87byXeapaykvPi7HRqfQE2fnPZqyuTV7IMOTRMv7ZCsAGwwXHdV3ZhD6gPQNvKR1XYcvP1NempfpiwwXEUUpUT/wLQ6opR2Q9wVs8NqDkw+DKof3ExVQt8jrX9ogCBPRHBIVFMtVnxBP4gwV2XnKGos5vbwWfA4se5+zG6nzOVcVKMnPyNA3S5s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXhVTzgxaU1xRUE2SkZpVFJIVnZBQnB6SWRYSC9mTHFSSk85eE8vR25WcHlh?=
 =?utf-8?B?OWR4R2RieW1PbFNrQ00rQnhDWHBBSnB2NURleUx1amVSQkwxdWxIWnJVNHhS?=
 =?utf-8?B?VDFiNHplY2g2Y0lYaUZ5aHE1aUhEOUM5Y3h5TzF3UjBzZkN2MC9ZS0ZsMVZF?=
 =?utf-8?B?UFRUTTVNelNBWG1hRmp4OW5HRkZtUFBnaFo1UnV4Rldna2wxTFN2Z2dWOUlr?=
 =?utf-8?B?YWk4RFdSTFZlb1FKQnZqaVBYeVNzZE0vMktEcUUrZ1NITlJYaW9oQUV6ajcy?=
 =?utf-8?B?WlF1R3JpcnhTMDNaV2huQWNFWU5yQVY3SXJMTkdUcEFFdHd3TXBmYTVUSi9Y?=
 =?utf-8?B?UEdTVmQyekt2TjI4dG4vK1Y0Sy9JTEFqa2V3L0ZCZmo0ZTBuSGkrMGZrT090?=
 =?utf-8?B?TlFudm92Rit6VE5jWXlpdVljbFJvY2dKaDdITEJ4dEN1a1hkWXU4aE1JN3Bk?=
 =?utf-8?B?dE9lZCs0akRsL2VjQm1Uc0Q4ZjNOenBsSVRvYk1UMXVIR2p1T215YjdRcElZ?=
 =?utf-8?B?VktKcWZDcUZhbzNYOUFUMjlQN1J6aWt5QlZoVnpSbVhsZ0FBcDJTNW9Tc0tX?=
 =?utf-8?B?bzYweG5aV05KVmFPcDhhV3N3bkpJWllIYm9kSGRXbHNoSFJSVmdSZklSUFF0?=
 =?utf-8?B?UWpOT0VjcFBRdTRzM1kwZWNuQjN4U1QvUURNaDFKSWd5OUZJTnBuODJmZW5v?=
 =?utf-8?B?UTZaU2hnQmI4NmJqV2F4Sys0amtXU0ZWU3lnTEpzQWJxVUgyOEkyS0pkRXJG?=
 =?utf-8?B?WlhUbUQrUjAwY29RczFYaW81OHBTdlJUNjZYQnZycExkMC9oVUs3V1c5Q2gz?=
 =?utf-8?B?NTBCZHF5cm9meksxQzZwY3pTN3lIa3EyZXVMWmNtengxS2tpK1NxTlpzNXVq?=
 =?utf-8?B?NVB0L0NoVWovNHBpV2NSTFZFY0FFUU54dnpLRXZLd2lDeENoeGlsN1Zpd1lJ?=
 =?utf-8?B?SkFLcW44ZEtwc0o4eDZrUFg3RmR3cXlEeGNUQjA4alZlUk0zWlJ5YTBXMi9j?=
 =?utf-8?B?Mys2cm9LMk42dVhWYVUxVWxzUTlzbkExVzMwUy8rTkVrRUI0dkF1OEFEYTJZ?=
 =?utf-8?B?enQ4NFBYTkV6cnBqZGF2VkdyWlFJYkZHZHhHeWRUNzNCd0xYK0ZubXBiNHVC?=
 =?utf-8?B?RENRalBGdmk4MVNNV3BLbm1Sdi9hc3VpNnFGWDk4ZXlIRE1Tc0g5L2FVYlNZ?=
 =?utf-8?B?YktOWDVCMmEvSURYRDRVNGxob1YzYWZIQTRzUEloaXY5ekJmREVRUkhON1p4?=
 =?utf-8?B?dXVsdm1PaWhKaGF6NktpMTh3SGtmbnZLeFYyWkloOWNaSExTUDhTeUloeVhi?=
 =?utf-8?B?NzB0TXZ3WStBTnRmU3FFMUhjR1ZMbG9SWGZTZWY0amdyc0pOSFhhbTB5Sm5o?=
 =?utf-8?B?MFhySzdsaXQvemlrTUFJMEhsN1E3Ym5HTXc3Wkt1ZUxXTnNQVFhoRUFKOGM4?=
 =?utf-8?B?N041bFpWQXFxWVV3b0NreWtWN2YvR3NFQUlQNWpZK0hEZG9pWkttMHdNSUdJ?=
 =?utf-8?B?YzJCd2U0T3FscXJzOWE1YUVKdmhVSVRCN3NGd3VKTE5hTEpUc0JFV2FwWW1z?=
 =?utf-8?B?cmQrOEFta281SnBZWE9jVUdyRGRGbkYrb3FVQ2x3TEM1b21nRko4VG9URGV6?=
 =?utf-8?B?RHpWcjhPZ3gwYkt4V01tczJuV0M2OWpWaWc5bmIybWQrV1QxK24yN0U0NkVS?=
 =?utf-8?B?N1FWZVNnZFdCbjArSEZ1cWlOdlhGc09tMkFZTVc4TGJ1Rk5jeFBXTEVGcmc1?=
 =?utf-8?B?S1hWdkwvNGlCUXlWNW92SU44WWRuclEyeG5sakRhVDlrdStkdUVZTkxQNWhr?=
 =?utf-8?B?eU9MNUt1THBSSTJlS1NlNHdTR1FCNm1YRXNRUEdWUG1oOHk4dUVzR1FZcFpE?=
 =?utf-8?B?KzcyU09sUGx3d0tVdEVTdU5ibkwrMHB0cW5sZDBmM3UyRkRvOUlJTjFIOGNB?=
 =?utf-8?B?cVlaT2hIVU5IVGpnTkx3L2ZqR2VKYW13NmovT29FNXAwby96YWtYVGp5OWh4?=
 =?utf-8?B?bE5YWmcyWUFnK3h4Rjl3UFA3a1FkWktLOGZsNnNjb0lsNnpSb3RySWpHUXND?=
 =?utf-8?B?U1FQdDZvWGJQL2JSaE1LWldieGRBaFNDTXUvZ1gwOU93QTUxd2wwM29NR1dW?=
 =?utf-8?B?SGhTY2tueUlYdjJ0MzNkZ0pvWU5hOHBoSVdTWmxWbjJMUVpwMFRYN1N2VFFk?=
 =?utf-8?B?YmpRaGhseGNXcktML3dZdmRtaHhWZTV5NVhDS3FCL1cyTEZLY2IzVjFXeHZJ?=
 =?utf-8?B?U2xmR1JIWjY2RXdDTFFaS2lNbFdEa1dwRnc1WWRnNWxOd3FpNVZsaFh3QW9w?=
 =?utf-8?B?dVhZblZTeTNFME8wTitSUjM5ZjR5KzFOV0I2U0JiSnVyYjhJL3BwQzc5Z0sv?=
 =?utf-8?Q?a2PqXBuP8ZFBAUFA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2038af07-6f67-4795-d563-08df1fa02330
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:41:16.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiCGp064rbxNv4msQjDagqmoWqPcpcCU1DymWoSk3ZTD2nfEdGW0Le1j0+UmQe3svH4/whtbd88GWOOPAu6oGgQMoVEUimCRnaGjNzU4pK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB426457
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 09:41:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24392



On 8/26/26 7:41 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We so far allowed to run first-boot encryption in any secure boot state.
> This remained unnoticed because the QEMU x86 machine is started with
> keys provisioned, and the QEMU arm64 machine does not support measured
> boot yet. The latter is fixed, and we also deploy keys during first boot
> now if they aren't pre-deployed. Time to raise the bar and reject
> generally insecure states.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../initramfs-crypt-hook/files/local-top-complete             | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 7bc08e55..3312e632 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -297,6 +297,10 @@ for partition_set in $partition_sets; do
>   		continue
>   	fi
>   
> +	if ! secure_boot_enabled; then
> +		panic "Secure boot disabled! Must be enabled to ensure correct key sealing."
> +	fi
> +
Why is this check execute for each encrypted partiton.
We could test this in front of the loop?

Quirin

>   	# check if we are trying to mount root, set ROOT to decrypted partition:
>   	if [ "$partition_mountpoint" = "/" ]; then
>   		echo "ROOT=$decrypted_part" >/conf/param.conf


