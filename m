Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C8110F2869
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 19:16:40 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.81590.1774638994463525534
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Mar 2026 12:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HSHRZTqi;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE8zP0p0OFGA+jGs03icUXglzIpr+FTOGWUE6Z7BqplOlFn+eBUpTtYJXqZcqAXoorp5olAX7QLfPCnX3gVfEiXi18z8N9PbsW4tysJO166CxqdIsXdQyd03skMEbiN41cNwMQz7G2elKv/yrvNpC/3jbZCk7lZCpvD9+vOpxqtf9o84iD0SyvOe4IFMRPG1yu2M9EE9dF7ENPTVkHYgv38xRKfvSdD64G4LVuMZ1F5pT6AHxNtW/DaGFEJ225pGh3e2Azb1zxvivuptu6BPwYpUTtpIpnNTHPUJJ3JE8kpt6K/JPpoYotdVwqpBWoaqVFvYwnK7yereaOZYvN1iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNYQalRGnK3Qwy1SG0rFQC1X+PKDHScYzIsNh9FSP1Q=;
 b=k6VJ/6Jg83HdrhPiffnRyJkBfP9PNDWI158hIlc3Bin+wJAg1eWTiEpBsvxMPTkKc8Joim7aK+wcJuluuiz5EFaZTiBnkscoJbDH1QC0Zdnjtr+y+rIv6NMB3ZJxvO41mF7OXXOon505bjL6oErY8UKWgG+HUUGVQ3Bz+ltSr8xyBlat7McKKGxtXN/i8Bzdgs3fj6hLXCTXYcPNtQvPvJ4gG7rjbS1u4MbPa0Fh3UuCq/m6OJfBUqc3ZBCBHCw8C1YYXpkyuknNrdhaYiGtF2TsYENrNTI3MDCcEocCmmIjyMatlCO31Iq0NlQ8cQdbLobHOgS/H2z92i+EabLhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNYQalRGnK3Qwy1SG0rFQC1X+PKDHScYzIsNh9FSP1Q=;
 b=HSHRZTqiMmNf68O+iEeuHE6Y+ZO4Ass42U34rAiQAano365gG6B3VRiRT48pvldItPPivLP8NtLMCsvVmc975pDQOZe6LhgiEYWrJ2SivDJcpJgLwsb7AEvd9YUPko6ftnviJZUndMdhbGeflrZLC4VpxlwVYSxCU2ZQYiw7l7ml5yhHp4mT4+GCCDO+J2nSSdYGqbMHdQvkJ5Gw3Q/7fx8pPCPlQUA8BH9UK/8EPAEgvSbQqPzBkp3tpKVUPLSfbZi40d94YmI9oSI2/cEbT6X9YTbca0mmrsj4OKk5o9gVVyhtPwVZ41j/CdO6LjPdkXuXTTvRH21THYd8NUQSyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 19:16:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 19:16:30 +0000
Message-ID: <ac3d73c8-33ce-429e-882a-d9eb5a5620c0@siemens.com>
Date: Fri, 27 Mar 2026 20:16:29 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.11
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0446.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1b7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7e6465-79e6-4918-2899-08de8c355a0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	Um6AUAePDxnLSKyfGEMXh2/aCzHTclYxCG5bib5U8r5S05KF7aQ23YP0dhyzmxFa7PE2KJHTJkFbukTU7j9CAHqP41ZLKH1xY5Eg6cfhJd7OnTReuEu8P3j5Il0opbhnFqg1imwgeeyYbOF43kZAdJScW9+hEkISFcIUrxRV7auVsL8W5+5HnDhg3+Wmn/Zi0d/uF1gfpbfKBLTgdHDrZn7Q4omvhTgp8gQcMdRFKS9CbqRbyW9CMsUPukN6JCpbnUZcwITg5MFk0g0vsVVMypCX/s2tL7sRY9kLKDb1ZNWRhQnGH8i2bxaV70vmz5OM0NEcj2AS5o2e3fcnnFwvPv5T/TMWR1CEHjUqY4RUWxEuIB1Peu3mWOIbFySbiLVX3e/jVHYy8LQAN29oF/cwgOmix8xCDDxd1+Gkm39LeWthOkV5ps5tP8i8FPMC8WO1MtH/1TpEvPHnfPcTR/Pqdtca5ok34cTlMEyc//vspZHf2U2tYaN80BvqVDiPkSmZjlFiHtfsrZ99QCkwMAnxyiEGjqy1vsSaGZGkIu2EhNxwmJRiW4QJ4HiV+t81+ewHRQpC33SruyGBAEoeU6bICZoC0RoMDWDrx1b+PpDrGpQqLI9UHI5VxP5TfNxPgcT1jQ+p1tmAPRQ7k+nSInT/hkL5UfRCOXvkBw+wmu6zSNtVYaoMeAUPl5MN+sLQRol1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEYrRlJ1ZUFLQmxCZ0o4UUJmNE9NRDV5Y0FVcHlpWXdhR0xzOTMzVG5ieEp6?=
 =?utf-8?B?eHIxbzlrMnZYeEY1Slc3SCtBZlU2NXdPQU9qQ0xUQndJcUFURGpMbFFXTENl?=
 =?utf-8?B?NlAwVlVyN3BCM1lGWXhmelBlSnpZRzIwejFibWtCZVZtMkJmRmV1WjVpZUp2?=
 =?utf-8?B?dHZKaTM1K2dZQjhZUTdOb0FCUmhkZ3k4anUvQ0FMbWhVeS9KelRYS2JISmFI?=
 =?utf-8?B?YVM5aXErVmF0KzhYYUh6VzBYaDl6aVVIQVR2MzI0bFNQNitZeXdjSk5BS0dl?=
 =?utf-8?B?S1FUQ01wVUNocGw5eWgzSkVYaTVmaGUrRDFST2dpRHJiTjNqWGgzOE5BSmw2?=
 =?utf-8?B?USsvTVZrMEZBZ2pHVElXaklPTktvTW9DVm5JWGo4NHlWbU92S05yTTlzanVq?=
 =?utf-8?B?OXhvRWl0NTJKUWVickxlb1BJeDBKVGd1dkF0ZldWYk52R1dTcWdrQklyNjRN?=
 =?utf-8?B?SWJzUHp0dU1hV2tDcFo4c2VkajErYWtaZEoyOVpGVWNkRUg2M0oxR2ZRUU9P?=
 =?utf-8?B?TVRzRHRaeFNUM1hDZTRwWk5kRFpQVi9uSTdrYml4RUFONDVvL0QvMWNTTXdY?=
 =?utf-8?B?U3Y3KzZtbWpQM2hZaGxlR1hucU9aaEg0NmZDMmNNWlFxQkR1ZmcvUWRGWnB4?=
 =?utf-8?B?eXp0bzhFeHJEamNBOWFGUVpWREFWMG9QSEMyb1hsSFRrczRZVjYyY2h0ZldD?=
 =?utf-8?B?YU9KSnc1U2c2bTNNMGxqWUJqbk5OZG5xK3dDNzZCWmtmaEtLaDJ2c0EzSVUz?=
 =?utf-8?B?bzlwelVjTzVtWWZKS0x3MDlQclFRSGNMTjNNL21UTHpoKzhyWDlacnpqeE13?=
 =?utf-8?B?eFdUZ29xTUZWYXZubTZkeTR0S0g5UmVyQk8vVEc3aFBSNThMeUxoYVcyK0pY?=
 =?utf-8?B?cDUzd3NPVjZqMzRVcTR6dGRJbmhUdXpuQVg2RWFyUzJzclViNGxMa3M1bmpZ?=
 =?utf-8?B?bjlWMkk5c2ZKOG9EVGRtVk1jcXJvN05xU2lTQ1JPdE5ZdTlFUk12T3FZeWl2?=
 =?utf-8?B?RkRhTGVndm9IbFRheGF3SlJZakhzTXFvdVl3cWZDMW05MngxMDNNWEE2NDdQ?=
 =?utf-8?B?SXpaSDlXNWZLNXh5STBnSTRwcE5SREQ0djZFdVJjYjB5VjVNSzhhRmxpcVN5?=
 =?utf-8?B?NFphV2Q2RWRKUXZ2SWtwUDhpd3hoR1ZUQnBaRDAvV0h4MndyNTRVZ3lubUFs?=
 =?utf-8?B?MVlMSnc1U3dienJDclkwYnVqdU5Gck53Z0QyMk1FK2V6OVA1UEdab2M0UTdl?=
 =?utf-8?B?MitDZXRGZVpOazZkVFlISDhZSEs5SzJuZkMxbXV1RHNWaGM4blZ4eHR3eFZI?=
 =?utf-8?B?cUFNMkUxWXVUdk12MjhjNXorNDF3ak4wUGRqSnBxcUsvbXJDc3hqd3FHK2c0?=
 =?utf-8?B?QW1pYVZjR0l1UnVWVlpoSmFzZmlwVTQvZjFlS1dya0NRYk5tQ2VmeVp6MjNy?=
 =?utf-8?B?aC9HZ3BnV3NsQmgwVm5sUzFaa3ZPc2pITmYwMmNnQ2ZrSkxiUk83VDhSblVn?=
 =?utf-8?B?Tmt2d3QvNEttcUxXeHdzODJBd0E5a2cza2dVREVZa1dpWlE4b1AwcVZneGxm?=
 =?utf-8?B?Sk12Q21WS0RlZTdiWEprZ2haekpXZUdZRThtdmU0NGw2Q2c4N1N3Z0NsMG5y?=
 =?utf-8?B?KzNJamYwUEtLODN4UEY0NURUTHF0UDhmUXBhc2NUOU1pSERxd0JaS1pxZnFh?=
 =?utf-8?B?QzlpaE9LSVBTU1dNUWlacGI1TzNNZ3hEbVR3YXFOZ3I0dWkvTXM2OFN6eXVu?=
 =?utf-8?B?amtKQ2ZCRmM5TjdyR0NQaWU2eDQvb2FtVGREZ2c4TU54aGo5Z05uOHgyNHdT?=
 =?utf-8?B?cXU1L3hza01PTzVPMnF1UEh1MXhOT1A1eDl1REFEQWdaeGV1S29OaWprWmw1?=
 =?utf-8?B?OVlQdDM5MTZMNFEvdUJLYlM0WG5tWjNWZE1EaG1OUTBESU5KSFA1WVB0ZzNI?=
 =?utf-8?B?RWJNMlFVQ05nK2F6MC93QUoxdW1hRk5sa1IvK0UrT0lIZjVyVlRFSlVrb2Jk?=
 =?utf-8?B?R3kxZ3IrNlVzMXUwMmd6VVhFUFRzZTJYd3c5cG1VdDJPamdYMDEvb21nOVRO?=
 =?utf-8?B?NTBlZ2pWMUE4bFU1ODRUVFJZT2Z3dmxoT1hwK0xhUUFkWHAvM0UyWXFKcDV1?=
 =?utf-8?B?Y3F5QlJqbHQ2dmgyWnNTbE4rL3NvRzVRMDVhaWtVMlg0RzlxREkwYXZpQVlP?=
 =?utf-8?B?NS80WTZDOTAvcU95ZzdjSGkwcnNpM0kyZ0tQc2VWMURlRVllR0dzZS9XRFF0?=
 =?utf-8?B?MzVPNDhlZzNvSVJXVUowRHdhTmg0RG1mM3dRMElhaW56UXFtdG9qU2dHMlMy?=
 =?utf-8?B?bWlhdmI4bThxR1VwajVENnN0RnA3MFV3Wm9zTGF4MHVWVDFMT2Y5UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e6465-79e6-4918-2899-08de8c355a0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:16:30.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UoFDfYkuhtZSxS4IqzBOtY8f/ODL8hTG+upoGAnyy8zQZ5vwefYu95oBz6PHKrlhbLKoEM0K//8ApyzYZPtlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 19:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22602

Here comes the first isar-cip-core release of 2026. 60 changesets, 11 
contributors, 183 files changed, 1770 insertions(+), 784 deletions(-), 
our stats for this release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.11?ref_type=tags

Again, we have a couple of new features, most notably support for the 
BeagleV-Fire (many thanks to BeagleBoard for granting us devices!) and 
for wfx (https://siemens.github.io/wfx) as update backend. We 
furthermore improved the steps need for using isar-cip-core in own 
project layers (check out doc/README.layer-integration.md).

There some smaller changes that I would highlight as they may cause 
surprises downstream: We sign and verify updates by default in self-
built SWUpdate now, just like it is already standard in Debian 13. 
Furthermore, we increased the boot partition size in our image layouts 
to 128 MB - in case you use them for already deployed devices.

And then there are several fixes and adjustments, including 
compatibility with latest Isar and latest Debian 13.4. Check out the git 
history for more. 

Thanks a lot to all the contributors!

Jan


Adithya Balakumar (5):
      swupdate-config-wfx: Recipe to set configs for wfx backend based updates
      Kconfig: Add option to set WFX_URL
      swupdate.inc: Enable wfx based updates if WFX_URL is set
      doc/README.swupdate.md: Add section for software update with wfx
      doc/README.factory-reset.md: Minor corrections, verification steps and what to look for during factory reset

Alexander Heinisch (5):
      wic: Unify /var partition handling
      swupdate: Fix unintended modification of the image in swupdate class
      swupdate: Enforce signing and verification for swupdate by default.
      wic: Added support to set sourceparams for empty root-B partition.
      wic: Wipe rootfs-B headers on bmaptool copy

Badrikesh Prusty (2):
      linux-cip: Update kernel config revision
      wic/ebg*sysparts.inc: increase boot partitions size to 128M

Clara Kowalsky (1):
      fix(linux-cip-head): catch network access error during commit retrieval

Felix Moessbauer (2):
      fix(swupdate): register vardep to DELTA_ZCK_URL
      chore: add efibootguard to imager bom on affected images

Gourav Singh (1):
      fix(security): install systemd-cryptsetup for LUKS userspace support on Trixie

Jan Kiszka (29):
      x86-uefi: Switch to systemd-boot
      linux-cip: Update to 4.4.302-cip106, 4.19.325-cip127, 5.10.247-cip68, 6.1.159-cip50, 6.12.63-cip15
      u-boot-bbb: Disable problematic GRUB workaround
      ltp: Fix build with latest Debian
      linux-cip: Update to 4.4.302-cip106-rt59 and 5.10.247-cip68-rt30
      linux-cip: Update to 6.12.66-cip16
      Kconfig: Sort boards by architecture
      u-boot: Add U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
      u-boot: Update to v2026.01
      Add hss-payload-generator recipe
      u-boot: Add recipe for BeagleV-Fire
      linux-cip: Update cip-kernel-config revision
      Add BeagleV-Fire board
      kas: Add BeagleV-Fire target
      ci: Add BeagleV-Fire build target
      optee-ftpm*: Switch to new class
      linux-cip: Update to 4.4.302-cip107 and 4.19.325-cip128[-rt46]
      linux-cip: Update kernel config revision
      scripts: Use plain gpg binary
      linux-cip: Update to 5.10.249-cip69, 6.1.159-cip50-rt27, 6.1.162-cip51, 6.12.69-cip17
      linux-cip: Update to 4.19.325-cip129, 6.1.164-cip52[-rt28]
      Kconfig: Do not try to build fTPM/StMM for non-update images
      linux-cip: Update to 4.4.302-cip109[-rt60], 4.19.325-cip130, 5.10.251-cip70[-rt31], 6.12.76-cip18
      scripts: update-linux-cip: Switch to fresher mirrors.kernel.org
      gnu-efi: Drop self-built version for trixie
      security-customizations: Fix mistyped pam configuration
      wic: efibootguard: Add SPDX identifiers for plugin sources
      tests: templates: Update SPDX license identifier
      linux-cip: Update to 6.12.78-cip19

Kamlesh Gurudasani (1):
      *: Add SPDX-License-Identifier MIT header

Quirin Gylstorff (11):
      kas: move initramfs-tool specific recipes to cip-core-initramfs
      Move RO_ROOTFS Options to swupdate.inc
      Default SWUPDATE_BOOTLOADER to efibootguard
      Move efibootguard to swupdate-efibootguard.inc
      Add swupdate-config to swupdate.inc
      Add documentation how to integrate isar-cip-core
      fix: Disable bootloader interaction in case of ebg only updates
      Add bmap file to speed up mtda tests
      swupdate.bbclass: Set owner for reproducible swus
      chore: Add maintainer to all package recipes
      chore: run swupdate in all tests with loglevel 5

Shivanand Kunijadar (1):
      IEC_template.yml: Update IEC layer tests revision

srinuvasan (2):
      Update Isar revision
      recipes-core/swupdate: generate reproducible source tarballs

