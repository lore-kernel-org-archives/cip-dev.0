X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.93])
 by mx.groups.io with SMTP id smtpd.web11.2976.1588233573402726965
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2020 00:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intra01.onmicrosoft.com header.s=selector1-intra01-onmicrosoft-com header.b=A7/9XUb+;
 spf=pass (domain: cybertrust.co.jp, ip: 40.107.130.93, mailfrom: masashi.kudo@cybertrust.co.jp)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5/fPSPcs28ncYY9EGR+QESG+HroT1fuPJMiBUYgThwUykZ6AvamwPcc/gxlhIqqvqLYqRHfMUxGONRjgBvPU/4le10dIWYDntiIVp0TI+w3VC/bDWYKU0Gs46duqsbMVIFMjMC+oechdNppecFoV/g33gk2AO606ZgDhvVCu6QvlaJV3ZH85OgITDZr3EWvD0Ud0XYv42NGcnflzD3HYOP7G0u15JTpd3bktqc9SfqyrGtZ277p9RqYPB/7IzEqCbiWEQn2rV50pkrNf+U7sHPtlZUqVPDdjCHt04DpQVBr/0lvdc7hJjS89MHtuM+kB+1kqe2EOOL1cm3UxdtkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDK8C4nIFH8AstSr/ZnnpABFLH9Y5+3c2DIGpS5wDVg=;
 b=Mehdr2DBpALe4/x6b555rME7r/YASEVwmiKWgQQUBwCwKs4lAEF/N37tfJjNaHGX4VNE6S7GYovvevqJ8l+j9gyKBtqROAl5xtso2WZoOIUC9dG+bw72MhF1Vnvq3cn4idbi99YLMc+yWkqLFtLOu9ZIIjkCPQr96SJO3FaiX2rlwisrN3+waUtNvtQxwwsx7sFOSLFVz8euIoDYScYQ6c3p0A0alfcdibNfQ81yD6V2vzC7kWxdCbU7QiH2wNpR7xLS5YrLixXe0j1x61oZpf6HoROCyyspnAiNe0lSmr6zzZ9t0duBkSLRt81UmT4nmjDCe3xfHgh89tVV3irKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDK8C4nIFH8AstSr/ZnnpABFLH9Y5+3c2DIGpS5wDVg=;
 b=A7/9XUb+zKleFax1Rd6aF8JPlZ6/McJKp+7XllPCJ30nAIHNAMS1H5Dw1Mi5O5e87/EDfJC8stu06utcuiJ//0B0AntSxNus/RRZ1UQSm58aK2SN+gewVs7/WjI20igSoQ1KCdTOR207jKMFZSY6nnUGo2PrLu1t52S+iKLAN4c=
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB2457.jpnprd01.prod.outlook.com (20.177.97.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Thu, 30 Apr 2020 07:59:17 +0000
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 07:59:17 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYeii420HEWkZLJTG+HNfuVKCzjngAOb5uQAABLbLA=
Date: Thu, 30 Apr 2020 07:59:17 +0000
Message-ID: 
 <TY2PR01MB497278C2FC9FA3D574DBBA1CA0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497292B5ABFEA4BC5CC874F9A0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSAPR01MB3667B7F6BD8666E1A789657E92AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB3667B7F6BD8666E1A789657E92AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=cybertrust.co.jp;
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed071e88-2fad-4709-5696-08d7ecdc61b0
x-ms-traffictypediagnostic: TY2PR01MB2457:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2457CD18AEA3C2F242A2D439A0AA0@TY2PR01MB2457.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4972.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(33656002)(6916009)(71200400001)(2906002)(9686003)(85182001)(478600001)(966005)(86362001)(5660300002)(55016002)(66946007)(66556008)(66476007)(52536014)(76116006)(53546011)(64756008)(66446008)(8936002)(186003)(6506007)(316002)(26005)(8676002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mDHvPnayw8mtSMO9YefJ6J+t/mR/5eL47+L7IRAH8uDcoFo9kTG6Z3WABY32hKLEb1TlkcTzvZkaMz32t4n9GZD+NkHyYzhkMZNzMh5BbYlNZrEd552A5oOhZ/gvU6yuJ8Xy4KJ3Kf9I6El86NlV00YSCjOp3Gj8n0gAz5y5fYSnnn20dc5EiYLBTm48jrIls7EnVeBsfZbkOoKeS6yoh/r0PzCyxc8lHkRh6lNL6R5bGYU3T2ESoNLCvr+U5vDcg/jXJpEtkod+UkPDSxrZy3lq/mwfLTOT80Hr9YYAUMUOfYU4ejlNf5nFaWQILqINw+DLlv/nFfg85DQp+RNdmv1dAnh+YIjUjZ7R+5ljGDiAgh/chJeC8DCxNn9lCvr9Xu+hlumMVIhFZAFjbJQbDCxIh16TA9MxZfkETtykXH81jsiXjtnZQFyClssWYU+CKz6qHEbZluWeYUNu9UPKbm/7liX1rpcpNAiUU6qje+IabFmftYyLKn+v5ciXDny1D1nWdgzVizvclld+l3I9pw==
x-ms-exchange-antispam-messagedata: 
 jPaquGyBekD1eofLZT4uHN3sWxZzNByAKPEmLpdgCrJxj98z9ocpOi+5DTCSvQeysSz/7A/iPvkkWz8m3PBWElXFYHYnZHOnJ1s2qtFzMR0ZOV+8BlDwQhT4Oqy3Rt9MKxL8HqsAJBlaVVnziGCZoGOQDaPSTK85QQX5ZOOzJyLHjNcYCaVZSLH91ZCFNoDcsXkJiC1SwQ7bde/crl3rdZ3ynt/3ShOsW46kAkRNOwRv4jkpzHFqlzE6Qs2ahhn638JxA3i2vnQRtFf9v6v/91KLQHV4tsNsthRbFjGSNjC6H7w4p0LkcmkJy/cQNmTzcvbqn25maPFfGZofSJX7bXTp9Kl7ebiwtEr5pyHAIolF//TVoa6XkVwjBopeLn5r9e1k+UbL+n7IyAHYnCv2j9CH/5Ld6QoIal8mpJdg3ohYd8x9n+SPEu/SSMUH+IKTVdk3bkYeQZdowlsoNB+ZI0v/gRErdnAhztDyM8j53qsmb+j8aB2wevcY4SOAyGmJ6YzP30NcoO2pBqdayFTV/XrnYJRDaOLDBBWEyy+zGUH8SyaKt9MX3xeio3UguUdkeDvsAtsOxMynldICCqKNdXZC6eFsjBpcDOpsQwfOYm9pQ1PSXfa+3NZHKC0+mFkHnDZQEoI3xAHTCkobP2S7HCIKHmrpJsh//xmoETslMMz8WEtsPN3GgvLr3X1TFAre2lVYBkX3UTlhtyOlLtue0mIZ8NWeYGGMfhj6bBCVb9WuWxYdpQS++SxjbuT7OjH9kai83Ox7FBC4jycdoqS2qhbxi1pLGYKYVGtwwfzzsuM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed071e88-2fad-4709-5696-08d7ecdc61b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 07:59:17.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kZNO1doZU3MJ+9rNzE6YwxMpQ4xGPvfIZZgKLIg2bNrksvXn07hYqXY1tl5H5gsVhHa6jEtpuV0ax7xnc4UDobW0k9sBLpy/WvAJf4qvoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2457
Content-Language: ja-JP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

SGksIEl3YW1hdHN1LXNhbiwNCg0KVGhhbmtzIGZvciB5b3VyIGVtYWlsLg0KVGhlbiwgc3RheSBz
YWZlIGR1cmluZyB0aGlzIGdvbGRlbiB3ZWVrIQ0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vk
bw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2Yg
Tm9idWhpcm8gSXdhbWF0c3UNClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyMCA0OjUzIFBN
DQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLWRl
dl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheQ0KDQpIaSBLdWRvLXNhbiwNCg0KSSBhbSBv
biB2YWNhdGlvbiBhbmQgY2Fubm90IGF0dGVuZCBJUkMgbWVldGluZ3MgdG9kYXkuDQpBbmQgb3Ro
ZXIgVG9zaGliYSBtZW1iZXJzIChEYW5pZWwtc2FuLCBTdXp1a2ktc2FuKSBhcmUgaW4gdGhlIHNh
bWUgc2l0dWF0aW9uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIA0KPiBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YgDQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNv
LmpwDQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAzMCwgMjAyMCA5OjU3IEFNDQo+IFRvOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3
ZWVrbHkgbWVldGluZyB0b2RheQ0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWlu
ZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0
ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90
ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3YXMgcmVzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAw
IA0KPiBzdGFydGluZyBmcm9tIHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nIHRvIFRT
QyBtZWV0aW5nKiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVl
dGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjAmbQ0KPiBvbnRoPTQmZGF5PTMwJmhvdXI9OSZtaW49
MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiAN
Cj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiAwMjowMAkwNTowMAkxMDowMAkxMTowMAkx
NzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2
Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2xvZ3MuYmFz
ZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIwLzA0L2NpcC4yMDIwLTA0LTIzLTA5LjAwDQo+IC5s
b2cuaHRtbA0KPiANCj4gQWdlbmRhOg0KPiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAxLiBDb21iaW5l
IHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBJd2FtYXRzdS1zYW4NCg0K
Tm8gdXBkYXRlLg0KDQo+IDIuIFN0cmVuZ3RoZW4gc3VzdGFpbmFibGUgcHJvY2VzcyB0byBiYWNr
cG9ydCBwYXRjaGVzIGZyb20gDQo+IE1haW5saW5lL0xUUyAtIEtlcm5lbCBUZWFtIDMuIFVwbG9h
ZCBhIGd1aWRlbGluZSBmb3IgcmVmZXJlbmNlIA0KPiBoYXJkd2FyZSBwbGF0Zm9ybSBhZGRpdGlv
biAtIG1hc2FzaGk5MTANCj4gDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSBy
ZXZpZXdkIHY0LjQuMjE5IGFuZCAyMjAuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIENJUCBD
b3JlDQo+ICogU29mdHdhcmUgdXBkYXRlDQo+ICogQ0lQIFNlY3VyaXR5DQo+ICogQU9CDQo+IDEu
IFNvbWUgdG9waWNzIGZyb20gVFNDIGNhbGwNCj4gDQo+IFRoZSBtZWV0aW5nIHdpbGwgdGFrZSAz
MCBtaW4sIGFsdGhvdWdoIGl0IGNhbiBiZSBleHRlbmRlZCB0byBhbiBob3VyIA0KPiBpZiBpdCBt
YWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQgaW4gdGhlIHRvcGljcyBjYW4gc3RheS4gT3Ro
ZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBiZSB0YWtlbiBvZmZsaW5lIG9yIGluIHRoZSBuZXh0IG1l
ZXRpbmcuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8N
Cg0KDQo+IC0tDQo+IE0uIEt1ZG8NCj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

