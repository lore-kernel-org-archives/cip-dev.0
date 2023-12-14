Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C8C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 03:19:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.14002.1702523988457237701
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 19:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3BE3JcB8531243; Thu, 14 Dec 2023 12:19:38 +0900
X-Iguazu-Qid: 2rWgTXl343mU4Rz6bk
X-Iguazu-QSIG: v=2; s=0; t=1702523977; q=2rWgTXl343mU4Rz6bk; m=q1yrQKStC2+zuy463qV9RaHJf0ujFNUlmBZMZiwowxs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3BE3JaPm4123438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Dec 2023 12:19:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkt+ntFvTW0AYgnF1plc8J+CL2Yik5bufLnpWPFD7ZCZn04PAoHWhEOq9rCsjUz3wotMpy8wzNt5TxS2oI3UTR+tpYblmF01q3xe3FEULWANW4iXwB59R4kzlW+IQkOm+LAge3H4uwcGrcL2/fHWoV6meFykEoNOf/xatCBwwfHKjicTx//mPqg8ahk5i8DxDrprAs36kyZCzBP0ZAK6ranUH7ft75VIrk+9NxoLcNzs1ctFOkdU4aIC+jZqxSCdlmrnJEBFAsXc4H2gZSNmvJBa/sc3oL+fk/BUPLHmkt7l2zI3KJ4JrGolmr+Do2Au8xxfu7pC/XgcFVfwOyAYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsCVWTC0DgPNV1Pg2E/7JZNT3k10qGn+exTinYfn5eQ=;
 b=hSoXbMFLHwOx6ggg2OjxT7rxXa/xmUxjkXjK/jJwdcP6LXQCF6ifpGw+KhktnZud3kQiWjH64oeG19mu5aPVL+4HhoRWDl4rVs1LeJeRb7WrhnILs1aSuBvLEtGAwe0dN9ztlOsgoaiPUXlBLNzBttUYNZohaxpw1R13yWLIMcpuc+jubASfl+37TPEu2oIEf5Y9O/8NBbGdoihXB4nJcXkcEGuC1K2CVc6xQ5cjFr7g2E2kxlJYJBmKyUtF+aeOc+sySStt0BAkMHwyM4fphdL2cYJKEP5e6he8Lrc/rwOtXVe1MpCsWWbQBE4C+QCgSpjhKWgsZe0tu924+Cj+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
Thread-Topic: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
Thread-Index: AQHaLPhuPCHJZWta2Eux0/w1k6DzYrCm4GuAgAE8NKA=
Date: Thu, 14 Dec 2023 03:19:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245F51F54A2EE4E6505040C928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
 <ZXlpN+5ODcVIfZj3@duo.ucw.cz>
In-Reply-To: <ZXlpN+5ODcVIfZj3@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB9749:EE_
x-ms-office365-filtering-correlation-id: e0278e59-0b5f-42c5-6a0b-08dbfc537f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I07vFbBdm5zk0nHSJtmW1yuS05gDeLFf1IKKNmgHpaFgGoP4XVBXu8P+9lysAU6UobPDDEn42RNC7EuRu88uIZEvbH7WUq1MwDFIpsjHRyN9F0UNEYEdc09kCfb42coZtraKQMkn9WPUXweOsJVyPB85kN/GXTuGw+5wVsvCuW0BQOH6uMTV3vyYcJ5FPX/tqawJLy/gyYBIUKvKh6PZOoIAEC71VoJ9GUdnnSo55w96R/jNDBgWQYOSm3bpNBcOHtg3YQoc/CSAKFQCCJWtUxsnMRheOw3YfYeHpJGD8ujqUZymVQAMhdItO6Ih+fYQLcLjc5AGY4L0Pnm8liQMoaov5GQLK5boNgvBd6mDg0uNMHulGuFEkdnOZpNINMGZFSLFpwijnGyQD0K22QTsyElAAknmuJpqQoa/gBm4qLy5jUB94W8KMs3hPpMLNNw5PwGkerVeK9pqZrKatB6D5+G6yWKsO6Tl218ZEckSu+5tw8yXMEo/O9d7AYgLshL75t/9IAh5oDXLYO14/e3ivjwStKINXoB5Xl6HsWCljBue7cmQphWapwHEovKydA9qcy2fl0/tZiQIrjR/kIDFRwzw7dsnKQM87j3Xre9zW+wqksNW4mr4ODTewVTHsNFcTNCVuT3jSz/sgxgQzWZzXg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(53546011)(7696005)(71200400001)(6506007)(316002)(4326008)(8676002)(8936002)(52536014)(86362001)(38100700002)(64756008)(110136005)(54906003)(66446008)(66556008)(66946007)(76116006)(66476007)(55016003)(478600001)(9686003)(26005)(5660300002)(4744005)(33656002)(38070700009)(41300700001)(122000001)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?clhvRVMwQk9MeHhHZXF1NDVvLzkrckNmT2JPeWNGb2RpTEtDNmtWVUtO?=
 =?iso-2022-jp?B?b01qVWJROUc1V0xtK093NlM4RWtyU2lvRGhsZEo4bmdpTTFVUHA4UnRK?=
 =?iso-2022-jp?B?alo5ZCt4QVBzaERldC8yUHVRSXpCc1IyaDRMNVVvSEhSMVBvLzV5MkRk?=
 =?iso-2022-jp?B?VXducXR3bVc1cXdIMXRwclBoUWRCSVNzMlhuMlBqdWF5aVFQT0dPU2Zt?=
 =?iso-2022-jp?B?RENRN0xpMmV2YjBsOU1WOW8xYm9RU1dzUmpoVjk4ZUhPbWFlL1lqSUxt?=
 =?iso-2022-jp?B?NDJmTlU5UWNjUGx4eDdKZFk0UHovT3pQSG9YVnQwUHQwNGF1R0wvYklj?=
 =?iso-2022-jp?B?ZVM2MVNZaXVBb3cySjRuUDlJSWtmcjhrdUdQMnFISXpLS29URkNUd0Nk?=
 =?iso-2022-jp?B?cy9NMVEvbGhnMEFTbm5PL1hVeG1obWR5NVhRSmNVTkorOGsrWE1qMUJa?=
 =?iso-2022-jp?B?VUxyKzA4MTR1RUxlblpienRRSFo0bUVScnR2RVd0TnZrRnVjemV0TE9M?=
 =?iso-2022-jp?B?ZGx3cHQ4bEpwTWE5UlUvMzFhT0RjckFTUURZUllOMHVLdzMwNGUvdXZr?=
 =?iso-2022-jp?B?aG40V2tpOG53d0puYW1lSWFmM01xSFBwMlBHaGREZk5zSnZyREU5UzhS?=
 =?iso-2022-jp?B?QWJGUXdmTjNteHJ2ME9oYnBxRWR3MWlTaUpIT3BqZU1NV1p4SzJDMmUr?=
 =?iso-2022-jp?B?aXhpb1NVL2ZKSGlnSy9hcjBmbzBxdFNQQUE0S21IYzVRbCs3cGhHMnJW?=
 =?iso-2022-jp?B?TmdtOUVnejR1eit5VnlnSTNhUHpoSCszREdNOU9qQURjN0Vvb2dzSUhn?=
 =?iso-2022-jp?B?Yk5ReTZSNTZWL08xZGtHMTcvdmRocGVaSmRIVlJvUnZVSFFGUUZEbnN1?=
 =?iso-2022-jp?B?NTlSeFJvWnpwY1M4UHE1d0liTlNDRWpBWUFVWHlzRUxpVGQweW9pbEJj?=
 =?iso-2022-jp?B?YXBRZWRTRXJBRjFjQmJlZFNVVzg4blE4K0t0WHNuUkJkL0w5OUVOUG5i?=
 =?iso-2022-jp?B?ZmlqZXZNMWdQRFFiWnJKSVF4dVdqTk1vRlgrZHZJWHo4a1ZpYUNsZlZp?=
 =?iso-2022-jp?B?eXd6VC85aTVKWDVvTWpDSUk2ckdSU3lLZXdianRhWWRvdDZyT3FIclZy?=
 =?iso-2022-jp?B?cENEKytsNFpHTnZDZStEc2NhUkJ3S0RLbWZqQ05tRThkZi96bnZWK2hl?=
 =?iso-2022-jp?B?R1kzTWZsU3BDUmZoNGpETDd2NjFSV3pScHY2SnY1VzRhUll2NWdVemdX?=
 =?iso-2022-jp?B?bmZWb1NkTm9sUmRLMHBsdjFOSU1LUHlLZS9oanhLU1VxQWxkRm1xMzZq?=
 =?iso-2022-jp?B?VVBxWllzRXYzYjZUd1dxNHpmeWQxZDloN3RnU0ZaVFAvYnpTTzZ5UkVD?=
 =?iso-2022-jp?B?N3piK0ZPM1B4VklkN0tFdG1SYlBGWE10K1dVMW5neEZ3WHFBK3cveGZY?=
 =?iso-2022-jp?B?MEtyKzNLT0JXNWRub09BbC85dFZuQmNsVERiaVdzR2NleGZXM0RNbHlP?=
 =?iso-2022-jp?B?cjIwQXQvRVNBQ1VIaWdoY2xtL1dxb2owT0lpM25PUTBlQ2l6bXQ5QkJC?=
 =?iso-2022-jp?B?RzY3RDhoV25MZmZ2Sm9kOTRURWhzVVhoQmNqQ2lHSmxzSmxzVDBoenVC?=
 =?iso-2022-jp?B?TXlXWE9NRUFrMzNVWW5CbGJqUkFkYU83VjdCN3pBMitKU1JMTktmTVQ3?=
 =?iso-2022-jp?B?RktuZlhFVXRKYmJZWnhaZlRLM010RUlLSjcvQ3owbEUzRE5vZTZNbnl4?=
 =?iso-2022-jp?B?V1RBUHNJMTZuOU5LV2VHcVhhWmlwa2xhOEpXUE4yV1N2U0p4SDhVQ0I2?=
 =?iso-2022-jp?B?SDFSMC9uK2l3YlpwbzlYKzZjOXZzQmNyblY4VGpvK3kxd0dxQ2h4MkMv?=
 =?iso-2022-jp?B?T2Y3TkNsRTRXRVgyd2dHek0rQ1pDQndlYklMeTJkMUNJcmJBdnIvTzRs?=
 =?iso-2022-jp?B?aFFhbHl6V3JxczlHT0dwQWRrNTZUcE5nWFZtc3BJL1F0NnNEMXNMZitX?=
 =?iso-2022-jp?B?Q2kxdmZtUTVoNW9QR0E0bGFxRXVlTjh4RXNtMW5GaWlrdnVzalp6LzFy?=
 =?iso-2022-jp?B?V2MrMHl5NlZuNmZ3VkZ5aTBLUTdqRHpKVjI4SkVvekRFMFM1NDdCancz?=
 =?iso-2022-jp?B?YVVRR0NDRmFDVUltbFc4dUVRd3c3Ny8wd25GWDhzLzhUTzNyUDhQQlZu?=
 =?iso-2022-jp?B?YXpSQUVqTURWMGc2djZIT0llazRjMEZETkpZZmh6TTViOXhMVmtVTjBK?=
 =?iso-2022-jp?B?NlJxSjh3NE1UZTRsQ2dQbngvelBnWm5rQlJPbmtEcXl5Qy9vZTlERFVm?=
 =?iso-2022-jp?B?V1J1ZU50RDNmK09ldjFFdEhCSVhCQXRsVmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0278e59-0b5f-42c5-6a0b-08dbfc537f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 03:19:34.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwZyL615SZOWtXfMw5FqZZi6qrgh4dKBABXLfTr4StCfYJ+zd1IFtqGP97gCWueTCBQRsNUlo9kC6tN4klpFnFTfPJRBoTyJXwfskZjitZgDH1A8VNQith+Nj7SNrxTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9749
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 03:19:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14085

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, December 13, 2023 5:20 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
>=20
> Hi!
>=20
> > RZ/G2L SoC embeds Mali-G31 bifrost GPU.
> > This patch series aims to add support for the same.
> >
> > Please don't apply patch#7 to patch#14as it is added for testing purpos=
e.
> >
> > It is tested with 5.10.y-cip + out of tree patch for (DU) + [1]
>=20
> I reviewed series, and the parts you want applied are really quite simple=
. I can
> apply them if there are no other comments (and provided tests pass).
>=20

I reviewed this series. There doesn't seem to be any comments.
I will apply and push.

Best regards,
  Nobuhiro


