Return-Path: <SRS0=ReVN=C2=lists.cip-project.org=bounce+64572+5459+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E8C43461
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:07:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9EE2080C
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 03:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ob80Je/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9EE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5459+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V54mYY4521723xOVmV47itR5; Wed, 16 Sep 2020 20:07:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.7413.1600312040749838402
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2020 20:07:21 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08H37J6b002118; Thu, 17 Sep 2020 12:07:19 +0900
X-Iguazu-Qid: 34tKGq3o3OGItXvZlv
X-Iguazu-QSIG: v=2; s=0; t=1600312038; q=34tKGq3o3OGItXvZlv; m=etzC2ARU8r20MuwZlQ3VKtwxM5JJqcZoP44/Jn9v5jQ=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 08H37IR3007927;
	Thu, 17 Sep 2020 12:07:18 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08H37IR7012558
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:07:18 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08H37Inu020793
	for <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2020 12:07:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2aO7Nv5pHm4R21nvNUKhnwcYe93C2AhIcDs63r22iYgMFWtHbZ2Pnh2KvQ8OCOSgrDyy5VqBZiZ/002mGblfYAnU4pHdd57iUk0qk0eFvHCl1mw+I5RbuYAW+dTgDW9D1O2QjPOPyOM06JRYONzBbGh03LTqBzk8HxhakgWnEHiR2BfDWQKaGVdu5MON+Vb3I8ICOYE1b/47bBMYhCJqh/NFccu/dBo3YrVo5lHaF3AjpF6TU6fn0Nn46qKe0uESjvVoWFT8H34PWnfDeylD154c55LZbd6y9ySaxebFHR9xOd2xwR4SY8Ri/f84YY0glaF394UGD96bkgUUzN9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueGyL+QPqBs99niSPazqU7kWiA8Ym06RIt/RnJJsywM=;
 b=XL0FWrrommNpyc5tY7k7FjZ4q+tRJraHCu1WC8eHmTyl3Qyr73dvW3y6Ekj3uDsUw0Ic0p6AhHAXN1KyO1eW48bh7dewHBmAhvVivk5sbzvgeOZHTE/33jIYKloR8kOq/eTcmrzvt9D6LqKEWpaUFoNzoYjgG4UscUUBMNPs/pAObV0Kk2sYHCCalKqBlnfUJw4LtSkj6/Q0emNxaD6EvH64poX7G+92k9csQRfr36KgvEcOy9QYjjRBAXU1l9qDSPIpystZSOjzOPq0HVB4Ib2GERVlTWqngW0jRjSYoevX3spezTTL7rffmdm7p9MrAv8HyOFRFTh+gN1Em2iWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <Venkata.Pyla@toshiba-tsip.com>
CC: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-core:deby 3/3] aide-static: enable aide to build statically
Thread-Topic: [cip-core:deby 3/3] aide-static: enable aide to build statically
Thread-Index: AQHWi2u7Bq91YSv130i6HTuq+TwtbqlsKMyw
Date: Thu, 17 Sep 2020 03:07:14 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053DB7C2804F51BC5E1D822D03E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
 <20200915142345.179-4-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-4-venkata.pyla@toshiba-tsip.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dde3009-a3aa-415c-689b-08d85ab6c79f
x-ms-traffictypediagnostic: OSBPR01MB4166:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB41664B51CEDD87F93FF2C632D03E0@OSBPR01MB4166.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHyrfwpwtFoYQWj3PmlhUlcGFB7TnlcpDXZ2JHxpbQDsZT0SBWYTzZprTDXwoeFG/NLZEpcSM3Yu6n+YzIKDOUxj1gSG4EGPAm5C/1hW669y4QPkcBLGTrxDLWTsjqrxXLOoaTQmvIwUpdeVontCUxfZOvxknv4kKBa0zRExwRh5BaM1WJxVm9Lxd9Q92fq3kyVcKQP0/jNW/8nTcu2N0v4OULlj1GDbSdNuK88Y2odjrdy/4eiuISGsSLREWFFsbvnjekps+Jd08Z+KG1YQ2W1rGLR1Tq2F/EKzCgFeBQzy7Kvald/LslKpTSnGQrmYeWWHKMx8VCsbmu3n+3rPW4bYfkzwi9um6+OIW+0rO1HPK8jbIhHUE1514J9TviEn
x-ms-exchange-antispam-messagedata: xxO3c4Tn5pZW3DSOqRWx53brRHjRYquAQK16n5turR/f+DKjrfTcHNBTWT5lJAr4uo6c1yXSyCmlp19H6UpARPusYNeR77jg/J51AHuC9ZWQvJbj5mPln4ugZbMsGuWXlVwd2df4mfV+fUBJ9rBY0VX1Op5EnnlgcissCl/nG3HhsXFauCkp9ctQLurmCkatxfb7GBcS7LiPvb68SV9LR1/gO2dxgeSLzT3PGS5jixtVVT1Ap3zjbH4eEF1Lbhm5K2VzEcLWyhSynNp7W/+ujJGyxlh2v8E/FubC5Aat3qk1ULlAsTeum/lkqQ2PBuJ/3IrZJJjb0NRRtcEi4NfNRkuA5BZ20My5BXh/ywSteZ0qim9QTS0dIgbw6mmZne9iTcyQpjsOfdK9tORpX0q1Zs3vF0nUBv4yk/n9xmgUEaF6462BKj8KtSSEzJtFa5XwMkTo4BU0d2NnarBMx6PLH3XE7XT6dJFxiuYJPhGwOIQKHd+ETp5V1eMEB5WOdnE5XpGKdrMuCNgCCB+eS3HbAkE0A0GrGBaZS8jZcve0E3eFyFhRajo0GvGqvgluFt/d1/Ibo8WmLGhhVf6epBRVoEm94l3ugUQuFH17FvP4kZ1Qm1tQmBlVyHy70nPNyPtiYV/F+vPXgfQ21+oiK12XNQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dde3009-a3aa-415c-689b-08d85ab6c79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 03:07:15.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6TpVUwQJTKE0NH3DRubPRvYIrTSP9MU8FzteEaxmAkwZs2raQ076KZpzTzUSTG56i59HJt3L0gdhel9vuJSEDw6WsC4bNhgwKyfClGmbQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4166
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jVDClMaNRBCzoNPkHz8Zk2z4x4520388AA=
Content-Type: multipart/mixed; boundary="4ZtiC2qNbLKDf19ha1mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600312041;
 bh=HazwaQii8PK1/if1ReitHJqXxyPiHmhdaByN1Ae++2k=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ob80Je/OQoV7w/40X26rKMZgUKs2PwhkUp0Of4xb87xC1B1BUz0peW5CZRi6scFOArM
 4ek1rVsGU+c7CKyunp6HnE1/D+q+vfu0X61V++TNCxiBAcD0GpARfuVEWP0dMGfTY+eeB
 20bCZIGVLJ3tBLfxJTfVgG6btVJC3o6i0sk=

--4ZtiC2qNbLKDf19ha1mq
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks, it looks good.
Perhaps you can  write in the commit id what is the effect in size compared=
 to not using static compilation.
Please send me a merge request

> -----Original Message-----
> From: venkata.pyla@toshiba-tsip.com <venkata.pyla@toshiba-tsip.com>
> Sent: Tuesday, September 15, 2020 11:24 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) <daniel.sangorrin@toshiba.co.jp>
> Cc: pyla venkata(=1B$B#T#S#I#P=1B(B) <Venkata.Pyla@toshiba-tsip.com>; cip=
-dev@lists.cip-project.org
> Subject: [cip-core:deby 3/3] aide-static: enable aide to build statically
>=20
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>=20
> To build aide statically, its dependencies also compile staticalliy, so a=
ll aide dependent library packages enabled static compiling in an
> include file and added to the layer configuration.
>=20
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  meta-cip-security/conf/include/aide-static-libs.inc | 10 ++++++++++
>  meta-cip-security/conf/layer.conf                   |  2 ++
>  2 files changed, 12 insertions(+)
>  create mode 100644 meta-cip-security/conf/include/aide-static-libs.inc
>=20
> diff --git a/meta-cip-security/conf/include/aide-static-libs.inc b/meta-c=
ip-security/conf/include/aide-static-libs.inc
> new file mode 100644
> index 0000000..1dc4374
> --- /dev/null
> +++ b/meta-cip-security/conf/include/aide-static-libs.inc
> @@ -0,0 +1,10 @@
> +DISABLE_STATIC ?=3D " --disable-static"
> +
> +# aide dependencies to build statically DISABLE_STATIC_pn-aide =3D " "
> +DISABLE_STATIC_pn-libgpg-error =3D " "
> +DISABLE_STATIC_pn-libmhash =3D " "
> +DISABLE_STATIC_pn-attr =3D " "
> +DISABLE_STATIC_pn-acl =3D " "
> +DISABLE_STATIC_pn-libpcre =3D " "
> +EXTRA_OECONF_append_pn-aide =3D " --without-audit"
> diff --git a/meta-cip-security/conf/layer.conf b/meta-cip-security/conf/l=
ayer.conf
> index b015436..158d75c 100644
> --- a/meta-cip-security/conf/layer.conf
> +++ b/meta-cip-security/conf/layer.conf
> @@ -16,3 +16,5 @@ LAYERVERSION_cip-security =3D "1"
>  LAYERDEPENDS_cip-security =3D "debian"
>=20
>  LAYERSERIES_COMPAT_cip-security =3D "warrior"
> +
> +require conf/include/aide-static-libs.inc
> --
> 2.27.0.windows.1
>=20
> The information contained in this e-mail message and in any attachments/a=
nnexure/appendices is confidential to the recipient and may
> contain privileged information.
> If you are not the intended recipient, please notify the sender and delet=
e the message along with any
> attachments/annexure/appendices. You should not disclose, copy or otherwi=
se use the information contained in the message or any
> annexure. Any views expressed in this e-mail are those of the individual =
sender except where the sender specifically states them to be
> the views of Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
>=20
> Although this transmission and any attachments are believed to be free of=
 any virus or other defect that might affect any computer
> system into which it is received and opened, it is the responsibility of =
the recipient to ensure that it is virus free and no responsibility is
> accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or dam=
age arising in any way from its use.


--4ZtiC2qNbLKDf19ha1mq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5459): https://lists.cip-project.org/g/cip-dev/message=
/5459
Mute This Topic: https://lists.cip-project.org/mt/76865934/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4ZtiC2qNbLKDf19ha1mq--
