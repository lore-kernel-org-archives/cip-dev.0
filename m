Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A8E95A8E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 12:13:29 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.70])
 by mx.groups.io with SMTP id smtpd.web11.59493.1696853601992281488
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 05:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pPaP/LeI;
 spf=pass (domain: siemens.com, ip: 40.107.7.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6YyQZsvPjvl0ZMGdTYI6aSw8Gl5eD7BtR/oh4Tu7Rmh9QOdn8Zf2TJBs8h5vo94eYTvP/N3WXX7L6+wmYn9jep3Ljdm26Ol+fBdqfhFjYOZ3UjITCg8w+xS1gOQYK0VE/R09tnSaOFJcGgyUTa05A3E19GcN+Kt84+xSVwZluXzwWex3KelEaKEkJQY2N7hCCjPhEBbZ4xwguAol79xJrNKsp8fEzxa39yqWegkKMdzkihV8y1tVS6x9iU9JZt8uAYro+CgsZE01Z4bFG9jXOmqHyRHDBu3xcQ1M+2C9BwB76fbavCqRVmz8Mk7u2S8WgVHTuoLXL/ELKmYc06xIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s8Wt73hVO+rJyfMH+VUNUZDZL0DYPspMs3FM/B7zJY=;
 b=EMD6a70N+h+NW0/ThNu6PJS8/t3ucxn8ugWfFkgLDn6tk7vFbaKVO7CwQJBqMHbpIcGb3uaeEHF9uG9wTFLiQEGBgnKwBw3fgZsKLP6Rtrjfyx5Uqw4V8m97qcZ7yGlGYQHmQLqLDXpWfW/RZy7PcuGcdVfHrHtZEo/ENjKd4VS7b8969fbqydSVQpDivJdzSTU0eeJKWSY95zkh747HJN7KcPVnhC7PkIYYVe42XQfTdx1fY8bFLIb8L5oEg7LDT5JcU6CDkM6D8UQT0AsgmBbGfJ8c4iWsxe3IYEN5yZsXhhuFq2WoS6P6oRKNuxtli3uo1Z40wdtA700ErZd2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s8Wt73hVO+rJyfMH+VUNUZDZL0DYPspMs3FM/B7zJY=;
 b=pPaP/LeIYjrtw3m3gCqjO070z4HKBlNn2qxTDBBCu5lJdbRyg6t9XLaRImioUl0FwFT6qh0+YkL7gie3iZnMBg+t28fy0waXuU2x/1bKXeXMxCtUFVyRZA9O6AHt7GA/qtgDQYRAeAyhGlTs9U7f7RQRVlWPaYcMxvlhWJwuqrUsiPKQ30pymDex2IS+8/ulNf5vqD92/A/rw9GNObNjZ+X1OfIvkBALQyCJLhU89QMoL1P8azq5aX4VgXmrq1/KrC4mPvRMEAp5r++91trC761XeQhsV4an3erJ6Jz9srjkAlj+PBsoUlq8l8wi7h+L7KZGED/rvg7jAIIzA2VgwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 12:13:17 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10%6]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 12:13:17 +0000
Message-ID: <7b17dabb-9bec-40ab-90a2-8771ffe20cd8@siemens.com>
Date: Mon, 9 Oct 2023 14:13:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 2/2] update ISAR to latest version on
 master branch
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20231009115344.746642-1-felix.moessbauer@siemens.com>
 <20231009115344.746642-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231009115344.746642-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: d54c4d5f-0204-44be-b224-08dbc8c11e9f
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Odbp01lB3MwbdjLGk3VGFwuDOMsgR+AcW2AXDQ2Q/USwYOaxZL2/Hs1385z6dIXY0vwuXrZwrDNti/soUHs9JQs48xB9oFx/zWLJEZ219/O/w9y0b5j1eZMzYc4/wvLSXSoAvVg3NEEbBJE0n7CzCsnHW+lSG5F6Ra3V3w9Y6J5evBaeYQQpz/fw4b29851SFMQVzVftes+AOI3bFIzoOpRTNAa/9CtGzlxVCHiSFIvgEvOqCw1gHkDF2W0wbUw3VFzVgQxmJPA+vl46seVm6xelGgCoax3n3i1fyAfqhEkksKaHnwuak0HVION1ZehOGu92337dg5xtc/9AsvJiDtf/7CYoARV4RLPwrhi+aPyNKrGFZMs9/9KAvUgGo+A93GhiiKcE/YvzmKgUkPdFSdRIombQe0SKQy47jE+Wn60nAevOwpvisuGVN309O8bWMTbkBY0Q5v7z1IhqItwr9MRau2RLHEv6bTsig29RsutO7h+Lhkd3K8HxTc34u+PdB9R3eQDZfqSu2KE/ubqqkFOFjS+977alO6QpRBisiVmHIcW6fH9nlkKdgfm4uPqHRbVEVXyXTGiYbiD2/fi6nic8CNfVpdelikbgBqvyNUE8BLVmVHLayld7rT2wxpVp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(41300700001)(2616005)(26005)(53546011)(86362001)(31696002)(36756003)(82960400001)(38100700002)(83380400001)(107886003)(4326008)(478600001)(6506007)(6512007)(6666004)(8676002)(2906002)(44832011)(8936002)(966005)(6486002)(5660300002)(316002)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djVVOG9STlJ6TUQ5NW1KRTBlM1o1V0JYNUJmQUFDMThTNHFyTzI1VTBqMmQr?=
 =?utf-8?B?WjVYZFk2UlpkajVzOS9IWUl0cWkwbk1yd1l0ekdPU1RUNUt6VnEvRGZNUS9u?=
 =?utf-8?B?YXZqa2I5d1RJSXpVNDh0dzk5U2dtRXNmYXpYNTBLN1NnWU9nOVZ3K3N4Kzgw?=
 =?utf-8?B?RmJXYzJvTE5mQ05qTTA0L1UxWDNrVHl5b3hBRTkyZ3NMTGtmVVluNGthbmR0?=
 =?utf-8?B?UzdoUHhMMWVWTFFHaEYxMmF4eU1JY2kycWhRNit3U3NTeHpiM0R0YXZkU01j?=
 =?utf-8?B?bnBOVHNZd1hQNktheTVFSkRIVVU0Z3JQNTk0SFRuK2gvK0Uwb0Q3RkJ5Vy81?=
 =?utf-8?B?QUhqbm0zdzFFdDl5Q1FwVFFueG43Ym1rVWZLS0djYnVDOS82bTJnL0tRWFlr?=
 =?utf-8?B?NGE4dVhZRHlnU2E0RDExa05NOEcycTZXOGdtQUtGa3BTb3JzaXBqcjdMYlFG?=
 =?utf-8?B?a0VqT1QyUUhQYkVZMUkrc1g3VWk0N3VXRG4zNkJjMEFlM2FHcnpCbEJ3ZWt4?=
 =?utf-8?B?WTZPVGpmaUpmNnk2UGYwRU9VTWJFNkxEbGk1N3p3ajREQUoyUFVGRXhuUmxt?=
 =?utf-8?B?L0dEVDVQZnBuSzE3dHRPRU8xdmp1YmI0TE5YZ2drU3l0NDNMQ1NVWUV1RjR2?=
 =?utf-8?B?bSs5NGR0NmZHY1BNT2JEV0pib1ArMFRjaFVtMVJ4ZW9ENC9rdGVqR1U5U0NC?=
 =?utf-8?B?c1krQWFpRGhjOUtJY09YdHl1Y3JlaWZaaUdYWGliT2w4SEd1WnVWSVZhSERR?=
 =?utf-8?B?T2hXMXBKZFFvZ1NnNHQ3aDZwWnBTcFRFZjhiaExaUXR6aEdRalNlVlljamoz?=
 =?utf-8?B?K3R3NWFoTGJaNDZ1Mm1Ec2xWOFhWVjdDcDlEVForU29TR3RkNEFtOGFuMTVm?=
 =?utf-8?B?RThZTnRkbTI3aXRtc0xYRUVqc1ZEL3RxS29RdzlaOTlOZW9nTmxIbytpRWNB?=
 =?utf-8?B?TWFBbTlVRW1ocTk2SmpTYXNkV3MrbE1WVDB5emRxaHZvd1gzN1lyODlrZ1Fq?=
 =?utf-8?B?anlibUJlaDFDTzJsTnVvWk5rT0tHaHorQm9qOWpCalkvd0dMc0xwc1FzODMr?=
 =?utf-8?B?UjNwN3RacWZKQTZ4VHY3d2l4NHhUcTN6UThJZ2gyVi9zbzRncURldUxnaWdz?=
 =?utf-8?B?WDU4bWVlTEtDTWxMNERvUG9zeS85NmpOV3ZQVWx4OVNRejY5Q3RWZG96UTVO?=
 =?utf-8?B?clpkZlpSRTYvQnhGODdLMkF6MENrU2Q5cVZKbjZFTjRkSEN4cHRKMSt1ZjVI?=
 =?utf-8?B?Qmlmejg2Z1B3K3FLa3AwVDhoOXc5VGRBVndFRld5L0hLRGR1YmRRNFBFMGI5?=
 =?utf-8?B?TEF1OUJBMWI2MjBUcWczWEsrTkM4Z3d3ODgvaEVYL2k2N00vbWJtblNra25V?=
 =?utf-8?B?SHBvUnhGbUU2QVNoZytlKzN5bnRzU3lXd04yWHJvTndLNWgwcnBxa1FrSm5p?=
 =?utf-8?B?MG85SGZWRTFMQXBmTnovR1VXdkZLNC8rYkxCcHVjUTlSMFhJcUkzSWFBclFK?=
 =?utf-8?B?NEZUOUZBbWxsQVBtQ21LWkh0bGVNSnArYmsrWVlxSW4za0J6U1VVdkcwWmZK?=
 =?utf-8?B?VmNYVEg4d1kyVkNEWG96ajlOOFJTSjJ1MWp1c0dxNEEreGV3RGdOeHVJSVdQ?=
 =?utf-8?B?eG9RaS9vY2kzRkYwdFB0MHFvaUtTdjNuUVFlYzRHS1BDODFmN0NILzlmYkFm?=
 =?utf-8?B?SFZWYWlpYnNrK0Vzdk9PSGNXZ2tUdnR1ZFhMMWFRZE5iY1hORUtCN2Y2S2V0?=
 =?utf-8?B?WkNINzZvZFhLUDJDOTlnem1MMHJQV3JvRVR0YjVZdEIxeEVhQitSTUo1VG5m?=
 =?utf-8?B?REUydWtyL3ZTcXh2K3N1L0FUQjRkYTh6bnRxeEVVUDAzZXZnNmpkWFR0NHJL?=
 =?utf-8?B?TW5KcTBhN3F1L0hNaW5hK1dGNTZpc2RJSGxKNkdjdXZwbnBoQmYwRXh5TE11?=
 =?utf-8?B?QytiNm5ERmU1VE1xTjRBYWpsM3d1V1o4K3ZpTjIvQVdINzBrak8zK2VBYUo3?=
 =?utf-8?B?NlhiZXNVSms1Ui9DNjJDSWJleUVTbC9WdjJxWjFJUm0zaXR1Tm9mN2hjOW03?=
 =?utf-8?B?OUMwRkp2SFpuUkJrRGd2WjFLYlhlSDFPejFJNU9HNmUyM2FoZVBDamhPb3Zj?=
 =?utf-8?Q?Pk16OxSzkumYi4aSncRP0NkPb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54c4d5f-0204-44be-b224-08dbc8c11e9f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 12:13:17.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCyzGsfXgiznSeEZYxdVrWfQDn4wd+oFvzSvlz4ELngIlgBveTr42XGuC3371DN8Ax447UGfM8dFj/YB7pdgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 12:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13321

On 09.10.23 13:53, Felix Moessbauer wrote:
> This includes the following changes:
> 
> - make deploy-ovmf compatible with schroot imaging
> - make swupdate class compatible with schroot imaging
> - avoid use of sudo when creating squashfs

Seems the last change didn't make it into this patch.

Jan

> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/swupdate.bbclass            |  5 +++--
>  kas-cip.yml                         |  2 +-
>  recipes-core/images/deploy-ovmf.inc | 10 ++++++----
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index aedaf02..55dad32 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -106,7 +106,7 @@ IMAGE_CMD:swu() {
>      # Prepare for signing
>      export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
>  
> -    sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
> +    imager_run -p -d ${PP_WORK} <<'EOIMAGER'
>          # Fill in file check sums
>          for file in ${SWU_ADDITIONAL_FILES}; do
>              sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
> @@ -138,7 +138,8 @@ IMAGE_CMD:swu() {
>                  fi
>                  echo "$file.${SWU_SIGNATURE_EXT}"
>             fi
> -        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
> +        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"
> +EOIMAGER
>  }
>  
>  python do_check_swu_partition_uuids() {
> diff --git a/kas-cip.yml b/kas-cip.yml
> index c329248..84b7441 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
> +    commit: dff8ad504b54a4e292a1b986cdc74ebc9e6e177a
>      layers:
>        meta:
>  
> diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
> index 0ec8762..d2b8a27 100644
> --- a/recipes-core/images/deploy-ovmf.inc
> +++ b/recipes-core/images/deploy-ovmf.inc
> @@ -11,11 +11,13 @@
>  # This recipe deploys the OVMF binaries to run the image in QEMU
>  # Note: x86 only
>  
> -IMAGER_INSTALL += "ovmf"
> +INSTALL_deploy_ovmf_binaries += "ovmf"
>  
> +do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
>  do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
> +do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
>  do_deploy_ovmf_binaries() {
> -    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd ${DEPLOY_DIR_IMAGE}/OVMF
> +    imager_run -p -d ${PP_WORK} -- \
> +        /bin/bash -c "cp -v /usr/share/OVMF/*.fd ${PP_DEPLOY}/OVMF/"
>  }
> -
> -addtask deploy_ovmf_binaries after do_install_imager_deps before do_image
> +addtask deploy_ovmf_binaries after do_rootfs_install before do_image

-- 
Siemens AG, Technology
Linux Expert Center


