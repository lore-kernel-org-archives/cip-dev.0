Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11349C54E66
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 17:19:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web10.1684.1710350369839429433
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 10:19:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=OiuUm4QZ;
 spf=pass (domain: siemens.com, ip: 40.107.20.74, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnIOA4LVKvWMPkima1wGxqqHtJT6k0QQ4aB6MF5CAXkCu01XVEHg+WZpc4bLVonox8qy3jm98RU/wqs7OIl8LqxAMbui80bYIWP7kJExTjgXW5CW4SnxMxSGy4j2DyNs8ZfaRlrCOzjYn3HsYttopQ81wnVkXP0htoMGbK48fFzoHwqtu/UoxuanuJei60PHSHQOhg0cflYTN96Mkh/gMPy7iDdtR7V1wxutZLKRA/klqnNUEJdvnFltc5bkWZQrKuBQgKt7w7H6QXWnXs3ZUYyNAb3GqgvgvS8cE0EKfvRlCUTQNxCYg+W1CncsDtrbxMZ7XtBZKu+ii97s/w/bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB8LetGbmkY7GfUU5C7w6HRXuNnv+HQpkHcLzyHlqxQ=;
 b=nouP5Fc7xr95snOc10l8oo7gjpP6Sds6NfnbakVuJUM0U0O0gtbRQIhxY6F8hImnyupMlLg4/TW8XmzQjzh77wUmoQz68iqd8ndDIpfF4wp2YeUgS7j06pm22GJNQOMPGYt6wUdaKZukQWgSZPoLz0MwAwyTB6iF5UFrrIgRw9uyi1bP7s6ktMDe7Ml+5Rhop6U5/eCv5xjw23ALMjtB0hLCMVQ3k/1vqD+MbBTiW9M41T08Agin/Vs851PGAs3ty0Ez1X7TOpua21t+yxyaGfIbyb/bwaOK8AT4GdIDkT6Y6Eo3xjcX44KYlTchqzfRaAUnfpqkTDKcX1fHIWmiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB8LetGbmkY7GfUU5C7w6HRXuNnv+HQpkHcLzyHlqxQ=;
 b=OiuUm4QZDX3Aso3xmDJ+d0kuW1jPUwA6+vHEto3y07BI/m0h0D0LdMjufjo0+sK3g1yGQUPDs8EEuN/bBTuHIVF0ZHkQRFfSZjzH7L1hHMGDLdsxYGaiTEhknmzap/tlVvTVnIL9sXAd319O1FnF2GYalZQtMnZhgwoda03wfe6RH8W3pWDH2nJLcs4UqWoTwChXe7qDSq85tTm3C8kFiCqV3yGWNlS5GLTeCjFS+ODoH1fb3iFaO2b3To52RDWqNRSPPi4R+ev+M0ag2zvvsd2gzrTU5KwqQTbw0AAaE+R4OYbq3dHoVqaWhqo0OpdXAJwsUXVosc31GHK2S59K9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB4PR10MB6070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 17:19:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 17:19:26 +0000
Message-ID: <bfc4ba9a-d473-47e9-93d7-1fc3937215ec@siemens.com>
Date: Wed, 13 Mar 2024 18:19:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with
 rdiff_image and delta handler
Content-Language: en-US, de-DE
To: Adithya.Balakumar@toshiba-tsip.com, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
 <0876d8dd533161214f2010cdbcd65d5084a1ddd3.camel@siemens.com>
 <TYCPR01MB966940F5431AB8457BD3204AC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB966940F5431AB8457BD3204AC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB4PR10MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: c058c766-6bfc-47bc-15c1-08dc4381bc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uAO29csMTzzFtetdSpIIKfNdGTySOtOSraE0oFKjz78i8pPxjsX6dJKehdMFUDeRwBFGLlIElgKcivmu2UEkAeot0VJODV9wMaS7IMNJ3479tbe9ktMKBOeTmPp3vRCYJ6IP/10LauiA+nRkQYQT34OLf0gi1D3GmV6nd1kXUVyZaN1LjF40aC3Euc5gyXYVoJ8YSc2601vvV21aJc0KZXCrG9L4CzkY49AstMHCxbKB94YBvroIH6Ol4v+AnH0uEqXnsfJb66dIA8+7Eu0fZdaqetIFIniLUsBuAOuC6LoiykTJoxZUxhT9DrFOVAOY0IodIT0C6eRXgLCl4+JA7RtzuUptGFYSXNv3qykbQsK/UTzEGjrTuepqkFXt+7FjTa1qMPr7JL3CmI+w8EbykGcVJqGQuq5FQ9btJfVE6azzxKnhDHtnA3vVN5E4WPARoR9V/JgUTNB7S7CRduoZ6/A+7tmcNXFTPcaWkkXyJOfFI4EBwp9Tu1SqqWhjOv6rEnQRuJESyDeCqlsXWV5siTp4Fr0MI8e5PIIWvyh/fQQfeNJFJAfgvJdWzhtsk9CTgjPuHGpM6iGp7foqXjHYxNP+TYVkAkg7CqmOyxdNvwvQEK3MhCgE46mYsRToOSEJuhqbMCXlQ54gUp9Cr95zfQykcn++ad91PnR1kSnu15g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WF9INsS1GZ4Yu1+RUwLFciW0DIWbIdCF/KgDFqt5bGhGLtzVAkDEUavJRy9z?=
 =?us-ascii?Q?Wd6AZpEC5/BHDrfyOVOlbvTvxe3DTlFTcHSDHyZNUw5WP7OSVeCZPtC4rhR0?=
 =?us-ascii?Q?pgIF1ytRxd2iJdwawxI38+Oo1jQfZYLbn1gx0XjxcSLqnHE7tQ2xNw1T7ci9?=
 =?us-ascii?Q?rRgaUNp3Hb8zAZFlNfowAYgNRgVh9ZOh8490lxRHtA1o8HUEY28FwDJoSypX?=
 =?us-ascii?Q?1EayscIwnUQnHW0upRfKgFxACemSAZMtglg4IDV+9IIwCfJz516dH1StsZU8?=
 =?us-ascii?Q?htzbCpMdNFJQcMCBjYtv1FdX2CClIvibuh0UHsvG5M3z5bJE7JZrhSBnZpxp?=
 =?us-ascii?Q?Dcdj4AGqS/f/GHal6HNmRHVki2K947nIi6epkalMeoRoTLQ7f67CtfmC5h6Z?=
 =?us-ascii?Q?tVbjLpZl1rRZ8j6W92/L1yNhSGQsQN9FAfGEi8wNZFTHfNIwrBjDK9IH+rSy?=
 =?us-ascii?Q?7ZWRESigWp9Z/TTTq5pxX66LOcJYfjvtIruTBhxp7FkW1R0/Ow6Og4Vamdc6?=
 =?us-ascii?Q?wyk+v/X70644z1ISFKrwSaCZK2NCpjMtHzRX+cRbVmWmWBhD4FIsKyPeXoip?=
 =?us-ascii?Q?/6rS1DLBBeR7UCl75EG+4e1/FAt/G0TsZLA3sPpGcdZkPbuRJ+R1UAsBWd5H?=
 =?us-ascii?Q?Au7p8nwUmW7xf5dquXR1x+ncrQEFTzs2vFS4gloVow8xNIj5EGAmLAshVjfG?=
 =?us-ascii?Q?BhKHdun/ch7lruuxuP9ajbyJ/z6l79dgKCr+pH0zJc//epJW24b9grsJwn+j?=
 =?us-ascii?Q?fsHywP/Rs6R44PEGwU92vnjgVD0a53o/CX52pEmTthCf2L/b8Fce+SpMzWWi?=
 =?us-ascii?Q?ApLj76qrJ48df3jy4xlaoSpfSQMRXG7/jUkOHwSoZf2KAYi+x0DqXmzdjVr5?=
 =?us-ascii?Q?TWu8mJZ3aENkA46K/RIKW9EGdNtG90TrltGyXDVvG4092gceFa/whiuOccyM?=
 =?us-ascii?Q?cEtZVh06KlmwZfadQFCfzF2bKEPuzyUzeH7FNlR2CmPjU3OKHP6eXzv3Orb+?=
 =?us-ascii?Q?5vOUzksKsrR/RFMnAQbYvPo72GSiqHrShx+y5WoshLhBs4est/xpevt4NPjS?=
 =?us-ascii?Q?fj+9IpMfXpzV0C7b2ohH/9wbPaD2xAL1Kj5iwCOmOIhuXAhX4w3CazGPJsEf?=
 =?us-ascii?Q?vWVIO5QjV2pQIN6ndckX5oyIdMLr03fKTMaI/z/RUSQiklyVw1KJ8ajmnssA?=
 =?us-ascii?Q?txHYfSH74gKOabfxGjN9I9YX+/IlrNxTYwQvp+LFfjPHeyb5zJeGjUnnv245?=
 =?us-ascii?Q?+wc9eD8SgSGBpK1ciuNdMnom3f2ZmS5R7H1Gdp3Xdu+Y0nLfBCIz1849gPKH?=
 =?us-ascii?Q?uJgsoYpHZH8diDtC6UbHkeTeRvrHed92fqMDTd7NwCGhmcWpOxRsVP6tn5Jp?=
 =?us-ascii?Q?oy/w7yupUrw6nXgOjiENSGH+NYuupbBYnDvLE3tHYaf2LnqXgL++VJ6bLVrs?=
 =?us-ascii?Q?Fp3wRfD8adLFRr0ve4UOY8hFTbVJEgxrmWsQgdN8rLRQma8CIjuJIvYiJbRh?=
 =?us-ascii?Q?nmjXXn7+tT9T9a8z8cGle2875tQQaAefRrRua52ON/xgGQb775Mz+3Dx5O/A?=
 =?us-ascii?Q?8Kes7mn0QIBoQsDcwNER43qQm2AW7pD5J/SbgH+D1yhC86d378wSIjqzjCOY?=
 =?us-ascii?Q?t4GVZteEgiUZftfQdMkNb2I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c058c766-6bfc-47bc-15c1-08dc4381bc2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:19:26.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtO6C87IrbdDwCtF/6ys81H9/ElkshRhuGvSssZrpJa8H+qQVd1C78UsYz1Qb1K2w5F2Hj5tSAmkmTcC/eACF2VR6faOunzR0DjxFTK6UcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 17:19:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15293



On 3/13/24 7:11 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
> Sent: Friday, March 8, 2024 4:22 PM
> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR) <Adithya.Balakumar@toshiba-tsip.com>; quirin.gylst=
orff@siemens.com; Kiszka, Jan <jan.kiszka@siemens.com>
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with rd=
iff_image and delta handler
>=20
> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>> swupdate supports delta updates with rdiff_image and delta(zchunk)
>> handler. This change adds support to use either of the handler for
>> creating delta update artifacts. The type of handler can be set in the
>> delta-update.yml file along with additional variables needed for the
>> chosen handler.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  =C2=A0classes/delta_update.bbclass | 90
>=20
>> Hi,
>=20
>> please name this class delta-update.bbclass to keep the naming style sim=
ilar with the rest of the project.
>=20
>> ++++++++++++++++++++++++++++++++++++
>>  =C2=A0kas/opt/delta-update.yml=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++
>>  =C2=A02 files changed, 111 insertions(+)
>>  =C2=A0create mode 100644 classes/delta_update.bbclass
>>  =C2=A0create mode 100644 kas/opt/delta-update.yml
>>
>> diff --git a/classes/delta_update.bbclass
>> b/classes/delta_update.bbclass new file mode 100644 index
>> 0000000..8d47081
>> --- /dev/null
>> +++ b/classes/delta_update.bbclass
>> @@ -0,0 +1,90 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>> +#=C2=A0 Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +IMAGER_INSTALL:delta_update +=3D "fdisk zchunk rdiff"
>=20
>> Conditionally appending with +=3D overwrites already set weak defaults.
>> You might want to use .=3D " fdisk zchunk rdiff" instead.
>=20
>> +
>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>> +IMAGE_SRC_URI:delta_update +=3D " ${@ "
>=20
>> Same here.
>=20
>> file://"+d.getVar('DELTA_RDIFF_REF_IMAGE')=C2=A0if
>=20
>> I guess this could be simplified and made more portable by referencing t=
he DELTA_RDIFF_REF_IMAGE directly (e.g. from ${DEPLOY_DIR_IMAGE}). The prob=
lem with the FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip->core}" is that it=
 only works if the delta image is also from cip-core, but usually cip-core =
is just referenced in a downstream layer and used there.
>=20
> [Adithya Balakumar]
> Hi Felix,
>=20
> I understand the drawback of using FILESEXTRAPATHS:append =3D ":${LAYERDI=
R_cip-core}" that it only looks for the delta image placed in the isar-cip-=
core layer.
> As an example you point to referencing the DELTA_RDIFF_REF_IMAGE directly=
 from ${DEPLOY_DIR_IMAGE} but as per my understanding ${DEPLOY_DIR_IMAGE} p=
oints to the current build's image deploy directory.
>=20
> So, Could you please suggest a suitable way to provide the delta image in=
 the case of rdiff.
>=20
>> d.getVar('DELTA_UPDATE_TYPE') =3D=3D 'rdiff' and
>> d.getVar('DELTA_RDIFF_REF_IMAGE') else '' }"
>> +
>> +do_image_delta_update[cleandirs] +=3D
>> "${WORKDIR}/delta_interim_artifacts"
>> +
>> +extract_root_fs() {
>> +=C2=A0=C2=A0=C2=A0 INPUT_ARTIFACT=3D$1
>> +=C2=A0=C2=A0=C2=A0 OUTPUT_ARTIFACT=3D$2
>> +=C2=A0=C2=A0=C2=A0 SECTOR_SIZE=3D512
>> +=C2=A0=C2=A0=C2=A0 ROOTFS_LABEL=3D"primary"
>> +=C2=A0=C2=A0=C2=A0 ROOTFS_START_SECTOR=3D$(${SUDO_CHROOT} /sbin/fdisk -=
l -o
>=20
>> Can't we simply use sfdisk to query this information instead of all the =
awk stuff?
>=20
>> Name,Start "${INPUT_ARTIFACT}" | awk -v name=3D"${ROOTFS_LABEL}" '$0 ~
>> name {print $2}' | head -n 1)
>> +=C2=A0=C2=A0=C2=A0 SKIP_VALUE=3D"$(expr $(expr $ROOTFS_START_SECTOR \* =
$SECTOR_SIZE)
>> / $(expr 1024 \* 1024))"
>> +=C2=A0=C2=A0=C2=A0 ${SUDO_CHROOT} /bin/dd if=3D${INPUT_ARTIFACT} bs=3D1=
M
>> skip=3D$SKIP_VALUE count=3D1024 of=3D${OUTPUT_ARTIFACT} status=3Dnone
>> +}
>=20
>> Why copy exactly 1GB?
>=20
>> Instead of extracting that here, it might be simpler to just store the .=
rdiff file (of the rootfs) with each image build and use that.[Adithya Bala=
kumar]
>=20
> [Adithya Balakumar]  Here, I am copying 1GB from the wic image because th=
at is the size of the rootfs partition.
>=20
> However, Quirin left a remark stating that the .squashfs file (or .verity=
 file) could be used to create the delta artifact. Using the squashfs or ve=
rity file to create the delta will eliminate need for extracting the rootfs=
 from the wic image and will simplify many things in this recipe. Would lik=
e to understand your opinion on this.

Also you can use the `WIC_DEPLOY_PARTITIONS =3D "1"` to generate the=20
seperate wic partitions. That is much more robust then some
dd magic.

Quirin
>=20
> Thanks and Regards,
> Adithya
>=20
>> +
>> +do_delta_update_sw_description_template() {
>> +=C2=A0=C2=A0 # Since the sw-description file for delta update would not=
 be
>> very different from that of a
>> +=C2=A0=C2=A0 # normal update, copy sw-description.tmpl as sw-descriptio=
n-
>> delta.tmpl and add delta update
>> +=C2=A0=C2=A0 # specific properties
>> +=C2=A0=C2=A0 SWU_DESCRIPTION_DELTA_UPDATE=3D"sw-description-delta"
>> +=C2=A0=C2=A0 cp "${WORKDIR}/${SWU_DESCRIPTION_FILE}".tmpl
>> "${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}".tmpl
>> +=C2=A0=C2=A0 sed -i 's/\SWU_ROOTFS_PARTITION_NAME/SWU_DELTA_UPDATE_ARTI=
FACT/g'
>> ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
>> +=C2=A0=C2=A0 sed -i '/configfilecheck =3D/a \
>> \'$'{SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES}'
>> ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
>> +}
>=20
>> @Quirin: IIRC you recently refactored the creation of the sw- descriptio=
n file. This might simplify things here.
>=20
>> +addtask do_delta_update_sw_description_template before
>> do_transform_template after do_generate_image_uuid
>> +
>> +IMAGE_CMD:delta_update() {
>> +=C2=A0=C2=A0=C2=A0 if [ "${DELTA_UPDATE_TYPE}" !=3D "zchunk" ] && [
>> "${DELTA_UPDATE_TYPE}" !=3D "rdiff" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbfatal "You must set a vali=
d DELTA_UPDATE_TYPE
>> (rdiff/zchunk)"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0 DELTA_ARTIFACT_SWU=3D""
>> +
>> +=C2=A0=C2=A0=C2=A0 if [ "${DELTA_UPDATE_TYPE}" =3D "zchunk" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0extract_root_fs "${PP_DEPLOY}=
/${IMAGE_FULLNAME}.wic"
>> "${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Create .zck file
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${SUDO_CHROOT} /bin/zck \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0-u --chunk-hash-type sha256 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.
>> raw
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Calculate size of zck heade=
r
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HSIZE=3D"$(${SUDO_CHROOT} /bi=
n/zck_read_header -v
>> ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':'
>> -f 2)"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Extract the zck header
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${SUDO_CHROOT} /bin/dd
>> if=3D"${PP_DEPLOY}/${IMAGE_FULLNAME}".zck
>> of=3D"${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=3D1 count=3D"$HSIZE"
>> status=3Dnone
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DELTA_ARTIFACT_SWU=3D${IMAGE=
_FULLNAME}.zck.header
>> +
>> +=C2=A0=C2=A0=C2=A0 elif [ "${DELTA_UPDATE_TYPE}" =3D "rdiff" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_RDIFF_REF_I=
MAGE}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbfa=
tal "You must set DELTA_RDIFF_REF_IMAGE and provide
>> the required files as artifacts to this recipe"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Extracting root partition f=
rom image1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0extract_root_fs "${WORKDIR}/$=
{DELTA_RDIFF_REF_IMAGE}"
>> "${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw"
>=20
>> We only need that to compute the rdiff signature, right?
>> As these images might be quite big, better remove the old one before
>> extracting the new one. By that we save ~half of temporary space.
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Extracting root partition f=
rom image2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0extract_root_fs "${PP_DEPLOY}=
/${IMAGE_FULLNAME}.wic"
>> "${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f ${DEPLOY_DIR_IMAGE}/${I=
MAGE_FULLNAME}.delta
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# create signature file with =
rdiff
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${SUDO_CHROOT} /usr/bin/rdiff=
 signature
>> ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.raw \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0${WORKDIR}/delta_interim_artifacts/old-image-
>> rootfs.sig
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create delta file with the=
 signature file
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0${SUDO_CHROOT} /usr/bin/rdiff=
 delta
>> ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0${WORKDIR}/delta_interim_artifacts/new-image-
>> rootfs.raw ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DELTA_ARTIFACT_SWU=3D${IMAGE_=
FULLNAME}.delta
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create a symbolic link as =
IMAGE_CMD expects a
>> *.delta_update file in deploy image directory
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ln -sf ${DELTA_ARTIFACT_SWU}
>> ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
>> +}
>> +
>> +addtask do_image_delta_update before do_image_swu after do_image_wic
>> diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
>> new file mode 100644
>> index 0000000..c7a3893
>> --- /dev/null
>> +++ b/kas/opt/delta-update.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation 2024
>> +#
>> +# Authors:
>> +#=C2=A0 Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +=C2=A0 version: 14
>> +
>> +local_conf_header:
>> +=C2=A0 delta-update: |
>> +=C2=A0=C2=A0=C2=A0 IMAGE_CLASSES:append =3D " delta_update"
>> +=C2=A0=C2=A0=C2=A0 IMAGE_FSTYPES:append =3D " delta_update"
>> +=C2=A0=C2=A0=C2=A0 DELTA_UPDATE_TYPE =3D ""
>> +=C2=A0=C2=A0=C2=A0 DELTA_ZCK_URL =3D ""
>> +=C2=A0=C2=A0=C2=A0 DELTA_RDIFF_REF_IMAGE =3D ""
>=20
>> Please also extra-weak define the DELTA_* variables in the
>> delta_update.bbclass (to always have them defined and for documentation
>> reasons).
>=20
>> Best regards,
>> Felix
>=20

