Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F2D3B7D9
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 05:07:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.12327.1732511230631707168
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Nov 2024 21:07:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Emsw9bDs;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1732511214;x=1733720814;bh=YTDC7knnwOFyrizrgx/NnoKcX2cCNG6Zh0rGMI/
	FcdA=;b=Emsw9bDsKKSEDN/42vxzALbjD5oD6HwlJPX6MoMEXRrdodjcOF4RmF7eLk/2QPF7obJLw
	vmTnzJGfCLOeZmLZF9w80KiGaaln5Nxh+HOsaoKaWanRt52FPbuT1LvOG9YTK1ktuaD6Szclikd0k
	fJK5wLczAqKqBln0uchTbgxgDHRxz0plvfGbYk9rLBm2Qo2IzAszwMjKKLVFA2+6mu7P9gGB+49Qf
	nn6JB/HBER4v81oOoTmQnLxGxUnqVRAgU6iAJHlp3qJBZVcEww/heVoNaCzPSwVTPclZN/aBYEBEE
	8ZCunaw2zNgEjkC1YR0msIozS7JkwGgRYuHC1RaOOw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4AP56riT2972968; Mon, 25 Nov 2024 14:06:53 +0900
X-Iguazu-Qid: 2rWgLQGrAddKc5hjZS
X-Iguazu-QSIG: v=2; s=0; t=1732511213; q=2rWgLQGrAddKc5hjZS; m=xj3SAAKDCjFcqOowikGS0cdiuMiG67GJGAnKm/klj3Y=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4AP56p4K3608448
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 14:06:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6uYs7e+DC5xDT0rSRq2LrbqZ2U9rqh8pQDokeBptlF3C+FEXsmgh6ELNGuXLmJng1GCwHyCUonBiuOzmsjc+HRmu6xATh7FT+yp57+nwZx20QUDQ4l3ADuaAWWqw//cE8m58xcIb2d+tWfU32w05w/9c5DsnTdiL99rPBcW/xb3ugF84x7N2/wAEjqMI7Sv7KDvDwoWgZBcT+tLdle8Z0NAvHE97TQFmye7cjvPJUf81liLgZkaphmuckA9rt0icOuUBJN2dj+CMF6ocr9sgU9esw4oNGoUNxMS9p3EngHOmcY3GrxHIPjleE1XTSnipV8ATmNHUGougTSuFcc2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTDC7knnwOFyrizrgx/NnoKcX2cCNG6Zh0rGMI/FcdA=;
 b=ddHtLDCDPhgebPXdJYtJWSfrhlDK9Z9RYQFaYKPJAsyf26AqrpVmd/lmEyJxu8UwVf+NPPgFtQs7hTKW2rI1a/UAOTfFGMwsGRYf/Vd8BF8ow2VFppAjg4Sso2WhPjloUDDFBpvnS/2J23mFgwqG3tswjBBzXU2E+CNDIOKW5nbZbuLlerGLMgXHhKrf28NYazWgRhQZ4Ts3qSHCEJEEtEXGQMuSTvFsZpYTa92Bf8Xzd53XELzA119diEAkuGoyYGHkGcPffGc/hW9DKYHQGUNRBuuhKsB8qGa4DvX+traRbZHRh1aiyIsYMf7pygS+eFtLNi2i600As6+0Plo2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for reviews for 4.4-st58, 4.4-cip93
Thread-Topic: Request for reviews for 4.4-st58, 4.4-cip93
Thread-Index: AQHbOYeiJ9LufgvI3EueuL55TwQMRLLHeuNQ
Date: Mon, 25 Nov 2024 05:06:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638844CC21AB107A78268D6C922E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <1048687374.465216.1731913250080@webmail.strato.de>
In-Reply-To: <1048687374.465216.1731913250080@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB10101:EE_
x-ms-office365-filtering-correlation-id: eeb34e27-9b29-4961-7f6b-08dd0d0ef5d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZS93VERGZVZQbHRLYWYvejlkUlpSd1NsVzl4ODh6U0NITHJxU3hDNkFVY3hN?=
 =?utf-8?B?RUhEYzY5R3N4SGZ0aEdoSU5zaXE0WHNlM0pTbGlLdXhwSTZRT0hxdmVaSE9o?=
 =?utf-8?B?b2FuU3dGNFRXNXhrK3pqMHBkK0hjak02a0h2M0JQN2I4cmJSVWFWVXFxa2RE?=
 =?utf-8?B?Zzk5TXVkTmtMSTk3ZmFZREhKd1ZNc3BNTW9iVTNFaEdHNkNzNVNzbDJDUFVV?=
 =?utf-8?B?eWM1QXJLMjdaN3h1VWgrL2R2bDhEdjF6UDFJRmZCc3AvQ3pMWVZlOWtTZ3pB?=
 =?utf-8?B?aU93Ry9sa0prODN3L1JVTE10WmxFQ29ZVjMwdFhJWXBjY0M5NEV3ZjRyT1Nk?=
 =?utf-8?B?OVZkZUY4VnFmcTdERUxZNGliM2ZDVklnVkxHMlVobDlVN1RzZ2MvUHE5VGkx?=
 =?utf-8?B?Zjc1Zm1VaEpTOXd6SVJ0MmlNSm4vY2Qxeld4Vkc5SXpFcUdHL20rYVU2OGJh?=
 =?utf-8?B?eW9YRnZsd2xiMmNSajZ6VktKRFhkclRjZjQvWFNZbkowK2p0REhzZnowL2ly?=
 =?utf-8?B?TmhEdWxLbjMySHRiU0VHUzZJTXB6VWJkcys1NWpxQ1dRaU9YVE83cHZMa1c4?=
 =?utf-8?B?bTFTODAvOCs3YTlrbkgvbGNDNFBodUpCNHV6Qks2UU90cmQ4OFI4S0t0ZWZa?=
 =?utf-8?B?UFNGVTRBT0xOaTJCWTQ2bndTRVBoTUwrTVJ4QjVVOFJZSnZYcHBsVFBwNUtH?=
 =?utf-8?B?WWhhMXlrdkVnS1dCejFjdGhpbzVQVEJDZmozSnh2bmhwWmhreFZlVWpQaWx5?=
 =?utf-8?B?K3VWTlE4NDFvMlpWV2FNWllVN1d1aHl5VHZhZ2xUY2tCMHY3ZlJtdjE1eGhI?=
 =?utf-8?B?aFYrREZ5M0VFMUhtdC9COStrSVpnT1lMYUJ2KzJ3bEhpcFQ1TXRYTzJvM1p6?=
 =?utf-8?B?N2dKT1ZiYlZkUVNOczVNeE9NSGFxZjJsK0JwSHJQcEtZeXdTU2pIVzhnaVhU?=
 =?utf-8?B?SURCTDVIOEw0aVRLTWY2RnJIbnExWlJQU1ZoRGlPbnpXNG1TWWNxMGJIYllH?=
 =?utf-8?B?dW92enpaOXZ3RnpDMU9rSjdUTUR2NExaMjJGV00wak9WOUFSS24xOVlsR3Y0?=
 =?utf-8?B?R0ovU0d5SktPT2hNT1JTdWhUYWx0alVsSUZudW9aQ1ZwVlpwRy96eW96aEpF?=
 =?utf-8?B?dDV3VEV1bU1UWGEybnRXQkVwM1oxcmdoQjFvbHphcHozWkZXV3lrODh4VUlP?=
 =?utf-8?B?cElnbWhmN3hpd1dPOVk3QUdmTHVjSXBwTW45b0JYTGQxdHloT3FzVFFTVUh1?=
 =?utf-8?B?Z2s5TFI4eWhqVTJIR2tKQnc2RE1ESnNoTjZGa0tERG5vSU1KOG5jRDF6MkNx?=
 =?utf-8?B?bmhhMkdpeUlOREMvNHB6WmhpWTZlbnJ6Z1JUR01Vb2JES3RRNFVDRjNEelpX?=
 =?utf-8?B?Y3RWWUViZ2padnVCR0FpWnRmNTNKNzR2a0l1WmVLS0E5VGNXRmVzM1Z3UmNl?=
 =?utf-8?B?TWwzYmxpMHpyVmFaNmJIZGQrbEExQmpudWhZV3hsVDNQeVV3TkRZZDNERjhR?=
 =?utf-8?B?V2N0aGhHcEN0QXVZM0dXWGNkU24wQkJOSXgwV2toMEhKM0ErWlpuVW5hbkpx?=
 =?utf-8?B?TmZxanVIeThEblRTVjQ3ejluMmhnKy85TFNpSGF3RUdGWVFBdjd2SGcxeTU4?=
 =?utf-8?B?cEd6SHUxOVVUQjJhblJqakN4RHhTcEwwc0lDZjc3NXMrMHNia2VuTjR1YXlr?=
 =?utf-8?B?QWhKM0FiYzg1UWpJN25pRjRmeEhtWDY4Z3pqcFliM1BvVE9GcmpYV2tGaFJN?=
 =?utf-8?B?Qm1HcUlnd2JFZElkVDZZS2o0a1BuQmRPeGd4VitjTmMxL3Y3OHB0L2lTSUpR?=
 =?utf-8?B?RWJrNkFtdkJ5djNkR3JRUDdLSGhYRUpEY2JUd0txSldUYlBTNGNtOSt1WVNK?=
 =?utf-8?B?SnYxemRFbnAvRHI5Tm1aQXZGalY4b2JsdDlVaWNqblFWRVBOTFRRQXNma2Fl?=
 =?utf-8?Q?EXZgLYG5wOI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RzNTVHo4Z1BBL0o0bk5YNm9vZ1FPOWpqanYxVzU1SkRZVWpReVhQdkIwNkRJ?=
 =?utf-8?B?VUVjU0JNaHNnQmhHVTdldXNrQzAvRFVHYVVuVUYyVlNwVVhzUDZHc2lnQy9X?=
 =?utf-8?B?Nk1ubzAwdm0zTFdKS0g0amFYWXdZcVRCYTU3aU90aFRNMmxLMWlyZG4xSWtE?=
 =?utf-8?B?eTBZanB5Ly9RZFd5RVBsL080N0NKbUxvaGIySDYwVXNsWTUwZnZOTmxGcDc2?=
 =?utf-8?B?dHlsTmcvMjNCNXQ0dWRPSTlNOHczOXk4bVVDc1VYUFhldXJpSm14KzRIZTB4?=
 =?utf-8?B?MVdRTlpuN0dBbDZMVFk5bmtNeWdIMzdHa2hFWFI2REJtOHdURlpFV05xN0tw?=
 =?utf-8?B?bFdqdUNlaGZRQjNrZDFOaXZBT2MzSlJVS0dOZTM4V3ZsWHcrOWtzeVpWUGdh?=
 =?utf-8?B?VTBsTGc0a1g0YnVGMUVQNU8rMWFEdjRWMkRuUTQ4MnhacXR5dFdFT05yaEs4?=
 =?utf-8?B?M2F1U2ZSaWUzTDZZRTFoR1MvNDJXbEJnbHBGTUdZa0ttK0RmVHNoaXQ3OXBu?=
 =?utf-8?B?WWEvQkQrTTRhYy9qbE53R01Lb0J1d2syZU42TjdseGJTdThaUHdoODMxTGpU?=
 =?utf-8?B?Z0tWMnlLekxmL2VjUW5nZExvMy9VRmI2UGFhWitMaXlVWmtnY0ZpNzNuRENk?=
 =?utf-8?B?YjBvb0d4bW9jRWQvZE5wSHNETTlRR0hNQm0wNzdtMndKODRiajBVNDA3RmQ5?=
 =?utf-8?B?ZDNBWkNDRUFOMDI4MUJheGhnRm04QkI4d1pVZVVZN3hFOWp2Qm9iK2F1enJr?=
 =?utf-8?B?b3Rmc1NhMDBJNkFjT210di9sNG1ETndBaHlQWFpteXNpSEI5QzB2R0U4VjBE?=
 =?utf-8?B?d3ozT3BJUVZ5N1J2eGdmWHJDUld2alZTSjl2OVFBeVVSYVM2Z3Y4dnZxL0Ro?=
 =?utf-8?B?R2VCL0pObm9WM2ZYcDZyV1BPZXlkYVJmZVQ4QXNZSFVCRGNLNjNENDBrQXc0?=
 =?utf-8?B?UWV0WEt0WnZlOHJVZ1hOeStZSitGT1FVUXVzZkdvWEl0R1hZUnlhRDhSZDdZ?=
 =?utf-8?B?QWNHb051MllERFRqb0xCMWF2NzJ4eDdjRDg0ekV0bllyNVltUU15bDgrTTV5?=
 =?utf-8?B?Smc3cHBrMURWK1UvTEhBL3pKQS82eTVUVGcwSjN0OXUvV1o2YUJtdWxDcys1?=
 =?utf-8?B?elBRWUUzVkI4OHZ0YmpMSlNOa1lpUlRQQXRydEpIVVNxK3h6Q0lXU0t4UXFo?=
 =?utf-8?B?bERDN0JwVzJvMDV0YWNoaU11OVJ3Z2hXWHNLVmovd2lMYzVuSVFQcTl1MHJZ?=
 =?utf-8?B?ZUFwZ0ZnMEg3WHNkTW5YMzFnQ0VWRVZQS2VETW9CM3llUWNzYzVrVkxRelU5?=
 =?utf-8?B?NWxPdU4yckREc2liWmtQYkpEQzRtNG03Z3ZsaFRBYVd4NmVNdlRYWFE0NzQw?=
 =?utf-8?B?NlhOY2JhVm5GZG9TREtMZVNzTEhGOE9OR2QrZS9nUzk2SmFrMTdOdU1ENXJj?=
 =?utf-8?B?LzAzQnJ2UUlIWEplVjBqUXI0LzlDVEd3dklHeUJTK1FlV0FzWFdJZEpIWmU0?=
 =?utf-8?B?NENPaFVMVmtsbXE1eURLSlU1dGhLVGtTVFlad2VramxpdUFHQ04yUzhlY09I?=
 =?utf-8?B?SUI5dmdFWitIeUZySG44Zis0YmlQeCtYaE85cGtzWXJnY2crSERrWUpSR1ZK?=
 =?utf-8?B?TktoZGpFUEZ2THhpZ0pwQmYvN2ppNnluUUtNMlRMaFl4UGJzeGFIQ1B4aWJQ?=
 =?utf-8?B?cFpLSGFoMlkrYmtPWTVKaEpMcWEyUGhjOUZVeGp1R2pJV3FlRk5FR2NldG1B?=
 =?utf-8?B?K1BOVWl2aFFnc2diTjR6ZS9FMmJwTlV1K0Z5aTh4T1Z0SXdubHF0bk96QmI0?=
 =?utf-8?B?T2NIWEFDZUR6eUhFdmZ5cWJZejZnZ2FFaDdsQlJSakdTdnZvU3dqblkzUSta?=
 =?utf-8?B?SmRFbGJTMkZVb09XQW05bkJvQjl5WVhLek1ZYkYxcnFmbElVWndta1hRaUtV?=
 =?utf-8?B?enhYei92bVJYLzV4SGZEVzBxNmIrRXFCcmtXQXZwWFlVNCtsMnhvdEJVTHFv?=
 =?utf-8?B?WmhEUFdkOCszWnZYR2E4Y0hHV2xHSUc0c1p2UDZ5VkZoUFM0dndhOFdZVDlX?=
 =?utf-8?B?NEVXWGFNR0x3YUp1OXpJQkNsYjViN2RFNlBPN2QzTnJDK3IvV0tvMHdCM3Fr?=
 =?utf-8?B?SEtSc0dEOThZZGt3Q2dSVWtFOGI5cXlYU0p6QmxMa0w1NHI2dlBvcjF6dlRi?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb34e27-9b29-4961-7f6b-08dd0d0ef5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 05:06:46.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTxCfXo/xUX/yPPWIa2D5ncIvBDY/wXHkTAHTq49sCPbsTTK/wBHQ0F2yIsPyKlSW5m5iAR686maHCSws7e2B3K6xCbZrIEFXb2hfX70PL8iATr2v69aMgNAVYtia02d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10101
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Nov 2024 05:07:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17269

SGkgVWxyaWNoLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxy
aWNoIEhlY2h0IDx1bGlAZnBvbmQuZXU+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgsIDIw
MjQgNDowMSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRl
bnguZGU7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6ENCj4g5rSLIOKXi++8pO+8qe+8tO+8
o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNv
LmpwPg0KPiBTdWJqZWN0OiBSZXF1ZXN0IGZvciByZXZpZXdzIGZvciA0LjQtc3Q1OCwgNC40LWNp
cDkzDQo+IA0KPiBIaSENCj4gDQo+IEhlcmUncyB0aGUgbWFudWFsIGJhY2twb3J0cyB0byByZXZp
ZXcgZm9yIHRoZSBuZXh0IDQuNCByZWxlYXNlIHdoaWNoLCBhcyBhbHdheXMsDQo+IGNhbiBiZSBm
b3VuZCBpbg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jaXAvbGludXgtY2lwLmdpdC9sb2cvP2g9bGludQ0KPiB4LTQuNC55LXN0LXJjDQo+IA0KPiA4
MTAwNDdhNWEyZDU5IHhoY2k6IEZpeCBMaW5rIFRSQiBETUEgaW4gY29tbWFuZCByaW5nIHN0b3Bw
ZWQgY29tcGxldGlvbg0KPiBldmVudA0KPiA1MTRmNWFjOWMxNjY2IHNlbGludXg6IGltcHJvdmUg
ZXJyb3IgY2hlY2tpbmcgaW4gc2VsX3dyaXRlX2xvYWQoKQ0KPiBhMmIyODBhYjBhZTBiIG5pbGZz
MjogZml4IGtlcm5lbCBidWcgZHVlIHRvIG1pc3NpbmcgY2xlYXJpbmcgb2YgYnVmZmVyIGRlbGF5
IGZsYWcNCj4gM2JjZjY5ODhkZmQxYSBkcm0vYW1kOiBHdWFyZCBhZ2FpbnN0IGJhZCBkYXRhIGZv
ciBBVElGIEFDUEkgbWV0aG9kDQo+IDg2MTkxNDk1ZTg5YjggUkRNQS9jeGdiNDogRml4IFJETUFf
Q01fRVZFTlRfVU5SRUFDSEFCTEUgZXJyb3INCj4gZm9yIGlXQVJQDQo+IDNhYjA4OWRmMmQ2NzQg
bmlsZnMyOiBwcm9wYWdhdGUgZGlyZWN0b3J5IHJlYWQgZXJyb3JzIGZyb20gbmlsZnNfZmluZF9l
bnRyeSgpDQo+IGYzOTQ5MWM2MzhkMjEgQ0RDLU5DTTogYXZvaWQgb3ZlcmZsb3cgaW4gc2FuaXR5
IGNoZWNraW5nDQo+IDU2YzY5M2MzZGE5NDAgbmV0OiBpcHY2OiBlbnN1cmUgd2UgY2FsbCBpcHY2
X21jX2Rvd24oKSBhdCBtb3N0IG9uY2UNCj4gMDU0NDc0NzQzMWMwNyB0Y3A6IGZpeCB0Y3BfZW50
ZXJfcmVjb3ZlcnkoKSB0byB6ZXJvIHJldHJhbnNfc3RhbXAgd2hlbiBpdCdzDQo+IHNhZmUNCj4g
MmQzODRmZjJkNTVlMyBTVU5SUEM6IEZpeCBpbnRlZ2VyIG92ZXJmbG93IGluIGRlY29kZV9yY19s
aXN0KCkNCj4gMmU2NjZlYTU1OWIzNCBydGM6IGF0OTFzYW05OiBmaXggT0Ygbm9kZSBsZWFrIGlu
IHByb2JlKCkgZXJyb3IgcGF0aA0KPiBiZWMwYmZlOWI0MDFmIGV4dDQ6IHVwZGF0ZSBvcmlnX3Bh
dGggaW4gZXh0NF9maW5kX2V4dGVudCgpDQo+IGU2YmM1OWUwYzg5ZTcgZXh0NDogZml4IHNsYWIt
dXNlLWFmdGVyLWZyZWUgaW4gZXh0NF9zcGxpdF9leHRlbnRfYXQoKQ0KPiBlMDFhZmRhYmVhZmZj
IGV4dDQ6IGF2b2lkIGV4dDRfZXJyb3IoKSdzIGNhdXNlZCBieSBFTk9NRU0gaW4gdGhlIHRydW5j
YXRlDQo+IHBhdGgNCj4gMWFjMWQ3NzVlM2E2MCBhb2U6IGZpeCB0aGUgcG90ZW50aWFsIHVzZS1h
ZnRlci1mcmVlIHByb2JsZW0gaW4gbW9yZSBwbGFjZXMNCj4gZjE2NGZlZTcyYjY0MyBvY2ZzMjog
cmVzZXJ2ZSBzcGFjZSBmb3IgaW5saW5lIHhhdHRyIGJlZm9yZSBhdHRhY2hpbmcgcmVmbGluayB0
cmVlDQo+IGJmZTdhOWE1YjQ4YzQgZXh0NDogZml4IGlfZGF0YV9zZW0gdW5sb2NrIG9yZGVyIGlu
IGV4dDRfaW5kX21pZ3JhdGUoKQ0KPiA0OWRkNDkyNWYxNWVmIEFDUEk6IEVDOiBEbyBub3QgcmVs
ZWFzZSBsb2NrcyBkdXJpbmcgb3BlcmF0aW9uIHJlZ2lvbiBhY2Nlc3Nlcw0KPiAxOWUyNzU4ZDZj
NzBlIHNjdHA6IHNldCBza19zdGF0ZSBiYWNrIHRvIENMT1NFRCBpZiBhdXRvYmluZCBmYWlscyBp
bg0KPiBzY3RwX2xpc3Rlbl9zdGFydA0KPiA0M2M4YmZhZTRjMmE1IGZzOiBGaXggZmlsZV9zZXRf
Zm93bmVyIExTTSBob29rIGluY29uc2lzdGVuY2llcw0KPiA1ODc3OTQyMGNmNDhiIG5ldGZpbHRl
cjogbmZfcmVqZWN0X2lwdjY6IGZpeCBuZl9yZWplY3RfaXA2X3RjcGhkcl9wdXQoKQ0KPiA4Yjdj
NjYyOTUwZTgxIG50YjogaW50ZWw6IEZpeCB0aGUgTlVMTCB2cyBJU19FUlIoKSBidWcgZm9yDQo+
IGRlYnVnZnNfY3JlYXRlX2RpcigpIDY2YjJlMzZhMjhmY2UgUkRNQS9jeGdiNDogQWRkZWQgTlVM
TCBjaGVjayBmb3INCj4gbG9va3VwX2F0aWQgMzJlNWVkYzI5NmUxYSBuaWxmczI6IGZpeCBwb3Rl
bnRpYWwgbnVsbC1wdHItZGVyZWYgaW4NCj4gbmlsZnNfYnRyZWVfaW5zZXJ0KCkNCj4gNjgzMmY3
NmJmN2Q0MiBleHQ0OiBhdm9pZCBPT0Igd2hlbiBzeXN0ZW0uZGF0YSB4YXR0ciBjaGFuZ2VzIHVu
ZGVybmVhdGgNCj4gdGhlIGZpbGVzeXN0ZW0gODkyNzhmZGRkZDUxZSBrdGhyZWFkOiBmaXggdGFz
ayBzdGF0ZSBpbiBrdGhyZWFkIHdvcmtlciBpZiBiZWluZw0KPiBmcm96ZW4gMDk5NGQ3NWMxNjQ4
YyBrdGhyZWFkOiBhZGQga3RocmVhZF93b3JrIHRyYWNlcG9pbnRzIGNhZDlmNDMxNGEwNWUNCj4g
ZHJtL3JvY2tjaGlwOiB2b3A6IEFsbG93IDQwOTZweCB3aWR0aCBzY2FsaW5nDQo+IDY1ZGM3OWU1
NTczMDIgZ3BpbzogcHJldmVudCBwb3RlbnRpYWwgc3BlY3VsYXRpb24gbGVha3MgaW4NCj4gZ3Bp
b19kZXZpY2VfZ2V0X2Rlc2MoKQ0KPiANCj4gVGhlcmUncyBhbHNvIGEgZml4IGZvciBhIHByZXZp
b3VzIGJhY2twb3J0Og0KPiANCj4gYzRhMjI1NWIyNzE0OSBuaWxmczI6IGZpeCBpbmNvcnJlY3Qg
dXNlIG9mIG5pbGZzX2Vycm9yKCkNCj4gDQo+IFRoYW5rIHlvdSBmb3IgaGF2aW5nIGEgbG9vay4N
Cg0KVGhhbmtzIGZvciB5b3VyIHdvcmshIEkgcmV2aWV3ZWQgdGhlc2UgY29tbWl0cy4gVGhlcmUg
ZG9lc24ndCBzZWVtIHRvIGJlIGFueSBwcm9ibGVtIHdpdGhvdXQgUGF2ZWwncyBjb21tZW50Lg0K
QlRXLCBjb3VsZCB5b3UgYWxzbyBjb25zaWRlciBhcHBseWluZyB0aGUgZm9sbG93aW5nIHBhdGNo
ZXM/IFRoZXNlIHR3byBwYXRjaGVzIGZpeCB0aGUgYnVpbGQgZXJyb3JzLg0KDQotIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2NpcC1kZXYvMTczMjAwNzM3NC0xNTcxMC0xLWdpdC1zZW5kLWVtYWls
LW5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwLw0KLSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9jaXAtZGV2LzE3MzIwMDcwMzAtMTUyMDctMS1naXQtc2VuZC1lbWFpbC1ub2J1aGlybzEu
aXdhbWF0c3VAdG9zaGliYS5jby5qcC8NCg0KPiANCj4gQ1UNCj4gVWxpDQoNCkJlc3QgcmVnYXJk
cywNCiAgTm9idWhpcm8NCg==


