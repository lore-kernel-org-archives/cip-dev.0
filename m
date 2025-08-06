Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667DC87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:14:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.19476.1754464455582826377
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=T5O3/S8m;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754464453;x=1755674053;bh=aBizt6+vTYn8Sz6k7qCef3mi5q8XS8qVEZhgjs1
	AXuA=;b=T5O3/S8mW9mkYBUPanJbIE2coV9YwekmGaADScdwL3e09I6Lbl4DAtGD8xaEXuL8eHLPP
	q90vYPcRFKtkn4hK6Ah8ALjr2fdZb8u0Uo0whZ63rH0d+QgVFakjP7wAeUyXHYmhUAmOZnbgiZrSr
	+F75Eb4wbZkvmco6RUcrRGRZ+EKp/a+0pIQcRjA7xTOSahGAVgckKpVxh3wN6P1vdFOViIWH50Uby
	Tge8e0LuDSoDlk0Gmkr07RdUqC5aPmiwK4zoAofD5rPuUFWEx6FvQsvrfP2n3kYB+hgFiK+S7x3zN
	euPHjiQILg9WsbfSKnr+IcNnptpqyqJhVH6K+K3Ewg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5767EC1H3969319; Wed, 6 Aug 2025 16:14:13 +0900
X-Iguazu-Qid: 2yAb5t3M3O21DtOqrD
X-Iguazu-QSIG: v=2; s=0; t=1754464448; q=2yAb5t3M3O21DtOqrD; m=5YYhMbIdMLw59iClvvvmcqHIA9ID0UHzzz7t1n9Gi7c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5767E7Vj2410875
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 16:14:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXNa+/bq79c4QgUu1MJt7hj+vHQ701ob2g5hllbIWGs94lzmq1QDLrpth6qjCDCunjWhzOHPY1NBz/dv2KRkNmthp424AQWrE8DvJrXiwZcNsPBl+/opvniG4gnqcZu7R0r2QtEnj4tegUFeTTKUHqKOq4OIVm01397GuQt5SgXRaWT1fdqglpvDPsliwUbL4eSkM2nDecXzPo21lf76IbEjXvYDs2PIi6O40C+IL1kxAw9/32WlD65UKxseimeeaOQGX0m/L1UiIQXAqJzajR25nu+myqy+dfocuvqFC1arctOtbHt/joPyqv1Ya83TUbin0qdr8DMyq96x1/eL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBizt6+vTYn8Sz6k7qCef3mi5q8XS8qVEZhgjs1AXuA=;
 b=m4kHPNBXVUBW3t9IbFl6zMw2aWIbFYBinziopJTmwDBvN4ztf/y4AR8ERmjeTxu1I106PIfdrHTIVqUCcDnaNbAU8SjPAwHk1qn+LTZIDBPVXe6qCytNuFvOKipRVEKx6pc6+xSJJ9JWezFCi11ws50DoaRjp5pzZQYiwTJWkPnA6hJvcI3aPDt4k6IMEZqzDKYzG7sZn+C7/YVn7NzqET3DOczQKi2rW5BpXLG8T6FTvwh0yyE+FvtO+MmVM+/5YtMK8uFTzwtV6SNz+yE76SoMDzQms+GLGVEd7wyMpc1RX67QSQtF3/izJXbMeylLx6NRANIyTsJfm7uVn11zmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
Thread-Topic: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not
 install kernel
Thread-Index: AQHcBpIgOmzYuwbGeketUM1Yw7g8VLRVMqcAgAADQlA=
Date: Wed, 6 Aug 2025 07:14:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189CCFC6B8EBF8B39A786F922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <68a235ad-709a-448e-acdf-d206a8428fdd@siemens.com>
In-Reply-To: <68a235ad-709a-448e-acdf-d206a8428fdd@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB15566:EE_
x-ms-office365-filtering-correlation-id: 64c245b9-2fdf-45c0-2018-08ddd4b8d39d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YjlxVUhzVXdYR1h5V2w4dzhnUDVvYlB6WGVaWWt3OSsrZXhLZFBXdWw1MHdF?=
 =?utf-8?B?NThhTlAyZHZWMENvOUtwSGhXYW5PUG9DeXZrdkJ3WkZpbGFlNHpCR3ZneVdH?=
 =?utf-8?B?blhHeG5IL0dYUEFLNlIrM1BFL2h2MkZIaEJ1NDNpUlZMMDFNVElZS2o1RGNU?=
 =?utf-8?B?bmxMMHdOV2xFY0ZWcldEeEFOdmlsbWVwSzg4TTkwRnN3WjZ5TjIrT1lJYjBD?=
 =?utf-8?B?RUFPdXJCK1E2b25qTXZEN0pVZnlvM2I5OWs1eitOK2p3dWd0azNPdVY3cXRt?=
 =?utf-8?B?WHh2ZmNJT3JLSGlGWlI5VHc2eCtVMWNOWXgwaVpNNW0reTBGR3k2S01PcUF5?=
 =?utf-8?B?enVhWkk4M3pnZGUxUkg0TlVFTFNwVGF0ZFhVSHlMU1VvOVJUdW9OaE95ZUEv?=
 =?utf-8?B?RDNvZHUyVSs3djNpUHJuRGZnTGlJQndDYmQ0SFhBQS9CckdhREJid0poeHFN?=
 =?utf-8?B?ZVJHK2RFSkpiN1ZVVVVtbExOMkxQZGF4NHZ5UWxSL0VYQ3FvVkYrelQ1czdq?=
 =?utf-8?B?cDRpL1EreGdqYlRaQVJLVHBjeG5YcCtSdDByVDVwTWRwbkZOZjNpQUNHMkdX?=
 =?utf-8?B?d1JkRnk3dW1TaUJhdDV1Y0poWUxoRzkrZVBSQmxpUmtrTDJxbVdvK0dOd1pn?=
 =?utf-8?B?TlJKVEhQbzZSNklXa2ZNNDFYNXZTZGlWRWU2aWRTK2Q4enNvSHlLT0VYa25a?=
 =?utf-8?B?b2pRek5BZWVIeFM0WjhZcGRBc245cVo2TXBoRTZnOFN0OUxFK3FMaGpkRnJv?=
 =?utf-8?B?NG9ObW1STWxEKzRkQ3Uyekl1ZXlYdDBLSGVoK0VWY3hIOXkwVk40emlSajNl?=
 =?utf-8?B?dzhjZ21hbXZtTzRiZy9hakRQRTBNbk5vUHlGQnBRZFU0aWZyUHM0NzNQTWNw?=
 =?utf-8?B?UEYyWEdLSGY5MWloeGxoMjRFMnNSZ1ZwS01sakpPTnlZOUZuS2F1RStGT1gx?=
 =?utf-8?B?Q2p3VVB1MXpPdEFPRTViVXpxSFBZSjZTMk1nbmpjaTU4M2IzeDlPaFdWcE81?=
 =?utf-8?B?MkpoZWxCenRSVFV4K0xibFdXK0ZOWjlQbEE4TWpKaFBERXM2L1dNbzBmN1dz?=
 =?utf-8?B?NEVCbXZselZ2VmNUN2FkKzFJdDhQWGZwVE1ha0FLQzF6WGU1Nm9HSW4zeURn?=
 =?utf-8?B?cm8xOVREOUM2ZWtFaXNER3poQnhVTmhYdGU3WXpXbU1sOG1iUUlBNkFrVkRL?=
 =?utf-8?B?dnBCK0U2Uk9JcHhTbXNMQW9WamJSd21DYWUrejRReUtRZFprS0djcGEyd29h?=
 =?utf-8?B?YkdBOVJ5NUJrVkhMR1BTRWpWaUpONWU5UndLRUxCcU05RlF4ZG1tMDVEcU44?=
 =?utf-8?B?YWZQRGFLb21Sc2gwdVpEM2t3Tzh1aHNCNFc4MFFrcnd3ZDRuay80d3pwcE15?=
 =?utf-8?B?UXdjSkJnRFhtMjl2eW11ajd2SjQ0RkxibzlpcWNBZElhbXY0eXFUakVQaDl0?=
 =?utf-8?B?THBEalNRbTl3YnRISXpWb1JVM01YWXlka3FHa2RibktFRXRUdFJqMGZLOFlL?=
 =?utf-8?B?ZnhnTGpYTlRPUTBqZjNYNVZtZlA5bWFobDJNem9WNVh0UkFHVzUxbGpPdnN6?=
 =?utf-8?B?Q3JPOU5lbHlXbVVmanNmaUZLb000NXlPZlJvMzRoQVh1MEpEWlVoTWt3ejJa?=
 =?utf-8?B?Y0RxaExBVG8rWFRnR1laamFXVFhGZ1lmU1dLdER5UDFRUFZLN0grUGp2b1dG?=
 =?utf-8?B?K1loaG9EOURjamhtOW9JL0Y1d0RJaldwVjV6TzFLTGFuVVNGZU9acHhLWHN2?=
 =?utf-8?B?L3daODBod2NOQ25tczdDNHA4R2g2MjJZNWRpZ0F4WWtoZWd6bythckJ5ZGt2?=
 =?utf-8?B?U245YVk1bHFXSzdoQjJ3azhTTXAzZ1VuQVFyellScGQxSDRmT0VlR0I5QkZp?=
 =?utf-8?B?eENralFhTTFaelprSnI4THk4Wm9KNC94RFBwM0h3dFg5K2dTcmZtZHk2SXVU?=
 =?utf-8?B?bWVWSXZYSUpNU2Jic0NSdVM1aG42RVBuZThFMGpiVkZDOHQwYTR1UStpR0lq?=
 =?utf-8?B?T2xqTWlTWkR3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TGMyMGlVSFhTSHppTUozNnNuZHNmbThrQkN4RzR3SjZTcm02bE1UcjNKUEpx?=
 =?utf-8?B?S1dhdWw2TGMwRHlHQklzbFBSTUtGQzh4MGhxWGZIUkYvWW1lRjJ2RmJ3MlEr?=
 =?utf-8?B?WVVlL253MTlzOVE5eHlKQmxUNzZFRGFrWWxRajlUUzlWMm1yWmRsV2pSMFgx?=
 =?utf-8?B?cUVqbnVaaWVCY3plNVVhbkVTUUp1OWhJejhhWktZdlRzMDFIeEg0TzFIdmpT?=
 =?utf-8?B?L29uTkxLRE5PYVkweW03U29QSFdnWHVNK1p0cXBZWnVTcXNjODIzTkNrT2NN?=
 =?utf-8?B?S25McjJDeklHN3R2MlNxR2gxNmh2ZHpqVHJwbEZWMTZ6dTVJdXFpc0Zsb0F2?=
 =?utf-8?B?M1dYanlhUm00SUY1WUIxakhjRTZyMUNwNEcxa2lGdm9RVnJFMFN6czU5blgy?=
 =?utf-8?B?T0lTVGx2Mk4vZU43TFpTeURudWIwTzlMZkNHbCtUVW5GUTExV3o1aDhidXcz?=
 =?utf-8?B?NnlIaFJndEphZlJDcWdkbjUvUlJXQ2ZxeHU5LzVZRy95bmdCTlg0TW53Um9L?=
 =?utf-8?B?Y1NNaXNOMGVraEdzbHhGRGllRHNzTFRBcFF4MlpvbTJmVXA5RE1zb0FrbTdj?=
 =?utf-8?B?U1hGRmtJRlNBM2xMK2VERVRsYXN6N1R0TDBVemdjOGw0YTM3MnphVVhPUUtK?=
 =?utf-8?B?Smx1WVVWWXFlTTV0anYxUG5Nd0xuc3JtSWtMNGluNkhvb1hyQ2NkbFBQMGpm?=
 =?utf-8?B?U01tcUtFU1lLQjFaS3VGZ1ZySUlXUG5samdta3lBQlBEcks2N2VZc1MwS25v?=
 =?utf-8?B?WXRwM1ZWc2R0aHlzTnpaanBzekF6QUo3RVgvcFpxcDJNek51WXJ2ZkY3d1ZW?=
 =?utf-8?B?ZW5CWk9BSndNL09ObStWQlVJcGVzRlQwYi95YVRHMDhqdU1WcXRIOEtLWTQ3?=
 =?utf-8?B?M1FMQmRSazVLNk5KU2lOcDVWRDU3UmVlajVaeEdRUGhtYkcyS01vQ3NRb2xM?=
 =?utf-8?B?T01wTlFiVnR0aUt3RGY1ZGZxNUFBd0MzdWtWbmwrUVZsRVFIWUJJR0oyTDl0?=
 =?utf-8?B?VXB4MW0xWTVaVDZmRTF1YWFhUXk1NktqTlUyaWNkWmQranlQU3c2V3ZUTk1B?=
 =?utf-8?B?OXVqek5xR3RWNndsYkM2ZFpqRDBQcS9ENCtQOTR3ZVU5MGJvYUlvN0FMNGRE?=
 =?utf-8?B?MUVmQnpXbUt3M0I3YllublYwY1lKdW1SaGorUXNkYjdlYlAzTzZMWkRTMDZQ?=
 =?utf-8?B?UUJBVnB2S2V0YVM4TUphaUJrYkVtQWErcm1HMy9SWjNhZDRFRWordnhVODdD?=
 =?utf-8?B?NTgycjhLR2xjUzh5Q1FhaEJtSzRKWjRPN3ZUK2JEYnI0RkpabzNxNjdvL2xv?=
 =?utf-8?B?YmJmUzVLcm9IeWJ4ek1ka3RFTUIzM2RicnRySU5tVTlvc1JQY2x2aEkxb29T?=
 =?utf-8?B?eENLd2MyTXZORlNLemJSaVFneSt5YUVFeWc3L3lUbXRKVlZnd0dFSWFVQzYr?=
 =?utf-8?B?NWhIc3B3R2Z6dk5JQUNqUTdmTzBWRGpSUUNPQUh1TW82L01wUW5FNlhEbjdo?=
 =?utf-8?B?aFByWVNNZ1pBdEdmbGdqa09ha09lMUR6OGhheHBVbWlZR0JQR3BBYUEveDJJ?=
 =?utf-8?B?dVlTeW5GNHVDWjZYMFQ2T0lVNGhYdWMzWU10NHVMNkNkTk9ZUDQzeGo3MWh5?=
 =?utf-8?B?K2k3YlVJQWJXMkFYM3BoNDBrek91TUxTTXJiSHVpMW1pbEhZSkhLZTcwYXZZ?=
 =?utf-8?B?aHQwTlJRd202RjEyU2VWMEkxM3FZMkUyQ1FwRkE3eFVFdjF6OEp5OXVzbzFz?=
 =?utf-8?B?eGVaZllESktvc2Zaa2Y2czFrcC93Q3hiTXNwYm83ZjFxcWpWaGNKT2JIeHpo?=
 =?utf-8?B?aU1lQlJiSWYrbHgrdW9zczZyTXdiSDV3MjY3YmZ5Mno3bHBYd1ZwcWh2WUhm?=
 =?utf-8?B?TXlMMkR5Vjhnam1lTUhiRGQvRFZVdi9NczJlRmg0OGgySHJKV1ZGR1NzU09R?=
 =?utf-8?B?Qzg0VUdaNUZhZ0hvRlI2TVQ1a3lrN1QwWE5VK0lUZHJoSUVhOHl6aDNuNk5O?=
 =?utf-8?B?eFg4aHQ4c0FxYzlmdkdaakN0VTZLT0swQ3RCRzcxdldmdFRlcTZjakt3TStE?=
 =?utf-8?B?WTVvWXM3MHJoQnZPVVd2ZWxQaUVlMXhyaWpTTFlEL043RkFEaXgwUzJSSDI3?=
 =?utf-8?B?b0NuMjBuUkZLek9wTnBYcmtNWmVFblVWa3VCOGJrV2JOTHNrTTdXdUgrQW4z?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c245b9-2fdf-45c0-2018-08ddd4b8d39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 07:14:04.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSxQp034JgVo6JokHLgxI11mfvvUx749rHoD3/uAYDGL4ObQ2FUaQxAwY7ki8MzpGkNc4VcCqZSbCXPhufI1eOse/SXh7jEUBqSJmk6JmsFoG23vBnX8ROTjxBqf67ZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15566
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19686

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1IDQ6MDEg
UE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj
4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENj
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2lzYXItY2lw
LWNvcmVdW1BBVENIIHY0IDEvMl0ga2FzL29wdDogQWRkIG9wdGlvbiBmb3Igbm90IGluc3RhbGwN
Cj4ga2VybmVsDQo+IA0KPiBPbiAwNi4wOC4yNSAwNzoyMiwgTm9idWhpcm8gSXdhbWF0c3Ugd3Jv
dGU6DQo+ID4gVGhpcyBhZGRzIGFuIG9wdGlvbiB0byBjcmVhdGUgYW4gaW1hZ2UgdGhhdCBkb2Vz
IG5vdCBjb250YWluIHRoZSBrZXJuZWwuDQo+ID4gVGhpcyBpcyBtYWlubHkgaW50ZW5kZWQgdG8g
cHJvdmlkZSBpbWFnZXMgZm9yIGtlcm5lbCB0ZXN0aW5nLg0KPiA+IFdoZW4gdGVzdGluZyB0aGUg
a2VybmVsLCBrZXJuZWwgaW1hZ2UgZmlsZXMgdGhhdCBhcmUgbm90IHVzZWQgZm9yDQo+ID4gdGVz
dGluZyBhcmUgbm90IG5lY2Vzc2FyeSBpbiByb290ZnMuIFByb3ZpZGluZyBpbWFnZXMgd2l0aCB0
aGVzZSBmaWxlcw0KPiA+IHJlbW92ZWQgYWxsb3dzIHlvdSB0byByZWR1Y2UgdGhlIHNpemUgb2Yg
dGhlIHJvb3RmcyBpbWFnZS4NCj4gPg0KPiA+IHdvX2tlcm5lbCBpcyBmYWxzZToNCj4gPiAgIC1y
dy1yLS1yLS0gMSBpd2FtYXRzdSBpd2FtYXRzdSAzNTFNIEp1bCAyNSAxNzozMQ0KPiA+IGNpcC1j
b3JlLWltYWdlLWNpcC1jb3JlLWJvb2t3b3JtLXFlbXUtYW1kNjQuZXh0NA0KPiA+DQo+ID4gbm9f
a2VybmVsIGlzIHRydWU6DQo+ID4gICAtcnctci0tci0tIDEgaXdhbWF0c3UgaXdhbWF0c3UgMjc1
TSBKdWwgMjUgMTc6MDkNCj4gPiBjaXAtY29yZS1pbWFnZS1jaXAtY29yZS1ib29rd29ybS1xZW11
LWFtZDY0LmV4dDQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPg0KPiA+IC0tLQ0KPiA+IHY0Og0K
PiA+ICAgLSBGaXggdGhlIE5PX0tFUk5FTCBjaGVjayB0byAnZW5hYmxlJyBvbmx5Lg0KPiA+IHYz
Og0KPiA+ICAgLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gdjI6DQo+ID4gICAtIFVzZSBL
RVJORUxfTkFNRSBpbnN0ZWFkIG9mIElNQUdFX0lOU1RBTEw6cmVtb3ZlDQo+ID4gICAtIEFkZCBi
dWlsZDpxZW11LXJpc2N2NjQtdGVzdC1ub2tlcm5lOyBwaXBlbGluZQ0KPiA+DQo+ID4gIC5naXRs
YWItY2kueW1sICAgICAgICAgICAgIHwgMzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiA+ICBrYXMvb3B0L25vX2tlcm5lbC55bWwgICAgICB8IDE3ICsrKysrKysrKysrKysNCj4g
PiAgc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggfCA0OQ0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBrYXMvb3B0L25v
X2tlcm5lbC55bWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5naXRs
YWItY2kueW1sIGluZGV4IDYyOGU2MjQuLjQ5NmE1NmQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS8u
Z2l0bGFiLWNpLnltbA0KPiA+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+ID4gQEAgLTI4LDYgKzI4
LDcgQEAgdmFyaWFibGVzOg0KPiA+ICAgIHN3dXBkYXRlX3ZlcnNpb246IGRlZmF1bHQNCj4gPiAg
ICB0ZXN0X2Z1bmN0aW9uOiBzd3VwZGF0ZQ0KPiA+ICAgIHNlcGFyYXRlX2hvbWVfcGFydGl0aW9u
OiBkaXNhYmxlDQo+ID4gKyAgbm9fa2VybmVsOiBkaXNhYmxlDQo+ID4NCj4gPiAgc3RhZ2VzOg0K
PiA+ICAgIC0gYnVpbGQNCj4gPiBAQCAtNjksOSArNzAsMTAgQEAgZGVmYXVsdDoNCj4gPiAgICAg
IC0gaWYgWyAiJHt3YXRjaGRvZ30iID0gImRpc2FibGUiIF07IHRoZW4NCj4gYmFzZV95YW1sPSIk
e2Jhc2VfeWFtbH06a2FzL29wdC9kaXNhYmxlLXdhdGNoZG9nLnltbCI7IGZpDQo+ID4gICAgICAt
IGlmIFsgIiR7c2VjdXJpdHlfdGVzdH0iID0gImVuYWJsZSIgXTsgdGhlbg0KPiBiYXNlX3lhbWw9
IiR7YmFzZV95YW1sfTprYXMvb3B0L3NlY3VyaXR5X3Rlc3QueW1sIjsgZmkNCj4gPiAgICAgIC0g
aWYgWyAiJHtzd3VwZGF0ZV92ZXJzaW9ufSIgPSAiMjAyMi4xMiIgXTsgdGhlbg0KPiA+IGJhc2Vf
eWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvc3d1cGRhdGUtMjAyMi4xMi55YW1sIjsgZmkNCj4g
PiArICAgIC0gaWYgWyAiJHtub19rZXJuZWx9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPiArIGJh
c2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvbm9fa2VybmVsLnltbCI7IGZpDQo+ID4gICAg
ICAtIGVjaG8gIkJ1aWxkaW5nICR7YmFzZV95YW1sfSINCj4gPiAgICAgIC0ga2FzIGJ1aWxkICR7
YmFzZV95YW1sfQ0KPiA+IC0gICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIgXTsgdGhl
biBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaA0KPiAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4
dGVuc2lvbn0gJHtkdGJ9ICR7Q0lfQ09NTUlUX1JFRl9TTFVHfSB3aWM7IGZpDQo+ID4gKyAgICAt
IGlmIFsgIiR7ZGVwbG95fSIgPSAiZW5hYmxlIiBdOyB0aGVuIHNjcmlwdHMvZGVwbG95LWNpcC1j
b3JlLnNoDQo+ID4gKyAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtub19rZXJu
ZWx9ICR7ZHRifQ0KPiA+ICsgJHtDSV9DT01NSVRfUkVGX1NMVUd9IHdpYzsgZmkNCj4gDQo+IEFu
b3RoZXIgY2FsbCBzaXRlIG9mIHRoZSBzY3JpcHQgYmVsb3cgd2FzIG1pc3NpbmcuIEkndmUgdXBk
YXRlZCB0aGF0IG5vdywgcmVzdWx0DQo+IGluIG5leHQuDQo+IA0KDQpJIG5vdGljZWQgdGhpcyBp
c3N1ZSBhbmQganVzdCBzZW50IGEgcGF0Y2guDQpUaGFua3MgZm9yIHRoZSBmaXguDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg==


