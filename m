Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA9C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 08:22:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.18626.1751444529803041955
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 01:22:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5628M6QH3908589; Wed, 2 Jul 2025 17:22:07 +0900
X-Iguazu-Qid: 2rWhMjEQMDI1x88l4j
X-Iguazu-QSIG: v=2; s=0; t=1751444526; q=2rWhMjEQMDI1x88l4j; m=ZQydSjJ2WlF6KBn5MQCE2vytzYU3kwmFhCoCOlSmRrE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5628M43J2717615
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 17:22:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/QCIw4EmOtiw6KoFEvL4PijQUsB9gn0s9A6IuMdnkSb6rvv9koaq7VePKmekhqBICmob7V5YvgsyQKw+YEO4HdliQqP8OUJHcCckwGuukM/kQlpQQEbDFBNYjegDJ77ECd/3TIcyjxPg6K31yYVBcdjFpMJGwq93ufDYkkgIN8e8hgH/LrX9g4fSZcNFaBHyAv0PyHZvoQ86oQr4J7F1TW7425aBgDIUj/ZvMsInKgzf5AGiMXV1W6uhXjkBmxmTQFT0hwgCgSWJrho1lQiWXTnPzmSUgs1qaQLEk7uACpn+ye1zc8yqfH5xJyIC/ajuiar7/71qT7KF7LwLdCZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHsPhVnKHFQJQr1hLZSvQL8psq/T+xwXk6GNgmgUtaI=;
 b=vSlM9T3SzMYLwerz3Brt2Vlifyt7ioShyx5ZRbxRBDdjC/O/3UbvxZK9pSRpz98vebTS1bZE90dt1XAp/Io6tMkquayMRdLIiO+okaZAvpPevNMWSCzkX6GQNUUp9vROWBBw+085UUQoz7mDrxlW3hSjA214Q2PZ6ItBwHHo7Vc/SviavsY0UULQa2El2K67WP+8uQwDeLkP1PGYx+vNfb8+ZoVzWkMmzhZBPNHwjt9QFKG1s4E0CZxLAD+LLBR6lE8pi4z2C2bXdx/6E3lTHmr6Myy2mcvEdNxTbJKcu/6uo8+XQmWBME9jf3JqaRWnd1xsG/uRdh6z/pGXLem/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Topic: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Index: AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldA=
Date: Wed, 2 Jul 2025 08:22:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
In-Reply-To: <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYWPR01MB8541:EE_
x-ms-office365-filtering-correlation-id: a3589fde-a34b-4b4d-0a71-08ddb94185aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UGErR1FibGdHbWVsbUxZYXg0eHMxYm1WWG5LUkhTcktiR0xNcVpJbHQ1RVBl?=
 =?utf-8?B?ODNMRTVkRzBCdlhjRlVaUEdBcXFGNXBSVXRQaWpxQjRXN0E3aXlHdnY4eU5O?=
 =?utf-8?B?dUdnempBZ2VVU0N5bFpDWldlS2NzRE9Rc2hYSFltL1ZBMzVxdTJKNzRlaWgy?=
 =?utf-8?B?NEk2cDdXOUU5cUpMUm9IMTZGUVh2YThLVmtGVi9zNG5pMzNNczFEeUdDTnBG?=
 =?utf-8?B?b0RTMGZ2OHE2bWt1VlVhZzVDNys2QUI4bjlDc0MyVlgrZENaVU5MaUlzcWFO?=
 =?utf-8?B?bjBiZEdFMnZJSkhRMDZDUzJpYmpOMUJsSEoweXVnYXluWWlDY21KVUdtaVlz?=
 =?utf-8?B?MmZrNU5KWGZENFdqZVdNRERhdEZIMGtvcWg0d1luTW0xTi9hZWhMV25qeHFT?=
 =?utf-8?B?dVZ5d25QQXdGSVJDbHFNbjBDWVBWTWMrdytBZ3kzRFYvVDV4eTJyV2hmOC8w?=
 =?utf-8?B?aHYwdVo4VG9hWE1zanRIUmxIRFE4b3JCYnZBS2dHaXh1UW41U0tKK0g1aDUz?=
 =?utf-8?B?alg3UDBWR21hOE4xaVpNU09yWktBcnpFa0pmc3Azd3k2VmxVMFpkWWh2cXdM?=
 =?utf-8?B?Nk82bmtwWkpxUGZPWU1ZOWZhai9OR0V6SEQzdnZpTzdHVnFZeHhmSzdwSTVC?=
 =?utf-8?B?Y002cm1tY3FlWEMwemFYejJjcFNhclpka1I0ZWpMclhZNzBIMi9MMkdDWHZW?=
 =?utf-8?B?aitkSFE1eUJJZ092WU90MGdnNE9MVEVuWjVCcGl5d0F4WnpGWVVFUmlNSDF5?=
 =?utf-8?B?RHJUM2RuQkRkNzJDUk1sNVdVT0NBTXFuRG02RWVTREQySW5PWHhtcXZCbUU4?=
 =?utf-8?B?anI5MnEweGdwN0RLczN4R0FnRFVTcFdGSHdTbkJLVEhTZnZyYWN0UjFaUFIy?=
 =?utf-8?B?eXJhLzFzenBPbUtES2Z0NTdEQXI5SWhlczRqd0tTaHVMa3VzODkvMFFUTCto?=
 =?utf-8?B?anFvL3lqWURXVXRTWkhXZ0tNVXA3SGFJQlZDclhzakJaVDlHRkZSRmI3ZUNv?=
 =?utf-8?B?REJEZ2JQZllob3pRdFhxcVBGT2ZRY2FTSCtuQkhDVjJkeXNtWitDNTM1YTZZ?=
 =?utf-8?B?M25tUjI1a2FMRjlRV3ZkTGxhSTZ4dWNCM012V1MrL0lnb3NQeFBQYXMzS2pB?=
 =?utf-8?B?dkVQRWJkby81T1FIT1ZmRGpQeTU3MTJwMjJMSDNKTDZrT3lZZk9pTVlXSXBD?=
 =?utf-8?B?czZ2SEdiUnAydFpDQk95MEt3eUxCeUJ0czNaVC93YnRhdHEyNHBIUUZTMXJS?=
 =?utf-8?B?UitsQ1FUcG9SM01PSVpXaW02WXJ2RVhFVnh3WjBLSkFzU3YzYzJiSWpzSVNL?=
 =?utf-8?B?NVZkT1dsUFhMNVhjZWZKMy9qTUtDQnB1ZG1qLzNiajhSZ3RIZFI2amNGck5y?=
 =?utf-8?B?dTFZVEpYcWEyVmRCOHB4NWN1YnNQU3RSRGRGRDkxblV0V3J0MFlacWdXckxR?=
 =?utf-8?B?cGV2Qk1nWW1BRnRxdDJaVmtHemIrNFdydmlTemxuOGwxckpQaEU4d3AvajZG?=
 =?utf-8?B?UTVzZXdGMjZDK3g0K1hwY1VxUXF6Yk9rRkgvRjIzaThPOTBoYjRDcERTVUNB?=
 =?utf-8?B?MlZBVUlyd29IUHMrZHVLVW52UGhwTFB3UENoV1ZhMWJCQUlVR2VobU5PeHBm?=
 =?utf-8?B?NjVSbEY3ZVhGZUZRejg0Vm5ZRUJGb25DeXFReG95M3AvcG8raUxUak51RTlQ?=
 =?utf-8?B?OXQyR21iVnNxRjB4VmgzTGJmaE50cTdBL1VpUEwrTWhaQzBJbEQwSFFSSWNq?=
 =?utf-8?B?Z1NvRVRUbFQ3NW5Xa0MxZFdoUHdFMGordVpHRktiNjFXY0Frb0cwbW95bWc0?=
 =?utf-8?B?eFJOWlIwWUY2c2h0bTJjejBka3pnMDdpbDZ4RUZQYVhSOVJ3L1AzSWI3bHQ1?=
 =?utf-8?B?VW1aVkJTR01xaUxMNDBoNkQvT0d3a0ZHSkhia0tSRXJmbFp3dDBIYU1ObzRy?=
 =?utf-8?Q?pmpQi99bqR4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?blFsb2ZaWmRHWS9WRDZab1RETG4rQXdBc1Z6V0pTOHM5VFoxZTRiaE1FM2dp?=
 =?utf-8?B?cjE1UmFpUS85ZFRhb29QUzluYjQza0hzaDNMRVZPN0JhcWNGMUFGUjNidlFl?=
 =?utf-8?B?WnFZWDVHTFhHR3lYamt1Z1BUYnBaWGl4YmVYZXdJc2YvNCtuTVZJR2RxVk1N?=
 =?utf-8?B?V2xPeVltakNHdy9jYUlRSFY0enI5djM4R04yTTkzRHR5YTdYYmhwV1ZsRjBi?=
 =?utf-8?B?YUVNckVlMzF3OTVHZndQSXRLQzlndWdZd0tRMDRUYll6eFg3alZiRTJZWnlC?=
 =?utf-8?B?em9ERFFyUzhVYjZtWksyMktqcFdYd2RkQnpmeWMzdFVud3l1cDZ3M3d2RGpk?=
 =?utf-8?B?Rkd6THh5OWVTTTBXc3p2K0E5aE53cXZUK2RIZTA2LzNtbm4wbWU3bVREWE1h?=
 =?utf-8?B?cVhreWgwcjBtc2pNUEhxd3h5a3VJcWFKWDcwVHRXaWwzbTRmTEM5MWh3WTdi?=
 =?utf-8?B?eVJ3OHAzMGFROGRCSTNtamI1VUxoQVFPMlpSRTFrMDFqdUU1bXloZlJTV3BT?=
 =?utf-8?B?NGRweklYMDlEWmIzZ0duRDFnbnExRjl2TmFSdEpncmhSdng5RVhvK0VpdmdE?=
 =?utf-8?B?Kzc0dU55NXFLYmxrNHR2QVNnRHJ0T2NuRWpVUW8wSHV5dHpFUE1taDhCN0RD?=
 =?utf-8?B?S3ZWRHJkSWtuM1JSYURyTlFwM29QZ1kxRnRSRnVmQXNjRXV2VmxpYUJORzJX?=
 =?utf-8?B?enJ1YWM2SktNNlltV1hySkMrVGtaQ2pnVXlESHUwQ0U3eFR3MTlXUnB0MEc2?=
 =?utf-8?B?b2UrNy9HYWtIeDE4dFNPN2ZwUlB5U2pDYTlhMW1uY2lVcklmQkxENHVPWG5u?=
 =?utf-8?B?S0xobkpPajBjaUNGMlNETGJrRnMvMTJndkFNWlF5RGR5RDJ4dDNZN05sbm5k?=
 =?utf-8?B?ejhmSkRhMlVEczhsVTdJRzVKeFIrM2w1aWVHeTBQQ01OWmpkSDZkcXJIbVEv?=
 =?utf-8?B?WlRSOFk0TjdmOUx6enlFR3k0c2lXQ01jaGM1dEYwRE5vb0ZqcXJGQk9ZODJw?=
 =?utf-8?B?bzhob1RNYnBoYWNzWm1KbHBOREEybXU0a2lSZDR2VU40UkFZVzEwbUc5dTds?=
 =?utf-8?B?L3lDcnRJUHJQeE5jLzE1WWUxM0p0NkV1SEFTdHNwSkRoYmtnbFdoSVphWXBm?=
 =?utf-8?B?a3hQbzhYTEt6ODBkV0hLdXUxN01NN2RYY2tEZ1pzNkFoWnpRd2ZkUXN0SlRM?=
 =?utf-8?B?cVVBYU0rdnFNNTlkZm94ZmtlZVlFWmNNdnFIMHlBS3ZmYWNGNVpMdFpzMzRu?=
 =?utf-8?B?RzRMdkRkQmhlWTU3dm9GSnlQTkI5NExRcmpGcVMyY01vb1A4eGZ6Ti9iN2Fi?=
 =?utf-8?B?SFlaR2tRMnhaQ0ZNYzhTU0g0enhEYnZ5WnZ2U2RFTWt3UlBoU0E5THczL0dm?=
 =?utf-8?B?dHNpc3UrOW1kZnluZEZrSlcvYXpuRTlqQU43VDlXSTRScklOOURVVFlpUjRS?=
 =?utf-8?B?NHNWQ1dJNGhqSnJESDRldGg2eEExQ3p3VjdyV21WSER2T3dBZ3ZaY2Jtdjdr?=
 =?utf-8?B?VUhwYm00R3RBajVIUXF3cWR2Z2RxSkc5c0pqb0tRdGtQSStmNCs5eUR4UkI3?=
 =?utf-8?B?cFU1RmRGL0NoSU14UWhaZG0vcUZ3Q3Q0aXEvMklBMTdGNGlCQ1pEaTd4OGxS?=
 =?utf-8?B?d0xnaFl1a3pSK2VBeEV1NjAvYUZpZDlXTGNFcUNqejlORHY4Z1BxcWlOenhK?=
 =?utf-8?B?MW02RFZ1ckdBeXNReWkzVGFTSzZxYnZFZkhtOEFURmNQTThjdU82UGtudjdk?=
 =?utf-8?B?dkFZMkkrRUdzcU5SdXR4U2V0L2RpcWRVZlRvN0N1L2plNTU3RzhCTzVhanRU?=
 =?utf-8?B?ck56Qmg4Ui9vV1locE5mSzZ6UHdEMis3b3gzZ2hseXdKbXBkTkxnUkRGcWNy?=
 =?utf-8?B?c1ErRlo5OVEwTWQ3eTZPWGVuVXZ1ZVNDam92Ky9land4UTJhd0M4RXl6Zk00?=
 =?utf-8?B?VEhzVkcwUXYxTGxMeC9makQ0RzZKVHQ4ei9tRTQvM0pUUlA2Zkw0aktpRlA2?=
 =?utf-8?B?SWwwNUNJR3ExU3M3OHJVNzFyS2hkOHRVdXVvMEJPaDNIcnpkRmxGeWw0NVBt?=
 =?utf-8?B?Sm1QNk9hYUgzM1o1cWJwUmdLQXkxY1RJOTB3UHp1OTFMSko2aHcwQW9paklh?=
 =?utf-8?B?VlNHRXFtNnU3RFd0QVpob0JJZE9BVnZvZ1psZ0JxOFRydlNEcU9SWjA1aldV?=
 =?utf-8?Q?/1i2A9WAthEDpjQTXpxchmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3589fde-a34b-4b4d-0a71-08ddb94185aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 08:22:02.2661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Iraohih5Ftw9k2R5/0c8ULOzQMjIMtAK5zkBiyDx12SOQQTcXWCdYXBD9nJKWxkWmC+Ilw+wBZSaUfG/rcVg9yjysPr0rTpB1NRIZwdC5iiaKLk3O0nt9dOsjqmHz6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8541
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 08:22:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19281

SGkgSmFuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXBseS4NCg0KPiBJcyB0aGF0IG9m
ZnNldCBwb2ludGluZyBpbnRvIHRoZSByb290ZnMgcGFydGl0aW9uPyANCg0KWWVzLCBpdCBpcyB0
aGUgc3RhcnQgYWRkcmVzcyBvZiB0aGUgUk9PVEZTLiANCkV2ZW4gSSBhbHNvIHRyaWVkIGNvcnJ1
cHRpbmcgUk9PVEZTIHN0YXJ0IGFkZHJlc3MgKyAxME1CLCBpbiB0aGlzIGNhc2UgYWxzbyBJIGVu
ZGVkIHVwIHdpdGggc2FtZSBlcnJvci4gDQoNCj4gQXJlIHdlIGFsc28gZW5jcnlwdGluZyB0aGUg
cm9vdGZzPyBJZiBzbywgdGhlbiB0aGlzIGlzIG9idmlvdXNseSBleHBlY3RlZC4gDQoNClRoZSBs
YXZhIHRlc3RzIGFyZSBiZWluZyBydW4gb24gdGhlIHNlY3VyaXR5IGltYWdlIHNvIC9ob21lIGFu
ZCAvdmFyIHBhcnRpdGlvbiBlbmNyeXB0aW9uIGlzIGVuYWJsZWQgYW5kIHJvb3RmcyBoZXJlIGlz
IHNxdWFzaGZzLiANCllvdSBtZWFuIGlmIHRoZSBlbmNyeXB0aW9uIG9mIC9ob21lIG9yIC92YXIg
aXMgZW5hYmxlZCB0aGVuIHRoaXMgaXMgdGhlIGV4cGVjdGVkIG91dHB1dD8NCg0KVGhhbmtzICYg
UmVnYXJkcw0KU2hpdmFuYW5kIEsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
U2VudDogMDIgSnVseSAyMDI1IDEyOjM0DQpUbzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPv
vKnvvLAgRElUQ19ESVQtT1NUKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29t
PjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz
77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5
YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPGth
enVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIExB
VkE6IFN1cHBvcnQgUk9PVEZTIGRtLXZlcml0eSBjb3JydXB0aW9uIGRldGVjdGlvbiBjYXNlLg0K
DQpPbiAwMi4wNy4yNSAwODo1NywgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29t
IHdyb3RlOg0KPiBIZWxsbyBDSVAtbWVtYmVycywNCj4gDQo+IFRoaXMgaXMgcmVnYXJkaW5nIHRo
ZSBuZWdhdGl2ZSB0ZXN0IHNjZW5hcmlvIHN1cHBvcnQgZm9yIHNlY3VyZSBib290IGluIExBVkEg
ZW52aXJvbm1lbnQuDQo+IFRoZXJlIGlzIHRlc3QgY2FzZSB0byB2ZXJpZnkvZGV0ZWN0IHRoZSBS
T09URlMgY29ycnVwdGlvbiBpbiBMQVZBIGkuZSBiYXNpY2FsbHkgZG0tdmVyaXR5IGNvcnJ1cHRp
b24uDQo+IA0KPiBUaGUgcmVxdWlyZW1lbnQgaXMgdG8gbW9kaWZ5L2NvcnJ1cHQgdGhlIC53aWMg
ZmlsZSBpbiBMQVZBIHVzaW5nIHBvc3Rwcm9jZXNzIGFjdGlvbiBzbyB0aGF0IHRoZSBzZWN1cmUg
Ym9vdCB3aWxsIGZhaWwgd2l0aCBkbS12ZXJpdHkgY29ycnVwdGVkIGlzc3VlLg0KPiANCj4gSW4g
TEFWQSwgcGFydGl0aW9uIG1vdW50IHdvbid0IHdvcmsgYXMgdGhlIExBVkEgZG9ja2VyIGNvbnRh
aW5lciBpcyBydW5uaW5nIHdpdGggbm9uLXByaXZpbGVnZWQgbW9kZS4NCj4gV2hlbiBJIGNyZWF0
ZWQgaXNzdWUgaW4gTEFWQSByZXBvc2l0b3J5IFsxXSwgdGhlIG1haW50YWluZXIgc3VnZ2VzdGVk
IA0KPiB0byB1c2UgbGliZ3Vlc3RmcyB0byBtb2RpZnkgYSBkaXNrIGltYWdlLiBJIHRyaWVkIHVz
aW5nIGl0IGJ1dCB1bmFibGUgDQo+IHRvIG1vZGlmeSBiZWNhdXNlIG9mIFJlYWQtb25seSBmaWxl
IHN5c3RlbSBbMl0NCj4gDQo+IFNvLCBJIHRyaWVkIHVzaW5nIGRkIGNvbW1hbmQgdG8gY29ycnVw
dCBST09URlMgYXMgYmVsb3cgKHdyaXRlIHplcm9zIA0KPiB0byBzdGFydGluZyBhZGRyZXNzIG9m
IFJPT1RGUykgJCBkZCBpZj0vZGV2L3plcm8gDQo+IG9mPWNpcC1jb3JlLWltYWdlLXNlY3VyaXR5
LWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQud2ljIGJzPTEgDQo+IHNlZWs9MTU3Mjg2NDAw
IGNvdW50PTI1Ng0KPiANCg0KSXMgdGhhdCBvZmZzZXQgcG9pbnRpbmcgaW50byB0aGUgcm9vdGZz
IHBhcnRpdGlvbj8NCg0KPiBBZnRlciB0aGUgYWJvdmUgY2hhbmdlLCB0aGUgam9iIGZhaWxlZCB3
aXRoIGJlbG93IGVycm9yIFszXS4NCj4gIkNvdWxkIG5vdCBmaW5kIGRldmljZSAgbWFwcGVkIHRv
ICdob21lJyBjYW5ub3QgYmUgZW5jcnlwdGVkIQ0KPiBSZWJvb3RpbmcgYXV0b21hdGljYWxseSBk
dWUgdG8gcGFuaWM9IGJvb3QgYXJndW1lbnQiDQoNCkFyZSB3ZSBhbHNvIGVuY3J5cHRpbmcgdGhl
IHJvb3Rmcz8gSWYgc28sIHRoZW4gdGhpcyBpcyBvYnZpb3VzbHkgZXhwZWN0ZWQuDQoNCkphbg0K
DQo+IA0KPiBTbyBJJ20gbm90IHN1cmUgdGhpcyBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3VyIGZv
ciB0aGlzIGNhc2UuDQo+IGlmIHRoaXMgaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW91ciB0aGVuIHdl
IGNhbiB3cml0ZSB0aGUgdGVzdCBkZWZpbml0aW9uIGFjY29yZGluZ2x5IGluIExBVkEuDQo+IA0K
PiBpZiB5b3UgdGhpbmsgdGhpcyBpcyBub3QgZXhwZWN0ZWQgYmVoYXZpb3VyIHRoZW4gcGxlYXNl
IGxldCB1cyBrbm93IGlmIGFueW9uZSBoYXMgYW55IGlkZWEgb24gaG93IHRvIHNpbXVsYXRlIHRo
ZSBkbS12ZXJpdHkgY29ycnVwdGVkIHNjZW5hcmlvLg0KPiANCj4gQW55IGlucHV0IG9uIHRoaXMg
aXMgdmVyeSBoZWxwZnVsLg0KPiANCj4gSkZZSSwNCj4gSW4gb3RoZXIgY2FzZXMgZWcuIGNvcnJ1
cHQgdW5pZmllZC1rZXJuZWwsIHRoZSBiZWxvdyBjb21tYW5kIGlzIHVzZWQgdG8gY29ycnVwdCB0
aGUgbGludXguZWZpIGZpbGUgYXMgYmVsb3cuDQo+ICQgZ3Vlc3RmaXNoIC0tcncgLWEgY2lwLWNv
cmUtaW1hZ2Utc2VjdXJpdHktY2lwLWNvcmUtdHJpeGllLXFlbXUtYW1kNjQud2ljIC1tIC9kZXYv
c2RhMiB3cml0ZSAvbGludXguZWZpICJjb3JydXB0Ig0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0bGFi
LmNvbS9sYXZhL2xhdmEvLS9pc3N1ZXMvNjcxDQo+IFsyXSBodHRwczovL2xhdmEuY2lwbGF0Zm9y
bS5vcmcvc2NoZWR1bGVyL2pvYi8xMjg2ODI2DQo+IFszXSBodHRwczovL2xhdmEuY2lwbGF0Zm9y
bS5vcmcvc2NoZWR1bGVyL2pvYi8xMjQ4NzM3DQo+IA0KPiBUaGFua3MgJiBSZWdhcmRzDQo+IFNo
aXZhbmFuZCBLDQo+IA0KDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9n
aWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


