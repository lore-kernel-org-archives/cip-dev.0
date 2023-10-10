Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FECD68F4
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 04:34:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.52])
 by mx.groups.io with SMTP id smtpd.web11.83538.1696912471061183101
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 21:34:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JlrQFJ3t;
 spf=pass (domain: siemens.com, ip: 40.107.22.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqTb5y4eMpo7upFZCrHqCdj/vWuf6oZ0fhLdH26qazpXJ2/kVaLw/U4e9HZrTG1vw9Olj2YJJLi7gKWWFSM8fxWLoJ8kfzUGjHfBN6Q8Fc69D4MchTN2CBmuxSgDR64ENMkxEQwcKWbSx45DAurc8SZpBt1SITEe26H5ohTjskbhXKOf1opwKhvUn1zR/E7To7vgNRcNZIIy54bGbOCbrcSj64GnzNs00EVBRcjyEXYhW1CEbW91I7XaC1kH0/ENzbQNZYue9fRfc+jFkJtsCdWDp6klsf8Wdehp0SmJbw+OmD4Bmc8inNVxfHRPosRMJSNYvMrxnn2TqzI/xbZ6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=539E2YZtFFYMMG8CJb+smGO2t75+xuUUHeVb31aoIYU=;
 b=LJzeSYta2oTMuFRMvnTIYt2sq32lqxGTVRoAC2o8TOVDYkmXkmYnXjx9mZRenW7PU8HRs8/uWPhA+nx+XUW78visgLYVD5QxuzhmgZs9l99YRIEMREiO1PpCf9kPibIA0HsdZCMZ3SFsD/7Xtz6BIklN6SJNZ0uJUETZ/Jn7fc5Z/0xlEih5MOLOpZGGyubnCx+hSr+NJxGgN7WCy1e2c7N67sI6SNMyNgmLr8P9ds7V72Y3iitLwNBLvFOIzQJLwZYySTZVe1AOEt7bajD9DFLpjKL9RaF2PoJHwJR84Bk538yoF4yAhBWvqGrDsM7nec0REyYpFc8oRXIcBj5F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=539E2YZtFFYMMG8CJb+smGO2t75+xuUUHeVb31aoIYU=;
 b=JlrQFJ3t/SvkJJqn0vxNKjk/2+GDBWjpDXYy6ekGBA06sa8/C3AOFNgs/8/pXxm6hic0JPcmlC/83MshGMm7gNjsZ0U96LddAlpbNRRBaTAhlPxjVLBxlZ5h2nv4Qi2bQzTMbePKaEDBBxoEJ6I7hsCt8HhMcp9m4jur5FWqi0Sqix4HtDPBSgldykLrEjV4nB2+qKtzIUB8bGcaFIcuaoAQJTyvbKI2X4+EotAdhhdTvbz2hRvvufPQHA5zCZHHJ5PMpJAzTjqUZBvTGNpCYsQA/5a00ypBsL4PU+U254J1iqrKzr8fIBweO71NcaJV/Sd5IwprMDnZAY55Bt2NhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 04:34:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:34:27 +0000
Message-ID: <a1bb2c8e-1104-470f-802b-9716e25e8624@siemens.com>
Date: Tue, 10 Oct 2023 06:34:24 +0200
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
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 682ce1d5-44dc-4900-1efa-08dbc94a302a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eZ/HEqZBHMMOtYIeMhvDyCwgVKCn7APkFOr1+857jt3UGicjxmL26nna1dwh4S/PM7uHzIYKYQhvW0hKfiRQ2dcDFPi1qWXg3PaZ1V67xJ7n4HKnZTkpTqjo0zJ3bT0h+n10eOykCTs0stOeYxSgOEYYeN1cL6PqgIE6yhyY4djyQ0P0Rddqy6yfWPoSC71VXujiJtz+GbmPkNnYcy8pELHASNdo5mSg6/WqJ8aN0/bvQa3gkAzHmuDcslIfxkBs3HGT5C0N1a/QE7ESs2w5g8y/Ga/i6+b+hdAaQm27lYxUzWBUXBMVjw5J8sl+Ui0gTvsqKULm3md/GXzJed6xLO2tCLxoUn/qrHSoa1iQHwfK13ocs+B2DZtWLun7sTyyjnBEC/6xGgGYNtIdWJABLBYl6Xx9/Y1isxsnn+9LvUVahFQEQNz9H3x78MDa9UpJXPfRBRnStdAeakjvE2hb+LHSrUU/kzuYt8AuaBb+O3kM7BT6QXrsUs+1M5AOJhRQmdrgmLtzTALWhJNjT6v+Y/Ec11n0cBxodZ+uwS0NO1QBb1m6VrqGf/BNaAoF3nSJc40Awgw4fwEagQHQxENrmjbEpl+bkWkH8ZXsA9L1X4mVoJTUZupSEFO8mApJdPIR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(2616005)(31686004)(6506007)(53546011)(6486002)(6666004)(478600001)(966005)(82960400001)(86362001)(31696002)(38100700002)(41300700001)(8936002)(36756003)(316002)(2906002)(26005)(66556008)(83380400001)(107886003)(8676002)(5660300002)(4326008)(44832011)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEpjanFqL21FNTlZSVZGaXVZbXJLd1pZYS8zcG5jZE9GTkFsam5SNXpJV05T?=
 =?utf-8?B?ZmRjWWFXWXI2UURKd0pLc0tDWllpQVNuSEhGR0hNYTZ5RzdIQkkzckYxSWJP?=
 =?utf-8?B?UnV6aTVLc0ExQWlOeVhBYjR1V2MxVU9Ja0FZU1d4THFxOUFsQis3bEQ2Uk5t?=
 =?utf-8?B?K0VjK21leDYzc29qUmhRcm5YeE56ZUgvTUduLzZmK250MHZKQTRNUFFzL2lM?=
 =?utf-8?B?S2YyTm80SGJuaGkvb2ZyQ1l0dHZNaVkrNm15U0trUHNtV1RyT1BhVlRqbjNi?=
 =?utf-8?B?ZVFrelVWeHNmQjhScjZKN2cxSzUxTnYvT3VsT0lTRlBTTWxvKzFxOGJNVVVY?=
 =?utf-8?B?L3NzMDF5djJmNEorbFp6NHdGYU1DeWdxNVhlUlRuNy9YamRhanFlZFd0MC9H?=
 =?utf-8?B?czdUZUpxSStqdG5rSWFrbDVxdnFXVEJmMnBZVzBkK0pmdFdDcGY0T2JhV0o0?=
 =?utf-8?B?ZnpUYnBmMi9HYVNPeUgyc1hsdkRIQTdlT3RIZW1rWHpRTGNKQ0dSbkI0UmxX?=
 =?utf-8?B?MG5odnh0QWVHU00rV3RuUk0vTFdtVm1JcURBbHRXN1o2eWJGRDVxVmYzVTVG?=
 =?utf-8?B?all6YXF6UnZuc2hJK1RYcDNhN3pHODVIMXZza1pRejcyandoZ1ErL0dKYnhC?=
 =?utf-8?B?SkY4Y3QvbENmQk9FcVVVbk5EVU51cllLR0ZMc3o4am1LdEtFYmpjcFJqMWRw?=
 =?utf-8?B?Qk5SV0xWNmE4MU1mZDRIbXZKN1pLWnlSdVZ4MEEvMHFHa212LzlpQkFwT2Nh?=
 =?utf-8?B?R2lqM3JZSXEyU05JUWU4aFpWNnJ1R2Y5bzdlWTkrU1ExdVdQZEpObnZsUXFV?=
 =?utf-8?B?cU9zWU5ZM1JMVmNxUkhRYU5VSytxWk9tSEx2Tm12OHc1ckJlVENtVE14S1di?=
 =?utf-8?B?cUduNEpFcEUzL0l6YmZiZmpwcHpYS2VJbGxHNTdWSVY2VVUzMDM4ZnQ1SlVi?=
 =?utf-8?B?bElSUURRUElPRWhwbnFJOVFvakJmTnd1TG5qdFF2NlpJOXV0TGZsS2tMazlz?=
 =?utf-8?B?Y1A2b2FnQUEzQVBjMEROTkhjK3RGcWlYOGRLM0FGUkdzai9sQ2tIQ1B3ODEv?=
 =?utf-8?B?V01lcXVRWVA4TXZocmZZbUVnMElIWlhDVGlUOWlzWGV0SHVDajR0bDJzZld5?=
 =?utf-8?B?OVdRSkVQZ09PdjY5dXIrblpyaFV3ZDN6cTM4ckdpQ2NBR09yK0g3SG1wYlZL?=
 =?utf-8?B?cDI4eHVUYWZqbVFoeEpwVFlBMmtmckNicjYvZlFCdnRLdUJVU05zeHBPb1Ru?=
 =?utf-8?B?TXpPOVdxbXJXRE52bm9ENzBYWUpud05COWp6SjVLQWxnVmpFUUF5aks3Wlpx?=
 =?utf-8?B?VGV0NHY0V2RXU1pEdUorNU5WWjYyckhoLzY4V1gzKytPaW55ZkZZSjFxcGV6?=
 =?utf-8?B?MTVPTjRvOTZ6ZEg1OHZTWXJnMERPK2pzUG4zRVdHdG84Q2VUU2tyNUgzeFJE?=
 =?utf-8?B?dFpBVDBYOFo4cE5GWW1JUzRaUHJHMWcyQ1lmbm1UaXhERW9BMFJRNHQwMmVN?=
 =?utf-8?B?Ukx4L0MyNkt1YXNwQ3dlM3FYZW5JTU11OGxFVWlTUmV2Y25zUXN6UC9RRnpr?=
 =?utf-8?B?NnRPRFBFVWRpYjBhTUMwUjNSeDRrSTNLZFlHUXpmZGt4NW1iUDNXOEJLSmRJ?=
 =?utf-8?B?UFpobUYzYWZ3MXNSYit2WjhGeFMwdEo3K05RQlF3eng3RG1pL0NWdlhSVTR0?=
 =?utf-8?B?RUFGcllmcWdXWDBibFlNWlF2bWVCZ2JVbXlmUndaaUc4Q2lLeHRLeURobFRi?=
 =?utf-8?B?d3RoZDJLeHNqM0cwYUpKMVBBNzdiSVE4MnRZMWMwRks0djdLa0VXZmV2TkFS?=
 =?utf-8?B?ejY3TGtUcExIUnIxNGtYUU9WYXR4OHBFcytVVjVubEtBcnFvWXBRcTB0OXY4?=
 =?utf-8?B?UHBHNzZIZFhzeG5XNXRoUDlQSlZJMjZMN2VoZXNoRWFHbjl4RmpNckpQaGdX?=
 =?utf-8?B?YWdvMjdmcHVZOW5iMXMzQUpnZENXOXhWd1RKOFNFWStqbGdTNEkvZFh6ZTEr?=
 =?utf-8?B?VkNtd3RMbm5NMjhPQjFhL1dJeHRaYU92NXVTYnorYTJRTSsyM0JvQStuVFFn?=
 =?utf-8?B?OXAxdjdZQUNzcHR3TkN4QWprMTlkT3NFbU5FRCtSL3pCZVFYeDFCeldZLzVP?=
 =?utf-8?B?QmhIMm1IWGZkTXJyaVpDUElGYTRyQnB2eUdlbTkrd1VwbnRBenp4M0N2Mm11?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682ce1d5-44dc-4900-1efa-08dbc94a302a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 04:34:27.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHz/keMPzPnO9thdzsWbaeZXSeT3qPdbs9C1ED/MZCmnsiF3lT4/mR5A2r5Xh1oLlW6ESEETMjTVi2DJwt92MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 04:34:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13336

On 09.10.23 13:53, Felix Moessbauer wrote:
> This includes the following changes:
> 
> - make deploy-ovmf compatible with schroot imaging
> - make swupdate class compatible with schroot imaging
> - avoid use of sudo when creating squashfs

Dropped the last line.

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

There is no reason to use bash here, unifying to "sh -c '...'" therefore.

>  }
> -
> -addtask deploy_ovmf_binaries after do_install_imager_deps before do_image
> +addtask deploy_ovmf_binaries after do_rootfs_install before do_image

Merged into next, also patch 1.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


