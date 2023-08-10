Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE567C001E0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:57:45 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.45])
 by mx.groups.io with SMTP id smtpd.web11.14448.1691665062978159682
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:57:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZaPlU9R5;
 spf=pass (domain: siemens.com, ip: 40.107.6.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQTU2wmIU8B+c3DZheQsxhLGpMDB/eK4MDyfZjLooQMg3PBKirXBfHtefen4ea8yemtBUWITUSu61w/G7orC3sFFmTkru81PE2d5jEQIqxtguoYFsvyKROti9ConhxTbgc0BInSTLqm4pOe4cuOGR4fJn9IsEr/qSFrqqMeQqbPRZBba+dZpH9v8F9Qhy6nzFgWxvmBgCrKRRC0DGWkHBfQ7KxuKUV3HgsiCbYfuTpJDmBoSX1QIg/3V0ZYqN8w+r8YuBibl1zSmxBZv5/r9aSlfc2a8ezrKg5kviE2e2vxGfU8VZz965MGq4cuITiiQ1DcIp5J16H6G8F9xIFdu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsP76zHTBWN0jCfBxcSl7BhvwrPqWDvteAs5eB+GMmE=;
 b=ISQD+M2xc1mfwQgNn9RcZdEyGWGEwLCDMET9A7u94aPbgC0hHkWzQ7CpTjthJVicJKzEmpnLiKRzESMHqHMznd6eL2JvoZP5GYpp5QiF5a5bXyC47DRWa5uUcEx/qOe2YATIxPg2Y5E0rjZqDlFX0niT0DE/1GdsdOVK12IPTbJAfWyrBtMnTSbSrhaTYHYR2HVj4prf8j7llflRCVj/DbwaWBmNu4QhBDObyyi6yx9wOpcjUMjjjNdcLDQAW9OKgwBfc/COIPDeOnHNKDYfBPTPDjvWPaOmuU2HABUK47tBEMlldASAS1Pr3WNmUB00hwgyASa8+fk5vRnWBxbVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsP76zHTBWN0jCfBxcSl7BhvwrPqWDvteAs5eB+GMmE=;
 b=ZaPlU9R5A9nY/LlhmaC/cfScAEg8F8Y4Ul+y4b0VUiMtqVSJeNcRKn7HHCxXwZeqZDQ+SqhgcFESn95QZckpO1GiHeAvGauFog5jK1gLdJ0OvC/J3O36gZjrHk442viB0jjrqg4iSkWPVBcGhcPN+NKLmYiL9bh7IN7IAHU3isAAPeGFdafMXYz6KISqHYB3r1U6HE1JTgvWqE0Twfeo2Nxxh5FJp3RO3D44LKbvqC5bD4iYI3gAHQ3j/EWmMPyn4Rjx3fjxgwGuQ/CdkxN49JhSbo4V3zd1B0annfgoyqGCLZ785UmaE2t2DL7x18af7vMawpObtqYVWGa+ZWkUpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:57:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:57:40 +0000
Message-ID: <7a2c7f58-0b5b-45f2-a9d9-134292105402@siemens.com>
Date: Thu, 10 Aug 2023 12:57:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] linux-cip: Update to 6.1.42-cip2
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <20230730224310.1333158-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230730224310.1333158-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a52ff-d8e4-4ad5-2c1c-08db99909df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2qAi+IexicDxSG3ZC9gvHo8+T8jm3pvpgcpYbNcf8qaFChd8q5oxAJVlNRJPNXBsZqIX9VjRfdKi3lUHOZt50IgxJt2+UF4WrBZOg+ispCCzSvuEabPQH+rZj5sQWnCT8JdBpLIB7yS/2B5yZntivvPzpgNw43CmqHhjj8fSqkovs6um1JCRfk2NQfnjq6gIYxHikyUfzF3QgHfw/Vr3+rn5mL2rwM2VN/qOLeumDTGQSerGtwdMf6TsEcH1ZtGVmofR2MUK1KgOAozmSH7u0y3IQbZgRwMHEqhre/n5o7nHFkvZ88dg+6N8H8SgHiQ3Zo7mxxOIDc5dIEj5qVwiDJDQ6dGhgpqSfNXxj54QFvzgozC9rgvb04yr8jmUaiosuSmehwBYlXbZNjB2z0XUeEDiG+acJIMMIH9CZtIcp7t3i2IH/Fws1OGDkhm7fYTaLPP6ZEXZNVbJKAvvM6Hofyt7VVseoOYu43f25BBjXKonerMcvOVZnO9FeQphN0hrOkPaROudKl0LIPTVQfyaKz8WhJhx4o8z2un8R5zz9PRHtHa+kwx8LJ9nQLt6xYQH/AJ0UIg9IOJ8IONeKlj3i80eZYraZX4uXB50NBtYhPuuDSHHViS2dpvAdUI98NxRL2sc4J4V5O51Ef3oTFR2+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(1800799006)(186006)(451199021)(36756003)(2616005)(316002)(38100700002)(2906002)(6506007)(26005)(53546011)(66556008)(66476007)(66946007)(6486002)(5660300002)(31696002)(8676002)(8936002)(82960400001)(41300700001)(478600001)(31686004)(86362001)(44832011)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VG5kTmxpcEg2cnoxSUYwRTcrRW96aUpoYWgxRWplV3JkWDY3Tyt2NnhNOXBS?=
 =?utf-8?B?eDJUSjRrR1oxMjNzOU5CamIvSkp5WnRxL05wcWhlRWR6dWFRdUhHWWkyK2Zi?=
 =?utf-8?B?ck5ZS0NzbnozaHNzRzJSVS9PNk41ZkpaakVtblFkR2JkcXdCMlIwNFRvZXNI?=
 =?utf-8?B?cGZlYzloYjZVN28wNmM2QnVvZE95RDUyQTI2d3ZxRmJYbWZZc0NQUkI5enFK?=
 =?utf-8?B?UWk5N2dzTkRVbkRjanZBek55eUhqRFVOeEVJbGoxUlFEWjRCWkswRTR2RXJY?=
 =?utf-8?B?RzFpbDZjNEVXc3BnSTg3eE55eVo2dUNDaWdnVTZNNjVHUFlxZE5GUGJHay84?=
 =?utf-8?B?bm9YR3FMc2JmTDlHdDZORmJDUzlsdTVkdnJHMzR0dkpyQmZDdjd0eEtidHo4?=
 =?utf-8?B?T2J5QVA2M21LcWN4YWZDSy90bktjbmpEc2w1T01IcTJ5aC9pY2txcnhzOW4x?=
 =?utf-8?B?cEwzYnFGWngvOEMvZDhnMzZkNEh1VTVOUTFDS0ZVYUlETkVkRldhc3lnaFl1?=
 =?utf-8?B?WkdYY25MU2F3OHE4TGRiYWZURE84YjdZc1FRZ0dKdlBpZWg2d2MzaXZCTXd3?=
 =?utf-8?B?WVVTeE5yMm90U3I3QS94VVFMaXlxTkJpNExGY0F3RU1NSnhwRXowUk5iVGxw?=
 =?utf-8?B?NjQvTTREdjVnTDZsN2dZZnAwLzdSMWtoQUFtZEMwd2czcitYbEpTVFptdGRU?=
 =?utf-8?B?K0kyc0d2RGpEbnU1QjlqSWtnYklUNm81TzRzYzNsTGxBd2RtTlJkSGtIV0Vu?=
 =?utf-8?B?RUVYN0pXMlZxSjhTSlhDT2EyL0IxaHU3NDgyYUc1bnQ3RFIxeDEydDVQTU1X?=
 =?utf-8?B?Wml6YllZRmppeVhLMXF5ZStUNi9jblhHaWFoSmpxWkdWenA5L3ByL0NvNUFH?=
 =?utf-8?B?RXU2WWZIVCtLOWVtODUxVjJnRHRENTBWTnc5QWhCN0RXZFdnOXlKaU54amRX?=
 =?utf-8?B?L3hLamRHckphNXFaallMWE5VYlhXTXhVRERtVjJ6WXdDNFRlUThWYmw1QkRl?=
 =?utf-8?B?cVQ2dnVjNHEzRjZZSWYwNEZSbWtlR3NuVjY4U09rUUx3K0lJcTdCZDc5dmFU?=
 =?utf-8?B?YVBRL0VKdWdTQUNLdGF0cmFhSEJwNW1pY254OTNuTkp5bnd0OWlrR01tZFpn?=
 =?utf-8?B?RFdtNDJrMXczVmpJdGlibDM5QVFHUGRCbWg1NmVWbS9WWmh3ZDNKMFpUY05r?=
 =?utf-8?B?NjY5Ukovc3pMRkRvc09KU0kyeFRRNTQ4UThUSTJBVDRnUjNkZFpHV0VmOElr?=
 =?utf-8?B?ZjdVUUJBOWNFcll3R3NtZTdDVG05c3lqM0ZidExJdkZna29PdVUzaEp3eXUx?=
 =?utf-8?B?RlVwZGVOTnFDRnc3K1FFYi9RcUtvTndWdjNTZVZlQ3FFbldqRFB0bUZ5Um5p?=
 =?utf-8?B?djExRVVmVytjN0puajlEaEs3c25NU21TeDc2dUZUVmlDdlNOMElBckcrdjFP?=
 =?utf-8?B?Y0ZKV1BmRlZJSEpLVmJmSVBkYS90TmxDY09sQ3RQN01YR20yU3pwUzNaTWJn?=
 =?utf-8?B?eFFXbS9NajlFRGxmVFE3azJoU0ptQjdOei8ydkRKNGdmdHpkdFd6eGpJRWJq?=
 =?utf-8?B?eGFIU2FLb3Q5bWRhZzB0S0xDejJDYW5DL1JGdXc1WS8xU2cyZ2t3S1I2UzFQ?=
 =?utf-8?B?cU40WVd6YzFFSXJtQVh2RjI5cU9vOVpjNmIwSExDa2d0Ym9Gbi94eDdMbzdn?=
 =?utf-8?B?Ymp0N1o2akEza3pib096Y1NLSi9DNzRQbk5jdzRlWXdXUFkrN3RVMjBFSGVr?=
 =?utf-8?B?SDUvcVBKY1JQZFIrN1pLYm1PeDdqWmlyTjFHV00wTjRpWmNUTEZGN1JROTN2?=
 =?utf-8?B?ZlY1dGl3bUZSV2U0ZElPSDNpQ3ZQZlJScDZvT0pjMmJUTzg1SURuYnNuV2Rn?=
 =?utf-8?B?M21raDJ2V3ZKUWZSVDVXWEFOaWNvaHhpMW1TUjJ5ZTVZemhTNXdwTmxCd1ky?=
 =?utf-8?B?VnhMSDZYM1hDUXNEZEpJTlFYN2l2RmtPUW5LcWhDemJvZXdaU1hFNE5LamZ0?=
 =?utf-8?B?OENPZ1VXVGw0VnBPQlpvZDZTbDhibkh6dVQzakhleFRhVWpHQmlqVjkvR2ti?=
 =?utf-8?B?R3JzVzJrNGpjZU1FMUZCYjNqcDBpNkNXQyszbkI2M2Q3MTRMYWRJNmNTS2NI?=
 =?utf-8?B?U2tOYXRTTTFuNms4ZDJUbFJoRlhIaTVwMGhuOUMvdUJVa2llcmx2NStpNGsw?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a52ff-d8e4-4ad5-2c1c-08db99909df8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:57:40.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUrScCWsvNp76Q2ObRb7cZ0BS896Xnf7dp7GRkUWJG/+M57MESUSMR8a32Eyymi1VD5+tsz/fpeQeNJWDY8clQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12594

On 31.07.23 00:43, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../{linux-cip_6.1.38-cip1.bb => linux-cip_6.1.42-cip2.bb}      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-kernel/linux/{linux-cip_6.1.38-cip1.bb => linux-cip_6.1.42-cip2.bb} (65%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb b/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
> similarity index 65%
> rename from recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
> rename to recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
> index 417de50..0b6ffaa 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.38-cip1.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.42-cip2.bb
> @@ -9,4 +9,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
>  
> -SRC_URI[sha256sum] = "188c2ee35a13058858d71aa9121ad9f75c3834126bd93d019ab1687ce0027aa7"
> +SRC_URI[sha256sum] = "70d05a84e8194a94dccbdce952a983466a404498fe59fb61fd3de1463322bb5a"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


