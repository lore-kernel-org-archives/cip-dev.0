Return-Path: <SRS0=C+e5=BA=lists.cip-project.org=bounce+64572+4942+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82EC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 00:43:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5AF21702
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 00:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wGsvGgKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AF21702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4942+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rSsHYY4521723x5qXZ2FwJTU; Mon, 20 Jul 2020 17:43:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.9499.1595292230803867583
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2020 17:43:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 06L0hdkt007332; Tue, 21 Jul 2020 09:43:39 +0900
X-Iguazu-Qid: 2wHHsainS7wAop2qWN
X-Iguazu-QSIG: v=2; s=0; t=1595292218; q=2wHHsainS7wAop2qWN; m=UyHqH93LgBJjHPo6vrJyQsXMVvPq8mR2KLpYFL5aKBI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 06L0hbG6026049;
	Tue, 21 Jul 2020 09:43:37 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06L0hbR6005170;
	Tue, 21 Jul 2020 09:43:37 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06L0ha8j003879;
	Tue, 21 Jul 2020 09:43:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA0I+YcpLhjztUA+otmfRayrea4q5Illq1LEu96YR/bQIvDM0kAN1mdp+YomJt0HjdXIRrMxjROCKkkb4YcrRgv0xgLZsQAsP/YKCDDj94w/lJATlAiWcDzH2lI9aT2sZ41OxJn+NV5eHWn8AcvtjzbAk3OSC10ZJlcf3OWVhxmtC7KUbcgvD9Av8bSNOAe38QDuIV9m1tuZVg7MjklOWNQ4o5qU6FYV1PPBD4roW/4aX1GKLOE6utl9KwUD9VbeQO43IzKJvzG7c1RPqNQSxPQT2Zkq+UZmDR++NAb/UTLV/n9WDJ/WPGsEtf1YXUl9CpnVMzfUaG6MDFT2s1SC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HcXq8sX3UgXsfjEtN0ya7Ef5jzMh035zsVYZ3kYImI=;
 b=nD5UgwP4HyK5RiascoLqMwCaJfJVTOFqSgMixFKAIaIvdQ2Ao4lNoLjSvcogLCjEKlzGcQyvTK/SyIOLd+73KCpKMlmSu6aYNg98adQxWlkgkhnxERXx2OHDCDaJBmCCkVnsewDw6zm1VjM7U00lGPQv5Osmht/DOjp41BCTGLLKHKm02NOKtq4Ntm1ILYUAGa/FwDQbjvbQ8FycmE7ynZ7G6QH0iO1oHMTl35dP8dpNBYaGf9jogQ95wcle07xY/3dWYarQ5SBIy4nL+odNtWHYIHFp/OlNJwZWgOL+SJBAgIjwJ2JjEtQRWkWA7OLhWMK4Z+uJeTseURDeRg4qYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Thread-Topic: [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional
 support for Renesas platforms
Thread-Index: AQHWXr8VyzapM68aLk607aumQRRooakQ9AEAgAA8utA=
Date: Tue, 21 Jul 2020 00:43:27 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983171CA949DF2DA8967BED92780@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
 <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
 <20200720210008.GB9879@amd>
In-Reply-To: <20200720210008.GB9879@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90fca981-e541-42d5-78d2-08d82d0f1537
x-ms-traffictypediagnostic: OSBPR01MB2981:
x-microsoft-antispam-prvs: <OSBPR01MB2981F2B4DBD1C79E04C749E392780@OSBPR01MB2981.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:317;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LJenZ54ZOnffSJLrNYZnrHllJw1vKd/wA0OR8eC/3fHSRe+xRdqQKzkQGeGmU8HJBIaeaRQx99CT/8CHX8yg27EV0ZcbyAVVcF0zDo+YxascXYk5jRKVdQYu2QXUEMuNrsz9cOLecqPK6JHaKH+3zJDmcZsezSG5ZoRvmA6P9bw4GChjNstc+C652kR1YVVXE7Dc4nQgSWVye8ANg58qmVzqOoSv5PA8efi2Se/fptrn+r2ls0MirMD1hvFuKiNG66DOGtq85ahiZ5PfBtkmCOIufXBnvdoxpD68MxoUi5MoxSnON4BkFxPyk00U1Vwikcp0OVAMdgceC5utyIa02w==
x-ms-exchange-antispam-messagedata: bGb2sY9LsAzIP6EIeNeqKcvUxqdcaTy8S9TmmnGo3UMx0fN0miim9mKh9P0zG3og5zLV8UZL5epuXTFXkClLDj2F3NEhVg+MBarZOayAOpbU0eTi2yeVBr73ZYJ3V+X0lHDNmn8EoJpo0cb2QWlNrXE1odOc6NIkKg2YuPtI+CGi8F+2fHbrpAb5/N/VXcmzctPAlb7yfFQ692dyd9V6E3toiUYBP31sOdehtaFVSdr/njEXmYh4DuupWzM9KkY45SqfxLt78l6N+zLQGWSqKC86/NHp4ACbeR3706sJM3qo7GfSzCETQRNbkmFpIgq0pRKrQ52THURItfPrmJUGc4Ti87jjmv3IvXCPFbagE5soWHCHbrbAydBWhCbdvYj+ZQ/SfeF/dSKSyNU24sN3CRIOW6LrzywRGiaeBcseb22qEYcxLj4s2Z/b4rnjDMDIQoUgUK4KkFPfR8O2G6EufTnc0sa+Ep7qWiE3vGneZ+8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fca981-e541-42d5-78d2-08d82d0f1537
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 00:43:27.5891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bnfUHd412x45vrTio/xZ66QVyK1uAGtUWdUsk1rJm9oJxbKwu6+MZFvaijfw23pwujuJWXZgqQvl2nHLAmsMP+xoe3wXJXI2MZLfvbbtamsxKXBl2kaDOauAmHNq+40
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2981
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QbbhZegVOiMkfJIiq2tPWuUOx4520388AA=
Content-Type: multipart/mixed; boundary="dIdMH43SJwT1YW550Rsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595292233;
 bh=hOhwkX8KZptg7nRwKcpM8s4RzWGDTt7/v7a5omjqK20=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wGsvGgKUmENq5GNHFk7gViVx70KZL3sn8dVzdzmSD3ZLL/smjDjy61jxAzc0bKLDKs8
 43bh+zF1OJ1REFnGmk0DWWaakYmjB+MGZw+Jj9feIpfXdzpJT/LkTPPpMLXc31TAmfvzE
 HeM3+YEa2ZmRCffu/zhLSyZsZHTsyrYQckY=

--dIdMH43SJwT1YW550Rsv
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIGFsbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjEsIDIw
MjAgNjowMCBBTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWy
qeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1h
dHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBDaHJpcyBQ
YXRlcnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPjsNCj4gUHJhYmhha2FyIE1haGFk
ZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNpcCAyLzJdIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBh
ZGRpdGlvbmFsIHN1cHBvcnQgZm9yIFJlbmVzYXMgcGxhdGZvcm1zDQo+IA0KPiBPbiBNb24gMjAy
MC0wNy0yMCAxODo1MjoyMywgQmlqdSBEYXMgd3JvdGU6DQo+ID4gRnJvbTogR2VlcnQgVXl0dGVy
aG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPg0KPiA+IGNvbW1pdCBiZjllMzMz
ZWMwZDU0Zjc0MjhkOTE5MmFkNDAzYzNjYjUyMzU4NGM3IHVwc3RyZWFtDQo+ID4NCj4gPiBJbmNy
ZWFzZSBidWlsZCBhbmQgdGVzdCBjb3ZlcmFnZSBieSBlbmFibGluZyBzdXBwb3J0IGZvciBtb3Jl
IGhhcmR3YXJlDQo+ID4gcHJlc2VudCBvbiBSZW5lc2FzIFNvQ3MgYW5kIGJvYXJkczoNCj4gPiAg
IC0gUi1DYXIgQ0FOIGFuZCBDQU4tRkQgY29udHJvbGxlcnMsDQo+IA0KPiBPaywgSSBjYW4gYXBw
bHkgdGhpcyBpZiB0aGVyZSBhcmUgbm8gY29tbWVudHMuDQoNCkJvdGggcGF0Y2hlcyBzZWVtIHRv
IGJlIG9rYXkgdG8gbWUuDQpJIHdpbGwgcHVzaCB0byByZXBvc2l0b3J5IGlmIHRoZXJlIGlzIG5v
IHByb2JsZW0gaW4gb3VyIHRlc3QuDQoNCj4gDQo+IFNob3VsZCB3ZSBoYXZlIHNvbWUgdXBkYXRl
cyBmb3IgY2lwLWtlcm5lbC1jb25maWc/DQo+IA0KDQorMS4NCkl0IHNob3VsZCBiZSB1cGRhdGVk
IGFzIHdlbGwuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

--dIdMH43SJwT1YW550Rsv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4942): https://lists.cip-project.org/g/cip-dev/message=
/4942
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dIdMH43SJwT1YW550Rsv--
