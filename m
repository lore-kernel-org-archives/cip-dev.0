Return-Path: <SRS0=QDwY=OM=lists.cip-project.org=bounce+64572+6743+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93148C433EF
	for <cip-dev@archiver.kernel.org>; Wed, 22 Sep 2021 20:47:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50A56103C
	for <cip-dev@archiver.kernel.org>; Wed, 22 Sep 2021 20:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C50A56103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oQoEYY4521723x7BQAMYyXuw; Wed, 22 Sep 2021 13:47:45 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.844.1632343663960216818
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Sep 2021 13:47:44 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 18MKle82010897; Thu, 23 Sep 2021 05:47:40 +0900
X-Iguazu-Qid: 34ts0AfxiJlZJ7S8A4
X-Iguazu-QSIG: v=2; s=0; t=1632343660; q=34ts0AfxiJlZJ7S8A4; m=HQ491JvfUlYJqNSYHAfzbvLWS3mBUDY3rfg2bP/D7p8=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 18MKldt5038751
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Sep 2021 05:47:39 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 617B9100109
	for <cip-dev@lists.cip-project.org>; Thu, 23 Sep 2021 05:47:39 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 18MKldAw012492
	for <cip-dev@lists.cip-project.org>; Thu, 23 Sep 2021 05:47:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz9ljlpm8mRbP8HOHeiF7PpMUg7K8E5AOvWffvdMKYCKD28EAVo0NE0yduE13h1dI2OGq05ARvFqeV7pYxZ4lTSwzz5jQcWiGC0B9cMjaILG6EWByyNyYvgY4ndiaOlZhj3PhxfBC20ohYR05W9Bs9cE/lfn09pbHM7NtNa4+AHlB/z90imWiuPpDyJAUBp0R+D3JtF26rKRwtWOP19cyxheb4zmo3aikfvMH9dNkGDuR0F2QORo9N6MfOkhR/r3KGgj9YAHasHfksgq0g9nftMI148lnXMtLWsw5mVjOGZvPQxi95Fth8V707Q+oIHDaOsmfvkufdZ90KBacEc+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+0XwHPm/oW9kUNKhMD4XkdWnobQ0+OIBN8IdHFeQUkI=;
 b=Nifk79Zq8xhE6Tiv1QcoSroNzOk0QfhNyx+Xl/VA/m+YbnUQqAW/7wO3S28jV1QJo8LjOvMMLkJMrNi8ifhwKWEMkwzxoTg6HJTY7sBfS1Sev1e3dbuMIqPsRXhPVrHFTbVlOsl3bs6KbIRA58PM+g74/gAQCH8ZVTMbkqIah/EH4RvmXTOFRIK7cv1OwEIWh0dDs6o8YbZm3+bAFd8zE+hr5R6vJWgYLsztTPUDCwwkYqxvYkM77ps0sVqtu4QajlmU87aPlAltYCEDSYvE4owMo+v/crQBqOkk7z/XQphjkdrM/o38uLTy2C6zeuGKhaD0ih/9mSXwW/QXeSXaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat (2021/09/23)
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
 (2021/09/23)
Thread-Index: Adev8tV8uwOkgAQpRtCVYgB884iwXQ==
Date: Wed, 22 Sep 2021 20:47:37 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252C9E6D9BDABA80B072E4092A29@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a6a036a-4364-4a5e-7cf0-08d97e0a3625
x-ms-traffictypediagnostic: TYCPR01MB7009:
x-microsoft-antispam-prvs: <TYCPR01MB7009AD68FC27847737C2BADE92A29@TYCPR01MB7009.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 8EwNwVhjgK3f/EoMQzLyX2zpqJ+eFmyzxWEtL+C560UYgl3kl8jJiM0B3zlM4gQSEfjxiWgIdl630FVsh+BVpeyajqmxhhaosaU1odEwh/kiaVV94ltb+T837IsT0WG+Gc8jH43CQ345LseOCgKHW23F14hyI/f+zeprpEUPrPer2t1/oM3GQbjotxFDLvYMHvPIfsQwDXe717zLouli0B4MuIkaj6MwuxE3u9UhWCTbcp2cOLjBaUSrCtmACcaZ2kf7Wp5n0dKczXAFqvC1X7M/smLCVZD3PRzILNkZesEQ2K4vrdTzGUMcqvgrMyYJceyyTFm++9fzqOMRKHI0sXrSYUwqma+/TeIQh+rqm5K44GMQE3FNk+6beEVgp2vIlOrnfqFoiTv4YXV2UAVnI+CCHPjrpvnylzstTc108PZhs0w4gMXQs3BzM1K01/eOE0N9SovkUlp5r2sj4sJTdxl5/bnNXiZ0VrQwrBDwMZWdEc4Im4U0szlaGxmcs5UEMlLpXXWFu3FPb9sFAotxbHeW7jTWtWUQyISESKQCG4MpLH4wqVaz2FJ0z3YiUcKpl70qzcRCyBX25SqFEI8rTGDNEqt29AKt7XgPnRXA5fMn7qgMxJWoyHuavTEnOxsqQw2IvhmwWvLoPwXsIxLzCFuhE6opo8bl7hDN/FFD5BUwG+fdHH3w5sISBXSqKnOQTIHhq8TfdIb9umS4nyBY1G+zgbIi7nYhaSX1UBzQedvuHGRFGDO+eYCmR80F244NK8UXpKIbx0Tkz8NVavw67Y9n8ZAWlyHbe4GFwY4AlzQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0tjeEIra09tSHpOdXJJLzhaVCs4bnUzZXZsOS9YL1k3elVWV0xha2IrVTRy?=
 =?utf-8?B?UzJDYWpyK01Zc0RxWWsyTW5RQTlnbFZCbGZxakk4RzRjdnBQcXFQNW1OWE9G?=
 =?utf-8?B?UmRiazVQKzFNNUc2SnlweUNRNXpQcW9ReEVsL1dhUmxTVThEcWJZbzVzenhR?=
 =?utf-8?B?czgvN0hSL0RZQ3VZakJkVUFaU3FIZkVQZjVHUnMxYk8zVkxtNDl3YzVodmI1?=
 =?utf-8?B?QUlJbXhQVUFmTmh5d3hmbS9oSjFKV3JBWjZUTkFILzc4c2RHTWtVblBQYXdR?=
 =?utf-8?B?TVdDaTJIalArdm9mYjFwNVBSMVM4M2ZYUi84SElyeHJJTnY4bVBLaXkzcHdv?=
 =?utf-8?B?T3hvTFR5RC9JWE9RUDA4cFY4c0FpTWpPZ1J1a3lFSjNxRFlHNElVeVNDWHpw?=
 =?utf-8?B?NW1JRFBSUkZVR1NJVC9pQUhjMUlpakF0c05ReUliZTRaOWxOU01FM2V6SHIw?=
 =?utf-8?B?aS9aNWRTbXVNREV1bFplUWlqV0tFVnBJYm9BcGIzWnJjT3o5dWo2U2FQWGRL?=
 =?utf-8?B?eE1TaVp4L0lIOVBieTNJdExGVEx1dGVCTGZ2b0xLSUlod0tKYXJDMFB3dUhS?=
 =?utf-8?B?a21xZlNQRXR0Zml4cnFZaXAyN2IrZmR4Mm5id3prSXlVdjVjSzdZWGMycFI1?=
 =?utf-8?B?Y0EyaDF6ZzVPdnBjd2tpZy9NMS9HNUZmUGwwdWVmSkhZa2lzUFdMZ2dTcy9C?=
 =?utf-8?B?M2JoSGJsVWZnd3ZxU0pmYmxlTlFmMUpqYnR2L1phMEVXbEdIZkxVRmtvdnla?=
 =?utf-8?B?Nkg1RENXU1Jwc0FOQUJFNndmUnhhRVovSWNvMFBsOGFpSERBb1hCSldieiti?=
 =?utf-8?B?R3hWZmZOcHkxY2dCcXAxTWU5ZjVUZ3Ixa1lQZHJhRGdjTnpveXF1bGpCY2JB?=
 =?utf-8?B?MlpGUldxRDF3WHpyWWhSOWY4YnhwRUVwRFFnQnhMQm9KKzRSWjVNVTRJbkhn?=
 =?utf-8?B?TzIrbk5OeUdFRk4yWEsrSkk2Q1NodzZQNE93c1Znd0FSNmxyaWZjL1h0K3Bn?=
 =?utf-8?B?NHNhNGhVek9rUE52UWdLQS85TGFsWm1NNVQ2WHovZUJzUGpYMTd6REhqbnlh?=
 =?utf-8?B?RDlEbE9adWY4eU9ZNGdqY0hVaTg0dDVUNFRRWFc3RGRtKzFLdERKeG0zaUNX?=
 =?utf-8?B?R1d6Y1dTVDFMeEZCR1VPa2JPd3h2U3hKS0lkdGxvWkllYzJvUGFXMDludXVa?=
 =?utf-8?B?VERsbldkUEFSMXduNE5PRFdhUzJyd28xc0Q1S2FJQXBia0FNODBhZmRJVjUw?=
 =?utf-8?B?cHplZlhUMnVoRmZ4L0h1bUQzZVJkRW5GQlJVZWkzYU5Za1lnT1hRaVVhN3U2?=
 =?utf-8?B?dVgzekM4Nno4SDlNRldUUVZZbjNLTThLRFVQeDE4a0I2amwzeG1KU0wxMWR5?=
 =?utf-8?B?QUk3SVZUclh0b0t3dnJnYWxQWkUzUTdhWUl1L1N2d2V4ZjRnb2JKVUM0VUhX?=
 =?utf-8?B?Z2VpWmZNY0ZGdmhoSjZHL3g5aksrQXoveVgvZ0pHdGVyeDMzbDBNaFdPRU1p?=
 =?utf-8?B?S3Y4RENaWHJJelErQ3A2R0NHQ2ozYU92TWtTMDZRYUxTR3krTEJuUFFpdWRZ?=
 =?utf-8?B?MXZFR0YrRTJkenNEekd5Q2kySUNKSzVpekwwZGNNRDFEMEQvUTFiWE5NYkVB?=
 =?utf-8?B?c3lDUG1CM3NmOXVGandGWEZEeFhscVh5SG1lanVyYzArYnhkSXRDNjlvek55?=
 =?utf-8?B?Wm9qak9XWGNidU4vY2JKWTM3eUZ0a3B2UmlmWW9Rc2xOTDAvM2VZaEpORVdv?=
 =?utf-8?Q?5TEx7tBSSk1haF6oTN5Sq4/HpT5DTBmqpR33WJk?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6a036a-4364-4a5e-7cf0-08d97e0a3625
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 20:47:37.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYvvI79L2BVH/usjdWgdjmZFU0ZMTQW9HnGntpFr1CrBKGdVt7Xn5wuw+CvGEdrXv+Zh1HCG0yRrl5CgRdRXiT0YtN+qs8uMld/y0Aog4OF1CoSUrrWU4zYF9KNfflGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7009
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
X-Gm-Message-State: XiadxtFk0MgcdPlCImsn8NMhx4520388AA=
Content-Type: multipart/mixed; boundary="SA3YUZVfnaiP8zdZW0WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632343665;
 bh=aVA94hYY2TRKhIj9SrYZ8aMhJihyJoXyPVwgNFenO8E=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DdFb/OqS2SGBPdntj6im3NrEARdyCZQKOkX3Lhx7jElCUH/KKCKN9re4pCdj+lUo3q9
 QNAJjOzd6ZtLau7V73C1JlezLlHUhHTIt9sOE8lVUAZV77zgrtLYr9JFC0mOn08Dz6y8P
 LkTh+WO3mCAoqPZuNYGQiH6ULSolAcVaCKU=

--SA3YUZVfnaiP8zdZW0WA
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGlu
ZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQp0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5l
bCB0b2RheS4NCg0KUGxlYXNlIG5vdGUgdGhhdCB3ZSBtb3ZlZCBmcm9tIEZyZWVub2RlIHRvIGxp
YmVyYS5jaGF0LiBPdXIgY2hhbm5lbCBpcw0KdGhlIGZvbGxvd2luZzoNCg0KICAgIGlyYzppcmMu
bGliZXJhLmNoYXQ6NjY2Ny9jaXANCg0KRnVydGhlcm1vcmUgbm90ZSB0aGF0IHRoZSBJUkMgbWVl
dGluZyBpcyBub3cgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMzowMDoNCg0KaHR0cHM6Ly93d3cu
dGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjEm
bW9udGg9OSZkYXk9MTYmaG91cj0xMyZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZw
ND0zNyZwNT0yNDEmcDY9MjQ4DQoNClVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAg
ICAgICBUVyAgICAgICAgSlANCjA2OjAwICAgICAwOTowMCAgICAgMTQ6MDAgICAgIDE1OjAwICAg
ICAyMTowMCAgICAgMjI6MDANCg0KTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQoNCmh0dHBzOi8vaXJj
bG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjEvMDkvY2lwLjIwMjEtMDktMTYtMTMu
MDEudHh0DQoNCiogQWN0aW9uIGl0ZW0NCiAgMS4gQ29tYmluZSByb290IGZpbGVzeXN0ZW0gd2l0
aCBrc2VsZnRlc3QgYmluYXJ5IC0gaXdhbWF0c3UgJiBhbGljZWYNCiAgMi4gRG9jdW1lbnQgbmV3
IExBVkEgZG9tYWlucyBpbiB3aWtpIC0gcGF0ZXJzb25jDQoNCiogS2VybmVsIG1haW50ZW5hbmNl
IHVwZGF0ZXMNCiogS2VybmVsIHRlc3RpbmcNCiogQU9CDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9i
dWhpcm8NCg==


--SA3YUZVfnaiP8zdZW0WA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6743): https://lists.cip-project.org/g/cip-dev/message/=
6743
Mute This Topic: https://lists.cip-project.org/mt/85799944/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SA3YUZVfnaiP8zdZW0WA--
