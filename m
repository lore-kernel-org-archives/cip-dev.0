Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B53103E301
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 01:54:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12424.1773280464743568566
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 18:54:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=b1xmAMg6;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773280460;x=1774490060;bh=C1gqEbzsG27Oe4fYjO6UtZ+nsUBF58mKTHxMv
	dfH8x4=;b=b1xmAMg6MTKRlphqxbn+3xq2edpnCXLpOdC5PJQKkJ8qiln9l/xRolszIXcPvNPYHMA
	wthAekpH7YpusyzuXEyRzIQS8paCi4FqXV4K65XWtQKVTqggqX9vqfbEWl1E1DzcbJnI7K2GQhc7h
	f2VkXMgQbj3aLO0Q4BPV4079jTh3Ny27vBj5R54I8TtfiDYYXKOYKH2/HCLCqnyXlSWJRiMCrtCej
	1AusOxq8CP9EnWjp2RfS5ftEthtSaVcMUw+NuoSO0oSM4i9d764e5OLCAr648ie+IA2qkiY2zH8rE
	BlaB56pTwPbhuWacHK6cnig8eaPX67lnhH59DYU8ZA9A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 62C1sK9D1017846; Thu, 12 Mar 2026 10:54:20 +0900
X-Iguazu-Qid: 2yAaH9EEFbYn5IKUEG
X-Iguazu-QSIG: v=2; s=0; t=1773280459; q=2yAaH9EEFbYn5IKUEG; m=YQpUm18oTfCflTKeuhn9hPPQxQhuxPSIcrBSIIa8y1I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWVzH1y38z1xnc; Thu, 12 Mar 2026 10:54:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxXPNqcca0+OZITSm5uP90TC9UWTeg5KSrA2hi87e2629+ECiBUU/upD6loO7YK9a9xMmskCoSXxJPwA9/s2qBsPDVD414MzUQUuJmgzsc39yI86mOO4LU4fmD7rNVem4grxO1i1cYXshQ6vQEgtJPspJYR4cppLcJek1VNV3NwqkVdD9rtnbe6melMobDTdG5GfjrNqD8GwEMFiY42ospVaEycsDW5mitH/6tpSI22aVJ9XdXAwh75MSGGgJ7CiYSF9w0hQSO1fsIE/DwZizNGuGebehlJ/63qiOFOiLrJtLO8jdjcZkYFkd9bI9yo+IUnySvgTZmOrW0ukxQZpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT04XREe6ixT4RgyzkeprK+4B22jbdVcMHmTxYPKFpo=;
 b=WlB1LmyWf5QuImkKHvQusbFvBEb2Ivh947a28FXira5/ycvtA1uXAGTxiiRheBn0sukW1MRVNpjejGlQjs8w1MExbX8mMfHFJhWK9zujtaRxfNvwznzApzfO7mAURZTvhHOjDF9To8AX+bm5Hdj5TXcVT5gGGq4h43N/Y0wIc5hcKBsIyzqBfh522rJDk80y2svBQo4CuCaj1uENl1VTM6+Un/2SRxJyw3n48NYQb237qUYnIJ0iIbyeewMVY5bccjDPN0j4T+4RX5bIMfgy3McvVZr/fKa2/kwGxSvZokMjryVYlYYZN8+7hbG44sy7Mof4oh3LyJWAgADxxRtZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/6] Add suspend/resume support for
 RZ/G3E ICU
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/6] Add suspend/resume support for
 RZ/G3E ICU
Thread-Index: AQHcr5xdkfnhtJql5EKlFvfgX5VcDrWl24EAgARLXKA=
Date: Thu, 12 Mar 2026 01:54:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818911AA2C463A61E251057CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
 <aa6CbMQ18Zflw2Yk@duo.ucw.cz>
In-Reply-To: <aa6CbMQ18Zflw2Yk@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB14870:EE_
x-ms-office365-filtering-correlation-id: 83cdff62-d199-4e99-139c-08de7fda4325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 CrcMIFAEH5zEKortPa+b9wtwIbJOFotGYH4MFI13T3VFH92Sk9lccM7yw9IfKzJp2zQ2oDsScBahn8xX3fneJ44kj1QDTHupsHoI/gz9MNFc3WWCLWFOzWlBrxCYBfF83VUDWeWSzPMMPRvh4XLSo+A7wx263Gkr+9N/kEg+mtI8FGnCmX8oD+HzwNwn6Oz8pHu0NOqiF8F/ao4OfxT11NNRMJth7LNAfDofwkm24FqNKHkKZnfpmKvebOL2Rt2lsB6DLy2OtpOYr8W4edT9e4ohRWqVXMfmwY+bbDrPcMNalIgXA3bgmhKgvldvb1IG5oIRYICyd2mqKo1zQYz+2UmYx5l4KC+6iKpEztGVEnFBVDfIQo98JhUgzgQWTihu9j9CQ3dbeDRo8AHBf2T0ugv4zhEnr6SQBIEKPj60nEGEE0nhX4bMu52lN2AOcI7B4mFIFI3BmL524lJeQwa0T3TC0AmLbkKJ6S6cu7ViK6LDyK6qKCjn8vF5CA16TI3MBEWpwLkMq2rtmuqcsroQtB2skp3TW3iIOmsoAn4vEtyNoFJUHJG0Bkq+3bXVSf7McbvQmJ1oq89amTXYQKkQtkaxdDGKzIXwFWbaqJctAR+0IQ9NJfueyyh7mpqFCkjdJfdWFnxO7vXW6i9cFDtaV76anWtu8/uhVvTSYPfM7O6Hsey9b3bJIqobhtE6O/Qn3Zy3X0u1NLB3CLbqZ3Mef2fUz2aXH9DD+a1gJAwIYqPwmG9ZVrdQyTTsJ1shMHPQZ8zSPHGQyfbPxZDhtUAMw9xm9XlXGhe9BCBR55ksfdc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bms5ckh0bzFLbVMyMFdIT01OTnVjNFVoREdqanp5UVFFZWJuYlV0eFpk?=
 =?iso-2022-jp?B?QjIzWW9pd0o5WERuVU1SakpsUi9UUk5MWkdmUUlHZXVueTRJa05MVmFq?=
 =?iso-2022-jp?B?QU54UG5HR2ZYV3g5RzZ2dWp0OXl5SS9VU09jNjhjc0s5V2x3dWF6Q0Fu?=
 =?iso-2022-jp?B?ZlcxNzJVbXcvdHFPV0V5dWFqOG9zYjhZcFZkK2xlNTFPT3lRVHAwSWlM?=
 =?iso-2022-jp?B?K3J2SG80VDBzSE1RM0k5QTUzTU1SZTlsTmVvSzJBZENySS9FQWRjWDI0?=
 =?iso-2022-jp?B?KzVpVUQ5UlRuekZJcmpRd2IyYlhlTnhTTEg5N0lldHRKQis2SUdleWZB?=
 =?iso-2022-jp?B?b05Fa1ZCb1k4b2o0VHpqRVp5d3AvdkcrdE5Tb0xETGdSUFJaNkJIa0Ri?=
 =?iso-2022-jp?B?aVhpTGthV2VDMFFsNWZQWVZCOGpHMjJ6SXlVS1h1SE0rSHJ1RWYyTUFG?=
 =?iso-2022-jp?B?ekVwTElwRk9IcytWMDRGbEVldkI3UWx6NmV6aXBYelMvcHlBcEdISEFP?=
 =?iso-2022-jp?B?OGNnODN6MXQ0dHY5V3ZXZnpPVTNWdWhseXZ6WVJTQWpRVkR6QjVkZzNS?=
 =?iso-2022-jp?B?Ujg0YTNNWkhIOHlkMWluSkVFTCs5MlZHd1E3bXFKWVNCY2FqT3JTZ0Ns?=
 =?iso-2022-jp?B?OU93UGxQQnQzV0hTbmNhSTdNQWkyME5YSmJsODRYem14bHZSNWNCNDZz?=
 =?iso-2022-jp?B?QVh6ZHArMkNQKzNDbUFvc093T1hDUnczZlJvckNCVVdEbkRSVGVTV1Rz?=
 =?iso-2022-jp?B?bnJySTZVaWVmWmY2WC8xYnd5OG1EZTNVSFBrdXhJVlZwVXhRSEtVK0Fi?=
 =?iso-2022-jp?B?bjg2Z2pxYnZkZFdQdnRGYkoxV0tpYTZCZUsyV2dGc21KVFNROVlhdXp0?=
 =?iso-2022-jp?B?cFY5c1JsaEMvWFV5Rk1BbmdiKy9HeCtadVZXTENwZ2g4SEhFd1FNWTc3?=
 =?iso-2022-jp?B?UmlZWGk5UHhlMXFMUDlSeGxROXRLVWlqMkIwamtMYVBlWjVKUFFaa3Zn?=
 =?iso-2022-jp?B?UzBHWHRMY0tQa3BUQVNmeEhyUk84Z3VncDljUTFIenJrMng1WGh6c0c5?=
 =?iso-2022-jp?B?M001ZUFtN05ZZEt2alhLWFNTSkwyTkJqNnNFMVRoK2tDSm92OUovSlVQ?=
 =?iso-2022-jp?B?alJlN0w2dW9vYmgwSlMzTkpTREs1cTd5Vm9FYndieFFack5JMTJYV2hQ?=
 =?iso-2022-jp?B?dGx1V1BSUXJwbzZCTDAvRFBBRXdXVTVPZWFzTTE2WElzMGM0ckxXSjZS?=
 =?iso-2022-jp?B?dTgzQlJTSVBlbmhTZnEvL3duVFBUNElLOUNGKzJUQWI3U24rT29Kenh1?=
 =?iso-2022-jp?B?S00rdk9BaGw3b2Z2VVI3YmxmbUw4RkhYcjRWYjRiVFNEMWdPVHV2WnMr?=
 =?iso-2022-jp?B?MUNyUW8yQnRmYy9WSUtwSGpwQVVZQWhISnQ1dlZFeTN3VHlsNld2UWNn?=
 =?iso-2022-jp?B?Q1NXZlE5cFFHRTl6bTE5cmtXb0Exa1NTQVNldG10bjhMS1d3Mm9Ubko2?=
 =?iso-2022-jp?B?dGpnN1JMV01FaEo2b2FZTVhHYmlDWGdZdVJtc3hrbjMzaUs0V29zdWpr?=
 =?iso-2022-jp?B?L2NyRDdVa0VRVnZmOENwV1BlTW5MYStmaTMwN0ZQOVY3dm1WU2g2ZGt3?=
 =?iso-2022-jp?B?VzVTZUcyQW4rNkFiMlBFcUVEZ2w2eUIvamxLbENYQWpPelBTYWtNQngy?=
 =?iso-2022-jp?B?b0xSK0NTN2RXQmM1VU9neWZqWmFWTDZoL1hMV1p5dDJUa3dFcG5QWGtN?=
 =?iso-2022-jp?B?SFN5bVNXbzgxWUsyKzNnSk01Q0lORUtjTEVvcldLK091dFAyUjNQaVBZ?=
 =?iso-2022-jp?B?bndGTUI4UXpNbDlmMHIxYWNqc3ZnajJScWo3aExtUkpIWUExYi9wQ3hC?=
 =?iso-2022-jp?B?cVhWUmM2dzV0Y0QrY1g4NEhKTzJma1h2VVVpSFowVVh6S1VSdTZLcG8z?=
 =?iso-2022-jp?B?RTNBKzNtM1FnZmUxQ0pnN3luMDdDOTZ0bG0vR01WTU4rN3V1N1MvNlNT?=
 =?iso-2022-jp?B?a3NOeHZKWFJBcExqbkpoaDFydkdaNzdaakFpVy9ySGNQU1FCTjNwZWh3?=
 =?iso-2022-jp?B?aU1Qa1k2Vy9CaUtZU1NkZnJYSEZSWWF0ZnJ6OGJCSHFlc0EyMWx4Zmky?=
 =?iso-2022-jp?B?ekxNaFJ1UkRFWkR0cmNOU0tnOVFDSnROM3JDOWlFajN6MVpEYWptYndQ?=
 =?iso-2022-jp?B?eVVsSG1STGRMTkdPcnZPTklNM2NrdXIwRk9FdmhsdFB6WTlDY0JrQWpa?=
 =?iso-2022-jp?B?SGhBbjZTaEV3OXZ1VXorNTUvUWxtdVQxcS9uUlgyRWY0YUhCQ1pWOUFm?=
 =?iso-2022-jp?B?R2dLdXArR2RMZzVqd2hHSzFEVHNKUEIrc0JyK1lhMDZsVm5MaGNpa09S?=
 =?iso-2022-jp?B?eFNIU2RrdG4xR3h1dXluczcyUGhGVGRtKzVZUUw3T1ZPZ0FURDFzMzdv?=
 =?iso-2022-jp?B?MkR2OFlRand0ZkdlcGRSbjhTU1RkdUUwcTkyQU4wMzFzY014TC9iYTFi?=
 =?iso-2022-jp?B?d0RXVUtlaUlyVk9wZU1qRXVGSndUSjdlWTN0SG4rQkl0UUIrc1FSOXFZ?=
 =?iso-2022-jp?B?MnJ3UFVCQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	KfbcjApN0GZeTHBoroGcaI3DaM+JbDWmZr17BWSO4ZJhJhJVGvvf+DD/Y+ZtHgtyhvOWkUKpboKPWsucLrIMIkXB4TUogo6cSljGXg0EsEJldiSKRUvjiksETbORM51iBJT+WUCxcnXxtKQhb2utUPWCEgYkTpFEUNCxoxoLPT4Vj/eawp0/0rcw6mctsAXbLTDcnJS7MseI/98C5OGJ70Amewcr/9VTzdcBe9CjITuzNgGLnsUUfFXej1NoUgtiBynuUUkpYFBZW4pEjM9++Ok1iLYcweVdUke/tDMAPmmk0cQVaDivPs4yCj+s68StUT0ER/64nwKXPNtFTZXzkA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cdff62-d199-4e99-139c-08de7fda4325
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 01:54:13.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3t7at1me+9Bw3jyXFYPfTtbGnMRiN9S/tQTrkfMltpQtASg+IRlFUM6/yn9bMgrJc5Ujzj6/Kx4CbVky1iPjlOKNxOopBTtyXZgJ+9MUjUbeVKHaRV/Xj0U2wuDK48e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 01:54:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22348

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, March 9, 2026 5:19 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add suspend/resume support f=
or RZ/G3E ICU
>=20
> Hi!
>=20
> > Add suspend/resume support for RZ/G3E ICU(interrupt controller unit).
> > Also add support for CAN FD-Only mode.
>=20
> Similar to 6.12, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I will apply with Pavel's Reviewed-by tag and push.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


