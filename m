Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921BC83F1C
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:43:57 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.82])
 by mx.groups.io with SMTP id smtpd.web10.8224.1693205030329550549
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:43:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O6MeFImT;
 spf=pass (domain: siemens.com, ip: 40.107.8.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcwO7fF8uur3habx3PGtVVy7ZaMAR7gYZ/yPF9jmGCcrVLe4VydCtJNHVZfKbQVwwy3iVvBUbgdn2mNkZXvPah6z24KIKcOdZEoDYtPJ6KxHiguIbjQ3AOYNFDkD98x671ahxdilcnca86Pb2nWEaBMKr1Gxu50Ginihtpi0FMVY54ovMEHRT4NSGEaCC8KdEPj6xj2DgYXWEU2TB7JLRiy4Kx3Vl0Gyk4RZD1gl87IUZv/oFOPeEyP2aTgErblbiWRTiEIVp8J/1J7VNmeCsxtG5YUZV5sHCnrshXLCNW1mRy8IHwwkYaWFk11bwoexYi4Y8jN0pEDQNg99SA59jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrZZNolshbLHSpt4Xlb9EJajFhUQZNEpL5GBN5EXhVk=;
 b=SqN6fgHpzC6ZQ9sZnCrpYMvCiFjMMB5pYaxJ+gvR9CftGi9ToJo7ccWkqaRXK3/J2W6C2gnKyilQF2/b01XFGfvhXye3ZXP/C3CYoaPIFcNs/8EP1iOEA1s7zEkNVJw4q+00jQc2HHakiMTzPArOvKvq72Oy9r35v9lL26RET+nQP5BZblC88Gz3YAxHZGb8voZlLnxR299qjFyciYnhFI/3aUMNxe+b1aSJHhQF1WA4MADBNgHqtGCdxmbhk8LLK1K2ooBv66kdsP+LYYmhMP2WsjkrdKZB+RZkFzKfYFIeIuaUopTE+2ed3pGwKNwyFQhCaaKSahGaz6lLnB5tvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrZZNolshbLHSpt4Xlb9EJajFhUQZNEpL5GBN5EXhVk=;
 b=O6MeFImTKWctYOGvWZerGD1yWYmVDQweZocMtApNrYn1M57d+8x915u619LqDesSc7lyKklGtROcrStMEdGTWE8mv0Mt9VLY1XLdkoXDzoV7b+1oBkVETk9JVZOY/V9jAjO2FBUTG7M/3M11r5b+v+EQqyuumvI6bTzyLYzcuj/sr/CL2p4Fkj34f41mgGee07PYg5a5da3rBsOwP39L8SP1Zk2QUeFRRrBTbNAXNeegxz0xVYmoegoBmGd5SjoSBwVxw2KK+bUZelaDrLC8OHD0TyVgGGVqwtJU+9lX01MnG6f5yfrYxAr17JBqW1nO9vwQJzVkoW7GOJRnpV6/Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:43:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:43:46 +0000
Message-ID: <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
Date: Mon, 28 Aug 2023 08:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Masato Minda <minmin@plathome.co.jp>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1d4011-954c-42e8-6208-08dba7922126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LRtMhXQlim37tVspcLBmtW+Lfq+8emcy9tNgJIJg9Ro4lC1FahTsOfN8XMeMQ0DqVqed9LmhagZGOEmUHOsSCgkzsWdMYBamS2KT88Muj0ktfV4cHkuLk9iO9kCPTDEvzhcjYX0csj9Z7BCvB6vqj7k3gt1MvmbjLE593lc9Pex1W88M+NTHui8hebKYJC3qV2BbWvqlqzKCdZEZo7QbeUqnd5nELarKQOU4ITXn7HAjsayYQDBCUhij1SZICOrqagbUDgIr6ReUw6XYTU4/Q6SpJhD8iyHSzsvYxvQZVZGFy6/wMHJywn8sqFSfo57SgmC0h/T1NfHpQ8SEKPtkkSMk1PQvLwKirwvZpWyE8w1A5EG7c1qegdj5OYBxcxb/yIpMGSL0uevDRVRz3Qr+loc1bU9GqOED2SuvryaYeyL6ye8VXuLczsG5Xami6W9+CItMgjh07Murlv8FjrVtCPyirQtcGntrSiCwuvFk2xwFl5E9UX+lB51YfJsspVHzbS1NbTVtpl/8EARAOXRH+l+syWFTJrjyd/g8iDhNg+AnrxllL1+y2DN7vKL2gbxC1bzFCg8g2TJk5W5v9OShcQXbnEH6jGP4kGHa1JN1yFz7/fazgO4Ufk05MxJesUa0FyPVxQAD1rnvSInHU+twQClIorIIEL6SVDQp2bWbuTQltktbA64S7vn1Jo999OwT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2906002)(5660300002)(38100700002)(4326008)(8676002)(8936002)(44832011)(82960400001)(36756003)(31696002)(86362001)(26005)(31686004)(478600001)(6506007)(6486002)(2616005)(6512007)(83380400001)(66946007)(41300700001)(54906003)(66476007)(66556008)(53546011)(6916009)(316002)(151773002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjZmNmZqYjNLWEIzWDJSUmlyOHF1WXl4aG9WcmZjWGJncGxnUW9XWUpqWEdL?=
 =?utf-8?B?UGhYOWF1amIxRERTRUc5TExrQ3FLQWlMVEZsUERHYXNnb09TN1FWTUFkUVBT?=
 =?utf-8?B?aTJTenJwTWFKcHZnTEFBZ3A4aDNhM0xjamNibm92NERWb29MVkE2TVhpcjdS?=
 =?utf-8?B?ZCtobUVKYTErNTlKMHF2RC83QTBmSE9vLzU5UHhaZ3BiNC9lVzlUTkpmTHZi?=
 =?utf-8?B?RkF5U0pRYUVTWlhNUmsyVGJPQnZBY1RFSW9wTkxoOVJRYmJhWXRVam5IQktJ?=
 =?utf-8?B?Z3JlSjJmV0R4MU9lYnI0UjVFRm91eitRQWFrWlZ2YTJKTnJhZzdhL1c3MXRt?=
 =?utf-8?B?SGZBblNDRE00SFlmWFhZTTk1bHloTmxEa0ZoK05CTG5YTVhneDdpMm5BbEVv?=
 =?utf-8?B?K1AzM0t3aHdIbmxJTEVaNHNvT3kzc1FraUk1elRoM2VvN2Y2REoxY2RBL1Fm?=
 =?utf-8?B?MWxmMjlBV1dMR1VDdkh5b0x5NW9hU0hkOG5zVGtMSSswV2NldnlaWkN3M3dY?=
 =?utf-8?B?d0kvZDdVZzJFTUlsQVlNZE10MnBHY3Y5NVRWVlliSU9LcmVmSVFFSlRKY3h2?=
 =?utf-8?B?aHp1VGFwWWcrc2pFS1htU1A2MzMxNkRnVmhzY2FIQ2M3SVhaWmdEazdkWDJJ?=
 =?utf-8?B?Y3paWkZoZzZwc1JFalAwdWxiYXl6MUp3SXRKODlOZFVhSHlxSXEvS2JtSnoz?=
 =?utf-8?B?cDFDV3ZFY0VIdlFhVEE0dFFsZE5nRG9RYlZVV1RmVXk2NmE4QmlpU2d0NDJ1?=
 =?utf-8?B?cERKOUF5ZnFVVXZCUlhLajVRQ1UyRUNUQ1kvMllHZDZlVkRPaWxtNVVGbVhi?=
 =?utf-8?B?ZUxDWFJhTTQzc0VNQ1IvcjRvN3Jhb0JDcG1ZTlhCdld3eHZreWRZakhVRDdJ?=
 =?utf-8?B?UWlXSXRCQnJ0VmEyZk9mdzM3Rk05UDZUWlVwOXpoME0rakM1SUkybWRjL2xw?=
 =?utf-8?B?YU1MQ25acURaRDd1SHNlRG1NaElZUEdsTFZodDdvYnE4ZHhrSlRwMjdZdGpa?=
 =?utf-8?B?OG1EYjBCQ1JjZVAvOTlYSWFHQS8zVnl2NitCOUlpMzlvSXRKWmJORnpmSDRT?=
 =?utf-8?B?NFpkSFdhVEN4U2hxc2JsU3JsdDVzWVhIZFJGa0xDY1Riam9zbkcxeEJaMytj?=
 =?utf-8?B?bHcwQ0xsV1psTlNKdDA1dVN1ekthSGk4YS9LQkliaGF2V3JEMnJYR0tXVGVx?=
 =?utf-8?B?dEIrVkVJVCtpeHYvL3JaMG9EZzVoaVFhTC9TNXlyWXkxWng0Q0E2Zk9VeG92?=
 =?utf-8?B?Ukl1VFNNMG1rK0todENFL2hndktqTWNOR2xCVjJEMkNETFpSQWNkb1dWQTd3?=
 =?utf-8?B?K1IyU1FyVHAwVERXekNkZmVqNlpCYWtESEc1c2JYOW11dkVjSmVQVGNFUExS?=
 =?utf-8?B?Q0hVcFB2ellhOUIrTm91MmNlRmdTeW5uOXFua2Z1akRGcFdOUG84N2tRV2ha?=
 =?utf-8?B?cURIZG1ZOGlPOU9wREY3Vld2dVFvWjRQSU9ESkc5eUwzQm9nZU5PQ1lJNm94?=
 =?utf-8?B?YmNKSS9FdUtoeWt0dHFjSSt5TzIwVGJIZFFGanlYOUdPbmpvZDB2SjZ1Ui96?=
 =?utf-8?B?TFN5bEIxS0poRFROcG9SeVpoMzdKNU90cFRUbU4vaXVvRjlPZjN2eVVhZkp6?=
 =?utf-8?B?VDBwZTFlbTZYVGtzQm56cHEwQkpuOFlJam82K2xlV3VRTEdJaUxhdXJySkZT?=
 =?utf-8?B?WWhWZ0QzSm5DcXlVdWtYZTZzUytOWWZWZmtzbUp6TW5zTncwS0hTR096MEJC?=
 =?utf-8?B?M0xmRnFqS3Z1VVM0UWs3clkwWnloZ0RHckxTZENlVEFVbTBqSWNWaWhxclVH?=
 =?utf-8?B?VUZrVzk4Wkp5dkhxdU9ReERNaEZzSTNBamZqUDVEUDl3NTVLM0NaZUJpVUVt?=
 =?utf-8?B?NWZnVHhzVC9Odi9EWEdDR1B2WFlIQ2lONEZsMXVKV1Y2K29USllqQ1ZMYmlR?=
 =?utf-8?B?Q3ZWSFpBZEFvN25ZeGs0Z3A5UTY2N1pDbFU2b0RHTmgwME9PMkxVcDNBOC9o?=
 =?utf-8?B?ZVFzdm05cWlwcU16VUZzelFPNUMxSUNrVXYrcEZOeHpEN3ptMElubUp5bVIv?=
 =?utf-8?B?cnNhU0ZUOWl0cjluWWJIdTl5c2dZNW1uT05xOTA4cU5ETUx6c3Z2c1VkR3pC?=
 =?utf-8?Q?3+S2rWjSMFBepG94lsD9fc0qJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1d4011-954c-42e8-6208-08dba7922126
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:43:46.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcopMGLXGctZqB5xPz1FcGeEPF3ufNegWETO6MlrdRxkPjRGwXYSd1RYoff1bSRgDUH1JsAhiPpfHNgRCGYfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:43:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12876

On 23.08.23 04:17, Nobuhiro Iwamatsu wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> This adds configuration files to support Plat'Home OpenBlocks IoT VX2.
> 
> CC: Masato Minda <minmin@plathome.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  Kconfig                              |  4 ++++
>  conf/machine/openblocks-iot-vx2.conf | 15 +++++++++++++++
>  kas/board/openblocks-iot-vx2.yml     | 15 +++++++++++++++
>  wic/openblocks-iot-vx2.wks           | 15 +++++++++++++++
>  4 files changed, 49 insertions(+)
>  create mode 100644 conf/machine/openblocks-iot-vx2.conf
>  create mode 100644 kas/board/openblocks-iot-vx2.yml
>  create mode 100644 wic/openblocks-iot-vx2.wks
> 
> diff --git a/Kconfig b/Kconfig
> index ec49631..778acf6 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -67,6 +67,9 @@ config TARGET_QEMU_RISCV64
>  	bool "QEMU RISC-V 64-bit (riscv64)"
>  	select ARCH_RISCV64
>  
> +config TARGET_OBS_IOT_VX2
> +	bool "Plat'Home OpenBlocks IoT VX2"
> +	select ARCH_AMD64
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -79,6 +82,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/openblocks-iot-vx2.yml" if TARGET_OBS_IOT_VX2
>  
>  comment "Kernel options"
>  
> diff --git a/conf/machine/openblocks-iot-vx2.conf b/conf/machine/openblocks-iot-vx2.conf
> new file mode 100644
> index 0000000..a9bf65d
> --- /dev/null
> +++ b/conf/machine/openblocks-iot-vx2.conf
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) TOSHIBA CORPORATION, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "amd64"
> +
> +IMAGE_FSTYPES ?= "wic"
> +IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/plathome_obsvx2_defconfig"
> diff --git a/kas/board/openblocks-iot-vx2.yml b/kas/board/openblocks-iot-vx2.yml
> new file mode 100644
> index 0000000..6951e2e
> --- /dev/null
> +++ b/kas/board/openblocks-iot-vx2.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# TOSHIBA CORPORATION, 2023
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +machine: openblocks-iot-vx2
> diff --git a/wic/openblocks-iot-vx2.wks b/wic/openblocks-iot-vx2.wks
> new file mode 100644
> index 0000000..3050684
> --- /dev/null
> +++ b/wic/openblocks-iot-vx2.wks
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# Based wic/simatic-ipc227e.wks
> +#
> +
> +part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024
> +
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
> +
> +bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"

I wonder if we should (and could) consolidate the x86 configs. Or does
this target come with any specialties?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


