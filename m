Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C52ECD128A
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 13:00:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.139])
 by mx.groups.io with SMTP id smtpd.web11.105879.1712581242052495261
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 06:00:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y6/yMZw0;
 spf=pass (domain: siemens.com, ip: 40.107.8.139, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHJntGymgcS4llDg3PovJkUSJRqLNbSjUP/ZORZm8AbfMJ2mf45GLUbn/SDrh9Ss6/bZRgs8q81evC28wR3O6M8VX+4Y2NxxQzcRc3V7o9C3FXxvqmb6g06zsPnGeWuGE26gytHEbPYW69zQTh7qR6oaD0ohgUjoOt5aUJKi3DRL1jWH96NEY6NxE1Plbbc3L7fVjTlDkqgFnPKi4dhwZ75kxoUoaJX5IJaSVxIcWuGYRY6a6RVq4M/ptaUp2Cmn1fljtgPsuGlIDQ+1wID3L5izZNL98V2DIxeXVyD32bg9xTb1JlswztxKohGkEp5jqw3UzFNqJ7AdaloewZLZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBQpwe/3aDgaHB3c7sUsIPuJsl7psQD45wlcQSLobHM=;
 b=IdHQ8YfHO0NgrsMebmK7YCeZ5qP044n0u7tRi5EeBNxRJ88BLIwhpW4h6AQaO5BmQ+5blcWFN1p14HVh9JtK/VoaBehj92OjnT9/LMNKpDPZMSq+LJWxHPMn8VFjB06X8OoOI23gtA4epCgSjnaERmzUXLY91JVlEtLi+6yf2QxNF9fbzuOqLD3UCyo6cHYO3pw524pG0K/8mp7oaAxsjWKco4cgszV6w+Ac7BcPdU3FXT3J67QIPHKMxRNTrs/8Q1CrAg7Etqcctm2c/p7ZJTsw5RUTGxv15AgmqHAcfZvSVadKcSby4ecwjejiOnAbh3Zr61sPhmgC9L4JDR5R1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBQpwe/3aDgaHB3c7sUsIPuJsl7psQD45wlcQSLobHM=;
 b=y6/yMZw02aSeXqudeWnIsplGQOjv/72y/w5STd3Scmh+OwC2H8OAoXC2unXzy+BwrS2sM9HdEeLvXkmSdaM7dfT98jQ1/OLEahrDuU3lGab0Exq01A3MoMSqza/ORR/E3vm0uh1fc3BO6e1zzTwG2pcyscrgMLAOrqPPfkJeAha/XLkrFN96AmMQVYghN255tTvNYQPexRYNEkvROuCuHQRnzxBx9imVNXia8AekVNA55mMGR0REQuaMI//gX9XAdmw19JrDcu1OkeoTbD6yjcJN8n0jhW+S+WypPP6N7YRkEOlnqtJDplCvypLA/JLDAWm5hzY6ZBzb41Y6+ipqRg==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:414::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 13:00:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 13:00:38 +0000
Message-ID: <112543a0-4a32-4e39-b900-006548f73dc5@siemens.com>
Date: Mon, 8 Apr 2024 15:00:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 3/4] swupdate.bbclass: Generate
 swu for delta updates
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-4-Adithya.Balakumar@toshiba-tsip.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240320103229.1078738-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6929:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QdFu5iYgAHbAphaFQw2yfLKz6nz5OeDb+gom2Sr9E/AAODV55c2KKot4CEvnccCzziP8A4O0BAE0nyq8/58A1UuyDjn9oUMUv3HEBTXYLWg/jIaw/lwkKRg0JAFqQAewRZCREWQXg6NMTsPSnM71NydUxkk4+DlGSgpVz8PoWamFo1U64vZFef4Yxonr8V4M187WA+lryYOUN7hLnuuzhgvdgc1vVfkPPMwyssoo1PNYV7m1Eib/nKCJ4ku9R3Oa9G89+QIyuTEYFvU2KkVSPz90w/UFeCuE+U4RgGBdTeA32ILH4wazd+ImBvrnR7pZlwBc1ScHpcs+RLLQCE8od8jQPtmVnePsiZWuIOIfRScX+uBRpx7QF0BKUOhAZ9i9Y6tC8pxVOExgZ964V2CGhShVIXT+Gmolk6GSDTsLB6A0VyW/bwATT1C+eHCWXWZF31q3qQSOJVcDkH96ji4usLSYv+DegLUOnZ1p33q27vn6LnJIHj+2ZvB/iuzsGppKF2XEXr5DkXL8x5QpZptwhSxyyrA3xn+UNeFyXkp9kFQEuhrZLwv+KgaQEkSHkID9p5h6rFj+FMd+mXNtKsybnTTPF5kp4PpyXGNQP3DjxvE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTljcC8weHZmK2xybWdOWURDN2lWZjQzc1BTdTdsSUpMYzU5YkFxNDROTEdS?=
 =?utf-8?B?Q0hUTWlYOHNvNlFpRUI5bzlHZzdhOUFUaXJJekVXaTdxWFV4UER1RTVPSnRB?=
 =?utf-8?B?OXVoSEtuZ0htNGdsTnJSdzZ3emhvRHMzYVdvaVNxeEtSRHJodm9Ed1REOFJK?=
 =?utf-8?B?amZDdHBobEUxcjlxOWZkT0tyK0ZpVDRESW01TU1LQndzblI3WURvZDdNYWpu?=
 =?utf-8?B?N24zNDVYb1JVMG16cVV4dDRubElXRHJkaWpCakI4V2J5NVNkL0lCWm5hbkxz?=
 =?utf-8?B?UFR3L1dxdlNTK2pqRU5QMW5mdHpYaXdkQ1N2UG9Uc0pFM3R0M2JoVW5waXN1?=
 =?utf-8?B?WnEwUXo3OEwrR2dBZDJMek5yYmZhUXhuVVVUWW9mUitZMlJ3ZlkzdzUrL3U0?=
 =?utf-8?B?RGVTL1RyY0tieUlNdmdPN3BkY1V6VVJxL3k0akxqSXB4MDJZUEZSb0tRVFJQ?=
 =?utf-8?B?RFNubnVtejZFOVRmTW5GUTYwMW85VGt5QTBjK2w4Nnhkc0RLOFJrd2drbXM0?=
 =?utf-8?B?QVN2WG9yNFRMRTIyN29WVUJ6T2dtN2FlVUxqTXo4aWVWVWFsSmsraHRUN1Vj?=
 =?utf-8?B?Z1Y0YWlBUzc5UHpBWERITDBlSFlwLzd5SjZUdStKZS9QaGU3bS9ibDQ3M2Fx?=
 =?utf-8?B?cVNXSHBZbUE5aEJkLytRUjdnUjRXWDlNanNkZTBYL3pWelIvRzRva3VNbWdm?=
 =?utf-8?B?ZEk0VWQ5a2tLVmxFYUxXMHd1RVRmSGZ4TkZjdjlxQWdZditGOUY4M3NYdEJV?=
 =?utf-8?B?aTZwaU9sMnVLT3pXOFFBV2dFMHgrYlBLck1ENytZY3o1U2NyS21rNW0yZ2hS?=
 =?utf-8?B?ZGFzSnhvN0ltdDhyc0JTTzVGakVLSUcvaEl3eXZ2SitRRnBnMkduNjBsbDBs?=
 =?utf-8?B?cUxQRTJ6RlB5d0FiUmozTkJSS0tFOGhDNW4zMEEyVFhXNXB5TE1ReEx5WDZh?=
 =?utf-8?B?UnNsajdLNlhRaklZSEF1ZHBrME9iRlkyWmNzOVlKTWY4T2lrRm1xbFZVRVJs?=
 =?utf-8?B?a2wrckg4UW0zd1QzL1A1SWRGcUhITHpHK3FRL2pDZEl0ZHdUQzkrMHpocUFJ?=
 =?utf-8?B?RjF1akxIZFY1MjhwU0VrREtCZlBlaDJ3WDUvdmpBUlZuRUZCdnFHVlk3V2Vx?=
 =?utf-8?B?eVpvQzRtNm9JbTJTTkR0N1ZMUDhhWW5EVURYQTJZcVUxVU1kYkdPd1JPV2wr?=
 =?utf-8?B?dHFSaHVaTkJJTEZqWFFKaGlTR2wyUm9XL0hwUnBkOC9hZHEvMkhtOEZUVnh0?=
 =?utf-8?B?V251cFNJYWtuZVZzMU9HUzdXNjhTcEZKWWRPQUNFVUFKWEl2SDdiQkFtUjhT?=
 =?utf-8?B?ai81SUlHNUZyT0FpSUFaY3lIVy9kVmt3bFpKWGZwbElJTFRBSlZwdDRXdDFI?=
 =?utf-8?B?QUNHdGNsWFdzNGszY1lCdWI4Qm16aUJMV0FhUnY5Q1ZCc3FjQTk1SzFYTkdB?=
 =?utf-8?B?S080Y0VTNHp1cjJkTFRXcjdkcExCVnZmUStmWngwRUp5ZFQvZDJ4NWVqUjRC?=
 =?utf-8?B?VkdYMlJJcjMvUnZhUUU5b2NkRTQrQ3MxT0ZvS2syQ1pQS1JjdVFLQVpCMysx?=
 =?utf-8?B?a0JabFFzcVVhdEl6NW9CSGlWL0NsWXA3K1NMUUg0aERQSUJGT2dMM2wrbEg5?=
 =?utf-8?B?a3RDejhHQUw3NTRTWUZBTU13dFg3UXlkY3owUUtJNDhhYTdKbFRHcXJDK2JU?=
 =?utf-8?B?RTdhbFMvWndicitwWWlWTzlTM1Btem1CUXFRTmVBa0JZaUhSVmhmZTRtUmZ2?=
 =?utf-8?B?dVVaSkJXdkVQUC9za25uSitsOVcyY0N4dXl5ODYxWFFKQ0xJV0xSZmxqamxr?=
 =?utf-8?B?NCs2R3d1R1BxaC94MUFzLzhrSksxVTlkQnBPaHRIZlRvOHpaeG1VYktZaGRs?=
 =?utf-8?B?cFdKNkpDQnZodmRsMjliY2lvWUphWTFKaHlBR3YwN2tUb25XeURHcjFyQmxi?=
 =?utf-8?B?czEzVWt4Q0s5cjI4M1dJRWkybExLY2x6TnNjeFJNWllHMWcvTDNXeWUrUEFy?=
 =?utf-8?B?cjVBTS9ETGpsTEJvbW1pMGp5WGI5UWlCdTNXUVExRmZaOEZyMUY4OHgvRHhW?=
 =?utf-8?B?blFoamh6Q1JpNFdYamRiQ0ZSZWZJTENWcmgraDdWeWltbW5naUhnVlEwc0hY?=
 =?utf-8?B?d2RYOExUWlZlWlM4RGJtUWpZRG1VOWdlTGZWZFlJV1ZOSmFVcGtDdWhvTnkr?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87209b50-21bb-40d6-00ae-08dc57cbe33b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:00:38.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DRAUV4r5i+f5N9nCrwn/sBujqZoQjQXR6Y0vuQuoWGUoShCodA0RA7o0BUQ464zphtvMGa6/ynrPjoFZtB1v82ZstdEIKSc8xNJw/PPMdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6929
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 13:00:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15502



On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
> This allows the creation of a swu file for delta update.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   classes/swupdate.bbclass                      | 32 ++++++++++++++-
>   .../images/swu/sw-description-delta.tmpl      | 39 +++++++++++++++++++
>   2 files changed, 70 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-core/images/swu/sw-description-delta.tmpl
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index e23261d..1c495da 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -26,10 +26,12 @@ SWU_EBG_UPDATE ?= ""
>   SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
>   SWU_BOOTLOADER ??= "ebg"
>   SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??= "${SWU_DESCRIPTION_FILE}-delta"
> +SWU_DELTA_UPDATE_ARTIFACT = "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
> +SWU_DELTA_UPDATE_ARTIFACT_TYPE = "delta_update${@get_swu_compression_type(d)}"
>   
>   SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
>   SWU_DESCRIPTION_FILE ?= "sw-description"
> -SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>   SWU_SIGNED ??= ""
>   SWU_SIGNATURE_EXT ?= "sig"
>   SWU_SIGNATURE_TYPE ?= "cms"
> @@ -37,6 +39,7 @@ SWU_SIGNATURE_TYPE ?= "cms"
>   SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>   
>   IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> +IMAGE_TYPEDEP:swu += "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if d.getVar('DELTA_UPDATE_TYPE') else ''}"
>   IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>   IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>   IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> @@ -44,8 +47,10 @@ IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SW
>   
>   IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
>   IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
> +IMAGE_SRC_URI:delta_update += "file://${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>   IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
>   IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
> +IMAGE_TEMPLATE_FILES:delta_update += "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>   IMAGE_TEMPLATE_VARS:swu = " \
>       SWU_ROOTFS_PARTITION_NAME \
>       TARGET_IMAGE_UUID \
> @@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
>       SWU_FILE_NODES \
>       SWU_BOOTLOADER_FILE_NODE \
>       SWU_SCRIPTS_NODE \
> +    SWU_DELTA_UPDATE_ARTIFACT \
> +    SWU_DELTA_UPDATE_PROPERTIES \
>       "
>   
>   # TARGET_IMAGE_UUID needs to be generated before completing the template
> @@ -148,6 +155,22 @@ python add_scripts_node() {
>       d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
>   }
>   
> +SWU_EXTEND_SW_DESCRIPTION += "add_swu_delta_update_properties"
> +python add_swu_delta_update_properties() {
> +    delta_type = d.getVar('DELTA_UPDATE_TYPE')
> +    swu_delta_update_properties = ""
> +    if delta_type == "rdiff":
> +        swu_delta_update_properties =  'chainhandler = "rdiff_image";'
> +    elif delta_type == "zchunk":
> +        zck_url = d.getVar('DELTA_ZCK_URL')
> +        swu_delta_update_properties = f"""
> +                        chainhandler = "delta";
> +                        url = "{zck_url}";
> +                        zckloglevel = "error";
> +        """
> +    d.setVar('SWU_DELTA_UPDATE_PROPERTIES', swu_delta_update_properties)
> +}
> +
>   # convert between swupdate compressor name and imagetype extension
>   def get_swu_compression_type(d):
>       swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
> @@ -167,13 +190,20 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
>   do_image_swu[depends] += "${PN}:do_transform_template"
>   do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>   do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
> +do_image_swu[cleandirs] += "${@ d.getVar("WORKDIR")+'/swu-delta' if d.getVar("DELTA_UPDATE_TYPE") else ''}"
You can always generate swu-delta and remove the rm -rf later.
>   do_image_swu[prefuncs] = "do_extend_sw_description"
>   IMAGE_CMD:swu() {
>       rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
> +    if [ -z "${DELTA_UPDATE_TYPE}" ]; then
> +        rm -rf ${WORKDIR}/swu-delta
> +    fi
>       cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>       if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' ]; then
>           cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>       fi
> +    if [ ! -z "${DELTA_UPDATE_TYPE}" ] && [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' ]; then
use `-n` instead of `! -z` - also do we need this guard we not copy the 
delta sw-description always to the swu-delta folder?
> +        cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
> +    fi
>   
>       for swu_file in "${WORKDIR}"/swu*; do
>           swu_file_base=$(basename $swu_file)
> diff --git a/recipes-core/images/swu/sw-description-delta.tmpl b/recipes-core/images/swu/sw-description-delta.tmpl
> new file mode 100644
> index 0000000..7f7d623
> --- /dev/null
> +++ b/recipes-core/images/swu/sw-description-delta.tmpl
> @@ -0,0 +1,39 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +software =
> +{
> +    version = "${SWU_VERSION}";
> +    name = "${SWU_NAME}";
> +    ${SWU_HW_COMPAT_NODE}
> +    images: ({
> +            filename = "${SWU_DELTA_UPDATE_ARTIFACT}";
> +            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
> +            type = "roundrobin";
> +            ${SWU_COMPRESSION_NODE}
> +            properties: {
> +                        subtype = "image";
> +                        configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
> +			${SWU_DELTA_UPDATE_PROPERTIES}
> +            };
> +            sha256 = "${SWU_DELTA_UPDATE_ARTIFACT}-sha256";
> +    });
> +    files: ({
> +            filename = "linux.efi";
> +            path = "linux.efi";
> +            type = "roundrobin";
> +            device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
> +            filesystem = "vfat";
> +            properties: {
> +                        subtype = "kernel";
> +            };
> +            sha256 = "linux.efi-sha256";
> +    }${SWU_FILE_NODES});
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15383): https://lists.cip-project.org/g/cip-dev/message/15383
> Mute This Topic: https://lists.cip-project.org/mt/105041878/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

