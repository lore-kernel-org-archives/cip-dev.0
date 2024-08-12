Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A63C3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:11:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.43818.1723461061018353008
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 47CBAvWV1280107; Mon, 12 Aug 2024 20:10:58 +0900
X-Iguazu-Qid: 2rWg67yerBlZCZnk3c
X-Iguazu-QSIG: v=2; s=0; t=1723461057; q=2rWg67yerBlZCZnk3c; m=NMDVH1V/E7K47D81/qdtnwQgp4SBiRabQ/ouBVRmvrY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 47CBAtM23235554
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 20:10:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZO6vqMBBqfV/umeGWK/vMMmCK3HAw/dOM4tdy3lZ2QR6JYHFBJm8CRpFPwnLVhZXrxRI0n8pMS8StkpV5hQvauZNpz1QeijyoRbs5ECntHOmyCr/sh6D9vAjItC3N9EVWGerISjFPIAyqkbMh68hrEmiXMXkGZTXVd1A4KJEAikWLdBjoL9/KunW+TqXt3nzSskvFWhwqH7T+lQx2+tw0PoEqsD0vFz+d8QObNIBv69YbDXl+8w6By6zmkDDaKFof54zTCPNV43tUgRTLK7qTvr5eyiYYqv+K5OU3BrqlYfuJf+WXOBnxzL08Hc5WLS+HbrqcHQwz2oscn3sQnQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9w0dn0wWcC0/YTj27BtvWgggxKanE06WouJDUoh7i0=;
 b=vjYG8KWQdnrbO1kV4uJ6YgjboVt4MtoKdP/yEgrpSioI8Y4yiEzs8MfGeuefnwamAimcY3rf+sxxRCX8/VkbaET8YP2tbmVPrr7K58VzqwsUTBZBv71ZtKkEMe9OjeBegc/8ja2+k0FiCoKmEzooXv/1BN3pNI0E3PPJOiQlUJsXDcq6AlA7coUSGnRFeJbWr2ocycevSbP1xh53G82yC3QZ1/CKYvadRH675BqOccIsJeOb9SzGeYCw856HOAN97WmfW9H7GRia3gwb9LeZJbv0HFGwDRENxQijk8EdPtdKuVNkeibKYan+PH2bRXZuPm2/8KPPcU8UE668N52JRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Update
 debian-cve-checker image reference and runner tag
Thread-Topic: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Update
 debian-cve-checker image reference and runner tag
Thread-Index: AQHa7IXVRi2L1aXS3k+CF9tXnsWYjLIjR8yAgAAvByA=
Date: Mon, 12 Aug 2024 11:10:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6100A1ED70513BB7C76A8AEAC2852@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: <20240812070303.1206167-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240812070303.1206167-4-Sai.Sathujoda@toshiba-tsip.com>
 <4b675efb-9cb9-40b5-8b0d-adcf534578d3@siemens.com>
In-Reply-To: <4b675efb-9cb9-40b5-8b0d-adcf534578d3@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|TY3PR01MB10966:EE_
x-ms-office365-filtering-correlation-id: 576eedbb-cf3f-42e4-735e-08dcbabf6e40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T2FHZXlTdmFEdm1EZmpwMzlmMlBCbjJ5MFlzUG01d2dpVzNrZU1TOUtGYm1D?=
 =?utf-8?B?UWVrWWZtTUFqUjhEcThLVmtlUzRPcElBSWRzK2IzaEFoYjJibE9VdnBQaFI0?=
 =?utf-8?B?RDcwSUhkcGUzQnlXOVpJaUVpeVo0MThNMDd1dnVjU1RrSUlhWWF1cWp3N0hq?=
 =?utf-8?B?czBDVG1tTkE0ZHNob1QxbUREa2drWHRRREFPWksvMS80ZTIyMmhUemt1SzZG?=
 =?utf-8?B?MUFBbnNVVWlDRlFjVTRGRHB4ZFV4ME5TVVVMb2JzYmkzU3MvK0NRdmxOQ2NZ?=
 =?utf-8?B?QXJwblovYW5CTGgyUTZLbW5JNGcvVWhjcEJPNGlodVBXamF3SUl5TWtYMnYz?=
 =?utf-8?B?N0tXWWlHQTYzRDNWQXN6L3piRXp5M25GbUl3TEkxVUUzdS9nL1ZsR295Vno4?=
 =?utf-8?B?TmZnOEE4R3hjRXFiOFFLeDVIYXVYQXZ2M0JOVnU3VGtucVo3QytHWVFkR0Zr?=
 =?utf-8?B?WDdLRzNxbGYwMW8wYjlqTHVNTmpLN0d6a2RlcDlsUW53UDg5NHpBMGVrV2RZ?=
 =?utf-8?B?cDdUbHY1T2wyMUh4VzZzdkp2cWFnd0FGVU40em81UUZQdllkRVlEdk80Y2dX?=
 =?utf-8?B?SmROSU5UazZUU05VYTNWWWpkai9oWm1VMVpNaG82NjF0c1EyQUtLS0JIQjBP?=
 =?utf-8?B?aWpMN3MzNWpRWStuV3g0ekpDSjlMVER6QlA5NjJYSm4zVis4eUVXcWtLNS84?=
 =?utf-8?B?SUc5NEk0ck0rNkdmOGkxM0Y1VmtocDF1NjdCWGcxVzZoVXA4UlEzRmR4OGE4?=
 =?utf-8?B?OENOR3ExUS8rMlNLVitHd1lvRjl0RlJyUGhxVUNZbEYwc09zTlUxc2k5MkI3?=
 =?utf-8?B?RGk3ZnRsWVVlSUh0M2hsaFBXdEZKd21SVlNucXBuK1ZTeDdwSjB1OHowTUdU?=
 =?utf-8?B?TWFCZkMvWlQ5QTExRFN3MTN0TlNWZlkyK09jdTVYdzhzZUQ5UDIxemRBb2t2?=
 =?utf-8?B?Qi9SK0ZMU1I0VFN3S0t0VGFmcnFIQklLWVdpSHZ2a3VUZVlMNTBLbGpNZ0Np?=
 =?utf-8?B?RmV4L1RnOU8wSHBZZ09aWVpQUEVUZXRxSW1DR1Y5Q2o1azQxdkgxZmVsM204?=
 =?utf-8?B?L0lTUnVRU1AwNFRBbHJrUytzMFhESTlIVVhOckViWXp5d3BWS0tuVG9zWWNl?=
 =?utf-8?B?ZVJqMGJFUWtmYUhEZFpOa1grWnova0h3dXlQTm4wbGdhcjRmRWNYNnBFOTZC?=
 =?utf-8?B?WWZpbWdLREVYbHd2anhRWk9WaUVOTHUwSG1Cc1RxUW9QeG51VjhqdGY0NFkv?=
 =?utf-8?B?dE9oYmVWeG16cU5jaGxKeElVcDNsTngzRjFGTjlPWkczcERhL2FXdHdsMjFI?=
 =?utf-8?B?NUpxZVRTU3ZJWUZWNEl6dHEwUmpuRmR6REJBUkdYQVp4MDJmRGo1MjdZTVho?=
 =?utf-8?B?UmFjdWU4ZlZHdmN3SkN3bC83a3V3RWFwb2hlNlh6dlNnMmh1YUczbS9YaHRa?=
 =?utf-8?B?eWlpdkcyWUxqYmNoSnRucFIwQ1BscTBBK2VnYnprODU0VCtwbCsxK2RvRjFa?=
 =?utf-8?B?OTVLblJLZU55U3NKb3FBbEtESHhyWTlrWS9RZG1TMzJSQTRZQ0tKS3hFN2la?=
 =?utf-8?B?UEhwWk4rdlhwcE9ZMWVkUGZoTmNyTjk3d1lwS290MmtTUjg2KzkrbDY2S1Rn?=
 =?utf-8?B?bEtOWXE5bFlYS1FyRnhSMUJnU05YSktyNER0RWQ2U1JkVjF0elo0RFlVQ3cr?=
 =?utf-8?B?aFFpQ2RMOGNJb3VveHgrMkcxVHFHKzVlbFMyVTFReitkZTdFUFdUNllwS1dI?=
 =?utf-8?B?TWNpNW9kZ3R2MlZnVXI5cElUdlpNdDBKbGgyazdDNEpRVXFxL1lxWnBVZ2FH?=
 =?utf-8?Q?Ny30dcYkwn8KdVteIdOiZ74VjgpvGG1ZKsJvY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cXdKVi9WZHp3RUR6elB0V1ViMXlrckplSWZZZDA5N05tcFR0RGZseDQ5cHJG?=
 =?utf-8?B?K0pPVjkyWVpoZ2dDZ2gvK0JtNnlCT1dZSDdmTytiUXVzMjJ0SHViSWRHc1dz?=
 =?utf-8?B?RHdFM0lncHhDcnhaeTY5Skk5dDZ4OHNQbXNITEhKM09tMmR3a0g1c2NxNkVC?=
 =?utf-8?B?WnVLMnpHc1RlcW1OZjdrV1pxL3ZQdXVnc1R3MTJHZzZ4Q29RY3BwQWhmdzRl?=
 =?utf-8?B?TUsxV2hwQzhUb0NINkdoN2ltcW5sbHRtbmZGckErNVJwNzUxWWxCOXUxRU92?=
 =?utf-8?B?ZGpOM0hVZkRzd05XaVRGbEJmVll2NE44VWRwN0VXOTZRNnZhOFJsTmt2OUUw?=
 =?utf-8?B?bnRyeGRiK0NqelE3YnZIK3VqUE13SWZ0U2QzWnJteUZPaitIVUJOaDVkY1U1?=
 =?utf-8?B?b2hFZFJuVC9iNUROODdpTFdhdUxTQ1NienVPUEcvWTA0Z0NDSFFFMlg2QlRm?=
 =?utf-8?B?UTgxQ2FEMGF5YUVBaCtMQzlJcWE2SkkyZk9LUHNYUU5FYzhoV3FmdmVMSTZ4?=
 =?utf-8?B?NkZEbkRva0tRUWJ0RUk3VHVWa3B3MHZKdVNVNXRXTmpYSjJTK0hyYlpDRndn?=
 =?utf-8?B?Q2dwdUY5bGh5VERRQURKS2tJNS9CU3l3MWpaWmNycDBhVEFQY0Fuc2pHVkdJ?=
 =?utf-8?B?RTBxYmFlYlVaSFdOSCs5RFJXYWx5MnlLSWpmY3RvWDVsS21Bem9vOGJjK3dF?=
 =?utf-8?B?bzZhVTVYNzM0b0doQVY2M3F5bk1Gckk0TnBtenBGWVcyZDF0Z3BOa3pmQXVh?=
 =?utf-8?B?NEczMEs1Uk15VG0vRlFIK3B6c1FYeEVDRStmOWhrS1d0eWtua1BubUc3YXU4?=
 =?utf-8?B?cXJnbnJwejMvMVpjRWlWTU83NlkwN1FJY0RYWVJVNEl1Tm1VcXRXUFdtTHlv?=
 =?utf-8?B?NThpdi9hd0hBS2xNd3ByS1NGeDhQWDFHSFNzRHhCK0xQTlBqOTRXUEVSaTk1?=
 =?utf-8?B?d0lMVnA5ODJXS3lqNERib2pPMnBiWXZwY21RN2dRSHVNUTJxamk5NjgwTzYv?=
 =?utf-8?B?dEk0MElpaHk5RXhwWDJzR2xJbjhnaUZPYmdpTVBxV3FvdFBqM0xXWjZnV0kw?=
 =?utf-8?B?N1orU3pycU5vbVQ4clUyYTgxZVhoNVVyNjd4cnB2aVlJODhGTmRQU05EWEFk?=
 =?utf-8?B?YTNtWXM4aGlsRmVpcEx1eVJYQmx3RHNPNkpwbFZ6T0lzVSsyYnkzd2IrUFo3?=
 =?utf-8?B?WkhGT0ZGZHlyeDBZVm1qNjZ5QkJnM0dvb3k4djQyUWhIU2FvRlRvQjFaMkVh?=
 =?utf-8?B?cll6OHZKQVZ6Qng0SExWaU5nUko5RmhEQXd3bWlxanJHM2plOW9KcmJVZzhY?=
 =?utf-8?B?NWNjd1lKbkljU05qdlhjOFI0NHhXaGVqZUJWelBzOUJNRldzVW9zVzNJYnA0?=
 =?utf-8?B?UHUwSzc4SXg1b2VqaysvOGFMaXV1MnR6VlBJUDBJVUlCSlc3NFB6ZDJGNDUy?=
 =?utf-8?B?S3BiR2RjQjg5aFlZdDJRSkpGams4cSt1SnFhQmk5RGcxcWlDQlJZWDNVYXNT?=
 =?utf-8?B?anlMMldiQ1h0MWZjT1dNWFJWMnBvR01YK2FyWW4xOWZSRDFYUUFxcXJaMEJP?=
 =?utf-8?B?SmlCY0VFSzVPdE1OS2w4Q05zRkRNQlA5M2NaaTE3OHQzWGZWajZybGgvUG5v?=
 =?utf-8?B?QzZBajBpSmdQQWxmZy8yTlpBdlFlM3VmaTBRaTA3dDJYUWhmY09NVTl2b2Jw?=
 =?utf-8?B?V3VYaFBRTlJOTlhZbDRnUnowWWo3Y3FZcDdLN0E5eEVZcHphb2FEbUwrWTZa?=
 =?utf-8?B?MTFtVHFGS0x4K2d2a0ZVZFI1UWdUdWt6R05zYjZMQkZhU0ZWdDRWTUo0VXpt?=
 =?utf-8?B?TFl1SnRJY01aVS9XcWJPaXl1WDlCMUM4YmxNaWhkQ2ZvcWlVbmEvVlhoZGFz?=
 =?utf-8?B?bnBPWnN4V2x3Y2VFdWw3WWpiZ2JIcVh5SS9VZmVwWlJVN1FFK004Sk5jbTZJ?=
 =?utf-8?B?MVBvT2VHamllNmY2TmkzcHN3NHBrTkI0OHlyL01QVE5zUjFkRlV0RFZ0eGNB?=
 =?utf-8?B?cjFKZWU4OXNpNlhCY1NxR3lucmlGbWhOR3puYll2SzUwRVk5bm1hREFCdEli?=
 =?utf-8?B?U0ErT2xpRWdZRWRRNGNSM3hzVm1mdEw2dTRrWkVTWFFSdUlOR1FKWjR3eXBB?=
 =?utf-8?B?WW5leEUraHM5WGtkd2xxYTFaOURCamJyN1JMNkhJVXNMbUpLVXhWYmQ5VTBR?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576eedbb-cf3f-42e4-735e-08dcbabf6e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 11:10:53.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODFex1/8TyXm2Fs0UIgx8l+6PCGvnnMqrUZIkVN1qZjVZbN1lEk1gSfWKfWNgrrgZDXRtPY9UgDFHr0leWfEFqqublVJeKwQNcIBg2R77Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10966
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:11:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16775

SGkgSmFuLA0KDQpUaGVyZSBtaWdodCBoYXZlIGJlZW4gYW4gaXNzdWUgd2l0aCB0aGUgcnVubmVy
cyBvbiB0aGUgZGF5IEkgdHJpZWQgdG8gdmVyaWZ5IHdpdGggc21hbGwgcnVubmVycy4gTm93IEkg
dHJpZWQgd2l0aCAnc21hbGwnIHJ1bm5lcnMgYWdhaW4sIHJlcG9ydCBnZW5lcmF0aW9uIGlzIHN1
Y2Nlc3NmdWwuIExldCBtZSBkcm9wIHRoaXMgY2hhbmdlIGFuZCBzZW5kIHYyIHNlcmllcy4NCg0K
VGhhbmtzIGFuZCByZWdhcmRzLA0KU2FpIEFzaHJpdGggU2F0aHVqb2RhIChUIFMgSSBQKQ0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4g
S2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IE1vbmRheSwgQXVndXN0IDEy
LCAyMDI0IDE6NTAgUE0NClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWkuU2F0aHVq
b2RhQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6
IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3Vt
YXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3v
vKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFz
aGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUg
My8zXSAuZ2l0bGFiLWNpLnltbDogVXBkYXRlIGRlYmlhbi1jdmUtY2hlY2tlciBpbWFnZSByZWZl
cmVuY2UgYW5kIHJ1bm5lciB0YWcNCg0KT24gMTIuMDguMjQgMDk6MDMsIFNhaS5TYXRodWpvZGFA
dG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gRnJvbTogc2FpIGFzaHJpdGggc2F0aHVqb2RhIDxz
YWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+IA0KPiBUaGlzIGNvbW1pdCB1cGRhdGVz
IGltYWdlIHJlZmVyZW5jZSBvZiBkZWJpYW4tY3ZlLWNoZWNrZXIgcHJvamVjdC4NCj4gDQo+IFRo
ZSByZWFzb24gdG8gY2hhbmdlIHRoZSBydW5uZXIgdGFnIHRvIGxhcmdlIGlzIGJlY2F1c2UgY3Zl
LWNoZWNrcyBqb2IgDQo+IGlzIGJlaW5nIHN0dWNrIGluIHRoZSBtaWRkbGUgYWZ0ZXIgZ2VuZXJh
dGluZyBjdmUtcmVwb3J0cyBmb3IgZHBrZyANCj4gc3RhdHVzIGZpbGVzIG9mIHZlcnkgZmV3IHRh
cmdldHMuIFRoaXMgYmVoYXZpb3IgaXMgb2JzZXJ2ZWQgaW4gc2V2ZXJhbCBhdHRlbXB0cy4NCj4g
QWZ0ZXIgY2hhbmdpbmcgdGggdGFnIHRvIGxhcmdlLCB0aGUgam9iIHJhbiBzdWNjZXNzZnVsbHkg
aW4gbWluaW1hbCANCj4gdGltZS4NCg0KQnV0IHRoYXQgaXMgbm90IHlldCBhbiBleHBsYW5hdGlv
biwganVzdCBhIG1pdGlnYXRpb24uIENvbmNlcHR1YWxseSwgd2UgZG9uJ3QgbmVlZCBhIGxvdCBv
ZiBDSSBwb3dlciB0byBydW4gdGhpcyBqb2IsIGRvIHdlPw0KDQpKYW4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogc2FpIGFzaHJpdGggc2F0aHVqb2RhIDxzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNp
cC5jb20+DQo+IC0tLQ0KPiAgLmdpdGxhYi1jaS55bWwgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
LmdpdGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbCBpbmRleCBhYjE4MzVhLi42YzkyOTI3IA0K
PiAxMDA2NDQNCj4gLS0tIGEvLmdpdGxhYi1jaS55bWwNCj4gKysrIGIvLmdpdGxhYi1jaS55bWwN
Cj4gQEAgLTQ1Niw5ICs0NTYsOSBAQCB0ZXN0OnFlbXUtYXJtLUlFQzoNCj4gIGN2ZS1jaGVja3M6
DQo+ICAgIHN0YWdlOiBjdmUtY2hlY2sNCj4gICAgbmVlZHM6IFtdDQo+IC0gIGltYWdlOiByZWdp
c3RyeS5naXRsYWIuY29tL2NpcC1wbGF5Z3JvdW5kL2RlYmlhbi1jdmUtY2hlY2tlcjpsYXRlc3QN
Cj4gKyAgaW1hZ2U6IA0KPiArIHJlZ2lzdHJ5LmdpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNv
cmUvZGViaWFuLWN2ZS1jaGVja2VyOmJ1aWxkLWxhDQo+ICsgdGVzdA0KPiAgICB0YWdzOg0KPiAt
ICAgIC0gc21hbGwNCj4gKyAgICAtIGxhcmdlDQo+ICAgIHNjcmlwdDoNCj4gICAgICAtIHNjcmlw
dHMvcnVuLWN2ZS1jaGVja3Muc2gNCj4gICAgd2hlbjogbWFudWFsDQoNCi0tDQpTaWVtZW5zIEFH
LCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg==


