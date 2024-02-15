Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70942C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:41:47 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.81])
 by mx.groups.io with SMTP id smtpd.web11.14008.1708004503389305568
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:41:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s5+jJruo;
 spf=pass (domain: siemens.com, ip: 40.107.20.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJPFoyoGB3ifmFsvn0sM04fXRX/TKB7NkwZt6Mez41eLJm1g64iPlY/QYyjzdfRZOj3BZnK9AxsEavFYCSw+NnHKVjH1V8FU0Xty8GZaohM0Ez2sTJtoHhhR6I+9jDXRk6E8CDYe+YMxr+nlZ0+N0vNzDV1oIQmMp9fI9nI1IvMPUHS8F7JPjzWRbwhxUV4rDxJT4DKNFkM7JNSsb9xdSz7jgPGxbboAlt2gFEaoqhEkJCz72UDhvi2cmrg7ypIB5DiAohYX88sh5/x3WCzt1JxTR04BUWieQs2fV2G31+FQZv3Lu1TXszol2CTPq+h1R52NSZ+I0YWHR6UtS+KVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydF1VEzWJzCF9bUmKfXHZIUIHpUprQ0jpeZ3przuvis=;
 b=Vh9IR7RvKhMGDSohH20zEIU4Sc72fWIgwEGQvzX9t5ciZCVAFLIIlQR5gHQlSRMAo3NS/U57dJuVjnFnp2/vaKZuqVo7iZPz34EjMEPmIGgetv6msZsIJ9fCe3DWH+DuaxIxNOHyjCn1k9OF3x2hTyCoXYtGEmJGN3yQX0eRATittGSKUC/jezh7K7DEW5+0f0Cy2zzBD4B9sUqpfe1+5nBMo4OgR1gQ1HTdtIOHgdyu8BWAF+iZBf1sdzxj2Db7jjnQRQkGcaW1dYL+5i38YFUvjyq3U6pJ3DV3VrcE/r8uKWpcRckE7fwDyz08gSbaMqbTfvat5Jq6c2PP8SoMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydF1VEzWJzCF9bUmKfXHZIUIHpUprQ0jpeZ3przuvis=;
 b=s5+jJruo2VfaKRdOZRboEM2V5zO1DlfPOguXlAy/MPRb9TgLoeTjweZ31i0MHPRflCEmImMHgbbVs+VIGAOFa8IAKG1rj7HVDR8Pf/AVykGSQ0upg1yjmf82I2bqAbecSMxkLpaxlLWzuI70rCNHVNGp2hyPkmra9he1ONJbEtYET3x/2kekWqZuqRqt+3XeefjxhqNOFr6ZXzdAPrSoaIgmJg8Uuc27sihlTk1l3sE7iK1OGlNR6bDH+Xat7uzeCgoxiC0SuAO29NXTsJsUfbaPc0+G0cPnTl67iY1G300lyM9e2u5hr9CS94d0fQw1jbgkDA680K1MQSOtg18LUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 13:41:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:41:39 +0000
Message-ID: <8ca05288-d85d-478b-9796-d2bc4092abd1@siemens.com>
Date: Thu, 15 Feb 2024 14:41:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] add SWUpdate 2022.12
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
 <20240215121659.315309-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240215121659.315309-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 438c81f8-67ba-4678-566f-08dc2e2bd65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oqp65BH7w1+orHg1hsOQGhS9uqYu5aHUeF0gaiATKPtaiSk4EbhYj3CdRZL+Fppp1THIZwQWQxy41QoJVgm+G4aEYj02rIvGPQBTg7Wy0vNqpW53sbSbJugk/AFRsvJoorlvxqJBpd52Ana+TeMeWoha9p4j1l0/bPs8tE+HwOZDIbi61GbV3MddUXHmdrFBuVUwMfAt/vy0BByd2Xj/052MhQibhZLuX0KdEyxFOlReybr2xrVByzayPa8A6JlvKNXcZzzXRhC29zvmVLikFAfbgxWYqQBpP8MV/U2p9n607pfa7urosMkD3wfw4IUmqQ5uOkCF3NlqceTxdhMPLl0mIhMYLnesrxYaenn4v8AkruVG7lTkUGlBLeYzsKgELSOd5ZDYVzmcYDE7lbzTsQyOagdAmvouf5Yi0Qr8nUXOM4U9C+bw4RU73eBULnShuqyhqxJTM5C2+ysNphFrBoxm2CNFngDZ6Ta5lCmG+syzMDdDajSMXJDJCQmBcY3xNPqSqsBtn1Gc/r3fqgbwamxjCRui7dZ4L/2p+yG1n9EPogNtMcy5WN0Ccb9oMWlx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(82960400001)(36756003)(38100700002)(86362001)(31696002)(6666004)(316002)(44832011)(2906002)(83380400001)(5660300002)(8676002)(8936002)(66476007)(66946007)(66556008)(19627235002)(26005)(41300700001)(2616005)(6506007)(6512007)(6486002)(53546011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S01MZXY0UFZQT0t3T1cyU0RvN09qU1crVkFETHpINXNnK1IxOGhHNDFwejZT?=
 =?utf-8?B?TzA4aVZUZktORHh3QlFOaDdvZWtFaWFVQ1NXTWFIZzQ4U0V3R2FJZ0ozclF4?=
 =?utf-8?B?OWdGclEzRTNya21PcUV5bFpDc1B1SnROQWpnOVFxMlZDdEJ1d1UrRVZualMy?=
 =?utf-8?B?bGQ3TnFSMm14ZlExeHNEbkZnTDFwc0N1VlRlNmJwTFRwUDRSYXNSYS82Qnph?=
 =?utf-8?B?bWhTSlQ5VDJyUHBsY2VERkJkTjBlaGQ3TVNhaWNtVDJ3cC81bWVZYTlWeGlE?=
 =?utf-8?B?by8xbERmQzVsc2I4UDBtL2NOL2dWTVJ0blg0R1ZzVXJhN1F2UjYxTGZHc2lx?=
 =?utf-8?B?Ym9BMmV6bk4zbFJ1aTZDQlZ3TWFnTURvYzAyUzdtWXREWUpYN050S0xmQlRG?=
 =?utf-8?B?SThPalRpTm1MaHdKbmlleXV0RGM5cmVqcjU5SlV5YzFJYnB4VWNxUVhSSy9n?=
 =?utf-8?B?U3Q1cUJxZHdLWDRneGgrMUZEYVFJNFVqSkplWkxrdmFLUkpOOWRWUnZWNXV5?=
 =?utf-8?B?Y1YzZWp0Z0c2U2FTSTY5RXFjVHg2dVpRTXpCbEt0cng4emhIMnl6TTdxekRs?=
 =?utf-8?B?ZXZNNWdTcDVvMHdpbEVTNHJ6eVhucDNicFYwVWRqR0NxN3I4bFZkM242MFc5?=
 =?utf-8?B?WUI4T0JyVEF1dEhKUkNFaUlCNk9rRDhTcG5FYStKeDBnQ1YvZUxIVloveXBI?=
 =?utf-8?B?S1lEZ3B1VFpwbm1uSVBidjM2Q1VVdkwwQ3FWSE5BVCsxNXJETG5mYUJGTFd1?=
 =?utf-8?B?VG96NnZiOXc1V09oYUNDRzBJbzRtMzA5ZXZqWlRFRnh3dCswUm5wUURvMWhm?=
 =?utf-8?B?MTlidkcyOThpMDM5a0lnbnNlWld2NkJ6NTYrSlBCMUpHNXRCL3EreVZEWk54?=
 =?utf-8?B?KzI3UnFRSElMMTVKSW12WUxST2FsalplbXV0YytoK3hHbVorcWs2azBrVGxM?=
 =?utf-8?B?UFFkLzdWVm92QmxLY1NQSkNJak0zRUd0eXdxZEh1SmpuRDhLSXZWa2dOSWVU?=
 =?utf-8?B?MExmemVuWk54di9lK2RWR3dFclIzU0ZIRXdacWpsSjVyMWZFMHcvSDlFYTNX?=
 =?utf-8?B?eVJQQ1B1WWM1ZTNzR1dHdXdmK1hRQ014eWRpQlhrKzZrNW5JS0dQcVFZbmRQ?=
 =?utf-8?B?K09JdE5mbDR6c3AxNEYveGdCTGNnRUltdFhpTXJlSko2TkhuT0wxYnZqM2ND?=
 =?utf-8?B?ZkhrYjdzR2hKQzJudGttTHdTbVk1ck0xNzM5RVZ0aXVOUkhEZFJRbDAybktB?=
 =?utf-8?B?MzN2MTltSDY4VEphc3p4Qm5LRU1PUHEwTzVhSkFPcHJwblRIRC9xbmp2Mkx2?=
 =?utf-8?B?emxiK2wyWXJBOG45Z1J3L1JFOXhhN1N2YjlKTGh1QVFXY2dWZlJvdjZpbmhU?=
 =?utf-8?B?TUZMalNIb04xY0h3SkxNL09OVmpBelkwUTZXaWF5ajBmRXBXM1VsU1k1dHlq?=
 =?utf-8?B?djZ5cXNsM2MvckJid0RPVnkrNGVMS2VLblgyeVpmNFF2dmwzME52VTgrcHpI?=
 =?utf-8?B?UDZZaWNHZHNsb3czYU1jeW9GU0JiU1JmdnIxcWVJVUF4cHBUR0xENzZnVkR6?=
 =?utf-8?B?WFZNQkxYOVhPQkt3SjhlUi9PUW5QcEcyUnZFMStaL091UjlJZnkvYTN2SDhR?=
 =?utf-8?B?RVhBTDFuTnpZWGxYUjV3dmVLM245WFdPeG9MN0d0VmdtL05iOUVMT1N0anV6?=
 =?utf-8?B?Z0kyNnpIc1R4MDFRUFVNdFB3eFJEL0JlK1h3SFdwNUNhRGl0SFBBV3hQdlgz?=
 =?utf-8?B?WmE3MTNHN2loeFlQZ3J1QjY5aXZCQVQrZmxTY3JFSmp1K2hDZlQ1dnNYU0Zh?=
 =?utf-8?B?M0J5RkxFYzhGb0dwVTcremJJYmhodTU4Z1o5U2pRbFpjRHVQY0RzRmhNSHIx?=
 =?utf-8?B?cGM5amNhbXI2TnlCV2RGTHVPQ25ad3VFbWJxQm4rV0NmWWZMOWU0WlBBY0xy?=
 =?utf-8?B?OVNRUDFpNU10NHYwMFJNUDZ2Yzc5MkRIL0F2ekljVzAyL3c4b21pb2RMU1Zp?=
 =?utf-8?B?OW54dkZvVFkwbm9QcHk5eVZpQ2JMbWRRQ1J1NFozVlEweHJ4SmFVbDhYT0du?=
 =?utf-8?B?QWNBelN4Sk1tdkI0ZzhNeXR0VEdlOTdkK3hvbGFFZjFzV2VXY3lyNlZmRE5H?=
 =?utf-8?B?RFhLcWliV1ZaVGc1c1AwM3YwWklLZTBHUmg1cVUwSXhwSE5DYkRoRTRGbEt0?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438c81f8-67ba-4678-566f-08dc2e2bd65d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:41:39.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlMZuDKhu49+MZI78VaEikfAQs7jGbszzBrXNvQqad6rzAxUABcI1/XNqfeld5bt7HOsOX8PV5TXsEezjvDyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7810
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:41:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14995

On 15.02.24 13:14, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> SWUpdate changes the Suricatta lua api in 2023.05 to support
> released legacy applications add version with the old api.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate-2022.12.yaml                 | 22 +++++
>  ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
>  ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
>  .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 kas/opt/swupdate-2022.12.yaml
>  create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>  create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> 
> diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
> new file mode 100644
> index 0000000..5dfe97a
> --- /dev/null
> +++ b/kas/opt/swupdate-2022.12.yaml
> @@ -0,0 +1,22 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
> +# from the first wic partition
> +
> +header:
> +  version: 14
> +  includes:
> +   - kas/opt/swupdate.yml
> +
> +local_conf_header:
> +  swupdate-2022.12: |
> +    PREFERRED_VERSION_swupdate = "2022.12%"
> +    IMAGE_PREINSTALL += "cowsay"

What has the cow to say here???

> diff --git a/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
> new file mode 100644
> index 0000000..dafbf6d
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
> @@ -0,0 +1,27 @@
> +From 451a80e1a98d7f6abd287215e7cac3929eebe025 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 15 Feb 2024 11:06:52 +0100
> +Subject: [PATCH 1/2] Add option to enable surricatta-lua
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/rules | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/debian/rules b/debian/rules
> +index 57da4ca7..a78d9ca8 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -56,6 +56,9 @@ endif
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
> + endif
> ++ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
> ++	echo CONFIG_SURICATTA_LUA=y              >> configs/debian_defconfig
> ++endif
> + ifneq (,$(LUA_VERSION))
> + 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
> + 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> new file mode 100644
> index 0000000..4ff7419
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> @@ -0,0 +1,94 @@
> +From 356ed7987a489f0259c0878117a4cac8e22ba8d5 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Fri, 16 Jun 2023 19:43:38 +0200
> +Subject: [PATCH 2/2] d/patches: Add patch to add the build version to swupdate
> +
> +The build version is only set if build in a git repository
> +this patch allows to use the version information stored in
> +the Makefile.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
> + debian/patches/series                         |  1 +
> + debian/rules                                  |  2 +
> + 3 files changed, 49 insertions(+)
> + create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +
> +diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +new file mode 100644
> +index 00000000..480b67f5
> +--- /dev/null
> ++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +@@ -0,0 +1,46 @@
> ++From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
> ++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ++Date: Sat, 17 Jun 2023 17:56:18 +0200
> ++Subject: [PATCH] Makefile.flags: Set version if git returns no information
> ++
> ++This set the swupdate version if build in a non git environment.
> ++E.g. pristine-tar build or from a release tarball.
> ++
> ++Also allows to set the EXTRAVERSION from the command line.
> ++
> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ++---
> ++ Makefile       | 2 +-
> ++ Makefile.flags | 3 +++
> ++ 2 files changed, 4 insertions(+), 1 deletion(-)
> ++
> ++diff --git a/Makefile b/Makefile
> ++index 9f6a33a6..56189688 100644
> ++--- a/Makefile
> +++++ b/Makefile
> ++@@ -5,7 +5,7 @@
> ++ VERSION = 2022
> ++ PATCHLEVEL = 12
> ++ SUBLEVEL = 0
> ++-EXTRAVERSION =
> +++EXTRAVERSION ?=
> ++ NAME =
> ++ 
> ++ IPCLIB_VERSION = 0.1
> ++diff --git a/Makefile.flags b/Makefile.flags
> ++index 2bec8468..f69ab5e8 100644
> ++--- a/Makefile.flags
> +++++ b/Makefile.flags
> ++@@ -7,6 +7,9 @@
> ++ # ==========================================================================
> ++ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
> ++ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
> +++ifeq (,$(SWU_VER))
> +++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> +++endif
> ++ export SWU_VER
> ++ SKIP_STRIP ?= n
> ++ 
> ++-- 
> ++2.39.2
> ++
> +diff --git a/debian/patches/series b/debian/patches/series
> +index 5638bbf5..12324569 100644
> +--- a/debian/patches/series
> ++++ b/debian/patches/series
> +@@ -1,3 +1,4 @@
> + Link-config-to-swupdate-www-path.diff
> + Replace-Font-Awesome-5-with-Fork-Awesome.diff
> + use-gcc-compiler.diff
> ++Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +diff --git a/debian/rules b/debian/rules
> +index a78d9ca8..1bc70f84 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -17,6 +17,8 @@ export DH_WITH=--with lua
> + export HAVE_LUA=y
> + endif
> + 
> ++DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
> ++export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
> + BU_SWU=
> + ifeq (linux,$(DEB_HOST_ARCH_OS))
> + 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> new file mode 100644
> index 0000000..fcccc2c
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> @@ -0,0 +1,41 @@
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
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/2022.12:"
> +
> +SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "aa9edf070567fa5b3e942c270633a8feef49dad8"

Is this the debianization for Debian's 2022.12 version or for newer?

> +SRC_URI += "file://0001-Add-option-to-enable-surricatta-lua.patch"
> +SRC_URI += "file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
> +
> +ISAR_CROSS_COMPILE:bullseye = "0"
> +
> +DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> +
> +# use backport build profile for bullseye
> +DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> +
> +CHANGELOG_V ?= "${PV}-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}

Jan

-- 
Siemens AG, Technology
Linux Expert Center


