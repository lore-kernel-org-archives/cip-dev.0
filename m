Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A5ED65C68
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 09:46:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web10.33923.1731577613721852242
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 01:46:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ab/IDcqP;
 spf=pass (domain: siemens.com, ip: 40.107.21.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tczMPdwRD/QZNoXyo6qzZ2EytmoMF4i0zZTY+shMfgS4ENNxWX+EDvke4VcaarOpNxY89B2TKOFltf9Sst0v7OYRUpw9pciFUXq1Oes+Xr33uIYICCuyaY3cVC6/I7VIZAsLLOeY2vV+jyeAc5Q6jYTpg6+8jZ8lD+GAN9OGi6tPfQBN7/kXdKIU7IwT7dfRW1T9M6OxVTcbIthisWt2qupRAjU86XKUWjO1blZdkZLOC3Mya8J4eDRyLNMBqL9GuHx83ipq48kzc8EKNoFNsa7XsQ0amOS0jiPWiFIaD6WDALxIxK0BGNgMa8lK2V/TPwlFQnmJ3i172suq4glIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIRukBFN+wFpGcywiicHAr2fDwROkDbuoPJ4TVEI3G4=;
 b=vfds/ljO1/WBUAoYh0KSTQGMysBWTXM6dUFllWTkTA5wmrtcjk24T4hCzdaCBWSsHjaGTZUAc9I95bHRbU2u6cv2AHOV0PLmn7/FcNycR1DbfXNxGsBFfb/qtxd6XAFAfhxp9J9YjSG6zTWtVAl1lV0OYCAUfvMgUEaB4w0rRF5Ehy6JUv1AsCJ8xk7WzllSfwC6Ezsd5x8ZQ1PxRdWZSxc0ICCx/SW2JK9ymCqk3U5s6XpDS3kNVfOdpPZtl3ujWvhtWovpZWl0UeeUda51p0efFM0rnlZh/FB91GkXdI5nFLD5vt1YP7fwJecGMXOTMSTFqzqt1BzFMGBtI78zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIRukBFN+wFpGcywiicHAr2fDwROkDbuoPJ4TVEI3G4=;
 b=Ab/IDcqPynLReBjsUkHgLW2YJOdtEFofkkX7NvBzOGXax8BhGu2U3umKWd+bBkxlVZHlbTiukepVMQItGQBwL82f1T9c7/2+U/T/Yw7WBISf5IWVevMiwvQrcIP49M1nHSLuUh6wiFSiySYoPo6zW4VP1JrvKB+t41dnIxrmgRp/WqP57Ld+ifCEf2XMpE2f8bYllTxLYBiQ2Ph9e+KrDZGyoNPUB4Sir3aJXEcpQmEsokciaG6cB7Sa34mf7XVYNGaA7+XtNAYp/A/chXkYfbxTp4EWjH/KNZbklNGwHcZR044oByL1JpKcfi1Qjk7Yzx6hWGfZVDovH3PPhZlInA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:447::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 09:46:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 09:46:49 +0000
Message-ID: <48487163-c6f4-44b7-8bb7-08836bbde305@siemens.com>
Date: Thu, 14 Nov 2024 10:46:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-devtools: remove setting of
 DEBIAN_MULTI_ARCH as foreign for DPKG_ARCH = "all"
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20241114094956.867473-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241114094956.867473-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0229.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 799150c1-ff9b-4fd8-4ed7-08dd049142ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y3lGR2psdEVaT0RuczV2NWRrTUp5MHBTK3JSOXRpenlVVnI5c2R3RWpTcmhG?=
 =?utf-8?B?ajlJdDRKTmlma2JNMkkvREJDTkNHeStvNlF5ekxqMG95UklTRi81YnNUeExh?=
 =?utf-8?B?My96RlBYcVBHQUJCOEtOTHJnSXNMbWdhenZqaG5nbWU0anY0NHBoSVYvUG5T?=
 =?utf-8?B?UGFZZE9TaXNXM2U2TFcyaWNNSTJNRjNGUDlCeTlqeVNKK1lRU0VkTm1ScXNq?=
 =?utf-8?B?bG5NakgwSlM1c2VWNXFxZTd5RkV1cEo1Unp5V1ZoT2JCc2k3OE9tMXNWQk5I?=
 =?utf-8?B?RWpOb2QyZkVVOEpRS2ppd0c5OEpPR1lmUGsxMGpuaHRRN216blArRWNuTWNI?=
 =?utf-8?B?ajhtVkZvRzU4d3loZW1VL2lGSTQzQWhENEZIWUd5Q0FWNjA5NVV0enkvQWRE?=
 =?utf-8?B?OVNRTUdqajB6L29XRmZLSGhsakNzRFBGNk9wbThOVERDK1ZXKys4ejZvcjJT?=
 =?utf-8?B?c242TFJaZzI2KzBKTGpYN29qQnFiV3pRQ2xIdEhMYVJCeWh5VW83SnVuNnNU?=
 =?utf-8?B?cnAwTFZUbEhuNEszdFJmYk5zeVVRRENHaEFGbFNYdU52ck5FYzlXMzI2dVFJ?=
 =?utf-8?B?TlEzTlJrVHI0UW9URU1ZODNrZDUxUnZVYjE2MGFFTFMxbG5EeCtFUncrRVhK?=
 =?utf-8?B?azdCS1NWcTd2MFVYd2pSZWZEM21vZFY1Q25uNzZWbzlXa01MTjI1a1VVc1NS?=
 =?utf-8?B?YjhhM3lwTmdSdk5uRkI4ZTVRcjc1MHQ4ZVVJQ3hYZmVxOGZRY1p4VXgyM2t1?=
 =?utf-8?B?L2ZVK3pJa1MzOFQyNEUrL2V3c2hWa3dlUnF0eERGd1c1aDQyNFRsUmJJYWlZ?=
 =?utf-8?B?Vmpvd1VTOWZTT1poeXlpZWZBSitneERqWmV5NEV6bkRsUUR6UlhvaDhtRTA3?=
 =?utf-8?B?d3MrNDUremxheUl0Ly9QQTJJOCtZZWVZK3ZXNUpoSVFyWHVYQjB2cnRCY0Ew?=
 =?utf-8?B?SXpvenJaUklzNVlUQll6SzVXSkZXNjlwdGM0N0kxODQwMW1CUzMwMEZ2WkFN?=
 =?utf-8?B?OVhBNVROMFFNcWUraWQ0Q2tCREJ6ZDN3UFlnNEVoVUtpTmwwMWh3VnFFSnZ6?=
 =?utf-8?B?eE5aR2VGdUNjOTY4OG51cUFRUkpTQUhKWEIrTTROWjZqdGF4djdPeVpTUzFU?=
 =?utf-8?B?Ynl6aURGcElUNUNhUEJVTmJCWHpjVHZqRTcrSEN0ZzlxekVLN1VmSE5CMzg4?=
 =?utf-8?B?MWNPWEhQV2lnZEw1K1NBSmM2cTg1a0crenVBU05DdGMxKy9iL24wOHFHQnZm?=
 =?utf-8?B?MENHVGhsemZ3Q0dML2sybXRUWU0rckxEVldUOFRjTDZJMVV1OU8rUnVMY0I2?=
 =?utf-8?B?OFJyMG1EZUl4UmhCcFhyellxOHlrWGo5eDcycFV6SEZQb3BpLzNXLzJrellU?=
 =?utf-8?B?QU1EQU9GVE56NDFwdkovc3NRTVVvVWZBM3pGM05BYWdCTWMzeXZhZExvWlly?=
 =?utf-8?B?WlZMMm9rV2NablU5Ky8vQ0loUUQ2T3Fwd1Q1TGppTWI0QUp6VWhpQVp6My9v?=
 =?utf-8?B?OGxkVVIvWWRCSkREbnd6SitwRmFTK0FYSTFMOXh0SW1uckErdVlibWpFMVEr?=
 =?utf-8?B?RjZGenRkL08rTmZWb0VCWmMwcjVlUTNJNUU4VXJVWTh5bVp1OHpRVlZtYkpS?=
 =?utf-8?B?aDFtZVNoM3JTS2RHVERBZ09INEdqK1ZFSUdqbWYwakZjOEpCMm41R1hMaGdw?=
 =?utf-8?B?Q2FRTXNoM2ZvRVBvR0lBbkVvMzhHcGNKeWprVTFLZlNUbE1jdmpPS1Vvbnpk?=
 =?utf-8?Q?76WUL3Sks2YwEoKwMIwDtzUyX3ue+nnBY5252uo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1RQYXorTTF0WjNXdmlMdzc2TnNIRjQ5Zm9tWFhKd0hVUVpsUTJ2R0JFekZr?=
 =?utf-8?B?RnJWemJJWllHeWw3T1RMcHVjYlBzdURRY3pEMXcvR0pQWDNUTzJCaktRQUEw?=
 =?utf-8?B?UkxINTg5VkNMaC9mOHhXTitoR0dIOFZyNmpaVmVyYysrc3k4M25Pa2t2dU1i?=
 =?utf-8?B?Y3BnSTUwdm5WUWtZdGVTTTBVeDlxdmVSYktBU05RcDMwNmhiVjl0dW16ZGg0?=
 =?utf-8?B?K202ajg0bjJ1cXF3ZXdJYThibUcweUZvQ0tSL0dQWHoycUtzaDVnL290eGlk?=
 =?utf-8?B?bXdVeUxZMVEvYzhQOUxKaHRrR1JuUFBxeFFlM3JweGFSejU3TTB1M1R3cDJv?=
 =?utf-8?B?SUJlelAydUl4cy9Tejh3ZjhsZGhBdHNqK1g3REkwT0JzU2hPcENTelBHMndG?=
 =?utf-8?B?dWhkaFBPbll0dkRGbmJkYm1zbHlQM1dGQk1RMXoyQWpGbVlpRW9od0dqdlVK?=
 =?utf-8?B?WXV3Qit1U1UwZ2FoT1d5YzI1VDhaYVYrMXdOSG5CdFN1Tnh3YjRHZVN5amdi?=
 =?utf-8?B?Y0Z5MENKTlpiekZNSHBlYUdFcFUxaXRGWGF6L2tvMFhlZ0xUQ3BhZnFkbkh6?=
 =?utf-8?B?RlJwZWM0dlBnR09BNVp4QnRrbnJtd3pRNFZISnU1eE9SMjNrVjEzQlVMZDFO?=
 =?utf-8?B?RTF3WDJQVmRJU1NPUGZ3Q1phK3VVdjlyMU9nWjBJeTI2MUxIRjk0SnBwU0hs?=
 =?utf-8?B?MWFMKzRBbWUybDBtVTNqQjI1NUxIK0M4dys4ajZpZ0RSenRvODY0aVB1Y0tC?=
 =?utf-8?B?bDJjYVpIcUZEc1kzL0k2QmJWTTJadVNkbnEwbU9BM1JwYkZ4Ny9uM3k0elA3?=
 =?utf-8?B?STVzdnI4d2wvd3FpUHo2cDBsZ05tcGFGOXJRNjNybTBWaUhEZ0lYdEJqUmxJ?=
 =?utf-8?B?eG8yMm9VTXpFanRkY2UxZEM5S0NvVWM3aUlGZmIySTdDbm1GWXBjdDFwcnMy?=
 =?utf-8?B?WUgrQktoVGtJTW9PdGZjTDNNWkg2RkNuQTNCOTdndmFrZm1aSXRueFczRTNt?=
 =?utf-8?B?NGpGYjYzcHF6NkU0c3drRW9kT1VnTm12UERJTk90NlROWEJkVjBia1JLTmoy?=
 =?utf-8?B?dHlsTkt0bGg3TE1SN29iYlduOXhoNTNMUndaQ3VmQ3FOYmVWM1paSFErVVhC?=
 =?utf-8?B?Ukdhd3FOMHBacUFjaW5ScUgzb1k5TWdYaklIeWpzT1BtMVo4S0JrVkZxbUtL?=
 =?utf-8?B?VXNoVlFvT0Z4R2hJNVdqd081dXVtTDV1Y09UajRMbEczTkFlRm5qRGwrUEVG?=
 =?utf-8?B?NG52N2FuVzM0bmNOY1NlMlVPTDE1RFloa0hpYVNFZURWNjFFRTZ5enNmZFFl?=
 =?utf-8?B?Wno2YmpaL3lma3FBaWJmN3BSTE9vWEJPS1cyd0wwUVhGcVUrTk9rZy9aMTV1?=
 =?utf-8?B?WFhWell5aDFzb3VSSlBDWVh2b09WQ1hxM0I1TE5zK2lFelhvL0l0aldUMnA3?=
 =?utf-8?B?OEpHYVVXRS9BdzJ4L29VTk1xUGxnQmtjZUFkZU1JYm1GSU5KOHR1RlBiVGdk?=
 =?utf-8?B?aGV5VTZjNnN5ZU0zRU8vb2tTbUFxUHFRbGE4VEk0NGF3aVBQbkd0L1ZMVmxZ?=
 =?utf-8?B?cDZKamczMkcvKzRMN2tTZFBHaUlISnFXdklsVkErOXpleXZOMnJFRjlXaDhF?=
 =?utf-8?B?SmRrU2JHNzEyZmJDRFcrR0FvSlg4b0hGNytENXlFMUVNU0tROGJkaWM0VGNk?=
 =?utf-8?B?Z012M3QyWWNPQlFrMDBjNzIybE9Sb1ZzajdoUWZpRUJhTHZNU3UzSGRCT0VJ?=
 =?utf-8?B?Qi9hYVVyQldYb0tseTVtOFgvNTZRZ0xubC9UbVlieDVEcEdWM2F5RStWQ2tK?=
 =?utf-8?B?YmVJUHZVNHlBQkpBYmFvM3hWK2RLSmhBU1lCNFFFN1VrYm96d0plVFY4U0k5?=
 =?utf-8?B?dEY3OW5qQkYwTnYxYnhmajBFemlGemFvS1UzSlUvaTRDZUpSQUNGSkx0RFRT?=
 =?utf-8?B?ZHl6aVcxYlJheUdLWnlLeGEvdlFDZ010eXkyK05VTmR4RHYycC9ocGhsbzRL?=
 =?utf-8?B?amUxWkhhc2k0bS9VNHhEaVM1Tmt6dHhZam5xcWxUSlNUWjBFTTd6MG1oUDhS?=
 =?utf-8?B?TnR0cjVEVHlZakgyQ2RPSjdPcEl5aDRnNS84YnIyRjN4RVJJR0hsSXA2QWFn?=
 =?utf-8?B?ZHBMbEdObkN4MlY1aUhadE5mMFhOZjJYWDY0RzVHdHBzcldQV3JHTDBKanBw?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799150c1-ff9b-4fd8-4ed7-08dd049142ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 09:46:49.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0V/TXhX5RowQ95D4t7RciP90CKnxgGoOE6XG9S/L/8HGJFR/Hxh18t++GBkkfBmclJGhElbY40ROky7mMF7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Nov 2024 09:46:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17255

On 14.11.24 10:49, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> If the recipes builds for all architectures, then the default Multi-Arch is
> foreign, which is provided by ISAR, hence no need to set it explicitly
> in the recipes.
> 
> Ref: https://github.com/ilbers/isar/commit/0816ae6e
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb         | 1 -
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 -
>  recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 -
>  recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb      | 1 -
>  recipes-devtools/swupdate-signer/swupdate-signer-empty.bb        | 1 -
>  5 files changed, 5 deletions(-)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> index 88512f6..83289d4 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> @@ -17,7 +17,6 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  DEPENDS = "secure-boot-secrets"
>  DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
>  DPKG_ARCH = "all"
> -DEBIAN_MULTI_ARCH = "foreign"
>  
>  SRC_URI = "file://sign_secure_image.sh"
>  
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index f11e93d..c1fc12f 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -12,7 +12,6 @@
>  inherit dpkg-raw
>  
>  DPKG_ARCH = "all"
> -DEBIAN_MULTI_ARCH = "foreign"
>  PROVIDES += "secure-boot-secrets"
>  DEBIAN_PROVIDES = "secure-boot-secrets"
>  
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 2532de6..43668db 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -14,7 +14,6 @@ inherit dpkg-raw
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
>  DPKG_ARCH = "all"
> -DEBIAN_MULTI_ARCH = "foreign"
>  PROVIDES += "swupdate-certificates"
>  DEBIAN_PROVIDES = "swupdate-certificates"
>  
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> index 3600c3d..17e64ad 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
> @@ -10,7 +10,6 @@
>  
>  inherit dpkg-raw
>  DPKG_ARCH = "all"
> -DEBIAN_MULTI_ARCH = "foreign"
>  
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> index 8522e5e..a999182 100644
> --- a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
> @@ -10,7 +10,6 @@
>  
>  inherit dpkg-raw
>  DPKG_ARCH = "all"
> -DEBIAN_MULTI_ARCH = "foreign"
>  
>  PROVIDES = "swupdate-signer"
>  DEBIAN_PROVIDES = "swupdate-signer"

Thanks for the cleanups! Applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

