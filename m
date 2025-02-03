Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F74C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:33:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.75])
 by mx.groups.io with SMTP id smtpd.web11.93868.1738604025674353962
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:33:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BHPZIyvo;
 spf=pass (domain: siemens.com, ip: 40.107.21.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHVCJxFg/PeScXHyZyrcmxgml8EtLsZG8ZAxav0P8zWeO5NBoPPYMsQxyUtpNXk7CTS36YoWOwn3wp4NqI01jTsuJIIIVssgF9ERnTk0wbqNTInH84lNtLZon91Y5YDysQvYG5otskaivP1LgoKr0TxalqIUYqr1Wqo5dakLnNKJZRsDSz50Sk2a+h+ViUq1qTHWCqv1MRT225F1iHA7Dy99ylSHI7bNzb8Eq1gfjAiiqi36SY7JW8hY96shR0U32uwX5R9akTtFhPTaLaLLbW24E9Wjr4ZYxUz+UGPrgbnsc/vlO5ssX9AwJWUakt2jU9jEuU8qXWyxIYIF93v3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3eBj70zrATwRKpmInlHSHfPprNXIxwSENhbYnkgEGQ=;
 b=plINLD6Yi0yoWoE56GQmiHatA0/QO+Aw0z6bSyz/0g/gZ+xwIFXCMf14IdnSoIvZcdc3/1PoZLDBErjW+WWozgBfdrvpbyKavr+a1pdnBgsErItQJvPWrruqXsnSrEZSuse6nMSe3URsWI5r6osnCOqKfpA1mN4/ECP/Clx6d9AW8UfnC3iPrcV5b9p8VQYMtv61Z5pzOx64s17I23julpd13+dkau4rnsEfggXdzEu+81Al+dYRP3FcUZgpHZjzOue2q0Y8w7kloGZpRpwRwMiqFssCuNf+jTIk0JE0mPbEi4clF/orIgm5eI15msd+PVYdduVR9vJPet7V2G6NvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3eBj70zrATwRKpmInlHSHfPprNXIxwSENhbYnkgEGQ=;
 b=BHPZIyvoG5LZG1w86/hVniMm7o5toTPy5vylfs15cKlQFLZjTJLM+5FxhwUv2kf1qNCET7bLhbgKJkwePanCUQDaKSNf9ej12pD1D3yofL5t9Nf9ar1Q41T01pWR1vh053Oc/UeiSfr0kGARkwz6oNbBc7L8Rr2i2sb5ONfSDZCqsOjqEJQSJh3oiFzFR7pnHu835rxp/fUzWFWPHjYP/0p3gKjYKGdZuZUgxf47A0rBMSwnsQV3iZllhxiZSKHE7oQ3IgHyR1qZUUaemb28qtX1diFN3vDs6ltle08hQdSquneapJX31VNFlR2vxh0n2myv0ndqJ05gk4DrRWl7Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.6; Mon, 3 Feb
 2025 17:33:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:33:42 +0000
Message-ID: <17ed6202-fac6-4920-ad7f-80a5b0deedb9@siemens.com>
Date: Mon, 3 Feb 2025 18:33:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] read-only-rootfs.bbclass:
 Exclude boot,home and var from the erofs and squashfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, ludwig.nussel@siemens.com,
 felix.moessbauer@siemens.com
References: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e76f4a9-a743-48ed-ca53-08dd4478e74a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RWR0NjlpZ2lXdStPM2lqakNLaW9FNXVjS0Y4d1BOM294TUdNclF3bDZUbHpP?=
 =?utf-8?B?NVgwUnFaOEJpaC9yRE5zOFJyRXBDZ2twRlpCcis0dlBhQm9YQlpPQ0l3eExM?=
 =?utf-8?B?RzRQL1hlWllVU1VtQUQ3bnBUR0JnbzZvTy8wNmxTN0JnT0lETndTT0l6RFdJ?=
 =?utf-8?B?TkdURC93d1Jsc29aOTRUSDhpSk5XVmpMQXhVWGZDV2l3N1AxUTJSQXp1Q2dy?=
 =?utf-8?B?WWdXaVFxeG95akxYdTFHUnNVdWZtK29nTE1GUTdYVkNzOGVxNmwzM0haclg2?=
 =?utf-8?B?MWNSSk9DTjZhR2Fwb3pSQzdVdXZvbzlUZHFUNklyWlNRSVNuY0huM1laMlYw?=
 =?utf-8?B?Tmh6M1o4OFB5bDE3b2JTcGlGN3lWRmZNcEJidE5VcDI2U011YU1xaWIzZElQ?=
 =?utf-8?B?RVRCV2szV3g1bWF1WWRMQTlzWitMdlhjWFRNd3prZ3BsN1FyM0F6N0tuT216?=
 =?utf-8?B?MWNUKzdrTThjcmVUQkVjdWtJbUdwY0sraDNyTFJrTkZGRHRoQ08vN1lQZjJq?=
 =?utf-8?B?U1EvSjlqMnJHTHh3cGQ0MFRnMEJxRkl0TFRGd1ErUkJJSjZDQS9QZVVYTUJI?=
 =?utf-8?B?UVZ5R2QrVHdqUUZva1ViWHNmTEs0K3A1Vko2K3ZSTkJ3azJUUGhraURwbisy?=
 =?utf-8?B?aFNxK1VJeFI4TXI4UFl2ZEJEakFOeEFCRG1Ody83WDc3SGUvTGVici9qTGNm?=
 =?utf-8?B?Z2NvbkFHNGdSR2h3Vk14U052ekY2aWxFZ2pQUkMrek5VUStZN1NlTTh2cTd4?=
 =?utf-8?B?eS9TM0xWcm5LLzNxOFJJUnBxSDRRWkNOZ0xCZndjMTBpNkJUbWJJYS9wcjlN?=
 =?utf-8?B?L1g1KzhXK3VFQzF5ZUxJVCtJRjk4T2prQ1AwN3QzdGNaamFjY0hzSFJoQ3d3?=
 =?utf-8?B?MFFZQ0VmK0t3eEJTTGN4a3dITlhoV1YwN1hETFBvMmtFek9IcG1mV3BIdGJa?=
 =?utf-8?B?Zmc0Qm5BNkhXUmt3YThtRUtyS1JYNkNXcGRqdnFFZmxWQklCRHNnQkRyWlF6?=
 =?utf-8?B?Rllqb0g5OXNKbDdFeWRkcUNQWlU2YnZaT2hpOC9BNlBxZ2FxOUhEM3VhWXdV?=
 =?utf-8?B?dTdGNG1NcCswWHRzMjJFcEI2Zkh4WkFGam1LOUNjS0p0VnpWQ2E2ZWtiQ29F?=
 =?utf-8?B?dWtTUW9LRE50YjJiMno5MXRWMVBaL0JXdnVqd3paRnlhMFdwdzFZWW1wWk9K?=
 =?utf-8?B?aEpQNDVhQk1CQzBGa3JmdmtDTk9vbmJwZ1Y1MFovMkRTbXhaSmhIeDdZbkNZ?=
 =?utf-8?B?Tmk2ZUNHZ3VyV0RzNjRtckRMYjFHdjc3V3UzMnQxeVp2QnlSdlFldTVaTlgr?=
 =?utf-8?B?eHVPMzRROEk1T0VIdDIxWWlUcWEybXB4RXMrTjlhUGpwVVdab21LK2lhNWVy?=
 =?utf-8?B?WlVVZ29vZVVJQTgycnFibHpHVWJ0ZDlqOVMvN250QXZJL0NRNlZjUHJHb0pX?=
 =?utf-8?B?ZUpKWHNWNktwRGhRUDVoeUNOQzBqMVVXQ0x5N0ROSzJyM3RFbENidEJpeHls?=
 =?utf-8?B?NFlqTVpFcU1HTUJ0UlV1cEJaZzBmRjhkWTRuNnBmUzdoWldYM2RSOUc0czZN?=
 =?utf-8?B?Mi9zMExEY1ZMZkcrRUQzMzdjV0lXTVV3S3FTaktpMUJmQmFhZDVyOFhOZWJP?=
 =?utf-8?B?a1ZycVZmMzBOUUdNQlpIeGN4dFNFZWRsNWhocUdqMENEMTdwYmZvTDlyUGRn?=
 =?utf-8?B?cURpR1RQcG9lUUtnanVIKzJZZk5HdEFCNThzUnZwb2dBZmpUZ2NPOFp3STBJ?=
 =?utf-8?B?NUFic29hYUdSRW9pczREemNkNjdUT2hwRnp3bnlkUnQ2RUpUd01CdUdXd3gy?=
 =?utf-8?B?akozTFpWNEFvME1GMVo0dTBQd0tWaWZmUTdURlM4MEhDK2RnK2N4clFhbUVq?=
 =?utf-8?Q?5SvmU4n1eIA+t?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGUvSi9kOFVtV052U3lkL1BHa1FQVVZubENkL1RRcFFOZEUzRmM0eU55MWZL?=
 =?utf-8?B?eEtRVkR6RHFweHkvb2lXc2Fpc0kxeUpzY3pYenN4SU1IYm4rZDVhNFNlWkIy?=
 =?utf-8?B?cHlObDk3MnFNNWJZR0NuK2tuQmpDVUVwelVwRkVkbnk0RW5PckozckV4Tkp2?=
 =?utf-8?B?blp5d28rYUorN1NISDZ0UUsydzlpcHlCRlZlRUt6cGkzaUtUNVJFTGoreGly?=
 =?utf-8?B?elJERDhRK3ZUck1jd3p5Q1MySS9PaXZ0SEgrTmgxWTA5WktXenFuZDRIcFIx?=
 =?utf-8?B?a0pJZzcxN2pYbWoyeWtDbWYxMjVkZ1ZZMlE3NEZMU0hhR1pWQ0dQQitxRlQr?=
 =?utf-8?B?NkZQV2hPSkE3aHZ5cDZJZ2UwK3JnNXV5WHBJaWFDdnUvOVgrVlJKbityKzIx?=
 =?utf-8?B?QmVPSXMyWG9WSE9sclhWYXlYUDJCMmt5RW5UeE11cnJhVnVaWWxOUmN1cTM2?=
 =?utf-8?B?dFRvWlJ4ckY5L0dnUUFyL1VhR3RYVDlzL3lkU3o0TXgyRTJIWHh4NlgzcFVE?=
 =?utf-8?B?WENBYWRCTmUzTDFadVJ2S0dMZTlYQm44c1JKK25FcVhFMkZodlZtQXkwazgr?=
 =?utf-8?B?UmR6RXVyS0lQU01sNFhERHpQL3J3emxNalErQll2UktOcEJONTJjeDE1UExy?=
 =?utf-8?B?NWF4NWQvekRhM1g0OThVOGpLdkFkU0pZUmMrcTd6WlgrN1JNeDIvVnh5SnY5?=
 =?utf-8?B?VERhdzg4NDlaZUd6WGF4TnlTTkgwd2JrYmx4Q1VyOHlUQmpHMkwvY0FBSEh5?=
 =?utf-8?B?Zng5NnRLbGpMZW1ZVG1Xemh2b0Y0VWFDbTRxRm9rNzBCN2FIdFpLU29BcDBZ?=
 =?utf-8?B?U1pwclRyNzcrdlJLRUF5TGZEN2dIbTB0dGRhSUpUQzQwWTllelVVeldPZDFF?=
 =?utf-8?B?aDRpMlR3TUFadkcvRzU3TlhNL3hKTHBOMmR3TDEyaUQ3aWQ3S243WVl0eDk5?=
 =?utf-8?B?YWhCNFNYNytRUlQvQm1YSWxiaEtNb2pka3VTeEFIa0paaU94MnFoUG5CZDg3?=
 =?utf-8?B?Y0ZNWERtWkFFVGlkSTUvTllVb2NlbHJIVUNnR0J1U0lEdjJ6Q3Z6cFBMUzdY?=
 =?utf-8?B?VXZkOHBJMDNXN2xYVUkySmhISjRyelZQdVRZQ2gvWCtmNHZHcDlzODUxMDhV?=
 =?utf-8?B?R3granBpRWVVQnlLWHZYVGNhNDB2eUlIMmlrSjVWa3NoVHF2RWF0d0pLWlgw?=
 =?utf-8?B?ZTlBMUZWSVlxNXBIL2VWZzBqQm1ic3ZZN3BiWUttZkJpMnRCQU51RTVmUG5a?=
 =?utf-8?B?d2pnbTVrY3k2MGY1OUhrTDlXcVhkWFZ3UFQvUGhqdnNsMFNTT2M2TmpOL3dj?=
 =?utf-8?B?c0RCcmRZbGZVVnZLQjJFelBkTDM2L1g1VzBiZXBnYTFEOTlxTHpVL0hVemcv?=
 =?utf-8?B?eTk4Y1pVNGY1N1NPU2hvSGhwcnNGZ0dEUGhEcFNWOWVURXYvR0RhSTB1ME9G?=
 =?utf-8?B?ZTN4OU1MSFFmbDF3Q2wvYkhmRnQ1eGdTTXRucG1ieDhWcjI3NENRY1pFcGRk?=
 =?utf-8?B?TmNvbnRxWHN6YlZvQjhHd2ZYQ2dzQVM2MWtsaDdwam45VXBuaGpQMWlxdVh3?=
 =?utf-8?B?M1ZGd05MdkpDMXFLSUtGaTh2WW1zcU83TmZJT2FQSzhYUkNGZGdaaFkvV1Fj?=
 =?utf-8?B?MU5mTmdPSW9XdC9DZDBCeTBSU2JYanYyZ3pTOW95dWhsVjVBQXk4N3RkK01W?=
 =?utf-8?B?ZHg2MVpkWlhqdHdZSU5DbkliR3lYMzAxMkNuVTBEUTZTMGhCTG1PeHdqa28r?=
 =?utf-8?B?WW5FaE9sd245WEg5cWlTRDFGR2t5bHJpRVNtUnh6eG9YdmcxYTR4Lzh2RGoz?=
 =?utf-8?B?Y1lSSWgvVC9rc2JCM3RTWXpxcjlXdFV4TXlYdk42NzZTRjNXMDNVeDlUK29o?=
 =?utf-8?B?QjVrd0wyTy94VEprRm5QNlJpTVFmQVI2V1FyTG15VzNvTWcvdFJtaGhscE5F?=
 =?utf-8?B?NXRpaTQzNGpzU2p2YmltaUsySHpYTlNpNjRxL0xRd3BNVnlpM0pHU2RMQVA2?=
 =?utf-8?B?WkZJWkIzNmN3VzQ2OTZSMUxGM2NUWkRWVWdpdmZzbC9ha1diTndxWjZNYUs2?=
 =?utf-8?B?OEd4U044L3hOTmxYRnB0blN3S0dTcnh0WUV3OE4rOHczUDhWSWhHUjg3YmZK?=
 =?utf-8?B?NlhuckVDT0phMEp4UEV5RkdIMFFYQjZLU2dyYnhLNnRmaXpXbTV4akcwRCtL?=
 =?utf-8?B?RG9RZ2VyMC9rdjMzYUdUeVRBOGJBQXlVUk1ZMEpsNDRJSEVmdkgxZTFaMEpQ?=
 =?utf-8?B?dU41QW1WWkJsd0xodVNlcnRkOW93PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e76f4a9-a743-48ed-ca53-08dd4478e74a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:33:42.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gydYHJ4LSACjPFio6EVSRn5mLNFy7i0T23Et2QN0DizsoeuqwJUZZlEq2cNCsEz0AjBdc/zGPR2I+oMhto5HXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:33:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17735

On 30.01.25 09:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This excludes the content of boot,home and var from the root file
> system. Home and var are stored in separate partitions and boot
> is not necessary as we use a unified kernel image(UKI). This UKI
> is stored twice in separate partitions.
> 
> It should fix issue #126.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Also exclude /boot
>  - define empty RO_ROOTFS_EXCLUDE_DIRS in read-only-rootfs
>  - define excluded partitions in recipes-core/images/swupdate.inc
>  - Update Copyrights
>  - Add information to commit message
> 
>  classes/read-only-rootfs.bbclass | 6 +++++-
>  recipes-core/images/swupdate.inc | 8 +++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 9ebcadc..35a3ab3 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -34,6 +34,10 @@ copy_dpkg_state() {
>      sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>  }
>  
> +RO_ROOTFS_EXCLUDE_DIRS ??= ""
> +EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> +SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> +
>  image_configure_fstab() {
>      sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>  # Begin /etc/fstab
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 81c3365..07dbe97 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023-2024
> +# Copyright (c) Siemens AG, 2023-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -12,6 +12,12 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +# read-only rootfs with /home and /var
> +# as separate partitions is used
> +# /boot is excluded as an unified kernel image
> +# is used. This images are stored in seperate partitions.
> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> +
>  SWU_SIGNED ?= "1"
>  SWU_HW_COMPAT ?= "cip-core-1.0"
>  IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"

Thanks, applied (with spell-fix).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

