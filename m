Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD83C02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 13:21:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.57])
 by mx.groups.io with SMTP id smtpd.web10.116122.1738675277867192717
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 05:21:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wrC7VBWr;
 spf=pass (domain: siemens.com, ip: 40.107.104.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl/9cz7R5Ci19v1pipvXLcoVsvj+edrzJpxAr1hiQHf10NPCDWaioX/WEgqLsxu6ATyNiF5jhLeoFWOjL9GpEjY+Cvi/Gq0E59i4StaqhV8rNc+Zxec1MviAxsfhWoFQPkzVedGhoucY6w+jraYm8DwY0/d4QaZ16HJrNXNhLzkk6j1spkhG/XZ7R2y3GXPEMNHL//wX5e6oS5uIV3BLNbQJHn15lOD28iRsQ5XSFJRpt3sXxsd9JIbvcFr2SVsKB1fXV3DrNVghZMHdLtG9/hk+Eq1hQ9Uj96dg9HjeYJxhSvAeJGRFylPd4Tt6j5BASjiGByvvQn555C3uXsyffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhT2x35/TuoMO7Gig9USMR3N/rj5pTIgON7x/eKFpV8=;
 b=K9syUFqB7PLimVOLA7TO1paUORkVnuMzoDLzlUhZMh+Gjm+kjK2fQcMPgxCncb6eOIgN+AgNNegDqJk4j33afguQbhK8RiqzvhIrkzNaM1hrUKRiqUYg7Gvld7mjsTE/ai+SEePmfWaZx8jWCke6+gXLDNnaYhooTxkDmlj7xrlh5SvVz4Jif6Zm/DuhyLPaRdP+GAim1YzEnfUFjtvMx+w0ydq1FE+wULLTRasfTndtc+JD/iXAeGuZ1jCOZuNZ+gJEx7r+i6+h9WTf1THKyplR/PSNcjdDbuSje0r1rX3k128xtaY+3VKj5IAWhUMdkFc7oGvjYoO9NwiRPNjWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhT2x35/TuoMO7Gig9USMR3N/rj5pTIgON7x/eKFpV8=;
 b=wrC7VBWrCUSm5zMRqJ3CPmSTQBVfxMk87W4PSe0yk0FP8/6X4+AG7KrmhOlJdMpWgQnQHEg+iIQ4rDeeNSYhL2RLNx6tJjZ39N6a+8TagR42+bYcCG6MaVmjWiHNHwOMkUtnvayrN5o/FgdIrsC3OpO6jntfqMGVYc6KiPxFjOZtI9rcE+b1qsA4KUGKBDYW0352H1vTAqMsvuqacCWRtOYsMxlGj/1v9dMeNk7nW5p4HWynB+m5DWUBRPrCrGXrjboQzJ1m+80XwiNzLCM14tvA3UTjSawg8nuA/TkaYwiBVdxh9crwlQea8mOtfGbkys6hVs8cGBEyM25+OGuQyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.6; Tue, 4 Feb
 2025 13:21:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 13:21:15 +0000
Message-ID: <578c7f2c-ef52-492f-9dc8-054d6bed958b@siemens.com>
Date: Tue, 4 Feb 2025 14:21:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as
 template to make installation path configurable
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250203115321.3589084-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250203115321.3589084-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a617453-00f6-43e3-6783-08dd451ecd45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elNwVEJ5bzJIeTB2aE9qYklzM1ZsblJiVW5Gb2lKdDlJc05tYlp5UTNqSWlY?=
 =?utf-8?B?aGdWYUNpV0VmYkIxcHBOaEtsY2J5blM5YSthM05LVEhWZHJmOUZUMkxSaEJU?=
 =?utf-8?B?bnVvYy9vVFFJak9qbDdUeXJCL25HbmVqOUN6M3lEdlJTQWdzM3dOQ1dFZkxh?=
 =?utf-8?B?dE53MGhZYVRiM3lyU1VkdUFKTFdHL1lReFQ4MkxDMmdoTTUxOUZ5NllzOEI2?=
 =?utf-8?B?OG9TOTNkK3N0cE84Yng1Y1lCYWJpSGJVS0x5L1JPc3JYYXlLZGl6aUtGZTRR?=
 =?utf-8?B?VTRPRWE5WmRqYTlWOXJ2Mi80dURraVNNYUhCK0UwZWwxTW55c2dmRzM2L0Nn?=
 =?utf-8?B?L3pNQlhwL0xoQnlUbWNxaE9ydVdXSFRMMG5JUVBWdng2THZCQ3pRYXBWaXFX?=
 =?utf-8?B?MWswOEF3QWxEaERkb1NVRWFEL09zNkUwOUQya1ZyUTZhRDhFd3BRVlNHVC9G?=
 =?utf-8?B?VkwvcFBiS0pBRjlINW12RDdaUE1nY3ByaERDTExUcWRldHlSS3VVSE41WEYr?=
 =?utf-8?B?WmduKzlrZDgxWUFzTEp3akdSL3FPUzhXdWlpSXpoQVRpWldZYWZLa3pweDBx?=
 =?utf-8?B?ajlOZ2VraTFOU0FXMlppNGR4U0JCTWZiU1ZhV2NibGdDOCtFdC9XUHdNZEVk?=
 =?utf-8?B?MFNVN096YURBbjVpb0dNaE40bjE2Wisyb0NkVnE1OUJTcy9nWVRBamVKT1R5?=
 =?utf-8?B?TWEza3dGK3ZVYXZZYTRQQ1dSTkUwblNhRTJQbEZmVWxVUUNmVkZOL0Ftc0Ni?=
 =?utf-8?B?Z2R0WnVDZXpRYUhiTDVPWTRvbG1TZXI4ckZtZUZIN1BKTmZKTVdteTJTMW4y?=
 =?utf-8?B?YUxqZ1htWlhmRExZQUhtWXlXVlJ5MTFYRlo1eFVCVVUzMmJZSEVMellNc2Nu?=
 =?utf-8?B?REMzTmhpK0dWSlpiM2tRUzZVL3JBVFVjeUE0ZFhWRlhzK0hUcE9rUTI2cjZW?=
 =?utf-8?B?NUkvZ01yRHVSbFduZUNxUGJWY2J3K2RJQVdodlUrRTlEN3QyZjZXdTZmVnMw?=
 =?utf-8?B?Y1MvbHd4ZkhsSUtlMWJQZ2d1bFpVSlAzenhHVFRlMmVOQUJQODk2dGx2R0lk?=
 =?utf-8?B?elYxN2FKWWJJMHFuZlNWRGt5SzlkeVB0aFVsUVI4UXRJak1vVjJJN3hOVTAz?=
 =?utf-8?B?cWZuejZwdWh5bnlKS1MvL254MmtzbnQ0aXJZVlRMUDB5NEpCNzFtS1BycTcr?=
 =?utf-8?B?NWZpdmNFN2NnNG4rNTNNbjRjeHc1SEN2Tm9vQ2tObVlqcjFkemtuZ2o3S1E3?=
 =?utf-8?B?dmdoOXI0U1ZBSTRodkpjYmJwa2hueEZvYk1qejhpVmpHQ1RpVVhNbktKdFYv?=
 =?utf-8?B?YXI4RThST1BDdy9HMkErTG1rRGpwMVhBeWpQQzUrb3I2QUc5d2FxckgvYy9I?=
 =?utf-8?B?czNJdFhiNEdNTzRQd0ZEV1JNOUR1TFQyVHNxemxZMTlzMFg2Y1V0M3hDM2Zt?=
 =?utf-8?B?MXA1U2NhYk9mb29yNnVabXBwRkYrR3QwUEl4U1dzZnptZ3Rmd0pCcy8xbTFj?=
 =?utf-8?B?NGFEUXRBTkF5VW9rdmNZTXBES1VkTFZVM3RPb05hTldzZ29rcHJac0lsaHVK?=
 =?utf-8?B?ZTdzWkduOW44S0ZjZmFoa1NsVWg3ZDVxWkd2Ym5CanVrdFN3Mitrckh4MENj?=
 =?utf-8?B?TmJJckVOMDA4N3ZaMTByQW5PTStJRW1RVngvcklERDJsdjM4cHhvelVoaXJ5?=
 =?utf-8?B?NW1XcEZzY2xhMEcycjdJaDFPQVpPajVQSWRBSGxqODZQMTVMbWEzS01HemNx?=
 =?utf-8?B?OS85VGhSU1BaVTdORUZwdzFZUmxROUxiUWFGbXJUYStuWmJPdHBhRUpXeFlH?=
 =?utf-8?B?bStvRXhxd1dOM0YrWU5uRVRQQWNBS3hiUm03bkovWXZIalUvNUNKbUJxdThs?=
 =?utf-8?Q?mijoUTTK0b4gV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmV3K0Y2cmtLUU80dDBhY3J0QXVybGJDQXRSby94emFMNDdXcWwwQTQxZklF?=
 =?utf-8?B?Z3EwaEUwbFBReE1leU5uZU1NWWg1aWN4ZUZ0cnk2SDE3SGc5VW9sV2pxbnQz?=
 =?utf-8?B?amI2MXJ6aldLM290MEJ4L1Z5OGk2SDlxZ2pDbElMdzZIcHRiSm9KeWorZ21G?=
 =?utf-8?B?NWpEZ090bkxBNkVHY0lHU2RoZCtDSU5ncWgwWFVkYTgxSlVHSzR5SUtlYzRr?=
 =?utf-8?B?MktvZVQvQk1zeWpvQjBZQWxKc0ZYOG93b2hGcUl0cU9yWkpJNThtdzVHcUJz?=
 =?utf-8?B?ZWdMUlJnSVgvQlp1TVBQTVB4VmtDc1BDK05YbkIzUGdJbjZEYmRkQTVPRkRC?=
 =?utf-8?B?bFFVdlU3N2IyWVRSV2tJQWFnZ0toV0hvdEhGTlJZNEwyZFVIWDRnZUM4STBK?=
 =?utf-8?B?ZTk4ZG5TOHFXL2RFbEwvUDJuRmQ0WkIxKzJOS1dyNlg5b2hNY1hZb2R2a1k1?=
 =?utf-8?B?Kyt4K1VoSWhBQTF6bHVMRUsrVzB3WEJyMmpuTG9xalI4U09Qem5wcTJkdGFx?=
 =?utf-8?B?SDlndXFiVUp1ZnI3TEdzV29RV0xuY3Y2QVgwNzJiVWpQc0g1dnhuY2FDZTF5?=
 =?utf-8?B?Q1IvSGYxSUZLOGNLTHJlaGpCUEJjOXZicGVLbGpzbXEwV1g0TEFnYTdFcEFh?=
 =?utf-8?B?Sy82WGxUZFViVnVlbUI2Q0k5U1JxcFA4RHc0bXhEWUUwWUNJRlp3MW42VHdw?=
 =?utf-8?B?WWJqdkU2Z0tpRndLL1B5c3VYQXMyRGZGWnlwQnh5eC95RDRsTkxWeWJ4UUtT?=
 =?utf-8?B?L0krZ1hRdWJWUU5TVE00NUNqck9mRDdsQjJDZGxHY1VmMUgyOEU3MWt2NFBm?=
 =?utf-8?B?U01qVi9kTDhUN0lLTXhZd1hLK1Zyam5IaXJsWWMwd0ZTY096TEIrM2hVTGl6?=
 =?utf-8?B?ZTN1eW9YS3dyUVNkcFE0VWZqcmxVaCtJSW0xdW42QWxYaGc4MlFJWWN5WkRa?=
 =?utf-8?B?N3pjWlRqUjFhaFdKTGRGcG44VE9HcW44NUFxN3pzYjFOK1UrWmNJUGNDSzUy?=
 =?utf-8?B?OGpWdk4yZ01lK0QrSE9FcGxHNkpmYVdKaWpGS052R0ZqZy9tZVVZWnpITzYv?=
 =?utf-8?B?djdvUVdlQVBZbnZ6cGlGd2NrZnNJcktxOWZrSFRjUjVyVHk5N2VnVXp5bGZ1?=
 =?utf-8?B?Q05ZNlRsZE5KQXJ4Q3FMeEFZdVp6SDQ1TFFwbktacS9kOHJla25oSVVlOUF3?=
 =?utf-8?B?LzBnT1hGOXpXc3dFUHpwd01iWWg0S1JLSEFGd0dVbWVjWCsvalVkaTRwWUFq?=
 =?utf-8?B?TlZVSGhjRFE3MGRsdzJORGVWUnVScUVRMFVFSDVCRk1ETThpR1c4eFJBa0s1?=
 =?utf-8?B?bE1UbG9HYy9OZStuZGppYytiNzBkVUE5U0U0TG5sZ2srcWlnQUMzSWtSYUdu?=
 =?utf-8?B?TXRqVURWaW9DYVhFU1NKNWhzMWFySzFjQmN4QjJnMWJJTHArV0piRGxDbktk?=
 =?utf-8?B?d0xjMW1NZm5aODVlZWxxOTFUaXhGL1V2aUlYbk9vTUUwaTMwaEpXNjNDb2Uv?=
 =?utf-8?B?S2cvLzBiV3BUTlcvQW9Mc3hKZVVNWUR3ODZiTUxwZVdLN0pYcGNFL2NHODk3?=
 =?utf-8?B?OENiMUNFS0VYM0FuZiswQ3ZIWWlYc3FhNE9RemQra2lpUkhzbkl0U1FHdEE2?=
 =?utf-8?B?TlB4L1JmaHJVcnlLc2ExRnJBL2VFeXU2L2VJbmx2aW00WDFTNkRzOUs3Z1dP?=
 =?utf-8?B?R2FkQ2VQNWhGQ0Q0d1F6SnRtQXhLZDFGMHJmODNabjhWMlp0bGFwM1RPd25j?=
 =?utf-8?B?TjZoeWlEWGp4aDY1OXhNdE9lMlFmdzFIcDNrZXhkR0JEb2pxQjEyMldFZEtF?=
 =?utf-8?B?ekNNbWVERWpyZUZ4bEhOTWVYMXNTTWV0V2NrcS92SnVueXkxc1gySHFneFFt?=
 =?utf-8?B?V1AyQlNHQzB0aGN0ckZoNzdXam9maENtUFRtZHhCVWVjUERkQU5Ob2NIU1R5?=
 =?utf-8?B?RmttWkdrbHAzMFVZZmMycEw0TXdGNVJ2dVFybVZEYWdIeVdGSVZndExwMFkv?=
 =?utf-8?B?ZjZXdFJ6MmM4c2NzZnBvL0JLM25WZTVmN2RqWWI3NkxPdTZUQlgxdElXRlp2?=
 =?utf-8?B?NE5NQk9uTkl6MnllRHdZM2RCSVpPMnQvSjcvWUIzMUdXWCt6YnNYYXc4clo3?=
 =?utf-8?B?cTBJWkd5Uk1UQlVTa3liLzFseU5La1U1Mkd0YUVNWDVlcFNmaHZodkQ1ZmtO?=
 =?utf-8?B?V2wvSkFUcTl4VHVINCtJLzJSOERtVUhvSnMxOXVrMXMwYTd1SnNNL2h5UmtG?=
 =?utf-8?B?QXNYei9JM0RhNzZ2V1FWanpGVnBBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a617453-00f6-43e3-6783-08dd451ecd45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:21:15.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzV2jADxhvTDPQ0XakQP57C38qbEvHMqn1ovQeUd0vGjd54MEc+u9s79+mCWeLe9p+FqwDPPgj19oD/JSGW1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 13:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17747

On 03.02.25 12:53, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/ltp/files/debian/{rules => rules.tmpl} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/files/debian/{rules => rules.tmpl} (80%)
> 
> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules.tmpl
> similarity index 80%
> rename from recipes-core/ltp/files/debian/rules
> rename to recipes-core/ltp/files/debian/rules.tmpl
> index 06b9070..918b443 100755
> --- a/recipes-core/ltp/files/debian/rules
> +++ b/recipes-core/ltp/files/debian/rules.tmpl
> @@ -1,7 +1,7 @@
>  #!/usr/bin/make -f
>  export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
>  
> -LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
> +LTP_CONFIGURE_FLAGS = --prefix=${LTP_INSTALL_PATH}
>  

Missing default value for LTP_INSTALL_PATH - comes with patch 3. The
whole series is in inverse order, in fact.

But making this a build-time configuration will mean that there might be
two binary packages called "ltp-full" that are actually not the same
anymore. Can't we select a path that is writable for all our images? Or,
even better, can't we fix ltp to separate installation from workdir?
BTW, does it matter where this workdir is located, on persistent storage
or on tmpfs?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

