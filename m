Received: from esa.hc514-86.ap.iphmx.com (esa.hc514-86.ap.iphmx.com [207.54.83.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38234.1795596034326003599
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 00:40:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hitachi.com header.s=hitachi-com-20240118 header.b=RPJavQqb;
 spf=pass (domain: hitachi.com, ip: 207.54.83.18, mailfrom: takuo.koguchi.sw@hitachi.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hitachi.com; i=@hitachi.com; q=dns/txt;
  s=hitachi-com-20240118; t=1795596034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OQeUCSjedN8+tAp3D/UD7rOjTKpXMzMl4AymkTZVUa0=;
  b=RPJavQqbWX4D1imVhn9b1C8wibdnOiHgqV9tspGO10uO9YN8E6BPoMpe
   16mZyIvs4mm408V/wMJDn1uet3P0YFk5CfWnr7gbl9mptgO4raxScCWFJ
   DzSnv06Jjp1I1hxcdXq2/IH6CCWBDxVfP7p4r5WKB7bIwYtdWBvsEx63g
   4=;
X-CSE-ConnectionGUID: mnGNYRtjQymorUQnD8Dp/w==
X-CSE-MsgGUID: MGlW4fHPQiaFSk2bzMrnDQ==
X-IronPort-AV: E=Sophos;i="6.27,232,1787011200"; 
   d="scan'208";a="23413596"
Received: from unknown (HELO mlsv5.hitachi.co.jp) ([20.18.96.97])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Nov 2026 08:40:30 +0000
Received: from mfgw10.hitachi.co.jp (unknown [10.178.97.247])
	by mlsv5.hitachi.co.jp (Postfix) with ESMTP id 1AAE14056F1;
	Wed, 25 Nov 2026 17:40:29 +0900 (JST)
Received: from mrelays02.hybrid.go365.ext.hitachi.co.jp ([133.144.234.40])
	by mfgw10.hitachi.co.jp with ESMTP
	id W8YGxyfeuQV4BW8YGxBHsh; Wed, 25 Nov 2026 17:40:28 +0900
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010003.outbound.protection.outlook.com [52.101.229.3])
	by mrelays02.hybrid.go365.ext.hitachi.co.jp (Postfix) with ESMTPS id E5D5C113E1DE;
	Wed, 25 Nov 2026 17:40:28 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3CRYuKVh+0jV80IHyZCqbQCZ8C68l/uucoQu0RKBu6XrOzveBuLUOJ5Rdxfn8K8OHgwoH/XA/3ZmGro7M8DilN2CGoKkOhWV7WsTbxXQ2bdm8xy4hUfiO05bQOojFJYM6uLs1dJJbNu5ogV+2CYBN96ognJ0qvB/W8hATKoXH3eccPjb4QrcmAC2695pk0IA2yt7u8pKH+HgwhpM7RNgSR7IQJRFA28KHGh5lvR2S+HGv03OqI2Sc4KCcccNPSw6BIFG48iP+5b6n3ugbQKt5Tfj9GRnHvSfmCh/N4oFrPJuFJwckC+5kAzsd3tzbEUnfP3zDdSH1fVSvbQr6TsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQeUCSjedN8+tAp3D/UD7rOjTKpXMzMl4AymkTZVUa0=;
 b=uCn4k9oiyhjokXv79cNNz/KL0RtyTUbyvOhagKhboit2pwpk3dSfHAe1sn61lTTaYfgIYmazwdnolZY3NzYFGY1BnwRcyDGUF2ulapy59N0VfynauMiPj5OANIxpuWurEWcuIuZancs0FZnQHC4Bo6x7Ku0dWHTH+iOi555okUGU33dduvAEcknw0TDqVXovhw9fULi/cOTEdLRvIpVc23Wxe70q6ETvAm9LInq7BdoBi5lCV3cNH56rewXym39yxlUbxqygOAqMIXzzQ6ZWALAT+FeKP4FKxcXJUzPmtSFwGv7PrGqTLDvmHG2Nvsoih33tq2RVPiVdiq0888WWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 (2603:1096:604:332::14) by OS9PR01MB946765.jpnprd01.prod.outlook.com
 (2603:1096:604:511::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 08:40:27 +0000
Received: from OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299]) by OSCPR01MB13449.jpnprd01.prod.outlook.com
 ([fe80::bc0:644d:a51d:8299%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 08:40:27 +0000
From: =?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=
	<takuo.koguchi.sw@hitachi.com>
To: "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Ulrich Hecht
	<uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: Re: [cip-dev] [PATCH] memcontrol: protect drain_local_stock()
 with get_cpu_var()
Thread-Topic: [!]Re: [cip-dev] [PATCH] memcontrol: protect drain_local_stock()
 with get_cpu_var()
Thread-Index: AQHdfJcrP3lhT0mi/UO5OjEAqOtuDbc+NiVQgAA+QgCAAACPEA==
Date: Wed, 25 Nov 2026 08:40:03 +0000
Deferred-Delivery: Wed, 25 Nov 2026 08:41:00 +0000
Message-ID: <OSCPR01MB13449ADCB5313C7D0F62A7CF9D7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
 <OSCPR01MB134491F796D1F30432D1990C2D7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
 <ee066451-53cd-4e86-a06a-6f986ca0c1d2@siemens.com>
In-Reply-To: <ee066451-53cd-4e86-a06a-6f986ca0c1d2@siemens.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13449:EE_|OS9PR01MB946765:EE_
x-ms-office365-filtering-correlation-id: 3d620cc0-2dd6-45a7-c2bb-08df4acfc193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|18002099003|22082099003|6133799003|261009223027099003|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: XwLRwDaWVcW4Rid9lwhh9qfrgqVsu6uAXLQURsN0ENo/fEFxzPIUqWt+xnpLHGVy8mO+I0k7n1y8/F/EZ89dY+opuz/KR2wHJDwv4qvjnf8AwyOesAs6nlFMXOly3VgLGkMTFRv08ft423zq3/r8U3I4ELBusGNEmnRmSaCHyetF7/9a6shVW5JAPvdQXWibIutX4sAg/L7ucZW8ZyqqOvpGEA3fnbZpP/enLo286uHNzLUxVyySEbDQicTeTN96pKiyX0QbeNMvsNVWqqf+xL4ROW8YGIFqX2GSNKPe2G9+aun2eNef9/+3vKuNwRDi33gd44xPFrF6LcDhHyNo43bNuaRZjNNgPtzEjXNGaC2s1qcPkZpAYw1O/jU8r5DNvww/gStPVcWm56vbOV0xhiJIhWaixUNsnV0XQzioPGGIsmIKWHldETecwCo0LIlXfUmwBgj7pAhJF+pE+jcemxNfubKEWoQ0huiE+RJ1i671ucBufMMYNIspAx6ESSmEONWP9Wn8IxgSBKyZZ3Q/ITY2uZZ7bia2B2LHAIMoCHPVOOlm8PLbhPksO2ThR/dscd2rvRqfF9Z+PQjq5cyon+18C/Om5q+0kuSHtzhgDw/QKmgfJe0jGCGg4NY49kmKIBwMDY98iTS/IaeJHjFyrlpEV5ZU0ggPTkVdIVJ8vTPGvRKojz53UmJQp9PLDpre+Eg9xzK6Rmi6x/oKZHZZTB87miNI3aQX1lh7QQblzIY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13449.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUxLcmtVSlJpOGo1TWpmSDgrcm56UEo0SFNUQ3dsRXRVMW9STEVSV05wcVVH?=
 =?utf-8?B?Qkk5QjQyd2VXditZVWZyMmxlaTdLZy9vbjZUbDJycVVzamFpMDhGbFFRSlV5?=
 =?utf-8?B?UXBsaVZyTmxuUnBrUllwT1BCQmw0SFM2TGJ3cEFFOUoyZXJsWHFNYjU1VitD?=
 =?utf-8?B?enpKUUUzN3lKbTBURmx5RnVhcko1c0RzMG9ERk51STlvTURtalpweWErL0xn?=
 =?utf-8?B?L2U1YlhLY2ZlYnVkQjFjMVQvT1lQV1hxS1p3WHNUcmpCQXVJM3ZDeGhTRkJT?=
 =?utf-8?B?Y1poMXpDVHFvT1o5cVNOOHNKT20rUGgwQ1pWMmJwaHowOXZTVHZ1dWZqeWtC?=
 =?utf-8?B?RkRSTzRYcUtDdk4vOExGc0toN2hmVmUyMGVoTmdyTFpnNitTelhGZmRuT2dQ?=
 =?utf-8?B?aXZyK1grNVlvWm0zTCttYzkvdDJyRTFDcE9yOVFwbU5ZdHN0d2Mwa0lLaUtC?=
 =?utf-8?B?Z1ZYelVtKzNLK2p2Q1RTL0NXWkxEbU5FWk9GbGEzcjVpR0RHY0crOUlBcHFs?=
 =?utf-8?B?YW9QbWdZVnpxUTVDeDBGbWl3ODhOdWNkMzF6Tk90REJsMG8rbXNnYWtaNmFX?=
 =?utf-8?B?NnU2dGxHYlczYWU2QWdKK0gvL09zMFRBbmNkVmtPMGRoTkVCQ29ubE14eTVR?=
 =?utf-8?B?a3BSQTZXeHV3MEsyajBxYkl1Z2cyQUNZMWk1TVhrdEFMNkkzRUx4Rk51Wmg1?=
 =?utf-8?B?RDZqNHRTakJyTzNJZFovNDFmQ055WnZQWlUrcVA3Z3c4dytmOWUyb1B6Sy9M?=
 =?utf-8?B?VXVORStseWgrUkpoWGRuektyWFpqQnNoRTVyVlJ5eE9yRWwyMDB1dVNIdnlK?=
 =?utf-8?B?L01FTzN2Ykd0K3VWQ25nZHZzYnpBeHlhU1gvTGdBS3lWaVpYTElsdU11Kzl6?=
 =?utf-8?B?WlZMTDlWVXIxUThZZEUzTFk1K0hGU3Y5NkgwaW5xNDVYQmtoZ3ljRTlRTVhS?=
 =?utf-8?B?RFRiR09XdHJsOWNoN1lTaW81bC9sK1doNGVHNmwxSStaQW1QNkJVclNncGJ1?=
 =?utf-8?B?R1R1TkRWT2tjS1Zoc0t6cVlNMGxlZUdTYmpVZEQrRXVsckJ4S1JXUjEza2RR?=
 =?utf-8?B?WHF0MDhmZy93d3F4VHJnd1hTZndDNm5RbVRNaEFNNldCQWdCNFVzT0lINUJq?=
 =?utf-8?B?K3JsRTdYOTM3clhSeWRDMUhVWXZCQXFra2MwZllVZVVNU01hME1ER0dHU05z?=
 =?utf-8?B?bmhPcllIRTVuVVVvMmNMdStsaXJrTnhSS1NldUdnVmgwK0JTeWd3aHNaZit3?=
 =?utf-8?B?cW9CS29oaWFjTDRIT1lMYjlMTnZnSlZ4RTNmQkIxc2hYZW1Gdzhka3hzNHNJ?=
 =?utf-8?B?aFlkS1NWbXhtTWdmdURCWkVHWGV3a3dKRkhMVUJScEtJVDd4MmZ4SS81a0pj?=
 =?utf-8?B?dERyWEhjL2Q0L0twTStVK3VsVW5mU0VMcStkR2VwbkdHTDVkQnRYTThpanNy?=
 =?utf-8?B?ME5pMGppcEg0cGMzNjV3ZVcwTE1YbGx5SlJWbXl3VzF4NkNtMzd1UGxXZ2hy?=
 =?utf-8?B?aVVIMG1lZFJkTDBGeGhrRG5EU2hxRDdhMlJtTlp6cWtrZlpiVHJ1aXpRTDR3?=
 =?utf-8?B?Y2RIQjRTRFRTZU01YnMrVS85ZGQ1OXgxcmpxSjZCZTlQL2ZVQnNKRHBBRUlr?=
 =?utf-8?B?ZVVGVUJrazkzUEZDWnJ5MFdNaVhKOTQ3TnlkMlVBaDBSNkMxY1VJUVByNGhR?=
 =?utf-8?B?K3FmcUs2NVkwUmZMTDhxVyswTElSMnlxMlY2K3RLOWdsUTZrb1A0amdaTmRy?=
 =?utf-8?B?OVBMSVQ1NEVTdG9SR2loRDNBd21VL0F6YmZnMnh2M1FpcEY1amhnbVBwSzdR?=
 =?utf-8?B?dkhXdTR4b2YvcmFnVU1tUWhtZlIvMUQwZlZNZEo5MHUxYThhcFFTb0NLRnpT?=
 =?utf-8?B?Q2pvWjRLcDYwNWhvcFRvSmhhbFQ0SHllcW0wTVBHaVNDR1k2N1RJUVRYUVUv?=
 =?utf-8?B?S09GRHJtcmltemRjTXFVWHlIQ3kwYnZYQXRHaDRaVUhWQ3QrTjV0WHM4dVpX?=
 =?utf-8?B?cGd0RjQ3UHBJSlR5b3RZcUh1YjJCWUY4OWUyazVGRVlURS8wYVBURUxMUVR5?=
 =?utf-8?B?eTRWSjlOUXpuc1VKS0J6eVd6VGRHSFlsVkxkNWFyeFQ0YnJFWk12djRpM1BQ?=
 =?utf-8?B?SlFOVVBMSldPbEJ2S01JUUc4MGlydDZVSUxMejZNSVNucUhhdzNqdUw4a2VX?=
 =?utf-8?B?aEVBMjRWekltTUtFTGZuWnhMdmxuSit5QWdNd1ovVHhMZnFOUGh6K2dxN28r?=
 =?utf-8?B?bDcxMkNaMWFIdXpza2p0RlBwcTBDVEZTU0hhYnkwZVovYVJmMC9jOEhGdldu?=
 =?utf-8?B?Y1lXeDdQVHYxVWF6VG5SZ3hzTlY2RlFGNDdKZnpKcnlCYWt4elA4Z0NoQnhZ?=
 =?utf-8?Q?Uf6vp+Azd9glEUx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gEpEsP18wiCzJ1vCT/LJEiERUG4F/u/5baHLVyhhx0mAJdepTtKF88xF0Qe6OGvdiOMQy44S2x7cTu9qXFoODsdlWyDMmkK7YBh4y4rXr0ewKz2hxngpLW6Hzygf6suW1HkqqjRxnJue1a/xTszmd1ptHMFbmq7n4ZLAWTCIp7pFeerpYr2jgmQ7CO5pkhFzuvgArT81skruzgk8QBEmLuTW9iB8cGa1FNIvt9QIJ/qtIVqX45osmQe3YqAPw6ofhh9CX9TJyTZhuiEFjc39Z7UqrDWf0NLpX7Y0QuJr+7n3SDksWTE0qgwtx7IBZgEk9j7E0hL8eXWvUVKTAwR0CQ==
X-OriginatorOrg: hitachi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13449.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d620cc0-2dd6-45a7-c2bb-08df4acfc193
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 08:40:27.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0nmYarM0A6FpMlbJmSZnfVY9S9aoQUAi46k0xnCibXXX4tecnMMzIvsDJgcYXszQbrpQppHk6Sm6zaRV5CSVaqv0mgDd5DGhzpScfhxzXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB946765
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 08:40:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25074

VGhhbmsgeW91IGZvciB0aGUgY29tbWVudCwNCg0KTGF0ZXIgTFRTLCBvdGhlciBtZXRob2RzIGxp
a2UgbG9ja19pcnFzYXZlL2xvY2FsX2lycXJlc3RvcmUgYXJlIHVzZWQsIHNvIHRoaXMgcGF0Y2gg
aXMgbm90IG5lZWRlZC4NCg0KSSBob3BlIHRoaXMgcGF0Y2ggaXMganVzdCBpbiB0aW1lIGZvciB0
aGUgbGFzdCBDSVAgcmVsZWFzZSBmb3IgbGludXgtNC40LnktY2lwLXJ0Lg0KDQpUYWt1bw0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6a2EgdmlhIGNpcC1k
ZXYgPGphbi5raXN6a2E9c2llbWVucy5jb21AbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPiBTZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI1LCAyMDI2IDU6MjcgUE0NCj4gVG86IOWwj+WPo+eQouWk
qyAvIEtPR1VDSEnvvIxUQUtVTyA8dGFrdW8ua29ndWNoaS5zd0BoaXRhY2hpLmNvbT47ICdUYWt1
bw0KPiBLb2d1Y2hpJyA8dGFrdW8ua29ndWNoaUBnbWFpbC5jb20+OyBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZzsgVWxyaWNoDQo+IEhlY2h0IDx1bGlAZnBvbmQuZXU+OyBQYXZlbCBNYWNo
ZWsgPHBhdmVsQG5hYmxhZGV2LmNvbT4NCj4gQ2M6IHJvc3RlZHRAZ29vZG1pcy5vcmcNCj4gU3Vi
amVjdDogWyFdUmU6IFtjaXAtZGV2XSBbUEFUQ0hdIG1lbWNvbnRyb2w6IHByb3RlY3QgZHJhaW5f
bG9jYWxfc3RvY2soKSB3aXRoDQo+IGdldF9jcHVfdmFyKCkNCj4gDQo+IE9uIDI1LjExLjI2IDA1
OjQ3LCDDpcKww6XCo8OnwqLDpcKkwqsgLyBLT0dVQ0hJw6/CvFRBS1VPIHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2ggaXMgbWVhbnQgdG8gYmUgYXBwbGllZCBmb3IgbGludXgtNC40LnktY2lwKC1ydCkg
b25seS4NCj4gPg0KPiANCj4gSSBob3BlIHlvdSBrbm93IHRoYXQgNC40LWNpcCBpcyB2ZXJ5IGNs
b3NlIHRvIGl0cyByZXRpcmVtZW50LiBUaGVyZSB3aWxsIGxpa2VseSBiZQ0KPiBmaW5hbCByZWxl
YXNlcyBvZiB2YW5pbGxhIGFuZCAtcnQgaW4gRGVjZW1iZXIsIGJ1dCB0aGVuIGl0J3MgZ29pbmcg
dG8gYmUgb3Zlci4gSU9XOiBBbGwNCj4gdXNlcnMgc2hvdWxkIGJ5IG5vdyBiZSBtaWdyYXRlZCB0
byBhIG5ld2VyIGtlcm5lbCwgb3IgdGhleSB3aWxsIGJlIGluIHRyb3VibGVzIGluIDUNCj4gd2Vl
a3MgZnJvbSBub3cuDQo+IA0KPiBUaGF0IHNhaWQ6DQo+IA0KPiA+IFRha3VvDQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVGFrdW8gS29ndWNoaSA8dGFr
dW8ua29ndWNoaUBnbWFpbC5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjUs
IDIwMjYgMTozOSBQTQ0KPiA+PiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4g
Pj4gQ2M6IHJvc3RlZHRAZ29vZG1pcy5vcmc7IOWwj+WPo+eQouWkqyAvIEtPR1VDSEnvvIxUQUtV
Tw0KPiA+PiA8dGFrdW8ua29ndWNoaS5zd0BoaXRhY2hpLmNvbT4NCj4gPj4gU3ViamVjdDogW1BB
VENIXSBtZW1jb250cm9sOiBwcm90ZWN0IGRyYWluX2xvY2FsX3N0b2NrKCkgd2l0aA0KPiA+PiBn
ZXRfY3B1X3ZhcigpDQo+ID4+DQo+IA0KPiBJcyB0aGlzIGEgYmFja3BvcnQgZnJvbSA0LjE5IG9y
IG5ld2VyPyBJZiBzbywgcGxlYXNlIHJlZmVyZW5jZSB0byBvcmlnaW5hbCBjb21taXQuDQo+IA0K
PiBPciBpcyB0aGlzIGFkZHJlc3NpbmcgYW4gaXNzdWUgdGhhdCB3YXMgb25seSBwcmVzZW50IGlu
IDQuNCBhbmQgaXMgbm90IGFmZmVjdGluZw0KPiBuZXdlciBSVCBrZXJuZWxzPyBUaGVuIHBsZWFz
ZSBleHBsYWluLCB3aHkuIFRoaXMgaW5mb3JtYXRpb24gaXMgYWN0dWFsbHkgdGhlIG1vc3QNCj4g
dmFsdWFibGUgcGFydCBvZiB0aGlzIHBhdGNoIGJlY2F1c2UgaXQgbWF5IGhlbHAgdXMgdG8gcmVz
b2x2ZSBhbiBpc3N1ZSB0aGF0IHdpbGwgbGl2ZQ0KPiBsb25nZXIgdGhhbiA0LjQuDQo+IA0KPiBK
YW4NCj4gDQo+ID4+IE9uIFBSRUVNUFRfUlQsIGRyYWluX2xvY2FsX3N0b2NrKCkgYWNjZXNzZXMg
dGhlIHBlci1jcHUgbWVtY2dfc3RvY2sNCj4gPj4gdmlhDQo+ID4+IHRoaXNfY3B1X3B0cigpIHdp
dGhvdXQgZGlzYWJsaW5nIHByZWVtcHRpb24uDQo+ID4+DQo+ID4+IEFjY2Vzc2VzIHRvIG1lbWNn
X3N0b2NrIGZyb20gY29uc3VtZV9zdG9jaygpIGFuZCByZWZpbGxfc3RvY2soKSBhcmUNCj4gPj4g
YWxyZWFkeSBzZXJpYWxpemVkIHVzaW5nIGdldF9jcHVfdmFyKCkvcHV0X2NwdV92YXIoKS4gSG93
ZXZlciwNCj4gPj4gZHJhaW5fbG9jYWxfc3RvY2soKSBzdGlsbCBhY2Nlc3NlcyB0aGUgc2FtZSBw
ZXItY3B1IHN0YXRlIHdpdGhvdXQNCj4gPj4gZXF1aXZhbGVudCBwcm90ZWN0aW9uLg0KPiA+Pg0K
PiA+PiBBcyBhIHJlc3VsdCwgZHJhaW5fbG9jYWxfc3RvY2soKSBtYXkgYmUgcHJlZW1wdGVkIHdo
aWxlIG9wZXJhdGluZyBvbg0KPiA+PiBtZW1jZ19zdG9jaywgYWxsb3dpbmcgYW5vdGhlciB0YXNr
IHJ1bm5pbmcgb24gdGhlIHNhbWUgQ1BVIHRvIG9ic2VydmUNCj4gPj4gb3IgbW9kaWZ5IHRoZSBz
YW1lIHBlci1jcHUgc3RvY2sgY29uY3VycmVudGx5LiBUaGlzIG1heSByZXN1bHQgaW4NCj4gPj4g
aW5jb25zaXN0ZW50IHVwZGF0ZXMgb2YgY2FjaGVkIGNoYXJnZXMgYW5kIHN0b2NrIGNvdW50cy4N
Cj4gPj4NCj4gPj4gRmFpbHVyZXMgd2VyZSBvYnNlcnZlZCBhcyBkaXZlcmdlbmNlIGJldHdlZW4g
bWVtY2cgYWNjb3VudGluZyBhbmQNCj4gPj4gYWN0dWFsIG1lbW9yeSBjb25zdW1wdGlvbi4gVGhl
IGRpdmVyZ2VuY2Ugb2NjdXJyZWQgaW4gYm90aCBwb3NpdGl2ZQ0KPiA+PiBhbmQgbmVnYXRpdmUg
ZGlyZWN0aW9ucywgaW5kaWNhdGluZyBjb3JydXB0aW9uIG9mIGFjY291bnRpbmcgc3RhdGUNCj4g
Pj4gcmF0aGVyIHRoYW4gYSBzaW1wbGUgY2hhcmdlIGxlYWsuDQo+ID4+DQo+ID4+IFVuZGVyIHN0
cmVzcyB0ZXN0aW5nLCB0aGUgYWNjb3VudGluZyBkaXZlcmdlbmNlIHdhcyByZXByb2R1Y2libGUg
YW5kDQo+ID4+IHdhcyBmcmVxdWVudGx5IGFjY29tcGFuaWVkIGJ5IG9vcHMgc3Rvcm1zLiBQcm90
ZWN0aW5nDQo+ID4+IGRyYWluX2xvY2FsX3N0b2NrKCkgd2l0aCBnZXRfY3B1X3ZhcigpL3B1dF9j
cHVfdmFyKCkgZWxpbWluYXRlZCB0aGUNCj4gPj4gYWNjb3VudGluZyBkaXZlcmdlbmNlIGFuZCB0
aGUgYXNzb2NpYXRlZCBzdGFiaWxpdHkgaXNzdWVzLg0KPiA+Pg0KPiA+PiBVc2UgZ2V0X2NwdV92
YXIoKS9wdXRfY3B1X3ZhcigpIGluIGRyYWluX2xvY2FsX3N0b2NrKCkgdG8gc2VyaWFsaXplDQo+
ID4+IGFjY2Vzc2VzIHRvIHRoZSBwZXItY3B1IG1lbWNnIHN0b2NrIGFuZCBtYWtlIGl0cyBwcm90
ZWN0aW9uDQo+ID4+IGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXIgbWVtY2cgc3RvY2sgdXNlcnMu
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRha3VvIEtvZ3VjaGkgPHRha3VvLmtvZ3VjaGku
c3dAaGl0YWNoaS5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgbW0vbWVtY29udHJvbC5jIHwgMTMgKysr
KysrKysrKy0tLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9tbS9tZW1jb250cm9sLmMgYi9tbS9t
ZW1jb250cm9sLmMgaW5kZXgNCj4gPj4gZjlkODA5NTI3MjNjLi45YjI5OGNlMTBhN2EgMTAwNjQ0
DQo+ID4+IC0tLSBhL21tL21lbWNvbnRyb2wuYw0KPiA+PiArKysgYi9tbS9tZW1jb250cm9sLmMN
Cj4gPj4gQEAgLTE5MzMsMTQgKzE5MzMsMjEgQEAgc3RhdGljIHZvaWQgZHJhaW5fc3RvY2soc3Ry
dWN0DQo+ID4+IG1lbWNnX3N0b2NrX3BjcA0KPiA+PiAqc3RvY2spICB9DQo+ID4+DQo+ID4+ICAv
Kg0KPiA+PiAtICogVGhpcyBtdXN0IGJlIGNhbGxlZCB1bmRlciBwcmVlbXB0IGRpc2FibGVkIG9y
IG11c3QgYmUgY2FsbGVkIGJ5DQo+ID4+IC0gKiBhIHRocmVhZCB3aGljaCBpcyBwaW5uZWQgdG8g
bG9jYWwgY3B1Lg0KPiA+PiArICogRHJhaW4gdGhpcyBjcHUncyBzdG9jay4gIENhbGxlZCBkaXJl
Y3RseSBieSBkcmFpbl9hbGxfc3RvY2soKSBmb3INCj4gPj4gKyB0aGUNCj4gPj4gKyAqIGxvY2Fs
IGNwdSBhbmQgYXMgYSB3b3JrIGl0ZW0gZm9yIHRoZSBvdGhlciBjcHVzLiAgUHJlZW1wdGlvbiBp
cw0KPiA+PiArICogZGlzYWJsZWQgaGVyZSBiZWNhdXNlIG5laXRoZXIgY2FsbGVyIGd1YXJhbnRl
ZXMgaXQgb24gUFJFRU1QVF9SVDoNCj4gPj4gKyAqIGRyYWluX2FsbF9zdG9jaygpIG9ubHkgaG9s
ZHMgZ2V0X2NwdV9saWdodCgpLCB3aGljaCBpcyBhIHBsYWluDQo+ID4+ICsgKiBiYXJyaWVyKCkg
d2l0aG91dCBDT05GSUdfU01QLCBhbmQgdGhlIHdvcmsgaXRlbSBydW5zIGluIGENCj4gPj4gKyBw
cmVlbXB0aWJsZQ0KPiA+PiArICoga3dvcmtlci4gIGNvbnN1bWVfc3RvY2soKSBhbmQgcmVmaWxs
X3N0b2NrKCkgcnVuIHdpdGggcHJlZW1wdGlvbg0KPiA+PiArICogZGlzYWJsZWQsIHNvIHRoaXMg
a2VlcHMgZXZlcnkgdXNlciBvZiB0aGUgcGVyLWNwdSBzdG9jayBzZXJpYWxpemVkLg0KPiA+PiAg
ICovDQo+ID4+ICBzdGF0aWMgdm9pZCBkcmFpbl9sb2NhbF9zdG9jayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKmR1bW15KSAgew0KPiA+PiAtCXN0cnVjdCBtZW1jZ19zdG9ja19wY3AgKnN0b2NrID0gdGhp
c19jcHVfcHRyKCZtZW1jZ19zdG9jayk7DQo+ID4+ICsJc3RydWN0IG1lbWNnX3N0b2NrX3BjcCAq
c3RvY2sgPSAmZ2V0X2NwdV92YXIobWVtY2dfc3RvY2spOw0KPiA+PiArDQo+ID4+ICAJZHJhaW5f
c3RvY2soc3RvY2spOw0KPiA+PiAgCWNsZWFyX2JpdChGTFVTSElOR19DQUNIRURfQ0hBUkdFLCAm
c3RvY2stPmZsYWdzKTsNCj4gPj4gKwlwdXRfY3B1X3ZhcihtZW1jZ19zdG9jayk7DQo+ID4+ICB9
DQo+ID4+DQo+ID4+ICAvKg0KPiA+PiAtLQ0KPiA+PiAyLjM0LjENCj4gPg0KPiANCj4gLS0NCj4g
U2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KPiBMaW51eCBFeHBlcnQgQ2Vu
dGVyDQo=
