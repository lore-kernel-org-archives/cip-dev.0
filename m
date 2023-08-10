Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B776FC001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:39:35 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.60])
 by mx.groups.io with SMTP id smtpd.web11.14240.1691663974792632047
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:39:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nQYM0Cqd;
 spf=pass (domain: siemens.com, ip: 40.107.241.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGcI29wagUNCwTzuyLkkLcW78Q47HSpxQNhN3i3fKDbG/zhidGF1ittui1gceJwNzQ4lPPKG/N+8kUwmfxcaf7JNoLPTPI7gpizaT7EEXuPGY4WSdM9hSaA5Nh81yPxr6ab1S7/L78pJ5AD25J+b8HVaYYrchJUwO2J0UcFdNY+8TnKWsFLvtnSaKfMgCJUsKlr9DlOtkM/dPM2BrZbcQL1/GeE26Rdt1uZtZXVH7XPMtHkWSYuODflgHtdYJLHRnwKf3AxfNuN7qAuwYkBXtp60NJUS6Xy6EBpO0bDObFGSlcALcg68Ue9haDZDYYSHuiEFArQNNPIoTS7M5M+vwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFIGJYvD+ou/Oet3T9czEdlboHt0NDxw9SR6N9VEccM=;
 b=GP7MiriCyd28r5zKWZJLZco8djkv6aX9pzyS0/dwJ89H8x/tBtoCR5pPHPb0jcrfAahxBDYY+WVqDA4DSxVXfOImHGA1uAS/YC5qHBKvMdG117E/W9gCPVn4XJFTBlHQ5UoF91KCfPxeSOdQUuWmQvQ6INx9rjKtdNLPoIV3pDJyuvoGn4FiFyBzwE8twMrKvT5kHkp1T30+IqcqD0eaIPnWXVysibfVDzKLSl/chrn5onZYzZTJuCyI+IO7vEgjl3ts+pHgETjgq8t9UC7+vpqRtBAjFYAECoJAhJIa0NMHTV3XjabhwuzikNu0SF2MZFYVlire0wVLKg6BhHG0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFIGJYvD+ou/Oet3T9czEdlboHt0NDxw9SR6N9VEccM=;
 b=nQYM0Cqdv+SYqJoN0TYzaspel96ZHaC+OFlrxj2m2seR2ppq5m74vttxl93XTXUB7wwhMrh6w5BIXgo+QTuFFT/o8wBA7mov3IEopWfj49sBgghTqtA5CViKbuuMve9a4B7yudNlkrwo8w8wCUToUXIto4V8TELpUojkGt85uTMh/Do2/QLQoD4vrdiqlluv7DETfh4ajFuG2z6TeVeFRx0VZW81uLyWEfAb4XHl1eC+XhBuKqHOn/x58F2vmMMgG2Mv2DuekaRekKnafriRapCWuCyeJEMTg6r5l3EHuf7UiBIpx4ZUmQ+5OZGQudkjV3CJIXDqoYs4g0R6zndSgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:39:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:39:31 +0000
Message-ID: <42d2c7d5-184e-4cc0-b031-7fa50b0201b3@siemens.com>
Date: Thu, 10 Aug 2023 12:39:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 4/4] initramfs-crypt-hook: Fix error with
 libcryptsetup-token-systemd-tpm2.so
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-5-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230728143320.3891194-5-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd14d50-67d8-47e8-f774-08db998e14c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Oma3GvwV5dUGI+DygnaNqOvpPBokSb+J2THZxPpAk7WSGguwVk/IaeNRkAEQUY9iYtnaexDd6AJbWhXPRYNwKnxOWi4QB9Mo4JcLnBw/Hv1jAzu+RELvFNtJhfzBvyuskKr7O/xT7d3HQRMeFnEw1J7oGJYvd48/7Xb7iFN4jSZsh5qAjShUwkdQmJZjKlIOR3dT4/BKNoX8ppmhj/C0m/ZxvaO8z9Cg4RzOLq1ukjEJJaG1wfHTNjLdBZiOxfnwxiudELqp6tMsGRYPyYQ805XCD//JabNGkglxtPQlEjpc/LNAr1JtyUU0lPo6WhpGDGGyWJeKRMyvINKwRd2jwuD/K+6BXFkB13aAnxLpZcsCJdr8DT5Sl9nByZNzhhNO3j0ml7GJ64WFu9TqSKdiFY/VdxkOiMyrncT4eAKR3f8Z8XA/8HRk1QRDDlBO0zQrZeMUVemGac4E6fjskDiCTbeRbu4EnsH/ip1o0qy6W3Kzlk4LAC+mW6M5SFNzQ8MEv4KNRt+L7/yg2M+YWWlZVqShp0yaQQ+W7k7b0xWvOg1b9vznY36czyDwCM8vM8a9h2npOoMlhyf6dccx+JtbN1INjSwyA4sdJ1291ikdrLS/O0OIMi0my89nS3Ps9TjLa/Xwwpj4u3pbn1evNnyecA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(1800799006)(186006)(2906002)(41300700001)(316002)(44832011)(8676002)(8936002)(5660300002)(36756003)(31696002)(86362001)(110136005)(82960400001)(31686004)(54906003)(38100700002)(478600001)(2616005)(107886003)(26005)(53546011)(6506007)(6486002)(6512007)(4326008)(66556008)(66476007)(66946007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SG1GaUJxdzUxVURzRkRIV0hDYzR0R2hqWkNQNWt2MG1pajZMOTNTQ0NiOStP?=
 =?utf-8?B?OGMzWU9JNWNoa1hoeVQ3WEc2eUQrV2w0VUpqNi9pMklWUEZCdUo1SkZBRjFj?=
 =?utf-8?B?MEtjclh2ZjZSbW5xa1VUVVhWMWRYRVFBdlVxL29JWVRqWTZFZkIyalRhcEZy?=
 =?utf-8?B?b0p5RElYN2FMdUdvZC9qVkUxVlFQQ0p3dVdMVXdmQ0lTenNzd3UzR1pkeXhD?=
 =?utf-8?B?ZzRyUGlhT1dUbnFvY291S3dvN3Z3YzhuWlFhRUlkVGNPVm9Ja0ZvNllNWGtu?=
 =?utf-8?B?TGhKS2hJZGxRUlZGWjFwM2trRndEZkt5cjQ2RjRva013V0QwMlpnVTRmNzMy?=
 =?utf-8?B?VkpTYXJabEZnbURtSU9QRExRajZkZE50ejdoQVpxbHpyUGpNNGU0RHBQakh3?=
 =?utf-8?B?aklKdFBsVk1TdWRZUjFWV25POS9wa0FWYlZVajVKbVd1YytKenVSUnNjdFhu?=
 =?utf-8?B?ZzVxbzdNZlFHeXdIdW1KdlJjY25mVG4rdGZYam8rOGZVdGtjNUplVkpXMmwx?=
 =?utf-8?B?bHZXTlpWeTA0RVRBYTJWSlNxaWlQdVVzY2ZmM2IwY2hQaStPTW5sSzYrWVJF?=
 =?utf-8?B?Sm5Rb3FKbzhqQXhPUHlBVWFNTCt2d1JncG5mby9QS3doUVVqOUEwNGVNU2hN?=
 =?utf-8?B?dmwyWlpSM2Rsb2lib3c4TTlTOFE5SVJiRDQxNkZ1MDFqYmorTEhrNGpzYnhs?=
 =?utf-8?B?NEZaS0UvNmovcmhNaVB4VlpJT3V2VHFPNGJUcEQwQ0FJaTN0Q0tlNENGbGw2?=
 =?utf-8?B?NU1ZOGhQVWp1T2YwRXVpM3JBV2VoZUpyMHRObmVUbWZhbXc2bGNCU0J0RkJB?=
 =?utf-8?B?WnI3dTRuNTl3N2lzcnJ6YVI1Wll4NFdmWjBPTVVtNE1XWTl6aDBzN2lldVZT?=
 =?utf-8?B?ODBlNCtXWW94L0hlVXRMdFFlR1RCalNndHI0ZjNOYWFZMnYybU8zSG4rNEp3?=
 =?utf-8?B?ZStzL2pBRGFtNURiczJjZE5KYTRIdzNJWXhmZUFhMlhBWG1VOFFlSFVQMEFY?=
 =?utf-8?B?Mm9aVG42VUdQY2cxdy9sMTVnbkNDNVNOK0g0dFZlaDgvR3NzSzI1bEt3K0Zr?=
 =?utf-8?B?TDFTQi94ZUh4QjdGTGQxQVRxaWZjUW5vcUNQM2dUd2dUbmJ3a1d0NTVVNko1?=
 =?utf-8?B?clZCTFlYSjRkSUpVenNIS2oxQldWS3FRMDcvRnV4LzhHV1hwVmlvYlEwZ2cv?=
 =?utf-8?B?ZkJnY2dSTkladmhFQWVvS29jaGNvSHFiajZQd0lzR3J4ZEQ1N3J1dVRqWXlX?=
 =?utf-8?B?THRrZWhBOG5pcnFOT0JTaDFHdjNEdUE4STJoZENaY0U1ajNlQUNhWHp6UFRv?=
 =?utf-8?B?MXdKeGJOT2tYUjFLeEJta2tJN3UrZnUxS0hPdlhBelZtRXdCaGI2c2ZXWHVh?=
 =?utf-8?B?bkdkUXkxM3UrNFgxWXdYTmZ2S242QzNsTTFQV1N5S0VkRThNRFRkZTBzRDY2?=
 =?utf-8?B?QW5nMVBkczFiNzl3MGRtSXVqa3ZScnQ4YzhvOUxpcVVVZ1FrcnU0T0ZHL01B?=
 =?utf-8?B?MktPdWs3Z3o4Um8ybUt3bGhXZFYyaHB1TEFwYkpMZlhCNzFCNEoyVGlYZFV1?=
 =?utf-8?B?cERPdmtWek1KZE5xRlA0OEg0WU4zOGl2V09mc1g5V3hIa3Q4MEcvMVVIU2ky?=
 =?utf-8?B?Y2FYNVgrVlg3TUlDdHV2aStXNmMrYTl4TUJqZFg5WFdoUUplZmp0K1BJTEJr?=
 =?utf-8?B?ZVh4OGs5ZzFaenVQOWpKUWJCeEE4ZlhXd1dlRVR6VGhPa2ZqQ3BBd3JkZU9o?=
 =?utf-8?B?eWhIeTlJSWsxVGx5blRSbFhTTEMrR3pXd2E4WFUzM1ZjdUJIbkJTdzRtMmhK?=
 =?utf-8?B?NnN1Q3Q1V2U2K25SVnZsVmZPV3dtQkFtTnd5eGZSbWgxOENlRXR6V1NWRTN3?=
 =?utf-8?B?L3ZnanR4V3B4dkdaeHpOVjEwYTJOOC93M3htbHlQYVpPVXRhdzl2aGpQaUxI?=
 =?utf-8?B?RXN1QlF1eEVhR09XRVNadUNkTWNSenc5Um9VM1F0QXRrb3g3eGJDMGV1c3dJ?=
 =?utf-8?B?N0xESnNYNjJJc2VHUktTK3ZabmJJZXJMK1VLQ1Bmc3Y2SldRYmRiWlp1ckxP?=
 =?utf-8?B?M2d6eDl0SVExMUlXWmFKOEVKRXk4OWU1b3lBZTRmbG9kN0tTNUJlMVY5STRZ?=
 =?utf-8?B?WmhpNjh2KzE1UUtUUW5NdjZJTGRwQUt6Wi9hK0JlTUFNS3JST2tHWGtkTEZo?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd14d50-67d8-47e8-f774-08db998e14c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:39:31.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktV9D0qANl9ZYn5F4qsQ2XITd8ZnUaom2OTtpXTXFgSfP6a4cTZ79qENznk/aUx5ogiKRNRhlc19APmbmQy27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12592

On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
> The library is missing and is not needed for systemd from bullseye-backports.
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 08ea631..dac60e0 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -44,7 +44,7 @@ copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
>  copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>  copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>  
> -copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
> +copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || true
>  if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>      copy_exec /usr/sbin/cryptsetup-reencrypt
>  fi

This recipe is not to be used by bullseye because we decided - for good
reasons - against using systemd from backports for <bookworm.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


