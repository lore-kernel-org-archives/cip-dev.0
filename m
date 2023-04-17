Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE6C77B7A
	for <webhook@archiver.kernel.org>; Mon, 17 Apr 2023 18:39:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.82])
 by mx.groups.io with SMTP id smtpd.web10.4547.1681756771643899652
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Apr 2023 11:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z+mKub0o;
 spf=pass (domain: siemens.com, ip: 40.107.7.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwybpYxQ5PsBvL/dW9lHplHNFiajdXZGd0MZnRJ5dAojX0CYnzK9d1ylUtNL1RvPQX/DuO32WNta/6Kw/lV4hsr+4bGA3RsT9Obnjo1uKvZlYaI8Ss2K1DwSZFGR4bMZeULl2fMVUY0UBdTytgiRe0tJ4pI+SV+2NLUbrhX81akHqTYxFJdX9i1HpmmuiCoP6cbaR1YOVQnTwt3/RFKGr684LEZn+ieimUcGeKBeNEvsKSJ/GOpNNl294JbM3xjHkhcCtSHEA+KPwyGAR3NPQ7QZ0GyHNkTDwyekg6XP6GdCmEo5mxZXhw6qGzelCTpIzIZVb2K45r06cWjiJj3s/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxRnAKH74jHLoxbqDCPDZ09WEnILqgXkpc1E+K1HiQs=;
 b=WornXSKfHILFxIM2FuNGq+qWSN2/wrfl5KON1WdO/ZzyT8O7vT2a8P6PQbahgVYt26f8CaqH0oTf9Q76RN0UcBLan6Yu0SnH5IPxEXMMyGiqqvfEfvw+WAhQJtt45Q3zh4xrehEsnqCqylikoOAWhUdeN2U6dAX/1vojM4k4Y6Xqr1cVUFGwJ5M5VR4OFNLsHX8u1HLbTqAo1eDG/F/qdHg7dWucEFYmnKNeBRHclmtIRJDBcX5A0fKjMjcBsLuj3LEYMCn6seEhltyTLENJeXU7gS44ECe/j9/kiNpFbyp8Js1iK3CAt+nynt2225IGLlagYjxTNRnyiuEVkAe0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRnAKH74jHLoxbqDCPDZ09WEnILqgXkpc1E+K1HiQs=;
 b=Z+mKub0oPbWoapsMDKqDrOreXkLQKWGurmKbY7kiXgCd7DP4ZrcJGV7J4A6R16K8Se4pqkGdfPh2wrNMSa2sUjEVRzL8hwkfFRbSu2V7I5jCRXRKCHlI6fjPq3jHO0cDargPWaV1Mnb1TMcmr1lADJ83p5unwBiGvjjh0V12bbr2bwZ801No5aaccR4FcnQ1CH1XYY426sg9RlvYYstl8ILVuxDuWwrLyulhRsj6e6V/GVQMtI4xax6s/NXMswEW3CQWV7kQqKaVJiKGG5cTGMEVHQjdm4O//lBmmAR0/j2WgTT+K9vpsy7YaAKMJ9Q0g8dSwDyCBorMYr5l9juspg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:162::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.19; Mon, 17 Apr
 2023 18:39:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.019; Mon, 17 Apr 2023
 18:39:27 +0000
Message-ID: <3354e3b1-9cb2-aedd-0284-586dc8e77ed1@siemens.com>
Date: Mon, 17 Apr 2023 20:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] efibootguard: use debian
 folder from salsa
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230417120431.356950-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230417120431.356950-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8807f6-147b-47c4-192b-08db3f7312a6
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	guv776KUaX8qYxrk6pzzPtU4bPKew+Kh1uLlYVSijABONcEG3a+ibbyxLWNhPkwbySGPXB0n8ojuuQFlIvKELSIxlDpevQdvl9V/A9FKlecyBI2SkJYwEfcAFe8yKMoZwL/xmq3gJSgcK/5GAQD1i54xST4Qz7ss5DfEcj2gG/prc30ptmtR8CLCZvue3y6kjgdn/Cf5d2nhftWoqhAR2zk6KofSG0492MEI/UeCs7XdfWhmPG4yz2FVwCRIihghq0h34prlhnPb5cy+DmDeMYRZrZIm/MXVK2earS613NaJXZPt2pvu5ce8oHqZJfZcmJu/IU4iGps7KbdtgG4QgPM8/FDcxrqeZMBbIp3G7hBPOAxaCZJAtHub1HudOvybjJsdsVB/airZ0voNxD/n62ynnN3AnMQv/q5RGJNzYSQNDQbCtFihLMFFLpilf5FdwnKnmLGJmzLnmB0mc9pza/0FTLqDE8/13B/hoWm/2ZKkrk2acXcdWbGp4Ck6e/i+xdAc9PN0eQhr6DYrj6JJDho+A8fb/HhR8K0igWO7KW8JhYPFj1T4EzOr7uVlEO9IWk8yfwP9K7VKBLyF5CHxsvsJ987c+p8CZG5Wv6qpQ5JAFGd3rlue5b1ElyV6nvZIws/QylbAdAEh5B9U8A6z99mMtYPhb+w2EoIcCvJfq/OZi8PbttuIJEsolNa+dDte
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(66476007)(66946007)(82960400001)(66556008)(478600001)(316002)(5660300002)(8676002)(44832011)(8936002)(38100700002)(41300700001)(186003)(53546011)(2616005)(83380400001)(6486002)(6666004)(6506007)(6512007)(26005)(966005)(30864003)(31696002)(2906002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akcwMjRwZ0ZEdUppL0RDWHJtVm9hY1BUQUxreXNibHoyM3NpY0dsZmd5M2RB?=
 =?utf-8?B?ajJFa3NxQWFVZlhhK2tvL2FzbzAxOWRiWHFSbTVrT1pBTkxSQlBESU0zVUdW?=
 =?utf-8?B?eWxQT3hYcXZ6c09aeFUvb0NpdGY4ZEgxMXI4dEg5ejlQNUpaQ1AxVk5xSkp2?=
 =?utf-8?B?d1UyTk9SNkpRb20wUzVtZHQzOTM2K1crQU9makhabGxYdFQzRGNuK1hHam1o?=
 =?utf-8?B?Ull2SXN0L2hsNUdobDFFaC9ET1EyZFVZdWMvV29mOVk1Rm9DeDV6ZEpYdE1t?=
 =?utf-8?B?bFE4SVNKSElYNE5ZNWhMd05aY2lSMzI1RFZjR1Brd2UyVUtvbElEbzVOQmFk?=
 =?utf-8?B?UjNGd1o1WjdQWUN2THhlallzZjhMRGZGWERvR28yb0EranpyMndVSkFVaDBv?=
 =?utf-8?B?NS9GYi9wNm5VS2Vsd1pyMTcyb05jMEIrbTFJaGtQeG1hZk1kdHZsK3NmelJt?=
 =?utf-8?B?Z2xyNDA0MkFNQ1orZlJ3ZVhkUGgrTjQ4cVkzZGpaSzZJVGRyK056N3E3bEZU?=
 =?utf-8?B?NUtYL1pCdm52aEtnOEx0OW14V1o0YVgrWGhSWktDdWt5cDkxd1kwS3dQaXJW?=
 =?utf-8?B?UXBOVm5TWVhuUzJESDAwRE0yOTlxSGxidy85VEcvZzVVZDlNVnNEWDNkdms3?=
 =?utf-8?B?KzJOdE4xc1QwRWJmeWNWRVhhSVp0cUhuUmMvQ1k1MW43S3FYSmRab1lwYWRk?=
 =?utf-8?B?VW14cmFiSllMZDZEQm5OWGdkc0FoNkFjS2pNV0pyYTkwNzBvTzU5NFVmZ0lJ?=
 =?utf-8?B?VmJKeVJ4cHlxRDJTakRVKzAvSTJTZWNPbGFNMkVJZE53dmxuYkR6bHFZYUhL?=
 =?utf-8?B?VWdDcENJaTdEd3l2NGNoRnJMb1c4VUhRUWUrRE96VUVKb2VJUDBEMldPRHFL?=
 =?utf-8?B?RmhrRi9yY3hRUSs0amloR2VLRVFvRXRqaFk5djBZTmxZNGdmeXhnUXZ1K0hU?=
 =?utf-8?B?ZEF2QnFneVJWdlVTaVdZYldha3VkSTBwY3hnQkVTTjRQaFB2bWozbUlrRlM2?=
 =?utf-8?B?Qm5PQzlmdm9XS2pqQlB3T3dJZElKMzMyMDRzSWszQXB6eHd1SGdVZkFHKzJr?=
 =?utf-8?B?em5ZbUcyQi9qNWF1Zi9DWWQwSlF6SWJJc2dkMjBEcUc4OCs0QjlMWENrYzJB?=
 =?utf-8?B?V0EwQnp5N2lKQXZPTUJmNmdZS082aVVaYUxpaXBrMnFqb1Z1MHZTT0htSWRP?=
 =?utf-8?B?a3BwVWZsNHJPTmdFbzhqSjJBSDJCUE5OUzdCQ0VKWXhwRzFnUlRmVndnc3Rx?=
 =?utf-8?B?ejZua3ltbDZEZjNjaTFQYW5lQVdNcXd5bDNYdnVvWis5OE1PL2hCck9rb1JT?=
 =?utf-8?B?dUs5S3IzTU9kZ3ZzMTJKZnJVMGM4WnUyajR4Y2prcUpPc0ZxS0prdHhQOEF0?=
 =?utf-8?B?SDlKdUFsMXYxb0pUUTgyY1pVcEFaQytUR0Q2UDNBTVZDOEJTWU55OXE4N096?=
 =?utf-8?B?ZExPNDdCVjByN2xzTkZ3RERsa3VaMUFsbnl1bUFDWmpmVTJhcC92SytXWVVI?=
 =?utf-8?B?eWNKVkhhbnRiWkQzdkIwbXlYUFpmajFJR05LUy81elptNjh5YWxHRFdyRnIr?=
 =?utf-8?B?M1Y3YXNPTTdqaGs5QW1RTVFNbDQwdmczUHVXODVTVmpaR1cxTkhUWVNRK0NW?=
 =?utf-8?B?UkIzS2N6RGFlMUxWNzNqMzlvOXJ1NWxHTHBiWlBnNS9oQnhBZ294aUp3ellk?=
 =?utf-8?B?dkVsYk4xbFl6bDRsaCtJY1hSL0g3QWVjZWp3UFJnZW5YWHh5UlhVQ2hxVVlZ?=
 =?utf-8?B?ekVVSUhhUlZXN3psbE9VdkZvY3JXMkdHVEpJVXV0N1VhbkdlMVBXN20wOWJE?=
 =?utf-8?B?ZXpzK2g1NFRjTTFUT2t5MExiUVFKSGlmdGlsRk84WHVCdzVoTGVHY3JSc01U?=
 =?utf-8?B?aSs4Mjlnc0hoaFJiRVRkMHZEUklyWGFlSitHdzlWSkJKdHZKNG5FQUpEUWZy?=
 =?utf-8?B?b2dLeTZTS01IRWlNSFRNakd2aTFPOFV6SjV5SWNpRGIrbFk0RzZkazVKM2pm?=
 =?utf-8?B?UnFmYm9TZURXTi96UVFvV0VPNnNkaW0wR0M0K1JSRUljTE85MVlONmtRanlT?=
 =?utf-8?B?RGlDS01kMVpUc3dMZ2NvQ1psVE4raVRDU3hia3JiODhQdFFaM2JEQkRIQkNJ?=
 =?utf-8?Q?LxVOLc7+0JUmrjBaBn5SusZPo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8807f6-147b-47c4-192b-08db3f7312a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:39:27.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYoabaYrKNPeMitcq0iTAVW0EVIzlTl3peRfCytge5w2Bpf8m7a3jrS7/Hlf/Ayva5GvjfTuZZwdvbkTzkgwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3799
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Apr 2023 18:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11227

On 17.04.23 14:04, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To avoid package name conflicts between cip-core and Debian upstream
> use the debian folder from upstream to build efibootguard.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - rebase onto next 
>  - always build efibootguard 
> 
> Changes v3:
>  - resend only efibootguard as patch "Enable Images based on Debian 12 (bookworm)" is already deployed
>  - rebase onto next
>  - remove unnecessary patch 0002-d-control-remove-native-from-python3-shtab.patch
> 
>  ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 30 +++++++++-------
>  ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++++++
>  recipes-bsp/efibootguard/files/debian/compat  |  1 -
>  .../efibootguard/files/debian/control.tmpl    | 20 -----------
>  .../debian/efibootguard-dev.install.tmpl      |  2 --
>  .../files/debian/efibootguard.install         |  5 ---
>  recipes-bsp/efibootguard/files/debian/rules   | 15 --------
>  ...01-add-machine-type-name-for-riscv64.patch |  0
>  recipes-core/images/efibootguard.inc          |  5 ---
>  recipes-core/images/swupdate.inc              |  6 ++--
>  recipes-core/swupdate/swupdate.inc            |  2 +-
>  11 files changed, 57 insertions(+), 65 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (55%)
>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
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
> index dd76198..d61c080 100644
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

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


