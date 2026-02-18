Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D16E9A03B
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 05:01:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5768.1771390860517353969
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Feb 2026 21:01:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=DDkV7A9G;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1771390858;x=1772600458;bh=t8VuXv+WFDy3Usy3HmW1vr7l9qEataoLC4raw
	5ujrdc=;b=DDkV7A9G/kAREGvrQpUdZr74k+hezcWu29nTnGcYYEpgh4eTp/kXjpONKgwikVmFY0d
	lMWw1J3XB8OIOlXC0bVsDSijn5Lb0Z0xRd7G/eTdCvb3rL472xULr2D+uK6TVTPki/MOo2yNj4aBB
	88/i1MHIQGlRYFXvDHD8X6GwRAMD2uja7UIOZz1G14HhqEWU7VJi7ictFzyDDCw28gbhiVOFJC280
	KnlMcMuZ/IeqOAPKYE2a2QiumVChxtpm2APqS1BpzDFAqZ2yMOoPGFEeoGvcmLPYe5WhRdt9aW1DW
	DFkusbBITOMENl198Ly8xiRj4tw2hrGPZ2gJdsoKGhNg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 61I50vG23900259; Wed, 18 Feb 2026 14:00:57 +0900
X-Iguazu-Qid: 2yAb9zgpPJUGah6z8Y
X-Iguazu-QSIG: v=2; s=0; t=1771390857; q=2yAb9zgpPJUGah6z8Y; m=XESg5A8xnY/V5mrEsgwbvwBtlORRUCRK1G6+RzOs8ME=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fG48n0WqWzyPd; Wed, 18 Feb 2026 14:00:56 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8hszJCthcj+WRUlzDSCyTGWKjsb2kIdsLhPW3u7p4YfXVDTNlYD5ZUu6ZUcxpF25AWNp6BoJCFEbi97V/7+rzHTOWY5aX2BQVNHg2N1WtnNxu2w3ZcrSVle+m43xZ8yo6yulJZEJW9bm1wZGvmBoAYlVms5EH+fvnT2X0zgqLYvSjTmBmlbtHP3w9vc5lWdIkBcqdc4wQ6k7haYJ+AWYCgSJTf3okcOuFzthMp16rznqfe2Jd/pNevuL4HIpQ3XGkGjS7W7pRrHPn33z/DmXHcWBT9KxE+akeIF/vPuGwsfvwwAOToTYRBdbOp4YyKdoo67Rlvkj5CSzP+PreM+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bZ+YBkSBj/u2T7mYudOCD6+m182fr/dblX5jgO4PqY=;
 b=fQWIxYjat8riGP0iFcXTD7hf8LI1GmbGBNUePcA02dRYI/JkvU2tehi2K71+ez2DM2R/kspE5TzppmvqrkGrlQtxVPkNifoSR3BtXcBZ8HefmmI56wr/oV/X7noIclVKChaPlhLwCDx7AE1xmQQQILmsBRIlaj9Bh97sRP2XS/A7EmnMd7klQG3TCix4gCbRksdVhdIoH3Nuj5DFeUWYHDC0EXaP8wisruJxOgV6wOyqRP8IM+GGIsdZMGuSYBgKXgEgyhWiLru0NlS/cfgGqQo4gqwi6LW6tRnteIQdQw/lEaEoZeP1vfuZiB2HNZrToElCCd+0cpOwMjKWVAKcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add RZ/V2H GPU support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/3] Add RZ/V2H GPU support
Thread-Index: AQHcn1eDToJ3wrtS9EuwjJeSdKqcWrWFsoiAgAI1bqA=
Date: Wed, 18 Feb 2026 05:00:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F7B327FA2C4239F0B6B9CD6AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
 <aZNszwTG0dY27FJa@duo.ucw.cz>
In-Reply-To: <aZNszwTG0dY27FJa@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB16226:EE_
x-ms-office365-filtering-correlation-id: 9dba3d51-58e7-48a8-5982-08de6eaab212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|14052099004|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YTNSMVFVSVZ5L1R2VkdxNUtsTmEyVkpUTzM3bGV0WU5PVnh0UGF3T3ds?=
 =?iso-2022-jp?B?MlpQSTRGRjhzVTBQTWtkMjErdFRhMDlrQTFvQXBWa0JOM01JUnlJa1Nq?=
 =?iso-2022-jp?B?UGh2U2dVWkp2ajBBcVRMMEhUM2FKdnRvVTVlYW81TmFHQ0FCdENiQ2FK?=
 =?iso-2022-jp?B?ZEFjdk9XcUtrUWNJWGs1S2JqM3hKeG0xUTZIVktqUTQ4cHc4dmJRT1Yv?=
 =?iso-2022-jp?B?S0swVzlEa3EvSGQ1aXJiK2x6bm1WSUpiWEd4MXJTT0lIelU2aHNWdVF6?=
 =?iso-2022-jp?B?c2cvNGt6VXR0Q3dodk5rQ29MRVVkbFFnM3JVV0ZUUFBJbDEydzIzQTVy?=
 =?iso-2022-jp?B?S042dEdHcGt5cjNzNUU5RnNvOU9LOE5Ra0hmSFgrS1Q0ejQvUnc5TzNI?=
 =?iso-2022-jp?B?V3ZBdXViaFI0NjlTZmVCcE5VaW82WVBtUTRRUmxhMXZGSlQvL1VlaUxX?=
 =?iso-2022-jp?B?T3BVeVdLODZXcFZSUlh1WXFteTlMNWVvMVducFpZY2NjNENtLzdpZWlm?=
 =?iso-2022-jp?B?UUxmZURYcTY2cUhuOWRzWnRGcUVXcEtGVldnNERtZTh6VGVYYlVPYlAz?=
 =?iso-2022-jp?B?TnkzNXZlVzdFV01TdTZzekVNVEZQanRXOGY3eWRER0toV3UycVVoYnho?=
 =?iso-2022-jp?B?WG15ZzlWTFdOOXZEcU40OVF6UTd2emZZeVljVFY1SFVzeDQrQmU2L0t5?=
 =?iso-2022-jp?B?SnU3UGRxU0VmRElJTGg1NGRVdmV6cCtnK0hGRXJtRllPa1kyWXQzVjR3?=
 =?iso-2022-jp?B?aG5iaHVzWHdpeitrNDg5QWNObVo3MURHekRLN05aK2tWRjRUUE1LMWJz?=
 =?iso-2022-jp?B?RjVmL21iSUhTbUxjQnpjb2t2RjR6UzM3cUdYTGRFR2JEMHJBcEdWd2RQ?=
 =?iso-2022-jp?B?QkZjVm04TEYzT0d3M2JpeEtmMEdibzhtTWREVStHdHdxTUdEbk04YXIv?=
 =?iso-2022-jp?B?U0VXNC9CTWhiVzdld05aN1VnaUVKUURjelNBdGt5ckZSbElnMld5NnYr?=
 =?iso-2022-jp?B?Q1JscGFGRGNEdExzUWNCSVNrdERGWjVSZnNUNFdoZmxybjRDTEF6aGFt?=
 =?iso-2022-jp?B?UnVTVGtrVFMzbWcvZ1ZlUXQybXI0bnlzeG5BV2xBSFhvamh3bStydDA0?=
 =?iso-2022-jp?B?Qmlza0lCVUJRY3FQbHFyamZ3cVZvdGhzTzIwSml3ZWk2Y0xkVllSRkNM?=
 =?iso-2022-jp?B?NThKaFJhMFZzbmtPLzlLSjBFYTM1UytuZmp1Q1pGOVZvMWxQa1pYc3NW?=
 =?iso-2022-jp?B?d0FpcEV3Ti9mQmEvTnQ4VXNOcngzRkVVOE9qZitSNXFpbWh1ZmJyL0N6?=
 =?iso-2022-jp?B?MTNoQzl5dDM5M25adkduVVlPWmRMUElKYTVOcVo4eGIvSXlHVk9KTG5n?=
 =?iso-2022-jp?B?Z25Dc0lmMmpiR2dLNFpMZUdxNVh6OGZHa2NhQTQ4aEt4NEFwTXQrS1JV?=
 =?iso-2022-jp?B?bWxzdEE5K3UrVDVURk9xSExGSkZYRnNMczB2NkM4WUxlVzFFWTBNSDFi?=
 =?iso-2022-jp?B?WUx3UTFzWmpseVdiV2t0YmdRNVdLc3k4Z1Z6aE9KcFR6OEVQWGpjQk1B?=
 =?iso-2022-jp?B?N2xsK3U0RytCZzk2SXJ5NFR1cGVKZjFpMGo2NW9WMUcxMm1UZUt5SHR4?=
 =?iso-2022-jp?B?OW0rQklzSksrVWdJSWdOUVFES28yaG9CTEtPaU04cEVMVWdCd0pSOFFL?=
 =?iso-2022-jp?B?dnIremI2U1FNVFU0Q2hjQTBld3J2OHNJTzFNMDFhYnBqbDhKNldhekRq?=
 =?iso-2022-jp?B?WldvZ0JaalI0ZldZbk1mcnZvMDhvenlleGljWVNIaWFyNUlkKzc3bWIv?=
 =?iso-2022-jp?B?dk9Qc0NrSGwyczZ5M2dJWDNvVU9EdlFzUjdFUU4wLzJNSlJVZnB0MGtj?=
 =?iso-2022-jp?B?UHJ3QWpmSTQ3WXRLTEZZTk5wTUd6Znl3ZnV2U0dhWUVYNGJiaXA1OCtt?=
 =?iso-2022-jp?B?RzN3K1lUSGJFY1pkT2J4UTNHSnc0VXlXTVlObExpNEZoSDhmbmEzMEp6?=
 =?iso-2022-jp?B?aytiVlJEd2ZGVjZ1RmI0elFZV0xkcGkxc0xXRmk5Ym9jaVA0TDNQMHQ1?=
 =?iso-2022-jp?B?bXA4OWFkMjltczVjcGQ4Q0NMYzJpRDhrcFROU0FZYmFDOHM0bWx4Zlkv?=
 =?iso-2022-jp?B?aTRKUDBvSGFrWWtwN0E0a0VzZ2J2OTgwS3Y1RVplOXZ1dTdpMnNHdllJ?=
 =?iso-2022-jp?B?Q3RwUnFjTWZiZ2RKS2dQayt3ZFhuSWFLUjlxQU13cEUzb0tDQ0RXNWJL?=
 =?iso-2022-jp?B?dU9IOFkwcWY1RVAzSEpEQWFFSkI1UUJBVks2dUFzMmtyZGtlT0h0ZTVB?=
 =?iso-2022-jp?B?dk9JOU03RWdVNnRaek92WVNsNkEva1NSeUR0QXBjZE5OTnFRcExLQUsr?=
 =?iso-2022-jp?B?NlpSakU9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(14052099004)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUsvRHUrUUc5dHRZcEIxNmUrWjNybTJlZHlZZ2ZjcVkxYlVlTW9zclZj?=
 =?iso-2022-jp?B?ZjNyVWYvZU5UZzlIUkZoQzhvaXh5ZzhvVzJXbUo5ek96MUp0WTF1WENG?=
 =?iso-2022-jp?B?ZUo0R1pWaStBMWpOcHZUdFQycDFYMi9LUEo1Q2wxMGRXV1dsaHkwSGVj?=
 =?iso-2022-jp?B?VDNOS09xT2lyWEZOTjBIejhPU2w1VW8vRStTMzZ6WkN3aUNiL3EzTjRx?=
 =?iso-2022-jp?B?aktXRThhYTBueGN5czE0YUw1ZUtwVk9vZlltdGVtMFE0MTd6MmhGbkJ0?=
 =?iso-2022-jp?B?WWtwU3haYlozWnZkdTJWbVpLYU1sLy9EUFU3R1VYaU5UMHB3ZUY1Nytr?=
 =?iso-2022-jp?B?Rlk5K3laQk04Zi9wa2EyZ255QmtEOUNCNTF1MjhIdzUwanlRWWdrdkh1?=
 =?iso-2022-jp?B?NWMwRDhRMW1PSlRRNEZMOTVTazFoNmV2UUtnUEZORzBPNzNkL2tBTWQ3?=
 =?iso-2022-jp?B?S3FNK1FZRFdDL0ZTVEQzdFd3OXBMZU1HakdhVVZMTTJjWHpCaW1aQllD?=
 =?iso-2022-jp?B?WCswKzdYVVFveGozQW1td1MwcDhyeXpyV0NpY2VyTmZyNzM0Z3V6Vm5a?=
 =?iso-2022-jp?B?RUdETGtlQXd3NGpxQ3d5dmRmSWFMRFF5R2NmZ2h6MzZZcHNLbmw2Q2Fv?=
 =?iso-2022-jp?B?N0d2NWNYcFNEeFp5ZUtxK0MwRGdMNHZGZ20zdDJ3cjhvMjJ5MTQ5MjhS?=
 =?iso-2022-jp?B?cUlPemtCa0hETm00QmtadHVjTG9TOWQ0WjNUanJ6WWgrOWkwUjVHRVo0?=
 =?iso-2022-jp?B?azFLbFRlUkVLMUlSU0toNWQ4S3hKdE9reFhRaDVLcGNFSmJJY1B5NE1q?=
 =?iso-2022-jp?B?aDZWR0tjaHNERlQySTZpcnFQMWhVcCtXSzBSRHdkbUFzdVNFbGNZS2s0?=
 =?iso-2022-jp?B?YXFscDlOMHZXb2hxcXdtbUQwMllIMWRZdGZxQXhnd0J3N1NuamMycVlj?=
 =?iso-2022-jp?B?ck8zN0ZkNmVnL0t5V1ZhOEhTRkhoY2lzY29JZ3NrOUM5azI5WTNMd1Jn?=
 =?iso-2022-jp?B?MkZnWi9ZblN1NHFPUHo5VitsWGNSblBkcldqY3RtV092UDJHUjh3dFJH?=
 =?iso-2022-jp?B?MnlSczVNZUI3aUhsQjlMNVdRTDRzWUZ6dTVFakh4Mi8ydXFwZ2h6SXlE?=
 =?iso-2022-jp?B?bnJSNXdwMXJJaklaczhHMU8rdTZxdytJY3NteEdFWkdydy9VcEoyVHY4?=
 =?iso-2022-jp?B?SW5FUVFQYW96dXhXWGcwTjVma2FkcTRLR0V4RmpiWW5rWDZydlNaT29p?=
 =?iso-2022-jp?B?UUFRYUYyNk9IMUtmbTZWYW5uOVdOd1lhckxzOVUwYjB6TUZUY0kvOWxS?=
 =?iso-2022-jp?B?NWpCZE9JejhFaHpFVDErTkRMdnhGYUl0Sit0SWNDL1l0aDg0ZUd1QnYw?=
 =?iso-2022-jp?B?ZGlLeVVmSG5DYWRVdmxaYlQwR0tCNEs3VEdwUlcvMUl5VVQ1Y041VEow?=
 =?iso-2022-jp?B?SW1TU0V4TjFtZGFjdE40U3lDYWhDTVlCdWhhcVpJclBEaHNUdUhpdjha?=
 =?iso-2022-jp?B?QTZlS2xxU04zOFBIUnhvNVhCSkJOdUNManRUQ2h1d2ZuY3dXNTJaK2No?=
 =?iso-2022-jp?B?NzErZ001ZUttMTJvTE16Q3RmUnFYbjJ5VXlFeUliSVVjbitLQWlQSi9H?=
 =?iso-2022-jp?B?SkxRMmhOalIwS2ZnVzU5ZWxVQ0hUV2k5emMxUjQyRFAycE5aQ0RFcWNt?=
 =?iso-2022-jp?B?MWVQdFVKN1Blemt0dlFUalZSQWh4UzNjZGR0cytMeldRV2hPRDU5djdU?=
 =?iso-2022-jp?B?UzUvdHJkbm0rdkV1N3ZnOE10dzBhWDJhTXVlb05KbVlYZXN0Rk5sTi9a?=
 =?iso-2022-jp?B?QjVJRlM4TDR0M0RFK09IaldobmpXL0dNc1JzelJPcXZMSGpKYWVqSVRZ?=
 =?iso-2022-jp?B?OTFoL3VBZU14SlE0MlpOTEp3dnlsYVpIcytBN2tnUjdYYm1aRXlwUzNi?=
 =?iso-2022-jp?B?dVpWK1UxVlhnUVpQUU9oaEJRZGJuTkIrNzVmZGtUcnptWmRVSzBISXp1?=
 =?iso-2022-jp?B?Z3ZiVnUwcWRvM0svUUNtdmRKbHVzWmFIaktwT3lCV0hlRHFkMmRPNFQ1?=
 =?iso-2022-jp?B?M2pzVjAyYnNGeXZ6aXkwVnlhbXFQekNGL2ZUdm9GTGNYemJsbGEwY1lj?=
 =?iso-2022-jp?B?MUJZYkkxeHhGOFFmdjJrbFlaWUg5K0lGdlZUVGlZdGhmaGUrQnlUTi92?=
 =?iso-2022-jp?B?UktWTnEvbUZhNU4xK0ozQ09sV3I2NWF0QmFkT2hpZ3czaWkwNDV2dFVj?=
 =?iso-2022-jp?B?dmk2NFVsRmpvWnhYWDVaOVZRYlpMTksrb2ltV3RWNUZmSktraHAwbjV4?=
 =?iso-2022-jp?B?bit6VzRVblB3dnRXUjVZdHR6ajNSL29yZXFTNzJOQ0Nyd2VmVFRKMmF4?=
 =?iso-2022-jp?B?KzhoVWJhcDBCWExrd0QrZktOdG9IbHN4OTlYQm85R2E1SEg1Y09Rd05n?=
 =?iso-2022-jp?B?NEhCZS9CL2dJSVVkRytKNnJJcnY0WkhCYUtsNjJ1dTUzOXY4YjBjY2dh?=
 =?iso-2022-jp?B?VG9FU3VmTUk2Zm8xbkRWWlJoSVQ4cE5MY01qSW1zbmNjT3ZVQ2ZNWXg0?=
 =?iso-2022-jp?B?eHVHcHloND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba3d51-58e7-48a8-5982-08de6eaab212
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 05:00:54.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TobQoX5OyODjZ1HPcGYSlcrptsnHQWfz6ATfE3sBOkFCdbgwSqRBL4HqxoPlCbR5Plmk1OxtV8UyLWljglYInS9zjWVaCEYeNTmX5WdVpwVKIfAKfciOdE7KThpzXwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Feb 2026 05:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21892

HI all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, February 17, 2026 4:15 AM
> To: ovidiu.panait.rb@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/3] Add RZ/V2H GPU support
>=20
> Hi!
>=20
> > This series adds GPU (Mali-G31) support for the Renesas RZ/V2H SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series and 6.1.y-cip, looks good to me too.
I will apply and push with Pavel's Reviewed-by tag, thanks.


> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


