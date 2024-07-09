Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8EC2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 04:46:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5671.1720500400117300679
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 21:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=IBfEgqil;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1720500389;x=1721709989;bh=+9Idx7x7kLKk9hzi/hkH3Vi5n/EVntItdH3TfoX
	WMOE=;b=IBfEgqilthnS/bzA9ac3F1tb+iNPdCXh8SuZy5p4j+YKJ0DuKsjd+5OSeeASCD9JGXd67
	X0v1aDfWFZau54z1V73vC6o6lSz15hgpqldXYDblY4NWVvUeGEQCCsL9LTXwLuQWhIXYm3xHmKTFs
	vO5L0z0Dz4nHxcMxwMzrNSk4v92OIi+Szc8f8d7XKzxSIYJFydDj+t/iIBO8/EtJB2+AL53CJjYHg
	nPdOrcBBWOOanKsixrzTu1Xb/gGAQmndS+ZwzPyuswpKD1ZnUaJE+WQeskPg8jRbSSEYyedVsqfj8
	OvdIlsbVKnRbgis2g4z7TD+yuLe/Rzu83Vct+FoOlg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4694kSFB2593564; Tue, 9 Jul 2024 13:46:29 +0900
X-Iguazu-Qid: 2yAamb6APVXBBXxdkm
X-Iguazu-QSIG: v=2; s=0; t=1720500388; q=2yAamb6APVXBBXxdkm; m=7WsVcGYJcX5kbniiZ/96YLMshgT+bqq2NbAHnEVqeMg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 4694kRWQ3237442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 13:46:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sah3jfz7EO3pxyEsjNu1dE82I/O5zi/jdXcoBb/h9aoxlUDkd7APEOrUm0eN9fXdX92TTLQFN6rHmSCdqH8D2t55SPR3Ajzy/3EaO7Vy4+zZkuo8Rpq6iHQhCkbHYfV/9fqbzZ9oQlbsi+kD4qSfj/L1mBWieuMrlibbU7+MNmTiQQu9J9KVSnONmAp1LklFio/hy+CZMAhN8HswxuaNV2tcU30H8FZsaDOLPvH0o4YJekyj2Ao5NkGb4sIHO3jUcl+TGfOizMXB7GIXAKHwUhGJ8iJypg7i51yCrLpLHgHRA90kUP/jhuZqr2w7vZ6tRYYlmZrcUL9oxApM8gWSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z+Ae8ftYT1pWeFneP8ndDI4Fm8QHc25/5CqbxwNVus=;
 b=HQkC+kBDaAUPe6c26zVPmnstYVoP1J0fkjedLkyNMvrTtVmd2tsvPugJ4qz4Syxyana3HSm8sF7SDM0i8sQvOvW6BE/zW0vCsFAfpVLKu0UZJ5hMmcBij5H6KsttIH2nxdr31NqmUWwRQv3cd49BSCQEsf8HbwBN9Visy6SL5MqiTGn/4PxlWI9FyboK5ldydfWgsB+iFuMgI818yy0Tgl1IEC9KXj2RHVyUfZIiX/w49vmKPBoT5QLkUggpkg7G2F2nYAOIKfSMA7IEjmhzBOICtcCK0OtkaTCOzdMs5uLmiESlUMd05q760PahWdlXwmsTVvwLGzMik5svhKklSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <paul.barker.ct@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <biju.das.jz@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
Thread-Topic: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
Thread-Index: AQHa0WYbG99RcDiMX0mg26fArY14v7Ht0QTQ
Date: Tue, 9 Jul 2024 04:46:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63885D918692983EA4B890AD92DB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240708183832.33446-1-paul.barker.ct@bp.renesas.com>
 <20240708183832.33446-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240708183832.33446-2-paul.barker.ct@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB7212:EE_
x-ms-office365-filtering-correlation-id: c18b241f-a4f5-4f70-b261-08dc9fd2168e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b1FaVUpKWW53REtvdFN6U1IwakZubmpQUHRwL1ZPMGYzSHlZbGZkQlNq?=
 =?iso-2022-jp?B?WnlLdUhiak9yWDlra1A3RmNjMEtTQ3NIWXhyeitwSkhQdmx2ZjAwc2F1?=
 =?iso-2022-jp?B?a3dqc3ZwdmlvOUR5N0ZnQnRUSmtYRGkyeFNqdG0xRkFCZWRjaXIvY2JL?=
 =?iso-2022-jp?B?c1pQdUhlWkhkdHlSQmxTVmNJdjVoNEhkRmpXYVZVenV1WXFwYVNXV2Yw?=
 =?iso-2022-jp?B?czF6ZUFLaE8xbVBQWUJJTnVZT05Bd1RwU0lCSS9GWHVZazVOWUhyZ3dL?=
 =?iso-2022-jp?B?eERxWU85MzRjZzd5ZGluVGc5R2hJMzAxSHJQbU9UdXpLa1FGRngwQWlI?=
 =?iso-2022-jp?B?Y0NaejNPUlB6QytDNzdqenZFS3JqUldIa2VXdTFNamUzZjJkSUFyRlJQ?=
 =?iso-2022-jp?B?WUxHTjFnQWtCVVEvRE0wN0VKMWJ5dTFWWkN6WmFhdnVCWDJEUHdxa0Jw?=
 =?iso-2022-jp?B?aEVJYithelVBU0NYTlZ0NEVUb0ZyVktEbC9QcnRQY3NHMW4xZWkybElq?=
 =?iso-2022-jp?B?VmdaWnN6MWNFQWZnM3FTOHJCekhQQ2l6enNYc0Z5azNrNWFTd0F0WG9v?=
 =?iso-2022-jp?B?TDlBZDVKWk12WmREVWNONzMzRG5CV0ZCbTYzNnFadHFLdWo0aDdhMzB2?=
 =?iso-2022-jp?B?N3k4SlM2elpDWXZJN1dPMjhVemdPbDRPTjZ0Wm9WalNjL3NzcU12TUlI?=
 =?iso-2022-jp?B?UG9pcjBHODN3ZnRYODNZV21oLzNUTmlGZUx2MExLTGJ4cWNBNDFwVXc1?=
 =?iso-2022-jp?B?UGZpVGlsTCtXKzh4MEhEekJlbmI1U3BYNG8zNmdMOUUyMCtVcy92MkEw?=
 =?iso-2022-jp?B?bDRuaFVycTNHYThtV1dDL3ZFSnR4dVNQS0FMZS9kWU42VjRtNU5VNWx5?=
 =?iso-2022-jp?B?WjBERDA3QnZlKyttWlFFMnMwSGoxaHNXS2VPSjVyQTdNaCtNYXZoN3k5?=
 =?iso-2022-jp?B?ZlVPLy9Bbm50WXlpaGNlTkFZdW9kcVVHbHY1c1NlbmNJcm1EdHU0WW9W?=
 =?iso-2022-jp?B?dWhXUFNRVmE0cm9uNXBaNUtSQzE4UnM4cVduMndzVndFNG00MVlZWStx?=
 =?iso-2022-jp?B?ejVKYk1hK2JWejF4TGZ6NHk0WDVYdU1lZFFYNDhwRmkzV2JSemtIY0dM?=
 =?iso-2022-jp?B?emNwZE1XWDFXRTNZeGVvQ3VTZTBiT0pkNDhnbUREWnV5SSt2SVFQWWl5?=
 =?iso-2022-jp?B?YUJvM2NJQ0hGLzdLUzVhYzNpbEEyN1A3S1NIMCsyM2F6ZmZUMmJPNGNp?=
 =?iso-2022-jp?B?QjRYWDAzY2V3dmM1NTZZbVQzMVE2dTJ5UXBFbEFzOFRKaFBrT0JrM3ZE?=
 =?iso-2022-jp?B?S3cwQjgvL1hNdEhtTGJRYTl4c0VLRlFuM2FBMzFEZDd4bWtmbElFdkE0?=
 =?iso-2022-jp?B?aFMrT0VJTXQ5Q3BDZjBtaXBNVVR6Y0lXSUROWHlzaGxYdmJvdmZmV3gw?=
 =?iso-2022-jp?B?SzlmTWs0bFFxS2NTdEN5cUhZcmdvdnlZWEY1Z1NMalBUMjdrQ2NxQ1Ny?=
 =?iso-2022-jp?B?d1dTN3ZZSk9QZkVwYUJsS2xaWlpBVk0xY3BhQjJRZFpDUURWdlQ2czMz?=
 =?iso-2022-jp?B?bi93Ylg4YjI0OUx6VktEU0xPMy9SQlRMbVNlOTRjVytVVnJwZFZhNE9w?=
 =?iso-2022-jp?B?b3FEUmVLZ2RNR1FwUzg4d0dTZkRzNHVmek5XVTNvZXBmZ21NZ21HdmJi?=
 =?iso-2022-jp?B?ZWx4cVVHOXNlcGhpVUdvbWZmREszZURtNjViQ1lNOVZsdTQrcGp4ZzZE?=
 =?iso-2022-jp?B?S0FhVVBhcUo5L3dyYldpREtuZGhnRm1PUzBUZjMybVlEVTVpakh3NG1P?=
 =?iso-2022-jp?B?NHhDcmhNdVA2UDU0WDlqc0xsL0dGZHVIMnBxOWJPNW93My9kUGNEUXZK?=
 =?iso-2022-jp?B?dXk0Q1ZtYlFVTWlXVUJ5U3gzRStYaGtKMnRSUG9RZWVRNlY2U2xMMFdF?=
 =?iso-2022-jp?B?d2pMVW9samYwbjM4ODhNditZYkdRbTZTQXo2L1lGSlUyc2F5NXppbytI?=
 =?iso-2022-jp?B?c3FvVnFSNzczUVljaXUralhkMEx1ckZYa3MwdGtINnNKVUU4Vkdid2Nh?=
 =?iso-2022-jp?B?UkxPMGtWRnVocXRlNmU2L1BUaDJ3L0FvSFMwNnpTVzZjNy84SVpVMElG?=
 =?iso-2022-jp?B?MnY=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NGNZYjVjV2JrVnZmdElMQUp3eG0wMVdUdTJXaXZPNGRHZXVvSG9Za1NR?=
 =?iso-2022-jp?B?RUpzV3NKTGJ0eDdtZjdoT0hGcEVQYmN2MmlOb3k1THVJQ2JSREtQT0dX?=
 =?iso-2022-jp?B?TlJhdzc2MTM5RmZGbWRrZlB5SjVZUlRXaWxWdkF2OHdqUndsc3BubjMv?=
 =?iso-2022-jp?B?aUZBVkQ2S0dqNlJoYWQ2emd1SERYSk9CaFZ4RmxSN3J6UzZ3SjMxUnNI?=
 =?iso-2022-jp?B?cGJyUk1tMDQ4WUxiQUV5RVNiNURtZ0ZvOG5UMUp3MTd0WFE1aE9XcW1Z?=
 =?iso-2022-jp?B?dG1pZkpoZGMwZjNNa1N0bWlSb2luWXBTYkx4aWJsQlZhRXdPOVZsaWNO?=
 =?iso-2022-jp?B?NWFaQlQ1ZTdrQ05mMzd6dmR4UW5mMWtobHNpWmdIVGtDOTJUR3RSc21Z?=
 =?iso-2022-jp?B?aGZYczRwZGpXYVJuRlRabWMwdzhUa1l1UnZGcDFsM1N4d2JSdHJaM1N0?=
 =?iso-2022-jp?B?b2I3bFprSXRSZFZ3a3NwMmNKRjhSd0R3bzMxTkRmSm16bUlZUWRDVHQr?=
 =?iso-2022-jp?B?a0ZvMHZCbXVQcWdFVUt2WC85bmVSUXRNbmV5cllaUmdhWmVZL0pHMjhS?=
 =?iso-2022-jp?B?UHJQRnBrQk5UWjNhMjdNTGdFMkpyNlpOZnljUDRyTitidHNpeFZrTGpL?=
 =?iso-2022-jp?B?ZlNwbGdjeDliRnNHUkxRT1gxV0NHVDd3Q3dlTkNXc0MwNkVwRDBra3Bu?=
 =?iso-2022-jp?B?ajc3KytnSjRpcHpGbzkyMmZkT081blUxMlNQbHQxdEhOYWFwNEIxL1Fn?=
 =?iso-2022-jp?B?TzVDZlJ0VFI1UVJZUTdMcmVVSEV0VkxVQXMyd3VCY1JOdlJDWFE1MzNi?=
 =?iso-2022-jp?B?Z0o5RVlyMzlKRkNvejVwYi9MMjhMSXBaMHkrYmxjbXJsYW9UVnVNT3pE?=
 =?iso-2022-jp?B?RkZCOUN3WUZhV0RjRVNPcHFrTWIwN2dNOHpiRWdPaklTekc5M1JhUTRl?=
 =?iso-2022-jp?B?ZTZzMm5QQWdrUktKY3ozT3RSRWpDVTFmZnhHRk01VW1kSk9rNUloNDVj?=
 =?iso-2022-jp?B?TE16MUx1c2hIR0pLaHlyQWJvb2JWc1JTTnFoYjdBaHBRZTl2dGJObDBE?=
 =?iso-2022-jp?B?dkxVdWdmdGxEZzBOWCt4WVREa3BRNVJQVkVZdG9jNlZXZTRPcS9WZXhi?=
 =?iso-2022-jp?B?Q1k2VkhOL1hCUzZERkR1cWs0Zm1rVmNjYUt1eFBucUt6MWloL3Urd3k0?=
 =?iso-2022-jp?B?d2J1dWNVZmE4Qm5tRTFKM2NNWlJ3b2xDNmxCWU5xemNhQ0M4K3lLa0Np?=
 =?iso-2022-jp?B?Qnc5WEUyN2NBZ1F1VCtRWEhOaHo4VWZTQVBFbDFyZkxhV0ttRDJEZ0Ro?=
 =?iso-2022-jp?B?Z3djcUljSkVkdGU1R2diME5acVhzbVVZRGdoVnpTNHBaa0lMbFJYWHQ2?=
 =?iso-2022-jp?B?bGg1NXgyeThWNG10M1lySXd0RHFjM0poTzN0RDg2WUhmOTY2NGlQRU82?=
 =?iso-2022-jp?B?a0M2cWhJcDlGMEZ5RUtnTWU1d1pMUG9WNnJneXNPNnBJQWpJdDJjSFli?=
 =?iso-2022-jp?B?ckhwZTVRK3lZZk9GWDN3Tm01SThYcy9nbElhYXJOZ0Y4VHAxUmxkY3hW?=
 =?iso-2022-jp?B?Q3c4c3VTbHlMWlhUMEIxVXN4TjlxS0Y5T1B4V1oxUDFSd0sxcllxTFpq?=
 =?iso-2022-jp?B?Tk9id0pGYm9Na1IrcVlKNzZnS1QxNGl2WVJoWHBpbW0vSEpXakRERjI0?=
 =?iso-2022-jp?B?UzBmSUdKN3crWVRhSFRrMGtKZDBTbDVWUXB2bC9LV1g5a3VHakQ5WEZY?=
 =?iso-2022-jp?B?Y1pkWHdhaHVzalI2cEFlN2xTQzJaemt4VGd1SWdtQ2t3Q1B6TmhESktj?=
 =?iso-2022-jp?B?eWZDSzFPRGlPVWxEZzFHblZ6TnFSMWdZRDBPN3dVNzJ4MEtiTXdKWVkv?=
 =?iso-2022-jp?B?UklVWWtMeVFDMHBNY0c3U0lqWEU4aDZKZ3A4azNxOFZBMVduOGFXWnVB?=
 =?iso-2022-jp?B?aDIzL2hBQzRTK01LV3VReWxEbzhRdFM1MVFXaENOMlN3dlVRcmJNRFRs?=
 =?iso-2022-jp?B?ODZ3R2hFOGR1NTBLSFZISThYNEdld1NPVTNhdTFtK3pTLzJDN3Z6QTBQ?=
 =?iso-2022-jp?B?U3c4c3VnQUlFY0ZBQmNVNG51OE9sdnFFdzhoZU1PQzIyT01GTnp4RUN0?=
 =?iso-2022-jp?B?NnB1aEZFNEprKzgvVEg1bG1oVktPMkgxUnJkVnZjZ01YbDB1RFJpMTNk?=
 =?iso-2022-jp?B?L2RlV0d5WWp0SFdzQkk0UiswRFRuZzg1WlpacUNEejZiemhZT1dIL0tB?=
 =?iso-2022-jp?B?a1htcGZrNnBaZ016YlZ2bFdBQXMrcmhRTmpYajBCZy8vMnFwVGpwMmdJ?=
 =?iso-2022-jp?B?b2htaGd1U2kwN1pHNkpIU0lqSHlzWm9uaWxGMkhHNkl4UXk3OWVwazB4?=
 =?iso-2022-jp?B?OUpsNmFIWkpDTzN1TGZScmV3TFhVVGJzTkYzZGhhZW52T1Y1bjRCOEt3?=
 =?iso-2022-jp?B?SnVXZ1pMOU1yaDhnWGo2WFBPU2REOGxjb1JnPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b241f-a4f5-4f70-b261-08dc9fd2168e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 04:46:25.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMoV4yT7jfxfPPnD4YCkrjjDUyo5oH/DZO+dR3PdlRhRYfKIT4GubRuCv+9qk8f/Hih7sw0KLm4sntwfB0/8398bUznuQCLAnxGrlSz1+6u57h8GVrlAE757CQVVCFgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7212
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 04:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16438

Hi,

> -----Original Message-----
> From: Paul Barker <paul.barker.ct@bp.renesas.com>
> Sent: Tuesday, July 9, 2024 3:39 AM
> To: Pavel Machek <pavel@denx.de>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>; iwamatsu nobuhiro(=1B$B4=
d>>=1B(B
> =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@=
toshiba.co.jp>;
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
> checksum handling
>=20
> commit c7c449502b51c5b5de79f97a42be750b28f6ecee upstream.
>=20
> Sending a 7kB ping packet to the RZ/G2L in v6.9-rc2 causes the following
> backtrace:
>=20
> 	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127
> skb_trim+0x30/0x38
> 	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
> 	pc : skb_trim+0x30/0x38
> 	lr : ravb_rx_csum_gbeth+0x40/0x90
> 	Call trace:
> 	 skb_trim+0x30/0x38
> 	 ravb_rx_gbeth+0x56c/0x5cc
> 	 ravb_poll+0xa0/0x204
> 	 __napi_poll+0x38/0x17c
>=20
> This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
> wrong skb for a packet which spans multiple descriptors. To fix this, use=
 the
> correct skb.
>=20
> Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> [backported to 6.1.y-cip]
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c
> index dda7fb410657..07771bdf0fc7 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -897,7 +897,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, in=
t
> *quota, int q)
>  				priv->rx_1st_skb->protocol =3D
>  					eth_type_trans(priv->rx_1st_skb,
> ndev);
>  				if (ndev->features & NETIF_F_RXCSUM)
> -					ravb_rx_csum_gbeth(skb);
> +
> 	ravb_rx_csum_gbeth(priv->rx_1st_skb);
>  				napi_gro_receive(&priv->napi[q],
>  						 priv->rx_1st_skb);
>  				stats->rx_packets++;
> --

Thanks for this patch. Looks good to me.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


