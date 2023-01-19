Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272DC6379F
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 12:56:21 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.83])
 by mx.groups.io with SMTP id smtpd.web11.44512.1674132973332635252
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 04:56:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IcAMYZts;
 spf=pass (domain: siemens.com, ip: 40.107.249.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNVh79i9oo46Pm/dnBAs9UbXZwco0INBuc/hOtGatjXA14kpdrMePHXUuDXvp4wj7SLGTNRcCM0WSZrLS7dQetCS8Ew1/WQrvgIRtotI1JwCdU479OBZlvLmq2GgAZ23BEHMos46NeusieDRIBxIilm1uKFqG0v5x3EhuoudGwoJ22N53X6bGrxy+wH9ywTljFfZPt9gll60VchhKiYXB0oKtKmwvcPG7yDjwV+9KfTtDdrShhYhqn2CzbrXewh6Juz9PxUinfmiGqFhw3RoMpeTz/LmLPxxQgktcsMcGsQK+NT5naJ6Hp45ANkxgAChQ3CKob8VysyjduOWICkBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxsmaxuwRetzc9CM9hGXGbVpWjhvUTR0W2FOJTVX5EE=;
 b=XPkIQqgM8QhFtUdz3LTKD50FMLSVgGYdvRR6QAsUWnakHuE0HuJUkkk9H2jMZx1kijJ4HYRZX2MCPkwgUg873nRpJV7/nmAQPq/mA/XJBfaRacL6WxbDqhT3L9zxCZPfXFUnWmpyMMsTbP3bFjpPUPg3BtGG9402G5PY/9z9oQN8VZ1WSaTcVosbis6x/OJ90p6sU5ZdUj8YXt6fc7yn3l5D5zEmkfwkw1gUwkfd6J47PsXUYTbe83LtVhgxAIA74n5OqCcgDQ4nqhbc+joNBcapKH+z245NFmwpZAyqf9Q7GVlA43iuQ5QCJctu8onLO5eGnW/B4mVKvzOirANVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxsmaxuwRetzc9CM9hGXGbVpWjhvUTR0W2FOJTVX5EE=;
 b=IcAMYZtssfLSr62M5uPL4NqfkPnP1US4hojOZcvw9lc+ZPvgnZeo4HZ4DE+drLCuWx5JcS4zVvBqGAq5MjJ3eGZbxJhR0uM5KfUQjrB6UHIQTytbJvS921MiUkI5zWzlfS38rKWf3/5VAPum9Wj85PRCagzQy4hspThEqZPjO09MI3PI1lBKneaNhmtgdc8EwmmgbnX7LpylykdZBrf5XFtTveCsQ5gP+pXzF46OZ2ooXlpyNxiKe2n6T3LIqimAU2oJ/WDeb+yHR6G5iey8c72jP5Rm29lI9YVGYsE4OCI57r2f9Ya9k5j6TPyin0qZC4Mq/7gcCF/X4tYFrN8HuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 12:56:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 12:56:09 +0000
Message-ID: <f2dd42fc-6f61-de64-1f57-96d13c29a529@siemens.com>
Date: Thu, 19 Jan 2023 13:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH v3 1/1] Use global variables for abrootfs
 partition uuids
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, tengfei.wu@siemens.com,
 daniel.bovensiepen@siemens.com
References: <20230118090400.1582100-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230118090400.1582100-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 72acb781-ee57-4f7f-4a1d-08dafa1c8949
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z83jcKKtxM4tctMmST6YhMz3dJjbV1+PQnJovnxTDyvz9EgXNAH7dA8TA/a6BYdkIVfUoMqsPlfkZ1xjBLV26RGh3Z1KfYsIevOTXKC6ewDCAGK9os5Z2YkBHyrMgovPknqnkt5E0qb8oJbJQCclLPlNdnPdkzaC430bN679Q9+znUBHLS8PFZleE8GQvA1UC/m0AjU0zouE0+nG2zqIkb5yqFMJ8509bG0ihPDuTh6BsgIGbuw9tTZ24vJJNWtQ7HFa2kRF0dfDYfO4SD13jrQEq2hgzjVqFwIMFRusWLjDo1j3p+1i3BCa1eVbnIjLltGj2cvQdiiyXhjQslvvSBkIpuO4nlaASh4jujLoAC+bCLz8feCaG7Xuy3UFr9DuQjwWtlySDQtsAPr5l0y/ZVnlCyxppF3dTzPphExBQAjc1LcRiMlpZ7cXL8xKcF4fouSOjJRmaHb0qHlxDUc/wfvAuOfjToB+MDNHiTItOc+ocAvt6UBunMD7GakQgT7ks9a63Ff3161yoAtRvDWUQkKMEkF1DreTcjjf+nlTMuG595/PyXHFIDf/HVn6pANU/WOxDfWKOkGK+Fe7/jQ7T9usE6eaxUgnCEiyKWp6nn2GN+eWTsfFB8RdAUF5j8/U7qDNAcRfXW7MbX7+D6qv7T33zWFRp2MqRGC2rcsAwriNMAn0ZUpsyk9d/gptuyUjpEWt8TK1RqAuTiOTnVMORWbvXpcSM3W1552/gRIRmkIBSOR1faxe2WIyoynOXxtph1tl9jFkCBu1QnuUeh0sSA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(82960400001)(44832011)(2906002)(5660300002)(107886003)(4326008)(26005)(53546011)(41300700001)(186003)(6512007)(66556008)(83380400001)(66476007)(66946007)(6506007)(8676002)(36756003)(478600001)(8936002)(38100700002)(316002)(31686004)(2616005)(6486002)(31696002)(86362001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGtmc3FFNk1rS1l1OTVVSWlIaTllNjFBQXB2anhxUXYzLzQwR3N0WDFrOXRy?=
 =?utf-8?B?ZUtkQWhUU3NoblI2dk8wU1pTVFg3V1F1aHRVN29ES0JJQ1FCeUxPTnoraTY0?=
 =?utf-8?B?bU16Zk5qMEJsRTVRSTA3YmVmV3NUajB3ZVdvcndkaDdGcjdnY0o4d0ljR0tL?=
 =?utf-8?B?cmlWaVZXYXh3c2RWOEVjbWVrRWxkVjJjWjkzaThadFd5VjV5MmIvMXdSWDJz?=
 =?utf-8?B?VFp2UFlaektBYk1NL0pKOVpZMHBFbDRtKzRzME5JUHVtNE1mSWZ3SXRkM1Nx?=
 =?utf-8?B?OTZNaW9JUUNjTm5PaldUdFB0YkNaMUJjYWZJUTNOWVdlSEVtUzEzeGZNWTJH?=
 =?utf-8?B?VThLWTByV2U2SGhRVkx6M001T1kvWERRL0dNSUN4blVnbnk0Vk5qNEJiT0dr?=
 =?utf-8?B?L1YxRjdjbTRwU0lmbXZzeTRCbFA5TzFGVis5M0I2dWwyVnlVNUJXTVI5aXZ3?=
 =?utf-8?B?SGtHRE80SjZObU9XbTdNQ0FxQTMwRTRnTlZrTWxHdDI5RFlwUzhUaEwrZkx1?=
 =?utf-8?B?Qk1IOGkyOUJFQjQ5TGtiVko4T2RaUTBxdGxTdE9vdGhDY01oK1dKbUIwN2NG?=
 =?utf-8?B?cnltaFR5QnFBbElqcDNVam9WVldEdU9hWlhxaUQ3UG15WVVnbGduYmo1bGxW?=
 =?utf-8?B?YUhWQXNlV0NWREZadi9udU1nR3B1bVhVQ2VMdTNoUDFMRHhqNHkvTURIMlBG?=
 =?utf-8?B?ZW14YTI3TXV4czllK3M4YXpkdVBtWEgyaXZqT3dkVWJONHBxMkVITUxWQWZG?=
 =?utf-8?B?bTJEVWdNSTV6cjZlY2daZXE2QmplSWxueEhuV3lhZEhsM0ppdVk0Sjk3UXY1?=
 =?utf-8?B?VHczem00cU9iZ1lrRlRCN05WbThnWm5hYkpEd0tiSTBmZXJNTXZhWnNiVDJO?=
 =?utf-8?B?YkdXZDJlTnR1bzErbjhueHZ3allLam53TUUveXI2T2RYOEI5WitqL1RJeHFn?=
 =?utf-8?B?QmdNdDhTYVF6VmFyWW40eVJ4dG45VG9QUFRJdnVyZGZwVys3Z3ZqNmpTa01j?=
 =?utf-8?B?a2p1MElML2d6M0hxMmY3NklBRzBuNk5TQ3pDY2RYb1dpYWpwL2ZoMkZsNmVm?=
 =?utf-8?B?KzBiMWxBUE9NczhOdHRUQkNqdjl3c0xuOC9haGpZS1pybFpRMytucnQwQ3ZF?=
 =?utf-8?B?bDh0c0xjMnBXQlE3ZnhlRTJMdWpQVzVxNlhQdVk5NzcrbyszZEdRZTJvUDIr?=
 =?utf-8?B?cjBtZUtSME5TcHlvOFo3SVVDaXBOaVdOaHI1Ynd5RkFoYlRvc1A3WUhKZFpw?=
 =?utf-8?B?anZwelliS01Kb1JaMTl6dDI5SUcvby9YZTErOXZDRGIxOGtWYWVvbDJxYzJ3?=
 =?utf-8?B?UUVYbmlVRmhEL3RtL2Nic2NVMGtlUmYyNmtGQ2V3VEo2UUs5S2JteVRtNFA5?=
 =?utf-8?B?d05rNktDZUtIZzRqaHVNb294c1gvK1FkTjdIelhpUnN0WlBrUjN6TEJoQ0F1?=
 =?utf-8?B?L3JvbUtwMERDbjNEdjJOTjhaNVFhTm5ndzJCY1AzWW9BK0pLNzQ4REFHaGZO?=
 =?utf-8?B?eUtud0hjVGU0cGZSdDBIMldua1FPSkFuTkNsNTdTRS81K2hUcTlpY2luNEdF?=
 =?utf-8?B?SzZQajBvQWI5N1dmYW0rcldxU0hCL2pBTzdGYkFzblViUEJBOW1seFhHK0pG?=
 =?utf-8?B?ZjlDVWdDMS9veWJNcU15ZHNZSm9YeFpCT0JPZjVYeGZGTW1jSHBwbWR2WkxK?=
 =?utf-8?B?YkVQWk1xL25QcEpja0RVckZ4Tm9SUExsamN3cVk2dDNSOEd2K1FUQUVzaGZO?=
 =?utf-8?B?TUYxWVJjdXdIdHltL2FCTElvaVFZNE9HbHpsb05xSXI4ZEoyNU5tei9ha0dD?=
 =?utf-8?B?VzZwc3NLQWhCbng3QTltNDd3Qnh5YWsxbnNRekp0QjZRSFhFM2VYTDhyck0w?=
 =?utf-8?B?UzhndmN6ZU5oNytMUFZUVG50TEFtNGVYNG5DM1pDV1ZycG5XTFo5d0NFYkhq?=
 =?utf-8?B?cmVVK0lYQWNKZHZjc1VzMFVPQnNSM0VyOHR5Y2c3ZW1EZnZlZmVwQ1MzcXBa?=
 =?utf-8?B?alM5bG5aemFpU0dUWk9QVXZBYW1hRGpKTU1lbEtJbUJTbTVEanJKUGRUeU13?=
 =?utf-8?B?WUhKSjM5eW0wWjJCK2l3ZmlrOUNnWHZ5Vjl4bEl1WUFZQ3VMb0dCNGtwamxP?=
 =?utf-8?B?L2x5U0RXVkpkZEFPTk9wOEtRcjdPOFdycjA5SkJLc2ZGSTNaL3BGMDRJdlls?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72acb781-ee57-4f7f-4a1d-08dafa1c8949
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 12:56:09.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TF//FLG0ERJH7cYF9/kq2eMg12PVyceIyNObRX9IhNnZcpMHgBUkgAWeS6fbQ58jqtDda4w/4SpmJMToVwxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7585
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 12:56:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10440

On 18.01.23 10:04, Felix Moessbauer wrote:
> This patch converts the abrootfs partition uuids to a template and adds
> two global variables to control their values. By that, the partition
> uuids used in the WIC files can be kept in sync with the uuids used in
> the sw-description file. This helps to avoid issues where the part uuids
> are inconsistent and hence the update using swupdate fails.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v2:
> 
> - rebased against current next
> 
> Changes since v1:
> 
> - fix: add ABROOTFS_PART_UUID_(A|B) to template vars for sw-description
> - removed initialisation of variables from swupdate.inc file, as the
>   check will catch it anyways
> - simplified check for uuid values
> 
> I decided against the recommendation to move the UUID out of the swupdate.yml
> kas file, because this would introduce yet another pattern how to handle things.
> Downstream users are free to use a different method, but als long as CIP-Core
> handles all globals via KAS, we should not diverge.
> 
> Best regards,
> Felix
> 
>  kas/opt/swupdate.yml                          | 2 ++
>  recipes-core/images/files/sw-description.tmpl | 2 +-
>  recipes-core/images/swupdate.inc              | 8 +++++++-
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/x86-efibootguard.wks.in                   | 4 ++--
>  8 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f0d3f1b..60a4aec 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -25,3 +25,5 @@ local_conf_header:
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
>      WIC_DEPLOY_PARTITIONS = "1"
> +    ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
> +    ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f7105c7..05125e6 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -14,7 +14,7 @@ software =
>      name = "cip software update";
>      images: ({
>              filename = "${ROOTFS_PARTITION_NAME}";
> -            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
> +            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
>              type = "roundrobin";
>              compressed = "zlib";
>              filesystem = "ext4";
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 0ba3a0e..9b2aedc 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -26,6 +26,12 @@ TEMPLATE_FILES += "sw-description.tmpl"
>  do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
>  addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
>  
> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
> +TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
>  
>  SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
> +
> +python() {
> +    for u in ['A', 'B']:
> +        if not d.getVar('ABROOTFS_PART_UUID_' + u):
> +            bb.fatal('ABROOTFS_PART_UUID_' + u + ' not set')
> +}
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index 8a8de50..bb893d4 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index ba7846c..5c41116 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 80a7803..a58928a 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 53ab568..bcd736e 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 38f7cce..683d7a8 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home1 --align 1024  --size 1G

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


