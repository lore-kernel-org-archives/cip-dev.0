Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C502C43334
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:01:21 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.111])
 by mx.groups.io with SMTP id smtpd.web10.24772.1658134878121648586
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:01:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Yxjp7Oal;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.111,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYfwAVqZywRkF3ZIQTMf2oVBA2+pJYfaQGW8D3UZhamuKzPW99Zr+ruEWRUGtWnPOAj84CNyrJ8MzkP+r7dbeSGovbnla+tddqlxIY/Qa81kDdwrJINmBtHPLrZ1wVd6obvjOR8LHOohfPXMvaUNG6vLJ0vUhuZvQlpS9j4P48/g2vw3W5/f17o4/BB6c1pLs0iHqt0Gmgn1CxO+fzCcZhXlqX1aO/MFoHcVBb4WzBZDnI1ezxGgK4MDL6x5k/rg79uW05JDhXCh1Xwy0gBIJKA/NTXUEA3pWSD4BDrFf8D0fZrFzwRdbnvvv42cuIokgmNBJCoRmWj5lrCoKXvLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tChsuVmrQz+L/Mjar7U3ARhRAztqXkgQlKmTUeaT8oE=;
 b=O6hPfa0VC+aF78nwZ2JAXm2BS6Y7tGufmd3JYjPYP+OPwv1a0NgLtPTeeFj5wzh/64GLcIzfEe0FaZmuTbmz7/jHuFNFnkoV04iJwS0N3uxLC1thI+qtK5U0Rm6/7PgQtUtV+RtlHOPfiXo5p2Z06/v7pb6sPVoIg54jGQHLnQLFYgD0VMofJ0CWYxEogz5sJTDYbclAqVX1UwW3Rhr3AlUHNVPiHPgLeHuUCM9LTRg3dXJAhdp4BYe0Lwyaa0w1ePMyNWedMm9ZGNVlrJc0LLLlm0amK9O+sSrl368q1QH9hfzb8vqRvJdI79JIG6SX+7ZtlW34wK2ZIahrzyMhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tChsuVmrQz+L/Mjar7U3ARhRAztqXkgQlKmTUeaT8oE=;
 b=Yxjp7OalvBojKYTaCwY72N6iT9kZjssV/1Brsi1oJs4jV0pgZz5VA2QFSPudRg7rQGGvmmJt+ak/5xYBX4V3m/2Ea9pXKp/Tff92ED+TWWuRDrXx8J+Zf8tsUQD/YopB3GhCSa8gbo71lidSwSw0neBQRfDvZ9sbIth1Jgtvpcs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB6145.jpnprd01.prod.outlook.com (2603:1096:604:b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 09:01:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 09:01:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Topic: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Thread-Index: AQHYmB4DoFtie5laUESOxGXECxlswK2A1G6AgAA7jkCAApJA8IAANacAgAABQrA=
Date: Mon, 18 Jul 2022 09:01:13 +0000
Message-ID: 
 <OS0PR01MB592241DF97B065A84C7FB941868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
 <20220716105351.GB18467@duo.ucw.cz>
 <TYCPR01MB5933D3A6DA16E05E80D87DBE868A9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <OS0PR01MB592291A21992DB4B471AB5E4868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YtUf5HKy9MGPd8i8@pollux.denx.de>
In-Reply-To: <YtUf5HKy9MGPd8i8@pollux.denx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73b9d6d0-4ced-49bb-31ad-08da689c113b
x-ms-traffictypediagnostic: OS0PR01MB6145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lzx/tYr4/0jtRfPbqa077ZfS7IanXrEmcDjbCByn9L31hG9Ba6btC2LGd4tEXyAf+jOrE3oLU6pzI0CfQskdn4+hE0I3JMnqkIvV2FsjCNVWMyjkdGKTj3FKFKEuipowa17aBGndtjtjSqEH1Z2m87L23Upkt8WiBKVlXOSPBlOkVPrBllVwnavZXoG+ZpxMmfBi3CW1C2rBqE7zSGirxEZnAav9ccLdKfTsIE43//fzPA/laRy+F5nPVp2lnlrYC6I3GBm7BIHr806lgVEE06b/HvVZxHX4Qr22QJjgTvKiiEu7n8lKPAt3PXbT8FTMPMT4XCHMLGmwrLQryIQh1s19xfxgUi8OuFwcv+u5KY3G4RJ7XIrwgpmy0rL+bKqBqdc93EGgyN53hPFI90UH33euLV0GIWC9OC+Yi0FFR99pX7mrj0Y7e5KuLVja8xKKLkAhmla8DZw1SMXlI+eyzcWy8NRf7oKe/qrZWtX4dMmLmw6fo1NTCEMiUy1Xdn83LbagPQA+1rzSbfFO2TbOFSde+QC1fmU64+jLki+UEpleVOnls7wu0xQxbUtHVZR9Zkc1IyhPN8BeWPzOKLmZcPKyBXF+nyp9GttRsQwRzNHD0dqC+vAhQ81E+soIkU8ybHH6FtdG0NubBuHwzQEGqNyWLgKJP1murHSrNWQvHYj1gK53EnTOoQBqFn/C5aOuKAvf/92vJdCxt+Blej0HCUSQFy6EV1k/GUhCUFiyI4KVLSCq119avagSgVX5jOAd4oxrhyOdXtMj68IQe+o5kfBWVwbpxfLFdyR1wDu+SHQ3+X+g7x7/mRxd3O1AeKhD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(38100700002)(71200400001)(83380400001)(478600001)(38070700005)(7696005)(41300700001)(6506007)(9686003)(6916009)(107886003)(26005)(316002)(186003)(76116006)(4326008)(55016003)(66946007)(5660300002)(66556008)(8936002)(66476007)(8676002)(66446008)(64756008)(52536014)(86362001)(33656002)(2906002)(54906003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?O2bQyz8njW2IK2WSHZX/9H7Tg+ZkUMRVE7lT3O+RYbtATDDaVJhi8UTvf5?=
 =?iso-8859-1?Q?UR/gcqhATuw/nPVsgvI7ZQLuFRLQhyQ4GVS8rBYZleYgvS5RouXLdnnBVu?=
 =?iso-8859-1?Q?RZBRa9jwVYGR/gbs8v4vqK+ty2KfcxNtlXbxnUSS2QjhIsd97lkcq0So7j?=
 =?iso-8859-1?Q?+XZ/X/Ql+a8MxvaxmXAThYE6EbWHTt62KvKL55qB3ALXfP8Z2Fwpke33nz?=
 =?iso-8859-1?Q?yrWTvsaH0cHge/iuyOof606UZ3WTo/pXv3ujhTM5AQdKZ6HX1gjWVHkajJ?=
 =?iso-8859-1?Q?aWKxNxjtuvfiHx8Dp81cu0jOdye0eHxVSsTkROLNh3DmCZnt08hWQ5Kui5?=
 =?iso-8859-1?Q?UGed5B4oqdRp7P/afcUs9VjPTKqLvgyfKW8gRPFg4iIuj0AqWC31TIbVb/?=
 =?iso-8859-1?Q?60C50bqanyhpXOpLSHLqfhVtD3XIxxL60ynyiGwOLR8s3GrU0QASzW+iLs?=
 =?iso-8859-1?Q?bAxEXQRWFAdAnYaAwMrBjfX7wZdnxMY6AghUehor2UT535KJfZ/W3FR2xU?=
 =?iso-8859-1?Q?/JuKRsh7WY7Yqj/0Vvcy2eY7rg4/fvVI8qMvqJkwMBILxaJ3VAHryl3k3M?=
 =?iso-8859-1?Q?MdhIyDQuTsWKs8Rc8S7a6iFfuYTzam9rEKSeg+wZh3yRwyofa99ounuoha?=
 =?iso-8859-1?Q?XvQfrLn9S1AntHvkQfsh7uR7300YcoHZwW+DCa/j40BrMdJqqgYzCUfbEb?=
 =?iso-8859-1?Q?YFBJ7EoWsROsBoGl73GZAKAzNPE3tZNnrpyFh7OHnKNlH1/rM19UFv5T7i?=
 =?iso-8859-1?Q?kgsQjt+VW5IxKlZP9thm0ozvuiHoyfcroYnqoj1unqfwwVwPmdXqEQLJwS?=
 =?iso-8859-1?Q?470jrtle6RNh2Ui/unvObCYL5GhD8c0XXtB607zUh1NcHJnKExGPcvuZDI?=
 =?iso-8859-1?Q?DC/s0LQII2ioVL2+vXIhV4d44kLb7ihWuoqOTM7ZimQLhQ+xdMUSZNRajn?=
 =?iso-8859-1?Q?VMlIXTStxIrFCviXLFsn8PO90QOGLpN28QMPMCzVSRxaxfvZx+EexUznw4?=
 =?iso-8859-1?Q?SiwnOEBbZiOvxIVZd55O8fRYejptx1zoSodHgWOm7NxMA6lO2ovtTf5joT?=
 =?iso-8859-1?Q?eym69yxDTZTPVyOBMDmwqvorSigBcOkrKf45ovZqp/uz73jvoskEmjRY7h?=
 =?iso-8859-1?Q?kFwgA3+dmU+uBRMoLFZqriS4ydrn9c58hgzYPl51Y3bnD1Ms50Lq9c6v4b?=
 =?iso-8859-1?Q?tbg6/yrP6piDYSp5tJO+dfY91OTbeUGZeWLNP2M9mx1+4ARXyNY4O7sLyk?=
 =?iso-8859-1?Q?KNz5JVLVO+w8gC5s1lR/yUR0U4nPcstc2GoPyZtAXSj2ENCT81dnchaIG2?=
 =?iso-8859-1?Q?aBz473mnKZXi2y2fTwQhF7bNbb0uZ4bPLs7wlI/sn72gxicpEiBDILBiGb?=
 =?iso-8859-1?Q?8/4DGBnUxGy7/0WERUSaG6mJ5fyoiCTbr45suA2bM+G9cQAY0GzQWSFdJn?=
 =?iso-8859-1?Q?27uRnWGhjRMVWy+0J9BMU/suw4ib8MbPHyIrzMkapVfipXaIpAjOalids1?=
 =?iso-8859-1?Q?ylnJZT+WZFK+8zefvFom8SPigDRYaQRkZpbQDQGRIg9nBCidg1IyMfy0Zl?=
 =?iso-8859-1?Q?nvgfT26RJMMgqr5nFHL84cPSiPG98uEfHxLCIUA+fv+eqpJN2AvOMI/gZp?=
 =?iso-8859-1?Q?3vG1vofvCEuQdLdY17B6s333nAt8roQkLAewVz1sEWod4P0KIxheGTkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 73b9d6d0-4ced-49bb-31ad-08da689c113b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 09:01:13.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 9crKM2iwFrwe4d6togRTsKKu1dS45Vkf6JxchusNpAdJCMqETbuYbPDFcw5tQcHfQcD3CPtyuWBtcKqsapTFXj/Yg2N5rp/M2UgW2WXJRsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8844

> Subject: Re: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers:
> Add TSU driver for RZ/G2L
>=20
> Hi!
>=20
> > > > > commit 673c68bd48390dad01f7d17670de3e33b60860ac upstream.
> > > > >
> > > > > The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that
> > > > > measures the temperature inside the LSI.
> > > > >
> > > > > The thermal sensor in this unit measures temperatures in the
> > > > > range from
> > > > > ???40 degree Celsius to 125 degree Celsius with an accuracy of
> ??3=B0C.
> > > > > The TSU repeats measurement at 20 microseconds intervals and
> > > > > automatically updates the results of measurement.
> > > > >
> > > > > The TSU has no interrupts as well as no external pins.
> > > > >
> > > > > This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.
> > > >
> > > > > +#define TSU_SS_CONV_RUNNING	BIT(0)
> > > > > +
> > > > > +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> > > > > +#define MCELSIUS(temp)		((temp) *
> MILLIDEGREE_PER_DEGREE)
> > > > > +#define TS_CODE_CAP_TIMES	8	/* Capture  times */
> > > >
> > > > Two spaces, plus "capture times" does not really explain much.
> > >
> > > OK, will fix the 2 spaces. For " capture times" Basically we need to
> > > read TSU_SAD register eight times consecutively at 20 microseconds
> interval.
> > >
> > > I will try to drop the comment /* Capture  times */ from mainline,
> > > if it does not really explain the intention.
> >
> > Or
> >
> > What about "Total number of ADC data samples"? Does it better?
> > Please let me know.
>=20
> Yes, that sounds better.

OK, will upstream these changes.

Thanks and regards,
Biju



