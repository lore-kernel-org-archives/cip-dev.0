Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F33C64ED6
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 07:09:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web11.84899.1677481783902893209
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Feb 2023 23:09:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vx6U3ZCf;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1qj/wtwFBkrgVdHXXeCHElcT//4mBxsrxhOU6Z0R9MkxcUoU6vB+ZRkynzV6CNsSn1tQr/0S4hWCueBtdkael9lmXC6YWgq73HVoOBkJkDzn9hCnhAHf3pGu9d5ZSJReUQ7M2Mm0XbvUbHubIJzKYpuqsFjjzQg02H9oXeeEicHXe0o4Mz9ToLUynXwKMiyeGIqIIZ4x5YxTMcFZG7LXQOJGFhTFXVTyJBtqXoEWeIe1jJulk5h5revpkCNyLTDGEkZm1Gj7tT1tgnZ1l12LL4991I8M1GZkVrcXeJ/9VjwxWFu3XUIcNAOgNnpCG02zo9hlAMAHCXUGnf/YPkKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHfxkecJ77R1KdUMvFf/HBKWjCpCUAy1aVlMxwE7Vj4=;
 b=KKdP3PBZmgTJfWt5zhe1HLXkaXCywEwvZ1KqJiZom0v2Etnx1F8kTVJXp9KhTCB9BD5sG67O100VWO5rPqnrGLj3aE8mCgB+r+opbW97VKg8pHjDts+m6HRUhGyqLEY8m2gPAlyTxmLfqGWEUitjoLAY6f/bFZ7VufA5d2U/NUwvUWb2Bstpo7awY/Ki4Ih1jBLSa+ICFacATyHdscmwqOn3n+6qyt3bH3Yei2s60s1wF/iSCgK5DQdreLWBDFFqRgRcQq/D7cDZnVagWM3ABtNzFgSAm9zmS9bHSFQLmZ6I8EovgAq0zBvrahxiflrXp7WmbqnvkhSk8y9QCQZB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHfxkecJ77R1KdUMvFf/HBKWjCpCUAy1aVlMxwE7Vj4=;
 b=Vx6U3ZCfpxEJcIIRXDlqeUMIsFr+8RKgzfZiKd4A6vlpkxk2xSat1KdkauoQDzswgE8c0p3bIEo9qbgqi7pgZZb/0IJpGU6m9G51CM6ic4vSAsA2suXOu4/uQWNlZ0B/rLtaFNKpUpGivJT65xh92tQcWv0WFc80xZHXJ3c2tWAwK/SR6VV/8WhEGMTnDXUAApQD7CZSDSF34MuKyhEZFFU3enZ6hPwhElwPV0QXP31Nu9WFaPxayCa46/ijktL0PHX7Hs+ZN26xYr5jC7FvYy3a3hfOGxsLvYZ4Bx+Oz/3hlnRCNSNIG2lshaqLqmOHsJVTNYx32UrfHHbTpRmzMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:09:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:09:40 +0000
Message-ID: <9b874eb8-3fc5-e0ed-c3b7-8c16ff51096b@siemens.com>
Date: Mon, 27 Feb 2023 08:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 3/8] KConfig: add tpm option
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd1e8df-6dfd-44dd-7d2f-08db1891981d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dEEV0GaRTgZQGmLHbdn4eDYQivA06B4LAjUSUbNfYJHHD2NWRAG0QcIQuDAcVdMI3+NY0Qg0oaL0zKw/QReeh+i7fUJWnIpqVs99hd3zC4tMrx+ZBDNRBYQfLrs1BLUaeHoiLBUfsEP1OhHahbrWVtqo/b6puKO8O/Q5tHzXGnJpX8/Tn2gZN5LNT5GWPrT6kr6TS0L7qGm+tRaf+Qtr5NFNoeZeEMU8jkNlZ9MzCls+myZkNnPp4jdyrMIgtDqcyvQ9pXT6ZAVRP73OOSatEtwWSSWWoc8zb3fABuBVGNgLQMUL1ppYkRhMObuKPEZ+CYSzLU+EKXY80sVHPLbMoy3F3DzV1OESNVZy0xPsUwbbLbJnRGbEjIDwycuxK9z4ekuZZK04h29QP8aNp9wgKauZOSxtEnGH/Nu6/EjmIQ8QKvWVNmGsQxNRHGuC8uNfVyDOiy9LF8CF8N56yxwJRSAyYg36TD1VxK4PSp1weHsWh5cEvqdI4S+RIwwIbk+3VUVuSppKPfILIZs0CyDn6Zn3sES40u6PEIdMH3Cvkip/kwJZvHMlmChHlJPM+bGA2YMg1DSDOfgIkqkLP5oOdY4WbeIDGYqnWHopxkS87jzHr3WRlRTAIDgSyo1f+KoMBPKTpFx9QtEBrEF0n7CaqKGYSZ4JBevyYPZ+UUcfmnyV0MB+jGjsQdQn0ZbZsXvExf1wxZHF4z40g6Kl43gMiSusXOh2BwxmZGpEfMMDGUA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199018)(5660300002)(4744005)(44832011)(36756003)(86362001)(8936002)(31696002)(478600001)(83380400001)(2616005)(6486002)(26005)(186003)(53546011)(6512007)(6506007)(66946007)(38100700002)(66556008)(41300700001)(8676002)(66476007)(6636002)(82960400001)(316002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vk1EMGtlOEZldk1tUnllSVlGYjRIcEE2ZnlJczkxQWRCbHBSeTRsSnlWWjFO?=
 =?utf-8?B?cW1MTkM1SzNUcyt2QzQwSGVIV213amtxV2ZKUUdQWXUyN29rWnVDeGprT0tw?=
 =?utf-8?B?d0YwZWpaVVVOdWNXd0NidFhYWCtqM3QrUWdEanlFQnZRWm00dFVFUndJSVBK?=
 =?utf-8?B?dWxIZkh1TFo1T3Jib2I3M3Y2dTJ3Wkk2T2Vndk9NVUliWStmT2EvRWZaSW5G?=
 =?utf-8?B?dlpxWnlaQ2IwQlNVVUpXc0ROQXVqM1U0MCtWS1FMQnFQWk9sTkhrckVnYzhM?=
 =?utf-8?B?N21uYnNIeTJlT1hZWWcwYkEraVhMejE5czZpeXNsRDNZZndQMWxMempISGVq?=
 =?utf-8?B?cG9hRkxwZ1hTVWkzU0NPQmx6UEJjb1NET3BLNzEzN3dRNnRQWWVqSWRldjI2?=
 =?utf-8?B?Y2RuVjhtdkhtdXFnQ1VEWGdyMDFsaG1tNGppL0xkNXlLdGgySDNkYVJYTnFB?=
 =?utf-8?B?cTdMY25wVE04UFZnbmhUMDBnempVeVgwQXF1c1drOG4zSlJUZmtuQ3ZqMlJ1?=
 =?utf-8?B?anFTNEF5S0VVcVZuR2FzZW5Yc1R6a1UyM3BRRmMrSEtBOEttRnRseGo3VFhH?=
 =?utf-8?B?VzNJdUMydzJqQ0xmY0NYcUU5Z0o2YXF3U09acHJrVW9lOXBucEM0RE5ibXVZ?=
 =?utf-8?B?M3U1ZWp4Q2UyaVF1UkV3ek9BTzh5THhIRzhSWjlON0paQW45Y1orRXdhaURj?=
 =?utf-8?B?bXRZWkQ4ekN5YkNKd1k5SUZCUG9SLzc0UXBNZ2tYaXh5VzZuQk1EdTBHWVJ5?=
 =?utf-8?B?MlBKcGZKemtUUVBFbUNBQzlGZUNYem5HcStvQUh2MDVUUit2Tlc3ajZaWlEr?=
 =?utf-8?B?OHZ4TE00WmxvZGYyeDhBZzNwSmVyMW50UTI0WVFabXlDdzB4Z3ZYMEhxcEhV?=
 =?utf-8?B?TjhoZlg4dm5mTmhCQWttdEcwSURHQUlBR0puNUVvd0xIWThjSXQzaDlvaVRk?=
 =?utf-8?B?VzJwcjdwSnZmZ2RFZGlRS3RoeC96dWo3ZGdWZ0tDMmFWbzJFc0ZNM2FCekhj?=
 =?utf-8?B?WHRtL0EvR0w3dW5iT0d6N1g0dDhLVnRqRC82d3JZcnBtYmJTdE0yYmVyNzIx?=
 =?utf-8?B?Z2lPRnZZWVQwQmNReDNkVSthWXlFdVdJVzdRV3pWZER6NDlhQm1XbDBQcVB1?=
 =?utf-8?B?ck51bjJ6cENpOE1PMnM4ZWQrT1R6UU1GOExHMS9WZlJYVHNCOEFNeU5uSTNT?=
 =?utf-8?B?UW9aQUVrQ0FCRmp6QTVLK2c4SG82SkNrTWY0Qi9Ec1d0UkswaDU0SnpCeWtN?=
 =?utf-8?B?REh2RFRkZU5hY3BKbzcxNG5XanhBSWFZdlVmN1oxTm5CSlhTNXFPZk1GZUti?=
 =?utf-8?B?RDZXRG1PbXl3bjBkeDVjOGJnSXluc1U5RzkwWWc0KzUxaHlrY1hvaEFKYXBK?=
 =?utf-8?B?R1VUOU1CaVM5WFo5RmdGOCtGMlNpQytweDEvTzE0REpBSWNjZkp6TFF3R3Jw?=
 =?utf-8?B?NWNDMnJTY1NhaVhwZ3BGMEpvbVNoUkJmb3U5UXdNUytQcnFJUFNHbmhpMDl0?=
 =?utf-8?B?TzJHTjJ6Q1BscEZqM1hScWgrdGJTTmxEWlJhMDR0eGtYT0UvSXora3JHRHF2?=
 =?utf-8?B?QWlIalFsM3NvdWRYbEx2bVhxZnN3R1BxZ3puWVB5cFRzdE53aFVUNGJuREhx?=
 =?utf-8?B?SVhUbVkrMlJMbnM2N2RMNlp1b0FzOXN6cE9vaFZCMjFYRE9sWDNDbTNRdkRy?=
 =?utf-8?B?dHdSUHA4aE9VU1VZZHllNGxlOW5rWkRQemJzenpJVnlwOFpjdG03TG9WNW02?=
 =?utf-8?B?cTRSV1hRcE10THpwcUc4dGlZSXg1T28wMlNMSzNyTlhMbnMwOXpRYXZ0ZFdl?=
 =?utf-8?B?eVVFL0VZOE1qUTFNWElVTnl4c2E1ZkpWTGVFNW82a01yeGlLVGxVUWhncFQr?=
 =?utf-8?B?dmxmZUV2RTNZMDQ0N3NhR3h6aWFNRHdGKzlJbWlOeGZlYzJ1bjZHWXNncEZG?=
 =?utf-8?B?VkpCSmJhTEllSm1yUkY0eHpWR2RRYWFvcFIrKzZYZU42QzdWanU0ajBBOE5D?=
 =?utf-8?B?SEFabVVlaGdkY21yZmI3d1o4N2Y1UEx0ZDlPdVFVVDFHQ005cS9CZ3V5UGZC?=
 =?utf-8?B?REVIY0VrbndycDBYRFFNMlArNHkrRnN4RkY0ZzJMTUcvdW1qZkNpeGZpcVJt?=
 =?utf-8?B?b3F2YnFERDBNQ0treitWQWc5RmJKQ1B5b0xiTkJvTGVvVUViSXZjSVhldkdU?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1e8df-6dfd-44dd-7d2f-08db1891981d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:09:40.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLdnb1/Is3felNa+6j+8CirRjpi3U9foxuwVpeabAkKiwaKNVQLhhI9uwc9wspfoMjYH5TlLn+W9Y76pABiz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 07:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10858

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index cd24ce2..b8fa16a 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -189,4 +189,12 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>  	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  
> +config IMAGE_TPM2_ENCRYPTION
> +	bool "Encrypt partitions on first boot with TPM2"
> +	depends on TARGET_QEMU_AMD64

Here would be one good place for the "demo-only" warning. A help section
could elaborate. And/or the README.

Jan

> +
> +config KAS_INCLUDE_TPM2_ENCRYPTION
> +	string
> +	default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
> +
>  endif

-- 
Siemens AG, Technology
Competence Center Embedded Linux


