Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB5C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 06:57:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.11832.1720162648094535982
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 23:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4656vPgi491218; Fri, 5 Jul 2024 15:57:25 +0900
X-Iguazu-Qid: 2rWgqvMjY0rhG8SMFd
X-Iguazu-QSIG: v=2; s=0; t=1720162645; q=2rWgqvMjY0rhG8SMFd; m=Wln1hTS7dZXIB/iSjHE9yClm31qBwSeLffGCL3Fx6YI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4656vNXh3472794
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 15:57:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBYnqvsmQWVtv+sFvloaebxQG1OASagx+7Mc/OM/XQmMmNAjqYORw18Fi+r1MswfTNkcCMg37ar/iiIcFmQYhxuarzh3/kzujltfj4miv9UqI/e1sk8+HcN0xp61TkM259hVY3AE9ulvfHnQRwp9YFp4Fxz/8SZWyC3jLzkSBmJEol8GwBQcplifIEbS1jsD7FN0L0bfoQCe2ZC1gnHLCEAi245IMcwaJ2kXFRA9x86JLC+nEDKmo37KXdrgTMsu/aXkQP680NdjEBBG7M4zhq6861YZiAzKr/YFhKcF1Fgvcmx58rH6+k8OkInbzx+r0vUfa/ToVQbTpdMpXRBdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9B6EirYjpUS4CQT1aowtX5g0blus4ALEANyQmcHiPk=;
 b=Dy+VmtkSp7EgvWoCMyLKpIH4niA5Icu4jUp0ssQhiYeg0qw/i96T5TLfSuODzUDTmstl6g4LquWLP0nevGUnZNj4IAcPrTQdrx4eWpCF0U1cWpQRorYnJJSPvXzSrG43arjzfVlxTFR92ehn8P7oWEBmnp+NDZlx+TOliTA9kozkMCl4pAmS7Xu/Op2KBhmTF47UbSCGKELGWGRueSf/QQyH9FUw0PSH8kPvI7Itt+J6aH92OiZp59+JhpJm9GRsKPEOu8uZ14ovGVuUEJ4PpEqitPxBerOScIbp2uTR8ajJzUxePkLS+WK40fEFQcJtwwMHKOCpQFMbMRiqIbPKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Topic: [cip-dev] [isar-cip-core] Kconfig: Refactor Kconfig options
Thread-Index: AQHazfoVk99fsaMHdE2T5O7XjqyfgbHmXT/QgAC9bYCAAHqNgIAAFUoAgAAG/iA=
Date: Fri, 5 Jul 2024 06:57:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107551C9D25C7CC82540F20EC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
 <TY3PR01MB11075ADF741232B7FD668B5C3C7DE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <434ca8c8-b1c6-4fee-8838-ee052666221b@siemens.com>
 <TY3PR01MB1107571B579722017185157BBC7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
In-Reply-To: <ce96a45d-edbb-4401-842e-93117ab1f9cc@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY3PR01MB11074:EE_
x-ms-office365-filtering-correlation-id: b24d8953-eb80-415d-a90e-08dc9cbfb64f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?THpldFdnY0NOWGcydUtzVHJyVnhXOEJpWEdFNmpheUNycjZGWmFqSThWYlM4?=
 =?utf-8?B?cUM2UGxKTkxmZC9Ybmx3SWpRSitROTFjTjlJOEk3dWNWUmMvU3V2ZEpXNWFC?=
 =?utf-8?B?OFgwNUpwZThqNTZZYnA4dXNnR2RHam1jZndMbDVvYXhVZnFkenlNMzBST3FQ?=
 =?utf-8?B?MWlreS9PYWN5dmc0a1lIWjNIZFhiNVRkWU9sLzRkMENtdS9VelNnbXRBTmZw?=
 =?utf-8?B?S2ZiL3R0RWxLbUJaVHpmYW9oY2kwUE40ckpUMktDakZWdlF1bDRSVmNBZUhZ?=
 =?utf-8?B?UjNNNEEvemNmb3lzSXNQREkycW9QVXlWMWZiQXZQZzV4K3F6OUp0M1g5czN4?=
 =?utf-8?B?Y1Rycklrbll2bHZrTmdQOUtzR2NURHFlQ1B4WVZ1SlhBbzVXYml5cTcxaDRk?=
 =?utf-8?B?RzBDMFY5UHJRWS9CZTIyNmVjRVBVWng1VHRuM1BObFdIa3BYUElqaTFiSGNV?=
 =?utf-8?B?UzUwaEk2YWNRUEJOY0xlN0Via05tSytRbVdBV09qbWtzL1MyMVc4L2Y0T0lo?=
 =?utf-8?B?Q3c1YUd3SmlNMkV0NS9CMnNnTENxVkZJaS9JemlHWGV1TkR5Sk8yWFNHMUtO?=
 =?utf-8?B?Yk9nTE5waFVhMTNlcHMrVzNsRzRNZ01VaUxoQXV1Z3cxRnc1SEo5cUlXOXMx?=
 =?utf-8?B?ajNUNlF2WXBBcGNJazFjdEt3cWMyUFpETmVkdmlDYmNsdnRta3BHSHRyT1Rk?=
 =?utf-8?B?L3hDUW0yMXZOVnZCc2kva1hoVFRZN0FBTzhoV0tBb0RwUXBqUzlNbCtwMWly?=
 =?utf-8?B?akI2MnNsMGJJN1ROeFVkMTVMS2didy9Qc2NHNm5hWmhxdW1wWHgxZ2tZZzR4?=
 =?utf-8?B?SXhma0lwQmp0RDdNeWYyQVJ6ZnlBYWVqb3M0ZUd4QjBEcHJCczZMSTFuUTdz?=
 =?utf-8?B?S21iMUp2bUJPdklXSUpvTmJST1UwaVVwMGxoTnhSQzdUZHVHandPb04rcWlv?=
 =?utf-8?B?RjVucWtHaUJBM093dTJjTlhXMnVaV3U0VHhHdW1XdVVGKzJoUnloS0hEWU0z?=
 =?utf-8?B?T3hxQ0J4WnlSeWZJTXhCcnAvUnB3cGRiNldhN211cElpSldLNVV5MGo4M0w2?=
 =?utf-8?B?YjJ5K3lpTVRQeWVOOEJKenMyRDB2Z2VsRWhJZHJ5NitJWm10bnRGdzhwTHlK?=
 =?utf-8?B?cmhLVXkzODhUUjFIemYrSlRBbHZzV0J3c0w4ZFNDMmNSdE1rY3pyR0pVTFRq?=
 =?utf-8?B?ckFtZ09sazdjTk04cUllQVl1VzZnTzlxendyOGU4U0w2Zi9KWWxQZnIxTFc3?=
 =?utf-8?B?U0hGVnI5TnJKREtDYTQycS9EVG5jRlkwQk9YNU1TZ3lrak9iNjk5TjM0RTg0?=
 =?utf-8?B?YmZsTUVWbUdyaDZZSm9qdU5FMEJweDhpanlqWVh3emF1UmVOZVJwdzZkVTdF?=
 =?utf-8?B?anJOdmZUZU9HZzVpR0U4cTc4OEkzdGMwVFVWeC9oY1V0U1NMbU93U05FN3dL?=
 =?utf-8?B?VFgyK3lmZ2h2MXQ0K0ZRejVhVnhzZGQrTFpBUUpVTkNTYUFpMGY4VkJJVmx5?=
 =?utf-8?B?cmJyVVJUVXR5QlVZdkxQNTBBMUtQSmZsd3I1NXZrelF6aVdCYWJVUStNYTRs?=
 =?utf-8?B?a3FnaFEyZFZRUHNXTEtraTJjZG00cDRJa29CdnNCRXZQTjhZdFVVbUY5WGJJ?=
 =?utf-8?B?L01XbThVU3RKdFovSnRjS0YraUxpQVFuQm9hTDBwdXltemlleFptajA4Nm0w?=
 =?utf-8?B?bDQvWmxsa1IwNzUwb1RyR28vVW5aYk5PMG1KSmUzQ2tsVkp1bDc0SFE2QVF2?=
 =?utf-8?B?R1ZseTUwRDJlWkIvTHhVVk5oV1NTWlprN0o5UFdrelhaeXNFbkRQZkVCYVo3?=
 =?utf-8?B?QnM1c0pOS283WWlZTElnb2pMbkh0REQzWVZwdTlOblhJV1hHRnpTbENRYnlo?=
 =?utf-8?B?OXoxRlhpN3ZFKzJyNUFiNnZOVi9ZTkw0MCtiTVkvMkhPQ1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlRidTBZcnVDaGlpRHowQjZWMWZPV3NmLzhnS2UxR3JQNHVubDhrZ1ZQdjg2?=
 =?utf-8?B?bFI0NnpobkZoa3Q0QjVtS2ZGK0ZMNmNIcTZDa3pWWmtsQ1hZcCt0ajJhVjl2?=
 =?utf-8?B?RGVGVkJ3NnN0UU0xUyt2MG5iZDFxUlhHVFRMdVZHcjd5REh5aytGd1NQeUVk?=
 =?utf-8?B?SUlrNnlsVFNOSjFFdTVJWVhFQjROV3d2aU55NWxsSkl1blh3ZW5hTGxuODB0?=
 =?utf-8?B?N1phMTlKbDNSRHpsSWNhcTk2b21Lcjc3SDBOVE1OeE1mc1ROVjBWcW5uV1hH?=
 =?utf-8?B?Wjh2NEN2WjQ0RWVDd1ZIVGthOUZnZURqZnpabUVZQ0x3Z3lIY25iRy9ZNGNr?=
 =?utf-8?B?WVcwVVFZS0NFQkVEV24vbHlpdVZkTVdzZWpUbytoQzhuNWl3TVJqQkg5Y016?=
 =?utf-8?B?TW5QZXFUTGZ5SDRla3E5NXBIblRMVlcvUW1zdU1OUVdTOFlaMXgyN3g3eWQx?=
 =?utf-8?B?S3dRZ3JWT0dHZXZTSDA1OEcyUkR2OWJHRzFtNlJzSmlUTmh1ZDV0TUcwejhM?=
 =?utf-8?B?QXJCMGRLWmpFUUYzM1VTS0JtalRya3lJcTBEdEZweHB1Z0x5S1FqODlmMjc4?=
 =?utf-8?B?WnZ3TEVodnViM29ySC9oZDNZWTNmM3U4cHIxcW1pYjBISkNWbzZwYzZqd0k5?=
 =?utf-8?B?aUYxb2JFcXpEYTNHR2V4NFdRWDgrbE12VHlEdGVZT2lKTlNCTGYrTnN5UmlO?=
 =?utf-8?B?dHNaMjVWZmllRWRQelRZaTF3cGtNZ2JlK1pMYjJSWFd3U1JWN0xNTFRNYXUv?=
 =?utf-8?B?TWlaT1hGdzAvQk1zNUYxbjJMZXNaQzFFZGNwSDJTOEd0NnJrdWk4K3JMQXJq?=
 =?utf-8?B?SjlkcEFYRGhrV0tRRVZTTXhYT2gxZ3VPb0RPTy9uTWZ3UGFxek53ODRxS1VJ?=
 =?utf-8?B?Ykk2cXlZNU1xNXZPY21qUCtrUUtyQlJXaER5VnZOak5ic29Hend2S01LZUF0?=
 =?utf-8?B?VzR1ODVjTmdWSkl3Z2ErbGprWmxrSzk3bjA2N3hvb1RKdHdFUEpSVVQzLzFZ?=
 =?utf-8?B?TVNmTC9CNGU1SVYvU3RKR0xqckFkdVRPY29iSjlib1FCK1JiMmhoMjRnMlVu?=
 =?utf-8?B?eUpwUCtUaUpyNk9kVXJUZmd0WDNXaDVYenN0dXRNM0d0ZEwyb08yZ2dWN2hk?=
 =?utf-8?B?VElYb1BFMnV1MHRZT0t4RTkxeHBRcS9nWHRzdTkvK3FWemxabXFJN0YxUFFj?=
 =?utf-8?B?ZmtNMW9KTmpkQnkyVXBob0xvL1RNYXFYSGtsN20raVU1a2VtbjlZQTdJenZs?=
 =?utf-8?B?MldORURMY0N1WHNoUW9ZRUFNR1JEQUF5cjNvQ1VyZTZ6SVZVNzVtcFd4Y0ha?=
 =?utf-8?B?OW5vOGY2YWVWM3F2V1Jqc2R5RDVxK1ZuTUVmVHlTL3NzdnEwNi9mbk16ellC?=
 =?utf-8?B?Ly93eHNmWG5tSEZsejUzYU1qYTJtY2ZncjBRZHVEMjRxVTB5c1V0QVpkLzJj?=
 =?utf-8?B?YUEzRUVVNklsN2I1WmNlU1htTFBNUVpyMThURnY0d2tyOVJlcHBRMzEyaWh2?=
 =?utf-8?B?VXNReFdOSjV0VmNLaCsyWmkraE1KZzk3RUllVTZDSEJScENiQ0Z5MTVQVUVP?=
 =?utf-8?B?V2ZMdjlwNWVBMDZiQ0dIWUNDNWJGTkdLaFcxMUd1VDFtR20xV0lmeUdsbkhH?=
 =?utf-8?B?OUFFVWFZaTE3MXpSelE0clVlK0hGSXoxY2lvYjZCWDBSYThZZGVWSlBKVmsy?=
 =?utf-8?B?NklFUjFKa2V6V3owRFA1WWxXWnhzaHJaQWlTQkhhaW9uVUVpTGlLOWRLVlV5?=
 =?utf-8?B?RWRnamIvVEpraE83L21CM0Q1RUxpMkZ1VWx2b2ROaWpFekZnRmpKQ1l6UWFG?=
 =?utf-8?B?bzJiQW5nelJDSUxvVU5IOHZBNnJ0aTdPcjM5MmZmeHJSa3AxZk1LNzc2Z2Fy?=
 =?utf-8?B?bzllSXNGeVc5QU5Tc1NmZlpJMUJRR2VwU3UxZFZDTzZNVXRpMk9oK000Znp1?=
 =?utf-8?B?bkc2SGQzMTB5UmVkbEtHekRJb3QxWkZEWm82RlBwVE9JNHlORlNFUXVZQ05C?=
 =?utf-8?B?WjRkaHNNYzJNaHFrcXBtenlPcFhHUnNVWjJJVWFuVVRxZFJ2cjljSE56NUNy?=
 =?utf-8?B?UVdXM254SWgyeTJ2dWFWcjZ4QTJwMWF5ZVhSeC9CYW1JS2M2TzB3dVBWb1Va?=
 =?utf-8?B?UThMakZjY3grWHVDMytTQy9NbG95SFFqQkpodkZpdGVuT1NsR3NBZEhJUVZT?=
 =?utf-8?B?dXllaGUyckZ4U0RxVkNZRjBVS1FmalJwZGpkNDhVU3VEQldWVENYTllCcGNl?=
 =?utf-8?Q?L+Kxv34XCjr4DN6uDiPzTguJE7p3ZIdEurrJtoJizE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d8953-eb80-415d-a90e-08dc9cbfb64f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 06:57:19.0697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/ikFmzWLr+5pizg4cXFhm9mWK1SIhsUYzaslDgcIj2ZYrYBp27sg5G/UazsfBA+mixS1fF7FQvgQfxPAB8mWVuRBxeFTwGirdkvbyvhf9wezh3Gy8r5bskmAtL+Rmy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11074
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 06:57:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16380

SGkgSmFuLCANCg0KPiBUaGlzIGlzIGJ5IGRlc2lnbjogV2UgZG8gbm90IHN1cHBvcnQgc2VjdXJl
IGJvb3Qgd2l0aG91dCBTV1VwZGF0ZS4gV2hpbGUgaXMgdGVjaG5pY2FsbHkgcG9zc2libGUsIG91
ciByZWNpcGVzIGFuZCBjb25mIGZpbGVzIGFyZSBub3QgcHJlcGFydGVkIGZvciB0aGF0LiBUaGVy
ZWZvcmUsIHlvdSBoYXZlIHRvIHNlbGVjdCBTV1VwZGF0ZSBmaXJzdCBiZWZvcmUgYmVpbmcgYWJs
ZSB0byBjaG9vc2UgYWxzbyBTZWN1cmUgQm9vdC4gDQoNCk9rLCB0aGFua3MuIEl0IGlzIGNsZWFy
IG5vdyB3aHkgc2VjdXJlIGJvb3Qgb3B0aW9uIGlzIG5vdCBzaG93aW5nIGluIEtjb25maWcgbWVu
dSBieSBkZWZhdWx0LiAgICANCg0KPiBPaywgaXQncyBnZXR0aW5nIGNsZWFyZXI6IGthcy9vcHQv
c2VjdXJpdHkueW1sIGluY2x1ZGVzIGthcy9vcHQvZWJnLXNlY3VyZS1ib290LXNuYWtlb2lsLnlt
bCwgdGh1cyBhbHJlYWR5IGVuZm9yY2VzIHNlY3VyZSBib290IHdoaWxlIA0KPiB0aGUga2NvbmZp
ZyBtZW51IHN1Z2dlc3RzIHRoYXQgaXQgY2FuIGJlIGRpc2FibGVkIGFzIHdlbGwuIFRoYXQgc2hv
dWxkIGJlIGZpeGVkIHZpc3VhbGx5IGJ5IHNlbGVjdGluZyBzZWN1cmUgYm9vdCBpbiBLY29uZmln
Lg0KDQo+IE5vdywgaWYgeW91IGVuYWJsZSAob3Igc2VsZWN0KSBzZWN1cmUgYm9vdCBmb3IgdGhl
IHNlY3VyaXR5IGltYWdlLCB5b3UgaW5jbHVkZSBrYXMvb3B0L2ViZy1zZWN1cmUtYm9vdC1zbmFr
ZW9pbC55bWwgKGFuZCANCj4ga2FzL29wdC9zd3VwZGF0ZS55bWwgYXMgd2VsbCBhcyBrYXMvb3B0
L3N3dXBkYXRlLnltbCkgb25jZSBhZ2Fpbi4gVGhpcyBsb29rcyByZWR1bmRhbnQgYnV0IGlzIGFj
dHVhbGx5IGhhcm1sZXNzIGJlY2F1c2UgdGhlIA0KPiBzdGF0ZW1lbnRzIGluIHRob3NlIGthcyBm
aWxlcyBhcmUgYXV0b21hdGljYWxseSBkZS1kdXBsaWNhdGVkIGJ5IGthcy4gSnVzdCBjaGVjayB0
aGUgZWZmZWN0aXZlIGJ1aWxkL2NvbmYvbG9jYWwuY29uZi4NCg0KVW5kZXJzdG9vZCwgdGhlbiB0
aGVyZSBpcyBubyBpc3N1ZSBpZiBpdCBpbmNsdWRlcyByZWR1bmRhbnQgeW1sIGZpbGVzIGFzIGl0
IHdpbGwgYmUgaGFuZGxlZCBieSBrYXMuIA0KDQpZb3UgY2FuIGlnbm9yZSB0aGUgcGF0Y2gsIHNv
cnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gICAgDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZh
bmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDI0IDExOjQ5
IEFNDQpUbzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRp
bmcpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RH
IFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhp
cm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw
77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lw
LWRldl0gW2lzYXItY2lwLWNvcmVdIEtjb25maWc6IFJlZmFjdG9yIEtjb25maWcgb3B0aW9ucw0K
DQpPbiAwNS4wNy4yNCAwODowNiwgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29t
IHdyb3RlOg0KPiBIaSBKYW4sDQo+IA0KPiBMZXQgbWUgZXhwbGFpbiBpdCB0aHJvdWdoIHRoZSBw
aWN0dXJlcy4gVGhlc2UgcGljdHVyZXMgdGFrZW4gb24gdGhlIA0KPiBuZXh0IGJyYW5jaCAoY29t
bWl0OiA1MDdhNmE3MGE3MjQ0YTY0NjE2NWMxMDUxNjY4Yjg1NWFlZWU5YjVmKQ0KPiANCj4gSW4g
cGljLTEucG5nLCBJIGRvbid0IHNlZSBTZWN1cmUgYm9vdCBvcHRpb24gdW5kZXIgSW1hZ2UgZmVh
dHVyZXMgdW50aWwgSSBjbGljayBvbiBTZWN1cml0eSBleHRlbnNpb25zLiANCj4gDQoNClRoaXMg
aXMgYnkgZGVzaWduOiBXZSBkbyBub3Qgc3VwcG9ydCBzZWN1cmUgYm9vdCB3aXRob3V0IFNXVXBk
YXRlLiBXaGlsZSBpcyB0ZWNobmljYWxseSBwb3NzaWJsZSwgb3VyIHJlY2lwZXMgYW5kIGNvbmYg
ZmlsZXMgYXJlIG5vdCBwcmVwYXJ0ZWQgZm9yIHRoYXQuIFRoZXJlZm9yZSwgeW91IGhhdmUgdG8g
c2VsZWN0IFNXVXBkYXRlIGZpcnN0IGJlZm9yZSBiZWluZyBhYmxlIHRvIGNob29zZSBhbHNvIFNl
Y3VyZSBCb290Lg0KDQo+IEluIHBpYy0yLnBuZywgU2VjdXJpdHkgZXh0ZW5zaW9ucyBpcyBjaGVj
a2VkIHNvIFNXVXBkYXRlIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBidXQgbm90IFNlY3VyZSBib290
LiBBIHVzZXIgbWF5IHRoaW5rIGhlcmUgb25seSBTV1VwZGF0ZSBpcyBlbmFibGVkIGluIHNlY3Vy
aXR5IGltYWdlLiBJIHVuZGVyc3RhbmQgdGhhdCBpbnRlcm5hbGx5IGl0IGlzIGluY2x1ZGluZyAi
ZWJnLXNlY3VyZS1ib290LXNuYWtlb2lsLnltbCIgdG8gZW5hYmxlIHNlY3VyZSBib290IGZvciBz
ZWN1cml0eSBpbWFnZS4gVGhlcmUgaXMgbm8gaXNzdWUgaW4gYnVpbGQgcGFydChJIG1lYW4gcHJv
cGVyIC55bWwncyBhcmUgZ2V0dGluZyBpbmNsdWRlZCBmb3Igc2VjdXJpdHkgaW1hZ2UpLiAgDQo+
ICANCg0KT2ssIGl0J3MgZ2V0dGluZyBjbGVhcmVyOiBrYXMvb3B0L3NlY3VyaXR5LnltbCBpbmNs
dWRlcyBrYXMvb3B0L2ViZy1zZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwsIHRodXMgYWxyZWFkeSBl
bmZvcmNlcyBzZWN1cmUgYm9vdCB3aGlsZSB0aGUga2NvbmZpZyBtZW51IHN1Z2dlc3RzIHRoYXQg
aXQgY2FuIGJlIGRpc2FibGVkIGFzIHdlbGwuIFRoYXQgc2hvdWxkIGJlIGZpeGVkIHZpc3VhbGx5
IGJ5IHNlbGVjdGluZyBzZWN1cmUgYm9vdCBpbiBLY29uZmlnLg0KDQpOb3csIGlmIHlvdSBlbmFi
bGUgKG9yIHNlbGVjdCkgc2VjdXJlIGJvb3QgZm9yIHRoZSBzZWN1cml0eSBpbWFnZSwgeW91IGlu
Y2x1ZGUga2FzL29wdC9lYmctc2VjdXJlLWJvb3Qtc25ha2VvaWwueW1sIChhbmQga2FzL29wdC9z
d3VwZGF0ZS55bWwgYXMgd2VsbCBhcyBrYXMvb3B0L3N3dXBkYXRlLnltbCkgb25jZSBhZ2Fpbi4g
VGhpcyBsb29rcyByZWR1bmRhbnQgYnV0IGlzIGFjdHVhbGx5IGhhcm1sZXNzIGJlY2F1c2UgdGhl
IHN0YXRlbWVudHMgaW4gdGhvc2Uga2FzIGZpbGVzIGFyZSBhdXRvbWF0aWNhbGx5IGRlLWR1cGxp
Y2F0ZWQgYnkga2FzLiBKdXN0IGNoZWNrIHRoZSBlZmZlY3RpdmUgYnVpbGQvY29uZi9sb2NhbC5j
b25mLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBD
ZW50ZXINCg==


