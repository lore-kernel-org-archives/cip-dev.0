Return-Path: <SRS0=MO+K=7A=lists.cip-project.org=bounce+64572+4626+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFEC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 08:10:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61473207D4
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bdxIZmvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61473207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4626+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w3JbYY4521723x25dHgEFZgR; Mon, 18 May 2020 01:10:30 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.99])
 by mx.groups.io with SMTP id smtpd.web11.37886.1589789429343908639
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 01:10:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWce/tPTQk+Ayqc5VzhD8Ai8abINCscfj6Tx3bbF3u4pNQRRGoetK4qZYDXO1x4qRF/F+gMjQgAL/Clwmw2pXLLv9HwQDGUDU7cgqyUtsC4MO2+pHulGhyFiTwDsT88ubxag4/zIk8YWtxkrMGbYDm5LLMWfW4Q0fM98A88cqsOOqQ8/f6ztoGR+OHbwDrURl+JDMztFkcw8AjH14RYAvYwfUaLCoAY2qb0VBwj45a+JzM4RIUa+gvFZ/wy2fY9OQJ+mIncPgDnRCiJKDIBMxzV3RuKNKf1oKK69rBFUHBoOz9b7myc+V2kM0cAR4ptQ+4grBqd5d1fdJSnZOagg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeviAeQYpkzPGNRm9dN+ctjs5Bn91mVlYyhNh3lp+UE=;
 b=di5nIBhtHlW5QkURl0KTPUevbKMYHQojDGFqT4nO5/TppYyRkXFWhP4Q7UWJD4WgKxSCRSB8nT8JD8VSZkcE5n6w9+VFeRg8mcBLG98oxlt9PddEWMwTsV8VS5SiVeOmhfhJhSZTa9rAsca1ojcxXGb9r5dqqf9FdQQHlfqomzzUnB78pihpAwZF3YF4Mx+lOCW5GrSRUGwpevK1gSb542uyTKZaHqxOiuDiHvDti6px3gQ1XWMyE0hhCC2GVbYKPXydkWolNjS0pdje4haob8xRQx5MUjkL1BvlDa2mAogJrBHzS9vJbSzhHQ5+KIttOEOeerbtZaaXf+lGQhhnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3459.jpnprd01.prod.outlook.com (2603:1096:604:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 08:10:25 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 08:10:25 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "daniel.sangorrin@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
Thread-Topic: [cip-dev][isar-cip-core] Integration of test and security
 dependencies with cip-core
Thread-Index: AdYs0vpAUKy4cgndQaKwQlyaddtP7gAFtRAQ
Date: Mon, 18 May 2020 08:10:25 +0000
Message-ID: 
 <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [151.224.223.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aa56657-aff8-4695-ed5b-08d7fb02eb9b
x-ms-traffictypediagnostic: OSAPR01MB3459:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3459C58616CB70779116D79FB7B80@OSAPR01MB3459.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 MXlm5uPInKd8qkx77TM3zk/+rW59ktTQMpJkIZ2jQMwJT/a/rK0nQS5362+BlMQBDmy3tUhEu0TVvagJ7pAQUHGFzaKCPaLbg6N8Dsa9NQfIk56PzZe7OLsDnDxNa0BKmiZ1yNv/+zwqLDXfE2MCebilkvyxywXNwp1i1enl4Yt6q1fBnX5wTFzw9uDkzsFJ+8TbcDBh8c208FtlV4+yLRyft2UzccSVWU3Zi+1ju+8ab6w2Y5N59KfTPMyQoKABoIJ+MLrzispNBW5MH0AEve+jq8/dmpAxkkWDOmFwGmSVPNfowo6P0s4X7qmchd/FI8mXtFph2EiWJBdaLU29JB9YIFL3XvY/wXpDjJc9eyi5lhWOyIhIktDSy3I1lUj8eVVKKBm7HYnFEYWh7xqYFOJPHtrlrh1E8JXhtHWQMtYiyxfF8dFWpF8uRQYFgtOjCri+3evBQXbIStjF5N6F3gvENDtXYyncpcqJyx7XyOy6Q/IKfi33sCRb1L++bgexy+tDW70sKh+Mv+DMphgJ4w==
x-ms-exchange-antispam-messagedata: 
 5LI02pjWZmaSMlOSAqhr8LnPyM0vspp6cvnbHOdrWrPhSuNdbfA/2LZJnPjKj+VQ96G4tAwpu8sZw0V8JIy8Na/dV/5PktJy0GGPwETkZKkDQ9u/h/W5VPUykrNoKiA23x0nbvk10R9c2gs+kkwKvzA7HwoeXMQnEkRW2eQmjF8O3O1SRPwBV0lfoRqNu3WZ+CPY6yeSzUp5maYKP5cS/ulIDbLq36jYJSRmCIrWYkvKpw1ccknan/D2IH/F704xNLjtWheXR3dLA0S/rt8zcLCJvf9eHIO7Cgccgv7irF4R70BnR1GXo2YECFFFzMCPkiMXu+nTeCVRFcPjsLf26VWDuB22ZKoyd3yaZjzJrT6KlcUyiMiuRqcUXQi+AL0JmxE++s0oEVZUCFBnOrT9wCKAxNUdOOabUgTnxTw0CSvefmSvutHDOoQ+tTbHT1VyahpyWBwKGQNX2x/gSLplwYUlWw/oGkX0fDffB5VEuFpknf2YiqcmMYOmgQ+k9tIZ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa56657-aff8-4695-ed5b-08d7fb02eb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 08:10:25.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hRUL7vo5E8GcTNE9NT5kOXa3YcoYsSucw2Ix2SPX+timU+MLGE7ZJ/6sJPprn1wr3xLFUdthqZKDtwdvjiPL/iK07jQDGK+vfDSDcPm8B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3459
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ozth3ulGrUBsxfONTuwHICCOx4520388AA=
Content-Type: multipart/mixed; boundary="QaEc5tEPHQSuFkHduwv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589789430;
 bh=dVEzWFdz36TAXF9uzq9GcS8VBz/MCs3IbkHgG/6r0nc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=bdxIZmvG0119rD1e/hMXSrQaNYntYmHWGYdyIDjlMG2PxDeh+1be+48FDdPgXtqF1NN
 jOvQnLdtMGzXPDEe6aOYIRr80zrdN8thJ19cA+w2OrqDyEodFFt9EEZOFdDIRmkgt8zLJ
 V61v0pnf5gVmR//nykCeLaaDZkuk/KTI6Eo=

--QaEc5tEPHQSuFkHduwv8
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCj4gRnJvbTogZGFuaWVsLnNhbmdvcnJpbkB0b3NoaWJhLmNvLmpwIDxkYW5pZWwu
c2FuZ29ycmluQHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6IDE4IE1heSAyMDIwIDA3OjM3DQo+IA0K
PiBIZWxsbyBEaW5lc2gsIENocmlzLCBKYW46DQo+IA0KPiAjIEJBQ0tHUk9VTkQNCj4gDQo+IEFz
IEkgbWVudGlvbmVkIGluIG91ciBsYXN0IHRlY2huaWNhbCBzdGVlcmluZyBjb21taXRlIG1lZXRp
bmcsIG91ciBnaXRsYWItY2kNCj4gc2NyaXB0cyBzaG91bGQgYmUgYWJsZSB0byBwcm9kdWNlIG11
bHRpcGxlIE9TIGltYWdlcy4gRm9yIGV4YW1wbGUsIHRoZSB0ZXN0aW5nDQo+IHRlYW0gbmVlZHMg
dG8gaGF2ZSBweXRob24gYW5kIHBvc3NpYmx5IG90aGVyIHNvZnR3YXJlIGluY2x1ZGluZyB0aGUg
dGVzdHMNCj4gdGhlbXNoZWx2ZXM7IGFuZCB0aGUgc2VjdXJpdHkgdGVhbSBuZWVkcyB0byBoYXZl
IGV4dHJhIHBhY2thZ2VzIGFuZCBwcm9iYWJseQ0KPiBsb3RzIG9mIGN1c3RvbWl6YXRpb25zLg0K
DQpUaGFua3MgZm9yIHN0YXJ0aW5nIHRoZSBjb252ZXJzYXRpb24uDQoNCj4gDQo+ICMgQ1VSUkVO
VCBTVEFUVVMNCj4gDQo+IEF0IHRoZSBtb21lbnQgd2UgaGF2ZSB3aGF0IEkgd291bGQgY2FsbCAi
dGFyZ2V0IGltYWdlcyIsIHdoaWNoIGNvbnRhaW46DQo+IA0KPiAqIHNvbWV0aGluZyBjbG9zZSB0
byB3aGF0IEkgd291bGQgY2FsbCB0aGUgIkNJUCBDb3JlIEdlbmVyaWMgcHJvZmlsZSI6DQo+ICAg
ICAqIHRoZSBJU0FSIGNvcmUgcGFja2FnZXMNCj4gICAgICAgICAqIEkgdGhpbmsgdGhlc2UgYXJl
IGJhc2ljYWxseSBkZWJvb3RzdHJhcCBtaW5iYXNlIChpc2FyL21ldGEvcmVjaXBlcy0NCj4gY29y
ZS9pc2FyLWJvb3RzdHJhcCkNCj4gICAgICogc29tZSBleHRyYSBjdXN0b21pemF0aW9ucw0KPiAg
ICAgICAgICogaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lw
LWNvcmUvLQ0KPiAvdHJlZS9tYXN0ZXIvcmVjaXBlcy1jb3JlLw0KPiAqIHRhcmdldC1kZXBlbmRl
bnQgcGFja2FnZXMgKGtlcm5lbCwgdS1ib290LCBmaXJtd2FyZSwgZXRjKQ0KPiAgICAgKiB0aGVz
ZSBhcmUgYWRkZWQgdXNpbmcgS0FTIG9wdC55YW1sIHN5bnRheCwgaW5zdGVhZCBvZiB1c2luZyBh
IG1ldGEtbGF5ZXINCj4gKiBvcHRpb25zDQo+ICAgICAqIG9wdC1ydDogd2lsbCB1c2UgYSBrZXJu
ZWwgd2l0aCBQUkVFTVBULVJUIHBhdGNoDQo+ICAgICAqIG9wdC1zdHJldGNoOiB3aWxsIHVzZSBz
dHJldGNoIGFzIGRpc3Rybw0KPiAgICAgKiBvcHQtNC40OiB3aWxsIHVzZSBrZXJuZWwgdjQuNCBp
bnN0ZWFkIG9mIHRoZSBkZWZhdWx0IDQuMTANCj4gICAgICogb3B0LXRhcmd6LWltZzogZXhwb3J0
cyB0aGUgaW1hZ2UgYXMgYSB0YXJiYWxsIGZvciBMQVZBDQo+IA0KPiBPbiB0aGUgYnJhbmNoLCBp
ZWMtZXZhbHVhdGlvbiB0aGVyZSBpcyBhbiBpbml0aWFsIGltcGxlbWVudGF0aW9uIG9mIHRoZSBz
ZWN1cml0eQ0KPiBpbWFnZToNCj4gICAgICogaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0
L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS90cmVlL3NlY3VyaXR5L2llYy0NCj4gZXZhbHVhdGlv
bg0KPiAgICAgKiBhdCBmaXJzdCB0aGV5IGFkZGVkIGFuIG9wdC1zZWN1cml0eS55YW1sIGZpbGU6
DQo+ICAgICAgICAgKiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNh
ci1jaXAtY29yZS8tDQo+IC9jb21taXQvYTgyMTZkNGNhNWVlZDRkNzNkZmYyZTAwNjAxZGVhN2M5
ZDczM2Y0NQ0KPiAgICAgKiB0aGVuIHRoZXkgY2hhbmdlZCB0byB1c2UgcmVjaXBlcy1jb3JlL2lt
YWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiB0aGF0IGV4dGVuZHMgSU1BR0VfUFJF
SU5TVEFMTA0KPiAgICAgICAgICogaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1j
b3JlL2lzYXItY2lwLWNvcmUvLQ0KPiAvY29tbWl0LzM0NjFhNTAyOTdlMzcwMjEwZDc2ZDg1ZDQz
NGZiNjI1YzhjNDI0OGMNCj4gICAgICogc2VlIHRoZSBvcmlnaW5hbCB0aHJlYWQgaGVyZToNCj4g
ICAgICAgICAqIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NpcC0NCj4gZGV2L1RZWFBSMDFNQjE4
MDgxN0M4ODNGODc0QjMyMURCQTI2NEUxRkQwQFRZWFBSMDFNQjE4MDguanBucHJkDQo+IDAxLnBy
b2Qub3V0bG9vay5jb20vVC8jbTc1MmExMTZkODM3MjIyMmQ3Mjc3MjJmNGZlMThjYTE5ZDk0ODM4
ZWINCj4gDQo+ICMgTVkgUFJPUE9TQUwNCj4gDQo+IE15IHByb3Bvc2FsIGFzIHRoZSBuZXh0IHRh
c2sgZm9yIHRoZSBDSVAgQ29yZSB3b3JrIGdyb3VwIGlzIHRvIGFkZCBtZXRhZGF0YSBmb3INCj4g
cmVsZWFzaW5nIHRoZXNlIGltYWdlczoNCj4gDQo+ICogdGFyZ2V0IGltYWdlczogaXNhciBkZWJv
b3RzdHJhcCArIGN1c3RvbWl6YXRpb25zICsga2VybmVsL3UtYm9vdC9mdw0KPiAgICAgKiBbTkVX
XSByZWxlYXNlIHRoZW0gYXMgYm1hcCBpbWFnZXMgZm9yIG91ciByZWZlcmVuY2UgaGFyZHdhcmUg
Ym9hcmRzDQo+ICAgICAqIFtORVddIGNyZWF0ZSBhIHBhZ2UgKGdpdGxhYiB3aWtpKSB0aGF0IHdp
bGwgY29udGFpbiBsaW5rcyB0byB0aGUgbGF0ZXN0IGltYWdlcw0KPiBhbmQgaG93LXRvLWluc3Rh
bGwgcmVhZG1lcyBmb3IgZWFjaCByZWZlcmVuY2UgYm9hcmQNCj4gICAgICogW05FV10gcmVmZXIg
dG8gdGhhdCBwYWdlIGZyb20gdGhlIENJUCB3aWtpIHBhZ2UNCj4gKGh0dHBzOi8vd2lraS5saW51
eGZvdW5kYXRpb24ub3JnL2NpdmlsaW5mcmFzdHJ1Y3R1cmVwbGF0Zm9ybS9jaXB0ZXN0aW5nL2Np
cHJlZmVyDQo+IGVuY2VoYXJkd2FyZSkNCg0KQWxsICsxDQoNCj4gKiBbTkVXXSB0ZXN0aW5nIGlt
YWdlczogdGFyZ2V0IGltYWdlcyArIHRlc3QgZGVwZW5kZW5jaWVzDQo+ICAgICAqIHJlbGVhc2Ug
dGhlbSB1c2luZyBvcHQtdGFyZ3otaW1nIHNvIHRoZXkgY2FuIGJlIHVzZWQgaW4gTEFWQQ0KPiAg
ICAgKiBhZGQgdGhlIHRlc3QgZGVwZW5kZW5jaWVzDQo+ICAgICAgICAgKiBwYWNrYWdlczogcHl0
aG9uMi43LCBweXRob24zLCAuLi4NCj4gICAgICAgICAqIHRlc3RzOiBMVFAsIC4uLg0KPiAgICAg
ICAgICAgICAqIG1ldGhvZCAxOiBidWlsZCB0aGVtIG9uIGEgc2VwYXJhdGUgcmVwbyBhbmQgaW5j
bHVkZSBpbiB0aGUgaW1hZ2UNCj4gICAgICAgICAgICAgKiBtZXRob2QgMjogYnVpbGQgdGhlbSB3
aXRoIElTQVIgKG5ldyByZWNpcGVzKSBhbmQgaW5jbHVkZSBpbiB0aGUgaW1hZ2UNCj4gICAgICAg
ICAgICAgKiBtZXRob2QgMzogdGhlIGFydGlmYWN0cyBhcmUgZG93bmxvYWRlZCBieSBMQVZBIDwt
LSBNeSBwcmVmZXJlbmNlDQoNCkJ5ICJhcnRpZmFjdHMiIGRvIHlvdSBtZWFudCB0aGUgZW50aXJl
IGZpbGVzeXN0ZW0/IE9yIGp1c3QgaW5kaXZpZHVhbCB0ZXN0IHBhY2thZ2VzIGV0Yy4/DQoNCk15
IHByZWZlcmVuY2Ugd291bGQgYmUgZm9yIHRoZSB3aG9sZSBmaWxlc3lzdGVtIGluY2x1ZGluZyB0
aGUgdGVzdCBwYWNrYWdlcyB0byBiZSBidWlsdCBieSBJU0FSLCB0aGVuIExBVkEganVzdCBkb3du
bG9hZHMgdGhlICdsYXRlc3QnIGNpcC1jb3JlLXRlc3QgaW1hZ2Ugd2hlbiBydW5uaW5nIHRlc3Rz
Lg0KDQo+ICAgICAgICAgKiBIb3cgdG8gaW1wbGVtZW50IHRoaXMNCj4gICAgICAgICAgICAgKiBt
ZXRob2QgMTogdXNpbmcgdGhlIG9wdCB5YW1sIGZvcm1hdCA8LS0gTXkgcHJlZmVyZW5jZSBpZiB3
ZSBvbmx5IG5lZWQNCj4gdG8gc3BlY2lmeSBwYWNrYWdlcw0KPiAgICAgICAgICAgICAqIG1ldGhv
ZCAyOiBjcmVhdGluZyBhIHNlcGFyYXRlIG1ldGEgbGF5ZXINCj4gICAgICAgICAgICAgKiBtZXRo
b2QgMzogdXNpbmcgYSBuZXcgaW1hZ2UgKGNpcC1jb3JlLWltYWdlLXRlc3RpbmcuYmIpDQoNCkFz
IGxvbmcgYXMgdGhlICdzdGFuZGFyZCcgY2lwLWNvcmUgaXMgaW5jbHVkZWQvaW5oZXJpdGVkIHJh
dGhlciB0aGFuIGNvcGllZCBJIGRvbid0IG1pbmQgdGhlIG1ldGhvZC4NClRoaXMgd2lsbCByZWR1
Y2UgdGhlIG1haW50ZW5hbmNlIGJ1cmRlbi4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+ICog
W05FV10gc2VjdXJpdHk6IHRhcmdldCArIHNlY3VyaXR5IHBhY2thZ2VzICsgc2VjdXJpdHkgdGVz
dHMgYW5kIGRlcGVuZGVuY2llcw0KPiAgICAgKiByZWxlYXNlIGluIHR3byBmb3JtYXRzDQo+ICAg
ICAgICAgKiB1c2luZyBvcHQtdGFyZ3otaW1nIHNvIHRoZXkgY2FuIGJlIHVzZWQgaW4gTEFWQQ0K
PiAgICAgICAgICogYXMgaW1hZ2VzIGZvciBvdXIgcmVmZXJlbmNlIGhhcmR3YXJlIGJvYXJkcw0K
PiAgICAgICAgICAgICAqIGFkZCB0byB0aGUgZ2l0bGFiIHdpa2kgbGlua3MgdG8gdGhlIGxhdGVz
dCBpbWFnZXMgYW5kIGhvdy10by1pbnN0YWxsDQo+IHJlYWRtZXMgdG9vDQo+ICAgICAqIEhvdyB0
byBpbXBsZW1lbnQgdGhpcw0KPiAgICAgICAgICogbWV0aG9kIDE6IHVzaW5nIHRoZSBvcHQgeWFt
bCBmb3JtYXQNCj4gICAgICAgICAqIG1ldGhvZCAyOiBjcmVhdGluZyBhIHNlcGFyYXRlIG1ldGEg
bGF5ZXIgPC0tIE15IHByZWZlcmVuY2UgaWYgaXQgZ2V0cw0KPiBjb21wbGV4DQo+ICAgICAgICAg
KiBtZXRob2QgMzogdXNpbmcgYSBuZXcgaW1hZ2UgKGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJi
KSA8LS0gQ3VycmVudA0KPiBtZXRob2QNCj4gDQo+ICMgRkVFREJBQ0sNCj4gDQo+IFBsZWFzZSBj
aGVjayBteSBpbml0aWFsIHByb3Bvc2FsIGFuZCBzZW5kIG1lIGZlZWRiYWNrLg0KPiANCj4gVGhh
bmtzLA0KPiBEYW5pZWwgU2FuZ29ycmluDQo+IA0KPiANCj4gDQoNCg==

--QaEc5tEPHQSuFkHduwv8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4626): https://lists.cip-project.org/g/cip-dev/message=
/4626
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QaEc5tEPHQSuFkHduwv8--
