Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279CBC2A077
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 08:50:59 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60465.1767603055849952895
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 00:50:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=SgVE4w6H;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.12, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCIztAXsoZ8BiJDR/ZYMqBOh7wjCi5XgoxNe30HdyVG0exTvcRhds/m9bpoB/a6Qp8lKlh2zkQIjzRQmLmeUqix+cGzGXDpqQxraZ5UP0/2dMBgEM6AAf8YuKaPgRb57pijNuaZ+cEbURUN99SSVmo1aw7+e0NQL+cw6UdsIY0Vt0TUJYDjiTo484uiTv1lCHdpXKL31rTNFAChSxRjwPFE1MF3FHlH8AQg/wHdYv5ThL2EYtPmvddstYIHPF+K34dbnb41hNT/Mmu0U665krPHqFmg/vm22pkEhzrbM4Nk2HYZtZ9jY+NOjId18lrGtWxOGPaJKALsQdfuDiNZTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaWFtoXRBaSns2rTFppalucY7IBfTtf7MJB8LLLmk2M=;
 b=sr2dfydtT9MQFYxzbsveq/c5gxDb2kPtngxD0CGa2Gr8pYyINbpH7bz8JiUq1eMGpR3MI8Hom81Q5Et0lpvCnOZiR1levyDWTrYORpoyRDXdgcUwHUNb0y6pr7v6nh5YCevUcr3Oi7NGlDfgxkgu4kq4yt6yE5M42J4/zv7A6RTTXNK8xVIIjHvJjmtES7Nb7W+XnwFVaR5HJ8RKLB4gB1518M0KKQFmFbTp/L0K1JfUJACBDU7i3CWbJ7fxIO7o/ShVjTttE4wu8VxMB5IEsmD8i0HlVDTU/4Qj7DNqsmv3m6X9SbkHSI4QgTdbE/cwz1H47z1YM71/eAL+obv9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaWFtoXRBaSns2rTFppalucY7IBfTtf7MJB8LLLmk2M=;
 b=SgVE4w6H07yRkVUO630pMpnBg5tN1zUXgjnkvwYuQnHkaERsTchd+GErt6IPC/blE5VpgkjYpe2OG8oraOlDEhm5ZM0AnWuPuwGPkFFOlS/cq61IMsk2R3aOApt3DCpftftYpxN8blyyeLj+E/ZfTbRgGDmOKBSHVFUDUN9hy40=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13456.jpnprd01.prod.outlook.com (2603:1096:405:1d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 08:50:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 08:50:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: AQHcfd+pY+coh/wWykqX9mehHuUtRLVDRJkA
Date: Mon, 5 Jan 2026 08:50:51 +0000
Message-ID: 
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13456:EE_
x-ms-office365-filtering-correlation-id: 13c416e4-cf58-4ace-7b6e-08de4c378784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZDA5UzhuVktPajNGNi8xWFRocGp0aTQwUUJXQ0gvTVhGd081SzJiZHdpRVVP?=
 =?utf-8?B?dndrZ2k3WHd0cDd1cTBqbUlLUVVwUThjQ3VDajRSS1RVNS9kYUxBWTZ0ZThj?=
 =?utf-8?B?a2RoU2hUYi9nSUlIR3I1ZElJcVNSWk0wcDI1eFFoVGxEWVRxaEhBcld3Z2xO?=
 =?utf-8?B?NzBpU1ROQTlsem1XNkczaVRGZ1FPeFhnUHpwV3hUNWJlZHZSSXNkUzFRWGxh?=
 =?utf-8?B?TllHazBaVUM4MlBzQ3NXR3dTYTQ0ZVBYOFRtaHFqaDhidVlMdFBSUE82Z0Vt?=
 =?utf-8?B?aitGVFhaMTNRcnk2TFZvVmtSNnlONm9aVC9BNnU5SjBpWGxkVGlLYVJJY1hW?=
 =?utf-8?B?S0ZOa3MrdGlCbTBnbWFiSWFrWXI4Ukc4L0VCMFJMRWhqU095MTlMQXhLQ3Nw?=
 =?utf-8?B?SHhPSXBpeThpNUphbFVRSkFEY1dhSVlDK2VURy9rWVJiOTRvNEFVWkhFMFU2?=
 =?utf-8?B?Q25kRUJpWk54Y0VvVXRXVm1vcDBaZmsva0VEQ2R3U29ocjh1QVdTWFRVSlZC?=
 =?utf-8?B?RmY4WitOeEdZL1ZtSzVvd0JJR1VnSis0WlNZNGZxWTg1Z2ZUUnN5NjNLQWtn?=
 =?utf-8?B?L3RnTmIwcHVDK0JCMStoVDcvd0lOSytQK2lSYTluZjU4cjFUN1d1bTcvSjgx?=
 =?utf-8?B?Zjlhem9yZ1NhN21jSlEwdTRvWGI3cTJUNkNxK21NMVlsRHhkRUhIKzhDZjdz?=
 =?utf-8?B?cjJCay9QRHR4NmEzLytUbjFkZWxMRlVmTys5aWFrd3I3dUhZdEN0NjliSDRo?=
 =?utf-8?B?SWZWVmhGYTg1bkQ1bVRkZ1BnUWpZM2lsMlhSSVJOVE11NXdNZGlOY09uMndo?=
 =?utf-8?B?OSsrMk82a2t0Y3ozN2VTK2E3MEZaN0JqYTRlOGE3djUzbXdnTHVLSmg4TjJJ?=
 =?utf-8?B?RlZpQmd1d1VIbWVGUHJwc2puSHRsZllwNkhIV09kc0NiRE1LNEl0Ti9NOG1x?=
 =?utf-8?B?MHc2QTN3ZEQ1YjlWdlRnMnpsN2VVTnVIaUpWcFBLdUNYb2dDY1N0bEVWSEtx?=
 =?utf-8?B?NUpDWGhGeTNRWnhvdkxwTU5DaFplejlWRXV3Ty8xbXVIRkV0T3J6NGxJOHdN?=
 =?utf-8?B?V0dlVWEvLzUydzZ6dWdBbVZiSloxNGVnN3VlR3dDcXg3TE9laGZOaVN5cGtj?=
 =?utf-8?B?VnpzM3hBU3Rqa2kvQUNua3BuUktmdUlHSW4yTTVsYlFGOTlSVy9MaWhTUzMv?=
 =?utf-8?B?cG5EVXB2OXpQU0VYTEF2SUVIeXBCci9nM2x5UjRlbGlkMi94Tnp3akxScTRm?=
 =?utf-8?B?R0xMMzRwZ0ZpaUtldjllVFhPbnF0QUg3Z0hFUStpNGdQSW9rUTN3Zmdpd0RN?=
 =?utf-8?B?aXpSRHAwRUM2c3NKRkZNYTZyZDlUaFkzaUJiRDFKcjljd3A4S2ducitwd01R?=
 =?utf-8?B?TmIydXgxYWRBWFRDcXBnTHp6dG9LNm1ZdmJQTFF5c1JhTC9CZ0NUOGwxbnV6?=
 =?utf-8?B?bW5odzNlTzByQTVDMmtOd0hBTW1SS0k0Z3ZIVTN6QlVVdUoxNHp0YmtYZ0lq?=
 =?utf-8?B?eWV5WlRUU0NMSWNRRzhsK3Ivc2NBYytVdDA0TlFNODNYYXpzK25EZU1lMUdW?=
 =?utf-8?B?MEo0ellnSzlMN3VJd2h3azZrcmNyNTRYYmVxOFpGS0g2TVZKaHhIRVVmc1Jn?=
 =?utf-8?B?N0lhQzMydGEzUUNkL0hTOTQzMnhqMEhVTGpqOTJ1UU83QVMrRUxvVkczbnM1?=
 =?utf-8?B?bTg0RTNVdmRMTmlxb1cxNDhTR3R1UFl2dDJUOWJtVFBwRFhNNWFEejYzQWY4?=
 =?utf-8?B?Rm95TEQ1eTBkZE50dzVpVWZzakRqWnlqSWllVVMwTjk4YTd6bGw1UFhGd2ta?=
 =?utf-8?B?MFN6a2NLcHFRTFAvM1hDOEFkSVdvVUlRSmNmSFVxcWxWYnk3TklrNStsL2lG?=
 =?utf-8?B?MXlOc2gxQmNtUzBjNEdNSlFrNFFraGxWRVZ5WUlhcEpxaE9xWm8wRENXQUdK?=
 =?utf-8?B?YUY4eTF3NzR0QklDUk9UOGhUQmpZSkdyRnd1bW14TXh4MlJHanFqMzQ0cFVr?=
 =?utf-8?B?MG56ZjNaL0NVNEN0RU5TUjQyOUZOMW1wSk04dloxODhaZWZwbUFSUEoxZllO?=
 =?utf-8?Q?F8wXsP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OE9PSmdKZEN2aVFrWmpSRGVoSnM3THlYVi9MUXVZR3Ayam9rV0F4TzZ2eit2?=
 =?utf-8?B?eVF4T1ZnMFZSbU1qMDJUSEppcGQ1cXV6NmNybm5VNDBjUWdHYmhhV2d1LzN6?=
 =?utf-8?B?a1Z5d3lBRElpZFRhd251MS9XWFlQSVNodElpbUx6QzhtQmZYYWp6Qy92ZFRi?=
 =?utf-8?B?d1NjOERTR25Nblc2L3krQXhZNU9CYzNwSHFrdFh0cXN6YTJCc1ZGdUdhN0lt?=
 =?utf-8?B?c2JQTTliWFBLWnV4aS84cDh4U2tpRVFYbWZhTjNYM2pGaHN5bXE5aklWVW5h?=
 =?utf-8?B?QWpTQ1g1Y3FiWGROcVdrdUpuYkUyYlRIOEFrUlkxMnROMzhZZngvbWsrdXRL?=
 =?utf-8?B?di80SkNVQ2UvWnlndnVuU1FNdzBGdVVKS01XY2pCODVWQzhRTnc4Lyt1cVVY?=
 =?utf-8?B?cUlqWUgzY3ZzTEI4QWRjSzZrNjRpSnBVa3pqbUJtK0JtdnRKQUhFazMwQ0FE?=
 =?utf-8?B?SHU3bVEyd09VTUhxZmhraVczV3hMcmFmaHBlL0ZGa3VQbC9VZ1Nxdk4yV2Ez?=
 =?utf-8?B?T0FoeFc0TG9uZW56c1B3L1VoaitHNTM1SUpZak1DNXJkZkNiTHZGVmlpSUdu?=
 =?utf-8?B?TlBLWndjUEFDbmZONHAzREVQZXN6QndPczA5NEFwQ1N2cVI4UWhUbHd0OUpj?=
 =?utf-8?B?ZWExSzBwZExKTVg5RmE1SDBlb0VvMVJnV2ZjY0JZdmd5c3NjRUFyK0c3cXNi?=
 =?utf-8?B?NWdNVHp0ZUZXN3NKYnZNMVkyYk9WUmJXbWRLdUhuYXBaa3FHZGg0ZjNiSy80?=
 =?utf-8?B?Y0EvTTBHNGF4Rk9tRHZROGRIcjJ4RmYzMkQ3RmFYcGIvT1pJRktkREI3S1Zp?=
 =?utf-8?B?VmNzVTJOL0p3SFZpWW11MWU2RmJMN1krNkhSRTd6d3duaWFVcGVFVFBFOS9p?=
 =?utf-8?B?YkljYjBkSnlCY1MyRVg5OHMzQ2J1ZWlnTmJZTE9tc0lXYk45N2haRmpRa3dM?=
 =?utf-8?B?NVlnZHBERXFRd3F4MUJueVlaQ3E2WkZaUkNYTi9UcWp2WmVIOVBTTmVmREx1?=
 =?utf-8?B?ZG1FOEEvSHQzSWlVdk5wckpOSUZKaU4vMlFXMml0bjQ1TWd5UVRZb00razI0?=
 =?utf-8?B?bFlQOVZxYTlHb3Qza3VhL3FYUjVsTEorV3FRLzYraExrZFFBd3FsN2lmS2tR?=
 =?utf-8?B?Qlh1VVM0YmdBUW1Uam9McU5TWFNvTitkUXFoT3hlcWIySFRjUnNmQTJHUk9y?=
 =?utf-8?B?cnN6cmdZS0pzbzlmeUJsLzJ5UzI3eHZrVjh2U3o0UmhQRHVETFVJUlJHSnN4?=
 =?utf-8?B?L3hSQjlrRVhmTmk0YWUzVXZMYjArZzBKWVpnL3E2ZXVkTTV5aENmeFovV2dh?=
 =?utf-8?B?R1RhZUMxcFdNV2VMRzBFTnZqQ0lyZTVDVVRkNWV1cit4WXBtTlpvYUhyRjFL?=
 =?utf-8?B?dUh2ZjR3NDRlaGQ5WGE2cnVRYkhYSjlOTVY2VEdGenRtUHpVb21uS1F4Q0E1?=
 =?utf-8?B?SEd1OHp0NmJML3lnKzZjdWE4cEViTGU4ak42aVk1bTRqOFM3RHc5bnlvbzA5?=
 =?utf-8?B?VS9NSTl5RUVJUW1pZ2ZZdkFzaXNZYlArNHAwV0JpTnA2eitxVnRKQTY1Y3Nr?=
 =?utf-8?B?enplTTl4UmJQVm45M2dOQ1NTb2pKc1hPUGljMWlXMHVVZjlVY3ZLVTVQTXlj?=
 =?utf-8?B?TkdGc1hXR0VxYmtoL2UzWFJzL1JTQ0V4czBCOVM1UTFnQy9DeVNScGhJOE01?=
 =?utf-8?B?elQ1WHhtM1lpc3A1Njh4SHpuL1lrMzg2aW8wdjZnN21iT3FqOVB0cTFha0VZ?=
 =?utf-8?B?QlZqWDQ1bG9OMnhxdlBXVVdLUkNxcGtOS0dwNFhOb0s2aWUxMHZ0MVJ0dVBt?=
 =?utf-8?B?U1JmaUZ3anBtWmJrRTBLRkYyQW9GdlFON1Z1blVtQzBFUDFscmNUM1Vnd3BD?=
 =?utf-8?B?Qk91Y1RnOCtxZ1I5TzUvR0Y2UHNUbWdXcTRQUkl2ejU4SWU0VFZOM2lONDhW?=
 =?utf-8?B?V2R5VWptSU5INjVwT2p0TWtpdkw1UnhRQlBZZVJhWG8rdjY3S3VCZGVsMkNh?=
 =?utf-8?B?SXN6OXZTeWlXTFhSMTVtYk1FR3VRRnRlbWNwa1RTUkJtWmYyWEhERm16b0Nx?=
 =?utf-8?B?VWxMSndGWXhTRnVpREJNdmtqSzIxN0o3SVpuODIwNW16NytTNlVudmhQdXFl?=
 =?utf-8?B?NlMvWVVyVnd0SXlGcmpVS0JaSURvZXF4di8wVDcrMUs2Sm5IWDZCSUtoQXMw?=
 =?utf-8?B?NkVrVnJXNDh5djkxZ05VbU9NNzNMZTRHMCtrLzNINFZ0Sk9PUko0QjhxU296?=
 =?utf-8?B?b2g4eFdrbGJLaDRSVUhrYk1MWnlnc2xxSnU4OEpyUU5zYWtRTEJZeDJwTnVF?=
 =?utf-8?B?cm5GY05MSTh2SGIzcGxrQnBFTGhIazVSMVJnWVM2cmtETGZ6NWprdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c416e4-cf58-4ace-7b6e-08de4c378784
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:50:51.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psbqMj04CY090YIVgVJnsdT2ffAFZHjvmEnLgyG3r8u6eql5jZx6w6EIVmPA7MWv+mrW/3+pliwe0op7ZwcWPklCiPjnu62GZf1SkEqG9M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13456
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 08:50:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21306

SGkgTm9idWhpcm8tU2FuLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3No
aWJhIDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiBTdWJqZWN0OiBGVzog
W1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDogRml4IGJ1
aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gDQo+IFJlc2VuZCB0byBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IC4NCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5pd2FtYXRzdS54OTBA
bWFpbC50b3NoaWJhPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgNSwgMjAyNiAxMDowMyBBTQ0K
PiBTdWJqZWN0OiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2Nh
bmZkOiBGaXggYnVpbGQgZXJyb3IgY2F1c2VkIGJ5IGlzX2dlbjQoKQ0KPiANCj4gaXNfZ2VuNCgp
IGlzIHVuZGVmaW5lZCBiZWNhdXNlIGl0IHdhcyBtb2RpZmllZCBieSBjb21taXQ6IGYwYjM3ZjJj
YjIyNA0KPiAoImNhbjogcmNhcl9jYW5mZDogQWRkIHNoIHZhcmlhYmxlIHRvIHN0cnVjdCByY2Fy
X2NhbmZkX2h3X2luZm8iKS4NCj4gVGhpcyByZXBsYWNlcyBpc19nZW40KCkgd2l0aCAnZ3ByaXYt
PmluZm8tPnNoYXJlZF9jYW5fcmVncycuDQo+IA0KPiBgYGANCj4gZHJpdmVycy9uZXQvY2FuL3Jj
YXIvcmNhcl9jYW5mZC5jOiBJbiBmdW5jdGlvbiDigJhyY2FyX2NhbmZkX3Jlc2V0X2NvbnRyb2xs
ZXLigJk6DQo+IGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYzo4NzQ6MTQ6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpc19nZW404oCZIFstDQo+IFdp
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICA4NzQgfCAgICAgICAgIGlmICghaXNf
Z2VuNChncHJpdikpIHsNCj4gICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fg0KPiBkcml2ZXJz
L25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmM6IEF0IHRvcCBsZXZlbDoNCj4gYGBgDQo+IA0KPiBG
aXhlczogZjg4YmE1MDk4ZTgzICgiY2FuOiByY2FyX2NhbmZkOiBGaXggQ0FOLUZEIG1vZGUgYXMg
ZGVmYXVsdCIpDQo+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5p
d2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KDQpSZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+IGluZGV4IGI1ODg5NTA4NGVhMmEuLjk5ZDBjYmU4NjMyMTMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiArKysgYi9kcml2ZXJz
L25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gQEAgLTg1MSw3ICs4NTEsNyBAQCBzdGF0aWMg
aW50IHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcihzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwg
Kmdwcml2KQ0KPiAgCXJjYXJfY2FuZmRfd3JpdGUoZ3ByaXYtPmJhc2UsIFJDQU5GRF9HRVJGTCwg
MHgwKTsNCj4gDQo+ICAJLyogU2V0IHRoZSBjb250cm9sbGVyIGludG8gYXBwcm9wcmlhdGUgbW9k
ZSAqLw0KPiAtCWlmICghaXNfZ2VuNChncHJpdikpIHsNCj4gKwlpZiAoIWdwcml2LT5pbmZvLT5z
aGFyZWRfY2FuX3JlZ3MpIHsNCj4gIAkJaWYgKGdwcml2LT5mZG1vZGUpDQo+ICAJCQlyY2FyX2Nh
bmZkX3NldF9iaXQoZ3ByaXYtPmJhc2UsIFJDQU5GRF9HUk1DRkcsDQo+ICAJCQkJCSAgIFJDQU5G
RF9HUk1DRkdfUkNNQyk7DQo+IEBAIC04ODAsNyArODgwLDcgQEAgc3RhdGljIGludCByY2FyX2Nh
bmZkX3Jlc2V0X2NvbnRyb2xsZXIoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdikNCj4g
IAkJfQ0KPiANCj4gIAkJLyogU2V0IHRoZSBjb250cm9sbGVyIGludG8gYXBwcm9wcmlhdGUgbW9k
ZSAqLw0KPiAtCQlpZiAoaXNfZ2VuNChncHJpdikpIHsNCj4gKwkJaWYgKGdwcml2LT5pbmZvLT5z
aGFyZWRfY2FuX3JlZ3MpIHsNCj4gIAkJCS8qIERvIG5vdCBzZXQgQ0xPRSBhbmQgRkRPRSBzaW11
bHRhbmVvdXNseSAqLw0KPiAgCQkJaWYgKCFncHJpdi0+ZmRtb2RlKSB7DQo+ICAJCQkJcmNhcl9j
YW5mZF9jbGVhcl9iaXQoZ3ByaXYtPmJhc2UsDQo+IC0tDQo+IDIuNTEuMA0KDQo=

