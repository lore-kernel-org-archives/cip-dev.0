Return-Path: <SRS0=NvPH=LQ=lists.cip-project.org=bounce+64572+6570+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED604C2B9F4
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:18:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464026128C
	for <cip-dev@archiver.kernel.org>; Tue, 22 Jun 2021 08:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464026128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6570+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1BDjYY4521723xFFcQMxPYP1; Tue, 22 Jun 2021 01:18:29 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.5953.1624349906991970150
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jun 2021 01:18:29 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 15M8IIrH020867; Tue, 22 Jun 2021 17:18:18 +0900
X-Iguazu-Qid: 34tIXnnNeQyUzXkO4z
X-Iguazu-QSIG: v=2; s=0; t=1624349897; q=34tIXnnNeQyUzXkO4z; m=vHomjMVKwbVyKkFbSnIevDn6WKyK33gaAdFwvG+ViIY=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 15M8IGe5036538
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Jun 2021 17:18:17 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id CE4041000E2;
	Tue, 22 Jun 2021 17:18:16 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 15M8IGYM029294;
	Tue, 22 Jun 2021 17:18:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TecYLw6ovNMmJgkQoXlfNHaMOEn4Ue8YsoxXgi7XagvOBuYg3v870GKeMm7c4o4HjboHxH91WTdnkcjR8ZjcLGO2cxNnv8GYrCBCJraLf7wyMRwYyykfQgy3Zd00gb3fBDyK1KO/NK3imeFON+OKe0kOOE5POBLAFja6VKtIie2nEIgNvnYOI50IIXQMuX21D2RnBCYtd+5AdsY9NyrH1glwpK3TmuWLsroYrvdUI2A6MONiYXnf0YzkAgfzTIipop4GCJJHQxz5Uu9Ax2l4Fzs/HNkDYoDj1BC4okuqvM8zEdnJvVzDBqoE0lT8jSD2pBJP/WkXf58i9TlHk5iX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RRm6pTvgf0gips+lUTzEQHWCCCF2kdjcbHPxGdcKRY=;
 b=drH9kqmjq4hEmK4UT5SUjjpJj40vKMosEJoCgIAZlagHvIjy2g0eI6fquAaPfgpmS3ODF66bNpDikLdRUfz1p0HCm9i+isf2UHWIuE4V5aw6o35gTigpARcnwbPTdinfF6TiN9OJJ2hdUIJjK4EVD1kmqCdikNGimB7yLtoQBGrWG3MNpp2VFUPPSxsvbIPSk9Ix14uTH8MaiKxtLihMnReTmU4Xhh+ka37S82b04nOp8dRSJ7MZXrGqZ6VjhY4WnOgRkcQBlRsPxqbAJuB4JxBAEXM+TGmzUO6sb2QIKNdGPFJSwy4E8qsGf9oLizLf/devFhO0adL2vriJPjVTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/16] Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip
Thread-Topic: [PATCH 5.10.y-cip 00/16] Renesas RZ/G2 sync patches from
 4.19-cip to 5.10-cip
Thread-Index: AQHXZsA3NE2os2oivUuZrH8/3j+Z5qse9sAAgAC3jPA=
Date: Tue, 22 Jun 2021 08:18:14 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252A1B4A16A886C300E52F092099@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210621211222.GA2230@amd>
In-Reply-To: <20210621211222.GA2230@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d28baa12-3ea8-4082-cfbf-08d93556488a
x-ms-traffictypediagnostic: TYAPR01MB5548:
x-microsoft-antispam-prvs: <TYAPR01MB5548BFDFDAB2246746301EBB92099@TYAPR01MB5548.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R2Fz2SAxn4AR92a5xSiCdNG3XkunFT9twCESlC2UXJ3LMOQYivQEUOd6/GPykLetMdf4Mb97a2kWelT9M+Bz4v8sytrgoz875oBSkPpYN2Wz7Pwq4+/KNB5rZaH1cGAvBvC7kVfT81v0cW1CNEJ4H6BDxX9jQdT3xw1IqusSd+RXcCpQVpDC1SNTQVnKQPhmc18kLTtm2Vb6k+hqA9G51GWSoY/FK298Yp0Pxk4BT/9SELdcEP4MsYbH2kSYj/DXzZRF2Y4si6m2k4Kb+IC0cdjjeQmRyzpEl3cUADJL+gcDGHoE2JXM5e+MFRmPm/Sdxr7tYzHlXxKtcki08r8EfTNp0VOoFUue6FELQC+7478HEHvMVXsQ0EaUWGa7cZIVr9qtglFvCMfm5qTr/Hd3RarVhvsO4HtiKYHvXDT4wxfUnwPdjkOp5c5fU6rdBXoO9SETZu22N5kI+HMSo7bZvhCraMjK871Q08LANp6s1ksx0QpF4Lpcf/28E2f3CZOzvospvqNFMY7g1erKugtYihyD8b9L8I/ioAqt3fjVHR7+Xm3nWazM2x3v8BdYz14uM8lFSD5k7M4Fa+OucGu2NHAN0m7NvjRDaFMmz39cNTU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xVL0lSUTdqZjBWYjRBSkFDSnBnUVZIdlBDemdtK1JiQ1N2dmU1elJFMDVE?=
 =?utf-8?B?QXJNdFMyVmtIdmN1WEYxblZBMzB5eURYQWp2M2tPR0VvaHJybko5Mm5QV2xa?=
 =?utf-8?B?aWFzUjR0RWFNZ2xaMk1rQnVCSk1LczFXTTV0SDl4dFBIQVA3bTZSS1p5blJh?=
 =?utf-8?B?R2NHcVNwQm9sUERIeTF5VmlxUnlqbTZYeDRUODlvVkNXdlJpY05jMjY0d1dJ?=
 =?utf-8?B?MTJRclhFL24zaXBNbVF6VEw3UURrRlowOHNNY1E3eSt2TkVHVWV6aEpad09t?=
 =?utf-8?B?N0NBVWYrZVk3WkpTSGY3MktKK2VHdlg1OUtIL2pqc3BWdVAzSzNYQmZzYVlN?=
 =?utf-8?B?dUVoUHFhREgySkM4bFhhQXFib2RUSzVDRnRKazA1RktNTU9vNHg3YXY3YnZs?=
 =?utf-8?B?RnozcHNjU1E5anAxaGJkTjdNd0NsYytOZTh0b1RmcE1LS0c0S2R6MWxuV0FE?=
 =?utf-8?B?TlZWYTlmaFNqQWFKdS9uaEtPcHBJVjBvYlNvRWswZXNsbWhHZ0xDOHRyVVVR?=
 =?utf-8?B?djdxQmorcTdEc0d5WlBkZFdTOURRM3hodlVTQ2x2bzUwa2RyWnRWcW5BaVY1?=
 =?utf-8?B?TmVXN3h6c3VxbW5NUmpGZUhrUDdDVjZZQTBYcGV3Q0xyMnZ2cmJhaVFXbVVi?=
 =?utf-8?B?VFlrMk1abVEvdHFzUHBQQkxjMHNUNkVIdFFjeE9kYjcxdDd6bU9wOHdUQmhN?=
 =?utf-8?B?V01ZTXFNeDRKYTNkb1hRbkpFa051b2dHdDVRd0hyTUNvQ1lMU3daNkdkSTVq?=
 =?utf-8?B?dEdVQXBXOW1TaFpBVEFqQWY2L0tMZjVZNkk4MEt6NUUyVDlGcHdGRjh6emdC?=
 =?utf-8?B?cVVRaTlZOUh6OTl0cU5nYWhUditRNHdrcDh5N3FFRFcrME93cXE0cytjWjJV?=
 =?utf-8?B?UEFZWG1pS05MZ1J2VU9XUEtjMjlvMnhJNXBoQ0U4eDhHaUZOTzF0K2M1WDBj?=
 =?utf-8?B?R3hFanZRTGlHclZmK1pCVFNaM3BtYi9SNlcrcWlqRC9xZFpqWXpIbS9vZ2dn?=
 =?utf-8?B?WFNVOEZQNDhaNmJXUVpka1d3QVhJUE9iWFZqTCtoMmJ3L29KZTVsd0s0OUJN?=
 =?utf-8?B?RlJRMFMzVEthWDVFR3JNcVVQQjRmNGowMDVWRU12Unh1UU0vamJVdmQvZXZC?=
 =?utf-8?B?MVlhdU5hcm9BdHMyU0FFeEMyTjV6WjZxemVOL2RXZFNBZmlidDFkT2tUc29t?=
 =?utf-8?B?SEl2eEdrc1JzOURiam9ONTJscExDaDJTcXF0cGNNa1JKM29SRWxFbnp0M0Vn?=
 =?utf-8?B?aCtRdVBkTGUzYTRjRjFhNUExekt2ZjdXakpWRzJTSk9TV3NQVEF5T1QyajhU?=
 =?utf-8?B?Q0hNenp5a1gzLzUyTTVHeFkxeUJpTHh2QWpmSVF0akYrc1IwcVN6dnQwbEpl?=
 =?utf-8?B?enh5bE5kcEZrZGdmck5JT2VDNlJaL1NmYVlsdjgwVDNJOVB2ZzFmSWE2L3Zo?=
 =?utf-8?B?VzFQajIvZG43TVhycXp1MENqUjZJTEtaTWwwbzlEWlFZWUxLVFluSTkybnds?=
 =?utf-8?B?OCt6b2RZVnNYd1FSd3JqQyt4endKQVVmQnJuWTQ1K1VuSzlGNnFKOWc4VGVM?=
 =?utf-8?B?VmxPSlFWRTArSzlKZW56U09mQUFPdGp6K2hTVktXaWFVTFZESVpnQ0w3UnFC?=
 =?utf-8?B?c0pUYXVRMHV6MzUra241ZllXeENNSU1FamphenZ5YkovaEs4STJJSkFBMFpz?=
 =?utf-8?B?QWhRZGRRWGlxYXNsbzZnS2p3WFVGWnJRYXoySnMzWlYxQmdDaHgzWjQ2Tkds?=
 =?utf-8?Q?CtioX97H0H4aC8QS2M=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28baa12-3ea8-4082-cfbf-08d93556488a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 08:18:14.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw4LAiP5LhnHRVVGVbh4uSFc/pS4YVp0J7Tax4ewlYq8EUyVGRcYLPkscXqOd9Sxw+cdp1PhpVUNCV6Hs4thaZapcmeWVO5CqcMJn2uYJ4xAjjr+blrZ8ZXCWPlOMxA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5548
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QaF9335KPA3zmVPWcFYycLwBx4520388AA=
Content-Type: multipart/mixed; boundary="UxYnkjL4hvd2sj9vsl2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624349909;
 bh=xUzOuYXSg+KsUq6gXVlKAf/+HNSOOhz49ve7FfQ5LbA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=N1PgmGGvfkYOffBoN7wux7Xnn0loquFhm+SrEXLZYkweOnLSewvBoFLm6iJFPFvxHuS
 GHVoSjPG9VxvWVO3HqzZUb+b5GxzJIQKqRVQz0hOD9/fiJw8KeqFs8I2tnGrsFYLkIljz
 OtKBbYgxB5YVT6KKlJUkRoZmaU8U/1ZNbE8=

--UxYnkjL4hvd2sj9vsl2O
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjIsIDIw
MjEgNjoxMiBBTQ0KPiBUbzogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJq
QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0K
PiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVs
QGRlbnguZGU+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNS4xMC55LWNpcCAwMC8xNl0gUmVuZXNhcyBSWi9HMiBzeW5jIHBhdGNo
ZXMgZnJvbSA0LjE5LWNpcCB0byA1LjEwLWNpcA0KPiANCj4gSGkhDQo+IA0KPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIHN5bmMncyBwYXRjaGVzIGZyb20gNC4xOS1jaXAgdG8gNS4xMC1jaXAuDQo+ID4N
Cj4gPiBBbGwgdGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGNoZXJyeS1waWNrZWQgZnJvbSB1cHN0cmVh
bS4NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuIEknbGwgYXBwbHkgaXQgaWYgdGhlcmUgYXJlIG5v
IG90aGVyIGNvbW1lbnRzLg0KDQpMb29rcyBnb29kIHRvIG1lLCB0b28uIEkgYXBwbGllZCB0byBh
bmQgcHVzaGVkLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--UxYnkjL4hvd2sj9vsl2O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6570): https://lists.cip-project.org/g/cip-dev/message=
/6570
Mute This Topic: https://lists.cip-project.org/mt/83693866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UxYnkjL4hvd2sj9vsl2O--
