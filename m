Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD28C38142
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 01:51:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.6352.1661305876847797652
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 18:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 27O1p92T003255;
 Wed, 24 Aug 2022 10:51:09 +0900
X-Iguazu-Qid: 2wGrZF6jKTdXw7S4ep
X-Iguazu-QSIG: v=2; s=0; t=1661305868; q=2wGrZF6jKTdXw7S4ep;
 m=Wa+lHyLfPKv1u/k8A8YuCX+V7DlMK0X0tSD104Ym3lY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 27O1p8n2029810
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Aug 2022 10:51:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY4sD+45XyhKBbSj0wpe2OquAz2tqkiMiqWNnYmbFdJZfi0tTykNiVz5lAJZ1GdhROxarbdJJN4YEouKvqFl1DHwgyX0R+J76Rst8iSV3LyOl02YqqDY+nq0R7N4pNORJltbKDIWv3VHokmegYRf0wl8dNFFAs569OGOXRoV1Hxnk6W/qUPOzJokZT3QCoI5vNi17Uy1cmX3Q1tMPKSnp1NG+pi7mP21K8Ic1DR50dxI5nlHB0UkPtBOGIdC46lsVmG+NnkTB0fTcZY7oPDlQ0ZLkmkyf0/pHGDCtJd4WyqFLTwiJKe7GBiPK9Dq/OzFqDU6U5Bj3qVNK8I7nbHVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjgH+gAIVmc0xQTtx7Avm0Y8vfvhb0QdlX/HixlhL3o=;
 b=IIBTkMi3PzM/QiojkiVmVaiodkkRkGAwtdeTsw98kt3r29SHFpOtIfjlCtNenUpf05PEZH1zBUh7CM/0kv51AZtWdXPfPhFIyS5hdFR2s/g2ZwN+j883VPF8fFg5GbhjYUEfwrAaDskKWJ2+D/DBKq3lBhDkbCwXdM51NI29NbsCdc18KK600ik1iK7DAzMbzScfxHBnlI2sTkS7EVnwgWiIq9a1AYrA5pyUpJaFqPwlDBybtrvw0b9ueoENnh6/2N1XjQV1naRj6Ic5UHq9qrHXB3K5+REkMTOBnXOJzBNP1Yk6cRc2FqQksOY2tPJ2wmRqfF8d/S9KE9kJ5FqHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
 Correct SoC name in comment
Thread-Topic: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
 Correct SoC name in comment
Thread-Index: AQHYtiN91o7Kn3wDgE2AlkVeUfQPvK2647MAgAJnvaA=
Date: Wed, 24 Aug 2022 01:51:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94203771A805DE23DB11635792739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220822123346.24089-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220822130628.GB16642@duo.ucw.cz>
In-Reply-To: <20220822130628.GB16642@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 263e6b5b-688c-49b6-9528-08da85731b1e
x-ms-traffictypediagnostic: TYWPR01MB10363:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ruZVLqirfLiR/703Q6So4rAFUVpTA0SA+8TJoWzWUEuO/M+lX50BZ0yiiXEKcHhYlppblcxsWEerJhnVslciFHws6FLBp85c7YQpFsCHjDnbYOgeFL078icbgLGQ3XB/b3knEctgjLrNDF4LHfHWjf9mXBaXExf0tW9CvTgaaN2vWjAEE5cdWgfLSCJgOOVrMoo8KDJZIwPOJNR5CoDayTYFN/d/9lk4qTbN90rWyQ+uRR/pfsNJb64+0mCupgokqWZm41z+k7vPe2Qeg8vL6l0Qz9I3ZPM/KpB++tQGgd466SHvAnwcUFkKyPUJpD1QIWjhvsvLggxtyP56YHGK7w8E18v+Ce1yq0m5E5ge0m26bMHiGgQsswLJ5G0kTlIl5IB3iS3pr1GIzeulbMhCOLzUyHl9rMPZfU5hjEFd0wKqOKWjOUMtfB5lHJobb9ivwGIPC0PrwT6TdMaufOUjdrRWv/GCaElLE4F/YW+Z0mc20aACH1LK0rTGaWHMs5uJ4B28znlpfdzUGr+6DL5J/7DkLzhipZg+apebW+4X9NYj0QsPNVrE3Zk/T3s4BGhhTfws3hbKucGsTG2ZR8CRpGabgFbaxyuKELB4VXm2cG2WGqYBsyXtXpV1UPpzhwLN665IJA36dutBLGrW3p13DC3p/1eyO1POwLJjO3SnCopaBl8m1xECTTujeteGmXk+4BDdx/CxoAVHy3cPD6gX8HoRgvihn3xnN5Y0pFSZoVOwXKW+D1ldcTTh5452jd1kUqLfpSPG+n9Qnay+PBw0pmr0rAgoFCMzumkIl0Mj4HM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(71200400001)(966005)(6506007)(52536014)(41300700001)(478600001)(83380400001)(186003)(7696005)(9686003)(26005)(53546011)(2906002)(8936002)(4744005)(55016003)(316002)(5660300002)(110136005)(54906003)(66556008)(4326008)(8676002)(66446008)(64756008)(66946007)(86362001)(76116006)(38100700002)(38070700005)(122000001)(66476007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MTFIdUZDbHVLV3lmSjJCeWg2MTdZNFB6M2huNThGZlVaMFFNMU40eWo0?=
 =?iso-2022-jp?B?dlVCSDhTc0lrYlhLSmJoaWF1M01XK1MwQTBsL3BLa0hpOFBndXNMRXdp?=
 =?iso-2022-jp?B?UlRqcm5WaGhWbVp1VXlYZDJ3dDFySTgvbm5YY29BdytBUGl5aDgyYzhk?=
 =?iso-2022-jp?B?TTdLSnBEeVd6RnoyZ0paNTJTQ1E4bHNTZ0U0TTVSMW43MDdaWUpwenFY?=
 =?iso-2022-jp?B?RWVaVEZLR1RSN2xyYnRtdFQ4WElERklGYU9kcTNSSGRUZTRPQmdQQldq?=
 =?iso-2022-jp?B?VWRxc2gvZFhjVFZCSDRacTlpWWN2N2xSNW5IMEJsUGxOVDFLdnczc3dS?=
 =?iso-2022-jp?B?SXViUGZnTXVjdUhjV1JvU3l2NXVXNXRaTjhGeU9BRE9oVlp2MXNEM1Bh?=
 =?iso-2022-jp?B?TXVPMW5seTI2bGcrVHBvdXpMUldMN2Vva0JRWFlyNjlzUjB1VDBPdEE5?=
 =?iso-2022-jp?B?dmZoZUprN2NVMS9yZW5FOHNBNm5qZVY4eHEyOHZLYTdkWjV2VUVOUWo4?=
 =?iso-2022-jp?B?WkE5K2ZibmhHNVVGUHZJdHBOMjgxby9SVitwalJmUnJpV2tXOU1FUnB4?=
 =?iso-2022-jp?B?M1RuMjU3Z1pIcm9wWWdkV3VNTC9QUy9oNEVyUWpOYVhFNnVCVitSSUx5?=
 =?iso-2022-jp?B?UkRwWm9XMG5vTE9hWEFlZlk2R05NSVp2WmhiY2loclhEei96Mm8zTGRk?=
 =?iso-2022-jp?B?OUJOSTJPMTRRdVIwbWRQenRvdjhJcjdHZGo5YVd5dDlBSEUwT1FmVGtk?=
 =?iso-2022-jp?B?OU9GNnpvazdLcWZDSUEzT2J5TEw1WTdTVDUyNGczUDc2M2cxZlFONXNC?=
 =?iso-2022-jp?B?WnExT2crZndpVG1qdjc1MHF3SDBTU2wxUWNjWVdnUnZqL2RDdURPa2Ur?=
 =?iso-2022-jp?B?Ny9JWTdFeTd1NldFV2l6OFNPSmRtSzhBRDRQRlF2d1FPdzIwNjVwWDdW?=
 =?iso-2022-jp?B?aENoUEhWMmZGclhkclhaWXpQdFdvZ3BReTZmUnhFVENnR1poeWZpb0FF?=
 =?iso-2022-jp?B?RHhqZDZwR0x0T05vVGhLS1ZMU2FBVVd2UTEvWTQrWkozR2wxdUM0b0Ft?=
 =?iso-2022-jp?B?UllBYXNrcnY3SjhJeWZTd053Q3h2aDZ6dG9jQTNOOFJ0d3psdm1CaEpa?=
 =?iso-2022-jp?B?MTdCRmpzME1ReEpjZnRGWCtZT2ZTMzJaSTB2ZUNDSUpodTJQM0RucFJM?=
 =?iso-2022-jp?B?aEM5VTNEVnBoSDVFbkdhRW1wekh6WGtnN29ONVRhaFE4dHV2ZG4zMHFK?=
 =?iso-2022-jp?B?TkFlenBCWWk5S2xmTDI5MzdQVFQrQjRjNVJlL0JkdmUzWnZJNEFZOEU2?=
 =?iso-2022-jp?B?SjdFTE54OHE1OVByRWd1eForQXB2UUE4Wjlvc29tOE1USkEzYWxoTUU0?=
 =?iso-2022-jp?B?RHUwS0t6MFdtbkx1U29VUWZKdTZKbHcxenB4YTMrUUlPSnhQTzkxU2Rl?=
 =?iso-2022-jp?B?MkRjcFIyL2d5K1JkU1VBUVdHMGJEVE9NS2xXalgyTFJNVDBydWQ4bHlH?=
 =?iso-2022-jp?B?LytjM2RJN1IvOSsrMXZCeWdibHJYMEc2Z2lyb1B3MDJuUjJyeHhXMGs5?=
 =?iso-2022-jp?B?cFBNU01rTW80U1M4ekVFZGtkZmwyYmZuaHhDbFpFK01JUzJhdThzbWN1?=
 =?iso-2022-jp?B?cndlaFVIUkRwOFRyMEk3RFNiWi9nK0wxQXdMTWtueTQxZTBwYWQzSFBD?=
 =?iso-2022-jp?B?RHF5ZHhuamt4a0xYTzRjUVhEZzJUS3lxRzVSUUFrbEh3K1lOV3pndHVr?=
 =?iso-2022-jp?B?TjdFWC9oVmorNVZMYTJKQWxpbk05QUVOdURheExVY0F1YWxGNHlISGdl?=
 =?iso-2022-jp?B?K1dFa2IvUmRpczlYVWo4QVo4akJtSFp6eFYwMTZUU3RyOE8yNkRTdTVX?=
 =?iso-2022-jp?B?d2Q1RStoVThXN0dpZ1hWN21lZmFJZllGenlEZ201S2ZjdFVTa1hwY2lS?=
 =?iso-2022-jp?B?M1hSRExMb3M2YXU3MEdvTDZEb3pKL1F5bnJITDBEMGJhMmEvdS9tbDc2?=
 =?iso-2022-jp?B?Yk80ZnV4NytzakttbUtuK21JaEhsMUtrdVRkMCszdm0zeDh3WkwxVEN4?=
 =?iso-2022-jp?B?SWFtSTVBTUdsQjF4a1A4ZE5uSFVWY0hmbkNTc3ZUVndTQWxwaXVkVC9Y?=
 =?iso-2022-jp?B?RUc1a0JsSGxCbXdoTnNqWm5LdnR5UTdjUldWZWhoNDBOWVB5V2hpNUFt?=
 =?iso-2022-jp?B?ZUhPb0JmNEN4bGVCZnZISHM1T3phQVd1VWdGUXBNZkU0YjlqUDA0c2xp?=
 =?iso-2022-jp?B?djRTUWh6RmtNSk1sbFN6dWJ1a2gxTkE4SEFSeGF5RVhHM2c2NmtyVmFn?=
 =?iso-2022-jp?B?cmhGaGdxQkl6cGhHd1E1aCtYaHJDRC9ZeFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 263e6b5b-688c-49b6-9528-08da85731b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 01:51:04.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ErCJR5neJYIpovR5t5BMIv8b7BMlct5cLqafIaEPgO/1QklB4qJ/CZvxC3kDrhJXqkzEP5+hbIThEq+sPnVi8+IppkAJk2Bwfj/NCxi+RJ/HNHGpFdWW8HdQlS1pOMyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10363
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Aug 2022 01:51:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9315

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, August 22, 2022 10:06 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc:
> Correct SoC name in comment
>=20
> Hi!
>=20
> > From: Chris Paterson <chris.paterson2@renesas.com>
> >
> > commit d1273f541ab409242e08da6bb836bb564021274c upstream.
> >
> > This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.
>=20
> A bit trivial, but looks ok to me. I can apply it if there are no other c=
omments.
>=20

LGTM too.
I could not find Pavel's test, so I am running in following pilpeline:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/621098021

If test is OK, I will apply this.

Best regards,
  Nobuhiro


