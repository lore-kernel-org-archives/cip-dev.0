Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13731C624CE
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 05:26:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1094.1788240387446736198
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2026 22:26:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VomlxZqr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1788240378;x=1789449978;bh=qJFK2MJDLiW9Ynwt+8YZE8AkRg3EDhruu34Hm
	JgNhMU=;b=VomlxZqr1Uxo5LKfsDEvGEitWBA9YDhOBXOziw9SATZfRH2kxaCboOzyN5o7k79Wi5m
	Hq80jWdsce+CO7PJOf6kuEHYK3QfdsBZjg6XjMR1FKxtzR7BKrYoO72lkF8wPF0AH8fSk34b3PDyc
	7TgZ/IPOT2vl51/9KeDzIW5uiewi9ACvOQjQSQfgd3w3Euhhpr1ELK1VGtA4TzF60vfzW3UP3HUW9
	Gwj93w7FgvrLFhhIraKjLxsNOHM5e1vGWsyMw5+Ec02OpHJud3XTCBqFuPa0eHQslgnAm6mk31V8Y
	dFg0opuzGjyHH4fpWFxRPeIrqBn7n2ANQCyYlWPU9D/Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6815QHRP3999614; Tue, 1 Sep 2026 14:26:17 +0900
X-Iguazu-Qid: 2yAbeCtgx97tshwjSa
X-Iguazu-QSIG: v=2; s=1; t=1788240377; q=2yAbeCtgx97tshwjSa; m=mBK59Bg46hFP3JZh9Oky/6Y7moVbOWkDuJmZ/wIph1M=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hYvV03NlRz1xnh; Tue,  1 Sep 2026 14:26:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK1V8I6NxVB4XWMGbk2+PACo8P7cAwyFdCpuIpxS/kK6wzijIJrldNYdPnF7F5uAxbpfH4aaJj7cupMkdrZg5dDeJjn9MAQfkdpw8CeJBZMRmP75F554squUlmYs78f+FyTbi0ZJPp0eFtuno8KLqwf2J+xp36jqZce6WyrUAVmS/kcYPQ50zpznlKJCEEgEjn2R8oAWpQrTMR0Vjj30zxkLtc4TscD3oZjvAJemY2zswNruTPbwKjvLRb3anwGOdyGEwK+fOJ7JJjPjF4hqwuqKozb+crUhKcmgYI/v2sDT76R5VPeToY77QnoKagJ2ci53yA4C+3zM8Jmrj0sLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJFK2MJDLiW9Ynwt+8YZE8AkRg3EDhruu34HmJgNhMU=;
 b=RizZHJPzemCRrAqoP+tuQbs6uihCVi/qWJCTZS5wBnaMYXonylRgoGqmcxjTVaLX9gOUOitpX944wzJf3k5KCPb/PFHTw58j8PwIUit3dQTh1Sy6++zOLtrJOYjzqUzCF94cvGnDNhiulkZXkFzjezHtLiSHV7Eahy2zsI0QqgXPmRMb4X07UKG7TvX4GiRK4GHF8l1BPfd/hjZjhDxjGu75swCWGHr+GqkGXN0ftRjNVeTx1xZE90Kj3eGGRZTDjdDewsRXIPyVi2WF8ngOfvfYSy4baLQMM34INkxt87qkd2wRo8FMUDKfRClZieL0KWElpAzgJIN5RIYHhHKdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 0/2] Fix for module build in
 ohci-platform.c
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/2] Fix for module build in
 ohci-platform.c
Thread-Index: AQHdOEttww/WRfMaGEaoGGkdnyMd5ba5NAvQ
Date: Tue, 1 Sep 2026 05:26:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818AC356973A9BFA58AD066CDA82@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <apPR31SYTp9fma2-@duo.ucw.cz>
In-Reply-To: <apPR31SYTp9fma2-@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB8689:EE_
x-ms-office365-filtering-correlation-id: 6153595b-d272-4a9e-3392-08df07e988eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|4143699003|11063799006|18002099003|22082099003|10067099003|56012099006;
x-microsoft-antispam-message-info: 
 vo6Xjl7m3meol6OGUmbg02ZkotFp9j55HJ9zxjakuAVBOoWwLUkEi9Vqri9cGaIGNxKq2V6rM0O6nttG9t++/bXUh8VsbpBEVlYJ/4XNffLg5pwT61lAu3h7wE7HD/TEuUQHS6JvMARuzHiewQsLXA4fLATeCMAFR0zWBsPFilJTSy6k2qCBjFaDQr2Cln3oVWb1f4HwlBQ8iFvlLGu2HNrz9Tzx3ZJ5rZTRf0rC0vYoc0nZG6+cn8aFspPASZc1V8j6dgCYJdOGo8YNPrZkCIwn1sOo239ZHZIAinlJzGw+9ii7bmL4HH0F93JW8P9BFszHR35XBzyzUPttcIYLkJYBWsScuZBT3cLnj4yn52LPaW/CCpaTJcsRmBAEK/+tsnC5IC006oIHKBh9UCSFIHtdXh8DaF19/8fl+EtVfM3uhOKV7BRe4wZed+W0XQuIdAhCYQh5+jnr1jNTiofWl95y6MHPFPULJax8WHKkzuhKFZsKoFk7wu+ENTcL0h+9NMmYdqMA4szXW/nOxJmVb0WUOiq0o3aeX6cojya4MrcUBZ2CWeFq0iYFTIW7XgcCxOFvtuK/hWtU/reJtpouEops9oTX2RHkw6BNxm5sz1FibRTyDcWKXpu4Eml5nztQs8dT3Jldbf2WvvabomLhbBBcPbSqWxAHoH6zwjTkU7rYX7MdcWgW5GlFXT1keczpTYaMqPsknBBHHEj9BqPPWu5zOGxarmtIbHmds4yW9JI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eVozVFB3eE54aVVLU3hzelFDdXVvU1FHdmlOaUFxdmprQnp5Z0djbWpxUFVD?=
 =?utf-8?B?UERFZUJJMkVyUTZrUGlpSjQ2Y1NmVEZtUGMzc1dnWVJqbTUySG1aTTlHRllJ?=
 =?utf-8?B?SEFvZG1vSzEzM3VEZjRER1B4VUx2UVdvbjl3WURIczNiK1MzejNONE1hZlhr?=
 =?utf-8?B?T0xpTVhwUTNJVjFMeDZGRzBISTg2QU1wajU2RjNCWHpCblcyUUlpNzFBQkNj?=
 =?utf-8?B?VGkraTJiQ2VjcDFPYlJwOEJheUZlK3ZGeExJN3RybVpKbGZ1aEJIcjM1UVdW?=
 =?utf-8?B?UXl2aG5HVUZyc0piODVDeTFydWdjNnNUZ2VpRG04WTZjNERQZzZWWHJISXRI?=
 =?utf-8?B?Q3M4Y2ozeUNqNXVPRmxTUzFMUGdkcEllQnVwY2EvdDdCdmNHRUF1dmtDb0tz?=
 =?utf-8?B?Tmk5WndURGszK0FOWFhWdDJ6QythMjg5cC9SYys2akNYSjNRZjl2U0lPRnh4?=
 =?utf-8?B?WnZscUtxMmExSXEwNFY1bEowbTVRMmpnYWx4Z1NIZUhjTGZmU2NBRzlwaUxn?=
 =?utf-8?B?c2pDUXlOeUY5VzZVZ2pYd0ZaRlMxaWx3cWtkV3paME1xckN5QXpwMFlWNUFa?=
 =?utf-8?B?YUhoVUg0dUp0d2hnbUQyTXFOcFh1ZjUzSWZveU1LbUhrVUFnb1BxNW1CRE9E?=
 =?utf-8?B?Qy9YVTFGalEvQUx3eEZMRFR2b1BGdmZST3J3cjJRUis1QXQ4WXFFTEJ3RjVC?=
 =?utf-8?B?YXZPbXNUNE1WWE15eDhGSmRmMkV0QStQUEQrRWhpaitxN09nSzVtR2FGS09F?=
 =?utf-8?B?Z2JMcDUvaGJabVk3MlJiTUgrbzg1SXJhQ2tleE9aZ0d3Vmc3aDJIUEJrcklF?=
 =?utf-8?B?QWRPb0VSdU56Tlp5N0EwQlVETlJmQ01UUUN2Z1UxSEQweVV4M3VzdjhSVmlY?=
 =?utf-8?B?SllFakxnS1RmT1dvdXJtYUVlWXJCSjRZdXRjdHFPNGQwd2tPV1RaVnBSQ3Bx?=
 =?utf-8?B?VDhZV0RMT3d3dWhlQ2pHMDFkMTlxUXpuV3R3N1NUeEtDNXlMbUNpVlEvMjVr?=
 =?utf-8?B?a3F3aXdWcHV4aHdQTVd0YngzTnE4Wnl6bDNKR1BWZXNzQU1LZFl4SXpXd0xX?=
 =?utf-8?B?L3Q1ZDhwZVVVL1NCTEE0NS9LcnVtZ2NIZEpOUENvaUpkLzdKc2gzbUpyYTJo?=
 =?utf-8?B?WkhQdVVaQWNyenRCTDZKWThJTWVnMW5xWjVIQmMxTllUdzhwL2JqS3ZIWWZI?=
 =?utf-8?B?bzh5V202d3ZZZlRVbEZoYkhKd3loUElBOHFya0N4dC8wbkdnaFRBSDdlZ3JD?=
 =?utf-8?B?a0dzcENqdXp2ZHk1eHlIL2NxZ2ZycWNycGIzRDJSRVJiYVhzWWVUbkJoMVBP?=
 =?utf-8?B?TTJ0OHMwcjFXTkdSZlU0Wjh4NTdBcWNuTmF0UlRzUnlQaVl4eHBmQSs1aGVq?=
 =?utf-8?B?bVE1enhYMDlVa3NWYlpRRjdkRE05aWFDUHZpa3g0VTRzMUdlUVQ3Q2J5M1dv?=
 =?utf-8?B?Um5UOThUN0R1SmhhUkQ1RDd6eEZYREVMNWFDUEhFMHpnWlJMWitBT3NZSG5w?=
 =?utf-8?B?Q05VelZ1NVNnMU5yK0tNZy9FR2YvZ09iejVVU3VNdzFQd1R2d3cvMmpXQkMy?=
 =?utf-8?B?N0IxWFVsY0JBdWduNi9CRjVnUWhqVHBKZzhOMUx6VXAvYjJMTThMRlR0NFdr?=
 =?utf-8?B?YU9rRExkRzd4UFpyai9jaGJ2eGE5djdrSCswZEhSLzJkNDZCT1FjZThlc2Jr?=
 =?utf-8?B?WUgwMmhPVTNpdlhmYkEyaUJwblFBdlU3eUF1WU9QUmF0SmFkcXJtQTF0bGpT?=
 =?utf-8?B?Q0xJNVg3TzNEWW83V1VvcnpINzZiK3NMSVc5SVR5elZTUFA3MUpDaTdpQmhU?=
 =?utf-8?B?SU9pOEJiY0xlTkQ1WDZtbzRpV0Q3YTdSeUlvQStHbGJDd0VqTHlaZXpVQW1a?=
 =?utf-8?B?RFRXRS9BV2poL21ZSjI1TTJ2V2lxeW8wTk5FOFlNMUpLaVVOcldIcDZ2YW1S?=
 =?utf-8?B?MUl1eDhFa1BUTG1SaDg1WkNRMTNqOERwYk5ucFFOcVRaVjRLWW9BRjdpbkxB?=
 =?utf-8?B?cXU0dWJwUXppMDdIa0tIcCtzT2lxQnJMZERPQ2d2TEhXbmNiKzJKVVBpQ2k3?=
 =?utf-8?B?VjhPYk9jejMyQmRxeGhDK1hESDRFWkZON1pWM1NlMjFNRlZyLzZVWmVQZ1pL?=
 =?utf-8?B?Q1A4QU9KcEoxd0VTWG8wQVNUck55WmVuakttOFVBSEI0VlRISlN5VWtiOHl4?=
 =?utf-8?B?RmhtV1ExeVY4V0pXWEpBTFBxNmd1OWYzY1dXVGVZOHY3QXM4OEx5a2NYSjVP?=
 =?utf-8?B?aHVvUys5d1JNQlc3UlliT2lscDVCRExUNWgxZkMrSENFZWN5WXMwclNpdkQr?=
 =?utf-8?B?Vmt6Z2VEdlp0UU1RbW96MWhMUlVRQ05KM1Y1VjFkd0N5K0tQNllOVTVER1Js?=
 =?utf-8?Q?n9TwYGwx9j8eo+SY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	siLI/isL9PjY0HZ5mULPtzsjB89SAss6nX45AUd6e7Em42CgLF4T8IBQsNiEaCVlgZh3xrV+vp7i3cbzvGLD7RTAiKQNFin224yGUh8rzHZEcf8Nvu2f5dnVMoDK7nQijtln33FypDPPIlBJtyfp4mSB/pzR7hro16QWLjQkTdIgNPkbbRcqtH2/7Q+87kHyuLsl8QGFFKsAhbQbHbUTLW+mAhb7+afb5z3FRj38tc2azcUWpwmY7qqUqOsUxylz7i+HCTNXLve6aH+MldJbqNUFb/IIbSdxX8weN7izOTApaKxKo7zgo402Eowlo/DkjM6tNcmaUa+e7K83Hip9zw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6153595b-d272-4a9e-3392-08df07e988eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:26:11.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKKXfqf2BqpZuxzuDBHe8oPdrIs3/2BTfmdvuV8sj5dm4+KeT5jXltuJD4s1GVPbrfvGK9G5iDlayZ/d0aPTrKP+ATmUmlph8hzN/zXR/sqUWHprBzAv0LbXuIVns0Ua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Sep 2026 05:26:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24049

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBP
bg0KPiBCZWhhbGYgT2YgUGF2ZWwgTWFjaGVrIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4g
U2VudDogU3VuZGF5LCBBdWd1c3QgMzAsIDIwMjYgMzo0NyBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpDQo+IDxub2J1
aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc7IHBhdmVsQG5hYmxhZGV2LmNvbTsgdWxpQGZwb25kLmV1Ow0KPiBjbGF1ZGl1
LmJlem5lYS51akBicC5yZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRD
SCA1LjEwLnktY2lwIDAvMl0gRml4IGZvciBtb2R1bGUgYnVpbGQgaW4NCj4gb2hjaS1wbGF0Zm9y
bS5jDQo+IA0KPiBIaSENCj4gDQo+ID4gVGhlIGNvbW1pdCDigJwyMmNiMTA1MTllOGYgKOKAnW9m
OiBBZGQgb2ZfbWFjaGluZV9jb21wYXRpYmxlX21hdGNoKCnigJwp4oCdLA0KPiA+IHdoaWNoIHdh
cyBiYWNrcG9ydGVkIHRvIDUuMTAueS1jaXAsIGNhdXNlcyBhbiBlcnJvciB3aGVuIGJ1aWxkaW5n
IHRoZQ0KPiA+IG1vZHVsZSBpbiBvaGNpLXBsYXRmb3JtLmMuDQo+ID4gVGhpcyBmaXhlcyBhbiBp
c3N1ZSB3aXRoIG9mX21hY2hpbmVfY29tcGF0aWJsZV9tYXRjaCgpLg0KPiANCj4gVGhpcyBsb29r
cyBva2F5IHRvIG1lLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAbmFi
bGFkZXYuY29tPg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBBcHBsaWVkLCB0aGFua3MhDQoN
CkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


