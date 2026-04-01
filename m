Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291710F9316
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 01:30:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3259.1775007045730992110
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 18:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=QppzAPbv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775007042;x=1776216642;bh=UfUFEvQqm2x0AVgimA7h2Cj54f0h758YDy5na
	MmPINI=;b=QppzAPbvVDdZ8+RkXpHmj7PF3VdueU7C+KDoT6Ds+nwH7lWck53if+qihuJxf3AF9l1
	O9woHnfg5gCG9FoRVFm4PGjNXZyTEn3Ozn5ql6eOVr7ku5qRKhnc8xhUwMYwR7DK1ryvP977RXf2c
	iPMVWUGaw5piGFF6K1wC+k88Ov4jfnMX2DcQi3w0xCe0Il2xSaETuLnkoOTpvy2KOui1YkOD64Nhg
	QhQBqWMd2mzSzSEEvJzlw2oAAKhGEy9ICve38ROlFBYB+xDNjeBOdpNFTSmsFp6JoONH3g97eQ1Zf
	kq9rnNQZjO8Lv8dDVPGNum/e1Dhd7vYdl5lwaK23H2Mg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6311Ug0E2333521; Wed, 1 Apr 2026 10:30:42 +0900
X-Iguazu-Qid: 2rWhfSiM73Zh7vwy83
X-Iguazu-QSIG: v=2; s=0; t=1775007042; q=2rWhfSiM73Zh7vwy83; m=OQcABvFGXHwg2p58dsHNRQDUweRXc9VVoCt/La49Lvg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4flnVp018rz1xnm; Wed,  1 Apr 2026 10:30:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3H7MWHAgDQXFHXKWl6oA5z4hQcDDnYxMjCsvriGKhJWgDhRWybRY4eFGxMGko8o/vXY+prwf6FSl91CwXmWsFdfPvko6pzL4TrYyAr0kQ3wg1Ebbl7FRPNRltHPE3zVaTQwI270WH47ocg+KEX6efcb1K5N3k3TUov7tZ9PWKMrAajiuWeLek3PWFHwEPixWoBYMZQXUy2pcQp+QT8Lmu30JOvCNFXmws5QHmY/brCcNn9mCdUV/wwiFfpu/E6EPnfzzWSGhcd3FuoM4xB38HVpRN2RE7HrQOOSrH/LifNKWLUPljDoVr7nbbZWOvN8L/4gjs9PHQTGjk0m9zJiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKmJPxdV/8LCt8R7JppHTR+4VwCEJekWyaS+ZFomgY=;
 b=CWZlUL4bUSgMCBDjwhvat/lLPN627JUkw04TCoadIINQIIvXa6+G1Iy45KiDkKVfg6cuWAG//pVkF4k2YddOUuplGe1k5HsTNVZ234Z1DxT1WA8fQ8+8xkr+SgfLq9higpgHTflLH9FWINSr0YxMEbS/4DhST/tur9AZjEEAjuHzDZhFRCAwa0h4V81g2E9hQoWijxtCjzVDscA6RJwQyBqsXgtluaULhJXHFcErWiLEfK/hsJV2urpz+2kltxo/z7KjixONZZw1nM8el4EE9A1edBCB32g4FpdHkiztghaHKjmgIl6od6eN6fz6WOsFiTuEzi980H13tpF7uf9G2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Thread-Topic: [PATCH 6.12.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Thread-Index: AQHcvc4R6PWdtoFjOkqh7lmILBPjbbXG5DeAgAKOUHA=
Date: Wed, 1 Apr 2026 01:30:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180DEDB0182EAACBA332A7CD50A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260327094231.34974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acpQPSbwftumR6Ez@duo.ucw.cz>
In-Reply-To: <acpQPSbwftumR6Ez@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6923:EE_
x-ms-office365-filtering-correlation-id: 3d506fee-b9fe-4894-9bab-08de8f8e486f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 jU1xzHZYLZHnbQ2ysxogjaf9sYF0ZKObmo6S0dK07uoJzDU8JbQKtgZC5W35dReZ0ijlR5OUXHyVM5wDrorRHIgZXWpjJQkdkOTnD4Enorkv5O4AMY5g98HczisMCrrLG7esehQSYoyaTbehajg8LBlONfyQ4k6TzcNF45uhmrsMStHd4ZXCvnIoJX1iotyPkXet+Tg2uL+NuMehsFdT8WWYuZWR7Sij+lgH50QeA4niyO7BIVFSb6UsMPxiP68wkrZJ0oLRJQXawJIOKERdez6PzM6iL9QvIWznlWTOg/8JGqxxqzHQzY1FOvqhL0pe2DUjTOfQ3Xcka3rOunPYYftGPs9hN1+G0jsX+FjwokkKcvvDIq8rlBP3XqOBikPdRIQPEOwJ0dyKcD7FLjNfaaI5WKlHItqcVD3gZUdpT/qdBf1xm1Gu330chZ4h08S2atzAB22xoslQNycYtYSILvILR8+o7uogNIGAznQDEAxdIlRS5Pw3XGj5bM6O+JUePY22DG+2DzVbM6gq2GoiV30ugdparXalV0+dkvALIX0OyVsGKYhR8/n25aIAP0WZn4Z97LH1LvdJf8hLL4hCc3MIccP5tAlF8cslER3g7YoKDLYkLh5RB3aa5AEysvqXIAVcZITIKw9la3OFc1ftz0fwuWsWyDS9IenCEMkG76zsUph4w8NuOHmzX9k/CSGfvuTV6CAulT6Pat869XHEvvXAbFGP/yiQu2eAsO+tMCeROc2GTU16UkKu54uOQJbHKjP9WpC+50Tj/kCzcxdxUfC134PDBv2R+qeQOb8Bhlg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0NrektSNkNLR0IvdlF0REFsNGlmVTlrSjhPTmFhM1BkSE1VSmhVcExi?=
 =?iso-2022-jp?B?ZmVQa01ISU50WUFzbER4NVkrY3BxYW5LZzFtbE9jUVg0d3VpQkYwL1VQ?=
 =?iso-2022-jp?B?bzVlWDBNVWMyUTRWYlY1eVZvcHNyY2VNNlhtTDFDdG9FT216ZXFXTW9o?=
 =?iso-2022-jp?B?cm1IT1l6OFUybHE4aVpNaDJPREVScDdPQU03VTlybXZhT01EYWUrejJP?=
 =?iso-2022-jp?B?R2toL2p3UVphdWFaQkcyVHpscGhidzgrQmd4clp0TTc5VE1lTUdXcG5C?=
 =?iso-2022-jp?B?Sk1pb2hscVVUKzFjY3ZPZnE2ZmVnK1U0N2Job0RYTGk0NmhZbnUvZWtm?=
 =?iso-2022-jp?B?Y1NSWDNxZW5JdUxubGRzUktKNUhuUEpBRmpNSXBlSDRPSFdHV0dVVVp0?=
 =?iso-2022-jp?B?ajNYVGV5b3hTOXN0c0NyT0RZbmhVbC9zMWNyb3FKQ2VCTHRtSXdvUzB0?=
 =?iso-2022-jp?B?bzFOS3RUTlE2R0NqbFBJZHFBbkkyTFVocnI1dkJBNENvdXdZeGEwellx?=
 =?iso-2022-jp?B?amE5bThqQzJlb0tjNjVnM1I1TWpHbkVSSkh6Z0piaTlLVE9GOFNCelU5?=
 =?iso-2022-jp?B?bXBQcjgxdjdrTHZIbloxS3R0K3FtWkVtTTZvSVMwMU8vYmNUeXFFZkVY?=
 =?iso-2022-jp?B?WlpuYkJ6cUdJK1hlVUkySHBJNkpqcnVuNEJZbkc4Y3ZmbDNVeE1YT2kx?=
 =?iso-2022-jp?B?M0VjRVQ1c3pYaVJBZC9tWmh2akY1VUIvQzZ4YjhPK25DWnNxQm42STRu?=
 =?iso-2022-jp?B?U01qdkRLN1FESmNiUWRCdC94VVkycElpVndmQVpwdEFwdVE0QXErbVUv?=
 =?iso-2022-jp?B?a1BCSE1KRjNTb0VIcGdheGZxYmxmeVI2eVM5TUtBVVpUMmx3Y1ltNzNI?=
 =?iso-2022-jp?B?MGh4MjluejZtZE9EWGRxY2VNNXlEelF4VSs0VFlpbE9iR0V4MFgxVkhC?=
 =?iso-2022-jp?B?bklDS1RScTI0S01ieWJ4eTdFSDRWdzZrb1dkb3I1enp5Z1pTdmd6SDRk?=
 =?iso-2022-jp?B?blhzSW96WWZZZ2kvZitDamRVZ3B3b05oZkcrRWFISlR0VFYzRG1pZVZ6?=
 =?iso-2022-jp?B?RzFXWUltc2w2TURVUEpjSmdnUzBoNkUycGdNMkRaK2g2WDhwUWl3MjNr?=
 =?iso-2022-jp?B?VVFpbzd3eGdXOUJEM1FQbEhFUjQxVWhaNUNxM055dkZ1YmM2WUJEVjh1?=
 =?iso-2022-jp?B?T3huOUdHaEYzQXk3Zis2NHF2bEF1aElMZENjYUd0d01FKzhsUEhrTC8v?=
 =?iso-2022-jp?B?K05rM21HRHdFTnVOeU82NFhlTk9PbGpRQXVTdE5NNGVBVVRsVENjdFgz?=
 =?iso-2022-jp?B?eFlZeVlFWWZ1VU1palR2VG5QeXZoVlJyd0xYR3VLVkwzR05XNGdGK3pJ?=
 =?iso-2022-jp?B?empVcU5vTVlHRXBEMVJ0Sks0ejlxdVpkL1JrSk5NNlcwUTZyRkQ2UEpP?=
 =?iso-2022-jp?B?SHo3cnhtWm1mc1NTRUVRb0p0WWQvT3MraHl6UDFvWVlLSWMzc2FBRm96?=
 =?iso-2022-jp?B?QjZvZy9RMlM0ako4RVRaZHBBdmNIUElvdFY3dkpRNlZqeXFQREtlekdM?=
 =?iso-2022-jp?B?c3ZmVjlHcGQxc2tpOUIzVEhTOCtvRE9kRTAvWEk2UytjUUp4ZVdtMmRy?=
 =?iso-2022-jp?B?cU1ENXAyUm1rYmVudlpiR1ZYcEsyZHdBRnpiZnBGbHVmQzIrMzVWY2hJ?=
 =?iso-2022-jp?B?dTdFUUpscWxicHgrcDJoRC9uemRHVEM5d000dzBGVkFkRlN6TnVTME03?=
 =?iso-2022-jp?B?MjZVMEpidmk3dGdiUUNZRFdOM2cwRmt1ajNDSi9zbXJzOEtiaHRnbFVu?=
 =?iso-2022-jp?B?ZVRVZTV2QVRxejN6TXBnMlZ5Mk11dmpQVDJzWkhXbmsrWUhFSG1tUjE2?=
 =?iso-2022-jp?B?Vklsc0Fmcnl6UVhHTnRkMzk1RjZnTW9IeE5TaHpDYkt6dldmVG9TZDkx?=
 =?iso-2022-jp?B?YmdiQUZ4RzMxcEhwL1FiTzNNTUR4MytkZ1dpeTJ4MUQwQWV4QTVDRDZO?=
 =?iso-2022-jp?B?bUloeWxOMFZpb0ZsY3pmZlFza1I4TnhERG5xWVg0WHlIZnE5bDR6L3V2?=
 =?iso-2022-jp?B?SE5icWVrNndVYXc3TkVjZkppam1uRXFLRjU4dzlDQnZVVkhHeUpmMk1x?=
 =?iso-2022-jp?B?VTRKODYxTWJhUS9LQzBFK3dLNmRjZlN1OUZUcHNNZXA0MkoyV2c3TEZN?=
 =?iso-2022-jp?B?R0pyU010alRPZG5xY0ZMNWk1dXl5TVlwTlR6K29OamIwcWtiVWlKWStH?=
 =?iso-2022-jp?B?SXVsUk5MVGhBV1NVc1ZLNTZoTlIvcEFZSk84ZUpDNG02TUZybDlCaWhD?=
 =?iso-2022-jp?B?T1lpc2FJc0RaMnVZWTRCbVUzdFFpcSsrWEV1SzgreHAyajhhVFpwSzZt?=
 =?iso-2022-jp?B?cnlhVHlUOHhTYTJQelp4dHBCSzAzZjUyZ1I0eTlmNlIwV0FmMVl0c2Fl?=
 =?iso-2022-jp?B?WDUrOGN1VmtzZXBYRVpzSGtYK0Q3S3NFNWlnU0FXREN2OTdqSjRscnpG?=
 =?iso-2022-jp?B?bmxCR0plOFRzaFU1dE4yQk8yMTA0UStzaEo2MjM0UlQ2MktTVUNieTZU?=
 =?iso-2022-jp?B?ekx6NjVuUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Rov9eVlzDH1th8qbvXKxDDPpxPlYU0h6Wd3NFalxLGD0TguV/Df8kP0gBLplPbG2XFQlrwsQWOLGHylpClZgXM8I0fnQejpTZDMmrVnBGTpVSeHRzhe2C62pL7hRW6MfI8YeO4ktmO4Qhynk3hiEJlKI5FBtlwRsC6UgucJOsjq/skpgh6ve/xUey/EtyEIYMTibWvihNb2wkYo3pGTINY+fnCcxKdASznbUFTRKL78PQ9M7cOo6ic2trXm4nXPXSxqeqFhEqJFk4XMYnfDNaDKTzGHNRQbj/4oJXydQmaPwyBhCCmkqQTmClHsg20ek4AndZxRa/J39OxbbZ0q5Qw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d506fee-b9fe-4894-9bab-08de8f8e486f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 01:30:39.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmo1CKU/h7CZdIXq1s6dilD+4fCFtnEh3QuCKVdsutd9t6zvvYcW384Er+YT5qKiWP0OMtTKr8J3r+avV3WP+Q69Q8LJbaecFmIlliSudcUgggvF7ZKuNqNfaD9AnbM1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 01:30:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22610

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, March 30, 2026 7:28 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoC=
s
>=20
> Hi!
>=20
> > This patch series aims to add CANFD support on the Renesas RZ/V2H and
> > RZ/V2N SoCs. CANFD has been tested with external CAN PHY transceiver
> > as the EVK isn't fitted with one.
> >
> > Note,
> > - All the patches have been cherry-picked from upstream kernel.
> > - Patches apply cleanly on top of v6.12.78-cip19
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

Looks good to me too.
I will apply this with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


