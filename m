Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF74C19F53
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:10:00 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.72])
 by mx.groups.io with SMTP id smtpd.web10.15125.1714046508026962809
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:01:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x8A6Y6MG;
 spf=pass (domain: siemens.com, ip: 40.107.105.72, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXGpUyZQO/Acu+40AnOJfdDDL7kNvTdhpqYFpzEJjtya1XMkuWVZ+zAicfhuXH//tmocwjv/YQm9WjTTTUZ5oA5adKnQ/EAMi/f8XU92zg4mGLbIC6WfuQqeAokmt8/eQGUKcKZzsdv3hvi8gsUAzxpQ48ZrAANG8Rp1pJP4wzVAGrvyHQWDzlkzmRLgHT4eoHC4K12xsjF3ogzIEprwR/ST/IN5xUNWAJwG6ZVN+c86E6o0sdaqGH6sQLGjvsmVLkQ0pL/RjMz5K3Dj1piYB8U66WbOcCAGkL5daDjnxCCn936mvR+r75w74UPY6SgmVm0Ag3zF0i96F8nbA3ubHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWYK+9hzRGDOnZygx2NgptRZXdrCFKoUuVcNYvK8b38=;
 b=D3goMIlRV45PDibo5+zAuQAp+AL6/4jpI+SykrIeD2BejUTzwq4U03RZ6LrBIPi9bBM8nTE+/MNa5+sQWuWfy7l9jfi3GsnXcnb1pfQ4UMkQwyczVjTKfhi2A/RkGkDEKDaaasi+o6Ln63ocUetpwaak6FgoJcT6Eip+toP4h9QWDbN4CLCyrivNGqUWWp3Hk77hmQgefMuDC0eYf12wMTb5pGSwF48BPFODB7iqXi0n09bH2mmob3CkRVdylVxw/jIaIAt2uAyXypqJ1n02+NVliOn2rPLxnay5yQUsGzJ7vycwaXAYb6QJlMWWKsm3OXLEVuVHI3Zm+SUenPfi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWYK+9hzRGDOnZygx2NgptRZXdrCFKoUuVcNYvK8b38=;
 b=x8A6Y6MGO1p6pwJYghuL4SIVFn+dCx9vGbknGg7JdVdwCLK8AIdrCoGwO4KbG0pxjSXApqI5ArXpS8cVYaFnxG1kfrL7UZTHbjcrp5dKg2LtImjShHL59Hj7YicHG6iptLFTiZWH/Q3cU7N8w7Fc/q8ZzQDCCvie9g5iF3x35z3tiTn1J4W2rlrO4w0UtuzDAT1E1jknf4lLFG+yfF1VyEroy8HPVlEcvgibA0WZN7ua1aWSiRsiHxVAeM/hO3Oe91NsXXk0QZZPp6a6gOOoQjyVsqjOBeEVDSn3dIDAT8981zX02AUJ3krh2utFwr6Km/px0B58BkPO3Gnv7dPpqQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PR3PR10MB3962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 12:01:45 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 12:01:43 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "sai.sathujoda@toshiba-tsip.com"
	<sai.sathujoda@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core][PATCH v4 0/3] Integrate Delta Update with rdiff_image and delta handler
Thread-Topic: [isar-cip-core][PATCH v4 0/3] Integrate Delta Update with
 rdiff_image and delta handler
Thread-Index: AQHalvUo2w+j7aMOnU274M5QvNT2kLF44sEA
Date: Thu, 25 Apr 2024 12:01:43 +0000
Message-ID: <7ebf915e1183c8241ca4922adb9e47ec6985c593.camel@siemens.com>
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PR3PR10MB3962:EE_
x-ms-office365-filtering-correlation-id: df05ca9c-aded-4c3e-db55-08dc651f797d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aU9ZQXJaY0dmUDFvUWZWSnB5WWpnWHIvajZDQW5lNUNmNmhZVG9aa3YvcHM4?=
 =?utf-8?B?RW9DeVFrTVB6VlNCNFhRVnR5QW9HQ01SNHpZbTRWNzRaVGsvejNQZEowSUN3?=
 =?utf-8?B?akNwdHBaUzViR2VaRldKQ3BsNytYNFNKUlRzVjRGb0Q0NzBLZWNJYzBzUk9M?=
 =?utf-8?B?TW9tMFB3Mm1tN05iQ21rd1k1UlpJOXBlK3k0blRacHc0eGZibmNwNDBpN2dK?=
 =?utf-8?B?cU1qOThKRlBDNmpFVUFmRHZUNEFVL0dNTHZ4alFqMGRnZzhiQVFTdUJaRDN6?=
 =?utf-8?B?bDVFY1JJazNpb3ExajYyM1hiell0WFZRNUZPWi82WDh5RDdnSGNIUkJSUGgr?=
 =?utf-8?B?K2FGcWRNb0VLUTU5ZHJkZFVLaW84ZG9YTFZGUlJNbGFva2lmQ3owWTlJY1Av?=
 =?utf-8?B?a0RHeDZmYzdFWjRiZWpZZXlxenRDZXp0d3l3Smdadk1OMFpyOXFXc0pNTFky?=
 =?utf-8?B?cEhwdGM4UURqUVBBS2tWeVl0VUN3eDMvZEZSRlNKd241T2hocmkyVkZqS3NH?=
 =?utf-8?B?M0tJbVN6bHVveHprdXJQWE5ma2p2c3JGaG9pSXNlU2FYY1N0NlZsMUlra2xO?=
 =?utf-8?B?YTJ3dEt5dUhPY1ljczJTN25kR1lMZDBzZmQxckN3N00xa1EwQU9VdEhQNXYr?=
 =?utf-8?B?K1psMkxMM3cyMHYxVzFlNy8xdWgwTGZSV1lwblZnTzJxVGZ3QmNNNDQwcEdW?=
 =?utf-8?B?ekEvNFozTlZ0eFFjQllDV2hFZ1B2NFUyZE40RFJvTWxRN2ZKeEhNWlRMM1R0?=
 =?utf-8?B?aUhYQS9QY0hXYlRlRG1YeFhjOHB4N2krNU55RzNzSERnc1Izc0tPd3J5aWs5?=
 =?utf-8?B?dElFZ3J5dlQ0MHk3Ymp5OVBTRHJ6OEppSCt4OWY5UE1lWHQ0cVQ4UXluRFM0?=
 =?utf-8?B?S25QbE9VZlk3Nkx0cDAxeSsxNFhSUURBK0MxQU1qK2Qyd2lFREkvbVdidXVL?=
 =?utf-8?B?Sm5ieFR1U1NUcGdOY3MvUTM1VEpLL2pCeGw1aWhwamxzTjRkNk1RZFh3NHFv?=
 =?utf-8?B?UVJyYTdJKzczVlduTVMrWHJVanBURWU1aHZBY1BRS2lkUjUyRzlQYW9MSVQw?=
 =?utf-8?B?L2hsWjU3c2JpeTJnSXFocEh0N3NNa0gxUCtIcm5KbTExNDNhUHFPK0xzWmZ3?=
 =?utf-8?B?akZ2aFFjN0MzKy9ZZEdwZ0VUZy9nVUgzenRvbHNWRVZaeUx1YUxXTG1aVE5h?=
 =?utf-8?B?VjZiQ2VNbXVVek5nbzR4SVdEMmkxdHpsVXJ2WXNhbmxYTkM3ZWhzZ3IxTC81?=
 =?utf-8?B?VnBub1pFR0drNndlQUVaUVA1MGJpQTREWkFVNGVHMzJna2pyajdsV0dNQk1I?=
 =?utf-8?B?YUdrbEttSWx6bVJYeXZnak9Hb0tVZ0t2OUxyMXA4akkySVFVVTdNR21GV3lB?=
 =?utf-8?B?V3lPb0toN0ltaEdVZXdyc2xKOURBd3E3d3IxMGI4V05KSGNOMXFoejIya0hS?=
 =?utf-8?B?TEhqUnVPdzdudUJRaU9oWERsTnNyWEZiRnlrZVNMOTh4WVV0RUdvaWNNSmk5?=
 =?utf-8?B?cDNPVmNMUTRWOGUvTWJqS29iUHlMZ1ZmSHBEYkc5eitsYVhta1FNNjZPakF3?=
 =?utf-8?B?MGN4azFJWDgvYlhZS1loU2xtOWkwRFdhSGM2N1Y4R2tBaFg1NEVacWVZbkR4?=
 =?utf-8?B?WGlYU29nejFMdUEyV1BRNEVKUUc3aWIxM0ZGb3lEOHJ6UW9BNFNCZk0rd1ZH?=
 =?utf-8?B?Z2VNT0xyN05vdUIyTkNjUU0yL1FJNElteWZocW9saGVkWFBZOW5jSzZuYnhR?=
 =?utf-8?B?Q0kvY2xQTmdSUVR6OTBOY0dZWVBSdTVNbVNnUSt6cTlVTFgxNllvbDVoMm1F?=
 =?utf-8?B?TnVQNE9aMFJwQjZJeWs0dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TmREVk0vQXplQXBHWFB3N25FdUhrSml5VGlMT0pvLzRwdXlrdHN0VjFwQ05r?=
 =?utf-8?B?TEtqSElNTUV0U0FjOUMwVHloV2tMWHc5bktvckh3UTZ5UlhuTk1mWVdBQVBi?=
 =?utf-8?B?dEFxVUl6QksyMkFFUWNVNFVOTmloeVR3dVBmZ1ZFYjVXT2RzNkw2Qk03cVRz?=
 =?utf-8?B?L0I2eitMbDZSb1N4ZFIzd01ZWDEzc0ZvZko3RldrMm5rcTlMWXNjZmw0VzBG?=
 =?utf-8?B?c0NiZWZENFB3T2w2RHY1SzUvUmYzV0srZi94QjZ2eTBmZHJGMWhmYkhaTEpq?=
 =?utf-8?B?cmgrRHArYUU1YzBmb2l1UHRLdjFTQU5kZzNmNnJaa1JtVFBMUXU0ZmE1MUFS?=
 =?utf-8?B?T3BwZnJ3OVpxR2tvVlRvYm1USFNzRUt5c290M09qWldrc1hacURxVjBXa3h3?=
 =?utf-8?B?NGRBVGU2VXpzZC8zZGxNZWtxbkxEVFYzUnVFMnlYSmlLeW8rTCtQUlIvTTZm?=
 =?utf-8?B?WUcvVnZsWVByNDBFZzBrRXdIODA1SFpHdVNYMXdyNlRWaFEvYjNNOWZlTTdW?=
 =?utf-8?B?U2ZoWHJET2J3bXpDbXhuNkpjeXYyZHNEblBJU215di9Zbi90aUdoa01DWVBl?=
 =?utf-8?B?dGdoWWIzeGdDc0s4dWFGRnBpck8vaTdiZ0U3cHRFTFRCZ3ZLOWljOWE0UnA3?=
 =?utf-8?B?NWpuM3JyaUU3SVhueWYvQ3dpNnl6ckFSamVibWwvcjkwRTA2MFVyaHhNNFBL?=
 =?utf-8?B?a0RwZ2NFOXYwcFlHenpjTkVSQ3M4TFZENURyQnc4NHdCTUp0b0NEOEQvT2Zp?=
 =?utf-8?B?c3ZaRnQ2KzFyRHM0WUNYQ201UHJwZWVzSHNSNWYxRG02b1lXbkJvd01LRWJp?=
 =?utf-8?B?TE42N0l2a0hORkZnSnA4K2xKTVZOQzZ1eHg0ZEZxRkg2dUpTT0VMeFhMSzhW?=
 =?utf-8?B?TmIxaWFDcDQ5Qmd0V3RHUmRkeWVZV2IxeHlPYVFUVzl2MnVGNHdYcFlFQVNx?=
 =?utf-8?B?ay8rTk1NeWlzQm0vYWErZ0E5VlRCejdzY2RTMDRBb2FJU0dDN05tMkwxc3Nu?=
 =?utf-8?B?REU2azQwam9oTXYwQzJpRlp0ajhEbklHY3NaNW92UFhSLzY5alZiZWJ5VUJr?=
 =?utf-8?B?cUZ6SlBKTzl5TnVFcWFYSUV2bW9jZWQ4YjJhU3dZUjBOdUpuUlNwR01OSG1y?=
 =?utf-8?B?UUZ6OElSdEtxRmhuY09KTDNidHBXQ3liN2tMNnpuaEZmcjhHb2U5ayswaG5o?=
 =?utf-8?B?TG55QjJmZFhkZW1Sam15ZGtYWFNlczRZdFVXbldGdHJjeHAyQTkxdC9qMFVZ?=
 =?utf-8?B?MDExTEVRbmRsRzQ4a2RoWjZ3N2RKcndRaFdzamFXUHV2eXBuT2U4Q0dKbnNJ?=
 =?utf-8?B?YlI3Rm80dC9vb3Zadzd2SVhwVEM0OXdqWFNvc2ZZWldDeWJtd3Q3RzBKbXdz?=
 =?utf-8?B?UTRSbjZ1RmZ4bjVmY2d0dmM0VU16amlVWjhxTUtxaS9zOVphbVRnSDBhK2Fn?=
 =?utf-8?B?L0RzOW5yZ0RXeURVVVBJTWpUVlh1TnZFSlZld1dwL3IvRGsweDIrbnFEendI?=
 =?utf-8?B?VWdDcno3WmpPQzMwUy9vcDVlK3NkYkxkTDhXb2g3VW4wWkFUSWdkc041TmVm?=
 =?utf-8?B?akhLWENDbUk0VEIvRVd3YzFkL3JzYnRtRkVScHlYU2J4MG1YaHJRREhGUDVa?=
 =?utf-8?B?dkZIQlBLeGltUGlmeFdnaHYvM3JRUUNCRmFBUkI4a3RyZk14R1lFKzJuMVlh?=
 =?utf-8?B?VTlwbFdGY2xkUEVPTk16bWZyeFpsTHF0c0pUakhUVUtxQUcvUzIzcU91KzN4?=
 =?utf-8?B?emEzQnNYa3NJZHJpUG11TTF6WnhQaXZjUFZwb2R0L3JmK1hmK0ZXampvNUdU?=
 =?utf-8?B?UXhLc0xCZExLR2NYVFlXc1llQ1hkd1llRGVxaTlQUkRJSlhwUzN3cGFDbmFX?=
 =?utf-8?B?MGgxZnVwSUNWYzdjQWltS0szU2RYd2FXUm9uL3JkVllrbXdqZURXUzVWZWdN?=
 =?utf-8?B?ckU4dStzdjdwVzRZVWdUOHl1OFVqbWdzUGRJRjg5Sy9wWVl5dXBnbWJaOEpn?=
 =?utf-8?B?ZldqQ3dTU0FzY3JiOUt5TTBtOXU1V2lxN3pHNlBaRVByaVRyYnRrWDkvUWds?=
 =?utf-8?B?eDhkMXh5V241ZlF1TXBEemRFTHRkcjYyUllIZUlZY2xlczhJRWhRRWxNbWdl?=
 =?utf-8?B?dVUyeUpqM0R6OXZ4VmFLcGhYYmREdkp3Um5hK3c3VTdHUVhjZWtnSE1Wc0VQ?=
 =?utf-8?B?RjdhblM0NGxvOGFQdyszS2MxZ0RWa3dIYXkrVk52ekJ6OHg4WFQyNmErbVJr?=
 =?utf-8?Q?H96pwOAFkX7rffR832V6QlPn6A+ihQImwuIGMrBU1s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df05ca9c-aded-4c3e-db55-08dc651f797d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:01:43.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dQiFiTa7BYErufyTx7yM+Vk0cZtPswuqXPBVAD4CoDY/wazS1zJ9A3hrkkRUUKOKYcn9sDlrJ8HWucu7WwIabaf0eKiyCa7UeEWeptY74g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3962
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C451DCC4851D84B94E30D9C125AAE17@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:10:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15765

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDE1OjE0ICswNTMwLCBBZGl0aHlhIEJhbGFrdW1hciB3cm90
ZToNCj4gVGhlc2Ugc2VyaWVzIG9mIHBhdGNoZXMgZW5hYmxlIHRoZSBzdXBwb3J0IGZvciBkZWx0
YSB1cGRhdGUgZm9yIHRoZQ0KPiByb290IGZpbGUgc3lzdGVtIHdpdGggc3d1cGRhdGUncyANCj4g
cmRpZmZfaW1hZ2UgYW5kIGRlbHRhIGhhbmRsZXIoemNodW5rKS4NCg0KSGksDQoNCnRoaXMgaXMg
bG9va2luZyBnb29kIG5vdy4gSSdsbCBnaXZlIGl0IGFub3RoZXIgdHJ5IG5leHQgd2Vlaywgb25j
ZSBvdXINCmxhYiBpcyB1cCBhbmQgcnVubmluZyBhZ2Fpbi4NCg0KRmVsaXgNCg0KPiANCj4gQSBj
b3VwbGUgbm90ZXMgYWJvdXQgdGhlIGltcGxlbWVudGF0aW9uOg0KPiAtIEluIHRoaXMgcGF0Y2hz
ZXQsIERlbHRhIHVwZGF0ZSBpcyBvbmx5IHN1cHBvcnRlZCBmb3IgdGhlIHJvb3QgZmlsZQ0KPiBz
eXN0ZW0uDQo+IC0gVGhlIG5ld2x5IGFkZGVkIGRlbHRhLXVwZGF0ZS5iYmNsYXNzIGhhbmRsZXMg
dGhlIGNyZWF0aW9uIG9mIHRoZQ0KPiBkZWx0YSB1cGRhdGUgYXJ0aWZhY3RzLg0KPiAtIFRoZSB1
cGRhdGUgaGFuZGxlciB0eXBlIGkuZSByZGlmZl9pbWFnZSBvciBkZWx0YSBoYW5kbGVyIGlzIHNl
dCBpbg0KPiB0aGUgdmFyaWFibGUgIkRFTFRBX1VQREFURV9UWVBFIg0KPiBpbiB0aGUgc3d1cGRh
dGUueW1sIGZpbGUgYWxvbmcgd2l0aCBzb21lIHZhcmlhYmxlcyByZXF1aXJlZCBmb3IgZWFjaA0K
PiBoYW5kbGVyLg0KPiAtIFRoZSBjcmVhdGlvbiBvZiBkZWx0YSBhcnRpZmFjdCBmb3IgdGhlIHJk
aWZmX2ltYWdlIGhhbmRsZXIgcmVxdWlyZXMNCj4gYSByZWZlcmVuY2UgaW1hZ2UgKGFnYWluc3Qg
d2hpY2ggDQo+IHRoZSBkZWx0YSBpcyBjb21wdXRlZCkuIEN1cnJlbnRseSB0aGUgcmVmZXJlbmNl
IGFydGlmYWN0IGZpbGUNCj4gKC5zcXVhc2hmcy8udmVyaXR5KSBpcyBwYXNzZWQgdG8gdGhlIA0K
PiBidWlsZCBzeXN0ZW0gYnkgcGxhY2luZyB0aGUgYXJ0aWZhY3QgaW4gdGhlIHBhdGggIiR7VE9Q
RElSfS9wcmV2aW91cy0NCj4gaW1hZ2UiIGFuZCBzZXR0aW5nIHRoZSBuYW1lIG9mIHRoZQ0KPiBh
cnRpZmFjdCBpbiB0aGUgdmFyaWFibGUgREVMVEFfUkRJRkZfUkVGX0lNQUdFIGluIHRoZSBzd3Vw
ZGF0ZS55bWwNCj4gZmlsZS4NCj4gLSB6Y2h1bmsgYmFzZWQgZGVsdGEgdXBkYXRlIGlzIG9ubHkg
c3VwcG9ydGVkIGZvciBzaWQgb253YXJkcy4NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gQ3Jl
YXRlIG9ubHkgMSAuc3d1IGZpbGUsIGVpdGhlciBkZWx0YSBvciBjb21wbGV0ZSBzd3UuDQo+IC0g
QnkgZGVmYXVsdCBjb21wbGV0ZSB1cGRhdGUgc3d1IGlzIGNyZWF0ZWQuDQo+IA0KPiBDaGFuZ2Vz
IGluIHYzOg0KPiAtIFJlYmFzZSB0byBjdXJyZW50IG5leHQgYnJhbmNoDQo+ICg2MWU5OThlMWUw
NTQxZTI3MTNjMDVmY2JmMjFkZjM5ZmJjODgyYTBhKQ0KPiAtIFNldCAiJHtUT1BESVJ9L3ByZXZp
b3VzLWltYWdlIiBhcyB0aGUgcGF0aCBmb3IgdGhlIHByZXZpb3VzIGltYWdlDQo+IGFydGlmYWN0
IGZvciByZGlmZiB1cGRhdGUuDQo+IC0gUkVBRE1FIHVwZGF0ZXMgdG8gdmVyaWZ5IGRlbHRhIHVw
ZGF0ZS4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVtb3ZlZCB6Y2h1bmsgc3VwcG9ydCBm
b3IgYm9va3dvcm0gKGR1ZSB0byB1c2Ugb2YgYmFja3BvcnRzKS4NCj4gQ3VycmVudGx5IHpjaHVu
ayBiYXNlZCB1cGRhdGUgb25seSBzdXBwb3J0ZWQgaW4gU2lkLg0KPiAtIFJlbW92ZWQgZGVsdGEt
dXBkYXRlLnltbCBmaWxlLiBSZWxhdGVkIHZhcmlhYmxlcyBoYXZlIGRlZmF1bHQNCj4gdmFsdWVz
IGFuZCBjYW4gYmUgc2V0IGluIG1hbnVhbGx5IHN3dXBkYXRlLnltbCBmaWxlLg0KPiAtIFVzaW5n
IC5zcXVhc2hmcyBmaWxlICgudmVyaXR5IGZpbGUgaW4gdGhlIGNhc2Ugb2YgU2VjdXJlIGJvb3Qp
IGZvcg0KPiByZGlmZiBkZWx0YSBjcmVhdGlvbiBpbnN0ZWFkIG9mIC53aWMgZmlsZS4NCj4gLSBy
ZGlmZiBpcyBzZXQgYXMgZGVmYXVsdCBmb3IgZGVsdGEgdXBkYXRlIHR5cGUsIHRoZSBidWlsZCBz
eXN0ZW0NCj4gbG9va3MgZm9yIHRoZSB2MSBhcnRpZmFjdCBpbiBhIGRlZmF1bHQgcGF0aCAoaW1h
Z2UtDQo+IHYxLzxhcnRpZmFjdF9uYW1lPikuDQo+IC0gQ3JlYXRlZCBhIHNlcGFyYXRlIHRlbXBs
YXRlIGZpbGUgZm9yIHN3LWRlc2NyaXB0aW9uIG9mIGRlbHRhDQo+IHVwZGF0ZS4NCj4gLSBSZW5h
bWVkIGRlbHRhX3VwZGF0ZS5iYmNsYXNzIHRvIGRlbHRhLXVwZGF0ZS5iYmNsYXNzLg0KPiANCj4g
QWRpdGh5YSBCYWxha3VtYXIgKDMpOg0KPiDCoCBBZGQgRGVsdGEgdXBkYXRlIHN1cHBvcnQgd2l0
aCByZGlmZl9pbWFnZSBhbmQgZGVsdGEgaGFuZGxlcg0KPiDCoCBzd3VwZGF0ZS5iYmNsYXNzOiBH
ZW5lcmF0ZSBzd3UgZm9yIGRlbHRhIHVwZGF0ZXMNCj4gwqAgZG9jL1JFQURNRS5zd3VwZGF0ZS5t
ZDogVXBkYXRlIHN0ZXBzIHRvIHRlc3QgRGVsdGEgc29mdHdhcmUgVXBkYXRlDQo+IA0KPiDCoGNs
YXNzZXMvZGVsdGEtdXBkYXRlLmJiY2xhc3PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA5Nw0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gwqBjbGFzc2VzL3N3dXBkYXRlLmJiY2xh
c3PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI3ICsrKysrLQ0KPiDC
oGNvbmYvbGF5ZXIuY29uZsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+IMKgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDU5ICsrKysrKysrKysrKysN
Cj4gwqBrYXMvb3B0L3N3dXBkYXRlLnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDUgKysNCj4gwqByZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dS9zdy1k
ZXNjcmlwdGlvbi50bXBsIHzCoCA1ICstDQo+IMKgNiBmaWxlcyBjaGFuZ2VkLCAxODkgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgY2xhc3Nlcy9k
ZWx0YS11cGRhdGUuYmJjbGFzcw0KPiANCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpM
aW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

