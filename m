Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93518C64E76
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:47 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.91])
 by mx.groups.io with SMTP id smtpd.web11.3484.1648841573155038008
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:32:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nFYFAdwA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.91,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMPHFSWOpjJXOxRADI4NL008AuzLkLZdg8ibwzTBDTfamaB76H+wbe2Mi6ddC4psgFmxr+K351ADVdlabCGezoTNSNG1RUmhTxhQSyYpAgsjR+yVHtGPsTXGnil++fgCCmpNKM5xEv2cpTXSYVGld89q24bipuPNccaELlcxURRcCahBkfJ+eT48HrBcRguo+n27KfHlWOpF2odm66U3zlhqUMlSHeJgNPx8ZrWXugObaMQGDKhrz2ikSgUR+ouaL40SJ+pu3BJb9DXFGhZpWpLbhjkmLOa4/ZnZDTRY4xmLPDQeLVGoKVqSx73295Uh8g5qvqf8+jXTC6MYS5yXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N02h2QPZBIKL4iiDL1nUCPj7BRFmNmwmCsaqUfqfvbY=;
 b=Y8R38K5tnkuSvwXptnBAkDZtOnXAswEnJMNi1/CTGDpYRa3IykvEDqt/FBQ/vuMURnX/eEYV2SyuCBnGK4m+A74gUKUiv8Uj8bNGGFzDVI9Uz4d2zihMTBLQU4lzbRjVt4lAUCVfR2dBSiilKIvxi0zY0AAuMWnvUYd9mLp+vX4ycjvm5xNhvmfhZrJlTgTd9Z0bZdaOUT8ZbgW+bmbiXPEIdPTDvKl2c2nvjy4pf8q+O0AvlO1uK+pE6zoy/ZjDYuwzDWYbdmJT8mUKt6fKdqsq5VN9GnP14bBeGbFWsXxUkYLzEhZpT6EG9ueQPXnRHsWAS56XzRzIht4nNXgnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N02h2QPZBIKL4iiDL1nUCPj7BRFmNmwmCsaqUfqfvbY=;
 b=nFYFAdwAzSawr3sd9Qn8RCqs9u2RcIpvuY64fGIxf9zIv3PkxHpek/rLcgnXHV4s4Wx6v+RlJnWLOO/Hffvq33KrggGkyHYd/TXRa6NpKNwq8ubuA7dP2A51IXzcC5kcpqzwEGwyDnKvTUEDoAxZ42Bc/qgc7TKqETLVAcuOejM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8568.jpnprd01.prod.outlook.com (2603:1096:400:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 19:32:48 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.029; Fri, 1 Apr 2022
 19:32:47 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 32/39] dt-bindings: Drop redundant
 minItems/maxItems
Thread-Topic: [PATCH 5.10.y-cip 32/39] dt-bindings: Drop redundant
 minItems/maxItems
Thread-Index: AQHYROk4BY+MimMCikuprvCt1oP0uqzbdA5A
Date: Fri, 1 Apr 2022 19:32:46 +0000
Message-ID: 
 <OSZPR01MB7019E3703EFAFB076DAF2159AAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331102221.GF21513@amd>
In-Reply-To: <20220331102221.GF21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 702a33e2-d4f0-4a17-4ab5-08da141666b2
x-ms-traffictypediagnostic: TYCPR01MB8568:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB856816DE2300F482DA79E86BAAE09@TYCPR01MB8568.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SfILDL/3x/v78av07kzOA/jHZ4hzhFryDgLAtmf+QpJIE5b+r4I0JiF/vWktTcz3OaKaCKhCcKAoevHXURHUBCMawQU6OZuRIPQptxPh3EoaVAleWmiGuGGA7vucRn8SJ+0PcwEg9M/Y7SsE34W0oHRqRYOcKjTauDseuzrDUOtOfDZZlta8B0fQ/CvEZCF6ix9OUrvQLyfR78zqvjNOSmrZrj8eWHJIeY7NNXRme2Vd3yGRhINcGXNelDqUmM9QG8CaUFgIcPrb6aYULlmCcDekNvvz0ZEQqkMujDHRKbroaGvS7wlupWH1dSDwJQtdtiJPtKB4M9J2IJ8cG2lg01ID/37oLIG78KZHjB8vHrHq/ze8WrnccPpcSbLWv7QQ9tGos7r6lhjJnM6nub0dvoA6hyRw5K2dNQ3/G3Ox6ay4Cy/Cpk+crOW7eV19n2GBTopskfzkb6+sQs9LXryLj+jcS7EeUqQ37gkrgY1zNiXydzgL2T3ZmrLQpEUwLjRRR/VTTIFpqTqVM8540axHujJK+DOc30U3ycXci7/qIlzPHU/W5duYbxSyFfxMU4cEKI0Cpo+YQ35jpcgPH6kWZrkUjmG2u0zY0UbhzMf27VCwhBqD3/n4T8/TkdX2WqkX0yQiOkUzVaAFgfNl29Rh6StKhmuDI0VRWtueQVW3Vi6pkSqSzoavZ8kaGbCgbb/0MdRebuJGIrtSu8DKOqZuJg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66556008)(66476007)(64756008)(316002)(66946007)(6916009)(54906003)(76116006)(38100700002)(508600001)(38070700005)(55016003)(86362001)(8676002)(52536014)(5660300002)(7696005)(53546011)(4326008)(2906002)(186003)(9686003)(26005)(6506007)(8936002)(122000001)(83380400001)(107886003)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?FYzewuj0bPeAEs5ux6DsYrhjsbmKG+tbmoziVDddsAXkw9yNTbDUrYEPAQBx?=
 =?us-ascii?Q?lMyDBuHgD0uJY8M7YOLzy8unaMG4DWQErIAmYAducuBC8kJrvCQVxPLzKkpp?=
 =?us-ascii?Q?3xjEpmMI7LyKoxCk4BO8WMKDERws9e89dzv96OursSXrhnh/cTp/iztitPzm?=
 =?us-ascii?Q?6C1/dPIViISbEv0OyPIxSnLnrBuWe1GFacr5VgjP76xqAB4k9vLk0wv1svW6?=
 =?us-ascii?Q?0GOup21XxXtq9yNWk/Esx7kEUsdP5NzXuN4DdhCJvCSJK1KsvU/ZAdiWDR7r?=
 =?us-ascii?Q?xi49YLf1fYtz4PxcAoS0N137PqDadZjmXcH8IqHuUbApXAOdqF71msgZfq2A?=
 =?us-ascii?Q?dnKKbIQ/rlkjOGyCk5tjWCYwwcCAuRzEKQSos+XsdYf3O4+CAWXzB3u2bchq?=
 =?us-ascii?Q?2sWs7X9UFQjXWHAg0YuZ8bEO4ATWPHALRH+udlEidbF7Z1DSX+JswXvsh/f+?=
 =?us-ascii?Q?0lbFm+WWUTlIBk2426iyLqevrd3g7DSI/w5It4+7OvedSfLBCICIo3ucy8r3?=
 =?us-ascii?Q?gnoJq8T2c41hxjCJ3Sk2GUE5aCWi9Vy/DeUvaRr9tOgOqZWjMD3xRp2Ev8e7?=
 =?us-ascii?Q?5bLnY6QB6zRgSlcuLqnWDJ2HcAvRciKt8NNjnmT1lsAD2NDGO4Ny9tlrysF+?=
 =?us-ascii?Q?CTtkAZCo7vdg7Qo9GkvC+fOxVi3r5h6KV4J0pgBv0CgMU8UF8Zo9XySuhh+v?=
 =?us-ascii?Q?rwXtwuzeQf0tQksPBmOCOLVEWjU0iWloNRNN++Pizmh6z+gxHk7z0XrV8l9M?=
 =?us-ascii?Q?9l3N89XZuGVUZ+BNpA4PQRnrIBrmWUFYyVAe/c7zHqRcnM/1Fzahm/a93tju?=
 =?us-ascii?Q?dN91VSbccjqH5abCCAuaW1C7NiE4fGK5uWizAGRKk5nta1+qjUg/yu9Q+6Jj?=
 =?us-ascii?Q?WZTH/tpHGFN3hIjuqRXxlDfyf4eh8bGn3MuQUT+jW2dcpGmpoj6BTU9hhtyT?=
 =?us-ascii?Q?Y6ihoPcgSewERMPwc8JVpS5ZM7Tppd4GdrNSLclvYJYTAS36y+3mrStYRfxw?=
 =?us-ascii?Q?BGNvsI95tJNTdrpTkeriDUDnz2l8iJf1yBcstAiZS3LnvTPUdi1uTeBrXPDx?=
 =?us-ascii?Q?TaYNsZKoOuyQuSp9y5YSluU7YiK6pB6ZK16UXjtA5jKk5YjNmE1pP2//lRRw?=
 =?us-ascii?Q?AFhfiFVf6NxNiNZHhPoU9ckjEsm/upA0AVBRRla0lWa/2ZLCLIjKwISqRHU6?=
 =?us-ascii?Q?Ke1MwlvoNiBzBN+6iUyNnxToipMmMKTcHvhRt/SsRpb5MPw7XiJVY95BS3Xr?=
 =?us-ascii?Q?pPHmpOqG7PbBpgKTL6y5/Y4VbbY5DUW2tWcXk/JhaIi21O31KyBnzYBkysjm?=
 =?us-ascii?Q?n2RYCVrxd67tkIdQT8ol2r1ly0yH2lmJGXF2kIVRqIO9cqOfOf9OUBnSlGsr?=
 =?us-ascii?Q?w5jRQJ19ILLagpIOpj0F6HNU1+tN8IuJlbhGqouY5tf+ssAhdkKq1u6dgiln?=
 =?us-ascii?Q?4febWDi50W9BbpVO87saMLPDQhBBPKHJ5XAkXe8bM9UhfckI8LS6GtkuEGxK?=
 =?us-ascii?Q?To2q6N5CzRQtdfz7TEYteyH2UPmLOGLBleFWDa6Oe10caQhk8z8Sy50rzI4y?=
 =?us-ascii?Q?bAOzha1h9q49gBEzbtq3yB+TdepkfcTJm5ptYurIPeljZNOXMGXYIWw+CBTv?=
 =?us-ascii?Q?cNw1st6oya0hV7KmIDMMFUCmME7QY0Fz5/QY/iEga2f6w/fE6Emh4HN54jlF?=
 =?us-ascii?Q?iiHOl6k4eLW4aMpJ+viNgM1G/0rlgBuCxF72c873cqUPYMyIbPKnDHMAhT17?=
 =?us-ascii?Q?2PNcgzwYGo0cEYwRj4EFcuR7irJ3uw7eMzwWVJ59fo8IeiP746gW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 702a33e2-d4f0-4a17-4ab5-08da141666b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:32:47.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 cYmUSlLJH/lwZdvQvIa5sed5V+Cj9gXhu8ykv+8p0UhFeFqbFdOKF7FC3+zQ6O5EQVk7GGU13nDUJs2euFxc2O+J0TQAj+uF5edgb/1DM3jc1vUTtsUhjsxLRkjeStXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8568
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7909

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:22
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 32/39] dt-bindings: Drop redundant
> minItems/maxItems
>=20
> Hi!
>=20
> > This condition is partially checked with the meta-schema already, but
> > only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> > An improved meta-schema is pending.
>=20
> Do we have the improved meta-scheme in 5.10.X? Are we actually running th=
e
> dts schema checks?
>
Right 5.10.x will use older schemas. Let me know your thoughts If you want =
me to drop this patch.
=20
> I guess it is not a big deal either way.
>=20
Im hoping you are ok with this change.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > @@ -74,7 +74,6 @@ properties:
> >
> >    clock-names:
> >      minItems: 1
> > -    maxItems: 2
> >      items:
> >        - const: core
> >        - const: cd
> > @@ -106,7 +105,6 @@ properties:
> >
> >    pinctrl-names:
> >      minItems: 1
> > -    maxItems: 2
> >      items:
> >        - const: default
> >        - const: state_uhs
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

