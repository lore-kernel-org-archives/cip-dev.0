Received: from esa.hc514-86.ap.iphmx.com (esa.hc514-86.ap.iphmx.com [207.54.83.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35812.1795582084054550828
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 20:48:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hitachi.com header.s=hitachi-com-20240118 header.b=jsHlxOVE;
 spf=pass (domain: hitachi.com, ip: 207.54.83.18, mailfrom: takuo.koguchi.sw@hitachi.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hitachi.com; i=@hitachi.com; q=dns/txt;
  s=hitachi-com-20240118; t=1795582084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uQbTwrPRHPCyPWJri+bYLYGxjYp1ynP63rTgcCQLz00=;
  b=jsHlxOVE21PcGnJuHDhMJ8sZ7fqjCjOoqNNQXnssodZ+4kjkoa/mnkVR
   OwYeM9u/vkj8J++emUqnHuKVlj2yDKTcgvxzdyp52VAWS9DNnUICNljGY
   Z6eIQTY0eKlVlGalhETWQj2q5lLvutzVS9tq4dMG9R+y5tTIJ16vsOWeB
   k=;
X-CSE-ConnectionGUID: dkEplKKoSYylBpYr85SMwQ==
X-CSE-MsgGUID: G4cX4PfbQI6W8u2msKtaLw==
X-IronPort-AV: E=Sophos;i="6.27,232,1787011200"; 
   d="scan'208";a="538852986"
Received: from unknown (HELO mlsv1.hitachi.co.jp) ([20.18.96.97])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Nov 2026 04:48:00 +0000
Received: from mfgw14.hitachi.co.jp (unknown [10.178.97.251])
	by mlsv1.hitachi.co.jp (Postfix) with ESMTP id 5796F404BC2;
	Wed, 25 Nov 2026 13:47:59 +0900 (JST)
Received: from mrelays03.hybrid.go365.ext.hitachi.co.jp ([133.144.234.40])
	by mfgw14.hitachi.co.jp with ESMTP
	id W4vHxqcjZ1bn9W4vHxUydG; Wed, 25 Nov 2026 13:47:59 +0900
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011050.outbound.protection.outlook.com [40.107.74.50])
	by mrelays03.hybrid.go365.ext.hitachi.co.jp (Postfix) with ESMTPS id 2F15B113F3CB;
	Wed, 25 Nov 2026 13:47:59 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk0xlIlqmAH5esa2RRl9TTEh7AP0fBcacqY62LQs+zgKHye5GeVKU9IMHgBo0C8uBzKs/wa96hx7oaWNFpheY20djYnQ4UVm3Y6oAtTROkQwU/5OiLJTT8qjNUK3ZeRGSfSiSWgRAgaxRcIDvpTRDxaUKyKCOAQegoZ0P7tZlkuou7xbtcUwHAhBwwgO38lNl8b5rJ9EwxzXAFQwaM7bH4lcZHE5tFBMzH8Wqh34Qb6mteqUcw7rDqppY1bIk+lHDhTudEMedipJvRoDd5ZH4tPapMBsM0v7uPP1A06C5FCOIBWYqRB2q4VqwcJQtyOX1pNXjw9qU9hDay71sj4Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQbTwrPRHPCyPWJri+bYLYGxjYp1ynP63rTgcCQLz00=;
 b=F6Hf7cT4LW+7XnXNmYreChgYTUsFFkq0nD5fJvHco6i9pPoc6mwSHUKAXGM2uwiiSejpuATppONaLGN26249L11wmlVxwxgU4cFkFkhbhTkvXNuaPiFDl/RMu86XIDSyFKr0yIqkEdAsUlETtWmXK6H/C1U3CvO1vY75dqBND22o1/BETczXqMijsRip5fh+AcKpUpG4XocOM+gfuly3dl5SbEYUVvO+freSnYobD5kGLmzbqYGlWfMY52AGNF2C2ngnzRObs9X9mAoGypj8Cz8IWZEc3vECJoUNEdWipZPmPPnc3si1tf8ou0wkR7aNK2stI3jvH1qnmQ/RNeUrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 (2603:1096:604:332::14) by OS3PR01MB9961.jpnprd01.prod.outlook.com
 (2603:1096:604:1de::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 04:47:56 +0000
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299]) by OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 04:47:56 +0000
From: =?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=
	<takuo.koguchi.sw@hitachi.com>
To: 'Takuo Koguchi' <takuo.koguchi@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
Thread-Topic: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
Thread-Index: AQHdfJcrP3lhT0mi/UO5OjEAqOtuDbc+NiVQ
Date: Wed, 25 Nov 2026 04:47:54 +0000
Deferred-Delivery: Wed, 25 Nov 2026 04:49:00 +0000
Message-ID: <OSCPR01MB134491F796D1F30432D1990C2D7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
In-Reply-To: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13449:EE_|OS3PR01MB9961:EE_
x-ms-office365-filtering-correlation-id: 276f83c6-20f3-4218-fcf1-08df4aaf4611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: JSBa19+bTuLARnry8ua0ypqZA3vXnInlUUEhLolBNgW6Rtv3wUPzPLveCAxaWv7WH+aS4cwPD5GAMo6ePPNMmzK8nOEDVOMjjy1AGFn8XZIOQUwpawxHAetZUmdLNyuHZpmnXNrJ13Dy/mU1A3o5htbwYlqDqLmSCPDVnzHWs7HJtNJZX3ndsg6IW4wBkQ6EvPp/OrgB3sm6i45q9EeqRHBbZCuagrSFwN8AUDUeMyoUdWLf01FY7I+VzlWZOnKqVLFHu+w+KFk5NVI3DddE0cbzR2tXy7q81chQyYW+K1H5I4ZDFn3rRUxuPQNyrU9tQwgnh/iIbwUMnmxbM3VlMQmsbsTViAcYJsSzRjVQfkiKRwhn3YQU4HFSuAhaK+m8RGnWJf1iObH33EYbjoAkyWB8gAuKHbAmTuCzxNpyEGuuleExItapNHJHW5vuB3e2qt6SuOBhoVhmpJbLqU3OLKZ2pVblXCA3/HhO5DKI9D8FH9orZWEqwMfdePmT3i5423LX7qI91Aq286Q6ooBzidRM47jhzth7r0w7FcnDrvPM7ARnyFfHA59tapeP5Fs53Q7uTlBkYxB+MhDQ4IcCLD/JxT9EXqTFDEJFewuczbdmdwpOxdtJkTQgVuatolmd+Y/LPr8OxYDr6b3QUZNKWVODn2w6ss58dpWpENpaxiCPH4T1AioxFYULoB5EJ69AJuKo8HeFClIFcfh1agFVHmfqp+zyvtzkAN1VLYDmPvE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13449.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2pXMXRUTjBIbVpIemQzaXgveUtWV2doVVRYY2pRaDlhajEyTHRrOWtlZUVw?=
 =?utf-8?B?cG5KOXV3cGdRcnUvTE83anlZOFYxazI0blBmLzB5dEpiQ09TQ2JuMG4wbTVB?=
 =?utf-8?B?eFRKTlQyWlBEMkozWXBmRkZEbU13VXE4R3V0bWdmOVR6bUc3MCt5M21Cb2Mx?=
 =?utf-8?B?aTdGTjVkN3EyeklkM1BHSjQzM0ZRTDdGdlAxMlBoWnFRRWtjN1RiWnRja0xE?=
 =?utf-8?B?Tm1XQVp1dk03VVdYazdPUllRVldxdWlGYmdiYVRjeGNCK3gwT1VPa3BaU2RL?=
 =?utf-8?B?eEc4b0RkVkR4dEQyYWRFSU5uRlZER21UOTJzN05vZWhOMHhGbVBmdUsrQVlr?=
 =?utf-8?B?Qk81UHdIb1dudXhSNVNMeVczSHMxL0NNVStGbmRYVWlvcGt6SUN3TmFadHJx?=
 =?utf-8?B?UjJGckg3akVnUG1SUjBJL05nOTc5b0ZKbVNDeEJsRi9pV1RTTmtZUjNlM1h4?=
 =?utf-8?B?VEdaNk43WEVaSG5CNjZLNzFKMVJsZHUycGc4dWNiT3JGZE1zQllNRyt6WVFw?=
 =?utf-8?B?WlY2TzdaZDh1NHFwVHBUcERJNXhBU1RIbG40L2wrTFVoS3ppSFd0UGRqZHox?=
 =?utf-8?B?cklCOHVDbEZPeEpuazJiMlJWN216OEV6OGtCQWxNTzlzanFONlN1OWxINXlv?=
 =?utf-8?B?SHkxSkh6V2FMY2xOT3kxUFpjdWtFSzlsdzUvbERWVXhBRThCQjZybXJHT21t?=
 =?utf-8?B?bzBrYllRcEpMRWxvUWx0a3BjSFJoazdaNDZucUhsellJbzhtdmp1MjlVNHpv?=
 =?utf-8?B?Q0pnTitJcnQwV1ZlQ1dHeTZRR0pJZzljbE1kUGRjcmphV2NHemRPYkY4WkMv?=
 =?utf-8?B?RWhEYmhSdUZKeXNtZW9WRGMyMmM0UjFyVk12QUhFYk9ZbXU3QlNiZTlwNlV2?=
 =?utf-8?B?MTBrRzV2bGlONlhSbU5nRWdSWFBUV2tCbjF4R3ByL0EvSU1TWmpsL1JjWHNB?=
 =?utf-8?B?SS9lZkN0b0NscThTNVNQcmhRK0t4Z1VtU3M2SmhSWHpoazVvaFZVbU1ibHBn?=
 =?utf-8?B?emRUL2x1eW5RMGdlU2hidndLSk4ya2FGK2ROSVM3VGhCeVUrMVBMTkw3YjJR?=
 =?utf-8?B?QmlmSWlNM040TmR5akpvUTRBMzEySkJ6NjR0USt5UWRqUzM1TmltUHVabHhV?=
 =?utf-8?B?ZDdwcWxkNlVZblhyWURHejlEK2FHOWpPNlpyTUN3TklpUFNVUURaZ3hQMHlT?=
 =?utf-8?B?TlJhZHNiYnRnRjdWd3gwSEhEQ1BsVXd3a0Fld0NlSmxOeTY1Zm1Kam42WGhV?=
 =?utf-8?B?V3lma0czdU9HT1NHRFlyanZkR3F1SlN3aTdpVVRxaXhGR0UwNXZOOGRjUDMz?=
 =?utf-8?B?QmgxUldXSjViaDVuQmxGYlk2YjhueDFGTWF2MU5UdG40S1VzVHloU0t6bWxL?=
 =?utf-8?B?ZG1wcklVTmN3Tm9BVGhYbDdvQnBPZlhTZStZM2JIMTQ4MGk1dEZvNU9OVWZ5?=
 =?utf-8?B?YUtsdjFHR2NCTHB2NnpFRnNseU1RS1p6NkVHejlMZEx0NXlHWXBDQjhmRDFI?=
 =?utf-8?B?RjBFTGg0Nk5TQVYrSXI1UkR4MnhCN2FTV3pVa1lXdncxd1N6WnB3VzBPdzl1?=
 =?utf-8?B?VzFzVUVNNkFvRElDUnpoV1gwYzlldW1SSUo3SnBjeU9sLzJPNUVBdFF2THUx?=
 =?utf-8?B?L25YZjJZWk5ITVZ3b0QrQjdTTk5wV2VMak10aFlBNlA1cUU1Vm9mMUk0Y1Bq?=
 =?utf-8?B?UmV3S0dxckNtVHRVdEhscFlZQTdsTU5YcXNBV3UxdEtCRnBLVmlmcnVyZDNI?=
 =?utf-8?B?OXhhUUNza2RGSy9IdUdwUmVvbjBDeW5LUDBjdFl3OFBZcEN6Z0w5YzhBUS9I?=
 =?utf-8?B?Z0xiVnkyZ3dLSnU0NStxTGt6dEJETkNuMWxuS05yNEtpdHNUSWtFVDR4L3Js?=
 =?utf-8?B?eEU5RFNBNGpodm5XSWhDZFUxUFBjN0phNFgrejNHUVZKTDZ2dCt0N09IakVU?=
 =?utf-8?B?VFY5RmdqL3VLYWx0UDhhSDB2Vm04TmdtVy9UL2dDMnBSKzhIb0FBdjNmMHd6?=
 =?utf-8?B?UzBqcHV6K2dkdjNqbjk4ZFoyUG91UXk1ckFIZDFpTHVQYUJDRkcrbExkUGZW?=
 =?utf-8?B?UkZselYrbmhKcHlhU00weFEzdGg2MGlYM21BTk16ajQyaEl0WHdEWmlVSVpB?=
 =?utf-8?B?TUsrczgrdCs0c3hzN21JZ3lmTmRncDBBZ0NYNGQrTEJMZGRzZ0cwTHQ5c3ZR?=
 =?utf-8?B?Um9GUHEwM1JrTVpZM2xUbXMySG9ZbWQ2NDU5VmFocTlLdmo4MlBIb25YNTZv?=
 =?utf-8?B?ei9mMS9EVjM2VzRLQUdSbm1oUS9hVURqUFhFMnVGUlV1VE02Ujd2amc2bk94?=
 =?utf-8?B?d05qSHk5bmc2Z1V3RmJ2UFRHclhTS2JBYjVLRUE0Wmp3eTFlMkkvTUY5bDlX?=
 =?utf-8?Q?8O4d4x9RsH8kwmjg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q/JOh04Cr8M2FlntCr9szU5DGXm5jgdioOCgpsD0IvrH6Oq5kr/eUdRd5YzokY+lD8JUZUjvLRA6zomNTElXgDTJqSpXZtbkAZFDUwLPIA9nacVFY67K9lPuewMZobLWfGeoFvYwgxh2bN6leXt7To5ziB5kAYTyhGmD7Eyj4rxCCsRL8exUNg4Vj9ocUNPKvoWxCqkVTSaD1o3LbBS/bxVaLZrEfvlPXiaNegzBhYDoITjyJnDoEwbSnLfMTUuBRc6sdYvn4ngbQzFRS9ljI2K756DANgFEdmd9VhUhKv9kVqJbY2gxW7sfv3GHoBCgamAVQHWMPfwP9sgpV3orFw==
X-OriginatorOrg: hitachi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f83c6-20f3-4218-fcf1-08df4aaf4611
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 04:47:56.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cOp+Wd2IbMMUF561/AflUlr/i9D/zn6bWunxiNYtifJxyfWk769V19l88k0Dfj2UdNQNSPiPxXhwiyBEogaax5TWibyHw8JHC/3nstZsDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9961
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 04:48:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25067

VGhpcyBwYXRjaCBpcyBtZWFudCB0byBiZSBhcHBsaWVkIGZvciBsaW51eC00LjQueS1jaXAoLXJ0
KSBvbmx5Lg0KDQpUYWt1byANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBUYWt1byBLb2d1Y2hpIDx0YWt1by5rb2d1Y2hpQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBOb3ZlbWJlciAyNSwgMjAyNiAxOjM5IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KPiBDYzogcm9zdGVkdEBnb29kbWlzLm9yZzsg5bCP5Y+j55Ci5aSrIC8gS09H
VUNISe+8jFRBS1VPDQo+IDx0YWt1by5rb2d1Y2hpLnN3QGhpdGFjaGkuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0hdIG1lbWNvbnRyb2w6IHByb3RlY3QgZHJhaW5fbG9jYWxfc3RvY2soKSB3aXRoIGdl
dF9jcHVfdmFyKCkNCj4gDQo+IE9uIFBSRUVNUFRfUlQsIGRyYWluX2xvY2FsX3N0b2NrKCkgYWNj
ZXNzZXMgdGhlIHBlci1jcHUgbWVtY2dfc3RvY2sgdmlhDQo+IHRoaXNfY3B1X3B0cigpIHdpdGhv
dXQgZGlzYWJsaW5nIHByZWVtcHRpb24uDQo+IA0KPiBBY2Nlc3NlcyB0byBtZW1jZ19zdG9jayBm
cm9tIGNvbnN1bWVfc3RvY2soKSBhbmQgcmVmaWxsX3N0b2NrKCkgYXJlIGFscmVhZHkNCj4gc2Vy
aWFsaXplZCB1c2luZyBnZXRfY3B1X3ZhcigpL3B1dF9jcHVfdmFyKCkuIEhvd2V2ZXIsDQo+IGRy
YWluX2xvY2FsX3N0b2NrKCkgc3RpbGwgYWNjZXNzZXMgdGhlIHNhbWUgcGVyLWNwdSBzdGF0ZSB3
aXRob3V0IGVxdWl2YWxlbnQNCj4gcHJvdGVjdGlvbi4NCj4gDQo+IEFzIGEgcmVzdWx0LCBkcmFp
bl9sb2NhbF9zdG9jaygpIG1heSBiZSBwcmVlbXB0ZWQgd2hpbGUgb3BlcmF0aW5nIG9uDQo+IG1l
bWNnX3N0b2NrLCBhbGxvd2luZyBhbm90aGVyIHRhc2sgcnVubmluZyBvbiB0aGUgc2FtZSBDUFUg
dG8gb2JzZXJ2ZSBvcg0KPiBtb2RpZnkgdGhlIHNhbWUgcGVyLWNwdSBzdG9jayBjb25jdXJyZW50
bHkuIFRoaXMgbWF5IHJlc3VsdCBpbiBpbmNvbnNpc3RlbnQNCj4gdXBkYXRlcyBvZiBjYWNoZWQg
Y2hhcmdlcyBhbmQgc3RvY2sgY291bnRzLg0KPiANCj4gRmFpbHVyZXMgd2VyZSBvYnNlcnZlZCBh
cyBkaXZlcmdlbmNlIGJldHdlZW4gbWVtY2cgYWNjb3VudGluZyBhbmQgYWN0dWFsDQo+IG1lbW9y
eSBjb25zdW1wdGlvbi4gVGhlIGRpdmVyZ2VuY2Ugb2NjdXJyZWQgaW4gYm90aCBwb3NpdGl2ZSBh
bmQgbmVnYXRpdmUNCj4gZGlyZWN0aW9ucywgaW5kaWNhdGluZyBjb3JydXB0aW9uIG9mIGFjY291
bnRpbmcgc3RhdGUgcmF0aGVyIHRoYW4gYSBzaW1wbGUgY2hhcmdlDQo+IGxlYWsuDQo+IA0KPiBV
bmRlciBzdHJlc3MgdGVzdGluZywgdGhlIGFjY291bnRpbmcgZGl2ZXJnZW5jZSB3YXMgcmVwcm9k
dWNpYmxlIGFuZCB3YXMNCj4gZnJlcXVlbnRseSBhY2NvbXBhbmllZCBieSBvb3BzIHN0b3Jtcy4g
UHJvdGVjdGluZw0KPiBkcmFpbl9sb2NhbF9zdG9jaygpIHdpdGggZ2V0X2NwdV92YXIoKS9wdXRf
Y3B1X3ZhcigpIGVsaW1pbmF0ZWQgdGhlIGFjY291bnRpbmcNCj4gZGl2ZXJnZW5jZSBhbmQgdGhl
IGFzc29jaWF0ZWQgc3RhYmlsaXR5IGlzc3Vlcy4NCj4gDQo+IFVzZSBnZXRfY3B1X3ZhcigpL3B1
dF9jcHVfdmFyKCkgaW4gZHJhaW5fbG9jYWxfc3RvY2soKSB0byBzZXJpYWxpemUgYWNjZXNzZXMg
dG8NCj4gdGhlIHBlci1jcHUgbWVtY2cgc3RvY2sgYW5kIG1ha2UgaXRzIHByb3RlY3Rpb24gY29u
c2lzdGVudCB3aXRoIHRoZSBvdGhlcg0KPiBtZW1jZyBzdG9jayB1c2Vycy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFRha3VvIEtvZ3VjaGkgPHRha3VvLmtvZ3VjaGkuc3dAaGl0YWNoaS5jb20+DQo+
IC0tLQ0KPiAgbW0vbWVtY29udHJvbC5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbW0vbWVtY29udHJvbC5jIGIvbW0vbWVtY29udHJvbC5jIGluZGV4DQo+IGY5ZDgwOTUyNzIz
Yy4uOWIyOThjZTEwYTdhIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1jb250cm9sLmMNCj4gKysrIGIv
bW0vbWVtY29udHJvbC5jDQo+IEBAIC0xOTMzLDE0ICsxOTMzLDIxIEBAIHN0YXRpYyB2b2lkIGRy
YWluX3N0b2NrKHN0cnVjdCBtZW1jZ19zdG9ja19wY3ANCj4gKnN0b2NrKSAgfQ0KPiANCj4gIC8q
DQo+IC0gKiBUaGlzIG11c3QgYmUgY2FsbGVkIHVuZGVyIHByZWVtcHQgZGlzYWJsZWQgb3IgbXVz
dCBiZSBjYWxsZWQgYnkNCj4gLSAqIGEgdGhyZWFkIHdoaWNoIGlzIHBpbm5lZCB0byBsb2NhbCBj
cHUuDQo+ICsgKiBEcmFpbiB0aGlzIGNwdSdzIHN0b2NrLiAgQ2FsbGVkIGRpcmVjdGx5IGJ5IGRy
YWluX2FsbF9zdG9jaygpIGZvcg0KPiArIHRoZQ0KPiArICogbG9jYWwgY3B1IGFuZCBhcyBhIHdv
cmsgaXRlbSBmb3IgdGhlIG90aGVyIGNwdXMuICBQcmVlbXB0aW9uIGlzDQo+ICsgKiBkaXNhYmxl
ZCBoZXJlIGJlY2F1c2UgbmVpdGhlciBjYWxsZXIgZ3VhcmFudGVlcyBpdCBvbiBQUkVFTVBUX1JU
Og0KPiArICogZHJhaW5fYWxsX3N0b2NrKCkgb25seSBob2xkcyBnZXRfY3B1X2xpZ2h0KCksIHdo
aWNoIGlzIGEgcGxhaW4NCj4gKyAqIGJhcnJpZXIoKSB3aXRob3V0IENPTkZJR19TTVAsIGFuZCB0
aGUgd29yayBpdGVtIHJ1bnMgaW4gYQ0KPiArIHByZWVtcHRpYmxlDQo+ICsgKiBrd29ya2VyLiAg
Y29uc3VtZV9zdG9jaygpIGFuZCByZWZpbGxfc3RvY2soKSBydW4gd2l0aCBwcmVlbXB0aW9uDQo+
ICsgKiBkaXNhYmxlZCwgc28gdGhpcyBrZWVwcyBldmVyeSB1c2VyIG9mIHRoZSBwZXItY3B1IHN0
b2NrIHNlcmlhbGl6ZWQuDQo+ICAgKi8NCj4gIHN0YXRpYyB2b2lkIGRyYWluX2xvY2FsX3N0b2Nr
KHN0cnVjdCB3b3JrX3N0cnVjdCAqZHVtbXkpICB7DQo+IC0Jc3RydWN0IG1lbWNnX3N0b2NrX3Bj
cCAqc3RvY2sgPSB0aGlzX2NwdV9wdHIoJm1lbWNnX3N0b2NrKTsNCj4gKwlzdHJ1Y3QgbWVtY2df
c3RvY2tfcGNwICpzdG9jayA9ICZnZXRfY3B1X3ZhcihtZW1jZ19zdG9jayk7DQo+ICsNCj4gIAlk
cmFpbl9zdG9jayhzdG9jayk7DQo+ICAJY2xlYXJfYml0KEZMVVNISU5HX0NBQ0hFRF9DSEFSR0Us
ICZzdG9jay0+ZmxhZ3MpOw0KPiArCXB1dF9jcHVfdmFyKG1lbWNnX3N0b2NrKTsNCj4gIH0NCj4g
DQo+ICAvKg0KPiAtLQ0KPiAyLjM0LjENCg0K
