Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C182BC3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 15:34:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web11.19901.1720193677079292412
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 08:34:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=W53cuxEb;
 spf=pass (domain: siemens.com, ip: 40.107.22.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItRUjv0wyzvMyQAukwRhLTsAVx7ysKkiltygUnZ5LryfxEmiL/4tA+lro8b/8DoXpMY7ju+C6MNCG5eQxZSL5eieHmxBoENQNFxZjoewM+HhwTn8nYM4WHqP8HPbXdO2DLgXoddZZHnEJJPwW6TOPoZgR7aas6icAVJNfxmN8taQBFW2zpI2lw/W69U3xjXc7C3O25uQl5c85jVMXBNbFQFjaaiid6MlWPbdtDpbKDjUuec3Q5qiPAOdYhOPbAfpgv85+MIuWYFd2Ffpr5BfezsBYHYY6Tvec10qM5AAozGd7VHRBGUAzc9gbwH13k2fXTAchI4Dcem441SbrtIPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjl62FKfx3VTIyJ8CNa6LunHdosuUPnP/h3g5QLZziw=;
 b=ipzylDBtgwsGm6NOv3WvUPG6a1DfVIsmdBKW1HscguMU6R/FPTZEffhfTYr/XfcO0YMv29t6V/nG8VjK/Efk3Ob3HOEKvdWycXRGimB9btPMZEJ2dVtA4V4bW5AnQYM0aPrEBj+1pbAZkwzGj0UcQIzIpXeckuCUtZ5T6TqDnDxzFXn4s6gvMNMgS2Q6eBjaCB35Z//bwysGHHQgr2EqMWKXlU/FH9F/LVR1u37kjeVP1LS/96w30uShS3tS9bAMq5tH6WrHOmRIMTYXh4sLL0mL+z3oyhz3jmx00v5Pq4YrL1Iv+irliYhSG6fktsQ0DQFZ6A63boUCxpzLGlFuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjl62FKfx3VTIyJ8CNa6LunHdosuUPnP/h3g5QLZziw=;
 b=W53cuxEbjTW/hZDUTeamCAfVl/gzcRVmQK50rB2hfvXj6PvFUjqoabDvyIX0qy2L7wg5w2d+bVaAau7prUunF4LHlq6G9oemdExgIMxZxasc95maVPUx4Gf78K8IM2z9UmgiEOUOwfP7XoRKHDcR1LeAZnkB/grTA55BpCLM/dLRqFGZ/YEimuGN7gmmC4x/nsnZr3z52IkPna9xo5z4fge7EqMC2ekRo09+524huLjEkpRmqnA0HkpXMeaAvX70dBZDHi0M+rswhLCMUnguKtttw9dQNAV1RR3ca8T5qD4u7GTfgEQl0UCCYtk2Dn3rbBl/BBaXOKF0rvMZk0UX2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:416::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 15:34:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:34:32 +0000
Message-ID: <4465175f-5a58-4be1-86f5-a83eddc30887@siemens.com>
Date: Fri, 5 Jul 2024 17:34:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3] README.m-com-x86.md: Add M-COM board specific
 details
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240705145601.1413337-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240705145601.1413337-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 18514fb3-824c-449e-b7b1-08dc9d07f77c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4yUqnQZ6kAibffUU4xFn96r+w5R1MGvi0VMEvqW8qbrxrX1rzquMfEMmHWqg?=
 =?us-ascii?Q?C6ecsklP85yROlS3HEpnb7bAHqNJzU2/nRqDi5p6ObPWjMUtpB5XfEHjQiVP?=
 =?us-ascii?Q?cRxAJtCILNGAMvARNrQanMZU4GztLgEN5oYLhJAND7+WhEzwcTr5FVEE45tQ?=
 =?us-ascii?Q?wlbI6b3a35k5JxnocJeuUnZilNpe4jGuq3zs0Vrb3UAHDQbKcL8cqIhXu17B?=
 =?us-ascii?Q?Ya/0r0zeWdTUe1+c220Q31u+Datkalir+jV1ub33WR1p4goA671r9DdjND9K?=
 =?us-ascii?Q?o7lv7VgXjMttktF07TQ0SnIomKAWftJNdDjGQgCiXRk4s4j0EWr0EilL7Jjd?=
 =?us-ascii?Q?T5sg4grAoYj9CU9B4WIf6qYgh4UPCoe6+q88PPauj812DRG+48eJOXUhmrFV?=
 =?us-ascii?Q?jko5Duu2riI8KIYQTW7YNrhIVpLOm5K47OTeBQA98YeZTl7anfV2KKrvehAt?=
 =?us-ascii?Q?ZAIaa6MoevhaWSUDLYOsuvC9eGI6DhNxW0cuKOFUYati0c9OWksnjFL0b5mW?=
 =?us-ascii?Q?sl9t7cw+0l7sw6e7urIxhrzCM7j905xM1agkJs59Rdvggfjh6GzngIqQ7qYc?=
 =?us-ascii?Q?ARM1IlUpKRZZdmfs8oVI8/YSAaQC3eLYC9o63HfzuumOfDTI6blT5yztmXyU?=
 =?us-ascii?Q?y28L7o8OfebKA4DqtbHyRbbYJmKyBiVm2F8xUdon6FkBmHosetnkZE+mKMbQ?=
 =?us-ascii?Q?ods8LRQF2XZyX1iZ6k7Z9aiekuC+SVthSniDmK2TytslNwYDYkUUITIn6R+L?=
 =?us-ascii?Q?A8Of6rROw6RGK89zNcd6cDVum9NW7LIn17AFsR3ByQ2sBX7YmevOG5P1aOEv?=
 =?us-ascii?Q?Vl56e/fxMAI5coCXnNY4OQWRzgs3u4zIU4RPqVa8GQ4uULSPooAI1LTngLBa?=
 =?us-ascii?Q?5+paMiZrbNCrkvaKugEBLnUP6NGWqaj6WSseHMuxStejYyTQRFM/h2Ts2hP3?=
 =?us-ascii?Q?4Msm/a1qwbl74XfB9pPVVQ/HI1nfoCqNKj9u2qQRDTGbT6Dk/sh7+JyslLKx?=
 =?us-ascii?Q?a36Xj98oHjbqlNiF6hxsVNfOWwHD+K8uMQkFVgKtQYhWmEbjNVPVoK1mwan9?=
 =?us-ascii?Q?f1/dafUW9/R2ChviWcj7Nqgf27LaSeBN02UjQmdKjtGcmc7WDCeNdB2ZkgiZ?=
 =?us-ascii?Q?CEhtqKtWlapC7TsyjxpFVzSQzixhcPLz1C+IVs61ycozNI2fiqbss8zxZmiy?=
 =?us-ascii?Q?Cfs7EFEg+/fkG72CAA03R6Ne+2ISyxs9p7+9SopJco+Q3Mhyb1aeNR77+BJ0?=
 =?us-ascii?Q?Wkc1Qblmwk/Gj0WuV0tCDd/ihcHQ+e8o+bIQ6b8lJ9HpXIfV4OG9b5Y3gmwo?=
 =?us-ascii?Q?jlJQ+Gw4ncqorSJC76bNHvJ9XsbmZXBwf2yTTFCzcHs8Jg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C30hW9Qpk2+BYhUoJC/xo1EzzxB7COfxDQHQI87xA2B9dPLd6xC19d5YV7L8?=
 =?us-ascii?Q?JhrSfHFqR3PNlPjE3fiHpt0fyVFJfEbipj+DRBsDhRKTHYGxYXf1bg0Uc6R7?=
 =?us-ascii?Q?PmRL9KvaKCXdHXe/qnR80e32Di6VWqqCHMc2m40sfR6Cm5uboW8jfYVDp+O7?=
 =?us-ascii?Q?g3fsMqu+Tv/T/Pq6IYwo1L3jR27EkGTaDakxAFRvfUinF+Xl0VdSmPi/x0NX?=
 =?us-ascii?Q?XEvsjZWySDZYMe52d3HIKEBME85hEgsYnQ1+Mxp9QUCda8jxZlxRe0LrE9BL?=
 =?us-ascii?Q?Y9TZ1if5SiwixYgUD0tSxTRc9wvo9JgwwDxfphx4d3nKenw8d7LmK0QH8enH?=
 =?us-ascii?Q?7RK7quV8W2XXv2U42eO3OEFSPe4/tpPsp6rCpHFISgTat8HfVUvVr1i8XwMd?=
 =?us-ascii?Q?VWMe+YklNtGzSMfmO4eT+4G/y7YrjjwU//L9fL3B827I3KBFW+sfvBz5/SrG?=
 =?us-ascii?Q?yyTNvJhZO5n6XCdFDnjjVPK6NsU2KuKt96xXVANpxyyk7CDUS702zngKeij3?=
 =?us-ascii?Q?bKBFEk5SJuXov9S0Cw7qlKmoN/cAZdjd6fKSmhhVVpG40hD4C5P0Nch6zo+7?=
 =?us-ascii?Q?NjVkXlBzOvXpg9z52bQGQDSnQvSEFE07JStHNGmb+cxy9mta2uyRsXy+E31i?=
 =?us-ascii?Q?6o0Lbh7nAjsqgQUdszXnkO2O5IsOCj7+ur7as8C/C/QSY3xBQoGl/8FH/mXF?=
 =?us-ascii?Q?bk6BB5oSBlpTE23oYj4+9WAaKKMfBrX2BoumHjM8cS34N2JEEIWEEm8/23TT?=
 =?us-ascii?Q?bNJrHa8B7FjHMePYQWsW/SqHFVion7r/w+cOuWH87XtSdQsPwl+d8htwhunc?=
 =?us-ascii?Q?GASBli7nSyzfilGRvqz7tbfNEjIkBr8eHUj0D9zvHx69ZD4Bc1tqfEVx0TpQ?=
 =?us-ascii?Q?CM/0lTlPTtYKER7WIhBYJliqGtwOpDUiCD8XTHxe9nwHrga9gsUXq6Hjch78?=
 =?us-ascii?Q?Oo9+X7+XOp2XXD13/7GM1J63PYL4VYAVv0vwzWCg4MqYB+MvhYVeY4Twt+Nq?=
 =?us-ascii?Q?w2xu0/5ExvqlGrfeFkW9otbKGNbOOtxSlnvBw4/mrDeknpAxdjP5RUyJA/7/?=
 =?us-ascii?Q?xRT/gIxeQaW5p6PtFRPltMawQzD3Kx9fLRfA3vSDrHRskQyFiBV7u8guPV33?=
 =?us-ascii?Q?+cs0h7b28Id6ZmuilGz18aYIGdJ/UdyrZl6678EefOcgDUZN9Wd4IdF7M4sy?=
 =?us-ascii?Q?RmAq8UZSlq6iAlNLaZGP8mQJlutSmLauhMGpGNChdTqj3drCAh+bxGL4Kcmx?=
 =?us-ascii?Q?5wv3aoZt6lm3mgR4/iPSJpHMNWxBZwaIDUpyUtEuvJ6IFuIbj5DI6zvIFQxY?=
 =?us-ascii?Q?PwEuf7YoWtenge8bo4NLt8eThu9FlZwjw2BQchU0aFcGh14lPjgsm8K3Cyl4?=
 =?us-ascii?Q?M+ozb+96GLJzKjtNu+3gsa1R8OMeB6/Au1Dn0orwFYTDBzGg42D/qyrVLDAH?=
 =?us-ascii?Q?+PfOMHRW/buoXsWJeHg/nzjyENHMBKTgG+NcJI7JjmB+ORaQ37JAdnJaGwsp?=
 =?us-ascii?Q?3yKaSCWpobKMKdSRVyxKX7pen/fVEjDGpqIUZG2IeLLMeq1YQo08VXqlLuO3?=
 =?us-ascii?Q?DadakdX/5XsNUrWsKbwb4plwAHSmaiM3XY9CylFhYNgEEAcqN+JYXa8wOUXK?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18514fb3-824c-449e-b7b1-08dc9d07f77c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:34:32.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haq3z3hfkYFUX0oIFasnoPPgE4dvelZcUTgRzDliah+gUMwRgMdD0u1LqIgR0iIax8LRfhwyVQxFoGN6mrtT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 15:34:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16418

On 05.07.24 16:56, Shivanand Kunijadar wrote:
> From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/boards/README.m-com-x86.md | 102 +++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 doc/boards/README.m-com-x86.md
>=20
> diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86=
.md
> new file mode 100644
> index 0000000..cbd74ad
> --- /dev/null
> +++ b/doc/boards/README.m-com-x86.md
> @@ -0,0 +1,102 @@
> +# ISAR CIP Core: Instructions for M-COM RT X86 V1
> +
> +## Build the CIP Core image
> +
> +Set up `kas-container` as described in the [top-level README](../../READ=
ME.md).
> +Then build the base image,
> +```
> +host$ ./kas-container menu
> +```
> +Select below options to create base image,
> +
> +* Generic x86 machine booting via UEFI
> +* Kernel 6.1.x-cip
> +* Bookworm (12)
> +* Click on Build to start the build
> +
> +For SWUpdate image, Just select below additional options on top of base =
image,
> +
> +* SWUpdate support for root partition
> +* Set EFI Boot Guard watchdog timeout in seconds to "0"
> +
> +For Secure Boot image, Just select below option on top of SWUpdate image=
 options
> +
> +* Secure boot support
> +
> +After the build is finished, insert a USB stick and flash the image.
> +
> +## Software Update and verification
> +
> +Refer the section [Build the cip core image](README.m-com-x86.md#build-t=
he-cip-core-image) to create the image with Software update enabled,
> +
> +Copy the .swu file generated from the first build to temporary folder, w=
hich will be used for swupdate.
> +
> +Create second image(RT Kernel image) so, additionally select RT Kernel o=
ption on top of SWUpdate image here.
> +
> +Flash the image with RT Kernel to USB and boot the image from USB. Copy =
the .swu file from the temporary folder to M-COM device.
> +
> +For verification, please follow the [SWUpdate verification steps](../REA=
DME.swupdate.md#swupdate-verification)
> +
> +## Secure Boot Configuration and Verification
> +
> +**Note:**
> +* All the steps are specific to M-COM RT X86 V1 device hence consult dev=
ice specific manual for other devices for Secure Boot verification.
> +
> +Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure bo=
ot key enrollment](../README.secureboot.md#secure-boot-key-enrollment)
> +
> +Insert USB memory stick to M-COM device.
> +
> +Power on and Press F12 key to Enter BIOS setup.
> +
> +**Note:**
> +* if you want to restore the default BIOS settings then
> +Under "Save & Exit" tab, Click on "Restore User Defaults" and select "Ye=
s" to restore default values.
> +
> +Enable Secure Boot and enter to Setup Mode by following below steps
> +
> +**Note:**
> +* Due to following step, old keys will be deleted hence it=E2=80=99s rec=
ommended to take backup of old keys to avoid any data loss.
> +
> +Under Security tab,
> +* Enable Secure Boot if disabled. The System Mode will be "User" by defa=
ult.
> +* Click on "Reset To Setup Mode" to remove existing keys.
> +   Select "Yes" to delete all Secure Boot keys database
> +* The System Mode should change to "Setup" once we delete all Secure Boo=
t keys.
> +
> +Under Save & Exit tab,
> +* Go to "Boot Override" and click on "UEFI: Built-in EFI shell" which wi=
ll launch the EFI shell.
> +* In the EFI shell, run KeyTool.efi from the USB stick and add all Secur=
e Boot keys from USB. Follow the step-4 from the section [Add Keys to OVMF]=
(../README.secureboot.md#add-keys-to-ovmf) to inject the Secure Boot keys.
> +
> +Exit from the KeyTool.efi and built-in EFI shell to BIOS.
> +
> +Optionally you can confirm the injected keys like below:
> +
> +Under security tab,
> +* Click on "Secure Boot" and then "Key Management" to confirm the inject=
ed Secure Boot keys (DB, KEK and PK).
> +
> +Under Save & Exit" tab
> +* Click on "Save Changes & Exit".
> +
> +Now the keys are injected, remove the USB stick.
> +
> +Refer the section [Build the cip core image](README.m-com-x86.md#build-t=
he-cip-core-image) to create secure boot enabled image,
> +
> +Once build is completed, flash the Secure Boot image to USB stick and in=
sert the USB memory stick to M-COM device.
> +
> +Power on and Press F12 key to Enter BIOS setup.
> +
> +In the BIOS, Configure the device to boot from USB by following below st=
eps
> +
> +Under "Boot" tab,
> +
> +* Select "Boot Option #1" as USB device from the "Boot Option Priorities=
" section.
> +
> +Under "Save & Exit" tab,
> +
> +* Click on "Save Changes & Exit". The M-COM board starts to boot the ima=
ge from USB.
> +
> +After boot, check the dmesg for Secure Boot status like below:
> +```
> +root@demo:~# dmesg | grep Secure
> +[    0.008368] Secure boot enabled
> +```

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


