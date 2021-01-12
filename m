Return-Path: <SRS0=GOeT=GP=lists.cip-project.org=bounce+64572+6061+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4795FC433DB
	for <cip-dev@archiver.kernel.org>; Tue, 12 Jan 2021 00:04:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731B922CAF
	for <cip-dev@archiver.kernel.org>; Tue, 12 Jan 2021 00:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731B922CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6061+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tTnWYY4521723x1p7HK4phrS; Mon, 11 Jan 2021 16:04:39 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.1984.1610409877035789830
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jan 2021 16:04:39 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 10C047U5002789; Tue, 12 Jan 2021 09:04:07 +0900
X-Iguazu-Qid: 2wGrPAPDh8tIAK1Guv
X-Iguazu-QSIG: v=2; s=0; t=1610409847; q=2wGrPAPDh8tIAK1Guv; m=YFe/QyeTNyy5QAq8v9uLxepafUpX6dFuWpNq2JThijA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 10C045P6038207;
	Tue, 12 Jan 2021 09:04:06 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 10C045ww002709;
	Tue, 12 Jan 2021 09:04:05 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 10C044bO028093;
	Tue, 12 Jan 2021 09:04:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqDVMQuWYas1JnZ2JvSrmcaZCG8p5VknJJNOMg4VtTQAhxLH80D5L+swNloF2onhnzARHBNad6b4rt9W0EF2ZtT2b6NsaqirEVes5qQFjZJLNhURRCvXDSK1n3XOl9hZoE8XnKTz/pHFQqOZMxxbsdOak92VwSJ0lGuUjntpfjswoUVPWddYe6d5UVO9w7ErKmVfKRyl7R1S1KRJRbkM+7lu78fLacyBuNBC/GblWYeYRql7SvAjXlzorHmrXrCVDmcEOfyE+k9XPX+szsQ5LA1TicGarLUl3BxXeADyTis6OQktGuPRu9Kssruso2z8PkL3K/EdscyklqBU4pDFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHoxmR5ZrAb2KbHfdInEdyZ70ZZWp3FzAz3kKiIUHu4=;
 b=YPW3MPBI0+6O8yU5nwdsMfg0sd87NI3mK3assx6f/3Ak7J/mr13uA6mkKu4kPO+8ZmUE8kcjcgZjAg1lp6HBJW3Y/tdOWbTgNakQy2Ab1mj3i/pUwfg9/tw1m79opWenKqPMYzi4NWVz0/O0uRiJ2xi8Ehgj7pxbCmAKqkX3OLZSoTOrejUCeFq4UQ8XlUoFP2HzmOgo0b2624ZNe2jthnckSJxl+Ow/PmRmncty2ZYwt+qQjTpBoumMQgfBqIMcDPwkaBa2hgJ6al48gORQrn7hBeXXjQ5YSSUsQJKV3C7EVki+TTC0VOOH0ulqBM9uJy8vDCMtPYlqsCczRSCpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <wens@csie.org>,
        <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.165-cip41 and v4.4.249-cip53
Thread-Topic: [ANNOUNCE] Release v4.19.165-cip41 and v4.4.249-cip53
Thread-Index: AdbodmKif9Vk34QSSTmCSP6KFKKPQw==
Date: Tue, 12 Jan 2021 00:04:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298354A5FBA09C41E995D16592AA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61c5324d-2f2f-4497-6803-08d8b68d90ca
x-ms-traffictypediagnostic: OSAPR01MB1459:
x-microsoft-antispam-prvs: <OSAPR01MB145983C754B4AA3FCEEA0C1092AA0@OSAPR01MB1459.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9A16xlx4qQmOLnTKIO6zrxeS/Kmq2+A865MXyJDM2tNONGzU5ERUbFIHRwNur/s3Bj9xd/7DAVoY+WVphJTiiHPxjyQzQrAHrUXgJ9/2R74cqoH+7Lg5KPjEdqeBGhVdpnQDc6UqTyUiR7UYW/EjAuRy4YIzRaDMusWC76DLH4WGaEBQ3uvb5JMhvtsWXFMrVBqWjeJW382U+p106IIsZKbpAsSm7EmZr6tANOmEG4R9nDYDuIZ49lr2ORiT0wUTt90GV3+x4UkjdSlEIASp9exMHgb8LCcxsw8S1QP9weapcsnudzwjyPrLTXmRbU2BPl9m7xs/svw7//TJHax8oXmjaoAMl9ntWkEFRnOn4inHzb/S7QePw7/WLG3rN2aEhaM+h+Xf9UbBtKuiaJ2dY3gMRLgjWatGGqsIe3J9RYBzgv9B94bMfKTBaRpnl7/i7WfkuUDV2Wqt450sDVTSJQ==
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWlLbVhMRkZYeGdiT3V5bm1HZE45bVRnR2laZDRXdE5uRDlrWVdPSzEvZkwx?=
 =?utf-8?B?RlltdWVUSXhUd3lTY3B5NTJGSWJCaXV4clpXbHBUVncrRDA0VHc2RkJLcDEx?=
 =?utf-8?B?K0Q0cThjbDB3Sk0xblRpaFJERWQyN1B2MG9INlNWUHZqWEswRXhSWWZ4Mkkw?=
 =?utf-8?B?TEFEYmFZcEUxUkY2eXVEbld5bENDZnRoTUpiNWRvQjM1VGtGaFVIdDRpZG1n?=
 =?utf-8?B?aHpNVWRzWW9ObXBGS1NuZzR5ZVlhYnp4UWFJM2VleDJBV05RQ0VYeWcvSlVU?=
 =?utf-8?B?Z3lKN0JnYlBFblZNcmduditMR2RJTndmbFNhU1NhSlgzR3kvMFFhc0ZYODg1?=
 =?utf-8?B?Q0VGTG1JdmptV1B0a2xTeWhpczU3alk4US9LUGE4K05kTHdsbDRJQzVteXla?=
 =?utf-8?B?L3JxdGNHNVBzU2o0OXNHK0t6YzVPSUlLYXRBSEVsbmgwVE5vaWVxUGVXN1Ex?=
 =?utf-8?B?dnRnT0RSbGI2U1R2U3diL0ZteTd5R0pkejh0cVc0NVF6L0pJQWcyb3kwTW5Z?=
 =?utf-8?B?OExkM1VuL3k5RkFocnlvUWZub1hDeVpXcGlNUCtZZlQyWE12Y05pVktBWnVX?=
 =?utf-8?B?RDVHWC95QTQ2VWRCMGRXZ3BxdGEvQUZxWDRIaXliUHNvTk9XN05xb1VrdHZ2?=
 =?utf-8?B?OFhueWRvWGVGM1F4bEZXVDZ0Y1M0WDdmanl2c2dmclRBRU1IWmcvMWR1RkVQ?=
 =?utf-8?B?UWFLb2pUQzV6c3g1L0lmckNVTi83SjhJSVBYUkhoVG1VVk0rbEhjV0RoaUNy?=
 =?utf-8?B?TzZ0QVg3WTEyd0xsNVFuR3lVbHc0N1dZZWljOVZWSll1OFdmL3pMcUpXTytP?=
 =?utf-8?B?RFV0S2kvcUluZWtLQzk1aVM5cVFxYjBXKzB1RTlGdi94a0lrWkhoYW1BRWhQ?=
 =?utf-8?B?TzhrOGV2OTZreGFrTkxvU3NGbTN3eTVSUGJmSE5tQmMvMVFMemhRb0tjZlpF?=
 =?utf-8?B?TjFhSHVvSjBuUXgrRUNRUWt4NnVNdkdwcWN5OWVBOTB1aWhrVlFCVVNWTzRv?=
 =?utf-8?B?TUNMQUloQ2NURi9GZmthTm1aOTNyTExudCtKQ21WMURJSmVWTUkzR3Fia3hW?=
 =?utf-8?B?L21xVXVaSjVLekplV1ZuVm9iTXliTjZYVWdBU1RLQ2RubGloMzV3QmxFdzR5?=
 =?utf-8?B?b2lWem1qRGNzbzhjbmVuNmRMN0JmY0g4dVFNQmExUUI3TktqWk9iZ2cvQUJN?=
 =?utf-8?B?cDh3aVVzRzFWV0dRTzQ5eE9uU3ZiZ3NETWM3ZVFXYlNFd1JoUDRZUEZDaEpZ?=
 =?utf-8?B?d2JIS1lyMUVJL2x5aWlhNnd2RFlYOEJrNlpRMWpOZXRBTzVkQ3ZyTG93QlU2?=
 =?utf-8?Q?YkUFhz3MYuHR4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5324d-2f2f-4497-6803-08d8b68d90ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 00:04:00.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeoLPPzztXNsoDMRp6v/4/5/ntl4Uj35ZI8C6/OGR0vNMHo4FmLOUKn5h8d47XkfHqIejzpj6WbI9hhDHSftJEl1qJpf9yNOTI/A2gEuDGL+YE8oUmBNkzshkCsRH807
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1459
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: igidJmeErdNFUf82Lhkfib5Gx4520388AA=
Content-Type: multipart/mixed; boundary="9ir58HYh5mSFxoYdHSny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610409879;
 bh=uoPXXIvfCmIoGVAzUJNbTFWC/7YZvxgorzZ5tveexuI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jnjNqw7VOvySIqDY5bTpi3q9oZE37o7fqzuHWEwG5AufOfNVlOBxX/11IS17a8JhGXQ
 yhCNxLr9qntng/n3L1n65/+VcP233FUNhTf7k3qNw4nehEJuljn+Wipqlpk6w/qKEv5rf
 7KaK6suHx+UGboINthVs2+U6xkhqwdJfYE8=

--9ir58HYh5mSFxoYdHSny
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE2
NS1jaXA0MSBhbmQgdjQuNC4yNDktY2lwNTMuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTYzDQp0byB2NC4xOS4xNjUs
DQphbmQgdGhlIGxpbnV4LTQuNC55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJz
aW9uIGZyb20NCnY0LjQuMjQ4IHRvIHY0LjQuMjQ5Lg0KQW5kIHY0LjE5LjE2NS1jaXA0MSBhZGRz
IFJQQyBkcml2ZXIgc3VwcG9ydCBmb3IgUmVuZXNhcyBTb0NzLCBzcGktbWVtDQpkcml2ZXIgc3Vw
cG9ydCwNCmFuZCBtb3JlLg0KDQpZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQg
dHJlZSBhdDoNCg0KICB2NC4xOS4xNjUtY2lwNDE6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1j
aXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBo
YXNoOg0KICAgICAgYWUxZmVmNGIxMGYyOWVkYzRhYjc1ZWY5YmU0MGYzMzQ5OTdiNTY0Ng0KICAg
IGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDQx
IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQogICAgICBzcGk6IHNwaS1tZW06IE1ha2Ugc3BpX21l
bV9kZWZhdWx0X3N1cHBvcnRzX29wKCkgc3RhdGljIGlubGluZQ0KICAgICAgcGluY3RybDogcmVu
ZXNhczogcjhhNzc5NjU6IEFkZCBRU1BJWzAxXSBwaW5zLCBncm91cHMgYW5kIGZ1bmN0aW9ucw0K
ICAgICAgcGluY3RybDogcmVuZXNhczogcjhhNzc5NjogQWRkIFFTUElbMDFdIHBpbnMsIGdyb3Vw
cyBhbmQgZnVuY3Rpb25zDQogICAgICBwaW5jdHJsOiByZW5lc2FzOiByOGE3Nzk1MTogQWRkIFFT
UElbMDFdIHBpbnMsIGdyb3VwcyBhbmQgZnVuY3Rpb25zDQogICAgICBwaW5jdHJsOiByZW5lc2Fz
OiByOGE3Nzk5MDogQWRkIFFTUElbMDFdIHBpbnMsIGdyb3VwcyBhbmQgZnVuY3Rpb25zDQogICAg
ICBwaW5jdHJsOiByZW5lc2FzOiByOGE3Nzk5MDogT3B0aW1pemUgcGluY3RybCBpbWFnZSBzaXpl
IGZvciBSOEE3NzRDMA0KICAgICAgcGluY3RybDogcmVuZXNhczogcjhhNzc5NjU6IE9wdGltaXpl
IHBpbmN0cmwgaW1hZ2Ugc2l6ZSBmb3IgUjhBNzc0QjENCiAgICAgIHBpbmN0cmw6IHJlbmVzYXM6
IHI4YTc3OTUxOiBPcHRpbWl6ZSBwaW5jdHJsIGltYWdlIHNpemUgZm9yIFI4QTc3NEUxDQogICAg
ICBwaW5jdHJsOiByZW5lc2FzOiByOGE3Nzk2OiBPcHRpbWl6ZSBwaW5jdHJsIGltYWdlIHNpemUg
Zm9yIFI4QTc3NEExDQogICAgICBjbGs6IHJlbmVzYXM6IHI4YTc3NGMwOiBBZGQgUlBDIGNsb2Nr
cw0KICAgICAgY2xrOiByZW5lc2FzOiByOGE3NzRiMTogQWRkIFJQQyBjbG9ja3MNCiAgICAgIGNs
azogcmVuZXNhczogcjhhNzc0YTE6IEFkZCBSUEMgY2xvY2tzDQogICAgICBzcGk6IHJwYy1pZjog
Rml4IHVzZS1hZnRlci1mcmVlIG9uIHVuYmluZA0KICAgICAgc3BpOiBhZGQgUmVuZXNhcyBSUEMt
SUYgZHJpdmVyDQogICAgICBzcGk6IHNwaS1tZW06IEZpeCBhIG1lbW9yeSBsZWFrIGluIHNwaV9t
ZW1fZGlybWFwX2Rlc3Ryb3koKQ0KICAgICAgc3BpOiBzcGktbWVtOiBGaXggc3BpX21lbV9kaXJt
YXBfZGVzdHJveSgpIGtlcm5lbGRvYw0KICAgICAgc3BpOiBzcGktbWVtOiBBZGQgYSBuZXcgQVBJ
IHRvIHN1cHBvcnQgZGlyZWN0IG1hcHBpbmcNCiAgICAgIHNwaTogc3BpLW1lbTogQ29tcHV0ZSBs
ZW5ndGggb25seSB3aGVuIG5lZWRlZA0KICAgICAgc3BpOiBzcGktbWVtOiBGaXggcGFzc2luZyB6
ZXJvIHRvICdQVFJfRVJSJyB3YXJuaW5nDQogICAgICBzcGk6IHNwaS1tZW06IGZpeCByZWZlcmVu
Y2UgbGVhayBpbiBzcGlfbWVtX2FjY2Vzc19zdGFydA0KICAgICAgc3BpOiBzcGktbWVtOiBTcGxp
dCBzcGlfbWVtX2V4ZWNfb3AoKSBjb2RlDQogICAgICBzcGk6IHNwaS1tZW06IGV4cG9ydCBzcGlf
bWVtX2RlZmF1bHRfc3VwcG9ydHNfb3AoKQ0KICAgICAgc3BpOiBzcGktbWVtOiBBZGQgU1BJX01F
TV9OT19EQVRBIHRvIHRoZSBzcGlfbWVtX2RhdGFfZGlyIGVudW0NCiAgICAgIG1lbW9yeTogcmVu
ZXNhcy1ycGMtaWY6IE1ha2UgcnBjaWZfZW5hYmxlL2Rpc2FibGVfcnBtKCkgYXMgc3RhdGljIGlu
bGluZQ0KICAgICAgbWVtb3J5OiByZW5lc2FzLXJwYy1pZjogRml4IGEgbm9kZSByZWZlcmVuY2Ug
bGVhayBpbiBycGNpZl9wcm9iZSgpDQogICAgICBtZW1vcnk6IHJlbmVzYXMtcnBjLWlmOiBGaXgg
dW5iYWxhbmNlZCBwbV9ydW50aW1lX2VuYWJsZSBpbg0KcnBjaWZfe2VuYWJsZSxkaXNhYmxlfV9y
cG0NCiAgICAgIG1lbW9yeTogcmVuZXNhcy1ycGMtaWY6IFJldHVybiBjb3JyZWN0IHZhbHVlIHRv
IHRoZSBjYWxsZXIgb2YNCnJwY2lmX21hbnVhbF94ZmVyKCkNCiAgICAgIG1lbW9yeTogYWRkIFJl
bmVzYXMgUlBDLUlGIGRyaXZlcg0KICAgICAgZHQtYmluZGluZ3M6IG1lbW9yeTogZG9jdW1lbnQg
UmVuZXNhcyBSUEMtSUYgYmluZGluZ3MNCiAgICAgIGR0LWJpbmRpbmdzOiB0aGVybWFsOiByY2Fy
LWdlbjMtdGhlcm1hbDogQWRkIHI4YTc3NGUxIHN1cHBvcnQNCiAgICAgIGR0LWJpbmRpbmdzOiBQ
Q0k6IHJjYXItcGNpLWhvc3Q6IERvY3VtZW50IHI4YTc3NGUxIGJpbmRpbmdzDQogICAgICBkdC1i
aW5kaW5nczogUENJOiByY2FyOiBBZGQgZGV2aWNlIHRyZWUgc3VwcG9ydCBmb3IgcjhhNzc0YjEN
CiAgICAgIGR0LWJpbmRpbmdzOiB0aW1lcjogcmVuZXNhczogdG11OiBEb2N1bWVudCByOGE3NzRl
MSBiaW5kaW5ncw0KICAgICAgZHQtYmluZGluZ3M6IHBjaTogcmNhci1wY2ktZXA6IERvY3VtZW50
IG1pc3NpbmcgaW50ZXJydXB0cyBwcm9wZXJ0eQ0KDQogIHY0LjQuMjQ5LWNpcDUzOg0KICAgIHJl
cG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuNC55
LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNDQ5MGQyN2E5NzZmYjRlZjA5YWE3YTVhYjQx
MGEzNDdiYjdlMjMyOQ0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lv
biBzdWZmaXggdG8gLWNpcDUzIGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJlc3QgcmVnYXJk
cywNCiAgIE5vYnVoaXJvDQoNCg==

--9ir58HYh5mSFxoYdHSny
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6061): https://lists.cip-project.org/g/cip-dev/message=
/6061
Mute This Topic: https://lists.cip-project.org/mt/79612024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9ir58HYh5mSFxoYdHSny--
