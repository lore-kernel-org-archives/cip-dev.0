Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDDD116F1
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 13:21:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21141.1764595250892093922
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 05:20:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=B+CwqxME;
 spf=pass (domain: renesas.com, ip: 52.101.229.57, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXsUtmCIltJVyRqw+fc6OQUjG4q5TuDaHLY2d2rldqdUAdJI0BqfC16fmloZw968j7L1aLlowF+xgE9dwcniZft8SHjhn+ed6EmD1LE4iRdlnK/8TMQ/PU/f2EXP0QvalUSciUvn6b/xf+6tXnfAFLS+0RGDhdZOgaAqRbWTotx0Wn47DxWVWl+InsuACKTt0mj2uc7TErYtsLLTUDTr8YRGv85BWYN/IVlhVMDa3Qf/jYlV9S5VxAjbF8GamPJfpu7ErphTe43YOvUz0hZ2xCH+hqbN1n2SVxM7+zzDmSV/kDQlvNtneGS+TWr1doVKGFG+UV5wxmi043K8ntiHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FIrXghe6GObcPgmwUX+q5nzVXpguTdkS4H00thPedw=;
 b=O1AVKktqWWwB5cGK99RJVpExzgeR4hZqX9q/UzWlopiU3Miol9hJ5lN5y9ujJegyl4L4+49dJn3VxGJFaviyMsSqgX7cbp5fOATM/tbWlUSwrTxdPCPS6TsgQYeSfAHvHJJnbu8EA8ZjsXZtXLzocWsXM5lIMcMFYjNTx5MjKNRGGWyK/+/NGwX16NnRjkXt5xmpAkt6m8KM/XT/Ily/Ox6+Arm7AD2ZoeElztVL9X+F/nIZmQx+cZMErkAQ1mPzYOeglGz1uA4A9mfTK2wrhZotXqQGyFXmIeOGsJKlr28vs3639XfrAdWCdI84QyBnhIb4BpdTwNlC6AyOTei2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FIrXghe6GObcPgmwUX+q5nzVXpguTdkS4H00thPedw=;
 b=B+CwqxMEnr2lCV80+KWwSfAYCNGTMA4YJ8LHfqpmZoXdqTPZ1rWqGFgxFGACX/ThPXD5eRM/THslvrsU2tASkS2RZMD3bP6TkKQM/AyNKzFJn4whzUFTu3HrHbVFN2j9nkVoDUBznakUmMY8EWTJJ1PIFqMn3iA8shJuxbKrd+g=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSCPR01MB15611.jpnprd01.prod.outlook.com
 (2603:1096:604:3c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 13:20:46 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 13:20:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, Pavel Machek
	<pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>, Arisu Tachibana
	<arisu.tachibana@miraclelinux.com>
Subject: RE: [cip-dev] 6.12-cip RT testing
Thread-Topic: [cip-dev] 6.12-cip RT testing
Thread-Index: AQHcWE6PkW7DydJ4rke+DIHGtXDHqbT4ZvYwgAATJICAFBpjgIAAQxUg
Date: Mon, 1 Dec 2025 13:20:46 +0000
Message-ID: 
 <TYYPR01MB151320DF527F486189DBEF103B7DBA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
 <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
 <c2a68a07-435e-4a70-af85-0e34a7884946@siemens.com>
 <687ebce7-64c8-4bfb-8ed1-3b36ab1f2dad@siemens.com>
In-Reply-To: <687ebce7-64c8-4bfb-8ed1-3b36ab1f2dad@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSCPR01MB15611:EE_
x-ms-office365-filtering-correlation-id: 5fe9ad5c-2bde-4af1-d069-08de30dc7013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eHJ4S3k4a004Q0JtRmRZVnJzQkl0TDBxZ2g3QnhPdG5xQ0htVTFwYnhDc2VZ?=
 =?utf-8?B?NzJMWERxai81Y2tMNEU2U2JDaFN1ZklsZ0RzMTdYb3pQelZUcGlHYUFTamta?=
 =?utf-8?B?SnF2aFcwUGwvZXpJZGg2OWNaSWtjeXFIcmtjdkVuQzROc0NwVHRzV2FYa05F?=
 =?utf-8?B?S0JxT1pudHpHc2pveUwyc3FjUXBUNWFyZ1d5dWZQSEh5d1czc3Jwb1dNbFN3?=
 =?utf-8?B?RzFEZTN5TTA5ekZobC81TkZkQmNBa3lERXUzaFVONms3ZU1VVTQ0WnF6bUpa?=
 =?utf-8?B?cGpCU3p5RTM3VFlEdFcyRWxwMTJYeWhEb1IvMk0wQjFzV3l1UUhRWE1QYW0w?=
 =?utf-8?B?UkJqSjc3R051TDV2SVR1ZCs0cHBERms4RWdxeTFkTDk0T0cwbG1PU2VnSzY3?=
 =?utf-8?B?bFNRa0dBNTBXRE5nUGhRcGoxSEtKd3UxdGtyckc4QXV0UVRHL0I1OHRvNDFN?=
 =?utf-8?B?elFGWHJqaWtWaGMwSmtXdW1GQVM0MVdBd2dibjNUaHlXbWlSWUxvdnhiTjhF?=
 =?utf-8?B?a3FyZ0VqenhVZGJZRGI5N2d2YW45Z2RSdjIzSDJTWXh0RkZSKy9Fb0NNVEJH?=
 =?utf-8?B?Nkp6VmR3dzdPUUxPU05yRlRQcVpheGx0Vy9VM2RZQkhtZkJVaGNaY2dFckFX?=
 =?utf-8?B?N3NwTGE5a0JFeW5uYXV6M3RvazU5dmtlWUpSY0RNQU9FNGw1SWJHYm1teG1K?=
 =?utf-8?B?RCtvN0FUSDBQbnU3b0ZrNzhtVCtacU9XUlZLT09HRXJla0gvcnFMUEg5M015?=
 =?utf-8?B?THl1Z0owbWkxRDNnSXV4OSt1bHNDU2NXR1dwbDR0U2hac2NJUjdvY1hmOFZU?=
 =?utf-8?B?QWQrQkUwV0RPT2x4SjVYOWt2YW90QTlzbmJ0TTg4STdIUXZsZGZhUWl3NzJh?=
 =?utf-8?B?K0JTRUh5b2ttV2N2SGZUbFRjaW9GL2pZY09DS1c4ZDdxelBkeTZMVUFTalo4?=
 =?utf-8?B?Tnp3bUhlcUxGR29yUlV2R0lLMk1ublRiSktRWG9ETlRWT2IwVWVqMkVleUlu?=
 =?utf-8?B?eEFCY0hvT0w0RFhsL01oVmcyNUozSkw0djNnRlNZcnJscTg2TEFvaEI0VE5w?=
 =?utf-8?B?bklKbkt0Z2hQdDVVTXJWMmlRMDcvekJkTEszS1IrVDRFL0RuYVZ2aEdITDR3?=
 =?utf-8?B?TDNGcnF0VnFsdTQ3aTRoclhMY3BYdEw3QkVSWS96Qno3WFY4TWNScWtLWEox?=
 =?utf-8?B?Qm80cHQ3eDlWOC9ZU3BHZGNpQUlOZXlJYUFIU0RJUHNDWjBVNGtZanp6UUQy?=
 =?utf-8?B?SzFpRUV1WVVjcVJraXVibFY3N3plY1JTcDFhdzR0WUVhTkg5TmxxRW9laVZK?=
 =?utf-8?B?UWNOVnVMVXd5cThjeWYyZUtBcG1uelZ5UnpPa1dlRnFXZ2ZJMGdub3E5QkdO?=
 =?utf-8?B?cGtmQjAvQk00a20vaFhWMkV2aWM3SEp4NkpGV1ZiaTk0VlpBSVdmYUdmbXI1?=
 =?utf-8?B?MDB2V0FNWDV6azk1WjR5eUVyYVVzaFVzblU5YkZlMXRITGdiWUtsNFNBcDVD?=
 =?utf-8?B?TFk3a3BkTUlMNUl5ckZOWGJTZFVqYUFwNTJqbk9RaTFyTlJvNkxmVENXTUtY?=
 =?utf-8?B?RVlhMW9nV0w0bldjM3JWV05RcXpzdUpBVHRQZ0RNc2hEcG9GeTV2MDBGUWk1?=
 =?utf-8?B?SmIzWnVVQmhqYWtWZTFDMHNPTXpNMjVmWjBzWGY2Qkx1a0pyWEJxZU50V25N?=
 =?utf-8?B?LzQxUmtuLytNV3VpMTVKYkdSdmEycFVZM0twZEhmYy9uM1ptTUlYTko2YjVi?=
 =?utf-8?B?aytzWnVrR3J6R2lSSi9JaitPLzRUenE3Y3NZZVVCelNid2lTbWJueGNPM25K?=
 =?utf-8?B?RTJJRGpiVCs0OE9sT0VMZys3eS9uRDdDTGNPT3RERit3ZHVBL3VGTncwS1Ew?=
 =?utf-8?B?bmlvNVA1L0NCZjFvTzA0V2E3SUJ3QmdMbWlQTWFpVXdDbnU1aEduTmVuMUMz?=
 =?utf-8?B?VFF4NXBKR0RYWklRWnVLeFg3YXVNR3NqWmY0emlHNE9Gb3RtcWtOMVJ4N3lN?=
 =?utf-8?B?eXkzZVd5SW1nPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ritxek5IVTNqWkcxQ2RCK3NwdHZobHczME9IRjljQlJlM20rUFB4dnFiOGUw?=
 =?utf-8?B?M05jN0RWV0l2VXNNd2Y1d1JxM1lCcnVlZG5ZRnRrTDREL2VNUmFnUTNpWnk1?=
 =?utf-8?B?eFRYY0FWM00vQzN2ZGlKcDVURHNmUWw1UHkyeEV5NVQ2QXVtaFpUL2xhK1VV?=
 =?utf-8?B?NFViSjV0ajhoOGNVU0R1Ty9XaGlsdTJqdndycGQvRHJROGtRQitSOEZWWHNP?=
 =?utf-8?B?RTEyd0wrWGU4VWNhWXh1K2xFQzZxZDIydmxjeENEOUJWTVNHcWVIZW9oNDZl?=
 =?utf-8?B?OTVjUkRQRWZMbC9SL2YvK29mMFRRV3ZlMko4UkRIRGYvNFBaNEhkVUpiQWRL?=
 =?utf-8?B?M2JpVVJRQlUrOGkwa0RWYURPd0kySzZoSkJGUkZmVlBKZ0Q1VGVqR3hrcmU3?=
 =?utf-8?B?YjdsdnBFZkxhZ005ZTFmdjFUOENkUHk1ZHVLbG9YekRtTnFiWnFZTU5MeVFx?=
 =?utf-8?B?S0UxalBVVnR6MkJndyt3V3UvWjdOblNjcElKeUFxb0NzS21YdFVJNDdaQmlw?=
 =?utf-8?B?dlZzM0cveUt4R0Ztc0E0OG5vVi9QdzBoYTA5R21OdndCc3g1NmptNmwwbU82?=
 =?utf-8?B?bzBITXdVWnpQL0VPMnppbVpRUjhDdlFSTWVXZk9vRC9KUGdZMmJ2TWQwRkM2?=
 =?utf-8?B?WmtVeGN4U2pCeDE1QllpQ2dRb0dCS0FNS2FsYW1MNXUyTGtrRi9QbEExTXFt?=
 =?utf-8?B?MzYzVGtkVW9DZHVWa0U2cllYU0JhRHUrNVlPWUNGL3orVGJSbTF4eHlLVktC?=
 =?utf-8?B?QjdzbE40US94ajA0VTlLeEtVa3prMG1FVnl6ZkhqQmVlQUJVbk9HTDV5YzVm?=
 =?utf-8?B?WG9ONkRINXNGOUgvdTl1S3FwUll4SytVaWYxdHJoWi9vN08yRDNiMUQvVStB?=
 =?utf-8?B?MmhZVEd3SzNpRU1lbFF4OEU2YkVsamVIeUhQa2dXRlFUd3Zwd3oxc1djWG9t?=
 =?utf-8?B?K04rN3MwNnlsRHZwM05rZ0dEWFRTb2pYQWF6bUtJMXFYV1RKcTdiRVhXQ2Fm?=
 =?utf-8?B?KzZHN3l4YmorcEZrVEJiWUp6SmwxemFUbjZidDJQa1VibHh6V21PZnN5UjZT?=
 =?utf-8?B?MmZOQXhKWUFjUVE1K2JVc0EvZVlrOHlZSlVoM0t4b1F6dWYxd0FNVlZ1WDNM?=
 =?utf-8?B?dGRjbHlzWVAvb2NsTzBOYlVQVTA1bUxBZ2VCVXFzUHllZVZlTW0yMWxTaG5H?=
 =?utf-8?B?aXB0enFDNkVzc2ZHN2x6SGYxdkVZVEV5TzFVOS9oclhzUkNHckZTWi9WdDM5?=
 =?utf-8?B?empUYURGSHFSYUM3WFNGK1ZWQlFjZnNFS2RaeUU0NUVVWG1jTjlCM2M1Q2VG?=
 =?utf-8?B?aFVIMTVpZktPLy9Kb0tiMHdQTHkvQWpxVWJBbTE5NElNbE9oUVUyNEVWUEtQ?=
 =?utf-8?B?RUZDb0doNENXMm9JbWxvZUsvNnZOUFZJd2NwcWd1cFQyOGE3T3ZjdUsrUzkr?=
 =?utf-8?B?SXVsSDBLSVB3b3hISkRWQ01PMUt1VEVFbEduOVlUTVI3U2ZmcVl2Z1kvOGRB?=
 =?utf-8?B?bnY2RXZoQkt2cnNGeDU3U0pkMWR1ZXl1R0NHMC9UajQzT2g0QUtrUWp5S0pH?=
 =?utf-8?B?VTh1L0gvK0NmQ2JOSDBmRlJFdDZNQ1Fjak1ZWDVKdThjVkcwN0hDUVRSU2Ey?=
 =?utf-8?B?R2d6alpqN1NGUmlQYUR4ZTlteGRLYjIzdEtsR2FqMWpXVVgvRXZHQXovMlZL?=
 =?utf-8?B?MEp2M0dLWFlRbVJBRGt4NFA4V29FeUljZi96RW9LSVpkT0xKM1lFR0dWQnJ1?=
 =?utf-8?B?K0d3NW1wQUtadnNsNWovL0RvRnFsRU9sVHFvN0tqUXlaZFZreExHRzlMcTVL?=
 =?utf-8?B?YXJGZVNxNktWUEhzMVR4OHhDanhXWnRJbE90L085QnhPTjRlcVZqK0xmSmlI?=
 =?utf-8?B?dFFTeXNpZEdVdVJzYU9xQ2trN1hEMXJRMnhIL2xEdEZEZzlQRnNiNEFMVzJQ?=
 =?utf-8?B?Y3haeWRoNzZmUEsycTRxT2tWNnJjcmtuTFhaa3hXUk9KSFRpUVpyS2FGTXp0?=
 =?utf-8?B?UEFveUpxOXZ5SW83NzhnNHZza1NxdXVPNk9UaGZqWEtCQkVvL29jVXlLT1U5?=
 =?utf-8?B?WExjWXpJelcwZFhwazVuRUUxOStRYU8zUG9Idnk2dzZCOXZQOXVtL05Lb1Jl?=
 =?utf-8?B?bkoxUXJld1o0a0JPOS9rUWtuS0FybHVoU1F6MGhmd1BEU1Y2d0RGWFE3Z21k?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9ad5c-2bde-4af1-d069-08de30dc7013
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 13:20:46.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hVqEsL2NO3Hd+hihKbVxUsi+KVk+Gbxl5KXMrJsE+8Lb9YyFSSYcyFJxhkXQpO8cYE1x73xxFf5TMW3Sjr/h59A+3o1b5iQM7cyMvqAXFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 13:21:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20781

SGVsbG8gSmFuLA0KDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2Egdmlh
IGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiAwMSBEZWNlbWJlciAyMDI1IDA5OjEyDQo+
IA0KPiBPbiAxOC4xMS4yNSAxNToxMiwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBPbiAxOC4xMS4y
NSAxNDowNCwgQ2hyaXMgUGF0ZXJzb24gd3JvdGU6DQo+ID4+IEhlbGxvIEphbiwNCj4gPj4NCj4g
Pj4+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4+PiBTZW50
OiAxOCBOb3ZlbWJlciAyMDI1IDA1OjQ1DQo+ID4+Pg0KPiA+Pj4gSGkgYWxsLA0KPiA+Pj4NCj4g
Pj4+IGxvc3QgdHJhY2sgYWJvdXQgdGhpcyB0b3BpYzogQXJlIHdlIHRlc3RpbmcgYnkgbm93IGEg
a2VybmVsDQo+ID4+PiBjb25maWd1cmF0aW9uIHdpdGggUFJFRU1QVF9SVCBlbmFibGVkIG9uIDYu
MTItY2lwPyBJbml0aWFsbHksIHdlDQo+IGRpZG4ndA0KPiA+Pj4gSUlSQy4NCj4gPj4NCj4gPj4g
Q3VycmVudGx5IHdlJ3JlIG5vdCB0ZXN0aW5nIFJUIG9uIDYuMTItY2lwLg0KPiA+Pg0KPiA+PiBJ
J3ZlIGp1c3Qgc3RhcnRlZCBpbnZlc3RpZ2F0aW5nIGhvdyB0byBlbmFibGUgdGhpcyBpbiBLZXJu
ZWxDSSBmb3IgYWxsDQo+IENJUCB0cmVlcywgYnV0IEknbGwgc3RhcnQgd2l0aCA2LjEyLg0KPiA+
DQo+ID4gVGhhbmtzIGluIGFkdmFuY2UhDQo+ID4NCj4gPiBDYW4gd2UgYWRkIFsxXSB0byBjaXAt
a2VybmVsLWNvbmZpZywgbWF5YmUgZXZlbiBtaWdyYXRlIGl0IG92ZXI/IFdlDQo+ID4gYWxyZWFk
eSBhZ3JlZWQgb24gbm90IHRyeWluZyB0byBtYWludGFpbiBzZXBhcmF0ZSBjb25maWdzIGZvciBy
dCBhcyB0aGF0DQo+ID4gaXMgZG9vbWVkIHRvIGNhdXNlIGV2ZW4gbW9yZSBjb25maWctcm90dGlu
ZyB0aGF0IHdlIGFscmVhZHkgaGF2ZS4NCj4gPg0KPiA+IEphbg0KPiA+DQo+ID4gWzFdDQo+ID4g
aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLQ0K
PiAvYmxvYi82NTFjMzhjMWM5ZDgzNzMzMWZiNGM0YTY4YTRhNzVjMjcxNjNjZWQ2L3JlY2lwZXMt
DQo+IGtlcm5lbC9saW51eC9maWxlcy9wcmVlbXB0LXJ0LmNmZw0KPiA+DQo+IA0KPiBBbnkgbmV3
cyBvbiB0aGlzPyBIZWxwIG5lZWRlZD8NCg0KSSd2ZSBnb3QgYSBQUiBbMF0gb3BlbiB0aGF0IGlz
IGNsZWFyaW5nIHVwIHRoZSBDSVAgcGlwZWxpbmVzIGluIEtlcm5lbENJIGEgYml0Lg0KT25jZSBb
MF0gaXMgbWVyZ2VkIEkgY2FuIGNvbnRpbnVlIHdvcmsgb24gYWRkaW5nIFJUIHN1cHBvcnQgWzFd
LCB3aGljaCBpcyBjdXJyZW50bHkgYWRkaW5nIGJ1aWxkLCBjeWNsaWN0ZXN0IGFuZCBjeWNsaWNk
ZWFkbGluZSB0ZXN0cy4NCkN1cnJlbnRseSBpdCdzIHVzaW5nIEtlcm5lbENJJ3MgUlQgZnJhZ21l
bnRzIFsyXSwgd2hpY2ggSSBoYXZlbid0IHRlc3RlZC4JDQpPbmNlIHNvbWUgdGVzdHMgaGF2ZSBn
b25lIHRocm91Z2gsIEknbGwgbG9vayBhdCBhZGRpbmcgdGhlIGV4dHJhIGNvbmZpZ3MgaXNhci1j
aXAtY29yZSBbM10gaXMgdXNpbmcuDQoNCg0KWzBdIGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWxj
aS9rZXJuZWxjaS1waXBlbGluZS9wdWxsLzEzODINClsxXSBodHRwczovL2dpdGh1Yi5jb20va2Vy
bmVsY2kva2VybmVsY2ktcGlwZWxpbmUvcHVsbC8xMzY4DQpbMl0gaHR0cHM6Ly9naXRodWIuY29t
L2tlcm5lbGNpL2tlcm5lbGNpLWNvcmUvYmxvYi9tYWluL2NvbmZpZy9jb3JlL2J1aWxkLWNvbmZp
Z3MueWFtbCNMNjg0DQpbM10gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3Jl
L2lzYXItY2lwLWNvcmUvLS9ibG9iLzY1MWMzOGMxYzlkODM3MzMxZmI0YzRhNjhhNGE3NWMyNzE2
M2NlZDYvcmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvcHJlZW1wdC1ydC5jZmcNCg0KS2luZCBy
ZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5k
YXRpb25hbCBUZWNobm9sb2dpZXMNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K

