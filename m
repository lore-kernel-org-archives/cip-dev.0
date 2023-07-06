Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6264EB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:30:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.10895.1688603417943509255
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:30:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3660U8gs185280; Thu, 6 Jul 2023 09:30:09 +0900
X-Iguazu-Qid: 2yAb9zVTfDtxaQAM2d
X-Iguazu-QSIG: v=2; s=0; t=1688603408; q=2yAb9zVTfDtxaQAM2d; m=L295Q9suS03AjUchxOQaVs5tMRXp4iMTwo/NgMTVCws=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 3660U7Ck2438587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 09:30:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPlyZhpeB+LXAkRFlQtJo7WrHW02apm7aNM/H+G109smXdVM3HOKMxUyzVyMnUZa1+xYJPbC6wvUAFupOBynZEzi1XeOJ+1ajqpVnq6QSOmg6Ha4UT8d9l/IRGbV6ZDFyME4+b5oWeGdFRM5S8vMbGFg3Hsiz9/FzHD08780GtHk/WemAVMW7pqmhqCAH+RhIkoGkXZ8W7Npqjra9rVR4Uqpt/30Tna8jCBwmxLfHn//qAutdwZyRbLDU3mZFCauSEUwwnqyijnmmIIdyCjd2I50rsoY/tYt9qcv3vtgVr9pTCj/qjZBwUjCc7DbEUGstxzGS4SJ9PHTl8cEMHzWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIeLzc9gBq1iKCdOM4yvbr4pZdYs7/AETONcaJXtscY=;
 b=FkwejpI/w48VvRQwIhfJvdU2nvj4XbTMJMWNZ/B1G8VBEKkOUT1Umsm5I1t5u9RI+sAZLHHsyWFwP1ArEjOJr4TOH/S1tGlpUH/MssIMi3dmxtD5waC798HL0icuN1S58/n4QstdMidTeAwh8IOc0aRw8zI1Yb3XPdD3ZBF9tjzfLYh72tnpUYd2db387N3dUQ4KQxwdKhy/qORrIWtedMcyFtFFsQEeaxsbaH9zGKvwMXPwF2F7KZP0Nz6gRvtsKioyi/AV35xqMP3+7+x+X5W9W8sfQYrTNhD4GhVmVrtWul9t21LhlIzPt8rtJ3kV0aZp0j7OQEwLPtvNP+pINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 5.10.y-cip v2 0/4] Add Renesas RZ/V2M PWC support
Thread-Topic: [PATCH 5.10.y-cip v2 0/4] Add Renesas RZ/V2M PWC support
Thread-Index: AQHZro0eOvv+m8ZSuEGAeNRnUZ5mk6+r5FMQ
Date: Thu, 6 Jul 2023 00:30:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94204F2C0F70B72046CA6CF1922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230704153452.11780-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230704153452.11780-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB8159:EE_
x-ms-office365-filtering-correlation-id: 18b42d38-aa77-4aec-5db7-08db7db82514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F5OYbFfYXuFtsbirCV1WkCbZhUWnPizh60a6ln9HmJi5quo07aQUS/AuEFePCiWAfMhv9RKg42Ai/f67Z+GRpZVFbioQ9XwD4/kMbYaxmecWpk9Imu5w/educNwHJdoqIDEG/r7UA+ixGttBZyuaav43dYc7Ed7TYnCVXkePgcDZWoFjkFz5VepArwJwibQDFxvrKpr5jg1sfRZJaGQrTryIsF7UgfBrclJxSPT89M8NqliY2xKvJFPfE8tyW9zeQEYDy9J45UyS9a9D+6ruBgxbJ+auA5IrV9eicc1QLy+1/kaRpoJ6xe5kRjeVun9xvt22n/DeINQ7ghi0q+bqW9eORUytnDP42zwRtxaVNmJ5RcD87tH70b4J/lN8J1nzxZDktaJGPVFWV3rRpObmfzEhORZV9D0hTsV/dGNUuJEjQpWM6QgVc9BWfg7BMojXSvyxu7cuKQWSbNrWErcmxjHJxckHgKFWq/O5miGrOU5J5umMxV3Qvy/Nuto2oAwWEDIVrqR6KszAQyaRuo03vGVDgWyn+iPwptUTi9Itt3EFJNd0iL/ZV1njqtIZwu61Zs1pwuCVRMqN4TnLSZMmExHt34s5zYqW+6UE98D8odrNxp459DAA2ewejrnyIr5Oel5xPpRXdSG9i7/OKqlAbA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(55016003)(66556008)(110136005)(54906003)(66946007)(7696005)(122000001)(71200400001)(478600001)(8936002)(41300700001)(8676002)(4326008)(66446008)(64756008)(38100700002)(76116006)(316002)(66476007)(186003)(83380400001)(53546011)(26005)(6506007)(9686003)(33656002)(86362001)(52536014)(38070700005)(5660300002)(2906002)(4744005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T2pSVVc2RzlQbVJVdzRaeDRTZjVzL1NsVW0vdWJEaUczL2Y3ZmlLSVhz?=
 =?iso-2022-jp?B?ampocUtaRUk2bEpKS3ZHSks5Uk8rdUFwTVZiallHcjJpRFhHOXl4Nzhp?=
 =?iso-2022-jp?B?aHNXQ2dEeVdWRURkTWFteWtaVEFLSWlCaTQyKzYwaTBEaWlUSSt3VVk1?=
 =?iso-2022-jp?B?TVYzUzhtcnlMczdjblo0VEZoVStKWVhuZ2s1aHNwbmpleUtzUEFWWnQ3?=
 =?iso-2022-jp?B?VkwvejBPdnUyQmhqQ0hPa2lWKzR5Zk9TUjhSTHdZSTFrVkNYOCthUnpn?=
 =?iso-2022-jp?B?cVpRTGwyYlVEZXp5TVZNWG5qZ0o5RUh2RUZFWW1sU3VORkFTYnh5SWV4?=
 =?iso-2022-jp?B?R1hEYlZRdjlsVE94WEhjL2tJb0pSdmVDSEx0bjdyUU1RRW5LY3ZyQWFa?=
 =?iso-2022-jp?B?Y04ranNGMGRGSzlRc2luSHY0LzlaMjZUM1pYMnB1Y1M4QTNJNzdkMUsv?=
 =?iso-2022-jp?B?NzUzalh1b1Q2bDZndytKMCtYbUhsRi8wTXZCN0lXMHFsVC9EMXYwMTJH?=
 =?iso-2022-jp?B?eU4zSnNIOE9sWitjajczUkM3dFJiU3hlbG5KaXZpWi9QRzk0UXFFRmNH?=
 =?iso-2022-jp?B?dTdtK1M0ZVpieUZQSWJiVGZiMXVManhUZVZjT3RlVnN0RWkyeWlYRTY5?=
 =?iso-2022-jp?B?YlNQRzhRMmYzeWJXak5VNWFpVFRjSFhZaHlnTHIyYmNNaHpNR3FQWUVX?=
 =?iso-2022-jp?B?b1crWXdoSHIzcjZpMEpjVm84WWpZWi9lbldXR1pDc3JYeXkvcXhiMkht?=
 =?iso-2022-jp?B?cHZsZWdBMmRVbVUzM2lNUXZGZ3k2cmxtbmdPQnFZdXdQQkY0ejZtNzAx?=
 =?iso-2022-jp?B?b0V0UGNxbERDRk1aQkluVFcrUEdRMU8wRiswMnh6NmdGdnFrTXFKQ055?=
 =?iso-2022-jp?B?VHZnVkxMeVVyUnFSVGxaZmVvamljUjFNa2Zha3lnSERkejdYa0Y0T2p5?=
 =?iso-2022-jp?B?eFZ2WW9VSVpmckFwTk9IODExY0pDRGJYa2ZydStCK3ZERUNYSEtMNHBP?=
 =?iso-2022-jp?B?dUJTZzJiY0xrQUk3WFBEbHBaVlY1aCtjM01LdDVWNnpZLzJ6L0cxWEJl?=
 =?iso-2022-jp?B?WGFQbE1DaXNFOERGdjhteHNnQUl3WXMvdWZmL2Iyc0llVjhjTDZacStM?=
 =?iso-2022-jp?B?REFGcjg2ZTNFOTJ1RSt3QW9TMDBqUHlJV0VYTGNJd2RKcUNrMzlMMmpO?=
 =?iso-2022-jp?B?YzNNVitReEpNYUd3TWk1N244bC9lVWpqRy9mWllkZ1hBUzZIUHNwRHN5?=
 =?iso-2022-jp?B?VTRqNVUzRUNzL1VwV3V6UWpyZ2h6UWFuVU1Cb2VmTGg5NEo0bktjRjVQ?=
 =?iso-2022-jp?B?WmRGQTEwTm5VQ2lsUFlpaXNTaVlXK21hM0hvR1hOUXFWVjFtN3lFYzFI?=
 =?iso-2022-jp?B?bXhjUGtkZkk1ellNNi95L29QY1l4eDFwbjZqMVVyR1VuV29WS0JEa3lI?=
 =?iso-2022-jp?B?OWdFN0MwdWdnd2VXN3g4RUh0VkJZcGlJWlprTWhQaE1jMlQ0blVkcHJo?=
 =?iso-2022-jp?B?aUt6b2RPQ0t4WkxSQVlHcUFYK1hpejBJRERsWHJVMzBLbGZjUFFZa3VE?=
 =?iso-2022-jp?B?azkwZFowSkR1UXRpQlpuczJzQXhKYWlJVHVVZS9YRWhQM3VEK0pDSW9S?=
 =?iso-2022-jp?B?dTZRZEZaL0FKNGVxRWtWR0JRMCtYY3JiVGk2RC9aOVNPREMyaGRhZVVa?=
 =?iso-2022-jp?B?U0JmdmpMZFgyK2pkTHNPQUYzWVQrQmRWTStPcE1rNXBOcittdk9oYmx3?=
 =?iso-2022-jp?B?QVJFWHE3eGtLUHQ2OWwwUFQ3QlpMU0ZGYzgzanFTejhKV3lQL2lDTmxu?=
 =?iso-2022-jp?B?Zks4VE0zUHNhM3FDUjhXWllHQXpFVEU1M3RQWWF1SW5wdlFkcnNUYmwx?=
 =?iso-2022-jp?B?TzBhdldhbjFDS0FNdHlQcXhmeTZIamxlQzE1TUhheDNROUZUbTNpNVY2?=
 =?iso-2022-jp?B?VFpGZm1yT1RWUzJsLzRPM280OWd1OHlHZUF3NVNhSFd1YVZPeU9OeGpO?=
 =?iso-2022-jp?B?enlKOUZhdmVhWDB2bmVydzFiL3pUd1I4UTdSMDBkUlJRVWZTWWZnN2M5?=
 =?iso-2022-jp?B?dWdMNm0zNWQ3RXRGSlZZdmNnbVV1dW9qYko4OFZQQmY4d2NRcWhNUjV2?=
 =?iso-2022-jp?B?U3p2NU5ESzRpNkQrL21aVTVYaDk2Y1lvMzZidlJETzlCSjBoNjYwUGYr?=
 =?iso-2022-jp?B?RFBnSTJSZCsvMHpvUFowVTNkb3EwbGJUZ1BHeUJzQTJaSFhHNXd1TlNU?=
 =?iso-2022-jp?B?YW84djNYaUpXNTYzM3BTTkd6QnZaSnd3WnFGWDBJUnZlQWdhOTcxU0ww?=
 =?iso-2022-jp?B?Q2xDMXBOWDdGQUpVWmw3SXRZeDJSQ0ZsNUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gUUTebAJR1dihGTyM5hA+2kiWIx9jj3v5Zug+QS9na5frUpSFebEhxwAmF+8TOH79x6L03oaKb+wWdRHwWOSw+c+/h/o4sHlyszTYgNlb5dhvNNf7T0FvZLtxKZSGvw0xMQFRlcjULrTF8gPXPNGAjW/EydkHO2bqC5PccGZgeSngFTFMmSnih+K2L6G5/YRTxRwzX22/n10x58jXG8yJMVi5UXEunhSbtPdNgEgDs/eqDong/Icfv+vM8sTaUAyM7cXctH3PqGsqxYLNAMEGAgIFKRrBIvlFpTRDq4gKf3S/dvAsjRYYhFmri4TbWaWCCkkX5mQM2vDACSdIw+ArnsgsoURpCUCxltRWILJCx9xTqo2xhiFyns1ugZBGMAb3HF6R6vJqDIacwdJ2RnlI+z+NnWe96Qm2xVz5IjlBAV5WZ32QAf9TE/r+wQyaenpIlXEj29PxXAvWrFqkwqmTH2psq1YakRcYH1MWa3r0itA/D3rLKeDIjiPBQ1ShqdXPiMjnDYcjheauh1FWMv+Vm3ecsu5hPBTe/Q1tTDSzeogIpk7DJqYUgFOxMYyyZw+bo68NXJy4eMw9b+tyI0qot3y6WqfFlt6TK1Z7d7ZvSjuXWd/F/53Gp1rV9ivkHNYuIQ1o241prgiRlxQzx0zqpIsREfb/YqeCfqOHBtZequwi7QPCFCE35A6xJpcgcTlLSo3Owg7zhpTkY7C2nn53hkrKzRQhN/oqDeP9mXuuWELK4/Yo2WsO+0MFl+MiBYp2O1eObAy9EdCsc4T6AdzZDbHBbpvxUvKASJXNFbavzjqxDH1Dc8Znz2DdcU6rg9RiV8l5CPVsHWI7x6bnP7MR+ZHKfdXerIJEoTrSn4ejMrXd58FWagC6Zrs+HGh4a16nvzH9kpxNevF9qP/9e49mg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b42d38-aa77-4aec-5db7-08db7db82514
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:30:05.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUp774Ub8pqvG53lK+3AzTAg8YWY0ee2ti94sbXhUKj+1FpNpuCdBWwmixCEsRPq6o2An1l32jVCtXHo2QR8Jk0FKe0XonqwHwyA0KGXgisAJvdarZTcNqrzgxDnGdiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8159
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12239

Hi Fabrizio,

Thanks for your update patches.

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Wednesday, July 5, 2023 12:35 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip v2 0/4] Add Renesas RZ/V2M PWC support
>=20
> Dear All,
>=20
> this series adds support for the PWC IP found inside the Renesas RZ/V2M
> SoC.
>=20
> Thanks,
> Fab
>=20
> Fabrizio Castro (4):
>   dt-bindings: soc: renesas: Add RZ/V2M PWC
>   soc: renesas: Add PWC support for RZ/V2M
>   arm64: dts: renesas: r9a09g011: Add PWC support
>   arm64: dts: renesas: v2mevk2: Add PWC support

Looks good to me.
I can apply, if there are no comments and issues.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



