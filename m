Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF2CA5FA1
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 22:30:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70372.1790634630294709259
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 15:30:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ry0OyYPM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790634626;x=1791844226;bh=YLxZfpq4+YDDyM4rXKEDsWnG0PKOYsNWYWvua
	EpSVFY=;b=ry0OyYPM3E85nOIjIM3Py1tLl2D7FqT8RH0mURMA5u6QP255VCvRvcRPUA0g5NAJ2wC
	b+f+ESnrV04gYyOo3TjaiA1Qyb6ZIkr3rqB7iXdgfP7DZedgPoHdzH0A0uK//eEVoP4fW2/eb6kzT
	st+c2mctSH2HXb+d0hn7ebC1kI1O/yqpLOQDYa5H2ud2mXEn2R0cyHEUf80DDwixFb20Su1hFOxa9
	qOtq5vmg5LegPfHD+y30kCNmujH9A7Hdks6kbUD0k2939yl2DLyXO5oUHQ+NN56bLLegxT5ac3vhm
	kHdMT2cXAWlPA+h5wqWMulcl9KTfRbQuAAVdccSeCLDA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 68SMUQEU2356584; Tue, 29 Sep 2026 07:30:26 +0900
X-Iguazu-Qid: 2rWgEvqjf3DeDIsAu4
X-Iguazu-QSIG: v=2; s=1; t=1790634625; q=2rWgEvqjf3DeDIsAu4; m=s4GjsCOnoYut5st5KllGLERr/Q3tRTkt/jYjPAFflLU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4htwxF3W1Yz1xng; Tue, 29 Sep 2026 07:30:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn8VzFjtsa6PWCICs8BVy8b/QfT01a1Q5FDNziWyJy+QDsPTtP1fixiLcqHtnweh/41iNMujy2WLj9I0MmK4WEDnlvtrlcvq3rmVaArb9GEbZ1PZhLVi2qZjY61lq7uiEWI/UAZ9XlFArhwwAHLqZrxTpY2e0s4aJmcd4L9VxxgJynrGbQxKlMSBQ0g/nBGgsIPq/7Pb2JXYQCToJVRPKY8P5r6OUTVrhxEqPhVVrjLirj51RuqaX59neY9h62YV2OmDIv4aNAY2fkJ7Cnml1+k0aB4KUuNnNzuiyWlqycpl/rM8+p2IESXCXWPUsm2n2237fGIqE5M68gIyJzGbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OluETDPD8PdNUdlzkFbpaBcDqsLYNjzxl5wHlEUe6fU=;
 b=yXm1KDs3D+L6m3pxZkqozJVmtRqWljh7xAEICksVYNR2zQJLyAANjAwot2ZtPjb5biaK+BkbTyAoOC2qo8EjhYYv7fDYvsnrMjaUGcgMDg/oVEH1jk9lMxfe/Xc6MbmUE65XWAYtT5VBkdYw4xSpD1uTQl6dQEcNdDuLOh3OtCfTRv5VchM0tdLKcaGxolZQoJDMgjV30dZ5b11TWmICIGtpWKQKCZjy1+8odUwUDGcy8hNHxUulFkovwE5a53/QPrBwkupPtBcDRcqZbPH9Kq19areN1wx+QhuN09JJ8l6rA3m2f5UKiRaqDeAArsd+BP7IKms59Qq5OkGYnuVrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Index: AQHdRoTpJGNwLYH/pUyse3FxathRzbbfAWuQgABFrACABV2EQA==
Date: Mon, 28 Sep 2026 22:30:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A80265B7C4F524D6899ACD8D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB148184F29618545209EEF1699CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <arZqGGvpX429C0OA@duo.ucw.cz>
In-Reply-To: <arZqGGvpX429C0OA@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: 73eb021f-548b-4063-d71a-08df1db01610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 LMvTWoYGkaudnDnEcnji/aYzzWMpRvyrhFCPqcQUgu5datqhSczVZyLwItk8+z8BcE4S+hYYaL/juj5ndtFs1xd0yW/eGYvP6sDAHdFjImJciM6KMBKjPFQmNSl+zJNJ3Kw2KJzn++0fmwYbzkpnNjg5I5cQQg6ssoiVh7xpUKu0D6ZsDagBSMHud1ZlL6SJIEkHRmtHlg9LNotrRx5MnEgc69GM5xn4LV1PsOrVD2yTL0sWV1CrlbfSJHoKl4eYxwHmn2bvcTx3ggMfHuBtKwfOac8IHhVl6Rvm59binkRuqAUoiWy6wuMleKEYwNqsjkxjVz9Vr5DeRO2JRQssWbkSdQ2v+UIEKMpsxwpSUTzBVihBSRmAMwQEYjsxBLnVh8A14tV72A5mNMncTsx6UxmubdDh5+7X11EQWfB1gOieyP6H6ZHUjMsasBqV4bwhgE6VqmraZojXjEQhiJTdC3OnXjdzYjrKxJbjjGVoE2EaLehee1XeWVxXfP9FlYNZ9L9cmL8kGZpRbUXFvAOzrFFn2oxNbhjNJ3aoft9K1q1fAUkZa4SpQWgj5WiAbySw6nY2bR/mnwENXS0TyoREhi0Ckk4HStE69/ZKfPga2bHIbx2cVXYfMI5g8PSEr/Gg90thVJrEZRT61zvfUUB3DmrQW4u/tSc7ZPbnGxAWB3E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bERtUXB6MGw3NVRDZmlCbW9IZGFpcS83QmVHcS8rQkRjTEdjcFdjcmE0?=
 =?iso-2022-jp?B?dzFtcjA2Y1d4cW1TQjhSZ01yeWJleWliTFlFaEt5ZmdobUNmZHlobHg5?=
 =?iso-2022-jp?B?Yk5RRDFTTENUbG85RVp4OERWNzlrR255dndlN1NkZWszc0ozY2JRSk8y?=
 =?iso-2022-jp?B?c2JEY0JpMXphRzdjbkplVjh1RGI0b1M2ZkY3TjVoZDVwQng5Y0c1cUJM?=
 =?iso-2022-jp?B?NUxZWjREN0tsT1ZIdG00bjIzY1JLVkU0aGExdVZlaWJyQzNIeEhxVTBJ?=
 =?iso-2022-jp?B?UTFqbzlVSW0wWmwycVJUc1YxdnRhb0UxbkQySXY0SjhNUExoU1dUWTdL?=
 =?iso-2022-jp?B?cllPa1V4QVNBR3V5WmFXcS82RzJoR2QxYytpcjNwV05TQkhPSVFVcENO?=
 =?iso-2022-jp?B?K1Y2MW1KZVZ5ODB3b3VkbWJSNk5naTJiY0ZjMXIyMEN4QkJWd1ZrczNa?=
 =?iso-2022-jp?B?QjFXeHFjTTNmVkhyTGNPbGRrdFI5c0FVMy9sREQ2NTBJYnVYVHBwZW0z?=
 =?iso-2022-jp?B?dktoN2JpamlEekt5d0hiZHpFdVNZRThyQzZ2RS9UblNpcFJJeUEvTU4v?=
 =?iso-2022-jp?B?ekdkZ2pzWVhnK0U1MGtBOHMrYXZNemc5aC8yblFPdUVlQWNuZENRQlhL?=
 =?iso-2022-jp?B?TGtscXg3QTlpWHZtU0xDTlY4R2tpaDJPTW9OQktpWnZUcU0zUHExNWVZ?=
 =?iso-2022-jp?B?WXpSckRMbFN4R3lQb05NQnVpOHR2ak5nV0tuRStCRVYyZFAwQ1NHc3ho?=
 =?iso-2022-jp?B?YndjYVJpUnlMcTBzMDlCbkUyNzkrY3pHMkkvSU5XblFDbmdvTWtZMXRG?=
 =?iso-2022-jp?B?V2JxVGVOdituaHVmbkxIRS9QNHdPNFZIWVdjRmZEem5VYmN1U3lISS9w?=
 =?iso-2022-jp?B?ZDFKK3d5MTQ0eHN1REpudjV4cnlzdEtFQ0lyT2haK01laTV3dkZEVHl0?=
 =?iso-2022-jp?B?M0R1WVQ1WmVEcUh2cXRJM2ZCcndCenExNlJtWFYrSlg1ZmZNUENNUmpw?=
 =?iso-2022-jp?B?ejBqK3V6NVozZjI2RXpHcEJKN1gxbW56cHBGd3Q5UmYxMEhHdVhxTjl1?=
 =?iso-2022-jp?B?R2RKMi80cjQvb1VJa0Fsb0xWeFN4VzhlOXd3MWhEejdrcmJQWjR6Lytl?=
 =?iso-2022-jp?B?Q3RsNUhKRk9MYXNzaEl0THdvRDBLeGlIVWRpcXNJL3haYnR2R0xaN2h6?=
 =?iso-2022-jp?B?TjNyYTNpVEhBMXJ4dDNFaGdKME9ITUhtUDdHVDJvL3YyZENuM0gyNG5E?=
 =?iso-2022-jp?B?RHo2MCtlbjZlU1hnQWFKbnBHakpERGttTENwZ3RsYUdtMEpSY2srMG5V?=
 =?iso-2022-jp?B?NHMveXphMkhGVC9TbDQzSDZReU4rY1JJalpXa2tYbjhabWtKRW8zaGlO?=
 =?iso-2022-jp?B?TTZyQ0pqakZjY2VsNlpCbS9zeTR2UUYyZngwcHAzNDczYUpxRjhxNjFQ?=
 =?iso-2022-jp?B?Q093eWVMeEVmMHZuNnhHYkp1bGN3RVRsUXNLSDdoOFlWeThhSVkzOWxM?=
 =?iso-2022-jp?B?RUJLM2dWRkhQVStPUkNzTFczUVQ1T1ZuRkZQK0s4aVVpMy9Db3RaR2VW?=
 =?iso-2022-jp?B?bFM1MTlObUhQSFBUZkV4UlRVcEl1alhQdkN0TDVXVE9USzBENHMvWTlW?=
 =?iso-2022-jp?B?V0hFY0lQYW5MUGZLbXh1cVQ0VDJ6WXo0d3Y3SWF2UzJ3VzM3ODQ2MzNn?=
 =?iso-2022-jp?B?ZTAvV084UlNCZDVsZHVrK3VyR0s2cjlyRUYzOUk5Z0VRM2k4OFE1Q3pU?=
 =?iso-2022-jp?B?NjdIQnh0aEZhVFlCckJBcEVLS21tQThKT2R3QlgzTGNjWmFtWjcrWXR0?=
 =?iso-2022-jp?B?eHh1ZFN0Q3hUT25YNkVaWUlOM1Y3TUg5Vk5vRVBjMlNoUUs1SE8rdWV1?=
 =?iso-2022-jp?B?M3dlVzhaamlUZGwzVzJIdFhMWithMndkb29DdWJiU3hlcS8rLytWUkVq?=
 =?iso-2022-jp?B?akdBd2xRclJ6ODArMHJ4bHZqVGdiRWUwa1FqQmZ5QjJMZEt4YnJBcFZi?=
 =?iso-2022-jp?B?RUxVazlkL01WUUpDVTFqL3lFZkR1SFhUZTN3QWNNTmd4cmt5c0IzLzNn?=
 =?iso-2022-jp?B?REZ2eEMvOEhSUlZobExCYk93cDhVV2M0eWRsZ0QxVEVnY3BBNWgwU1ls?=
 =?iso-2022-jp?B?RXljTXNtOUdBcCtqajduenVEVUlVQUtCd0pkQTgwd3pNWHlreHB0VVNq?=
 =?iso-2022-jp?B?cGpBREJkUjE0d1lSN2NIeTdDZVUzLzJmQVptQ1N4dk9Xb29GbWJTeEhm?=
 =?iso-2022-jp?B?eFdPanlWOGtwWS9hU3R4amJ0ZWMyNkdpOHAzQ1RBOUI4aEplOTBwMkJW?=
 =?iso-2022-jp?B?VUE3bVFEQ2MreE8vcFkvU3VuL0tUTTV4MEV4cXExS2FGd3Z5enJlTFln?=
 =?iso-2022-jp?B?K29VNzBFY3JuWkJST1VCcUFvWmF1cEZrVjFLZWc5TUM1WEFEVUVHWWhj?=
 =?iso-2022-jp?B?UGhOTmhxSy9qMFliaFQrVkRqRXRnWkJVdjJGV1g1NEwveWZGOFJIRlcv?=
 =?iso-2022-jp?B?TDByam9Cc2ZkTVpRZG9Zay80K0FndTdFZlR0Y0tTWUswNS9hSmJaaTYz?=
 =?iso-2022-jp?B?ajl3U25Ibz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	4VxQhO6iIRYgYa2fMgAlEjIuYEPxt+RloaTm2aCrSVkWGWWQlbDzBW37xmx3cvUgSj9gwEvV+No+trXcZ2dEF15LPPM58WnyNlFu8w9vVS1zEZWfT2lVsUkpSpwRaJIKx/QAYXYYWDguVTVKN7M4x8r6XG3SLwoIFP26qjDMj+tA0cdsjrJgtu0k0ALw1pv8Bj8gg1FNHekfjFlpDqt6FTZucO1EMhaOM6i/egFiIjQLdLCK+2wFTS+SJGaTcBdJP2eKV9nL3z3n+hbbOObw5xITpm4tCX8kGwKhh/FnmbJTJ5/1AlPwAakHoq+VMexkGlP/UWhFHnt+pT+ZcuVDDQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eb021f-548b-4063-d71a-08df1db01610
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 22:30:23.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENmvO8oNxLSaIhND7Dn6/HFfNYm6pvD1jakI0xS2j2n0BQG/latYjKMoD13bGo/gzuoNBu2ZJF2PVDxBituIuTEMfjZshXzf2ebDP4yjL2CG6bg9wHS9dFyiH2gvvFks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8441
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Sep 2026 22:30:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24369

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Friday, September 25, 2026 9:33 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g;
> pavel@nabladev.com; biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N
> SoC
>=20
> Hi!
>=20
> > > This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP
> > > on RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for
> > > which patches have been already backported.
> > >
> > > All the patches have been cherry-picked from upstream kernel.
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Lad Prabhakar (6):
> > >   rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup
> > >     error path
> > >   rtc: renesas-rtca3: Check RADJ poll result during initial setup
> > >   rtc: renesas-rtca3: Fix incorrect error message for reset assert
> > >   rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
> > >   rtc: renesas-rtca3: Factor out year decoding helper
> > >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC
> > > RTC
> > >
> > > Ovidiu Panait (4):
> > >   dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
> > >   clk: renesas: r9a09g056: Add clock and reset entries for RTC
> > >   arm64: dts: renesas: r9a09g056: Add RTC node
> > >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
> >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are no issues and there are no other comments=
.
> >   Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/288156
> > 1788
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Looks good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> As you are already running the tests, I'll let you apply the series.
>=20

Thank you. I applied with your Reviewed-by tag.

> Thank and best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


