Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11518.1792467867913222559
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 20:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sRqKe7Fc;
 spf=pass (domain: siemens.com, ip: 40.107.130.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNuAESF9mo0ZwwX1lzF4rAHlc9z1SE20AkPYkkeIQLePNd/UWvIqvsU1tY3YjtR6gDA/3M5noBUdWn32jB33B54eSF/euQaIItNFjz3t5FAvcY+6xX8aJx0HXAoPmp2paB+BMtmVkvIRcdAazP4brLC8FBL7PFz96ndkWvrs6znbSLY+9wctJja/YTi34DAGiFtvuAUVyEnpvIEHyflsddL9rgVPV6aoxD/YVWQcQTAqCK9dHdWyoSh+UiO7//W5L/aeA3QIiQCyypAdFrmojsFq7uEnXtFiKw0RDdsmsYhCyxFF3yOJ5IJIWOAUmkvclDIsH/1XOzU9VqyWnlAjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKw9E8kcWehVMnkbL3lAIv2BCOL61xYwKp7XLK7R3wY=;
 b=yN/mZQaWNyw64QnqVOSOhRi4vjDV36WfUYbl3xzH016ausIluc+6DMyF19bpeKq3rv6P9JvnJwg8/1DS3JnePUu9AkBtHUpG+MZC/wKR/+fv8NFrditefg1CPKU9qMM+9MkLAo1HYRi1S0sYaAtJH7KHY4bGcKURu8Kc9gcsMUUmQFgYw8Ta+yRuOJIWwMPWOESAq9y2TDx4OfeTjgzcYggLh+2jqB2oW3RzeuTXR5/4YIl/nbmJTZiymQJz9TcYFFq3mCjgF0ePe+jv5MdnRA0vSDXXKyoIbAjUGSG/ehBMBMpOPlR9To3+Z+lcJKm1pKQfDwJdvNmhuavQVd/uGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKw9E8kcWehVMnkbL3lAIv2BCOL61xYwKp7XLK7R3wY=;
 b=sRqKe7Fcq/7W3Az8zN1O9R+8kOLEgj94b8bhdGvx12BxJ7uTV1plRjU1lXw2Jq119zpAACa5DLk0tOuGEkt5cVzI8e0r9kS8rtTvj7jaU6YnrxfHuSdiThoW3rXIwNP/V1BGRRn6tr+iHFmV6qJMk2JJpsX9ruAXJaRsl2dahUeSI4flk26s/uwErBsin3RN3x7Ijxj+noqxdtncViqweSIGn3zqkWfj3SlxZM/pBazgMD4qtqj4YqVASEfE2K5LdSrA9VBZOSH3AU8ZtgEM5GoXrdSPqgwlI8mYnVrdnMOQUDhy2rPAuEQalNWxBbnHjPdj0fE9FPrzzguYBTYsag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by FRZPR10MB9868.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:44:23 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:44:23 +0000
Message-ID: <e83f087d-5290-4974-bd9f-4d6f8ae17ad8@siemens.com>
Date: Tue, 20 Oct 2026 05:44:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-cip: Update to 5.10.271-cip78,
 6.1.189-cip61[-rt32], 6.12.112-cip33
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261019175548.124127-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019175548.124127-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|FRZPR10MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f2e0a3-cc4f-4c0d-6d8a-08df2e5c6e64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|261009223027099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wfMgQS7Cxp/8xSdODyoJPrgB75ZbvEji4T3mr7hOzb25s3BiOumrLxd2slb+xKI7oVNqZH5211/fLNhFIMF9TyH7hbQzYiAQ6AK5CAUCR/3Ab65wAnrVa32FwWZoExeKOtDXzIRUrYAAPLN5GLqFsCc05k8X4C/0iTrfKwKtRiJu098gPAa8s/9kAz8DNDv9oGqcrsdtVbP60i/nN/+2Sjb3jdUffg6TgSt1k9WK+HQaQ+ZEXw9iW2EZ0IUsHmrxJQsX3ozX93j1wVeTvSIJaF19k0+M7X3SYqr6M4a9Ezi9Y/XLaHMcSOfjnhI1tMkgyCZ3MOEwYVygYLq0e1AE3O2qdg5DLKNnGt0P5+sK/MatH4cABNSEDZsV6caQRmGSKEvvqoEt19q6AAusEU8NDclW7FII8rh8x+5lVHsOZ9TsD6Ui1zt2NMAtDrUObz9y/oV2PAYVjFZ9sCWcPKhgSoKUWdn//pEWwH8W2Mhj/PNSgDTGsF774ZTQJH59+qiG7KxClL8jYxI83/iiAxMQAji2ET9mPLFOY/vP9/M+lD9+SpfGlG0JnDYVXX84JPizIuO2KAU4wjDY+oZT1Ac/QEJW/xomVtV1RW6Qr3ZiddM3AW93Rm8geATOJaavKn1/Ji56JI+0tExPREoViXbudGk8+zaDRUmoZ+f7Tk8l4Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpOWnBsVGpSVnN2blNxcGljbHRpWTE1TVlsQklHSVlTMThoRE1wbXR1SVJo?=
 =?utf-8?B?TE1HRnRmdlRqa0tFNmdPZkI4MTRUcEQ5amhJblBnOVVTNmlNeWcxeW1wbVFn?=
 =?utf-8?B?blI2QURXVWJ4a0I4Z3RYZ24rMlFjTVB2c3UxT2dtVmFuaWk0VDFVZlExOHo4?=
 =?utf-8?B?bUdjYThVNXhMQWcwV2xrUEVLajdBd25GQlhqWTNnUkkrT2dLbXFCYkN0Z05U?=
 =?utf-8?B?MU9aUkx0N2dCdkcwQkgvSVJhSWx4ODJMd0E4a09ldDcwUzV5Y21PQUxzbk55?=
 =?utf-8?B?STVzYlFiYkNhOGo0TmNQcmQ1bmQwZzhPWTFuR0RYTkxYc0RQYnl5MXJMMms1?=
 =?utf-8?B?ejJxYmJxa3pqb1MxVk5BaXRIM3E0OTQ2NFF1RXd5enhGMVZoU2NuWmo5dW9m?=
 =?utf-8?B?cVVLaGNSc2tOVFNkN0N5bmRFOWJyMXpLVkROM2w4OGdVOFA1TVRVNWJSNW0y?=
 =?utf-8?B?dWgyY0dyVEhwakFiOFN0Tjk0L1BDQ0lnQ2FLZlRSaHZ4cmE5RFNYSk1iTCtJ?=
 =?utf-8?B?SVdYY29DczFqSG5JSEFCM2wycTRCL3NEZlNYamRRMjNocjlaYUFEZFk5WUxs?=
 =?utf-8?B?VE9GNkdCZTR2K3hISmJIemc0SGRGK2ZWRXFqa3hLaENFY294V1c2NlJFaXJ3?=
 =?utf-8?B?VThGWHpFSXdmUThnMm44OWRPcU1ncG5KMXFxU1AzZm1zRU5qdTBmRjhZb2Vs?=
 =?utf-8?B?cHNSTERTUmNvWkJTWWM1dVZWTWg0aFdnL1NnMmRObW0vaVYxZWw2RE9ZYTJ1?=
 =?utf-8?B?eXpkMjFYVXhTYVJ3NVU4QWxHdGlFeTc5TWo2ZjdnaU1ZeWJ6QnpxdWhwODJP?=
 =?utf-8?B?aUNnQWFibnlXS1RVUDlmVlpsUmZBeGs2dHZRNVVsTFpaMXdKLzFySXAveUd4?=
 =?utf-8?B?cTZjdlozeVRaVmNNM3VGOS9MY0xRdE1OTGxiNnZidWJYNnJ5bXQyNlVTVVJN?=
 =?utf-8?B?YnZrZHZVaUt6V0dTbHBzaHRCYUF6TVNkdFdFQ2RtMjhmWHJ2MEo0ak9tTXQr?=
 =?utf-8?B?ZElmdlAzMkpQZnJKSkdVRzdOMVNidENsU3l1N2RubGM5UG5yYmVUVGF5dHhJ?=
 =?utf-8?B?c1dtbFVtRjhEem0yNkNqa0R2bVBKTExkemxMNGE3YUxveC9rSDNla1pHbGdr?=
 =?utf-8?B?N1JHTTZOdTlYZmZRMlVMWnR0NjZqY2tGZ3RCWHl4bGdMZVl4VnhzeXNHZkN3?=
 =?utf-8?B?UkJCa0lzUzd1QXFyNmJjY2xvcDNEdWd5d2QvQm94azVxRzAxcGFpNGJEYjhO?=
 =?utf-8?B?STdBYjVmaS9YNCsvNThGcHFYNVFnTmszQ1hETzFLNGRUK0FmbjVxZmVqRUl1?=
 =?utf-8?B?VjB1NityODZsSm5mTlBhUlpOTk9kWVMwUmQxME8zc3VZSTZ6Tkh1bGgxNk4v?=
 =?utf-8?B?eFpMZ3FOSU1PcmlQSHU5RFBXZ2hhejJuakR4MTV5QjRKWlpVUmM2ckpVVGZt?=
 =?utf-8?B?TUhDdXhDTGlNZFZoVEFEWlA4a3VvZGtkTGZNMTJRVk5ubENkWmFIT043QjQ2?=
 =?utf-8?B?cEZRUFVibDVVSjgxSWY5d1ZKNzU2dkNHRkhIZGpFUm5SWEJpZXlNVlZXblNj?=
 =?utf-8?B?a3NQNmxSMHN1Q29RdFNLcXRKMEpmT1dnRWxHSk1XVDh6V0NJWjcxVXQwYWFl?=
 =?utf-8?B?MFNhUGg2Q0szdEhhWFBpZnpiLzlndm0rUmk2SjlLamRXaUVWS01HVGF4NVFG?=
 =?utf-8?B?Z2ZNWkFiM0MwK01xRHExTW53akNPRkJQdGR2Z2RRRkJWWUFYN2RpMXYvMFo2?=
 =?utf-8?B?dG5rb1ZITk5uS2JpV2J0bDMwR2xjWlNLTkZyazI2VU14SGNJeG1DVTVNYW52?=
 =?utf-8?B?UHExK1d3TWVkMXIwV0lreWlWOHUwQTcxbHlMNUU3L3dmWXRXeHFuQUV3U1Q2?=
 =?utf-8?B?cHFwaGp3SHhGS3l5aFJuaG5lRkNkSUI2Ly9YYjhLWmJJS0JqUCtVUHdWM29u?=
 =?utf-8?B?Zkw4TEV4VEhURTFGa1FaZDFYZGNCYkpHN3JWVUt6OWwwdWFDQjRKWkNKSlpG?=
 =?utf-8?B?QktkUVd1aEVrSlNlSjl0YW9PcFVnd1F3WWZHZW9rN2t2WWE3Z2VFcmVZVThQ?=
 =?utf-8?B?OTFjZFlsellhOFZtS3lsTUVjTkd4R05LVmRHcmNheGN6MWFoQTVsL09nUGts?=
 =?utf-8?B?dnAxN05SQUtoUVA2djYwckZZR2lpS1g0OG9vYXZ2MDIwOEpNbXlYMy96TnBN?=
 =?utf-8?B?eWN5VkNZeW5sclk4L0RCeUY4OVI1dmd5bUxCemdkSEgxQkxsNGViSHkzMXRi?=
 =?utf-8?B?WktSVG0xQzlrNTZ1L2xEWkE0bG1Pd3BNcVRkQjR2a2h2cHgwZ05CaTFNWm9P?=
 =?utf-8?B?Vk9lWHJHcXFJc1ppaTVobER4VDdkNnNZbElFeEM2aUVnd28wRW5nQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f2e0a3-cc4f-4c0d-6d8a-08df2e5c6e64
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:44:23.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9xuzFoSjHJyFy41XqF/tW8lRK3zM+CDuS8NG89rt2ta/CaqaiYVv1k/ZjVj44ntTnqaBlUdeQZC5dFPNwdfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9868
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 03:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24496

On 19.10.26 19:55, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  ...6.1.182-cip59-rt31.bb => linux-cip-rt_6.1.189-cip61-rt32.bb} | 2 +-
>  recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb             | 1 +
>  ...{linux-cip_5.10.268-cip77.bb => linux-cip_5.10.271-cip78.bb} | 2 +-
>  .../{linux-cip_6.12.111-cip32.bb => linux-cip_6.1.189-cip61.bb} | 2 +-
>  .../{linux-cip_6.1.187-cip60.bb => linux-cip_6.12.112-cip33.bb} | 2 +-
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_6.1.182-cip59-rt31.bb => linux-cip-rt_6.1.189-cip61-rt32.bb} (59%)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
>  rename recipes-kernel/linux/{linux-cip_5.10.268-cip77.bb => linux-cip_5.10.271-cip78.bb} (68%)
>  rename recipes-kernel/linux/{linux-cip_6.12.111-cip32.bb => linux-cip_6.1.189-cip61.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.1.187-cip60.bb => linux-cip_6.12.112-cip33.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb b/recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
> rename to recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
> index 52fbe64..8da2d14 100644
> --- a/recipes-kernel/linux/linux-cip-rt_6.1.182-cip59-rt31.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_6.1.189-cip61-rt32.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "d66e63c93ec04fb51c32cedc97b1ad73998d58055bf3fa021e3d7bb1a2789ac1"
> +SRC_URI[sha256sum] = "805490d21893c71af2fe8dcc4e45fa5a1c53619414894072390d6b3ad9fc79b6"
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
> deleted file mode 120000
> index 8003b24..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.111-cip32.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
> new file mode 120000
> index 0000000..16111eb
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.112-cip33.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb b/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
> similarity index 68%
> rename from recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
> rename to recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
> index e7207d3..c6fccfb 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.271-cip78.bb
> @@ -11,4 +11,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "7151537fafb9f395ba41a8ce86b8236b0d2dab9834e9c66b1a12b442aea41ee7"
> +SRC_URI[sha256sum] = "a972b3e41472bcbd28f41ef48bec9354ac7a050b8d0e0c880de207c70f929201"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
> rename to recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
> index 5a225b4..4b6c7d5 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.189-cip61.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "879b45f18c1bd8322b2026f72642faedcb77242418cb10a5aa56f5404f647059"
> +SRC_URI[sha256sum] = "7003af449cbaf2af04c671dd3d06193bc8a7d8a10e94a9d286b5a3c36690c923"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb b/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
> rename to recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
> index d6120de..0d708db 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "b11ba859c202d5feadd8905f93902a2df6a1434c2fff9eb8eb310b8cf969bd74"
> +SRC_URI[sha256sum] = "522caf8dd5a07904705691ba07440d8a557d74eab39a938b95b0c69ad27eed3a"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
