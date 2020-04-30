X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.3498.1588237097228082259
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2020 01:58:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 03U8w7w9032189; Thu, 30 Apr 2020 17:58:07 +0900
X-Iguazu-Qid: 2wHHidEfDNRTolmHie
X-Iguazu-QSIG: v=2; s=0; t=1588237087; q=2wHHidEfDNRTolmHie; m=sTPOpgOTjXFvBoDShy3HBu9WQNY8p3g2FVeFhtjDdVs=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 03U8w5iV024244;
	Thu, 30 Apr 2020 17:58:06 +0900
Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 03U8w5hj022502;
	Thu, 30 Apr 2020 17:58:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 03U8w5C2009182;
	Thu, 30 Apr 2020 17:58:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiV8pmhwiJYeyofOGHtYGATTTMa1hB6h/GAW8fEd6qpHlky3ILe4QF9G88SPH+Uegwsj9yU8TaT6iNlwi8uJ8UR+sYJ1k8UIe2Ys+scUGG9VjRrEPdHqirlljlukdn3uwxTglRbNZeJ08r/nRqN9mts4Cq5T6fRLIZam91E/GSlz6RbJ7Jak3TIs0fb34ZVsK5qAn1rGFRpm+9zYxnygAEG6rMLzNpqRgnwlPWQ3T79LHZAUN0FzLn3nd4kcWgkIOHK+9UWKcanc4idtiIdqdSqexBLvF4NF9B++gVlutD9XFPc5rVfJ6XlIDJr6vOEuvSBDyS7hJZRTHF2hXR5hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikUWsMzmZj2dZQB9Do5lfnSw7ue8xr3Phb7ouyE3sNg=;
 b=HxcO18vH7kajJJhOamTbg7k8F6i3LPO9vFC68iNbmVkJIXIFhWHQhiRkRR5scLjuqGuWL2rUcFgEbxvv64gdj9bfc4qNrQA3REHDA7+R5cUVTJlcUSUTIJzP5nCFbsCNs6zoA9VV+oYzYg9cavK0newEmT63S9a3NZfWsIP++JY1HYY+TP/bHf6hYwCdRnP6PeODiC0JAdbbMIBk5UM4Rbrt/ebEfDbEYfrCeUnpKHYhy0u/JrOpYN79XTBGgW2KllokuC9mMBf7EF+XVPb+/lwC4MmiurGvoGAmWuDp5gLRmF1mLmvglccksrP6fusXSFs8R6p5TQKEbYfUzzxzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <JohnsonCH.Chen@moxa.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported driver
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported
 driver
Thread-Index: AdYenvv3s7SU2aaJQLW/83AlIfO9iwALioEw
Date: Thu, 30 Apr 2020 08:58:02 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667E8AE3A76EB13D1C03BF292AA0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <HK2PR01MB32811FA86BAC56B8CDA4B1B7FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
In-Reply-To: <HK2PR01MB32811FA86BAC56B8CDA4B1B7FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, en-US
authentication-results: moxa.com; dkim=none (message not signed)
 header.d=none;moxa.com; dmarc=none action=none header.from=toshiba.co.jp;
x-originating-ip: [2405:6581:5360:1800:18a5:7534:3f8d:363f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8286826a-21aa-46d2-f4a6-08d7ece4973e
x-ms-traffictypediagnostic: OSAPR01MB4033:
x-microsoft-antispam-prvs: <OSAPR01MB40334FAB3BD050BCB6E7F52892AA0@OSAPR01MB4033.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3667.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(8936002)(76116006)(9686003)(52536014)(66946007)(33656002)(66556008)(66476007)(55016002)(478600001)(66446008)(64756008)(53546011)(8676002)(186003)(2906002)(6506007)(7696005)(316002)(5660300002)(86362001)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOoQxnDsdK/FfTjsZ7dF+CJZ6qvbKGEHyTtTE6pZLLFyxRxwYaNzheESDaxtCng4xetjJpC2/RdGZG34Xo/QXP3Ar8O42QZWCpFmF/xDGQd4zELck67wtCuQ91hwP3054CYKwgkq/VLwJgn/i0giY23wfq0LsKp2Ui2Zcw2lyjer1xFvnbP8AmsRtZkz5PMFcvzUBM4DrQir40mqvIqCe6drAs7fAvJEfKKsIUa3NpdW3tKIrOTsqwJCF5nhu2OE/lXYXcgdQdWPexKljuUaaccoaMmU2zP2rwWs9CikVxx6yGjoW5gQNs2XjvPaJByOzeeWFd5Ul6wE5ZwGhlumxVAtVZkm0JRReP+vviVne7drlXFWewC2XdT0MDsh2kvrKedfpDjys5sgIPsOSoPxzU9qDemyRIMOiP6WoXkXMT7juTyziRxZLjJqCAjjWuVJ
x-ms-exchange-antispam-messagedata: 1q05O4G/tVyVBL/2chU21PN2M3h6vtZyBzzu4KXpKg8tYRmFMXPW/ZSsLmPwi4Qo5h7SMjxnOXZAcIr1Bi1dV4A0qy9gHh1T4dvoVVF254ftl/eVPDRI0Weq2bOFIRMeS5M80q0QqWKhf/uDRFXVmplA0V7igTj1EdjwSUsERJwjnCldDCF6b+VN9dIcuDr4rolUbCzbYGYqAhZ55k3GilTi/c3YDPXiTAlyVYKHmHR1+wIBL/Ec3umKejgUGVCOwcel+W/TMAcuPRx9ynZYPIMIO+1m7mktqC6NiXTe3WDpr/zTELblUTvmMlPNyFuIXotMY++QuCCZKwFegSVpB/EMHuxQ27pWwFnysR69M4pvkNDTxPNOJ89ISToaEwTR3vQ9kA+YnNJWsNEvetu/bmeAgR/NJIR2hjBNzb7w64YzHqz2fRC7LVl9v1UKXy9d/JDmGKpZLWVpZ7eDEaSx0z55cKPAcY20JB8/P6DO7liMS7qlRsnHbhYyrJfgn2nWLGx1qQdrpCJ6HFnJqg27kiUI0uS7Iv5ZxQWYFf9SmMQW/ZD5U6H0oJt4FcWYSJFl8ax4cwg8aZzfCFD7T/DfuhL7wGfOrfZPt8X60cpoCzFnz83RAwWfGRPe7hNHANUpzBITq9S9LTRZsGqJVZeKbAeRmPGC9qTD6uiM1r+CaJFMLAmYoarp7D00YxZAiKPY1MM3CGbAyWgdU0xYY3HOW+tdS9SR1Pu48B3nSGZTlYLK8RH1BHay/3iMiDeGAwKIxqkcTjTG8WpyjWNuNn62K5xy2AiX6o9Dypx2fq7mOZJBErm5vf5W2mrvt9FGl1smm6/PpmCvIRD+6AO2n8Di2Fg9CsDTYNf243811X/5KeL35Yl1YfIcCGjRSppUCyUY
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8286826a-21aa-46d2-f4a6-08d7ece4973e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 08:58:02.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaZ5aiyczstwxJahdqt/VdP3o3S0wUvC6DP0oO25btKSEFt0upv+yiOxu4F0uZnTH55enwXTpEyTnGIQepsxCagADSG/LlzTn9ZqRB0Cax3jcJQS/aqG13jyfp06vDiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4033
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>

SGkgSm9obnNvbiBDSCBDaGVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEpvaG5zb24gQ0ggQ2hlbiAo6Zmz5pit5YuzKSBbbWFpbHRvOkpvaG5zb25DSC5DaGVuQG1v
eGEuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMjAgMTI6MzMgUE0NCj4gVG86
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g
5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPjsgcGF2ZWxAZGVueC5kZQ0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW1BBVENI
IDQuNC55LWNpcCAwLzNdIEFkZCBUSSBDUFVGcmVxL09QUCBody1zdXBwb3J0ZWQgZHJpdmVyDQo+
IA0KPiBUaGUgcGF0Y2ggc2VyaWVzIHN1cHBvcnQgVEkgQ1BVRnJlcS9PUFAgaHctc3VwcG9ydGVk
IGRyaXZlciB0aGF0IGlzIHJlcXVpcmVkDQo+IGZvciBjcHVmcmVxIHN1cHBvcnQgb24gQU0zMzV4
LCBBTTQzN3gsIERSQTd4LCBhbmQgQU01N3ggcGxhdGZvcm1zLiBCZXNpZGVzLA0KPiBvcHAtc3Vw
cG9ydGVkLWh3IGFsbG93cyBhIHBsYXRmb3JtIHRvIGVuYWJsZSBPUFBzIGJhc2VkIG9uIHRoZSB2
ZXJzaW9uIG9mIHRoZQ0KPiBoYXJkd2FyZSB0aGV5IGFyZSB1c2VkIGZvci4NCj4gDQo+IFRlc3Rl
ZCBvbiBNT1hBIFVDLTgxMDBBLU1FIHRoYXQgdXNlcyBBTTMzNXgncyBTb0Mgd2UgaGF2ZSBpbiBo
b3VzZS4NCj4gDQo+IERhdmUgR2VybGFjaCAoMSk6DQo+ICAgY3B1ZnJlcTogdGk6IEFkZCBjcHVm
cmVxIGRyaXZlciB0byBkZXRlcm1pbmUgYXZhaWxhYmxlIE9QUHMgYXQgcnVudGltZQ0KPiANCj4g
VmlyZXNoIEt1bWFyICgyKToNCj4gICBQTSAvIE9QUDogQWRkICJvcHAtc3VwcG9ydGVkLWh3IiBi
aW5kaW5nDQo+ICAgUE0gLyBPUFA6IFBhcnNlICdvcHAtc3VwcG9ydGVkLWh3JyBiaW5kaW5nDQoN
Ckxvb2tzIGdvb2QgdG8gbWUuDQpJZiB0aGVyZSBpcyBubyBvcGluaW9uLCBJIHdpbGwgYXBwbHkg
dGhpcyBzZXJpZXMuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCj4gDQo+ICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvb3BwL29wcC50eHQgfCAgNjUgKysrKysrDQo+ICBk
cml2ZXJzL2Jhc2UvcG93ZXIvb3BwL2NvcmUuYyAgICAgICAgICAgICAgICAgfCAxNDkgKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvYmFzZS9wb3dlci9vcHAvb3BwLmggICAgICAgICAgICAgICAg
ICB8ICAgNiArDQo+ICBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICAgICAgICAgICAg
ICAgfCAgMTEgKysNCj4gIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2NwdWZyZXEvdGktY3B1ZnJlcS5jICAgICAgICAgICAg
ICAgICAgfCAyNzIgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgv
cG1fb3BwLmggICAgICAgICAgICAgICAgICAgICAgICB8ICAyMCArKw0KPiAgNyBmaWxlcyBjaGFu
Z2VkLCA1MjQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3B1
ZnJlcS90aS1jcHVmcmVxLmMNCj4gDQo+IC0tDQo+IDIuMTEuMA0KDQo=

