Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E85C36005
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 22:47:02 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.web10.9390.1742942812293303091
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 15:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=SPMwuR60;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/w8lFd9E3m6cjsx19NkEGKmjwmtzFAzh8/PEIJGljRdiiL6dudHCan8uisNgFVIJ9+mMIgUl/YptXxwGBh7bl8ny2LRmxrXDfwiPTxNjqXPZ9MqGz4vaY0rdIELPH3HkwFlfsGCiMkSWQxdEYnz69MAt4KuP68v/AGnJEuZ9d2FwiBTiFdg0x9SxD3QqpV13+01G0qoo0IXagrMZhF4NRem43OjkPn5UbVn1Jy3jFXZSpe3A6XYGBMWmNmE4R+eEpAYlBZgruf3iApTplSRgmOTvFMNJNiHkGYiX4gh5ELCElV8ypiPD/DE+trUnwqJvPjdpto5tF0FrLoOqnt81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDnO3uoYKY1ALKFbUHCNN6aGc/PqzuJ73uYbxBA34v4=;
 b=oUIn9atbBJYRjXWT1p9r1mZRm3RfcRUie5LHG8wcDDoCF/KfDb+FFcoGBOrO9uyoK696jYTVpCdldQSkHZ+/5x+WfxkYP1inGdw5csCjRBelV4jWfx5F+NXGCyJT+lQdmgxgJJuvp5T7/V/4VYqwqDouEbWtdnXSzqMeoErulV7tnGZvxPyRX6RSFmSiCDDKGmaxgw7ENSmCOOeU1Vj0wZziNoVz1kiw3Otg8latv1h2NDA6TMnib2rs6mbhb9HmAnW6p2083D7EOBPmixw3XMsBgwtIHwstYKlRZq4nh4R8xoMdUv2t/uKiSHl4kFmqyMLh0tN1JxrhUrIkq6tO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDnO3uoYKY1ALKFbUHCNN6aGc/PqzuJ73uYbxBA34v4=;
 b=SPMwuR60Qb1QH37wOlBndkwHvYJ0B+oYZe6rYeG7hf7x9pNadIx/h/5GkGZf+4Cjl5CTaoSpkBJxgG3H8il6axUkQh8gs+bT0qajkmVvAqli2rzE44KoOAxHkgmkpBCQTcpHrfEBxvKEFpmwwYQoNjencvWAJFcSUFa0eMhL47k=
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB12547.jpnprd01.prod.outlook.com (2603:1096:405:19b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 22:46:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 22:46:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai
	<tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Thread-Topic: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Thread-Index: AQHbnZYZsQqvfRHVJkCfvjmPfZeu6bOESaWAgAAqZwA=
Date: Tue, 25 Mar 2025 22:46:44 +0000
Message-ID: 
 <OS9PR01MB13950C71EB1034F5D5B5914F1E0A72@OS9PR01MB13950.jpnprd01.prod.outlook.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
 <Z+MOeS51tO4dKnpL@duo.ucw.cz>
In-Reply-To: <Z+MOeS51tO4dKnpL@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB13950:EE_|TYYPR01MB12547:EE_
x-ms-office365-filtering-correlation-id: 6d39d8cd-9606-4bdb-ae7a-08dd6beeeb29
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?h0T1VURIwZvkBt3NS/8DFln0d9IQXWylPjIs+IcKZ6cJ8gN+VqjFTMXjYvGF?=
 =?us-ascii?Q?SidLKuZ5EZqGMMk9kuuK1vUVnrAJ2jrdbJpJTkuSnXgELU2v+QZFJXntUBbx?=
 =?us-ascii?Q?oCOST5G94qiEDiE141LmhTbqWVIE+fKRn5YXYQIdzrdUoAtcYR65frWUi0Mt?=
 =?us-ascii?Q?YAyI7qNH5NlaH/t3/AKBupV24WggcAiG1DjA1HeGCTDnbjQ0AlYpFHAEpXEE?=
 =?us-ascii?Q?4wbNxIEtYkZow72vNOXFxzU3m4SheZ40ThAZXU6h5AYec1Sp3glDHe6vorWY?=
 =?us-ascii?Q?UmXVequyDsP3D2ZFVFsNBWn4nmwqAIawrtz6h7QRAJfYmYsPOGEhxP0M8Aev?=
 =?us-ascii?Q?il/TdRwXVTdcdZtC2YUr6fho7SBlIw3TKxLaW7NeB8f1ES4IvwTbSmHMlG83?=
 =?us-ascii?Q?BKiQ3VBrToilaIl4gJLQkAOWSCW5J1jvGl2bH5M5yLWQRZ9RLbqS+O12jfZ+?=
 =?us-ascii?Q?Vpi8VCWbhlOI81kBhOo4FmPHKVZnVVLRbWR5VDyP6+iXA8zlo0yD+JfnN24W?=
 =?us-ascii?Q?IqYlO6fo3w2yTI5jc/FSeQgfW9zybSeGjhUlzcaTl2BDe43k7bqtMdEiyyxm?=
 =?us-ascii?Q?pJMNzSkKxehvTCUT6kqyXTPnASkuQrkL3RYAQVvz7YR+FkFay/vZuxvDs99K?=
 =?us-ascii?Q?ABFoL0RiB8ZUJm4QJH0nXqMh3FoSdVCjlh30pCj/0w7mLidpAFf1Ad7xdSip?=
 =?us-ascii?Q?phKrwHzg0KD19Pa6bhHNgKCnhhSrD6Sqcs4r9C6kB5QEx30spSkbqku7RI8B?=
 =?us-ascii?Q?e9iNXxAYjCwtgpbRceotT2VL3O7lL160YdS3MNneykRqoJRhJHhGmAE+GutK?=
 =?us-ascii?Q?DM+HH2bVXP0auptq+lMfyBi3w9LGe+4rtRKa57Ivur6el2n9nxB5mSOhhVVb?=
 =?us-ascii?Q?9BuuoKEPlLUzm2KkjkJgTe/ZpSKetM12Etj+us1R6rtjTKM+y3BaKoYGMlvV?=
 =?us-ascii?Q?y7GcNB3sMNpJBXXOp6syp/L0hGLg5MXxcsiIdS9ZLqAN0TsczuKJRbsg2jYw?=
 =?us-ascii?Q?6x1PMojCGZa54oVHJOb6eAi98zqYmIRh2OuahvpvG/xa8bnjSHwCsvBA8JKP?=
 =?us-ascii?Q?Pyv0eSZh4IJ+fNscDaKmX0pfxk50xgOkDnEqxIEt2c5L/JAhLxx/2OqkvJDw?=
 =?us-ascii?Q?yVF/fkBspZiqWN7HNxXHbTqERUHHHUgpK6cl9oYrBItOKzopj1a4WJi7aAky?=
 =?us-ascii?Q?P6RWYQCJVsNH3UfbuQvFvQxPc8Q6rKSu5CQtIcZRdnzZ3I69JAjk8H8qsEXO?=
 =?us-ascii?Q?Jb3zI3hjzt+l10NMXSaYKuSrhZDcV8HnAsx/Sy5Jv/db4b7Ss577FnqTj3KD?=
 =?us-ascii?Q?6WGawT+uiwl3hrHcu66PK1mQhNUVcOyq+5RECrUgnINSd7Q5Sj1fjSC4kCRM?=
 =?us-ascii?Q?JqplZRp+9cRLkgFSNPO5JNqNxMXgkmj3mTiHkjgPAC58Vv/m+JUtOyCtaofq?=
 =?us-ascii?Q?O5csW45kGW0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0Qn8csJJon5bc90qbA40MIVE050AP/2fxWJ0rTEd2CbYbKqIqdU8cdYZLjPV?=
 =?us-ascii?Q?wo2pqHSRkFaKBkYkXzvo+3dDzHgWZ4sE2ya/OKYH1CLsjaYrvxnDG+N9G6ej?=
 =?us-ascii?Q?BwVy5HCu6uKbcC99/pYpNjinz4UQfq8JKqLq6e2z4yFQNshnh0Ug1zqAJgkf?=
 =?us-ascii?Q?1WS1rPfD4CAEINPih3rRA6zMYlwbKpZ9/4JJmz3umBLcdxTyiBclLz74qGfL?=
 =?us-ascii?Q?BchwFtxw8a5nRDFAksNBZwwjTBvC4tKBIGuupdW8GB73XCy7tIiZyxHNS0zc?=
 =?us-ascii?Q?59esDQH3Pt8InUK9zST5hs7LNErXDati3BiM70/yD0rl7QtQyqZ7oz5MDr3q?=
 =?us-ascii?Q?Vgqh9rn6ESlVn7D+46GxWcEcnbw15cdzI2/hP/YFwym/OK7f9OZOMLCirvSs?=
 =?us-ascii?Q?7HZKQPVK1WzBYyKNY5jDR3MbHK3YGMumyI1Fw78sUpKxSD9Oz4R1tZZM0gXg?=
 =?us-ascii?Q?8kNqzS3yFPL1Rj429EUlq+OEunsodCY7ImIP8CWzGFJqlbUnLRUcpi4Y6YRu?=
 =?us-ascii?Q?kdTx2pn5gnMJdMqEY68J1xhPu7zuZ6yUIYUk71srmoBbe6s5sdYKAA68t05h?=
 =?us-ascii?Q?Vl4xzysznuoZgRWp9ZNbfrcVzXU4JYKbv5oAt6Smgw9OaxPMgWnlhK3+OxWH?=
 =?us-ascii?Q?5mzKGWi2hELr+Q7sA7R+erh6BTo/ZclZdIzKMdc9PhMk9khRCI71XtxW2qzD?=
 =?us-ascii?Q?g+wcf5Zmd/LQe9ZTkgyQhy6V8oqw/QZrOOjTnIGExR40IM2q97Gv4N3jrheH?=
 =?us-ascii?Q?AO63f8XctfCelsiv3Dw4zbpC9hEQwSz9DAeDmZYDsd21xOiY3G7I196MfCoO?=
 =?us-ascii?Q?U3eNWdYTK7ZY+p4+TrEjn0NthXWe929GMp9djzioXArF2fy9MWROIENHCFjk?=
 =?us-ascii?Q?Uhoxxun8r8mTOvSGH9h+UqoAV/6o8nWMROBtUjkFGDXKYd8a55zlU5kPGBw3?=
 =?us-ascii?Q?X9SP6yRTL2087vKMJCsvbDjtYHEBuFHPHTB8aOl/opWioUgldwywnVLFF56P?=
 =?us-ascii?Q?wkNPIlO5vmfBqzcad9n8bWBggmO1pEbH32FHerl4le896Ov6Y/7jHm6c0Dp4?=
 =?us-ascii?Q?Bs0glLd9F1VTwfm0Wfev1hqYyC0Hws4L3qo814jrtvmNXvPom8dsFioqi/fx?=
 =?us-ascii?Q?wutv88930LhTDPkABeUY4iAy2r4rDqiTRl4Dvafcuw1qwL0lUU01VIa4kaBs?=
 =?us-ascii?Q?yTvUcw5Gu7+4fiy45yv8BOhxLqFvzwg17GoYUZMbe5lqjaF12FXo9A7yIJHY?=
 =?us-ascii?Q?4dKJvMFOtt6yOk57felkSiMLmqSubMV0WQmBLmCVxa4l9zfoUU/tWq2m6hs/?=
 =?us-ascii?Q?q5ddFfhMQQaFkh3llWrReAQOYd5IcjWXViFQG1zeI5hwDRcfAcibSUdw0cTN?=
 =?us-ascii?Q?VzYNsbmxViS6nPiaZs3Ob+04DDPtA0rrP810oP5qfm7rGm2XOoDYWK9fQOSE?=
 =?us-ascii?Q?OKw7Hi+OupPECECvBnDOjaPaPOnCQ6KhkZmyF+8uE+iCHaDauNlVGOvOpx8U?=
 =?us-ascii?Q?ajN/1ONsV2M7GmfKqxUfVuYId0xLVOMQcFtVCYTXX0ZHFPGaL07j52D+uNoN?=
 =?us-ascii?Q?+C5SQiunNe3F3UZMY5zjntMbPbmOrvt5L6xLrVNDWcTA3czyjCVMkbVPT6EM?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d39d8cd-9606-4bdb-ae7a-08dd6beeeb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 22:46:44.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhmMURlq0GZs/AF1/2poWLierbs7oznw59QEF95t3MOuLVUwjPFFP4IvbbxHR+gLkwNid7oSAu2W++SWYwak77vQgJ4W+G9LErj5T+tE6tGe3JkIyJuPTVDgvd0OpkoX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 22:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18368

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, March 25, 2025 9:14 PM
> To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>=
;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Tommaso
> Merciai <tomm.merciai@gmail.com>
> Subject: Re: [PATCH 6.12.y-cip 00/16] Add support for Renesas RZ/G3E SoC
> and SMARC-EVK platform
>=20
> Hi!
>=20
> > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > RZ/G3E SMARC EVK platform to linux-6.12.y-cip kernel. The RZ/G3E
> > device is a general-purpose microprocessor with a quad-core CA-55,
> > single core CM-33,
> > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
>=20
> Thank you. It looks good on quick scan, I'll apply it if it passes testin=
g
> and there are no other comments.

Thanks for your work!

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Kind Regards,
Tommaso

