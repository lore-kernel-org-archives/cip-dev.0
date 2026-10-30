Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5517.1793339809864356651
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 22:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pbYWq91B;
 spf=pass (domain: siemens.com, ip: 52.101.70.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtnTKAtxIaxnkS2P7IEMNTGu9nkQIdblNUxRdD77eEuqvM199zoFXE8i0+2DbQz2DTpSsalqUHJhGdRuqkzZXA/5Yh9Awz7xQfZ8sWlxdeVzUCBZSvfeQqFzRBMYQurfxWddRaYrPEpkEVoKD02RorQjstehkCRVW3GTxcqLOyZe77g/UDVIEUClJBuKlyogcB12kN8aOxNZC0bSXmw1d7DZWdaxEwEHf1vOogDUZ6u3gseMx/3qhU6wa+cZgu7O0HrQXvgI95isVw+Dzj8JHh9oLCu3qDvOJxzI227vNspa9J0BCuQXAy9X+arWIzMSzJG3jDLLdyE+AtU150M2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOoX2QQ0c8MZQCKCh0mbX9MjptNYeqE3zD8drNU3CMg=;
 b=p4mFw1N6MWh6ruBoO2EH8HjWicpvIkAP0bDaRoqXc8/o0dHe0+t8stuU9Wc9NhbQ1cHBgbbmxrS23rc9c0izNB9BOTFgQsWDW3k4afZpHa04XZ/8KBrQYr3qrPH0LdJ2h1/odjGlsll9+ehmqKZLAC9AJVT0OBC60mRwERv0ymbFulq1Wn4lGlwgykq76dYvkQdANmlfm6ku2R7IrnDD2Ce/qXeTNNUePXQaECpJrojszrdOSbx70wiZOO0PajFvXx6cV06t6b189feXO7ppLraOm3CmsgOCJHqHfUxlNfjFLXOnYVQZrVLA/RpbWyNKHKv8XSdOeb6SmjeXuk9rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOoX2QQ0c8MZQCKCh0mbX9MjptNYeqE3zD8drNU3CMg=;
 b=pbYWq91BbarVn2UdzOUOgOjyX5hoRdxjrHIB8eUNa7XBy1iOZNWae2wpYCw4cNU0YfAcdsRS5xUlmmstJGOYsJGwp/mo7enGb8YQlOgOZ3Nl/lXXVeUEzERvUkAQsioRXWOYfwYDDkx7ynbQmSq0AxYs/SBNzi1+WAXWmOZwVrhugzppw5/fOvFFcWMkLia4h+FIAmF73f14y/LeKlTv8HhdUO8QFy0oHya1T6wY5MRiLrJP0KfZuS8QjPoIyX7Ye86zJy2hqBXikyOrlVQ3VS+PTxD18mCFVV+qdj3JLV0ONRRB7ls9Gv3speyBsp1HqbTUq1l2+9M/Diu1YRQp9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA4PR10MB5732.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 05:56:45 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 05:56:45 +0000
Message-ID: <dd348f86-93a5-4761-b8ba-a5b904f215fd@siemens.com>
Date: Fri, 30 Oct 2026 13:56:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Add out of tree signing for swu files
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20261028184403.301959-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261028184403.301959-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA4PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b864733-c62f-4163-b657-08df364a9469
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|55112099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: uIQ05MrQEI0g+g+yam8S90VZd9kmvYba0ZltbMSm9a5ZcdcI7W5dzDcoVS9i5bxK6JCxnBMlHheblruQltQGhKWMizUYj2QGFaYgLdDwE1QfJ+jcfPWS4jJlk29tE9mV7wdBk6z6X8RlS/bxANDoYHifdDxg6fzfGPFEqd26ojIIhaTPsAIvdx0yq4Sknbqjwl0/1J8zYhqg7UFWRc9auNiQoxQJdIrhpCLBra5agYhuYeIXnQ319EdSJuMNsf0Cs0vANcMOTfxyi67bw5xGrKNw5MBu8mKyUcaBvG9zzRNYe0D+gbhBw/c5wUMuHdOWtuQqBY0jobVegz8Q/ABfGRxn/JxH2kAncpv7smJXLJnJmtfwZIMSDb8qMGuQLmIfbPd56EElLOtORzkGMWkcoc8Vk4trjYJ0khrXMlymi129KJ8NweNeO6Pzz41s2wPtok1QOVgWHZ12DBUNlVApxKAcLtyAxyCAO5eJNXGYQ7BYgICBt9U9S3yPJG4PgPs1TGXDVhVDA3tbh80FDOSx/hde/zFaqyPkPgqNgxoxL5LmnDZEeL0oMhoKnQxgGu124hlftqrVgb+PefbDjBFMR9O8UwBKkkb0/fpOx2xvNbhVmH8YLrUkw90QLU4DOgwy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(55112099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk0xQVJGSXlmYi9tR2R6YTZ6SEZaMENDVkwrWXB1T0dGNHZaQ2tQdEtDUllT?=
 =?utf-8?B?RWlDS0Q4QVYzNFpDZi91b2JnekZlOU9IbmhrU0xpMEoyMUdtcWxQdmZKOHRF?=
 =?utf-8?B?UHJyd0ZFOFBiM2ZIV1h6L0VFMFoveDlMRmlMT056aXlEd1VldXZuR0U5aytk?=
 =?utf-8?B?a1ZKenFCZWhxOFJqQ0JhcnM3b3NFMm1xbThJVTl4ME1JODgreDlYTTdYd1VC?=
 =?utf-8?B?SzQveGVCQVE4SGpmQ3dWTlV0SFdXQTB6bFBQWXNZRkVSRzBSY1pIYVd5aVI5?=
 =?utf-8?B?ckFKbUE5anY0V2RPSTFLSmJaMWFieE9WMUZ5alIwSUpDbFVIMWVtdzh5WVZJ?=
 =?utf-8?B?UVRTcjJYRkRrcFV2Wkw1aXBCdUtvQThBUEhJRnFYb01IMVJOMXBqRzVUZUEv?=
 =?utf-8?B?NERpWVZuY01ZMWl4dGMyV0Z3Ky9ZYlZlQlh2dXNKR1AzK1BVVUt4SmRKY1Y4?=
 =?utf-8?B?SmRnM1NrQU5uL0QxYWo5N1pwWTF1NG5BTkxmV1pabG9BYW5jcUZIcjRpWnd0?=
 =?utf-8?B?NjRyRGFuYUQ4WUZ6ZTNZTm9WMkNGRzUveWFOelZHTlFKZmJINzNFNnhydTRp?=
 =?utf-8?B?bWRQWHk3RFhCbzlvL0ovd1lNLzFUZzVzN3BEWEp2UmpESkhRNkE2cm1iWVVI?=
 =?utf-8?B?R2g4RWVSczBIWlgvN0VOSDlJbDZPbVVYTzZQaGNWOGhkNlBlRWtvL0RLcXI0?=
 =?utf-8?B?TjNhQUhrQ0h3WmxRSlFBU1VEZlhpMUYrQUZIeFZoUGZMemc0Tm1uaVkzdlRo?=
 =?utf-8?B?OHduWFBPaXBkWjkzNHRTS3ZKaVdONElmRVhkMWV4T1BMUXVjNC9WbFh0dHdh?=
 =?utf-8?B?ZDVnZmtoc0NOZU8rNFJDalovNys2Q1UxbVcxdno0VGZDSkdPTHdmaTQ2NEV5?=
 =?utf-8?B?S0tWUndUNDV0QkdVSmE0RVJTNTAwOU1mcmF5V3REM1d2di9WRDNBdWUyVldt?=
 =?utf-8?B?aERFNnc3QitCV1NRdzduWS9SaTErQ05FOTh4Z0d2dnNrUFJoVmxDcDR4T0lT?=
 =?utf-8?B?N3pseUF3b3FrdzNUQVpVR0NLaHJQdVMyaExMSWoxS2xUZVkwTTkzbEVhTDhZ?=
 =?utf-8?B?SUJlcnRLMXM3YStxUU50NXpSNE53bEhQYTRxOFdiMzU3N2J2Mkc5YldNMjNF?=
 =?utf-8?B?VzByNlRYb1lwM3NFcnZoNkFPandEZmdYK1Z0RXBQb0Z6RVgyQkNXU3k4Q3dY?=
 =?utf-8?B?MHJxZ1dhTk44M1pUdlZlZGg4bHVGTXBXWm9SL3h2SUtTNGEzT3A3eFlNK2Y5?=
 =?utf-8?B?YWpqSU12M21WeGJ3YXN5RktKZk5WSCtsY05KbEhHNi8zQjJEc0lrYnhIR0pi?=
 =?utf-8?B?ZElnWFNGSDdwRVpMTXUzbi9rQUlEYWU5L3dkbEV5U1lPOWxEQnpNK0NWd1Zo?=
 =?utf-8?B?VjBOMi9yd241V0c0RE9YM3E1dXlwNkE0TXVLQkNhRktYV3NYRGt4eVdZa09a?=
 =?utf-8?B?aGkzWHFwODNYaENVRzZhbWJ0bHR6QTYzYURPOUIwcXVGYmNRRStVdDF1UXZs?=
 =?utf-8?B?bFRrUnlmYWQrV0tYME9ZM3RramxOMFluTEJMMmhjTG1CSk9jRE9JbXBNbFhB?=
 =?utf-8?B?Q0N5WmdpNmxtUDNZKzRaa1ZxSnlKVW5QaUJVbVJ6dXZ5UXZEL3RDYWdVM1Rn?=
 =?utf-8?B?eVhrWFN2MW5TTmlNQlY1RVo3cXA3MmlxT21sM29RRDhUVUZnUFRyKzZDbVdt?=
 =?utf-8?B?Z2Q5SzZ2RU1XU3N0MXZRY1BPM0VZdm9nVzF2eEI2aWRnaTNWL2xwVXZFYVpQ?=
 =?utf-8?B?S1BGd29YbkRXM0ZRT1UvR0FtUnpTYkM1cElvZlc4V2c3WFBUcnN2Y01hRHNR?=
 =?utf-8?B?dDYvZUdmUHlsSU4vcUNzaGJtU1Q3S0JQMHR4cTBMVmpWK1k5QXNEYXlHU3FQ?=
 =?utf-8?B?ekd4UFpIOEFINEJNRk9WRnZrSlVsSDdMeUlIQ3ZiUEpubzlteVpmcnlybWZY?=
 =?utf-8?B?T2Q5OWt2VTZ5ak9jWEFhWVpTRmszdE40Ri9KMnQ4dnFEcUc5NkYzcUZEQ2tn?=
 =?utf-8?B?c21DQXBrM2VaSlVvSkZOejZwZE43ckZFOEx3UUwza3Y1K095YjhaS0o1aWl6?=
 =?utf-8?B?cHE1NjMxV1NrUVBRaVA5VjdmNGx0L0pHZ1FxMWd3VlJEeE9GQTNaUUNTazkr?=
 =?utf-8?B?a3ZjYVdNbFkwck1vWXdwdTl3OVlCbDJhbTRFR0lMR2hNNlJtNkE2S2I1TW9r?=
 =?utf-8?B?V3dwODZLNDRrdHhNOXJzSlZQUEx3N01lam5uQ3lPd09XOGtFS29sUWxEc0Zq?=
 =?utf-8?B?VUQ3NDlRWk94enN2enNjRzlQVkR0MFBuYVAzSlZRaittakJiUWFtU21NQy9R?=
 =?utf-8?B?OVJia1E2NjZJYUVNY2VubzdzTWJWWkRDVE9NckcvajVsUXZlUlNhQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b864733-c62f-4163-b657-08df364a9469
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:56:45.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pvSnKI4BCI/nN2fXCC2iTrxU220s0Hx76D+KmvjswtR8Ib2dX+xTGQF7YvOjuT0IqreOz982JU4WtMkNqSdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5732
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 05:56:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24580

On 29.10.26 02:44, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
>   Following up a request from [1] I added scripts to sign existing SWU files out of tree.
>   A rework of the existing sign-swu-cms was needed to allow reuse in out of tree signing.
> 
>   The script interface is:
>       sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
> 
>   where the SIGNER_SCRIPT interface follows:
>       SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
> 
>   SIGNEE and SIGNED are provided by sign-swu.sh
> 
>   1: https://lists.cip-project.org/g/cip-dev/message/24534
> 
> Alexander Heinisch (2):
>   sign-swu-cms: Refactor signing script to be reusable for out of build
>     signing.
>   swupdate: Add out of tree signing script for swu files.
> 
>  .../swupdate-signer/files/sign-swu-cms        |  99 +++++++++++---
>  scripts/sign-swu.sh                           | 128 ++++++++++++++++++
>  2 files changed, 210 insertions(+), 17 deletions(-)
>  mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
>  create mode 100755 scripts/sign-swu.sh
> 

Style-only (so far): Please use at least 4-space indentions in the
scripts. The patch(es) also seem to introduce trailing whitespaces.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
