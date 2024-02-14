Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD21C48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 13:43:32 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web11.41731.1707918201798933924
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 05:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BVi6LIYF;
 spf=pass (domain: siemens.com, ip: 40.107.22.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYSCmxK4X3XGM92tSU09A7tOXaHbnC7aCpAIbv6HPXJqj8HQB/LshjiZTGkwKrmh4YBPVJ6VVcozfMqLRMpBjtDuQTY8xaJDPAuesQHyBR364ANFIoI76d1NO/oL0vI5kNeDu7sN0hn3Zyi8yGd9CEV7+5Zx8/H9d6MsFd+Y2Gmm7I8x2XTcJYCLU57y1CavVDdFxLXkq2lrpG9y2PIwOTXXz8dPiHY72jZFwFk3ibJApetkL/sMLJs8hmfgy5U+YhuwVfIYVA05inLavv0GtQYIVSTiXPkFfUcVZ0NzNg/DIAGWlO3DfcQn4ZAh+2i81EurEszC3wOyzrjdf0Ba7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46NSSedhRDUh1A6eBuyVyDlMgkayMLzK3KOhO0hvUnM=;
 b=fhksd8btyMwrNTnoII2vcXajgil9+Nfq+Fgg+qOSid7PNC0GzF5zEMSbdHX3lDS4c53UbUDNGLIbpWoffEQnNJhbdEeOVViU99kBX8s72l4TydV3/ocJFCwxllKfTb8TgWHFFBFOOuQMUDczzrAnLKcx21MSnrWWJQGMIcugtzCwNLGxIEt0UKAAOHUi/RBAIAkvKi6MoypIxkQJ8AJFonUemcGQYb/AlzCWRsdCGn86651ofN0X+IoGTbjdgwjB9DvEqkKS+LXV2DQVNQpSdXOtPrMqvpEuF+Feq0nMMNzOQGQ7/fPEvVxzcTr1FNWFo8ia8Z2Rs0nPxdRHErsdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46NSSedhRDUh1A6eBuyVyDlMgkayMLzK3KOhO0hvUnM=;
 b=BVi6LIYF2DJVYvxshqL82o4w/ReJuUgB3bc+52S3gIJF0d3T5ZwePWTwIlou/HwDzYt75fjXfNchoQNwfZyH/swxuovqcgnn0MQO5bxEZSD0IpKuDnrf3A96UmpGkdfhWS/Y5fHdOpeyX++CgFecK4Q34d81R5v5Qm1BHm1ZsdmiyWwsqAeEyIzIMP+Wz1B3bkXx5AqYRclbEznk/m+4MNFQMaRtSeI+xeU7jewjzab+cFYjIhPI96kINKPCvme2H7pB+2jJz6sXLijQUAy+TvqkIpzkjE4ajNREP9NhxntatlLAbzxCRbpv3fihTCMtytd5PIfwQyvNa6Ngj7ssDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 13:43:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 13:43:18 +0000
Message-ID: <30daf14e-f07f-4fc6-b37e-d1021d9de534@siemens.com>
Date: Wed, 14 Feb 2024 14:43:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v2 2/2] copy and symlink dpkg db to ro-rootfs
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, shivanand.kunijadar@toshiba-tsip.com
References: <20240214133907.999657-1-felix.moessbauer@siemens.com>
 <20240214133907.999657-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214133907.999657-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3312:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313e30c-b1cf-45d7-1851-08dc2d62e6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sr5kaH0p+kUK8JxbOLQB3xEGKt8jYJn7iWf5GtZbiwy6FEAMXT1kS9yYZtCNu+4AnCbpFB6HZ0uPkjKdnN52dsuDGKHvw2W7F5hqbTd7C+L5Jo42u4+vYKwBxWSWBumcArNjeHzR932ojWnNR2cPp2RItnAkOIWQFo0P/fy1+ssWcLyRdKINsIXWLOKyS6hFVOUUkY76dENbiBEf6eu7tfxnu8esQyTDDhjgV9AsbtugdwXHtZqA+ifpkkSROZLDOlmDbA9am3DDIadqwOxoQZCssU/7LYxBpR0lOA4YGo58r9DT0h/lM2Ap7f1ljKtPds1lRJFwCPECCh4ITs3sRchKSabKqQ/695CswLjQPf0IoE8Wwb83Ksko+8f3/5vEihQABOmG67AYRYDpTFYE/UAn9y82otTB8lkm4QkXliaKhnpsfPCL37nnCdiOJkGqQF56ebhEVX4c4agdYBDVECetoPxqvxaUOC1r7tG42ycdc6fD+QV9yTgwTZnPurk8NZljbTCk3TJ8Z2o7ygAi2DXfoXB921Ficn9N1WBq2CvYJtOyP+HwfCwMrxE1oCoH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(316002)(66476007)(66556008)(66946007)(41300700001)(2906002)(5660300002)(6512007)(8936002)(4326008)(86362001)(31696002)(8676002)(44832011)(6486002)(478600001)(6506007)(36756003)(2616005)(53546011)(26005)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGlBNUs3UjJWQjFGL3dML1JoVWNUZk05emFtR09HRWM1REFYUkxVaWY1RExB?=
 =?utf-8?B?QlREcWdJUTFuZUhlYloySTJCSlFIZlFZbk1BTElvYWNyS0t3YWZ4V2RCQi9D?=
 =?utf-8?B?Slo2ZTl1cGcxeGFMc2JRZk83dklOcUxtYWpUcytRbXpNRzkvU053Q1ZLcHUz?=
 =?utf-8?B?aTMvcDhVM0lPWlJ6Snh3SlJCSVNPb3pFNWZWWnBqRkpGajZNcS9yeUtFNkZL?=
 =?utf-8?B?THAwSmFTS2Z5SkFCa3V6dXd6RkZ6ZElYdnJhdWNoRC80LzhtbE90Rng4enAy?=
 =?utf-8?B?ZHJtcDc3TkZ3aEoxMGduNzBMM1ZaSXZTdWRkYXJKUWVuTFVsYk5VeklrTGV1?=
 =?utf-8?B?bVI0UUw4QThubHRwRmJNZ2dxSHM4WlFDUU9rZ2lRQUhUZzdXMkRWT1NwQUMz?=
 =?utf-8?B?RUw3TUk0ZjhoaXdobm1mbjFqbTdUMisvOVBNUkcxRXN4SzdMSTYwaDJycHdk?=
 =?utf-8?B?bVo3cWR2eWJqMXpHd2VCaUV2UW1IbDhPTDI5MnlHcklzc1ZWbW1YTU5ndVJt?=
 =?utf-8?B?T3I1dFMrbDNmRDcrYjhXMGR1akkxcTZYbkNCVnVEOEQzOVJxYlVNQzVaMVFR?=
 =?utf-8?B?K0txalRaQTErNnU3TE1XZUM3OHoyV21FdEIxN1RoTzZPU1I1M0RNTUhxSlFx?=
 =?utf-8?B?TzhYeGpOSW15UnhSVyt2OVUrNGpFNzZIdWx6VlFmYXlVM1I2cWhEK2F0THVK?=
 =?utf-8?B?bTBpbVNweFRtUEJJc0dLNkhWelNEZm5uZEE1RGRMVFkzTDZqY1U3REZrQkhV?=
 =?utf-8?B?cGlCYU5TMnZmOHNQSE9DQnI3ZVlSZUxPK0VHTTFRNDZGdHdrd3k4RHU2QlJE?=
 =?utf-8?B?aTFNZG9BMTI1TW5ZckxGMjVOUlhnWmpLai9KOHFVbTR6aWtZQ3k5N2NtcGEx?=
 =?utf-8?B?a3hLRVJDZnBhZEoxOEQybDBBTnV0aUlDYlJ3SHBvUWtIeEF0MTFmcnFjOWt0?=
 =?utf-8?B?Z2d3Sk90aU5DNFA2TS9jaHQ3Z05HUStVZTdUNkVSU2NzT2w2YnhKc3ZRRmNG?=
 =?utf-8?B?cjhPeEtTTXlvdnRoMFlXcXpYVkx0dXQ3Y3lyVm9hUGtweE1GSmU0TjN2Smpv?=
 =?utf-8?B?SGFkN08zYXFHZFkrRThJaUY3emxwT1Y5V1ZhdGdjc0YyaEdqMGFYT1ZvRytY?=
 =?utf-8?B?YXU1K1BER2V4QnVpelZlUW1OYmZIN0NTa1VnY0tiMXd2Tk1QdDFQMXRRMlJV?=
 =?utf-8?B?QjFMTUZocVRUak5qZ1lsc0dONXNRelEyaHVoWXdidWRZYjFLLzZETGpLa25u?=
 =?utf-8?B?TDRtZFV3ZU5meTBsb3dzcnRZeGswUVh1czNiTGcvYkhFdG9jM2sxS0UwRmpN?=
 =?utf-8?B?Tngwd1RIc0NsM3lzNzB2a2JveUJKcXZnOWdPQ0RLZlVyS1BKZEx4eWRxa3Bj?=
 =?utf-8?B?ejNZYnQvenMyeXRYWWdVMFV3VFJuTVI5S1VyQTdtbWJ5R1phaEVYWXRuSC9l?=
 =?utf-8?B?Vmx6aUY1T0JXSk9OR1VrYjRNMDdtY0VEeFNIODFoSnBaWDlMRDFDcmFwVTNL?=
 =?utf-8?B?b0R5SkIrcEdMd0UzelRma1VmLys3ZTdZaEs1dllaK0FVMzRXaU1MQ1N5Qk9I?=
 =?utf-8?B?YTA3S2dORUJlcVd4Y0c3bzZNR3kwZlpKR2ZNZSthWlYrS1FyREtSREdCSEtG?=
 =?utf-8?B?UTBHOGVzSTlKRXpLS2JsZ0ZrK21zWUxpeG9xL2sydy9GRXF5Q1RKU3BNNkZM?=
 =?utf-8?B?bVpVYnVkd3QzSDc0NmVOMytyaE9BT2p0VzYvWUlnS1dxZzkrdU1CU1BEc3NB?=
 =?utf-8?B?RkE3dXpmNitLYmhCQkhiOHBESXBqS2hHUldyTVhFVmZRcDg3aFU0ejQzWlJF?=
 =?utf-8?B?VzNKVCtYRDJicDgwcjBqVEZTcUVYdnQxSnpNNmp5UVRXc0dQWVBuR2NqUHFj?=
 =?utf-8?B?c0oxTk9Hb0thdnhoMUtSdHVmMmNpdk9rSkZWc1g4RVFsaHJBWjJkbDdSYU5q?=
 =?utf-8?B?dlcwdmxXWHZFcVEyVCtJWS9qMk5STUxKOTVQRWNrUTh6c2lZelZ0YmtIb0Fz?=
 =?utf-8?B?UW5sdFJ2TWRFMXVESm1PNjBsV1JweWwwTnJDK2RuY1lKUnU4WkY4blBKbW44?=
 =?utf-8?B?blY4a1F0dnFPL2ZOdzEwTXcrK1hRYVFHKzU3L1lDMzBLV2NQTmF3OFF5VWkv?=
 =?utf-8?B?UWtYeDYyaDlPcUdyeGdFUStyWUtxbGdhSVU1di9INUltWUxVNG5ONkVHNDRk?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313e30c-b1cf-45d7-1851-08dc2d62e6d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 13:43:18.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj/V4bQT3v4cqW75aKcMC9FUHTKm9Pfg/V0uB9MJc46ONhp14YRfYHlJ4kSya/h4VzgIj6wG5TvAnSkJGNt2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3312
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 13:43:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14968

On 14.02.24 14:39, Felix Moessbauer wrote:
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
>  .../cip-read-only-rootfs_0.1.bb               | 26 ++++++++++++++++++
>  .../files/cip-read-only-rootfs.tmpfiles       |  1 +
>  .../cip-read-only-rootfs/files/control        | 11 ++++++++
>  .../files/immutable-rootfs.tmpfiles           |  1 +
>  .../immutable-rootfs_0.1.bb                   | 27 +++++++++++++++++++
>  6 files changed, 76 insertions(+)
>  create mode 100644 recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
>  create mode 100644 recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
>  create mode 100644 recipes-core/cip-read-only-rootfs/files/control
>  create mode 100644 recipes-core/cip-read-only-rootfs/files/immutable-rootfs.tmpfiles
>  create mode 100644 recipes-core/cip-read-only-rootfs/immutable-rootfs_0.1.bb

Wrong paths and one obsolete recipe.

> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 6f91f66..bb8ab9a 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -17,6 +17,16 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  IMAGE_INSTALL += "home-fs"
>  IMAGE_INSTALL += "tmp-fs"
>  
> +# For pre bookworm images, empty /var is not usable
> +IMAGE_INSTALL:append:bookworm = " immutable-rootfs"
> +
> +ROOTFS_POSTPROCESS_COMMAND:append:bookworm =" copy_dpkg_state"
> +copy_dpkg_state() {
> +    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
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
> +}

Obsolete duplicate.

> diff --git a/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
> new file mode 100644
> index 0000000..16a91bd
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/files/cip-read-only-rootfs.tmpfiles
> @@ -0,0 +1 @@
> +L /var/lib/dpkg - - - - /usr/share/cip/var/lib/dpkg
> diff --git a/recipes-core/cip-read-only-rootfs/files/control b/recipes-core/cip-read-only-rootfs/files/control
> new file mode 100644
> index 0000000..c12fdcd
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/files/control
> @@ -0,0 +1,11 @@
> +Source: immutable-rootfs
> +Section: misc
> +Priority: optional
> +Standards-Version: 4.6.1
> +Maintainer: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Build-Depends: debhelper-compat (= 13)
> +
> +Package: immutable-rootfs
> +Architecture: all
> +Depends: ${misc:Depends}
> +Description: Config to link volatile data to immutable copies
> diff --git a/recipes-core/cip-read-only-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/cip-read-only-rootfs/files/immutable-rootfs.tmpfiles
> new file mode 100644
> index 0000000..d180bc5
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/files/immutable-rootfs.tmpfiles
> @@ -0,0 +1 @@
> +L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
> diff --git a/recipes-core/cip-read-only-rootfs/immutable-rootfs_0.1.bb b/recipes-core/cip-read-only-rootfs/immutable-rootfs_0.1.bb
> new file mode 100644
> index 0000000..8afdb4e
> --- /dev/null
> +++ b/recipes-core/cip-read-only-rootfs/immutable-rootfs_0.1.bb
> @@ -0,0 +1,27 @@
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
> +DPKG_ARCH = "all"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    deb_debianize
> +    rm -f ${S}/debian/compat
> +    cp ${WORKDIR}/control \
> +       ${WORKDIR}/${BPN}.tmpfiles \
> +       ${S}/debian/
> +}

So, will you simplify this once Quirin's patch is in upstream isar?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


