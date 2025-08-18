Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09FCA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 17:14:33 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.45])
 by mx.groups.io with SMTP id smtpd.web11.1129.1755537262540944287
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 10:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QWQBD+Xv;
 spf=pass (domain: siemens.com, ip: 52.101.83.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDEd7SVJ9QG6BTjTjr4x/xETaBRaM2cQ8P1asBEcgXqw/aGNiMUmRMdWVZ9FwY0pcKRbENv4+tuRhdINdYXSTMBLCNGtAUfQQGy3ZPehCeUpa+M+I9Ad4chL5D5kYc38jklRpM4NRQKx4rdXQO+whx1vwUXb8/VFnL+x67VtyhtBpPWTK1QzRpHZ9FK4Cg9d3ZCIZI3lp/1f18KGqUfx2mwb3QqTaaq0XTHmn7MTCqu+cyqQDmgiwTzm0Z2D81bunbmN+KuvNoamzwSkA/YY9DmwsqsJbhZNEplVBx1Wq8uNPiWFOPVsD76S5tc4Tn8K/MhGiAVilVighb2DqlPZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsa0iKRzIEG0Be5Foc2GHDA7WQ7My5S2xYOowsR4gQM=;
 b=tzsSRMNv/jw474SQwE6W3iVODQEB+NNddlSmEs5A4GIw1h2qb6KntrVR4QgnCeRgQ8vsga5/U9Zgeym7AkTtT1O/AFOET9rJFvLxK3+pw7IXkhxJVFEInm8i7tcTJO7ofEebtyxkSlOZyPLnlzFKKinH4vZqD+MZUbm8ynxofD6+CZqgwzrO/Wz5qdaZAaKdZaZe3m/Cj5RSUVk72CWCMTrJwnhL6MoyO7sDAORGefV7NPMs8AcZ3DN3rrlwdtmhfwi8nfINBwbnIi+xwaNcukjFlKvl80iJ+trEMWVL6tD6+gwaIAa5YbGaKV9E6arvLEWKqKLhgU4nZZYHa6BJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsa0iKRzIEG0Be5Foc2GHDA7WQ7My5S2xYOowsR4gQM=;
 b=QWQBD+XvpxZw+ex4U7WDdNFMMRAaUARMa9NRAryNRxgxbcRh6hQc6Vw1Q59sLaTZD1YfC6dc7J2jbn/vaT1da2tNcnTO8U+dHzRPUpyWPulLfdq+neDZLpmgPblNmg1WXabs0PW2JrxCHQDb9c6Ewor+NBNs0puUlAvHFjf2KmnEYUZBuxrzF0vO5FWGkiCUA1+Cv/3R9zB6LOgKhzEEWCJPHDj7ccdzLv2UlLLu9qjz89Sbm6QOIv+qYxXBQvTb6pJNj6mEt2n32Aa8fAbu0f6i6dmNWTBtn6+mrVQp3u/gaBrxr5GD/sQlUuwFBOJagfVTOh9JyacNBEdLLqRQog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:14:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:14:16 +0000
Message-ID: <841cce01-62d9-429c-9e6d-6333c79ed9fb@siemens.com>
Date: Mon, 18 Aug 2025 19:14:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] Add support for TI AM62Px
 SK platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com
Cc: vigneshr@ti.com
References: <20250731082421.292376-1-s-adivi@ti.com>
 <20250731082421.292376-2-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250731082421.292376-2-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: ba56c2db-9fa4-46fd-f7b1-08ddde7aa940
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTlWNGVqMjVCRDI3VC83NTd6TWJEMFRTcEhma05ZSFplVTR2OUJVT2hQTGVo?=
 =?utf-8?B?UmRzeU9PVzQrcHhrc1RJaFJtRG4vRU5memUzdVc2R1o4R05YeTJwYUlldm1j?=
 =?utf-8?B?WVFCVlN1ZzFZekh6aFVRSENUdEJWdi9McFVIQmxseUVYTUxvYjRDZHorY3Fo?=
 =?utf-8?B?VUIzQ01EaUdqTWxqL3BKWVNUMU5UZjJVdXBmZ2w0UWxWNEk5R3VaTmVKak9K?=
 =?utf-8?B?Smc3Ukh0TGd0SFpwY2dhQkduc3B0NVBVWWRXemQxTUlrSCtVT01LamdodUs5?=
 =?utf-8?B?WDdxTEdCb1NTV2pUV09yTERSVmw3TDczRHBSU3FORXJVRGc0K0JIbjlKVklX?=
 =?utf-8?B?Q3RGbTByb0xPMzFvdDNIRURZNGphQ09LWEVMRDVxT3RmOUVkTVZOWkFSRExR?=
 =?utf-8?B?Mm1xRDFjMVdXejdCL3AxdmFhWWVZSzIySDNXRHZPUHduYUNiVGtkUUsvc2My?=
 =?utf-8?B?U1pnRk9INlBDNEJTYjFPNHlQZk9kdXJObkNNYUxtYWdIV1F6OXowV2N1K2VR?=
 =?utf-8?B?VUV6UlpEWWQ2Q0Y1VkkycDNTSEJVbkpzMEJJeCtEQjdDUkpBTUF3dmcrVUQr?=
 =?utf-8?B?YXZYUHo3ajU5Umt1b2xidlh1cTNld0htV0M1bC80UGEwVGZtbVRsRVlhbnAy?=
 =?utf-8?B?am5QOC9TUU9UMmZMaExoMDZqM1N3MjIyL0tia2p3SlR5U3JBWmMwelovRDRY?=
 =?utf-8?B?cTMxU1lzMkJEaDBCSGJwVXRONmRSQ1dJZnc3RWYreUhabFh4V0JNdFE0eWk1?=
 =?utf-8?B?UjRDbHhLN3FjWThwbkw4dW0rTWw2K1AyUDdnaGwwaGQycEZ2S3JSSmZ5M3Mx?=
 =?utf-8?B?dWpBNWs1TU8vU0N4QnRBeDZPeDhqNlBiV0R1MnBObEZlMWlMaDlFRE1nZ2Jz?=
 =?utf-8?B?eWV4OWsxZVV6WFU0S2dxUWphaXBKN1k2REYyQWRiWjB1cnJjZnVoWmZWallr?=
 =?utf-8?B?SGlwQlc4bUdneVdlMTcrQ1VwMjQwK2VRT1NSVlQxTDZmUUZxNC9CVnloeEF6?=
 =?utf-8?B?UHRKQzhqam1DQVZSSngyakx0WnBLMVRacFU1ZVRuTVlKQzJXQkZUcW9GRnZS?=
 =?utf-8?B?WUtrZFdjZnk5NVZ6b0ZtcVIzbFA1RXQ4VVN1VkdMWWlGUU50NExlYkdRVXdC?=
 =?utf-8?B?TzF4Vy8yWGlCalB1UGtUY2p6UFM3NlpXenpuWmRTb0ZaOTh6OFlQV0Q3M2hu?=
 =?utf-8?B?Z0s4b2FoaU00VnBrbVVNeFIwYm9BU1VXR0NyNUNHZWNGUW10YzNCc0YzNFZq?=
 =?utf-8?B?UWg3eG5pYzhwMThuOElZcHJaaG01NUh3enNMeStwaEd6MWdvMW5KdW9QQ1FR?=
 =?utf-8?B?ZHJFNFdvQ1hlTFQ5aDUrZHVQaEFrTUdINlgrZFVWOXAwNERGc2dGYzNDem9D?=
 =?utf-8?B?ZGs4bUc3MW5GNFhhQUxpcmx0b2tvVWF0ZzVQRVkvTngxb0xnaGtiNFNpOWxa?=
 =?utf-8?B?cDF1VmpsWFluNk5NUTRXWllHTUVHTmpVa2lUK0NaakFQSWtFZytjVFdsSWdH?=
 =?utf-8?B?c3o0Z2lmMjhMciswL3ZDNjVaZ3VEdWluZjB6cHI5OFZGMXNRSzRnRmluZENt?=
 =?utf-8?B?WG8wYytZNUs3Y0pKb1YwRkgvMTVHSXB2RGp3SWMzcytIVUloSjM4YUV6ak1j?=
 =?utf-8?B?cUV5Vi9qSU5mdGN6TE42SzdNWkZFTFlrS05uSjltT0NNZ0Q5WFRFWVBRaXp0?=
 =?utf-8?B?bDh6dDkrbmM2OHZiY0EzRXB1dzVpUW1VRzhnNFBCYkl6L00wendDNUZyZ0Ro?=
 =?utf-8?B?V3pSRThDMXpMR2pDNk0yTHNHclEwQ2s0amk4aldVWjdKdXltVEFtNHVDYW1l?=
 =?utf-8?B?S040N3krMW1JNWRzWGtWcnpKUThLQzd6OFRKU25jekduUmw4SFBZSXZGL3hO?=
 =?utf-8?Q?R0d8iYNzMpnXn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1ByalhsK0RxMUFnR1Y4YkQ5VHIzVU9ESG95QmhyaGhVU0x5aDdCbkhua2ZT?=
 =?utf-8?B?ZUx2QU1QdkEwNGpJNWg2Wkc2Z1N5MTUxOVY5UlNWeFpMTUpLVXcrajhxZzdM?=
 =?utf-8?B?dXpXSjI2blh2RVdQMzNaVnhObldodzFhZGhmdGZvdFNLeGhGWVBkQVFjTFor?=
 =?utf-8?B?dHIvNFJCYjFQak8vdzlUY01NK3dwYnhOeDUyblYvS0pjc2RmczhzQndnZDFX?=
 =?utf-8?B?dlRxQlc4aDNhdFVSUWFlVUVSOExRODB5MHpmVWVFSCtodWdUbFgzZEI1a2pD?=
 =?utf-8?B?WmlLemE3ZXVNcmRnYjZHZHhHNm10aVkva3M2UG51bFQrK1hmQ2RFYStneVh4?=
 =?utf-8?B?Y0FzYnNkdzU0anNEZExPaGtKdkYyc1B6TXJmL1pYbUQ0RHJHTk4yaUdhOFNJ?=
 =?utf-8?B?RmtuL3ROTFdiZWgrVmNDMG0xbjB2TmhnV2ptY3poSWhZMkVlVG1ETFRzWW54?=
 =?utf-8?B?NGVva1ZxL3FSeDltYmo0RWZJcnBicVEyaXJUdmRLb2ZLNFErb2o2eG1oU214?=
 =?utf-8?B?QktabXRBQXFEc28ycFZNbFFuMUcrMVV1MUE5SjFacDdwUHFLV1BtdFBUOU0r?=
 =?utf-8?B?SEIyeDhRb1B4Y0dRSFV0N3JTUGdiaXpCWk5HVWdpMTJVMHRvVWRGVy8vNFd0?=
 =?utf-8?B?ZklrZ2o5L3FDL3c3aUd1WUlzeHdJREtkTWh6eFNCdTlGY0x2STFGeGlGZWxM?=
 =?utf-8?B?SzBIVDA3OWpQVTkvamUyUno4czlEQkhLUi93OVkyeE15MWpPMW1JbmUzOTBu?=
 =?utf-8?B?QmRJUy9iaG5iWTQ2TVVhd2tCZ0RtSjc0NkJFakkxZ3hwVW51b2svK0RRaWNQ?=
 =?utf-8?B?eVczY0JvVmNCMkhXSWdmTUtoaEE2d2VrMW0wNkUyZUZiMmphc3JDUEhyRGdU?=
 =?utf-8?B?UjRpL3lUWHVSZ1B2SHptNWdnTjM5TUE0WERwd0hXVUxwNGxFYzloOVRXNURy?=
 =?utf-8?B?TGVWQUFJV3NYT1hmbmdncWlwQVdGVkR0ZFRpS082ZC9rQVJsMlIyL2grcGR6?=
 =?utf-8?B?YXNYYjFzbGxhSUsxdHRhc1NjbEtZL2VKbTlhSHVaRnpVWG5BN2lnQUtPNU9s?=
 =?utf-8?B?QVArZ0p2dVV2dmZnVmRDbXpIblJIdGsxWHFvME5YdGpYNi9wOThML1lJeEp6?=
 =?utf-8?B?SDZEeGpSckxubUYrdm8xbjJJRDR1c1lVZDB0OFllSW0wRHVHdE5Sb1Y2eXVx?=
 =?utf-8?B?SkFUUkJ4ZW1XdHA2eURBOGxiczljZWdHeWd6STJnQ3ZCS1hZRzBDY3dkZ0NP?=
 =?utf-8?B?RTBHS3BZSEt2VkpjWTVHcjNhQlBRU3Vyc3J4WWNaVTNWaUp5ZWlmd0poUlhJ?=
 =?utf-8?B?UnNvZkhsZWNBWWs0TXkwdlNJYUN0TWZvMU5CeEM2cURrWnJsRVU1bVljRVBS?=
 =?utf-8?B?N2RlenRONDVjQmIvdS9Zd2RFbUhOYzRRQ0k1b3J2NU1kYWNaalpXNDNqelU1?=
 =?utf-8?B?cXgzU0tqcGUxaitiSTU2a29kd1M5T09BOHRib1RmQ2NDOFM4N0xOYlpmZTZa?=
 =?utf-8?B?NUJOUStVSUZSYlAwYVE5L0ZQVHF3RUc0M2M0alZqYTl0anZRcnBtWEZSdUVM?=
 =?utf-8?B?YUREdEs5bzhnemd1ZGtNazdIM28vd01mbis0c2laOHIxcHJ0NitqTnRmcWlj?=
 =?utf-8?B?YlFpKzFNanlKWlhBY3NCaDFBZlpGNTcybkp6aWZoU0RJUmtEeG1mRFBLcjhi?=
 =?utf-8?B?TU1BQnRUZ1VEWCtRZ2tvTWUrdEdXZ1NiNm1yVEZiYlk0bnVnQmpUbkt6eVZ3?=
 =?utf-8?B?OWZpdGp5TENqNlRES1ozVnN6YmwyTzhmbzUrUW93N1JTWGcxSXd2eDY4R2Yw?=
 =?utf-8?B?VXpubHBDTmRpOUJOYkQwZjhKQ2Zoc2FRbEllNFkrRU1NRkREUklDby9jaFpn?=
 =?utf-8?B?cUo3b3Vobk8xbmk0SW1rSlhkMTRiZ2tXYllFaU9LRnh4U3ZCZzc5MUlMSk9X?=
 =?utf-8?B?VHJoMzA0d0ZJeis0bWxrSWU1TG5wRlZJUTVMN1hEc0hwTVJOZ3ZtRTA5WWt6?=
 =?utf-8?B?NWVIVm1QQU5xL2xCLzBPVUFXd29CeVMreVVnRXhLOFc0WUIvbWFSTEo3c3F3?=
 =?utf-8?B?MUVxcnMyM0pvMk0yMEhhSTRpbm1PaFJzdWFkT3J4S0loTXhBM1k4Wk5PbEsv?=
 =?utf-8?B?MHJpMVRaM1Z1OFBGOXEzWm9CQjRmeHBkMEg1cjFWMmpTek8wdlNyQmp1MHFJ?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba56c2db-9fa4-46fd-f7b1-08ddde7aa940
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:14:16.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSkRT8B3XjLma138CnwFDBfFUG40hkUaKwV1CrNIG8N3R90V4T9VPPp925uHd1wB6B4t5p1WRa1ckDL+PIHL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 17:14:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19761

On 31.07.25 10:24, Sai Sree Kartheek Adivi wrote:
> - Add machine conf and and kas yml files for TI AM62Px SK
> - Add new u-boot 2025.01 recipe as support for AM62P is only available
>   from 2025.01
> - Add new patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>   to enable KASLR support. This is already upstreamed to u-boot at [1].
> - Add new recipes for trusted-firmware-a, optee-os
> 
> [1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  5 ++
>  conf/machine/ti-am62px-sk.conf                | 32 ++++++++++
>  kas/board/ti-am62px-sk.yml                    | 13 ++++
>  recipes-bsp/optee-os/files/rules-ti.tmpl      | 21 +++++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 37 ++++++++++++

For QEMU, I'm now on 4.7.0 - please update so that we can probably reuse
bits.

>  .../trusted-firmware-a-ti-k3_2.13.bb          | 18 ++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++++
>  recipes-bsp/u-boot/files/rules-ti.tmpl        | 33 ++++++++++
>  recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 ++++++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 60 +++++++++++++++++++

And here, we should go for 2025.07. I will soon bump the existing u-boot
users to that version.

>  wic/ti-am62px-sk.wks                          | 11 ++++
>  11 files changed, 301 insertions(+)
>  create mode 100644 conf/machine/ti-am62px-sk.conf
>  create mode 100644 kas/board/ti-am62px-sk.yml
>  create mode 100755 recipes-bsp/optee-os/files/rules-ti.tmpl
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>  create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100755 recipes-bsp/u-boot/files/rules-ti.tmpl
>  create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
>  create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>  create mode 100644 wic/ti-am62px-sk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index e078892..1b7e428 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -77,6 +77,10 @@ config TARGET_QEMU_RISCV64
>  	select ARCH_RISCV64
>  	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>  
> +config TARGET_TI_AM62PX_SK
> +	bool "Texas Instruments AM62Px SK"
> +	select ARCH_ARM64
> +
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -89,6 +93,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>  
>  comment "Kernel options"
>  
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> new file mode 100644
> index 0000000..6e59250
> --- /dev/null
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -0,0 +1,32 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +DTB_FILES = "k3-am62p5-sk.dtb"
> +
> +IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "ti-am62px-sk.wks"
> +
> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
> +
> +IMAGE_INSTALL += "u-boot-script"
> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
> +
> +IMAGE_BOOT_FILES = " \
> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
> +
> +WDOG_TIMEOUT = "0"
> +
> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-ti-am62px-sk"
> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
> new file mode 100644
> index 0000000..53e08be
> --- /dev/null
> +++ b/kas/board/ti-am62px-sk.yml
> @@ -0,0 +1,13 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 1
> +
> +machine: ti-am62px-sk
> diff --git a/recipes-bsp/optee-os/files/rules-ti.tmpl b/recipes-bsp/optee-os/files/rules-ti.tmpl
> new file mode 100755
> index 0000000..d5163d5
> --- /dev/null
> +++ b/recipes-bsp/optee-os/files/rules-ti.tmpl
> @@ -0,0 +1,21 @@
> +#!/usr/bin/make -f
> +
> +# Debian rules for custom OP-TEE OS build
> +#
> +# This software is a part of ISAR.

Not quite anymore, but...

> +# Copyright (c) Siemens AG, 2020
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +endif
> +
> +override_dh_auto_build:
> +	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=${OPTEE_PLATFORM} \
> +		CROSS_COMPILE=arm-linux-gnueabihf- \
> +		CROSS_COMPILE64=${CROSS_COMPILE} \
> +		${OPTEE_EXTRA_BUILDARGS}
> +
> +%:
> +	dh $@

Why do you need an own rules file? 32 and 64-bit TA support? Maybe we
can generalize that and patch isar instead? But I so far avoided 32-bit
TAs - do they have a use case?

> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
> new file mode 100644
> index 0000000..0d03a57
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
> @@ -0,0 +1,37 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/optee-os/optee-os-custom.inc
> +
> +SRC_URI += " \
> +    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee_os-${PV}.tar.gz \
> +    file://rules-ti.tmpl \
> +"
> +SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
> +
> +S = "${WORKDIR}/optee_os-${PV}"
> +
> +DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
> +
> +OPTEE_PLATFORM = "k3-am62x"
> +OPTEE_NAME = "ti-k3"
> +OPTEE_EXTRA_BUILDARGS = " \
> +    TEE_IMPL_VERSION=${PV} \
> +    CFG_ARM64_core=y \
> +    CFG_USER_TA_TARGETS=ta_arm64 \
> +    CFG_TEE_CORE_LOG_LEVEL=1"

You could probably stick your deviating make options into
OPTEE_EXTRA_BUILDARGS as well. Still, if there is some way to make
isar's rules more generic, that would be best.

> +
> +OPTEE_BINARIES = "tee-pager_v2.bin"

That is legacy. I'm almost sure the default of this var will work as well.

> +
> +python do_transform_template:prepend() {
> +    import shutil
> +    import os
> +
> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
> +    shutil.copyfile(src, dst)

You could also add rules-ti.tmpl to TEMPLATE_FILES and copy the result
in shell code in do_prepare_build. Or rename to rules.tmpl and use
file://rules.tmpl;subdir=debian, just like below. Too many options with
bitbake :). So better avoid the custom rules.

> +}
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> new file mode 100644
> index 0000000..eca70d8
> --- /dev/null
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -0,0 +1,18 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
> +
> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
> +
> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
> +
> +TF_A_NAME = "ti-k3"
> +TF_A_PLATFORM = "k3"
> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
> +TF_A_BINARIES = "lite/release/bl31.bin"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> new file mode 100644
> index 0000000..d831b21
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> @@ -0,0 +1,38 @@
> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
> +From: Gokul Praveen <g-praveen@ti.com>
> +Date: Thu, 10 Jul 2025 15:29:22 +0530
> +Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
> +
> +KASLR, or Kernel Address Space Layout Randomization, is a security
> +feature in the Linux kernel that randomizes the memory location
> +where the kernel is loaded during boot.
> +
> +OP-TEE RNG is a Random Number Generator (RNG) component within the
> +Open Portable Trusted Execution Environment (OP-TEE) which provides
> +a random number to U-BOOT and U-BOOT provides this random number
> +as seed value to the LINUX kernel for KASLR.
> +
> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
> +configs.
> +
> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> +Reviewed-by: Bryan Brattlof <bb@ti.com>
> +Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> +---
> + arch/arm/Kconfig | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> +index 5872455a0fe5..4e7593616d8a 100644
> +--- a/arch/arm/Kconfig
> ++++ b/arch/arm/Kconfig
> +@@ -835,6 +835,9 @@ config ARCH_K3
> + 	select FIT_SIGNATURE if ARM64
> + 	select LTO
> + 	imply TI_SECURE_DEVICE
> ++	imply DM_RNG if ARM64
> ++	imply TEE if ARM64
> ++	imply OPTEE if ARM64
> + 
> + config ARCH_OMAP2PLUS
> + 	bool "TI OMAP2+"
> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
> new file mode 100755
> index 0000000..8f41300
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
> @@ -0,0 +1,33 @@
> +#!/usr/bin/make -f
> +#
> +# Debian rules for custom U-Boot build for ti-am62p-sk
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
> +endif
> +
> +override_dh_auto_build:
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
> +
> +	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_A53_CONFIG}
> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
> +		TEE=/usr/lib/optee-os/ti-k3/tee-pager_v2.bin BINMAN_INDIRS=${BINMAN_INDIRS}
> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
> +
> +override_dh_auto_install:
> +	mv tools/env/lib.a tools/env/libubootenv.a
> +
> +override_dh_auto_test:
> +
> +override_dh_strip:
> +	dh_strip -X libubootenv.a
> +
> +%:
> +	dh $@ --parallel
> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.01.inc b/recipes-bsp/u-boot/u-boot-common-2025.01.inc
> new file mode 100644
> index 0000000..14bdef9
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-common-2025.01.inc
> @@ -0,0 +1,33 @@
> +#
> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/u-boot/u-boot-custom.inc
> +
> +FILESPATH:append := ":${FILE_DIRNAME}/files"
> +
> +SRC_URI += " \
> +    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \

Let's see how long this server will still work... But I haven't heard
about an official new home yet, so let's keep it.

> +    file://rules.tmpl;subdir=debian"
> +SRC_URI[sha256sum] = "cdef7d507c93f1bbd9f015ea9bc21fa074268481405501945abc6f854d5b686f"
> +
> +SRC_URI:append:secureboot = " \
> +    file://secure-boot.cfg"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +
> +DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
> +        libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}, yamllint:native"
> +
> +DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
> +    openssl, efivar, secure-boot-secrets, python3-openssl:native"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:buster   = ", pesign"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:bullseye = ", pesign"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:bookworm = ", pesign"
> +DEPENDS:append:secureboot = " secure-boot-secrets"
> +
> +do_prepare_build:append:secureboot() {
> +    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
> +    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
> +}
> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
> new file mode 100644
> index 0000000..d0d6e5d
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
> @@ -0,0 +1,60 @@
> +#
> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require u-boot-common-${PV}.inc
> +
> +TI_FIRMWARE_SRCREV = "33bec0e2ea9a25362c0c8243b2f1ed392dbc5b02"
> +
> +SRC_URI += " \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=sysfw-cert \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=sysfw-enc \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=sysfw-stub-cert \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=sysfw-stub-enc \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f?id=${TI_FIRMWARE_SRCREV};downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=dm \

Did you answer my question about CI-stability of git.ti.com already?

> +    file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
> +    file://rules-ti.tmpl"
> +
> +SRC_URI[dm.sha256sum] = "7251394068d287ec81cb0f005a734de3bb7bb695d9dbcc3903ea83dda2182efc"
> +SRC_URI[sysfw-cert.sha256sum] = "fe36da7923ac6fa52eea5e601fb4321299df5e639d9dd66b41b6825bc1d9d539"
> +SRC_URI[sysfw-enc.sha256sum] = "4db6ed096fd5077023f292841a64aedb3a4ff8408d1160fb10a7aa0355d06e56"
> +SRC_URI[sysfw-stub-cert.sha256sum] = "22b58a07429da5ae0b0cd126d4ec0f429ee687429251f4fcfe9a2f5bb3e74b5d"
> +SRC_URI[sysfw-stub-enc.sha256sum] = "2cb73e5c9acf985325f40f16152906c9a2057f41ffb7903a981a34f7b2aaf524"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
> +BINMAN_INDIRS = "./ti-linux-firmware"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> +
> +U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
> +U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
> +U_BOOT_CONFIG = "${U_BOOT_A53_CONFIG}"
> +
> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
> +
> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
> +    libssl-dev:native, libssl-dev, grub-common, \
> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
> +    python3-jsonschema:native, python3-yaml:native, \
> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
> +
> +do_prepare_build:append() {
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +}
> +
> +TEMPLATE_VARS += "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
> +
> +python do_transform_template:prepend() {
> +    import shutil
> +    import os
> +
> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
> +    shutil.copyfile(src, dst)

See above.

> +}
> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
> new file mode 100644
> index 0000000..8663607
> --- /dev/null
> +++ b/wic/ti-am62px-sk.wks
> @@ -0,0 +1,11 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2023-2024
> +#
> +# SPDX-License-Identifier: MIT
> +
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
> +
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

