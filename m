Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969F1C7EE25
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:02:45 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web10.426.1686150154973510733
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:02:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Zpo0VeLl;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRqU9r8AZlYSffCKxm+6fxh0vzUXh0l8CYQ2mZHJ2fcp6m3pdZOkQ8OPDwLgrkHrtnEb0VleiXJCQ0kdCLZLIhNDfXfhz30TTnIHcBR97QpUpmSXyyPCeT5/5sB6qmBdB7gGzGYBVIK5sl26EbChPuaN+oKvzixSOrP7cT/3CjcyOgU4el+NH4tvnzQ/PzOLh/0nqK73O0C1JFIy0+Hrq3rHH0yFhB7Eu0LMcgQ8Y6QUUPcHnN4Ia5sk7mJbSGIsq6KbpaywjoqonpurHbFPnee72H9Bziw6Qhe8Tv2VberJe0w/jP6OfTVrNiDXLj57j0FjvDiEJY5T0a+fjjh7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP+ciAlyCkpDjw/tIe/lNVYAXpvgRc40sv0sX5JF8Nc=;
 b=ik8gSKgQdIiZxRYlH2Fo1pzIYJ/Siy5mmyB4h05KSyN8wHri9vLWWOTI6Gt1OG/BykglDaXxh0CbwRw1gWt/vCUMMrM0oiExZRencL1go1PdhFBL7fKLXpwR1lKvMp5KAGHsDGsPZqGdwJExg6kJxT/FT4D9DeOqm7xz1cY8TalTFLXJHC+BEvttEfbGxpf5p7JAVSqpJEQ8qiuQ22f2dsJpPyZEy036Jb64zdnaoMPIEwmSX8JW7PUYVJo9i3gVELtCd5NfacnM0b5WRWzLjApMgmwu1J6t/8QmNKcLlPyajpwjdluPxJVXsQljXpDu7YTFB+lP6N6stUMV5D2etg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP+ciAlyCkpDjw/tIe/lNVYAXpvgRc40sv0sX5JF8Nc=;
 b=Zpo0VeLlC9t0J+ba96/DEAbgM+GVlaWxuHsoKwu8/4XbVO26517N3A31b47p1fIOK2EAcF4X5PbNAoTQSzd7TNJFyDYQAP+Yn/TQfq70PRqQiNMSvOAAn8d38ccAM4Bom4HDmkRJjiAos830Cwjf3VFbxphx4lgS27WYie6onQo/fX5AtV+LmErCFzfAMhvId+pnrU9PGtdL0xY528qU4xz2E8jVYABM3DXQi0eeMdQpHStMIBjo11AivNGSmbYc87SbHLkAmG5j98kMAtwo92+9rZbVj8HsGdLVmYK7+uVWkTxX31bYb3strtAxY+Bl9WXr+lYTPI/U9kAGlv6YUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 15:02:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:02:31 +0000
Message-ID: <eb8930b1-2fee-1f0d-ba77-dd6db697da70@siemens.com>
Date: Wed, 7 Jun 2023 17:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH v2] IMAGE_TYPEDEP:swu: Don't depend on wic
Content-Language: en-US
To: Uladzimir Bely <ubely@ilbers.de>, cip-dev@lists.cip-project.org
References: <20230607121848.31306-1-ubely@ilbers.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230607121848.31306-1-ubely@ilbers.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fce718-bab0-4f59-aa3f-08db67683763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VoII2IvvLurgnYR15Fz553FxetmPPtleBdRohUDfuGnxpZjR3kRiMOwOIpAl3BCiNmIC/3Ua1YlqP6rvVymjhZaAU/SOT/pBXw/TqGbSMMjM7yGMsfWpgdozm3eG2bP5dcPbcOEFf7u3G3ZFRZPZY7IoX8zMPTeDSpbeHZ0yP02Mv5gStGmPBnUqpEldxKAVVAyjcoHp0BqMrtJS1fge2AXdME0oPLD6ByynP/tiMt3lwcmQnjM4kNOp27dd/qZvaw3fgzvVUCrE6of2bh6LIvdBPJXF5SujcQh2aeKVkeIhVZng9VPwkGZkeQ/nv/CnyZNHoWQN7KlLzSiidI5s1S4tRNs11XsjfT73Ln/37lqptp55pSyyVLwNGBhn/zaPcn65+A8ZYO1n7oUcQEsV3oKUKXsFWj2ESDa501YJ4lWr0zEjjQB20m1LubtLxm0zqeaPZNVdAHWEOR3r1d5Ysm7J7NsD6fLox01ur2rzD6KR9Tl7ZfuYtBMIXmNIO+IcBO7zkJdKm+g4D65K0aAS/nyvoDrjTRwBT7Bgczns7++m9zVnjyG8xz25xe6rNLL2Z6apbty8raMxyWcdDl7RTGQbC45pJICpzeE7rv5n8Win0mdQ/uVDCjcoKQIFMfmPOjL9xcuCvWD0zJYhuNCNRw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(83380400001)(478600001)(44832011)(82960400001)(8936002)(8676002)(316002)(66556008)(66476007)(5660300002)(31696002)(38100700002)(86362001)(41300700001)(66946007)(6666004)(2906002)(6486002)(36756003)(6512007)(53546011)(186003)(6506007)(26005)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?alArbTAveEJhbWFXNXBlUGlRS2kxMUVnNEJkQURybHJZdmc0cHpWb3ZTQzAz?=
 =?utf-8?B?eGF5ZjAwaXpDR2x6cW5aeU94SGhYMHVnTFFaL3prUnp1QjdPVkRUMC8wMHgr?=
 =?utf-8?B?RDNGcVRpeWdxSFYvMlkwVzhHb2hRQ0Fad1lXbHM3M2tOT1JZV3NLNWhFSi9S?=
 =?utf-8?B?M0krL05hUy9HNmxnUzlkZVZtWHpTVUwzWGMrYUNpSE1INXlmWHpaMDBydFlj?=
 =?utf-8?B?ZGpLaFcydWN6dEFNSFNnQ255R1VyREh0b2M3bzlHRVdLUHNPbXVzNXJRTlpa?=
 =?utf-8?B?YUtZa1dMRHUycG9IQ2lkZXJ3TkhiT2hzMXZZQkcwY2Nma0Z0eEswZXlMZFk3?=
 =?utf-8?B?QURPRm1uT1dwdHBNU3hLTTh1SmlZZ1RacVpmNjQxTU1vbWR5MG5BaDJIVXpp?=
 =?utf-8?B?N05SSCtReVhZWWZOclR0L3UwY3diMW9semFmNlBmNHU5cHltZnBEM1l2cTNF?=
 =?utf-8?B?eXJpVHdKLzhDdGRzYjFQWk1IUTd4K1o5aXEyUG1zNEorcGZyU3FoaktwVUhZ?=
 =?utf-8?B?YkFTZGxVVzFmc1JtbzJLaFltOFZqd3JCMjJVRmlYTmp5eVVOamJWSU1QWGhB?=
 =?utf-8?B?TVBlQkc0eTJkbEE3TFQvb2FEbFIwMjdEQWZPT2l4N0hGYVhpRW9ZZ1NRYjZD?=
 =?utf-8?B?THQxVllEekNhRC9vekdZNER1K3BIeExsaDl5NXRBbGFWNit5Yzk0QUY5aTVQ?=
 =?utf-8?B?TDZ4NGJaWmtBcVZJMXZFbUNSc2tnWC8veW5EdTZidVZNNEkrTWNkTmt6ZTV2?=
 =?utf-8?B?RDI1RE9CSGlrQmNDQ0JRVUZ6MlBELzFpYVl1ZXJTV0dYc3F4YVhGamNURVhZ?=
 =?utf-8?B?VzlXcGtPUWIySC82OUdrZ2hzc3pyOFpWYUdQaTY3dERkeG9vR2h1UTZwd3Rz?=
 =?utf-8?B?a3oxZk10czI0ZlJOK1hSTnp4VlNKSzZaV2hkaC94TzM3WjdSOGl4bUtobmZI?=
 =?utf-8?B?aHphWTNQZElGU0F3OGxpWlYwbGZWL0dIekhsZWhQQVB4R0lLMjRwbTVXVTZX?=
 =?utf-8?B?ZlJ5ZlhsZHkwN2haYlhuV3Z5cW15SHplOXorRnhyVmszTjUrZlRmQzdtMVZx?=
 =?utf-8?B?QWtJbE1EVWZwamFtMERSeDNXQU9GZVpXa2FrQllkRTVHWVo0VWZ2VjNXYlN6?=
 =?utf-8?B?U0xGY3cxM3hoOUFFZ0N5Mk1RVUE5YVdZYWJQNGtBUXhOSTI5dUlIWVpqLzB0?=
 =?utf-8?B?UThCR3l4T0ZVNXVMVFRWcnRCdzFmeGlNMnpsNG9lWlFKaXdnYU5OL3M4aDJz?=
 =?utf-8?B?M1djeFQ4UGphZ05DblgrTXBKSGJXdXJsZmVWMVlPbkJ0RDJrY0htK2hWQyt1?=
 =?utf-8?B?NEhiVmJNcEJ2U2ZQamFUVWpUQ21EYTBtdFB2MFVPcHZyOTVsOVh6aUV3Nzli?=
 =?utf-8?B?MXVkYTI3VXJLN0c5VGJWQUJGYUxFaFlydFBSUktFY0VCUXhjTGJXYlpMUnJ3?=
 =?utf-8?B?RkdXL21GL2lZUGE1am16dXVNRElJVnBlUHpQanczMVhQcHRtbFoxNEJtbzFG?=
 =?utf-8?B?TUEzMkhabFR2Q0dPTW51Y29QS0NlTWYyUEw1Q1NVZzFXcjM2cFoxbmtYb0hU?=
 =?utf-8?B?a0xaM21mSnlXVzlCY2RsNFBESVdrQU1KU1lXb2FBSGJNV1BOTWFPTkovcTRI?=
 =?utf-8?B?MGxlQWx3dXkxU25yVUlDdm53U25IRlJUcjFmV0xJVFAzdWRoOGg0OWFZYWdE?=
 =?utf-8?B?RkUzeXJVdy94TVdJcXpYMkxJSks4SXd3UWdkNXZNbXNIZEowWkw1UWYzWkFr?=
 =?utf-8?B?SHoyRmpqdVdyeGVtOXhmNEQvVmZPQzBlWGZwVi8yQjF2TnBOY2NwSklVOVdQ?=
 =?utf-8?B?aHRjeSt6bC9CbGphOGR5aDkvUjRFdmJCMlZ1YlJ3SHdWVjJvUFNUUkM1Y3U5?=
 =?utf-8?B?OU9BZEhDY0NOT1d2azdYRmlkR3BSR2tLMjUwYnBYQXAwL0dsSUpRVW9nalRB?=
 =?utf-8?B?cjdxWWpsUzdrOWQ4NnlhUjdPTGdvZDlxUElvRCtmR050S05TdzVjV2lmZHNF?=
 =?utf-8?B?Y3RLUDNTQWFPYWNhSk5QdUhRVmUvekc1YVA3cmR0N1J2MTF1YUpSZk5FR0FW?=
 =?utf-8?B?ZzJDTlpwUWJJR21xUXdLcGFheGREQThsb05jc0NxRTBvbkdsanlKRGswamNw?=
 =?utf-8?B?aTRQajhjNjNWM01NTVlBY0cxRmw2KzYwYkFzdjlyRVI2L1l0Y2hkMUYwclY2?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fce718-bab0-4f59-aa3f-08db67683763
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:02:30.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH8frMQ+g5BZ9OEyY8LDZJWpTdD8/a06Ze64XkSoLNyn0KMtgIXJpvmOCE05R7HpkLAM3d5MVSH+U3n5gT3TyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6658
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:02:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11919

On 07.06.23 14:18, Uladzimir Bely wrote:
> Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
> causes uncompressed '.wic' image left non-removed after the build
> finished. This is caused by indirect dependency on "wic" in swupdate
> bbclass that can't be overriden by the user in local.conf.
> 
> This patch removes this depencency. If the user want to use some wic
> partitions to be packed into .swu bundle, they could simply add
> directly append "wic" to IMAGE_FSTYPE and IMAGE_TYPEDEP:swu.
> 
> Similar thing is done for efibootguard-enabled images that require
> task 'do_image_wic' (that generates "linux.efi" in deploy directory)
> to be executed before the task 'do_image_swu' that uses this file.
> 
> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> ---
>  classes/swupdate.bbclass             | 2 +-
>  recipes-core/images/efibootguard.inc | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Changes since v1:
> - restored swu dependency from wic for efibootguard-enabled targets
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 6934c0f..ac59c00 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>  
>  SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>  
> -IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> +IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>  IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
>  IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index 604c9d7..e6824eb 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -14,3 +14,4 @@ WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
>  IMAGE_FSTYPES:append = " wic"
> +IMAGE_TYPEDEP:swu:append = " wic"

Thanks, applied. Let's see if CI stays green now ;)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


