Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B56C5478C
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 00:48:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.13572.1709167722157709852
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Feb 2024 16:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 41T0mVix3378985; Thu, 29 Feb 2024 09:48:31 +0900
X-Iguazu-Qid: 2yAayDBj4mrse0aaRA
X-Iguazu-QSIG: v=2; s=0; t=1709167711; q=2yAayDBj4mrse0aaRA; m=3gZ5Aa31qzx+4wslcTxSF4Qno0Z2+BDqns5pYIKRjQA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 41T0mTtq392614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 09:48:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2tg59XCnDo1gfMj4f0fmkoOGYs0taj11uklSJggEn9/wd6h7cPLhk5cvoPaK0jiqGaC0NQFFL07b3yhkZw71qr4FYkB8BeEbZedzMeeS6RgqKYnPsyl1VKp5/qoZ4eqbCmMZYirVIS7BPLdRe7INsdhKU6JjarAiUNMJaod3LDPzlRyJ3GBLvppexxk5FdkXj8mIJ3PwYb4ivZP6ST/CUN9i+mT54CtVALT4VBoAL7T9NAohoIhpD9wdGOE8BND+WuLNn7lvKnNC+U3K/zHgWLEa8f37nzj5py3adJpdSQMk7iJTwjlGDrFnTXuTbGIy0CIFsvmh2QwAVEn58U/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cal8KhP7p7rUDVcZCugrzN15wlxzs/FvRsNzeo8/WwI=;
 b=gFYzZ5XkEaYtitQvtaO+nYcfBr1olnvx/y9/ME8kqVOcEGh0NGofRzyvpDU1CozLykf7Eb67oQl7ZYdrChferDdPzDQOsIM0VzhbAyTQ55y7CNhoYYZGsG83KrlR6sQ9UuQPqJ8BC4iSWCP+0AvYEVssrUFmLYNs0902XFUliUQ7JEHAZdJe0HUEgGwinKDuQsNjyH+zq66neNwdbhrSTaqFCCsccQtUvd9e0TV8Xbk9oB9ebF2W1Wc9iRUfarCnO6eWVWF28SaKSjU0RzKxsYFCS1LYuy67O1cp/SXg3ZH9kkFYPQRKdbriws9P4gHTEdi9qGsoudWRZXiDdILZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/5] Add RZ/G2UL MTU3a support
Thread-Topic: [PATCH 5.10.y-cip 0/5] Add RZ/G2UL MTU3a support
Thread-Index: AQHaaKAmpS9l0P3Jzk2fImpRufm8QLEgf/Vw
Date: Thu, 29 Feb 2024 00:48:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63881BCB411CF35BC6A90364925F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240226103949.138960-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240226103949.138960-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB6109:EE_
x-ms-office365-filtering-correlation-id: 164bb47c-2678-40f7-7e15-08dc38c02482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gWhISroCoUi0rwpjS/cH8gIcalqsz4c1VwDKW/16S5vqO/JnW61SSwWcXojVF/JZa+Q2RThZtIR5fNpWmL6Pmv/XkydvBzts8nc2yqQPhocWSe26TnxDc4dhgA2aRpCJIkkMT1hx0DdufSkW7jmqVWPAn4ZwjCUOHpOOwjT05E0vUAUAlixM2NPbsFofcUp1XqR8T+mpel8eUFdDdlWnFdv/C/579gWr/paHVNrzSXTDnVnC3avTvpWvbKPRhiPmPme0cBn3ENAQvpUttwYlN4K7NRO83O2Cd9r5ZZDn80HodzyZxMuLpurL3eqoWwJ7rXcyyuMa4HFIVP88KW50SNw1d5zUUH7cQBCru3dbWhntubcVx1ATk4nYvFkkvSl4hw2WeSohZdmEQ0IpGIxsOjqi7mB2Mc69YgWoFV46HQBOa6TH8h1gna5w6x5ATOryEVmjUUMFXBWz4iwTGd8pgr6XyqR/pgHf7TWwe7UOvXZ54g0E+o6OM3c5bzbSAY6qazR5imgvbn2JckT82lz0XfidWHVQurdgFYRuDQ1oQh/Sy76eCEMcR4yiRxSGY0tA6UAZAfGgqn6AKZfGcfvCPbcysNYWjp+ks+K3SFlwxOIDrE+8UeTrdVZ0c4A3dzGm9ZMFohwitd11NjSVtIZF4WlqVaCGm0U/mzXkMOc5YuBGTaV85W19hmVDAx28thGrcUnjG+FGhWuo2EUSPzzoPsK43CtMdBNgqTQkGperd94=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YmNrOUJER1JaM05VZGJnNWlhRElUOWJCWUN6WXV6OHMrTHAzR2cvaUtQ?=
 =?iso-2022-jp?B?Z3VObDBUQkZaek9oSTl2TjdjdE1yeDVYMmdwRDRzUklPY2JoMEp5dVBs?=
 =?iso-2022-jp?B?bHB0cWZaODJuRVZPRTR0VHd2K1dWRElnNFpTYndwaFBtQ01uNmhGbnBk?=
 =?iso-2022-jp?B?UVdUWlk1SWZTQW0wZWRwRXJ6aVBrQWFkUEp6dktFbDBqalNRUVU5VU1V?=
 =?iso-2022-jp?B?WUJTRE04a3QvbFU5dG0rYVcwUzdHTmpqSzNlNElvZ013azlINnVpOTR5?=
 =?iso-2022-jp?B?Mk55NmE2OGlGN0xhZFU2bk1xVWpNbW5ORkNGdzlGcDg2WnFHSHZuOWlL?=
 =?iso-2022-jp?B?UHFncXZFOFlkNTVMMzVVZUJ0TkFFb3dHYTk5ci9pazkvWVF2c2dGRDlY?=
 =?iso-2022-jp?B?YjZ5Z1VPSmIxbE9KY1F3Ulk3YzVvZTZDOWlpdGJiRHR6WVlBM1NTZDRJ?=
 =?iso-2022-jp?B?MU5kc0x4dXB1dUZ5OEV2aitkazRzSmhEZlNVWGRMS0N6UzdhNVljdG0x?=
 =?iso-2022-jp?B?OEp4VXRIcGwrUkhkV3NwRzR1dzlHSE1sa3lyNXhmU1MvZCtYNThEWXJE?=
 =?iso-2022-jp?B?UTFmMm1veVg3dkNvRkhnSDRtcXpmb016c1FXMHZGMVg5QTZpREY3dlUz?=
 =?iso-2022-jp?B?Smg2SFU2ZkpCd0JETFdmSFY0ekFMeXdyUWhPSFVVR3N5SXV3RmxXR2pp?=
 =?iso-2022-jp?B?cFQ0czJZSHEzU2ZyQlZNQ2x4OE1hNllIYnJBVXZlUWFrZ1NBZHpCd0dS?=
 =?iso-2022-jp?B?Um9DSDliSkxoOStVcnZ5RStzT2NhN1dwelFNY1ZXOG4yT2lVZStkVW42?=
 =?iso-2022-jp?B?RmtOcHp0NTBqdzlENEdwckJoNGV6NkdRR29Sd0Q3My9yL1Z6NnVjV0Z4?=
 =?iso-2022-jp?B?aWg0RVdOWU1zemFSM3drdnJXQUdLWm5IMlRKUlh0UitjaUNaVDdzelU1?=
 =?iso-2022-jp?B?cHlRVDRxNHdDSDhGaHQ0cjdMN0JFV2YrNHFReFdOV0tNMi9uTy80bytx?=
 =?iso-2022-jp?B?RFd0Zjd0NkNGOVA1ZFRnTzlCZSt3RmJHT3Z5V3RwWlFISERaUGluZXVG?=
 =?iso-2022-jp?B?NlU4bG9rZEpQOGVDeUdOTVZ3ZmZOM3V2Q3pEL1RVWnRjb0JSbGRLTEsw?=
 =?iso-2022-jp?B?NVMzTWttRWFoTGE2cmk3YWRJTTN6ckR3VnpVNFpmQUxlWUdUcGVLNzZ6?=
 =?iso-2022-jp?B?OFN6NUVyc0VYUTl0cHh5dGZoeFFzQVczdlNKUjRKQ1liTHVJbVZJTXZl?=
 =?iso-2022-jp?B?dkVaWkxKblhzNHZ4MjNKekcvZXorNVBheFJnSk41bWE3ZHVjT2FJcW9z?=
 =?iso-2022-jp?B?d2xBMFM3TWZ4OWNwNWh3VTM1eUM1NGpEWWRRdURvVDl0OS9WYk84Q1d2?=
 =?iso-2022-jp?B?MmVOU2MyU05ic0dXZUpkbWtpWTltemljN0ZKQkI4MGdNSUpxU0x4TXRX?=
 =?iso-2022-jp?B?OFA5ZE1LLy9uamNrVGhOQ3pIU0Rub3Jqd2ZlRE9rWmROQ29NVXFWNE5H?=
 =?iso-2022-jp?B?cC9EaUNUdTBkYTAvRUtjeWsrYzhNTVpVTEJHbStCQU52eWFieTVNQ3RD?=
 =?iso-2022-jp?B?RWw0TjhCWFFTNjUybjBWajMzSzBIdzg0c2FjU0RQRkFiSEVjWGROUjVR?=
 =?iso-2022-jp?B?QloxYm4xMXJhOFpLaHkraC93bHp4dzcxNVFCZXdGeEY1SkxlWVRBcHdl?=
 =?iso-2022-jp?B?UFY0RFR4bm9RODA3TFNFQng2YnFsanBnVTdDVG9sZWJRR1lDN3RPTzFr?=
 =?iso-2022-jp?B?a1RXN0EzbGUvTnVvbkJiZEFJakRhVFRHa09BOG0zbS83OHpXRHdydnhP?=
 =?iso-2022-jp?B?YTg1UnNjZy9ZN0ZxZVc1bEVRVG4vYm42MjdEQ3l5dVd5RkFGZDVoQ2Nn?=
 =?iso-2022-jp?B?eTdTWlhuQnY3NjhyTUVOUFFEMzdsVkx1c1RrZWRVNE5EVE1lbkUwbHM5?=
 =?iso-2022-jp?B?R2g3elpPV0J3SWJ5eXFOK0lQNEpnU29aY0ZsTmZLNG5maGt2WWdCZ2RI?=
 =?iso-2022-jp?B?dkcySDBreGVkZG1iL0gxYVZIZEdkaEFVeVNJT1dQZEZ4ZHBUT1NNQ0Rx?=
 =?iso-2022-jp?B?ZEYveWVDVHRjQ25IajRleHJXbHhqejlGMXN6aVpxSkx2RkdJMUprN1Zv?=
 =?iso-2022-jp?B?bWpVT2xxWldJMzFaZGFmTlQzV0RnUTgvSG0xVGl6WEVUV3NmQjh4VlBR?=
 =?iso-2022-jp?B?c2JqeVdKaFZaSXpPUjJ0TTJuRmZ0TTRRWlBNU01vaVIzNENWeEsxVGp4?=
 =?iso-2022-jp?B?K0k4ZGZkaDhVK3YyWEJCRnh1bVIyMmw2Vi9zTVVjZWErT3BuVWlZU1Er?=
 =?iso-2022-jp?B?VWkxNy9kKzU1dGVrV3NaMmh3RitXc1RoWmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164bb47c-2678-40f7-7e15-08dc38c02482
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 00:48:27.6773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/EnhMgqEJPN3tkotiIaBXZD0bq8NX7Eak+6159jLOet4HE92xF3xWlfeDApiIZM3uFvkoJA0ADipSwkpJh2HmlF0rVi9t6llGxTCZwbzvcIldoslJWL0/jM6AnPyj/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6109
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 00:48:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15100

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, February 26, 2024 7:40 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/5] Add RZ/G2UL MTU3a support
>=20
> This patch series aims to add support for RZ/G2UL MTU3a driver.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (5):
>   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>     names
>   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>   arm64: dts: renesas: r9a07g043: Add MTU3a node
>   arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
>=20
>  .../bindings/timer/renesas,rz-mtu3.yaml       | 67 +++++++++---------
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 70
> +++++++++++++++++++
>  .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 11 +++
>  .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  6 ++
> arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 13 ++++
>  5 files changed, 134 insertions(+), 33 deletions(-)

I reviewed this series, looks good to me. I can apply this series, if there=
 are no other comment.
Test pipeline: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipeli=
nes/1194909294

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


