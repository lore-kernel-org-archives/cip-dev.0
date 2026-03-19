Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9D109024E
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 16:23:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.187.1773937427753372927
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 09:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=upEhQMKy;
 spf=pass (domain: siemens.com, ip: 40.107.162.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ3Vv+YjNTRzvHB/DebsJycCGmuMKQsI0AuR1Ry+Qj9Zrt+8IMNtUrs3oBL5mcn+gwdUQ4QbbflNs9JASR0dAV+uoCx7TwIzy/7/1mYQ2KOv16b6t7Qxm+YXNBN7TP00JvnY3JEl53xB8eTZ6fLmC1YgQWcYV4RyeLHNYVhTx5x7ML5BbmlwHtvmCrQipJF8+OF/US9l+9iUeazXCVmZKVDr4qQtTQLIdRgEVS43j6JRD+97JQR3ZGptnmxVhqi1EmwXtRyyKr4DUDFmcj8LMoNBD9G/Q3YgeDVJDfY4sLPDC+jYmNFw5YPTF80ldoqM5Ms8GGoyChIuvwxaPHMcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxoI+LoK4DDjvNZdLFC3wL5oRohqzpWGibhmpyJGdyw=;
 b=hZF3DMlXAlQDhCMcE3dADuuZEXzQf4W6JRBQpFOfGQEs8vUmTQbtP55x3AQD6Z5lBs55mv4mfhshzbZ3hW1pFf0k3Qw3mmc2AkDahv3sNDyFrjHgPTnc7fi1syMX9DxvSc/9OySZkZ22ifNrwdlIKo84kHU0vykwe3sLuAXM/HCFglkMhRTS0ucfjcwZ4/NCv1xAc4tQMoidupcbvZI06XcEqEu5x9ax/12hVlPlVeFhz1GfjFdW5ZFRAIbNDwjgQiG7XJsoz73++YHFfsx6pJ7Z7DeuNwCp02pbaavI4MYn0hkPs2FGrRA2J3oAVj/AuSHCRF1lFUMmOn2/8K174A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxoI+LoK4DDjvNZdLFC3wL5oRohqzpWGibhmpyJGdyw=;
 b=upEhQMKyNsEEXorDoF60hTJoEMi2S9kY3XnpAwYhUjkN901CAJyYYgqZjcULkLrN3E53In+LR4NZwQms2ZatXUqAY6GE557bNKvIKax/QLOmi5qo/CdJGwn3ENE6AvLhgz/e4Qm2PQa+9OXQYItLYyBsBYo69od88NBeQPj9exHQQvSlxnlMyUWJkps6c3r8CKQ+01DxT9aILt6kxQkcCjhXvAHtHDafXGYQYClLuIxKIYxkCG4tYI5YpTW3tE5YBxI0hYAYXcotI6P0XLq0f9yCjNoG+63IgmvMEgGm51M/BrwkDcINZ/vBUH5yXXmSKF2ENBONbuRf2WCwH0gL4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:23:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:23:43 +0000
Message-ID: <df91344c-4c41-4ad5-bebb-31f70f3a80f5@siemens.com>
Date: Thu, 19 Mar 2026 17:23:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Set owner for
 reproducible swus
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3dff1f-916e-4d58-52a6-08de85d3e38a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	75Yenb8rvF7o8dP3g4XqFSuJrd6kb9w84RcJfrChfnnclFk1oUIJWEqcDA2YGoQo7xWa8n0HXopCOtyKYMB5GqsYIbZOkyQ22npb4kqGsvGcK3jIGFDHsHRzce/IS/RWCpCe5T20AXYrlYe3PZKRh/SR+3QUQl84vY85ewkBTd7TD+DMK+KgSPFGQYuX19afBi4Kv66Ud81ZQDmKf7Cmmh8UDydeVeIdPpLsNPw2bEFk3TS8yJWkSZzoGBl42eczFysH3JEeDmZ1DrFkn4VijvCG9bQ+AKekeca95/4FXe8aEg4BUlw9ERnBFW32R5yJmApOQT7CC/sMUHvBG4mEA0+PXsRivnpCxVyQ+80KxgHvnSkDxwo6ngEVYFObxl/ZMqqGbTludYibDhGhzh7Zitk2IX18YpeDBE22Sx7VYXDEITUD9yjz8saDlDDbcE8kx99EHPIoheWCtDJ+mJGDEGivbJkvphu1JnAYZQna3gJEV1OQrtWHzGgGnSYxfkZjjFX9UXFIekT8zo51jYPLPBPXAt7CRVNoMJgRC+zbgQxK7w+G6MDMBVCW54CnP7D9KJLDMvz0kv9pubilQwJAgiFynoAXass5ep+wD2cC8l78/epeeIxXXBJZHv4dY8v0JvWAOIwymMTjBv4I8XKchJon/GZTzmv2oiGwBJivAZsP7q6QMr87Pvol6a/qsmoFchUzNTruYDZgskgssK/rKOcE024aI5vL+Pl8giEt8wY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2ZTSnR2RUYza1BqSC95d1pUblRkdFBkcFNTdkxmNHZNQlFDNkJ5RnFoWEk3?=
 =?utf-8?B?RTExZXZIUThiZkR5TWFNY3dTSEhvYzBGYlV4YVdBWERZS25kUExaZWd0a2Q1?=
 =?utf-8?B?WU4ybWZ0MkE2OG5qaFZCVDhjemgrWFRrcVpwQXRpeEgyelF6TzBBQnlsZ3Mr?=
 =?utf-8?B?S0Jsek12Y3EwUmFiaGlVdTJMbnhUZ3dWOWJyOE1BdFNOVml1dGNscmdrZHBR?=
 =?utf-8?B?ek16czgrRWdSOXVqM3h5ZnF0b0Z3MnAyVFRiZndJaDd2Y213cVAydm04ZUxu?=
 =?utf-8?B?ZE9peFNybGZkRmVYT0xWWnp4YVd4dEVqMGJ0RTdkdDlhT0xtVkUxR2xzOElh?=
 =?utf-8?B?bmhzOHZEUVYrSmQwRTVXeSsyMVVtY1V3RTNpTmwvdEJldm52TDd1bWFnay90?=
 =?utf-8?B?b1BKcjVTeHZXZTc5blUxSEpMVTNMZkxrTWR0KzA5RDZJdkhyZ2haSHd3VzUr?=
 =?utf-8?B?YXRicVZYZHh0Z1ZxT0ptcXFPTnFkYjFML1JjZ0Zob2tiWTBkZkJwWDB4ZUF5?=
 =?utf-8?B?bDFWVVhNUlVTUTEwZlhDVGtrRjdHaTkxbkRONU0rVjRkeXFpKzlYSUtuS0Zo?=
 =?utf-8?B?YmpXUGloWjVJRmhrbkQwZHRJSHpRenU2bm15eVo3bWU0R0xpeWRWTUc4ajgx?=
 =?utf-8?B?ZUNXL05NVU9yU3Q1MXowODhUdmdTdWlnelltTG83WGlHb0VCQ0x3aXhRWkhZ?=
 =?utf-8?B?M3g3b0F5K3pueXhpK09yWE9rczkwODFZaDZSWmt2OGt3ajVkRWZmYTI0aXpr?=
 =?utf-8?B?Mk0yeGpTdkxrNmlKNUkzbDJZSGpjU1ZUbG44cldKbU9ZUjEzYVQ3MFhsalBk?=
 =?utf-8?B?MmRxZW1XVmEvSS84VkNybEZaQ29xNWlGSFU0OUl4eDRGbnB6YkhuMURoRDhp?=
 =?utf-8?B?WCtoRTlKYWFOYmdXeXhCeEdjRndxdFhseGc4ZmpMMWFxSmlEWFZjN2xySUUv?=
 =?utf-8?B?TVRrcmpiWVhkaTNZcVRXTkRLMndsWFZwYUlsc253R1UyK0J2TEwrcFNTcFFa?=
 =?utf-8?B?K3I2WUx3S05Na2c0OGJFUHRlN0RWRFcrNUNpQ2FXdmJlbDFQWVQ2SGJmWnpV?=
 =?utf-8?B?dFQzeGZDdVdRWVFQQ1QyQzRORE14MFFxMnhocWdKY3dVL0V3TXNEbkxiUFJ3?=
 =?utf-8?B?ZW9iOVNUaXpNYlJjU002SkxoR0w4Umd6Q1JUeWVjNzhiaWRxUG5XWVRDNk1j?=
 =?utf-8?B?NDk3emU4OUpvT21EZDYzbG91bUpqUnRXRG5zbk9rR1J5TmhNMVM1UzZHNTg2?=
 =?utf-8?B?WkFPamxLelE0bUZscGJDZnZRVkUvSW1qcVJsSlFQaTJIYmN0R0dubHM0eFBT?=
 =?utf-8?B?WUZ2ckRWQWtFNWRLWFgzeEc2aXFySTI5WjhYdDBmeTYxQzdrMGIyTEpWVEx5?=
 =?utf-8?B?WHBENzFyRlBxNFpGZFc1RVJKQWRDNThweW11L1hTa2pKdTdOb0RHRVpreFNX?=
 =?utf-8?B?R0RrR05NU0p0N1dvTXVkT0dUMHBZRklJQlJQRGRKcTFOaXpRb3ZVUmFlRTFu?=
 =?utf-8?B?cXBsekFRb2FMRlpkUkgvZTF6SEpPclVWVVhIWS8vcy9qYTlENjlKMnJ6am1Q?=
 =?utf-8?B?Z1M2WXVjc2F1cUZWenlrbUlyMlJnMFFXWEN0bW5hRzc1VnJxRUY1clp5VUpS?=
 =?utf-8?B?L1ppcW1VNUcrbDNXOGJsSE85cU45TWl0anZvVS9CZ3FNc3JNb0d0NFZhQ1RC?=
 =?utf-8?B?ZFFiUndoUm9DaktoRUNRS3pKQVlST3pETTE2QUN0SGRSYVdlRHNXRktzZ3Bl?=
 =?utf-8?B?RjhQVG5oRXNOYjZpRS9jYU9TKysra0kxVnpZSkloaEpOcmlnUlh4alhYNVB4?=
 =?utf-8?B?T25maGpqcEUvL3pYUndRelltUWZNeXI0ZjdZZUNsL01tRkIzVUI1b0VaMXdR?=
 =?utf-8?B?QS9LQUYrZ0llWFJ1dUo5MnJKbnlCYVNxR3hTNkRVaWU2WXZ2Tm91ZEFWV05V?=
 =?utf-8?B?VXNKNkhBK0wwTDdXdjNSYUkzVjE1MVdFWTNqOWNQNzFNSng3ZndCby9jaGw0?=
 =?utf-8?B?a1p3RUVPTmNBWDRYZTZNYmdxd1EvZEtOTER5dE5SeGhOOXlNNjBqV25ySTEw?=
 =?utf-8?B?bld3VDFaZU0rTFl5bEdIOVBUYlZ4eGVwRnNzNThPRHNBOTNWY205ZTBZSFMx?=
 =?utf-8?B?SDdtYWkybTg5V0hBQWlYMjMrWEpqdWZVUThuRWFrSms4VXNBdU12elZLQ0FK?=
 =?utf-8?B?a0IvM2tXZ2dQM1AxbkxpcDNNNmE5Z2wxQ1JIWDBSMXE3T0d5c1pESVhKUzR2?=
 =?utf-8?B?RUlLM21ZNVdza1VURVVvWjRMcHJNNEdZN1loenNrWVVCd2MvMk9tQzZBWVlq?=
 =?utf-8?B?WDY4RUZFREpxU2V0S3FiQ0Yrd0d0UnI4RUNZaGtSWlVyK1RTTlo0dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3dff1f-916e-4d58-52a6-08de85d3e38a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:23:43.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjK3laC6+xDgGPX1KMkEk8uTt/9cFlXVkLv5CZ5EiKLRqsn7KmIqIwf/GsUINlQ0u3LtFbJbSHu64b1x5wAuqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 16:23:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22511

On 19.03.26 16:48, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids leaking of build information and allows to reproduce the
> swu on multiple machines.
> 
> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes-recipe/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index d92d55f..8e90169 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -292,7 +292,7 @@ IMAGE_CMD:swu() {
>                      esac
>                  fi
>              done | cpio \
> -                --verbose --dereference --create --reproducible --format=crc \
> +                --verbose --owner $(id -u):$(id -g) --dereference --create --reproducible --format=crc \
>                  > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>  EOIMAGER
>      done

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

