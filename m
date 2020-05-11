Return-Path: <SRS0=+ftc=6Z=lists.cip-project.org=bounce+64572+4617+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC78C47255
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 07:11:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031FF2080C
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 07:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rol9FkLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FF2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4617+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id r578YY4521723x1J8TfI43Ba; Mon, 11 May 2020 00:11:57 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.7686.1589181114764269884
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2020 00:11:56 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 04B7BUKo007651; Mon, 11 May 2020 16:11:30 +0900
X-Iguazu-Qid: 34trvY1fFaY1GNGYcM
X-Iguazu-QSIG: v=2; s=0; t=1589181090; q=34trvY1fFaY1GNGYcM; m=tNj/wem4M0G41J/wZW9kmSAYBaf0QVhjFyudLq0wT8g=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 04B7BSp4019745;
	Mon, 11 May 2020 16:11:29 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04B7BSEb011122;
	Mon, 11 May 2020 16:11:28 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04B7BRAR000574;
	Mon, 11 May 2020 16:11:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVR2ciOSsy/f61Ti9hlOqtwn0BV4Xe5THlOPZOioOkPndj8i+VocVfV8aBjO60O9AXcqK4iF0S75cwOp/1RF4Nzf3xiOmSYHfbRpRUhryzT35tAlJCZMll9ESimXtUcC2Py5Myg+RVM82P+dkmBOseEJQ1Vcx38X612etoXfaLQI+tncq9+IeROvR3Q197AQWujZFpQbP45Wtq8jejB9gRFzF40EwwW/L0KrNqr36bcKrQ3R0V9HCI/VDgP4ayf8zR/6sAuO8ESi11CASo7TqJdiDe3sYKjnNu5LddjmBYfEnLQNx4BGSMEC9bLyTBASGipJee+zjgWCjOky9BxMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lglRnyoTKccdb+aHCwvTSidQnHsnM3jxgoH4lF/R7XU=;
 b=ggHJy4eThn1ngPHXcizjVtEeqoVygIO4gNI6VuZUSdLiiL9D1cM0wfwrGCrvFynGCmqShsala4C+S9fj7ZZoJXl5UZEtg+RdJhplBwBscOaMv9Xo9WPk4jCQeg/WMlTsXTFp4yGKF4vKj9r/i5vK5ljVYBFkQ4WALQDgObtOYBHSMx1h1PdryCN5f92EZgPTXfGRVQRf0g12Wl8/b6fCBBjkfhw66bnc5obGFTyzFhnSBFwJkPPprN5TGzSp+DFEoi3wuEwYdTHAuKIz3fFXD5zvhivBziXzwj5P+gKKkv3t5oPlZEcm5rLzJ8gIsyCUFdu2WaFd95WHOn+QARKF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <ben.hutchings@codethink.co.uk>, <masashi.kudo@cybertrust.co.jp>,
        <pavel@denx.de>, <wens@csie.org>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.120-cip26 and v4.4.222-cip45
Thread-Topic: [ANNOUNCE] Release v4.19.120-cip26 and v4.4.222-cip45
Thread-Index: AdYnYui4khAX/0pjRve5WWYNndTaSA==
Date: Mon, 11 May 2020 07:11:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983FE35FF677AC5FA1AEE7092A10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62d5b8ad-94cd-4a95-cea3-08d7f57a845f
x-ms-traffictypediagnostic: OSBPR01MB4216:
x-microsoft-antispam-prvs: <OSBPR01MB4216708C54D4CBB3B1889A3692A10@OSBPR01MB4216.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oBzuP3yfjqN8ra2dTzunPNdjLvc+zS78CLVLq+wMHlqxyzwRCiBm2jSiYz6HK/lQpaKNjXYckjTYX52NRMJs95JknNExU0vUrBbA3SOsAgTx23ou4o2sf+Ci4Ma/2f62gKl/jsXyfy7VDoT4VPIItS8NohaunAsCRQqJnObzNTbk1S4GUZLJdOkiMd/pOCfERJ+4DLlN+zHRf7bvJ/Bf4nZ2DC/b/hBb7Rc+gt5dCVYXNHD5yEl1JbLJxjl1AvN+CVsA04dCvWUtGkKEnFflLRomRco0cV6RaIyvAtUSwEtO5HaeG2JiqJeRDijluwp5fes7GQ7Xub011nvNfuWmuRXHlI3dFFLCj9T2eGJPDDGVvBL30IWUNMYLw5lchyJLYmSwaO7eh/BS2xC5K9l7meQDDcu2o1BQVSxQ6zSlAGyRS5wbMwP/0SY6gsG60TAeuzd1QB7C+eeVJ+NzpUW22OzONErwzlWe7AGqCNFMLtVpNRqxugY5gkSqIpYxAu+9dp0wzMeQM42NLpn8Civ05xLugLhmJ3w1fgUzuTkc6YE96lhp8AkiVTHuXtIkdLjiP7rLtTQbJpPIHKQuEy8xTF1xnU5T4HSA+GMTk6EqpUM=
x-ms-exchange-antispam-messagedata: B8mUaLxi80ikulnZC9Lu5aldHzcTjuqrLXgkkJgF1UHy3tqdJWKkCNxN7P6P8+fI/8znbr3TD6RhbxEQl5ovoy2QCqzJRN0bMPpAD3jnHPw7QUe2zcmL8pKPoZPDObPhScqZH97nBU8V/Bol1A1slMPsXyZGBk0uSUZxwP9zZfBW+0vNEPx+xqWFr8QtzeBtn1FBY4w7xui46ULlNgeV5vLorMfJgtwbCB33Ugx9TcZYZduUFo4RtA8QCs0HH0/X+67Yq7rQIyexunCMcTU5Q7vfqGwwyrU7TQPT9IrMevGX+qnIK8cqvTHAQ4aME0h/TvvxPPPObgSn8AZnlUVEI/W1WCztzniDIQaf7o6RjEAWyD4Gjs8Gbdfev3InnuFxSWXJJc24yTCw8dvZmtUyXrC8X5Xz5b8n6lmQvjbDPU5rkIHLW99HpbZcdrLwiBxeGvp+LygLU06dit+5vUmH52I0H/pR+92pq9oLNZ7TcUg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d5b8ad-94cd-4a95-cea3-08d7f57a845f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 07:11:25.1401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H69arALNa6m1tZh3P9nfEM+ctfYxHPC5IEecM/7B47WF+9zFI/y3CWgWDL9rz6mDFMb6lC3LeVpASUaOa7r/n+4992LxbwxH16iDAmUtbpCZIkKHAYikJnuNZlQTNuKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4216
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: N9oE70rGZW8vJpgcNH2fTmAHx4520388AA=
Content-Type: multipart/mixed; boundary="7Sgeb1IudHyqbpTg6xt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589181117;
 bh=zGeOUedjxZYFhCqe8VsqU/dcFmH8qMEEsy0yyVn+MW8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rol9FkLF0KwlbmEZEIeR+96MkT0fI4BmnYzO2j9L16IuBQzTAKi0pLsduvYXAU4OA8K
 a49xZREGcqvoW3jxgxX/XMHuQKLFv4tsBAX5otC3OhkoHN7gjJwrHG6Fi6opX9vtpAzkl
 JHCbwJpXvOLAwj9nA4hmCjjW2LK3khRzehc=

--7Sgeb1IudHyqbpTg6xt9
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xMjAtY2lwMjYgYW5kIHY0LjQuMjIyLWNpcDQ1Lg0KVGhlIGxpbnV4LTQuMTkueS1jaXAgdHJl
ZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0LjE5LjExOCB0byB2NC4xOS4x
MjAsDQphbmQgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbSB2NC40LjIxOCB0byB2NC40LjIyMi4NCg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNl
IHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTIwLWNpcDI2Og0KICAgIHJlcG9zaXRv
cnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXAN
CiAgICBjb21taXQgaGFzaDoNCiAgICAgIAkxZDRlYTRjNDMwYjI2NjVkYzJhMDg5NzQ5YWEyNTBi
ZGY0OWI3NTlkDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9uIHN1
ZmZpeCB0byAtY2lwMjYgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KICB2NC40LjIyMi1jaXA0
NToNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBs
aW51eC00LjQueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIAlmNzdiOTYxOTMzMjc0NDA0
MGEwMzIwZGRkM2Y1ZTUwN2Q2ZjRjYjUzDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDog
QnVtcCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNDUgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0K
QmVzdCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg==

--7Sgeb1IudHyqbpTg6xt9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4617): https://lists.cip-project.org/g/cip-dev/message=
/4617
Mute This Topic: https://lists.cip-project.org/mt/74131009/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7Sgeb1IudHyqbpTg6xt9--
