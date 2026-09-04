Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E22C61DD3
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 01:19:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4265.1788484750923799965
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 18:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=g3vPFAsw;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1788484748;x=1789694348;bh=pk+Huo4b3Fxi3aZWGV1521g3WCJ9WdsmBTvhm
	hYxH8Q=;b=g3vPFAswb4CPOCJnw232yoVFIP2wQILAIlkta9cadBBrfpBznNcqJB0IwXhKJtZFsbr
	Jc1Mox+/RXiTptOAVfYcq0Nev4vLopW/RMEXgMZYp7Ltx+rzUVNmYo7WykO2iEoy8rNq5dAp4jIz7
	n6M3MeDACL4D/kTRgrqwiXtiPFH+1J0tRubCpoYDQGC9/95aqyDIFcpiAB8+SxmI93TCZqLhYRkuL
	2iMz+XdMvOvqQlAcxTEOqlbD2X7STJ0+a4SUz50W3Wq+GcYf8TCC/PtJVkFlDQYBhyJ3F3BkfS6YK
	XYDodEgKRotl3tLf8HXETcQXCp/tlRvniaFcU28Bc4Ag==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6841J7YU797995; Fri, 4 Sep 2026 10:19:08 +0900
X-Iguazu-Qid: 2rWhJyGID0nLPVE2Br
X-Iguazu-QSIG: v=2; s=1; t=1788484747; q=2rWhJyGID0nLPVE2Br; m=t+b61r7qylHqhFFd1Au1bohlIbjlIpi47QyIfvqfos4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hbdsQ6rHTz4vyn; Fri,  4 Sep 2026 10:19:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBiFjWqTXaIMx1HNKazLcyqetKg64/tAsChOTgH1OCykhgkHR5ypkwHKjVNDSTxKcQdk2IyHcfaKf88c+G/nqjv79MMDnzhl4BCRr4Z2G/w2zuGKmKYVhfpleW/BYOY9Tt7g/supwEHm/RwinJhurG0Eqgg9BaCsKkkMftzz1BuVHdv3VTVlZSH2RUCsDxzTF5nO4iJ+1TZJyPGKzoMqqdmC6pckBsij8oRyQKG1ws26fSKGfNQb61J9q3NWPg4hoBdHiPhOON79M6UzIC1JeHXbUj6Y1SXN2W+YsWowgnvDIV1JdjjF6GAR1m9PT6NmqCZ6wVWMip8UKa0HmCTjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/L8Iaulze/RA8EhzwG6ZiZ9wRVlheYCQkmiCFysxkg=;
 b=FX062l6klDxcQdcA36RjicDH2v40GU+o4WO5bb+ypezSvPETxF3aukkWn2thARPiw8Vh3hp11OT7jyHzl38tTq+9pc/wVzVCTAaE7BsFiED+qpptPCBAeXs+vBukAyNjJGAYWzYbpfaqO93GzdpmzmKL0Fp0MbqOMGV4zAe4pjfWcJj+cXJRHhkJX1cJ0bVb4Cey/jIok7OflOlv8ItjvfjxMFC+tBa0MmdLyBUc/uS0HfcEQaQpip47zTgT50JnW1mVwVbSpwBn5NOuM6rb8Yc53f0j9XbpEY2N0fZU6rr+JfpU+jICM5XelLLlvdy3WeGOqtoFIH2k62BmJ09bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ICU error and software
 interrupt support for RZ/V2H and RZ/V2N
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ICU error and software
 interrupt support for RZ/V2H and RZ/V2N
Thread-Index: AQHdOr1FtAxa3PkUzEioJLZ3yZCFora9QBgAgABgSyA=
Date: Fri, 4 Sep 2026 01:19:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481819EC13BB4E67239BE4ABCDB52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
 <apnLBGWeIWKIWJM0@duo.ucw.cz>
In-Reply-To: <apnLBGWeIWKIWJM0@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10500:EE_
x-ms-office365-filtering-correlation-id: 90dc84ca-f4ff-4e17-1fc5-08df0a2280ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|11063799006|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info: 
 7wKc8/4hKbw5q2CgtpxagIecS7+R1blx/vTW1zUeZK6OV1RgHOIROKWTvQDWUBZcELjaD+nXAw4kicGZtEh6Uo6dM8P4NQ0RQtDBiC5NHAOk8H6b5xWNOfeO241eFaWPPZLN1ECoIBTEhbLb8kXrBgJWFRdz3xlO87sU76W5HQDlzVila4+QE2l8531whf7xzOwZdXM2L0XF8yJQlhaGPuEZEBZZhJ4Yj39EQBJrJPrizjJesSjsbJmvip1bq3J14PQv1jB3W4/ZrV4jOMy5C4SOGASBY9PG1aN4C4eawWf5IrQqB0MZu6B5ztS2EyYFqKZs7COtEXkK9K0bdsuwmzpbsMMTd+OoeSLYoUG6Qr1yaTHBHAWbSQhA0gZl/Ui1v1Ha/E/Zm6JOknUy3fO3dfzHQyQT6IrXLTWd4n2CKGVPl+KZ8U9gqlTzimUoeOUAau1xpVp6FVDxg/9D8GbRQgk9i6Tiil+7q2w4S5fZQ6oAbFhAqT5tiiP1KMDH1X+lmWFiQSpeFKykPXSYjqiYYoTl2EO6Cs2EvddDaDE++3NRIbxirfyIVxup3kQ8e47SH7pSoIrLKGEawb/49FBacsSWESE7I5rr7oAIbYh6z0b4en1mT8eay+IyawasT0GriaU3pg/wEdlnYzFYUF7iPRRU9L8E2tqj6X6WOhNizVepD+tWKAHjW8DJxIglSwl3DQ/5sag5B0ChtLVqWlGlpvV+yWedB3rNz3bylTuPkuM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RTk1WS9pdWdGRnp2TUQ1R0RWNUI3MjRpUGZTUENEbmpVWUFOOHdreE5v?=
 =?iso-2022-jp?B?U3Z5cGo5S2cweXhxaXdjenhUTnJueXhmMC9LakNveTRJV2hHbGU3SFRF?=
 =?iso-2022-jp?B?d1ZKT1VMRThLdmt1eVEwL3lWOG9LNUV4anFxZytTbCtPN1dRWENIQngy?=
 =?iso-2022-jp?B?aUE4UXpqVDZXWU5ad3Rrcy90MDI2U3krV2VXWkFtb2xFTTVoVW8xZlll?=
 =?iso-2022-jp?B?MERibzdsOEFNVWl5M1ZYakJSYWlyZTM4LzRUd2psZ0tQN09DS0wwNG0z?=
 =?iso-2022-jp?B?WUt5eUsvbGpORXBoVmlhb2F5amJXVDFjZWNWQTRCNHFBNmJIWk5YcGZW?=
 =?iso-2022-jp?B?SzlFOEFIUVQwTmNNOVJudS83LzNObExTbjlLM0g4RG1nUW1HcGt6SzBy?=
 =?iso-2022-jp?B?Y2xPZ0JmV3pFRVl3WFNCMncvTUtlYTA0OVpacDZvM2ZuTkwwUmd3eDk2?=
 =?iso-2022-jp?B?N3pZeUlVTUdXRkxUYVBzcjE0U3pidXBaWlNGWEx3c0MwajRtd2phMWw5?=
 =?iso-2022-jp?B?SnFtMk1WK3JGc1liOHhtdEMwS0NySDM1SW9pWS9yVExwWG50bTYycVNY?=
 =?iso-2022-jp?B?djVYcnhFYlFSUXpldUtrZFpUWXJ1NllFQlhpUktBTVlpeTBCUGJZTXd5?=
 =?iso-2022-jp?B?NnFjbDJQSGVNS3JwWUZWWnZpSTVtY2hPMnNPLzZUcXZpSlJZeE13bkhQ?=
 =?iso-2022-jp?B?WWh1aEhpK09mRGdZOTBhaS9ub2tzL1FHS3l5QU50RExJK2Jad2d0eEZt?=
 =?iso-2022-jp?B?Wm9yc1RFNXJCWnRpRzFISnJxTmQ1ZHFsMzBrQWo5L0x1MHM1c2xtZmlJ?=
 =?iso-2022-jp?B?SDJuVHkyTFJiWnZzaVdYYWZwSnNxNjBOZHoxWnEvTTVYdGdEY1k1V1px?=
 =?iso-2022-jp?B?VlAzaTVKaytVTDZpQWJkVDFUN0hKQ2h2U3BTU3lUSllReFI3T01VT1g4?=
 =?iso-2022-jp?B?WElqSkl6VVdZWUlrY1FqZ2ZVbDdUbmhQeWVqRTRObU95dk5ud2xCKzBy?=
 =?iso-2022-jp?B?NjNEbWlXSDVJNnJRWDg4dVNaaUtaUnFsekU3eHpoMis2Mk5aa2phWmlZ?=
 =?iso-2022-jp?B?TGFud3FPZ0R4VnpiRmVSWjNBRVo2Z3JQRm5pOTF5TU1NdlpUbW1iRDZo?=
 =?iso-2022-jp?B?b3dRMDVPWjFpMWp0Sk9xbkFxdGtrc25XU21QZ2hvajE1VGNLU2NHejBr?=
 =?iso-2022-jp?B?NklxUFA4Wnd3Y1RxSERBeGRkaURGK2JNMGFINjB4Y2tCU2kwUU51OW4y?=
 =?iso-2022-jp?B?L2R4VDRVVnNQRmNkdmNod0l4TVJYZTZ1SktMN0NULytMSlQ0dzQ0K1k4?=
 =?iso-2022-jp?B?dVYzckFFaVlWTVBaNk1uVVRGOXVlTkpSNzBzUDdoUTJPeUlWT3BRQWpt?=
 =?iso-2022-jp?B?MDQySVBMY1pOcEs5cU9xR3JzZHlRQXhCUklYdmdhdDFYSGFrUUlLYnNk?=
 =?iso-2022-jp?B?MzhrQ3c3d0d6TThwdUhEK0VuWEl5RFkzc1JoYzBBWG9MQ1RBWW5rT1Mv?=
 =?iso-2022-jp?B?NWhKOVlUNzcwOEwwb3liTXdGM2J1dE82dk5MWDRBaUZuWEpDamNmUHlC?=
 =?iso-2022-jp?B?VkZNV3l6RVhxOU5UK3ZNK2hIQWxBOEJCamlQNzhEbHh5WGRhcDZPUGVr?=
 =?iso-2022-jp?B?QWpFZWpMYkpnV0NXTGZHMFl6Z29FK0d4dnlTUHJ2QW5GaHVBMVA2R3FS?=
 =?iso-2022-jp?B?Z2pqbHlWMTdZVlQxYU5PcjI4eDFWMzl2cm05WVhBc3FoYUgyZEdxWTJO?=
 =?iso-2022-jp?B?bE44TFlhQ0ltM01Sby80ZDlTdG84RDY3cXBKa3NoRzUzTDBlN3FsdzRJ?=
 =?iso-2022-jp?B?UnZYTE52dFh2Y2ZrNS8yYzQwdHNoQUZvYkt2ay82MXd3Sk9PdjRucDhq?=
 =?iso-2022-jp?B?NENUSnZUMU9jQzB1REJZdDZOdTZwU3c1c1lES2VOQkNPclUxTXFQMGsz?=
 =?iso-2022-jp?B?Nk5jYW1tZzQ2V0U4T3Zjb21WT1g2anFzQ1J3S1Z0SzFYVi9XcVZIY3J2?=
 =?iso-2022-jp?B?RTdhVWxtYk9TcDNSbFUxM0tMOXpPVHk0bGQwNmhNaWtGN0pQQzl2N3k0?=
 =?iso-2022-jp?B?T0FmaGRrVkRudEdHcDluRjZzb05UckhYMXRmUWJBMXJFbXBoNHFtOTZi?=
 =?iso-2022-jp?B?VDRUWU51R0dHQ2R2Ny9uL3BOUVU0cksvMWhaeGRVU1RvU0d4K3FFbjlR?=
 =?iso-2022-jp?B?YnJjNWRwdmw1SE5LT0RRT3J1TG92aEl1VTZhcW9na2dnRjI4MXhIaE1M?=
 =?iso-2022-jp?B?WHpDN2RWTmVqSVlSNWpnV0xGTjkydUtvWWN1ZnBXVGZmVGNGNHcvSG12?=
 =?iso-2022-jp?B?WkFuTTZhTGNEeUtLaFg3RUlWY3ZjZGlBY2x5VXFKbUhQbUs1bkhCMFJ5?=
 =?iso-2022-jp?B?eVJYL3ROSm1BSHUxTEFtUTRCMFR3OWYwRjQ0OGZxVGRwM0Y3QzViNjlr?=
 =?iso-2022-jp?B?OWRVbUdMUUR6UnpPbUVHUnRqMHFtN2NDWGE1WnNwSkM1VEtkT3YyY2JV?=
 =?iso-2022-jp?B?NEE0UForYzZvQngwcHF6TllHV2Y5N2Uydkw1WjJkT0F6bmtSbjhJNmdY?=
 =?iso-2022-jp?B?cnRpVHJ6WT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fEC7WrWt0l/ZJ20w8JstbTUzmv3M8MOPyqhYX5rnochqSwJmRNdNmiMJXclziBiu9uA4Nla1I7lB/Xje0L+wo17q1kPQITFXaDYthX8PoVp1E4eCzfZ0YO9Im8q3zQa/0NjQwvX99LvnJgOwDfUx0IMIlXCoklk9TM6pE+OJYbbCDzUoL2Lg8H4eQ65JVSyV2B1gwLHAVLQhKS0d5Y9zablE4Xdv7RWM1rK2zYtIZKOyPLBGQVb382bV5dtQFyJ0e/Edhvl2vdzEQLrAd4XjjkGJgI/qdKotjSTpYe57JHeIcBdQAtGp27ttf11cjypT7JIuUG6zXGvX3KJqJvQi8w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dc84ca-f4ff-4e17-1fc5-08df0a2280ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 01:19:01.8745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9qylDxcDOY0hm7GU9xi+fC0I6Mn98kM+/Ire2vbSnc1/5RBgWA5XuYekCJoInTr1aBVl8sNB07A0iB+legZYdOwMxzEKNX+FHZh5p8ePFLIe8ZJ0CML4jGeESv7I644
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10500
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Sep 2026 01:19:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24093

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Friday, September 4, 2026 4:31 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ICU error and softwar=
e
> interrupt support for RZ/V2H and RZ/V2N
>=20
> hi!
>=20
> > This series adds support for error and software interrupts in the ICU
> > driver for the Renesas RZ/V2H and RZ/V2N SoCs.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> Thank you, applied.

# I am replying to this email for the record.
This and the patch series for 6.1.y-cip have already been incorporated, and=
 I have reviewed them.
Looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


