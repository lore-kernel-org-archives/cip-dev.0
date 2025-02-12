Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38000C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 22:21:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.1176.1739398893129611420
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 14:21:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=W8vtb3si;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1739398873;x=1740608473;bh=/C9tXNoeefBOkIqTAzSg4LaPYCXo+AQZt0TeJxI
	pawk=;b=W8vtb3siQxRxqcEWlsCONRLhvZwLA/36T2qyCrM2sCnR5LD+Bc9lTCDNHKF7LxbP5QqGq
	3/fElnDhsb7lHJLLwC5+opg3GmpS0tYJuj7f87n7Wynx7ytQ5rRQC/QQm/0GLaHW9NUDP2WsOrqSv
	JDnGV0x5OCNER4Cn8rL/vbi+hJYx7FiTyxpAWjDQ4cWHT6QhvmdZOacHkj4jNVWZtcZ3dNVVoxvHP
	wa1x4JuUYe1dyKvP6d2uAh5D8LmbbkR2j/bq5MwJmJBE4qD2uITZN/lNQsVTRPOQRsKrtnBoLwXdr
	OcrcSvXDWNwgOALOneehWI7WOvuXOKpKik1VFDgxaA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51CMLCDD958511; Thu, 13 Feb 2025 07:21:12 +0900
X-Iguazu-Qid: 2yAbj3N9XkBoHPkUhb
X-Iguazu-QSIG: v=2; s=0; t=1739398872; q=2yAbj3N9XkBoHPkUhb; m=CmWZwan5cZe6WwNyNW0cGSMAykRQEnpX320X0YHYkG0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 51CMLA5k659643
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:21:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWU5faLcN2TC01jy1lfkilT5p8rcDRm9GQcIkxUc2foTojcZqx+wcNWcENreBfagdnzf2qdxjs1C6Amt3jPAyzrwxo2iQrB2M0KDCPqwatn+nfcHlmnKDfWcdjT4EV16NhiZN2cLfIQHdS2FrXxqXWAK32AEJjdkOX2gPl8T6acLxb3qdxk93VuRSn3rITY13DKGjgyJy3fYNXgeEzJCqfSb7IGZJtTdL+2sLXjDf35uwrV5k9vtianwvtL4NM8szmpjsnhkekp5QgSo2C+50WWGD/l0foo7oa8G/f1zXOmHSJ8E6Fzzh9oTG8aO3oU+48YG9j67U0vjdRPTGaG2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C9tXNoeefBOkIqTAzSg4LaPYCXo+AQZt0TeJxIpawk=;
 b=GvEFrXdxJ/EyVk3+G7bRuYemZFEMGEFcg43+MpsDEQP3FrVjWxvJGyJsS7d2Nrh10o/C2Xzc5TpAI0T7EYU3Yppn7aD8Aew9CHMvi+UzocC1J2iBoWUUT8JBSQ9gDKmBboD+JMHs/HNOzuxVH839CwhsBpU081X7CK+meLY/GVdlnnvu/tRPsxpWArA8wGWW4c2s1yeThB4bVHkCTkgQwyOpUWYw/OYHuQPiE9q8e2BXgL67kjouUQBELffG0f8bqqiYxgIyqm8TKm61kGlxEAmagY+YEe3lraOOY8E6ZPkIBien+FOwzt2Qbz8tXeVP/R4W1Oh/xHAq6lwqEZQtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for reviews for 4.4-st61, 4.4-cip96
Thread-Topic: Request for reviews for 4.4-st61, 4.4-cip96
Thread-Index: AQHbfCqzrIoECUMDc0St5t1U56o66rNEP3Hw
Date: Wed, 12 Feb 2025 22:21:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388925C5EFE62046922C7EE92FC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <707882010.596091.1739240064075@webmail.strato.de>
In-Reply-To: <707882010.596091.1739240064075@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8181:EE_
x-ms-office365-filtering-correlation-id: 80e232e9-a160-4671-163b-08dd4bb38c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U0FWQ2E4SHlvcHZUOU0wN1I1akpicmlRMk1EbXN2blhEVitNTFd6KzdHMk1T?=
 =?utf-8?B?RFkxb21wZzhRdFdFbmErLzVEdHJ3T2lRb1RnNmtQRkRjQ09pZ2FrV1NTWkhi?=
 =?utf-8?B?K2Z1SjBWRVJCSXN1a3p0VU5IQ1RkYnJuWVI5VnNwRkpzR25HVVRhTzY2UXhB?=
 =?utf-8?B?SkRmTmczWDVEWlFVQk9vWnJubE45T3dVLzhyWitwT2lYNkJZSFNqZWUzMi9P?=
 =?utf-8?B?dUpnZUpmNTRiekZHdlRnQ2UvOW9NMmk1b2hlcThQa283TkIyMms5SmZGVGJR?=
 =?utf-8?B?aTN1L3lxY1hDa0Z3MDE0N1ZzSnoxbW5rV1EyeTNaZmwwTlMxZnZXbGNUQkVt?=
 =?utf-8?B?aHBCaCtnK3F6R3hSeFpZcjlsckVMc2ZFUnRZOTZITFdJYU1QZmllNlJPZklL?=
 =?utf-8?B?YmplU1Z0Z1VkeldpQkRuRG81RUtZeUk3cHVOZFpyT3pLdlBOSzNwSUxUcUVz?=
 =?utf-8?B?YXFrVStqbW5Yc2cyM1JkRDdKR0U0Y25GbURMTkhYM1VXTUR1UDJ0cUtqMmFm?=
 =?utf-8?B?MnZiZXM5UHB1aHdCblpCZUM1QkVSYjRXa1V4dEFRV2xUVjRKS01HbTN3QStZ?=
 =?utf-8?B?Qk5Ra2RpeGhlQVdLYm1VM21NS3dqUmtDT3NqbmsvdnpWVVE3Ny95ZlAwVDEx?=
 =?utf-8?B?Uk1OQ2twbXdSS1Jib0s4T2FnRHNuL09IM1Q1ZktTQXdYYWcrS01wdWZjVENo?=
 =?utf-8?B?UHZFdFJrVkc1enR3M3R2U2U4QjBLY1lZM2R2RzN6bVdRczMrQWM0ai9HTFlp?=
 =?utf-8?B?VVpFNWV2WnRFTkJPaEdaTFdHaTR5bHVKYkFFWXJKR0M5Qjd5RkFQckxBVVpP?=
 =?utf-8?B?cStjT1M5S1M2enVvaytyNnBETVQ4a3BFaXVwWUJJenI1bWhpUWNBNmE4c2Zy?=
 =?utf-8?B?SEVRY3FmOHFTeS84MWtOVDdXdk42YzJSajRIanAzYjEvN3dVTVJIdnVaOGVw?=
 =?utf-8?B?Wk1MQ0pQZVFaZWNUeWNJZU82MURwanQrUVU0K0lNYzIyWmIzTkZsWmk0dlpX?=
 =?utf-8?B?OEphcmlTSU93ZlVtZHl4TTFrQUYyS0hwQzZKNnJ0L01NaGhpUTdIZXFUMks4?=
 =?utf-8?B?cUN5Q0hHRWw0NS83R3hpYTRkUWtuRnM4R3RjbkJqV2hkMDFOdUF0NkxhUWF3?=
 =?utf-8?B?VGhNalB4OVg1TDdTMThPV1N6cjRHY0lkMGxVeW9kT0tXeUMvRjlrS1hsbkZ2?=
 =?utf-8?B?dUtzeVdWSzI5dG8xZGJvNGFPSFBhalBsS2NxcDl0TW1hWHkyVXdMSGFkcHdE?=
 =?utf-8?B?b1lYVlFOYklGZ2J5UjBPcjVoc1hweUt2UVdZS3BLVGlEeDFSYXB1TCtQWHZL?=
 =?utf-8?B?TUZkdUxlQnU2YUk4aEJGS2xNSVNmV28vN294eFpJSkNjSlRYQnl3eGVPcjQ2?=
 =?utf-8?B?WnBZcHYzbEJURTlaTm00SVpFbkhBdlc0UU1FNC9CQVRtbmhEeERQM3RxYW9H?=
 =?utf-8?B?UmZXWnJNR2Y1NXFPQ0kyTFNSdGw5bk5VYXBXS000d3RhK2RkTVdsTENQb05x?=
 =?utf-8?B?RUxHbWw5VG15Vk5jTmpyanpQd1F2T3YvOWx4UkNLY1pkSGN0WTZQMmhLMGhN?=
 =?utf-8?B?V0M4d1hiTXRBeHMrazhraVBsZzNHRzExdVF0MTNRbkZWc0R5bnYveG92aXQ0?=
 =?utf-8?B?bVcyM2VNMVBVSHQyYmE0a1lFSU96K1RaVi9uYTRZU3ZBSWxtSEFHbEQ3QzlU?=
 =?utf-8?B?cGc3RU1uU1VEMHJuSGFSREhNcDlnOXN1bWk5cis5REl0ZUVJS0dwdkZUcGlH?=
 =?utf-8?B?dFdwblkxMUg3bmtyQXlzZm45NmNRQzR0WWgzZ1VxV2xpNlVMOUJWcDhFRG9v?=
 =?utf-8?B?SDBkTklwdC9BOFVQWElCbXRXc2pBd1pJR1Rvak55dnhNZFczdC9KdHZPLytU?=
 =?utf-8?B?ZGRHRVprTUlmd1BzRk9TeEJWbk1qZ1BlYUYzb3R1akNneDRyS1FBWnBucTlx?=
 =?utf-8?Q?LbTyaERjnK2v9H5eSUszHayULCO3OKn5?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z1hlR09nT3prQ25wL0NCRmRKeEJDcko1VzFXQUxicUlvNXJoK2JuQ09aRUd3?=
 =?utf-8?B?M1JSb1JpVWQ1UzFYdVpqdDh1bGsyQnVMc2sxWUhmYnZhbi9SWE1GeVE3NWtn?=
 =?utf-8?B?cmduamJKRURydlhSUWQ0eXdyclZjMkVqc203OUY5Sld3eHZPc1BIUFBYR1RN?=
 =?utf-8?B?RTFoSHZUU1dFbVk1VTZQQ0M0Y2t6cXBWcEtaMFpMa1d2MVJ5ampWTDd4cU1l?=
 =?utf-8?B?UjUxaHVEU0N3Z0x0Z0xrTFpYSktZUUZyNEJsNExrMG00ekdtamlLNURzbWZN?=
 =?utf-8?B?eThGQmhzL1RUcm9qSlJBY2tEOEd2SGN6L29UOGk1WkZiWiszMGp3MVlRbzhE?=
 =?utf-8?B?OGZpMWVnaDlEVHdqWHhXaEljQ3FkcS9xaDg5Qm12bXRiRlMzZGFnc0Z3bTZN?=
 =?utf-8?B?a0wwdFpaNy9GTzZUYWJwWWtrMkhjZ1pmLzBTN293ZDc2T3JxUmc2SFZwMXVV?=
 =?utf-8?B?RDl5Ny9rbWd2YmpzU3V6akVFUmx3UlhuTmNaU1dKZVU2bU5mR2R0dkYzeHk1?=
 =?utf-8?B?c3FHNVcrbGRDY0VrQ0Q0Q2Q4VXdQTTMzeEJPL29wQU9NQWFPbkpSbUhmVjBq?=
 =?utf-8?B?MVI4OWtYQkVVQmtLV3J0bUlCOVFvVDh0dWNYYjFka0xBZ0x2WTF3Mkdub0R5?=
 =?utf-8?B?aHZ5TWNGekVJOXlVQ2d3Y2Iya3VDcCttK0k4ME1HRU4vejJ0Y2xGNEdXZUgx?=
 =?utf-8?B?M3Ayc0VTak4xVDdXUlhKaXRhbFV6bmVLRmU1V1JxSThCV2lxV1ZYaHpUQ1RR?=
 =?utf-8?B?WjlKNXVyTGQyRWY4RUt6cTU5ekFmQ25FbGlkeEV4a3JtckRieWxPOUtTUXY4?=
 =?utf-8?B?dG9heVpoMDVWUUswblNxZUFSSlViWjNucXNLQ0FOQW9OQmQzdVVSNjYyTnVR?=
 =?utf-8?B?S2tYRU1LclE0UmlqMEdCcHo4WFhhSWxIeE4xK2pDc0VYVVZ4cEs3cC9IWUsy?=
 =?utf-8?B?QTltVTJBajJMaWY0dDNhaFZwRlkzcSthTGg1K2E1SzMxalFFL0dSMGZhQUFW?=
 =?utf-8?B?ZFJNZVg1UWJhRGNPTFYvNFJISEZsdmlWYURnWlVpRWhidWpLd05ZcVZzVWtv?=
 =?utf-8?B?bjFaMllpd0J1TTJYMW5pR2Vzbnk4cG5teGRzQ0Vib3JHTkFYTjFyZjMwYmZQ?=
 =?utf-8?B?aEJpRkRTejdLNUo3TjNzc3JtK0I2UUtzMVFYcG15U3FoTzJDRUc0RlZmUkRI?=
 =?utf-8?B?Wk5NWThrQ01CYW9iR3lKOWRnTGpSS3plR0pHdSt0RDFaQXZrUktrTU1ocXo2?=
 =?utf-8?B?a2UrU1lLLzRjellpM2JXZDNIbnVPZzdkdlpyamhhSC9HbGdPVitrK2IxcnlV?=
 =?utf-8?B?UG9HMVp2aHZ2OW9uZEtNWmk1WVZENXdVVjRyRnBUNm9Od2w1NHRCRC85RS8r?=
 =?utf-8?B?bG9NSFhaYTNqdXdLVmJHUDlLZEptWDZucElsTDY2TlpNYWo1alFCQlBON1FM?=
 =?utf-8?B?bitscUFqaUFRd2RybnpTM2sveGM0d0dMWUpFT2kvdndUS3U0ZnlVR2tMMllr?=
 =?utf-8?B?MTZ4MmlGMWNKTlJnRjBJZ0E1amp0em9kbnlDWTV3ZTErS3poaENSL29YdmYw?=
 =?utf-8?B?QmZSN2FHVGQ2R2dOd2hYVjVjcXNFbUdqMmx3anBrOFZhWDlKTWRPRk03aUJJ?=
 =?utf-8?B?OUQrV09kZnpGVWozaFZMdVIyN0FYVVloK1NuZjRuUkZ4ZFpjUFBLSHFEVXN2?=
 =?utf-8?B?TnZFTEZoZVZHdkxrRlU2SVNBZnB1dUNIVUhMZXhKaThCUXZkcVppbUo0K0xk?=
 =?utf-8?B?UXJMU2xTMWU4YTczN0pmNzFMWEM4WHFWbkhjeFE4bGd1bmtRdFU5c1RuYnZ6?=
 =?utf-8?B?dGNGZkhHVjM2RkMvNEI3bU9COS91Z3ppbjhSUFNnSERmblhBWC9yYStUWXFq?=
 =?utf-8?B?ek9sSFpQM3JFSFZMa2ZnQjVpZlJDNkJmQUp1Wm11RlBnek9jT2tlYzBqTzgx?=
 =?utf-8?B?OFYyVEpsUlVTd2JvaXlPV1hrdmJoYkZYalVZQk8rc2srZWlHZ1hYeUgyQmlF?=
 =?utf-8?B?WW05NElJaER0cm93cEdRYmI1Nkl0MGN2TytRSHgrb2ljQ2FYM1FidkZpaE1E?=
 =?utf-8?B?RjdkUE5OZzd6d29kVm9vZVVHakViYjlMelFaclBaS3RVcVNoY3VueUF0QlNi?=
 =?utf-8?B?ZnRuanpaN0psdVkrU1BKa0VlSEF5QVJ3d0lmZ3JBWGg4bWE3LzN4cHpUUDJN?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e232e9-a160-4671-163b-08dd4bb38c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 22:21:08.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dP3vHJtiH0tKsX8+/vY0EFuvQyKxZLxXX2/B8P6SJ/o/3KkUszj36wpPo+NbgOLT7HkpVn76QML2cFl4XxXNeUgT3pxiGzhzC/NlcmpMwRp1wI884QWWH2iKTbguu3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 22:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17819

SGkgVWxpLA0KDQpUaGFua3MgZm9yIHVwZGF0ZSA0LjQueS1zdC4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbHJpY2ggSGVjaHQgPHVsaUBmcG9uZC5ldT4NCj4gU2Vu
dDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUgMTE6MTQgQU0NCj4gVG86IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBkZW54LmRlOyBpd2FtYXRzdSBub2J1aGlybyjlsqnm
nb4g5L+hDQo+IOa0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQpIDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmVxdWVzdCBmb3Ig
cmV2aWV3cyBmb3IgNC40LXN0NjEsIDQuNC1jaXA5Ng0KPiANCj4gSGkhDQo+IA0KPiBIZXJlJ3Mg
dGhlIG1hbnVhbCBiYWNrcG9ydHMgZm9yIHRoZSBuZXh0IDQuNCBrZXJuZWwgcmVsZWFzZS4gVGhl
eSBjYW4gYmUgZm91bmQNCj4gaW4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQvbG9nLz9oPWxpbnUNCj4geC00LjQueS1z
dC1yYw0KPiANCj4gU2VlbXMgbGlrZSBhbGwgbWFudWFsIGJhY2twb3J0cyB0byA0LjE5IGFwcGxp
ZWQgY2xlYW5seSwgc28gdGhlcmUgaXMgbm90aGluZyB0bw0KPiByZS1yZXZpZXcuDQo+IA0KPiA2
NWEzZGE0NTdmNjQ4IHBoeTogY29yZTogRml4IGFuIE9GIG5vZGUgcmVmY291bnQgbGVha2FnZSBp
bg0KPiBvZl9waHlfcHJvdmlkZXJfbG9va3VwKCkNCj4gZmJiMDBlZTE4Y2ZiOSBiYXRtYW4tYWR2
OiBSZW1vdmUgdW5pbml0aWFsaXplZCBkYXRhIGluIGZ1bGwgdGFibGUgVFQNCj4gcmVzcG9uc2Ug
YjMxN2EzN2U0MmRiYyBsZWRzOiBjbGFzczogUHJvdGVjdCBicmlnaHRuZXNzX3Nob3coKSB3aXRo
DQo+IGxlZF9jZGV2LT5sZWRfYWNjZXNzIG11dGV4DQo+IDIwZTNkZmM1ZTYzMTIgbmV0OiBpbmV0
OiBkbyBub3QgbGVhdmUgYSBkYW5nbGluZyBzayBwb2ludGVyIGluIGluZXRfY3JlYXRlKCkNCj4g
OWYzNzY5Mzc4NzY3ZCBhZl9wYWNrZXQ6IGF2b2lkIGVycm9yaW5nIG91dCBhZnRlciBzb2NrX2lu
aXRfZGF0YSgpIGluDQo+IHBhY2tldF9jcmVhdGUoKSBkYzRkNzRkMzZiMWJjIG5pbGZzMjogZml4
IHBvdGVudGlhbCBvdXQtb2YtYm91bmRzIG1lbW9yeQ0KPiBhY2Nlc3MgaW4gbmlsZnNfZmluZF9l
bnRyeSgpDQo+IGUyZjI4YTBjYjBhODEgbmV0ZmlsdGVyOiB4X3RhYmxlczogZml4IExFRCBJRCBj
aGVjayBpbiBsZWRfdGdfY2hlY2soKQ0KPiANCj4gVGhhbmtzIGZvciBoYXZpbmcgYSBsb29rLg0K
PiANCkkgcmV2aWV3ZWQgdGhlc2UsIEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHdyb25nIHdpdGggdGhl
c2UgcGF0Y2hlcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=


