Return-Path: <SRS0=nxgF=DP=lists.cip-project.org=bounce+64572+5506+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C14C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:32:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5AD2173E
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eF9IhE4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5AD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5506+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5Y3nYY4521723xFhScnUHroQ; Wed, 07 Oct 2020 22:32:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.5324.1602135159427065477
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 22:32:40 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0985WIHF018093; Thu, 8 Oct 2020 14:32:19 +0900
X-Iguazu-Qid: 2wHHzZilbcnjFEsJqE
X-Iguazu-QSIG: v=2; s=0; t=1602135138; q=2wHHzZilbcnjFEsJqE; m=+KVxTBTPp57tAk52+YulqQwA4x6LdYHKZB23XuJKiDA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 0985WG8Y026133;
	Thu, 8 Oct 2020 14:32:17 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0985WGNR024728;
	Thu, 8 Oct 2020 14:32:16 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0985WFJw030706;
	Thu, 8 Oct 2020 14:32:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3JZVg13b3HUUhD4oF//VTLGBwn2mA69TRdzQbhbwJfJdg8jYPVG/luNpdQT2tE+gNBh+2bZget2F0bWSS6lsXAkIBSNhtfVUHmN3PaQbLFt4cpkD7sSW3XnlB4GsS8lCQU4N9YODLgrMEyT3ZOlIJsPZxL4v9kANRXsq1hXnp83Kk+a70TvNOGp8DP2nt1n/NZ7QkE8Z9AdjkFoSHqiFcRzjvhjNJ6lOG4BJ5NIlxwuN8GyuxDlMgTZ2uehWgMKOWCZl4cL70OPk8ESmjVOU2gVf9KzOKlxoYqI8DxR2GMoFucbcVYBc17DQQwNf3pAbehVNZxxBN/pKxYOx5l2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x5oEkI9IBlRtLGbkWdf5q9Rag9+nuI8r1Bkv5AbD3w=;
 b=eq9UxxWWs1gp0pgGyJzvSBIrzq6cP90AX8lboCwhlFLeIHcje8un9aa19CmmLmBApFy0H/Y6fam1NEuEaciZJRAsK0MYrC3w0LeTfmPyN+qzO+Sm8tLb0qZ8d9e84vyEupevT69ZLmvN5o9Qj0UArny/RnSU72/dutUZuZAAkgrqcFe2FsKPvO/L6zYWzuSj2UMowlGK00Hy+M+nLe4xzK2RnDg08J1Bkb3PCX+PQZo7bzWP7+wh7SG3bjh8Xw+jZW787SKFtAvPpSKCUV3v+fE1/PZIh3nrEtCdZW8Ay0mWhQWV2yvr2xzt5+s3HXCueUU+ORp7dc80ohwBd5t9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <SZ.Lin@moxa.com>, <ben.hutchings@codethink.co.uk>,
        <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Topic: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Index: AQHWmi3HbeDruN0ZlkG2LoC92+G9x6mH5dqAgAATW4CAAhzRMIABKiPAgAFXcACAAJvFoA==
Date: Thu, 8 Oct 2020 05:32:13 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29838595D7430E92E750A188920B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
 <20201004213905.GA8065@duo.ucw.cz>
 <163B547D5FFC3079.30511@lists.cip-project.org>
 <OSBPR01MB2983148027370F1B4D02B0B6920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201007201102.GB32003@duo.ucw.cz>
In-Reply-To: <20201007201102.GB32003@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f7a05d-67c6-499a-85c1-08d86b4b8315
x-ms-traffictypediagnostic: OSAPR01MB2001:
x-microsoft-antispam-prvs: <OSAPR01MB20014317F56C0F335A5E7BFD920B0@OSAPR01MB2001.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hHHtbCgt5XkV3iUi7DvGIhQsZXUgn8+goSGkW2qLXJovumsi6z5Y3NVw8TeXzSgycWR2/t/BKTdWfmRyhiztMGTXXjK/OBAKP/sH16CDGc9z/eaXGktSGcY4fIgZ3iixWF/mguqhF+Fidk7zdsllfl6TdmtmDa/JNqx0GUe8DmNGOG30EhXu/JwUCYkPnv6z/4eeo8AcDlTTogSTDwQ8NaGWVpsXEmqHFOOImi2bDAi7gE+FqQ0Nz5BzfdU4BtcgbWAp5R9C2ZNNeLCvVZgRjcM6zx/rBJNf6IYMjfAFfeay38YCG1NlG+0rAaFeYvWcMASalLDVMSN2gR6dUloO9fHe/AiH4Cue3CFae0EqdmIhHHv2gd4AYmB+XwXXN/fbZkYiIyCKWUUHA9I2olskFw==
x-ms-exchange-antispam-messagedata: a83c2V2zAm257qKMT5Bhv80DkUhmpic1ijvWkhIjThkyk9qPRyIcpxAdIEfCOehdv1q4/R0hzb9ZFm89JANDftGnO4xzypeJsX7Op3sk553JjT0cmBObsZCkxCSnelbSyCquN5SnhTez+7AbuZQMPzrRw2AHxH+aISC/qZnAXYamWwypE0zF8ERncfktOS9ddtr9QqHqbiT0UO4GsgqzzBe3qDlPmL9Zdt/Qx3bStRa87KRA3+lRY5kWl00kPi1/24xSl9SfBniX9y/S1bmYkG1ZlTUiIvo4jsR3ORnYQu5CdBIfrnkApKMaV8Csbjl3bXP2wU5FxKCedYryG1YaXu1by4muKw/TGDtsHjYSj2vau4z5L0Ps2ugwpRG1m3FPFeTQ0S4pKJu7Mcvaq7sLMeMQF6Hy5RuEIC3+yQijDHpj76iVnAyitKCN9ENciYxtzmwt2hSvh3r6BUUXV7TwkQz/JMBmaJcuu1naAodJLpHeQcMXhCk4+witqmc4LcoZ5wecq2HHG37Je93QcJ3hd0Y6sJtKMPcZQqFFVTdZUdmrmdwZcoB293cl3NnFqELrBXG0nynH5H0wUcaruIepT5VfEcM78mZs9a5cA2HC0/v1SG1CK0820stkpsx7sfKMGPaXd+JF6XdB9WfShxyoQA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f7a05d-67c6-499a-85c1-08d86b4b8315
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 05:32:13.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJdaNbKHV1gtax6qINdsc+5WOV1KAG3/++OjoOBShTKthqDPW3C+FlxdIrQ5sFS27AcFhZ4EQXEiFkBt1+ZzjAgk4fqu5cE2/6zSIRfP/weeIEwc1xs37Pd/tR8KqW9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2001
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ueLaPAPBTd3zvBXqNza2ps8fx4520388AA=
Content-Type: multipart/mixed; boundary="qm7Sf7U2yi56JE9zFxNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602135161;
 bh=QH5cVYG43O6KAXaLjQdaqrxaWCmDQdBrkgHaGyiDYpc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=eF9IhE4aDe4DgOEc9+1+fXphqnsx45eYvFdlet5oWyaGqFBKxptYCvptG0LJf/PbJr+
 O9FVz2aT4yiGHvuz+gjeY/11RqEGIoYwPpNLteQd7/fBi9RCXHt9R68U5xWZ2dpCbmHuF
 cF2YlHusrusr1Fux6RD057kSB4KLQTJWzUA=

--qm7Sf7U2yi56JE9zFxNP
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
OCwgMjAyMCA1OjExIEFNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGU7IGph
bi5raXN6a2FAc2llbWVucy5jb207IFNaLkxpbkBtb3hhLmNvbTsNCj4gYmVuLmh1dGNoaW5nc0Bj
b2RldGhpbmsuY28udWs7IENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW2NpcC1kZXZdIFtBTk5PVU5DRV0gdjQuMTkuMTQ4LWNpcDM1LXJ0MTUNCj4gDQo+IEhpIQ0K
PiANCj4gPiBGWUk6DQo+ID4gIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9u
ZXRkZXYvcGF0Y2gvMjAyMDA5MjIwNzI5MzEuMjE0OC0xLWdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJl
Lw0KPiA+DQo+IA0KPiBZZXMsIGFuZCB0aGUgcmV2ZXJ0IGlzIG5vdyBxdWV1ZWQgdG8gNC4xOS1z
dGFibGUsIHRvby4NCj4gDQo+IFNvLi4gd2hhdCBkbyB3ZSB3YW50IHRvIGRvIGhlcmU/DQo+IA0K
PiBXZSBjYW4gbWVyZ2UgNC4xOS4xNTEgdG8gLWNpcCB3aGVuIGl0IGlzIHJlbGVhc2VkLCBhbmQg
SSBjYW4gdGhlbg0KPiByZWxlYXNlIG5ldyAtY2lwLXJ0IHRoYXQgd29ya3Mgb24gcmVuZXNhcyBi
b2FyZHMuLi4NCg0KWWVzLCBJIHRoaW5rIHNvLg0KUGVyaGFwcyA0LjE5LjE1MSB3aWxsIGJlIHJl
bGVhc2VkIHRoaXMgd2Vla2VuZC4gQW5kIHRoaXMgd2VlayBpcyB0aGUgcmVsZWFzZSB3ZWVrIG9m
IHRoZSBDSVAga2VybmVsLiANCkFuZCBJIHRoaW5rIHdlIGNhbiB1c2UgaXQgdG8gcmVsZWFzZSB0
aGUgY2lwLXJ0IHRyZWUuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gCQkJCQkJCQlQYXZlbA0K
DQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--qm7Sf7U2yi56JE9zFxNP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5506): https://lists.cip-project.org/g/cip-dev/message=
/5506
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qm7Sf7U2yi56JE9zFxNP--
