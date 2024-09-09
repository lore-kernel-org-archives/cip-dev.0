Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D930EE021F
	for <webhook@archiver.kernel.org>; Wed, 11 Sep 2024 08:58:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.46])
 by mx.groups.io with SMTP id smtpd.web11.43094.1725844576536304139
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Sep 2024 18:16:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O0A7+yQb;
 spf=pass (domain: siemens.com, ip: 40.107.20.46, mailfrom: zhibin.dong@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmb8qT9T3dPodFmaVfhYy8p0ON+6MENacDp50+mD/lclC8q+kNfZs6H1q1qeEQcP6RYZNjO7vZfxmL+3r7ZQEknKT/7L7b3ZUfx64P1myxSw0dz5VR1MPy3BgrjsZg3zUbx0ZbsfDnuYLaKatdyUzbRuYC4gerXAAFyu92RtxbFjcQGcb0om243cjOeQastRNFCz/KOGFSKOficryYOcoadUWHtpJ7F7T5OmLXHvVuj5SRz7Yo+PBbRajNTptJrgZSqv/5afG7Bhv8BT3XPDHKGUfW0zJWx3sK2aMG2JpbQkM6sERIkVf2C73TSbaml2CILvbTHmIDvx8mJj/gVhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPa/OnWI5etMhGhs+sbFJAFGcc9JaCZRIGp1k+sMVbc=;
 b=aqsPKCG2DiIZz0vOxE0MvcYhNDN06Ke/wsmKOdW86xOZZVbzAxld2kLZ5rrpF78bXsMfOEFubb98AYmylvMv+R/N7miEo0KcVMev05EbKfz1QS1tl2yDsPk19i4lLukz+c+DPkzBZHdHdtGqCbrf20BceTtpUwvvOTIg93Rsr7zu/fADyDacV8F9A7rF2WYe/+X95g6i+qkFtcy0Y/tiSHtaPPK12KVdavLPoGrplBsAlJAeZaRYPQhOw0DN5V6O3/NpTuihfMAqXX9tnJfNb1bofy9H2cGUFInJmKSh2To7kLd4yKrhmtKMTCZ+HPYir1CVeMXovWA4o42boG83dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPa/OnWI5etMhGhs+sbFJAFGcc9JaCZRIGp1k+sMVbc=;
 b=O0A7+yQbghzkb83bTmUJeUcALyEB5I1EM2ZOCZ65fmeayRG4VsdWUb5V31MdPGuZFI7L3SiqXvogtEjGJQLUS4o8PmjG5uYIUGZM8MogFEjlzbcmVp2BReWsjbiqcNn46F9ljplz3pJLtfzLyBej7rtKAv+E1sTXgdW+/scY7rqC/3wSucF87T1YOexX9i9Ce8rpse/NXYSAg8AO2s7gHqmdStoB34uvGUS3VTDzQaUlVO/Q+mJUdhjZRQquRgF673Z5MgOoyFH7Ye4+Sae+u1HRqZMmh2ZEku/1GIhM4/rsXbnqAUvE1nLvOxwFF/2eBkRfw1L4h76ys1f1ux6cwA==
Received: from AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::22)
 by PAVPR10MB7492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 01:16:12 +0000
Received: from AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdbb:7a2f:9fe6:2198]) by AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdbb:7a2f:9fe6:2198%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 01:16:12 +0000
From: "Dong, Zhi Bin" <ZhiBin.Dong@siemens.com>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"developerdong@qq.com" <developerdong@qq.com>
Subject: Re: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping acl
Thread-Topic: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping
 acl
Thread-Index: AQHbAAwmElACTbF+KkKcfmsrFLEx/LJKef4AgAQvySA=
Date: Mon, 9 Sep 2024 01:16:12 +0000
Message-ID: 
 <AS8PR10MB7497B136CDCA6B9C9A434957ED992@AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM>
References: <tencent_EE69D05C78693B4A0913E07D06A7CF6A2609@qq.com>
 <d96b13c0d1891878bdea3e6a46bc33c14759579e.camel@siemens.com>
In-Reply-To: <d96b13c0d1891878bdea3e6a46bc33c14759579e.camel@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=35866ccf-d5dd-4b36-9279-f7176ce863e9;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-09-09T01:09:36Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7497:EE_|PAVPR10MB7492:EE_
x-ms-office365-filtering-correlation-id: 4d1f6a25-e9c3-4a2a-a279-08dcd06cfeb7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?O2SaGIWRZb8p0yqp2uyadFA9uiapxSW0qO/CpWtXTeU9X005uml6z4znzu?=
 =?iso-8859-1?Q?qQZMPoSpLa61GRWFtRx007x//RoM6uVKQmfnS/6jxc67ZURV8IpcsEqCVK?=
 =?iso-8859-1?Q?OvFBxkvMk8FSbhJ0L9kYUcvb8jCTaxFA/IH6nIomhmoEsoElU+AOSkDvIW?=
 =?iso-8859-1?Q?NcDBM/iRkZW3tjedKszP9UW//zD1X4wTBNQiEMjcwZi9byURZLjDN7rTMW?=
 =?iso-8859-1?Q?7revVfYu3N3IeFrXn0SeBXhK1NAYLhwdl7InpZUmmfDdmDtxHq8Dupgdah?=
 =?iso-8859-1?Q?zGQugBEdNf1pJeWNnVvhs/aYvFllRuoCW3JXOQMeykQml/w5D08Oxc3i/d?=
 =?iso-8859-1?Q?9iBdf2gnLxbUXgnoxUvZKZaQbYbxcTbq1x8BVfglp3UyPh3pkLZ6j+CdTR?=
 =?iso-8859-1?Q?CN/NJMAwygjTD+83hhzcCrEo5Ez4J/uMCq9L6OxiaZ5nPBTjRJ55H20IIC?=
 =?iso-8859-1?Q?/nn+421VIWKUXjgg+NN0aWbI0W4IHjQSeLOdw+myYNk8g6kba96awmMTfy?=
 =?iso-8859-1?Q?kjv4f2r2E1XPGeVP2ln0Zs1MZLqpouRwj/j35tq12BlbN7vMC4kF506SbU?=
 =?iso-8859-1?Q?LGHV34D1dOcrItC5Da5UsWafMcviUtNNl3PxzlUTfufz5wXIpilhSBJ09P?=
 =?iso-8859-1?Q?94E9aStP1qpKaPQbsAvuv9k1ri/3CrkYDjgTPcFfZEGKys2794bTOxhcT/?=
 =?iso-8859-1?Q?/vY8uyK2GklzFDzUeovD6aEJuwYAYaOnJItV3Hwvr1bO1QTa8QYbl25HL5?=
 =?iso-8859-1?Q?NbX2clLjIh5EmMjaKj3tHAdaor6MPwwBWgZ9epXMw7LSb8f9hTsg7Zpd82?=
 =?iso-8859-1?Q?b/YEfMugQBN1EXM9Dp9udqFXXHlKVFCeoAHor8ArIxEAfVCKoBImDJ54Mp?=
 =?iso-8859-1?Q?nXotusSNaCwBNAYDgxtHHXOlaQTrrF6WFQ1BHNKQaOlx908NRcp5Sa/xRg?=
 =?iso-8859-1?Q?g/gungi5adzfGlffkDYTBo34xc0IC1hK8HERtgXG6Q0surst6qRrAIJCkz?=
 =?iso-8859-1?Q?FQ05V+J5H7Q7lg5vnvKY82Pu/kkQUYl0UuKxw9XmjjYB9ePIWisQJR1jxj?=
 =?iso-8859-1?Q?NSTgww03wN+TvJBuVVgcItpdLyBgt4VbYOpshK4BOOfbcTIdI639p//D4L?=
 =?iso-8859-1?Q?LF/YlDBIlSBU1q7nU1OAkQQIYHs0Qtxnf26e8ciXN+QmH/82ne2lKNWKKg?=
 =?iso-8859-1?Q?tbYYa/PvE9/Vmj23yenID5oB4IAzvvrWDJajRh0ouc/8y/ZambeThp3Nhy?=
 =?iso-8859-1?Q?4AV6b1mfl8NQKwimC7kru6qd5/oT8gHgHEWTyjVAiuTuQFum9/GrChz2TB?=
 =?iso-8859-1?Q?eGvFKQcx2ExkBL1MQoljeQbAyHoWpSpyi4nLMu/Qv9zWswVCVRQ9qt1JW8?=
 =?iso-8859-1?Q?VwTG5m3CjKns68bWRgAKy7UmvwPyY/GYydsFwB2C4Ermg1KZa/5/0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?BnYCflAhJCEBBQHC0j7Pe0sE7PcAJZXSRR9BkhvrraaZAJ5sNslZ9mVQQF?=
 =?iso-8859-1?Q?i8pn5oHME1q96Vrb7Tts0ZXXJ6OoyEgumAaJ8K26Ixfh/Q8GqCxcP1kvGZ?=
 =?iso-8859-1?Q?OI72gFYy8ra8o4wM+rGP+j1WzrbYCiG5b5bX49zwXtgVTspY/Kw4qw6/9Z?=
 =?iso-8859-1?Q?8mwSBr2H14pUnRkINSiAhTMDTrNFNNAoJvFFCzmGzlUjy/YuQCIfRb3RGL?=
 =?iso-8859-1?Q?coL68NCZPnlIshR2iuD3alYVnmdW6O+xo7hieil11lMq65yQy1oiR830sK?=
 =?iso-8859-1?Q?KnuOt+ZbcXTJIl4ygXJaaWdiEeuofgFSBjoZjeeQpZejHUAZsTanKhTy0u?=
 =?iso-8859-1?Q?N96HyJABa6PL34bcZETmjH5wQDTomd05hAg/vcHz+pYqDnrNuqrZJwPbUG?=
 =?iso-8859-1?Q?FVZxWuT/3XbawtPXwBjuIU8YJWWPrpf6f2jlCkkP89cIp/oTkp3BlEk+2l?=
 =?iso-8859-1?Q?yW6331rAtW2mD4YLuzrJ2VJ/4B8raMSPxeRrSYRmhzMOA7oeHz0WkVlfB0?=
 =?iso-8859-1?Q?tx14QuytVWUV0eeYJTW7c/v2guStK8xwBD44MWRj1e+8ez6lq/YPKvv2e4?=
 =?iso-8859-1?Q?lC2F41hai+bWvqITyN1WqcR+2hBJhmpo13sFLC0erPi4S2/cvRYYVVBgGu?=
 =?iso-8859-1?Q?Zygdw/uKGXqojrwoYKoX1LHPUpSmMuTwQSYDBGsodg62ykvfHmsGDROW29?=
 =?iso-8859-1?Q?FpSSdlD1QSEELPWD2PTxc2YqpZcVdT3b+g3gB0RdbHjnr6Lu0gUZx93tGh?=
 =?iso-8859-1?Q?OOEFzEb3/oJ28eXX4XzHvbp3lfAvJAL04A/VmMU8wSmUNlJDCXpm8ZgzuI?=
 =?iso-8859-1?Q?YBTiYlhlQMligESdLhqNLlIoJKfFWrleQtWBPGuJF/OSAX2H+HoM9SuB18?=
 =?iso-8859-1?Q?x0WCK89+qMxWL7eyVPo4FbwqNt9AB3OrfXH9qATU2hg21yZiOBk+B4XuoQ?=
 =?iso-8859-1?Q?UMAFay4Ae+11X8VV8ADvHRmSnybUB0Lx6DNg7Zwc4KsVXLp/I+mkZ3BvSF?=
 =?iso-8859-1?Q?qSzQHs40k9cLE26+F/o6zN/ty+1zytzi8yR52Eq0WGvQll2MvqDM/qF2cf?=
 =?iso-8859-1?Q?FZjRCmbVb5JgKR55E4LwN4NjgIahBay0gZCYFwAtiQM2f6mVkf61P0e5Eg?=
 =?iso-8859-1?Q?alXPaku/rKSXaHZNIiuP/GUlB0RmoukW/FucrLKZpmKiPo/96qnn4NwaJH?=
 =?iso-8859-1?Q?mL9HQbht+LgmvFdVTXpWR+6unu+XP2fPU8TA3OnGaJTpv6UNUc04XfoZ3I?=
 =?iso-8859-1?Q?FQg4+5mhafxuvY2DpbERjcJkpou+qVjt94A7D5oA+Ntw+7XfPPBbsqBgKJ?=
 =?iso-8859-1?Q?0PXV0CxeqFjdsXcAWpxKl9XC6ohBq6AgkS1oHVQzIe3m1AB0UCPPbVjZIf?=
 =?iso-8859-1?Q?j+4a8o1K18cnn6q+91vwqBr4S81TWxcExv4CKhQhrz9OCi7Xf8x/Dc3Y37?=
 =?iso-8859-1?Q?smGbKMCSKUnfK6rQsPjhdxx3cvBmKlRTfr4d+dwt5t4DCuwzp1jfJbPTwl?=
 =?iso-8859-1?Q?Uu6lACvXnEWp/rslonSOEOyQCuhYH2P9Dyx8onhV/gu/KWfBvb3/wnrJHZ?=
 =?iso-8859-1?Q?VlQ++5+PNXk0l/sq+gnS89IXKbwl6RCJvsUjs2Rgpg2VtK5dKa2YDirMS9?=
 =?iso-8859-1?Q?0w2wOKZ4mnG6MxwJphonGRlIDv31QSLnaP?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7497.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1f6a25-e9c3-4a2a-a279-08dcd06cfeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 01:16:12.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OygDpIld67ctFO3qppf4oQj78ISWjxtwi4cgWXANrsbmm6+F8EgVLCyF3jsnoIwBBD5HNwKdm0UsVo4CB7ujkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7492
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Sep 2024 08:58:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16883


> -----Original Message-----
> From: Moessbauer, Felix (T CED OES-DE) <felix.moessbauer@siemens.com>
> Sent: Friday, September 6, 2024 5:14 PM
> To: cip-dev@lists.cip-project.org; developerdong@qq.com
> Cc: Dong, Zhi Bin (DI FA CTR SVC&AI CN) <ZhiBin.Dong@siemens.com>
> Subject: Re: [isar-cip-core][PATCH] refactor(squashfs): prompt for droppi=
ng acl
>
> On Fri, 2024-09-06 at 11:22 +0800, developerdong@qq.com wrote:
> > From: Zhibin Dong <zhibin.dong@siemens.com>
> >
> > Because squashfs does not support ACL, a prompt is needed when the
> > squashed path contains ACL.
>
> Hi!
>
> I would rather say "issue a warning in case a squashed path contains an A=
CL".
>
> >
> > Signed-off-by: Zhibin Dong <zhibin.dong@siemens.com>
> > ---
> >  classes/squashfs.bbclass | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass index
> > b39be0c..fc4c5d7 100644
> > --- a/classes/squashfs.bbclass
> > +++ b/classes/squashfs.bbclass
> > @@ -1,10 +1,11 @@
> >  #
> >  # CIP Core, generic profile
> >  #
> > -# Copyright (c) Siemens AG, 2021-2023
> > +# Copyright (c) Siemens AG, 2021-2024
> >  #
> >  # Authors:
> >  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > +#  Zhibin Dong <zhibin.dong@siemens.com>
> >  #
> >  # SPDX-License-Identifier: MIT
> >  #
> > @@ -20,7 +21,7 @@ def get_free_mem():
> >          pass
> >      return 4*1024*1024*1024  # 4G
> >
> > -IMAGER_INSTALL:squashfs +=3D "squashfs-tools"
> > +IMAGER_INSTALL:squashfs +=3D "squashfs-tools acl"
> >
> >  SQUASHFS_EXCLUDE_DIRS ?=3D ""
> >  SQUASHFS_CONTENT ?=3D "${PP_ROOTFS}"
> > @@ -45,6 +46,23 @@ python __anonymous() {
> >  IMAGE_CMD:squashfs[depends] =3D "${PN}:do_transform_template"
> >  IMAGE_CMD:squashfs[vardepsexclude] +=3D "SQUASHFS_CREATION_LIMITS"
> >  IMAGE_CMD:squashfs() {
> > +    acl_paths=3D$(${SUDO_CHROOT} /usr/bin/getfacl -R -s -p
> > '${SQUASHFS_CONTENT}' | grep '^# file:' | awk '{print $3}' | sed
> > 's|${SQUASHFS_CONTENT}/||')
>
> This check looks really costly, as it operates on each and every file in =
the rootfs.

Yes, but compared to mksquashfs, the cost may be acceptable.

>
> I'm wondering if we can get the same information from mksquashfs itself. =
Also, if
> POSIX ACLs are supported depends on the squashfs version. There is some
> upstream work [1] going on to add ACL support, but I don't know what alre=
ady has
> been integrated.

mksquashfs obviously is a better place to do the check, but I didn't find a=
ny way to do this in mksquashfs.
From the latest kernel doc, squashfs still does not support ACL:
https://www.kernel.org/doc/html/latest/filesystems/squashfs.html

>
> [1]https://lore.kerne/
> l.org%2Fall%2Fcover.1548406694.git.geliangtang%40gmail.com%2F&data=3D05%7=
C
> 02%7CZhiBin.Dong%40siemens.com%7C1ebf539a652047cd0be308dcce542e52%
> 7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638612108143304541%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DoApst5i%2BMPDINwgkhM
> %2B5mHF69%2B0yZPlO0oqRXRmjVbU%3D&reserved=3D0
>
> Felix
>
> > +    include_acl_paths=3D""
> > +    for path in ${acl_paths}; do
> > +        exclude=3Dfalse
> > +        for dir in ${SQUASHFS_EXCLUDE_DIRS}; do
> > +            if [ "${path#${dir}/}" !=3D "${path}" ]; then
> > +                exclude=3Dtrue
> > +                break
> > +            fi
> > +        done
> > +        if [ "${exclude}" =3D false ]; then
> > +            include_acl_paths=3D"${include_acl_paths} ${path}"
> > +        fi
> > +    done
> > +    if [ -n "${include_acl_paths}" ]; then
> > +        bbwarn "The ACL of following paths under ${SQUASHFS_CONTENT}
> > will be ignored by mksquashfs: ${include_acl_paths}"
> > +    fi
> >      ${SUDO_CHROOT} /bin/mksquashfs \
> >          '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
> >          -noappend ${SQUASHFS_CREATION_LIMITS}
> > ${SQUASHFS_CREATION_ARGS}
>
> --
> Siemens AG, Technology
> Linux Expert Center
>


