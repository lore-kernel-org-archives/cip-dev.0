Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22576C64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 07:08:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.81])
 by mx.groups.io with SMTP id smtpd.web10.84870.1677481716679908445
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Feb 2023 23:08:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kU7j+pY+;
 spf=pass (domain: siemens.com, ip: 40.107.22.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUH/rjEXfQMaMrj19+nXBbkCt4ePmAaUhY7uVRRqlbEXBAvckTZuomct0YxaE+t6RgzARMHtTvJtu5ilXWtGwleyN8NS1akSe3k0mzg7+czpruDwmkFUn1S+D1NGL6dEo9u4QqXrWEZAgT3hdF/OnP6m6FPRaUZQjn9tucLXdiISYXPAIo3KgSFkstvCXuFxwGnaHwN8oAEkB42rGe97CF1jIj/CR47cnWws5yFhe0SiPjDnGwEju6raQ6KtqGE/v41a0c1tL4Q34TtVweXUEEJ8xLhadWJ/O5NJHLBZlERWhWDIEopd4TE4AWiQmtgnPk3WXBGqMqJhtcKBodaKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tOEdjhIoIVIxEIA5g1kgrtgav3Z03p+2n9DxosyS0Y=;
 b=ioMKIxV+Qx4v8RexS2z8vJFPt/6E89XdvEbV/lFlASQB3/NPODZDPboafU05hhdXtgqChQdYOBRBJAZixAKsNMg4R+iIIbRkbtl/v5hG2P2hHgGOiczOEcPmBxACW5k+FMzXoHFMJEqW7flcOloaNCVTAruW2F+vWMVMcatPXM2vRZ9Cg/2N7ImDIxtnmnzBVFf/XrRgJ6kJfBHhCzwHbbZTmVFlazttp3A0C1ySEnYjiRMe5YFMer9COkNIjZQzVeSkE8Wl20die4bTrW5+5lGdlmIgSKlNd0LhN+y/3Ohb4eYmuzk3QKD0dtAdauh2Q4DsQtkRoI8mGPHbAqIVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tOEdjhIoIVIxEIA5g1kgrtgav3Z03p+2n9DxosyS0Y=;
 b=kU7j+pY+DX3nIfqh0SO/s2vATB4wcNM8Sl59d+prAx8JEfI/+B3sSI3U6dVmGdYpNo2z4Ec1uM59o1p6EZhC+4G84dpsTkQIe4ZJTDF3TdR1JxVPU7bGcid4lgrrecMpsVz3gTu1xKuRXKl2qUSjl6tF4ZDWDiZ2aUk+I7NPSBvKkBvbFWkDckCmrxa+QM6cl3jZ1X5apQjAMwr19tzydxbQNZwuaKa/0BztkmS6ONOu9EeVrxD59QPt9AqahqO0PWspIKe7rVcQUUNXp1AeTdawgSgrRy1ugJor02bp7rPE1PhB3vp2ytDJdD9Tnxn/Qr04tFxomloVpsAPzB02aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:08:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:08:33 +0000
Message-ID: <2f4f3770-0227-4744-aca9-9955de48b7a3@siemens.com>
Date: Mon, 27 Feb 2023 08:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/8] use bullseye backports for
 systemd-cryptenroll
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: acc905ae-f4f2-4868-cb45-08db18917008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BTweC3sejPy2+qXvkhwH7rh6CKAh7Xe56Jj0UiGz7sarUw19gHSx0LEgLQPThCQJI+fMtVswIEp4lLB5pZtqPg4weVFEOPHndc4JkfiTe9at1DhiNMLCEvk03E7+uQ2D3Hg/PZWkVMh2B+U9XXNHvXzhhVvY7Y2IceFahj9LpTHYmxj1WBeH/8c5GUYT4U2wMW4S/vot2TaG+/TLk88UhkmA3yc6IEG9XosmbQUCTBU/S1/TpbT5nUHE3QkSnTkcIPiQsFmSC6Pzz5E4oZ9Ng+Ei/Hq7FBOajK0n0xnaniepu14t5UkOAJWNxZ0+JQPYsn/UsMMKCVsO/YJHyTuKfSiKFLQPbeDv8u5UWaHZOup/Nh63AnPyl0RKOTcWP22yF9Zpj+KntfweRIHzalYXYaOxaeK/NIxl7lreL8NTSY4Vv6+nAO4+8Pp5SJKyUdHP761xyLSIS281+PGiZG8c5/aYAS4dboNgD394NepSfc+q5qDHSe/0DCeXd3E7E8x14OAH+buTHyDALm6mBHE/Xb+dU+5UKHeyVsMlaMW+whYi6UfokI3h+p7hBk28m/jNYE/K5Xiwf+6mudbjQmOqhZ0UD4NyGuMxbR8IZP1f/LVT3WNDXHa3+8y2ix4y4DxizptYQxYywIWclkNbJwWh/6buifvTjka36JQRjouvd+5b7br40153NhkoU/fiozbw4FKL7cIKEmwHoNzBEbNdIXu1KWdcCHYNW7LpbeLtDhA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199018)(5660300002)(44832011)(36756003)(86362001)(8936002)(31696002)(478600001)(83380400001)(2616005)(6666004)(966005)(6486002)(26005)(186003)(53546011)(6512007)(6506007)(66946007)(38100700002)(66556008)(41300700001)(8676002)(66476007)(6636002)(82960400001)(316002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?byt6VmpYaGJ2Wk1LZXowSzQxNkFhSjJBcDdhQmcrVWxwRWFUdjVLTXJJSzhp?=
 =?utf-8?B?VlVqVTkxN0dNdkxGR05DVThrN29MS0p4S0N6d3FqZkF3Y0pxK1krTnVPWE9o?=
 =?utf-8?B?RDdSYjZUclV0Njdvb3V4bE5BRkpGS1dwZnV3bFVwUFArYnI3RXFvZ0ZESFFP?=
 =?utf-8?B?ckl2QUc4ZmFoYjM4akxHdFpEbXppc2d3Z3ArNGpOT0dmM2szQXlsaDZGeEhP?=
 =?utf-8?B?am9VQlk5TVlkWGJnbCtLRUx4SDFBd1VIRS9HaFN3NUVBeEUrcHA3NndPbkpH?=
 =?utf-8?B?anc5WHJpVGQ0OCtENmFrZUZUaFR1TFpSTUF3NXJXR2hweHI5MjNrRjgrU1Bo?=
 =?utf-8?B?Z0pRb3UzR3JsQ1BRQis1VUFsbWRZdThSVlgvY2JHMlBjT1B1aUFicmhMRWJo?=
 =?utf-8?B?eUxMcXkzU2owa0hheHVhS3dMZFl2bzJsa3VqMTgzKytPMnN3ZUdzWDRGTzNE?=
 =?utf-8?B?SlhCR1greERDSHVKQlphZlB4bUtWZlBEeHZ5TUloalZub2toWisrSlFBSW0z?=
 =?utf-8?B?bkY5WUdVRHBIdU1ZL21ZT0s1eXlXWlRiWHBBZk0xdXlDYXU4K2p5eDVPNWVY?=
 =?utf-8?B?LzVPOUFVQlBFNkdoc2sxbklySlZ0MGd3VDFOdzByRFpIdmUzNnU2VzNDSkNJ?=
 =?utf-8?B?d3pmclljY1lPNThZOWxMd0htQ1JEOTY1RmpSQnkxZVRYdytYaDRsWktjTWY2?=
 =?utf-8?B?NENOa3I1ZGR4ZTRhbTZyTjVHTU1nc3dIWmdiZXpvOHJuTkoyRnpvcVI1M3Vl?=
 =?utf-8?B?SXBDaUgyQ3dpUTMxYVNoVU9lMDNLVno4WmxGSFRMT1dBVUo4R0wwMTUxVTNV?=
 =?utf-8?B?NW16RnUvR1dnNmNCVmJDQUJPc0tLTXNVdDhISzNXdVVCUjBMbS9TUUNJVnZV?=
 =?utf-8?B?bkpCRzRhSm1BT1BneW43bWhuR1VCK3dyMmc2QUlRejN2am1qNUtIeUgvaDE4?=
 =?utf-8?B?aFl1TWxzOW5tVUNXdUZqN1d4RGhJZWZyQXF1T1dXTHNEa0ZjTCtIdENNSkN5?=
 =?utf-8?B?OXFrdVVuRnJ2QzlMZkkwbWZFVU5xZmVxUHd5RHJONzI3UHFTa0lyMjBndGV4?=
 =?utf-8?B?Y3JydW1ETEg3bjVxU1lvd2podVdzWU4zL0RQT2dwRExOM3QvYWNlSDFhSTVF?=
 =?utf-8?B?ZWZ3K0RHeDdGWkphMEo2b3Z1S1c5ZkpDN3B1dHJ1QTVNWWY5UXNtcXY3VGxw?=
 =?utf-8?B?YXM1MWx0QzNac3F1N0lGbXQ5dUtwaGdyaC9tRU9RNEZPVFFCOGMvdWR0cit3?=
 =?utf-8?B?eUhuQUZYVFV4aGxYVUJXTVlFNU9IRXRETUJzZGtGWGVnZ21zQ3dlSHVxV0RI?=
 =?utf-8?B?cmNZS3dGN200RzdkemU3eUl1ekh2aUZZd3pocThsdXlrcTg3TnpMU1dwcjN1?=
 =?utf-8?B?NW9RVEFCbU9rQmEyUzh4Q25hdVdPU1NIL2ZrK3Mxa3F4QjhzMjFKOVlqSnBq?=
 =?utf-8?B?M0FyZEtLWGI5TWVINzY5a1RKeThHK3R5MWtZUnlydXNjRjU5ZGNhZzFocnlN?=
 =?utf-8?B?ckExSmdQUzdHUjZMR1VvNjFMUUhNUlBReVdya3JVOVpyVnpQOHV0czZFcmsr?=
 =?utf-8?B?M005ZEV1a1l0WVVacGphZllBdm8zaU83ajhkSUlxbnB0R1lVak0xUncvUnpk?=
 =?utf-8?B?VHc1bGdwS2M1aHNNUU1GNmx6MU4zQmJGa05EbWp3Tm5nU2tEUDhKQU5HbXpl?=
 =?utf-8?B?dHo0NGRiK1dEekpXYWUvbWV5NGxUYlltWDdaZytQY0pxS2hmV3UzaDhDcFBR?=
 =?utf-8?B?clhIMm0xbzdpN2JmSWdXL2pyNmg2dzNnT1p6QXZucjVzN0N6dU9DbFh0bURy?=
 =?utf-8?B?dHBXOGIrNllsaHQrOWVnY1N3MnkyZDBDOWNEcmdtbWpubzFQNDhQMno3bHRa?=
 =?utf-8?B?TlNYVG13bVY2YWFVa0pMdDFuNHhuaVV0V1pUWGlZaG42UHNXaThXbmQxOEFT?=
 =?utf-8?B?clB4SU9MQm9RZ1BsU1ZNZzgvbTdpUWZXZ2I3dkdWZTRJcWtjZTR6dFA0UXQ0?=
 =?utf-8?B?QlBjNi8xd0ZUOUwyMXFCTHlrekVGMmxhMWJVZWRuOTZWY2pxY0F3ejNaRkFa?=
 =?utf-8?B?ZWptdjkyMHV1QUZnZmFVb1BjZzhXY041ZWI2ank5ZnNIWmNXbTN3TUJFOG9U?=
 =?utf-8?B?R09LT09XUFF0TWdrYXBtNkpoeSt3VEp3WnhMTWpjTW9iYmwzYmtRR0RRK0hN?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc905ae-f4f2-4868-cb45-08db18917008
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:08:33.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyADLVTxNTDwTTyShnU8Oh3Mw5LhRDo5wX8nC800n47sZwYqt4+q8JKMihj51x4wchTX41b51q8irOgtccf4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 07:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10857

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Systemd >= 251 is required for systemd-cryptenroll. This version
> is part of backports.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/debian-bullseye-backports.list    |  1 +
>  .../preferences.bullseye-backports.tpm.conf   | 40 +++++++++++++++++++
>  kas/opt/tpm.yml                               | 20 ++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 conf/distro/debian-bullseye-backports.list
>  create mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
>  create mode 100644 kas/opt/tpm.yml
> 
> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
> new file mode 100644
> index 0000000..3a55e4c
> --- /dev/null
> +++ b/conf/distro/debian-bullseye-backports.list
> @@ -0,0 +1 @@
> +deb http://ftp.us.debian.org/debian bullseye-backports main contrib non-free
> diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
> new file mode 100644
> index 0000000..918745f
> --- /dev/null
> +++ b/conf/distro/preferences.bullseye-backports.tpm.conf
> @@ -0,0 +1,40 @@
> +Package: libnss-myhostname

You can add multiple packages whitespace-separated to this line. Will
make the file more readable.

> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libnss-mymachines
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libnss-resolve
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libnss-systemd
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libpam-systemd
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libudev*
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: libsystemd*
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: systemd
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: systemd-*
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> +Package: udev
> +Pin: release n=bullseye-backports
> +Pin-Priority: 801
> +
> diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
> new file mode 100644
> index 0000000..0e4dc95
> --- /dev/null
> +++ b/kas/opt/tpm.yml
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +local_conf_header:
> +  systemd-cryptenroll: |
> +    DISTRO_APT_SOURCES:append:bullseye = " conf/distro/debian-bullseye-backports.list"
> +    DISTRO_APT_PREFERENCES:append:bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
> +  image-option-tpm: |
> +    INITRAMFS_INSTALL += " initramfs-crypt-hook"

Two-sides sword: The one hand, we don't need to compile our own systemd.
On the other, the question is if the choice of backports for such a
central and potentially security-critical package would be a good idea
for a production deployment. I don't think so.

At some place, we should leave a comment that this is for demonstration
only, not for production. Only bookworm will change that. Or some
alternative to systemd-cryptenroll.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


