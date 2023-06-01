Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EEEC77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 08:48:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.26087.1685609304061766476
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 01:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 3518mFi6007879; Thu, 1 Jun 2023 17:48:15 +0900
X-Iguazu-Qid: 34trpHMSn1seALBLOj
X-Iguazu-QSIG: v=2; s=0; t=1685609294; q=34trpHMSn1seALBLOj; m=nFQhT6yT2wYWbz7YHC0E3jB0H2pv89nJt1ohBRF9Wt4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 3518mDli036693
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 17:48:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arIvskvvjtcIokqXyipkB+wcCAS7dpfe+sBFCRnrGxRoSVE0zutIXjAqsZ7VXMHjeT9EXdyh47HH8/coeupnYUA/74n5cUMHXsrAPsspY7g2luSTP/m82NGxwqVAJoWBwk89YJyuxhXji1Uk6VltuPX/+u8kMRNDJaHADTwncCOW4YbDWMrUcbQ4TK0pmEHty1iKiDCdKJ6dpM+3/CjNwmAxtIav8ATmYFFnNEMAQ3VsaGF/m1i55A37tFxES+ATGF1J4P62rK0pBSdo4NQBuKoaFCLOsMRurX8GLG5qZNvg4sQ3mN89SK7TJ3TDM6Z2HWhFkjrzEha7wy8yWYrX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22nwGipZmBtDkpwCzvpiDsfK6cXYBzr/WIxrXJI50Yw=;
 b=QbhfOkLh9mLlxDeucYlVNTvtkZfvLr2jX4aJqSqxjpGRodncyQGaYeSZ9hSEg5quOSkkHBBNF9MtUfVS70mX8S8vDl7HsFZrxhLU/Tq/mPHaMTDaURibZOadMjaX8cdzpPT+RMck1+XMKh+hnkN4pkxS3GTYFbu7BMM7GdfKay1vSqiERo3Hs6PI2HAG3wY8qR1Ayk/akGuHPW8ZD5bhUdlkNfZzAOFL2Xql1Z5fQi/jai6K53Cv6gHj1uTDLa4dk9aztN3T2X4Xa3u2R8lJCXPK0UYCIA/MWMNYFTMWSDU8MVWwH4LEVk90XWfkn6BMiD/4WESjP5LJ3wvJXUhaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <ch@denx.de>
Subject: RE: [cip-dev] [cip-kernel-config][PATCH 1/2] 4.19.y-cip/x86: add
 Siemens IPC127e defconfig
Thread-Topic: [cip-dev] [cip-kernel-config][PATCH 1/2] 4.19.y-cip/x86: add
 Siemens IPC127e defconfig
Thread-Index: AQHZjhmvcghhcvUPVkaPt5YdJdz+E691rxfA
Date: Thu, 1 Jun 2023 08:48:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB94184897E0D84E0A95FA00F792499@TYCPR01MB9418.jpnprd01.prod.outlook.com>
References: <20230524082725.41558-1-ch@denx.de>
 <20230524082725.41558-2-ch@denx.de>
In-Reply-To: <20230524082725.41558-2-ch@denx.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|OS7PR01MB12082:EE_
x-ms-office365-filtering-correlation-id: 9d00fae2-6774-4067-2627-08db627cedfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zBlvk8LZj62/kAPnAOxx7IBA1j73/zh7E8A2w71MaEyLlwyKcpjy3F437R2LVlf5EkCsMQx6dlnXFUKtxBPCM1UB8EpLQqEBd//tRliZsn+PvEl/v+YJWMKNrababr1+HeFmes8d71+hiWjsYQlmA640hQZAu7wnDieWMLwYBPsLglKrpUDHqV8ge9pY5SaloDM8HcfmLe6VqDsgC5+oFm3AfvgdLaQ/MTqQ67+JI8R82CZH7qhd/iZxTALEgbGZ2noT1p/q7lhNib4vftLBxFNOjy4BGFtSySH1Mxkg7GwRdgPF5I8vivntaZnKy+SMX505GuSMDDuBtPjHsxGwpFvrtU9px9lY4z8zZXqLcU+eUx1sjjktfLUd7GHXAnyhouyzpLItUqvw8drurnGnOiVAUJHENJqgmt5rGDDBHdYQE3utwUhqxNEpRdAGjgLdASnKrrrVdoZZlCvvPjT2PoZ886FjCRr/ZLMNzKmzwrl6owMdPNYYqtL2HrdpOaitH4r12C0eqPA04tuHsDTKZcZb6VapPhBkqtH+frTsllbD/eGW7Up/+S44KERvHT4hTcGCMGfBBoppqhhTdRW61Ciq1GRiZRR2imAaCjJynvZ+qUqZGFQl8SrjtQI19JhpxduxacShQ1YBPNs4XYOACg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(53546011)(52536014)(6506007)(9686003)(26005)(6916009)(66946007)(76116006)(64756008)(66446008)(66556008)(66476007)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(33656002)(83380400001)(86362001)(41300700001)(55016003)(316002)(7696005)(71200400001)(186003)(2906002)(4744005)(478600001)(38070700005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SHA4Y24xTSt2QU4rTVkwQzBVelhyZFFjZ0NUc0hyUEN2V05kNTJpLzVi?=
 =?iso-2022-jp?B?MUxjS21Nb2NlK3QrNVdxeERtZmpUUEhkRTl4WUZQZllaNnRET3Nyc1gx?=
 =?iso-2022-jp?B?enVnVTY3QjBabzVqOWRMU21GeWNPTk1YdUpEbDBoY0NDclJhbTJhREh0?=
 =?iso-2022-jp?B?TjhSTTVNajc4aFBOYmR1ZFQva0tSY3pOeFNJV0xaTmRPdXRLMzhiQ2E0?=
 =?iso-2022-jp?B?NCt2Ykl1SlQ2eVg3cGJvUkFRTVRSTlFpSk12NmhYMHpmTHQ3b1hJelZI?=
 =?iso-2022-jp?B?SDNDRVBKcFdnTTJJMDBNbk5xOS9wTXUyUEsrYUQ3TmFNSVYxN0F4eUJl?=
 =?iso-2022-jp?B?c2RjWlJQR2xaMEhGbTdneEswSVgrdjRzd2p0RXMxN21jUCtTQm51cnFQ?=
 =?iso-2022-jp?B?SGZXWDZoazZLQXZiTzVqNVluSVZhMzdMdGpESHBtTlF3RmRwN0RXYnZ2?=
 =?iso-2022-jp?B?UFpDUndOR3JiT1FzcjAvRkZXdGg0OHFRTVF4SWF5UHNyTlllYXVjRUpm?=
 =?iso-2022-jp?B?dkNHamNpV0xIcURsTm04a1JOV1FkZ3JCRXN2dXVyVy83aWIwaDliaWho?=
 =?iso-2022-jp?B?UFhXWlRuSHhWZExLSFJFNXdYZ29IdGRZcUUyVnJoc2JDYXBqQnZleWN5?=
 =?iso-2022-jp?B?cTliQndIWGtUQloxckd6WFE0OXk3QmpDeGpKZzA5L0xEaFhnUmxSd1pO?=
 =?iso-2022-jp?B?cTZRYkpDVEpOOEVSRHZ6aFR0TUxIS044c3BFZWwwSTBKUDdBcWkwNU50?=
 =?iso-2022-jp?B?bjJUZmlxM2xzU0dIbUpaTlBEZ1NsdnN2c3VqaFhUS0pKbFdpWXY5SU9O?=
 =?iso-2022-jp?B?VCs1N0VTNitsOFhIT3I0Y1d1TTZDT2owcVJ0UWwzRVRTSnNZd0EwVG4x?=
 =?iso-2022-jp?B?b0UvL2tRYk95YWM4Q2xTQkZmajRwMFNxelZXbXoxNFlhcWR6NWVDSEsw?=
 =?iso-2022-jp?B?bTZSNWdtTXVVdUp2MVhERmZNeTZDM1VPaFY1cHZVNy83VnBRc1RYbTdr?=
 =?iso-2022-jp?B?ZWZscUpaQkRzVEVYNG9vQTlKNDZuN0JqMlh0OXh0OWdoWjBsblJtd3Ro?=
 =?iso-2022-jp?B?THROaDB1MGJrZzZsNCtCWU0zVHFGK004VGJrUkNLM0I3TFl6VEMwU1JY?=
 =?iso-2022-jp?B?RTg4MkZQZEdCVkRJL1FEc01oK0ZUa2NDRFN3eUpXZG5MTWQ0SUpqK2lB?=
 =?iso-2022-jp?B?bnM4a1Fqc0tBZGovMDYwbi9ia1cwSUJERjhvMWtvWWdtL2pKZVlVeDk3?=
 =?iso-2022-jp?B?eGJaT2pJV1l0cXdzUnNPWVdvK1lsS1ZQMkVqalFXQ2lNbkh5RGFkOEc5?=
 =?iso-2022-jp?B?d3FJRlpueWxkb240YXlMTGp4Qi9FQjFnNlRoblgwemZNK3FNL3gyWWUy?=
 =?iso-2022-jp?B?Mks2Y1A4R0FHU0tVNk1LUzdRdTlrbHhyczZUOGw3SmovSkVGcW9BdThY?=
 =?iso-2022-jp?B?L0ZpMnFZRGRGcHNlYlZUMmJKUXlJNWppelU4anVkK0xtNC9aMXk4QWlz?=
 =?iso-2022-jp?B?eHZ0RDdNenRhVnRiUytlVFNqaDRzOWlHZnhwaXNZajRyR0dIekZxU1B0?=
 =?iso-2022-jp?B?akZrWC9UMEh1Q2VEQThlWkpzdU9hWjZUamJKMVphdnJVbXBMRWNUV3Yv?=
 =?iso-2022-jp?B?NFVFN081NVFXeWRQSllNcjB5cjBPTzlJbGFwL0xPbmlVeng1aHFLdWhh?=
 =?iso-2022-jp?B?ZXZMMXZTVHdxY0xGbjlJQlZoL0Y3UXJEVFNjWlpmYWFaa3o1OEtZVm1h?=
 =?iso-2022-jp?B?cElXMW4rWERtMjdYMVNCVmpjczhPMk1uRkNFdGJJcDZCeHEyNytHY0Zh?=
 =?iso-2022-jp?B?RVpITnJxbktlUTZiLy9GUEc0cngxcTY4UWpuNnJ6U0o5L0lDY3FGWU9F?=
 =?iso-2022-jp?B?K2tmTVRnUkVNdE1NZTJvdzRzU3djaFdwZXREcWVoSnJaL0pRMTVpdENL?=
 =?iso-2022-jp?B?cTE0SmhIRU5zY2lnYWlTc2ZJVk8wK3ZvL25nNWIvQkdlLzNjSTIyNzA1?=
 =?iso-2022-jp?B?bjVxdkFnOW5TNGNPNmo5SFExTTR5cm9VZHl6YkNsWVViWlM1cWpkS0xI?=
 =?iso-2022-jp?B?RW5sYklaanJ2dnZ6ZlpBODZLUjkraFA5QVFyOC8wMmIxa1RpQUtuMHIx?=
 =?iso-2022-jp?B?ZGh3bFZiZzhka05aank3Q2ovYmNONjViR014U3pPRFRzU2Q0dXo4bGgv?=
 =?iso-2022-jp?B?VEo1eE1FSG1PWHFyRW03TzU5VVBuaTgrZ2g0K0tXdWdqOUFEb0hmK2FO?=
 =?iso-2022-jp?B?VnBGdFdiTlZPc2NzY1Y2bTM5cXY0QXVlMHpPVzByWmsraW1EZ1RYT3Rn?=
 =?iso-2022-jp?B?SWs1SEp2RVM3TllGL2lsS3RqRDdzOTdhSkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QN3bZngudoh8JNGq2+WGS1kbVFH1nvr7u5evP6e+5tLvG+E6A88+cUvX8nsmLIQvTlq5oiK5SUystXZ9t2Fo4yhaUQPhg9+1h9maDwAv+doVxDgptnO8zY6AmS9SLoOf9Swaz93ez1cB6zBqRoD7YogimMFLYGCtHiiu5wAMRComdMnTVZtBGd3+aGGe1LIg8CjsU7m2UysJ/M0zigyVp8wC4OvWWB2BNHgt9YttwNlcqNQyLRcypoFS/SM0H1CzZeNQHwa+I23E+rPVOD95aOhhWN1loeUsJktXTbI35ScICTXUsItTBW/bgIgRDU8CTMZQDOUMZDfC7vMoZgm6QtxsfqdiVGwMHOH/97g42F3aFwZBluK9IW5GoZ4kAzGSooSk5NFn4EUa0FqKR7FmXelGDo32eJY6C3jWdDCj8zdB5JYfIq9EOhVLlzwKjOTA/TdIUYAvYYMW8nJBqIe9g9gct1xeFb4VRt7D04W9K8bKl1A85f7s15V+mvn0Rpc44RmHfIXm4hXYZaoyMUIKGNVwH2qX4i+QlS9LDIAUZC43w/cGyr0YISaTscgYE5PP4i1LsABBnFrv2xgyV7jSuBL/CQ4lyFkMLtD3PGAPeiakgaHua3O48IHfwFitLsX1zKo1DhXDX5rzYzPK+gOii+aebrjQL1lHuDuQB7N3YxX2bk8qB1TYIw9NVtALDKEwVMrNAQ0c4lNc8IWWD30uZMo54SaAECM3+ey1vbbh2DirPMVKazmHYErRlQ6rH6w1aBJewe72keHSvArtLWoHCmxnoplmKLRviSEYE2g/cB3m1L0ePGBEhuQ7M039nISkmmjOgflkjXbXTx4zI8DBTg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d00fae2-6774-4067-2627-08db627cedfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 08:48:11.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvLWML4JHzRP0gHm7lsa7EKzHS9/acrvG4eRzMAv2siLASSq5ZewjLT5M0atIQiE49Cu2ABUshqZsqvHlXeUTqY/DI5rGCVOAcXaoWatlaH7VRHA4KErEomNRy5QLHfO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 08:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11721

Hi Claudius,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Claudius Heine
> Sent: Wednesday, May 24, 2023 5:27 PM
> To: cip-dev@lists.cip-project.org
> Cc: Claudius Heine <ch@denx.de>
> Subject: [cip-dev] [cip-kernel-config][PATCH 1/2] 4.19.y-cip/x86: add
> Siemens IPC127e defconfig
>=20
> This is a copy of the IPC227e defconfig, just `CONFIG_WDAT_WDT=3Dm` added
> for watchdog support on that platform.
>=20
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  4.19.y-cip/x86/siemens_ipc127e.sources   | 9135
> ++++++++++++++++++++++
>  4.19.y-cip/x86/siemens_ipc127e_defconfig |  456 ++
>  2 files changed, 9591 insertions(+)
>  create mode 100644 4.19.y-cip/x86/siemens_ipc127e.sources
>  create mode 100644 4.19.y-cip/x86/siemens_ipc127e_defconfig

Applied, thanks.

Best regards,
  Nobuhiro




