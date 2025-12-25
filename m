Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB6E784AF
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 01:26:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.131882.1766626005292623517
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 17:26:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ELJ53iGv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766625994;x=1767835594;bh=cqvWkLZ9j6QlJvID/sWMPhN4wOkucz0tdpy9d
	7C3I08=;b=ELJ53iGvoBO8UT0svMGdZQuqvJyGmCYo3l+QHgHAkCwcmJtl0FmcSi2lD/4cXhPCsoB
	kmpuW2pY97LmjYv74DzOqEGYxQst+G92y+aV88LqHbSuCqsiWLmX25Geu5MWWk6KpY99Rcl60x3e0
	/vGJWv9MQiYjldMrUZJKOgB/R2E3pZ0ANlrgiU/mYu8/7J0U8mmcBswNxRYVgzTHNAYklpUuRLTKw
	QI9AZUL47fn0D9W4eYdhHTevgIHVN7j3rnFwQcdf9bEf1ni26nw4/JwDM8dIV6vnS98lNwdilt9rT
	Y9KWFX/gAT5eWjXxKoXxBZrdkypsAXr68r9WXwfgjVSA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5BP1QXkJ2121573; Thu, 25 Dec 2025 10:26:34 +0900
X-Iguazu-Qid: 2yAapjLoQAebT0a71q
X-Iguazu-QSIG: v=2; s=0; t=1766625993; q=2yAapjLoQAebT0a71q; m=WeiafSOWZFRsktWXvcv2uINzza2J64zS9ofGHL/NdSM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dcB0n2qG7z1xnf; Thu, 25 Dec 2025 10:26:33 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg9KFHQjY61i3i6RnmbgE3F9V9kcCqtEevvyiu/pl5KjGLYnHJ8YqLvC8xB5m7/BhpWZrm3fzybBji8JWOkDH5dXwksasRTMC9HN/IjcFZ4U3N2uX1VQT774iZ0Hli7Lc/KkTbT/1Oo9ynJM+K8aSjeYUmFQEisq8i4CVVhCIiSi9yYEE0wE+YayS/1bokJK8hYFoAUx296ikdIwjzQKNQRril9OigQw4FyherF4QSDEr3qxlOdrMBbdjC/LY0TQaU3wMPFczhH0n3Uai1Hx1HBgYZKEGPA5BL6V5LmAwRLMuUhSwYvVzqel7oYiYHy9nc4fcnADi8jBtje7QjUr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tbDrfwFHEkSf/WXkL5sF22tmnRCVaPVP7w9PvSynU4=;
 b=RiHtH0gfFSWSBAfeWBgKrB9bNw0udV7C6LXkdNJ1H9o2MsIchDxnNcZG2XKksmzCWLeTn0JO4IF7Jkf/0TxWrPaGlqVX6ozzqakPuhkZO+APWJcw80e3/XoyelU34g0ii1ftvWbRTLqcnFX+meTSqlcfoHhXpF5tblXfz8IqgPMpcqlV0mIBKO2NFhCVFBa5CZl5cmeJ4jELJvziaowknXmlFRgitQsZ2FJ65tfL3q1SLfiBe1Vy1V5U/BSiUt9jkokNGEJ4NEGuRP8ER0ck5LK/Fu1wrU7caQbOK9zdD95SHW+qmeHmoMe9XuC4RR6mSayKIxbJ9XofA5jxDE1ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Topic: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Index: AQHca6+901AOmKmFuk2g14dCjt2QIrUxovtA
Date: Thu, 25 Dec 2025 01:26:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E30D0E0BED5C4B7E5D04CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7049:EE_
x-ms-office365-filtering-correlation-id: ce1e0b3a-2053-447b-2ab8-08de4354a0d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bVY1OUFCcVg1alN3RWxTNFM3WFc5N3Jhejh4bUk4VGZJdGU2Q2VxQWdI?=
 =?iso-2022-jp?B?YlB5ZFJyK1pmd3RJNDZoTE5YUU1jY2FkZ0hnNUNGdHFTWnBCN2hNd1pT?=
 =?iso-2022-jp?B?SGpkWGtidHVIdlhZMzlvSEZDbGRBOGoyVnhob3lQUzNaR3plSlc0WnNL?=
 =?iso-2022-jp?B?VWJ5ZXNFa1pwMjJKRkRxbWRKRnlCZjJlSERRb1luUS9oVk5BbWZPVmt4?=
 =?iso-2022-jp?B?MzVIVFh6Tm12TzhQeVVmY0UzMXJhYUtxTFNaekhSRlFBbElDMnJnR1hj?=
 =?iso-2022-jp?B?NTB2NVh2eGlsOVZhNVRkUW11ZGdmNWV0QXhJbUZLb204eUZnU3JhWVYr?=
 =?iso-2022-jp?B?TFhOOW55SEY3Yk1Ybmpxang1SXV5RHhJSkY1NGdTd0k4MTVLNGxXRy9R?=
 =?iso-2022-jp?B?L2kvejZZQW1ydG1HdS8zeEN4blFtaSs3b3N4aE1wdVlPb3NaZDBubGNU?=
 =?iso-2022-jp?B?emFEaFhGdWhmenN3NEVLVllGYitVRUdqa0pEVENTQjRjOWRGVmdlT0ZL?=
 =?iso-2022-jp?B?N0ErbEZlb1ptVFU1MU41RjhTSXZJUU03eVBtY2VGZmdUSThYZkNTTm9N?=
 =?iso-2022-jp?B?VVRhYWZLS1FUUGI1Q2hVYlpoQzN4cFF1cGhSanNRZEU1WEpYUkF2WmY4?=
 =?iso-2022-jp?B?NFVmTE9veGNoNmdpbC9GQTA2cVVlWGRad2hzYXNzMTNwRW9lbTRDZTZF?=
 =?iso-2022-jp?B?V1RRQ0lFUEw0Z1hwcGFKY3VrVWRMd3VIQ1Z3RUFNek15aGFjR0VVVWRo?=
 =?iso-2022-jp?B?a2t6S3g1cElheHZDNTlZOUZxcDljL0tGY1VsQ0trdmsyYXc4WStKRmZT?=
 =?iso-2022-jp?B?WUY4Y1BSTUlmWnBWMFBVM3hHRTZ0eE9SV1NYSEowZFBlNGNlVFBHalhp?=
 =?iso-2022-jp?B?eUhzVmRxcEJsQ1JxWHllMUVkZG9JL2NiRjRRNHNrUHgrY3dlSGpIeW81?=
 =?iso-2022-jp?B?R3YyN2xhVjgwUmlhWnJ4L0NzTXJMTXRIc29EMWpGblNJdXNJdGN4YWhw?=
 =?iso-2022-jp?B?clAyeUtmUXJqdWIrQldUYnM1QWtjdzdHWC9ha2YvcUdqalJTeHh4RlpC?=
 =?iso-2022-jp?B?emxKL3FyemJFVGZ4dk45clRnUzVsR0xlek9QbjNWcDB2NGMxWktVSHRv?=
 =?iso-2022-jp?B?T0J0M09wVWRvR3JSSEN5eFR2UnIyTTRPQWN5dTlWejNDRzRvL3dsTktj?=
 =?iso-2022-jp?B?NDdPcjdDZ2JZc0NSWS8xRXRxZXBFMHRqWmhoOEdLcGt1N0sxR29MNVVH?=
 =?iso-2022-jp?B?WHFZcEdRaW54M00vVkt6TUFlNDlnUHBEWGZZOUlnbG5vSktWUXNaMnlJ?=
 =?iso-2022-jp?B?TUVtQmptbWtiMzRkUEF4cVZpaWhicENXWUErMUozOS9sOGdJZ0w1YlNJ?=
 =?iso-2022-jp?B?S0xRa1IyNi9RNGl0NkVLZm5kNjhYSnBDd2hpcTBRMStqVHNVSlovZ2Qw?=
 =?iso-2022-jp?B?N2pIc2xzQUlDWDRQL0MrcTVzS1hQQjRtS1hWK1VEcHl3RW44S3ZnSFU3?=
 =?iso-2022-jp?B?c0QweEx4bDFabmxkWk0zemEwSitQYWRXbzFSeDFlRmxCK3VQYlR1d1pw?=
 =?iso-2022-jp?B?NmdjbDFwNURyRmh6Z210SnAybzU5c0RUTWJXRThnZXlOc1BxckYzZkRV?=
 =?iso-2022-jp?B?MVlKQjJWT2hVa040Z3hNeTkyd0lTbXoyeTZYaEpPdUNoMk5ObG1sMTVU?=
 =?iso-2022-jp?B?TWVPemxTemxQeGFoUUptRTgzYTZzSHRRSE5BM2NzRVFaUnp2WjI1SzZN?=
 =?iso-2022-jp?B?UU9PaUhEcUlRRXVlMWpRYWQwSDZPdmEzc0IxTEpQWnFjcWwzOHNIVUJi?=
 =?iso-2022-jp?B?elVpR3NwRkt2ZnBkU0dpajhOaFloWWFxVitSZnd4QncybTZBNklTR0pY?=
 =?iso-2022-jp?B?N1FtdXJIU2lkQVBkTzBtbnNYUjZlTGF6V05sYTFvU2ZjZlFvVUduMU1T?=
 =?iso-2022-jp?B?akVQUVdtVVg0TG4xZFErWU10YTdoVkJPM2hDOG0rNDBkU3Jnb1ZkVGtR?=
 =?iso-2022-jp?B?SmdqWllDbXJTYmtzOFFSeUhaS0d3dmYwQ2hNMisrdWxSOHlVNzM3bXU3?=
 =?iso-2022-jp?B?eUR4WWtZb1dSOEFack5yQXpRT1FnQXlPaGVXa21vZkM2YmdjYm02Umtp?=
 =?iso-2022-jp?B?dFkxL1Y5MTBtcWhWRUZEWHpHZW9oMUEzSXp6MXBCZ1plbW9jcnI2dDI1?=
 =?iso-2022-jp?B?WUk3L2Z4MjlXTXl6bzg4YVpBSzZTWWVy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z2hFdC94c0VBN0dYTmxlUmJKTjBZNmhWWWF6V2Z1ZXptVFlRSFJXL3Mr?=
 =?iso-2022-jp?B?dVcxYk9DV1lFdlU0eUV2U1lKeEg5a2JCandvTzZSRDREdllrNXB4eFhl?=
 =?iso-2022-jp?B?cEdLSllkNkZpMmc4RU9NSXVoSytCVXRNV0ZxVTQvdmY2NCtqNXNZMmJ6?=
 =?iso-2022-jp?B?K0lEcHNXQXpEb1gydXlTbm5KZ2NSYVhRR25yaUlQWVl0MVNQQTdjMHlL?=
 =?iso-2022-jp?B?b3g3WldLOWdQaHFEamJBY3FaM2JZdEZqcVozY3ptNWdwOE5Yd0IrejJM?=
 =?iso-2022-jp?B?ZUFGWU12QjlYazB3WWdaSEtET2xlMUlkL2RaYWlXWGtoWlNOTVh5dmJ0?=
 =?iso-2022-jp?B?TS9FejF4Z1gzanNmdVI0YUtPZG1vZzJtK01SQURGL2VFditqYzVmTzU1?=
 =?iso-2022-jp?B?VktmSnVNWU5yZlRyczJZZ05RSzNUTElGRWc1VDQ5SURiY2hQdE1VRDdL?=
 =?iso-2022-jp?B?akVyNTB6cFVmcEgyTHpnN21kUkRnSUhXZXlrSmxLcWlmWllUVlNNSENI?=
 =?iso-2022-jp?B?TzJzcHBScUYwZWZmUUg4cVZTSkxlWnp2dDA0eklQMkN6OUdCa3AyUjJI?=
 =?iso-2022-jp?B?YVlzZzh1bmsvZnRuUzBiMlhRWWo3N2w1OHVBVWN4ejVNUWR1c2x5SEZz?=
 =?iso-2022-jp?B?VWRtajQyMXpMcDJXQnkyZ2tHek13aXhYRklndm1UUnFwRWNqeld0dzlv?=
 =?iso-2022-jp?B?WWIvUWJ3ek4yN2xzbGtwSkZ6OWk3M1pIejU2RnBoQ2ZORlBxamFEOU1k?=
 =?iso-2022-jp?B?MlVJSnB1VkhmN3FkTGVzaSszSFpXMm15bWxud1U5T3UvSm01UFc2aHh2?=
 =?iso-2022-jp?B?MjdSQUFRV0FDR21ibXBMbUV4NU90MlJRcnBlRHhGZktWeThoUlhZN25s?=
 =?iso-2022-jp?B?L1AxNGF1Rm53U2xDeThnUnV1N3I0N3ZTRGxHZmRscmE0eXZKNUtDWnlP?=
 =?iso-2022-jp?B?c1VZelRnWHpEcnZ6T012VytmRTRXWmxVdFBwbEUxQXRqeXJOcnY3VVNP?=
 =?iso-2022-jp?B?TVZ5bXpDeStGb3l1a3NWSFZybkFEVzZrZ0VpSFVlT09uR2F0ZXk0Y0t0?=
 =?iso-2022-jp?B?ZERkOGpmYnYxNzJFL3FhaGk3dWF6RVZ2ZjFyRmkrOUh4M2RpdlZtTWV0?=
 =?iso-2022-jp?B?dE1pRmwwVnd5YjVZTks5ZzVmYm9MbEVZYVNOYnNOL01tckwxYlRLanRD?=
 =?iso-2022-jp?B?eDlXQWRDOHNsZ2c5NHd2WWNacFBsLzExQU5ZZUluM1Rocnd6NWNvbEdB?=
 =?iso-2022-jp?B?bytTQzQyd29yUWUrK25Vc2xTbk5WZzlzUkxKNzNma1h5eDd1KzdnT1Nh?=
 =?iso-2022-jp?B?cnRGLzhXSENyWDhOR2kyY0ZndEozWDFBNXBPRlhDVzBDeWxzUC94d0VF?=
 =?iso-2022-jp?B?dWRNZmE5L2Rwb2IyTndaL3pEaEJ4ZWxZZHdyckp2VVhEa3RaeGJiMzVm?=
 =?iso-2022-jp?B?R2xWc3lLUFZYSkV1azNMNmdLSEp3dEtudEY2ZkZ3L1N2UWg1c21yejMr?=
 =?iso-2022-jp?B?TDNkNTBqT09RVDVhUmhZTXNtTGlmZ2xHL0tjK29oTXNuMU04UERCclNF?=
 =?iso-2022-jp?B?U2kyWlgxV3V5b0VnT2dWUVpGcDgzcGVrT0ptZFZ4aXRlL0ZMOUF6SkpY?=
 =?iso-2022-jp?B?c0ZxNFIrVEc3bExubk40OWdORDFVMTd5NDBhMksyaCtPSE56L0grSThP?=
 =?iso-2022-jp?B?RStNanhKUzZTRUpGb3hodEtHdGMwMXBoQXcwQTJPUDZ0VmQxdlNNcXNr?=
 =?iso-2022-jp?B?RUlpMEg0MXhMZ3JBMUlmeGc4eUZ4OW9ZUi9GQUZpVm9kVjgyY2k4VzZQ?=
 =?iso-2022-jp?B?K01lTjA0cXZCVVdDTUlIWXVmZWl2M2xJSkdaYXBtc3NnWWtuRkM5eDlD?=
 =?iso-2022-jp?B?bDNuS0JhSnc4QnE2a0RKaGFnZU9tMXc4Yld1azdHZm5vVFpZbHlRWnJZ?=
 =?iso-2022-jp?B?TGpTNFFmTEhla2dLOXg5b3VNM3JUd3JIaTF1WXc4c3BsOVU4a29lL0pn?=
 =?iso-2022-jp?B?OElKRWlzYjl4Ym1EaTVIaTFqcE1kVjBhZUx0dUwrMTlzQ1dEc2Jjbnkr?=
 =?iso-2022-jp?B?Z254N1VxcUlvWGZncTVvOEwxbXY1VUN0SURVVnNZY25hS1YvYmluelo3?=
 =?iso-2022-jp?B?dkxEaFppT3dvM2pHcHByblZnMDB5OFpGc0NOQWp2aHhtRncybWIyWkpF?=
 =?iso-2022-jp?B?dnk1WWhhUGlyVUFjWW85azdFUEkzTXI4U1ROeTg5T3BMQ1FaM3pCZ0ox?=
 =?iso-2022-jp?B?MWpDWUYxVy81VVhJcnB1VkZIaEhVamZOSFpscWNrdmtPL3NaNW5YYWJm?=
 =?iso-2022-jp?B?NUFQcjNxRDdQVmRNTHlMcmZsRXRKaVZ5dDFHdjhua05PdTBkekJiSHFh?=
 =?iso-2022-jp?B?RFc5MGtpTGtVWnUxeE5FOE1hSXBTOGNlY1gzUSt0S2JQMlBNWGpYb1Aw?=
 =?iso-2022-jp?B?MlJTcWdTRmdBUURsMS9hYytuQTFTQU95THNLRlBkVU41SjgxNWtmZGNW?=
 =?iso-2022-jp?B?aG9pZnFrSG1pbk9EUTlibkFnc3cwSkVzbHJXd0JYV21oT3VvL0MyVVd6?=
 =?iso-2022-jp?B?WFFSdERSbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1e0b3a-2053-447b-2ab8-08de4354a0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 01:26:28.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3KEjGPRvXLDcZfYHC8enZ+VV3FsOHmkKwvxWuocWVG9/rqQVWXV1jN2YgisYNjk2/SoPBjONeb+PmDt5c593PYTDdfJ9sjgRspwscexbTd+2Z8NP79I+TDSoIOLyXKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Dec 2025 01:26:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21215

Hi Ovidiu,

Could you rebase to HEAD of each branches (6.1.y-cip and 6.12.y-cip), and r=
esend ?
I can not apply to each HEAD.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Saturday, December 13, 2025 6:39 AM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
>=20
> Hi,
>=20
> This series adds watchdog timer support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Best regards,
> Ovidiu
>=20
> Lad Prabhakar (4):
>   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
>     support
>   clk: renesas: r9a09g056: Add clock and reset entries for WDT
>     controllers
>   arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
>=20
>  .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40
> +++++++++++++++++++
>  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
>  drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
>=20
> --
> 2.51.0



