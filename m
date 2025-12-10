Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F535D2CE17
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 10:25:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12430.1765362347294080092
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 02:25:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5BAAPh1F1284960; Wed, 10 Dec 2025 19:25:44 +0900
X-Iguazu-Qid: 2rWgP4I50F6puIXFOW
X-Iguazu-QSIG: v=2; s=0; t=1765362343; q=2rWgP4I50F6puIXFOW; m=EG+jWkqJwnGrw5YB9jIP9WZQYj6lGBD0+Bh4700wwJ0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dRBgq4D3Nz1xnc; Wed, 10 Dec 2025 19:25:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1hzXCWU0+U+iA8KaISjc8jqLkTrjjoWUziLHNlprMu9NrsHW3+h5C/PB26BwzyTTGORA6oprtrtzjMRyR4nROdKlDL7aUn2JoZg4EaRKey9Qyt3vr57AfUHioJgera48hWAuDGQa60hdNcF0WQUJMDWtvQqUNQDV190FAXvPGZzVkmlZRY/X7omRVZ0bhC/FpESnAnF4NZFB+X6VfFP/M2KGuoWvgyEMbN9iDHErUnv2EUS8P9ZSKdmsezYWZ2mEbglT5NBnN7KZ1BQ4nikEQxKmHB5DdsA4DpeKn98n7JyyELw7Xskof9M+bh6iV+8K6sP7r10Ku68iPqB2GUWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t44ENy5xIuML/qEY5eg00GdrJ89HQTqUh21ayYVZtM=;
 b=tKEd3OioFmD6Y24XYYy4aKylKoPjxYMEOe/g6RwwnO5I9B8wfqdKWldQ+EvuG2s3zL8abf0q822Hxm7VxHKP0GVOaqRoXHg/xMAhAtRJ+ib2GsRXMqB1IRZYqfMzQ+XdbJrkVj4/yeMiJNRQIc7yFU15AauvnI/ImX24UxHItZ3XdrPYAU0r+wD7Knd/S0ruVjnCccTTSloRm0x2heYJ04mlr2f8fos7R+Fepwu+/K4YT3YtPQDUrXW3svxt0qE2zAv5odREClN7g4OHsuFxq1luwiHOhZf5J5CBIaEAAL8KIyzN/sA0rK7leQud0auAj6qohxqr4ryzglMA1llCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
CC: <sai.sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
Thread-Topic: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
Thread-Index: AQHcabhOGi0n9Cdi0UCkp27ux+09xrUaqT+g
Date: Wed, 10 Dec 2025 10:25:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
 <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
In-Reply-To: <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OSOPR01MB12410:EE_
x-ms-office365-filtering-correlation-id: 7dc923d4-f28c-4181-7465-08de37d677e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dGhudTlFQ0ZYWk1LWDdqb1JiYzQvNC9MVE9IaE9FMEpxVm51UU9EOGo4VEw1?=
 =?utf-8?B?K0dFKzJPMHZFNzNtbEpGWnpUV3hINHA3WDVyeCs5T2NyN21zemZBclZ1L1R6?=
 =?utf-8?B?WGE3dVZsallJQnEwbFlUUTcyamRFUk11anVQd2JEbWVGSzl6NlpPWXAyL0Rs?=
 =?utf-8?B?YW83N0VCelRWZkJuTjVIV0pLeGxXZ0sxUHZLZlVkSFJ1d3VZb2JPSHhKUGhX?=
 =?utf-8?B?c1prUFY5ZWx5NjIvTkx2NDRUNGtXS0NrVG5KWWNSc1FJdnFOTmpCL3ZvbjlB?=
 =?utf-8?B?aVAza08zSitlajd1eUJ2bUNZUnpIY01QLytKQ09nYlBKTm52TmlGYzl4OE02?=
 =?utf-8?B?VytiUkRZUmVIWkhKUVdhdlBWbXY1TGtUMTNKdjFqZlNPalk5S0NHdEY4Nll2?=
 =?utf-8?B?LzVCTW9tZEszaVNHMDM0dVBHellIeE9tQ0s4NjFwN21SZUdMWERMbXY0Um9Z?=
 =?utf-8?B?NUxnRjNtYW1QS0xVSXR5RjFTbURwRForaWViNlgzamdGOHhTaElwejhRSXZU?=
 =?utf-8?B?NDV4MVc0N0pqZHRzWGdXNllhUWpleEtXQTRxTjI5dWN3SDlmdGRvemE5Vkcv?=
 =?utf-8?B?eU82RVI2elhxQ1JCYUlPalU2dXdSd0ZLY3dNRktPRXFQN3FqaTBOcUZVT0l3?=
 =?utf-8?B?UUJYdVZYTWFtVlg3TDJxZ2o5Z3VGR0xwazl2ZSt3a2tvdnozM3lDbzk3cGU3?=
 =?utf-8?B?b2t0dEU0ek05R3lFLzlkWDk0R3MwMHhab25XYnpySUdaclg3bDdPUGhqVkgv?=
 =?utf-8?B?T0NnTWJiYkdsYmI3aVpsMjZGd1doUTdmWmJFbGlMTXJzbXBxV2FMOVpqTXo5?=
 =?utf-8?B?NUNxMWhpZTNOVGRZNVVTc056VzN5OC9CQnJCSDFrdmFlSHZyc2lSSEU0aDN3?=
 =?utf-8?B?TUpwVFh5Tm52bUFtVVFDQ3ZmaXdUV0hXODI5TmFGeXkvVnVyNmVtUWdDTFFw?=
 =?utf-8?B?MDJ1eldpQXh6NnVSL0lTKzV0QmVDMXlDOWdIakJ2bjFKaGlZYS9GMEtQaFMx?=
 =?utf-8?B?cGtqK1hZZDJuQy9NUlZpSGYxV2FLaDhvNTVUMUZSTVdlWXhiK1lhZlA3c1Mz?=
 =?utf-8?B?ZGZMK2ROUFdZWGtmTk5qZWNLYnh4eWZKa2pxaUdPSFhCK3c0OCtWUVowN3c3?=
 =?utf-8?B?QldTbkRjeHFaTXB6Z1prYUhCSHJLaUxVUURMZ2NVeERZVW10VVFrTi9QSWVZ?=
 =?utf-8?B?TDlRREgxNjdQSTRvK1JhOERTbEtEOWtVNDltTTROamd5bUw1dWJhNjlkalBr?=
 =?utf-8?B?ZklKUk9takx4c1JGM1dFd016NDQwM3RaTkxtTGFyVERQa0V5Z1hvOVhBb2Zx?=
 =?utf-8?B?cTcrcW82R0ozOVdhY3ZaRE0wcWRmRE45dE5GR2VqcnVUM2lXQVJ0ODJhdnhO?=
 =?utf-8?B?R3IzTkxVVTZZaGdtTU1oZW9YMFNpNjdtaURiWjVsUkl3K29uUGdMVU9Qbldt?=
 =?utf-8?B?YTAvR1JRbEhCOTB3eWlQb3dFV1U0QnFwNThlU25hS2FjMklQOXBXQjdGRkZ3?=
 =?utf-8?B?Vy9aRzRGRDdRNGRuOFo0dXgvWDR5UDd5eFZHV2t5VUc4ZlQ1ZTZ0bGpFeEd2?=
 =?utf-8?B?YUd2K24wcFNWK2FrdmxnZXBVRTM0SXJUTTBLUDVzTy91NTFleTB4NlJ4Nlg5?=
 =?utf-8?B?WkNmTHFlSnAxdk45eExlc0dIeVlZVHFZcjRBYUpKeVdibEZrTlR3V1lnQi9x?=
 =?utf-8?B?MjFEMTZ2UGFPL1dtRTlhcUtmeW4vcTFiMlgzWHVydWFMcG5mVCtIdEZhVFpr?=
 =?utf-8?B?d0NxbzFsVzlXSU1CN3JzZm52OEMvc3Y3OEhhS0xqQ0RWUDhRY25oMFVZWnR0?=
 =?utf-8?B?TVRRNElYZ3N4VzQwV0wwSW9JS2hwQlQzcEVteWdxb0dCL2EwcVJtS05MNnZX?=
 =?utf-8?B?K3VVcTlxanVTV2tOMmtseFRaN2xqZlZJN1RqazIxVmJiakpsMEw5MFkraW9R?=
 =?utf-8?B?UWNuNDBMSGM1ZldreHpjQWpGa2xuamdheVNHbWwzSmc3TDFnQzRhM2kvdVB4?=
 =?utf-8?B?RGhsTUJxV0xYNUJHSU9mNGVrVFdaQ0xKZktFaGpCazkrUVV3WFlhSTVyaGo5?=
 =?utf-8?Q?1r/lIM?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0FKNk5hK2NDTUQ3aUxLTVNjSzRzWTNoVWhzUUV1aHZwRnFQSUdPSnhwVHZ6?=
 =?utf-8?B?OUpDRTA1RjB6NDF5TGRUTjlBck5Rc3lZVGNXUjhXSndKUE9PR1ZOQWdDV0Vl?=
 =?utf-8?B?dFBpcjZidUZSWjJRNEIxd2xJMlc2NnhhNmZ5WFI0UDN0ZzZZdVJ3eEZ3UDl2?=
 =?utf-8?B?bWt4TzJISjBHcEpabU9MUVZuWTlpNnBnd1lKcUFEZDlMay81NXdMZ3ZWMCs4?=
 =?utf-8?B?NmwwKzVKY1JZRCtTTmdUMWxyTkh6RG92R0txdUY1ZFVYNzlCSEhqTkxCbksz?=
 =?utf-8?B?Zjk0elRhMEUrS0NBM2RTL1I0QjdlV05vc1FHY0NVOStrSktxeFlTNklueDF0?=
 =?utf-8?B?ZFZoMHJSdkJqeVIzSHVuZHZpSit0cWx6WStyUWZBdFZwRE9mdUtod1ZGekVZ?=
 =?utf-8?B?R3ErVXp2eU04NWxtaGpGcDUwUGs1aGM0OWZhc3ErZ0xnRzkrZzY2N0ZIak9l?=
 =?utf-8?B?czdibXphRmxDcWFLSHNEbmhyL1lzVkZqRldqS1dhVWlDdGlndWZCSDJJRmJG?=
 =?utf-8?B?SkxqUER0T05TYkZiTkl2ZHZ2YlRLNXMxaEsydDFxUnRwSFR4TTZkbEpIaEFz?=
 =?utf-8?B?bTJsQXBCVWxsNzdtbDFKcjEycmp2ZUJ6WU5OM2FDNEdDU0NRbDBRaFRqMHRa?=
 =?utf-8?B?N2ZSM0hkM2tVbWptL1NHSFQyeDRWZGNDNVhnVDhLUitIQWY0MWpzaVFYZ1Yx?=
 =?utf-8?B?eWxBdm1EQm4wZ0dVSVpMR0F5RzNyVHc2Y1owcXFkUlRLZGx5U3U2VVZvYmg1?=
 =?utf-8?B?ZW5WZGNFb3VFVFZWcDA5MXV4Uk13QTJERE10YXdTOW9ROXYvK0UyWDVPL1Rm?=
 =?utf-8?B?Wkpra29LdjUxOGREK1hGVkw2cGZCN096TGx1OTgrQVIzRG9qWGlmNHJPWFBG?=
 =?utf-8?B?ejhZNGNWOVhaRWtaQ3p5blhUTERNd3ovT0JSMDJ4UlV3VjZlay92STNvTyti?=
 =?utf-8?B?c1lPeDdVZVczRS93RjhNTU1qWDdqWXFBYkIxMGE5WkpaODNHSmJJYXBKMC91?=
 =?utf-8?B?aGUwSnk2OGtDUGlxL2pVR2VCSUgvc0pRUFI5R2wycVAxZEpLZ1FGVDVGVGFT?=
 =?utf-8?B?SGJnMHJQdnlIdFZpb25FNlVzeUtFODRESVZJcHV3QlFUM1dMaGVUc2htZXdN?=
 =?utf-8?B?Z3k5NzA4L2pFWGlkSE5PeFZuTG9wK0VBYjd0ZnlSTkZHenorYzZReFdnaWFi?=
 =?utf-8?B?bnRmZWdIeE8zOVZNRndwSVlCaVhZWFhLTXp6N0J1eWFvOU44U1JMdXl6bVNT?=
 =?utf-8?B?cHVZYXdYMWNZSVBkVGhNd3dxTEt0TGNTd3R4WS9lRXBtUW1Zcmt6eGxSSEhx?=
 =?utf-8?B?TVI1N3dhSk1CRVJ1T2d5VllOc1d6cE4xSXRxb3lDTG9FY2w3Yk5JaVZNdy9p?=
 =?utf-8?B?VytueURjNUh1M1JCQkRlMFNsRUhWZG11ZjlaS3lBZUFjZzZhVDFqOFp4NXIr?=
 =?utf-8?B?SkJlVkh4NU1TVjNhSU52ZmJNL2dNQVc0K1ZxMUp4UUxQZFErNTdmMmwyQnVV?=
 =?utf-8?B?Q0pObW1Jd1A3Z0JLTkhidnM1b1FkVW55OHVCOVF4bDR4Syt5OVE5QXFwUVUr?=
 =?utf-8?B?RVc0K0NrV2xqQWgxaVFQMGs5bkZWd1RFQ05pMHNLY2JtWmFrc0NuYmp5WVBF?=
 =?utf-8?B?Q1dFVlVVVXhxV1RqaHR5ZjU3NHJSNmtZb1o2aEFTc0FkL1hqNlZlbkF0aXEz?=
 =?utf-8?B?ZDc4WVdubkpBNFRZMXRuOXp2OXI0cEpGeVY0VytOV1NGQ1F3RHJCK0JNV2pU?=
 =?utf-8?B?VnU4NWhZNWlhbkJTM3J3b0pNckVadzd4WXdXbVNMNHRDbWxjcVpmUVg2TlNL?=
 =?utf-8?B?bDJkakd3V0k5SUpYU2RvcE5YK2lXeUV1QVdieCtrL2dRcmM1TUw4V1RsYlhF?=
 =?utf-8?B?TUlTV1N2RGo4QTJLTEdZUUxqY3VZcFlaRTlzak93ZHBIYkxIb09zcTYyOVlD?=
 =?utf-8?B?SHhUd2sydWp5bEJpb2dUK1NxUEowYXdzdExZQXVMVGY3TjQ5QngrRmFjNVdl?=
 =?utf-8?B?ZmllVGJ4bnhEdnd0bGprWWJOS3ZJaU9OSXdKRGlXL1J0RnlISDJNODYyaDhx?=
 =?utf-8?B?N3ZyY01FcHAvM0QxWGVNM1JqY2hLcmkxcUp5ODVabFdYZ3p4aGc0Nlh6eGRi?=
 =?utf-8?B?VFBHRDhKODZnMVYyUE00VkFtekpwWDdFUHNYNlpYT241eFhMUVllWlhUMGxj?=
 =?utf-8?Q?1kFfDrc4Uh/rUQ9bNN2cv0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc923d4-f28c-4181-7465-08de37d677e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 10:25:40.6768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6zYT/tMh8b2JFbPLEhfEnHntlKCkzPemU9ImB23NwQn3FDSuraB6Ja5GFFZYGipSKcU9ZKhaeLjRd9EeKkrJ9kBRymzx7PPR96n1cKB6V0wzyfMLzNpfNfhMb9P/Hy0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 10:25:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20959

SGkgUXVpcmluLCANCg0KaWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHRoZSBzYW1lIGxpY2Vuc2Ug
aW5mb3JtYXRpb24gd2FzIGJlaW5nIHVzZWQgaW4gdGhlIG0tY29tIGhlYWx0aCBjaGVjayBqb2Jz
IGFuZCBldmVuIG5vdyBhbHNvIGl0IGlzIHVzZWRbMV0uICANClRoZSBtLWNvbSBqb2IgdGVtcGxh
dGUgaXMgZGVyaXZlZCBmcm9tIGhlYWx0aCBjaGVjayBqb2IgZGVmaW5pdGlvbiwgc28gdGhlIGxp
Y2Vuc2UgaW5mb3JtYXRpb24gaXMgaW5oZXJpdGVkIGhlcmUuICAgIA0KDQpbMV0gaHR0cHM6Ly9s
YXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTIzODA4OC9kZWZpbml0aW9uDQoNClRo
YW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBRdWlyaW4gR3lsc3RvcmZmIHZpYSBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNClNlbnQ6IDEwIERlY2VtYmVyIDIwMjUgMTU6MDUNClRvOiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZzsgamFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KQ2M6IHNhaSBhc2hy
aXRoIHNhdGh1am9kYSA8c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPjsgZGluZXNoIGt1
bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lw
LmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPv
vLDvvLQpIDxrYXp1aGlyby5oYXlhc2hpLmY3NEBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0OiBSZTog
W2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIHYxIDIvNV0gdGVzdHMvdGVtcGxhdGVzOiBBZGQgdGVt
cGxhdGUgZmlsZXMgcmVxdWlyZWQgdG8gZ2VuZXJhdGUgTS1DT00gam9iIGRlZmludGlvbnMNCg0K
SGksDQoNCk9uIDIvNy8yNSAxNjowNCwgc2FpLnNhdGh1am9kYSB2aWEgbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIHdyb3RlOg0KPiBGcm9tOiBzYWkgYXNocml0aCBzYXRodWpvZGEgPHNhaS5zYXRodWpv
ZGFAdG9zaGliYS10c2lwLmNvbT4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHNhaSBhc2hyaXRoIHNh
dGh1am9kYSA8c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gICB0ZXN0
cy90ZW1wbGF0ZXMvTS1DT00teDg2LnltbCAgICAgICAgICAgICAgICAgfCA1MiArKysrKysrKysr
KysrKysrKysrDQo+ICAgLi4uL3RlbXBsYXRlcy9zd3VwZGF0ZS10ZXN0LWFjdGlvbi1NLUNPTS55
bWwgIHwgMTggKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90ZW1wbGF0ZXMvTS1DT00teDg2LnltbA0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90ZW1wbGF0ZXMvc3d1cGRhdGUtdGVzdC1hY3Rpb24t
TS1DT00ueW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGVtcGxhdGVzL00tQ09NLXg4Ni55
bWwgDQo+IGIvdGVzdHMvdGVtcGxhdGVzL00tQ09NLXg4Ni55bWwgbmV3IGZpbGUgbW9kZSAxMDA2
NDQgaW5kZXggDQo+IDAwMDAwMDAuLjQ3MTYyMjUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90
ZXN0cy90ZW1wbGF0ZXMvTS1DT00teDg2LnltbA0KPiBAQCAtMCwwICsxLDUyIEBADQo+ICsjIENv
cHlyaWdodCAoYykgMjAyNSwgU2llbWVucyBBRywgUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6ICAgICAg
QUdQTC0zLjANCkkgaGFkIHNvbWUgcmVxdWVzdCBhYm91dCB0aGUgbGljZW5zZSBvZiB0aGlzIGZp
bGUgYXMgaXQgaXMgdGhlIG9ubHkgb25lIGluIENJUCB3aXRoIGFuIEFHUEwuDQoNCldhcyB0aGlz
IGxpY2Vuc2UgaW50ZW50aW9uYWxseT8NCg0KUXVpcmluDQoNCj4gKyMgVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgQWZmZXJvIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIHZlcnNpb24gMy4N
Cj4gKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2ls
bCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4NCj4gK2pvYl9uYW1lOiBtdGRhLW1jb20tI3Rlc3RfZnVuY3Rpb24jDQo+
ICtkZXZpY2VfdHlwZTogbWNvbS1tdGRhDQo+ICt0aW1lb3V0czoNCj4gKyAgam9iOg0KPiArICAg
IG1pbnV0ZXM6IDE4MA0KPiArICBhY3Rpb246DQo+ICsgICAgbWludXRlczogOTUNCj4gKyAgY29u
bmVjdGlvbjoNCj4gKyAgICBtaW51dGVzOiAyNQ0KPiArcHJpb3JpdHk6IG1lZGl1bQ0KPiArdmlz
aWJpbGl0eTogcHVibGljDQo+ICtjb250ZXh0Og0KPiArICBsYXZhX3Rlc3RfcmVzdWx0c19kaXI6
IC9ob21lL2xhdmEvJXMNCj4gK25vdGlmeToNCj4gKyAgY3JpdGVyaWE6DQo+ICsgICAgc3RhdHVz
OiBmaW5pc2hlZA0KPiArICByZWNpcGllbnRzOg0KPiArICAtIHRvOg0KPiArICAgICBtZXRob2Q6
IGVtYWlsDQo+ICsgICAgIGVtYWlsOiBjaXAtdGVzdGluZy1yZXN1bHRzQGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZw0KPiArDQo+ICsjIEFDVElPTl9CTE9DSw0KPiArYWN0aW9uczoNCj4gKy0gZGVwbG95
Og0KPiArICAgIHRpbWVvdXQ6DQo+ICsgICAgICBtaW51dGVzOiA2MA0KPiArICAgIHRvOiBmbGFz
aGVyDQo+ICsgICAgaW1hZ2VzOg0KPiArICAgICAgaW1hZ2U6DQo+ICsgICAgICAgIHVybDogDQo+
ICsjcHJvamVjdF91cmwjLyNicmFuY2gjL3g4Ni11ZWZpL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5
LWNpcC1jb3JlLSNkaXMNCj4gK3RyaWJ1dGlvbiMteDg2LXVlZmkud2ljLnh6DQo+ICsNCj4gKyMg
Qk9PVCBCTE9DSw0KPiArLSBib290Og0KPiArICAgIG1ldGhvZDogbWluaW1hbA0KPiArICAgIHRp
bWVvdXQ6DQo+ICsgICAgICBtaW51dGVzOiAzMA0KPiArICAgIHJlc2V0OiB0cnVlDQo+ICsgICAg
ZmFpbHVyZV9yZXRyeTogMQ0KPiArICAgIHByb21wdHM6IFsicm9vdEBkZW1vOn4jIl0NCj4gKyAg
ICBhdXRvX2xvZ2luOg0KPiArICAgICAgbG9naW5fcHJvbXB0OiAiZGVtbyBsb2dpbjoiDQo+ICsg
ICAgICB1c2VybmFtZTogInJvb3QiDQo+ICsgICAgICBwYXNzd29yZF9wcm9tcHQ6ICJQYXNzd29y
ZDoiDQo+ICsgICAgICBwYXNzd29yZDogIkNJUHNlY3VyaXR5QDEyMyINCj4gKyAgICB0cmFuc2Zl
cl9vdmVybGF5Og0KPiArICAgICAgdHJhbnNmZXJfbWV0aG9kOiBodHRwDQo+ICsgICAgICBkb3du
bG9hZF9jb21tYW5kOiAiY3VybCAtSCAnQ29ubmVjdGlvbjogY2xvc2UnIC12IC0tdHJhY2UtdGlt
ZSAtLW91dHB1dCBvdmVybGF5LTEuMS4xLjQudGFyLmd6Ig0KPiArICAgICAgdW5wYWNrX2NvbW1h
bmQ6IHJtIC1yZiAvaG9tZS9sYXZhOyBta2RpciAvaG9tZS9sYXZhOyB0YXIgLUMgDQo+ICsvaG9t
ZS9sYXZhLyAteGYNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RlbXBsYXRlcy9zd3VwZGF0ZS10ZXN0
LWFjdGlvbi1NLUNPTS55bWwgDQo+IGIvdGVzdHMvdGVtcGxhdGVzL3N3dXBkYXRlLXRlc3QtYWN0
aW9uLU0tQ09NLnltbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi4w
MmIwYjAzDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvdGVtcGxhdGVzL3N3dXBkYXRl
LXRlc3QtYWN0aW9uLU0tQ09NLnltbA0KPiBAQCAtMCwwICsxLDE4IEBADQo+ICsjIFRFU1QgQkxP
Q0sgMQ0KPiArIyBGYWlsIHRoZSBqb2IgaWYgc29mdHdhcmUgdXBkYXRlIGFwcGxpY2F0aW9uIGZh
aWxlZA0KPiArLSB0ZXN0Og0KPiArICAgIHRpbWVvdXQ6DQo+ICsgICAgICBtaW51dGVzOiAxNQ0K
PiArICAgIGRlZmluaXRpb25zOg0KPiArICAgIC0gcmVwb3NpdG9yeToNCj4gKyAgICAgICAgbWV0
YWRhdGE6DQo+ICsgICAgICAgICAgZm9ybWF0OiBMYXZhLVRlc3QgVGVzdCBEZWZpbml0aW9uIDEu
MA0KPiArICAgICAgICAgIG5hbWU6IHNhbXBsZS10ZXN0DQo+ICsgICAgICAgICAgZGVzY3JpcHRp
b246ICJUZXN0IHNvZnR3YXJlIHVwZGF0ZSINCj4gKyAgICAgICAgcnVuOg0KPiArICAgICAgICAg
IHN0ZXBzOg0KPiArICAgICAgICAgICAgLSBjdXJsIC12IC0tdHJhY2UtdGltZSBodHRwOi8vJExB
VkFfRElTUEFUQ0hFUl9JUC90bXAvJExBVkFfSk9CX0lEL2Rvd25sb2Fkcy9jb21tb24vY2lwLWNv
cmUtaW1hZ2Utc2VjdXJpdHktY2lwLWNvcmUtYm9va3dvcm0teDg2LXVlZmkuc3d1IC0tb3V0cHV0
IHRlc3Quc3d1DQo+ICsgICAgICAgICAgICAtIGlmIHN3dXBkYXRlIC1pIHRlc3Quc3d1OyB0aGVu
IGVjaG8gc29mdHdhcmUgdXBkYXRlIGlzIHN1Y2Nlc3NmdWwhITsgZWxzZSBsYXZhLXRlc3QtcmFp
c2UgIkZhaWwgam9iIjsgZmkNCj4gKyAgICAgIGZyb206IGlubGluZQ0KPiArICAgICAgbmFtZTog
c2FtcGxlLXRlc3QtMQ0KPiArICAgICAgcGF0aDogaW5saW5lL3NhbXBsZS10ZXN0LnlhbWwNCj4g
DQo+IA0KPiANCj4gDQo+IA0KDQo=


