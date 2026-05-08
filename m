Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FDFCD342F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 05:29:16 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7000.1778218145824255841
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 22:29:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZxO8TDIG;
 spf=pass (domain: siemens.com, ip: 52.101.70.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVtToTuS1fElY52p5k1IRwkmJgXcps1gDvEcB7RdEGPPvUVrfahXiUlAQImQXjROmViEiQV5GYNNjKVLacDTDVQIt7lJqh01aorU1kszoqz/Vr1YJHkE8i8bOAaBBjJuNXGHKdkZNrPby9VZUdn6V38vBFBX8PWgUhL1lMm+prZssz0yRDpTb+aRpVcIzDJbQnp2GxUYu10o4Z7K3uHVQuTkGtd/lZv/c7kSErtJDqrgTmOEQQiwai/GDygl/frZISlJG5xG06hSQsVa4bnOadTI3WPSRNzvlhJZiYytwoYx2Gf0pcL4BT5/LM8wG9ZDClqfWWKhNJZ5hqG/PIGQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7oNrnmH5CCX+aWPiu8qfdvtWnK/1taTXKzeGmefwO4=;
 b=C7lJBLiqVO2puEiAskZtU0a7m3yvnM3mAN26clxtHwAGkww6gmNjDxAZfQ5XCEwCHW57Ii88nEGUGaMWoQZ3OloNcfe4vc3gggUyOgdtuDbHgDC7M5mBoikdV6qwaRVZtXlWX4O5XtZINN7ftzOZMpsUB/GkjYo/dQJ+/r0opDD1MkZRo/zYF8Ky+QwaiV9ugA71/F2Uy/cr2kQhZDL7606CY+oIiINXNVoM6XLhmjhgam2z9nPARrew8Nqyjrk4q5jzpiOS79ppn2omcmKBqZfyOu9WESiwxMYBx3REU50+ovrOybDkwGnhcD8Oq0YC0Z4P6q7nvB+/X2zDbLshTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7oNrnmH5CCX+aWPiu8qfdvtWnK/1taTXKzeGmefwO4=;
 b=ZxO8TDIGmTDHA/CYdpY1NYTLv1jCs2AKCoht/JE/xOhO5W8dr7qy4vY/1FvkaZse3sUbtzenWfyPOdS3z62ichmlmVl+lWO897bZSxJfEEwATRQTdOyl7OHAS/XUHqOk5dlemGcdgdVNVCm5WVp9OdTdio/PNMAs7dYenOH172lNndoy7P1qBQdzIf/E1TTeAwjX4A039I/5OFy8cKe7DqmBH0PTk02ylWdDFz9FvyGrndkTZfjcpNN7PZVt6VtaTt0NXQWNOQmq9OeraFU8pS27lUKIBdrVnjxwEAt6S89wuLFqH/7geFJ3XE5pd+Ok6M6UprryRo+Vhgyxo30wjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 05:28:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 05:28:22 +0000
Message-ID: <d84e2d03-23c8-4925-ac03-ce7a02c914a4@siemens.com>
Date: Fri, 8 May 2026 07:28:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] chore(factory-reset): make btrfs
 support optional
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260507154253.2686296-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260507154253.2686296-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3a07b3-33d9-4af8-6948-08deacc29ea9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DpTPm863vFxy/Ze5Q0kb5e9MhdCGQhoFL5hIj2u40FH43Ogcn4ToGKEVUojirHNNv/k/8+6J9WDtSSdsWSLosZqLErqNLz0wTrpHIdKb6nvdDThm+2EVDiGsRxi4hqWlNrtoNC1cv3K4orYVWKwsM5cP4CBgUwO9s8syqq2T5WtUhhyvJ46q+yf8xN4s0HdfYexmV9ci+LSyj3y0LP+58ecc2ma5M8ANA3iJzEnU+t9+Oas4J0ROWbL6fgJBwIBVPnN8D1A5qK6LcbGB5l7CRo9UruVxNEFLolEGpsbccBfkEiRJrIsD9d5gYFTls9yRud30C1eB72ve7DYTYM08kiLhAEV8zi/aacNq4glVCZNZA0uynl8T4mH3Yjpz+iwDsv8wC9ruytRbMXOorCdlP7scVAYiAZ3CoILhzHu0Pwp2LTdlFnVSB1nni5LBN41FRhZkl4YJm9SWhVcg9vHTpeQIVrtV/OlvTQUs7QEHWY19d2lGOnciT5eFrk5bDjobVUXlTuC42In59VNGbVvKQ9MqkFsGR1yM3d9Hcn8ynZCA1+wo6c8jGhI5c8AzCcJm1T75/recfSmOEiMFRO8YMKE3/MsUTDR73uxWH10nbp0qPdgybuG2pN8az/P2VOlwSJIVfeSwuQU9ClEiDmS5gHTs1QFnSnzyyz4aFIrwYQd5CXQgmA1fUwTN22II9GS7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SW5QOFY4T25PNW85NlFwOHR2VkUwYVcyc3I3MmZyVW9vUWQ5anBXcjU2dCt0?=
 =?utf-8?B?eUdUL2VXeVc2NDM3bmxDMGEyUGxQQnR6czZQeEppaE0yTXYzSnJ1SXhGckFs?=
 =?utf-8?B?YmdjdjNQRFRXa1lOcitXYXFTVGFNd2xzQXZXd1Z2cTF6RGh3cm5sMWpZTzJu?=
 =?utf-8?B?aWJoSDhqOWIwSkp4QVU0SElKSWFFL1RFcUJKREwzSEp3aWlKOFlPblVaUWZB?=
 =?utf-8?B?bjV2b1FmaDFhNncrWExVQ2hIZllKSmJwUElmcE5Wd0NFMnlpOUJITDhPNFNP?=
 =?utf-8?B?N2VMKzRzRzE2NGI2VUdWSUduN2kxNTVYR3ZQUUdUelYyaWhzOHFUSWp4YkhJ?=
 =?utf-8?B?MDU4cEthWTBKOTJwTkdpRmhVNThSTzNGOTFTNGtDUGtrc2tyYmNwRzRxMjZ5?=
 =?utf-8?B?R2pISWhHUldRMmxONUpWRUVmaEIvSUZiVWFpdHlLTHFXUGI3SktZeUdXV2Ft?=
 =?utf-8?B?UTlnQml1VFZ3aGkzTlY2cUJJWkt5MHpoKzBiWW8wMGR6N1RqNHQrL2s3cndI?=
 =?utf-8?B?SHRWcGdldldrakFGMytSeGV4MmNSZG9NZkZ0MU5uTmFSRjRGRDdXRnBVWktk?=
 =?utf-8?B?UXQ1aUwwdjBCZEsvMStTTkE0aWF2QkFvam90dVQwWHhGczFOVG40dkQvZUlW?=
 =?utf-8?B?V2tzQUNpQUtPR2pHblBXZGNwQVR1c2o1Z2M4bmwrdTh3ZjhPVFI4V1RIZ1cy?=
 =?utf-8?B?M3dlSFE3WE9sZTFabDFxUkN1a3Y5MVV5R20ydXlyMm10NDJVN2wzYkVvTjlG?=
 =?utf-8?B?R2hwZWVSeUM1ZVR2TGhGbExlNWVWWGg3K2NSS1NUSWNlTkRZcFB3TTZQTVNU?=
 =?utf-8?B?SlFoK1pQc3FGSUM3c2o0VXo1V1d3S0Z4Nm9QZ05pV1NLQjUybzI2MVFLKzJu?=
 =?utf-8?B?c0hMZzRsMi9oZGtBSEtpbGtHUElTdzBSZmlUYlNLa0pTRGV3RUdZNGRpMzV4?=
 =?utf-8?B?b1dUanppcVQxUlEvL1l3Q3hXUTdOVE04ZXU2UW12TGUrbGJNZDQzNStsN3Zp?=
 =?utf-8?B?WDdYbXo3eEgwWWlFR3dMVEs4aEhGNkZqWXdUZmU5UzNVbmVSd3prL0J1dXdI?=
 =?utf-8?B?NUhmMDU0T2RhOGJBSG1FZUNndEdBczltUXRGU0JvYUJzYUcvVlQ3by8yVEZx?=
 =?utf-8?B?czFReHQxZW1zbkhyNXJLSngzT3BnNzJrMkh1RUlyNDA5bUdVY1VKYzNmTkpr?=
 =?utf-8?B?U1pPS0dHL1MwNXlnMUpIU3luQkNjVkZzMlZoKzNMVlFoYzlQS3JjMVgyTnZp?=
 =?utf-8?B?OGlnY1ovbFhaZXRVM0hGUWF3eit6ODgrdXlGck4vYXBsY1J3QVh6bllzQ3lL?=
 =?utf-8?B?OHNvQ0IzL21jMWIxZUcxcE9UZXZwcTd0Nk9OVXBwN3QrZmxEU0txZ05kQkV2?=
 =?utf-8?B?aUc2KzBVR1JVUzlzVGxtQ1NxTDNVVWp2TUVJNURPTHd5Z0cwTWNCQ2I4bUxG?=
 =?utf-8?B?a1ZSeXNWNFNIdGRhcEZCblhGMkM5SDNqbm9SNXJaNkhxazdpUUJMS0l5U1lq?=
 =?utf-8?B?ZzFZK01wSC94NFBhSnUrRzZvQUF3QU1ZSjhXTjdxcnpOeHpNdkNyTzJmVGJM?=
 =?utf-8?B?ZEFJbFBORmpLRk1RM1ErSlFkbGJrSVUvcGh3OW5ia1pOYk5JckFSei9Ubkcz?=
 =?utf-8?B?SmZFcEl2cEJCVlFFWWJpQzNlSm82bVBNM3RmTTRHRXN5a1RSUXU1RjRhUFcr?=
 =?utf-8?B?bnlEemRpaGxQeGdlZ1YwNEZNMElNZmhBZ0VQWldHVzhGaCtBWVlGZElERG9D?=
 =?utf-8?B?VjBuK2dFOFgyVmFEZWNPNzJzbmQxdWtodHdxaWJqVWxLUFdsb0ZkZXZiRFJL?=
 =?utf-8?B?eGkvemdaQXVKdmI2TGN2K0JTeWJPbkdxTHIxZ3E1VDczUmkvdDNqNmo2VEl2?=
 =?utf-8?B?emMvU1FBSEk0ZFFSREhTdytMakZ2OEpVdXJCb1l6UmlCdTNrQmJzUkFUaGFo?=
 =?utf-8?B?ckR6SDA4aDd6dlRKbWpEMFFNV041cWQyRWtxaXdDMUdEelZqRS9FWkhhb2Vs?=
 =?utf-8?B?YzBGRXNHQUgvcHJYdUtWSEVSYWxMSnVkckxZU1hjTmp5U3NaS0lZcGM0ZjU0?=
 =?utf-8?B?YURqNXJiLzRhWk13U0hLYVQ3M1pDVUwvUzRtUWl4SittRko3VnRaQU5wR28x?=
 =?utf-8?B?cnhDTUtSYU9XWW5IbHlRZXU1aVU2OWlQWVduUWR0aG9vQ3hEaExQT0l5c3BL?=
 =?utf-8?B?NGFrbThPbS9qWGVXNlF1NUFmSFgzd09YaDJPNzIxZmU4dnVwMXRtZENYd01w?=
 =?utf-8?B?RnBnYTdMMzBSRUVhOGxMU1ZHZ21kZlNYdlpmR1NyRVJWay9zNkVFQXB1aHJY?=
 =?utf-8?B?c3R5aGVJQU1aMWFRQzJrQStBSEo2aUt3K2pEazZURGg1RVZIL1dtQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3a07b3-33d9-4af8-6948-08deacc29ea9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:28:21.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDc2GjxxB5oIuNoPYiHDnrwDi78ZcNAluw8e2km8sALszp7QJEApZoSYmoyRBCMwcy2hWMdnNqBSJX3DvbxDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 May 2026 05:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22916

On 07.05.26 17:42, Felix Moessbauer wrote:
> To reduce the footprint and attack surface of our images, we make the
> support of btrfs in the factory-reset initramfs hook optional. This is
> implemented similar to the initramfs-crypt-hook.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Note regarding testing: I tested the non-btrfs factory reset on the x86_64-generic
> target in QEMU. As I don't have a target with btrfs, I did not test the btrfs part.
> 
> Felix
> 
>  .../initramfs-factory-reset-hook_0.3.bb             | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> index e962a51..9ba3e66 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> @@ -20,6 +20,9 @@ INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
>  INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
>  INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
>  
> +# add support for factory reset on btrfs
> +INITRAMFS_FACTORY_RESET_BTRFS_SUPPORT ??= "0"
> +
>  SRC_URI += " \
>      file://factory-reset-script.tmpl \
>      file://reset-env.tmpl \
> @@ -35,14 +38,18 @@ TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>  RDEPENDS = "factory-reset-helper \
>              initramfs-cip-functions"
>  
> -DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, \
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, awk, \
>                      factory-reset-helper, findutils, initramfs-cip-functions"
>  DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> -HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
> -                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename \
> +                   mke2fs awk blkid rm get-factory-reset.sh \
>                     chattr grep find"
>  HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>  
> +OVERRIDES .= "${@':btrfs-support' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_BTRFS_SUPPORT')) else ''}"
> +DEBIAN_DEPENDS:append:btrfs-support = ", btrfs-progs"
> +HOOK_COPY_EXECS:append:btrfs-support = " mkdir rmdir mkfs.btrfs"
> +
>  HOOK_ADD_MODULES = "efivarfs"
>  
>  do_install[cleandirs] += "${D}/usr/share/factory-reset/"

Can't we have some fstypes variable here as well? Only bashing btrfs
seems... unfair ;)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

