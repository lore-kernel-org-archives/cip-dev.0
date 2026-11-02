Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9829.1793615624488113762
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 02:33:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SzpB90eo;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6gkSavuJ0LvfYoEr8V6jxp62w7VTT8NGuZJvzC8AWQU+Qbbe4EgxpCPoLYmUz2lnVN9TcOh9FpoaBV0iKKwkWi+HBJNid3uhqTbgXuDbT6VHK1wbQ40yZXGw63pGqcPEBQOLVjm7udASbqYAvNoVm+8Yhkj972GhwiOHJ8nDKbEELP8bqFbAWw/xl1urZQxH5sLB9AyKP30Iv6guZDB+YvDLwqPoez0Qm1xaXCSDI8e+TYgVik7HnHkCmXeO/d5zwzosStiqJ/aeKUjtPd/aVyo/2IvbR6XK1k73N1WTHv7BUp9k6f/tzp38x6jFyKlHDyy2yRHTdMkC5GJfVzpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y/O555kZi5hiZGIEu6LgfOF84s8UsUcCMOnj3PcXc0=;
 b=vDh6zXCJ4s13U2NZJ1M3Di7zlnyFPI2JD+ydmtV8+KlXvGzvuqIiNRiGhMFp/PIk1sTY/5+IZAi+PmOjuFx7LIGzZVXWIU4+3aurLGlhm47HHig5awWz6v7F1bjB2JiVH9jGFeq9b/UIMemHZkzPyVPFNH55xipZU1EBLmSEMKYGSZSZQDslPafPyMP07+VJm0PXETHlDKwsYOlBiv+p+3QTstD+Dv1RezDYdzFqJ11CfGkUGo/ZneQx4giY69RsFZwD3pdRhqI3dLXfJDvIrETadVlbQf6GObfFQ4XDjk8qW+wwzmpqm3l+nLnyKXJNNuPIo6Wa78h4oimg3V173g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y/O555kZi5hiZGIEu6LgfOF84s8UsUcCMOnj3PcXc0=;
 b=SzpB90eodLSCsXGlSBg3f6Zj+Th1XMkpCCL1LSmDwIfp+PmUvkcP2LNdMwN8KrryYar0MskYCgu3pBi1n+q9cQTIjF8xKLrlv5whFBQ7OrxoYZTXqBact4M+VSSVIQbaD0MU9kLwe32w+ioSqJuMadBuLClOGIS4I3ynbj/6O7qWZbL9yyHjmnIrG4nbUHw7tXb0LJJVVGei/2yOHhOi4XWN3VgHDtNnI+lEdJQK0temQazIxdvyhSaRVqYp4YzOlFeVxMkYcpjuFDTj09E6mTyNhci4p3jRYYmjIl02yfXiga5vnrEcrIhUtBa3qhMVaZaXReAHhLVNLFEo8cCECg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5192.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 10:33:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 10:33:40 +0000
Message-ID: <d2500097-5339-4169-968d-0962d57c6984@siemens.com>
Date: Mon, 2 Nov 2026 11:33:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 3/4] README.signing: Fixing typos.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
 <20261030115543.111644-4-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261030115543.111644-4-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 81937800-47fc-4422-64ec-08df38ccc2bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|55112099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261022115727099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: CoSz2J4Z4BiQtbd1wwbTkDAh7/jmIVe6TdsHsYXoF1eZWeuSfI/G6RMeNB6SFC2cmom7EnqLkv2IDtrY/4dMY1wsYnWX40qbnyxELZBlpo3pypUsPUaDeSKwqsV8jooGxeDYfq/yQaMqI8QtauNPBppg56A9FXgo4debXq/VExl3s5BJg6SE/vMYsllBvdrLixe/ISRgDjyBTv2j7UDJGjC7lelX7Td8bIKv+xlHuH3w8e1YrNznETkTlkz2sqy437ZluzSgRlz2sQeYumjNbml/30k94ivP4V1pA5auUBN1MacTgld4G2aIxssc+2wX35swhCoGGpu8SlmgbtBNLURoE+xjujEZyDbMa2564tH9Yc1vP3i4BcuDuUn5XfwFm4SHHPAuyQG41uUfbqUS80pwBBw+XtS9KD+xUCZkyk/zMZCNZxkQyQII1PnW6pK0CJsa0Z/KqOEwh8HYu3MO1vn53KfY4XlHvPEIdCZxLyAKvvV5riYfVGxfSsl9DAZfx95meG2arQWVYYWu2LV6IkMbegL5eCxeKKMG4CP0grs0UOvMwBuOTZCxurehsY3TPApYXd163PKkGrU/10dJQ5Q/lJ2nkc8P0l7kQ8EK30pC6Ex8PQe7iK9qIshqomcGaXZrfmwA3BSoYw8YjqSnhlQabYO09RyeQsdDyEkBjog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(55112099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022115727099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHRhakM0TExBdWtZTDZDSStmUlQzOVFjZHpYYmJWU1EvYjNib1NUSkJpMk1Q?=
 =?utf-8?B?c3JYb2NYK1lYcTg2OEZUaUZwbDdoNFNlSzhLN0R1MXZ3SHlOL3VGTG5JclRx?=
 =?utf-8?B?bzlQTHl3OGh0Q2ZWRWNURkhBZmNIWjJ1dVRIb2Z5ZFNydGsxTzBhRTUxRVBw?=
 =?utf-8?B?UHM5Z2lKSGRiTWVBcFlLOTlrVFV2R21qOXlQaGRIc0x1b2RadTlMZmkwbGxS?=
 =?utf-8?B?RWpwQnp6TFZxbTlIRjBEL1hYaWNZNTNRUWhHb1NKL2tnK2RPTTZDelhDVFdz?=
 =?utf-8?B?cXdDVlBnR0F6SXI0QVp6bTR6bE5CSUVDUXpqd3pCVHB6RExaVVFNS1phdU4w?=
 =?utf-8?B?b0lqRzFhcHB5c2g0c3lzMzkrSU03ZVNGbHE5MTRoS2k5S2pVQ2kveU91djhX?=
 =?utf-8?B?Q2NPWktNM01LbnFGVFVaeDd3MUIyMjdiem45WkZJR21qb245Qm9KckJaYjBa?=
 =?utf-8?B?aENxOXpoamdoWGZlTzNBRjRVb0U0cko0QWFTSVVxQWU1eU5VN3YzYWdWaVox?=
 =?utf-8?B?SXdRQ0l4TzN1eUwxWG9sbkhLVUMrN2JzTkNZYXhxc2xKWFNEc0Vocm9NL2lq?=
 =?utf-8?B?UHZjbHNpaVE2am1KWEN6Vlg0VlFObUZIT1RjaUNWWUdjVC9XZWhQL0Z1bGpU?=
 =?utf-8?B?RnNIdG5GYVYzVUlFbUtublBERHQySzVaZW5aa1pjZHBzaCt2Q0hUZE1CcE9h?=
 =?utf-8?B?eFZNUGVRaHFEcm1CWWs0dzFjYVdUV1d6cCt5OFpITndxMFAzRW4zaEtldmJa?=
 =?utf-8?B?b05CaWFyZ0l6MWg4dE5ibkR4WTRTVWlqMFIzeFZobisxUjBxcERrRkZZdlZP?=
 =?utf-8?B?QTBleWJMcHJmWEcyRyt3UEhXa0RaWlY4M3pIWm4xM3pqSzlmd2xydmlndHJE?=
 =?utf-8?B?eENhQlozaVlIQ2UyK08zVkRNczNjZG04bWNhT3g3c1Zmay9COXpkSVlNajB4?=
 =?utf-8?B?aTM0MWNkZjdhYjJaa1hnb2ExUmw0Rit0b1BFZXNzSlBKMDNnTVA5VlpQYzc2?=
 =?utf-8?B?QTBhQUg1UUlqNFppZjVORC9EMDRjMlZ2TWpGeVdZODY3M0RuSUtqNVF2VjBK?=
 =?utf-8?B?alJ0Z1dNMGpncnVLSXora1Z1QTNDTFZyNE9mOWEyL0pEd0J0OWhYeDVSSWdj?=
 =?utf-8?B?QmtJQWNmNjl3enpocUFKdFE0dkNTSzNOSnFvZ1ZkeEMxSlFNT0FFeFMrTVVH?=
 =?utf-8?B?eHRzajU0MGlvd29CRjk3Z2hMaEdZdDFNaWxCVnl3cFVqbUdGemN5bmdJV1Nt?=
 =?utf-8?B?MGF4dkxvL0ZjZjhXS3c0NHJ0QUxaUjFZOXM3WGtSUG5DeVEwMk1yZWUrSFVV?=
 =?utf-8?B?M1ZBNHFUQ1cveEJiT3dJLytBSkQwWWVOVXJEcnRMNWtPM1R6QW5TbXhaMnlw?=
 =?utf-8?B?WENKY0ljMmFZa1RUQVJMemliczdDU0dzYnRvOE5qMkxuQmtuT2NBbTJxbFBj?=
 =?utf-8?B?c0JHcENYVEFrYkdGM3JwUThCT3hwNTgxSmpvQXlTZjlpQTN5Q0d0RTg2Z2ZO?=
 =?utf-8?B?alB0VGtiZm1FWXNFcVJTT1I4V1VmNmdLc0wxZ1ZJWEpETm9UcCtIWUtvcStM?=
 =?utf-8?B?d3NVVkl4YlUwRWdQWElSelhmUFROdnF0WUlxRFhmYm9PemZvT0g5bEZ4c01t?=
 =?utf-8?B?NHJlcm8vZFpKOStIdEs5NmZydHlQRDF6OVBzRnNwenIweEhnMGJ2dVRsOEh0?=
 =?utf-8?B?V2VGdEI4UkI5R0lpNkxScGp0R0I4SEpFa2xUQkNBdlhkM1NtemYvbXhSV1VD?=
 =?utf-8?B?MEdrOEJQS1RHRlZOeE54U3NDUy9RSHhjc0hvVUIxQis4N2tLMlBQMmNMOEJl?=
 =?utf-8?B?OExVTEZiQ1hxc0d2ME4wUkp0emVxYitNUzB2TGNrODZYRFhJUEpYNHduSE5B?=
 =?utf-8?B?cEdwRlRhRjFCSmJjWDhPRmg1WEQ2cW5aNEdvajNrSTJWOWhlbThzOWlYSVRP?=
 =?utf-8?B?T0FuWjYrb0NpUHZ0bnpPbVVlVmIydzNYVktScVlTZE5Ib3A1WXR3aGsvUjZY?=
 =?utf-8?B?TkE0MzFHTm0xNkZTMXlaK2pOblJCSldDb2NnT2QwRk1oSDdZNk1oYUozWDZE?=
 =?utf-8?B?TVdNTlJFTWdPajl3WGp2YVYzVlVqaS9TQ2hUbFdINmhXblF2NnJROWtRY3Jm?=
 =?utf-8?B?YWlEZnhJSXMrUmJtanNOR1M1NWpXTDBXdkNBNDJ0MXpGUDJkMEpuNlN6MytC?=
 =?utf-8?B?NnJnWFJuOVpJMDA1MFVsaVZxQU55TkZObFFJU1plOGs4NVdtb2pIeDR5QXRT?=
 =?utf-8?B?SWZuTkFrNlQya2FCRmZXZDFQQ1BscjlobkxKOG42aWlMaFE0dHhCZ0hEUDhE?=
 =?utf-8?B?T0hXQXkxL0NmM0o4bmVnSEJQREJWTFd3cUxjcUpYUU9YTzhwMmhMQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81937800-47fc-4422-64ec-08df38ccc2bb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:33:40.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WPHq3dLl4CPCRm7quiI6wlnQXfV7Mp4mgRpSfHh0pQwk6F89oyFzFA4HKdQ302MkEeuxtmD0UyuaGBtfOenyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 10:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24598

On 30.10.26 12:55, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  doc/README.signing.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/README.signing.md b/doc/README.signing.md
> index 327d9815..f9d14efb 100644
> --- a/doc/README.signing.md
> +++ b/doc/README.signing.md
> @@ -17,7 +17,7 @@ testing.
>  
>  A swu contains the signature of the `sw-description` file with the name `sw-description.sig`.
>  This `sw-description.sig` file is created during the swu image build process by calling
> -a script call `/usr/bin/sign-swu`. The script is called by class classes/swupdate.bbclass.
> +a script called `/usr/bin/sign-swu`. The script is called by class `classes-recipe/swupdate.bbclass`.
>  The script has the following call signature:
>  
>  `sign-swu <unsigned file name> <signature file name>`

Thanks, picking this one already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
