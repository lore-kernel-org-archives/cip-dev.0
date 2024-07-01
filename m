Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D032EC2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 07:47:43 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.79])
 by mx.groups.io with SMTP id smtpd.web11.14758.1719820053831908547
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jul 2024 00:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Ce8H9SgV;
 spf=pass (domain: siemens.com, ip: 40.107.247.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Q/zerlEOHadKJ7X98PVWrL3EawFTNGa2hhBI1YIKNUppkZd9WY3FblXzlYTM25B45qoIMpfzUjtxQmoCIXbF3M7Zc81VUglGUncdLxF7zN4de8VvrCrOcmOKtbt/R5Kg0rBWKX2pwBsXxercjgtQZ5NE5kXx+opHEnWQSmdd/dxtym4hq6H7oEu5cSEZfZwuO+DfM6+gmH6LuIZ580cAU90AfJJ2EibNZd7H6TIVtbXnFEmv2iQjo+v5Wm8zjegqdq3J1XcFr2dMLsKDtr7gKL2AyN4UhOjMOBhxjUqv2NvFiZLYtwR6/znNHKyl6i781ybs6O2PxqAI8EdyJ4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDKLTmJ0VuJL+rVbxWZiwKtvBSGN0iJuUYWsSHpoA3Q=;
 b=W6ocfnj7xeOnrfReV5XeBNzPApGgAipZqyNKIChf+BgNUwkVLjP44qnPD9eIXLZGl29VSU3dBnvEAowfSO+0jA0EC19dc4oVLHWb+O0pcSrR1vXnI3Woh404P2nI2DYqiJ4Whq2XPyAnUp7cNyhYXeEbV/GzAUA72s0QZc0DJ/b0ozy4X+7c+nSvzAuUcxik0iHMQ85dF7y33s7mKQHzCklS3kCK+FAFfwwT+0hnGrjEE1RfE2dHYK8Eqrwnm5yQURx4zG8eE0+Jg2c2LWcjgidI8PlwoXBqukKm5yfVc966tnV31lUB68MJuvZI1wuwYrYgEwRUBPB6eB3VpZ4K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDKLTmJ0VuJL+rVbxWZiwKtvBSGN0iJuUYWsSHpoA3Q=;
 b=Ce8H9SgVTC8KH69zotGWAKlkD91jH0nndWDjjMSWfy9CiiQlKwzcCyLo/Mso6jmAWjDhwELPRRCdNWgfzVtu8+0pgCfBvm0f0W7IDBljJoBwR1fNnbXJt3BfR0VzYiAv5Rc3lkL+mXEn2f/HyakNsR91xV42MyQM/P3x55q4C+9U8DJD0LMMV9hGmW7JNcSlNBgjwQUOSCMLtq9x6uUQsyMhFGHE7vXSlhmYsyk8jUpIWNYA4B7Uzq5/5L5GX3txztQeSrXrlyilOroIwntqUVku4Cqh1bthCMvBsL3a+5qyueesSSxEk2UFwzOM90KeyqBqfNfK9r3YMvVSHkk7zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:577::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 07:47:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 07:47:28 +0000
Message-ID: <0fd02bc4-7ddd-4269-8915-f465d5f4d1e8@siemens.com>
Date: Mon, 1 Jul 2024 09:47:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] doc/REAME.secureboot.md: Add MCOM specific secure
 boot details
To: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20240701064005.1651999-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240701064005.1651999-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: fddc5c10-3c09-480c-7793-08dc99a20e59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SytvZ1I7v1F3n38OKadxlZdsJl7UZYC4u/U2GF4EQZ53OSz2mjnacSNDgg2B?=
 =?us-ascii?Q?NxacA63px0uWyG+LCiIPos/7znHVG5l0BzPCJ7BvPF9Y2tU+NtZ3bHuPje0m?=
 =?us-ascii?Q?o3N0i67NahNuSpLul5Ae6bACLpTyvD/dih7eRxn0FExigBB+A+H8Ak0spXAK?=
 =?us-ascii?Q?10mSIOMdaYJhDP07FNdMA/ncGNExIxWFbRESZHgslzh54BW+7tZnVAatIOXQ?=
 =?us-ascii?Q?vAKY9HZBgtXXXTFXrOIzg6+wmi/cOlt9fqtC9nm1NWm841JxbHxT2V6sNwH4?=
 =?us-ascii?Q?X3VWc9eWwA1wG+E7SIusUg7ZC88Ni64sCVMUMpX54NtbK9Q8PxNCGCu9J+WS?=
 =?us-ascii?Q?IPWZyI2aDvOCzYeWbDuNQX3COjM86zsuOr/YKdSFjWnQYtJ7q+lhcCHDAU41?=
 =?us-ascii?Q?ZLudW8AbX4o7YcuYrR/7ZHxKJQo2S/HPBjbj2Wvkb7v5/cy03BRj3RDO+NF2?=
 =?us-ascii?Q?62hjoyQDrxgqh88xHq0YIg4PQrOWccyaDT1b9Mf3JxTBkJ3dLOCBgX8M40FE?=
 =?us-ascii?Q?Ll7JabvwWKeb+jcKjMNNGSwesopccpFeR0XInHN5Pkx8Unp43w4gTHotZY0c?=
 =?us-ascii?Q?LDu/lkrcvSNXTsspTCahIgfBk5vDGGcNpdW5H4EyIwDtpFNNKVKrW1IiHpzV?=
 =?us-ascii?Q?JOu2ETbfJ1MYtezXvrheFqsVeOGJKio8lyert5LclXyzFoy6rpDt350E0gGh?=
 =?us-ascii?Q?iYfdpwjGB/VVwNvAovTuvUwRGBFC23vau0rOoSLL8A2W0EDAxRlGJhwy036f?=
 =?us-ascii?Q?OjKx7BWHLZLfSTYdDT7fzgo8JPWtGLkGepaBhlVP8FuxA2m22o/PGZnvgs/W?=
 =?us-ascii?Q?ltTO9ARBQ1A03eZrh8kVukCAPJWBHn6dVo7vu9kHfPgU+cEKJpj7Nbfqdbbl?=
 =?us-ascii?Q?rM/98bs/VpVjRaeV8TT2KY4bo5H91b9iLSvMdUJ0GbzH5EACKu0bZXpMRnc6?=
 =?us-ascii?Q?p6+mXEW2+7tOroIfCkZKEuMaDM/AoeC3mxyAC+gdMLUYKzv8yXZqglmMqxOw?=
 =?us-ascii?Q?uNIW1BMUknqcpZRPSX2EOHa9UXsFKVWmA41GckHZAJbZz9kRCmZ0Up6kRcj0?=
 =?us-ascii?Q?/HidIGen/0DnO9pJ5gnyb0AZaED21nY2NHMRcjT2jxXbuGy5MjOlP+a3bHsa?=
 =?us-ascii?Q?tVr31oE5/6Pf3pRjQRRylA5eWnAzvv9hXY6Kg5lAKFEpSBFC2NQU4tiU+JHx?=
 =?us-ascii?Q?Ug7zcioCPQQ4MB+3/Q6GQDzjpdx/8r5omucmn8LdZzIsQdunQ0KXy7ihlo4b?=
 =?us-ascii?Q?BTUbGw79M6phPQUpYhHR3RCLSYhFICHtmy3Lnbk1KR2PxxOzjd6bVCJCt63u?=
 =?us-ascii?Q?az4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d+qJz9TayN7SBw1eOR7dKk1ibE7cD1UC67KrK4JIYUPeT866cMZG8IjrHOa8?=
 =?us-ascii?Q?ETtwfFYoslrzt1PXV5IcM3TZiLP78b2xb3edo5F7ZhxGALtxxpm58/FwMiQn?=
 =?us-ascii?Q?Bhjvnnqrq7LVtnMZgTEoln1nup4fsSUWPJaRvg5tNtXCsfFXOgl0PLy4yN9E?=
 =?us-ascii?Q?vXG63NyF4ypXpk73VPU2WUsp6gk4b/L3GkcB8MmWTvm+txy99oNR+2peRAE6?=
 =?us-ascii?Q?mdxVJftuma0qILt9+/qeaJ3S3cvcbuE7KLEuhW71T6jhNaEjv3hGqVPaLFKA?=
 =?us-ascii?Q?XH5Sx9kDYASX+u421BaPBAtpwUugG0ihGIBjMemof5exKtRyBqu3+SiU6zaH?=
 =?us-ascii?Q?9Zf1Ccn4v9e/CJf+1Y6gehArhRytJTBQvIn9xkDBrAFywmXH5wqUQPC9S01D?=
 =?us-ascii?Q?EuNhHevejhgUuRDdTQuob9dxGt4EqdU227U/znXbfUGaOZC/A0Zzk428Rbpc?=
 =?us-ascii?Q?OQGFJJxmRpXdS6X9pOaugk0r3Z14iSJHM+w5GLoUlCEkyr6RQKIf870UNbqC?=
 =?us-ascii?Q?5lfMHfEqs7Ln7tTSnms3F/fZHsNqM8oOJFTUw8CHgD6cB+3PZTHRClOtcCRg?=
 =?us-ascii?Q?ygzU4M4rBevkckmzS/7yvM+Qxt0OeVI3MnqO364e9ZQNzc+671DRZZFuL/XA?=
 =?us-ascii?Q?QQa3uBGVrkgSS1XA7Ew/y4s+Q3J/qnSgmxZcP6saC2rdwDKGA/zaByDhTWF0?=
 =?us-ascii?Q?wyBRqLESYy38j7i9nPF/mL7UDA6PMH9MJ78bMt4ikRSyARCAkadVWLBqPtNw?=
 =?us-ascii?Q?YZNelA0XMv5VtkjcRjSPy3k6XvCb0l3vObNE54Gy/x8oEWjvdQeZ13eF4ZH9?=
 =?us-ascii?Q?bqktZVXhHAWC9xEd6ozHKqWGUh2MnKmx/0I+zdrMW+CO5YTs9T/kNb4h2Oar?=
 =?us-ascii?Q?12vSZDli5ggsB6vDH/kxipo1V1+8P0KAv1yeIdEDvY8rLMfBrWDME1sdQxoO?=
 =?us-ascii?Q?EWfC1k+A7gFvBcF0RNu1fePnAF8qTt+fQTth61WmjKrsN73ALKc0yU7WOIHc?=
 =?us-ascii?Q?R5l9MvhxqW8YNlnDukajMyOj0U1dxyEGIp0VdVA0lBu9BRkE4xsejT+AB3j6?=
 =?us-ascii?Q?ki1P2zuYaQog6h07nW+zgHxYE1ZpMNuyDPpBgoxKtDf2vxTQKw5FSokgyYjw?=
 =?us-ascii?Q?OmrmPOZ4m5KKyL5GN5idiOlhOwertXjtlBkXZOVhJZNefiy3vD9wuRRs429b?=
 =?us-ascii?Q?A8kP0AA2aQG1OMRCwtBtn/ldy6gwdTSgP9jhBfYEXaBNka9lL1h5d8PwVuwI?=
 =?us-ascii?Q?2+ms/BAZcRuhHtxFQE2L8/n13rVwYXEt/CSnbejvQpIEudBLGaWV0njZYy5j?=
 =?us-ascii?Q?GXbG/RFK/8ESnboD83RlQaA8gIsGjL/6E8OMitkCCE2SOxrOySV14NMlM2g3?=
 =?us-ascii?Q?Qs1p96tBrCrOmcxesACE25EyRWSLMy2EnBcm+KaSLl3e/2ir/uGNS/5deU62?=
 =?us-ascii?Q?jCGK7PMODfYPsMMHpMxijDqOR1MMi8M6qwRw4dfrHINvAJ1DihG/LM8hkkSk?=
 =?us-ascii?Q?szDlSf/Z2lHBIovjnKuu9sW/MY+loLuwOQJSGn1MnWsZJp4xTjUi96pfSwGK?=
 =?us-ascii?Q?ZsKASiR/uwzmIaojbgdvXYhj4oN7WsvNVnIBgMEb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddc5c10-3c09-480c-7793-08dc99a20e59
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 07:47:28.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdiznbB3Hk94+cAIhYa+/r5IubVglK+t5LOXkGKNR45Bkgxb7hTh6rmwyLGj57wi0CAc54Cfw4s3dLzQh0rbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Jul 2024 07:47:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16353

On 01.07.24 08:40, Shivanand wrote:
> Add separate section to configure and verify secure boot on MCOM device.
> This section includes the detailed steps to enable secure boot via BIOS
> and inject keys using Keytool.efi and finally the verification part.
>=20
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 85 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 3ae4154..7917207 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -322,7 +322,28 @@ The following keys need to be enrolled onto the devi=
ce:
> =20
>  The enrollment can typically be achieved with the help of
>  [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-update=
var.1.en.html)
> -on the device. Otherwise, consult the manual of the specific UEFI Firmwa=
re.
> +on the device.
> +
> +If the device supports built in EFI shell then the enrollment of keys ca=
n also be done by KeyTool.efi tool like below:
> +
> +Format the USB memory stick
> +
> +```
> +host$ sudo mkfs.vfat <usb device>
> +host$ sudo mount -t vfat /dev/<usb device> /mnt/
> +```
> +
> +Copy the KeyTool.efi binary and self signed Secure Boot keys to USB stic=
k
> +
> +Here the folder "keys" contains Secure Boot keys(DB, KEK and PK).
> +```
> +host$ sudo apt install efitools
> +host$ sudo mkdir -p /mnt/efi/boot
> +host$ sudo cp /usr/lib/efitools/x86_64-linux-gnu/KeyTool.efi /mnt/efi/bo=
ot/KeyTool.efi
> +host$ sudo cp -r keys /mnt/
> +host$ sudo umount /mnt
> +```
> +Launch KeyTool.efi binary from the built in EFI shell and follow step-4 =
from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boo=
t keys. Otherwise, consult the manual of the specific UEFI Firmware.
> =20
>  Use the recipes [secure-boot-key](###secure-boot-key) to provided the ke=
ys
>  to the signing script contained in
> @@ -334,3 +355,65 @@ During building a efibootguard based wic image the s=
cripts contained in
>  the recipe ebg-secure-boot-signer can be used to sign the bootloader and
>  unified kernel image(UKI). If the keys are stored in a HSM the script ca=
n
>  be exchanged to sign the artifacts in a more secure way.
> +
> +### Secure Boot configurations and verification on M-COM(X86)
> +
> +**Note:**
> +* All the steps are specific to M-COM RT X86 V1 device hence consult dev=
ice specific manual for other devices for Secure Boot verification.
> +
> +Copy KeyTool.efi and UEFI keys into USB stick as mentioned in [Secure bo=
ot key enrollment](#secure-boot-key-enrollment)
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
(#add-keys-to-ovmf) to inject the Secure Boot keys.
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
> +Flash the Secure Boot image to USB stick and insert the USB memory stick=
 to M-COM device.
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

This does not scale if we have to add a device-specific section to this
file for every reference device. Can you write this more generic what
was missing in the setup guide so far?

And for the deployment process, we really need a generic installation
stick. The manual steps should already be described, though.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


