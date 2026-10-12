Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8C9CA9ED0
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 15:59:08 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16709.1791820738217635699
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2026 08:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uCLqflfO;
 spf=pass (domain: siemens.com, ip: 52.101.66.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsxVDqUu4ipVgKHTMrAddfDTK4kCwIlEibF5lGjSgBUzYnC87lqRDN4t42PykSKvRFfLwPPQaVtnE4pKQHbKFLcQwm1o36Rom7KL9E8QyGqir+VlvV5VQGlEP0IA0neqoFIpLjVRAH/4k4bnvRkLthnH8FvPnWN8y1JZfCm1RYrYgNKQKaEiOdxZb4NzI+OqxXYDWu6ozxovIVvhHC9kWwa1l6/JcXCHwsWVr5HLD31va6d96foqxCazytDsMG9WbcoGoR/keDI8GhepzURKiZLRVPgQieUlThkQgfdTVZqeesoRotPLulcMpdz/UWMpO3yeSG/Y/8hoJH3j3mXPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8L8vAAIPtV192Dm7T5tlENvGwRPgAFPKGh65kokvZA=;
 b=G4gMJ0WJpiQaAgEVIIoWLI4Jm7Zkb7dokikSf4YCXa354QD2zRm/BKDEfJDa86mXiBQm0XQybeJPL0eoysZjAvEZ9xrj4huxyT1Ig2xdtbLf22+9QiCa2Q8xGuQeI0HrWu5wN18BpfkVA+ye4tfqj2pMJR1iw2N6u4q7AOp5sjjrsMdi1m7r/uk68dCF3Czz9Wbex2bU8jty2+WRyCmShwf3aT5pj2xMYzhcTorbdl2iCy3cBK9RNDfWkELd0Zhog+BigBRCjpKLYdRfZQQzHRJI2ojwV2bLGnloQ2mYEmCYeZqEUeaK4g8DnM+3yzzWCQCDdnw7aW5UtnCNw22Qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8L8vAAIPtV192Dm7T5tlENvGwRPgAFPKGh65kokvZA=;
 b=uCLqflfODd/iuq34zhoZMyyNehdOQTgvXfs5z6cSf84wqC6nldNmzFYba+hy0oguccrXz6rOgwQxOcMtUq+BimjbolJgp0XaPjNlYX8o56+egRNlAcgpUgVD0hcF+e5eZYGG9WbEjAxxuhwZomXQe2zhL4gp7quF5HR4+YWjYPSCtuWLT4auXT3dxWBAjTlc877ncv+912I4ZBp+J3EFhkOOnTTB7hE55FTPnn2+JDWm54/DZAFPqRwNt/FrrvMavR/WF9ugBLDZAWb8GGDbuYT0ONGJ0kXowbd7RpRNw8poSv26A5hxmi1E2Vbv/p/pKF+Y7mlhvnE5Wifsjl/FXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB8344.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 15:58:52 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 15:58:52 +0000
Message-ID: <d30748c5-bc97-4331-ba81-ad63f11817a9@siemens.com>
Date: Mon, 12 Oct 2026 17:58:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.13
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: fa60af3d-0c55-49cb-6085-08df2879b67a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	jatLBDKZIdGnMbnfr4pBOuQapS6fUejfB6/grVRGmMAoVHp7EHMHZ7Q5sO3yW4kLDkLzmhDEilfk9LCZcz0FfEYYnIsdfY6sa/ESUD/u/ur13uZVOpxz2PTaFk9TEzOsVC+Br2UaM0bfYfWu5rWBK4GllDBDQ/XKzvTvSAQkluWybAhwIM67XTfWuqvG64MByqOoT1JqGj58JIkYpo5vQjBuyJ+1sITXIoO4DxZ35lWORCBfas3k/YOyYXBYJJ92kJDq/Iqo2x8etCB/E0DeG1YuXxk2KUJty06sYiv4MEIJsUJE+KWbcBw0amoXx1ZH2DvzljNS4KMIFgtmvAADWkvHc68H+3qZ3GlFxpo2bkJeqzCMpGhDAYzMaDqP9hFQ+sUw2gUAE8AiTFNofH+02oabK9t6Dw4ACOTQTYo8XxjSSuVTZwtVq9X1yk2dJQEGZyZpnx4w9W4vXqyUQC+A6Nf5aJyV/6h6DW+H6zCU3dJ8msu65l5fKhBnMs36eLT+pI0O01Z+H7gA9flFuSRX9sXn/hvB8eKAsYlRPwj9TfdcbI5rAo2Rab5XtJVy8Ug7yf9Y1EaoStoACyhpDUOZ9NFxQ/5PTfw+c6iJOfu4QSTxQkqRYjykJlyIUMo9vF97
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VExQdkUxa3lxOU80OXZ5UlhwZjNaMDNkY000RnNKbWJPZW4wcGdRMGE2QVhk?=
 =?utf-8?B?Z2hzUjJQU084cjJDWnhlM3BsY0VyWkthdTVYanVROC94OUdPWSs4WUF2Q05R?=
 =?utf-8?B?VkhVQ2FoQkxEcDMrQ1MzZ1dvUDYrblo2cjZSMEpJRGppSnk2Q3p1azVUNExi?=
 =?utf-8?B?QmszWHdPY3pNUnhLeUVCRWxyRTRlcVpaRjJHbUkzTng3NkVyRkc3anA2YSsv?=
 =?utf-8?B?M01PYXlsU0NpeThEb0hmUkxFd3VZSVhldDB6b2gzMHlOWFVNVTZPcUZIUTJZ?=
 =?utf-8?B?YVI5QStDOGJtU0pRVHF6a3N3Z3Nxb3h1ZytjdmwvZ1VsL1BOQlFRS0lTZEgr?=
 =?utf-8?B?TG94NmxxUVd4bG1RWXNUVEd4cGRDUWhKTGtzQ1lrTXY5bk9BZjRWYkhGdEVH?=
 =?utf-8?B?TnRnbWszMDYwVHVwMndUSDlveTBNeXZNV0JqNjArajVBblFTZmJoRGRKREpM?=
 =?utf-8?B?N3JhemNmdkZIR2F3dUZjMUJva0VwNnBSd1FXTVFiODcrK0ZlNEttTGhTTTE0?=
 =?utf-8?B?S2JrWU94NG90SThMekNybWJ0N01VS1lQOU1LRDRzQlhrampFL1hMZ2NRcDFp?=
 =?utf-8?B?eGlDN3BGTVlZcExkdVMzNlpZQkZNcVA0QU1vRmthZzUrVWN0L1pTOFNsWFlX?=
 =?utf-8?B?NHVheE91TEMwV2l3czVzL3NYaXdJL2loQTdTb3oxV291NWhxSGdtblVLMGhV?=
 =?utf-8?B?dEJsbk42LzVTcnBKMXM5Vy9yTkNkSlJmYTV4eU5hdVlXb1R5N2huTWgyYWFQ?=
 =?utf-8?B?TXdBRjdXcE9QRERWNWVCekFSMi9lUGZBekZ0enE5VHJPNkFFWUw4V0x5NG52?=
 =?utf-8?B?bFduMkxYM1ZkMnlUWGlZb0lOeU5IclVqOTRsOVJrcUwrUS9LTDNJNDdXR3Yz?=
 =?utf-8?B?WUl1VWI5RlpjVUxzeE9tc2tOWEpwYTUxcnovTUhOYzZNUEpyemNmWjV6cUl3?=
 =?utf-8?B?WVBiRmVHOEk4RGgraDI4RzU1b0xZVVkvdWZPb01XTUh6OXhldVh3WVg4TGxv?=
 =?utf-8?B?aUQvZFZWSlY0V0FsbU5YTm9HN0lCUmFIOGFpTTIyTXIxUFpTZnQ0Rk9Ud3Y2?=
 =?utf-8?B?aGh6bFMzUUJlQVAzU1NMcHZUcWF1dzhIUFJaWUhRbzQzcW1wOXo4cU9nb0d2?=
 =?utf-8?B?U25OR3dUMzdtRGVCV3JvMjZ3SzcxaVdySmkxVUhlUkdGbTgzTWllbEZneElE?=
 =?utf-8?B?KzJQeDRtNSs1UmZnWEZqQlBVZTBrQ3JrVTYwcUhieDBOUUhYMWhOWjQvVHho?=
 =?utf-8?B?WURGR25nNVRMUkMrUjFvWDdkNVdWd1dMb2NzTENsNEYyK2ptTXdJb0dOQ0lm?=
 =?utf-8?B?dmYzL21VSDI1clRmM3FrTU5hdlNuazk3aWhyVi96N3VWS05UV0Faa093SXR1?=
 =?utf-8?B?YTg2YWVab0llRkt1TFJpbFBSUWVRb0ZNaFBKYnVLU0lEYXVaMjRYOURYcWZi?=
 =?utf-8?B?aTlPbkpSTEVMNXVBM2pEUno3eXVNWTVjYlVzOHQyYmtmRWppbjVpVTcyZVMv?=
 =?utf-8?B?YzduVFZTeWM4ZjRZZy9kd1ZwSkdlSlNJMERFRUkzSjJSeHBBWFN0ZGsrWU51?=
 =?utf-8?B?VWNYUEFTZ1puSnd1SVVFR2Z5ZzBxMlNHbnFJVHgvSHp4bVd1YVVMckc1Q3FO?=
 =?utf-8?B?U3J2SW1zYUs1NFl0dUY2Y0lmMkxuRmVDNlhzV2gvQnhZYTFCYUx4T2dqRGNG?=
 =?utf-8?B?b2Y1d1cwMURiKzFKaStlejJsY3lGNUxySmZXSkFuWlJpSEJ3S2lIbkpsQXVE?=
 =?utf-8?B?RW5uV2ZVUnRzQzYzV1EvVkFoeGpBNko3WENQQVhuTDNIMUNEcjNidy9xQ1Jo?=
 =?utf-8?B?Q1d5Mjc2NXVCS3FWdllab1VzMWFDQnJja3RIL3krNVJPV2ExdjcxUysrUDFU?=
 =?utf-8?B?UlNqRDJpZUpFMEN5anhqR0lTMElaZ1ZINjZ3V2l1dm8yOXVGQVh5NnJTYTly?=
 =?utf-8?B?czNYOUZmWVhUb0lLcUJCRGZwenZDNWZBQ1Y5bUVIUDEzK28xU1lCSUI0R2Y0?=
 =?utf-8?B?RHFodW1uaTJUaG9sUVF3Z3UvTXlhdE52Ukl3cUFQTnkwSC9ic0lnK2k1VVpH?=
 =?utf-8?B?MUpqNm15UnA1dVRTbFNHL3ZxRGdEdUhTL2tjQnc3MzY5UU80WTM5OVR1K3M0?=
 =?utf-8?B?ZjlPc1JaaHI3UXFpR21MOWxiMUdUWkMydVh5SEd6Y1AzS0dUMEVRb004VDY2?=
 =?utf-8?B?V3hob3BCUGVuUU9uM09RSEwyVHdGRlIxVVhzdmpTYkNBdzhROFJFY21lSFl3?=
 =?utf-8?B?Y2lsMVIzL1kzbE5JcjMvN1FZQkFtWFBYandkQUQxbHRxdkxRNWRleVlNb0dI?=
 =?utf-8?B?VE5WSkpGaWZSMXVZcy8yVjJqc2NTTFpnZkEvT2puemhodkxxVWt1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa60af3d-0c55-49cb-6085-08df2879b67a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:58:52.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UrM9rWv6oRMfmp4bZruOrgwbCnbg2Nejp5NtyHem12Mt+zWwenhfsSXrXN2NQmxJUSLbzWpY46Nc8LhVyQEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8344
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Oct 2026 15:59:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24445

Slightly delayed due to a long and valuable conference week in Prague, 
this is now the Autumn release of isar-cip-core. We have 71 changesets, 
8 contributors, 99 files changed, 5726 insertions(+), 637 deletions(-). 
That's quite a bit a code addition, I'll explain below.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.13?ref_type=tags

This release brings support for the new rootless build mode if Isar 
upstream. We default to that in our builds, but downstream users are 
still able to use the classic privileged build as well. Along that come 
updates for Isar and kas.

Factory reset has been improved to securely wipe encrypted data 
partitions if the TPM is not reset, thus encryption key is kept.

Another technically small but functionally important change: We are now 
demanding UEFI Secure Boot to be enabled before encrypting a partition 
on first boot. This ensures that the key is not accidentally left 
unsealed behind. Along this comes support for enrolling UEFI 
certificates on first boot as well.

In this context, we renovated our reference support for OP-TEE with fTPM 
and StMM for ARM64 and added patches for U-Boot to fix measured boot via 
fTPM. These changes were very valuable for testing our image but - and 
that is important - are NOT yet ready for being used in any production 
firmware. Stay tuned to the respective upstream projects instead. The 
changes are also the reason why we have a significant code growths: we 
are carrying lots of not-yet-merged firmware patches right now. Will 
shrink again over the next releases.

Last but no least: There is new board enabling for the Renesas RZ/T2H 
EVK. And we have started to test forky (future Debian 14) and sid 
(unstable) to detect upcoming tasks earlier. Some were fixed, some 
remain, more will come.

Check out the git history for further details.

Thanks a lot to all the contributors!

Jan


Alexander Heinisch (1):
      initramfs-crypt-hook: Fixing comment on prereqs

Badrikesh Prusty (4):
      linux-cip: Update to 4.4.302-cip113-rt62, 4.19.325-cip135, 5.10.263-cip76, 6.1.182-cip59, 6.12.101-cip29
      linux-cip: Update to 6.12.108-cip31
      linux-cip: Update to 6.12.111-cip32
      swupdate-handler-roundrobin: Fix Lua version for bookworm and bullseye

Felix Moessbauer (1):
      introduce helper class to set secure boot timestamps

Gourav Singh (2):
      recipes-core: ltp: Update to 20260529
      scripts: update-linux-cip: Add automatic GPG key setup

Hung Tran (2):
      Add support for Renesas rzt2h-evk platform
      ci: Add rzt2h-evk build target

Jan Kiszka (40):
      Kconfig: Drop redundant target exclusion for kernel 4.4
      docs: Relocate iwg20m README to doc/boards folder
      linux-cip: Update to 5.10.260-cip75[-rt33] and 6.12.95-cip27
      linux-cip: Update to 4.4.302-cip113, 4.19.325-cip134-rt49, 6.1.177-cip58
      Update Isar revision
      optee: Update to 4.10.0
      optee-ftpm: Factor out common recipe bits of qemu-arm64 and ti-k3 targets
      optee-ftpm: Update to TPM reference implementation V184
      optee-ftpm: Apply security fixes for V184
      README: Document the QEMU version requirement for fTPM/UEFI key storage
      initramfs-crypt-hook: Fix TPM shutdown to prevent invalid PCR states
      linux-cip: Update to 4.4.302-cip114, 6.1.182-cip59-rt31, and 6.12.104-cip30
      secure-boot-efi-keys: Add recipe to create EFI certificates
      cip-initramfs-functions: Add secure_boot_enabled helper
      cip-core-initramfs: Automatically deploy EFI secure boot certificates on first boot
      u-boot: Add patches to enable measured boot with fTPM
      u-boot: Refactor ftpm-stmm.cfg to enable measured boot for all
      u-boot: Drop obsolete config workaround
      initramfs-crypt-hook: Prevent encryption without secure boot
      doc: Update README.secureboot regarding recent deployment enhancements
      Update Isar revision
      ci: Select rootless runner
      optee-os: Drop redundant CFG_EARLY_TA=y
      optee-os: Move common fTPM/StMM related code into include
      ci: Fix and improve lavacli container
      Kconfig: Let disk encryption depend on secure boot
      Allow to select EFI-based factory reset when StMM firmware is enabled
      ci: Use debian:stable for reproducibility test
      Update Isar revision
      initramfs-crypt-hook: Also set watchdog when using u-boot-based firmware
      linux-cip: Update to 4.19.325-cip136[-rt50], 5.10.268-cip77[-rt34], 6.1.187-cip60
      Add SECURITY.md
      secure-boot-secrets: Strip passphrase from forky key
      edk2-standalonemm-rpmb: Update to 202608
      customizations: Switch to dhcpcd
      initramfs-crypt-hook: Add forky support
      efibootguard: Add missing imager recipe dependency
      Update isar revision
      Update isar revision
      linux-cip: Update to 4.4.302-cip115[-rt63]

Quirin Gylstorff (12):
      initramfs-crypt-hook: suppress stderr output from stopping watchdog
      initramfs-crypt-hook: suppress stderr log from cryptsetup
      verity.bbclass: exclude unit information from verity data
      update Isar to contain rootless changes
      use run_priviledged instead of sudo
      update to kas 5.5
      switch to isar-rootless
      update README.md for rootless build
      initramfs-factory-reset: Ensure that '0' disables the TPM clear instead of enabling it
      initramfs-crypt-hook: Move service watchdog to cip functions
      initramfs-factory-reset: Rename target to target_device
      initramfs-factory-reset: Wipe partition before creating a new fs

Shivanand Kunijadar (9):
      swupdate-handler-roundrobin: Update revision to latest master
      swupdate-handler-roundrobin: Keep default lua version as 5.5
      swupdate-handler-roundrobin: Remove adding additional lua version paths
      swupdate.cfg.tmpl: Add digest-provider option for signature verification
      .gitlab-ci.yml: Actually set release to sid for sid targets
      .gitlab-cip.yml: Change CI variable to CI_RUN_UNSTABLE
      Enable the support of Debian forky based builds
      Enable CI image build and test support for forky
      Fix file timestamps are not reproducible for EFI certificates

