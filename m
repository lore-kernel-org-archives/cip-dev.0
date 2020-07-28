Return-Path: <SRS0=aUmn=BH=lists.cip-project.org=bounce+64572+5042+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43484C433E5
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 23:36:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97FF2075D
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 23:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hg4ASSls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97FF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5042+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ceh7YY4521723xkarjibWZYI; Tue, 28 Jul 2020 16:36:56 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.1974.1595979413188530445
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 16:36:55 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 06SNaoGK014301; Wed, 29 Jul 2020 08:36:50 +0900
X-Iguazu-Qid: 34tr8v5ekB0fadx0dz
X-Iguazu-QSIG: v=2; s=0; t=1595979409; q=34tr8v5ekB0fadx0dz; m=l3JpdtEMMgVo0DKc3u8BvJu3kr/1Za6ANpwhW34qqZs=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 06SNanb4001616;
	Wed, 29 Jul 2020 08:36:49 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06SNanCJ011636;
	Wed, 29 Jul 2020 08:36:49 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06SNamDi030455;
	Wed, 29 Jul 2020 08:36:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWjuzFegh5+7jwBKoXB7AuhreRhVvrFy0mkoQq/hFn+K8fdEgfsKqNdOPKZAFOsComoq0M5ISZ/VfCPjcNkFAwgpnAZpHqpxQJtgARKCzeHm4Df33PCuRQBFxGCEtj/AQ2SjgyPyh7L8TrfYfJY/U3pI0PfiPIGQl1CQfehGGX4b8g/1QFsQvwbwJXnNTBm2tIlGzGDLw27najY+XQwa3c1jB8AmIc+uc5n9aQLCLx/O9ghbNjt6H4rqzedtFyjXPDQvUHLj8F9hIpYU4rK2ftmXEHrJIOwTl4ZU9xCnc0FTYT/hjBNWiYkvKVqEJacL41qhkyaJ0gcbPpXZDRYCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJq2tD/BiEELi4pYIskXnFv9F9rSaJQ2eByaoH0QcHM=;
 b=fdpLjDFWXbFITB03b+C5kyD/vevQiBws52cG6tewqeRRBffZAGsoCFHg5rGeXO0UrwAXFMdzmLgfgLZBEJXN/3RyQ2RE1Z9E8AYjn4AVULbVuKSVNwfC4sowgMGO8VUVQMnbPfIGDeVMIqygnTTXRhZ8tJ3x0v58nr/efpLYyV5CqSMIuStIl8G761hRK2KvziIxeRI9ZRFojpc2ZdJ2ZSoKsHRKSq7XBaOJhzy1g4ruT+Yp5NQt8UUkc6f71un2U7Z9AfqYQhKwQDQTecIfYwLX9oQpATxI1G7eEfVSvw7uN7UfW98EP0UY503gv4q/fDAsl05tL3+Ppa4rMLQR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Topic: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Index: AQHWX/OmhX5UQNU+wkWK0hIB6uUEs6kTMaVigAAMAICAACgeIIAAPR6AgAoNGnA=
Date: Tue, 28 Jul 2020 23:36:45 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053FFBB0C2B06E07E465841D0730@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
 <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
 <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <b22e4826-c624-fe98-07ee-2d6d99bf55a1@siemens.com>
 <OSBPR01MB205393EC7EF5806AF88C6D39D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <001305cb-0a8e-f90d-2cae-9e7a358aa834@siemens.com>
In-Reply-To: <001305cb-0a8e-f90d-2cae-9e7a358aa834@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6fe33b1-0d84-45d1-710e-08d8334f1753
x-ms-traffictypediagnostic: OSBPR01MB3814:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB38140C4E0226DE6C5B6B61E1D0730@OSBPR01MB3814.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pn7M5c9xTrP/R2DfyiDYLCYa28bHWIIohrjRvfQSbDqC1t8/jDN3vUfPBpaxi2iJbvA3vWbrBNCWXlmm86lgklAwKmgZzWjPKaW9JtBduWOJTFnX5xrDcej8PRHfSO10U0QJ4L/hesPSQ6uWi6Jtnin4UX8uSJVHn4viosvBWn3Z/YuY2whGeo89zmV10zQPVku5ziZtFhYJO6lC6LyVk4ddFOwD6/g8+qC02wp+Zs3mZDff19mqyaU9eGM/3/WuObkwAt8nlIzuIsXHY2ozVPLGiwZySS4Jo99rqqyX40Uq+SHk3M6IdX6s0EPRrv6hH6INtX6H9BwfRz0oLrvNqjbSBI1gFTfyKJfFl1CQaPfn/5dRYCETEvbuBAIeq62m
x-ms-exchange-antispam-messagedata: 4RGfqc8gB3ZXJkzFrkHM/APSaJEkAbpW6l3Tb4p+puDaIChIg8tWQ7owyIf/CYM84OnN9WL+dqQ7pG1WD/1dmrLJ1tFK72dqvknk46sjdPJHlJXdsrDXO1F1n9pli3t60K0VBCvrjVj5Jz6X3g9LdFtI8Gbkf36BfVP5ve6zK9JSG/cdjvAhOECYWwBDYr6fiSZEFUqlzg36Oa01uHg9S/iz2eOS2ZmHGPmtj28TzVjAxaenZbdhNe28E32KFtnz040sHenPmz4iEGJ3fDZx5Dl4vorAgSrMJ0sPdIIfIec+Rv9mQtx6LY1nZEvO5dT/wX7zOXPGtqre6qYfLiJ2V2oz7uJEMMECi13GUhfutUPWJaKawwau3lwMzV7egFGM4zzUmUQVkAxUhqD45VZLrg8FqqbwHEZTPe1ra+5+mxig0sdTrk0fHd4AWY9WAQP7ukCulCWdaz8R9VvwaHji36B25RXS2GAk279S+1RIt3w=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe33b1-0d84-45d1-710e-08d8334f1753
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 23:36:45.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqcqpukQsc4fePZ6QUZdwzo58Z/xuVxgNbCPBJ1WdsLpK8Sww9f4Fsi+DlDwxTmmUGJwR14OXaFGBpxt/VxKOmLxlxFq7SfF+h1wk5OZhco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3814
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DZBZXOtgMHWoLtI6g8ESITAVx4520388AA=
Content-Type: multipart/mixed; boundary="scs3C0qGrY2r6CjxrB0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595979416;
 bh=93KE8T26oV5pPXNdI0K96mcV0Azzm7lbbuEJgY3e4L8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hg4ASSlsBpTjMOVrXzMBUDbLI8J8fhmFJd6qmcwcw3vFftrH2+LTIUfiQqLvIeD9LPT
 0r6+kQxJkGjGQthHB4t06drW/Rv5Xo2m1IzKXOvZ0AKnXdLUQ9xyjrIfZ275PrXNf9MWS
 UhWxFW0Pyo0DQM1pphL5C10Tm7Sp3VZAcJ8=

--scs3C0qGrY2r6CjxrB0M
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Wednesday, July 22, 2020 11:07 PM
[...]
>=20
> Nobuhiro, is something missing from your perspective in Daniels approach?=
 If not, I'd like to have one patch that takes us to that level.
>=20
> By now, I think an opt-testtools.yml is better (an "option", not a
> "layer") than a separate image. That allows to test the security image ev=
entually as well.

Personally, I think the same.
Perhaps Iwamatsu-san got a bit confused by the comments on the merge reques=
t.

Thanks,
Daniel

--scs3C0qGrY2r6CjxrB0M
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5042): https://lists.cip-project.org/g/cip-dev/message=
/5042
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--scs3C0qGrY2r6CjxrB0M--
