Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD99C77B7D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 06:19:27 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.88])
 by mx.groups.io with SMTP id smtpd.web11.43369.1684304359982268915
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 23:19:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QanUkAZw;
 spf=pass (domain: siemens.com, ip: 40.107.241.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoSt6KoFHji0PvhItJlNVB5SFdksbNXDi6zOlcWXfGH/gTx1IkKmCYksW9XZx5pvmfrrz4jvvtavIqOUWhBRkKPRvqY+3NywgNZa1e/5ZLVS5rqplPxfCn5wgM0e76JwtGyRz92U3BTBeUmAe0BKpEW4cDZADkDzqRlaOVWo/vKMzbWU64Zaubm+5MLujecfEl5WCX4c0lGk5944I7MtHKefOVNUWeluPX7OX76nSPFdDQMvXGGAdGz+mXtC/4LOqGW7NBk6hJDpky0JdlTo3stqo52jOyuQ/g+fycc8pz7pWTDHv8ErMxMUZwC1bSOmPH2/8Dhdu5NLjyBYWBTrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz80YRaw10xgJgHqsq/DfZiz2Sb4s1/O0zleTXncGww=;
 b=FNNOaDdydtBrNemcE5vGnxadJg9CSfRHYPw+mjVhj6982UwRE9/DBCeYDZ6/LP8JPffmiGNeVBosh3fBX//7XKFj+gAlMokiri9FU0MpzMyOglz0Iq7nOgdN61tXGMMG+mLWcD/A4xPx/9yf7DpSnUzGCMB5AxWFPt3pPBKdyUYkltkPUHzxdxel/6D1rvqKdqXOf1JBCRu65vUgIlU037d/B5tyeasuLUrN9/HKlogoO3rytGMTz9gfFlRF53Rqu96OsW/0edAgC6mBrSRRnXqfJaxW+4gF/wUtLHIzEDQQfO4ockYeQJ/QCGkSzAbRR9VQnHt3gCwckfOeM1BkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz80YRaw10xgJgHqsq/DfZiz2Sb4s1/O0zleTXncGww=;
 b=QanUkAZwMWbwMHwbi7oM5be28/F6EceQtAV5iaqqB3OeBxm+p0XJfzl3DDNAVd0fAI/d1stbTw1zgMDUtMptoyWRLrYjcPNt+9bVyFE/m9jM7mE91rJyubJm4VcO6MD0AFAfvRTYUaYfGvUMoG4V6foCDt2wCjkz36wA7sDDCT/MiQwas/9yON1vBTKplOhy6Ru9F4Fn9r25p6ePK1tvXelmq9p44/TL6wAtNs0toHsITBqjreNGfsYdKuqcb2woNtsHW0htrsbfxmeS/mDQoLpKBU5+rfkq5T7OEgLuUjtTwV9EWHfXZmJXQPJ4aj2nTG/sXyRGnwjScgQ1GwPOJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 06:19:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 06:19:15 +0000
Message-ID: <a7ed2afe-c2b8-f1aa-4fc1-9151babe8e12@siemens.com>
Date: Wed, 17 May 2023 08:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] swupdate: Add recipe for
 2022.12 for bullseye and bookworm
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230515141430.13315-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230515141430.13315-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3601:EE_
X-MS-Office365-Filtering-Correlation-Id: 75de4fed-af54-4b3f-b564-08db569ea3b2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	On0whH7CEpeolrK99ZvlqWOFOPvT6wklJV/t63rpxDoNcMu6+VhfV82JvIzmw14BpJXc++843eOm27NnhcUrXBOadVS1mq6T04Xpf3T8DU7lMI9Pzn917u0l6mCfuMeGIuueOT40kABkFcWCflP6v9NGfl22NFt5Zvylsveqg9BJZIA92xr9ONSnOLN2ISz8B1btAfME70LRS+9aAKYpLbNGdOBB6ivRMVBsAfiywHE8GqCKl2wxvziSRrK9YLXicY/Kcmzun9fn2o4UduCbMX84TchnzF7WTkuQruJpsighwNbM9bdj6dJnRX4X5n//CsY9WDldhykZOXfrIO8OsfdcrD6nDj8pvYOl03+BH0pkOODnzFRy/hfZGIoWNP69+cBhmp232sY3Gk4Lvak+F8Yz53SNloutEna3pRo5rwWlZsswdK1tlCn2PKJ8IjiULFYLVU+jXQ7R0LbR3k5Vk+kQhKEsImAnlHZvdL+F+sxq929ytwbaSEfP+Cqv6oC9tYJftCCP0j4d3lt/77DnFBV3Vei1Vc+FcSu3SejkuXqo3eNm5WN4wkPFxj4s9bLBtdHSze/fFsrNFg7z/j1iN4DrNQS+GJRVm8dLUEfSOZI72XVTt/B7GFfJkjK2mJsrxpTFFOpxWLon/p6Ot5NBpA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(31686004)(66899021)(82960400001)(41300700001)(8676002)(2906002)(8936002)(36756003)(5660300002)(31696002)(86362001)(316002)(38100700002)(66476007)(66556008)(66946007)(83380400001)(53546011)(6512007)(6506007)(26005)(186003)(44832011)(478600001)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVhBQ1dCQWNCQ2N1eHl6dXR2WlNwUE1JOGt1NlA3UHhxMStnK1BGd3A3Mk1o?=
 =?utf-8?B?TS9iN2w0TnN2cnBZKzQzNjdVY0NKS1JPckZTNEVxVDdTeDE5MG81aEFOcVBp?=
 =?utf-8?B?WXUvU2VUb010UG9BaEp1bmVDdW5ld1FMaEh1NERZYUx1Z0szK0ovd2lCU1V5?=
 =?utf-8?B?RzhIdmZUMnJPRE9oS2xva3lPcmYzZjNrY3djdGgvWGZ5Q24rZmtRU3prWlF4?=
 =?utf-8?B?a0pHa0FpdDBoWUNHNTNzVTJaL0lYNEdOM3EyMlVVTUNoQ0FPNjlVSDhqNk5T?=
 =?utf-8?B?c2orRFRxNU1COHRxYUdGaDFXMkZvakhZalBPUm00VlpjTU1hSkRJVXNuRTBz?=
 =?utf-8?B?aW52b0Y5RXZQQkYzcGxqWWNwU1V4VlF0bXd4c25pcTRoakxzcE9neHo2K1Y4?=
 =?utf-8?B?OHNFSWVPT3YrWHJnR1VvVDFYaFkwTTBFSGUvRkQ4ZEVzdnlsWThWVUxiZjI5?=
 =?utf-8?B?Qk9RRnlpaFFGZHBKdExVamp1THBIQW1tdEVLdThYS2ErbG9XN25IMzM4M0V4?=
 =?utf-8?B?Z2FldzNRQ0kyTHV1NDh1ejNhZjZKZ2daMDFHdkplUTdGV2l3dWdHZzhEdTlt?=
 =?utf-8?B?YlloTVc2eGVoa25MbmlaV2hnOU9sVmsra25qaEFndFVhUlFnWnZNRjZtU0kr?=
 =?utf-8?B?bnF5ZllNOExhVFFSUTZ5T1lIMmJaekFnSlByZCtSNEtVUUdmWlVvWkZXYjZr?=
 =?utf-8?B?eGpxOVFKQVBBNVlHZklrS1RYWTZtTmhsUFQ0QTJ6cmVaOE16WG9ORjAzSTIw?=
 =?utf-8?B?Q2xiK2pCUHYyREN6T2p4M0V5cHAvSnU1ZkdPZmVvNEw4Y1NaMHAwWHdCYUJE?=
 =?utf-8?B?UGdveDNGbjdCc2ZZRzE3VnU3N3NadW9WLzNTbE5adGt6WW1lMTEzTmRKUjhn?=
 =?utf-8?B?MWRWVDRuTGlxTFVDVjBudmd3MVplSEQ3Z3pLYXd6K1liRUYvVHVzL3UwODdW?=
 =?utf-8?B?K1FYUWRSbmMwelNzbFNDRE1VU3JmcXl5L2RrRWVFNnlzTmJPMGF2UHZQL1BR?=
 =?utf-8?B?a0d0RzBvWk92TGNhdGRyVE9FVjlsaitjdllEWkYxOWRMcWt5RFhvSWI1Z2hh?=
 =?utf-8?B?SmdQR1ZpUk1xQlY3Z2FMMFU2Y09hbzUwbW94VTFlRFRDTzJvL25vWWhRS05y?=
 =?utf-8?B?Sm54dTBDTnpQbm9ISWVWeStUQUU5RHI2NUI3VEgxMkl6dUV1SHdCOWNtQ2g0?=
 =?utf-8?B?QlB3OXBYdm1JU3E4SFd0dU80cUY1TXFZOXAzVGZ3M0Y1cDlSUUxyVUpDclo3?=
 =?utf-8?B?MHFtV0h0eUlUeXRORnFhUm1NSlF3dWp4NGdXYXBuNVg1VXl5bGc2NndhRGlh?=
 =?utf-8?B?OXp1dDd1Q3NwUDVSbTNxTm94N3loTmRwV1dNeWZnbnFCaTlYWEJDanNoTjd4?=
 =?utf-8?B?c1FZc29WenFaS05tS2dBTGF3VloxY0tlY05BakVkSW1HZ0xXYTAxMXpvWEND?=
 =?utf-8?B?ODY2NU1ZL1MxOWRZOW12dmxFb0t4ZGxlWDVwcWtCYkUwZGF5eU1kN0Jkbk1r?=
 =?utf-8?B?cFBuei9QSEd4Mm5XUytpY1dXcUtnZGlETzNjSTA5dlp6UDZtSWZTYnpUc0Zn?=
 =?utf-8?B?YU9ab29VUWdWVUlaWlp5S1BXYUkreEh3UHhKS2ZCQTd0bU1KZTNHZlYxbDYx?=
 =?utf-8?B?Q21YRTJGVUQxdjZDS3BlekU5Z0ZhS1N5SEprSnhUVXdkeUdUK0VMT3FFUWhm?=
 =?utf-8?B?aHY2TUl2UDhnZWFnSEhJc3lmQzI2Tktld1Ardm5TRE1jTkxSUUFKcFNnSUNa?=
 =?utf-8?B?T2J3R0FXWW1Wb3ZzSU1CK2Rub2FRSmErTEpRdmkrdHk3dEUwTlNmT2NGT2Ju?=
 =?utf-8?B?ZlNvT1FtV2pXVnBXQUdMdE9ObUFVNitudjFLQStwT2Mwd0drSnNTVmo2ckJG?=
 =?utf-8?B?OUVXMFFoNHoxVE94eW91enFmK05TcnBXT2FZVWFsdDVMTlZ3OGphRWlSZ210?=
 =?utf-8?B?a3ozK0luMWNFdVJkZ210V3Frb3IyNFdHZmhQQ3JDMjRQU3p4SEo5UnR2TzJk?=
 =?utf-8?B?dU0vbFRHZVpkUXJXblRIUUxiMWFRN29BaWhORnVFNGJKUDU5QmNoNDU5OHZQ?=
 =?utf-8?B?bWFKRGFCZy9mczNzMnc1UUhqZ09QenIweUU2S3BNVVpZTGM5M2lFTnlxc1lS?=
 =?utf-8?Q?d8MaYIqf+wi3+gfHpa+qoezxH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75de4fed-af54-4b3f-b564-08db569ea3b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 06:19:15.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUACzfpkybJ+NfyUh3sOg8580nycOPApnRBwhqDpCR1H3glTF6e7etcNbiKlqXrGnjgIm0OJj4nBo163F4HxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3601
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 06:19:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11482

On 15.05.23 16:14, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows modified swupdate builds in cip-core. It also
> adds the option to use suricatta-lua instead of the default
> suricatta-hawkbit to communicate with a webserver.
> 
> `suricatta-lua` is currently in use for internal projects. Some of these
> projects are planned to be released as open source.
> 
> To enable suricatta-lua add the following line to the swupdate recipe or
> use a bbappend.
> ```
> DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v3:
>  - remove OVERRIDE for suricatta-lua
>  - correct titel of PATCH from buster to bookworm
>  - add description for DEB_BUILD_OPTIONS
> 
> Changes v2:
>  - Add usage of `suricatta-lua` the to commit message
>  - Add missing space to DEB_BUILD_PROFILES
> 
> 
>  conf/distro/cip-core-bookworm.conf            |  1 +
>  conf/distro/cip-core-bullseye.conf            |  4 ++
>  conf/distro/cip-core-buster.conf              |  1 +
>  ...eferences.swupdate-bullseye-backports.conf |  3 ++
>  kas/opt/swupdate.yml                          |  1 +
>  ...d-rules-Add-option-for-suricatta_lua.patch | 30 ++++++++++++++
>  .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   | 40 +++++++++++++++++++
>  7 files changed, 80 insertions(+)
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
> index 0000000..df0b3b2
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> @@ -0,0 +1,40 @@
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
> +
> +# use suricatta-lua instead of suricatta-hawkbit
> +# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
> +
> +# Disable cross for arm and arm64 on bullseye
> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
> +ISAR_CROSS_COMPILE:bullseye = "0"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +
> +# use backport build profile for bullseye
> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> +

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


