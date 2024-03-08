Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41656C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 16:43:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.64])
 by mx.groups.io with SMTP id smtpd.web11.26832.1709916206247825094
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 08:43:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=B6brM/Qe;
 spf=pass (domain: siemens.com, ip: 40.107.21.64, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv+6GCkqF8Ai3+4XHj6NohRbHbNbgXE1NpHLeuLBI4P1QkFQibjYc8ZET9y/WmZ833JpTjmfnTzqxKRlTbAupR+vlScdH6We23iBGGkdrwa12wx2VovqEi+TiHf56aa+6Z1V8Y7HQjSb0Yd4rI0CB3k1UGz3O02p64f7YFnjxtQMVwIkhv5DeDECAjPPMG8gd2dYuIT2HX6/2xQAbmSq3cfN+PN+HHWk2WwyvjvP3g210JFCLkEp6iXiPAq9sE7NUT0gomVUjzMYn1Se5mc6rvtGvnyqLwUD3Xwu/klwDIXNotWBzn+Jgz7cq8pVgX/0mOHeZpiM2jb4huSz5BEvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYXvNmp3ZpZmziS6WPMBIfd3+n0cZ6NZZJIbHQt8tDM=;
 b=lPOn6lS+OZvzamacWwYmKMWeutfchm6y1DeE2NNlcB/VEl4jJDne7uXN+NJv2tQFpSf6xRk7Db+LV1sq6DX90NQG12me4M5E1fAIrI3c09HXDp13TZRPe6C+ly1haSWAbj8W+FcPCN9+c2fpR/MhtsxjBS4frCsd41HFcj31NNO11NPcG0xenoATnuDo6bjOoxDA3DQUxGK868xYvBkiDvzulp4lMk6wDrjB1PCzwoq4kcOGOD/N3h5tZqe69LhYeJ7qEFR6IMEQJ0oGgHPn9Xsy+OVh4NHe+arPYmhhsuX5JAAi3Cm6GHp4TQg4qRIi2mx/OgIV4WIooed5I5uiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYXvNmp3ZpZmziS6WPMBIfd3+n0cZ6NZZJIbHQt8tDM=;
 b=B6brM/QezGePTuW8vU16UPUX3f44YNu4uKOMCXyPXIfdIo5a/Q6aui9xvVHk0Oje9+iONU+qmkYsthipnFNRBvk3epp74d3MbdLGzu45lY9LLXzB30ElbZeJXYf/74FfgrvLlFoCvM/JjmKPcwhdli1j4Q/sRhtfs6XMdiR5gXlnW6MQhcE95vGvminz4Ds6YvcWd1Xpgx9EttBSbphqZ2rxfmM5QhL739njyoPbjJrSR5k9TD4F/EcLp3ots354fSphcixsKMdIb7syQ6oI++XKTcKQofw6k9fp7z2HPACTrK0NmR9iErko5OcY50Y2b8ZfDyu9O9dN1j6h41lPqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:43:22 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 16:43:21 +0000
Message-ID: <5c405595-0182-4e1f-9687-7b7edd9d1e95@siemens.com>
Date: Fri, 8 Mar 2024 17:43:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 4/6] Add Delta update support with
 rdiff_image and delta handler
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
 <shivanand.kunijadar@toshiba-tsip.com>,
 "sai.sathujoda@toshiba-tsip.com" <sai.sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-5-Adithya.Balakumar@toshiba-tsip.com>
 <0876d8dd533161214f2010cdbcd65d5084a1ddd3.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <0876d8dd533161214f2010cdbcd65d5084a1ddd3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::29) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: b7047630-f01f-439b-88dd-08dc3f8edd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ViCCViZejy1NT9GUES+9ulnRA1VPoKwrjMyH9/S7toagWL1HIiLbWooTG5wWoeMz5ed81QszUoDLj91RzxoZ2wn3palacoWsYQlCf6lpB5G3iDqM4szoFT7PaKTlE0eBJ+uDcEWb1fyYetMyhphaDunKsMGgUxsFfWFLAtCYSfKSvDDlBJibxpBVBzaf3X3GMj9XDFlQjkOrW+HxkbxzATWbTisC9bW9zNFmC2ubVm158PJl4buaaOTUCb4dXJOOocG2XQ0O1+bnpEuQMkgTFtnzHfVwJEcMDMR9KFjZxaXxlaEmBAdxKTCj6GOl5Z4qXJx+B3iX7eqsKFnkQSF24y88cc+R7eu0K2E2PSb1F2Is2Et9UK7zNUePcbsnVz4SEsyVwy0Wj9f9MVYaiRgs6kdlZO8dlwtamy/etXryBdtPLUVwnbOPCloD6NmDqTBSjS+jU5huNgvWd83kruXKkxaO8wkod79SPvuG5Uyq+Ai8YLzHsrifJhXyLlYu1B+2iwJtJIMexl/81T6wnx4aHdQ8aMY4I7t59WIiw/vWTmPh9ohpDAeZAXrJ0a74E+FFR3hOInrDVh4NI0WxgIIM+u4FT9KIFweYacbtOpDC8xM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OJwO4gPc8kpdc4sGtXVwExdSPG2FDWGNImfI4aWpnRq5vZrtzLeg4fZ39phw?=
 =?us-ascii?Q?zoEhpmkO+BIbMumHbylfEmPZDcO0mp/Zc7+5AAaW4F4ZXSbRY15UCYp7+mEn?=
 =?us-ascii?Q?CBw57aUnt8qA8302Q/OZMi5bHlp2zbiu8Ja8G8IZrRK28nVSezYlVqJmK+13?=
 =?us-ascii?Q?PUyVzsB0zXr1/Pw9lUPXlGR03D1H7+4ady6xfX3TxjEM3tZcjyHw+/09XCQS?=
 =?us-ascii?Q?sr2Q1PXjMkqwJiVe+osigPWVZ2TD7H43qDovu7KgH5iCofpw9Lc+DdY9RGNU?=
 =?us-ascii?Q?z1Y+x7/7Bvg2U8WEkUL+HzYGXKrWgltvY0iv2Q0WHHWYjl3rLoOMIv7R+jAE?=
 =?us-ascii?Q?59qztSoLvuE8tLWd+0nbCSOjcv+4L8fp5AqzS1b41X5UKK9vAwkhGpwd0lYp?=
 =?us-ascii?Q?Kr0yZWza8lZ//kkGvtGFHJdZquHhCrtau4QrQDWR1ndOZOVgXu0xz3xY1+Ic?=
 =?us-ascii?Q?5AVpflVFk2tNKANfDFUt3zns0aAaGWi/Ly1hXGbxYP31NRjf7wyn8+AvJMI1?=
 =?us-ascii?Q?GF1ZRYGd8wcyqe/qqeKoGcPflvJjv6bLeftqpze2blsyu+/OMHX3Q8ynk3kc?=
 =?us-ascii?Q?qmTtL/SQESTGRtQdszBBy7IcsMsXlcZgYfaKTwGahMEgG4fJkQMCVmBrRLfZ?=
 =?us-ascii?Q?Zpty2efEztP9tncWxLC8Rg1IUdG0eb8vAFsMqKuMUVJp46ameeGgmW0dNtTd?=
 =?us-ascii?Q?zVhD7ljTxavMt/RqBOo18I9ilE6/M8fEiwtZTNYSZS1e4Ru9WITQMKyk10EK?=
 =?us-ascii?Q?Xg/iybtzjYiLxEpTuzIv3bhU5n0y10QihF3SQ6MwX7Xym6OFf2BupNX7/0Xg?=
 =?us-ascii?Q?0uvNt4ybVUp1UfCkGj7ShbCS/Tu+phF1804uupRP24L6hEt75djNRL/vxOKC?=
 =?us-ascii?Q?y0YR+iooHhI+BgjyVdUkjwUg2frzmG7m/+LWsijp1Ca2Pa/6vEEYVh/2fcCf?=
 =?us-ascii?Q?MnX+m3W8BohndlCAIqH2KiOWBN2LhCJKSvZx4Xh8N0H6jD5B2+p6SVODZjYo?=
 =?us-ascii?Q?5YKm58kVWH6oK9SEAoOasXt+2LQfn2cZzElGMbjCtX+UpvYLQzW32LEBPjxS?=
 =?us-ascii?Q?mI53sPyP7g/smkwoqBvYJ7eKqWQW+JGhzRFPXI1yfK3E5voOpZlgzyOCoVlF?=
 =?us-ascii?Q?Do2BIKHgokm31pLV6sYhbb07A1k5BjOmIsw4+cmwbCZry4zqQVuaInow+/6b?=
 =?us-ascii?Q?yMplFHK73Z7vw/CfXxnfYbgRMAkCtpPmJdSPF6ONp6DpuUOQj9P5f+Qv9+O+?=
 =?us-ascii?Q?RudZza8Ax9XCeeuOgpyiB9PmjNYbX4RXxuzrsVdG1UzMJLHI931AthZiw6TM?=
 =?us-ascii?Q?sQ1Sxebonyr/fmQqufNPJxQThOLNX1elsWHZkgBseAuf5zel4eh9bv3lbDf3?=
 =?us-ascii?Q?CurX3lgv8xhp4laHyPhaB6kr3Y267JajGYzsr6WyUcLZRZgMQuIYR7wR+66B?=
 =?us-ascii?Q?7uYD2Fdv/cxdssBz195yWPcj6LFRr/E4MKoMepwjwB8Mxhy1Hzge+1G1Hob7?=
 =?us-ascii?Q?9rV6G2ostcaxBaVD2StKfPw48wUWja4qDSlD+guUQLKxl8UqaaION9BGyFZR?=
 =?us-ascii?Q?iYkcFpN22jRUR0idOUQokuLpLRyTYA8wbt8GYVu6CP/DiujZk7cb/U1HQbi6?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7047630-f01f-439b-88dd-08dc3f8edd67
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:43:21.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kzeuxaVM9DcEeOZ2WbA2MChjIvTDmfSpdmp5K3VP4VIRxL2y3b5B1OFJ++nsBfHfE0RDuFfXHCMquExn+TwnINtE04rgB7aslMyoo+R8HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3195
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 16:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15272



On 3/8/24 11:52 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>> swupdate supports delta updates with rdiff_image and delta(zchunk)
>> handler. This change adds support to use either of the handler
>> for creating delta update artifacts. The type of handler can be set
>> in the delta-update.yml file along with additional variables needed
>> for the chosen handler.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  =C2=A0classes/delta_update.bbclass | 90
>=20
> Hi,
>=20
> please name this class delta-update.bbclass to keep the naming style
> similar with the rest of the project.
>=20
>> ++++++++++++++++++++++++++++++++++++
>>  =C2=A0kas/opt/delta-update.yml=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++
>>  =C2=A02 files changed, 111 insertions(+)
>>  =C2=A0create mode 100644 classes/delta_update.bbclass
>>  =C2=A0create mode 100644 kas/opt/delta-update.yml
>>
>> diff --git a/classes/delta_update.bbclass
>> b/classes/delta_update.bbclass
>> new file mode 100644
>> index 0000000..8d47081
>> --- /dev/null
>> +++ b/classes/delta_update.bbclass
>> @@ -0,0 +1,90 @@
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
>> +IMAGER_INSTALL:delta_update +=3D "fdisk zchunk rdiff"
>=20
> Conditionally appending with +=3D overwrites already set weak defaults.
> You might want to use .=3D " fdisk zchunk rdiff" instead.
>=20
>> +
>> +FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}"
>> +IMAGE_SRC_URI:delta_update +=3D " ${@ "
>=20
> Same here.
>=20
>> file://"+d.getVar('DELTA_RDIFF_REF_IMAGE')=C2=A0if
>=20
> I guess this could be simplified and made more portable by referencing
> the DELTA_RDIFF_REF_IMAGE directly (e.g. from ${DEPLOY_DIR_IMAGE}). The
> problem with the FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}" is
> that it only works if the delta image is also from cip-core, but
> usually cip-core is just referenced in a downstream layer and used
> there.
>=20
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
> Can't we simply use sfdisk to query this information instead of all the
> awk stuff?
>=20
>> Name,Start "${INPUT_ARTIFACT}" | awk -v name=3D"${ROOTFS_LABEL}" '$0 ~
>> name {print $2}' | head -n 1)
>> +=C2=A0=C2=A0=C2=A0 SKIP_VALUE=3D"$(expr $(expr $ROOTFS_START_SECTOR \* =
$SECTOR_SIZE)
>> / $(expr 1024 \* 1024))"
>> +=C2=A0=C2=A0=C2=A0 ${SUDO_CHROOT} /bin/dd if=3D${INPUT_ARTIFACT} bs=3D1=
M
>> skip=3D$SKIP_VALUE count=3D1024 of=3D${OUTPUT_ARTIFACT} status=3Dnone
>> +}Why do we do this extraction from the WIC file. We established in the=
=20
issue that the verity/squashfs file is working. see=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/99#note_1798=
945281

>=20
> Why copy exactly 1GB?
>=20
> Instead of extracting that here, it might be simpler to just store the
> .rdiff file (of the rootfs) with each image build and use that.
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
> @Quirin: IIRC you recently refactored the creation of the sw-
> description file. This might simplify things here.

Please don't use sed but adapt the sw-description Variables
to allow both variants.

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
use the case statement.
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
> We only need that to compute the rdiff signature, right?
> As these images might be quite big, better remove the old one before
> extracting the new one. By that we save ~half of temporary space.
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
Can you use seperate functions for rdiff and zchunk?
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
> Please also extra-weak define the DELTA_* variables in the
> delta_update.bbclass (to always have them defined and for documentation
> reasons).
>=20
> Best regards,
> Felix
>=20

