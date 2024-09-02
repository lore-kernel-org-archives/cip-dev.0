Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C0ACD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 09:49:47 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.18])
 by mx.groups.io with SMTP id smtpd.web10.35057.1725270582522845308
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 02:49:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=HQ6qGpYv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.18, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bczlIxlDl0zfq8jroDsymx67UqRxEmv0Q04T5eu0De5o2+GyyN3brqom3rk0WpjmbbUrKIJpoN8I04dGGVgwkbui52x8GXU70HQqJBS8VlZF6exb/WllbubNmj9pmME8zhiHKFC39kaYxcXPhGgmbjQCG7KmU0qPCy8NZkzlZlnwDy5vy4LxTrf7w4uiU5fD/dczaJ4xQRlo4tcJ6QjWLDR8yP2e1eqwWyjSivOFuxkSpFf7hbObJhwo4Nr1aIs5vAuc+O1V6DKnvO+5Po414rL9l9Ia/cVTfn8cPqN96jxVbYpA7/nDvCmis5A1N8Lx+ddJ3Tl6bT8GjQifmfZjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go/i0m5mXa1b8nBfTQMd4NUscDVxvkA2Vy9X5Bm6NLA=;
 b=gEAIK2MVZ3VXdvJrt46/gFoGOLJ68NtJ89uMeEd8gdHlBB0a/ITbCGJ2Y/fb9QRbDLiXLBRDFRRGLgZOcdArge9X3Ii06oYqaDCqa79YR6OAcjV+hxGVi4sboB2KyQc5MeBpwfQD0mGVWYWDaE/yN9OcL7/y5Z3O1fPbVwwVU4qBziMSnR6X0JkHQTRYgBq9mEYSAvCaccuK4PgtmYFZ2Gh8wRVj1wgaKlkOZlSFg5AwSk+iw0Ii5pLxN9XD2ZAgfP+CLiIdbjpzQdcDi/pL6pWSEdgJMifUqPLJCzNm/XOTP3v+vIEqsVcYpcr7OcnSZDWjjICRyv/y/l9kWt/V1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go/i0m5mXa1b8nBfTQMd4NUscDVxvkA2Vy9X5Bm6NLA=;
 b=HQ6qGpYvqu1dhsYLgF1GPVGvUFbyEsi4lpktpIvkAR+WwG5KZpI67y3AH9SNOcfbfPtjYS62Q9HeCGl4dczbOE60Qq2mLka/UunABva8zX2B5+VpGt0XHN0iXtECWmD+GNCr0jFNsPxkgN5Z4bYuqxwSvwy8AxMmRhXB57qfVlE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSYPR01MB5384.jpnprd01.prod.outlook.com (2603:1096:604:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:49:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:49:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 08/30] media: dt-bindings: Document
 Renesas RZ/G2L CRU block
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 08/30] media: dt-bindings: Document
 Renesas RZ/G2L CRU block
Thread-Index: AQHa51au4fL+DgrmGEOs1b9lpUQaKLJEa4cAgAAAYJA=
Date: Mon, 2 Sep 2024 09:49:38 +0000
Message-ID: 
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
 <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
In-Reply-To: <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSYPR01MB5384:EE_
x-ms-office365-filtering-correlation-id: 1c312c7b-158c-4a37-512c-08dccb348f61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?EV/lU/q3YXcIuPnqyVnyDXyqj7tUmvbTmfI4xJcr/0rbo/MkezEd3dVDcZ3S?=
 =?us-ascii?Q?w3VYEbdt/Jt79VQdDNE+Anje8/yqteVZlHk5OSOQb3ZgaLWxfVR9gQ//6qpm?=
 =?us-ascii?Q?Ai0yiybIIRwHt5MILQkyOHQlVqRlhZSgmjWXeprmtrHyLCS1BdqHa+nhe7O5?=
 =?us-ascii?Q?+fPMS7WUZJkYxgYqjfQK9Db5CT20yCCJZbdgnYN507KqPITgBejLLPBWZCX3?=
 =?us-ascii?Q?v3+Ha4pCZ5A7wqVBsUCQnuC9M2y5l+SkWH/hg+HqI3Vhq3Me5HioeeWRjI5T?=
 =?us-ascii?Q?IeKs9pYzzxdW0G5IUfIivh2algA8ENDPPABFXZTkFjXiEFBQMoDoY27LxPXn?=
 =?us-ascii?Q?QnjpBHATwjUuFkDgGi4EFrBUgpNOxb1DfssqjYosXrIqwsc1wTmkWihHjnvi?=
 =?us-ascii?Q?I3K5ampCj6XFunxFC+CF0oxGHlQmYkce22TACJ5+vB+jPYVrYxzJUTXgW3uM?=
 =?us-ascii?Q?T7NvZFFnOaS3HAf1iWCc/xariB4gjYfEHvcZDY3Wj+BUlDsapduTAUl6YyMI?=
 =?us-ascii?Q?2pxunMQBOmfLF3U84jqJS6uCQZTRWq1yN2zC6/SPYkoefvzY4c3mRqgIXSO3?=
 =?us-ascii?Q?G9l6uGrXw7E7Jti8C8+nEdyjGYJfIv8cogPcGCYPyMhD8wQA6ZNZ6pYBSj+4?=
 =?us-ascii?Q?OSeZhVXYV5u4BhMDSnn5b4YP4kx9bNzyqcp02zCEuucH18CI4B5wWezlRXXs?=
 =?us-ascii?Q?pDQAd2kUkRAhqUlX0wkpOoS+ZhyX5krf7CZUMOmQ6f85iFsxTdhnXFXUfW9h?=
 =?us-ascii?Q?u8zurThgqcjXlTu07NhUTuwKT/o2HY2N4l10Tr0VtAcgLUTL2SITwpqQrdmd?=
 =?us-ascii?Q?gpP7Tsmy0YqmwmQQnZuMU9OcXKwKHmB3INr6T2C+nUT10/XZ9bOgewLttazL?=
 =?us-ascii?Q?hpkKijUo8YDM5LBbULGntLYg7e8ZdiO8I8M0jKI1PtpZJlDOm/1DKJy8uu4t?=
 =?us-ascii?Q?6XxhuMhZjsSktOvHVtAfve6uXO5EZPAMyp7DqFhNjO9/cGcid1zK6Tb8ip4K?=
 =?us-ascii?Q?5w4WE3wiRIfomBU5joXy8T7T0KRV3s//d7gRJSVx0VbwGx2HZN7BtVHNJuFW?=
 =?us-ascii?Q?XWEm4aki8NKePWQOKRRmqGrTflNKAmuLHnm/kxFISrRGyPZBJi1HhSTB+6SC?=
 =?us-ascii?Q?kxpaWyjrK15wt57DJ+VUaUxD1wOTniWJThUELoOx5WeiUyR7q8dgE+7/nujW?=
 =?us-ascii?Q?bNONqyGoDUFkBvMOGbL8cGW4cdtciBI3CTuK3JI0yHBKtR+NgOlZx1tyR64c?=
 =?us-ascii?Q?GuDLZMNmoYyCzFnkE8lqZWQf2nu9YmzIO7ZFhJPVaG2DHd6pKoRLGmTjv4nm?=
 =?us-ascii?Q?rbOfSnYsL1EB0/uRo5N9qCVjvsdGVdtE3luduhgqThv0miouIMmV4vp6ABdo?=
 =?us-ascii?Q?8c/N0OqfhWmqFthMqKobO2/cUOG2/igCp8sLUz64sXhPiY40Sg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tJSygIFPBfPd3LvUQXmYvaajgkMajacoMrtscjB0b0lKUpA11jjFbdKBNNna?=
 =?us-ascii?Q?QdPxoQ72Tm5j7Qopnd6g1bqSQBqQ9rmGxjawdjNtGv39BlX5H+sCqjUoDSfO?=
 =?us-ascii?Q?4NT7jQsQegsHWZK/qsFPrSR2wSboqQhlHDJRiBeHCPpV7t9ZMwwgO0mMWZm/?=
 =?us-ascii?Q?3Clkw1FR8diCjVV8T7HEVu7j5Q2NwxWvDUhRgZecNxqjn7cLCgOCZy193Qx0?=
 =?us-ascii?Q?OVIQlh3pIbjyg27p0VkMuS5Dc90ZUXKKx2+agDYRRgSmq31KwJVQQ8T9vlEM?=
 =?us-ascii?Q?UwS1K+VysqpkSb6oEUuUPBkNxs4c8zpxO8d56hJoKIpygnrGRGHwfc4s8KGh?=
 =?us-ascii?Q?H78P9vw1nl6XyMZ7ByDCs02q0uVJ2eIgabgnH1ZF274pzQ07B8sBWgsutuGs?=
 =?us-ascii?Q?ahyW+DKxclm/FS76BwDxCuccHsI+wBmn+UpKku0V1c3SUA/VEXhx8w5tNWZE?=
 =?us-ascii?Q?tGgmOX7faxHjBTM9nabUjm5BLJAoJ4IpVMj53OiE+T9yGUxU0K3/mM9VELSS?=
 =?us-ascii?Q?Ds91hjq/AMw9hBfVZBJyyQnz0/A9tieFVtQ87hyicvL2NFydLx9y6WKawqNP?=
 =?us-ascii?Q?MEEb3z5PmfqkyQ7oulGY9vOYt8zTIxgsQKdGo4tBBN18hrhTfMm0oqSbtxFR?=
 =?us-ascii?Q?lRdG8h377MztpmPHLeGXLn347Wll/Ea8gGdU0i91TOdRgwfpfTzqqxvK8xmV?=
 =?us-ascii?Q?HFNnLmpnLmvbn6BxUtPGIthpJwq2/OowVIM/4LUA82z6OftYYpjNtgVk8gwk?=
 =?us-ascii?Q?50396Z38mtAagMvjlDTUK8Srf5tXk0T1iTyNaiCHniuUgmW9MtZdxYLX1BHP?=
 =?us-ascii?Q?49TL7fuMVBDWrlu8tF2z3X5PpDTzaYdk+2jdSRnZiJNCD938Wdby7bFUYkub?=
 =?us-ascii?Q?mQ6ti7l7bVcIWJbr8ha6JOPCAosHba1s5gHbf4/ksX9u4dr6eZlbzmuIqzLX?=
 =?us-ascii?Q?ZE3yVXLs4oaORrsWkQa3sL8FuaKDR6pVTlGY7WoFeyCJFfCiRT/5ND5/+syB?=
 =?us-ascii?Q?dn8FrvSo6Mz23nwiIhvIXUQ0AA+tH8B1Yc2jT1r59ca5PHEHA5K0IFtTMs6k?=
 =?us-ascii?Q?qFWte5H+wqBWE6BXdmzth4AFMdR352ruzs37w0vUFBUx/iyuQj8GhX5iuBHJ?=
 =?us-ascii?Q?JkWg2enUsTyn0+fT2jIT/StogbXMMxqXJU4aB63NMJ1vFWah72OXWlAL3cPV?=
 =?us-ascii?Q?MQnJh3mHr05SnqW4tU5pJelDF3Djd6AE/9j32aPH/0B+dTbxVmocgSmWRXHl?=
 =?us-ascii?Q?k7k4RJHZGPusNuW40gEmjX7MLss3/OqRxNXl3IHs2/RtD2HR9I/D1EKLipsg?=
 =?us-ascii?Q?Q5iCO9MslB/StQiWT2W+V0edJ0V7KwSobwhb/meLprioyXrafi1fEIuYecZu?=
 =?us-ascii?Q?p4RbKrY3yQKgtU1E85VmA44izu+qznQnuqyKPLDQ9IoeQphWRsjSt1at6ssa?=
 =?us-ascii?Q?FqSuv4SsALBG0sfTz2P5KQL3mtFd46psmbdD8jI/KKLtIlCuqLvX/gT0AOca?=
 =?us-ascii?Q?MQPEIIY8tA0leqHSIGoY/UoTbju4tkYThOhIzgPeNHXOAhs1zM/n6xpW6dCH?=
 =?us-ascii?Q?kvWNsH46PD6mz4q5JRK2AFEPB7E7YKFBdNIaCCrzHBlzcr1y9CDYlXaqCvzh?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c312c7b-158c-4a37-512c-08dccb348f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:49:38.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsnKdniQroO1C4QTLMxJXCH+AABZhQusOEqyaZCpm7j/l2qXfIPwCsYgok2xa8G8VWDN3WKt+TfU12QCKEJCMh5xQLzttGeUyWJIRfmfzUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5384
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 09:49:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16838

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 08/30] media: dt-bindings: Docume=
nt Renesas RZ/G2L CRU block
>=20
> Hi!
>=20
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > commit a18004173a087573628ddc9910f0665a3829f48f upstream.
> >
> > Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.
>=20
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg=
2l-cru.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.=
yaml
> b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > new file mode 100644
> > index 000000000000..7dde7967c886
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> ...
> > +description:
> > +  The CRU image processing module is a data conversion module equipped=
 with pixel
> > +  color space conversion, LUT, pixel format conversion, etc. An MIPI C=
SI-2 input and
> > +  parallel (including ITU-R BT.656) input are provided as the image se=
nsor interface.
>=20
> input -> inputs?

OK.

>=20
> > +  clocks:
> > +    items:
> > +      - description: CRU Main clock
>=20
> Main -> main?

OK.
>=20
> > +      - description: CRU Register access clock
>=20
> Register -> register?

Ok.

Will fix this in mainline.

Cheers,
Biju

