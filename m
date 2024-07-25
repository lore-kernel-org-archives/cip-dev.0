Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA43C3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 06:27:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.30145.1721888869931416807
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 23:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=qAfLoEbt;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1721888864;x=1723098464;bh=Xz1I5fpFZXKE5D8phXOfJUkZPTN53Ke+E5SGA0Y
	isNE=;b=qAfLoEbt1KKOEQzp2SYvIyhhN5G2dvnrSkV0eFewfOWK1T2+hogJ6gjwpk6ge3X23xf39
	CSl0AZNCxh4LmHHmZj2dsBoDA9Sc9VWtwO89dZg9RX4B6kec00rHewA33fPMUyubNRQhA31m/1won
	clILsiUMva7ohhhJ+YHwgObmTN4ocaTZ2y67SqZUmkdyUmoIx+kDH4blfv3mJCO0GXdFtRQFFlEjq
	syZHNbNFpOsYKD5RiPHK39CusSau7HDjVUjrVo0PjOCdGX73r8C1wKRoQKdg8aR12vfL0DlPVAdIP
	XjFr809dCKXZCopdds8pJJuF1o0sj+jqr4BZAyiIJw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 46P6RheT1451238; Thu, 25 Jul 2024 15:27:43 +0900
X-Iguazu-Qid: 2rWhZiPwXoQwdayoHU
X-Iguazu-QSIG: v=2; s=0; t=1721888863; q=2rWhZiPwXoQwdayoHU; m=jst4pvUYVoAMG4xzRmSTrbPdMA/+lw8CcrWGxgqQXqw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 46P6Rgrg760580
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:27:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvWJEZJJSJMPNQiGBN0Rpqy5H5ud2/wZyEkjz3SQ/2a0Glv+BE9VD686hf5swB6yQaOe0FApEg5Jc1eEhqTq0ARoB3+BwQdVKfrA9zR9f4pRWd9MnDU/TOLmPQOK0fGUExHnalnfRivguCrKEuki3ZfYyZOQSoWFPjYpmxlNeljbK0ve2VY+5xT3aL2HiQWrjlhrId0AklXXVi5V02hrtMGJEuUgOVKQ6uXVCSYv7thWxmWTFf3Vvnu1bhs5WrrVxatpEjI6C4CEW7cgGIMT11X2RMI1fmwQYc1fxjtVWKB5iUKc/pOU3aHn1bfgHExH8ouX6dpRpVKYkM9WgegUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkRqpmOMLeeNJYA213nUeKzC8geTLVV8iaQGWP5oaGY=;
 b=rqZ75GhD6TJ3hTso9Gr75MoEvmbfdAd3hPAUVgF3wGaRh2jrUziucE4yjlN54hxCM3mF7jC2vcqBQ1g8XFGXf+AriMsOyPgcyNg398xK+pHR0zoWGhHCSyz38FsedkTU4Dyeq0toD7kxjJme77F03Wh8/EsRGZcEw59K2F+odhQeqYU6wro8D3HNGxY+09VTS06oabZ4iOY24GDSVQFXDiy3l0DuxwQXcKPRzZtyHXbmzwpmqylCG7jIRE3UIRVl+VovR7o6h6uGuq+5kCiaxsZmD6nGfd1SxMCyj7roUAuoUsYad7oyCz3c4sEOG9vDaMAYQzMVSBgvRbEAwXTqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <paul.barker.ct@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Thread-Topic: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Thread-Index: AQHa3Z+dCx5tgM/X30ORdpjx0AxTjLIGJdcAgADWK9A=
Date: Thu, 25 Jul 2024 06:27:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E6882BDB0FABD2E7B60D92AB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
 <ZqE8gLGPCc93dZFz@duo.ucw.cz>
In-Reply-To: <ZqE8gLGPCc93dZFz@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB9589:EE_
x-ms-office365-filtering-correlation-id: 33556b1d-36dc-47ce-1ab0-08dcac72e279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MkpvaW9jRkVvTE1kQVBLR0VvVzdtUGxtY3l6eFIrMHZGRGRJRXdKb3FW?=
 =?iso-2022-jp?B?N3l2VXU3cVQvdDFQblgxbktzQjZEcEk3STBxN3ZLZlZJMndBQy9URnRJ?=
 =?iso-2022-jp?B?T20vTXducTM2blQ0TkRzMTZXV3VyTmZqNnVVMmNVbU1iN3Via1M3ci83?=
 =?iso-2022-jp?B?d0JzUVBSRzdXbDZWVHZRSDNnQkJKbWJPTTRpTTRTbXE5WlQ0MkRRSTlF?=
 =?iso-2022-jp?B?UmJtOGg2VHBDRTZ0NjdNemEzYjIxMXFPK2dCRng4a0NjVVFnQndUbXBv?=
 =?iso-2022-jp?B?RkV3N2JGbVRXUVFGcVA1YUt4WUJRQVJqNU8yU1VsYWU2YVVUVGNUZTF1?=
 =?iso-2022-jp?B?S0FJald2QzRJY1FqY1Z4T09DbFF5dHdkNmNibnllMWhKclRJQ2dOT002?=
 =?iso-2022-jp?B?Y0FXVVdRZDRKL1AvOFViZmNUdGdzZWFUKzV5ZGpxM3hjUjdHNjc1SVlW?=
 =?iso-2022-jp?B?dkQxSzNrVE82VnJXUmxyZW9EQ0pVVWxmZWY1bXdHa0hmL2NYNXlUY1Jm?=
 =?iso-2022-jp?B?YWpsVjJKUkZ0aW1Cait1Qkg2R0FpN0pmUkFub1NFY3hyN25KN3pXWnRn?=
 =?iso-2022-jp?B?VTNCOVZQN3JOekFvZHBJaFNNRDJsOGRVcEc5WlpiYkhLU1dFVHBkbWNL?=
 =?iso-2022-jp?B?dE5sWWRENklCTTZ2c1lWYituZERLT0Yza2FoK0xTNWhhTVhhQVllU2hu?=
 =?iso-2022-jp?B?M0Q4Mk44TGc1QzVMS0ZDUktDV2FzR0tzVTRIencrdVU4b1FCdEU5UkRY?=
 =?iso-2022-jp?B?OFNtdWUvMGl1TTRvaTlmUEJFTU1wN0dYVnd2Q2RyeVdmUUpmc0lRNTdz?=
 =?iso-2022-jp?B?OTZ5S0oxY1RkRS9waWcwRFdMU0xVenRYNzNsNXdhN3lkMlZIZ2dCbTQ2?=
 =?iso-2022-jp?B?NllPU1c4elcxbU9IcHE5dnlqTlRlaGdjU0FKVzdVZTJ4Ym1TUS9OSkZq?=
 =?iso-2022-jp?B?T3FvWkwzZ0U0Y1phMzlXUWFHTVdCMUFvQ1Nrb1VOZnhyeUdyREZ1R1RH?=
 =?iso-2022-jp?B?b0wrYzRIRkVnaE1ZOExjUWJNVERmZyszaFZzZzYyaHYvemRnV2M1Y25j?=
 =?iso-2022-jp?B?aDRaNjVwdFFVaUFRaGVIcUVURUZaVzlEbXZhMFJtdFZSQXVzT1RRZmJP?=
 =?iso-2022-jp?B?RXkxRmxIbGZmcm1NMmdrVjFiRXNoU0dXM25SMnNMaklFSmk1dG5GQmdj?=
 =?iso-2022-jp?B?Y3RZdHJoeE1DbHBWbzA5dk5IbXY2WlJOcmZZdmVzUXZ3L2RLeHhGK0Nq?=
 =?iso-2022-jp?B?ZEROYklkQXIvMHhRVUc2Rmc3bk85eW5pcDJpY0lXeWZqOEZtRzFNZjk4?=
 =?iso-2022-jp?B?Q3F3MGhSakFvbTUvVDlJbmUwQ0pqdWRZN0ZZb1d6eHJtQzBZWFlUVmxj?=
 =?iso-2022-jp?B?S2NXUkhhaDJqbk5mcWViSDdLbUxobFpIUnhwd1lNRGZxT0dwYzlwSmhM?=
 =?iso-2022-jp?B?aVkvWUw3VWJ2WkhuQVFkSXZjRmlPeEd1WngwakgzY2g5MmhsdWlDRGlu?=
 =?iso-2022-jp?B?dE1qaWZiZnNvR3RaYmVXTmFXNzlnWng2WGlCclNGL0VVSU1CbjUxNmFs?=
 =?iso-2022-jp?B?OExFRHN4YzBmY0NEMGFCTjV4Vzd5MURYd2g1L3dzM3kyaXpOTWlodTRS?=
 =?iso-2022-jp?B?QTlxNHczSEZER1JYaGR6QTNmS1dReXNVOXBabFVEeHRYUFZxbi9jSXcz?=
 =?iso-2022-jp?B?R0xjQXUvYmVvMmZ6YVBoN1NkTlFwdE9YM2dJamRrZ0tBcnBtangzWUZk?=
 =?iso-2022-jp?B?TzNpKzRuMXRCWDRxSXJUeXFMTzl5YUtMZ0lKVnJ3NlVHbFdZRFJaNjVn?=
 =?iso-2022-jp?B?VjhOTkN6aGRLUk1Ka0s4dmR5MHUyU29Ja2JVOHp5RytBMGtDd0sybmIy?=
 =?iso-2022-jp?B?NE1ZVUpjc3JtNC8vQ25RUXhnYjl5N0NWZTZud2lYZ0NnS2w3NEwwU3VH?=
 =?iso-2022-jp?B?d2lJL21mMmlNUHhPZDhFZHFwT3lDU0hHUXJZREpsU2lpdnhTWVNrOUtO?=
 =?iso-2022-jp?B?L1A4dWpXQXBJckhxZ2ZVOEl5aFNOK3BVbjl0VlBJcjFmelN5Wk1KYXN4?=
 =?iso-2022-jp?B?eUZKM3o2Y1p6TEFnK01NL2sxOE02WWV0QlBMTWZvQndHSG5icFAyTmh6?=
 =?iso-2022-jp?B?TmE=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Mm9UOVR3OHJKdVRPS1VBMFlEOUU1R0JhUHl4NFBsVDd0dEc4S0ROeHBo?=
 =?iso-2022-jp?B?TVBTT0Rsc1ZDU2pRSzhiQnJ4MTdaK1l4K1lhZVd1TEFUVlRLeFU5UmJ5?=
 =?iso-2022-jp?B?WWdNNmU0V3liUGtKc05lNGUrYVBacHBKUWE1ZlVhNEhNaUdybmt3QXhq?=
 =?iso-2022-jp?B?VHlaTjF0eFdyVE5WbG5YYmtLSHhINU1PN0U1VEMvQVVNNnE2WTIzNW43?=
 =?iso-2022-jp?B?NHlkKzRJUy9iRVBkWVluQ0FiMFp5SDVMN1N0a2ZoZmNzdlpEMi80Mi9x?=
 =?iso-2022-jp?B?eFVWRzNIdUNZZnlyRGdtbTVpWEI0MFNRRTFCVmZTMElsVldraUFtYzFy?=
 =?iso-2022-jp?B?Lys0cldqWHJ4cWc5aHdXaXNZUWR1MjZwclU0OGNjTGxLak1qN2pRUUp4?=
 =?iso-2022-jp?B?L2RMVDFoWDBIUHozREdwbkFVb1NweTlGRFl0dDl3MzJycnRyS21Ma1dP?=
 =?iso-2022-jp?B?THpXTEdpUXpuTitvV0dVOWFzQ2ZyaGZNdEhTSG1WV1h1YlFDUEcwaEJ2?=
 =?iso-2022-jp?B?NnBaVFd0TFhRTUVNUzB2eUVwZ3FzNFNGaXczRDJtNlduUFFUeHoxWTRn?=
 =?iso-2022-jp?B?MXg3ZDdmVUUyMlBlamNYK01OOFhPL2dycFFhSE9OekJockpiUTlNRE1Q?=
 =?iso-2022-jp?B?QjgyNEFDVlpzZktjQVFLbFdCOEl5bjZtMVl3dllObmRLbGhhdmh0a2Qz?=
 =?iso-2022-jp?B?a0lQL1VqUXI3cmY2UzJ4M0NLSDU3OXRaOS9lbndSZGhxYWE1UDdWOXZh?=
 =?iso-2022-jp?B?cFJSZmhmR0EvejNHQWJMN1gvL2V3bXZ3NUN3NElrVkUzTk8xUlRuVEJI?=
 =?iso-2022-jp?B?TzJZL0FaUHhQbzJWb2Jqd0dxVm9SRDg2WkNpbUJ5Y2pRVTBDRXlCdTZQ?=
 =?iso-2022-jp?B?dEpPOGg1YndKYmVrSUo5VGgyL3BjOEJCMm9jRVF0bEU4amR5N3pMRWs1?=
 =?iso-2022-jp?B?enA0Q1RPZTY2YzJHYWlDYUMvWUJSTW9oMEhRUWlKQTBpWnlGREFmMXkz?=
 =?iso-2022-jp?B?QzdpNlUzanZlK3ZucFNIemMwa1NlVUdxVElXRy93a0lwV0VBWUMvclZm?=
 =?iso-2022-jp?B?SXJsY3dreFgwMU55K2ZQVk4ydDVUdHhtQytHTW84d1QrSXFveE90ZEJq?=
 =?iso-2022-jp?B?NHFzV3dxVXlZd3pQNTgxWUxaKzVCYjFjVnNlRHQvSC8vM2p2Qng3d3Av?=
 =?iso-2022-jp?B?RERkWHozMUNJOHlFeUJJZHF5cjllbkNJZXVIY296ZjFQcTRJWnhBVWR6?=
 =?iso-2022-jp?B?ZisycVRhSGlvZVZ4UzYrQ08rWDNyLy9ZakRkV01xYWRKelJONE8vSEgz?=
 =?iso-2022-jp?B?VzlydDJLQnFqMkg2Q3dZdXk5V09wWnhjdzBSbWNldlJHNi9QLzVES2Vj?=
 =?iso-2022-jp?B?VStwZ1NvT2tTSyt4QWt2V1M1dlh1WFl1c25EaWdDV3BlUHR0eEJsMkFD?=
 =?iso-2022-jp?B?MmNSYm1PTmMrWXZrOVFIYXJqaGlyVkVFUS9abUkzSzc5S1VBVkhLOVNm?=
 =?iso-2022-jp?B?T1ZEbURES20zTGh3czhqNlE4S212MGtZcmdCdDBrVmxHdGhNRG5NR3d2?=
 =?iso-2022-jp?B?Y0s5NzB4WmltOUY2UXA4bmN5Qm1acmFkeXNSeGtjSXI1L1NFMU5zT0xD?=
 =?iso-2022-jp?B?WDJoUlZleDU5MW1SaGN0QnZPTnZTYmIxQkRybGhBY2FhcE1jc0tvVzc0?=
 =?iso-2022-jp?B?ZnhTY1paeGN5d2VaN0hLZUZ6YWRqcEtoSVZ4RTBBKzJ0WWtLei8rTjMx?=
 =?iso-2022-jp?B?Z2w0UC9UVW5QQmovT3ljb3RqN21CRXprVlhCR3lnKzZOc2ZsMklxTnNo?=
 =?iso-2022-jp?B?M3BkUHJJeG5FeTkwZ0dGck9vcjJDcHhoV3J0OUhLWTdpZlduRnZJQnc0?=
 =?iso-2022-jp?B?WHlYOGNKeVFsSTVTMEdHRmJQK3BNQ3ZvR3hpeFVKREJJeWZQTVJIYjJn?=
 =?iso-2022-jp?B?NjBYUmlDYkFCYWx6TmhKVEY5R0w2UnRxc0x4L2dCWDdINFZSeFRHVDAz?=
 =?iso-2022-jp?B?MWFlOEdrek0zV0NtZGUzNzRjMnN3YTFvSmR4czUwQ1FPTDV3SFROQkx2?=
 =?iso-2022-jp?B?T0NPS0dWNTM4b3o4U0tWRlVxOXBDVGhhNDZ6bEVleHZsUXpIQXZuRDYv?=
 =?iso-2022-jp?B?Mk5BeHlHekpBdXpZZ01rSjd1T05YT2o2Z2hQNHFiMUJWMjlrVGo4ZHZn?=
 =?iso-2022-jp?B?WmxGUUxxVUlaZ29hM0lGRTlZY3dFdlBnbGpjdlg5MG92YkVrNzBYbWJ5?=
 =?iso-2022-jp?B?aUFkN0hVNTBNVmFmLytSRHVoTVBiVW9UaVF1dy8xK2tjbzAyWnpDeUtQ?=
 =?iso-2022-jp?B?bVp0MThpa1orVTFFYkRUeWY1dlhwbGEzTnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33556b1d-36dc-47ce-1ab0-08dcac72e279
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 06:27:40.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6cWBG96CEZ1xs2iPN/PDQ9Di3b9057lJW/bEs03JZ1DDFAaN9mh4WZysCgu8pDYElchAUEEg5qlBlQ3xD6rMRAoaaEShwaV7Zj++1IEAjehzEvCoXSwAA3UO0hQwTEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 06:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16619

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, July 25, 2024 2:40 AM
> To: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
>=20
> Hi!
>=20
> > This series includes all relevant fixes, tidy-ups and other
> > improvements to the ravb driver present in Linux v6.10. Backporting
> > these patches is a prerequisite so that we can backport the GbEth
> > performance improvement patches which will be included in Linux v6.11 [=
1].
>=20
> Series looks good, so I can apply it if it passes testing and there are n=
o other
> comments.
>=20
> I see extra blank lines before final sign-off. That's unusual/wrong, but =
I can
> remove them while applying.

+1.=20
Please remove blank line.

Best regards,
  Nobuhiro


