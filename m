Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4583C00140
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 06:40:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.8062.1661323220108417989
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 23:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 27O6eDps012236;
 Wed, 24 Aug 2022 15:40:13 +0900
X-Iguazu-Qid: 34tKIuUqqM65vtsOBW
X-Iguazu-QSIG: v=2; s=0; t=1661323212; q=34tKIuUqqM65vtsOBW;
 m=ToTMhP79z6YhRAjxNq+P8CA4pM0pChtvy3M/Ffo1If0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 27O6eB3q003283
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Aug 2022 15:40:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC50Avm/t9or8X7txTq56SDADAi8j4nnlkcKPNh22S5eMCCLHBolwfRJmHEmE/uSElH8cCj5J8in8SQAdaVCoWnRmY47RJnUxmomrPBODJVaRAGTLMpiioGEFtJBn0AV4UDsuR9WOFs8q9DWFYVxKI7bojC0w2gXDvYTJQ8ern/rrAn4R5lSlsaAen44D1+n35QmGpv+B46Pvks1piBt1MZr0Ka+7k1jMipmpsFrJo3fzVVZwi8xoRb1baN/N1G6uClpTy9ap74YlgxqsLz0pT1J+/mW0OOKQxnRqgjWdgwCfHK21HhFrTtHcytOA7Ogn6JfIMcUIQaDr8JXawTqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPD96MAJzCWXkpNF+7bIe/ZDqzAvCi4870S9A0MTwJo=;
 b=H0biYFZujVAiChjFg3KfKjg//iIMHbpcR9vS/RNZHlCub3RYOZo5Nj1sNe7HYkyoaLXIA0KOaw70TcjC0vhdzYlw7yj/ZgE27WpvPlSYDMNDs3IqfKERTl/N6l4RPCWG+wRTaEUdJP5azy/QnJVC9jcJlWpkelkTroLe3yXn/y1cipLs3E/ZzDroIk9xozEp4OfP3EUxJp9NaxLOoLcqe8TN4z3RhnvXkRdlECXSymI6F4mgNjiSuJnBy0gBabY8+ZxTAb73mqcgKULcG/lnnYBj2TB1tyK6jadbi4JI4TbYbSyL7OxHCCitwHfPRTPq4ZxeBIzC6tx+uduH8PuoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
 Correct SoC name in comment
Thread-Topic: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
 Correct SoC name in comment
Thread-Index: AQHYtiN91o7Kn3wDgE2AlkVeUfQPvK2647MAgAJnvaCAAFDkYA==
Date: Wed, 24 Aug 2022 06:40:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420AFDE7D7617200C23636392739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220822123346.24089-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220822130628.GB16642@duo.ucw.cz>
 <TYWPR01MB94203771A805DE23DB11635792739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB94203771A805DE23DB11635792739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c8ff03c-2ef9-44f1-defc-08da859b7ac2
x-ms-traffictypediagnostic: TYYPR01MB6682:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 p0DsqiR2qqGwd0C1p1UGexijBtjH6XNXneicT6kAr4HjEvpl/r2eq5riv5Obs9jjZh6AXiZm2772U78l50MCNWcqvgtZvTEDfm5xoirAR30R17ALDAu5u12xqU2jxG5DTtLGtzvlld/7RCRXKHHNedNHh2oU/fMQCcYmwXECpjXPypM9abYzgAT7pRQPtGinvTPT00vwNj+jqLLeiERama71v+QMW77p2pZX+1QOl1SiDlJXlO51OtMIxinAokbAYk/Oi42Ow3jxVhGgzkz+SgE/dZMJmnWWBJQKd7OMda+Yen38GfLE+5St2FNWCAp0IXiBDgZKifJXhNrxiDsCNtL7Ok3g2cg5z36yzgPuHmn+ElYN0ITmwbadQ8uKTStC8SHnPJ1GQYa6sJKAFFGhvg8yokSrI4O1B979U7gkHxTEK0ZEnFbSjhL7wuvct1eM+LccgJyS6UTwLhqh7cxnEndAFCdAuhRf866wY3hwOgQOT0vS9shHAbiTQo+STxm/TThYG+M6AgP2s7rcf5wemPaSPG//0YUdZUaeGUcrUl/2/TaalvOaaL3/0VsS5wgbrLlKaibZXFe6cVRbEI1EJNdlLW/tQbfgfQ+2jhdRFVVSuu91REJ1YVyOsEUydrvcO3VM0KjYsWoZDYPO3ZmgqwGA8QJ3G/Nbny9lEUpBWoCaN6Wp2HBhbPM2Ufgq96lDv+i1CxcXOWy9t1HCHextbHahtdUB2Cd2If4BiFtMIi/nBGshOWZvGF4OQpsRgQoJ+50LrGMfs6Ka6+Oc0ywXeEqid2XDDzWMvcTBmNvp074=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(38070700005)(86362001)(122000001)(64756008)(83380400001)(38100700002)(8676002)(4326008)(5660300002)(186003)(8936002)(66556008)(76116006)(66476007)(66446008)(33656002)(66946007)(55016003)(2906002)(52536014)(478600001)(54906003)(71200400001)(966005)(316002)(2940100002)(41300700001)(9686003)(7696005)(53546011)(26005)(6506007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?blcwaU9jOHRoYzJZOEd0dzlBUEhqaDN4N0JZV2c3MVVRQU94dVdNdnkz?=
 =?iso-2022-jp?B?cWVFdkgrVnE1dnhsNStORG1WajlEOWZrL3VpR3lGNllQRHd3Qm54c0Vn?=
 =?iso-2022-jp?B?MThjVVN2YmhaV1h5MjBnNXp6WDVSQVMvREVjOGNTL0FYb1BuL3ZkZm5q?=
 =?iso-2022-jp?B?ZEZmQThzcUhJeEZQaGJweVlCRFdXdlpyNzNrbDlvYVlta1hDV2hHbDNU?=
 =?iso-2022-jp?B?aC9Ld0o1RjNPM3pqdDh4bzg2UlJZc1VhSmtFOXJvU3hKbnlIQnlRc0Zt?=
 =?iso-2022-jp?B?cGEzZlN0a3RvbStESmcxV1FFQ0IxRkNrdGdlZmtHc3hicUpWMmJiK1I2?=
 =?iso-2022-jp?B?ZlNBVzhKOUYxSklhS0c4VjZSLzFYU0FUcEpiK2hqMURNYTZGR3JXVC9a?=
 =?iso-2022-jp?B?QUFRTmQwNmJ1c0IwRkg4YTFUa1VreThMMzg1M2x0TkIvOVJCOEZMaCtT?=
 =?iso-2022-jp?B?VjNGU29oRURGc2MrU1k3blNlKzJDV0dxOXRnNlRhV1IwejFhZFhEcXBk?=
 =?iso-2022-jp?B?alUxN0E3Ny9PdHRxTjVqKzNxQlU5YWFvUW1mQTQyUUFOdlkzbXZuOWd5?=
 =?iso-2022-jp?B?aEY4Skpvbld6SXdYajJFd0NOUlNOLytyYzJlR0NJZXFqS0gydjNuK0hL?=
 =?iso-2022-jp?B?VGlUT2JBaFhIbTRuN29oRXlHSWUwWG9kQ0RSSmRWd0JCdDUvZmpra244?=
 =?iso-2022-jp?B?OEQvTUhWdTZnUnBqVGxxWHFrZWh5TkdYM1o4WWZKWjFOOWRBaVk0MzQy?=
 =?iso-2022-jp?B?ckhLNVZtYWsxbGVRTHQwRU4xdW9oQm5iQkhZZFRUc3lIc3JWNEpLckZi?=
 =?iso-2022-jp?B?U3pER0QyVytyVnFHRUdIZmZLTS9icE5YVHdFcjJ1VG1mTmdDaXFiTEhs?=
 =?iso-2022-jp?B?M3E2UkJ6Q1NqMTV4QlJQYVFwSTk4NEREMkN2Q004SGNJU2NlczFKMnZM?=
 =?iso-2022-jp?B?Nm91elozbThlcFJ3R1pNZTdsWis0S05nR05kZWxLeFVGZWJGVkg0cFJn?=
 =?iso-2022-jp?B?RDNCUHk1V1ppOTZVTFhVUjFMNlprUXZvUk5kMmd4dE4xbUR1N1lsMDdR?=
 =?iso-2022-jp?B?MlZEQ3BMektnWTdpK2VPTmxyZ0k3ZlQ3MzZUOC9RTExxSUNXOFc1RmRl?=
 =?iso-2022-jp?B?UmVaNlFMVzhDYkxORWZ6SDEyb3E1K0ZvZnoyazN0S3J5Rkp5dXMvYmNm?=
 =?iso-2022-jp?B?TUJwdjZsSFVqaWxvemlUZDllaE0yNTQ1eXdlNlZVaUlkSFVYQlBXZXc3?=
 =?iso-2022-jp?B?M1IvMXlIaytra1B5dzloR3BXTUNnR1JWU0FwZU5tQUswdE83U0M1dWVC?=
 =?iso-2022-jp?B?eStQV1ptWnJFU25yRjBVcGkzWjN6VkZ2cUIzbXdDREV4WDdqTXN5QTNr?=
 =?iso-2022-jp?B?cHpWNHdlS00vdEIyRVlzWStsRkR0UkI2Wno3ODVNVkVZUmJGZzR4Nmgr?=
 =?iso-2022-jp?B?aUx6a1VCNXNmNDRLRW5XV1p4ODYybGdwQ3FpZnZ0QS9haUVveEtma1Qx?=
 =?iso-2022-jp?B?UXBaamtqWVFSbDZrRE5FQVdtNFRxcTh0SFJoOFozTlBXdEt5WUttR0JJ?=
 =?iso-2022-jp?B?R3F6UXlJYm5LRkpLbENLWFpMaVJHNzdyeHp6UUQyd05IeVBrSk5XUVdi?=
 =?iso-2022-jp?B?REhXazc5Tzdxa2RyRGlENFExSXBmNWN3OVB0MmRxK01mSU0rNXlEYyta?=
 =?iso-2022-jp?B?V0p5VFl2YUdENmRCQVkxNEduQ2xxYzFpZUd3VEd6V3ZGeUZKb0ZJUEts?=
 =?iso-2022-jp?B?UURFSUpvaXN3N1pmb2tBY1ZYUmV0ZE9iWXJxSkNpSDNKU2FIeFc5Tkty?=
 =?iso-2022-jp?B?SFlYQkNsQXB1TW10ak5WcTd5TUJnN0FkL0EzczlzNk9GZlZWSDZUMzZz?=
 =?iso-2022-jp?B?VUN6WURkQkpsSU14ZG1ISUdvZmpIRFp1TEJtaC8wZ0UvaHlrbkJKVE1O?=
 =?iso-2022-jp?B?MjB1WThNTGpHZTBZMm03eGNwenBIckJJWmdXSng3Tk1oMkk1WkR3b2Na?=
 =?iso-2022-jp?B?cVUycm1iNXdvb1NpWkxqeHo1TmlFSjdPSm9Wc0RWd3R5S1BObWpkWS9H?=
 =?iso-2022-jp?B?TmNxYW5OUXZZOFg2eTZRL2RJSmc1MjVWM2J0MFozWkhWQ0lOMDJKQjdu?=
 =?iso-2022-jp?B?VzJXbUQzWGdvbWcwVnRFWHJ4aFM0V0ZMaFpuUUhTNWhHQ251dHA3QmM5?=
 =?iso-2022-jp?B?ejV5OFQyVHVXT3ppc01QeFhZSklPRFk5bnRQdVM4VytMMGZRMkNleVdY?=
 =?iso-2022-jp?B?WTBZZ3drZlBOVk9WR0xVN1ZxKzBIOC9VRTJ0Vm1hYnU2N3JiQ2dpM2d3?=
 =?iso-2022-jp?B?M0lYY2NDODlVSzBGczdrZlk3S24zWG9zc1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2c8ff03c-2ef9-44f1-defc-08da859b7ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:40:05.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 wRu1dRkRkcECryMteythYT+/Y57d3uRJ5C9Ygrtkwr9cgcQaHc0XwGTmJ9ICej3eaw1aU7hyOlARPYCdhAOfOzq1QiYHSVmE0xwZdFhFStZhskuCjSaijyzKj6wgCwtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6682
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Aug 2022 06:40:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9318

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> Sent: Wednesday, August 24, 2022 10:51 AM
> To: Pavel Machek <pavel@denx.de>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
> Correct SoC name in comment
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Monday, August 22, 2022 10:06 PM
> > To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>;
> > Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: Re: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
> > Correct SoC name in comment
> >
> > Hi!
> >
> > > From: Chris Paterson <chris.paterson2@renesas.com>
> > >
> > > commit d1273f541ab409242e08da6bb836bb564021274c upstream.
> > >
> > > This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.
> >
> > A bit trivial, but looks ok to me. I can apply it if there are no other=
 comments.
> >
>=20
> LGTM too.
> I could not find Pavel's test, so I am running in following pilpeline:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6210980=
21
>=20
> If test is OK, I will apply this.
>=20

The test looks good. I just pushed.

Best regards,
  Nobuhiro


