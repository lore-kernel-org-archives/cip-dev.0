Return-Path: <SRS0=UxhZ=CG=lists.cip-project.org=bounce+64572+5288+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84669C433E6
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 07:11:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E446B2078A
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OdnC6UkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E446B2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5288+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6276YY4521723xQjKtbMKgie; Fri, 28 Aug 2020 00:11:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.37914.1598598693026363100
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 00:11:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07S7BTYm021406; Fri, 28 Aug 2020 16:11:29 +0900
X-Iguazu-Qid: 2wGr7dZaS7yF49nmb2
X-Iguazu-QSIG: v=2; s=0; t=1598598689; q=2wGr7dZaS7yF49nmb2; m=T9ZAV9g/SW7HllafzkwtIooBrAj3/iK+EjXxzEnwwCo=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 07S7BRiY005379;
	Fri, 28 Aug 2020 16:11:28 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07S7BRWX021539;
	Fri, 28 Aug 2020 16:11:27 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07S7BQ2E017175;
	Fri, 28 Aug 2020 16:11:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjkzrXwsinPzj496gzBW4BLadrzkDnpg/h8UQ8RT1AUSJgjXwDTl30hV4hP81rBVfuS3MDkuHmAPfdX2dpUmFuDbIFtnr+c3aC59j3q28OoP2K7hZS3Ig78wnE6i7xLFmhfhGqBJfYOSUaS/hZmo9LdBLGqDWgvthXC2NOlSICAKTu/D5Nz/2IvcfSpvTNkg4+zAt+kysOnD8f6gT8Sm4Kn8Put7Us2n7OssIh/GRHjI8HTpQwP30SxhYIL4bUp4IWPWlk9xU5t0lhrMf6JOAuN6mmH218tLOU4PMpXT+Y9gcmQPW3PDh8Dpa4+Iz85v93Ts5g+yBTJ/WKEBikSVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lezeEb5ADcyRgp3my9xKhUc6jyfWYYEvMYWj5d4Zc2o=;
 b=mpWsb38zcQg4r9sOt23Dad98uxmJrWxoAmJ2qI9Oz8ybqRj+VV7DDRq533M2L/7gRDk9Ne/qFe5SEUW/oz7uAQHiFdKpZvhiePePFEYvVPYY6jh+pslULq0jeG0LD/iJAoX+mX6nFlZeKOJWh5nQKcyWatUDo4Wf6s/AIKtBU2BZXOHaZtM1hlOy7jlPcWpdafaEcUPvnasjYz9av20suxR+yxJ+6DUshKk+PMZcZp2gTWpIb21S7Py6R0d/z6R3lJ9gcBUuUaLuaCbLy/tVznS0PwAG7cfp3JAfngpzr2YOt0Rv75x7DVYlRS4qMpocbAfDIjXlI2ejVvfizEyBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <iwamatsu@nigauri.org>,
        <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] Everything failed in gitlab
Thread-Topic: [cip-dev] Everything failed in gitlab
Thread-Index: AQHWe3oYMRW6Nuf1qEKKdbQw/+P4O6lLhNuwgAAN3YCAAAx3AIAAULeAgACOjICAAHZLAIAAKIGQ
Date: Fri, 28 Aug 2020 07:11:24 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29838DB1D31267F8BBC0A91392520@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
 <20200827131025.GA28744@duo.ucw.cz>
 <CABMQnVLyjmJSEBce_oJSgSTGU5muMEyy3iwhikjuAS=DT3o3Hw@mail.gmail.com>
 <5e5a71ba-fbb0-99b0-126a-b11d51608309@siemens.com>
In-Reply-To: <5e5a71ba-fbb0-99b0-126a-b11d51608309@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 647ec66c-9f14-41b3-b777-08d84b219334
x-ms-traffictypediagnostic: OSYPR01MB5320:
x-microsoft-antispam-prvs: <OSYPR01MB53202E2C439680142CF06DB292520@OSYPR01MB5320.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a1imKNS/MZUMb5EGm/jqEW4uoBNOhXQy/XH4qf2fFLPBroXsY2pvfV7FFuUGY9D1JqJvZiwdSfmN+BgFWkUrhoYTESuVH+1sLjcMHpd84uglw5FrR0Doqx04qTJFqHnS2c3EHcIAeaQs/4ywNpANWOFQjlt2386Vh5nWngn5RRvN9kMdFmMi2rIOom/JaAx5Zj+485PZh7n9a2mF7BsyG5KqAHMToAHww/odEvweYcANJNi29fHV3PnfMBeAyrm6MsuvEA/3N0moxzJZ43Vjlq3NzV5Lu22tJfJVVLtlUyJWRvZCWN2oMd8w6y78NUxMsAqzHfP8k7vLTUSUQZcSnYcLZ/451wmiEJPDPBNXlDLjUXwDR9Z4aiUIGZWZHYCgFlc7gfjkyrg6pP937iPxZg==
x-ms-exchange-antispam-messagedata: mZQBLV2q+QcNIzsT0fgENjbDrNCsHR4jhXZt7b3sCv39gP4AYuIxo+BkjdEXxjjcpR9oyP8kq81TtvL+I61pI9M7txmXFQT8XizChgn1lhnEBFyqvKjAAf1VN+HpomxoAu0EqOp4slmZdhMpb5bVZaD9LKIEiMw6httDKTwGhwlDf1Fz7zIemFQvLnSIIiWf1LcQPeNOayPRf3M/4pzFdjQ52qUAvG6+ePHhOFFDWZihtQ3RhmdOsBzB0WqYTYwAywZ9I3ELgyNrsER7cKg0C6nSymRBjLrx1Iso9hJiZGkEooD5AgQjCstAFkFJ8dYzXAQrApEHGi2YbAB8rpd1GHUSDyFpln40xynq8WQk0VEul8az+mxpcFP5GAfpkIS5okB5Z9XhYkYfv4g44X1kDYlhbDRntdSW0jLiW6OcJHkOnb0ZXptPmV/3Qv2hEH9C9T/fkzbYcLYcJ+EFBpch4TAD5rRabvvo4ecuz6L9iygIGrlQgkKUMl8siGKDbRTWBjvkCK+Zi2BiJkc+58mJn8Z0QmI7TSyjbWdqYiGbo/h4k+8uOsWVLAxI2SYIOQ0fWP4MyXUOfqZB4cl2xzycTU8ptnwaHSGioUB5G1zRHPeuwkdLIkaxvvNNWG1iEJvqUVQvNgdtqYci6UthLn5WCQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647ec66c-9f14-41b3-b777-08d84b219334
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:11:24.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tLgwUxwyTyF/t7iKXiGy/uh5+COClIXqOtosqGUsMPWPFxXzmrpEFfIE1NuiPltxMkUh//GQqbeK3NpSjD5ukVYlkeSeWw8FGxOzKLZ6kcSlNICD79hZ64siViVIfyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5320
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zUwxbU5ameM7T8DDrqetB6kNx4520388AA=
Content-Type: multipart/mixed; boundary="mIMGbASOeEar4dHtvklp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598598695;
 bh=pqvrJ++hSypDSCoaGqgqxQdlPyRMJ5N69LBe23c6lEM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OdnC6UkBMMIUU3ZA9T+TqW0yWtAA7bE1FiLaJ9sVdZv3GNmPgdg8ndCcP+2MT+dnPG4
 7/yIevCA6k/OGmTf5RWi8Q8MRMnatGmQCQWR2ztDwCn6LHvnkFxsJ3P3hteBfWKcmxBkC
 Uhzrx3FavCpq1Y9lJzO73ZUohizvM5ys/Tc=

--mIMGbASOeEar4dHtvklp
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgW21haWx0bzpqYW4ua2lzemthQHNpZW1lbnMuY29tXQ0KPiBTZW50OiBGcmlkYXksIEF1Z3Vz
dCAyOCwgMjAyMCAxOjQ0IFBNDQo+IFRvOiBOb2J1aGlybyBJd2FtYXRzdSA8aXdhbWF0c3VAbmln
YXVyaS5vcmc+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogaXdhbWF0c3Ug
bm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IENocmlzIFBhdGVyc29uDQo+IDxDaHJpcy5QYXRl
cnNvbjJAcmVuZXNhcy5jb20+OyBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNp
ZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIEV2ZXJ5dGhpbmcgZmFpbGVkIGlu
IGdpdGxhYg0KPiANCj4gT24gMjcuMDguMjAgMjM6NDAsIE5vYnVoaXJvIEl3YW1hdHN1IHdyb3Rl
Og0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IFRoaXMgaXMgaGFwcGVuaW5nIG5vdCBvbmx5IGluIGNp
cC10ZXN0aW5nIChrZXJuZWwgdGVzdCkgYnV0IGFsc28gaW4NCj4gPiBjaXAtY29yZVswXVsxXS4N
Cj4gPiBJIGRvbid0IG1hbmFnZSB0aGVzZSBydW5uZXJzLiBIYXMgYW55b25lIGNoYW5nZWQgcGVy
bWlzc2lvbnMgZXRjPw0KPiANCj4gSSBkby4gSnVzdCByZXN0YXJ0ZWQgYSBidWlsZA0KPiAoaHR0
cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2Jz
LzcwNzk5MTczOCksIGFuZA0KPiBpdCBpcyBhcHBhcmVudGx5IHdvcmtpbmcuDQo+IA0KPiBJcyB0
aGVyZSBpbiBpc3N1ZSB3aXRoIHdobyBpcyB0cmlnZ2VyaW5nIHRoZSBidWlsZCBhbmQgd2hhdCBw
ZXJtaXNzaW9uDQo+IHRoYXQgcGVyc29uIGhhcz8gSnVzdCByZXN0YXJ0ZWQgWzBdLCBhbmQgdGhh
dCBhbHNvIHdvcmtzOg0KPiANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1j
b3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzcwNzk5MjkxNw0KDQpHaXRsYWIgcnVubmVyIGlzIG5v
dyB3b3JraW5nIG9uIGFsbCByZXBvc2l0b3JpZXMuDQpUaGFua3MhDQoNCj4gDQo+IEphbg0KPiAN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

--mIMGbASOeEar4dHtvklp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5288): https://lists.cip-project.org/g/cip-dev/message=
/5288
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mIMGbASOeEar4dHtvklp--
