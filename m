Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E85C7EE32
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 07:25:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.2928.1750749896969874883
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 00:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=biZCtUJK;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750749885;x=1751959485;bh=r0+6LTuZ6Aweji3BZq/Fd8icSF7hC2s8ateQkka
	oYds=;b=biZCtUJK5K39NV0bzElemoqp58XxZdDwwOTXWRKHwfa0O2vG3zQaM6WAgnD8c4Fs9T26i
	1R024OzZH7MTPqMAS5VqaiEhScWL6SK3CovC1rcpLIgZIwRPllQQyk8/8c/x4cT1mJ03bpFsO08xu
	ceHwYDGZZnj0fl9bvJms4QnOlHjZnj6pzU6wHnPgJX0wOsWr6QJAA1PwPJPVf+WVR+tKLLtZfhRlc
	8X6T202eOwnipz1D3yV19pGcniOamokGnglpt0U1kaIxE1FEWCtv3Vs+VyhNfLpiaJkFe8HLX36fq
	k2FmdSVekttBY38PlT1QumI3dyw7C4haL3XnsgB4FQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 55O7OjDk796010; Tue, 24 Jun 2025 16:24:45 +0900
X-Iguazu-Qid: 2rWhiV7hUOOSzxYkLr
X-Iguazu-QSIG: v=2; s=0; t=1750749884; q=2rWhiV7hUOOSzxYkLr; m=uwVFy2bDLTFxh1km5NoSeFU2yBAi6bC94VwrJzlhdVs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 55O7OhX11575623
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 16:24:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUsPf6+frByXjZ5nFkv0NAHTiDYYANJQ7xJ3QczOpEW5rGyoMRpTQq98MIopkZh6rukpiSuC7NkUsxZFadpbDpFEP1B2iNMMIbhiuDWZyXc2KqCdLIZX/nW8HGUo0a+Wr2Kt5yeDGIwuARzthF/rFJF4PxyU7JJ0l9hvFmQmobWH9/ns7ZithumcS0MH7l+JjKNmt0AAZ+TXrrfgeZ6zQxTpbOklkmEDjgFYfUocz+Zt6JDdiqRCDRSDxCXHK4UWn0ogxHgzyXc0A/lC1v+xwGkOIHKjsHWEhmcAmJM70hfUA3W+ydJR+896oVbOeEtAQB48TGCvC2PDhWX+fqnaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGwywBJhgLCtTi8YiiwnWzns/Gt15oGS2191Oaff1fo=;
 b=xqFCGadyO3GYo3DtVF/s2n4LOLHXhX74iU71CKCd1giOUAlaZcQ5fXn9jjX0LER3VA4WN8m12D7wPlwHfjfsFdWNHVkw2Zt3cHHyp8s0ZGO+jAXwW1EUIBHQnG6k2rhUc0Bq3qf/acBJ9DSXp7sMrqz7zvWh438lwsSlgfvMV5/nbX+WgRzDc4hhghdrq7r0xrUEVpW4MuOoC1qnBmqzB33NruaTGc8LcANPMC8t7DN5HIDrJmb4jXURdGw+paK5Lp990dK4Xj8QFvWLDuQrsDUO48BI5O33j/4YWl7ZcMNaJ+t78APwHYnu/7It3nwTMSvMDXnAnUxxcbxQxBd1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 00/17] Add support for RZ/G3E SDHI
Thread-Topic: [PATCH 6.1.y-cip 00/17] Add support for RZ/G3E SDHI
Thread-Index: AQHb5E27L/o4wjHhUUa/Ky55d2j8KbQR6D8A
Date: Tue, 24 Jun 2025 07:24:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481888A60B76147F355A71129278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11828:EE_
x-ms-office365-filtering-correlation-id: 5f30d7e1-a3a7-4fb1-9b2f-08ddb2f02ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UlpoL0F2dDhhd0tHVXEraUZWalRHWDBETyswZ0ZNTDczendNMkphcEky?=
 =?iso-2022-jp?B?N1lMeEdMbS8zYjBQZVhQSnBnSXd6NTZBRGFzWTJmYmI1S3VHM2M5TC9J?=
 =?iso-2022-jp?B?ZHlxNmtIdlhrU3FiYkpqa3RQdmdOQ3A2OHBTSjEvRzFGc1UxU3lJQzhH?=
 =?iso-2022-jp?B?RmVqN09ZaEJISWxkRXg4WEU3c2xuWDZJMi9lcjZjOHYrS3A4cThqUk9y?=
 =?iso-2022-jp?B?eWVKc0NlaWVwdEo1cHNDc2tSV3BPSUljRVIyazJMMWZ2L09UQmxRaFps?=
 =?iso-2022-jp?B?T09jT0sraTZhb0FmcnlwTVlvbHZkN3NBMW82b1R6bFNqRFZPWVJySTAr?=
 =?iso-2022-jp?B?S2F0LzY0d2NRcFJ0NWJmYXpFbXFRWmEweGdBTlUyMm9abHdxMzNSNDEw?=
 =?iso-2022-jp?B?U2hKSHpJOFdOWVlPbWd3Q0hzdnpMMFZQSXNSYjdkUk42UEZ4WUpqeUJB?=
 =?iso-2022-jp?B?T08rOFdLeVdjMnRLVkVJQ1hEV09MWEwwdUxjNW9pWnhaWFovTHdBZFVY?=
 =?iso-2022-jp?B?SmViYnk4S2FSbTNuZkZFdHgvNHZIYlE1V3J2VTFNcWMzSFJCR3dLZnZy?=
 =?iso-2022-jp?B?YlFhTkRGYXBmTW9pNkViWVhkT0tjQldITkRpdVk1S2hhM3NMWnVESzVm?=
 =?iso-2022-jp?B?SkUxZWhGc1kyWm4vdUNvQUdZMEZRMm5JTC9jN3hvZ01LNlFiMEdETCtk?=
 =?iso-2022-jp?B?VlVFWW0zSEU3UU1CNHl3NjJMVVZReUVNVUN1cm1jcW5PcFo5amR6eXJI?=
 =?iso-2022-jp?B?QlA1NTBhSUF3VnBidlltZWdYK0V5VDlvVzRVMEpRaDMybXBQTHRRRkxD?=
 =?iso-2022-jp?B?Zk41eWt1WnVxRGVjZGc2VG5jd0t6Z1VFUXVsS3FRak1QclVLVHplY0pE?=
 =?iso-2022-jp?B?ZWEyblZwS3d3aXFoeXo3VzVGN0VSais5aUV5ellHV3NpaEdEVFFaL2Jo?=
 =?iso-2022-jp?B?OWZIN2JTbEZxbDRtREErQzhuaElHdWVGQ043eWRHMHpTZGk0K1Vkanhl?=
 =?iso-2022-jp?B?L3dzdzNCUWVrMWVLSXQ0bFFOaGc4eDlCYzV1d25vcjZ2aEJzbzNQeHFv?=
 =?iso-2022-jp?B?YU1YdGF6aXRqUUQweCt1dEhDdGdqaisvc0xyc2thUWUwcEgxYmNmTUdQ?=
 =?iso-2022-jp?B?ekVlVmtlb3JaMFdIbmN5bmxuOXk3VXlhaDVzdkFFejFjTE5CUEVKNmtI?=
 =?iso-2022-jp?B?SzJtTGF1Tmd0MmxIM3JMcEg5dU55aWNFNVFWVjdYc0kxVndUQ3ZHZDJT?=
 =?iso-2022-jp?B?SXVFZnRkT1h6SmloNXFQM3B0VFYyU2lROExCYlNXeGxCdU5zU3hkajlB?=
 =?iso-2022-jp?B?N2psV1d4WEdpMkd0bEc3VkZPTm1EdEZiVTdTU01Lb0pGT1o0cnZSVmp1?=
 =?iso-2022-jp?B?cUhHM3VjM0Y2enIvUmlrcUpWSjRqQXBkYWpoLzh4b2hEMVMvUDBNWWZL?=
 =?iso-2022-jp?B?MmtHZHVlcHJ1Q2lxckdwNGpoYmJTaVExWnF2Yk1pQXFIMlhwZlJ6dFR1?=
 =?iso-2022-jp?B?Yy9Ia3h2VHhPMnF5dFdpVkt1N05LUGlqekVVRGZvQ1IyRjMxelZ3RnNk?=
 =?iso-2022-jp?B?UWNqdFAwVHN5ZVpxajZTbVJ1bFdBWDVrOENoVG91SmFpck9OMUMrMXBK?=
 =?iso-2022-jp?B?ZWFRM2lFY3N3NnVLRlZYOVcrZ0l2WnQwZTFURDZNUTBwdDg2UTNwbmdz?=
 =?iso-2022-jp?B?QjNEdUNLV0d4UDV0dFNXSG56UWtRNGIzQzZPaVhpRDRTbHFtTHdneXM4?=
 =?iso-2022-jp?B?eUM0YlNPb0k3VXlQZFF1dXRqUmN1ZFZvMzFvM1dQdkpyelNUelJlYXk2?=
 =?iso-2022-jp?B?aTNIT2hzcUw4VVRkdlhQWXlaRGZBTlBiZ1ltRUJKZ0dVWWJiRUd2UzRr?=
 =?iso-2022-jp?B?WnlBV1hCVEh3bExDbyttVE9hS0JoVzF2Y1BLUW1LYkVrVzRjTndYT0pF?=
 =?iso-2022-jp?B?cEJzdlhEU3NqRGVxUitjaktxMnRvbGZZNWxkSHphN0FRZVAyaVRrMzNl?=
 =?iso-2022-jp?B?YkJGdXhsZDZOWGdQcldwQzd0WGMzeDVRWFhybndHR2NBQlkwRFo3NXRz?=
 =?iso-2022-jp?B?MmgzK1Z3ZmhZN245dHRiMU1jeWRwaHpTK3lYTlZOVDVNR1E0dTRQYnRK?=
 =?iso-2022-jp?B?U2pnUEFCZ3hwbXFDempZMUUrTU8wRkRjZHJSY2lGSGF1bXdkamVKMWNX?=
 =?iso-2022-jp?B?clBRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NGpIaEJIQmFSejRhdlR4ZlpES054SFAvWHBoQ2NOd1NjWS90Y3VGM1dT?=
 =?iso-2022-jp?B?QnN0dWNxbk9aSExoS0tQK2dHdFhrZVRKSkJHV1Z2RDFEVzNxM1dOdE5z?=
 =?iso-2022-jp?B?VVFqT2FWR3NmeVVsc1AybGFGNlFlTVFCRWp0cG40ZmFiNlVWTDhYbDg3?=
 =?iso-2022-jp?B?OUFlVXhPLzlpUy95aUpUL3RCNjZjdzFDVER2U1ZuL05zZXNYVjZoN2VY?=
 =?iso-2022-jp?B?NE16RUVNY25MWnVobldnS3c4OWordWRHd3FNWHRmMWg5MXZ3WXZkZ21x?=
 =?iso-2022-jp?B?QkJWSFZIRmJRYUhSa2IwcXl3WUVuQmxReE9BTS8wNmc4V2V3ejNwQ2N5?=
 =?iso-2022-jp?B?MnZ2Nm1FK3hsV0RuVzR2QlpLNVNqd0ZLY1luMlI3Q3pBM1RvZmRYVVB2?=
 =?iso-2022-jp?B?WXhEdm5NWVdEcitLaFBQS0ROWnJLWko5MUJvTTF0dldZT0Z0RkdBZGh6?=
 =?iso-2022-jp?B?dVNKZkRGUTI0MnVqUEk3STQxSHlPbVlVa3JITjFmTnowWlZrS0Y3U0xK?=
 =?iso-2022-jp?B?emdKejVXZG5NdFI3WDlmNVNhQS8zcndqUTgyVXhrVjJzZnowQWFhek9I?=
 =?iso-2022-jp?B?U2NFOEllRlIxQ09CVk9xUWwxNzNzTkVHYUEreXZsbjRpM1REQVlIYmJh?=
 =?iso-2022-jp?B?NlhPTHhGaUtuSEdEN0VEUVZ0K1ZHbXFOL0VkODY2UUQ5dmJQVnV5MkpY?=
 =?iso-2022-jp?B?ZUk2cWVlYTdvOUw0bi9pWGYrRCt2THkwM1BaU1lpQnkxZnRjSmxRK2Iz?=
 =?iso-2022-jp?B?NzF5MVY4bGVGbXAxaGdTRDlvQ01qVlNmVGluSnF6QUh3SVRWcmY1NVZ1?=
 =?iso-2022-jp?B?dE9KUFhscCtmMVNsVVJaVTIzeEUrdmx6cXV6NS9lT3NWUmdOOGJoOGQz?=
 =?iso-2022-jp?B?cXlJTTF6RWcrTjNZSnNVemg5VUt0dmpRenVCZzZRZzJLT202VXptRUdn?=
 =?iso-2022-jp?B?aDIzTzBuQi9sQ1IzQjRXdGl1L3orZEpQN1I1ZloxMlNueDJndDBsM1Mz?=
 =?iso-2022-jp?B?d3FvL1A1VzZVWkdnSXFLUEU5MUwrOGk5ZFdGb1RycHJ3R1crL2xFcDlG?=
 =?iso-2022-jp?B?NUczcmltVWJ6dS9XWWtSeTI1Tzg2ekxIZHgyc0RUbERBSGNRcW9jQ1di?=
 =?iso-2022-jp?B?WFhHbUYxbmpaaEJ2eS9TL0YvZ1dMZ2dBbWV5ck1meGd4L1N2eG80TkJG?=
 =?iso-2022-jp?B?V0VmZlE1MmtpUnFBbldPMHVrTk5tbDRlVE4ySzJraXR1M0FZZVVwVTky?=
 =?iso-2022-jp?B?R1o0Yi82VVFucytRQUZmZzM0K2Y5Y0kwRTJJa0xjS1hTZmQwUjJ1ODQx?=
 =?iso-2022-jp?B?UFFsaGFqTnRBMktEbTBTNHhZbndhNkFEaHRQWW1QS3JSRng1UjNpVllk?=
 =?iso-2022-jp?B?c21aOXN4R0drVlN5Qy9ycVVXbzZZNFVWMXh1QVNkQWdqUnVkWmc4VVdD?=
 =?iso-2022-jp?B?cEpRcjgvV1VRZWY2YmdBUjF5aVpnaEhDekhZaFVMWGNFS3gwSEtpTHps?=
 =?iso-2022-jp?B?ZGZtRXZCazBnRm9jamhqN2JOOEVGWWpWWE1zRHFoVjFKMGdFUVF6OEJT?=
 =?iso-2022-jp?B?YkNMNENDYVRmd1BOcHR3R0VFaGVGUldIeTJlUU0zV0hhMmROWjhFZ2JL?=
 =?iso-2022-jp?B?Rk9MSmVRQk1Idy9KTC9sM3N5elBKczdhS0ZyLzFsREVkVXVHWjE5aDFF?=
 =?iso-2022-jp?B?NHdaQmlrenlYcWd6b01hMVBKeXJzNWhwSWgvN0VsOHFXTHFmVFRBaVEr?=
 =?iso-2022-jp?B?MzM4UjNPOWNYaVVuMzMzNFNZRm8vTmlXZ3M5cUt5YS83dlE3MGMrVjg5?=
 =?iso-2022-jp?B?aXVobloyT0tCVHNPM0k4UUhkRXdmeTJXUk15TWt5NjNYSk9NcnJxZDVL?=
 =?iso-2022-jp?B?S0VOL01HdmhaRm1pVkNYa05EL2ZDNHJSekgrSWRnUDdJeTREbEZhMktp?=
 =?iso-2022-jp?B?M3V2N1J6WFdIRlh3UE9ZTkZEN3ZuY20xczZuMFhsWXMwNUhieVJrSmk5?=
 =?iso-2022-jp?B?cmdCLzZMYjhRQWVDSWdZcWdGZnJUTVY5Q2hoeEs5TzU0WFcwdEMwMm16?=
 =?iso-2022-jp?B?MG1NNlg0STFjMjZZTENwenlOT1hTM3BqQXJjRm15N0JCNThpQXQ4UFhj?=
 =?iso-2022-jp?B?L3c3cVJIYVB5SFl3dmg3bFkxOExpb2hqT3FxM3I5Umw4dEtIdkZITEs1?=
 =?iso-2022-jp?B?Yjh1UmdoSUdFNFRydUVJL3hlUHB5NzQ0OVBOY1dIWHRNdmRNUWlmMTE5?=
 =?iso-2022-jp?B?aG91M0l0UE0xb3NsUkhIdm5rU2xyeGFZdXJ1QXhDcENFN243d1dnS0R0?=
 =?iso-2022-jp?B?bVpKeDRpQkdjMXVNQjcvT0JNTW80SFBUVWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f30d7e1-a3a7-4fb1-9b2f-08ddb2f02ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 07:24:40.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I25JKE7PZ5gEzQsX1qm9J8pAIAi/vjCCIMEUW2xyJHTemJufyOqm2bQ3m0UgKUHF1rUYJRfCV+VOKakGJx2OYTuLaOnxYp7EF9/oiqJHeWJFESF5SsWIf+H9C81SCDrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 07:25:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19223

Hi,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, June 23, 2025 11:46 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.1.y-cip 00/17] Add support for RZ/G3E SDHI
>=20
> Hi All,
>=20
> This patch series aims to add SDHI support for the Renesas RZ/G3E SoCs in=
to
> the linux-6.1.y-cip kernel.
>=20
> The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that of th=
e
> RZ/V2H, but the SD0 channel has only dedicated pins, so we must use
> SD_STATUS register to control voltage and power enable (internal regulato=
r).
>=20
> For SD1 and SD2 channel we can either use gpio regulator or internal regu=
lator
> (using SD_STATUS register) for voltage switching.
>=20
> This patchset applies on top of [1]
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D974771
>=20
> Thanks & Regards,
> Tommaso
> Biju Das (10):
>   clk: renesas: r9a09g047: Add SDHI clocks/resets
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
>   of: base: Add of_get_available_child_by_name()
>   mmc: renesas_sdhi: Add support for RZ/G3E SoC
>   mmc: renesas_sdhi: Use of_get_available_child_by_name()
>   arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
>   arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal
>     regulator
>   arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
>   arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on
>     SDHI0
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
>=20
> Krzysztof Kozlowski (1):
>   mmc: renesas_sdhi: use typedef for dma_filter_fn
>=20
> Wolfram Sang (6):
>   mmc: tmio: add callback for dma irq
>   mmc: renesas_sdhi: improve naming of DMA struct
>   mmc: renesas_sdhi: remove accessor function for internal_dmac
>   mmc: renesas_sdhi: take DMA end interrupts into account
>   mmc: renesas_sdhi: add helper to access quirks
>   mmc: renesas_sdhi: use plain numbers for end_flags
>=20
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 ++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++++++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  49 ++++++
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  21 +++
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |  18 ++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 154
> ++++++++++++++++++
>  drivers/clk/renesas/r9a09g047-cpg.c           |  31 ++++
>  drivers/mmc/host/Kconfig                      |   2 +-
>  drivers/mmc/host/renesas_sdhi.h               |  20 ++-
>  drivers/mmc/host/renesas_sdhi_core.c          | 148
> +++++++++++++++--
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  82 ++++++----
>  drivers/mmc/host/tmio_mmc.h                   |  11 ++
>  drivers/mmc/host/tmio_mmc_core.c              |   3 +
>  drivers/of/base.c                             |  27 +++
>  include/linux/of.h                            |   9 +
>  15 files changed, 605 insertions(+), 46 deletions(-)
>=20
I reviewed this series, looks good to me. I can apply, if there are no othe=
r comments.
Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/18859=
43849

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


