Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EFAC7618A
	for <webhook@archiver.kernel.org>; Sun, 19 Mar 2023 16:22:42 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web10.20453.1679242953375447982
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Mar 2023 09:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xff/e1eB;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBe02WF3cfmuHYsLWj34tAgE6nLAwR8WDg1FYd1Prj0oxyDV73JFf/RZDgQGwkf0Ry2aYfEjSFwpmayLyRG5W8GGnEOVjD32K2trY0vl9uwkca1cj5mT9TJ2vLHBlY+uzLcSCgUJtAlg75EtLK5MonkXDIxoT55gXurr6ifI3TkOEKz0Cp9fBE1BoUDKEk76k6zWszoYgqdyS4a1Dc/+m5QMyPOEUc+X3CQiGmd5s2KBWh/GkWfQk3DcPmebgHyMrdF5npB1Wwz07znW+vc7wHiIWrJ/u3AFYLWujTxvWC62Xmyt7Hm9VjpoKq88K10HWCpBLJ+WmOnHmugUeePdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm9QjYY2eeftmhNvCMk+QozgcHuxSHkUCx07PrUew4I=;
 b=Gx9ugjXGc+OdBVT0pIF+8ZQH58eG3dFputPajLOF83Vg8LwBSapLaZinHWzbAU6LZdjbYp4mHSfpYOsv8iItvZK0DQjsvUB/uswLH1R2bMaaTEMaTkcJekO9M06JZkDC1j6vr90yVtErBQ9LMKDtxNge6cipaOcV03K0Kwg+WkWLZOUL7hDFanWhwovPW23y5zuf8KwSQUxabkQKWLMmoaH19SsP4m8J7NUB0oOX/TfrOPX9rbgTxw4NK0LMb8uNfboUnhlZ0JV6k3muAeJLhVI8rZbRHFkjOFh0nIHwGD0gHGdw31jZNXBspEvh6I+HOgsCYozsyFdgpCnoIp9T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm9QjYY2eeftmhNvCMk+QozgcHuxSHkUCx07PrUew4I=;
 b=Xff/e1eBCWb3tZuvPrgk8AT07ajlAPKog4bY/rkpFKiavuV+J6fKzP33XspogPoRuMT7kam4qdC/w8dofOwOPg1JB9mL1+jX33fEhhg0GwLPxVAcUITodiZgp6ed1tWY+aX93OXmss+Lboug6IShn5VNSY5Ejp/Rr0yA0ZVLTPLo+vlWWcBx33AZuPeeaGICc16+Bw6cP4caW5XytzU9IFuOBUImXOozF3/+ROxw+mWQX6NHDOJ5yL1agbR20ZMmqvPOmtOKiM4S6b2QL04zrbMm/nQ9TjuIC+iSo/RlIJDA04fJxwSasDl4kVrzQtR/L/bmoIGWkYeLPPKbOL9xOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Sun, 19 Mar
 2023 16:22:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Sun, 19 Mar 2023
 16:22:17 +0000
Message-ID: <645e9796-a99a-c1cb-827c-ced3654be828@siemens.com>
Date: Sun, 19 Mar 2023 17:22:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-crypt-hook: Add
 clevis for buster and bullseye
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230317083737.14025-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230317083737.14025-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3c3032-f5bd-4c8e-576c-08db28961b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HWNN9OPeX3grYc8fxBbDD0u7TO2JuwY0LD7y44Hofb4fjtsSF+l1Er33CjIH+Vzbo+TBjwF7Fr9QOiPc8w+m68DZcDGcG+/hovqZcDp3w7wEXGgpOnWV/XlM5K0Qd6ebFlTI8biSIE2jfxJ0OrM3gvJnK8Zchl5ZDtGyDR5Rwd6Wy9KRDcbokE+j2isA6piCoCf9LBdjwY8GJ1qLwas5kbnBas5YW1QQHDy21qiEOj0BXMrq2iTEwWwlndf/mbWteqUoigQkccNnextx90/L8c2qwMtElptpL19F0K71LnYfm5A0Mrq5XWPHvEUU0GRyi+2s9CYcgczgAJ0XFbAAVvFiVJV+lfUpxodkpSaJlTpgQ7tv/Re6ILRu4c3M0kS6zPVSO2OC20J9vTTAqKmVQjHmijSHJXJcb3S0fAMWKAcU8BFyDCm+8ULugfequCvubonS+MGkJAB93yK4d3u6DF3weu3ZSgiRnX+x4OCZTMtTuvXXu1yPkzYMFnMuBOmNqvuh2Y5KfziScaIWDiDzeLHAMyFXHNBxhNayQsIjhc4dhlPYQDTsuxkALcEbp+/GZ+Ig3AbzZlMOc2xakdO4HXq+oIG4V9MAo8cVIq5zxP7BXBPm60yrfH+my0VpaiVk2zI4Rugg6VoXIm2QZTozdJ5RYV7QShV8U878CllMqVA1TqM6zMic68WzNsvY3zRg3PTGFFS18sgqOzeLre/pMn7a1LCnGk59go+Ip1oLj1BYzUTwjNFJXaAsX0jWf6VM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199018)(82960400001)(6486002)(31686004)(478600001)(316002)(2906002)(8676002)(2616005)(44832011)(30864003)(36756003)(83380400001)(8936002)(31696002)(66556008)(53546011)(66476007)(66946007)(26005)(38100700002)(86362001)(186003)(5660300002)(6512007)(6506007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anloeTNZbEE3cklEdC90YjluWWpRTVhQKzJqRW9vQ01xSXR3a1dLWm5hYWVw?=
 =?utf-8?B?dUVpNkw1UlBpTklkK1F2Y0N1QXE1VDVCdkorV3FISXdRdElFT3FvQmNKdm50?=
 =?utf-8?B?bGpxbTRxWnhyQWhzWTVmT29rU2NDclpVNFkrMUFiY1dMTFpzTmd0RFlyOHdF?=
 =?utf-8?B?RW1TUFJNeDRiWU1JeC9aMTZibDF0WkgyYjl1bW5yTVc2YUxpNnNYOUVxZFNM?=
 =?utf-8?B?Sk9iL0pJV2ZUNndVL1dOcUx4ckpwMWwvNzhUTXpKRWc3cnRlUU9tV1BIaEtF?=
 =?utf-8?B?VktkaWwwNlVMQ0xJRVNjTHNtUDB5WFlsc0JTekJqQm1qTEJ5dU5SY2dSaHRn?=
 =?utf-8?B?YXM0UDBWT1pXVlBndUpqSjFPcGtnMjA0YTdNbVh4cmVYUERzL0RwYTZmTzE3?=
 =?utf-8?B?Y0FUK1lYZEptWHRtekoydEtZOUNvYnkyR2lWR3g2VUJNVG5mTUhObmYzbUtz?=
 =?utf-8?B?TzFIY2xwNk9Sc295NXI0RldqT1IzWlRqQXg4c2xHdUVMVEgrS2ZGMFdTbXQ1?=
 =?utf-8?B?L0VYY05NampOTEVYM3VqZkxma3lZOFZpY2ZmM1drM09WNEhJdnZJZ0ppUEMr?=
 =?utf-8?B?T09jdnR2d2VFKzFVM2diNW9LenhZTzF3NUpjOWowQVhyUVBUdE5WOXJnWWVj?=
 =?utf-8?B?U1lXMnBUeXVGM3dZVEtWbExKYU1NdFd2UHBOTUlFT0U0akdVZFl4UU1XZ21V?=
 =?utf-8?B?SjJRSWJWS0UyTTJteXpxdXAxNkR5bHcxRkFDbEk2cDVTRWx2QUc4OXpQYndD?=
 =?utf-8?B?WnBtaGhmZUdrMGw3QWVMRkY4VXROOEhDVFkrL3Nvd0krQzBuSy9VZFNRMUto?=
 =?utf-8?B?TUtQUWZKcS9JbC85bTM4SVJIWUd6ZUJObEVjOHljNW84L2k2YWdrWVJtOVgw?=
 =?utf-8?B?WXo5U3NLWDJTdnY2ajJuemp4cDFSWHJpRFU3Z3NJU2Fob2pwNmp5bWF1Z2do?=
 =?utf-8?B?aE9FQjFqcmh4UTNxQnZ0WXAvWVlQQkZxYTlIc3RPWTh0b3BrYTd6OWVWSkRh?=
 =?utf-8?B?N0dET2tBMlkrUEVxYytuWGxGcFludjIrNjU3bDEwcUZNQng4Z1pTcHBpUjJi?=
 =?utf-8?B?cGR2OHV5WVoreVF3RmluTmFlTWtTcTJlcnRzbnNZQklacGhGOGRnVWdwTG9a?=
 =?utf-8?B?NTNkK0dzdWVVaXpFUWFITGxkWE5tVG43dWZ5WXh1ZFJrWS9FU1k5NGt4cTVE?=
 =?utf-8?B?UTIwRlY3RHFzRitCNFM0SDN6eUZjWHQzYlIwWmlOMldOWDdqR01kcUI1VUk3?=
 =?utf-8?B?cDdQazcvdFpMVGN0bm5IRm9vcVBvZ2gxYjFPYzNBRlFpU1lwRzIyUkJoWVJh?=
 =?utf-8?B?WUNicjY4TDhVcDM2S2dRek1RejZTNkg2WHd2YnhLZm84bmVIMjNPM2RudlFr?=
 =?utf-8?B?ZU5MeTFvdGF6RjAybnkrVXRNMnBRTklwakl0NHRzNUt6Nk1kN09XMUJjM2lD?=
 =?utf-8?B?Qk9oODE4N1ZOSnpyQ2dPOFZvVHJvYkJOSDAycXB1alB1eUxnMFZxMS9IcHdu?=
 =?utf-8?B?TlFHUVMrRlhoNEdVbndCMkNoa2EzQXBjZFNVUTgxMVRWUVV4ODExaE5kbWpP?=
 =?utf-8?B?a2tDcEVUc2x3Y0REZVVCVjZTZGZWeDFpcGxZTzJLb3hyM1ZkQWNlcEZNUHc2?=
 =?utf-8?B?eGdtdW1Vc1NYVHI0MngzWUI2S2RKNUVkVkw3a3VuT0s5NnhVa0x4ZXZCbnRL?=
 =?utf-8?B?N3podFFwQ2lwRjRlSEw3UEhMRTVFcG1yL3BNRjh1TVlMNFNFT3dyWmtMWENS?=
 =?utf-8?B?bTlxeXNUYTFXMEQ4RDdyTTNFaWZuNkdpOVJSYlJtdmNIVFk1cEprUW81bU1E?=
 =?utf-8?B?Tmh3OVBSWDdxOThsdGErRFgwVURxdWFFZDJSZnFLUFpNcWhGZjVzVGFHQ1l6?=
 =?utf-8?B?UjNEVnlvQjlSYnpxS3hqRnZra2xoTUN4aVNjWldzRDU4QWdRTWhsVzg2aHRl?=
 =?utf-8?B?aVdUUnRHY2hCZUJwZ3dHd1BjTjVNUlJHd0tBTkcydkhsdUdJNUk0N1RMcklr?=
 =?utf-8?B?Uk0wWTNWWXJnbjliWDdlaG9KeXpLaWQ3WnhDaWZZcWF6RWZ3Umo1dUx1alhR?=
 =?utf-8?B?MlBZTFZQVWwvRFFJK3hPWHBjVFpTNzloT3VBaXhXK3RPMGE4VDNsamhseGNT?=
 =?utf-8?B?ZXdoZWU4bkoxUzRkVTZnUzZDZWNKMnUzQ3p5LzdqZ1ZJZHAwWVNNb2QzVHNB?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3c3032-f5bd-4c8e-576c-08db28961b8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 16:22:17.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otJ6gu3Gzuo6fqEm6H6Ya+qJ/rVKx9EfdrvF2vyW0vXhrTtzucDrYe+br9unkaG02l2wzzCClkd6cCWUkYNUxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3873
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 19 Mar 2023 16:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11035

On 17.03.23 09:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This will remove the requirement to use bullseye backports.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - fix whitespaces
>  - remove set -x for debugging
>  - add comment to explain settings in pwquality.conf
>  - cleanup dependencies
>  - make system the future default backend 
> 
>  .../preferences.bullseye-backports.tpm.conf   |   8 -
>  doc/README.tpm2.encryption.md                 |   7 +-
>  kas/opt/encrypt-partitions.yml                |   3 -
>  .../files/encrypt_partition.clevis.hook       |  79 ++++++++++
>  .../files/encrypt_partition.clevis.script     | 138 ++++++++++++++++++
>  ...on.hook => encrypt_partition.systemd.hook} |   0
>  ...cript => encrypt_partition.systemd.script} |   0
>  .../initramfs-crypt-hook/files/pwquality.conf |   3 +
>  .../initramfs-crypt-hook_0.1.bb               |  28 +++-
>  9 files changed, 242 insertions(+), 24 deletions(-)
>  delete mode 100644 conf/distro/preferences.bullseye-backports.tpm.conf
>  create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
>  rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.hook => encrypt_partition.systemd.hook} (100%)
>  mode change 100644 => 100755
>  rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.script => encrypt_partition.systemd.script} (100%)
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> 
> diff --git a/conf/distro/preferences.bullseye-backports.tpm.conf b/conf/distro/preferences.bullseye-backports.tpm.conf
> deleted file mode 100644
> index 60c4265..0000000
> --- a/conf/distro/preferences.bullseye-backports.tpm.conf
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -Package: *
> -Pin: release n=bullseye-backports
> -Pin-Priority: -1
> -
> -Explanation: Use systemd and its dependencies from debian-backports to support systemd-cryptenroll
> -Package: libnss-myhostname libnss-mymachines libnss-resolve libnss-systemd libpam-systemd libudev* libsystemd* systemd systemd-* udev
> -Pin: release n=bullseye-backports
> -Pin-Priority: 801
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 7914bf3..0df7f39 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -6,10 +6,6 @@ passphrase on the device.
>  
>  ## Requirements
>  
> -To enroll the keys Debian 12(bookworm) or Debian 11(bullseye) with backports is required.
> -The implementation in Debian 11 is for *demonstration purpose only* as we need backports for
> -systemd >= 248. [systemd version 248](https://github.com/systemd/systemd/blob/a41ac8ac407a1a58612059a45229f0d440f58e28/NEWS#L3391) adds the necessary systemd-cryptenroll functionality.
> -
>  Testing with qemu-amd64 requires the package `swtpm`. Under Debian/Ubuntu this can be installed
>  
>  ``` shell
> @@ -18,7 +14,8 @@ apt-get install swtpm
>  
>  ## TPM2 protected LUKS passphrase
>  
> -The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` to enroll a TPM2 protected LUKS passphrase.
> +The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` (Debian 12 and later)
> +or `clevis` (Debian 10 and Debian 11) to enroll a TPM2 protected LUKS passphrase.
>  The procedure for storing a key is described in [systemd/src/shared/tpm2-util.c](https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395).
>  
>  ## How to build an QEMU image with TPM encryption
> diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-partitions.yml
> index 418e753..2fe38f8 100644
> --- a/kas/opt/encrypt-partitions.yml
> +++ b/kas/opt/encrypt-partitions.yml
> @@ -13,8 +13,5 @@ header:
>    version: 12
>  
>  local_conf_header:
> -  systemd-cryptenroll: |
> -    DISTRO_APT_SOURCES:append:bullseye = " conf/distro/debian-bullseye-backports.list"
> -    DISTRO_APT_PREFERENCES:append:bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
>    initramfs-option-encrypt-partitions: |
>      OVERRIDES .= ":encrypt-partitions"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> new file mode 100755
> index 0000000..07c9d96
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +# Copyright (C) Siemens AG, 2020-2022
> +#
> +# SPDX-License-Identifier: MIT
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +     echo "$PREREQ"
> +}
> +
> +case $1 in
> +prereqs)
> +     prereqs
> +     exit 0
> +     ;;
> +esac
> +
> +. /usr/share/initramfs-tools/hook-functions
> +
> +hook_error() {
> +    echo "(ERROR): $2" >&2
> +    exit 1
> +}
> +
> +manual_add_modules tpm
> +manual_add_modules tpm_tis_core
> +manual_add_modules tpm_tis
> +manual_add_modules tpm_crb
> +manual_add_modules dm_mod
> +manual_add_modules dm_crypt
> +
> +copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> +copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
> +copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/bin/clevis || hook_error "/usr/bin/clevis not found"
> +copy_exec /usr/bin/clevis-decrypt || hook_error "/usr/bin/clevis-decrypt not found"
> +copy_exec /usr/bin/clevis-encrypt-tpm2 || hook_error "/usr/bin/clevis-encrypt-tpm2 not found"
> +copy_exec /usr/bin/clevis-decrypt-tpm2 || hook_error "/usr/bin/clevis-decrypt-tpm2 not found"
> +copy_exec /usr/bin/clevis-luks-bind || hook_error "/usr/bin/clevis-luks-bind not found"
> +copy_exec /usr/bin/clevis-luks-unlock || hook_error "/usr/bin/clevis-luks-unlock not found"
> +copy_exec /usr/bin/clevis-luks-list || hook_error "/usr/bin/clevis-luks-list not found"
> +copy_exec /usr/bin/clevis-luks-common-functions || hook_error "/usr/bin/clevis-luks-common-functions not found"
> +copy_exec /usr/bin/tpm2_createprimary || hook_error "Unable to copy /usr/bin/tpm2_createprimary" 
> +copy_exec /usr/bin/tpm2_unseal || hook_error "Unable to copy /usr/bin/tpm2_unseal"
> +copy_exec /usr/bin/tpm2_create || hook_error "Unable to copy /usr/bin/tpm2_create"
> +copy_exec /usr/bin/tpm2_load || hook_error "Unable to copy /usr/bin/tpm2_load"
> +copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> +copy_exec /usr/bin/tpm2_createpolicy || hook_error "Unable to copy /usr/bin/tpm2_createpolicy"
> +copy_exec /usr/bin/tpm2_flushcontext || hook_error "Unable to copy /usr/bin/tpm2_flushcontext"
> +copy_exec /usr/bin/bash || hook_error "Unable to copy /usr/bin/bash"
> +copy_exec /usr/bin/luksmeta || hook_error "Unable to copy /usr/bin/luksmeta"
> +copy_exec /usr/bin/jose || hook_error "Unable to copy /usr/bin/jose"
> +copy_exec /usr/bin/sed || hook_error "Unable to copy /usr/bin/sed"
> +copy_exec /usr/bin/tail || hook_error "Unable to copy /usr/bin/tail"
> +copy_exec /usr/bin/sort || hook_error "Unable to copy /usr/bin/sort"
> +copy_exec /usr/bin/rm || hook_error "Unable to copy /usr/bin/rm"
> +copy_exec /usr/bin/mktemp || hook_error "Unable to copy /usr/bin/mktemp"
> +copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
> +copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
> +copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
> +copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
> +
> +if [ -x cryptsetup-reencrypt ]; then
> +    copy_exec /usr/sbin/cryptsetup-reencrypt
> +fi
> +
> +for _LIBRARY in /usr/lib/*/libtss2*; do
> +    copy_exec "$_LIBRARY"
> +done
> +
> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
> +copy_file pwmake-config /usr/share/encrypt_partition/pwquality.conf /etc/security/pwquality.conf
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> new file mode 100644
> index 0000000..37bb024
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -0,0 +1,138 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +prereqs()
> +{
> +	# Make sure that this script is run last in local-top
> +	local req
> +	for req in "${0%/*}"/*; do
> +		script="${req##*/}"
> +		if [ "$script" != "${0##*/}" ]; then
> +			printf '%s\n' "$script"
> +		fi
> +	done
> +}
> +case $1 in
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
> +# load necessary kernel modules:
> +modprobe tpm_tis
> +modprobe tpm_crb
> +
> +# fixed tpm device or do we need to find it
> +tpm_device=/dev/tpmrm0
> +partition_sets="$PARTITIONS"
> +create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> +
> +if [ -z "${create_file_system_cmd}" ];then
> +	create_file_system_cmd="mke2fs -t ext4"
> +fi
> +
> +open_tpm2_partition() {
> +	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
> +		 -d "$1"; then
> +		panic "Can't decrypt '$1' !"
> +	fi
> +}
> +
> +enroll_tpm2_token() {
> +	if [ -x /usr/bin/clevis ]; then
> +		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
> +	else
> +		panic "clevis not available cannot enroll tpm2 key!"
> +	fi
> +}
> +
> +reencrypt_existing_partition() {
> +	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
> +	# reduce the filesystem and partition by 32M to fit the LUKS header
> +	reduce_device_size=32768
> +	reduced_size="$(expr "$part_size_blocks" - 65536 )"
> +	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
> +	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	resize2fs "$1" "${reduced_size_in_kb}"
> +	if [ -x cryptsetup-reencrypt ]; then
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +	else
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +	fi
> +
> +}
> +
> +if [ ! -e "$tpm_device" ]; then
> +	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +fi
> +
> +# clevis needs /dev/fd create it in the initramfs
> +if [ ! -e /dev/fd ]; then
> +	ln -s /proc/self/fd /dev/fd
> +fi
> +
> +for partition_set in $partition_sets; do
> +	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
> +	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
> +	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
> +	partition=/dev/disk/by-partlabel/$partition_label
> +	crypt_mount_name="encrypted_$partition_label"
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
> +	# clevis does not work with links in /dev/disk*
> +	part_device=$(readlink -f "$partition")
> +
> +	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
> +			| grep -q "clevis"; then
> +		open_tpm2_partition "$part_device"
> +		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
> +			 "${rootmnt}${partition_mountpoint}"; then
> +			panic "Can't mount encrypted partition '${decrypted_part}'!"
> +		fi
> +		continue
> +	fi
> +
> +	# create random password for initial encryption
> +	# this will be dropped after reboot
> +	tmp_key=/tmp/"$partition_label-lukskey"
> +	openssl rand -base64 32 > "$tmp_key"
> +
> +	case "${partition_format}" in
> +		"reencrypt")
> +			reencrypt_existing_partition "$part_device" "$tmp_key"
> +			enroll_tpm2_token "$part_device" "$tmp_key"
> +			open_tpm2_partition "$part_device"
> +		;;
> +		"format")
> +			/usr/sbin/cryptsetup luksFormat --batch-mode \
> +				 --type luks2 "$partition" < "$tmp_key"
> +			enroll_tpm2_token "$part_device" "$tmp_key"
> +			open_tpm2_partition_tpm2_partition "$part_device"
> +			eval "${create_file_system_cmd} ${decrypted_part}"
> +		;;
> +		*)
> +			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
> +		 ;;
> +	esac
> +
> +	if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
> +		 "${rootmnt}${partition_mountpoint}"; then
> +		panic "Can't mount encrypted partition '${decrypted_part}'!"
> +	fi
> +
> +	# delete initial key
> +	# afterwards no new keys can be enrolled
> +	cryptsetup -v luksKillSlot -q  "$part_device" 0
> +done
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> old mode 100644
> new mode 100755
> similarity index 100%
> rename from recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
> rename to recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> similarity index 100%
> rename from recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> rename to recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> new file mode 100644
> index 0000000..d4c8981
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> @@ -0,0 +1,3 @@
> +# we don't have a dictionary in the initramfs
> +# this solves the error "Password generation failed - required entropy too low for settings"
> +dictcheck = 0
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index c5b2268..f1ff404 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -9,13 +9,23 @@
>  # SPDX-License-Identifier: MIT
>  
>  inherit dpkg-raw
> -
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
> +DEBIAN_DEPENDS = "initramfs-tools, cryptsetup,  \
>      awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
>  
> -SRC_URI += "file://encrypt_partition.hook \
> -            file://encrypt_partition.script \
> -            file://encrypt_partition.env.tmpl"
> +CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
> +
> +DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}"
> +DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
> +DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
> +
> +CRYPT_BACKEND:buster = "clevis"
> +CRYPT_BACKEND:bullseye = "clevis"
> +CRYPT_BACKEND = "systemd"
> +
> +SRC_URI += "file://encrypt_partition.env.tmpl \
> +            file://encrypt_partition.${CRYPT_BACKEND}.script \
> +            file://encrypt_partition.${CRYPT_BACKEND}.hook \
> +            file://pwquality.conf"
>  
>  # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
>  CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
> @@ -29,11 +39,13 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  do_install[cleandirs] += " \
>      ${D}/usr/share/initramfs-tools/hooks \
>      ${D}/usr/share/encrypt_partition \
> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
> +    ${D}/usr/lib/encrypt_partition"
>  do_install() {
>      install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
> -    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
> +    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
> -    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
> +    install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
>          "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
> +    install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
>  }

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


