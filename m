Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A96C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 10:49:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.70])
 by mx.groups.io with SMTP id smtpd.web11.9397.1675162144162732619
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 02:49:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SS0PoEhn;
 spf=pass (domain: siemens.com, ip: 40.107.241.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjG9I2Z7jfLr1Ugp1/SiCQOoF7YhJlqOfP++D8+JD8jPeeRHHdSQk7jd1V0Th4WrIclwwKD9ohn3g15PanXefAoSQJr+IQVoaEd079ceFciK1nO7jtNZY19h1gZ+Bk4ESnfvlL9vwBpoFMvIdP1pjReq/A4cK99Ii6k4YbKvEuoYQM3rGYb1czLSc6Eh+SxnRXwEV4P7BtmYbU1NdzGgXiIB/hR3Pu/3/JSZFd6r9yQHFcSmjTRofgn9zTVOvA1ES4XPnak39xCqNgxcAnlGxYI1JZjdlcsg74sqegzeos6XhxjGVQCvXcxMs8QVXJy6GkCZOa+JXPROcNdjqxIFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZowKGsQH53Q8bp5P6GQ2s4jwePekYhnIkvHsZUq81Y=;
 b=TNIYufrXxGujacrQmi5ITbwn4ExLM5xq4VBDXmflQf3Hkb7tzwgeZzJSBXC7bOU0H27U0YDFfPQJZa14wO/qpiCc1OAowNyxUHRKk9yaYj41DFH8JR52YELijO2LDDUt/CATcjtEaHJza0AkcB65xlAOwWxZccE2aeImAa64BPGkObGxDptNvzxPr4GyEXipBow8Uqr29VVaOLJUPO3D9uQldMb24yfDlfuwagHy9zG7m/nOARF2nFljinpo54B7haWuQFJiuNhduMTyEqv+tqiBBr6m8TUtO4N31UCACcMQ4A0+V1zuw4iUPfliBqiokoErt8UdPip9xrSLZp8K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZowKGsQH53Q8bp5P6GQ2s4jwePekYhnIkvHsZUq81Y=;
 b=SS0PoEhnsht9HD9nOpPfJk1+HA0wMLhuC2pwmV1r/dVV/Mtrlc3CQNaLgte18v+x1FnBTGmeNv5M2uC6mF59GghbyLUHSxoMyaUmcnPRO3Q8eOaJlbmNNUZyWYNNb2xj5mQ0A/uBlJozUnDypSqvya5m2DFe/h62NtR/WaRA16XOOZUxxB62i/4Y3BFvZcCd7UHq1flKwEgHUWwVWQ4L5RZZO5x8j3S5qQO73yeNymsevcgWYQYRM4WXUZVoXt+RaOTHKYfILyrM3ifjpK/8l5E3DKeXyPiGoIfxI0n+6l0+4NWbtOc1aY2vDZ1GB2XLQGDrozTBsP2vOxsxs4Hz3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 10:49:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 10:49:00 +0000
Message-ID: <7fc91f67-d431-fd43-a098-cb5d1b222852@siemens.com>
Date: Tue, 31 Jan 2023 11:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to release 0.13
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230127062331.250975-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230127062331.250975-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d866eaf-941d-43c3-07d7-08db0378c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l6fx/BjLyTxu6kZ80kgoYH8b6weGdm14DTH3XfmmaFdW/svOxJ1Q23SywfyzdEzKBr3GwpQCeiQ1mGamVZsGKHQo5H2GLQYL9XKZjCqB3fvxX2wIQIvT00+F+Oi9kcXifizo53MOGWj2EJys3dMxDWkpqBtl67/HqULTCY9GcOWWtpZnCIi2KU5eL8Ujw+EQthwwi27Jd2n3UxdkBB2vGEJLRxVFmo+DCnQfHa3vCLsspm6io+hh6Mq4Q/x4/V2xMsnHAKssh7sScLSk4upLOTftpvmfJr244XJLJjM1mZs2ULb05vEPNbdLCljetoWYtnhp87Y7NxS3Oq0dxJS7eq3cqVmcvUaGRjxm3zrVL5eUPp+IlCNKW8TMzP8bso2yZtiY5QdFDVyhioZu3k5THvW7HLIbh6mjm+sXpX6dnH5fJ/WFcBZ12h4x4v7npUZ7Kbeecx8Swj+PsR8WqOoWt5KXUrWCplQHb85rNgA0XZwXSSMv/Sn85wbc84p+/SF1QjztOkKrYTRC63mjS7hxvva1P8GPD8giXr45VyrqupBgfBjvTsJ1m1BPq+RU3st17TfS4noJjkokqhCXzJSwn+79XnGtgggIO+AE+JrReFw1M5364IXuhgD39RZ8Jq4bD6j1+585YwMAHFMyGFFP6/p4gi5fsAErxNODwoEG8mB329/uoCFkSB8fzqlORijn/Aas7vzEdQMWWfNx+N/ZUYG0eJiyeOYWdVqTc12EWJzitZHQckCj8JD40ES8WrMcD1wggNZGVKdTDYZklbwATQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(31696002)(83380400001)(6666004)(107886003)(6486002)(316002)(478600001)(966005)(6512007)(26005)(2616005)(6506007)(53546011)(186003)(38100700002)(8936002)(5660300002)(15650500001)(44832011)(4326008)(66946007)(66556008)(66476007)(82960400001)(8676002)(41300700001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmtTTk8zeGJ4MndrS1dZNHVEMFVHWUFZQzE2WjJWQ2M4dHpjTU5MVWsyMXNM?=
 =?utf-8?B?RUY2Q2dVdzN3MFRXRGpFVGZ3RlRzMEFtd214QUxYNlc2NzE4eVFYVXFTUzVT?=
 =?utf-8?B?ajFRVER5MGpZTWlNUmpOU2lCWXJXMWN5RVRpRTgzMjEwVnN6ZkovdXA2Mm9H?=
 =?utf-8?B?c2prTTRUL0F5bU5jOGZ5MnpKRE5SR1VFSCtzemdPU3JJbWNzNGdweHNPWHpl?=
 =?utf-8?B?SnNaUW5MdmJ4SkhmYUpjY0RzSTkxdXVTK3JFZHkweVRZbHRhb3E5U2VYY3pR?=
 =?utf-8?B?VlU5amJkWWlCQ0pUTFJjM3FTVEw5Nmg2azVkZy9RZUV5YnhuNHdWUFFzcVdQ?=
 =?utf-8?B?bFRmTXpzOXc4TkVxcC9wWWRJVU9rOHBoTWF0SGwyNmxSV05lakRkQVNKSXV0?=
 =?utf-8?B?bThQYWZrZjFnUW9KZVNJR2R3NjVKbHJKMmxHaGxvVjNMVk5obSttS1VVeElY?=
 =?utf-8?B?ZjFMVnhzTkRMMDB3cXBzSElJTnJmZnJySGJocVh2SlR0enA2U21od0JkenNt?=
 =?utf-8?B?K1FLTzM5eUJsZVEwQ2llbkQ0ckVIZjBGbHR6WjFldGNFZTN0YWpvK3JvK1hZ?=
 =?utf-8?B?bm50RG5JdVpHdFI1amJpelNGVk5oOVBGR3pSNmVwR3c3OWlNRW5pUmk5MFJa?=
 =?utf-8?B?eE8ycHVYdFVhWWJ5SlZNNXEreGY3Q2lYUnpYTHQ4a0JobnU0Ulg5VktFMmVm?=
 =?utf-8?B?cHRUU1VuZWJUU3VpU3dyV2h2c0dvcHg3MUJpdm94bFM0SGk5Qk92K21JQXZt?=
 =?utf-8?B?Zi8wd2FPaWZqTHFsbDJ5RUVXSElDNHA4YWc4WXkxWjhzQzhmSUljTnQraXRh?=
 =?utf-8?B?QW5Kc3BLaFpyU0IvWjVhTVNmM1Z4UG1pdlNQVDZlZVNSZCt0NzJORTB5NmNx?=
 =?utf-8?B?Z1ljNDFwaCt6eFN1SXRWRGgyWDhyZngyN2V3M0xVT2VqMUx4Wi80VW1xSGRW?=
 =?utf-8?B?NmRRVkhWT2ZaajRYUXRHRkVuc3FnODVSMjErRnpwZVpUamMwbnVKRWxaMFNq?=
 =?utf-8?B?K2F3MGozN0FKWSsyVlluanFMNVBRcVdWcFFZaXpDQ3oxeWErU3BPT1B3M2VX?=
 =?utf-8?B?dDhCRm93WTAxTWpMQWhzWFRGY0F3SGFvbFVrWjdrQ285RTREbTRLWGM5d1pr?=
 =?utf-8?B?S2VscmMvQkdvK3Y5eUYzZEk1OXRMdU9mc0pwZENvSWdyOExEVHp5N1hFaTZI?=
 =?utf-8?B?cmlXNjl3cU5OajBwNTZjQWtVaDEwUXJCNmRWTUlIVU9CSVpOVmU2cm16NjQ4?=
 =?utf-8?B?MzlIUEtSM09LY3c0Y1ErdFZaMzE2aUQ3bWZEREFadTNDcGcvWVpjbEtVdlhY?=
 =?utf-8?B?Q3Q1bTJabWcvUjc1Ym5CeGRFTWxibVIvV3dPYVByNEhkSjFNVGQ0OXBtYVA2?=
 =?utf-8?B?U3lSK2VOenNjd3BPem1sdHp0dVlvbUt3MlJoR3ZocVBXeFZjV25panRML2gv?=
 =?utf-8?B?bUlJcEhSblZKaDNDQ2NYRmVrTVBCdEFkOEljM1AraGs5dHpvM25MQmlqdklY?=
 =?utf-8?B?VFEyUjBpZWRFTHlNS1ZhMUZoa1BjOENDcFU3RmNFT244d3BzcGlRaWJmb1Ew?=
 =?utf-8?B?WnhISEw4Y1ZjTTBEMGJTYkVSNGJ2YXlwWHBsY0xIZlVpQ0xVN25URHp6YitL?=
 =?utf-8?B?OUw2djB1MllNWWwxWCtZcUxuQTNpS1NhbElZYWg1V1FsSjRYZldiWXBzUnZB?=
 =?utf-8?B?SytxM0FtQzRpa2JGUllTU3RzcHZoMnQ2dURsc21iTHBlRUh6SUdTTTZoYUF4?=
 =?utf-8?B?anNIVGs4bC96WW12TTFPQ21PQUNoR3pXbm1IZzk3OExIblBuOU80SG9pZHRQ?=
 =?utf-8?B?L2puMkhYTjZpcG1oemxBb3FqekVkcjhMSXJQMkl4Y0Ezd1Fpb09NQmJkMnRN?=
 =?utf-8?B?QWMyMHF3SlkvZDVidUhXZkp4OW9EQmpvZHlyV2FMVzIyeDNabW9aWnNOajNR?=
 =?utf-8?B?aTJUOHcrYUZyN3liMXdWcVE0TU5CZEpSRkk2b3VNOHU1QzhvUWNCUEVnRk91?=
 =?utf-8?B?L0NTYXRqaytNbStuWGtPcThFaG1xaG01SDBNVW5YL3ViRDVUSEVuOFV6YWkr?=
 =?utf-8?B?L3VobVM5SFRDM2ZmVzgxSEhuSkJCVkMveG5ISVlOV0xHMmk1TWFUbEphSWZM?=
 =?utf-8?B?bFVlcHBpNXlNaytzQjBoZlFpbWxOTy9MUkFXWmZmTWRxTlBvZWtIMjd0b2d2?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d866eaf-941d-43c3-07d7-08db0378c2fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 10:49:00.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbV4HreAM9Ihe8wBvAJwDZHjv8p1bWEvZj1zBtD4E+aaFoAKzPyUGfBaOOffzK+cTvrbtcoIwg9Lbf5vuu+iRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 10:49:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10519

On 27.01.23 07:23, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update efibootguard to the latest release.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  .../{efibootguard_0.12.bb => efibootguard_0.13.bb}            | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.12.bb => efibootguard_0.13.bb} (91%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
> similarity index 91%
> rename from recipes-bsp/efibootguard/efibootguard_0.12.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.13.bb
> index 721b9dc..79f784b 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -20,7 +20,7 @@ SRC_URI = " \
>      https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
>      file://debian \
>      "
> -SRC_URI[sha256sum] = "fd670f7a60a605c68ed411a9ab83ac680fbc9a9b5a8fd7b417c049f6cba5b6dc"
> +SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
>  
>  PROVIDES = "${PN}"
>  PROVIDES += "${PN}-dev"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


