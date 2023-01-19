Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099EC004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 11:44:40 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.80])
 by mx.groups.io with SMTP id smtpd.web10.43094.1674128674781715146
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 03:44:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=esKJJyw3;
 spf=pass (domain: siemens.com, ip: 40.107.14.80, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqCXlIRyXfdXNUVP78YPYLbxCiZhaCx+G9M5XxXe/S6t++VZUAzAV2vNizDCMaXxVJMSTFf+EGRr/EpLlUge+dWY7qE6OC2mJIGk+dFiDQFa9QHwYI0ML+eyu4O7aci9p461CFwd36vPRDoxjjQ1ENQ6bmJ3qGTxx6qiKeoSaRHidqh7q4JxdyhBJ21mo+wlVKm0s67kY6tutKKEs3TLDro/TjTB4nYf+dXBldOqkOpczw+Ll3KTzJn5wHFYmR3fa23Hjx5XJkjhIFiHbcwE5t1AMXi2TPGUe1naEkMSBqpu/jJO6ijXn83Qq285qKaqhjtC6vQdG5qyArPx9UJ7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/Ace0o7OGI4WHoJLhCfVg+tr0+iwQR62WKRQxOEKE8=;
 b=aD7Zd0d/i3lUJmaGN7JIC7TUGjusbJqOzMn7JHuVF+ycIpPeHVqgqtjVU4GGKcsV35thfeJ34M2oKC1mVMJanbwfLzWc8GQFWUNQsr2EjOSkoM2f0eGjceWq12odQbPaK7hP/W7j7XtOC96yTtnHr95zBfg+CUJgmDsvm+drS4epvIH7czmbrmgGQTqkw7MfoqFGctTpDj7A34qR6yNtL1716ZIkX04PI+T9ei+I5QWAtvRfawVnBAOY1dtE0k5EXVWrK4e2urC6s4x/Dhs40YRIr1Xq/fGxSK1oc4Wi/m5ehvoV9H9xe+xkDJveTHHRkOa/CZEZ/pr+dIw/I6STDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/Ace0o7OGI4WHoJLhCfVg+tr0+iwQR62WKRQxOEKE8=;
 b=esKJJyw3VmR/tINXEFmRPocdmmNNCqdnIklszPhyt5Saya9fQvaBKxKyQ4ZZiSbddX3EbxfjixwlKRfs8PhQnbrq2CrYSt6E6GRe1NV23WozJDbaxvTHCfONMXcLWktV37+gNDzJu/1irrAna1EudxWzMO78Sz+ZSSWBerB2qIxlYF/27g1K9URQOzfTt8YOWta9QJUypRP43VryEo+O3zzpimHiB6QUxKzVvFtLwhcVdOU2JtuZ6jLxnSTnWJ5tpjyXlQfaC5r59x1PuK/PUFfG9BH4TaGDJswQ0as0lLlWd6vj1YZ3bbkhiosUv5bCIHnDTQ1zyESxcSwDLOHdlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 11:44:31 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741%3]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 11:44:31 +0000
Message-ID: <10d25a0c-4468-62e1-b22c-d39f8ab16964@siemens.com>
Date: Thu, 19 Jan 2023 12:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [isar-cip-core][PATCH v3 1/1] Use global variables for abrootfs
 partition uuids
Content-Language: en-US, de-DE
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: tengfei.wu@siemens.com, daniel.bovensiepen@siemens.com,
 jan.kiszka@siemens.com
References: <20230118090400.1582100-1-felix.moessbauer@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20230118090400.1582100-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3613:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e134cb-42a6-4abd-c71d-08dafa12873b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n2pSLqxzajqgGn1ZXj31ZxobVpxFybnIZ1W6+dPmszZT+nEn042nawOpJdQGxhOWSniYrzLKcwWsa/tzVlyxfd/JIc3I2DidTf08Tlfbrp9IY3wN6/ZAbji9X0rNGTbse898jj7yRhQMHZB1CF4kX/idaBNutcEQPshyUCeR+opNgCoOUV67r9hYGsEhCDzF7ottxrWTqfFCH0Eok4mQjIRRdAVCGrAs5t9oxbiiW5f+vvA0/Ws65MD45WfOAf0FZMy+b0A+mtYPELHmh+6QHB2iqxnZn4grJjjdyKu9NRW9bA6rgJ2Xp1ikjW1U1bQaRXmG/JJHsGVTjEv2Sdl2OYrwmZxwDFWC1eXTkwp0KxeUoANzb8utKgMcDb0f87E9KiZXXq6RbCRlLv1GBFWSWZ0f2JYyC6L40H+cuQ1e19d1hkUp3r0ZS9etAm2h7SkK7ef5WOP+QQxlFdVSVZta23rlhJSP2fZFyvw/vvUZmaC9530RVPTnVP62Ty5SVKiyf+3EylaL1dxh82iHAz17H+JjL8aoTtNwsC8Zt85ajMOLHU+6yPhBztGsUSB989dOLOeRR/WsrwzixzTkmRj8uSrEizAtgCpTUguGuTBM9QNcBiQT3wfmZSs9UHpZyFJnMyX5lEw424CLBS14wYCgeVloDpf6WzahY33kbzyQRO0Fu+ds7zVRwodOJahQ1OGbQBv6o1HydPrl7o2C/NV0wCXNrTEsVbnkscVZsWbGwNhi0El4gO/x6ufzDuV/tEzpFldUIJnxfuujXk+MeSEDCA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(31686004)(66946007)(2906002)(66556008)(8936002)(5660300002)(66476007)(82960400001)(38100700002)(31696002)(36916002)(6666004)(107886003)(53546011)(316002)(6506007)(86362001)(6486002)(36756003)(478600001)(41300700001)(4326008)(8676002)(186003)(6512007)(83380400001)(2616005)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1hlRit0NTJrL1gxV25uNExMZFR2OTc1TjFUaysxMGNUY3hmTWVOekZpTmp4?=
 =?utf-8?B?YUNjNjN2TFlvZERQNjRTT0dPT1ZoY1B5RVNBOVc4NE5RL1JVTHNYTG8yNTlv?=
 =?utf-8?B?NHAra09lejV0QXViSDBvV3ZIbXJHWURPcHc0M2k1b2tQeVRIV0ZDYzl6ZTRP?=
 =?utf-8?B?dmVqNGRkT01hcFptY0lCS0JiSkE0VHA5SjMxZDJZdnhtK3FFSmxEeVZNYzZZ?=
 =?utf-8?B?UEFBbzVVb1dySnJ2TyszdzR5WVJtYndlNWpEcHFwb1lZNHZBREF5cFZJNFBN?=
 =?utf-8?B?WGVsTUg5RFZrUFhyZUErUUJuV3JhQnRud3ZSWHczSk1Pdyt2bnZBNEVSTG8z?=
 =?utf-8?B?SXVGWnp5Y0tNdm5Gdm84Zmx0Q01qa2NETUs3TWRiejJWaWczRU00b2ZjeURH?=
 =?utf-8?B?VHBFTnU2Z1ZmOEJKNFZ3NFFsSnpVc3oyMkRIUlEwc1Q4VjIwRU54NitFQmds?=
 =?utf-8?B?RUhBOTV1SkZHOWtRR0s4SEtvVEdaZVZac3E3QVFZcGw0Z0dQOTFpVncyUVRq?=
 =?utf-8?B?WXhKZHhhOHFYTjZ0Smk2WDB2UWU5a2lVbW9IRDhNSHh6RGErMVg3U3gxa3Vz?=
 =?utf-8?B?S3ZQM0FRL3FxaVM0N0dRTk1MN1dObGJLSjF6aUl6ek1xS29ESm56SHdFcm9x?=
 =?utf-8?B?S211VGQ1YlF1VlZlSTdqbEpuZjdiYk5Cbys2ZGRGa01tTzJxM3NhWXBjQzVh?=
 =?utf-8?B?MkdmM0diZ0Y0Ty8ramRzb2w1MlVqY0EzSHVLNmhDb2lYRE9vMklsS3NjL1Ny?=
 =?utf-8?B?blhMbEZXNndOYlNtM1Axa1BYZzZJY0V6Mk84NXhFTXJKT1BqZUVKcGVoTm9D?=
 =?utf-8?B?dDV6OXJrdUUyRlNqaGovVDBuWWZpWmZZUkFZMkFWNEwwT2o4akZ2U2sySzVU?=
 =?utf-8?B?ampUSWNvSHg0ck1Jbnp2VnE3QWdYOWh0YWJOWml0L0Q3bUpxMjFpQzV4LzBT?=
 =?utf-8?B?SHZtTkFHNEUxSk5yWm9Vb0RQTVFReWtQL0QyRVNVbGVmT05ET2pTbGcxZHQ5?=
 =?utf-8?B?QmxzVWVXUjBuY0lwSmsrSEtHZUdsVi9xYVFNd3hvWTVKVnRXeVRNODYyMDFR?=
 =?utf-8?B?M09XK1padm03c3NoYnNIeldENk1Zc21xcG1YQ2NRN3F0ZEt3ajA1Vmxyc1R4?=
 =?utf-8?B?aithUU9HTEljT2JROUZZdCtYcEpvSm1aQ1pESUdVTjV2b05wS0RKWjhQMGtF?=
 =?utf-8?B?Vm0zNmU3QjNLWjJUemtUWEtzK3BFRnZVRkJRakRWeDV3cFNoNlBsTVB1c0Zn?=
 =?utf-8?B?ZVJFV3dmanNuWHd5dVhVUHdBS0tkVURYaXZxN1A0MWl1blJWejZ0RkxMdnF2?=
 =?utf-8?B?dnJINUZhSUV2ODU2b29LSDZJZFlnR0Q5enBBSjNNRnltdHFSbkQ5ODNjVEpS?=
 =?utf-8?B?clYzaHJqbmVQQmxiNG5rZ0NreWVnT0JrLzNVd05nNjN2SzNCMmp3a3BzaW1L?=
 =?utf-8?B?SDJraW15QkhlajdjYWkvdUgzcG9SUERSM2JsNE4xaTFxU01QVUlOdXJ3RWxp?=
 =?utf-8?B?RGlkYzhEV1RISDYwMUVSSHM3Ny9mYTJjemZXZHdwQUVPL2NIb2RCUkhRU05q?=
 =?utf-8?B?eWlTNEszZFR6UzFPaTIzdUNMN1BLTitpcnpId0N0UmRLVEJhcFNNL29CTy92?=
 =?utf-8?B?MkRiMC9oWktHV29WZ3VZN05VbTBiTFRyaXRoTmQvdmp4d3ZRVDNBVUpValJ3?=
 =?utf-8?B?SW8rZjdoM0xGdnI4MlpCY1JEem0rRVdNeWNkUE9OL24zbThoZ2tkVXNBUDVl?=
 =?utf-8?B?S2h5R2J3SFpuYnFzVldydGJpRDlPWldVRDBjQlRUanZBL0w1eC8yYkZaSVZJ?=
 =?utf-8?B?YklDTXJQZVhxRFE5Vlk2d1hGTnk1WDRzSi9idHA5aWx5Q2NwYzNsQUxkMDE3?=
 =?utf-8?B?aVRKeGJxc1dTbGd4MHYvc2M3YXpzTGFVWjdzQTBQQnd0cm1nRDBmMTFpUnVR?=
 =?utf-8?B?cEVWOFhTRWV2TFRsWTZCZWxuTlg4TDgzcGRxWTdBNFhKT0YzL1VqYS9XbXdi?=
 =?utf-8?B?S0VQY2tSb2srOGZQdVkwMU5YMkpEdjFFM1BPR0lUY3poWVdZVjJZd0FOY25D?=
 =?utf-8?B?Y2w5dnpqNDFWcUJheklwbytKamJPZHZjdDZRREMzZjFxbEJpT2dmVW0zcGtw?=
 =?utf-8?B?Qi90WXU3L3Bjd2diTUZBZG1iTHlsS2lEN0lEQytFN2o1cmFheXJ2QzVJRW13?=
 =?utf-8?B?VDZsNTBhTDA4MGZQZmU3L3BKNHA3dWxJd3RwYlI3ZjQ0ZW1YMVV1QmI2YW4r?=
 =?utf-8?Q?WE2I4Ev27VLn80RlnsG4uFaTmwttVGfMdnRUUCHwl0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e134cb-42a6-4abd-c71d-08dafa12873b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:44:31.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PxnT4FKP6/jeOMHYtTRWp4O3Ewe9Anf+RxH8rh80H7hJKe6zcwKNfnqrG+3w0dL6VhjRFy2MTA5xNewFoTzZprtGWOza0jxOsZ8zlVUPos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 11:44:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10435



On 1/18/23 10:04, Felix Moessbauer wrote:
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
>    check will catch it anyways
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
>   kas/opt/swupdate.yml                          | 2 ++
>   recipes-core/images/files/sw-description.tmpl | 2 +-
>   recipes-core/images/swupdate.inc              | 8 +++++++-
>   wic/bbb-efibootguard.wks.in                   | 4 ++--
>   wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>   wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>   wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>   wic/x86-efibootguard.wks.in                   | 4 ++--
>   8 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f0d3f1b..60a4aec 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -25,3 +25,5 @@ local_conf_header:
>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>       INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
>       WIC_DEPLOY_PARTITIONS = "1"
> +    ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
> +    ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f7105c7..05125e6 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -14,7 +14,7 @@ software =
>       name = "cip software update";
>       images: ({
>               filename = "${ROOTFS_PARTITION_NAME}";
> -            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
> +            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
>               type = "roundrobin";
>               compressed = "zlib";
>               filesystem = "ext4";
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 0ba3a0e..9b2aedc 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -26,6 +26,12 @@ TEMPLATE_FILES += "sw-description.tmpl"
>   do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
>   addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
>   
> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
> +TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
>   
>   SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
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
>   include ebg-sysparts.inc
>   
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>   
>   # home and var are extra partitions
>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index ba7846c..5c41116 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>   include ebg-signed-sysparts.inc
>   
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>   
>   # home and var are extra partitions
>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 80a7803..a58928a 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>   include ebg-signed-sysparts.inc
>   
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>   
>   # home and var are extra partitions
>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 53ab568..bcd736e 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>   
>   include ebg-sysparts.inc
>   
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>   
>   # home and var are extra partitions
>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 38f7cce..683d7a8 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>   
>   include ebg-sysparts.inc
>   
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>   
>   # home and var are extra partitions
>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home1 --align 1024  --size 1G

This looks like a typo in label: home1

Quirin

