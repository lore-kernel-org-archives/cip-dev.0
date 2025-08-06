Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE0C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 10:42:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.22312.1754476912105219486
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 03:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 576Afnki392117; Wed, 6 Aug 2025 19:41:49 +0900
X-Iguazu-Qid: 2rWh5b6vJTuyPuQ3E0
X-Iguazu-QSIG: v=2; s=0; t=1754476909; q=2rWh5b6vJTuyPuQ3E0; m=YPIP7n9MZzfq90otJK2T8JGsUt9M9NrBCWcS+PQtghY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 576AflBK2792735
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 19:41:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB3dxVHcUAS14j9sAEQ3dAtZokAcI0CrmnnIvNBAOOv3P3tSU+maakJSKu6xVCD6yXoKgqHqwpzzSxxcPyBZ3HV3Hwgncetue28Un+rQdw85dCu6aQ7fhfWB9+B1cywrXEuE5NCecvi1l9li6g+wV3kvB7l2oLNDrHTxn1O926SEdC9BIZ4kG0w39R5d3NfBRD/SPAzb1BZHQztwYp7uCt16Z/ezea0DBGJ09hn1TMIkJDL+IehnLj5IDQvcFG0Vb4jL7JKHnfB3MIqOTHw049oCAtrTUxYkcvir/oFlPrJp9VaeUghtvtBqDDeNHvNu2s/KsgvoJ9h88XJCtcOdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmLVmuCcPYhp7oBOy+4CQ0zSvk8/ouekNsXJgNQFCmg=;
 b=yLAf+JhgxQ+0I8SBPIqJyS59oPWdUyuaLXWwdD2Rgn2QZ7EXivIzTjXL2E//i0c5GL/pT4h14w4JwQ6Nc+BE9nGW6atNaBGTLwVkjiUvxsg5Tku17LJJ/6oHZKpABG++O2UQBRWFeDKpaSetgmBJe3AsujkcgrpSK+Ygv2TBlqvBH4+hDcoApg9hp2n0MEnO2fOuxyJ2lGUr0Hlm+MFhXI9q6xQ9E1/ksnSdn6HcA1bjRRpNF3DexGR/3uuJh9YRa3Ayl/xW3eR2nZwomRm+kqCIH5gfcdbIkdNmzO5LnSZsWG4s2SgJ1pmXWYRxdJv/2lbYT6zbPsv16gbkuyPtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Adithya.Balakumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remove
 the credentials from console & document them
Thread-Topic: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remove
 the credentials from console & document them
Thread-Index: AQHbuyKPR5GGPQhBmkSQO9iot55vJ7O+78cAgJPA+/qAAAA9QIAC5vIAgABtGrA=
Date: Wed, 6 Aug 2025 10:41:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107507C9567147863B7EBB17C72DA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
 <29c1beeb-3f3e-4bb2-89b5-a84d2b0b5043@siemens.com>
 <TYCPR01MB9669DF71C777AFA3B394F007C423A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075B09AA1BFCDF5DACB3519C723A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <45d4c4e8-322c-4b01-9385-219333638981@siemens.com>
In-Reply-To: <45d4c4e8-322c-4b01-9385-219333638981@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS7PR01MB14446:EE_
x-ms-office365-filtering-correlation-id: 65ee5b6e-f854-44da-70b2-08ddd4d5d71a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MnRwZTVQTVNmcHllOEFoTysvZG9lVmJnRlJRMVFkaFpraTRmU1QrR1lWMGQ5?=
 =?utf-8?B?OWloRVZxZzBJYVhPOGtwWmhRc3pmeEtoT2lqZ1hVZldvLzlKdXdSZXJrTzFH?=
 =?utf-8?B?NC9BYkNMSXJXN0QxQ1FneENRbTN4TG53Sk1Rc3hnSklvLzhCMkNjVHNjWElJ?=
 =?utf-8?B?MkxhTUlUTFphb1JyQmJsRlJPZUNKT0lrVTRNODNuUW1IZzN2WnF0OFk0ckVV?=
 =?utf-8?B?bWVUQUJFbHd3K1Y4V21PdlhaNlExV3h4L2R2Vld4SEw0a2Y3eDBVZ0xtaTZ1?=
 =?utf-8?B?UERZbXI1bkxsbTF0bEFPZytYeU4wK1ZVbkFNK3J1NnJUVFg1Tkh4L1hmR0tt?=
 =?utf-8?B?OHRicFhjZFZOQ1VFVHNXL3RxSlNrWFlDNFJqaWZON2lCUS9mN0YwYWJNSjYv?=
 =?utf-8?B?cGxmZHVSbnhya2p1Y3NQM1FNTFZsdy8zYzhpVzllVzNHd1VuL2pTKzZpWC9I?=
 =?utf-8?B?Y1Vjdmw4SXRXT01TWUIxUGxzTVJxaGtrSW1aSTQvSVEyaHlzTGxBdFYyeTFW?=
 =?utf-8?B?Qjg0eW56WFlvRWlHNFdwOFBMUkY2TCtPYmkycmsxK3VGcFJ5Z3FrSzZqMmNC?=
 =?utf-8?B?T1pWenFiUjlPVTJHakJvdjI0b3MxV0dCMlVwNXJkUDRTY1hjeVFtY2xEUnYv?=
 =?utf-8?B?WlRrNjhCZkppb3NZN3F5VENqL3NGM1orenhyTDJZZjJ4V2NRdHc4ZDg1QWxB?=
 =?utf-8?B?eGdHSE43NG1MakJqc0x5VnpwZEs1andhM2lwTmNyZXp0Y1dZRGhQaWIxWXlv?=
 =?utf-8?B?WEdaYUhPWW5FN0lQS2lvakRPMTNSeCt5YlV6c2ttR0xuSFBONXRaSklITVkv?=
 =?utf-8?B?U0FBaS82a21kVkcwZVVqRFRicGV2dVhyRnFTQVBaWDdqWVBIN09hYXg1NkMy?=
 =?utf-8?B?UlREWk10bFcyb0ZZK3lIc2t2WndUTkFQZWFUbmxvbEJwNkV2RlRLS1VXWGNJ?=
 =?utf-8?B?WUxjQ1Q5dlJYOTY4cnZvTk9DMGpyRlNtcVU5M1EzMFV0VHNQeFlKWmxtejFy?=
 =?utf-8?B?WUcrUmo3OGovajFqWVVoMmU5OGhaOUFRdHpyTG44aG5BSWZrMEVYaUNhNUln?=
 =?utf-8?B?bVA1OGp4enRmVVQ1RTlvczZaK1V0S3FpUnRzeGtvYUl4Wmg1eUhTT0Q4Zlll?=
 =?utf-8?B?em5zOXFLdHY5ZktKQlpVN0plU29ORGNreldwUFY0eFdwODFYbFEwbDNyNit4?=
 =?utf-8?B?azUyVWJsZ1pVbTc4VVJTTkF0Z1hoY1VhS0dnSTBUVFZXbU8rOC9tcjdtTy9L?=
 =?utf-8?B?bit5d0ZFczNmUGpIWDgvalpqVStNQlF5ajRLeW9zUTFPelNlRkJUb0dycnVP?=
 =?utf-8?B?L1NiUmVtVlVZNDZWbWlmNklHd05wMFdtQkFZYktWZzloUHYxVk5vVEdHUFNk?=
 =?utf-8?B?U05rQjEyNkc2N0FWVFozRFpVd0h6T0owMkJaYk9CQmZSQ2wyZExvMFR6UUsv?=
 =?utf-8?B?czE2VXZMczcyczUvTkxDK29leFVOdlZPbGQxMHJRdENIMm9Db3h4QWJ3NkpB?=
 =?utf-8?B?ZHhEUE9nbDNvM3hGcjRsTFowVlk4YVk2b2pjZHZIYTJhdlRLUGFiK09vNjVN?=
 =?utf-8?B?UGNNSkFqQ3EydXZwcTZpNTRBMjl4ZVdCSmIvT0Uzd1ViMW1PWHJFNktiYW5w?=
 =?utf-8?B?UzBZUlBDYTRxM3YwYXIzaW5ucXdqU2p1SFg4SWNna0hETmJHbzJFZHlaWUdq?=
 =?utf-8?B?ZE53YUJ0bkREZHRhb1BoM3JBNHJCUEkxclk2RTJ0Uy9XLzNOaXRIWVlRT1l2?=
 =?utf-8?B?Yk41V2puUERpM3Z0QlFLWHpqK3pXOHcwZmx0TVoxRFhjRDBkK2h5aXd3azJt?=
 =?utf-8?B?c0NHRU1Da2VhZ2tWRUJaZlFmM0FJV2JkcUFOdVY4TVpHUFpQbnNZTTFBZmhn?=
 =?utf-8?B?L0g2ZDhzTFF2UWtYUmpvU0Y1OHYra2RRSkN0MHYvdDVqWTNJaU5ESjlDMVhJ?=
 =?utf-8?B?dmtldDZYYVhNMVp1YlpDT2ZETVVxVjFpYTZpTUdkWTZSQ2p4UGw0OHlZNGNP?=
 =?utf-8?Q?elldRbHBy48ajY2+klHzx03Bnz3/XI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MjZ1RGNjU2NDUGlsNlRnRFRtQlBzdGw0RWQwOTUvb1drNEpUVDdHUlp0b1VQ?=
 =?utf-8?B?Q0x5WC9MSXpwN1UxVWYxbHRXRnpXTU9Gd3lwazZhbHVUcHJmdWpzN2xydDNC?=
 =?utf-8?B?ZHRvd3RjMHVkZlhSWk1UQWlabWZVK21BbXkzVmdmWllPSS9nYkVPdnc4UWVx?=
 =?utf-8?B?eHhWV05vdm5RZ1FoeG4wRTg5VzVycXRVQnorWVFKQTduZXBGaXVkWm91YXEx?=
 =?utf-8?B?dlo2bUZoUEE3cnFJNTliVzhJalBZb2RtMS9XcWhHeWlUd0VEYXRaSzZjOXFW?=
 =?utf-8?B?eW5FNWJ5R1h0M3EzeEwwTVVqUllQOW9wOWlrRHhlRWxwbk9UU1kxdy9NNU1G?=
 =?utf-8?B?S1ltdzNUdFR6MlJpWE1UYWJsRDRzSHpVa1VFbzNMN0NOVmV4c2kwTGpUeHRx?=
 =?utf-8?B?cmZ3b2ZwZDVyR2hDZndsTE14QUVObktIOVMwUlR0LytwV2JNZFhsZ1BZZElU?=
 =?utf-8?B?MTljbkpiT0I2eWkrZXpoUjRyK2ZDYUpFU1ZPQ1hkSGRGdVBoY1hBcDZqSFVj?=
 =?utf-8?B?YnlkWjFBcWtPRkg1U0MzZ3NuZDFSMlNBQ0hrcnIrbnIwY3Yxc1NOa0dvZ1Z6?=
 =?utf-8?B?VE00amVOSkNWYzdaN0wvVHc4V3huRmRYU2ZCcEd6Y2Y3L1ZpNnZTQVFrcEcv?=
 =?utf-8?B?enRDSTI5aW5idFUxUVowZ0xuNHZvR2RvTlFkcG5vZW9lbVFnYjRIUHR0WWhJ?=
 =?utf-8?B?V1lETHROeCtPTEFQNGxScTF2Vzc4dWpISkR5bUh2S29TdkFNZys0ZVl6M3NG?=
 =?utf-8?B?b2dJNzZpdHZwVEU5WWV1V3JGVHZRQjlDbjdLbXBILyt4V0pxTkw2bXFsd1d5?=
 =?utf-8?B?YjlRM2gyVnUvNTJ3dDRFcnYvUFdWaTZNWC9ac2xrbS9WQlozaUJEWm42aC80?=
 =?utf-8?B?dkkySXhCRnlwVzRJZmFJbjh6VU1BTWNhUzlGbE5CM05lR3pzdzRjdFlFSjNy?=
 =?utf-8?B?SXA5SmFKNVBPeEtoSEVKVUxObnNNQ09MUzFpd3huQWNOQjRkV1VoYVNQd1NH?=
 =?utf-8?B?RjgyM2doMldJQjJldHBtNXNHY1lXSzJYaXJiVE9BbjlYUWtSMElSWnhISnhM?=
 =?utf-8?B?RlhUWUNYU1RlWWozZFROT0VuWDExMEk3cFByTTJBblpoM1JCVUdyYWVKejdk?=
 =?utf-8?B?bG5xV1VGcnBBZ1lQdnlCVC9idXgyZ0lTYlFYbzZjdzV3UDNJdmhJd2NjdWZN?=
 =?utf-8?B?S1VOZ2l6NldCci9ncEhRdjl0anUyYjdZSFJBc1UvNndCTjFibURFdlpkUENX?=
 =?utf-8?B?cXh1dDBZdjltd3ZFbG41Rkw4aFpjWmZNdVVEUW9pR3FXSGg5ZlZFWkpkYjZG?=
 =?utf-8?B?eGcvRXlIbjNQZ0xnWDgzU09qNi8zcTB6YWQwcVI2bExTN1BmZ051Tk5Uc0FZ?=
 =?utf-8?B?Z3lWK3ZjaGRNeDFTMlk5QWNpMndSMmtMVFhYaUtXRlROYXdzS25oM1F5OUhS?=
 =?utf-8?B?aUp0a3h2V09qNmF3cW9weVk3RWFIV0FpdDVUdm5JQjl3eUhtS3ovY0QxUEpt?=
 =?utf-8?B?clRNM0lHZHBXWjUzRkxVWHd4N0lZRjRMTWlHeHQ2RTYva2ErMnd6RjM3NmMy?=
 =?utf-8?B?SFU5Q3JEcDVReC9ZT242RU1tNVloUklGbUFDUEp2U2wzUmw1bkI1UW9Ndkgw?=
 =?utf-8?B?K1FmUnZKajNDL3U3QVZQU0V5c1QrY0lHRjcwby9NaUFhYkNLQjVSTEJNcUdn?=
 =?utf-8?B?dXdqdStCdzhJbFJRc1VlU1lXL2JkQzRzd2tBSFBBVEx5RllMRlhIWHZMejkv?=
 =?utf-8?B?NitNZ1hqdHZnSjRhS096NHYzNzVUY1BUcGpMNlNTY0lkVXdtTG9PNERsMnNq?=
 =?utf-8?B?YStNY2JSSnZuTXVJQkwrdE0yTno3azBPVGJIZ09UOWJwMDduelBMUVNPZTM0?=
 =?utf-8?B?K2FaOUFhOVoySmhGRTBlbDNKMzVDSE1CYmRPSGRNdG8yaE1INnBGRzFpa0E1?=
 =?utf-8?B?RHhFTnBJVU1jSXFUNUloa3pXck1BeW5NbXZMQS80aXBkTzVoUFpvbVA3OVBM?=
 =?utf-8?B?T3VwZ3U5RTQ4bStic2xKVldjL0l1RWp3V3BDK25wbm9tdnZKcUZacGxXU2Vp?=
 =?utf-8?B?T24zNmt2VWpvaW85ajQxa1pwM0FxK1Z5dXEyVjliRTJzUFNpSzFtN0laZmpX?=
 =?utf-8?B?QUNCTEZJcVpPNnp6TGJBVGJQYWxuL0dhSEhjUGdUZXV5L2ZOajAzakFMd21W?=
 =?utf-8?Q?92AVpke5P2Ev+s6G7i18w+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ee5b6e-f854-44da-70b2-08ddd4d5d71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 10:41:45.7839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/s599WHVdu4iUv5P2fM08YU+ZPdVMraxtxSS1HeEDbBv+w6frWfCo7LnJz1HBbG58sP5dL4lrcPo5m6O7zB9Y2XDoZ7Oak8IT89f+juRkZRFGnw4F0R0D9Ok6VDZWxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 10:42:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19694

SGkgSmFuLCANCg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuDQoNCj4gSGF2aW5nIHRoZSBzdGF0ZW1l
bnQgdGhhdCBkZWZhdWx0IGNyZWRlbnRpYWxzIG11c3Qgbm90IGJlIHVzZWQgZm9yIHByb2R1Y3Rp
b24gcmVtYWlucyB2YWxpZC4gVGhhdCBzdGF0ZW1lbnQgc2hvdWxkIGFsc28gYmUgYWRkZWQgdG8g
a2FzL29wdC9zZWN1cml0eS55bWwgd2hlcmUgd2UgaW5qZWN0IHRoZW0uIFRoYXQgZmlsZSwgYXMg
aXQgaXMsIE1VU1QgTk9UIGJlIHVzZWQgZm9yIHByb2R1Y3Rpb24uDQo+IFBsZWFzZSBhZGp1c3Qg
dGhlIHJlYWRtZSBjaGFuZ2VzIGFzIGRpc2N1c3NlZCBhYm92ZSBhbmQsIHdoaWxlIGF0IGl0LCBk
b2N1bWVudCB3aGVyZSB0aGUgY3JlZGVudGlhbCBhcmUgaW5qZWN0ZWQgYW5kIHdoYXQgc2hvdWxk
IGJlIGNoYW5nZWQgb3Igd2hhdCBzaG91bGQgYmUgYXZvaWRlZCBmb3IgcHJvZHVjdGlvbiB1c2Ug
L3dydCBjcmVkZW50aWFscy4gVGhlbiB3ZSBib3RoIGZ1bGZpbGwgdGhlIGZvcm1hbCBjZXJ0aWZp
Y2F0aW9uIG5lZWRzIGFuZCBldmVuIGFkZCByZWFsIHNlY3VyaXR5IGF0IHRoZSBzYW1lIHRpbWUu
DQoNClVuZGVyc3Rvb2QsIHRoZSBpbmZvcm1hdGlvbiBhYm91dCBjcmVkZW50aWFscyBhcmUgcHJl
c2VudCBpbiBrYXMvb3B0L3NlY3VyaXR5LnltbCBmaWxlIG5vdy4gd2UgY2FuIGFkZCBhIHNpbWls
YXIgY29tbWVudCBpbiB0aGlzIGZpbGUgYXMgd2VsbC4gDQpBcyB5b3Ugc3VnZ2VzdGVkIHdlIGNh
biBhbHNvIGRvY3VtZW50IHRoZSBhYm92ZSBpbmZvcm1hdGlvbiBpbiBSRUFETUUgZmlsZSBzbywg
SSB3aWxsIHBsYW4gdG8gc2VuZCB2MiBwYXRjaCBmb3IgdGhlc2UgY2hhbmdlcy4gDQoNClRoYW5r
cyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IDA2IEF1Z3Vz
dCAyMDI1IDA5OjM0DQpUbzoga3VuaWphZGFyIHNoaXZhbmFuZCjvvLTvvLPvvKnvvLAgRElUQ19E
SVQtT1NUKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIERJVENf
RElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGly
byjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPGthenVoaXJvMy5oYXlh
c2hpQHRvc2hpYmEuY28uanA+OyBiYWxha3VtYXIgYWRpdGh5YSjvvLTvvLPvvKnvvLAg77yk77yp
77y077yj77y/77yk77yp77y0Le+8r++8s++8tCkgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEt
dHNpcC5jb20+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIHYxXSBSRUFE
TUUuc2VjdXJpdHktdGVzdGluZy5tZDogUmVtb3ZlIHRoZSBjcmVkZW50aWFscyBmcm9tIGNvbnNv
bGUgJiBkb2N1bWVudCB0aGVtDQoNCk9uIDA0LjA4LjI1IDE1OjA4LCBTaGl2YW5hbmQuS3VuaWph
ZGFyQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+IEhpIEphbiwNCj4gDQo+IFRoaXMgaXMgYW4g
b2xkIHBhdGNoIGFuZCB3b3VsZCBsaWtlIHRvIGdldCBzb21lIGNvbmNsdXNpb24gb24gdGhpcy4N
Cj4gQmFzZWQgb24gdGhlIGNvbmNsdXNpb24sIEkgd2lsbCBwbGFuIHRvIHNlbmQgdjIgcGF0Y2gg
aWYgcmVxdWlyZWQuDQo+IA0KPj4+ICtJRUMgNjI0NDMtNC0yIGNlcnRpZmljYXRpb24gYm9keSBl
eHBlY3RzIHRvIHJlbW92ZSB0aGUgY3JlZGVudGlhbHMgZnJvbSBiZWluZyBkaXNwbGF5ZWQgb24g
dGhlIGNvbnNvbGUgcHJpb3IgbG9naW4gc3RhZ2UuDQo+PlRoaXMgc2VudGVuY2UgZG9lcyBub3Qg
YmVsb25nIGhlcmUuDQo+IA0KPiBPa2F5LCB3ZSBjYW4gcmVtb3ZlIGl0Lg0KPiANCj4+PiArKFdh
cm5pbmcpIENJUCB1c2VycyBhcmUgc3Ryb25nbHkgcmVjb21tZW5kZWQgbm90IHRvIHVzZSBDSVAg
ZGVmYXVsdCBjcmVkZW50aWFscyBmb3IgcHJvZHVjdGlvbiBpbWFnZXMuDQo+IA0KPj5ObywgdGhp
cyBNVVNUIG5ldmVyIGJlIHNoaXBwZWQgaW4gcHJvZHVjdGlvbiwgaXJyZXNwZWN0aXZlIG9mIGFu
eSANCj4+Zm9ybWFsIGNlcnRpZmljYXRlcy4gVGhpcyBoZXJlIGlzIGEgVEVTVCBpbWFnZSwgbm90
IGEgUFJPRFVDVElPTiBpbWFnZS4NCj4gDQo+IFdlIGNhbiByZW1vdmUgdGhpcyBzdGF0ZW1lbnQg
YXMgd2VsbC4NCj4gDQoNCkhhdmluZyB0aGUgc3RhdGVtZW50IHRoYXQgZGVmYXVsdCBjcmVkZW50
aWFscyBtdXN0IG5vdCBiZSB1c2VkIGZvciBwcm9kdWN0aW9uIHJlbWFpbnMgdmFsaWQuIFRoYXQg
c3RhdGVtZW50IHNob3VsZCBhbHNvIGJlIGFkZGVkIHRvIGthcy9vcHQvc2VjdXJpdHkueW1sIHdo
ZXJlIHdlIGluamVjdCB0aGVtLiBUaGF0IGZpbGUsIGFzIGl0IGlzLCBNVVNUIE5PVCBiZSB1c2Vk
IGZvciBwcm9kdWN0aW9uLg0KDQo+IA0KPj5Bbnl0aGluZyB0aGF0IG11c3QgYmUga2VwdCBmb3Ig
YSBwcm9kdWN0aW9uIGltYWdlIG11c3Qgbm90IGJlIA0KPj5jb250YW1pbmF0ZWQgYnkgc2V0dGlu
ZyB0aGF0IGFyZSBqdXN0IGZvciB0ZXN0aW5nIHB1cnBvc2VzLg0KPj5JbiB0aGF0IGxpZ2h0LCBo
YXZpbmcgb3VyIHRlc3QgcGFzc3dvcmQgaW5zaWRlIGEgY3VzdG9taXphdGlvbiBwYWNrYWdlIA0K
Pj50aGF0IGNvdWxkIGJlIHJldXNlIGZvciBhIHJlYWwgaW1hZ2UgaXMgYSBiYWQgdGhpbmcuDQo+
IA0KPiBBcyBwZXIgbXkgdW5kZXJzdGFuZGluZywgd2UgZG9u4oCZdCBoYXZlIHNlcGFyYXRlIHJl
Y2lwZXMgZm9yIFRFU1QgLyANCj4gUFJPRFVDVElPTiBpbWFnZXMuDQoNCkJ5IGRlZmluaXRpb24s
IGlzYXItY2lwLWNvcmUgZG9lcyBub3QgKGFuZCBjYW5ub3QpIHByb3ZpZGUgcHJvZHVjdGlvbiBp
bWFnZXMuIEl0IGlzIGp1c3QgdGhlIHRvb2xib3ggdG8gYnVpbGQgc3VjaCBpbWFnZXMgZnJvbS4N
Cg0KPiANCj4gQ29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nIGhlcmUgYW5k
IGFsc28gSSBiZWxpZXZlIA0KPiBtaW5pbWFsIGNoYW5nZXMgcmVxdWlyZWQgZm9yIFBST0RVQ1RJ
T04gaW1hZ2VzIGJhc2VkIG9uIHRoZSBjdXJyZW50IA0KPiBpc2FyLWNpcC0gY29yZSByZWNpcGVz
Lg0KPiANCg0KSG93IG1pbmltYWwgY2hhbmdlcyBhcmUgZGVwZW5kcyBvbiB0aGUgYWN0dWFsIHBy
b2R1Y3QuIEJ1dCBpdCBkb2VzIG5vdCBtYXR0ZXIgaWYgdGhvc2UgY2hhbmdlcyBhcmUganVzdCBm
bGlwcGluZyBhIHZhcmlhYmxlIHZhbHVlIG9yIHJlcGxhY2luZyBtdWx0aXBsZSByZWNpcGVzLCBh
ZGRpbmcgb3RoZXJzLiBUaGUgcG9pbnQgaXMgdGhhdCB3ZSBhcmUgbm90IHByb2R1Y2luZyBpbWFn
ZXMgdGhhdCBhcmUgMToxIHVzYWJsZSBmb3IgYWN0dWFsIHByb2R1Y3RzLg0KDQo+IA0KPiBJbiB0
aGF0IGNhc2UsIHRoZSBjdXJyZW50IHBhdGNoIHdoaWNoIHJlbW92ZXMgY3JlZGVudGlhbHMgZnJv
bSBjb25zb2xlDQo+ICgvZXRjL2lzc3VlKSB3b3JrcyBmb3IgYm90aCBURVNUIC9QUk9EVUNUSU9O
IChpZiBwcm9kdWN0aW9uIGltYWdlIHVzZXMgDQo+IHRoZSBjdXJyZW50IHJlY2lwZXMgYXMgYmFz
ZS9yZWZlcmVuY2UpIGltYWdlcy4NCj4gVGhlIENJUCB1c2VycyBzaG91bGQgcmVmZXIgUkVBRE1F
IGZvciB0aGUgbG9naW4gY3JlZGVudGlhbCBkZXRhaWxzIGZvciANCj4gVEVTVCBpbWFnZXMuDQo+
IA0KPiBBcyBvZiBub3csIHRoZXJlIGlzIG5vIGJsb2NrZXIgZnJvbSB0aGlzIHBhdGNoLg0KPiAN
Cg0KUGxlYXNlIGFkanVzdCB0aGUgcmVhZG1lIGNoYW5nZXMgYXMgZGlzY3Vzc2VkIGFib3ZlIGFu
ZCwgd2hpbGUgYXQgaXQsIGRvY3VtZW50IHdoZXJlIHRoZSBjcmVkZW50aWFsIGFyZSBpbmplY3Rl
ZCBhbmQgd2hhdCBzaG91bGQgYmUgY2hhbmdlZCBvciB3aGF0IHNob3VsZCBiZSBhdm9pZGVkIGZv
ciBwcm9kdWN0aW9uIHVzZSAvd3J0IGNyZWRlbnRpYWxzLiBUaGVuIHdlIGJvdGggZnVsZmlsbCB0
aGUgZm9ybWFsIGNlcnRpZmljYXRpb24gbmVlZHMgYW5kIGV2ZW4gYWRkIHJlYWwgc2VjdXJpdHkg
YXQgdGhlIHNhbWUgdGltZS4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwg
VGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


