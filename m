Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE4C0218C
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 04:39:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.45214.1737952764587772477
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jan 2025 20:39:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=P1sHH/7r;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737952758;x=1739162358;bh=R/ahA+wgH7Rcx710evQXp006I57et9wQq1DZ1an
	bAXI=;b=P1sHH/7rtDEOQqInBbPhU0YntwkTGwaPbu0tMSTTVpfD1KSNowO0zGD5lierY0CO/XW2n
	9GVZGSd0KxchENdI66g2vkqOXl7fmeEAxRurIddfFxr37WEp2hNvm/GnNRIj8L/W5WA2TlShSrUY3
	QhJrv+Y2nMdurNOtUlK8KZ6fG6hCSj4+aUnZW0I8g5SEfNfl5mR1bp7+TTZVk5ENIkV2MoAdeoY8K
	fYkYtYOOY03oKZLB4BpgtNw4ESNw1WRvv4oYpJPEjxbFG7y7Y8QX4fyjzXA6/mW0rizb1NnGUuiAh
	I+Gj4Z0AN6FxPrmAAZego4RQk50u+oE9H7qFMnv/AQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 50R4dI3o2222740; Mon, 27 Jan 2025 13:39:18 +0900
X-Iguazu-Qid: 2rWhMjEQHvtRgfVke8
X-Iguazu-QSIG: v=2; s=0; t=1737952757; q=2rWhMjEQHvtRgfVke8; m=DUXm1MZPM/wLz6waJ1TdTLHrO2QTfc+CEPnh4qbZnl4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 50R4dG9O3204224
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 13:39:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiQc5T/yn//g2h43ytblv8pGYzHyqnfzPNCA8/8vF1ydjwzQV96KfC8cajLwQOVCzMtmWlxtNvyrjRCLT5kWfpNP+x+vtTIOhX4RUiTzMiv0l0nImoGOtWPvELGp4pNEQX+mfG8DZpbpEXd2DtaBeC58fuTMQO3cHID81z8KL/bKPLvqTEWjDolayrASzek1QmJnAoAfpn68BkApqwcUY0AuFM6W8UAglIoZwmoKvxDd7gbpIseBCb4yNQA2r8mdfo1jbXOOzKyP7J9Uq+EVpfMrSCa6Ye3y3QD+g0y6m46TBwk2PdDYzmjJjGbXsBJxaqHHHf5w/oH8W3exxywyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/ahA+wgH7Rcx710evQXp006I57et9wQq1DZ1anbAXI=;
 b=H0WDgHasB3vuZJgUBXCwO272e9fPW15M0grc+ueEV34DMplvg99AjWvYb4gOYaEdz4Fcdg7JG1yzMbKjZctyCF6JLBXyLgGwaPruA3MxIXhVjgX76FsQd8GUjske8cn630HRXsk4nEoHN26JL8QBa/fxoIv6UN5iNnP9183p91aD884nm6Bt0uLC/bhi9sb0IvxfERfyxDO/60EZgYNzw47oDQWeR35BuyHmX8El4U0BQc0Os0PIxu4ch4Cm8nELAhvQslWCFI6v2deDmov4P+OUtirVtABH/QheO232wV7W8Qao0vj3CLv/6pbddC1zrSTqJxR+WyWAQreyfo2hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v6.1.y-cip v2 00/14] renesas: rzg3s: backport the RTC
 support
Thread-Topic: [PATCH v6.1.y-cip v2 00/14] renesas: rzg3s: backport the RTC
 support
Thread-Index: AQHbbj5now43JiXH0EGFBPaoJo/jobMqDh1g
Date: Mon, 27 Jan 2025 04:39:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638862C21F147406A2E6C36792EC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB12507:EE_
x-ms-office365-filtering-correlation-id: ba670040-0eb2-4032-1b10-08dd3e8c8e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bUo2NTBTUXpVR09BQzViZTR1MjZpYWdsdUtTZWUrRTErakVpTEV5V0kvYk9l?=
 =?utf-8?B?dWVqcnExZU1xODFaTy9EaHEzZFJaR3ZvZnRDbEN1MHhuMTl3Ty9sSFBUenVF?=
 =?utf-8?B?OEczNk00amtxaFdydVlPUFdDOW0rVGNXRWc5bVVmM0NLd3I5eGFnMGlIZ1gy?=
 =?utf-8?B?TWdIRmhCNEFHM1pNdW9DelAwVW5GL2svNTJ2Q2UraWhoSkFLMFdjQ2dGSXF4?=
 =?utf-8?B?cEtFbEtkckZZQlE4ZWJuU212OWd4VC8zUFRzbWJPeFYvcmtUdG5aUnpqMGN6?=
 =?utf-8?B?UTc1eVJtUjg2MWV4VExxT0NNVUp0RnpTT3BpeCtZWGhMMUdsWi9HaVZCR3lq?=
 =?utf-8?B?NTBEdWxIaDM4YlY5WHRlcXo0dzFITmRyOWxRMUhVNEVRSmE0c0lmam5vdXZz?=
 =?utf-8?B?ak13LzF0dXh3V3l2OEF6REEvVjBLaHB3bVhqR2NqYmVrR2lxYnZhVFFnVjZu?=
 =?utf-8?B?cFZSYnBYclBNdGFlcmZpNDdpTHVGWlZ5WHlzVDdSUWNlbmo3RUNVWEI5RFpr?=
 =?utf-8?B?RzZtK1ppTWF5UjZzblJONEdCZzVjaHpyUHVSZ2ZBUzJqcW5RNnBQWElCWFNJ?=
 =?utf-8?B?THZDRUhyVG4xU0Z5NjBRRWRjdEhyWXpBb3pDVDhPZXlXeEtyeUpsa2R2QzlI?=
 =?utf-8?B?SWY4Yzd1VG45RXM0MU0vb3ZJY0RsL3VyQWRob3d4ZHFnVzJiOFluOFFZeWZx?=
 =?utf-8?B?d3lOMlF2ZzhWcWlyUUNrQ2gxVU0wV2JmaW94UjdEZlM2Y2xycFNPZ05Bd3Jz?=
 =?utf-8?B?NllxQkJTbmJ6VVJlMGhqNW45T2dGOU16WU5oYzlNekJkdm1MaElpaFlYN016?=
 =?utf-8?B?bXptYlZjRDlNTWNWejdZR3ZrYzk3S0tVcWtlZ3p4bUZ5bWVjdGx0U29iQkJp?=
 =?utf-8?B?K1dQdVQxaFp1UEJlS1lkd1EvV2JmWWJNNWZTemJYdVhvMDFrSU5RYVlMMUho?=
 =?utf-8?B?STc0ek1yRjZjemNHQklPYllkSFUyc2RBdUo0VFlJYzl5QlRheWVHcTBGNlVa?=
 =?utf-8?B?UUNCRUxEbWovR2VKVjlDemljbHRVNVhNWTgvNUk1N0ViUWxBcVdCRnBxZ3Fw?=
 =?utf-8?B?Wi9rZ2ordXVDVEh0Q0l1aUY4TnQrR1UvQUpCb2x5RTRwRlpIYUc4UDJlL3p6?=
 =?utf-8?B?aGRsb1ZhNFdYK1pDZER2WVc1L2RNZ1REbmN1Qlc5QXRkYU04T3FFVmhiNW9H?=
 =?utf-8?B?cEtmdjUyaVdNRnNwOUg2blM0YUxVT1VnTS9SNURKaEFpeWRIQ1QrbUQrUjBB?=
 =?utf-8?B?emgvb3VlczQxK3VHYkNEMDZ3L25WQitqWHFqOEducUt0ZW05YjRnUnFoZzl2?=
 =?utf-8?B?SDhuVWY5Sld3VkIwT3pTSVE5MFJHMGN2NmZ4cEJ6RkZyRW0vLzlSaFo2Misy?=
 =?utf-8?B?aGQvUXA2RndIcndMeHFJWVFCYkJQS2FDeGtEVXozSE1GWFpSZDBoYUVVS01v?=
 =?utf-8?B?Y240SkVDVElIcnc3ZW4wV0ZUcTQ3V05OeE5wNzJhUWJFaE5KUXQ3Vkk4VmpB?=
 =?utf-8?B?LzVjUWhybDFvaUFjN3diZ1RkRm9EK2t1eDFvK2g2eGlXTkFtRG5udEdMMUJP?=
 =?utf-8?B?anN0RHVPV3Q1SW5sbjh4NHJ1b2ZSQ1Z0THJWRGkrd0R1ZkdsdmJYVjlGWTNt?=
 =?utf-8?B?a0tvQlA2dkt1NkVTNCsveG5SRkQzejdTNDVGaC9UcHlsTE94ZENqOGhRU3o0?=
 =?utf-8?B?elpoNE5kOStJbVhmQ0c0SFB1eHArdFRxT2xEVVMvTmdEMGh2cFpaTzBQTWpu?=
 =?utf-8?B?SzV2NE5FVXpHMTA3d2JRY25JU2huek1ENHJSZ0ZPNk5EVHB3QldhY0hvUmVy?=
 =?utf-8?B?K01hMlhqclRCR2Ezemt2N21YN1ZOZEtFTm0xR1ptUEVxSVJYMUs5NUIxdm9J?=
 =?utf-8?B?TVpLa0YvbnFJZW1rKzlUbEdVMXE5cm1BQ1FER2ptdWxrMDZITmR6ZVB6Y0M5?=
 =?utf-8?Q?0wWt0saVnGXBM1a46CQQAhPZM3VuK8UV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RS96OE9yc0FIaTcwS29uRUNqd3RTbGEvTUVRQXh6MmJMMFhrVGhpNDV6YUVr?=
 =?utf-8?B?MDhPSTVFMk1TdjYzRFI5YzdmVHZuN0VmdXBOaFhpdDNLdWJCQU9xaGIwRVN2?=
 =?utf-8?B?ZDVJSjlxbzc1K2hKdUMrRlAra0ZCaUxnTm1YcXA0NU5ZdzhsdWp3c1hic3hQ?=
 =?utf-8?B?aEJ3dEN3UWllNUhGRFJaSDkyaG1oTkRvN2d0amxiNElaakN5a1lockNuYXhB?=
 =?utf-8?B?T29zbVZZUk5QVU1tODBCK2crRkZjdFB3Rm80emh1aHdTcFlwVUhOQ3V1RXNy?=
 =?utf-8?B?VkFtWXpBRmxPMUQzVENjY1dUSmFVUS9BM0tRaVRzcktFYXJFZ1h5SUZCQmdS?=
 =?utf-8?B?TEZ5eHRydWhvOGVSNkpyaHlGODFZbUF3bVRwYUxEVGYxNW81VE1NK2Z6NTZZ?=
 =?utf-8?B?Rm12UlV4bHhVK0xKRFVjdFFENGg2a1hPODEwa3ZPVzFKV2RTTm9MS3pwMlda?=
 =?utf-8?B?Ly9rUUN6bzJXeUsvRWMxVHdmTEt0ZHVjK0cxbFdoK0sxMlBBTFBMOU5UZ2pX?=
 =?utf-8?B?Z3pORlNZYkFqK1UrWDlJVndyYXBqSzFrOFk0dUdRV1FXc29NU3B0YnVGRStW?=
 =?utf-8?B?SjVFK3RNTTA1TExLKzFyV0YrUzg1ZWJGYWdnNCtHanNETkxvTVJaWHdwTmdi?=
 =?utf-8?B?VmdzT0lkMS9MREhQd2g5SVdBSWl4VkNIU1BLckR4MnlNajd0OHZGNk95aXRw?=
 =?utf-8?B?Sm5RREt5WFIyOGY1TllVeFc2eFFsYWtwNnJ4NVg1c1NkWEpaTVpKSWxkTUpr?=
 =?utf-8?B?d016MlpDL2R0U2dHZUtqMEU5MVgvZ2dUck5yN1hBZjdqbFIrb1BTYVFuNUlO?=
 =?utf-8?B?NCtGaDU5WkhWalN5NWIxNUxnd0hIdHpqa29JbHg4TkdnTnJ5S3dnKzNVdTdh?=
 =?utf-8?B?SW5zWGIvb1FRNFhhRzliRUdXd2VZQjFaWEkzMlRkL2lPOTEwM0RYNWF1SlVO?=
 =?utf-8?B?WnpaaFBacm5lQkxPUXdIMkZsMGNlaW5wWmJaUlY1aTFzS01SZXczWUhqUUZs?=
 =?utf-8?B?MWVUbFFzdG5CYkpOckdFLzZsbURxODJWbUkwdUN2dDFTUW14cnZ3QzlzVjFY?=
 =?utf-8?B?Z3I0dDNneUFpWkFVbFdSUThJdlpNdWFsUHo3MnVJUFRmMGZrQXhIZVJaa0VL?=
 =?utf-8?B?NW42ODNoYzE4V2dKa1Y1QktrR2hjK3J2UG1mQVdwalpnUWd3S3NwNzNXcEJ2?=
 =?utf-8?B?YjRVVFpuK0tFVm5GUVF5b3RlY1lSMlJPQW5aSVFxUkRnbGV2aFZzbUpwZHR5?=
 =?utf-8?B?OXFST3RKRzVieElwMFEvZ3liNFZVeFU5NTR6emlqVWV0c0Y5aGdpRHFrT2tO?=
 =?utf-8?B?Qmc4SlZxWU96NVRqWXM4bkFkdDExRndFSUdkd3pJQVFoT2orZ3hsT1BGaG9a?=
 =?utf-8?B?WTRzeXkyYUF2U0VTU2lJZmJ1c21xVlZRT2trZllmZXMwREY1bTB0N1dxZnZ0?=
 =?utf-8?B?R0FIV2gwRHlpWHdMSG44Y1RMQnBZcktEd0tHYmtqMUcwN2hmY1E3VDJYZUht?=
 =?utf-8?B?TGcveE9FNlZqU1QxMmM3ZzA4ZmNGZWpEZWhVb3AyNnE4UjhjU0dYcmFoeFJ0?=
 =?utf-8?B?SldkcWN4NU0yMDNxNHdoNnRQcnpEakZlcjB4aHlsazFLSUhrSGR5Y2E2SWFN?=
 =?utf-8?B?dmxJb013WWgwZTBFZmdyUWh3TDJUNVhrdjNoWmREWHVlTkJRWWZhT09qOHpG?=
 =?utf-8?B?WGhuVWpMUUlNQUV1QW1FMW5XRkNkNnRhYmVjMTZxZ1pYRmo3TFhnZXZTUzFl?=
 =?utf-8?B?cWdqdXZtb21raFpOMTNURGI5SXN2K2x2Vyt1SEtSaWlxamZ1SDZUTzVZaGlF?=
 =?utf-8?B?U0FuVjQxNE56aFl3K1h3V1JYTkhMNEt5ZWE3MVdEYUw0amFId0JQeVowNWlK?=
 =?utf-8?B?WmxiWmIyV0llWDh6VDlQYWJPTmxzR21aL3FHR3VoV3ArZmNzbHYzWHpRSm5w?=
 =?utf-8?B?UlNYOWxiTEt3aXd4c1ROOWhtWFhLb1RKLzBoZXBCQTdVUlFUMC85d0xyalMw?=
 =?utf-8?B?TXQ1U3JqTlYyTkFaeEVtV2Frb3RPeUZTZkpKc2VJSkR1TXRjQzdaRkdoQUlT?=
 =?utf-8?B?WitDTWpCdVJMOCtkTk91OU83QVhEbGpnS3NkWHlEYWNEY2MyOFU2Nm1TcmpF?=
 =?utf-8?B?akpPcWRiSVBGcU9GSFpaWUV1MjdnU2NHS2RBdkYzTE1ZUUlSUFNWSWljV0o4?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba670040-0eb2-4032-1b10-08dd3e8c8e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 04:39:15.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Txfh7VVy53ps8NXHpwshw0ouNUBo5EBZPQj0vGALhCv4XFEHsQFrduiNPvkafts0EoBc601FJZ2HhMcyz/cORiMiMlAc92gIe6jKuqrTJocrpH4d+m0As4KtwgCI+7hM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12507
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jan 2025 04:39:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17667

SGkgQ2xhdWRpdSwNCg0KVGhhbmtzIGZvciB1cGRhdGUgdGhpcyBzZXJpZXMuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4
b24uZGV2Pg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjQsIDIwMjUgNjowMCBQTQ0KPiBUbzog
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnv
vLTil4vvvK/vvLPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHBh
dmVsQGRlbnguZGUNCj4gQ2M6IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHY2LjEueS1jaXAgdjIgMDAvMTRd
IHJlbmVzYXM6IHJ6ZzNzOiBiYWNrcG9ydCB0aGUgUlRDIHN1cHBvcnQNCj4gDQo+IEZyb206IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEhp
LA0KPiANCj4gU2VyaWVzIGJhY2twb3J0cyB0aGUgUlRDIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2Fz
IFJaL0czUyBTb0MuDQo+IEFsb25nIHdpdGggYSBjbG9jayBkcml2ZXIgZm9yIHRoZSBjbG9jayBw
cm92aWRlZCB0aGUgVkJBVFRCIGlzIGluY2x1ZGVkIGFzIHRoaXMNCj4gaXMgY3JpdGljYWwgZm9y
IHRoZSBSVEMgdG8gd29yaywgYXMgaXQgZmVlZHMgdGhlIFJUQyBjb3VudGVyLg0KPiANCj4gRm9y
IHRoZSBWQkFUVEIgY2xvY2sgZHJpdmVyIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyB3ZXJlIGFsc28N
Cj4gYmFja3BvcnRlZDoNCj4gLSBjbGs6IGdhdGU6IEFkZCBkZXZtX2Nsa19od19yZWdpc3Rlcl9n
YXRlKCkNCj4gLSBjbGs6IG11eDogSW50cm9kdWNlIGRldm1fY2xrX2h3X3JlZ2lzdGVyX211eF9w
YXJlbnRfaHdzKCkNCj4gLSBjbGs6IGZpeGVkLWZhY3RvcjogYWRkIGZ3bmFtZS1iYXNlZCBjb25z
dHJ1Y3RvciBmdW5jdGlvbnMNCj4gDQo+IGFuZCBhZGp1c3RlZCBhY2NvcmRpbmdseSwgaWYgbmVl
ZGVkLg0KPiANCj4gRm9yIHRoZSBzYW1lIFZCQVRUQiBjbG9jayBkcml2ZXIgdGhlDQo+IGRldm1f
Y2xrX2h3X3JlZ2lzdGVyX2dhdGVfcGFyZW50X2RhdGEoKSB3YXMgYmFja3BvcnRlZCBmcm9tIHRo
ZSB1cHN0cmVhbQ0KPiBjb21taXQgZDU0YzFmZDRhNTFlICgiQWRkIGNsb2NrIGRyaXZlciBmb3Ig
U3VucGx1cyBTUDcwMjEgU29DIikgaW4gdGhlDQo+IHBhdGNoICJjbGs6IEFkZCBkZXZtX2Nsa19o
d19yZWdpc3Rlcl9nYXRlX3BhcmVudF9kYXRhKCkiLg0KPiANCj4gVGhhbmsgeW91LA0KPiBDbGF1
ZGl1IEJlem5lYQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBhZGp1c3RlZCB0aGUgcGF0Y2gg
dGl0bGUgYW5kIGRlc2NyaXB0aW9uIGZvciBwYXRjaCAxLzENCj4gDQo+IENsYXVkaXUgQmV6bmVh
ICgxMyk6DQo+ICAgY2xrOiBBZGQgZGV2bV9jbGtfaHdfcmVnaXN0ZXJfZ2F0ZV9wYXJlbnRfZGF0
YSgpDQo+ICAgY2xrOiBBZGQgZGV2bV9jbGtfaHdfcmVnaXN0ZXJfZ2F0ZV9wYXJlbnRfaHcoKQ0K
PiAgIGNsazogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgY2xvY2ssIHJlc2V0IGFuZCBwb3dlciBk
b21haW4gc3VwcG9ydCBmb3INCj4gICAgIHRoZSBWQkFUVEIgSVANCj4gICBkdC1iaW5kaW5nczog
Y2xvY2s6IHJlbmVzYXMscjlhMDhnMDQ1LXZiYXR0YjogRG9jdW1lbnQgVkJBVFRCDQo+ICAgY2xr
OiByZW5lc2FzOiB2YmF0dGI6IEFkZCBWQkFUVEIgY2xvY2sgZHJpdmVyDQo+ICAgZHQtYmluZGlu
Z3M6IHJ0YzogcmVuZXNhcyxyemczcy1ydGM6IERvY3VtZW50IHRoZSBSZW5lc2FzIFJUQ0EtMyBJ
UA0KPiAgIHJ0YzogcmVuZXNhcy1ydGNhMzogQWRkIGRyaXZlciBmb3IgUlRDQS0zIGF2YWlsYWJs
ZSBvbiBSZW5lc2FzIFJaL0czUw0KPiAgICAgU29DDQo+ICAgcnRjOiByZW5lc2FzLXJ0Y2EzOiBG
aXggY29tcGlsYXRpb24gZXJyb3Igb24gUklTQy1WDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczog
cjlhMDhnMDQ1OiBBZGQgVkJBVFRCIG5vZGUNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemcz
cy1zbWFyYy1zb206IEVuYWJsZSBWQkFUVEINCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEw
OGcwNDU6IEFkZCBSVEMgbm9kZQ0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJj
LXNvbTogRW5hYmxlIFJUQw0KPiAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBWQkFUVEIgY2xv
Y2sgYW5kIFJlbmVzYXMgUlRDQS0zDQo+IA0KPiBUaMOpbyBMZWJydW4gKDEpOg0KPiAgIGNsazog
Zml4ZWQtZmFjdG9yOiBhZGQgZnduYW1lLWJhc2VkIGNvbnN0cnVjdG9yIGZ1bmN0aW9ucw0KPiAN
Cg0KQXBwbGllZCwgdGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


