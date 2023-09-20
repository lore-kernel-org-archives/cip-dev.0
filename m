Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD9CE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:40:50 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web10.30509.1695188446167292910
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zAGxzFJk;
 spf=pass (domain: siemens.com, ip: 40.107.8.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COPCmSuMCf0KCXqR7yI7YMtErqCoklIx26Ma2T5DNdsnQgsufdlG+JRdE6BL0nMrKFV38b9NtLou0A5gR0CxuoCqnbmT+6tx34d2J7HoC0m64KDJW3C45PBVClJRaSZ/rbWHk10vkr1HJngzOCqpauJVF8DYQ53IrlJUIn0/XvOc6SfdQzNY8jS+3SbxjXunZM0oiZz4aDs9oynnI+OsFF1+iq5O7cbGgpCjYkioulEOtS1m9TiNRYey3KfBXmfKCxAl/MmVovRdFpRsKSjfsevE9kwqxdYthLP9HA9C8eDsGVoCjqpBWbvLqPyVnpVoGv0cCynWd/9931Vx5+ZC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbVPOD0lE8zAKB5DjBE4xqrnvYvXV3tzJlw+vWwsgB0=;
 b=Pc2Zuvpo5cvxjsO9Fzh+x5qMCYDSkiaigjDk5VlVTcnYNSuBCgUZRxANBOqcU0Fj9FjdY+Gqd4GhfQSVazulAew7lW6PircFVbsPT8vO1mFffPh8S4smxQNn6BGYWSGPOFMRgOs5VeBZ+tAQJRd6BWflEv8AFKKgYbTgQuPJT0bj7r58aHZjXuKUwrq0r96WD7kx6Hm4aqsWhKp49jMfpVHzNIalDh/M+pMcFMTD957CMHvD2lNbxroGNmm1BSgFl75LLjfdhzbAmGa398eWqy2ErNdYARmTLXXui+uViDP12ImKQK7m78tNrI4qwjl7CklPhQA+7O8QrGrAnWYF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbVPOD0lE8zAKB5DjBE4xqrnvYvXV3tzJlw+vWwsgB0=;
 b=zAGxzFJkcbKyTLYXbjaRi+jxEA1nyI6Hpz9s5HBrdGlwxo6DtUx8YnS7xXyrhFthK27ORa5Ok1SWeGLyMby13YBLjv4pAZkQmpfaCpYIx4J2hmcZooOX05w5mS+tlDBufEUbYKYZPA6YTxk0zzd9PSi2UaBqEUqYdD7bo6zv4Wo2nxhTn73rJ1Qjk7AJ9SE6pSjc5mZANUldxTb+NTo3tkwRDzntZ8yEC/TfhWo4iOGhkyzWLDSZWZ7yT8g3OqDuFZJ4JASZ5hJdgG44WWA4NLTYMmBstSkLiODuwTKg+Q6xURNZ52YErEVns73A2cTmGiIGMVoCAIQ2nkiD6x2VhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 05:40:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 05:40:42 +0000
Message-ID: <f277b372-1183-4f91-8279-32d52480ebb5@siemens.com>
Date: Wed, 20 Sep 2023 07:40:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] cip-kernel-config.inc: Bump the
 cip-kernel-config revision
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230919122603.68059-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230919122603.68059-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e5a909-e3fd-48a8-3b13-08dbb99c2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1cjuVryGK05trcWLkNuH/1G8zNrD9aUSSXcXjfqbzmsuD//rU8PG0KMimM9gMbJ3dipwEvqhPzwEn7EtL38MNM//yuro2ZhPli2D7rQ+evPyYbhj18WaO2YwKml7EqZhgzXwJXR7m2vDlz75et0IhpcJGSfHnkabeT/U1ER/7Lb+KHFIhS4ZNIaz2M0D4B31+PqhixggcPlF3OJLE5dOj7vSiDSMgQaqQPT2urNvAVLeXVBMyDHX95JwR9KrPS97bXfoyTyoJR2jIWQEpnk4tkLn7GRbduWbzGQp7MAnd7ClECNjtl6L+fUogCEhLdDrkVQ33pDa9FggRdf0LMwiWpEM5y7QrPTNlHyme7KeJ7UDlmmLv08T6kSssFQXSZJsljD08HnDSZM5662OxXVp7XyJHLsLYu1kyGeTYc9yXruoUAYsxFJ2CUFbFX9ampRQRSN1zDg3iiUgpFHFzUqclSA5Afw3ElIJiGZvZmXKiq9ncr17Sjcu+zLbFHZRjJodqj+NZ+Cq5/Mad+KDb0cU05fG6ZSZvqs2c0abFyEqtINNYB+cqnUi1tEYPY7IDTDfK0mxuxd1iIELcWRWxAWXiuTsqq4xuTj/p7XcWAfGTYM3QpZsfYwxrMTpxMrMbCTRmUMf9/nh4oTSlMkP/LJGJw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199024)(1800799009)(186009)(6486002)(53546011)(966005)(44832011)(6506007)(86362001)(6512007)(66946007)(38100700002)(66556008)(41300700001)(66476007)(316002)(5660300002)(6666004)(31686004)(478600001)(2616005)(82960400001)(8936002)(26005)(2906002)(31696002)(36756003)(8676002)(107886003)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXhjenMzRkduNHozUkdxRkhtTzJtN0FmZ0tUOWNxTnplbkxpQmpLTUFKYnht?=
 =?utf-8?B?VkZFQnNoRjlvdnJwMittTS9zZE55c2plUzJydGdDcUJsNy9nMzRiNmx3NWpV?=
 =?utf-8?B?M1lzTFk1cmtySmxRd0s2enprRElBTzNoVmJ0RFFlS3NGS0RsRFJpNTZldmZh?=
 =?utf-8?B?S240WFYxY3Q4OTlCMUpjakdnVldFWGlTeVFwTWxGOFRzTDhTZU9SUy91dUZt?=
 =?utf-8?B?Q0dRdnVnTHRNemcyN29CVnZvc1pteXZkaTdRSGNocWhPQ243RTdKNUJ6QkZu?=
 =?utf-8?B?aG1FRit5QU9MaVRWYU11VnJRNGRZd0lzOVRLU0E1T2p2VDF0K2tMSmtuQ01G?=
 =?utf-8?B?SG5FY0hyaENDT0NhNnQ5WjlxNEtVSVljN3h6ZU9xWEN4NWJTVFVrNXA3VGRt?=
 =?utf-8?B?ajZlZS8za0xkQzBFaGNvVGNqdUtpSktMK20rSXZ5SUk3cVBUaERGV2NUVXB2?=
 =?utf-8?B?YTZudWFJbEM0MmdabnI0TTYyM1BBcWZlcnk2RXg3dlFSQUlkR3Z5dkgzcmNT?=
 =?utf-8?B?NW15Y0VzRmJqUCthOGV3Sk1EVmdiS1lZTDRQNm1MaHBBSEthMmZkeldyMHRp?=
 =?utf-8?B?c0VDbC9xU2thUWlBdG00dEVaS2dCcTFQL2loR0ZhajJJSnE4RmtYWGJwbmt2?=
 =?utf-8?B?VHkzYnp3NGpId2ZBUjQxeHE5d0dzTTBNalYxVlh0RGhCTVordzFNTDgxTnR5?=
 =?utf-8?B?S0JDd1lqLzNFRnZnbUMvZDh3SWY1aVUrT1pkNnBEWTdaSG5iRmZFWVdGQmNj?=
 =?utf-8?B?VWUwNDFqZkpCUFZDMHJXb1BCR0JSZDVLdHR2MkNYS2FTVmltdTcwTEEyZDlM?=
 =?utf-8?B?QzdaMzAxMjRrUFJid2l6U1dlRExQeUxxTk1xRHFzWXhJem1rNFQ3Mm1hZzUr?=
 =?utf-8?B?cmEyVUFOWFRMbElST2NWMW1jZDdGVDlycXMwZVErL3JoR2FFSDg2VEVGRzlR?=
 =?utf-8?B?OE1FQSsvTWFGcE42OTJmbmRmdzhGRDVGUEplZnVNVlplVVVEUDE1TlR1NDNh?=
 =?utf-8?B?aUE3SVliTzVBOC9ja1cvWHVHTGFWeXBlSFhuUlp0bE1oMno4N2hGeFRrQ21B?=
 =?utf-8?B?UXU1T2RYdGEvN0hxZXN4SFNXSzVrTTVSSWR4Q3h6SlhkWE4zQndLVVdKRnlN?=
 =?utf-8?B?QnRyU3AwMmx3bkxhNXc2WFhta0dHZ0RlOW1yQkhBdFg4L1UvdE1ObkVUNFg1?=
 =?utf-8?B?dDFTeU50NG1SZnA4UG5mcng2M011YWwwcmxxL0MweVZ2UHJDRkxaV3gzTkF1?=
 =?utf-8?B?Wml0N0dJRHBDZVdQK09QTXovV1RsclQ2Rzcyb2htZDBITG9OLzBYVjVlQ1NJ?=
 =?utf-8?B?ZFZuRWlQeGxpWUg4U29aOVpOUTVZY2x3djNuK2JFeit4bTdsZ2haT3h5SWdQ?=
 =?utf-8?B?eG5ucXFHRTZrUEhmLzJBRExWajhDUklacm4zOHpNTjV3WWtIcUI5V0IveXI4?=
 =?utf-8?B?cG9XTm4yTEhtZjVISjhGeTJKczRuN0lZVHpXTXBLTUNwT0dLL1doSjdMTk42?=
 =?utf-8?B?VjZJd1ErcE5VbUhMZTJuYXE0dEpHaDJBazBTWk5YQnFUd0g3Q0thckswVHNh?=
 =?utf-8?B?KzBEZjB6ZlE4cUo1eVpyNEcvOEpPd1duTEcyL1VCUUFzK0h3aDRyVUFDdWxo?=
 =?utf-8?B?ZGFZbnRpR2ZhUkkvNHpLQlR6UjFFZGJ0TGxHQ2dYdGJ3UmdLSEkyU3pwMEFi?=
 =?utf-8?B?dkhEU3h3YUNTMVZLcGFxSEkzeWxacDlzUUFKeTRwQzVRUlBFbDVYYnA2MTRS?=
 =?utf-8?B?N3JyaHZ5Z0NGc0hEeWdUR0N4OCsvd0R4WlkydjZDUGx4QTU5eHlLWnFBTTBh?=
 =?utf-8?B?eVBiUnMrQnpZYUhaV2syZW5URWVoYitSdVVUVWtxMzM0aTdRanFDaSt0L1NO?=
 =?utf-8?B?VWZPNmZJTlpzc29oTUFEVWhFVTZma0xPNlFlVytORXAwcnZuTndhWUdQL0FU?=
 =?utf-8?B?aGc2dEY1OXJTNnBOMThpMXB6d2dhR01wZGRidk53RGZjRjJIalFCTTFzL3Qy?=
 =?utf-8?B?OUVyMUwyLzQ3c3NvTy84MEdjTmlweHFDbmV1UVd2aTZKSnd6N20wY0RXWEtz?=
 =?utf-8?B?VU0vY0hxSVJYUUZ4V2J1WXNFYXVQbXJLblE5OVlHcWxUeEFGTmsxYitvcEQv?=
 =?utf-8?B?K0VLLy9KODRMS2U5L2dRdDJDMW9jY0g2b1A1d0lsNisvYnl6MUp1N0QzWUNv?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e5a909-e3fd-48a8-3b13-08dbb99c2130
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:40:42.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifLptk7DtIQdHOZJhnlaKdLuRhPbk+V/8Yd2rH6jptpsKHMWmZZkTqWqYpWhBqGopc2OT+cbA1utNUs1noIn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7770
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13174

On 19.09.23 14:26, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> One of our downstream target not booted with 6.1.x kernel, we found that
> there is no dtb file generated for that target, hence enable the switch.
> 
> Ref: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/6bdb5d04
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index 51b17c6..5013eb9 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "aca5978b5abf93b20df4efda067c3a3f461476e0"
> +SRCREV_cip-kernel-config ?= "8133457d8e156c34eebe52d9affab9df3f7b597f"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


