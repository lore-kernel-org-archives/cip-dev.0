Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E93AC43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 15:01:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37012.1782486069446219474
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 08:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KKRe5vQY;
 spf=pass (domain: siemens.com, ip: 40.107.162.0, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4fdpx1O6VjjFXsmHCV0zxrZ7fZgBWr684vleKg5MrIAI8TSrHElQylPU+Ui2Njo0+pPDUDdVkWX3ELYc+vimzIzqNLXJ2jh2zqCORm6ZrDmQ1LHDGTICdu5jt/lv6+Xu1aAul3+DuE0eSyw4750RRjcXsHuH95nmkHwOyIQteXXNiYauLMnk5asUYheV+ik6ntTpiewfgyA0xo1JpZQaz9Ot7U0WCOXsIqgmutH3PplWVWzsx7uM/WwRG94bqeAIkE9Vm4HUKS1/zTid6A8Tfb50rd4Y29s6BKLZwuXbw5wnnFfNnTMoS7JtA9oppojn5QHbu+WFGsJAqgLLv2WQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fKX9rKbZX2zB+QpxKXajWkxGQjuQxklu65EEKCXhp4=;
 b=fHMcxjI1+2kE6KEHdbzwzH/YvhUW5X815pT3yyKqqN54cv+MtdZ8luupVmbLJIqFW+wKUELDCaoKHLm7wLgJQllnxFfwE1xEa1o+DwnbbvjBpgKmrEdH9wb7CpcZzV1kA50xATT7cUv/3u+DAUNNT7azD5g0OgFfRwyaPouOkYl40yiKRFUr+4nC292Tj91yq6/0qdgm3RHx0pVYEtGzP+a9Kqy6obSNuLvY1YemSgZnHoJkGEO8OTVCp6ghELAEPw2U8h1x9QKN2jnmeOn4N3mDWYhZoa/zgfHliW0jgsROrzwq2bA/K5BAn41ICEhVN2ZCJPxqPIA7o/20pNt68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fKX9rKbZX2zB+QpxKXajWkxGQjuQxklu65EEKCXhp4=;
 b=KKRe5vQY5eHrSk6Hv8xjGGVvm6FlPT8Km2N8s66TZ5uG0sOrpaHJZ7q/kfCjNPuG0HusBoJHo7EbXtcDSqdD7JEi+VOPQvbgivR8z5qmgF0Y6FztW2/FyMrjKzbILC/Io0Zg3wrxff4uqP1fVhE3rHcUFREfEM+oU1mvV7qigN6xFOO2lB42zOagSkA86QW0Qc+5JdAQTp/8PRcRCZYuwPuWpos6QIk3egGu6npcnD2QgdStOP/iXecKW6t3gJ1h0Ij2RhL5sS2tUY/UZJL/xidHAHlr/yHRPgjWmLhtawZ9DqmW1sgvcte7Do1rRuMCEc/3Ou6ONkYVXLcu1O709g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM0PR10MB3523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:01:06 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:01:06 +0000
Message-ID: <c9c39de6-0afd-4ceb-b740-bbe1c9358f05@siemens.com>
Date: Fri, 26 Jun 2026 17:01:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-config: suffix package with
 -${MACHINE}
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250211074636.348469-1-cedric.hombourger@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20250211074636.348469-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM0PR10MB3523:EE_
X-MS-Office365-Filtering-Correlation-Id: eed6837c-4f56-4e1a-c83b-08ded393bf84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	DOp9lMBFL6oEtR345zP4+vPq98pROF+alrCkYurORsecBZ/pfs5ZHqn0ODC9qQv8XnMOzhSnrfbAmi7D+dlt+ZxU/NDL32lt01tiqm0jMJM6SBL5g/nz7EZ6WJPRQJgl7joXM5cYov1uPHuzOS69caN5PgRc7Cz9Wn4VCttqnA7wpsX8k02aLYyP0ckAISrNsKXucMhQffsp2VyrI6JRHDMwx/73k3ILL4NZbaz3BLdxvDJwzIhTQHZCEnsnv3xmC1fnhHWsXetasI2bTBbyDjmiIBpJFbeVWgRZYg2Io43/DyMGFI6f7Z1g7vE87JWxUsoLiwbhP1lbbjNUIDoRUBP9nfYxAwJhi5M2bNyG09MP0g+9lA9Nrs9t5qsfV54jtOI+EkTu8mOfVG7hOg4+I7PnEuxY2QaXiXwEZu54bxViZwiGxxAN6RRPrGVEk/SIAYOBj1Jfcq8roKpcgpH17+4YBUjykRx3Ropq7rygf4KlBPxolXmRDj7F9CH5/032yI/PSHg6f06IhPcZf1bA18GTR+aDUoEOC2aSv5lMfJYLGTaDrXH9mZxQV4uJwuIa1W0wZDtZT90s/EXtz+IUdOf6C7cDAODVnMqkEptJePqPNl08VFuahyTufIpqFqL9bY2/mAGYOszwfY4YaTK5I1csRhKZPv0s/Q/OEAsG8TM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STM0OE02Vkh1NHk2RkduUjRHVEhlaXN3Y3NVaWhZVUptQjd2R2d2amJvSjg4?=
 =?utf-8?B?a1ZicXdKSFo1SVpMVG9hNFhsODNTV0liNTF2V0dmUFB6UWRyUytVb3E4MHhW?=
 =?utf-8?B?cFF1YTFxdTcrUGlqUExqQVJrNnpSZnNaNzJHcnQzTUhqd3pnS0FLQUF1Z216?=
 =?utf-8?B?MVVyYUk1QkJiaGpUWFU1SEZ5TjJ6TW15VXRHeXZidzRTaFlTL0lQNFIweGIy?=
 =?utf-8?B?cVpMRGoySUZLWUkxZmREZEZpWFJEaDgwMnlnOEEzaU4xTUEzcDBXTVdIUkxt?=
 =?utf-8?B?TjhQWkozalNpKzNvdnQ5ZUNNMDlEeTFDZWx1S1dRSzR5MFkwMGVXQUN0elVM?=
 =?utf-8?B?TUtTcUo2OUdkNG1CUlc3K2pHTXNibVljVnVjVEVWYmZJTVdqT2tIeTI0UW42?=
 =?utf-8?B?dVJHVXp2akswb0J0WjNRK3I3VjNhLzU3NW5yb1lEcXRzUi82UVo4RkJpOHNm?=
 =?utf-8?B?YjcxOVUweU5oRGdRSEtPR2RMT05YRUVXak9GOFR4SVpOTXlNaW96TkxSVXpo?=
 =?utf-8?B?cGU0bGZ6clo0dWIyeldWNjdLWWdOV1BwZFB3Wk1jSmFUaDhhQzQ2V1hEU0tl?=
 =?utf-8?B?M2FsN05la3Y5aGpsM0UvbUV4N3d0VGlmaDVETFJWQTgwbVdDQkhlaTVDbENq?=
 =?utf-8?B?S0o0bnJKZklYSHVmQlhyNEM3ak56T1lLaUx2RU9Ca2JYcUJBck1zalg5VkZz?=
 =?utf-8?B?RktCelFQb1kzaHFEZGh2azlnMFhodjExdWlqSFQ4QWUvREpGRWNwWWRyK080?=
 =?utf-8?B?aEZFS3JaOHA4RjM1Ukg1NXNKRDBaL2FlQTF2dC9HNkU0M2N2TkhZMmNhUDE2?=
 =?utf-8?B?bEdzeEFSQlRCY0NWcit6ZjhCakNaSzlrdmJ0SUp6ekltU1A3b25kZGVrbDhN?=
 =?utf-8?B?RzJpL3hxY1JQRWNZYTlwRzBwdCtmTGhwMFRwT216YVRXV1ZkZTJiRnc3UEts?=
 =?utf-8?B?TUJwdWlsRHEzWXpiQW9XTFk2eHhOczFPekhrYmg5cXlDNWpDUHhYeE83b3lr?=
 =?utf-8?B?VUIwaXFQY2VjWVYrTnlaaGxmdElNbFcxdHMzb0tFYkNRbTBYZnJTWkxpb3Y5?=
 =?utf-8?B?KzYwYlFXdTZ6bXc1NGQxVnZscEpWVjN2NCtnVERHRDMyTjA5QVhMeXdHbFo2?=
 =?utf-8?B?TkIzZ2V5RGZ0T1dLdWhpRlltazJNN2pCRzFEbnhPS2YwRkFZelk5dW9WY0Ri?=
 =?utf-8?B?eXh3NWduQlBPM1pPNkkxQi94cElsaHQwejM4V1NZME1CZVFjd3hwMEhYMGtQ?=
 =?utf-8?B?N1ViUlUwRjdZWE9jVkJPL0dGVzNpTGFZRXBmVGIwVXJndVRqMWF4NmJTbEdQ?=
 =?utf-8?B?QlF2alVZWjh1cmlTWmNkVGhGY045ZnBnNUFRUmJtQW9hbWhvL2hYaHlhbFg5?=
 =?utf-8?B?SXBOQ3dxR2d2Mmd6V1JMMHJLV2g5eU1yN3RrVkxDb295Q0RCMmFFRGttVGVG?=
 =?utf-8?B?L0NKQ2FVdVl1Q1VJS0l4dlpKSE1XNEZWWjlGUWdZOTcwa1h2blB6VFJOb29w?=
 =?utf-8?B?Vkp0SG0xMEgzVkUrbmQ4bXVTaWZIWXVhV0VYYnJrdVVWZCtxNngwMEM4dDRT?=
 =?utf-8?B?SG93QzNyRkdselcrY0F3Nm1kTWpJVmhRbng2aXhNL2RKdjVmRnp4a01NRkNT?=
 =?utf-8?B?dzVVNE5EYTI2cHlnNlNVVW5SRWpVemFzRHB2emxzaGUzOE00b2twb1kzVC80?=
 =?utf-8?B?MHVkVEJmZHAwTGVZc3l6eGszaW0rYjQ3eXJLM2Y2clF4U0tTRkUycHVqTTMx?=
 =?utf-8?B?UExYSUg2MmZQV3U0L0cwRUNhQmpKZ09DSzkxZXRZL2xEOVA4UTNsTkhjUHhm?=
 =?utf-8?B?WGE4Z2h6OHlWektPQnY3Ukx1Q0R2TUpvNk5PUEZtRExqZTY0eEpEM2JYMU9r?=
 =?utf-8?B?aS94bi9iQ3hlR1pYSUY5ejdaMGMvL0Y4Ym56QXdyWTAvbjd5WksyemMvbGtD?=
 =?utf-8?B?NHNMcjY1a2NPYlRpQnlVdTZib1BiUzg0SzczaERDdHFNWVdkS1RlaEpKbm9P?=
 =?utf-8?B?Tm5kQjFzQVI3bnpkbGhMRmhudklDNTZmdWNVbXZ3cWF6d09WTWQybUVQeXNl?=
 =?utf-8?B?ckFDaWhEaGZvZSt1d21xNmlzU25wSzhDd3h0SW9lZGpsY2xkWnZZUjVlV2JK?=
 =?utf-8?B?RkdJNTlUNFlRbXovU05Fb2h6ZXBPVkd6ZG93TGprV2xzSUt0Rmk4QUwvUjJB?=
 =?utf-8?B?aDZ3cWoyazRBMERkVllxbDc2YktnTU1hT2gzLzNTUzRLVG5qSzI4VnFOUlJy?=
 =?utf-8?B?NitnUHZkSTNYRnBxdWpINjFDVnBnRGw2VC9FNk43bXlydTVSaEpWQnFnNVpt?=
 =?utf-8?B?SlhpVWZtUmd1NEYrNDNkbW03NGpIR2p4ZXF5ZXV0Z3lyOEhKVkE3REM2ZUNL?=
 =?utf-8?Q?T6ubM+16kPsvUOv8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed6837c-4f56-4e1a-c83b-08ded393bf84
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:01:06.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3j4QDENqT3KvhVbCRVSgCbpYLGIzfjRd8nXpD0dUST2EIYL1OYUkT3OsExNyu3PoyWNmYTeLLpgkc9ZXtsaAi30PfFI+kA4HqkSX4U5vW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 15:01:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23282



On 2/11/25 8:46 AM, Cedric Hombourger wrote:
> swupdate-config generates ${MACHINE}-dependent code since it uses
> templates where ${MACHINE} is expanded for the configuration files
> it ships. This causes problems in multiconfig builds. Dynamically
> suffix the name of the recipe and package with -${MACHINE} to get
> a separate build for each ${MACHINE} selected in the multiconfig.
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>   .../{swupdate-config_0.1.bb => swupdate-config_0.2.bb}       | 5 +++++
>   1 file changed, 5 insertions(+)
>   rename recipes-core/swupdate-config/{swupdate-config_0.1.bb => swupdate-config_0.2.bb} (89%)
> 
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> similarity index 89%
> rename from recipes-core/swupdate-config/swupdate-config_0.1.bb
> rename to recipes-core/swupdate-config/swupdate-config_0.2.bb
> index 3495285..63fa320 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -11,6 +11,11 @@
>   
>   inherit dpkg-raw
>   
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +PN .= "-${MACHINE}"
> +
>   SRC_URI = "file://swupdate.cfg \
>              file://hwrevision.tmpl"

Ok this pattern is now broken on sid:

| Get:4 file:/isar-apt isar/main Sources [490 B]
| Get:5 file:/isar-apt isar/main riscv64 Packages [4,462 B]
| Reading package lists...
| DEBUG: Shell function rootfs_install_pkgs_update finished
| DEBUG: Executing shell function rootfs_install_resolvconf
| DEBUG: Shell function rootfs_install_resolvconf finished
| DEBUG: Executing shell function rootfs_import_package_cache
| DEBUG: Shell function rootfs_import_package_cache finished
| DEBUG: Executing shell function rootfs_install_pkgs_download
| Reading package lists...
| Building dependency tree...
| Reading state information...
| Package swupdate-config is a virtual package provided by:
|   swupdate-config-qemu-riscv64 0.2
|   swupdate-config-qemu-arm64 0.2
| E: Package 'swupdate-config' has no installation candidate
| WARNING: exit code 100 from a shell command.
| DEBUG: Executing shell function rootfs_do_umounts
| DEBUG: Shell function rootfs_do_umounts finished

The pattern to add a machine is wrong. I will change the type
from all to any which has the same effect.

Quirin


>   


