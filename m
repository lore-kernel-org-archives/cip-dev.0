Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17121C021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 06:47:28 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.58])
 by mx.groups.io with SMTP id smtpd.web11.20181.1739537208150329234
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u24+vuqq;
 spf=pass (domain: siemens.com, ip: 40.107.105.58, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXy1Ww1zDqh0nd6iKAwT5GGeCtuRzIJL2VnYIm1tmsoyGKDImo4A67ZFefRkyyqlnWSwleC7WNzKxjxSwFho2ERSEepWOTiyVkOvyNap4iw9Lnj79UmNwruVel/2wLNdtfD/8bWX647mHVd8BSMxiTI1M//Xx2hmmGqKlHkzYeOxsJ73SWWFIqsoV7uTqbnllAMTmwTE1tmV5HQkUoVcOjThUfcCWCpD3+RatpKLqkG8Bfe8Lr7FuV8QA8C3rTDUGlayeH3m5eT3yGI1Idy2quI1zRJHB1BRVXL61Dhua73wQ8v6BNokiR/CS6oLUz90Uw4C5Lz9hxQNsdplB3EmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDe7KE8cvjli/IG8v1AYAdR6YzanFmbnUVIwvjgZ3qA=;
 b=PW0Zt+pSvwhtnSjwbL90qogwK2GTdjqeQlSwl2FLepb2OBFXk/kYeCfmOJjE4JhqjIOAkKdidnbQBT1KkxLUzyPqSqTyccLOLT0kREeHzb9Vhaq2bvQycMiej0gDR64bJ4D2oZa6zVKNSYw58o3oBw/MsCgazXiP8a/QWyvHwNLCi9ScSYnvPpSkAvujTMnbfz3bmlHi3mJrRCKMwLlFLvtEmPtDcDesDEJp4PfKwzy+9HfqjOtFdmKtwk9fMr90ew9o2gyEEKK8b+8RNBiFeVEfmDFb9KkmTJcVvHoKPilD4lEvhxkP5hOz29En7k2F1rNPqKfnTCdcGg7OQhW0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDe7KE8cvjli/IG8v1AYAdR6YzanFmbnUVIwvjgZ3qA=;
 b=u24+vuqqyqzBOPALJmY8Fqm82V72+ezyF3euPct1MBfTTHkbUCgvcOtZTfHUGSB4mKv7rT0RhhqkJGMPqJ0sgePY/FPOQY22SpJ1BG+LG5UJHH4Oc973jhol5Aa8QeuoyTCuwKIoSpZM1D4x8Bt4oZrwmCPs/+Dfs/2IpAL/+EKBjrZ2LQqlTAVmCrCQNF6CYZqFPDobSlHcaF4dP9Ug5BnV698kYtQooJMfDxa9b0rcSrBAtdhV1xgdRIKKQ8zwaxOP1plnUo4/2YanBuYAwQiJioR3WOej9IPxerDhIZW45X9fHoAKghr1rQE4W4MyQ6zSLtbKn914VKPwVJkldQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB8PR10MB3177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.10; Fri, 14 Feb
 2025 12:46:45 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%6]) with mapi id 15.20.8466.004; Fri, 14 Feb 2025
 12:46:45 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][RFC 1/2] wic(ebg): add support to add verity env to cmdline
Thread-Topic: [isar-cip-core][RFC 1/2] wic(ebg): add support to add verity env
 to cmdline
Thread-Index: AQHbfttRSyPubRvUnkiEK/DEqAT7jbNGur+AgAAEiAA=
Date: Fri, 14 Feb 2025 12:46:45 +0000
Message-ID: <5cfefb4ab19187342c1252d4261d2366e0f437bc.camel@siemens.com>
References: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
	 <e01b7d05-1be3-4189-a8d2-2efbc2733bf9@siemens.com>
In-Reply-To: <e01b7d05-1be3-4189-a8d2-2efbc2733bf9@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.55.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB8PR10MB3177:EE_
x-ms-office365-filtering-correlation-id: 449c506d-a388-4eac-1245-08dd4cf5a383
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RENoSVNSTGJaVldFNzRaYkl4K2ZsQnlPUXBkYlkwUDVtMVJ0cENoY2FqQTZo?=
 =?utf-8?B?czJUbTErd0N1N1hCQmVoWk5pc29mVDZ1eWRKcEVFZ0JkSzFRUGhmMFJiL2FK?=
 =?utf-8?B?NU5SMnlJRkUvbExPNVIyQlJweVQxN3h2TXNseUUrak52WkhWd0cwVEM4eEd5?=
 =?utf-8?B?UWJNQjJURVdwUFA0ZytnZEpXOXVVZ052MVZiTXF2M0srZWJLejlLUFFiSGFS?=
 =?utf-8?B?ZTMyZmRZdXdrbkR4MkZPeXYxWEtsc1Bid1ZwRnArTVNnbHRiSUh5bXJPTFQz?=
 =?utf-8?B?bm95K093cFMyRnlHaWwrTUlGdEkvUTJLc1hhcG12ZmhmNmlFL1ZtdTQvOFpI?=
 =?utf-8?B?SXRpUGZkODVDQ2YyTFVSTjQzc1FSQmc0ellWL3UzWmhJTEdlSGxVd0RUMStY?=
 =?utf-8?B?S1RBY3ZzMXlmY00veVI0V1p6eXhwZHEvRzRuVDlIdGdsOWFVR0JxS1JkZEUy?=
 =?utf-8?B?RG16NStDL0lJTE5XcGduQkFWNHllazBVUm83SDNUUWlaaGI2SmJNZ29RbWkz?=
 =?utf-8?B?Q0lFUHkxdlhGQ1hoSkczRytZMTVqQ3hkbjdvTUNlRmFSRmdFUDJSVFJqWDV0?=
 =?utf-8?B?WEZpNnMxWUtkK1B3OG5XUDV1dWxxWkdwOVN4NXNSNG1LcnhUT2NvL1h1ekhT?=
 =?utf-8?B?ak14UTE1TSs1Tk9qdkEwSzVjYVZlekRQTXJIUXoxdUlmeklxM1dhNmw4bGpm?=
 =?utf-8?B?eWZEekFMdmVhVXZ3QzJ3NTA2dXpUNUhGMThtVHNDWm5Oa21jazJsSTl5bTBI?=
 =?utf-8?B?MXg1NWh5QVJ4NnFBL3l0Q1NkY3VvVFdWMmEyZ2ViRElNaUVyVjBtTmhGSVo4?=
 =?utf-8?B?QjJtTVV1ODVKSUV3Vko5bUZoeUFyNW9yU0laSzVQY3RVaUQ4L01XTktiOEdr?=
 =?utf-8?B?TEFHUFo1em0rOGpzRlFTVE1zb2NmSGtxZndlT3BqZUNiRlVkcGdCaFpmQ21H?=
 =?utf-8?B?cHgwM2lMMFJnbU00WU1RT1dyWk5nRnVjUDFMaGc1R1UrOUZLL1ZvbGd0bncx?=
 =?utf-8?B?OXVFc1IvdWI2ME1aYm5RZ1lFTXhVOWxGZ085dHhnbC9pN0ZlTEdJc0RFb3VV?=
 =?utf-8?B?bGliaDRiR2JrL0RhRVVxbnBaU0k5K1Z2R2dYcnU0TmkwK1FwNXFJUENWV3Nm?=
 =?utf-8?B?eS9US0RtOWk5YTRJY2l4NHg1NXEzTXBSN0MzQndQcDJsVmxObG0rMHBqZEJn?=
 =?utf-8?B?bTlwUExnaENQR3JCd0x6WCtUcDZ3c3RRN3BQcVd5bC84TzI4WjhiMzEyUGdK?=
 =?utf-8?B?ZzBrOUY0VGpqdkd5MUo2VG03dFVESks3K2QyWHcrNlhBZnd4RVZtQW5LR3JL?=
 =?utf-8?B?a1d1ZGRHQmhJNFBmRmpYSUl6VDk5VDlsa0NZWk80UnhUbDVZaVJSWmZNRWFh?=
 =?utf-8?B?b0RwRGtiUFlkOEMxd2VmcTNEb2RnOW5Id2kvaGJVZ1RWRkNHWThsOEdIZjdw?=
 =?utf-8?B?T0pFRnpFQmZRMWFiWkJjd0dLR0tOeC9BcUs2NXdudWlMa25RNzg3SGs1ZzhS?=
 =?utf-8?B?em4rd1dETmttaEx0RW5DV3RNM2dKWkZyZlVnNWwzWjViSVh3ekRFcytGQVNV?=
 =?utf-8?B?RUVDdnI4MUpxeTQ1T3doK1pCL3F4TTZTSGNBTlJzQWsxT0ZMbTZRM1VTRnNO?=
 =?utf-8?B?QWNxRTdjNXJQS2lmaEQrc3dkUk14RGhHbWkwdmJnd2pmSjNGOW40Ukowc2I2?=
 =?utf-8?B?b29DK0puZlJkZmVGZGM0YWNUZjlFaG8yanpmVzBFanVGSWVHSG85VXAyV29n?=
 =?utf-8?B?bU9OclJZZ0Q5ZC9TbUxiRW56bDJrOG95RGxVb1ZDUlE1WjFpeWZmbk85RVlY?=
 =?utf-8?B?ZzgxRUtBVnMyUHIreHFMbU10NWEvb2lHdWxqTlQwQnBpNHJwUjhhTngxNnhC?=
 =?utf-8?B?YmNFRkZwWXQ1RGRDcUhwZ0FRK3duUDJKMlhFN1dmU3hHbFFMNWpYdHpYT3BC?=
 =?utf-8?Q?lvIkRDc7B4QgNWh7K7Id+59OHIp9LeGV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UHI1bnFaT0RGRTVoZjRGTmN3cTZveDNQbHlIaDdIM0pGblJvb0lRWm1DTG40?=
 =?utf-8?B?NTkxVkppcWc0S2l3MkdmM0E4cjVBQjdmbXVLVFV3cFZaYk94RisvUTNodXhx?=
 =?utf-8?B?MUo1blFkZ21rditvS1UzbWdjSFpaeFVpaDNYamE3QWRFR2lxV3JyM250alJK?=
 =?utf-8?B?Y0M1RjRZWFc1MTdCUmwvaEh0THdzMnQxVmwrVVBJc20za3M0bjhZdWpvU2Nk?=
 =?utf-8?B?eCtZOU51eG96MTdyTFVBckFNZHViTXhZSUkzbi8wZWFXaXRPYVJteXdBMnRG?=
 =?utf-8?B?SUVTcWhjbU9FRVFaREo1bjdUalJEMG1jbDhTanZTRGhLVFkxZk13Wm1sT2Nv?=
 =?utf-8?B?QzZOb256dGFTMlRDN0ZzaUlDVWx6TWwrNTMzcXBHOGthNnZQZGdRV1gvWTdC?=
 =?utf-8?B?WkIrdHFBY3pZOE9zcGI5YlFsUEp2OTh5dXdPblhXbS8zNGNlOG51dUdsaFlt?=
 =?utf-8?B?RkxKeGZua0ZMYXNMcGlEVGhSRlNxVm5JemRUWE4zNWpoT2xpUERma2xFeDl3?=
 =?utf-8?B?eVVQdjVYaU8vTkZyZHJ4VnFjTDBGOU9GcjEyamJodE9ObVYwRU0reTNxN1BF?=
 =?utf-8?B?T3VrMDNibnFpcWdhVzJ4TUtXWjRuSGNnZkNmT0NCVjZVeWx0SlFJa3ErT0Zx?=
 =?utf-8?B?S2dxaElJRWpwV1EzWW5WVVgydTQvOVRZYTZvbitYREN2YmxlTkhMR0M3NEdi?=
 =?utf-8?B?aFFCNTBvN1lNcUR5TVBCaUJTbkkrUGpYOVcxOEo1Rnc4NkJ3TklCeDNUSWlI?=
 =?utf-8?B?UGZtTjNBSnBoUnBoYy9lOVlVeHFXdENTQjNOcWpBMHBiMUFnYTdqenVkNzlS?=
 =?utf-8?B?T1RXZTArZUtBdFRmTGdmeVJYdW43d3htaHMxR2FvUEZVUUtmVnlsaU95Nisr?=
 =?utf-8?B?K292ckpWTFNhOGRyN0dpQXFyYnlmQXJFbS9jMlMyVVB2Mysra1o4YmxUVjc0?=
 =?utf-8?B?eUpwdVJ1TWIyV1k4d1daeHg0RmJTdmdBVVl5aFRBREo1QSswNDUxbmtmVTEy?=
 =?utf-8?B?ZkJ6SDBqUkxPNGxKUmtVVFRXVmFjaHE0dkQ0MU5jNTU5Y2hDUE5EWVJ2NXpP?=
 =?utf-8?B?clVCQ3Rqc0Q5SHhJVkhpZEE5Q3Njdm52WGVlUUFTaWV3b0R5NHpLZ2NLUVA2?=
 =?utf-8?B?cWJIWktPQUY2bW92aFBiYW1QcnlNNnc3N1YzR2I4dFV2S09RdC84aCszU05N?=
 =?utf-8?B?Q2d2TXRWM3prVVZsSXAvZ3lVc0RQQjE1S2NOSUJ5SmhFM3BHdXJvTEZ1VGtr?=
 =?utf-8?B?L3JJZjIwbVdUTi9qUzFmc0haaEVQT3pKMEZtL1c1bDlCTlRtbm1FMDBna2Zs?=
 =?utf-8?B?RktaSUd1THIxTFJ0QzhQRFd2UGZNc3V4NGQ5SENON1NseG1uN2I4bTBVWUVV?=
 =?utf-8?B?b2tJWlNVQ1JRWUp5Qm5odkZNZ2F0WkFDOEtwL2pWSmE5alB1dnRDdGxBcy9m?=
 =?utf-8?B?anZBSXJzblMwQ0FyUnIzMDJNWEk3TlRnbHdiY0dJL0RRd2M4d3dSZXlzU3VN?=
 =?utf-8?B?VldYU2R3dGZTbmNoNjBXSlk1UG5vYnBRMEYwb1V3Nitla1JBY0c1azBGK0pi?=
 =?utf-8?B?QkxUTXJYR0QrUjhJT1JKOUI3NXBEY1k5ak56UU94dDI1UWZSTFBHNGwxeGRv?=
 =?utf-8?B?aDBMY0JFa2VjZlhKR3V5RFNMZE9QUHNIa09NdlA1eHcvaVEyZ00ydUtBVjhu?=
 =?utf-8?B?K3l4akU5YUV2QkppTHVDM29Nd2ozODNwY3MrVnJnN013alh2cHVYVy90YTUr?=
 =?utf-8?B?Nm14cC9zRnl0L2hCN0hhTFNFR1RIUGNldnZFTVg0NzV2akNzTENMZG1HRExT?=
 =?utf-8?B?REpDNGhPdjk0SmptWDV4bzNyN3JjN3lLZ1hFcENsOVFicEtRdER3dWpXd1Jm?=
 =?utf-8?B?bHd6a1RFU2RMbTgrV2luSkFHQ1BESFlpcUlGOVRVZ0lEV2hLOTFBQlFpYWVK?=
 =?utf-8?B?YTFOOWFHenM2c1hhdThWZXRmUllaanZoTDdIVHd6dGVtdEE2NDlhcjRZNFE4?=
 =?utf-8?B?RjFRL3M4eWpXU1RWeit4dzNuQUljaVNjYTkvdUlSdDdsK2JHeTJSTmxBWXhV?=
 =?utf-8?B?SlEvT3QyWUYxcHVYTU1aN3BTa3REbXNmODRlaUNvU0lEc0JwZk9GRWR2TXdZ?=
 =?utf-8?B?M0tsVTRPYmtBSzRUWjNCbTFDMGlqeXJUVmt0N3dWNGVCWU4zalBIR0JPNVkw?=
 =?utf-8?B?eWsyKzhkQTEzWTJNZ3B0Ykg5ZllXNjYra0NnL2xJRnVZYXd6dUlBMmtjYlQw?=
 =?utf-8?Q?dVJX2LFIZ/rw693LA1jZkIZo1L+HbNp3nBdunYy7Ww=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 449c506d-a388-4eac-1245-08dd4cf5a383
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 12:46:45.0191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p1pl6s8l0zFs8ZrBi8GBLRii7mCQtiaxWahX6M+a4RQywWMv8cpZK0myVTkZGkb13oHzK6AkOCyvBs86TtKx++rriJ/JVbqtx/qt/w71ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3177
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3246C93D976E5246B1E51624B0639C16@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 06:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17851

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDEzOjMwICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxNC4wMi4yNSAxMzoyMywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBQYXNzaW5nIHRo
ZSB2ZXJpdHkgZGF0YSB2aWEgdGhlIGluaXRyZCBoYXMgcHJvdmVuIHByb2JsZW1hdGljLCBhcw0K
PiA+IHRoaXMNCj4gPiByZXF1aXJlcyB0byByZWJ1aWxkIHRoZSBpbml0cmQgb24gZWFjaCAoYml0
d2lzZSkgY2hhbmdlIG9mIHRoZQ0KPiA+IHZlcml0eQ0KPiA+IGNvbnRhaW5lci4gRm9yIHVzZSBj
YXNlcyB3aXRoIG5vdCBiaXQtYnktYml0IHJlcHJvZHVjaWJsZSByb290ZnMNCj4gPiB0aGlzDQo+
ID4gY2FuIGxlYWQgdG8gdmVyaXR5IGhhc2ggaW5jb25zaXN0ZW5jaWVzIGFzIHRoZSBiaXRiYWtl
IHN0YXRlDQo+ID4gZGl2ZXJnZXMNCj4gPiBmcm9tIHRoZSBmaWxlIHN0YXRlIGluIGNhc2Ugc29t
ZSB0YXNrIGFydGlmYWN0cyBhcmUgdGFrZW4gZnJvbSB0aGUNCj4gPiBTU3RhdGUgY2FjaGUuIEZ1
cnRoZXIsIHRoZSBidWlsZCB0aW1lIGlzIHByb2xvbmdlZCBhcyBvbiBldmVyeQ0KPiA+IHJvb3Rm
cw0KPiA+IGNoYW5nZSBhbHNvIHRoZSBpbml0ZnMgbmVlZHMgdG8gYmUgcmVidWlsZCAoYWxzbyBw
b2xsdXRpbmcgdGhlDQo+ID4gU1N0YXRlDQo+ID4gY2FjaGUgd2l0aCBub3QtcmV1c2FibGUgZW50
cmllcykuDQo+IA0KPiBUaGVuIGxldCdzIGZpeCB0aGUgcmVwcm9kdWNpYmlsaXR5IGlzc3Vlcy4g
VGhpcyBjaGFuZ2UgaGVyZSBkZXN0cm95cw0KPiBhDQo+IHBhdHRlcm4gd2UgYXJlIGFsc28gdXNp
bmcgZm9yIGFicm9vdGZzLiBJJ20gbm90IGEgZmFuIG9mIGRvaW5nIHRoaW5ncw0KPiBkaWZmZXJl
bnRseSBvbmx5IGZvciB2ZXJpZnkuDQoNCkkgcHJlZmVyIHRvIGZpeCBpdCBmb3IgQS9CIHJvb3Rm
cyBhcyB3ZWxsIChhY3R1YWxseSBJIHdhcyBub3QgYXdhcmUgb2YNCnRoaXMpLiBBbHNvIHN5c3Rl
bWQgZW52aXNpb25zIHRvIG5vdCBoYXZlIGFueSBoYXJkLWNvZGVkIHJvb3RmcyBkYXRhIGluDQp0
aGUgaW5pdHJkLg0KDQpBcyBvZiB0b2RheSwgd2UgY2Fubm90IGFzc3VtZSB0aGF0IGFsbCBkb3du
c3RyZWFtIGxheWVycyBoYXZlIGEgYml0LWJ5LQ0KYml0IHJlcHJvZHVjaWJsZSByb290ZnMuDQoN
CkZlbGl4DQoNCj4gDQo+IEphbg0KPiANCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQg
Q2VudGVyDQpGcmllZHJpY2gtTHVkd2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdl
cm1hbnkNCg0KDQo=

