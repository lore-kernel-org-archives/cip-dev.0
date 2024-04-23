Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF86C10F15
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:36:32 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.75])
 by mx.groups.io with SMTP id smtpd.web10.14491.1713865175547903213
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 02:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ca5rXlEs;
 spf=pass (domain: siemens.com, ip: 40.107.105.75, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLpBY6zAxpNOQceLTN7+535UtBizxm0T1wUbNcpunrY9XWlofiSidFNzRqla7gAv5nHfurMiz9y5kLMFjj+WxSaRccP502Q7zIdSqhRZLP3wu/en0Sr9lbCG+lhetZEBVQr4MDiEHGUkpf4F2nDwqQCUbIb/MhNmccCIi09DbpiIUwRTjzbgwxiz/G6QeyVnNGxH0J9+U8WZfbCSeNt4q86O34vR6iRdjcPoOn4iTkV8d6q9ZudsuRzyfhjBozp/dvwgxhDReLbciGJGE6cM7Sdcu2UlZChr8QErCCVXLUGE0h1FqfDpWxPvEXBnURVdzdSHysFEtI2768+l99bdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhD3ZfR38iQInEczEYUhT7sAtpT4OScqdoiDE4aBHoQ=;
 b=iPYk1SlbwhzGpFnRJTy5MZ2FAswYcl1pu5ZoBwemB4NYCxxk74qmfOgqePmaLBPeOAoZ0kwzfbSwmAkPks3vjjUpg8ttwJIKiM7czB0OM51pNO7KD5IY/EG8dK97KcZ0bApSNQRkTgSmrGx6n88PqbeOdNcKSnmGb1l/lN9Gcs8+CxsYUUds791r6WNW36oi1S1xAMqCtJ/a58DCvlyUh++dnoeyzFYMS2mY8MbOLybWvrOGmwOKJ+JE2myyeu+wGO0G6YVWVdRZmDvnNco7tOYCU+cX9/CThmuLRbQQ5nrs3UgFQsi0pr+Miiyh8TofFW7ciOUyDbCSoOn6KoCNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhD3ZfR38iQInEczEYUhT7sAtpT4OScqdoiDE4aBHoQ=;
 b=Ca5rXlEsbaC8nqLA4LSEyyZCUK+0ckSUYTwAdDPgCLQOpqbad7gKKTjLe2xDghRiKCsZplDH3CK2o5txf/7qngym1cyJXnbUpM5Y+GE/XCzcKlEf0Ow0bx92+nTFi5gsiXsE5555V9QF/OijQwh6csC68IrVoDYjvWvYw5lukYZiTXIEqMHzfxVu04zv/UBrsAObnaMXV6gY8Ll6cmY3r/8oZEJKZa9xW6KcrzZiYNq2hFInpmydcbil44faU7yr7xhx4ORRH9w1zT9Gc3XRJIFp3KJRoyxehR8jJ7NQ522g1U+Wn5W9bcdeDGdzQT6uNsrSbwv1LUosqmcGVkAMIA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VE1PR10MB3822.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:39:32 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:39:32 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/7] initramfs: allow empty mountpoint for crypt hooks
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 2/7] initramfs: allow empty
 mountpoint for crypt hooks
Thread-Index: AQHalWIlWMyvogsSZk65cZLtuz0FuA==
Date: Tue, 23 Apr 2024 09:39:32 +0000
Message-ID: <b94187fdae5e249afce7cf3953f07cda0bc5916a.camel@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
	 <20240422141120.577573-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240422141120.577573-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VE1PR10MB3822:EE_
x-ms-office365-filtering-correlation-id: 1cdcfdf1-d894-4215-f2c3-08dc637947bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZU9nNWNiZ0ZWMFdQcmJ0NEpSU0JEbEZod2Q1L3FKWEVLcnI4OXYzd0VrOGFh?=
 =?utf-8?B?UlFGbCtwRTlDL0hFT0xJZk5qVENSN1hLbG14MGxkT3g2RDZSbm1SYU04cG9R?=
 =?utf-8?B?d1pybHY2M2lsUmpEeE9YVkV5NXBvQkk3Wm0vTUxnVTFuNW1JWmdDQUJWYlB3?=
 =?utf-8?B?azBnZXRpSjZxS2FSOUZnTzFDbmpQcEt0cFFweGU2MkZqMGFVdWdCSUU0dGE1?=
 =?utf-8?B?R2tzclJ0MFRaczFSRkhIL2pGVHMvNDZlUExZYUdnMjRUUDhJTG5HVTZiUmdR?=
 =?utf-8?B?OWtiT290U1Rla2Z2b01za0VnbVpDdnRSbE5xcXExK05zazhaTEFUY0pxRUJs?=
 =?utf-8?B?ZnE1ajZCNFhveSt3cWVYOEo3NFRmVjB2a0RwR3g3Ym4xRmFFOWhGenVvSlpI?=
 =?utf-8?B?Y0hwa1VCRVc2bkVQdEJoZWo1aHFkVXFlSkNDNmg3UGc0TUtGbHVUQk1iRVRE?=
 =?utf-8?B?cmpHQStzRStKRnl6R2ZUcUhmQW80UW5wbUxROEtJYUJXcExPTkpOZFBVcHlr?=
 =?utf-8?B?Rll1MVZYc2M5SllheHcyY0MrM0JobHlkRFBrUGVFanVNdWxRa0gyMnBpNkNi?=
 =?utf-8?B?ek96K0lFaGRlMnVsZFNrMmxISnIzTnFZT3BoM01Qc0wxeURRdjJ5ZUpTQXpL?=
 =?utf-8?B?UWRNZ08rbWtUVU9zajd6c2NTbnIxdTFteSthTG9JditBR2hoZ3ZsSVBnaUZG?=
 =?utf-8?B?dmxsS2JKQlNCWVVNUTk0cXcrZXNzK1ZDbDdSS0ZWRmQ1UnJNenJQYXhua3Ay?=
 =?utf-8?B?d3FnUWg0TWRaeTNWRW1BdmlyU1BwT1hDM21YaHkvSGdqQ251U2l6UkVHaktr?=
 =?utf-8?B?M3BXQjR0TjFxSzRSUEVwUy9od2E2Zk91OUNZOXNzcHZLVjZsZVQxM0Mwalc1?=
 =?utf-8?B?RzYzVVpxMUhNUkRvTzBxbjRzZXRpaFNBdllaWUtoOVZIZlk1c29YVDlocmd3?=
 =?utf-8?B?MHJTYW1iaVNaUEhuVFB3bHo4MjU4alBUcVpwbW1DdlBqejN0K2Y5V200QkFs?=
 =?utf-8?B?Y0YxV2IzRnpSL1ZLd2Z4c25Sd3lzUEJsa1JIaVVmZTQvRlk3RlIyRWZ6NytL?=
 =?utf-8?B?T0ROUG1pRnJ2anRyUzBTUGVOKzN3M09MUzJjc0NlYWdJTk5JZGszeCtpMWcr?=
 =?utf-8?B?MVhKOGlRWWZETXE5THJBdkZCOUZaRmhRVENIaDdWdWxteXdMaUFHOFZpekVo?=
 =?utf-8?B?Q3k5YUpSN3ZibGt6Vm5IR2ZnWXJRa3BqVlJ2Y25NVXVmRWdvQ3NoN3BWQ3BF?=
 =?utf-8?B?N25DbDZxczJHMm9wQXdXb1ljWDJ3V0ludjMzQXk3YmRsa1dseVV5eWV2UERl?=
 =?utf-8?B?L2hsVCtPWFg0NEZFay9RenNxcDZrcjNyS0xTc1ZvaEJmRmhYWGpCTmdFdW0v?=
 =?utf-8?B?OGFmcHRvZ0lGSzhXamk3bmMrem5iWEZvb0NHbGcyNVJwaDFCVWYzSHpWWktC?=
 =?utf-8?B?TW9Da001MlVHVDFwdUpadG55TE9kd3BlblBPaFlhTkdyYUN6aDVHd3hOM2tU?=
 =?utf-8?B?ZkdHQ1dyVUpOZThyeXU4U09CNlJGNjVjMWp3U0k0YmpUaW5NRzBLUzFBVlZU?=
 =?utf-8?B?RmdOWnhVakpWM0pRV2grU3JtZ1I4a1BVQzRsTHBxb2NveUUvRXBqbG5DSjBY?=
 =?utf-8?B?a0diN0orL2JlRkluMGEySVJHVzNGMnZBZGlSMU9jVllrRERHQzBBQ2ZxYkdl?=
 =?utf-8?B?QitiZkFWa0VqbWJjMVk3dkRzd0p6QmJVVGl2cWZlUjJMNG1qMis3MFhDVUlu?=
 =?utf-8?B?WlpUMjJPMWFOOWNreHNldTF3Z3pyRG5rcVNTejRmOGZNVDZVRGVzMHBBeXZH?=
 =?utf-8?B?U1JJUXJYcjFkaWdFRHZIUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MStiUGJKNHFpVzM3RWFEbHBORU1TdWRZdTh3bjVTbU12aTNhQ3NUZEhGcm5N?=
 =?utf-8?B?WXV5Yk4wMHlJQmVPcERLY3FTR2VBMWN0RGV6eFVyKzV4bkxaejBGd0hPamt4?=
 =?utf-8?B?em42YnZYSFV0UGVIS3ZPeXJJUGlwY2liZ1lUMllrbDR5d095YXMyRWVHM1BT?=
 =?utf-8?B?dDVHV1FNU1lYQ2FuL3ZkTzdLdVFqWFJvM2RWU04vZ09XcjdEYWJCS3Mzd203?=
 =?utf-8?B?ZDViYXN0UmVhYSs4RkNGRmlNajg3RG5Wdk50b2U5RlI2TjRmb0c4VTdGUUVq?=
 =?utf-8?B?cUQzeXhIamFiaTVTUDhEZmo4dWpsMjZxK1hGNG9NV2plM1Y5M1BObThWOWVa?=
 =?utf-8?B?eFJNYmIyUUJlME52c0oxNkxNZjhJRmhWT3doc3RHTE9jU2NkRzZybWYvRjk0?=
 =?utf-8?B?NHlSVlhPQjMvTFVYZzVZZVlRd1loN3dPNWVMQXcybEgyR2svOGRRTGV6eFlZ?=
 =?utf-8?B?WTkzNEhuMWxkcmVRejU3Y3hwQy9udU8yZTJ0NWZ5N2UreXFCSDhDRXJPYTJ0?=
 =?utf-8?B?Z0h2K1ZidmRXN3pnZm80ejhQT0lLcWhwdDBKWUljNnFFdTcvSE9Xd01EZjd5?=
 =?utf-8?B?RnNackUranQ1Qmg1VVJ5cm11NTBsdkpRNTZkKzhHZ2szUGhLVGMrdDYwY0Qr?=
 =?utf-8?B?MVEwRFpyWkJBaGNROFJPV2wveVpTTEtHOU1kRFVxTms2aEIzOW5MeHVRQ2xn?=
 =?utf-8?B?L2lER0dzNWpXakVtTHBSSkVsVzFzT2x0RXRIUGV0RFF0N3VCYWswZ1Rqeksv?=
 =?utf-8?B?bEJXNlVzY0lvclpNYlFocThRYUN2SG9IUlN5SnN2TVMrcDJXdnk1dXlmZzVn?=
 =?utf-8?B?VEpSak9oYnZKZ1VzbndRdHRjbGFnZWZsT0tweGh1WmdXUmMvamxWZDQ1N2VT?=
 =?utf-8?B?QXNJMHo2UTRYMVFGVmFvN2p3amVkT0ltREZkc0Ivb0QyQS92NzN6UUc2bWh5?=
 =?utf-8?B?SU1Jd1pvTGF6cTVBb3dTVUZlVjlOOTdvQmtzaHRyTHdSTk5TRngydHZKTkFq?=
 =?utf-8?B?RnY4clJueWU5LzVrVEtMZnluemtmeEtCMlhpR21KQ1owdFh6UWFwa1JEZW9O?=
 =?utf-8?B?a0ZzZTNPZERqYklQd0VmeHZOc0M2YTVKWVo1QWdUWGxDY1BaWURFbDcxNVM1?=
 =?utf-8?B?cCtDY1lDVGZPZ3JmTDd5L1dYWUxmYUNkR2dPZCsvaXowRzkwamFwdGphKytE?=
 =?utf-8?B?T0JSRVVkMlVSR2dlbkRuTWl4UW9NWERBcTNiL0xQbFFkYk1rZGYvdXZUTFEx?=
 =?utf-8?B?UXg3V2Y0NlAvbEpPN1Z0Tm9KNnE2andqS0pnTXJySnB5d2pSYll6OUlwanBK?=
 =?utf-8?B?eFA2N01EL1ptMVZKeWtwV0NhMEtpSFVXOE0zWFlzNWZqNGZXNnpYbC9hNlB6?=
 =?utf-8?B?ckpIdmR0YjVNUmNYZ2ZPQ0hwNlh3RFNLNENkQ0o2TFRvdFR1MkRFMGdkOVd6?=
 =?utf-8?B?N3oxMkVvaWdCcDV1cFpueDBPNTZ2ZzZPclRMMUU2SkdaeS9tUGxCL1M0K010?=
 =?utf-8?B?VEhqTTN0bElIMFgvTEhaa1VmSndBZGlxNXhyekhNQ1hSWVlwbVV3VmxEMERt?=
 =?utf-8?B?anpJek9zSVlGSEYwUWxyejA4TThZenJtRHZWQUFIMmdGd2JDU1dtUEs5UElq?=
 =?utf-8?B?MUo1Rld3M1pGcWg5RHhZdDFkWnEzMVZmN2c0clE5LzMwQ3MyaStWODRzYitK?=
 =?utf-8?B?bVZNM2ZoWUpvbS9OSXJ1cVJ0SUlyRHA2VWJCQ2EyQmpVN0RHNHdxV1NsZTZY?=
 =?utf-8?B?VTRJTHU3MW1zeUlJemFPZzRIQ2hpaXJhaEF1ZmRrSlo2Y0d1RjEyUmExcXdD?=
 =?utf-8?B?bkxkZzRSRzNvMWhoUGtDbTlxZkdSdlJ1ckNjNU56Ykx4OG5wRks3U1NsSDZW?=
 =?utf-8?B?azRZWUhjZUhqRE9qSDBiNlp5Tm5MRWM0L0QydHlFTHc3R1ljV0RocWg5NTRo?=
 =?utf-8?B?TW44Y203cnBYT1JabXl0V1gwbEF1SjhHVlhKMmEyY3NBN0tlaXMwNDlCY3JV?=
 =?utf-8?B?Sys0cjFZYm5RUjExOVZCd0c1Z09BRmFIYTdMWEhYcG9YN3UwWk5NbVJWOFZx?=
 =?utf-8?B?RFlaV3AzSTVmKzFaenQwbVFWdXVsSjhHbUJxb2xlLzRNYmVJVDJqdXRNK0pT?=
 =?utf-8?B?bXVZUXZUYkN1VWtBSjRGeGc0RWVueXBIeUl3V0haUlNZZCt5R2NENnY1bStN?=
 =?utf-8?B?bVcwU21veERla3ZhR0VwN1VBMlZ1amtNbyttZitxUjB2aVp6aVY5QUdjQWU4?=
 =?utf-8?Q?8VAs4gPwrDl/1QIcwR1Q0gtA05dpejkwTBVh5vOQKQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdcfdf1-d894-4215-f2c3-08dc637947bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 09:39:32.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZF/eA2MkVkfaYih0Gp8P3MLYO4aLmaLduUCbD9vNCttzmx9sC/6towxUhpzSzN77qNBf3XWFFiPKhVwcZ8JGpy4CIsRdBefEOt9S6+RH+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3822
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D424624F80FD5949A46A35E1B462BD6A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 11:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15737

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDE2OjA5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgdG8gZW5jcnlwdCBwYXJ0aXRpb24gd2hpY2ggaGF2ZSBhcyBz
ZXBlcmF0ZSBtb3VudA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLV4gVHlwbw0KDQo+IHNjcmlwdCBsaWtlIHZlcml0eSBhbmQgYWJyb290ZnMNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+DQo+IC0tLQ0KPiDCoC4uLi9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9tb3VudF9jcnlw
dF9wYXJ0aXRpb25zLnNjcmlwdMKgIHwgNA0KPiArKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMt
aW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gaG9vay9maWxlcy9tb3VudF9jcnlwdF9wYXJ0
aXRpb25zLnNjcmlwdCBiL3JlY2lwZXMtDQo+IGluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9v
ay9maWxlcy9tb3VudF9jcnlwdF9wYXJ0aXRpb25zLnNjcmlwdA0KPiBpbmRleCAzNDExZTcwLi5i
NzIzMjNmIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQt
DQo+IGhvb2svZmlsZXMvbW91bnRfY3J5cHRfcGFydGl0aW9ucy5zY3JpcHQNCj4gKysrIGIvcmVj
aXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiBob29rL2ZpbGVzL21vdW50X2NyeXB0
X3BhcnRpdGlvbnMuc2NyaXB0DQo+IEBAIC01MSw3ICs1MSw5IEBAIGZvciBwYXJ0aXRpb25fc2V0
IGluICRwYXJ0aXRpb25fc2V0czsgZG8NCj4gwqDCoMKgwqDCoMKgwqDCoHBhcnRfZGV2aWNlPSQo
cmVhZGxpbmsgLWYgIiRwYXJ0aXRpb24iKQ0KPiDCoMKgwqDCoMKgwqDCoMKgY3J5cHRfbW91bnRf
bmFtZT0iZW5jcnlwdGVkXyRwYXJ0aXRpb25fbGFiZWwiDQoNClBsZWFzZSBkb24ndCByZWx5IG9u
IGxhYmVscy4gVGhpcyBicm9rZSB0aGluZ3MgYWxyZWFkeSBtdWx0aXBsZSB0aW1lcy4NCkJ1dCB0
aGF0J3Mgbm90IHBhcnQgb2YgdGhlIHBhdGNoLiBQcm9iYWJseSB0aGUgbGFiZWwgdnMuIFVVSUQg
Y2xlYW51cA0KbmVlZHMgdG8gYmUgZG9uZSBmaXJzdC4NCg0KRmVsaXgNCg0KPiDCoMKgwqDCoMKg
wqDCoMKgZGVjcnlwdGVkX3BhcnQ9L2Rldi9tYXBwZXIvIiRjcnlwdF9tb3VudF9uYW1lIg0KPiAt
DQo+ICvCoMKgwqDCoMKgwqDCoGlmIFsgLXogIiRwYXJ0aXRpb25fbW91bnRwb2ludCIgXTsgdGhl
bg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWUNCj4gK8KgwqDCoMKg
wqDCoMKgZmkNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIC91c3Ivc2Jpbi9jcnlwdHNldHVwIGx1a3NE
dW1wIC0tYmF0Y2gtbW9kZSAiJHBhcnRfZGV2aWNlIg0KPiBcDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgZ3JlcCAtcSAibHVrczIiOyB0aGVuDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW91bnRfcGFydGl0aW9uICIkZGVjcnlw
dGVkX3BhcnQiDQo+ICIke3Jvb3RtbnR9IiIkcGFydGl0aW9uX21vdW50cG9pbnQiDQoNCi0tIA0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

