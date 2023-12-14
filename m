Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B47C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:25:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web11.23442.1702563929096957100
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 06:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rX/SJ3sx;
 spf=pass (domain: siemens.com, ip: 40.107.21.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLRrFVB+prE5WXGbrHyP+Fyqc9MTrZsdy71tAGE4KFWf1uvkHxKQhDKYxXcktDE1kgN6d8ordFU+pul78c2v4P46yFDglvzEYuBEii4NQX04uLNy9Mn07PPwacDsGHbIFQQckeoZIFcfIQ/B/ObIomQyzZlHTZPAZI619dbGqKh/ZZlEeA46k2cKpIShaUKHVs0boaFNPwPwtyWjvJHirLaWKTsoqKP8YIF/5tUL64hH9D9C/PTcyqELHDQafl0iswdbqL2F/t0AVUwJFNGU0jmCGSZKuN+it2UUm4LYvksh76/0uxeXKbZOZaThPnpyaVlkWZDeNyJ9Ekq9dw5wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LdZv8ASZpniye4X7QPR7BNpkZBBKr4a70CRS0WUnqQ=;
 b=O5CiSvz+IaTbgEY6B+jUgU0qtfcbL4CnY74np/ttDmIoQ657dMLcXTwG29wKa/kNztwdCzKE6A/Dk5OUHfPNz2rk5xH402j4Ky8C1mh3LfH7BAyxBoiWgYFMnvhfNAheoMoV2A/FudfsfkOl/dFJdxYT1LelbiZYi1L5K4aAKo2cL8GW7Vdtdf0fwKWc0gtXe1qfN1kPWS5jl3TUBHkwgM1zy9wNVTIEhwtgQlRoepRHfE8nySdLvkve8QqXRf8M3yUXPMuCKkie4gG3r1rurTwk5KrM2lY2D3FewV59pnHqpqlGKBE3lXZ0Qn2iF8/bZbBCQsSdoVpZkzzpIMNdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LdZv8ASZpniye4X7QPR7BNpkZBBKr4a70CRS0WUnqQ=;
 b=rX/SJ3sxhEZWpuPn0I3OrR3e+P1EAljU4Z00QCLhaJZn0aMjruOawNQvQyHG6Ql2hn5gCMRztYEId4Jxd5seVbsIIkYEey4+e3G+iTdUS1y16uI9d/enDJpcXqThVGlFD3ldTg2B7FERF0H0j0eE1AhXgjBPf6zCavlmJltjVIZBzN33ApnEC6yE5gCFeRVQ/0e625ItFbNx3pnIMM45MCAFIgY260/QKNmX47QPrs+3qGwZkE/dWGLItEOC8BEMNeiWUNw89/jfj/edjb3BYYDrKhYX2ncYRm/3YvN6QR3xlg0Udp4H6OJTrOlx7HrGF29kyR5B71hwZLgNKXm/Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Thu, 14 Dec
 2023 14:25:25 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 14:25:25 +0000
Message-ID: <f9ea8517-05ec-4558-8bda-0510de5da9fd@siemens.com>
Date: Thu, 14 Dec 2023 15:25:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] distro: fix dosfstools-native is not applied to
 security target
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231214130012.16994-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231214130012.16994-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 187da34d-e5e4-4d0b-f665-08dbfcb08352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O5Rr6n6UVe/H5CM5zH9hAUQeHeUUAzIU9WVvo83sYkKKGj/C1mO30mmpsUyFHZanHo6bCCpyvPwWLky31zZ9zflId4aE8+K7QewDytDB3z9jMDZkuC0n84ckZT8cAuamzePDR4FmZNaquryg6NVk0Kbbo+YUAP3aJKYzM86zgbO2gAYx398yG1O6UJqSIFt41dxba/m6QHTonnicSjnXoR1BZkqesPmgV/3UzaHlzRwQfUR5BXKHDHAozKmbShmaUpsCHib4YLNW0LL42hhzd7sELyArVVZYVUAdZ5YeG6pVqh2/+GVUYsp1veelWxF4295B4wL5y0+Cejse85xCyCpJ+jGeKOUv9lOPDZM+w0wU5iHGusIYKC18/15DSYNvo4gSVR9SQ3JbnW/RZmaGdqGhVN2CIyAZB9meILlVH7gs6dT1YUqBDQZFOeiFhJCzKTZE0fY88EtL1TnhzAgkoy4jIibHCjN78mpfvwz9VzoAH/u4XNhH5sYrTX0Xg2K3PGlJeV+jTbVGkJw0ca8xvsOIQpr4k+NFXrdb0bI/2SEB5xmzjbDFAKewQHFn0LB6fkV00s9fhT/Zln3iUd7KYCYfCxiHHvpb2jSzUk8x8I9tATYa+LLbuKySw8eAjsw8BYra2BOQjEP1HpAM9vy7fA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(6506007)(26005)(2616005)(83380400001)(82960400001)(86362001)(36756003)(38100700002)(31696002)(2906002)(316002)(5660300002)(44832011)(6512007)(66556008)(41300700001)(8676002)(8936002)(6486002)(66476007)(4326008)(53546011)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnVnM3gxZHVBNDI0bEUvYU10S3dkUFlzbk5WRGU0S1VGYm9Od2R5Z1pyQklW?=
 =?utf-8?B?NlBIYTgrRGY3aHNYYVJBdlFESEdsaHpzMUx6dVhFSTlJVHNDOW1iQ09aeHNk?=
 =?utf-8?B?VlJwMUQ2S1diTis2aFJSTmRwRUhFejRpaURuYXZzUWVzRnlnUHRGUTlwWmxt?=
 =?utf-8?B?TU5PcG9HRitEMTg4QnpWQXpFekZDUGNkNm8vQ3JrVFJ3UkpkY00zWjNnSXpS?=
 =?utf-8?B?cXM5OStuNlhvaWFwa2Zvc0lqV3R1VXNqakdER1QrSUpOZXZwdFVMUk50cmFY?=
 =?utf-8?B?OVJNZXhNL2pldFF4R0VWK0h1SVRtYkxmMHBxVHlqVE5CK3FOSkU4NExiNGZz?=
 =?utf-8?B?YnhnTE5lbnBxUUhIZkxSVUsrUG1TYXcwUXl3bkR5bG41Vkp5eG9GVVV0bGRr?=
 =?utf-8?B?MUJacmFnVFVYUG10dFNrRlZMSUtiWDIvS2p1ekVwRzhkMWVXUjllVVdNRktL?=
 =?utf-8?B?U3l0NWZvT295Q2owTVpWeUlmSm9RQUtiMjVhM0xESDFlZUlHSFZ1TFIva1N5?=
 =?utf-8?B?YStiNEJrOXRIa0Fna3Y5TmpDS2lzZ2tPbG5yd2VPaW5reGw2d2Q0QnM5Mk14?=
 =?utf-8?B?aEJQSU1Lc3lMSytaYnJHYWxRMDUzaFNBcjc1NGk1VU02STdEam1uVDVma25r?=
 =?utf-8?B?VDBjL0tqbkdSN3d1VFQxSzFJTWhibVFkcmJTMjJvTWRtUUo5RWZJc3hHT0pG?=
 =?utf-8?B?R1NZQkViOWZ3OGdWcGZ6TFpJUFVBeXY2VmRRalpxOFd2QUcrV0lmWVFLdGJ2?=
 =?utf-8?B?NG95STBUbWdXYWF5WmtlZnk4OUV4Q1RFREpsd29BTlVkeUJMbjBjRTJZVnJB?=
 =?utf-8?B?d2xPZDF1ZnNjS1Y2MEpIdUxFODFNZmt5cFNGTnFkRnUrbEhwVVY5S1hya1Yy?=
 =?utf-8?B?eWV2Mm04dUpzTkJSZDZ5bXNPSmEzL2N1MllUZFpCL2diUnl6MmxjOE55MUVM?=
 =?utf-8?B?V3BNeURUeTczMUREakpOekJVbENtZjFpajFEZXp5MllVSTBzTzBlbjBiaGZI?=
 =?utf-8?B?eXZLN3BxUFZLOGkwY0Z3TnJkTEN5TzNOT1RzOHJKbHprdXhBeko4cm5BcFNO?=
 =?utf-8?B?Mm1DUFdKYTNwYnpjMnR4WVJoV2xyZXQwZ2NzaTRibDFneVlwc0gyUkZibFFL?=
 =?utf-8?B?RC9GYlVDeXBHc0lPdGpKL3hsK1hqYTNOY2sycmthb0xWc01kMXFGWGhIczFY?=
 =?utf-8?B?MTM2OWMvK3FPNWhkZ0dXK1R1eVMrajc5eG5xL2I0eU52OFNsWUtCbGMzZDJG?=
 =?utf-8?B?QUpRdXFnYVZTREc1WHE0bjlheXV2NFpNN05IVFZybDU3K28xcjV0TmJNRVl5?=
 =?utf-8?B?ODR0U3NBdFhBZndseFp1aVl1VUJSNjlQaHJvR0laNjBtVXRHVzZzK1VRTlZ5?=
 =?utf-8?B?VUZiU2NFWFVic3g4S0o2NUx3TXFiSkRobXFqYnpMaXZ5YWtOREdmMk50NVU0?=
 =?utf-8?B?NlBlcmlTQU9DdGVQUUlZSWt3SzgrVnY3Q25wTGR6MWpBTjlVVERLbmNNOUQ3?=
 =?utf-8?B?dlNSSFh0K0ZGTDB3VzRlNkU3YW5xZmMwRkZ4VnB0a2VWSUoxLzY1VnlHV3Fm?=
 =?utf-8?B?UU1sVmRmVnI3K1NtTWJmbzEzZ3Q3SEFJUnVrZnZrVVI3dzlUSUwwTWxkY1J1?=
 =?utf-8?B?ZTBSd1czeUpuMjFTTFFUU3d3TDhiVTB3emFtTTIveVNpbXk5NzlDOE5BK0dP?=
 =?utf-8?B?aXgxV0I5Q0dHM1F4R3h5TUpGVkJ4TGhNY0pQQmdUTjRuakJwRmtldGRMbldP?=
 =?utf-8?B?aUxVTEd5UWF0dWlpNWsrNGg4aXhTY1NhMEg2MGlJVkVIWTBGZE1Fc2JvbnJj?=
 =?utf-8?B?TEFDazI4TUNUZGJ5OWY1alg2QzZSMEozV3YybG9DZm1meFBSaU9EbE1zVkI1?=
 =?utf-8?B?TGdRY0x1ZFJQVnI0eDJpNzNmSlRmSmpDNUgvNDQzNHBiZm1LK3hyOFFwcTRx?=
 =?utf-8?B?amtPY0huaXVQSDZxQkxrUm1sYWEySzZNTklvVHExTjNYKzFWZEU2NG1wMW1o?=
 =?utf-8?B?b2VBY0tVcHhLTENQcGI3UUJjOU1Gc3htMEljZUY5TzdqcUdsb0YvcDhJMFly?=
 =?utf-8?B?MGd4NFUzUklyaHFsMXpUSlpxS0tzYmV5eWV2UWlsQlU4NzlUYkh3OHh4S09s?=
 =?utf-8?B?WVhoMGl4dVRmeDJYYU1LWGxsT3ppWkpmWDhSUEVuVTlaNDFDSmtkN05Ld21T?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187da34d-e5e4-4d0b-f665-08dbfcb08352
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 14:25:25.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95/xVU1NCNf36Lzs2SWt0ewIxXgmLpXTUMV8fYD2KZv/8h/7Qbd5OcomKqrV7FUbr0AbrJwCjTF7tHiAOAK0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6506
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 14:25:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14108

On 14.12.23 14:00, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> 'dosfstools-native' is required for vfat images to build reproducibly,
> this value is assigned to `IMAGER_BUILD_DEPS` as a default value, but when
> other local configurations defines some value to it then the default
> value is skipped, so modifed to append the value instead of setting as a
> default.
> 
> Fixes: #85
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  conf/distro/cip-core-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index fb5b98d..dfee24a 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -15,5 +15,5 @@ WKS_FILE ?= "${MACHINE}.wks"
>  
>  CIP_IMAGE_OPTIONS ?= ""
>  
> -IMAGER_BUILD_DEPS ?= "dosfstools-native"
> +IMAGER_BUILD_DEPS:append = " dosfstools-native"
>  IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


