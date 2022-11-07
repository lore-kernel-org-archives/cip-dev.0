Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B137C433FE
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 14:02:02 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.81])
 by mx.groups.io with SMTP id smtpd.web12.3576.1667829713734042444
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Nov 2022 06:01:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CMAZ02bC;
 spf=pass (domain: siemens.com, ip: 40.107.2.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG0Ycp4/XmCfgt8Nj+t0if5GFwkLRE2FUy8Sv8+NTgvfnMbCMsOH//A2ZzJMAVat93oWgsViniJ4M9zyFT9veGvhbg0Wv0XhKVIauCSJNKUF/u9kn/c7AdK+mVlEDXHVcpS4oSfCiqv2a12+WRjuD6UcmmA/ALZpegFphi7Oyu5CA0+/Cjs3SSzkw72Rq93qmcrKNYtDTQMp2A8EQahB6n8KkFkvb4qZmwSYAB83W2BNcth7Bjpp+Oafk9DF6doUFJMvNh2JiPl9oe03cBpFNMPzbZrRDyzTB0tBmRXUrTfV7dBVDl8/hGmtqF4mZGViD5nQNc6NYw5Xby+ldPTtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n59XEsd8FqGEppdeXBbhWSlOUH4fUBtRoDKtVsApHQ=;
 b=iujJEV9rEFKJKKB7Ac/NtZ6pMA2Rc+t3aBSMn3qWuenfObw5HnmDzqCWp6kBtr4HtVrehHVh3WPK08ZzCK8wvwZRnlxt3LIeNnrFzo/U4h4p92dUXmIt/Q+dZM1Z0kavjT5oidV6TuY8swK6jmxgqMrbLc2KWX5MksIGh4+d39zaJfUZkBNG5ibiKjQdyPszbsskr7yH5m2fOApm3GwZUp9HfU8NmwB0znfwmzYEQPow+9JRHUn1d/cp01XJjMl+/Xr7hK6Q8FFQNnzqymDzJYqr5iLaF4XVK5kkC7P9ZiB3FFzp2XxmtyBgMAiVc2wh6p/Ib/VN3XYi6raytfKfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n59XEsd8FqGEppdeXBbhWSlOUH4fUBtRoDKtVsApHQ=;
 b=CMAZ02bCDldpI1N4GDitPWHWCpyJmkWHASOagEor8iWWKDX6NQXXB32LHizqB37wCA34+Xr4K9R9byHxM2QA+6X5jCV/GmLc5D65FSbL6gLjCl3kh+jpZOLymt0HtbLQLPM1r7dTGvmEwVtZpxbLMk80FEVdiiXYXPUzhQLbP3OhoTkcH6oLQgzDEG/BUhqF1s0HwV/eJ33DcAEvWpM2/zx7OcJ052ZlUydwFX8To4YN0DpMUwtdNPyMwXGr1Af6fUfj0Ap+DMe6jvuSyRhzp3tSvbgwd/Q8fVaf25WYYLaGZMyNtvm4bcEDv3df2XNRqiruwUki/H6PzF84cxuaIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 14:01:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 14:01:50 +0000
Message-ID: <c9ae8c2d-ad6f-8457-6b7a-ad14a40c8904@siemens.com>
Date: Mon, 7 Nov 2022 15:01:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] tmp-fs: Use systemd tmp.mount
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <ea6e38ca-1bd8-34fd-7329-f64705912091@siemens.com>
 <20221107093146.104489-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221107093146.104489-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4462fcba-742a-42cf-61f2-08dac0c89e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G0WqYMgnJjRVdXagBCxfMOfEvTzYNdmu48TfBOnDPMD3qUNtyU5XHgFW5DEMJ6oyjpZSvwcxpEO3ooAv8+cwrc+MhONf/9Q2jkU6yY3FvhXtNh3N0b1wHNrOdi7NWK5NOIRCllIuz2ncCrYBfagj9R10tVrlR7mAaDQJ5awW4/y0TAV2Z2HjWFNpJSMxQrFWsu2QP0tpRhGynJXvWIBKNad9CyrBwVK7W83l+pyXFfnb0aSXtggeCz6q0uYpMHAK8Svt7pgU8uvXMVyqOmZ3G6x/YQBsdBLTO5AjD0KMrPR1Ets91nrUeisl4MXjbbexgEDYUoB/Tgwp9Axz2xgTtfFoPmHBpYqimN6LlcZyg3jQQYcFqVzRX4Q6v7eO+uLhNF2d74nl3sHFCFz/6yRTPkUQ8qbFcFJCU9sXTPjIXG2ClDjsqqcioM+1pz2tHvmrYfi2yzSDpveoHzP4vjrCyZsDojZxojSqRMpK1qDur3GftC7QmfGJI/wOxxhZP2gzAMnG4TfREDtSyTzVx00KVAf1r1Dq0M6qZ7sDvuaGpd15fxl/G7Paje0f/amlggjQ3nSkRG7PLRJBlKYDBtWUTmmyP7CcG9BPc4prfSZmpoR8S3FYJxYcr20/7ZKLU2KJjn4v4862Ft4/p9hkyqfOZmX0D8HvefA8vVUXvg+RBMHAVRwHk+6Z0f5FnS+so8KPT85Uu0zDDCaE0Eh2o4ov9dXFQkkTBc+Oox3ySAW1kFy6+tpQ8vxik9PQnJuRDJ3TDgYnqs+v5dKpVhhMw7qyj/MBq6yiD5+gsqry0x6IFLHH+l9iFaXOcT0i+sd2yXq3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(31686004)(66946007)(66556008)(41300700001)(66476007)(8936002)(5660300002)(44832011)(86362001)(36756003)(38100700002)(2906002)(316002)(478600001)(6486002)(966005)(31696002)(8676002)(83380400001)(2616005)(186003)(82960400001)(53546011)(6512007)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enNTcy9VK01qUjhuSURESUZsMGM3MFErYmIzaW1nOGZMUnZqeFRoa3IvMVYv?=
 =?utf-8?B?aXNSOUFSdlcyQ3Y0QmV3NXN0UFM4ZFBCZXg0ei9yd29QakFVOUl3czFpSUNY?=
 =?utf-8?B?NmUyVHprengxNUJDbzlXU3FQY1ViYVFVQlFlUVBZeGIrUWtyeldxSXBoNzhQ?=
 =?utf-8?B?dDlkaXVrTVF3cWN6Y3d5Y3RxR1ptUm1oR1dsZ0s2QnJ4NWo4ekwrS3FDcUVn?=
 =?utf-8?B?THhxeG1udldiaFdhaVlHdFRaU2RuVUJMeTRZeUFTTkRlT0F0aXoxdDExWFY3?=
 =?utf-8?B?NWZkSEdKdE55THN3Y21haDlISS9CUTg3WEI2VDJTUVpJL25xRGJZRSs0Uncy?=
 =?utf-8?B?MFBkT2pmbnJmUWZMZDJrdVJraXZhWGxHaE1SQS94K1MvZlNCQm51S0Y1K3BR?=
 =?utf-8?B?THBaZzJOa0kwdGN1K3N2SWZCaUFWSzNSTlV4NWh1Z3J6dVRuTDRna2RCcWsz?=
 =?utf-8?B?ZjVEeWszQjVYVi9RZDVHZDVONFRoS2J3UDVrYW8vRVRTOFUyeU56cFZNNjZP?=
 =?utf-8?B?cHIxZFpoVDUxL2FFSUYvWXluWW9qNTYxQmFZLzlJSjViNGQrUnFFcnNGVnJX?=
 =?utf-8?B?VWdqeDgwM2t1ellvTnI4RTA4cU14YzhyWWVTSHVvWitKUStnKy85S2JHY0xp?=
 =?utf-8?B?ZHdUblRHbWpIdWRNQk9JVUpzOS9Dby9nN2JLU1l5M2IydXBDRkVyelVyRU9Y?=
 =?utf-8?B?Szg0VFJVQi9KK0xOZGJtaEFjRnNHeVZuaUNZUWhjMW8yNUVuMWY3eXNEeGpL?=
 =?utf-8?B?VDJVWUEvSTl6a1k2ZFVZMDViSnJ2bi85MXRKTlp0d0NBWVkveUp0TWJWeWY2?=
 =?utf-8?B?dDJ4YUF3c1h3cTNkTk1rZkNrRVF3Wjl1TjRsQVZHSXowS1J0d2VQODN1RU9s?=
 =?utf-8?B?bDI4anZtbGJLSElnbUtaNHlGSkVhZFVsMzFweDVUZGdBYitTZXY0UDRKbFhQ?=
 =?utf-8?B?bEZTdVBISXE2ZTFOaktHQkRUNlA0QzNGR0JCSVV2UDJodjl4SmFmaEVDcS8x?=
 =?utf-8?B?bURNTWg2YTVJSWRhZU5wT3dFU2l2WmlsbXdjMUF0MkptU0RremMrVTBEUWFY?=
 =?utf-8?B?SjVwVTJaUi80Q0laMFRKY0s5eSt6L3FOelJqbW8xUi9jUGk1TTVrUmFsTjFK?=
 =?utf-8?B?bFVIc0R1VmsvaERzM1ZxSU9mNXdNeFFVNXdQWmkyMy9UMFVlKzlRUlZySUNN?=
 =?utf-8?B?VS9yL08yUGpBSkV6eHAvSjE4eXhWN1puaHhhMGFsWkNDTW40aHE2M1RtZWdj?=
 =?utf-8?B?QTFjdUx6SVFZWHdIM0xmdGg1K1FpZk9FSFpCQ2RFOGNza2xjc2s3L2xoYVU4?=
 =?utf-8?B?d1p3M0Fic1FCMkRYMkxxV05ubzVBVDJRYVAzaGRldm9YcFJBTWg4d3FUMjFm?=
 =?utf-8?B?aHRLVkxMZjhzcjFwcGt1bmRBYm9PTk9VQXgrOGt3bkl5dTlNSlJ6V2tKSnlX?=
 =?utf-8?B?dWV4b2FmaTNXK2F4Tmo3bEVjVnRoUUdrNWN0QzZCcm1CdC92L1dOTVBmbThN?=
 =?utf-8?B?Yk95cEgxUGFid2wyKzI4YmVXMzE3ZGNpUGdMaVFxVGh4akc0Z3BwZXhycGUv?=
 =?utf-8?B?dFdpWmYyVTh2K2U1MmtBRGVxd0o0dEVDdEx2T2NGeDNiUmRkcWw2cHZCZGRr?=
 =?utf-8?B?M0NnMjROV3lEVmdQSGdSRDV3T21EN2JBczY0ZnpBL3ZDbVo2amFUUkJBL1Na?=
 =?utf-8?B?ek5QZlFIdjcwcmxaTi8yUk5yZzh6aWdSd2NBL0FvZk1BWnZ0d080Z2pRUHJm?=
 =?utf-8?B?eGVtQ0RPcEtnSno3UXRqZXpBOVJvZGpVRjRySUpHdS9jd3RTVXJpTDlUMDZE?=
 =?utf-8?B?cVErWEFVL2l1c3pKMkE1NDlXbnRqUkt0SFhuek9PekVsMitLSm9VR0VIbGg1?=
 =?utf-8?B?Y1F0NUJab2ZkUkhrZ2ZEVE9EZXF1S0JMaTFDMzdkUm1YWkdIb0s3M3VuYnJy?=
 =?utf-8?B?YzFhN09Ma3FzV2tMd0pmcjBtcUlPOGRSVmhyK2xNTnlJbVN1emVpNENXTnJR?=
 =?utf-8?B?YkdwMmIvZWprWm9STnFuK2JMVEdSMzl1cUtCNHlGNmxab2cxc1ZiUys5enZ4?=
 =?utf-8?B?Q1h6UGpyYUZISjZCdWYzckFFMlZyYU11eFNMUHFoMWRVOTh5d3dQdmFoSFlv?=
 =?utf-8?B?MGRNdTVCZmRTblR5RjFqeWRXS0ZiKzRZeFZZbU5MUWtkTDFaQ2xadFU5UHNI?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4462fcba-742a-42cf-61f2-08dac0c89e14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:01:50.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GOh0qdjAqn8eASE9R+iyDzpjZkQJTmm6CP431h1jDQuLtnjl5NmBg1J0lE0WdxKhL3SE5555EboVAsfzqXC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Nov 2022 14:02:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9941

On 07.11.22 10:31, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Debian moves in [1] the tmp.mount to /usr/share.
> 
> To use sane defaults use the by systemd provided version of tmp.mount.
> 
> To overwrite the options use a drop-in file as described in [2].
> 
> [1]: https://salsa.debian.org/systemd-team/systemd/-/commit/5a9a0e7d25ac7ff0f1113ddb4219cc554b20dffa
> [2]: https://www.freedesktop.org/software/systemd/man/systemd.unit.html
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes in v2:
>  - increased recipe version
>  - added empty do_install to avoid log message
> 
>  recipes-core/tmp-fs/files/postinst       |  4 ++++
>  recipes-core/tmp-fs/files/tmp.mount.tmpl | 11 ----------
>  recipes-core/tmp-fs/tmp-fs_0.1.bb        | 26 ------------------------
>  recipes-core/tmp-fs/tmp-fs_0.2.bb        | 16 +++++++++++++++
>  4 files changed, 20 insertions(+), 37 deletions(-)
>  delete mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
>  delete mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
>  create mode 100644 recipes-core/tmp-fs/tmp-fs_0.2.bb
> 
> diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
> index 07017fd..2db15ca 100755
> --- a/recipes-core/tmp-fs/files/postinst
> +++ b/recipes-core/tmp-fs/files/postinst
> @@ -1,3 +1,7 @@
>  #!/bin/sh
>  
> +if [ ! -e /etc/systemd/system/tmp.mount ]; then
> +    cp /usr/share/systemd/tmp.mount /etc/systemd/system/tmp.mount
> +fi
> +
>  deb-systemd-helper enable tmp.mount  || true
> diff --git a/recipes-core/tmp-fs/files/tmp.mount.tmpl b/recipes-core/tmp-fs/files/tmp.mount.tmpl
> deleted file mode 100644
> index be5e663..0000000
> --- a/recipes-core/tmp-fs/files/tmp.mount.tmpl
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -[Unit]
> -Description=Create /tmp
> -
> -[Mount]
> -What=tmpfs
> -Where=/tmp
> -Type=tmpfs
> -Options=${TMP_FS_OPTIONS}
> -
> -[Install]
> -WantedBy=local-fs.target
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.1.bb b/recipes-core/tmp-fs/tmp-fs_0.1.bb
> deleted file mode 100644
> index b86b0fb..0000000
> --- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -
> -inherit dpkg-raw
> -
> -SRC_URI = "file://postinst \
> -           file://tmp.mount.tmpl"
> -
> -TMP_FS_SIZE ?= "500M"
> -TMP_FS_MODE ?= "755"
> -TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
> -
> -TEMPLATE_FILES = "tmp.mount.tmpl"
> -TEMPLATE_VARS += "TMP_FS_OPTIONS"
> -
> -do_install[cleandirs]+="${D}/lib/systemd/system"
> -do_install() {
> -    install -m 0644 ${WORKDIR}/tmp.mount ${D}/lib/systemd/system/tmp.mount
> -}
> diff --git a/recipes-core/tmp-fs/tmp-fs_0.2.bb b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> new file mode 100644
> index 0000000..bb5fcce
> --- /dev/null
> +++ b/recipes-core/tmp-fs/tmp-fs_0.2.bb
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +SRC_URI = "file://postinst"
> +
> +do_install() {
> +}

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


