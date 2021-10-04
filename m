Return-Path: <SRS0=ChMZ=OY=lists.cip-project.org=bounce+64572+6770+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300BC433F5
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 08:16:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF956121F
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 08:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFF956121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XS9YYY4521723xBad1NjF0oQ; Mon, 04 Oct 2021 01:16:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.6470.1633335388179816980
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 01:16:29 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1948G6UO005247; Mon, 4 Oct 2021 17:16:07 +0900
X-Iguazu-Qid: 2wGrDIThyQ83tySSr0
X-Iguazu-QSIG: v=2; s=0; t=1633335366; q=2wGrDIThyQ83tySSr0; m=900msukDKlk5F94nY5s6yk6QZSAfevbdrXYya3XhW94=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 1948G4YT022733
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 4 Oct 2021 17:16:04 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id BB6821000EE;
	Mon,  4 Oct 2021 17:15:24 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1948FOJ9019150;
	Mon, 4 Oct 2021 17:15:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAmdBACXlXbIH7nmfbmv5yg363RHn+H+xIDi2bcDjhm1wFmzNqHgZudbDifti8ggrwc7IUN8+yFpYpD9YOtOLf4YMHz3OFZYZVDbvqsutUD+piUFIgyB9UsDssuRhBzODcEFDK2gOZGqf9MQADpRXnD0cse3caodkByNg9dWoqsph+HpyFfNW1DBlEHRiS5RbI4C7UoPg2Miyalky+gR2M66liaQCBM9ReXR4LM5+zP5mT3H2+OPZizbiEFW6uzHWbRQLpfzR/xAJ2HJ32muwmV97uTh2YHRAmh/f8RTPm/xBd20SzoIbuR6D0rhatX2S2P1LioHTIVquJuhEbzCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=866S+WOeyNiehBg5THI4S4Ln0QGCmtFsl+nE4i/gC4E=;
 b=LQ+WYDFNg49KvUeXEYBbNUqjyrC/xMINUePmJ3dQ8ukPKuNEV7+eWbMyCxcpuArcw6dAKxzQUgQmYwi9pFJ6aquWNhn15I3VmqIKoe9yTVEZJXZCa+upYUrkNYnhjV/JTjUF2EK1TkAK1jbGaRwa89GoM7fFT9hEaFf9Njrb83BVcFpKGvkFQDhOaLtc3KMAt5Dz0sbMmSN6uYkMcsZzkiaRt9M6igoBKqlRAI5/+iOK37gLzjGVrLNgHIe/2C4qx4S7oWvNtamIvHun3n/xNwlYRGFtDN6UZDrmydlwKKO4A8gDGdFVvsL+MXus2pUA3rq+i0gqdQDbxHQ2gJvQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.4.285-cip63
Thread-Topic: [ANNOUNCE] Release v4.4.285-cip63
Thread-Index: Ade498YKMUCfGDF2SCCSN/nSxw8lhQ==
Date: Mon, 4 Oct 2021 08:15:20 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252C6286EDCA87D7DB8B10892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33401ed2-208c-460e-f07d-08d9870f1bd1
x-ms-traffictypediagnostic: TYBPR01MB5551:
x-microsoft-antispam-prvs: <TYBPR01MB5551E5ABB652D2503A86F11292AE9@TYBPR01MB5551.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: PnbIIyNgSvaI5pXeipojhl5CgfpdUOaAwHblhHvQ/Ij9M0wVPSOKbLbde356FbC8snae6ByCTbL2q2eXRShvCC5R66levY4tMJnjENGWIz49N4f3Bdcu1yw0TAtAoc9LHhlXl1UO8r5hwTNv1DQfy6eaWODGmALXVxfcZ3TU6gX1GtdbjcLwtPIUosb3mnVW5TYFj0rKNYcV1+1AGbqsb5dZWoD1TcxM0j9VGWE6t/MnDfPuCDKwEl38U26XWl9ukDGU21BcSKoillYAtDFuN5dWjXsEcs78aSG4m8x9QkWOEv4VSFK8C0D6e5ruEFDdJlFIPxJhHHKYmA+dX+u4qmVxQ6bgsJ/2kCS1ud+59lsjgQDFwKlIlZuGFisip3DX8IsvkTuRbKuNI+BCnTRA1jrTBLRX7XOn5c5pAeq2dSmngB4xtbWQVIRbjAj3ODznHhgUXVJopubrON0XkjFXW11oT+SjXAWDNhYFBr61sCYT7WkwoACqCon5KzEDDL6ltswe3h1sT3de8g3Cf5QpnfcQkRyuwFnSOeeKeqYPtnwC2/E6gs+FJlppX153lHZ55MgneOfrkLkV3ZfciX7dcx9WbIYR59WqXVetPAkQIGyH3FrcyqIsu2wqd+GCmy4khNqGPBjTYsDR23cYW9d32ed3ty3Asxvnj3LwStEYTeL5gg59+dqHs2hamlI3pmJIACNREdT99J3JoPlLWP6No24NgYnf6w84hU6Gk0llOwOchIELc/Ubg3yN7imHpE5R0xVDltAiCBF7sDIsj1XkzJHjs5qtS8pBtn6hpU7kzjY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0ZaYldTVDY0U0padU1VSWExUmRnYnNPZnVSRG5TUkdzeUJxNlFlaXU4RU5L?=
 =?utf-8?B?bEgrSjFsR0NHT1IwRHJHVUZ5STIxaHRROVZQK3dETTRqa3dOQ3pRaDVhZ1Vm?=
 =?utf-8?B?aUUraTMvSHlMcUdBb3FZZ1FaWFBDYVIvWGVJTGFBYUloZWZWNXQrMElvdlJy?=
 =?utf-8?B?NEZUeW5MRUxaSlkzb0pHUHl4dHR1ZXZlZlNKcE14ZldhUjc2bGdYRDhYUEtV?=
 =?utf-8?B?dnc5TCtPdk55OXZ3T3VtdXR4M0g1cFZMb1NOVy9SczJZUDZIdXQvV2U2S2th?=
 =?utf-8?B?UWU3aHprWW9DZ2tGMXlaYk91YTRidkt6QTQza2FzbE4xbjBiaVpuOGZWaWZT?=
 =?utf-8?B?cnVGVThJZkllcTRYWUVTdlZGbTdQdVJLQnkvR2U0WVh6MjRIQlpsbDc2MWJU?=
 =?utf-8?B?QktQQ2tKalI1RkpVbUhnZnYzZ0dJK0xEblpEcHdrd0s3bVE3UmdpQlc4NDBL?=
 =?utf-8?B?K3l3S1RwSkpCVGQvNlBSRVhGSUw1c2dES0Y3VHk5Q0UwSFRHYXo0QVVZRTFn?=
 =?utf-8?B?Sm90cHB1RXllejVZS0xMa2dCNmp4c0ErRStDUmh2WkU4SUE4cnBiTjBIZXYx?=
 =?utf-8?B?T01sc093U1piZWdlT3lvaE80N3BiMzJEeVU0WTBuRENrdExCYWlMZDEwV1V2?=
 =?utf-8?B?S01oV0o1S3ZITlFaZzFhbjV1aGpXZWFNRFJJZFE1NnE3dEZqQnNFWHpIMUxq?=
 =?utf-8?B?RCtvODZEZzhienJrVUd1Nzg5MkdaOTE4RDcyRW9JcWlXQWlWVGxKWjNta21l?=
 =?utf-8?B?WVYrcWFkVDBlT0xaSURiTUszRWFZaWxBRTFUQjV1RjhvK1NSMGZDdWNRV1hK?=
 =?utf-8?B?V0ZtOWpIYUtrNDFYMnB4L0pYZWNVR2FBVWoraC9WUEt0d2YxNzYzU01TcEtQ?=
 =?utf-8?B?REdDVHc2Z2xsb3JHb3NLSXNGQ2ZNcElnK2RuTHRDZWVCUEVnamlkTklDVHBM?=
 =?utf-8?B?S0lkT3JEMmtGSTdWWVhiMzM2MFZyY0pjUGR5WXg0cjZSUktYT0IyVmtDVzZ1?=
 =?utf-8?B?MkNaY1lPSDlQTWE0VWxCYy9wZ2d3TmlHQ3J5Mkpkd3JjSUw3NDJLK29UZlY5?=
 =?utf-8?B?cWh4SkdSa2g2ZW9GOGN1VWhOWmtySnc2VUtiWlZqY3Axb05VeFh3VG82QWFX?=
 =?utf-8?B?c2JKNFc4OXZxbUJORDBxa08rb2pIVTBxMWl4eE9BTmgxTkZNRTdROGYvUGk2?=
 =?utf-8?B?T2E4UUVlNGpjWWJwd09aeG5iRDVSRG1XekVqYldWK1B5bElDbDNENWMrR2hq?=
 =?utf-8?B?TEEvdzl0bEU5NUZRQ2JmMzJLR1ZPN09Xcno0dzlMeVJ5cUg1MzR1cU1PZURW?=
 =?utf-8?B?TytPbS9WTFQyblZ2akRIaWVDYjdDQWhrdlJEOEZtdjFRbHpGNU1MV2RxMVRQ?=
 =?utf-8?B?Y3J0eXRIVXJ5Y1pWV1kzdzJYV09HcXh3enR6SC8rM0wyYlJVVG51cUxtSG5C?=
 =?utf-8?B?MTdhVEJoR3owUTR0MDNNM2RlWTVCQStobWxZNE0veW5UazhLRzRNRmhyVTVP?=
 =?utf-8?B?dk9BakpyUGUvZktGYVJ2ZEZ0ekZGMUp0S1I4TXo2ZmJXQi9UUWczRkllYzBz?=
 =?utf-8?B?cjF2eDhyRWJlZXg2THBaSEhJNFZDbkhrTzlpb2pVR1JjbkhGMFF5Vy9Cc1Mw?=
 =?utf-8?B?bU1xWTVwL1Z2QURBVzZBdXY5TWtYVkdqNTFSTEJmTEgwYktkZ0RKUndRQUhI?=
 =?utf-8?B?Z3E1bFl6OUJhQ1hQYmdWYVEwQlpDUWNtRHhGc2NlVEtkdmxpbkl2OVYrR2Zr?=
 =?utf-8?Q?ACOTRDrF/Y7kKg7Dqo=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33401ed2-208c-460e-f07d-08d9870f1bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 08:15:21.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlPd7lJq5vunfz1jEnBLI7/VbuYJjQ67YztXlyq8ZqIYfLmKCFDDjqFcZId/yqRVerulScyEComesoG+eFaGsvBuh68WSGrt775BZWy7lrLHcwOI7ptwJ6C0Z0wKjf9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5551
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
X-Gm-Message-State: zGarjzzCo4QQDy6rH5wJ73Ghx4520388AA=
Content-Type: multipart/mixed; boundary="gARFXEaWlyWeiXbvxrx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633335390;
 bh=u5t3pFv8tPOOYaKJ0shLlNC07P5l6SYXVBLKL1Amaso=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=daLRqiMzTR31mgvAW1SBMBDdKdzb0L02NBoE7cfe9YPGniMFMIa6/wlV9Zd7GzPORUg
 JP4ZbLSbXf3Ka81kyTwBvsVwOscGPn40ONzbvD69pC9FmVODFnmFGOoVCj2X1/3wKCX+y
 BIOVY3sCwNgeZk1S0mP50Q5QKHAHxz5PSzs=
Message-ID: <20211004081520.39LEmgfJVzh4h9bstgIB0J5y9780T9W7bujUgcjnvYo@z>

--gARFXEaWlyWeiXbvxrx5
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC40
LjI4NS1jaXA2My4NClRoZSBsaW51eC00LjQueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGZy
b20gdjQuNC4yODMgdG8gdjQuNC4yODUuDQpUaGUgcmVsZWFzZSBpbmZvcm1hdGlvbiBpcyBzaG93
biBiZWxvdy4NCg0KICB2NC40LjI4NS1jaXA2MzoNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNp
cC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjQueS1jaXANCiAgICBjb21taXQgaGFz
aDoNCiAgICAgIDE4MDE2ZDRlNjBlMGFiMTVkZTQ2ODNmNmNhZjY0YjYyODk2MTJhYzYNCiAgICBG
aXhlZCBDVkVzOg0KICAgICAgQ1ZFLTIwMjAtMTYxMTk6IGRjY3A6IGRvbid0IGR1cGxpY2F0ZSBj
Y2lkIHdoZW4gY2xvbmluZyBkY2NwIHNvY2sNCiAgICAgIENWRS0yMDIxLTQwNDkwOiBleHQ0OiBm
aXggcmFjZSB3cml0aW5nIHRvIGFuIGlubGluZV9kYXRhIGZpbGUgd2hpbGUgaXRzIHhhdHRycyBh
cmUgY2hhbmdpbmcNCiAgICAgIENWRS0yMDIwLTM3MDI6IGF0aDogVXNlIHNhZmVyIGtleSBjbGVh
cmluZyB3aXRoIGtleSBjYWNoZSBlbnRyaWVzDQogICAgICBDVkUtMjAyMS0zNjU1OiBzY3RwOiB2
YWxpZGF0ZSBmcm9tX2FkZHJfcGFyYW0gcmV0dXJuDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAg
IENJUDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNjMgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFi
bGUNCg0KQmVzdCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg==


--gARFXEaWlyWeiXbvxrx5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6770): https://lists.cip-project.org/g/cip-dev/message/=
6770
Mute This Topic: https://lists.cip-project.org/mt/86061603/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gARFXEaWlyWeiXbvxrx5--
