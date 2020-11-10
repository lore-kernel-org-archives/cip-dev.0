Return-Path: <SRS0=UYlS=EQ=lists.cip-project.org=bounce+64572+5787+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C0C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:17:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3304920665
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Rr9XohSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3304920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5787+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rXQzYY4521723xVvbRFZIi7U; Tue, 10 Nov 2020 04:17:19 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.26789.1605010637076336888
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2020 04:17:18 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0AACH73k010237; Tue, 10 Nov 2020 21:17:07 +0900
X-Iguazu-Qid: 34trXZNYeItPp1nk5g
X-Iguazu-QSIG: v=2; s=0; t=1605010627; q=34trXZNYeItPp1nk5g; m=T7pK3Qaw4EUcUPvxqGwUfyNT1K7SYaF3MuagtVsU54k=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 0AACH6Tu011228;
	Tue, 10 Nov 2020 21:17:06 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0AACH6md002709;
	Tue, 10 Nov 2020 21:17:06 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0AACH5jq008992;
	Tue, 10 Nov 2020 21:17:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq4EysgoxoTwJPKeDAV2tYxUCtZ+V5Rf54SDJjqII6Bwg5wrvLfWkBgqJhjcJkFys/nxxL/pY2SwVfJP2/hQypEzRetFndl1Puhus7dEdxbuaP8YI3zWbIvWEXfNmlwHadXtfy2PqeHSXbMUZCiLj4jtMnZxnATHXoDoGrQmMcbuM53rRd3cTb9k6Gh0f87GL5mblhICdqnVs3957JBydx7v+d4zkWFJvXeRUNTzfajVuXNTbK1rmwH/QbWPM2Iyhw6FUxa5BNEOAbxV3HDMwpd2N8BQb+77j5yXWh/MkLti5HpYJktlI2X0tIfvB89yX4DTaTfZs61RfgOTsX0aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGGvtBOeQKlsI2NXd3jLweJl+Ld/VgY/eA0FnPNE1a4=;
 b=cG0g2N1/91Xf01w+844Q5dHVcFT80chSgK232nbC0E1SzUBdvjd9L9qrIPP1zOZicI6b+c53VjHmmvGx0bvr6hOEhG9NBLO3naLNP3I2wNoISQekOb3vQARNXGAr6Tl5qKDDdarPuOAOya1tNlJ3axRPjutWeMygpc1cOWFFjRgrEF+sVlnBRz92K/46pElgznoBZCcBNLmXuXQwzmjZfUw1RFucT0HZJs68x8j4EIm1TSkEeSeOqaUdKIwjG/2dLgd6IKsWUCKk7GbvuIyv+oPB1t3Re4zNfcfsm+ErIBF9G/wCv80gBPfaEPFsVMpfCYrg4+Epuw//Vgsvy1r61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN, IPMMU, QSPI, RTC
Thread-Topic: [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN,
 IPMMU, QSPI, RTC
Thread-Index: AQHWtrAIwObsHxvcdUqdstTA37mDuqnAxM/ggAA7QoCAAEkDgA==
Date: Tue, 10 Nov 2020 12:17:04 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298369540C0DAD8004C1D06A92E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983D2D88A4E9CE78F41627692E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201110075431.GA1029@amd>
In-Reply-To: <20201110075431.GA1029@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b4f56c1-004f-4970-14ef-08d885728919
x-ms-traffictypediagnostic: OS0PR01MB5666:
x-microsoft-antispam-prvs: <OS0PR01MB56668672063A9351D30CE9F592E90@OS0PR01MB5666.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VeCTK3u2Ol+iwPLGHf5rOkjr5EWgoJgPQOJdpPpUCjiSGvziX4Ief/+9/AYQeQiojNhfUl8GrALaPejg4Fh9Zumd+XckVgcU3ny7MkWKY0K0ZlvJOItMgxsB+gt1Z3TGRZeo6WFwcGWW5/9yVD7txf95S55I6D+CTXQPixlX7aamJANEQVCoYhGTNJ0gk1691JBFCKfeBRAGhGVuFyu53Lzkuli1v/PAvC+5o43a4HhrVyG8h0kxM7T8lfKbYQsXuIRLVfIJg0sJPG0xiHfiIDY8t/rLPR01lqxFqOTcbk+QBmbzo6VcUr8KvZVdu9mt
x-ms-exchange-antispam-messagedata: caryFYGXnB3NWufTUyL3qG994VPx/ODOrzA8HdHkL3kRwoMi+/P4wiUvVnFUJbSL8sBDw0NOKUtpt/nqWtV8up7tBoKCuRjiRRwtjjsGa0f5UTtzBamF95d/6p8gVIlAg/CU52UPu/aN16kwaJougKPok74ymjg8rDI9jngm6Mnn8ZX86WHrRWiD/wjC+5RKYbKSZ0qAb4etsb++cJOgC4vRDsmTvxEuUtEqkp22fcgRHlxxURTUopHhtnps4tq2UE1QQFKMdJZvIRC5GqknQgVRV+VnzGkQoOcT0xMP+GA9CdW71hX6Y1D13E+H2fIkSoU7QoEmxVpzXLZZXl7KWFDx+1Zi2Q3yvr1yaxNgcdzwSpwZu8aXBZnGmbJzAeWX1Sq/qHPnFXf9mjM/3ZII68O4rfgRdLhw2uX6vbPZKtfG0iKdNdpptLRh891eMzqVzAujcmB/RFVMXzukH3M53usWLk9FfU1VCoMuRuJqjCMVaGFQfjBOs66RhFSSNk2vuwlrO/Iyj3W+6wO1wvFg3+dNOTpe71OedglIrNRYCOHZRn/S2QK+ZHjnozuu4hbSCsRMHgHMTU7IcL5Zo1XIMtZp+9mO8PRn3lN2j2j8NwZx1v60uYi256HD4TPaMv/pqxAfTqVEveqyYJOxq74ormywZJmuJHPndoQOsx7eSFXxZCiOElO7nGLE1rATxkINLfpWP0kEzJW8pfF670t0rPH3rpjBqrQXR2OAM5ji8Ipvdee46GgJYh9qtzjZ/rA1FcVFYmmFp+tSLJ3FHaS47+oLWxtoAQekUJ2wXV7TJW8k7VVgjiwTSBbxradgMztcAPbilE8tlQSnkKWRGkbvk0H53SrJ4uj/gAO4WNiefu7uiGwj7/VM6MJgOE10uLQoGftqBdP8d2pX1w0EZAXHkw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4f56c1-004f-4970-14ef-08d885728919
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 12:17:04.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8kIwQDzlcnHIlqZJRrRHY2OmZQooFXLpd12wu2xiMts06fZ4P2wRjAytfR/iQkkwjDetW0q1pfgi2T/OLYL22BrqeYq2zcBc0spymXBjEoN9kqfXM8biM76833BjbnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5666
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5ZQGHmnY5oTWaPCnhnM3claXx4520388AA=
Content-Type: multipart/mixed; boundary="vxUaziIkDkCSBHQ8KMgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605010639;
 bh=tRO1ykPJmmjQmC47C3Es2UZ3n9bDN1DVcaZVHYZLbI0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Rr9XohSa0GLOwCu+BQEwiTobIc06Ngezha5/skEq6BcY6pFOQCnKGBpZcAr26ZSwSkU
 aPHP9wY8MJVsN5CZmpwm4j7Mbuclh3NHRtvJfhvs+ke3NkMzEicS/24PgpJmbxTI/wyCk
 UDh063uqN4V7fucvbIz87YwtZfKDELDcVy4=

--vxUaziIkDkCSBHQ8KMgY
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEw
LCAyMDIwIDQ6NTUgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
DQo+IENjOiBwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb207IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBkZW54LmRlOw0KPiBiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQuNC55LWNpcCAwMC8xNF0gUmVuZXNh
cyBSWi9HMUggYWRkIHN1cHBvcnQgZm9yIENBTiwgSVBNTVUsIFFTUEksIFJUQw0KPiANCj4gSGkh
DQo+IA0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmNhcl9jYW4udHh0
ICB8ICAgMyArLQ0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcnNwaS50
eHQgICAgICB8ICAgMSArDQo+ID4gPiAgLi4uL2Jvb3QvZHRzL3I4YTc3NDItaXdnMjFkLXE3LWRi
Y20tY2EuZHRzICAgIHwgIDExICsrDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi1p
d2cyMWQtcTcuZHRzICAgICAgIHwgIDUyICsrKysrKysrDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9k
dHMvcjhhNzc0Mi1pd2cyMW0uZHRzaSAgICAgICAgIHwgIDc5ICsrKysrKysrKysrLQ0KPiA+ID4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDIuZHRzaSAgICAgICAgICAgICAgICB8ICA5MCArKysr
KysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvcGluY3RybC9zaC1wZmMvcGZjLXI4YTc3OTAuYyAg
ICAgICAgICB8IDExMiArKysrKysrKysrKysrKysrKy0NCj4gPiA+ICBkcml2ZXJzL3NwaS9zcGkt
c2gtbXNpb2YuYyAgICAgICAgICAgICAgICAgICAgfCAgOTIgKysrKysrKysrKystLS0NCj4gPiA+
ICA4IGZpbGVzIGNoYW5nZWQsIDQxOCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IEkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXMsIHRoZXJlIGlzIG5vdCBpc3N1ZS4N
Cj4gPiBJIGNhbiBhcHBseSBhbmQgcHVzaCBpZiB0aGVyZSBpcyBubyBvYmplY3Rpb24uDQo+IA0K
PiBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbXMgZWl0aGVyLCBzbyBubyBvYmplY3Rpb25zIGZyb20g
bWUuDQo+IA0KDQpPSywgSSB3aWxsIHB1c2ggdGhpcyBzZXJpZXMuDQoNCj4gQmVzdCByZWdhcmRz
LA0KPiAJCQkJCQkJCVBhdmVsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

--vxUaziIkDkCSBHQ8KMgY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5787): https://lists.cip-project.org/g/cip-dev/message=
/5787
Mute This Topic: https://lists.cip-project.org/mt/78138424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vxUaziIkDkCSBHQ8KMgY--
