Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2BCC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 12:38:47 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.59])
 by mx.groups.io with SMTP id smtpd.web10.27835.1704199117253952841
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 04:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u4eDEFmx;
 spf=pass (domain: siemens.com, ip: 40.107.13.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lebOJYpdbFoFcsAuCmkyhrBKJPJzj1gn9ybc4QMdnxe5qLiZtR7mYzQnTD11/3DqFrPRG0gu+ZHGzR1J3JUlaK/5yJcJ3NC/QhUbsTdFf59Y9gWdV8yQlMhWqFpi/FdKhiZ0fNbZdgHQrnp3t8ZxmnrU64qe72qQ5ihTMD4sQYnoWe0UaSPAetk51FQkAjcuoT4LL2+j3vEkoHC6eOf4n8fR5EMY2dcw7sdcH9MPRdnm6fyA042nB/mf+zEbAlys/lqWnddaTYDYAQ/MlwgV8/8fj0BPQSGeV1qvd+xE6Nmtoc9gyEk+JQD9/UHHdxvulP7hkYf/lTEqeMYRZxh4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIGST0vff3ULr1v2K3aGV7/5/+oLh20kYPtJXGaMzCc=;
 b=KMt84TkrQHX1c37EhgiHNgJwBsUziYGejUHnSo2pm6reEI+PU62LmHwC1QATvvlUyaQmdAz7AB+egFnmeM/k4dCPZpqeFEhlpOEJO8QcaFnodXR+aJkALBqV6VBrDYijZm34V+UrbAYDFbv9vzCNhMWUclW20jIA3WFWFnc0iNUmq2jkorJMcdfij/9HmLz5LAqdaFo2o1Zj7JAZooiOwfiPI67AxYVyYQyB/QsxT5QhsKBuZa+VYtzlX0svp36rNPL4/wdqxVKb0KojqXctLGHNDoiBw1aNAPw1WFIlfb7IuMUMmGLVVWVJWC8EcqyqppanL5zmQdXbd/g2IVn9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIGST0vff3ULr1v2K3aGV7/5/+oLh20kYPtJXGaMzCc=;
 b=u4eDEFmxw+i3ypEvP4H+jTHWSHFHDxHlmRhp3wFfEXOs9AE9YWw2AwyWXWkNqBaFm2yfoiQwGrSvBCQQYj4JskwUd25Fju1PVEmwODRRxXDAc01un6I3E3qZO7jG+RRPP/aDSGMayX78uiOgM+lrtQsdYKklmWT44D906tbAP/XVgwqF3F11Lmv9BGaCQeSthTB2xRm1x7L/+Npk3i5XcQ4ljsoq2ev8idue22lpjFdr9LmeGIRWC1bQtmSvpU55Lg3jFUd60yM0T8MQv6q4efO0LZ+/ZYgbWbtP0ojE0JG7laFTDduHldOuX6GUDldy6uGTp/LLBYuShg4nw15Chg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:38:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:38:33 +0000
Message-ID: <9a87e572-5353-47ba-a031-22c91d08d67d@siemens.com>
Date: Tue, 2 Jan 2024 13:38:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v3 3/5] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
 <20231229123111.400555-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231229123111.400555-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3881:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f8d295-224f-4ec5-e0ed-08dc0b8fbb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MEpBDolzpTvA2jAZPeGa7nm1FDcMyMChVpyp+Lv1iqxYZimaWnaDYka6lpbMIupx9BYH3DQXSn4ExJG+c47rVm0S8Qfbja6bzBrCprPLxBLX88NAxkdxnEA8J9Q69a9wl0GWsS1r3SjGIyklnpSOTqwWNZyv0SrMIda9S20jazM203AYL1XdH620yX7P0/63sPlmsN4eQtGInxM5ZvueF7QBs5ZHlDqctHngmyLzMy88RftwlG27jVN3HxDkDZmDzzovQl7qFTe4BXNS7753f0/7PshstqnzQjKcmKtmkwveORb4oxSNYyw0uM4FxU6HmvJ8xhG2PAYB5SbL+5AHxLma8fkxQX7MTKcyOBVhhMEREC/YZ6UlsRvhNRq787xnerk4+tcyvBKDKvutWBzJe6MDuQkzHBNOcGsudN5vOUJAqiWNRm7BZh5f75tJIm61JJu1+H46cEYH1yAYw3rbAPY5a7D0sm+qnefCRJE92qhSSSd52XZYqXxkIdphyuawfBHSJvOkklxQRQQDOYKlymLrX8Mf8VltV/CbIXdLMJ6H3codPsjgnDpd6JRPH7ERMGVRxcSJmOgNG5YNJXCH8C9riZsBckBTGcnIt2r5JSYevJiOpK7UwSLDI4jQuSf0ujFGc0rEC0CmUEJmDiE1+qNwqYpoNUkL9zj3KbhDWmE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(15650500001)(38100700002)(82960400001)(8676002)(8936002)(5660300002)(316002)(2906002)(478600001)(44832011)(966005)(6506007)(6512007)(53546011)(66946007)(66556008)(6486002)(66476007)(31696002)(86362001)(36756003)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHZ2dDlxL0Fwem1ZNkZ1SXdOcHpMK0tNSjVndWJac3ErcVhYZXhmenpnSlZR?=
 =?utf-8?B?anFnVVpJZDdKdFhXSStRNW9OMkZGRUtJSy9MaXpuY1pBZitqa2wzNSs3aGJo?=
 =?utf-8?B?bnBPbzVHWGE2SytWR3MxRmFGWVRlajRNRHo3YnpZOXNnQmhWVG13czBPaFdH?=
 =?utf-8?B?bUMvd3BBcjdlY1c1T0ZkYTJWWUxrZ2ZmcENLU1VyUEtTS0xZMUhGLzVYUGpa?=
 =?utf-8?B?U1ptd3VqV0JPNlIwRjRLSFVTcWtGaWpCNTBZZk5aaEJZSEhkUnlYc3pkWmZQ?=
 =?utf-8?B?L0drRVVvSEgrTVNJZUNmUkw3YTJBeGs4clBsSU5ZbnhUcmJwanZQY3ZOSkJB?=
 =?utf-8?B?S25HZ1hQU1FvMXhkdDVVSmVaVHJLcVZZRFpUcFc5TktHZmJKTG9NZDl6cTd6?=
 =?utf-8?B?a0hFakoyeHJ5WUhIaWJxMUI3cXJBOWtrS0o4bTdoMDdSSVAvOG1ua2pQcnFX?=
 =?utf-8?B?d251Z3MzMHJmSlFZeFB0VzNFUThSQldIOWZrenJlV2xkQ2NranZCWmJmV2U2?=
 =?utf-8?B?bkcrbXpTdk1UTTZxaEl5dENEL1BZMWxYcis2UXMrK1ZGaERJTER6d2FSVGJz?=
 =?utf-8?B?MnNyZU1ocSs4YVpEYjVDalBmTFpnK1J0R2hsZW56MkhCMjJhV1pzanllNUVF?=
 =?utf-8?B?RUlkN1RJdWZlRmZtT1k4bGZHOVhubDlUdUN3MTd6am9jWThnWGNFMTVYNEJ2?=
 =?utf-8?B?SWFNQWZMclhlaFpCOUttN2kzQ3JBL0o0enc0bkIvdkMvb2trQXJFYjM4QnZV?=
 =?utf-8?B?SEJVRi9JUmZnWUtKWXpsejFpVDZzL3JBeGN6dkdxNTlIcFVoVTFyaCtqNURl?=
 =?utf-8?B?NDhXSTZhdVVuYm9HZUU4TmdoTW4xOG5UNTdzS3hhSEU4T3FaRkwvbXZwcWls?=
 =?utf-8?B?dTliWlhvMVVkMmVkdmw2b2p6SlpHV290VyswVlNCNEpMMWhtYXVhN3NDbWtS?=
 =?utf-8?B?cm5nTUwrQzJVVmsweVlRblpwdHpLaHdjaFZUUVBpWUJ6K2tqSzZrUy94Qmc1?=
 =?utf-8?B?UTFXSjBveDdTQ2V3ZHFObzRLNGhSZkVSUnQyTEtDOHZZR3pkdW5vYlJUYm9w?=
 =?utf-8?B?aU5zZmZudVQzWXM2SFlidm5JY1pEWFpNNHdsaDg4QlplT3BmKzNETFRkWUcv?=
 =?utf-8?B?K0RFVEpzZWllcUR3ZGRWWTVONGRHQkFBZkJ2UW56bnFXMnNMREFKY3FLMHlE?=
 =?utf-8?B?b3Z1WDlUZjh6QStiMUx4K3JZZGpRYXpNMGNLa2ovMXFWa2c4a1hIcitJcEQ2?=
 =?utf-8?B?OE8vcFNBTDNJZlBrVFJ2VEdCeUZXN3M1WTk5Zm5DRmw5dVhTdXVia2VGbHRr?=
 =?utf-8?B?WXF4SkVsam4xclVtZlhoUmdpRTRDNzh3VTVFalloKzJOQm5XeXB4d2s2S3BY?=
 =?utf-8?B?UDZ4YVN1ZTRNMk16WThQWnpyUnpHWnlGWTZURmtXZ2Z2N0srbUdnbjZrcmJR?=
 =?utf-8?B?NDhBcW1jVzFtQm5meVhzU2szTnAxTENuYkNtQjVNREdyMmNlVEJhbVE0MHZB?=
 =?utf-8?B?M2E2WkROV2VUVkVxdlI1V0k3RC9EZnAyeFFnZDh5dEQwd2Qra09QWUcwSGRH?=
 =?utf-8?B?RWdmanhpS0p5b0NKc3ZZZUIrQjFrcGVNcVJEVzVMRnhaU2FZL2VERGtUZUdW?=
 =?utf-8?B?MEhoa2dYVEtLSWt6a3IxSFdsRkFpYjU0NnFsZjhSaGhjaFRyU1ZTTW5uc3Nx?=
 =?utf-8?B?QjJZTXFBU0hOZXVmVytqMVIwbDM4REZOTjVQa2RmbDlKaURJaWZRY1YxYzBY?=
 =?utf-8?B?NGFwL044T0owbEdFZVlac3ZWRU8yUWhPWGdTdXZBd0FLb0NOZVZOVHZvdVNS?=
 =?utf-8?B?eGJtWUFxMFhMK1kyazJxR1JXaG5zQ0RDV3h0aFU4YXF3UldZcytBbkpNakRy?=
 =?utf-8?B?MExQWkhwZW9iRE5yRGNBRUhHT0ZUN3FiakVnWGFWOFlhOW5iZWdUMUxBK1cy?=
 =?utf-8?B?bmp3RmswYVI1SFE3YU9CYXhYRzdFSkZzRTRCVVpGZXhMZnRTYU9zZzIweFNj?=
 =?utf-8?B?OTlYeTZjelRhdmE2dHdWNmVHa0N1WnJzTjg1UmpoRXg4VmNSaWRZS09iYzk2?=
 =?utf-8?B?NitUQUtHTkFWWVRUR2UzNHQ0TVZBaHdYOVFOT3ViY1hpdnhiRHFLSk14bEZY?=
 =?utf-8?B?d0pyeEIzNEZ4NHA0V3hjaUlIWXBnY1VLZUpGMnNCZ1k5bVRubGxIa0FpV1du?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f8d295-224f-4ec5-e0ed-08dc0b8fbb7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:38:33.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIK6iPkXeei2nqLe61JVeZdLasYbwp0mlWjl0NPzrfNk8qI5CcqD78KIW3ZuaCNr+P5gUOmoKkzWilmCJSnmkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 12:38:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14226

On 29.12.23 13:30, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
> element is added to the sw-description to replace the ebg.
> 
> Use python as newlines are part of the sw-description syntax an
> therefore cannot be hold in a bitbake variable, see note in[1].
> 
> The efibootguard binary has the property 'atomic-install' which
> copies the file to a tempory location before replacing the original with
> new file[2].
> 
> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
> support atomic writes or renames so a powercut can still corrupt the
> system[3].
> 
> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
> [2]: https://sbabic.github.io/swupdate/sw-description.html#files
> [3]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass                    | 39 ++++++++++++++++++++-
>  recipes-core/images/swu/sw-description.tmpl |  2 +-
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index dfe8ef1..f9dab33 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -22,6 +22,9 @@ SWU_NAME ?= "cip software update"
>  # space separated list of supported hw. Leave empty to leave out
>  SWU_HW_COMPAT ?= ""
>  
> +SWU_EBG_UPDATE ?= ""
> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
> +
>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
>  SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
> @@ -47,7 +50,21 @@ IMAGE_TEMPLATE_VARS:swu = " \
>      SWU_HW_COMPAT_NODE \
>      SWU_COMPRESSION_NODE \
>      SWU_VERSION \
> -    SWU_NAME"
> +    SWU_NAME \
> +    SWU_FILE_NODES \
> +    "
> +
> +# Add the bootloader file
> +def efi_bootloader_name(d):
> +    distro_arch = d.getVar('DISTRO_ARCH')
> +    distro_to_efi_arch = {
> +            "amd64": "x64",
> +            "arm64": "aa64",
> +            "armhf": "arm",
> +            "i386": "ia32",
> +            "riscv64": "riscv64"
> +    }

That's now the third time we have this mapping in our code. Maybe worth
the think about having it only once?

> +    return "boot{}.efi".format(distro_to_efi_arch[distro_arch])
>  
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask do_transform_template after do_generate_image_uuid
> @@ -83,6 +100,26 @@ python add_swu_compression(){
>          d.setVar('SWU_COMPRESSION_NODE', '')
>  }
>  
> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
> +python add_ebg_update(){
> +   efi_boot_loader_file = efi_bootloader_name(d)
> +   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> +   swu_ebg_update_node = f""",
> +   {{
> +          filename = "{efi_boot_loader_file}";
> +          path = "EFI/BOOT/{efi_boot_loader_file}";
> +          device = "{efi_boot_device}";
> +          filesystem = "vfat";
> +          sha256 = "{efi_boot_loader_file}-sha256";
> +          properties: {{
> +               atomic-install = "true";
> +          }};
> +   }}
> +   """
> +   d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
> +   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
> +}

I still wonder if the EBG update shouldn't simply be a separate SWU,
thus there would be also no need to perform any append operations on
existing ones.

> +
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


