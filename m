Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F93EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 01:50:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.2505.1689645003050862995
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 18:50:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36I1o1DK4065843; Tue, 18 Jul 2023 10:50:01 +0900
X-Iguazu-Qid: 2rWhJyZQYTpaYKFrfs
X-Iguazu-QSIG: v=2; s=0; t=1689645001; q=2rWhJyZQYTpaYKFrfs; m=Fo7ZBNKM1U3JLiDHsJJ5eyaqhM0zv1sWecC5JiVp9rM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 36I1o0MW2468427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 18 Jul 2023 10:50:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUfshln05JJbbVW2SmNRY8rmJbzVldgg58f6KvwV9sCO8NZEC3KqjtPtsAalP0s9kh8yHkWBm+rxaCkSraXNu8/ByXM5ZB6kofD+PKd6H3lU6wx9x/TLbN2PIgWl2Szyi//hHjBDJV8wUr3zo9v8rnu4avtb5cFbZKZxNceBgaX5M8Vf+SKE1P/3Dbf9fuRmzhq2aZvr+zQ1XQIAJv0R7+wO6ipccBXzZssZgK+8V+FSsOP03nTTZ54/vTFaG3AASmZJ04Vhr18y6cWvQVhWM5D6CNJ8Kl2GcrdPmK6ss6j5hRt1+A+YidA/yoq34gtNEBmPEMU2w5QaFElZFKAm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dn+GDoBTnxSIJF1OcxyIbW89htkhWenfgO35M3aTuA=;
 b=lw/yOe94PuXzBESL0BYLssL6PJbsUSDaA8XlpR3hJnooCccVIddjnR+jbE8XvcC78e68Zc0Y7HcsYtBgwq1aCQZVigoklalI3MWTFEGaqxY9jCaZDFnNShrdrwFDA+nPONM9QKkQ4A553zJ3JbFW0CB4Q8zC31B+/TrYXu/sIAfgBNybmcFGj/S9An8gHe6ALEmzjQDYfRnpLtZDk/u7Bu+ta9ognT6llXntsCxJ/u78t0ZyoLhKNrEDcLPGbZF1f3E6byZmWdQro5zPyRkzpZzWCCVhsirkLzaLaQMnvHijY3pR2L9QLwfqOyOaPQhLLmVFORfKMpxL1A1/4gNMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add audit
 and nftables configs
Thread-Topic: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add audit
 and nftables configs
Thread-Index: AQHZsvOD2O6vCfMhXkabMnWjf3sBja++zlIg
Date: Tue, 18 Jul 2023 01:49:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94201BD44E41C67535BEA4129238A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230710055809.10197-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230710055809.10197-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9577:EE_
x-ms-office365-filtering-correlation-id: 25be17a2-f1f6-4af3-29c0-08db87314ac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Hmqkml/XMffUAhPUHY/iwgntXw5AXADnPBRYlI+EnHDJ79vk9pT7xEqDVWs891/N75BTP48l0nqimHz2ZzSgiu9QIEOGKInixETINrUSX92ZS9wKDOS9Cl59BmkOOeYIJHz7WbSj8FDwoQQNF8Od+no8CW6CNLIvErzsiGpZnuXdRN8TaLxPS+gU8G87N+v3tpUDlD8JvpwAx+YRDMIEOCJIse8XevUcCk5rMOocYDUh9gvwpo/AOO7MhmMAXJps+WB0bgHLBmNa4XZ9V98WPGstd+VXs+iOZ7y+VVTLJmJCAeiXBYI9lJpF4KlRTeQ7yTKgt4Dysr3JipJfkwtaPqPazHIxwM8zPYmfPuI5Oq6VxM23WkqkAAKkQ6KrtcYns4b6NJ+Xu50HzxA6R7cDk2qdtPDVwaTS9lDsC+1qI9zg0Tb2v687GuK6G5g2G1htdhPS9R+fdEi4HvWbDUFzR/NXKqbtI/Yw+fbkERR555j2LIjAwcM7mTSgNezv0lLMf7B5ulA/OiuTND/fgYVM0t97MO85vOSQ1a5LrLKN0S6/UCAZl+yI1C+onfXvQHh/KYnFCUVExVushz9VXjNrB+O4gSPm5WyVGUxBOBUrISX8rH63aSJ0oxIbQz0Vw22wTn8iQ7gkfqLCxHWOstHgSg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(9686003)(6506007)(53546011)(26005)(122000001)(38100700002)(478600001)(54906003)(4744005)(33656002)(5660300002)(52536014)(76116006)(8676002)(8936002)(4326008)(66946007)(66476007)(66446008)(64756008)(66556008)(110136005)(86362001)(41300700001)(316002)(55016003)(71200400001)(7696005)(186003)(107886003)(38070700005)(83380400001)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NEFnTjJYUWYxbEI4WXpxdW81WWU2UzVZQVMrZUZtTzdibFJjRGJLK3c3?=
 =?iso-2022-jp?B?MW94K3gxRzVEV3c3NFhLK2MyaXp2a2xhWGc0Y1EyanVjcStyK0thRmxr?=
 =?iso-2022-jp?B?N1VOY3BlMjQxTVFUb3doeUhRRkF3VzQ2WGdTSjJ3SWsvV05xVjJYUWF2?=
 =?iso-2022-jp?B?ZGppcEc0amh2YndNTXU2dlIwNExTN0IraVhpNDZZOEdKQjQ2b3MzT3pt?=
 =?iso-2022-jp?B?c2hOSWNqd1dnN3hmc1U0R0FnMGVKaVpkbHpLU0MzM29sdCthY0hSQmw0?=
 =?iso-2022-jp?B?S0ttcTVsNHlTMFVGbXBKQmsrSWUwV3RwdGRkVWxjZWtGa1lNTzBoNGky?=
 =?iso-2022-jp?B?NzErMDMwZ3BwamNtc2Z5SytxMjlDWWpsbEJKaGdzVG93aEVBUGUwUk55?=
 =?iso-2022-jp?B?NFc4VkpKR2dmeHVtZ3JlSE42UEcxUktxb3NwaDFQZUNwRzFlYld6L21R?=
 =?iso-2022-jp?B?a2trb3VjLzdpMUJpeVhRTHd1N1MrSXlNRXVyUU9NTzY0KythVFVuNGty?=
 =?iso-2022-jp?B?THZVVzRNNDg5ajRIRGRnU0F2QWtwNGhzdWRQRkJpQWZhMitLSVF5TFQ4?=
 =?iso-2022-jp?B?M2xRQmw2MVZRcGpSK3BzWnpSaTcyOENRd0cvUjdqcGc1ZWNTUGtjYWYv?=
 =?iso-2022-jp?B?bEh2N2RYc2JKODhFYzM5aXZuYzFUdkVmNC9iRm9LL1EybDNFeFEyZmUw?=
 =?iso-2022-jp?B?N050RWhscFdyUGZxWXZwR256bUEzT2JIL3hTK2U2cDk1amd4ZVhGU1gr?=
 =?iso-2022-jp?B?RTdRK3kyTnAzWjA2ejJuODgwdk4xbStqWGdydGdYdEh0MG1vSEdnalJj?=
 =?iso-2022-jp?B?elQ4Q0xuYm5iMSsvbnp1bFVqeWVjdGJ0UndKSVFKQ0tGNktLYTU2Qi9S?=
 =?iso-2022-jp?B?a3Bva3VKZ1Byay9wTlpkNEU1dmZUSkcrUCtNQitVNTlOYkJLRmNDVjli?=
 =?iso-2022-jp?B?a2N6QkprWGw3U0lwWkFMelBEREpUU1RrS1RmeUYxNmNjMWpWOGZRQUFU?=
 =?iso-2022-jp?B?bFJ4RityeFRqTWtQNUdxeWdBVjNoVGJXT09uRndGTDloak1HVk4rRTh2?=
 =?iso-2022-jp?B?dzdlTEtJTWEwYUVaSGJRR1dQYXJHSjJXSmtUdlVOZE52UzVSUFFhUXQ0?=
 =?iso-2022-jp?B?VFRGWXplZXptUnNJSHRzSGhSeDQ4ZGR4TGlncTVONDNtejJoa1lwRUlG?=
 =?iso-2022-jp?B?NzczNGpobnhKOTdBM1E0NVFQMEhyakxjbUFSdlI5UmJ5VVZ0TFE3UThI?=
 =?iso-2022-jp?B?Q0pBWEZBam5JcEQ2RDVVaEdGaDlKNTc5Tmw4bGR6aWcyb1UrSTh6NCtw?=
 =?iso-2022-jp?B?ZVVHVjJUOG1RWFEwYzFUQjJ3MU8ra29JQU9RRUR5QUd5dmY0L01kY2wz?=
 =?iso-2022-jp?B?QlJjQjBCRDVoa2ROQnlhTm5zaVM1cHVaSDBxeEloV1d1cW1aczF2czhw?=
 =?iso-2022-jp?B?T3RDV3ozdzQzemdUZktZRWswTUN0ZkRzdkFjUDBWSGJadHJiSkRWUFM4?=
 =?iso-2022-jp?B?Y2ZLLzZCVmcyM0dEbnEwUHRyT0NMMmo3ckpPVUl4Rm9rM1o5UkxvMWp6?=
 =?iso-2022-jp?B?M0NvUk43aWExVzBsMS9NNGFPVHU3ZnQraFZIZ0phRWk5dXNHamh3Z0Q4?=
 =?iso-2022-jp?B?YkRpN3FlYkNPMWt0WDhlL0xUOTdhSmRJMi9INkI3ZjJiYWV6d1dEOFho?=
 =?iso-2022-jp?B?R09NZ3h0U3hObGpmVndQQldXSHdPaGRlZUVMN1lmYThhbE0zTGRHYklM?=
 =?iso-2022-jp?B?S3VyVG1LOEs2RDhzWlVBMzVtVFJ1T095WXNBZ0Vhaiswa0lPcmppSUpa?=
 =?iso-2022-jp?B?MncxSmpnQ1VuclJvTC9yNVZ3YWREaVNwV3RNK21kVVF0NUdLeXlIYm1n?=
 =?iso-2022-jp?B?L2FEZ2JFT2FIN2xUMy9hZjQxeGJQZGdEV1JUWEQ4cVJwTXBXVFRScHV5?=
 =?iso-2022-jp?B?QThHZmxhTFR1eHJqRVMzNnhYMXJnY1VYaHRhODMrSzUzYXRWU0JlSVIy?=
 =?iso-2022-jp?B?V1c5Q0FVY0d5VXNnNjhHL1ZDT0RHVFdpSFRvdFJuR2d0eUc1Mkd2dllG?=
 =?iso-2022-jp?B?NVBTOHpXRE9scm9zbk9JME1PUjBlYjlyT3ZWcDJJSTNKVEZ2N1JqMEMy?=
 =?iso-2022-jp?B?UGxqTnlXdGlNMkI4ZE9QZ1ZVdlFJKzhEdFA0RkN2QnhTK0dFUC9UTTho?=
 =?iso-2022-jp?B?SG4xRG9NcU9QUDdlU1NleW1WZThnNmRqeWJlUWIxcnFpd2tWT2tGRE5t?=
 =?iso-2022-jp?B?T1QwSXZaWHhyZWM1dHlJTjU0aGs3NHRqZitVMjFRVlpyNjJWb3l0K1Er?=
 =?iso-2022-jp?B?WGpiYnpHQnIxUDFxYUVkRkNaeVhPVmVmSGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Kd/455yPNpC7lfBAg7/eb3gvDTpzrlJ9aOqYTMyecni4af3ycX8F2NwvztqyNWe3hnkicbwtpuBQ0Kil+iSSBCAS45w266p/IBU24IZBZP2Fd6HS0DCTuZxY0O9GGS1iAflHyqYmfuTdu1rF4MGBwmXh+T7liglcBeDngQaSwYw1bCDEwiQrjbOFXj2Fr3fgjp+v2DTJTFdKx7Rkc33BhRgaB7sck9FAmr4yaOJAgl6X1FZQYo54vL3vhv75hn94Y5VOmAa7D3EJCJRTsxjgoXgCtLWJ8j8C+rldziZZh/+YoPwBywPSfnIjmJl7CGORIPnLQgPUFDtfRXGF6VayU/OB22TgT64Bq9ColTCIYhckV6BLJBDH9GTg0/kCAwMPodspcEjWKylF+mD2mUi6Sh61jdUSY+TiheUgcyDrpwYp6x4kczfD8vF0MaE0fnbOH+RP/yzA089dd3m9W9RJv5rd5EbgVbrBhya4ikdZBpPEdwvo5Cs27Q9UeaAeiLiOKBrwMyyxzAhUbEYED+8gGvVJuMzUUmktVQo1AODcNxFi61nIuRIo6myKAmfbd6733z6U+eJ1x5/gQgLw73YKOmb1GgnM0LB3y2EjD/BGlHynv/6fYbarBCMCUV5FmlFh5GbMSJsuodPF4O5Bd5Rzv3qe8BRnJZOVZ5CWYTBXg/AH/5lwg+wU5ePa+Er5tyzQOGMY1ktGGaWO2Pzn+SpqvdsKKKdhmjN+qyZMfx977Rq4ES/9rXqAmNaXdx8us+wmJApjHrKt0YC9RZOLEEbv0aem4BLuTANu3vu23q+qIujAvT6TqmpVRyXJO4HqtT+
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25be17a2-f1f6-4af3-29c0-08db87314ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:49:58.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6ybBtIUlc+b6EPEi7H7PWYQvMibsgNBmFbT69VFxbf3QqVsvcuizt57vOcy202W8hOJ9leUv6nsZW3VlNViFVVGAy2RQuvjHFb9wnZIyEQ9ZsNp9KUy9uJ0cPZkW8ty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 01:50:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12376

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, July 10, 2023 2:58 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-kernel-config] 6.1.y-cip/arm/qemu_arm_defconfig: Add audit
> and nftables configs
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These kernel configs are required for nftables and auditd package to work
> which is used for IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Applied, thanks.

Best regards,
  Nobuhiro


