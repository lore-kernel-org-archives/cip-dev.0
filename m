Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A02E6B24F
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:09:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.web10.36243.1730462935666983378
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WJXXXUrp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6s4xVXHSmvVWF0SnrZYghiF+Bly1iveQf6kpy/8NoMKCKX0vokdS6zbHHxi1dtDR5nvkwwl+oc2MEOMOKuCqaRgtvODsbJSwUg/JZbkQWvEfDpo+ZSvygX7D2rfuvLJx5607s7AApqMMMmVVKacKpxv5pasJPkHHMUGWN+juk/qp8vtv/MFhNpA1DKIUjb2QfCsKDcJFirC8VpHc+uXkzDdoHGf6UgHKMPVGYilSHpnIjVB+ODvPoNh0QncEJuVKjPVC4SvwtI9wCTRiIeKTvGQ4PTKUyRWLgJYnV03paDkNp8TUC3wRIdfLDEoCgjmqRoyifTZkChvg/+DG2ISBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a92MHN7zrv4BpfnKUB8qvvTO9WJ275c/9VzGU2QOoIQ=;
 b=roDFkr9FD8PZYqbnzc4yzq25oJdcRuag+aU/GsC+wM2m3w3IijMEidi8P1UlhQOYcbmQ4GInSuw538sHoEV1sRLMz3ufCn8it2gDGtcX7JVVa1QmNTz2jhse1Xv5X7HejyP5ojPF/975m6FlbElaoDgYw+7FgDKcnAb4BOof4OAkmtPmeDVqE+3dwqHc+rfIDXEBmy1du0BFbgflN2vWDJIaGqkzny8t1FlWGu8KZ79hQIaRqWir2f+wb+rCH2ToO9HMx/K8Ah3ibAoxRAH+Oiq0LYuDcs28+LkWX/MKmIY2G2CL3nF1ctzkVInAKxP8S6aGRUghcbTvYaOXfqG0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a92MHN7zrv4BpfnKUB8qvvTO9WJ275c/9VzGU2QOoIQ=;
 b=WJXXXUrpDGxNWcw+N1KltDrGxmpMiGMwd8Ig3f/qL7r2eG52k8pRYf+Na/e76SxQUkCGTYZDCTo7iPncLlrV4tfN7sFlLS9dZHZ/tCw8OB3fXFcII9rPi0ffShqMhG9U0KgG3i73ivnEANB+lvboZrW+TcIJuJelGX5QnjfJFPs=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by TYCPR01MB11053.jpnprd01.prod.outlook.com (2603:1096:400:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 1 Nov
 2024 12:08:50 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 12:08:44 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 17/27] media: platform: rzg2l-cru: rzg2l-csi2:
 Enclose the macro in parentheses
Thread-Topic: [PATCH 5.10.y-cip 17/27] media: platform: rzg2l-cru: rzg2l-csi2:
 Enclose the macro in parentheses
Thread-Index: AQHbKrnTsYNmKc/JK0CAhPp8Fu5gSbKiV8Vw
Date: Fri, 1 Nov 2024 12:08:43 +0000
Message-ID: 
 <TYYPR01MB7024A0C6E1E949E230A4C358AA562@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241028200349.9620-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZyIP69IkF3ZrE4Jf@duo.ucw.cz>
In-Reply-To: <ZyIP69IkF3ZrE4Jf@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB7024:EE_|TYCPR01MB11053:EE_
x-ms-office365-filtering-correlation-id: 5194d788-ce1c-4ee2-7bb4-08dcfa6dee91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VcAtgohJwwO4L39ghhbQzDAXeoz6iIl19PZPGsOcdBoyudSSIVS9JKYlwHik?=
 =?us-ascii?Q?XBHPSNxdDgihY91WGfg9j+t4ORWjWIkNOdfkSvAhcPhP/2LSCOkXf9tb8bsI?=
 =?us-ascii?Q?b14VnW1AOo33h3Fuu+kojBSYjdidrVGmY0cFim1RwiGzTRdNuHy6WqogVBun?=
 =?us-ascii?Q?huGX+rMduhvReV98sZdrUEvgUB6MRqvnqVH4/CTKzyrQiOj9qcSbH9jOMulT?=
 =?us-ascii?Q?Ap5g6CiQY5zDUNP9pC7SdXXenAS0nnVHNws8A9s+uUiEsrAXfkXpKFxPqCjx?=
 =?us-ascii?Q?h2K2VUjZUPlEmdL3FCaJ1bHYWeg41WQKPLNi2LiHM4aFKluECdsj3E0Vuu58?=
 =?us-ascii?Q?yzgUHDrmCqASRsZVzJ/q8nAlIRaXEru4SLnXVECsr7OZNTXJn7FOcBR/OAG2?=
 =?us-ascii?Q?E907H9lJs4RerCot2707RhH80n7C2CnhlpzGWtPIoSGc4I+zQ2sVYWOyccYD?=
 =?us-ascii?Q?VN1iAaqlJHmxQ8QtStv5D8P/8RyTZBeXy6HH3O8X+vWHqJ8J1nBQse5K4EKr?=
 =?us-ascii?Q?smsXRYkN+WkbB96D1YMDXqHqH2R7V7U2QhguEp/uLuS+4v1IONxEv+6Tsb4J?=
 =?us-ascii?Q?u1+CFZPzj4HXPQZeWPAakCmZev52Clt+E18cMA0jFoWORCP5LxHX8/MyYGHj?=
 =?us-ascii?Q?PN7dlMH99iqO+ukN5ty8Uo3TrYq7hgIZAsLCFNOIAuFwDple1Uug7tIsyXNU?=
 =?us-ascii?Q?STt/j71iYIz0aAFog38Z4U/F13TdBSAsD7rMKa4ZQFXrNd4wyFhLcufeukt/?=
 =?us-ascii?Q?txexQQwd56Xnmsq7vbBI8yyuQ26qx0bREzpRh0WS1gbGnj10b6lLrK3+ybUX?=
 =?us-ascii?Q?BNgOFaYo4I2Kx4hRwvSGzFjhXCZ27lAcfcUiIu3df3ml4miXEYWUhvOdAKhH?=
 =?us-ascii?Q?t+5iHBcfCmXR3iymuAfdQ8NYubpvGl4lrZOpkopZIQKFQYaK4OSwTRWuxLsi?=
 =?us-ascii?Q?fSAyTpdeS589PllAZETMsF9idlf/p+DNj2fK0AuSfeIG1kPeI3sajqdbxLbP?=
 =?us-ascii?Q?USpok58xAVoUuscq0CfEUFWN56s61LmraG1REGChL/LN0n2h/WjiLMmg3kP1?=
 =?us-ascii?Q?6HbloAZGAjG7pbEhpn8bnG2K1LJMSDdbzNke5lMvCtVuSYHpjpJYPof/Lcrz?=
 =?us-ascii?Q?HoFPa9tHRvatIdzp8NsBMVGC+tCOnptTBwcoT0ZD2qzPYD5M2DwRIibwigci?=
 =?us-ascii?Q?VNx0Afwe7Xb5jM6XKUVg8qu25+0Qd24ujwz7984dCu5sfmgQhO58if4EjVb2?=
 =?us-ascii?Q?duUw9wkPms9k0NqZpR2Uc4r1tuWLBcZpUXymmZ+JFewZHh/L8RFFrrIg9tHm?=
 =?us-ascii?Q?4NW0tzbdQ0GmtmhBx5FxPamsnVzP0hPr0Vgw82ZFCEe8LPNT+n/4lW2lqkdm?=
 =?us-ascii?Q?ykupMtU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?LRhAIH5h+z+hqarXy3I7MUHfYncZ/ArMbRPK0GdYUCTiWStIKlWhIRY9MHIq?=
 =?us-ascii?Q?MPl3YldGcZuEHCk7VrSy8azDwsuGNJYYJnd78oo8vqDSYeIQ3AKR7dadYxal?=
 =?us-ascii?Q?WSHxeUamyMKVDiiwkxEMaiV8LebOTtu9MNiEdJovMVW+NzvceHX/OHwVPRV2?=
 =?us-ascii?Q?8FDXuAkfRpSsKtBCbwZuw30aMCodZptny2peFyUAwXlpkQbeo6OitN0oe6I5?=
 =?us-ascii?Q?A1Zi75ZYh5LVSa+ELqLimlzCknAWyfGxV+187V5noPVwcgtVXoX7ek8uJtBr?=
 =?us-ascii?Q?PgwF2fbYOx1roULnfqAfTMylyK4kno/fVQpVTaLwp5yMqSooJVOMGZYl9sL/?=
 =?us-ascii?Q?271+ewdcynxm/GYlg//PSe7K2Kr2/U1lIt61ltmXzUK0puiwET/hlkVRGNIZ?=
 =?us-ascii?Q?EYrBxoSUyR/MH2kzf5XavifpgZ5lGYHUwkmf1nh04B7u50DRJOIR4eY52q38?=
 =?us-ascii?Q?oYSU9g7xyTJ4zeDsQh/E2tIH79oSVQRpbQxWoGmJUiL5HbKxGw7Cbl9i1q/D?=
 =?us-ascii?Q?6WbshUW8JfZZlMrKTKnAmE+L+jxi8VGGz+MZV0vO+jhY+bAmBjlSmXATThwM?=
 =?us-ascii?Q?7QXmbg81FiLs3vWrFvCc2RNZcZ78SmypQ55RUOedSTF2+aqBfDA4LlnldHmN?=
 =?us-ascii?Q?vIrRGmKtPs59FhWW9zThzCG5TvCTJ2X9h8lNYMb9D7N659sGV8Py62EOMukA?=
 =?us-ascii?Q?oQOK9s3vTg+9ATdLno0H36jsueQNHW8S+AGZtIiTMr3tGmgNB4k9I+Hwu3eY?=
 =?us-ascii?Q?aJ83jsZvlTjVmRt6rbQgbTAhNVcw51dCWVavNOCO8LsyOmdLt67uxa6LOfvr?=
 =?us-ascii?Q?FpNhYViGorjYGjI7Ez3PbMOV1qI1M6IupdftUtf7/7t8FnC1P95/6WHTw+1W?=
 =?us-ascii?Q?2A2b5YJLJr0YB3mUFsV3hoLPOpZ9ZPPGYxfyNZxw1FIdvuCdHa6ASLgzhAKF?=
 =?us-ascii?Q?2F2l7SXajA/20aF7tL/7tLnkNdjf3bF7RetvuL47WhxXfSaGH6Bp1b3QQ1TV?=
 =?us-ascii?Q?WwaGLtf/kRoDjlxDwItnnfXndRGf381vEM8MuLmt+rLIlIcFhqIy7zDd/kvS?=
 =?us-ascii?Q?CLOL8fFThTVHcs6UP9kdV/n8ZleMgVDNF/BsZTaCucBGi637Z+MSHOnBBF9l?=
 =?us-ascii?Q?3ZUVKnMuA0zCugeNyTH+4kT433T1rOBJMIvNEfYvUU7kZBEz72eGMdsjenHL?=
 =?us-ascii?Q?Cm5oNxOoBmZIY8W3NyqOVYijqlj8myZDFbR1W2GWskNpaRH48ePC5vC0dBSo?=
 =?us-ascii?Q?rlZxVt36Lyv/liKa8RK/lcCssd4e6ff7wtb1S3pjpl5XQqnIxS0HjDq3D80A?=
 =?us-ascii?Q?cEXgcnzjLozflUR2e98mJ12yHuUIw7ncwUbMWhUObkKd21Ywdd+jas58DV2N?=
 =?us-ascii?Q?81sZbL7ZmeKjIZor02WzwJMs4x104Ir8RuZO9Y/AcOx349tZHBM96CYj/cOt?=
 =?us-ascii?Q?qPDZYIhqsUgFLQMA84ibi4WAYEmc2K6lPjuvUn6eWYCvdwv+NQkbaQdD3KSl?=
 =?us-ascii?Q?GAxYQfWrvwVsN9BQNkMsScVXzzDGxIXrmpE1UHUW/WRxcRVDNcUT58yJy31C?=
 =?us-ascii?Q?b7XwoS3HL/nT0MRdAhCieUS72EFlHHHu+FzMd9jEjrLIboL9ckxJ5drwIZbS?=
 =?us-ascii?Q?CoTnxhceDHWoIfzbM4i4tfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5194d788-ce1c-4ee2-7bb4-08dcfa6dee91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 12:08:44.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nmlFfMiRtXUr8fqIU7W/Wu4h0ZIdXk0Q1Nm4A4f7Do5/03Q7+u+dAOxN8T2zsZqxRpm6ga2g/8xX+qjfQUyi51Zl+aY4hZgXnQ/BUEjUYtnvP5ZEw98RfRAgPoVHUvD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11053
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17133

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@denx.de>
> Sent: 30 October 2024 10:52
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 17/27] media: platform: rzg2l-cru: rzg2l-
> csi2: Enclose the macro in parentheses
>=20
> Hi!
>=20
> > commit e5f29bb9c4350dd9692f3b98eb8538dbbebccbaf upstream.
> >
> > Fix the below error reported by checkpatch:
>=20
> I don't see this one in 6.1-cip. Can you submit it for that branch, too?
>
Sure, I will do that.
=20
> (Are there others that are missing from 6.1?)
>=20
I'll have look and submit any patches if they are missing.

Cheers,
Prabhakar

