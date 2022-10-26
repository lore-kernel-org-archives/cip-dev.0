Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA88C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 10:17:32 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web09.5957.1666779450229835642
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 03:17:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=N3Y5VXWg;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqr9H5b1Kvzo6fU/eGfdv1eq2YGKDx8b2aTbCSPaxjA3zgAWmh1nLI7mHLFZzPxLbs0/4IHtnSEy71qlk69dL1+k2tx3J9xiMNGay/JZKOt/9RP6L3ExxIqZLFNiuid8rvWXxV96AXitEacNeGhjBIqdwplfl16DjlnSYLRIiIyJXNbMvTY3h5RtTfJW3Ewlupaq08mWUbpoEG3Z76YFI+/odb0mH4V2vHS6R8HYbYe2ut5VWbT4Y3XnresZdr2Eiw/bQmwNlqe/lqyIY0yZ5SBr1EaViO8Us3fOU1pZkp53P000rEnIJoybMFXSdJeVovzxzvd48BjQe61u5GyDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtEfr1yWgPiPGlJDdwD7zbGZXNC/2LiauoLAvCVyPoQ=;
 b=ocC7Jmg0JPZuiua86KJw59DMgUSlCRpRzYu/0TB8JLMvZQjCPHWLUx4vROrIZw7ytmL+nVL9rZXuFO6KKhRg4cTofGfq0Gvet4ztpxuQ573uivuPmVBWoPRE9JlO/fjC4iUP2ptox8QsEvSiW9454hY9Rz5QQobAYQO4JBY49oc2eTxPTKvGA4O6IicvSKSMqLMfVroSy4ccL9o1kg26NGJoPjSLP5s4B6WEHQ+d8WPoURWxKqoLB1T+CGwhs7IiVBvuyWwqXv5uxXF6E/jgEQgL4ol8qIwEmuaAFFPXh7ESrHVE7B4F13u7Hgk/zbyFQA0uVFGL1H8RImqhQHzvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtEfr1yWgPiPGlJDdwD7zbGZXNC/2LiauoLAvCVyPoQ=;
 b=N3Y5VXWg3koDqWaqVzlJBxBqB5G+QACsKR+KXfwVwfZosBbPPTHu+NO+GbGpGuOionEMTnOGxwQiK73BYLGK+kVob0n9bN6CnTw6lUc7DSAIo/MEwc+zAgl5kQ6G/JpDRteyHZ90ZrqwGVXWYcmLAqYywlxAdbZByjAJTndtdYy82qGBqwq6AmH5TYuhXRnlgZJzhYxHPRbC9RhvGBgGWnnDIa7cpDqtnn0+ml6jP+hS5ACS3mAqw+c62XJBiJWTKHClJK+Yi3hlkhcETnaqR8XmNG9tgkfsb1l7QhTuVTDwRVvh133UOf6NAKquiKT8xlv2eCuwU513iuWLj0OyfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 10:17:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:17:27 +0000
Message-ID: <79c28068-e6bc-dcb0-3569-2caeb6ad0020@siemens.com>
Date: Wed, 26 Oct 2022 12:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH] shtab: Update shell tab to latest one
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20221026085633.516519-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221026085633.516519-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4c4bf1-3fab-4ba3-4dab-08dab73b4831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4HLaswg/eO7kiEZPsgAeSHTgh4HSKMME4JDADMLCbj+ZTkmEuqRal5Yf3ylInCVEBftOI+NZiBv6YrH/kbyueSfnlHWz2pq70kJXSEulk9GYgYX3/AiCabuARqZJZ06CvLThtCMrY3dMG9IiDXyDhdrG3fk5YBOJa++rWZOvKWidDwIPhP/WqkdP1H5BDH/IN0FuOiI2FMcGcMXBnHo1d4DluKpnxUGPWXLpzZ5WvLlGdeEdXb8+2WTxegiLma1RWzTXEr62BRkW3xZ5Cquckc7LyO0qTYbFI2uAEDjdRRl7T4DX1YpDtY76zJUWckCJVnZ6qHPXZcgQ7XnAjpvcDa5k+AcE53GNU26vHpA/fCtZn0IilMr4pEmoGJp71l4+cSK1unEbaXx8/WwaVDXCIUyUJvaDm9yPHpTZcJVx3uKJyZ/OhXxoATdbLk3GqgRplSY13VhmWAyQwxdP3Giai2vugjy6JnpsqYiSvMN33wiukt6IHlitX2K09oui9q7umHFQVuIEKMvKV5CbFlc6CdJoWDkXwrjYLtrBHWcheuYwWCKQ4r9+xvhyGYAwyyomDhqKser9z0JbCTvK2R2ogBnIoxbD2UxuPNRSufHk8yYjiQr6P3xX5wRAFhVy2Y2Ro0SLIMNSmHkDCxpXDEt3ktxG0NK+7EwVNge+BhrUTOQsMP4OkU6W3qqStHiJ+xm4jK5Ck/43JlOHK6JNxVoQojns8jGCdPBjX+f0BYq2BYKDWtQko5cQAMTTXRcQStGy0J2KvMfCTpFQ87glhYwQ9dIgTQKR3WvWO0jYRjhIF0RjSB7WOUPvu5MC/fsz11f8LOIaqlxofDXbzi73e/4Ho2i7kBtM1qFZaITTSJNiFFOljlZf+C/31+k5QV9Bkscj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(41300700001)(6506007)(82960400001)(6666004)(53546011)(38100700002)(36756003)(5660300002)(66556008)(66476007)(44832011)(966005)(6486002)(316002)(8676002)(66946007)(8936002)(478600001)(86362001)(31696002)(26005)(83380400001)(2616005)(31686004)(6512007)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3NtOEgyTW42bEJBRGVydklsTkQ1Q2VXWWZRSk9mZHA2K3l5NUNsZGFqYkJU?=
 =?utf-8?B?MTZTSk5KT2FEcEM1dlQwTFNDYUJKTUZjT2hKM29qUUgrZi9nZjBOemhnN1N5?=
 =?utf-8?B?cXQ1NC9jcklPQlFpK3JZRVNIUnBleWtKeE9BdjFjdkUvU3lXV3phOWNyVXdU?=
 =?utf-8?B?VDlIL2k2Wi9uL3p1Z2ZUVVBxdnFCcjZpTGtoamVJY3FESWZ1VVd1OWc4RFhP?=
 =?utf-8?B?c3BmYUNzZ2ZBV1lKSXlidG1RTDh0eXR1SEFkSk5aSk4rRzZZNWtid1hIVGFw?=
 =?utf-8?B?c3pQZmNKSjczYktrWWIrc1FoQlJ6MDJTYzh2SXZHUkZQSnIvcFZlTk84dHZ2?=
 =?utf-8?B?RkxGMVVORUtXbXBtbGxScUNmVHFFR1EvT0RBS3FldmxvS3g2NU1CaFg3bXpi?=
 =?utf-8?B?SFNyR1JHbGNZVmQ4MGpqdFZyaWNjZG9VNVdHQ0dic1AvdDFmWlBIV0dtN1Jl?=
 =?utf-8?B?QnVQalhkZnR3SmpaRmFJWGEvYUxCS3BZbi9UWUEyU3BzU3pFeHpvd3NyQjc3?=
 =?utf-8?B?d3NhRHRXY3BDWkVCemkrczZLZFpBV3k4SE9KME5xVTRVRVdZWUV1aEk1dUZh?=
 =?utf-8?B?RmU2bmIzT0xRNU9Ta1Ntd3JmdEVlNTgxUllWVS90YlMwZjY5QWwyQmJKVlNY?=
 =?utf-8?B?Q0ZBT0VvNEpaRzNSallsNHlRZXJEeVAvenliRC8ram93eDlSUW1oZGR5TTJL?=
 =?utf-8?B?YldwZ1ZJYzFkN3NKaE9VeElPb1FnU3VVOHFWRHpzVDN1ZVlRRDhvL25BaE4v?=
 =?utf-8?B?UjkzNS9pa0hodS9DOE9wNHpRb0tvMW9IOGJ5SlBXdEROT1pCaHpmM2VSc0pC?=
 =?utf-8?B?cEFLeXluM0F4TWFINlh2Mm0wR1J2VkpuZEMxU0diUzd0SlgyTk4rTzJmcTRL?=
 =?utf-8?B?ZGl1MnhtYkdaZ0ZIUjV2bjVwRHJsNjVGdU9oY29JNTFaN2JzdEVxUTR0ZnNx?=
 =?utf-8?B?MVMrSzM2U3AvTHN1aC90VHp0UGZqWjFOL2hScy8rVXhRL09PNmdFc0F1QnJN?=
 =?utf-8?B?c1RRRzNCcnplRnJPTWtCanNvT1VkdkNRUTl2YmR4d0QrR3dMSjlZWkxZSTVy?=
 =?utf-8?B?NVFLVm0waWVXT2U3UG1HMS9YdGE1K1M5WTdDSlA3TjRHVjdhVjVJUG1GZmhr?=
 =?utf-8?B?WE9LVDRrdEswWlpTZCt6QUV5THlsWVlIU1N1bnBoR1oxL0J0MVpNaUk0UWdj?=
 =?utf-8?B?WFdMN2drbFl2MVF6K09rcXlnNjlUT3B3aXRvazVQZ25nZVk4ZE53OTYrMmVX?=
 =?utf-8?B?N3R0WWNhNnRVSER4WmZoV2hwRHJQKzBPTHFLL0YxT0UxVWtRVDBKOVJLN1Jj?=
 =?utf-8?B?dHl0ZVpTcm5tNmVIQ2JzTEwza1hnNUtSazRvd05YaGxBbnVwQ3pwNXpaR2pU?=
 =?utf-8?B?N2ZsM0N2aGNtczZmU0liUVBKaFl1VncwSk1JdDBYU01BQjNQaUc1bGg3SVMy?=
 =?utf-8?B?NkQyL1FrZFN1Mm5OV1ROaWFMMU5Wek8wRGlFRlY1VHZFd3VmeUFPZkUxYnFP?=
 =?utf-8?B?dVhFTVVmbHZuM0w4TjRaemVBVmx6TDk3YXdQU1VDaU1sTG9PRmpIM2NReXZ1?=
 =?utf-8?B?L2x0NkM1Z3hNMkZWSWxKSGZRMU1NbXJpL2hrcm4zdWdWUXRxWDFrZUJ6RS9o?=
 =?utf-8?B?R2NkK3YvZDVqOVpFMnM0emZnRHdjdnp6SlBVMS9iZ3hHd2tmeHpmWGd3bDdn?=
 =?utf-8?B?aWpiOU5iNWwxeWYyUmN6Um9vVmlHRW44N2RDL1BHdHlUNFlFNGZ0TFR4cGp6?=
 =?utf-8?B?RVkvdjdlaUFZeFp3eklXSHdGUVZrcHMrTmtaQXBiSWdZVk8rcVo5cW5aamVn?=
 =?utf-8?B?Tjd3RHhQVldDWHY0VmpON3dRd1BmN2Rqem8wQnIybEh2Qm45MGxEWTZQZGlC?=
 =?utf-8?B?YU9zbkR2V3lqTWhiSG9ZcE5XQ3lFdTJmSzg2SU5Selo5ZTAwTkVMNFVLSCtK?=
 =?utf-8?B?cWpZWFphVTdhNmFpbXBBeGx0anJqaEg0Y0tvTkozKzJFdk0va2hBcGQrR1g0?=
 =?utf-8?B?OUlObzJFbHZ3RjNyYyszaFAzR2tlTVJqcjBtekNZL0Jpa1RWdjVxbXNxTWgw?=
 =?utf-8?B?ZGcxWm9tNnpMdnJPOHh4aFErcDMwamUyaDlBOHRHK2VkQ2NsYkFXb09Iam5F?=
 =?utf-8?B?Y0d6OG5UR3hkQWFZYldRU0V4d3FuYmc0UVoyYzRqM0RnQkJRbjdqeXZvQ2RL?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4c4bf1-3fab-4ba3-4dab-08dab73b4831
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:17:27.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tF52vDrvGMkgM2tAhVr57YnqXaCLPeYnZM12/5CT2psSS6HPduIoCi+DuDJD4kvaTUzCcylX2d7O/tY2tZvJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 10:17:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9856

On 26.10.22 10:56, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Bump shell tab tag to 1.5.5, created a patch file to build
> against debian buster and added required dependency packages.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...001-Lower-requirements-on-setuptools.patch | 22 +++++++++----------
>  ...-shtab_1.4.2.bb => python3-shtab_1.5.5.bb} | 10 ++++++---
>  2 files changed, 18 insertions(+), 14 deletions(-)
>  rename recipes-python/shtab/{python3-shtab_1.4.2.bb => python3-shtab_1.5.5.bb} (63%)
> 
> diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> index dccc2dd..ba8c1bd 100644
> --- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> +++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> @@ -1,28 +1,28 @@
> -From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
> -From: Jan Kiszka <jan.kiszka@siemens.com>
> -Date: Mon, 14 Mar 2022 08:17:00 +0100
> +From faf4d157f563ee44636c1cc4ef1be73bd7264382 Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan_a@mentor.com>
> +Date: Wed, 26 Oct 2022 12:32:57 +0530
>  Subject: [PATCH] Lower requirements on setuptools
>  
>  Allows to build against Debian buster.
>  
> -Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> +Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
>  ---
>   setup.cfg | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>  
>  diff --git a/setup.cfg b/setup.cfg
> -index 55eecd4..186aad6 100644
> +index 6fcff23..5562b88 100644
>  --- a/setup.cfg
>  +++ b/setup.cfg
> -@@ -66,7 +66,7 @@ classifiers=
> +@@ -64,7 +64,7 @@ classifiers=
>       Topic :: Terminals
>       Topic :: Utilities
>   [options]
> --setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
> -+setup_requires=setuptools>=40; setuptools_scm>=3.2
> +-setup_requires=setuptools>=42; wheel; setuptools_scm[toml]>=3.4
> ++setup_requires=setuptools>=40; wheel; setuptools_scm>=3.2
>   install_requires=
> -     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
> - python_requires= >=2.7, !=3.0.*, !=3.1.*
> +     argparse; "3.0" <= python_version and python_version < "3.2"
> + python_requires=>=3.2
>  -- 
> -2.34.1
> +2.25.1
>  
> diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.5.5.bb
> similarity index 63%
> rename from recipes-python/shtab/python3-shtab_1.4.2.bb
> rename to recipes-python/shtab/python3-shtab_1.5.5.bb
> index d03e694..625dd6f 100644
> --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
> +++ b/recipes-python/shtab/python3-shtab_1.5.5.bb
> @@ -12,11 +12,13 @@
>  inherit dpkg
>  
>  SRC_URI = " \
> -    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
> -    file://0001-Lower-requirements-on-setuptools.patch \
> +    https://github.com/iterative/shtab/archive/refs/tags/v1.5.5.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
>      file://rules \
>      "
> -SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
> +# modify for debian buster build
> +SRC_URI_append_buster = " file://0001-Lower-requirements-on-setuptools.patch"
> +
> +SRC_URI[sha256sum] = "b8183c7ee95f28d2f9e17bbe040d5e58070e272f8a0db2f8a601917da8cf8e26"
>  
>  S = "${WORKDIR}/shtab-${PV}"
>  
> @@ -26,6 +28,8 @@ DEBIAN_BUILD_DEPENDS = " \
>      python3-all-dev:any, \
>      python3-setuptools, \
>      python3-setuptools-scm:native, \
> +    python3-wheel:native, \
> +    python3-toml:native, \
>      "
>  
>  DEB_BUILD_PROFILES = "nocheck"

Thanks. But is that now in line with
https://salsa.debian.org/python-team/packages/shtab/? Maybe we should
pull from there now and then patch on top if we need adjustments for
buster or bullseye.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


