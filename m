Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B1DCA5FC4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 15:22:22 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14880.1790954538411632480
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 08:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rIe3u1J9;
 spf=pass (domain: siemens.com, ip: 52.101.84.58, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzNQxnnnWJK/kBiz76WCD3/BrZR8DVdPlYqyTHCOqoCCuwZzSImVk07dmH2KWR2xh0J3o9Px4CeeReqD8HyR0+ugtjebzg4ZTsAs/t9o2sziGE3siBQGfeSXHtnjSYCLSiiaPtnA0PB1Kyx5tSq4CTX6DHeSW7/duKnoTwC72yB3iKoGM4dTfYQ+dw3tDTylTL4+xNayC+wwrF49zkfITLMvCXDdd6KlYNRJ9pC6SCIYKIL6ZTPmirhrlA0mGBSeT8JK9YiuGhOV8MrvS635GS4EnIfwr8MA4vhBrjsygjr3rSuMKum3L2oePVSpEWBYX/kVMo3xta8iIc9BUQj9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fqCn+Nn+MYlthvvUkFRa3P28aeosSJHOPpEPr0mc2U=;
 b=EHLKHL/UOT64QPX5hoefD3k2sK4B8atqqhYgKRP/U1hh3Y6F0fPjvorDzvIpj10bZJzpEjqk5LPtM2q29fIXuqch2ZL992miqCpQ8AQTPZjCPZMVozM0i+1zkDaxtoqY6Pf9xoTW1NggG5poVs4HmzbRiiZJ7Nc5ngky1j9LB4Efh7znk12xphbhj5ZZjI2FulUo+NOijAKkBLMo+pwK0AuShLQHwB/73qwVfj0WEFgGS55ZW5zVnbe+vV5jJa41+coVo88rOE1w4SbdVkHDuIeaWc+bS71SUwWPJ49X6qdAykPpMk+k1Kc+cbivMJY/HPz752nsUOJupSUkCIiNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fqCn+Nn+MYlthvvUkFRa3P28aeosSJHOPpEPr0mc2U=;
 b=rIe3u1J9AlwMo2wSDAjV8dyldgTJG5J6bSwUDXoN4hIaGnTpGIS428nlqv2IZpM0MGTsgHTWKJ7oOtTBZnqXFoVCEWntJZNnG8+Zr0eL5iFdaHl7MNiPvy0RcEdmZoARexGiyQaIvggSI9L8cUUVJCR/kQzqtUNF3B4JXvZMwLJ7/AzdY140qPb7FH6TFTh9aG8N6uMauEOxQD/hQRonGqb5BFrKw+qWaMuulMi+Wi851/j9l0rA/7rBmuNwuVlkRKpf6S+KNkCQ3rxWKvai0G4UVU/reXwXJHfQ8lxcsbSuE0Cx3fmx6+Gvt66p5wTWTNFHWmnXhe8V8BhNVSxDPw==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB6557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 15:22:11 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 15:22:11 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "Hombourger, Cedric"
	<cedric.hombourger@siemens.com>
Subject: Re: [isar-cip-core][RFC 09/11] watchdog: use the rootfs systemd
 watchdog timeout in the dracut initrd
Thread-Topic: [isar-cip-core][RFC 09/11] watchdog: use the rootfs systemd
 watchdog timeout in the dracut initrd
Thread-Index: AQHdUl/zM1MCO4aGqEOa2uGVcS4sB7bqXteA
Date: Fri, 2 Oct 2026 15:22:11 +0000
Message-ID: <dada54a5507157cbb8971fbea78257ff3de1dfce.camel@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
	 <20261002111938.3600786-10-quirin.gylstorff@siemens.com>
In-Reply-To: <20261002111938.3600786-10-quirin.gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU0PR10MB6557:EE_
x-ms-office365-filtering-correlation-id: 6b149154-4ab8-4b1f-5912-08df2098ee43
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|55112099003|22082099003|18002099003|3023799007|6133799003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 GDoEwaA2TxFDMNCI6D3GGu1P7b/mlMdnbKMCkh2PIcNcw5WCt5yt6oSDHA/G5wwn8AiMmiF995O/dRFY30t0QC2OKhQ/Um9eZFSMX6eL7cxtFCq36h0YkmCLfrvvG5CAAhzW5UHKi8WG7NNMwAvnBCLgVznZNHjKVmrN9qeOqNyHrpCgCK3IIO5wacOWyKdfSGN11zchKcAB/UsFUeb8QD2dOO4Bh2M3GFJky2wJtkboMlNI2NqVGPROHw9ZpOxDquV6v5tPdDWXQ8GSbPDpnn8W4o/oh+1c4NmOfV+pThhvVsHsUwEyfnfbT2lZeEKBqxvJ11ddTrwocxooeu/tHt9JIR0qzJFzbTtcH759bVJ6QZBO2CMbvxPlTgG8uFbCwh8JNJzctgyoCDGBvgD0LRkJFeYgwAs1/DdIJioQmgCC/rTXU49ki+trQplgk2eyTieGs3asipq0tHLMPnja9cIKTgj5+zJUBCF7ieuUDr6URpvO6etJiLLNjHVUEfUcrCJwVRZOdVonbVPf/8dimEoexl342e4kpx2iXPyu1Wgzjd16rSB4QH4YZaW8e8oufYXj4eWv3MVs9rs8zuaTXtXDJjUgqjG/kCip4IqALVw3SzzPSPrUMdjlb9f7xjdDQ4s6cbzocXi81heIBu0GwKVHFL9ZDPZlHmd5sM8IlbINGFjPDeOculP3v+EHrsmHzVxyn8pxBYr0AWyqN4aN/W/zOvHxNm42SaZ3S1l0TKo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(55112099003)(22082099003)(18002099003)(3023799007)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L2RscDI2dXF3UlNWakJKNjhlbGJxZGhvbjVWaUU3cmpUYnBaS1JGRUxyRnk5?=
 =?utf-8?B?SXVkQnhZT1pwVHhiSXE5bkkvK1FYempNa3AxMkNRTDJlR0Jqc2pKRTFhUlNW?=
 =?utf-8?B?OG1NYXd0Z21ZNWJYbDdvMzdHMDQzOE5McGVpc3RiYkg5cytWNEZjUlJ4dXpE?=
 =?utf-8?B?QldiV3ZxQXFTWG9FZkhYb3MrMmtXb2UvVU1KWmttenMwdjcrZWdpRXZ6YXBw?=
 =?utf-8?B?ZXBGR0Myb0FoTWx5QUVpK083ZjRiQWgrQXFDZmZEN084cjdqdnprdTVtclho?=
 =?utf-8?B?Q0VqYnhHWmx3MEgzUmhBNi9BZWF5ZEl0WTdKUUJqdlMxU3hhMGhub1hwYm5V?=
 =?utf-8?B?dmcxYVB0aU9nMVhocE9MN2FWZ0tvajZONkVxdmJGbUNaUjdkWFlHRE9Tc242?=
 =?utf-8?B?UGRFbFU0T2pEWWgyblpISzdaaEdFYVdFdGtvazNnc0J1TVBaKzhQcUFDRktp?=
 =?utf-8?B?QThhWGZaVmkyd21vWit1T3N3VEZpcTkxelhNdU1JazhaMXFMck0vTW02K0g1?=
 =?utf-8?B?MlZ1aEs1ZUtjaHVFckhEeDdJNnFkSWkza3M3RFhsdmlwWkFxczRDd0dLcW5t?=
 =?utf-8?B?amp2T0IvSTRvS1BGaUYrbG9jNUVnK3d6MFE2RnB0Q1V5WmhGbkdSOWhMekJ6?=
 =?utf-8?B?YWQ4R3hEUmVOMnlsbDdTMGxpa1A4dWtBbkNxcTYyeVI0RGNDSlZQazRBQWlh?=
 =?utf-8?B?eFFCYzV2MEpuenBnYjdRTzdvUUMxcGFGdHhMSWlaOTZKaDhIYTk1VFdhWWZ4?=
 =?utf-8?B?NjVVdThreS9pS3hTbENtVWdBZEtZc052MlIvWnROazlqYlJZWjAwZnlrbTk0?=
 =?utf-8?B?YlhlaCtuMmNJNCtGcWFGNHdGOHRIRUxCaHl0cS9HNFhXakdDcVY0NW9UaFRn?=
 =?utf-8?B?TWhpSndwc0pRNHJNcnl6M1V5bElsS1Q5OXRoQ2NtZ1cycW9hZFh4SXNXL0xW?=
 =?utf-8?B?VWgwU2NnZFJCTmJTQnVuVHB3ZzVnTjBYWXR5aGJRRWFVZ3VXT3NySmROQ2JW?=
 =?utf-8?B?b0FQeDY0dTFjV3BWeVVJTVJlWUtHQllnbkgzMDVZZTBra0svNUZHSGR3NHNU?=
 =?utf-8?B?K1pFK01YbFIzVjBoZDU5Z0dFWkxwekNYcjFqM2hhSXBLcHpoTS9XcFRLRXVZ?=
 =?utf-8?B?SS96TmZBTnJTckRCUWZxUmNSL1dXSW1oS3d3YUR0L2d6bzRwZFJzam5XdUlk?=
 =?utf-8?B?RFJObFFlNDNZaXB4VWd3MDZPelJiN1c4Wk5Nbk1UNEZYK0NiT1JDZDJNbDdp?=
 =?utf-8?B?SDBTRWRqaU9MK3ZmWUZFR2UxT2pGS0s5akplUnQydko0RENWclV4eU82K0o3?=
 =?utf-8?B?OEw2ZXpYQk1QMWlxSFB1ZGxWWFpLamc0OStnWlBtaGprcTh2VFlPQzA0SWt4?=
 =?utf-8?B?bFV1TnNkNmxVaS9URE5IVkJtVmU2VnQxUGtFdWNBTlF3VDJTSnV5N2kxclEx?=
 =?utf-8?B?blRsZGRTdHJVSUtLUmJibnpCOE9YaXExeUlPQzZxWkpVa2pxUWc2OGx3ZUF4?=
 =?utf-8?B?UVlScXZ4OGFoNmJLYlNoMTRIc1pPeTlsVWVrNCtnS1V1QWNZY0VvaWFZaFdM?=
 =?utf-8?B?d3NNd1hoZ3Z1OXE2blhpNmFRaXlMbEoyYWt0MWplOXJxbENpcFN1UTdPRHI0?=
 =?utf-8?B?a21NbDE3clNoMVY4bStNWWtEUmgweUVYRWJuREoxdTBjL0ltaWZ1NnFPdVV2?=
 =?utf-8?B?RUxBbXA2ZWE0QUIvN3dIWS95eXdxOTBUU2JJSGFtblJnY0JYVld2ZnB0dHVR?=
 =?utf-8?B?UklQbFJoc3Q2NXV6b3FWWktKY3ZUUElBM1JYTGJrWFF5b1UraWpNZGRhUkds?=
 =?utf-8?B?enYwaGZKWnBsN2tXMkRTZ1AzYy9EalExMHc3eXlkamhvSTFXYTBONmtLUUpl?=
 =?utf-8?B?Wi9iOTRtaW9WODluNTM0S1l5bDZMSkZKMSt0ZExDY3FHS2pPUG1aTGRxREJp?=
 =?utf-8?B?QjBuVGhXTUlyYTNhT0tpdk9CRlljdW9ZOWhmcXFBT1QyUDFPdlE4SHlYS1Ry?=
 =?utf-8?B?NVREV3FWRHJSbHJLWW9XdlNRRytCbHVZNlNibzlENmYvSCtYU01QanZNNU9u?=
 =?utf-8?B?ZU16U25ONW9YdnlaczdvTk93dUQwUlM5c0pINnhLWHFZL3JraVBXWmpoWlkz?=
 =?utf-8?B?a2NpYnJCMXZOSUlWcklWbnpKM0t0ZEdKMmUwZ1IydDdNbi9OcTVtNEZvQkwv?=
 =?utf-8?B?RlhUeHBscUdlcnVSOGRnRTJDY25NUkhQNXUwdDg0ZmxEbzY1VzZpU1BqdUJi?=
 =?utf-8?B?dlhqQWhzSUxzbVJ4SmZMSEpaYkQyMGlBVW9rRlZRYUFsK0dVcEZYNjUyVTlW?=
 =?utf-8?B?blV0TVh3VDFoSWpteGduZTVtelRuV0prUDVlYXpROWZRZkkxV0pxdVV2UzRk?=
 =?utf-8?Q?IIVhZizX90Gyo6OM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46DE5CC03D6EA140A2BB24E67E9BA727@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b149154-4ab8-4b1f-5912-08df2098ee43
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 15:22:11.3864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13CBG3o/kL08E8BjkhJCcnmNOJvlaYfgM7g0jmMC6+DwyYo2jj0HJqbIeOhvuY6faMqXOQgC7VvFNcscKe1KQRNu94GpQVELISjod2G9xgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6557
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 15:22:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24426

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDEzOjE4ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Ogo+IEludHJvZHVjZSBTWVNURU1EX1dBVENIRE9HX1NFQyBmb3IgdGhlIHJvb3RmcyBzeXN0ZW1k
IHdhdGNoZG9nIGFuZCB1c2UgaXQKPiBhcyBkZWZhdWx0IGZvciB0aGUgY2lwLXdhdGNoZG9nIGRy
YWN1dCBtb2R1bGUsIHNvIGluaXRyZCBhbmQgcm9vdGZzCj4gc2VydmljZSB0aGUgaGFyZHdhcmUg
d2F0Y2hkb2cgd2l0aCB0aGUgc2FtZSB0aW1lb3V0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFF1aXJp
biBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+Cj4gLS0tCj4gwqBjb25m
L2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKysKPiDCoHJlY2lwZXMtY29yZS9jdXN0b21p
emF0aW9ucy9jb21tb24uaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDcgKysrKy0tLQo+IMKgcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVzLzk5LXdh
dGNoZG9nLmNvbmbCoMKgwqDCoMKgwqDCoMKgIHwgNiAtLS0tLS0KPiDCoHJlY2lwZXMtY29yZS9j
dXN0b21pemF0aW9ucy9maWxlcy85OS13YXRjaGRvZy5jb25mLnRtcGzCoMKgwqAgfCA2ICsrKysr
Kwo+IMKgLi4uL2RyYWN1dC1jb25maWctY2lwLXdhdGNoZG9nXzAuMS5iYsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0KPiDCoDUgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gwqBkZWxldGUgbW9kZSAxMDA2NDQg
cmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVzLzk5LXdhdGNoZG9nLmNvbmYKPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvOTktd2F0
Y2hkb2cuY29uZi50bXBsCj4gCj4gZGlmZiAtLWdpdCBhL2NvbmYvZGlzdHJvL2NpcC1jb3JlLWNv
bW1vbi5pbmMgYi9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jCj4gaW5kZXggYmJjZWEx
ZGEuLmRiM2ZlMWRlIDEwMDY0NAo+IC0tLSBhL2NvbmYvZGlzdHJvL2NpcC1jb3JlLWNvbW1vbi5p
bmMKPiArKysgYi9jb25mL2Rpc3Ryby9jaXAtY29yZS1jb21tb24uaW5jCj4gQEAgLTM3LDYgKzM3
LDkgQEAgSU5JVFJEX0NNRExJTkVfU1RZTEUgPz0gIiR7QCdzeXN0ZW1kJyBpZiBkLmdldFZhcign
SU5JVFJBTUZTX1JFQ0lQRScpID09ICdjaXAtY28KPiDCoFJPX1JPT1RGU19WRVJJVFkgPz0gIiR7
QCcxJyBpZiBkLmdldFZhcignSU5JVFJBTUZTX1JFQ0lQRScpID09ICdjaXAtY29yZS1pbml0cmFt
ZnMtZHJhY3V0JyBlbHNlICcwJ30iCj4gwqBPVkVSUklERVMgLj0gIiR7QCc6cm8tcm9vdGZzLXZl
cml0eScgaWYgYmIudXRpbHMudG9fYm9vbGVhbihkLmdldFZhcignUk9fUk9PVEZTX1ZFUklUWScp
KSBlbHNlICcnfSIKPiDCoAo+ICsjIFJ1bnRpbWUgd2F0Y2hkb2cgdGltZW91dCBvZiBzeXN0ZW1k
LCBpbiB0aGUgcm9vdGZzIGFuZCB0aGUgZHJhY3V0IGluaXRyZC4KPiArU1lTVEVNRF9XQVRDSERP
R19TRUMgPz0gIjYwIgoKVGhlIGFjdHVhbCB3YXRjaGRvZyB0aW1lb3V0IHNob3VsZCBiZSBzZXQg
b24gdGhlIGtlcm5lbCBjbWRsaW5lIGJ5IHRoZQplYmcgcGx1Z2luIChiYXNlZCBvbiB0aGUgV0RP
R19USU1FT1VUIHZhbHVlKS4KCj4gKwo+IMKgIyBXYXRjaGRvZyB0byBzZXJ2aWNlIGJ5IGluaXRy
YW1mcyBob29rcyBkdXJpbmcgbGVuZ3RoeSBvcGVyYXRpb25zIGxpa2UKPiDCoCMgcGFydGl0aW9u
IGVuY3J5cHRpb24gb3IgZmFjdG9yeSByZXNldC4gSW4gb3VyIGludGVncmF0aW9uLCBlbmFibGlu
Zwo+IMKgIyBmVFBNL1N0TU0gaW1wbGllcyBhIFUtQm9vdC1iYXNlZCBmaXJtd2FyZSB3aGljaCBt
YXkgZW5hYmxlIGEgd2F0Y2hkb2cgZWFybHkuCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9j
dXN0b21pemF0aW9ucy9jb21tb24uaW5jIGIvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2Nv
bW1vbi5pbmMKPiBpbmRleCAwZmQzZDRmOC4uMDlmNGM3NDQgMTAwNjQ0Cj4gLS0tIGEvcmVjaXBl
cy1jb3JlL2N1c3RvbWl6YXRpb25zL2NvbW1vbi5pbmMKPiArKysgYi9yZWNpcGVzLWNvcmUvY3Vz
dG9taXphdGlvbnMvY29tbW9uLmluYwo+IEBAIC0xOSwxNCArMTksMTUgQEAgU1JDX1VSSSA9ICIg
XAo+IMKgwqDCoMKgIGZpbGU6Ly9wb3N0aW5zdC50bXBswqBcCj4gwqDCoMKgwqAgZmlsZTovL2V0
aGVybmV0wqBcCj4gwqDCoMKgwqAgZmlsZTovLzk5LXNpbGVudC1wcmludGsuY29uZsKgXAo+IC3C
oMKgwqAgZmlsZTovLzk5LXdhdGNoZG9nLmNvbmYiCj4gK8KgwqDCoCBmaWxlOi8vOTktd2F0Y2hk
b2cuY29uZi50bXBsIgo+IMKgCj4gwqBDVVNUT01fSE9TVE5BTUUgPz89ICJkZW1vIgo+ICtTWVNU
RU1EX1dBVENIRE9HX1NFQyA/Pz0gIjYwIgo+IMKgV0lSRUxFU1NfRklSTVdBUkVfUEFDS0FHRSA/
PSAiIgo+IMKgSU5TVEFMTF9XSVJFTEVTU19UT09MUyA/Pz0gIjAiCj4gwqAKPiAtVEVNUExBVEVf
RklMRVMgKz0gInBvc3RpbnN0LnRtcGwiCj4gLVRFTVBMQVRFX1ZBUlMgKz0gIkNVU1RPTV9IT1NU
TkFNRSIKPiArVEVNUExBVEVfRklMRVMgKz0gInBvc3RpbnN0LnRtcGwgOTktd2F0Y2hkb2cuY29u
Zi50bXBsIgo+ICtURU1QTEFURV9WQVJTICs9ICJDVVNUT01fSE9TVE5BTUUgU1lTVEVNRF9XQVRD
SERPR19TRUMiCj4gwqAKPiDCoERFUEVORFMgKz0gInNzaGQtcmVnZW4ta2V5cyBjaGFuZ2Utcm9v
dC1ob21lZGlyIgo+IMKgCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9u
cy9maWxlcy85OS13YXRjaGRvZy5jb25mIGIvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2Zp
bGVzLzk5LXdhdGNoZG9nLmNvbmYKPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAx
ZjM4YzU1OS4uMDAwMDAwMDAKPiAtLS0gYS9yZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmls
ZXMvOTktd2F0Y2hkb2cuY29uZgo+ICsrKyAvZGV2L251bGwKPiBAQCAtMSw2ICswLDAgQEAKPiAt
Iwo+IC0jIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQKPiAtIwo+IC1bTWFuYWdlcl0KPiAt
UnVudGltZVdhdGNoZG9nU2VjPTYwcwo+IC1TaHV0ZG93bldhdGNoZG9nU2VjPTYwcwo+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvOTktd2F0Y2hkb2cuY29u
Zi50bXBsIGIvcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25zL2ZpbGVzLzk5LXdhdGNoZG9nLmNv
bmYudG1wbAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAuLjNkNzUxOTJm
Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3JlY2lwZXMtY29yZS9jdXN0b21pemF0aW9ucy9maWxl
cy85OS13YXRjaGRvZy5jb25mLnRtcGwKPiBAQCAtMCwwICsxLDYgQEAKPiArIwo+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBNSVQKPiArIwo+ICtbTWFuYWdlcl0KPiArUnVudGltZVdhdGNo
ZG9nU2VjPSR7U1lTVEVNRF9XQVRDSERPR19TRUN9cwo+ICtTaHV0ZG93bldhdGNoZG9nU2VjPSR7
U1lTVEVNRF9XQVRDSERPR19TRUN9cwo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9k
cmFjdXQtY29uZmlnLWNpcC13YXRjaGRvZy9kcmFjdXQtY29uZmlnLWNpcC13YXRjaGRvZ18wLjEu
YmIgYi9yZWNpcGVzLWluaXRyYW1mcy9kcmFjdXQtY29uZmlnLWNpcC13YXRjaGRvZy9kcmFjdXQt
Y29uZmlnLWNpcC13YXRjaGRvZ18wLjEuYmIKPiBpbmRleCAxZmQxYTg3ZS4uZmRhZDk0ZWUgMTAw
NjQ0Cj4gLS0tIGEvcmVjaXBlcy1pbml0cmFtZnMvZHJhY3V0LWNvbmZpZy1jaXAtd2F0Y2hkb2cv
ZHJhY3V0LWNvbmZpZy1jaXAtd2F0Y2hkb2dfMC4xLmJiCj4gKysrIGIvcmVjaXBlcy1pbml0cmFt
ZnMvZHJhY3V0LWNvbmZpZy1jaXAtd2F0Y2hkb2cvZHJhY3V0LWNvbmZpZy1jaXAtd2F0Y2hkb2df
MC4xLmJiCj4gQEAgLTE0LDcgKzE0LDcgQEAgREVTQ1JJUFRJT04gPSAiQnVpbGQgY29uZmlndXJh
dGlvbiBmb3IgdGhlIGNpcC13YXRjaGRvZyBkcmFjdXQgbW9kdWxlIgo+IMKgREVCSUFOX0RFUEVO
RFMgPSAiZHJhY3V0LWNpcC13YXRjaGRvZyIKPiDCoAo+IMKgSU5JVFJBTUZTX1dBVENIRE9HX0RF
VklDRSA/Pz0gIiIKPiAtSU5JVFJBTUZTX1dBVENIRE9HX1NFQyA/Pz0gIiR7QCBpbnQoZC5nZXRW
YXIoJ1dET0dfVElNRU9VVCcpIG9yIDApIG9yIDYwfSIKPiArSU5JVFJBTUZTX1dBVENIRE9HX1NF
QyA/Pz0gIiR7U1lTVEVNRF9XQVRDSERPR19TRUN9IgoKV2h5IHRlbXBsYXRlIHRoaXMgYXQgYWxs
PyBEb2Vzbid0IHN5c3RlbWQud2F0Y2hkb2dfc2VjPTMwIG9uIHRoZSBrZXJuZWwKY21kbGluZSBv
dmVyd3JpdGUgdGhlc2Ugc2V0dGluZ3MgZ2xvYmFsbHk/CgpGZWxpeAoKPiDCoAo+IMKgQ09ORl9O
QU1FID0gImNpcC13YXRjaGRvZy5jb25mIgo+IMKgQ0ZHX1ZBUlMgPSAiSU5JVFJBTUZTX1dBVENI
RE9HX0RFVklDRSBJTklUUkFNRlNfV0FUQ0hET0dfU0VDIgo+IC0tCj4gMi41NS4wCg==

