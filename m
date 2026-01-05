Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF432CD0416
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 22:00:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76483.1767650408897410408
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 14:00:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=i01RlHG9;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767650406;x=1768860006;bh=Sp7BbaxL/Qp4jaWv6ZesW//evbrtkjPldxhh6
	2d7QR0=;b=i01RlHG9ktZCr6OeLnKM2su8Sr167pZUQPeoQYHdIQ2yaa8gp/GHmIxWiJZr4kzvJph
	OBC1oJa7MO4g6MJrJsSs2Fk4Pq/EPITZ+lf9epZgyb9ReT5UFCcQcQesx2hY2qPS/LuKZs8Ss76mA
	3hXxFN92Kr4PqoeJqFHLsxRWNM3gygKXuMxPMwstMxPV3VKI0KiR1WX+oMSWYEavn8EbiwdLwRuT6
	fVYejPFikoy0siMCNuF3Z0fxHJOct4YPGXH34ywEGv+MZXBQFZ3xIHEPvyhDrj5TAmDKQoDE1UarH
	DeEGM4y1wj5VzYLiDtfVrbcGxjz2dmIyXI+v4i1rKlsg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 605M05Rw3512197; Tue, 6 Jan 2026 07:00:05 +0900
X-Iguazu-Qid: 2yAaLE8zt5xHDq5RIA
X-Iguazu-QSIG: v=2; s=0; t=1767650405; q=2yAaLE8zt5xHDq5RIA; m=xrU3xew/JdsDMWcQRhD6XhpQFuHOiwayaTMWARTHvZc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dlSs10Mp7z1xnZ; Tue,  6 Jan 2026 07:00:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT96ONfw1iYs//ighgIo+RecQhCQin8slI/p7ymOkjs565f3Li6LUAJRjsEfRfYzVt0KEJ/6TM8K02zNBK9/rAdRzldTsI7PuLu4Qt8sATfKOwcQDAU8HqyDc6TNo3DVhHEz0YAHUi2bbSexT93jlw/YHbawTyQiQliEUdiHuLlsr0iClW+FHJ+FpjlqDMJpqXm5grVrfNkKObTRnXQTB791l/uZRBSAvnNvuvcHLW/8AmG9fL0JeBxuUDisSd9dn8f7KxF+sLfSAHdNcMhpICl94cQilbUy7J7m3p7k3VUEI8QeZr3oCYnRMH/5kwQT/anKj6pB5PXpxN9W1kJkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp7BbaxL/Qp4jaWv6ZesW//evbrtkjPldxhh62d7QR0=;
 b=nZexcZKHWwwBlRmNQpZT3EFWVI+it5j9Z/fHppcro4eNdItKiQghtHwLiyI3OjIg44BnQGswfblOy16gijyxiatoMp2D1H6UNOkveQeN4J0ackBMXTQTIE0wcW4zKlzIt1hVG1FsMO+J8sA8jVwq6Hm/ZBaGPP+5wkB++6SxwdSbrym2OKw3Dl+GSaFF4oYlS83TFohs2olhDdjkA8SZw/CyGsr088bJFF2k4hHlNSAKQY6dz9eQgf+RXbES45nbKitVuFB4RYWHh7e1Qd4qUCw3+t/5ZYcqtDll+80wxRK7mhBgpivhOXVpHsnjYGGO4vjX/LX0txdukBtKegJ/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: AQHcfd8KZ0N0yIOqxki80+6lHh+CCbVCww9ggACB/ICAANxMsA==
Date: Mon, 5 Jan 2026 22:00:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11896:EE_
x-ms-office365-filtering-correlation-id: 8e02fa9c-e794-4479-dcba-08de4ca5c756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RVFPVEJEdW1PQWFQanpENXpBNkgrWS92eVk1Qmt0dCs0ejd5ZjNtWStZd1RQ?=
 =?utf-8?B?ZnVlYm4vQ3lFYVR6TTdXeEJVQnJwL1ZTcUlyU1g0RVdVb3phVnFXbWpqSm9q?=
 =?utf-8?B?VDY0OTkvN3poRVI2U0JnUjlMcjdOQk14VGhKcmlkKzQ4ZXpMeHM4c0U5Wm5x?=
 =?utf-8?B?SksyQzQzdjZzVXp2QUVvazRwNnZzSWxWd29zOTcyNnZsd3hFcVRNenZtUkZD?=
 =?utf-8?B?MVBxcXdWQjFhNGxmY0NrVENhbXo2R0FUK0hTSkVuK3JVeEFuSndybmFHNnJN?=
 =?utf-8?B?eXRNRU5ZbmZtNk0zZ0ttNTRNSW9KSzljdFBRRnlCM3htZEt2czZUaGdnUzZD?=
 =?utf-8?B?eUNrQUVqQythdGVmbmRmMWtyY0FPakhPOFRJblVzbGtSRDcxSFhJKzI3Vk16?=
 =?utf-8?B?elM4TVMweHE0MUNTNUlRR0pnajJEdndqb1pmUTBkYkRmYUpoazQ5MTYyaC9M?=
 =?utf-8?B?QkJtVk9jWjZRZFpaZCtaLzRMbEdyaithOUpSL1ZHVFZRbTBudTExM3A4YzlM?=
 =?utf-8?B?a3lLWWk0cVZvOTNSeTJKZ1NuemVtMHVwTG05bW4rYlZqL3lraDB2TmFXekNX?=
 =?utf-8?B?Z3FhNlBSYi9vT1dack5RZFBIaEJiYWQxVTNLbVJ3R251ZDBoYmk4L1RpSXR6?=
 =?utf-8?B?bDhXQzUvL2ZLcGhVSzg5emFsSFhXUXdxcnM4RUpXS2xaWUVxaU1jREJtellr?=
 =?utf-8?B?dzFkSWRHYTdsTHovbkFlRk42dkV6bE1SNjl5cHl3eDZrVngrQWtGZjRwckNY?=
 =?utf-8?B?Z1ljMm1mNno1akRTUGlVS2IwRlR2ZE53NnhPdDBmcmR5bS81U1p4NFQ5aS95?=
 =?utf-8?B?RWlOK2llREMxVU1FdVZWa1JiT1ZmdEJCVC9LSHlIc0JBNkdHWDF2VUYvTitG?=
 =?utf-8?B?RDZRbmlzMEt4cDhHakl3dzdDWnJMRVFkVXZoTFVQYVRYWVU2Y3dkM3JqQzFR?=
 =?utf-8?B?T0R1Y3UrZ21PZGUrajI5bTA3SE9IQ3E4bXdQWSsyYjUrZVIzeFJwNlpmdUR4?=
 =?utf-8?B?OUFwbnlLUE12KysvVHZTTmRCdDNWdkRaejU1eFF5WG9Edlh6am9zbWJMYjU3?=
 =?utf-8?B?OVpDQlg1QTEwQzFPb2kvdG5zRTNZNWJGRkE3WHpFbGFRcHdseTRWZjdGZEdr?=
 =?utf-8?B?ditCa1I2d0ZoWi9IQ25DVldNRHN1b0pjd29hRXdYazBJemcrMWZKSHlrQ3FC?=
 =?utf-8?B?T2dRY2lUVEV6b2dwTllIaG1Tc2VqaHhNVzNTWnBiWS9xSlBTNWwzc2dMYmpN?=
 =?utf-8?B?RXpvanA4ekZ4RmlHMlVRbDlSbGVYbVBmbThIdytYT0JQenJPTVRobmRuZUZ0?=
 =?utf-8?B?YUZaU3JGSlczamxlZ2loNkRoTm9XVXl3eGNJM2gwNXBveHZaSWkwSTk2TkZn?=
 =?utf-8?B?QThEWHRucVdyRkJjcklPTWVYTGp1dWdmWUdoOVBMZGpScFFMWFA5TVFOa1hU?=
 =?utf-8?B?K3kyMHltOUM4Zi9PR1lmWUFGa1JJZFUrcGtGM2gxNmJ2allvZlVyTUdyaVdF?=
 =?utf-8?B?OVdGVlgyUC9BSkU4aFBVMG5SSjVVRHkvSnRJd1ZYY3JlQTM3WWRjZmI2MDhX?=
 =?utf-8?B?bGovZTgwZEJsMlozT2swQ2FkZ2J1MHp5VE9Jck9vZUU4bklKa1UxT25RelpQ?=
 =?utf-8?B?djc3amgzdW5OTkI2b2plRi9yUkNvU3RMMFFycmJxM1pGK2lIelVNb0lGanB1?=
 =?utf-8?B?OUI0bUNJNnBHZ05acnlQR0I1VmpaTjh2dE9iaFFEWUEzcGkrdUJKVkNaK1kv?=
 =?utf-8?B?dFczdWhmaG9aRWVtUEkvQmpPbG9KUnJQNVYxelo4VUlpUkNSYkwyUjdMY1lW?=
 =?utf-8?B?enhwaE5vRFRpVFJBU3R2RkRLVzBTeGhDNUlaaTF4SzkrZG1aVHYzNTQvNWgw?=
 =?utf-8?B?cytNQ3ZjVGU5OUNPWjNndEFsb3g5N05ReFVIdHhyZXJzMFovbFpHSldFa1Mx?=
 =?utf-8?B?S2NPR2VWVEtFcVZTeHAwZnlIZDkwbzdWWnZGUWVicTJISVRKRlQweGJBSFps?=
 =?utf-8?B?TTJhYUxnN1hGS1Q4UW8wNk9WS3NRR0V4NkF3aEhIc3MrRk8ycTNua1UwS09M?=
 =?utf-8?Q?1o/mPk?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDV4ZXQ2dHJjbkx5NzNXNFh4UXhxcUtqNVJucWQ1UEdOSmQzbWZrUGJDZ1lJ?=
 =?utf-8?B?eG9EazZIMUpXYlFoblAvSjlLVGhoTEN5bndGOTFMeDF6WUtWL2Z5RDlaUjJm?=
 =?utf-8?B?OVI2WlF0M25xb3ZsYlROazN1UDYwY2l4ckVVa2tKb3F5c1ZPQllsTCtBWlA5?=
 =?utf-8?B?eEY3Um9MbmhtNGR3V1VGNUxHRUtWYlBlWnpucGRJK3gybkg0RFFhR1RKd1Bl?=
 =?utf-8?B?QnRNRTZnRlMzZ2l0aVozckFIWTY5WlFBWUlqZ1NCa3NoZm9qOG9BL0I5SHZu?=
 =?utf-8?B?Z0tuZ1g3YzNMdXFhSHdIaU0vRU5VeWhScWpBbzNtbXIxbUc5UjlJY05UMnhP?=
 =?utf-8?B?SGJCSzJzNTlMWnRQeTFleWFYOENNZVRsbTJxZ3FwaWVXdXNsaFErU0tEc3pX?=
 =?utf-8?B?KzRtTzlNOEQ3SjVjQWZac1lscG9oa2s1WFJOWDVDSTBVUjQyRTh1eGtkOS9O?=
 =?utf-8?B?UVhQUFpOYjg1S0tlMm9Dcm9maGZuOVpialZjR1ptbEc1eExKb3NmbzkzVm81?=
 =?utf-8?B?dFd5RVBxY3lTaUNTSDdoU2NYSloyQjhkL01mN0hOWHNZL3VuaHhybXNvTHI0?=
 =?utf-8?B?NjRIUVBzUWFEdUdIS04xUVpzN0RaZkpEb1RvdXVwRFl5R2JPKytDbXgrNzJS?=
 =?utf-8?B?ZVo4T29ybHdiQnNVTWJhUHRVbDYrWm9VZHdrTi9PbVlmMnNmc2NZeUE2dmZB?=
 =?utf-8?B?L216UktIN0lEeXZieTdDak1wMEVJQ01FRHExc3FkbXA3UjVUMk1OL0xLNW40?=
 =?utf-8?B?N1gvR0wxQkNnSWwwYkZFU1htZjRpbEJsNTJpK1A0Z0VkdlFKYmd6TWhIUmMv?=
 =?utf-8?B?aFNkL2VrcVovSzU1aFYwOW4razRvZEY0bnNEdHp4dFBQNjBCSnBjcHpramhN?=
 =?utf-8?B?cmdXL2d2cGhFU1JUK3ZhVVY0ZzFGenE2V1ZNa0pZclhHcWVQeTVRZ3NYbllz?=
 =?utf-8?B?ekY5dmtjMHp5VmU5QUoxdXE1ZnhZbW5QZWpTVVpzeGowV0lrMmw0SGJmY01j?=
 =?utf-8?B?cFZ3QmVZR1ExM2tZb1JqQVFHQTNISTF5N25kTHZaRUFvdUd1TGhHaXVEbDhT?=
 =?utf-8?B?TTgraWxQUVlsUTk0b2w3UmZJMjVNSG54Q1VDUGFyZzNVbjV3OFZEWEtGaEJn?=
 =?utf-8?B?NXIxWTB1UGNYZitna2cyMkdCNUU2Tk5HaUJ1clBBRmFRTVpnYmVzYUtHcGJm?=
 =?utf-8?B?ZyswS1JzZGtNaTNHUTd0a3BpMG5RSEtQeWZpb0syMjVQRmgzWVlFSWxJM0hZ?=
 =?utf-8?B?RW5vU0liY1ZtUWk2c2N2TVBJWEd3WmVWanNQNDdMRVVQdEF6dUNhcG9ONytB?=
 =?utf-8?B?RDhrWUJsdWZoQnlQRFlqa1kwZ3MwYkVqejJOY1kyMGp4bmU4YjlNMEtqOFMy?=
 =?utf-8?B?L00zaEVlUVJRR0hFY3hNeHgyUmY2dUJqQ0V5NERFYjU3ZW4wVWdOVFd1VkJo?=
 =?utf-8?B?eENpZExPQ0k5TWVxUzhtRGYvQmpYRGZLclZHVXBOVTRnZVNXMTZKWkVndkla?=
 =?utf-8?B?bkwzYjBPU0hCNGRKZXJuVTdjWVJwRG41RFZ5R2F1eE9rMCthbXJja1NaUWh0?=
 =?utf-8?B?TVpvRDZBL1pvSGhuS2VPZmV5dUJXcWZWU1VlZmRSWElzNWRIZXczRHlTempx?=
 =?utf-8?B?bkJBRjJtM0pFQXNPQktDY0dUTTNVSU9kSEdOR1NpVVNGMTEyajZKUzAzY2Jt?=
 =?utf-8?B?V3FtN1g4dWJoTmMzSXpmTlV0S2t6WW10bFRWcnZpZkZaeHlIQzFTSkQ4QXkr?=
 =?utf-8?B?Z1dIWENuRTlZdExCTXJXUEdmejBHeXBDWlVSUWkvTk1kRHRzRW5nRy8wRnJU?=
 =?utf-8?B?TGdjNlgzZ2g0MEJUY0dnZ2pGdVRXWG80aGp2aFA5ZjgvMDRJTkhQQTNXUU5h?=
 =?utf-8?B?Y3lUUEtHbngwa2JVK09sSzNtTjlZYXo0Rm9zRjJzb0x4eVVVeFN2b1lWUDNI?=
 =?utf-8?B?NHQ0UkRNZUxaL2wzanhZbjlXeEFLWmJiWGUvOEVQdVNsOThSbVNCS21NM0Fq?=
 =?utf-8?B?YVNEVTNWT1BGdys4U2hiN0Q4d2NWMWpqMUdOUnFVWHJGTTliTXlTbXUxM0ow?=
 =?utf-8?B?dDd2eFlxZUlCSW82b2ZXNnRBMHZjd1d6MFpDWEtVb1UxNTMyRVRkeEZUcWZj?=
 =?utf-8?B?RjVqeVhBTWRhNUgwdDVWVWtMNWJIZnFNQ2FWL2s3Y3dTTjRwcTI2bFdCRkNv?=
 =?utf-8?B?c2V3TmxSS2N1eUJ2S1hqMjJ5ZTNqRHA1Wk1IZUFxaXNMMTlNSFZ3aW15L0tq?=
 =?utf-8?B?WVFrRnhGd2xKTzYrNno1YnFyOGJOdEsrR2trQUtWYzMzM0Y2VDZRNmdNVFVv?=
 =?utf-8?B?TWtCbk91cHlhbGVwV1kyVWVYUWtLQ29IVTNpUUZJS2s4RktIR3B6dnA2RFJ6?=
 =?utf-8?Q?v4y11uH5Kj/oXI6U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02fa9c-e794-4479-dcba-08de4ca5c756
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 22:00:03.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwTlv6ualfoZpZw2hcBWvgJGOkLgx0qnl2SbbkeccNayrNNtVTsNtcHZAkH8RLUk5bxdKsdR6NyVk35vDrHcf/Ivy+qNouFKcUKK9vDiIEC8zzRf3ySJdCLXIG3iNc2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 22:00:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21318

SGkgQmlqdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA1
LCAyMDI2IDU6NTEgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwu
dG9zaGliYT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOiBG
aXggYnVpbGQgZXJyb3INCj4gY2F1c2VkIGJ5IGlzX2dlbjQoKQ0KPiANCj4gSGkgTm9idWhpcm8t
U2FuLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogbm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGli
YQ0KPiA+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+IFN1YmplY3Q6
IEZXOiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOiBG
aXgNCj4gPiBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4NCj4gPiBSZXNlbmQg
dG8gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiAuDQo+ID4NCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1
aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSA1LCAyMDI2IDEwOjAzIEFNDQo+ID4gU3ViamVjdDogW1BBVENIIGZvciA2LjEyLnktY2lwICsg
Ni4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDogRml4IGJ1aWxkDQo+ID4gZXJyb3IgY2F1c2VkIGJ5
IGlzX2dlbjQoKQ0KPiA+DQo+ID4gaXNfZ2VuNCgpIGlzIHVuZGVmaW5lZCBiZWNhdXNlIGl0IHdh
cyBtb2RpZmllZCBieSBjb21taXQ6IGYwYjM3ZjJjYjIyNA0KPiA+ICgiY2FuOiByY2FyX2NhbmZk
OiBBZGQgc2ggdmFyaWFibGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyIpLg0KPiA+IFRo
aXMgcmVwbGFjZXMgaXNfZ2VuNCgpIHdpdGggJ2dwcml2LT5pbmZvLT5zaGFyZWRfY2FuX3JlZ3Mn
Lg0KPiA+DQo+ID4gYGBgDQo+ID4gZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOiBJ
biBmdW5jdGlvbiDigJhyY2FyX2NhbmZkX3Jlc2V0X2NvbnRyb2xsZXLigJk6DQo+ID4gZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOjg3NDoxNDogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uDQo+ID4gb2YgZnVuY3Rpb24g4oCYaXNfZ2VuNOKAmSBbLSBXaW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dDQo+ID4gICA4NzQgfCAgICAgICAgIGlmICghaXNfZ2VuNChncHJpdikp
IHsNCj4gPiAgICAgICB8ICAgICAgICAgICAgICBefn5+fn5+DQo+ID4gZHJpdmVycy9uZXQvY2Fu
L3JjYXIvcmNhcl9jYW5mZC5jOiBBdCB0b3AgbGV2ZWw6DQo+ID4gYGBgDQo+ID4NCj4gPiBGaXhl
czogZjg4YmE1MDk4ZTgzICgiY2FuOiByY2FyX2NhbmZkOiBGaXggQ0FOLUZEIG1vZGUgYXMgZGVm
YXVsdCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvLml3
YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+IA0KPiBSZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gQ2hlZXJzLA0KPiBCaWp1DQoNClRoYW5r
cywgYXBwbGllZC4NCg0KTm9idWhpcm8NCg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25l
dC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+IGluZGV4IGI1ODg5NTA4NGVhMmEuLjk5ZDBjYmU4NjMyMTMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTg1MSw3ICs4NTEs
NyBAQCBzdGF0aWMgaW50IHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcihzdHJ1Y3QNCj4gcmNh
cl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ICAJcmNhcl9jYW5mZF93cml0ZShncHJpdi0+YmFz
ZSwgUkNBTkZEX0dFUkZMLCAweDApOw0KPiA+DQo+ID4gIAkvKiBTZXQgdGhlIGNvbnRyb2xsZXIg
aW50byBhcHByb3ByaWF0ZSBtb2RlICovDQo+ID4gLQlpZiAoIWlzX2dlbjQoZ3ByaXYpKSB7DQo+
ID4gKwlpZiAoIWdwcml2LT5pbmZvLT5zaGFyZWRfY2FuX3JlZ3MpIHsNCj4gPiAgCQlpZiAoZ3By
aXYtPmZkbW9kZSkNCj4gPiAgCQkJcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5iYXNlLCBSQ0FO
RkRfR1JNQ0ZHLA0KPiA+ICAJCQkJCSAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gQEAgLTg4
MCw3ICs4ODAsNyBAQCBzdGF0aWMgaW50IHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcihzdHJ1
Y3QNCj4gcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ICAJCX0NCj4gPg0KPiA+ICAJCS8q
IFNldCB0aGUgY29udHJvbGxlciBpbnRvIGFwcHJvcHJpYXRlIG1vZGUgKi8NCj4gPiAtCQlpZiAo
aXNfZ2VuNChncHJpdikpIHsNCj4gPiArCQlpZiAoZ3ByaXYtPmluZm8tPnNoYXJlZF9jYW5fcmVn
cykgew0KPiA+ICAJCQkvKiBEbyBub3Qgc2V0IENMT0UgYW5kIEZET0Ugc2ltdWx0YW5lb3VzbHkg
Ki8NCj4gPiAgCQkJaWYgKCFncHJpdi0+ZmRtb2RlKSB7DQo+ID4gIAkJCQlyY2FyX2NhbmZkX2Ns
ZWFyX2JpdChncHJpdi0+YmFzZSwNCj4gPiAtLQ0KPiA+IDIuNTEuMA0KDQo=


