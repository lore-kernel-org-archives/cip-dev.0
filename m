Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247E3C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:45:52 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.114])
 by mx.groups.io with SMTP id smtpd.web09.5367.1666773944611234457
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 01:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=FeiYUjOv;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.114, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoNzpouqHmEQrt3i91w5OEFHPsIy5lbMbvnW1KsNgaXC3jB8chz+7FDtyLUfyDyp1Q2Ijlf1RPt/bB6nv96VuHdQ6mbtu0h9nwOtl7qRVHz6/lYueNkhSeJiU6Y6xfk/vo/+ob2u029A9uHGL9hg/BzxqXJjrtdetGOzy8ocpsNXqM2JZeDHXStQ63ZXanG7cWggdAbH+eOWsrxwvTjK0WMjHE5RrnM8cbhXzibUS+hSFWfPWBrnvKnzGfZ3Osiiy6tZJ5cFaJ5qCAyeHGZYie7903xJlYokdfod/rA7V6/1wlcjb3J7QLCX9V4o22Gv1nV5+01d/V5GojpOaXsLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T3aKmOnEGo4k1IEwn8uVOCRKb8Q+hJ06ihJvoCDnNI=;
 b=iTbsnDrVr1QpJbeZE7bgrhjNlWkVksZ6kaYzM5fbaRe59KuS3VToJm7AK9Yco870we4JIscvfRJyXB1rnnN2FjPjGNY+Y0q2u+6A4dUYq5O7TfxQ9Eg2JsZbS2mmrOaNNbGuZnhq19fyj3gD/RNc581BDy1jQ9IfKqF1E7LkNqd0NO6KgmhNgRbzsFD2Rm21CPY8Uz37s/jIVa/WZhKAEPVk4V5OVrK8VCzIgZJpj3qK8JNWM4MFdeuWCC0jvH4a5V0IIm9CkGx9Y4W9DdUBkq/iMfiRnKJGA0CGy61pBmR8AS1++EtSZwLziMt4cHvA1qa1qQhkb+3Nra/+Zm04gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T3aKmOnEGo4k1IEwn8uVOCRKb8Q+hJ06ihJvoCDnNI=;
 b=FeiYUjOvmJ7QQYXhhiDb5UHJtKa2l2Ojak3dVkS1KmzCdhroeCdJnC0tCaPm4YlqOELVMQdxwlSrYs8PbHf/XFQpMFujnWiIWobWt8D6BKMF3mSAXUQ9N8jI2e1MpsESXFW7PXZ7Yj13Z/P5XLoS7WlaiL3fr4RhBGHcan8nm+c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8660.jpnprd01.prod.outlook.com (2603:1096:400:159::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:45:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:45:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Thread-Topic: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Thread-Index: AQHY6H/i8MtUtEymhUWa3QL0gKf75q4gXFOAgAABJCA=
Date: Wed, 26 Oct 2022 08:45:40 +0000
Message-ID: 
 <OS0PR01MB5922F1B818A0CEC70E125EEA86309@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
 <20221026084055.GA13322@duo.ucw.cz>
In-Reply-To: <20221026084055.GA13322@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8660:EE_
x-ms-office365-filtering-correlation-id: 229e4832-6b79-40c3-45b6-08dab72e7620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DVSCcXOnLeIOk74lx0cWfgJN6X5a4ewAuqRc0Zkm0DzjekY0W+e2MfHRTjekg5myU+fBbUQzxluGTqw7fKDsEhmDHELk/6+mCFoGLyZig73akG2zEXG33ZV4QxkohXQXzMleNNzHrC2wIDdpu53ckJdumS9OxViD0wEF+xTS/QRi/zeQOG3n+BDtS0gN4ssx0TT3Etpx+3oZatijRiBqcwudt57O2KDMy4NNDtEg4nNSVhXLiNShExbvqtNFkgFxqBMlrTKMTvYnLr4kXuMIwIU5nTmWWkIJ7fUPDqzZtCHEJ2im5lg2o3upLehWojtSp6ZFaa3/YuQiTrBdBxdn29M3F9q4eqgdkHaF8IaYYXhT4odkGBD5lRMJray8zNHxXE39+kQz/9douVeH9CUfF80DKENxaIZVG8iY0FQ5dA30YbFh8lj0VQ9wAF57JmI4CpymTkzHIb0VbTBxYky7F4U5OD5NP505e4NUmbQFi64kTNXAQc5yg9vb5yf1xoUn832z9QexulCqlftPgyYy4dSMygO+oBzrsgcVYdr4OUqgOKuU8VlbM3HI8tGLRRCQcwh1J9AMY2zU2kE7s82r1M0v3vN1hobunwHoo3uJ2Y4myaJHhPrLRgHVLU9oyEZ/zUGvOvL5LQJCzncvgDA//w/Rqt1DI9k01UT+q+Fpyojla7j2WgokDgx7dtssJV8Ul8f3j/k8cFug8UeohhXxsZMX/Z48Gs7/eSsBlYeu+w9ccYAm3Sl6f5xYzQUU134pALMW87j0aD0gj2ljArnNpQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(55016003)(71200400001)(7696005)(6506007)(4326008)(316002)(66556008)(86362001)(66446008)(66476007)(8676002)(64756008)(66946007)(76116006)(478600001)(54906003)(6916009)(107886003)(9686003)(38100700002)(8936002)(52536014)(5660300002)(33656002)(26005)(41300700001)(2906002)(4744005)(186003)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?BENsYkDqhx2EwUKe8PFaEnerMzXJfkZOdquPQnW2+7LF0+uwtx5cjTWjAm?=
 =?iso-8859-1?Q?bcSyECoTLNBDggUJv6NGHjJ++4uZ5lc2+uBGtKv76EDOryndzXTl6YqF7e?=
 =?iso-8859-1?Q?2YbpyON9so71otjk87Zs+zYIiqEIeZbnymJYyw4GVlCCDk4XOdH1e0IDia?=
 =?iso-8859-1?Q?FTdUA0jVj8W3MGOxRIqLjk1WtYT/VcrKE+99sKteSVOdd4me5cOlwHyyCo?=
 =?iso-8859-1?Q?hLey0EOpcHyyK+qMFBuHJ4j6PqudFNCHHypxwI6qcfMTf9LBoW4bljIeI1?=
 =?iso-8859-1?Q?o/6djA6rDFp9yQcVTqzo5DVkM5O45W+w6wwp65Oqu+RCaFIN8GledgjVeo?=
 =?iso-8859-1?Q?zIOt2y36/fnFmBpr3kxoESIPNnLHX/rCLtSzk0SZPWjvscVxZEm/12eyeW?=
 =?iso-8859-1?Q?le34sW2pplCm7ZgibbYHNT/YDZDcEo8gYnH+HdyR3cePR6UMOhvyiGRtLP?=
 =?iso-8859-1?Q?7gOmi7kh9pcSk3vWsRuTP9sh2FEz++qJeZAJBC6K7L4c77EbDmqfGv3Mls?=
 =?iso-8859-1?Q?9463tUrZfrou6Ri6705Omp3jg0D2jmRjITa+jB7XkCVSpcB2v/RRAdTKm6?=
 =?iso-8859-1?Q?k9V8a/ZYgRhfMbdX4HmFTE+Mga0gr3dUjqd0laa5Igt9KTeJm/r+xf2doO?=
 =?iso-8859-1?Q?Baaf0csxlUOHfHuLeuFTAGP3NsYMgGpnRGx6AsfFqv/3+nrJvSFWV4wj3T?=
 =?iso-8859-1?Q?UQYDVIzybDpNfE3oCw+/DtyQ2P8zTjJGp4NJmQcd7lHUzU9mMyJ8wnQz3R?=
 =?iso-8859-1?Q?oHJUKYsruRcVinafNTeiim541TrHOvZa7gTQDcSD/y9iEVMg76z7G5z8on?=
 =?iso-8859-1?Q?8JRAw3ayOVx1VO86woj2XFVGE+7jYBSixTJpz/vBLwQl64jejz1hjP/wZb?=
 =?iso-8859-1?Q?TvKeLx9hSj0Se2+dozczuG+u+Ea7Aubdy4XQg9Htqkq4+Hplvxk7vF1x6O?=
 =?iso-8859-1?Q?kiVmTv26AJm1AqDGLACNxSueNwsyIEBNvEtocB4snzc9p4EJYW//fwVCAs?=
 =?iso-8859-1?Q?yAQjrBvFsdeX1Aban4Ply7B9H7GbK0nW3f3CP9FkgC/e0kXZfyyX+W5ODW?=
 =?iso-8859-1?Q?uP0z/pE/bwE6i6arNiD5JhkQka236Gr5V2fbmTQZqV9QyHd2TbRFeyQCDp?=
 =?iso-8859-1?Q?eAQ+Ldoe/e4pr4SCP71g8DayxS4tQLkuCvS701A+vOoaz4NNSZ4XVUigMm?=
 =?iso-8859-1?Q?SCAroUGvIYIP2tD/cxzfKuQWqehyK7iw45KnMUUeZTKMsgp0Oh81uLLnWr?=
 =?iso-8859-1?Q?0g5E2ODDZd4wjHnXV9wvbqRGYwrFjNjCI2rXYumnOVmBa98bS/2UoYDdxH?=
 =?iso-8859-1?Q?ckZ2M9gGouKMLb0/mO1x+9WBfSDHhtnujVojuv8OlI620HcitpbUZDqZgH?=
 =?iso-8859-1?Q?R6A3XDc7q9z7anCdjSyqNHpm/JyqPkN4XjXXzEFatot1hkns8+KeVwpikE?=
 =?iso-8859-1?Q?zGdOrF734vzyiJJTr64k+U83nR53p/nZAJHHI2MFeGxPmtSdvexvqEjhr8?=
 =?iso-8859-1?Q?o2PkBCxUMgknJEh68ucCW5qSHkkUEdBc/GEkaEIBpNtgLla4nnHDhRlhCe?=
 =?iso-8859-1?Q?jn/cVSiiBzuwjfFLjC7qcyiFvBIbVKrILuuOvtoL6TqYZ3YBfNg5kRih+a?=
 =?iso-8859-1?Q?/g+yOHoRIQCd+x5RIIY1VO7i88gMEOmd5b9geakQxnU4ZO/s5s5TFkdw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229e4832-6b79-40c3-45b6-08dab72e7620
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 08:45:40.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckkphwFNz3c2C8gFt9Oq8u+fPGEADVIR4bT4h0pK2G5te85d8N7uqJK7rrgytzo5FIfkJvccupjpP5ISyyD6uBYMGcPokOkEulE8BsDVC6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 08:45:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9843

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L
> improvements
>=20
> Hi!
>=20
> > This patch series aims to add DMA support to RSPI and enhancements
> > like fixing interrupt types, MII support and fix RPM imabalance for
> > RZ/G2{L,LC,UL}/RZ/V2L SoCs
>=20
> 1st patch seems to be just a preparation for something we'll not merge
> in 5.10 -- not a bugfix and not a new hardware support. It is not
> likely to break anything, still I believe we could avoid it.

OK, I agree.

Cheers,
Biju
>=20
> > Uwe Kleine-K=F6nig (1):
> >   mtd: hyperbus: Make hyperbus_unregister_device() return void
>=20
> The rest of the series looks good, and I can apply it if it passes
> testing and if there are no other comments.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

