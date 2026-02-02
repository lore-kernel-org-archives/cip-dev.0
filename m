Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39CD172B7
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 02:05:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43832.1769997914631932300
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Feb 2026 18:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=qKPUvOJB;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769997913;x=1771207513;bh=2qnwoUnc+bgx9Vb2GtcZwwXFLhFtMngGNOl9U
	ccWen0=;b=qKPUvOJBYdGas+MFIL4kq7YEzJh5IT49ETgJhZNNmIZcknv1wMUyTHFO0NKB4sXrHLH
	oPZ/7GHoCEJgbmCcGNWkc70Mbkk/7AE5nGiJvXosM8rjaewa72WkXfBL72jIUwx4KpEWtvjdMiN19
	5thCEnNmQpFzbTzwEQZptzoqQckrTVhoBOTu4Xx2a5mWGg2Wv3fKh/tDmBhy4HaogIPGvzUEIdnhH
	jpHy4ZAfH36d/+CSIGogVDIwlt1gZI1udrxMu05xC4pAM3JLQlYyxwZ7q705p7AO3Jqdl7hlnppjX
	eySx/NFhGZCIAUBo0wXuE52cGXq86Ik8lIoHIkUUPIvQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 61225CxS3561229; Mon, 2 Feb 2026 11:05:12 +0900
X-Iguazu-Qid: 2yAbeDG1WK8xOPtPnj
X-Iguazu-QSIG: v=2; s=0; t=1769997912; q=2yAbeDG1WK8xOPtPnj; m=Ygbl3/IsJvTVTPp9Ri+qj7rxN4oZ4SZ8gkz5JW5pGZ0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f491N1V5RzyPZ; Mon,  2 Feb 2026 11:05:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2+txGun3EqECS1FBEqHDzX+vZ0Fkhx09Du4HT3fhxY5xDw9atIHPKXpkZgoYc3g7UfAUgLWqtylyr8CDJzLiKvfCL1k0seF+g5hXKFeoI+4QdVIqsH0D8x0Q4pkYz019QpV9PtzE1WS12Onbzwusmz8n4EmtJLzq2tvFQh/HqI9Tj22jENtuGts6t8uW3kQRScqA8m7r81XK/K7Qq17BFOSS+R5P8DAUvqNc25PvOtQj0AvosPzDM8sk1Xn30Lc+mytFUXIVRmgJG62rjLILPpduPMqCChrOeMXYt5iTpwNnagG8H1XcUNQsBEbPFA71d+jVIfflwMNjOxa2D3tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTLr4w/9dB+YBnWSShKu/hoPXhod1JMqkQk3boAQQVo=;
 b=lgZLbRjjW9hiTvAVB/OZtNAjBEvhed+hm9cv3h9Ac8Nup4ZGk5OoqnzD6VsrxF7mveXjmYV3D3ErZEWROLhKBHlHUlAZyk+aE/aZqeybI+z3PGHWqTrUy9WEkOBXRMTXcUqJ35PoQMnwFDb9ufEWfwlIQn2hJ+HVNspMmEkFoQ708XFaO8l+XcA7Bq+Z9YW8k46b+Nb5jFy2TB0Kk15bqrbMBrAv0wYjRCudALhMgcbe0SUGK4fR/0tLL/XhEmRLxwwoU2K/yCpkdkaN8U3GsXASV6UNX04BkHs31Gij+6DXfLXFXIjAd/ovdapZo4eG3MVQC9pmjGpllprXfJTdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <nobuhiro.iwamatsu.x90@mail.toshiba>, <ovidiu.panait.rb@renesas.com>,
        <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Thread-Index: AQHckFnKuEMNPjR34kq7F9DTLBS66LVozU5ggAXihmA=
Date: Mon, 2 Feb 2026 02:05:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481890FD64F4010BD75C12D4CD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
 <188F257CFA6798FA.3408700@lists.cip-project.org>
In-Reply-To: <188F257CFA6798FA.3408700@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSOPR01MB12168:EE_
x-ms-office365-filtering-correlation-id: b4c47758-03c8-48d9-8a19-08de61ff7e2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|14052099004|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ODN5dEY4d3UwYjFVRFE0VU03ZEk2a3gzRmh0SzRMVUprckpva3E3bzlz?=
 =?iso-2022-jp?B?TlhZbk5vNzhUYjMzWTR1MFVyUTdRUTdKNDhsQ0pIRFlra1luRjNnK0pN?=
 =?iso-2022-jp?B?aUhCR0pnUXdZcFcyZVJ4VXNza29EOG5DWjhJYlp2dGF2SnhGV2NIdkhh?=
 =?iso-2022-jp?B?ZlVIV000bXgvTEd0eDRQOEplRmtMcW1rQ2JtY0hHckpYaEZzVk1DcHlR?=
 =?iso-2022-jp?B?QkZ6YmZENHI2ME1FUy8wV25GYW9BWkc0ZjIrYTVwczZ5MDBiUlpWYytk?=
 =?iso-2022-jp?B?NCtCdUY4ZStHanAwUnVyR3ZZc2orU3RXZGo0MDFNa2JiaThDVkR2SnlZ?=
 =?iso-2022-jp?B?R2UzcGw5aEEwZldVK1ZxZ3RKWFZPWDY3TUJRR3J3Y0tJSGpYUTgyc0J1?=
 =?iso-2022-jp?B?Z3EvTDErZm92S0UxeUw1bWVyQWtPTi9YVjlodkdQT1M4d1A4OGIzNE9z?=
 =?iso-2022-jp?B?WExHaUcyVGxTLzNJdk5UdlRMMFpFYVRHcFgxVnROcUNoa3BxTDZ3dEpC?=
 =?iso-2022-jp?B?cGRLM3M3T3BRWmZKb3BFZ01ZQ1pIaU40TWpFRGpHS3hxNEdRZytaaHBI?=
 =?iso-2022-jp?B?ZGlYRGNuMEZyMXpkOFlTd09WRVR1V2wvcDZMblNWOEx5WTZ2d0FCVWJr?=
 =?iso-2022-jp?B?MVVTVEZjT0wwYXVid0VLbXhRRHViTmxLVjJNUW56UTdtcUluTm8rZHBR?=
 =?iso-2022-jp?B?WS9FVGpuendvNTRORDNSbW9FTTFyeE51NlZRTGNtZ01nOWJYek1NRkFI?=
 =?iso-2022-jp?B?OUNSZFRxRldZb01wWXEwRUNVS042WEpmbWFPbk53cU41ZEZ4aDU1UWk3?=
 =?iso-2022-jp?B?REFKVU8rYk00Tkk1Ti9OUVgxdUE4bHFTZUJXZ0xVOVErQW1GdnZ2cFc5?=
 =?iso-2022-jp?B?WTJrVWkvZ0FtSW51d1ROQ0RlZnZCRGVkS0pFem50M3lwelVLdzQ4M0wy?=
 =?iso-2022-jp?B?dHpka2NEZTNBOWgwL2VFQU5ya1lHa2U2a2dtVUVOTlp1ajNSVzZqdlFP?=
 =?iso-2022-jp?B?clNlZG5OV3pINmNrNk9jMzNmb1BQQnBFMi9iWFFraGdOTHJOeTdSL2k0?=
 =?iso-2022-jp?B?WVB5aWZ4cmVsZlpuMWl5SXNvRkxCL3hRV21KR0xSRzlicEhLVHF1K1Vj?=
 =?iso-2022-jp?B?M1FJcWFqMXNheEZRYVJXc1o2QnVuVUV2SWV3U21OWmxDSVhkVWpHNlV6?=
 =?iso-2022-jp?B?UmVwUEd4YVVwTWVCREVPQnd1T3pvUU9FYkRwOTVueHJ0QkZIazFDamFt?=
 =?iso-2022-jp?B?eEZiV21oeGJGQ0xUZ3VVNENPalpaNUFsN29aK2hrVE1DNG12ZXBJMDdL?=
 =?iso-2022-jp?B?NzdKcGZ1eXpqckVaUjlLSENITXBjR1lwWERmMHdaTzk3Z3F2NFN6dEJv?=
 =?iso-2022-jp?B?ZElDWXF5R3JpcG4xQ1ZXK1ZCZUdwRXRFci9WSjhLVE1hY04zYkxMYWp0?=
 =?iso-2022-jp?B?UkJNd1hBUkU5NElJYTh6bDc4dVFKeXFZM0pzL3hmWkFXdWpGZ3ROMmpt?=
 =?iso-2022-jp?B?REthMm9XNVIrdDhieEFhSzhybW44OTVEZHRuSk03VXpKdFFYYjU1UUFs?=
 =?iso-2022-jp?B?cjFaSUNhc2UvVGxpYUMyWmY4aUtDYnBaZzVEWGJLR0Jvc25Tbi9lZzFt?=
 =?iso-2022-jp?B?MTJTZENUbDRzSmpqQTFEMkhqaUlTMVRnZmk3dHlyL3BoSERoOSt6L0pl?=
 =?iso-2022-jp?B?cWtRWlcwTTN0QXlLdzJOUUk2Tk1GZWlFTmhXR3dIRnhSQ2FwdTV2S3VW?=
 =?iso-2022-jp?B?TisrTGJWcTFEdUdETWhKRDBIdnplZkpTNUVDaFV0SXJybE5nZjllenRH?=
 =?iso-2022-jp?B?TEZiS1RHS0RqbnlreXBJa3Q1blgrTEpBNFQ1anRKVjNYRC84NUUyMmdp?=
 =?iso-2022-jp?B?R1FDVUNvM0wrUytpTE4yS2x4YVVOWkF2c3RYa2p4cEM2V1VlWHlTMDZB?=
 =?iso-2022-jp?B?Z3R1UmIwY1hVYy9YN3p3YjB0Vi9hcHBOSzNWZ3Jja1JjRUN6VXRSM2tS?=
 =?iso-2022-jp?B?Z3V4RUc1K0J2b05heG84QStFVzhwZFhYUTdYcTByZGd5QzNkZGNoUnFr?=
 =?iso-2022-jp?B?VWtmOFViVjJQdDB4UzRuN2tWeWZ4VDR0Sk9LNkdjQlNrdFFrbE1YRXFp?=
 =?iso-2022-jp?B?MjRxbFk1dmFzWjBlSERoSWowcTJETGJqSFc5V1ZHbXZ1WXkrcjl0TmRO?=
 =?iso-2022-jp?B?OVdjTjdET3YwT3U4d1l0UkJjSW5XaTNCOXRSQk1DRGxxa1pFU1I0RDNQ?=
 =?iso-2022-jp?B?U3VxaG9vLy9RTmJnQ29ib3Zad0ZjRHJKRitwdUh1enR4aDBoMFFqL2ha?=
 =?iso-2022-jp?B?WHJQQmtwK2J6dXNObGpCVUtWb2R3QThKYWFadjV0c2kzV3d1Zm5uOFQv?=
 =?iso-2022-jp?B?a1hmaWs9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(14052099004)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UEk4bkd4UFd5SitpL0VlYzd5NE43d012NGtPaXR0bndKWWlTcTZDTFZO?=
 =?iso-2022-jp?B?cHlzbUdZNWJrdVVVZWs5WVQ5Qm1wTmE5TFJ4eStYMVZuQnhkbkI1OUxz?=
 =?iso-2022-jp?B?a0JoTmhPWlFIV24wNWRiYU9WN0NCWFVUb0loZkR0SVF6QlJDekV1S1Mx?=
 =?iso-2022-jp?B?b2dYWUpHUlZlemt5dW5OajRLLzJEQVNWdXo1ejkrSjVyUEVxamVXY2dT?=
 =?iso-2022-jp?B?TWxEOEwycGQ4V1pPYVlSeHdiUDAxQzBvVGZsOFljamJRZzFmVkZXVUhU?=
 =?iso-2022-jp?B?MFZVamVqaXNLelNjdkg5ZGFJaVQvYlZtUjdKUEtyNnRRNG1CaHpVS0tP?=
 =?iso-2022-jp?B?ZjFxUTl0Umc4YmIxK2NnNC9PQ1VvL0RzYk1OMUlvTnhobVE4NlRNMkta?=
 =?iso-2022-jp?B?Z1pMd0FvUVpFdCtMWWwzZUc0dFBHWTlqTWZPcWc5UGRSQVhlL25lWTdo?=
 =?iso-2022-jp?B?NWxaSDhzQ0c5eFZmZ3lhL1JVeThWVUFLa1JTT0h1L2NNZ0FKNHowLzBZ?=
 =?iso-2022-jp?B?eUx1RWlDQzFTd1hyOTNvcFJacnhpM0c0ZGdDTnRydUY0cWRFNUJyYkhy?=
 =?iso-2022-jp?B?Q1FpWGRyTms5TFZnenk0VEtzOXo2VkJ6VmtOM2NTNVZIMDZmekRhZWNs?=
 =?iso-2022-jp?B?ZTVPeSt3bGhBc1VYTS9hajFCME5uckFCdTFzZm9qaXdHQjFleXdHZWNs?=
 =?iso-2022-jp?B?Y1AyT0ptMGU2TkVvK2VPalJORXBtV3d0azYrdjh0QTF0S1o0VzB3cmlR?=
 =?iso-2022-jp?B?ME9hT3J4OWFFZ3ZiRjN1TmYzYUVpNnVYVWZkaWYxVmZuYTAyS2ZCVzVN?=
 =?iso-2022-jp?B?UEVsdk5adXRFTTNha0dqdlpmelF2YjVvYTE5WVBNZUIyallQT0Y5U255?=
 =?iso-2022-jp?B?YVh0SlRiUXpFcGxRU29BeE1SdDVyMHdnbHlIN0phbDhaMTdDSGtvdXN5?=
 =?iso-2022-jp?B?aW56eTNiRkFxa3gxUWRkVmFWQ2RncHd2MWVEb1JlSEp3VEhVZ3NURjdp?=
 =?iso-2022-jp?B?TFFLeE1VQTZxTlU5bkdmOXBCSXY1bzNNd1RKbm1HaXZ5bjJaelp1T2lH?=
 =?iso-2022-jp?B?T2pxRFNsTnQ4a29oMkZZd1B5c2V1RlhTOWp6UXMwZi9mQjY3dVF5WU5s?=
 =?iso-2022-jp?B?ZHlhM3BSKzIwQi81MXl1OVg4amIvYm5leXYzVDJhWHp5QmlKdVUzTGdr?=
 =?iso-2022-jp?B?K1JOSU1EME5iWS9DSjZYWkZRaEY3NEZuQzgzTmlOL2VDQ1VmMmhObWNu?=
 =?iso-2022-jp?B?ZWs1aE04YkJZWUlnSW9BZ2UvbzFzbXlYWjVyMU5wcVhhODladjNnR2Vu?=
 =?iso-2022-jp?B?SkFOeWNYTmZnMEF2dUM4WVZBbUJUU3F6Z2Y4dlBJNEpRb3BOaGpGeklS?=
 =?iso-2022-jp?B?bndYdHQ3YmpCVGtNT3NZeElTWUp3UGw3d3NuOEo5MWtacVo3S2tZUFg0?=
 =?iso-2022-jp?B?dmtSNHJuNGt0NVE3UmdFVjhBeGVoeHZmV2FlSStTVTNsNmc0S0Z4ZVBu?=
 =?iso-2022-jp?B?eDJkVEhFZTU5UkNGNWtFc25DK2lNd0NKbUxLODdjUGtPVlBVcG84UElI?=
 =?iso-2022-jp?B?TW9FS2ZROHJYMFk1UlBUSnptRmJ6dWgzc1RkcnFpQlN0ZFVBNThFQTli?=
 =?iso-2022-jp?B?SzRqUmZJQVZPQUl5bkN3emQ1SmNEL21CT2c3S1dCRDA3SEVmc0x1a3pG?=
 =?iso-2022-jp?B?eEVhbEg3c3lqODlRVXhMV09Ba3prNVRMRkFvQnhsalZqNWxISElwakgw?=
 =?iso-2022-jp?B?WTNDN211U2Rzcng5cnFRSTd2VW55eWpCOERXb1lldDQ5RElUTTlKbzk4?=
 =?iso-2022-jp?B?c2pScDQyUVVRL2tKeS9JdFpqN20yTGxtZjRyODQxWWdTbld5YXdUVGd2?=
 =?iso-2022-jp?B?UlB6d09nZk9UNTFscU5sWlpKMkp3QzcrVFZBU3V6N1hyRXkxZU5BbWFD?=
 =?iso-2022-jp?B?WHhwNWFJa0YzcjVhSDB4Y1hHSXZHSHA1ZHFtMk9ydmJMR0NZVlV5RWtY?=
 =?iso-2022-jp?B?U3VPa3RIb2RTbXNncWZKbC9ZRXhXeXV5TXFvbEIzTnE0Umx5Rzcwc1VQ?=
 =?iso-2022-jp?B?Wm43dzF2YWEzUHV1S2xFOHlYN09JR2tRdlFkL3dGdVJnWXM1QUNTY3V6?=
 =?iso-2022-jp?B?bS9Ba3RRZjNCNVZjWFkzZVBiL3FicHZ4dEJIUTQ5WDdvZnlObDZua0hH?=
 =?iso-2022-jp?B?K2pMdWwzeE9Jem9NWWw1d1loc2VUSC9IdW4xSzEyOGdtN1JTOXJNTzNC?=
 =?iso-2022-jp?B?WDhMUmhNOUpRTmhUUWlpVExHV1dFOUJDVkYxbWVKcnk4Nld4Z2o2VzVS?=
 =?iso-2022-jp?B?cXpjRnU5ZGZMOFBHY01VWU1BTXl2b3ZCNjZ3TU1MQmRIWDBrVEErWHJZ?=
 =?iso-2022-jp?B?TlFDdUdzYzE5WWRBN05IYlBQaENYamIyN0V2VmNCUTM4ZEhUUHdXVXVE?=
 =?iso-2022-jp?B?dk9VMmxHUG5nMzA0L1RobXc3aXBOUXQyOFZoREtUOHJBaXl3WXlrUm1X?=
 =?iso-2022-jp?B?bmZxVHAwendiaWk1T3dOYzRvbXhQQW0rVTRkOUtHNXkvc01LcVNsMEEr?=
 =?iso-2022-jp?B?aStyNVZBaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c47758-03c8-48d9-8a19-08de61ff7e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:05:09.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cks+JOIlmRo755/bxilosSPnGTwRYu6qZCuNwnC7cv1/Q9AvtsaXXbA8GWjnFpAXFtqRpBTXiKzgobc49eHJHH3kV6yu/e9Xe0XN1cE38sQRZSVrOT8rzr7z0ncDQVL2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12168
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 02:05:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21794

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: Thursday, January 29, 2026 5:13 PM
> To: ovidiu.panait.rb@renesas.com; cip-dev@lists.cip-project.org;
> pavel@nabladev.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Wednesday, January 28, 2026 10:27 PM
> > To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> > nobuhiro(=1B$B4d=1B(B
> > =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwa=
matsu.x90@mail.toshiba>
> > Subject: [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
> >
> > Hi,
> >
> > This series adds TSU support for the Renesas RZ/V2H SoC.
> >
> > All patches, except for patch 4/12, were cherry-picked from mainline ke=
rnel.
> >
> > Patch 4/12 is needed to fix asynchronous aborts during unbind. See the
> > MSTOP series [1] for more details.
> >
> > [1]
> > https://lore.kernel.org/cip-dev/20260115083604.1064260-1-claudiu.bezne
> > a.uj
> > @bp.renesas.com/
> >
> > Best regards,
> > Ovidiu
>=20
> I reviewed this series, looks good to me.
> I can applyt this patch if there are no other comments and no issues on C=
I.
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/229342285=
1
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20

Applied and pushed, thanks.

Best regards,
  Nobuhiro



