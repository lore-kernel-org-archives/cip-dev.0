Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09DC4828E
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:06:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.21155.1706875605868459774
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:06:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 412C6bDY1394637; Fri, 2 Feb 2024 21:06:37 +0900
X-Iguazu-Qid: 2yAbDGJnhzbxiOmsl8
X-Iguazu-QSIG: v=2; s=0; t=1706875597; q=2yAbDGJnhzbxiOmsl8; m=KXOfjHQ/+AAoncLhTqFTCiQ2Lp49T/JUj9voJOUbEwY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 412C6afe2887590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Feb 2024 21:06:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxymLgZlXnw/LxSaXT95QhfY5eMc7Vt0Ie+XpUI2LsnwnNpe9TH0TxDDpkRYlEDTRsym0tKjd/9Ic0VuswDQsd7oIiuIj3phrtTxZ7lWZHfBa2HlNl/bDOy1MpKZ62DuiE9rM7SUF9YMJqlP6Tc9nK2ZPY3p4iN87neItgMwKpg9XMv36pMFV+RQYKR60px8ludiRL2XkhwpGYMOvhago7E6rwZHjIGIiELo85hQLKZI2L+qP58yvkoWLyXKT9NIN+XlmbxlHEr62LP6RlK69g34fOJ9kiK3RhF9oHkchb1fUx0un7v25qf05QnEvE1FxT70azWvNmG2zxWFy+kT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA+Lx8/XJSX8eDw5MxtiQc6RjWH9eNHc3fLgk5DUZtA=;
 b=jWNdL3mazqB4LjVppZav2C7qFEUw932vpgzpo05jGK2VwuSXTQ5Szs2LvyXGIuVSs/YkaOWIaQYVj+Q6cFAZVmydHH58PguB6KSgs3iE3UCqJDINSV5t6dl+cNcSjkfsNWaQ8p7nMiCOB+sPKI8+S5OEtgE7ghCCJcjBm6XDWJYwzfLr2X6cLQw0JI12ChDo4IyT31zkLIuATTC5JSzFXr8eRY5zBP+RDHNtoCfbHkL44eTrFTBFWYgdT13JIZzTG7Exp/+8Q0dbCRhIvb0o0RwdbCaFPi48DJvy7welOGm+1tLfuBJRlyBum64Z7WDjuiHRCzkLZ0aqfbtexjvTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 4.4.y-cip 0/2] Drop undocumented register definitions
Thread-Topic: [PATCH 4.4.y-cip 0/2] Drop undocumented register definitions
Thread-Index: AQHaVcEk2E75MCAgv0WJr+UQ3I2VzLD29Kbg
Date: Fri, 2 Feb 2024 12:06:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388993D6F46E71E12707AE292422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240202101807.153140-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240202101807.153140-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8262:EE_
x-ms-office365-filtering-correlation-id: 58540564-988c-43e5-534d-08dc23e7667f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wDEqRHsIMHgjDlEr9iDzg8A+GdOuPyRW0exT17Ba0n72elQR2gPSxusMfUc1IcNObxDIws+WrFwCZvAkbsO14phnY+1GJ4dv87nJCMLASBCM2jE/oIdzN/GDLAnCXeTpROqG2B3CKlte9jiYddqqBm4qkE+J+O6Gkq5NJU9H438Q93LPZ50ieSLclTuMfOKvKP3tpqpbOyOsN4QnYMbDBOzLQqB+KhzM32HYvyD+MqUuZVU8wl2ne4nxWSE2NJa1FkdOb/tPrasGnU8vzv9q46CrKfjVvGhNVijm0sEX/qwLYcj2QziJnwY7vMARpeOUFXHJxJtg5b9K1irMgUOsj1g/Fy0O3gWD16rq5GF/bmswBXUqwm3pqZGJ8buaWNGvgzcRcde9BBeQ59wDfMURsl5q2MjCY1BYC957mH7Avbvq1qhh5zEDRY7VbA3xO8dLBjbquxS2BJWZPAacVxoXPwg2FNu/Kt4X8FVZViU5XkDeQrOoIdInkSK6a6IffdAZ1xwHOL2AWLQmeHGKdUcu3aB6eAa3DqVdYhkw1a04zpxwF6Az6p16iQgsP3lM/WzkOzLhh3iM+PEHoebEJHPcZ6tqTIq1uKo/5TkIYDC8hMEfQLLv7aGd6D5f2L43g5F9tt7d9AwaQIgwHqfNAOwKRg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(64756008)(66446008)(26005)(83380400001)(122000001)(86362001)(41300700001)(38100700002)(33656002)(8936002)(66946007)(76116006)(110136005)(52536014)(6506007)(2906002)(5660300002)(71200400001)(53546011)(316002)(4744005)(478600001)(66476007)(8676002)(4326008)(7696005)(9686003)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aGpMWlZodDZqOUMzb280VkdYT1NSL2N3bTN4UGpZa0dOVW8zTWRGbW1t?=
 =?iso-2022-jp?B?YmZzSTNNZVdCWlVMdlVpNDVHUkdhaEJOdmlZclQrYytEd0t0NEFqa0VG?=
 =?iso-2022-jp?B?em9EQUJIdjJDQ2hLQjh5Qk5KdUZObk1sZUI1dFVXZ2hCdm9IVHcvWHFn?=
 =?iso-2022-jp?B?NjBoVFBSVUZwNlZQMjJhVzVXeUdHcjY2MVdDQS9QSlhScE1ubjBpZGlt?=
 =?iso-2022-jp?B?QmxaaGN5SS9pZEF4aVllVnJBRXlBUUVIeGY0UlJ3SUtrMnZQbUVmbVl3?=
 =?iso-2022-jp?B?cHVBbkRZUkM1aGZTeHErU1ZNV3JZRGlDcE9NdjMxQXdtZUJOVWNuOVZi?=
 =?iso-2022-jp?B?aHdXSUhpZkNoNUZxNWpHSVloQXZIOWpDc0VDeHBlNUR1cDY1Rk80YU9l?=
 =?iso-2022-jp?B?dXo5Y3FEWHA2cUE3UmJxYUR3NjdnRjQ0MTFtNys4dlFsSWh2RTdBMk51?=
 =?iso-2022-jp?B?SFJmOTVFMlQ3MXFNMXErOHF1aHIvS3JUdzdwamRRUXVSNGduaXJyM0xR?=
 =?iso-2022-jp?B?VEtLL3U2S3l2YnNmVld0ZXRCc2tnY2RoSXBTc0Z1K0tTRk1UVFN4Lzhv?=
 =?iso-2022-jp?B?elJkWU50K00yRXhyRldubUYzN2ZwZVRKOHAvUGkzUnUrc2NJT25jOUFo?=
 =?iso-2022-jp?B?UkpXVm44QS9HZ2liNFptbENvRW5ycDJ0SHpCRXo2dmRKZFk4RnhNUVJm?=
 =?iso-2022-jp?B?MFJlZmkwTEc4ZEpid1ZmRzlaY1QrbVdLTGFRVWtKUDlMWjJwSWdGRG0y?=
 =?iso-2022-jp?B?Mm9rSHFic2lPV3NkM1FmZ2JITXgyeDNyYklCYVZPbmpvc1dhbjF4TnVW?=
 =?iso-2022-jp?B?a1hIaTl2NWVoSm5uZVZmVUlXQUN6TEZTcFFYc3VmbkkzZlJGdFdhTm1B?=
 =?iso-2022-jp?B?N1FUNFJXUzdVdUU1R2V6a0ErdU15QThGUVI2SCtXcHFrVzEvR3BzU0Zq?=
 =?iso-2022-jp?B?bWE0RVlaWWpEWlFaQTdyVDcwUHhqeU15QTlQZVNJTmhQa0x6WGh0WWRs?=
 =?iso-2022-jp?B?dCtaM2xXa0w1aUpodmRGeGF2YjIwU1NuKy9PQ09yVXdtUUloVUt0VkF1?=
 =?iso-2022-jp?B?Zzd1djd5MkpIRUppdm1vcnY1Ny94cldpZThXMUhVbFBicVN5TVBvaTR1?=
 =?iso-2022-jp?B?V0duOFNBSDlFL3VldHFzT2EwV1VDa1hrY1NqK1A0T05hcndKczhyZENs?=
 =?iso-2022-jp?B?aE9oaXFKMHJtdUlwV0RubUxFOWxWM0FqcUxCNkZKeWZyUHZWSGlhK25u?=
 =?iso-2022-jp?B?eXpWNE5zNWtsWlJhVHJDMzA3V1ZTL0dac0NpMS80ZjdrMU1mSEo2c28w?=
 =?iso-2022-jp?B?VDNiSUhhOW1kdy8wT3JzS09xYUtYdVBaTEdmSjZ3V0JkUC9YdmY5UXZv?=
 =?iso-2022-jp?B?d0V1d25LeXZ1VDVzbWJwalN2WDlWT1BxelRnTXdiSXdxTldYUzZqVkow?=
 =?iso-2022-jp?B?MTFqUW9TTjFDT1JrbmZOL0NnUFFTa3JDWHc3aWVSelVyai9EcUgyMHFu?=
 =?iso-2022-jp?B?V2hrNm54U3FJOE9tV1ErSEN2SnNYdGFVN0NJdGlJcTRmNWJMQXY1WlZZ?=
 =?iso-2022-jp?B?UW1HaHV6bEdwYmw4eHR0WElXUDFoZTFab3lYbE9jN0ZxbGIvWlFKeXFP?=
 =?iso-2022-jp?B?WHFGR0RXdldjRUVJeDZ2M0RhMmtXdnpndVRBby9LRmpuRVl5VTZsa2ta?=
 =?iso-2022-jp?B?ODBFOTdhODZHU3dsOTN0UExQV0RMU1ZveDgrMEoxdHM1MGhJSUtkTFB4?=
 =?iso-2022-jp?B?ZVYwb28zQnFwcS9BZTgzVTkrMENpRGdBV2NGaFk2UWIwUk02Um4xaGVh?=
 =?iso-2022-jp?B?d085dGlDdUc0NGUybXphUzdGZGZYV2xPUDM5V2dHcGxBc0VNM21MMTFx?=
 =?iso-2022-jp?B?ZFQ1QW8xUm9GMDdHeU4wbktuNnlFNVAvNGc3K1ZNUUJLcDJBQnloZWpP?=
 =?iso-2022-jp?B?Wkk0QW9nWGt5MEdta2lTcEc2eHVxSmdkRkdncGxZYWxJWFJhamc5OTVE?=
 =?iso-2022-jp?B?WFBpUnpiKzZvaTNLQWFzNEtsZ25MVmp5anV6VFVxb2VGcHQvUUdMODMw?=
 =?iso-2022-jp?B?MnY0c1JtMXQ5eGRMdzFMN3cwZDM4VVVhczBxZEErb0NPZU9TUXFMRGpk?=
 =?iso-2022-jp?B?NjE5OFk2Tjg0RElyVXpzYkxwajBpWk9Nc0o5VHV2c3JHRGpQL3BnMGFK?=
 =?iso-2022-jp?B?VzNRSnphNlFWVDkzSlVrczZabHhQRE1RZlMrdm9vU1Z2NHZqcVFnOElx?=
 =?iso-2022-jp?B?cVVSVmU0OTNJMkJZOHg4aGJPTW9PeE9HdEU4b3FsdnN4NXNkNW0zVlBi?=
 =?iso-2022-jp?B?QmREL1c5a0pNak8xQ3hrRC9xVUlwUzBpclE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58540564-988c-43e5-534d-08dc23e7667f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:06:34.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQjgH+GSr/chTFH406X3wdoR8LgFxAc3AT2Ihzf06Ocpv/nvdd3kFT7eOcsgDOMB7Z9vuQ4k9dZYgddpGdKwwEjXoCy0Nr34OUM3u2OSeQ5TS+F0JOmISc5hXh0p9wYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:06:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14624

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, February 2, 2024 7:18 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 4.4.y-cip 0/2] Drop undocumented register definitions
>=20
> This patch series aims to remove undocumented register definitions on the
> ethernet driver (ravb.h) in cip kernel 4.4.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Sergey Shtylyov (1):
>   ravb: update "undocumented" annotations
>=20
> Simon Horman (1):
>   ravb: remove undocumented endianness selection
>=20
>  drivers/net/ethernet/renesas/ravb.h      | 27
> ++++++++++++------------
>  drivers/net/ethernet/renesas/ravb_main.c |  6 ------
>  2 files changed, 13 insertions(+), 20 deletions(-)

I reviewed this series. I can apply this series, if we have no other commen=
t.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



