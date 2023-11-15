Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0078C54F8E
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:41:06 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.88])
 by mx.groups.io with SMTP id smtpd.web10.14739.1700059259987630924
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:41:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NZfYLe8P;
 spf=pass (domain: siemens.com, ip: 40.107.14.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n96G/I9PjEfdD2h/LGOPB1BvWhi9AvrnKyZ574qZGcs2zFsVIKeodSJG2bgJXpVQ+xKnUnZh49fN15H/yYBjGCULk9HM1/7iQiu1lgstwq/9Iv8Fz2ALycaL2Gs4UOtgdOPxENSfii1UAABljMsTAIfFzldXSt9V+TfxetLYVmeFlv8OAF+MuH4PLUUVI2aeihZeR83e+hi78FHa9VWuhOeOk/Zk/nFAErC00i+2tYtotBT4NPNbHKuHHLxNvQvoRn8eXf3B3oa7QtaN1q1RuJyE1j8maKc1LKGpUb56YIGf0gGvKeeLuZvIuZ5mU8NLqNl1Agynu4kqFKHv4rCIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r018cB3Z0UW7AIiorkoSWAjQvs34h8Osy9F/bT4VuPg=;
 b=gD80YDSt2+TjQV8Pnpc20NjNHw7ycp0kJ18Zr1Honrwprls6hZdNkghRwAQFusfEjtYvRgsK5ZMfqbWoRuMgZaJFuIDY6TEp+h4gu178/IkyFAoZW/WH15jYKRMC5bmSoY2ENR6WI46B9QQqLjXjc4K6XT1ZkDdy5cMpEjTRq+7GVWZ/dY0G0RYWlxnck5zB8TlrgF6BDZRV92L0FAiw218lTpDkYt93sLxjKwPg/2HDh8i2upPQhj050f2UMEeaXbuKxCY4rz/BwWYoMyqnSJKp9ADTe0ZislgtFSMrS2czLDrnLfXEklg3nFI/6iquEvXiczX8TFeM40NRZYRa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r018cB3Z0UW7AIiorkoSWAjQvs34h8Osy9F/bT4VuPg=;
 b=NZfYLe8PmJkH67DC9L8xOxCREScXjZ5clHgyedqaT4S+4y//Movyq6dkD+EiMSmNNkuOSZIiicweMJcBSaeXElsUw98ZZyxeBVI0lXu3fTT62E+WnytacXbIghHG6XgVjwZwUUPM26GcnDqqaTtn1LpGDiyJPtdIuhlwo3fW2JyDgFIcHcdbKmi376XdB+7pI6jG7HWIoNl9WW/ljApgT4t4djJujyqq0VGgjNf3KYsEOSMDcjYY9zdAk9v/HCJuVrk1w687qdovb/nx5E5p3drx1aS+8COLzLSeOtMVC7St7uNd5QhCnz7OMPEnUZ7sCBYrfteFuk2kdIxuw446cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 14:40:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 14:40:56 +0000
Message-ID: <eb98a52d-9bd0-4583-a148-81ef1253c6ab@siemens.com>
Date: Wed, 15 Nov 2023 15:40:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update debian folder to
 2023.05+dfsg-4
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf596a7-9cea-480e-d8c9-08dbe5e8e064
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LMoffZgt0ceeptBsrfub9d/wurHg83ELpWtLApIJPufLWv5ctiB/CF8TsIqmoLeVEUGIism/JWvefj0OKd50FiRImyPaD3JNSMmYprlKGjueiBjLIMMG3EoC9xnp6Qv8veuRT3CPnhcy+/XqJkTzglKHbyBRAHtAwIfPluwFcFnOAZ+Owy/27E8KfHtkKa5u5yslJLmWrgPKfRwKxmamZMh1v/jL3DObP8Udr/VsD59mkDTd75WtBOZiLcck/41wZQDKlg/pS70q7tavEFFZ+5b7laAYfeiPIfoS1ykulBS4ruI8/w1/qldaV9tyFsQATQNS8WhJeN2ZCJkuIJb84TL1owaSPbM6LBSgg38ZIMORul0xY76LTDj6StZEzk4XLisXSIVcBE6WTPAxSGiDaTZDXcJ0I/jpgQ8oHey6O1887saMiogPcmet5sT4MhN33xR6aN5zE7ayPGaPKXJey4S/56yP6WCQoVQHcpSoPdBjbk9ZPzxItM9gH+b9iO+fBNhSukMHn903QMbzbIvk+eaT5T2Q0YEmMq/vsJcz/tup1mCX61myCQmp57j9+fSrNc8PaercOEQ3lUnING+Pgppl5D+kThQtds8kwJKSujmb0oW3lkdhK3GNZYYHnJ2U9kf96dmXTDfDTyYRjQgCDw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(53546011)(82960400001)(41300700001)(6512007)(6666004)(6506007)(83380400001)(26005)(2616005)(44832011)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(30864003)(5660300002)(316002)(66946007)(15650500001)(66476007)(66556008)(31686004)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3FtdThQSFMzb3lyWms5SXp6SENsYWpuUTI4d2xuY3NpWDZJZmhBZlQ1enJy?=
 =?utf-8?B?ZUV6UGJvWERPY1FtblFkM0VlT2d2Wk9BVXhKdThxek9yZ2NkVDhXQUt3Y3dt?=
 =?utf-8?B?M0o0YmxJZ3I0MmFuaU9vWUlYWFE1b2RZdDl6MmNvTVMwT2pxNVErWCtXdU1y?=
 =?utf-8?B?aUREOVNlQXJPWURuSzhyaUw5MUlISzlMQnJyRzREYkk5RmQzZy9rb2tOa0Zk?=
 =?utf-8?B?aG9SOXZMUm8weDhoYjJka1E5NVAvakREd0wya2NJS1cyWHlZaEF1aTRhUEJM?=
 =?utf-8?B?bnpUaVZoa0lhSmdiNmhHSDB5cktmMytRY1VPZ2JRS0tvZy80cVVreVZVQnMy?=
 =?utf-8?B?blpVUERwQVRZV3NEVklrOEFLRXB2bjVxWjk1SUxtaXRremx3UTBOdlQ3N1pV?=
 =?utf-8?B?bWdsRGFlSGFXV3IrMk45b0ZBclh5Tm5BbUFUcFdBY0RReU1BWGpYRGp3Q0Q5?=
 =?utf-8?B?Z2RML2hIN3pUVEFxN3lNamt5aDFRK0h1SGlGNUlEa2NER21wbEVPalRzY0Ny?=
 =?utf-8?B?eGFudFFKMDFDVmE3ZDV1V3Urbkx4NjNZa1Jna1BRVmlOT285QU9ZWmViQjcy?=
 =?utf-8?B?SlZuQUpWVTNaY0p0eDBWYklGRTRCYkwwcFRZYkh6STNpVlByNTVWTXdYd2Vi?=
 =?utf-8?B?ZkVIblVyVDJiMCsvSVFtUHVpZzlxcXFRTG1ER0tOS2NsczJyVE04K05uMDVF?=
 =?utf-8?B?em1qQUp4L3B6VHVTcGxxL0RUcmRpM3huVU4yemdtR1hpQkNuSWtZL3ExRmtu?=
 =?utf-8?B?L2VDZ1prcTZGQy96OUVlOFpOb291djZpdXcvQ0U3N0Z4N3pqRlVSNy9iQ3ZT?=
 =?utf-8?B?cUZBeE54N0ZPOEJTeHlOeDFKMFJ2bTF1dFlaVVZsSk9JU0FZdm1jb2xpVVM2?=
 =?utf-8?B?aG9LWXhWUHZpUVZjMGVUNFlUbTQvVllZenVQSjBkSWFpLzJPQ2h1RUc5Z3U1?=
 =?utf-8?B?U0FnNzEvelZIQUtUMEU3ejNiVy9mc1VCejJhcUZ4TUtCOFZkTlNqVkpiNG1S?=
 =?utf-8?B?OTVNckxPdW1raUVoaWhVdDU3cVZPV3VtT21vTDVtYjYzbmVZU3F3TUFOK2hB?=
 =?utf-8?B?cXlsUDZ5dVh0ZXVBVGowUFJzOW91cEZ2NWgvS0kxTno3R3QxbVg5bkJZK0ZZ?=
 =?utf-8?B?cmg5aGc5c21LeDg4aXV5SEVoWFVaWjRjdUQ5bWErbC8vUmovRENUbnBhY2lv?=
 =?utf-8?B?R3I4MGozZ2pCV01LQnRod2FJNlhISnkxS0YySUQrUFJQUTdUVHpjVjFCQXNx?=
 =?utf-8?B?TnpMbjBtdm1GaXZzenFYOWhiMHdUam5TclhoK2NpaUt1dzkrek1lbVFMd0sv?=
 =?utf-8?B?cGVhbTFNYmVaazgxMlF6cDhuYkNadjQ4V2JiNUc1TUdCNHQ2Mml6MHNFeEZ6?=
 =?utf-8?B?MjVmc01RSHZhUC9jVUlVTXFLMWxjZ3hTN0o3Mk9SdUVhV1Excmtsc2hhRkp1?=
 =?utf-8?B?NE1IZ2dsK3ltRmtXcG1vVHB5aFpmYjA5N0dNaVFaK2VYQ3VtRERkcDRhbVA2?=
 =?utf-8?B?S0RLc1pkbUdBN3RUbkNBcW5vc1N5RGsvc09JU3BDOERPVVo3L2FkVVFONlZT?=
 =?utf-8?B?SG5oK3FzQVhDMXljSm9Ka0h1SGxVUko5RFVnRTNEVVlrY01nR094ZEhCT3Nh?=
 =?utf-8?B?Rk1uSUpqR0p4ZWVYZEswMENVRVM4dWlBcFAwZWU1c2NwcE04cUQyM1ZJb3lK?=
 =?utf-8?B?cXBUVlR1MXRaVWdrYTFnZ2lQRFBVemZlM2E4UXlDZUk4U1hPMG9Ic1pWejBh?=
 =?utf-8?B?cG1sd0REZVJFSUZQbzZpSFQ1VXBFRUtFelhiQU52eG16REY0b2ZSMkk3K3JY?=
 =?utf-8?B?MTVBbjJYMkcwWTFvVjF3ZlFTMVVCYncveG00ZnR0UlNvSmFlTk13VlB5bWE0?=
 =?utf-8?B?eVo5NDUzZHpsWWY2b0NhNzVMSkF5T0Z3OHJkZDg4aE4wSDVKSmc2RTBLMml0?=
 =?utf-8?B?K0wzUmZYbnF5SDlIbkFWSllwN0pCSkhWMm5qUGtBY3ljUkV6MktOV2ozbFF1?=
 =?utf-8?B?WHZwZHh4Mk1BUVlNbkFrdTJEWnpCQThNcEExY3dQN1F3b3ZyaTBDRGtmaE1i?=
 =?utf-8?B?WElTYWRBaU85dFBmczdaeGFjUHJHNEVpU3VZQzhkVUZlVjE1NGVDc1VqajAx?=
 =?utf-8?Q?06MVFfiHIz6fiWI33JF+tBtgG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf596a7-9cea-480e-d8c9-08dbe5e8e064
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:40:56.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcOpm/G5edRvWhpPKuQlkW8ybGXuBRWxQgpz4lAHaZo1NTjoBNSq4BXTvGAIYlJw17AKmJwWglkTnx5+2NRvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:41:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13583

On 14.11.23 17:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds the system user swupdate and changes the permission
> of the sockets to 0660 instead of world writable.
> 

Stefano had some concerns about the best aproach. Is this Debian
revision already reflecting those?

Jan

> Also suricatta lua is now set automatically.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...d-rules-Add-option-for-suricatta_lua.patch | 30 -------------------
>  ...ate-build_profile-option-for-delta-.patch} | 16 +++++-----
>  ...ch-to-add-the-build-version-to-swup.patch} |  8 ++---
>  ...-Add-option-to-enable-suricatta_wfx.patch} | 14 ++++-----
>  recipes-core/swupdate/swupdate_2023.05.bb     | 15 ++++------
>  5 files changed, 24 insertions(+), 59 deletions(-)
>  delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
>  rename recipes-core/swupdate/files/2023.05/{0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch => 0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch} (76%)
>  rename recipes-core/swupdate/files/2023.05/{0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
>  rename recipes-core/swupdate/files/2023.05/{0004-d-rules-Add-option-to-enable-suricatta_wfx.patch => 0003-d-rules-Add-option-to-enable-suricatta_wfx.patch} (69%)
> 
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
> index 4203061..d92860e 100644
> --- a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> +++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
> @@ -1,7 +1,7 @@
> -From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
> +From 8d9d7b561f311b2bd2757ee3f14ca51b22563118 Mon Sep 17 00:00:00 2001
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
> +index 05422d68..97afc92b 100755
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
> similarity index 94%
> rename from recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> rename to recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> index 857b4ab..f6092af 100644
> --- a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> +++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> @@ -1,7 +1,7 @@
> -From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
> +From 81e9c0d781314bfff479bd5cb6a778f5d4e08ac3 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Fri, 16 Jun 2023 19:43:38 +0200
> -Subject: [PATCH 3/4] d/patches: Add patch to add the build version to swupdate
> +Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
>  
>  The build version is only set if build in a git repository
>  this patch allows to use the version information stored in
> @@ -77,7 +77,7 @@ index 5638bbf5..12324569 100644
>   use-gcc-compiler.diff
>  +Makefile.flags-Set-version-if-git-returns-no-informa.diff
>  diff --git a/debian/rules b/debian/rules
> -index 8cac6359..566a21bd 100755
> +index 97afc92b..18cd7643 100755
>  --- a/debian/rules
>  +++ b/debian/rules
>  @@ -17,6 +17,8 @@ export DH_WITH=--with lua
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
> index 9c5ebd3..8a5bd82 100644
> --- a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
> +++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
> @@ -1,7 +1,7 @@
> -From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
> +From 319f0d2f54781ef207bf16a4c85dc8de20796ed4 Mon Sep 17 00:00:00 2001
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
> +index 18cd7643..9635adb1 100755
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
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 762fac2..8d50ec3 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -22,16 +22,14 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
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
> -
> -
> +SRC_URI += " file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
> +            file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
> +            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch \
> +            "
>  # The option: "pkg.swupdate.nosigning" disables the required signing
>  # of update binaries
>  # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> @@ -39,9 +37,6 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>  # deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
> -# suricatta wfx requires suricatta lua and the dependency
> -# is not set automatically
> -DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>  # add suricatta wfx
>  DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>  

-- 
Siemens AG, Technology
Linux Expert Center


