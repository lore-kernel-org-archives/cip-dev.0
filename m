Return-Path: <SRS0=uDtd=DD=lists.cip-project.org=bounce+64572+5479+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E3DC2D0A8
	for <cip-dev@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB632080A
	for <cip-dev@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CIUAS33r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB632080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5479+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hktnYY4521723x8SiNiVZrMO; Sat, 26 Sep 2020 00:46:58 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.7036.1601106415234871882
 for <cip-dev@lists.cip-project.org>;
 Sat, 26 Sep 2020 00:46:56 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 08Q7jxFa004161; Sat, 26 Sep 2020 16:46:00 +0900
X-Iguazu-Qid: 34trJE3d6YvJDLB8cM
X-Iguazu-QSIG: v=2; s=0; t=1601106359; q=34trJE3d6YvJDLB8cM; m=VHyDttLsRyxcJxcVx4MZttox+lt8Zh0Zdrgn95lc+zc=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 08Q7jw2T014677;
	Sat, 26 Sep 2020 16:45:58 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08Q7jv0H002607;
	Sat, 26 Sep 2020 16:45:57 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08Q7jvkG006610;
	Sat, 26 Sep 2020 16:45:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBKY2b3HUp8ITOyHtZN+cl2hUDc3a+AEYLN7egNbr4AgfjS2QBcUSLo0836kdiN7uoHM0q49tGo4cxTu/2BfvbfTDagYYBODwXgS28f5Hf+WDTqyM5PV/LvVHoQ7RKP4kKilvtAqu87AxS7X7geZRYFCgb6NmCSvUYJswl9pYIk1GLTxGLrxz4nPDsz1eZML90efyZpnQoR43CeohtT5/U7AfDyOMZFRcQCFsxLdHXaeOtNR+ddKGl+7g/MSW+sC5SViKi2dAfCYPX94rJ3k+TH7SDb9ctVLj0UgXgSnzpzQuU+mJ78m3+HDDt+tdMbvoTJ6BAuWWYj7BPNFa9+UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+vF7hvSDEpU8xPlFS+PpcNw7vlJMQdvRsEme+NVgak=;
 b=ADMpEjwttpluvsWCyGWPCmS3xsdr758kM8j8ywhL5pB4T/VuD5fJ5wZODtmvwnyWx7JdACh0gnHJ/ZJV0CRt+tvIuex2jcFaKiVQ2ZVAL0rllGUNReuxOrbJJX/hpTzggxwmh6krRQGSN2dpT2jQA6uyuXXZO7oYQc6U7JxsJfl4X0e76T4JcE1MLRMyrXlbLLhRrlE4BlaENKPv3ozY7rWXZNzgdYt2JyXTCYUfA69WEYmtLLxgxp/7NSH0EJvBCE03n8IBO2b3bw3AbtTWQaWxLPkKNRzROAGrzZCExGPDkFH0z5xE2d0zlnxunZtMRoazRY8Qb56cl8npTcAUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <ben.hutchings@codethink.co.uk>,
        <pavel@denx.de>, <wens@csie.org>, <SZ.Lin@moxa.com>,
        <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.147-cip35
Thread-Topic: [ANNOUNCE] Release v4.19.147-cip35
Thread-Index: AdaT2Outh4HhKIv9SCCYNkK8RfhQFg==
Date: Sat, 26 Sep 2020 07:45:55 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29831FA29F42D1EA889F810D92370@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f61b601-ccaa-44b1-4d89-08d861f0337e
x-ms-traffictypediagnostic: OSBPR01MB2246:
x-microsoft-antispam-prvs: <OSBPR01MB2246AE0094D2B6A2DF5FB6BB92370@OSBPR01MB2246.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pUB2A7xjbRqIdO59VkjenEKxjHYHQQSTmmKlJwH5lCVWX3RriZOSIrB1XJoSunN3pW4CrLJrG98+jjVyc5op7XNBe4shAidDkfeubfWzy9UIqrD8XT+1tS1+hkOMUNyWY5GW9LfGGj2UJmdT7EvzZ4KwYBE7q2MJXSg+WzJI5GtH1pCU3iylUH5EdmMNaqqwB98v/VDcikKtSBAUTnRUiw3IyyXmkpxuyFqphJGZ2SUKaTJcBaelqnxT8Gvl8JZ0SWA5J29wEV8RP/gJ+Web5H3JJz7wPus9EsQyyG4bhkOCeG5C21wKSdhPqA/AFqfKXdGkThwyrsT9t25EwKVHFTg4jEUGqMV7z8i1bg4JTuBMoMhbQfSoUvPiadlhoclLaWMBYwPi5wiDecbWp0QP2Z4V5tOnFJjfuT8HVxusbf5LaTdvjZihIbL90xoNtEnszeenuHtPqF2GxX3V6ZsuNw==
x-ms-exchange-antispam-messagedata: +iQqMbjta8m0FWwO5wBcrKWxerMn62FjPxQHtJtnPbj++k2UTs6RHxro2w3H1CvffrsvhR39xLf4WEh5XGjr4H1b30WEcvXbQaZS5GZ9L0AG4Eiw5xGtRCbb2BLqc+o/1EmfqtTxWLdmYn/hL7quro2RU9rdK6QkpRYfz6n0a20OUxSOlexcfTW6JtQhGR8fajl9ctA5SzPEKGkLjCKB3r6g8XYNnoS+0231mpbKsMMlUgug0RjxgG2+DEzwd9K1IT/NlmnEeQKbNJFQLlFh21k19m8ZV8DsK4mWJuwUUVeQXYlGG0zYHKkJW6ZKw/RZQPftQ33WCWt/N29Jf+TVERtORaYOT1oLz7o9WaNniKsr9wgeKhnXpqw2X15DdrBH6Kvql0lrisGKn4buHOgBQVDNiDaxQmlqARR8aD6ctvnbnZrsNveiBscGn/Kv3RUOf/PpMN5wP2Cy4ZU61N+bvUzWv8EyAGmMb5uS2/KqN5AtIo0y9dQNp0b59gxtySJXSf9UGgvDrl2bTTtCAAQoMyZFoIk3vrarKuggY5Xz/YGyoFAeGFuJ/6tQcmqci3HXMd2pc0PlyYJCYwYS26zKHEyccpHCf2hYx9GlL5of5NPnhQLndUkKwDv8oPjoihdqcKMOAgb335qCm3kbIX2Jbw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f61b601-ccaa-44b1-4d89-08d861f0337e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 07:45:55.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYVlYyxzyFP6VxxqIw0xkSWgu4Z1LuKhUwtp0xum6pxpUzCbsooGzA0jlUYMPkFWdtPqk1mFjNcxD/yz6tPrnH0CgBsBq7wwbfk+yMAMmLc2j1tMXOmrO8Cp5f0ivT3t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2246
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KeQxRJOrAUNxEXCos1XhhCytx4520388AA=
Content-Type: multipart/mixed; boundary="x52nD5CJRvBYeJesPi5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601106418;
 bh=+pnisGCvI9ulrfpHTRKKzl36Avk80PkDtBZG5u0RCTw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=CIUAS33rpHPREpA04VQAdrlKAKaLuBQK859ljEgd9ZUx6eWSqlsJYTGD3a9Bhn+I0ZY
 nQTgsB/hkGOzlrIfayBcmlZ6NrestPQCurXz/hcjNPxSsRd2wk4Hi30DT7yx1NS5CpSpv
 Vj96qBIc5pq8sCADpCyXz5J0qQNcYzcG+8Y=

--x52nD5CJRvBYeJesPi5y
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE0
Ny1jaXAzNS4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xNDQNCnRvIHY0LjE5LjE0Ny4NCg0KWW91IGNhbiBnZXQgdGhp
cyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTQ3LWNpcDM1Og0KICAg
IHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQu
MTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIGIzODUzODFlZjNkOWFhYjY2MWI4MTE1
YjJjNTAwZTBkYjUxMDkxNGQNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZl
cnNpb24gc3VmZml4IHRvIC1jaXAzNSBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJl
Z2FyZHMsDQogICBOb2J1aGlybw0K

--x52nD5CJRvBYeJesPi5y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5479): https://lists.cip-project.org/g/cip-dev/message=
/5479
Mute This Topic: https://lists.cip-project.org/mt/77133147/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--x52nD5CJRvBYeJesPi5y--
