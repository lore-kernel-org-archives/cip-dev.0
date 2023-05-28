Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE00C77B7C
	for <webhook@archiver.kernel.org>; Sun, 28 May 2023 22:23:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.38300.1685312627030223304
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 May 2023 15:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 34SMNZlw017831; Mon, 29 May 2023 07:23:35 +0900
X-Iguazu-Qid: 34trk59YkaObNh0B7I
X-Iguazu-QSIG: v=2; s=0; t=1685312615; q=34trk59YkaObNh0B7I; m=hzv8BDLfnwkVFSCmPVz43J4XlNvLEBJwVPF2ZzxY4hY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 34SMNX4M038241
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 May 2023 07:23:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYB87slIVkvUqRxTNxkFPcNXej9nEw4KJabegYw3OjQ68cGDyz9fDVdJ7ypExaPTZApjd2YJdpQl9cmglEkBJ1xG1jEx05X1TOL8cGnrVkqbwq5OlYM+18KN+LD806lzrmJNzL3EZoo0lxG5rSiAnP8KtUY6cpAAoabhAofEjw3RaCJaUjzgTH/Sqc4LXcGIdrUbVRwNyha+7ufsRxQBlItBwsZ5e38NfP06ENmGiZEN4/88pLM2/eTvWnZxxwKDBKaEY8V4Ido+hB3m1JsumccMUbVBUASxILiDFtMTYTbg4peqhltxB9MVqbxmRdgGnRRs+kAZRwh10pBspzVQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfjqIZ504tYYC6ho262l4V/YT4led77j3hdI3xYsm8I=;
 b=TKTaFsx+5Od1l6Nbva7NpjSaHo554eGoqwrAh9UqzRYFHfxUMpJRp/vi58a0g1BREId2Q9ejZ+0Gkf/AkXm9gBQ8adi/XoPqcwAPwosb5Q+Y8sagFJ8m6Nr8E770FaSgu9FG3XNpzgYKk9YY8suEeKnEXNaALmLNm6YeaUik5H8Wr+FBjOeEkqK7PkS8j/2VAJI0VXMjk7nStjJWx24JdxnNXMEqKlLxtGc/Kg90PnEL7O08Wn/G65LzDUIi9yVXdbc98Bac29tOpq2wclaWFQECK6EJr6oM7Fh2RAXACUG6Rwws+cV4ycpQVRqiS1bZ3eTmtv/QyevXTrwE5BTnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>,
        <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Thread-Index: AQHZjj450go/Xfex5UOIXwKa9dCQBK9sC/nQgAG0QICAAokHYA==
Date: Sun, 28 May 2023 22:23:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94202627F38A60C6BF5D898492459@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420A2C36904A2A95575D48892479@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZHGzq91g7AC8PP/b@duo.ucw.cz>
In-Reply-To: <ZHGzq91g7AC8PP/b@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11874:EE_
x-ms-office365-filtering-correlation-id: 8777cb0f-7324-4c53-cc97-08db5fca2a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EQl59VoFSdSwbEB4bKIr63OREmUaI6H72web7JjNPzdPk68O5Mkx7MyJ7Mwy5E9GT1FCEG3gse93S79Vl8Jb5cs9qQbB0LD24IiTwBCa5+K3pweR36iTyfHx9zWPexViiyHz+31zBLkTFGU/RSBpy2YJVakBsSbAIYtRnYMPi7j6jWa3ow6e8MvW4l+Sk202F54cwGxNH1zinuvWymIcnA+yyQfe9PKMJNywJ8jOpbRlu+ACCxcJ/UBjXW43StP5QBnvyNm2b9hPxJUsODKFmsc1dgzvTNYEiyPvp+E3DkA9oY7J0P/dmnkVdEDPOxONMXZ7kHp8bgfFYNEDlLxxwUvalO9qWIPPtj2RaQZwQQ9e2ABr5zvOkz84h/wHTWIV1toRwkdcrTKH7Pm4MdMX2Yr8IG6Jc04V9V1zUFwTGtAK5AApEyRc1j36bEh4am5aaJWIW1VytEswswqFBOi7KBFZEqPQFckY6puzGsXN5DsQLkcxYgEhG+TsMV+bDJnZ2KmgBizlnn24+tz/YzyqIN/RpYZrmHep5NeipH2nHXzfmxoAnNokPoIBXIwb3JwtUhEYs2xp+5aLLNMWazUuYRs0iEyAROa0h0q6ymXjn8ZNM3PTT6qESFTkeeeZqlnvlacTZh4eHzNBP1IjJ56ubw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(478600001)(2906002)(186003)(9686003)(26005)(6506007)(53546011)(52536014)(5660300002)(8676002)(8936002)(54906003)(38100700002)(122000001)(83380400001)(966005)(86362001)(38070700005)(7696005)(41300700001)(33656002)(71200400001)(316002)(4326008)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(6916009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NWxpSlh6TEJDODN0cW5DMi82Ulc0d3c5UE16c2l6V0VqMjhoOVBqOG1l?=
 =?iso-2022-jp?B?cy9XeUxRMzRHbm9MaDdHbTd6bXFGQXh5aDRUbmtRMUVFd2VVdnBvTG1I?=
 =?iso-2022-jp?B?cG1zN2tDYW9qTEZDTnE2VndWTmpMVExkcFFjck5CQTNnSjkxdDVWSksw?=
 =?iso-2022-jp?B?WjAxb3JoejZwSUFXaHNaYklOcmlTR0g2bzg0cXkyWW1qU3I4UHZpNXRu?=
 =?iso-2022-jp?B?dnpWTUZBem92bFpLSzVCeTgxUW1rbGcwcUFuVWZMZW9lSDE1Ym9ocTBy?=
 =?iso-2022-jp?B?bFpYQXJBeXBQdkFSbmZBRWQ1WWYrbkorVFJxL0NkUEZLcUpMckFxQkZn?=
 =?iso-2022-jp?B?NG03VVBWR09RQldUYVJ5TzkvQzJINDdWYUQ5UWxuY2l3YWxoRFpZWTNI?=
 =?iso-2022-jp?B?YWVnSUR0eFJWWlVLUDdYbW9mRk1GV0NQWXNtaHVvNXA5Y3JzV3hBUURw?=
 =?iso-2022-jp?B?WDdzalk4Z05ucEUxS2QvQnVabkRyeDRTZkVraE85UUM3SVY2b2pYTVpn?=
 =?iso-2022-jp?B?cG9tL04rb3dHMXdkbUo0dHJNSW9ickNDSGZSQkZUU0J2djJYcjExcnBS?=
 =?iso-2022-jp?B?eHd1L21tb3dZS0syelJqUnBuQ1h1QUl6SmlSNE5GVURaR1ErRzJkYitM?=
 =?iso-2022-jp?B?S1M2YUdMMVk5R1NUcGk0cllZRm5sMHJUQ0RRbUVhVXN4SzBNYnBSejUx?=
 =?iso-2022-jp?B?MVZyNzdvZlBiNlNUSThxZ1l5SlVrRERQbGU1UVlEQ2xrNUV1V1lkYTls?=
 =?iso-2022-jp?B?dEJTbStRZmpYZk1ZRzdhTmVYRjFkR3NMWkp6QkhBZGVwczFGRDNPZ2ln?=
 =?iso-2022-jp?B?UlNZK0NJM3JOTEJLS3JPS29EUGdLMGVVTUNYUkQzL1pXMzVRUDkycTZi?=
 =?iso-2022-jp?B?NG55elNQYU9SY1VnRjdLUDlKb2l3ZGlERVFwM0lOVko0SnplSjRRT0Ex?=
 =?iso-2022-jp?B?bU9KQU91UGYxNmNOK0V4OE0vUzMyUFNkV3FSWlUzdm5hUnN2VnNEejFp?=
 =?iso-2022-jp?B?azY2aSs0a0xwUkczenhYVU9jMWNFaTdjb0FvZG42LzJqVzZqUmpkb2VS?=
 =?iso-2022-jp?B?ZnZueWFKTHZvbzFtRmZHRWN1SXZaRlllb0N4aDZGSG9xeTNxaGJGSllS?=
 =?iso-2022-jp?B?UlJKQUN3VlYyWk9uN2xISTBQNVlCZkp0K0E0VDVuNDR6bUhUeHh5QXNL?=
 =?iso-2022-jp?B?OXBWWnNyNDhEZjhFQWxTM2VYdUFkZmEvV3NXUDJXay9yb1JkT2pmTkxl?=
 =?iso-2022-jp?B?T2gvbEFJK0F2bHlpMVVYNVd1UUw0dGtPRzJUcE1NQURJaGpKQk5UNlN6?=
 =?iso-2022-jp?B?ZDRVY0VwZzhKQUFtSk5ldGMwNWRUcGQ3Q3k0bUxFSG84V25nZHJUamp3?=
 =?iso-2022-jp?B?cmlDRHA3N2RiN1ptR2E0dXI5d1p4TVZTcDZYYm9EK0NFUEhEYmMxWDhC?=
 =?iso-2022-jp?B?V2V6ZWZRZFEwTVZRMXdpTktTZHpMSzFOUjNiNlpwTUp0WXIrL1R6R3hj?=
 =?iso-2022-jp?B?UXpMV3JqZEMybTNIOVozWUtxV0tWbkpjaHVXK0JBVEswUUJlMTZvYUdL?=
 =?iso-2022-jp?B?azEzSXEwUFRwYXNqbUtvUGUvNzMvZCt1bEkxWFNVcFgyQlpWZWd4eGVm?=
 =?iso-2022-jp?B?elVzdExHd3UyTGxiSjN3c1VrOTRiSTlwZXZ1aTFDNW1QSHZOYzBBUEZj?=
 =?iso-2022-jp?B?ODJqR2UzdDNUbi9mRXdSeTVDYmdXOThOMm94UVF6UHhVTldxYmQwUHE2?=
 =?iso-2022-jp?B?Vnp3SlNySHoxcndCOGROazZKd1ZLV1k4SDMyVkVQOHd5aXRWOWt2cngr?=
 =?iso-2022-jp?B?Y0hDZkFHL3JPSHF3U0UyV054c2NIVjFiRVVwZXFwZTlZdjR3VC9JUG1U?=
 =?iso-2022-jp?B?d0NOTWFOUysyUVc0YTN0YWpITHMvWFAxTmZqMGhwaFBXZE5ROUtuTlNI?=
 =?iso-2022-jp?B?R1RsN2kwdGw5OERQcE5rQ29nMTdmdFMzZlluczQwd1E4aFRBUjR4Ujhp?=
 =?iso-2022-jp?B?S09FMUhKKy9RcEV4dXVqQWFNOWRFZzNLQUk0eXp6TkJSS2UydEV5c1I5?=
 =?iso-2022-jp?B?UEo1d1lFR0tnQlFHS0tlRFl3a2FxMCs3aVRBZzhuK2R2SEFxZktZT0M5?=
 =?iso-2022-jp?B?bGhmYVlHK2pMNzJPRzJJSGJzNnFKNWFnSzJWVDdRdmxzNTVIcnYwenU3?=
 =?iso-2022-jp?B?cnhGemJDYlRuSDZ1V25WNUlnbTFZYWdJdGxvS0tkLzUxSjc2aUp1WTVF?=
 =?iso-2022-jp?B?S2VPMmhOa0pqaEZWcXdqalplT2w4S1R5Vm9Wa04rRzBpUjgwdHg4UE42?=
 =?iso-2022-jp?B?VWhyZVRPSDVOLys3RVVmZUFGQldOWXYzOXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0pucQrrE0P4BSDkeVIHmNoHUuI1A+HO9HV7EDmIwNCBMIYV+J1IinNlUG6Py8i7YPKphDZzCDAWI9OTAhA/xFKV6I9hpGMXH7UaAOFZ7V3EeXOoNC1eJXnH962nN7wDBFnxRBxAO4nmxIJzOWJg0veS0GIFhGVNOCqpO3k+zurUmydrYiuTqfkiBleW/HjBGOpG/Rzy/c42DU/OpyqOeGkCS8gsr8zOR2AAlKSa/4zXzqD4kpN/wcEipUZE0dNllOpnlAioS2kZBp1Vcs/pVFTMTeOFTZETlSQcQDDRojdMS5CJWWU2JCRUCh2f8K0XfRCNsuDMfM5P/pqgDvMKNUE9CATfE5ix1lSikbLpIEQJNq/PFh7rxVndMZtoLk2yyrvIVhldXpM/9mmlODW+xFxHY5gXZRdJhuxYZmfRmjEVBr/7v6Jb8W07as1GKXrQYJH7pVqzOBSpwF14sxAJSynPV4daIxXHntEhgm7huujLN1nDoYk30ek5PotsQUW2adJUrewzIrk6omycVzgxv1ODsTKoymZrwtllUoS6WelaZH8lBcK3TwYV62ZhyCtwGym81jwahC+rX1zR/UwXpHLXpjBZWA0z4BRj7KYGVTz3puEy65LA4TwpWALFsrH7PWBIZffuGTfn1EvQNp3zaUemDe9V7H4Jr3TAJRoK4dvOy53+n+lzhR4RKMFo5sHt80RVriksLDVsu31Z7dD+498sV19BLAZqeLuoDKHGjoPGCS7XENjwWdCpEF7BzNZoii1IRgLbWv4I5mh85sqgg2On8hlbDZEXV0J1IfHa7vPHO5Riwiy7ZPjO2K1fOd6jH3Owal7OGr8KyHDTWYaB+XxGqP4+ue/5K+UZBeedllIEZ8+CJmKG4cAkfmZNV/So0XUPewEjxyswgwYLY9KXT2Q==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777cb0f-7324-4c53-cc97-08db5fca2a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2023 22:23:30.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dseEgXygGvlWUv0YOxvXxaMF5tdnw3J+36uYfujWotH6tyrgQY0c9sn+CVRzd75MyuQOf7KOeU+jzOVvOqxNYnaYdLIoop0JZ1lm6xB3uMzT1HiMu+ISQlgGQsSa2uLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 28 May 2023 22:23:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11670

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Saturday, May 27, 2023 4:39 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; chris.paterson2@renesas.com;
> fabrizio.castro.jz@renesas.com
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
>=20
> Hi!
>=20
> > > All these patches are cherry-picked from the mainline.
> > >
> > > v1->v2:
> > >  * Dropped patch#2 and patch#3 and replaced
> > >    SYSTEM_SLEEP_PM_OPS->SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> > >    and pm_sleep_ptr->DEV_PM_OPS.
> > >
> > > Chris Paterson (1):
> > >   dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Cast=
ro
> > >
> > > Fabrizio Castro (2):
> > >   dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
> > >   arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
> > >
> > > Geert Uytterhoeven (1):
> > >   arm64: defconfig: Enable additional support for Renesas platforms
> > >
> > > Ioana Ciornei (1):
> > >   driver core: add a helper to setup both the of_node and fwnode of a
> > >     device
> > >
> > > Phil Edworthy (5):
> > >   clk: renesas: r9a09g011: Add IIC clock and reset entries
> > >   dt-bindings: i2c: Document RZ/V2M I2C controller
> > >   i2c: Add Renesas RZ/V2M controller
> > >   arm64: dts: renesas: r9a09g011: Add i2c nodes
> > >   arm64: dts: renesas: rzv2m evk: Enable i2c
>=20
> > I reviewed this series, LGTM.
> > I can apply, if we do not get any issue.
> >
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/090289427e8b
> 2be9dac126c4d1b760b100f2c6b8
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> They look good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20

I pushed this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro


