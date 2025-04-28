Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02900C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:08:56 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.41])
 by mx.groups.io with SMTP id smtpd.web11.42315.1745824056638151477
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:07:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=apICyu4O;
 spf=pass (domain: siemens.com, ip: 40.107.21.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfteG4RnMnIfugJxlOU9vrsouNNDqETTH3R/SgxSsBCqSEMCBWa08+/iRs2Hw4OxzJR3iwzJXmGQGtwGo4t38T/OrDDBThC7nGh8IxpLo2hocpPYiPhndcsBwWjyWZZg6hMUn9JAsXD4QEmbeCBcM1vkHkhwulghhKcqNKAq/Fg4kntKZfqCtL8Dd2O1uT0vHdgf3sQQp3N81c4UHXhBexf/HS/PDuRObSo/lq/+UbkCzzv7iFmil+lBYXPe0WUqE7fWnnBVKVN48IhNNyUHo/aGeyQWJVXxYQK5AyeZTfsTs4CkCGtBYHl7tpqfFBV9FefqJ+WipVfM6RdCMV4o4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh8J5YUwix/3hrbwIxkqYM1BzxQ54+cem/YnQriEkg8=;
 b=qHFDlWonS9NjgbPPwC3FWOBUvU/COIgLfWpHuw4mrUhcsd/Ga3MuoBCoZ+NjLDH/JI52TqcAwM7SffpuUDEOKFCxPR4FJSxvBT9ihQvmQ9EbRlYgKolUck6PhVjKoKuqHXff6GMmPvlpV/mAvPDvCkFfYF8S4A9ZdGnKfXbS67bEsHZAwWMrZGfa4DXNYgwJNo2FniJJUnCp5lnordzcUhdHcp657/eJX806m03qNDo48t3zYXwc32UsOwQJlT9EgG0GJQXIwrXMI0Ltt0GfwQvPRWFtNJhP2FJo7umTGDEnY+V7gP1ujGIA1Bxz0NQSM5FeFVQvJxU4BbwNAySbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh8J5YUwix/3hrbwIxkqYM1BzxQ54+cem/YnQriEkg8=;
 b=apICyu4O2rbfb3p8GcTLA1JS4q/w9jxtfe3uhmBpgbcMeqq9HqrAopk4TTeICmc8ygEkMAwfL/aRFViQ4Bprbbgr16ldSKENIaQiuWsPjKKcs5WiUKvvPTqv/4Jy8ErwfgnsfO72eKVNEJN8VLH8cFMbP3EgMYdyCIkWtWhHcUOFsEXmRQZzEnoggkj4nJN8cmnrHARJqnT1Oj7dcQa0AnMKKVRHQwNUXbHiN6S4LchrbF6bnuCUppwt4wc2Voc7xOqMFTtbwAjwYkPOuv1qgCWkuwUjseIkxodGefWXcAwVO7D2w17oNCb8vbv91arwozk0C49JhWP5bKf3btNLfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 07:07:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:07:32 +0000
Message-ID: <3f5bdbd8-5635-4f63-92cb-a2a04265b882@siemens.com>
Date: Mon, 28 Apr 2025 09:07:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/5] wic(ebg): reduce search to
 generate the verity environment
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
 <20250422145055.1095348-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250422145055.1095348-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 495a078c-ac34-4c77-fc84-08dd8623589d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHRuM2FYdUVBRVRIOGF1YkJlQXh5aUd2b1ZhNlhIR1BWMklHaUV0TGpFYkty?=
 =?utf-8?B?eGkzcnhhV25kVStEWDBid29OSWxuOGZ3SEhCcWFwL1k3Mm5PMktEQm04NGVS?=
 =?utf-8?B?OXpVZnVZVzRoTGI2OGp6VytzM0lCS3p5VWFoTFJaUW5KYmpsMHhqeWIveDR1?=
 =?utf-8?B?YWJMcm1SM013YjNpRFhrZkd3L3VjRmpvZ3ZsOUlBSGkrbVl4VnhXK1MzSGZq?=
 =?utf-8?B?VnBma1Y0ekZ1d1h4alRHbGQyNitJa3h5YjBsKzl2VHRpdFdISTlnRjFxYTBJ?=
 =?utf-8?B?OVphSG9GWExsVW9JZ3lpdEVPVkJMd3IzZ3F6a1ZjbGl4YWkzWmxKU0Q3MlN5?=
 =?utf-8?B?WGErR3Y0UldUeEtxalRreFB4YWxQbTRCMnVsSk5GYjl4amRXUEZaTEtrcEtZ?=
 =?utf-8?B?OXV3RDE4d0dIcWtXWks1Z3R4RmkvT3ZvNC9WTXJ5NW9SNlpJbnRmNk1xUE1r?=
 =?utf-8?B?ejdUdktmcU9PQnVuZnIzdHAxSU44ZExWVG9SRWk4QkFLTWJDTmtST2d6WWhu?=
 =?utf-8?B?OGEwY1E2bGd0M2ZucHdpbXk2dkNGdWNxUGcyaDdiTHQyWWNnVnN3alkyQzlT?=
 =?utf-8?B?WlhjT1pHV1g3emZPSXZWdkxld3BnQ21nT0FWb3VkTVZNTFhPQ1N5eXpoY2p5?=
 =?utf-8?B?Q0Y3MjhmRmMvNlg0VXhkRUZDY0NlYXZkYXJkSk42SHVTNXVVanZYOUs5NEYw?=
 =?utf-8?B?N0ljbXZXUDVSQmNpN3JhYmhuTCsvcFM5OGFSY1g5akFiVjVRa3pUQWZEaDZz?=
 =?utf-8?B?WXV0anZDRmdhWlBDS3M2QzZlaTgyTlJJK3lERE9iQm1YU0FBVUF0bEwvYlpG?=
 =?utf-8?B?MEhSMXcyK0Z0NFV0dWNvZEw1a2ROY1JDdkExVUxSZ2NJb0hTZFNpVWZLL1Zi?=
 =?utf-8?B?YTRseTZ2RXpnRmc4WWx4WnlQK0FlLytEOThsTWxOaC8yVUpMSGZNYlM0Sm1G?=
 =?utf-8?B?eWxqUzZQdTJ6b3l5R1dmUlEzR0MxMXpiM0lpM0Rmd25TTHNoNGJwbWhGMzdE?=
 =?utf-8?B?bDFOOGFvVDkrdy84c2t1WFNVU2dTU0R2ZUowbUt1a1I5dnp1eGVwNFJGc3JH?=
 =?utf-8?B?YnpPd3dEMmVRRGRKWG9uSjdwb3I5elZCalRkUjhCMVB2ajhtTkxBdUE4cFVY?=
 =?utf-8?B?a1NHNUl4V0xKaTYyVmN3T2VjMnM5U2RtcjdDNWRqWHlVWmtKRXpzM1VCbDB2?=
 =?utf-8?B?RXd2L2prWS9wY1owQ1ZMdThOS1d6UUkzK1NLb25CQkIrb2hoVnRNY0JqV3Jh?=
 =?utf-8?B?UUtyMVlvak5hVThTQjBob3lwL0g0S3Fjd0JHQXE0VnRBSVpLZ0NkZ0pBWkFZ?=
 =?utf-8?B?MkZZdmhUZFZiZDR4cUsxcWp3d1l1Nnl6ckRzRmpMUVlpaXRjVmdGb2lZZXpl?=
 =?utf-8?B?WjBtb29haC9ibElCUjVrdHg3SGFIM09YSU9WMFkweWUrWnBoSHg1SkFPcUxY?=
 =?utf-8?B?TnJ1WE9paHlnSHJhaDhRVUlsT0NyUFlLa2tncnJ2aWRwTExTNis3WHpqdVFi?=
 =?utf-8?B?RzFYWEdVa0pWcnhBSmlPOGdQN01FcE1JNWJ2VGpIUmJDU1FxUG04Lzh1RENF?=
 =?utf-8?B?MllINU1TSUhqbG12V1NxeElhV2ttSnN4cWRZMDBLaGtiWURXR0NpOCtTQWdq?=
 =?utf-8?B?MUx3YjZVVDN0dDFQVTl2U3FLUlNvMmRjNHFnRHdtVFR1ajc0MnlMalpweWxX?=
 =?utf-8?B?M2MvT05hS3o3elFDamdldE16NExoRmxiUzNYQVBqdk8xUVdyN05GRTRES0Ur?=
 =?utf-8?B?U1RYSmxvVEFkVXdkeUk4cndsbVFFY3BkV0p2TWk4MkloYldROUpIUi8zVnp6?=
 =?utf-8?B?QTM4N0VlZUlKbEdxTEpqRHVjNmRMSEhJQWluNTRGOUJwdEl2aWJPSmZualpj?=
 =?utf-8?B?QUZwTWl1UWxDbi8vTVRFMzhHYVpiNHFZaUtudDFiWEdseHYxTWtacG4vUndU?=
 =?utf-8?Q?H7z3ZG0zo6Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TG44aGlSMmtvbmpNMEs5TEx0RDA1SVdBK2I4UjFIbUtjS01uVnkzOE1TOTZR?=
 =?utf-8?B?MGxrM3NJVjRWV0xGTGlsQmxOM3VzUkNYcXJhajZQUVhtcVhUWSswTGVrVHVO?=
 =?utf-8?B?aWJPWFBJNGpXYUVvRUpzUk5LM01IUVNIZ2NtT2FVRExWK3hwVmNNczRyOGRY?=
 =?utf-8?B?TzlMLzlJc01Pb0xnanJhUC9TTjB2eEFQczNTUExuZzByQnFGRXZEekdkOHpo?=
 =?utf-8?B?b1IwWWt3dlNhY3hVMC95alRMRDF4YU41V2YzYlhEb1lxbU8rVk5sT29XLzJF?=
 =?utf-8?B?WXhOUi9GYXpSblorNG12emFPRk9Wd3BVdHdYYmhiaXZYaXVJSTBHVGZvQWkr?=
 =?utf-8?B?dmlVK205TWcrd2p4M3AxS0psSzNOV3JVdnZEakxVRW1vcmlLc1dudGFjdllq?=
 =?utf-8?B?NnI4THQrUWJtNVNOenhEMkZqbk9ZaHFXU2E3RlAxVWpDT1ZVUTdCNVFyR0Nh?=
 =?utf-8?B?ZzVzUWM2djk4Z3llb3NvaEx1cDRuM1ZjZkQ5TXpBZHpoY1BGWGNUNHhubDdw?=
 =?utf-8?B?WHBMK2d2RjBIUjdtTE5NM1J1eVErT3dmNWIyTmRSaFdIUTZqZm5UajRicStQ?=
 =?utf-8?B?eVJQdURTWEpaazdaNWRoSDBYdDhTMzFuNHJRWDRMZHJzQnZoMDU2dUpyU2Nz?=
 =?utf-8?B?clFveGpYVDlLUWRUb0QrZ05UeHg2RU9MbzJheUw4ZFJxb1lPaktkYk01WUhs?=
 =?utf-8?B?SkwwSjl3ejlNditCTTk4NDZBbXdOZGFaK0IzanEwU3R1WTk2ZkwzWkR5Wm1a?=
 =?utf-8?B?UUhwWk1mZXBBaWhnTnJXeS9qZkZIcW1pK2tEWHVFTDVyK2V4QWJQbHZMUHFZ?=
 =?utf-8?B?YU1LeEFWbGlYN0hmdWlSS0piTEVsK0IrU2E2eEYwS1R4MVRiUjZvZXJjV1li?=
 =?utf-8?B?eWRBM3ZYdlBMNnB0VUk5VjFzbUk5REdNU2Z5M2o0SEVQTnFaTTh4MnR4N09J?=
 =?utf-8?B?bFZWRUZhMHVyWUNpK2JkeG1rTlBzZ0tza29hc0pPR3Azb0krOVdnOFJkY3cy?=
 =?utf-8?B?bHhwb2RDUWswSm1DTEFCVUwyVU9RR0NXNlo0NG5RUitLbXRXMDV5Qkwvay9J?=
 =?utf-8?B?bUI3Zlo4RnNGaWpJeEg0Z24wOTNBWDJBY2t6MUtSbkxDVW1CNmtOK3I3U2l6?=
 =?utf-8?B?NFdWL29vZDdYZlQwdVpxeTB1cGpISEFWdkdQaVI3a25FUTZRTzA4SEFVY0pF?=
 =?utf-8?B?U3BNaE1pN1YrUjdPM244aWtIOHpKWDdEc3dSU3NNY0tKbUp0VG1hendwcm9O?=
 =?utf-8?B?UXlVNEJKVGdtTmxpczlPTVdzVG9LN3ZPcUdRbXZtRHpiamwwRkxoM3dvVHNY?=
 =?utf-8?B?ekFmaEdFOTRWZmN6RE5pSWtZbVRjVlJhYlJLNlBnRHFBdWQ5MXEzT3o3Z3Q2?=
 =?utf-8?B?OWgvMmdROUNJMjBmZ1NqYnNvMng3ejE2Y1NiTnJxNzREcVZCdmN0aXY2b2Zw?=
 =?utf-8?B?UWhFZmREN1BqZS9acFdvS3VPbEFpMG11U2xuaEk1R2M3UElsVlh6KzZTSlg4?=
 =?utf-8?B?dE9USUt2SEg1eEZ4T0R3RWtpL2x5cDNtVzdBSUtNN2FXdEFNL21LQnBDY3VC?=
 =?utf-8?B?ZlgyR1JuR0RyaXczbDRadnZxM0JUa2hhTm5EbU9CVlJsYnliWE80MC9XbzM1?=
 =?utf-8?B?MlVyOFVMb25SK3J0S2IzOTVtZUhqOE9ldzlsR2JOTEtxZjB6eDQrZkgzY1NZ?=
 =?utf-8?B?enRLL0xxcGpDNTZXYzZxWkM2U1ZNc01KTnNsTnhvdEpzSlBRTDdwbElXVzQw?=
 =?utf-8?B?N1RCblFDb1pXWTA1V3FWTXM5bVN0VzJldFBwUzBlNHVBaEU4MnFzVDBYamRV?=
 =?utf-8?B?cWxwLzMzTkpCdnJIQnJIOVd1U0lzSHl5alAwWDM4OU44cDQza2h6a2N5bXhH?=
 =?utf-8?B?dkE0dFNNR3F5cERZT1Y0aWFDYVFTMSttQ1VqNGtGUWZMSkhOYkdaa0x1MlBY?=
 =?utf-8?B?ZkhXSzR0Tis5RUxPc3RFYzluUFNHeE4vVzJHK1NvZU9CVjlhamdvL2V2QkdN?=
 =?utf-8?B?UzZBOHd6dW9jcHN5b2F0N04vRDdBMWx0bGQzYXZkRGxrbG9lVjFwUVd6Wndi?=
 =?utf-8?B?TUpqSDlBVWw4SEZvdE9Od0hpdEhVQWd3T2IyRUpSQXJiazlneWhtaU42bWsz?=
 =?utf-8?Q?na1ulfE24Ke0Fy3JJtbuf39gI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495a078c-ac34-4c77-fc84-08dd8623589d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:07:32.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rtul7SVvqASRyqd+vDt+kkPYkyv+FPj5fth/bBzNj6FAyvEpd8xbQzMhHr/Ds+D3pPYRfAdrcFiVjsxSAB1HCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:08:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18685

On 22.04.25 16:35, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If multiple *.verity.env are available it is possible to select
> incorrect verity information.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 941634a..c3098dd 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -155,10 +155,11 @@ class EfibootguardBootPlugin(SourcePlugin):
>          verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
>                            "hash-offset", "salt", "uuid", "hash"]
>          opts = {}
> +        image_basename = get_bitbake_var("IMAGE_BASENAME")
>          deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
>          verityenv = None
>          for file in os.listdir(deploy_dir):
> -            if fnmatch.fnmatch(file, '*.verity.env'):
> +            if fnmatch.fnmatch(file, f'{image_basename}*.verity.env'):
>                  verityenv = os.path.join(deploy_dir, file)
>                  break
>          if not verityenv:

Should be folded into patch 1.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

