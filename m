Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DF1C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 09:26:22 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.130])
 by mx.groups.io with SMTP id smtpd.web11.4550.1658827579322098702
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 02:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nThaiwGi;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.130,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfLgcCylivGglZC4lk3wmLE9bby/AMKHhx7ThFR3XgTGiKzmO+Cd8NUNjVJ1xR1oqz7+9i+VAKj6JmPYzqZLF8JoMSTbazNoFfsXo3fEvxxxbJEjwh/DRbF90OaObH6nq16AX6CETGB62MgGeEwCPc1jPbPKfeseZhTD7uaYMQO4Mw192LanCUhf99qxoorCCLP2brx3zg27lS27J2isVYLL+JQc5N6XEjkffhGmyvP8dvlxuRPplFriivnq8VKY8HQwJoRQaPxz6lWORyZSdcVpkWrzYgaZfJ6XN0Rto1aJb29Dn3NIKJxeuswQNKgVj5cINhxYsULxTH3Ufd7iMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm9CtVU9BFZMYkpbPnMfNCEvdsZTurI4LDC7e6y3eug=;
 b=meg5tHdwvh9SPV51HSAvjrl2j6QC2P4a6SOMn+QdJHw3hiHnBsRoMTg0/RxpgPk/waMAZ3FevQWg2C2hFDP3K6Ix4HDAcTkLVtX9qXmDMz9vXd9WB1fOm4RN6+MAd2f+oUkNA3SSntdqB2MymBvSu3bhY6CX6u6isW94arO0QIgQBKeJAAxEY5E4m+R0pJ3nIwnS+PoO2xcGBlXyi3aXYRordiEJXDwU/a1CXxUpslSD/8zm+2gc7g+epcgHp0gDqmCcOtiLPZXtcJwRxkVe+DdbQxCcf6jlfviPcMebsUSsBRI9k0vIfhNDmPZZygkW2/fgxLgzZsqLi/NqOMZ3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm9CtVU9BFZMYkpbPnMfNCEvdsZTurI4LDC7e6y3eug=;
 b=nThaiwGipkJep1Gj/clhXdtDbqEG3efotSMmFEXYMNFJzwklycUdyZspmgFlLSs/e5kkrkUhl6ph+IcNvVIdQ8oVWfNLnzaZIwZooEgQxTZC6aXL+o9nlWm1lug2B7bHAdNz5KXys0Uooed6XFlLmMfS/8dzshOAP/nqh7RQMKo=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYAPR01MB6393.jpnprd01.prod.outlook.com (2603:1096:400:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 09:26:15 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::440d:b27b:6bbb:3d27%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:26:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 16/24] ASoC: sh: rz-ssi: Release the
 DMA channels in rz_ssi_probe() error path
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 16/24] ASoC: sh: rz-ssi: Release the
 DMA channels in rz_ssi_probe() error path
Thread-Index: AQHYoGmY0lHa8iddjEOuMqlkEVF75a2QYmIA
Date: Tue, 26 Jul 2022 09:26:15 +0000
Message-ID: 
 <TYCPR01MB5933C8A2CFF17CFD2336AF8086949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-17-biju.das.jz@bp.renesas.com>
 <20220725210031.GB2302@duo.ucw.cz>
In-Reply-To: <20220725210031.GB2302@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6a9d384-6ed4-4413-f2b7-08da6ee8e357
x-ms-traffictypediagnostic: TYAPR01MB6393:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5UG184QRhhNpYevoSGnOfqifrjvwzuXfCc9XnM7B1vtEAgESKnPKWQlDIGEMdeQP4evVXHiHObTQxNq9avaKjChCZcprD8TLTlsS2+ILiUB5VSJgC1vvRPuKfppVSOkqc5KLgpaBQdrMsC4t9hauSNqXwtB/MeX4OTrXMtpM0GaY2V6zDofkCCn0DHLJRAeIfyXflLpGtHp/DxkEBmXCsaMubnlLLZ40Y465H0lIeJcMsodi20Gg6T9/PVkkQyI4aSF3zpy90I3a8AxsTxQKYhsXsnegToiGd1bm0kAdjb756Vp8gKR6h1Rw3hXAthRRJJNDKt5t8orM22AtiHqZQ9hEFB6/8jDP+Z2+l2xOBaBVDK00SKXHfqekhO/L6ZB/J70XnHsLmjaYXYlnFOtlPj2KlvvwI+jWZFF/OC9DSdYlaca014Q05Av8ALRNboV5VR4hntZXX/79wlA4R5Xv5FPqVzd/M5T7HyKvLU+VIOAGhPVcU9wPGEyW9by6jNjf7w9jhtC9YXI5tGnTAQ5AJ144M15CEc05X+EZEyrzWIdJJU35dgoyw9ehUwC2VTQB7chTgbsoDGDJrPHJpAor/Rr8ScJd/fBLcR5dh89Eef3RKhrpemkCQvsTGn1OaHD4hcGsD8XdQ2++NWO1S03M9nflIMO3+uQtycjPb+5mQAL74+hz2/t3wzYEmN2nXtZTBZnovNg+d3h1npQZouewCG3vvzqPROEbJ/+kewt5J+wxIAG0pzRkQHx2NGBaGCGcbzM6FMzwflIEAkbrtpCIAb4tAScIdk2TrOmX7FShUgc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(186003)(107886003)(64756008)(71200400001)(8676002)(76116006)(4326008)(66946007)(83380400001)(66476007)(66446008)(66556008)(54906003)(6916009)(9686003)(7696005)(6506007)(41300700001)(2906002)(26005)(33656002)(38070700005)(86362001)(38100700002)(122000001)(5660300002)(316002)(55016003)(52536014)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SMxmBM61dSPoqOmHnqGJ1DrrkD2z7ZSSuFIlHaXdoT1jWMUJ4eWMJyPPZT7N?=
 =?us-ascii?Q?psELnCUh0FAGowgupU3PlGaZ+Bo0BnD2eW80oDkfC5V1y76Se/s6Ll0EJ6YI?=
 =?us-ascii?Q?9n7L2VvGxu/QKDNVD9MBe17ZeuOdJ27SeoLF03a/6x9wlcKnSblJPyUN6DKt?=
 =?us-ascii?Q?1CCo2dEhyQlHgsS4E6X2ZKPWKdG3Bq1COZy5xl5B8iOQMYFcoKxvoryhxPjI?=
 =?us-ascii?Q?Fo44gvRPEdSSkdSPG4aBn9KxRPJRIYC1CtBLkMkADjUar7caBCCgUktQF9KQ?=
 =?us-ascii?Q?2orWvCly41dQD5t6P7Ox2Cu9xI2tg5jko/yhkbBbcCrscTNdOkCs1/O/gKQB?=
 =?us-ascii?Q?oJG+Ul3nxWrktbp1p4b61HK4PsKUXbRiwGwCK2APpOAs3Dr12zYTJqkEgRUL?=
 =?us-ascii?Q?XvKIQDkecvUPqShci091DbwG3ogJoTA8/oka/1TuQ/mcZTK2U7M/xFqNqXox?=
 =?us-ascii?Q?J1pqpo2m8GD1Os6QvTgZ0Rr43E5GNvYOAGRgwGsnSVCB6qjIM9fncUHVgjAY?=
 =?us-ascii?Q?2y8WRjIvusgPgoFGADIU7qVGoqXIMoIOoNV44gQCgXHa1Gf1zUeT4zfZlzNE?=
 =?us-ascii?Q?Kgozky5/jtgryJ9WwE5hkYZFf2hqbIp3hHe6OKKLQCKl07uE+6SAbGoh6ufV?=
 =?us-ascii?Q?B4rvF7z2uB8BsstC8u+c9aFBZnOEjuhbOMOSg0D+1YkPJ2xkporzpAQga/cA?=
 =?us-ascii?Q?pwGqhmXDpmyLkG/6/rcZN7dr2Ql3sK6eMv4z3pBDNFkq2+CE5qB9hscOcE3I?=
 =?us-ascii?Q?Ja+x9rNQG4GlAPHW7SvQ4OFBEyatxo3QebG+YyzfohGwdTDcwRdFhOsmx/Cx?=
 =?us-ascii?Q?QDG8aD1/7PiehWtLlp3Hn5W1rHgduelXnZ0xU5GHmipq+6aCe+nbH0uTk7IF?=
 =?us-ascii?Q?jpHGD5etZGrowTmANdL0kkh6lOvLwYBVLAAk9oequNgnzVA6ESxfb5J0MQPX?=
 =?us-ascii?Q?tyyEkSagBbSdT47t0FOVgU0IBqrlbPeUXQ+3Dl8qUmIAiDZujTku516z70/x?=
 =?us-ascii?Q?5A32TaEz8iXLFIkaE7z3NcGSmoOTzk8R4678TuwkNQdGFlDDzTFzxSP8lyk2?=
 =?us-ascii?Q?D6L+PmTs41Us5v04+tLTa8a3rTmw0QIzmVGeIe74s2WpWjI8PjMBMID4zim6?=
 =?us-ascii?Q?BNO9ny7WDa5XYrFXueO6Tw4opHEOc9wzovx7kqI4DJB0fjZw0wUBhN1p//hW?=
 =?us-ascii?Q?x3LzemsMpVCf+MFm96OsUKuj+fheDhIdUE1YR85V5cd4ufc0edKSv1IHBsp9?=
 =?us-ascii?Q?VM95xAGgm/v/bpgmsCa0MbNsvgrP5Ui3uyepHnFgdpTiOG7RkUpNtxD7MIs3?=
 =?us-ascii?Q?PTMgVVlo5r6bLV2kUVxTEj/klYW//5mr+6DdVb1NHB8pDJml7EsIT63NZ8JV?=
 =?us-ascii?Q?TJAgtukjXD5OLR/5UQJ1PXnEQRkL/ohdXYvsmXWf1CIKjkfTuFhXQAjjzEOg?=
 =?us-ascii?Q?apoC971HfCgtMtcqm2he6M4muAhLbVssnC84ZTbULcWz1QSgkTqsYskjItn4?=
 =?us-ascii?Q?k99jtNzL8+HBDTeDbey48MV/Bkpii9Bks2SD2wxFI2m61mqR7WplsKANvpoT?=
 =?us-ascii?Q?+mqn0gvkEf4kOM9Q1TRpwB0Exv/L/9FUwHTq6+w8J0cMLT/i+FipgsHlthQg?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d6a9d384-6ed4-4413-f2b7-08da6ee8e357
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:26:15.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 pkiioEV8n1gyMY8YfLVBZPFDsJOBQDMeaKTSdcnAtfG4WFiwsRPKmXAG8H1Nhs2saI71YS81eUChn0SmF6/cTFq3eJkFrZdsgBcHAeTNcvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 09:26:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8927

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 16/24] ASoC: sh: rz-ssi:
> Release the DMA channels in rz_ssi_probe() error path
>=20
> Hi!
>=20
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > commit 767e6f26204d3f5406630e86b720d01818b8616d upstream.
> >
> > DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
> > never released in the error path apart from one place. This patch
> > fixes this issue by calling rz_ssi_release_dma_channels() in the error
> > path.
>=20
> I believe this is correct, but...
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -976,14 +976,18 @@ static int rz_ssi_probe(struct platform_device
> *pdev)
> > -	if (ssi->irq_int < 0)
> > +	if (ssi->irq_int < 0) {
> > +		rz_ssi_release_dma_channels(ssi);
> >  		return ssi->irq_int;
> > +	}
>=20
> > +	if (ret < 0) {
> > +		rz_ssi_release_dma_channels(ssi);
> >  		return dev_err_probe(&pdev->dev, ret,
> >  				     "irq request error (int_req)\n");
> > +	}
>=20
> >  	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > -	if (IS_ERR(ssi->rstc))
> > +	if (IS_ERR(ssi->rstc)) {
> > +		rz_ssi_release_dma_channels(ssi);
> >  		return PTR_ERR(ssi->rstc);
> > +	}
>=20
> I believe we have enough cases to use "goto cleanup" style to reduce
> code duplication.

OK.

>=20
> >  	if (ret < 0) {
> > +		rz_ssi_release_dma_channels(ssi);
> >  		pm_runtime_disable(ssi->dev);
> >  		reset_control_assert(ssi->rstc);
> >  		return dev_err_probe(ssi->dev, ret,
> "pm_runtime_resume_and_get
> > failed\n");
>=20
> Plus, we usually do cleanup in reverse order of init.
>=20

OK, Will fix this in mainline.

Cheers,
Biju

