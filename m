Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87516C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 09:39:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.26219.1643276387511708549
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 01:39:49 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 20R9dbrP024353;
 Thu, 27 Jan 2022 18:39:37 +0900
X-Iguazu-Qid: 2wGrPrypr2Re10c3uq
X-Iguazu-QSIG: v=2; s=0; t=1643276376; q=2wGrPrypr2Re10c3uq;
 m=GC0iECkkliypxHxHqk+hgKUplFwOncJJsbSJBAs2+NY=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 20R9dZgj012105
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 27 Jan 2022 18:39:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+COP//YLcUg/HBFi/fFKqZE5hQjnzgDZ3bHiFF7RTyRPwmC0Ustu2xfLOyJyXFUtLfIB5L02buN++UPEEFdw0ybThtdTNosTxOWP3CVTvfv8Uj6S1xNzEoRdlvY6wTHl9/ap13/dzAH3RhzRuhKWYxx21aEvhsgbGCFzfi+PdPkmVcOUribUOpIDJSUfETa6zDJEZi2UbOvP6aQPhaEMYyTiOJh6Al3gM/CnW2cYO39bLF62XYEMkd6m2RgBrs5EtX7Rg2MfghUkNayCkCa4MtEEn+9SCNcbDvBxOxl3kquzLxVJEppgUSxEIZHrbLuEm0etXZww//GU3vfXxWo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUjEf3lojcscnTZdlx3Ds5JPhihi2Lrj6l5dsA8pbJo=;
 b=JazLev7e9NCCvpBgE+OPSAhtYDXGkv+9D+wGHSYmEgz/C15qbgcB3SeN7GHkWLaScPanFmo70mQUMor6wo0wQrR6WdFT54LeBNtmpICcCOmF6Vev7wXK7+ALva0FiaOxPyjs7+2AZDG1v8qBMsV2vqAWqzFDGuft1C50XWQ4Qzc5QuTXwfvma7UqXcGddTQlez8FEg2wdIoJkTJI/uN9ygs5wM4EjT2GAOwhlluvUJqLjgVHvyL33HJ1XGGdE8mvIeC9bPVz6V0nk2x3xrJ+O1zxaz+zWEOk9+hxdbf8XhDSv6K/+78Ti/H0e2q0OabM+9KEGT8JDEkDKA/hTMjn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Index: AQHYEvJ202eby2TASUy4nztI+sVchqx11GWQgAAHWACAAMGyQA==
Date: Thu, 27 Jan 2022 09:39:32 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252F0114D31EC9C5D051D0F92219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB625274BC4EFFA92D99EF211792209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20220126220524.GA26019@duo.ucw.cz>
In-Reply-To: <20220126220524.GA26019@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 616d448c-8803-4959-6d8f-08d9e178ec7c
x-ms-traffictypediagnostic: OS3PR01MB6151:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB615152D936B405C05460EB3392219@OS3PR01MB6151.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 v/vPrmMy9NlYcliJKeh47hXjF3CXpUk1nW1HwDrGVNbJSXOXxPGW38YBf22k6zRHPALC6EjmTP4AH9DZgYkVh2u3g2dI2VKwDW2CfsEFtiZhQXqNctV+17PxArt2l/Xc37Lp3ISvA+o4ooV7GcEOtXtKLjunMCrnZomoFMOyxsf+VCWkxkGn1Cv4lpL08965IQgUxDljtqu8hjJOmNeD9Lnkqs1nfSa097NeLwdvjlL+M3v8QmotLlAK++TU7sTZVSHa1lvlXdRYx61jFUpwDkYKKEHBle9sK5bhOMfaMnAvNG+JXHsJu+AXbAKlADwoYxzqH1cOOhLUmwd6L5cVZVgAGPjJVYWMhyXxY9tsUs9PEWio0GLmJkqDPlx+ULCf8acpJCaV5FwNNuzqP9WCvVvcYPhgmlFiHK2wt8ZSKYsuDwflDkDjnNZdS6MwYUY4xCxKW+ZJ/RpNz4gO/BI7uCNWNJAoPkZJyeGqVxH+yXmGuUcWm2fS4Q2TeMZc7+s6+32dx07PhbRUdyQStFuDWDSIFmfkHRf7q2JYAYxeYOaoVFIZbyDAzcWSnMDAo/wZIaOBQFR9cp/+OQdstfjoMagwzh2QDaa3WSqpkEsQlhnA1xLe67f4Wnm/FkWkLTzNCHe++tYcdPw1QcfO3CyPyuCgZ9GWkqG20XfzXqcyJQqjaVR5j76e4y4nNinFGsTbU1Mt9qhjmYqEQiP6qgOp/jUjZM0NLITlJlfiDLV7o6adZcwVVLkSqNOemRDOe7EJodrI3SF4WmZYgz4NeQ0Z76zKUvpwtj78WHVA+otpxaE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(9686003)(2906002)(6506007)(7696005)(71200400001)(86362001)(83380400001)(33656002)(76116006)(38070700005)(5660300002)(66946007)(66476007)(186003)(52536014)(508600001)(66446008)(66556008)(26005)(6916009)(64756008)(8676002)(316002)(4326008)(55016003)(54906003)(122000001)(38100700002)(8936002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eU1laHgySkI1cUt3VXZKeU90blRwVWFJZ0FtdHBCNnM3ZzZwREpkbEk3?=
 =?iso-2022-jp?B?bUEramYrVnQ4RGRmOEZtV0tUUTFtTnl0SzlRZzJudFFMQXpZSlhGaHBI?=
 =?iso-2022-jp?B?WHVhSXU5QnNhQUE0QzhtbXZBYWJvQzcrTXhuTGo3eFl0ZmZuN0orblF1?=
 =?iso-2022-jp?B?SVZkT3RaQ0t4d1ZwVm9DRGNiQ1VMdFNaZThRT0dKSDN2RjZ3a0NoR2Fq?=
 =?iso-2022-jp?B?QU1YdVZSa0xLL1diZExDeFl2d1JGbE1YOWFYOTk3S09RRUNtY3BqaGdj?=
 =?iso-2022-jp?B?WnM3VWVzN1pLRjU0a05kclZ3TGp4RFhqMnlTUmFJdGppYUlMaldiVWJ5?=
 =?iso-2022-jp?B?SmYybDNhRzFsWksyNHFSa2FLMXZ2NElFUmVZUDJCbFBmWTd2RE5aMjJH?=
 =?iso-2022-jp?B?NGZYc3Y2NExKd3BBamhCbFRNamNrVjNtYUtuM285YitySDRUYzdVcG1m?=
 =?iso-2022-jp?B?NnBGVVR2THJpeVdYTUI3NWdxRnpFNUhCRTdGSDJaNjFFL3JQUUhNRll6?=
 =?iso-2022-jp?B?MEdPbW8rVzdCb1BNM21jU0tYbEd0WjAxaGNONm9DYTA0UEFzSWxoOTVB?=
 =?iso-2022-jp?B?T0hXd2pReUlrUG5ZZ2p2c1BsbWpPbGpvb3NiL3ZCZ2FVMk1DVFpkQk9h?=
 =?iso-2022-jp?B?Um8rQkkzOEJsNS9TNGhuMzMvTWZ1alVUcUtEZ2VDbkF3UGFMdTJpcGw4?=
 =?iso-2022-jp?B?dEZibzZta2tXQjJXeElMaU5OTENJL2dXU0ZQWWRHT1d5bTRjeVZFY0xj?=
 =?iso-2022-jp?B?QnNzRnZMeDZWMzFPNWhNMngvbkRQbTc0OStSREdUTHIrNlBwYk1iZ0VO?=
 =?iso-2022-jp?B?Z0NncHlpSUZhZGhaOFhHT1hiMlAzMG5rSXB4TDRmQ2U4WmJhL0R6OUhx?=
 =?iso-2022-jp?B?TnB1WkowTjZzQk51NlZQN1Q0cWRyWS9NOEFHc0dNQW45bEVqaDU4aFpP?=
 =?iso-2022-jp?B?SFJYVUNtVmJXemNvZS9FcWRkYmNiQlpSaDNRYnh3TVpiUnh3VktBUitH?=
 =?iso-2022-jp?B?dTUyNWdQNXhDUE50SWRPSGhTY2VudXczQ3VJd2Q5bTJMY0hrTkVldmRy?=
 =?iso-2022-jp?B?MU9vRWJkeS9QVVMyeDVuSnNOOFJsVEpSOGx1ZXRrcEdKdXI1dWJyK3Ri?=
 =?iso-2022-jp?B?WXI0end6SHg0N0VEUEJGNDAvSzlzVDIvNGxGZFE4UjJ0R3VORTFrNFVn?=
 =?iso-2022-jp?B?ckptb1FuQXJBQTVxV0xYTXVzOC9nMFVkQmFMdHd3VnJuNUp2ZnNyUEJL?=
 =?iso-2022-jp?B?RDdEc2FGT083SlM1dUFQdXBUK0tNMGEwNjlIRTVteStsMEtrcTZNeXBT?=
 =?iso-2022-jp?B?MFNQQUo4M1R1SjhwZC8rZGxMZDIzc1pZeG5iWWo1bm5GK256RXJxNDYr?=
 =?iso-2022-jp?B?S1gxcGJhV2FuaVh2RHEvU29GeDNPNHlqdld4bkNnODJLUHQ0VWdmMzRv?=
 =?iso-2022-jp?B?SU01MGgwdFVHZDNva0ZScFNWdUlISkpETFUrMnZMV3hnR01KdkNkdHJt?=
 =?iso-2022-jp?B?TG9uc2RzUUY0aTJ0Rml4eFFIcnJQWXlkWjdRcWxtdkF3dzZqZGVuakhk?=
 =?iso-2022-jp?B?RGkvVU5QWjdQM2V0TG14K0M3YTBMVitmSEk4VmVhSFYzL2RaRGUwZkd1?=
 =?iso-2022-jp?B?bnl3L0pjVGRBQldrZXk2Ylp6Mmc2Wjk5WUQxbStrZTR5ZnFwd1htcG10?=
 =?iso-2022-jp?B?TmIrV2p0ZDNvc3FLWmtIdHluMDBjSDNYK0NRWGg1ZWJMWkZGMkJMZnFm?=
 =?iso-2022-jp?B?K2NUWmlEUHZnNm5HZ0UwWVdVSGFoNmFFZ1BPSHRsd3M5VFJHZ0NVemlG?=
 =?iso-2022-jp?B?YURxcENVdDE4MzVoYS90SFV3ZEQ0cEpBL1ExRExkcXhqY1pmZFkwSWpP?=
 =?iso-2022-jp?B?SGNITWVmVE1DeWNLOG4vVWtEaEZ5RW5UL1ZPRDc3UjZQRlBLbWwrcjNk?=
 =?iso-2022-jp?B?U1NORHpZSythYWRvM3UwMElaeG5jdFVZWVYrdkFucnk1Q3lRUHNUTlFM?=
 =?iso-2022-jp?B?MDY4QkpjamxpZmc1Mm5jUTZ3OERUMHdSakZjOExvL2JhYnp4T3ZSNzQ4?=
 =?iso-2022-jp?B?NHM4dTdYUU9FYUZaMjJRc01nZ0dJR0IyV0hFOHI4aHpjcVN0QUNJcVdt?=
 =?iso-2022-jp?B?UEtyZnpkd2JneG1zLzNXMEk5TWRmQ0JiNXpqbkFnQzZLbEN3REs0Zk9G?=
 =?iso-2022-jp?B?NllSMVdWQWNicHZzK0s2NHNPNU52UmxSMGxzUUlGdlgzT1lwRGhFTmw3?=
 =?iso-2022-jp?B?OHg1dGVTQVdva3dOWmJ6RS9JK1VtMDJ0TW51VXRUVXcxb0kvZXpIWlFk?=
 =?iso-2022-jp?B?UWp6WXk4eXpGbmFCeDBIL3lQbW9QZFM1Yi80c2I1cHpoQnlFVk1LOWZz?=
 =?iso-2022-jp?B?aXQzS3UrWTJJWllqallFcXlvOFl6VWxMb3NJNFhnSml5YWlXd1FkYmZk?=
 =?iso-2022-jp?B?U2VhdUVaM0lyUWpocXl3SXBLWWQrN2FPNFZiMHF0VG9PT1doQ2s3QWRh?=
 =?iso-2022-jp?B?ZkJxSTJH?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 616d448c-8803-4959-6d8f-08d9e178ec7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 09:39:32.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ewF9IqmpFrbtKvb5Y9P61H01IlrbUb40katMaxaFGlKhxcejJocsaUSNcHaM4kC1hO5L5srptHaVieTHscMPwXIAMB/6zQKq76Gl3qM6Rp/8XC9/aNAAvvfdG0U8u5zM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6151
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 09:39:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7498

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, January 27, 2022 7:05 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g;
> pavel@denx.de; biju.das.jz@bp.renesas.com
> Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe=
():
> make sure we free CAN network device
>=20
> Hi!
>=20
> > > make sure we free CAN network device
> > >
> > > commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
> > >
> > > Make sure we free CAN network device in the error path. There are
> > > several jumps to fail label after allocating the CAN network device
> > > successfully. This patch places the free_candev() under fail label
> > > so that in failure path a jump to fail label frees the CAN network de=
vice.
> > >
> > > Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L
> > > family")
> > > Link:
> > > https://lore.kernel.org/all/20220106114801.20563-1-prabhakar.mahadev
> > > -lad.r
> > > j@bp.renesas.com
> > > Reported-by: Pavel Machek <pavel@denx.de>
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Kieran Bingham
> > > <kieran.bingham+renesas@ideasonboard.com>
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/net/can/rcar/rcar_canfd.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > LGTM.
> > If there is no other opinion, I can apply this.
> >   Test:
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/4571
> > > 23034
>=20
> Looks good to me, go ahead :-).

Thanks, I pushed to git.kernel.org.

>=20
> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


