Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CCC433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 08:18:45 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.133])
 by mx.groups.io with SMTP id smtpd.web11.3070.1639988321284397727
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 00:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=bfUymHxr;
 spf=pass (domain: renesas.com, ip: 40.107.114.133,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSCaJ7FGo92+N5Q0C4hOA54YaUzhfaF1fa6HXl0rWhsaqbKp5DdSHtWT+13JIRszrZjnCh1Wz/s/StAhq6oHN0J+LT7hZJufce70dNZAt0+qBy24zxa+uieFBYRw2Qpp2tcycP7QgzZ4vj/k+GBHvFUZ8ijN0yfgTq4697qyZWYG7z24IS4ggsu7/rQJFC7nIi/6TuTn5vAwEFTrkwtoBr21WgUo2CFSdknJK1VTXup0zgF7bbFWKioHk2eMZXDidR//Qk9aCk401JNzpU9vlvz+Sk2RPr/oQD3r4oP8f9cXDJscLdhGJ8BPByqP2NyVT2i44Y5QRizpgxfBX+0fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXSSYVYGhU3i3iXKIc5JwapT5SnkwYDsDSNl98srN5Y=;
 b=BqmP+3GVhvEundibqTgPoDrkpfgLgbeRxvfD4oYl0A9p1PzewR1RPdNs5EHWQAbIeBYwtr2+PES2PFKR22O3lgsXIo/6IF4NS04cFv7a/gel9oqwdDFiFIRG6/U5+sdIIV4XCpMFFe6+GFeDe+M4YFC3MabonaIacVakMlpQuz+TNoYfhkABRYB1KyGWNnj4//ZsQYVTEsmydRRcFLAZ8neyTNZ7+kxutmahZ6l8lS+MdgCgrW0jWY9li2dnYDSRVb/GHl6E+xCmJHWitFR/XvEzQSzLJC2g90up5yF65uogZXsMhog+id6uM0oY3mqc+YDhb71XPCRRYC+299ZrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXSSYVYGhU3i3iXKIc5JwapT5SnkwYDsDSNl98srN5Y=;
 b=bfUymHxrnJvuq95COMmSrEhPe6YaTDTEsBwpdkcP47rXmNdnahXzCe61mCFWcAuhUyLe9luKWkj56ZlJa1n9xoAFtR+dQ1dvSr/QF0PEsV0vnSslYfAlICJkQPGiyCl8QT8N0pYxjMEmtKHsMyVh41AAuLHl/RYbtMYCNQbjI3E=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB4088.jpnprd01.prod.outlook.com (2603:1096:604:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 08:18:37 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 08:18:37 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
Subject: RE: [cip-dev] 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33]
 5.10.86-rc1 review
Thread-Topic: [cip-dev] 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33]
 5.10.86-rc1 review
Thread-Index: AQHX8djMhWFUnPMh8ESXVyayu7bpUqwz4IKAgAACOoCABxtVYIAAC/Xg
Date: Mon, 20 Dec 2021 08:18:37 +0000
Message-ID: 
 <OSZPR01MB68771F67502AD57B62ECFE5AB77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20211215172024.787958154@linuxfoundation.org>
 <20211215183223.GB10909@duo.ucw.cz> <Ybo2lbHVaASDyAcC@kroah.com>
 <16C26552C5A174AF.6275@lists.cip-project.org>
In-Reply-To: <16C26552C5A174AF.6275@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31f9c821-19e0-4da3-4e06-08d9c39152bb
x-ms-traffictypediagnostic: OSBPR01MB4088:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB408835F147DEF1ED93625A60B77B9@OSBPR01MB4088.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8VXwDqWCLCfasoECKi78KrEXHl6C5fqDhzjMhHtZbccMuuHa3DPtFI1rq31ZsU92h71cZuoUTzQJlD4My3on5vVfQG6P62ALlKOeqtNLiYMrP44jocr03NA2famZfa+pgt4EIa2pvHGYsg9SISpuVFT46l7R6y9HUaPpa7y8CmevKZPk+3emyweupLRWhedE8ez58j7SzJ4mMwvZhef6VcDPhCKMGqEaxWRiiH+j9m3iZftj2dMSjE2pnFxQgOeKwsdty1c6lIr85KTBxRi+wspvFfhahqhkFiEJA1ajVB1amQ5crKhAGtMnsjUNQlPidB36XPlrzAEebIxZvPR4ij3MIxfdxdz+uZ6dUr4Fxuz16xyvTQJfw9TxDSXT2IE3kPawhRFLbSW/D0wHxrfEriO3TQ8D8qyIopAxBHWmGSN4UUEYcF6+pG9eguzLun254A0fzChbH0kg2Wy2ofwc7h3VCFtJPbiFRCrfcRRWyXRLDJ7i6WUe749zVsiOaRLyLnDB9gQX3rkC9YlBEKJSxR1l14+O7y3HQRFIt6oQyz+/isxTSinIB0U/7iZujyRr5yJrjXteIc/opIrRU8elGEtKP57cTglBNUz39ARwsqQDKhZyd9sgsVe/szU2/pPZbKO9Suphh+LuxtZenzoPbF8HVs77RCu0j7taf71JaxO0Z54g5aGTp+oKUZ4NxvCSdc7vyqeAYzBph8hXbLU65tsGh6DHpQ+XBFfwRiRkBngDYqe8hoXqbKGmG08Ql5kyBUSXlIdBBW+toexHwL61U3r0D1UBSYG8O6daH01oXxFNvnCx4NA/eQUjtNuHenqBFu1f75RQ7ppBuviUT6Ita/qmXmxEZzUmIBYosmVLTVU5+pD/R940ab2bHGv10Mf0
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(7696005)(66946007)(5660300002)(76116006)(2906002)(66556008)(52536014)(55016003)(966005)(8936002)(122000001)(38100700002)(64756008)(186003)(6506007)(83380400001)(45080400002)(66476007)(508600001)(316002)(8676002)(26005)(71200400001)(86362001)(66446008)(38070700005)(33656002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?5Zak+5maHf9pBdlKgu5eftYVNKkXjR+XKVb+skzPutwKtRnMQ0EbQerZ?=
 =?Windows-1252?Q?fyMfsqnN9MlrQGiDjUZtHcNCoy9m0ULTNTXRpYssQa4YF0ogrqiS4f+F?=
 =?Windows-1252?Q?X+dc59yr3e2OtofGccCvlUAKU4FAhxupWaauq1MX7h+rHz8SJnDrfQdi?=
 =?Windows-1252?Q?NdqXewzW1hZunmKug1TAcEmR7L18OiwrgxGibS/3OL9vHnXBt7+b2rlc?=
 =?Windows-1252?Q?5sscE0IWpAdNdtCDONhbRtFOge0Tkimaa7K64tvFo9iULZOT6vKN+5wH?=
 =?Windows-1252?Q?TxQkWC444I0lviH5E0RW6088NQuLrzfYmxg6Ps6XhOGvmObYieC1hqWd?=
 =?Windows-1252?Q?jM3nEF48NKcP3Dal29GIMcCxV/72Pslc+fQ4/dbKzSVigUBSQ0hvENCO?=
 =?Windows-1252?Q?J6TfT5jnv2ndkudgAKet8E6NUyZEhG+uSuqLPxFZGtAGU6SxzBBy3EP3?=
 =?Windows-1252?Q?p9EBicqz9enaWL5w9rArPpCxWbS9Csn/PIzTwG+NulWaR+bHab+nML1J?=
 =?Windows-1252?Q?ieohG6Y8o5ZYoZqIAK6+9rMDMi4CkVuVo+Pwa7yQ1rBTJ8NJhvJOlO1q?=
 =?Windows-1252?Q?ao+unCfpgYxL2ubDNT5bseBUWofHdLkdw3Ey2yHmmYJcs+ywcnBUrfV5?=
 =?Windows-1252?Q?/ewwRoSvDGIKAoeFfPy+cjWnwkoyeW3PLqb6JktxGCv/rDhRdR/9oD4I?=
 =?Windows-1252?Q?FjPf7H7NANlH17As6ooa2kNIiLQTzch6pAgdwlpt96cmP7XCfSAgs2bM?=
 =?Windows-1252?Q?w+Ct8o6xBiR2Vy0qAUlm3HAW3euNmJIKhn4KuqSKzajscRHvddA3hkEd?=
 =?Windows-1252?Q?6pBwK1J3PaCaKHjOcSZm8UAJ3va873XiZkSCh89DKh+aT0hFFMoyyfxX?=
 =?Windows-1252?Q?8oScvaQ+VrImZfQLpL2fVf185gkx/aK4ClP+Ak+H7PzoTNYmBzhIknFY?=
 =?Windows-1252?Q?QVD/KC6s7YadPpeKF70SMc3LW924PkE4OwqjbMy4IAPb3MhA+4DkQ17l?=
 =?Windows-1252?Q?Nb2BhaaajbHyu7Hhn+Bjm8F6u9YhD3IA1HQClNFq0C7OXn/1V5bjsM6I?=
 =?Windows-1252?Q?fX5cKjcz0Vm8WZM7hy4D7ZSaIdGLAc3My2L/VxSDSbOqD5nzUsLAjozI?=
 =?Windows-1252?Q?jZx1V8povK6pzwvJlbB+Q8WbdfmfwrC865dGxildEGjKVS1QEvXG+3on?=
 =?Windows-1252?Q?CHWPGOWDFRG8G7CIHuIPmG76jwDTDULuffj5kzQzv5+Qgj0hoVdh9DCj?=
 =?Windows-1252?Q?MTlfkEmNE8+ThlaYeDCIdnjGdQepNQb1hyRoL8nUMFjUaXS0iuI1DgQ1?=
 =?Windows-1252?Q?+2vcQ+zHJG5V7fyHwOevCRRyOonrt3p/43U+ARVvJDTzTohQ3Ud6t6h0?=
 =?Windows-1252?Q?hXp0N0ePyQRD8QyPWbpvIc4zIJVctjmn8LDi66ioO5dhqrYDGfrK2KVv?=
 =?Windows-1252?Q?ZsE0QsW2zKctn/qv0tK+j6//6GqcrE5Z8AXuc1CwrBtFcs2QhoWFrp27?=
 =?Windows-1252?Q?2VEd3nlv8W6Zlu2XH4KKdOJFr8e6eBlErZhxIHsUakYdrsqjEfzV2LS3?=
 =?Windows-1252?Q?C3i6aRrO7eGcgqJ4OXFjxuyKuh8DVgPYYz2LH368uuXG0n2NDm7MPKaC?=
 =?Windows-1252?Q?oGSdDcpJ1hxLXYq2bnHMtG5YKiN+vPM87JzO88079Av0TzauftxH1Jio?=
 =?Windows-1252?Q?T0F8zFDl+alaiXDJpBR7YRka27QRew5dpfQvPuk9E8W+P2kAk666gJLt?=
 =?Windows-1252?Q?ZCUQ66wsDosU+stbQxUT5Berc2worRCaWxe0ofz7MeyYG6vjft8tWdJj?=
 =?Windows-1252?Q?1sUnDQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 31f9c821-19e0-4da3-4e06-08d9c39152bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 08:18:37.4379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 3mXfo3SSwJG8pDg3toWYO6ds8NxId2HukBRbhed7RMQ7wabZanTSBSQuxWjbBtdvaeirSZESLjdP2iDh9cwfnjxdgOm8IID8q2tV3D7d9L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 08:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7194

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 20 December 2021 07:17
>=20
> Hello,
>=20
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: 15 December 2021 18:40
> >
> > On Wed, Dec 15, 2021 at 07:32:23PM +0100, Pavel Machek wrote:
> > > Hi!
> > >
> > > > This is the start of the stable review cycle for the 5.10.86 releas=
e.
> > > > There are 33 patches in this series, all will be posted as a respon=
se
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > >
> > > I'm getting the gmp.h failures :-(.
> > >
> > >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> > .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> >
> %2Fpipelines%2F430434332&amp;data=3D04%7C01%7Cchris.paterson2%40ren
> >
> esas.com%7Cef488aaeb0b84b91a25a08d9bffa5dd5%7C53d82571da1947e49c
> >
> b4625a166a4a2a%7C0%7C0%7C637751904307960001%7CUnknown%7CTWFp
> >
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> >
> I6Mn0%3D%7C3000&amp;sdata=3Dd4fq1iITMmiW79nbbG0Tf4srDwikrnVaPW%
> > 2BH%2FITD9sY%3D&amp;reserved=3D0
> > >
> > > I believe we should not change build requirements in the middle of
> > > stable series.
> > >
> > > To our testing team: 5.10.85 introduced new requirements for the
> > > build. gmp.h is now required in our configs, and maybe something else=
.
>=20
> Hi Pavel, sorry for missing this email before now.
> I can look into supporting this, depending on the answers to the comments
> below...
>=20
> > >
> > > Easiest fix might be to add
> > >
> > > # CONFIG_GCC_PLUGINS is not set
> > >
> > > to our configs. Alternatively I know which patch to revert.
> > >
> > > But I believe -stable should be the one doing the revert, as the patc=
h
> > > does not fix serious bug and introduces problem. Faster compile is
> > > nice but let mainline have those kind of changes.
> >
> > But that commit is needed to get gcc11 plugins to work with the 5.10.y
> > kernel tree.  So either we "break" it for old and obsolete gcc versions
> > (i.e. gcc7), or newer supported versions break.
>=20
> Well this leads us to an interesting point.
> At the moment we use GCC v8.1.0 for building all of our kernel trees (cip=
 &
> stable).
> What does CIP want to do mid/long term? Keep upgrading the version we
> use? Or try and support a specific version of GCC for 10 years?
> If the former, when do we want to upgrade?
> If the latter, which version?

Note that I've done a quick build test [0] with GCC v11.1.0 and 5.10.y-cip =
seems to build okay.
If anyone wants to do something similar in their tests, edit your .gitlab-c=
i.yml as in [1].

[0] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/4330073=
10
[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/3185529010=
dfa5cd4ebe80d55b5c1c1ed23da4ce

Kind regards, Chris

>=20
> Kind regards, Chris
>=20
> >
> > We are not in the business of keeping older versions of gcc always
> > working, right?
> >
> > thanks,
> >
> > greg k-h

