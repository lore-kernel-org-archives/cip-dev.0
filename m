Return-Path: <SRS0=fUXz=OP=lists.cip-project.org=bounce+64572+6745+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D6C433EF
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 08:17:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12E860296
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 08:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D12E860296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XVM7YY4521723xsX3yepCRdX; Sat, 25 Sep 2021 01:17:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.4736.1632557871362582907
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Sep 2021 01:17:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 18P8HWfO027182; Sat, 25 Sep 2021 17:17:32 +0900
X-Iguazu-Qid: 34trwupu9LuLQndrou
X-Iguazu-QSIG: v=2; s=0; t=1632557851; q=34trwupu9LuLQndrou; m=IUWNrgX2Xs2guTOF8rM9vV+8vFx5IHSC0YMj2iDzBX8=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 18P8HTSs006805
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 25 Sep 2021 17:17:29 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 73EA8100111;
	Sat, 25 Sep 2021 17:17:29 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 18P8HThI019876;
	Sat, 25 Sep 2021 17:17:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZSTX6zSq5X++BJCoylORG2liIzLEHbUu64FQqoCszZng0ndlb0JHdzXxT/jPJd+paNgL6/XYoISDkaw3wSXGhVEMtcLtywNpS/yZ06N9gqiMewnJaDWsIh0/9ykPiZZptR607sy90MaKTvyQxGYJZl5LSa2J1OKkI41oRaELnIlnwrOGzQ+zGote/vabk3B2BvK3Df95HQDO59o41PLXX48vRsSyINbiWOdmLTHvWzwQ80MzLuKUS4M+WGylZ3XtO9ON3maAFlWfZUJnxK/fMrtGSIg4aGADWageYhfDan1OTRe1YJ06HjdauYnM3QSoYp85og8jDch+M+zmfZ+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oGgzmSlDMVpD7dCMM6BrS10+LSGO+ey+qbBPP1inxQk=;
 b=SPv6J6TSZBeehJfCfgb/8D5mQGnghO2CLraiSr3jSJ1z9OlOmelk5LlBcGzyGAfNxzBxmu3unaxisReWt7LdTiyeTaH0yC6HW7FixHJZmNv7AvjDEjvMMX5gMsUjssLLfmdE6Bc0Y6QgeGaN61f5inF8LNfsN5SvdA8ta+mylB9c4vvQAAL/9vxTebRyYhrl7TCNb/HPtD0yukZz5CdSyjLteUuH90cWszp3VzBaBC8gS381nXYrb7ta9YR3LmLT9DP63ffzl3jm5O5x5T+H7bPiyEEgrgXDCaoGrpaPwnjF5vKTe38ncfN78++9ORzs6xcw/igw7YfXf2HdeNflZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.207-cip58
Thread-Topic: [ANNOUNCE] Release v4.19.207-cip58
Thread-Index: Adex5YvyLIIG84k6QVuX6btUwajbiQ==
Date: Sat, 25 Sep 2021 08:17:25 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62525F9F3D7F891FED79EE5192A59@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c21e519a-0945-4082-c4dd-08d97ffce879
x-ms-traffictypediagnostic: TYAPR01MB5355:
x-microsoft-antispam-prvs: <TYAPR01MB535585EBA4E2F05912EEF8B792A59@TYAPR01MB5355.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: K9H4BvV0XhUt8JM3qpblWO41+4E9JeFuI27dVZX6n++EZ6p7Y00SyMsc4jktcIQP4gPCLy0ZWb6dTwcxmZQhhx8SxVDd3SLv4RdfbhzbTEYr8n8Uu/5T2lyDbRMP9MPGXp/i3RMBOINVU7+oC1jmRnz2eWCZaMmWd7Ynmzfj5gNZVuhaeinsyz/Jw77xa86QKgqZktJZNy2zx5yZzuAI4TGwWfweCY0wg+MqGn/KIyUtRqBisGgarP31fzSXtnvi2L4AClwYIvOEjCDB9h7cClQmXx4CkHA+KjiTQIOLm68cFCUDkICGx7/EKl5C3G7SF/btbNLh6bJ8L+BfcpfwVkXB7c2/NBzSWgaonSDhuFesWFJloAT/0FcvYjRWU/MNuq4Ste4OMci9IYRksObc9s4sMbnG1DiAk0LV9SEUA9AVP/l4qdDaGBsqLyreC/csygKM4DQR79D2lZwZozhhtXhKh/kPc5E+dm4T78MRsN2r0t2wicczbUCmAhjWO4kaZY+A28ctrt6T9UvzSWJOX5qdrbCkt6Kv2OYIce+GzXnHB9vGoLThg3zrMAtzNk3UFGFrKxoIkk4uGRy4eusECqX3sp1mXlmYpwJE0yEbo0C+/JabrHuoJjAndSugt/Y9o4rcQPnAV12KN1Nr2vSwqbgNeMHjxJsUNaTM7+iHrE0CBSo4QVLkbHGtJHTjtgs/6pGMY6YRdtMsdm6TwJbtMgjwpLMFDQyAOmmuPknsPHeHf7n/3z6g7yr84jtRJ8nm9dCH8LL5gr+wOuTki9UhXbmE2EMd02Jg8kYHyoLgtcs=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEZiRTQ1bXVqVmpsa0Q1TWowZXVsK3luUmY0UmhZOW1TYjhDRnFzbDZYSUwz?=
 =?utf-8?B?OWRjbXF1TUE5amdrT1pvN2VMSEhaL05ZcGFxVnI1VURSUUxUR2ltUWgyRHAr?=
 =?utf-8?B?UlpaSnJzVzJzT1p5QmN0aUxDM1l2V2NndTlabm5DM0wyZHM5bldub3d4aWRk?=
 =?utf-8?B?bmVVcFJwaXA1eWRVem1RRGhUWnQwUC8yMGcxNW1Dbi9kLzZJcGg4WCtkM3k5?=
 =?utf-8?B?VFBiZzJCdWdjUzBweHVuSjNIdU5idkpHN1lMNnJrVFJyVXQ4dURjRXlpejBo?=
 =?utf-8?B?dXRFK29WZzlvV0N5MEJhdnZZbERPcXkyUGk3d2lvbmhsMjROSmJkd2tKUER1?=
 =?utf-8?B?bjhGNHZob2pLT21tN0dqNHp2SUZjSFZVQXFBSUFCU1hmWEtQNm9IbDBxT0tt?=
 =?utf-8?B?L3U5bzJqZkFVTmNBUHVVei9oaTE3WkZsKzN3R1VvM2hMbzNsYjEzcTVSNHJU?=
 =?utf-8?B?eW5JcDZleHp0SXFtUHVOU0hFejVhS2JMWGJrdUo5SlF6d0dtZC82RDJ6ZkM4?=
 =?utf-8?B?Ky9ZVVNIa1NjRXdyZm56UDNadVZna212UFJzRWxma056WG5PYmhaOXZKeFNp?=
 =?utf-8?B?NGFFSE5LRWJwbHFHdkJ2U1NFNEhoV0N1ZDQ3eGtGamE1ZUZsYWpvTDVxaENK?=
 =?utf-8?B?SHdoZmVaY1ZaSndDeGNsYmtMUForVDZTc3NTMWpNbjA0R2lWcVBGN3ZGV0dk?=
 =?utf-8?B?Z2pqQmo5VEZsWmt1MWJsbHh6aURQc2lEazBGVzJEUDE4N20xSUdJZUVRS2pI?=
 =?utf-8?B?bGRVSzhncTAyT0FIUzhJVFZTRDJxZzNoWDR4VlB5OUU1UFZZQUVVNTZTSzZJ?=
 =?utf-8?B?NS9Ga1kwa3BKWEhuNFZiMk1LR25BeUR6YVZJQjFySU9aeFhWNEJ4c3hJZVZX?=
 =?utf-8?B?SHphNFpaTWtHSVZRVUhnS0c0NkIraHNVR1ZEcmtUWGQ2ckhWRldVdlJuZitT?=
 =?utf-8?B?Umw0UzZYMWMrSld1TEpTZUMxNHZ2UXFXUmN6c1VYVUJwdU9Pc3dhT2xMZU93?=
 =?utf-8?B?TFNNLzZhc2lYd1Z6Ym93ODdXMVhFdXNPWGNQZDE5R2V2bVFjREI4K1ExVEt5?=
 =?utf-8?B?U1UvZFpjUnVicmEwL2JpK2tVcGVjUXBCK3FDNkRETitIenRTRSthdmJrU3o3?=
 =?utf-8?B?U0RoOCt3dlhPZHRTY3JxY3RVRVZFNDlTU0JIbHU3WnlLRTdoeW1Kd0dDK1BP?=
 =?utf-8?B?VVRYR0pkS1l4QkVEVVNsd3h0WlRTazlqUlU2UVByTDlwNUMxUExDNjI1T09Y?=
 =?utf-8?B?ZlJLTnM4R1RYWUszVEtETXROYWlnWG51UHowTjJFajNpdTMvaTdZWmQzTHE4?=
 =?utf-8?B?VGhBK3RyL2dKZ3hjeTBvMlJRVkhVNlU2OXRpYmYzRmFINEFWUFpZYzhrTXR1?=
 =?utf-8?B?Rzd6eE1RSGdESXFsSW1KQUVRTks1bG9Wd3hEU2xRbDV5Q2h0bnZEQ1pHMUZs?=
 =?utf-8?B?VVdMWWJ5cWUyQVhocnJmdCt2N1FhMTRFRUVyRmZQUGJyVUxEWWpLTlFRdWsr?=
 =?utf-8?B?MEEyL1Avb2xKM04zZUpUQjlYSk90WWtXa0ZFdXF2NU84S2IyazRDZGJMM1BS?=
 =?utf-8?B?U0V2a2cxNVdzOVBGWTYrVCtTMmlCa2x0UjR1QThzNmtPaVN1eExmTFExN0RN?=
 =?utf-8?B?cDVORHlkUDZUYnJlcGloVmpSRVV1WndsTHFBOHVaOGtSanl0aWFCT1VJUGkx?=
 =?utf-8?B?RzdSK2IrU1diZHAyT3hiYUhPSlVIV2RhdUVrT1ZWSVdQWlFGYkFvNnVZMW1V?=
 =?utf-8?Q?P+WM+7z30Gf4Jhtj2UJtz+kFBCLiZDZjeiyHyPR?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21e519a-0945-4082-c4dd-08d97ffce879
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2021 08:17:25.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mVBXBs/9f4mh32z8xsKo1BpuiwoY+7b9gnCrUVUaSdI1nCjRd8MLspEXtHzoxsVAupb96H61dpqV430hWHTpgmhkh1wa4j5yEAh10gftr92TeQ6SpiC15e60QTqa6Uz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5355
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
X-Gm-Message-State: 5lH87ockyNOqInpvboqpRcyJx4520388AA=
Content-Type: multipart/mixed; boundary="VvrToGR8qJHKSGblOlYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632557873;
 bh=TlZLMEvqikEwnVJh+GOUgb7DBQYkKwGB2oyBiRAOAx8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=jS2MhjfHR6ZJbTpgmzPL6XqlT8eNZPSWMeQUjDKTE5m+k5tt0RuHY5GtRi2ITSoK3qv
 kEgShGy2wQWIA7YBEdvVeEa282YgW1h8pzlb7BB4oop7aYMK1Fd2/XMhZzrJIAWkDwcBT
 tbUswbfTA65iD8kkNGo5gG/R2+nfQxgju8I=
Message-ID: <20210925081725.9SI6fD3PuXMdpwwgB22EoZnT5Ks9AFvVVSGmeDx4WAg@z>

--VvrToGR8qJHKSGblOlYz
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FOTk9VTkNFXSBSZWxlYXNlIHY0LjE5LjIwNy1jaXA1OA0KDQpIaSBhbGwsDQoNCkNJUCBrZXJu
ZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjIwNy1jaXA1OC4NClRoZSBs
aW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBmcm9tIHY0LjE5LjIwNiB0byB2
NC4xOS4yMDcuDQpUaGUgcmVsZWFzZSBpbmZvcm1hdGlvbiBpcyBzaG93biBiZWxvdy4NCg0KICB2
NC4xOS4yMDctY2lwNTg6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJh
bmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgYzM3
MzdmNTYzNzE3OTczOGE3ZTg5OTM1OWE0OTBlMzQ5ZWU3NWQ4Mg0KICAgIEZpeGVkIENWRXM6DQog
ICAgICBDVkUtMjAyMS0zNDU1NjogYnBmOiBJbnRyb2R1Y2UgQlBGIG5vc3BlYyBpbnN0cnVjdGlv
biBmb3LjgIBtaXRpZ2F0aW5nIFNwZWN0cmUgdjQNCiAgICAgIENWRS0yMDIxLTM1NDc3OiBicGY6
IEludHJvZHVjZSBCUEYgbm9zcGVjIGluc3RydWN0aW9uIGZvcuOAgG1pdGlnYXRpbmcgU3BlY3Ry
ZSB2NA0KICAgICAgQ1ZFLTIwMjAtMTYxMTk6IGRjY3A6IGRvbid0IGR1cGxpY2F0ZSBjY2lkIHdo
ZW4gY2xvbmluZyBkY2NwIHNvY2sNCiAgICAgIENWRS0yMDIxLTQwNDkwOiBleHQ0OiBmaXggcmFj
ZSB3cml0aW5nIHRvIGFuIGlubGluZV9kYXRhIGZpbGXjgIB3aGlsZSBpdHMgeGF0dHJzIGFyZSBj
aGFuZ2luZw0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZm
aXggdG8gLWNpcDU4IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJlc3QgcmVnYXJkcywNCiAg
IE5vYnVoaXJvDQo=


--VvrToGR8qJHKSGblOlYz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6745): https://lists.cip-project.org/g/cip-dev/message/=
6745
Mute This Topic: https://lists.cip-project.org/mt/85856834/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VvrToGR8qJHKSGblOlYz--
