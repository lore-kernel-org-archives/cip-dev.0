Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7671C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 07:43:05 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.106])
 by mx.groups.io with SMTP id smtpd.web11.86599.1700725380785694938
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 23:43:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=h+hRFXYX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.106, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSrcso/pCXh2dAnwL9OF8kTvz5AAAcVWT49KX3CyZCrPpcFgf91gpnx2EAQzc+jKTGjSTcDWDIbrIu/Fuc+7TlufpvOETxU+249GoWboVKl0hbQVjqXJZcU/rcCsSs6yDhkJtO3foEbM3e1JmkVFvtjm63NOEZhGyd4R1sy3zqbEGVfJh82LWKjWAAU/dOKlUJibQV2AfGhRNXFKy5hOaxTrCfBgxenAoazSRUCYAG4UAIhhQwcXHfXFk9yus77bArWN0/rAZTVXYlu8OOQbHq6LQxLTlglwgRAcKeEOoNL8KhE1YZ49dKbrjc23BkRQVQ9B8i8EQtWSVIEybIOnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/68FE5Dj5LwCVesu7szBZ8GM2MjqdQlpeqyRjn3mWY4=;
 b=HNCPAA4m82NG9gXb858HOMhFM0tEA7X8M+tzAACUDCSNT7xLdfNdDCX0jwSn+HHrUEh/fxNJq6v5mEf+l7qHiGNP9mz53NTt/8b+1SfRl9bokWt3o3yCgHblSzTjorh7p5AvtBN5GrdCJ0zW5mr5td9BRBYAkdWsOLwe9nHbUug2xfowp8OqYPD58yBaqQ2g2vWKlXKJeRSNmJPgCZp1FbZMpwRA3RDv1KxaLTONG5yVWdAVNYeWV13VRSslwL43F2hD3ZRD+vjo6PMZdZp89bc66xhzTyWjpjfwp1VEaQvXjWjLqLl6yY47lGK9M32BkurmXZWEn0jkITxuj/fbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/68FE5Dj5LwCVesu7szBZ8GM2MjqdQlpeqyRjn3mWY4=;
 b=h+hRFXYXsa8QWSimUis0tMQYQjKaf5jrJMRHPueUbpbACS8TkCVqIM1S5QouOVVMxKSVXYCP6v/vG/JxvUNvrIOWOff/1JLe4nNGDhVWrXZ0j982bFd46/C5eYN7YQtd+fUzWsxNMjg3HuHvI3g+rxSXhM2U5SXJLZWXuLcpYI4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYYPR01MB10466.jpnprd01.prod.outlook.com
 (2603:1096:400:2f5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 07:42:56 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 07:42:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: AQHaHVCnCyOZxfLIuEC42b1j1b2u8rCG1g8AgACwIMA=
Date: Thu, 23 Nov 2023 07:42:55 +0000
Message-ID: 
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
In-Reply-To: <ZV5uUFDxiawBZf30@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYYPR01MB10466:EE_
x-ms-office365-filtering-correlation-id: 4716c5f0-43da-427f-952d-08dbebf7cea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c8fraRE1Cqz3xxca4vnacJE21zI56j972JXB5ljgJFo0vVZEZEKm6zrYz8lpei6nUbv5LOUqE46EtkOWXP8Sj5NldbQ8b71RbyTzhzSjb9ZsEJNb+4ocM/cZNMzEEKv0BhQTv0Zo800h4LrLxVUUuBFIyBgKAbOnDPZupV0KSWY0ND9hyDNs3NIvcXrDNTdshfUKktO+ZT4RhMiR59n5X6Onfrj32VOrRkNhxa+bEebxJJ4NFVP39aZJcon8kx1uc4o4YqtGGv8EifqBRtBzuZ2I2V0cMDEdUGSFqo1YvAwnY5oYzdvvophTFbJAttm9Gr7ZSirMZe4no6OOpeVaSaQp7j7vJWwfctm8ole0HJaLw3mCME09/91QmdH8p9Wh8zELgON4KwIYzzp+Cts4/lsq4XEu9fFtfv+ywF0nj3EJWNDrFk907FgtlCBJZfHMMEsfAWNvJR4RbNwubqv6QvqeSuD8g/xI+FSualBn0sJbvOvds7i6oL2kCNwKeBOULelYcPFfZISMyjFIuySyh9R9nw01k/CdezTz+3EMODMVbr+9OwNlqZ7s15l5TUnjNJCkIZvEj+L5u3GIjnx0pPTCKU+5IgNJhbzQl/Mysu9uidyxoTMJw0oz1J4OIUV9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(122000001)(33656002)(83380400001)(41300700001)(38070700009)(316002)(6916009)(9686003)(66476007)(66556008)(66946007)(66446008)(76116006)(54906003)(478600001)(71200400001)(64756008)(6506007)(7696005)(5660300002)(26005)(4744005)(2906002)(107886003)(86362001)(4326008)(52536014)(8936002)(8676002)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zu8d+HzrA3Pw+GzCiVyZjaALeirL/+EH6NTU/cmK+i0xDq7UXsYVenaSQjUo?=
 =?us-ascii?Q?2Zb8fCTOKosgwDXIhPbIt7asux33PcTTnjqPKU7IJlILXfl3umFssqnE+bAB?=
 =?us-ascii?Q?S03ueykOy8JbcIAhuXjWXtuU29AHE0eObgd3gsmvqvZA3pZP4menyvOPzWgR?=
 =?us-ascii?Q?N7sgdgQZQ1v614975fIxDjW0gw1xfU8I/4kVzdKfOuXdGjhbIgFQAjfrdp2F?=
 =?us-ascii?Q?jmqMk5luoj8gBddbrUSKTQHg3YJpNDVbVwugbjy/LhrmsVA4Wt/+RvRivETu?=
 =?us-ascii?Q?THPOJQv8TaljNFtS2+JX2bD502ilODZYc/cSc/VCKgId5E60e8pNE7+/+D+u?=
 =?us-ascii?Q?FzN7Bf5h2U2QFJva19FDKruRVmzeAhTnRMlIStlII+QRIaylIx7kE7odK+y1?=
 =?us-ascii?Q?FLCDM7YubCeYONFptCpnxOcmA/E0uTuLMcrMioGmK/9Jg7rm0BBfls/mVEcz?=
 =?us-ascii?Q?ah6AMeHzH2rdT6rywcLzjxawjXYVE1NDPrn5BHtkoHAEdcsOGaFr3BRx1S9t?=
 =?us-ascii?Q?t12gOf5+RkkCqbJot/iw3PEtMRV+a7RNzQ2BoKLZ5PZa9sC6m2Tse3Ambrwt?=
 =?us-ascii?Q?zM1B2BieXvYsdKXNkQREqeSvcLmBLUbDPE8+3r45cCX95iSNXm6bu+cKXwp4?=
 =?us-ascii?Q?SXE/ocP8BqBkd/hMmSTFXTfuq9B2g/SoDG28qU99m/rfPBNkLT7ZE5rGafQh?=
 =?us-ascii?Q?JHgoKX2eyJ3RNQ5BIWmAqBPeN8ZCrfanoGOQF6gvzU6w38GXqn/4NOgIx5tw?=
 =?us-ascii?Q?VskQXD1jT+mLHe+EoLAosn/nibJfs7CnA1DUP21uH2XeHtGRgMwyg1pfmKRs?=
 =?us-ascii?Q?/3M81caDO44oAN9o8IQG0AOuwQpuRSqhvvxUP3FBHXP8A0se5TL9Iijl0+zz?=
 =?us-ascii?Q?p2Duji2H/lPaHOMfn3+zImq33YQUoplFqi2qQHTCUJpTa/zGrgT5PhU46vKy?=
 =?us-ascii?Q?RN8Sr9bqJsb1jfbp7/oRoPU0EqKjCRKNjD26+5cON9nL1k391lPyexXePWql?=
 =?us-ascii?Q?2PCj15l4ZGgOOmxmt1dynZ6zij5QI2NOUIzgv4zFzUy6aTZixxeGKVesg6t5?=
 =?us-ascii?Q?i/E3dACH5h7lwSIGwKnpMqJlATvXmK0kFcdAxk6ZrlKNdL1Qa47pGSPn2O8f?=
 =?us-ascii?Q?Tkm+JQjZhrmnBnkCzleiHi+hxegHiBHtMybv9a8KqE/jrLDe/xK7Aw20Sg9S?=
 =?us-ascii?Q?j/fVDTIixKyRTIz8Y03YsyqTHmU9FntGDlaslSIPRRifScgMNb3azPMfgPgI?=
 =?us-ascii?Q?LXt2wGNHzUATpXty5p7e7MTWMhDkj7Zg6xNxLvN9CwEb3ey415SyOemCE5F6?=
 =?us-ascii?Q?wKeBVC+wbOhySt9/PMoLd2jYQVNHEAymZ+bktXVb8/AXmvXJjPXxswW8FZ0c?=
 =?us-ascii?Q?a52Y0eXwOKcur5PWVP1SFeYANJLJBA/3dqe0trv0RuC223aTtX5EY4D0JlJr?=
 =?us-ascii?Q?vupyEy+4wnhGk+NiyQvndEMsLW0/p11vI489OuANXkFhMtvXwB9jvM0eGzgv?=
 =?us-ascii?Q?hraAPE1ehIN+h1YsH9cTO9TZewknqHzpsI33xTJNb7LZbiQqizprdkeWPeCd?=
 =?us-ascii?Q?gCyNcFhngtTQ64K9uqncN/1IaryVcS4Cr/bN/xDQM2mR+bsJly0AUEXBZDaI?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4716c5f0-43da-427f-952d-08dbebf7cea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 07:42:55.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71w6u4F2ckoosPmxItYANd1wnRMDLMTbgk+N0srWaIeUMA0VFRc2ZGyWPyekbbt9IWDOdgirI3GggifGJYP7javRwlq4zBv6P7UR7w1rFHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10466
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 07:43:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13658

Hi Pavel Machek,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>=20
> Hi!
>=20
> > This patch series aims to add versa3 clk generator support on
> > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> >
> > All the patches are cherry-picked from the mainline.
>=20
> > Maxime Ripard (1):
> >   clk: Add trace events for rate requests
> >
> > Stephen Boyd (2):
> >   clk: Move no reparent case into a separate function
> >   clk: Introduce clk_hw_determine_rate_no_reparent()
>=20
> I believe we don't need these in 5.10. I'm okay with this version as-is,
> but if someone says these are intrusive and we should use 5.10 versions
> that don't need these, I'll understand that.

I have n't added this to 5.10 as it needs lot of code restructuring.
Please let me know if I need to port this.

Cheers,
Biju

