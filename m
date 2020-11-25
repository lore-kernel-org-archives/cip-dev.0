Return-Path: <SRS0=Ypdt=E7=lists.cip-project.org=bounce+64572+5870+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A7C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 07:08:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E145206E5
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ijQ1MDRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E145206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5870+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id azcZYY4521723xFwoelLg0xI; Tue, 24 Nov 2020 23:08:08 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.3579.1606288085921522345
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 23:08:07 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0AP77tQO017342; Wed, 25 Nov 2020 16:07:55 +0900
X-Iguazu-Qid: 2wHHLA7xMfcZtSBzuq
X-Iguazu-QSIG: v=2; s=0; t=1606288075; q=2wHHLA7xMfcZtSBzuq; m=Rx69ikLgddNfSrL85TEQXWw5xGI/ZaslqWXKqqyqdYI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 0AP77r8L021383;
	Wed, 25 Nov 2020 16:07:53 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0AP77rXb000831;
	Wed, 25 Nov 2020 16:07:53 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0AP77r15030012;
	Wed, 25 Nov 2020 16:07:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AETjysxodWvIF2WB8KEqzXMdtiG0YBwxrz3rh0eE2dmwB1DTGA3iI/4g9PoTW+MQ4FLpzuAeW33tizz6gOWgQlaNbLiwE4Zyzy54EAh87GcYo5tVeToz9+WNDDVVbMQlelYVruS0AXFLbMTmPYtZex/RuHeojIHxBDQYz+fQu4ZYpbQv9CjjEInmm8Mz4B3Hd9OEVFaxht6puhLWKG+Gj2HwvLC2F6x49K25erPHdkpdFxyjLiXVZHHyAOtdZhgwcCniRvrAJql/i/CC7xJyxMdo1+iEWGnfVDAUhU0TY67D9Ix3ckeK/qyI5jW1gyiWJMBjKj9k1Z60vGJMm5PVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=070Sx+IBBIrtX5O8qe+l0p8TCIf8P5T66+2vUzdmuyU=;
 b=VmdrfsP2C2lDj3fj3U3aawzIAmesTDzasu/I2gNfI4TJdehuNBf/IBUtuq2WGtCQEd+qTOxD5WWMV3mZbiSyOmd8GjOOiEzpQ96pzdNBgAwCmfGCR0kPGtyBEHjquNj9ehN8lWXUNsYBI9fcyNMrGYQYLmPOqXWDSYvFBu3plV4TBevzg3aBQqIJswLGtavj17BxjZ61Y333wDclSLU2mNk+fg3k6YKtQpB1O7jhz6Z98a9SVullxC5jeAb/01cFfRdnwJFsb1UD5P53tchz5XNEg2NrcJ8wBHiMentmheTKsMnFXwMl2ocrJFIH/ILRyyHSaNRweXwz0ddMLO54BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <wens@csie.org>, <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>
Subject: Re: [cip-dev] About corresponding CVE-2020-25669 from CIP kernel config side
Thread-Topic: [cip-dev] About corresponding CVE-2020-25669 from CIP kernel
 config side
Thread-Index: Ada+HcbxHj2VtR2NRheusAWsF8UA+wAKcCYAASwB4FA=
Date: Wed, 25 Nov 2020 07:07:50 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29835DE6E9B6059A639AB7CA92FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSBPR01MB29831AC14AD65ADE956DFF3392E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <41fcecae-8dff-ca7c-1b07-2f8469ca7eba@siemens.com>
In-Reply-To: <41fcecae-8dff-ca7c-1b07-2f8469ca7eba@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f2ae03d-4d0b-442e-e5ef-08d89110d208
x-ms-traffictypediagnostic: OSBPR01MB1685:
x-microsoft-antispam-prvs: <OSBPR01MB16853E48D7D753505869EB7392FA0@OSBPR01MB1685.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WG0M/eZZ1/2CENZ+aDYk1pjDqAYmN1ctf/pcy+2yo+HBYKI7YI3PkvwlM4Ka8uRRswqvRIl1wossnyWr4EfFxe0cY6Qel/IUg83mFbT2w41kzLaZ6eMM79CzscJLfxLJI2D4IzyVvns2ow1QfdpbzkOEygSd3EKFJleX+/hGqqGIzk9Zq8n0O4nXG1yK2UfX0Z/syIczpyhXxA1Tos0NVbE+WRyauukKPEjT1WxzswYvkkKXXmOETsvcTaP8v+Syb1cDLSXyVliwUrhjqFjS99Mw9qE/WqCX7b999XFGJD79oWj/TXDZc2NOCDoRMxjITVC+Uhe0tYWKDX/G8DcvwA==
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZEM2ZEhaaU1abzRaRnc4VmEzRTJaM1c3K0c5SVh5NGt2aS9aRElGd1RHMm9V?=
 =?utf-8?B?TUtuYURoLy82c3JvbU9CSU91YkdPcjdUcVhtRlZ1b2hTa0pXZUpoT2FlL3NK?=
 =?utf-8?B?Um5HLzhSUGtzNzl3Wm5oSjBPMzUzM2g0QzNMM1pzT2xUdmp1M2U0cWNEVUl5?=
 =?utf-8?B?cDAwdEVhdkFUZHQ2Qkx6amNNOCtmN2wzUkhhQnlKVlE1YVVtWCtXdkdoUlB5?=
 =?utf-8?B?TDhCUERCa2dWVXhyZW1DalB4aWgrenlMWDdqWndYZk50aG5ReThpVGYrdDM0?=
 =?utf-8?B?OXRBbVBhQitrZ2pndm9DKzZMaWc4K3JubGphM2NjWWNJaGxTRlByaDVTRTBR?=
 =?utf-8?B?ZUxCa2RTUStjTGd3dCt1MGEzc09Xc0FxY25Od1ZkWjU5ZnpoOUNWbStUajZy?=
 =?utf-8?B?cDFQQm5GbE5HRG5wNnNOWkgxbzFFMHRQYldkOUpvTnpZbWNrNmxFUDZ6ajRw?=
 =?utf-8?B?bUpZb0F6S0FPaWN3ZFZTSjcvQm9oOVMrdm8rVnFRVkZWZTRXQkR6TnJjdEVW?=
 =?utf-8?B?WjdUeDhaR3NVQzhJQzRmR2gzU2l1Z0VJRmtrSmJDcnQvaTRueWx0K0ZhcWN6?=
 =?utf-8?B?OXJYVVhIamJUOVFWcnFLUWJtQ045QU1JQ0RRNVJMeVRuMlVkQzBSRGw2bDNM?=
 =?utf-8?B?MkFycTAwTUNCMHEyUDl1NmU1TTdjeFZoYm4waW5aeXl6cjZFTFhhU0hZWGl0?=
 =?utf-8?B?WDNpdlFrRHRiOXQxaGRLRnVwUHVuN2NyaUZhUVcwVURhS09RZlRKU0E0bTlE?=
 =?utf-8?B?T0RUS2gvdUpMVGhuUFRtTU1Fdld2N3RwT2R6VTBUR255ZlJJQmV1cE4xUGVj?=
 =?utf-8?B?ZmwyMmptWGhDTmFhQ3dWZThkc1ltVDBCMWFEOXdNVDBpY1M0TEF2RHFEcVRH?=
 =?utf-8?B?eC9wUTdJNTN6aWw0cjBUNFJGMHRnQWJZVXBYaGpiWm43bERtN25sMjF4Umh2?=
 =?utf-8?B?UFJ3M3g4TEdKcUhiZG5DZ1hlUURlMjZRbVlqdFZOQlBEaU02M2JkZnp4M2xD?=
 =?utf-8?B?Z1A3Rnk4c3ZhdHNhMHZhY0xNcGNVV3dLR1pETmNJMHJiZVE5bnVtSUhOTjZj?=
 =?utf-8?B?TkY2ODJWU1ljVUlVTERGaEZoS1Y0NzNJWmNRS2lIeFE3UmhpSGx3dDFUWGp3?=
 =?utf-8?B?ZUhMUlVlVnZ5RlVVSUQwR3d6SlNpZVR3SDVxaE1LSFZoMUVZR2IwZWpsYUNE?=
 =?utf-8?B?VFhnaHpPeXQxSktZM2grTEZiSGZaL212NG5CWGl0WXRwWEd2bmRTK1lSYzl4?=
 =?utf-8?B?UHpUMS9HSGRGdjZxT3pZRkJZbmVOemMycDJEdktWeHRobDNEZlVRL0RYVTU2?=
 =?utf-8?Q?P2fmaqB0lKZfA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2ae03d-4d0b-442e-e5ef-08d89110d208
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 07:07:50.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yt0ZQzfG4rmbwsJ9vrkO/DbwoUWYWc3s/9U+hcHiIdbsLYBOivnxIUF14aHXpFPgy7WweOGmtEg/ukc7m6LQhfy7xqd7s+i3MlZg7mH3Hp1qfHlmJiPBVg2R3cFzBcKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1685
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GuCYEMGTYJ6xqKnOd5mXRiJKx4520388AA=
Content-Type: multipart/mixed; boundary="gVRncYq5vhEeetqBpTvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606288088;
 bh=gp4FanHxaxIxozpMRMH26OOPAqP12aNzH4mX2n68clE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ijQ1MDRur8k5R6EJUMXOcw157GECG0tnF9JnZ+7B4IRh4V2URKhjx1RPwqPXI2jxwNJ
 /JGbsS+nF9Xds9zgTFb25lPCDqtUhC9hYJgx/GMQDl1oM5LoPsbnKe57lqFt3sxtTOW8e
 9IIZaIRKpMiNmUPrwJmhHIiEKiLDNbCPidg=

--gVRncYq5vhEeetqBpTvR
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmddIE9uIEJlaGFsZiBPZiBKYW4gS2lzemthDQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAx
OSwgMjAyMCA0OjQyIFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHdlbnNAY3NpZS5vcmc7IHBh
dmVsQGRlbnguZGU7IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFN1YmplY3Q6IFJl
OiBbY2lwLWRldl0gQWJvdXQgY29ycmVzcG9uZGluZyBDVkUtMjAyMC0yNTY2OSBmcm9tIENJUCBr
ZXJuZWwgY29uZmlnIHNpZGUNCj4gDQo+IE9uIDE5LjExLjIwIDAzOjQzLCBub2J1aGlybzEuaXdh
bWF0c3VAdG9zaGliYS5jby5qcCB3cm90ZToNCj4gPiBIaSBKYW4sDQo+ID4NCj4gPiBDVkUtMjAy
MC0yNTY2OVswXSBpcyBhIENWRSBmb3IgU1VOS0JEIChzdW40L3N1bjUga2V5Ym9hcmQpLCB3aGlj
aCBpcw0KPiA+IGVuYWJsZWQgaW4gc2llbWVuc19pMzg2LXJ0IGtlcm5lbC4NCj4gPg0KPiA+IGBg
YA0KPiA+ICQgZ2l0IGdyZXAgU1VOS0JEDQo+ID4gNC4xOS55LWNpcC1ydC94ODYvc2llbWVuc19p
Mzg2LXJ0LmNvbmZpZzojIENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldA0KPiA+IDQu
MTkueS1jaXAveDg2L3BsYXRob21lX29ic3Z4Mi5jb25maWc6IyBDT05GSUdfS0VZQk9BUkRfU1VO
S0JEIGlzIG5vdCBzZXQNCj4gPiA0LjE5LnktY2lwL3g4Ni9zaWVtZW5zX2lvdDIwMDAuY29uZmln
OiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0DQo+ID4gNC40LnktY2lwLXJ0L3g4
Ni9zaWVtZW5zX2kzODYtcnQuY29uZmlnOkNPTkZJR19LRVlCT0FSRF9TVU5LQkQ9bQ0KPiA+IDQu
NC55LWNpcC9hcm0vc2llbWVuc19hbTU3eHgtcHhtMy5jb25maWc6IyBDT05GSUdfS0VZQk9BUkRf
U1VOS0JEIGlzIG5vdCBzZXQNCj4gPiA0LjQueS1jaXAvYXJtL3NpZW1lbnNfaW14Nl9kZWZjb25m
aWc6IyBDT05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQNCj4gPiA0LjQueS1jaXAveDg2
L3BsYXRob21lX29ic3Z4MS5jb25maWc6IyBDT05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBz
ZXQNCj4gPiA0LjQueS1jaXAveDg2L3NpZW1lbnNfaW90MjAwMC5jb25maWc6IyBDT05GSUdfS0VZ
Qk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQNCj4gPiBgYGANCj4gPg0KPiA+IElzIHRoaXMgZHJpdmVy
IHVzZWQ/IElmIHlvdSdyZSBub3QgdXNpbmcgaXQsIEknZCBjb25zaWRlciByZW1vdmluZyBpdCBm
cm9tIHRoZSBrZXJuZWwncw0KPiA+IGNvbmZpZyB0byBzdXBwb3J0IHRoaXMgQ1ZFLiBDb3VsZCB5
b3UgZ2l2ZSBtZSB5b3VyIG9waW5pb24gb24gdGhpcz8NCj4gPg0KPiANCj4gRHJvcCB0aGUgY29u
ZmlnIHN3aXRjaCBhbmQgaWdub3JlIHRoZSBpc3N1ZSAtIHRoaXMgd2FzIHZlcnkgbGlrZWx5IGFu
DQo+ICJvdmVyLWNvbmZpZ3VyYXRpb24iIGR1ZSB0byBiZWluZyBkZXJpdmVkIGZyb20gc29tZSBk
aXN0cm8gY29uZmlnLg0KPiANCg0KT0ssIEkgZHJvcHBlZCB0aGlzIGNvbmZpZy4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--gVRncYq5vhEeetqBpTvR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5870): https://lists.cip-project.org/g/cip-dev/message=
/5870
Mute This Topic: https://lists.cip-project.org/mt/78357177/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gVRncYq5vhEeetqBpTvR--
