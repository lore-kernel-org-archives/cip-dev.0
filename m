Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45103D24479
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 05:42:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.80])
 by mx.groups.io with SMTP id smtpd.web11.5022.1728625346213392927
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 22:42:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LNDQQhQb;
 spf=pass (domain: siemens.com, ip: 40.107.20.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=secyEb7mkhE8I3Q3mtHGJONqm35Pv+IZsQcR206eDhXPultLb9GPTYAHmuhYjBBFbRu8zQoEZKK6ZrfrL/+CpwesQFcaxjGEVvuePkTdNlR5jz9IFgDMAQQaLwW+kmH9nmE5rqAon9x6/uCBWoqUkxNi4wppMwbD53H3RGdzD2b6jhifebRcRfeBGm3RLTkOBeofxGmd+wj9PBv/Eu5OeJtJwr8B7A4iMlowmCi2xZoP/J31ZUvnLboXfZdFxTJNywHSUl6t4CO7dPBQCABELpfgLxUd1FdGSgSpMYOMXCB7L9sK5s8O0o9bCUynMxZ4PkrZ/pG6P/gXzVpwPiSg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QqNslxPjPlAb7mUikqbslGhDUM0aRBVg2S3JCazQ6E=;
 b=QYadJVGbhSVrT2+XRhPRTkcey6FL21zmht+QX/HzhUPxhPzWIufwC6cb9pTukB76Ez2wNwApaPGRM6vyEatdFfCUEQBEbygtCHPRWlGyPwDL3qmzAP76Lu5Mndr2hDthrO5+u4vGmVCEHRxdR8jW03U5mxFiv9rg1MlKdBVRrYitph97DQQS8jll58PWfPXnXnltTC3xSR1fnUKfSDAb73ZFPOPx1CJrRfcMowQ7obAYhmoPClKce5gc74Ls+vvlzUHQpUQngUf6H0oUb80/YIJdAkDglvKm4vUDk1VslW0noryo8o8SLMoYiaJPqfmosYtcY6Fp37SNlRi9ejb2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QqNslxPjPlAb7mUikqbslGhDUM0aRBVg2S3JCazQ6E=;
 b=LNDQQhQbFoROKuyR+wZZLT1SVMvwuoeQRyhiwCZBJeXQLfSa0nYskKvg6xwNuZTG70nWmp15s8azu+wAw2vHyTf00jHB3sEjDS/o7IqDL0rVzRx1lzpoMkeSxakCrlb9W1T17hxTgh1lBm9vyG1+tJJpD7MnmIPOQCZiONNYI7h9u+IeQnUGr9xYyQKHsKFGy4/DoukcBztw3iXoDvke8sAIESwOlws0z/YBkEch33BivseAkrWs9iiZMmm7BW6SI3/LpOrjB9AvwzJUgdRbwkrhK8lgG+wXyR048XtERqqHh8uJDr7PMpd85JJErUcWzcNrQ82I4qdCu9vuWKOTXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 05:42:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 05:42:22 +0000
Message-ID: <dd0c8d57-afef-4bb3-8c77-8519a6dadeac@siemens.com>
Date: Fri, 11 Oct 2024 07:42:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: Update to 20240930
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1728611688-13663-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1728611688-13663-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8911c2fd-69ec-4dd6-d95b-08dce9b77a8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0tMU2kzM2t4U0o2aVBGbHVSdUZaa2M3bzRSSzZjWkhnc0ZrS2ZKK1A2OGxo?=
 =?utf-8?B?WDcralJqWEQreHRQZis2NmRaN3Q0TVhFdVlVRDF0R3Z3blJmc2krcjRiWE8v?=
 =?utf-8?B?MjhIV0kvcGkxN3ltb3dMWVU3Wm1yVnRiOWNJelVtV3RBN1VNSXZqZ2tRREhU?=
 =?utf-8?B?a2t5eU5vajQyL2JtbkJGUkx2TFR2SVl6bmlmUmJHdEt1OGFGcUUxOHhQTXll?=
 =?utf-8?B?NkNCUHQ1ellFSVJ1RHRYZXl0TFE1aWV6U3lUVE5veUo2MGNXa3UveHRMQUFj?=
 =?utf-8?B?NG9DTHlDQmVIWHhXaVY1UmhGR284YmsyVDFVR2hDaG4zR0Y1bjROWk5DbVdn?=
 =?utf-8?B?UEQvcXlXRTdvMGIySUZVanhMaHBHc1JING1Ud050cDQ4SWt3R1hVRlFvYTBq?=
 =?utf-8?B?MmlpN3JWZzNRVUFLNjZNalZIVTNTekRpcUNuVUpBRGFvVVppMGdFQVhseXY4?=
 =?utf-8?B?ckZZYkovMERhdnhXV3dvOThLd243VmxRYVBlSnZubVorVGdFUkV3Qk5ra2Mw?=
 =?utf-8?B?cG1OY3BkQnpGRHFwNE1BZ3BjdCtHTHFaTDNkSXRHb21MMDE1bDBLaS8xWFZP?=
 =?utf-8?B?ak1YVlhXck1QT0lJYWlkOVVSUDBGdHhpUkgvRk52WXdBZkRhZDlQMFdwb1R3?=
 =?utf-8?B?V2lYY2JlaGloZGFWS24zZHgwbnVUTkpJMkhvWUNpWEl6L25Hc3BLa3hnMlhr?=
 =?utf-8?B?ZHBCdHZuL2xPU2JBVG1xN051aFhTSng0KzR4TTZXRjMyeWc0UmU4T1VDWjZz?=
 =?utf-8?B?ZW12MHF5UXZxdnMwemg4dGJDTUM4QUtEVU1PbWpZWHZ1S1RZajMwaFVxL01D?=
 =?utf-8?B?ODNmdGR2cTh1VDZTQVorK1VKU1g0VDJtNm5KTEdheVY2aWhqalppSXhiQnFa?=
 =?utf-8?B?dWFrdjZXS3FLUDFoejhRa05QU3AybWwwK3VwWnJGZGJhS2hLM0tPbUU4RGpa?=
 =?utf-8?B?M1dPS0gxS3I4cEdNWERtcXBQSEh6WXE1Z25KL3Z6ZGx3djJKbzd6aHdGWitU?=
 =?utf-8?B?dmJlVTEyak1ZRFRJWnkrUWp6dGpBS21sRjR0b2xQVlA5OW1GSDNtYmo1NkFv?=
 =?utf-8?B?WWJaMzF2WTE4aFFLV3NET093azVlSzBjMVRzeVZJR0N2bW1pa1c0dFhTUS9Z?=
 =?utf-8?B?ZlBGUUFsSUxNUE9RMVltcFZDSWsvQkFpS0NoRzZueHVwUkdqVE9BeGxFblRN?=
 =?utf-8?B?ckpWYkdCMmVTNDBEMnNzWlpiYVlHVjYwMkh3RGxINk1MeENOR0ZkZTgrcy96?=
 =?utf-8?B?MHh3UUoxNk5GS3FlWm50RDhqaGx0ckxIdlBjSmxtTGVkUUtiNlc4YjNDYldo?=
 =?utf-8?B?UWtyWXhxaWQyZDBnVTIxU1AvK3NScUZTR3AvNGgzOHNsYjBxYXlMRGZkajNC?=
 =?utf-8?B?bnZUQkt5NlpBWU94ZHVETmJQSVB3M0lkbFNqKzBLSGdoeFVsbWFweUJPN2Na?=
 =?utf-8?B?ekFuSkV2WEdFOEUyOExsbHVnUDJ3bml1RkZNdTd0UWZ6bVFaeUJpNHcrMGQ5?=
 =?utf-8?B?bVZNcFBLcWNVNzBYYUU3ZDFqNVpvcmFUTWFCZWUxanhqVG4vbXRSWFI2WXF1?=
 =?utf-8?B?Qk1qN0FvWjlqcjlncFYxcEZ1dDZCWkUydW80d0w1Ump5WllZN0pPMmhSWkVG?=
 =?utf-8?B?endyR1piSTF6emk4MnVMbzZwSmlWeHZ0dlEydERmUmZWN3NCcFZWMFUxZ0Zy?=
 =?utf-8?B?ckxDbkgxQWE1Y3JqRjgySkdCY2JTSHB2YzgxUDBDZzlLcFQwUk9Tak5BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlBxNFYvV2JEZTN5UnQ1V3c3emp3R2pPa2laQW9WcmIzTGtDQU1nL1VzeFNP?=
 =?utf-8?B?Y0p6UDk4Wk5CNnhmUjZaN1pmQU5zWTh1R3VLNkVKNWVLK0RkMGRFekI5TExz?=
 =?utf-8?B?NlU4czVVTHNFMW0xWXUyQjBhTWhSWmYwenVpTDROYW1kaDR6MGFQVTZ1bXZw?=
 =?utf-8?B?clhyZVptSWdNZ2VjTzYyY1ZQVmNJeE8wbFA2REd3VnI1VHpDeHoyS3Vxcm1p?=
 =?utf-8?B?dXN3RDhvcHR4dU9wb0E1eXViUnBrNDd5Zmp1U2JUM2h2aVR6blZZeXkwVkFw?=
 =?utf-8?B?Yi9YQzBYSHQvUEVuQWpFRFFQbmJHSUNRQnN3MEdmalpqWU9hK29NaHRBSy9q?=
 =?utf-8?B?L2J1cUV5VXZLY2dEWVF2QjVJQU9Mb2Vwbm5mUHljT3kvcHNaMC9qMHA1VlNq?=
 =?utf-8?B?dHk4SHpFa2hSc01xN09DczVBZEhjMURBZ053N2RIMGZBUFdaUk1XWTl2Tk1L?=
 =?utf-8?B?V2dvQWlzbkRXRlp5VmpIM0xmOTJJYzBCKzZEWVJVNDRNbThOTUlOU0tqL1N4?=
 =?utf-8?B?TC9Gcmx3d2FXRlJIbWtCU0xwQTk1dTR3cXJteFJIZjNwQnlGVXk2YU1BcUNo?=
 =?utf-8?B?eDF1c0hLVXUxM2NySzJ0NnVaL3U3T29VcmNma3AwUjdaa2E3eEZpYzFkV1py?=
 =?utf-8?B?UVQwdHk4WXo1Tm9oNHFEcnlNOFNmRWxua1ZWUC9TNDV6Vlk0OGYxYTYzQVVv?=
 =?utf-8?B?Mko1MU5wSWtZeEZ1d2p4dStQd003MjVJay85YW9kYTkwcjVVc2lhS3MxanF1?=
 =?utf-8?B?bisrQWZVdTBkcFA5eGxvOGUrOCtUMUY0Yk90RWxOTWg5dFhuZG8wTVUxUHdX?=
 =?utf-8?B?N2o1dlNXdERveUxabGpmQUplbE03djhSR0owQmJhT095Wk1CVStodzVyK0Zn?=
 =?utf-8?B?NGIwMG1qL1MrMDl0ZGZlOGFuamcrODM5eTN5T1k4bElFVWhpRWJQS09aVUVX?=
 =?utf-8?B?YUxxS3lXMytBVnN4VGVoOHEzZFpXd21nbXdzdE1HRlFnWGVaQkJ2dWxabzY0?=
 =?utf-8?B?Z1BHbmlRNmovaFVMaDVZM242S3hhUGE4M3pSaGtEYWpZdTQxTEtLL0pyQjd4?=
 =?utf-8?B?N2Nid0E1czVjanJCcHVPTHF3ZXJ0djNLd05FNTlmWHNmTjFPbkw4MUtXVk56?=
 =?utf-8?B?SjU2eU9VWU5rYzdVRldSVzN6ZWEzZTgwYTlkVlZMVXF0WTFwZ1BhWUVJSWxP?=
 =?utf-8?B?V0pnRUk3N1BIcUxOLzhJNS9TL3EyWXY2bi9UWHBqTURETjI4UGNjMk8wdWJT?=
 =?utf-8?B?QWZQRTZVbnJhMW9IMm9XZ1RFUmZDSEFTZnFwMmx6SWxuREw2QnlpOWxsMk9j?=
 =?utf-8?B?K2VwZWJaSXZtcFk1VEs3VXNXcDdTQW9Sd2hqS0d0NXFVc0pkSXdocnZaYzFy?=
 =?utf-8?B?ZTNjbUxZNUZOVTRRRHdVeUc0d3NUcWJmdzFuNUtBcGwwSHVSVVpOYnYwempO?=
 =?utf-8?B?blhhSTU5eVpaaTZRdnZZcjUrMGUvRHl2dnFLZEJsdkN3Ulh6bWs1NXpEalVl?=
 =?utf-8?B?UW92U2wrVGtZV2R6K3AvSGpkL2x5MnZsQkl0SU9HczBDeUNkRVpoSWplNDd3?=
 =?utf-8?B?bVZTMmoyZWVpMStPbElJTHlxTlI0ZWp2UUJ0ODhFMzhZSm93MENDb2l3Sndk?=
 =?utf-8?B?WlQ5VjNEWUxTQzBFK3UyRFI3NDJhaDRqeTNnZ08zWVhlMzJWRzd4SVNQL21l?=
 =?utf-8?B?Vk5nOXN5OGFmdnJhbUczNW1VR2o2UFVuamcxY0tJVGRtcmV2b1RnaTRKK0NM?=
 =?utf-8?B?SGxDUG0vTmVCSWNCTm9iSmhXbUMwaWw5YkVadEJZQUIxZFJ4a0FKT0RONTVv?=
 =?utf-8?B?V3BqSjZHSXFvdlUrU1lGd1lsN3YvenM0YmRKRVpSZGd0SmFLdlZveDJHVVRC?=
 =?utf-8?B?ZmwwaWpsMXRLU2cwMnVQckdRTTlrWGh5VkNQcXNJdG9mOElBRXhDbHFuNGti?=
 =?utf-8?B?Qy9EVXh2Tm1vRHR1enl0TGdBZWMyeTFRTlZueVZrQmRWMFAzV1BNd2NqR2NM?=
 =?utf-8?B?cmZibHZhMzAyS1UwVkNZa1Y4TnpTSG81OXpBaWhPSmkzVit4MEtuRUZrVzEr?=
 =?utf-8?B?QWY1aTRpVFZ0YWd5Ylp2WWVPTXNLelhhUTc4ZlhaTHZxZ0tod2p3SUQ3NkJa?=
 =?utf-8?Q?Cn8wZP/K5czGb6Y3Nk33i67QG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8911c2fd-69ec-4dd6-d95b-08dce9b77a8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 05:42:22.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pisl2GiU/GaoMdyDaN7OuIoK00UMtPv39WwmgKhmGI3zL/BZSm9FB6mMtjBLsK2UFtEa63QFPBWMcctvMB39kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 05:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17029

On 11.10.24 03:54, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-core/ltp/{ltp-full_20240524.bb => ltp-full_20240930.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20240524.bb => ltp-full_20240930.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20240524.bb b/recipes-core/ltp/ltp-full_20240930.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20240524.bb
> rename to recipes-core/ltp/ltp-full_20240930.bb
> index 1ec0974..95828ee 100644
> --- a/recipes-core/ltp/ltp-full_20240524.bb
> +++ b/recipes-core/ltp/ltp-full_20240930.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "2b7c07bb281b7ec49981eeb06c4b66f147b103977254632678d384034f6e9663"
> +SRC_URI[sha256sum] = "3e9e806405aa602e2d21d221d885fd4914ff2da23eb8bba3d0f0f468bdf60238"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

