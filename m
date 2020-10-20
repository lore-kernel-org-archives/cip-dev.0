Return-Path: <SRS0=ZyUG=D3=lists.cip-project.org=bounce+64572+5592+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C934C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 08:29:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF1C222C8
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 08:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hKDrOKlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF1C222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5592+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SV8VYY4521723xwqHRKS5eHA; Tue, 20 Oct 2020 01:29:28 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.49])
 by mx.groups.io with SMTP id smtpd.web12.2658.1603182566930847030
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 01:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTZfEicU7tlC8W2SVe9COjOLYx2aoevCAJsCHXuc3DHac7v+hoPVeNXQpQEwCzVRxbnSPqdBGHV+I1w27hrxNyFQnWjlyRzPaDV5BW/x02okyGfCegf5QRpx15ubI5Nv8jJCOpQ2u5R4WW/OqvUKxsEKPsMAmgYR50fSjUxCW7N19maIBjfcj5H53Zz0bLI07X8dg8l/+QKwEdx3b3EtDeGumVHdOCS6eO7whlFNFlsb0U4VPs9sVbNvKbKEnyQERa2Rco1gVvbIeSCLMcgX/BIgC9RSuZstXg8ZHCmyxfNKH5qZKDE+mZSQ7tUieAylBMsUkBPWEz5zUY2NY+bm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7TEsSo98cOezELPG2KepfAADl9ndf+sExefhndIQzo=;
 b=XEF1cM6drB8zQIsBQtJt6nWwcUunM3SQx2fI7O+8DhTxEz+4K5zsAftXuC3lZpRusFCN8damFrgGStgstvzkb7R+wXl6iau2byC/OdS271QZZtFEWmWroTJzz7Nc9o0kBAI7LkwWZjZCwKlTiHr12BNSCtQqMYYRKY05DDOOqkEuCDMkBSd7HnZh9SLcsaUhmgbE8D/OLUV2mXR7Xue62Y2NiAck5KRGy+zSOmnNn9mkKX9iHqWyhelh+Ri/P5gjUzO4LldyyHQvYBn2lvk3BHY4EPD7+n+UguirXA3Dkrxpxf8FqPQZeUOA3h/ndsDisKDR4/MJf4YUTp32H22vLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK0PR01MB2049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 20 Oct
 2020 08:29:20 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 08:29:20 +0000
From: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Rajashree
 Sankar <rajashree.sankar@sanmina.com>
Subject: Re: [cip-dev] Camera CSI support for IMX
Thread-Topic: [cip-dev] Camera CSI support for IMX
Thread-Index: AQHWo6jl6sYcEd+pJU2HV/rtv0bzaambioYAgAQcdsA=
Date: Tue, 20 Oct 2020 08:29:20 +0000
Message-ID: 
 <HK0PR01MB24509FE02AB124B60465324EE21F0@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: 
 <CA+UxhRrWr_1VNmcrujPKjPWxoZw47XCSpGY2sqbkein2vHtYug@mail.gmail.com>
 <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
In-Reply-To: <8ba7cf9c-7f55-7f06-4e34-6f4d92cce821@siemens.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.146.94.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239d6ea1-ca8e-43d2-95cd-08d874d23deb
x-ms-traffictypediagnostic: HK0PR01MB2049:
x-microsoft-antispam-prvs: 
 <HK0PR01MB2049B9B76972C33FB362A141E21F0@HK0PR01MB2049.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Ru9zkTt088Y3SgH2aInu3+oKbA9/JWsQWCW2i13F7/tGap0HGyop2cjSyb/TfFjhJw/CS87xi76GLxfHOld+YxYgvQApwM5u6k8PyBtV9wlldcquIxeS0anUBXEKyhZx9cxqKOk86r6DW6Os7/7CV89i3gZb6dJv6SASfACTAYrIYi0HGVTGDOl1PF7fFz0YN5YqbOsM2mk/ShqPqvBM0SuGM2jaQfWmwC7eGeJ85fC9Bz4Crmtyo3UX2T8b+elwI+2rqJW5Kl/q75LB+iYCw/wcBafjc1amQpiA1n9iVckg6s1QmoB2gTMRYfDDqjpdzpX8OUURbGVnHxGJOuRr03KX6FISruFHJHTvRXcsol0+Fe7LPvL0JrcAuy1uxHEW0PqXzIVrNbJ+oMrPjBI9Vg==
x-ms-exchange-antispam-messagedata: 
 vs/ptOjDbix7tzKEWSNJBiW2oft1mX91nuz3y+5P5BfgTtV1Eu4e9qiXneQoy83Lfnh73ZMb48msdhi37XMPk0P0vE4NI9NrHIX1vJpfiK2dVnfMnl6q3mc8aldJY5m+tPw/Mhxzvu1hGnukwH9cqX6elVL3DT1EGxUwNYWGsoJPjK/SXg46bbDOM8TxYoyvTCMZHdF1WdBw6pL2Y0Re8tE9qMiLBVyxEF1kG5Y9f7OOqV97TNNxDnZXBcJW68OH0lxhyJsRvA+KRfJMcUCHLAZZIwCAES+cx6KKbE1wJHQwTx6mk9KzbomJsFT4MZGst0Yuz/3h/nuAFbzOb6pLYI7u3JDYZp0L2phDswNUsRD3xDTbObKEAp5Fin2wxn4fXBjYaUQpVon9aMcKX4eTF1vs6PWCpQC40KDfh/OuMUFIdmUZATeED1gr8iVwvqvRhTzIS4q2eaWtDsIe4tHVbk5PIfAjfxFWCW0nbDwjddSHomoY4Xg4Md4awY0Gxa+ff6x9y+ljfbdr8MvfJ7xIcVoqaRBsJowUopUIcweomkeRr291mo7+qYcYiGqaArxuSh8ZqCVyWESGrZFDvyLxUarrmWZyQGxpf3rBc5oe/9LIsmodNIG/or95e5SqmNvt9V0YmhWLdUM1yyWTuUNFww==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2450.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239d6ea1-ca8e-43d2-95cd-08d874d23deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 08:29:20.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1D5BA7XWrTwicTGBpbfSAlgwpYjhdX30dipTfpoTBgslx8hiugxvRkxld7t8aUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2049
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: J1QyWjGWs0rXSu56E7e0mLfxx4520388AA=
Content-Type: multipart/mixed; boundary="xkSEaDgD8PNUwySISRvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603182568;
 bh=/H7ESZXRokWzW9+4JDmlhDGn4P2s3QlhgMPwFRd9rjo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hKDrOKlhN/o0Z28ifxexJm7nsdlgtDAeCm1aWQlIy7dt4ql0YN4jh5HcWLpYVRnj/OR
 qG9CkJl5mTcrU4vmMsmjccmrofC48fsqm6FXR8ABFuvXAfWFQvkKTfdM3wi1tahDNX1dp
 DjfYrBhEvNUTpGchzfOUtRzUHkf0AZEcoDk=

--xkSEaDgD8PNUwySISRvt
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmFqYXNocmVlLA0KDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gDQo+IA0KPiBIaSBSYWphc2hyZWUsDQo+IA0K
PiBPbiAxNi4xMC4yMCAxMjoyNSwgUmFqYXNocmVlIFNhbmthciB3cm90ZToNCj4gPiDCoEhlbGxv
LA0KPiA+IFdlIGFyZSB1c2luZyBMaW51eC1DSVAgS2VybmVsIFZlcnNpb24gNC4xOS4xNDAtY2lw
MzMuIFdlIGRvIG5vdCBmaW5kDQo+ID4gSU1YIGZpbGVzwqAgaW4gdGhlIEtlcm5lbCBzdXBwb3J0
aW5nIENhbWVyYSBDYXB0dXJlIHRocm91Z2ggQ1NJLkNvdWxkDQo+ID4geW91IGdldCB1c8KgIGhv
dyB0aGUgc3VwcG9ydCBjYW4gYmUgYWRkZWQ/DQo+IA0KPiBDYW4geW91IGJlIG1vcmUgc3BlY2lm
aWMgYWJvdXQgd2hhdCBrZXJuZWwgZHJpdmVyKHMpIHlvdSBhcmUgbWlzc2luZz8gSXMgbGF0ZXN0
DQo+IDUuOSBzdXBwb3J0aW5nIHRoaXM/IFRoZW4gcGxlYXNlIHByb3ZpZGUgYSByZWZlcmVuY2Ug
KGRyaXZlciBuYW1lLCBEVCBiaW5kaW5ncw0KPiBvciBldmVuIGNvbW1pdCBsaXN0KS4NCj4gDQo+
IE9yIGFyZSB5b3UgcmVmZXJyaW5nIHRvIGEgZmVhdHVyZSBvZiB0aGUgdmVuZG9yIHRyZWUgKGxp
bnV4LWlteCk/IFRoZW4gcGxlYXNlIHRhbGsNCj4gdG8gTlhQIGFuZCBhc2sgYWJvdXQgdGhlIHN0
YXR1cyBvZiB0aGlzLCBpZiB0aGVyZSBpcyBhbiB1cHN0cmVhbSBlcXVpdmFsZW50IGJ5DQo+IG5v
dyBvciBpZiB0aGlzIGhhcyBiZWVuIGFiYW5kb25lZCBieSB0aGVtLg0KPiANCj4gQ0lQIGhhcyBh
IHN0cmljdCB1cHN0cmVhbS1maXJzdCBwb2xpY3ksIHNvIHdlIGNhbid0IHRha2UgYW55IGRvd25z
dHJlYW0gcGF0Y2hlcy4NCj4gSG93ZXZlciwgaWYgYSBmZWF0dXJlIGlzIHVwc3RyZWFtIGFuZCBv
bmx5IG1pc3NlZCB0aGUgbGF0ZXN0IENJUCBrZXJuZWwsIHlvdSBjYW4NCj4gcHJvcG9zZSBiYWNr
cG9ydGVkIHBhdGNoZXMgZm9yIGludGVncmF0aW9uIGludG8gdGhhdCBrZXJuZWwuIFByZWNvbmRp
dGlvbnM6DQo+IA0KPiAgLSB0aGV5IGFyZSBub3QgaW52YXNpdmUgdG8gb3RoZXIgZHJpdmVycyBv
ciB0aGUga2VybmVsIGFzIGEgd2hvbGUNCj4gDQo+ICAtIHlvdSBhcmUgYSBDSVAgbWVtYmVyLCBv
ciB0aGUgQ0lQIG1lbWJlciBjb21tdW5pdHkgc3VwcG9ydHMgdGhlDQo+ICAgIGJhY2twb3J0IChh
cyBpdCBtYXkgaW5jcmVhc2Ugb3VyIHdvcmtsb2FkKQ0KDQpZb3UgbWF5IGZpbmQgdGhlIGRldGFp
bHMgb2YgQ0lQIGtlcm5lbCBtYWludGVuYW5jZSBwb2xpY2llcyBoZXJlIFsxXSBhbmQgaGVyZSBb
Ml0NCg0KWzFdIGh0dHBzOi8vd2lraS5saW51eGZvdW5kYXRpb24ub3JnL2NpdmlsaW5mcmFzdHJ1
Y3R1cmVwbGF0Zm9ybS9jaXBrZXJuZWxtYWludGVuYW5jZSNjaXBfa2VybmVsX21haW50ZW5hbmNl
X3BvbGljaWVzDQpbMl0gaHR0cHM6Ly9zdGF0aWMuc2NoZWQuY29tL2hvc3RlZF9maWxlcy9vc3Nu
YTIwMjAvZDAvT1NTTkEyMDIwLUNJUEtlcm5lbFRlYW0tMi5wZGYNCg0KU1oNCg0KPiANCj4gPiBU
aGFua3MgYW5kIFJlZ2FyZHMsDQo+ID4gUmFqYXNocmVlIFNhbmthcg0KPiA+DQo+ID4gQ09ORklE
RU5USUFMSVRZDQo+ID4gVGhpcyBlLW1haWwgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIHRo
ZXJldG8sIGlzIGludGVuZGVkIG9ubHkgZm9yDQo+ID4gWy4uLl0NCj4gDQo+IElmIGNvbmZpZ3Vy
YWJsZSBvbiB5b3VyIGNsaWVudCwgcGxlYXNlIGRpc2FibGUgdGhpcyBmb290ZXIgd2hlbiBwb3N0
aW5nIHRvIHB1YmxpYw0KPiBsaXN0cy4gSXQncyBpcnJlbGV2YW50IGhlcmUgYmVjYXVzZSB0aGUg
Y29udGVudCBjYW4ndCBiZSBjb25maWRlbnRpYWwgZHVlIHRvIHRoZQ0KPiB0YXJnZXQgcHVibGlj
IGF1ZGllbmNlLiBUaGlzIG9ubHkgYmxvYXRzIHlvdXIgbWVzc2FnZXMuDQo+IA0KPiBKYW4NCj4g
DQo+IC0tDQo+IFNpZW1lbnMgQUcsIFQgUkRBIElPVA0KPiBDb3Jwb3JhdGUgQ29tcGV0ZW5jZSBD
ZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

--xkSEaDgD8PNUwySISRvt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5592): https://lists.cip-project.org/g/cip-dev/message=
/5592
Mute This Topic: https://lists.cip-project.org/mt/77547893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xkSEaDgD8PNUwySISRvt--
