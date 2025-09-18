Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7382ACAC5A0
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 12:29:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.13030.1758198560297952898
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Sep 2025 05:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=DdV2XAD5;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1758198541;x=1759408141;bh=ZrfgdEUdQTefscoI6BTQT+c6cv9SRtcz5jkBc
	e5pDq8=;b=DdV2XAD5K1yiWwbL3WxjEUJ/M/M0sQel+Zwgb4gEZVs9Sj1PYaj2556EFkJcVHFt/Tp
	wPdOUeAtwHluisrPybLcthe0miy6Iz4FJB9LB3UjC4HZgD8wGaVj4m2bbpvjxC/GkwBCxkTcRdoK9
	gM5n/iZ31Z7Z+bzx1SGeZMzIXy/uNlIPms7pEmYy58OC9RUIDDcnsoUqbvKQHt7t39q0mUm75MyVi
	58z14NK+pmWfgSXGrXE8t5zV7LI8NXJ4Sf5ZoMcfNkHy6WsE5Z8G25UUP3cOBxzcX5ZjbktQdTG8J
	HxWAgylD9AMdpN3R9NevtgvfAQYXgbcNwQCUnSv/gneA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 58ICT0N52138379; Thu, 18 Sep 2025 21:29:00 +0900
X-Iguazu-Qid: 2yAbCy75eoJpSaZSF7
X-Iguazu-QSIG: v=2; s=0; t=1758198540; q=2yAbCy75eoJpSaZSF7; m=UY8kiD+cZcqm4onJGxqq8T6pQGxh1NH/030FAOTd23c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cSFLM2PVHz1xnc; Thu, 18 Sep 2025 21:28:59 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFbA0o9gH6Arnn1pzaA/4ijjK+A6OgO7DqXCIWTnD8WORBWs5J/6MZ/6pH2xvRbNPpEJZvq/73weilb4hcki8Kg6C+JKyBxLECYoK9k44+Lmo8JzDAjwyZ1aVS373fCjvYZ6cNT9/uXoWwxQIbiHUgWTuxf+lEuOXD0lJFtDJ0agNJq4fagOif8G1+chCcl4vtH5MvWkxNBBO7y8p47nanE7ZpEjy3qMzy1AgTE/U7wNc2F9duWC5yRyCyzGSbWiCeoKhuTl4SfDwEJ8dulnd8ZB7z2yPPRNp2Jre8eIv0V76toK13AQ1YoJo2KJ3EqQ0xKSeVQuCEbpugJBw44LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrfgdEUdQTefscoI6BTQT+c6cv9SRtcz5jkBce5pDq8=;
 b=Mf8ZkVmUmFgHRAb4JdrK84vkZ4SJ9V6WPvkbUrfdZ1FeEOy/iURvO3R0M1K3GjTsb1wdKQ8yBMuYK1ucWexvts3/sNW76S6CpYMA9rhDL2YfRCD9yvms679fuC7GxJ6rU6Q+gqopFXXxnNIG5baUTMEkVGak4ed0kWUobLqqixsbl82pgWkfPgh9/c4vzTbYcKvivc9TC57vPLEM0pi6BsytS2bT7OWvzs00kdLloeAJFtrm5eS4im/YSMR8TcR9JGFRzI8F4+Jhol+KE1yh1PiVAx0cOyVquPhgkDfTMlenvn6KYfdhQz1yWi9B7mbC5CyMs77nP+m43PKys6xe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.19-st8, 4.19-cip124
Thread-Topic: Request for review for 4.19-st8, 4.19-cip124
Thread-Index: AQHcJxso9DnisyL1TEuylAiLQeDOpbSY4A0g
Date: Thu, 18 Sep 2025 12:28:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D384A90E52AE9BF2CDF2CD16A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1522250355.247103.1758035031215@webmail.strato.de>
In-Reply-To: <1522250355.247103.1758035031215@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB14227:EE_
x-ms-office365-filtering-correlation-id: dc9ec74d-0eb4-4088-6a9c-08ddf6aeefdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cCtFejVjRGM1VXFuRzRHYVArRHQ3VlAyYVpIeE1KS2Q1UnYyTnMwUm9WRjhk?=
 =?utf-8?B?UWNmQUIwQ2gwRTFVNTkxbktLOG9BaHNpTGdvWGR5K3RGR3g4Zi9kWGk0TE1E?=
 =?utf-8?B?UnNOTS9ZbWFZeDkzV0EycG84U2V2c1FkUndHUndUMkdnVWovcEtoaHUrbU5Z?=
 =?utf-8?B?T0Y5R3RDVVJoVEljVTV3V3pMZjFCUGVuL0FjYTBjU2RhMENwMVU3Sy96M3lY?=
 =?utf-8?B?V0NaRnRMbDBkQkN5SlVUWWVncnd1RFZ0dTQvT04vODllMU9TNVlxZlN1RzRQ?=
 =?utf-8?B?bytJc1E4Vmpva2gwQVBhTGFkY2VPMDcxRW9rM29DRE1hZ3A3VGlZdEttS3FC?=
 =?utf-8?B?b3BETUlKamNBTDduWWEvWlBtTVhtUjR1QU42ME5UOFdFRnJXWkhoZmtGbnVZ?=
 =?utf-8?B?MHJlUGh1UXhvcUwvd2ZTK1k2dEJ2U0tFUVRBOUhoRStGa1VtVGlieUtoeC9z?=
 =?utf-8?B?UGZLOTNYV0VYSHkzdEJYQjVQQm5wcjZtTEZkc04vTkFaeVBhR3NOWXl0dTFE?=
 =?utf-8?B?VFpYdFhCRDVlOFVOekRoMXZUOGh2bDN6N0xsNFV0V2NHZks2VUdXbGNiMFdh?=
 =?utf-8?B?dEZEY3ErQjJNMS9KVFdTUTV0VlpMREp6NE9YMWlvYU9lM1ROckFqM08zWi93?=
 =?utf-8?B?WWtwa1JybjExMWNPOTRFZ0V0Und4b2tYY0RMOVNLeGplSndGUU1JdGZ2T0tG?=
 =?utf-8?B?TlpBWElLZUlncnpMMWN6TnFtVUZkbVdoMkNEYk1wYmJiY3czaGIxQnhqKyth?=
 =?utf-8?B?dTRBbkh4dER0NktCOVZqRkZoaExPenhVVXI2dytDaVFLOU1mSmxQdjlIWC9W?=
 =?utf-8?B?eEluN2thWDZITUU1YUp0Ri9pRzZXQS8rTWYyR2dNejlIT25VT1hielczZzda?=
 =?utf-8?B?eWJOTnRTcnJScllPemdVQTZWa3pqalEybEVhVE9xTDNNTDY2TUlIRUNtNTJF?=
 =?utf-8?B?T0RQV0VyOG1PSUZIWVlBc1lvUzBZRDVzYW9CeTVJRituaEQ0N252QmMwd1ly?=
 =?utf-8?B?RlZtT3pzNTlkb0V2ZDJ1WG1hditjaSt6SlNjcU1LMDlRR1pDekp1cHRXQUJ2?=
 =?utf-8?B?S1FGRmpTdVdjdHRPTWlGbFFrYVExZUh4Q25oT3NEdXRiOTZJNXdGWHFmYnVr?=
 =?utf-8?B?dHRva1B5YmlRbnY3aEs2S3FWZUJPTEpMcGxndWNiVmdyU1FveWk2NERpY1lp?=
 =?utf-8?B?NXRuYUNlU1NiUVU2NEJUWW9nTzJENUtNdFNpaWYvQ2VrSHY2NWZGejBMWnVr?=
 =?utf-8?B?dGczTEZKSXNEdERxMXh4SUhnaVlDU0EzVitVaXZiTE1qZXZaaE1MODlTNVRX?=
 =?utf-8?B?QnovNXNMU09qc1ptak1ueWwza25wRUZSd0F5M3V0TjFUTkJWZ1h3enZYTEF1?=
 =?utf-8?B?Wk5LKzFNZzBnWjFiSHd2L1JpOTZiQ0R0eXdtd21SYkdKaUJ6dDY1dzZQZXpD?=
 =?utf-8?B?eUtCVDRpeHRhblgxMnRPWEo5djAyR0MvQkRKTE11ZGFxU1JWSGh6ay95QUdn?=
 =?utf-8?B?S2NocmhJT1M4clgzTDNTN2oxTDZQQWo0ZVhVWllrOXE4UWZBSDFlenR6cDg1?=
 =?utf-8?B?a2lsN3UvOFdOVnZCSytJTFU4RzRPRG5MSG1WTnE0WHd0NVgwNzZrU0k0NW8r?=
 =?utf-8?B?Yysyd0VLd2p0UTFtcFhoR0x6QW5KckFJNUphbmM4VDJ5RlNhSHduM2dTSDNX?=
 =?utf-8?B?dW1KTmtxd3U1bzJ2QjhadCtMYkVYMVJjMXQyQ2lJUjBrQThnNTVIRGFZdFFD?=
 =?utf-8?B?NHlKNm9mdjlsK0Q2WGFwbG96ZXpNcnIvNFI1SXg4aGExYTl0U1YvSWpwNXN0?=
 =?utf-8?B?eTNsRWVld2IzMjArN2lUQ3ZZYmw1dzBMdWoxSnZBQ1oyMDI3WUVJTUo5QktR?=
 =?utf-8?B?Yk1lU2orMXBMOWkzajBIajRCaWNiOUxOdllTU2VJQzE2RDJ5Ykc5K3RIOEhN?=
 =?utf-8?B?TFRoU2g3bE02V1FHN3M3d2ZWNWdMaHB2dGJIY3ZadUFycWg1aEZyU2pURkF4?=
 =?utf-8?Q?Pv6PeyVTcJZd4ke7GIO0MQf9moZJlw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWJIQkpPVVpXTFJxL0gwK3pCRENTWVRvVllZWUM2Ympkb21JYjQ0WHpTck9D?=
 =?utf-8?B?bnViQVNHU0YzYlIwT2w1UFlEWE5kYmNKK3E0WUQ1ZWc5dHF2WVBreVByazVL?=
 =?utf-8?B?eHErMXg5cjR6SDBEL1czZ3I3emdGUm9KNXRuNVV5cHNxYnBneUJTTGdGU3E3?=
 =?utf-8?B?czZXY0x4dlM3ejdtc3NzTExnY2ludXMzRmlWaEdUaUZEVzBFRnVTd0FDWHpU?=
 =?utf-8?B?Vlp6cE16aHM2QkZLOG1xY05sejc1alpJbFFUS2VsWFpNU3RlWE1UeXJsMXJP?=
 =?utf-8?B?ZTQ1QzU4STlXdFR6MWJxdzF1TkI0UUpYblZFZWZNRUNtNTY2T2xhaVhvZzVL?=
 =?utf-8?B?TlVrWXh3YWFmKzJQU0xsQ09Ca3kwWUZIR2VvcVFHb093WkNHL3JseFMrNGc5?=
 =?utf-8?B?OUdkUkxySGNFS29BdjcvVjREZzU1dkxjbFdjc3l4cFVRWHFHVlNNeWszUE9l?=
 =?utf-8?B?bHQvcnlOQnhvYXF2cDFQNFA3QWNiSStmekJMb0J0N3NKanpkMUpjbU1neFFR?=
 =?utf-8?B?Z2MxSGVvM0c0L3V0aVA5cHo4WkxnaFZIeHZEMVJxNlJ0Zm5vM05EZTBTdmM1?=
 =?utf-8?B?blhVS0dlM1RzYWRNbHlFN2VGZm9XUmYrV1lObE8wa0pnYVN1a2RhTmlWNFdn?=
 =?utf-8?B?K3NBWFNXNVExWk5sZWpxNWlvWllxYnNaTkNSbFQwcFpHTDZhMTBFU2pPdTlx?=
 =?utf-8?B?Wjc3RTZTSWpiOW01d0I5bUVFS0huZDRVWExEQnRVMFJCTG5aYVNERm4zajJm?=
 =?utf-8?B?Nk40ZlZRWXAveDBPZjN1SzdyUjVIN3dsbHZMSklGYnJXSjlNZU1qL1B2S2NL?=
 =?utf-8?B?Yk5vWFNyZ3FUL0hzNkdiOStqUW1zNkN0ZWVIbXZvV3dxNG1vZFR2MkZZUkor?=
 =?utf-8?B?dW5kd25NVTQyTGhaQXFkcFVMTGR5a1p0NHNBb3BhN0tkaHIrRDhHRGNSV24w?=
 =?utf-8?B?TldrZ3MwOEdGYlJDZEQycGxORlNPMzdTdUJMOFpuUTd3VXNOeW51bkx2N3dZ?=
 =?utf-8?B?S2U2Vk1SVXpsOXZDaDJ1TEgyaVhxWms4b3U2U3NycWZJYmlHeFNCUURvTDJH?=
 =?utf-8?B?Q2pqQlkrL1hOQmdSVkkxU2FLR1dnTXdpQVM1aElOSE4zN0pHVytKcVVuenB3?=
 =?utf-8?B?WTlSMUJFeTdUMisrM0pLM3VNQWlLbkxoQko5VGdJT3AzUlhDUTFQRU5uOHkw?=
 =?utf-8?B?d0lBcDVSNWZIU0FaNlA1elJoSnhacG9NQzg5c0RlSVBMeUJ5cENub216UFdE?=
 =?utf-8?B?ZW1FdDVreWZDR1YyT2NKcEx3M0ZSc014VjVDd2ZrY1hmeGxUS1R2V0ZmQWM4?=
 =?utf-8?B?dWNhOXI5cGF0dVJEZjJaSEt3SGIvLzNiakhJNHlQUjZnaVYrT2NtbzV3WFVj?=
 =?utf-8?B?Y0YrSy9qQzY2ZThvVGZjK09PMGFESDJOKytYYnJSOGtja1g4elM3VUc1bGtG?=
 =?utf-8?B?eTQvUFdUWllabitlMUpDajFmL3JxdmRxYzBweGdiZHllRS9DdlhMZHhvWVB3?=
 =?utf-8?B?cHRvRGhUMzNqdldKajhNSG51ak8wRHlaM3FnYXRFMkVnQ3pFUm1HU2FHU0M1?=
 =?utf-8?B?WXpWNFZzcm1XeEZnL0htbGdCVlVNMmo0WmpmUFdja0ErUmlQRVV2aDRHTmtD?=
 =?utf-8?B?TmN2QWdOMTBaK2hlTUlSWExzUVRnUXV4RllQSlkwYUY3YTNOcGhzK0tJc21I?=
 =?utf-8?B?UzZxUzNkbytHcklLU2pISVFzdVZ5d1AxVC9yTkxmZDZsWG8zQVhKelJDWEtU?=
 =?utf-8?B?MCt1SC9TK2xCeHRBN1lqaDVZQVEzcVEydjV1ZTdQUFBHc01uSFlTWnh5Zk4x?=
 =?utf-8?B?NHc4SDBhZE9xNlQvQWNXTG9hMDB0WWpKZ1N1dklFck9aRkt0L2NXcVhlNVJx?=
 =?utf-8?B?aDQzMXdQRnhtM25TVkNxVFN3eThtRThwU282WS9hb1o2emRSTDVZZXhvSWtZ?=
 =?utf-8?B?dC9DRzhLN3oydGE2VTlhOGpXZ0pWQ1l1dy9sQ1JnZHZxTlFQWWk5bEQrR0Ni?=
 =?utf-8?B?OU82N0kzdUgyR0FHRmFxZkVUdGRoYWtZZllnM015MlN3aGFCdkh6UXRMV1hz?=
 =?utf-8?B?MUNXeDFHNTdUMldYbGdsYnFHSnZ5emd6dm9ZR1RrMnlwTTVQN3IvM2NtbXAz?=
 =?utf-8?B?WUVqdnZhR2JTS2JHblhXZUZIV01rbk5xcGhoMlMzbVpjUHhZQWtSSWgyTSts?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9ec74d-0eb4-4088-6a9c-08ddf6aeefdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 12:28:56.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3ixiIPQuFDA4A9qVZKJSBaS0PYcF/sC87TueB9ewva7tDmrWYQl7vsHvjfIFjh7953jdziXoa/+jiWgYe0Ell623vRcxIcsTichZidByzw+Bi916LLKP1I9HUCsLRy3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Sep 2025 12:29:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20085

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxyaWNoIEhl
Y2h0IDx1bGlAZnBvbmQuZXU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE3LCAyMDI1
IDEyOjA0IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgcGF2ZWxAZGVu
eC5kZTsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oQ0KPiDmtIsg4pah77yk77yp77y077yj
4peL77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gU3Vi
amVjdDogUmVxdWVzdCBmb3IgcmV2aWV3IGZvciA0LjE5LXN0OCwgNC4xOS1jaXAxMjQNCj4gDQo+
IEhpIQ0KPiANCj4gSGVyZSBhcmUgdGhlIG1hbnVhbCBiYWNrcG9ydHMgZm9yIHRoZSB1cGNvbWlu
ZyA0LjE5IGtlcm5lbCByZWxlYXNlLiBBcyBhbHdheXMNCj4gdGhleSBjYW4gYmUgZm91bmQgaW4N
Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xp
bnV4LWNpcC5naXQvbG9nLz9oPWxpbnUNCj4geC00LjE5Lnktc3QtcmMNCj4gKEF0IGxlYXN0IHRo
YXQncyB3aGF0IEkgYXNzdW1lOyBJJ20gbm8gbG9uZ2VyIGFibGUgdG8gZ2V0IHBhc3QgdGhlIGJv
dA0KPiBwcm90ZWN0aW9uLi4uKQ0KPiANCj4gYzUwMTc1ZGQyMzJmMSBmMmZzOiBmaXggdG8gZG8g
c2FuaXR5IGNoZWNrIG9uIGlubyBhbmQgeG5pZA0KPiBjNWRhNzM4NmNhMDM4IHNxdWFzaGZzOiBm
aXggbWVtb3J5IGxlYWsgaW4gc3F1YXNoZnNfZmlsbF9zdXBlcg0KPiA4MDA0YTAxNDAwNGYzIHBO
RlM6IEhhbmRsZSBSUEMgc2l6ZSBsaW1pdCBmb3IgbGF5b3V0Y29tbWl0cyA3M2QxZmEzMTk3MDlj
DQo+IHdpZmk6IGl3bHdpZmk6IGZ3OiBGaXggcG9zc2libGUgbWVtb3J5IGxlYWsgaW4gaXdsX2Z3
X2RiZ19jb2xsZWN0DQo+IGEyY2FiMDViNTY2N2QgdXNiOiBjb3JlOiB1c2Jfc3VibWl0X3VyYjog
ZG93bmdyYWRlIHR5cGUgY2hlY2sNCj4gZGRjNDRmZmRhYTdkOCB1ZGY6IFZlcmlmeSBwYXJ0aXRp
b24gbWFwIGNvdW50DQo+IDY4ZGVmNGJmMmM3MTQgZjJmczogZml4IHRvIGF2b2lkIHBhbmljIGlu
IGYyZnNfZXZpY3RfaW5vZGUNCj4gYTJmMGYyOThhM2JjNiB1c2I6IGh1YjogRml4IGZsdXNoaW5n
IGFuZCBzY2hlZHVsaW5nIG9mIGRlbGF5ZWQgd29yayB0aGF0DQo+IHR1bmVzIHJ1bnRpbWUgcG0N
Cj4gMGY4NjI5MTMxNmEzMyBmMmZzOiBmaXggdG8gYXZvaWQgb3V0LW9mLWJvdW5kYXJ5IGFjY2Vz
cyBpbiBkbm9kZSBwYWdlDQo+IA0KPiBUaGFua3MgZm9yIGhhdmluZyBhIGxvb2shDQo+IA0KDQpJ
IGhhdmUgcmV2aWV3ZWQgcGF0Y2hlcyBhbmQgYnVpbGQsIHRoZXJlIGFyZSBubyBpc3N1ZXMuDQoN
ClJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1h
aWwudG9zaGliYT4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


