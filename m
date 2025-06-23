Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7381C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 23:26:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.182.1750721156017529411
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 16:25:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=Xf5CbEp5;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750721140;x=1751930740;bh=i1ZWe8p5kq1h20+MpIQ6vBMTGKVyDFcTHV8Tcu6
	Bxw8=;b=Xf5CbEp5+UXTYZMn4EqNF5wsLn018CczPkrjXIkkuWB/QAsYYRaoiIY5zhrSiE3l9DG0d
	vy+C2fM761m48YUTucMeRwAS27eIHeltNB7gsKCYkMXjVo5XPQC8bYjxJ/tFSLbESHx1EkS18eDM/
	VJX6ev+2OrR/MaHpW5iL8kCXfQ31iBcsfsjj3XmgEdh5yYObPYloO6eBVeP6B0/ioPeQ60ePaLSaa
	sope5jOkZTod4yMF2a9VcDVCYbUEGEuBFXS6GCqywsPIUS7MxRKFs4mQkk+n8N1Pyj212X8JClHZs
	U9aUK4bNoNjxpXKbFSB3Q4CSYwY+MYfhNkO0FrLb4g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 55NNPdKs3033932; Tue, 24 Jun 2025 08:25:39 +0900
X-Iguazu-Qid: 2rWhMjEQLz3mp1uOwa
X-Iguazu-QSIG: v=2; s=0; t=1750721139; q=2rWhMjEQLz3mp1uOwa; m=8aSoQs7LFiUFSHYlajWrnjz+2t2NTGtqAePnAA/p+fE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 55NNPbZq510167
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 08:25:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uyaqo638Uh87DOs5ywgeJdJfV82QbBhUPm9jUyMM43VMsFVZrEaUjje0j19pMywu6yWrHcn0vM6wL0rjgR6o8Kc0O+l5seb/EENtNzdZG4nTk3+/y9sXc7OtDNaIS9nZmWpLHJEesi/5pAELy5RHbHMopWZ326wopu6QUMj+VCxGc7ZGa0ntIpYzJYmirdPZOLxcefRJT1VOZK5XtGB5g4w6ClTe6lZIP8uJDengK99jxMcpanvnNHcftceYe3t7XMp/ceFUgl/GsRdQC7j/qe9HqJaJzRbEqnylgbuYnMfooepgDi8x3HUaxHXtoDSrBrpPE9bf6csyQqgPsTWbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXHDmN8b/x9bgYZqbUlJzHMMrBM4sXmslVcXAwGf+ec=;
 b=lp8kJj7sDUksfTPAu7ES+/oN2ab25rMqdsk47BgP+4xu1Ub67KyIHDA/whcZdNScvgI1KhCTMXLdDibNozdrRWYeg3VA7kzqHwnFGgE9i1DLgbtlQUVzOgy6T8wSRUA5MKNGY2XTwt3IXbH85zQEFqZyUyNeEcTyRN6kPGBvWZy/2kYT/fbaDmkoHdkiAnza609sWzIN7X56wJvCdJ/W+ImJzigIAywbK3ZYAKduPpz5YM9QZ2aSf4DAlJgwxF8AHYaYgsgHipPdjvPWIg1mqoL7EQkbxNMEXu1pmgL+agNg3Ir/OdU91JM2MUneXPz1dV12YJ4Ez7a7jhnYWVziRg==
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
Thread-Index: AQHb5E4A12KrO2LStE+pm4q62jnGMrQRYqjg
Date: Mon, 23 Jun 2025 23:25:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818072E909E2ED8B6E114539279A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
 <20250623144817.2119838-9-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250623144817.2119838-9-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12429:EE_
x-ms-office365-filtering-correlation-id: 51c62370-aab2-4f09-027e-08ddb2ad414e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dnplZEtGNldUWllyRVk0Zjl6dkUzcFhrVlpGWGd2ZkM2b2NPT0xzeWVI?=
 =?iso-2022-jp?B?S3M1T0lLTEN6NjM0MU8ycVQwNHNBRHBGQnJ1emo1RUFTWW12d2xIS1RW?=
 =?iso-2022-jp?B?RDdDVFQ4dlJBY3Nra1N1S094bkhGWktwVXBvRGZnaUtpTEwyNkJLSGF0?=
 =?iso-2022-jp?B?RVdraFN2emxZRjhDbWFhNW5kUU0rb0R4N1pTV3A1NHRLOVBIQm43bWlR?=
 =?iso-2022-jp?B?Y29mRjRsL005TVZyaVVUM0tHRGsxVi8wNUxoaEc1L3QyNmNFODQ1ck5v?=
 =?iso-2022-jp?B?WDFPbG4wWVpnUmU2OXdRTmFMZEU3b1FCdVNiRW1iT2NsaWNLQXhORjlG?=
 =?iso-2022-jp?B?b3NaWHhscTNwcTZkNUR1UTA5cWd6V1pZYWdrbnlhUzJSblNscUM0RTJt?=
 =?iso-2022-jp?B?SVEvL2FrZVZ6SlZHckdoWmVkRjZvTkpoNDl4d0ZCRmJsN1J1RE1TbUFv?=
 =?iso-2022-jp?B?T0J4L2E3RkxFY1BBdTlXWmJJNW41c3JtOHFZVU1wWWNaOHRBc1A0bnlN?=
 =?iso-2022-jp?B?Sk9pNjNhcUhTbHNzcUtMQUdYbUNacjFLa1dmdk8zM0E0QjVuVFNrUEpD?=
 =?iso-2022-jp?B?dCtROXpkR0lCbVJ1aFVKYWkvOWdXSHV3SDFpaVFkWHBUODdwUzIrdm1Y?=
 =?iso-2022-jp?B?VUxUSmRkTWlEYThvd1kyMFJqWFZJTXlUUTQ1aHRYODY5cGtTcWg3UEVU?=
 =?iso-2022-jp?B?c2dFWVF6cXpyUm00TDV1cWIzdDI1OUV6RldBYjZndkI2TXI4YzR6YWVD?=
 =?iso-2022-jp?B?QjZ4cVVQOFdkb2YydlJnOUtOYUVwRzJBQVpucXdRbVo2Q001b085WDRk?=
 =?iso-2022-jp?B?RnBMU0dNSTc5bStuclhpRXdVUjVtcktsY0lScjhBRURkalVLYWFsRWQw?=
 =?iso-2022-jp?B?Nzc1YWpxOTNWVTFBcHNoTU03cm5SVUo2c1RmL1F1QjVNQ2hGYVpBc0Q5?=
 =?iso-2022-jp?B?ckQxZStBYTYrT2ZVem13VGI0TmgvZUdrT084UER3K3JnVS9Vck5DT0VF?=
 =?iso-2022-jp?B?VGhnZTk2NHNsb2VwMDVtdyt6YU95TWZzcjdDVjg2RFJ0QkRreVlTSlI1?=
 =?iso-2022-jp?B?NHEwWDJUam1tUEZzY09rbWFsaDgyR1NKNVNHbmNXNWdTMnV6MTQ5dSs2?=
 =?iso-2022-jp?B?ZE9WSmVQZy9pVnRwSTV4TnNsUGxTTTlGVFBIQXpQdkw5VFQ2OXNKWS9W?=
 =?iso-2022-jp?B?dU5oaCtUOWtiYVJwQzBqbUVvMDVqZ21LTy9paXEzQjRSTDJlMFl3MVdw?=
 =?iso-2022-jp?B?ejRLMStoZys3U2xFOXd1K2tLK0lvOGNhSWQ0cHpjYlR1U1lhNjdSM05z?=
 =?iso-2022-jp?B?eXIva3ZlNDNlWSt0eVFzR3ltOExwcWc4RXVicEtvbDB5MFZITElqMGZy?=
 =?iso-2022-jp?B?RVdNclFyeVB1OURjVGVuRWFpVG9OS2NIMkFQRUl6UXU5VElYaU1uU2lZ?=
 =?iso-2022-jp?B?VTlDdzJQbXZLckpaVEhOV0Q3OFVEQytlMDQvbmxJVno5eVN2VWx5STdX?=
 =?iso-2022-jp?B?SE9KR1RiNFlBMTltL0llSlRvaWhlcjc1Q0pBV2ZlU0tpZTVYcWhYY2Ja?=
 =?iso-2022-jp?B?ZUp5M2hRSkc5aXd3cEFTTGp4aGJrN0gyaDIxTVpZTDdjZFk4cmVZWm95?=
 =?iso-2022-jp?B?WTF1VjFNbGFOWnRXcmtvbmsxS3RHaHBUdFFSdkJXNTRYZjFWTFVia1Az?=
 =?iso-2022-jp?B?ZERIdE5PZmVHTW5tb1lEcFV4b2Z6ZmRsM2xISHZncGVpU04xNllvbGpY?=
 =?iso-2022-jp?B?b0RzY2tTa1JOc01TZ2JWKzl0OE1RMmxMNGtjK0Y3TCtDN2Y5eVJlelE5?=
 =?iso-2022-jp?B?bTVDeXpPZERUTzlyLzdHazJlVy8xWjRzc25uM05OODgxY3NkTG1Bank1?=
 =?iso-2022-jp?B?RjFudGpHeUg4Y01BRGhZdGVhSjQxQ3V5RzN6M2ozRFpwQzhyemtFKzAr?=
 =?iso-2022-jp?B?OU5yUXE4d3FQNjVqdzVZYVBnNzZOTkNtRHYxamdJL1NvckZDQ3R5YTZs?=
 =?iso-2022-jp?B?ZnUyMVpSK3pqTmVJRHRIQUVrdVlDZHlERTVuODc5TW9mdy9YaXlPQUNQ?=
 =?iso-2022-jp?B?SzNrWkp0dFRoYlBZOXR2UWtJR3R6K0RSNU5vLy83ZEk0QnJwbzZPOEJr?=
 =?iso-2022-jp?B?UFFMZ1lCSTJLVlZHTmltWXV2bWJmVGlkejNQZFlQMDBoZlZpL29GcUNB?=
 =?iso-2022-jp?B?WDQwPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SUFUVVB2M2k2ZTE0RXZsWEpPQ0FrQ2t1dFcxalRWVWNVRHpKMDFmZ0dp?=
 =?iso-2022-jp?B?YytjeW5rK2U3SkJpbWt3S1ZNYlRaNDI4d0JXUndkWlEzR0Q4b0FrRUdl?=
 =?iso-2022-jp?B?YUdsckkvUkZTT3ptb1VKcGRjdHIranJTZWtQVjhKaXlsemQxeEp6cVRI?=
 =?iso-2022-jp?B?TENxRHZuMStpK0FWdi9UNGFabVZTcGRDb1VwRm9VUGN4MUNlLzU2anhJ?=
 =?iso-2022-jp?B?aGZ5L3VHb1pSZFRpRDhwOFFBNEJjcnFEbDRMRk5WeTlldm5qWXpzaW5F?=
 =?iso-2022-jp?B?NWpNa2RzNy9jVUR5aHdOeWI5bi9GZVYwbGRlbTNTTVpGWkFTVHRuU0R4?=
 =?iso-2022-jp?B?N3dWbktKcXBkVVUySVJFRzhsSWxVOW1vTGppemlGcTk5TkZsYThRSVZw?=
 =?iso-2022-jp?B?MjlGUTV0OXJyakRFL0xocHJCVEprYzROa3VLQkpLYTNVdlFrL2p6Y0Yv?=
 =?iso-2022-jp?B?WFBkQWI3S2YwQ1BTUUhoYUNGTWxrajFXNnhsTHRqZGlqR0F0TDlHV0dX?=
 =?iso-2022-jp?B?dThHZ2d2Nm50WlgwdWhwNFo2OU5LSkxBWFBHb2VlekxQQTVxTjhrUFZ4?=
 =?iso-2022-jp?B?RUlJL29BZkxudGptdkVwbGVabW5jMzc1MXM0VjUrVWRBbFZsRGRGTllh?=
 =?iso-2022-jp?B?U1NQV2djNlRNbGN1V2lQd3N0L1pEWlQ5ajhvTnBIeURTYVhGZVovRWds?=
 =?iso-2022-jp?B?dTF3YmlNSGhlTGRYak13R292TDc1cUZFSHUrelVkWnU1RnFyUmJYS09V?=
 =?iso-2022-jp?B?UC9oQmRBa2NxdWNFTUVkUW5GNUZTajdDbnd6aHdDZ1lZR1B6Z2l3TXd1?=
 =?iso-2022-jp?B?VVRGR1Y2TDRGTTIvTGMwdW5COXRReVhKa1Z5aU9oVjZCUHRwai9pcUth?=
 =?iso-2022-jp?B?OTlFVkJ0NVc2UmROQnVBWXRlckJnY0VrTXFIaG9RZDR6Y3Zua3FPYmtR?=
 =?iso-2022-jp?B?WVRFZFpOV0pzRUFhOGpONmxFeFFBZm4wUkRBSVR4MEJ0Vkdia3liZU5K?=
 =?iso-2022-jp?B?MTVTWDVTejFYMEYyWm1LN0dsamJUb0N3OFJqRVpWVlo0ckwrMXQvaFpB?=
 =?iso-2022-jp?B?blJ0d3g4U1pCNE5qby8yYjV5bVFsS09QR3dnaWRjSUk0N2FhKzk5Nm55?=
 =?iso-2022-jp?B?MGZwWlFlbGY5aE9BUmFQZkgvS0hjMUpnWlRSdzdWeFVtekpJdlFHcE8y?=
 =?iso-2022-jp?B?WThSamRFeGh6L3dldGVkYm9meG1VamR4MWJ4dW5zc0FkZlV5UXc2alhQ?=
 =?iso-2022-jp?B?dXJVdWdzUlc2clNuSnE2ZmZWaUFvNEFnWFZTVkQrWUs3THgzVjhSQU1G?=
 =?iso-2022-jp?B?RWp3ejUwMk5MM3h4NDBnWi9lM1ZIU0FtdUlXeEFoSEh5TERuQnFHNTY5?=
 =?iso-2022-jp?B?ZGpJWTcvOWt0QmNEaVZ4YTNubkI4azFNWE5vbit4Y0FIUXNDYzRIbHl1?=
 =?iso-2022-jp?B?V2JFcFlNZGRLSE9HRUVTZnprczIyNmJERjZNdStuTFFKcXlIcURBZjZ6?=
 =?iso-2022-jp?B?a3JKcllTUmFDSHU0cHhiR2xGR1JVTnZXRkE2NFd4TnJrQTRod2plU28w?=
 =?iso-2022-jp?B?WER0WmJLaDE0YWRKZk53VFVINXgvMFh6RGdpYS9vSFRKQlV2bTl3T1Az?=
 =?iso-2022-jp?B?aG1PdzVNS0ZEZlhHamR2ZUJwYXhWeXJpaTB6dzlMb2Vsc3dhWEFCcWov?=
 =?iso-2022-jp?B?UzBFV2RyRkJ2R282UWY3OVlvaytxbisvRnpNZklhNmlXMHN0aHZranE1?=
 =?iso-2022-jp?B?UzlISWtzVitxV3EyeHBFWitVNnhSVG14VzJySTJoQk5Fa1pvZlJlQVJY?=
 =?iso-2022-jp?B?YmdmSTNNcDFKeFczd3lvdDZCRGFCZFhWY2FBMTB3UGozRWtuVGxBV2F1?=
 =?iso-2022-jp?B?ZjBVUHErTE5uUS95N0E2WVVhbkFzTWdRK09adXNUc3N6QTVDTkphTnRD?=
 =?iso-2022-jp?B?RVlHd283RFY0TWRSdWFSc05PTUVENnUxeTFGYlpJMi9UbllHekpYeUU5?=
 =?iso-2022-jp?B?Z1NsSzJTUlRGNUN4TW95eDNPeTFhcjFPOUJjWDNLK0JVcDJlMXdTWlVh?=
 =?iso-2022-jp?B?MHhXNUNRUkZSbGErYVRpcnRJS3ZCL2JXR3FsM1RVOHkrZUpyQjI5YTZx?=
 =?iso-2022-jp?B?VHNIWFRtcDA1WmpDY1JCQTRuN3JtOElZWW9hS09taFBYTVNEWHBwTG1F?=
 =?iso-2022-jp?B?U1ZYckJQdUtnUloyWWlNM2I4MmVJV2YrM3hMOGI5cUVMYUtTK25kVVNt?=
 =?iso-2022-jp?B?bUxrN3JmYk9FZSt3ODFHN0lTMjR3bW1DUW9mQzN6b2RrM0luOXZRWWVP?=
 =?iso-2022-jp?B?cU40aWt6cVNoY0FsVGErN2RXdm9iRzZ0Ync9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c62370-aab2-4f09-027e-08ddb2ad414e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 23:25:35.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8dcjWffyBagYl/R8Ls4eXqzzgkHuAnKwS1A8SS6fv/X8sWnkFpdWXMovcmu+K1LW2sgihnRHLgDmIerZ+FFYUApcrFotybQOde0hphcxAI36ifc9sKr0qQkUd0GqMtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 23:26:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19217

Hi Tommaso,

This patch cannot be applied in my environment.
Could you please check it again in your environment?

```
Applying: arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
error: patch failed: arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi:27
error: arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi: patch does not app=
ly
Patch failed at 0008 arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
```

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, June 23, 2025 11:48 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 08/10] arm64: dts: renesas: rzg3e-smarc-som:
> Enable SDHI{0,2}
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 16bce534a391487c56aa266dff2ac5733b207f5c upstream.
>=20
> Enable eMMC on SDHI0 and SD on SDHI2 on RZ/G3E SMARC SoM.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/20250206134047.67866-7-biju.das.jz@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 100
> ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> index f4ba050beb0d..fcbabe2cb003 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> @@ -8,17 +8,86 @@
>  / {
>  	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57",
> "renesas,r9a09g047";
>=20
> +	aliases {
> +		mmc0 =3D &sdhi0;
> +		mmc2 =3D &sdhi2;
> +	};
> +
>  	memory@48000000 {
>  		device_type =3D "memory";
>  		/* First 128MB is reserved for secure area. */
>  		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
>  	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed-1.8V";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "fixed-3.3V";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
>  };
>=20
>  &audio_extal_clk {
>  	clock-frequency =3D <48000000>;
>  };
>=20
> +&pinctrl {
> +	sdhi0_emmc_pins: sd0-emmc {
> +		sd0-ctrl {
> +			pins =3D "SD0CLK", "SD0CMD";
> +			renesas,output-impedance =3D <3>;
> +		};
> +
> +		sd0-data {
> +			pins =3D "SD0DAT0", "SD0DAT1", "SD0DAT2",
> "SD0DAT3",
> +			       "SD0DAT4", "SD0DAT5", "SD0DAT6",
> "SD0DAT7";
> +			renesas,output-impedance =3D <3>;
> +		};
> +
> +		sd0-rst {
> +			pins =3D "SD0RSTN";
> +			renesas,output-impedance =3D <3>;
> +		};
> +	};
> +
> +	sdhi2_pins: sd2 {
> +		sd2-cd {
> +			pinmux =3D <RZG3E_PORT_PINMUX(K, 0, 1)>; /*
> SD2CD */
> +		};
> +
> +		sd2-ctrl {
> +			pinmux =3D <RZG3E_PORT_PINMUX(H, 0, 1)>, /*
> SD2CLK */
> +				 <RZG3E_PORT_PINMUX(H, 1, 1)>; /*
> SD2CMD */
> +		};
> +
> +		sd2-data {
> +			pinmux =3D <RZG3E_PORT_PINMUX(H, 2, 1)>, /*
> SD2DAT0 */
> +				 <RZG3E_PORT_PINMUX(H, 3, 1)>, /*
> SD2DAT1 */
> +				 <RZG3E_PORT_PINMUX(H, 4, 1)>, /*
> SD2DAT2 */
> +				 <RZG3E_PORT_PINMUX(H, 5, 1)>; /*
> SD2DAT3 */
> +		};
> +
> +		sd2-iovs {
> +			pinmux =3D <RZG3E_PORT_PINMUX(K, 1, 1)>; /*
> SD2IOVS */
> +		};
> +
> +		sd2-pwen {
> +			pinmux =3D <RZG3E_PORT_PINMUX(K, 2, 1)>; /*
> SD2PWEN */
> +		};
> +	};
> +};
> +
>  &qextal_clk {
>  	clock-frequency =3D <24000000>;
>  };
> @@ -27,6 +96,37 @@ &rtxin_clk {
>  	clock-frequency =3D <32768>;
>  };
>=20
> +&sdhi0 {
> +	pinctrl-0 =3D <&sdhi0_emmc_pins>;
> +	pinctrl-1 =3D <&sdhi0_emmc_pins>;
> +	pinctrl-names =3D "default", "state_uhs";
> +
> +	vmmc-supply =3D <&reg_3p3v>;
> +	vqmmc-supply =3D <&reg_1p8v>;
> +	bus-width =3D <8>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	fixed-emmc-driver-type =3D <1>;
> +	status =3D "okay";
> +};
> +
> +&sdhi2 {
> +	pinctrl-0 =3D <&sdhi2_pins>;
> +	pinctrl-1 =3D <&sdhi2_pins>;
> +	pinctrl-names =3D "default", "state_uhs";
> +
> +	vmmc-supply =3D <&reg_3p3v>;
> +	vqmmc-supply =3D <&sdhi2_vqmmc>;
> +	bus-width =3D <4>;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status =3D "okay";
> +};
> +
> +&sdhi2_vqmmc {
> +	status =3D "okay";
> +};
> +
>  &wdt1 {
>  	status =3D "okay";
>  };
> --
> 2.43.0


