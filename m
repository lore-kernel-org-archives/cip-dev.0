Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9AC30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 16:58:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.29720.1719939522298508114
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 09:58:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 462GwckK3654004; Wed, 3 Jul 2024 01:58:39 +0900
X-Iguazu-Qid: 2rWgK3ox5c6W6qHUEi
X-Iguazu-QSIG: v=2; s=0; t=1719939518; q=2rWgK3ox5c6W6qHUEi; m=6nXnNWDIUDXeP5ie1zSWEpuC6NRXfBboS/k2dhOie94=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 462GwaZX1619949
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 01:58:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce03VcTHSpnL5vRJHmxF4BgDHRHngVHORQuwdASBPYymYqCPUSxkYjsPSvb0AMuFcwYutzkQ/QySsK8fx0VOipumm6Vldyfxe11SiQ1/op0G9x8sbnBD393JUKVfwu8SoqDnCdy+Dq7cC/fNq81nEU0A7Vy0IBbeBJAceyeIvliWggoJ2rRu4t4ukmVokKHX1vA9tPnFaCam4U47y7d7opFFaDt5YZNWmvY4MDOtnNeV0LbL8ef8bdfQCdGjdaCSojxsFAxmO4UhDdT32XtDkOp6E0KsmNCWVj65qoafC8UAI+RjcWe3xsv4fp7WjJ1jjkPWvYQko63p1qPrKQVwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZONfGLhcQWFTtOEmzMRLucdXLa3lQX27cMPPy/YTNw=;
 b=GwbrW5qD/u842mzVBlip3weBU4Q96IQcQHaRwJH8WZDj7skzVKpwLFocHHuXox6e5H/eFUIJ/Rgldjd8VOcqnvmzuTLtrHtYoW05VT5TgUYR7ruwHEad3C3WA/puJMAXsudCEBZM1CYvxrenLnP70uT0DOdkKaXISrI00CoDEjKQGpge0NE+69nEamP/MGhmOD2G+VtKUawbLquqrKSAf6WKCWwa0o5hIWHjXpHzo8a2HOurgIvQxDNt5aTW+cNYCcQajN3JDBAEhHGazXJrNRtDDZqvZnM9fjJO697OfbklX6j0ppcqasPuOD3jvBVuaRmbTswqRWnNBjF4fmKhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] ci: Only allow IEC tests to
 still fail
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] ci: Only allow IEC tests to
 still fail
Thread-Index: AQHay3TKV15D1eb7+ECZzp1X52Q9gbHjnB2AgAAI6FA=
Date: Tue, 2 Jul 2024 16:58:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103277C6D5226300C60A890C2DC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <063a4e8a-4daa-48f4-9dba-2df7961f5b95@siemens.com>
 <e9bb1b92-ad36-4a12-9a40-2ab6c523ab34@siemens.com>
In-Reply-To: <e9bb1b92-ad36-4a12-9a40-2ab6c523ab34@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB10280:EE_
x-ms-office365-filtering-correlation-id: de54ea40-5aa5-40b8-526e-08dc9ab834fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WU5XRElyQ1ZUMHdpMXM0aDYwVWpIWDV1OEZCVnREME1WejlKbDN5b0hSN0tD?=
 =?utf-8?B?SHlUZitDRDNvbUl4ZGs2a25vdHlxcG5DU0pidC92L0Z4aWtPMDNVdDQrd2V5?=
 =?utf-8?B?WldFTEN1SnpJMWZ1UHArbWoxT3IzckhGdFgvL0wwbFF5MHFsVFUvMUNiUUdD?=
 =?utf-8?B?Y090NWJpTXVjMUpYUUh4eVZRS0E1cjlQbmxTTk5aU0hBaHI3RnkyYjI2YlB5?=
 =?utf-8?B?ZnVSVU9odklsNVRWc2JnMGxkMVJmYWliY1hpQlVrUnBZOUw2N05tWDBmY0hD?=
 =?utf-8?B?c05BalRSZlEyR1J5UEpzTjJlbWc0RnNpNjJnUFEzOHFiNjhPaVRnRHRYUncx?=
 =?utf-8?B?TVdtY0RHeXR4MkFFbElzVTNwdXQ3OUNrb1NOZU8xelkvNE5WeG9ZQUNVam95?=
 =?utf-8?B?TmJqTVhORWoxb3hNWU9vTkNtYWp1VFlqVzZPMk9sVlh5UUwzOGlQeDZwMHFS?=
 =?utf-8?B?MFdRQWlKVzRWc2hWQktYRXpCekJNKzg2WnovemRNL0FXR3lmNHZuOW56a1RH?=
 =?utf-8?B?bGl5SmRyTE5KQ1lPMUlyeXZlOXM3QWRwUXU1NUpvYlc5aTF0b09VVTVDbmIz?=
 =?utf-8?B?QzZZblZsOUJVMUhXZFFrV2c5ZTgvZnU0ZCtKNzhyTE01bG11eXdCTGJTUTBZ?=
 =?utf-8?B?b0ZCUkJyVXNUb3BtZGZIVkE0QXorSTU3cG44MDBDaEZPNmIzTFNkVUtuWHFp?=
 =?utf-8?B?UUFpOG5LdEp0QlJ4NzRCQ05aSkc0aVBjQ21SNk9DcmpJQnpCMVg5ZUZkODdM?=
 =?utf-8?B?cXJGQmVhRHNkM1d0YjlrMXlUcVZ3QjBJckpVVzRGYnIrdEdpOFFXTE9Lb1A4?=
 =?utf-8?B?am03d3RiYUZCdFc2YU96YnFyRWtveXdpMkhPUlJmcEt5Sm82aE5NZWRDNVRT?=
 =?utf-8?B?cjB1N29PQmNNVlB5SHVDZUxUZnY5ZlM2TGcvamJ4eVI3STdIY1JoV3dNS2pr?=
 =?utf-8?B?VnpINDhVY1NzNk1OVTJLbFhiblo5Q1JyTENzKzFDTjl0K1JwM3k3UWtlYkl3?=
 =?utf-8?B?QklOUWhsOTlMWGo5eTZRVDdFVUhvakkwYi9NYytOUTFTZUZ1UWRkanJxOEt5?=
 =?utf-8?B?RFZkdkROamg0UHlvb3FDQURjQjRpWWdNMjBrV0tFVkZ0V1JYeFBxS0Q5SDRR?=
 =?utf-8?B?Q0xjc2J1VW5OaDVIaWljZ0FwQnJ1dktOWDBPZGJvZmdGUHZOcUg2bW91dWZu?=
 =?utf-8?B?b29CcDJLTWRVR0Exak0vK1RkcFdCMkFrblRqODFjWmUremw2RENIY2Y2emt1?=
 =?utf-8?B?cEZNUDI4N1N3Ri9scldZTGJCS1kvZlE3YkJ1OS9pTmI4akErZW5wbW1id3ND?=
 =?utf-8?B?NEZRdEJUU2ZQcFRUZU5mQTZCWEpxajh3bjI1T0VLdTlBSjQvUExEbFR2NmFB?=
 =?utf-8?B?L0p6RnRPeVdqTHF2TjNJblZHSnlsNWduYXRCUE5leGRDNDBickZsaXpzWGlt?=
 =?utf-8?B?aFAvQ244U2FXbDJjaVBkczdsajd0QmhYcHZrUElEZUExZkxPK1hMdy9vc0M2?=
 =?utf-8?B?YmY4aE4ydXE3dW1LU0E1WTJQclY5SmtoTjB6dGs1MG9UQXlYRGxFSkRJbzQ0?=
 =?utf-8?B?cmJDSm5KUW91cElRaWZaMXR4ODlXYlpjcUpZVHdCdUt0Z2NhTFlUd2NDNUxl?=
 =?utf-8?B?SC9OenlZQlJVRGk1bXViRVAvSG5QM21FRE5TRWdXb2pqMUs5SkVNQjRjOUt5?=
 =?utf-8?B?c2Rjcml5RUhMTXFYaWlqNmxSeTIyMFdzRlprSDJXTUpBcit3RHZXd1ZOSlFO?=
 =?utf-8?B?L1pucUNjcU9OSmw0Q2s4ZVdOOWZMZ0xvMlJFdkpBUGRjZGhHQVVaN3JkMXRo?=
 =?utf-8?Q?hwdSd3jfJdYvbC20FR6tqe3gIczKgRPYvsJeE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L0lGQUVMMVJKK1VtOEloUWtYZVhhak05UFM1aFRVY0hUaStTbzVzSDhMdTRT?=
 =?utf-8?B?TmdKV3grR1FlWllEendMOVpGQVpiWDZuWjBtWVhQVkNRWEhSQU8xNklNd2pI?=
 =?utf-8?B?MGhha1FPa2NoNUR1UFllV1I0bTRXaEZsZU1QNjNzekNiV1M2UzdQb3M4Yncy?=
 =?utf-8?B?dERxN3FxQVY0ZUdZN2JjdkZMVjlyTFRxRTFiOWw5SGdIcEtRVTFqS0YxK0lE?=
 =?utf-8?B?bTliT0dmalU1RGFPbEd4b0tseHNOVUNzMk5VTXdacllOdGx6MkVPRE80R2Jv?=
 =?utf-8?B?Y3FtWmFpd2NDYllTZnNabW1rVllRUU5sYVZpczEzcnVWVmJOZVA4d1o0bjho?=
 =?utf-8?B?T3hjb2ZPQ3g3MlhYd2czVHhuM0p1QTNTSGtDUkF4ZnU3V0V3QWU5UnlDUlI3?=
 =?utf-8?B?U1Z2WjNJMTRWTXRHanBBT0lUOHg1aEZYZFIxVTBvTXNOWTNhNXlCZFE1cTNK?=
 =?utf-8?B?ci9qeWRhSFkxcW9vQWZvY2hSeStaaTBhcTRVbnA1NmNHZXBZL1Q1cXBFU2Ur?=
 =?utf-8?B?eXZoSkx0OHNUUXkya0RKdHZXdDcvay9VRXkrekRjZnlKaFljelA5QmJHL3hw?=
 =?utf-8?B?QzRqOTVjbXpIRWRlUE5rbDNhQ3VhZGthbUFKZWJSVDJ5bkhoYUxyclNLMHlP?=
 =?utf-8?B?U3RTaFJBMThxRHJ6Zit4ZE9KR0tabDBwSk52UHFDMjZpT1ZiaDZOZWlQQjFG?=
 =?utf-8?B?TUsvL0lrWlg0bEZFNDRyMW5RNTZLNVcxTjNKZXBCKzFjZGtuajFtRmRhNzNa?=
 =?utf-8?B?RDdRSzVnUXI3WlR1VHFMejVSUlFma0NkWVpLOFNMZWl0QmxUWHE2ZExqQUlx?=
 =?utf-8?B?amJGVVpYR3ZxbVJWVUtOWHBSeG05cFU3UlRmUjNiSWNHa0loNVNGT0FxU2gy?=
 =?utf-8?B?YVFKZmlXNno2Vll4K09tMG1lRXl1d3RGZm16OFpuT0h1Q05XNU9Tc1Ura1lJ?=
 =?utf-8?B?UGxteWJmNjlQTGlMcllBWWhTVDE4TE82Z1hQcE1jMWxndzhicm1YTnl4NTE4?=
 =?utf-8?B?T3ZFTk9ZZ3hMREkybmYwZjFuNERPb1UwUUw0OTVkSHpua3M4YktFM2dCVDda?=
 =?utf-8?B?OW9NTzFSaWxSbitNTE9Ed0F3cVA1enhCM1VFcWIwZUVtTkQ3bFg1Z0N6RWZB?=
 =?utf-8?B?TVFvUnl5dWR3a21iZTUwQjgzVnZUU2k0ajh2ajZMMElOWWQ1Y29HcVJaUnZN?=
 =?utf-8?B?NGJhTFF4dFZpMXFjSm5WYWJqSTByK09QdUNuei9leTZ1MFhPaGc4WjJUaURw?=
 =?utf-8?B?MjJ2c0NCY1VoODV6VUt6TVF2bGF0aGVXYk8rYXRTMjd2Q0czeE5ZWWxPRHlV?=
 =?utf-8?B?aVduRktlMFpjYkdUUjlkT1RvcWtUZG5LVTdZYXFzYStIQ0FEekhkam93OUc0?=
 =?utf-8?B?UHpMYS85MWdNUVpuWEpGckErdUJqbTFObjdBR3FXRVphcU9rMW9Cem0vM0ZS?=
 =?utf-8?B?QW1hZCtMektuenZJMEIwZ3FHaCsyalUzNFVjZnpyR1pLazNrWDFFVlRuZnNm?=
 =?utf-8?B?d2U0cFFlU3ZISDlrTFc4c3hudFlxaVEvR2lnb090WXIzTlhKZ2NsalQvaDVV?=
 =?utf-8?B?bWN1ZlVwb0NGK2hIcnBqeFNEc05xWjRSbjZKa0pJR1BTZXMwY0x0YnJDN09J?=
 =?utf-8?B?WmdNVTIwYlJNd0QyNEU3VmkvRjBHMmh2bS9OUy9hK0VzT201a013aXovYnU3?=
 =?utf-8?B?eWx6dU1CTVpmUG5mb1NSOGgwTVY5aTdyOXVyaGRHbk9XamQrd2ZPM1lTbjRp?=
 =?utf-8?B?MjFpTC9DblJZQmJJaGRuT3IyQVFDbWpaaGQvVDZ5ZUF4RkxjSFBlVlZYT2hO?=
 =?utf-8?B?UytCR1haN2VEelN1WDFoRkxnS084ZzA1Ti9rVVZ6MFd1QVgwekxMYXlHR0hm?=
 =?utf-8?B?cWJzeWxnUmR5NDdQaTRmSURhb0dWMndTbG9VbitBUEJGUzlrR25ZcVZySk81?=
 =?utf-8?B?MWN1UTJEYU4ybkswUG4weHplaTZYQzJLQy93MFJpY1FZZDBqOU0yeVlqRHR5?=
 =?utf-8?B?MFU3ekFyOGV6UXJOWUZxUG1ETW44cGdxZjZCUlNFcWQyS0dFM2paWnpsQVVM?=
 =?utf-8?B?U294OXVlVjBRMDdPTEJrNzhmNkJBSkZlNjZKa0drRWo3MkluQ2cyTktYejQx?=
 =?utf-8?B?RGd5UE41VDdTYVFGVDBPUVgwQ0VxcXlKUzdPT042cXZVWGVxa0s3LzhSdmdT?=
 =?utf-8?B?TWVHdXZCai9OZmtwT2Y4TXRlK2piT25UZmV2dGNUR0c2RkRoSDNwako0TDRJ?=
 =?utf-8?B?Q1poUEhrSFNPMUtReTJQZDJEaXZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de54ea40-5aa5-40b8-526e-08dc9ab834fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 16:58:33.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0sMsHP8CKjyOHH7NQZ9KgFuHzQvno/MaPtnGeY4cD9pcj/85+J4RXkTzN1rSnHRaOcfFv7QXP1wqE2QK7J1LI/EdOrxF96sfJcAoHdDCJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 16:58:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16364

SGkgSmFuLA0KDQpUaGUgcmVhc29uIGZvciB0aGVzZSBmYWlsdXJlcyBpcyBiZWNhdXNlIHRoZSBz
d3RwbSBwYWNrYWdlIGlzIG5vdCBwcmVzZW50IGluICJsYWItY2lwLXNpZW1lbnMtbXVjIi4gc3d0
cG1fc3RhcnQuc2gsIHN3dHBtX2ZpbmlzaC5zaCBldGMuIGFyZSBtYWludGFpbmVkIGhlcmUgLT4g
aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xhdmEtZG9ja2VyDQoN
ClRoZSBtYWludGFpbmVyIG9mICJsYWItY2lwLXNpZW1lbnMtbXVjIiBzaG91bGQgdXBkYXRlIHRv
IGdldCB0aGUgYmVsb3cgbWVudGlvbmVkIGNoYW5nZXMuDQoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtdGVzdGluZy9sYXZhLWRvY2tlci8tL21lcmdlX3JlcXVlc3RzLzM1DQpo
dHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGF2YS1kb2NrZXIvLS9t
ZXJnZV9yZXF1ZXN0cy8zOA0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0
aW5nL2xhdmEtZG9ja2VyLy0vbWVyZ2VfcmVxdWVzdHMvMzkNCg0KV2UgYWRkZWQgYSB0YWcgbmFt
ZWQgInN3dHBtLWpvYnMiIHRvIHNwZWNpZmljIFFFTVUgZGV2aWNlcyB3aGljaCBoYXMgdGhlIG5l
Y2Vzc2FyeSBjaGFuZ2VzIGluIHRoZWlyIGRldmljZSB0ZW1wbGF0ZSB3aGljaCBhbGxvdyB0aGVt
IHRvIHJ1biBzb21lIHVzZXItZGVmaW5lZCBjb21tYW5kcyBiZWZvcmUgYm9vdGluZyB0aGUgQ0lQ
IHNlY3VyaXR5IGltYWdlIG9uIGl0cyBob3N0Lg0KDQpJIGd1ZXNzIHRvZGF5IHNvbWVvbmUgbWln
aHQgaGF2ZSBhZGRlZCB0aGUgInN3dHBtLWpvYnMiIHRhZyB0byBxZW11LWNpcC1zaWVtZW5zLW11
YyBidXQgYXMgdGhlIGxhYiBpcyBub3QgdXBkYXRlZCwgam9icyBhc3NpZ25lZCB0byBtZW50aW9u
ZWQgZGV2aWNlIHdlcmUgdW5hYmxlIHRvIHN0YXJ0LiBTbyBlaXRoZXIgdGhlIHN3dHBtLWpvYnMg
dGFnIGNhbiBiZSByZW1vdmVkIG9yIHRoZSByZXNwZWN0aXZlIGxhYiBzaG91bGQgYmUgdXBkYXRl
ZC4NCg0KUmVnYXJkaW5nIElFQyBsYXllciB0ZXN0cyBtYWludGFpbmVkIGluIHNlcGFyYXRlICBy
ZXBvc2l0b3J5IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9jaXAt
c2VjdXJpdHktdGVzdHMsIEkgd2lsbCBzZW5kIGEgcGF0Y2ggdG8gaW5jbHVkZSBjb25maWcgcmV2
aXNpb24gKGNvbW1pdCBpZCkgdG8gdXNlIGluIElFQyBqb2IgZGVmaW5pdGlvbnMuIFdlIGNhbiBw
YXNzIHRoZSBjb21taXQgcmVmZXJlbmNlIHRvIHRoZSAndGVzdCBhY3Rpb24nIGluIHRoZSBqb2Ig
ZGVmaW5pdGlvbnMgdGhyb3VnaCBzdWJtaXRfbGF2YS5zaC4gSSBhbSB3YWl0aW5nIGZvciBTdGVm
YW4ncyByZXZpZXcgb24gb25lIG9mIG91ciBtZXJnZSByZXF1ZXN0cyB3aGljaCBmaXggbW9zdCBv
ZiB0aGUgZmFpbGVkIHRlc3QgY2FzZXMuIE9uY2UgaXQgaXMgbWVyZ2VkLCBJIHdpbGwgc2VuZCBh
IHBhdGNoIHRvIGluY2x1ZGUgY29uZmlnIHJldmlzaW9uIG9mIGNpcC1zZWN1cml0eS10ZXN0cyBp
biBpc2FyLWNpcC1jb3JlLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCBTYXRo
dWpvZGEgKFQgUyBJIFApDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6
IFR1ZXNkYXksIEp1bHkgMiwgMjAyNCA5OjM0IFBNDQpUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+OyBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVq
b2RhQHRvc2hpYmEtdHNpcC5jb20+OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9E
RyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVo
aXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8
sO+8lCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2Np
cC1kZXZdIFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gY2k6IE9ubHkgYWxsb3cgSUVDIHRlc3RzIHRv
IHN0aWxsIGZhaWwNCg0KT24gMDEuMDcuMjQgMDc6MDgsIEphbiBLaXN6a2Egd3JvdGU6DQo+IEZy
b206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IA0KPiBTZWN1cmUgYm9v
dCBhbmQgU1dVcGRhdGUgdGVzdHMgYXJlIHBhc3Npbmcgbm93IGFuZCBhcmUgc3VwcG9zZWQgdG8g
DQo+IGtlZXAgdGhhdCBvbiBmdXR1cmUgY2hhbmdlcyBhcyB3ZWxsLg0KPiANCg0KQW5kLi4uIGl0
IGZhaWxzOg0KDQpodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1j
aXAtY29yZS8tL2pvYnMvNzI0NjM5Nzg3MA0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0
L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzcyNDYzOTc4ODMNCg0KSSB0cmllZCB0byBm
aW5kIHdoZXJlIHRoYXQgc3d0cG1fc3RhcnQuc2ggaXMgZGVmaW5lZCBidXQgSSBhbHNvIGZhaWxl
ZC4NCkNhbiBzb21lb25lIGV4cGxhaW4gdG8gbWUgd2hlcmUgd2UgbWFpbnRhaW4gdGhlc2UgLSBh
cyBpdCBsb29rcyBsaWtlIC0gbGF2YSB1c2VyLWNvbW1hbmRzPw0KDQpBcyBJIHNhaWQgZHVyaW5n
IG91ciBjaXAtY29yZSBXRyBtZWV0aW5nIHRvZGF5LCBJIHdvdWxkIGxpa2UgdG8gZW5zdXJlIHRo
YXQgYWxsIHRob3NlIGRlZmluaXRpb25zIGFyZSBwaW5uZWQgdmlhIGlzYXItY2lwLWNvcmUgd2hl
biBpdHMgcGlwZWxpbmUgcnVucyBzbyB0aGF0IHRoaXMgdG9wLWxldmVsIGNvbnRyb2xzIHdoZW4g
YSB0ZXN0IGNoYW5nZSBpcyBpbXBvcnRlZC4gQW55IHN1Z2dlc3Rpb25zIGhvdyB0byBhY2hpZXZl
IHRoYXQ/DQoNClRoYW5rcywNCkphbg0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGlu
dXggRXhwZXJ0IENlbnRlcg0KDQo=


