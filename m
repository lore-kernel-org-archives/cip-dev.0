Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B73CCA476
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 07:29:34 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.36])
 by mx.groups.io with SMTP id smtpd.web11.3748.1760081371846054869
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Oct 2025 00:29:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=TFRlwROD;
 spf=pass (domain: renesas.com, ip: 40.107.74.36, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWvH2FcjFef9Yn3CUJfuIH+Hnw4taQT9fIfS8W0qFvcAjUMzDY2YPV4vN0GA7qXyhpnVPSsft7fWeio8MnFdiP7zcFNMOfbP1BTPGP2/MKDlW+VDaSAJR4WUSJrB4CkfWJGPg56w1Sekt0WY6opXOrqJRrTwChEvp4Wx45SiHSWJwGo/3lENQUOtwJlLl/hbjRy9lFtA/NpekcZsvfhvMKPh6KcxpBLKSL9HNWeLQqvZJ6hLABq+sk0yLYPt0mNsdOUHaF622RLrjZzveoLOip0Ach13TYnSm5ngcpgH9GbHwGkPTPwKR8AZfogfce1wIRVdRvgCO6bMmhHLBh4a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IBlMKp81RpTNgvCal+7V/tMb0W27C3iab9M9Q6V6nc=;
 b=bFvNYTlL/dTs888K8MhgBJEJRR9mq+Z5quMjuvyQvnUEe19N+q+LAQp3SSZ/Xk+tbFf9wXoTeyJGTPwEP6cVda5TROjCJdsgOalbA/y8Oj5VEh1C9uJb/WJa1CBjU8lFnRtEdLRU8pDXXJ+VyhhefN2PsYYlFkX5d8FXQa9wYvI2lWHdvhmkTOEen3/n2vCFUBVBtWl3wLu2jrd18plFEjnI2Xxu5p+SYEzNQ82HJH2+sjs9z+QLn2C5wHrxpq1FIQaOJIPOGmDHwJUoz6Rsw0Grm+zl4UT0lPwz1cud+uJI9tRAF9OT8Yp76sHchKwm3GDS+h8iHcfjKaM5MjHFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IBlMKp81RpTNgvCal+7V/tMb0W27C3iab9M9Q6V6nc=;
 b=TFRlwRODGfqQvdcyWsCHJli7n98fZYZKw/CtggmdqzdkPn++XfU34QI+Aaycrq3G8dcWFu/Ce1PiQkmdrELyLR8LoR2w5u9tA2r7NqhUggB0tmHELxykTlHjZ2LMbJf2Sbjqm2BjwEq7O2mRt2kkbFE6ioaQXMUS9+IXsOxlnZM=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TY4PR01MB16846.jpnprd01.prod.outlook.com
 (2603:1096:405:338::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 07:29:25 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9228.005; Fri, 10 Oct 2025
 07:29:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "lnasby@intwineconnect.com" <lnasby@intwineconnect.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] v4.19.325-cip124 pipeline failure
Thread-Topic: [cip-dev] v4.19.325-cip124 pipeline failure
Thread-Index: AQHcOa5JRkWXra7Xfkm67HDw/QcL47S68TpA
Date: Fri, 10 Oct 2025 07:29:25 +0000
Message-ID: 
 <TYYPR01MB151328AC3E67C4AB3016EC716B7EFA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: 
 <CAJ6VbXKtYC2r6+obQvCza9jtWTCsfRbzNGWFa6_MwZALR9qvJg@mail.gmail.com>
In-Reply-To: 
 <CAJ6VbXKtYC2r6+obQvCza9jtWTCsfRbzNGWFa6_MwZALR9qvJg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TY4PR01MB16846:EE_
x-ms-office365-filtering-correlation-id: a89f8018-2147-4c50-828b-08de07cebd95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V3pyR2xkaGtkbEs1L1JwNlpqWjE2VzJ5aWJiWnpMQ2Z5L0dmVkVjc2pZVmR6?=
 =?utf-8?B?YU9tUDUvTjJ1ckVUeU1FU1VyNXVoVzhCMzVCTWN1N05tM0paaXhrV042WDdz?=
 =?utf-8?B?YVNodzdlR3dDb3VOZkxwcWtXYmEwaGJZaWFuSTZhZzQybDVITktyYm5PZFF3?=
 =?utf-8?B?WjJwWlp3Rnllbnl0STV5b0ZlbEF3Wlg1TFhiVjdZcG5LQ0h4VkRqczQ1NXF0?=
 =?utf-8?B?cEJ5WjJ5c01hTWFHMWhnb3JNUkgvZmdOUjNVcUN0V3pWTkt3YnhtVTlnL0Jz?=
 =?utf-8?B?ZE1NcnhRM2pzcWxlaG5HM1pQb0tiOU1rbFk1Vm0rNlBrWjVwcUlnTW9hSUZ2?=
 =?utf-8?B?d3o2UVZNK0luTVlNenhEYzlMVUJhVXNkN29jVDdsamFCZk5ER1VkeWIzdVdP?=
 =?utf-8?B?dmpxVzU5MmRqZ3lkYmFDYTUreTdxbWFFTHBuNmc3ZENEV0RGTzFzcmRKYUs1?=
 =?utf-8?B?UVlrMUVBdDNzTG0xWXFqQVJMWTMra1hpNWtxcXJzM3FyeXNXVjFjQmtIQlRD?=
 =?utf-8?B?cENNcGtXdFFEVlA4UHdldWV4N25rditzSStZNUN6TDZsSUlUK2phWHJjQUVy?=
 =?utf-8?B?QUVDSTZSQUNib2R3RmJvTVRjdmg4VktFcUVtWERLZFZiTGw5TFZabW1GTkVN?=
 =?utf-8?B?UnI2bUlobEE5M1VZZDVIVElDWm1RK09QWWw1dVlCSi9yVVA2M3ppTUpxcWdK?=
 =?utf-8?B?eUFIRjZCakgrd1lpZy9ESDk5TFA2L1BVZEJpOGE3WUdZR29xRW0wTEZwcGEx?=
 =?utf-8?B?cTRzQXZHcjRDKzdCRkE5alc5QVJjbll0bDhFMmt0WjBPR05acXFNSlBUMTVi?=
 =?utf-8?B?MUtMNktyUkxiSGJQSi9ZeTdkaCtqL09ZK1B4WkJPKzQycFNqQldwbm1XOC95?=
 =?utf-8?B?YWtaM0ltczl1TkM4VXhveUVQakxOZVlIay8xdVJrd3ZTc0lWcDhZamk5MkZa?=
 =?utf-8?B?cDlycms4dHl2ZVpvSDgwVVRrVU56c3YvK1FMMldFSDI0R0ovYjZFSkZNWVRV?=
 =?utf-8?B?dlZURXU4anBqaDdUK3VidlQ4ZnN5TUV3U0tKS3ZHWWNScHVIdHJnUkh6ZWx4?=
 =?utf-8?B?RWpydTR6dVNwTjRsS3VtSGtTQ1BvSDhuZmdONDBBd2RIRTkvUVIwQ1g4M21E?=
 =?utf-8?B?QmlwOHNzZ1JYczNFZ0tkN0JWRWZncjN4TEpWc21HbEIwWUhKR2o1L0d4VGlo?=
 =?utf-8?B?VGhEbi81K1dnWVNETDQvMWlNeHcyeFdNcWc3NHo2R3ZQaVNsd1ZiWnhGQURU?=
 =?utf-8?B?UWVTM1VVemY2TnUzSDAxbkR6YVhyOVFkdlJ0VHRuYXd2N2R3bzFmbGpxcE9O?=
 =?utf-8?B?Wmw0dnAySWJ6ZHNZTG83RlFndi9QcXoxU1EzQWlzNjhLOTFQVVEyYS9oQng4?=
 =?utf-8?B?MGxOa0JSVytEeFdsQ2NFd0F4Rm9qRTlnRVloNTNNSVlRUXV4UTBIY1dhakVG?=
 =?utf-8?B?eGVBeW02MVlOMUJHMWVvWFJyY2h4d2prQmNXM3lMRjFWR1NJN2o1Q0lXbnZy?=
 =?utf-8?B?UUo4emlwbnM5eitkWmdVODVvZ1FVREpxdFdGOUdBekkwTWRaZWhvRUpiL3pz?=
 =?utf-8?B?NWZ1Wjl4WlNoTGY2YU9TUk42MVRxU1Q3VWRVSDdKQXluOUZJT1lHbmNkUXZl?=
 =?utf-8?B?c3VET2VjUndwdUNIc0o4YmQ2a3MyU0J2NjVqendUNnZoWk45YW8xTjgrQTVD?=
 =?utf-8?B?MEovQXJ3akNGNmV4eEVuN1pGb0VxNGswVUdQaHA2V0lNa0pDQzVXZ2hIeWlv?=
 =?utf-8?B?c2FFSXpRV0x4WUJEdWhuK2pUekVacHZmZGQ5Tno5czIzcDkwakpNNzJnUVFx?=
 =?utf-8?B?S1pLdUYvREh0Z2V0U3ptVEQxTkRVdDVBRGhITys0RXJhcVM2S2ZuR3hPR005?=
 =?utf-8?B?REp5SXpHVnFJSGo3aDRDU0xZVDBVNms2MDZxS1Z3UzZYV28rL2xtQTM4RTBo?=
 =?utf-8?B?anZsWHQ3NXdkeE41ZmhlbWRUL1hWWVBFUXExNlZXcHRlNnRwdk01VGM1YmxR?=
 =?utf-8?B?MEZlbVdWMk8zc2tYMjlrNjN4S3Vkdi9iRnMxQXc3c2Rtd2RiYUhmM24yMkRZ?=
 =?utf-8?Q?vwoRXl?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?em9iYUhJNGw0N2ZXRUlJS2w3K0lDdGhFVDBLSENCbTBqS1dhRHBaRUUyeWNI?=
 =?utf-8?B?NE1PbVF3c0hoVWFKTzhIbyt0N0Zmek01THp5akxXREVkL0ZwSGFGZzhlbUZN?=
 =?utf-8?B?dzZUUm9iSlIydTVqRU9sMUdZYkhCRS94dUtYeGpyL2NlbnJYTisyUE1LMmlk?=
 =?utf-8?B?NnlublJ2WlpIZHc2VDBVOFlCa3BHSDl3cENjV2xBOU5WR0VKOXdUR2pIckpB?=
 =?utf-8?B?dFdwaHpMWHh3K1dwdTNXREpGM3pvT1FkUER1N2hHQURBcUVhZnBsVTQrZDVj?=
 =?utf-8?B?ZW9VVEhtQTFxTXdkbUh3VVlRQ1FQRFhOS2ZMS096blB5OHlXM1lvQ1JzMWhQ?=
 =?utf-8?B?bVNadm1Uc2U5eWlmUk4zVGd0cmFMclpIYlhBRU1TY0ZRc2FFRW1tMzMxUTNq?=
 =?utf-8?B?MDM1cmJTNExYc0dlcUZHdVRrcW9DcXFCQWJGZitQYUkyY1pKaWc5U3E3T0ky?=
 =?utf-8?B?TklvVi9NV1M0aVViVlllZ2VubVpxeWZvckxLT3gzYWVkeU91V2R5ZWR1NXJL?=
 =?utf-8?B?SVJ5ZTFKZ0VHMGJjNzVyYTVuY0EzTG1mUVdLWmZWTzFxSHdwUnl1L0VKcGhw?=
 =?utf-8?B?SlFyZzl1dUVyTGF1TE1aQnVFbS8rTG91WGFBRVR1dWRZZzJ0VHowUnRlamx6?=
 =?utf-8?B?WWdvc2FuSlp0V1MrdFpDQXFUODY2UWkvbUoyTno4d0FSckZTMUlFOTUrMVpu?=
 =?utf-8?B?Y3A3NmsrSW52aUV1YzcvZmRWaWpHZWNRMjRKdWpGSXdWckh4MWNBNDlwQU9Z?=
 =?utf-8?B?QnJvc3VwU0FsL0wvK3VNYjFrNkFISUxNSDBRejlweW9BcTZlT2lURGcvUm1I?=
 =?utf-8?B?TmhtNllJUXhmK2tsS3dpLzc1dGV2MFZkNmJaNldTVEw5cU1kOU5pMDI3Njhu?=
 =?utf-8?B?OUJXVVFwNnA1MTlhOUM5TWRDMjJlbEVzdlU1L2FnczFlRHdzbEZIVVJ5RTdp?=
 =?utf-8?B?M0FpN0ZQdHdRVE5rRmRQdXg0ZXhRYnpsNnlxRDhDaWJjSWVYcnE0V29JNURi?=
 =?utf-8?B?OUl2ZEVOK1pLR0lveEo2VC9KajltT2JVQ2lUaVN1eDJKMFNNTmtYRjI2NlZu?=
 =?utf-8?B?U2lFaUV6MmZjNkxrSzh2Z3E2VDBaZ3p4UDFJUWlZSG0rQnNVYktKN3l3Mzgz?=
 =?utf-8?B?cFJRNXhDOElBUzM2V0V1TzJBZmI4VlFqM3VMWWZ6czZlaG5kK2l4OHFOVzJr?=
 =?utf-8?B?UTd0RWxNWmpVQlRJWTlxUnYxaWZiT09YVXVxTGMyUlpkNjd3aXBpd0gzeDN4?=
 =?utf-8?B?RkVuNm1rb2c5YzFEdnB2VFlsZFpzQVFBZEh0Y3U2NjRMeUtPbEVzL1NTQlJh?=
 =?utf-8?B?RjhyUHFSTVBhRGdDQ1ZhVG84ci9INTNVKzBqL0xMcTlwYWlZMGRjMTNiWUZS?=
 =?utf-8?B?UmIxS2lhLzRrMTVjTFdzL25SU0tZNmN6ZXdrWmdsZCsvMVh3SnhqWEpjMGJk?=
 =?utf-8?B?NmlUYWYrcXRjbkJRMDQ5cWR4VHdnaEYzQktibzUvRExSMlp1UkF5TlNEbEQ5?=
 =?utf-8?B?OEVBejBlN2Irb2I2ZUJnVFdHQzdkdlZqY1ZOR0tFbVplTnUxSWV5Q1Z5Zklx?=
 =?utf-8?B?NnMyTG5CYkh1c2R6STQvZ1puQUkwMmNVcm1wQWg3Y0NvTkY4ay9kQlhCM3Na?=
 =?utf-8?B?bElsQmlNaVhpUTNsekVhL2I0K2lYVWhiazYxLzFsaDA4MitnQ3ZZOXlKZElE?=
 =?utf-8?B?cFJqVVZybGlrMjVGVElkQU9RRmFwb1NhM09RY3UyUmM0RkVQallJOFpsUjFv?=
 =?utf-8?B?MjB6NE9QUXFVYWlaa05vR0dBRGVmQnVQV1hTbWZJZXB1akI0QzhPWmoxU2Zq?=
 =?utf-8?B?Z1gwMFdyNW5uUkdtd09WVmZDWmsrbFRsS2hOS1prN1NCampNakNnVytNUSto?=
 =?utf-8?B?RTdBZ3hhYkZpZHlKUDJwVTJVL0FVK21zRDF2Q09IeGIxQ053M1NzeUpSbmNZ?=
 =?utf-8?B?ZUFhYml4NldqTGpLd0cvZmVIem5IRERUTk8vK1Bnd2VKUUFudjg3b1BSRExY?=
 =?utf-8?B?ZGdxVHBxYjhSa1AzMWdBZzZuTTVUUGRQNVRaSmZsaXNRVkwwZ3BZbEZhNk9k?=
 =?utf-8?B?YnZWN1hDc0xDTFRoRVoyR3h3R1RXR2tFZmZZK0VIVlJUZTNRc2x4VHZybWxF?=
 =?utf-8?B?MitLZEFjYzR1UUlQcXhuL1hPY2pNcC9JbE5iaUZjSDRiK05TMGgxUndMbFla?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f8018-2147-4c50-828b-08de07cebd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 07:29:25.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHio3mZPA7/14/JutZREql5DEmaPSwA9LHzVb8swo1ol87TBUMLncHY1LL1D5+RP5LZPnDuSEH9DsborLjkc2iGgT4ogJY/hLjmJXnFOBl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB16846
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Oct 2025 07:29:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20168

SGVsbG8sDQoNCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgTHVrZSBOYXNieSB2aWEgbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IDA5IE9jdG9iZXIgMjAyNSAxNjozNw0KPiANCj4g
SSBub3RpY2VkIHRoYXQgdGhlIHBpcGVsaW5lIGZvciB2NC4xOS4zMjUtY2lwMTI0IGZhaWxzIG1v
c3Qgb2YgaXRzIHRlc3RzLg0KPiBTaG91bGQgdGhlc2UgYmUgcmUtcnVuLCBvciBzaG91bGQgd2Ug
YXNzdW1lIHRoaXMga2VybmVsIGlzIHVudGVzdGVkDQo+IGN1cnJlbnRseT8gSnVzdCBjdXJpb3Vz
IGFzIHRvIGlmIHRoZXNlIGtlcm5lbCB2ZXJzaW9ucyBhcmUgc2FmZSB0bw0KPiBpbmNvcnBvcmF0
ZSBpbiBhbm90aGVyIHByb2plY3QsIG9yIGlmIHdlIHNob3VsZCB3YWl0IHRpbCB0aGVzZSB0ZXN0
cyBwYXNzLA0KPiBvciB1c2UgYW5vdGhlciB2ZXJzaW9uIHRoYXQgcGFzc2VzIGl0cyBnaXRsYWIg
cGlwZWxpbmUuDQoNCldlJ3ZlIGJlZW4gaGF2aW5nIHNvbWUgaW5mcmFzdHJ1Y3R1cmUgaXNzdWVz
IG92ZXIgdGhlIGxhc3QgY291cGxlIG9mIHdlZWtzIGFuZCBzb21lIGJvYXJkIHR5cGVzIGhhdmVu
J3QgYmVlbiBvbmxpbmUgaW4gb3VyIHRlc3QgZmFybS4NCkV2ZXJ5dGhpbmcgaXMgbW9zdGx5IGJh
Y2sgb25saW5lIG5vdywgYXBhcnQgZnJvbSAxIHBsYXRmb3JtIHR5cGUsIHNvIHdlIHN0aWxsIG1h
eSBzZWUgc29tZSBpc3N1ZXMgb24gbmV3ZXIga2VybmVscy4NCg0KRm9yIHRoZSB0YWcgeW91J3Jl
IGVucXVpcmluZyBhYm91dCwgYWxsIG5vdyBncmVlbjoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAt
cHJvamVjdC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL3BpcGVsaW5lcy8yMDUzNTYxMDczDQoNClNv
cnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K

