Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1663EC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 10:33:24 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.68])
 by mx.groups.io with SMTP id smtpd.web10.8563.1707820402924512086
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 02:33:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UpfEl/Z2;
 spf=pass (domain: siemens.com, ip: 40.107.6.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqckJfjUkAe6cJ/LO3PiFYLCTnWgox8nFpQ78wNppDKDATuVGUZiGxunj7NK+Lrg8+rf/wR20DhjTpiNWQM+PCMC+5aIrxOQyUwRpSD5oqfFdfvwUQkgyZPe0wUov02qA4m+N4S7n5Mc7wbc/zClC2kWAwIpBrxUSND7m/wUg1gugcYVI0vr/Qwgjt9PNa9XnUwKX6i0nlnd9wnKJh+3vmXTsEG7zl8JR3EznRMVQmVyOXQo/0wTV1oryQnFxQBgNYhPiFmu2yxFszqhm+JhmLd8/XPeCuZDhS/1LGDpvJt6DIFdvAQxHVmNhKQpnPPYwtH5GOEX6DkGAVMuzRZYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+T+60obPqAgw5RuDS+NhoMrTxrv0sgwMGHoQ8cxFiQ=;
 b=HVP0hXa0BhGH5blVgPbx85uvVku78iTFCOzwiUdqUOs+33HkU1zVeXH7cmyWxXFcJXyaXYpMist59i/J0+FDTu+9LSldw8VbLlhHTxiTeolNkmYKA8SE2rq32YZX+X+0FUuky4NWj5DxOeMgX/Nsdix7Zx/uDxYr57W7otXcFW4TpcqX2jJXagf6lnpNmNEsR2EoC0H8V14mDCGFbYMldb4Nz1NUpjCyHPfa2gdygr/GdMqonbj9q9HhtRHYt/ufn22R8SjDgEGhNBk0fA4TteFGyq0qxl6wWvFFJZ8hCvAol8SKbcToXwDYxj6H+GN8BTJU+a1mER89GAHMj+u71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+T+60obPqAgw5RuDS+NhoMrTxrv0sgwMGHoQ8cxFiQ=;
 b=UpfEl/Z2mhFkyhLPTD1MAInrmRs7JhUoRWdOybWBndoik+G2hsaCIgqqOSA5e5yjH7OdIHk5DjkPNr+/w4TFzkgAuXAtvwHWRD9LF079MIQ8rBtMoHZw0ID8wOr4pCPOSAFLYNV5DSZwsDeiZWGSywYgs/ThwvFM61emftR2fHvFvgq2HucaDCPafzvYRp/Fym1QFm/PK9w/xBNDvp7Uc/NqQRci2UuD9qy2P6ejlYyym8IDW43hKF3JYaYVYjciM80MCqxiXk5viKkMUUsbyUv0agnughptwbHhVQbq1QAJhebBHiaDl8T7Tym8p5gcibPNyX+n9KHpDMtFFvimvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 10:33:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:33:20 +0000
Message-ID: <464bd7dc-85a8-4fd5-8452-256c02f60ff4@siemens.com>
Date: Tue, 13 Feb 2024 11:33:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "shivanand.kunijadar@toshiba-tsip.com"
 <shivanand.kunijadar@toshiba-tsip.com>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
 <20240130115648.311177-2-felix.moessbauer@siemens.com>
 <29de90aa-1a30-4f17-9538-e6a2334bc343@siemens.com>
 <cd3b8b6b9d762cda263489202a5c16ecbb3fe68a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <cd3b8b6b9d762cda263489202a5c16ecbb3fe68a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6cd693-73e4-439f-0822-08dc2c7f329a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/bRULYT9rjcBI3K6iYYgtJid5OueH3XctsPVvpNgyONRwPaMcsea2idQehn9pZBTeOOQw4a6lRTXNFPXPkzB1LFPqTTX4UMNL2MORh1n3r6Jpr6Af0y3x3VL9vpIPq63zD8Mx7jNzmzMvai136Oh3N9pa6AnwANQ8vAE3eTwLn6w2XexizEz5pDNcSOh4K0+y/Df+/f+lpno8pZ/3zlQvdFEEhu8XJlveL3Nr7HoPUZm8JQMpfsHyX+y8FjJ+grxjfWm1pPyOFBPAWop8gKWjc412Wf8XJwoCE4N2AJT7yxGfcnanzxJB/1THP4NG1hA0wXDCRZirFTS7++k22QQsvgn1ej9hbhpKeQ7YFTZfm3cLULu5MoQgZNelSV2a5BrxHUxKDv43UMT1gTY9y1dSgpipF2I2ooQ8S02LV07wTmr9H/wymQAEN/QQhsCfJD8b/mHXIxVx1r/VOxh98xG4FOpvh6Fwyd0totic+e57PUy173ZRTkF6/h/2x/ISiXgaBrIAkeU9+1UWGi7tAB4bdfIzwR4A3D72zLjhLpzTYw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(44832011)(31686004)(41300700001)(2616005)(107886003)(478600001)(83380400001)(66946007)(66556008)(6512007)(5660300002)(66476007)(8936002)(8676002)(4326008)(53546011)(26005)(36756003)(54906003)(6506007)(110136005)(6486002)(966005)(316002)(38100700002)(82960400001)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LEd8yg9mLHnhRKPE/fJU6Naxig9SPpAPrPRL7AkvsFB9AvPAuF91XSvKg7u8?=
 =?us-ascii?Q?2gtzzVcFEW8QxB1+qSTT4NB5x7uqyXvvwgUGb7zS4J+lHjbGV3Jnc5Nf9Jy9?=
 =?us-ascii?Q?PciKwczdGDm9qibtM9knhELF7LgbM5zIoHOzhcDeUDCVyDxoCOw8HU+ZiuFZ?=
 =?us-ascii?Q?kXCAZWkzuCthqmeuOdn7hzJsHrWyKTr19x6H21AU1tOFeLCB+tjVExuvgl1J?=
 =?us-ascii?Q?nYQepNMOpJRv51YAD62/hXYs0TyZgnJJN/zSXMg1/JBfbL5RvlunM8S+PQ6Q?=
 =?us-ascii?Q?5n8+P4WwrImvpblKtDsIBit5+Smx8ay/UxAXB1WD15Dby/kpmiPg7vjNss8d?=
 =?us-ascii?Q?pqjK8SrjWRaK9XSP8jqEtTTvg8PuRdn90lbzt53UnZ7heZCPDUusG3kyY17m?=
 =?us-ascii?Q?rldttZW2aDFLJwoC/QpSC3BkmEWKnogLaCWfuN2XtH8HVimpcx1wVkKzUjtm?=
 =?us-ascii?Q?i7nWFD0k3GwuZgzN8XJNLOSRYZ4ceC04h8ZPGrzz7vIPdQxWYiEzBhSNjeoZ?=
 =?us-ascii?Q?AtHFBq6ZrZoAMz/5jXAMQClk13SsQ0AtoIW1Nc5V/6TRNIjLklUp5NjeTnwI?=
 =?us-ascii?Q?7gQCdfm87CMM1H5V7FAatIA4XSIxBVSo6rJmR65ssEOsqeS6vER6EsisYkh4?=
 =?us-ascii?Q?j+aU3X7wXCznvY8eCTMi+oXNDF46khUCuLl6V3NuO8YNbxgNlEoe5jPqubcE?=
 =?us-ascii?Q?72DWWIfsXa0xAJ3k1c2XlFUr0VUJFHG4HqyQNDPhnD2kHeJ0/DklLshwKkA7?=
 =?us-ascii?Q?Dp731lW/kpgeveIi5ho+ZXQrATaKkQawn8Ir9HGiTIr8/FoTZyiQupTpw8RH?=
 =?us-ascii?Q?Dwq3s+qY4a4R78ueMdC61cuMAmdLetOhXuVshZH1jCEFKNYknhFWnaeyPibW?=
 =?us-ascii?Q?7cmlR9g6s8wYGjNDArJGT0BOURpy5+bJ+RGB2BT8J3MkxSxrV2Mlcfdq7/So?=
 =?us-ascii?Q?vxn/6tdVczHHRV71rUwCkI0E8aKq3TS8LDuFBQmOBULp+gH6HRh531Ojc5SS?=
 =?us-ascii?Q?lTZK5rAGSjQKCe/lDYwtu38XBKfrLUB8ctVasdGmoeYi9YCHsAQlUk9+PslO?=
 =?us-ascii?Q?vYP3C6GNXXlb/ugW7UaKtQlq/YJ88xxImpdpB1jS5wg7DE0yDOeto/veYwMl?=
 =?us-ascii?Q?7Rp+kflXh8YjqBVQABjVxA/vs4eFN4CNwG2Z2PzcZjQ9rExuGLMMLY4K/MOo?=
 =?us-ascii?Q?bZqye50iwqi+chsZIJL2N/HIbweywRJYniQ2rZJ1nXGRbYMdT4nXMaKto99c?=
 =?us-ascii?Q?+fk/719wtt1xEkW6TyTHH+CpeiJvoYR/d6wIVPvo3+ST3+XSkDEsNVxoEcga?=
 =?us-ascii?Q?MBV1lfebRXlldwz7YKolHum7CgdocQvPOIrY7T1pDpSd90PdHbi0345J4fpc?=
 =?us-ascii?Q?LswRJokhd2VKVDLRhYiK3kk0bYxokSsDrWva7HosgZNnhQTRgoFMmUuoPQN0?=
 =?us-ascii?Q?4oEbhZiQuQXFs2hcWNvX7U7EZd32QA39o0iiZkUVLn9agl4mE2pAo/5NyeBG?=
 =?us-ascii?Q?SqJjP079/G6ui7HOmjbWJTn1GJAPsZxvg8WUK6iQ+tSMs3xjWzSPmWZhOCnj?=
 =?us-ascii?Q?ZXg4rWfjwLoioyWBPgSIT6hFAWi+2h+Rv5PCX7XmwANNX283rlWnxx4R/1hF?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6cd693-73e4-439f-0822-08dc2c7f329a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:33:20.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9HiK6XlPYTtbAVezOtLsmk+Lxe9MM/VffXKKnVTxjnI2xyItD23HLp6b8UYnRVbmC9HAULV0t5cE9SgQwWlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 10:33:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14935

On 13.02.24 11:24, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-02-12 at 19:16 +0100, Jan Kiszka wrote:
>> On 30.01.24 12:56, Felix Moessbauer wrote:
>>> The dpkg database is located on the var partition, but this
>>> partition is
>>> not updated (and might not even be deployed). To still have
>>> information
>>> about what is installed, we relocate the database to /usr/share and
>>> create a symlink using tmpdirs.d.
>>>
>>> Note, that this is only enabled on debian bookworm, as the proper
>>> packaging of tmpdirs files is only supported from debhelper-compat
>>> 13
>>> on.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>> =C2=A0classes/read-only-rootfs.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++
>>> =C2=A0.../cip-read-only-rootfs_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26
>>> +++++++++++++++++++
>>> =C2=A0.../files/cip-read-only-rootfs.tmpfiles=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0.../cip-read-only-rootfs/files/control=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 ++++++++
>>> =C2=A04 files changed, 48 insertions(+)
>>> =C2=A0create mode 100644 recipes-core/cip-read-only-rootfs/cip-read-
>>> only-rootfs_0.1.bb
>>> =C2=A0create mode 100644 recipes-core/cip-read-only-rootfs/files/cip-
>>> read-only-rootfs.tmpfiles
>>> =C2=A0create mode 100644 recipes-core/cip-read-only-rootfs/files/contro=
l
>>>
>>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-
>>> rootfs.bbclass
>>> index 6f91f66..14ed85d 100644
>>> --- a/classes/read-only-rootfs.bbclass
>>> +++ b/classes/read-only-rootfs.bbclass
>>> @@ -17,6 +17,16 @@ do_image_wic[depends] +=3D
>>> "${INITRAMFS_RECIPE}:do_build"
>>> =C2=A0IMAGE_INSTALL +=3D "home-fs"
>>> =C2=A0IMAGE_INSTALL +=3D "tmp-fs"
>>> =C2=A0
>>> +# For pre bookworm images, empty /var is not usable
>>> +IMAGE_INSTALL:append:bookworm =3D " cip-read-only-rootfs"
>>> +
>>> +ROOTFS_POSTPROCESS_COMMAND:append:bookworm =3D" cip_copy_dpkg_state"
>>> +cip_copy_dpkg_state() {
>>> +=C2=A0=C2=A0=C2=A0 IMMUTABLE_VAR_LIB=3D"${ROOTFSDIR}/usr/share/cip/var=
/lib"
>>
>> Hmm, should we really add "cip" to the path here? I would suggest to
>> have a more generic name like "immutable-data" or so, avoiding that
>> this
>> recipe is renaming while branded downstream or has to be renamed if
>> we
>> ever hand this over to Isar upstream. Maybe the package name should
>> be
>> aligned as well then.
>=20
> Yes, we can use a different name here, but in general downstream users
> should place their immutable data in dedicated packages. How about
> immutable-dpkg ?
>=20
>>
>> Jan
>>
>>> +=C2=A0=C2=A0=C2=A0 sudo mkdir -p "$IMMUTABLE_VAR_LIB"
>>> +=C2=A0=C2=A0=C2=A0 sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VA=
R_LIB/"
>>> +}
>>> +
>>> =C2=A0image_configure_fstab() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>> =C2=A0# Begin /etc/fstab
>>> diff --git a/recipes-core/cip-read-only-rootfs/cip-read-only-
>>> rootfs_0.1.bb b/recipes-core/cip-read-only-rootfs/cip-read-only-
>>> rootfs_0.1.bb
>>> new file mode 100644
>>> index 0000000..76453ab
>>> --- /dev/null
>>> +++ b/recipes-core/cip-read-only-rootfs/cip-read-only-rootfs_0.1.bb
>>> @@ -0,0 +1,26 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Felix Moessbauer <felix.moessbauer@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +# Note: This requires debhelper-compat 13, which limits it to
>>> bookworm
>>> +
>>> +inherit dpkg
>>> +
>>> +SRC_URI =3D " \
>>> +=C2=A0=C2=A0=C2=A0 file://${BPN}.tmpfiles \
>>> +=C2=A0=C2=A0=C2=A0 file://control"
>>> +
>>> +do_prepare_build[cleandirs] +=3D "${S}/debian"
>>> +do_prepare_build() {
>>> +=C2=A0=C2=A0=C2=A0 deb_debianize
>>> +=C2=A0=C2=A0=C2=A0 rm -f ${S}/debian/compat
>>> +=C2=A0=C2=A0=C2=A0 cp ${WORKDIR}/control \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${WORKDIR}/${BPN}.tmpfiles \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${S}/debian/
>>
>> dpkg-raw wouldn't have simplified this? I think even compat is not
>> customizable.
>=20
> DPKG raw in general is only useful for a trivial copy of files into the
> rootfs. Here, we need the debhelper logic to process the tmpfiles.d.
> Also, we need to update the compat mode so that these debhelpers become
> active. I don't see any value in mixing this with dpkg-raw, as most
> parts would need to be written manually anyways.
>=20

With [1] (granted, not yet upstream), this would simply be

inherit dpkg-raw

DPKG_ARCH =3D "all"

SRC_URI =3D "file://${BPN}.tmpfiles"

do_install() {
	cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
}


The whole control file would become obsolete.

Jan

[1]
https://groups.google.com/d/msgid/isar-users/20240201101236.3555681-1-Quiri=
n.Gylstorff%40siemens.com

--=20
Siemens AG, Technology
Linux Expert Center


