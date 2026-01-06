Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC06C47BDF
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:01:47 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86933.1767693697394966964
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:01:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=mn3EXpPv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.66, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHjUDRn3QwNZ4WtIoEbN/pxpO9lEhMTZXzHcdAZx6f9DMwv4T2OskrL0Qj/coS3kCP0rNtPNHNRbpwT1XiSYLd/Zeu6qnMlIa4YTVlPg1DnjVvdjuy49k+31JRlqTdEHdf2d/BijI5FNkEcmFIge26XHttJ1hZxDpSeRZOnFZiKhgu8ipOl3/tOCRd/lN4UvBIS7Bl5O4hyEh1iCkCdYt7E2cWVllcj1qMnq9+HHlQ282vJ8Bu6e9Bf/xDOsIVjeNYxej2fGGAkiHDCUSG9hjx1qQeGfrwnGCqMNp1PQ8z/Xt4oHQQb34rmqLpOaHJS8kRu76V9TLe31IEbVtFOjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdTO5y0z3R+KuHRsNM/7VUbqE92Bv3UWD+NB1/eHOas=;
 b=dJhxGlTu5ad1+fvUWUbn60hWkcXyHaXOHKcLD35DcxFZuYfiF3DEPqXz/dLFQAIF5w8/LDqPP8Byd2QNOasd7/ptMFMt+iJg78c4ELuo2LqjawH4h/HiZbMzBre0SmZ2uSW0gq1ego8F4RxguiKxIXVSD58lCxayvHxUAmngVh6j6c5J6hx3nst8Su2kutp6K26RAH0h4goy/PpqMmVSfv4XmQFwIREJGHAMt4Gr84XORUGgz9qUugxFNYp//RbGTVLaeGWu1BgwbO/m61o8u/4FPunMcUtbwF/kXQ8C/z+rA2C2DGcN10hT2tNNOdim1e3NMgEgQsyRPt0kXVc0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdTO5y0z3R+KuHRsNM/7VUbqE92Bv3UWD+NB1/eHOas=;
 b=mn3EXpPvrs3bLX0OeCHy8SANBZ3BX/Wb/QQQCrSxJp6Vv8dU1EZay1GnkuOwP/5b00ZFBNMmFuFPIq2+4jVf/SCqTGreBU8Q6VhaRxgrJ/2MBatA/0KlBOTeXhJ66UPuBjBqLi5d35HvxTqYsRF8vlenIiTYWIeY5ziX/ABScr8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13024.jpnprd01.prod.outlook.com (2603:1096:604:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Tue, 6 Jan
 2026 10:01:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 10:01:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: AQHcfd+pY+coh/wWykqX9mehHuUtRLVDRJkAgADc8YCAAMb0sIAAAcjw
Date: Tue, 6 Jan 2026 10:01:34 +0000
Message-ID: 
 <TY3PR01MB1134635E75F27240A59DB138D8687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346883D7A93A1538A1D5EC98686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY7PR01MB148184B738A3B59788E717DF3CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469B5BC2D59B29C590EAA68687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB113469B5BC2D59B29C590EAA68687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13024:EE_
x-ms-office365-filtering-correlation-id: b21f7f80-ce92-4f0d-f4fe-08de4d0a92d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zmh5RlpDZ3RwU0toeVhLaGpUajlJVjdoaW5XTm5RSHJpS1dqd1E1UDlEbTBk?=
 =?utf-8?B?OGd6MkhCeFV0b3pqVUM5Z1NBaXF5dm1JTlNhKzZVWlNrbkIvbkZPa05qc1FJ?=
 =?utf-8?B?RGV4bGRRcHIzVGdYcmczeEZqSmRNcGw2QVVocno4QVVSblRFOGQzODhkb3lw?=
 =?utf-8?B?RWxoZXp6M0JoNmZuWTRVSk9VbE0rdGk3TFA3eU1WSHZKOHI4Qy9ISTMwR1BW?=
 =?utf-8?B?MmRINUhNZG4waGF3TWlURU5Fcm14YWVzTkNmMFlYRXpSZnR6ZzBWcHdPVDF6?=
 =?utf-8?B?bnl4SVhsZmhzVW4xeGFQZmpQOWxUTXU2SWVvYVdPV2IyYU9rUDZlU0xXUFVk?=
 =?utf-8?B?M3cxNDVCbVB2OVJQOVF1bjNoNzRoM3ZObkZndUNsWWZlUkxjU2hsZ0N3ZURJ?=
 =?utf-8?B?emtwWkVpbjNtdlNzSjU2RUxwL1l0NC9aYXB5UUxaeUN3VmZIWkNxamV0bDkv?=
 =?utf-8?B?aUpwN1YxaEFsV2xBNXBFdUNpUWY3UzkvZGxhRytDNFFoV0syYzZrN1VndEYw?=
 =?utf-8?B?dkRmOVhqKytTU0FFNE8xeVFHZlR6eVJZRnJJUDU3QVFabXY2TDVyMzVKUUI3?=
 =?utf-8?B?STdmMUpmUWRCdmxvc3J4dnZvZWFoemRmekMwbWpZaC8wUXJyUENmQ01HTmJ3?=
 =?utf-8?B?TStXaWRzcFhsejd6aFRoQmpmOXJMS2R1VWZNcU9lWkRYSE5pV1p2bGhod2ly?=
 =?utf-8?B?eG9aYmQ5a2xSQjZhcW1pRkZkV0F3MDlyMXV0VUIxcEF1cGJwUk52VjJuUVBU?=
 =?utf-8?B?dmR4NGhNQXJPVVVBWEIzQWJMT2p2WGhzOTRjZStYb1JsVzFTQTZla0RDWnlJ?=
 =?utf-8?B?Nnd5emppcjFQamVzL25kZmwvbmpZbFMwNGV6N3daVDdPYjQzQzBGay9BYVRJ?=
 =?utf-8?B?Q2VwWVpjOWZmVGcxVjFPRi9rYzFkWkkvcXRGcUxaQ0c1MytVR0NPTzZtYlUv?=
 =?utf-8?B?RFBsYjErdG5lRjMxTmxWeUlnRXljL25DWWRpYUIyRkZ6c005b25YVkxpL20z?=
 =?utf-8?B?TlBiZkJVZHk3QXY0aXhjcVU0Njd0SkRLWFJKMHpNcWxOL3FiWmZsZi9IeEVF?=
 =?utf-8?B?b29OdnQ4MzZ2SGxKNHJsOGhXc1hQWm81Sjk2YkhRdjVPcDlubEx2djhjd3ls?=
 =?utf-8?B?UUdJb0V3dFAwbTRmS3ZkaGx1WHdQaFhvbmZOZGdqaTh1aldLSXlJZlFjdGFp?=
 =?utf-8?B?S21EL2dlanBheENEUmNpVnNiK1V2SUhPWk1HN3Bvcnc2aU1rcmd6Qldna0tx?=
 =?utf-8?B?OFhXUEVhNCtYT21LZzkzRVQvWFZhV1JtT1FCRHcxOURORmd6TWxJWFlyc2dS?=
 =?utf-8?B?OE5WNXZrdW05NnY0TFdzWTAxUmlpR2ZYbE1TYzVqTXljb213d1R3STF4bmpZ?=
 =?utf-8?B?WGduck41cWRTaTFDVkVRTTRoYndaYi83Rk1xYWNPcDNMRUJocmd3YS9zSWtD?=
 =?utf-8?B?bUhFdzFsME5WSzVoT3VrRDB4amxQOHR2cmdaWUxXemp3ZWdtT1VzSUpiUVZ0?=
 =?utf-8?B?M3ZhdktBUk54QjN3VXdsMmxweFR1dGxoK1c3di9hRStBL2xzUGx1ZmlhOFFK?=
 =?utf-8?B?M1hvdlQwa1E4WmNhZDE4a01WUmhNaE5vSkRHS1U3eVBLQkd3S3YxYjB3bTF6?=
 =?utf-8?B?eHNXeTJaMVAzYmYzUnU2clJ6SDU4WTRLUFpuZWtzNzJMSUZraEFRR1R1aVd2?=
 =?utf-8?B?bVp4SjBTS1BWZElWMzVVZTRRUkVIalJxMFQ5cmF0NjBQTzdmSVNMZUNJNFFO?=
 =?utf-8?B?QUV3NzdCUmR2Q1I3S1JET29WOVZtVUZ1MWMzMmdHWGhjOUJ2MXpqTkJyZTNz?=
 =?utf-8?B?OGpkY21wZjRiQW1qcUJGNlVPZUp2RWtNNUYxSW9IK0h3QytCaTh2VHJwbjdU?=
 =?utf-8?B?T1dZUFI2WVN3VWh1Lyt2cGthem9JTzQ4WnRuNklWcXBzRFZGamtINi9xYXJI?=
 =?utf-8?B?QWk3WjRHak1qdmV0WlR1Uy83WURyd3lpMUZ1TVJoNU9Gb3N6QkdGYk55dGJE?=
 =?utf-8?B?NzhkbHdHM05GS2EySy83cTRmMlN3WXZmbEZSZm43bVdFdThxTk1LZWxOaHlC?=
 =?utf-8?Q?rPURbZ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UGpmOWE3aTVtTlNGcEZKRzdSZnFQV01zZWplOURYb3RxMXJNMnkveWgwRDEy?=
 =?utf-8?B?V3VWQk16TlUxODBZa0FERFRlMDB5aG51aDZ5Mk5rVEtDL2xVcGk4dHpPaEoz?=
 =?utf-8?B?bTdDbVlGUHpra3F5S0lYWWJxYTBuUGtJa2R3TGJ1WU81TG40RGZGU3lwV0pV?=
 =?utf-8?B?RUd1TjVSa3IzNlhVb2hQM3E4SWNHV0UrTXM1Z05GSjh0cnJ3bVgybDdsRWdy?=
 =?utf-8?B?Y0tCcDU0MmRuM09hTFZGVkRRbi9GWXkxWGZXVDBXQkZsUGNaTjc0aEZOQy9z?=
 =?utf-8?B?NzhYTTRjM2RnVE5GbGlTc2JpM3F3TjRlRVl5S2hBbXpyUnJ3YlJGcFI1YXZt?=
 =?utf-8?B?c3d6VTBXbzFOWUJra210MGxBSFNPaDhkbWd2c0I4a1RSbURlSE5qY0Y5L1o4?=
 =?utf-8?B?WXFsU3FjWlBxNVRUSlRCQUMrdGdCYmhVSk44TVgyaFM5WEFrd0FMQTFWaWJy?=
 =?utf-8?B?RmdzQW1TdUUvVi9zRUE2MmR2Qkw1azdBTCs4YlJHUjMxTlVaYk5uaU0ra09y?=
 =?utf-8?B?RmNjY0R4WUM0ejVSYzFqckxDdW9yUWRieFBXcTUwTVpsU1VwdWtOaURqeXVF?=
 =?utf-8?B?eXRLY3UrS2pHaWE1ZGNPSnpvOTlDNnQreGZ2UnJhZ2RQbUtwUXRWc2lHeGUz?=
 =?utf-8?B?cjBYSEY4SjMwSEhCMzdDWlJhU2hqc1RGekNOdERLdnBmQlpsN2h1UXg1cGUx?=
 =?utf-8?B?U3FzNGVWSndnekhDMXpHWmNVdk1yRnYxTmphVUJpZVI1empKbTdHTjVsdlNR?=
 =?utf-8?B?eE4zUzd4OVFzK1dRVDFtN05FQk1IY05XS0RJdUt3S3dnYndLMEJkbjlCU0o4?=
 =?utf-8?B?UEY3b2hZUFczOGwrY2hlTGt2OFVlWElRMGpONzVLZENVUFRpZldIOGl5anNO?=
 =?utf-8?B?aWFGaTJtWlJlVGdoV1loeHpTM0VCLytlWWFsUzhSR3hpVFBkSU1UQ3pud1Vp?=
 =?utf-8?B?VlVrYnI4SU40ZEpsTmJsY0IzcVhjWXBPY3pBS1Avbm9FTUNmY3JQRlkrUHFi?=
 =?utf-8?B?d0I4dFlKakJYbmN0MVlReWFEVUhDUHUvQTdQdjRLNTRGYlRyQkI0dWVla3BN?=
 =?utf-8?B?RDRlY3pSSkVIcFZlNzIwbUdUemVJc1VuWHBaclZVcllycDRlelM1UkcxdUo1?=
 =?utf-8?B?cEFIYTBGYnp0NWUrN0Noc1pPZVBERjc5RHJCUzdtdWdGTEFMT0wreGtHOEsy?=
 =?utf-8?B?TUx3NUJTandYekkzV2pRQjhUUUVERWZKNExLRXR1S1lxbExheFI4TVZHcWlO?=
 =?utf-8?B?OVJ3ZkZvVVlXK1NTanlGSmtPemdHL3RlZEZtclU4RnFBMVlEaE80N2lRVUsw?=
 =?utf-8?B?TG5zcjVzZGg1MTgwd0JHQTF0UnR6NzRoNHRHLy94NGJEUktwd3BUaXRBaUwr?=
 =?utf-8?B?RVdXaExuVWZPWlFUUlFxWHdFQ2dQSHBJT3AyRmJVV21lM2ZaenI1a1pLTXJi?=
 =?utf-8?B?NnNCanBDK3JRMEpOL3d3a1B3Z1ZyVTVhZ1VDYjhmaU1RTFZNM043cnNGSmJV?=
 =?utf-8?B?aHhnWDlSUzZyK0psWTNJNEFzcEJUZWJKTzJTUmFTemdxVThCWTBsR2duOU1G?=
 =?utf-8?B?bTRJNmxnLytQU3Nrdmh3QXI1eS9ZVGhhSUlPS2RPM0t0cGlubXZTQWdGN3o4?=
 =?utf-8?B?WEFmck9vd0RtVUladVUyOGxsSWZ5M3NPUjM4Rzg4L2ZOUnp3NVg2amc4L0tr?=
 =?utf-8?B?QTFkYnRCV2NSMzU5ZW1LeGFRVlhnb0sxN0pPV3QyVHB2MGNtNk5zMS83dGRs?=
 =?utf-8?B?YS91YitBWUdHU0x6b0J1K2crODR6a1Q3bU9FRitXVzQ5ZExGclF0Z1Bwb0JZ?=
 =?utf-8?B?TWpkQ2lWamRreHJMb1Vvc0ZiNm1nQzVGNWcwNkJ6RlhmVm8vZEl2OUNkdEFD?=
 =?utf-8?B?cmY1ckdNbkFzaTcvaHZtRDlPSFIxTUEzZ0Z3eUdxam9qUmlLa3VaREZHekhy?=
 =?utf-8?B?Szg3bk10aUpxbmhpelFJTGdpdVdnS3NscVNYL05XOTY3cjFwenMrT2JZbWU1?=
 =?utf-8?B?V2p3dm5BZDhweGNvWGVnNzJkUFdwM0F1bFVlSWoxUUgzdzM5YTBCRWZnVFVC?=
 =?utf-8?B?b1l3am5PRDBYQnl1a1h0alM4V1RmYVRMOWUyZkxKbFBuVjIrQTdUdHN2cUVJ?=
 =?utf-8?B?eXZyS1d5VDV2ZTRQcnpIZjk5Z0J4dEhKdVNoMytTZG9neHZXc3FlQzJHKzVx?=
 =?utf-8?B?RE1BRnRXQ3lmdUQ4S0h5RmhqeDNLdVRheHJ3Q2ZnSjFQT2tsMTZIYUdvSzg4?=
 =?utf-8?B?WTBXOElaWVdmNEJGR2tqbCtxQTYrWUkzbjljcDlVeVBBanpQQTdpT2hSVS8x?=
 =?utf-8?B?dEdsVXpEOTREc3F2QlIwa1lGOTJtQ0hiOWxFMHV6c0lCMEJyK2I4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21f7f80-ce92-4f0d-f4fe-08de4d0a92d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 10:01:34.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgeD0jbZGCD87eewZSseB3rhn/LpbcG6G7G9GT8nPZ0diNwfh27l1VHpQv6xLgHFwzQaduipOM/6AkmkV3MHMoK54skM3NAwJYTI+1ItDCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21323

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMNCj4gU2Vu
dDogMDYgSmFudWFyeSAyMDI2IDA5OjU1DQo+IFRvOiAnbm9idWhpcm8uaXdhbWF0c3UueDkwQG1h
aWwudG9zaGliYScgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+IENjOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIGZvciA2
LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDogRml4IGJ1aWxkIGVycm9yIGNh
dXNlZCBieSBpc19nZW40KCkNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmENCj4gPiA8
bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gPiBTZW50OiAwNSBKYW51YXJ5
IDIwMjYgMjI6MDANCj4gPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYzIF0gY2FuOiByY2FyX2NhbmZkOiBGaXgN
Cj4gPiBidWlsZCBlcnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQo+ID4NCj4gPiBIaSBCaWp1LA0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gU2VudDogTW9uZGF5LCBKYW51
YXJ5IDUsIDIwMjYgNTo1MSBQTQ0KPiA+ID4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDk
v6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA+ID4gPG5vYnVoaXJvLml3YW1h
dHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+ID4gPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggZm9yIDYuMTIueS1jaXAgKyA2LjEyLjYz
IF0gY2FuOiByY2FyX2NhbmZkOiBGaXgNCj4gPiA+IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19n
ZW40KCkNCj4gPiA+DQo+ID4gPiBIaSBOb2J1aGlyby1TYW4sDQo+ID4gPg0KPiA+ID4gVGhhbmtz
IGZvciB0aGUgcGF0Y2guDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiBGcm9tOiBub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhDQo+ID4g
PiA+IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiA+ID4gPiBTdWJqZWN0
OiBGVzogW1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5mZDoN
Cj4gPiA+ID4gRml4IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPiA+ID4NCj4g
PiA+ID4gUmVzZW5kIHRvIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gLg0K
PiA+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9t
OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4N
Cj4gPiA+ID4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDUsIDIwMjYgMTA6MDMgQU0NCj4gPiA+ID4g
U3ViamVjdDogW1BBVENIIGZvciA2LjEyLnktY2lwICsgNi4xMi42MyBdIGNhbjogcmNhcl9jYW5m
ZDogRml4DQo+ID4gPiA+IGJ1aWxkIGVycm9yIGNhdXNlZCBieSBpc19nZW40KCkNCj4gPiA+ID4N
Cj4gPiA+ID4gaXNfZ2VuNCgpIGlzIHVuZGVmaW5lZCBiZWNhdXNlIGl0IHdhcyBtb2RpZmllZCBi
eSBjb21taXQ6DQo+ID4gPiA+IGYwYjM3ZjJjYjIyNA0KPiA+ID4gPiAoImNhbjogcmNhcl9jYW5m
ZDogQWRkIHNoIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8iKS4NCj4gPiA+
ID4gVGhpcyByZXBsYWNlcyBpc19nZW40KCkgd2l0aCAnZ3ByaXYtPmluZm8tPnNoYXJlZF9jYW5f
cmVncycuDQo+ID4gPiA+DQo+ID4gPiA+IGBgYA0KPiA+ID4gPiBkcml2ZXJzL25ldC9jYW4vcmNh
ci9yY2FyX2NhbmZkLmM6IEluIGZ1bmN0aW9uIOKAmHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxl
cuKAmToNCj4gPiA+ID4gZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOjg3NDoxNDog
ZXJyb3I6IGltcGxpY2l0DQo+ID4gPiA+IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlzX2dl
bjTigJkgWy0gV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ID4gPiAgIDg3NCB8
ICAgICAgICAgaWYgKCFpc19nZW40KGdwcml2KSkgew0KPiA+ID4gPiAgICAgICB8ICAgICAgICAg
ICAgICBefn5+fn5+DQo+ID4gPiA+IGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYzog
QXQgdG9wIGxldmVsOg0KPiA+ID4gPiBgYGANCj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6IGY4OGJh
NTA5OGU4MyAoImNhbjogcmNhcl9jYW5mZDogRml4IENBTi1GRCBtb2RlIGFzDQo+ID4gPiA+IGRl
ZmF1bHQiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOb2J1aGlybyBJd2FtYXRzdQ0KPiA+ID4g
PiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gPiA+DQo+ID4gPiBSZXZp
ZXdlZC1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4g
PiA+IENoZWVycywNCj4gPiA+IEJpanUNCj4gPg0KPiA+IFRoYW5rcywgYXBwbGllZC4NCj4gPg0K
PiA+IE5vYnVoaXJvDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCj4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4g
Yi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4gaW5kZXggYjU4ODk1
MDg0ZWEyYS4uOTlkMGNiZTg2MzIxMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQv
Y2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2Fy
L3JjYXJfY2FuZmQuYw0KPiA+ID4gPiBAQCAtODUxLDcgKzg1MSw3IEBAIHN0YXRpYyBpbnQgcmNh
cl9jYW5mZF9yZXNldF9jb250cm9sbGVyKHN0cnVjdA0KPiA+ID4gcmNhcl9jYW5mZF9nbG9iYWwg
Kmdwcml2KQ0KPiA+ID4gPiAgCXJjYXJfY2FuZmRfd3JpdGUoZ3ByaXYtPmJhc2UsIFJDQU5GRF9H
RVJGTCwgMHgwKTsNCj4gPiA+ID4NCj4gPiA+ID4gIAkvKiBTZXQgdGhlIGNvbnRyb2xsZXIgaW50
byBhcHByb3ByaWF0ZSBtb2RlICovDQo+ID4gPiA+IC0JaWYgKCFpc19nZW40KGdwcml2KSkgew0K
PiA+ID4gPiArCWlmICghZ3ByaXYtPmluZm8tPnNoYXJlZF9jYW5fcmVncykgew0KPiANCj4gU29y
cnkgSSBtaXNzZWQgaXQsIElzIGl0IHBvc3NpYmxlIHRvIGNoYW5nZSB0aGlzIHRvIHNoYXJlZF9j
YW5fcmVncy0+Y2hfaW50ZXJmYWNlX21vZGUgdG8gbWFrZSBpdCBzYW1lDQo+IGFzIG1haW5saW5l
IFsxXT8gU2FtZSBmb3IgYmVsb3cuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2g9bmV4
dC0NCj4gMjAyNjAxMDYmaWQ9NmQ4NDlmZjU3MzcyMmFmY2Y1NTA4ZDI4MDAwMTdiZGQ0MGYyN2Vi
OQ0KDQoNCkkgd2lsbCBzZW5kIGZvbGxvdy11cCBwYXRjaCB2MiwgcmViYXNpbmcgNi4xMi55LWNp
cCBbMl0NCmFzIHRoZSB2MSBkb2VzIG5vdCBjbGVhbmx5IGFwcGxpZXMgYW55IG1vcmUuDQoNClsy
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9jaXAtZGV2LzIwMjUxMjIyMTExNzA1LjI3MDI4LTEt
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vVC8jdA0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K

