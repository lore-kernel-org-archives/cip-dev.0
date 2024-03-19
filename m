Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA836C54E68
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:42:11 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.87])
 by mx.groups.io with SMTP id smtpd.web11.24088.1710873726580161006
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kc0HkRpQ;
 spf=pass (domain: siemens.com, ip: 40.107.6.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2S+VYmW1USo9eChZgwfKnt4JjakgMQ2U48XOGHx675DD8+6w+SMfK0kh0/3gRqW52Ios1MgxHc8C4bvQnAisvOghErt1HV2+Ath3Bed3FBybbX1qlr98WbGAzD5CkmarelQW/LSK5SVDQU00JL+wsK2l5q6ylLKOM7+ZYhApfCbWjbRJ36XfwGUTh2l0a5gtfUJWgqdRflIGZCEU0ssiXwvazHKRrFk4j7p42irRJ+Cbyeh3n3R4DuhQmaXmj7Zj466TsFLX9PrCk5+XM33ki8sSeoZL3FXuHJzmTisvJQ79zDF+evqV4G5VYhFH+oeZk5ou44ClURlijz/4DaTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RDHvNsA4SGdyELi13TPS4oGfCbOuu4QMZ1kDfisf/Q=;
 b=CVkZUKayOBrOQmjcUIvCF3tjFpeha//QxzhqAB/1bbjYW7MOXHv54lsJ48xQ3tB6UdnBvDzDhjV4FgovvnI0EoAjJChadU6q7dDcEYelioFbKxPqCLZwWJs/ictVmrbQrQEjjquouOZsk8PJ54R2P4YegOR/+/MNSYEUAnrLXtKbWCl/H7fx7n3VStL6eS9Rxn/BEb6ets11LNacTMmDsjCEnzae10RB8RGil5kq/Ke2bgcgE+88PHqOT35zt4jG87A2nx1Z51IQmTJc0J/ynxdCI7SuXWrKnVFxKF0I9/nyi4jqU+ACiOKK56WYaBi7+EpZ/hoZe3dSqu/NMR0kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RDHvNsA4SGdyELi13TPS4oGfCbOuu4QMZ1kDfisf/Q=;
 b=kc0HkRpQJWfmS3MK+MpJ+gnPyX7hdw2hkXDUsLLGdfyCk5H8tHsvdVvjp/0Fi7A9gwsED8cAFbkSjP2QXOp2VOI4EpXRakHQMeCiq06fn57+TKLb888ty79xFCK0da6cpby53QvohlrexY1lfao8RmYEpwmScNuYX6ZImSwdkMSag8fW+FHFfhbMsX6dzsZtJSy2Ik/V3x+K5/zQmiwiNTfVfZ2vQpya6tTwcmxJDXKplIU81saVl+dsMQeIes5JmPs6X+cWbZx0PtifObKizQ0JdJFpnbBtrYrj2GPwExCzIwA3uDTDDcwhiUIhlmEG2sOHE/bFG+ZFKO4MrF1ufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 18:42:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:42:03 +0000
Message-ID: <09154543-a923-4dfc-a6c0-0920da9bf45b@siemens.com>
Date: Tue, 19 Mar 2024 19:42:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 8/8] Add example to encrypt the
 rootfs
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-9-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240319182026.1571362-9-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8d00fe-9a1b-40be-9881-08dc484444d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s5IRv32sMM2VXi9xVblGQyW9Md6t5b2Wx3K/Th+YIMY7yKT2oayxD9+2E43SVsMMtda4KYHWiuBz2Ruzzs37otf/jUZgshNyj3auy8lKsDeBgKFBlrM8I6UXVHSYx6p5BwuSOBaSCrIWPEjM3lSalyql/dSRCLk/iLZyqYQ8c9UIlS3PvK2UG6RA58dv9zX51CnCKCTqhRvTIyg7jKADeZXybWhygFgjPB9Z0OBRcoiGaw0GFz2j2sg8sDM411+mT6jfQ/p7RkpVLmooe34HF5izH8YlrGnoJA/Hqa67GyvJ7l7trpvrW/Cm8xrZTZHP5fl4z/UT+fvfPbjg1Hu3bGHe9MNK5Q2AkmaPGfH6UsHIsnIt+Zj/Hbh+RMF/zgN16bm1LvjwwlonA9QRt9CBZqj4S/FS33r4m7BE5dz6H6ZBolsRnhxHMnS7SN/eSWeemK43Lig7JjUZiVMl35L7t3/COkl8LNoeqtbf+O8IIAZU9dwZKWV7xwBhwTczkH6oTo5vHZhKa1pcwm0qXrbxwtqQcOWFux05FK9ZAVnExRByAt2C6JzcnraKLnjgmrneYZ7Qep6sBR3iO96svvH1/GsT0cd9/PyaO4nm36nES8l4xav0XlCaObKUeKmhYHLNPqsUR5w2gl6RmhCGU19Z1GXcvdAtsUX8ePW6oz1OkGA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1NsS05pVW4xcVVXVzBPUTgyM2ZQby9qRUJPbjJ1Y0gyK3N2OFVFZExOV1VK?=
 =?utf-8?B?bEI0NlN2bmNJZUIyMUtUYWFHQllHNWVzT0h3bVV5aXl4VnY0bENvMFlwRUdr?=
 =?utf-8?B?TzhKa3FwTlZBL2ZDTnNHd0R6MnB4WEUyUmpwRHdSRC9xWlZSdmRNL1NscTkz?=
 =?utf-8?B?UGgzRVk2ZWY5RDhkQlB3MDJocU5lWlNwN2tsT2dRb3c5VHRYZVFWQ2ZWSFdK?=
 =?utf-8?B?UnR2K3N6bFM4dWhxMDlDVlBXQytZM3NwQ3BQTUVuYXpERkZGcHJpbW53Yi9S?=
 =?utf-8?B?azRLeVdTUS9sWHl3L2FzbWtPazRGMGJsemJRTGhUVmp5R3BVaUNhUzE1T3RG?=
 =?utf-8?B?VmdXQkVaNUxGekVveDBwNkU5ZXZIQXJNcWpUaU02b2xQOHFjTW96NzZXMVJN?=
 =?utf-8?B?dkllRzF3ZXpEakNyR00rTkxMTFprWXlFeXdRU3A3Um51UVpFTU5RRnpmVTJw?=
 =?utf-8?B?OWdRMUJqY3NmcEZQVjlhNzRlek9sbVBpZkhtYWVnNVVjTStKT2t2bXE4VEVR?=
 =?utf-8?B?S1h5bitBRUFWY0V2TlNXemRJdGVmUS9mVi9lbndFUmRzNmtLb3kzS3pxcVYw?=
 =?utf-8?B?R251MkxXZGh1ZkgrU1NuSE1zNzBpWDRrM3ZJeXVjR0dkSzdBR2RwM2ttUEJr?=
 =?utf-8?B?VkJnc3YvcVhyU2dwam5xRHcrSlBXaXQ1cnZGNWwrNGxPYkQvVTZEWFRYb2JX?=
 =?utf-8?B?Titsa1RZc2piR2pNaFNFKzZhajlhekJXVGg1c05ZTDY4cmRVL1JpQm9KR1lv?=
 =?utf-8?B?UWVOblJmbXU0UWN3bVhTR1M5ZGZacU5PZG9QaFNvTERYL0ZEelp3U04wa2ZY?=
 =?utf-8?B?MDF0K2w1LzczbWpRcTVHWVAzZ1JYVG83MDJnd3Z5QzJFZGNmQXVZMmVsUDRQ?=
 =?utf-8?B?a05CMTYrWlhHbWRrTE5vdjNMa2laU1FBUU44RlF5aXh1VVowSjEzUGRHRWpV?=
 =?utf-8?B?allIYW0wSkdtZnpabzlhTGtjYVo5bHo0dVlsd0NCRmJYVzNoK0VyNDRIYlBI?=
 =?utf-8?B?cDJvMjB2Qk4zRVJ3RURSZjg4REZJVTB5VEFIa3RiYm14ZFlCMzB3Mmd5WitX?=
 =?utf-8?B?RytyQWJJZUgrRk44MHdXVmRBU2hjaWdSbjRZNnlWTk1WdW5rd3daM3RnQUJX?=
 =?utf-8?B?cHU5TlVqQVg0ZXkzQ3owdndRdzcwcmhaTmd6dnZXSG5rSmEveTgxaks3RkN3?=
 =?utf-8?B?eFlORlcyNWVBcUk5WVJjRTYvTmtCREw4b3g0YmZuUDRBT1E3WUxjckpnQnZL?=
 =?utf-8?B?MnNMRExHZ3B6MUJKcEdJUEMxSFBjSzVJVmVMR295QmhnR2QxQi82aGhRcHV4?=
 =?utf-8?B?enE2TG8vVkdPVzdiMEZDYVJ5b0g1Q1ZES09mY1I1VTEwWUd0K0NYa2tQTnlE?=
 =?utf-8?B?Z1lrcVdyYUFhTUJBbDVSUEtCZDExQmRBQ0NYNFc0ZFFrOERLNHRLbHRxSndB?=
 =?utf-8?B?YWJ5ZytBU1FvcU9HWXhlYUU0RGJBRFpYL0JBUUFqUzIrd1hFayt1QXFOOHpM?=
 =?utf-8?B?L09lam5tSE9URTVUMlZ6b0tpeUtmV1RyVTh1ODVydkp5V0pBaHFWdDFqQmdI?=
 =?utf-8?B?ZFNoWVhOMHkxNStabC9Qc3BVbkNqMzZuV1dnUkRNZ2hEZDUvcmpXSHB0QlhC?=
 =?utf-8?B?WVJ1bngvQ3lKM1dCL0JVdUQ4bEZ5UjdpWEJzVVVjVVlBYmcrWWhueHNtcUEx?=
 =?utf-8?B?Wjdtakd3VXMwSjd0TXZFUVIyUG5SRzJhT2xCTy9pelRkQVYzcEZxVzBJLzNl?=
 =?utf-8?B?WFRMZ0pFMXZuZDZHSVJ6NHV4K0FjRXcwWlRzWHZUY0ozdnFFbWcxaWdrYkdM?=
 =?utf-8?B?R2YzV0VRQVo4SXAzd3F5ZFhpWGtsZ1N5UU5MVEU5K2h3dm9ERmFJKzgyRGlF?=
 =?utf-8?B?VUlCZ2t6aXZwN3FnMmwyalcySU5nQUlaT3NWbWpMN3orbWgwc3dwYzZkU2tr?=
 =?utf-8?B?eDErVHFUK0FQaWxKSTdmKzhWelR4Vmg2ZFVCR083QjV4ZVEvaXl2SFlnTXov?=
 =?utf-8?B?aXYyZFlEK3NUU0JJTGJMRndGNitaNFUxNjE4bGFNN3NnZkQyS205RlA3ZTRw?=
 =?utf-8?B?a2w2S3ZsUjhZM2Z1cEJaMjRVRU5ESE5xSGc5MGY4SCtNU2pZaWk1YURJUWd5?=
 =?utf-8?B?cEhvcWFWTVVob3k2NjFkRmgvN0VUMUNHWCticVpnWTAxR3kvelVXVnIyQ2tK?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8d00fe-9a1b-40be-9881-08dc484444d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:42:03.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw7lvfjYkg29oCEg1sC6TVULJmKeOwxNRl0f770UOeg6+xqPtygSDty/7XOmRbiGeWzuNvi2PVp+kDCcKs3DYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:42:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15378

On 19.03.24 19:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> This is a rough example to show that rootfs encryption is possible.
> 
>  kas/opt/encrypt_rootfs.yml   | 24 ++++++++++++++++++++++++
>  wic/x86_64-encryption.wks.in | 18 ++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 kas/opt/encrypt_rootfs.yml
>  create mode 100644 wic/x86_64-encryption.wks.in
> 
> diff --git a/kas/opt/encrypt_rootfs.yml b/kas/opt/encrypt_rootfs.yml
> new file mode 100644
> index 0000000..4001c75
> --- /dev/null
> +++ b/kas/opt/encrypt_rootfs.yml
> @@ -0,0 +1,24 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  encrypted_root: |
> +    WKS_FILE = "x86_64-encryption.wks.in"
> +    CRYPT_PARTITIONS = "platform:/:reencrypt home:/home:reencrypt var:/var:reencrypt"
> +    IMAGE_FSTYPES = "wic"
> +    IMAGER_INSTALL:wic += "systemd-boot"
> +    CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
> +    INITRAMFS_RECIPE ?= "cip-core-initramfs"
> +    INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
> +    do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
> diff --git a/wic/x86_64-encryption.wks.in b/wic/x86_64-encryption.wks.in
> new file mode 100644
> index 0000000..c143500
> --- /dev/null
> +++ b/wic/x86_64-encryption.wks.in
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,initrd=${INITRD_IMAGE}" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
> +
> +# Not nice use the source param label to supress the root commandline

"suppress"

Can you elaborate what will happen without this label? Another, wrong
"root=..." would be appended?

> +part / --source rootfs --fstype ext4 --sourceparams "label=BOOT" --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
> +# home and var are extra partitions
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +
> +# This works as we know how that the luks device will be named encrypted_<label of the root device>

A bit ugly, indeed. Is there no way to let the script set the
appropriate root?

> +bootloader --ptable gpt --timeout 2 --append "root=/dev/mapper/encrypted_platform console=ttyS0,115200"
Jan

-- 
Siemens AG, Technology
Linux Expert Center


