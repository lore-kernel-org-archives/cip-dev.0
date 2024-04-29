Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B2C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 12:15:08 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.83])
 by mx.groups.io with SMTP id smtpd.web10.19270.1714392906304904401
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 05:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qgQQby9R;
 spf=pass (domain: siemens.com, ip: 40.107.105.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndxuCYe9ggQzrlu90scHNkYRQmWGe4tqLiJgHLqOO+d+p7sJFeqYXQ6i1f8eRHjL+Ww2O4vP219r7mNi3kyQ6QiOyAhltsKxDOcBgMKGVHmTQ6K0zjIEsAP26O9POGqD3hCIVAxqemwaVEQr81rHT2lJvc5+q5KGQqLfNBiInS3RgI4YKSxwxGiAJj5cJUxYqLCZ1xtotc9KvjgwOqM700t4iptOUkjfD7FpuGG+CJfLQi+96AaohZO3H99mZ0hM2ZDyI3WHsHerrfv4HIC3qkB58OLsDMf1lt6hqYzkLLBHLXS/+PSzSXoENIl6ZN+wxt562eAH2YV3gCxcPsv2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddCjMnjPt64h9Zr8Ct7lr2cUNuvZZoD5l82PBjf66zg=;
 b=diIw/UKfu8ltcPlFeX99rYR9FSzKlOaB7IzIK2sjZc9JnrY24eSEilrlocF4hrtlfXgH2ncgsy3rYcXlG6T7OSQ8V3c5vHm+dbjIWcWg4qpcXmhgMpYCvgFw4+bheJIroatHUbw7J+xjVVZ9+dew87YBmRxne1FzriPDb+AGT1gvEOtyQRye9xEHwPb35SNgALFyhblgDLupcfVpvO8urFYTv4fXLQe1RBonDcRwQ4wFgdoMRnc2WJst5BtnCSjtJ02uCMXM3b2ojLIdfofrzV6JbZx9dG1oG6DQj8pDQkykxvHW/Y+NeezUyfx/1DiuEj1ywyxRH+/E6bOT8SVn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddCjMnjPt64h9Zr8Ct7lr2cUNuvZZoD5l82PBjf66zg=;
 b=qgQQby9R6oYNZeUS3RyLiIb4MDgz5YMLEZ/r03ejhExb6EJawZaRUEd89iVYKyFId//JeTuexjmxXHKR6yrbJ+eWygE0kITJVHcdYIg5t+fBMDWNb3v//Hbe9mQgJu1ZS0/AWg33iKvGKM/DGQ07ZD7Gh1kLhwKt8XXLK+qyTrYQf9Aih6TulxJeG3wwRQZir+Wzeb26sSYzB9a03rmq3tZXrcThf9mtTmLEGYyRvn/1xUV030OdyPvuhbIqtQjD8TUI+XOMJCOe+gV1DmTYQ2JqROWHjbYdh2QDgQ5AKi+s5wKM9owXhjxj1veREx1BRycJouhL4Rj2j6Asbkvgdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:15:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:15:03 +0000
Message-ID: <cd182e2e-0e07-46b8-98ba-5652e075741b@siemens.com>
Date: Mon, 29 Apr 2024 14:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 1/3] Add Delta update support with
 rdiff_image and delta handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240425094444.404036-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: bdba4d2d-0098-4149-92f3-08dc6845ff98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHRFSk1TUThLWWFOOW9nOGFGZTV4T3J3VU80bVVFb0xqSUh4dmU3cjF3SGtG?=
 =?utf-8?B?c2NDM3ZnSkxoNHhpN2lBWWdGYVNVSUw0VFJUVWhnbDdGKzArQXZzY0JqdFpm?=
 =?utf-8?B?b2gwQXU3dTlDWll4LzJYYWtsRGd0YlpIVk5NSU1GM1dSL3hlV0hlRStLeFBy?=
 =?utf-8?B?WkZRZ3V3SVFxY3hlYjM0SlZzSzh2ZllxK3p1N1I0SjBZbG9tOTNCTE02LzJO?=
 =?utf-8?B?Tk10SDU0aWtPb3h6SXFHSzQwbng1RTNZTDR3NmVUYStmRzJlZ3REczRGU05t?=
 =?utf-8?B?dkxUWWtUV2xMbUdRYTAwSWZJZ1JPdTlVQjNWME85RHNUNGdiSlNnOEtTYXh1?=
 =?utf-8?B?NkF3KzJFc3ptN0dRcHUvR2hUcG1xd1lyYVZ0dFlWT1JJWlhNT3VZN0NRSURM?=
 =?utf-8?B?cGFQZkM4ejRENzB5TTUwaFQySjM5WW4rRmJ6eUhEOE54d21OU21RcWxRVmxa?=
 =?utf-8?B?Vy84QVVXb0NSbkZxUEQyVk1WOXlsVisxOTcrc21SOHdMUnZERnozQ1d6OUtu?=
 =?utf-8?B?bUxVeFpuNUcxblVDaHoyMnpyaEMwb3c3NmJNVDR3UncxL1FnYVREenl5WWdk?=
 =?utf-8?B?b2VHTlZuam52WUZ2V2xMTjVVSnpUSTNoVDZsOXZGV1huRjR3VFoxV1JCcGpX?=
 =?utf-8?B?eWdpNmk3bFZOT2NaZmxEMGFMRkVuVVgvMlVreDc5eE4xcXFNaVlFWkFUTy9E?=
 =?utf-8?B?UUJmd3RRc3VZandSOVN3dG9uN2Urc0RVT0V1bkpRcXA1cTRIakNaQjd1SWV3?=
 =?utf-8?B?LzZrL0c1a0QrckN0WGFnKzE1NGNJQjdMY3lwWTZVZjgvLzA0UDhqdGlWNldy?=
 =?utf-8?B?M2lHa0Z2VUlJTTE0L01ZcFpiNHVJUzNmWXA4aW45M0lBYVB2b3R0bHg2Rm43?=
 =?utf-8?B?QXFLZ216NWw1SitKK2FKbTVDWnpWV3YzQjZoekpYWSt4ZHlXZmZZN09JUkpC?=
 =?utf-8?B?YlNIUDl2VXdDZEZPUmNzQlh5aUdkWDlOTkxZVUYxQ1dtcVpsWGE4cnh6ZlVN?=
 =?utf-8?B?bWczYkJmTVRSNGt0Y2QwTnc5NzkrWlBsVUwwRFpMS2phQllpT1VOOFhxZzJM?=
 =?utf-8?B?c3R1M05Mejh5d25vUGJBWTNjTHpmWlhJODdkaHZDbyt6TkFJMzl4dkNJR0lJ?=
 =?utf-8?B?ekJhSHlxZEMwdG5ucFpDbHhUVTBWL1pRMlh4SmhMZHJhZi8reHlmQjQ4Zk40?=
 =?utf-8?B?S3ZOTDlrSEZvWnllak5qRzlOWVMybDNxeHozajZOQXlEd3g3N2VxK0lRRnJN?=
 =?utf-8?B?QlRDVkM0M3VsN1ZCTWJiU1JqV2hPV0ljUmdSaUxER3hRbUo5bFpNRk9hQUtI?=
 =?utf-8?B?WUN4UlFaaVJ4S3hGODBFaUlWajd0QXlQZ0ZHdk1ON0NoSkFpbUY2ZHZ0M0do?=
 =?utf-8?B?VG5JRmtWNmxVK1MyRHhYaUIzcDdtM2NBSng5TlhLVGVQQUYyN0ZSYnA0YlVO?=
 =?utf-8?B?dzN1VFBLbWxob3Fqamw5QXdOYWVtVVkvS3pEZm5NYXR1ZktFS0hPVFR2U2Vk?=
 =?utf-8?B?QXNlMStTY1BmTW9CNHdvMzdvM2ViMVZodHZLeUNsT1dlMlUxZlh0SEFqMEdw?=
 =?utf-8?B?aGtFdFQ3V1NSdnh3OFV5Y2hEbDdLVTRtVFhxRFdoZXJrTXl5N09iNzg4WFBm?=
 =?utf-8?B?Yk9UbzR5VjBsVlRmb1ZBL04wbENldFpRVE50TVM2cUoyeGlYVHRCVUlIWXNj?=
 =?utf-8?B?UkRWR29HZVFYTERZNEZTRnNFVmRZMlRYY3NVTjV1WHVwTi9iSE0xMnVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NG9qcVlmTjZUejZPYlpFZ0hNQVpIUzRqbFlJaDlEeEFPdGRGd1pPOFdrNE8z?=
 =?utf-8?B?ZTZKb3pOQTNsT0swUUR0RHhEYTA3amc1VVVCbEV3clBtZ0ZjRFZpYVo1YUNn?=
 =?utf-8?B?ZW5UbmswRDZON0NhVlNoMmZFaHhGM3BCTUFCaUV0cmFacm1TL3ptSlFvb2Fn?=
 =?utf-8?B?RUIvTHplKzBKZjJQaXg1c1B5ZHBNM2g5WWQ0NklqQ1FvSGV1Vms1NmhZRi84?=
 =?utf-8?B?NjI1c2RLTWlVVUwwaUVLWXBicmk0Ykkwc1FBK1lwSEkvSHE3RXNaYWhtOElz?=
 =?utf-8?B?eFZrb0h0V0ZLNzZzODBsYmIwSFcwUHR6czkwTFBEc0s2M3E4azhTS0dzejcy?=
 =?utf-8?B?ZWt6ZFA5MmNzU3FMdVRvUFB3eFg1WHdDd1lTRXdmWURuYXFNSDVWeHg2b2Rj?=
 =?utf-8?B?SjhDYjZaaGJLU1JBWnVmSFRIODA1cTNnWGd1c3lkZ0MxU1ZWVGRsWlpiY21Y?=
 =?utf-8?B?UzFLTnI0L0htSmxRcTliTll6UE1RSXVrNWUzTjFWWGhib3p1M3JmMFpldDE4?=
 =?utf-8?B?L0FQaWxZMWtlSGFYcGRrQXFyK0Z2T091eTE1Sk9zcW84TkxQcVJyRnFTeUlu?=
 =?utf-8?B?YlloeG9LOGE4YStuT0xqb1NrMjNqRVJMSnJUYzdtT3ZVUDRTbVk5aVhwVUVR?=
 =?utf-8?B?L3FMemJKNjlWRTZEYlJraGhFTTJLZ0FCU3lXR3R1d09IRkd0eEFkaGFoc2Zj?=
 =?utf-8?B?bDRLSUQvZzllTTRpcHVCY2taTlNRdTRHWWxMOE53Y05QUVg0WS9xbkxQZ0ND?=
 =?utf-8?B?Tm1wYmYrVFA1RGJCbWVMS20zY0pGTHFrb1EwUi9YcitiRFllUC9yNEZzcDl6?=
 =?utf-8?B?QkJxU2JINTd0cUw1U2NQQ3BjTzhBQTZYRUg3UkQ5RUhVM0VtZU51amN4dnk1?=
 =?utf-8?B?QjRsSFgveW1WODA5bFh3eGJVVnFKK3dHQlZwbWNYa3dNbDBpMU9PRnNpYlJv?=
 =?utf-8?B?WG5oa3hQYzZQNm5xVmh6RDlTY0xqajN3Q2M3dkQvNnhpWEppckJNbEQ5UnZw?=
 =?utf-8?B?WUdmZHJuOWcrTnB6TWFGUlBMSnd0bTV3VnhMNFZySUhHdW5zR1ZQVnY0Vjll?=
 =?utf-8?B?NHY1RDJnM0RXc2J0Tmw1a2lQNWpUajFUTTZERm1odWZtYm1wTUFyeWZsSHVq?=
 =?utf-8?B?TU9ibUh5Y2RUcndZZWxxUm40L3V6emJBeEVEVnE4U1cxaWUxVGV2V1FoSEoy?=
 =?utf-8?B?V0lGRUJsSVVSSFRJRGsyNnYyT3ErOW40Q0RBVStkUkhIMXp0MWtlYjJUUEtq?=
 =?utf-8?B?Y09KaGNlem42YXoxNEVjRjVMdk1YbmV4b0w1YmU0MEJJOVpzTm9hN21IL2t6?=
 =?utf-8?B?aGU4ZVJLWHVsSVlPN01RYkI4U0hVNWZEQ0lJQUtQa2ozRzFDdEYyanlza2dr?=
 =?utf-8?B?ZTlNbHN2NDdxZWVYRDZsUkpIYUxzcUFVWC8yNm9nenplYzB2bWg0YldQNEhv?=
 =?utf-8?B?SXJ3elRmTXN2aHpDVFJGZWFSSGJBakVqVGlpUWJUOXluLzBvN1kxbUl6d1dU?=
 =?utf-8?B?dnN6eFdnNkN5dU9GdXZUdW0rQWxLL0VJZE5VSVJIblFFeDJlcnN3aVpCSFc0?=
 =?utf-8?B?YVB3RHl1N0xUUUJ6d0ZuUEVwRTUwVlVLaEJuOEVsM1BvQnE3WEhMcjd3azVp?=
 =?utf-8?B?bysxQWFNa29aMVQwLzVJY3VJcGF0ZjBwNjM2NVExSnBIem0yZXRuWHhZeUx1?=
 =?utf-8?B?bkpaRTJRaU1xbng5emFjazdRdDlqcmdwUXNQT3gyT1dBQ0NaeTlqQW9aZFdX?=
 =?utf-8?B?OU9Ha3duYUlSOEpmaytDajY1UFIzbGdqa3IxK0ZKN3Nwa3JkNm0xMmdTbWVn?=
 =?utf-8?B?ZXFDU2ZoZXFhSDRZRDJuZWFPZVBCVk5rQXdILzZjc1BvL1N0WHQzdXBuK09O?=
 =?utf-8?B?Nm5velJVbUp6ZW9USnZuNy9VWEsxaFIrb2VxZWFyN2hTc0xTdWk3ZUVqbDFz?=
 =?utf-8?B?Sy92RU1rYU92NUlzMWtmWlZnWGxPbCtoaWJUS0RWZzZaNTVwaFRsWlpCckNN?=
 =?utf-8?B?TGs3MEdzMkVCYnh3SWlIQ1Z3aUNVbmgxWmVFL2lrUWl2VjBhNlpzZFVBUGh5?=
 =?utf-8?B?SHcrSWo4Wjk1Q290bXZ2VnZQU0RoSFFNaU5acWdoMGZtbEpodW1tbnBuaFE3?=
 =?utf-8?B?QWNRT0JwZFVYbjhTTWZDQytkdFZINmh0VXFHMk15dElEQXR4end5L3F3cFBs?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdba4d2d-0098-4149-92f3-08dc6845ff98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:15:03.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WB8KvSJb+KKNL461maeJDo1f+mm9rOOeUAu7HdBktENx7KP+kzPCfcMB9mbBNXDVfQIkgCtM0Fye9T/N+Jrj1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 12:15:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15776

On 25.04.24 11:44, Adithya Balakumar wrote:
> swupdate supports delta updates with rdiff_image and delta(zchunk)
> handler. This change adds support to use either of the handler
> for creating delta update artifacts. zchunk based updates are supported
> only for sid.
> 
> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
> be modified based on the update type in the swupdate.yml file.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  classes/delta-update.bbclass | 97 ++++++++++++++++++++++++++++++++++++
>  conf/layer.conf              |  2 +-
>  kas/opt/swupdate.yml         |  5 ++
>  3 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 classes/delta-update.bbclass
> 
> diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
> new file mode 100644
> index 0000000..56d2231
> --- /dev/null
> +++ b/classes/delta-update.bbclass
> @@ -0,0 +1,97 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2024
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGER_INSTALL:delta_update .= " zchunk rdiff"
> +
> +FILESEXTRAPATHS:prepend = "${TOPDIR}/previous-image:"
> +
> +DELTA_UPDATE_TYPE ??= ""
> +DELTA_RDIFF_REF_IMAGE ??= ""
> +DELTA_ZCK_URL ??= ""
> +DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
> +
> +def disable_delta_update_tasks (d):
> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
> +    d.setVar("DELTA_UPDATE_TYPE", "")
> +
> +def delta_update_prereq_check (d):
> +    import os
> +    import bb
> +    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> +        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
> +        if not os.path.isfile(path):
> +            disable_delta_update_tasks(d)
> +            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
> +        else:
> +            return "file://" + d.getVar("DELTA_RDIFF_REF_IMAGE")
> +    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
> +        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
> +            disable_delta_update_tasks(d)
> +            bb.fatal("Zchunk based delta update is only supported from sid")
> +    else:
> +        disable_delta_update_tasks(d)
> +    return ""
> +
> +SRC_URI += "${@delta_update_prereq_check(d)}"
> +
> +create_rdiff_delta_artifact() {
> +
> +    rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
> +    # create signature file with rdiff
> +    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
> +        ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
> +
> +    # create delta file with the signature file
> +    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +create_zchunk_delta_artifact() {
> +    # Create .zck file
> +    ${SUDO_CHROOT} /bin/zck \
> +        --output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
> +        -u --chunk-hash-type sha256 \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}
> +
> +    # Calculate size of zck header
> +    HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
> +
> +    # Extract the zck header
> +    ${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
> +do_image_delta_update[depends] += "${PN}:do_transform_template"
> +IMAGE_CMD:delta_update() {
> +    case "${DELTA_UPDATE_TYPE}" in
> +    "rdiff")
> +        create_rdiff_delta_artifact
> +        ;;
> +    "zchunk")
> +        create_zchunk_delta_artifact
> +        ;;
> +    *)
> +        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
> +        ;;
> +    esac
> +}
> +
> +addtask do_image_delta_update before do_image_swu after do_image_wic
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 6198e1b..c652a61 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -23,5 +23,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
>  LAYERDIR_cip-core = "${LAYERDIR}"
>  LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>  
> -IMAGE_CLASSES += "squashfs verity swupdate"
> +IMAGE_CLASSES += "squashfs verity swupdate delta-update"
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index ef61e4e..7907acb 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -30,3 +30,8 @@ local_conf_header:
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
>      PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
>      PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
> +    # delta update specific variables"
> +    IMAGE_FSTYPES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = ""
> +    DELTA_RDIFF_REF_IMAGE = ""
> +    DELTA_ZCK_URL = ""

At least the 3 empty defaults look redundant to their initialization in
delta-update.bbclass. Can we drop them?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


