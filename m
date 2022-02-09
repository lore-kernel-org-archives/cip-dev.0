Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBEC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Feb 2022 11:06:03 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web08.25155.1644404748685842898
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Feb 2022 03:05:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Teca0Y9N;
 spf=pass (domain: renesas.com, ip: 40.107.114.127,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SznGqNvqq2HfDzGrTOz/sPt1rzD8T/hlHGhQFM1AbD2WusYKtHFMYoTe7A/KFAN67gtpOur63uBpuQpfg76hoKJty99ad8EmQeLJNhEs0dHoyLFM7i9zm9RAzJENizYjjdU3dRCJqa30/gZ1lsB1B013j9c0Gbu0AFxgOmNqm6ZhrHodnt0S0X3iX4pQhMA4UIVZbpuTvdVed7l/4leCabbU75U6RGVg6klmIm+KZqpMiVr8mbOOK6Dfp6BSyOx1cV14yKRWslutV0tdqy9DzNwcsJsH4fK7o60eoIJv4wy9mbRLZ2Oqlnqqn+2PRvFTKLXDH75f0rKJq4uFWvxJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Cc6eBFCbm5UtAzjHGiUdUMbhLPFOTKD5YsR/aMTdA=;
 b=duOaZovwtklPZNJYlLLZ7MX06NwdXGsVo1bZkZcD024/s2F5Khj2xwyPfH8GzjzGTjadz/S+yeEzbslLmbQosw4eCsGYIM8jvAExm4Nf5Wo36U9pEtMaLKQaZr60UhjjQO9pERGppD7qIWjPEZqS7WBMlhoZdkxwVVYaV/onj1edWFgBWq80R1q0iNvtMg9BhrjKPl3PHC0K2DGJzFCFWY+t7IAMK4vEn8UJiZ0aV/FQ5FgZJYd0r9lq6uFoAQEnhXt6hWUBOGDx7Rb48HrXqG+m1l8oyN3VSRpyiTaI7bTvJlhxcNGvclWvttr1ctbeIzX4cr+u/4tOaRxkNa81xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Cc6eBFCbm5UtAzjHGiUdUMbhLPFOTKD5YsR/aMTdA=;
 b=Teca0Y9Nqluk0GJsJc4Ajm2rdfvu5+F9fhiC151MdHpybMIxtnSib1lygJ9G7upxFc1GB36mdyqu3LcvOx7i5yCbeDMfx+a2xQW1nTe3JU60jGF4b19wlYfOTYi0972Zi/AANiVvNt9JroQXI0Xr1ZFC3VZPKDXDxciX5sNfHV4=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TY2PR01MB3084.jpnprd01.prod.outlook.com (2603:1096:404:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 11:05:44 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3d03:7441:e57d:869]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3d03:7441:e57d:869%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 11:05:44 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Topic: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Index: AQHYF7NMn/0vR/EI3UWFAkZB11LM4KyBa6uAgAV4+QCAAnUfEIAAefyAgAFGgwA=
Date: Wed, 9 Feb 2022 11:05:44 +0000
Message-ID: 
 <OSZPR01MB687737C88D75FD8F450DAA7DB72E9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220201213254.GA3001@duo.ucw.cz>
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <1ac8ef07-4bba-71ef-83da-524c1a717be0@siemens.com>
 <OSZPR01MB68774ED2525BD5F8B8AE8414B72D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20220208153601.GA5021@duo.ucw.cz>
In-Reply-To: <20220208153601.GA5021@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c4a03f9-a342-457d-88d7-08d9ebbc1e67
x-ms-traffictypediagnostic: TY2PR01MB3084:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB3084DEDF2FFE6B49F6719DD7B72E9@TY2PR01MB3084.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9tdYqVSL9697kzpPqKYNX1zqnINlu9ty2UgNzn2CGckiclM3WUY675o3FsZHnk7mJMR1HOqnVxS+78rn/rt8vhrjBFsCWwsGVkcr0S4dAJ68PFDfOaB1ECghBYDg8VPppMYi+hFs/plDnPbQD1dHYO92IykaLYBp0Oe2DXIatcKnHwEU/3hXwV6EkphZRn99p22wtDnP0sHyHekkkrxos7isJWPvvJPt1uR7SaB3XXykqXjttW1AfBzb9WR2wPWU0J8ZvMMtM4zSYmsdpQVgwblPNJZtuo1nFFSqXbNSvp9YpYJtOyWsDxeWzkiitHVa5DBh1hnv0/fRTRagH+AJp3v7H43zLdEz0GJsWsCpDYbTymwzqd3UfdAUhXtWzr3G4IiXbUzkey+fh1LUvE8bZCLID7ihb548rF9b20TgfrIEWWIrKakif/hxI0fjuJAp4yoaPlMLftfE/Xm6vZIHVz4Y5YEdnXglwPJA26vZxEZinwRM/+drc6Krrn6YHt+2IW9kGncJZuYl1VS9v8BqLZ8CbXBQ+YglpXyvJnA+dRawJqs4obUJ2asEQeS5CEgETFhTWaJzGRTvMUsReNNj76m4JYkJheQ4wjP3M0S45Vd43iep+Cc4Ykuc8+2lqDNfrRPu7LqdRXO2mfqTSAHqjFo6iD2r4t7P7s3qqD5WHfq5UUQAaJWVI6AKGXnCF7rYz1SEzNMs8OoQvja2ibPLZg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(33656002)(9686003)(76116006)(6506007)(83380400001)(7696005)(5660300002)(38070700005)(55016003)(38100700002)(2906002)(86362001)(316002)(508600001)(66446008)(4326008)(4744005)(66946007)(8936002)(71200400001)(66476007)(52536014)(66556008)(54906003)(64756008)(186003)(26005)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?248hfrly+fx6o8f3dC/FRLGqYzcX9P5chM/vLjgdgnvXHJks6NeF2H/0?=
 =?Windows-1252?Q?2SFXz3qW8HMK3Wp+iAYj2+U0uJlFtpzAuernOInvN7diix6kuGSrt5/8?=
 =?Windows-1252?Q?CJwjSyhSB0/Fkt8DAe+8wSwCD5oTZFfnygcIJU/oG6y7sX+6ZIprwVY6?=
 =?Windows-1252?Q?+rwOTA0WSvU5R0PzvBtof1jmpTmcQ5EV7AiMdXTeO1n3QE0nmToBFJFr?=
 =?Windows-1252?Q?O7UeEsD1whxo3hJcwXQJuAyP7l5CvLJ4tb2jEDR2bYr5PIjyigH9DB3L?=
 =?Windows-1252?Q?818rrXVGJQfOzj7rPfwOvGMJNdhytnvxdv94txfN1JmoVmOpKuNOhrVG?=
 =?Windows-1252?Q?B5VAukPya0rVuZNuPaXZuXPV05XxfxS3n4MLR639yR/FxloMR7lrgO44?=
 =?Windows-1252?Q?gg2b0/hn+Upk9fnlxUaGMinTZfiN0kU3LgULarODnfzgGt7nnItTYrhR?=
 =?Windows-1252?Q?guRlBwXgc3wg8MWHHDXLjwHdD/3seMzgtTrrQBY1FI5I+FpqVoumPfcR?=
 =?Windows-1252?Q?N8dF2kdQaIE/vOizUFE7Fpbl8+7zla21cWz0uN5eCjJWUhzoiVH5zdd9?=
 =?Windows-1252?Q?AoySSRg6zbWwQBIfjU2gIDga7XyhgJM6btysREIMTFfW6iEbrRfoOZn9?=
 =?Windows-1252?Q?Ipfk7S+bXWgH5srmYbOvuI/EuF0BnqviCyZFgHijRTapfqpK4UQfJoPq?=
 =?Windows-1252?Q?cowdPoPoMjBWW2eAGGHYKz5AcWpKoU/2VIVZGpFD6c2kyFetqQ/NLOB4?=
 =?Windows-1252?Q?y7NEvZTdhWqngenezmK1wrr/Z6FkdASzYX13U8whPrRn+m1iz3/u4LAK?=
 =?Windows-1252?Q?pk/UdEVRDPV5v1gX2k9tbWG5RmHg+dFXT+8bS2WCwvvkUDRawSwAKWEl?=
 =?Windows-1252?Q?GsvsiOowzpuTw2GcY24HZF0s0LsM3ogLxGXopN2PGUJaFjUPdVNkbmjs?=
 =?Windows-1252?Q?8K4nbknf1OSrjlYFkuy8ejmtVRiBwwg/I/2CDAu6SvpbLnYqp1gHZidB?=
 =?Windows-1252?Q?b9zYmPoUBiVjghtM9YToPp37lOZ1YU3e/h6sEh55vL0k0knGjDk8X/2d?=
 =?Windows-1252?Q?lgAFeL6Gdf/+QrEifuG/4XdR0xQAtEuVjfm4TCVZASBTfhjk8AL32dG+?=
 =?Windows-1252?Q?lJd54FiAtqzoWINCacEsRfuI73mDJCi99YZnQ4i1ADvSRfU+MFrRB3ee?=
 =?Windows-1252?Q?e+iSVNuL3IrMYseGfipgIvby893JQsiAMgsnjRIZCEc2OaaH1CoTZdRx?=
 =?Windows-1252?Q?a7cGh2Nlt2JfmDZevp+XnHYExT5XNxfEuOnE2g8BCZmW2/dr4POe2TtK?=
 =?Windows-1252?Q?3WJQm9EQoL95Kjq6FlgXINghY5ri25Fg2omFqSFIIP18iqNz7jvM50uO?=
 =?Windows-1252?Q?NxQsrB8HKe/riyvt+OBeo7pvN+V1+YQprsT4Id1sqoBpQoSRJFHuxext?=
 =?Windows-1252?Q?MACR+XO0fl137gU8u7qOfs6FzKpOndY7hGGXYHRksiOOsQ1upA7at16a?=
 =?Windows-1252?Q?ir9L6q53QQI9R/fhVdBUbRj30Psktjp3wMgbyFqmoQBuSZbymCD1ZPjz?=
 =?Windows-1252?Q?2zvDv29pKxkDdgJSjgCkk83jW5V4XEjQKo7vrbIbp3ImOWcduXu1xJ1m?=
 =?Windows-1252?Q?BOb1AGWtym5k9WtU7+TH+Vw1wTL9sy75cmVhoxnWLkkn/UHBQZ6zrhoA?=
 =?Windows-1252?Q?5tUOmvhv0ZVsPOsok52Y2XraFTwbn9dSepHxw+LD9yY0MF9E83PJhF2N?=
 =?Windows-1252?Q?mPVuI5eoTGBNPdUpNGmkaEqAghtDd8Jix50JUKVcivJ1pDpS5SVAAssN?=
 =?Windows-1252?Q?bL09Lg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5c4a03f9-a342-457d-88d7-08d9ebbc1e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 11:05:44.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 AAgNvfJZbfcPKb4XKFzf/UU+OcC6w/npHyXZ6SVXCkv6xDnEWy/mgPiojxR8tNZCuQetOWExX+2xEcgE1Q3Lwsm3U3wA2kRegiJMwZunFfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3084
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Feb 2022 11:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7587

> From: Pavel Machek <pavel@denx.de>
> Sent: 08 February 2022 15:36
>=20
> Hi!
>=20
> > > > BTW, do you have any future information about the RT kernel team?
> > > > We may also need to check the RT patch.
> > > > If you don't have the information, I'll ask the RT team about this.
> > >
> > > Why should 4.4-rt continue if its former upstream retired?
> >
> > Didn't CIP commit to maintaining a real-time version of each SLTS for t=
he 10
> years?
>=20
> We did commit to maintaining 4.4-cip-rt, but upstream 4.4.X is going
> to be discontinued, and so is 4.4.X-stable.

So does CIP need to maintain the stable version of RT as well as the non-RT=
 stable kernel?
Is this achievable?

Regards, Chris

>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

