Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A5EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 17:29:19 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.48])
 by mx.groups.io with SMTP id smtpd.web11.3288.1689874152803892122
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 10:29:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vctUU9YV;
 spf=pass (domain: siemens.com, ip: 40.107.6.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ielrr+40nSboIL2K4lTnMOi9HA9nOrua4Xt88fn2gsp/z9lZ8AnTY/+bUk848UzrgfZV5fTiVqGldp96Lw8E4CnLU9m57x5baYIG0BBs5MhU/v++A6Ch3A58jdwh72QS0E7045/bQoJ+scYRnOZO6jEGih02UYUkDNovnPPJTD4DNIIsEHVYF9jsLSiJ+ods8FImB8Q3b6Ve/ImvhbtPTS/KDwCBvWHDezuj4BhWtYzMHjNSLTUygxBpILhJ6pPjuRcDNVoI03DxxaEN1n5L3+JCBmkaYcrJhmnfqCro108bNcgT5xFmG7UuNGzpy5c9uuiuLXsAciWUNfXfm7mJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZDsO2yQYmHI8Dkd5Tt+od/nh4gbF8gI4qkqVBsqlPE=;
 b=OaSWVRfuLttPJNkKUKbVQ9CQcX91YvUnyU6m3AcGlGGigsfb3w4DKBhf/998SHDKgSuOpaeXNH1x2IAJQMrnksKbWU6INpdoiOWJpFKpg7efR6RD943068g58PHAnf3VtEFfQHwblDziUVf9C2csq7Tti/jC0gCklJouuT+zhX76orE7VG2dO2GwWujcPk0giSv5sr2MtQuNWVfpZtefkiYzuCb8ajHSfWI0JJgZuRLdoS5/WwXh6zppN3yanVJE1ZUbEG8qQGLqJtFtdO2leasvqq0gY9Nj2CjB0IbY0F8FKwk/TN6uGBtzSBYSeAYfLP0nAUMQ1FctSg2TBt30xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZDsO2yQYmHI8Dkd5Tt+od/nh4gbF8gI4qkqVBsqlPE=;
 b=vctUU9YVQAG7TSn13uZSd8smgkNIHKK94KGq4bGHzswwY4HcEPUxisfKv+GysGP7DnbZQOQjmw6XH0tEFE/fMepIAYatTN25klL19xS1WBG/jwL5uvBtKBkYTSgO1vgy8WMKzhXakjsec5cRLJssWGOaECEU6PbOZCyKm/ioww0/noTGGr8Wk2O0esO+4vq4Ept+OPNRfUqz2eanZybOE/D1Q6K0iamnBNIJjRK6IkQiQlN1Y25feBi1lh5csx9xAZFT4I5Y5eyqYenRlD7OOTXamMMrzavaysk4g65Yto6RAuZ71w+NlZyJzssr+8hHVt27q9Khk/1PgN3NvH90Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 17:29:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 17:29:09 +0000
Message-ID: <7ac91e3f-e664-c915-da8d-cfea3de4aa11@siemens.com>
Date: Thu, 20 Jul 2023 19:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d3019d-1a3a-4eef-6f90-08db8946d3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IqFKgBjF8tQj17Jy70SrylOwo5HV7QRTvSSzTDeBn/C1wbPEMBJZ3XxKib0j9GlLnVUQa5OM1d9wlWI6keNj/QB3FBKw+AE6FjK1Lcn2JQ45BJhoS0XZ6hXd8/f5ALprOWyJgqKS3Adu1iaSaOwjJkiihrYl9qpFzaNmbJbOfTINetQfwV1vUCAxEjTbuNFBSWNxYbGCU+xqqEZTGE3o/Elh02XT1rCDfMAMmGdAFZAoOg8l5hkv+b00Z7xFJAs+b3Ae8w0RISwy9hXSlZWEt2eM3ienOMY3u+RwSQg6Tj5Pd/l0+FmPnw/ugYkn6BNZBwh7w5LG7uTlB3rGtcggnOcCKMl87n3VDZSQR3xvjJlexqSvYmbjFrFTVyig5Na6UyEDaFfyCv6PRJBB8qd4cDMh3h6f2LA38/oaimW12nOZ6Fdnq565WNBPYJePV30vnI87pzgqjBpIKV+zEKHUKBdsOFcFJoitoHbFutXNn2NU0l2z0cpokWalB3DUP1lrA3T/FmkRxJb09xoxf4W7ugXRkHT1q51ZpzRmc0IFQQQzNho3i7uMQRI8/rqFs1S2XrXjXyqK6XbsEHkYB8inZbajAx4oPz82NhTRXTeJv8YbLMoyzhL5UH9GWXSpQgKIuHTIj3NpneANXOgTj3lJqg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(82960400001)(6486002)(478600001)(186003)(31686004)(83380400001)(2616005)(31696002)(26005)(6506007)(6512007)(316002)(44832011)(66476007)(6916009)(38100700002)(66946007)(66556008)(86362001)(2906002)(8676002)(8936002)(5660300002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnhUWDRzeTBPNkRWYStlUzV1RDVjaStVU0M0dmtJM3ZDMW9KVkJCanNQb01Z?=
 =?utf-8?B?WUFXY1BBanFnRkVMVW5RbjF6ZlR3bjBkSUN5YlMwVG9TbnViazN0ZFZzakkx?=
 =?utf-8?B?cE8wNHFwTTg2SXhIbEE3Qnd6Q2JENGNpRFdoWXNNTndsa2pVRXpwdHRXSE5G?=
 =?utf-8?B?T21zU2ZEYUhmSXdqN3Nxci93UDRNMml3U0RxNlNRMzZPclVPU0wwck4rNER2?=
 =?utf-8?B?NlpkZHBnY2JQVlFpUFRwcklXRm5ZRVF0ekU3blkyaDNVWFZEWlJKbFZXeVBn?=
 =?utf-8?B?eWljSmpXTEZxRk9jQ2VrL0VaSUdMMDJkYm1pRzZCWEo4NjJ6ZS9hNVBycjJS?=
 =?utf-8?B?WFY2QWJwSXFWSkVaU0tTbEpudXZWalRnK1p5YWFNUTN1VkJUTkxqalJOaVRq?=
 =?utf-8?B?Z01xdmN2dVo2b3B6WFZ3NGhkN3B4Nml1ZEFvcUtxUXptUXYyUnI1b1Vnd2Y0?=
 =?utf-8?B?eGVVUHpRdGwvZGZCcklTL0o2U2ZqSkRjK2hMbnEvREpGV1ZrYytqbDBrUXJZ?=
 =?utf-8?B?ZkN6dTZ6T2wyNVE5N2VQcVhYd0EyZmVQeDU4bndvbG5MejlPbE9FaHZoTFh2?=
 =?utf-8?B?dlAyZ2RWZGc1UGtvdzhacXVwRWxFVWhuT0Jhd3hhMXRKK25GZ04zM3RiaURF?=
 =?utf-8?B?a3hlUm0yOUZ4Q20yTk9IaU9rd0tUUWd1V2dnN3llL3ZKSDJKS2M0VGNSZG4w?=
 =?utf-8?B?OGZ4VjZmaFNrMWRVUFF4bUIvOGlWZkpFVnhkaXJ1ZkJQN0ZnQTA3OW1YUWZJ?=
 =?utf-8?B?WnpFUDBmTWd2QStzYXlZelgya0swdjNNcW5oeFFjcW03UjdRUEUwUEkxRGJw?=
 =?utf-8?B?Zk9nek13OFVQOTRCWjc0a3VHT0ZoNXY4WVhpbWwxRFkrVjN0VWRwd0RUUnpD?=
 =?utf-8?B?b05zdVdyVFpQMSs5c3NxVnlPaWpYbExvMjVUWmdDUVpxbkROUHI0ZmVic2FN?=
 =?utf-8?B?ckJ4Vms5RDZTSEV2NmVQN3I4N2o5S3BhZys3L3ZUOCsyOU1JazJ4YjhtSUNz?=
 =?utf-8?B?d0lrTFFwZlEySm03L1JTZHlvSkpSdlAzbk5Wc01HK0w2MEJOOVFncmJOcHNu?=
 =?utf-8?B?Q0J2ZFRxa040RTArMDdZYTliVXhoeHljTTRKcjdoRnJHa0RrdEhNS3krRUkr?=
 =?utf-8?B?alA1OUJtY3RoeE8xVUhSbnlTaWFEbkV6MHV5WnVTRytZZmNYNWhadVJtdVdT?=
 =?utf-8?B?T2ErbWNmeEl2YStpellvMHVneTcxdVRrVUFDRTdxNDRvbnc2SlFzWHRLWGkz?=
 =?utf-8?B?cXRPeU5PTTQySjBxbkE3K2MraFpNaHE0SmhleU91VWJiUDVEai95QkRqK1RU?=
 =?utf-8?B?eEJKY3ZDQkNxdjZ0MzJNczJOK1RmVWZ3OVc4bTdXNXVIUUhTVmxnT1N1bCsw?=
 =?utf-8?B?d1QyQmFyREJBSGxiZ1hhU1hUZmxEMmxDODNycWQxZnFnSURmekpLb3UrVTI0?=
 =?utf-8?B?akYxZmovOFJSeDFZcnkxYmJlVzFSZjRheGpQK2QzbGUrcWdmOVRXdDhBclpv?=
 =?utf-8?B?UFBXNytDSFRFUzdPandLYkpuT2lXQSttL253MTF6QmgvR0tMNTZGQk96YlVY?=
 =?utf-8?B?c1pFYTNnS3ljSFlvbDhQVWtLTW5tMEhCOVBUaTdxSU1yL2dTK29HaS9FcEpO?=
 =?utf-8?B?dzEyRDEvbUZDLy9CeUpmQkZjKzZOSzRzV01TL2dMbFpvYlBaR3N3eThRQnJR?=
 =?utf-8?B?MDlJMFI2N0J0NTNPcW1jMXRhWHg1dW44SGREalNETHJBcmtRL29FaXhteWR1?=
 =?utf-8?B?V3hBV2ovRnFXeElGUSsvWXlyWFNaVURMMWlFcE9kVnlqS1M0MUlRcU4vMHRs?=
 =?utf-8?B?elkzNE1vK0VYd3A2cDh1VkpObVpjcXpFbUxhV3Ric2F4bllCdTZvLzk5eWFo?=
 =?utf-8?B?T2wwNy82Ukc3dWE4dEM5a3NYcXU1R09pSmlOVEdud0lhK2l6MzJxM2JkakFD?=
 =?utf-8?B?RmNZNVRvK0JJTTZzR3IrbnhrY3BjbEhhMzh3Y3dmMDhYTVNERGZmS0tFSjN3?=
 =?utf-8?B?YnkxMXNsRmhZbzltc2I5T0RYSTQ0UWZNVStUOXh4eFMwOHFnUmFiYlVGc3BL?=
 =?utf-8?B?Z3RRZFNDZEZWQVJ3S3VjdWlJcGRiTVRGMUU5U2kzUityM2wwdk5Mc3d5a1ZW?=
 =?utf-8?B?VjB1TmF4d2pNVW9kV0JmOVFjbkZJZDJhNzdVUXlYUVRGeTRwMFBGSHFVTnVX?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d3019d-1a3a-4eef-6f90-08db8946d3b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:29:09.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXfec/dES3GhHbrKQjXPhImGm2cyHTPqx9Js69opHDN3ADnljphOk0I5i8YoMpR+5AqhOEWZskeryFH2XSM7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7600
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 17:29:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12483

Here comes the second release of isar-cip-core.

80 changeset, 9 contributors, 101 files changed, 1323 insertions(+), 481
deletions(-), these are the stats compared to v1.0. Major changes were
the addition of Debian 12 (bookworm) support, lots of reproducibility
improvements, updates for major components including support for
6.1-cip, and various fixes of the integrations. Full list below.

Thanks to all the contributors!

Jan


Felix Moessbauer (12):
      add missing dependency to template subst in swu
      add support to limit resource consumption of squashfs creation
      make name, version and hw-compat available via bb
      swupdate: add support to disable compression
      disable compression of squashfs swu artifact
      fix operator precedence in ebg and swupdate
      refactor deploy of OVMF binaries
      generalize deployment of self compiled firmware
      use cdn debian mirror for backports as well
      fix(start-efishell): argument passing to qemu
      docs(secureboot): fix logical issues in example
      docs(secureboot): make markdown better readable

Hung Tran (1):
      swupdate: Enable SWUpdate for RZG2M

Jan Kiszka (19):
      scripts: Add make_release helper
      Update RISC-V snapshot
      ci: Mark riscv64 job with allow_failure
      linux: Factor out cip-kernel-config and use it for 6.1 mainline as well
      squashfs: Fix vardeps for SQUASHFS_THREADS and SQUASHFS_MEMLIMIT
      squashfs: Calculate a smarter default SQUASHFS_MEMLIMIT
      edk2-standalonemm-rpmb: Update to edk2-stable202305
      swupdate: Add missing libebgenv0 to swupdate images
      customizations: Select EFI Boot Guard as bootloader in swupdate.cfg
      efibootguard: Update to 0.14
      start-qemu: Pick up architecture from .config.yaml if left out
      initramfs-crypt-hook: Add missing lib for bookworm
      Make CIP_IMAGE_OPTIONS reusable outside of isar-cip-core
      initramfs-crypt-hook: Remove needless differences between clevis and systemd scripts
      initramfs-crypt-hook: Service watchdog while setting up the crypto partitions
      x86: Harden watchdog settings
      cip-core-image: Restore CIP_IMAGE_OPTIONS default
      linux-cip: Switch to 6.1-cip release
      linux-cip: Update 4.4, 4.19 and 5.10 to latest releases

Quirin Gylstorff (16):
      Enable Images based on Debian 12 (bookworm)
      wic: Use INITRD_DEPLOY_FILE instead IMAGE_INITRD
      start-qemu.sh: Add bookworm as distro
      efibootguard: use debian folder from salsa
      secure-boot-secrets: Use distro specific snakeoil certs and keys
      initramfs-crypt-hook: Add support for buster
      linux: Add missing kernel option for LUKS2 encrpyted partitions on buster
      initramfs-crypt-hook: Add libcryptsetup-token-systemd-tpm2.so
      initramfs-crypt-hook/systemd: Address shellcheck findings
      .gitlabci: Enable encryption for on buster
      doc/README.tpm2.encryption: Correct kas option
      swupdate: Add recipe for 2022.12 for bullseye and bookworm
      initramfs-crypt-hook: Fix Error Messages in case of missing binaries
      classes/swupdate: Correct task_order
      swupdate: Patch to add the missing build version
      swupdate: Update to 2023.05 with wfx support

Sai (4):
      doc: Define versioning and release policy
      security-customizations: Fix broken sshd_config in bookworm
      kas/opt/security.yml : Change password to fit pam_passwdqc policy
      cip-core-image-security.bb : Add pam-passwdqc package for bookworm

Sercan Sari (1):
      initramfs-crypt-hook: fixed function names

Srinuvasan A (14):
      ebg-secure-boot-snakeoil: drop space in remove override
      linux-cip: Update to latest releases
      Kconfig: disable RT selection for 6.1 mainline kernel
      recipes-kernel/linux: Update cip-kernels to latest one
      image_uuid.bbclass: remove rootfs class
      classes/swupdate: remove image_do_mounts
      Drop redundant expand=True parameter from getVar
      kas-container: update kas to 3.2.3
      recipes-kernel/linux: update cip-kernels to latest one
      linux/cip-kernel-config: Bump cip-kernel-config revision
      swupdate: remove BASE_DISTRO_CODENAME override for buster recipe
      recipes-kernel/linux: update cip-kernels to latest one
      recipes-kernel/linux: update cip-kernels to latest one
      recipes-python/shtab: Update shelltab to latest one

Uladzimir Bely (1):
      IMAGE_TYPEDEP:swu: Don't depend on wic

venkata pyla (11):
      image_uuid.bbclass: create /etc/os-release file before do_rootfs_finalize
      scripts: Add script to test different artifacts in the image are bit identical
      .reproducible-check-ci.yml: use repro-tests.sh in the CI check
      .reproducible-check-ci.yml: Include swupdate artifacts in reproducible check
      .reproducible-check-ci.yml: Drop 'base' in job names
      .reproducible-check-ci.yml: Include only files required for RB check
      repro-tests.sh: Enable html output in diffoscope
      squashfs.bbclass: Fix file timestamps are not reproducible in squashfs image
      swupdate.bbclass: Fix file timestamps are not reproducible in swu file
      .reproducible-check-ci.yml: Enable reproducible check on bookworm
      kas-cip.yml: Update isar reference


-- 
Siemens AG, Technology
Linux Expert Center

