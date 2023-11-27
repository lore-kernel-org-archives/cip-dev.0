Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83520C4167B
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 01:43:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web11.83715.1701049420726432928
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Nov 2023 17:43:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EESri5A3;
 spf=pass (domain: siemens.com, ip: 40.107.22.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gem6cb8USK2HQj7MxXSGh6qR35tBZsTGfGxXIT1tLbiy0q7P8NqV+o0XgWIX1E6DfelOwMcHZNyZgk0n2TcyayY6tNn+Q99amfGs7moZEp8/0QUxGmgHhRZn6lMLJvtdKKgVjGYysY2VLP/ET8ddqLTkQMWmGc4hDcTgDNaF4rzw0Hx7XicbPTiRFt207WY7FB1seYNfvIK6Q7na/Q9sDq1U0OurvYID1XxjzdzH2huv/ce72vRihXGYAmZsMgOAUPR3soJCKXJOYSnmFDb/CTx1I8uvJayMCa8GCRh/FwDWiq2sEKxjjyTdYHpgYasPre6paICqFAFsqEmY7DaCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nNLhlPk1RpN5k1qg+O89aABErQXDSTQqnICNnVkG6U=;
 b=c3BUqrmz/3c0rPl0+3dxGc8FLtisySuHqPNfEK8vybqJCbya24ZJLSmbs2+TFwrwonKDp+94k+bgNpF/6gCqFCL6gApYnO0AaP0tjsZXLu/Amk+adBUiDSKElTyRajj+ZuMLNNrDtIViRDJEPBEw73XTOpqXQSJn7MxzHcAXArf8tRXQZhfucQ6RmSBQLhrvP+yyxbCdv9JDCwBmbojd4S8oetWDdDmk95WT0l8FnH4cYx9XDGjPSzfdJCffelXVaRuBf/iVUWWeWXTYUJQKpEYvHk30Ysqj+xhg2HiKVwZ5kDwU+cEOMlX4UlXbt2zf5RBitE2LsshbRoIgNx+piQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nNLhlPk1RpN5k1qg+O89aABErQXDSTQqnICNnVkG6U=;
 b=EESri5A3uuDw/ab2F88mPBwGbAgPiyMQUJiUgQviYKCerkD1LazfU8qdO3WTC6ppqZOAAdmjAqu9UQUTczLbtqYRWLxvr7pNcuajCm0Ae5qQLvXIp0ECr5r7fmbL7sYCBKiY5xD+vx7YIEZ8wSE0ZNFlTNrLwCMAKVNMAhWI20BnCAxxNfhDQBm2JDx8cA6W9QP8qUv9Q28kz8BfQ1bkY4yRbiWum+t5ndwF4pzaeEpX5FRSxamb6m39gBFJ3upaWrPmgyPv8WdPKbX9f8Olg526VZd3nV7N1eTNeo7CDF/96lXg61d63NJCXy5TIwYeRbiC9xMFSATkBQ9QsIughQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 01:43:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 01:43:36 +0000
Message-ID: <203ee38a-ff84-41ce-81fa-8cae8eb59d98@siemens.com>
Date: Mon, 27 Nov 2023 09:43:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] swupdate: Update debian folder
 to 2023.05+dfsg-4
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231124121433.2174817-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231124121433.2174817-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce06517-49e3-4a31-317d-08dbeeea45a0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/799cUFj8ShYSQCh2Wz3WTn49K7TR4HxYw4Yls0XY6+o6846UMP9y/l6Ukp3Fe0hMTD6XvBVKWdVx7YETUI3f/xGM5eF/56fYnVQgsqh2s3CYfT5magzWmLXE1HLbJlVWp1BJu27mmYc2CxbQ+hD1spaxKBxsewFV4rRKLwzVzNAnsP1ZAyd7UrvdVjO3yNslPAMlZm8axNlU4/PUWxBAIAXf4HV8jM8xelUkcdTP6RrZKZsq9IFJag5AZH3+I+T5zJNp2SRTSWVUuB/wWkicpaJ96ZMXz3aG5qdzrKl6DhzwjR82I78ZaRmj8MUxyZE7MsLxTNcloE7ERCIFR8UbMAnMBtt3toK9ngrNasPxsMx6LB/bRznEEw57t1f0p52yua92qaNvbZv309lJGROo9H45HsCSY+JYbwr1T2+KLZ/m6zCrODlXUoosdBcfDzPqy0IBp08Kw9tnOzt0Jc9xpYszFjKNn4pwgkxboFwZFRklG8aWTLEr6cDMNVYTPJnVOgQ6ZdIbcJfW/05fssMO//UWixCtc8wQaab25Z9gPMMesEUyOuzAPVCUmm5NzpmB2CaIwy7aW6MSVhe7bU4NKwKcWOrvV3WSnPXQ+vysgZbrwZsT/76V+Jd8juO3OqnOcUQIDIo24pljrcanA+QiQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(31686004)(82960400001)(6512007)(53546011)(6506007)(6666004)(8936002)(66946007)(66556008)(6486002)(316002)(66476007)(15650500001)(5660300002)(31696002)(44832011)(8676002)(478600001)(86362001)(41300700001)(30864003)(2906002)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1J2RzdFTkU5d3lCZkVhcFpUbUVoOHQ3bUwrQ1AraTIrSmEyRTNWUWJhcElm?=
 =?utf-8?B?U3pWaWg2NXVyMGdRRURxelNPc0ppc3dlV3VZWHBld1RaZ0pOVGR5aURHSk5v?=
 =?utf-8?B?d2FIaE9aRHBDZ0ZSZFJsTSs0eUN1em1xM0lDSnRZcFVoVXVIM3pGbzFDZ1ly?=
 =?utf-8?B?MVFkdUFhSVJLU1JxOEI3WjVLSWx2cGF5cXcrUGpuRThpU1puMGEwZ3B0cCsx?=
 =?utf-8?B?S3R4MG1OSFhxNE5paGxGcmtLVTdNOGdPbXFHY25MTmlJNVhRSHF2UGp1bHQz?=
 =?utf-8?B?UjFxSTI1L2hFL1N6Ym12ekZJUVh5S0REMnlRZWwwYzNtNFQ3Qnh4YkVuMWpW?=
 =?utf-8?B?am55SC9Yd203TFJqREFRVjhlSDhrRHg0VEQ3ODhHemFRUWNrOXp1YWVPNHpM?=
 =?utf-8?B?Q0lsaEl6RUNjMGZyQVpqd3RmSnNSblpZSVV5NklKRHVWRGdCV2VRb1kreFRN?=
 =?utf-8?B?SlUvQ3o2K1VXTzNCVDMvVEI2VEgvZytXSC9XMmFIVEpRdmh5SzJaNE1XeVh6?=
 =?utf-8?B?N2J1djZjY1lLMjJFL3U3WGtuWlFzUURyaTkrOXdUZ2JQd3lxZVlpaGpBNjVU?=
 =?utf-8?B?cUpwenRIcTVKSVcrMU9aY1BETS8rSElKd3llVmU2ZjR0ZXZJUmRieU5PdXB2?=
 =?utf-8?B?V3ZrTWNjRFA4czdDWlZRTkhJZndrcE9XcGJ3NFVIbnRScGtiNVVydUZFbklW?=
 =?utf-8?B?VSs2eTg4SzhHQ1VwdVR6TmEwTHQxQ2k0ZE9YVE92MXNpQWlLL3F2WlBOMmhl?=
 =?utf-8?B?RkYwRUFIWWorTXNGb1ZZLytaQnBZTFJXM0IxbDNkcS9xc0E1a0poUS9uUFps?=
 =?utf-8?B?UHVZc0lOc2ZseXZnL1l1ZzFSelVzTWUrTHNpcjRXd3hkM1huemxWTVhXZzhM?=
 =?utf-8?B?SDNHdGdBV25Wa2ZmNWFxOFBOWkFhN0R0T0VzNDV0T0dhODhwNmVqU0FQRUpl?=
 =?utf-8?B?NDAzVTRaTmx6NWRUOUgzR3ZBNjI0WjZ4bjIxSUJCK2xvM0ZMQW1yTE1JenJL?=
 =?utf-8?B?MkpscHY2eGdYeS96NUVWR1JCL1NyOWRJSWNSVFptaHQydjB5TUJYMjdRb3lr?=
 =?utf-8?B?Z0JCZWpXNjU5bjVxSzJrMUhpRmxMSXc0QXcyZzRvclJjRW51aWg2T2xHZEVm?=
 =?utf-8?B?NTZadmh6Q0lFYVQxVmtDcGt5TXlrTFVQQ2RjYm5FR3FuRXJvTmdGUUlWSFc4?=
 =?utf-8?B?ck9KMkIxS1BQTlJuWWxacDhxUW9VYU5Jd1NNUjgxS3FsTWwwV1dJRVA0M1RS?=
 =?utf-8?B?Y3ExdWZJV29vcVBMbmNWUzhBeDQ3MWtWeVY3SXcwMHdQb3hVNitOQjJlRW5W?=
 =?utf-8?B?aUlGcjJQNGJNNkR1dXRETWZWOUZPczRjRHVVMFZaVHl3TXNXcUlDVUY2Mjd2?=
 =?utf-8?B?M3R2OGxpUE41TW9HVmVkSUtvVFMwVEFJMGVoR1NyQ3lWYktHeU9aa0VYUDdt?=
 =?utf-8?B?RDVLQjI0Ukh3T21VUjBsaHY1R05ncTNDWS9mU1lwaHJTS0pUU3lRS2NLRS9F?=
 =?utf-8?B?REtUbVVTbTFtYk1tRzZvT2pVb3Q2NWszeXVpL0VHMDZ5WXlHWUJFYzlqZHJ4?=
 =?utf-8?B?bEM0REI3dW9NOStsMllQaTliTHJZSlU0Rk9kVy9IUUlkMXdOMDEzcHlqT09I?=
 =?utf-8?B?MzVrL1BFd0RNSVFkZnlhaFVqRGMwaXB0WThJYWhqbXdaRnFINWlWNk0vSDhi?=
 =?utf-8?B?QU0vK1dmU3hDZWVNRDM4c0ZEZG1ucjlXOHh4elRaRzZtUVI1eThzQ3lvbXd4?=
 =?utf-8?B?TmlYbDJLVGlzdjBmYk1seGNTL3l3T1VuZWpOVFFtUEZCVUZsSHlEbHNRR2ov?=
 =?utf-8?B?M2lRR2lIR3JEbHNRR3VNMFNpek03RytuS29yYnZ6emhEaWtJMmNFTXZYOFg2?=
 =?utf-8?B?T0x2QWRCMXpqd3F1bUVPaU4vT1MxSkNLZVFuR04vVWZmdlc3dGVNdndpSEZx?=
 =?utf-8?B?bW9ya2xhamt2K2RsaU1oL3J0b3g3TlhCbVpDYnIyTGdNNzh1S3lxMkpZVFdV?=
 =?utf-8?B?UEFYdERRVHlVSC80djc5eWpXOUxTY0p5bmVEZnRSYlYzQ1dQN1REQUlOTXl1?=
 =?utf-8?B?eHorUXVUVkxVS3ZIY1d4SERJSHZBNTBrL0U1YzlYNDdScnc0ajlTbFJnM0VJ?=
 =?utf-8?Q?WKQrLxNJd26L4/YL+Nl3g2anS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce06517-49e3-4a31-317d-08dbeeea45a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 01:43:36.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jghnZq+mpPw2EpbTIavWKGUPrif29DjfGe3YsGwB6efK6UlP0qYZEfSXtct3o9bmAz0VIdWOqMr3U0R8ahFAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Nov 2023 01:43:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13747

On 24.11.23 20:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds the system user swupdate and changes the permission
> of the sockets to 0660 instead of world writable.
> 
> Also suricatta lua is now set automatically.
> 
> swupdate uses  wolfssl (=< 5) instead of openssl for
> certificate management. wolfssl(=< 5) is only available as backport
> in debian bullseye.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> SWUpdate in cip-core uses the debian folder from salsa with swupdate commit
> c8ca55684c375937dbcdefb0563071a35137f4ba as decribed in a2aa61b swupdate: Update to 2023.05 with wfx support. This allows to select hawkbit or wfx as backend during runtime.
> 
> 
> Changes v3:
>  - Cleanup of bullseye backport preference
>  - change subject to clarify patch
> Changes v2:
>  - Fix for bullseye
> 
>  ...eferences.swupdate-bullseye-backports.conf |  7 +++++
>  ...d-rules-Add-option-for-suricatta_lua.patch | 30 -------------------
>  ...ate-build_profile-option-for-delta-.patch} | 16 +++++-----
>  ...ch-to-add-the-build-version-to-swup.patch} | 10 +++----
>  ...-Add-option-to-enable-suricatta_wfx.patch} | 14 ++++-----
>  ...install-Fix-path-for-debian-bullseye.patch | 24 +++++++++++++++
>  recipes-core/swupdate/swupdate_2023.05.bb     | 10 +++----
>  7 files changed, 56 insertions(+), 55 deletions(-)
>  delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
>  rename recipes-core/swupdate/files/2023.05/{0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch => 0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch} (76%)
>  rename recipes-core/swupdate/files/2023.05/{0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (93%)
>  rename recipes-core/swupdate/files/2023.05/{0004-d-rules-Add-option-to-enable-suricatta_wfx.patch => 0003-d-rules-Add-option-to-enable-suricatta_wfx.patch} (69%)
>  create mode 100644 recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
> 
> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
> index a2377bb..70d0494 100644
> --- a/conf/distro/preferences.swupdate-bullseye-backports.conf
> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
> @@ -1,3 +1,10 @@
>  Package: dh-nodejs
>  Pin: release n=bullseye-backports
>  Pin-Priority: 801
> +Package: libwolfssl-dev, libwolfssl35
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +Package: libwolfssl-dev
> +Pin: release n=bullseye
> +Pin-Priority: -1
> +
> diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
> deleted file mode 100644
> index 5aeb605..0000000
> --- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Wed, 3 May 2023 16:02:37 +0200
> -Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
> -
> -This allows to use lua plugins as suricatta backends. It is optional
> -as it overrides the default HAWKBIT backend.
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/rules | 3 +++
> - 1 file changed, 3 insertions(+)
> -
> -diff --git a/debian/rules b/debian/rules
> -index 57da4ca7..91106fbd 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -56,6 +56,9 @@ endif
> - ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
> - endif
> -+ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
> -+endif
> - ifneq (,$(LUA_VERSION))
> - 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
> - 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
> --- 
> -2.39.2
> -
> diff --git a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> similarity index 76%
> rename from recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> rename to recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> index 4203061..0d0fc0a 100644
> --- a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> +++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> @@ -1,7 +1,7 @@
> -From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
> +From 03d455be74d439c7e2eb849e5acdfb494afb3d7c Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Thu, 15 Jun 2023 18:48:25 +0200
> -Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for delta
> +Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for delta
>   update
>  
>  Delta update need zchunk 1.3 to work on memory restricted
> @@ -15,20 +15,20 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   2 files changed, 2 insertions(+), 2 deletions(-)
>  
>  diff --git a/debian/control b/debian/control
> -index e47c320c..d4b17972 100644
> +index a389b2a9..2f0c0053 100644
>  --- a/debian/control
>  +++ b/debian/control
> -@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
> +@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
>                  uuid-dev,
>                  zlib1g-dev,
>                  libzstd-dev,
> --               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
> +-               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
>  +               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
>                  libp11-kit-dev <pkg.swupdate.p11>,
> -                libwolfssl-dev <pkg.swupdate.p11>,
> +                libwolfssl-dev (>= 5),
>                  libmtd-dev [linux-any],
>  diff --git a/debian/rules b/debian/rules
> -index 91106fbd..8cac6359 100755
> +index 3b1cc0f6..2c91677c 100755
>  --- a/debian/rules
>  +++ b/debian/rules
>  @@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
> @@ -41,5 +41,5 @@ index 91106fbd..8cac6359 100755
>   endif
>   ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
>  -- 
> -2.39.2
> +2.42.0
>  
> diff --git a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> similarity index 93%
> rename from recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> rename to recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> index 857b4ab..8056818 100644
> --- a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> +++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> @@ -1,7 +1,7 @@
> -From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
> +From ad714bc12b03c148aadb3523f87cc14d42a477b0 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Fri, 16 Jun 2023 19:43:38 +0200
> -Subject: [PATCH 3/4] d/patches: Add patch to add the build version to swupdate
> +Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
>  
>  The build version is only set if build in a git repository
>  this patch allows to use the version information stored in
> @@ -77,10 +77,10 @@ index 5638bbf5..12324569 100644
>   use-gcc-compiler.diff
>  +Makefile.flags-Set-version-if-git-returns-no-informa.diff
>  diff --git a/debian/rules b/debian/rules
> -index 8cac6359..566a21bd 100755
> +index 2c91677c..5d72987c 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -17,6 +17,8 @@ export DH_WITH=--with lua
> +@@ -17,6 +17,8 @@ export DH_WITH=,lua
>   export HAVE_LUA=y
>   endif
>   
> @@ -90,5 +90,5 @@ index 8cac6359..566a21bd 100755
>   ifeq (linux,$(DEB_HOST_ARCH_OS))
>   	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
>  -- 
> -2.39.2
> +2.42.0
>  
> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
> similarity index 69%
> rename from recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
> rename to recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
> index 9c5ebd3..87c60d7 100644
> --- a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
> +++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
> @@ -1,7 +1,7 @@
> -From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
> +From fae97f0e23f945c1ab6e767451cda1d2798aa348 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Fri, 16 Jun 2023 20:32:38 +0200
> -Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
> +Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
>  
>  Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
>  suricattawfx lua module.
> @@ -12,12 +12,12 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   1 file changed, 3 insertions(+)
>  
>  diff --git a/debian/rules b/debian/rules
> -index 566a21bd..fc122d0d 100755
> +index 5d72987c..d7ff5510 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -61,6 +61,9 @@ endif
> - ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
> +@@ -58,6 +58,9 @@ endif
> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>   endif
>  +ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
>  +	echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
> @@ -26,5 +26,5 @@ index 566a21bd..fc122d0d 100755
>   	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>   	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>  -- 
> -2.39.2
> +2.42.0
>  
> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
> new file mode 100644
> index 0000000..b2d831d
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
> @@ -0,0 +1,24 @@
> +From f2184e7573e705bad408cf1422599b967773d48e Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 16 Nov 2023 16:40:19 +0100
> +Subject: [PATCH 4/4] d/swupdate-www.install: Fix path for debian-bullseye
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/swupdate-www.install | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/debian/swupdate-www.install b/debian/swupdate-www.install
> +index 7e3d95c6..9c6113cc 100644
> +--- a/debian/swupdate-www.install
> ++++ b/debian/swupdate-www.install
> +@@ -1,5 +1,5 @@
> + web-app/css          /usr/share/swupdate/www
> + web-app/images       /usr/share/swupdate/www
> +-index.html           /usr/share/swupdate/www
> ++web-app/index.html   /usr/share/swupdate/www
> + web-app/js           /usr/share/swupdate/www
> + web-app/node_modules /usr/share/swupdate/www
> +-- 
> +2.42.0
> +
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 762fac2..5ead66e 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -22,19 +22,19 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
>  SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
>  SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
>  
> -SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
> +SRCREV_debian = "78cb6f20319d2b911e170eea5305f2cf0bd33030"
>  SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
>  
>  # patches
> -SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
> -            file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
> -            file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
> -            file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
> +SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
> +            file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
> +            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>  
>  
>  # The option: "pkg.swupdate.nosigning" disables the required signing
>  # of update binaries
>  # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>  
>  # deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"

Thanks, applied with minor style adjustements, replacing the previous
version in next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


