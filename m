Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5AEB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 13:29:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web10.7574.1687181375928210834
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 06:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZA2mJHO6;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK77LVtwFvhrnACnnqFgwvy58fP7f/aY2et++eANVyifqyyr4OXiVZZ50uzOx9ycYjtlceQkHpimpfVondn1DovqUAdZ2pS2wB05Cw/dqGyjOh7saBE5Wmb6NbMIz6Ov5EilWH+jkuqrgUvKN+itPqd0yXA8XUicHDGLggJ4cH3JNT/OOxJjmLJjJ2G5Ns8rav2O4Vn+LxE/7Mzw18MBmGj5h6IyfiCNNXeKfjYj4SVn1QgxINO9rZ8l33dA3m4R2Z+qMMIpBMpe13SxZKTrGBFAaVbdZYlsgttKE2wUM2XG8tVCZ6/ohVM4D95g9lSGsgLHJxKGeV7+s6iYi0SArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzO9yo7CibBhSv3FDxrIFgE6G+l0/qNmrbEws7nk2e4=;
 b=OPPrJsdybUe3QdlNPQ7AydemPj6loIqomioOqd9GlRuXgfR9QL3U/coH2+YXCAqW4kngsKD/BYNjj6GtiJHWLAe8lx9BGKDpz78MsBY58Bx9cDrxf9XJJpDYVFhKXAhW6giZd8w3appSZSinsLQQA2iWJG7pXZRwHe/QHHeyc+9t4ikP4jmWWxi6oPtht6hLHFfpnx+CBh2rSvxdW0HQcVm6eTNrsrbAYvReEC7h3+ep7phCY+ijLd0P5h1hYeo01VHxusD6JzcpFnpT7VR6u97bye+OjaDOX6TctNp9y2K1rwOBaNFK/WLP4J5uvW8hzG1ip32kj07vQB/NyihNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzO9yo7CibBhSv3FDxrIFgE6G+l0/qNmrbEws7nk2e4=;
 b=ZA2mJHO6tzQAhe7lF0XClSDxK9WKBVO34UrVvArqpo9uKIS4GQgKe5J+LH+65a0NdoOTtKlOTyjzHC53e1948+mt3TdBitnz3/kbxGS2YTmVKbpctTymCQbdIerDt8X0tcirpbtPiRSD9LuOja/eapdc3k4EiTWkbWRkkEx18N47kE+jal67Eee6NFqZd83Y0TmWgi0V8mxzHp00PoCTPHO3BWPHU4D0hj27X1fJPPdwswLlHjMLdqSgYeClL4hHdUs+O2NGJDrQ3rqMk2ET4fgMTZhMprrB7N67hQJzOY6XE4TO68IXfWMoss+UZTnaFzLLgew98gDTnaNcW2t34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 13:29:32 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:29:32 +0000
Message-ID: <041140b7-0ac6-f735-22fb-2c8be047c8dd@siemens.com>
Date: Mon, 19 Jun 2023 15:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to 0.14
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <795ab3b7-8aaf-3649-bc48-87bf780e11e4@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <795ab3b7-8aaf-3649-bc48-87bf780e11e4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3341:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea133cb-87a6-4291-9578-08db70c937a2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p0QRWXD8qJBWfm0/GjheWMVMk/1Np1XGeyRYjsBpXzOA+QXtr87WYtvXoW4K79x9Mo0a2P+hZo8jCPgUCm6unVpoPUHfd1yCBMmw97Zpsd8wAR3exvGoiz08KiYz8DZsQhx+9Sbn4YQog1FPWSh/n1YMgZpr2Mo+pqz6ya2Dgi0qtnIQMy7qHX5rDzi2OFlzO8A1WNPB0jRYpYFWx2RSGuGUG6Z9xHAF82DzCpdpjfadafVOxVj0wYf0eLXLrOixu1rU2rXwPntPcF0lSN03hl/5ieiNv2aCaK19J8KOyC8USLQX8pMtQ8zx+fWRRItRJKAJmlvS4YE0XIJbWb8qbYRO9ELybbWew5ZyZ2txQsct//0dm7C2qlJ7Jze7B7vHRPknEH10727Kjmikbvf4U++2pd0c0MZ/SWJM0o5QdXoWW+hq4iXc3B9dW3UeNblsdDjc18E8ANwx4fYmNSIX28XKL/CpjG830khcuawOINP8mYq232f0hdLc5FKpZN5NHqfsOduJ8spBul12awVTmyth2J0ONOZ7/7X+KaUm3INR9TRSwo7rXOX4E2o0vgKaPbK8fJtfQoZ886Qva83SW6oWIGhUplBlrREXdA8XawXOgzNTSdXfxREsnx8E4RSrD47USib1koMTZAHM0HoPwTHPKjdtiqugyP0kVmSf16A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(31696002)(82960400001)(38100700002)(86362001)(36756003)(6666004)(966005)(6486002)(186003)(107886003)(6512007)(6506007)(53546011)(26005)(8676002)(8936002)(5660300002)(31686004)(478600001)(110136005)(41300700001)(2906002)(66946007)(66476007)(66556008)(316002)(4326008)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3FJdUo3d20vdWxlSE5RRnY5V3pTdlF4OFVZTUtzZmlxQUlLK0laSlovakFU?=
 =?utf-8?B?U3hmQlhXM3dJMThWWEFPUXlvUmY1U2JiY1NxdGZLNVBmODFlR2ZTbHMvN0NK?=
 =?utf-8?B?VmN3OW5MZlNtZXAwMFRrdlJBeWZaNkp4dlJBeVE1N0ZiNXBOSFJrUFRoTnZj?=
 =?utf-8?B?YzZ6ZktWMGdFbXlzQnZUTjNGL291cWsvd3IyS04xQ1QyaFVZZElJdzU2TEFh?=
 =?utf-8?B?R2ZmWllaaUljVUllTkh4RkxhaDNIWmNMcGZlc0V0Q2NEYTVnNDNtSFh3cWxL?=
 =?utf-8?B?STI4Q0NYSjByaDdDa0puenpYcllkdlJZbjdhSlhwTFFXR3l5SExGR085a0t5?=
 =?utf-8?B?Z0g2OTVJNVoyMVhQc1c3dmc5QXk0OTQzMndCcUYrbDVjcnhCSzZDYUtaT1lw?=
 =?utf-8?B?RUFTMWlFdjJsd0Zra1BqUWIzTEswbVBqbjNrczVRelFMV0djUlNSb1A3OVRX?=
 =?utf-8?B?RWFTcE5QeHoxQTQ5RnBtQ1NYeDc0L0VIdzhESkVDUzR4TTVwb2EwQlNid3A1?=
 =?utf-8?B?NXVzZE96OWprOUM3UWJnNVBLeEtJSGNhbkdkcFZUMi9tSUVkeTcxV1laOUQy?=
 =?utf-8?B?alUrQmlmUGNlbkFIeS9WNE1HakdMSEJYY3BEVktZb3ZUdk1iUjJ3R3NMbDFW?=
 =?utf-8?B?RHFVcFpacE9LYWxkWWNYbWlCTDE0NFVBN1pUdExDdk5FeDViSW5qWC9WU045?=
 =?utf-8?B?eThhUXZGRW84cHJBYUszWUtKK0wydmpWcGE4RUVxQlNwTFZQc2pyQlBEd3VM?=
 =?utf-8?B?OUgyRzAyMDh4Zkp3YzRQWldjUm1zN3pkSXBOREN1MFN1cUpPZjRqZzRpWHFR?=
 =?utf-8?B?QTRjVHJMYzBnaU4rMnNTV0xhTG1uOTFZWFU1U1VIaFRhZ21rMXV5cnNHV0NI?=
 =?utf-8?B?c1JBUWNaeEd4b3d6MnNHU2RkaU1uRG1zY1RzTm1CbjFWc2tpYU9Nd1d0RXBk?=
 =?utf-8?B?cGlTeW1GenhUWlIxQzBrcjRmZVpOUjJYTEhMNE1HQmU3RFc2R1NjQkFMSVlG?=
 =?utf-8?B?QndjVFVtaEtZckNGQ1AyNFRwbkZ0aktnYXJ1SVB1Sjg1bnVOMnJZYitkajlr?=
 =?utf-8?B?aEUrUi93MUswbFJHd1hsODFGemkwajhhREdCc1pRcUI2d3Y4WEdIMzZnb1BD?=
 =?utf-8?B?YW5OMTJYZHBmVjhxdzlmNkdSbS9kUGx3WHhUTTNOdEJEZE93NDR0R1hsSks5?=
 =?utf-8?B?Q2FxS1dmN1YyQ3UwbmV6SjZuVkZpc3RqcmlUdHdaTDBWYTB2THlNS29sR3RN?=
 =?utf-8?B?VTlRSUJ5RlZDNGpOM0xoMmlkbmJGTVVTbFEwd044N1dreWpMNzZBUkxpQ3du?=
 =?utf-8?B?c2N1cGIzZUI3UDdNVG1WUFJRYlIvZ3hHcGdRRk1WVmZLaDBNU0tvL3BBWnVH?=
 =?utf-8?B?UGFncEdveERCbDhwNVVUQldIL2Mza1d5T0RlZXZueURlbkJjbTdSdDQ1Yjc1?=
 =?utf-8?B?OW5UY2lVTmdaM01iUWRRU1Ivd29RbXIrM2pFQnczdHgyTndwcU9rVWRvSzF0?=
 =?utf-8?B?QmVUdys3U1RuUUxJZWd4WGZYNHpPRlhLNDkwVnhxRUtYTFpXVGl5bTlINGly?=
 =?utf-8?B?dGxsRy9nVy9DaGtpcDFXMUw2cXU1Q1FsQUpDUnpCRDNwaURqQ3VzK1h6YmRK?=
 =?utf-8?B?d09BeWVDY2pDS0h5RmRZTFFwTDFCY0JxcjMydmZiL0ZZdUd4SmRKSGdpODNC?=
 =?utf-8?B?dHUwTVdCNVQ3d0RQczlDOThvMVNHNloxUzBjS3FaSnJiaEJUS0Z3L2dyYThZ?=
 =?utf-8?B?R05sa0NzNHAwcjAxd1FPTjJVZDV4dDJVWjMvdWUyczB2V3RsRnFKa0NlZUJ3?=
 =?utf-8?B?eVN0QldNRys4VSt2N1hWendrYVQwUHB2Rld2aXN0UVpjMi9iVTVpbzNmRnJt?=
 =?utf-8?B?T2NJVEYveE45QS9ya3hNODJsWnpZREthcmpWOEd0SStIcFdNMmpaR1QxRTBR?=
 =?utf-8?B?emhIdzRlbVRiYUF1S0MyUXNCM3JONWdQaG9jclU3VlVlbTVhZ29wWHZ2MVA2?=
 =?utf-8?B?K2NaNCtXeTVmbkxtaDFkRDZ0TE94amlEdHh4ZlZzVXkrWDNDWEw0S2NWZHNE?=
 =?utf-8?B?QjdMaHFrckd3dG95NHlmT0VvZzNUUU93ajYzUFpLbnJNWkplR1BUZWcvMitn?=
 =?utf-8?B?TE1jNmNOQXQrSmVmMXcyOHplSEp5VVdWYU43WU1kVmtyb0MwK0RzM3I5aUFF?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea133cb-87a6-4291-9578-08db70c937a2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:29:32.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rjYzuGCwyKjcEtPCyPOoDHXo/Jhryw6rOaVnAC859i6jZeSVfc91Ua9J6LqADO8y+ZxoahmH/x2oLOmQS25bWRKo+U0uIBuixXh7yJwrZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3341
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 13:29:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12076



On 6/17/23 15:09, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows to drop the RISC-V patch.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   ...0.13+cip.bb => efibootguard_0.14-1+cip.bb} | 13 +------
>   ...01-add-machine-type-name-for-riscv64.patch | 39 -------------------
>   2 files changed, 2 insertions(+), 50 deletions(-)
>   rename recipes-bsp/efibootguard/{efibootguard_0.13+cip.bb => efibootguard_0.14-1+cip.bb} (78%)
>   delete mode 100644 recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
> similarity index 78%
> rename from recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
> index 9fc15a47..f58a3200 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
> @@ -17,18 +17,13 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
>   MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
>   
>   SRC_URI = " \
> -    https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;downloadfilename=efibootguard_0.13.orig.tar.gz;unpack=0;name=tarball \
> +    https://github.com/siemens/efibootguard/archive/refs/tags/v0.14.tar.gz;downloadfilename=efibootguard_0.14.orig.tar.gz;unpack=0;name=tarball \
I would not use downloadfile to create the orig tarbal. Reason is that 
the usage of downloadfilename currently breaks mirrors, see bug report 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15126.

Quirin

>       git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>       file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>       "
> -SRC_URI[tarball.sha256sum] = "639a6d8f687cb099b2e9b01eb08ad1494267fe26b5d903b4d405d0737feb989b"
> +SRC_URI[tarball.sha256sum] = "80452a9e37460708113292daf0050d3f4fa7d3d4b8b2308620701112cf18eaa1"
>   SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
>   
> -# add riscv64 support
> -SRC_URI += "file://src-patches"
> -
> -CHANGELOG_V = "${PV}+cip"
> -
>   PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>   
>   S = "${WORKDIR}/git"
> @@ -46,10 +41,6 @@ python() {
>           d.setVar('DEB_HOST_MULTIARCH', proc.read())
>   }
>   
> -CHANGELOG_V = "<orig-version>+isar"
> -
>   do_prepare_build() {
>       deb_add_changelog
> -    cd ${S}/debian
> -    quilt import ${WORKDIR}/src-patches/*.patch
>   }
> diff --git a/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch b/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
> deleted file mode 100644
> index adc7962c..00000000
> --- a/recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-for-riscv64.patch
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -From 391dd5e04b17be6f5184afb2de4853795f1d5620 Mon Sep 17 00:00:00 2001
> -From: Felix Moessbauer <felix.moessbauer@siemens.com>
> -Date: Tue, 31 Jan 2023 09:27:31 +0100
> -Subject: [PATCH 1/1] add machine type name for riscv64
> -
> -By adding the machine type name, the generated efi binary for
> -riscv64 is suffixed with the corresponding efi machine name.
> -
> -Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> -Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ----
> - configure.ac | 4 ++++
> - 1 file changed, 4 insertions(+)
> -
> -diff --git a/configure.ac b/configure.ac
> -index d8f9d3a..90d70b0 100644
> ---- a/configure.ac
> -+++ b/configure.ac
> -@@ -87,6 +87,7 @@ SET_ARCH(X86_64, x86_64*)
> - SET_ARCH(IA64, ia64*)
> - SET_ARCH(AARCH64, aarch64*)
> - SET_ARCH(ARM, arm*)
> -+SET_ARCH(RISCV64, riscv64*)
> -
> - ARCH=$(echo $host | sed "s/\(-\).*$//")
> -
> -@@ -103,6 +104,9 @@ AM_COND_IF(ARCH_AARCH64, [
> - AM_COND_IF(ARCH_ARM, [
> - 	   MACHINE_TYPE_NAME=arm])
> -
> -+AM_COND_IF(ARCH_RISCV64, [
> -+	   MACHINE_TYPE_NAME=riscv64])
> -+
> - AC_SUBST([ARCH])
> - AC_SUBST([MACHINE_TYPE_NAME])
> - AM_CONDITIONAL([ARCH_IS_X86], [test "$ARCH" = "ia32" -o "$ARCH" = "x86_64"])
> ---
> -2.30.2
> -

