Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2AAC30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 11:15:47 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.56])
 by mx.groups.io with SMTP id smtpd.web10.14731.1720178143314637801
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 04:15:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JW4wvCxK;
 spf=pass (domain: siemens.com, ip: 40.107.103.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezG7oJtZJ9veZGQEfF2yIPcbWYC5MbU2MHRFi8RQobXcs+3CqUi9fR3/jk2ZG3i8cqCInXkC0azht5EVXRBKpTfjQPPIvY2IOamcVfKzrKBplczLjcmPPzCXdpqiPIf8dTC2OrYC2+G22xSdOGK22OxXcvHtdlEhg0+KyA/rx+ur493aa1XF+UVOwj77VgeZNCXF8kE5e3mS2n7VQZKDEYaLmGm4qTLSYlpc+va/lRJBraHGuafGKEACk+nM9iovJxY1N9LFx+/HRS7KGdjIerUUHE0H5uGLB5F3u6xK1tp4D39Z4IVYmWEuRJiN6MRj369gD0+fMVJ8S0J1t2R3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvGetI/ct14hsIo7kxJxkPdhKHEwahCmPs7rVbT9Rvo=;
 b=ZVZfp2FXhhKndrIaD2iau+r8ygtPGIMAhtInDE4GtI9A90n5n7jHL5AElZC6MR/2Z33zQ1FECfOZoZbOU/eqr3sEpk71bTQbtuVN596F9Q72noEGfqOm8GosCtgSBwCt+EjUDmDz9JDSlzGfrktFGVshLv7J3YyQea2TKt80B7p3JaDPNQ4oHJCgxwmMJr3b1Be0C3oE61EcH6d6GibY5U7SIVnvWHB+QNgHGuqjcALbK2lTAVY5BjwJbyt92T7nVhVyg4kqxvyNtTjJq+rEYE20cuwi8zMo2O2QldXVG9JgK8RveY7NlQU3XEw4AdAf7bb8e+llv4KHt15s0Ecwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvGetI/ct14hsIo7kxJxkPdhKHEwahCmPs7rVbT9Rvo=;
 b=JW4wvCxKld3W9I98vf+qVpOsVCn5bIeZfQlE118aggNG7pWK9wmYvUReJ4DYAf0917ffWRwJT4dkhkoWS+5PgpOGlvQs7leY+DefwmKBkgbOheFXlvb4lbNst/bljqU9s6B3R8QiLO3bNO34NR335kUEsX5ZJd405Lwkbldrr0juhF4dd8wojSMVuqfdYNRsDu5EAppKsgQscja99Jf2ZhdGNoqZXabISPwdUSQ3whVSp/8dZhIi1cfVwZFULCh47Odfjqnr3C9pae3R55AkY8x0dA2G9tsaLXmXo+gQPJOW6iz45lAuF89Sh3mBabBkDvbSiXViTMF47bpFnXamvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 11:15:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 11:15:38 +0000
Message-ID: <5032d0cd-0965-4a0c-8d6d-c3152ca48676@siemens.com>
Date: Fri, 5 Jul 2024 13:15:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 2/2] README.m-com-x86.md: Add M-COM board
 specific details
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20240705071129.1374609-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240705071129.1374609-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: fce448c1-8c20-4644-74dd-08dc9ce3ccd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2k9f9rQwZu6vw6R8NpmpNnsxxktxszkvlZgWayCWA/rgCc7m/2upZXFKpCHR?=
 =?us-ascii?Q?J79lhEHDSxUF+D4VIXfmNEy/vH2XrD3kfg2uKYFa+ldH7WHl29CHwkildUgA?=
 =?us-ascii?Q?u85EX/jLYBletH4z1x4LEWrsKAwszWuH+WkUrceyndYaPfggIvCM2GI6Dwua?=
 =?us-ascii?Q?Wgc9eSyozj0DPoIQm3iMGKsnvXwV0NqsMu1uE/2WkXuoQtI7omD2dMFi5W6P?=
 =?us-ascii?Q?gq/nBs2ThXt5DPEIVGEZwxTcu112nVvhFxJ0yNfYdOtDJS2Bik3elMb/HslR?=
 =?us-ascii?Q?a1KbJGkNzfXnbzaZAOce6Vi6MliOa0CJOes6BWZjAc8r9bimSQ+8xMCv+oXl?=
 =?us-ascii?Q?i5OzE77Ijylocz+blcbLL9P2UQn0qK0dATm111PVk6POAgqaUKF+mw/vleB4?=
 =?us-ascii?Q?eVG6fk44FFbGWFti93xVSII+O6jcAvRwG3O7zgrkOJkY6kKhvnYWmYicfCVQ?=
 =?us-ascii?Q?kfBM7+6MaBWcEgmoP0Ai+Zjp+UTHxGspnoiL97YoaIGXa/a8lg1vw3OzR3CW?=
 =?us-ascii?Q?tZLW0btKT55lc2YkwbdIw52TM6P5wfy+VbxZS7lxNzHVborY+1no6d+lCC3S?=
 =?us-ascii?Q?eGyK3vdSWOOw6n0GJC7zBGMt1LiPhswFqq8f/kaol2jmB4whSOdteIljLPYE?=
 =?us-ascii?Q?BL9HJsB8b5RovXGXxROewYLISzqmsb62Fp7ibI5Og6Wec+oXJ0GgK6obrUya?=
 =?us-ascii?Q?1uRNIQQFd8Ry8yY7AcKio9RzKbOef7CeL9pTC88nPNG2Uy0WY/zttu756zGa?=
 =?us-ascii?Q?Zn9DNR8P52AwTO3Eb6x1wKKRaT25PovzmswdkxC++jIJf9KxSocx80591hiN?=
 =?us-ascii?Q?Vd4afbCNruGxtaNaMmaABNLUN2s1mROEtexof7/LVZomy15ZiopT6icuzim9?=
 =?us-ascii?Q?yi9eyAcCgfi3a5KcSdaZdFz6C2h9xql+sl0mH9OUvsT9FI0a0O4O25D7UU+v?=
 =?us-ascii?Q?58uh6PkDBcy3N2ytekDqWid2VvtV017zRSHUWf49S82Bb3CuIePi9WTyuD9m?=
 =?us-ascii?Q?KJBRcT9m7bIR54vLHj7Jx+jvPlmA0I7++SBaVAQ0+IPrd0PoAiaPkaHtU6bq?=
 =?us-ascii?Q?gFB4erUPHSko7zPOryOxEy9o5HsHjU8VD0PppKProjBfDc683lzT25Jey5h0?=
 =?us-ascii?Q?nl9RTPeh0SJbyzkqZ+84iN1F+f2RVl6XQDE7CQCmuy1UTow+dIvrKbSnoT1b?=
 =?us-ascii?Q?M5BOnlQIFlOxnZBulDRguWOTKkX4DCD2eWWWiYqDw74G9trI+DY7TIPFLoo6?=
 =?us-ascii?Q?+RcTQZLzZIkaCA/3FSsp64ZPQiXVXpoMwh5WkRdvnQSZtUbVLDW0lKz+txd6?=
 =?us-ascii?Q?iRD583dNnwcecLPZDYMS/+iB8oi1beQU/jK6/FzNfkv2dQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hg5FBIl6J834HwsQHCYvTNqz29mz1NrFbESwl0V6SLTuAK0yQczxgY9aqAzl?=
 =?us-ascii?Q?rDYZ12O3t7DvgS/W+PMew/lN2+yaOas1CGSYV5Zj3szdLAwwHyZHR62W1OLF?=
 =?us-ascii?Q?d39TfX0QbcSn8sqL1P1zLamYdRq7U5swwfI71WXKbVdKR8RzaW+EXUaYF+zi?=
 =?us-ascii?Q?5ynBM7sgadR9jofU502aio+stA6JHIowuare4pcwQd+AS7leHbGt/Ny8QtXB?=
 =?us-ascii?Q?YUfDL2ELWtFyQBxMa0DtM6HUUOcwDSpSiRzP+EMTYEsxY9gdW+LDk+pZsm8B?=
 =?us-ascii?Q?Zw6B1cr03q5QLRhyKkRqHD3vaU6F1ga3kCYeM4XRF0mbFcor6T5qa/Ofk5Xt?=
 =?us-ascii?Q?t3INDiuWD3IZr190BSdhz5w+TiPbCWwoBSBY+PL9fAZ/1ps+aywiKUvtDmkw?=
 =?us-ascii?Q?0ab09CDu53cVUh4mKXSgtCouzPIrd1rwlDFzLj3aI94pD3fzjI7aw4yvM+yF?=
 =?us-ascii?Q?V9UBfmWDp9F079jYWd7F11LuLDWQTi3FKs0J6UULqbIch5jhTKTmlwpXe8h0?=
 =?us-ascii?Q?BP26H47DXThWYiuDU6ZYwms7v4bMwUo5IdcmmcZbEif/cD7ATJFyjAlIxdWX?=
 =?us-ascii?Q?lBI/IyEg9ij32fBxUfN8tMqdtUNiF18aBl4d+I4Sx4GD2p9o5zBKLOTOl4ke?=
 =?us-ascii?Q?mI4EUTY6NdrVvzGefav5Mc0agGShFKbRQRnTXsLaw/Qrc3OkR8Z/nUyhWPxb?=
 =?us-ascii?Q?rfPu6rrnd/v2EhID3wx0oj4/HK0aU3g+jws5f1PPTywUPOBl6Qh7JCGlqRF2?=
 =?us-ascii?Q?WZU0h925+pMZ1xFj8PFul0EsoPIZJ+QZ7bbEE0ZQLlU3+nxs+AQX7QuzH4Bl?=
 =?us-ascii?Q?tvWvCP48wCE0duOn8waw1g8bOvdLLlqugbeq752+aV+U7SMdjjp/Fn//QI87?=
 =?us-ascii?Q?M5qN3pVY1I41QXBiiznUYCVk4zkAUb6c0qxdf/njoIAqgxkz9jpOQ0swvo4S?=
 =?us-ascii?Q?TxPP650D5DZkKlkSKqFEWhn7RNtcCbGdni6QKoYfMLhI86pUf0NVJ3DawsSu?=
 =?us-ascii?Q?BAFOvZbz477GC8JuGojppCiZeiSfZGhChGuypuMZy5tYEg3zQxrncUNEXhNF?=
 =?us-ascii?Q?zQW5iSZCwU8cl9SGjb4+FBPltsWNX3P3Mcn/1litVLdChtpdqdqpssq9+P6n?=
 =?us-ascii?Q?S1OMCceyyvzDhdb2tRUnc8j6j2MlGUa3e2ygZ9Cu5wWAQe5IvT5+Bs/JJ0Nc?=
 =?us-ascii?Q?dSNW/aCYcX3UzURIH5GiOVyriCKNrH2nJlqMqEmaL1y8kwNgA7JGMAjhI72Y?=
 =?us-ascii?Q?qXjQMwi/cJ80vsY8YWxaje1kjtqk843ekNT3mhk3jRZ8E+Exky7AWkPPjlag?=
 =?us-ascii?Q?RoSsDiDNp6kxd+KD/gUr4eZNoKUksh6jeWBxbl9YL3h35VGEJC8L9RjgkYCa?=
 =?us-ascii?Q?WIHJLPI1Sxyj93Rfyfwn40tYNs7kWZPjsegY36ZndIBOrrbrmuyjelBuck+H?=
 =?us-ascii?Q?1I78mD1OEp7kVjmkTueTrFsR/Q5EH6p+YG2y1w07hwhMh/60u/Gg10AjsX4m?=
 =?us-ascii?Q?0zN8bUlNnGYsqOxhAcRcVxaPxOX1EWoufQOo9QWljVfMLbcED/xw2fK9H26/?=
 =?us-ascii?Q?Hi2/+CsgXY/Am8R/BN5bsPD/rbCQJysLPW9FGaWN4KXomE9N6rBlD2TIq19w?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce448c1-8c20-4644-74dd-08dc9ce3ccd2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:15:38.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7hXh5Tu9fhHWBXV5ku6/9jrBQMb0DZRtbL3aoxMkyZg1u9MZGKF3b7Y/MHn6fRGvcrFEOYpTCYlD+W7XeCs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 11:15:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16394

On 05.07.24 09:11, Shivanand Kunijadar wrote:
> From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/boards/README.m-com-x86.md | 112 +++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 doc/boards/README.m-com-x86.md
>=20
> diff --git a/doc/boards/README.m-com-x86.md b/doc/boards/README.m-com-x86=
.md
> new file mode 100644
> index 0000000..a72dd09
> --- /dev/null
> +++ b/doc/boards/README.m-com-x86.md
> @@ -0,0 +1,112 @@
> +# ISAR CIP Core: Instructions for M-COM RT X86 V1
> +
> +## Build the CIP Core image
> +
> +Set up `kas-container` as described in the [top-level README](../../READ=
ME.md).
> +Then build the image:
> +
> +```
> +$ ./kas-container build kas-cip.yml:kas/board/x86-uefi.yml:kas/opt/6.1.y=
ml:kas/opt/bookworm.yml
> +```
> +
> +After the build is finished, insert a USB stick and flash the image.=20
> +
> +
> +**Note:** please make sure to diable watchdog by setting timeout as "0" =
for SWUpdate and Secure Boot images.

disable

But this section is redundant to the description below.

> +
> +## Software Update and verification
> +
> +Build the Software update enabled image,
> +```
> +host$ ./kas-container menu
> +```
> +Select below things,
> +
> +* Generic x86 machine booting via UEFI
> +* Kernel 6.1.x-cip
> +* Bookworm (12)
> +* Security extensions
> +* Set EFI Boot Guard watchdog timeout in seconds to "0"
> +* Click on Build to build the image
> +
> +Copy the .swu file generated from the above build to temporary folder, w=
hich will be used for swupdate.
> +
> +Create second image(RT Kernel image) by selecting all the options mentio=
ned above and additionally select RT Kernel option.
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
> +Build the Secure Boot enable image,
> +```
> +host$ ./kas-container menu
> +```
> +Select below things,
> +* Generic x86 machine booting via UEFI
> +* Kernel 6.1.x-cip
> +* Bookworm (12)
> +* Security extensions --> select Secure boot support
> +* Set EFI Boot Guard watchdog timeout in seconds to "0"
> +* Click on Build to build the image
> +

This described the build for the third time, no?

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

Jan

--=20
Siemens AG, Technology
Linux Expert Center


