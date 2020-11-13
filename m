Return-Path: <SRS0=GPWN=ET=lists.cip-project.org=bounce+64572+5797+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80EFC2D0E4
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 00:50:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30120B80
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 00:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iLN2Mwxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF30120B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5797+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id inmzYY4521723xAzmHpfuQKu; Thu, 12 Nov 2020 16:50:10 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.117])
 by mx.groups.io with SMTP id smtpd.web08.14169.1605228609529983688
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2020 16:50:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFVUpEAs2PB1JxM2zufgGOyG0whws6dioqsIVTz6si7ei6+wltSu31KL3S0YQnjnxlrYp1t3KZgdV4eGyzR1HzsY/e6/9Nrd9JN5Es7TgdVPZJE7XpW3YQ+0Skk4W1FfF8GEwPbDpx/UiHY9V13vaYMcs9PrJ35Bt8Wnyo8rmzwe0fF5WwEktVLFWX6daSwH/nHmpZow0ARLNLb//jkMp2PaoIcncIhyVeZzyrApNiw/d5TUHlxzWLiBh56yLb8HRiJNOUQ7dGs3jePYCzbvTZXR8fi1kGuwyqD/6ipWJzlJo23efK+UVoWQM9OU5c4EF/IL4Z2ToTkQDYj0VmAoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE4Rp4MIfIQY1TztgWIejRWtYw3fXplJFBrZAdLB+fU=;
 b=M27PZbs+PyEPTqLVXCuF0k69larB+YmubK5MSpjqso8nnhVxJcF6GqLb957zHX0AkUbVDJsymQuOfcT8ak3zwr04yYJp7QjX/+RxJiB+/Ip1BFc8M+zN1WgkkS/2Ukn5s8cy/tTpguOO1RQFlSoG9nfmNtMuo5DmdQgP9xtOibGpuFWRUNaRpFvujgeZLHGR++hWAei+HGyRvdIdnJtt9r7DJP8J8FcS240qfifzyh0cLkRZKt5eZs+l0f4HKv2iISQ/StOlf3T0luPpwt8gGtMC8SB0ei5qd/ZDxiqJ+RviAbF/8r3NQcWK0lz2kLNW0wxrNkAuTcJHLsdl54BEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB5952.jpnprd01.prod.outlook.com (2603:1096:400:47::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 13 Nov
 2020 00:49:58 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 00:49:58 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Thread-Topic: [cip-dev] Backporting of security patches for Intel i40e drivers
 required?
Thread-Index: AdadV2Jnu1CNqzkrSoynC++LmpFHXAAeQTNQAA8zFIAGh1Kw0AAQbuMAADpfeiA=
Date: Fri, 13 Nov 2020 00:49:58 +0000
Message-ID: 
 <TY2PR01MB4972A81EAD1FCAFE28EE1566A0E60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
	 <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
	 <TY2PR01MB4972EDB29B2AB0B3AE5E363DA0E80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <9c52fda6f710d3aad6fd9f781b33c4034dee4d10.camel@codethink.co.uk>
In-Reply-To: <9c52fda6f710d3aad6fd9f781b33c4034dee4d10.camel@codethink.co.uk>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6adba664-daf9-431c-3502-08d8876e0b93
x-ms-traffictypediagnostic: TYCPR01MB5952:
x-microsoft-antispam-prvs: 
 <TYCPR01MB59525A0D6BC9136B003321ADA0E60@TYCPR01MB5952.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 q2TgFkfz4tg9bQe8Fixd1pcFDYb3JeL8ndDbMGfvXfad6Xqj5QaXYYCDyZp8JbVAlv7wRRBPZ2p+9veq9z8lOajKbZWBcZ4o2h7js+aKL2+6h8KHfY+oLl4nK4V0SxHKsUu2hlUYK04I7ktxSrAfLoLX/QhWKGKZTv551TVnDNa02Nsak8887KpDErf62qTIAcp2GIBzPlAp67eL7Y6b0qi5jVkozZLMFBafpFPirORXIccO/hFTSGDLQ27eNs3VJLFADALIRaVoLervDr9KkLvjhpY45+/E6cl6BiJXFSKOUjvulXc1Fm8VDrOSfTviZJYPa40bb3ZfVh0A5nfeQUYRp+qZII4QemggkbtzIn2RAdwwuMOJinjapJuoAN1XT51WBeApmvWOnCS6EkH3Jg==
x-ms-exchange-antispam-messagedata: 
 5/h0XnZSb7ltEt8WcurDRhX0nGKTfXwebAvkjBhjlvCxyOmQjun6L7ouIia9KliieCnvMALZ/HSZ/evEMBry7qsbRPSAh8QoeLmEjCxgg/2yf/lk+iaabYY/u7snj2gGpnvVSWyD1Qvk8CT//xiKkwHfuSNSQ/FL0+UDGnokb7D2oJSvvpHRJhCDCl1ZLHLx6dYh+QrfNek1S2uQwSRNVwS9SkC/lSCWKboROoffpb+9VszGyqoDZJDmRuu7kDoE1ezHRFIU1FAcZ3dQ0pIkAujlrg8frHju6WX5feGnzCaW4LBMryMR7/Gkq6fe7wYDNSHh3trT6ugSKU0Xshhq8e7BtoJ6NsFfxNDWOiN9qwW6lUwSswfgcjHcfsB+AMrVdw/KUZBcguqvwc9lP4XG5u/SxUfynMevN7yoFtzPgGILW1c2RowFJhRHDYup1JYBs3J9CCt5Navn8xJMgaaVgmBhnNb7LOxvdUvURqc9q3XoIjWfCYxOV1Wi+cRhgvYLp+JDalFGgP+10F9tHqLuZV7JIaGKgidsqL9tO9774CbM+1uXTUjwGyQDLLFS31VzP6nP4k9aS3PRHQj2a1kQWef4VwDqPDV1lQm1sfLJc4hdAnHNuBlWBXwtyTHkXTKWTVn+wjkDbPpJDJfaBC1Adg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adba664-daf9-431c-3502-08d8876e0b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 00:49:58.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rihiEHjPJIf09yfg9C/cRk4Nc3FZgz20aPr02R6YcFtgvtScE6dMXOVYfDJ96IxSIKJwBVVaJjTjwFcJ45JLK7V1jajIa8bKrimzMNCQ2es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5952
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OENClkZk2pSFWXG1XxHHTwpJx4520388AA=
Content-Type: multipart/mixed; boundary="o3UjhTqlgkbG3ayUMOIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605228610;
 bh=KZGab/QJQnntzPde5JWwoIQbMG8abjxJnsrFVdVKTsI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=iLN2Mwxi0ftH9s8bexVrOfSxnlwFUS8ARY6F0dzwgBwzcMy4QYsHM4AucNuiHUAdP9u
 2nkMHN463q0neKg49abiFy8PK2wDgLwdJ9dXHalckBKdIuhydUDTgCxi304UmSqvuwOK6
 0x3F+rHyKrSQuZFrt/0ux9stpzHvdKca1Mo=

--o3UjhTqlgkbG3ayUMOIK
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEJlbi1zYW4sDQoNCkJ5IHRoaXMgdGltZSwgeW91IG1heSBoYXZlIGFscmVhZHkgbGVmdCBm
cm9tIGNpcC1kZXYsIGJ1dCBJIHdhbnRlZCB0byB1cGRhdGUgb3VyIHN0YXR1cy4NCg0KV2UgYWdh
aW4gZGlzY3Vzc2VkIHRoaXMsIGFuZCBJd2FtYXRzdS1zYW4ga2luZGx5IHRvb2sgb3ZlciB0aGlz
IGFuZCBjcmVhdGVkIHBhdGNoZXMuDQpJbiBvcmRlciB0byBtYWtlIHN1cmUgdGhhdCB0aG9zZSBw
YXRjaGVzIGFwcHJvcHJpYXRlbHkgYWRkcmVzcyB0aGUgaXNzdWUsIGhlIGlzIHNlbmRpbmcNClJG
QyB0byB0aGUgSW50ZWwgY29udHJpYnV0b3JzLg0KDQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgY29t
bWVudHMuDQoNCkFsc28sIEkgd2FudGVkIHRvIHJlLWl0ZXJhdGUgbXkgdGhhbmtmdWxuZXNzIHRv
IHlvdSBmb3Igd2hhdCB5b3UgaGF2ZSBkb25lIGZvciBDSVAuDQpJIGFtIHJlYWxseSBob3Bpbmcg
eW91ciBnb29kIGx1Y2sgaW4geW91ciBuZXcgdGFza3MuDQoNCkJlc3QgcmVnYXJkcywNCi0tDQpN
LiBLdWRvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBC
ZWhhbGYgT2YNCj4gQmVuIEh1dGNoaW5ncw0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTIs
IDIwMjAgNTo1MCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwOw0KPiBqYW4ua2lzemthQHNpZW1lbnMuY29tDQo+
IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gQmFja3BvcnRpbmcgb2Ygc2VjdXJpdHkgcGF0Y2hlcyBm
b3IgSW50ZWwgaTQwZSBkcml2ZXJzDQo+IHJlcXVpcmVkPw0KPiANCj4gT24gV2VkLCAyMDIwLTEx
LTExIGF0IDEzOjE4ICswMDAwLCBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcCB3cm90ZToN
Cj4gPiBIaSwNCj4gPg0KPiA+IFRoZSBvdGhlciBkYXksIEkgaW5xdWlyZWQgYWJvdXQgQ1ZFLTIw
MTktMDE0NSwgQ1ZFLTIwMTktMDE0NywgYW5kDQo+IENWRS0yMDE5LTAxNDggaW4gdGhlIGZvbGxv
d2luZyBlbWFpbC4NCj4gPg0KPiA+IFRoZSBrZXJuZWwgdGVhbSBkaXNjdXNzZWQgZm9yIHdlZWtz
IGhvdyB0byBkZWFsIHdpdGggdGhlbS4NCj4gPiBBcyBhIHJlc3VsdCBvZiB0aGVzZSBkaXNjdXNz
aW9ucywgd2UgY29uY2x1ZGVkIHRvIGlnbm9yZSB0aGVtIHVudGlsIEludGVsIGZpeGVzDQo+IGlz
c3VlcywgYmVjYXVzZToNCj4gPiAgLSBUaGUgZGVzY3JpcHRpb25zIG9mIHBhdGNoZXMgYXJlIG5v
dCBjbGVhciwgYW5kIHdlIGNhbm5vdCBmaWd1cmUgb3V0DQo+ID4gd2hhdCBpcyByaWdodA0KPiA+
ICAtIFRoZSBwYXRjaGVzIHdlIGlkZW50aWZpZWQgZG8gbm90IHJlYWxseSBsb29rIGxpa2UgZml4
aW5nIHRvbyBzZXJpb3VzIHN0dWZmLg0KPiANCj4gVGhleSBhbGwgc2VlbWVkIHRvIGludm9sdmUg
Y29tbXVuaWNhdGlvbiB3aXRoIHRoZSBvd25lciBvZiBhIFBDSWUgVmlydHVhbA0KPiBGdW5jdGlv
biAoVkYpLiAgQSBWRiBtaWdodCBiZSBhc3NpZ25lZCB0byBhIFZNIG9yIHByaXZpbGVnZWQgcHJv
Y2Vzcy4gIEluIENpdmlsDQo+IEluZnJhc3RydWN0dXJlIHN5c3RlbXMgdGhvc2Ugc2hvdWxkIGFs
cmVhZHkgYmUgdHJ1c3RlZCBhbmQgc28gdGhlIGlzc3VlcyBkb24ndA0KPiBtYXR0ZXIgdGhhdCBt
dWNoLg0KPiANCj4gPiBTbyBmYXIsIHdlIGhhZCB0aGUgZm9sbG93aW5nIEFJLCBidXQgd2UgY2xv
c2UgdGhpcyBiYXNlZCBvbiB0aGUgYWJvdmUgc2l0dWF0aW9uLg0KPiA+DQo+ID4gMi4gQ2hlY2sg
d2hldGhlciBDVkUtMjAxOS0wMTQ1LCBDVkUtMjAxOS0wMTQ3LCBDVkUtMjAxOS0wMTQ4IG5lZWRz
IHRvDQo+ID4gYmUgYmFja3BvcnRlZCB0byA0LjQgLSBLZXJuZWwgVGVhbQ0KPiBbLi4uXQ0KPiAN
Cj4gV2VsbCwgSSBmb3VuZCBpdCBxdWl0ZSBlYXN5IHRvIGJhY2twb3J0IHRoZSBhcHBsaWNhYmxl
IHBhcnRzIG9mIHRoZSBmaXhlcy4gIEkgYWxyZWFkeQ0KPiBzZW50IHRoZW0gYWxvbmcgd2l0aCBz
b21lIG90aGVyIGZpeGVzIGZvciB0aGUgNC4xNCBhbmQgNC45IGJyYW5jaGVzLCBhbmQgY291bGQN
Cj4gc3RpbGwgZG8gc28gZm9yIDQuNC4NCj4gDQo+IEJlbi4NCj4gDQo+IC0tDQo+IEJlbiBIdXRj
aGluZ3MsIFNvZnR3YXJlIERldmVsb3BlciAgICAgICAgICAgICAgICAgICAgICAgICBDb2RldGhp
bmsgTHRkDQo+IGh0dHBzOi8vd3d3LmNvZGV0aGluay5jby51ay8gICAgICAgICAgICAgICAgIERh
bGUgSG91c2UsIDM1IERhbGUgU3RyZWV0DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNYW5jaGVzdGVyLCBNMSAySEYsIFVuaXRlZCBLaW5nZG9tDQoNCg==

--o3UjhTqlgkbG3ayUMOIK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5797): https://lists.cip-project.org/g/cip-dev/message=
/5797
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--o3UjhTqlgkbG3ayUMOIK--
