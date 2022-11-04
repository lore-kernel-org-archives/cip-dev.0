Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E3C43219
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 18:29:02 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web08.1155.1667586539318104863
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Nov 2022 11:29:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cxkSXsue;
 spf=pass (domain: siemens.com, ip: 40.107.8.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Bfmoi27NrlDicq2PEGrUZh+SJUqGqECKsc5Bw5yxm5E9997FibMUAM8xJ/zy+00OAuQjLOrc6ktP8QSM8BzOuMUcxq+XNgW/yj/CNcCNmQA4bHI30XaMZKerjK9qK7BnsA4EYYVh52pPPPMDWf4qE4gmCrnPMH2cUCMozosJ2EXT62y5ucSvVB57+RLyssDP0SqDev11TgNSCp+Uj9YJEqM/Wv2SFZMew79oL39kd1OaQiLWnZBgw6TuQnkZQe4WOfV/7nyWNSOSPDDaUmBaqhVT5PuWF1uN0oKgW9k7w6qrXylpF+jQ7ERi/7ckDzQ51N7rfoaOPLwHAvJoixIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg+P5ZJ48SYudLRPq7YA9EbSL8jighKHeu5nwQ42RDM=;
 b=MWrUM45E3SYHgswmfD/1D2RV+DQQpmldgQp8TW3f1/kFWcTg/o6tXvM5gvJuuvBnH1YnIw60xTxLgsSNVapsjF6SS6nUXIw3kIL1nwlhJlpGRGs8rQOXwc2w5xw3X14AMCf25F1OXxUzABq9kIJsUjq0ojzLq6yBmN5YLP3WkXgwta3UEf0udNpZIHNzgwMDToEuqCT/hz3nDkZa6RnNP2E8xyN9dwTVWQKdRZAU8e9HYNjBCXNae/ThLn0C9FCDIh3FwLiaNvJlqzWv2r2bNup+SejRbTeyuIoKfYVva0o/NxKZphlO98kMCWbuBkKf5aEkdh15U27aNrkyxG6GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg+P5ZJ48SYudLRPq7YA9EbSL8jighKHeu5nwQ42RDM=;
 b=cxkSXsuewtYD06DtKy+Lv/evN7S3G6cehBI32tuiSlQqxs6lc7R7SpHbSFuVT3yMDaEhKkFhJD4XJqxw2IIRywKraFhtor310c/2oCP1eFDWXN4gK/XIzaUN3rxJJkr4ACPw07f4o3sXJr6APBo10f9jHDz+oV23BwkDyDQWVeaYmTUkCB7MlWJvmdmxr8uBDfpUO2ey0EbUrhxSf1h2pk370knYQQDn+kcMA6l+9gJXF7J5ip/2ANeYxncCL8/qn0Sha0W2/DrZCm1ELWDwvXmsSXrEPFa6OsBgBdlFU7cYQdHF1dQxNgCODsxcauuZPoc4kQbcfEPttf9g4DyYHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 18:28:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 18:28:56 +0000
Message-ID: <ea6e38ca-1bd8-34fd-7329-f64705912091@siemens.com>
Date: Fri, 4 Nov 2022 19:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] tmp-fs: Use systemd tmp.mount
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20221104130756.195716-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221104130756.195716-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfa56b6-09b9-43bc-20e7-08dabe926edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sqFk0VOy0jGt1dhyRRofZ7+/VtIZ7QpwAoz2sUIpZ97hZ6Fdn7FRUizbN3UflJ6phQQZP9DRyMIEhUddf8cyosO4RA/7LYBhwzz0J5OHFDFyV48D+9L9hSJWIpQqR1XwEsYK2Ybu71VSwNM76qWxQpPl15++Dfg6Fcz8RKQWtsLvfEZ93nz1ckOl6RyXJ11WPtAtgGRo/rYpeiNjUVQ9+wFsOR6snp21DeNKNyQDRHPeNrTJ8gowddExjQ58PYSZAe2mllRVazh633O49o8xMbG+ejbVO6OD8Ysbf7MrxqZb2gwU++CyvVEwhlS/2Oob2hL227VNRO1QMrs6rs5t7AsDwPVudFDml5xKeq40lx7W/wz+KhCUo3l+nEUwBlr8IvHZ7nzOLR3XjlmE+YBIF2+RGYed0AZFvS8qFbf4tb0Q1XqXs51aObnSH3sk0x0D+zAEZLNT63AQOl5I9vFfzmij4q8kqQabsKrRB/aw6CX/+7+mgvGmWMIuD3jotSE0lsrKCxzooQ7srFozNb4a20hvFS2eb7B8ska4XSvQurBxjlBrE8X4Ep/U/QA3TmWxSQ7Ku+CVEtJFSLWsB0Zo3ZgTjHzy/RuvS7JEmCvAYnKtp95Pvfzyxpfyrx3hs9EjC6+esjZW+lEILeSECX964S/Lcgpgky/TWHpkSmGkXPEbbAtj7pGMrNqzsvHAGzsb02UX/jK0QttVjc8Ct2ylqv+c0KrYJph4vitrr3TsSV5eAQBKgD4WNdM524MQbwoIbmSQwJ8u5RtEnrKEPnd+0AZl8lfFBKSp5EJ/0B4tHaZ5egXJZsZ0FNHiYrN+VhIFAlPOFDsbWnvCrWwbULoeKoo9JNqQQTv3pPmkequBvyM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(31696002)(36756003)(86362001)(31686004)(82960400001)(38100700002)(2616005)(44832011)(26005)(6512007)(478600001)(53546011)(2906002)(8936002)(83380400001)(186003)(966005)(5660300002)(66476007)(66946007)(6506007)(41300700001)(8676002)(316002)(66556008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1hKWmxUOWRjeU1XVjdDY3REMXc3L1ljY1NnMHBtbmxIR2tVZG82eEdQbEFq?=
 =?utf-8?B?T1VOVVhBaWU4UGZkTnNmUHIwUm56ZkRTb2VCanBCQkJ0Z0E3UmFkUHgyejhQ?=
 =?utf-8?B?bjlaVEZOMUFDWU1FY3FmaG1PTW52OUhLZ0NVanIxL2JldlpFdXFjVHQ1ZDJC?=
 =?utf-8?B?RlBsS05TbHlPRWVBZ1EwUXAyYzJ4aC9mSXRaM01hRkUwcWtVKzJITGJiMGl6?=
 =?utf-8?B?NDNGTE84MStjUjdQd1lBb29BVy9zaXlSNTh0bzhLdUI0VTRLSEc5N3hVNWph?=
 =?utf-8?B?cW1tUFZWRmcwLzVFckZlWEZ1SzIzekhzOFAvR0xyUGZnaDNRTU9LempVbzhh?=
 =?utf-8?B?U1pQRDlNdEdFZk1JQ2gzN0NvazBjekVSejNaeTgwTms2Q01jb3B4VGtjeVV6?=
 =?utf-8?B?M3hLSkwrd3AvSW9rNkpMRDlZbmtISFpnUFZwMExsSjFkSGFSTU9hT2M5OHo4?=
 =?utf-8?B?OEtiMUpUQk01Z2tSb1JpeC9VMGExM3Z3bHV5dFN5YTdYZi9mR1BZektsd2N6?=
 =?utf-8?B?enhXK0tBZG9LdnhHaGVYRjVTL0R2clZkaHZucTJZdmR0L05ZbjA1MFJhb3Ja?=
 =?utf-8?B?RytLdTZwNUhtUnV2VmNFd09nUnZnSkVqVnFaaXorZGRSdkhuZ1Q3LzlmcVZk?=
 =?utf-8?B?TnVaQWY4MEFWOSs2a0hYNTQ3OUtHWHNoMlZ0VUg0UEpOS2Vmd1FZWUdYMllR?=
 =?utf-8?B?aGJlTWx1OE15WEZnQmNJWFdmVTR6dDNqTEUvN29ObjlYa2czOWNwenc5KzRo?=
 =?utf-8?B?WmkyVzFVQ2ZuYTh5OVhqcFlSZUNwbEtJcDNrUTJYNkh5T3NtaHVlODdWR0Z4?=
 =?utf-8?B?WjloVnFGZE9UVEE2Uk45dzB1Y2xsTzRBV3Zsa2xJVEtDdjJ6QXo4OUlxKzRk?=
 =?utf-8?B?R0JWOU9sY2lRZXJyUG1qVDJlMHJWQU1Na1RkV1o4RkNMVGFtNytpVm11b2x2?=
 =?utf-8?B?M3BXR052TnFRWlZPUWluVGZmMGYwRnlMdUE1TkRUMmgwQ2N5ZEo5cVVTQXVp?=
 =?utf-8?B?SEhLY2lGWmlJeU1sUG1XRm41b0d3K3FJdDVROU15N2cxM2hWOS94Q2JaK1Jq?=
 =?utf-8?B?bXRMWk1zZHEvR3J5NDQ0U01OOWlla0tSaVpCZEUxSDNZMTZvbGluVDRrWHN5?=
 =?utf-8?B?QmlHZnRmbXJoOHhoZEUzNTZ2dnd2MUZtNVpDcVVIUEY1MjdMY0JFVkdNUmNK?=
 =?utf-8?B?RXZKQVdyaXJYY2FCalZqcEg2OHJCLy9aNmhQdVNzZkYxbERod3Z3eXBWVzhE?=
 =?utf-8?B?eXFlSXhOWXNya25janRENm1haHBFSExqbStEM2tSQ2xyNW91dllYMWh2N1Yz?=
 =?utf-8?B?SGIrOEp5SGhtUkd5KzhWSFVmNXVvcTkxWlJVQVY1WnVVaDZPczV1eGZGbHAy?=
 =?utf-8?B?ZWR2dzZCM3lZLzVad1FWM2tVazl6ZjJGcjIxQlZHdk9URm1FdDlHYUl0MkIy?=
 =?utf-8?B?NWFZR0llTFpXZ1diNHlxaUI3Wmt6NDRMWlM5Ny9wUGp4RUZPcVlQNko5eFpq?=
 =?utf-8?B?OVFaNWtqcWRMdjl0SVowQ29TZUFrSjFpRTM5OGo0UXMyS0hJV3R6aGRlcWta?=
 =?utf-8?B?aTRjdi9DQXIvUVpLUHptMzR2TWdHdzVMT2NOMTRKWkhXRlZwK0lPMkFJMmlI?=
 =?utf-8?B?WHA5Ri9NM0NqNEVoMkJMcFh5U2N4QmtuL25aeGJEbi9kLzZRVHdqRVhua1NR?=
 =?utf-8?B?QkU5SFFNRXRCMzhzOElQNkdIa0dmMzNiK2hYbUVKaVk3NzdCS3dyYm9DMkJz?=
 =?utf-8?B?TWNGODR4ZkFyVDB1d2JMVjRvNWZmRllLVGNnWUlzWDcyNElKQUdqcE50cEgz?=
 =?utf-8?B?VjBEZGJoQ0s1WFF1YjdiWVBKSXJZREZXWjBrWWI2SkkzQjJ3d0lXUlBiM0cx?=
 =?utf-8?B?VDJlL3p5ZGhiTk5UdVhacHVLTFVYWDYvd2drUnN3eW9JMVVyRktObXB3YVdL?=
 =?utf-8?B?bitxSHR4Q0t4WTZVN0xOdXV4aDhWWmwwY1I3Z2cvWEJEQTJZdTk5eU5VUngy?=
 =?utf-8?B?Q1VpWExKcldLVVBLYXpRMWNlVHlQYWVFU2svNE1IRFpqSWE0ejVZR2wrU0Zl?=
 =?utf-8?B?dVAxOHVOVUh5aEJCSnZwd1A0RkEwdWdzVVRKcHE0RWNoMFNTNjN4VDJ6eXVD?=
 =?utf-8?B?LzFBK3lrRmlWcHFoNzhRLzZ1by92V09sK3U4QzJEZWQwcVJjUmpzSytXZjJK?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfa56b6-09b9-43bc-20e7-08dabe926edc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:28:56.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9fZ0GUZwh2+PLe1QYUrQ7CxKL+FD0rCjcIHsDCcipXmRzq9PeP+7WlH7MoK+1QwglqivZ2uVOW2QehEmLISZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7636
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 18:29:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9935

On 04.11.22 14:07, Quirin Gylstorff wrote:
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
> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/46
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/tmp-fs/files/postinst       |  4 ++++
>  recipes-core/tmp-fs/files/tmp.mount.tmpl | 11 -----------
>  recipes-core/tmp-fs/tmp-fs_0.1.bb        | 12 +-----------
>  3 files changed, 5 insertions(+), 22 deletions(-)
>  delete mode 100644 recipes-core/tmp-fs/files/tmp.mount.tmpl
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
> index b86b0fb..87d04b9 100644
> --- a/recipes-core/tmp-fs/tmp-fs_0.1.bb
> +++ b/recipes-core/tmp-fs/tmp-fs_0.1.bb
> @@ -10,17 +10,7 @@
>  
>  inherit dpkg-raw
>  
> -SRC_URI = "file://postinst \
> -           file://tmp.mount.tmpl"
> +SRC_URI = "file://postinst"
>  
> -TMP_FS_SIZE ?= "500M"
> -TMP_FS_MODE ?= "755"
> -TMP_FS_OPTIONS = "nodev,nosuid,size=${TMP_FS_SIZE},mode=${TMP_FS_MODE}"
>  
> -TEMPLATE_FILES = "tmp.mount.tmpl"
> -TEMPLATE_VARS += "TMP_FS_OPTIONS"
>  
> -do_install[cleandirs]+="${D}/lib/systemd/system"
> -do_install() {
> -    install -m 0644 ${WORKDIR}/tmp.mount ${D}/lib/systemd/system/tmp.mount
> -}

I think we need an empty do_install, or
https://github.com/ilbers/isar/blob/master/meta/classes/dpkg-raw.bbclass#L12
will kick in.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


