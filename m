Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38434.1793004548300128869
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 01:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bbD9yz03;
 spf=pass (domain: siemens.com, ip: 52.101.65.40, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIRXFgDac2Qj4dOMHpeuJRF2SXMocRJ6BfFbGOwnOl8K7nrxqhjeOX/i/F3rqAbXGullu2CgLqEnHov0irJkrZyES7E/kOo8ZlxukCJFefPJc2xdXM7CwBbY0sgstcy6Beb5o666Tw2NLkqrdAotTByt/hUN2HHFCgzo71OOzkHu2elSlDkoTZ9z6YwvyUYBcytOMWf+LPAZVcSTa41jqnboF2SWOfVM1OQeu9RIBJ+pCVs6jIH2B2S1I66sf79B4s8EaeMFxgEcjgyyRuYSUhluYUJ1X1DLETowmtoYPcctsZiyQ70Ky8aILMVR0gwXTCUq8VZosCKm5e3YnphcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZmakpdS5BOcgtlrvkNT9z3jGyOsWo6w2yrsvc8NpUs=;
 b=uD4DZLmWwtA4ScM5XYdpwlWDRslmY7NJD5hOAfq8G6CCVWA6jhNlf0E0SHvhjx5cD/W1yNbBGMJVBJGEwn0HC7wT4xv4/YC/lmCME25cAvpfgN4zcaP7/n20rBbxKbSf+UCCdPaqBXg9ELa40cKowrqgUaw51RmaCQw/oUHemkJP0OkEurNxZhQi6mhughqKtBKX1H3WmYbaqle+yGeczWA603VMvGdxbKEO/5LPHhWAZjTp/L3OCsMYY9TxebTuXAhnAhlXScsNpya4aUxI4Gvpnw0q4IlFmrcReTnsBDNTHGCIfjaya7lrdeDAffJnlNLe4e/plM4jmrNJPh0y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZmakpdS5BOcgtlrvkNT9z3jGyOsWo6w2yrsvc8NpUs=;
 b=bbD9yz03EQCxq6YwQLM/O5qL4rsBdzh1bdNy2F6gKcR2n49w267NkS4/YteHpi2XcfsW1psgfi8bB3mEEQfctYvbcYtoLnpBxhy0rkQHMub0yZSVOu4RDdjhQ64P+tP84BHbfkS2EWCaLh51YPyoVJeq2L/6zSrs3JL+O6JSfLFmrX1lmJ4A56e7A0jeUqsbRJqa4kwaL+3GXkloBTiKFiTvlNfe74uNI5H1HsDiaMpbJEvdm/mTxithT7QNKazJal/ZEkD6/3r67Ri/+hOymzFQOjbIv6VDyRfeXHJKSqsJ6CSy0MfsKFU/qeNz92HfqABgDt0ndsOJvkS4ZH8HQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 08:49:04 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.005; Mon, 26 Oct 2026
 08:49:04 +0000
Message-ID: <b3b9cd74-daef-48bb-b76d-3a4e842fb11e@siemens.com>
Date: Mon, 26 Oct 2026 09:49:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 00/12] Add darcut initramfs for
 CIP Core
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <fe61c8e5-4c73-476a-9c03-1b1aef2e17a1@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <fe61c8e5-4c73-476a-9c03-1b1aef2e17a1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc9df37-820a-4fa6-c5d4-08df333dfccc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|55112099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|10067099003|261009221227099003|261009223027099003|261021135927099003|261022115727099003|261021121427099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: nSrbbiYq+619zNDaAnwMTJH5R39rc2zgFCSw8nM6bljdThTqptr3gXZnQrwZVipdU718nOMKBm/T40YXXq8TiXr36KlylstHoa0b8pmQnQYgY0P/fk9B4oKXlVHPenZDDV89rVkQrowDytC+bh0qCze7Db59yHPzY/A3ngv2NOFH0I3L7vReXtWFM3k3BBjdDolL7chozhx7XEGWyMcQM071ATYZDPLYiTQtU4dD4/x2TlMS/EFARjtoMSw1ubzKSMtonBEmSRjJKueKuR5qEvxXl1AacesPWv67eYVG/kThpYYAamu+GTyc4wYoAu1E+OtXiFY7HDpOUnVEGunx4q/Ke+atUpI6IELacrCjqDbp2Cu95klRE9MGmdqPtrS1prjYosE2zkKAHoZmbAEjoWUw4I+NOCypQL99b8psjbzF3TpmRsrvNkibggcSP1j0VKr66ScPfzN2sYzRot5l1GHjWgMdFqyKqr1zF/BfCaYBFrCFPd7e5PN0yHRwxlybiKbInxeq0k+ffPLqYrY9eVYrgjPrvbdUReEarWo6Ib/i1Rk3SgHMBiSMNeYQOZRnAMp51F1BJCOeLa7UjOfZaV9sTeshtJJGNRguDepLvVOagq7Vjbil/0k5Jb/0a/iaQc+e8JgM5MWE9nxZ+gNbM2vXHXX/GeXmQIe0LxIgu2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(10067099003)(261009221227099003)(261009223027099003)(261021135927099003)(261022115727099003)(261021121427099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3YxTXc4Z2VKTkd6M1REdFBrR1hFUi95WWNuU05lV1dUTFFjOGs3Nys4cU9p?=
 =?utf-8?B?UWwzYWJqNmxOYUIrYWdaNkVIaDRKeU8vZUUzc3JhSzUxL1Nxb2lPR1ZHNlpw?=
 =?utf-8?B?NFVNblV2bVc5RmlzTlhmWnN2T2wrRWNyMXN0ekMvL3hFNEJNdXAzeHNsK0Q1?=
 =?utf-8?B?TEpJZUFZQnFyT21Kd1ZXQzFOWk5ickJOb25zanRCKzRFcGFzVTF5aEFRbDY1?=
 =?utf-8?B?cGFCZjJuSzVCSE9RRGJaSlVOaFl5V1RBU3hOQnlMbU5nUis2QmorMStpL0My?=
 =?utf-8?B?M0pjWHJCYkg2UDN5YmI2ZERrcU9Ob29wQ3dQOTRhanovcW5Qby9GK0p1cWhx?=
 =?utf-8?B?SVpYQWp3QnNaRGlsc2lzYy9zVG9MYU9mNGNhOWUxbFRjZkExWGZLUW9leThH?=
 =?utf-8?B?MHBYV29UaG9oTHAvTDlEV2RhbTlsNXNFL3BsaHI2ZnVFZ3NGMVZPcTU2VGQw?=
 =?utf-8?B?SGQwMk04aWF4ZmpUdlE1Y0JMeWZRWHoreEU4bDdkZG04VXRZYlY4TG1scVh3?=
 =?utf-8?B?TFN5WlNMOTFwTmtRTzM3ZWFQa3lBVjRLVkRsWVpVOTZPK3BhbzY2QUlKbnpa?=
 =?utf-8?B?QXorS3VWbmFoYTJXUTM2bTYyRUhxR3N2T0M5UUxvL2gyODlhMldoZ1VzRE9E?=
 =?utf-8?B?S0FMaCtndkZISzcrc0JnUUJza3A1UW9UdnczMjlvWjk5WlBPY1l2ZTdhbWh4?=
 =?utf-8?B?d2xiV01qcGhySG1rMzNKaFJlaEpNMEhkWmp4NkExUWpUK1E1eGVCelcvTFly?=
 =?utf-8?B?enp4KzI1bThVMTY2RUN5S1JkNVV3ZWF3K0xNVTRDeCtzNE5WaEs4U0dVQWsy?=
 =?utf-8?B?bGtxZ2FsQlNIY2J0T1lHcUc5OFlDVFJ4d1BtR0JLNmV3MmZ2N3NOWFNLcTgx?=
 =?utf-8?B?YVg4SGl4RWJXeXBqd3B6dTlwNFlKVzFyYlNGdW44WVFOOExrZnBGaEZrbTVv?=
 =?utf-8?B?QmJKdWg3d0NtVTZCSW1oOHNaeXloN3hvMFVWcXU1R3FVdlBKSVMzYk9HU1lI?=
 =?utf-8?B?Zzhjb0lpN3JMZ215YlArTFNYZlJyS3Y4aGlmaThHSkRWS1N2STY5bGRDdThL?=
 =?utf-8?B?amcycGpRRmtJQkxKVFdsNEszMlVIb3V0aU1QVTEycUF3WndLc3ZmUy9SdjJB?=
 =?utf-8?B?Kzd1QWxVZlE5V2lkTWFLNHFLZmpWUHoyRit3VExDWXI3bDBoTVAxK2JvYXMw?=
 =?utf-8?B?TGlFNHFsbHdHOUVlRzgva0Q2L1dCUG9uZWk5YmNaQ0VEQ2Y1WXdKTjNITjAx?=
 =?utf-8?B?ZGhpUHI0YXJ2eDlLZlg5ZDJoa2pWdHZvazYzVlNLUTQrTFBMc29hUEZBa3V2?=
 =?utf-8?B?MUFPRVVYMWNEVVM5WnhPTFhLQmFDWFBieGJSa2pzZVpKdzdqZkYyNTNGYkNj?=
 =?utf-8?B?eUhyNjZGZGE3cFVBd1I5YW45ZitHckJTODB3ZTdJVjJNMzNDRG8yamc5eEhz?=
 =?utf-8?B?NStJVTBlbHoveGV1TmZzb3RIV1JST0x2TFVNQ1hpUFdrRk5rVEt3bEpTRVBt?=
 =?utf-8?B?cHRrOWtsZG51YWZiUGxib0FDSDM4MDUzWWRkaURySDlUM1dHdU0zdk9waW1H?=
 =?utf-8?B?RkQzdHgvK0g4UWR6K29tM2RBSmRrb0taeEZjNXM5YTd5U0plVkZUMGJ1d3RX?=
 =?utf-8?B?QkF6YUF3emJuTTIzQ0dieHVhWW90UldlN2tnY2wvTmdFQW5ub1JUVG52VEpj?=
 =?utf-8?B?Rk4yZU5Yb2wxbGJJOGFVbCtWcjIwZ1FpS0NYang5ZDhWdjJyN0ZvSGtxcjRI?=
 =?utf-8?B?Q1U2ZzZEUmNyYzgxczRjdStjSkRaZDhWL1B6VGozcGZkZHphMWRUTzVkMDZk?=
 =?utf-8?B?cDZqbHd4RDZ3Tld0aExWS1pTc2lFVmJySk9uM0dNOGxYSXJGb1QwWjFTMDV1?=
 =?utf-8?B?MVQxVCt0UUVyWW5KQS8zVDEyYVliUTBEQmc0d0VmdkxaTkJSQmpheFNFeGl6?=
 =?utf-8?B?aFh5ZytvOFpDcEFmaURTZlFiS3FScHp1M1loL3Q2TlhGQ2s2aGptRVY3UXRJ?=
 =?utf-8?B?Rm1Lek1ROW9IeWIvbVpoUzRmckdWTUxJbVovcUJ3VTd5SWxWeTlBUVJkYm12?=
 =?utf-8?B?d056eTYwUG9SaTV3Y0pxUVZrQ3RobWQ3cW10Um1EMFVRcTMrazQvTS8rQVVy?=
 =?utf-8?B?Vm10ZkJUQnUvNk9aTWFXWGVpcXQyQUZNd0lDaFFJN1BsU3JkRy9xaGM0dUZm?=
 =?utf-8?B?a1JROExnQmUrT0dtaTNBcE0xNlR2UDhOZkRwa0NMUGcyT3FKK0ttUGxwcDNs?=
 =?utf-8?B?WWxtLzlkSVpKQ2J1TWc0TFlYNEtsQ0FjSFJ5TjZnYVZkVG4rdXFkT3BTajJN?=
 =?utf-8?B?eXNaVGwwWnUrcWhPSU1iS3grS3l0TUo3QmRmZ1dhS3FnNTNFcDNQNG13VUxp?=
 =?utf-8?Q?aozp5I2tjH1i0wSo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc9df37-820a-4fa6-c5d4-08df333dfccc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:49:04.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1FsjD1k6pkUEbFWKASYv67dnYM6er9ea8wqRIVs34XeMJQhb1BW9c3LR68qWcBG3mH3GRf4fkkJ9Y7lqSzmevdSso0lNz9/Mns0nsMZuk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 08:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24538



On 10/26/26 4:44 AM, Jan Kiszka wrote:
> On 19.10.26 18:25, Quirin Gylstorff wrote:
>> This series adds the necessary recipes and configuration to build a
>> dracut initramfs for CIP Core. The initramfs is used to boot the system
>> with a read-only root filesystem, and provides support for features
>> such as dm-verity, factory reset, and watchdog.
>>
>> The code for these dracut modules will be stored in a a separate
>> repository the make the maintenance easier. The repository is located
>> for the RFC at
>> https://gitlab.com/cip-playground/embedded-dracut-modules.
>>
>> I will use force push on this repository until the development is
>> settled.
>>
>> It only supports Debian trixie and later, as it uses systemd for the initramfs.
>>
>> I tested it only with the isar-cip-core build it should also work with
>> downsteam layers. Please test it and report any issues.
>>
>> Changes since RFC:
>> - Added a patch to load the watchdog drivers early in the initramfs
>>    this is needed to load the iTCO_wdt driver for kernels if the watchdog driver
>>    is not built in.
>> - Allow verity based rootfs with secure boot disabled. This allows to drop abrootfs
>>    for systems with dracut based initramfs. Also in case abortfs_root=y
>>    is set together with dracut the wic plugin will automatically generate the verity
>>    based kernel commandline.
>> - wic drop adding panic=5 to cmdline if dracut is used.
>>
>>
>> Quirin Gylstorff (12):
>>    swupdate: add RO_ROOTFS_VERITY to select a dm-verity rootfs
>>    efibootguard-boot: emit systemd verity cmdline for dracut
>>    wic: select the A/B rootfs image via WIC_ROOTFS_IMAGE_TYPE
>>    embedded-dracut-modules: add recipe
>>    dracut-config-cip-*: add build configuration packages
>>    factory-reset-helper-efi: use systemd FactoryReset variable with
>>      dracut
>>    cip-core-initramfs-dracut: add dracut initramfs
>>    watchdog: use the rootfs systemd watchdog timeout in the dracut initrd
>>    Kconfig: add option to generate initramfs with dracut
>>    read-only-rootfs: check dracut verity and secure boot settings
>>    doc: document dracut initramfs
>>    cip-core-initramfs-dracut: load watchdog drivers early via force
>>      drivers
>>
>>   Kconfig                                       |  15 +++
>>   classes-recipe/dracut-cip-config.bbclass      |  54 +++++++++
>>   classes-recipe/read-only-rootfs.bbclass       |  25 +++-
>>   classes-recipe/swupdate.bbclass               |   3 +-
>>   conf/distro/cip-core-common.inc               |   8 ++
>>   conf/machine/qemu-amd64.conf                  |   3 +
>>   doc/README.dracut.md                          | 111 ++++++++++++++++++
>>   doc/README.factory-reset.md                   |  46 ++++++++
>>   doc/README.secureboot.md                      |  10 +-
>>   ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 +++++++++++++++++
>>   kas-cip.yml                                   |   4 +
>>   kas/opt/dracut.yml                            |  17 +++
>>   kas/opt/ebg-secure-boot-snakeoil.yml          |   3 +-
>>   recipes-core/customizations/common.inc        |   7 +-
>>   .../customizations/files/99-watchdog.conf     |   6 -
>>   .../files/99-watchdog.conf.tmpl               |   6 +
>>   recipes-core/images/swupdate.inc              |   1 +
>>   .../cip-core-initramfs-dracut.bb              |  46 ++++++++
>>   .../cip-core-initramfs/cip-core-initramfs.bb  |   4 +-
>>   .../dracut-cip-force-drivers_0.1.bb           |  17 +++
>>   .../dracut-config-cip-crypt_0.1.bb            |  86 ++++++++++++++
>>   .../dracut-config-cip-crypt/files/postinst    |  10 ++
>>   .../dracut-config-cip-factory-reset_0.1.bb    |  49 ++++++++
>>   .../dracut-config-cip-overlay_0.1.bb          |  44 +++++++
>>   .../dracut-config-cip-verity_0.1.bb           |  23 ++++
>>   .../dracut-config-cip-watchdog_0.1.bb         |  30 +++++
>>   .../embedded-dracut-modules_0.1.bb            |  21 ++++
>>   .../factory-reset-helper-efi_0.1.bb           |   5 +-
>>   .../wic/plugins/source/efibootguard-boot.py   |  67 ++++++++++-
>>   wic/bbb-efibootguard.wks.in                   |   2 +-
>>   wic/beaglev-fire-efibootguard.wks.in          |   2 +-
>>   wic/de0-nano-soc-efibootguard.wks.in          |   2 +-
>>   wic/hihope-rzg2m-efibootguard.wks.in          |   2 +-
>>   wic/qemu-arm64-efibootguard-secureboot.wks.in |   2 +-
>>   wic/qemu-arm64-efibootguard.wks.in            |   2 +-
>>   wic/qemu-riscv64-efibootguard.wks.in          |   2 +-
>>   wic/rzt2h-evk-efibootguard.wks.in             |   2 +-
>>   ...i-am62px-sk-efibootguard-secureboot.wks.in |   2 +-
>>   wic/ti-am62px-sk-efibootguard.wks.in          |   2 +-
>>   wic/x86-uefi-efibootguard-secureboot.wks.in   |   2 +-
>>   wic/x86-uefi-efibootguard.wks.in              |   2 +-
>>   41 files changed, 811 insertions(+), 41 deletions(-)
>>   create mode 100644 classes-recipe/dracut-cip-config.bbclass
>>   create mode 100644 doc/README.dracut.md
>>   create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>>   create mode 100644 kas/opt/dracut.yml
>>   delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
>>   create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl
>>   create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
>>   create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
>>   create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1.bb
>>   create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postinst
>>   create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-factory-reset_0.1.bb
>>   create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay_0.1.bb
>>   create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0.1.bb
>>   create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchdog_0.1.bb
>>   create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1.bb
>>
> 
> Should I wait for v3 to review, or are you waiting for me to review
> before creating a v3? :)

If you have time you can review the v2 ;-D. I would like to have some 
feed back for the v3 - especially if somebody tested it with out me 
helping.

Quirin
> 
> Jan
> 

