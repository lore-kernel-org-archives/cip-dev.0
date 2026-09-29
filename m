Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB95CA5FAE
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 07:39:14 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2694.1790667544998303349
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 00:39:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ns4Ruv0M;
 spf=pass (domain: siemens.com, ip: 52.101.72.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow7KavLSbO1T3BZ6thD8aC1oJytVUfTZ1xp5dxEvnjXmSQbySh6dJEVxVZNXRBOMUROJZenPWmt9IqGsUYMEZ6zkWrEhLsy0JZtC1HijgpuEkGO3uqYDvlxJhn8TuL1s6//XI4lF2Wheb5chG0hQ7lqhd6UBXAj1efFRn5DImeFcwQ3RHaOKGqKAyJmIhQOOQcMPVAlTS0uL2TYZDi9LTlX7kx5hUgj5/rD6A6CNGEODfbeFIGQLcZcAhzXsdL0+8YDQenYX3OPRXljMcybfbX41qeLEb/PQEWoL5VeHhVwyI5ijq+eO7gDPIcUPMrmAFQIAPnC8cdYjVOeVOprDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngXx016p64pNYyVPFRi55QqYwe/I9CbXM20i9X8AjKU=;
 b=PH0zWahV3078U9nCQWizV/ghZDkdyfxM/cbwuj/AXznZMyuEYUGo1wrXcq7pkyYyAQRe6FXhNO5CF2vgAg8s6yLeBSw3L/BEijqCgZUNw2VEIvNCuO+Ct2o5A3hdLlyXPGMKA45ewdZWkZl+NPdsJheSlHKG77FZZhffPTtq7Lki6/UYm6LhoKXd3yt4UIzmpgDYixQQvWju/+9bD2hI4EbYOX9RlQbyxlNB0Gk6KMVVOVDhkxUxVIrnzdx69vM1GRrqUu76E7ZIyqGL6oXbQQFfjAFSsagPKCvIuiFqrJFlNDusQsWZXqmymi3J5vpID8ego5tnxGeRXWXW5YYK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngXx016p64pNYyVPFRi55QqYwe/I9CbXM20i9X8AjKU=;
 b=Ns4Ruv0MSiW1gm7uPXBx3/romn7EPIZrNm+cCFx2Eml0l8q9fdZ6u+twtbYzcIbmLlhOyCaO0DsGM9tCopRuMz8fY5/W4ZFyLsOoiD0IvJSE5sdXCfsE5u6BQBj2YV8Szc7DPzOelkVfkyDew1lKl0iQmAT63cndlG/LX1sP+v0AY0gOJN9/4l6RvamVBIdbp/stfq1TB8zK2TIspSkYZOOPTF+rxqqm4+aqTHG9i7VtjJNvuQeR1synOOko22VC5CEyBfCXNqvNg2dUKwruMyGPi8iL5JC3NkBUYrxYOjvEDfrvQhVN6QTw4lZEuG2X9MVxoormlgzGWh+qbJVElg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:f8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:39:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:39:01 +0000
Message-ID: <121665c3-c46a-48d4-aee5-5f481d087265@siemens.com>
Date: Tue, 29 Sep 2026 09:35:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 6.12.111-cip32
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260929044313.144425-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260929044313.144425-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: 25137409-8612-48d9-719c-08df1dfcbacb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	7w8f7tuct06F+BdBHhdn/BCrK7fJSRh+49u9vzcWu4lDAAmialYUGdLtPwbOsbIVcgo9BUA1xAXp3NkpQNowpLai9meQQ8SUNaKRdOLbO9uhXVJDtIG3joOwv39aMG1u0A04L83gMloRIiuRlr+UmWjdgjE0WdIein9MsRms+Q/whmCI7IWD/zACXWziaz/FXW36sNTmxy2NiyapkLnGdb5Dil4yTCvS73gziAldZok5V/56yjdU9Q8iPKE4tEDSVSmXBGZIdYHk+DLi3zgqbmNXAZ3e8wgzGVDW8xqKdJfkaRGVclOLLLDDKVBGlwEud1duhPRiyCEhuuI5teM3JH1ca/o/Xy9rImjdKEGfskHyOMzCDELYInqW/y36RPLCi3E+1UIwoilUy5Z2FxbTR+4ca0cXIrx8a7395BaA7bDa+dJ3pL6+FeiPZ5vxQphlI6ihpqdwDFRuU+2e1c31hr9hXp2CHKzQvF3uIiM9WpLwarQt80dCzAOIYB5T44BflehesSElmSg2iOjuYGDP1bCpuLUZf/3k/EgLQj3RE5mPAGTHHhKPS2H4M3P/lxJkzO+69DuZKNZBuuvFWlMH4TAvAoOIFb2VNAPSf6QfAJxQab/pjCgI7IL14cBsY/u+6N9cHjwAhajeSsrSwtP1EqanIUZ11KzrXom/AallBCw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVBpOHFkMitrblhKZk11SVR1NmJXQmRONXBjWW9nMWp6cmg3Tm1QdGZ1Nld6?=
 =?utf-8?B?MzVuMmVORkhsZmhOUzlkYTRuekhvZlV6dDNyMGNWRjFKeDA3d0QrQStGNGpo?=
 =?utf-8?B?QzBlRnl5RnlGN1QzMzllZ0FCcGx6MGd5bGNqT1Y0dDlxTEhBbXZZaWpWL24z?=
 =?utf-8?B?RUcrR3F4S0JjNjdHQXI2azdobkxJbTVJYUpXeDBrclVEUEQzT1ZLWldvcHlV?=
 =?utf-8?B?L3ZVWm5QNVJQMzNPT0hCYitUNlowWjlQRVBJZ2FjeENVMkdYN1dwYWY2TGhB?=
 =?utf-8?B?YXk1eWpHaC9DMERZbUl6SkU4RmFIYjM1dk1Hejg2Z2FIK0dhY0NnVjNicHZt?=
 =?utf-8?B?ZVdRbzN3UDBDNXJxNkVFM0Z3QXRzM2JUWHdENGp6NHJiU3dRckg4Q0ZRcHA0?=
 =?utf-8?B?SHYxZ0JRb1QvMHF0R3NVemVXcmtDeEs5dmdvamJscUkvMFNNZDMxUVREQnlp?=
 =?utf-8?B?bXk2ZUF2VjY1cU1IUEJ6bmNEcTB0L1hkMW9ieDgvdFRxckFSYktPSUZUM0Yy?=
 =?utf-8?B?cnhaeDM4Sk9tQ1JZUmNFVzRrcHJ6Y1o4amFLa0ZCdWlpaHhnWlBHZ01pSjY4?=
 =?utf-8?B?QWVSdjZVejJsaHhHcmV3b3JnWFE4a3VSTmRhRlNTRlFvSmswYU9iZlJ4Qmls?=
 =?utf-8?B?cWlWVDhPSm1CYTFaK1hqR2pSRFBSQjcrdHFxQW9LODViMlIrbTFEY3lGVFVV?=
 =?utf-8?B?UEtMUGd0dTUreXVWUlhicnExN3JHeENnYkVLWXhGRTdndDlTL0hiaWxwanJ2?=
 =?utf-8?B?dWMxd3JYZmJnRUpuMm1oQTcrYnExODQ2bDNGeUpnOXloS3NpQzVyNnRBeGE1?=
 =?utf-8?B?TzcyNVhIaHR6OHFDaW9YNmdIT0h5S2hVSm5mTTRONVkydDFmRG56TEJwZE96?=
 =?utf-8?B?ZCtObG9TRjBmUHpXUEJmTnNqTW9vV0dhcXlxbjJUN1BYYTQvNjM1YVdaRVBB?=
 =?utf-8?B?aWs3OTBMSkZ1Q2lDdUw0VXVVUkxxVEpmL2NwMTY5N2NyUGVoVmtzNitVaFdw?=
 =?utf-8?B?UjdVdWQvbDhDb1k5RFoxSDZ1RDJxKzlzQzBjNjc3MytzdWZ5K1Y3aGZGdHBR?=
 =?utf-8?B?UERrZEY0cGxwRTl5WldNaSs3QmMwTzdyOGdvNFl5S3U5VjlKNjRMdDZNQ0ZK?=
 =?utf-8?B?UWgya0R1WDVaSDRTUU9yWWhkUnAyTFJkMjZKaUNaclQ5R2laWWp1c3pGaE5N?=
 =?utf-8?B?QXArdWd1RHNFa29QaEplY2hGUzBoOGZ4ai8va1FZMGNtdk5yVk9MV25lcWtC?=
 =?utf-8?B?Q3pZZWtEa2NHbTd6SEhWUng5T1Y0Vkc0ek1yb0tJanBaQll1YnlwVlNDTC9B?=
 =?utf-8?B?NHp0K21wKzBmT1NRSHIxcWtPOWdkRkh6bFhKWEhDTHNGd0ZKSzFKeVZhMzBE?=
 =?utf-8?B?VG9MaWRRWVY4WmlBdWZNVlVBdW1nbUJGWWszNFE4VHVvMEVWS3lxUW5VK0R4?=
 =?utf-8?B?YVV1MW1HYW1HeTJEeEVnZ1RacGV2RFA3ekIyeS9xd2RHRVpTMWgvVkd5Zmd6?=
 =?utf-8?B?NGFJNXFubEE3Zi9VK0YyTVBKNFJkaVpXSnZwOHBqSnc3K0UrQVBpb1A0aXZB?=
 =?utf-8?B?ak1RWDFPd1BKa25HRThOdDdKdlF6cUxveWRzYlVlMkxoSHlUdlAreC84VDdn?=
 =?utf-8?B?OGtISVczcXp5QStFVWdDZGhhdks4K3J1bjhkRWNuaEZubFlVVk83UUNDRVFJ?=
 =?utf-8?B?NGdJdzJONnJsd0h2cUpWQlpRQWJ5eGF2RzRWRGo2NzZMZkU3ZHNqNitSQk9s?=
 =?utf-8?B?cDkrWE9UWlM2aXE0NjdDa1V1YWgyN2ZzSUQ3NE9ONmVHQWlheVkzNTkwTnRT?=
 =?utf-8?B?TFZ1L0UwR2FxWjdaQkc5aUVSSHFDV1NwMldWUUJCRi9XQmhCZGVJdTcrbjBZ?=
 =?utf-8?B?by8yTG9aUms2UmNScXpkTkREYTlDcWJDYkRpMnh3ZTdOV0hzMFpaSUxRV1Zn?=
 =?utf-8?B?MHpqbjRxSTBWeEovQjhaMVpNRGZaQTVjZHRJcEtubjgxMnV4WXREdlo1U010?=
 =?utf-8?B?Vk0xRlJXcFFtdUJxb000dklwQ0xQMG1mVUt0VXlHWTZ2cHdWVW5RbTJQeHgw?=
 =?utf-8?B?bktwMmttSVg4QTk0QTc0SEdURGZ2Z1pOK0o4R0JXOWdXN2xUUDRCYmVEWjY5?=
 =?utf-8?B?T24yemIralJzYkdIZHFXNEtDTkgydGhLMDZFYThUd0piQWlYQ3hyR05BWkZS?=
 =?utf-8?B?TmpOL1JTL0RSRzU1TC9JVWxleVNEQXBrR0JoZDBUd0VsdVFnZUVxMFpLZExz?=
 =?utf-8?B?dnZMRzl0TlUrT3ZNTzdybEZlOGFaaTM1VFFHSWVRVnVLa0dBM2RoZFRVSEdM?=
 =?utf-8?B?MFNlRmQrWFVoZnJqZ2gzVThhaUlQZXB3dkVCczhRKzh6RTBDQW5NZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25137409-8612-48d9-719c-08df1dfcbacb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:39:01.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydg+4MQNAbuomWcId1daeaT7J+ezEKL+kKAJoaDgOhP/dZAfY2Kvw2+uBCCTHiHbDsGq8ByqQvgaGrCSVRrCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2026 07:39:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24373

On 29.09.26 06:43, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb             | 1 +
>  ...{linux-cip_6.12.108-cip31.bb => linux-cip_6.12.111-cip32.bb} | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
>  rename recipes-kernel/linux/{linux-cip_6.12.108-cip31.bb => linux-cip_6.12.111-cip32.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
> deleted file mode 120000
> index 6b45063..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.108-cip31.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.108-cip31.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
> new file mode 120000
> index 0000000..8003b24
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.111-cip32.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.111-cip32.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb b/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
> rename to recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
> index 7373de3..5a225b4 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.108-cip31.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.111-cip32.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "baf5969362189174c1d0b3480bc33defd3b9ccb73af768b811c117c2e16f8244"
> +SRC_URI[sha256sum] = "879b45f18c1bd8322b2026f72642faedcb77242418cb10a5aa56f5404f647059"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

