Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11AC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 23:31:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.286.1750721476527377768
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 16:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=Vh5JAsVg;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750721463;x=1751931063;bh=c1X4MCGt+kS69jRE2a+bYEK2v7ZXPPvdyDCDzlz
	iU/g=;b=Vh5JAsVgeX2GUs5V9qOVftbZz/FwuKIGPkVD+EyBEhu2H91EqZYPNyktzW861pWbFVXCZ
	NgONJedm4uW2uslMoiI13LzqDYpSmk94a5WTh8guBfRw+ZrmIS0QYLa5dqNBAJuTYCQ9u62OT33tU
	scdUvn2QBj0s/N0/DlS5wmEsTa5kqWVgQA2vEdLpblS/hOgaV/vBOWFH4dqwHo2S1Omzkt7W5WwJA
	A7VXDY6gnhgsp3pCOV3K7lJ34qIyVYzjTw0oMyRGPN9Nk1y6C24JEA4tDO8wMGS95PxegAvak7kn/
	kZeCVfarTN0Pxk4iGKCMzvGwx9+o4Vsv6T0uM80b3g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55NNV3VH443318; Tue, 24 Jun 2025 08:31:03 +0900
X-Iguazu-Qid: 2rWhg4sy4KvFuFyMxG
X-Iguazu-QSIG: v=2; s=0; t=1750721462; q=2rWhg4sy4KvFuFyMxG; m=DEaT8P5trbUp/xzAUiB7O/I3PWz89k+o20xHu8yV8EA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55NNV15p1483866
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 08:31:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfJH9hdyC1GN2cIbz8dhOkRG+Vy5A7h6PKVSVVJYI8vJz4qyqOJwaOEepH3fO7lR03Ayclh1LbzkKJm+6eb8fB4Hs2JBJSaJnyDbfw9kGOn/vtul0kitfFU01QUMuwlKsnIdPsp/HX/2OEtFpJzHir/HV/pt3IsOw7qIotvsCoXD3vHaZtvVoo/OxJO2pRmKeQyihyX5bxbc9/CqphMk63J0w5vWSqBD3rGSl3EO+YiSIrQ7NyV/vY0EqM5zMmMfOAEsWd6RvASj7ogva6SDIUymFolTSInd6PSo9+fWK7LfxPUciMubG3jJqNZiKJQtW9wbTPVivrVYelkjz1Z5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6AJohzcyIX3CTLIvC9ag/fjrGzGXJpsljEWLQ5fLyQ=;
 b=Q/C3OsVlaLNiOWSma/zHTJNPHLjNdc82qx+TOMMvQd+NnuXC+w7rqIDDiRoLNLgX5vkK9sQX4ZP4JcgfEwcaChHzLLgknK94PDM6E/wUtDYVFIgRBoBcZVMiAZO1dkFhOq4cSuVfkHvrpdUatK+ttU6wuYz7Tt4GEDPGUS7LrETzgBNTm5pIPbyGyfpQucIz7N+RU6JJUQ2W3VXaNFoesrwbctR9YZaUAcybP3eFJ9gv4ew6SLFzWfOytR6flnaxInzwZnelNfDN2/wnGFmf4+Yj3rnUsE3llYGvBdPpSphILc5HFslGGR+lMNXSbANioDB6Gcb64IVlw+ALngukEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-som:
 Enable SDHI{0,2}
Thread-Topic: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-som:
 Enable SDHI{0,2}
Thread-Index: AQHb5E4A12KrO2LStE+pm4q62jnGMrQRYqjggAABRtA=
Date: Mon, 23 Jun 2025 23:30:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183C6DA354DA02AD9A89869279A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
 <20250623144817.2119838-9-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB14818072E909E2ED8B6E114539279A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818072E909E2ED8B6E114539279A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12429:EE_
x-ms-office365-filtering-correlation-id: cb5f0aac-889b-4374-0dfb-08ddb2ae02c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UHQvU1pSN2dpY3ZmSno5VVFQTXdaYVhBYVpydGU0KzdHczJHMjRtTTlC?=
 =?iso-2022-jp?B?M3lNakRxWmdLSjFyVGtuckhZRHlVUmJuVHEvd0phYmg3Sk1oZEIvTVIw?=
 =?iso-2022-jp?B?bVlWNEoySHAzNEdqYUpXQ0JidjNRRi9HTVhRSVk3ckpEZndadzR0UWJ0?=
 =?iso-2022-jp?B?SjZkYmdsbkdUMkt2VTNLcjl1OHk5V296RzJmcGpjbGpyQTFDQUNHUitY?=
 =?iso-2022-jp?B?NmQyVHBXL3N5YW9kd0svNmQ2UFJ3aEFEdytXL1Z5OHBXVUZvQlBDUHpm?=
 =?iso-2022-jp?B?TVpEL3N1a3krWkltaHpZa2RIbHBSQWt1YkNvUDhpN1hxYlF1cTRSa0FN?=
 =?iso-2022-jp?B?N3BNUndxVnExWG04eUo1MjNaNStrTXptUHNMbFZ3cEFBcE9aVkF4aGpl?=
 =?iso-2022-jp?B?NFVMWkZueG56MHB5Nm5zM0NBLzMxVzRJa3ZpZkx3cFB0b2pKazBjQURP?=
 =?iso-2022-jp?B?V3lQM1dFUWcrcGNMZUdYYUVMd2xpcjlJZTcxeVpTUWhxMHlWWk1MTHlR?=
 =?iso-2022-jp?B?Mm9jczhlcTBmaC9SdmdCRHBxT2EyeldYRWpuQWtpTmd5U0F1R0wwTURw?=
 =?iso-2022-jp?B?R1EvNnE5RmEzOXhtd0hkU2FncGxpaTJmOTdha1g1SXRndTRuNWJUeUpF?=
 =?iso-2022-jp?B?djB0eXZLUS9QazB0TThGUFdDeW4xSk1UZEJPQ3Vza3RXbFFXSCtydHkx?=
 =?iso-2022-jp?B?dGxjYkhTNHFyYUNvYXZmSFVtSUViNVFqNEw1b0pCS0hwaS9YbXNGZTB4?=
 =?iso-2022-jp?B?RE1aUUlxWmtXZHE2Um1jdXJqaXE3bjFQZ3U3UDRINDBnMTZKWUsrK0ZH?=
 =?iso-2022-jp?B?LzNPMkNsRFowK3U5T3lXT3BoQUh5ZnpYa1Y4VkM4Y3dldGJNaFo5OHBI?=
 =?iso-2022-jp?B?VjNlY3VwM2t1ZGRMOTVsejRFN1A0ZmRkSmlxY2JnelYvWEJSUVRkZlZt?=
 =?iso-2022-jp?B?Vmd5b3F6TElhcGFYWWtSSEwwbk5RZUxDU1lRamtuSzEyR0dVQytkZk5N?=
 =?iso-2022-jp?B?S3ozZkhtV1NFUjJ2U2dIYUc2ZDFMeFRzZ1kwd1lDYzlGcjNoeEgzRm9U?=
 =?iso-2022-jp?B?d2poWFIveHhCbVgwbUhzWUhyNXFsNnlvWmttYkVDTENOdlZJUDRIcEpM?=
 =?iso-2022-jp?B?bE52VEhSSWlRUlVJbk5iRS9PY0NRY0FwK3FFSVBjOG1nU0tROGVnZWZH?=
 =?iso-2022-jp?B?Wk1NcG1LSU1KUnVtRXdjVVk5UlVOeW5PMUs1Qm9RSmg1WXFkMGhqTU1Y?=
 =?iso-2022-jp?B?WHpzWlIwMm8wWFFtYWt2eEFvVkRjZXY4UDNGaVBuUEJLeTIxYnRQMW9J?=
 =?iso-2022-jp?B?ZEpSSUtaSGdpeVR1T3NOdCt2MFdNaE56ajhCdGp1M01qdzZld3ZzSGt2?=
 =?iso-2022-jp?B?SkVvbUJaak9XRXZ4aURhYlBRald4VHg2dVVlZXprN1g3RWFxMkRhZG5E?=
 =?iso-2022-jp?B?MDhDL3B5KzRMV1A0eDI4NEYrT2Jzdm5IZWxKdFF3NFVzK21VMmVrMHVl?=
 =?iso-2022-jp?B?SVhsRjhOamk5YzZiZ3h5WVhYYlJTa1Z1aCtwOVk5YktXTUFFdFlGL21W?=
 =?iso-2022-jp?B?RkxIdk1vdFlIYVk5dWUxU1NOSXBGQldMVVpRWGQyWmdPNW5ibVFlWW43?=
 =?iso-2022-jp?B?TDdmMTdKVjBvYlNuZGFucytsNHY3TDk2djg3MEs0NENVVk1UVENYV0k1?=
 =?iso-2022-jp?B?TmZJNjRJbFNnR1EwZGJhd1J0YVlIYVFQbGtTWGZsSjRNbHlTWGs0dk42?=
 =?iso-2022-jp?B?TUhObTU0OU1NWnNyckYyKzFFQnVodGpmN1dyYWVNVk41aFIzazlQRHZI?=
 =?iso-2022-jp?B?SUhmei83ZStiaVhOSmM1bWdnTmdpWUM3VGJvNUdUY2ZtL2tuS1FoQXk2?=
 =?iso-2022-jp?B?ZnQ4eXl3UVFqZGRKNkRUU1FRSGJMaDY3UmNtYTdhSmxBZmhKVkdpTmlT?=
 =?iso-2022-jp?B?QWVEWlR6bGJzcTg2clI2a05ENFNJRjJwYjZkU0NtWTdneDNjMUxXVktR?=
 =?iso-2022-jp?B?RkRQYzZhYlhBQ3dsMDhmQS9kZHpRSDVvM3YrdWZXNzdobE5rOXZEYkk1?=
 =?iso-2022-jp?B?TStyaDRJVmlWVHBOdkhHMUlka0x2Y2RIcEpwVC84UjFNTzBWeVBZMkNp?=
 =?iso-2022-jp?B?YkhWVm9qSVEzRkxVdkcvU3MyNkNuLzcwRllvYy9TSy9XdW9HTzFNNjlj?=
 =?iso-2022-jp?B?L0pJPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cktWbVJ5MHNvRmkxVmJKaEUvc1I1NUQ4dFlaTUZTOVZtaUM1UWppSXZv?=
 =?iso-2022-jp?B?MmxabEY4b2k0OUsyRDhjTDJrOHNzSDBOSUExUWFSczd0bWNrdU9LR0xj?=
 =?iso-2022-jp?B?VFNONWZRUm4rTnB4TnBNOFNnQ3haL1hQTHhBVDQ4RHE1dVVBNy84dldJ?=
 =?iso-2022-jp?B?N1o1QUpHZEhNc2hiS1BsZ1duS1BVdmhIam5ib0lUTUZXMUt1N2xBL05i?=
 =?iso-2022-jp?B?YzVvUE9Jbm5LdzBnREVJeUVtRXQ2dTRLS2RJSlRtTldGWHc2NFJiODY2?=
 =?iso-2022-jp?B?N0RCSXBhVnFBMjIxMVkxZVg2eVlHZTZHV24xd0tkQlNCN0tmcVp6YlUv?=
 =?iso-2022-jp?B?SjFrdTJJajh5YXNZbDBGVWxMN3RtRlN6UlpRYVA2NjZzOHYrVUZjaG1v?=
 =?iso-2022-jp?B?V0ZsM240TE1QbEFWNCtGS2Y4d1RUQytzdTF3ZWFPd0o5QzFVQUc4L2Zy?=
 =?iso-2022-jp?B?UkgxWEkwZHRTU3ZMYUFHbnoyMml6end2S1BPa3pvODF6T3J6UWM0WnJI?=
 =?iso-2022-jp?B?aU4zYVF3dHdZUmd0cno3dGxnYUF1aEtjNkRrMGhZV0VBbkdLd2dFQnRs?=
 =?iso-2022-jp?B?R1BnSFRESGtIZ1dOQ21OTC9nb3NoTk5CYUYyRmFxK016TmVjdi96RmR3?=
 =?iso-2022-jp?B?aW5ieWFyeG42ajByVEE4UTVBakxmUThEQ3gzR3JWVVVHOXM1a0xIZDZv?=
 =?iso-2022-jp?B?QzVpQXBXODMzbnQrUmNKWkZ6Ryt5Z1djczZnV01Wd1pMQkRjeE82SGVh?=
 =?iso-2022-jp?B?bWdTMitSaWRGZWxOT1dKMTRvUUF0bS9PUjFUM0ovaGVzb0tnKzN1aE9l?=
 =?iso-2022-jp?B?ZW4zZnZ2bTBJUEtMWmZOc2hSNjhRQ3UrZ0NWOGZZVUJsaDhTRjd6MERm?=
 =?iso-2022-jp?B?ZSt1RHN1WmZjd2d6bmNldlVwbXdpa3hzaG14NFAvRCt6RW0vb3dVTktl?=
 =?iso-2022-jp?B?UCtQTHBPNkFwbUlBSzk4UTRQeEVlZXhNREVWRnNaT3pvdXZhRkQzVXI0?=
 =?iso-2022-jp?B?SFpLaFhGZ1krbG9PNHNPN3VnWlVNemVicnpxbElJeE5PRk5xSWVHa3U0?=
 =?iso-2022-jp?B?bmhVK0tSOC9Xd25uY3U4cVdabjFSbjRCRVRWWU95bTU3Ky8rNE1janYx?=
 =?iso-2022-jp?B?ZXpPTlQvdStmamVtTlBvSlh3cGtxcEk4QjRLS0h2ZnZydkUvSkJNMXZF?=
 =?iso-2022-jp?B?WmZ2U1FSaUFFWEdkRUZ2dmR0aStQTlVPYVB5a2dLV2hNdGxBMjNuVEFM?=
 =?iso-2022-jp?B?a25aNVgyT2N1QzFybUttZ1Bhc29ZaUtwaXpPT1gvZng1NmNpUjM4TDZL?=
 =?iso-2022-jp?B?S0JEaTcydjBiNzU3aXl0eGtkN3pwWkxvWkR0UUhIcXVzcHZ6MzMxTm1V?=
 =?iso-2022-jp?B?OUJ6dGprZWZCbHhCdVVWak5LTWhBN0ViTUFEczJTWGt5cWg0WjBlbnhT?=
 =?iso-2022-jp?B?SWpMRkpaL25FbUREVXhGaVBMZGxUOFI0YlMzTmlyRTVDTkN5VHJ6R2Rm?=
 =?iso-2022-jp?B?QlJFSGtwMkNrbG1EdTdlT3BFbSt4SHNyakdWQVVNQ0VEQzZuaUJSdzcw?=
 =?iso-2022-jp?B?dzNuNHpyK0p1MG1nTEplTVdrd3RkOEhBZERTV3FPamF1ZWE0VFNSWEZ5?=
 =?iso-2022-jp?B?WHFTOFlDeGdCUkJkQUVmUFgyc09HZHZzMWlPMDNmMEtvN0JyTnpEQ21W?=
 =?iso-2022-jp?B?SHRyQWwrbXNrQ3FPSGpqeTBKandyMXdBc05Ha1BvV203amUvSW5ieW1D?=
 =?iso-2022-jp?B?bUVzL2dmMmFqNEM0VjhZRk95WU9qV21rVUxyTWtHRXpNdWc5bUxZTDFU?=
 =?iso-2022-jp?B?OFltaGhLV2hrK3ZMYkVuL1hpYkNWN1EwWFMyNExReXdWUmdOQmVZalNq?=
 =?iso-2022-jp?B?RHcwMFhITHBDOHhTcHhCenZ4a1kvLzE2THBSYVV3aFVlQll1T2I2K2hU?=
 =?iso-2022-jp?B?YXZ0MEI1ZmVBWFh3cU9nZ1FmK21QbVM1ekdhOEVZeXR0ZVh5YjNVbDhK?=
 =?iso-2022-jp?B?VytrOW1peXRCeVF5RHMyQjJzNWw5NDhxdUJnaUtFMkFnRzJ1YS9zSHVh?=
 =?iso-2022-jp?B?Q3F4Y0VBNmxFSUNxZ0RXeVBYR2JvNElTREw2cng1bG5MTTRmcCtDaDdw?=
 =?iso-2022-jp?B?VUQwY2FTdjF0TkRxemVaaWFQWkdiSjFNcVhGMnhET0lDZnNQbWpVSHpY?=
 =?iso-2022-jp?B?THR6WTMyQmlndFlNZmZxdWdkR2d6Z08zWWQ4Y3U5UXJlYlM0TnliUnJm?=
 =?iso-2022-jp?B?S21VWWtCbi8vb21NVEJPL0RUUUVLdFhjOFRKRXlVK29CaWorYTgxWFpu?=
 =?iso-2022-jp?B?TklCdkRuaXRPMEpTNDBTajNOVDBYSFUxaWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f0aac-889b-4374-0dfb-08ddb2ae02c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 23:30:59.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDh8JeIO+L7c/fJqRoEh6zLqZapZT42puqDu7CdV4pKFIQc6V2uXgETs5JzJSUmQzLg1dx4jQYejhxs4Cs3tzEvz2ZAc8MmJY1jqJ4TrKxjOBhBT1hO79IxKhtva3qEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 23:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19218

Hi Tommaso,

> This patch cannot be applied in my environment.
> Could you please check it again in your environment?
>

I did not apply ' Add support for RZ/G3E WDT' series.
Sorry for the trouble.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Tuesday, June 24, 2025 8:26 AM
> To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: RE: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-so=
m:
> Enable SDHI{0,2}
>=20
> Hi Tommaso,
>=20
> This patch cannot be applied in my environment.
> Could you please check it again in your environment?
>=20
> ```
> Applying: arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
> error: patch failed: arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi:27
> error: arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi: patch does not
> apply Patch failed at 0008 arm64: dts: renesas: rzg3e-smarc-som: Enable
> SDHI{0,2}
> hint: Use 'git am --show-current-patch' to see the failed patch When you =
have
> resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ```
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: Monday, June 23, 2025 11:48 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> > Subject: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-som:
> > Enable SDHI{0,2}
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 16bce534a391487c56aa266dff2ac5733b207f5c upstream.
> >
> > Enable eMMC on SDHI0 and SD on SDHI2 on RZ/G3E SMARC SoM.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://lore.kernel.org/20250206134047.67866-7-biju.das.jz@bp.renesas.
> > com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 100
> > ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> > b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> > index f4ba050beb0d..fcbabe2cb003 100644
> > --- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> > @@ -8,17 +8,86 @@
> >  / {
> >  	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57",
> > "renesas,r9a09g047";
> >
> > +	aliases {
> > +		mmc0 =3D &sdhi0;
> > +		mmc2 =3D &sdhi2;
> > +	};
> > +
> >  	memory@48000000 {
> >  		device_type =3D "memory";
> >  		/* First 128MB is reserved for secure area. */
> >  		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
> >  	};
> > +
> > +	reg_1p8v: regulator-1p8v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-1.8V";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_3p3v: regulator-3p3v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-3.3V";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> >  };
> >
> >  &audio_extal_clk {
> >  	clock-frequency =3D <48000000>;
> >  };
> >
> > +&pinctrl {
> > +	sdhi0_emmc_pins: sd0-emmc {
> > +		sd0-ctrl {
> > +			pins =3D "SD0CLK", "SD0CMD";
> > +			renesas,output-impedance =3D <3>;
> > +		};
> > +
> > +		sd0-data {
> > +			pins =3D "SD0DAT0", "SD0DAT1", "SD0DAT2",
> > "SD0DAT3",
> > +			       "SD0DAT4", "SD0DAT5", "SD0DAT6",
> > "SD0DAT7";
> > +			renesas,output-impedance =3D <3>;
> > +		};
> > +
> > +		sd0-rst {
> > +			pins =3D "SD0RSTN";
> > +			renesas,output-impedance =3D <3>;
> > +		};
> > +	};
> > +
> > +	sdhi2_pins: sd2 {
> > +		sd2-cd {
> > +			pinmux =3D <RZG3E_PORT_PINMUX(K, 0, 1)>; /*
> > SD2CD */
> > +		};
> > +
> > +		sd2-ctrl {
> > +			pinmux =3D <RZG3E_PORT_PINMUX(H, 0, 1)>, /*
> > SD2CLK */
> > +				 <RZG3E_PORT_PINMUX(H, 1, 1)>; /*
> > SD2CMD */
> > +		};
> > +
> > +		sd2-data {
> > +			pinmux =3D <RZG3E_PORT_PINMUX(H, 2, 1)>, /*
> > SD2DAT0 */
> > +				 <RZG3E_PORT_PINMUX(H, 3, 1)>, /*
> > SD2DAT1 */
> > +				 <RZG3E_PORT_PINMUX(H, 4, 1)>, /*
> > SD2DAT2 */
> > +				 <RZG3E_PORT_PINMUX(H, 5, 1)>; /*
> > SD2DAT3 */
> > +		};
> > +
> > +		sd2-iovs {
> > +			pinmux =3D <RZG3E_PORT_PINMUX(K, 1, 1)>; /*
> > SD2IOVS */
> > +		};
> > +
> > +		sd2-pwen {
> > +			pinmux =3D <RZG3E_PORT_PINMUX(K, 2, 1)>; /*
> > SD2PWEN */
> > +		};
> > +	};
> > +};
> > +
> >  &qextal_clk {
> >  	clock-frequency =3D <24000000>;
> >  };
> > @@ -27,6 +96,37 @@ &rtxin_clk {
> >  	clock-frequency =3D <32768>;
> >  };
> >
> > +&sdhi0 {
> > +	pinctrl-0 =3D <&sdhi0_emmc_pins>;
> > +	pinctrl-1 =3D <&sdhi0_emmc_pins>;
> > +	pinctrl-names =3D "default", "state_uhs";
> > +
> > +	vmmc-supply =3D <&reg_3p3v>;
> > +	vqmmc-supply =3D <&reg_1p8v>;
> > +	bus-width =3D <8>;
> > +	mmc-hs200-1_8v;
> > +	non-removable;
> > +	fixed-emmc-driver-type =3D <1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&sdhi2 {
> > +	pinctrl-0 =3D <&sdhi2_pins>;
> > +	pinctrl-1 =3D <&sdhi2_pins>;
> > +	pinctrl-names =3D "default", "state_uhs";
> > +
> > +	vmmc-supply =3D <&reg_3p3v>;
> > +	vqmmc-supply =3D <&sdhi2_vqmmc>;
> > +	bus-width =3D <4>;
> > +	sd-uhs-sdr50;
> > +	sd-uhs-sdr104;
> > +	status =3D "okay";
> > +};
> > +
> > +&sdhi2_vqmmc {
> > +	status =3D "okay";
> > +};
> > +
> >  &wdt1 {
> >  	status =3D "okay";
> >  };
> > --
> > 2.43.0


