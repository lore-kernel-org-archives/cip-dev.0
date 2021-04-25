Return-Path: <SRS0=Tsg3=JW=lists.cip-project.org=bounce+64572+6393+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9AC433ED
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 23:22:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067FE611BF
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 23:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067FE611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6393+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nEiYYY4521723xIrSmgBWXbu; Sun, 25 Apr 2021 16:22:34 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web08.59.1619392951415818063
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Apr 2021 16:22:33 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 13PNMH7j027921; Mon, 26 Apr 2021 08:22:18 +0900
X-Iguazu-Qid: 2wHHmufQVQAmE6UATZ
X-Iguazu-QSIG: v=2; s=0; t=1619392937; q=2wHHmufQVQAmE6UATZ; m=vDK4VrYyQi4bwnWO1eK0eTn+Qx8861lIEBhxcbTOYbs=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 13PNMFZ0014194
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Apr 2021 08:22:16 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id DDBBB1000C1;
	Mon, 26 Apr 2021 08:22:15 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 13PNMFr8010180;
	Mon, 26 Apr 2021 08:22:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCthfE+aFuZaqFveK5K7lq1zFJNPRguHQ3X/jC0lGJ5kN2r0FnBW+nBj2JkFQFJCeygU0tYUVoldGbLMUIt0SxpD4t/U+p2Ypk+xxEmKOJuQqGWOGKZe1u6T3PVWka8+G6pjdalaJhdFAHEsy09df41wPx2tdKUriRCNFZCAq5BtqAmLwhuPys9VI0lUmhw0fu3+sEjODU/SlEN8ksSPEtn6tQhdf4GVE7/GyWXTy7BXcgVLc4N0xWHIXzbrNeLO377WotowhTz9LZnlCCHKmE0tpRiIFjErFOiEmd/nsqORtvfLZHkI4g87lpDAUzRyQwl5NAzA/sKdNak6rubUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOVJtwIzmhlVYLB8XppUPcCJyTxVNk0yy7Er2Okfq4c=;
 b=N3VB1joiuIPhKY982vuqSA4myBgwZUCtM0pGm0owU0EsF8U3qzf3QQ61THTge8uLHTf/mILzxlm4hHixkjakBPdsLx6leE/5M3d9uOzeeW3A/KK13FbSLMZlFwOgYIVNo44HYl0tEI3RESEVP+FhI9AGErLgRQRddZRe12Kx+ljfjZMFucmG115/kCzye3BAaL6134J+zaZ9kV2dxEUiK0ydpO6Y44TqKROA4xXOk9etg4potkWwJkeP3v8wZX7ndqlOH2BtK3KqJF0/tIualEtfl8BtYkPFCDtuzKBbD+dlJmXwKIqpptpZMEvDdpo/8IcJovndk8Of08D/5T0SNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <chris.paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.188-cip48
Thread-Topic: [ANNOUNCE] Release v4.19.188-cip48
Thread-Index: Adc6KbGhNJU6HsPCSHi+99Jq5FMx6Q==
Date: Sun, 25 Apr 2021 23:22:13 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625209B770DE1E1281A05C5192439@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22af1ab-edc0-43c2-83b2-08d90840f550
x-ms-traffictypediagnostic: TYXPR01MB1805:
x-microsoft-antispam-prvs: <TYXPR01MB180563F38172981665869EAB92439@TYXPR01MB1805.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LKwAEvXbkVLMY/JJBwQcfk2hwDvgRAl/ReQuvG3ZImej1SYUlbgKkYi9qeYYlnvmSKhUJfHfSJcFfEJawQL3NhbiOEI4NCW27DURHwejfaCCsaqFcLENnZ2k2+jLka08jAUUoGCDlKC1DKa40FxLrnnqh8/fa+OkAO/A7QX0dT3d+XzhbZF5dHaKbeCR/bkrSSvfhj/P5PRZIOVcX5bdJiUryukkiK2qYn9h+dJzgpOsRYImaF/pqe20yyAaSL+8u5ns4zvtpUk1jhxxPq2lDd8jAh21hNwwgcU7vBwL1r9IsAM3pCQfPnSMtnRF+6ow4Fbj2eY2VyEQJFDOAR7t+7mTmniGB5jrS0m3t5/z4wGX/6Au/eDxiuDCzgkD5qcB/UzdIFkz0oz2d4qRegDgB5GEXipGIbJ7SLFZ6uB0ZTjLyqsmoXIZoMgtAWEaijtg121YZXxL5ia6wlYCYRmrJLTaurfGPEUaotbUah52tJBHcCsi4jBEhmIpa/VYQEsTHTpc5Lc+gurT20FiCrSOsQKq4y6q0wt9GLZ5PHVDlV9Ny1mEsSDBhUj+7i+ZxnpumoCL/QwBFaWOaWP8WMKRORIJwts8b47NVz8Eb52TKu0W3wFwSZaavBUbZbq/ZnVX8Nsl8ng3mxKcxpTxGCrHlDmpxUqaQQr2B+13okJak5Bg0AmRmGrUY+HL/2S2FQgl
x-ms-exchange-antispam-messagedata: =?utf-8?B?UkVickJUbkhOelBxR3Bab3FrZHVNVlhOMHZoUFlNaGRLdXB0dFlRZUxQV2hu?=
 =?utf-8?B?QVNhZ3RacmRubDZzQjFsR0EyblpkcEZkOTdkc21zWTM4NVVNWHZzWWpkVmU2?=
 =?utf-8?B?cmx6MFFjdzJBTDZGdWVQMlp4cjBhMVg5QVUrakxzNUpqU1RJVnNmbWhSSW9M?=
 =?utf-8?B?U0dxVVozV3d2cUQvREk4UEpPZmNQVG9rRWJTVm14eUVLMW9ETjB3V1h1ZlEv?=
 =?utf-8?B?RUQrRHpFempCVUN6d0hrUXVzQ2h5d1Fqa053cUs0dmM1bkoydDU4d1VDTEov?=
 =?utf-8?B?eS9DQ1RwT0x1NHRaakMvZy9SN242UDdTbDdvdzNBTWhlY0dIbU1rVDhsajlU?=
 =?utf-8?B?c29tSktDKzY1Mk1WMkd6VVVuK3lBdWJUQ1FDSzhBZVd2OGpzOEFBMjA3RDlB?=
 =?utf-8?B?N0hoeHpsZlVUN2dhT1hDVjViQTJvNEk5NDFqZzBMUE5PZDhDQVdmcWxlMVBT?=
 =?utf-8?B?YUxwN2xtSnJIZXFIaTRjR3J1ZnRLcmFSbFlCS1BOWVBjdTBqTlRzUkl4Q3Ft?=
 =?utf-8?B?Y0RrOTIzWkp5ZE9XKzl3ZmI3aWk2N1BqZklDWEtZcFhhbFM3VTUrWXM5US81?=
 =?utf-8?B?TGVqWSthMTdXbzlhMlkzMzlDWW0rZ2lnTjF1UGRqcXVDbkl4U1JRWFlSWHk4?=
 =?utf-8?B?Z2l2WHJOYnJiWVRYZGpWejdjWURLYVBQZExsa1c0T1BHeG5oSUd4ZUZaWW11?=
 =?utf-8?B?aVc1WjRHOVN4MHZ0bklRK3crMEpOWXFYenQyK0luMDBvTndaU2NOUmxXeFVV?=
 =?utf-8?B?ZEJMNTI4V2JIak5jVisrMS9nZVBLaWFFSzl2MEpRUGhpc2dKV3kxMkpCVkZN?=
 =?utf-8?B?YkNXV25TYk8vUEE5VVNwUDVzc1NUaDZmbkpNKytsWGNHZncwMGJ6R0NlNFlV?=
 =?utf-8?B?Uys2WFV6OTkzcXo5ZmV2T3lLNkVnNG5pYXdPTlZsVUJPeDZsKytTT3RsR1VY?=
 =?utf-8?B?VTk1bnc3THRFZVEvR2pueG1wUUJZRzhjU2I2Sjg3VjAyYXRJbW91N2tEM0Zv?=
 =?utf-8?B?NXM4WHh4NjZ4ZHhieG9JYmpEbXVMSU5Wck0yZzZ5MFJBVkcvYk53cWZ3anZ3?=
 =?utf-8?B?Kzh1OEV4ZTdBWlAycFVRUU90cWkyZ1E1YWJ3bXM1NTZFVUdISFBsZFlaOHVw?=
 =?utf-8?B?cW5IUjNqcjJEbk84QjdnM2FmL0k0NWpyYlZ5bXlNSWFUdGJDREdkUU4vWjhX?=
 =?utf-8?B?ZHI1NWtGdzNCTlhBNnpuSy83dzlDR1FXSldkV2xHK2xKa1VycGdnZFlaTmZZ?=
 =?utf-8?B?K3dRVUc0elErU3J4Qi9wRXQ4Skc2eS9iM011K3JvNjQ2YjVud1lVeXJVS2JH?=
 =?utf-8?B?eUlJZFNrY000WnpMUHEvQkFreTlNMkQvVzQ1bUVERUVyRkd0MU5CekRzTDQr?=
 =?utf-8?B?b2Uvc244YzlYSVBXcUprTVB4d3NOTHdmM1BoZUIzTytVU1VFVUI4RVNzcC96?=
 =?utf-8?B?ZGM2c2ZBVGpjY3J6c0Q0WElkcllxWGFCTW4yNENSUFlxWUpRcTFPUEtJbDVi?=
 =?utf-8?B?U3M2WFBWKy81MDdXUTVnUlZwZmFMblR4R0pTUEFyN044TTlSZmJYeXYrS3dW?=
 =?utf-8?B?K1NxNXVYWHBCc0s0NzdUOUk3alc0ckJ3MStNUElzWlRoL3ZHaEdwaEJwdXRL?=
 =?utf-8?B?RkdXMWRGUHZvaVRFQnN4S0JQdlJyamZnUldnRmJzdWhPeTkzelpyUVc5Wm1G?=
 =?utf-8?B?U0V4OUF2WWNJWDNqdm02M25qL0FPWlhPdWJnUWhyZXk2MnZ0YUVUcVk1ZldF?=
 =?utf-8?Q?iEBojpBYZtEV+Liw6A=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22af1ab-edc0-43c2-83b2-08d90840f550
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 23:22:13.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vvIhnK4SR6/UgaQWDOpWPir7aj98pEZVNVTFcL2u8Ddla3138gVaMzIJUPfK5OQBuyWPriWajdNtC/eXCsPE5eeVz4IVnqg17euXr/HhRZmaF+mIBW+2eYstCG8shsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1805
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
X-Gm-Message-State: USI6vPpkzdLV26p1p5rrTK6Rx4520388AA=
Content-Type: multipart/mixed; boundary="hKGaFdN2K5nCQF7nhhwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619392954;
 bh=yvxPW2IqdKR8ArIRByLw/zJATOQnOYjNReFcDNSeA64=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=XpJv5LO93hDL1y58MyQIdEkKympgnArt+bze22Cxvne+akhgD4SrRV9AlYHN0FwWIdY
 9j6/4QbUcqaqioJW+YUSE3/FDwxMFiNCD1XY5FXDghz8vZ9NPkEUai0cJM5LhG7RoY7u6
 i3oQgu/1xNuBQkm+OAfJr1vdrUwmSthgy5s=

--hKGaFdN2K5nCQF7nhhwr
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE4
OC1jaXA0OC4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xODYNCnRvIHY0LjE5LjE4OCwgYW5kIGEgcGF0Y2ggaGFzIGJl
ZW4gYWRkZWQgdG8gZml4IHRoZSByY2FyLWR1IGlzc3VlLg0KDQpZb3UgY2FuIGdldCB0aGlzIHJl
bGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xODgtY2lwNDg6DQogICAgcmVw
b3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55
LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNDZjNDAzNjFhZGRmYzA2MWRmNjZjODI5NmU5
ZGMzZTcxNzI4MTQ2NA0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lv
biBzdWZmaXggdG8gLWNpcDQ4IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQogICAgICBkcm06IHJj
YXItZHU6IEZpeCBjcmFzaCB3aGVuIHVzaW5nIExWRFMxIGNsb2NrIGZvciBDUlRDDQoNCkJlc3Qg
cmVnYXJkcywNCiAgIE5vYnVoaXJvDQoNCg==

--hKGaFdN2K5nCQF7nhhwr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6393): https://lists.cip-project.org/g/cip-dev/message=
/6393
Mute This Topic: https://lists.cip-project.org/mt/82366375/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hKGaFdN2K5nCQF7nhhwr--
