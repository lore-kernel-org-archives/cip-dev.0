Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A5E7B61F
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 14:16:43 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.50])
 by mx.groups.io with SMTP id smtpd.web11.19654.1696428994877189377
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Oct 2023 07:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yKClVeHI;
 spf=pass (domain: siemens.com, ip: 40.107.7.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN9UjF/QkkfD6+fcdSpOnNCNe/L2ciBIx+gtidCm1Pv4mdTTFbD/QZqePleRvlc03fBLWiEb6OW0Zlg0ESRELqnP/YZ7OUWXBdorCOBl1lIFTKJfNZL8Yz0qx6DqVn1GYApwPQu8+s+1xz7KfwO3uhlTSATc/x2gSkwiyT4AjGkWLKfVgF/79H8qZgaIfcfCkYSJiFdsBHSKcs7UByVgpj7Y83YcmHOVNxsiOyAwhQRq3qyMqWO1Gtos2Ha8wIAWMK7c/OwMVpECLrfgyV+ozOEM0Sop6zipKmWGlG2OgyqX7mk6ZR9wmwAprGeM3H7h7bCZabbjKy5MxPVwYuAt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBbqJM0vzOe31vXpHsiuE2I9P76eYwFiG48hdK0xhGA=;
 b=NKlW9m9j33V6goFcXAHY2je5Z5CxzrjWklYeB8jjbs92KbDm8CruvcBQ+Am6i8MxQ98EuNVOxi9GKJUuKwFtk07Y2CYgYCKZM9hMq56wL9ALf4kSdkk3pGQwGb31yC3UkDl1XvB+EZ45OXnVzoz5HHvAuLB7x5v6mpDyA8GhjhOwX7HbxoDyUIc9n08oJjhRvf0q0tx1U7x9gMM+RpmkmwAs0GoGxBcufZGaP9RrVgcgiafrJsGg0IgrynVRyyJPcK2s5m1nmKztwj6wxs6BJdsUKe1GiAMvxBX39Q96AjIOn1a1fmr6wCW9vopL6AcAQHiwX/oigniXp8mftTObug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBbqJM0vzOe31vXpHsiuE2I9P76eYwFiG48hdK0xhGA=;
 b=yKClVeHItUj2iEhmYg6W9gk4uVusqKrIJs4XM/HSk91BMZEfF4yDy390V4H1764wYd6fe5gNYg5OX2Y91txloUmeicUUKINfGXMKutLKiJmgH9W2B4qKSKBZuvmB+nbc9diUi4Hta4z4KEqsGnEtr2S/Rzna31nYWbd5FwaG+ou8kt+f2O7dKujw9CwUSvgQwa9t0jsIf0bT+dYRL+Vpmwy+9gjdjFXyFe9T/QSWogyIyh/aL/GAf7ZHp7slzUgPndoVOifZmNy58+7V1OGXBfg9rZjt+KxuQjeP4RIp/yXw8+1VHFHPqB16R8OT/xOWx3/YivT1tpgVtUI+kamjAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 4 Oct
 2023 14:16:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 14:16:30 +0000
Message-ID: <db6a036c-b93f-413b-a623-927bd48aba41@siemens.com>
Date: Wed, 4 Oct 2023 16:16:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initramfs-crypt-hook: Load necessary crypto modules for
 intel platforms
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231002112105.2929311-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231002112105.2929311-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:b0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e7a903-5d09-43c5-ddea-08dbc4e4815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dgZxdHZCQIf7tq6AwYWD4Z6O97COGjUDoh/X4OcfmEMyXMEj3x2tLc50ZvDOky3NEobVM/+O7HQWEHxbluKXIxZ2TFUybh48U7tUxWPpeSo3lNt0WcWFdflAM1cAJcAyc3l6OjnUfqqWr2ilnR6hC6LXNJAr4/S7sg/H0gMj3GE1QFtS4wcHneHoLZGpOwV1r+RrMYNFHFq0UzRk1spujlCOjQ8haNnKtwwJ6vGUqfRa+cWAAj3IgNFt0uaaj3ZO2YYsNm9QzDRpfPCuQ2LO8lRlemo7uh56dwwx7+Mm76m5tIda+75KOLo8DPg43A4yFVv6OlorWicbqwg/9cLPLg0w6JcbKQzAm5kLAf5CTD+D6uHbPRooBBXaDKrBSRasLpWe204q3YS3i/EDZf8cvYa27TrTg7ZVaafQaXwl034Wt3XQR2iuzaINyEj6igrY5l6NdgO3NsTA1EeeAQO01GSaINgfeGx5fqqa9DziT+HQQZPaVEkma18XM9InGkGOfOAQi+fnjJFQlb1shei4AC3fULqjHl9sGMFQPvLKWuL38YPmQy30jQBDzozn0NgTBQt7LIEtUMoHxIzA40aoLQsJZH6Rp+WFsJi5uisazzJ3OsdyZRgHSxxVD8cEk5hURPpGlsrOdsIC/qM42yXuWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(5660300002)(8936002)(44832011)(8676002)(2906002)(31686004)(41300700001)(316002)(66556008)(82960400001)(66946007)(66476007)(36756003)(2616005)(6486002)(53546011)(6512007)(31696002)(86362001)(6506007)(6666004)(26005)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2x4RUR1ZFVvUisrdHZNYW13YlYrTGdCOFVDNHV2Ym9TSEV3UXF3aGJWUmFU?=
 =?utf-8?B?UWZRWUVGTVJtL2FFR3Z0bllQRzQ5WW1PNXBpUzFGVHJUVlRDMHpEd2FZOEFq?=
 =?utf-8?B?WE0vTnJnZFVpVE9TSE5TVGh6UGRJK0Y3SzNFR2hKNXlMZFFtalR5SHh4V1ph?=
 =?utf-8?B?R2F0MU5NRURSV1FqY05tc21PaHptTlRmWXQrbVNuVWdEcFFxbERiRTlPY2tn?=
 =?utf-8?B?NVczUm9tZFYvWGV1dFpaMWIrMGlHVFh0VnhCQ2ErbW9SdWhGVEZIQW0zMHhH?=
 =?utf-8?B?d0YxVnQwbjJXcmlydDZ2UVRMS3RXRWFWSEdxNzFvSVNTUGVGM0k4c2xjNkRM?=
 =?utf-8?B?Y1ZxdVdLL0VlSUd6MkFLSWZaY25GcUwwN2NBSGJNNmVQUEZLZWpvRWdsRGtM?=
 =?utf-8?B?VzBmTHJwS1VHem1BRzZrZmYxZUFqYWQ0cFJ6dGZabXgvb0VwMXphNHNVNzE4?=
 =?utf-8?B?ZHlUenBnTWpKSkNzdTYxOEFEWEc5bTRMVWRjNTkxajFXdS94dDhzazd5aWNV?=
 =?utf-8?B?dmtjNUhWV0dOc3dKczlXa2xKOVczNTNEOG50ZTY5cWZmZXo2TFBFNUhMTld2?=
 =?utf-8?B?VHhkSFBweFN2NVhjalJQU1Y1L1JWWmtyMEdDMGU1amVlU1ViaTZGWEY1WDc4?=
 =?utf-8?B?MVdJQmh4M1Evcll1U1I1WkpzYkdvS0VlOGM5S1IvYVo2bUZ0b1hXcXZvdGFT?=
 =?utf-8?B?Z0c4clo2enlJT2xmYUFOb2VaK2VONk5Yb0V3UExKbVRGSWRLQVNWL3BHN1Zx?=
 =?utf-8?B?cVJJQWNLY05nYVp5YkprVTA1RHFUOC9NWlIvd0xUVWFNT0hBMW5IcW5BRWNz?=
 =?utf-8?B?d1A3UzJwbFViYnNpS0dLTTEwZXk1TWhBK1hWVWtVRGpKZlNMMjYwZnRnanJw?=
 =?utf-8?B?U2J5NDBRdDFrdCs2cElrSWVPYnFNQUs4VlI2aW5aeXVnS2ZOTXI0ODFudk9Q?=
 =?utf-8?B?dmNzMkkyU0toZUpOemZ4cTJIdm8vdWUrR1oyZ0pOYmVJNGxjVHVmZENHOXgw?=
 =?utf-8?B?MHMyQTRmWW9Sek5nS05mNHJkQk1VbTBpZTNSOWZITnJTSXlxd2puUmtzc2M5?=
 =?utf-8?B?dmtUekZVdXkrVjJKQnRoL2lySE5zK3dXbENyZkIzNWZtQ2YyVk9pZzBHL21V?=
 =?utf-8?B?MUY0a3ZjN3lqVzBRMFltM29ENVc2RXM3S0M2WU1LMUNnMjdESEMzSlJBTFIz?=
 =?utf-8?B?ZG1ZODNHYjRZdDNRTGxSbTRrc3kyTkxrMkF4WW1Fd1dLYnkrTEZFS0NHUDda?=
 =?utf-8?B?ZEZpMU9XSzhRRnVjSGpncnY1Q0NHc2ROWkhmQ0FRc0dHV1hQcDFoV3BHckYz?=
 =?utf-8?B?Zm9JWXM4R1ZhSmhMeGVrV09rZDI4UW5FbDh4aWNxaHVNaFlnRmJ2L2wwMW9s?=
 =?utf-8?B?S01odVM1TWtETDVxanhuS1VDNXY1UGkrTjJqSWJPOWxhVjlMSG1zUmtNSG43?=
 =?utf-8?B?ejdGSDhpN0tzNm1waG83cW5PakhGeDdNTWducHJKRE0wZEw5TzNRMVVCTldj?=
 =?utf-8?B?eGdEd1ljZUlSbGxhcjNVb1JGWVg0Uk1mVGJ3NEVtR1VwcVhMNmtQc3RMVThl?=
 =?utf-8?B?Uis1NGRmd1VNQm1CWkU3TjhTY3VXSm1oeDk0dUR6VkhmbUZ3cmttUk9ER2tR?=
 =?utf-8?B?cUI4b3h6dkdOMHJhc3ZKaEdvaFdjNUVVSVJTTmlldTQwNUI3R1A4V1dCZXdF?=
 =?utf-8?B?YThndURVU0d1OWhUWHI0SGVyNGpXVUVDRXZZTUlKWk9JYjZPd3pxOXRycTV0?=
 =?utf-8?B?V0oxUC8rcnBhMFpGSlVLcG1ZcDV2bmxUZzQ3Y0pocFVTMm5jZzRPNm9rbnR1?=
 =?utf-8?B?eG45MmlXWkZsQ2ZVQ3FpY01YR3JhQ3BhTFlpTnBzMzRoVU9HUm5CaVIxSnlh?=
 =?utf-8?B?NzVscFR6Mkd2UFlSUnlQbTBTOXp1SnFSdU5LZjc5cFVIQUJEalg3SWlud2t6?=
 =?utf-8?B?MnkvVmFQRVFSSDR5VlRFaDhUZEtQMjN6TE1xRG9zeEplSXVoeCt5TkphM1V1?=
 =?utf-8?B?c1pDYzZMRXN3cUwwWXRWbTV5c3o5cVB0NWJHSDBjMmNiZWFNNDY0UUI3OE1K?=
 =?utf-8?B?OWdiVkdtck4wVG9zajQ3OTBvNG1WUUVLNlNZSk9kSVB3RlFuY2lOQjhQS2xG?=
 =?utf-8?B?QXNuVVF1RUdiNXpsaEhnMVJqOFJCZkNNTklxVGt1blVnTDI0STJuaDZJUk45?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e7a903-5d09-43c5-ddea-08dbc4e4815c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:16:30.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKbBCStmnaULtldCeLcxndTktL/9XM73gXP6HI0E2/sAkoOaew2xpD+18KlRWim96LlRUH8YljXKYxCes1T1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 14:16:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13289

On 02.10.23 13:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To support the encryption on intel platforms with add the crypto module
> 'aesni-intel' to the hooks of clevis and systemd.
> 
> If the modules are not available(not build or compiled in) the build
> will succeed.
> 
> Reported-by: Sari Sercan <sari.sercan@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook   | 3 +++
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook  | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 23dce93..37b373c 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -34,6 +34,9 @@ manual_add_modules tpm_crb
>  manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
> +# add crypto modules for debian upstream kernel
> +manual_add_modules aesni-intel
> +
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>  copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 08ea631..0a39da6 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -31,6 +31,9 @@ manual_add_modules tpm_crb
>  manual_add_modules dm_mod
>  manual_add_modules dm_crypt
>  
> +# add crypto modules for debian upstream kernel
> +manual_add_modules aesni-intel
> +
>  copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
>  copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>  copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


