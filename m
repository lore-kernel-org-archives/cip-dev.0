Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E7CF6BF7
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 07:55:22 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1267.1767772519753045085
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 23:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Od/+unJQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.67, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTgXqxXPyOjUv2vKXR+tqn0O7hdWLbkeV4L/60fVJ8mDd611oWN2DSVNjkicFR9AgFgivMb0yD0amfAsu3nUoJQYU3XHxvLy+QSBcUvMLLxlOm2Ur85UBTYw5KDqKS3BvG6dzuND5DxSElMWIWpFl09aye3/bbWXJnVcE1LNQLpv2w/jJNTb4xJ7ZjFPmuGwlPmLLJp5xA1ouNkoNUuROfA+V3rfkYL4DA2YtK3cUlnUqmCNLDe+QRtIDgs2uW1NQUxNvXgW8yavFOB7gIfYgYHoyMrSajJf8aRIBoTquNPqy9TpXhRQcm8XuZBI8FbqjCX3fm0T3KymDHT3cZM65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWeFmFy9xDwtOOoQetvnnbu+nYrEZ+Fd64rU6woT1Uo=;
 b=fTPrFUTBrBydUDKh0Sea/gpmgQxUw2p1tI3e9k12o+Cfkap0S/2l3dd4nQzWtK21CiALOItuYVotnFVl9eCOn5Ry13+x+LtspQS689oOM8qI+xbLDgrzZRX/zaAb3Z7WDP9g70hhDtLW3VBP6RAI0E6VKsX4SnJ+kTEyn6IO+AJ881j2OCuPchnF038u5AQj8rkIdLYoeU5Yx1YhHo+DPXPstJUqrYbPccnVfzAsOhaP0+BnnOlIRWH5eHzPJ2zjgqTvruMceYSjTWW7NOtxsI7jld5PdZLzv1PUl61iYSNLn4P4Q22GsTWcwxhqq9MfbPRmtCYJ+fDbU6pcbXpRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWeFmFy9xDwtOOoQetvnnbu+nYrEZ+Fd64rU6woT1Uo=;
 b=Od/+unJQObkHARLCrnjEiiD8TpRyMUZphCtB595bi+ppdFz8Id2OmAfad1ELx0Mk9rw2+Wbe3VMaVqZXps41Q20jVV43LPJz8d21nLqqJKCrhhdCjSi25jgPL5+cVGZ6HzBFqFENhs+GmsCDghIAQUk56hdDFVuizKL+r25mbZs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13118.jpnprd01.prod.outlook.com (2603:1096:405:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 07:55:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 07:55:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: 
 AQHcfd+pY+coh/wWykqX9mehHuUtRLVDRJkAgADc8YCAAMb0sIAAAcjwgAFsVwCAAAJ8MA==
Date: Wed, 7 Jan 2026 07:55:15 +0000
Message-ID: 
 <TY3PR01MB11346C86DCF3E3888CF83D9108684A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469B5BC2D59B29C590EAA68687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134635E75F27240A59DB138D8687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY7PR01MB148185E3A9F8B3B15135381B4CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148185E3A9F8B3B15135381B4CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13118:EE_
x-ms-office365-filtering-correlation-id: 047483f5-54a4-4555-2508-08de4dc217e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007|14052099004;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VXN3SWEvVU5EQmk5SG9HQ0ZKRnV4b3lkbVRveERXZldxTS9jVHpHNnN3ZjFi?=
 =?utf-8?B?QkFkOWwzWDhuL3RLUUF1UEYrNXdYZUFGdTFCK1hOOHFnZm5ubHJyYTdGeXhK?=
 =?utf-8?B?UTMwYWpXaFdLbDVxZUowRU85RmgrUTY3MVp3aFZodFpJV0E3KzVrU1hOTlhP?=
 =?utf-8?B?L21wa3JtVXcreEhNQW9GdThMYU5mZjY2eVZjWHRxWFFpd0lvNGpHam9COWhk?=
 =?utf-8?B?U21GZURVcFZOSWl0aTJJVU44ZHpiWFNGVXM2Z1NMYzZpai9FbC9saURKa25H?=
 =?utf-8?B?dWFBY21DSUlYYXFybC9UR1EzRXptYUl0N05LZkg0SytDMDJic0JPTnhIVEJS?=
 =?utf-8?B?YWtUZk9NTzZjNjIxVlVwVTEwM2Z2dWtRZHZ6WjFhNnFEZ0JsYkZGay94ekpX?=
 =?utf-8?B?b3pvUFBrL3V2cUtXVXFnY1oydW5pa0puZ1hJTVp2dVBFUnNabkN3MlhHL1Fl?=
 =?utf-8?B?YkloTUI3N0xOWHkrNW9OamVoM1pac2ZLMEdSMmRwT3p5UXBDbk16bGxiWlJp?=
 =?utf-8?B?bnA4RXJNQXN5ZkUvZW5COWFRWlVVZ1NGRm9wZDlRVlZYdTNrdjh4S0dLdFdF?=
 =?utf-8?B?WUxLWkdGNmpOV05aUkFncFA5UStMQmVvVzhhaVptK0g4ZVIwRFZCVW5rZzZR?=
 =?utf-8?B?RXFpU3VoNmlhaVhDajlnR1BoUlM1c1pLOGF6bkNITzU3Ylcwa3RVRUNKSUNT?=
 =?utf-8?B?QmV3QW1nSjJ2UzZTTGtCUHkyRi81OC8rdlg0Z2F5OWJKaVVMNGhtbjNpWXlL?=
 =?utf-8?B?anIvcUozWW92a1hwZTZuVGFISHNLM3B4Q3hGeGV1QWNiWUJyUWtRSXIyTFF4?=
 =?utf-8?B?UGMydUM5elhzVEFmWjVrdEp0d2dleDdrdVVCY0V3Z3NrbnFMaE50MzQra2c5?=
 =?utf-8?B?NjZyeDR4QnVFZUNkLzhDbk9Bb1h1VXBWSnVCaFIveTg0dVlDUkhmMzBidms1?=
 =?utf-8?B?MW5weHFqOGEwYzZqeWFVaHhNUXE0djZodnRxTE9LSW5BeUdVY1M2YTlpMGhx?=
 =?utf-8?B?NVBXYXorbjdSdFhHUW9HVXdFVzhBY0ZEYUhPV1VMZ3BMbGpmcHZHVERQYm1t?=
 =?utf-8?B?YTNvYjRyRUlZdWZOMjNhMEdhSUgvMUFGTnZld09NanFWRXZPbzE2ZWs3RUps?=
 =?utf-8?B?V25UcFF6b2pZeFBmZTE0SEdqUTRacEoyUG1CVy82Y0FRbjU1RldlVmFFc01B?=
 =?utf-8?B?RHkxU1JsZDU1ME9BbUp1clQ5NXJkMVM4aExDc2RjLzRKNkNsUXgwOHViSndC?=
 =?utf-8?B?aGJPbnJaa2RzdGNSeHZ5UTMwV0l3NXhkMHpCVzQ4ZWIxa01TdkRpSzNrcTh4?=
 =?utf-8?B?U0ZZOVd3RndUSjZqWDFDUlpBejJjYktTTkRNMkxXNHBkTnhjQUprOFhSdWZo?=
 =?utf-8?B?Und6ZlJmV3FiMUc5bmwxUW9YQm9ETFNJVHNRRUhhUjI3NHFWM3FKWnpIZGJ6?=
 =?utf-8?B?L0g3SjJLakZnZldYelpuRTEySmNwU1VEQ0kxeHZha3hJdWMzUSs2SUFodU1D?=
 =?utf-8?B?a1JZT1cwZVRnZGlxV3Z5djNIa3dmaThoYXpoUnVURjJCVFN1TmVCSHFvSWlL?=
 =?utf-8?B?TGdtYkRHMFNneGI2QWt3R05nZXdKWUxaQnNCQ1FhdGY0SUpxTU1zTFl3R05o?=
 =?utf-8?B?K0NLNVNYMktqb2RZVDlHZFVKUUdGaXVNWFo3QmxUVlRSeTAyM0lmY2lkRmth?=
 =?utf-8?B?WWZUWWJNNkJOeHprcitJZUhOWXJJYnBIMFM1TjRvUk5kQ3owVjB6NE5KQzJh?=
 =?utf-8?B?YS93U1ptYnFTQ0pSYlQxd3ZjendFYjZNdGptSUJ6WlRjQ2NxU2QraTR3Wms3?=
 =?utf-8?B?SWVYaXVDS1lJLy9lZ0g0RXFCdldmYkJqN1JjMk9KZ1E0UjAvZzA4aUpNeVJt?=
 =?utf-8?B?U3lhaEg4cWpQYURhNCtTUnJCNk43cUVwOFZPVG10RElHUHI2MVNmSWl0RW92?=
 =?utf-8?B?Ny9HV01JTjA0YUlxRVhoTDR5R3p4ZGNnYTY0Z0VDT09iOFFocWVrdGV4bnln?=
 =?utf-8?B?dEhEWC9aZHV6QlFDYitGQytQTWxEaFRVeCtXay9ra2U5NlNKdjNjcnlJMjJG?=
 =?utf-8?Q?ww2tsJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RWtUUDJkRG1rNDhFL3FOY1hnLzdXdGdKWHV6eHM2Y1pIL1hQMnpLMnBUc0R5?=
 =?utf-8?B?SWxYd1dpWlh2cFlYQTg5RzhFejFoWXdLMmM0UVNpWXdSdzRlS1l2enFEcy93?=
 =?utf-8?B?QXdyZ0c3SHdpL29pMDZ1ZCtjZll1Qm8wTlg3NjJzbDBqb3EvSFVjV1QwSURC?=
 =?utf-8?B?ZHZKOUMxcDRvOUxjWG9RaHltWEF2TlBQS2pWS0hNTVVtVnhTbTNIQUFtYjM1?=
 =?utf-8?B?MThxVXVLVDBMd2pKYXErY2Y4ZGlGL1M5VFBCUFk1dlB1Z01ROEdVUzdydkxw?=
 =?utf-8?B?TG1ZbHJhWENseFBqRlc2a2VvdlZndW8xaEFCMWFWbUdlaXRKZ25vYUUwcG0z?=
 =?utf-8?B?RFN3aEt0blVIVWN6WElDeU0rdTFyVzBpN0hkTS9YbWVEL2I2TjVyL1Z0KzY1?=
 =?utf-8?B?MWtPSHBFcndBdWd6L1JXb2JYeUE1NFZId2FTUzc1Y0tVdUZNNHVPUHB2UUxL?=
 =?utf-8?B?WUhSc3QxK2d2Ynd0THIydjdoS2MvalBma0NNeDNFeUhnUHVKRjlHN0VxeWpw?=
 =?utf-8?B?VHZ5WGdLZm9IU3BJcXYvWXZoYzBHSHRCSXYwK3VJblF4S3R0WWFyaEd4UHda?=
 =?utf-8?B?OUFOMDRodXAxNVBBNzFONnU5TFJZeEhTbW9pMXhmRWZJN3pTN0RpY0tkekRK?=
 =?utf-8?B?SndyU3lIWEllZDVjSDVSZ1pMZ0NTOVFySGt5UG9laDdIUFh4NG10eVhGN2lp?=
 =?utf-8?B?SnhzOFBpSVdCbk84U1NxVHlRVFlBVnhPMkhqa1ZyV2VzVy84SHlTQzBMSEhq?=
 =?utf-8?B?OWJDM2FKOG9yLzVVZ3Fta3duRlFDdVBncUlRLzJWdm9nL1JTeXhBUTlEMzhQ?=
 =?utf-8?B?MWZnUVdnVmFNK2xoOEF2V3VqVk80eUEyMm8zbm1taHJ4ejFobW5KeWNtRHh5?=
 =?utf-8?B?S2Z3VEVmTFhQcUdtU09vVkRrSVRxNksvYU9zUHJObjNheHlsNXg2Z2tvNHZF?=
 =?utf-8?B?Vmp2cGlWV3lpMnltMVY3cUIreUpvSTl3b0xwRWM1NFZqQU00MGVlc2d2RjBX?=
 =?utf-8?B?QVNCTVhJa2dmNkM0d3NnVW9oQXJiMG5PS0ExNlJ4VVgxU0pqTmJBYkFSOWV2?=
 =?utf-8?B?RWtSL1orcmJJUXFXR1FWNWZUSit5eFlPRkpGYXdJd0xIMDhBUC9iaExnZHhz?=
 =?utf-8?B?RnlCRTB5eFg2Zmc1Z3dIZ3dnYmFveEduTmZWcTBaS0p6ZGE0Wm9XUFBuTXpk?=
 =?utf-8?B?Vm1yYy9ra0RHeGRIcmZ2Mnd2TW1HL3NpZHB6REFtaWFaWVRCNFhLeXRsNlFX?=
 =?utf-8?B?Y0Y4bjZUMnp3eGZ5eFNtV0NtZElHU0NmLzJXL0tMOHV1cXphcGFpeFg1S2tC?=
 =?utf-8?B?OVp0TW9SVkRNTFhsNEFTZHljdFBpZFovUG9oMmpjVXlyS01LdjZpUGNrU0Vq?=
 =?utf-8?B?ZGkvVnRjU2svRlRMV2V2ZGZlNFdvWEVSQzhrV1FuN1R5dnBMcjc3alo4VGda?=
 =?utf-8?B?MmFNZGhlOVlPcWlsNUNOSWdwT2ExMVNQVWExRGFvL2ZXY3FDUUtOdURSOWlP?=
 =?utf-8?B?WExTWGdYdEFjblcwVHYxMTJQakRnMGNlV0JnVE5HRUVNVHdWWG1XYmNUL25P?=
 =?utf-8?B?T0p2WUJxaCthQ041Y3VRd2ZFM2tva0VQb04zNGcwQWdveHByZzVVeHpWZ1FM?=
 =?utf-8?B?eWcxWFhmR29hTllvRStWdWk3QjFvalVKMjQxeS9aNzBCVERUVjg3T0NNQklF?=
 =?utf-8?B?dUhaRDhadVphMDJoNHNXUGUyQzJCdzJkUU9GeUJNdFZMNTJkb3N6R2lUa3pF?=
 =?utf-8?B?RFdXYkswOEJBajBSNEQ3bTdWMjR5b1VnWXNmQ252T2hMY3pTaTFnc2xCYktj?=
 =?utf-8?B?S2IrVlBHaW5pUEJrWFpEN29KaTkrdzZOc3VBUFFxWk0yWkc1aFJKZGdYcGxJ?=
 =?utf-8?B?SVlMcmpBOURWWUlmUWdPRkVwUnlJbGVIRkxHYlpNYVEwQWZ1SWtOdDV0T3Bx?=
 =?utf-8?B?ejkwcWVpTVlTQlBpb2JrZktSNmQyVmxjb1JFaTFGRlFXb01XVU1nQ3VOT0oz?=
 =?utf-8?B?RytrRjhxWno4VDIyeDgxNU1ISExxMVNEYzMwODJSN1N4OUM4RmplN2FyTUZC?=
 =?utf-8?B?VC94WTZOM3JzbU9aS3NQUkdQSFM3ckVwdHRZcmRxNlhaWEp0aTJhZU1MMHlv?=
 =?utf-8?B?UUNnVGJGUm80b3hhK3M4NU5NaVFRbGhXMWkyUjNQTUhpa25zNllFUzNPWlFY?=
 =?utf-8?B?Z245cCsxSTEyY3NIRWlpN2VEdlVjLzJRMlZpdWVFc012S1pzSDJuZXVNVkxL?=
 =?utf-8?B?NHlpUjN2azJsVzdnenJpaC9wcjdjYzV3TFNZcGtHRkdLcnZpelMrUGN2UW9w?=
 =?utf-8?B?NFFQSXRNRi9yVFNzQnBZeklVVkZQNGIydnhqVTFxcngwY0F1NXpWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047483f5-54a4-4555-2508-08de4dc217e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 07:55:15.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1jUhdLyiJr0RV9Zg480hPuYTY0DG+lkSoLLAd+qEEU1jMVqcDLwQsY9MIuTH1MeAwyxbGaBkS5pRCIRhNRx+dcf+LZ0Zn3JCwkW0v5aCmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 07:55:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21395

SGkgTm9idWhpcm8tU2FuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmEgPG5vYnVoaXJvLml3YW1hdHN1Lng5
MEBtYWlsLnRvc2hpYmE+DQo+IFNlbnQ6IDA3IEphbnVhcnkgMjAyNiAwNzo0Mw0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDog
Rml4IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gDQo+IEhpIEJpanUsDQo+IA0K
PiBUaGlzIGlzIG5vdCBhIHByb2JsZW0gd2l0aCB5b3VyIGJhY2twb3J0IHBhdGNoLCBidXQgYSBw
cm9ibGVtIHRoYXQgb2NjdXJyZWQgYmV0d2VlbiB0aGUgTFRTIHBhdGNoIGFuZA0KPiB0aGUgcGF0
Y2ggYmFja3BvcnRlZCB0byBDSVAuDQo+IFRoZSBMVFMgc3RpbGwgaGFzIGlzX2dlbjQoKSwgYnV0
IENJUCBoYXMgcmVtb3ZlZCBpdC4gVGhpcyBpcyB0aGUgY2F1c2UuDQo+IFRoaXMgY2FuIGJlIGZp
eGVkIGluIHRoZSBtZXJnZSBjb21taXQsIGJ1dCBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBoYXBw
ZW5zIGluIGdpdCBtZXJnZSBsb2dpYywgc28gdGhlDQo+IHJlc3VsdHMgd2lsbCBiZSBkaWZmZXJl
bnQgb24gdGhlIC1yZWJhc2UgYnJhbmNoLg0KPiBUaGVyZWZvcmUsIGEgcGF0Y2ggdG8gZml4IHRo
aXMgZGlmZmVyZW5jZSBpcyBuZWVkZWQsIGFuZCB0aGlzIHdpbGwgYmUgYSBDSVAtc3BlY2lmaWMg
cGF0Y2guDQoNCg0KWW91ciBwYXRjaCBpcyBPSy4gSSBoYXZlIHNlbmQgdjIgZml4aW5nIGFsbCB0
aGUgcGF0Y2ggY29uZmxpY3RzIGR1ZSB0byByZWJhc2VbMV0uDQphbmQgdG8gc3luYyB0aGUgQ0lQ
IHdpdGggbWFpbmxpbmUgYWRkZWQgWzJdDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9j
aXAtZGV2LzIwMjYwMTA2MTE0NDU4LjEyMjMzMy0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
L1QvI3QNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9jaXAtZGV2LzIwMjYwMTA2MTE0NDU4
LjEyMjMzMy0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tL1QvI20xMWY5M2NhY2U3MWQ3OTc3
NTlmYzFhYWM4NGMzOTVjODE0NDk5Zjg4DQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiAgIE5vYnVoaXJvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFNl
bnQ6IFR1ZXNkYXksIEphbnVhcnkgNiwgMjAyNiA3OjAyIFBNDQo+ID4gVG86IGl3YW1hdHN1IG5v
YnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA+IDxu
b2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+IENjOiBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAg
KyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOiBGaXgNCj4gPiBidWlsZCBlcnJvciBjYXVzZWQg
YnkgaXNfZ2VuNCgpDQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogQmlqdSBEYXMNCj4gPiA+IFNlbnQ6IDA2IEphbnVhcnkgMjAyNiAw
OTo1NQ0KPiA+ID4gVG86ICdub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhJw0KPiA+
ID4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+ID4gPiBDYzogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggZm9yIDYu
MTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOiBGaXgNCj4gPiA+IGJ1aWxkIGVy
cm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogbm9idWhpcm8uaXdhbWF0c3Uu
eDkwQG1haWwudG9zaGliYQ0KPiA+ID4gPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9z
aGliYT4NCj4gPiA+ID4gU2VudDogMDUgSmFudWFyeSAyMDI2IDIyOjAwDQo+ID4gPiA+IFRvOiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IENjOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIGZvciA2
LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDoNCj4gPiA+ID4gRml4IGJ1aWxk
IGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQmlqdSwNCj4g
PiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZy
b206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gPiBTZW50
OiBNb25kYXksIEphbnVhcnkgNSwgMjAyNiA1OjUxIFBNDQo+ID4gPiA+ID4gVG86IGl3YW1hdHN1
IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA+
ID4gPiA+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+ID4gPiA+IENj
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6IFJFOiBb
UEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOg0KPiA+ID4g
PiA+IEZpeCBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBIaSBOb2J1aGlyby1TYW4sDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MgZm9yIHRo
ZSBwYXRjaC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4gPiA+IEZyb206IG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmEN
Cj4gPiA+ID4gPiA+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+ID4g
PiA+ID4gU3ViamVjdDogRlc6IFtQQVRDSCBmb3IgNi4xMi55LWNpcCArIDYuMTIuNjMgXSBjYW46
IHJjYXJfY2FuZmQ6DQo+ID4gPiA+ID4gPiBGaXggYnVpbGQgZXJyb3IgY2F1c2VkIGJ5IGlzX2dl
bjQoKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJlc2VuZCB0byBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+IC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gRnJvbTogTm9idWhpcm8gSXdhbWF0c3Ug
PG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+ID4gPiA+ID4gPiBTZW50OiBN
b25kYXksIEphbnVhcnkgNSwgMjAyNiAxMDowMyBBTQ0KPiA+ID4gPiA+ID4gU3ViamVjdDogW1BB
VENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDoNCj4gPiA+ID4g
PiA+IEZpeCBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gaXNfZ2VuNCgpIGlzIHVuZGVmaW5lZCBiZWNhdXNlIGl0IHdhcyBtb2RpZmllZCBi
eSBjb21taXQ6DQo+ID4gPiA+ID4gPiBmMGIzN2YyY2IyMjQNCj4gPiA+ID4gPiA+ICgiY2FuOiBy
Y2FyX2NhbmZkOiBBZGQgc2ggdmFyaWFibGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyIp
Lg0KPiA+ID4gPiA+ID4gVGhpcyByZXBsYWNlcyBpc19nZW40KCkgd2l0aCAnZ3ByaXYtPmluZm8t
PnNoYXJlZF9jYW5fcmVncycuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gYGBgDQo+ID4gPiA+
ID4gPiBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmM6IEluIGZ1bmN0aW9uDQo+ID4g
4oCYcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVy4oCZOg0KPiA+ID4gPiA+ID4gZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOjg3NDoxNDogZXJyb3I6IGltcGxpY2l0DQo+ID4gPiA+
ID4gPiBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhpc19nZW404oCZIFstIFdpbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiA+ID4gPiA+ICAgODc0IHwgICAgICAgICBpZiAoIWlz
X2dlbjQoZ3ByaXYpKSB7DQo+ID4gPiA+ID4gPiAgICAgICB8ICAgICAgICAgICAgICBefn5+fn5+
DQo+ID4gPiA+ID4gPiBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmM6IEF0IHRvcCBs
ZXZlbDoNCj4gPiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZpeGVzOiBm
ODhiYTUwOThlODMgKCJjYW46IHJjYXJfY2FuZmQ6IEZpeCBDQU4tRkQgbW9kZSBhcw0KPiA+ID4g
PiA+ID4gZGVmYXVsdCIpDQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOb2J1aGlybyBJd2Ft
YXRzdQ0KPiA+ID4gPiA+ID4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2hlZXJzLA0KPiA+ID4gPiA+IEJp
anUNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLCBhcHBsaWVkLg0KPiA+ID4gPg0KPiA+ID4gPiBO
b2J1aGlybw0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiA+ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCj4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4v
cmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+ID4gPiA+ID4gPiBpbmRleCBiNTg4OTUwODRlYTJhLi45OWQwY2JlODYzMjEz
IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5m
ZC5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMN
Cj4gPiA+ID4gPiA+IEBAIC04NTEsNyArODUxLDcgQEAgc3RhdGljIGludA0KPiA+ID4gPiA+ID4g
cmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVyKHN0cnVjdA0KPiA+ID4gPiA+IHJjYXJfY2FuZmRf
Z2xvYmFsICpncHJpdikNCj4gPiA+ID4gPiA+ICAJcmNhcl9jYW5mZF93cml0ZShncHJpdi0+YmFz
ZSwgUkNBTkZEX0dFUkZMLCAweDApOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAJLyogU2V0
IHRoZSBjb250cm9sbGVyIGludG8gYXBwcm9wcmlhdGUgbW9kZSAqLw0KPiA+ID4gPiA+ID4gLQlp
ZiAoIWlzX2dlbjQoZ3ByaXYpKSB7DQo+ID4gPiA+ID4gPiArCWlmICghZ3ByaXYtPmluZm8tPnNo
YXJlZF9jYW5fcmVncykgew0KPiA+ID4NCj4gPiA+IFNvcnJ5IEkgbWlzc2VkIGl0LCBJcyBpdCBw
b3NzaWJsZSB0byBjaGFuZ2UgdGhpcyB0bw0KPiA+ID4gc2hhcmVkX2Nhbl9yZWdzLT5jaF9pbnRl
cmZhY2VfbW9kZSB0byBtYWtlIGl0IHNhbWUgYXMgbWFpbmxpbmUgWzFdPw0KPiA+ID4gU2FtZQ0K
PiA+IGZvciBiZWxvdy4NCj4gPiA+DQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvDQo+ID4g
PiBjbw0KPiA+ID4gbW1pdC8/aD1uZXh0LQ0KPiA+ID4gMjAyNjAxMDYmaWQ9NmQ4NDlmZjU3Mzcy
MmFmY2Y1NTA4ZDI4MDAwMTdiZGQ0MGYyN2ViOQ0KPiA+DQo+ID4NCj4gPiBJIHdpbGwgc2VuZCBm
b2xsb3ctdXAgcGF0Y2ggdjIsIHJlYmFzaW5nIDYuMTIueS1jaXAgWzJdIGFzIHRoZSB2MSBkb2Vz
DQo+ID4gbm90IGNsZWFubHkgYXBwbGllcyBhbnkgbW9yZS4NCj4gPg0KPiA+IFsyXQ0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NpcC1kZXYvMjAyNTEyMjIxMTE3MDUuMjcwMjgtMS1iaWp1
LmRhcy5qekBicC4NCj4gPiByZW5lcw0KPiA+IGFzLmNvbS9ULyN0DQo+ID4NCj4gPiBDaGVlcnMs
DQo+ID4gQmlqdQ0KPiA+DQoNCg==

