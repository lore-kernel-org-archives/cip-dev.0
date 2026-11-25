Received: from esa.hc514-86.ap.iphmx.com (esa.hc514-86.ap.iphmx.com [207.54.83.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36176.1795583885774826317
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 21:18:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hitachi.com header.s=hitachi-com-20240118 header.b=Kxj+glTH;
 spf=pass (domain: hitachi.com, ip: 207.54.83.18, mailfrom: takuo.koguchi.sw@hitachi.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hitachi.com; i=@hitachi.com; q=dns/txt;
  s=hitachi-com-20240118; t=1795583885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5OjAVgqByo25eUdnLWe+ZjITqDBNp5AAfNosUKHhRwM=;
  b=Kxj+glTHE8SyXjdXxuLh1r1ueIVJWc0mTJFZHwu6h5kJcNMAjgzY8u+X
   CdvtQusIYENKE/jryyKnMEs2RYiB7KUWrZ8UUqu1x4f6/kYM3wYEBMv+c
   2TJJS4YrR8BFGPbsBztHBTFVPHGl4E2slX0TCuKzCO7qSuVkBGa6zS9qQ
   Q=;
X-CSE-ConnectionGUID: wDxwNBF4Tj6jOX77mxlImg==
X-CSE-MsgGUID: LQ4ohFNgQVWJ8bHQOK3uNw==
X-IronPort-AV: E=Sophos;i="6.27,232,1787011200"; 
   d="scan'208";a="539282442"
Received: from unknown (HELO mlsv4.hitachi.co.jp) ([20.18.96.97])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Nov 2026 05:18:02 +0000
Received: from mfgw12.hitachi.co.jp (unknown [10.178.97.249])
	by mlsv4.hitachi.co.jp (Postfix) with ESMTP id EED90406253;
	Wed, 25 Nov 2026 14:18:00 +0900 (JST)
Received: from mrelays02.hybrid.go365.ext.hitachi.co.jp ([133.144.234.40])
	by mfgw12.hitachi.co.jp with ESMTP
	id W5OKx6dBS9Y0LW5OKx8nH4; Wed, 25 Nov 2026 14:18:00 +0900
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
	by mrelays02.hybrid.go365.ext.hitachi.co.jp (Postfix) with ESMTPS id D1A63113E1EA;
	Wed, 25 Nov 2026 14:18:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjefgQLPLvuuUDU7X5EmZJePBsGdQuziMEz+2C9DpvNrUqIM9fPy4F41gdGdzVM3WtJlF/haEbugywChroHDrC5pVj4w9iPktGEJZ8/QJqgME0WhJbYvNH5WQAe6yBjHzwA+n5a/eE6VapSLFo6OruWzYSsBTU4TJg458R3gn4tQY9Cb+7gpfrEI46qIDHyuBv87+qj9ajNO8wFftl+hFqNocJjYprgRjhDhsfRsfMdupZzyWpCh1bMXDsThAbtfGRAXSYvugYWTlU8BCo9HnOsbcqGAy2ztpMIkAHX6B++0OD6Bv9k9oEDacD3Fp/uPZc+sNVdXVHXlmAnjw7+3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OjAVgqByo25eUdnLWe+ZjITqDBNp5AAfNosUKHhRwM=;
 b=LJcpz+KjTeeBp37xBivg7ZlLTS5d93IkK49goYnxmno59Iy2W9dV6+cKjtdfdHnPRsLBdFkChbBdUlGC/5s1P4/6ilSKoY7Os+AEtCcgKRTt2adHLWnziRrFFtRbbBnfCDGytTWo74XbTlRXpMUJQF1CipOmXNRFb+BVR6peFu0pwyraw0sCpBRFrMxddcG2QOK1QyjQcDV7oqD1eqWBjrr74LTZrvICSxCFodIApi5GBlENHkEZRjZMm9GeTWj2XwjNi+DsAO5ZIUm98wnbv5a8SWj0DBaS6iH/Y6DeRayujEcjnr8yPZ/gn91ZwdVrwesEFLZQJxlmWWqe7uhcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 (2603:1096:604:332::14) by TY3PR01MB11101.jpnprd01.prod.outlook.com
 (2603:1096:400:3d5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 05:17:56 +0000
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299]) by OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 05:17:56 +0000
From: =?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=
	<takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
Thread-Topic: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
Thread-Index: AQHdfJcrP3lhT0mi/UO5OjEAqOtuDbc+Pqdg
Date: Wed, 25 Nov 2026 05:17:49 +0000
Deferred-Delivery: Wed, 25 Nov 2026 05:19:00 +0000
Message-ID: <OSCPR01MB1344916130A8CDD0305CC602BD7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
In-Reply-To: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13449:EE_|TY3PR01MB11101:EE_
x-ms-office365-filtering-correlation-id: 041c7322-050d-4812-80f3-08df4ab3770f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: f0aVeS1Fs7IjqB+jKmdfZAQ3tgpQ+Ajb5A/6wZ8MOfxAxdnSiHcAKAscQoD8pCK/4QLUn4jkoKb2KW6ZqqvO/3BO3Wt5rP6WheK1Xm89ZL/Drng34SEJptZHpesKi5cZ12GUVsrkL/DBNNFg6pc+8N/Kl6qIkercTIh4Fned3gD0mhpI/1FpC81G7FfvJEJBJkAg4cDqPInG8Kr4kz27uzMMyyzKCq3B/T967Mgt5jcOe/iaI7I9MybRlaFGAjgWvpcs6XHgLT8aIxkXSGZCnUnCdTZozno6hjqfsn4bP7rnqByTUv1MlnypCdCNnBAHXU7pmJNXhutupN0b7LTvKnLaw9xlqvwFrXq/nBMgJNYCTcWOItQ8nPAatvItOzSEfN9vszsFKu3vFPNEjasG2ov0p25q2z3sb7BjDESQ5mL6Z9k71EIc+TGYDrTR4RuKnhBrpXx4E+dOJgpBX6B1Ue+vBvvPzNeToA6OifSDOrc57nHmXno14F1DWeg3xoej+lsadWzFzxohFx55+PgpeWL6i6mEhUNF5dXq2e/VGa8UA8aTrctQUWTPklgOV1G2N2JeDBJwa1Dydu+U23oKz+o0wFliB1U0plhzXja0Uy8GAXdJqVgeEhYHhNLggDkvB7elx70+ug6gNXwuYsCU+Vi+REZPJqMvdyfETXCfPHIA2vsgabHDTjX0JvFd7gAN+KZ+Uo2yRz7+eHdL6xFxLqSChB5c4OveIKHDKUAtQJk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13449.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdFVkxyQnhhRFlOWTJLaXZEdHlmN21IUStYcEIvc3lUU3hHemJQakc4QWQr?=
 =?utf-8?B?YTVzT1BxV1Y3UDhsQzRUbFFSdThuZEZQN1NUeFBMcjdxRzVINnRLa1YzSTRD?=
 =?utf-8?B?THNsZ05hM3E5UkNrM01UMExIZGlPVVpUaWkyWjZEQW0vUHQvanlvY3o1bjRY?=
 =?utf-8?B?Qm1TcE5FWE9BZGVTMUlJZ2ZiaWkveVlsR2xpYy9uYmpSNzMwMmRwRzJBZFk5?=
 =?utf-8?B?eklQdElsQXhuQ1UvbGt2RldRSWJuNXpkOWV5RmhnOC81cmtOK1ZqRnpuaTBu?=
 =?utf-8?B?VmZkZ1k3NVI2SXN6VU9iOWRadEJXSnZUeDA3Mis0ZjE5NmE0OUhSUnZISXNx?=
 =?utf-8?B?eS8waHBoSHloVW5FejZ0VUs2NGFEenNtZWpFaHo1Q1VMbFArQ1cweEs5VGNI?=
 =?utf-8?B?QU9wMDk3RG5iUmpVTXlYWjVpTnpsRmFPVFByYjJianllSnlKeExOOG96SXEy?=
 =?utf-8?B?K2ZzU2x6SDhrNkh0RGJCUS85d3BWY2k5YjREV1Z5amxyNFRYRTA3all3MjUw?=
 =?utf-8?B?dkd4cmllYlRWZ3hkSnBCSHQ0dHlsMUNzTmR6VmtaWm15d3RMMlllVTRjVmtx?=
 =?utf-8?B?VXhhRENLOERCaEtQT1paekp2WStlV2s2dTc0ZzlIOVhBeVluMGtOQm1PWU9v?=
 =?utf-8?B?NWdQYnAyYXN2YWx1VE1YbFhVS0Q1bDJSTWdva0NTU0owSHhDdmNHcjNUTGNY?=
 =?utf-8?B?TmJQSS9MZys2d1ZMaFQ2a1FLZE8rbStDU1prRnh6UmdzV0pWaXJuRnQxRFFK?=
 =?utf-8?B?SkdHYURqMnlCWXVXcjFLNzlFUXU1WGQ1Umg3M3Nhak1RSzNLT0FVcS9rQlVB?=
 =?utf-8?B?Z0ZKdnI2NDViRWxtU21KNVdLU3VkZTRLY0lMOFNpd2hGWVF5K2ZYRHQyZEZL?=
 =?utf-8?B?ZkJHcXkzOEV5NzJpVGpqa0l5MVU2NkdpNUsyeTdRSHQ4V250aWIxZi95MHh2?=
 =?utf-8?B?OE5LcGRqY3lIdms2c3Zxd2ZiWGV2T2U0R2JqWHZ2Zk50dGcxQ1diT2cyakUx?=
 =?utf-8?B?MHcrZ09CNTBLMmRwRWExNVpIUzlZM25YMU0wdDFKbnFUYnJpYnZkZkJPY0VV?=
 =?utf-8?B?d3AwRjdPd3gxTDFQL1dtc3RGYmVGcngwVlhseG9wYXJhVGZHYTArNXhxSmJQ?=
 =?utf-8?B?MzgycW1FekRrZ2JTSGR6TU5OckNKMU1kYWYrRk1mZVFLcGJIbEFIK3pGb3FE?=
 =?utf-8?B?RjhGZHptcy9nS1dtZWlKUXJPMEQ1d05TWTJIbjFocXppN24vVFU5U2xEdXNZ?=
 =?utf-8?B?NDY4WWNIMmJabkJUSjg5VFdZd1JpaVpWRGEwU3loRkVYL0FPTGw2Z0FBbmNx?=
 =?utf-8?B?YWJEaHdxUnFZcTU0b3VjeE5hZEpYUnhVb1lTUEV2TW1nVDdhNWpZWG9Sc1Zl?=
 =?utf-8?B?ME5sWlJwcUE0R3pyckNvU3NFNjQ0VHJxNGwwODNGdldjazMrUnhIOHZVMUs1?=
 =?utf-8?B?bUJNQnNybm5PRzRoZURvR0pQZTkzcDNicDNhQmZZaVdlTjdvN2V6NVJvZjZv?=
 =?utf-8?B?V0xuZnA0UitnVjdpL0hQdUcrejhEQkVUUHZCTTZnQnZnbU81bnVuMUU3djla?=
 =?utf-8?B?OGFSNHQxKzlyYVEvcEJPbmNDeGRSN1hqcjFXT1RrcGhKNDllbkVRSWlZNm1Q?=
 =?utf-8?B?WmdkOWxFOTFGcnM3VGg0NG5MenFwakFkWjVKN1Bwb0lTUCt6NWQ2STRZNXFp?=
 =?utf-8?B?Wnd6Tng2RjJUczlMZnl6MUI1dnZUOU5FcWFxK3BQZ0Npa0I2Uk9IbzFtL281?=
 =?utf-8?B?TmpPOGU0dEJHU2FBNVBmUGRJSkhlNHluYTE5VGFMcCtEOEtxd0J0blJRQ1Nn?=
 =?utf-8?B?QklseXFubDlmdVlVbWFnbUkrdDdIOFB1SG5xREZ6VzRmcThvYkQyKytTSUJH?=
 =?utf-8?B?WVN3MHV1ZGVyUTBPV3J2dkY3N2NQRy9zeGFQb09zelp4RWxFN3RjVnc4TkZI?=
 =?utf-8?B?ZXlaZDlNNmFqNTRMNFhVMjlSMjg1eEFxSGlHSm15RDJJZW5MZnlIZmNWV21p?=
 =?utf-8?B?RTREbngySzZ3bXRyK0pETG12YWxkc2tJVXJpNERHVDV5VVByc3NqbEIzRk04?=
 =?utf-8?B?WWd1dkkyWHE3MWdVNHZTVGJsUXV2bkRjSHlDd2RtMjlzdHRVT0xCU1dzRVlR?=
 =?utf-8?B?b2kvbzFxQWloRmZYZUhtVXNhNVc5bTRxZTN3YzNRWFJmSlYvczJkUm5PN3pv?=
 =?utf-8?B?ZkdxdVVjdHBOR3kyNGdIZUIvM2VTN1QvVjhBb3hIb09LeUhRMTdBcndDR1Rt?=
 =?utf-8?B?b3M4NE5Lb1Y0d3pOclZ4T2NRcytQSTRmNW9vRG5TdE52ai9XUHdNUzVBRzRC?=
 =?utf-8?B?ZTFNYndvek84UzhEcWtZTHpwL0dFWXhpWTdFMEl4dWRJVmp5bW5GSk9xWmxP?=
 =?utf-8?Q?KfodIUb6FSK1ZW8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ine2W+MQqAE4Ezjz1eWhvK7Xgb/ZBrmUqYBAAuWGZ5eMw09RcbMnEZ2K9+m6l6B5NyTuNiU0ep5XnGaZeb7TUZ1bltrzG1DlWaOzvE+ArNEjmI0Fln05JB7klmPLJJ5bCKb5fpu9zb1fBcxaLeXSMIB4B1tnhCK1X8ZrDMoT4dkCodcCCmuDhtajqGJpKfz1JFf2socch3dCfuVZezYpkTxof2zJ+wuQr5LHxFWH4hx8k+QMsxAlXbclSwowY1Hac3UxsiBO7IOl4m5dgQlj0StVbsRkj6nmOEpzq2ytKbfgsa1bzfh3KwtRl7EsudqfPXZdbubkgGd++zctqjxgVQ==
X-OriginatorOrg: hitachi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041c7322-050d-4812-80f3-08df4ab3770f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 05:17:56.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WasfMrcjXhugvoP1QvISOratQiUrS2qcONVniYUOPOKBpSA6zYli5JrsC+W4qARECeE3J/pQX5p4TtlfaC+98mjcNUJKJWdjTrcqFsqzVjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11101
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 05:18:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25068

RGVhciByZXZpZXdzLA0KDQooUHJldmlvdXMgbWFpbCBsb29rcyBsaWtlIGJsb2NrZWQuKQ0KDQpU
aGlzIHBhdGNoIGlzIG1lYW50IHRvIGJlIGFwcGxpZWQgZm9yIGxpbnV4LTQuNC55LWNpcCgtcnQp
IG9ubHkuDQoNClJlZ2FyZHMsDQoNClRha3VvIEtvZ3VjaGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogVGFrdW8gS29ndWNoaSA8dGFrdW8ua29ndWNoaUBnbWFpbC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjUsIDIwMjYgMTozOSBQTQ0KPiBUbzogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IHJvc3RlZHRAZ29vZG1pcy5vcmc7IOWw
j+WPo+eQouWkqyAvIEtPR1VDSEnvvIxUQUtVTw0KPiA8dGFrdW8ua29ndWNoaS5zd0BoaXRhY2hp
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBtZW1jb250cm9sOiBwcm90ZWN0IGRyYWluX2xvY2Fs
X3N0b2NrKCkgd2l0aCBnZXRfY3B1X3ZhcigpDQo+IA0KPiBPbiBQUkVFTVBUX1JULCBkcmFpbl9s
b2NhbF9zdG9jaygpIGFjY2Vzc2VzIHRoZSBwZXItY3B1IG1lbWNnX3N0b2NrIHZpYQ0KPiB0aGlz
X2NwdV9wdHIoKSB3aXRob3V0IGRpc2FibGluZyBwcmVlbXB0aW9uLg0KPiANCj4gQWNjZXNzZXMg
dG8gbWVtY2dfc3RvY2sgZnJvbSBjb25zdW1lX3N0b2NrKCkgYW5kIHJlZmlsbF9zdG9jaygpIGFy
ZSBhbHJlYWR5DQo+IHNlcmlhbGl6ZWQgdXNpbmcgZ2V0X2NwdV92YXIoKS9wdXRfY3B1X3Zhcigp
LiBIb3dldmVyLA0KPiBkcmFpbl9sb2NhbF9zdG9jaygpIHN0aWxsIGFjY2Vzc2VzIHRoZSBzYW1l
IHBlci1jcHUgc3RhdGUgd2l0aG91dCBlcXVpdmFsZW50DQo+IHByb3RlY3Rpb24uDQo+IA0KPiBB
cyBhIHJlc3VsdCwgZHJhaW5fbG9jYWxfc3RvY2soKSBtYXkgYmUgcHJlZW1wdGVkIHdoaWxlIG9w
ZXJhdGluZyBvbg0KPiBtZW1jZ19zdG9jaywgYWxsb3dpbmcgYW5vdGhlciB0YXNrIHJ1bm5pbmcg
b24gdGhlIHNhbWUgQ1BVIHRvIG9ic2VydmUgb3INCj4gbW9kaWZ5IHRoZSBzYW1lIHBlci1jcHUg
c3RvY2sgY29uY3VycmVudGx5LiBUaGlzIG1heSByZXN1bHQgaW4gaW5jb25zaXN0ZW50DQo+IHVw
ZGF0ZXMgb2YgY2FjaGVkIGNoYXJnZXMgYW5kIHN0b2NrIGNvdW50cy4NCj4gDQo+IEZhaWx1cmVz
IHdlcmUgb2JzZXJ2ZWQgYXMgZGl2ZXJnZW5jZSBiZXR3ZWVuIG1lbWNnIGFjY291bnRpbmcgYW5k
IGFjdHVhbA0KPiBtZW1vcnkgY29uc3VtcHRpb24uIFRoZSBkaXZlcmdlbmNlIG9jY3VycmVkIGlu
IGJvdGggcG9zaXRpdmUgYW5kIG5lZ2F0aXZlDQo+IGRpcmVjdGlvbnMsIGluZGljYXRpbmcgY29y
cnVwdGlvbiBvZiBhY2NvdW50aW5nIHN0YXRlIHJhdGhlciB0aGFuIGEgc2ltcGxlIGNoYXJnZQ0K
PiBsZWFrLg0KPiANCj4gVW5kZXIgc3RyZXNzIHRlc3RpbmcsIHRoZSBhY2NvdW50aW5nIGRpdmVy
Z2VuY2Ugd2FzIHJlcHJvZHVjaWJsZSBhbmQgd2FzDQo+IGZyZXF1ZW50bHkgYWNjb21wYW5pZWQg
Ynkgb29wcyBzdG9ybXMuIFByb3RlY3RpbmcNCj4gZHJhaW5fbG9jYWxfc3RvY2soKSB3aXRoIGdl
dF9jcHVfdmFyKCkvcHV0X2NwdV92YXIoKSBlbGltaW5hdGVkIHRoZSBhY2NvdW50aW5nDQo+IGRp
dmVyZ2VuY2UgYW5kIHRoZSBhc3NvY2lhdGVkIHN0YWJpbGl0eSBpc3N1ZXMuDQo+IA0KPiBVc2Ug
Z2V0X2NwdV92YXIoKS9wdXRfY3B1X3ZhcigpIGluIGRyYWluX2xvY2FsX3N0b2NrKCkgdG8gc2Vy
aWFsaXplIGFjY2Vzc2VzIHRvDQo+IHRoZSBwZXItY3B1IG1lbWNnIHN0b2NrIGFuZCBtYWtlIGl0
cyBwcm90ZWN0aW9uIGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXINCj4gbWVtY2cgc3RvY2sgdXNl
cnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYWt1byBLb2d1Y2hpIDx0YWt1by5rb2d1Y2hpLnN3
QGhpdGFjaGkuY29tPg0KPiAtLS0NCj4gIG1tL21lbWNvbnRyb2wuYyB8IDEzICsrKysrKysrKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21tL21lbWNvbnRyb2wuYyBiL21tL21lbWNvbnRyb2wuYyBpbmRl
eA0KPiBmOWQ4MDk1MjcyM2MuLjliMjk4Y2UxMGE3YSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtY29u
dHJvbC5jDQo+ICsrKyBiL21tL21lbWNvbnRyb2wuYw0KPiBAQCAtMTkzMywxNCArMTkzMywyMSBA
QCBzdGF0aWMgdm9pZCBkcmFpbl9zdG9jayhzdHJ1Y3QgbWVtY2dfc3RvY2tfcGNwDQo+ICpzdG9j
aykgIH0NCj4gDQo+ICAvKg0KPiAtICogVGhpcyBtdXN0IGJlIGNhbGxlZCB1bmRlciBwcmVlbXB0
IGRpc2FibGVkIG9yIG11c3QgYmUgY2FsbGVkIGJ5DQo+IC0gKiBhIHRocmVhZCB3aGljaCBpcyBw
aW5uZWQgdG8gbG9jYWwgY3B1Lg0KPiArICogRHJhaW4gdGhpcyBjcHUncyBzdG9jay4gIENhbGxl
ZCBkaXJlY3RseSBieSBkcmFpbl9hbGxfc3RvY2soKSBmb3INCj4gKyB0aGUNCj4gKyAqIGxvY2Fs
IGNwdSBhbmQgYXMgYSB3b3JrIGl0ZW0gZm9yIHRoZSBvdGhlciBjcHVzLiAgUHJlZW1wdGlvbiBp
cw0KPiArICogZGlzYWJsZWQgaGVyZSBiZWNhdXNlIG5laXRoZXIgY2FsbGVyIGd1YXJhbnRlZXMg
aXQgb24gUFJFRU1QVF9SVDoNCj4gKyAqIGRyYWluX2FsbF9zdG9jaygpIG9ubHkgaG9sZHMgZ2V0
X2NwdV9saWdodCgpLCB3aGljaCBpcyBhIHBsYWluDQo+ICsgKiBiYXJyaWVyKCkgd2l0aG91dCBD
T05GSUdfU01QLCBhbmQgdGhlIHdvcmsgaXRlbSBydW5zIGluIGENCj4gKyBwcmVlbXB0aWJsZQ0K
PiArICoga3dvcmtlci4gIGNvbnN1bWVfc3RvY2soKSBhbmQgcmVmaWxsX3N0b2NrKCkgcnVuIHdp
dGggcHJlZW1wdGlvbg0KPiArICogZGlzYWJsZWQsIHNvIHRoaXMga2VlcHMgZXZlcnkgdXNlciBv
ZiB0aGUgcGVyLWNwdSBzdG9jayBzZXJpYWxpemVkLg0KPiAgICovDQo+ICBzdGF0aWMgdm9pZCBk
cmFpbl9sb2NhbF9zdG9jayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKmR1bW15KSAgew0KPiAtCXN0cnVj
dCBtZW1jZ19zdG9ja19wY3AgKnN0b2NrID0gdGhpc19jcHVfcHRyKCZtZW1jZ19zdG9jayk7DQo+
ICsJc3RydWN0IG1lbWNnX3N0b2NrX3BjcCAqc3RvY2sgPSAmZ2V0X2NwdV92YXIobWVtY2dfc3Rv
Y2spOw0KPiArDQo+ICAJZHJhaW5fc3RvY2soc3RvY2spOw0KPiAgCWNsZWFyX2JpdChGTFVTSElO
R19DQUNIRURfQ0hBUkdFLCAmc3RvY2stPmZsYWdzKTsNCj4gKwlwdXRfY3B1X3ZhcihtZW1jZ19z
dG9jayk7DQo+ICB9DQo+IA0KPiAgLyoNCj4gLS0NCj4gMi4zNC4xDQoNCg==
