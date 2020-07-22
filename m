Return-Path: <SRS0=yBkX=BB=lists.cip-project.org=bounce+64572+4956+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D9C433E2
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 07:26:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1DF20714
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 07:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w6SlfkzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1DF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4956+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9pnvYY4521723xHfq4AK3SgB; Wed, 22 Jul 2020 00:26:06 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.13636.1595402763648394199
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 00:26:05 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 06M7Px39026816; Wed, 22 Jul 2020 16:25:59 +0900
X-Iguazu-Qid: 2wHI1scKHrBXRYQIGi
X-Iguazu-QSIG: v=2; s=0; t=1595402759; q=2wHI1scKHrBXRYQIGi; m=OTlK9jQKcLg5Hp8G5IKgNPS8RT5r0QzBlwMEkx5DG7o=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 06M7Pw8Y009062;
	Wed, 22 Jul 2020 16:25:58 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06M7PvRN020772;
	Wed, 22 Jul 2020 16:25:58 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06M7PvhA028872;
	Wed, 22 Jul 2020 16:25:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjL2CBTwUdO4kdY3RKu9TQoqyu29p2d+NrVJ3ZoBdjEyIdSxlh2pAK5UJDaGmQtCZ+7QKII/KWSt0XI8nUufMNF68aLq0PB8jF7uHw3CU9YiXf3eQUr9lbBbCi0tXA4pUVsI+Em2DskRyg8EicHgSF5asTO2cx0sf/kZMd7cfhwSKn4tlw6bMX6jiu3ZlMsiyyzNEG4LpvzF4qP7aPmjMkDheNEBFcwpSb8L+ZOHaHcx3rAceFEUDyPvd66a2DOss7adQpF/wMNb451yYMSoAfWpmdC8XSyv/NDZRJSiOzSyBl9RuY+NI4L+CjzDPnNF+wdAKIGfAcGQqanXYLLlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7XLAlQ72yw4V5Kvx2M/mdMH+xKa3ljmOwZFCiYzjgc=;
 b=dtXHOiA7GC3ynPDVNuZG0KteLyMvmcJDxxXfJBOF2POx9VHJdRG6Ts8LOnvfVJ0WkHZOkXuayiDid3KwWdWEQEi/YLZsoVHKAn2jJvmHaTvrnkC/BUhbpmjG8/021lthb8pn4Vl4VpS5dMDVktAomLki9acMLFfZ8Pm9tNQNPA9YFg73TWiA+cfS1pg64ESXbUvXvFzZGLmm0h/qNdlw3g9aQ/0QKQ6Cf+vT/lLCmXZMp4Q7nVJlwXiac0EFJURAMEVyduJM8femoJc78rFG9L+lWoI/ghwwWXQAx3mX5wxMAR19XqT076i1tQPISmGlS2CAKh6bJqwDJUPwnbU3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Topic: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Index: AQHWX/OmhX5UQNU+wkWK0hIB6uUEs6kTMaVi
Date: Wed, 22 Jul 2020 07:25:52 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>,<5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
In-Reply-To: <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a69e1878-045c-4072-4178-08d82e10772d
x-ms-traffictypediagnostic: OSBPR01MB1815:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB181560F00597342393B3EF86D0790@OSBPR01MB1815.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gu9nVum6B8yYXVYW479ubeamYE44/lmhUG13wUA1kOSBlH7UPhqVFdJ0NBYGortwqV8C5KN2jpe9TtcPAZfocE147QlMThIeqnZBWdxDDCWKt3rtQSnVV6vdAfaBXJedJVB21kVIGyai8xWFE+gU0NGZ7k1ApWPqziqMvSnwxzjbm/b+5ERWdmctyfB5//GFi/MNMGcp+beKehcQ0Q1SEj7hJ/Po/fRunefLpz0RAbCEShTMnWjNoogGhmRndPlMlMFjWtGTvsrtMTRGWOFTWGM8wajcohnO8AlDpfGoSTfRJAZ0Ast5FSnlSx6xJQjtKOl9dYg8pTKIp61eb1vO/jrUmfPJ+O5CDRdahhqrcFit0HtxvhVuOS451vaYEQ4qZixHeuDGAiw3oNXUzBBCqaygBlOt92FbtJ/KUIajnZRkwzeIuk9Gn/FjEKWoonv6htM/0trKOr4XBc3kdvK25Zy3oS0CJkMwtDGOYDas8u87Fa9MGMnX86cXyiP7zi+3
x-ms-exchange-antispam-messagedata: xX3plJole2mwenI9XfiUmxli6ahicA1gGugK3+QiOM+jKpKDWb+w2rInvwI4h2CXkQF369ctFegkRH9lLcBm8fvADn+Qyf5DgDTknctafN/0oRqksg3D2pcNtmsNBXLAt6dlygH9C0fbST/x1sLdce1Cp6qXSDZJJzCshHRWPUDhqTPY5CHGbYuRE2qsVl0wVonir2hjb3uiQOSWB5FFDPHJ7uRy5wRGc4Fw17XN4MpIA57kRwcoQ9WHABs10I4ysMtVz5JfeE/gl5hOEf/G8AEZmjS3/3FgrJdcl+fRGriYDr4gTwpVOanMqeJjOavRSnSz0CZ2Qr/3GJWdsESW26MIhq4W9N1/7p1DFGoAOiOtuTfkHd/EcyloJqRMoShmTl4zBg8aExlPWWs2YzukfESIrFVNNFCb4q0O8BmWwLJRjZYkRfh3rtu84lNETZ5nUhsVVEYOUsCApjzm2POrjBTc8NUbVYjwYdpd8Gy/DiE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69e1878-045c-4072-4178-08d82e10772d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:25:52.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Hr7oCew1gEVUplY4QmhGGT3ZAXku+0Gyf2q4xX2ftbUgA752oX2mDIld+A1trknMqj8dMwxclV8n8Q0kOO1MtgjoM2h/aNZlOjiNRMhkDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1815
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: d4Gu2S9KO95zFZGBFODroJIDx4520388AA=
Content-Type: multipart/mixed; boundary="T3p7g5r3peKzdlOsJ7mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595402766;
 bh=mKoK1paEdnDveEWZUrwguMovTlQhabHbkFOWd325ZZI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=w6SlfkzD+HiRPTtZlTA3LmOqHGQ9bvjXeNAtw+tLi+Z46tqQlJNr1ohmAkLn+TLlBDM
 Of2iXSzMFc1l/x4UIktb60PyRLaiFeQbFt3+RVrxi1CT4y1qW0YjzN81KHJ5O4qOYIw+4
 Gkat6Rk1gq15RrGBGM67NGxBhFuP2R1lbLk=

--T3p7g5r3peKzdlOsJ7mx
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

________________________________________=0A=
From: Jan Kiszka <jan.kiszka@siemens.com>=0A=
Sent: Wednesday, July 22, 2020 3:44 PM=0A=
To: cip-dev@lists.cip-project.org; sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =
=1B$B%@%K%(%k=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B); iwamatsu nobuhiro(=1B$B4d>>=
=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B)=0A=
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt laye=
r=0A=
=0A=
On 21.07.20 14:42, Daniel Sangorrin wrote:=0A=
> having an opt-tests layer makes it easier to see what=0A=
> tests are installed, and allows creating images without=0A=
> them as well=0A=
=0A=
JAN:=0A=
"Having ... as well."=0A=
=0A=
Does this obsolete=0A=
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests/7,=
=0A=
where I just commented on?=0A=
=0A=
DANIEL: Maybe you can apply Iwamatsu-san merge request first, and I will pr=
epare a new patch on top of that to avoid confusion.=0A=
=0A=
Thanks,=0A=
Daniel=0A=
=0A=
>=0A=
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
> ---=0A=
>   .gitlab-ci.yml                                |  8 ++++----=0A=
>   README.md                                     |  4 ++++=0A=
>   opt-tests.yml                                 | 19 +++++++++++++++++++=
=0A=
>   recipes-core/customizations/customizations.bb |  5 ++---=0A=
>   recipes-core/images/cip-core-image.bb         |  3 +--=0A=
>   5 files changed, 30 insertions(+), 9 deletions(-)=0A=
>   create mode 100644 opt-tests.yml=0A=
>=0A=
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml=0A=
> index 6f1dc91..90eec1f 100644=0A=
> --- a/.gitlab-ci.yml=0A=
> +++ b/.gitlab-ci.yml=0A=
> @@ -13,17 +13,17 @@ all:=0A=
>       - export AWS_ACCESS_KEY_ID=3D$AWS_ACCESS_KEY_ID=0A=
>       - export AWS_SECRET_ACCESS_KEY=3D$AWS_SECRET_ACCESS_KEY=0A=
>=0A=
> -    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-i=
mg.yml=0A=
> +    - kas build kas.yml:board-simatic-ipc227e.yml:opt-tests.yml:opt-rt.y=
ml:opt-targz-img.yml=0A=
>       - scripts/deploy-cip-core.sh buster simatic-ipc227e=0A=
>=0A=
>       - sudo rm -rf build/tmp=0A=
> -    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml=0A=
> +    - kas build kas.yml:board-bbb.yml:opt-tests.yml:opt-rt.yml:opt-targz=
-img.yml=0A=
>       - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb=0A=
>=0A=
>       - sudo rm -rf build/tmp=0A=
> -    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml=0A=
> +    - kas build kas.yml:board-iwg20m.yml:opt-tests.yml:opt-rt.yml:opt-ta=
rgz-img.yml=0A=
>       - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-c=
a.dtb=0A=
>=0A=
>       - sudo rm -rf build/tmp=0A=
> -    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml=0A=
> +    - kas build kas.yml:board-rzg2m.yml:opt-tests.yml:opt-rt.yml:opt-tar=
gz-img.yml=0A=
>       - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-h=
ihope-rzg2m-ex.dtb=0A=
> diff --git a/README.md b/README.md=0A=
> index bbad1a0..7339396 100644=0A=
> --- a/README.md=0A=
> +++ b/README.md=0A=
> @@ -25,6 +25,10 @@ this:=0A=
>=0A=
>   This image can be run using `start-qemu.sh x86`.=0A=
>=0A=
> +If you want to include the testing layer add ':opt-tests.yml' like this=
=0A=
=0A=
Wording: It's not a testing layer, it's "test packages", no?=0A=
=0A=
> +=0A=
> +    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-tests.yml=
=0A=
> +=0A=
>   The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`.=
 In=0A=
>   order to build the image with the PREEMPT-RT kernel, append `:opt-rt.ym=
l` to=0A=
>   the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead =
of 4.19.=0A=
> diff --git a/opt-tests.yml b/opt-tests.yml=0A=
> new file mode 100644=0A=
> index 0000000..a1f431d=0A=
> --- /dev/null=0A=
> +++ b/opt-tests.yml=0A=
> @@ -0,0 +1,19 @@=0A=
> +#=0A=
> +# CIP Core, generic profile=0A=
> +#=0A=
> +# Copyright (c) Toshiba corp., 2020=0A=
> +#=0A=
> +# Authors:=0A=
> +#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
> +#=0A=
> +# SPDX-License-Identifier: MIT=0A=
> +#=0A=
> +=0A=
> +header:=0A=
> +  version: 8=0A=
> +=0A=
> +local_conf_header:=0A=
> +  tests: |=0A=
> +    IMAGE_INSTALL +=3D "ltp-full"=0A=
> +    IMAGE_PREINSTALL +=3D "rt-tests stress-ng"=0A=
=0A=
This, in fact, has some benefit over a separate image in that it would=0A=
also allow to make the security image testable by appending the snippet=0A=
=0A=
> +=0A=
=0A=
No extra line at EOF, please.=0A=
=0A=
> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core=
/customizations/customizations.bb=0A=
> index 38881fb..cbd6daf 100644=0A=
> --- a/recipes-core/customizations/customizations.bb=0A=
> +++ b/recipes-core/customizations/customizations.bb=0A=
> @@ -11,7 +11,7 @@=0A=
>=0A=
>   inherit dpkg-raw=0A=
>=0A=
> -DESCRIPTION =3D "CIP Core image demo & test customizations"=0A=
> +DESCRIPTION =3D "CIP Core image demo customizations"=0A=
=0A=
Maybe "reference customizations" - typically, you will replace this=0A=
package for a real product with a, well, product specific customization.=0A=
=0A=
>=0A=
>   SRC_URI =3D " \=0A=
>       file://postinst \=0A=
> @@ -21,8 +21,7 @@ SRC_URI =3D " \=0A=
>   DEPENDS +=3D "sshd-regen-keys"=0A=
>=0A=
>   DEBIAN_DEPENDS =3D " \=0A=
> -    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-=
keys, \=0A=
> -    rt-tests, stress-ng"=0A=
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-=
keys"=0A=
>=0A=
>   do_install() {=0A=
>       install -v -d ${D}/etc/network/interfaces.d=0A=
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/=
cip-core-image.bb=0A=
> index 9ee4b25..188c714 100644=0A=
> --- a/recipes-core/images/cip-core-image.bb=0A=
> +++ b/recipes-core/images/cip-core-image.bb=0A=
> @@ -15,5 +15,4 @@ ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} descr=
ibe --tags --dirty --always=0A=
>   DESCRIPTION =3D "CIP Core image"=0A=
>=0A=
>   IMAGE_INSTALL +=3D "customizations"=0A=
> -# for cip-testing=0A=
> -IMAGE_INSTALL +=3D "ltp-full"=0A=
> +=0A=
=0A=
No extra line at EOF, please.=0A=
=0A=
Jan=0A=
=0A=
--=0A=
Siemens AG, Corporate Technology, CT RDA IOT SES-DE=0A=
Corporate Competence Center Embedded Linux=0A=

--T3p7g5r3peKzdlOsJ7mx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4956): https://lists.cip-project.org/g/cip-dev/message=
/4956
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--T3p7g5r3peKzdlOsJ7mx--
