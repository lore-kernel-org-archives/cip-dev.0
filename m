Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432B2C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 06:19:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web10.21840.1716790723144839947
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 May 2024 23:18:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bkuQk+Hs;
 spf=pass (domain: siemens.com, ip: 40.107.22.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYS7GQ2Tc7u7EPKTE0O+2KJbudAEVL/4RgE5zBvyBTgwHXW8q6guBM64etqQQ/6zTKD18ZAUVTiA+Hexko/kzitu21NpX7JmaP7hPgPDhsuq+3WsToW+ODI6HPteEwmn/ZUjEHnyRhbsa43WeVUuaWfInXiry10rQVUhdLVUqqLsRAcPuyq5fEmdKUijcWh7xNecrK3nto82gAxgq6TVY0i2Teroc19J7069gWKPNiQwMPXbyG3r3rjfyit/5DZfJegfSPOzzOt98Fnn7uPFXnQyQpiMQgfsL+M6eDd6eGpkRZNkcK4/suoP3+w/4386PcQRz39tYMV7Q2/SrcT4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFL5AfxNWkbufs2R6LvrlrHL3twAjmI794zGB4v22QM=;
 b=hqS+x6VUrXx5sFIXzx/jnE1Op03drRG1/G/l4F1UhXjVN/6xZrcTc5ywKz93HVEWYbckJDCwwA5uocYSsCtHC5WKhGjmJUAzl8sRi28SGCpGWqxkuDR+TTlU7mvz7MU3sh2LIJYEeWQHNUVcjol4kgCSqAh2fa5+V0EeQygen2quIRALnboQ8iQC3pMOdX2Sx5pEbWU6VtD3mMKrBUoe7i6IxJmwi0msqpj4hbE/x40ZQbuf4S6lVr1pVWEMtsc/eIeQhX8dgHm2TTjvrbRQBn1oMY53D2xbAtBmj10MWUiFU4TIHPa8/HI4CWHdhaYw/Gk9gSt7wQaKSsCni+c+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFL5AfxNWkbufs2R6LvrlrHL3twAjmI794zGB4v22QM=;
 b=bkuQk+HsxEwXUueLPHELnhETSeJVnCjkwiwb+lfVil821RWJNbXuZx/EvugWupccvBFiTw8Yc7CeItaJ3ttY6l5ttHQjI7HlgO1/ctKMwDf7Cm/njTjUJW1t4bu4NZtikw4I54eXBa0t0hPaVgTM30qSye2mXWmcCTx8dbJoUk9zjty/CLuglz03ivjW3fbclEcfZzl/ahOv3Rp+RN/iUOekds37XWTgRUVVBkEucPtLcLFVQ0Zzap1rtHG9n+pTBePviBfSOoDKceUEAFjlhDZQ0gsbHCgVMRR7dLQBz7lcBd2Hacr9bxycwwimsQRrnG+dfe518TLSjLnxssuTag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:18:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:18:40 +0000
Message-ID: <990c3a80-79b4-4be8-865d-c1162a5988a4@siemens.com>
Date: Mon, 27 May 2024 08:18:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] encrypt_partition.clevis:
 select tpm2_device for encryptition
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 gokhan.cetin@siemens.com, cip-dev@lists.cip-project.org
References: <20240527052948.2471630-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240527052948.2471630-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c615a8-fb23-4ca0-cf43-08dc7e14d9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eTZSSStZZ0cxT2dkN3htMW5nZ1VTY2tGSDZjU0FEUjRuVk1rbmhnRGVsNEx5?=
 =?utf-8?B?ZWhIVThOTnY2cDhVSDdEb1lnM09lYmlMUFZhQWZJS0F5M3gycWhyYWtVWmov?=
 =?utf-8?B?Ynh6R0NNSExNTmNSL2dSeG5ROFhqVWs2ZllUWU1IYzVSS2dWMDhZdDhXQmtI?=
 =?utf-8?B?RVNlMEZ0ZFltVzRBaU80dTZqU0JjSkRzR3ZRK29FbEVSWllDS3FTSGRFdVVj?=
 =?utf-8?B?Z2RJbjhSaFhndFRQQzNHRTZWQ2VqaXlHWCszNDhIYjNUS0V6b2VXY2hkVE1W?=
 =?utf-8?B?RHEyRzZQQkQ1QTZtUUpmbE5VaUhKUFFlaFpEdzArYjR5dUV3WVdHaEZqTWti?=
 =?utf-8?B?c0M2Sk9JVVNzZGFZVUZIczRYNGdIcStrWFNVa21Gck91SGVZL3lhWk52cEl5?=
 =?utf-8?B?UlRqRXJWN243ZitINjVqQkM2OWpCZEUvcFpsaUlRTUxBbzhFTUJnbi9ETzlh?=
 =?utf-8?B?RW5qUlR2alp1eCtxdVJSMHowSW9abmphWHc2dkcwejZ3UElWQU1nZmNVVEJH?=
 =?utf-8?B?OFl3azBETnFRUW5KVm1lYXMyWGpOci92M2M1dWpTK1BzQnhrZzU1N2h3R0dH?=
 =?utf-8?B?L2hYL1BKNUJmOU1rSzBGOGlRcnE5cStEWEUwRnpFT2pYVmphMGpvYitzWEZW?=
 =?utf-8?B?M3lFS1JadUIyNjE4VHhoV1g1QXZJWjRpa0s2UnRkYm1HVFd3UmE4dFpHcVFs?=
 =?utf-8?B?bEJxT3NZdVlYZ0xWbHVKVk93eU4xRmxCMFpha3BZL1lzYzVNcUR4dGdMWXRj?=
 =?utf-8?B?KzhRL1cwcm5GOGpGbmVTVnozTlNFb2NrZHhVQ3RTNzErR2ZndW9qVFBqaE1x?=
 =?utf-8?B?cW1Yb0s0SW0xRzNubm1GRUZpQU9McmIvSFNIZHFCM2Q5dVV4UTZHUCt6MDZn?=
 =?utf-8?B?VGZiTTdXdHUyT3lxMXpGYmtrSjYyajZOMVdGYkIvQkQ2M0Y0TTlnNXlXZjJH?=
 =?utf-8?B?QmlhdkFJL2NTOW5PSjl1aXhnV1lYWExhZmN0aE56NUh4L3NuVUhBMng0c05r?=
 =?utf-8?B?RmdTMHVNR3RHZytMUG1PTURzZXUrNk0vU2paRDJlTXlvUDAvM1ZJRTR6VEor?=
 =?utf-8?B?cHEzQ3dwR3V5VWd1eUhWZFNObm50YWFQbWs1YUF6ekZBREtSMjNXdXJrK1VX?=
 =?utf-8?B?RFRORFpVenVsaGE0WTRLclJiWXp2RFpGeVVMRzB0Uzcxc01xWDhNQ2RXbmp1?=
 =?utf-8?B?WXFzSWFtQ095NTk1Nm1iV2pLTWFreHFyZVM5UzZ3eitFZUducEdrUVh0OGVz?=
 =?utf-8?B?TVVoUFZKKzM5cEhmQW5VU0RrSk1BR08wU3dzU1k4QXpza281R1hoYnlvbUE3?=
 =?utf-8?B?OS81eDc4R3Y0YkludWJuVHJhRnh1dU9PTEZ0WUpOREdLaWd0ZlhsQWE4SHd2?=
 =?utf-8?B?SFVKQWpWdEw4UnFVYnJOeEFxWGdXVVdYZi8vL0lacmg4T25WNnZoWG10QVJJ?=
 =?utf-8?B?UXRURU5mZlVGc3lnSmNiMC9XSWxsSkdNbHEvN0R2NFB4U3M4WDU3cjJYQVR4?=
 =?utf-8?B?SURVak1GOHZpY2dEZEJYRWw5M1JiNWJzZW0zU2pyUDEza25NL29HbWNYcnhp?=
 =?utf-8?B?Yk5LV2QwdTJjYjRrOWNwcFN1eVpuVEVHVEJFTjEvdU5NV3VucXZUUnF6ZTRj?=
 =?utf-8?B?WXJQZ3J3NVJDbGxWcDFqeW9SeWtZN1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWlZcElpTXZWUzZmUVJQeW04YUhPVFZ1dmV2ZVdFWGlNY2d6MGU1ckFkSzVl?=
 =?utf-8?B?MTZCb1lsN1lNMUNDQW1Bbm1yUWliVlNISlF6amt0WVlacjg3R0Q0TldTL2x0?=
 =?utf-8?B?Z1IrTnVrWG11dFVJYkJSSEl3REUvNXN2cDkramVaV3NxbnM5U05INFEzdjhS?=
 =?utf-8?B?MytWMHA1NkZNYk9HRWpJOFlVejREVE1JNDhPZjl3YWV0T1NrVk9sUXRiUTla?=
 =?utf-8?B?WmhCNlR0YmhmeUNraUg0SVpZVGlwREYreVUrcFRHN3hBd2htR01pVWUrdTNZ?=
 =?utf-8?B?SnFrR2JPNVZ3azlhUUNzRjFybXpkREkrenFWYnBKYjB4enhuLzNNN0FORDJN?=
 =?utf-8?B?K3dCWSt3bTlQKzV4WUJ0OExHRjlBMUd6Q0hOS0xmbW5KcVloMVV1SWhBYW92?=
 =?utf-8?B?bW9iZW9DMUgydzgvc04wRUYrOVdsQW5DUm9YSXdDcWtBOE9DYTd1SkRJKzhP?=
 =?utf-8?B?WndYcVBYays2c3VFVWNmZWZnemsyMkU3MDBlV001TERtUnNKR2p0MGdPU1BH?=
 =?utf-8?B?RHFObXVkYTRGUWRGeVhIM0VGSFhRZ2ZyOGpWbUFGa0tNT3pmN245cE9YTlJl?=
 =?utf-8?B?WEhJaCtYblZaeVhJcjJlYUszTW11RU1jclVZem1Hd2dQOWlxMVJNbjBsbHhv?=
 =?utf-8?B?VXlndlpxcWIvbXhoZlV4NTNYd0F0bHAzY0srM3BzQmNqQkc1MDJ0MHQ2ZUUw?=
 =?utf-8?B?TmpiWktSaFdZNTU0cjRDQ0JyaHhJWU5vbmlFdmlFWnhCNCt0QkV3dUJuckhF?=
 =?utf-8?B?WkdLRnVMTnZzaXQ3WU1IRlQvUTk3Mlc4ZWtFVDRnZ1dyWnc5cUJHSmFRSXZo?=
 =?utf-8?B?L2FadG9Jc2dhazRYV2Q2TU81ajlKM2ZIK3psam1oeTJlMjFOWlFpdFN0Qnpk?=
 =?utf-8?B?NWFjZkRRcmZlWks5SldYOGFDVWR6Vk50RzVaM290VlBwOFRFUnJVWEJiTTRp?=
 =?utf-8?B?bDZybEIwU1JoZ05uOXMrRXBEc2J4b1QxUm9renRXRkMxYmc0dTBFV1Y4em9O?=
 =?utf-8?B?cmlmQzJvN2ZPWmNJNUNUMjQwYlBsQ25NWG56bEx0cVNsS1U5aTNxaHJtNXN0?=
 =?utf-8?B?c1MvNW4wNnpENmZPL1F0bm5hWEl4RzdHMnNuWlBUZGorRVF0bXN0UzlwT2RJ?=
 =?utf-8?B?T0txUFhwdHowNUlOdFZPamZ4VUxjYjhHT0hVcElmVjFXWkhYc1JveFI0YkE1?=
 =?utf-8?B?RGpJVGVxNEhlZnNUWjMwVjBFQ0ZaRjc2a1JxcUhnMnZpVVJoZjQ5ME9VaXBG?=
 =?utf-8?B?aFpYZDlXM2U0cHdpbitaSWhsTGljSlBuMzFkM0Z4VDJiNzN5VUhCbG5Zc0Fr?=
 =?utf-8?B?SDJRSjM2MkRwYXRhcGZJamhxWHMxNGZHV0M4d1BTRlUzeGNpcFlZTmtSWkll?=
 =?utf-8?B?NlZMZEQyaDZ1U3ZRY254T1pkMzF2TVBZMVlqSzBta3BHaU8yYWxKQzc4TFV1?=
 =?utf-8?B?ZWI0UEhzRXl2dkpqRG4rbXVDenNRcnJQdHNVdkJVUzlZWCs2OSs3TVFDMjdT?=
 =?utf-8?B?bEZ0SzlqNUs2ZzVnUWJhbmk0U1plQ3VXRlhqZEpjOFgwWmUxNG1acmpLa3Mx?=
 =?utf-8?B?WlVRNVBISi9ZTW94U2w3QjMzV2tVa01VWENkMjMwVG15U01LV1JTSW0zQW5h?=
 =?utf-8?B?WmdKUEFXVGJoejRjN2t5cGVZRzdxM0psMHpHQ0x3TmNnNUVWNGZVMmZpc2lt?=
 =?utf-8?B?Ui9HeCtXdFgzMXQ0VzFTMHNkTEU0Zlg3WmM1ZEh4dHpoZnlneklURkdhblZJ?=
 =?utf-8?B?NHFERWlUVHRHWGU1bGVvU3pkS28yRXlETDdiUnR0T2Q3R044YzZpclJkS2lR?=
 =?utf-8?B?US9kOWFFVC8xVXFRQWlxdEpHczVhVUV6TU1hK05FMTNXeUh2aGFSS0FzS2Rx?=
 =?utf-8?B?anptRWNkU3JIbXc2T2kxb1dNbU1uR2d4STNiK1FjbUllTGFyYmV5YXFGVENi?=
 =?utf-8?B?RzUzMDNZekorVkhXU3VYdUtGZzBVZlJaVDlCd0dDYlBGY1NORC9ranpCVWd4?=
 =?utf-8?B?ZW8vN2tnM3ZYSWcra2VsNDh2ZmlhOGV5V21kN0RsNHZOVVZJOGo5VFVDZmhQ?=
 =?utf-8?B?dE1vSHZsOEJBUUhyeWR0T1VlTjlOWDlkQlRUVUlNQmVoczV4NFlXMHBMYlZx?=
 =?utf-8?Q?q7CB4D9TtOtAtv5k0/ihnxebj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c615a8-fb23-4ca0-cf43-08dc7e14d9fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 06:18:40.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1nATD/oQ7Ad7RlilitQXAKIiF6WXNEPAv5SKEmOqCOo6b/P1KwmdY41y6grCiCfwj8qbPU4CX37meFUXXjusw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6757
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 06:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15951

On 27.05.24 07:29, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows use to select a tpm2 device which supports
> all requirements if the hardware provides multiple device.
> 

This is fixing a regression of cfef8103, isn't it? If so, call this a
fix, bonus for linking to introducing commit.

Jan

> Since clevis v19 the tpm2 device can be selected with the
> variable TPM2TOOLS_TCTI[1].
> 
> Setting the variable as no effect in older versions, so
> no version check.
> 
> No interface change as systemd-cryptenroll already allows
> selecting the tpm2 device.
> 
> [1]: https://github.com/latchset/clevis/commit/c6fc63fc055c18927decc7bcaa07821d5ae37614
> 
> Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - reword commit message to clarify intent
> 
>  .../files/encrypt_partition.clevis.script                 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index ddb3eab..a7a5009 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -13,8 +13,8 @@
>  open_tpm2_partition() {
>  	partition_device="$1"
>  	crypt_mount_name="$2"
> -	#tpm_device="$3"
> -	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
> +	tpm_device="$3"
> +	if ! TPM2TOOLS_TCTI=$tpm_device usr/bin/clevis luks unlock -n "$crypt_mount_name" \
>  		 -d "$partition_device"; then
>  		panic "Can't decrypt '$partition_device' !"
>  	fi
> @@ -23,11 +23,11 @@ open_tpm2_partition() {
>  enroll_tpm2_token() {
>  	partition_device="$1"
>  	passphrase="$2"
> -	#tpm_device="$3"
> +	tpm_device="$3"
>  	tpm_key_algorithm="$4"
>  	pcr_bank_hash_type="$5"
>  	if [ -x /usr/bin/clevis ]; then
> -		clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
> +		TPM2TOOLS_TCTI=$tpm_device clevis luks bind -d "$partition_device" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$passphrase"
>  	else
>  		panic "clevis not available cannot enroll tpm2 key!"
>  	fi

-- 
Siemens AG, Technology
Linux Expert Center


