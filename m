Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B9EE4993
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 08:38:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7092.1692779877475641385
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 01:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37N8bsO41301575; Wed, 23 Aug 2023 17:37:55 +0900
X-Iguazu-Qid: 2rWgbWvRzbXwSW5S58
X-Iguazu-QSIG: v=2; s=0; t=1692779874; q=2rWgbWvRzbXwSW5S58; m=nviDVwiydhdkaZppYnIwnos0hPIpVvO/AEtX+4aFdRc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 37N8brHQ2379327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Aug 2023 17:37:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz4cZ9i2lBpZ6wRaynM47Z+9ZeDCNPhfEKi1oRczCXcnJ+eyroD7vxjgSLc51Ja2vW9o2uwNeOcAKB58+liRsRib0jE+O7ElZOyXU2W9V7h0G0PIG/Liwdmt5ONVOSF40QQc/g2HocyK4Btf5X5frOf2x8KKTqYUPaPQnST3FckN50r55W3dN3xRbKPObkiwe0xVF9S5oXpi50G1ssTRkE/iuIh31OEiaoGBI/pN+HaWnvxhI079tGqOLfxvTbZoH9kIVe+Jc+O8z2MOFyU8gwGnbsA8zK9lPWqmldxksHCQV2NEPptUHCZU2r4CQjMfVXuE8nFxeWTw3fwOIY/x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjK7HPpTthnBQTRPXKCvt3ZQ0ZKUeqZtVpuk8HJImw8=;
 b=cSf+0nfx6fI8J0Oybna5LInUAyNDjSiihoh9QKozVlQEVHv+TGFi/eNuM7Vm4HtVOjiKmqmvssQ1RWBg5cO6U5QdKTarXANzrov3k7ZCD9FtKeCJiyXytmjPRPDP3SvHl+lT4A3rN4QPWjWnzNZBqxzr2xQ7W5oJ1swL2favTaqwKnE7EZ7cIsUMiKXzZYUxvSQS4yCEmXZIri4hashw4n3mPeCOEO1PdWERS0s330NV7qjewb7fKBmRBO1CmNGdz7FbpSmoKJ7s8+gPYTagBawZSprxMol2WTMCrCRemUyVAvIkAYusQC3oOL3x5B7ykybQgx91+I6JYeUuBcLRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] scripts/*/efibootguard-*.py: Make FAT
 file system image create reproducibly
Thread-Topic: [cip-dev] [isar-cip-core] scripts/*/efibootguard-*.py: Make FAT
 file system image create reproducibly
Thread-Index: AQHZ0RTnyu4JBRoD3EOrb/LSAIv2JK/uihSAgAeEgiA=
Date: Wed, 23 Aug 2023 08:37:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYBPR01MB554958BC918EE615C5C4FBDEA41CA@TYBPR01MB5549.jpnprd01.prod.outlook.com>
References: <20230817141246.2503-1-venkata.pyla@toshiba-tsip.com>
 <c3591d1b-3d4e-4689-b0da-d5da5d8606c9@siemens.com>
In-Reply-To: <c3591d1b-3d4e-4689-b0da-d5da5d8606c9@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5549:EE_|TYCPR01MB6109:EE_
x-ms-office365-filtering-correlation-id: 5a248042-80a1-4462-73e2-08dba3b43d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zR8m/Y0c2TFWWyOAWpYV2xNdeZZUofYhcizsm6WajkXHUOnMxTzSYca7YLAzhHq3bkJrF/SBGlBfuP27UBUIVGMd1QOe1E1PTpH8BXoKFjjcUEPjRlpODJpUlrDC+xF/sL6pt67GX0YVJxFRlUScewGSNZfE4fIkZT228RJavRB5FD8lX/OwcU2HwKhQSMu2teC4QsCOnX4rPNc/c9ACDGxKEUqr/g8I1Lg+4nJeHzz3xzR5boauANh6Qz0fVcUTQTocu09htElv0HAEWr4iVUqPNK6ArGrgx7iJbkQ1jmjYjCwz4FSCgSdkKZIFjaSWacPr4a6+vV4LjKnKpEL5vaAapRuBIHnJNvHplNk0BjU0T17T+ns/VzJNXpoGljCWi1/Fwm+WuOnyps5msJ+SEVb4135vFOSChgOylkIwy57Xvlb5jTpCDNdrdqdw83s8ILhMOiMoK/bRcasT/NyKMwgcm60y9YZQA6IwBIzXqpQFFkKVgvGbUpShEYH30O6+whfV3yEBju2XLFVGGXXio8pjt9puy3NZ9Mc1GPbX2sX39almFfa/YcvmCAJEpxK/ViffBpxiYJBmPcDmk9LD5Ffr4J/ObTopR++fobG+Ds87n/hfx4Ul+QYi0XEi1fW6
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5549.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(71200400001)(55016003)(53546011)(6506007)(7696005)(107886003)(52536014)(5660300002)(86362001)(9686003)(2906002)(33656002)(4326008)(38070700005)(76116006)(38100700002)(66946007)(41300700001)(85182001)(8676002)(8936002)(66476007)(6916009)(54906003)(64756008)(316002)(66446008)(66556008)(122000001)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RzdDOFlSbXNNYkF3ZUhPbW9CN2xRcW1zMzhqZ0hReGJmN0N1MzdoT2Z0MFF4?=
 =?utf-8?B?bituaTFMRXM1YSs3MXR1STA2WHhWdzAzNVJxa09sUU0zL0s0dHdrbStUc015?=
 =?utf-8?B?OC9VNS9UbEtFWWNBMW1LazJnSjhTb3NsdjJjU3JXd1RuUVFZb1ZUd0daR0Nn?=
 =?utf-8?B?L2wxanFvOEJqcU95TW1QVmJqa2FEYldDMlNVYUZaemFZOU1HaG5Dckg5bzNu?=
 =?utf-8?B?ek04eVFPNFU0TXRERFhsU0ppU2gzWm82SGVMSVRoZGVHelFLeW5LSXc3ZGxv?=
 =?utf-8?B?SWVGNUxWc1lkZlg5ZTFDQWNWZG9SQnVRSW53ZDV1NUxlZGNnTG1KSFI4cmVT?=
 =?utf-8?B?bmpiWE82Y3YxZ1FndXpOVnV1Yk9haVFjRHcycnpXd1lJck9vN1J0M0pwY2Rs?=
 =?utf-8?B?UXJNaVlIYnh3Uko2RnNCYjdEd2JOTitqWjJDUjQydENKOGNTQ1Fvb283dFJw?=
 =?utf-8?B?ZXVIQ0NUSElJWTJRdUlJSzlBNldweDFpaHBERXp4UVl6S0x1RjlYd2lqTkM1?=
 =?utf-8?B?azZEN1RiU0RYMUYyYmJ4ZnR3U3Y5cmlIN1RCYXE3R3BIQ2gxTlBtNEJ6WXNy?=
 =?utf-8?B?S0t2ZGhOWWJuUUl6K2pZckozK1gwb3JNWnR6cDc2dWo4ZjdGN0VtUUd4dUFM?=
 =?utf-8?B?U0NQUlYwczU5L1J1ZE9QdTZoK09US0tBR0YrUHRsdVVuRE81QlorS1dvblZo?=
 =?utf-8?B?d09FUC9vY3R1VVVSaVlpeWM3SEtUODNjbmpTQ3dkb3FRZkJzVG5kYlM4MGRn?=
 =?utf-8?B?b2NNZDViSkJlWHBBTTJnQmppSFN2aXZSZHVyUm1qYnFWL1JFN3hsNUh6bTlT?=
 =?utf-8?B?dFh4RHhqWmF4aVExWDNhZ0EzNmtWRjEzZFJwY01yZFRCa1QxOUp1bmk1MGd2?=
 =?utf-8?B?ei9FZUczYWNub0Z1elF5eS9KNVhmSUlWSnZYMzFwU0VON2VPTEhuUUsrRHUv?=
 =?utf-8?B?UWRzeFE2VEhjcWFJMlBENTRuQzFmUzRxQVl2TGVjVFhhY3dTN3U4WTh3dXFJ?=
 =?utf-8?B?MGpLVXlVcmhwdTU3V0FldHFhYUtVZzM3K2FacVBBaXcwcjlHaGhjVUJrYm54?=
 =?utf-8?B?STgxWFBPNmlMTitWY251NjRQVklRa28rWFRYeHpBTlRtbFRORnlnN3hTUkJw?=
 =?utf-8?B?ZEhyRjJPZDVoTEhweEI1ZXo1RHIrSHdUVUZhT1JOdDR0Si9HRTdQblF2ZDdm?=
 =?utf-8?B?OFhzRFZGYjRsbHc5SHpoT2VKVXZmak1DaDJGOEtTS0NLYkVFdTBOWUxHOE43?=
 =?utf-8?B?QlhzekMxVXFBdTFhV0FtWFh0eUh0cDFSb2Q1aXpDYXdNSEhYYkI1dFgzZEJk?=
 =?utf-8?B?cjZMb0N4R2UzR2hQQVJNdU9TNUxUbU9haE1wbVBHT0pYMWZaazVqMHVhNnMv?=
 =?utf-8?B?dnlHcFg3MnVadXZwclFzeHhUSGZHVUFLeEM4aGxGb3l0aExIcXRXQkl6SmNX?=
 =?utf-8?B?RnVVZTFnaFlTVjlFQlpDajhoZlM4aVpYWC9mVDExTmZ1eFBvMmtVTGc1ejFm?=
 =?utf-8?B?N2V0L28xaFlLQnFGMlVQSGZOWi9kK2loR2d3RGNrb3dhQTlYLzZMaU5scmIy?=
 =?utf-8?B?aXlaREJ4cUR0UmFjUHJNcGJPQVBLbFM1YW91NUR4UkwwUkJxaFFBd0pON1dO?=
 =?utf-8?B?UGdORjlmS3ByTytTYkczalBmNnFUZGl6TGhzaXBzTGFlR0drbXpjM0U2ZTNT?=
 =?utf-8?B?NUZHVHlRMnRyS3hVemVLOW9oa0dsODd0VU10eXd0OWJIdGlOdG1GbGUxd2Mz?=
 =?utf-8?B?N3NMbGZsTDYzVGpJS09jZkxQaWRaWmZOTkNicXc5TzJtYnlRSTQxMXp2UXVD?=
 =?utf-8?B?VHlUYm5QdVBicTZ4TGtrbUV4TnN3djNGY2w2cUZra0paTHdZQ2tHbzlEYUUx?=
 =?utf-8?B?b1g2UEdLZXJEZnhkcXlKOEQrVkZUc2RHVElXMCtDT0srZFJ2TzBaL0Vtc0gr?=
 =?utf-8?B?NTEreGFkaTV2YXJJQU5QTHZOT1hKSCtOdmVyVlJNbk93N0MrRjEzVE5QRk1v?=
 =?utf-8?B?TnNkSllocDRJbUVlNFVDTmZUOWRvbG52VUdta1BLeTNxdzluUHJySEcvQkd3?=
 =?utf-8?B?aU8wdGlpN0FYT2RpdXE2TUhFZWswQW43clBMNjJDRFoya2YxcVNWTFEydE14?=
 =?utf-8?B?cUNQZjFjZy9LYXFLMHhMK3NIRW8xNmNKdVVxcVM5dTZrTlV2QTR1VWtxVTNz?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9OI2R8aBcK62ExNItk42PaHef7dB7e/O7PuFgBheC9jc0XRWLEMo0BsPK+BqLv44olvoND2gj7MWrTjdnCgalNRD7cELopnYDOSbjwvfF3ZfGa9roOLCitB/sGxKcgb/xmB7dJ0/C6I4N8S1XDU1mirLHQ/y7dmlPjAzRsuVLblMhRIzpE34LKuIfjCFS/zTnNANObMJid0Q6HlSIFkDqGf+gioJ3+svbNpWu++UQFc7A173ZqsJJ3VST+GH10amGyoylZGU0LarIrU47NZWaJm+2rwgVRtS++T5Q1Ph2axQX3QyhUTRj6JoFjxZl5+J6kYnVutkjgwurUybJfLLEIJuwpBZ37kAjfqWIEXXpmxSA0u04ERgHM5LJbd/MjUBFezP44ZswpIFSEw/GVy2kbTBMfS8I5QJgUM7inBg4YcWRQp7UY993jxLWy1XTFIRc9ZqtWLXFuWT66sH4A0q7wGqUrxYydfnZ/O5jc0JlC/NNBCh1Pvy1nE7qJf6FYT8QR4jmo2QHdWlqrXOmc+STjRDsn1FpjE2nlQpPI9tI2IugbDSQSYHLq/Zg8zD1SO/6K3OvTBIc1axzrnYSVavHcO8G/tcgP6b1mkYFdLf0tP+3spneYzykXCdIaJFXbDl9nCRMyUrSoVsi4UU4yMWkzmvfQw7li5DLUSuVuiwyxLYdAy0Y2ZxOCYnTH25eXB4I25m1YEPdl7+EiQqtiFeguf7ORjVko9+X38BRPOk+dHNry1Agzh7Wa4Pyf75DjAA1lkvKrPZjIQBir2jCg6bwEun0hO3xXJeC5OS8FdSqXrO9HpkTygMTOgG+61esL0S
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5549.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a248042-80a1-4462-73e2-08dba3b43d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 08:37:52.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnNb59psS0TZW8T7yRyWgyy/arx318ScGEoNBhiCGRrzvY5jWlRKtnYvgHjZ1yVxLW8zt0n+hzvHzpofyHoKvAAeeN+QjyqrovbmnVvJZT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6109
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 08:38:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12833

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYN
Cj4gT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMTcsIDIwMjMgNzo1MiBQTQ0KPiBUbzogcHlsYSB2ZW5rYXRhKO+8tO+8s++8
qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPFZlbmthdGEuUHlsYUB0b3NoaWJhLQ0KPiB0c2lwLmNv
bT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBkaW5lc2gga3VtYXIo77y0
77yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+IHRz
aXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnv
vKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpDQo+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJh
LmNvLmpwPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlXSBzY3JpcHRz
LyovZWZpYm9vdGd1YXJkLSoucHk6IE1ha2UgRkFUDQo+IGZpbGUgc3lzdGVtIGltYWdlIGNyZWF0
ZSByZXByb2R1Y2libHkNCj4gDQo+IE9uIDE3LjA4LjIzIDE2OjEyLCB2ZW5rYXRhLnB5bGFAdG9z
aGliYS10c2lwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiB2ZW5rYXRhIHB5bGEgPHZlbmthdGEucHls
YUB0b3NoaWJhLXRzaXAuY29tPg0KPiA+DQo+ID4gVGhlIEVGSSBhbmQgQk9PVCBmaWxlIHN5c3Rl
bSBpbWFnZXMgYXJlIGNyZWF0ZWQgbm9uLXJlcHJvZHVjaWJseQ0KPiA+IGJlY2F1c2Ugd2hlbiBg
bWtkb3Nmc2AgY3JlYXRlIEZBVCBmaWxlIHN5c3RlbSBpdCB1c2VzIHJhbmRvbSB2YWx1ZXMNCj4g
PiBmb3Igdm9sdW1lLWlkIGFuZCBjcmVhdGlvbiB0aW1lLCB0aGlzIGNhbiBiZSBmaXhlZCBieSBw
YXNzaW5nDQo+ID4gYWRkaXRpb25hbCBvcHRpb24gYC0taW52YXJpYW50YCB0byBgbWtkb3Nmc2Ag
dGhhdCB1c2VzIGZpeGVkIHZvbHVtZS1pZCBhbmQNCj4gY3JlYXRpb24gdGltZS4NCj4gPg0KPiA+
IEZpeGVzOiAjNzMNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVua2F0
YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4gLS0tDQo+ID4gIHNjcmlwdHMvbGliL3dpYy9w
bHVnaW5zL3NvdXJjZS9lZmlib290Z3VhcmQtYm9vdC5weSB8IDIgKy0NCj4gPiBzY3JpcHRzL2xp
Yi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWVmaS5weSAgfCAyICstDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL3NjcmlwdHMvbGliL3dpYy9wbHVnaW5zL3NvdXJjZS9lZmlib290Z3VhcmQt
Ym9vdC5weQ0KPiA+IGIvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFy
ZC1ib290LnB5DQo+ID4gaW5kZXggNzQzNWIyMi4uNDkwYjE5YSAxMDA2NDQNCj4gPiAtLS0gYS9z
Y3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkNCj4gPiAr
KysgYi9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkN
Cj4gPiBAQCAtMTYwLDcgKzE2MCw3IEBAIGNsYXNzIEVmaWJvb3RndWFyZEJvb3RQbHVnaW4oU291
cmNlUGx1Z2luKToNCj4gPiAgICAgICAgICAjIGRvc2ZzIGltYWdlLCBjcmVhdGVkIGJ5IG1rZG9z
ZnMNCj4gPiAgICAgICAgICBib290aW1nID0gIiVzLyVzLiVzLmltZyIgJSAoY3Jfd29ya2Rpciwg
cGFydC5sYWJlbCwNCj4gPiBwYXJ0LmxpbmVubykNCj4gPg0KPiA+IC0gICAgICAgIGRvc2ZzX2Nt
ZCA9ICJta2Rvc2ZzIC1GIDE2IC1TIDUxMiAtbiAlcyAtQyAlcyAlZCIgJSBcDQo+ID4gKyAgICAg
ICAgZG9zZnNfY21kID0gIm1rZG9zZnMgLUYgMTYgLVMgNTEyIC1uICVzIC1DICVzICVkIC0taW52
YXJpYW50Ig0KPiA+ICsgJSBcDQo+IA0KPiBXaGF0IGRvZXMgT0Uvd2ljIGRvIGZvciBjcmVhdGlu
ZyBkb3NmcyBmaWxlc3lzdGVtcyBpbiByZXByb2R1Y2liaWxpdHkgbW9kZT8gSQ0KPiBkbyBub3Qg
ZmluZCAtLWludmFyaWFudCBpbiB0aGVpciBjb2RlIGJhc2UuDQoNClNvcnJ5IGZvciB0aGUgZGVs
YXkgaW4gcmVzcG9uZGluZywgSSBhbSB1bmRlcnN0YW5kaW5nIGhvdyBPRSBpcyBpbXBsZW1lbnRp
bmcgdGhlIHJlcHJvZHVjaWJsZSBpbWFnZXMgZm9yIGRvc2ZzIGltYWdlcywgT0UgcGFzc2VzIGV4
cGxpY2l0bHkgdGhlIHZvbHVtZS1JRCB0byBta2Rvc2ZzIGFuZCBTT1VSQ0VfREFURV9FUE9DSCBm
b3IgY3JlYXRpbmcgcmVwcm9kdWNpYmxlIHZmYXQgaW1hZ2VzLCBidXQgd2l0aCB0aGUgIi0taW52
YXJpYW50IiBvcHRpb24gaW4gbWtkb3NmcyAodXNlZCBpbiB0aGlzIHBhdGNoKSB3aWxsIGludGVy
bmFsbHkgdXNlIGNvbnN0YW50IHZhbHVlcyBmb3Igdm9sdW1lLWlkIGFuZCB0aW1lIHN0YW1wIGFu
ZCBjcmVhdGVzIHJlcHJvZHVjaWJsZSBpbWFnZXMuDQoNCkVhcmxpZXIgb25lIGlzIGJldHRlciBh
cHByb2FjaCBiZWNhdXNlIHVzZXIgY2FuIHBhc3MgdGhlIGNvbnN0YW50IHZhbHVlcyBpbnN0ZWFk
IHRoZSB0b29sIGZpeGVzIHRoZW0uDQoNCkkgd2lsbCByZXNlbmQgdjIgZm9yIHRoaXMuDQoNCj4g
DQo+IEphbg0KPiANCj4gPiAgICAgICAgICAgICAgKHBhcnQubGFiZWwudXBwZXIoKSwgYm9vdGlt
ZywgYmxvY2tzKQ0KPiA+ICAgICAgICAgIGV4ZWNfY21kKGRvc2ZzX2NtZCkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWVm
aS5weQ0KPiA+IGIvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1l
ZmkucHkNCj4gPiBpbmRleCBkNmNkZjBmLi4yYzY5NjA5IDEwMDY0NA0KPiA+IC0tLSBhL3Njcmlw
dHMvbGliL3dpYy9wbHVnaW5zL3NvdXJjZS9lZmlib290Z3VhcmQtZWZpLnB5DQo+ID4gKysrIGIv
c2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1lZmkucHkNCj4gPiBA
QCAtMTA1LDcgKzEwNSw3IEBAIGNsYXNzIEVmaWJvb3RndWFyZEVGSVBsdWdpbihTb3VyY2VQbHVn
aW4pOg0KPiA+ICAgICAgICAgICMgZG9zZnMgaW1hZ2UsIGNyZWF0ZWQgYnkgbWtkb3Nmcw0KPiA+
ICAgICAgICAgIGVmaV9wYXJ0X2ltYWdlID0gIiVzLyVzLiVzLmltZyIgJSAoY3Jfd29ya2Rpciwg
cGFydC5sYWJlbCwNCj4gPiBwYXJ0LmxpbmVubykNCj4gPg0KPiA+IC0gICAgICAgIGRvc2ZzX2Nt
ZCA9ICJta2Rvc2ZzIC1TIDUxMiAtbiAlcyAtQyAlcyAlZCIgJSBcDQo+ID4gKyAgICAgICAgZG9z
ZnNfY21kID0gIm1rZG9zZnMgLVMgNTEyIC1uICVzIC1DICVzICVkIC0taW52YXJpYW50IiAlIFwN
Cj4gPiAgICAgICAgICAgICAgKHBhcnQubGFiZWwudXBwZXIoKSwgZWZpX3BhcnRfaW1hZ2UsIGJs
b2NrcykNCj4gPiAgICAgICAgICBleGVjX2NtZChkb3Nmc19jbWQpDQo+ID4NCj4gDQo+IC0tDQo+
IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENlbnRlcg0KDQo=


