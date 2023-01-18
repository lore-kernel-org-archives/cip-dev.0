Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41646C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 07:46:32 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.88])
 by mx.groups.io with SMTP id smtpd.web10.10309.1674027985530738467
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 23:46:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XTZkRd3B;
 spf=pass (domain: siemens.com, ip: 40.107.7.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1EktGBrf/MASDlIl3hnAZo1gc2cmO+ER/R7GIjpep5y/9dVg2jSkOhxajJlypefPKr7VnkEgpBn1H+8sHnISO4CTFewf8uq+iySvwjCGfanSPdMPjHTbZWxghn4P6icDEU7Vk7UyoZG9DOWTTIcp6pTbqAaFOZAUwlgAnsGdHOpyqrB4jPE5qk9OsynLCb78J+d5VQJxMlYBU4/U4u/TXlEHUJDjy98uFha0iGTsQdVE74c9gaDkdOOHIuCuNyfQBclaeGHGnVMXA51WMAZsq03soUYHeJ954OyggxfbK45bOJdVGlcwHD5djBgJyI1NZr9jkYv5fQMhPodKQPW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y4mK6gZs8TIsN0P2s2gm1kCfvHeI828KSQov6dKWaM=;
 b=iYdcDf/p4Ry9u7MgFXYN7QHxVdYlilnB0V4x+rZb8sg1UBr9QqZkf8+Z/6FyCAYy8ZHzX7um/IE20/Aw9akGA8pFNoyh+0K/WmVZxXfePGZ++qImJOYCv3EwJg4rL43DB6o6ZDUOlW1cBBEHUe7mAnDR+HVsZ++ZCVnh2f/K54JfCXRZo8iXAIXc7Wf/keAfonOG/lOJNgJcPKjF7rQxs+25AbXoc+wnZNoQ1Q54Coo7+noBGP61F1fp1lcABEKk30toe2J+up6PY0txBspiapeljCJkhaOrMpeIruon5624Phr+wdObCDbcqML9saOE367V+XJFe6EDn9h+/fzW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y4mK6gZs8TIsN0P2s2gm1kCfvHeI828KSQov6dKWaM=;
 b=XTZkRd3BodRRVlJBpZkK0xwwTTuJMttggKMOe7XA+w9hOCFY+rnPfiJ/6Inc8TX+Q6iUlrf3PuB0a6xMcAB0fWmwCzS2vAkZIvwVl3JI0OcUGjkFFpoudbDihYxJwMvhdcQ/bq7VDlr+jSk1q9ox7BZfYYWYbP5qn7cHbD+E5q3g7ICnZTLehTiK9YbJE2XS/QVK3pdX//ry9vebJIzWIDsYh2eyOxpG7NW8rrLuy8AWIk4r9EdJUdk5++X9lSKt+kSwOxAO3dhyAJlZgpbTGBYP9F1zgU6zr5dlk7U5lvh5aGCFc6LaYLcN+gz/GjVH9bgIpda+RBCIsB5kdhAyPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 07:46:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 07:46:21 +0000
Message-ID: <fb36037e-de6d-d167-6c11-ddcce05497a1@siemens.com>
Date: Wed, 18 Jan 2023 08:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH v2 1/1] Use global variables for abrootfs
 partition uuids
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, tengfei.wu@siemens.com,
 daniel.bovensiepen@siemens.com
References: <20230105022044.1507793-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230105022044.1507793-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 98491a40-1cad-402c-8809-08daf928174c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mzv9jjWTeWk8RLhvrTjSLj5CV6pPLYhbGVj9++Deah4bT39T8NETMT88XO2inrEdXoOcMfEAmLIuEyUPSFWXD6jddmbvxqAxbKuI/ajYiFidWEgX/OqcoqhUYhOmaq3jtCQ3DwFqOzmTrhzFFeRy3DdBh3qcN/i8bLr1HrFkc35Fgziblh5t7OtLgqYtUwMJEikAgyBnOdpd6WSKFW9CxrlWEDd5y6IBIfliceT+tHoFWIBgdRHc6Am3kLnVZEps7FuEL+8g3836FKKz4YHC/rHFGa0bzCl3ELp4tEPUwjYioWMLhPtuSXyvle5rw63qw8bquXFKBD214CBoMg44/9Dok8e1jLwOgxzSV7vTpxVRb2HoSwxBJbwIU9SDoV9p4EsfjWIFRYrEyb3lj/liT6gDAWrHRpWxU/B8IugQX61l996HbAgdje87mAECmb5eE+4l0Ztrp2pLpDj2xgakWtzJn/1yIDNvtrf2xqbxlB9ew9oNtlOrm/wld8MY0jl1ZJFqJ8toHv3zs1n3JHiLhG206dQTKxvErRC1pPA7ufkFHin8J7LOOcL1DzjVIeXvpavNTJPcBxbcFVdOJnWccEFoU+ArFaJPHCafRiB9lr7iU+3kMLAM2QE0CwFgYL7AAVnvDcWtoY8vQCoYy1EwJut2ZKHwmdB1Gy69v90ax7xIPjBJ1a69F38GNuEPGvNsA2Ny8DWZaCh8r/FJbZSi+TTGnE5OA6PDJpCzd+rzIOcvTJImmRZWiOwI7ZTZahPyyCLZSCvBuXTWvC3SijOUsA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(2906002)(44832011)(31686004)(8936002)(5660300002)(66946007)(66556008)(83380400001)(66476007)(86362001)(36756003)(4326008)(8676002)(41300700001)(316002)(26005)(53546011)(6512007)(6506007)(6486002)(31696002)(186003)(82960400001)(38100700002)(2616005)(478600001)(6666004)(107886003)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0txM1JvTEFkajNuZFdnckZIamtIWXhjWk91U2MyR2VuVENJbkd5NFJLR1Fl?=
 =?utf-8?B?cFF1MzF0SlBhVlJLMmU2c2RwQ1JlN3VqZWV4T1kvSndGb2JaaFI0SjUvczJ3?=
 =?utf-8?B?UWEwem9oZy9LMWcrMVJEVmYyaS9jS1BmL21kL2tvU3JxcFlJdGkxeUxIV2ph?=
 =?utf-8?B?dUdKVEdOZmZWNVdrT1I5dk9jN1JublRHVVd4N2IrZUhKRjdEem11ZEh6NFQy?=
 =?utf-8?B?dnUyakx3MHhxb2k5TXNCWHF6STREY2JRQ1ZRNkp1TVBkSzQrOWlSb2FMSkUy?=
 =?utf-8?B?Skp4bGFtVS9xZ3l5aFZaOW5tUk0zTmxZVTJHTDhHQVhSK3hieEhIcWlhQmFK?=
 =?utf-8?B?aC94TjdNV2k0R0JQeHdlVG9LdDBZVVFMYU9aZGJ3bHpmbEdLMC9NKzVYOFZv?=
 =?utf-8?B?OVlGWXJZOHVqbGUwK3U3b2hPdEpLSksya1Fwc200UnorZFpsK3llU3E4Rmc2?=
 =?utf-8?B?aWJyMGVFT0lmbStod3I3TFp4K3VkSjZ6L1dkREdTWjFOdmxHUnpieVhwWnBv?=
 =?utf-8?B?VlZEWVdYeTJESDUwbFVKZkF0OXJ3OUl0cVpJakNYWnkrRWhYSW80cG5TMVlY?=
 =?utf-8?B?UXRVdWhOTHUzL0EzVEJHMmp0WHVHMEJ6dWZ2R0pHcEg2QjQrWDI4SDRZUFJz?=
 =?utf-8?B?OHUzOFRxaGp6ZWZSZnBicWEzTGVzQkl6OFd3M0U5TFZLT3UrSXNudnNram9F?=
 =?utf-8?B?aFhLVlBjdDVDRnhzSmgzcXdYZE9jZnFGNUhZTmowQllrV2F4cUUvSkdFOUdj?=
 =?utf-8?B?TWpheUdvNDhVMzNOQVI5QWNSUmdzaTFPSDhJZjUySlY1bm01U01wdVU3OWZm?=
 =?utf-8?B?SnZmd3pqdDkya2NTc3M3aHhOUXRWdUJyUFlpWEV3cVgwMVlGbWZwN0FwRVY0?=
 =?utf-8?B?WVJLRTM2Nm1UUytkaGhZbkRJWDI2UThGMWxQbWE3US80OEhPejFaNlFXZWpW?=
 =?utf-8?B?bS9zcDhjKzdNNHIzL1ExVEdvUGJRU2Q4TlFDN0R3MHFnZndTMUFUUmMzelg3?=
 =?utf-8?B?bHRQN09kKzVscGxicUpKQ1d1YzZQK29pTUk0a2NSeU9SSUFKcmQra3hVTCtz?=
 =?utf-8?B?b0pZaHRyQWRFeHJJMENTc05VWWtmd205M3ZmeEg5bkd4VkZ1TWpTZkxBT1BP?=
 =?utf-8?B?QkkvdnNPaHVIMmFycG50Rnh0bU9ZQUQza2svbnRQQnhtZWsweUpVbHdOQzdh?=
 =?utf-8?B?ekFhc0N4WmI3SmFQU055MzJVZWVSZ0NsZlpxeHduK3JZZDRBK2hjbG14Zmg1?=
 =?utf-8?B?bDM3Tlo5K3ZyZm8vcFBsSVRxZ2VyOHVBdkFRUlhkdXNDZzM4TjlJcnk4Ym5M?=
 =?utf-8?B?bktLSWtrZ3VJZ0lacGVWRVZKbzZEeFdIRUp1d1lsRjBlaFhBSXh5U0R4eDh6?=
 =?utf-8?B?VXR5R292MzdaaFRWL3Bpc3BuQTE1QnFRZVZrNEF6REI0T0wva2M1d0VmMHBC?=
 =?utf-8?B?ZzZlcVZvamhwL3JEZzhmQzJ1ek9JQTdtV0NlNWFqTDJ1cG5JeGJiNHNpekJm?=
 =?utf-8?B?Q0pVNEIwbWloaW50SE1MelZHT1V0ZnpCVGxpUXowc0dWT0ZBVTJEdTZkTDFq?=
 =?utf-8?B?azhOdTc2S1ZRdDBjT2UvaGMxZGxwS1VvSjNWOU14U0hUMlBpeEsyZWZhV2pR?=
 =?utf-8?B?eXd4Mk5xZGVVYm40ZFpqcXJDbFA1Q01HakhtMFZWWjNpUjROczFpenJ4ZVJ3?=
 =?utf-8?B?S20ydzJKRVl2TDRFK0J4UFErSHAycElwbFNGUXpWalF1ODBnOHhObGg1aHVY?=
 =?utf-8?B?cE9tUUVoaXpoTHZidC9zZForL1F3WmU2RVRBZXhGR2JpSTlyczA1cnplNW9a?=
 =?utf-8?B?djZDalM3ek9JYzlFMjV0WnJ4SjZHaWZtYVRiSU9laTY0RmlPU1FXRTl3bnhu?=
 =?utf-8?B?MDNucDZ3TDIvT2FRSTZsdkRiQTFKUmZSSE9QOURZSTBySERuaTIvYTFEVlhH?=
 =?utf-8?B?VWxENUtJVVlheFpIOU9sZFgyYm5WMGZBUUVpUFpkQXJuTXc5cnVIcS9sWThr?=
 =?utf-8?B?ajVWdHEwQmVNNkJ5aDhaSkN1NFhjQzVXOFFIUlBHVnl6b0twNVhDZU11ZGJj?=
 =?utf-8?B?djN1Tkthc3BpYXJYYWk1N1lEL2lpRHlnaVkzVHRlRFQvTk1ROVh3b0FtbDJk?=
 =?utf-8?B?RnY5RW5GU1paQm5YQjZyUlJxWS9Mdi9KVmtqcXJ4YThaYnNlRkxQNjYwSGxO?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98491a40-1cad-402c-8809-08daf928174c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:46:21.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLhQe1MF5DS9cH5KeNJYom6H9FtNBRyuqX92hZdWKG9abP5J7slJ6fcpPRh0e1rMqeCPWMm+ot4MJirFOkOHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6930
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 07:46:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10387

On 05.01.23 03:20, Felix Moessbauer wrote:
> This patch converts the abrootfs partition uuids to a template and adds
> two global variables to control their values. By that, the partition
> uuids used in the WIC files can be kept in sync with the uuids used in
> the sw-description file. This helps to avoid issues where the part uuids
> are inconsistent and hence the update using swupdate fails.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
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
> index e48cc7f..a714694 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 0e298bc..8305ebd 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 3b8dadd..6b01443 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 9ff03e1..bc684f3 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index c71253d..0604deb 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G

Good that we have patchwork now - almost forgot this.

Could you rebase over next?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


