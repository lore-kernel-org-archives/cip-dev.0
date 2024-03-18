Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6CC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:36:04 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.80])
 by mx.groups.io with SMTP id smtpd.web11.41078.1710761753879757156
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ei9t0iXb;
 spf=pass (domain: siemens.com, ip: 40.107.8.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW5jCGrFmBClzDEoxAguFx1p6ksaoV+8oqPtq4MeEMfVrupT5uPI5krSNATfMYbc5DRKZNrFoX3/eA8uLily+rlmYO5kDhT4h9BKqyCasKm/sZyMGb9leP1iQLin8Rb+XiK75K8wFOqMDQ7IrDg3zxaHmdQiIs1IlkY4p+EGAG6CsZVlvBLnbLdzNDcPFYl84vCXIxH+kAPjKLaIx9nYrfKHFcFYNdQ1MZhq6h7W9wyG/fn4Itd6G+XfwpaZkbleYdXAZVn/Pq4b4NK/dbGpYfpT6lV/Yywz5tjpEoxRTd1ZiJvCjxjZL3NINmqtHge30Y6XItZxp0lu3CXiuEZyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FG7+hzbRSNQbXFpSUVjp4mqO3rf1ME3ZSP/fIsQ8GQ=;
 b=DykmfcleAZlsRoZ1M/rnQtGPXtTZJZqrTdMAOlDbb/h0q7xjq4ZeHtaE8UTH2qDc60e8u+wLvOzfLwyP0PqhtWHoXS67smS15hU/e9WeRFPWnfRO7/OyUbvBCWenJLeB1VfR3307lHGMsCTW4WlHFjXlRRGhwD5kxcuVpIOf//xhESmlCrKbBlxB2DbH0lwmnd6uM62afh56qZ8P3kuB86N1wDLjexUxsDMLsk1qR3FaMip878O6vWXHdQn3/q9yNaX33JH4C/X618rI6uXSxZQR8tiy84rICvwmedtV038KCssbnAx6UXRbXRGvhHrgyCeTCpHC2xBJCkvGUAKz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FG7+hzbRSNQbXFpSUVjp4mqO3rf1ME3ZSP/fIsQ8GQ=;
 b=ei9t0iXbXoELc3+2ssr585mFHOFdV4Uhh2kd+sq2CZJx4AP6O2+43e0b/EcgDdKfN34z+qlM/CXXotYwsYjN8W/Ts74NnMuYZOU13ixOq1gQ7BH2gWyk6I5a3J/x80iFzZGMOsJnYYVLViqD4vkcJz9yyboumdpl/XLgmctOa0xjsoTcvKilOIDaOSAe56vYeqdvkPg46FemwWHjljhUAae9AoDOUYlTw2+cdf3mz3khCdkVeI/MwLISPJS+M6e+e58u++5VtFtGpTChVZPjvQtLla8TNBpYJEE4keRdfuuZmC7ueIMqaw3rtvzPrvUCaxQYmQ0tRFYFbK+/xlDasQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 11:35:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 11:35:50 +0000
Message-ID: <8397cef6-2e9c-40c3-8ac4-8e48a3ccbaf0@siemens.com>
Date: Mon, 18 Mar 2024 12:35:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] conf/distro/cip-core-*:
 prefer swupdate 2023.12 for all distro except buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240314123736.1100948-1-Quirin.Gylstorff@siemens.com>
 <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240314123736.1100948-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f0474e-4bfd-4f55-9c02-08dc473f9009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E05buSNsXqmyb3vkVgkTKPFLopOKosrKF7fuVn8K++LwyYGYWuyjitwXu0f1f6XSGbjD7e6ccivzY9D2Zvr7ip2JHImdblZYFP3/rdA9ReIq1r+bRFtc4LUmON18JN+ZGgY2hbF7zbGuQO/TqbPj6V9RgwDA3lTTzvw1rnZJG2jP9FYRSuE3dtKgjjKmaRGsk+tr7jGlIcIZGDoEZw+ieRO9UkB9KTvUjI1sHRMtQ8pVtLOeEhXPmGRVg3CgMqwPxZtykcIH2HX+Tp69IbXaxOj5ezAgN1XGum03bGCeIbACFfMqzKUFy5n5gegO910ENfzOd+oBVwoJMynbBcxWwTv/TZ1SVacMxFxIOtv8pFvffsOqafn43a06uORZhjRIbG2PA4Gs9zcaen798nIeaXsmPSkZaGMmfh54qR0P6ONxKJLxMlD7qiZDUDd5vtd3mCrvvSDEXDVQmd/kI5nJSmrvgm6pjzuL5eDXlL5oB3TE9nSPqmgD1VmUyKP/GjSuqMZONqPyFT7Rl3PbaQl0cBeEM3yhPZy5g3IKBLxCDcSGE4eO7du82YjyxOhTMjrDEuR2MdBdr9oHJ1MRkbty7P5Jyycz+sPysDn6QISj9imDtAHtWAmDPGEkicXsEJXp/uAaEuZDqX5mE6ijcbZU4xLBlDrUGNiqlTaMC4tMMl4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?em03VXkvMDBVUkxWZ0tVaEs1eDdXdkVyUFg5aUpaNkZoQ1RsMDVkR0IvYmxG?=
 =?utf-8?B?amJESzkrSGpOcTFQNWV3QlhEa3FjRFRoN3lRNVErQW1OWVZsWlNSdEVyMjZl?=
 =?utf-8?B?TzArYTZYYXVuOVo0UzBrZ3dYUEJYS1Rybk8vVmZvYkFxcGFQZUQreXlGT1lB?=
 =?utf-8?B?UnRDUWoxaTIxTlcwMW5HVjdFZlRXMWx4RFNubzlwSkFsMkRmdGt3UWJzOWxl?=
 =?utf-8?B?RWRsQ0ltKzBaekt2UWpmemhQWG1oOTRGdkFkZFlVa0VXUnlrVUNYVG5DOHlK?=
 =?utf-8?B?dld1QXBMVy9BZENMUUUxUzczVjc4c1E0V1NsVzVYR05JY2NPa3c1dkN1TkhT?=
 =?utf-8?B?THQvYmlFTkZPL3hmNm1SRlJmR29pNlBuck90LzNSQ0J4SjdVaHVwNzAvdHhY?=
 =?utf-8?B?NlR0Z01qM2Izd2t2YThraTF6ZTdYTnhoc2lqV3BYYUR1VkNTT0xYa2tvMndM?=
 =?utf-8?B?OHNYRll3Nkg5a3dkcE1qVExBczVFaDkxdWVnSE13Uk1tZHFnODJNS1lBL3I2?=
 =?utf-8?B?Qzh2NnhMYlhrWmN0THVPdzd1dythaFkxUnQ0SW5UNzl2TDZMd1NoOEhCbUhD?=
 =?utf-8?B?NEpvRDZkWFFCRVJ1NkZmenZRbXVybm9PdUlUc0txNGF0WTlhbENyT0ljRU9D?=
 =?utf-8?B?bHJkZllMSjFEUi9GWjl5cGdLNWxXMDIzeGlCZDk4WC82Slk3UjB1M1ZQWEM1?=
 =?utf-8?B?c3FuWUpySXN5RTNIS0ZkbzJxUkhiVDBvVWFFeWJadFUxdlFCcE01T1JxZWo3?=
 =?utf-8?B?UlBpL3lHSzc1QzBMS1g2ZTM1OGxmRE15R2V6WWJZZk1xL29uNVVaZVcrNGdL?=
 =?utf-8?B?TGxuNnkyaC96MEFvTjdWZGZIR1FjQ09mRHA1enprVlVMM05HaFU5eHNOQ3No?=
 =?utf-8?B?NkZZU056T0tLYlFuZUU5Q2NtK3I3MTQ5eFpxcjVSbUhrQzFqMytPMFZvbFMy?=
 =?utf-8?B?MW9LYVJ5V3pjMStSZWU3RjFKckJjbERXKzVVeEF2VzV6Umg3N3pGM09YK2xB?=
 =?utf-8?B?NVpkczFjSFVuZzk0OVF0OFpQNFcyeWtHMXk3U1lZTnk3VjBXdUFGVzUyQkJw?=
 =?utf-8?B?anF5R2oyaWNtc0trY3RKbDdLOGV0N0JtSmF6c3JsbnAzVW4yTWxncVdGQ1Vl?=
 =?utf-8?B?NlQ1MFd0UG84NXRBQkk5bXhVd1dLa2p0bTlaa2dMbm9VR04xTzlUMTU2NFZ1?=
 =?utf-8?B?OGxOUzF3QXpIdmxsYlpLM0NPemRqU3ZxTEkxMnpLOGFGOGhIZUpEY2M3UDB1?=
 =?utf-8?B?LzJIbVNKZ0luMFo1Ujk2MGNsTGpYTmpEOUdyRFZURVBxeGNaaTZwcDRpL1dL?=
 =?utf-8?B?ZlFIbmpRY1ZzRkVvT0ZQWEFBOFQ5VnVCcUVZcWhSOHdZeHl3RkMvUjR0VDlt?=
 =?utf-8?B?STFVK2NoMlI5RlpBK3RUb3JCeDNlZE5MOFpDdFpKL1R1WnlmaWNrQzdwOXJB?=
 =?utf-8?B?MWJWeFNwVEdaR2JVQ3Fpb2l3enVhOXdRTWN5c1ozYTdWekdHNHRnWEp6SXo0?=
 =?utf-8?B?c0JjV2lwaE8ydWEvS2NEaFBLWnVaTDRtSzRURmM1Qjl6Y3BiNit4K0xWQ1hN?=
 =?utf-8?B?VVlKbC8xUlRaMFNXTDRJYkpjSndDUnBNRjZWajBhMVJMZGxzVzRZMlRETU9I?=
 =?utf-8?B?WTZtT21DWlJuanJZQThRZWNML3RseXVaMkl3dW5seERkeDlJeSsvZjR1UXVD?=
 =?utf-8?B?b0lHZ2ZwYmVITGJid1NlelhVYU1rZ2RnenhNZ2pSdmNZS0lzS0FXcThxcWxL?=
 =?utf-8?B?di9EeDQwcS9wTE4rMVllNHdGNkFCdlQ4dUJndHFPd1BYU0pidU9QYW0xbEcv?=
 =?utf-8?B?TDFKNXd0cVB1MEo2MGtncGsyM3loYkxJZjBxRmcvckVNa2YzWGs2dnNCZFV2?=
 =?utf-8?B?RkUrVG9RQk1KVkErNXQxczVDYnoxS3ZxektHbkVGWWRvd2JyZmk5UnFib3M2?=
 =?utf-8?B?T1RCdUoyblRTaHRYa0JLUjdZYTVIWEJkZ0dzY1RzaG5jeU1UQzROT1NXTC8x?=
 =?utf-8?B?UVhHZ0RsUXV6czZPN2dkTytkdmxUM2NOWkhsYzdHc21zSmtJV2JuVG8yVmY3?=
 =?utf-8?B?cHpLRCtMT0NyU0VJUDI4RFUwMjBsUEZQR1NWaitSVEorTGVOYmxSYmdZME5k?=
 =?utf-8?Q?g89HzdKsgi49XH0sKXW756KB6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f0474e-4bfd-4f55-9c02-08dc473f9009
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 11:35:50.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTNvPgTFWjPu/FD3zAwmG9uonpllBbh20uz6DjZy2ZfJQ8+HqqB9tPMXglKcqYx3Avopvx+SNM+0G6O7bL2a7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:36:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15346

On 14.03.24 13:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-bookworm.conf | 3 ++-
>  conf/distro/cip-core-bullseye.conf | 2 +-
>  conf/distro/cip-core-sid.conf      | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> index 9bcf559..634a666 100644
> --- a/conf/distro/cip-core-bookworm.conf
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -12,6 +12,7 @@
>  require conf/distro/debian-bookworm.conf
>  require cip-core-common.inc
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"
> +PREFERRED_VERSION_libubootenv-dev ?= "0.3.5%"

This line is not explained - is it actually related?

Jan

>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
> index 4f26299..110f334 100644
> --- a/conf/distro/cip-core-bullseye.conf
> +++ b/conf/distro/cip-core-bullseye.conf
> @@ -15,6 +15,6 @@ require cip-core-common.inc
>  DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>  DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
> index aff4572..692c105 100644
> --- a/conf/distro/cip-core-sid.conf
> +++ b/conf/distro/cip-core-sid.conf
> @@ -15,6 +15,6 @@ require cip-core-common.inc
>  DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
>  HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
>  
> -PREFERRED_VERSION_swupdate ?= "2023.05%"
> +PREFERRED_VERSION_swupdate ?= "2023.12%"
>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"

-- 
Siemens AG, Technology
Linux Expert Center


