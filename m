Return-Path: <SRS0=MrVU=C2=lists.cip-project.org=bounce+64572+5458+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E1C43461
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:06:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1952078D
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BXxBvZOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1952078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5458+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5sgsYY4521723xnxVhjb83Yf; Wed, 16 Sep 2020 20:06:04 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.7313.1600311960446181489
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2020 20:06:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08H35xk7030590; Thu, 17 Sep 2020 12:05:59 +0900
X-Iguazu-Qid: 34tKSwRU9Sq277YTEt
X-Iguazu-QSIG: v=2; s=0; t=1600311958; q=34tKSwRU9Sq277YTEt; m=LdWvE8AtJjo6reHOQ6rm3PImNSaP3+RKRSGBS76u9w8=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 08H35wfh001916;
	Thu, 17 Sep 2020 12:05:58 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08H35wAE012046
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:05:58 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08H35wZN019935
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:05:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7/0ethDLsGnikbCjQj9o3X4kOh6Kbb81E4lPRmzMQO9aTf6mTVM1DSceRcK+VPObK6BE3UT3sNhwcSwdqdTep+upGMeuuRP0GOlk8IYsTIqgUmEgEcnwUlIhusme01/b/USRdehSJ+mDJVh425UiIOYNhXvkk++r7IIN8JMMy/Qk12OApwgmh3K1uX16xU82pnul/roDoAWy3AIvxl7NX+m/qgGVUUosZbKO2PdFgHPM+CObT+MgZFAow6gbeO6mcMktpsDxFKtAimJMGY7Z5LhWBSiHh6n52SmGzvqwTIy9p2nF9rcyAq8TYlEM9BP/wtsd0uxn4F/CRJQj9VOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JePKmM2zlTCXZIPqPyVjsDB2Kgv65/8iwktc++374Ns=;
 b=fEVHxpzYR9UJ9pXpNM4y9iigyIL13J/Di7N3QUpu15wMpSXGZqvoNd+1dilRLWD1TdjDDFQqyK8HhVjsj4yUpHYhf9uSCrufRCQHgqk/GbLk4fYQe+8OW8bNY0SrhP7zwsGPu2GSXxITMgbQ1orl9QST8dRWPTuv6Acfh0SA6/DC7wqSyE3Sy0qnAxaP42lfOq+Mrgf/4EPUWzT6r0VRvmrcTOB3CL+9UBj0imUMVL0DnH/vm7glzyUWzUvXiI9AqHZy9vCdzGiHq6C8wBCuUU3rLRnx2qL3XXElVcyezafb/eoiufi4hswJj6PXSI+NQB/SStpG8BwNYdtjnGGnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>
CC: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-core:deby 1/3] cip-security: Create new layer for cip security
Thread-Topic: [cip-core:deby 1/3] cip-security: Create new layer for cip
 security
Thread-Index: AQHWi2u5g+r7QizZWkeHH9x1nf/C1alsJ9EA
Date: Thu, 17 Sep 2020 03:05:56 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205319021F908B4D20A055B7D03E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
 <20200915142345.179-2-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-2-venkata.pyla@toshiba-tsip.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae711579-d6bf-4392-2758-08d85ab69887
x-ms-traffictypediagnostic: OSBPR01MB4166:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB4166906FE57B5E05AA54C46DD03E0@OSBPR01MB4166.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uw/oeLx2jLuI7fGuwvOTkmGrC6umYcCFPFIN7ijovS4cLFlbo2PmGrH8tK2oCLsy/Ead6p19XVTlqTQhubYCLstnQ6PzJo0k115rdsvxpxFauJbdpCmvdYyWtJ6VK4E+9Ovp2zngteyThdIfIBcZ7iQCtC63A+wittm8MykyyTKOZSKLZy5sUmSanyCc/9P9Q/5gGlVK/IuNROFG1KVo+oC78Ici3g2Iw7HZtnimHSq/u7MS/RDQC7gBTOAR9cKijPG0eFuk1BQo+Ym9OyLaQPy68WZkIJ5CB4NYxiYmZLNLGcMPEis+2x9zHZVOconhT4JL0CET9gEdkvQXAMbMQz62h+4H08O+EJEJ8kDts9aBnLq32gwS8CVarRoEsIjH
x-ms-exchange-antispam-messagedata: L8OR7kO7X4iduJaP+SAyegIxCY3aZcbgHY5SUw7BCVxZdI8d3mkauhoN7f7wmfqaRZIbsO+2IgzQWhqhxR+vGZnR5ZzI9BB3VPaSF9uxTZIAXqCl41v8Vfjl1nCuhPSbZik5BV+K87IKU44k/Ku4t86YKwr7lWtdYzZsh9OZumUMBcfmjYSu09kAg9grM23DBhYmKijM9/XgQWv0Rjy3mKzbVwJLxnzW1GsjDl588k25q660IZcq+uWCq42yecvieHKxJwUB5wD9DSgHJbTbUlMoB++z96pwsTVc0Ia5d8oOycBUqJdqmPUe0uNNaT+MfS3nL+hc62WxPwpMsflGAW50n1eRUOYOEX1JKGkOvCmzyG3obWo4IzUHx1H8IA06EYR8yvGr68evuVfKnttP+zUmpGeYhIUMIlOybwS/Zd2BUb3zCPzWtoxiZGkYlaBc4NmCc9CgHOEA+qiw+ri1BHIsQr/b27pFu4Wcuc4poZfomlbMwzX0BKf+jXZJslscffOSBKPuN/JgBCN8B/RuZ62x3/SkJQe+hRplaYQvvDj8IvTb9oaE0bUixCqEgHa65YYSxROCHFa/k7n1GMzthiscxhjYcUXkVUzYNwq675+3NcsAtEoKcv1/5mm+/FE3zkdVMrCAofXOXb+bPLMFOg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae711579-d6bf-4392-2758-08d85ab69887
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 03:05:56.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYk7Qwgw3Jt8s8xB7M7bpwQfO9pT9Hu+7gKDaWTdudB55niwbw81e32ELnm9etCHNdUjhZpBdkASrnTCnmxGV4Vins5EnQE4QiilK0iINTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4166
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6uHzDjKjQcQTKBctKSwA8yrkx4520388AA=
Content-Type: multipart/mixed; boundary="Adf7b1sMWrnJGU3fiFJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600311964;
 bh=VNiWMGD1LII+AJ9/pdPGkqErj5vmRmgsQl02Ok/wP4c=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BXxBvZOTB8Tr2xmIbymTKsauLvUxbeXf0/IfQoglF+h1ds15FMWMO6buM/8dAmmfoQE
 /EJaNLWlVHm6PSJ2IVPIXw9KbjgeGdDBqXFNhW0zDNXxSrtLCrRIliarEbfN+6+9zhVAw
 y7MogBXIhyn7FRUxyVYSU5u9v+NW5i5J/o0=

--Adf7b1sMWrnJGU3fiFJ8
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks, it looks good
Please send me a merge request

> -----Original Message-----
> From: venkata.pyla@toshiba-tsip.com <venkata.pyla@toshiba-tsip.com>
> Sent: Tuesday, September 15, 2020 11:24 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) <daniel.sangorrin@toshiba.co.jp>
> Cc: pyla venkata(=1B$B#T#S#I#P=1B(B) <Venkata.Pyla@toshiba-tsip.com>; cip=
-dev@lists.cip-project.org
> Subject: [cip-core:deby 1/3] cip-security: Create new layer for cip secur=
ity
>=20
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>=20
> This layer enables security packages and default configurations
> required to evaluate IEC62443-4-2 assessment
>=20
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  README.md                         |  5 +++++
>  kas/opt/security.yml              | 32 +++++++++++++++++++++++++++++++
>  meta-cip-security/conf/layer.conf | 18 +++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 kas/opt/security.yml
>  create mode 100644 meta-cip-security/conf/layer.conf
>=20
> diff --git a/README.md b/README.md
> index f90e040..f59dd0c 100644
> --- a/README.md
> +++ b/README.md
> @@ -88,3 +88,8 @@ LTP test image for QEMU arm64 / hihope-rzg2m
>=20
>      $ ./scripts/kas-build.sh kas/board/qemuarm64.yml:kas/opt/deby.yml:ka=
s/opt/dhcp.yml:kas/opt/ltp.yml
>=20
> +Create Security image for QEMU x86-64
> +-------------------------------------
> +
> +    $ ./scripts/kas-build.sh kas/board/qemux86-64.yml:kas/opt/deby.yml:k=
as/opt/security.yml
> +
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> new file mode 100644
> index 0000000..e84290c
> --- /dev/null
> +++ b/kas/opt/security.yml
> @@ -0,0 +1,32 @@
> +#
> +# CIP Core tiny profile with Security
> +# packages and configuration
> +#
> +# Copyright (c) 2019 TOSHIBA Corp.
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +    version: 8
> +
> +repos:
> +    meta-cip-security:
> +       layers:
> +          meta-cip-security:
> +
> +local_conf_header:
> +  security: |
> +    DISTRO_FEATURES_append +=3D " pam"
> +    CORE_IMAGE_EXTRA_INSTALL +=3D " \
> +                                 aide aide-common \
> +                                 openssl openssl-bin \
> +                                 openssh openssh-misc \
> +                                 chrony chronyc \
> +                                 libpam pam-plugin-cracklib pam-plugin-t=
ally2 \
> +                                 syslog-ng \
> +                                 acl \
> +                                 sudo \
> +                                 auditd \
> +                                 util-linux \
> +                                 "
> diff --git a/meta-cip-security/conf/layer.conf b/meta-cip-security/conf/l=
ayer.conf
> new file mode 100644
> index 0000000..b015436
> --- /dev/null
> +++ b/meta-cip-security/conf/layer.conf
> @@ -0,0 +1,18 @@
> +# We have a conf and classes directory, add to BBPATH
> +BBPATH =3D. "${LAYERDIR}:"
> +
> +# We have recipes-* directories, add to BBFILES
> +BBFILES +=3D "${LAYERDIR}/recipes-*/*/*.bb \
> +            ${LAYERDIR}/recipes-*/*/*.bbappend"
> +
> +BBFILE_COLLECTIONS +=3D "cip-security"
> +BBFILE_PATTERN_cip-security =3D "^${LAYERDIR}/"
> +BBFILE_PRIORITY_cip-security =3D "11"
> +
> +# This should only be incremented on significant changes that will
> +# cause compatibility issues with other layers
> +LAYERVERSION_cip-security =3D "1"
> +
> +LAYERDEPENDS_cip-security =3D "debian"
> +
> +LAYERSERIES_COMPAT_cip-security =3D "warrior"
> --
> 2.27.0.windows.1
>=20
> The information contained in this e-mail message and in any
> attachments/annexure/appendices is confidential to the
> recipient and may contain privileged information.
> If you are not the intended recipient, please notify the
> sender and delete the message along with any
> attachments/annexure/appendices. You should not disclose,
> copy or otherwise use the information contained in the
> message or any annexure. Any views expressed in this e-mail
> are those of the individual sender except where the sender
> specifically states them to be the views of
> Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
>=20
> Although this transmission and any attachments are believed to be
> free of any virus or other defect that might affect any computer
> system into which it is received and opened, it is the responsibility
> of the recipient to ensure that it is virus free and no responsibility
> is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> damage arising in any way from its use.


--Adf7b1sMWrnJGU3fiFJ8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5458): https://lists.cip-project.org/g/cip-dev/message=
/5458
Mute This Topic: https://lists.cip-project.org/mt/76865927/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Adf7b1sMWrnJGU3fiFJ8--
