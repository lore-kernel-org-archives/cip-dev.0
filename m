Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398E10F9315
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 01:29:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3237.1775006960262248042
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 18:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=qcw7De6t;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775006957;x=1776216557;bh=mj2I5HfDVL+CQn+RQqf0rwx7GroMWYVQj21uI
	QgRE4o=;b=qcw7De6tydSA3V9juT8jZMLrAWG0ZuTYDxm1uWQqLtmtcOYYoUTDqTCenjA+YIDaIJB
	+vTd+CDhfXt7CzDilbBjS4c2yZBUAEJ0GtOiwI9iXk+1Jaq1jDHLigIZjV1szRJ5qKdpyJEQnrLRN
	G7FN721UeE89aY6rPBv4zUiyEQfM/hRTIliSNU+aByUbi/Rv6V92kJib1ZDcJPi/RRo2ruvFPVhMb
	Et+r3AfB1t8bYjUKN0DHS1uUNJYxi7+X+LQ+jmre12DAWTAgZ9DhF+VtBxj+GL07MYDNaQLMVauv5
	jncovpJJk/U+7RzbHTQ2acHoLqp/tJvaTkCZyLnGK/eg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6311TGIq1568339; Wed, 1 Apr 2026 10:29:16 +0900
X-Iguazu-Qid: 2rWhSUPmTmza8Jrhon
X-Iguazu-QSIG: v=2; s=0; t=1775006956; q=2rWhSUPmTmza8Jrhon; m=Pzoni3WQnBKwmmYGs7aaciOnm5x9Wufd3lN//OCXU60=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4flnT724WJz4vyh; Wed,  1 Apr 2026 10:29:15 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beuM9J7Licqpo3qzgoBwRtDzhNHSWrH9VU8q2jNVADceSEF+N3gqPkJ4nakqKJ27Inawij+93PU7+TCq1038Pk0a1SQI755AACfzxMRNYb56Lsnlz85aqWiZVu2FeOnQ/lswtUsXoWiAxhZWE/pNrpU6Pbd3FYSUx5MvHHVzEKVZK+pkvleYjsQg1ep9ARpV6rSOhPEyWqnEjC6QYcPm0vTjlkkzeavZZ6gn+Q806fqwoKru9V+D8X/WLQmz8EJZ4/l3NkdvxSolJ456vCu0xk46J1ASm8vywezR8z9wZTNxqJuDrI1CKFE2SSZ63xodq1Bvfbj50b7ggB6odjN0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf+MW2y/jZpBmQjDv4hYTGV1ahM/6eYsHdS6XwAaTVA=;
 b=KJBysj7MQ8Syp7h945BGpaJ5S+/P4BtFRVJ48+5Y0CCROWqD82tJibBKf5PhX4kMWhEpGTR48rsrfw1w8aOZG61nLGMZ8QWYM6MxPxamweHeGvPp29G0Y28qNBzPwAeuFH6MIoVwR0F8IK/w2NfxSELukYDKmslmdS5GdDqDa+SPN7XF+CUvQrg3ueflwBtthKVIJ7lcQXpMJpp+jMdSSpKzFdLiIS0XkjW83p9fZY03JZFMrHiAX3p5f69p2+WXc1v+iCc/IWSw87r/wzOx6ZTHiNqWaqI+TM49qhGxaJ9sajPUGZ+2gFgwIlRYI4pBGufw7Au1VwyBg1Y4bATImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Thread-Topic: [PATCH 6.1.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Thread-Index: AQHcvc+ZF2YCzdEQ4UGs/54FqKvqwbXG5FkAgAKNZHA=
Date: Wed, 1 Apr 2026 01:29:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481872D2631193E217AD64DACD50A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acpQXIzit4oEPTT8@duo.ucw.cz>
In-Reply-To: <acpQXIzit4oEPTT8@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6923:EE_
x-ms-office365-filtering-correlation-id: 530e2666-4380-4b0c-fbb2-08de8f8e149f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 va2zOuF26ELiZNXS5cqczJegdCRnYG+V3jogURKDS6tPeYsNm8aaSWAemK/WMkD7AkuSj1MpyElUhRfuRvt9d7fJDmxQtyL9zx1bPeUUriv4yRKw9JIrgudDzr7wOMYMM2GUjAxlzClpQ8EtOpqfvugAzQp1aptn6V1d9PC4aW+ip0neA0JYepgrs3ZRuztPQ/7V+3Sr55YsemO25v4h+fPzVK+UfBMnQPBRC3tIy64BqlyxSETf/Y9TpFbiZ/oEdhnaQ7EMyMsnO3i/G4/guwDDMj06KfOqSMgcanspJCG/LWe0EDBC7BUtqbT0aNtwMGFeelwaoUKJyEXgn+2IvVUbhebaVbxdLIJTqjJFYBBtwy441ns3bPoB9qx2oxjJ1RA5Y97+T/MUCr3TyTaUX3rg/4WprgjS3+xWiTOUZl3DfjwRq/tgh3JebBOjriJJCgwVUo1m3DLJX85Zfy1cMqXUejOZYw333zdQ0BooF028UJ1Xyz8bv5xEm0GbCyGySE7gd+AysX4H5R/XOUVYdfLpvlsnuR9B2zp69qUOGeWau4o7KLsUE0RNgEdFiZjSCJPz8+2TNYImrKeOqYcu5VB47pZLpZiEzJcMsNHCEgZhakWdsqZRfFAmppzQQyL7bxjPezcRoKmG0FKCEpGYh/lpmlE5ouLS/Z2Yck3gAUqcn0J6wzT9lno6ruWezOA5JszgluRxV2+xxQBGwTxSCxSn+KutzNNKv7nu30Cm/bOkQYm8vmjddIjFl1xjq38vV7B3pwIBREYznfymMIg3NQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N3dHTXY5cWxtbHRwTTdnd2VZUGNHcVd4RjlETmwwSFJ0NCt6L3g5eEVH?=
 =?iso-2022-jp?B?UlVpMHNWbWtDbU5yT0hoT2Rhc2VHNzRqVlRYcjU4NjhmWHJ5cUtDNGdp?=
 =?iso-2022-jp?B?Q3kwSXkrSWRyamdIUVRJaStiYmd3cnc3VW1WZWd6S1N2UkJJTGdsWlFT?=
 =?iso-2022-jp?B?emNFdUVFc21sVWJ2NnZXSkJ6aWpsRlZRYUozK0ZzNjFWclE1ZW8vQUtZ?=
 =?iso-2022-jp?B?QzVWNUxDZXl5RTRKeDNhbzlrb0Jad1Rjc0pJOGVGcE12em9IRGR4TEQv?=
 =?iso-2022-jp?B?UGpjNHdnNHlSSHp6bTZGaTJuV2xpMjBIOXBKOGxYUkY0S0hndHJlWjkv?=
 =?iso-2022-jp?B?ZmVHSWFPbkN3Y3l2VHp6NnR6TXlVa0R2MExNWUZsWFVoUmRic3crU3Rh?=
 =?iso-2022-jp?B?c2ZyTFo1czZDUWlRcm43TjhCT1h3NVdlZWhPSi9aeHh0NmgxV3JjVFk1?=
 =?iso-2022-jp?B?U09tU1hJb0VyaS9sKzJMVjdRZlVIdXUrQU5MWVFXRmRQVWlnS0J5M3Vm?=
 =?iso-2022-jp?B?LyswTm13aGFkMkVra2Y2NElZZTg1SEVVNjdZWjZoZHlXUm5FazFFWjNP?=
 =?iso-2022-jp?B?WkJiNGE1ZE9xVjNHam5yb0JpQlRVNCtqK05QRmFKQVJuR3g1QWJ2Nmw2?=
 =?iso-2022-jp?B?RTQwVDNvMGcvdWdTOEtrN2dZV3Mwcnh4WUdmam96ZG9VYXVnNjQ3VFg3?=
 =?iso-2022-jp?B?RlR0aWZiMXlIYm11Z2VOMSt5alFIQmkxemkyRU1qbm96R09ld3h4WFJz?=
 =?iso-2022-jp?B?dC9pdzU5SW1ta2h0bk8raXh4SE84R1R5blZ0MkU5U1Z6YUZPNEE0bEtk?=
 =?iso-2022-jp?B?TUI3VDViaHliRmNJSnJWQ0JFZVNQSkZYMXpabVR2TGxmRXRxVG1vQU9j?=
 =?iso-2022-jp?B?U2MrNVQ3ODBCWjl1Y0dpTEEvVUdVVU9jM2hvYzRMUWhPSE5nZ2RmdGFE?=
 =?iso-2022-jp?B?bnJLSnREV2U0dFl0YjNwVFhaZmZnVE1EUkVDK3FGdEJVaHozUngyYzRa?=
 =?iso-2022-jp?B?SFJtcHRhaC9Lb2YxTVZrU3lCc3FTWkkrQ0JpTzRCaHFsTnI5QXNITjll?=
 =?iso-2022-jp?B?aXZ5WUg4OW1WMTJPQkNVa3RzaXByT2tsNGtKRVJnWGE4TEliWndRRWhn?=
 =?iso-2022-jp?B?VHJzUjFVUkFlNVlLV043cU12S1hoaXl5N2s5TUcxOW9ZTW1UUE5rYlEz?=
 =?iso-2022-jp?B?d3liMitSWERHZkxiVlA4cWUwMlRtald2U1ZibHVtaFhaZ2xlUk1LRTdt?=
 =?iso-2022-jp?B?Qkltc3drT1BiRkxUK2Q0YmcrTExkaC9ISjNzdlBobUVOdGt0N0xqL0Jk?=
 =?iso-2022-jp?B?RzVOL3VGWkdTaXM5ZlhQSGdFbHVkQ09JN1cyU1ZnZjRxY1NJS1crNFN3?=
 =?iso-2022-jp?B?bDVkZVlJUmV3a2lVR2dQdlB1d3dhdjdYMGdkMXloRjFLdFl3ZUZxK1Rt?=
 =?iso-2022-jp?B?aVVjeWZnc1N3cUhXTlpaLzYwaG9oMTFNalc4RzZsK2tHUUJkWHE4MFZx?=
 =?iso-2022-jp?B?cGY5MHc0MEk0RWI5ZzB2MzB6NVp0OUhrNlVPa2pBK3EvS1JGUmZNT3Vj?=
 =?iso-2022-jp?B?My8wK3V1MWc2am5jVlZ3a1BhQnpaYjgya1VZQWw0SnB5dm9xdWZicVZr?=
 =?iso-2022-jp?B?ek5PY05ldnJtTmtWd01PQTBRVlRiWDBVYWZIN3QyWHZnZmhrYjluYVQr?=
 =?iso-2022-jp?B?ZFhSVUNpRzZQV3Z6ejE5NUEvcU13bkx4S1l1QWRRWDN1RTBRZHQ0VEdF?=
 =?iso-2022-jp?B?WTJkVE9LVE9LNWs0SUE5Z21xaitRNVFTaE1oVFRGbHp5M2N6K3BkdTlU?=
 =?iso-2022-jp?B?WmU3ZUkxZGdQOU9LZnlWRkpqVHVYOHluV2w3eExYdkNaUXM2bW9PeHhR?=
 =?iso-2022-jp?B?aWRaY00rTlpwQVBiZnVqbzhMWlZML2krVmxGclVyK2xhOE1yWkROb1I5?=
 =?iso-2022-jp?B?eSthTmRBY0Zja3FucXZkYThhWG9RVC9IM1YwQU9wRWMyaHFIY20wcExF?=
 =?iso-2022-jp?B?QnFiSXRZR2NNM1N6UGg1RWxXZ04rdnRIdDhCbTNLMlQ5bTZUQTZkODFQ?=
 =?iso-2022-jp?B?bk82SkxxV2tVQStZYXJKM29CWm1WaGlWc21OSzJwQWM1S3BPaExBUzR0?=
 =?iso-2022-jp?B?N1lndlgrUWh4OURKcEU5LytZcUtaTGx2U21XUVI1K2lzWXRmdGNkK0dC?=
 =?iso-2022-jp?B?TzRVaHNjWGRjd1NjTjVmK2tQWTYrZ1dWYVgzL0diOTZEUzZjeTl3QnZN?=
 =?iso-2022-jp?B?bGNoTGVtankvWUlEOGpJczBodU43VHp6UURNRmJlcnhVVnpGbHdHeWZ5?=
 =?iso-2022-jp?B?TklCL2dQaWFLVU5iMEwxRDdhNlo4ZHJsSjJ6cnh3eDdSbE1FWHE0RG9t?=
 =?iso-2022-jp?B?S1prdEh5UFFodFBXdUxJVDdqM05xUVJmOWpYKzdXcXBqRE95ZnI1dmhn?=
 =?iso-2022-jp?B?LzdzRk90SEZTOG9vODJQMzJkcUZIRmxVaDlnZDdIalU3KytTSCtSK0Vx?=
 =?iso-2022-jp?B?SHhKaEE2VUhtSTNNaGU1S2RjV0N6MnpIMDBxSzdadkNERHlGU1BIemNP?=
 =?iso-2022-jp?B?Sk9vbHFxRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Ovarr24yarZ44uo4PJL3viOWgdct9pwMFOX4UXXNiu5/K+z6rbXud+aoBfafLvlJx3YfKqU1v+Cuy4+/8hQjyo6WPqHHLMROqhbbYJBzFWW0usrVwj6FS6undXFYkLfB0A7StVFALUJC9f0vxVV8JAncUAJTcUHIgPcz/ase9wkbf4SAIcCLaxgWbHy/g+f55MwOSu1czG5MLLXv/4iaZXCbtgdQOICdjQjDXDhPBKyTkD38ITRd7BnmCYTH15FV55xf5Sngv6KkgBRGJGoZR+xPWzkmaxGZQwXExRw0BvV1bC6tihJO1SUjuO5XY93svp/PyG4jyen6d6lm36R3Xg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e2666-4380-4b0c-fbb2-08de8f8e149f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 01:29:12.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+THy3CRiRlvGU+nrsnii6gO7SAA4rgtfxoWM0gGAdi20s4jF2w03nZlNjrAwKCcGMW/rx9nET7hnQZqizdmTPm0X8G3gx5MORv6sroxJ9TmbQvq94GkwlITmX+m3foV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 01:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22609

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, March 30, 2026 7:29 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
>=20
> Hi!
>=20
> > This patch series aims to add CANFD support on the Renesas RZ/V2H and
> > RZ/V2N SoCs. CANFD has been tested with external CAN PHY transceiver
> > as the EVK isn't fitted with one.
> >
> > Note,
> > - All the patches have been cherry-picked from upstream
> >   kernel.
> > - Patches apply cleanly on top of commit-id 1ea90e3298a62
> >   of linux-6.1.y-cip branch
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

Looks good to me too.
I will apply this with Pavel's reviewed-by tag, thanks.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


