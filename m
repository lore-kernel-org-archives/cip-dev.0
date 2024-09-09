Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B2ECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:30:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.68])
 by mx.groups.io with SMTP id smtpd.web10.50740.1725881405005716930
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:30:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O+oVXCGd;
 spf=pass (domain: siemens.com, ip: 40.107.241.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfYqYqQY+Mc5N8oPp6uBH872uWTiZjhPCWn+kxNakNQpc3ttj0Yufax6f3YCOuvRb0p5cu+/DcyN0MvaOzjr1EH2QmVDFy4xU6zBF3wOx4f8R1lKTLpmNy+9UKC66ZPPrLa5bLGx48NoKTixgM1+rPNbh1Y9tmfc8B3sIW1jUt79VPn0NsmPDjKT2V3fZXuJBW6IclIK1ycNSMHDkxi4qoBQ58qeBtPUvDMrOIA+s/x4DKDv/STG+XJLgg1q1qHOz8VtQkWVR8SCoCiaIuoP0v72z1w88aT93YPkKIk+Q6XXfDOYwFousKBBDcMKuFERuM0+AB2bjDGy+ZYO9A4sUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RwY/r7HSxHJZADLYHSqjQ6cLS6gPq3qW7BdCOHwDHE=;
 b=ElbiIbYZp97FlR9lAngeWhITdKZabqo8MrQD59UQKqZu39tPJEBNNUR1vcONEpkZlach9IY/nlx4uuy7g5FPHzkzEJlIS82RgK1Wr19YbuHLE4MRFQXMO/CGsZ8Z7WiJrPxqmE/XvDJlgFAIsDZhe2eaGI4ALIN4PMVRSxJskOXveZCJJUHMr2oX69HFrx7U6tollaOvwAYsFn/97tglqaE3h79k4NlvRfcFg2gMwTpLQad5HPHo/uxAb41Tii++t7aGmg9su067Cypn+aFvLeuxSflmpOC5EC1yBw2RHH8SdmynZbJnQJNIzmrIw4WIC+U5H+IBPx/7MxJoa2xF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RwY/r7HSxHJZADLYHSqjQ6cLS6gPq3qW7BdCOHwDHE=;
 b=O+oVXCGduGOgbauDz/5y+uGNNoshw+mmncVe2akgfgXjhVezCYjG+1JToG+IP408FAkQFlUkuAzcTZyu6F/Rvwqfm8VW/Byt86LOOBz5X6XfldFfLsuSLS+VuMw1Cmh6Ob569FaM2jzVnpuZRG7byIQSLlxd0Ob7yyBMG83mSl2c4dGf+CtzrWN+kAoZgiRz6x77aQCFOnzd4j134irrmyulKO76sRZUuzHhp2cjhVjbpnI5GPr3b/cTOI5UFTKwmUZbd3y58uQkNC7nsjQXPY8S7prV40l0ZPlr9FIqxpDl+OuYMJOHp6P2K17L4ZPt/dbw6RPKQtOFLCL96rBH8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB8039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 11:30:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:29:59 +0000
Message-ID: <1fb27068-776c-4e29-b0f4-1d3758e417b0@siemens.com>
Date: Mon, 9 Sep 2024 13:29:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip91,
 4.19.320-cip112
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:610:75::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c25681e-5840-45f7-1215-08dcd0c2bd5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDVYN0Y1NThLcm9DZXFCRDNkVkF5NVU5TW1Jd0tRL3RVbmxTTGRqa0lTRzQ2?=
 =?utf-8?B?MHhTQTJNdFd3WkhUb0lxUmF0L0E2cHlNV0ExYmJqZC9qOHJ5aWVkRmJiZThr?=
 =?utf-8?B?TUFjV2xPRGVHWnYvT3FNKzRwRVQ2UnQyVk5JcWozcWpIcCtIZks2UEZmQ3ZW?=
 =?utf-8?B?TUFLR2FvY2hmMTJGNUVjOHE0Tk00RUpSaVhFWnI2M1JxQmxnZVJ2azNTeEsz?=
 =?utf-8?B?ckRMMEE2RDk4c2JYNEl4cGljK01rQzFiWmdOOEhCajR2T1FMcnVmbzlUVXEw?=
 =?utf-8?B?bloyNUtMbFJSdnpKOFNLUTg2SysrSDE1aTVZT2FQNWRPNlI1RXBIc3phYWNX?=
 =?utf-8?B?RGlLOHFJWEZrQzJ6UkczSUpwdTh4NzlOeVV4YjB5citaQWx0MG1UWVI3NGRu?=
 =?utf-8?B?VGliWWFzR0Y1KzFZOWNuQXI2T201TnpsQ1kvcktrL0luRURlWlZyRjlkUWZr?=
 =?utf-8?B?aEpqenl4V3lkMjNHV3VXSXhYaHRpSjVPaG5Pa29MZllnQm1GUVZrbFl4clBa?=
 =?utf-8?B?cDJqVVhnUDMwRFd1Nk9XQ1pQYU9IcHlSK3I0Q1RSQVFjLzNwUmdDVVVNaW1Q?=
 =?utf-8?B?cGlobFdsZGNhUmFxNXpqa09pd1hyQnpidDF6Unh2Wk9PUDg0c1FNSlNrK0VF?=
 =?utf-8?B?QSt0V3pRbFEvT2c4RzN0b04zUjVxMTJGKzlWUi9nV0JFN2RpYkhLUGxYQnUr?=
 =?utf-8?B?aThMeUNnemlUVzVKSlVhbFUwcDhKOGpyeEs0RHlIck80RkNRVUR1U25jRUYw?=
 =?utf-8?B?SU9PQ0w2dlFuZ0cxajI0cWc5OVFiS2lVblNpS3Y2UUFDcnA1cGhNMlNPay83?=
 =?utf-8?B?TTNMdjk1Q3hFeVlEVTNEQ0NPT1Y3THEzdTJwd2hHZnlGV1JzUHlEdGNuUjZ0?=
 =?utf-8?B?WGRubFk1a21hNkptMXdiYmhXRndCRXhTQ1pZSEdwdEdGZTJKMDhvVEVDUmlQ?=
 =?utf-8?B?WWVZOXpFaFM1NlN2bko3eURQVHU5ODBsQ05GTW05TThXaVZkbGpiM0d5QmN3?=
 =?utf-8?B?b1hlQy9FaTE0WGhQQ09EWmE0L3g2N01xNVlwMUZxb1NIUFY0YkJSSzdDMDVi?=
 =?utf-8?B?bFUwSWFNWGliMjhFbEJjMEdZSVpwYlZzYzRIclhQVWp2amNWUWptK2JTeUNE?=
 =?utf-8?B?cXBoUE01aGdGM0xnLzdkL2g0RjB2SGlGVGNWcWljUkhyaGY4ZTRRdWJGa3gw?=
 =?utf-8?B?b3hIcHo5bkZhWUhNQk1mNHRaMEIxWkJIZVhZb1Zkc3p3eHduenZrcUFXcVpS?=
 =?utf-8?B?QXg2WitmV2dUQUVtRFE1aGsvUzFCSlNiaEFlVXBmMGZlUEtudWJhU284TGRO?=
 =?utf-8?B?ajV3TUhwWHlPVERoeGtzcmhsaGo0WlExdWFkcU9HUDhqU0phS2JKYTZmbmJT?=
 =?utf-8?B?VFk5MkJGbjVSeGxiQWJCM0V4dVozQktTZ1B5U094QU1pSk5lUUpoNzB6UW1h?=
 =?utf-8?B?Ky9ETFpManluMFFZeklLaTR3VkNkK1pKamkyZzBDbFNiOGRMMjNzYzRZVXFi?=
 =?utf-8?B?dDJ0MUI4cDgwUUJjRytTUEJjY29iNXgxOUw0UHFKUitNMmd1eXRvQ2lvRnRZ?=
 =?utf-8?B?SE5KRTlGMUNBSlFtZ0xHeUxESFpWckZHZ2xPU1hTSktGWEpwREZSUWhGSXRt?=
 =?utf-8?B?TGFKUHJyZm9ra0c4V0VpdDJoMy9xdEx3cHQ1cDhYZ0ZjM25WcEVHY0huWFZZ?=
 =?utf-8?B?cjQvMzcyS2V5TkJKM1dJbGFBZE5LS0daNzdWUVlWZjJSKzQvQTVWK216Y1Az?=
 =?utf-8?B?VVNSSzJpTjZjeEF4N2hzN3RoTWd3TmRmOHE2RjVlTmpQaEZTSVZtVkwrMFk0?=
 =?utf-8?B?MmE2dHJmK1IxWE9BRDd3UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzlIV1lZTTRFOEFkcStLQVVjSk9uS1QwdjZ2NlBvdFZISDBnb3czSmV3ZzNj?=
 =?utf-8?B?U05Ub3FqNGdvQTRQMloxMHFFK0k5bnR1YWZmd3k0SGNBWFA5dS92Wnp5b2gw?=
 =?utf-8?B?RTFNK1ZSbitBcDdaRzlSa2YyY3gxV1NGdVhtc3czOXEzV2poTE9XbGZLWVR1?=
 =?utf-8?B?MEpiakdUMmFkNTc5NnBGK2R1ZTB1QjlYTEhOZ1h0NTY1NUJnV21JMVpUbWVw?=
 =?utf-8?B?ckFxenMyVFE5dm16WFFTK0VxamVlVlJXRUxZcmdTUC95dGVsME4yL0s1aWpD?=
 =?utf-8?B?N1AzUzFmRVNTQ1dtMWgwZUlkSUNWbFpVRExWNEVWV2d4OVRXREF1YlVGaHVI?=
 =?utf-8?B?eEtuZUROMm9wcTNMVHNmR05TeWhsUlZrNzFvaXhDQjdaMWM1Rk1hRmRMMHZs?=
 =?utf-8?B?Ni9CUXM4MGNveUlReXJvVzNoOTBIMFZNN2Y3cmpFTE9DeHJuN2x2elVEMHBG?=
 =?utf-8?B?WlVoUS9uenBWckZMSXQvcGlFRHVNVVVUVGNrbmZmOWphV0VrdXpXWm1Fd3FG?=
 =?utf-8?B?UmlOT204WXROcUdtVHhyUVNFTEhhazlNRktyV01JSFRrSm1IRkFsSmdMVHg5?=
 =?utf-8?B?T1NNZlExQXlUMEhSOTFLR0V2NG5vMDBHdjhzelMwbGlIbHJmVDgrYk9PV2ZX?=
 =?utf-8?B?bDBVOGl6dmRTMkU3ZUVEb1BtWVFlMFcxTjNIMU84WSs5L0FoWUVXOVVMS2tu?=
 =?utf-8?B?NjlycHd3SFhHYXhRWWtRNGQzaC9mVWJma0w3L1R6OURKTTRxRTZISGE0VzE1?=
 =?utf-8?B?cFQyVUVDQTFVM053QUtFOEVTUjlndGZBeE1Ha3dkYmV2bVJkUXB6QjhiTjZk?=
 =?utf-8?B?OGxlQ0dSaUdEQzdxSHV0V3l1L21EZ0xSNXh3dFAzdWFRbWxWajgwYmc3OVpj?=
 =?utf-8?B?bHlyRS9tVDMyUFJHRnhqbmZ5UHptV3JHd0RJVy9uM0RhdmdQYTNnQnFTV1RB?=
 =?utf-8?B?M3h1K2RmUzBhUTR6UHQxWUMwak4xOTZyVUdJZk9FTEl0dG1QamhLRUo5YkVY?=
 =?utf-8?B?RkpBRkdoYitrcXdxWE8xMVE3QkVaWEVUcWZYRzRZTDVZbElRU2dkb1NSSlpP?=
 =?utf-8?B?S1ZGVVh1NG1XS2p0MnkxOHdaNFhYL3FqNjJ3dkZDaDZ4QUlVcGRiTVFqWkty?=
 =?utf-8?B?S3htTEs5R2lpUVFGTEQwSW1GSjM5UDFOTlBBSHZZaVo3NGp0RndicTdxTE81?=
 =?utf-8?B?emQwV1RveCs2WTZqYURBb0J4NjNsUFc1c1NRQnFUZ3hoNjlnT0VUKzJwVEhI?=
 =?utf-8?B?cUt6ODczNGd6dWt2ZXEzNVdRcFJVb3JuNENiOWFIcWVWaTJYeW9kT2Q3c2NO?=
 =?utf-8?B?dEN2b1RqWWJMaE5aWHNPeGhaQ3lpT2VKd2dIRXlCaG4zL0dQY2I4OWdXRlk4?=
 =?utf-8?B?dmw5MFFNUzY1SXRXM1RRazVtYVZxcm5wR0p5VWVob0gzZ3BDTWpUQUZIRkN5?=
 =?utf-8?B?eHNpeW10dHYrMzIrVFBGTnNFMmdEYW5HYUNzTGJCNUhXamVDWmlCbXlkbmlo?=
 =?utf-8?B?RFlMcEk0S2IyOUorSXR4ZklaZXNBMERFRTZiRTk5Q0pUMHZtamxic2h1NXRK?=
 =?utf-8?B?b0FYWmVBS1NRTHo2UG1YY1lPN25BUXY3R3MrZUk0WW1YV1pEdGlPU0R5NUdH?=
 =?utf-8?B?SHJMVmlTYWVkR2pjTmZqL1J1UEZiMm5WMXZNc000UkxMMTdjaXJvSk5BWHdi?=
 =?utf-8?B?eTRzSENlTWs1UTMreWVqY0tpMzhHbGM1bmNOc0VqT0hVdVBMMEp1RUlKR1hz?=
 =?utf-8?B?V0xXWG9hZlZyQ0oyY2owNml5VWtwbU5UWE9DTnJnSjNUd24zZVZ0cExVUWJL?=
 =?utf-8?B?K2V3bG1ncXdwY0JSWDZzUW5FblFNTjltOFFtc2lhQ3ZtVjlBbzl1MEhXbVdj?=
 =?utf-8?B?cUNhQzVibW1BUC9scmVHa1dJMndGMTdyYVlFRHE3K0lYRFRyME02NFNHMHlX?=
 =?utf-8?B?RXdpUTVLZGVVZHVoT0xTYUFRa2dEemlpeStGNHlYWWxza0FXbGZPQlk4V25w?=
 =?utf-8?B?R3ZaUnROVlNZUkMxeGRleUZzUVZkcXlnREJVeGFSaFdWRUlDYk1aMEtndVFW?=
 =?utf-8?B?Umk3bzJFc3NjZHNXUEZVSWxYenF1Z0tMc3pTTzFkV1N4SzhqU3BPSElTUFRN?=
 =?utf-8?B?WmZrcXVScVU1RWc1dXBZK2FyaWp4K3Y1WHJGWlZ2bzFIOWw1NnZTNzhkN3hK?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c25681e-5840-45f7-1215-08dcd0c2bd5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:29:59.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMvTySj2kuYEIYJwBY6rqdboT2QUZX7wv2oSqLun2V6Me0wXNqEE3AlIrj7GiMeynw4OKBPkiaLCX3fKcySGXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:30:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16872

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.223-cip51-rt21.bb => linux-cip-rt_5.10.224-cip52-rt22.bb} | 2 +-
 ...6.1.102-cip26-rt14.bb => linux-cip-rt_6.1.107-cip28-rt15.bb} | 2 +-
 ...inux-cip_4.19.317-cip111.bb => linux-cip_4.19.320-cip112.bb} | 2 +-
 .../{linux-cip_4.4.302-cip90.bb => linux-cip_4.4.302-cip91.bb}  | 2 +-
 ...{linux-cip_5.10.223-cip51.bb => linux-cip_5.10.224-cip52.bb} | 2 +-
 .../{linux-cip_6.1.102-cip26.bb => linux-cip_6.1.107-cip28.bb}  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.223-cip51-rt21.bb => linux-cip-rt_5.10.224-cip52-rt22.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.102-cip26-rt14.bb => linux-cip-rt_6.1.107-cip28-rt15.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.317-cip111.bb => linux-cip_4.19.320-cip112.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip90.bb => linux-cip_4.4.302-cip91.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.223-cip51.bb => linux-cip_5.10.224-cip52.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.102-cip26.bb => linux-cip_6.1.107-cip28.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb b/recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb
index 9893b898..c8f6ce84 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "f5190b70b33f389e7315bd2c8d80728e388fc8cf45957de3c81e2e79331a7751"
+SRC_URI[sha256sum] = "eaf443d103c2e5c28206f3141e643b86c5e5482e56b33acb7434d43224bb2891"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb b/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
index ac122f84..ee3bd939 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.107-cip28-rt15.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "7b11725df3d3d460d5f5a178517c6d4bf1c6e3354acb6d2a9b8df0f8d267149f"
+SRC_URI[sha256sum] = "5296cbb13076f4b7ac24fcb9220f1be5bcf1f28c7e5a00a71b84f67d5f85b35d"
diff --git a/recipes-kernel/linux/linux-cip_4.19.317-cip111.bb b/recipes-kernel/linux/linux-cip_4.19.320-cip112.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.317-cip111.bb
rename to recipes-kernel/linux/linux-cip_4.19.320-cip112.bb
index 42634e9e..d01d429e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.317-cip111.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.320-cip112.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "c426f71ad3c781cb545804577808b79d11a43c8ce639cf3edda27252d0fdfb5a"
+SRC_URI[sha256sum] = "15a4aae7d9092fc0a75fe677712f45c2fa0ad561ed94e4ce6dff9a9104039840"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip90.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip90.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
index 2d39e999..1d76094a 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip90.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip91.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "cbb0177ac6fb7f11be31180e2623280da9603a709279f85ab765b535dc69092c"
+SRC_URI[sha256sum] = "25b3bf1d260185ca61de9c13dc3bda6d179c07f992a6511adc504b35bf915801"
diff --git a/recipes-kernel/linux/linux-cip_5.10.223-cip51.bb b/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.223-cip51.bb
rename to recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
index 97042389..ccc8b77c 100644
--- a/recipes-kernel/linux/linux-cip_5.10.223-cip51.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.224-cip52.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "acad4dbcc1eafccbad50c882403c8aa8166e7c61c1dd8d30e4dac4edcbb8bdd8"
+SRC_URI[sha256sum] = "7c3538b79831741991ffe373261264c313c712b9520e746f8336356a621d3246"
diff --git a/recipes-kernel/linux/linux-cip_6.1.102-cip26.bb b/recipes-kernel/linux/linux-cip_6.1.107-cip28.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.102-cip26.bb
rename to recipes-kernel/linux/linux-cip_6.1.107-cip28.bb
index d0546d9b..4de454b6 100644
--- a/recipes-kernel/linux/linux-cip_6.1.102-cip26.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.107-cip28.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d14dd53b262d415e1a2e80a9dc6977156248ee403b00833ded66e126fb7139f3"
+SRC_URI[sha256sum] = "d7d491b9617751ef83e71fa9380a5d6b851ae90f30096b3debbd0d8d5b81cabb"
-- 
2.43.0

