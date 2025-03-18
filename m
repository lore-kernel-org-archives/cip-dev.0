Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A30C28B28
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web10.7839.1742291845391671397
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 02:57:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ftXqTeVu;
 spf=pass (domain: siemens.com, ip: 40.107.20.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZQ0vuGiOskWSKwtrjUPRqGFiphWFk0i2+qbWFLfJelUJ03MGL6Kv6zxvrEvssbVZzKqcHAU3mE4aT2srw6CJeI11OYCguYrK6dzfbNKgrfuQS8zM3HcgI+vHWKjXx8rsrFhvAEyreWVHw8+z3bL3V4n7zt2tyqeXLxaBILzL/GFRkQdegPwd0+M3OijJMbG8YRZv0GGPSC6LK1fvBMH+9PymWn8EwBArereZXFxaqoMgM7zzTBIAaWvg+RlG6WsR3rNcmZbRLbm4ccRl1xpF8we9Xm6e/imhY4UVlVxj05tA1X+pauPlLoivoAcdjx2Qc/A25/8VFAwh3S1/m64jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWk7CsnZ31BetWFlOLzQMqnS6zo0X0VlmXiVU3o5uYw=;
 b=dlPyrXgZQXxauXebjRMSOHtjQ3cezY9zmS1ORca5ipc+nGDHzAqZnriYm/NL/NE3g3ExShfIeAKmfX6BZzNugYnmO6+il4WoEstmVeVta7VMsvgehUfu0nvdCQzpJCj5UJj9X+tZYzzzyWSOiMnOzJxZ9tZEiWZ0XaPbjOCMo61Iv2bUUQrVQ9YjgM4PdijXCgnceqDGL7+6PU5kZwEXZQ/AtsuMU9IZKtPM71Obgcp67xN8uz9Ygq0AJq3e2ABOi19zPkInVvWJ95zZ1EXqPrf8xG75s5O4+0vgq5dlKQFHWWLmg+WRr0bvDx0AIrg0YqQpkFm1Gfd4ovGC75L0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWk7CsnZ31BetWFlOLzQMqnS6zo0X0VlmXiVU3o5uYw=;
 b=ftXqTeVuwneJOR+faT9OeCAke1B4m0Gt6hSIHSRNQ2i8Bv7cdjkl6zZhxdYiJk+Fw82yrd+/vlADij8l4fxh9Jd7JCsyZl2nCKPMUM+wBZIYyixVvrnpCpmXST1zu/y5oiV5Hbd76iLMwjIYukRenjg5wctMoX/wKcVwy7HUrXUSJFyOfNxanpNAdynVb1v4m1egcsPdvkOwruINlfVi+7P8MKIm47IFWBf+ueYWJXuSihRSwftqVB/DHZmzyDjEm4PXqkdqqYm/c1qV4A0Ngs8AfPXS3CxKsOrr6uil/GRgCvpcKT8QpFzab6r0Dw+rI96GzuIbdGNLpSkCsYYs7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:57:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:57:22 +0000
Message-ID: <1998774e-bfde-42fd-a4b5-ccb3bdd668d4@siemens.com>
Date: Tue, 18 Mar 2025 10:57:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v5.10.234-cip57-rt25 (rt127)
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <Z9kv4aijWXNBDCrj@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Z9kv4aijWXNBDCrj@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d92d183-d96c-4034-bf01-08dd6603472a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Um1ZeEVqdmlqZXBrNHFhcmp5UnltdDU2alI5cVJqR0JUQ0tTY04yZm96SDJ1?=
 =?utf-8?B?YTFSYUFhWmZFek1IZ2IrOFdJUVRod0ZIZGpJUTBUNkxESnVXSFJWODFQN1JH?=
 =?utf-8?B?UVE1Q24yNE4zcURjaitnVmU3OWN0SjBma1d3TUtxV2I4NE9lL0NvczltR2Zt?=
 =?utf-8?B?T0cxRFZnRmdXTFFBaU50TVFqanNERXhUa1NJZnJUN3NmUEYzUlcrczU0WVVT?=
 =?utf-8?B?REUxL3RQeVhrQUNWbkhQVzUwMTNOUERKcUdNR0x0L0lKbG5iTDRUTUpHbTlS?=
 =?utf-8?B?a3V1enNQemFJeWlJMzI3QVVtWEtiSDVFcGEreXB4S0dKZWUzK0JzR0NOM3E5?=
 =?utf-8?B?YnRCVnkyV3kxL2treTVjRUJ2MUxkbzBpZER1cUo0Y1JGNXI5YkxkQlpqOXBS?=
 =?utf-8?B?Ujg4em9YN1IvVkRibUJIWXZhRGh0R1kzbGIrWVBWSnBDM0Z5RHExdm1jeXFp?=
 =?utf-8?B?RVFQNEJpM1IwN2QzZjgzK2xaQk5XbW4yUFJYQ21aM1lrcm44aHBJbnBmTlBH?=
 =?utf-8?B?aTFqbU5tNzE3c3NKb3RnOUNmSmpncnRTM3hZMjQ3eEpYRXAxTUE2bUJoSDBI?=
 =?utf-8?B?cUd5dDVhK0ZnSzBxYzBRVXZaVTU5UHczNmkzM2J4dHllNi9sczJEMFFVcEpu?=
 =?utf-8?B?c3VmdEZEdkFpVk5IRFJJQVR3Sjg3K1BOaUdpTy9pZzNuRGtjN0NTMFZQenc2?=
 =?utf-8?B?WVpuQkxZbnhiWkJCOHFjMXdHb0tGK08xRmZDM3puTnhwV01tc1lrVkRicjR0?=
 =?utf-8?B?UnpjR204cTBtcUd0bi8wQms5L21NNkYxT0VFWjhHZkFZSUl2MFpacTVOd21q?=
 =?utf-8?B?NXc0NWI5TlFEUk8rY1BxYnJuRGxHYVB6aEpkRlpIbVdGeWVYcUtDbjRDc1JQ?=
 =?utf-8?B?V2Z0b01KY3dCN01zaUk1YXN5aXBBc3NpQnRGUThJaGhWSjlBNmxXQWcwYVYy?=
 =?utf-8?B?WmlBWFJ6cVkySlBLZGlXOHR3SzVSZlIweGQ5U0taNUllZlozcG5IR1B4Z1d0?=
 =?utf-8?B?U1FzRUJxemFkdTlNczE3b0ordGNtMGJheldhdHJTZ2hjQkFXZDdRdGsybGI5?=
 =?utf-8?B?ODRQMXNlcjk5RGdCT1FnZFBBTWlBWE80T29JKzFydjlORC9FRnJJbEVadE9x?=
 =?utf-8?B?YVNweng5NDdLd3ZHdmhMaHpob005NjdzNFdjVjhXZ0JOMnBkQldTeUgwYy81?=
 =?utf-8?B?dmMveFcrNVNDUEVyeXVOWi9nSmdFa3lKdTlxbWRkUW1vVGN6MzgxTGZJbkU1?=
 =?utf-8?B?ZHZLdGFic0dlRTNXQTh5dmdYSzIrMU9IWTdELzVaWnYwaUhjY3phTlI3YkZx?=
 =?utf-8?B?YTVNRHl5eG01YUFkSk1SMjNUZ1JXNGxsL3prdlA0UVhhVWg4d1Y2cXBtc2N3?=
 =?utf-8?B?cTRqVG1zdnNXL0kyTEVDOXRjR0ZDbDZLbXdvc2FLd3dXS3Q0WVRsbWxZa2dr?=
 =?utf-8?B?T1lMQjZsL2VJcVVWNFNjdC9NUUU4Yk1FOXVaektVcTYrTTFNSGVmVlFINUZl?=
 =?utf-8?B?L2E5Z0Nva3dzUXJzQitkOWN3aHc0K24wZTZHVkt2ZzRJZnczSmdpOUQwM0lE?=
 =?utf-8?B?ejRQQUVKb2JTMk5Zazd2VEQ4RUZzbEhZYnpidjZMdEsyNUtBT3pTalRvczYr?=
 =?utf-8?B?bVBJWnZjaFpuODFlZitrT0ticENWZWtsSjY1bzdwbjVkc0Q0dDZUd0pwRkoy?=
 =?utf-8?B?NDArSkRsdW00UXdGQVpkVlhnbE93ZE90L2hXZHlGaGlCVlVhRnUrMlVDZTRX?=
 =?utf-8?B?bDlHeisybE5vbXo4Uy95bnI0eHZvL2QxOGRBRXQrQUtBTlFva3QxY1g5TFh1?=
 =?utf-8?B?L0VuMTgvNHovUFNPZzEyZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVFjamVTaUYwK3hhRVZMeVhmeHVQbWtUWE54QWEvNms2MDJiYWNsakpSaWVP?=
 =?utf-8?B?RWJDWkRTcjJ2NkZrZkMraTZ2TWZHaXl0M0t1OWgxVnFOUlQ0OHdIbUxwOXBC?=
 =?utf-8?B?WDQ4d09UNUNCL2wvRG5ZUzg3ZjJCd3J1RXVRK3EzdjFVWlQ0WFI5dTJHbWlF?=
 =?utf-8?B?bTM5S3ZxOTRUMlJmbmk5YmprTkRHdTFLdVo2UDR2a0RPTjExR3ZacDdLQ0pl?=
 =?utf-8?B?eVhsZ1lqQW02S0NBSzBXVzJ4SVpUNTNKbytLd2tvZXJuNXZhTGFrM1BPN0lD?=
 =?utf-8?B?Z2xiWHVyYmR4emtVeExkSW8vNkd5R1NVTXF6ajd6eGRSdkRteWwxMVAvWUlv?=
 =?utf-8?B?T1NoNnAvYkJVSVA0MEFlYkp0SERubktkRmRDbEhSSUpBL01DVng1UUEwSFFl?=
 =?utf-8?B?TjhQQzhTbE5yS1BOdWRvMFRUc0hJZFpTQkdlWGM3dm9zaUxLRDFwQVQ4SVV6?=
 =?utf-8?B?T0h1MyswSm85R0JhNnhneEZzajRHV24wZSt2L2ZoaGJicE9kVzJRSitDNDgz?=
 =?utf-8?B?Smw0TDkzcDRmWmhubGJjTUZiNlJsdWxveGY5Q2ptdjFMRDlqWlY5a215OU1G?=
 =?utf-8?B?RjJxbFplZEJObmcwZ0JNcmlVb20vNE5OVFFiWHJoR1d6amdDak84RWptd1Bq?=
 =?utf-8?B?OUxYcW5UYTBTK2tlVGJvNUxzTnNIUDhqUDM2Z0xSWGo5N2x4dnRaZlI2cnlR?=
 =?utf-8?B?bS9neWJSb08vb3BaWlZXd3hscXhiaDB4OUQwODNSdzhoQkVCTEg5ZENKeU5M?=
 =?utf-8?B?Rnl4OXhDS3BFOFdobHJTaVZBMnRxck5PQ0I2OElGVG1zdUNzR0hjS3VSTkVz?=
 =?utf-8?B?NmJqNHliNTVQbUNPMzl1WXdnaWl3WmxmVU9YRXhZQjlKQmp6c2NDTTkyL241?=
 =?utf-8?B?VWltdGtVbnZ4YlpKRzQ5blR0YXhsejZwUlFWVFBTUmpKL1ZwaUFwcTkyRnpN?=
 =?utf-8?B?bHNHak5YZDNQT3l4VUhwU2RwbDdINVc4bU9NQmtPbGpBTFJZMDVKVXZNVjVi?=
 =?utf-8?B?b3h3WUpaS0RVNmNENGNkenRjSE1EY1dRM015TUV0bDd5MXoraGIwdzhmZ1k1?=
 =?utf-8?B?aGt4RFFJMTNQaWh5azhLRkhuc1ZkQWJwb0x1eUtaVDIzWjhLU0pRbFo3My9B?=
 =?utf-8?B?R0JBUTBudzlHWkpyR0R2NEZwNjFCam5WRVNkTDlUUExqUnlDMDNMQXRncC9i?=
 =?utf-8?B?NkhmWDBFdVRVYWlVaEw0b05tNGVKN3h3bnBYejRxUHJoUEpmUXk3MU9YcWMx?=
 =?utf-8?B?djRBTWVCNW01VXc0VTZPRDNvTmF0NnhnUU5HbjFUUkxwYzdmSFdLUzhoNlZP?=
 =?utf-8?B?bDdVak9zYUdsYlFsUFprb3hpeTVkL0EzR0gzOUJuZlQ0MHBRdExJVDZkK2I3?=
 =?utf-8?B?MjFrUkNCSm4yVGhQblpPWUNGdzhyWlF1VlhHa1RQRzF1OUgzU29HblB3OWxU?=
 =?utf-8?B?bjFUSzRzZkQzMTRMdCs5R1V4T2t6TUgyWkd5K3l0RFhFazJQdW0rOS9QWklU?=
 =?utf-8?B?aC9lbmxQT25TNnZ6TFViMVg0c1ZIdzE2UHFLN3Z3T2tjSjB3cW9yZXZEOVZr?=
 =?utf-8?B?eUlxcFRrdHdGL3hUUDlYeFMvRmEzUXArMlVJS0RDTmpvUVVUWHBxa056Nk1I?=
 =?utf-8?B?NVNwUUtQVkRxVTNoWFVseXg2cDB6WGFTV2puRmVmalVoVVlVNWxvdzhFeTMy?=
 =?utf-8?B?Q0M5VjFqVDFGQ2l5YkZ6cjhHN3RPYU43UFRtY09hU09ia2Y2U1QxRUxqSytN?=
 =?utf-8?B?ZkhuSWY0R0FhN21XK0EzRWd6MjhLcERTZFNzQWlYYWtCb1FyY2NOMnp4bm1K?=
 =?utf-8?B?VFd5Smpvdmkxb2VCVjJRM2pzUG9LQnFENko4Rkd5UTAvYmFLdTUzRG9YQ2Fo?=
 =?utf-8?B?VENnM1FSRVM5QnZ0Y0JLV0RaRFE1OG1aSDZ6S1A3clBwTlJ0c0xQNmZ1RzRN?=
 =?utf-8?B?TjFKMzF2M1BKbUlOeXRFdjJBeHdpUTdLQnhZT3lmcEpKdWFxRzdWTGY5ek1D?=
 =?utf-8?B?R2M0ZDVDSUFVSUJxTzN1RUxwZ3hqWnlCOVJhVXhOTmF0anpYREw0STR1YlFk?=
 =?utf-8?B?Z0R2NDBDcC9BRHA4WnVpbnNqeFdNL1VPZUo1ZEExOWlVc2tGUFdWWW1ON3FE?=
 =?utf-8?B?RDBaTFJ1MnhKRERFUGFOWGdzVFlIU1dkNnEwYUVsWkRBdGMzbk5abmxpVGVM?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d92d183-d96c-4034-bf01-08dd6603472a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:57:22.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKdFFNGczUMQ8cGQI7eDgDnQt2XUfkacqNX3F3dDspqzBcY5aTBW3yEA6l+yvirXT68eI2asszkQ+yQdMJfs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 09:57:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18238

On 18.03.25 09:33, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase
> 
> And their content should be identical. There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 
> Best regards,
>                                                                 Pavel

"[ANNOUNCE]" tag missing - did you change your "scripting"? ;)

Seriously, part of consolidating the release workflow is unifying the
announcement emails. These inconsistency force users into manual filter
modes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

