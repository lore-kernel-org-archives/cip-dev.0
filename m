Return-Path: <SRS0=XZHY=CL=lists.cip-project.org=bounce+64572+5361+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BCC433E6
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 01:25:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9D52071B
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 01:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wtzTbcgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D52071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5361+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Kst1YY4521723xWuhwZLuEIa; Tue, 01 Sep 2020 18:25:20 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.11418.1599009918438581692
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 18:25:20 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0821P7aM032081; Wed, 2 Sep 2020 10:25:07 +0900
X-Iguazu-Qid: 34tKNrBeG0OFItZlMg
X-Iguazu-QSIG: v=2; s=0; t=1599009906; q=34tKNrBeG0OFItZlMg; m=JDh32nWZQhuRowI84SzENVPCF0efDkPyci+RXGpdO5o=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 0821P58Y003803;
	Wed, 2 Sep 2020 10:25:06 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0821P5v3003584;
	Wed, 2 Sep 2020 10:25:05 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0821P53b004193;
	Wed, 2 Sep 2020 10:25:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S74AAo7FV+FGiRui+uatYVUbEXM/Tz8MI52zEoVUhPnQtMwWaAL1qgqe7YU79ag2uXkfbgzemwB7KV+NdCrEdtC3VSsCJ2Bt6pyAk9bX09q5IcMVydmkuFqN3i/NN492x9rw1eELXL6e5hIOrra3Jq82twy9PskURsSe9XYh4UhZrsHS3whPNLlqUhCNPiNqMGzSoAgLFHy2/2KUkw57q90WAf5bHlYjm0Zx6rDjcEV9LTeAzPlyzJg7gzCMx7AC535bY8E4rpUqwqhpt8Y9H8nzc0Fj9QoTgL46yAGybbv4Eo/NDmvdS+mqJpqh6e3/eFH9W7a32A08+kONpJWzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKW+mpUu8loWC4sbh61wcDuhB8ccqgcYQtJ4wC0xt8w=;
 b=lT+zNGZiZMO2jiuGhgoTFjoNL74B1kqS5JRuPu1QfI2Y+IP0d0SkeWklBsDz4gr+gnKtKIdEaThjnTw6lw4t09472oRjHenT5D/matRV32OyshmOmod/SvHwOE65l6d3XKvq63YLYtl7EzvJvu0guPqCVVoKZtTebAeUK1dSz1OrbEBUstcyY2uRMB7C3WROG5Zulhk40OrZUXR2GhNPYk3EyeIrfKtS12HlQ+PLycTahYAVPnxVIhdLnhqjbSH8BZcUgozfkkpWdDg4MX2YwINmylpVBC2Wc1yuF8pH2ewANqK7/TafqkfLetacifgmPffIUNbyn23aUJIfFvoApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/10] Add IRQC/I2C/IIC/AVB/APMU support for RZ/G1H
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip 00/10] Add IRQC/I2C/IIC/AVB/APMU
 support for RZ/G1H
Thread-Index: AQHWgFTWSALK6jmqWka2wUljdmColKlUN5+AgABXETA=
Date: Wed, 2 Sep 2020 01:25:01 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983F422E001A59B43A81E4C922F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
 <20200901201157.GA11492@duo.ucw.cz>
In-Reply-To: <20200901201157.GA11492@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a91f988-4030-4ab6-9062-08d84edf039f
x-ms-traffictypediagnostic: OSBPR01MB1672:
x-microsoft-antispam-prvs: <OSBPR01MB1672757AA2073058ED9EA93E922F0@OSBPR01MB1672.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JVKD4wIroDGQvaltLpHkamLRuCAyXQU27jch9FfyFMvD+cc5/XZ/hbRI+0MQ431r7PZs3cEe2BUe+7Wtjaq7q+D26qPmrEzj+ufanTtlSxeGSdvyvLpYh6WRdbrqNtImo47dBEqp56hPG9IIui0b+2Yz4ojTk/N9vjbDKFv2ixw8IFUxP01xdvC5SVoWL93pusnT/1WszFKeYNPJdRS9iBSR3p2d6qs57U8CJgYqWAEnwpyOHNZW2HPWS3sGpoqUejuGqz0p0TVgrP0hh58PJwiFJIIECufJezLgFxT7wX4BhnPQBENQ/eK3/KCun0GA
x-ms-exchange-antispam-messagedata: Jw4TXbk1BXN33GWtmjNosjC9GHNHXIrF1nrvANuqC2KY7dX/iNcAuX92xELdC/NwVWB2Ir92tJHcuTEKQ0JIJhgl1aAjWfAAMq2XvB0lOrqtaw+qDnqLsSIkqfyZALzuXHuLfPcSNYTytvpVdXKJQJ2MABNmhLDL7oCKoDQ/mzivNWdZHDxA5F/ea8ziL2i0HA9zf9LkrHiWNzLso+2XwqAoiRzURrNnUW29msdEg48dXSzyp8J8zzaYDxvRvui8+IXdSZ18PhHJn2KtuT9qMGyOqRECgHsWIGUfSwLRd48gaO7e2W5QEJ3bZMBFjdEswCOrBjmppsmuNAxhUdV1RM+6xb2idm7ipF1ThdapDxLsvyW2c/G325DWc6NBffb/g7nwchVez6iBb2nrLBwznVsyQURpjefc2gCUkM56DY2RkWgjqO4Hb0NsDJKY90waIAM5XLcPHSfxvCXlhtLEotGtY8/NiOvlsFFd8eIcwMv253tpL2lxTldIr7fvCTpSaB2JK6CgdhhREYxS61Xw9nXoeuE48EdcyCmQQ6sJH94WoWGFzhOk02lM+qyrsptiqLr1+NMOnhO0UgcT0brEtUjjaIXSq+C20yUxtZbt1vqnCynfslZeLRIyhCMkPqBPYza6srkmIZrZh60A77BccA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a91f988-4030-4ab6-9062-08d84edf039f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 01:25:01.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYtJxSWhuXiwjE+qOaLBVhSiCLE1A9mNY8rmpGQBqOQdTgDnYghnAc7W9zeSyY8GRVNhtYC3RyBOxaxn5X5Cso3oaJqNjdrcnsOkY1v2zYtYUVhgrzRhnTZ92Fs14+tH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1672
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bNgo5g2Xq9ROnCk2KxLYcJQjx4520388AA=
Content-Type: multipart/mixed; boundary="fOZA7rqrJw6sULXQVmDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599009920;
 bh=Y/UjiOv8uJ24iGIkLQZst1PKAE/NJglhG9OHeEYKGB0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wtzTbcgdmioCNoBz/se59Cwks6BOXkqN2N6EcFz6WqzYhQsT4/OW40BDSeLltO6hm3Y
 McNx+CoRp8Wo8OQe0dWnEaAJFZlOnWzRSF6KCj4P9sJSQbOyiVtbRUS0839jDCp1ydQFx
 iZToUxv2XE0a0GkDd7oN7gGUiArx4A0dzjc=

--fOZA7rqrJw6sULXQVmDp
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAy
LCAyMDIwIDU6MTIgQU0NCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGly
byjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5p
d2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgQ2hy
aXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+IFByYWJoYWthciBN
YWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBT
dWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRDSCA0LjQueS1jaXAgMDAvMTBdIEFkZCBJUlFDL0ky
Qy9JSUMvQVZCL0FQTVUgc3VwcG9ydCBmb3IgUlovRzFIDQo+IA0KPiBIaSENCj4gDQo+ID4gVGhp
cyBwYXRjaCBzZXJpZXMgYWRkIElSUUMvSTJDL0lJQy9BVkIvQVBNVSBzdXBwb3J0IGZvciBpV2F2
ZSBSWi9HMUggYm9hcmQgYmFzZWQgb24NCj4gPiByOGE3NzQyIFNvQyB0byA0LjQueS1jaXAga2Vy
bmVsLiBBbGwgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcw0KPiA+IGFyZSBjaGVycnktcGlja2VkIGZy
b20gbWFpbmxpbmUuDQo+IA0KPiBTZXJpZXMgbG9va3MgZ29vZCB0byBtZS4gSSBjYW4gYXBwbHkg
aXQgaWYgdGhlcmUgYXJlIG5vIG90aGVyIGNvbW1lbnRzDQo+IChhbmQgaWYgaXQgcGFzc2VzIHRl
c3RpbmcpLg0KDQpUaGlzIHNlcmllcyBsb29rcyBnb29kIHRvIG1lIHRvby4gVGhlIHRlc3Qgc2Vl
bXMgdG8gYmUgZmluZS4NCkkgYXBwbGllZCBhbmQgcHVzaGVkLg0KDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IA0K
PiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGly
ZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hl
bnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

--fOZA7rqrJw6sULXQVmDp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5361): https://lists.cip-project.org/g/cip-dev/message=
/5361
Mute This Topic: https://lists.cip-project.org/mt/76554005/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fOZA7rqrJw6sULXQVmDp--
