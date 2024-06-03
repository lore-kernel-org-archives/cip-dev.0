Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF5CC25B76
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:30:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.79098.1717406969069561213
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4539TRNa2668586; Mon, 3 Jun 2024 18:29:27 +0900
X-Iguazu-Qid: 2yAbXhlxOl7nVuu8gK
X-Iguazu-QSIG: v=2; s=0; t=1717406967; q=2yAbXhlxOl7nVuu8gK; m=X0UUz2626wQ1oqT5WQRqZzwBVarGaTWVfHxsn+XpGTI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4539TQrN945755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jun 2024 18:29:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTzQmCOQQEMPs4WCjssIMwdFnA6t+h0/4nM3QfjEQQsd5OQcDibBSV23HdI4CHrLRJxNjbC4b4oJqqz0P5YBhTj/kUJk7YBmhTH7TEI1PGrCOMuaiYvQ0B1nWE3SIgvQKE4ToIr/WRADLLM79kI329EqyBECvpCy6oYppNOF/qWk8BUIaxbKvjgqR75rJxWD6Q70xfuyFwpe+vtyZF9sV5THCuHNi8IZhOcGeWGSQW2Mkh3AQLvxpzVV5M3ChGy3qE79z5NRq998JqaTtCQanoPMSJzciJK7tNfjbI9bvDv6szqi/Q9rdv5q67XCFkk2Pa1s/6FweEnJVTaCBA0F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpdltQSQpCokPTPxackmox1Oc7cKxdC2ErtGOiseSok=;
 b=j4js+XlY0WSeVHbM3gGePx9sBD7YNVmhNA7fGQp6pQ3Ri9QvNm7FUv4USYN1DL73TLJXraFQzfB4qFn/YkyVC5SPnLt5C+GajZtKiBsR82mhtYzKF1fTOh6FTDHjU50eK5xEGUp32kYmFkRgZcjha8DoYLRNlZOdfACDZz+dijGy3EvuDlskXJMYFPA45mggxfCq7Mt51cpwYdk4HRBrluHHdb7WEn3lNM8k3NGvILV3NZ/t69BKM1v3S/1pUxskt4hhz9YOzVeZZRxMl+xAcMbOgArtnj6ldl89e80wO8kZ74jPEZwRPudDZmWttoXPjYv2iGwb5kGt7ZoC23vSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets specific for
 CIP core functionalities
Thread-Topic: [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets specific
 for CIP core functionalities
Thread-Index: AQHatYT3zvzSaB/7DkyVmZfNM6jWa7G1wUKAgAADQxA=
Date: Mon, 3 Jun 2024 09:29:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61033D64BE71226DE976A422C2FF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
 <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
In-Reply-To: <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB11656:EE_
x-ms-office365-filtering-correlation-id: 6fb75d74-f703-48a2-8e05-08dc83afa813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VG1ha1VGYWgzTjl3SXVROFBpYjhFQWVLMTBkeWVMOW14M2ExUHlRS2RqV3Jv?=
 =?utf-8?B?cUdCaHYwWFJUQVVHL0RyejNoNFdHYUZuM3FPYlVHSXptNStkakFnbnZMVmFD?=
 =?utf-8?B?a09NQzY1QjdiUmhIQ3UzWXVpZmI0TWVkaE85MllVY2dEMitERmZtVjY2MTc4?=
 =?utf-8?B?YWxOTlFRQkswa3JlaXFXcjdXZVJaemdxNmJOZnhuaTFPUEY5VFhWcnlBZ00y?=
 =?utf-8?B?enFUdHJxSGt6ck1PSlFNVG1VUjRoNUsxenpmNkl1alVYTGFNdlNvTDlmV2Ju?=
 =?utf-8?B?SE1vV1AyK1VxRFJoOEs1WUZwc043R04wUjYvaVhXTms2VkhiSEY3VGl4UC93?=
 =?utf-8?B?RkZWdEd3NHY5L1RxZElOTzZ0NFU4MHViU2lVekdlYzlmUG42MTV5MVl1L2ZB?=
 =?utf-8?B?a3dnNFVZS0lvWEUvdzlBVG4wUmJyLzBsTTZRNDFyTHA3VFdXY3ZXU2JZTXk0?=
 =?utf-8?B?TW9hSko0cUdLYUsrQTVsVU13blU2Q2FNdUIybFVUNlp3c0hzWmVqRVZ5b2JV?=
 =?utf-8?B?dVBKM0ZQNi85a3N5bWIxWW1seHVjSFhqbzl2aDVwQmNJakdsMjBIWEhIN09y?=
 =?utf-8?B?RnJDOVc1dnlQcGhTemxkQU5pWThvaXNJVWZNZ1RCenNXL3RyU2lSS1ZGS1pN?=
 =?utf-8?B?Q3FGZTdsNnFrNjVFT3Eza1k0QVRpZXZERER2cnFySUJqL1IzM2lVcTBJZTFz?=
 =?utf-8?B?dVJ4MWUzYnBzeXMwenZMbXBRcTFYT3UzTDk4dFNPc3RzZFJPV212QlRqbWNa?=
 =?utf-8?B?Q2lBSko1UEhPdEdRazg0em51TGEvS01xdXhmNUNqT0RQdUs3RGVSQ29rREZH?=
 =?utf-8?B?YmE3bmJmT1RhTXRpa3lFdlFaVG5xdTgwMitKa0ZwVzRMcnpITVVNcGZzTWhv?=
 =?utf-8?B?RTFOSnpMeDRmZlpGNTFraTlZNmhranVhOFMyZUlLWkFTS0tPNklEb2poazdB?=
 =?utf-8?B?NTdOQmZZUWxNNDZIWWN5WkpvS3JEb2g5QmhPenM5NzZVMXBYb1R3RUkzdnVq?=
 =?utf-8?B?MnBacWw0YzVteHFLZUkzMmpnN0FHVEhIOHRCZG13dHJickVKenY1dlU3eENV?=
 =?utf-8?B?d29ybzhMSjYwTkFnNUUyL3c0MG9yTnRMMVp5WjN1c0R1a09QVEIrUC9FRlhI?=
 =?utf-8?B?SXIyUFRjUWxmSmt1UEJ5MkdtZXJzZlo1SS9oWDN0MHM4NGUxNkJQMExteVo4?=
 =?utf-8?B?UWxuTC9OUVVHVU51a1FWMzU0V2RMVHpXcVZWRHBSNGtoZ1FLdXp4SnJXbnFx?=
 =?utf-8?B?bFRiU3l5bUxzU3d0Wm91dnZxeS9Va2ZPSGVPK3I5dDRnYWNCZkJWcGIyaHFq?=
 =?utf-8?B?VWtpZFhiZXFrdFlIb005eUl0TmhDeGNwcFhlT01RTGJWSGxmeUhMcmJMblhD?=
 =?utf-8?B?ZUNsOVJPK284elVMZG8za3RYZHREZWhUMlVXbWgweXliS0N3bSsyWW15MnQ1?=
 =?utf-8?B?Y1BtZFk5UHZXOW1kU0VpOXVFSGx3dDB6RmdlS3pqR011RlU0T3FmeVQyV3Fm?=
 =?utf-8?B?UGt3SnpUcEhQZjdvbVBJNVdUQ1hHSjJqSjdQVURBV3FicFpEMjJRK1FUQzNI?=
 =?utf-8?B?U0JjK29EQVMwNGM1NUlBL0hWMWIrbk9pNzRiMFE3VEwvSVIydWgvMEZnUWR3?=
 =?utf-8?B?Z3JnYzZIaGl3OC9oMEg5Mi9LelorL2llbndSSDhTR1d0cWVQbzIwQ2FIYWZF?=
 =?utf-8?B?VXlhTVJWeS9zMHd2NlNxS1JhbW1YeDRscDlUVGttTXFyOE5Jbkt3ZjdZcERn?=
 =?utf-8?Q?o1tZ/jx6MqAYNKRks+n92Q9c3cIh3nWpG3U17Cg?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MmNVNTMxcDRLTGVoZlphcnZvcVFKVytieVRrZGJmWGpGdUtmRkZBc2ZUU0Ir?=
 =?utf-8?B?NU8ybnFYaDRmWHBuM2RvT0VoaVU1SDZwaWRPOU9VajN2NEg3TDFIdFg2aXdq?=
 =?utf-8?B?S2JBQWxHL1U4Uno4VzBKUFBHbDJNUmNEZFVnVWRxYXg2R1RQK1JONXQvQm5I?=
 =?utf-8?B?Sk5saXFXNm42R3hTUmcxU0czdUlyTjlSU01XU2VHaVU5K1BYcms2RXVzdTkv?=
 =?utf-8?B?WUJrS2txY2xCSXFmWGtOOWxwODZSSXpYMVpHQkdMdDJBTUJSYTRSTkVqUzVr?=
 =?utf-8?B?RU9ZVzdQSWN0aGpsYno4b2c3WUpxd0VtNjNPYnBTNzJQR2lwNEF5RWF0SGJj?=
 =?utf-8?B?NUM1ZjYvYTdPQ3VFaGxKRmR3ekk1c1IwNmVIdHU3djFRM1JNc1duWEM1VVR1?=
 =?utf-8?B?TXJyeGRpWWxoeVhrQ1UvTDNhWE9mOWRGWGNHMVk2THhPd1dJTTg1R0NLbG5z?=
 =?utf-8?B?dU5mbmRrdzlxMUwySU5CLzJ1amwxZWxFRWxtYWxtdkZDNjE0UXBiWVhRajA5?=
 =?utf-8?B?ZVFwUWp1WUhLQm5GTGllS2ZvR0lMbVQ3VVVBdUN4dEdkSlZ1TmpsUnE3WEts?=
 =?utf-8?B?S0ZXVCt3Mm03RVBOWGZYMDdZZ0krSWpadkRObXJ1cDZjMlJwbDY4NGZuK0E5?=
 =?utf-8?B?QjhoVE41Tlk4SXk2UGNOYWkzSGRIM05nTzZ1NXBKVFA3RFJpc2g2bGN4bmZj?=
 =?utf-8?B?NDRsQW80N0oxTlhVVEljSWhhZEJsTFdZbXpZelpKTi9SNnNsWTREa3h3ZWk2?=
 =?utf-8?B?VXlrUWFmWVpUZWVVMmNlSzFyRnMxVE40bUMvaFFibTN0OUFvM1hqQjhPbHE3?=
 =?utf-8?B?NlN2WW9ZUEQwTzIrdCs3akFLVU9CZU9Fc2ttY3dBVFpPWlgvcnJYY0xHY3ZK?=
 =?utf-8?B?Rkw4N3ByVjF3cVBLbmlaanRSUXU2U1h6U3NRVHBuYTdxUWRpMnc1T2NLOXdr?=
 =?utf-8?B?d25qOW9rdHFydU5GeHBOZ0wvNUtiejRocmJKSEJrd0RnamVsczFNVUlIL0VT?=
 =?utf-8?B?YUZaK081bnNVQmFuOGNESUF1bloyVm1RaU9jcys3Ry9NRHNmeWhGZWpRckgr?=
 =?utf-8?B?aWRiZktZM1llOUE4NUhMK05hMncxRXlHUjIwZ3ZTNUVIT29PTWFJMFJsTWlj?=
 =?utf-8?B?N3cybU9Oa2s3RjBpWUZHdCtzSnIxM2lqY2JqS2xEZlBobEFCTWMxMmhjTTZC?=
 =?utf-8?B?MEZqNzlNSm9LNVFoUlFabGlTRnlMVk5SZ1VjWkRodFZOWUYxTDEwUEtUbUlu?=
 =?utf-8?B?elhiMFdwUUNEYlJjcnNjM0FzcnRJeFlyKzhsenpEa2IvMXVodisrL3FNM1pC?=
 =?utf-8?B?TmNvNkZHRzRzamI1VmI3Y3VzVmJnQTJYR1JIaFpwVS9hVzV1Y1BDekZHRXZo?=
 =?utf-8?B?Rnh5RnU0RUdTaW9kZHFFM0cxZXc0MnF5M1d2aXpVYXg3N2FQRmhKUlBUdHhz?=
 =?utf-8?B?amQzNTRPUWtqRlNNZXRNbHV1Q1M4aU9nazRtRnRoM2RTNVlwWU1tMFFCbVQ3?=
 =?utf-8?B?YyttRlZ4VDNKUG5WemZWekRvSjJuYXhFNG9VRmFaQUVkd0JyMkM1VHlhU3dH?=
 =?utf-8?B?Y09LeG15QUJjZXRYOGRjUHowcUtndVFlZDh4VmphS0paeHh4THdtck1QdTFB?=
 =?utf-8?B?OFlHU0Mzd1krVGFnZVpKOE9scGMrOFJ2Z2tqUTZaVjNHMkNaOW1UQjBrcUEw?=
 =?utf-8?B?WnFlYml5NmRINDVGQ3BmSzBkV1g3MzlXSDNzVjNCUkpBcGtQSTNsZjNTcmZ6?=
 =?utf-8?B?Sk1Oc2JSNWoyODRycDYxajBnWWhEdi9ZWnIwT09aNCtObnk0ZStMRGQ0Mysr?=
 =?utf-8?B?VldNMHBUVlRCRDY2L1lnVVY0WStyc21TOVV6UnJ3dE9lLzJhUzkvOFlKUHRJ?=
 =?utf-8?B?RFdmcU4vNVh1dUZtUjNDMmtlSjVlZk5vTmxZNEdPYlcvWEdkMEh5bDlrSSth?=
 =?utf-8?B?dVNsdmw0dFpNNUhiUnRqQkUrSUJUOGRPa3FvOVBOUy9KVm96ZHB6eFIzQjIv?=
 =?utf-8?B?N3Y4NmNEYlVOK3NrWHNBRkdnUWhmOTNydDdPSjUvUVc5dG9sc0c2eVpUNVo3?=
 =?utf-8?B?TGFCMlZpMTZ5aGZYNlplbEJtcDFGTXNSTXVQVTJPbFVRQ2gySjdtNHJXcjFy?=
 =?utf-8?B?NXhxQ3RHTXQyWlJOMUdzVWZCL202UTRSOHVad3RZUHM2NnhHYzl4cEpOOGFq?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb75d74-f703-48a2-8e05-08dc83afa813
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:29:24.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7zSiDU50/477HzIpS7MXaceKE0cNwUQEZszKrqZknhXrHqv6lKvwVi1RjYJCSP6/9hHe9bm8qSMs2t/YZAVwLocxRF0ltese2t/XutbZ30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11656
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:30:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16091

SGkgSmFuLA0KDQpJIGFkZGVkICJhbGxvd19mYWlsdXJlOiB0cnVlIiBiZWNhdXNlIEkgZmVsdCBl
dmVyeSBjaGFuZ2Ugd2hpY2ggdHJpZ2dlcnMgYSBwaXBlbGluZSBtaWdodCBub3cgYmUgcmVsYXRl
ZCB0byB0aGUgZnVuY3Rpb25hbGl0aWVzIHdlIGFyZSB0ZXN0aW5nIHdpdGggdGhlc2UgTEFWQSBq
b2JzLiBTbywgSSB0aG91Z2h0IGl0IGlzIG5vdCBnb29kIHRvIGZhaWwgdGhlIGVudGlyZSBwaXBl
bGluZSBqdXN0IGJlY2F1c2Ugb25lIG9mIHRoZXNlIHRlc3Qgam9icyBmYWlsLiBTbywgSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8gZ2l2ZSBpdCBhcyBhIHdhcm5pbmcgaW5zdGVhZCBvZiBsZXR0aW5n
IHRoZSBwaXBlbGluZSBmYWlsLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCBT
YXRodWpvZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2Eg
PGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogTW9uZGF5LCBKdW5lIDMsIDIwMjQgMjo0
MiBQTQ0KVG86IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGli
YS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1
bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJh
LXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTv
vKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJh
LmNvLmpwPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlIDMvM10gLmdpdGxhYi1jaS55bWw6
IEFkZCB0ZXN0IHRhcmdldHMgc3BlY2lmaWMgZm9yIENJUCBjb3JlIGZ1bmN0aW9uYWxpdGllcw0K
DQpPbiAwMy4wNi4yNCAwOTowOSwgU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tIHdyb3Rl
Og0KPiBGcm9tOiBzYWkgYXNocml0aCBzYXRodWpvZGEgPHNhaS5zYXRodWpvZGFAdG9zaGliYS10
c2lwLmNvbT4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHNhaSBhc2hyaXRoIHNhdGh1am9kYSA8c2Fp
LnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gIC5naXRsYWItY2kueW1sIHwg
MzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdp
dGxhYi1jaS55bWwgaW5kZXggYWFiNTViZS4uMGEyMmEzZiANCj4gMTAwNjQ0DQo+IC0tLSBhLy5n
aXRsYWItY2kueW1sDQo+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+IEBAIC0zNTgsNiArMzU4LDM5
IEBAIGJ1aWxkOnFlbXUtcmlzY3Y2NDoNCj4gICAgICBkZXBsb3k6IGRpc2FibGUNCj4gICAgYWxs
b3dfZmFpbHVyZTogdHJ1ZQ0KPiAgDQo+ICsudGVzdC1jaXAtY29yZToNCj4gKyAgc3RhZ2U6IHRl
c3QNCj4gKyAgbmVlZHM6IA0KPiArWyJidWlsZDpxZW11LWFtZDY0LWJhc2UiLCJidWlsZDpxZW11
LWFybTY0LWJhc2UiLCJidWlsZDpxZW11LWFybS1iYXNlDQo+ICsiXQ0KPiArICB0YWdzOg0KPiAr
ICAgIC0gbGFyZ2UNCg0KQ29uY2VwdHVhbGx5LCB3ZSBzaG91bGQgbm90IG5lZWQgbGFyZ2UgcnVu
bmVycyBmb3IgdGhlc2Ugam9icy4gRG8gd2UgbmVlZCB0aGF0IGZvciBvdGhlciByZWFzb25zLg0K
DQo+ICsgIGFsbG93X2ZhaWx1cmU6IHRydWUNCg0KV2h5Pw0KDQo+ICsgIGFydGlmYWN0czoNCj4g
KyAgICBuYW1lOiAiJENJX0pPQl9OQU1FIg0KPiArICAgIHdoZW46IGFsd2F5cw0KPiArICAgIGV4
cGlyZV9pbjogMSBkYXkNCj4gKyAgICBwYXRoczoNCj4gKyAgICAgIC0gcmVzdWx0cw0KPiArICAg
IHJlcG9ydHM6DQo+ICsgICAgICBqdW5pdDogcmVzdWx0cy9yZXN1bHRzKi54bWwNCj4gKw0KPiAr
dGVzdC1xZW11LXNlY3VyZS1ib290Og0KPiArICBleHRlbmRzOg0KPiArICAgIC0gLnRlc3QtY2lw
LWNvcmUNCj4gKyAgc2NyaXB0Og0KPiArICAgIC0gc2NyaXB0cy9zdWJtaXRfbGF2YS5zaCBzZWN1
cmUtYm9vdCAke0NJX0NPTU1JVF9TSEF9ICR7cmVsZWFzZX0NCj4gKw0KPiArdGVzdC1xZW11LXN3
dXBkYXRlOg0KPiArICBleHRlbmRzOg0KPiArICAgIC0gLnRlc3QtY2lwLWNvcmUNCj4gKyAgc2Ny
aXB0Og0KPiArICAgIC0gc2NyaXB0cy9zdWJtaXRfbGF2YS5zaCBzd3VwZGF0ZSAke0NJX0NPTU1J
VF9TSEF9ICR7cmVsZWFzZX0NCj4gKw0KPiArdGVzdC1xZW11LUlFQzoNCj4gKyAgZXh0ZW5kczoN
Cj4gKyAgIC0gLnRlc3QtY2lwLWNvcmUNCj4gKyAgc2NyaXB0Og0KPiArICAgIC0gc2NyaXB0cy9z
dWJtaXRfbGF2YS5zaCBJRUMgJHtDSV9DT01NSVRfU0hBfSAke3JlbGVhc2V9DQo+ICsNCj4gIGN2
ZS1jaGVja3M6DQo+ICAgIHN0YWdlOiBjdmUtY2hlY2sNCj4gICAgbmVlZHM6IFtdDQoNCkphbg0K
DQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


