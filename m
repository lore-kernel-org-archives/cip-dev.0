Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF75C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:19:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32339.1785161966471536027
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:19:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zyScfyRH;
 spf=pass (domain: siemens.com, ip: 52.101.65.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlz/dNO2b+bHP3ujvJP+v7+50N7hN1r2nXvQI3QdbobQYkttYC3gihn+s9CyuNWIxKjflQbmCeXcTlUW0YQwszkZDRGJ0TuVOUCDQp+mUNs8u0M2ie2ouFrUEqSZFnmnamzOaQXBxV9AA24FGZra4wwcuJRAlFkE7sO2tXvr8D6WNeTFadx+5AFY4N/BRgxIRRjqJQdRSrPYAh0G59ouot+JXXC88Sky+8gws4EQ3M/ltvhJ3HD5fWZw8P9b6WVtrnfChfyBI0r+L8YyKUnsLaR+f++l/IFR6fHlJiu24stQ+OzBAwLlQ7HBp20kU2K+FR4dfMd3GsRa7HGcJfylUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqrCcohuhalnGe3uxwkS4KNhSZStEGX7cjmNf/DLYEc=;
 b=GU3acvjXadVbHfB0MrO6m5T3LezdqPvdJLp2FNuVxD7a0MI9AarRf5NFsb6F+8P16PgTkROrurXPMNpz7X21EnEJDWf2+iyvTC90qZNR06vYTlu6T16Tl+EdHetyLLL7jlhFQzQbBVGeNWTK8kQjrc3QUE84eL7dzCbEkkGlc87rD4PokxRrkiD9X3Xhl8bQ8ppkN1bfJJbVQhG79bLcC6zjeinwIZl/jDeNWNeVqmXI6smCFMmCEvg7zGqCZ5zBLqziyeQbG1RNypckFs6/CXYeXKzzEQlR1S+bugJDP6V+VAgQj/UGy8JeTxNqQlylkhefIpnLNu1jD9a7V0cgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqrCcohuhalnGe3uxwkS4KNhSZStEGX7cjmNf/DLYEc=;
 b=zyScfyRHnhZyx9CllgTI9bS3kXSAM5RYz6/AtTWy7T6LySUlUGYu3ajZ9Er3eI9fFl9Y1Y/HnMFs5SPCTNMPUC+Mtu7sBHT5H05VABL4Kj2BI5yBt6bbxqNW4Bz3hzZ+WQ0pTsb7CxCQqi9jLBzLf8vjg8lSbsTk5YHOW+Svf/yqfx0MAbrdzEVteVkv3JBsqhrVZNowXOf/ADUXfK58XF1y0ewy8BMOIKnxVYMCW4bp1QdESISVNVrB/aMx+VwsPbfrwRQHvzucsBcZCnIOWovwbaSFeeOPwTUFdtRfHQfu/Scat9iiJ/ubK3aQjvyJOJRbPD/N9PBWEPykHSlePA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:19:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:19:21 +0000
Message-ID: <1a989855-7baa-4d5c-8a90-bf7dbef9444e@siemens.com>
Date: Mon, 27 Jul 2026 16:19:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 05/14] Add cip-cis-validation
 to validate the hardening based on the CIS rules
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3853fa66-80ae-4184-5a89-08deebea0d59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	VTtJNaLDw3zQDd+p9xdfFPC93YaLMXlF/0edGKnKS1/m8AcO3Iur7Kxgl8+4rDiBYD7HELk6n4yElupZBBXOMLFsDm92wD0fv7uag70O2K4HvdDb9VF6J4pqmNMMNMZ4G4z0DBQN92eooqdhPsH4eJ/R5J4cozES272Cy3rfHpSpScWMsTsxdF7UZJEkRuuzJVAppRmUjIm4SS2avJqYYqaH8ss9ZcECdzIHFopy6WfYPFkljSix236hjhNFG9aw0MbLenOMAFE1ysFhBRL04W/pCR3LFdoi8xLmDWsJBeqm2b0WH026jHb9lQyAToIZXE+BZKS6YJEkG/rONabRvLPuxb2j7aD/fbVkuAUFgFwvllOy4qChOQbpeKaRxDa8w8dZOohYVFsa9FFOwI0MYcU9D4r0iO/0RcOREYJv+NwyNDNQYVKOf8E3z+KF36u9XddpZ8hTr6U9phYuc++ajBLWjJg3j3mfqOTgj0uamkfl1mD7K+/09i8BwNzuKX33aSGtQck+LyED6jNLZMzEtys7BJv5Kf8FU8Pl2SySQpbE7hQqzDU5EmXM/3SukkMEMKxfHOnvdUd4Wa+2Jnzrq+M3dLwUZosvzcP4T8VQ8+YiSf4K8ncCk0I+s5J0I/lzKebr3UJ2Lp10JmEntryPBFrkcvUjo9gNPZOBvTrFyyo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUxiSTAzK1Jkb0VSLzYwaS96QzY3Tlk1UXgyRThiU1JZV0pUd3hPWnByZ0FI?=
 =?utf-8?B?L3N1ZGpnR1JaQkdXTWI3QTYvdXJrK0dxQ3Z2cG1hMmg3VE5hNExSQkpOa1dZ?=
 =?utf-8?B?TmZ6UXY4YWVrR1NBTzZJZnc2Smp2TkNOSE93NFVRUjRDRVZ3WVdIQ00wWDMy?=
 =?utf-8?B?bTRiblhTajcxNlMza20yZlV4ZnNpWmxFUlBLRnZGdnU4bVE2U2d3eEhxcVdk?=
 =?utf-8?B?d2dxMEFycnZkK2NsSnR6dlFFQmJtZWZhRG83a25sWnFIcHUxQ1BhT3E3c2x1?=
 =?utf-8?B?Um5aNk92MGR1SmxDVG9yZ1Fla2JJNU8yUThCUzRybzR6RGRSNmtobytqRVR0?=
 =?utf-8?B?MXI3OHBOa2VKNG9kSXpkYUI3L0cvRmpYbWx5Z3pOOTNheTNSeVdsYjd4M2ox?=
 =?utf-8?B?V1d3NXJhRjNndlJEbUdCdGNKZEhKb0cxTDdUNTdvSExDN21HaDd6U0tXN0p6?=
 =?utf-8?B?clNxYllLeUlPU2dzcnErdWdhbk9EbFplM0pPVTAvZU1ZeDdQcG10RGR3cDhZ?=
 =?utf-8?B?Y2tqcGNtN2IwcG9SZ0ViMWIwYWhKUURYLzEzcmgxZGhMNFpNbnh3aTdSOHRt?=
 =?utf-8?B?OW9OUGRFaytVUGtMZkliR2wvakxmQWlpN3JXRDZTTWdSV3RWMmxRL0J5WHY3?=
 =?utf-8?B?SEVRQWhzem4xMGYwUmszZ2V5QzI4d2tyVWxySUl2TlJiQ1J2aXl5WTBPT1RE?=
 =?utf-8?B?dmw5SlpMeUdmNDQ4RjlQcnZ2TUlDbXJ3bVUvcFRndlpKbnQxbVI1WC9iVU1B?=
 =?utf-8?B?cW9nOHlJVVhHa1hoSTJmeHBuc0IyQ0p1VEhacFMzMFluclNNWHRhVnRsSjFJ?=
 =?utf-8?B?RlhNbCt1THF5bDl1SndvOUd6QkpGRlpwMnRhNHVPWElodUo1YmJ5YzJuVW5T?=
 =?utf-8?B?c25EZ2NrVnpvUEdZei93ZjlXRUlZZGJ2cmgrU1BldUpsWG9GMXIxdVNxRm40?=
 =?utf-8?B?NlRZMzJRUzFwZEVnRXpWbzlkbEYxNXVqOXNnUVFZTm50L3ZRTlZZRzhaUGpm?=
 =?utf-8?B?Y3RPeUYycDFzcFBUM3BHYXZQcVFUUmJHSXg2SUVTZ2gzdThVenF5S1Z5YzZu?=
 =?utf-8?B?cEdaak16aDZoVXNvK2pyUmt4ejFZUzNId3JLVGFvSXUxN1c1T3FTOGN2Y05u?=
 =?utf-8?B?V1lHWVA2V3lkMnducys2U1JHU01LcGc3SWtDVW5CejNpcUU0Zk5hUzJuQ3JY?=
 =?utf-8?B?V2szdjMwekYrYUN5M01RbTh3aVNDTlpURjRsdjR6YUFUcmRnbG1obDMvQ3k3?=
 =?utf-8?B?bTNTckdVN213YW1NVG9UU2p4MXlOUytwVzdpWlNCeVNwcHhzNEtnc1Ezdk9W?=
 =?utf-8?B?Vi80VFJlK2pwalN1MHZ0VnhxY1o3M2dEdFpKY1ZqcUFGc3drM0w4b1JVWm5y?=
 =?utf-8?B?TStzWXQwbHJ5bk5ObFFFSUhTL2hud0NiMld3NVc5b21VYzFUMzE2OU1LOFNJ?=
 =?utf-8?B?YTVxY3d6My92QXd1Mmc3bFBFR29WaGlDdGtHYzhoQkVJTW1NalMraHFZVWI3?=
 =?utf-8?B?Nk1zN1F2QWh2OUpRVG5nd0NoZEdkWlZ5Qm5FbXZoTE9lVEN5NnNSendhcC9x?=
 =?utf-8?B?NVR4TkI5eS9wWXZ3ZUNSNVl1aDRvejNaMUNVTTJtQXB5RXBwVXVQcU9wTnVq?=
 =?utf-8?B?Wjl0VVExeHNQL1VweXowa2ljVXVzbVZ1aW9kVTVESkFYNlJYcHJ5Y3hrOGh5?=
 =?utf-8?B?T3pubjRMNmpqLzBlQTVaTlNnM3RQYUJWajJIa0IyT3BRWGI1M053WDdseDEv?=
 =?utf-8?B?dHN1NjBSazUrVlFLL3N3bTNGVWdNNlBkaUh1d2pLRU1PTXhHVk92RlVEMENY?=
 =?utf-8?B?bDZUTUZnM2JOZUd0T2VqTVVva2lUZXJlZzJpdjZVOUoxYTAzblpVQXhTS29W?=
 =?utf-8?B?TkUzSk5NdDlpcWF4NkVCZUttSWJtVmsyQ0dqUksxTTZudlBuNkZ3OTZGL3Y5?=
 =?utf-8?B?cHZFOGhtZWRpRGUzQUNrY2l2STlzOVNwRzV0RHlsdGRwMVFYM2F0SDN6SUN3?=
 =?utf-8?B?UEtLbHNXMjNMb3NCL1JBdTlmQ1FqRDFUZVljRXhWQmxoMlRBbHFqZUVWN0hm?=
 =?utf-8?B?UVZtL3BxWkJOdDJHdDJPQU5PMUU2TjVlMVA0bU9kVlYzUFljN05lL05iZE5W?=
 =?utf-8?B?S2pCL2svcXFrZm53QkxmUUtBY3luSFVES0xTN293QWJTU3lPbjlBalhmRXd6?=
 =?utf-8?B?RVhpNDVkQW9SUHZseWJTQjRXbnFvTmtkK2ZiL3gvQkJPWVhvWWs1S21uR0ZM?=
 =?utf-8?B?Qk1kZUY0VUFwSWUvcWlFV3h5Tld2NHJsdVhuYXJ1SlFQaG9Wa3FBUmVyWks3?=
 =?utf-8?B?R1FUVGVCL0IyT1ZRYUdwQ0srb2VROEM4ekVYdmFnbFU3UmE5U3RMd2xmVG5p?=
 =?utf-8?Q?VpRtalSbII+nLKHY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3853fa66-80ae-4184-5a89-08deebea0d59
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:19:21.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XESN0hZMIgoelZCHMwQicWFe36rJRw9HYSESlPcE//VZhCv9s4RdmwKb58r1NbIuVk7T9JjOPur+lbHt5zbH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7019
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:19:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23770

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Clara Kowalsky <clara.kowalsky@siemens.com>
> 
> This adds the new recipe `cip-cis-validation` which uses cis-hardening
> to validate the configuration applied by cip-cis-rules.
> 
> It uses the configuration from the recipe cip-cis-rules,
> stored in HARDENING_DEPLOY_DIR to generate the necessary validation
> scripts.
> 

When / how is this validation service used? Again, missing architectural
description.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

