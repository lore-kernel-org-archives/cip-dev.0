Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77197D49221
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 13:25:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.40178.1731936309679181629
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Nov 2024 05:25:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=rIxd73ks;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1731936307;x=1733145907;bh=PWoNL0pUXcpv/e7DdvIPP0OEWiFYsXvJMJhg2ST
	ZBDI=;b=rIxd73ksnkoh0ojBpicZ8KSOqMGqBIyrU7xD+8zy9vJ/0DrvhPOZxiCqeQrH90o8dT/9c
	bklUqXeI+lxzvcjcMN2potH5lsArIv9omjVeavH/gXCse+sOLj7zJ4cMZmYHNwET+yNSfMO0witNk
	74PPTvyTLhUztDT3A9HHpNxJwHNCSGyI0ilfksg+BNNcbp4QIMZ/8bMuFOQbr2Z3kU5Rbb0f5HcPS
	tUkjJjA8H/nrQ/vmVbkQkj07nVHEHYiYx2Zhst7OPMD8OIvaoXF8xJFxvtwLMR136KnwYYd88UpEg
	a2DQIcQ7Osql+LnmVo6OaGBjd7wEDxjydbWgKtHdYg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4AIDP7112267022; Mon, 18 Nov 2024 22:25:07 +0900
X-Iguazu-Qid: 2yAbJ1jgy0PdWfmvuz
X-Iguazu-QSIG: v=2; s=0; t=1731936306; q=2yAbJ1jgy0PdWfmvuz; m=YcTmMSfuwCacxq62JcQMrIkWp5aCsWiPCKOml0fiZjQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4AIDP62N2861887
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 22:25:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrGOFbLPzO34k+LVvNi/lTCCo5oipB41+MjpyMD/Ci5xJgafVnkHqdxMThqt+X+uWQlk4t/wiS/eHLQDQsreo8ZODcOxnbXMczg50lhevxDOic+eaMmJSmqGSKncAFnfWOMMHm7kepBousPpZ6v07Xp3gBfDS5K4Bgja4sOe4nzf/E/UUNNU8u52CG8jZz2oNHqoHPL11Z71NvPEsaENjWINkQ/kkfcAxpm54HjGrb/jSTC9wLTN4PW4XTXWTYwR6XKgiPPr0sJVg6rI4Mcb6di4ySPWLqw9OThtlLMSQfUsrqmfxVa/sqh4KkhcTlKRt5KCcDDAdo/7zk/lF474hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lQCYmyQG1MgcTtPC+VXww/yk/fSxMjdhpZK0dxS5v8=;
 b=QR4CiyzmclDtnOjp1in5S5o1vCzujXQ4MUSRiFuYEqFAZ56iQ7FoGc1fZwejVtHjqTF1A3sZxRTzpiF2syl19hX0nCvLNr2x/RlobMHfCl2ZssKcdDbjnIIrmTjwNuWAd0HmcRlmwjnDhBEkyljsV4caE6h7d9bhxcfe6O8fiCXwylLemmE+O3OgW29mopGQeUg8CfUFetLIFQmjSFHMRGB/bmoCJO1LK8gbRvPCZOn18fx2mjYS5VfUnJc8lrZagHkPxmsLb+Z+sUOkuad0IoUtiqTN/DR5QnT3wnF/kMTx4ZtHMYv0F5bx1ya/W70qT0VFenpS4tBEBlx4KHmIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4A==
Date: Mon, 18 Nov 2024 13:25:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
In-Reply-To: <17FF38206FDF8135.11625@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYCPR01MB6061:EE_
x-ms-office365-filtering-correlation-id: 65a18ed5-b01e-46f4-c1be-08dd07d468e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZVZ0YnhOalVhdmRRaTlxYnd6V253Z1J0dlRpcU15L2x0SnZYNGlBRmYx?=
 =?iso-2022-jp?B?Ylc0RFV0TGVXOEx1cnlFVWtwTFdnakdOKzh3TytwL0Q2ZXYwaXdPREdu?=
 =?iso-2022-jp?B?NmZDSERNaHY1cHdNQmJ0eDNPZWVFQWYwQmRjYmZObTJQZ0NZWkVyMnp3?=
 =?iso-2022-jp?B?dm9qZytWZnVqd1F3TTIyMnZFeThZZ2hpVldaVlJCVyt0OGcySmZLWi80?=
 =?iso-2022-jp?B?OSsrcEo3QVpTS1V3RzV0cG93YS9DZWM1SytYdkUrM3pDME04UGJ2Mnd2?=
 =?iso-2022-jp?B?VzhHMkhTU1ZwWHRkQWMzak9CdzdlTHBneTNKaHhITzROaUlPVzY2UjQ5?=
 =?iso-2022-jp?B?SmJTNTlPV3IzajN6dzVERWtPck5UVFgyQXpnUUlBZzhTVllWN2hYS0xq?=
 =?iso-2022-jp?B?R0NwajYwWlBHQnJ1NFNWWWFTSU1SRzlKaVpJenNULzJLNWdzK0hlU3lT?=
 =?iso-2022-jp?B?SHpIZmZJUTJqL3BsenpCSDE5SC8zUGd4WXJwS0ZCeUpTNGpPK2JveTFL?=
 =?iso-2022-jp?B?VGcxdEp6VTZvenR0TzRBYm1PU201VTM0VFlJREZxbTd0WjJ5Y1Rrazgy?=
 =?iso-2022-jp?B?Z3dKVkNOTGZWSFh1UmpvUzNmdGEzSm5lNnEvSmxvTjZiS09XS3BoTUJN?=
 =?iso-2022-jp?B?eU9Gc1JtMFFvc1JieGNXeXdRdkhZbHZjNzQxenNVd3VwWGF4a3VOa1pv?=
 =?iso-2022-jp?B?WkRQSkoxVUZUeFdRRXQ0VC9XdmpVeFJQLzBWWlZMYWYvRWFSbHNHd01W?=
 =?iso-2022-jp?B?VnkvQVpZM2tQREpJTnFVMTNlS2VvVk1wQVU3RjBqSDRhSU1Ed0haeTM4?=
 =?iso-2022-jp?B?ZmdUSmczcEZTSlZ5SkZESzR4eE1Ed2NUOVZTSnZlclRYN25PZE1HOExJ?=
 =?iso-2022-jp?B?VnlrYnpFekFseU1rblRtZE52bWI5d29oWSsrTWxsTzM2RG5vcjloT2w0?=
 =?iso-2022-jp?B?bHRwci8xRUpSMm1tNmZWczhTMU5ZTHo3ektiQjllaWtDc2VJZkpQY1Bl?=
 =?iso-2022-jp?B?Q1l4VEZBVStWUUNweGQ2VGt1ZUNWa2xsMFFUcVZGOFQ1ZEVwRHppWVBm?=
 =?iso-2022-jp?B?WEJlZWFZajJEZW1YOEd1djRoTVkwVlhWYUx3cmYyc29EbVpIYUR3NlFN?=
 =?iso-2022-jp?B?TDUvOUVNT04ycXJpQ1oxcXdsc3dVa2wyUXkxYXpsc3BCak1mZUhIY215?=
 =?iso-2022-jp?B?dDlEUmNpcGdERHE2TXRiU2p3MEVENk84YWlNdHpiNXBSZHFETkNod2ky?=
 =?iso-2022-jp?B?SVp5VnF5aEdyRVNNbmozQ0N6a2lKZ0V6QXlBby84S0RaQ0xCQ2lPTzRz?=
 =?iso-2022-jp?B?RmJFV2RoN3dKQzhheGZtY1N2VnpPYVluMjlNM2xkOVBNYS96M0h1T1dH?=
 =?iso-2022-jp?B?cnBQSUlweFlONEJwb0xDR2JndWxSYTlDWkF2WkJPYlZHcTY5ZjI5ekpl?=
 =?iso-2022-jp?B?OHZqdUNvTk8rTFcySG96NTFYNzFWcWdxNUtPVzkzMmxEcjdtbHZTaW8z?=
 =?iso-2022-jp?B?OWlFeDhhSnIxWVZvbklFR3JYUzVDRjZyNVNvcCtJdGpYSHovRWhaMFp0?=
 =?iso-2022-jp?B?dHhVUkRBWVgvN2h6Rm1IeXVCRWpGblpPNlN4c3pLSU5hVFkzT0tiMDYz?=
 =?iso-2022-jp?B?T21TVzVLcGZ3cVhZQVZISFgyem8vZkZvY21GWG1sd1o1elo1eWFoNG84?=
 =?iso-2022-jp?B?L0prOW1aTW5NaWFFbXlaUis0eDZwZWQ3cXlSeVAwZHRLZCtoL1FCbjA1?=
 =?iso-2022-jp?B?YUgrVzBrT3lrUjRlbGEwSE9oZWg3dTROdnpPeHN5cXpqL3FEeHZMZXRD?=
 =?iso-2022-jp?B?NFVaSG9wSWswVmFvRzM1NGJvc1JPbXp1N1AyVW80Mi96QTM0UG9IMVJp?=
 =?iso-2022-jp?B?citJQVRyZTZHeVBJKy8ybkx5elZ5Q3VXQWZqd0I1SkpmSkduemxjSWxD?=
 =?iso-2022-jp?B?bWo4STFaZHZ1ZE1yenMreEh1ZU5vaEVDTzN2cFIzTWV4eG9kSmhEUkVu?=
 =?iso-2022-jp?B?OD0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eEc2OW54ejZPbmdVTUJYYVFyOURFcExITEdNU2RBNkJqR0VUUjAvZHJE?=
 =?iso-2022-jp?B?c0lZbG9nVjdDb1ovSEwwSkdjcnNxZytDNjBkb1lRYXJVeldsTlV0dll0?=
 =?iso-2022-jp?B?N3MwN3hrY25oaWVXZi8venhaVzFRTFpkNFlGZWNBZDV2Tm1BeEtCdTN2?=
 =?iso-2022-jp?B?blhIdGcxSythcnBmMEhWQ2dIYnl5VzVDdXJHenBTZEsxelJ4bzg1c2dj?=
 =?iso-2022-jp?B?UUh0ZEhTUzVMNFVpWWI0YlNBUjJ6LzdkbHdpWWtaMEtpRTBoanora1JU?=
 =?iso-2022-jp?B?azd6cHVUZUZVNDZCRUVheURqU25MK3BuMExEQ0RETk1xVHhxOE1zQ0Jn?=
 =?iso-2022-jp?B?VWkxQ1l6MWRaZEZ6ZTVrWS82NFVRUjFSem4xUVhacXN6K2RCaktZQldr?=
 =?iso-2022-jp?B?NStsZEFGdWlYVlM2bWFiZjBMZ2Uyd0xlNmwzeXl0NXh3Z3NiR3MyaURt?=
 =?iso-2022-jp?B?NTJMQXFSUUw1d1hsRzFicnhxTHpCc3VVS2RMUHM5VDFZM0U0YTVkb3Jx?=
 =?iso-2022-jp?B?dU5aRURaMnR1VVYvK1JPTmpaMnZCb3p3YU5vZ2x4bUZBbWZBcld4dWFS?=
 =?iso-2022-jp?B?emh5U0doYXRxYU5ISm1ya0V0cFYvUzlkYlkyUGxySmZQM2dmRWdOa2Vz?=
 =?iso-2022-jp?B?N3VqOXdZbUpRMXk3eHpNNUxIR1NBbXliZ21YK1NaRWJvcDR5NzBka0Na?=
 =?iso-2022-jp?B?dmtVc3VrNldpZGpqMDhjbDY0WTZheUtYTGJtUFFyMFVST1JPaGlpajcx?=
 =?iso-2022-jp?B?TDlsWkMxOGtVd1RiQ0V4MWpIZlU4djZwMUpqY1o4ak1KaWkvMDAvczhl?=
 =?iso-2022-jp?B?SXBHU3dxMWRWbGoxei9yTmg2YW1WQzlkSVBMUFhiOWFkS25Rblc4RHpo?=
 =?iso-2022-jp?B?c0NTaFQ5TFZ5NjlKRXVlR0JndUNORUFXWTRmcmFRa21tZzJ6QU1ZSVJD?=
 =?iso-2022-jp?B?dVNrUWdZTDFSU2ptSTIxUGlRb0kvZnZiSXkrMTNZYVRUdWZqdXE1LzBR?=
 =?iso-2022-jp?B?aDk3WjVIUCtWL0ZkNldUOGEySzBNQVpRUDFKRTdWS3l5aEt4OGpSMndC?=
 =?iso-2022-jp?B?SE5NTmVYVU5MdjFtd293ZEhKcUpRU3hmMno0bXFGTWlKVWxNb2x1allX?=
 =?iso-2022-jp?B?cXZzR3F6dGhRU2JjZnFOTGdhL0hSWWxHdCtma0FIZlFwVmNRZ2g0dWJL?=
 =?iso-2022-jp?B?am5UT2Y4MjRGcC9jbk5nUHVISkNVU0N2VEREc0lUNmYzK0tMUFJSOFBG?=
 =?iso-2022-jp?B?cjVVMkFxZjl1NTVxdGhGc3NOUlNWTWRnanB4Y09uRzc0ME1wL1RucTBD?=
 =?iso-2022-jp?B?a2hQTU5hN29YT3ZwZElkaEpVYzFiQUx5NldETjdaMTU5SGJIYTdOZVpm?=
 =?iso-2022-jp?B?ajhiMGZRQzhlSXdwdVhSTEJ1dEVzaHVUcFA5eXQyQUhudHhmUnZiRUts?=
 =?iso-2022-jp?B?V0R2RkM3MnlRUnZrQUFYazNUK3Y4RDNrNmcwVnFrMXFDZjBuUGZscGxD?=
 =?iso-2022-jp?B?ZEkvMEhBVHg2UnQwUFdUREJvcjB6cUR2amVXYm9MMlFmU2QxaUZ2Y2dr?=
 =?iso-2022-jp?B?RUo0NVdxeUdmNVJ4THBzVVhERU8rMTZwd3o5dmNtcjFEbDU2ZUNvMEhO?=
 =?iso-2022-jp?B?VWFPS2xHdzNpU2xQbXcrOThHM0RYMjlPdlpIbHp6SXA4NFpFdDF0dUZZ?=
 =?iso-2022-jp?B?ZUtPWFFqTUVNNEJvV2NVZUI5SDZVbzBubXpzVksxQmVQekZtOGVhS1d3?=
 =?iso-2022-jp?B?R1ZGK0Y5L1dpTHF0SjdwLzdWQ3FGc215VXVvdFJjcE1JZmd1SGhZTFEx?=
 =?iso-2022-jp?B?Z0ZyWlo2bnRVTlRPN253eStjNkpaSFM2WDYzYjloMDNpeWpKYzM0RURK?=
 =?iso-2022-jp?B?QUlMZFZydGE1UFVzbXRDYis5SjVRWjBpWVMweXdCUHRGNW8wUm00bTVu?=
 =?iso-2022-jp?B?U3dtMjF0cjlnVStpaW5QUS8xYS9VVFEreVFIZk51cnJYaGkxZ1FrQkRp?=
 =?iso-2022-jp?B?aUpzeXNySjlUQUZtRUdzMkg5ektWaVdmUGlOMnZHbzZWN08yNTVCQ3hx?=
 =?iso-2022-jp?B?alUyZmpCMlVJd25sSWVLblhlVXFMcWdDOUdtc2xCbmd2U0tWZDh2b3VZ?=
 =?iso-2022-jp?B?a2JXNEZWODU1VGxrK0FMOEpxZHNFRm9OcEtIYkdzYm5BTldtWVhVcWlN?=
 =?iso-2022-jp?B?Vk9IQ2oyRkxUZnZ1VFVGd3NxU3JvMTRFNU40Z1NWV2RvdHNUT0VCQ3pE?=
 =?iso-2022-jp?B?Vms1cE10b3UzT1ZldnZ3azFta0t5VnI0OUlFUXd0T0pody9DM1VSR2ZD?=
 =?iso-2022-jp?B?cHU1UHh2dVRpblA0elNYT1B1WEtSVmZDS2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a18ed5-b01e-46f4-c1be-08dd07d468e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 13:25:03.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwuWfcsBTsGHx7Gfi13e6jHcaoYERWxpPr6gU0IQRuj86g5osxleWoqNomjWUgc++DA+5F6jH+wJ6BmEH7GC60Zs/g40GBUxGjuQ+L+dePyJf1KcHIGMeok/Z+aMIRyR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6061
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Nov 2024 13:25:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17260

Hello Pavel, kernel maintainers,

Based on my additional investigation, I made situation more clear
and came up with an idea to resolve the problem.
I'm glad if you can check the following information and share your opinions=
.

=3D=3D=3D Unallowed situation =3D=3D=3D

In the first email, I mentioned that the problem (i.e. breaking
migrate_disable counter) only occurs when...

* buffered_rmqueue() is called with IRQ disabled
* local_[spin_]lock_irqsave() in buffered_rmqueue() calls schedule() eventu=
ally
  (i.e. cannot get a lock && there is another waiter at least)

Again, my understanding buffered_rmqueue() must not be called with IRQ disa=
bled
because local_[spin_]lock_irqsave() is a per-CPU spinlock_t which does not
disable IRQ/preemption and pin the task to the CPU instead, which can sleep=
.
Also, the (new) kernel document says the memory allocator is fully preempti=
ble
so cannot be invoked from atomic contexts[1].
buffered_rmqueue() with IRQ disabled may violate this.

I'll explain more with this assumption.

=3D=3D=3D Conditions to call slab/page allocations with disable IRQ =3D=3D=
=3D

allocate_slab()@mm/slub.c[2] is the key function.
In the following function calls, __slab_alloc() **always** disable IRQ but
after that, allocate_slab() enables IRQ **only in specific conditions**.

kmem_cache_alloc() @ mm/slub.c
  slab_alloc()
    slab_alloc_node()
    ...
    __slab_alloc()
      local_irq_save() # IRQ disabled
      ___slab_alloc()
        new_slab_objects()
          new_slab()
            allocate_slab()
              local_irq_enable() # only in specific conditions
              ...
                 ...
                    buffered_rmqueue() @ mm/page_alloc.c

Condition 1: if (gfpflags_allow_blocking(flags))
  flags is specified by caller of memory allocator and includes
  a flag __GFP_DIRECT_RECLAIM to show if it allows preemption or not
Condition 2: if (system_state =3D=3D SYSTEM_RUNNING)
  SYSTEM_RUNNING is a system state after the init process starts

Thus, buffered_rmqueue() is called with IRQ disabled when...

(A) GFP flags do NOT allow blocking
(B) The kernel is still booting (the init process does not started yet)
    =3D> That's why I was not able to reproduce the problem after boot!

I think (B) is more important because GFP flags are completely ignored
if it's satisfied. It seems there are some reasons to restrict enabling
IRQ in specific timings (e.g. very early stage of kernel boot) even
in case of PREEMPT_RT, but I could not find any clear reasons to do so
from related commits[3][4] for v4.4-rt.

However, there are some important changes for the condition check above
in newer RT kernels. I'll explain them in following sections.

=3D=3D=3D Reproduction of the problem for each kernel version =3D=3D=3D

v4.4-rt       Occur
4.4.y-cip-rt  Occur
v4.9-rt       Occur
v4.14-rt      Not occurred (25791 reboots)
v4.19-rt      Not tried
4.19.y-cip-rt Not occurred (72641 reboots on VM)

It can be guessed that some related changes are applied in v4.14-rt.

=3D=3D=3D Changes in conditions where allocate_slab() enables IRQ =3D=3D=3D

* v4.4-rt =3D> v4.9-rt : Not change
* v4.9-rt =3D> v4.14-rt : A change in system_state check
* v4.14-rt =3D> v4.19-rt : No change

Here is the change in v4.14-rt.
This is not provided as a separated commit but as a change in the
existing commit ("mm: Enable SLUB for RT") in v4.9-rt[3] and v4.14-rt[5].

 	if (gfpflags_allow_blocking(flags))
 		enableirqs =3D true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state =3D=3D SYSTEM_RUNNING)
+	if (system_state > SYSTEM_BOOTING)
 		enableirqs =3D true;
 #endif
 	if (enableirqs)

At the same time, the following patch series are applied as well in v4.14-r=
t.

  "[patch V2 00/17] init: Enable might_sleep() and smp_processor_id() debug=
ging early" [6]
  =3D> That's why I was not able to get any output of might_sleep() previou=
sly!

One of the patches above introduces SYSTEM_SCHEDULING[7], which is just to
make a new timing to enable might_sleep().
However, this results in the behavior of allocate_slab() is changed signifi=
cantly:

[Conditions that allocate_slab() enables IRQ]
                   Until v4.9-rt                  From v4.14-rt
SYSTEM_BOOTING     gfpflags_allow_blocking(flags) gfpflags_allow_blocking(f=
lags)
                               :                              :
                               :                              v
SYSTEM_SCHEDULING              :                            Always
(*)                            v                              |
SYSTEM_RUNNING               Always                           |
...                            |                              |
                               v                              v

With v4.4-rt and v4.9-rt, the problem always occurs **before** SYSTEM_RUNNI=
NG(*),
so I'm believing the problem does not occur by applying the patch series an=
d
condition change above.
Those changes are not "fix" actually but just "hiding" the problems that
some initialization codes invoke memory allocator without allowing blocking=
.

=3D=3D=3D Check with v4.4-rt + backported patches =3D=3D=3D

Fortunately, it's not so complicated to apply the might_sleep() patch serie=
s
to v4.4-rt, so I tried to backport them then check if the problem occurs.

* v4.4-rt + backported patches : Not occurred (22634 reboots)
* 4.4.y-cip-rt + backported patches : (WIP) Not occurred (around 500 reboot=
s yet)

As the problem occurs one time in 100~1000 reboots with the normal v4.4-rt,
so I may be able to say the problem does not occur by applying the changes.

=3D=3D=3D How to resolve in 4.4.y-cip-rt? =3D=3D=3D

(1) Backport the patch series and condition change above

I'm feeling backporting may be technically possible.
My concern is whether such patches to modify kernel initialization behavior
is acceptable from CIP's maintenance perspectives or not.
At least, all the changes are already in the upstream (linux-stable-rt) so
it still follows our upstream-first policy.

(2) "Fix" memory allocation callers' behavior while kernel initialization

Instead of backporting.
It's mostly clarified that there are some wrong behavior in some
initialization codes that call memory allocator (GFP flag usage?)
within SYSTEM_SCHEDULING ~ SYSTEM_RUNNING.
It would be one of the ways to resolve the problem to fix such behavior.
However, it will need more investigations (the early might_sleep() enabled =
by
the backports may be useful for this :) ) and the feasibility is still uncl=
ear.
Also, I'm guessing there is no upstream works corresponding to such fix.

Please give your opinion.
Feel free to ask me to check additional things to clarify the situation mor=
e.

[1] https://docs.kernel.org/locking/locktypes.html#raw-spinlock-t-on-rt
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/blob/v4.4.302-cip=
91-rt51/mm/slub.c?ref_type=3Dtags#L1401
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3D9ed2ef6690a56
[4] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3Db61200099212d
[5] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3D6cec8467e86c0
[6] https://lore.kernel.org/all/20170516184734.943149935@linutronix.de/T/
[7] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/?id=3D69a78ff226fe

Best regards,
Kazu

>=20
> Hello Pavel,
>=20
> Thank you for your checking my report and giving the comments.
> Sorry for the late reply. It took long to take the log (again) ...
>=20
> > Can you enable "CONFIG_DEBUG_ATOMIC_SLEEP" to maybe get better diagnost=
ics?
>=20
> I've enabled the config and retry but no additional information is given =
in the boot log.
> IIUC, when it's enabled, kernel ERR/EMERG messages, traces of IRQ, stack =
trace, etc.
> should be printed by ___might_sleep(), but not in the boot log unfortunat=
ely.
>=20
> > > WARNING: CPU: 1 PID: 18 at /path/to/linux-cip/kernel/cpu.c:197 unpin_=
current_cpu+0x60/0x70()
> > Can we get full warning in the email (and perhaps link for full
> > bootlog with the warning)?
>=20
> Could you check the attached full boot log including multiple warnings?
>=20
> * Environment: VirtualBox VM (the same as the original post)
> * Kernel: 4.4.302-cip91-rt51-test1
>   * Temporal branch: https://github.com/zuka0828/linux-cip/tree/linux-4.4=
.y-cip-rt-test1
> * Config: x86_64_defconfig + CONFIG_PREEMPT_RT_FULL=3Dy + CONFIG_DEBUG_AT=
OMIC_SLEEP=3Dy
> * Parameters: consoleblank=3D0 console=3Dtty1 console=3DttyS0,115200
>=20
> Usually I'm repeating the reset automatically to reproduce the problem, s=
o
> the first warning logs are already lost when I notice it's reproduced.
> To get them, I applied the temporal changes to panic when the warning occ=
urs more than 3 times.
> https://github.com/zuka0828/linux-cip/commit/4f59430d2b5183b7b65e598dfd7e=
93e7d99c3cd3
>=20
> Looking at the results, you can see that the migrate_enable() warning hap=
pens first then
> the unpin_current_cpu() warnings follow on it.
> Please note that the call trace from the migrate_enable() warning may not=
 have much sense
> because, as I mentioned in the first post, the root cause (i.e. breaking =
migrate_disable counter
> by calling schedule() when preempt disabled) was already happened in prio=
r to this warning.
>=20
> > I believe get_page_from_freelist(GFP_ATOMIC, ...) is okay thing to do w=
ith irqs disabled.
> > ...
> > It may be as simple as some kind of driver doing kmalloc(GFP_KERNEL) wi=
th interrupts disabled.
>=20
> Let me ask what I should focus on based on your comments above.
> Do not I need to check functions that call get_page_from_freelist() becau=
se it's safe to do with IRQ disabled?
> or is there still possibility that get_page_from_freelist() must not be c=
alled by other functions
> (e.g. kmalloc()) with IRQ disabled ?
>=20
> Please feel free to tell me you want to something else to try.
> I'm still trying to find ways out to reproduce the problem easier not onl=
y while booting but also in userland.
>=20
> Best regards,
> Kazu
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Pavel Machek
> > Sent: Tuesday, October 1, 2024 7:39 PM
> > To: cip-dev@lists.cip-project.org
> > Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in unpin_c=
urrent_cpu()
> >
> > Hi!
> >
> > > I'm facing a problem while running 4.4 CIP RT on x86 machines.
> > > Let me report the things I observed so far.
> > > It's appreciate if you can look at them once and give me your feedbac=
k.
> > >
> > > =3D=3D=3D Appearance of the problem =3D=3D=3D
> > >
> > > The following WARNING (and call trace) is printed on console repeated=
ly
> > > and very frequently.
> > > It seems kernel cannot process anything (but still does not panic)
> > > while the WARNING is printed.
> > >
> > > WARNING: CPU: 1 PID: 18 at /path/to/linux-cip/kernel/cpu.c:197 unpin_=
current_cpu+0x60/0x70()
> > >
> >
> > Can we get full warning in the email (and perhaps link for full
> > bootlog with the warning)?
> >
> > It may be as simple as some kind of driver doing kmalloc(GFP_KERNEL)
> > with interrupts disabled.
> >
> > If you could enable CONFIG_DEBUG_ATOMIC_SLEEP and try to re-create the
> > failure, that would be helpful.
> >
> > Thanks and best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


