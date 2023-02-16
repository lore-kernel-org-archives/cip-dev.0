Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6ADC61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 09:21:18 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.42])
 by mx.groups.io with SMTP id smtpd.web10.6214.1676539273017704224
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Feb 2023 01:21:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GFL3ZqZV;
 spf=pass (domain: siemens.com, ip: 40.107.7.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eee0HhYex8iJAsgdjnBEjYRGyxbj1UsT2mjDLniq/QekO/XXD2GfL11PHxaK1P6+a3jOacWiI59yS4tHixG++EE8CT0Aec/R7Icrv2Ge2O+FmIjg73hzyDyDZSBj83TUUsaiF700ga4juGR+fIpKBWfEZTXluxbD5G74aCDW9cJznwEJZTf/frKlRN1QL4PK+dH7v9R4JkCZS6XCfMTfEw7zAXmtzwpkY3qv6nZ2GbsQyuCPxYP0m85ChuiDHDOrfCXhdCF1DusyIKcCTYzQptmG2xTABcAhIDLkiZyiVqPE+6fqT4FajoSP2WoV5LOguZPI/0NPBxtpg/LgXeDGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZyFuI8bnn3cKwHKUnD6klyweYSbOcT8IKoNlHtA2EM=;
 b=CLPobw9yOwvlfSDHpHlwA1dGF6OIS6VMnUrrRxFTYp1qpawwLhx7TRJQh40Rikq10TZxrJg4wK4gWlcFB8QJxXa+mT3e1dZ9g2n8znmVWZg+j96mjQastkYMzfzdt3aXKxNjYsDN6UkvHy2GuCGtdm8HAWoMOV79kbzj7Qms7Oqd3p+8S+EKMplLR/YU7hylx2eshcEAJMBnpDvkTz43sCCtTi+/gC5mjTj+6zaFAkVUKxABUrmmw1fB6+MZYUzyq+Yc35F+JNipQiJMzII8kXiY0jKTZCIGFfqKmZuUQcZaQM5k5DdSTuiUaXZCu8/QmSktBQx7bQN4dAoPVM2mFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZyFuI8bnn3cKwHKUnD6klyweYSbOcT8IKoNlHtA2EM=;
 b=GFL3ZqZVmqv79JFuS2nC7IqIvCGZAeYkmpMDSAaGX6iAfPAiWJe0lrv6pMMD2HwHj01hs8TB8li8U4V/Zhdpr7mXFzanv0/chRVDvcuE0cG6knlPQEQS6dQxO/jPELXYirENeXJDdonPw+7AhR/cJ+B6sEM/ntjzw0rSPHI0xZ+bFov1e1QajO3ciBUH492cSWsy6G3YT2i/VT0g586APVoTk6GggigbMtJfZ3MZaz6VzzosI0lVI9cNDsuLf+71rahQZgao0TJw1gWHCy56nyCqGACK0FOucqdt+brZCscdWyrxmGRThZeQ5P3RNmbC5kMEUuIC8osmbNv0BzdfmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 09:21:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:21:09 +0000
Message-ID: <f6aa64d1-a9b0-7aef-7824-07a9a82c243b@siemens.com>
Date: Thu, 16 Feb 2023 10:21:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v5 2/8] refactor: use imagetypes for swu
 generation
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com, quirin.gylstorff@siemens.com
References: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
 <20230216033544.1990604-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230216033544.1990604-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bd665d-94b7-4b15-121f-08db0fff2368
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Vn8iVjQPVi26m9q1S0adFmgQLHUV+zJCl8+nDuLMNOuJzNPY9dcarHTd7n72CYN594lh/bbbPYFwG4CYvMgtT79s1sS1dDg3BSMwtqCcEWuFxZBjDdAhbVPZT0TCuM2YDkiUxL0SYi1Vn5KTiWZYCkQk+kAk+qKdVKEVVnyl4qsA9wvMLLNXWP9LnAfv7TF1itpkUBtyGQLGllDy9Mru3PHbntMyrShqpy4QGPjUccMp3inyjB/YzsMLo93ljM8nHkvg3Mvj8PA4vLnNnnE9jM5UgfiQyBjayVKMoL3Mrd0N00Mj2x8fd9XcCP3uPq9DrAf9JhLLPsB97N5MnKrwftZg4KaQn2UkG4P1zx8j1jRpOQYbQvanJzZHTtJHlH80q5DVe1fiXrvCcjuKWsmDA6kAEhfxTYVElmq8xspyOyRxM2ueUSXoEc3mFp5F5F0cxNj9IUnUSHhBhUWUVoOMB29ZWxzpE5Lq3+/erYGn0kR+/utfJM4Lw2KVpzu2DA0WqUy2QksTab5NS6RlZgOf4orBF/nQuB0p7oXr/E/93yubajAC93gdVBad+tU0TaJC0LA7cQ7cTOu0HlsxvZ6WwHhKIRZKo2EJxyk9yDW/puPgLlPfOB4eYyfuvhulL1Kg422fc8mrjV74jMqb8M1/nwxNHT5UkSZ80K/8i9rXD3yH/81SwSLa45RuzzcZab2iMwaVHN0sFEF007g7wshflBVX2I6OgqTpmdqBCYTPEL6jX47fhO5/K7X0gsHnGs09Sz36ANakyHu/pmtz/S+EtQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(38100700002)(86362001)(31696002)(4326008)(82960400001)(66476007)(66946007)(316002)(41300700001)(66556008)(2906002)(8676002)(8936002)(44832011)(6486002)(5660300002)(83380400001)(478600001)(186003)(26005)(6506007)(107886003)(6512007)(53546011)(36756003)(6666004)(2616005)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmVCVUdxcG5wRWpQdlIwUWlrQ1FTb21POWd0RHo1VlROaGZidk85OHBpLzlQ?=
 =?utf-8?B?MlpoZ2k3U3g3T0NiaHV1QjVVNUVXcnJnZStzZnFobFRSZmJYdFlrWnRJZ1NY?=
 =?utf-8?B?Q2N4ZVorTnl6eVhTRm9CVDJZdUdKdlRWeU5XRkJ4TXJUS0tmNEVzTGFRSEhD?=
 =?utf-8?B?Vis4dEx1WXVzc01wNWpBcVNrN2JlVHgxMkpYbVhlSWY0ODRmU0dseXVXeHRk?=
 =?utf-8?B?TFBIbmhnS2lLK2dEZEc1UmgrQ2M5YXVMekZ2M29WbDRhNVYzRTJndk5sSzRI?=
 =?utf-8?B?R1ZhMzJlWTFvVHVRTjJZWlI4eUhydU4xUVppa0FpYUhHOVl6MGt3emxheTNi?=
 =?utf-8?B?elMyUGx6T0hLQnZTeC95MStvNGRUWHU3bFRCbTlxYVM2VGR5cjRlQ3ZMSi9E?=
 =?utf-8?B?ODNjc0Z5S2ZDQXFONjB6emU1ak1JNjJoSWxPd1dna090R1l1Y080NWxmUy9r?=
 =?utf-8?B?Ris5Zjl4dXV5TXN5ZndYU29lSzY1N2twd3pLUksvQ0NBZm9LQjB2TUJ5a1Vx?=
 =?utf-8?B?ZWM2Sm9iaDFSR281OVVxY1RYM2ExMlFEYnBmNXNFYlJiS3FqNlRzSnMrZnZR?=
 =?utf-8?B?Q2V1Tk9lZ0FxeExWZFJqZVpickUrVm1OSVRRcnFubzV1b0U2VURVSjN2ZVJJ?=
 =?utf-8?B?Q2JxRThlcTlwbmcrUXN6K2dWVlRmZUcwZHVhZFQyZzBnOVV5VGhveVNIQW1X?=
 =?utf-8?B?dllaUDdFMEpBWlUxbnFsaFdXeldoZ09GL0ZxUWJEeFpIRWhmMVNqQVpndnMz?=
 =?utf-8?B?VHBnK0s3UXlaVEVHaVlaV0JaeC9mUFppd1gvTzJwWi9UZ3BlTGR4aDcyUUx1?=
 =?utf-8?B?YVNMdGlrT2ZXTS9YNFZoY2hYak5ObWZJdEY4cW5YbElzbkZxWnhBdWNmQnp1?=
 =?utf-8?B?dlR6bURUTmJkbXZDejladUJaRVpUeGdYWjIrcmxHMEt5aTAyVVRHTi9VTEVC?=
 =?utf-8?B?K0lWY205S0JCT1ZocUdPc0RKaFB2VmEvK1k4VHZieFJMb1h0eCtIVjlBWWNo?=
 =?utf-8?B?TlN4emFNbVRjL0V0V3ZIM1p5cC83T3hoQ2pKdkprcWhqN0c5Y3RQOXpRM0lk?=
 =?utf-8?B?WWQ5RGx0allsekd3dkRnczBjK2FqWU95WmM3TkR5UTJ3aVhJT1lJS2lRSlVR?=
 =?utf-8?B?RDBvbG1sVUJObzBFV0owdWxBQ2VPOGhudURKem85ZTQrZmc4WDAzVXpkVDBG?=
 =?utf-8?B?VDVrTEVQVzFRaTdud0swOHdscUdZeStaTkozc1FCOUpLNHVENUVackhtd00y?=
 =?utf-8?B?cEdhdVpsZzY2dTVKVmdqZjJhUkhXMS9QQnIyeGxEeFJNaGRDRi9wWEpYTTRQ?=
 =?utf-8?B?RjJxY3RZRFcxeUd4UDdvUXQ5ckdjQ0syWW0xZjFHK284YUx2OHJIK0g2SHY4?=
 =?utf-8?B?RkI5TVZKWDRCTEpRV01ORlg1REJhMTRQbytxbU9CSGtMVFpxZm1zY2pISE5u?=
 =?utf-8?B?ZldHMTlGYmFCUkZUeHNMSzN1dG0wc1RRVzJ3cHk5VTRTWms3MVZSL01TY0Z1?=
 =?utf-8?B?SWpzMmJ2SXNnZytuWXFpQnZrYzMxQkJFT1QxQzlBMmJ3SDhLYlJlTUFQV1ZB?=
 =?utf-8?B?VEdZemNHR0VyTWpuZkdwdHVEUTBkVVZYeW1aNUt4bnJQVjEvcDBsT08wNURz?=
 =?utf-8?B?cFMvRjhXN1kwOWZxNjRZUUtaMS9GV3M4aDFROXpkQ2RhSjBrY0x6bDZnTjAx?=
 =?utf-8?B?NkFBM1hQTVVpRkNvSDJWajQrdWdGUlRFYTRIaFcwY1BoK0RGdmdxNjZOL1lh?=
 =?utf-8?B?cGU4UFZxRWxIT1p2alJybS9xOE1PKzlqd0tiMHlqdWhxWXhSeFBnY3oxQU9j?=
 =?utf-8?B?YWNCQWdtdURpTFRQRUdQWm5QUitnSWczM3haY25oY2EybjdPV1pqQ0lHQ09R?=
 =?utf-8?B?c1Fmb3ZzejRQdWUwN00zVW5NUGMybUtRNVA5dWVrUHFleERoNEw3aUNVMlda?=
 =?utf-8?B?MG9zN25kL2VZOFFIU3hjaENIa0FTK0lRcEp0ZkluT0tpV0N0NXYzZUF1UkEy?=
 =?utf-8?B?dG91QkFORTJqZU5zNkd3RWlrZDZkRitnbzMxS0lESUZldUJyNHBIL0t4OE4x?=
 =?utf-8?B?eVpGMmkzZTVZWWNSRkp4T3lDdnM1TlI3MkN6QlZGeSsxUWVIbGcwV2pGUG5w?=
 =?utf-8?B?YzJtUEg0MUU2eXdFVGxhM3hxakZMOFgrNG4vZ2NyT1IzRmlWOUp1NUkzaWUv?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bd665d-94b7-4b15-121f-08db0fff2368
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:21:08.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+IsUENGEGU2EHn1ytCfR0ld8BqghS5JOZpmXAenDu/29Uqas8ZKsVyjYyZu4yst/8NziVc6/9zkeBi6u+k1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 09:21:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10711

On 16.02.23 04:35, Felix Moessbauer wrote:
> This patch reworks the implementation of the swupdate type.
> All generic aspects are moved from the swupdate.inc file into the
> swupdate class and made conditional on the swu type.
> The sw-description file is now referenced using the image-type
> infrastructure, which avoids manual additions to FILESEXTRAPATHS and
> accidental overwrites of SRC_URI. The templating logic is moved into the
> generic one provided by imagetypes.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass                      | 27 ++++++++++++-------
>  kas/opt/swupdate.yml                          |  4 +--
>  .../images/{files => swu}/sw-description.tmpl |  0
>  recipes-core/images/swupdate.inc              | 15 -----------
>  4 files changed, 19 insertions(+), 27 deletions(-)
>  rename recipes-core/images/{files => swu}/sw-description.tmpl (100%)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 5eb4936..8438c5b 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -8,23 +8,34 @@
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
>  # SPDX-License-Identifier: MIT
> +ROOTFS_PARTITION_NAME ?= "${IMAGE_FULLNAME}.wic.p4.gz"
>  
>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
> -SWU_ADDITIONAL_FILES ?= ""
> +SWU_ADDITIONAL_FILES ?= "linux.efi ${ROOTFS_PARTITION_NAME}"
>  SWU_SIGNED ?= ""
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "rsa"
>  
>  BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>  
> -IMAGER_INSTALL += "cpio"
> -IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGE_TYPEDEP:wic += "squashfs"
> +IMAGE_TYPEDEP:swu = "wic"
> +IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
> -do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> -do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
> -do_swupdate_binary[network] = "${TASK_USE_SUDO}"
> -do_swupdate_binary() {
> +IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
> +IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
> +IMAGE_TEMPLATE_VARS:swu = "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
> +
> +# This imagetype is neither machine nor distro specific. Hence, we cannot
> +# use paths in FILESOVERRIDES. Manual modifications of this variable are
> +# discouradged and hard to implement. Instead, we register this path explicitly.
> +# We append to the path, so locally provided config files are preferred
> +FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
> +
> +do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> +do_image_swu[cleandirs] += "${WORKDIR}/swu"
> +IMAGE_CMD:swu() {
>      rm -f '${SWU_IMAGE_FILE}'
>      cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>  
> @@ -91,5 +102,3 @@ do_swupdate_binary() {
>             fi
>          done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
>  }
> -
> -addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 7902d82..80cd86e 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -19,10 +19,8 @@ local_conf_header:
>      CIP_IMAGE_OPTIONS:append = " swupdate.inc"
>  
>    wic-swu: |
> -    IMAGE_TYPEDEP:wic += "squashfs"
> -    IMAGE_FSTYPES = "wic"
> +    IMAGE_FSTYPES += "swu"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
> -    WIC_DEPLOY_PARTITIONS = "1"

You forgot to move this to patch 3. Doing this while merging.

Jan

>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
> similarity index 100%
> rename from recipes-core/images/files/sw-description.tmpl
> rename to recipes-core/images/swu/sw-description.tmpl
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index ee893dd..f4f5c42 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -10,26 +10,11 @@
>  #
>  
>  inherit image_uuid
> -inherit swupdate
>  inherit read-only-rootfs
>  
>  IMAGE_INSTALL += " swupdate"
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
>  
> -ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
> -
> -FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> -
> -SRC_URI += "file://sw-description.tmpl"
> -TEMPLATE_FILES += "sw-description.tmpl"
> -
> -do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
> -addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
> -
> -TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
> -
> -SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
> -
>  python() {
>      for u in ['A', 'B']:
>          if not d.getVar('ABROOTFS_PART_UUID_' + u):

-- 
Siemens AG, Technology
Competence Center Embedded Linux


