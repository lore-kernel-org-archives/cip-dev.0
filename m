Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66080C48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 09:23:16 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web10.14152.1707384192396171145
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Feb 2024 01:23:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a77fovhm;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrucCkRRgUiB/uDjKRqFdLR6iw3c8UtRPz/upK145gLTz/UVPiwyLu0quJ+QM+9Piuz/A+HqSiU1Pn6cREQ/P7vWeuBny6L6ly4gUOypqfbJsHg1vp7L7rYWhCTDvyq+V+YQs39i6ETUzrxGYbqvFmgWR8Zm6uEk5dvGy7blKfGbUsjBYzDjmRWVO8TE2G5tkGv2AxpA6UUKPnAmA48xsXuX+q/FDVKzFDZxH2XACADwSifw+OVtJSO5U+t9vgcYIfrBD/KgDrK0bNWD1ZWmhNhPh2RdhuivVMDcGLaN6zBGnc+Z8uC/4XDwwhSyy9L1PW2xNOsxRhl+9fUdIF8pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ0Y8e4o1FwBeBf4Vd6xlnrcCNWK5viBa6v4wb2ySSQ=;
 b=MHEiN8kOdEHiEXIjxP/L7w3dDFZc1Ok+IapEEE4xakE0Ck3ToTGSGtA+nhyO8wVJk1D5GHP3OHO/fE/xnupfCHpV0GyS59Ym/V64fi+KxFAFzpHfaU979yqOg9zPqJkcBC2SCVzeLNumXsj6TdF1bc6SMqE1oP7stoUhtyiW4iqkK+PsazF6gm8FKjM8Iz0B+V2HfAHxJoCHwaf3wNSfLao27grECTWkAXc2gixaMPl/RLw95oyL2CCCOE+0HXYxMig2Lvx4rpvsz+18nK8qjzar5riv5GWwjxuI1PTF/tJn3F560KKotAM3C1xSbxCa3XLeOktu97TIthFwmZ2TPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ0Y8e4o1FwBeBf4Vd6xlnrcCNWK5viBa6v4wb2ySSQ=;
 b=a77fovhmytx1umjEvhpxhdWHIOG+O7Z26RKKM0B4WEcrBwduPDGOTaMinmQl90rIMJJHApn8qsoyEvCA4MTATlyvM9VUefEXRUZPzf78t+8KXnLw/jLrIbzGWxpH1KcHHCUXN9+V9JexNDTdfUwtggDCx4ap0sipPhsl+vhA7nd+QTS84+ysDiOe4LBw2HmB1y64LifXRUMrs07D9U18KxFH4yTgewRe0C03peirSO60mCkSMhsO3m6WhpFAZ4IzBS92RxLrE6Fnoj0y16Se25PlcWNd/j5aNUrKiI7l7urP83DndFkvG4t6SKSr+HgQuTL9Rz553EnprVIUFFhVrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3623.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 09:23:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 09:23:09 +0000
Message-ID: <16642092-27fe-415f-bf4e-41a8a239b946@siemens.com>
Date: Thu, 8 Feb 2024 10:23:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.3
To: cip-dev <cip-dev@lists.cip-project.org>
X-Mozilla-News-Host: news://news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3623:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9e26b3-8d7a-4967-fae9-08dc28879083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fagwXRK65yt/Mld/MuCxHVavxX4EwjpEkTXILLgF41ehmxjNe5Mi1nqqQXPRyTl86uqWbcG2wD+JHoW1RpOmSWNVyoGtCYav6JUrmQ9pG2PYTgjFE06ciTWGH5CkFpznh+8BlFrY+znTlnqRYUjJ+AW5r//JmWLBf737P0230RRuIekdyUISIN6OHqahfEsCHS9D7ScU5K7qOOVze4m8KEuk3G1NK5m2Un0ZWuL9wBbXoavAoratR+vQPZ4JayFIDKOhgqP2yNPUBe17xHG686RvsfCK1IOl3cQaz70mH3i13n72QxbcH9G1Kd+M5NXad5pMPjEMubazKUHXOj1lMbzxPd46gknZNJNlHqTEvge1NU5IQxkaX0N6zLYiRBpnOxixnpvDd8wpsdrB3+F6+cByDBqO38jg4AgLFWP5uWRGF1j/fhn3tQxdT11wlgDVfBiL6Gd7090NhKtRuEcdFcNhTozBMtR3yQHQptIEVKcVrezp5oFBX6a2TJGD4raO8Ok9Z4SI80Z0l2kZ3GTxN/eRZuarIwuDKVs2gZsInsDlnQ1m1HL7hVq97gA9sZjH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(38100700002)(82960400001)(6506007)(31696002)(83380400001)(6916009)(86362001)(26005)(41300700001)(6512007)(2616005)(36756003)(8936002)(8676002)(2906002)(6486002)(5660300002)(478600001)(66946007)(66476007)(316002)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHBSQWRaV21UM3BvUlZoYU13MWNxVWxPdTZnK09HS3phbmlON0JwVFo3b3B6?=
 =?utf-8?B?Tjh5VlB6VUk4cE96OW5XbERLMkhLTzJ3SFRVeW02ejZSUm5qb1p0NzdrSEZP?=
 =?utf-8?B?TjZoODVMbXFac1VMcGU5T2dQajgxUWpQMlNVNlFodERyWFplRExLbjlOdDB1?=
 =?utf-8?B?S045YVc5QWgzL0hRbkNMOG16SjlQQklnNHJuSU5PcDk3eHg3YlYvUVpSRmd3?=
 =?utf-8?B?SXZsVG93aUpPZzFOalp5NjVQc0h0R1AzNzE3QmFqaUVKRVoyRTZDUEZibXNi?=
 =?utf-8?B?UUtIV2d5RWl3dFNMbDUrNGovSnJOQWE4WmhCb1p1Q2haNll6RXNyTG82OU1W?=
 =?utf-8?B?V1pzY0t4YXJEMXh6V1NiK3dSM1VlUkxQT1lmWjg4ZHk5L2VzMXNtYjdxUi94?=
 =?utf-8?B?R3JIOUlDd21UOTNMdUxxUzBuNkVRaTNZZGxiOC9VbktnVzZDQk14NXZnY1hi?=
 =?utf-8?B?WlMyVndDV2RheVplZ2FXeEVaL0NFY2dPSzZHQXZaMUo4K2ZoRDUzVGRLcHhM?=
 =?utf-8?B?VVVhYVlXK08xUDM1aGRycE53UGYwUFNLUDYzdU9yczhxVXNUa0RpWEhON2Iv?=
 =?utf-8?B?L1V5T2JQVm4zRng4OTIyaFMrU0FpL2hXUG9sT3R5QUVwL3p1YUsybTZPdkVp?=
 =?utf-8?B?L2pHbFJMclRCNktXTmNTZUsxR3piQlc4TFhOUzRjS2xJRE1iSDBxalVOMk5D?=
 =?utf-8?B?ME01TFBmeVpNUmJRU2JHZUFlazc2M2syUzB2dzR1b2NUdWR1aHlEcG95UnpO?=
 =?utf-8?B?bDFtd1MxUlFBMDFyUWpHbDVqN21CbEFpUmF4WmxhVEh6bkxHd3dVQU01UVpm?=
 =?utf-8?B?cmFJTUUrZUdqditnUzV4Y0lxT1M0YnA1cjlHZDV6b2ZHWkV0TnBOZ0FTdkln?=
 =?utf-8?B?RytTNkVjbG1NUC9BeDJwZXM5dzBOTGpSUGRzbUN1Q1lnQmRpbjJGRTcvRld1?=
 =?utf-8?B?Z1o1MkQ4NHNjRFVUdzdwRXhpcS9yVnpBTGpZSHpyZk04UlVyMGF2bUptaHdC?=
 =?utf-8?B?K1FDWU5sMWtsUGVwbStPdGxqZWdRSXBjOEtodDdyVm82dGw3VE1yWGRudXdN?=
 =?utf-8?B?Ty9mR1dQZkdWaEYrQzhpYWFyVWEzaGVIWk1QU0xZQlkrc2FGaW1wV3RocTNk?=
 =?utf-8?B?TGFHbHlPQkJMNHJTeTJBU3ZkUnovNjFvOS9HZnFwWjZRRVRqMXZOWWFHd3Vw?=
 =?utf-8?B?VzhNYVMxT0VCb0dIbWN2c3dOVEIvU1NBOUxOd3hvN0kzZW5COWNHcDhYTlY5?=
 =?utf-8?B?UHpzUnBjQ1pYa255VzJVRHpHUkpEKzJEdmc3UGcvNmE1TmxtbFpWa2RaVkVK?=
 =?utf-8?B?UEpvSy85Tkh5RzJuWXBkb0dwbWtlazlkTm9GdjRwc2xZbXY1NDJ0NjY0YkRi?=
 =?utf-8?B?OUVHckZmOG9vWngvcWhCajA2d2x1SWNORWcrZVJKRmZ1ZS85Y0o1S09WZnY2?=
 =?utf-8?B?ZmUzejlFdjF3V1dXOXkwNkVLWExwVzFmbjR6TGlraGVLb0VrVTMzcXcxSE1v?=
 =?utf-8?B?eFB0QmZzNzU4R29UeFFUQXh0QWxTTlVoT2xNeW5pMXhyeGZPT0xwZE5RU3Bv?=
 =?utf-8?B?aXBoTXJyRnpwdGdYL3NxVGlZVVpFWE1hM3prTjRCZjY3cW9RenJINVI3dS9x?=
 =?utf-8?B?NU1xc2RHQXM1UFVMZmZVNEd0WGE1bTk5REdTdGpodjFTRHNnSnRjT0dFUkds?=
 =?utf-8?B?bWttaEJMd0Nkb2hJZmo0V1dJU3cxS2VwV2Z3OTBNQk9TejV3K2hZT3dLM0dt?=
 =?utf-8?B?eXlyVEhKUjRkeTRLcUdhK09iY1FUSGkyRUdwZHRnWXU1RDEyU2tvT2NpSEEv?=
 =?utf-8?B?VE5yYlNXNmE2ekV3NTBWVG0wKzNKcHBkK3ZXRGt0WndxYXlWSXp5SCttYk1s?=
 =?utf-8?B?aWNMbTZGQjBCcU5FUHV6dGRYb0hteXdvTFFWdVludDhpcXNmbXZkUTIzVmwr?=
 =?utf-8?B?M1o0UmRJMHdjS205K3prRTlHSktnNzBXN2dtTDZHSjdnMlExWXV0M1BSbnFi?=
 =?utf-8?B?T1R1QUdkR0hYckozUTdHMWNxbzVKRm4zMVpRcVBuWGZvKzJjd1JxbVBKelA3?=
 =?utf-8?B?ZTd1MG41NGRPRGpqWTJNdjREays2clUyMkwrc2NOTFIzbi9HUGdxbC9lZWJ4?=
 =?utf-8?B?RUdQQnNXWkFKUkhyd1p5K0hsZlNhMzJFZlA0RGVMdmVYUGpLem5IOGZPOFlS?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9e26b3-8d7a-4967-fae9-08dc28879083
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:23:09.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBt2JAIRoOv1uMJuMMBXHvnCde2jpF1LlfcTtHkzt6T2n/GloscWxaQPK5Lom3cT9ll+2acphvTgrhdcCQqw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3623
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Feb 2024 09:23:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14917

A new release of isar-cip-core is available.

56 changeset, 7 contributors, 100 files changed, 701 insertions(+), 499
deletions(-), these are the stats of release 1.3. We are still improving
the reproducibility of images, also in this release, so there are many
related changes. EFI Boot Guard has been updated to the later 0.16
release, and there is now support for updating also its binary, even
though not with the same robustness as itself helps to update OS images.
And the SWUpdate packaging has been updated to latest Debian which comes
with a fix for a potential local vulnerability (wrong permissions for
control socket) as well as a switch to WolfSSL for license compatibility
reasons. Full list of changes can be find below.

Thanks to all the contributors!

Jan


Adithya Balakumar (1):
      wic: Set fixed partition UUID values

Cetin, Gokhan (ADV D EU TR C&E) (1):
      initramfs-crypt-hook: Add required kernel modules for upstream kernel

Jan Kiszka (17):
      Confine wic-related imager installations to that image type consistently
      linux-cip: Update to latest versions
      linux-cip: Update to 4.4.302-cip80-rt46, 5.10.201-cip41[-rt17] and 6.1.64-cip10
      linux-cip: Update to 6.1.64-cip10-rt5
      linux-cip: Update to 6.1.66-cip11[-rt6]
      scripts: Add automated recipe updates for linux-cip
      linux-cip: Update to latest releases
      Migrate RISC-V support to Debian sid
      Kconfig: Fix dependency of security extensions
      start-qemu: Fix inclusion of QEMU_EXTRA_ARGS
      linux-cip: Update to 4.19.304-cip106 and 6.1.72-cip13
      u-boot: Update to 2024.01
      ci: Reduce build runs
      linux-cip: Update to 5.10.208-cip43
      efibootguard: Fix broken SRCREV
      linux-cip: Update to 4.4.302-cip84
      linux-cip: Update to 5.10.209-cip44[-rt18] and 6.1.75-cip14[-rt8]

Quirin Gylstorff (27):
      scripts/deploy-kernelci: Format python code and remove unused import
      customizations: Add variable to set the HOSTNAME
      customizations: Move ssh configuration from postinst to sshd_config.d
      security-customizations: Add dependency to customizations
      security-customizations: Fix shell error
      security-customizations: Extract sshd config from postinst to files
      cip-core-image-security: Move packages to security-customization
      customization-kernelci: Add dependency to customizations
      kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
      efibootguard: Update to efibootguard 0.16
      swupdate: Update debian folder to 2023.05+dfsg-4
      swupdate: Move signing to seperate script
      swupdate-certificates: Fix shell error
      swupdate-certificates*.inc: Add missing FILESEXTRAPATHS
      initramfs-overlay-hook: Get Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
      recipes-core/swupdate: Cleanup swupdate.inc
      Move efibootguard specific settings from include to class file
      efibootguard.bbclass: Add functions to generate the EFI_ARCH and EFI_LIB_ARCH
      efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
      swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
      swupdate: Extend sw-description to update efibootguard
      classes/swupdate: Generate swu containing only efibootguard
      doc/README.swupdate.md: add new section for bootloader updates
      wic: add part-type to squashfs/verity partitions
      efibootguard: Update to 0.16-2
      start-qemu.sh: fix qemu with encrypted paritions
      swupdate.bbclass: Move ebg_update to efibootguard.bbclass

Sai Sathujoda (3):
      scripts/run-cve-checks.sh: Add script to generate CVE report
      scripts/deploy-cip-core.sh: Upload dpkg-status files to gitlab CI artifacts
      .gitlab-ci.yml: Run cve-checks job only when it is manually triggered in the pipeline

Sari, Sercan (ADV D EU TR C&E) (1):
      added configurable pcr_bank for clevis

venkata pyla (6):
      reproducible-check-ci: Include swu files in reproducible tests
      swupdate.bbclass: make signed swupdate file reproducible
      swupdate.bbclass: Use root privileges when creating swu file
      .reproducible-check-ci.yml: Stop running in jobs all schedules
      ebg-secure-boot-signer: sign artifiacts reproducibly
      distro: fix dosfstools-native is not applied to security target

