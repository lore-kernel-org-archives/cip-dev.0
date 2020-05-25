Return-Path: <SRS0=TId+=7H=lists.cip-project.org=bounce+64572+4641+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7906EC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 25 May 2020 14:51:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7F82078B
	for <cip-dev@archiver.kernel.org>; Mon, 25 May 2020 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f4F5s+Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7F82078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4641+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tecyYY4521723xJMglViogxJ; Mon, 25 May 2020 07:51:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.32491.1590418259837700470
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2020 07:51:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 04PEolua026927; Mon, 25 May 2020 23:50:48 +0900
X-Iguazu-Qid: 34trDAmeJFHERcHFsu
X-Iguazu-QSIG: v=2; s=0; t=1590418247; q=34trDAmeJFHERcHFsu; m=ql9tjaF1wuovRMgPVTu+3edgWVQW2C+AnLAk7sJJf3s=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 04PEokKi023673;
	Mon, 25 May 2020 23:50:46 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04PEoj0T025131;
	Mon, 25 May 2020 23:50:45 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04PEoj1a029581;
	Mon, 25 May 2020 23:50:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrvrRbm19cE/L8f37p/K73HlKayszeqMawHCgfCtWKArREUWjtnUGW8CYRBJRPMxDtbNTU30SY7Tgli9MXUrJXkCA3Kg9QlFiJtWpQGZ5CvqvrAzTvjwj3z8EJ0cIzjh/subMax+wWkAQoVH5swNuJHq7MJ10ztqGbno04fIOj3swMK5TZxMFpIUZxnrKrxwuNjFwLiBZmbLNGUZJ2EqIvrKEhyWIHpuZCcV5Uhc3i1RZJ0dlAOplyeHcLNGLae0+J2S92GR5dXONvqsl82hmf6hGxxvNaVjJBeqqH8phWNrC7OsEukPgeG+p0YxUaqd2Itlv30uuPxXLRb93Pxi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEPNEVWbcgdQKjaW0VvuBPvZsIhO+6xx8lqwuFsLOdo=;
 b=OxSQweJEwaUKU315GL3f+CCIxiVWQsId1X0GWzFjheD/jNIMd+8xGrYZI7QG9Ki3OOBIkvqaveDO0SZbmz1e/6QBTZYriKIxivMGUlqmbsNajAa2/7sxPXHD7rFMb9vVW1vgbreOCuNAycGCJJNGppxYC41GOYdEyxXGU3ywsWUi3D+Rm1fOjEAV96GXpl7vu2PGGuOS9v7EyhbrfYoxLQ2fD6aWXaIVkgqURIYWbMVKxrRHvfLM1ry7xsVTUxOGEfkn+rnpb+TwS8zesnqPH49tyi8KM5lMp2dnZGcR32SuixRN1iKAPYTaI60gWvDlcHBv/Fgy/8jnqFqxdot5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core] version management
Thread-Topic: [cip-dev][isar-cip-core] version management
Thread-Index: AdYthqu0kcefdkDOSNuvyCjETy2KPACst5AAAJlXsdA=
Date: Mon, 25 May 2020 14:50:39 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
 <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
In-Reply-To: <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
Accept-Language: en-US
x-originating-ip: [124.211.28.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0826482-3177-44fa-2e1d-08d800bafdfe
x-ms-traffictypediagnostic: OSBPR01MB5286:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB52865E8DC093B9CB63044FA3D0B30@OSBPR01MB5286.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KFeu7++by4IAJW0ZA+0Vyno5LR2cJ97dNvgdE904U4s5Sbxr3BpeodXNV3WoK2VN11Va3a++RliKLKN7rBxRoaKlwh/+SWArnJVx6EaqUuz9Yn/60A8jqOkugMOem2AIKKBRHyHyNjw5GFwWOvSew9gu0kTKbip75BnZVe5MUm3fHXz8BU+lynON1MTQ2qx5dU9yi9PdIIM3ANt7m+8qHyPludv6/WmZKDLXgzqAOjjPfDwMNzj+rcp9ypgIkIr5kUchmwqZ++TbQs3hkMSrE+GAltoP4E64UYH478/r8X/hYojPNyU0n4BHhXzytS1USQ5OHnExdaUSEmrzhak8RAKYLO7Vd/quGGyTZJPNa4e+Chk2gKegY0qhdAhElQkP7au0MdJ1w6gqsvz7pTxBFQ==
x-ms-exchange-antispam-messagedata: Cc1byCFE+ZkoFCqnDfKK1OHyHV/ltfomA8+3o2edVoViNUfeyXCFBFP+Zt52GJL1ND0G5M+FgBMynoDgUGvFplvRp+g6EI6JAT3YCbAhgSshEdCBkPj7axUWezzhNfAgyX+c9naQ44WN7X/fj6uJ39MnKaiCMKVkYMNUHOBavH5OqT2FEy3JDqztQrzngLOdcIVUi8xL+pRTyz+mdr62M0bKEIURLGflu70JXbiXhH3N8ej/7XYKEwiNM07LmSI2AQVvUWb+DrRxROUljAs0up+ti7kp0aygellalKdIeoqzsBpsTFd0EkHnBC9xRv3iYABwjbadJczpxAmQxSvZXCl/wNYshfqAC47bMoS1h5QLKV5u72h+l9q/mi7ybKT2HhFszx5a/0F4M40tuRs4YlbgSFH22/PA8WrD7/wgVo3+/JY/bJeFwHHMKYcZ/SHYrji5pBFWbVDS4GmzkiTUKquGEqGLXg5Vxog4JzxuXx8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a0826482-3177-44fa-2e1d-08d800bafdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 14:50:39.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgU3tzrQHvxZHUxFOgXG2SXo3JBuqqFvFx0b/9gkFnKLv7p6oNUNE0DbeOrlw5sqUmL+3GBFuR/ueMyqNs6l1UB6oyxBUcWM1Os1wgXfD84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5286
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XDDjfvlomw9GVwvXXkmmTqXix4520388AA=
Content-Type: multipart/mixed; boundary="Fddue5LM2Cv8NRl98scy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590418262;
 bh=f7ov7UrN5RABxCNoH/F4xxNih26A63b27z7AN19t3Ls=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=f4F5s+VpIhVVhCasZY2tBh3JXByK6YCHfVWCC99kdHZCuTzHR8Wb3fQ9Imn9IU5KnA0
 49Y+bEoD5rfVQrDJ9a+NyRMYRDT6W6dM2BsZRQp0hccQO910Cv0Sk8ueDfRacUGvFO5nY
 dy/shqdSOWclbR+79SjI1acDiATAd12/oMM=

--Fddue5LM2Cv8NRl98scy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIEJlbi4NCg0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBP
ZiBCZW4gSHV0Y2hpbmdzDQo+ID4gSSBhZ3JlZSB0aGF0IHdlIG5lZWQgdG8gdmVyc2lvbiBvdXIg
cmVsZWFzZXMuIEluIERlYmlhbiB0aGVyZSBhcmUNCj4gPiBwb2ludCB2ZXJzaW9ucywgYnV0IEkg
ZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBmb2xsb3cgdGhhdC4gTWF5YmUgd2UNCj4gPiBjYW4ganVz
dCB1c2UgYSBudW1iZXIgc3VjaCBhcyB0aGUgZGF0ZSBvZiB0aGUgcmVsZWFzZSAoZWcuIDIwMjAw
NTE5DQo+ID4gPC0tIHllYXJtb250aGRheSkuDQo+IA0KPiBJbmNsdWRpbmcgcHVuY3R1YXRpb24g
aW4gdGhlIGRhdGUgbWF5IG1ha2UgaXQgbW9yZSByZWFkYWJsZS4gIEFsc28gdGhlDQo+IGRheS1v
Zi1tb250aCBjb3VsZCBiZSBvbWl0dGVkIGlmIHRoZXJlIHdpbGwgYmUgbm8gbW9yZSB0aGFuIG9u
ZSByZWxlYXNlDQo+IHBlciBtb250aC4NCg0KTXkgcHJlZmVyZW5jZSB3YXMgaW5jbHVkaW5nIHRo
ZSBkYXktb2YtbW9udGggYmVjYXVzZQ0KYSkgdGhlIGtlcm5lbCBzb21ldGltZXMgZ2V0cyByZWxl
YXNlZCBpbiBsZXNzIHRoYW4gYSBtb250aC4gQnV0IHRoYXQncyBpbiBjYXNlIHdlIHJlbGVhc2Ug
YXQgdGhlIHNhbWUgcGFjZS4NCmIpIGlmIHdlIHJlbGVhc2UgYSB2ZXJzaW9uIHRoYXQgaGFzIGEg
cHJvYmxlbSwgd2UgY2FuIHJlbGVhc2UgYSBuZXcgb25lIHF1aWNrbHkgdGhlIG5leHQgZGF5Lg0K
DQo+ID4gU29tZSBxdWVzdGlvbnMgcmVnYXJkaW5nIHZlcnNpb25pbmc6DQo+ID4gICAgKiBzaG91
bGQgd2UgYWxzbyBzdG9yZSBtZXRhZGF0YSBhc3NvY2lhdGVkIHdpdGggYSByZWxlYXNlPw0KPiA+
IAkqIGEgcGFja2FnZSBsaXN0IG1hbmlmZXN0IGZvciBlYWNoIHJlbGVhc2UgKGRwa2cgLWwpPw0K
PiA+ICAgICAgICAgKiB0aGUgY2lwLWNvcmUgYnJhbmNoIGFuZCBjb21taXQNCj4gPiAgICAgICAg
ICogdGhlIGNpcC1rZXJuZWwgYnJhbmNoIGFuZCBjb21taXQNCj4gPiAgICAgICAgICogbWQ1c3Vt
IG9mIHRoZSBpbWFnZQ0KPiANCj4gQW4gbWQ1c3VtIHdvdWxkIGhlbHAgdG8gZGV0ZWN0IGFjY2lk
ZW50YWwgY29ycnVwdGlvbiwgYnV0IHRoYXQncyBhbGwuDQo+IEFueSByZWxlYXNlIG5lZWRzIHRv
IGJlIGNyeXB0b2dyYXBoaWNhbGx5IHNpZ25lZCwgYW5kIHRoYXQgd2lsbCBwcm92aWRlDQo+IGEg
bXVjaCBzdHJvbmdlciBpbnRlZ3JpdHkgY2hlY2suDQoNCkdvb2QgcG9pbnQsIHRoYW5rIHlvdS4N
Cg0KV2UgY2FuIGNyZWF0ZSBhIFBHUCBzaWduYXR1cmUgb24gZ2l0bGFiLWNpIGFuZCBzZW5kIGl0
IHRvIFMzIHRvZ2V0aGVyIHdpdGggdGhlIE9TIGltYWdlLiBTaG91bGQgd2UgcHV0IHRoZSBwdWJs
aWMga2V5IChhbmQgZmluZ2VycHJpbnQpIG9uIHRoZSBpbWFnZSByZWxlYXNlIHdpa2k/DQoNCkNo
cmlzOiB0aGlzIGNvdWxkIGJlIHVzZWZ1bCB0byBtYWtlIHN1cmUgdGhhdCB3ZSBydW4gdGhlIHJp
Z2h0IHRoaW5nIGluIExBVkEuDQoNCj4gPiAgICAqIGRvIHdlIG5lZWQgcmVwb3NpdG9yeSBtYW5h
Z2VtZW50IGluZnJhc3RydWN0dXJlPw0KPiA+ICAgICAgICAqIG1pcnJvciBwYXJ0IG9mIHRoZSBk
ZWJpYW4gcmVwb3NpdG9yeSAob25seSB0aGUgcGFja2FnZXMgdGhhdCB3ZSBuZWVkKQ0KPiA+ICAg
ICAgICAqIGNyZWF0ZSBzbmFwc2hvdHMgZm9yIGVhY2ggcmVsZWFzZSBpbmNsdWRpbmcgdGhlIHNv
dXJjZSBjb2RlIHBhY2thZ2VzDQo+ID4NCj4gPiBTdG9yaW5nIG1ldGFkYXRhIHNob3VsZCBub3Qg
YmUgdG9vIGRpZmZpY3VsdCwganVzdCBhZGQgc29tZSBzY3JpcHQNCj4gPiBjb2RlIHRvIGdpdGxh
Yi1jaS4NCj4gPg0KPiA+IEtlZXBpbmcgc25hcHNob3RzIHdvdWxkIHJlcXVpcmUgbXVjaCBtb3Jl
IHdvcmsgYW5kIHJlc291cmNlcy4gSSB0aGluaw0KPiA+IHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBz
aW5jZSB3ZSBhcmUgbm90IGdvaW5nIHRvIHJlYnVpbGQgaW1hZ2VzLCBhbmQNCj4gPiBpZiB3ZSB3
YW50ZWQgd2UgY291bGQgZG8gaXQgc29tZWhvdyBmcm9tIHRoZSBwYWNrYWdlIGxpc3QgbWFuaWZl
c3QNCj4gPiBhbmQgdGhlIHVwc3RyZWFtIERlYmlhbiBmdHAgc2VydmVycy4NCj4gDQo+IFdlIHNo
b3VsZCBjZXJ0YWlubHkgcmVjb3JkIGFsbCB0aGUgaW5wdXRzIGZvciBhbiBpbWFnZTsgdGhhdCdz
IGENCj4gcmVxdWlyZW1lbnQgZm9yIHJlcHJvZHVjaWJsZSBidWlsZHMuICBJZGVhbGx5IHRoaXMg
cmVjb3JkIHdvdWxkIGJlDQo+IHN1ZmZpY2llbnQgZm9yIHNvbWVvbmUgdG8gcmVwZWF0IHRoZSBp
bWFnZSBidWlsZCBpbiBhbiBhdXRvbWF0ZWQgd2F5LA0KPiBlaXRoZXIgc3RyYWlnaHQgYXdheSBv
ciBhdCBhbnkgcG9pbnQgaW4gdGhlIGZ1dHVyZS4NCg0KVHJ1ZS4gSSBndWVzcyB3ZSB3aWxsIGhh
dmUgdG8gZG8gaXQgcHJvcGVybHkgOykNCg0KVGhhbmtzLA0KRGFuaWVsDQoNCj4gDQo+IEJlbi4N
Cj4gDQo+IC0tDQo+IEJlbiBIdXRjaGluZ3MsIFNvZnR3YXJlIERldmVsb3BlciAgICAgICAgICAg
ICAgICAgICAgICAgICBDb2RldGhpbmsgTHRkDQo+IGh0dHBzOi8vd3d3LmNvZGV0aGluay5jby51
ay8gICAgICAgICAgICAgICAgIERhbGUgSG91c2UsIDM1IERhbGUgU3RyZWV0DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYW5jaGVzdGVyLCBNMSAySEYsIFVuaXRlZCBL
aW5nZG9tDQoNCg==

--Fddue5LM2Cv8NRl98scy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4641): https://lists.cip-project.org/g/cip-dev/message=
/4641
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Fddue5LM2Cv8NRl98scy--
