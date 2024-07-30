Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70741C3DA49
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 12:32:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web10.16252.1722342755359331633
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 05:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Yosx+BZ/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ+mt83nEwtI+FpbmBiTNBWMnyPSxdmMDv5YQi32NRGGJ07aH6+qT13A4EsVLyxirJBJaDbBMAdH6PE9Zgo2nYDeGFoaoKmMinMK29CbSo2Eu1ocFsS1ZbLQgRh93E7WAzLO+EO2IGxZP8VIubZBfPMzRoTdNwnBT2iDl1EMiA9eb6VMcRn1RTRDcq5c7Z2wembhYNfAngAuoNBVgDrcvR1F+EwJo/HEfCEVk6ehZRc9aXw5LP0KcjPumKGk+hNLHf1pWgUu5ywzYVlXOxLb3eS56cSRyr+EhVICZs9bpniPX6KtrZb7ZJOd9twnHOIWYWNY5yIsR5U++RSLyDHg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n76wKYBtjgl1cdnZaQYAnjdFrN6O9CK/1DPdjcmyIuk=;
 b=Caf8NuPxxhpWxGeCYtnznGdvvAyw+16ehFcLBPiJ+JCHG/61fPYk4XMFINMVHB7YF2R5frrxWCFNZsSHnFK8oHloD6YGP3TEE317lTMspGeIqvcgp4roRmA13/z35y6rRZtr2nkmg4QzQxXFetuQmi3O8hsxM0n6nDBZA4qC7Mu50M6/jL0WRlVBG6TOiitL6Clt6fOc7whYOpRRcsXo4E9YaG+7ET4lEL4da74z3w2+lmzRn+nCZ+y72wWLVHJJNQ+kADypVUxQWsj0KFSfiE77G/z9D9WWeVXNilVNVAz5A09x5lI0n6Ce4t43nOZW2BBVMgNA1mICJXuOac0KXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n76wKYBtjgl1cdnZaQYAnjdFrN6O9CK/1DPdjcmyIuk=;
 b=Yosx+BZ/BT/GsCR6S+fmyjkRp1ojYpNkebRDDcw0pvbPCKL1Rx2dqXePxQO12BZwtJJ+lqhxXzdtSt2uT8tjE8B9aQuyvjmR/IlYru+XYDObwcR3VkJLg2B5Qfqlm5eIdCDco+hvlH9s9sBbtfqsVJz3UqW9gWIvzNa7XWghXxQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12431.jpnprd01.prod.outlook.com (2603:1096:405:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 12:32:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 12:32:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow HW
 access to enable/disable regulator
Thread-Topic: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow
 HW access to enable/disable regulator
Thread-Index: AQHa4cznvSDg6CT1lUGoLEBt5qpW2rIPNFGAgAAASYA=
Date: Tue, 30 Jul 2024 12:32:31 +0000
Message-ID: 
 <TY3PR01MB11346EB79E7AB9D5CECF88C4086B02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-3-biju.das.jz@bp.renesas.com>
 <ZqjcY1fp1uw+HW5q@duo.ucw.cz>
In-Reply-To: <ZqjcY1fp1uw+HW5q@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12431:EE_
x-ms-office365-filtering-correlation-id: cb76d928-135f-4547-4fa4-08dcb093ae70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JR56dhXenmaq1eb7OpucoU7bBQgg0D8ZC1gnzM3EwbSRxApg553KGIfPZrQl?=
 =?us-ascii?Q?NB62SCeCzEYdvKLlGz+wKsbDB8A2ikR/RyMHNT8uupQBVLlfv8u/xXQ1jD4k?=
 =?us-ascii?Q?U4UF32gKTkd5yatdDygxv4RDmUCeX0T4gmnAEh1OKpcvPsDlv5VAQAMdKJyi?=
 =?us-ascii?Q?Tm5JpFuwdmwDywJMyB42ctSXRp992yhyG2FgawYCKk94SNUZ3FKPtzyasyGf?=
 =?us-ascii?Q?2wRvZZ8KKAKjN/Jc6o0rjjKaTBo3jGJes2bWdd00HhnjTQNnvsxH+FvA9py6?=
 =?us-ascii?Q?MiWb2rpuelPEYrMeKw+wqmxfpZxV0Kb8BU/o22leL35Go4MNAQFki8asEuBe?=
 =?us-ascii?Q?fE5ZtQoD0qcKnlIA0vRJWU9ZPCnweTjjBFqgwx5ubk53wqH8p3dBtr3JCnaD?=
 =?us-ascii?Q?+wahh5TRedjgHXRIVpOSTnNOh8TvAGnAeJESeqr+1VoGfEkcIwi4iw1LBZY9?=
 =?us-ascii?Q?zWcN3nd+zTpfBwufw1wmsSeS6FMDjHPhEuQ/g4qN/ZUQvIt8ylnxbaeokFL/?=
 =?us-ascii?Q?oGDIndhq999/d/yyIZRyYZMFyKpDPTXvEqf+Jw70NJPUhSPHPW+6u7sTu7sA?=
 =?us-ascii?Q?4/59gnK2m4yx2xwsEfJcEkoUrXGe8sPoWGlgX2ekTMXDXTOdK9GwFs/Es8Wf?=
 =?us-ascii?Q?I+drykJGOytiCtrH1eX3E3kkOyhN0/2ZAk9PK9IVZCPqtjKWV77+He9xROtA?=
 =?us-ascii?Q?NWQmCscdiDFjPpP4LPi03K6nRVqr7d/oI316v2iaHoPlV5WS6iM5wJMVU7oQ?=
 =?us-ascii?Q?gNY7rlpreIG3p7JBCoBnKuL9uhUU7+7QoLetakaJ58w9qpf85U3w+ZGB+775?=
 =?us-ascii?Q?e1WOAZvH6yoUAw0T6PVei/owtuYy4/tTX20Gda5R50XwPhf1nlBg+zLITnbN?=
 =?us-ascii?Q?A+Gyc1JgisF5smVN7E8pv8ubv2lcFpI4ETNgA/y18JvBqslb0laJUzYPgLSt?=
 =?us-ascii?Q?OYe14chWAVM+SlXzTp2iaOTQxYLh+BhqrdO8s1oZCEdXgyOIHinjhOdefwrI?=
 =?us-ascii?Q?cRwLkomTR6rsotoC91MqarMN6fQEgMMXyuCxAJs91TOplxAlg37DGM66/4tJ?=
 =?us-ascii?Q?3TsarwmzqQP6slm+bs+hP5NylUe22ykHsTPg3PLjbGLqGpe4r0Xve9WGOiAi?=
 =?us-ascii?Q?sPPG1l6oddbV2ZBzXyb5jsMc3d8bUoOBAZogcAh26nuo4fLmm8FOzIa1WkHf?=
 =?us-ascii?Q?OiLzCluREKFzyLxGvrpC6LgnynimXHWogYyMtw68IvXgHLFBeEtkFfz13u/3?=
 =?us-ascii?Q?wgV+2qTa2HyMEAgNCglPSgks0qJ1U3ipG8xsIx17ECL3ClhcLM0pjMOCpImH?=
 =?us-ascii?Q?PwmN4VE2aQKBT42Bqr5SodLeBJEv9JOi+dZsnCu6H5FFBnv0dguKPg3Ar0tf?=
 =?us-ascii?Q?5MWwCWo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5vqjJZS82U63S3MvN8GpWcRy+lLsB1G0UzKIgxvH+rlF2hl56KnyXPeUUwAw?=
 =?us-ascii?Q?toTpLK7zhUfndlQpmDdu0vscFTOMvvJkR4VfWJeJ4B0SbwJp7P+awjrWlViF?=
 =?us-ascii?Q?UYIcrtBB3a3ou97AhxTVDe7PTNzgifI1nO8HaUzI5ClAxCxAFpSBGycbWvgz?=
 =?us-ascii?Q?c+YFuZ28XIMSdmE4cE1hAz8ygdjUau8lxRANdqMR1LKgdj+LmPmqwlLyggLG?=
 =?us-ascii?Q?7ZVlT32TdQPCQORLDI8JSVDsFzGAkDm5OFFw83M5hzgDZJeRCCoPBhdfqwQW?=
 =?us-ascii?Q?guzCeso6LyeqxP2ojVpNKYoClUhnyqZO9LSIfnUG9Ytu4pf6Twm+OoswcbL7?=
 =?us-ascii?Q?hBUde+l83npEoEEZxEhqsAtqHvkrCCmb7895+A/jOVAUQemT0gQ4eMj2x1s2?=
 =?us-ascii?Q?1awDpNX46qxUbLwbchDxNsLJuNq9rmPUBex47bP3wMjmxYSTgt5l4Ribv28E?=
 =?us-ascii?Q?USwLdVdTIv1iUNJ87YAj33VaBKJexGOFfrp1OxSCUdmY7zhL9XLTTJp4BMN4?=
 =?us-ascii?Q?FIspD5Sb8O3YApNkTBlS7G1mQ/GLnu2NIv/rvKje0AahBQHS+r4fhcqsbroW?=
 =?us-ascii?Q?+UOZXhPi2mSyrKXFuBBqLlQ8uniWOStVqyrZVAtpm8qO0J1QYfHt9eo2xI1q?=
 =?us-ascii?Q?xmZO46Qglm205Mk49my2+hXg9zYjtqmm4GuU5H2m6W/YIi+9Nq4rzuPpcvxs?=
 =?us-ascii?Q?iiT4s2kxybf+7Wx+qRiZeF1rlJG3xqfCpGV0m47JTQ9MDynl3PIo61pG1CPL?=
 =?us-ascii?Q?w5IDa+TE85csiMrKTeV/XJrnViPIhj6jJgrnQaVF3FWMux3djTbcNf09bGg/?=
 =?us-ascii?Q?9M4jJv1bfNrl7joAgFFFA6zHZgyDhCwC8xDvr8l6uiQL3MFBQuvtXqbMU8Dp?=
 =?us-ascii?Q?/QWb1nvtAvXtf4cjZIPfWhxW5RLye5EJ7iB+XG9wADq9HSz7WpmPlWohecaM?=
 =?us-ascii?Q?CSpqins2FHNfFZcR+ZCNlTr1vZ3D+rom9jN7FIA6QVQqJQGrW4/jMvkcwzw6?=
 =?us-ascii?Q?+Auzddi1ng0cSKm1uhv80MjKt+anhkqi/4zkPuCT5RE7lbXcMvZh0lyfi/Hd?=
 =?us-ascii?Q?4I0sxiBgbntlq5DZIjtkQ90XQq7nJrh/Lzo3rreiwiFxJJeFellXMXTHvE4q?=
 =?us-ascii?Q?qhCpGXzCpx1WDgSksQwvdQAqzlAPG62vdVzdMM43dBIKe4Xvl5ii4/qxfN73?=
 =?us-ascii?Q?Gmy60efmcFTdkAbsIUFnQNyZy/sayfRBx/ZAODSjbSwYmwOpd4EJ7+jqi3CA?=
 =?us-ascii?Q?hdEPNzXqgDp3B+rfE+h9+rtH7cT0ss7lnywsHfYIXN2Xktf793AWZEyZ1CD8?=
 =?us-ascii?Q?vkeGvmi+3bJ7q9WBTwOshQDRt1gWS9RzZiuz52hwhF97eWqN2EOpFrYuGGUX?=
 =?us-ascii?Q?w3HPNATEbXTLOb6AK3VJ/0BcRbRcFVaCmwtmEVkE/p97zDYqnEYiXjKflsRg?=
 =?us-ascii?Q?hzTR6EnR14SRPUobATMxQhw6jkiWVT6l+U4Z6i2ponOXv2xqGrTXBlH6mhYN?=
 =?us-ascii?Q?oikysnx/gEgX+Sus948MIV7NKhqkDgLUs0LoeRXnw3OKZuCPH64U1OLkmvfR?=
 =?us-ascii?Q?DYouY8xL6YC8RuqHqf2++xSO+PC7YHtclk37NcQw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb76d928-135f-4547-4fa4-08dcb093ae70
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 12:32:31.2470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiyjqQbdOg8RrI2t/R7gVjwFuaeESrhm0v434KIcB5Ay98K2xSQ3NLxJtH+Vy2xwB519MI56pKToBeGywUVDoW9FenSsPABXE3plQ4OCHc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 12:32:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16686

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, July 30, 2024 1:28 PM
> enable/disable regulator
>=20
> Hi!
>=20
> > commit 1cb7d29157603561af4c38535e936850ceb99f0f upstream.
> >
> > Add a helper function that allow regulator consumers to allow
> > low-level HW access, in order to enable/disable regulator in atomic con=
text.
> >
> > The use-case for RZ/G2L SoC is to enable VBUS selection register based
> > on vbus detection that happens in interrupt context.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Link:
> > https://patch.msgid.link/20240616105402.45211-4-biju.das.jz@bp.renesas
> > .com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  Documentation/power/regulator/consumer.rst |  6 +++++
> >  drivers/regulator/core.c                   | 28 ++++++++++++++++++++++
> >  include/linux/regulator/consumer.h         |  7 ++++++
> >  3 files changed, 41 insertions(+)
> >
> > diff --git a/Documentation/power/regulator/consumer.rst
> > b/Documentation/power/regulator/consumer.rst
> > index 0cd8cc1275a7..ebc4c8076711 100644
> > --- a/Documentation/power/regulator/consumer.rst
> > +++ b/Documentation/power/regulator/consumer.rst
> > @@ -227,3 +227,9 @@ directly written to the voltage selector register, =
use::
> >
> >  	int regulator_list_hardware_vsel(struct regulator *regulator,
> >  					 unsigned selector);
> > +
> > +To access the hardware for enabling/disabling the regulator,
> > +consumers must use regulator_get_exclusive(), as it can't work if
> > +there's more than one consumer. To enable/disable regulator use::
> > +
> > +	int regulator_hardware_enable(struct regulator *regulator, bool
> > +enable);
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c index
> > 7082cffdd10e..c5b6979b2560 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -3244,6 +3244,34 @@ int regulator_list_hardware_vsel(struct
> > regulator *regulator,  }
> > EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
> >
> > +/**
> > + * regulator_hardware_enable - access the HW for enable/disable
> > +regulator
> > + * @regulator: regulator source
> > + * @enable: true for enable, false for disable
> > + *
> > + * Request that the regulator be enabled/disabled with the regulator
> > +output at
> > + * the predefined voltage or current value.
>=20
> "Unlinke other functions, this can be called ...".
>=20
> And fill in the blanks. "from interrupt context"? "with interrupts disabl=
ed"? I'm not sure what real
> limits are. Probably can't do that from NMI?

From interrupt context provided the callback function does not uses any sle=
eping calls.

Cheers,
Biju

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

