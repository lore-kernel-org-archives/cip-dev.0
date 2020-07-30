Return-Path: <SRS0=Dfgb=BJ=lists.cip-project.org=bounce+64572+5067+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18059C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:16:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615A120656
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IOPFye6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615A120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5067+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SmyWYY4521723xK0QD0z6Isd; Thu, 30 Jul 2020 02:16:43 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.4576.1596100600391981126
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:16:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 06U9GFqi017641; Thu, 30 Jul 2020 18:16:16 +0900
X-Iguazu-Qid: 34trcFcTUnrvD293bF
X-Iguazu-QSIG: v=2; s=0; t=1596100569; q=34trcFcTUnrvD293bF; m=480gMOBo2acrIZSHQSiznujhkDRkqmalYCOj8hZC1UM=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 06U9G73W012253;
	Thu, 30 Jul 2020 18:16:08 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06U9G7vO012465;
	Thu, 30 Jul 2020 18:16:07 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06U9G61P011921;
	Thu, 30 Jul 2020 18:16:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE5XTwlhtF6/8ueV+qYdTKxNmVgolS0U9WWuL+nR7Wd69NTopXPNl4YHXEdGKijl9rKxKRoKWQaMtpLoLJF+EH9VnNP/sInstweGEwPoPDtdr99wGWGa1zNGudwNY+DovEL5qSgSVHCagLG2sYGzgXGXkO1WhB2OW90WVRQMRe9WgK0vIrUIDD0oiSLXq2ctfo2o/EdzqsLdnZjRDs/vv9HSp54x+hM/soMmTvW6mqbMjO5RyOKP2H2MOUDKlTWwCDpydX9Q2HR60+Fjy50GK04giwu8ek19xpOybN/+NmKoraKlnIjR9rS/Ev/obpy7F+8r6UdvjGq/xeB7kvqtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPY0n6VEGorr0U3M2mIvS/jQZRuPzEZ/rb7+CL9nb2U=;
 b=E7yD/N7XRRJdzixXUzx7umwh2rV89HdsX0jy7Tq0WnS04iBSjyCkthwIZJT8lKeiOWofsIGKs6Vp8AUkpBFzVXn30Kt8f2JIBP6jAmE6FpmI7QUj4S0VpsoSuPtUPtln1PGINXV0eY+m9dghEAD8Wuf1r3Mv6bbQvTFD3VlJoCoCdAo0VRE9HAjgGXw9j7+3ZPXv45qOyU/EnNtbkdZBKq389N/0+QygF9wsj8ysRUwNtOd1O35MevrFyc7C/LTs1He5pOH8jTnBeVotjMRfLU/KVApGwtvLYACEYYZy0CGgqqJMU2pn0D7wTKPNFFqsooxb0fakVF0XvWBinZPRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>, <masashi.kudo@cybertrust.co.jp>,
        <pavel@denx.de>, <ben.hutchings@codethink.co.uk>, <SZ.Lin@moxa.com>,
        <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP Patchwork
Thread-Topic: CIP Patchwork
Thread-Index: AdZg1ErSblGkeTY5RLCzs1AcoDxFYwFfNTKA
Date: Thu, 30 Jul 2020 09:16:04 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29830A4698C039B05CDB23DB92710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSAPR01MB238534DE1045DDA72E9C7548B7760@OSAPR01MB2385.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB238534DE1045DDA72E9C7548B7760@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ff52e5-2af9-4321-79ef-08d834692f83
x-ms-traffictypediagnostic: OSBPR01MB4038:
x-microsoft-antispam-prvs: <OSBPR01MB4038A06895CD699C8F6C065F92710@OSBPR01MB4038.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RY9zK/umX9wP9kQ++EzHcppwyQxDtTrV7OH1mPYoZ4HtOebyskCjzKT6iHHaCKgL8Fs6/1OzVmoIobjnmVH1MLHaj9M7mYvEXlGF41Qv6Sdl6C64tUFsX8r1KfQIpZKq7jDE6DzKfE6JMHqQINz0sD8rGgZ652z72VJt3WzXiW47bg0EIPQnNhi7hmWYF3TQ9pdwUsVfCB5LEaV5ZNURGIY7091VmUD7/TmtSJhBWCVtg3fRPBkXxuLug3mVi0j79bQYlUU7PlnTl9DoQ6xqtgasM6MY++gqeI0wj//DWsk6rFrYaMZTpLzFTC2fxfAvMvFXX1oLMuKo7E8CsK2gccAYd240TmdLbUJigl04BOHivXw4F7fwPuXAFU36TT7Yujs1Q1ddUY6/Vzaxl/+4Ug==
x-ms-exchange-antispam-messagedata: /E+2CEFNaLuvOAuu5/otTOrwmcoxr5q3sDSp6Ynbv9U8Y1FZpluwQ781N3AJRIpMlMNu2rQ2wtRx31/nK+DAZ1TS2xXq5C83VlI4HoFIO7pRcIUu1JbCZq926zoJmAfSKIafTgl/7k8B66ktoj0Qrzfv4RGXsJ2HDDxy06hDvHc00MIFUxQ6ExrfRP1dYXZKdzLRYy6BaYuFkZgtaM3b2KYOK05Vi6GCN9wo9AyvJMF9vzj87seijEocg82DBQw7VMK/Ud6GLpqL/SnBBOr68lfQ0T9LEwFFZmdsbHXbotxjRSJjxozSyKOEbvQgvJZ8JJ+qslFD6mix8DxRCNQ8qHK7PqmbSD34guM0cqEs+vYXtAkwMghgPqtBSy28CRxdCEG1HXrBBgq6pnqdEb9NFnZHvSt4k8EsVBMrSBIaqWkZ8wBe1IgnrqtU0CC4SQf0QHiwOKDM46ld6El2PSzjmWvWFWQ/dbR5IP84ou1xNU3jWajWVv1xEQgjXSMA7NF3NUcSykPytNJwE2T60GLepoJFJki3YUgkXgViFC1yAFse+GI+jO4zbozPhZ7k6m+6J+pTxtKpiCDnScM745O/Of+f8VUQFubwhDr+zNPFJU36m6bygmop2q9kLMOqSkCrXNHPUUvOhnzgOT+04q0gDQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ff52e5-2af9-4321-79ef-08d834692f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 09:16:04.5871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tK8Ze6pZQEcunXD00XWUWzX7svdWMRgUfku+Y+MEYprg4SAkY4dTewAqg5GHzYdmihzKosCI0F3oAodhiDVrV3Hh49cPQYcs215cz0PP2mUL/iqUkaNlMPvPZUG7QW5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4038
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: crZY2EI4GAghUlVBPEIHH56Qx4520388AA=
Content-Type: multipart/mixed; boundary="wfqh43CaQhy56pO4ZwOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596100603;
 bh=qLwrPHrQ6BrNsBCH05jXI5E/eOHPEfxyv9BuN7mH4Ek=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=IOPFye6+SOOX7az4arWIuTcEgb7sh2qDEKv6lJOYSBT0W6O3PIz8WGGXj41A69mDixG
 tjBIweu6MJLseW4KJPGqb5LDZYFQ+lqradGFPQvxQNEd3hcOo3vYg37CWiGOmWsHoNwgv
 /kpsmynIrGr4rG8yRGv1o6gy5B8gcKn6FGM=

--wfqh43CaQhy56pO4ZwOL
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgUGF0ZXJz
b24gW21haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb21dDQo+IFNlbnQ6IFRodXJzZGF5
LCBKdWx5IDIzLCAyMDIwIDY6MzcgUE0NCj4gVG86IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNv
LmpwOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8
o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgcGF2ZWxAZGVueC5k
ZTsgYmVuLmh1dGNoaW5nc0Bjb2RldGhpbmsuY28udWs7IFNaLkxpbkBtb3hhLmNvbTsgd2Vuc0Bj
c2llLm9yZw0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDog
Q0lQIFBhdGNod29yaw0KPiANCj4gSGVsbG8gYWxsLA0KPiANCj4gQ0lQIGhhcyBhIFBhdGNod29y
ayBpbnN0YW5jZSBbMF0gdGhhdCBtb25pdG9ycyB0aGUgY2lwLWRldiBtYWlubGluZSBsaXN0IGZv
ciBwYXRjaGVzLg0KPiANCj4gSXQgZG9lc24ndCBsb29rIGxpa2UgaXQncyBwYXJ0aWN1bGFybHkg
bWFpbnRhaW5lZCwgd2l0aCBtb3N0IHBhdGNoZXMgaW4gdGhlICJuZXciIHN0YXRlLg0KPiBBcyBh
IHByb2plY3QsIGRvIHdlIHdhbnQgdG8gc3RhcnQgbWFpbnRhaW5pbmcgUGF0Y2h3b3JrPyBTaG91
bGQgd2Uga2lsbCBpdCBvZmY/IE9yIGp1c3Qgc3RpY2sgd2l0aCB0aGUgc3RhdHVzLXF1bz8NCj4g
DQo+IFdlIGJyaWVmbHkgZGlzY3Vzc2VkIHRoaXMgaW4gdGhlIElSQyBtZWV0aW5nIHRvZGF5LCBi
dXQgSSB0aG91Z2h0IHdlIHNob3VsZCBjaGVjayB3aXRoIGEgd2lkZXIgYXVkaWVuY2UgYmVmb3Jl
IG1ha2luZw0KPiBhIGRlY2lzaW9uLg0KDQpOb3QgYWxsLCBJIHNvbWV0aW1lIGNoZWNrZWQgYW5k
IHVwZGF0ZWQgdGhpcy4NClRoZXJlIGFyZSBtb3JlIG5vbi1rZXJuZWwgcGF0Y2hlcywgc28gSSBy
ZS1jaGVjayB0aGlzLg0KQW5kIEkgdXNlIHRoaXMgZm9yIHBhdGNoIHRyYWNraW5nIGFuZCBwYXRj
aCBhcHBsaW5nLg0KDQoNCj4gDQo+IFNvLCBhbnkgdGhvdWdodHM/DQo+IA0KPiBbMF0gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2NpcC1kZXYvbGlzdC8NCj4gDQo+IEtpbmQg
cmVnYXJkcywgQ2hyaXMNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--wfqh43CaQhy56pO4ZwOL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5067): https://lists.cip-project.org/g/cip-dev/message=
/5067
Mute This Topic: https://lists.cip-project.org/mt/75742669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wfqh43CaQhy56pO4ZwOL--
