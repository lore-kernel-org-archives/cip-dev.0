Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F841C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:50:12 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.49])
 by mx.groups.io with SMTP id smtpd.web10.94653.1738605009636293669
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:50:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YVhPAcnd;
 spf=pass (domain: siemens.com, ip: 52.101.67.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnKlux8PAgJRLptRRW68bzEUWDBKLU5i3YTWBULvnP/PZgRMGWmy44RV3bpFhDNOkYlSlUplY4dCRg6+e18OZFNv45z4MfN/VXces8SjMtagBHINcK0QfxgQId3h9fnTt0BO9R7y/NYYa6XqCdVn42JpDeoRGy6w2kUZZs2qos4Tf4Dqktv97VGir9I1mfjQitfiIjjpuvDGAfNvjSBqgaR9lK3kzkXlIlrmauBXPk6quTAjhDKH7Ol8yykcMDx+O/NCSPDtl3IVGz1ufchBGH54yS63eTMGmouqMTAKaaZ5qULWgb3YbhJhVtEvBpx6TvPU8eFzglHyknSvM5AE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3b9ORbEy+8Bl4g8roFYa7tqez6Z7P9Qvu/6N+99Wmg=;
 b=H8EZA7cqZOYkN70X5dlXfZuwPtli+U1xwjxiefLHzH51Yz1p8PzXZOgvkq1XnKcrcqsUvb2vCcjnduxqm9iwDC4fp+kh/WIGoHfAbadBnBRhRwaXpgSLet4BI0tKQP7Kw9jdf4h9e1i7YMXdrmtmD+D1yBB4mlSQGg9zsnMHLNXNTq0FQwadc12uNV+G5LkU7CfVxlWM9y+PChEbyPKTDgiGSy0UjiSAawhdCWQVZoP8XRKPFfE5sJAKkcyFEmuGeZshwGiYNbG4CZXiClUhaFP//siGkv36FQXAnfbg29PQjgZm11kx9+4ozCCyVZkc0sKvEuB01aQfo526C4t4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3b9ORbEy+8Bl4g8roFYa7tqez6Z7P9Qvu/6N+99Wmg=;
 b=YVhPAcndi6Fz0GbnXhj13wisV+NpG5sC/c4SVP5brw6EGaYlx2kI29DvufyouZ0zv67NnSKNvCqXr5BmELBLqK6iagqzEHfEAMehPG6oHH8iFZm/sYb3DVv/BbmbYy2Ra18Z7izsJmtH6iwKQcnuMFe98sRpndOq5q6CCf4FpnBdH5NmNfAdWwKSgqHzTXY5I8pNfXTEtdLZBIQFzAJnWIL5qvjNYnoEIW14nJxH1r0O2qY32l2cdt/9pjxAvS7wdTkZLsvQnVGNedkEYzn2LSNJ0awzeVlmuDMz+Qz+ToQwTg20wSXF/K8eT2KpMsL84SGcGLt604u5qOfVRC3GpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 17:50:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:50:05 +0000
Message-ID: <9115f084-11b5-4a9e-b442-0ced50760736@siemens.com>
Date: Mon, 3 Feb 2025 18:50:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 3/4] kas/opt: add new option
 for security testing
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250131152553.270393-1-Quirin.Gylstorff@siemens.com>
 <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2393f2a4-0b27-492f-b6f0-08dd447b3167
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlljQy81ajJMYStZc0tYUDdzSDMyMFFwNExhSVFvNGlkOS85L3NMZVlERzBW?=
 =?utf-8?B?QTJCbzJSbEV2Y3VKS2FXOEsrS2djSWZpbGdVdFc2eEZSWXh4dEVxMENUY1JO?=
 =?utf-8?B?NHNmZ1kvcHhGMnowTUcyV1c2Z2U3dFJ5L3YwOGE5L3kraDJid2VJaGE2Sldr?=
 =?utf-8?B?WjhFZXAvZ0dEaXVIeGh1bXRta0FqSDYrNm1WNlAxNStSQzRLdjQwVTRGWkx3?=
 =?utf-8?B?S0x6TklnY09Dd2hCRVdGTTRUekFGTVVkS3lVcHVWUzBjQ3FqTzhwNC9xMmRr?=
 =?utf-8?B?UkVCWEVnbmZaZkNSSHR3RkJ1aTI4dlhta3ZndlVZanUvbUF1R1JlcUFxNThD?=
 =?utf-8?B?Z2hpMHllV3k4b3RETXdCcEZSUk03aGQrVmhUekhvRW15UytSaXlkdStTdFNY?=
 =?utf-8?B?R2liVE1lYjFyMm1nVGx3aHpnQUtQOVlwTjVYbFB6UmRBN3JPeVRsSzhWVE9C?=
 =?utf-8?B?c3E5c3EyRlNZNmI0cWhRWUFxQ0Z2OFJ1NjBqSmRkWG1oRUszVy9IcFlhMzFG?=
 =?utf-8?B?dUoxaTI4bGtWL05wS2VSQ3JNZVFwTjkvQmVsa3piWmZBVnkwU0tEaVIxYVhs?=
 =?utf-8?B?cXdiSTRDS29zTXhBb0NsanRESzNVVGdVL3B2ZTEvdU9OSGx4WWJScmZCTndz?=
 =?utf-8?B?azlsbE9QVnhJVHRIRVBOZmJ2TnJFYU1lalRiTlFRME4yTWxBcDMzZWJ6UTIv?=
 =?utf-8?B?V0hKWWxUVTg4Q1FSZzRGSWNCNmp4UXJPeEZYRVZBNm9OMnVBNnFsOFAza3hs?=
 =?utf-8?B?b1ZaUU9IeDdYbVRtYXBOUkNuVmlFd3hnSUhMYWp1UEl0SlBYNmFLUjRDUk4v?=
 =?utf-8?B?ZU9CMEZSWk1yMmxFWGFBTWdUR2I2UWVFOC9FT0cwbkxFcmFiWjlxS0x6SFgw?=
 =?utf-8?B?b2huTE1kb282OG9ncWtFL0JVOFVnNGxQY3U5Q1ZDQmJqR2tteHBVZkhEM3Fp?=
 =?utf-8?B?bEVCT0pGeTFKeXJmQzNUbjFSN2h4VTZMbE9va1lTdVdGYnl5ald0cE1OemRh?=
 =?utf-8?B?V0VoVUM4ME9mMExSWU5wMFlnWm54ZC9JcmxJR01kY2hmYnFUZVlVeXJwUm4x?=
 =?utf-8?B?bnZUbDlqcXJ1akd4RE0wb3owRE4zMDR2MEpqckxpbGFaaUJlNVZ5UmQxanZl?=
 =?utf-8?B?N2xBaHhvZzg5Z0FBOHRYYTU1RVYyK0lWYzhZN2x6a3VINFd2ZHlrTzM5YStG?=
 =?utf-8?B?QUtmejBPSHdoTWdqbW1zUnh6bDVlVURqY3RqNE1EWXVDbm8raFN5aXpObWRq?=
 =?utf-8?B?Tk10aXhpT3NrMlpieWpWSHVYQzlwVGlaM2UydS9TL2U5ZWZsenBoQTFrWGNQ?=
 =?utf-8?B?aUlUbDFHOHRvMEhiTU1mRGxwL2Fnbkh5SUdKK2VDSndxNDJOWmsxenZsYzJr?=
 =?utf-8?B?K2luSzBLM0d5QXo5R0NTL1M3NzVrL2RCL2pTaVd1bGtPcGhKTEhNZHlEeklU?=
 =?utf-8?B?VkdxRVU0RDZMbkZ0NS9iakpja0JiZFVOZjV5SXRBN2YxaFNPRm90VVIzMXdH?=
 =?utf-8?B?QU5pWUFxQzVncmdKZXRCZWtnUHRDTHJkdWpuN05OVHVDMEVvdVdoZDFZNzFQ?=
 =?utf-8?B?R3ZMVmc0dWRKdnNVLzdnSVdvUWpiYTQvcjdaeEpueXMxOXBCTXQyVkFYeVls?=
 =?utf-8?B?cmxycWFIdU9vYTYwZzVDK01aTnNMbUI4YWgxaGY4WC9LdmtRR1pCNFYva0Vl?=
 =?utf-8?B?NGt5Slprb1IxQ0F5QWFtN2dVYUN3S1BuUEtoVnVUNnRiaHU2MXJHMWdtZWcy?=
 =?utf-8?B?UXgzWmh3N2ZVYi92Wlk3dGlLYzdCQ3lBd1lXRVVLTnp6RXMxbklTSDhoQmFx?=
 =?utf-8?B?ZHBKdnpxQzhqREQ1OWQxWnJIbEZ5ZkwxQ1FMekVmcDUranluVGxNWGJFTWRy?=
 =?utf-8?Q?WCAfqCD30DIVu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUZCWVhTVnR3U3B6aGVIYmZDVzlBWU1VUENocXZjOTBQMUFET2dKelFHSVkw?=
 =?utf-8?B?NWo4OXZFbkI5eUxmVHY0eXVtSHF0ZVB0SUwxN3NXVUd1RU50OEh1Rlp0TFJm?=
 =?utf-8?B?V2FOWUNBL0c5anJwdEJxQTdwcXRRM2F0VnhPUExVRlB2aFdwbDloSTdIcWpM?=
 =?utf-8?B?UkhmUDFPeTlyQnJwTEowWGw4czQzbXFJb0YzYkFoREpyTGJ1WGJlSzNaMlNh?=
 =?utf-8?B?SmNXNzc3YlJTMnExbTZpTzc4bzlXU0pET0NWY1RPQmhVQUJwSThVWnduSnNl?=
 =?utf-8?B?emNTS3dyaksyaUFkSmF2a3NOaVlqYlNNbXFZWWRySVZtdHh4RkdaSFRJNmM0?=
 =?utf-8?B?Q1NNU1FxcStTRm1QUmZmSmlvTFFqaWdCYklBOExnbUJJTjdRZk1KMDdpUHhQ?=
 =?utf-8?B?UlZVTnFBcmRXTHRYZGpDY0l6N0VFMGsrOWZWaXZwdHRXdGowQnpGVXlzbm9n?=
 =?utf-8?B?dEJXVjFRZVo1YXpLaVpTckg1bU9uenNFRTlVMFo2UEc3MTQ0VFErTDRWaVNB?=
 =?utf-8?B?WjNsQ0sydUV6eXoxQjJCSWluVU5RT2c1bHJ3aFV2OEswN2JRRXp0RWROL2py?=
 =?utf-8?B?cWhXRk53Y3RORFNhVVhzY0MrTjArRHJTdFFpcGZFV1d5WkhvRUxZcW1pVHZz?=
 =?utf-8?B?d3VYVm1lUjF4YnhNK1hvaGlYVjVDdUIzMkcxdm1rOGJZUzV2aDY3YWk0SG9K?=
 =?utf-8?B?bkFpemgyS3NRRmFxbTJQM25UNkdDQzZISDEwLzBoS2x4aFV6TDZSd2doWUpt?=
 =?utf-8?B?bDJTRGVKekh6eHVvV2dUVUtBeTdNcDVwMGlVaDB4TnhNUVpPS3lWU0luUTdP?=
 =?utf-8?B?WlBtN0p0bHJkc1BlUEErTjQvM2FydXNxMlNZR2ZFUXlUbFVJS3VLZkNBVmFh?=
 =?utf-8?B?WEdHZHk2dTM5aUMzc08yRXJJZGg5WXBrbkVKeTV6N1V0VmFrSDI1R2VtcWpV?=
 =?utf-8?B?Um5XdnRxVDFzckV3dkNjeFZWYVdtTWMzYzUvaUMyYXV4WEowKzN6RDBDRy92?=
 =?utf-8?B?blBDZlhwcmYzd2tMT3ZUSWQwTmw0emNDRUI1WHR1akFsVjdlZmNib2EyU3Vn?=
 =?utf-8?B?WVJ5NHI0akhPb1ZZOHpnc29yZlB6bFpyVUhIWmUrWUFUOU5kOW1PM2lsbS93?=
 =?utf-8?B?c210RFA3Zm1pM2s3bHhxTWFsNjZuNkdTd2RDN0cwNG04YnNsc2EvUGFzdWFn?=
 =?utf-8?B?blFrUzdONlR2YnJUYVYvVXo0ZjVxYWdkN0VlcHFUcUdzS211SGdCQzNxRWdx?=
 =?utf-8?B?c25pNkUzWndXWGtmeUd2UHRFd25jMk40bUhVMGhjdjNMRkF6VlpEbVdpWldm?=
 =?utf-8?B?OXp4NTI4UEdUc1FKeHlSaUJqZ0tJUjVhZk9wbmRVeStwOW9EcDJtbFRUV1Qx?=
 =?utf-8?B?NWFjcW9uZStnaEFpYlYwK2RFNnl5b3lzR1M0SjBLbXN1ZXVsQ2lKUlRBdDhh?=
 =?utf-8?B?Z1pWb01IQndjWXFKaUw2MitJVTBSVXFKUzJyMjdQbFNCcUVnTkdnNHZCYkpK?=
 =?utf-8?B?WWZ5VHEzb2toSmwxc2VZaFlwN2ErQWZjM1FaSmsya1hjMFRzWnRubzBERGtO?=
 =?utf-8?B?NGtZV3JjTGdpUy9IeDZlb2JDWFRBTWJ1bFJRcXhNWEFZV3hZbjRvMytkK1VV?=
 =?utf-8?B?UHhBc3U5anZVek16U1NoWFBMSEFHWWFjMFc5dXJqbkdYT0ZvRU92dW1Ndysz?=
 =?utf-8?B?QkFNOG95KzVMK2VuTlRvKytneVhnSGM5RHlhUW8vcTRuT3FMd21BTVQzVHFY?=
 =?utf-8?B?UUF1UHdpaFY4N2M0c0wzbjVaVHBhZnJqZ0hBWkVhRUNaMDZDbzdPaE8rRk5X?=
 =?utf-8?B?dkMyV092ZnU5dE1XbjFHMXFUVzlBbXBiWXN0akxBcjB0ZmpOVy9TVFBBeVl4?=
 =?utf-8?B?UkErWEFtYzFCb01oam5HMmhzR3ZDRU5WZmtuc1hPRFZidGlyaVhKZnp2cXRs?=
 =?utf-8?B?US9UcHVOejVjdjYxajdqT295aFYvbXl5MVFvc0ZselNZR3dtL1hGSmFGemUv?=
 =?utf-8?B?bWxoMjd4N3FIYVNMZHV4QlpFTE8xcnc4akRqMG1ZbCs0anp6Z2tFY09YeHhv?=
 =?utf-8?B?OVV4dThLWW5mZzNKRVQ3aGxXcEFiSlNBd2pDcm5TUnpJcXhkUVBVVjh6RGxp?=
 =?utf-8?B?STBrY2o1MXA3U2ZYV2orUEZoekVnWndwdTFkZG9UY1ZvUkR0SXNMWllDVVFv?=
 =?utf-8?B?Tm9SODV2RitwV0I0ZmEzN2ZQelpXNXlyRFdOMjFCdnVnb0dwOENUTnBoM25s?=
 =?utf-8?B?andYdlhTK25MTGY0eTJlOFF2VHF3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393f2a4-0b27-492f-b6f0-08dd447b3167
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:50:05.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKzcglw2Ik6eG3zef+35t6LzR5ALzpsqiIqrLiEsipYr/SWDMErmdOrW9BEeiZQASsMiMTQbh9AvqqTqGzLvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:50:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17738

On 31.01.25 16:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Lava generates an directory, in LAVA called overlay, which contains

a directory

> all scripts and tests of the test stage. The Device-under-test

device-under-test

> needs to be instrumented with with this overlay.  LAVA provides the

with too many "with"

> possibility to download the overlay via http or NFS. We use curl
> to download to the overlay from a http server.

"download it"?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml            |  2 ++
>  kas/opt/security_test.yml | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 kas/opt/security_test.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index dd4baf4..d7055f2 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -65,6 +65,7 @@ default:
>      - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
> +    - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> @@ -251,6 +252,7 @@ build:x86-uefi-secure-boot:
>      use_rt: disable
>      targz: disable
>      watchdog: disable
> +    security_test: enable
>  
>  build:qemu-amd64-swupdate:
>    extends:
> diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
> new file mode 100644
> index 0000000..73d22eb
> --- /dev/null
> +++ b/kas/opt/security_test.yml
> @@ -0,0 +1,16 @@
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  lava-testing-add-curl: |
> +    IMAGE_PREINSTALL += "curl"

:append

> +

I just found this in doc/README.security-testing.md:

"To run `cip-security-tests` the image should need additional package
`sshpass` and rootfs size should need atleast 5GB, add the below
configuration in kas/opt/security.yml file"

Is that step no longer needed, or should the new security_test.yml
actually include that as well, simplifying test setups?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

