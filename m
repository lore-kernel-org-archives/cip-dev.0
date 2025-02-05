Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A6C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:30:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.11850.1738762210247632408
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 05:30:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 515DU8CT1745555; Wed, 5 Feb 2025 22:30:08 +0900
X-Iguazu-Qid: 2rWhMjEQIBoeUwYugb
X-Iguazu-QSIG: v=2; s=0; t=1738762207; q=2rWhMjEQIBoeUwYugb; m=DHQxoa59TgOa25+vy7snDb2nYI3Rr4F6XR7YxU7ZVvw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 515DU7KQ585871
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 22:30:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiNt1oQpCXLrMmJKD1XsUmarTgrLa0B84vB1b3w0XVlc4RXppVo0cdFGquutfQRFpTOOH0678f+Hmcu0QGTPz3JzHHtLC9459TSFZ5ZZfh7n6LJRqRWaIQTKeSy7rxYHn5YjTLovhNNo+9kyE7BD8ErSRipD0HYR0lbux3aUS7X6amjhyBhL8wEGIZEJPqN+ADFNbw0s72TNyje8R9xnlAuH+sEoESM5nx2eIjfz5lPa1ndUy87QHURUuV3zS/gAF63JmEobLbm+1x3d5kwlkOjWUqemBDgDl1j/4XGg8jeYxQuNiFI2bVAc1+kQTwd+1N0dkVxwqt1WOCes7q0JAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SbBAxlz/HJREUroH/nmWOmJRfgMemjJsY+/bxWcL00=;
 b=HZxLoe5a60xUE1j0IadDlPZyzxQ4pX36la8a75/UiRC/vaeLNzQ02ESPYu9YApGFAlc7IbvLkXxqzOWE1sgvAt8VCMHEe4k+rjMQ9lOdJW+S6q1Bf39ynitzGUjV0aTEBeXhqLj44brCAk3J2qgY+9CcSL02d3tBKfhb1F959ef4OKfgHUP7r5tfWwSL5xy196+cpT1DvBGdww1kjWLDU5dCQZQ8D9juOzYpa1KG55MuRP083YAkoZpc4wQAeepnOuGYCXq0M5/sFdp0CrFRMH+ZDaU8cRtuodLv+PrT7IfRrcdC9HpBLBaT/yPlRMZPzumvj+GPXGrX/WfQlfDbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>
CC: <jan.kiszka@siemens.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev][isar-cip-core][PATCH v4] kas/opt: add new option for
 security testing
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4] kas/opt: add new option for
 security testing
Thread-Index: AQHbdvwAtSQqoRjE/Uib2widvcAXrLM3IjIAgAE3hoCAAFvxMA==
Date: Wed, 5 Feb 2025 13:30:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB851557B67FBBA474F11C593EBFF72@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <20250131152553.270393-4-Quirin.Gylstorff@siemens.com>
 <20250204115722.48815-1-Quirin.Gylstorff@siemens.com>
 <40f39bdb-3ca3-4918-8bfe-8bb77e750fcb@siemens.com>
 <36fb2001-6886-42c4-8d06-995193d67405@siemens.com>
In-Reply-To: <36fb2001-6886-42c4-8d06-995193d67405@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|OS7PR01MB11601:EE_
x-ms-office365-filtering-correlation-id: 8899e47c-6147-48a5-04e0-08dd45e9337a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QUM5eU9hTEhqbkkyUU9jVDF1MW51bmJEKzh2S1pRNTRKRk42bGVjeFdTc2lE?=
 =?utf-8?B?UWVrK1pHeTU4K295aDk4R1RqbW05YVBpdDBPbW9mdy9uTzc5U3gwcnEvUmpI?=
 =?utf-8?B?SWVQVzFwaGtQY1NsMlgxSFJSbmlUdzVuK3lVNW92dHV2c20rUlhkN2ZQNnJw?=
 =?utf-8?B?Qm8waDdRWTJWVHJaNDhrMWNvb0tFWmQyL0RoWnAzYmEzTzRzQ0Nza0lwMzRl?=
 =?utf-8?B?TFA3SEZKRnViVGtPOHhUL3BMTVk3c1hTOUNoRlYvQmkzVWxWTUN3TWpZQ2dh?=
 =?utf-8?B?RXBoTTVaUkUzWm9TV21Na21sYU9LcG9SOG1LS1lGdVdUMERoM0lRVmlXY2p4?=
 =?utf-8?B?TW0rNkgrUzZ5YkhMcmY5dGF5THEraEl4cWJzZEcrN1ZtY21LUjlBYlZRNCtC?=
 =?utf-8?B?RnFEanBMQUovVjYxMjdxQlh5UTN5UlRmeitxQTI0R2RNamI0bzhZVWEyS3Uw?=
 =?utf-8?B?V1I5WCtUbURwcFlDS3V4d0NWK2J0aHJ0SGh0WGtWeEpJQy95ZmQzVUhwZG91?=
 =?utf-8?B?UEJyTzVQU090YTNkVW9OR0xJeTdjUkRlUFNzeU54ZFZpMFFEeHIyazhhZ1lB?=
 =?utf-8?B?SDduYVB6L0hsaEREN3Q5NmQwNDNCc1RQdEtLUHhPTXBGdEN5RW9qMVFRVkgr?=
 =?utf-8?B?TEFMTkNzc2FHdGNGenc5S1NvaFJhQytNTFRudDRpS0FUVEliNFQ0cWlBMmJ6?=
 =?utf-8?B?L0dvUFNPVENrNk5GL0xsY3FoRDRBK2t4cjlxMVBPVTNMQUdXUVFIUE54WnZH?=
 =?utf-8?B?TkxrTGhhclV6SFZBMFFMcmZ4RjF0OTNPVS8relVKK3VNZm12ZzlDZ1l3ZkRm?=
 =?utf-8?B?dVRGdE1ib3Evc09oYWJOOWVCZkwxeCtnclozQU1XSkVBOXpuZUlPV2ptWFlS?=
 =?utf-8?B?Z2pHTzE3WVFIZEFzK09LUWdNN0p6RmhJNXVOL2pmYWRsMGlLeVFJOUxZNHE0?=
 =?utf-8?B?WENtQnh4U01qZTJFeVhvb0lEaEJPNEdHTmo0WVRjeVlmemdvdWEyOU1xbmJO?=
 =?utf-8?B?amdwZC91VDN2ekZGMzVBQ3VsT0w3cUZMTnI2NHluZlBmNHNWWk94VzZMeTR2?=
 =?utf-8?B?dGY4MzlkSEI1TG42YTlpWFYrT052SGlueFJTNGFkZ2VQUi9tbTMyZGR0akhF?=
 =?utf-8?B?VkIvR2xHTjVMb2VEL1FiUzZRc09uNEtKbnRuWGVDNmd6aEVVd0ZLa3Zyd21j?=
 =?utf-8?B?UGJ4NWZVVTRDWVhGQjVFVFd3MlNVRmV5UUlEK3NINGt1SWw3ODNLd3FiNzhB?=
 =?utf-8?B?SFRMUkxDa1JaenNadWJZTmRzbUdUSHg4U0plM1A5RWxZVUMrU2c0WVMralM0?=
 =?utf-8?B?YWVjdlprRFJNcXJpeUhxS2I0TW1zeWw0TVVFYVhNSmFqODZPckZPWlZZTmc2?=
 =?utf-8?B?Tk5rSTZ1Sk9IckEreCtJdlJaSlR3U2loaWFkRDR2YVloRUJYTGVrMmZJcUNP?=
 =?utf-8?B?cVRXMmNoeDRZeUdGZXpKY2pEa0tUd3QvenY2YzI1UWQrS2w5bVgrVWRmTUdj?=
 =?utf-8?B?dWJvWS8vQ3B1ekJPWE9FQ3NxSkpjck9nUzF5UW1YUjYzMGgxQlhlTDZYNisr?=
 =?utf-8?B?dStOVEtSRDJOQ2JSRzlYMEhiYUNlVG1DazNMRHRVSFgvWkxyQVpTVE5lZkpJ?=
 =?utf-8?B?ZWVQTmdtUGJkdFBhOFhtNnppejZwQ0tZcThlck1SbGNwNUNDK1V2QmVxSmdj?=
 =?utf-8?B?NHQ2Q01rVTQzdTl1R0NTbldyeHRCODhFWEEvMkloNG0zOTc1UmhzaUs4M01S?=
 =?utf-8?B?cVFkSlpiYmpEMnpjNFZFbWV5SkhROXVoMzVrOEtWemd1T0JpcXRla3ZUTXpI?=
 =?utf-8?B?Nmd5YXlDYUtWMWc3QzNtZTNnd2F3VkU2TkxyZFFNU2h2YkRnNzJlTUhqTWc3?=
 =?utf-8?B?T1N1NzVvSHpMNFhDVXJyU2lHV01mWVpoN2cwai9hZlA2MlJ0dEE1VlJ0eEtM?=
 =?utf-8?Q?20VllzVLlu4968PX3OzMK/e0Yy5DgwzA?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NzBkbmJzdldoTmg2VDZiRGN4VlMvbGttdWZVdnNkMjhCM2JKQVlsaXhGVWlQ?=
 =?utf-8?B?OEQ2TFNGMkRsYm5mK0xMYWZaRkJLeldMSGQyZnlkUm9TRzZIdGUweTdRS0ph?=
 =?utf-8?B?MlNzeGkzWjNvc2w1SjdqVzdyV3dFQ3hlc3ZJZ3NDbnVValFOUFFnQ3ltY3Ir?=
 =?utf-8?B?cUpwbWx2bDE1RTYxQlFodHllUjl1L1VkWll3NDRURkpkb3ZMakVybnExaWdB?=
 =?utf-8?B?cFlOZ3QxbkR3amY3VjIwUkpHUEUxTE12Y3JodmlUNzhCdTAvS0dURm5SbXpB?=
 =?utf-8?B?d00yaGVpOXFodVVvTW9IUHQ1NWxKMWR1STRwelNMdUV0eVRsZEt0TnZ0NDhY?=
 =?utf-8?B?WEtzRHdUMkxKRWFEYjlaRW9vdit1SWJFM09jdVVzVlYrMEtlUzJGY3FyeDNQ?=
 =?utf-8?B?QkQyUTdxWmFGQ25iL2dUd1QzRzAwM3RSN0tzd3hlbXYyUnE4a2NJMTZFYUpP?=
 =?utf-8?B?TktiMlhzWDhJbEVlZkIzenV6M2FuMWhTVjhHZkl6UnRhRVJFUGR2bTFCN05r?=
 =?utf-8?B?cG1DSnRTU2NNa1JHdDdGWW1IdWR5elc3SitESjBOTGFvSnNLaUxiY0VXNGlY?=
 =?utf-8?B?NEdLcUR5WUdqVnF5WDRWZEhtTjROVU5wcHBLdVpLUVFJd3JTOU52ZW8rUVVi?=
 =?utf-8?B?dTN1QlFnUkxZMkxsSGYzT3h1cE40UWxEeStZNk9XS1l6ZjNJWVJKQWJ6TVBZ?=
 =?utf-8?B?SEdqK1JDbVBPZkE5dSttVGpRTWc2dWRCa1B2VmdLS0pUZ0lLVzVGWmlteWR2?=
 =?utf-8?B?ZnJjM2hmSzEwQnhNNktZakNRMG1vd3JkOXQ4bDJUeEpNQkZ3dE5RamZubFZh?=
 =?utf-8?B?S2d0M2xrOWhObmd5RzhxeEFReGlWbzdSUWNkNk90U2xpSmNVK0pFLzlHbGVO?=
 =?utf-8?B?THovaHN1ZFVxaGVxa0VXK05PNXJoUFNDYnZnUzNxTXpDeE9HVFpjWHpsZHJs?=
 =?utf-8?B?NmhDVEhmaG1CbFNyc1RNdWNGc21jdkxUN2huZXAwT0p1OTFLVHhhTnJqa214?=
 =?utf-8?B?akNQRm9MKzNGdlBNTklNU1JEdlFmTm9DUXlRZXI3cVMzVzRUZ2lTKzl0clRX?=
 =?utf-8?B?MkVNTi9hUkdENnFEMGxMeDVsZEpvaUNHRUZldldsNzZrb2Rselo2Ly9xOEc1?=
 =?utf-8?B?aEhSMWxueXJtbEl2RlZjRDJBWWtnRitldThmSytIWXdBTTZqZUZMa0JYZWdC?=
 =?utf-8?B?RjRsN0ZlS2hteTNmbUxtZHdhWjFJdGZMZG1LZVh2UTBmWnNMRUlZOHdHenhP?=
 =?utf-8?B?V2Z3Tk8zMFNWQjl2SVB1YmF0Y2NSamltanQ5UUpJR3BkRGdXUUowZ3doOWtZ?=
 =?utf-8?B?QjJyYlY4Ris5VFFib1hZaGZFMCswaTYrVDdJYjgrcm9KQXBWYkl3aEc5ZnNL?=
 =?utf-8?B?RG9oTXRvZUJBR1ZJUFFlZ0hIMTdaemxjbWNxWEtKaHltZTBmNjBkS28wZXM4?=
 =?utf-8?B?L0lsdkxMWjduMHpReGRNUXFEZ1c2WDdxeGhONlpoci9wQzFIVXZhTGp6Yzl2?=
 =?utf-8?B?V21rcGxSWjZvNkExaldsRmQzWG9oYzV3SjNUSDI1UE1rQ3dVVU11SHNxNWxZ?=
 =?utf-8?B?Q0dEbHQzMTYvRjVlOWt1b3BNNmRNVWxLejB3MmhwVDdOYUlPSWROcGtZZFFJ?=
 =?utf-8?B?SjFicTkyNWJ5S1BSaFNxWS8vMVpwMisvU0Q5MXo3N2Z1Z1hUcmlTZnZRUElh?=
 =?utf-8?B?Wlp4NzEyVFF1cVBiWSttYngvN0pTNUNnU2VaYXYwYjlsWmlDUDM2cmtIVVM3?=
 =?utf-8?B?cHpkVFI3YVFjay9ZRXF6L3prU0VjMlB1d09rZnVML21rR2hFbXU0OS90NUdv?=
 =?utf-8?B?Zlp4eTNncExWOXg5ejM0UmhVTFd4MW5aemRrY2ZnQk9ZNWdmMTVXdFd2NEFN?=
 =?utf-8?B?a1VsbFB3WmhJcmw3czJveERvV2EvTk8xOGFFRFhTUVJMNXNZdXN4cnpJL3BX?=
 =?utf-8?B?TWhGU3VUSlNaNzFGR0Flcm9ZVWtTb0JrdGtMRmZKaWdTeWlDWWNUZ3JlSWdI?=
 =?utf-8?B?VUR1NXpERkZpdmZVRkJTT3dOK1ZNNXcyNjY1b0pMbGwyZlVlZGNmVXZtbWdv?=
 =?utf-8?B?a1VkSUwzV0FlTEsxUnRaWCtVTy91T1Urbko2WnJqcXZicUVQUVQ0amVMSWht?=
 =?utf-8?B?dmZQZG1xcHZXUmcxNkZ3RHVaTTBWTnNkbDQ5R2NENG1XOGp1V0tvTEVaUjQ4?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8899e47c-6147-48a5-04e0-08dd45e9337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 13:30:04.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DAQVnGXxUxdTsfPOfa9neop2wh8ya0K2Y0dlljRktaFQcHusAxhmiNbBgG8+Bb0rmmJo9kFfyHz7MX8Y5Fswk9nuhNrFhFEMeuW/SXYCTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11601
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 13:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17754

SGkgUXVpcmluZSwNCg0KV2UgYXJlIHByZXBhcmluZyBwYXRjaCB0byB1cGRhdGUgUkVBRE1FLg0K
DQpSZWdhcmRzLA0KRGluZXNoIEt1bWFyDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPiANClNl
bnQ6IDA1IEZlYnJ1YXJ5IDIwMjUgMTM6MjkNClRvOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPjsgYXNocml0aCBzYWko77y077yz77yp77ywKSA8U2FpLlNhdGh1am9kYUB0b3No
aWJhLXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGRpbmVzaCBrdW1h
cijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl1baXNhci1jaXAtY29yZV1bUEFUQ0ggdjRd
IGthcy9vcHQ6IGFkZCBuZXcgb3B0aW9uIGZvciBzZWN1cml0eSB0ZXN0aW5nDQoNCg0KDQpPbiAy
LzQvMjUgMTQ6MjQsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDA0LjAyLjI1IDEyOjU2LCBRdWly
aW4gR3lsc3RvcmZmIHdyb3RlOg0KPj4gRnJvbTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4+DQo+PiBMYXZhIGdlbmVyYXRlcyBhIGRpcmVjdG9yeSwg
aW4gTEFWQSBjYWxsZWQgb3ZlcmxheSwgd2hpY2ggY29udGFpbnMgDQo+PiBhbGwgc2NyaXB0cyBh
bmQgdGVzdHMgb2YgdGhlIHRlc3Qgc3RhZ2UuIFRoZSBkZXZpY2UtdW5kZXItdGVzdCBuZWVkcyAN
Cj4+IHRvIGJlIGluc3RydW1lbnRlZCB3aXRoIHRoaXMgb3ZlcmxheS4gIExBVkEgcHJvdmlkZXMg
dGhlIHBvc3NpYmlsaXR5IA0KPj4gdG8gZG93bmxvYWQgdGhlIG92ZXJsYXkgdmlhIGh0dHAgb3Ig
TkZTLiBXZSB1c2UgY3VybCB0byBkb3dubG9hZCB0aGUgDQo+PiBvdmVybGF5IGZyb20gYSBodHRw
IHNlcnZlciBvbnRvIHRoZSB0YXJnZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5
bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdl
cyB2NDoNCj4+ICAgLSBmaXhlZCBkZXNjcmlwdGlvbg0KPiANCj4gVGhpcyBkb2VzIG5vdCB5ZXQg
YWRkcmVzcyBteSBvdGhlciBjb21tZW50cyBhdCB0aGUgZW5kIG9mIHYzLg0KDQpJIGNhbm5vdCBh
bnN3ZXIgdGhhdCBwYXJ0IDstcCBUaGUgYXV0b21hdGljIHRlc3RpbmcgZGlkbid0IHJlcXVpcmUg
aXQgYXMgZmFyIGFzIEkga25vdy4gU28gSSB3b3VsZCBzdXNwZWN0IHRoYXQgdGhlIFJFQURNRSBu
ZWVkcyB0byBiZSBhZGFwdGVkLg0KDQoNCkBTYWksIEBEaW5lc2ggLSBEb2VzIHNlY3VyaXR5IHRl
c3Rpbmcgc3RpbGwgbmVlZCBzc2hwYXNzIGFuZCBhIHJvb3RmcyBzaXplIG9mIGF0IGxlYXN0IDVH
Pw0KDQpRdWlyaW4NCj4gDQo+IEphbg0KPiANCj4+ICAgLmdpdGxhYi1jaS55bWwgICAgICAgICAg
ICB8ICAyICsrDQo+PiAgIGthcy9vcHQvc2VjdXJpdHlfdGVzdC55bWwgfCAxNiArKysrKysrKysr
KysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQga2FzL29wdC9zZWN1cml0eV90ZXN0LnltbA0KPj4NCj4+IGRpZmYgLS1n
aXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5naXRsYWItY2kueW1sIGluZGV4IGRkNGJhZjQuLmQ3MDU1
ZjIgDQo+PiAxMDA2NDQNCj4+IC0tLSBhLy5naXRsYWItY2kueW1sDQo+PiArKysgYi8uZ2l0bGFi
LWNpLnltbA0KPj4gQEAgLTY1LDYgKzY1LDcgQEAgZGVmYXVsdDoNCj4+ICAgICAgIC0gaWYgWyAi
JHtyZWxlYXNlfSIgPSAidHJpeGllIiBdOyB0aGVuIGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omth
cy9vcHQvdHJpeGllLnltbCI7IGZpDQo+PiAgICAgICAtIGlmIFsgIiR7ZW5jcnlwdH0iID0gImVu
YWJsZSIgXTsgdGhlbiBiYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L2VuY3J5cHQtZGF0
YS55bWwiOyBmaQ0KPj4gICAgICAgLSBpZiBbICIke3dhdGNoZG9nfSIgPSAiZGlzYWJsZSIgXTsg
dGhlbiANCj4+IGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvZGlzYWJsZS13YXRjaGRv
Zy55bWwiOyBmaQ0KPj4gKyAgICAtIGlmIFsgIiR7c2VjdXJpdHlfdGVzdH0iID0gImVuYWJsZSIg
XTsgdGhlbiANCj4+ICsgYmFzZV95YW1sPSIke2Jhc2VfeWFtbH06a2FzL29wdC9zZWN1cml0eV90
ZXN0LnltbCI7IGZpDQo+PiAgICAgICAtIGlmIFsgIiR7c3d1cGRhdGVfdmVyc2lvbn0iID0gIjIw
MjIuMTIiIF07IHRoZW4gYmFzZV95YW1sPSIke2Jhc2VfeWFtbH06a2FzL29wdC9zd3VwZGF0ZS0y
MDIyLjEyLnlhbWwiOyBmaQ0KPj4gICAgICAgLSBlY2hvICJCdWlsZGluZyAke2Jhc2VfeWFtbH0i
DQo+PiAgICAgICAtIGthcyBidWlsZCAke2Jhc2VfeWFtbH0NCj4+IEBAIC0yNTEsNiArMjUyLDcg
QEAgYnVpbGQ6eDg2LXVlZmktc2VjdXJlLWJvb3Q6DQo+PiAgICAgICB1c2VfcnQ6IGRpc2FibGUN
Cj4+ICAgICAgIHRhcmd6OiBkaXNhYmxlDQo+PiAgICAgICB3YXRjaGRvZzogZGlzYWJsZQ0KPj4g
KyAgICBzZWN1cml0eV90ZXN0OiBlbmFibGUNCj4+ICAgDQo+PiAgIGJ1aWxkOnFlbXUtYW1kNjQt
c3d1cGRhdGU6DQo+PiAgICAgZXh0ZW5kczoNCj4+IGRpZmYgLS1naXQgYS9rYXMvb3B0L3NlY3Vy
aXR5X3Rlc3QueW1sIGIva2FzL29wdC9zZWN1cml0eV90ZXN0LnltbCANCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAuLjczZDIyZWINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsr
KyBiL2thcy9vcHQvc2VjdXJpdHlfdGVzdC55bWwNCj4+IEBAIC0wLDAgKzEsMTYgQEANCj4+ICsj
DQo+PiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjUNCj4+ICsjDQo+PiArIyBBdXRo
b3JzOg0KPj4gKyMgIFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+ICMgIyANCj4+ICtTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUICMNCj4+ICsNCj4+ICto
ZWFkZXI6DQo+PiArICB2ZXJzaW9uOiAxNA0KPj4gKw0KPj4gK2xvY2FsX2NvbmZfaGVhZGVyOg0K
Pj4gKyAgbGF2YS10ZXN0aW5nLWFkZC1jdXJsOiB8DQo+PiArICAgIElNQUdFX1BSRUlOU1RBTEwg
Kz0gImN1cmwiDQo+PiArDQo+IA0K


