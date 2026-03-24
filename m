Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73137F54AC7
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 14:39:58 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21305.1774363188982084301
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 07:39:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zttH9mBx;
 spf=pass (domain: siemens.com, ip: 52.101.69.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/vMC/8aXVl4IpnwxsChe6hAzIHSWNLNCVT57caAkrSN2L/BRNfDifpMCoiJyM/cxKiR5bM8wZ9hey3DZAjNQShApsHpjI2wKqQsi7eBfwZL8wOR5siOi/Qo7vdDiB7t6KYSIDj8AkYbkBThfVi64UVYZMBZL3novpm1CxjBFSCU5iikXQKQXQ8kcAgbofNsFdwBNnHV5ybOv1nQPiWdtEhcuDb64g4d1aui4AGEfRw3um3NNPBe5JEwJ7ahm+uKciQLGocuonrk95lYo78fYXgoEzJXxaYyAhhcXgyDhBbFjkl0t/677jsH/iuhNYvyY/cGiwIRVCHrhBggO3XtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu0kE+wYjCLiZ7clouyxJCq97MMHglTbZUQ5TdtkxUc=;
 b=nwbVIBMQ4q683RBwNkoRLYtpv9oNRr5tOeHaLUio35Dxw4LWUtX/IBEmoVVLnW0RUavSee6eQP6+SwPi2Hh6KmjzptTyx1HKNXNkbUbDiKHouf6GRjYjrcsNwRcQL4FlI0k/l3EnNZbcpOYO8Va3aw173RjDYbQUFQ9rw926lgdhsph4HV0LlqSdqlmuXSUXxp8e/f0q2XfYWy9OJQjIc86QeEWY8KYiMDirO13iLpCoFmeSaeyWkvRgdBYZEY0jFD1yJKS0Ob3QlH5X0GDbRX5D4alHUAgzVm3yUxjkiowvoZfmzCEi1N4+ZrCRWwcAX7g+kOhhCtHnh6vfESThKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu0kE+wYjCLiZ7clouyxJCq97MMHglTbZUQ5TdtkxUc=;
 b=zttH9mBx9HeKOBrO0lYwBFhsEjpHhmfLPsLFGfJlInli/OE8TQhZxBtx5ijUzynLvGnC+QZaUEodKPSM07JSaPT1ppo7aE7AubcsbPTYctrVOrRWPjc4zz1pdTlL9duQHL0ThZwXQYuy/DejLjO3r9OrGmrnDZo+OSl7rrP21/DgLOBMqIcpi/wcJw5aamxlsAulKpiHNn9AwEn1db5z+yzEyrSYtP5VDmZuxR3q54DILvDs3s6xIBoICJ1GVygSuX4FqtnvdWigsc15cz+cG7bbPBcffy3Bjd6T3Xkby1RyXv9fKztIZobkuZLqiA8JDJdkT3eHQAX+Hcf8bTB4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:39:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 14:39:41 +0000
Message-ID: <62e3e3c2-bd72-4d60-9ee9-d460371a0955@siemens.com>
Date: Tue, 24 Mar 2026 15:39:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH isar-cip-core v2] *: Add SPDX-License-Identifier MIT
 header
To: Kamlesh Gurudasani <kamlesh@ti.com>, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, pavel@denx.de
References: <20260324-license-v2-1-1ca6dd83f0e8@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260324-license-v2-1-1ca6dd83f0e8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0388.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: ca53f4f7-9bf5-4635-794a-08de89b32e80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|13003099007|22082099003|7053199007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	pK9hH3+iPQDzFM6xIcIsVRHQCABArixbKU6rP8x9gmnIB6GUjfw+mVn4B00DM7w+1rhxtBvkWSdjk1B+c6ScZltoY7mchAmXN95s3/+8Z8PN0UOILBp2+I1PBzRJB4JPOaMTC92NSoewSyQv8oqHk2/Z3lFLOhXY4a81eK3RpgcZyOcgOLMuXSPnxWRpf7LNVwu9TATLQ20LUR6LAeB4XlGnBFshSMW8YNF4XHWpqlJlaK8GkIQw5EJi9tIWSEl/y6VS7PGtndqzZkS7Fu1F6W5X9IgS6Zqavli90s2EYUmHEig9nF/JCzae7GW7ohVs2p/aTmMjRTWb6y5mO6ki8vPfkaH6IaLf1ZcA+nHo45N2y6K1K/XYt1ap2nKVJbJzVL//H3ymm+nC3bcgb3yDTklokbM9ybu+bRZumsGYgzxr7eVZCu7TtQ73CsgUI6jSeNlgtA/iX/Xk7AbBP7W6COiPDXTYRVXbW7XZoUu23rsq31WWBK4qIDJ4XfX4lNhW6n3c0M+Om/ZN1CQbECT0WQZNiIeQEhISX1zMwNgWhRIvxb4eAOac8ANE4+DMBGDNrM/mniL4uznQqqpNXFni9Qtxdb30JqeZMkpfxkEgbaup6XRYbRYWV1TRvTi6C9bQOoy1ExhbwwmU1zpTCG5+Mt97bTD0qHKX/75fHnYwIJK8NRP2PKRH32z4MoMFxO6Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(13003099007)(22082099003)(7053199007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1pNb0xhaUM4MGFXYk8xanNCMXRGYkN2REpHMVVsRk16NUh4NFNHUFNMcHp5?=
 =?utf-8?B?YnlkMmRvTlB5RlNad2UyakR1WVZQa04rRis0UitlSDJXYXBhaFlWZENtVitU?=
 =?utf-8?B?SE9qZy9yQXNIOS9qSEQzUnpPOGF1Wk1id1dHSXVhTlNGWEhrWE1uYktkbCtB?=
 =?utf-8?B?cEtpK2VnSU5QT2pkeU5reklvVHpKdW5uTUNTZ1NXYUE0Nk9nTzU3TVVKT21K?=
 =?utf-8?B?NEJULzNVWTNJK0Y4d3NQZHorSy9pU09DMFpvekhQdm1FQUtBUHBSY2JyMzU4?=
 =?utf-8?B?QmFKcFp3YWNrNVNGZlA2Mm5MamMvM1g5WFIzT25sUTI2YlBvMjU2d0IrMkZB?=
 =?utf-8?B?Y3YvQjByemtRa0tsRFVMbXJWOFZ5WlI1RUZDbitzUE9TZnorL3dNazg1Wkcv?=
 =?utf-8?B?amdIMnNub3lhM01jVkJqUzY1WnZpOWpCdVpRRjBuclI4L21FUld3RGx6azIz?=
 =?utf-8?B?TGxiRzhjbXVGbGZiTnZuWVk3MzdGNnZKSTBaN3ZrMG5LUkZWWFNoRU84UGE1?=
 =?utf-8?B?Skd6ckNIa2tzczZrK2FTOHl1OXE2SHFIRUN2bzVtOHBjK2Q0NXNxQ0RRTTVZ?=
 =?utf-8?B?YlhCVzV2NTJjdGxYWHNVQnlCcHdSdysxYVlXTFA4b0JBWjdrN0xTUHgydTFl?=
 =?utf-8?B?bjM1dkxsZjh2N3piV1RjZXRuRXpkMVRIc0tuTGxydkdST1lJVldBaXlycXh3?=
 =?utf-8?B?OTNxTUs4b2pCOEdZa2FYczNiQ0VIVG9QV2lkV3Z1RW5DN0VUS2p4Z0RGRVZB?=
 =?utf-8?B?ZEFyblJvQUtEeGIwTVJndDVRcm9ZQU9RQm0wblNmdnViL2JpQlZNeTEramto?=
 =?utf-8?B?OE9nL3lKVnlKdkFjUDdOQ0FzMzlMTDRHeEVTZEdvRUpTM3MxMDJlSS9rYlVG?=
 =?utf-8?B?Z3dTNmRzdkU0QzVkWCtKQ29TY3Urc2tkQjBJWUVZdDgvU29zUVJzMkRVaCt2?=
 =?utf-8?B?bDZ6Q2ZxZFIveUpKK1I3SnpNNFQ5UjRkZmVYbGlqdWlibEVZTHJka2FmOXZM?=
 =?utf-8?B?TnlzdXR6cXVSR1MyTTJwZXhrS2xKR25jT1Q2dVMyZHh4K05PbTJocjB1Wkxp?=
 =?utf-8?B?TmJVNEJRTmc4MjBoamI0TXd6YUE0Nmg0LzgrYTI4ZGV3REhMcDVJSGYyQjh2?=
 =?utf-8?B?aXV0aW9ac2N0S2JDdGJheURYd2pYbDhuUXBSMlBYS0NhRG5UVVBlQUZnM1Iv?=
 =?utf-8?B?S1A4SlhBOWdFZlpINW5wSjNLVW5Hb3ZBUExDRHBMMnJJWStJQ1p4RENieGg2?=
 =?utf-8?B?c2tZSklxcnI5b1g5eXBHMHU0MCtuRkNoazBqOU9OcmFWYWFaZWZzR3l0VUt2?=
 =?utf-8?B?QmJMWEo5NGpQWXpGdy9DdGM1Nkp6RldOek11V0JYaG1EWEM2ME53bU4wcXp4?=
 =?utf-8?B?OWZERjJpRnN4ekY3ME80MEtSRWU0L2NGbzNGems4UEc1eDVpcUtjOHZXR0ZN?=
 =?utf-8?B?elp3U3M1K2o3SG9vMVlQcWt1T24xS21aaVVzK2JZa3hiTFdrVFd4SDducmZm?=
 =?utf-8?B?NEN5SVZ4cmpsQ0crcVdEeFVZUm1pRkNCbXZmS25qSEpCU1Bjem5JT3NmcW1n?=
 =?utf-8?B?eFhPS1p6cEd4TEdIMUxrS1B0MlZIaG5pNDA4Y0JwZU9iMzNvSVd2b0lGa1Aw?=
 =?utf-8?B?NHhEQ3NwOVVBQU1YdHprQTN3WHR2Zm5sUVJ4L1VLVUFrZ1BNRDF3eXhaTWFI?=
 =?utf-8?B?TFdlQ1pjUHBZL1FBSmg1czBUd1pzL08vRGFYb2w1QXlWcm5LQkVGTGJjTjZy?=
 =?utf-8?B?aHNQdW5xaWxlUmtTcDh0aWxTRnQ1eWRNTzNCRGxYbS9NNTM4TFNyRnJsTmJj?=
 =?utf-8?B?QkJrTEZ2MkdaTjd3d1dDTUdYOGZjOUFBa1BTSDVZbWQ2MElvWGp5Zyt1eVpD?=
 =?utf-8?B?eUgyNVAxcXl5ZC9tb3pGKzlDYTA1dkVFaUdrRW1BQ2ptM1ViRWdKVERpNkRB?=
 =?utf-8?B?WmVqS3YyR2FpcVpocnVzNXZtL3kzUnZlUHhEU2FxQmtqUldUT2I1bWMyNUt3?=
 =?utf-8?B?QmQ1K2UwdE1RUGY4VzJpdlVBcTVkM0sxTGN4KytrTlByWXVCdWpKenIwb1hk?=
 =?utf-8?B?RjBRNWlsV2t2MW1OOTM4SlpvOWpQOGkrOG5xaXJDR3J6R0JWZjkzZlVHRUZB?=
 =?utf-8?B?UVVXTVhHRXN1WVE3cDRqbVI2OFFTLzZ1ZExNNTBMOWhyVWxNblhHYllMVGwv?=
 =?utf-8?B?WG0vQ05HVFRtNGhJeXU1M09mdUowUHhiK0xzOFJOTjV2cEM3OHJzaVQxaXhQ?=
 =?utf-8?B?TFpMMzRuZjJJS1QvVWhPUGVoR3R1RkFZSVBTWENoWTZ3SVVnd3o2S3d2dXVn?=
 =?utf-8?B?RmcxbGJzMGZaZFJDWDlqbWdGeFVXQ2IzSzloaXMwYzJvQzdxdDhYUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca53f4f7-9bf5-4635-794a-08de89b32e80
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:39:40.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALeKH30+v+P3us1Pj9GO9JSKrgUGiK13kF975ZbsL6h6uQ/XHZHV6OktpVb7cwFRyc+oHM9CjgDs6LOMV9XddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 14:39:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22553

On 24.03.26 09:40, Kamlesh Gurudasani wrote:
> Add missing license headers to configuration, template, script,
> and wic partition layout files to make licensing consistent
> across the repository.
> 
> Command Used:
> git ls-files | xargs grep -rL SPDX-License-Identifier
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
> Changes in v2:
> - added license to remaining files
> - Link to v1: https://lore.kernel.org/r/20260316-license-v1-1-5bb039f50c05@ti.com
> ---
>  conf/distro/debian-bullseye-backports.list                                       | 3 +++
>  conf/distro/debian-buster-backports.list                                         | 3 +++
>  conf/distro/preferences.ovmf-snakeoil.conf                                       | 3 +++
>  conf/distro/preferences.swupdate-bullseye-backports.conf                         | 3 +++
>  recipes-bsp/u-boot/files/ftpm-stmm.cfg                                           | 3 +++
>  recipes-bsp/u-boot/files/no-grub-workaround.cfg                                  | 3 +++
>  recipes-bsp/u-boot/files/qemu-extra.cfg                                          | 3 +++
>  recipes-bsp/u-boot/files/secure-boot.cfg                                         | 3 +++
>  recipes-bsp/u-boot/files/ti-extra.cfg                                            | 3 +++
>  recipes-core/customizations/files/99-silent-printk.conf                          | 3 +++
>  recipes-core/customizations/files/99-watchdog.conf                               | 3 +++
>  recipes-core/customizations/files/ssh-permit-root.conf                           | 3 +++
>  recipes-core/home-fs/files/home.mount                                            | 3 +++
>  recipes-core/home-fs/files/postinst                                              | 3 +++
>  recipes-core/immutable-rootfs/files/95-disable-package-updates.preset            | 3 +++
>  recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl               | 3 +++
>  recipes-core/immutable-rootfs/files/postinst                                     | 3 +++
>  recipes-core/journald-config/files/persistent-journal.conf                       | 3 +++
>  recipes-core/kernel-panic/files/sysrq-panic.service                              | 3 +++
>  recipes-core/ltp/files/debian/control.tmpl                                       | 3 +++
>  recipes-core/ltp/files/debian/rules                                              | 3 +++
>  recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl               | 3 +++
>  recipes-core/security-customizations/files/postinst                              | 2 ++
>  recipes-core/security-customizations/files/ssh-pam-remote.conf                   | 3 +++
>  recipes-core/security-customizations/files/ssh-remote-session-term.conf          | 3 +++
>  recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl                   | 3 +++
>  recipes-core/swupdate-config/files/hwrevision.tmpl                               | 3 +++
>  recipes-core/swupdate-config/files/swupdate.cfg                                  | 3 +++
>  recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini | 3 +++
>  recipes-core/tmp-fs/files/postinst                                               | 3 +++
>  recipes-devtools/swupdate-signer/files/sign-swu-cms                              | 3 +++
>  recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl          | 3 +++
>  recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf                      | 3 +++
>  recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl   | 2 ++
>  recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl              | 3 +++
>  recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl                 | 2 ++
>  recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script    | 2 ++
>  recipes-kernel/linux/files/no-module-signing.cfg                                 | 3 +++
>  recipes-kernel/linux/files/no-tpm-hwrng.cfg                                      | 3 +++
>  recipes-kernel/linux/files/preempt-rt.cfg                                        | 3 +++
>  recipes-security/fail2ban-config/files/systemd-defaults.conf                     | 3 +++
>  scripts/deploy-cip-core.sh                                                       | 3 +++
>  scripts/generate-sb-db-from-existing-certificate.sh                              | 3 +++
>  scripts/generate_secure_boot_keys.sh                                             | 3 +++
>  scripts/start-efishell.sh                                                        | 3 +++
>  scripts/submit_lava.sh                                                           | 3 +++
>  scripts/update-linux-cip.sh                                                      | 3 +++
>  scripts/update-ltp.sh                                                            | 3 +++
>  tests/templates/IEC_template.yml                                                 | 3 +++
>  tests/templates/secureboot_corrupt_rootfs_steps.yml                              | 3 +++
>  tests/templates/secureboot_negative_test.yml                                     | 3 +++
>  tests/templates/secureboot_template.yml                                          | 3 +++
>  tests/templates/secureboot_unsigned_bootloader_steps.yml                         | 3 +++
>  tests/templates/secureboot_unsigned_kernel_steps.yml                             | 3 +++
>  tests/templates/swupdate-test-action-M-COM.yml                                   | 3 +++
>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml                          | 3 +++
>  tests/templates/swupdate_corrupt_swu_steps.yml                                   | 3 +++
>  tests/templates/swupdate_negative_test.yml                                       | 3 +++
>  tests/templates/swupdate_reboot_without_confirm.yml                              | 3 +++
>  tests/templates/swupdate_same_uuid_steps.yml                                     | 3 +++
>  tests/templates/swupdate_template.yml                                            | 3 +++
>  wic/ebg-signed-sysparts.inc                                                      | 3 +++
>  wic/ebg-sysparts.inc                                                             | 3 +++
>  wic/hihope-rzg2m-efibootguard.wks.in                                             | 3 +++
>  wic/qemu-arm64-efibootguard-secureboot.wks.in                                    | 3 +++
>  wic/qemu-arm64-efibootguard.wks.in                                               | 3 +++
>  wic/qemu-riscv64-efibootguard.wks.in                                             | 3 +++
>  wic/x86-uefi-efibootguard-secureboot.wks.in                                      | 3 +++
>  wic/x86-uefi-efibootguard.wks.in                                                 | 3 +++
>  69 files changed, 203 insertions(+)
> 
> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
> index 1594907..6107928 100644
> --- a/conf/distro/debian-bullseye-backports.list
> +++ b/conf/distro/debian-bullseye-backports.list
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  deb http://archive.debian.org/debian bullseye-backports main contrib non-free
> diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
> index 7134a35..842019e 100644
> --- a/conf/distro/debian-buster-backports.list
> +++ b/conf/distro/debian-buster-backports.list
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  deb http://archive.debian.org/debian buster-backports main contrib non-free
> diff --git a/conf/distro/preferences.ovmf-snakeoil.conf b/conf/distro/preferences.ovmf-snakeoil.conf
> index b51d1d4..25b7da4 100644
> --- a/conf/distro/preferences.ovmf-snakeoil.conf
> +++ b/conf/distro/preferences.ovmf-snakeoil.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  Package: ovmf
>  Pin: release n=buster-backports
>  Pin-Priority: 801
> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
> index c5f6685..da307cd 100644
> --- a/conf/distro/preferences.swupdate-bullseye-backports.conf
> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  Package: dh-nodejs
>  Pin: release n=bullseye-backports
>  Pin-Priority: 801
> diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
> index af5da93..a6fe2a3 100644
> --- a/recipes-bsp/u-boot/files/ftpm-stmm.cfg
> +++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  ### Enable OPTEE, fTPM and StMM
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
> diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
> index dc09edd..8a01ff6 100644
> --- a/recipes-bsp/u-boot/files/no-grub-workaround.cfg
> +++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
> @@ -1,2 +1,5 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  ### Disable grub workaround
>  # CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
> index e643db7..5380ad8 100644
> --- a/recipes-bsp/u-boot/files/qemu-extra.cfg
> +++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  ### QEMU extra config
>  CONFIG_MMC=y
>  CONFIG_SUPPORT_EMMC_RPMB=y
> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
> index 694356f..7b09a53 100644
> --- a/recipes-bsp/u-boot/files/secure-boot.cfg
> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  ### Secure boot config
>  # CONFIG_BOOTSTD_DEFAULTS is not set
>  # CONFIG_BOOTMETH_CROS is not set
> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
> index c10d046..9500055 100644
> --- a/recipes-bsp/u-boot/files/ti-extra.cfg
> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  ### FTPM + RPMB + StandaloneMM setup
>  CONFIG_OPTEE_SERVICE_DISCOVERY=y
>  CONFIG_TPM=y
> diff --git a/recipes-core/customizations/files/99-silent-printk.conf b/recipes-core/customizations/files/99-silent-printk.conf
> index ad24d3a..c5b3799 100644
> --- a/recipes-core/customizations/files/99-silent-printk.conf
> +++ b/recipes-core/customizations/files/99-silent-printk.conf
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  kernel.printk = 3 4 1 3
> diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-core/customizations/files/99-watchdog.conf
> index c02756d..1f38c55 100644
> --- a/recipes-core/customizations/files/99-watchdog.conf
> +++ b/recipes-core/customizations/files/99-watchdog.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [Manager]
>  RuntimeWatchdogSec=60s
>  ShutdownWatchdogSec=60s
> diff --git a/recipes-core/customizations/files/ssh-permit-root.conf b/recipes-core/customizations/files/ssh-permit-root.conf
> index 1073982..ab26ab5 100644
> --- a/recipes-core/customizations/files/ssh-permit-root.conf
> +++ b/recipes-core/customizations/files/ssh-permit-root.conf
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  PermitRootLogin yes
> diff --git a/recipes-core/home-fs/files/home.mount b/recipes-core/home-fs/files/home.mount
> index 062517a..653495c 100644
> --- a/recipes-core/home-fs/files/home.mount
> +++ b/recipes-core/home-fs/files/home.mount
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [Unit]
>  Description=Mount /home partition
>  Before=local-fs.target
> diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
> index ab0db84..904aa73 100755
> --- a/recipes-core/home-fs/files/postinst
> +++ b/recipes-core/home-fs/files/postinst
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
> index 7e6e9ef..b3b52ce 100644
> --- a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
> +++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  disable apt-daily.timer
>  disable apt-daily-upgrade.timer
>  disable dpkg-db-backup.timer
> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> index e6d25d2..4cdfc6f 100644
> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
>  d /var/log/audit 0700 root adm -
>  d /var/lib/apt 0755 root root -
> diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
> index a6e1962..3b8071e 100644
> --- a/recipes-core/immutable-rootfs/files/postinst
> +++ b/recipes-core/immutable-rootfs/files/postinst
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
> index 21dfde0..3e3419f 100644
> --- a/recipes-core/journald-config/files/persistent-journal.conf
> +++ b/recipes-core/journald-config/files/persistent-journal.conf
> @@ -1,2 +1,5 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [Journal]
>  Storage=persistent
> diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
> index 4f199fe..e892165 100644
> --- a/recipes-core/kernel-panic/files/sysrq-panic.service
> +++ b/recipes-core/kernel-panic/files/sysrq-panic.service
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [Unit]
>  Description=sysrq panic
>  
> diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
> index 0bfc0c2..a7d0087 100644
> --- a/recipes-core/ltp/files/debian/control.tmpl
> +++ b/recipes-core/ltp/files/debian/control.tmpl
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  Source: ltp-full
>  Section: embedded
>  Priority: optional
> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
> index 4e1747c..32d3c29 100755
> --- a/recipes-core/ltp/files/debian/rules
> +++ b/recipes-core/ltp/files/debian/rules
> @@ -1,4 +1,7 @@
>  #!/usr/bin/make -f
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
>  export DEB_BUILD_MAINT_OPTIONS=hardening=-branch
>  
> diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
> index 92e4a30..1821f92 100644
> --- a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
> +++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
> @@ -1,2 +1,5 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  L /home - - - - /var/home
>  C /var/home - - - - ${IMMUTABLE_DATA_DIR}/home
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index f8ebf9e..788e225 100755
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -3,6 +3,8 @@
>  # CIP Security, generic profile
>  # Security Package configurations
>  #
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-core/security-customizations/files/ssh-pam-remote.conf
> index d460b0c..ea120b2 100644
> --- a/recipes-core/security-customizations/files/ssh-pam-remote.conf
> +++ b/recipes-core/security-customizations/files/ssh-pam-remote.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # Enable PAM configuration for Remote Session
>  ChallengeResponseAuthentication yes
>  KbdInteractiveAuthentication yes
> diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
> index d11b92e..171ea9b 100644
> --- a/recipes-core/security-customizations/files/ssh-remote-session-term.conf
> +++ b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # CR2.6: Remote session termination
>  # Terminate remote session after inactive time period
>  
> diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> index 744b426..f750f3d 100644
> --- a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
> index 1eb0996..b937200 100644
> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
> @@ -1 +1,4 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  cip-${MACHINE} ${MACHINE_HW_VERSION}
> diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
> index 3e2b45c..5c05fbe 100644
> --- a/recipes-core/swupdate-config/files/swupdate.cfg
> +++ b/recipes-core/swupdate-config/files/swupdate.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  globals :
>  {
>      bootloader = "ebg";
> diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
> index 58271da..8f93cc9 100644
> --- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
> +++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [image]
>  chainhandler=raw
>  
> diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
> index 39067f1..ae0f74a 100755
> --- a/recipes-core/tmp-fs/files/postinst
> +++ b/recipes-core/tmp-fs/files/postinst
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
> index cb0cd4a..bc1ec13 100644
> --- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
> +++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  in_file=$1
>  out_file=$2
>  inkey="/usr/share/swupdate-signing/swupdate-sign.key"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..452714d 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> index d4c8981..8e087f2 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # we don't have a dictionary in the initramfs
>  # this solves the error "Password generation failed - required entropy too low for settings"
>  dictcheck = 0
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index f0ad40c..94b5f8b 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -7,6 +7,8 @@
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
> +# SPDX-License-Identifier: MIT
> +#
>  . /usr/share/factory-reset/reset-env
>  
>  . /scripts/cip-initramfs-functions
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> index d3e18a2..07e2376 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> @@ -1,3 +1,6 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> index bce588c..8a697f8 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> @@ -7,6 +7,8 @@
>  #  Jan Kiszka <jan.kiszka@siemens.com>
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
> +# SPDX-License-Identifier: MIT
> +#
>  
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> index 0cd084b..11ca731 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> @@ -7,6 +7,8 @@
>  # Authors:
>  #  Clara Kowalsky <clara.kowalsky@siemens.com>
>  #
> +# SPDX-License-Identifier: MIT
> +#
>  
>  partition_fstype="$1"
>  ovl_partition_device="$2"
> diff --git a/recipes-kernel/linux/files/no-module-signing.cfg b/recipes-kernel/linux/files/no-module-signing.cfg
> index ab54f68..064ef9c 100644
> --- a/recipes-kernel/linux/files/no-module-signing.cfg
> +++ b/recipes-kernel/linux/files/no-module-signing.cfg
> @@ -1,2 +1,5 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # CONFIG_SECURITY_LOCKDOWN_LSM is not set
>  # CONFIG_MODULE_SIG is not set
> diff --git a/recipes-kernel/linux/files/no-tpm-hwrng.cfg b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
> index ab46cd8..08e98ff 100644
> --- a/recipes-kernel/linux/files/no-tpm-hwrng.cfg
> +++ b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
> @@ -1,2 +1,5 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # see https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/
>  # CONFIG_HW_RANDOM_TPM is not set
> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
> index afbf53d..f558365 100644
> --- a/recipes-kernel/linux/files/preempt-rt.cfg
> +++ b/recipes-kernel/linux/files/preempt-rt.cfg
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # >= 5.10
>  CONFIG_EXPERT=y
>  CONFIG_PREEMPT_RT=y
> diff --git a/recipes-security/fail2ban-config/files/systemd-defaults.conf b/recipes-security/fail2ban-config/files/systemd-defaults.conf
> index 16e0d5e..32a8e48 100644
> --- a/recipes-security/fail2ban-config/files/systemd-defaults.conf
> +++ b/recipes-security/fail2ban-config/files/systemd-defaults.conf
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  [DEFAULT]
>  
>  syslog_backend = systemd
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 623c216..1e08e47 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
> index dddd9b5..42d09dd 100755
> --- a/scripts/generate-sb-db-from-existing-certificate.sh
> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
> index 8be0569..28ae34c 100755
> --- a/scripts/generate_secure_boot_keys.sh
> +++ b/scripts/generate_secure_boot_keys.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
> index fff8a6a..86e2ddd 100755
> --- a/scripts/start-efishell.sh
> +++ b/scripts/start-efishell.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  set -e
>  
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index b3180a1..a4d20ec 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # Copyright (C) 2024, Renesas Electronics Europe GmbH
>  # Chris Paterson <chris.paterson2@renesas.com>
>  # Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
> index 5fbfa57..df306b2 100755
> --- a/scripts/update-linux-cip.sh
> +++ b/scripts/update-linux-cip.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  REPO_ROOT=$(git rev-parse --show-toplevel)
>  pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>  
> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
> index dc8b947..321cc3c 100755
> --- a/scripts/update-ltp.sh
> +++ b/scripts/update-ltp.sh
> @@ -1,4 +1,7 @@
>  #!/bin/bash
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  REPO_ROOT=$(git rev-parse --show-toplevel)
>  pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index f8558cd..148f07e 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# IEC layer testing
>  timeouts:
> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> index b6f6628..5c47b30 100644
> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install -y fdisk"
>            - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
> index 2fcdbfa..a8e4226 100644
> --- a/tests/templates/secureboot_negative_test.yml
> +++ b/tests/templates/secureboot_negative_test.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# secure boot testing
>  timeouts:
> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
> index e29b64a..0a075e2 100644
> --- a/tests/templates/secureboot_template.yml
> +++ b/tests/templates/secureboot_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# secure boot testing
>  timeouts:
> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
> index 8d64b05..f4f4043 100644
> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install --yes guestfish sbsigntool"
>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
> index f097ed6..6ab334a 100644
> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>            - "apt-get update"
>            - "apt install --yes guestfish sbsigntool"
>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
> index 56ff106..69c9cb7 100644
> --- a/tests/templates/swupdate-test-action-M-COM.yml
> +++ b/tests/templates/swupdate-test-action-M-COM.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # TEST BLOCK 1
>  # Fail the job if software update application failed
>  - test:
> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> index 2fad3fd..043867e 100644
> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
> diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
> index 74c9217..3cdb793 100644
> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
> index bb79b07..250eaa8 100644
> --- a/tests/templates/swupdate_negative_test.yml
> +++ b/tests/templates/swupdate_negative_test.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# software update testing
>  timeouts:
> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
> index bfad106..074eb1a 100644
> --- a/tests/templates/swupdate_reboot_without_confirm.yml
> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # qemu-swtpm.sock will be gone after soft reboot.
>  # So the swtpm socket need to be started again for proper reboot
>  # To start the swtpm daemon, first the existing one should be killed
> diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
> index 3ff2e02..8329055 100644
> --- a/tests/templates/swupdate_same_uuid_steps.yml
> +++ b/tests/templates/swupdate_same_uuid_steps.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>              - mkdir -p swu
>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
> index e1f71a9..9a3366b 100644
> --- a/tests/templates/swupdate_template.yml
> +++ b/tests/templates/swupdate_template.yml
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  device_type: qemu
>  job_name: #architecture# software update testing
>  timeouts:
> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
> index c35878f..8210598 100644
> --- a/wic/ebg-signed-sysparts.inc
> +++ b/wic/ebg-signed-sysparts.inc
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # default partition layout EFI Boot Guard usage, signed version
>  
>  # EFI partition containing efibootguard bootloader binary
> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
> index 0290024..b7f1afa 100644
> --- a/wic/ebg-sysparts.inc
> +++ b/wic/ebg-sysparts.inc
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # default partition layout EFI Boot Guard usage
>  
>  # EFI partition containing efibootguard bootloader binary
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index fdbad14..99c8d10 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
>  # long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
>  
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 941a552..88eb91c 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  include ebg-signed-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 21c0b24..117c47c 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # short-description: arm64 with EFI Boot Guard and SWUpdate
>  # long-description: Disk image for arm64 machines with EFI Boot Guard and SWUpdate
>  
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 948c67d..a5dd09b 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # short-description: riscv64 with EFI Boot Guard and SWUpdate
>  # long-description: Disk image for riscv64 machines with EFI Boot Guard and SWUpdate
>  
> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
> index 2af3e58..f15f9e0 100644
> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  include ebg-signed-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
> index 3640ecf..982a87a 100644
> --- a/wic/x86-uefi-efibootguard.wks.in
> +++ b/wic/x86-uefi-efibootguard.wks.in
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  # short-description: x86 with EFI Boot Guard and SWUpdate
>  # long-description: Disk image for x86 machines with EFI Boot Guard and SWUpdate
>  
> 
> ---
> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
> change-id: 20260316-license-c5fcde3618d2
> 
> Best regards,

Thanks, applied. Will follow up with fixing two more spots so that we
are only left with files that cannot receive headers.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

