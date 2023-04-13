Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5FC77B6E
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 19:29:30 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.80])
 by mx.groups.io with SMTP id smtpd.web10.608.1681414162530383333
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Apr 2023 12:29:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FmHydmDI;
 spf=pass (domain: siemens.com, ip: 40.107.15.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCogAUHZQVQIQnv0De/8tX+kggosuKThCYSpHWE8X4ZW0U1zxcggdUiz8EEUJtDZJq0t2inVmJNwz8qrzGkA0S1odAm4cBydvg3gn7/3VT9/ohz4nSbCjP246HMbXdCOdBz00mOcSK0U+dC2e8NiCDUwxUyYRbFanZHvOLSGlPSp8uz6GMH7ONhwEqfbjeWGOZEBO6S2yEMzxl46euRYCVdSAj2jyDUPxf2POQ8i9+n9wtX+kz9PjvwqRFJpSBttlod0ECUAp6gBMhClyJ5hj/hbgPaiCnqcLvuzZmNXB1XCwXe3xy8sjKdfUiYe3sOMl70sdMdeK/PAY9dZTn9iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DL95H3aXlUGTZibQbGm80uLYAYjMdrp/s5+TmVmty8=;
 b=U5lvu3hL9XF5HWDYy4XYvYqJ5wqX93HCTqnQTQE0JmShyWZJK+Gi1kLu9jKh99dYlTp0JZL3sDE5qdYh/gwJkhhLVYGPELY3yifTxv5JCE3t/uzlTS9dSNZAgXmDSnzRojSnWtDeLbsTk7kayNQyeErf6dJcY6bN5Km6BGdNlxKh43pyABV81iLsL+LWMg2J6d9N1FG4faC8v/c6q9MNKoFf1Fk1Oe95eKhuhy3edv3aXPE0MvMa3M/69xIFk0SQGbWp8Kj8ENcd78sS0dmqTil5hvTo+oX9fR96HGwOY0ApVaLouo3+TbsEcanXAEozFdSbEox4MrNR2n4NP5PJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DL95H3aXlUGTZibQbGm80uLYAYjMdrp/s5+TmVmty8=;
 b=FmHydmDIzrKMLdnLLJYGkyFLIgxnojGASHQNsmam9rZBMbP3ovkGE4PosibT6Y+WRH1bHSznFmgpAK4M4IAr4ahRoC5OVZIz8HpAP7PPUjfWf45qIpW3+0LZUNMOFPaEHQMliKcaSTqwU9gXtauMmKLRZAa+vMa+Qg4xCzWD26h4+WyQzO8ahmaGV0bwDhoDlXJlfnQKvYw0HVtdrFsV2R47xxiMT2QXSA/BfadYiIxSuO0iLn3R+jMuEjhRl11KH/tR9Gwy7s3dxd+5eYeU8WOhJsE5BMOxkHmlzhC2RRNMOsBUAm8T9pFl7dj67NmmnCCOHm83LQPe5mbFurFViw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.5; Thu, 13 Apr
 2023 19:29:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 19:29:19 +0000
Message-ID: <064dcab1-97a2-c65a-6a3a-edbc760e5562@siemens.com>
Date: Thu, 13 Apr 2023 21:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] efibootguard: use debian
 folder from salsa
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230310182003.201194-1-Quirin.Gylstorff@siemens.com>
 <20230310182003.201194-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230310182003.201194-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbafa5a-54d4-461d-c5db-08db3c55602d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	brNuVOqe4rufwQ80fGQGDJb63h6iUutyGG0anetXD3kekWmgNCYlmX4M00W4X0TUrGkNoGsM9HN6o5jUo3UiuSRQ5v9unLc08r6ulSTnzoiRLTxJmIOPAOunajeV/2IrVN+Q9sy1UmKx2kGZ9R026R2ola3ADasi7p3igxUBeQek8yVPTCKZbrvVtBmdEvEKtnMLLck9YrIHemJveaB//C945f/MOfuEWOfLEAHl24i2LHeVc8QH8hvUb1eW2vi+7nPPfo9hXZdxeTtAKqNyHXN5qfwBa756NSmTWh1dHZDg8z34M4iEsSePgK1GxBK+iG3nh2cfpf6jfM88O1fj+40FQ6OvhZplRUWEop+KDhpMlgWiS6SYuzRpCTpenCvtHGgyeEQm0N3993f73u9QL6/qKSOhscKWNT/EwPZL2xwL53UXSJ8d5HZoMdbykP0EiBQVzxvMB9Hy4FUrhodm3wCFQWcERYDBhNtb395j3Z1EL92QniH40HDhTLHm1kfDGOyaQvUwhDo0RPUUDu5XQIG/7gzEQXeyTw91J/X+zImY0AGSAa8l7nOHNSa1XuBrz+4Gg69YFBq29doQAl6r/F/6yiyB9n025oDJXMH7adUorIIBTd2T/s5LQthm5KgnwM+jk71kN579k0PmwJT9z6e/xwJ/Kn5Su1gSaDhi7z++5XXC8cHaBzEm5hVrILep
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(83380400001)(2616005)(53546011)(6512007)(186003)(6506007)(36756003)(26005)(6666004)(966005)(6486002)(478600001)(5660300002)(316002)(66946007)(38100700002)(66476007)(66556008)(41300700001)(31696002)(2906002)(30864003)(8936002)(44832011)(8676002)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXc0eWlIaHd6bzVHcHlkNkJ2T29yL0xVc09GVTBhMkVITWlUTU1SQStCYmU5?=
 =?utf-8?B?bmgrMXZTTkd4clNoL0tjWDBsYkJocS9teEg0d0l3aEF1b0oxeDNYSEVVQk9x?=
 =?utf-8?B?MldOSXkzRHBGd2dGYlYzbVB1WEZRYmp1dGJycW8yUUswdjI5WjhFS2FCWmIz?=
 =?utf-8?B?cmhFeXFCVUgyOGpycW15Q1UrQTEwbXFMOWhTMjFaTnpKeU9ObHBKNWdTeDJS?=
 =?utf-8?B?K3pCTzRxb2lKWndaQnpzRkxyMkdSaE1kbHZWVlVCeHZUNXBoWHhyRVVBWWRB?=
 =?utf-8?B?aFViNnZybWpYZHdxc0NqVUtWTjBxa1lzQ3JtNGNzU0ltcDlPN2hOSDFCd3A5?=
 =?utf-8?B?L0JKR0NHYUpETFdLMlFaTDVVVnlzVlRXWTU1c3dSbjY5WjZhcHg3OEdvaHlj?=
 =?utf-8?B?NzZPOHNXeTNVWERsTjQ3VThOOUxjMTVUdnc0N29QN0oxWmkrU0g5Rm56cHkw?=
 =?utf-8?B?ZG9Ia0JCc1Bxd0FnWTJoZmZMdll1c3Faa2NQQnpkSGM4bGdNUU42bDBIVmxZ?=
 =?utf-8?B?czN2a0Z1cmFwSEoxZ0p1UmRGTWpWNmxTOHRXd1prOVBNcXJhcTlWMW1JVC9j?=
 =?utf-8?B?VjhnZFllTHpyNnlOV3JFTFk4VlNLYzQ3Wkc3Qmpscy8xZUZOWEdVVnE5NXBU?=
 =?utf-8?B?dEFYMlJYdEJ0ajVVNlFDbzRuSy9xTlgxV3J0elNERURZbUYrZTRPMTZYTlJV?=
 =?utf-8?B?R2dnbG9QdmZYdUdHQ3ZIYm0zV3l4djNWV3A3TExSeVhlVmhmcllIR0srK1BX?=
 =?utf-8?B?cXF4NEo1RC9VOFBqYndZeGx1T1M2YS9CTVp3WkYwY2pUT0I5cXQrMnJ5c25I?=
 =?utf-8?B?QUx5UEo3bFAvNURVYXJjc081cUZONGRoS1d3VGczaDJUQ1dLOS9uTXdsTlZ5?=
 =?utf-8?B?Smc4d0R0QnoyTFVvUjlPdW0xYitPTzY4ZFIreUZScURPeElCZG9rZUFFSlcw?=
 =?utf-8?B?UnpaL0ovTURKMzI3MXpzZ0JrS2I0LzlybDBvRkFUYlpEMUIrUGJmSFFKbXY5?=
 =?utf-8?B?UTZSZWFtNHUvYnZsUkN6R2VJOFArNFVmZVZ3aUhWTE1xQjF4ZUdaY2hjdmRG?=
 =?utf-8?B?bDQvMGRjd0g0a3lrc1dYZWQ0Wk41eW50V3Q4a0NBaFVSbTdhaUREUEg1QTQ0?=
 =?utf-8?B?QWJFcVNpcUV4NmJDNmVkZ0lNNGNoUmxrU09QVm9KWitmMkdRbzdvYVJGbGtO?=
 =?utf-8?B?UzRtVzJ6N3Q3Uzl3alE4OWVlZEIxTnZOZ00vQVJDWm5UTndBYU4xOFZEZ3JU?=
 =?utf-8?B?NDZRUXlkWm5VSlpXQzA1UW1Ra2pPTFNFeWZDM1JIdnZGRGU3dko5QXMzTVFF?=
 =?utf-8?B?RVFHSFN2RW4rTnJ5a1p6b2hhVEIxcWpidURkSWptVzBTSldaazVnMElZUWRl?=
 =?utf-8?B?a21hZndyQkp2dGxScENQN1NLbjgxbktpQ1hsTGhTcC8vVFJmTkdyME43UW80?=
 =?utf-8?B?LzAvVFFndklCZEZZbnYwUTRmWnVmUi9ISVQ2Wjc5eUI2dzVvRTNYU0xJRG0x?=
 =?utf-8?B?clI2dTM5eTFvdXp3VzdnT1NDYWVsS1drbGNzUkxORVJDVFFJZG1PRi9NWng4?=
 =?utf-8?B?Q1JYUkx0WllhL0NhOHRCbldYUFFjdlZhNG1jbmgxQW01Y1lHNkNMV3VSKzhN?=
 =?utf-8?B?NTVEbGhMQ3pEVnlLNmtRaGo3SlMzMDFremRkMWkyOUR0YU9XU2tzT0tKelow?=
 =?utf-8?B?ZUpLZXdyZ1RtWFpLRXZRclJ6OEVoY0R1bTdPR3F3NTcvQU53a05zd0ZpMHVK?=
 =?utf-8?B?S0dyUHlHaVRBdjhmMzRpY2FRYlc1WkFOQWFQZWw3OUNiVG1BTTl4aDJWek8y?=
 =?utf-8?B?WHVYbHhHbmNkcW9lSDAza3MxT3N2M09PVkpxTHhzdFFrVmtHTkJlV1RsaURr?=
 =?utf-8?B?aUNLTStKRkppOElGSlhrd3oxVnhNTm1SWkx4Q29meE1aMzBNc2pJcUlZaXA1?=
 =?utf-8?B?ZGMwWjFyYWdZMjNVaFFSRGIzVVBVMDRrdlAzaEFzby8wSEJ5V2JvVVkrMDgv?=
 =?utf-8?B?aFZhcTF4M3JQQ2dTL2J6bTBrNy9udzY2TEVmMlpuWDhvRDhJUC9aaXFoRUky?=
 =?utf-8?B?dkJ6VzlmMmtaQnlMUXpYdGhDbkh5ajNrdmIxZ3NsL2h1S1JEYzBmbjRCVy8z?=
 =?utf-8?Q?zB5hFgyu8OAIcD0SiPzrog7NX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbafa5a-54d4-461d-c5db-08db3c55602d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:29:19.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJw/vFr7uRgkY8gLYwdsXxCObzxrMKxH1qyoynPTo+XqZxXO1zMmpc916lg2WlSRjsYw9J9cyvXlC74BXakwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 19:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11197

On 10.03.23 19:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To avoid package name conflicts between cip-core and Debian upstream
> use the debian folder from upstream to build efibootguard.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 31 +++++++++-------
>  ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
>  ...rol-remove-native-from-python3-shtab.patch | 26 ++++++++++++++
>  recipes-bsp/efibootguard/files/debian/compat  |  1 -
>  .../efibootguard/files/debian/control.tmpl    | 20 -----------
>  .../debian/efibootguard-dev.install.tmpl      |  2 --
>  .../files/debian/efibootguard.install         |  5 ---
>  recipes-bsp/efibootguard/files/debian/rules   | 15 --------
>  ...01-add-machine-type-name-for-riscv64.patch |  0
>  recipes-core/images/efibootguard.inc          |  5 ---
>  recipes-core/images/swupdate.inc              |  6 ++--
>  recipes-core/swupdate/swupdate.inc            |  2 +-
>  12 files changed, 84 insertions(+), 65 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (53%)
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
> similarity index 53%
> rename from recipes-bsp/efibootguard/efibootguard_0.13.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> index dd76198..368cc1d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> @@ -16,25 +16,30 @@ LICENSE = "GPL-2.0"
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
> +    file://debian-patches/0002-d-control-remove-native-from-python3-shtab.patch \
>      "
> -SRC_URI[sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
> +SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
> +SRCREV_debian = "78a14cbde6ac1d2132a61bddbea7cf39b661d82a"
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
> @@ -43,10 +48,10 @@ python() {
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
> index 0000000..844eae4
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
> +2.39.1
> +
> diff --git a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> new file mode 100644
> index 0000000..1c6cdc1
> --- /dev/null
> +++ b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> @@ -0,0 +1,26 @@
> +From bc54a466bd48b78a9761a38a7f3b3cf67b19469d Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Wed, 15 Feb 2023 10:47:38 +0100
> +Subject: [PATCH 2/2] d/control: remove :native from python3-shtab
> +

Why do we need this deviation?

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
> +2.39.1
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
> index bb1aa1d..cdf5558 100644
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
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
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

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


