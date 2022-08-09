Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DFC25B06
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 08:51:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.9478.1660035065624637635
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Aug 2022 01:51:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2798otAx020109;
 Tue, 9 Aug 2022 17:50:55 +0900
X-Iguazu-Qid: 2wHHRQlOhSxxf6nBir
X-Iguazu-QSIG: v=2; s=0; t=1660035055; q=2wHHRQlOhSxxf6nBir;
 m=9h0IAbT8OZ8H2E0vDW4TQXQZcRJYABnUNBNcFaHMHh4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 2798oqaM017646
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 Aug 2022 17:50:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m73V/Xe2as3YCZLbHqUt9n68D1MApDDEOhxdCnKBsS3i7K1XNxTyRfz+w+PaacO0TBhADFYdx0CW5dDY8bpc8m0E43Ra9c8Kk5sd/VfMv5qApOmPqF7KWT5ogWH4skM+YS+FuFAhlgVs0m42lB0/TH6wS0ZsPSe9LHW1CoA8c+u1BAvW376OiEW6LJovLatZxYaWkm+vk69H5zEZEN4Z8mopqL9OUe9kgflOPW0II3V5S89/QfpeX+Mz7nPKLLh9Pdu6mKGbDfn2QgYmhLMt4IOfuX4NuE1OP1Mdh7o026OfwBzcjtHrDq8Z6Bh20jU2ooX4CTarw2WLTrImF6L5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rVv4fwVNtt4CHtI3efxU1+DjHcY6tUJ8J+SssCIXVo=;
 b=jmL4iqyRKCeHyJyr0DQa/T+PmKLy757owAb0mmUU2omJXznYjB/lUTJEfa9SgAMnk7+IsRiweSrWNWWK6HoLrCglYoGLgN9yWPjlgSug3vJD0+rMmw2bnwe4UpPuk6Sk5TmT+NwFWVIH5yW2wB6lvf8FU3JuN3KAsVPAA1jspofeMTYo1CRnxWCqaj06uIrvztznPvB6C+ebi+vHCBHQ1bbbsSiHpqO9635wtVrPRS/ojvmcMFmZCR0qnlDYEmaDuGjtz9ap7PynligFivFT2DMv2r06cYUW8CgYq9XFttvI3JixLqk2MZwFdd8kKIY3E2lTMeDpbFntL1WPu31/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v5.10.y-cip] ARM: 9093/1: drivers: firmwapsci: Register
 with kernel restart handler
Thread-Topic: [PATCH v5.10.y-cip] ARM: 9093/1: drivers: firmwapsci: Register
 with kernel restart handler
Thread-Index: AQHYqA5ds2NhLh2edEezrLx4LGdb/K2mSf1A
Date: Tue, 9 Aug 2022 08:50:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94203AF29FD29AB7C206727D92629@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220804142731.569579-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220804142731.569579-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863f0622-5a15-4341-8847-08da79e4428b
x-ms-traffictypediagnostic: OSAPR01MB3924:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sEgd153bpjNCOgLi+wsXF6/PEOWJihUBNzOzEBw6M7q8wRBMY96RWihpwxngku9rIfxEplUsLE4/imQJK7w4W/eIDH/kl7uCT4mnKBzzlyMaCUbAH+6/GeeJMp5tT/dG3XzA6ma8F6eXOKUHeBg8ww4sBx9kB6YGY6TapQQzDliSR6aAM3Z1sRkuqo7BCQ3yVPVJ4sumB0D91ATco+QEoNdOCQkZrbNCkDT5tPJqkhJmYxxab5BVsV4IYV6qDODN9zPiUWwx+4z7pf9m6tN3SUOrU/pr06fkbWEEzM4fkaTpkeCsW+CClivaMVfErajeNPxf04HlmGaRDMw9GmZt6TqT3JRve5VgGXilIm2RKU7n2K1zt12SG6xKmCgY7Mffc6B4fC/LutwJenEnCZnn1Qu3psyel9p4Oh7gddiRxk1QzUFzq4K80U/KAt3UguJIVJ45rYm3MpggCveGu6TfNHC+2V8i5wLT6846/MhpAId6Xl9d8z5qgfTm8oU1OF+aDTrTZiglL5Fu8AFzbOMbnD3bq5KHOrWGyIRRR6zicACKQDO4CUtYL0PLlYiuRxC9AtAYGecolHGxAB2V2YiOpnwEXg0T3RvNI34+Vgd7Lycih+8ACBcPWXV1noeSrnWvNwrJQP/8pYwGy/vSCE0Btc5kxuv7CZlNjtFzqDoFHhXm+5/XgYx5Q+hJjGG5ohw39ihgcIDTtg4NGfwoYz2JIhzHpyVYT/gBEOGic2gon7LUIA1Qs99blMTmSq2G6SjrqihbYtZ4RWjZAlhwqMiOgUwsOjAPtXJkW/2x6V29fhy49B/Wf0ESXGfcSNwMGgEzKvV4NXKr4WRtf0OwqzgENQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(38070700005)(71200400001)(478600001)(86362001)(966005)(316002)(54906003)(110136005)(66476007)(66446008)(4326008)(76116006)(66556008)(66946007)(64756008)(186003)(83380400001)(6506007)(7696005)(5660300002)(41300700001)(53546011)(122000001)(38100700002)(55236004)(9686003)(8676002)(26005)(2906002)(55016003)(33656002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q3FEemZyRnVhL3dJbDc0MklCdjZETXdlSGZDVytNYVlHb1A0M1pCaTRp?=
 =?iso-2022-jp?B?STRjekxJcjNvS29QUzFyNXU1dDNyMVhLWUdTSHVGZW9zNUhxRkhiVDFD?=
 =?iso-2022-jp?B?WUMyZ1FlcGoxMktsMnRyS2s2dUJ5djltTWVJb3orN3MxM0NGc1RFbDBq?=
 =?iso-2022-jp?B?bGhTWFJKdm5rZlpoc1U4MFJ4SDhhc3ptUEdlS0NuaCszcW0yR1NiMEQw?=
 =?iso-2022-jp?B?Z3BDazFMSis3M00wUitsS2VCbXh3dDRhSG5sMXdncnZnb0tWb28xRGN2?=
 =?iso-2022-jp?B?bDlQNWR3d2NZZVZUckp4dG11SGNlNkI1V2ZTUFlJLysvZlA4dFRFcmkv?=
 =?iso-2022-jp?B?cWdyUGkzeHpZS1gyOHpOM1pEQTA1QjliR3JkbDBzT0J6VnlDUHJZQzlj?=
 =?iso-2022-jp?B?eEVJZFZNV2NEQUpadi83a1VGdDl6ZXVkYUYvQ0F2aWlYbVg5M01tTit1?=
 =?iso-2022-jp?B?VlRYRUVVdy9ERWsxUVVLYXRuS0pYd05aWFhtZnEzSklHYUN0Nml4TjZN?=
 =?iso-2022-jp?B?ZnFqRlIzTCtsOEczMzJwczZUOFJsMXQ1TFdiTDlTWThMa0wwajd5ZWtz?=
 =?iso-2022-jp?B?MDk4dWJPK2d1UTFHbWVGUS90TGZZTVZDZmVmdUlGR2J6YkxvUzJ4V05S?=
 =?iso-2022-jp?B?OEo5YUJ4T1kwMjRqZE9xU0dSclk5QXpGK2s1NFZ5clpENXZRbjBQd1Ev?=
 =?iso-2022-jp?B?ZlNKZkV6V2ZFanlpWG5OYXU4OHNlRnF6VXdLT0Q3Njd4a3UzSFc5aEh4?=
 =?iso-2022-jp?B?MU5TT1lTRGdtVTJ1UE9BQlNTa0NqK2dFOU41ZkFmTUR6RUhvU2RCdXlw?=
 =?iso-2022-jp?B?eDBOOHQxdU9GUkdhQzg2emtXTXd4VnptalkwcDJyeGMvUy9qOUlKMElz?=
 =?iso-2022-jp?B?ait5WGxIZWx1bW13R2xhRkd3dXp5cWVyOVhNNnFXaFZPeVN5STlRWm1z?=
 =?iso-2022-jp?B?em1FQ2VXSHpkQzgxSXVGRGw4TGd6Tm9VQXRKZ3VTbFVKQjRIZ1BRbnNW?=
 =?iso-2022-jp?B?YnZhRVYzeW5UenB1UXhZSWt0SXNwRnZsa3ZhbEpUMVluUE91TzlNQ1FL?=
 =?iso-2022-jp?B?RzlxWkhVRUZZRTRLNVg5WGVzMVRKeENrVXd4d3V3Mk1WRGJGUnQrYXBa?=
 =?iso-2022-jp?B?V3FBK3BrMkp4ZDBWc1pWUTNobENibWYyUk4vQXVJK1RuUldYUzJKODRF?=
 =?iso-2022-jp?B?eURiS29VSGhOaDdTVHVPZ1pYczdWT0ZVcE5abzRUVzdZWURJZmt2VGNJ?=
 =?iso-2022-jp?B?ZytJaS9ONW1hb2xWT3BvRGc1R3h4WW0zUnpQZHFzbTdHMmQwaEJibVR5?=
 =?iso-2022-jp?B?WVhiRHFTcXhIRFYyM1hheVJuc1ZPVUlxdUFobHgrZFFiU2FkZ3plZWd2?=
 =?iso-2022-jp?B?ZGIwaGZGeURaTzVRVG1Cc2I5TjRENEFFRmdlWHY3RHZ2V1FzcVRPbUJi?=
 =?iso-2022-jp?B?L0dvQlZyR3lRQlJTMkEvU0srcGtoN3dHRzIzbThDeHhpN0cwRnFWOS9Y?=
 =?iso-2022-jp?B?L1BuTDg3Nkt5YVNLRTJFRXo3U0dVRnRuMHV3Tnc2b3BYQ3Z4WlllRThw?=
 =?iso-2022-jp?B?N3hFU1pZRUVTTHJ2WXFWMmFDeVNYcHNHRlN0OTNQc2xhcVg0dWhKWFlt?=
 =?iso-2022-jp?B?aEFCbDR6aUhkKzNnWmVjanFLTnlYN2kvbVR0ZnBMUmZRSjdYbzJtZDEx?=
 =?iso-2022-jp?B?NTZEbWVxQjgvV1Vrc0JCRHM5UW5aY09OM2pORlRFT1pEbFJTTlJVWWln?=
 =?iso-2022-jp?B?alpTaGROVXc4aWFpVHhxYXo5b0loQVZoVmcwUTI5WHBjT2hDZ05LbnFT?=
 =?iso-2022-jp?B?bDVwZURHRkJEZWpOUEp4TDNFVWlSVVB2eitDcnFrMm02blJHc01KY0dh?=
 =?iso-2022-jp?B?TXpnbzR1cVFZUC9aWEdTcnNXVTNoYkJmR3pwQmVRNUl6NDI4N1o3aWRO?=
 =?iso-2022-jp?B?S24zMFFCZjhudkI3OVZXQjdWWm5iNHhPZFpTaXVnRW5hSjNPVkxVYjNn?=
 =?iso-2022-jp?B?WjVzNVBUYWh6WkxOa3FmOXc2NElHZ2pJOVFmZ0hCeCs2akZxV1Q3RUty?=
 =?iso-2022-jp?B?M0FvVjhGaG45WGtnRk9ibDVydXZ6SWplVkEyQWt3TUo2enpRNmNjQktY?=
 =?iso-2022-jp?B?ay9IZXNLeTZIc1kvenJEUmVLcmpDWEV5MWMxc0NlaHc1bEVWSHM1MzdW?=
 =?iso-2022-jp?B?eXg5MFFSWDJYODRtRExiRkxEVEQ1cGJXbDR3eVErZHdMWThpeWtLVWpr?=
 =?iso-2022-jp?B?ZjVHcUNXQkdROUFwZEFZaGVpUGxPMzB4R3dxQzFLVFBSaGttTGZELzdY?=
 =?iso-2022-jp?B?THQ0VEVPRXk4dFRKNERXYkM0K0I1UTdjR0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 863f0622-5a15-4341-8847-08da79e4428b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 08:50:50.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 q+I9d4gYkwqHsjk2CpSVQtqZq2nV+b2GiWelRNf/ifBNKMm2zfhxd7wgnyp//mCd30jPJ1UXKgkJ6zC4Xxe6gpKgHp03fLX5XgNWyyslPqZGIF0BeFROOC7bMA8l/L/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3924
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 08:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9141

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, August 4, 2022 11:28 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH v5.10.y-cip] ARM: 9093/1: drivers: firmwapsci: Register w=
ith
> kernel restart handler
>=20
> From: Guenter Roeck <linux@roeck-us.net>
>=20
> commit 2bb565bbdc0358b6042e3076416c4ba32bd56bfc upstream.
>=20
> Register with kernel restart handler instead of setting arm_pm_restart di=
rectly.
> This enables support for replacing the PSCI restart handler with a differ=
ent
> handler if necessary for a specific board.
>=20
> Select a priority of 129 to indicate a higher than default priority, but =
keep it as
> low as possible since PSCI reset is known to fail on some boards.
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> Currently reboot command is taking 60sec(default wdt timeout) to reboot t=
he
> system on RZ/{G2L,G2LC} platform, due to [1]
>=20
> [1]
> https://elixir.bootlin.com/linux/v5.10.135/source/arch/arm64/kernel/proce=
ss
> .c#L203
>=20
> This patch allows to call watchdog_restart_notifier and it restart the sy=
stem
> immediately.

Applied, thanks.

Best regards,
  Nobuhiro


