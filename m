Return-Path: <SRS0=754o=FB=lists.cip-project.org=bounce+64572+5886+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DFC3E8C5
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 22:41:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C361F22228
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="spVyfoeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C361F22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5886+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uskjYY4521723xUTpzuEl6wn; Fri, 27 Nov 2020 14:41:13 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.25792.1606516870917132524
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2020 14:41:12 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0ARMenxn010828; Sat, 28 Nov 2020 07:40:49 +0900
X-Iguazu-Qid: 34treOZZEUT1hMqR1t
X-Iguazu-QSIG: v=2; s=0; t=1606516848; q=34treOZZEUT1hMqR1t; m=ThG9C3kq9bK/Zf0xqsXBH2Q2O64Nl7kEA8WKqxrGHWA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 0ARMel0F025103;
	Sat, 28 Nov 2020 07:40:47 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0ARMelEq002983;
	Sat, 28 Nov 2020 07:40:47 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0ARMekP6010867;
	Sat, 28 Nov 2020 07:40:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz5DZN1WVTWKqyVSwoh14fSMGNTqJLmF4itq74Ax6Mia3UVvXdg09s6W4RoxSciQOs5KC5kEfqq+vixBFEyEXFUalgg3ITcpiVqJq9A9UTSeVBi7LnefsrwceP4gPzhsn+8f5Ib6v9DqzXVuC1GYDRftUEeOp63bue53e0qUvLVfP2U8hk31Um/f6WIC/4IkiIxPdOT+9BUsu5rqFWxqZy+gYcOZX3izcfN/ET51UDZ5fUXhN+UIKGT90ATT0Qm+ri30IzMfHVfwg3fIMdKDz36+k6iRKru6jD0Zou2unNRK8V3N4YF4L8TKKrCtrA7UKRsVIpCfp6PE3IX25H9HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9w6iRIiynvifUNG/GAnHqc16v0F+aq5HIDQ8gkUcAQ=;
 b=iL7JWG78yDhH9EFXEithaYgcR+OeXvGHoSsSQ4DmsZ2L92g35rNc+ehKtxiSQ+Lflf3df5AND91WowApaIvn5LHUgbfoCCzGJpxjI86/4Z+RBUHtpo7xtMPC7pGPEE3LyS6WJ6SfIQsUegdB6T6wSLcOQ2erYG7E0GudFAsN4ukAHxEEjdFcfq5vsHStG1zG5Hhtung5owdu/SdoKqE+rA+StGg7DILMmu+llOqFKOUZij//lxkNkJIXd3uB92D9w/6NQLXnzhndvfiqL26byw5BsGiAMnfonAvKtLCnGiBcap+oSa46uZVrhQpWQ5HdOmPbZKCL9m0oRK013vg+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <sudip.mukherjee@codethink.co.uk>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.160-cip39
Thread-Topic: [ANNOUNCE] Release v4.19.160-cip39
Thread-Index: AdbFDe05G/PAqN4ETYOJ56txxMJOtg==
Date: Fri, 27 Nov 2020 22:40:44 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298390DD2A0F4511952347CF92F80@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 896529f6-3019-4bba-e7cc-08d893257a49
x-ms-traffictypediagnostic: OSBPR01MB2360:
x-microsoft-antispam-prvs: <OSBPR01MB2360A4B4C314AB80301DE81292F80@OSBPR01MB2360.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WXYlXw4Eqi9z9t77UCCJNAxtvkF4vRMOdalJoAswFROuJ+TjK0/Yh75ot/rhthlYQt44Aea0B6dy5AluvL57GCDSNrC78QGZ35U4lxEp8wxHYKrhBtEv4MgRaVBU4xy6hNO6AFIUfizVHO17gED2hysD9B/T7VeE1df5/XkywpJg3VNWc0jLT4Ur3XX2cS/fVhkKxvAOJ1/Jacnf/8y2MsJTTLfG47i0+XeO6yIoUlg1jPws/N9zw2Qa8pis4ftTNK2glywkkRkq5bDlh4haXtQJsLbQfJaumowI6DS7xoZhRJrEfNzNJOeuM4L4zunv8fI3QtZld5mrzW/BFzTnzKqUpthTraYuYUEQgsXfcuQ4lJzXTBRZFxGBiZQS4gbImBkdEdQUhn072VhFcgrJ3A==
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHZMa0VGZE41ZWU1WUlFNTdwenk3SzE5YlErV0Y3dkQ2a3QyNDFSLzlVbzlp?=
 =?utf-8?B?OUgrdTAyeWticWxTaS9zdUU4UG42RjE3QzhqWHNvQllzSUticmFLaFU2VDNQ?=
 =?utf-8?B?Vk54T3lGTzNrRC81NnEreGlxemFpZVF2YVU1WGMwbHZzWWR6RGRZVXlXR1Jo?=
 =?utf-8?B?UEVVbUxkaFBRelQrd2RLREJmekpEbkJUbGcvRFdSUmtiWWZqV0ZqQmZBVVF4?=
 =?utf-8?B?THRZMitRUEpvQkJrdzlVaExUazEybjZ6cWRYOS84YkYrR1JpbEJEbnlUWjFB?=
 =?utf-8?B?ZXNkenp4LzJUdDZZL1JaMmdsYUFGcWg5UnRrVy9Jc3N0eUcvMWIyamRuTTYr?=
 =?utf-8?B?amR0MzRHWWZSbTZrR0xJV1RIU1NOY0lOdVVjR1JpZEpXSWU3R3BZYWdYeTE4?=
 =?utf-8?B?RFh3cnlaZS9URml2QVQ1VWlkOENsb0RtRUNJbnpNdmRjZENMbzV0TkN1dnl2?=
 =?utf-8?B?UFRuM3NGTzVod3BJTTR1MEpvd2lvV0RkNmpYbUJqcURyYllBV2FNOFpnWmFG?=
 =?utf-8?B?NUttUVhzb0lJcjJOQmdrSmNiTGh3eUppUmVRMHkwU1lyNlNleUFtVUNEcXRQ?=
 =?utf-8?B?VEpvaVJtR3FkYnBkZGhDcjBEOFVSSWxBb3MreGEzQlNOTFVLa0FFd1JIS1RM?=
 =?utf-8?B?dHVnOFlTc0hQWjE4anZVR0Z6aWx0V0FzMnhwWEdlYXFTMHJRYUZKbk5ZaG5u?=
 =?utf-8?B?UXowK25sNEc1L1NKRHl2V1lYNFZFVDV3bkttR0h3WmlaZG1nY1MvU0lyWEtR?=
 =?utf-8?B?YlVuenZHM0JFUkx5S3d3N0gvb0draG05dkEwMng1SjNGazBBQnVVWkVJSjVh?=
 =?utf-8?B?Q2VEQ1NFZTJROHRVSUhCd050SFVINlVUTGtGbEtJVkRTVVNCdmhEYnB3QU9z?=
 =?utf-8?B?RmJPK29ObGwrVWJrRjBzNmhwZUhsaWZtNGJmTksvUFBSTUt3SzlheE1aZU5V?=
 =?utf-8?B?OGRkcElIS3JKSld1RUw2NzAvbEg2WGErTXkzZkVyTE5XN1Y4RTJkVGhSZlhx?=
 =?utf-8?B?M2ltcFRTK3g0bElOcFhrQXdKMUdrLzQ2MFhaS1ZMY1lhQXNweFYyTnVUZzhT?=
 =?utf-8?B?NzR2aURyNkpvbVR2aEd5cTd4V3AwTU1jOVByZU5tMTNqdTVYTU1LVXNXZkcr?=
 =?utf-8?B?WGg5b2tKTkxHL2g0NHlyVEo2OVREOUc2K1hxOGYzT1JqR1hLaWE0eldwTXNt?=
 =?utf-8?B?eGVIcFFLNnpuM0JILys1QmNWMDdaMWF6Z1lqTm8xQW9lZ3NtdHl6bFlkVzN1?=
 =?utf-8?B?dDNwcEZ2OU5odk5aYytJbS8ralZBZmNHdDlMbEZsY3dWYVltazM1UXpyTUcz?=
 =?utf-8?Q?ZXyenmafep/xE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896529f6-3019-4bba-e7cc-08d893257a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 22:40:44.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13ZyZ6JjyWJxdFH3qLAxeVHQXY7xKoMlGruf3Udrjg1rM8JgwGLjH6J4Mcd/PY28jSBWroZ4mlU8d/QMdnyPHq6CgvBc4ZeNO9IcwEmoLX9E78JVwiCK2NfRJscu61kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2360
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: R2H3S095lPgkhAUxOdQO8i8gx4520388AA=
Content-Type: multipart/mixed; boundary="GuJKIT4DfXmf87KEM71j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606516873;
 bh=mYyxbSS7TCg8CFplyUbA7/DBnx35m72R2OcOJVetI5Y=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=spVyfoeH+3pyitfF9stZZee1TD5jrARIeRnyxSZPWSA2x7K2ibov0fT7HOCQgYHRjs9
 zd4GhzwT6JjYUtYYOWTngx9Smi5tYMSQPD4d2/jSfP8Yah9MShDZU+W7Rsz0oTo5QffRP
 pmieKJoyVGBR7OX3pBag34CT8AOmoPujqAU=

--GuJKIT4DfXmf87KEM71j
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE2
MC1jaXAzOS4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xNTcNCnRvIHY0LjE5LjE2MCwgYW5kIHI4YTc3NGUxIGF1ZGlv
IHN1cHBvcnQgcGF0Y2ggaGFzIGJlZW4gYmFja3BvcnRlZC4NCg0KWW91IGNhbiBnZXQgdGhpcyBy
ZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTYwLWNpcDM5Og0KICAgIHJl
cG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTku
eS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDUzYmEzMWQ0NGJmNmZmMGE5MTViNDcyNzk3
ZWMxYWYwN2I2NjM3NTENCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNp
b24gc3VmZml4IHRvIC1jaXAzOSBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KICAgICAgYXJtNjQ6
IGR0czogcmVuZXNhczogcjhhNzc0ZTE6IEFkZCBhdWRpbyBzdXBwb3J0DQogICAgICBhcm02NDog
ZHRzOiByZW5lc2FzOiByOGE3NzRlMTogQWRkIG1pc3NpbmcgYXVkaW9fY2xrX2INCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0K

--GuJKIT4DfXmf87KEM71j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5886): https://lists.cip-project.org/g/cip-dev/message=
/5886
Mute This Topic: https://lists.cip-project.org/mt/78557453/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GuJKIT4DfXmf87KEM71j--
