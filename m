Return-Path: <SRS0=bmCp=7Z=lists.cip-project.org=bounce+64572+4796+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59882C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 12 Jun 2020 22:59:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAADE2078A
	for <cip-dev@archiver.kernel.org>; Fri, 12 Jun 2020 22:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tcA8T9QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAADE2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4796+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 560pYY4521723xYNpaf4GcZh; Fri, 12 Jun 2020 15:59:27 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.617.1592002765062921131
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jun 2020 15:59:26 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 05CMwvlU018895; Sat, 13 Jun 2020 07:58:57 +0900
X-Iguazu-Qid: 2wHH6kkKrQ7EtMJsPo
X-Iguazu-QSIG: v=2; s=0; t=1592002737; q=2wHH6kkKrQ7EtMJsPo; m=Dlxy96mfR6MqwF7sRNicZK0MTHPoWlAoIjASgfmVhrw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 05CMwt0l008773;
	Sat, 13 Jun 2020 07:58:56 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 05CMwtPs020264;
	Sat, 13 Jun 2020 07:58:55 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 05CMws1m011795;
	Sat, 13 Jun 2020 07:58:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiMe5y+51WJ4Wb830KfN39pzg8paYq5hAMTs9whAkXWT7Ef6jZDVbuaq6s1dzncxn/Mi+Ru4ULJyRNkYIJ6tgdu4tNSbB9huwju6qeHz+uJb3hGApvtK1LmIhrBfCl6IoAwVeKax6QtBeuft9HbTqWmiwtKn0opljmQnmW9fnYYKqVZA6sm73carTDc6a+tTmv7hg+8ncpcXofgJomR2U9M4Ay6BQKwIs4CnKFkdCZdORh3A2I03fiLFvfOTlX95/Bnl5el486gll1C+PZP81o9O03x5HKTgcygOv4lKv3K9pujrnTDjUhrrGe3uk0/mqC4v5ZDHWHZe/8wkjnBVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnMziK8/wQd4a9Z+VVo15Yod0xsGhknVPaum2fFBdcE=;
 b=mIo938M9QAhsjUAESXrQwX09JA4LIF4rreAdfmqI1jk6rqifUlUK97g/B6DsP124aQ94ld2jKTcZlmLXApgzvoAASeM8xWSDcvcuoWt9+0VvzxUampe1Rwt3nmj3JoEWpRCnajMAMyYvJbwIU+8HCX9RiOFJNpQb9hRSGZkd/9FSpTQ+fSzYEUVX04vVCzaaGPUaPQhvRKfOSmcfLSp36/yNOABMwm2Mb1b+HwAwqoCKa24w2b5iyFQJFBf2wa7yYNZ9rXn9+XsYzIIeWWr3d7Z/4gOgjDMj7EXqHtgRmMnCcN+mXryJBhbdDOgvgncdIDBI3eZ6RB6C4f4nxzHvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>,
        <wens@csie.org>, <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.128-cip28 and v4.4.227-cip46
Thread-Topic: [ANNOUNCE] Release v4.19.128-cip28 and v4.4.227-cip46
Thread-Index: AdZBDNVjq3oz0/8IR869rv8M6pLxHA==
Date: Fri, 12 Jun 2020 22:58:52 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB299028EE6A2F9FC0DB534A8892810@TYAPR01MB2990.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1819fec4-dc90-48f2-8aca-08d80f242d88
x-ms-traffictypediagnostic: TYAPR01MB4718:
x-microsoft-antispam-prvs: <TYAPR01MB47188900D93F8B9C04F88CC592810@TYAPR01MB4718.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V3P/1K/r3YaEl1O+Dm2q7ra7NzthfJYzI3R6mUMZrmnR5Ex0DGjAxH4b3bHnOqT0pc/m5Apvg9GEKiKIhKwK195VSw9jqlddxmRS0s65ChYvuqKtko0kJzKE1x9fiotOeQr3eLvJ8oXc6csvQk/XjEy50LX5QFj5GmjqeEfJGFEI4LTXlBE4ZmoW5Ma/6hidefjPDL6QrLuuJrIR12Fli9TYSQ/0n1sLocgMvRv1bB/8BvT0gRUApJDkdxC0BRAU9EkovC0ev8FVDsY98vh/RbIfeL/ohAQIG8PrEw0nbG7dAUT6T5oCzLR2rENroOCMvMGaugjBHeigJZzwHh4KFxUO+mP08ax3veG7NRaECo76lOp5Q3ToHvV5tDnfMZwEvIPpUS6aOHGE3qf/hXoPMQ==
x-ms-exchange-antispam-messagedata: 1X/iV/rmGm6QC+4XxYgbGi+w9f47Vo1Mp8tRelvGI1uLyEi4glVxvYGwOhgBbr5UQTU03xWwmcXWinHSGH6U14JDWtWyvZ2q9qKobLbNhMiSQtuYEjR0pMwotsVU4IbGGmuKVxsFj8Vw+EM8PI1qmaPVpgFOwJKSSA/RwYEMHLGRXZIGESNosTg6RWgyvP3XjCmB2dSn68l4uxzNNk3FrEdMJtESMiK3VUjJVYEa8QsvD5y/Gu4F8+gudldt8DG6dIFGksgzmGveymPtWepJK7cZJ7x5D0oMa8Fu6CkdJo7xaQr3hFrJrooJkMGwSDC62QHqNC6/YT+R1VT/zmQlLB6rx96Qt+DKhkG2TkYeqts+nB9616JYtCg3tdMmpL10TjnD7G4Nfbj0iEyIz4xhA+ZBvId9UF0P7hSeOHKpUEzhb9JGejWMf1Ww+4VEFhlFiPnTOsNUiUbESd7CzfoAgpFDwV8JhiLQdWebaLf8CFo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1819fec4-dc90-48f2-8aca-08d80f242d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 22:58:52.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QG6fQI/bdUiU5XHMyGS2E9qKiPe1F2FVo4eUVec5CKmh2ceuWh9VXOR1Gk+Gyl0hDNgo3JCSCMDk9prqXqMXQRAKhg/zVzLxQjEB27pNqOkjoKllxDRToa7uPu0fhkos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4718
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VYhpQBqQYfmrbLsWeIvcZN2Vx4520388AA=
Content-Type: multipart/mixed; boundary="SYgY0bVeU3M1afQuhIGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592002767;
 bh=N05D75aXvt+GxC4clIncofhIAddxgNiwf4sZ7JZVXzk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tcA8T9QSXRYaiFc83IwkGsOc/sWJP5uJ5bbFk1LceebCVkPRCQjn3VmXyXD5wyj7UMa
 fXwyjIVyEFEF6V+x/ZUmt3YBP2JDsXs+opv1fl/mpkJoCF+q0Sfg0q2HF35H1npWXd0MN
 tPaANmP0uowZ08kT69T27bCR9OOjHumJwjg=

--SYgY0bVeU3M1afQuhIGk
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjEy
OC1jaXAyOCBhbmQgdjQuNC4yMjctY2lwNDYuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTI0DQp0byB2NC4xOS4xMjgs
IGFuZCBUaGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbQ0KdjQuNC4yMjIgdG8gdjQuNC4yMjcuDQpJbiBhZGRpdGlvbiwgdGhlIGxpbnV4LTQu
NC55LWNpcCB0cmVlIGFkZGVkIHN1cHBvcnQgZm9yIE1veGFVQy04MTAwLU1FLVQsIExDRCBzdXBw
b3J0DQpmb3IgaXdnMjBkLXE3LCBhbmQgUE0vT09QIGZ1bmN0aW9uYWxpdHkgZm9yIFRJIEFSTSBT
b0MgYW0zM3h4LA0KDQpZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBh
dDoNCg0KICB2NC4xOS4xMjgtY2lwMjg6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0
DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0K
ICAgICAgNzc1YjAxMGY2NGE0M2ZlODI1ZjIyYzg3ODRiNjU4OWFjNDI5NTk1Ng0KICAgIGFkZGVk
IGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDI4IGFmdGVy
IG1lcmdlIGZyb20gc3RhYmxlDQoNCiAgdjQuNC4yMjctY2lwNDY6DQogICAgcmVwb3NpdG9yeToN
CiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Np
cC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC40LnktY2lwDQogICAg
Y29tbWl0IGhhc2g6DQogICAgICBlNjUxNTJjYWZkZTVkMWY2ZGI5YjhlNmU4YTY1ZmVkMmIxOWVh
OTFkDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0
byAtY2lwNDYgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCiAgICAgIGNwdWZyZXE6IGNwdWZyZXEt
ZHQ6IGF2b2lkIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgd2FybmluZ3M6DQogICAgICBjcHVmcmVx
LWR0OiBmaXggaGFuZGxpbmcgcmVndWxhdG9yX2dldF92b2x0YWdlKCkgcmVzdWx0DQogICAgICBj
cHVmcmVxLWR0OiBTdXBwbHkgcG93ZXIgY29lZmZpY2llbnQgd2hlbiByZWdpc3RlcmluZyBjb29s
aW5nIGRldmljZXMNCiAgICAgIGRldmljZXRyZWU6IGJpbmRpbmdzOiBBZGQgb3B0aW9uYWwgZHlu
YW1pYy1wb3dlci1jb2VmZmljaWVudCBwcm9wZXJ0eQ0KICAgICAgUE0gLyBPUFA6IFVzZSBzbnBy
aW50ZigpIGluc3RlYWQgb2Ygc3ByaW50ZigpDQogICAgICBQTSAvIE9QUDogU2V0IGNwdV9kZXYt
PmlkIGluIGNwdW1hc2sgZmlyc3QNCiAgICAgIFBNIC8gT1BQOiBQYXJzZSAnb3BwLTxwcm9wPi08
bmFtZT4nIGJpbmRpbmdzDQogICAgICBQTSAvIE9QUDogUGFyc2UgJ29wcC1zdXBwb3J0ZWQtaHcn
IGJpbmRpbmcNCiAgICAgIFBNIC8gT1BQOiBBZGQgbWlzc2luZyBkb2MgY29tbWVudHMNCiAgICAg
IFBNIC8gT1BQOiBSZW5hbWUgT1BQIG5vZGVzIGFzIG9wcEA8b3BwLWh6Pg0KICAgICAgUE0gLyBP
UFA6IFJlbW92ZSAnb3BlcmF0aW5nLXBvaW50cy1uYW1lcycgYmluZGluZw0KICAgICAgUE0gLyBP
UFA6IEFkZCB7b3BwLW1pY3Jvdm9sdHxvcHAtbWljcm9hbXB9LTxuYW1lPiBiaW5kaW5nDQogICAg
ICBQTSAvIE9QUDogQWRkICJvcHAtc3VwcG9ydGVkLWh3IiBiaW5kaW5nDQogICAgICBQTSAvIE9Q
UDogQWRkIGRlYnVnZnMgc3VwcG9ydA0KICAgICAgQVJNOiBkdHM6IGFtMzM1eDogbW94YS11Yy04
MTAwLW1lLXQ6IFJlcGxhY2VkIHJlZ2lzdGVyIG9mZnNldHMgd2l0aCBkZWZpbmVzDQogICAgICBB
Uk06IGR0czogYW0zM3h4OiBBZGRlZCBBTTMzWFhfUEFEQ09ORiBtYWNybw0KICAgICAgQVJNOiBk
dHM6IGFtMzN4eDogQWRkZWQgbWFjcm9zIGZvciBudW1lcmljIHBpbm11eCBhZGRyZXNzZXMNCiAg
ICAgIEFSTTogZHRzOiBhbTMzNXg6IGFkZCBzdXBwb3J0IGZvciBNb3hhIFVDLTgxMDAtTUUtVCBv
cGVuIHBsYXRmb3JtDQogICAgICBBUk06IERUUzogYW0zM3h4OiBVc2UgdGhlIG5ldyBEVCBiaW5k
aW5ncyBmb3IgdGhlIGVETUEzDQogICAgICBBUk06IGR0czogaXdnMjBkLXE3LWNvbW1vbjogQWRk
IExDRCBzdXBwb3J0DQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQp1DQo=

--SYgY0bVeU3M1afQuhIGk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4796): https://lists.cip-project.org/g/cip-dev/message=
/4796
Mute This Topic: https://lists.cip-project.org/mt/74849817/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SYgY0bVeU3M1afQuhIGk--
