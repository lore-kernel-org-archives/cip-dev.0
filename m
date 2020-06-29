Return-Path: <SRS0=71f2=AK=lists.cip-project.org=bounce+64572+4845+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798DAC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 01:15:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EF620768
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 01:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sRoUBKYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EF620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4845+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id a6lEYY4521723xwjV06TJomC; Sun, 28 Jun 2020 18:15:51 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.9614.1593393348459183675
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jun 2020 18:15:50 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 05T1FGtB021449; Mon, 29 Jun 2020 10:15:16 +0900
X-Iguazu-Qid: 34ts1iCWM14HFR1W69
X-Iguazu-QSIG: v=2; s=0; t=1593393315; q=34ts1iCWM14HFR1W69; m=2i34J5vGMBEnE6zo7XQdQWYdjVNUQf6LCc5NxRNu+p0=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 05T1FDj8015040;
	Mon, 29 Jun 2020 10:15:13 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 05T1FD1i019327;
	Mon, 29 Jun 2020 10:15:13 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 05T1FCc7014223;
	Mon, 29 Jun 2020 10:15:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaEHmMD3VJ6hTpd/g4VH2Sc7GQFdtaGZ80QKle8hTrWjE/geOGXxuH4beKJvmG09DMA+9lciWsIobcI1TeZhCQjNnVCd5Kv2BovXv6IgZrD2U/pcDYiHxudGHhqYlNBh3AvjM49FMZSPq1y4E4HGTjaLKJLySK/V2lh9NDI+jR/EaRBqAWrq1PGGfKNZsHjIcuKmSY93bmWTq3BVeR3+8BUYA6zKeAqgpsK6BjpmR797Px3bNPR+tnAI/v0evc5PIS79YRalQGcZALoMA3/dDE1ISV3vhAiHdYIouBTu4SQ8yDq92f+fPyNsl4jYHSDB925ClM39hN2Ff2HNAqNuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yltwXQn8rgLoMpWQK+bSP6Wh5GVZ9tih8sTdC1ID7i0=;
 b=Ha1S3vYfnMHGqItS6cbZLtcwrcNIYkDhZpe6B6UUtcLmxCLQsN/fldzAjpLHqadK78MFMe/AgjjQY7swcQs7WhLa0hHaFZBdEGBfivd8qbBktaQkw9H9FSvvALnOGizJkAPrO4t4aN1NrXcbjig4Q/EAfH6/VzKjiZt8DXUk6AaYQP1EVLdeK5isJ0uGxNbrfwi3CbL0ZPWdG2vHxk2hENKn0SvBFQ4dWlH4tZbO16j9SrE2LQ562RWKfMEfj4lZlZaQcGDV93xFASDsH09o6j+ZMqleV/snwUKX/TlTZlXSHjqX19wcEKZZo1m+i2C9zYf6TVPiJ/ka7eaId4LX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>,
        <SZ.Lin@moxa.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.130-cip29
Thread-Topic: [ANNOUNCE] Release v4.19.130-cip29
Thread-Index: AdZNsoWhNbdVs7OgTvOgTa3nwk6Ghg==
Date: Mon, 29 Jun 2020 01:14:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298356DF8DDEE58D47ACAA01926E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1651c9e3-eb16-44ee-5a28-08d81bc9c810
x-ms-traffictypediagnostic: OSAPR01MB1553:
x-microsoft-antispam-prvs: <OSAPR01MB1553ABF72EA80D3416EA36D2926E0@OSAPR01MB1553.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LdMer404OS/jmQ+myxqjKgzn7A2lgpxhDdl/WjEDkqYnKv81HFzJv3DImsMdsbVR4yqACjkij/iZGpHWH3DMVUHrrTIMb13tJUoS3XVIPlgy/7Md0liei7qolFn5b1xCyY/ygC4/WxmFHAtFloIwXq97VG9LTF7hP4Q4wXFaSw2dil2CaEkdQ16/E8/BL7TUp74x6DGWMkeYBXries+EbtiesCOC68rmePwGri8xRBV/gkbzGSgqdEFb3cPeTCUfcLpBUDpj+5D6+TMLrFDvaVuyob9NS5JBH0qBWPAqYLeIM9Xqx6Jk/zgO96kysiU3r8IcgupVzwV7J4CjObhcjwJ4WmLldQarMhX2s5YSLVf9GLhS73giydgmgJ6D3AzQwQYQO8qvk/FaLOMSrR5w4w==
x-ms-exchange-antispam-messagedata: BHkzYSgLQlgG3VpLg0xn2SVK6x8UxcWhyBUrnMlKaqqnlu6BIcfQpma4RIIN6APyAxUElBcqcEypKDWkagB37r/mJSZtdBprzSg3l845o6o3d9jHqXfccMUaSnZ78FD/323f4PxWN5g7tRGHP/JIX2xEZeuEiXtDYQ44uVmneIU2L+hUwTEyh62+5I+cREnJY85ZIsBaGbFfLKKuiXitgp49HBJC2EyHs99EdgAx5BpI2g4so+qZsRcLAET/62TuJr/RurTJFKvOWvMhWLk4iu2ExsP7w+chCRuL+20oa0C9HcYq8Ug8HhWpfG+BauhJLo2+Pf1c861NPYgFhal7BN8HCNBSZFPyOS807aw/YwbE9wCikmH2s5Z9JnpN9ZRWBu0dpWkRR/Z9nLMSpwBP7pfYknROD+63hltHc97Ma4qunZv5mn4pbEGFo9kzNKtg5oe0kh8oREes9+64SsBY2aBISQESGwSYE5JV/4k06ig=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1651c9e3-eb16-44ee-5a28-08d81bc9c810
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 01:14:33.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuHSOC7CiDFsfZU+/uX1MqMEMoUmsUNxri72MEqsMiGeOWFcZwdqBatlc20yWGy6TF5HKcdOEu+ERvQ58SpYa7Nu8Jdw39G6iQDTR05h3UdmhbgD81QV//rSn9R5/qN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1553
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EDIhMCpBBtQhE1g2PUdSQ0qvx4520388AA=
Content-Type: multipart/mixed; boundary="0BH4XyYb4iOoMY2wJ9f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593393351;
 bh=UtIYAlhsaFctii2pQ+NVXncd4wFujYDSqRhjDpHTeDE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sRoUBKYJgHh8Sg2rzDDsAWUcRy5/iBMOBg0ncy3F9Urk3bYLvmiDjM2jp1J2P/Bsa0c
 o4ewr/GugXxWt1ZlbdRcvB013ZGYbAOqS4CgIvol/OnN23ACjGVyNSCAx911q+T+8kTqR
 hAiSjscKpufYgTLnal4amklxUtpmZiuoGkw=

--0BH4XyYb4iOoMY2wJ9f4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjEz
MC1jaXAyOS4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xMjggdG8gdjQuMTkuMTMwLg0KIA0KWW91IGNhbiBnZXQgdGhp
cyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTMwLWNpcDI5Og0KICAg
IHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQu
MTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIAk0YWRiMTlkYTNmMjAyMDgwNzFmMzhj
OWE3NzA2YmE2YTRlYTBhNjMyDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2
ZXJzaW9uIHN1ZmZpeCB0byAtY2lwMjkgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVzdCBy
ZWdhcmRzLA0KICAgTm9idWhpcm8NCg==

--0BH4XyYb4iOoMY2wJ9f4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4845): https://lists.cip-project.org/g/cip-dev/message=
/4845
Mute This Topic: https://lists.cip-project.org/mt/75183469/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0BH4XyYb4iOoMY2wJ9f4--
