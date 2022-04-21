X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.128])
 by mx.groups.io with SMTP id smtpd.web08.20142.1650539937027919278
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:18:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Vz9r+/oy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.128, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaiJqJckZUvKo5XBnPX8hWcM2B+rubtx+vdbMebzEob9s8enlr4fC+7FfiRzUWUNxTkCvTHzm+nffrC+aYtwcDQiIHEmXhAAphZ/0vSnEOgy38CA1mDV7ci4+i3CT2/zMNuI1sAJ0UjPiNTCARuDc34BsnPV0xBrJMwMyvLP5w/1QMP2I+piQ2bZbk/lAP4wofkbTJJyUQKSrhftKCDECtl7fMnLAiJI7OUvWKLkPiwCzf3x44mAvFO+m/LJbOGhZf3OasWB/6NyT5WDDDq/UPV/JEJ25kAmhH05BQuieXVbuN7WS42SBz/sCkd6hZUFfQOoXISXOXE+X1RrolTSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v5hkt8nyXxltek9X6RCl6eMkgyy724N7c0s73eCHEc=;
 b=j90oSfO4AR8zouBeMmOl9HEdzTB26VUyoAiUod3VCiausVleCDROIva2eD+LhHpBvtDSGcAqdjJcnX4MjoeozXFkNeB7CVz5CTvSHK6nghEqIdqfxH9mFEfUCE/eZHleBhzq8a8/oAt+KyESE56usXroawgnLxfzxjfo6sfcoiQa26drHEyo/3o6R8jAKgf60cEpv4Tj7KXEPkDmVZU1F/zFxIHKd3ULzcatAXW66UgxoV3YOlPPiJpBmOEEjTw3CtK0CHN487nc98721s5amsqhGbAbw7NT3uswjv3UoJ2NV3vfA1T3FK37c7WAbQyavkvVftT6u7aT6jxwvaeeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v5hkt8nyXxltek9X6RCl6eMkgyy724N7c0s73eCHEc=;
 b=Vz9r+/oyUI8XvwYpTEpogxWUWTPHlaJpbo0628XHFJYFix+piLbhfBSp+KVkBmAcn/GC+FF6gQVnim6qCYmHFGZjZg49uHxGgTREKgyW9Uc70F5dxCZMJUiDiehjxYYIHZaX+yhx+udkp9moBHHeSxGScJkDBRFd+UvRZptoAFE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB2637.jpnprd01.prod.outlook.com (2603:1096:404:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 11:18:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 11:18:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 5.10.y-cip 21/24] arm64: dts: renesas: rzg2l-smarc: Enable audio
Thread-Topic: [PATCH 5.10.y-cip 21/24] arm64: dts: renesas: rzg2l-smarc:
 Enable audio
Thread-Index: AQHYVXEfGOZuM6obdUSDGcSG/jU2gKz6OBFA
Date: Thu, 21 Apr 2022 11:18:52 +0000
Message-ID: 
 <OS0PR01MB59225070F09D70B65B40531F86F49@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421111530.GB9759@amd>
In-Reply-To: <20220421111530.GB9759@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22e95acb-4af6-480c-b9a2-08da2388b779
x-ms-traffictypediagnostic: TYAPR01MB2637:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB263796ACD9AC5443F3504D5B86F49@TYAPR01MB2637.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ynfat2f6G6j3rIkemqZm7USrmDSbOV5dlFAfHPRiaW76lYqwxwuD6fJ0SOEbFvXmBfaqDQkZ22/6A+17c/toWg0rKAZh1RlIGGC/F7TB5mlO+O/lbq4H1NK1ioOEaFrbu1PLCxj8KbHLQTZH3X+qncmOUpuPJrTMk6HgC8oYHH6vlkQCH8c/IPi7605gNP6Gs9jJGySqz3tcIitsdmpc04nmZa0g0LUNBXp67FdNMpwyOx5n5t557a/BIkGThdp8rO+TK1MfLYRQlOO3vmXYoZSySoqWYnvu9yJu01i7oRyJGWZ+7IVn5S6Dha2CfMtO9qkMkcJrGq5qwvFfygIXWBDV513m+ge1gyG4EihszTIxdT7ZC/XpV+ujlaNrGy0ChQatVxbCYCMrgMtnXRtDrUYOYF7XtmF34MQDVKuPQwRK0y0Kb0tzy0VMX03wqDedBwMOO3t/FWcRgqDERpnjIFBhYWHGMdDWOHXQZCNtSgKFuLnViaNLRlLnbcuHMhjxxwdDlPXvMhAlkvSRf4psyhsvmdaYZs9wjak/D5YLJyJadG3ZevcoQw7UDpyYbEbEd/a7m2eqITKFZZH91FqCt4MDk8ja84q4eG2nq41qumPHXXfxNp2iYGE3uuMLfMMHu5p0J/DbdLO+BPvG/V5o79vazfl9p6J3tgb1k+x9ZlW20IZf3fWbNgIdJQ2W9Cw4EkhD+CUVF05aQ5P5RU5Q9A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(54906003)(53546011)(110136005)(316002)(186003)(122000001)(71200400001)(83380400001)(6506007)(26005)(66946007)(86362001)(38070700005)(52536014)(38100700002)(66556008)(8936002)(7696005)(66476007)(2906002)(64756008)(5660300002)(66446008)(4326008)(55016003)(508600001)(76116006)(8676002)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AgOvZHlqcVg7LcFS0hTWdLoFGjgSCqBIudJ98O2+2VHpO9AL/BN9k0CulCtn?=
 =?us-ascii?Q?Z6RYoy9fpNfi/2nl8L2vdp+TnRUJhzOeu4c1q7kvre2xrSqwkM9Z9xKU6g4G?=
 =?us-ascii?Q?CVpiiD0S7fmKLJfGcgiN9QzMEF+ICwS+90AR+4+sPeXkveAZk4zFRjPCur4o?=
 =?us-ascii?Q?6Vk5xMvVETxqhORklF4rlSg+oqJeRAPcLJ23Y+OozbjvTOCbXjarIe+Tn2tK?=
 =?us-ascii?Q?ecBC21Y4B9qsZqg6Dd79xaWsdpUeYNxOTtPaYQ+y0hPHpcDIZ5RbE9avsHiJ?=
 =?us-ascii?Q?mheTxAooxoRl7nM4c2FOylHmgldf3jCclwDCWfVX28evq4f2XnCAHu+jKNvR?=
 =?us-ascii?Q?iXrX5asDRdpfvszvgzpmW67zWNFikAVm4jbfO7jFjRlEkC2f8eMExJDwgo+b?=
 =?us-ascii?Q?CagWxsTPl3b1711htsc3PR+WP63HPVZQKugr/MINkl9OGjUiV75Auz2J652o?=
 =?us-ascii?Q?QhvmPEkhhucFQslR7mUWcF/vPQtGUjSsYtF3HOeIQTg5Yx1dDMKmGfbcVU4F?=
 =?us-ascii?Q?oJS9hOJZ8C2cSfO++clzv3g+/gRdLtj8h2EPIYhDrmLrAYsFXJpOkpeb+Nm+?=
 =?us-ascii?Q?+68LUxdQjbMZ/V7QMv4DvB/9GSGA/pfvaFmSNU856rGJRwQkmE2vBXq89jf9?=
 =?us-ascii?Q?iMLiy7PaE2neJE7FdjO1N2qlTqDjf6d+De9OIms4LQCCRB5sy0jk4iFSVKqd?=
 =?us-ascii?Q?OJw8fy3dkqaKUlviKbQ9TBdj9wO4WptN9sQjC4/EDYPYA7vI2aCnzKoWPH2v?=
 =?us-ascii?Q?S3KLhdXL5aP8n3lkH+2H8q3y8v5bRs8IZnIuA9cdMNa8Pko9hE6C/UyFQfsQ?=
 =?us-ascii?Q?KnVkZw9fZOr9vihdX3kZqpKBmW8ApHrnDjTQh5s7SlP4b4xCBaQ/xbvz/fP5?=
 =?us-ascii?Q?2c2V6n5S/x+pyhydwBCZpj8UJ7ESZJOGhME3pzWtLJhJPP2GZYk+StNqvym6?=
 =?us-ascii?Q?D0tou8P1P13oAmR7sgeA2KZCWskDWmQn9Z1dj6MzhRxmlrWpHIenU6pEo16G?=
 =?us-ascii?Q?giGGRqbmrQ1+C1KikqalVgLigC5bB5b9r0l83dGW4xqe4Arfigpvv4p7/VM8?=
 =?us-ascii?Q?SeajAbD2uAUv9XXzDafxQjeVmI3qsBuX9PRa2ir2rcrxXTuNdNlnO+lOt7hR?=
 =?us-ascii?Q?tnGD1Q9Hg+hTMROcO2Uf7bBIoCALKZEqOe9OLm3vA+Gf1AL+NNzQCr6awh8T?=
 =?us-ascii?Q?+nEAcFe/2uMafw013Tw9q5I3Jzrvr+u2lnN2zdJ5E8cnWhbYQZ5YiHJ51Iu6?=
 =?us-ascii?Q?DU/S33H0BlUhlowd/Ekr2ckV5Xkof45bdETeTNRdXtEKnwEw4Y4FneAoI9BT?=
 =?us-ascii?Q?LxRom9dT4uKdMcmjvWjX1y8ybzJrcdN8/zRJwtw9MAfL91+1XDx48GCC5xEz?=
 =?us-ascii?Q?FjnIsEMZ7LewRmKTPa1mvwyU++WQpaeL06fw8sVw26Ma3KgckgVsIG12xnvB?=
 =?us-ascii?Q?rBekCE01bpBaFoc9lj+6zy2BPQuvxmoBW6z4Hvk05lEE0/lI5aNSEGTPfqcH?=
 =?us-ascii?Q?3v39lPGB94iJI7M4RQl1WXuisn7qBdOpDCM1FPOSlkBFLnsiq9MV8dgmbYuA?=
 =?us-ascii?Q?qsqokhiUia6bWNN/6/denVsgcsaVcU/9erwU/CouDCFW/v4NqwAQGNPa/bkL?=
 =?us-ascii?Q?k3UqHuzaaWBXjJucD6B+gvLA3zz+Olye37rkxcegshcmn7sTUlYKU7o1nlLu?=
 =?us-ascii?Q?AZAFC5sYcQGdW4GiVRdhSRAjkecRDJCooRkwuzIGGgq+NyywVgJIFpxUZd+R?=
 =?us-ascii?Q?0wczS1lkO0K0qa1g4zZA4rrtT1V8wwE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e95acb-4af6-480c-b9a2-08da2388b779
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 11:18:52.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFZ3gRJTIc5ASdrk92iqyFV0o9EqKokFkOLJErne9q8PmH6XDDmhQhzZvSBU9Lby/fwOIL+S5POGU8RzKAfcPEWtM645p4EpTnzvs2ATx4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2637
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

It should be fine, as 1 is for multiple for 44.1 and another for 48.

Cheers,
Biju

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 April 2022 12:16
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 21/24] arm64: dts: renesas: rzg2l-smarc:
> Enable audio
>=20
> Hi!
>=20
> I just want to make sure: There are two frequencies, close to each other
> but not same. Is that okay?
>=20
> Best regards,
> 								Pavel
>=20
>=20
> > diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> > b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> > index 549cee1733c7..4bffd6b4c837 100644
> > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
>=20
> > +&audio_clk1{
> > +	clock-frequency =3D <11289600>;
> > +};
> > +
> > +&audio_clk2{
> > +	clock-frequency =3D <12288000>;
> > +};
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

