Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3ACCA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 17:17:13 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.25])
 by mx.groups.io with SMTP id smtpd.web11.1225.1755537424471688120
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 10:17:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mwZeWJyk;
 spf=pass (domain: siemens.com, ip: 40.107.159.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLTIQuSAm52poAwJBlkyAt/8rAERl712ifspW79hiV8qw+vDE61KiaSZMo6SofTZsR4mwM8b/Z2UC1hQtks7psJ9xEUctJ5duPh9Y9Mb8xYt6DCeH/BDQGgfCdaIfT3Dnt/xFKikNjyiSqqW2T7XkitzPl0zylSEWlvArzL6M9bAt+u+deuJd3Jq9aAiMin7Vw+GpjkdU/TNxpFhviP/PfkWv8JHjT6fgOjuQFmvuYWkCmxNtQz2XuVX5x7sEsUc/fhsyZ4+wax/QfiqVzYTBfN7ZMS0nejA+K4jeslxZddCp5RiOQ6xuVa1FxuzmONWcYSLQuRY7BCGbPMvH7Hf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xgu3dre1FYuDA6mp3WJzrqHRgXAs5R6LrHts/Rcddg=;
 b=WMmCyYLYykhEZNRo8i1Uvnow8jy+TwqKLcsDMxz+tjHnnCEEqT2GFSiaRNrzbp/b4UXqKfnMIRwjuNGTI7SppRiSgWPVGArVK1fNLGvmWc8T0DM4ShCgEcYBTvbQB5nxhFExaIH/0F/rfIeKp6WWckuC7Ximceh1yU5RWDmTEC2kqs103CiN5bNPN5RHxG8jMnOIcR781RNb7utR0f1h6rgsyn/IE5WcEwhhgKI761foBWJYHOMT1x6x/RnQLeSs2fh4b1w77GHaK9oWmU4vev3vCyfK/m/KO3q/dFBBrBA7i0MBWD2Uw2KpD41GlJk90E2XgfmELLZq08UcOqyfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xgu3dre1FYuDA6mp3WJzrqHRgXAs5R6LrHts/Rcddg=;
 b=mwZeWJykdr7WOmZAQmMWFM26DD6yMWyKdpKC1oCU8ur13N6GILYG8DY3diYdb4dnA2U8XdsSuNZR5j2CcpgpbG+pFSSGNmEtUjqTOYD3oBDzzafnXBlJ4f9nS8iknk2qoAQDILeabEDOqnjneFz5vXK2SdoGGo+xe+Cc5hWCF11rvdvZCnNvs+cVVh78DOQco2idQslJVRYHt3kAQfWlvDHCnFElCM+rwGb0ar9qkNb17x7VjJTSSfOv0ABHb94dDY7uLKgrgqAVNrZTzfyxclvim0qH2ivgFM6ci64iV5E2RGFt7GbquSLIhyZ9y7BC6LrfXfcuNImT1VqALQgULQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:16:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:16:59 +0000
Message-ID: <69b4513f-2887-412d-ac7f-f9bcb6e52a29@siemens.com>
Date: Mon, 18 Aug 2025 19:16:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/4] ti-am62px-sk: Add support
 for secureboot
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com
Cc: vigneshr@ti.com
References: <20250731082421.292376-1-s-adivi@ti.com>
 <20250731082421.292376-4-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250731082421.292376-4-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: d23f1796-1ec9-4980-709f-08ddde7b0a84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qk0wZzA1a0Y0VEJwK0h2R2tpejlCdjJjSHVVdW1jZndZTS9aUEgyV0hmTmJ3?=
 =?utf-8?B?YVlTR28yMElkcXlDaWlIdy9kOVZjKytwcE1tMUxJMGs4NXdtUlh0QWV4a3ho?=
 =?utf-8?B?UnBPbTlid0FVbHBZVExFdkN2aUZPTWpldjJ6STNOaHl1S21xWU84Z09JT2V2?=
 =?utf-8?B?ZktYcVFPVUlFK3lid2wwc3JsQmtrT0J0SU55bWFTK1hYdTlNVnhzaGFpMFdD?=
 =?utf-8?B?WFRndW1zSGlFTVdEZlVNK1pieUd3WnduS0xEQW5iMkk2NlFhR2dWZWhCbXlH?=
 =?utf-8?B?ZnVHU1JLODNVVEF2TXJCVUNOR3BzYTBXSzV1VXRjL2wxcnpWZ0RGTkpiY1VY?=
 =?utf-8?B?MmsxNnErTndiQmxjTExJQ0QwQWpnN243dHJrRVpsMEI3MTNrdnFqaURWK24z?=
 =?utf-8?B?eU9FYk5vWlBzZUpabHBHU29HZGVPNSt1bzByajZOVlEzRnZXV0V1V2VYeUFE?=
 =?utf-8?B?VnQ2Qy82d2s1M3BhaHVZQkhlMGt2L09zbVN5T3YwZ3dpUVluRnMwT0VySDUy?=
 =?utf-8?B?T1prajFwUWZlZjF2blIzMUN1TFZnSnB3RmJMLzVicldkS1d6SVp3aWFoZjdl?=
 =?utf-8?B?cExSN2V5M1F4bjdFdHlmOFA4R3BJN3hoTTVyVkFqYnJpMTVpODRDUVBUMGxO?=
 =?utf-8?B?aU1idWRPUDNWU1VrbVZzaHhpUGRmbnZwUDllbWI2Rkx6TkYwRzNRcDV5RXZY?=
 =?utf-8?B?Ti9jeERZRlRRNmI0YWVQeUFZZkdqS2VXemlHODBud09SVnArS3Vza0dLTXFV?=
 =?utf-8?B?MURpTG5rbisxNUFpQksxK1V0eWljM2M2YmtyQ1BpaVdSd0F4L1AzUXpUajFz?=
 =?utf-8?B?UVpsT1VEeXdEZ3hxOGJVamhhNjdJVnZ2TlQ1WlZwdmQ2ajgzMU1yZWVnWHhl?=
 =?utf-8?B?aHVvYkF6M3pOQW0wSTBoaGo2eHBFK0paTTQ4dE1rN3lkaGRXVitOSGxGQzBM?=
 =?utf-8?B?UXZ3WkNYUHBFZXNZNHNuWHhxWmNSbExPajlTRHNwVUtkekxMSEZZR2w1Tm9O?=
 =?utf-8?B?ay9GWlE2VzVEdUZxbFgyRDJVS1lDZ2pWVHRVQzhUTWFMQ2pScjA4R0FEaUUr?=
 =?utf-8?B?Z2h1blE2cHJzc2N1SU5UcnVGRGxLbGNIWUlBQnhjN2hzVHIwUFlNcm0wVGZo?=
 =?utf-8?B?ek1yNjV2OVVjV3RlYmRuYTBSNG5sOEpTT1NYeEI3L3A2WEo0dWtMdHpIUUMz?=
 =?utf-8?B?TVFsanpkTC9jYjRRM01LRmJEUXg3cG5ObEEzSTIrM0dBcWdMNDJDVlFzbm91?=
 =?utf-8?B?OUlWRXNvY24zYmtCK2ZsZUNNM3I1eW1NU0x4eDdKQzc4QjVKYXk4OWc0eWlu?=
 =?utf-8?B?d1EzVy9nSnk0MFhxby9PTjh1UTk4c3ZPOWlSN1V6OHIvYUFRckhJTmwwemE5?=
 =?utf-8?B?MnI1aHB2Wk5sSWxGTDUwcmdFajlGZkpMczJjdXdiMVkwTS9RdmRUNm0vZDU1?=
 =?utf-8?B?Q0M2NXVMa003Y2p4SWo3czlDc0k5dWN5dExJRmN2cmhVa2VDckJ6YUsxVCsr?=
 =?utf-8?B?dGg2LzRXbHBydnlyNFI4Z2ZZVnFobnJqZ3UwTTh3d1BSR1JNVjZab0RTQUNO?=
 =?utf-8?B?ZDR1ZUlDZzYrVWVyczdDVWFsTVM3WTRYcGJYY05kTXEreTNtOEFJTkdZZXhs?=
 =?utf-8?B?eDcwL2dSSUlZYnFhekxCTTg0VWtwTUFwTktMbjBKM3p5RVdZV2tPWW92RUto?=
 =?utf-8?B?ZHg1UUVobjlDY2ZSVVl5bHNBbjdIOXRmSkhPM1hNa0hsVTRoeEpkUmQraldP?=
 =?utf-8?B?L0kyai8rYWZRN0JMUjJVRlpkaklTMnhCRHRNb1BhOUxJaEIwQjNHRll1V1gw?=
 =?utf-8?B?bVpTUVdKejBiMDFVNTJEdG8zSlAwaXd0R0ZQdndpeVFBTVpjNW1UNEpYVThI?=
 =?utf-8?B?WFpyK0ZhWHRCNnA1UzRvV3ZDSXV5WWQ0ZnhMTStOcDBuZnNkRXNvSG9CVWhy?=
 =?utf-8?Q?7oRD9/+zUss=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFNOWlBlZmUzLzBuUU0vMklwNnkxeS9mUmlISWJoREFLYTBSSXFDMU9CNWVP?=
 =?utf-8?B?dDhWM21Sa2Q2bEttZ1NrNUQ1WnV0MDZNbGtlRnNrLzlEcFdraW5jdTBqMVBB?=
 =?utf-8?B?OVI0Tm11RmYwQUM2SXR0OGlvKzUxRnRBUHQrNWZ2TE1aSWQ1UW42WmdXRytZ?=
 =?utf-8?B?SjF3YkthWGxTbGIvK2IyNUUxUXJBaUZ2UjYyeHdISkJJUkFJSkpQMVJOK2gx?=
 =?utf-8?B?NFFnbjdzcVpBc1lDUUJvTmVvRUtpVHAzaFdjUFZqb3I1RnQweU5NZ0RXN2lN?=
 =?utf-8?B?UHJmd1NyMnlVT0Y3MmxORFRGQy9CbVEwajg0U3l0RnZjZ21jU2FEa3ZTakhK?=
 =?utf-8?B?aGMyMVl5NGtuNndRNWUwZXlKMDdFQThTVy9RYU1TU1hsMjZxVEo3SlNBYUhM?=
 =?utf-8?B?OXc0YkJYUk1mLzVUdDhYbjRMMnUzRXB0TXBLOXJWQWduczkrVGhodC94TWty?=
 =?utf-8?B?TCt6TXlQbW1IWW9OZ1VmV1ZoWllMcHJXb0I2S2I2dnZYSXZ5cjN4ZFhzL3ZN?=
 =?utf-8?B?ZGovcmZXVkNyY1RiTG5hMS8wSURLTVdzSEoxbXZJaFg5bEpnNkJCOTRFUE1r?=
 =?utf-8?B?S2I0ZE04eHpjZzAyelFTcmZkSWQ4d0RqMlA3dHNZVHo3cjFmbzFQNWZ1dlVo?=
 =?utf-8?B?enlacXgrcWQrYnIzWVYyU1lVWDFBVFRad3VadFZBYWZJL2Z3R2g0TFNiN2Fj?=
 =?utf-8?B?Y0FLYldkWGVNaGtheE42TWRjSGtqWTZoUEgvZjRFRlNSRHRYZCtCaXo5Uk9H?=
 =?utf-8?B?S2xyVkduU2lTSVBiNWxwTkp5SjNIVXRaRDhycnlpR3YxSHpmdXhpVWZRaTFB?=
 =?utf-8?B?WTFyenFPTkVnTlVMUVVnY3dQWEI4L1J6UnpMbU9EdUh3WWFvZUQrYXliRjVV?=
 =?utf-8?B?cU1ORmQreVJXdm53Uk91Q0gwMUVpeVBWc1hRckdBYkJxbjk1YnZIYlpNOTc5?=
 =?utf-8?B?cGtNZ2tEWGdQSlpPemlxbGtMWHpIYmpRcHorNE1pT3NBOUJ2ellGaWVvR3E0?=
 =?utf-8?B?emNXR0p3QkVva1p0Ny9sSEM0L2I4eVhsSTFmOXdQYjZzRTh4Myszb1NNanBC?=
 =?utf-8?B?OHZaV2FkWHdUTElBYTVlMllOTzdDNEkrdTgzalB4MXN3SndORlNjRW5uT09k?=
 =?utf-8?B?TS85bVZ2TDNaQkZrelBDVUVDR3lGSHA0ZXVuaXpYZGh1RnZ1YUIxZWk1RjFl?=
 =?utf-8?B?TlFBM0luSWY3enE2V2VwTG9lZjZyRk1PQUxjblhCcElicitLdjVjRGJueWxk?=
 =?utf-8?B?a1hiMEZoS09TVWlXaHV6SCtlSHJyUkgvTElnMlhWdGVXTHYwcUpSWTR5MU5p?=
 =?utf-8?B?UlpxTytqbHorUjRHZmE1YmJrQmQ5SldXT3RvbExjakJ3OWlkQzRHWkVQRThB?=
 =?utf-8?B?WkczSGhVNVpOSTM4cWgrVmg0NktsalY3Y09aTXhuenFmdnFqdU5lR2EyR1dj?=
 =?utf-8?B?TWE2Nm91S3BFOHNwWHNZZWRkR0lKZmtYWjBrVExRMWhhVEtaUmo0TGh0ODBm?=
 =?utf-8?B?UHRYWitqaGk0VThLY1VpbkRUOUlwREVjc0xyTlhnVkRZMlNqU2s4T0praVdZ?=
 =?utf-8?B?ald1aFF4cllaaElQazVEOEZnbHdtNHE2V2U2WXA0NEdlekZodmFvZjQxTGhE?=
 =?utf-8?B?dGtOemxkS3d6aklxR3QwS1lWOFhMZStHSmZBeEwydjR3UU5aYklmNkNFeUNN?=
 =?utf-8?B?aE9ycHg1aUpZZlEyelNzZlYyeGRiNW4zeEl5dDJKdW9zbE5QQjhiMkxpMFdp?=
 =?utf-8?B?dmhSVW1JbysvOG9oenBzenBPcmNDOHVWaGJrMHRWT3pwbmYxVVExSWxla01L?=
 =?utf-8?B?Q0huUDczQk4wT3VFZWdTaDI2bDlXUVBlMEdhNXVUR1gzM1hSWTNSWk5CTnQ4?=
 =?utf-8?B?ZGpiZHJQeWdRMStpMktyVTI1cy85cnp5MEtQanBQS0xaUWNzelQvQU1KcG5w?=
 =?utf-8?B?VVczQXQxK2tRcWRQOXZudjg2Y3crdkVwMXFrTTZoZFdRLzVtbGVKWUVxc3ov?=
 =?utf-8?B?cEtoL0JWLzhKSTdoV041aCtienpKVGlCWHB3RHdDN2hJYjJ6Q3l6ekpyYlhI?=
 =?utf-8?B?bnp5K0NiQ2l3U3FCQk5GNW5FMTNTTEdHaHhHNk85V1lsY1ExdkxhWEkxdlB4?=
 =?utf-8?B?L1lNUmJVTERGNERFYXpnZ01vNUxpY0xHSnV0VkpsdThRU0xaa1hPWTVTaFFG?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23f1796-1ec9-4980-709f-08ddde7b0a84
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:16:59.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0DzwQEevna5N19+CRL6klIOBHsMJ9SyjkUxtNAZrgN9EbWdRyfcwpMmCUATo+L57E9Gg03hSRSeFztptNYofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 17:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19762

On 31.07.25 10:24, Sai Sree Kartheek Adivi wrote:
> - Update u-boot rules to prepare secureboot vars
> - Add new wks file for use with secureboot
> - Update Kconfig file to enable secureboot for TI AM62Px SK
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  2 +-
>  recipes-bsp/u-boot/files/rules-ti.tmpl        | 16 ++++++++++++++++
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 19 +++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index 07111e3..68c4309 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -247,7 +247,7 @@ config KAS_INCLUDE_EROFS
>  
>  config IMAGE_SECURE_BOOT
>  	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>  
>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	string
> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
> index 8f41300..77840e2 100755
> --- a/recipes-bsp/u-boot/files/rules-ti.tmpl
> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
> @@ -12,6 +12,22 @@ SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
>  endif
>  
>  override_dh_auto_build:
> +	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
> +		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
> +		rm -f secure-boot.esl; \
> +		\
> +		if [ -x /usr/bin/efisecdb ]; then \
> +			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
> +		else \
> +			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
> +		fi; \
> +		\
> +		rm -f ubootefi.var; \
> +		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \

We should rather use StandaloneMM, just like I did for qemu-arm64 - and
like we did on the IOT2050 back then. Will need a key deployment step,
though, to actually activate secure boot on the device. I'm considering
to add a first-boot service for that. Could even be shared with
qemu-arm* and real x86 targets.

Jan

> +	fi
> +
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
>  
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..29373de
> --- /dev/null
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -0,0 +1,19 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# Boot partition containing Bootloader binaries
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +
> +include ebg-signed-sysparts.inc
> +
> +# ABROOTFS partitions
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_HOME_PARTITION}
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

