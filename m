Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59430C27C50
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 13:34:41 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.57])
 by mx.groups.io with SMTP id smtpd.web10.21723.1717508071586539573
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 06:34:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=enTKUsQI;
 spf=pass (domain: renesas.com, ip: 40.107.113.57, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmY496I8g/WTXZlXLvEJNlExGkpeZPv1mqlVc9iIR6UqQn111WDfelOxPIbRnya86Bc8JRDBVtw/Vv6JQ2bBLgXxTlMoFhZJ5uhqfhRnfcBjdasYvqKIe1SyUoSwrHwWY/uZbyZHS2COqE87GrHro8UgkwBAtM3bwqBI+3F9tV8Lr2Xz4FADRja49Hzw2/lIl9KkmfwSRMU5Dn8qpXqTywgq54BgYDDq3cCBdlL62RNVmhwfPyPBtuUU1yXXGxHeRj4x5cRx9WDIDq5Kek3gQUhlov+Gr8/au1V8mEDp3z/VUP9FAeoHX2jzBPHeQYSC2EDZdTCUQdv1oHUF1+3YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYoLdivzurfSur4f76tphqswc4fAri/GIVCvINxkCDU=;
 b=aN5iSHMN02pDy25BYcownGwiqN3k0ETgyGLB7nLFz3LerstAZNveL2fQHv1i+v90sHDlDinG1yOJIct8FtfYKLaaIlq7wzjg0kcNZ9iK3L77DirP1KZEBmzLW7bPMsjmsh7PRdu8Czskc5YuCR8VKQuP8AFvR+iBZvABz1GwpgdPmpprGQWWY4nI19BnVNurj3bXHLq6GV/252o9+qwM7yR6Aiy8QmR8qLdB1LvDuNkSK+I0euntgioSFY/MNo/YejzTntSXVSItVrV08uPI7egi5fD+A059QBXJ1KJaH3WwuE5X/FP3KVOJr5EmXlpW+o374uY7ZTbSrLXKFR91GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYoLdivzurfSur4f76tphqswc4fAri/GIVCvINxkCDU=;
 b=enTKUsQI8vHhCLmYnq6cSIFQvTTkTv1wzly99JevJH2i4vs3psk6fc+6kfYTD2aSGDXqycYvfK6ljPSL0vxxyOlfDdEhhXeVtTlS5J2gulx8TelTEbQxVTmUCblE/iEHRnRbxyGEq/F6T+FsY24zhWYyobppVrdss/umYyktg04=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYWPR01MB8544.jpnprd01.prod.outlook.com (2603:1096:400:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 13:34:26 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:34:26 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: RE: CVE-2017-5715 on simatic-ipc227e -- was Re: [cip-dev] gitlab
 -stable-rc: mirroring not working?
Thread-Topic: CVE-2017-5715 on simatic-ipc227e -- was Re: [cip-dev] gitlab
 -stable-rc: mirroring not working?
Thread-Index: AQHapuzrvr46zaW5HUiHSrZakm0AcbGmWZtQgABxSwCACEr9AIAIo79A
Date: Tue, 4 Jun 2024 13:34:26 +0000
Message-ID: 
 <TYWPR01MB118628B4E0E09DE551A5931EAB7F82@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYWPR01MB8544:EE_
x-ms-office365-filtering-correlation-id: 437e9fa3-3a04-424f-c7ad-08dc849b0d92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bTFSQ05jZlZHUnhGekJxQ3h4S3hQL3IwaHJYT0F6QmMzM3N2NFA5RUhnWWhV?=
 =?utf-8?B?ZFliWFIwOVl3OVAwNTcxMHRoTjZXK3lYb3pVVVVRRWNqa0JhMTRLRUlhOXp0?=
 =?utf-8?B?SEMxWFhlRmNicGtNWG1vSEtlV1VEZEJPV1B5dERmbDZBQ2ZCcDRtamlWUG8y?=
 =?utf-8?B?V05hOW02Z2RWRXdnQXpFZEVRc0RTVVN6TW5IOU9EQWhNTlBaVVQzaEIvSWdZ?=
 =?utf-8?B?TGthSE1TNjFtZ0YyVjQ0MHFOVXJSYTVYcHQ1R21CWTNPODMvdHBvTHNrWFpS?=
 =?utf-8?B?L1Y2YXJ5U0xaYWtncm53Z3RCTys1STBiVzQzRHJBaUl1WFRZeUJiQnI1UHRE?=
 =?utf-8?B?UXZ3dEIxSzRpRDZEV3BFVEorUWlKU0xQN0tRaTVaL1N2Vm9ZTWFPRTJ6ZDdy?=
 =?utf-8?B?QW4rTUtRdllNR0N6MmhyZ01kb1ZjeDYvck5zdmlMdW16UCtPTk1LeEwwcG9Z?=
 =?utf-8?B?WWN4YTRNMlMybjRoU3hLcGplUG44UzB4NmpOdEJrOXhFdkNyY0JML3VudEJP?=
 =?utf-8?B?VjVOWFhmTlRRcFBZUDI3bFArNDEzMGY4SFJxY3N4a0FhL0hiTlJ0L1dNNUdv?=
 =?utf-8?B?S3FkSWRyZnZGY2graU85Z3dDTmpZa3VrYzVveWNFMEV3QUNpd1hzb0ZNUlZa?=
 =?utf-8?B?c1o2aFNZNkRZVGpyczU4UFI4YkVyaEtaTVRHM0ZwaG5sUW14SmZmK1oyaSty?=
 =?utf-8?B?bnhzT2lwVDFsOERhZHlTS0tnTWJsd2FPeEdRejNHMjcxekVYQkVhbjgyMkJ1?=
 =?utf-8?B?M1cwQ293a2VvdDdxOFlkc1U4bkJ5RTJtYmJDcksyOXRBaXYxUER3UHNTSDJp?=
 =?utf-8?B?R3VqR3FxSkJOeVBOYTdPTlFVUFM2UEpmZnJzQ2k3NENzUzJ4d1I3TUJzWWdn?=
 =?utf-8?B?NkF6TCtJT2gvRFUrQ3VNaXNOaUl2TFV6UnhvUmpUclhJeUZNSFdzYXRPMnFi?=
 =?utf-8?B?RkVWeEo0cjRBck40LzVWa1pUNjlDdjIrdjVNTm41WklhSUVHUm4zZE8vcFU5?=
 =?utf-8?B?RzIrcDcvc3JXTEhhZTZMOXA4elUvMlRNOVVNMW9YazhQdDE5ajN5S1NXTGIx?=
 =?utf-8?B?TGFZMHp5KzhBR0IvU1FLUFAyYkNxUTYxaHpvWXNKV0pMZHRiWEhCOVE1M2pn?=
 =?utf-8?B?QTlwK0hpQ2QyRENka092Y1NIOENiTHVQWXFDVVBvUllHeEUrTC81NlVnNHZH?=
 =?utf-8?B?Tm95RGdka2gySU9DQVNKaGpSREgvK0xVNlBPRFpyak8rZ2dhQWJLeUx0bmR1?=
 =?utf-8?B?eldtMER3ckU2ZDhGeER3OXMyMW84UG9BM0Q1QmhTUFNlNVlUak5ENStWaitx?=
 =?utf-8?B?Wk1FOE05VDY4ZXNvRGJNT1Y2M3dySUY0bGhnZGJqK1pPYUc2Q3gxVzBLMUVO?=
 =?utf-8?B?RTJxbjJQS0pIUXU5WUF5cUNjNFRFaHl6UitjbnNzSE5sSHVsQk5wcVVSVERF?=
 =?utf-8?B?NTdBMUVqOTVTUjFNTzBCazZEZE43aWt6dkZsYUNOZ1VBWU9TK0lldStKOWd0?=
 =?utf-8?B?azUwdHNtUHdnczhhdHp6RGxhdFYvUnlmQmw1QndnRGRiMklweGRzZEgwZ1Z4?=
 =?utf-8?B?aWFDSGlscHZXSXVqQUZkbXdmTFJQb3d3UmhvQWhPWkx1bjludjZFc3FMN3lT?=
 =?utf-8?B?d1owWGVvdUgwNjBDKzVWRXRMcWtXdHpramZ4bEhnTVAxMGpkVTdvcHpmUWVD?=
 =?utf-8?B?ZVRiaXVENThBc3ByVXBsT1VvY00wTXBJbjl4WVNTOWs3aEtySG8welZBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TmZtZXlOdkZuZW5JL09DTzNhQW53R2Jxem55ZGVvOE9wWVZ3T1E5aEI0dDg0?=
 =?utf-8?B?WlpIWnpiVjhwWXkwZUU5MU9HcmV3d0FBeEhSd2NJbHdqc0JIVnh1SVFXR2cz?=
 =?utf-8?B?UGljSE9ZQ2hCWThjTXJxeGU2L2grVmFreWlkQXZCTXAxK2ZIbWtCSS9DUmtK?=
 =?utf-8?B?UzVBeU5QSGFucWdyelZKWmRkRWxPL1IvbFhza0RIdHhBR1BBWDFGQ2FkVktn?=
 =?utf-8?B?RTdiblVQb212ME9ndVZYR3pDY0FFaHNyV1pRRXV3NVZDaVYrNmNiMW8wVm9l?=
 =?utf-8?B?bHZqbmNnbUdZUlN3Ykk2SXprZE9VdzAwakFwVWtUeXBrdlBsM0lqZWtkUzk1?=
 =?utf-8?B?WU9nUlRKRnU3UXFCTXBhVU81UUVnNHNzb0dKdCtkYlRxa3dJRjVNVVFTa2lj?=
 =?utf-8?B?Wnlxa3l1VURod1BhdG1Fd01ldU5BQ0phVFNlb3VuaFRWSS9zRG1YbnF6NzUz?=
 =?utf-8?B?SlBhRDRia1ZjQ0FDUU93OGdLODc5VjFxMXVlVGdJTlJEaUNJRmd3eUxvT0Mw?=
 =?utf-8?B?eE5YQ1pETVppaFJWWG96Tm1ZdVplSklYTzR0YzJBL0tESW42Q2JLQk95Vnpj?=
 =?utf-8?B?WmEvZWRoendQR0NsLzFJbXh0MjVpY1VQZ3pqeW1EN1NvUDI5VndicEFwWVBN?=
 =?utf-8?B?VHBrNUVselZkODA3NVlsUDhUWW9kZVh3d0FHRlZETWRBVVYycHVTdDNqWFhN?=
 =?utf-8?B?ZGZSeDlYSVhZRnZkMFJSclBDR1BienhCSXFCTDFITEFPQlp0YllRaTVYMkYv?=
 =?utf-8?B?UnNLR3p3TUJzQ0tHM2grNmtDZzNPWSt6bnR2SEpET0pyQ3RYRFZHSHRIUU55?=
 =?utf-8?B?RnIrKzFDcVBYMGlGNTVhbDI4Vmt2MXRxa01HWVp0SEdySzBqR0VTM0tvTlNp?=
 =?utf-8?B?dGpoWTh2amViekJFVzh6TFl6QTk1MGFsMmxDMkdKcm5nTFZSV3lvSERrSVJJ?=
 =?utf-8?B?ZVJsSGNiZnA0VUlmZ3dCTGFFWUVmM3c3UmNhOU5IakI3UUdsbWhPMzVPSmxp?=
 =?utf-8?B?Qm4vZmg3ZVZ1TTl1b2liSkxEcWkvSlk1bHVGNjFtQkhBZzFOSElPSmJycUcv?=
 =?utf-8?B?TGlpREk2aG5ReDl3U2tBMmtNOStFajNrV00ydEtMZkFLdnFLZTlHY0p4OTZP?=
 =?utf-8?B?cEJzYlV4TVNrYkF3RHdEM1BCQndYbFNiMXVIY29HcTg2K1BCemdOK2YvTG5E?=
 =?utf-8?B?eERGMVcvankya1pFN3dhV052c2N1SzR4U0FxQU1CVlVqS2VOc2oxNDhsdStu?=
 =?utf-8?B?QTdCRU5yZU5tNjNLVlc0eG04am1DaExvREYyUXBBT3NhY0VJRjVIRlljNGkr?=
 =?utf-8?B?QmNsWFhoUkU0OU45c3pQRnB1eHJwZE0rQmdrbjEreVZ0YnByVzJmWW04Zzhz?=
 =?utf-8?B?L0RZd0xnSVcwbGpOUTdlOGZ0OEE3aGVqZDJtYXBXdDAvRFdwRHBvemFRYjVP?=
 =?utf-8?B?Q1BxRVc4cTNISVJMUHdMNGw0WjBhaHBjY2FHcWFpM3pjenc5S3A2Y1RmeXpw?=
 =?utf-8?B?YjJwU2VLaUpNWWRUNU9KL2NGT2N0c1FTNExucnY3bXB3S2xKOWpiYWo4L1Jk?=
 =?utf-8?B?ZGVEeGdZditsRFpreU5nclRtc3IweUw0clFhWS92VVQvZHBFUnVhTWllVTJn?=
 =?utf-8?B?anQ3cHBLMjI0Q2VOSlZGakkrb0cvYnJBeU5RVTF1U0E0eXppUjJJQ2d1VzhJ?=
 =?utf-8?B?OWdmU2EvdFliMm5mN2M0U09IUlUycjh0Wnhka1NiYVJPSWs0NHVJMTVEWUNP?=
 =?utf-8?B?UTh3dzB1RmI3RHBqVSttMGlXamJ3ZmFJNEg0YkFEaHRHc1grczhYa3V3TWRt?=
 =?utf-8?B?dGdJNnRTaTJNOUMya0dIdFlGekNOb0ZZa2hHZjRRZHNmWnkyY1VuUy9pY1Qr?=
 =?utf-8?B?b1BEU0NRMDNyQmZaNXVWWUY5RHRVbElCTkpEbk1wQzZ6UDNMbUdzSHFNSU1Z?=
 =?utf-8?B?VCtCT3ZMY2JUVVU2ZFJFQzhtMmJBWUdoMmJIdU8xd1l2VUo3SVhhYXFueHJj?=
 =?utf-8?B?RzkxcHhlVHVERWtmNGNjM3pzazV6M1RTVStnNnlpMUJobkVNWTVpSC9LeHVG?=
 =?utf-8?B?Q2JXSGd5MmhxazJRMGRHdFhxUElWWjc4U09aanpGTzNEa29OVUNwRzlSWFVX?=
 =?utf-8?Q?3K0QuSPlGBdm2JTbwkoYDi9hI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437e9fa3-3a04-424f-c7ad-08dc849b0d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 13:34:26.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gZPL8mqc16H6ZW2GASpzXchHQphnF4HogxkApOTinlqgR7+Se4Bvs9aBEV1Z+Rh+jnRuO8nydM31msFSyUYnbheHdr9cEJKuCGl77NRIl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 13:34:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16107

SGVsbG8sDQoNCj4gRnJvbTogbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDMwLCAy
MDI0IDI6MzcgQU0NCj4gDQo+IEhpLA0KPiANCj4gPiA+IFBlcmhhcHMgdGhpcyBpc24ndCBhIG1h
c3NpdmUgaXNzdWUsIGJ1dCBJIHRob3VnaHQgSSBzaG91bGQgcmVwb3J0IGl0DQo+IGFueXdheS4N
Cj4gPiA+IEZvciBub3cgSSB3b24ndCBtYXJrIHRoaXMgYXMgYSAia25vd24gaXNzdWUiLg0KPiA+
DQo+ID4gSG1tLiBUaGF0J3MgU3BlY3RyZSB2Mi4gQ2FuIHlvdSBnZXQNCj4gPg0KPiA+IGNhdCAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS92dWxuZXJhYmlsaXRpZXMvc3BlY3RyZV92Mg0KPiANCj4g
UGxlYXNlIHNlZQ0KPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8x
MTQwNDAyL2RlZmluaXRpb24jZGVmbGluZTcxIC4NCj4gDQo+ID4NCj4gPiBmcm9tIGJvdGggd29y
a2luZyBhbmQgZmFpbGluZyB2ZXJzaW9ucz8gQXJlIHdlIHVzaW5nIGxhdGVzdCB2ZXJzaW9uIG9m
DQo+ID4gc3BlY3RyZS1tZWx0ZG93biBjaGVja2VyPw0KPiANCj4gUHJvYmFibHkgMC40NS4NCg0K
WWVwLg0KSSd2ZSBqdXN0IHN1Ym1pdHRlZCBhbiBNUiB0byB1cGdyYWRlIHRvIHYwLjQ2LCBidXQg
SSBkb27igJl0IHRoaW5rIHRoaXMgd2lsbCBjaGFuZ2Ugb3VyIHJlc3VsdHMuDQpodHRwczovL2dp
dGh1Yi5jb20vTGluYXJvL3Rlc3QtZGVmaW5pdGlvbnMvcHVsbC81MDkNCg0KS2luZCByZWdhcmRz
LCBDaHJpcw0KDQo+IA0KPiBJIHdpbGwgY2hlY2sgdGhpcyBhcyB3ZWxsLg0KPiBCdXQgaXQgc2Vl
bXMgdGhlcmUgaXMgYSBwcm9ibGVtIHdpdGggTEFWQSDimLkNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gICBOb2J1aGlybw0KPiANCj4gLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZz4gT24NCj4gPiBCZWhhbGYgT2YgUGF2ZWwgTWFjaGVrDQo+ID4gU2VudDogU2F0dXJkYXks
IE1heSAyNSwgMjAyNCAzOjU5IEFNDQo+ID4gVG86IENocmlzIFBhdGVyc29uIDxDaHJpcy5QYXRl
cnNvbjJAcmVuZXNhcy5jb20+Ow0KPiA+IGphbi5raXN6a2FAc2llbWVucy5jb20NCj4gPiBDYzog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBTdWJqZWN0OiBDVkUtMjAxNy01NzE1
IG9uIHNpbWF0aWMtaXBjMjI3ZSAtLSB3YXMgUmU6IFtjaXAtZGV2XSBnaXRsYWINCj4gPiAtc3Rh
YmxlLXJjOiBtaXJyb3Jpbmcgbm90IHdvcmtpbmc/DQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+ID4g
PiBJJ2QgbGlrZSB0byB0ZXN0IDYuMS45MS1yYzIgYW5kIGZyaWVuZHMsIGJ1dCBnaXRsYWIgc3Rp
bGwgaGF2ZSAtcmMxOg0KPiA+ID4gPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lw
LXRlc3RpbmcvbGludXgtc3RhYmxlLXJjLWNpLy0NCj4gPiA+ID4gL3RyZWUvbGludXgtNi4xLnkN
Cj4gPiA+ID4NCj4gPiA+ID4gQ2FuIHNvbWVvbmUgdGFrZSBhIGxvb2sgd2hhdCBpcyB3cm9uZz8N
Cj4gPiA+ID4NCj4gPiA+ID4gUGx1cywgaXQgd291bGQgYmUgY29vbCB0byBzdGFydCB0ZXN0aW5n
IDYuOS1zdGFibGUgYnJhbmNoLg0KPiA+ID4NCj4gPiA+IFN1cHBvcnQgaXMgbm93IGFkZGVkOg0K
PiA+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LXN0
YWJsZS1yYy1jaS8tL3BpcGVsaQ0KPiA+ID4gbmVzP3JlZj1saW51eC02LjkueQ0KPiA+ID4NCj4g
PiA+IFRoZSBpbml0aWFsIHRlc3QgcmVzdWx0cyBsb29rIG9rYXksIGFwYXJ0IGZyb20gb25lIHRo
aW5nLi4uDQo+ID4gPg0KPiA+ID4gSXQgbG9va3MgbGlrZSB3ZSdyZSBzZWVpbmcgYSBuZXcgZmFp
bHVyZSAoVlVMTikgZm9yIG9uZSBvZiB0aGUNCj4gPiBzcGVjdHJlLW1lbHRkb3duIGNoZWNrZXIg
dGVzdHMgLSBDVkUtMjAxNy01NzE1Lg0KPiA+ID4gV2UncmUgb25seSBzZWVpbmcgdGhpcyBmYWls
dXJlIG9uIHRoZSB4ODYgc2ltYXRpYy1pcGMyMjdlIHBsYXRmb3JtLg0KPiA+ID4gRmFpbGVkIHRl
c3QgY2FzZSBsb2c6DQo+ID4gPiBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVy
L2pvYi8xMTM4MTAzI0w5OTgNCj4gPiA+DQo+ID4gPiBJIGNoZWNrZWQgdjYuOC4xMS1yYzEgYW5k
IHRoaXMgdGVzdCBjYXNlIHBhc3NlczoNCj4gPiA+IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9y
Zy9zY2hlZHVsZXIvam9iLzExMzc4MDcjTDk3Ng0KPiA+ID4NCj4gPiA+IFBlcmhhcHMgdGhpcyBp
c24ndCBhIG1hc3NpdmUgaXNzdWUsIGJ1dCBJIHRob3VnaHQgSSBzaG91bGQgcmVwb3J0IGl0DQo+
IGFueXdheS4NCj4gPiA+IEZvciBub3cgSSB3b24ndCBtYXJrIHRoaXMgYXMgYSAia25vd24gaXNz
dWUiLg0KPiA+DQo+ID4gSG1tLiBUaGF0J3MgU3BlY3RyZSB2Mi4gQ2FuIHlvdSBnZXQNCj4gPg0K
PiA+IGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS92dWxuZXJhYmlsaXRpZXMvc3BlY3RyZV92
Mg0KPiA+DQo+ID4gZnJvbSBib3RoIHdvcmtpbmcgYW5kIGZhaWxpbmcgdmVyc2lvbnM/IEFyZSB3
ZSB1c2luZyBsYXRlc3QgdmVyc2lvbiBvZg0KPiA+IHNwZWN0cmUtbWVsdGRvd24gY2hlY2tlcj8N
Cj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiAJCQkJCQkJCVBhdmVsDQo+ID4gLS0NCj4gPiBE
RU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgICBNYW5hZ2luZyBEaXJlY3Rvcjog
RXJpa2EgVW50ZXINCj4gPiBIUkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUs
IEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCg==

