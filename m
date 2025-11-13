Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC930CDB463
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 23:24:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6341.1763076257590743257
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 15:24:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=HsFaNXSB;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763076243;x=1764285843;bh=nF4p2i3eintC4GIBuC986ExkgDCtLUoLB9wWg
	/qr5EY=;b=HsFaNXSBPoEAcdsFJUQ1YG8Wy8Na2aONuR4bxO4gjn1bQyQltEyl/oC6TMCYdKlsi/D
	HdVysm4Q1Tcyhv4JmRXUl04HdrOL4u0KI+6Q+ioEz3ZMeE7n79GEfZQB/CwTDc5MqlZ516u/TNIEW
	eFLVYLQ1fKNWn1GArmJmcN1Ym9d9f5x5p7azJgTGiK5xQSp65oexnGXx82sTjavNeDdQ6AORXpAsC
	cOVYgNJ2CnPBNgDmok8derYTHGa5YzRUK8e4859yJB6UFkF0Fv68WglIUnZi5lpNtiVyP7fKGPB1U
	RG5YUOdjpl52JvBosE2aRo+9GKSW8NWgE69QBqf5VZxg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5ADNO3m02139962; Fri, 14 Nov 2025 08:24:03 +0900
X-Iguazu-Qid: 2rWg9DyHEOoP8tOrLc
X-Iguazu-QSIG: v=2; s=0; t=1763076243; q=2rWg9DyHEOoP8tOrLc; m=BjrRa8rqjC+Mm5mj7VMbdZpQgdqDMfegYihslp8CtXw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d6xDL4JW2z4vyh; Fri, 14 Nov 2025 08:24:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpTFHfS8ZOy6CvSK9B4YU1+197kPpz3sYAB6dLWE4vuZhzN6yhSFctefFTrir05YCVNz69bI/q2YTz204BXuOEsI7UE8ssEKk3og7ODBDFA/dA6AWkZaSnXssJrcTMILmSNZlghFc1RgD0sN1RfqBdJd36O3QQivmcmGF2TQP0YW85GaUx+dL6w3DfBsCRK7DTjxnrgDjf8jG3+l1gD7xCtiP83RaLgHoJoumiokkVf6Uwmu4/BguzJcCN3wWb7JhqxxpZnzCEeAa+xzYkFSUI41GlRGiSLmWsxeGyx6ynV0RIbK0X66Z+SkA0XzPmvQ8ldmGKDUIrUh/rmRLyx7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0yct9Nm4ehBJJ73JUyNNEs1puGQ5KH7z13hIbzwNPk=;
 b=GYfU/g6/jkH+GWLlAU1Rle5oFY1a8itMNi5Zi4hZxYWYsLWt0U7/zmoHjZomF7XXBCnTrOVCsIuDXy8IdXVintTVJQfC8m+Usp0TFchNczYh9EbYwMphSwqZKn3XZV3i1LfDZz9KVTK4sk4DKpCyf4pSThrBD2SaAmEgQ5O+NE6SRzNO+GIiZ3WIisqt7t9etzGcybMx0PPUYYXX9N6Guya/0OG0nDIs+ytd05QhjjXDtwOMcFegyHuAlsoEU82uzxwZy7snzYcJCkm+uLQkDaxd5qACOS0Kbe0Q/TWpQP+pgjSHvWbd0KTJws37Ut3WL63aoeRpvI7US+7r5HFFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Topic: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Index: AQHcSXohAN8na7gZ1UiuF/m8YRQGZbTbeywwgBTkMcCAAAnD0IAA7KGw
Date: Thu, 13 Nov 2025 23:23:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CB78323A225FE651FF2DCDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY7PR01MB14910BC4525FB7ADD0057D7B2D3CDA@TY7PR01MB14910.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818BA7A37D7D94DC3D9784DCDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818BA7A37D7D94DC3D9784DCDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10431:EE_
x-ms-office365-filtering-correlation-id: e10942a3-5e30-4478-dba4-08de230bb929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aThNT1MrOXo0N0hLU3g5YiswSitCUitrNVBqaHBxRFhCYlZWMjloN25n?=
 =?iso-2022-jp?B?cUV3RTlkSUQyWWthQmxLVlp2V1A5MmxKM05DUG5kT1VLQnZjS25qc0x4?=
 =?iso-2022-jp?B?VkZJNm9pZW5pSWJCY0pVcVNPOXQvNDNRTGYwbVMxazErVnJEekVLeDQ5?=
 =?iso-2022-jp?B?dHVIQ1JMYUVLMHE0bDkzdDMvK3RHeEs0dkVtZXN4d2xCdkx5VkxEQVNn?=
 =?iso-2022-jp?B?akdTaTRZdFlkeS9IbUdWcjZVOFgvQng1M3JHN1Q2RmZ1dWFabGZEaDBG?=
 =?iso-2022-jp?B?bm41QjQycnVFT04xNnFXTGRRTno1NVY2ZkJGVEk3OUJ4cHFGYmVkdndQ?=
 =?iso-2022-jp?B?WEk4VThLeUZVUDJxQ05TSWlaSzMzK3dXWEFIaFBUMWQwdFhVOEtCamdM?=
 =?iso-2022-jp?B?cFlxaU1hOFRTS1BLSVpHVjR6TitGdXRhSlplbkI5WFZodVV1VW1uN0lQ?=
 =?iso-2022-jp?B?Zi8xRWM4TlF6NW52L0x3TmU2QllZNzl4azZvdDVFTzE3bnNGa3poRmlJ?=
 =?iso-2022-jp?B?K0lSaEFLbGJENytBalBDNGtNYVlUbE8yOGVEeWdyQ1RQUUQzTjV5Yml1?=
 =?iso-2022-jp?B?Y1htK3dBSUN1RVlGVENpRWNnelhZNUs0dUQvallYV1p5ejd6VHIrRkpa?=
 =?iso-2022-jp?B?SXFOb2RrTW1OOGwwdEVNWlpWS1BPR25Fck81OFdDNW5pa0lVeTBXVmNM?=
 =?iso-2022-jp?B?UXoyWkIvNGdXRzgxTVBKUkg2enYzc2NwNlFLcFQ0NmlVbHlsWWxWTExS?=
 =?iso-2022-jp?B?VXFWbDZLVzE1aUg2YTlmc1BXL0xXZU9SQXdIQml2bWxhYUUrQTk2R0NC?=
 =?iso-2022-jp?B?K3VTcWFDMnhrQWxveFBBWFJRRXVIbE9wdE9wM2RrQUp3NElIcnhJS212?=
 =?iso-2022-jp?B?dFBlV29WNTYwM0tYSnl3NzlhaDNsMnB1OXJGdUlQZms1a2pXTVIxTkhB?=
 =?iso-2022-jp?B?MlBvRERvaFVKdnNKb1VteG5YemRmRUg5T0wvb3pLbWpqRkJkU3FjTDFG?=
 =?iso-2022-jp?B?eDRxeUdIb3ZGcUwzaTBnNU9xS2czZkNPOUxJMkM2Y0NFZnNrQ0gxY0d6?=
 =?iso-2022-jp?B?S2kwdFhNYXM1NVUwN2ZDODErNDBDb1FScFl3RUUvL3NZZWdOQnpqaE1M?=
 =?iso-2022-jp?B?U0pwYTlYVExHT2ZJdllPbzVDbUFHWXh2bUNodVpwMmlZNm42ZU5VaGNZ?=
 =?iso-2022-jp?B?OEc3TEgxaHFsMU1wZlRtaHBUaEZEQkdLZ2UxSHoyY3k0dkZha20yVFcx?=
 =?iso-2022-jp?B?RmROd3VOKzhXTE1YMGZPakU1Tm1MQjJhUlkwYW5venRJb2hKTjVoT1lS?=
 =?iso-2022-jp?B?M3Y1Z2dPV2NtY1p3bDdrNzg5dGRTMzNrT3cyUTk1dEpVWDUrVUxvbUlY?=
 =?iso-2022-jp?B?U0ZPcUM1a0M2YjYzSDhkUG9scW5WejAwN0Z0QUx2cWFCYSsvck1mOTlx?=
 =?iso-2022-jp?B?WEEzVEgwWkNzSS95ckkyenBQSnVBV0xOOVhQY0NoSzBEUnQ3TGZKc2xR?=
 =?iso-2022-jp?B?bXN5ODBuZTFnMTVveDNzdFYzMmZONkJSbzBQTTF4WHA2cUFSTXoxVjZX?=
 =?iso-2022-jp?B?dnRzbEdOckZCUDRvT1huWVdyMk1hVVNaWUFyNStZZnRrSWVRWU82dWFq?=
 =?iso-2022-jp?B?VVNKbWZYMlR4TThRWW1CL1hsUU0xMWg4d3lpSEgwcnJqeFpERHUxVzlM?=
 =?iso-2022-jp?B?SW5WYWZ3djA0SStOR3pUSUhOZTZ6RisyRVJOMDNWWlVFZU93SzhrU3Y2?=
 =?iso-2022-jp?B?cEwyc2N2eGppam1GMzdMRUdPRmxkVm5xaWc5aFlpUnhvbkg5d0lmcU5B?=
 =?iso-2022-jp?B?WG1OTEhqUm9XN2Y3UmhNalpmbGJNenI1Y2tsV0JkN0diVlNzQmdmUWxk?=
 =?iso-2022-jp?B?M2V4aVV4dmxuTmg5clJHYjN4a1NkeUlzblZMZzZSK1M0d3Y1eU9aUWJS?=
 =?iso-2022-jp?B?ZVVIZWRxT3hIUSs5NW50L0RLc2pjYkc0c1RuTjZZZzhOM2ozMVMybDBR?=
 =?iso-2022-jp?B?ejlOZVNWNVhTYnQ2NmViTnNuVk5MRlZIQndqWi9EYzN4UVE3MndTSnlM?=
 =?iso-2022-jp?B?a1pVdGg3dzZOdmRWV2plT0VLdFp4SVVsZStmQnIxVCtnZFNqWjRYdlRF?=
 =?iso-2022-jp?B?TVpnajVCYTRrVGV4aVVFNVBnUGJQcVlnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RFRGZUZ6VTRLU0RWM2dZQ2xNT0Yzbk5OYnFBSnBZd0VTTElLOXZQNEx2?=
 =?iso-2022-jp?B?WkhZZzlGa2ZVWWRab1hqWUkyQnhEcVVNaW5UM1o1R3M0WU1lcWwvM2Ix?=
 =?iso-2022-jp?B?OEhJc09yc2RTNHd0aDZ1Rm1CWjh2N2VoQ09xZW5HSHlldXBOYjBXaFkx?=
 =?iso-2022-jp?B?ZENqOXpOM09KanVwa01VU2JpdDRCUFk1MnFFRTJWQ3lobk5sYnBoZ2Vp?=
 =?iso-2022-jp?B?d1R3dVh1UVJPNUVxaFVMb05iclBqRDBwbklWOGx0NGcwbmwvUDZVV21z?=
 =?iso-2022-jp?B?dkVBeGxKdzdURDVPQzIraHBqakprOGVuYXBBL0xSeFBFQWx2RUFXQzlO?=
 =?iso-2022-jp?B?R0NBRS9jWVEvbjVYVXJFelZIaVAyOFhpbTJHZnorNjh6Q3d2aERyYmRX?=
 =?iso-2022-jp?B?bnVLakFTTFBPVmdSWHpheTRsYUxjZEI1TzF1VU1JWmZWc0t1Qk5FYjJO?=
 =?iso-2022-jp?B?alh3NEhiQnpZYXlUSDNJR0JOeGZkL2JmbnJlamN4eUU0ckFSU1FVOUxL?=
 =?iso-2022-jp?B?Z29SNWZUa2FzRW84QlBwdDkwaDhTRlBKTU0rUG9lemlpTFBKUlRqTGVw?=
 =?iso-2022-jp?B?RFA2ZG1hMERkUHlWN3FjUXdPM1UrSnp2T2xySkFBQUJKamJhTWVxMmJ6?=
 =?iso-2022-jp?B?Mmo4R0dQbTdacU1Pa3lYSUgyM2ZHejhHZFM2K2tGNDFpYmRoZHEwYkhi?=
 =?iso-2022-jp?B?aU85Z1RyN2tLeUVCMHkyMFY2dGJGMVVZVkxXTWNNRlNrdTY5ZGorOHI3?=
 =?iso-2022-jp?B?QmhhR2lvRUpxOURVL3FoT0NXbjUvOHViQ00rdXcrRDdVbEpXbVVQZlpz?=
 =?iso-2022-jp?B?T1M2WXhBYXZHZ2liTWpKcCt0VFB5VmlSVDJETHhmbFcwWG1GcUJzN3NC?=
 =?iso-2022-jp?B?aStjQ0ZWTjB2aFZ1a1o1NmtHRmRLVU9ONC9ZTmd3aVo5MytIOVo3enlP?=
 =?iso-2022-jp?B?YnJEQmRLbzdURmttNmN5RUFWUnkwaW96QnNkQWh3a3FTaCtwR09LVVNY?=
 =?iso-2022-jp?B?Zzk2Z1VXYXFIQUptY2IzT3pLdzVabFR1K1o3NE0yWU9vVUZLM1RqN05M?=
 =?iso-2022-jp?B?MXhHbDU0TFhuempSckZkdHJEVTh1WHZHaDVzY0ZZcGJSR1ZHbk1rOTdJ?=
 =?iso-2022-jp?B?R2VONXpxMWR2VjVPWFFvbHE4a3NadjZpZXJ2WnV6RWpjN3h4d1lmdTFr?=
 =?iso-2022-jp?B?bnVodHl5SnVJN0JiZEhvRUhSNkkrOWFVTjNFd0plZlVxNmxYOGFWL0Rt?=
 =?iso-2022-jp?B?bnpobzg5V0NnYlZKRDNoQXdIZnhZZG13dThENEtQVTdQSm9kTlA2YURD?=
 =?iso-2022-jp?B?VlhxZzVxUExKNzRObUk2OENWN0d4WlN5Nmh0QzBXS0t1THVUNUdiZHRW?=
 =?iso-2022-jp?B?NUhSSFVvdEFMcmhiU0NLOTYveWRTenFBY2F3TVB4UWR0YiswR1poSHkv?=
 =?iso-2022-jp?B?dnlLdjRUZ0JQNFR3WnhWejJtczdQSk9yNVVDd3k2S3JkWjN2OGtqdWhl?=
 =?iso-2022-jp?B?ZmprK0lrSWlrUHBmT1kvUThFV0NNblZCVFRIcFk0cFFHVHVsckJ2Q1c1?=
 =?iso-2022-jp?B?bGxEVVl4TVNyNlk5WGhyZXhvZG1oelY2dWVLYmVETzR4QThQdENRcHFw?=
 =?iso-2022-jp?B?Y2xTMkpqTHpKaHZ2OHIwOXRqQVJGRHRkT2RyRGFzeXdTaFU1eExwa2tL?=
 =?iso-2022-jp?B?VEQ0c2Y1RlE4TlFuZXhzRjV0SGtveDlMUlovOGlKZnUxWEV1OXd5dVNY?=
 =?iso-2022-jp?B?eTVEa3hxMzVXeGt6WmZCMUhXdnMzWisvWmdFQVozVWE4M2lyR0tQbzFM?=
 =?iso-2022-jp?B?YTg1Q1plaHJoZCtQRmRJZUpINjM3aVV3Y292Q3NLQnppeU1JYStIN3d0?=
 =?iso-2022-jp?B?Y0RlclQ0ZkoreGRsV09rd1B6YXMyanNWQTBqNllUemdqNm0xY1lzWTA5?=
 =?iso-2022-jp?B?RjlXRlNFZVd6T0dCaitCdFJTVTZwM1ZXbFJlaDdFajhXYzlyQlYrQThx?=
 =?iso-2022-jp?B?Mk4zTUVzQ2wrWTR4T0pzYldZM3VQS0NKcnRRYlNRb0cxd2NjMDl3TTdJ?=
 =?iso-2022-jp?B?OUEySTRCcFE1azNiV3pHM1RhbTlZdWI5Qm5FYkxicUh1dlpCZ2lBRmxQ?=
 =?iso-2022-jp?B?MUxPcWRkU3ZLakt0R1I0OUhxZkl6ZXQrV0djZWsvTWtnRWxheWwxUGJM?=
 =?iso-2022-jp?B?TU51Z1d1Q2FNT01pOWtZY1JYek5MZVVQK0RwOW42MlNQVWZRRW5obFNr?=
 =?iso-2022-jp?B?ZktGTCtmTDlGWlhkUTBscWZ6WTlXL0FsOW1Eb29WbGtndFVjYjUrVVQz?=
 =?iso-2022-jp?B?ZEZreTlERk0zbytpVnRoT0lWV1ZhRUdHV3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10942a3-5e30-4478-dba4-08de230bb929
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 23:23:59.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4CdYTZLZDxrGwlZm7t03jM+HAw0T3sLqEmAELb/bgCHVxMfVNObhGCP6ruZz12VtESWdcRvkdOKxHBe+E/f4VhqDf5ktLzIsO4xiFVNFYfX4c+k8imQlI6s5yaAV80a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 23:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20533

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Thursday, November 13, 2025 6:18 PM
> To: 'Ovidiu Panait' <ovidiu.panait.rb@renesas.com>;
> cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
>=20
> Hi Ovidiu,
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Thursday, November 13, 2025 6:04 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> > <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org;
> > pavel@denx.de
> > Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: nobuhiro.iwamatsu.x90@mail.toshiba
> > > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > > Sent: Friday, October 31, 2025 3:39 AM
> > > To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>; cip-dev@lists.cip-
> > > project.org; pavel@denx.de
> > > Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> > >
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > > > Sent: Thursday, October 30, 2025 5:49 PM
> > > > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu
> > > > nobuhiro(=1B$B4d>>=1B(B
> > > =1B$B?.=1B(B
> > > > =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@m=
ail.toshiba>
> > > > Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> > > >
> > > > Hi,
> > > >
> > > > This series adds the ICU dts node for the Renesas RZ/V2H SoC, to
> > > > the linux-6.12.y-cip kernel.
> > > >
> > > > The ICU driver and its dependencies are already present in the
> > > > 6.12.y-
> > > cip
> > > > branch, having been included earlier as part of the RZ/G3E
> > > > backporting
> > > work.
> > > >
> > > > For reference, see the related commits:
> > > > [1]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3D3d3a549e2fb073619507de56be14aab242f87b7b
> > > > [2]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3Dae9102da607f85ba0831c6b5af0c0d52d5166f7d
> > > > [3]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3D69c328745d39318be83b84a7f379009cc574d072
> > > > [4]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3D9fc198d9b2c292fb089eaaa2a5b679b24d26f072
> > > > [5]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3D2e7375bcebd154ccf175eed1982d11b8b3c4cb8a
> > > > [6]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > > cip.git/commit/?h
> > > > =3Dlinux-6.12.y-cip&id=3D1fe131fc74f7fa9d0753fbfb7dbb92483a10ba01
> > > >
> > > > The patch was cherry-picked from mainline kernel.
> > > >
> > > > Best regards,
> > > > Ovidiu
> > > >
> > > > Fabrizio Castro (1):
> > > >   arm64: dts: renesas: r9a09g057: Add ICU node
> > > >
> > > >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 90 insertions(+)
> > > >
> > >
> > > Thanks for your patch.
> > > Looks good to me. I can apply this patch if there are no other commen=
ts.
> > >
> > > Reviewed-by: Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> > >
> >
> > I noticed that a new 6.12 release was published (v6.12.57-cip12).
> > Looks like this patch wasn't included in the release, whereas the
> > RZ/V2H Ethernet series [1], which was sent later, was.
> >
> > Same for 6.1.
> >
> > Just wanted to check whether this patch might have slipped through the
> > cracks. If there is anything needed from my side, please let me know.
> >
> > [1]
> > https://lore.kernel.org/all/20251106104024.28947-1-ovidiu.panait.rb@re
> > nesas
> > .com/
>=20
> I had overlooked this. Thank you for letting me know.
> I will release a new CIP kernel that apply this.
>=20
> >
> > Thanks!
> > Ovidiu
>=20
> Best regards,
>   Nobuhiro

I applied this patch to both 6.1 and 6.12 versions.
Thanks!

Best regards,
  Nobuhiro


