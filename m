Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E87C25B7C
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 16:43:40 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.82])
 by mx.groups.io with SMTP id smtpd.web11.329.1716569017302503723
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 09:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=c/y+ewx7;
 spf=pass (domain: siemens.com, ip: 40.107.13.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgR2/cAIH6gFB17WEVx2m4076cGcUp19TploUr7oTsq8EO0bfQGmvKKhBmhCWjXD2uzzi3GesSMY1F+Uah3pVm8+bwDEwiGadbZggDzaEyLOnXjIInZWaJJ21mOIE3+tDlVgYm9asdI6gsGQXRXHABUcNgGD0AXRltFGmLYMJWn/8MOWWazesZLPcOXvJdqa64NyMkXSDH27yTXJXqPt0KtoISEHGbIkR0ptLZM07F/Eacu24mAzjCazwEHAIB2iyJtR/n1UVg8NxwNYG8zMl2hvCgD5JUFQQgTH9YGGBseu5oeVqdD2fluAaB+cpEZxB6ieo2VYRR5C9ynQVvuTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sn/Pgy+69sgLVK60CyLLfV7mtBfTK8BRaruIqW7lQk=;
 b=ddjwbIKL+l8F7Fs7ZfvggZFq/XJhFyJlNNk96vjcJpj5AsC418Hj51vL0/dkGIH5osPP/tWfbDBG+dCrDsTcHZY4lsGY+5lxfN/wDNME4wVx6O9iGWAXAxnOtD9+FyznFRCkLxG8DysGy0YamCaATTneNcpXHrqXh0/olMXvU0aczLE5wCB+RqDqHEz9FvVNd033d2fG093Xt3R6E2ZUZLajm4l9rXaB9uBsmAcqD1hJ9Hzv5nz5vuH6I0sOC3IB8ii6TPGPtwZXCQjaQiWqUBSlpP3bqV2DzV1s2NNSwEkf6SoM6Xf/llfEc17GoI8kNZzLpZQScg1nA4NcWLrdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sn/Pgy+69sgLVK60CyLLfV7mtBfTK8BRaruIqW7lQk=;
 b=c/y+ewx7xcMQZ1cBaGOYUGr3Uqz4X81ytfWWwM+gK10/ZC4bFeeTdbBR1RCAys12mBMucTkgJLKzP2mE+D4JQ9suC6PyQYujGuR3/ilOVVNqwMtWs9GSa0Z4edWYChsSeiLBFjlOa1bzfAHI/2gWyoXXzZ9RXWx/Sz4JiNHwvaCXNCjwfwWIKuhDWEuWpEyi+X797o5gieqG1E1d5g1aLhsR1rwteaunpk14t0kZM6LsjWyHSzqZOMlOEuwLyMSxwC7vx310Jz+w3aVxFYETnYiwS1Hzezre753R0t5lD2wMZNkJWIrfBzmkwL/U3bjKa7CqEC3kkVdt5kkuvhq3Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 16:43:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 16:43:33 +0000
Message-ID: <2750c2dd-057b-4cce-901b-dc4d1d29c959@siemens.com>
Date: Fri, 24 May 2024 18:43:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] encrypt_partition.clevis: clevis
 > v19 support multiple tpm2 device
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 gokhan.cetin@siemens.com, cip-dev@lists.cip-project.org
References: <20240524163509.2372441-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240524163509.2372441-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 18621beb-110b-4f71-d098-08dc7c10a67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Rjc0MlBXSVJMdlRza0oxMEF5VDBHd01IQ3dQZExab1k1RGhzam9JZ2lBelJG?=
 =?utf-8?B?MGxlc1dYbXNPUG1McXdjcFhvTkpnTVNGWE8ycEg4N0VlNTZrVWxFQVJWWEhD?=
 =?utf-8?B?cUYvbCt2dmViSWxUM0hGWkc2eCs4NVdGdktqK2JPUVhCOTBocU5DZDkxcUR2?=
 =?utf-8?B?ZlFmSXJVRlU5R2hNRzN1dEtNaytFQVNpM0JOWWhYVW1jSkYxYTliR0xvbUJz?=
 =?utf-8?B?RDd2VzNqRERmeFZuRjgzbXJUS3hrREpoVERvdjFaRjZyTmxsVlhzODBybnJT?=
 =?utf-8?B?V1V1YWZqa09mdzZiaklhcE9aemt6MmpMYlJKZWp4MXljVFRiUUh2bkZ5YW9N?=
 =?utf-8?B?ZTg0S29tTFlmZ1FFK21FOEJqSjVpM1BORENrQXNUQVNHZmo4d0ZNcHNJcjFC?=
 =?utf-8?B?OGU5dDhvVkhWbDBneDdycVhNYkpoYjVzeEVLSUFTTFFTT1Y2cXZtYVhMdmZ0?=
 =?utf-8?B?ZFQ3elFXYXBwTGRXWjZCL0pLU1FyYitPRFJRN2NhQjNheFNyNjhoS0JwM1Bs?=
 =?utf-8?B?TmJqYjVSVzZJZFV5WVR2UllGVXEyaHNiYkJhWFErVVZyR0FNTkh2NjRzdU5h?=
 =?utf-8?B?MHF1eEpFM05saTZoL3dLQ2ZYazZuU0lubHBCWS96RzNMZFBNRTJvZ0h3bm0w?=
 =?utf-8?B?bVZHa1Zpa0tQVWdPUUx5SWdhQzhKVUJ0SXYvR2swVkNvZHBKV0xSQTFQTERY?=
 =?utf-8?B?SmsrcElrV3ZDNkxpY29EalJ4MklSbWRKSENRYlpFcklJVWYrcG4yT0Y5M3Vz?=
 =?utf-8?B?MVkwR0VBN3V1QjJ0RkEvK3FRNnZjTFVydlVRVzNFTXlTTlNmSjBmU21rb01o?=
 =?utf-8?B?OUlwQW9NdXFFbmZtUXB6RVJyd1d1VkRMa25YV1dqMHVsUmkvTjg5cm1CRnRh?=
 =?utf-8?B?dGEybHBkdUZqVGJXbmp0SzJJWFJ6OUs1MXg4YzdGZXZ2MXdVcnkraUk5L2xJ?=
 =?utf-8?B?cUZndWZFVTJIVWRtVWV6WFJwd2tYYTBBTDJENGUrSHNmMWJNendqcnhyb2h0?=
 =?utf-8?B?Mm04bm9tNWJxcU9FOGY3azNlSEpSOTZXOUxOTHhrbUkvZWd4R3BiK0N1MkJD?=
 =?utf-8?B?empTUnRVUWpNSTlrVjYxemlxTzZSQWsvLzNRd3FXY3hPZjVFOUNSSndFTlNk?=
 =?utf-8?B?VUxYQU9XMGVoM3RoVm52KzN0a0JoN0grRXFKS3MzZ1dseGxNODV1RmlGMWYx?=
 =?utf-8?B?TlRkMSswWGJyeWZkUFZ6QW9VT25yYVJ3V3B0SjhyZlk4N3A1YWtxM3QrR3VP?=
 =?utf-8?B?clJ5eWNWR1U4cTBrSzZpK2twMlo3TGpNVEczNHFVcWgza1h4ODNBY1YxU2RM?=
 =?utf-8?B?NWFZYTRNakV4MnNEdDRCN1Jrb3MvajlPc1E2MnAwZ2NXeVJhUjladi9iMHJ5?=
 =?utf-8?B?SjNnV1lZWEh2SEdDWmpicllDS2Q5azdZcVZCT2FzOHVveEFDbTA4L2VTU05I?=
 =?utf-8?B?QXkzWXUzM0F1cUlnZVFzeVM5a1M2Q2V2TERYT0Z4VW5NVU50TjlPTncrMTZ2?=
 =?utf-8?B?Y1NDcnh0R3pPVndKSExlVFRvVjhKNFVLcWNBVml0N1U2YzBBV0RZWlRHMVFP?=
 =?utf-8?B?NHh6U1ovOXBjdHMxdXNWSnVzZnU5Wmtpczh5UDNuaE8wL3pvbktuQTB2UlEx?=
 =?utf-8?B?ZDRxSFlxUE1XOXBlVDVaNnE4LytESWdzc0ZDY1M4ZE0rVkw2dkdCcU1nekg0?=
 =?utf-8?B?dTRRMnRVcnBJNUtlWWwyUzZjeFFDSFJsR2x6amNQd0wycGdCRXo0Q2ZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDFTME41QkdWc0RXT01IREF1VzdRMTREakprakVmbzZMZUQvZlNEb29vSWpF?=
 =?utf-8?B?b1ZSb0ErSEI0MW1jcmFtaXEzVmVCSTV5Tkx1YlNQNjE1NkpFUlNIR21QbFFo?=
 =?utf-8?B?NGFoYjRheFR5OHhOdWFORHg4Ujgrd05nN09SR1VjNnpTczdJS1dOSHhGQi94?=
 =?utf-8?B?VWYwQU1OdWFPd3FGdEd1anpVVXcvZ3VSaW53YVljOHpPRWduRWxVN3FhVjdm?=
 =?utf-8?B?elVuWnNIbTdIR2dBVUNweVRFNlhjQVN2eE1wU0NCcmNwWFRVL2pxcXdoN3lU?=
 =?utf-8?B?a3ZDM1Ixejk5a3YzaHN5K0dWN25KNUdjb045Y21yMFV5TVk4Y3FodVdISnli?=
 =?utf-8?B?M3J5WUJ6azFqMG9uUWlpNWZtTktYcHVWVXhkQ2RoaGxmOXd6WmVCandYQ21Y?=
 =?utf-8?B?OE5zaDlLMGNiVW1xOE9FandQUitQcUR2TFNhSWlEV2lzdU5xL2phTkUxT1ZE?=
 =?utf-8?B?VTZURWtsSmg3Y1ZJdzV6OGd6RktwazY0SytSbWlOUFpMeVZxb0p0TnV4NWNO?=
 =?utf-8?B?ZitpRnZhL3E2U0lhOGJRTFlxT0NQdE5rU0hTTU51bzlrN3c2VDd2NmNSV1NM?=
 =?utf-8?B?dkhoNjc1UXJVK2I3U3Zwd0dmbWgybE1KZEpncWtMM2I3ZVlnYllLSFpBMzlN?=
 =?utf-8?B?cS9EcmExbk9NOXpJbUZGYUxyWUNsQTVReHp0bDB5S3J4eDRyek12cEQzQnNL?=
 =?utf-8?B?N2NKb3pxWTJ0eEdJeXpvaWdES2svNnRyU1hKSzRRNmJYTnpydmc1dW9uVGlp?=
 =?utf-8?B?UWdrRmNESi9RcGs1eWk5OVFqLzZSemYzYXQvMEFQQ0J2cXBjeVZzSWhCQzBB?=
 =?utf-8?B?WlpkOTZ4VkRyQVZwSU9uaktKUWZUdzR5ODRVT3ZsdnptRXpuZnJRaE9SU0Zo?=
 =?utf-8?B?V3lFZU1LMnI3THVyRHNuWm1FM1J0VCtMa0NFY2Z5Lzg4cXpYMFZiSUE1aVp1?=
 =?utf-8?B?SUhybkdEMHE3NnpNMlZDWnA3U2ZWMkxpeXhER2VBckZZSEJRZ0t1bWRMenNB?=
 =?utf-8?B?T0hXSHM1UDJHSXZIVTN4OXVSNkhhNGx1R2VZcDAzOHc0RW5PM0x1c2dnTk9P?=
 =?utf-8?B?ZytSWkdzeDhxQUJwTzVSWDZrT2c2Wk5jTHI2ZlV6dHR2RDFEVGVTbDFyS2pS?=
 =?utf-8?B?cjBmaGNRTTNUVTFPZEJJa1U0RFhFOVl6aWx1SlYxdVpLeGltMXEzUmNDRDBv?=
 =?utf-8?B?VVlma0RQRzJJbk5SKzR0ZzI5SXhBSjVXTGlvZEp6MHhDMDhNWld0N1BDS282?=
 =?utf-8?B?OCs3Y1NXR1R4c000U21SM1hPTzhGbmZPZytqdXpmZFBkeTZsSGRBOWlYNVZs?=
 =?utf-8?B?TWVnYWQ2OFBKVXV5TnBsVnV1ZHF6d3RLTWlHMG9mTFJJRkVwNHpnZy9xckc4?=
 =?utf-8?B?SHpOZVRZOHd0R0xWbVg0SEt6a29SOGk1b0NSNWVGNFlxaytmUnRMLzNxVlBh?=
 =?utf-8?B?YUZZWE1LaU8yTi9oTzN5MHJuK0xIL1lSMlYwUFZTTlVhdE1Mc3Faa2ZQZGZ1?=
 =?utf-8?B?VnFIVFpqUklpRjROM2d2YzhKOHJQZTJXcXVQU3Nic2lMWFpVY2wrcFFJMVFX?=
 =?utf-8?B?Wk5naFpTM3hYUllrSGJDcVZKNjFRclpVREUydVVpRExXMmNNTkd5T1FxMGgx?=
 =?utf-8?B?bU9QYldYR0lMdDcyYzdLWjhzTjdsa0NCenhCWFB5ZExIc2J6Q2ZGbExWNmha?=
 =?utf-8?B?VHZCdG1samtPRVVoNUh5QkViY0pKTUJ5VjNWT3R4WmRCdGhXaEhtblhVVkRW?=
 =?utf-8?B?S3FUMlFGTndXdm1rM2FlVFJhbkNYY2tINitCazhNVkxGeVZpRyt2eSs1UzNx?=
 =?utf-8?B?ZlFNYzlVVjByVjVoZ3FBY1Y1R2RVWjNGL0FocWJ3Mlo5b0FGa2VUczJMbEtx?=
 =?utf-8?B?SXFnd1EvL1dvU2tsYTdpQk15NEJuQ0RWY01TV3l3VUVuMUlmTHBuckMxenN2?=
 =?utf-8?B?K3NmL1JOMEdVb0hHOG80L2Q5eVBDblVpK0ZmaG9PN2FJMTlsK2NRY01SRXhy?=
 =?utf-8?B?bUJYT0FUUGowbXNrQjc2dGhmK1JDampJUmF0YUxYNEdyK1JudFhzU3VQaTRR?=
 =?utf-8?B?cnRnbVJIYTNTc0g3THVScDBtRnpUbGFiZWtRcGxjeU5DMUxOMGhHNFRFaE5k?=
 =?utf-8?Q?Vj153J5XdBEbKlDLWmcQUBA3q?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18621beb-110b-4f71-d098-08dc7c10a67c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 16:43:33.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMNz+2UpGZpsr9ZocqHX/MGRils777ugdKuLjZQ3sEw6Dhx5lHfgd8b/vSnnIeHWy2aA19GOaePlhwcbBwS2Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 16:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15947

On 24.05.24 18:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows use to select a tpm2 device which supports
> all requirements.

This is not yet an accurate subject and description. You are fixing a
code path in clevis which exists for systemd, and that code path has the
task to open a specific tpm device according to the interface between
the generic part and the clevis/systemd scripts. Is that right?

Jan

> 
> Reported-by: Gokhan Cetin  <gokhan.cetin@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
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


