Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFCEB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 16:58:49 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.81])
 by mx.groups.io with SMTP id smtpd.web11.3855.1686934719376324585
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jun 2023 09:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TZZb3IKo;
 spf=pass (domain: siemens.com, ip: 40.107.7.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSiOnlFjzfGwin4c03ApYXsKmsGLeHC+0JJ1XLU0uIQH7uXbkMeMZ7MnkelG22Yml60Q7niyyGOsRIRfijtdf2BIp/Qer3ltDdPysIrIxvtT4MF+leNAuUUzFJmkF0b0HCmjVv++XCxnTdFwBGtbGGgI+jleoqGNvP9usBf4yOI39CBENT7KnPZArq3U9GaJl0uUOrssyFG5mWAtd0H2WG/nziYnqodgGQMBh7P2nlMYDYwbMonq4YTnzdp8AUec1mjWb9K1qOggiRmAKVIj9TM8x5XyEkodOv6eVItIao+2yEn8nFc9aduhyHBZtVO4+QGnajaRcn6iI9M5BJacTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4BjV47OK3qTboWMsAVurM92P9VOGzJn4bGGWkfGDaY=;
 b=dVS0giBkEC9uJ8XCEYAhe6NqYjpjZwRCLfo3eIfP+eqH9zPHkp8b9vySG9ugDREon9anJjAIYNPB409HpCWENggYTM9ybHNr9j+VIygkANMHP+aTL5h0OotZKG0J3YPSR1r4LizxfEUJJYPTwYncmifU48IT9yxjKPuesdpYv2MmLbDlb49Eua/k7MQx5+B6I+Rooe8JCdRwyKWsN5l2C8yvLHBwwIb/DYMfr2omaLxO1YjyE8NtVJn/RLM+SQyDho3/uUTypwGT4aihuQyT7l4Y6jLefMGzsjiy9uHOtrZB9RX4M0X0PdrUpH/EkAtqdQWNFXp94fs4vjBr6GNwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4BjV47OK3qTboWMsAVurM92P9VOGzJn4bGGWkfGDaY=;
 b=TZZb3IKo1rl7yQBiWQe4Ro1BjblmfQiF7UHsyzbzNM7QCIN7b+pvOwgVNN3gQG6+oXszu5RzhFqP/mTQ/j8kBC7Gb4Mn/on48vNTXMhEYeenfa1LYwzJjKagjPJ8U7NJqiMDhO64kcGqwBYMk5mqtRtT+0BSmzFGi0AyQeYdk6+iup8CjO64CL7GfJiD8Ht/lvSuDL2UHs6aFMcbV8geYfad/4jMGOUDq7gWU+Ftj9r6SGyFxTioH2Wt42O6JlbA6GqbL/5CKpiEdzO8ROA6yV4oxUqS8LFYf9afczgOhl0dlzJStoczSSABx5OLWQLr2hGJI95AxMaWv81HaMHEKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 16:58:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 16:58:34 +0000
Message-ID: <f224ba10-ef4b-8ce6-a613-63bebae3c3a7@siemens.com>
Date: Fri, 16 Jun 2023 18:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update to 2023.06 for
 wfx support
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 christian.storm@siemens.com, cip-dev@lists.cip-project.org
References: <20230616164738.3895223-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230616164738.3895223-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aab7bd6-6347-401f-aad2-08db6e8aebca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M78bHinL1VTXObMFEACLBohh5I3DJNLf2oadtTeNLwKRNgjKC27xikWTcdsM7FauDKZOZTDK5t0u7YRem4xuVzb3g9RWE46+7pnyZlM71ys/BCMqndtLtvVa7Nu66HrlE1rW73ClX4JL5ZRepkQnhw7nBpPB7Q7GZiLvnqXGaJ5SQO0HOLO6SBOs0sanceRFq3872BTXpjE0KvTMto+cp8v6bGwcS1KVgR5BTdFEQbB0PgVK8sFJyb+Ed3WwSeCOqgOR44h0+seVBJrr0CR4ws2gp7tWkXfDxwW1u5Yjlbo1dcvoxjEwAMx+URD9S8swdrNeuk6E0Y/J+N9unQS2ROHt2DBXmHS249ooUOp+LnmyyyYfpMDjp0KI4qqZC7zZYRaorJ2+bj8O674xMgya0Nn8TcfzctIBUQWISH7udFZ6bt2Ct7zvEVTx1QVSFVrrypnnimtTOdadmBa4W1p8XmsHhUL2Bzw8Fw0Fms3qG1Ov0BP8WBaAqH5vz9nR4M6TMHE+f1H7T+utvgclYSFFBuPIXiZEraEjhLaIhfJFzzw+Zo6EnknbxWzGEGUulQvIXzVKPk9/L2yE9inHbuGqO4P1yuDuiLCBlL0tt4sGqKlGsxXINz15BQQgbQOsrQrBm8dJi8Wsg1IfrIuKHeXRRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(31696002)(44832011)(2906002)(86362001)(316002)(66556008)(66476007)(66946007)(41300700001)(66899021)(8936002)(15650500001)(5660300002)(31686004)(8676002)(38100700002)(478600001)(6666004)(6486002)(82960400001)(83380400001)(6506007)(53546011)(6512007)(186003)(26005)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2FMNnJZZjdxSStpTExIemdOQ1ZRZy9nYi80di8wb3YvNTVqcldtVVN2Nkts?=
 =?utf-8?B?aWlrQWdabURWNFhiMXBBQVFRU1htMTBCWGI5MnM3RnNodnpqOWphY0dPUG50?=
 =?utf-8?B?L0FuNFFKRE90VEM3WXJMNWtLeGZTbkdCS0VxNExFd25sOWNDdEtNcnM4ZWVY?=
 =?utf-8?B?R0lVQld0bjFmRDhqdU44T05wb3N3RE9WSjZYN0FJWm9YMSs4ODl4RXBISWtk?=
 =?utf-8?B?RzUvV2dndTF4SG5MUnVSeEphWHorZjlmQUFhOEFiZ3BzV253bU1XeTIyV0c5?=
 =?utf-8?B?clpwYUlMQ3lCRWpOdG9ZNzR1OHhVYWxFVlZPWXRTQkVHOWp6WGpLdmVoUDdI?=
 =?utf-8?B?RDVxNlVPMUlOYXRvOWVCT2dKSVY1T2FsYXdGMEE1T3JXMDArcFB6MHp3NE4r?=
 =?utf-8?B?Vm83cmJXTkg3eUNNTU9jM3ZXa0htZk14K1kyZmpoTExTTHpXOGZ6cmkwdG9N?=
 =?utf-8?B?cy9LaWpRU2kwSnpQaVk4cGF3VGNOWVc1SHo5bXdoZEpqaUIyeEZ5UzlUUEFk?=
 =?utf-8?B?c253K0xpb2VSL0RGT0ZNNmRvSGFJTzFDMGZzclE4T1V5Wmp1U0Nrd3REbVps?=
 =?utf-8?B?OWRUU1BManEyRFhoSC9GaFhPb0JHZUZmZ21WMllHNHlKcEZYZmJST2Y3b2Zm?=
 =?utf-8?B?MnJUSlZObXBFVnhSRkYvTGI4aVBteDRVK0F6T1pBQ0NucjJ3U3lOSzZnSGg1?=
 =?utf-8?B?S3NwVEQ2SmNRakJrQy9uTTMxNG9Kbk9pN0llZUwxMUZjMHhUcXRxN2RYUi9h?=
 =?utf-8?B?T0JJNHBtNU5EbFcvZEZsNFpIaEsybDVEaEUveHpnUEloY3FHWkZjS0ZDVWZB?=
 =?utf-8?B?aG9mZStyNm1JOEUrQnYrcnRhZkVKNUQwMDIvbC9COHhCSWd2T05rYlJpb085?=
 =?utf-8?B?ZTlrS3dPT0RxYWtNMnR1QmNML29vWlpEQ2FXZlhkZ2dBSndZdXpLZXhMRzg3?=
 =?utf-8?B?WkIwQS9hTXRVc3BGeVVqcFpTNXlJdk5sZkNqbHRQcXA2Q3FTbGFhMVdEempE?=
 =?utf-8?B?VnlNUzMwdzZvdzB2MFJWbW1mMWFKRTlJbUtpTUtzRFNaV2QrODU4ZS96c2Vv?=
 =?utf-8?B?SFRZYVUwTml6RTQ0ZVl0ZnFyeGZJUmx1eEY5TFpDOWJYZzI2WHFQZmg2RHQ0?=
 =?utf-8?B?dHg3TlAvYmJnUjJyNnlPVmpIUE5zZDJjU3BkZFAzd1l5NXBKWmR4eWp6aW5p?=
 =?utf-8?B?Rk5VMHhUdkIzdGJxRmYySUFsa3BEcVgyRm91Z2hFSGZKcFNXUm5DanV1cC81?=
 =?utf-8?B?RVBpNVR3Nml4SVM0MXh6QU8weUh1Z0dnbGtYQW1EUnZQQ3o4ZVlZdW5qN3hi?=
 =?utf-8?B?SEdBalI3YVpnd3REMko5V2RYTW9UemJ0NTJoWVRDYlEwMTNuaTlNVHpINC9J?=
 =?utf-8?B?b0Vtc0pHVzJzK1MwYzlWUW5TQlJVbG52ZXNKZUt0ZjdpTjhlakZxTlJKUzFF?=
 =?utf-8?B?L0ZaVVVjcDhoc3g2SEdkaGR3ZDRuUHVsYm1yLzFQNHJVb3lUejRuODVlTm4w?=
 =?utf-8?B?dWtvakpoSndYbFZSZzBLTVljd2xRbEtueFNiZUoyaFFtTWsxekpsU0RnVTNo?=
 =?utf-8?B?dkZhNGNpWmNid1hxbEN3SXAvcVdHUE5XVGI5R2ErRG81TjNBKzhvM0ovaU5E?=
 =?utf-8?B?TXh4enRNZE4vMUVvYmFodzU0L2cyOXF2REgvMzd2TG1HY2dKakZUc1RlYzgy?=
 =?utf-8?B?T0NWMXdkY25kRzFLU2ZOd0dFbUJLUmhmS0VaeVJ0QnFyeGJOMHFIUkdwNWo2?=
 =?utf-8?B?Sk9IVDF3OE5ybU03bG9vV0N1RDJYRGg4ZXJVaXo3N05yd3FiWXlBVHAxbUdp?=
 =?utf-8?B?WVFWV3RlQVd4SE5rWTFXeFh6cHdCMWdaVi9PQjJleC8rcFZGM0YxNlNLRWR0?=
 =?utf-8?B?NjFqbDBNYTZkR0RsYytRZmtVNTh0UWlpWW5SZzkxMmlzcXdGRlZXZVlvVDRr?=
 =?utf-8?B?aVNkQXo1dmY3RWJUSTRiTUo0cDMwM3puV2pxYWp1V2JhQTZjYlBaMWZzaGw3?=
 =?utf-8?B?TlY2Y1ZoZVJ4VWtYQUdUUS9kOWl1UnlQLzc1WDkyVy9kL3Q4QXV3UDVtYVEv?=
 =?utf-8?B?ZlppL0UyVmVZNkRJaHVpUkpzMGR6cjhUcVRxQVQ0aVV6bm1TaGJhMjZSYzZB?=
 =?utf-8?B?OVlZS2o5WktOd2lvbFNEazBRUkxQS1ZiWHI1c2QySnp6UTA5RnVzK3JSQkZI?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab7bd6-6347-401f-aad2-08db6e8aebca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:58:34.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5/dpnF78MN1K+CbRDY7SHgAW7MoY0MJ0GyYwrML67u03ZaEdIXwJfpALG8LjJyfUR+KxdLxFRyQUSO2kTonfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jun 2023 16:58:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12068

On 16.06.23 18:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
> (tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-bookworm.conf            |  2 +-
>  conf/distro/cip-core-bullseye.conf            |  2 +-
>  conf/distro/cip-core-sid-ports.conf           |  1 +
>  recipes-core/images/swupdate.inc              |  5 +-
>  ...rate-build_profile-option-for-delta-.patch | 47 +++++++++++++++++++
>  ...2.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} | 21 +++++++--
>  6 files changed, 67 insertions(+), 11 deletions(-)
>  create mode 100644 recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>  rename recipes-core/swupdate/{swupdate_2022.12+dfsg-4-gbp.bb => swupdate_2023.06.bb} (55%)
> 
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> index f05d3d3..5563e49 100644
> --- a/conf/distro/cip-core-bookworm.conf
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -12,6 +12,6 @@
>  require conf/distro/debian-bookworm.conf
>  require cip-core-common.inc
>  
> -PREFERRED_VERSION_swupdate ?= "2022.12%"
> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
> index 9c83054..604280d 100644
> --- a/conf/distro/cip-core-bullseye.conf
> +++ b/conf/distro/cip-core-bullseye.conf
> @@ -15,6 +15,6 @@ require cip-core-common.inc
>  DISTRO_APT_SOURCES:append:swupdate = " conf/distro/debian-bullseye-backports.list"
>  DISTRO_APT_PREFERENCES:append:swupdate = " conf/distro/preferences.swupdate-bullseye-backports.conf"
>  
> -PREFERRED_VERSION_swupdate ?= "2022.12%"
> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
> index edd3c28..2f02367 100644
> --- a/conf/distro/cip-core-sid-ports.conf
> +++ b/conf/distro/cip-core-sid-ports.conf
> @@ -14,6 +14,7 @@ require cip-core-common.inc
>  
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> +PREFERRED_VERSION_swupdate ?= "2023.06%"
>  
>  DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-ports-snapshot.list"
>  HOST_DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list ${DISTRO_APT_SOURCES}"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index ebc844a..6a01abb 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,9 +12,6 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> -IMAGE_INSTALL:append:buster = " swupdate"
> -IMAGE_INSTALL:append:bullseye = " swupdate"
> -IMAGE_PREINSTALL:append:bookworm = " swupdate"
> -IMAGE_PREINSTALL:append:sid = " swupdate"
> +IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> new file mode 100644
> index 0000000..2a6f2e0
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> @@ -0,0 +1,47 @@
> +From 5e29e0929e37a6ab6aaad1b44280f1bb0d9a4fbe Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 15 Jun 2023 18:48:25 +0200
> +Subject: [PATCH] d/rules: Add seperate build_profile option for delta update
> +
> +Delta update need zchunk 1.3 to work on memory restricted
> +devices. zchunk 1.3 is is not available in bullseye-backports
> +and Debian bookworm(12).
> +
> +To enable delta updates add 'pkg.swupdate.delta' to
> +DEB_BUILD_PROFILES.

So this will disable delta update for now - but it was subtly broken so
far, right? Should be noted in the commit message.

> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/control | 2 +-
> + debian/rules   | 2 +-
> + 2 files changed, 2 insertions(+), 2 deletions(-)
> +
> +diff --git a/debian/control b/debian/control
> +index e47c320c..d4b17972 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
> +                uuid-dev,
> +                zlib1g-dev,
> +                libzstd-dev,
> +-               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
> ++               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
> +                libp11-kit-dev <pkg.swupdate.p11>,
> +                libwolfssl-dev <pkg.swupdate.p11>,
> +                libmtd-dev [linux-any],
> +diff --git a/debian/rules b/debian/rules
> +index 57da4ca7..1c8d12e4 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
> + else
> + 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
> + endif
> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> ++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_DELTA=y >> configs/debian_defconfig
> + endif
> + ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
> +-- 
> +2.39.2
> +
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2023.06.bb
> similarity index 55%
> rename from recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> rename to recipes-core/swupdate/swupdate_2023.06.bb
> index da44ae5..26aced4 100644
> --- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2023.06.bb
> @@ -8,7 +8,7 @@
>  #
>  # SPDX-License-Identifier: MIT
>  
> -inherit dpkg-gbp
> +inherit dpkg
>  
>  require swupdate.inc
>  
> @@ -17,16 +17,19 @@ DEPENDS += "libebgenv-dev"
>  DEB_BUILD_PROFILES += "nodoc"
>  DEB_BUILD_OPTIONS += "nodoc"
>  
> -SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
> -SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
> +SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
> +SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
> +SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
> +SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
>  SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
> +SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
>  
>  # deactivate signing and hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
> -# use suricatta-lua instead of suricatta-hawkbit
> -# DEB_BUILD_PROFILES = "pkg.swupdate.suricattalua"
> +# Add suricattalua to support wfx

Maybe add ", disable to use suricatta-hawkbit"? Or did the logic change
to support both?

> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>  
>  # Disable cross for arm and arm64 on bullseye
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
> @@ -37,3 +40,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
>  
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> +
> +CHANGELOG_V ?= "${PV}-1+cip"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}

Which change fixes the missing version string in previous recipe?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


