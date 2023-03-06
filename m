Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10369C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 11:50:34 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.87])
 by mx.groups.io with SMTP id smtpd.web11.31309.1678103425208815328
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 03:50:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WL+PB7pe;
 spf=pass (domain: siemens.com, ip: 40.107.247.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4lqIWwVM3BxK9zmF9gp9JFRjVtnGL0k+QSCE4tJYKUDns/hNJs21O/WAZqmyWTYV1aoz/jr26igCrogJzWkdIwRoXqtvRjnwUpJE7AQKdhO7StJ6nbN6XCEJa4ZpaTPjnd6OZA7LQuigYjQkyMpqjFQt5tzQvFmoCplVwH6F2+XqaLjwLlj/NhJiB4Had+aaSd/dbrB0iOe7kg+bluxDOztjEXRZb8UcEjyqznQxdnVZleHmr1vPGnYe7fPQugc2JckClppPqf1sMJqs/tsElXuCbWv+Q2LaaY46gbxKBqfEon0PSBRIqDvEErDR1U6IBe11rmRFeF7H2mBpYtzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3dqZ90PsGUtRBW1ey7lzmGXqAqT2yCjYwiOmunrzVI=;
 b=aKUW7sYDxBK3q5xsF5nIrDD9Tc/EpPvQF+NwO6z/1fLlHf5k7mh63X0EOrwkNjOjT2Arvihj2tFyFK8oaEBQtss/gYxph1KbzbCbbY7yURbtnb2LtAjFKOQfCk84Xf1X4njT6CAOyozgtR6FrFnZRDC/CSraX7FREoiWiVZU6ecFaK2nwaftb901GXI6jNsOQAa8ad60e5iVIuuohNRmKx9xw035ABlPvEP/jxmppKcGdkh0/KpOf2j26rmF8W0yOtF16edhwFpEewM/B7EZlDAHqKEkfnebTexq4/Jq2FnOoyoxik3gh8b8aRm3hLLQZD9wwnH2YQ/upTezToWdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3dqZ90PsGUtRBW1ey7lzmGXqAqT2yCjYwiOmunrzVI=;
 b=WL+PB7peL2gzio/bnHr4p6rnGzTwiHN0Je8EvMvScBKGEpQ8nTugs7LthrVD1IED6JfaMlcU80T2e04qnKoglWEKEDrGO/quWU5lIg3i4o+jHq5+PEJTbzvN9ua/tJjEbBfwf3/RtYhwFN9MUI1KcLQSW1gPfCWc+KSAxYcyyRa76xHNfF4JzQraepUhH+Rhc32utxwt7ubbL241UFY/dEM7N/EhQByuGehU5Sric2AUiqjpqvbY+RmKqru0bCGiLOoRVlrV9zW3CBpMT/Kv/syDFw/OCVBQKTGtoVHb8NaagmfF1dii7E3NYnrVZxrad9krI425xpWvqQtEoGhTuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.13; Mon, 6 Mar
 2023 11:50:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%8]) with mapi id 15.20.6178.013; Mon, 6 Mar 2023
 11:50:21 +0000
Message-ID: <29cf23df-6329-f800-f7c0-025716aa73b9@siemens.com>
Date: Mon, 6 Mar 2023 12:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop space in
 remove override
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230306112429.3476447-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230306112429.3476447-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:610:32::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e879cf4-8439-4e6c-c107-08db1e38f706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CEwmOmRDxeGNPmkp71kmwKObHRSht7+6Q0sLpcTAeyj8ldg5jL3S6vElsBM1+XdX0seDArxpYQL1ARV7YBTLoqiK3J5PV7vQe701I1M6dTawgCpR+Y9LQ/aDocNbP9lnYoRsJsn/ftKAXZjG5uhZRjyZpJKrDYGtZEawLTiHnpj5esWwupgEsBE0zr6X48MNFSLfhA0kshGbhZqz6WVjhVIVoXCe6rdws2AaM6PBK46GV2mCFaBbD5ky7CTz813m0xEOXmiTo7ZAWaXzafAtf8sIRzrbzFR8ossro8F9UDJfEbE/xzgfy9/CuIZ+07fH9HgGOsRf7B9qHgyhB237b7cUvAHBePDUa3OVqU6/ZsxBqO2Mus54ee6RnKNdiXl6uz97um0V4nuOc6l37H7/UQYklsXgHn9G07eXHHsB9Ta0sXQql37bMXYjMPTsL8JhZUzNlxZtCMbY5Y+wdVF0ka/GF62xpbMQiHydjKXXgRuCXIYuNzHVOPfehL+Qogg4HnDKQWRiftxFhIfIcsChDCMlGwyXfrsBZnVopGZv0AdgVMgxTT/abP81ZpuFk2YBmX7X/Y62t0WG161MRoLkbwBYLntYxK2jSn/B9K2HwCe2icosZb+hywky5rpM9y1+kUY83KYqkU/WKP/g7SXoOcOB1Fp5UckuT8RsRwpNzcVL8f8HVIWr+FU5BXLSwBrdtrFT+avuSrkNivWDnrY3RhR28Td73YhXLwNHBUoHRc4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(36756003)(107886003)(6506007)(53546011)(186003)(6486002)(2616005)(6512007)(26005)(316002)(4326008)(41300700001)(66556008)(66946007)(8676002)(44832011)(66476007)(5660300002)(8936002)(6666004)(82960400001)(478600001)(38100700002)(31696002)(2906002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzlySFpMNWJjWVBQeDJBbHRyb3pTWWlJcFN1NHR2Qmw0UU5vWEJna3dYWFZU?=
 =?utf-8?B?ZnJVbTBSTTJFdUNMUjc2VmtJWk40WVRvbjkzcjRyUkhDdTB3NnpBNW9nOVhr?=
 =?utf-8?B?OW1FY2IyNEFuTmNyWWh6SmxzeGkwK3MvNEZqcC8zUkQrT01qVkNoc3lPRjZD?=
 =?utf-8?B?MFdXUitFbktsdVRFKzlacG1hRHkvdnpNam1oUm1Wc1FyRGlLaWtUSCtxeFg5?=
 =?utf-8?B?emhDN2hVRnVQdzNTQjZIcWdrS3ZLaU9lUHU1R210RloyMUFVVVpGVWJyalpB?=
 =?utf-8?B?aURpZFJWZmswMnNqT3RKeEJtQXpSNElRWkJka0hYWEhncnZqc1VwQ1hGUGUv?=
 =?utf-8?B?eTZPWlNiR2xqY09rajAwa2Q1ZlNSRitMbmRIMmVVTno1dW80akRyTUlER2tk?=
 =?utf-8?B?QXJWQ0gvaUlTakNZbFNOR05obVdsNHhoOEJsd2RmUEdUcnNIMkd2Sk9sWGNE?=
 =?utf-8?B?VGUxalRVcTJRRHZrMzh4QitqUk4zUnNFSHRwcHBVSk8vZytqQkwvSytMWm1E?=
 =?utf-8?B?UkhWaWRoTEZTSmswV0RXVXZiYmZnWTJiUG1tRGtzUzZaMldYaWtKcFVCSXAx?=
 =?utf-8?B?NlJWdExaeHdrWmhqcEhGTVBUK3dsYTJhdzVJRWZBamdXemJEWU1QbVd2LzR1?=
 =?utf-8?B?R0M1c0RTa05sZy9zazdhRE9UZWtWVEpzZFlaM1FiL1U4RXlYM01TeThaR1Zx?=
 =?utf-8?B?N0ltcDBCbE9lL1FXbVdUcVJXVTAzTk8wSDArcXUrWVVZWEpiR3EwTHpNVzhp?=
 =?utf-8?B?eGk3VW5YWDh0UjJSTWhzL1AwZVVSMG1YNHJ0ZStzMnU2MzJjUVNieWk1allR?=
 =?utf-8?B?RldLanVRbXREeGpVZ2dpd2NRcTI4bG9kYWd0RjU3YjJPY3ludERJd3k1THRN?=
 =?utf-8?B?WXNPMlc5ZmY5UVBYV1BHaS9VMHhTc3ZJNWFxYkV3YzFNNzFOQW1tUURFTEs4?=
 =?utf-8?B?eXVBaHNXcjBJeEdUT2NIUDdjclhjVUFyWWRMVWpVN09MNTFIc1QwUFFZZi9L?=
 =?utf-8?B?bnVmL0llS09aZ1NicjdXTW81VlRtQU1OakJvUmpXYVlUSFlnQ1dvc1JFakJ2?=
 =?utf-8?B?RlRBTVI4aDFjMEJxT3gvU2tVcm41cWxFbFM0U1MrUUZLV2tjRnVmRWJiSlFs?=
 =?utf-8?B?eW9oV0FwMDV4Wk5DcGkvL0pZQk5ZS0RvQUkxVkRFRFZyMnl3SHdNME53NmFq?=
 =?utf-8?B?T094RzY5dnIvN1F4eDUvcXA0SWtHb2Q1bmhzMGNQd3VOK0VoRGRQc1J1VGdV?=
 =?utf-8?B?ckNFckRsZ0EwQkhzTTdpOUNUMnRKWVFGOVd4MGpXOXZnWW84L0EzZEZaa2px?=
 =?utf-8?B?SDdDWU9tL0U4ODR5LzNmMzAyUmJaNDVGRDlIdEl3SjdvZ3Fnb2VzS2g4MXZR?=
 =?utf-8?B?TkNobXFjd3N4YlhRTGg1MUx0SXJyN2pMS1BSMHBxT3gxNEdJNlpvUXJVREtN?=
 =?utf-8?B?d29DSDJPZ09FU0FBRzFaNkdsaFo3VlpHY1RobW9GV3R6Q25xcUhGOTJsbmR1?=
 =?utf-8?B?UlFSQ0VXZHRwMzYrTklpWHlwU09MeWV0WXp5a2toaDNDdnZvRzkxU1BlNkdC?=
 =?utf-8?B?ZzVlODlma1Q3UGxJbDJ0UGpUUnNSZGtPRGFBb3JaQ1FHYWxoT2dlMmd3cjRN?=
 =?utf-8?B?ZHJjNnUrYVMybVBVNEJxdE41Z1oyV1ZIdFZLcnpDRU1UeGJoMFhld1BLQTBU?=
 =?utf-8?B?VjhINWJpRGZOSS9TaWFtT0czU3NwSkpwc2M5SS9WZlRXSHdzRDRBazZ3S1Uv?=
 =?utf-8?B?OHVrS0J6RVdvbXJidklwNTBjR0xMVFZJV2t6bEpRNWVvKzhWL2d1dDMvYy9s?=
 =?utf-8?B?Q0laYXZIYW50Z0M5RUJ3Y3NCYm5lNGhJRFhBdnlPWWRGNXlvT1hhNXgrSFBa?=
 =?utf-8?B?MkVwWFpWamYwc3ZLWFpoTEh6RlU2TE5XaldWWE5tVExBVUVWcFN6MGdvejVN?=
 =?utf-8?B?TlVocHlkQ1hNUENDNUVmeFBBV05MVnVOOXlzb0VJaFBiNVowWG1yZ0lVSFpW?=
 =?utf-8?B?aElEdGZJbXNKRElZQkh4VS81TzdJWlplUW9iMDZXM0F0WGVOcUFKeUlTU0NN?=
 =?utf-8?B?VVZFVFdhcEJIbFU0RnFFRUpOWFpSaG1YYmRRZEZlMVQxMFo3VkUyb1BBeHYr?=
 =?utf-8?B?Zmd4ZExoYVN6YW54bUQvMFJ0UDlpVWVIcWhZTVQ1RGVtRXMrQ3VwYmFvdUQ1?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e879cf4-8439-4e6c-c107-08db1e38f706
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 11:50:21.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbOTJJvSep6bdl2cQoiFg3eOY0O/Hor15kHkNOi9nuyzsb9c0Trm0dB3fbThNAAuIixqR62jYg6Ph4+IkIw8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8085
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 11:50:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10935

On 06.03.23 12:24, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> remove does not need leading spaces in front of the package,
> hence drop this one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.secureboot.md             | 2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 54d67c7..bc238fb 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -154,7 +154,7 @@ local_conf_header:
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-verity-hook"
>      # abrootfs cannot be installed together with verity
> -    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
> +    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>  
>  local_conf_header:
>    secure-boot: |
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 3d0e3c9..f787c82 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -22,7 +22,7 @@ local_conf_header:
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-verity-hook"
>      # abrootfs cannot be installed together with verity
> -    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
> +    INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>  
>    secure-boot: |
>      IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


