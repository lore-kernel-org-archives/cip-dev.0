Return-Path: <SRS0=fGqQ=II=lists.cip-project.org=bounce+64572+6265+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD73C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:49:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D7464FCB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D7464FCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6265+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 64QiYY4521723xhDydF5i0V6; Wed, 10 Mar 2021 00:49:46 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.115])
 by mx.groups.io with SMTP id smtpd.web10.6105.1615366185467226082
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 00:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcaku/nprM0XDnjfR8bqtZrvDU37zWAV5j3vGgVl8vRBtAI7vt44QK+93t3YDcUD1wzS0b/k6B4Dn1Yi6NLYhMSOSxgptyL2vmXrN/DsSnLhxf3oIA0XqtL4a1VMXAYjmv74KGj8QmlAB6XvJEv/ALy40B5ahYA7agDDE8TG2tnoD+rbts9dAi/TbI69NwgBsxBZD9glQ6o8HXpPYRBc1vYnS7/hDE8K7EoDLjrze3BqipfSeiL/BaNoGSRvn94kn+/9iWOqNKecEUgHJ/dfJha1Qk/+R2q7zLX3XNhj0eNYs8dZyS1ndIwWzJRggUvrlXSFRqyWW/cEQCZx5WVesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVRLxKjD0huj5IwYivB2Biv69GkO0SIIAoYOs3ahvWs=;
 b=asKXcGPYas8BI7FZmklFh/9mSKMHLrm+K8jSHnL+wIyFfu/S0R1DldzzZ6zTKnxjqBInf0SoOguNC9SNsK5k/bfxBcr/nnsuT5DftgnDtf4keRzalD23498FKYibIHV+C762m81KRSdM/4+jZNL4oatmLe8DFDADS+crX/x52XsP2Vb1nTV+7DHZ7IFyc2bacwBcI5MsIXl823lb/2S6aBn9VRRcLu/v39Um1anpDRBt+jM+GniqCuOCaCETiVwX2q4nq8WHJxZyy367mFPCAIOzbw2vRdVyp1o2olRXP+8KiifVVDODmBZuPa3NsVVdUKL3qjvYCC3G1p+0hHkxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14)
 by OS3PR01MB6070.jpnprd01.prod.outlook.com (2603:1096:604:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 08:49:43 +0000
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede]) by OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede%4]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 08:49:43 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 14/40] media: i2c: imx219: Fix power sequence
Thread-Topic: [PATCH 4.19.y-cip 14/40] media: i2c: imx219: Fix power sequence
Thread-Index: AQHXFRxVRPXKDp06NUuw4RnkFImd4qp86hZQ
Date: Wed, 10 Mar 2021 08:49:41 +0000
Message-ID: 
 <OSAPR01MB4867AD2108C22C7F0C854CE2AA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309194219.GA7900@amd>
In-Reply-To: <20210309194219.GA7900@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05adfaab-0fc6-4d5d-9e08-08d8e3a172fc
x-ms-traffictypediagnostic: OS3PR01MB6070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS3PR01MB607098B63FF304AE98F7C407AA919@OS3PR01MB6070.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 XKzqmcawD3IzCozx72oh7ZcgGN/+9rZz3syg3zMmpAwmSeVPOUvG59zdQoAltNd2gUkQi2Ot+VvysWgnsWloG2uo57C7yKNEhTzwBnfraz+ivOFi6rQ5UxDZ2YtktTcrmLd2jCxE7/EpIkoipZS1b0IuEbTkzcR5vWAKdN0g0vRBWTcV1Nc66tLp/RMGKl4/VHcxsX2EId1BBpcs4llrujebgg+cfgXhORQGdp5wzrsdrWVyU2L074d2JvJyVw5vwNF47U8ICiS1PYWGXVkizWjNsIG+NU2Rm9vJkN1LFD3Bg7bCJH2tBXtKIKi4iK2y0hkYeTSuxKttdit13eQ6la2Se8qmgsiW1xAR5P4OjbGJzc2uWlDzkJ78zeJKyRuPmmx9NdlI/cPRTWtxNLOgvoe/4aKos+tyHzKmVe4XTC8NR1mldkDubw26/e1c2knHv4h9GD6SeT5witX9TFF5B0oIk9OE9FxnaOzLdJ94dq+uBin1+a++uC/qRdYa2MQDvuvpt7mgtES8GxTWP72jAhYubRqd3/ICvDdZmAk+4zsiOxe/efzvq4JHgpzVxno3FmUKdTLGWeZmJhVc0NUz+7GHxeUcjAV9SLhOL73UGuPe0T2RAveNK/GKcy01VhLh3ivDbWUwbBz0U/jeQn9J0A==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?IVUhZKg4EEhPxWoSKSpjMHUR3x/CtDnUoKtttwUxNh9vufTzSB9C5GdhEVpE?=
 =?us-ascii?Q?GMY5lhpBpoDfr4Yl7B7cwXBhBFfRCJUSZHkTwpD0Zj3MKPdxHP4piq6nRjCa?=
 =?us-ascii?Q?NTYWF54UwG9IBYVRBaLNSHMbaSgtpbz5J5jVE1cx/z2lGqbQSCtwCBGSfNqp?=
 =?us-ascii?Q?T+7CpWScv371S89TB4sAW8uGIAZbkkbvFdfQUQNhtnhYvjvvTmZaxaWsfIpk?=
 =?us-ascii?Q?pvK7lVqm9GGOmiZLOkVHfo8ZzPDgMZnjMYABDr8srR3lm55m+0fEgZhx4ZxK?=
 =?us-ascii?Q?7Md/rsORL7oRyciFf5O2ma7xEWKrlvpdZGrTzd1s0HOAKsK5+lQOldO71eF5?=
 =?us-ascii?Q?YVJUOI5q51+iVSgHJ6aIZESfm58ktWeMsB1nZF+IywT2A/Yk93jyhS74lLhK?=
 =?us-ascii?Q?rX02rUufMcs7T6D1M5Hyx6WhGA6oQNAeqNvCMnuYLlRCn5bUO81y+fVHjBbJ?=
 =?us-ascii?Q?DGo8D40c1gXSE1pnom8ik3+xtdaUmbQylydl7sI9NJgCn9aa4xUdl2Rga6Ez?=
 =?us-ascii?Q?jJzPPLhDS33QAlGI6c0HCkx068/RZApFVohc/f7UaYFKhfZM2db8R+yVt7eR?=
 =?us-ascii?Q?kQUquutAPbaCrNNR8BIbdWoh/tQAUqHouvru1zPbchh80MsMw8WOjwArZE/f?=
 =?us-ascii?Q?BEkml+wnQrmvYmfooGoYcFk2ubZJaiqbTmRvd6ZSu+TOkUM2gJqr/W2P4KKp?=
 =?us-ascii?Q?P29SwIe0D7vz7f3xXTCn9mazZlEpg43nTB+EPbHq5bfDeBDhk+3NH1G3anej?=
 =?us-ascii?Q?RAgyab0k8/RYM8d6rrCtoquALlKRz4weG28kQ+hLMQm/GR1OMAackiiKyUC1?=
 =?us-ascii?Q?P2UA/wFZd4Pi3BUsnadFry6PJb1VAMFnolWgo9H8Q7Et/ZrtuTJ86OS98enE?=
 =?us-ascii?Q?wVDInvwrz78mscUSXl9llaTABwOlKo5pytzurb7p5tZX2daA1c09RFxDbs+o?=
 =?us-ascii?Q?CG26RCOZJIx+ZtN4xkCXcoAo43k4rONXNe6SzEY1A8HMnjhZx0/Pp8Y1ZxMC?=
 =?us-ascii?Q?Pu8qOJO4kj4X4e2DjYvGodr4r/JlK8xEqT5PkCo/K5SqnPYrDX/TUivSBg82?=
 =?us-ascii?Q?2xx+LzO9BdOafQWbVNQ/RVE2mYjLz40p7KNZWptRyLI6IVOwYAGfENl9IOe1?=
 =?us-ascii?Q?rY/aUJyxWCT0TIjJZphr1/iC6N0dCng8M0vzGPSja3qluDjbH9li1/rwaZvy?=
 =?us-ascii?Q?u+aMJHjwZhtv+9ajEgSWcnw3fU/WGwVVQJiNofGxssqoq51AtcT5g5pYhCga?=
 =?us-ascii?Q?j4UuLiV7apj5fNZX+dTAASeODbjZchU+u/iQzuXJxaBHEQAht0NH0dI1xf7r?=
 =?us-ascii?Q?KncVFy0rfvoynpEijM7WjtxB?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4867.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05adfaab-0fc6-4d5d-9e08-08d8e3a172fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:49:41.0844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbMfWgUHJq91OsOKT+/IGMDGdclWosu3/RU8Vxlj7RDfFGOZW+RCt5zivskJSXrW4J8cj8cGvjq+12DHq2s9pWHagk1JSpuFPw2CK417nhoDonn/udicBjQiOsRR2dj8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6070
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vD6hb5oNEEvqzVvMxOrCbq4jx4520388AA=
Content-Type: multipart/mixed; boundary="JleFLLJtYk4pF5PyUMsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615366186;
 bh=GvbfNLL7T9VtG7CsajAQ6s+D0T2YIPjLxUf7AEnt/f8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=c/hNfnsifPid9ywKZGs4sBm+nUBtgFWOYNH/HdHPemu6GZNsT2JmYkuvfhLYlebenU8
 95L2JzzwGnmtJZBTSAyRPs1ce1X6Io5kRaPvL5O1j2QRjeNUtQIjHylC4j1qATILKi3Hb
 XfORNwTF0eaDKKe4UddbKU2IMgHyqY6ZgR0=

--JleFLLJtYk4pF5PyUMsO
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 09 March 2021 19:42
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 14/40] media: i2c: imx219: Fix power seque=
nce
>=20
> Hi!
>=20
> > With this commit the sensor is able to enter LP-11 mode during power up=
,
> > as expected by some CSI-2 controllers.
> >
> > [1] https://publiclab.org/system/images/photos/000/023/294/original/
> > RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/media/i2c/imx219.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index c67b2cf5c32c..f1ae93569542 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -1224,6 +1224,23 @@ static int imx219_probe(struct i2c_client *clien=
t)
> >  	/* Set default mode to max resolution */
> >  	imx219->mode =3D &supported_modes[0];
> >
> > +	/* sensor doesn't enter LP-11 state upon power up until and unless
> > +	 * streaming is started, so upon power up switch the modes to:
> > +	 * streaming -> standby
> > +	 */
>=20
> /*
>  * Sensor...
>=20
> would be the usual commment style.
>=20
Agreed, will have to fix up-stream.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JleFLLJtYk4pF5PyUMsO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6265): https://lists.cip-project.org/g/cip-dev/message=
/6265
Mute This Topic: https://lists.cip-project.org/mt/81205358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JleFLLJtYk4pF5PyUMsO--
