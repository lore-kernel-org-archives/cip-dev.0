Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C1C4345F
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 11:38:26 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.60])
 by mx.groups.io with SMTP id smtpd.web11.11307.1713945631864247037
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Apr 2024 01:00:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u1/eW89M;
 spf=pass (domain: siemens.com, ip: 40.107.105.60, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLi+6jbw93KSE+kaDiKbIwdOx9UFcgtF9j292FcsPvFneXqEbX9DOtew2KKNfjkevdHKEIchsMXolEa83wf/1+tS1MjAyr8dQg5bQkigBgJUpsuNDz2m6eQVCc93AtIaQvyBg0l/79APfikq5K/3OGDayry2nBNUbzc51ecQJuMqhku1VAJ6mLMS26xrdQ1NR9PHE44KBVvvgUZEU2C247uKlNFKyTVASrU/QbfBL6f/9OwZF0l7pgU7x2l2wViQXam43WMTy7s20LO6ar224VBLkHC4yVvCxDLduKdjQ6sCWeVwlGIMga3vpjGdP4oa4aOKsHy0uSJH8i5qcwcqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTX2JrXVfFeU/cqURaBQfQGfnQbvv9Z4BNNOI1AEItM=;
 b=XL7t+fpWZ/BBHpLEGzcBY9gnPk09c8KaTwywpcV+cIvEKWIXnVVRvmfMQFzLkzLGnx7AVrNB6lxxoB9odV11N8G7WR11N0EaLjx+/MjBMZXBAkl7ihtuiZOjG9Tc41dnHDMefqT6Nvp5b1QVH0gZouS32f/fkKO5PmVlCma0BGYJa1Zk8qJTUZT8AAJTauPiKt/Y1at85PlubvOvvnW0XTpcfIZRVSD5nu+pFHc1jLRZ1ib28W0DUhaa2tYO60u75JoSB6tOu1mQGWMCHYviUKkstzNorwV2gBMWZPnBpnEcdyKe1arrV3W3KxavkbgKy8Yc4LLNjHCHK0/URhMZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTX2JrXVfFeU/cqURaBQfQGfnQbvv9Z4BNNOI1AEItM=;
 b=u1/eW89MGWkRR+PX868mRAfH+V2ORDGIeilokZ5DjuJJ2oj1+sl7xBbHVl2Olg1NLXHBTAURp1wJcD66vRfSJxR+hmROEoUoAvFphhuqKJqi2I0NbdxfgtQpdUbY1r8rzQ8vOFBr1QhvR1kABcX3JTBkO06FdbrElYU3YQ9eQSxJ/BJ5NPBHiVVMt00wxJ01+D2LtdHTDZkodxuXD0hfWYZ65ei4bD5vzF1h5WLlWf47CWhqxvIfJ6Q5F3ksRS5L7JuI4ej62e10wxZqv88N+dL5XBog+XBqWf0W0nPiFi24NQL+7ZrjynGOGi77grHRJvBiJh37m2oGKHbMbk2arw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB5PR10MB7891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:00:26 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:00:26 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify encrypted partition
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to
 identify encrypted partition
Thread-Index: AQHalWGf3mtVU5Lzz0SMvFl7Y1ut7bF1n2cAgAFww4A=
Date: Wed, 24 Apr 2024 08:00:26 +0000
Message-ID: <ab7a2cfe1fe1cfed3111c95e06e06b8bec217ea6.camel@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
	 <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
	 <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
	 <69e0e19e-4600-4df6-b1f6-e159c71440d0@siemens.com>
In-Reply-To: <69e0e19e-4600-4df6-b1f6-e159c71440d0@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB5PR10MB7891:EE_
x-ms-office365-filtering-correlation-id: afb8ad2a-67cc-42b0-44bd-08dc643499ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UWd3OE5VTzZsZWkwc05IR1I1K09SanVzamdTVUkyMDUzRWpJV29oaFpGYmdw?=
 =?utf-8?B?WXBSVkhpK3g1Vmk1STM4YTBzNzY3SDNnUUhiM0s3dHFFMTJzdE9hbjlNNEZ2?=
 =?utf-8?B?NDd5MExORW1xZWRIY3N4SEtpUGR1MFJGSHJDTTFHbGFBMm44K3JMRTQvVXVt?=
 =?utf-8?B?MGZPU2grUU02S1VYaFpnR3FiM2J6TXZXbE1UTUl6bWFpcHNBcXFaTHlGMDh2?=
 =?utf-8?B?eU14c2xLWEhRckthZ2k2K29EZ1c1TlBLZ2twWGRrQSttc2dQU2ZZME1xNHRM?=
 =?utf-8?B?Njc1SmF3a2swMzRmTHl6WjRsYkJ2dmpndWF3MnptTFBnZTl1bnBmZHYyZnJD?=
 =?utf-8?B?eUkvb0R3Z1VnTjFLSzU5MmtIcTQydmVTc1ZpTDVWTXZxK0NKRStZdE0zdVU4?=
 =?utf-8?B?Z093a01TNTFEaDAyZndhMHhrQXh5cHhtUHZ4Mm02eVhiSGlwR1VqRExQdEF2?=
 =?utf-8?B?Y0g1a0ZJejV4cmN4Y0lMcG1aamNUVDlYbldsTzFodXJGK2VTeGlhbDFQNzI4?=
 =?utf-8?B?L3AzQmZ4S2hKbXVOZE1OVzNqT0JZaDB6NUdVS3MzN0lnV2Z4VkVCcGVWRzV1?=
 =?utf-8?B?ZVQ3QVUvYXA1aGhxcVJzaWR5KzhzQWhacElBTkJSK0FQeUhSWTFvYmh1dVJR?=
 =?utf-8?B?S1pMcFUzWFpxWmhOcGljdjlpUWZmWmlEOXQxWGtSZjFIS3FRYjVxSDhpSFRJ?=
 =?utf-8?B?Z1F5QmphL1RmM1dQUnlhd0NLNHdORmJGWkpHdzJrcncwY3FBSHFKeHdxT25l?=
 =?utf-8?B?Wi9hMzZ4SDJVb1IwSDNxRlFQTGdQQm5lUWpta3J4bEM0K0hiLzViZXhSekE4?=
 =?utf-8?B?aGgrdCtPbzNyUHoyclU0a0ZkUXJzREtEeXROZFFaNEEyVXhnYU04b0RrTWcz?=
 =?utf-8?B?aTdUdzdDN3VSdDJ1aGhheFJNeHlwN3YvWCtabzJZY1Jpend6SThQaVY4dWRr?=
 =?utf-8?B?SFhSVUFJdXpqWFU3Z2VzWUthbVVSdVBaWHBOQlcxMVFpc2dFQ2k1RGp1NFpo?=
 =?utf-8?B?UHlwaDlsWnlCZCsxRUoveXIwWlRXdjU3b1lrbTBPWUhvbUJBSjZvYXBWRnN0?=
 =?utf-8?B?TlF0cFkzd2c5THI1REJmYmJXWWdvYTFwRGR0RGZGSGhvb3RSRGFDQVlHREY0?=
 =?utf-8?B?V09QVVdRa0Y1WjArb3ZVUG1KeWNybDRUNTBhMytQWDZZVXliczNlZVhNbkdw?=
 =?utf-8?B?NXlFUnVDK1hsVDl4Wlp2K3BqTkhNeHpPYzhYSkN5NGpDRWloZGRHVmhVTVl6?=
 =?utf-8?B?Qk9SK0JqbUZnbzV6WlJhbHdwdWpjSnl2SDlzOGU3RkhISXdNQ1JjaER5OWNn?=
 =?utf-8?B?T0gvYjZiTndJVXl5L0NaM2NwTTdPaUF2a1dPNWx2TmhBVFplKzRpdnlLbGd2?=
 =?utf-8?B?OGRyWUx3RVFTb0lpSFh0YzM1MUFYOGZoMVhZUG5WYUk1ZFNUSDkvdDZaQy8r?=
 =?utf-8?B?VVRpSlN0aHBWUHZyWEVPRGQra3BjYkJ4YzJCWFVTZFhnb2tnRmoxWG5TTEtz?=
 =?utf-8?B?ZFJ2MS9JYXArTGEwS1RSMXZqVVYyWHpSN3JRU2lQZWsrZWJrR291dVRaN1Bx?=
 =?utf-8?B?cC9veUNZZEhOd0JjL0gwUU5jTm1tek9oTHhuTVdvZjRMMVNFODdVMDVEZnBz?=
 =?utf-8?B?UVhFdmxzeTF3UG50aVhyNUxRN1VRMFZjUFFtaVVVcjJJSjdGOUFaYmpWRnBk?=
 =?utf-8?B?UEp0ZHV4WDNJNnovd3BDV1RXcWpUWEwvUnBUN2tjTkMvVG85dGFRNVJybUI0?=
 =?utf-8?B?ZlpNQ1p1T0c5d080WUZNSTN0V3NXU3hVbWhXT20wbWR3S1ZBbWV1TmY1TURM?=
 =?utf-8?B?aGtzK0pSb3pQVUVjdWo5dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VnF3ZXJhSi9zb3NyK1k5aGhnbDJJaU5oYWUzalZUeVFYeEVGcXR3RExPcnlQ?=
 =?utf-8?B?d3JKNFFBT3UxWk5mdmRCYWlMc3BBM1ZmME1CUWhoUEs4WFRWWjRqODNTaS9r?=
 =?utf-8?B?eTIxa0R5V1NGZ0RrZGRJekxkTk5YdzNaM09rZzhlQjZsTHNmSzhELzU2Ymxa?=
 =?utf-8?B?VjRZMHpEd3RzQms5YUxMVkhhZGlhdEVGeXJ1QzdxVElqZHNoNEkrNG9JaHFQ?=
 =?utf-8?B?S3Bubyt2WnZ3SzJCN2ZoWnp1bXNVb2I1VkcraTZWNkM5VDBiTVlyd0g2VkNX?=
 =?utf-8?B?dEtBcVZVbzRhVlBBSXJJdTlMMXVGUDdqYUV4QjZPR3pwUlR6UzNNRERiQW4v?=
 =?utf-8?B?YTlQK2gwN2N1WFVCVFJpOE8vYWdSR2wvUVZQRXZINE5LcTJCVHE0VXBGeklC?=
 =?utf-8?B?NGUrczdES2tVT3FoU0pkbE1VUGVHV1NqaGE2SmlKVTdycFg1UHJBS2t6M3B3?=
 =?utf-8?B?c1FNUlN2MmJhbnpwc0VSZmtnUERvN3Y4NHhvMUJkRk8yemdqcGJVdUNvanpL?=
 =?utf-8?B?VklQeGlVS0UxYksycm91a0dhYlJrcENFSlFhVU43bWhQeEVkdExGa3d2U1lE?=
 =?utf-8?B?UnQxSGxOUU9scm9vQ3orWVFNdXFiSmIxandlblBTVzNvMzduOG1NQmpkTWRu?=
 =?utf-8?B?Z3hSbmVCeHN4RnZNbzVNaUx5d0NzN3NQQWRnUXBYK0hvS3dyTGdYNU0vUk9v?=
 =?utf-8?B?Sk1CT0x5amFPcjlucXZTemJXR203VW1nei96VXdsL1dwRU0vU0Q3UlNHblU4?=
 =?utf-8?B?TWwrWEN0bjBaK2RTSVpUbTFvSjBxSGFyaDI0UVg0OFJvMFkrVzJ1S0JhMmJO?=
 =?utf-8?B?dUJsb2tDRGprcXlnQ0diU0QrcmVUY05CTjBPM3lHNWlocGNDeHp6ckxHUm1k?=
 =?utf-8?B?NU9nSzdiNGFKbldFS216elVxT0lJUGVpOUpYVVBYVW5UMExqSWZrbG9ZYzZo?=
 =?utf-8?B?cVo5azhVb0lzWkVaQ2NrUnU3NG9NRUNNdlJDTjlTeHBrVFRsZVNKelJKeXV2?=
 =?utf-8?B?VUl1RnkzdlY4U3V2THpGaGc1Um1PZU1EbkdiQXM2L01kYzRqNlU1ajdlVUp3?=
 =?utf-8?B?WmJSWXU3U3F5dG1pSTdKaFdVdDdocU4vd1cveE5KL2RpWndNMnh3Sm55TWNt?=
 =?utf-8?B?bmxobHl2Zzg2OVFQZEpuMG9aWU1TZ2NKZ3dkTS94ZTBBYWlqWWNmeU1odmhJ?=
 =?utf-8?B?UDNOOVZsRnEveXp6TXMyTVRnSitUMXdyM3ZJTlJ0eklRekZnSFlWck5HUzZK?=
 =?utf-8?B?RTJIMjd2U2ppRzUxR3JGdWd6T0dPTURhTVlrYVRyWTNHVjdTcWQ1aDE5TnJO?=
 =?utf-8?B?UFlZMVN6KzlVdW4xTk51TWpoREtPQjFTQXJJQktIclRzY2drS3VIQ3QrNUVJ?=
 =?utf-8?B?dkN2VVNSckl6TFRsNmNjNzAzL2dPeitCVzc3ZWQyTWYrQzQvMkI5RWozTVRh?=
 =?utf-8?B?UHE3cG0xRGJXbFNONFZ5bStFNnBwanhubHZjeTg0dVlaVlhORzdjOEFUZzZV?=
 =?utf-8?B?VlNiU2hMTkRXQmdhelZZL3JSUjFFdnlWZkdJQkNFWXhtK3lZeGFoS0o2TkRa?=
 =?utf-8?B?NTZhSnNEcUNzY29ZN2l0eExJVENqOElPa3MrUGQ3RHUrRnFFQjB0RnVpM1dH?=
 =?utf-8?B?c0ZOOXN3TkUzNTB2Q01aMFN4N0ZRSHlNMnNmUSt1M092Z0p6MGRWWHJlQ2Rl?=
 =?utf-8?B?blEzUFQyRXlaa1N5d0lhUm0wSnhPWUxBM0EvcFhXQ21keEdnS2dYdURXYXdS?=
 =?utf-8?B?clZSUFVNRWtnMlRzeE1oWXE4ZVFlalpWNEdxWVNoVk1HYmxGOWZMcEwwYnBy?=
 =?utf-8?B?M1JXLy9MWkpJdnRjUEIvMk90T0hnMWxaYmtzRnF5SUdBZHNaaVJDVGpBM0JY?=
 =?utf-8?B?bzJPQnlSRjRzWVE1UWhKSFh5eDNmaUFuWnZaSlJzU3FieG5TVUp5YTVzazI1?=
 =?utf-8?B?ajNmSUp2VzhZbkFZTXBiUXFqSEVEckZHQUEyY0xFWmlUczcySHVkVUsxcWlY?=
 =?utf-8?B?V1pFR3pwSXQ1OE5qeWVxMDIrazhFcmY4bzE4RVBSRmZLM2lBTURqdFU4WTBJ?=
 =?utf-8?B?cmlVeUpJa1VydlJnRDRRUVFDWVVHYzhhRFJaYTI0OG9peWt1RlkveGgrdDJ2?=
 =?utf-8?B?aVk0VkZkZkZNUHBMMGoybzhUMVEzNFd5MHVKOEZZRFl3clJMZHRObklvZnRp?=
 =?utf-8?B?UlFIUjdpVTZJcWxOZXFxQVQ5dU1BdVByUyt3VzUyZG5ZeHA3bTJiakZIc1Iz?=
 =?utf-8?Q?Es+sclO1L8B/vzvpM4ztE7WhUufx7ks+bIfemZzBVg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: afb8ad2a-67cc-42b0-44bd-08dc643499ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:00:26.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWDhj6yDpAFYcnOinT9rtWuohHM7fJmQNYfdsR2zWs5k48woutqAinhqnenjOl0o/3rByWk5Wyci3IP2NyKCaXfiTxKfm9kvYDgsxz1FPfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7891
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA601C120F54B46A2AB63438BDA9664@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Apr 2024 11:38:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15744

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDEyOjAwICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDQvMjMvMjQgMTE6MzUgQU0sIE1vZXNzYmF1ZXIsIEZlbGl4IChUIENF
RCBPRVMtREUpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wNC0yMiBhdCAxNjowOSArMDIwMCwg
UXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiA+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4gPiANCj4gPiA+IFRoaXMgZml4ZXMgYW4g
aXNzdWUgd2l0aCBlbmNyeXB0ZWQgcm9vdGZzIGR1cmluZyBzeXN0ZW0gcmVib290Lg0KPiA+ID4g
V2l0aCB0aGUgdG9rZW4gb3B0aW9uIGl0IGNhbiBoYXBwZW4gdGhhdCBkdXJpbmcgcmVib290IHRo
ZSBubw0KPiA+ID4gdmFsaWQgTHVrcyBwYXJ0aXRpb24gaXMgZm91bmQgYW5kIHRoZSBib290IHVw
IGZhaWxzIGluIHRoZQ0KPiA+ID4gaW5pdHJkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiDCoMKgLi4uL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRfcGFy
dGl0aW9uLnNjcmlwdMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+IHwgMg0KPiA+ID4gKy0NCj4gPiA+
IMKgwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0N
Cj4gPiA+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0IGIvcmVjaXBlcy0NCj4g
PiA+IGluaXRyYW1mcy9pbml0cmFtZnMtDQo+ID4gPiBjcnlwdC1ob29rL2ZpbGVzL2VuY3J5cHRf
cGFydGl0aW9uLnNjcmlwdA0KPiA+ID4gaW5kZXggNTFjODFmMy4uNjg1ZDg4MiAxMDA2NDQNCj4g
PiA+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+IGhvb2sv
ZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc2NyaXB0DQo+ID4gPiArKysgYi9yZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9u
LnNjcmlwdA0KPiA+ID4gQEAgLTEzNCw3ICsxMzQsNyBAQCBmb3IgcGFydGl0aW9uX3NldCBpbiAk
cGFydGl0aW9uX3NldHM7IGRvDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBmaQ0KPiA+ID4gwqAg
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBpZiAvdXNyL3NiaW4vY3J5cHRzZXR1cCBsdWtzRHVt
cCAtLWJhdGNoLW1vZGUNCj4gPiA+ICIkcGFydGl0aW9uIiBcDQo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgZ3JlcCAtcSAidG9rZW4iOyB0aGVu
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwg
Z3JlcCAtcSAibHVrczIiOyB0aGVuDQo+ID4gDQo+ID4gSG93IGRvIHdlIGlkZW50aWZ5ICJvdXIi
IHBhcnRpdGlvbnMgaW4gdGhlIGZpcnN0IHBsYWNlPyBJZiBJIHJlYWQNCj4gPiB0aGUNCj4gPiBj
b2RlIGNvcnJlY3RseSwgd2Ugc3RpbGwgaWRlbnRpZnkgYnkgbGFiZWwsIHdoaWNoIGlzIHF1aXRl
IHJpc2t5Lg0KPiA+IE90aGVyd2lzZSB3ZSBtaWdodCByZS1lbmNyeXB0IHBhcnRpdGlvbnMgd2hp
Y2ggYXJlIG5vdCBldmVuIHVuZGVyDQo+ID4gb3VyDQo+ID4gY29udHJvbC4NCj4gV2UgY2Fubm90
IGlkZW50aWZ5IG91ciBwYXJ0aXRpb25zLSB3ZSBjYW4gdXNlIGxhYmVsIG9yIHV1aWQgd2hpY2gN
Cj4gbGVhZHMgDQo+IHRvIHNhbWUgaXNzdWUgaW4gdGhlIGxvbmcgdGVybS4NCj4gDQo+ID4gDQo+
ID4gV2UgbXVzdCBlaXRoZXIgaWRlbnRpZnkgYnkgVVVJRCwNCj4gVVVJRCBjYW4gaGF2ZSB0aGUg
c2FtZSBpc3N1ZSBhcyBsYWJlbHMgaWYgbm90IHVzZWQgY29ycmVjdGx5Lg0KDQpIaSwgdGhlIGRp
ZmZlcmVuY2UgaXMgdGhhdCBVVUlEcyBhcmUgKHNoYWxsIGJlKSBnbG9iYWxseSB1bmlxdWUgLSBi
eQ0KZGVmaW5pdGlvbiAtIHdoaWxlIGxhYmVscyBvbmx5IG5lZWQgdG8gYmUgdW5pcXVlIHBlciBk
ZXZpY2UuDQoNCkl0J3Mgd2VsbCBrbm93biB0aGF0IFVVSURzIGluIHRoZSBlbWJlZGRlZCB3b3Js
ZCBhcmUgbm90IFRIQVQgdW5pcXVlLA0KYWxzbyBmb3IgcmVwcm9kdWNpYmlsaXR5IHJlYXNvbnMu
IFRoaXMgaXMgc3RpbGwgYW4gaW1wbGVtZW50YXRpb24NCmlzc3VlLCB3aGlsZSBsYWJlbCBjb2xs
aXNpb25zIGlzIGEgZGVzaWduIGlzc3VlLCB0aG91Z2guDQoNCkZlbGl4DQoNCj4gwqAgb3IgYXQg
bGVhc3QgbGltaXQgdGhlIHNlYXJjaCB0byB0aGUNCj4gPiBkZXZpY2UgdGhhdCB3ZSBib290ZXQg
ZnJvbSAodGhpcyBpcyBrbm93biB2aWEgdGhlIHN5c3RlbWQNCj4gPiBCT09UX0xPQURFUl9JTlRF
UkZBQ0Ugb24gcmVjZW50IGVub3VnaCBlYmcgdmVyc2lvbnMpLg0KPiA+IFRoZSBlbmNyeXB0aW9u
IHNob3VsZCBiZSBpbmRlcGVuZGVudCBvZiBlYmcuDQo+IA0KPiANCj4gPiBGZWxpeA0KPiA+IA0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9wZW5fdHBtMl9wYXJ0aXRp
b24gIiRwYXJ0X2RldmljZSINCj4gPiA+ICIkY3J5cHRfbW91bnRfbmFtZSIgIiR0cG1fZGV2aWNl
Ig0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqBmaQ0KPiA+IA0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xv
Z3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

