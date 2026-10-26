Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35336.1792986271389816778
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 20:44:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bCGpJY8Y;
 spf=pass (domain: siemens.com, ip: 52.101.66.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulm+CbSW+gzAPTs/Fcc708j+IG2e23YGUFMoPgKlGRBcRNG06UB8isTvDTAFZKUD8OI1CUgry72zjvVsjHwhxcxHbN5hVztdMrRmouOBXkLoBtQcFKZF0cXd4zm3ur/JhlUIhi/r5hzaXTTUEq3dFsiCD1nlGeYrfTY+NRclUGpvcaAsj8+I2VoYs0RSPsucKgB3h+x5wfyB2dfeV8yqzoPoGC534rEtxAqi+Tfj3fB1nJd/coQ5v8KHNhcOKita/VL4ssqkQtgALmNtxSw7uz5yvDLXLNTIimL+mzNJ8/y9KdO2YbMopYQoLE8KNSGsxPGwc/Qb6zNVeVl8HA07Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CdCDE+APv36iN87tvLIUA+oxT4uR+KRyzFw9ATG5WM=;
 b=r7+Mtyg+yTblWAOPvhi7a8ZrAFnCaHIrDh5vaMdBAgPnrskq0eUaza9CZQaEwjigPPZlyYtatD1THCHd36whb8gvSlTeU81xDBh2X9/WmDEvL2E6nB9T5y8+6ZLErLzCsOUUqLwAGws7Q4ja6LEIUmSYy7uAkbYns1n8/ZoPXkjdO6HnpGyfadPDWuzvRI+9f2fxDyj/yjz3m9h6kesRRu55+2LcrkdT8mtEzJcKXYa7keqLll0A0gZXSl86FyTzejcSJnFBakbI93aKY4IY7whymKglFPjqvjAhvVxfcMNQTVMkrMrOjwKlUMpByEQSDqZ26mjbzyUT+aTLLj5tTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CdCDE+APv36iN87tvLIUA+oxT4uR+KRyzFw9ATG5WM=;
 b=bCGpJY8YJRMKhthIaFOtHLYgw5kKWFhfji9W6uRl/0Ah1qBBpiwTBHk0GiU/oF/IxIF26/ZstpdTZkoGh91oXvDJlaAAuedr+mS7bT2EOAVw/jeuE5mCaP4Xr0klCkJrOlG2xz6kxzpvZ7K7vHl04W5//KAqtTz0f9Ao3FL+k2Z0JhEzU7qjHTOcZ4cMBXi0X8Hjm/XKR+jFHyyDB+Q83iVELr4F4s5O/0GsTYjy0wtSmYFE5BPWSIXsn4OEMKz/Vdh6uMWDoZ9D4/PDvUqkjrM1SWeUGnn6xleF54+An2/SdNYj7XbdAk0otXujG0dglJCswtOWFfIN5IZ/eGSKzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB3198.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:132::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 03:44:27 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Mon, 26 Oct 2026
 03:44:26 +0000
Message-ID: <fe61c8e5-4c73-476a-9c03-1b1aef2e17a1@siemens.com>
Date: Mon, 26 Oct 2026 11:44:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 00/12] Add darcut initramfs for
 CIP Core
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB3198:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c4c978-ef26-4ec8-dda9-08df33136e55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|261009223027099003|261009221227099003|261022105027099003|261022075727099003|261022115727099003|261021135927099003|261021121427099003|261021123027099003|10067099003|56012099006|6133799003|18002099003|22082099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info: x6r5Y11yM2vh6R+Qm54AVWUCvbLm8D+lwoUl2NRbkr1TsvR9nygaJv6SO3PivM3NxXi0DICOmtcP6Y8CeuyYyq7nYDdYdOiQDr5MaMyO3Y4y4hh7n7jCkTSqM3Mqc6k7c8dKPpk9up9Un6oKCHEn6Jw34Ka2/USPTsgDrmgwNoHLjJT+d5og6vb2TP6L5aRHizqzdSLuBgcL4XdhQCxSQp5IStAb0Wr1JzVJtAyju5WaA/H5IXjvj2qCJ/u4uOeCijA1CbwMP6ZVf/f4k8l9e1V6Jncm6C8kzWqrlWmghwfxq1Xe1WJzwI9oXmpMqM+0k/6zprDH6mGX4kqq7loMs747Ubx8MUQpRNP8rJSz/CU264uY5sxJB7wB36Wy77QzcLDa0zzePp0BACcqPGbuMpFUfwRQDfBxOkmE+tZK0pMBvaYHFSLQBP7+OU0k+K700NHmV4ZcAE2m+I7mXHSlT9n+RNjT1D5UpTBdHHwLIlof9jym+QICCsV+B6Rx9iQvkeZLrcWZCZbyAPbTYiOL/QSAyNk5OEc1COq5aq29gcKC8j31FzTC9yhmuJfr5hFtMOTLPHl6VBbE1Y7ZGWi3PozHf6ceR0QfFzS70igDFldVA7NiHEyEfKAiHaZIKXdJ4uCL8DUCRaZq0HSB5bdco/SWvMMgEmAJ6u5ZrNVbLJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261009223027099003)(261009221227099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVnQzhFTjdmYWNTbmJqZE9kOWVQN3hNM3llTnRJeTlPL1F0WGRZbHlVRTh0?=
 =?utf-8?B?RG9Jb3VocEZVR0FiRG9jY3JTZTRFdW1DZmhGZWcvRytycHlKUnNDaEtrSVUw?=
 =?utf-8?B?NWdVVDc2SzJ3Q3gzc1VnK3JwVmF0SU9tOGtXYXNYcjJCdUZQeUphYzZvb1RL?=
 =?utf-8?B?Y2VpSkxIdzRXQVN0S0VCRFZrZ3FJMVhibG9odE5hSnZWekVwK0FpYnE1NGx2?=
 =?utf-8?B?TmpUT0NoQllmVXR3UGlXc3BmTStnc2tONFRUVEs3QUlQV0UzdTFCcVlocTE5?=
 =?utf-8?B?emsvUXFPNEpncm5CRHBuaTFqU2lUa0t2WHZVRVMwbXFLQ25OMkxrdnQvTHZ5?=
 =?utf-8?B?bWhDTjgyVlhsQ0s2c1dBYmVrc1ptcnFPVTgzVWF1bnJmRnQ2Y2ZvbzlrcDVC?=
 =?utf-8?B?M2RlK05iam9XT0RQdkExUWZyYURySkRrVjMzYUt5MWUrSGQ1RGJUVm0vbGF6?=
 =?utf-8?B?UUZRMk1MeXF6M05qZWYwVXpDTDlZMmxud1Zmak9QODZYb2ZZL000WHcrSE9w?=
 =?utf-8?B?S1dyWUlaeWw5Y2pkTmFnTktXVFAxSWwwSEJZUW83eWFxM0FnQlpBV3ROWXFR?=
 =?utf-8?B?RnJuSjNaUDM1OGdiZC90MDFQSnZYZkpxNE14RncybjRvVnZPWVhCWG9ONzJm?=
 =?utf-8?B?akFUamNscjEwVnRhVmRkYnlUZ3VVR3A3VlpTUUIwcGJsYzRDbm1HNzlRQ3BK?=
 =?utf-8?B?S1htblozejFMeXVSRjJiNGxCNU45U2ZVVmUwbXkyUnczYml2RDRqNGVrMEpN?=
 =?utf-8?B?YzhlR3lMTHJydzV3alluMS9UZEZSblM5OC9mdXlsZTFkc0N4RFgrcUFSdEFE?=
 =?utf-8?B?SE9sZENrL1ZocUM2QTdPOWV6U1p6T1VsTklscnJSZ3NLNFpWeXVIUEg5REFV?=
 =?utf-8?B?TW4rdVZlTFFiRDV5MHZ1WEovb2U1c093QmxQd1h1b2FhN1JVUGFWLytTMS9J?=
 =?utf-8?B?MjdERDZFSDdnc3lJbkRSRHU4dVdHNWR2VEpJenVja0VVTGFYaXp0dVB0RGdE?=
 =?utf-8?B?dWpCcGNrYzVyNWFIZXB0OTdZcTk5MzUrZmtVL21YL0t0dnFrSXQ2YXJpdWRG?=
 =?utf-8?B?Wkx2cEhUNjc3VEFLby8rSkxFY0FWL0szNHpwcTZsZzJQYUVKeTY1MVV1U0Fv?=
 =?utf-8?B?N2doWWhKalViODBhRFZCZ1RoeFBvNDUrSUdVQldJQ2tRRWNSMDFNeEU2YVNP?=
 =?utf-8?B?dHBuT2lqL1Rma3hKTG9sMUNlTExMQjFwVkhHZXQxaE5tMTRjS09HL2YrbzV6?=
 =?utf-8?B?cExBYTdsbExpQVl2VDF4UkVtb20wYk9rTytBY0VObU1aOTNmcnQ1cEdveEJR?=
 =?utf-8?B?S0hodjlRZEpUNDIyVythNTZKYThIdW42ckZCWmNtMlR6VGlKeTJYMHVzN0du?=
 =?utf-8?B?ZjM0ak5kQTdta3FZOUkvMk1LUHRlMGw2RzhwREV4NjFBc0VZL3VnUmlQck5P?=
 =?utf-8?B?N0UwcTdQZ3g4ZHA4ekc1ZFB1NFBXTEJjM2Fyb0E3TGoxWEdhenVoZVh4SFpx?=
 =?utf-8?B?M0lMbXZzRkJoN0VEaU1Ob3ZDWEVFMHVBTnk5Q0JGTUo3ZmNvN2tJWVY5ZGhR?=
 =?utf-8?B?V2NoOXgwbm11NitoZVZqd1REaHVPK2NJTDdqdEU2b2lURStiL3BYYklleEVj?=
 =?utf-8?B?M3E5WVFHd3I3Wkt2ZUYvQ0FMQjRxdjhOdDI0dVRxV2JaMnFFUzdqTVJoWjhx?=
 =?utf-8?B?WTBhT255TXg2cjYzVzB6QlRIZ1dXeTNUWFlacGlQWWROYlQrYU5YSUFibVli?=
 =?utf-8?B?THNYR1ZEclk5NGx3cnJTUW12aloyZUxzcVc5RU5yUnJlTGZuVXhRRFdDWWtw?=
 =?utf-8?B?VDMrS0VNeVkvalQ3UlNRM29MUXlpeFdSbVFjZ2NVY3JWUVloSGhUMnRmdVU3?=
 =?utf-8?B?Y0gwN0xDN2JXTFQxQ24wV1NrOVhlQXVFWVFEOXI0bXNkblg5RWF4eW5ZbUxy?=
 =?utf-8?B?NnI3aUdIcTRFRXRrRk5FcG5TZllEZjBQaHkybmdmRU9kUmF1V3EzWXd6WW9I?=
 =?utf-8?B?T1BkaDZZUVppVHY2SUlDVDQ5QzE1TVdNN0dDa3ZsejZkTndMbGo2UWxLR0Np?=
 =?utf-8?B?eXlXbHJBMXNjZzZWd0k1N1BBNU5nalBpY0dON1F0dktnY2tJcWwzdFBPVllO?=
 =?utf-8?B?SmlFUG1WSjNXdE1hSTMzSkRoUjUybkk3bnFEWmRKMUtaU0Nxb1V5TTJ6aVRK?=
 =?utf-8?B?RGFyUTB5ZVJjWGVvSmpTYnpEb3RqOW84K0sraEV2RVl2Kys0MEovN2Q2dHNm?=
 =?utf-8?B?cFdpdURMQTJ2UnVUYndHc3ZjSjhkY3d6N1JIaStIcEx6TEdEbk93TWpLVWVH?=
 =?utf-8?B?dlBPNHRIRDFORVFHazRZME9iSG96b3RDZDlkZkJyOVhyb2wrUXJDdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c4c978-ef26-4ec8-dda9-08df33136e55
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:44:25.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GD1Nrzm8Zs6GV8nYNJQGGKOiMor/cMLHcBI8VKCccSYGGbOAw0P3p4nkDmHUal2T65LPlgKge6g1gpMgqIJHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:44:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24537

On 19.10.26 18:25, Quirin Gylstorff wrote:
> This series adds the necessary recipes and configuration to build a
> dracut initramfs for CIP Core. The initramfs is used to boot the system
> with a read-only root filesystem, and provides support for features
> such as dm-verity, factory reset, and watchdog.
> 
> The code for these dracut modules will be stored in a a separate
> repository the make the maintenance easier. The repository is located
> for the RFC at
> https://gitlab.com/cip-playground/embedded-dracut-modules.
> 
> I will use force push on this repository until the development is
> settled.
> 
> It only supports Debian trixie and later, as it uses systemd for the initramfs.
> 
> I tested it only with the isar-cip-core build it should also work with
> downsteam layers. Please test it and report any issues.
> 
> Changes since RFC:
> - Added a patch to load the watchdog drivers early in the initramfs
>   this is needed to load the iTCO_wdt driver for kernels if the watchdog driver
>   is not built in.
> - Allow verity based rootfs with secure boot disabled. This allows to drop abrootfs
>   for systems with dracut based initramfs. Also in case abortfs_root=y
>   is set together with dracut the wic plugin will automatically generate the verity
>   based kernel commandline.
> - wic drop adding panic=5 to cmdline if dracut is used.
> 
> 
> Quirin Gylstorff (12):
>   swupdate: add RO_ROOTFS_VERITY to select a dm-verity rootfs
>   efibootguard-boot: emit systemd verity cmdline for dracut
>   wic: select the A/B rootfs image via WIC_ROOTFS_IMAGE_TYPE
>   embedded-dracut-modules: add recipe
>   dracut-config-cip-*: add build configuration packages
>   factory-reset-helper-efi: use systemd FactoryReset variable with
>     dracut
>   cip-core-initramfs-dracut: add dracut initramfs
>   watchdog: use the rootfs systemd watchdog timeout in the dracut initrd
>   Kconfig: add option to generate initramfs with dracut
>   read-only-rootfs: check dracut verity and secure boot settings
>   doc: document dracut initramfs
>   cip-core-initramfs-dracut: load watchdog drivers early via force
>     drivers
> 
>  Kconfig                                       |  15 +++
>  classes-recipe/dracut-cip-config.bbclass      |  54 +++++++++
>  classes-recipe/read-only-rootfs.bbclass       |  25 +++-
>  classes-recipe/swupdate.bbclass               |   3 +-
>  conf/distro/cip-core-common.inc               |   8 ++
>  conf/machine/qemu-amd64.conf                  |   3 +
>  doc/README.dracut.md                          | 111 ++++++++++++++++++
>  doc/README.factory-reset.md                   |  46 ++++++++
>  doc/README.secureboot.md                      |  10 +-
>  ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 +++++++++++++++++
>  kas-cip.yml                                   |   4 +
>  kas/opt/dracut.yml                            |  17 +++
>  kas/opt/ebg-secure-boot-snakeoil.yml          |   3 +-
>  recipes-core/customizations/common.inc        |   7 +-
>  .../customizations/files/99-watchdog.conf     |   6 -
>  .../files/99-watchdog.conf.tmpl               |   6 +
>  recipes-core/images/swupdate.inc              |   1 +
>  .../cip-core-initramfs-dracut.bb              |  46 ++++++++
>  .../cip-core-initramfs/cip-core-initramfs.bb  |   4 +-
>  .../dracut-cip-force-drivers_0.1.bb           |  17 +++
>  .../dracut-config-cip-crypt_0.1.bb            |  86 ++++++++++++++
>  .../dracut-config-cip-crypt/files/postinst    |  10 ++
>  .../dracut-config-cip-factory-reset_0.1.bb    |  49 ++++++++
>  .../dracut-config-cip-overlay_0.1.bb          |  44 +++++++
>  .../dracut-config-cip-verity_0.1.bb           |  23 ++++
>  .../dracut-config-cip-watchdog_0.1.bb         |  30 +++++
>  .../embedded-dracut-modules_0.1.bb            |  21 ++++
>  .../factory-reset-helper-efi_0.1.bb           |   5 +-
>  .../wic/plugins/source/efibootguard-boot.py   |  67 ++++++++++-
>  wic/bbb-efibootguard.wks.in                   |   2 +-
>  wic/beaglev-fire-efibootguard.wks.in          |   2 +-
>  wic/de0-nano-soc-efibootguard.wks.in          |   2 +-
>  wic/hihope-rzg2m-efibootguard.wks.in          |   2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
>  wic/qemu-arm64-efibootguard.wks.in            |   2 +-
>  wic/qemu-riscv64-efibootguard.wks.in          |   2 +-
>  wic/rzt2h-evk-efibootguard.wks.in             |   2 +-
>  ...i-am62px-sk-efibootguard-secureboot.wks.in |   2 +-
>  wic/ti-am62px-sk-efibootguard.wks.in          |   2 +-
>  wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
>  wic/x86-uefi-efibootguard.wks.in              |   2 +-
>  41 files changed, 811 insertions(+), 41 deletions(-)
>  create mode 100644 classes-recipe/dracut-cip-config.bbclass
>  create mode 100644 doc/README.dracut.md
>  create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>  create mode 100644 kas/opt/dracut.yml
>  delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
>  create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl
>  create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
>  create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postinst
>  create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-factory-reset_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0.1.bb
>  create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchdog_0.1.bb
>  create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1.bb
> 

Should I wait for v3 to review, or are you waiting for me to review
before creating a v3? :)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
