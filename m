Return-Path: <SRS0=T3wK=NG=lists.cip-project.org=bounce+64572+6679+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77988C4338F
	for <cip-dev@archiver.kernel.org>; Sun, 15 Aug 2021 23:15:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEEB61261
	for <cip-dev@archiver.kernel.org>; Sun, 15 Aug 2021 23:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAEEB61261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KuIuYY4521723x2gu9GAtrUR; Sun, 15 Aug 2021 16:15:16 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web08.17355.1629069313274570208
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Aug 2021 16:15:15 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 17FNF9CX022676; Mon, 16 Aug 2021 08:15:09 +0900
X-Iguazu-Qid: 2wHHtYwhiH8iep3sfY
X-Iguazu-QSIG: v=2; s=0; t=1629069309; q=2wHHtYwhiH8iep3sfY; m=MbWUpgtMy0qs8nkSOP8VFvrpVCp3Rxh17XrhKbBHI4g=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 17FNF87t024499
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Aug 2021 08:15:08 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 138641000CD;
	Mon, 16 Aug 2021 08:15:08 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 17FNF7Qn018276;
	Mon, 16 Aug 2021 08:15:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz41uBpdn0CDxOwfcx5QLGYfizEnEnfeexf0vYMLppBe+1O+j40QUHG92g0y7CLEuBV9VCDSiSydI4UlArn4/nrpYnv8SN0EjC4y5nBJxEnFCbaKK3FqOHkw/r7/7YggJmSJi4ycHDSPBkgALTM7idMs+2//W/fP179kFXWmy5wxH+y6pg/0d84mTVzKg6sJ1rBIRf5ovSDvvjevcAgIzSF/V9nf+LTOTISU+ND7H3q32s2ci0jXsdJIQds5MI9VS9Kz7pI9yvUO92fu5cGlqjr+rbpEv17YPljBy98YNKfnhEiWRwEJmxjhjWcV3DHhhI+pkQbRzQjgl6T/PsMWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiIZUWq1vUOVeBs7XCbLm/iWFoFdTWvFuuZuwS2JzE4=;
 b=bdT7ggMIVFtKfV5k+yGXMSJmkl953h5Jzp2hVgbwPQgvYcwA8bmw1fgZ9X/+T+aY8D8nEWEEv3/dRX/0qRrpBRyz15CpZP9+AQDvkyjTB/DwfWhgxVU7b9fbrEG8QjrREqODjASfxPB7XfGNWhxMIUCqnkzwRTyJSbni6R24KfevxiJ1kc3LpYgtMRi6kdtjXzxDv6Iy54cMR9Q3v5l5VKAchxCuYQYZAOlBuxQUtQR2DFEzqdQGjGBh74a823swUTEX6Kdd35jboHEswUCIC8Bdn9Ki/Bo4imEcWUeqVcwq3z7f2cG3KnnD9T1OzI6NqI24/HGpNbcbIdSOTXGzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: [cip-dev] -stable-rc tests failing
Thread-Index: AQHXjnvAnZW454Fq80SVq3nBye0P7att8bMAgAPpLoCAA14i0A==
Date: Sun, 15 Aug 2021 23:15:05 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62529F6AAF0B05B25FD8DFB292FC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210811063943.GA23723@duo.ucw.cz>
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20210813194635.GB23237@duo.ucw.cz>
In-Reply-To: <20210813194635.GB23237@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d0d3e9-725d-43c5-b76e-08d9604284af
x-ms-traffictypediagnostic: TYCPR01MB6351:
x-microsoft-antispam-prvs: <TYCPR01MB6351AD5DCF46A7EF8442D20E92FC9@TYCPR01MB6351.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: tdsVwY2VKnG/SHDjG8PYpKj5C6pZzVZjFzJk5u6XSndWaj39FGqNTyax39v1oBYO6lAQwqiiHZaFsq7AT05KtWETjkrUjjJz1Mmh3LFR8/QKDVlr0vbAvBheA/xNo+LBOjMNvw7dwGbEmrxZDR4PxmGq8nZiI+UAUn9I9mm4NqCTdNgjR41Xx16OOFqA+dEWXp9n4JmNe48dElAylscSBcI57TU6Sx2F/t7KvJPmkE+EnAdMBRG4xrYSk+j36m6NxYqpRoN9osj8tP1WdM0yJKbj/aXczO5EvA/UzHD2jcex6PATndFnTbrkSzSm5DbvxxAQpqeMpccAmRAaHvhu3v/tPgEEkWPztCQhElMsnUa8ZsXEki+NDRcwFFkLwr/mgNQ10syVPT8BEdbHITDlSz+c02hdIlRnTUqM9L0veMijTHhv7Ps6bp3XiyK4Ov3UzeixDZsG2QcFildCp11BP+Wdk/JXE7sG5iBKCCqIyz0WenLwevWLKWw5Y7+lOfaWL6eT2it+Q1J7p/KVciMeOgOAicMyghf21X/D3ZhIvLkPlvPv5SIPcmy/1GwKD20dXvdUEVEEJAwPFOx/RK8o0/HhhkUxrzoHFEU7npXfcVTX2NwFnReIG2nISxVb1t6EglJei3YPgUZ/CFPynyawv9I8fn03ras4AMZ9H7CQgazNRtXounZnGIrkZq1Z4EUXtH9v1puTGZ1skWSac5IaWVgcMikiy3JJ7lLQ5LM9fPdI07JYiQNazBAUPvbJ4eOW9ywxYUJuDyem1OcpU5ogLPr8iDnhXfuzoGeIRcitF9bIhOADBjfSrON0u5Roib4Oc8raASds6U6/jsWFXvQtTA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZObDllbjcxeStERTl3TXY2d3ByamwrbElENm1WMUNNRE15SEhVT2Qrbitn?=
 =?utf-8?B?SWpDWUdvUmt5Y0l6ZEJuK2N0VzRkQm9kclJOTFgvMFpFY1c4cUJHeTQ4MTJ2?=
 =?utf-8?B?VVNsZDAzUmFqUGVvTUVKZFliOVBlKzhBK3hhck9INDQvaG9Yb09kOXhibVky?=
 =?utf-8?B?alE3OFNBNFozWlJtUlhIendRaGtNc0pESWloQ2dWZXBTOVBJT0wySjlqY1Ji?=
 =?utf-8?B?ODl3WlUzSVAvb3RINGNvZnhLTVJPVUllZnhpYnhhd2JjNjNkSktKUnhlNitZ?=
 =?utf-8?B?dnBWTmhSaDFVd1Q3U1NDSGFxaytCYnlXMVFWYUZMWitiUkM3ZTM4RlVNUXRO?=
 =?utf-8?B?T2YyaGVTL1RTTGxPeFdnbzMyUDdtUlZrdWJ4bXRyUjJnTGljMGh5UE1ZcVM5?=
 =?utf-8?B?K1lWelllVmhMcFJjYXFUYjF6d21RM2ZYU09pczVXM05oOFJTbEFkVFNubUZm?=
 =?utf-8?B?YkJreXNxZzNsRWhXeE1odlg5cDh4OVY3TGVyMVpKVFhlQjZ1dDFHajMrNVkv?=
 =?utf-8?B?WUdjZnFrSGRPQkplQ0NvRkdmZHNhZ0FHMnE0aU9mRzhOWXlpb3QvR1V3YWt5?=
 =?utf-8?B?bDdGWjBSSGNLVGd5ejBVZU92NEtCUkNkc2p3ODVicFAvY0o1cjBQWUFTZitL?=
 =?utf-8?B?ZDlaT0d5TldkRDJlTzU4Y2prb09hNnFNK1ZzY3B0dzFvNUdFT09NVXV4TGVD?=
 =?utf-8?B?NEpSWWRTaTZyVTNMaVpESUJlZlFMelNVbENHWmE1VmgrY083dk1iK2FaZlZ1?=
 =?utf-8?B?ejcyS2VoWWlKSXQvdVEzdVBxTWdNSUZobUdiSDI0Mk5KdlU1VHJjdkVJZ2tJ?=
 =?utf-8?B?VHZnU3k0V1BUZlh5TmhMVHllYjBTT3dxaERvaG0vYmNRTmRPVHlobWZ6M3Fr?=
 =?utf-8?B?eFNUTVR6TVc4eERnb2FBVVY4bUpuVG5GelFSRUFSbG85Y2kvazBobm04UjhR?=
 =?utf-8?B?OU1ndzhtUWQ5UHRyWTEvSm52VUw4US81QnRrUXRWR3dlemV6WVZGTms3QTdm?=
 =?utf-8?B?cW1MQW00UzlBeUQ0cGdCN0k0NXVyRElxOElITlV4bWhiYXVFL0d2NXR5Tjl2?=
 =?utf-8?B?RnJEdjV2bU5hWFdlY1ZCeE1iVnFjSE1NZnNZQkV4c2dPOWpIR3llVjFQU3pZ?=
 =?utf-8?B?QmlNRmxrU0V4dTV0dWQ3aDZsdVZMTGtaZlEyUDFLSGtOVmJNRU9iOXdsYmR4?=
 =?utf-8?B?UUNRZjcyTytwR3R3WER2VUEyYkYvUGdCMGVJK2VYa1k5WkxGN2MzMnI3bitD?=
 =?utf-8?B?WFdIS0ZCc281QWorV080eFdNZ2Q5aWl3eUdGVjNFWHNSTFMxQTk4SHVJM1lp?=
 =?utf-8?B?dHFpUFkzam9wM0R1MUMvR2U5aU9HOUx0ZEdDTUVWNUZxOVJwQis4aUE4dFFz?=
 =?utf-8?B?OGNlK0NwZlV4TnQvTE1tRFJKVFNYWlo0bkRueWVDZDF1T0luME9rdEg5b1F1?=
 =?utf-8?B?UVFSUHBrR3kvd0VJU0x3TmFvV3BJbE5PaVdCQTY4Z0tFTFJabmF1QWx4Tnox?=
 =?utf-8?B?d3FyYzNwNXp5V1FHR09PTFprMmkrUVlxK0FieitzUitpeUxTQnhyZjhjQ29z?=
 =?utf-8?B?Mmd0Y0xrMW15QXpSemdRZlp6c3NuaXRZazl5UTFUN1hHeXdSV1ZrUjdmWW1B?=
 =?utf-8?B?Y2VTYkZtTFFkZFllTisrcHhnRU4ySGZZNXZVYW5lOC9ub2RzN1Y3UDdtR1hL?=
 =?utf-8?B?NjlhSEk0Yml0TGhOTmZKQlNmZ1RLbHhXMVl6a3EwRGZBSXh0MG5ZM3Z2a1J6?=
 =?utf-8?Q?aEIzHSARxP11NpAJa3LUxaU62HhC7d3rwMSvzSj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d0d3e9-725d-43c5-b76e-08d9604284af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2021 23:15:05.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzzPPa75sV/WlV+VY0zFB8hbFkGejo6p+SiwXEekpZoVfPYVU4isvIcdK6V/OX4w9i21U/0NnuvTWs/jYYW96xDWVRlWoYI8ZV93Hvor95ZmVZnesqssaRitxDUvOUWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6351
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Z2FEgbqh7lI6f9jZcNOMLipXx4520388AA=
Content-Type: multipart/mixed; boundary="mMSBR8y0ca7iHYfUV05N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629069316;
 bh=+qiFIITNDjjGSPIeVwsNDpRl1Usdjtr/WCjropR0P5w=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=P55PDBJ0fY0sQI6mRuYTsyByZOfZKvXMv/DxHHwVlSCsJZepU7ww741IrVoUZYf0TAz
 03gtGNLHV8QjGR0KSa4CyngKPCYTbZ528ZHOwcLcLV5MDuxdkZFnoU2kyh+pojEM375BS
 C/W+E+FSQAgLGY7alROJo7y31iXfR0zcoA8=

--mMSBR8y0ca7iHYfUV05N
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDE0LCAy
MDIxIDQ6NDcgQU0NCj4gVG86IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNh
cy5jb20+DQo+IENjOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIC1zdGFibGUtcmMgdGVz
dHMgZmFpbGluZw0KPiANCj4gSGkhDQo+IA0KPiA+ID4gV0FSTklORzogUmV0cnlpbmcuLi7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlcnJvcj1pbnZhbGlkIGFyZ3VtZW50DQo+ID4gPiAyMTcwRVJST1I6IERvd25sb2FkaW5nIGFy
dGlmYWN0cyBmcm9tIGNvb3JkaW5hdG9yLi4uIGVycm9yIGNvdWxkbid0IGV4ZWN1dGUNCj4gPiA+
IEdFVCBhZ2FpbnN0IGh0dHBzOi8vZ2l0bGFiLmNvbS9hcGkvdjQvam9icy8xNDkyOTAxNjEyL2Fy
dGlmYWN0cz86IEdldA0KPiA+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2FwaS92NC9qb2JzLzE0OTI5
MDE2MTIvYXJ0aWZhY3RzPzogZGlhbCB0Y3A6IGkvbyB0aW1lb3V0DQo+ID4gPiBpZD0xNDkyOTAx
NjEyIHRva2VuPTlnTkdzdWFaDQo+ID4gPiAyMTcxRkFUQUw6IGludmFsaWQgYXJndW1lbnQNCj4g
PiA+IDIxNzMNCj4gPiA+IFVwbG9hZGluZyBhcnRpZmFjdHMgZm9yIGZhaWxlZCBqb2INCj4gPiA+
DQo+ID4gPiBCdXQgSSBkb24ndCB1c3VhbGx5IHNlZSB0aGlzIG9uZToNCj4gPiA+DQo+ID4gPiBo
dHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtc3RhYmxlLXJj
LWNpLy0NCj4gPiA+IC9qb2JzLzE0OTI5MDE2NjANCj4gPiA+DQo+ID4gPiBKb2IgIzM3MTYxNjog
U3VibWl0dGVkDQo+ID4gPiAyMTlIZWFsdGg6IFVua25vd24NCj4gPiA+IDIyMERldmljZSBUeXBl
OiByOGE3NzQzLWl3ZzIwZC1xNw0KPiA+ID4gMjIxRGV2aWNlOiBOb25lDQo+ID4gPiAyMjJUZXN0
OiBib290DQo+ID4gPiAyMjNVUkw6IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVs
ZXIvam9iLzM3MTYxNg0KPiA+ID4gMjI0DQo+ID4gPiAyMjZFUlJPUjogSm9iIGZhaWxlZDogZXhl
Y3V0aW9uIHRvb2sgbG9uZ2VyIHRoYW4gMmgwbTBzIHNlY29uZHMNCj4gPg0KPiA+IEl0IGxvb2tz
IGxpa2UgdGhlIExBVkEgc2VydmVyIGhhcyBzdG9wcGVkIHByb2Nlc3Npbmcgam9icy4gT3VyIHF1
ZXVlIGhhcyBiZWNvbWUgdmVyeSBsYXJnZSENCj4gPiBJJ2xsIGhhdmUgdG8gc2VlIHdoYXQgZGll
ZCBhbmQgbm8gZG91YnQgcmVib290IGl0IGFuZCB0aGUgbGFicy4NCj4gPg0KPiA+IFNvcnJ5IGZv
ciB0aGUgcGFpbi4NCj4gDQo+IFRoYW5rIHlvdSwgaXQgc2VlbXMgdG8gYmUgYmV0dGVyIG5vdywg
YW5kIGl0IGxvb2tzIGxpa2UgY3RqX3p5bnFtcCBpcw0KPiBhdmFpbGFibGUsIHRvbyAoSSBoYXZl
IG5vdCB5ZXQgc2VlbiBzdWNjZXNzZnVsIHRlc3QsIGJ1dCBpdCBhdCBsZWFzdA0KPiB0cmllcyku
DQo+IA0KPiBCdXQgSSBzdGlsbCBzZWUgcHJvYmxlbXMgd2l0aCB4ODZfcWVtdS4uLiB0aGUgIjJo
IHRpbWVvdXQiLg0KDQpRRU1VJ3MgcXVldWUgaXMgZnVsbC4gQW5kIFFFTVUgb2YgZWFjaCBsYWIg
aXMgbm90IHdvcmtpbmcgYW5kIGl0IHNlZW1zDQp0aGF0IGl0IGNhbiBub3QgYmUgcHJvY2Vzc2Vk
IGNvcnJlY3RseS4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


--mMSBR8y0ca7iHYfUV05N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6679): https://lists.cip-project.org/g/cip-dev/message/=
6679
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mMSBR8y0ca7iHYfUV05N--
