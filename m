Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB19C77B7F
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 13:26:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.84])
 by mx.groups.io with SMTP id smtpd.web11.58907.1683811560696313511
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 May 2023 06:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=v3GUjZ0i;
 spf=pass (domain: siemens.com, ip: 40.107.20.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVbt6VWX5O+xJYLB9cViSp2K9Yvsjj8JHbmdaM9CEVqlsmKSLjKQTATPmGgi5aqgWfJYs0mNftFIN31R1lxi/KkDssqIcw1Ej0jWYP8t4HPMctaT7NqOyI9+GKIbVpxMQW7vZWtfzuqEMn5PPHT8u83OmJlhyZp/u3E4rcanRe2irQfmjBkWSV3J6ZilzIHJEXLFJasIIl9VG2AoyTdgNtQVppZpdIw72LbY4luiHXqAPYhWyrdotbyJV9MubKo1GKo8Lq1FnH1B/0FazJdmq1rkeIYNYvfHeLPxnCwL8VFxSl+GXWGeoIJCDtBsyz1rVPVbrQixXUJigl73eP92DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/n7xW/TSkbILlU2qUSkqBlnvpTKZD+nBnDGkoTu39I=;
 b=f55+PosTGOIiLzI/X/2TICGXNfnwDNAU237QWGcAgDd9itZTArT2SO7MHKMoEywdG792JKfw9/WL3Xa4FdCE15gprGSyksLGe85fPf7DXTOR2rRQBoJSXsG7TLpz30ckDWa/62JGk/AeumavUjiZoABif+zFXBz+hwkBMULGJok13IsXauiMlJOeMYuQm2HxuQLw8tNc+kqUzuHKrUAbXiIneWtxCWvqSycAG2qjHOQ6RqDoRXKSsvH8PRFWZhXUqYA9EJEI8vTXKW+Stk8ef5NVBDPFDZG6Rx9MzgVlJBLiNV6zhlvDlxIT7rQLskaeA3+voqmOBcv+C4SF+RbaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/n7xW/TSkbILlU2qUSkqBlnvpTKZD+nBnDGkoTu39I=;
 b=v3GUjZ0icuNOH5pt4vw5c3D3wMNimdOhgySs4bGVX3hN2RCnb6ztk6czWXl8fx0/keoon/0ESWQ8rnZJBy6ObQldtfV8l6FoRErvwIvB8AiyZMbwItcgUI3QcCSVLfR4Jbh18SqNBtr8CIfR3ndkPOoUfjo7NQ5FjRYV8qMA4U4ThHwF9Q1KL4ht/46CYCUaje2FzbRYeU9mv8K3wcqMqCFAzXmTMdnrEw4XqXzZeFYuXEeT92gihDaL6OYETvdJLnUzKfFdDqvEP9Q+ugI7547tDb85BVvmJbb8kNFpjTuc5sdTbgweMoxh2jVtId4tYD6p+ChffjsW+j3OWgu8aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS1PR10MB5506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 13:25:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 13:25:57 +0000
Message-ID: <2891ecd5-5762-d806-584a-2703f87a6f90@siemens.com>
Date: Thu, 11 May 2023 15:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Add recipe for 2022.12
 for bullseye and buster
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230510152730.4060989-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230510152730.4060989-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS1PR10MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: d0efa91d-a9dd-4c46-c6bd-08db522340dd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0dRrVszX/LLGCUlVd/MLJKOb9WIY73yodrx23oRRmWbmsJaiUX8wfoA0/oDYAam5qacD1WABWyPuosUCm6a/RVOvFjBuqpK9necSHRPZyYxwFRy0fsgVYzkUZ479MCsklld0XtjFKGbgA3ri4oNkN/TAqmI/I9GM/lsVDD7U7cl/aib+4PGNJcA95HP8WxgmglJ1cGZ/QFG1dSHDFij8KWJIRbjvnuGETmVYRuLzUcVdUUUOaANPIz9riOx6t7BLg0o1RqOiVNRUuZoU/dOf1a+Gbtk5jaqE0ZAsUIngtYsBMwOZj2a29o/5Lvw9UBZkBp94A6sEN11xE0s9lXvPpPfyPPuGcMcx95lnFf4m1aZndor8WykH7NyHFGw7fxhLR4feZdNJsLHT5rDoUf6PD4ZeVbMDr+QVQ34G+n/EUoqH+xLTnCQAEMhiGCLtaFdaWPMgsaA9+A5F+GkVtOV07kUJFHsbXALv6AeMCbGhEIzoIvO9NCbDMFgc2/foyJSE34AvQpz7L8FqP2jcWMt6xAnFvC7Fvxb/vsrOaIth+Df4MqnBn/ePr/8cUc6n/lI8Ysg1ihB7ulXbPeOYmkLt6fcvVBykdtbuL/AW5EbP5xdqSj4/xteIwekW1HLjtqNlb0Hw9e4+86ItKDUTixeqTw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(66899021)(31686004)(66476007)(6486002)(316002)(478600001)(66946007)(66556008)(6666004)(36756003)(86362001)(31696002)(53546011)(83380400001)(6506007)(26005)(6512007)(2616005)(44832011)(5660300002)(41300700001)(8936002)(2906002)(38100700002)(186003)(8676002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2JON1dGSEZqYzA2TGI0dFhFNmx0UElVODBTMGsvVzRxK2tHa2ZjTHVsSU1X?=
 =?utf-8?B?ejJxUlJtLzczQXVFQURpN0NtWjlxUkJ6RE13VUIxVDhBYnpYb245cWFsSmhw?=
 =?utf-8?B?YmZRYlZZNlRFMkMyTTN4Nkh2NGN1MG9VME5wMUFtK2tkYm1PRlN0OGNCbEtu?=
 =?utf-8?B?UEc2dXBneERRcjJQeVBnVm8vbnlzV05LWkp2aFRtbCt3NHAzTk1sOWtXV21p?=
 =?utf-8?B?NkJ5SlFBQ1hLWG5iaXJhS1dDaXhPcnFWR1k2VXhTcG9lNURzeUcycllZYnho?=
 =?utf-8?B?YktNaG5NeTBGd2JQeVJBWHZyMWtDSDBBRnZCZlBGY2ZQeUxrR0M2eEMzdG5Q?=
 =?utf-8?B?Q2JnUmtVSHFjYlpPbkdzcTdhd0FxZ3Q2NVNvTXk0TlJxOUUya1o5NFR6SE1h?=
 =?utf-8?B?WHN2V3RYYmNCREkrOFNLalZWNllxRi9NTXFMSDBkR1I3S0dhcmRzU0tOQ2NZ?=
 =?utf-8?B?bVI5Q0N0WnZvdks3UFdVWGdnblM3allrUEZCVlV5NFVER3RmV0dSNklQR0Ni?=
 =?utf-8?B?YkJPbTloMFJSZ3JkamNadDlEdUJMd1BkaXdLKy8vbTZsVi9yZWxxbEh3eUlH?=
 =?utf-8?B?cWJQRWhzUURLcmU0NEZFN2IrVDNJSTR0V1VpbE5QRXNDUE5SUXJMNUh5d09J?=
 =?utf-8?B?dXl4NWdOUmp2WndIRUpDa21qbDN4eDFCS2JyK2dlQmVnV1pGZFp5UWd3N1Rh?=
 =?utf-8?B?Q1ZjcWw0TVBvS2RqVUFzZWFSQ29FdkNoUFhZbGQ2YVR3SE5jVlYxbXlTdmF6?=
 =?utf-8?B?SmRqN0FLbVhwTnBjazhOamZxTVNmNkpBbEV0bUc3MnV4bDJhUWJJb3ZGV1JM?=
 =?utf-8?B?M1M3cmdXQU1MZWthL1dTeDFSeFlVclBPcGpWc0tGa1J6VzVId1A4Wnh5WDJN?=
 =?utf-8?B?eGxncFdua3I4ZGhCTStvVFZZUURGVi9QK1V1QTl1cUd6M3Axd3VhbEpraDhW?=
 =?utf-8?B?b3VJT2NEYStTdTBRRXBIS05XVVlML1ZXeldTbTZBU2pXQVVmdXU5MTVCdU5q?=
 =?utf-8?B?U2djSjBqbzVITnhqMDRMbjlsMlI4b0JqTWJvQ3RTMVJPcEdSOFdTWWF5MTdz?=
 =?utf-8?B?dDZnWk1Kc0tMM0lhazlzSnFBVGE3bnhTbmZDK3NQWG4zMGZxYVlOTllscVpN?=
 =?utf-8?B?Q2NQS3QyWmJaRXluZTMvbWlOODNUUG9nVTJ3YUtkMW9Yc2k0Q0diUDlXRWU4?=
 =?utf-8?B?S0ZHcnl5WVR4K2tDdGtmdWZIVm1CNDlUQXJaUWlmWi9EZlVsSTYwSGRuVDVN?=
 =?utf-8?B?YWd2blI5WWYyLzNOUWk4TXg5NFRGNVh2QU1wTy9xVXkvUXdYYnpZVytqT0c3?=
 =?utf-8?B?M3MvRktnS0U1MWNGdzhsTXdpSnh5WHRtQ0RUZ1k3YXFBV3ZuU0Z6OVZWUHQ4?=
 =?utf-8?B?bStGTkRJZmg4aExnQ1lXeHhuSDg4OGUrak50RG5jeGhFc3pvNEVMUlcrejFi?=
 =?utf-8?B?aTdnNXFrR1FhU2MzWUpoWEh5UVU1dUVINzRRZkZyNUdzaHJxZ2V5RmUwd3hs?=
 =?utf-8?B?Zlp6M3Z3N0xRWUwvbHo1TUwxK21obG83bXhuRG5LY2cyUVVFdVppTDFDeU1K?=
 =?utf-8?B?TGhpaVE0bFpXWjBCVER5SjE4Nyt1ZEMrcnlpVTlLTHNvalpKVHRvdGhGejJ4?=
 =?utf-8?B?eGc1R1JkTlozSjc1YVZaQzl0bUpYREhUK08wdjQyM1lRSzFjWEltOVlIWTJL?=
 =?utf-8?B?ck10c3M2N056WDlpQXpYSGMxR2tUVEp1aHpJSE9LU1V6ZVA1eDZPelF5VTRN?=
 =?utf-8?B?Vm9PcWQyTGk0K3VoNC9mbVJDclJQNUJWWUtWZ2RueVpvc1J6RXRVQ1huRllP?=
 =?utf-8?B?MGQ3WkpUYjA1eEpHWmtsM1FRVGg3dS93WjEyZmNvZXhTMkl3TlU2d2lBSVVk?=
 =?utf-8?B?eFJ1TXhUZ2h0U09yRHFvL3orVnI5d0dicEhqbTVjNmw3eXYwWC91SjhtNGxE?=
 =?utf-8?B?UUtlUW9HTVA3S1NRUExLSVlHT1VhMThlOFBNSDgwS1hVajJwMWxDcy9PMFFK?=
 =?utf-8?B?ZVJLYlBtNVpqSHMxMUVncStrWGNKQ3RFQ1ZuTzA0aGJ6cDRLYzEyWW1QK0dD?=
 =?utf-8?B?TTljRWxYd0dFWXZLMHhKemFGUVVkKzg5UFQ5OHVwZGhTRUgvUEI4T0lFNGhp?=
 =?utf-8?B?UTQrMEJMTGg2UnlkWUpKblFENlBDNUxUVEo2Ny9JMTRFYnZSem1oTUVCVkw5?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0efa91d-a9dd-4c46-c6bd-08db522340dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:25:57.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLeWGYmZREt9hYaZ8ruN8By8MQKxDWXbAqicTHxvyThZgnToK6+RpScevF5Zp/NP5vLIW/5B7tiLFPY/98rftQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5506
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 May 2023 13:26:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11438

On 10.05.23 17:27, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows modified swupdate builds in cip-core. It also
> adds the option to use suricatta-lua instead of the default
> suricatta-hawkbit to communicate with a webserver.

What is the reason for switching to suricatte-lua? And if that is an
option, how to select it?

Jan

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
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
> +DEB_BUILD_PROFILES:append:suricatta-lua = "pkg.swupdate.suricattalua"
> +
> +# Disable cross for arm and arm64 on bullseye
> +ISAR_CROSS_COMPILE:bullseye = "0"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> +

-- 
Siemens AG, Technology
Competence Center Embedded Linux


