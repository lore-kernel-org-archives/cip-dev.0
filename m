Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC59C47077
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 15:17:25 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.81])
 by mx.groups.io with SMTP id smtpd.web10.17344.1705418239536517625
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jan 2024 07:17:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zbwLESTY;
 spf=pass (domain: siemens.com, ip: 40.107.20.81, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2HUxkKFVc3obS41BTjeC4N7VbIF8GPcmY0OkZToxgl+t1GaPqCRDEka6gCu5qII22004UKn4h+OgvXik4Wk+ocMYWRPAV3P8fMZb5jQLCv2jhc5MFDruGj54Q9oib+J8ffTur4aQxzvust9ekoIB5KjHZQiqUhC792ViwFwdebfSXEoVfP9sDGoj0jraDTIw1GQq/1AXpjqDPYKN7TMyMEEV7+fSU3RQ2BQc1cq5TI/wIXnNRHCkT58U3VBXtWSZv90A+BSwjZ155D/ITiyK5MPX3UH/b1OU1RlB2uVS6RHXg3fWBR/SIQo6bHCvq0Mzu0W0lMGuNZhjHjUgFQRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoE3zZ+0Dw8n38ONbelbe3ASih1J9zlFWzL/Uvq4Us4=;
 b=VN32da/e/XeQoIYxEYbKepynpHC3NB2g5mrd8SThB0BReZgwB8N2nTJJUKtM6htpcyLdQNGOQrwJUWH09y77T7lHVqtd5NDThwNdQXhXPWFTQrgvZgiB3nROXufMdx3bm7R+aPHgNtehNtvuh+CPXTR3JyX9hDhwtL18hG8COTKdyIpjLuW6MdEoz0NU880/RKFRM4bhe23V2a/17DUUEqHZN+j56rBuaIQEw0aZo/nnSM+ZxPN1KL94CnX5UyGmGeyG+lJ2zXh/0jkEuP7pLRfV0gFiwuppr558577kqD2tb5ADDnwQlyPmD/EAaee/pbByOyERWvmDHp6VXKAmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoE3zZ+0Dw8n38ONbelbe3ASih1J9zlFWzL/Uvq4Us4=;
 b=zbwLESTYLWBIAD4ZXm0oe9HLFhp3qUyCHkC2Bo/ZcMB1urlhBfuRn0X3KwgIXwC+VBLePAqWT8lvDPhHlmOOHhKbHrlFXaTFFaGHUF1RkBp3ymPyU3MGfVTJeFsUDGN4wMBLFIfSIMyvKMC2RNtFBzV14dPzVAIVzXlTQ1gXH/waha7sr/1Kx3VguHlKkS3wUNjTmjjRZvOnIq+njS2Q0B6oeE0l7M+Yir4fiDRYkWg1XSzTgWQd8yrdYIZs3YXoFIC5G7BlSaz6VtBLGByGyEr6W2s2HZZixKa3ZCanJQ/1sm2tpxlIyajWUr8EtQEUVBaBTS5heMAKPBMggAlEAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 15:17:16 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 15:17:16 +0000
Message-ID: <c3dc60a8-ff32-4e16-a1af-9087b4e84193@siemens.com>
Date: Tue, 16 Jan 2024 16:17:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to latest
 debianization
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <2bb4e18b-20bd-4dd0-9301-fb08aea7a730@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <2bb4e18b-20bd-4dd0-9301-fb08aea7a730@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2679dddd-c5d0-46a6-6a46-08dc16a6392a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6464WMJfN7mvUlZOPHIZKkSkQMRvu9Lyn4mLSQiv+Nw92+wfzrvofACUgDydN9UghHjtcSvvTrvARc6ajJKBxyD1NEV/wBOWNh5fO+93n3Jm13/k7LB8+UvW6fzzsYxJ0NBQFx5VIujsY6XPWjyw3rohrTSgdWGXwYE5CizYjbAjifUv3y3eCNfxtQiheVyJHUJJFRMxHlL7Qo1y+MYNipWAvNHy79ULP1Ilt+Gi6s/puv2DVj1MMrspw+XytlZOZgegf5gSlHjBHEPIC0MWc2QqSGcN5ArlCZOz042DtkWg3nvQ52TwKtufZArE+BLSjlW3d24FmHvVecJ2jOOwmXomFWZWdtwoE5KFVxfZlwcXR4hVxu5OL13VOXBcrbCEhRJIU4mmG5iEMyjo6IqPXN4wZLXH1RyI4YWD9zVOZUoXtM4CiRFEKMtvBVrVaJGu1skqWpSFMMlgVknwENFRkGGWlmXnHpAt6XxGZHouDVv4BfW+QtubffJIWhOc3OqsnP4wlX3nigTNrDAn5ajGRWC2TRs+JMc3XJ4GoTqKy4xnVXq3V8nHznQNhe2woIbW5Tnxtfvm/V1wodf9tn5ietuwNrUm8qiJ2GE2rJ14gPdraOP2swaL/a0wifZzSVqlxPQeYerFUIPvf8icb2evQQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(53546011)(6666004)(6512007)(83380400001)(2616005)(5660300002)(110136005)(41300700001)(6486002)(478600001)(8936002)(8676002)(316002)(66476007)(66946007)(2906002)(66556008)(38100700002)(31696002)(86362001)(6506007)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjFlek53YU54dHJ0QUZvVDArdGJTZjZnK1l4Y2hocCsrZWRkRmxuN3lsOW9M?=
 =?utf-8?B?TnN2M2piNW16WEE0cUFoRitTOUpGajdsemZhUmcwMkp3TUVtdi91c085TUht?=
 =?utf-8?B?TkU5Y010SmRSa2V3bzRHcFNpYVIycDJQdDdFZ3NIblRnZTE0NHhsbXIvTHNt?=
 =?utf-8?B?KzZmUVJ1dFFPU3ZzS0h5RCtjK0ZQcCt3Y2pDcm9TckNLTVZYcnZGTnFkU3d4?=
 =?utf-8?B?YURPclp3bDMrbnRidy9yRnNqRGxRRnR2RW9lQ3Q5OWZCUWhyOWhmb2lDcFk4?=
 =?utf-8?B?Qi9YcDhKb1JTV3RyakY4ZmRCYjhGY3hKZEkxZ1BFcDBjekxYTmtJNnVMdXpF?=
 =?utf-8?B?TTJxdDd0QWdvdklWTURnRVlQYUV3M3VTYTFzUG9iNFVnRHFEb2hJVU1QTmgw?=
 =?utf-8?B?QVRXMkFqVVc4MURpSzlRVUNUamE2Mkx0SHlYVEtrNGR0YTdEd2RWa21XRG5J?=
 =?utf-8?B?eGxHSEpCTndlaU1RdWRMNHF6aUN3WjY0U3ptMmEyN2ZmUUJtZXFQR2h0cWUw?=
 =?utf-8?B?aXRBcjJrbnBrNWlEaDVXNEh6ZnI2WDdlM1VJSmlsSmtlVmljRzlSTW42ajky?=
 =?utf-8?B?V1Z2U1crQXB2TVdlNlBYbkJFTVd1WjN1UUVFYU1kYUxRK082dTVMNUt4cHFC?=
 =?utf-8?B?bXE1QzZLejJZbS9COTlEYXJiQjU3ZlpCcGp2c2tPNTd0UTFFY3Ztd3NUZkU4?=
 =?utf-8?B?MTVaVnozQ1I0dGNsakRKWFI4Y0FCQTZmdWV5dVBpZSt3eWY0U0U2K08zUm5i?=
 =?utf-8?B?THlYNjBSN25uRURFQUoyTDZOL2RsTGI4TnYrZUk5OStFZGwwakFEUTRDSzNH?=
 =?utf-8?B?TXdLOVU0WU1QK0FjbE1GNDFSMU8wcUxpNG1jOGpXVmJRRUdiemFPK1drTlhn?=
 =?utf-8?B?V1J3c1A4MUZINUlkVjA5cEpENUxrZmw1YVpjVnhOdlZSTFprallqK3kvc21H?=
 =?utf-8?B?SHFUT3AvZ0EzQjI1V003ZjlsdExabmdqU2JIUjNuMkZxWFRHa2doUEh4OUxm?=
 =?utf-8?B?OFpxSlZxUERvQUNLbyt0TUpPZ1BIbHBwSE9EaGRzVEIvMWlUQ0taSko3YUY5?=
 =?utf-8?B?UFVzRk1MQjdLRy9HZXdVTTFhdG4rQnduZ2pTMWNOZUhPTjJpY3dId2cwL2x3?=
 =?utf-8?B?Vzh5UVNUQ3FUNHdTQ3lKYU1zMDN4VXdyQTNIeSs5UFNxSGQ2eHZkT3BncDVh?=
 =?utf-8?B?VEpTTllBcmVlZkh4NjN5KzcvRzMwSUdFelB2N0ZiZndlemQwbDZVdHFyUS9U?=
 =?utf-8?B?WXVKc0NNMFZOTUg0aTAzajNGZFRrUlIrTlkxRUpNbGpnZFJKUVlrZUNrR3RC?=
 =?utf-8?B?QlR6RWhzNS9rWnRCNmRzeDE5YlRNd3hIQUM3SEVmU2Y1MlFyRzRYcjl4dGIr?=
 =?utf-8?B?WFZLa21BWkY0eXBleFdOamJsT1hwUkJXYVBnME1YdXp6eDZIeGFFM2xMOE45?=
 =?utf-8?B?M3g4Q2R5bDV1UWo0Ty9TOG9NdnNqbXcrQ0JkSFNSQ2J1V1ZZYVJnMzFUenBX?=
 =?utf-8?B?R2ZuaWVpdThYTStsYy9ZMFFoUDEyQ2MzV1hVVnpXSTk2aXovdmJrL0xtWW03?=
 =?utf-8?B?REEvMmt6VUlROUZtUWFhTVYrQWtIdkkzWXBlOW1abWJJcmdmam5tRDdBV0Mr?=
 =?utf-8?B?N1FRbW1iT1JLSmtaT29heGk4Nmg3anNmR1BNY3dmMkZVOGlFSytqeE1xUm16?=
 =?utf-8?B?REI2d3JGWWJ2T3VXSVl6cVdwQm1Sc3hmQnlRTG9yQUxESThmaDdoNUZuaW9s?=
 =?utf-8?B?Y3BacUpWRnljckNlbm9WRnAwRnh6M1MxTE9naThkTnlrTXI0a1h2c0xOV24w?=
 =?utf-8?B?SUFISmJkdDYxVS9nSXlPci9KOExDMW9qMUpaUXZ1ZEdvc0ZuaDljQ0M3cjhH?=
 =?utf-8?B?WTIrc211UjVDR1B3eGczVmdRUisxY2tXRlNwWWNuWVgvQTc0UEdFejd4R1RZ?=
 =?utf-8?B?aW5EOGVTVThldmsyMVJMN1hkVlcrRjdrYnRoMjBIdThZU3Yvc1FDUUJjanBC?=
 =?utf-8?B?M21ES0xuTmNuUGdhZWsyb3FRQWVaRjk1by9GdmpkVnEydXBlcEdrWDVRVEpM?=
 =?utf-8?B?K3ZNalpjcGdPNjNuWUFUK1d2SXFqd2dDNHBIV1RGT3REZldQa3BMbEFWazh3?=
 =?utf-8?B?bCsxM0tnalVGdXVLS1F4UHR6cmYxNlY5YnppeCtmOUZzcHV1TTRJT0NBR0Mr?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2679dddd-c5d0-46a6-6a46-08dc16a6392a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 15:17:16.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vqs0nmomlWS4I4E8689dK0Kh32nGxeNxdKKxWh6sDyPqajB389R1T+BC8p4TNBKG/na1iTtNqpJq1qOfLJDPN478mIoadGGehVlTzUSeC7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 15:17:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14396



On 1/16/24 14:32, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This fixes cross-building and allows to use python3-shtab in bookworm
> and newer from Debian directly.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   ...bootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>   rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} (89%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> similarity index 89%
> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> index a7ffb00b..83be2a4d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2020-2023
> +# Copyright (c) Siemens AG, 2020-2024
>   #
>   # Authors:
>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -24,7 +24,7 @@ SRC_URI = " \
>       file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>       "
>   SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
> -SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
> +SRCREV_debian = "22b173a3293c976c9dff2ae92085d7ed995f6768"
>   
>   PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>   
> @@ -34,7 +34,9 @@ PATCHTOOL = "git"
>   
>   inherit dpkg
>   
> -DEPENDS = "python3-shtab"
> +DEPENDS:buster = "python3-shtab"
> +DEPENDS:bullseye = "python3-shtab"
I think :native will fail for buster.

Kind regards,
Quirin

> +
>   # needed for buster, bullseye could use compat >= 13
>   python() {
>       arch = d.getVar('DISTRO_ARCH')

