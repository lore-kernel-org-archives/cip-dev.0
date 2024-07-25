Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BDC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 12:14:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.34927.1721909689649700894
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 05:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 46PCElsB3021858; Thu, 25 Jul 2024 21:14:47 +0900
X-Iguazu-Qid: 2yAbjTfpfMYFkGWywA
X-Iguazu-QSIG: v=2; s=0; t=1721909686; q=2yAbjTfpfMYFkGWywA; m=IhgHQ4D5gfX4YJEyvCbd25AN3LjDVhOOUOWVolavxdY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 46PCEjQi3515784
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 21:14:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x59ZZXhL+7TmikMZgREs8KkwaHxGzDZY2m2j8rK+ElJAn204jhwOtY9NLm+ici7RsQrH6/x3ZaPcdQ4hjdNjZkEKEm+0P/L5QelFeRfIDAcFf47HOj4P3acQEWDd7MHmjN8VTCQ82THHWIZ6a7bExHSewwgI812LaJ+lgzNrh4P88ptHS0TjwhtbdKID8YhD3NkufWckjqwMlJY37LjWgOXksRLYGmKj61K1afCezN9ljaAvjT4+P2SvWdCHCQx62oJiul70VRcOupGIP0cTKDi3fOHnwvUmyrJEwOMeADYcRvHeFcePFXoIpqZpnmIHYMHoBEXCbTEbA4LEkVef1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7iQcveKhAvA8SsdnoBimUfcT4iWfYXKma0SO2P3gAE=;
 b=d3x31XQIsDx6/hZss3LyzrAXGH6LzNYy5HSfAfHQ/NRUVaBIJhnHN4IE4moT0aDN10wFWtmkh0e3ozLaxekMpVqxSEO2HWv3WZ+MCGX1vPtXsZiOw/KzhTUuUx/E3Zk2RzfdGIQCU9ZxH1wlG/lLUf706N2oV9AKLjAESQ6TDaiSO/FNDfpz0244PTWwbHVlkit9j7reTq7Ag696M0W/xqltKqOYiG3CkYL4l25NntV6loDp3WAnbveNY/EoMfsEmNazc7T89OLoSK7/WJVy2OCn6UbCL0P1E507LCQoENHxVZJMy4XEJrXYBPmqG1ZCx6HEe41YZ40XF2kfc0LL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: AQHa1GEaJrvjQ9LEBEqUr/NOQi8XF7IHAL2AgABrsFA=
Date: Thu, 25 Jul 2024 12:14:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB10211:EE_
x-ms-office365-filtering-correlation-id: 5cd130aa-522f-4d4a-1532-08dcaca35e07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SkgrK05NZ3ZMK1FBUHFrN2k4K0NVRllxSCtCeGhvdm1iME9abC9UV3ZiT3dO?=
 =?utf-8?B?Z0VLdDNiMHZ2RkNTZlBCcmRGTzlDOVVFVmV6eFRiaDdENWd4eVU4YWFBL2ha?=
 =?utf-8?B?czB5NlVtNk05UXVCanpyMm9salp4cm1XajZLSCtyenZKVHd1RWZ4K3BUbkhG?=
 =?utf-8?B?bVVHT01LYXdlanpNWVV4VjhBRkdmYzB5N3l6c3dleEsrOW9CVC9nMGc2RUhx?=
 =?utf-8?B?TVRQT1lrUmpsc2k0QitjeElxcVUrVmplSFRERmIxWllndFRTRHQvWkl2NE14?=
 =?utf-8?B?azJnckNaR0dVYVVGNUU5OG1NdUp4d2NHaGd6OVVsKzVtVlRQRkVHZWxWM0xv?=
 =?utf-8?B?MDhHakxnbUk2NzBNWFN0U0hQRTFMWUdPamdkR0pnMVdqYk5uMStTemJiRExa?=
 =?utf-8?B?YW1teTM4UW1ZZkpGTTFNMk0rNXM0SEs4T2FucUI1K29CYnc4SG94eEJDUXJo?=
 =?utf-8?B?eHZLbyt6YjZLby9CQ0NmdFRQWUFwd01HNjRzbFNBbWdrbFQ1dG9wYnc2QTl2?=
 =?utf-8?B?YlRCRzJSdElpck40ME1rdWJ3aVlYdUZBRFYzaGl5ZFRxTHcwK1JXVUFodnVo?=
 =?utf-8?B?VmdFcm1ZVEhwU0I5dzd0Y1pncTMwWmdKQ2hvTFZydnF5MHpPT003Zmw4Zncz?=
 =?utf-8?B?VnljZnI1Y0xIR29qOXFTVGtSVDhBalp5cjNHNlpUN1lQOHM0djdyYVV1dTN2?=
 =?utf-8?B?Q1dRUWQwZWdvR1dBV3g0am1QVnNyNk0vV3dzNnQyNXlPZGFvSXREZy9CdmZM?=
 =?utf-8?B?SzlaU2VIL1ByK283MEZodE13SjlEaXVPdDloQThvcGQ4MXk5a0ZjYkc1Sy9N?=
 =?utf-8?B?azYySzUwY2dlWm1kYUhBTS9QYjhJNEJpRk5jOG5uRkVTSDJYaHRudjJyblMr?=
 =?utf-8?B?N0xSNEZFSkI1UjlFbXN5Yk9qU1d4ZnVUZWxpYkZOTDJiaVF4RnFyYy9nYzI2?=
 =?utf-8?B?MmZtc2xmZ1hUWURmeG5yNVBTa0NKQnJ6OEQvVjB3TzlEQ2o3YmZXZHBncW1p?=
 =?utf-8?B?cmdDMVJBNjhRNVRSWmg5T2Z4aXdUTjFzNlVWakNQVmVmVktoeEpaZDlMTG5Y?=
 =?utf-8?B?Ly8wRjN5aDUwaU1QZ2liMUhMdWtUTHZFUWdBUlVib00wU0tScWZsSkRxcThh?=
 =?utf-8?B?a0daWUdYM0xaWS9YSWFUVk1raWpwcS9FUGZ4Z0VvZE81ODVCNHhCSmVESm9q?=
 =?utf-8?B?dHUxclJIcWQzenp5ZjNOT0FMa0VhUklXZWl6WnpaeWdCWEVCbWgwVUlkTHUx?=
 =?utf-8?B?Mm5xTVByNzN3TWZiTDFWaGY2dnRRZStUVXVSYWZkOVdRRFZqOG4wdzRlZCtp?=
 =?utf-8?B?VGNiczhpRW84TDdmMnNYdTJpV2ZQV2RCRWJDcGplUEtibWtrOTVBQkI5RWdi?=
 =?utf-8?B?UHVJakxoVWxkVnJ1U0VqeFFzNXVXdk85UStlR1RpMWwyVHBTSElyejdLR09Z?=
 =?utf-8?B?ZHMwd1l2VjZpZUdTZCt4bnpHcnlZWUxWL3FZcFVpTE1UemhEQmJab2NseENO?=
 =?utf-8?B?N1RSc3VxaUg2T0tjeG1yR2xEczN4Zk9qVytxZHZjNldnbG1QNDlJbExmRVpZ?=
 =?utf-8?B?eGRoWHpWdHB3RnhHeEJYQUoxTGRHc0xMT2orcWwyaEhMNktrLy83cFFGc1Ew?=
 =?utf-8?B?cVo4MTJSMjAyWFdycnUwMnRMRzU2ZHV5aU1ZajRVRFdJc1FmMXlKdVZzZU4r?=
 =?utf-8?B?VUlIVC9IV2tVUUNRUzNCN3UweTVFWnp5R3lYNTd3SkNUNVBHMTlOdWl5alZy?=
 =?utf-8?B?aEwwNmk4bFg0dkZYVWdDTHYrSGRIb29TbjJXSDZmTnBlZ0d6VHNOdzdUUXNk?=
 =?utf-8?Q?abjTLgdXpqMAvxdkxLjB1KjOCkD3zuP7Rv8+M=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aGpKMHZpSlMxdUE2MEZyakhVTlhQN2YxU3A0aHpaMVFvd3JSTU1zN2xkNHdE?=
 =?utf-8?B?SitjRWlkNUlvVWsrUDQrTVhrZ1hFRzFsNlROd2t2MzJhdFhKZmFsVmVRRDJX?=
 =?utf-8?B?WE0vWmlabUdYN3hiUDQ2ck9NckRNMGNCWWFaNkx4UVE3eG93RmxFS0hCMkts?=
 =?utf-8?B?M0svcEpnWG9ZNStBSUVZZlpkYTUyZlFuZHRHenNqZEd0R1FtM25uS2RlZGEw?=
 =?utf-8?B?QTNIek1TeDUxS3BBdExuZncxcjhmZjA5ZlVET1NlUFlPd3VLWjBzbHZlU3l2?=
 =?utf-8?B?cDR1NzlEVXk1NUkxc25mTkpQOElPSklvWHpwMWo5MmtTallFcmNTK3g3NkpY?=
 =?utf-8?B?Y1BZS2hwSzBjTTc1SmJCQ1dYVUJuZHo2L1l4cmFzWFR0eW44OGVuaEdzeTZm?=
 =?utf-8?B?WVFEMXhXYzUyMzQ3MStiZnR4UmV5dUoyQ0dIVzNRT1htWWhINUR2a1l0SnNm?=
 =?utf-8?B?bWsrV1FoaHl2NUdiVCtudnlFa3N0a0daODBiY3V3NVVxeVJvZjgzaUlPa1lV?=
 =?utf-8?B?T2ovRXRHMTNScExPUlBhbk5CbnQ1a015Q1htYnZ1dHlQb25LNlRLWmZ5bExN?=
 =?utf-8?B?eG1HSDl4OGVKQTZzNENCMFlacDNDMHZleG1jbUtkajNJd2RPTUQ0U1Q3ODk2?=
 =?utf-8?B?dmc2QWJhOFdPbVV0WGF3TFpSd1NlSUVpSGQ4aXAvdWlkcGd3YXFxVW83S1Nr?=
 =?utf-8?B?WmQ3YTZpVFo3ZzVFT3YzdVQvUUd1UndGYWJwWHRmRDROQVdlVUt0N05XZTAx?=
 =?utf-8?B?YlN0eWVJa3ZRcldLaEVSbGdvczRBSkYyOTM2YTA5WG9uYm1hanY5MVkxODdO?=
 =?utf-8?B?OWw1SnQySGNFKytudDE3RnZxbzdpZWpYRzA2bTNUSnVnV2YwM3FUakpPYjIz?=
 =?utf-8?B?NVpVTWZkKzZDK0Ryb25EY0NuNzErRVptcGpOREdQVStUZEJmNlNNWWVNNWpU?=
 =?utf-8?B?MU51WmlieUlvK2tGcHgrMEY3OHp2a1kvWFMzSmhOeWdDVkh0TzZjT1hsSlFR?=
 =?utf-8?B?WUJUaUxINTRnQWZCQ1FnME1kdjNzQ2VZWTRIdzE5VlpxNG4wbENmS0VkTnBJ?=
 =?utf-8?B?bitjKzhjaDZETHFiaDV4bGkyWkFQWDQ2cEpncnhKM2pFYytQamYzNE9DSDZS?=
 =?utf-8?B?ZzFXTVZJREdoTUFVNlFTcndzeVY3Vm1uQ29CSVVqTnVhUGI2R1dCMlZ2MG1h?=
 =?utf-8?B?U1VBK0liNFFQbUJCSGcvNDZWRzBISUxCVDJjUzdCNXRQV3ZNdGlwZkxJNExP?=
 =?utf-8?B?ZGcxN00yVFh4SnBydElHMWFxOUtER0U5YURJZFpicEoyTHM3SHRlYmtTQzRI?=
 =?utf-8?B?RVdJaTg1TUtVejVHNDJMRmNpNGpCdWVJSHFDTzlLWU1NRmxjMDJDTTQyTk4v?=
 =?utf-8?B?S25RVUdPbkFqYkhRMjZwL1JIcmZUWGNEUi9jV3FZVzRneklabjJLRXNQc0I5?=
 =?utf-8?B?bEFhcEhBOTJHSGNLaER4MDlpUnErM3U3RS9RUnJQM3IyaDJHTnYvYktsNnIr?=
 =?utf-8?B?bG02MnVEV2N5NjFFdVZPQ2ZkMG1hUXhlL0U3eStieStWdk9GdGc2Q0VXZHVV?=
 =?utf-8?B?STFDM1ZKNGRBcW1acHl5QmpvUk1TajFJRVBzdkpMV2JSaXh1cVFkczhIbzRo?=
 =?utf-8?B?TkJqMW9jdkVNVGRQTm9hTUxLOVRESkhwWUJneHB0dWhkbHhDWXp0T253ZnhE?=
 =?utf-8?B?WDFlN2lLQkFtRWNscTlpc3RUb051cFVVVHZtbjFJZzl0QS9MNzkxTGlxN1RD?=
 =?utf-8?B?Vlk4QUZES1AvdUV1ZGpYVFk5TjMveVVZRGh0RXlwKy96Zmx5ZTNHV3pwWkor?=
 =?utf-8?B?bDRUbEZUYVNGVTJWK2JPQkFNQnErbDc5eXBGdjhZd3ZISVFoaW00Rk9VNTBr?=
 =?utf-8?B?L3pheFZEckxValI5YzlzSzhwK3Nidy9tWmtsejZqTFgxdUMwWUsvc2IzZW11?=
 =?utf-8?B?SWtEaDZBV2ltUE94RUNCVFJEQm0zOFNnalNBbHZBeG1DSW8zOC91MnBVYkIw?=
 =?utf-8?B?WE80KzdsUkx1Y0x6blBqWm1BQTVnaWhWYkdielNiSHBqNzkyaWhrM25zNmhY?=
 =?utf-8?B?Nkc3blViTWdxanZzUWcvbVI1U1gwUkROZFkzSTlZakFlb0FSeDllL0ljWG5H?=
 =?utf-8?B?dEtPajY0ZXpJSlJ2eGhCZ0xpNU8zQWFWOS8zbUlScWNPbVB1czErbThLOUpp?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd130aa-522f-4d4a-1532-08dcaca35e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 12:14:43.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9GRbNs3KkYqRemKxgIs6T3Bx/uBcHWXYxmAOym78q3bAur9349/fa+9Qgowi10hMvxeoekLKl+5uNK4QGZw7RcO3kFBHRb6e9j9xUbm8k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10211
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 12:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16625

SGkgQ2hyaXMsDQoNCkN1cnJlbnRseSBTd3VwZGF0ZSwgU2VjdXJlIGJvb3QgYW5kIElFQyBsYXll
ciB2ZXJpZmljYXRpb24gam9icyBhcmUgcnVubmluZyBpbiBDSVAgTEFWQSBMYWIgZnJvbSBwYXN0
IDIgbW9udGhzLiBSZWNlbnRseSB0aGVyZSBhcmUgc29tZSBpc3N1ZXMgcmFyZWx5IHNlZW4gd2hp
bGUgYm9vdGluZyB0aGUgaW1hZ2Ugd2hlcmUgdGhlIHN5c3RlbSBpcyBiZWluZyByZXNldCBtdWx0
aXBsZSB0aW1lcyBkdXJpbmcgYm9vdCBwcm9jZXNzIGxlYWRpbmcgdG8gYSB0aW1lb3V0IGVycm9y
LiBJdCBpcyBub3QgbGlrZSB0aGF0IHBhcnRpY3VsYXIgbGF2YSBzbGF2ZSBtYWNoaW5lIGhhcyBh
biBpc3N1ZSBiZWNhdXNlIHRoZSBuZXh0IGpvYiBydW5uaW5nIG9uIGl0IGNhbiBzZWUgc3VjY2Vz
c2Z1bCBib290LiBUaGlzIHNpdHVhdGlvbiBpcyBzZWVuIGlycmVndWxhcmx5Lg0KDQpGb3IgZXhh
bXBsZSwgSW4gdGhpcyBqb2IgIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIv
am9iLzExNjQ0MDAjTDE2NjcsIGl0IGNhbiBiZSBzZWVuIHRoZSBzeXN0ZW0gaXMgYmVpbmcgcmVz
ZXQgbXVsdGlwbGUgdGltZXMgaW4gdGhlIG1pZGRsZSBvZiB0aGUgYm9vdCBwcm9jZXNzLCBmaW5h
bGx5IGxlYWRpbmcgdG8gYSBib290IHRpbWUtb3V0IGVycm9yLg0KDQpEbyB5b3UgaGF2ZSBhbnkg
aWRlYSBhYm91dCB0aGlzID8NCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0KU2FpIEFzaHJpdGggU2F0
aHVqb2RhIChUIFMgSSBQKQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYXNo
cml0aCBzYWko77y077yz77yp77ywKSANClNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDEx
OjQ2IEFNDQpUbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCkNjOiBjaXAt
ZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NClN1YmplY3Q6IFJFOiBTcG9yYWRp
YyBmYWlsdXJlcyBvZiBzd3VwZGF0ZSB0ZXN0cw0KDQpIaSBKYW4sDQoNCkkgc2luY2VyZWx5IGFw
b2xvZ2l6ZSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIEkgb2JzZXJ2ZWQgdGhlc2UgcmFyZSBU
UE0gZXJyb3JzIGV2ZW4gaW4gbXkgbG9jYWwgbWFjaGluZSBkdXJpbmcgZGV2ZWxvcG1lbnQgYW5k
IHRlc3Rpbmcgd2l0aCBzZWN1cml0eSB0YXJnZXQgZXZlbiB0aG91Z2ggd2UgbWFkZSBzdXJlIHRv
IHJ1biBvbmUgc2VjdXJpdHkgdGFyZ2V0IGF0IGEgdGltZSBvbiBvbmUgbGF2YSBzbGF2ZSBtYWNo
aW5lIHRvIGF2b2lkIGFueSBUUE0gcmVsYXRlZCBjb25mbGljdHMuDQoNCkN1cnJlbnRseSBJIGRv
IG5vdCB1bmRlcnN0YW5kIHdoeSBzeXN0ZW0gcmVzdGFydGVkIGluIHRoZSBtaWRkbGUgb2YgYm9v
dCBoZXJlIC0+IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzExNjQ0
MDAjTDE2NjcgYW5kIHRoaXMgcmVzZXQgaXMgaGFwcGVuaW5nIGlycmVndWxhcmx5IGF0IHJhbmRv
bSB0aW1lcyBkdXJpbmcgIGJvb3QuDQoNCkFzIG9mIG5vdyBJIGJlbGlldmUgaXQgaGFzIHNvbWV0
aGluZyB0byBkbyB3aXRoIHRoZSBzdGF0ZSBvZiB0aGUgc2xhdmUgbWFjaGluZSBvbiB3aGljaCB0
aGUgdGVzdCByYW4gaW4gdGhhdCBtb21lbnQuIEkgd2VudCB0aHJvdWdoIHRoZSBsaXN0IG9mIGFs
bCB0aGUgdW5leHBlY3RlZCBmYWlsdXJlIGpvYnMgdGlsbCBub3cuIFNvbWUgb2YgdGhlbSBjYW1l
IHVuZGVyICdMQVZBIEJ1ZyBlcnJvcicgYW5kIG1vc3QgcGVyY2VudGFnZSBvZiB0aGUgZmFpbHVy
ZXMgY2FtZSB1bmRlciB0aGUgY2F0ZWdvcnkgaW4gd2hpY2ggc3lzdGVtIHJlc2V0IGlzIGhhcHBl
bmluZyByaWdodCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBib290IHByb2Nlc3MuDQoNCkkgd2lsbCBk
aXNjdXNzIHRoaXMgcG9pbnQgd2l0aCBDaHJpcywgYW5kIEkgd2lsbCBsZXQgeW91IGtub3cgdGhl
IGlzc3VlIGFzIHNvb24gYXMgcG9zc2libGUuIE9uY2UgYWdhaW4gc29ycnkgZm9yIHRoZSBkZWxh
eWVkIHJlc3BvbnNlLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCBTYXRodWpv
ZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogRnJpZGF5LCBKdWx5IDEyLCAyMDI0IDc6MTAgUE0N
ClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNp
cC5jb20+DQpDYzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQpTdWJq
ZWN0OiBTcG9yYWRpYyBmYWlsdXJlcyBvZiBzd3VwZGF0ZSB0ZXN0cw0KDQpIaSBTYWksDQoNCndo
ZXJlIGFyZSB0aGVzZSB0ZXN0cyBhY3R1YWxseSBmYWlsaW5nPyBUaGUgYWxzbyByZXBvcnRpbmcg
dGhhdCB0aGV5IGFyZSB1bmFibGUgdG8gY2xlYW4gdXAgdGhlIGpvYnMgcHJvcGVybHksIGJ1dCB3
ZSByYXRoZXIgc2VlbSB0byBoYXZlIFRQTSBlcnJvcnM6DQoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy83MzI2NDc3MzE3DQpodHRw
czovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2pvYnMv
NzMyNjQ3NzMxOA0KDQpSZXRyeWluZyB0aGVtIHNvbWV0aW1lcyAicmVzb2x2ZXMiIHRoZSBpc3N1
ZS4gQ2FuIHlvdSBjaGVjayBpZiB0aGVyZSBpcyBhIHdheSB0byBpbXByb3ZlIHJlbGlhYmlsaXR5
IHRvIGF2b2lkIGFueSBmYWxzZSBuZWdhdGl2ZXM/IE9yIGRvIHdlIHJlYWxseSBoYXZlIHByb2Js
ZW1zIGhlcmU/DQoNClRoYW5rcywNCkphbg0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0K
TGludXggRXhwZXJ0IENlbnRlcg0K


