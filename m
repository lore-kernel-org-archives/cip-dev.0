Return-Path: <SRS0=IYyo=DI=lists.cip-project.org=bounce+64572+5490+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D188CC4727C
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 09:39:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1A02087D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 09:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L4fIFOv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1A02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5490+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Pda0YY4521723xBwRenuHhSX; Thu, 01 Oct 2020 02:39:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.8698.1601545173977889714
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2020 02:39:35 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0919dVcW015577; Thu, 1 Oct 2020 18:39:31 +0900
X-Iguazu-Qid: 34trJE3d6hYU2jBJOp
X-Iguazu-QSIG: v=2; s=0; t=1601545170; q=34trJE3d6hYU2jBJOp; m=nX6lgT0YQnNjrQp/c+tUPzWk3LYNTfXKU4LwoaGMaeE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0919dTFr012318;
	Thu, 1 Oct 2020 18:39:30 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0919dTZl001490;
	Thu, 1 Oct 2020 18:39:29 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0919dTvY026668;
	Thu, 1 Oct 2020 18:39:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyUJnLia9Vg8Lql/j7Rumje9zMlrIG6darT1wPtJfWCcVbH7kjfaJgJNY9mL2bGNOqolRYH55wOeqbaehK7FpMaW1NlXloEp6ZUXRqBXIx4c3gTQBzG6bTGcnDKchNC88qIryU4t5/0Y4Jl9NFOZ8bCzKU60bszDSAbOdCIAEZ37jEHc3XycZY7Hl04ctkH47HSI26/2WwX1k+EIx0dnI1rv7ZGuY/PSc04oAUBjQ2gsDD2/ST+1FZbYtvcMiLGkMhgIIZBxeEkbAw+Gl3looLViQpfbGdrpABij2sZ5GwjnL4lmrOjzzsQT87fsdlHsPFKVI+J3DZ9gHvIGiXiVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoEo9BeH2jf+3fWbQig5458MOkFr5SN4cOf7EIkHmUI=;
 b=ZoBFKQkMfkkvvnYt9XDJjjGhhlr5AU+wb8zVSrtyubzvSy8KXInRmXiPdjDr6KvNtewFUjsmxCSSCzwe0GnS4E20WrPQbxRAcKa1eVMSJFjfSdP6vsaCzwsf2ZrE1LV4/rk+vtHhH3KjEeUo3VSX7guXFsv0pSmt6AjFkzgbYkkUcvJaV23XQCBM90X5+jEEBRVx47lfaDXlEbVoCLrQTo08Xu2OWj8i/ljPr6v/3W5TmtEQzHHj5RxiyOfOrWqfSTayV9zdDrowoKVGnmP5QB6f2MtYjlQdw7GB2+7q/h6lPV0kUcxUDZkPwY7EjAZMEgP5dwo/OyBwWL1MvaDgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Topic: [cip-dev] Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Index: AdaNw7es631AlWmyTOq25QxHZpRfCwAHn2aAAAqW75ACchvH0A==
Date: Thu, 1 Oct 2020 09:39:26 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29833C0DA59C4F77B159DE2492300@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB49720A7CA0EC8E349A473CFFA03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <3d774462-6c19-a68a-7101-0183c1c9467d@siemens.com>
 <TY2PR01MB4972E6442E2A10765AF7EBC4A03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972E6442E2A10765AF7EBC4A03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0243cf39-606a-4b9f-f391-08d865ede353
x-ms-traffictypediagnostic: OSYPR01MB5400:
x-microsoft-antispam-prvs: <OSYPR01MB540086E7CD0444182822DACC92300@OSYPR01MB5400.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cMWNMwK3x/SEBwQuyvTFrKA5xu8tXtcy1vnD3P+MyRlz3DcNwG+7PSuaFALYrWZroFgvrilzqlBk8HqcaH7t1pLeDmgUfLMeYh524IhoHqM6XwF5NmzWGt/Sz5NVheihL+AgR/xBxat2r+ckVjGgBlmiq53JkCDkb7I2mxG3xeWYY8TPsl0o5ClZLo3SIEhWnjKiaiYJ+NmIfYIc/1KF12ndPceih0wFLPNk+eVGl3+qHkQmsaYCjWgUZ4s8Ih9S0If1y3yadMsZ3YKCin/1A6fS67ugC8+v2O4kfzIbacfcP5Ot5CxdbtQr7QSqTXkx
x-ms-exchange-antispam-messagedata: aXi2piKnl1eL1T50WQSDU1vt73nLEYHCf16IqtZfRXFkpz0twgWDHBbsnA2BqVVm063we7YXMk1gw7g/XquXe2P28FZNuj7YgfEmvxP61ouXvbeVVUuVS1m0rs1oj7n6T04WajG9Zq2LDnZ5dWO2cFtfGU25GQI2Ns0LM+oQ7w396BBqajqsmoJywMbdAwIXmuXXPETYQ60a1+LwCdEAz7F5ZziYCY76q7SsGSvO/BI2nez7l82Pu6G1V12kaC+91DqZg+hqNNL5HFNTAwvOJghBaF3HB20roTHH2/pyqpi8NvROcpSXbnQpcJWzsK1j7+jFQf8ec9ilBtzchRF6w44RTD1WMv2xFL+q1++Otp8u7GMnCHIhhrvmwWKwxBblWaE1QxNUNZVupc44nD75h9G6ndh2kMH4A70G6Pi3x9H+Qut80KAxG3HzL5/ylCPZ1L3c5OktvpeJEMGFHVpPQcjItnDhxsS/2jwPNYGzp/j7sWhjvHo/86yvkg0xFrf9VTtctb6ozkEhjSBfZGKhXeU/5cbdzzrdLrrbeICF1Zfn3szi7hftHodCTT170sUy1+mroshrA7DryvPlWjPI83CAJJ9RpCsX4l8nCJVHUxbuqeqjBM1qI2lEZnnqEh9yoaBF7xGbzZGxuICMzSYJSw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0243cf39-606a-4b9f-f391-08d865ede353
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 09:39:26.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgi/eBAWPpPrO2ey1Rs0l/jjQDaDGfhohoxnT5G+EV2o6hiVZ4x/WOQFHm8ggU+b4XNW7S8rPEI+uXjPay/Bd0U2nQSAuLPzjPHtdpxQy6ev5wgqbnPuhRq5ZXlti3BL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5400
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wfeFY2KqIZBzq5o6ZXSCqtGdx4520388AA=
Content-Type: multipart/mixed; boundary="tLseCMPSoE3WAJcpF950"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601545176;
 bh=e6nqC0Ur4VTBLggXm8nSkSglOHO5wKk/v5NvQK90g/s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=L4fIFOv+MGxFQAkcw+vZQqXEjX5U1WCEBQvvd3j7WxxTO0QbRlDDTTXjmzqlZWl1E0w
 /zPmwy2+YIeyXEoC31gP4+HBkNbpVJkzAAmI66ReNKHuGGk76BPDS1789DSjCOg8DxCdz
 xHP/sWr7Z9r8DmvHl3ma/+dUq05zujGK/yE=

--tLseCMPSoE3WAJcpF950
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmddIE9uIEJlaGFsZiBPZg0KPiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50
OiBTYXR1cmRheSwgU2VwdGVtYmVyIDE5LCAyMDIwIDc6NDQgQU0NCj4gVG86IGphbi5raXN6a2FA
c2llbWVucy5jb207IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJl
OiBbY2lwLWRldl0gSXMgQ1ZFLTIwMjAtMjUyODQgYmFja3BvcnRpbmcgbmVlZGVkIGZvciA0LjQt
cnQgeDg2Pw0KPiANCj4gSGksIEphbi1zYW4sDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sg
cmVzcG9uc2UhDQo+IA0KPiA+IElzIHRoYXQgdGhlIG9ubHkgY29uZmlnIGluIG91ciByZXBvIGNh
cnJ5aW5nIHJiZC9jZXBoPyBUaGUgd2Ugc2hvdWxkIGxpa2VseSBkcm9wDQo+ID4gdGhhdCwgdG8g
YmUgY2xlYXIgYWxzbyBpbiB0aGUgZnV0dXJlLg0KPiANCj4gV2hlbiB3ZSBkaXNjdXNzZWQgYXQg
dGhlIElSQywgdGhlIGNvbmZpZyBjYXJyeWluZyByYmQvY2VwaCBpcyBvbmx5IDQuNC1ydCB4ODYu
DQo+IA0KPiBTbywgSSB1bmRlcnN0b29kIHRoYXQgdGhlIGJhY2twb3J0aW5nIGlzIG5vdCByZXF1
aXJlZC4NCg0KSSByZW1vdmVkICBDT05GSUdfQkxLX0RFVl9SQkQgZnJvbSA0LjQueS1jaXAtcnQv
eDg2L3NpZW1lbnNfaTM4Ni1ydC5jb25maWcuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8N
Cg==

--tLseCMPSoE3WAJcpF950
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5490): https://lists.cip-project.org/g/cip-dev/message=
/5490
Mute This Topic: https://lists.cip-project.org/mt/76930681/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tLseCMPSoE3WAJcpF950--
