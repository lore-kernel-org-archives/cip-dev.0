Return-Path: <SRS0=kkUF=7G=lists.cip-project.org=bounce+64572+4640+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8251AC433E0
	for <cip-dev@archiver.kernel.org>; Sun, 24 May 2020 23:05:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64982076C
	for <cip-dev@archiver.kernel.org>; Sun, 24 May 2020 23:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nfT/w7Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64982076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4640+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TuOoYY4521723x1qxWYs96WZ; Sun, 24 May 2020 16:05:03 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.22809.1590361500865050104
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 May 2020 16:05:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 04ON4X0O015552; Mon, 25 May 2020 08:04:33 +0900
X-Iguazu-Qid: 2wHHsainQYwd1AoMvg
X-Iguazu-QSIG: v=2; s=0; t=1590361473; q=2wHHsainQYwd1AoMvg; m=VNZCq19C14xcy/yo9ucaTx5FMQb87ZTMBKBl4jvYXpo=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 04ON4VBT040854;
	Mon, 25 May 2020 08:04:31 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04ON4VpK029394;
	Mon, 25 May 2020 08:04:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04ON4UnA001823;
	Mon, 25 May 2020 08:04:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB5qXeVbwDm+a2RmYCE/C/WEghzpC+FHHm0lz9JZx3+EYlG+l+f9c9Mxrz7jZ7dEf5jk91V4BzwN9rbajDhI0Y15VAvry5sE/zQw+cvHOSlPLnpAcXlbQK9gPX6QelCNG3uv5cLZcevg/tR7v0FZpAGwPYNdeHhC43DbHgYPPDiRqf+mN/WmdlZ9rgmXFACMfmy8yKimNMCxJEjHPHap2EG7TCM2GNM7b2/8YZMxvP5HYlNm3mZf8b+fRZWA4Jdg6Rfn+sa4XBJgx96HbjmBU0ZyqqICg/H/zz9XjbPaFmc54dpoXxEnsnk18QjqK49HsId79eOdXtI5ct+Z1RRLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTQLbDH2r5w7o0hsXY/ojogbNSh5FT3rjJi6xSi5L90=;
 b=dgVWVZTxCxZxX0ZUQmZL8CDoTI5ppWwAB3JkJOg6R5rUnt3iSs8hwUkdgYLB1z3T6v7Lo2m8KGF3nZstlvtyrReKH18xJENidtOLuzd/ok/gHdTyzs9DhNmR4OlZJiI7LJmueaYrWeo7NYMAnJIOVoTSU6bOdEm6XKf408p3VGTxNoeQcb+J18SfkMwawM6/Qct/MLdGEhl6b1GdMC5qT+vTSZqXWeLjl9kjEBGtyr+yQUW0l21+C7SOPilppz592qBg+xNsNCLxt9vVE4QbyBZqfd2LEb6D7BUYyvsW2ZH6LteHw5T/apNypjWeYmLIiSq6tSoFB+dVw0KXJIAs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <ben.hutchings@codethink.co.uk>, <masashi.kudo@cybertrust.co.jp>,
        <pavel@denx.de>, <wens@csie.org>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.124-cip27
Thread-Topic: [ANNOUNCE] Release v4.19.124-cip27
Thread-Index: AdYyH5BfhSxiAC5NQWSCJX+c/vPR+Q==
Date: Sun, 24 May 2020 23:04:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983F9387A309E9C01984B8892B20@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d032222d-5257-4d40-c86b-08d80036cfa1
x-ms-traffictypediagnostic: OSBPR01MB3767:
x-microsoft-antispam-prvs: <OSBPR01MB3767EAE1F2E558C19E36B15092B20@OSBPR01MB3767.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7scUsqFgZPoV4y6YFP8uNfdf3CmVS97vfZgHl45Z4R5RXimDP2S062xQZxNdRzd5+OJvODWxTEvsn6ZyoBuaEY2aKK5s3EvM0qKXc6xoOoV3OgCOtIJkBzq6LQAc48HKlLqmgVLsvo5pH02ifZrNpRwLQJ7jPzf7SDckZH6U2jS6yJAfrOueh3TfcK7CmPZaAFni8EoHVrHOjsKLTwuGv3OiGtWfR0HtOwdi3LypcTycvWyIrhbUwzliEzryRtPQ4rGyDneg1eyTFOvdE2Oz/U96GMWBJxVfZc3JoYqh3jKdlblD9nWqijgWaRvr8JHpmFGkbeX+m4Hp2CUw7d59AKlf1tr/Gqy/svKeS7OOQYJ2fjJf9TcvpswyeISJ3ZtpjmAjd8cOfJRsCVcVU/0hmQ==
x-ms-exchange-antispam-messagedata: RZf/TRMzZ3sukGHNmsFxsHLq0t/XYJmt9rzy1u8sBll1zikJnAh4Ljj0sydqNJX+HjLHqBk2uus567025ypPSHDKgKcZHsrZ0TQa6ATAz2CKoNIagqbVwnkYgPo3Tp4//qYCxxytxF3aituP94KOGURbO96DWugx9GfVdx9+bZxEhf5obY86yZTDYGvCX1Rv4ORZk/hTesfxGhHkgNNe0yMGmpCBY3PpFKveGL6gupizDx70iYjVQGOePtoVzhbMbz6oXpo/gmfd62e7CaYMtie13eYsp78GTxagQomxGalBxlKCmcO6setlJ1i/E0kDY2TPB3MQ64zRYwmwX6nBZMONH/cD1MzTIhaPNI56yq2fc8hC7UYKccUJ+URCqP/wm5Vv8Z6rhrm+nN28o9X9Iho50evI3g0Hvr6YYo69YDCe0JagcYrQ7lutczo2xirsujf0HffjnpWrcO6b9vXGHABu+QZ90l4wGnFOzzyBD7w=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d032222d-5257-4d40-c86b-08d80036cfa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2020 23:04:28.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+sAhcjgmHDreAo+X0MuDhwuwt3Q0mkTe8uWCtNwSko6/AW6xhjizSPMhF9fB2IbC5miQf0XC3Fa9hnnCzDUofCiFH3fTMouAyb27WJQcShVwQn6BuxToFcYFBsAkPJD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3767
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hfLQHKB3IxZCLXA2TatasiFHx4520388AA=
Content-Type: multipart/mixed; boundary="tcAMow3hV7BtCGUDE0Hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590361503;
 bh=PN98lzoAd5q2JzHt95JQfUoyGGEUPnbw1JgtOHw2UJM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=nfT/w7ZhxZBWPOTFfCBf1Cr+17scATYOA5WiaPx/ltyzEDT2kD9vE0o+R7gWY6j3Weg
 T2wUcicZjeg0cTnwYnnVwIcHbXc+odJqckPVr+bxz871ndhoAl/njvu2FQLm1paza3TPT
 R7BDyHY2uw1EbBUoW1tR/tN/zMWmxAdq1Mo=

--tcAMow3hV7BtCGUDE0Hu
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xMjQtY2lwMjcuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTIwIHRvIHY0LjE5LjEyNC4NCg0KWW91IGNhbiBnZXQg
dGhpcyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTI0LWNpcDI3Og0K
ICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4
LTQuMTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDIxYmIxYjhhYjdiNzg3OTlhMjFj
ZTM5NTI1ZDFkOTVmYjhhNmI1YmYNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1w
IHZlcnNpb24gc3VmZml4IHRvIC1jaXAyNyBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0
IHJlZ2FyZHMsDQogICBOb2J1aGlybw0K

--tcAMow3hV7BtCGUDE0Hu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4640): https://lists.cip-project.org/g/cip-dev/message=
/4640
Mute This Topic: https://lists.cip-project.org/mt/74447241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tcAMow3hV7BtCGUDE0Hu--
