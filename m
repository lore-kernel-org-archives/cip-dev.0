Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBBC46CC5
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 13:45:23 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.78])
 by mx.groups.io with SMTP id smtpd.web10.8485.1702302314069533656
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 05:45:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uFat5rcZ;
 spf=pass (domain: siemens.com, ip: 40.107.6.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoYq+OOS9nOlnUFiP9UvJ/A441hliFA4HupZcdSBEuO/xhE3tVrP9/58zE10KhkxDBCgVzgDYXT1ou9NaNMawMin1xuIMT62RxNxtvqy7DZ9J0dMvx8K/ahfnBjSpYL1WAzFy84A5/w8C0EBj7JkTN5HKxx+fPbi9MENi7NQpWzj+INnjBQbzctF2wWy31RQGN7fv3VCtIQI1/tEeUXjf6vT4qmJzZLN8vJ/WXYvLzap6TIhUSWD+JQqvPZ1jO6U7Bdzyk3uRGpoxzKtmY00da2dTo/RYDUAGNnSMGT5hB6XamGqFFHly+cjAAFS6epRmIUrnbW6aucambpnUXiiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0tiKCwQj21Lw5GNe5hhJFyXjlqI7hmnc7p3/NGPdEo=;
 b=dHhgPhcoeymcRHO1noiN2+sGxGtLd+l+ZUILHSAAdLLkGY3vZwqvgrR4HUhrf8AnWJazNJyNG781rY/6vDWRl/k0PEmrUlSZMAWqk68YyEtSoltARo/S25IU1FHrIeTdbV9LPzPEOreyKww3rEbATDuqk2brwhRlEsaWt3UPJSw5smFNWr106vmG1lfQlTU0/Jk4leZnXdLBm3jGNq2As0UiuhIrZ266FGd5QBGLZfsocs4yR51Kx4XcteJIvTmS22REr7numO5DUUVBlLLmNXFk3k97A1XZGfmj5FCcR28ADs6sbbibfxGCviNKWKABXdmd4bvztjlV4f44BxQ4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0tiKCwQj21Lw5GNe5hhJFyXjlqI7hmnc7p3/NGPdEo=;
 b=uFat5rcZmP2gl32xTJku+PZu1iOc9M3moC8Z0CF23H5x6GmrhGv93/0U3U165S0ZRCQYBCcSdlOAixuMzROtbMOo+FIGcSGjcNq8nEoceAsfGw4UjGGJjtaOcNGvrdUZfbhpQDfpgkYSTHP6+pUnykmqE6U3zttbhz4T8SBs7YSjUmdGbtSWawGEQGCyZdCl6ZnUG/3TJ818KeZMmDnBT0NQW/zPm5Hbk7fpDIstWkyfLZwm6snPAu7idy8sdLU/CFFkRI1A+RFWpNOmllmPRp/sJpZbAx4toSrBqehmegsntxSTJtIu2EiKS1n2vo5uTJ235qJeDWxLvGV2yzb+YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:45:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:45:09 +0000
Message-ID: <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
Date: Mon, 11 Dec 2023 14:45:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5db508-445d-4372-0d72-08dbfa4f6461
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f5hcyGJFjp/+xNI0GpZ4YxUwGOD7tFYs/43ArB/bHhrSYTTZvlQlnClSaAnsWBJR9nf5W2OJ1Ncy8k/OzciD4XSP7ifC0Mid9u7FHvFVAPCTp1rHd7HpTFYkmmy9hC0qlwmsTIKDSM+sclFGB88e0iGLoOVdMCuP7SNtyN3jpLLMgYVdhcFGPnCFwAKUf27tewyCE5CQ0uWOXHRUb6uieYFROAqh1P8ShDSwRsiBkp6UHMdBm8PpMX7Ua4sKpIh33vG5QHfe5ZCZIiHDVOpAImExbrvm8bER4qRQeNOKpa/AXGCyV+kM4pWNVF7S9qZY5p/DgGtQXXXtbsp6VliRVxs2XeX7wK3CO1Ic2Phm2EWQ+dASThy82ZDscT9ksidgum543819rGkVgWvVgbTPR/SMGIH/XzfJN+MwhGmyO3aFd8RqUqi0pw8IRp0VtJ9y2+HOC0dEzt6XoZkLAuC/vQRXT/uCZ3M2ArR17UKtbWf4FVtfni3v7SjqorVvVUb52qYzzdlzoq88UdpcrU6wCLa5JqM5pwnEbf/mJhaJqR8aDjBgY4Jopcyifq3VqZ2xq9oMZPmAgOHPLPywlZm0kpZ9NTi2LdDxYFUMUEt6ijwHBh/QQXRsa9uG9x4YkX8kkQHqtyRGdm6jMU46cDzfQLhoVjq75q7E0Fk4QjsCkPM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(15650500001)(2906002)(41300700001)(38100700002)(31696002)(36756003)(86362001)(82960400001)(2616005)(6512007)(26005)(478600001)(53546011)(6486002)(83380400001)(6506007)(966005)(5660300002)(44832011)(316002)(66556008)(66476007)(66946007)(8676002)(8936002)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1pPMm45Q2JIa2tWaVgyQ3MvNW1vcG9oeUo4VElyNld3MEJRcjBrSi9HWUsw?=
 =?utf-8?B?NitLbnJWcGx3UVk3cFRZZkxrS1ppQURhWmR2Zk9WY3FsdjBlRXFFbFR2UGdL?=
 =?utf-8?B?VVlTN1ZKQmh6RGZ5RkpnbjdtK0xRWXpuSE5lWTVzeS9jMDdyYzc2VkF5dzNJ?=
 =?utf-8?B?Tm9kN091MXBvcUp4VFZtWjdkOFI3dkNVNlpoS00vOFM5WUJQY29QNkpQYitr?=
 =?utf-8?B?dE1OZDYxZU1wTUlsbzhnZDBNU1cyMFZCVUhDNFFjOTd3ODZNVzRzd3RjZXgx?=
 =?utf-8?B?OWFtbjB1S3NJQmxDUml1SW0rTHdQUjNMUzZwYUdtRWdNWFJuRVN6bFdpVUtI?=
 =?utf-8?B?N2hwL0M1cWxkcUdYbm9lbVUyYzYvNno4M0ZyMjVKTDhUUCtDNzRveGYyTFhT?=
 =?utf-8?B?V05zaU90REpucmVlM09TVUkzOGpxSGNLSDQzaDA4RjR1TTNnK2hHUHIzeTgv?=
 =?utf-8?B?aDd2aFVmVlVXQ0pFVWpQT3BiY3ZKcTdwM2NSY245eTEvcjcwTDd5b1dySU5x?=
 =?utf-8?B?MmhHVFZ2RzhTdG9DejlvY1p6RFZKdzVRd0hVWU0zSUZmSFlQR3RoTGo0bG00?=
 =?utf-8?B?STRoSnhxeXFTT1RsdG9zbmxGaU96bk80eVBWcDR3emdhbk9Ca1I3MHVkVkNo?=
 =?utf-8?B?eVB1RkY4UVFCQ2NmcmQwclZFb2dncUUvYUw1QmZmckkxWmJHTzNQeUtWTGxj?=
 =?utf-8?B?bStmWlBCYi9vbGhvNTJSZVd5ZUw0MzBZTEVHUUdtRndYeXBpRzFwUTEyN0U3?=
 =?utf-8?B?anJ0VzBJcGdFZ0pZN1BTTnpFK2kzS3Z2RTdTTzdWZkZudysyQ3htZU9IMDQx?=
 =?utf-8?B?c3FTK2dMazFKa3ZvbTRnNWU1emJlV2tWSFVZalRKNGxJQ2hNZmVEYnV4TDlU?=
 =?utf-8?B?aWRkd0xnM0kyb1o4eU0zMjlkYWx0STNaR1llT2JzUjVyelFEanRYRkJGeWEr?=
 =?utf-8?B?Z2VNOTBHSVJOd2FuZ2wxRVRFWDBOelZQeCtOTHBiRFEwdUpSblJjMUJyVkNY?=
 =?utf-8?B?dkJHdGpsVG40VWo4cG5DYzNhUWRyTVkvK0NHWnZORFA4dXNNTVFBRTBFc2dX?=
 =?utf-8?B?dERQSG5sNjhYNW1MeEl2QjNhZDVOMnpIdlVnamtpc0xLRDJqS2RGNkVZL1J3?=
 =?utf-8?B?eW5aWWFKQnJ5dDFhNXdsWkxVK1lsZnFxVVMxVUhYMHB3U0xENVBIdGc1WFhV?=
 =?utf-8?B?WDZ1SHA0blJYWXVCVUVmcjBoV1VHMU53Q1kvRWNUU09mUHZtRnRXQ3FaTFd6?=
 =?utf-8?B?ZFpGM3dHS0E5VTFTeVlWU1ZXYktuSjNOWWIxNHdNYmQ4TXppaDVJU09nZEJz?=
 =?utf-8?B?ZlVhVWV2cGErZ3c5SFo3QThuTW5EaWdLMGhkMHVlVmEyWlpzL0VLN3NuRU4z?=
 =?utf-8?B?L2JrbytjK0lMN3UzV3IwYmZKc2YzcTBwTlJBREttbS9sQUtFUXJucVBMbnNw?=
 =?utf-8?B?UGkreEo4TjN6bWM0bnM1eTNqbm53ZnVXMTZodDhYUzBBK2lqWjg3VGQybUJa?=
 =?utf-8?B?R0hQWCthNWs2aDlzelpGcklGWktEOWloMEptQ1lnWnBrbVZxQm1Vb2pka0FL?=
 =?utf-8?B?empXbUwwOVRudHZxWjVOMUFBUWlPMFdRLzdtazRMY3ZQeVU4OUZhY0tCdFh2?=
 =?utf-8?B?M2QrSmkyTHJ5cDdvamQvYnJhWVFBL3ZVM3ZZMHNzVzUrOFBVNVU4UVh0ekxZ?=
 =?utf-8?B?aU93d3l4dXJ5MzM5RnFSalhwSnZ6QlE2QW5SMERwdnZWS3VzSDJRSzBBUTNF?=
 =?utf-8?B?ZERhaGlLSGl1eXVzeDZaL2ZCbGRPQ0czZjFCNkhKaFhlNEUrakFYZEE5bnlV?=
 =?utf-8?B?dWpyU0Vzb2djUytiNnNUWk8zNmlMTU1wQTMxYW9RKzBWN2NaaXNSTTFNL1E1?=
 =?utf-8?B?dmdiMjQwdGhIVFhhMEJwQUxXTEZKQVF3WVg3VDhCZDlsaEZpOUNhTjF1emtx?=
 =?utf-8?B?YjBhSTJzelh0VnhpRjEzamI4azY3QzV5R1I1Z0h3Z3hLb1dLZkFta2lMcmt4?=
 =?utf-8?B?OEpWTmlETThLZ1pJajZrZHlKanBtU3BlZmVpZTlNQmhZWmZ6MGlkVk5aanBN?=
 =?utf-8?B?cWlmMjYvdkRmSks1KzIxUVhLQ1FPMWtWMjlmMEU0MlZ1WDV3UnpTMmdxT25E?=
 =?utf-8?B?ZDd3aDZVMjUxeGpFTXpSQVp6U1JMQzVSd3FzUUJNV296MXgvMkFqaHlDNWFs?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5db508-445d-4372-0d72-08dbfa4f6461
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:45:09.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPeaYTgBxO3JAv41LGB/9lNqXrlr1kc4UEnQe62aXD/WddrfNznsG4lf+UmiSXMuft9WrG8Y6wb6nDb69ZsaVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 13:45:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14023

On 11.12.23 13:19, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
> element is added to the sw-description to replace the ebg.
> 
> Use python as newlines are part of the sw-description syntax an
> therefore cannot be hold in a bitbake variable, see note in[1].
> 
> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
> support atomic writes or renames so a powercut can still corrupt the
> system[1].

"system[2]".

But you are not implementing option B described there, just the even
more risky option C. Doing flushes before the renaming and after it
should reduce - though not eliminate - the corruption window.

> 
> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
> [2]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass                    | 35 +++++++++++++++++++--
>  recipes-core/images/swu/sw-description.tmpl |  2 +-
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 0e95e3c..99a4c6f 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -21,7 +21,8 @@ SWU_VERSION ?= "0.2"
>  SWU_NAME ?= "cip software update"
>  # space separated list of supported hw. Leave empty to leave out
>  SWU_HW_COMPAT ?= ""
> -
> +SWU_EBG_UPDATE ?= ""
> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
>  
>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
> @@ -48,7 +49,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_HW_COMPAT_NODE \
>      SWU_COMPRESSION_NODE \
>      SWU_VERSION \
> -    SWU_NAME"
> +    SWU_NAME \
> +    SWU_FILE_NODES \
> +    "
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask do_transform_template after do_generate_image_uuid
> @@ -84,6 +87,34 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
> +python add_ebg_update(){
> +    distro_arch = d.getVar('DISTRO_ARCH')
> +    distro_to_efi_arch = {
> +            "amd64": "x64",
> +            "arm64": "aa64",
> +            "armhf": "arm",
> +            "i386": "ia32",
> +            "riscv64": "riscv64"
> +    }
> +    efi_boot_loader_file = "boot{}.efi".format(distro_to_efi_arch[distro_arch])
> +    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> +    swu_ebg_update_node = f""",
> +    {{
> +           filename = "{efi_boot_loader_file}";
> +           path = "EFI/BOOT/{efi_boot_loader_file}";
> +           device = "{efi_boot_device}";
> +           filesystem = "vfat";
> +           sha256 = "{efi_boot_loader_file}-sha256";
> +           properties: {{
> +                atomic-install = true;
> +           }};
> +    }}
> +    """
> +    d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
> +    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
> +}
> +

Unneeded newline here.

>  
>  # convert between swupdate compressor name and imagetype extension
>  def get_swu_compression_type(d):
> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> index 6b53a3c..c52372c 100644
> --- a/recipes-core/images/swu/sw-description.tmpl
> +++ b/recipes-core/images/swu/sw-description.tmpl
> @@ -34,5 +34,5 @@ software =
>                          subtype = "kernel";
>              };
>              sha256 = "linux.efi-sha256";
> -    });
> +    }${SWU_FILE_NODES});
>  }

Jan

-- 
Siemens AG, Technology
Linux Expert Center


