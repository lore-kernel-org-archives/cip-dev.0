Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B421CA5FED
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 09:51:43 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41795.1791280302136076076
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2026 02:51:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=l9QspY6C;
 spf=pass (domain: siemens.com, ip: 52.101.72.46, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ixb2XtovHT+FjFwT2KavNFMEPsybMoTLDsoXAMPKRtY5a9kY25KCTNXkontA7NrBC4MOFylBm6TOk6yHGP/8fr1F05zD4FqR3oDi9fqrhe0h1KuV+Q2VYq7oZgKPs13tgOtgZbw+cM06oIkd9sr84sU3MGOUKFNNabvaEoLVG+ilJCTo89CqdDxn1ZK9xDtJQh8rh/h9UP1N2CcBerszEROpfXeo2jxRDy8FAi0JVV6FWx2GuBDQPjg21h03hQBpOMWYEhpi35Lcl3Pj44Tls2Dt08Am0x7La/aRE6MDexcdsUgaiPSRO9doFfrvN6oCi3HFTDL69MnvQcERa+rSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Esp0iCyrn5aSrD5TkMbPWr1sjzVKd3r0C/7In5iAs=;
 b=POfWnpe+Y9cXf2iHvcU38B5npdeiYpiavdmIms0cT2Lrg+z6rgabFmYL/57dZQ3oC92KtxvObFLdb8G4TbEAjYjlTtoitzE473+lO+t5JISJvifglz6VoThN2CCgSLiPYLzh2KZYlDB+8DLYlfQzfF/P3tw7NJdZ8uMYynvzxpnIvXmrrFxXOOp5feHpShIcVmNy7xOS0pHMvc20Vt1QNVDPTKHmjnFfNPTnwOeFAdpipmLMxU4pRyLMo9T1YjGcEXmYD4iqV1lLXcRNskstxSuwUIS9k0DzRRQXM2z6dOccXGIW/0w+5Hat94UdkVNIDQWq27AoHFh66S3U1B4d9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9Esp0iCyrn5aSrD5TkMbPWr1sjzVKd3r0C/7In5iAs=;
 b=l9QspY6CHiTPSOgrVG7HxJryw7DMJdMEkiBuTxtvcNafwWpDnsTl3AG5JK71XtfKHO0aZ41j2XO2NGvYHue86+YDm37bHwCQDLqJvMEZcDKhlMk06SbNj8pzzLNjMqARHOUyUqFN9ICZ3mRWjWQEFSq8tK++KBKtVpiO4Tlrl8qBMxzDn7gq6stZTb4KGy/JleIH/7HW/5Lxy3k3jnUjxPTnm4LQ6J4cSK6ZVZEyBWC2q0iyCeuhxM7th+RVQEsgaMaiCPv3q36fyk60jJvch1KEs8x09kTH1u5YFSZ9NZi8UGnPoEvywnbfAI2CLgbdmiaNnxEasiZJjehf86I9IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB7641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:636::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:51:37 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:51:37 +0000
Message-ID: <956fd945-0bf8-412c-bd6e-52546d446871@siemens.com>
Date: Tue, 6 Oct 2026 11:51:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 08/11] cip-core-initramfs-dracut: add dracut
 initramfs
To: "Moessbauer, Felix (FT RPD CPC OES-DE)" <felix.moessbauer@siemens.com>,
 "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
 <20261002111938.3600786-9-quirin.gylstorff@siemens.com>
 <406608c4c1988ae22f0f1a5561a80b3d588da250.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <406608c4c1988ae22f0f1a5561a80b3d588da250.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c54670-2fac-4a64-5a47-08df238f69fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|55112099003|22082099003|4143699003|6133799003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	HAgWmi7gWOCClOzGvlVDP6MznOns5ylLA4zVHr7A5mqi4cN2llpbNysxkm5jR2TdMs6jPpKeLKtrUIzEnc6ddmA88pX6bDR8XQEDEqZNhb92MpABtUS4pQuYkLWUPc4yiCd6z2ycrzrgrto1Mz6DuU2bFs+WuC3kK+AibHVk6Kr7C5txQacINVxAXwtSSMHDt6iGqzI+jahOpm3RvBegYUVkYiXfkuI0PpRREmY7MzZUFUo/f6BXQ0n+KBogeV140+LNlLygOtz+BvuTyi/7RiQhWtEQjgAmVAO+Wnuh7cYmo+n5CpLZEDhBZ7neSloXJ6nRsgMDXsFTzAF1dQGTHFOcf8HcxZhZrPG3b3rZFVJgGfAcrS0z6dwwVhyvJVdF/C9dks3zP88VRHv2UAajWlW5lvxTWRhAFK2D2u1z6xpGdCIKfJdIIScvRkgMDQy5teMZAeIKEX8zrlGaq4ZCmZoxku4ENqgHb4tFlin1DUpOksWx//JgpjkWaZkppCy1H5VpA/kDLvJmll8SP2HriOaS2aBt4cAU0LvJnVblfpBxka7MxgG6sH9Gg7ZAyg8gAJU175jWU7QzGxxOO6aEGxSay/OXWmr31q/QHOPMDCZhXQ7eIgUYIENmwk0VN3IAcScvZFH1d2IK3Pab6zkuAWZMJQ179uJQRJ5F+RBzWwQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(22082099003)(4143699003)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4zgrOD/cqfznfZ6IEc4xYPEK8e1jaxTpK6b765xcjlXqe1Swj9O7AEXqlnsI?=
 =?us-ascii?Q?T5FpbwH9OGXw4WDsQcerBhyBp2Fjs8V/sH8zUnAsVdrDUOldqI8LRIb8u2jQ?=
 =?us-ascii?Q?DjYZTAegXM7Ho/IrpB6VSMWTYwQfWgyb+X/P5yvmzn50Wr5cIw/7D9q3Fr6q?=
 =?us-ascii?Q?hXn7PuQnDq+YMWo7a5yqclk/1d9IPe1e0yetcm7TwRYuwfPIWDV1td7I1cNx?=
 =?us-ascii?Q?RwW3hlYqi3vN1uuVZQ2YFAhv49sRMWpe0WUj5DuJGZqfio6gQVlZe3oe+uKT?=
 =?us-ascii?Q?E7js7BEGUKf2Ta6kCIkMQNh1g+hkAdp4/4M2o9OyhEbNpSeZDsID5zDvAEtV?=
 =?us-ascii?Q?38Sc8zSOvvkO5XKKMmCLm9OMSzVLpeAEL9Wx6cck2KtS7p9i9bURDXuw2n81?=
 =?us-ascii?Q?vzkS3/lpaCgihJ5Po/L1k+xAZzEcnsxWp1qUNnHfBVZ+CgtPVmDFoFKzoZOM?=
 =?us-ascii?Q?GFtn9m8fj8c5aZ0JtE3SoOZ6S1vN2h1lXFeHUXtiwNDY5bv9VC4spcc8UOcG?=
 =?us-ascii?Q?oO2OGby7NbVsbtfYKotEdBWSs4dPyidoneXDHb/x0D+uHT5tzaohvJkExYId?=
 =?us-ascii?Q?MY1f79qp89JeCT9qqjA+IMAVykDE53FFG5O4SBuyBNnO5K0ZMDZa+tboAd/Z?=
 =?us-ascii?Q?ucEnYOo230oqIC4+P3DhBtZ0BqqvQRSotJFBbzcxdVE/O+tDHhBWt/ISFR58?=
 =?us-ascii?Q?7BiAnU4R6vgxsJ4b7yPxhH4Ckinfeexw0D1zALXvfe3UwI45diM/+tknEBdV?=
 =?us-ascii?Q?wYbr8lHTViFqMIzpiEVOkys7lu0bmLlvgUJx0mciVfi+dYwGaL/whFBoiZ9p?=
 =?us-ascii?Q?0jFXilJQTob1FQ9LyRMH16Saxzuq1shZyCVaZ2dzcDrhvveYH4G8dmchxLXJ?=
 =?us-ascii?Q?I0Fdptwr3R2LXB1p0JHxRxuCbF5rQo5jFAj0Y+GcsI7MVzL8NP7er9iEO0l8?=
 =?us-ascii?Q?m64CfSoe3qNt1kkvL4AdwKwc3sKoKMY0yV7p3AQQu3z4OCWXbe/LhLQVApx9?=
 =?us-ascii?Q?BXZRmIvFgZtjVKL5Or6KeI77kyB0Ach5SqENjFAiFCh0C+iL7DbIlbPo8cb4?=
 =?us-ascii?Q?5qCM8iZtXkHyvaVnDcIkhKXU92pLqvZ2To0hg+3CNSAkHWMOx+3dKiUtvmtj?=
 =?us-ascii?Q?RDUFWqog72UyiEZqjFTwxgXJHK1Qk6b8gWaurKLGCykfGn2LAqoD+FniG2WF?=
 =?us-ascii?Q?npFdPkGpSF1D3RB80ScN5I7ZIBTwpdYXs4olpA2V15UQNHdqPsAfAIMbUCl0?=
 =?us-ascii?Q?1aONhTzTDyKsv/TAa9tQY5fCcNBAmTNo2t1DDYLgklyR0mTv7frpY8Kn7cDC?=
 =?us-ascii?Q?vOezLpUs8Pxyvw3QVuLdKO284/IMWrwPHYCU1oISV/x/B8kTM940/FdPZPTb?=
 =?us-ascii?Q?qJBoSuAtjBqiIm1xUZQGLBLejBm4sgrx8wRDUD9IPxRvkfmwoRiYC9TCCSLu?=
 =?us-ascii?Q?9OdnIrY0oNOiON6eIG2ZqQkMcq9hTi8KdBTSf3X7CwHMUBdiI+bLzxrlN5e1?=
 =?us-ascii?Q?ba9JhKoWubzmJSg3oGX/xlA86zSh7ekp+jHnAptVnkCoixQu77wZ6remqnGh?=
 =?us-ascii?Q?RFnKSE9zu09Tu7VONtiPo5QBC1eCehj82PQTg/mndHbWOg6hq2ZOuCJaSVcb?=
 =?us-ascii?Q?bfjtEgR/Wtj+MlllpKfvdYR3sIZu/ekavzNWepjPDXxHwnWX0f6h4yKQVZK9?=
 =?us-ascii?Q?KzMg/rmfjdFKP1fCcKDwFQHWArMvAaF+xF5fMI/1cgRSaaU0VIyDKeJD2Q8S?=
 =?us-ascii?Q?xSox+wq0rmHREWTCSDZqroCuCuBtgAU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c54670-2fac-4a64-5a47-08df238f69fd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:51:37.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3I07Z5b04X1QO9de+wFvv0V+FCsEw7G1u67oHhvtfvPacIL5ffM7/OQiay3gEx5pKUMXJK9CYJCfAI4u7adnHcOuaJzfKQXbiRMPEitxak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7641
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Oct 2026 09:51:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24433



On 10/2/26 5:15 PM, Moessbauer, Felix (FT RPD CPC OES-DE) wrote:
> On Fri, 2026-10-02 at 13:18 +0200, Quirin Gylstorff wrote:
>> Generates the initrd with dracut (--no-hostonly) on trixie. The overlay
>> module is always included; verity, crypt and factory-reset follow the
>> swupdate, encrypt-partitions and factory-reset overrides.
>>
>> kas/opt/dracut.yml selects the recipe and the dracut kernel command
>> line style.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0conf/distro/cip-core-common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>  =C2=A0kas/opt/dracut.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 ++++++++
>>  =C2=A0.../cip-core-initramfs-dracut.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++++++++++++++++
>>  =C2=A03 files changed, 61 insertions(+)
>>  =C2=A0create mode 100644 kas/opt/dracut.yml
>>  =C2=A0create mode 100644 recipes-initramfs/cip-core-initramfs-dracut/ci=
p-core-initramfs-dracut.bb
>>
>> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-comm=
on.inc
>> index dbd65e3f..bbcea1da 100644
>> --- a/conf/distro/cip-core-common.inc
>> +++ b/conf/distro/cip-core-common.inc
>> @@ -32,6 +32,9 @@ TEE_SUPPLICANT_IN_USERLAND ?=3D "0"
>>  =C2=A0PREFERRED_PROVIDER_factory-reset-helper ?=3D "factory-reset-helpe=
r-file"
>>  =C2=A0PREFERRED_PROVIDER_factory-reset-helper:ftpm-stmm =3D "factory-re=
set-helper-efi"
>>  =20
>> +# The dracut initramfs requires a verity rootfs and the systemd cmdline=
 style.
>> +INITRD_CMDLINE_STYLE ?=3D "${@'systemd' if d.getVar('INITRAMFS_RECIPE')=
 =3D=3D 'cip-core-initramfs-dracut' else 'cip-initramfs'}"
>> +RO_ROOTFS_VERITY ?=3D "${@'1' if d.getVar('INITRAMFS_RECIPE') =3D=3D 'c=
ip-core-initramfs-dracut' else '0'}"
>>  =C2=A0OVERRIDES .=3D "${@':ro-rootfs-verity' if bb.utils.to_boolean(d.g=
etVar('RO_ROOTFS_VERITY')) else ''}"
>>  =20
>>  =C2=A0# Watchdog to service by initramfs hooks during lengthy operation=
s like
>> diff --git a/kas/opt/dracut.yml b/kas/opt/dracut.yml
>> new file mode 100644
>> index 00000000..969388cf
>> --- /dev/null
>> +++ b/kas/opt/dracut.yml
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +=C2=A0 version: 14
>> +
>> +local_conf_header:
>> +=C2=A0 dracut-initrd: |
>> +=C2=A0=C2=A0=C2=A0 INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"
>> diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initra=
mfs-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initra=
mfs-dracut.bb
>> new file mode 100644
>> index 00000000..8541574e
>> --- /dev/null
>> +++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dra=
cut.bb
>> @@ -0,0 +1,41 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit initramfs
>> +
>> +DESCRIPTION =3D "dracut-generated initramfs for cip-core"
>> +
>> +INITRAMFS_USE_DRACUT =3D "1"
>> +# dracut-config-* packages are skipped by module-name extraction, so th=
e
>> +# modules they pull in are listed explicitly.
>> +INITRAMFS_INSTALL +=3D "dracut-config-cip-overlay \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dracut-config-cip=
-verity \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dracut-config-cip=
-watchdog"
>> +DRACUT_EXTRA_MODULES +=3D "cip-overlay cip-verity cip-watchdog"
>> +
>> +INITRAMFS_INSTALL:append:encrypt-partitions =3D " dracut-config-cip-cry=
pt"
>> +DRACUT_EXTRA_MODULES:append:encrypt-partitions =3D " cip-crypt"
>> +
>> +INITRAMFS_INSTALL:append:factory-reset =3D " dracut-config-cip-factory-=
reset"
>> +DRACUT_EXTRA_MODULES:append:factory-reset =3D " cip-factory-reset"
>> +
>> +# buster, bullseye and bookworm lack the dracut features needed here
>> +python () {
>> +=C2=A0=C2=A0=C2=A0 overrides =3D (d.getVar('OVERRIDES') or '').split(':=
')
>> +=C2=A0=C2=A0=C2=A0 if any(s in overrides for s in ('buster', 'bullseye'=
, 'bookworm')):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise bb.parse.SkipRecipe(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cip=
-core-initramfs-dracut is only supported on trixie and later; "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "use=
 initramfs-tools on other distributions.")
>> +}
>> +
>> +RO_ROOTFS_TYPE ??=3D "squashfs"
>> +DRACUT_EXTRA_DRIVERS +=3D "${RO_ROOTFS_TYPE}"
>> +
>> +ROOTFS_INITRAMFS_GENERATOR_CMDLINE:append =3D " --no-hostonly --no-host=
only-cmdline --reproducible"
>=20
> The --reproducible flag is provided by isar. The others are just the
> default if I read the dracut manpage correctly. In this case, the whole
> line can be dropped.
>=20
> Anyways, the --no-hostonly and --no-hostonly-cmdline parts should be
> moved to isar if needed, as isar also provides the dracut-cross
> support.

I am not sure about moving them to isar - there could be usecases for=20
build host specific initrd.

Quirin

>=20
> Felix
>=20
>> --
>> 2.55.0


