Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529EC61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 22:05:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.108355.1700777114813530819
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 14:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3ANM56Z01496644; Fri, 24 Nov 2023 07:05:06 +0900
X-Iguazu-Qid: 2yAacpQQBjgagSwL48
X-Iguazu-QSIG: v=2; s=0; t=1700777106; q=2yAacpQQBjgagSwL48; m=lh+rvmv8WkpVL753xlLipa1iYDpDFwAgi5UC58+DM70=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3ANM55Xe2540683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Nov 2023 07:05:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7sUMFeYfO+y17f21GUvarvDNqz5US1C5r8sY4VzIYrMrgEkwk/LnvabRrYlZuIU52FVzvSMsFuLVYLBeeA/Zkt5o1wpgnIPU2E8RMDrcFffiXK8w2JeX0tNaBVuh36VNnGmaS16CvKj2gkXNw52jSlJngd6S5Fpig+OCQaOoPO6xbAr4nJJgyNIcvFMCASyQZLjZ+HCrIWzUtJe2WYUgxgSxKpslJXx0mQVZOQSMRIaLeqwwObOwIhZh7j9QkacC8WYEVhmk5+UBCgEGpc0S2dLwbJo3TKAxm1JkacuVgMqmwxOX/18KXCZHzdeB6jPtPWsll8MUh1APcve7sRJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3KTUw0pcvUgqs9Hvl4RduI0QStEMS/072bqlhxpZT0=;
 b=QNNUXOqIpL0HfBaK+DOg2u/0GBsamHVn/mRUKE4/+NkAFM1bUwGEhDsChyZWfFPKyn8pmE0LJ51IlON1HvhnM/wgAvRbGIXzFdxQWevENeavXKLlVTNJOsoHbgYWYL9pNrHyj+p9errGlYUOfsjE0Qc5uIoMzD4+fKeU4Y/XALvuH0tcsATCx1wzZpWCZtaAVVbkeHaN1ByhwEs1XMVBXJ1m1RWdLASiQ1MnZcdlCRn1FhM47Q/wGc+FBO7MqEQaEwfN/aQBVRnejJG7LNSNSCj3vpzwaFbPthHXmZyH2vP1779yg98ySSPnVpsNiRKaAZ8UX9sIqbunYBwd5QENzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
Thread-Topic: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
Thread-Index: AQHaHWQflYSSNQ4eV0eGuSsA1VE2+LCIdskA
Date: Thu, 23 Nov 2023 22:05:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245431B2A5A261AC451179292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS3PR01MB8681:EE_
x-ms-office365-filtering-correlation-id: 0bac92ba-9d0b-4763-973b-08dbec703e43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o/uR16Mz7AFsaMf9pXJ3W082PBYcVuCqwGC2rP6/GQtD6Tf7y+iuqjFpW8Yh/47U7ZM+0yWPEgQ077SR5MayT+xgIlNRy4rmIoAvz/5v7ZZQUPuhAKZGposB/kyMs3OPq6nBw1ZvX7a6jWeh3DgkaXB10uEaSkOvabqFioNa34msvh86dokUGR5VT6h+UsWHug5OLOa/NtRoKFY2W9/akhlziOubaw12P/6oDH7i1dtpjpx88ckfGKx9Mrvh3a/MNt3rqOttJe7vWYFv7bmvwbinmXMOTiAEXjfgjKNo3jd79AavDNcRDlIdYeSGQQXkqR7mrRo51b1A+KAOblFL8fiSP7+3aTj7K1ukTJeNZmZTsq6OcXhlFvdL7g79q0c7TgnjS0FzUzv4teAJgIg2oRkPYaTHyPl/bmqwx5YtFpVB9ROj0Tmw0nPbvWyiTksl6iX1zEVkCUArFDE0YzFdyfnNHgIZFhbkY3lsLO9oN3TA322XiLpRPWUYbi4Q7sIZcKkd/AYacm5H2ObGfn32u+APDW26FnAeE/peRxv59NZ+3MD3SMl51zYfulNfsTXP0b0EUg/fE10sWcYyXS139zbmDw+Nijxfzi2c4pcHtTQJ2BczfG83TFXIdEhfDR13UmmPnsZ1SqhPUhwWfGYrXg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(71200400001)(26005)(53546011)(478600001)(9686003)(7696005)(6506007)(83380400001)(4744005)(2906002)(8936002)(4326008)(8676002)(110136005)(66946007)(66556008)(41300700001)(66476007)(66446008)(76116006)(64756008)(52536014)(316002)(122000001)(38100700002)(86362001)(33656002)(38070700009)(5660300002)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cVBGMHg3blQ5SGx1Z0t4SzAyajcwNkpuUkpJTWJmazlmWWxQNTZ3eVVY?=
 =?iso-2022-jp?B?N0FOVnVldUVmSFdUbUVqV2l1MERURDBNSHFuUnZuKy9CZW9uYnh2Nncx?=
 =?iso-2022-jp?B?YWw0bnRQY2hxYVBUclN5eldBWERkcG04ZVpmVmFEUmR6d0l2ZzdXdTN6?=
 =?iso-2022-jp?B?UW1qT05sUmExNDN6YWMrRGtQVVlKQnJwQ1pvVWFYTFRvNllGSzh1TDdp?=
 =?iso-2022-jp?B?b0gyZXg5UXhDOWh3SlN2WnBEbDh4dkQrakt2TTZiTWVHektzVjJ0K2tU?=
 =?iso-2022-jp?B?VFdrYUNrdUVJbHVpa0Q4ZGlET1N5a0hnYUYwdm41YVNxV1pmbzZDNUJs?=
 =?iso-2022-jp?B?MGhUUG9ZZkE0TlcyY1JuNmViVnV1MUhnSXV1QU1VVEp0dG5KWDhsWG5Z?=
 =?iso-2022-jp?B?b2gzQVVPUVA4SExaV1JuTGlFRzhhSlZwemxKcjkzeFpxVXBsdDdUTFND?=
 =?iso-2022-jp?B?NWdUR1p3ZERoM0xnclVnZ2oxRFpUR0JhNDdZbGhBRE41aVJiVDVHWm1w?=
 =?iso-2022-jp?B?MDREbE9VS0M1QTZrcE85WlMyOFIwdTc1RnVnQ3R1ZFJPbExIeUFKTEQ5?=
 =?iso-2022-jp?B?WEw2N1hTUjlOZEFteC9mdWd6UStQQWNUQ25DSXhkeVhPbVR5cVYxQXlH?=
 =?iso-2022-jp?B?YTNiR0dVWWlOSWk0Ni9oTG9YSnArbjVvUThMRGQ4YzNVMjZQVmlMTWsy?=
 =?iso-2022-jp?B?dnl2U3hhS1MyRzNLUFdiOTRsc2sxM09oS3E3TWZJSlUrZGtIeVV4VTdP?=
 =?iso-2022-jp?B?citxQ1RpVCsxSmFLSkxEbldRemlMcGdKTHd1SVdaREpYTnhGMVI4N2ZC?=
 =?iso-2022-jp?B?WDlPdkdOMjJ4QkRmNjVYZTV2b2p0QmJqaFRtd2Z6VFVjc2crczJzVTlO?=
 =?iso-2022-jp?B?YVBteVNmam9hYlpya0Q5em5WVXZhV1FKVDJBN2VSSFFidVkwd3A0bGxw?=
 =?iso-2022-jp?B?TzVYcHcvVVBPUnV1d3RENkYyYUt3eGtZNWdYRUNCYXd0TS9VVTh6T1Rr?=
 =?iso-2022-jp?B?YlhERHJSK2xrNGtseUVYUjU0YTZwT3hXVzVDN3VxRGRKMzJGMVJ6MjhJ?=
 =?iso-2022-jp?B?bHdXbFVFcEVPUExDcnJveFpwWjQvQlIwZDZqWnJwK1hOeUF2ZWNZd2tL?=
 =?iso-2022-jp?B?VVc0d2g2VnNQckZMSEtVMCtQNDlZRDBvZUlFdm1rQlVnSWlsTUptRTQr?=
 =?iso-2022-jp?B?Mk83Zjl2L1EwQVdqTE1sZmZUOHJXWDlHNC9iRUFqN2l3SU13ZnNBTUdw?=
 =?iso-2022-jp?B?Um5SNzRvbHRoUm9TRkNtNnBPU0J4WWkzMTVHdTNLMzVMclR1Y05tS00r?=
 =?iso-2022-jp?B?RjlOdFhIN1Zzbi9CZjI1bFNhWWlDeTFvU3FXWjIxcGV2cGloNTFtS0hW?=
 =?iso-2022-jp?B?VlNRUnltWHJpaGFWSEwxayttWExFWjgrYkdkME9WRjYxRE9WZkx1WVhp?=
 =?iso-2022-jp?B?a25KL0NPMnJ3eWxaWlZ4NGJmWTFWSkFPdDdNWmVHczFwT0Z3eFBYQUw1?=
 =?iso-2022-jp?B?T0l2c3EzNGpnYS9YTGx4aHFQckE2RVl0MzQ4K2N2eUNlUDJ2TzFqYm9l?=
 =?iso-2022-jp?B?ZDBNbStnQ3h4dHJDV1R5VDRRQloyWE1DUmcyVGRQRlc1bjlaRCsxVTJC?=
 =?iso-2022-jp?B?NW5yeWVXOFEzalJiKzZSMEZ6QmlWQlpCODlDQi9sMC9vMnExVS9KN0Fp?=
 =?iso-2022-jp?B?bW5GendqVmMwVFdkZEw5RHFSYmlKbXlVV3JENExmUThIS0lBN2x4YUJO?=
 =?iso-2022-jp?B?UnlzME1KRS9EVjI2WkY4dXRqYkdxc0dYbVkxSmRjQnoycENsTTh5cys4?=
 =?iso-2022-jp?B?TmpkOW5GdWE1NnJnODBoeFkzUkNpaUUvZUQ0UzNRQzh2dURHNzU5S09h?=
 =?iso-2022-jp?B?bXJPa1FFQ1FuSVR2bjRPaUxQVUJkRTgwd0NPdHJ6cXBxbEI1RFZzVUxD?=
 =?iso-2022-jp?B?Ym1kRnEvU25sSkVmc3ArVTJXMlArbnRnU2VMVXpiUHFBaWNOSWxhOG9T?=
 =?iso-2022-jp?B?L080bG1OOFdGZis5dDRld0VvMjVHWG5rNVcyR0cxNUdkamt4UjUzNEVT?=
 =?iso-2022-jp?B?cE83a1ZYTm1nNUVQR0llbWpEOEtxY2FKbUdzRzZsWlR1UlFTQkRrMGhx?=
 =?iso-2022-jp?B?cFo0L3Y1ZEhLVnVkWm1TMHorL3llWVhKQyt1Zlh5aVp5ODdnMkNmU204?=
 =?iso-2022-jp?B?M3EvUXJJZWtwb1J4NDlYV0ZENEg0T2pONGNPczhFakJZMmVKTzh5M3Y2?=
 =?iso-2022-jp?B?NStGcEttSmNCZG5EdmF4bm5oVXRqVmRQNys1dTRDdDcrUUZ6TTRrdzJq?=
 =?iso-2022-jp?B?ZklTN2QybkxLRnFHY1NzZlo4S0hSdTV1aFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bac92ba-9d0b-4763-973b-08dbec703e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 22:05:02.7990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nVk4sMZzEW8X4Fe2GMnV/zXwcSPoQvJn+uvj56dj4yGTo1WnraLWwgqaVrTI5mbCyjTmfsqhLvTGuPdUOfmaWk/78zOqAddi5WKk5XM8O6zI+BxRPOet+M6232uXnIu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8681
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 22:05:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13688

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, November 23, 2023 1:51 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
>=20
> This patch series aims to document MTU3 IP on RZ/G2{UL,Five} SoCs.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (3):
>   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>     names
>   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>=20
>  .../bindings/timer/renesas,rz-mtu3.yaml       | 67
> ++++++++++---------
>  1 file changed, 34 insertions(+), 33 deletions(-)

I reviewed this series, LGTM. I can apply this series.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


