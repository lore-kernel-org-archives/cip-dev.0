Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC53C54E58
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 12:29:31 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.77])
 by mx.groups.io with SMTP id smtpd.web11.15532.1710332962229371056
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 05:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MRKxHNx+;
 spf=pass (domain: siemens.com, ip: 40.107.6.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM5dbUUE3u3YVxjYg2aF+3AVHYDRS93i/ohvue8ldAP9XFe8FEbu8mNtWROth1GPcC7fYoOsM9AJ7lblHUvLmF045RFOZrzi2K11pDV/l6hKkHr0HTyKBVX2xspB3IKxsXw2KHYWuU/GIR+Swu0N4FwEboHFR6mVGf75vR4dJjnaeLiXr2NU2dCVigrr5uk4nVNX6vl2inx9VkkJ8x1sjW6UHGK/XAAWuD49JL0zvVR6sfJCDLOsnfjukCH/W5ro8qPyo8ZCs6+CONHvKizqfR18jlcA5g7UpbTIC57Rhpm9aUPc0VXMtpshnzxaWUX1QrzmCIoW7VfqacStZ8Xr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA/Zse4szkdZNwwL7HwliXzeGt0v5/yHS+S4XwYtRbw=;
 b=ixRGg+es0CwSPO1GqVQafTon7XYx62rvdkv6IHNwKHXiXFTUFatDq4RWc8+b4W0GWlQuQpm1MAWhWxTB0aYW0UuOozXFxZBq6xisHxUICTwpW9kEbvZjD4UlB9VIJ6x4019eQ5ScQl4GiyNFG5tOKoS6EuXSMe2RnNP3TOaJ8R6Rj84MikJhLN/r836TgQyC4JV8wXM4EpdufwyLo6w1iLSOR4BScwkz6pmYbzaG8XSfU7qZP2+iHaM9zZTdK3BpKfLP6yJTp9Jf78FHgacykmI/c8zHZjThv95/+kMxwxrAX+o9CHgIxFQQiFIwYtDOo0WLmpzlXV+ivUndjgneWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA/Zse4szkdZNwwL7HwliXzeGt0v5/yHS+S4XwYtRbw=;
 b=MRKxHNx+5OZETZMu1/LcE/Ao9Tct/wQowIb9GzTUO2slNsU9q55pSJ5UwqhrywhO/1Y6w56kD0pqmEJKpsvHgN9YeZiB9Xin6N7a+OTf4Ff7LYfTFfBIppZEaQFAtlBcpScHp+7PUIUICte7rqxn+Tt2pmJvlVs4L0vb8b7ccGWO/Kd1DFZf0NVROPnR4NnTNiYbxOa6rDSAuP9yjJxk0QeBWls9DRfBkXkk2SymfvEvH5zG8R4W5Cai3gi0CFAFHTx3CcctN3OjesnXQKdfNleEKwHGMDeG20WESxCdIj4V6+V6AlxgSA63IykYeT1Pe8xGJcyiLE63mLsnL7YC1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 12:29:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 12:29:18 +0000
Message-ID: <0a825f3d-a1be-4ce5-a485-adb06e18ac93@siemens.com>
Date: Wed, 13 Mar 2024 13:29:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with
 rdiff_image and delta handler
Content-Language: en-US
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
 <31bf9be7-30c7-4717-a34a-9d0477607f55@siemens.com>
 <TYCPR01MB96693926FB38BED196FFEFC0C42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYCPR01MB96693926FB38BED196FFEFC0C42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 607e4ee1-c661-4985-dbdb-08dc435933b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AbROfx/PetnEZjWoyc7xaQqdwoMBHOpnqrMf9TcAv2n9zUR3LoY2VNamFvI27L9DnBdGmz6K5sY0IblQcnBCTiluKjZWi+Wv3e6JlW4rjCLxr0Oc7VH6+aD6pdbugp3Yb8ZBalrOavN9bjukJJABdjRGTh310yepGTgZxvXZP+C1WvHIWLcJW7M9Tfo6Qvffjo2uEirTAej0DbNxk+QVBeA4sqLW2ttfwvMmqLX9N6HEISUrDGZuAxe4aFuotq5aXdM/HSxBwVizW0GdtIG3NRxVqn5W2j8+8veMfeMll3XAPVj7jOH/3YGgTQaizZ0RE2dg6OYpZEDQSNGYmgg8NcxueU2LaSUURl+BWrAxBpLenob2trGgXnacl5eZhzKTmL0jYUuEJtoV1Pf4IX+Z1qxxbWyGQyzUZJxdSGYI9LDka0LNV5w6womUHYtIorgcGwOGVf6ykvirr/D77YWjYoS0Zu9euy1l7DPeOVMDbHHvX4SJFm4S4Zsm5PSqc4OLRDwhteAx+vyCR95jr8gKY5FI7GVXFMMdkLpr2Gk9WjeI+wNwaz6s73XyskZm7wjWbPNzoUceL9StbEZSI5tzku28hoy4ycxOqAhVPEgf4UF/3Enw4M6DfOELUhNFZCDIhcuJpJsvMf6HIgdjXaiq+bjRosKxiLkcqeazK1DgZRQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1f10snBUyADgZoippsufTOh1zsxW+exzg9bwm6O4sgWANbsm/gvIJrtBunl0?=
 =?us-ascii?Q?6xo48kbW1aL6X6tHyIHbJ7UNRMBz5mx039bQbcGiAIixcF9L7bqW28dzPbkm?=
 =?us-ascii?Q?aaoGM1IqWe27Ep67dZVBTvdLkBRWxHrWx7GZRwdZpQSegOMRSzBhEb4tD5BE?=
 =?us-ascii?Q?uoXawzqtr7CCq3mx+8LJwHCx6Iszg1sT5OprXybBEW2JE4YZ3w5GsGGxewv4?=
 =?us-ascii?Q?AnKrDODzTfxMxNtESBycJPdE+ERCcWKcy/Lii3NCiWDR8M78xomYTFXLrboH?=
 =?us-ascii?Q?pXSj7YDZ0X/97MwwFAKs9Cr8AcmVv1oUuCgXUgWMi/+zOQ5nWu52EHpmjUvz?=
 =?us-ascii?Q?+3g4jesvp6QinRsDfPvzmwsM2hbgfcQOxbfDhtYLuJPgconDx5dt2OytGYUl?=
 =?us-ascii?Q?T8DMGnnqXjqd43xUsq0A1hLP+m+O0zyp572ISaBy0j1M6TNe7eaPKRh6lGfr?=
 =?us-ascii?Q?cLAdS4X321seNSl/OvOHVgTiS+i4Hsv/ZKAkADbPXCIP2ol4b7n45snKztGN?=
 =?us-ascii?Q?OK8xz1c4/Aye1/HnUQoFh90/X7YOukhkllE2nD9xnVUbLXpAUkxbG9z1Vhbo?=
 =?us-ascii?Q?/o1hgmCeqUywrd2JRE+G4NauuWRTGXt2XiT74qqMQMxbQo2Pw7wtsHojxjm+?=
 =?us-ascii?Q?eH4Tbk8fwpcr+E1UB2KMZ/IAj7v6pOmFhiXzmWXh+G8JeM17EcQchD/DRgqw?=
 =?us-ascii?Q?zg7fhYXEBHVI5f4im/MHoZfxwEnYwh5CLLuT7ViLZPjJREEoTbo9/r4n+MVB?=
 =?us-ascii?Q?GU0Aojx3psSpBHMdDasZDicjtnsWXNu3YKMj37t1DqpV0bDgABSmFRkvJQ8F?=
 =?us-ascii?Q?eOVxF9etsyf8PKUPyw1l1oc8AoAvaGt4O6EYBr1C9W2ekRuEOtxNFNDtbkRO?=
 =?us-ascii?Q?J5NygkC64HDvA4390URSImBSnEYY2JguGPPYZszHaHTVFpMgddwJK+sE+PHq?=
 =?us-ascii?Q?w3o/y4PFAb4u9+i65Pi4VIPaYWJiauFomxg7fh23MwJsUDyY2N7PacTMsH79?=
 =?us-ascii?Q?y4FOxVk6HboP8CsV8hW2Mg7QaODqhRNYYuFRZ7lX1in8NT/INTCzCv1V1jCC?=
 =?us-ascii?Q?ervqIeVrZNzV3cpbJi6J4WxHl2zMLWwibpt57Yee8dla/63bJkT2rxsPow2j?=
 =?us-ascii?Q?FlxgI9IYarkY/r5nP8X3ntfH2+yC7XMrLSLbiJ5oHb3559goScfWNi6ZPexJ?=
 =?us-ascii?Q?UVSfrwdDaz5jAHhHlwzulMBDWrGA3XueE806qlX4Qvta4InUzqqY50z+uRi3?=
 =?us-ascii?Q?OFQlYVaiP31MuSafTDJtDaKKwXsaWcf77iAhECHGBDzBagIIiLHhmR5HK7M0?=
 =?us-ascii?Q?AyTxUaWteyLqSxZAXMufj4iEtjrw4keOyCoDmIJGVji6kgF2VUl2q5ejez6b?=
 =?us-ascii?Q?EUSiG+sU1XijiDko7ZJcmjoCFhTc0huhB5mU6KSvnS5Gw5S2wPNlXkSZGBUb?=
 =?us-ascii?Q?ayAEBHVs8TIUL7BhEcWR/DP8OZFVQ4L00TZPwx1c4Drk+yG6xwvBALUmsTBi?=
 =?us-ascii?Q?KGp+FElc7LjsiikqTV4TUIYQZvwArUk9IC385RX6su1Ua9vw8CvBrqsDfNrk?=
 =?us-ascii?Q?6Ag4vep1eskWFWPm5oyM1ZSJ71/97aoykawxLCkk8hZ958IB1VWdAL6eFVs/?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607e4ee1-c661-4985-dbdb-08dc435933b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 12:29:18.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5pl/pgfUVlT50SIa+Pa8YuvZTe3cOQSic4+1Mlm+wPsUYhN4xp7aoTfy/LL44KXZmWjBSkmwv5sNt4eo6SxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6507
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 12:29:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15290

On 13.03.24 10:20, Adithya.Balakumar@toshiba-tsip.com wrote:
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, March 8, 2024 5:15 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithya=
.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
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
> On 07.03.24 08:46, Adithya Balakumar wrote:
>> swupdate supports delta updates with rdiff_image and delta(zchunk)=20
>> handler. This change adds support to use either of the handler for=20
>> creating delta update artifacts. The type of handler can be set in the=20
>> delta-update.yml file along with additional variables needed for the=20
>> chosen handler.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  classes/delta_update.bbclass | 90 ++++++++++++++++++++++++++++++++++++
>>  kas/opt/delta-update.yml     | 21 +++++++++
>>  2 files changed, 111 insertions(+)
>>  create mode 100644 classes/delta_update.bbclass  create mode 100644=20
>> kas/opt/delta-update.yml
>>
>> diff --git a/classes/delta_update.bbclass=20
>> b/classes/delta_update.bbclass new file mode 100644 index=20
>> 0000000..8d47081
>> --- /dev/null
>> +++ b/classes/delta_update.bbclass
>> @@ -0,0 +1,90 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +IMAGER_INSTALL:delta_update +=3D "fdisk zchunk rdiff"
>> +
>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>> +IMAGE_SRC_URI:delta_update +=3D " ${@ "file://"+d.getVar('DELTA_RDIFF_R=
EF_IMAGE') if d.getVar('DELTA_UPDATE_TYPE') =3D=3D 'rdiff' and d.getVar('DE=
LTA_RDIFF_REF_IMAGE') else '' }"
>> +
>> +do_image_delta_update[cleandirs] +=3D "${WORKDIR}/delta_interim_artifac=
ts"
>> +
>> +extract_root_fs() {
>> +    INPUT_ARTIFACT=3D$1
>> +    OUTPUT_ARTIFACT=3D$2
>> +    SECTOR_SIZE=3D512
>> +    ROOTFS_LABEL=3D"primary"
>> +    ROOTFS_START_SECTOR=3D$(${SUDO_CHROOT} /sbin/fdisk -l -o Name,Start=
 "${INPUT_ARTIFACT}" | awk -v name=3D"${ROOTFS_LABEL}" '$0 ~ name {print $2=
}' | head -n 1)
>> +    SKIP_VALUE=3D"$(expr $(expr $ROOTFS_START_SECTOR \* $SECTOR_SIZE) /=
 $(expr 1024 \* 1024))"
>> +    ${SUDO_CHROOT} /bin/dd if=3D${INPUT_ARTIFACT} bs=3D1M=20
>> +skip=3D$SKIP_VALUE count=3D1024 of=3D${OUTPUT_ARTIFACT} status=3Dnone }
>> +
>> +do_delta_update_sw_description_template() {
>> +   # Since the sw-description file for delta update would not be very d=
ifferent from that of a=20
>> +   # normal update, copy sw-description.tmpl as sw-description-delta.tm=
pl and add delta update=20
>> +   # specific properties
>> +   SWU_DESCRIPTION_DELTA_UPDATE=3D"sw-description-delta"
>> +   cp "${WORKDIR}/${SWU_DESCRIPTION_FILE}".tmpl "${WORKDIR}/${SWU_DESCR=
IPTION_DELTA_UPDATE}".tmpl
>> +   sed -i 's/\SWU_ROOTFS_PARTITION_NAME/SWU_DELTA_UPDATE_ARTIFACT/g' ${=
WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.tmpl
>> +   sed -i '/configfilecheck =3D/a \                      \'$'{SWU_DELTA=
_UPDATE_ADDITIONAL_PROPERTIES}' ${WORKDIR}/${SWU_DESCRIPTION_DELTA_UPDATE}.=
tmpl
>> +}
>> +addtask do_delta_update_sw_description_template before=20
>> +do_transform_template after do_generate_image_uuid
>> +
>> +IMAGE_CMD:delta_update() {
>> +    if [ "${DELTA_UPDATE_TYPE}" !=3D "zchunk" ] && [ "${DELTA_UPDATE_TY=
PE}" !=3D "rdiff" ]; then
>> +        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
>> +    fi
>> +   =20
>> +    DELTA_ARTIFACT_SWU=3D""
>> +
>> +    if [ "${DELTA_UPDATE_TYPE}" =3D "zchunk" ]; then=20
>> +	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic" "${WORKDIR}/delta=
_interim_artifacts/${IMAGE_FULLNAME}.raw"
>> +
>> +    	# Create .zck file
>> +    	${SUDO_CHROOT} /bin/zck \
>> +		--output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
>> +		-u --chunk-hash-type sha256 \
>> +		${WORKDIR}/delta_interim_artifacts/${IMAGE_FULLNAME}.raw
>> +
>> +    	# Calculate size of zck header
>> +    	HSIZE=3D"$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${I=
MAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
>> +   =20
>> +    	# Extract the zck header
>> +    	${SUDO_CHROOT} /bin/dd if=3D"${PP_DEPLOY}/${IMAGE_FULLNAME}".zck=20
>> + of=3D"${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=3D1 count=3D"$HSIZ=
E"=20
>> + status=3Dnone
>> +
>> +        DELTA_ARTIFACT_SWU=3D${IMAGE_FULLNAME}.zck.header
>> +
>> +    elif [ "${DELTA_UPDATE_TYPE}" =3D "rdiff" ]; then
>> +        if [ -z "${DELTA_RDIFF_REF_IMAGE}" ]; then
>> +            bbfatal "You must set DELTA_RDIFF_REF_IMAGE and provide the=
 required files as artifacts to this recipe"
>> +        fi
>> +
>> +	# Extracting root partition from image1
>> +	extract_root_fs "${WORKDIR}/${DELTA_RDIFF_REF_IMAGE}"  "${WORKDIR}/del=
ta_interim_artifacts/old-image-rootfs.raw"
>> +=09
>> +	# Extracting root partition from image2
>> +	extract_root_fs "${PP_DEPLOY}/${IMAGE_FULLNAME}.wic"  "${WORKDIR}/delt=
a_interim_artifacts/new-image-rootfs.raw"=09
>> +
>> +	rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
>> +	# create signature file with rdiff
>> +	${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/delta_interim_artif=
acts/old-image-rootfs.raw \
>> +		${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
>> +
>> +        # create delta file with the signature file
>> +	${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts=
/old-image-rootfs.sig \
>> +		${WORKDIR}/delta_interim_artifacts/new-image-rootfs.raw=20
>> +${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
>> +
>> +	DELTA_ARTIFACT_SWU=3D${IMAGE_FULLNAME}.delta
>> +    fi
>> +        # create a symbolic link as IMAGE_CMD expects a *.delta_update =
file in deploy image directory
>> +        ln -sf ${DELTA_ARTIFACT_SWU}=20
>> +${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
>> +}
>> +
>> +addtask do_image_delta_update before do_image_swu after do_image_wic
>> diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml new=20
>> file mode 100644 index 0000000..c7a3893
>> --- /dev/null
>> +++ b/kas/opt/delta-update.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation 2024 # # Authors:
>> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 14
>> +
>> +local_conf_header:
>> +  delta-update: |
>> +    IMAGE_CLASSES:append =3D " delta_update"
>> +    IMAGE_FSTYPES:append =3D " delta_update"
>> +    DELTA_UPDATE_TYPE =3D ""
>> +    DELTA_ZCK_URL =3D ""
>> +    DELTA_RDIFF_REF_IMAGE =3D ""=20
>=20
> What prevents making this the default for generating update images?
> People could still add their own options or local configs if they want to=
 deviate. Would also simplify patch 6 further.
>=20
> Jan
>=20
> [Adithya Balakumar]=20
> Hi Jan,
>=20
> Apologies, I would like to understand your remarks more clearly.
> Are you suggesting to have sensible default values for the delta-update v=
ariables in the delta-update.yml file or to not have these variables in a s=
eperate .yml file at all?
>=20

No, I would like to have an interface that comes without the need for a
delta-update.yml. As sketched elsewhere: If you build an swupdate image
AND provide artifact(s) of a previous version at some to-be-defined
spot, isar-cip-core should automatically also generate the delta update
artifacts, along with full updates swus.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


