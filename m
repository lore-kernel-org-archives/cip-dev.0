Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB8C4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:16:30 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.73])
 by mx.groups.io with SMTP id smtpd.web10.13792.1707761780999620208
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:16:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DcECNyJH;
 spf=pass (domain: siemens.com, ip: 40.107.241.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbmgJXoftYdiK7RzJReOPGOv5a0Puc2xARa7h60Toi44VZXRcn06OalM9ZpBAcGvgc21QKFS7Nbbv/5KKG97+NQxI6CdaLipfSorTdw0hNxgu24kQVBTem+kth0YJk38lz+o5RmSE6ZXskjVq7KXtb5+OAOQg8RNHzTIFIkqOvVpP5b7jcmEAjx59m0RIcFVT1Wl35nze+n7a0/MB3XBblxd6CzCx8SNyJZKBUfXJ3kZhLIYjSz9VTT36Ex9Np83SVSnD2FOD+m+eXllR75GRmdAcjnQfb4lXsvsziBR63Ww44CFvo5y7aU9btNu0T5H6GeSfuVEk1OS5CvyCBclDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbK52X2YCF+p0ftAP8JEMF2Vf0uzWWmwDEp1rrSPqLE=;
 b=GogseaaSM19igBRU/NX0WaoN9jrsh50BDtup/9cllFbd0+yMZDOpNUudFFuM162auWEzM1Egi/aq9osGp+hML1lOeQEXxyQyjA3OdUbb4+8oIlclEkVWazFpRvNHdR7I9uKYSsKL1y55USToE3Vx1rZ5HFKF6FxCJgldvNqbrL5aMj9UeZByrJsbxn8NFl8F8NlrSb8jU9l7fuNmPIz5rPrLtjHemTeC0H4FwpMMXrrf6ec6ld9sEfxV8fl1FyzwUGoL8VpY/VTbioxdoD8V59/1Za8T/PPIlbdgEOVKmqWsawA01PXO/Xj+PJlAd4288uBY0Bc5/wa7gttcP9nvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbK52X2YCF+p0ftAP8JEMF2Vf0uzWWmwDEp1rrSPqLE=;
 b=DcECNyJHYDhXFcZpM5LNKRl2jn/8W762O5/8MQBSt6yxzx4TYqApf270M4Aolz8DdO9ZK3qUCuigihnTgmbwdZZv8/UeoTNU2YHK4ZrvvTWx0WIJ4iNJqloYgaKYpeUbtRZQVxW5LZ+toiZ1oKPrm9JNjzFFDwV6I8MxJ/MhbB85+2YjsS+pl3mgqSKuts0oNB8PXcz/rmUYxxXZpdC1VbI6te9uWdD2Drb8oRDTlJZTID1SiCqsUf4eAX60dOqe/vUeF/D+re18poEC3D+n50K+rD4k4UOvjruoQj9fGCTvRbwukVqtwgRzFZ/rwMVI/5Pjs+OWHCev6hIR2HcjAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 18:16:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:16:17 +0000
Message-ID: <29de90aa-1a30-4f17-9538-e6a2334bc343@siemens.com>
Date: Mon, 12 Feb 2024 19:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, shivanand.kunijadar@toshiba-tsip.com
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
 <20240130115648.311177-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240130115648.311177-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d7419b-917f-46a7-ed77-08dc2bf6b4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4tzRpNnFL8a01uAtqPbjP02HMCNt3hFF1MTJVEF1U3ANbSu3BYOCMPZIOsnPz1kX//zX9AIq7oI6+NKiHAQLi2k551e9iwTfCi6590r5qPkf7tLVIo45T4ts7hSyr9TlTfr22yeSCR9YN1r6RP6LzT4iqTJlzOlb2TStwvOf6EA8Dc05N+Wn3Qaxcjuy78gXHa0xDj6pOlVOOZiQLfj5GPAXnJ23kN5UXTWsb9BLSeMZ7Tn+JPsffaADRV95jUYZBagUaC1Ym/yaRiH+Yew/pq+ktaQ3V/dBV0570dYwaA6zc1kgtGA1SND6j1V2bYbBNoqGv3a29HqzyC6jl1vWEMkndTh1B6y07VBiryK0eI8cf3hHunUljESPJlVY32ATiSQAygEM8IBKzNORqIcoaFRhcmYxNKx04/xU8DuzsrpE0Qp7X0z1xU3/b5focWd9CuXy3r0x1vyYAIM5WAA0krq97a+KCzcP9m6MpJRLLEXlsjFYY88Mu6PfzBPIg1NryO/sJD0as69uVh9IAzF97mPd9Wgjg6wic0huj/JcECvEQpi2xOnm+bbYyeBxTkqh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6486002)(6506007)(6512007)(2906002)(36756003)(44832011)(31696002)(86362001)(66946007)(5660300002)(82960400001)(38100700002)(66556008)(478600001)(316002)(53546011)(4326008)(83380400001)(66476007)(26005)(8676002)(8936002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFFuY1VVRWdVdjdNdVhpNi92QzNyYU92QlNGUlJJazRYcU5TckdEdjMvcjln?=
 =?utf-8?B?L2E1NnlTUGI0NG4wOXRMNnQrTFJjSGdJeVU1bk9EYzVoRytpci82aE5ZZVps?=
 =?utf-8?B?eDRRMURKYzRCUEpCR2hNemNYR2V2UksrN005VjVwZ2JhVUNzMkJvZ1l6TXlr?=
 =?utf-8?B?QkdueWpDcWlDdVd5bXpaV2ZKQ0wweldGSmVuT0NpOU14V0tMd0hxc0pBMDVa?=
 =?utf-8?B?WTl4RjdHTXVqV3RpWTlMOEpYaXlBdE1NQ20yTmcxeUFVb2pGREtzWTc0L3lQ?=
 =?utf-8?B?QWM5cGFpR1VWVEJybGh2Y2dyNS9kQUo4V2tONDBKc1BhRWR1Q216RFhUbkk5?=
 =?utf-8?B?akFBK3oxN2ppZE5KR1JieTk2MkowL3dGRlBOejRJdzE1M1h1SDk5WVJkNzNQ?=
 =?utf-8?B?SllBMjNMYkF0UEJQbEJXOTJYeUdVWllUT0I3dTloN1EzSm45ai83WGJtVVY5?=
 =?utf-8?B?Z1FNcGQ1LzJWUHpuZzlTTXBSMk9EMm1RVFNIMnQvYS9GMjVudkQyakFKR01i?=
 =?utf-8?B?a1ZjaDB5SWgzdmNWSi9UdHpsVkx2YlhjMURvK0J5b1pEVWxhSXhSNzFuTS9D?=
 =?utf-8?B?VjhqcVJSemwxOVdZZ05TK3NDem8rZnVJVnRoaURPb1prQ0pGdnh0U0wrRzRG?=
 =?utf-8?B?bTRQM0dxKzdvQ0x6T1BxTjdiRDZNNzRUT0ZzdTdxUkk4aklaZDZvSmVNUkYx?=
 =?utf-8?B?T0VvdlNjT2JEUmJTL1lOSjhMOHFVY0VuWnA2ZnRpbnRVUE9CbDBLbG5HYnNT?=
 =?utf-8?B?NWU4aE9xYVdIUXNpbHBUODVRa2RXampDd2ZWRzl6QTdqOTAzZ1JTMHlSUG1I?=
 =?utf-8?B?SDlwT2w4WVQ5QkhqRHU2UHZoaHZ1dnJ3WFhmVE8wbHBuTWZqWGJKbkg1OVpS?=
 =?utf-8?B?Z2tMUXY2b3FXSFdrR3BrSzNQRjh0WXgvenNydHFCMkZPZGZCZEFWVkc1bVRv?=
 =?utf-8?B?V28yUkdXNHhFM3FobXJBSGxURTY0QlQ5N3ZUSjFHdVVmVVNXc2JPSGdGOUFC?=
 =?utf-8?B?NGJ2ZFBSL0gydUhUcVpwa1FYaGJBWEd5ZTl0WjVwc2Y0NUViU05YWmZ0OHNP?=
 =?utf-8?B?N2ZURUVWSVBqeGt4cDhWT2w4Qk1QaTFjVTdvbnBscVlJb0FzQ1BxNi94V0pQ?=
 =?utf-8?B?RVFyYWZEU2l3eEpLMjNxUTNZa3h6VkQ2andnNkt1eWs1T2gvU0RjdzR2MWV2?=
 =?utf-8?B?SnBwNnlSaWlodlBJTkJLR3dINThBMGtUY0oxbG81ZStEcU9UQWl1RjgxMkgz?=
 =?utf-8?B?Z0F5dlJEL240TUZMT3hkWlV2QklhamFzbVJTaFVlTFpxeGZqdmJpcENHRkto?=
 =?utf-8?B?emRZMVdjY1Z2YS9QczlmQUhXRDhabHdJSjM3NVhXYzR6R0cxcW1xanB4c2pL?=
 =?utf-8?B?WEdmUUhRSDFZM3dIZENIdVR6dzEvZkVIRkEreTdoVzJWVmYwZnZ1b0RweUZt?=
 =?utf-8?B?R1FmWnpPVkFhZjcyRHVTdktoYnRoS2xOZmVDVWxzc1JibFdobkh2c2lTeUpz?=
 =?utf-8?B?TXV0Zzk5VVdTU2lYY2JYR3hhejNUanFLbFZRWElWbUl3NnZqYStGajFMYVdk?=
 =?utf-8?B?MHdzcUlKS2d0dkpySUVzcVhRYTBtV1dFNkxkMzZRa1dMME5aMVM1NklXK1ZF?=
 =?utf-8?B?VldVNzRyR0hKVytkK0d4VWRzeC9UNTVWbEVJbCtWbWtNbHBpK0hadHF3VWUr?=
 =?utf-8?B?MHJhWFd0OWE4V3RSUFpMcEM3WkdLSk9VT3J2N0M0SDd5eXAxZVFMVWcyTzNX?=
 =?utf-8?B?SnhYK3FzdDRoUUpPNHVrTGNZbkkzZTloajlUU2Q1MmRsaUZDTkx0TDBHVTV5?=
 =?utf-8?B?N0RoM3p5VnVyTXpLd25xMks1MXJncS9KeTdYTzI4VWVpcXRtWkQ4NEFQV21H?=
 =?utf-8?B?NG5oSzY2a0dwU0t3NEpNVG9vcldPMUYxQzB5WEc5SS9uVjk2QWJZT1VnMnYr?=
 =?utf-8?B?MGlDNnc0ODlCcjhXSlhFaEJpbUExaTZ0TU9rcVcvUkw5eDl2eUIrakJsNlBx?=
 =?utf-8?B?cDZ2TU9Dd3ZHWGR3dldpTWk5d3ZHSSsrZFkrUmg4RkpkcTM5Y0k1U1VFYWJX?=
 =?utf-8?B?WlVEWjNEeTBnUEFBb2daUGV0RG1pYitpdStCakpyanFMZVRzVXJHWEwxU2hp?=
 =?utf-8?B?WXpoYTNySWNmYTNBWU1FQWxsNXRtd2xDVGVkTXVPZTlqVzFaQUc0bk5oaUk1?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d7419b-917f-46a7-ed77-08dc2bf6b4f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:16:17.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMwbkH2OmLK3sn81/59BSECHk4vMmBacpKwtaBMsOVGGq8GotSi7unn1uLS5tfbO5uIDIekJdo9iUL/qxtjlMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14924

On 30.01.24 12:56, Felix Moessbauer wrote:
> The dpkg database is located on the var partition, but this partition is
> not updated (and might not even be deployed). To still have information
> about what is installed, we relocate the database to /usr/share and
> create a symlink using tmpdirs.d.
> 
> Note, that this is only enabled on debian bookworm, as the proper
> packaging of tmpdirs files is only supported from debhelper-compat 13
> on.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass              | 10 +++++++
>  .../cip-read-only-rootfs_0.1.bb               | 26 +++++++++++++++++++
>  .../files/cip-read-only-rootfs.tmpfiles       |  1 +
>  .../cip-read-only-rootfs/files/control        | 11 ++++++++
>  4 files changed, 48 insertions(+)
>  create mode 100644 recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
>  create mode 100644 recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
>  create mode 100644 recipes-core/cip-read-only-rootfs/files/control
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 6f91f66..14ed85d 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -17,6 +17,16 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  IMAGE_INSTALL += "home-fs"
>  IMAGE_INSTALL += "tmp-fs"
>  
> +# For pre bookworm images, empty /var is not usable
> +IMAGE_INSTALL:append:bookworm = " cip-read-only-rootfs"
> +
> +ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" cip_copy_dpkg_state"
> +cip_copy_dpkg_state() {
> +    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/cip/var/lib"

Hmm, should we really add "cip" to the path here? I would suggest to
have a more generic name like "immutable-data" or so, avoiding that this
recipe is renaming while branded downstream or has to be renamed if we
ever hand this over to Isar upstream. Maybe the package name should be
aligned as well then.

Jan

> +    sudo mkdir -p "$IMMUTABLE_VAR_LIB"
> +    sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
> +}
> +
>  image_configure_fstab() {
>      sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>  # Begin /etc/fstab
> diff --git a/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb b/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
> new file mode 100644
> index 0000000..76453ab
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
> @@ -0,0 +1,26 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Felix Moessbauer <felix.moessbauer@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# Note: This requires debhelper-compat 13, which limits it to bookworm
> +
> +inherit dpkg
> +
> +SRC_URI = " \
> +    file://${BPN}.tmpfiles \
> +    file://control"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    deb_debianize
> +    rm -f ${S}/debian/compat
> +    cp ${WORKDIR}/control \
> +       ${WORKDIR}/${BPN}.tmpfiles \
> +       ${S}/debian/

dpkg-raw wouldn't have simplified this? I think even compat is not
customizable.

> +}
> diff --git a/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
> new file mode 100644
> index 0000000..16a91bd
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
> @@ -0,0 +1 @@
> +L /var/lib/dpkg - - - - /usr/share/cip/var/lib/dpkg

This file is supposed to grow in downstream integration when more data
should be handled like dpkg, right?

> diff --git a/recipes-core/cip-read-only-rootfs/files/control b/recipes-core/cip-read-only-rootfs/files/control
> new file mode 100644
> index 0000000..55eec25
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/files/control
> @@ -0,0 +1,11 @@
> +Source: cip-read-only-rootfs
> +Section: misc
> +Priority: optional
> +Standards-Version: 4.6.1
> +Maintainer: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Build-Depends: debhelper-compat (= 13)
> +
> +Package: cip-read-only-rootfs
> +Architecture: all
> +Depends: ${misc:Depends}
> +Description: Config to link volatile data to immutable copies

In general, the idea looks good to me.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


