Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8675C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 08:31:05 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.121])
 by mx.groups.io with SMTP id smtpd.web11.87086.1700728257206143032
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 00:30:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=t6leHcyZ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.121, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwz7WJQdwcaDh5wzmvuKVXcjnHhjStLBqotK3YIJCDZ2BCgH3J/qe/CGKKUSK1ERl+02sDt6Z5AYDVEITHfADfoDygp4TbtzgsMLGKwvrnkaDIGl6gaLuGpl/rf1oFyxKxF2M6yUuS+URQls5g+gvUxzJJkVusTwiz5eV+GzhylQuwR32k0CbuS5u43hfwK0laUiWySvpntKHnkqovV75MXvxdi75VSHudjMNXCu7tXttIofCWpKGrXBWq5enohaMDSbhL+DPXW4dMQqvg7xEs3OouCFGpYi0l95ONci8zIohlRKgCzqwa5XqdPsBKqRFjhvNc0dBwYu0IujgOE7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BMyMgQvpcvaN0oDgpR5sdT3C0goTdIFqxdn2KnLKvQ=;
 b=fZE1Q8t9y2aJbGO/fvmzA9RdIgV2BuRv1fRFZwZVpvSMwcaU6QtN6CMaiRTyBiM4eBhWbQmNJtlyzUcP5lKz2SfXRvl0O9wCW5UnosGMYiOLOp4pO1P+Y+MCDJnlUY4lP4sTGhYvF8pe/srWS79h29vJXfgRYWscOM9rAi3kDsccwH31PGUa5fYeIHxsvBNooVoltGBgvczBkT5KvQInbzg2MhD5wOJ4JNFgiRCsIrYU9QCsObU4JyaThI52eq8mngRMa8WPNq4Zgpb16ifXdek9zvYiexn0Yc41DLMLfdlD2vU3R+St5KwdKbuOB7RNgSus/PQQd+9C1RvA51Z5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BMyMgQvpcvaN0oDgpR5sdT3C0goTdIFqxdn2KnLKvQ=;
 b=t6leHcyZ1ByZwY8kbN9sznJSA1Ece49yiPfXb93z3Brc9keHzQurfNaMBF+CsJ3Lxu8kfqy/upq8hMNqW5qakxUG1neOeVgv8y/Wb/Wr7wuOa7sgZRfx8dVQMbPkigD3dRIB1fdlUV0i1P3DGb0Xg9fNY3D2rBk6I9wMfqAQIHE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYAPR01MB6010.jpnprd01.prod.outlook.com
 (2603:1096:402:31::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 08:30:52 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 08:30:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 07/11] clk: Add support for versa3 clock driver
Thread-Topic: [PATCH 5.10.y-cip 07/11] clk: Add support for versa3 clock
 driver
Thread-Index: AQHaHVAwD8IMnMzkm0eXxcjtgRboZLCG1TmAgACyqZA=
Date: Thu, 23 Nov 2023 08:30:52 +0000
Message-ID: 
 <TYCPR01MB1126985E23A3B2678A631D27186B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
 <20231122142819.203737-8-biju.das.jz@bp.renesas.com>
 <ZV5tmy34x/GeB+Aw@duo.ucw.cz>
In-Reply-To: <ZV5tmy34x/GeB+Aw@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYAPR01MB6010:EE_
x-ms-office365-filtering-correlation-id: a1aca6c8-db9e-4637-4df0-08dbebfe8148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aCld2fNCwV/XvCV8yIhiscCn0Mar8hegcLd6DqQU1ZnY55cRGKVThWtokSgp3L7M6uMqTjwqz71qSPUVurv+ej08LbJpax/KVq3wLMYxqLv3m4LRYzGTbcbupPoNRgtHa/bO+mdVy+poLTh8F9W8j6JLiSCJPRylZCI5B3gufQASlUYV9pHTTxmM+QZjuel+fZ37aqfOdMpvGO1SvEZuD+ipTO2UezIMH6oIAmzqO7ZX7pqvo7rIrjJX68ZoB/Rv9ZKwtS+3LmHVEeU0taXTKD5V8RV/790fo0S1BUJ7Xc7E7ndRk70xinb8kRTsDfQsGH99epmAlKmXv6ic1qelyj6GSj7miR+uYwuYf2zAJU7+V4BVuS4IoDIL7TYP9fcnKpHwDM/OwKxTwMB2ORbe7R2G52ObB+uA/qpQ0VJzwVEdcM1+xS/UaJ94O1cH6tcHNuFlxO496CwAyarCQW6DR1HHWdo//U6XOnF1kW5oeQPMY4Fh0jfJWpte5zbg16WDsWod8yqnowlKaemIh6w2ewbpWFz6KaJsSYGv3ahpCTt1AWCH9demOVc0lnhx14xR58gVVT2hP7lt289l7KvkpQdi1b9e7WeUfZkglHUfnvw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(38070700009)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(64756008)(38100700002)(122000001)(33656002)(86362001)(83380400001)(26005)(7696005)(6506007)(9686003)(107886003)(966005)(2906002)(4744005)(6916009)(316002)(478600001)(8676002)(5660300002)(71200400001)(41300700001)(4326008)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BjlC5tTDQ84WKn6tOga2auA5Typ0+vpxctUFNfsoNVrnzdqWRfTGB3kI+BfY?=
 =?us-ascii?Q?Z5a6IOgov4tZ+3xrkNBp9rkIB5eIiY85EJEWIci7XVMhDme5cjNF8Sb7aoVB?=
 =?us-ascii?Q?z5f7NFOOv404Ct5WyJFL2L/KfroIfiNz4ZnZ0ETwWO2JTVjweXdW5KGBB5tQ?=
 =?us-ascii?Q?ahXf3RNPAHDa5vAIzRAdOr40hV0sMcluZp4U9lkZZRE12j14shXdNm9Ljhxn?=
 =?us-ascii?Q?LE5Bvp+utTcBPwouwXST2f/o8qwvFELhaWG5uhrFc5ju+LyvqmGqrCBgUu/9?=
 =?us-ascii?Q?7PCPgM1LIRem96unVX2IrOVba1hSC4fPoEp5uFQZI2cBewDVK4EsjLJWKiaV?=
 =?us-ascii?Q?ln6F9Bp5iL3xbM8e0RLIO6chcC20MLsbMlyH0CPe4NkdRpia/NBjbsmO+/Ch?=
 =?us-ascii?Q?haD9BrUjyZhI4dxYhRHnJcwPKZoUg+hOUL9tQoNreHo18zAlZFr/tWiUY48M?=
 =?us-ascii?Q?9jOkiaNncUXV/VnT3CXWncojAGG4WKzn36z+mcYqlBXV7Ud+gEjLrgFWzUSD?=
 =?us-ascii?Q?pYkthlMiyuSkQ68bXuT5q8L5+TOewR8ALadErQfCrx6z4Mj0mtrQd5tL17Rc?=
 =?us-ascii?Q?M5hwXG4gGYxORK+gfEqp9HZp1D95gexFDYMqWDmDKd1dLJilb42KKvx5+nlB?=
 =?us-ascii?Q?elOqCP9Xcp7MCJu78AlAlP4gkVUPrIZiNcHnNMlkgyBR+3ab1iKo3K76+S9H?=
 =?us-ascii?Q?BNAe1ZWq/6iD11NKkMdja0w4sr6FSoGj58dFfEY+qUHav/Ap5+5xEoTP9fqw?=
 =?us-ascii?Q?gCxqkSEx9uv9fWbL+rgh8ZYmkiFSiHiW/uyzSIeLvWq/1tT7WvzEBe61hRZY?=
 =?us-ascii?Q?UhEkTF/NgSstczqCAt/LfabYUt2ValkJwinAkW6dRxDV9vnwr5yXBTstrenA?=
 =?us-ascii?Q?sdILEz1j/zvuWDL7zc9l+4cg/IrgCB4Zi+TZYVQHsacB1jTkHcuJrXz6IIkw?=
 =?us-ascii?Q?ptEDC6Kt32u9+FsSDZA6mwV1QF/A78N++wf/0ZL5bZG9ddOWernqXVBU0Pq0?=
 =?us-ascii?Q?kB/UNrA0OIn6ezXOhIftgz+KoYII3vWSK2sMvAXPrNNnO3xHqLmx98jdwOIz?=
 =?us-ascii?Q?BYCXkrTgqegSUJbqLoBUGDNt7e0l0Q190G8opdHqM0STb+Z4v9ES6WzNF0cR?=
 =?us-ascii?Q?hmQ8X2Jx49BpHrxgIgJaXvJmPzp8neOt/OdnHc0fsChY2tca/rLWw1qzdZAD?=
 =?us-ascii?Q?JH4VPYyyNFk8pOJioqCbVrKKZJIzNmHRNvFoF5eQ9JoryqnpuksueV5CxUSy?=
 =?us-ascii?Q?5axmu7oTABEpzcChKS8T4mndyb4O3+c0HyQXNiTRlC5xQfRUefAyzJP9InKX?=
 =?us-ascii?Q?IxG6zOZWjKvt6nfcH28H3sJke88xIjTJM371CMfdKUY6rdeteggwW3FRJ9mB?=
 =?us-ascii?Q?Cs6iyOOLNe2juW1OP7KwzeVV8lKNvoWqFUlBryK4yGqrEmN4vw6/MWRaUMLU?=
 =?us-ascii?Q?cvGLDjDaZImphA3lXOIC83sJXyx+qPZOpl6e0zfrZo5tQXxZLKUNlb6RDRKs?=
 =?us-ascii?Q?tFYmLnX85ZviXCRsSLzioZHYMD82o2f9al1zeQgGVZqhG9usjwaRxh2kB4L9?=
 =?us-ascii?Q?pdjuS3ekiQAwskGLuOey7/lwBWIS4nP/LJqoQtVe1eAp8N9pxrd3U9KAAcAq?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aca6c8-db9e-4637-4df0-08dbebfe8148
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 08:30:52.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5rHpP2iDomkUCO+60VSAuIauKZae6WaQKGm/Ns8pINiyiwyTy3c1zTvq6w1sXV74JJ7vRh6R65WSKSy/8nSMQGoWj0cXPJyUiqfwgNKKDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6010
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 08:31:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13659

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 07/11] clk: Add support for versa3 clock
> driver
>=20
> Hi!
>=20
> > Add support for Renesas versa3 clock driver(5p35023).
> > The clock generator provides 6 output clocks.
>=20
>=20
> > +	if (!ret) {
> > +		/*
> > +		 * A raw settings array was specified in the DT. Write the
> > +		 * settings to the device immediately.
> > +		 */
> > +		for  (i =3D 0; i < NUM_CONFIG_REGISTERS; i++) {
> > +			ret =3D regmap_write(regmap, i, settings[i]);
>=20
> One space is enough after "for", but I'm not sure that's worth separate
> patch.

I have sent some cleanup patches yesterday. If there is a v2, I will includ=
e this as well.

https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D80331=
0

Cheers,
Biju



