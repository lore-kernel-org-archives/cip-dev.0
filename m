Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE92C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 06:18:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.9841.1749017877150385313
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 23:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ifve19Qy;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1749017870;x=1750227470;bh=hN5IP87UCLsJrEvPL2N7HozdReXiS+allXZ3HiT
	T/7g=;b=ifve19Qy8/5ihqGp35ym0h3qoBX+tDolFjAEi6W6DQcmfVA3Kls/U/AQBXgVptCTLcdHu
	EzApG6xA9YKKzNIakZodZw5O/O/YBXQ/unlYwwfVU3Kg76e6eqe9JEl/PvuASt6sSLm9SD5EkLQ2a
	4juZVa/wY69aqca7ZhH/PQa4uFbD/4r7sPgfBWUgCYiXoiLwC1G/VRbm8YNRkmuogeE6Hw5CXYup0
	GLQ4oPttScW/ItNMKPLmECidPmwuZvJ90mWAvz1CHsFLVhf7Rx5GTh/TfdcQIOSJjNTlLp7Krh8iG
	lH7o+MYCv2FAea0nBO9nG4/cgAR1vNAbhYC5L8fwFQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5546HnT7565470; Wed, 4 Jun 2025 15:17:50 +0900
X-Iguazu-Qid: 2yAbpfLvIQ2FIyelcJ
X-Iguazu-QSIG: v=2; s=0; t=1749017869; q=2yAbpfLvIQ2FIyelcJ; m=YuoSZy6bDzpmVqpnyMIsZjs7K0Lrw7aLsWSEmBG6fkU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 5546HmoX3064256
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 15:17:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN8KxInmiAswCZsBolv0Xe8E29SQ6BWpDhwa2gZitKYpMSMEgQcNaHON2XQe6qgKeWdZu9R07BbhurRt3lJXbRF6S2aE/BGDjW81W5G+FwaZ/QYXsfWqIg7j/Dtm6z/wKyio4s1Zi9o3aTPFWBZ1cPScpqus/svQj/X5IfU+0odh+2BFBTq28tpp03NQC1gVNYWHGR8jmVlGG8ljAnqWKqZeVbj3GP8MFFRvfUbM0GVnEPRpBVHTbSOObt9WXbDRO8utpc5874IzbfB9opmabGOnQ3LTe3QK8OV+yJOTdE9q3TpU6ny/lmALOT2hCx3g2t/xCeoEG1XeVEmYS3Fp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNsbg7noM62T6DJbnzAAUZH8WU1TJcoImeM00TMyJ7U=;
 b=Jbo9KDg5FJ1FxfEktwaTUB18rsUtISmkrqfJTIppwvSo6QdDwAn0i6b8DEY7L4rBqyqfRh3xd5PIBnFlXc/aMDwSthmbE8a/KMAkSgQdCNxNJc9E5heFbR+cVSk00FIYSsN+mr9hOCMBIpCLHqpXSkW3pHfMtbvNt5fVMzslwZsPi+obxE+mQQmQiFkBqghTsoZOeAV7g1w9T8sNOxVt+sg6K5Fh9i6GZj2ZgozmnTkl6Ny1H7oofvv4hTAhC+s6dmFAggsqINijSPwLMzrZKukytPEFRzTJV3ARYx+l4wNoSHS+zQ/blXj7/GSpSo/qqC44FVRBF0eABbeJl9DiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
Thread-Topic: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
Thread-Index: AQHb1Gi45l3NxX9H20apxXZgZNmjgbPyhvzQ
Date: Wed, 4 Jun 2025 06:17:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189C9477EF3A5FA4C5AD0C926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9968:EE_
x-ms-office365-filtering-correlation-id: 95a72a8e-4322-4820-1241-08dda32f85f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Y1creFV4eTdMSFdPTzFjZnk1YVc5a1BqVWJyUHE4N1VweDg1TTBTUWYz?=
 =?iso-2022-jp?B?L2tya3BDazc4eW5wcFlkRFdCdmlrQTJKN091dFB4TFZrQ0dLUWsyRFEr?=
 =?iso-2022-jp?B?a3k0TURwZ2Q0S3N4eWZSblR3djB5UWR6bUdKdDRSb0tDY2hnVjErWUdi?=
 =?iso-2022-jp?B?VUpEYzJ6QU1JVFI2dC8rNW4zbUFHc0FUdVh6VllUMm9GUzRjeS9Hc1ZR?=
 =?iso-2022-jp?B?REVGSEV6TzVRTE9rY1E5ZUFrYW1hbzBrWEZFRm9PZDlQZ0VwNElVdDdv?=
 =?iso-2022-jp?B?em9lcUZnaElsYzdjbmNPVG4yUE53SFo5RWcxMGtub011SmJyNEFXTVpY?=
 =?iso-2022-jp?B?MzBYcXhBMjhBS1dXTk5iOGFGOXNDRXF3dXJ5bmVRT0N3YXluVjNOLzNM?=
 =?iso-2022-jp?B?OUNNNlNsbVBSdzVLUWVJNndnQlhiT1ZjbFBZT09pVFRXS2pTMDZrSlR6?=
 =?iso-2022-jp?B?N3J2NHJCOWJNZE1QeUwwczdjU3pTNEIrZG9IWG1UOFU1bnlJUk1Tc0Z2?=
 =?iso-2022-jp?B?Qkg1ZnIrbnpHUDVYVnZNVzk4bGN5ZDF3MS9wUy9Md0VkcTB6eFRvekh0?=
 =?iso-2022-jp?B?OHRTQkwxUFpRNXlRb2h3SlhGVXB0UnlNRXlLM3VxWWhQaDduUGF2VTdV?=
 =?iso-2022-jp?B?L011RFVEZFFjSVNqaUxwNllqR3lDT0RHQXNyRk9LUVUxNXVYU1JlL3hW?=
 =?iso-2022-jp?B?a2ZWRHM0MkdiVFdqckJqa1E5ZzA0KzlhdmVWMUdZVTdsdW0vL1FaYUFF?=
 =?iso-2022-jp?B?T3VOMmlmbVBNLzJWRlJxaDBTYmV1VWxIOHlRamtsWDJTWWNwVzBrSXIz?=
 =?iso-2022-jp?B?QWZrMGJBQ29QeFU4V3BsZ2pTT0RJSm82OVpnWDJkWXduMk5PcDBDWm01?=
 =?iso-2022-jp?B?dXFQVWhhajcvazVWalBtQ1RsdUI4SWlxUnp6SnRHQWxtY1IrZllTekNQ?=
 =?iso-2022-jp?B?aVhueW9qVy80Q2lEbmVjeTRDRGRyTG12d0w0RHZ0Zm1RbWFMa3BJdENp?=
 =?iso-2022-jp?B?UU1pL2V1Yjh1dXA3UW9tUnVXVUI4TllTV3NFY1pFVEIwUGNGckJJTVd6?=
 =?iso-2022-jp?B?b01tTHpUZ0wyYy9PM1l4eExVLzdWNHhxLzhUQ0RNSmQvTS9OTEl0alZI?=
 =?iso-2022-jp?B?UlNSRFJESkFSUnhrelQxaXVXWTNSTU9PVDlBWEVUdHBJSU1rT2VaVW5R?=
 =?iso-2022-jp?B?SG8ydjVXWnZKNU9yMGRJUmZjWkxZeTBtVDJVYVpoUmY1czlJMzZvaUdY?=
 =?iso-2022-jp?B?bDZLZEJwejhkb2RweGNvb3FGZkhyZGh4d3FLdStHemlGd0d2c2gwTUNw?=
 =?iso-2022-jp?B?aEhKQndta1pZYWRtTzkveUhES25VcWdoVDJCbFRZV2VSVzgyUGJlSGRk?=
 =?iso-2022-jp?B?S2pzWWU1YzVEREFpZkR2U2haTVo0eWZMbzB3S0YxTitSNkVsTUJwcDUy?=
 =?iso-2022-jp?B?RmhJaWV4WThsR09GL0V3QjFJeWRFSWNPdWpUSVFOVFZocnF3aHdIWk9n?=
 =?iso-2022-jp?B?eWZZZmVubU41K2NqM3J3N1pyOUY1R0xramRPck0vT3M4NkZJajBkRUZy?=
 =?iso-2022-jp?B?dk1uY3BoT2h4L3E3ajBjUmJyWHpYMXQzS3hyazVZVzdJYURydnBZNWNT?=
 =?iso-2022-jp?B?WmVpMVM4WVRaT2IwNkRwaDNPdzlhZlI1dGNybGNyWVBTcy9wS3BDYVNE?=
 =?iso-2022-jp?B?c3l2cE4wQmtSbHpVaDZjOHRGRDJHYTNFMnpEUW9BTHdoZEdBdjYwZVlv?=
 =?iso-2022-jp?B?b3ladjliTUFvTWREeGtuYUoxTjZsNVVmMUhqekp2Sm5ZSkx1N0QzYmkw?=
 =?iso-2022-jp?B?S0s3RjJkeExHa3czcWJBYTVSOEJXUjVQK0xXMm1OVnZKNk1hdEgzZk9J?=
 =?iso-2022-jp?B?eHBPRENzRW9zdXd3dnNMY2VGa1FFTCtQWithbHlVREIvd3ZrNHN4VnhU?=
 =?iso-2022-jp?B?bmRsUTVFSDVST3l2V1Y0dE9Eai9nekd2YkFHS3BLT2NtS3dYZjJEVVA3?=
 =?iso-2022-jp?B?c1RhNWtZcUFzZWNWYnZESjc0a0ttZi9yTEQ0NUdsNHNGMEd4V0wzSDVh?=
 =?iso-2022-jp?B?Qk5YMHNIS2lGdVBFMDFnOHFFSE93UjQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Qm1ZamJudG5PbjZYNnBUT2cwZXdxWjRKVExsbGtSVkhWQ21Tc1pUQ3Bj?=
 =?iso-2022-jp?B?RFZjdkdZdjVBTjZWSUtSdm9kS0RtNSttaVE0ZlY0dkFwSGp0ZWRYamVi?=
 =?iso-2022-jp?B?dmV1NnU1N3hkamd4Uk5ZL0EyU29kSjR6OVFQN0t2S05iREFCTFZUR1NC?=
 =?iso-2022-jp?B?Q1BtcitNLzFJNk5SYnVKQ1ZCU2o5RXdqTmp1cCtHdmFGLytXWEMzYnVr?=
 =?iso-2022-jp?B?NzFPaW5qa2d6c3I4cUE2blVXRXdsV3BXcHdEelRWTzVHbmFncEdMK1lm?=
 =?iso-2022-jp?B?SWJDV05pMlljQWFJdVRmWGxpRG52akoyQS9GR0lILzhITStQL0tpVDBH?=
 =?iso-2022-jp?B?L0JqR3k5UGlIWlVNZTNRSk94UzVNUHh3T1FDTFZnc091NCtKMkt3OUxu?=
 =?iso-2022-jp?B?b2NpU3ZRMUJxVnFLbmJDaTFwdk0zOHdndDk0clR6OHE1RFdnKzZPQ3c1?=
 =?iso-2022-jp?B?cVlHdGordTVFNVIvR0IyWjRRZXQybEpCSTJPYXBxSlN3cmlPc3RBR1BH?=
 =?iso-2022-jp?B?dTMvL3I5dW1IV0gvREhFMmxFQjRZODR2SXdoeGE1cmlQVjJ1NEFlK2Yy?=
 =?iso-2022-jp?B?Y0E0bXZ5Q0ZQTzFsOCswSkFyQXNFaEsreVZhd1p1RVNqMDhzQ2tudEcy?=
 =?iso-2022-jp?B?UXdBeUYxeVVyMFgrMURQUU4za2FkMDduWCtEM1RrTW1zWW1JWFdDeHNW?=
 =?iso-2022-jp?B?TFU2eUwvbEdad2Z2OGJMRVBHYjRpZHE1RkwvL2dUQnZkTTVEdGxGV3FP?=
 =?iso-2022-jp?B?RXFaTjd5VDA5Qi9USExaVjdVUFZoV2k0ME1XNGthOXFpRDRqd1JSYktw?=
 =?iso-2022-jp?B?OHRTblVqWUVFRkJBaUQzOUxLYy9pWTdLdWpqMnhyb1d2SnVxYTNLSFdP?=
 =?iso-2022-jp?B?UXBZVXlONS9aN1lJdHZVUXRmT2g3QnY5U1FZejZmdENTRDFLekZiSXBB?=
 =?iso-2022-jp?B?cFpiSzFJRzlGQ1pWSWVvcW9Vbkxuam1lMGhnTkV2Ull6bnN0blhCZ0hM?=
 =?iso-2022-jp?B?ekJCUlpRanBaYVlTY2JhQThyV0UzdGdDV29IZ3ZJQU5iWHBGbjB2S0hW?=
 =?iso-2022-jp?B?bGh1dWxCRHVIQ2dmdVE3alJJbmprVEovZFRlM2NpOUI4MjVZK0sxdzYw?=
 =?iso-2022-jp?B?cDFsa2NpZ3AzTlpvWlRkbnIrK3llQjNIak5iNG1WVFBvQk5IYWhBdERQ?=
 =?iso-2022-jp?B?Skt1VDFsNkh6cW0xNklwTEJpMWhGc0VROHRGUVhoa2tWeWVnalpzVUt1?=
 =?iso-2022-jp?B?MVdLd1lQY1lmQ24wYXMyL3RpZHFxcHFGVzc5TUJPaG84ZktaYUJBSTJM?=
 =?iso-2022-jp?B?ZWhRTnhkdUVqTFRIMVZLQVI1YlZPc3BaYk41NXpidTRFRmVKSjBmUC9Q?=
 =?iso-2022-jp?B?ZTdoMnVSUG9SdXRYZjdmYmp0aDVCTmVEckhQOEE4clZyWVJWU3VMWlNy?=
 =?iso-2022-jp?B?ejhJOWJRaHlLeERZOENqcEpkWS93MHF3RXNjWXRab0VRT2RvQTZmZ3J5?=
 =?iso-2022-jp?B?eVdOTzhseUJjQzhDSVAvdmxhQjN1NlZJYmRmWkEyMlV6aEx4Z1JZcEtQ?=
 =?iso-2022-jp?B?QTFPUXpJSUhVZGJjeFZlT3poYWoxSW1OOGdSMmp1S3FqNmtPUTAxd3dn?=
 =?iso-2022-jp?B?ODJWUnpRTmYwY1dVdmdXZHFjZHVoUml3RGI1N200dFpxUTBXTHRwSmc2?=
 =?iso-2022-jp?B?dVE4VklFQ3BBNUtzWUVITmhKcS9LKzBQVmI0c0FVcHJJUEZlMkZXWlBE?=
 =?iso-2022-jp?B?MllHd3I5czZFN2tIVTUrYWZiVkRmSUxYUjNjZGsyM2p1cVpNMGtFL1Vk?=
 =?iso-2022-jp?B?SE9WMURCV1U5SGE2K2hJbkNwa2ZLdEtqcjFOMkl2THZlMkR0RThicHNn?=
 =?iso-2022-jp?B?c2U2aGt6alloZFBOL0xZUDJVbndKR0k5dXI4UjMvajZRRExvUnFuS05O?=
 =?iso-2022-jp?B?d3JQcGtkYUdPaVBFeGlYeDlieWt5MlUxczg5VUVYM1czRTNTVFZJZnRZ?=
 =?iso-2022-jp?B?QmliWGRGZzhnWURoQnRJQ0JFTkl2SHc5SFFFbTNOcFpZME5NamhWcEt2?=
 =?iso-2022-jp?B?MUVzU0NTd3M1bVNxdFpPL3lZTkd6ZE5GeGJIajQ5NHpMSGNYS1dxalAr?=
 =?iso-2022-jp?B?aS9OeVFJMEpqT2QxazFDdG1INFM3ZVhmOWxZS0l3am9kSFFTQ21oOVBX?=
 =?iso-2022-jp?B?d0hkVXNFVEV2WjB0c0FERUhNeXZkT3NiaEt0MXdYL0VhNXMyczFZZThF?=
 =?iso-2022-jp?B?eDJ3VWlHNVhUcU16ckZSbFNlTXZ3MGpXYTByZnFmdlkrc05hbWpVQ0pi?=
 =?iso-2022-jp?B?Wi9rUXZQU2NRSVhWYUpEYUlkSTdYQ3U2Qmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a72a8e-4322-4820-1241-08dda32f85f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:17:46.2622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22ePdyFdvRMml9kb+ymTql1GGpVliYFBAR2glLfZfv52+Cak6vU7qXABRfd9q4DGW31BGcaVkrvi2jHU7PVob25mcJ+t/jIaOyhlHpaoF2VsNd2S7wc6LB9PeMvdpY2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9968
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 06:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18998

Hi,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Tuesday, June 3, 2025 6:20 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S SCIF support to v6.12.y CIP.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (6):
>   clk: renesas: r9a08g045: Add clock, reset and power domain for the
>     remaining SCIFs
>   serial: sh-sci: Update the suspend/resume support
>   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
>   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
>     different switches
>   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
>   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
>=20
> Geert Uytterhoeven (1):
>   serial: sh-sci: Save and restore more registers
>=20
>  arch/arm64/boot/dts/renesas/Makefile          |  3 +
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
> +++++++++++++++++
>  .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +---
>  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 13 +++
>  drivers/clk/renesas/r9a08g045-cpg.c           | 25 +++++
>  drivers/tty/serial/sh-sci.c                   | 96
> ++++++++++++++++++-
>  8 files changed, 314 insertions(+), 21 deletions(-)  create mode 100644
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

I reviewed this series, looks good to me.
I can apply these, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/185236522=
0

Best regards,
  Nobuhiro


