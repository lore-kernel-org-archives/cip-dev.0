Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7449C7618E
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 09:52:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web11.4001.1682502730743500348
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Apr 2023 02:52:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LrLa7oCd;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogwTioBhgJh7G7ZgpOqe9TCPJSIoUW2oCBMIHXqK+R8xLcXW+GipOE5wrKPDSPar0xz2pZpU4qf5hyKzW9ev3AglzM6ekCupUlge21zxe/+nUbfm5btXdP4jSfcjq/KI6mrW0+dC/ep0lqDcg2Uyoc4ocBzzcETiSKxsaHEw1BPt17qcrsJXp98a7Y4OkWlMbEtqNFGw0VdBUo7UZDph4vKYq8ROfuK2WXhtMgNHIu1TVHQPTe0e68l/5/KzhbmtvAtR7EkyufGvzfrGaN7E1mk7JoWy34quAPuQvXZz6Y51nHU3veWW+ctHGJyvfLDG9/EbW0UHB716IxTek5CBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iisg50iAyoXgk2VnQIxk6CEFo5IXpXaZjoobOGPSxVA=;
 b=UjqF4sM6PqYvP48lJvb1Er4aFsJor7Uk7fzTzlAe+7V3iyD9HELda3KVAJtnkH4gro5srnaBnjBbP8W4vRNhOCKAcGBn3Yb5jEnw6iZJcbMUJ2RY3L7PgER3ev70kiT6gcVJlq+WzLcvK03G6ZHFEbIGYC9UYJokBnFu2yQTajmNryRGkQjBVgKn909fk7SVdNKygyhPJoM5U0/qQZJNt3U3vO+Lpt3VDp3XbVBab6mg00ubjYpcPp+FfMo+rGmYmnPWYecGmmT3MScfk1P0am32nxwfJ+dtWXpDxngszokCtoyZ0mXpCIyQz7zhpSB51BZhddYzM01NYTZI08Kwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iisg50iAyoXgk2VnQIxk6CEFo5IXpXaZjoobOGPSxVA=;
 b=LrLa7oCdux4ptbdxWEkU39o7sHsbkOLA1k6CEFga6AeFbPHiIJduQdWOhAuL0Oe4ufZ3UDGZCT5sR5m6biF425ccNSASkl7dr0/e3m7EbJ12oIvbX9r9KZd1FrEcMI1xglMPXy2s3pF8far2Xaza7ztO/ElpYPIe3Agzf2+HEfCicSbMgx2H01D2UrT+3JVPO1j3NlhWJ1cUe5sh2m+PDJZON606go7g3o6fZ4PD8S6IiGvjTtDBIFpZckf7kd4CdL7jmDe1Bba8kwVzXpJSH7fERLAKVrvwVUVPlH27AhmMBixaOIymjil1TLaykY4HDwozf/3dO2y1DrxbKtDrTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6397.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Wed, 26 Apr
 2023 09:52:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Wed, 26 Apr 2023
 09:52:08 +0000
Message-ID: <5b42f08f-f49e-f207-8eec-bfd57bf79d36@siemens.com>
Date: Wed, 26 Apr 2023 11:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 1/1] efibootguard: use debian
 folder from salsa
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230425073005.584868-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230425073005.584868-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba0c43c-8e7d-4bc9-3142-08db463be628
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iIgbMOz0AoZipyNIigWKofzS6hfu03+kRidwyOkvREzRLaLi36Af/pfEfk0bCTZPUCfyMwrzFHKnrSf7hWHAAxTFAVeNzkelwAy2iV/URkBHq/RL8cd3/tz8EAn7SsFEeglB4TqfJcYZ60ZA7VrpV1iWboH5u8RUmo7+C2ehG4gLBlwZl52t2/TtVYiXYWyFyOyV35pHPCb2B4b0u00HiG51JYuUJhJIDjwP4q8MsBGsiykCMwYRvDa7GlRNzpWoDN6F7GO4GPTNe1EMHTEa8BAKGOr5pPgywroI/jn7lHJVg7ALSOGqEhDVdlUyhMThCqBX/o5OYIq0GEwi9HdLAh4axhzpAXhCbkpjsV5iejZUaszpX+UJNURejQfU6YfpjjK9w4AsTGMO7HiMmN3lX+npn7UmQ9HtU3IDOJ5S4l69s20CDlCTHrl9uYnYI6uSrbhLmiQ1okGOgb4AM74Kl+5rttyJF/dVSAfgeX0leL/KoEM4W/jBH84I2EsQg3OV3azaDV5SM9oI7Q2ixvmQqpYYbZiZ0Bd4pXhdberNJhW8+I9eIhfzVLvE4CHvhfD9aUmDH+9wDkL01+3RCbCfr+FFdr3AMBVXREGUmnr2LmUd1oFZou+dZ1p7nnaPRp4VYJds08TY/pCICcb+1+srcd9R5ckmKE2cfdXb/Qpm0XNAMZXOKcUi3+Uwn8VgduIx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(41300700001)(44832011)(83380400001)(66946007)(66476007)(26005)(6666004)(6512007)(8936002)(66556008)(53546011)(6486002)(6506007)(316002)(82960400001)(2616005)(8676002)(5660300002)(38100700002)(30864003)(31686004)(2906002)(86362001)(478600001)(31696002)(186003)(36756003)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mkdwbm9JWEFDUDNrTk9yd0dqNG5QNXdwVmZxNnhONjhvaExod0JxVWdnaURt?=
 =?utf-8?B?Sk1SZUJJK3VTMlJHN0ZtZ1lEMTFFOGQyclBxTEhTVEF4USt3alBNNnNnUjRG?=
 =?utf-8?B?Sis2NWpuUkduRzJRVGlwTUt1RmN5bmppZm1HUHAxNHVERXZOdEFibDE5ZUpB?=
 =?utf-8?B?ZWhtSjFxNjJoZTY4Y0gzR0x6NlAyQittSjZDOWhKVmZFMU90V2c4NjRIZEJ3?=
 =?utf-8?B?b3lPajJsb2tqYVFlWTVKQjRpVkNtN3NnTTBESkk1ZG5BK3U2c1RBRzBGSmpO?=
 =?utf-8?B?dnRCNWxtQ3FDY1kzVnltNUQwZUZpRjdjcy9NZ3VVWjJOZ2VMSEZkRHB6UlhZ?=
 =?utf-8?B?VlJic0orNGZOaXErTHZ2aldMTjNkZTRsZTQ2V2dFckx6cGNISjhDZHBmQnBY?=
 =?utf-8?B?akVxYUNwOVU1b3JPTTQ4OWNObjJFMXpZa0taYTA4YUpqSWZRVWRkQ0xQeFRF?=
 =?utf-8?B?RmZrZkxMemFVQjdSVHc3dk1oMkE3eUtxczRZcStHOEhKMDhaQVk2bUViejdN?=
 =?utf-8?B?WXVrckFhbFIrVlA1cnpSWUZ5UzlFSWRNMS9wc0plY1BPenRzN1lqdkpRY2tF?=
 =?utf-8?B?N1dZMXM3NHI2aVBmMDJ6KzVnSnV5RUVIcjJaRVFWUUEza1JUWldZUVJCYUFF?=
 =?utf-8?B?eTdsaDZpblhsQTNTUGEwZEx0aXZBeHMyZCs2MzdlZ0c2WUZSUlR1VnVpNWRo?=
 =?utf-8?B?ZjcydkNaamJIUW4walpMa0FLN1JWL2pvVjhsTGdjVG1uMTdEc3QwREtHb1RP?=
 =?utf-8?B?eFRHSHdzQyt0SFNNYkg2RnQ0UjhCSzlRQmdHN0FRL2tPQSsrNFROS09oaUtI?=
 =?utf-8?B?T0NZRDVueWlBalF5M2ZhQ0pPOEdTaG45NkJQRTRWMDVTS0NlakxiSlpqSGFr?=
 =?utf-8?B?dWZSaDFBMVBITUMrNExzVkRBTXVJR1M2WXNIdTNWVDNxU0t3RDlzQlFxcVhE?=
 =?utf-8?B?a0VXMDRmVXUxaWxxNGl4eDFhRytWa0dGOUx6OUh5R3JMZUJhVy9xUzdJRHhG?=
 =?utf-8?B?dkxxTG1DR1V0eGY3Mm9VTjRkSlVtbE55N08wdkNEdUFqaS9pa3ZGMkcwckh0?=
 =?utf-8?B?b2p5QXJPSEZsUSsvcWpreVAybC8zYmdsUkJmaVV6czVWVUVHb3pNa21kdDBl?=
 =?utf-8?B?SHArNnZmV04yd0ptQ1BQWDlLL0xMalZxRXBNY00xSlIyZ0lXTkplT0JhWXQ5?=
 =?utf-8?B?SDkwUGVzbnp2d3RWUXFvcm9DcG91WEtwUUpvYXhsb0dJdzRDQnZ5RExZT3pr?=
 =?utf-8?B?ci9QNDkvd0JabGJEL1JzRVNqYk5tV2NObmZOZ3ZicURxUERFRE53aVdIMzBm?=
 =?utf-8?B?RTNpc0FIYk5SK3l2ZTZJb1JEUG84ZG5MK3lKSW50K05MUlZFd01Kcm5pUDk0?=
 =?utf-8?B?NW03OUFuOGxTQmFXN3cxVzZZYkdXaG9IMUNBZ1lyeld0emxQYTk5OHZDc2tw?=
 =?utf-8?B?RTBoeWFESVB5ZjdNYVNxaTJnNkNyRHNtUnNySFN5YmE1dThhaG1KcHh1emFU?=
 =?utf-8?B?eWFjUkdiem1IUnU2Z2N0TjQ0alVQZzc5ZUFkbXg3Q2Q0NXVBdUlVVWVzQS9i?=
 =?utf-8?B?UFNucWpQYytzcXYxclhLejdCYU5ROXpnM3FkanZtZ25NdlhxME1SYlQzZ2xV?=
 =?utf-8?B?U2N2NlNCK2pOMDZHUjB1SFBHcWhHL3BNMFdyNkpCV0QybFpPLzdHNVVvZE1L?=
 =?utf-8?B?VTdUVktCdkhTNDc0SmNOcTkvS0dDWGhHendVaEdVRFMyYUJRTVI5dVFCK2R0?=
 =?utf-8?B?bitiRzY0MFpDRXowRVFYek9MY3kzUVFZNktWRDRBbUJLYk8xV21POUZmZ0Zi?=
 =?utf-8?B?MUJWWmRLbWhIZytiSEJKZEYvTmV3MDkvMEltMlQ5ZFFEZHZDT2V3eFE2RjlK?=
 =?utf-8?B?d3FGNUZMZytPcVdVSTM5Qjg3cmc5Nkg5Y0lWN2JJNnA3cm9NQ3pScEI4c3J3?=
 =?utf-8?B?QjM5Yjk3UDdKSlNGcnU4cjRTZ01Bd3Rpb1psc0x6b2dDRnExc3dBZGhqdnJt?=
 =?utf-8?B?MWh0TnRySDVuZXIzcUthWHh1WmdtYzdaQWkzTDlDcUxlS0xhRHZxVFF1ZGcz?=
 =?utf-8?B?UXJieHhmNC9Pc2x5c2ZDOWErZVNVOGQ1S1J1aXpiTDFCZjNEMUN5aUUwV1Iy?=
 =?utf-8?Q?IItjKV1wYXZnbW/HILZCRQJeT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba0c43c-8e7d-4bc9-3142-08db463be628
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 09:52:08.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q4lCD1ulZpj5FUXizgRndNGPWe4Yw29ymz4NQ9eTcBjh+n9SV35xs/yTfyh5ESF2O9INguucO+o0DKEGsQn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6397
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 09:52:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11352

On 25.04.23 09:30, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To avoid package name conflicts between cip-core and Debian upstream
> use the debian folder from upstream to build efibootguard.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v5:
>  - upstream patch 0002-d-control-remove-native-from-python3-shtab.patch
> 
> Changes v4:
>  - readd patch 0002-d-control-remove-native-from-python3-shtab.patch to
>    allow build for qemu-arm64 and qemu-arm. see https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/844580247
> 
> Changes v3:
>  - resend only efibootguard as patch "Enable Images based on Debian 12 (bookworm)" is already deployed
>  - rebase onto next
>  - remove unnecessary patch 0002-d-control-remove-native-from-python3-shtab.patch
> 
> Changes v2:
>  - rebase onto next
>  - always build efibootguard
> 
> 
>  ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 30 +++++++++-------
>  ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
>  ...rol-remove-native-from-python3-shtab.patch | 28 +++++++++++++++
>  recipes-bsp/efibootguard/files/debian/compat  |  1 -
>  .../efibootguard/files/debian/control.tmpl    | 20 -----------
>  .../debian/efibootguard-dev.install.tmpl      |  2 --
>  .../files/debian/efibootguard.install         |  5 ---
>  recipes-bsp/efibootguard/files/debian/rules   | 15 --------
>  ...01-add-machine-type-name-for-riscv64.patch |  0
>  recipes-core/images/efibootguard.inc          |  5 ---
>  recipes-core/images/swupdate.inc              |  6 ++--
>  recipes-core/swupdate/swupdate.inc            |  2 +-
>  12 files changed, 85 insertions(+), 65 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (55%)
>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
>  delete mode 100755 recipes-bsp/efibootguard/files/debian/rules
>  rename recipes-bsp/efibootguard/files/{ => src-patches}/0001-add-machine-type-name-for-riscv64.patch (100%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> similarity index 55%
> rename from recipes-bsp/efibootguard/efibootguard_0.13.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> index dd76198..0ff8b0b 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> @@ -16,25 +16,29 @@ LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>  MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
>  
> +
>  SRC_URI = " \
> -    https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
> -    file://debian \
> +    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
> +    git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
> +    file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
> -SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
> +SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
> +SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
> +
>  # add riscv64 support
> -SRC_URI += "file://0001-add-machine-type-name-for-riscv64.patch"
> +SRC_URI += "file://src-patches"
> +
>  CHANGELOG_V = "${PV}+cip"
>  
> -PROVIDES = "${PN}"
> -PROVIDES += "${PN}-dev"
> +PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  
> -DEPENDS = "python3-shtab"
> -BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
> -BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
> -BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
> +S = "${WORKDIR}/git"
> +
> +PATCHTOOL = "git"
>  
>  inherit dpkg
>  
> +DEPENDS = "python3-shtab"
>  # needed for buster, bullseye could use compat >= 13
>  python() {
>      arch = d.getVar('DISTRO_ARCH')
> @@ -43,10 +47,10 @@ python() {
>          d.setVar('DEB_HOST_MULTIARCH', proc.read())
>  }
>  
> -TEMPLATE_FILES = "debian/control.tmpl debian/efibootguard-dev.install.tmpl"
> -TEMPLATE_VARS += "DESCRIPTION_DEV BUILD_DEB_DEPENDS DEB_HOST_MULTIARCH"
> +CHANGELOG_V = "<orig-version>+isar"
>  
>  do_prepare_build() {
> -    cp -R ${WORKDIR}/debian ${S}
>      deb_add_changelog
> +    cd ${S}/debian
> +    quilt import ${WORKDIR}/src-patches/*.patch
>  }
> diff --git a/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
> new file mode 100644
> index 0000000..bf02a8a
> --- /dev/null
> +++ b/recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
> @@ -0,0 +1,36 @@
> +From 299b2fecb4be67b3b669762a88cb3376a9fd5628 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Tue, 14 Feb 2023 10:30:34 +0100
> +Subject: [PATCH 1/2] d/control: Make compatible with debian buster
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/compat  | 1 +
> + debian/control | 2 +-
> + 2 files changed, 2 insertions(+), 1 deletion(-)
> + create mode 100644 debian/compat
> +
> +diff --git a/debian/compat b/debian/compat
> +new file mode 100644
> +index 0000000..9a03714
> +--- /dev/null
> ++++ b/debian/compat
> +@@ -0,0 +1 @@
> ++10
> +\ No newline at end of file
> +diff --git a/debian/control b/debian/control
> +index fa7867c..8b92019 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -2,7 +2,7 @@ Source: efibootguard
> + Section: admin
> + Priority: optional
> + Maintainer: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +-Build-Depends: debhelper-compat (= 13),
> ++Build-Depends: debhelper,
> +  autoconf-archive,
> +  check,
> +  gnu-efi,
> +-- 
> +2.39.2
> +
> diff --git a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> new file mode 100644
> index 0000000..42204a5
> --- /dev/null
> +++ b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> @@ -0,0 +1,28 @@
> +From c599480bdec0ed57922d100dceb5c94d04755694 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 15 Feb 2023 10:47:38 +0100
> +Subject: [PATCH 2/2] d/control: remove :native from python3-shtab
> +
> +This fixes the cross build for qemu-arm and qemu-arm64.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + debian/control | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/debian/control b/debian/control
> +index 8b92019..53e2b66 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -9,7 +9,7 @@ Build-Depends: debhelper,
> +  help2man,
> +  libpci-dev,
> +  pkg-config,
> +- python3-shtab:native,
> ++ python3-shtab,
> +  zlib1g-dev
> + Standards-Version: 4.6.1
> + Homepage: https://github.com/siemens/efibootguard
> +-- 
> +2.39.2
> +
> diff --git a/recipes-bsp/efibootguard/files/debian/compat b/recipes-bsp/efibootguard/files/debian/compat
> deleted file mode 100644
> index ec63514..0000000
> --- a/recipes-bsp/efibootguard/files/debian/compat
> +++ /dev/null
> @@ -1 +0,0 @@
> -9
> diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
> deleted file mode 100644
> index 626d43f..0000000
> --- a/recipes-bsp/efibootguard/files/debian/control.tmpl
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Source: ${PN}
> -Section: base
> -Priority: optional
> -Standards-Version: 3.9.6
> -Build-Depends: ${BUILD_DEB_DEPENDS}
> -Homepage: ${HOMEPAGE}
> -Maintainer: ${MAINTAINER}
> -
> -Package: ${PN}
> -Depends: ${shlibs:Depends}, python3:any
> -Section: base
> -Architecture: ${DISTRO_ARCH}
> -Priority: required
> -Description: ${DESCRIPTION}
> -
> -Package: ${PN}-dev
> -Section: base
> -Architecture: ${DISTRO_ARCH}
> -Priority: optional
> -Description: ${DESCRIPTION_DEV}
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
> deleted file mode 100644
> index 948019a..0000000
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -include/ebgenv.h usr/include/efibootguard
> -libebgenv.a usr/lib/${DEB_HOST_MULTIARCH}
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> deleted file mode 100644
> index 01cf974..0000000
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -usr/bin
> -usr/lib/*/efibootguard/kernel-stub*.efi
> -usr/lib/*/efibootguard/efibootguard*.efi
> -usr/lib/*/libebgenv.so.0*
> -usr/share/efibootguard/completion
> diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
> deleted file mode 100755
> index 9c3b916..0000000
> --- a/recipes-bsp/efibootguard/files/debian/rules
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#!/usr/bin/make -f
> -export DH_VERBOSE=1
> -export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
> -include /usr/share/dpkg/pkg-info.mk
> -
> -override_dh_auto_test:
> -	# we do not run the tests; that avoids having to pull the fff submodule
> -
> -override_dh_installchangelogs:
> -	# we're not interested in changelogs
> -
> -override_dh_installdocs:
> -	# we're not interested in docs
> -%:
> -	dh $@ --with autoreconf
> diff --git a/recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
> similarity index 100%
> rename from recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
> rename to recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index ce08f0a..604c9d7 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -10,11 +10,6 @@
>  #
>  
>  IMAGE_INSTALL:append = " efibootguard"
> -IMAGE_PREINSTALL:append:sid = " efibootguard"
> -IMAGE_PREINSTALL:append:bookworm = " efibootguard"
> -IMAGE_INSTALL:append:bullseye = " efibootguard"
> -IMAGE_INSTALL:append:buster = " efibootguard"
> -
>  WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 817fce0..ebc844a 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,9 +12,9 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> -IMAGE_PREINSTALL:append:sid = " swupdate"
> -IMAGE_PREINSTALL:append:bookworm = " swupdate"
> -IMAGE_INSTALL:append:bullseye = " swupdate"
>  IMAGE_INSTALL:append:buster = " swupdate"
> +IMAGE_INSTALL:append:bullseye = " swupdate"
> +IMAGE_PREINSTALL:append:bookworm = " swupdate"
> +IMAGE_PREINSTALL:append:sid = " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 53b8133..e5e7282 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -26,7 +26,7 @@ DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>  def get_bootloader_dependencies(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>      if bootloader == "efibootguard":
> -        return "efibootguard-dev"
> +        return "libebgenv-dev"
>      if bootloader == "u-boot":
>          if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
>              return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


