Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B9C83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 13:08:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.8213.1752584921090952814
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 06:08:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 56FD8bT51702490; Tue, 15 Jul 2025 22:08:38 +0900
X-Iguazu-Qid: 2rWh5b6vIshUrLjyS0
X-Iguazu-QSIG: v=2; s=0; t=1752584917; q=2rWh5b6vIshUrLjyS0; m=hwSskZBLOO2on6O0lECoLnwlQU1cZDDeaQP8N0NK5JE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 56FD8aJn3396708
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 22:08:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkN0J4O5on+b9madorq1eUye4hiNSRSxV7lfM/zX8fOK6nUE+fWQrRttRl2CK/n7Y4B/NFjnWyFnZ26ATRI+6RLDHNUGkUzDdDWAHqbENJt1niQDguxznOe3LyeBLUl0oIpqo0XxyODmZxClG6Vpa8SbDHUGPV73GTbUXY6/Lc94OAe6QjK0DrXltkQCmX01qxd+bzXgiXDBNx+HSMusL0MmQjoauLiSsJ5YK1hfcQBOU8PsVHtYdjZ1SzuSQuZc+mYL+8F+hymQkVAxHoYYwcWfV/PFeutvj1ovfMobyA+wgSKn6HY1cxBltjOQp3H5TjTEeOKJtxwrbPfR8P/gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SbMaQP4h1f03d5iyVRBygAer9e4WMszD24O/dmkAyE=;
 b=TGdC3DrL1vLIYBT73wK2HxyuNpuWBoZQScnC/rGBx16eePSXm6or1fWO2qGDhCXw3pdpFYnktXx7UyvAF4zDX3mkqtC2iwnx8YOkHvcaJGPJoCw/h/I9fiYgATN/hAxsmfc7y5QDKoC6Py9vAeE8LEkNfL+rteRQr8esGzy08hw0H8MC043anmERttifbZ/dal3eq/rI758/GZdwpVr0bbgsp2IKsiZtbHj29TgAAE+/d3tdBiyer8Y1C3cxShDC+1eY38w1GKa/7wfoz0wBPmwJU8LWRNkjy/uKBhRTokMkqu3qEr928UKpHin5UBZmZT3IdXh0PPK9F0vKOHj1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Topic: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Index: 
 AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldAAAq2dgAAAqsrwAADXmQAAADm2oAKFRenwAAfGywAAAHnW4AADs3kAAAIwyQA=
Date: Tue, 15 Jul 2025 13:08:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075AF23719F7D751E3D703BC757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
 <TY3PR01MB1107546DA13B576633ABC1614C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <2006d2a3-df31-469d-9fb0-09f0086b7b59@siemens.com>
In-Reply-To: <2006d2a3-df31-469d-9fb0-09f0086b7b59@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYCPR01MB5630:EE_
x-ms-office365-filtering-correlation-id: b3c5f95e-ba3b-496a-dbb6-08ddc3a0b3a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MHFJYktiK2NTc2JSM1B0R3JXMlRXRHpTNWtpUlViQXBYYWw3WjdXREZBYjl0?=
 =?utf-8?B?WHlvS3M5TzFoZGwrVTBselhuazZDYTNYYTdWQVV5Z3VwZVMwNGxRdW0yTnpo?=
 =?utf-8?B?Y3JOeGx4NDgrNnd0MDFQRjBtOVpYQzI4amhkdW9vVEVCSDJ5RVJZK1BCMjZM?=
 =?utf-8?B?Tk5yNXNDUnBaUndVMFRCNGlJSkRoUy8ySnNuTWJwM1BaWlFJRUxVWlZnbjJC?=
 =?utf-8?B?amZaNEZsZkg5cFNiVG45Um4wa3VpYW9UbXk2aW5sVHVTNDF3V3BqRkhod0hI?=
 =?utf-8?B?OS9BNy9vTGs2UTFpSTlNRU1WWUxRYmpqVEFrVFJnM1Zqa0JDVFVLL3VMcXBm?=
 =?utf-8?B?azYzWlVhZ0ltOUtxNEl1YmgvMXNwVTNsR1A4NG9odklpRGJlckp3MlJMVlhh?=
 =?utf-8?B?OVZhME9OVXlIaTZ5TXdTaVBiNWI4bkVWYlpJeWJydU5mSHloZlgrcXVZZVBU?=
 =?utf-8?B?VWlKOWxDU2QrUXN5MXpCZUNFZWk0KzZOQjNwZHpzZ0ZuTkVUU1RtME13Mkhr?=
 =?utf-8?B?L1QwRVpGTXR1ZGY0dDFuN0hKT2xJa3BYRnhHR1FUQ1VaOEc2TWxGcUZySEIr?=
 =?utf-8?B?ZmJibWwxcHVqelFFMFBpWGdpRGlFUWg5RmdTV2h1MlcyVmo4Q0N5S2RFdXEy?=
 =?utf-8?B?RjJ6aWxReDBUbVh6eWNoTEFUcEhQcDZXb1prMEhETkcvTzdiREpKREFNck9V?=
 =?utf-8?B?aFlWZkJQcXNrWXhEb0U2ZVg0eFlpblNwWk9aSHBFUDhjdHZiWnNBd1M5MVJF?=
 =?utf-8?B?VkYvS0d4SnhjTXFwUFpsNFl1M1hXZkNtZWMvUWQwZFlLWnpLQXFQTjJCQWR1?=
 =?utf-8?B?VlZOSUtUYnNyRlVpV1dZMkNMdG54UEVQK0E2VmNuTE5aUXdjUkRNTCtqdHlW?=
 =?utf-8?B?UzE3TTZuYmdXaUpkbW9JYlAvNWlOSE1zSXIrS1NtenlHNHdIYjhJODhCYjYv?=
 =?utf-8?B?YTJBbzN1UEVCV1VOL3lOVFdIclhxMjFxRlJTSGQ1QTIzbkhIMy84d0pyNmds?=
 =?utf-8?B?N2xTZ0tZSy9QcElacWVuUmx5am9YMm4rb0JaeTZGWGFXU2pYa0h4VzZpOU1u?=
 =?utf-8?B?VTlBVGJ3N0pVL2JLdWFKUTd0N2xyOTNTTjNzMmxLOTVRc0pxTGpkdTl5Zk8z?=
 =?utf-8?B?ZHIzdUVWWkZmTkZMREhSdkk4UEpRUUg3M3dQcUc0STBkV3RxNzRtR3duSkhE?=
 =?utf-8?B?czlQb1JpQUo4K2lwNU03QzFhaVJIRTBtZWpZdmh1VnduSW03WjAyVHI1S2w2?=
 =?utf-8?B?Y1NlS2VMNEJTTFRMTTdhQ1BubzJ5UURzQU50M2NoVjluSTRoRnRLZ0xrU0s3?=
 =?utf-8?B?K1ZnbVBHTWdtUmlkZGE2M1FYODc2VTFGZEkxYytsM1lFSTZmVFFhVnM4OHph?=
 =?utf-8?B?VWdZeGVpeXZLYkVtWHBYcDJzS1lob1JVYnZpa2xtL2dGd0JwTnE4Mjg0YkRB?=
 =?utf-8?B?QmltQ3BXTzZ4VjBPSkVvVk5zVWV4b281YWdUSHFNbXYrTTVWa083S1dKenpB?=
 =?utf-8?B?TjIwREJiWEgwZWc4akJjblRsTDBTREQyOG1MSmhJaVBlOXVrb3lBVVBQMExF?=
 =?utf-8?B?Y0x4UzM5cTc3WCtIUWJDaDVEdlBwNG91d3lrYjhWcXpEMWhxZ3o1cnRSSm1T?=
 =?utf-8?B?dTlKLzVrK3lSZWthbXpmTmhkQ1JhWlg3MFpXQXhpNUpKRWtPVzlJRHFGQlRj?=
 =?utf-8?B?M3J1Q1hPS3dkU2dRZmExOERncEhuZDNnL01vSlZRRXVBVWoyUktSbE16WFJF?=
 =?utf-8?B?cnRKVTdqa3lCVkUzOEdGSWtNQnQ1ZHMzRURuSTh6cGJaZWV6bW5DMFUwbzBh?=
 =?utf-8?B?YXg1MU01cEQ5NExSRGpySGdQZms4RW8vQjdTYjBGU01nS0NES0crR2Y5eTd3?=
 =?utf-8?B?QXlKT1BqSlYyU20yc0JRYkdHRGhlS2NabkxBWVAwemRlOHlKM0dyZDdxODdx?=
 =?utf-8?B?U1hoZ1F4T3g5YkJlb05HSzlubDUrS3ZVdlZ1czBVVlVya3NhOFZpQ01TYWFV?=
 =?utf-8?Q?/Xx4nErhhJ+NT0hpRot0Chvh32UTnE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NWdqOFoxY1FnWkp3ZGNDSS9DellNdEtHSTByWWpSOHViNlNXWjFuc05DN2pJ?=
 =?utf-8?B?OEMwU2xnSjdHZnFKL0hzUWpFdHU4UWkzVGZDdVBWRm9kbHlzYUJwVDFBb1dz?=
 =?utf-8?B?eVIyKy9UbEsxSUVXSHZVSTZia014cXo2anBjSGZCbExsTWM1b2k2Q1ZYZHRu?=
 =?utf-8?B?VG9acUF1Rit3bHRhZVFNY1lLRzZHdGlSaDQxNTF6K0Q0MjhnU0pEMUxNcWdv?=
 =?utf-8?B?dVk1b3E3OU8weTZuYytiNDN5dHVzcjZxRklqOUVNamVIYnpWMm9OS1l2aHNR?=
 =?utf-8?B?NkNSSDhkWjNwd1QwSkZXQVdoZWsrM2Nrb0IyY3ZyTG03c0kvVkQrVVBQZE83?=
 =?utf-8?B?ZTZhNlMrc2h3OGdJbUptbFo1UkdROUlUQUhId0dlQ2FQODBVQ3E1V29QNFlL?=
 =?utf-8?B?eWFmQlczZS8yeG9vM0JBNDBsSFZ4ZTNUTWdkSTUxV1RvMG9vUWpvZ0tYMm42?=
 =?utf-8?B?Y1p3b2dhRHZVb1JORDBwNWJ3L3hsYzRKNkR6MnRvcjB2LzVSVW8rYktSSU9L?=
 =?utf-8?B?dURIWGdRYVhkcFZIdFlEdVpNVlp6ZlI4SkZGUVhQbXVONUtNMmRFQnlmZFh5?=
 =?utf-8?B?cFBmK3ZwS0l3b2tOSDQ3RWtlSlJORzU0OE5sZmJZM2xkSkF6dlZvL0dZeU9p?=
 =?utf-8?B?VkRQKzJRb3dBYWFUSFBaeTVzVThvRklEZDZTQzZ6KytQbS90V2ZyUWpWa2J5?=
 =?utf-8?B?eC9qUjc5K3pzNUJLbk1obzUyQVA2SlRSOE1mem1CSUhPZHhDWFk5cWQ1TUwz?=
 =?utf-8?B?L2c5RExZbmpkUFFxZEltS0hNNVJ0Q2RvUkJQUnVUZmhNQjhyRzNZKzdON2lP?=
 =?utf-8?B?NUxxQVd5OHBhbGo1WmJJT3Y2VFdROWtQTHFIUTJ4ZitlTlFGZGpLOGZDcFQ3?=
 =?utf-8?B?RU5QR2hLR0tVSzVEN0NkbnZKQkhxVmxBOTd1QTV0OFVBRHZERTdKMmxmcXRG?=
 =?utf-8?B?aTY3UDZ2MVhoRGl2RnY4RGl1cjdhdldjcnR6SnpFMXB2d2dMWkN5M3JlS0hX?=
 =?utf-8?B?Y0xPZW9SNHJ5ZHBNVjJSbVBOck5jcTRTeDBzaElRWVRLZ0JFYm1jb3NHNlJX?=
 =?utf-8?B?Nk9zKzR3YkllaW1lQU9xdXJOb3RESkVWSFN6NUk4VHFQbnVJNzNzWStUc1F3?=
 =?utf-8?B?WTIxU0ZqNWlhclB3Z2FTblRlbFFZTCtXQUVCanNlbTNQYzF6amdtOWZVdkVK?=
 =?utf-8?B?OVkydUpCOUg4b01JYndVMHgyTGYxVHFJb2JKOXZlU2JlVVlEY1UzbC9pb2di?=
 =?utf-8?B?NnIyamdIUi9ORUJPUlk0QnE5NVhick1nWlBlNy9HY2VQQkFBTlB0d3NHOGg1?=
 =?utf-8?B?SS9qbkFZcU9hc3BmQXA4U3BqVVpPWjY2L3ZZTExKOXZKaFJYa2locUxia3ZX?=
 =?utf-8?B?UDN4WDVJSjRSeGVjbXJiTmRuS2Z6M2pOVUJIWjVla3hVVEVVYXFpR09HaFN4?=
 =?utf-8?B?d3NKbCtCalpRSlNNVEQ5MlpHWjB1L3RmaFc0NEFZZlFhUVJ4ZDhUalZVVTF4?=
 =?utf-8?B?eWhHWkJJempFMnl5ZXYxMlYyY1JmajlJbXdwekN2QzA3RWd1aDdYU2FyS3o5?=
 =?utf-8?B?WHhIQmlUa09ucWorZ1duMWtPMi91TG9ORjI0QmROU1N4alA2OWNZVmp4cVl4?=
 =?utf-8?B?TnlDaGMyeDI4ZER0ODFhY2ZGcVpUTmpPVlpIbmN6RlBUSTd6YWNOT0psMnF5?=
 =?utf-8?B?dll6VTVDcndlRlN6cmN1WWpTWFJzSktTT2Zhb3Z1SnkyekZOSXVhWmJ2UkxJ?=
 =?utf-8?B?Qzlmc1d2d2oyV2g4YlJjS0JqR2hrZDU3dFhJamRvcXo2Q0xvcGtublhldHVu?=
 =?utf-8?B?YW5jRUl0VE5kUXlmeHBKaGNtTStQYldESXlzN0ljbG84SnZMcW9xNGM5bXZI?=
 =?utf-8?B?Y0NOdFdBTG03Tnc2TnZlZldmZ2E5Y3Zpa21qTW0yMDJVSGo0ZU51SG9WL201?=
 =?utf-8?B?aUJSVUNQcVJjd09adUQvd09STVRBTmdQR3VyOU1zQkV3OENNc3dHRk9wdkJO?=
 =?utf-8?B?WW5MWHhMWHpIQnFNUEVLZ21NekMyRHJOYTRZeDNYeEJwSHFIOXQxS3pabjM5?=
 =?utf-8?B?S2YvMkNYQTVleDZvb2ZKTHJJUC93QWU5Si8vWDhqb0hOV2V0a1M4UVNKYjh5?=
 =?utf-8?B?b0tHbEY4TnhrWGJBVkNJbVF0ejVZcjJ3QkwxcVVtaVFqb0N2YXlJNVFhVGlY?=
 =?utf-8?Q?wzFaJqaVNV6pFd0+XYreM0A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c5f95e-ba3b-496a-dbb6-08ddc3a0b3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:08:33.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJRMonahjI3O/Esj2+qY1rxUQD/NqFG8utXhtGutVat9gwk7l2A/6/Cuzm4orL2ZsdllK+bhutOJlDmeLAcqN+SaFX4OKJIg+cExMZZE0rq6K4gpFmXheo6Rck6QnX3Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 13:08:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19539

SGkgSmFuLCANCg0KPiBXaGVyZSBkaWQgeW91IHJlYWQgdGhhdCB0aGlzIGluZm9ybWF0aW9uIGlz
IGFwcGVuZGVkPyBJJ20gcmVhZGluZyBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9Eb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2RldmljZS1tYXBwZXIvdmVyaXR5LnJzdCwNCmFuZCB0YWxrcyBh
Ym91dCBhIGhlYWRlciBhbmQgc29tZSBoYXNoIGJsb2NrcyBmb2xsb3dpbmcgaXQuIA0KDQpCZWxv
dyBpcyBteSB1bmRlcnN0YW5kaW5nLCBwbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcgaGVy
ZS4NCiANCndlIHVzZSB2ZXJpdHlzZXR1cCBiaW5hcnkgdG8gY3JlYXRlIC52ZXJpdHkgZmlsZSBh
bmQgdGhhdCB3aWxsIGJlIHdyaXR0ZW4gYmFjayB0byAud2ljIGZpbGUgbGF0ZXIuICANCg0KdmVy
aXR5c2V0dXAgLS1kYXRhLWJsb2Nrcz0yNTYgLS1oYXNoLW9mZnNldD0xMDUyNjcyIGZvcm1hdA0K
ICAgICAgIDxkZXZpY2U+IDxkZXZpY2U+DQoNCiAgICAgICBWZXJpZmljYXRpb24gZGF0YSAoaGFz
aGVzKSBpcyBzdG9yZWQgb24gdGhlIHNhbWUgZGV2aWNlIGFzIGRhdGENCiAgICAgICAoc3RhcnRp
bmcgYXQgaGFzaC1vZmZzZXQpLiBIYXNoLW9mZnNldCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiBudW1i
ZXINCiAgICAgICBvZiBibG9ja3MgaW4gZGF0YS1hcmVhLlsxXQ0KDQpJbiBjaXAgY2FzZSwgZGV2
aWNlIHdpbGwgYmUgLnZlcml0eSBmaWxlIGFuZCB0aGUgdmVyaWZpY2F0aW9uIGRhdGEgKGhhc2hl
cykgaXMgc3RvcmVkIG9uIHRoZSAudmVyaXR5IGZpbGUuIA0KDQpTbyBpbiBST09URlMgY29ycnVw
dGlvbiBjYXNlIHVzaW5nIHNxdWFzaGZzIG1ldGhvZCwgSSdtIG5vdCBleGVjdXRpbmcgdGhpcyB2
ZXJpdHlzZXR1cCBzdGVwIGhlbmNlIHRoZSBmaW5hbCBzcXVhc2hmcyBkb2Vzbid0IGNvbnRhaW4g
dmVyaWZpY2F0aW9uIGRhdGEuICANCg0KPiBJIHdvdWxkIGhhdmUgdGFrZW4gdGhlIHJvb3RmcyBw
YXJ0aXRpb24sIGFkZGVkIHNvbWUgcmVhc29uYWJsZSBvZmZzZXQgb2Ygc2VjdG9ycyB0byBza2lw
IHRoZSBoZWFkZXIgYW5kIGVpdGhlciBoaXQgdGhlIGhhc2ggYmxvY2tzIG9yIGV2ZW4gdGhlIHJv
b3RmcyBpdHNlbGYgdGhpcyB3YXkuIE5vIHJlZ2VuZXJhdGlvbiBvZiBhbnkgc3F1YXNoZnMsIGp1
c3Qgb25lIHNlY3RvciByZWFkLCAiYml0LWZsaXAiLCB3cml0ZS4gDQoNCkhtbSwgSSB3aWxsIGxv
b2sgaW50byB0aGlzLCB3aWxsIHRyeSB0byBkZXJpdmUgdGhlIHJlYXNvbmFibGUgb2Zmc2V0LiAN
Cg0KWzFdIGh0dHBzOi8vbWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjgvdmVyaXR5c2V0dXAu
OC5odG1sIA0KDQpUaGFua3MgJiBSZWdhcmRzDQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4g
DQpTZW50OiAxNSBKdWx5IDIwMjUgMTc6MjQNClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8
s++8qe+8sCBESVRDX0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5j
b20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTv
vLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBo
YXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8
a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0g
TEFWQTogU3VwcG9ydCBST09URlMgZG0tdmVyaXR5IGNvcnJ1cHRpb24gZGV0ZWN0aW9uIGNhc2Uu
DQoNCk9uIDE1LjA3LjI1IDEyOjUzLCBTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5j
b20gd3JvdGU6DQo+IEhpIEphbiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcGx5Lg0KPiANCj4+
IEhvdyBkbyB5b3UgYWNjb3VudCBmb3IgdGhlIGRtLXZlcml0eSBjb250YWluZXIgaGVyZT8gV2hh
dCB5b3UgZ2V0IGl0IGp1c3QgdGhlIGRtLXZlcml0eSBjb250YWluZXIgc3RhcnQsIG5vPw0KPiAN
Cj4gWWVzLCBmcm9tIHRoZSBmZGlzayB0b29sLCBJJ20gZmluZGluZyB3aGF0IGlzIHRoZSBzdGFy
dCBhZGRyZXNzIG9mIFJPT1RGUyAoc3lzdGVtYSkuIA0KPiANCj4gVGhlIHJlLWNyZWF0ZWQgc3F1
YXNoZnMgaW1hZ2UgaXMgd3JpdHRlbiBiYWNrIHRvIGEgb2Zmc2V0IChzdGFydCBhZGRyZXNzIG9m
IFJPT1RGUykgdXNpbmcgZGQgY29tbWFuZC4NCj4gSW4gdGhpcyBjYXNlLCBteSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgdGhlIFJPT1RGUyBpcyBub3QgY29ycnVwdGVkIGhlcmUgYnV0IG9ubHkgaXQg
ZG9uJ3QgaGF2ZSB0aGUgcmVxdWlyZWQgdmVyaXR5IGhhc2ggZGV0YWlscyBhcHBlbmRlZCB0byBp
dHMgdGFpbC4NCg0KV2hlcmUgZGlkIHlvdSByZWFkIHRoYXQgdGhpcyBpbmZvcm1hdGlvbiBpcyBh
cHBlbmRlZD8gSSdtIHJlYWRpbmcgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9kZXZpY2UtbWFwcGVyL3Zlcml0eS5yc3QsDQphbmQgdGFsa3MgYWJv
dXQgYSBoZWFkZXIgYW5kIHNvbWUgaGFzaCBibG9ja3MgZm9sbG93aW5nIGl0Lg0KDQo+IA0KPiAk
IGRkIGlmPS9kZXYvemVybyAgb2Y9Y2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHktY2lwLWNvcmUtYm9v
a3dvcm0tcWVtdS1hbWQ2NC53aWMgYnM9MSBzZWVrPTE1NzI4NjQwMCBjb3VudD0yNTYgICAoMTU3
Mjg2NDAwIC0gc3RhcnQgYWRkcmVzcyBvZiBST09URlMpLg0KPiANCj4gSW4gY2FzZSBvZiBhYm92
ZSBtZXRob2QsIEl0IHdpbGwgY29ycnVwdCB0aGUgUk9PVEZTIGNvbnRlbnRzLCB0aGVyZSBieSBu
b3QgaWRlbnRpZnlpbmcgIC9kZXYvZGlzay9ieS1wYXJ0bGFiZWwvaG9tZSBmaWxlIGFuZCBlbmRp
bmcgdXAgd2l0aCBwYW5pYyBlcnJvci4gDQo+IHBhbmljICJDb3VsZCBub3QgZmluZCBkZXZpY2Ug
IG1hcHBlZCB0byAnaG9tZScgY2Fubm90IGJlIGVuY3J5cHRlZCEiDQo+IA0KPiBBbHRob3VnaCBi
b3RoIG1ldGhvZHMgdXNlIHRoZSBzYW1lIG9mZnNldCwgdGhlIGJvb3Qgd2lsbCBmYWlsIGluIGRp
ZmZlcmVudCB2ZXJpZmljYXRpb24gc3RlcHMuDQo+IElmIHlvdSBmZWVsIHRoZSBzcXVhc2hmcyBt
ZXRob2QgaXMgY29tcGxleCB0aGVuIHdlIG1pZ2h0IG5lZWQgdG8gaW52ZXN0aWdhdGUgZnVydGhl
ciB0byBmaW5kIGEgc2ltcGxlIHN0ZXAgdG8gdmVyaWZ5IGRtLXZlcml0eSBjb3JydXB0IGlzc3Vl
LiBJZiB3ZSBkb24ndCBmaW5kIGFueSBhbHRlcm5hdGUgc29sdXRpb24gdGhlbiB3ZSBtYXkgbmVl
ZCB0byBmaW5hbGl6ZSBhbnkgb25lIG9mIHRoZXNlIHR3by4gIA0KDQpJIHdvdWxkIGhhdmUgdGFr
ZW4gdGhlIHJvb3RmcyBwYXJ0aXRpb24sIGFkZGVkIHNvbWUgcmVhc29uYWJsZSBvZmZzZXQgb2Yg
c2VjdG9ycyB0byBza2lwIHRoZSBoZWFkZXIgYW5kIGVpdGhlciBoaXQgdGhlIGhhc2ggYmxvY2tz
IG9yIGV2ZW4gdGhlIHJvb3RmcyBpdHNlbGYgdGhpcyB3YXkuIE5vIHJlZ2VuZXJhdGlvbiBvZiBh
bnkgc3F1YXNoZnMsIGp1c3Qgb25lIHNlY3RvciByZWFkLCAiYml0LWZsaXAiLCB3cml0ZS4NCg0K
SmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBF
eHBlcnQgQ2VudGVyDQo=


