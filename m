Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D235C77B7F
	for <webhook@archiver.kernel.org>; Sun, 14 May 2023 10:54:45 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.49])
 by mx.groups.io with SMTP id smtpd.web10.64829.1684061676572232357
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 May 2023 03:54:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hOnDvfML;
 spf=pass (domain: siemens.com, ip: 40.107.8.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQAMUvb/Pad/RoEGSobvRTfEvXf/N7dtF+FYo+z6lW9IEZoXl8mRCvaAo3RmRPdKORUb0AdqyRtgVwk8MX2BTHFJpFiAvJAot9t0W3wZkNpbiC5+AnreynfK6NZ63svU209W4rO6G2VUKfLtaplTkVo2juOA2tcgAPo4DLagIVUi97sQlGkRMUXluun2ggeFxHzsXfTKi3HTnAMVX7NJ1bR1pk/cWE50bFT1xaXEuDEAZzRgq1XlF8nsVUb6b7jXGEaYsBDRvOGo5HqgSJ6nqW8cxFee7rGmdAzKXl6qK7IhPeUBynvoOxXO+2UG6aPTGlsqmx6CIe722C5eYBiANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYK3mbCdXeAgNxXNiMSttoXYTpgnk/fjrqrUfhbADV8=;
 b=C7SEUeOwIsUymXc2RmwbsB3kiaxZT4y3H5nmOLHPBfRMw4uRJuR9SBGMSl7XfeG4hTMlAUtKV6SsVJn7NXrVKqB9kGx4btHPAAztF6yhUyyI1dXXHdbYirCHmToOw7YT0QJ/OSAi5AO+zJzmCPOOYi1SoeOJmsH7VopNmClC7E6cfBgl8NTF9vPV9rca2xsqZpNjHhsiv4EXiKjRa+aoLeh0T30nLmxGJ7PzYn3IL4bFZwPSGzq2odGg0dPzeGMQAxUpGFyk7wbo3LliTK2rmoapWOomlpKg5VzwYPzIiyG3VkYu93mIeFoDMWoTMXZsV7hoK64JNIL4G8SSLFIIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYK3mbCdXeAgNxXNiMSttoXYTpgnk/fjrqrUfhbADV8=;
 b=hOnDvfMLHO/2wIOLlAFWkyuZVsZsrdZNcuY1U4AXH+xpb5fhpTjT0/+DwbQgtFQxc2rxkC+vMpYUuKNOBxJHqsRsZR4ZxWj4Q5AvxhdVHfoFcOI+o/JGRU30nfvuwG0CDSYGBr/7Q62YxNIVAAf1FB6KULTwYbmVeev3zk3C/IpvQsgSzQHg3V2d7J0WwthyfeKDOpc2kPZREpsjZLZzfb0U3Ga5jI3qMESS9twU7nkOKC9MHoCY+mdMHek7EkiJoK723dDSmH7E3puEM+qOJgL3h9ij7CdcifN7QZgDXlMQ15ZDqVvQwhZlrSuwx4anf6aposB6kX2kbtcHBN44hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 10:54:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.022; Sun, 14 May 2023
 10:54:32 +0000
Message-ID: <c8aa853e-f207-10c8-405c-8c696ffa6e69@siemens.com>
Date: Sun, 14 May 2023 12:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Add recipe for
 2022.12 for bullseye and buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230511153938.860495-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230511153938.860495-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: d319c94c-d7b9-4f6e-7311-08db546998d0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7V2B2acRbgJ2HfAEZbaAEyNqaSW0bxk9AGrTTFK76YTaqsxmcHghdz4fMkTIGIGW01eKzpGYXZfOA1lQNv+iVfVcEgbp4IzFvDKlNixUIJlYtBT+UhnTyo3KDCO1FN7MGpuaAM38YZbivcKn3mbso9MRi0u88mnum4ilTPUXkk0kFb4YDHsTKR3A9lVxZqyc7KetaC3YJV4CZUiATXqntr9AAkvu1lWdDcHrBcahD3F5x7lDb6MiLbqOzVfu8phIeBnNCbZk+IQwG1DekOBoc3cU+LwThdipWCMft0I7w1Uo8z9GGbLGy/m6Ekqs0sNzxK1zU/v3j1+ckA8JLds9L1NJAwlnAnmTjfu0idubu12yAWD4EcueL7/BjVk/vBk21iTC8pCP+5Pptdrv/l0TKBYEBHxzvfYuTl3rfYlErAdPNEOD1cwLCM3N4m4mmGXMLmyISoyopnuSdqS5w6MrCVsuMLyY+cu8sSt1QurVGwgucUy//BiGPuEkap6ihVCK6BTaQwKiWKEL2dlhLq7SJTM9IWwDzr0XV60JtqEXcrwal5OfRyWpNkdJWviS5R0N3FaEQWZpsJUzmw29IxrhHV6BMft2GyRY/GDN5MMOQI4DvFjAXSsVolOcxKPnezXYFz7orx2daPdj38OlCVohNw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(31686004)(66899021)(66556008)(66476007)(66946007)(478600001)(86362001)(316002)(6486002)(36756003)(83380400001)(26005)(186003)(2616005)(53546011)(6512007)(6506007)(41300700001)(8936002)(8676002)(5660300002)(44832011)(2906002)(6666004)(82960400001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUN0ZllJMVJhb2s1aXZqcXduaWRuT3NKKzdvZlprcnNnUFlMY2V5SEl2Vzhq?=
 =?utf-8?B?ZHFTWmgvamoycThoOGJwUmpVckhVbTBTcTlFMkNzWUFQNHc5VC8wa0RFWGZ3?=
 =?utf-8?B?bmRUTlpzZUxKSERBREFxOThxM3B2Qk9Bd0JaQ1lmZmd5dTdiSG9iOHg4WGtX?=
 =?utf-8?B?bklhME9FQmJybDhHNW1oU0tCMnVGUlNMbU5ycUQxRi95V3hENVY4Zy9kemJz?=
 =?utf-8?B?SVlObC9UYTlKeUprNG8zd1o5UWlLaDdodHVjenMxNnRlVzV6Z0dvL0llTU5L?=
 =?utf-8?B?MkFCZEFqMDYvN1RhUm13RE92Y1ZvMU5EOFFNWU1Pc3dNL1BuWEZmZWV4bDF3?=
 =?utf-8?B?VStXbWdFcHp5Y0k4a3JNalpZcFB0SDQ1VFlscGhoNWRIL2NDU2xLYXJRQ1ZK?=
 =?utf-8?B?YWVpa2xKYnZBemtvd28yUHJaTzQ0SWVmSitwRWlLTlA2K1pYQjFuWjVCRVRH?=
 =?utf-8?B?eGtIcFA0OHRvYmZTMjJRUmk1VXZHQ0hFeURKSVlWTTBvd3d4dWZ3SjRmaFUz?=
 =?utf-8?B?V2J3aDNVeHd4ZkhmbjAzSjZBcGw5Tko1Ulk0V1dCLzdtWnpRTnRzY1hmaE16?=
 =?utf-8?B?dlhrS09veElXS0xxQUtxdmJMbW5Wa0Z4c3dhdHRZRkgvOGNla3BHZHFoWDl0?=
 =?utf-8?B?THgzcmhNMk9KQVkwaTM2NnFaRDg4VDJBOXk1bk1FT3Buem56c2hrSm1oM0kz?=
 =?utf-8?B?ZWZuOUVjQmU3dUhtZHdiTHlLSkR6dWFORkR6SllPQ3RHUmFJdm1xUW1INEs3?=
 =?utf-8?B?cG5DNmtCdHZCaW5EaXd6eVh6aHRYMmpyeUp0eFVwSU5sTVIyam1yMjg1ck1R?=
 =?utf-8?B?VUFMZHJGMXhWd0Zkd0twVGR3OE1BQktCbUJtL1g3Nnhsc1gxTStBRkxmc0dp?=
 =?utf-8?B?Z04rNXduZFBvdThrMVZFUkl0MktSa3d4RldCOWpTZ3prbUFYNm1GQmJJVFlN?=
 =?utf-8?B?SjBwVTZrYk00WDBXYmtFZmpSaFZ2UXI2eGNSOXphYjZFQUFqQUtRK2xydC93?=
 =?utf-8?B?NjJJL3h6bGhrQXdVemdpYXozUGkzTG1xZGFVa3ErRTFqcE5wdldsQWs3K0pz?=
 =?utf-8?B?MEp2OGlZUkVaSjl5YksvWVEwV2dnWWQya0JKTlN3WEMrV290V3p6TnRTTzVq?=
 =?utf-8?B?R3QzRWMyT0lpbjFhQzJqaWtoOGk3UlE3R1RTN1dodFkzZ1FHSTNwNGxlbUZn?=
 =?utf-8?B?U01uOWExdTRMeTBuMlJhbFJyQWxMOUNBTkovcm5zY2JNWmJaNy8xdnQ3U3Y3?=
 =?utf-8?B?eGRSNitIQW9mVnFMRTdYMUVLQVJnaERPaXVseGpsUmJSMSt0SDNBTW03ZDkw?=
 =?utf-8?B?Ukp4WUR2ZUs5UHBJbEt0RlM1OVp3YXlvaTlRcHhIOXVPTExaZkxmVU9UTmc1?=
 =?utf-8?B?Sk0wWWdmSDROOFFhamJldkNUNnpvdjNWWmFWWHkwV3M5YXBZdXdqbnphYUZ1?=
 =?utf-8?B?NmV4ZXo0NEoyUFBCYng0Zkh3Q3FSRENCWUt0S25zaXB6SDJqQk0rd2dPRU1i?=
 =?utf-8?B?c2VaR095YnlMV0lEaDd2Q1lJa21nT1hzczdmT25wcVFmcmdwQ1RJVU9UWFZ6?=
 =?utf-8?B?OStNbFVJYlRMTTZ3N3R5dmRhVDVlVWw5aEdzN1dhSXpEVGI3RVFVeE4rcGZB?=
 =?utf-8?B?L3RRUDhVc3gzSW83UFhmejFTT1ZhelJSaWY1aURidDlvaG8vNzJTREVsR0ZS?=
 =?utf-8?B?NHBQb0RWT1dpKytBV2pwcFl1ejNzWUczdS8xdkZlemN1Y2M0REIvV1pYZXZp?=
 =?utf-8?B?YjFTc1hVNmRGQmlQSGE4dFVCR2dYa0xsaURRdEZpTXFKb0Qydng1NUxNaUUx?=
 =?utf-8?B?Ulpmd3ExTUNGUFV5N085dzEydkRJamxJajdTTWNKeDRYSXIvOXFxczdRc3ND?=
 =?utf-8?B?d0NaUFJIbkVpQWsrdHZWL01Ja0lvTGgvdm8vaWdJZ1ZEVlNkdE9CN0xWeUN2?=
 =?utf-8?B?VXNMM0hKTTY3QkQwUG14eWdySzVlN1F4K3Fudnh2M2wzNmtZMk1GSDFhZkcy?=
 =?utf-8?B?NDFDRjZBM2lsQ0Z1TWovbXNsZ3pNMThSblE2ZXFSYjVzdGcxWFRJQ0htZTRH?=
 =?utf-8?B?Yk1uK0RDVXRIeGVRZkJFZTcvTDNRcTVuYjVpS0JGcHJ5T2w1R3R2N0JaQkNR?=
 =?utf-8?Q?VqE5Mr6ahNCC2na2XkPDmjtlG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d319c94c-d7b9-4f6e-7311-08db546998d0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 10:54:31.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoID23mIEeMAUF5cQ/3JP9zeNTVu1e82XZgIDpOLBbRK8Omma/HtdwkSGBYXlAAGGU118pFeJbV1+FxIimpnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5579
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 May 2023 10:54:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11440

On 11.05.23 17:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows modified swupdate builds in cip-core. It also
> adds the option to use suricatta-lua instead of the default
> suricatta-hawkbit to communicate with a webserver.
> 
> `suricatta-lua` is currently in use for internal projects. Some of these
> projects are planned to be released as open source.
> 
> To enable suricatta-lua add the following line to the local.conf:
> ```
> OVERRIDE .= " :suricatta-lua"
> ```

I think, this is a bit overkill, given that only one switch needs to be
flipped in an own swupdate_%.bbappend file.

> or add the following line to the swupdate recipe.
> ```
> DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Add usage of `suricatta-lua` the to commit message
>  - Add missing space to DEB_BUILD_PROFILES
> 
>  conf/distro/cip-core-bookworm.conf            |  1 +
>  conf/distro/cip-core-bullseye.conf            |  4 +++
>  conf/distro/cip-core-buster.conf              |  1 +
>  ...eferences.swupdate-bullseye-backports.conf |  3 ++
>  kas/opt/swupdate.yml                          |  1 +
>  ...d-rules-Add-option-for-suricatta_lua.patch | 30 ++++++++++++++++
>  .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 35 +++++++++++++++++++
>  7 files changed, 75 insertions(+)
>  create mode 100644 conf/distro/preferences.swupdate-bullseye-backports.conf
>  create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> 
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> index de2e435..f05d3d3 100644
> --- a/conf/distro/cip-core-bookworm.conf
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -12,5 +12,6 @@
>  require conf/distro/debian-bookworm.conf
>  require cip-core-common.inc
>  
> +PREFERRED_VERSION_swupdate ?= "2022.12%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
> index 3a0550c..9c83054 100644
> --- a/conf/distro/cip-core-bullseye.conf
> +++ b/conf/distro/cip-core-bullseye.conf
> @@ -12,5 +12,9 @@
>  require conf/distro/debian-bullseye.conf
>  require cip-core-common.inc
>  
> +DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
> +DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
> +
> +PREFERRED_VERSION_swupdate ?= "2022.12%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-buster.conf b/conf/distro/cip-core-buster.conf
> index c5cb39c..4e9a4a7 100644
> --- a/conf/distro/cip-core-buster.conf
> +++ b/conf/distro/cip-core-buster.conf
> @@ -12,5 +12,6 @@
>  require conf/distro/debian-buster.conf
>  require cip-core-common.inc
>  
> +PREFERRED_VERSION_swupdate ?= "2021.11%"

Err, the subject says that buster is also using 2022.12. Confused.

>  PREFERRED_VERSION_linux-cip ?= "4.19.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
> new file mode 100644
> index 0000000..a2377bb
> --- /dev/null
> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
> @@ -0,0 +1,3 @@
> +Package: dh-nodejs
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 29b7dd6..1528b09 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -17,6 +17,7 @@ header:
>  local_conf_header:
>    image-option-swupdate: |
>      CIP_IMAGE_OPTIONS:append = " swupdate.inc"
> +    OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
>      IMAGE_TYPEDEP:wic += "squashfs"
> diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
> new file mode 100644
> index 0000000..0be5a71
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.patch
> @@ -0,0 +1,30 @@
> +From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 3 May 2023 16:02:37 +0200
> +Subject: [PATCH] d/rules: Add option for suricatta_lua
> +
> +This allows to use lua plugins as suricatta backends. It is optional
> +as it overrides the default HAWKBIT backend.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index 57da4ca7..91106fbd 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -56,6 +56,9 @@ endif
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
> + endif
> ++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
> ++endif
> + ifneq (,$(LUA_VERSION))
> + 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
> + 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
> +-- 
> +2.39.2
> +
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> new file mode 100644
> index 0000000..f5478a3
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> @@ -0,0 +1,35 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-gbp
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
> +SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
> +SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
> +
> +# deactivate signing and hardware compability for simple a/b rootfs update
> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> +DEB_BUILD_PROFILES:append:suricatta-lua = " pkg.swupdate.suricattalua"
> +
> +# Disable cross for arm and arm64 on bullseye
> +ISAR_CROSS_COMPILE:bullseye = "0"

Why that?

> +
> +# add cross build and deactivate testing for arm based builds

Does this comment apply to both lines above?

> +DEB_BUILD_PROFILES += "cross nocheck"
> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"

Or what does the last line?

> +

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


