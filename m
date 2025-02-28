Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037B3C282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:19:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.15134.1740748785584382898
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 05:19:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=RsGdDN6N;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1740748783;x=1741958383;bh=WRkZLhrPhi2leo90RwgsTKA3rZCnSnFCB8/2Cxz
	61vM=;b=RsGdDN6N5KOavImFHSx5/yduAD8pIOfdT09q92zcHvuGOyY2RonzdEzyUYuRr/MTm23dE
	ejtWcVt4wchtqiryy8xpDrIFdLs3Rvf6daRs1hyNUeVRcdkN98/BVGFHTGzbGQOFqLKOtXzO5FZNf
	xXa6PizQ3dpci2Ea2MnKqwxX4ZJKU1A5UXLHFu5xAw/5I8bzb9AVLFwWjduTinOuw8VClM+/bXk/l
	+kdPDD5Xd2WsrWjpvzF6M73HdOD0CbGVZWK7KUYzY2ZP2q8n5Va9D3AMcw2ZHITvYTvB4BlGJ0QiT
	R9N3q3+dM90qo/iTIEkADqASdyOpFJozmE5H3ll8Gg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51SDJgl12753300; Fri, 28 Feb 2025 22:19:43 +0900
X-Iguazu-Qid: 2yAbJ3LJ2RRaatVMoL
X-Iguazu-QSIG: v=2; s=0; t=1740748782; q=2yAbJ3LJ2RRaatVMoL; m=l2URG3x9AkHR9HfSazT7oFayJRS9idTWk0933TGm9B4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 51SDJe15552902
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 22:19:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+MhizqIXZC1AHS0gmCnOlwP69Jq/0SUSVscuPM02lX9KmwSlkhmqeyAJS6AGYC5c3/eSHEt9HAQEAzYNtxer8wmOvFJrX3Qpq2oFOfelLjVByLTl3/NL84MWBlEDSpoOPXF6oN60xnMesxfS1y6AUTJX4+G2N3eZYi+XYZXAgEMofjxdMYM7CCuXaLgGvCT7vCf9vHBJ0frgJIr8q9O9J51dTaIE9uQD2fIL2fl1mQXvCmKtyEAcGEpiow6Tfew+vX8mBji4l4It2JGUwVLnKSWD7G6aR+VUz+/qXP/d/c9V5japbreUmbZtaXqzWlGYv+4xirFCl3X/X0oUK8Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFBLsHP+GYIOiIMrYKIJlpNfrjK37YHdQR62GTRI9+U=;
 b=MKz611pIPLCjfxyFiISHLkJXgS0lkJACpauGE0VeihHIXfW3XcFtxLYSgT0Phtjyp6eNegQJhdWYWSfjRaWpATrNSSKa6HLhk8vqePX29UBQ2onvZG3qdbz89PkNArDWgJkH/LZIfVqBsHdubGLo7yrz5YynIwNPZl6i7sz3Z9qFfYEX45X0uBnMQZm5jg/fXexDTarxscd6+oLfwy8Gu3zl5nC3FSUItevEiZNkp5rdh6BoTChoSGzATsgeWRjqjTqKfSN2WE3gNQ692ADTQ0a2NFGdVFbacEkLheb2S7OVt5ub0Ao5YcH0aqI+trJHec9BKNw2ppMXQn9C1erqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] Updating root file system used for kernel testing
Thread-Topic: [cip-dev] Updating root file system used for kernel testing
Thread-Index: AQHbiAY0k37sypfPYkK+BZ6qIlAP7bNcrpRwgAACZGKAAAMGgA==
Date: Fri, 28 Feb 2025 13:19:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148183EC423793A8EF2008B3092CC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <OSCPR01MB1483816E3365201CB54911E2FC2C22@OSCPR01MB14838.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818C4E6A1A2A38D174182D892CC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS0PR01MB5716:EE_
x-ms-office365-filtering-correlation-id: ac8248a7-dc69-4b8f-57f9-08dd57fa8d1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007|13003099007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dG5hTk1BQTI4d1E1ZjF2aWVyZllySVRsU00rS0xFYzExVkpjOEhXNWhv?=
 =?iso-2022-jp?B?c1VhRjBTb3V2cTRrKzVsV2tKa294UUVxMjc1SjV6NWxnMGtpdnFhTXV1?=
 =?iso-2022-jp?B?bkdORUFwMExYYVBKN3NPMFFxYUlBMi9tSUpNTjg3ajRzSjNRSkthZE5w?=
 =?iso-2022-jp?B?MW1lOFNGRGZFenYxSVFwTDZzNFJqcVhwR2F2b215OERvcG5RUDE5TWxk?=
 =?iso-2022-jp?B?QmRpTklUU0wrOXpYbmhRQi9ZcXNFblN0VmM0NGN1NjJmT2RFcUt6S0tF?=
 =?iso-2022-jp?B?c3E0dGkvMGZSd2VXcHJVWUM2TFZ5T3F3RURvaXlkbmE5YjBwV2FZbGpy?=
 =?iso-2022-jp?B?Qk04cDdiTjJndTZJbmtqQ2lGUjdpeGI3UEFydE9OeTRXeGduQWdhOVVJ?=
 =?iso-2022-jp?B?S2V4U1pKS3piblZMYSt5OWsybFoyejYvYzZCYWlNZDluQjB6dzlhYkdp?=
 =?iso-2022-jp?B?aXpqbFkwK0JDOUFFdTNVbFF4UkJNTVlCelRSVXVmMURId0J2SVZ3SUk1?=
 =?iso-2022-jp?B?eVJEZkVrOS9WbFh4MkdjM3VUZTN5OVhhdUUyNHVnTGsxZ1R0SExDK0VR?=
 =?iso-2022-jp?B?Yk5aM1hrc2x1cEE0MFJaTlpLeWhlZitXRnRnVldaN0tkYmp3T0FpSnR3?=
 =?iso-2022-jp?B?ZlFwUFUzMmFTMTdYMkk5ZTJPUU13OWVnT3RZVWRaM1NBMHlWcjdVVnFD?=
 =?iso-2022-jp?B?V0x3dVBDOGRtZ0F3TGFCVXpicWpVOFVlQXBQbXkrV0l0MmFWLzFJcVJt?=
 =?iso-2022-jp?B?WlRtaEJJZHgwZjhHUlIrZ0drd2E2UG5NWnlGM25kRnV1WkpCc2RMTmcw?=
 =?iso-2022-jp?B?NFhqYlpISVFCc3I4Z09naWxlSGxGK2dDZUNQVkFjTjAwR2E3RDVRRHNG?=
 =?iso-2022-jp?B?RUl2bG1vaVhhQjdOU2taMzZybm1pbUZkemp3V1NacFBZOTM3aGU3NEM3?=
 =?iso-2022-jp?B?dnBrQnRjNU02cVdteVZZUkswVG15Ty9oZEx2ZWNLSkQ0OWowZWhHTnNQ?=
 =?iso-2022-jp?B?dXkzNlBSWGw1Z0s5b2VlUW1wemVVYjFzQ1hqWFhOSS8vVWVGakxqWUhK?=
 =?iso-2022-jp?B?ZFNxV2JJbGRVbUFhWnRkS2F0REdkZWFxblhjMmpYU1N4clBKOGVVR0RP?=
 =?iso-2022-jp?B?cGdPVjQyYkpKREljbzRwSk5aRG5Sd2tTL0IrSDFya1VhQzZFNERDcUFw?=
 =?iso-2022-jp?B?RVVxMWRyUGhTc3FBc21YU3hVRTBWUXRaMXVMbndGd2U0SlllRDhVdWJR?=
 =?iso-2022-jp?B?MS93c2tybytXMXhUS3hXcTRjVEtwTnZoNW5seHlqY0l6RjBFOGJlM1dD?=
 =?iso-2022-jp?B?Nkw5WWhuSTJPcjRXVlo4bGx6Tithd1BkNWp4MEtuZjUzZVhHc2Q0UUFn?=
 =?iso-2022-jp?B?YmFKQzZuZTJxVXJpaVY4Q3NHTDNXelZYakYrUFQ5NVNvTEpoQzRLRGFV?=
 =?iso-2022-jp?B?ZU5zMFhjb2pXNzk5UjJQOUx3em9qYWJUdkptR2I4bzIrbnY4K2ppQTNn?=
 =?iso-2022-jp?B?SnRsUmNmTDlwQlBiM0UxY05yM2U0UDA2V2JQSDZCTmpwVEM3UzZZdTI1?=
 =?iso-2022-jp?B?UmhSZ1Y3emlvNnNNV2JMQmRYejlXcm1xT1ZySTk0TG5kOXU1NjhCUDIv?=
 =?iso-2022-jp?B?bWF3ZG9LcmVZWnVWWUZqdHAxb0hnOXBHWEZ2eWhEQjNmU3RXbDBqNHVT?=
 =?iso-2022-jp?B?WHdYTVFEdFBiWEtrZkZMK3I1cnpDczYzbmRCT2Z4U3ZGOTdJOUxxWGJh?=
 =?iso-2022-jp?B?SDB0eEtvcEV0clJ1MEZxdGNjRFFnNnJUY3dZM2F4bUpBQjlONkRQUW11?=
 =?iso-2022-jp?B?a0ZTQjN2bU1CVHZ4VWZrK3h3R0FrN0RTNTgxUC9kaFhNU2FYV2xma01K?=
 =?iso-2022-jp?B?ckNIRTNPOVZvTG1zVHR3YXB4YWlON1hFUGprbk1zbHFCV3VsaTVoUC9q?=
 =?iso-2022-jp?B?dmluaHJmdldJSW5wVVBjdnd0T1VGZkRNZEI4cTRtVFZ6eEZEVWlPNEpO?=
 =?iso-2022-jp?B?VzNFalAvMnFwWEt5NEZWcjJoNWhseVkrQXNVaUkyS0txb2xqV0E5WUgx?=
 =?iso-2022-jp?B?ekppbFdWTHFESzlGb2w3TmhEajNtRWs9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(13003099007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RFVmVld5dDJQSTVvWDNYSksxNFd2bjVxVEVuL1ZtTEM0cWo3bDNkeWZD?=
 =?iso-2022-jp?B?ZnJQUi9GZXZLdUdLL3pWNzN1KzgwbFBZd1RCL2hLQU1CbG5ONjAvN3cz?=
 =?iso-2022-jp?B?STJ5c3hpR055QXY0MjVockdhdUF5TnljczJuYVlWaExVR2JRQjB1L3NI?=
 =?iso-2022-jp?B?am4xcWpxZmlsTVQwbUhYcDlGRjY0bUU5RjJNNW5EZkF6WXNLRm44MUhS?=
 =?iso-2022-jp?B?NmZSbVFidHJ3VU9CTDB6bzZ4R3FNaGtzUnM5OFViWEtETDcrUXNSNGlI?=
 =?iso-2022-jp?B?UTRKNmdzbzlBcHJsOUp6eHlXK0d3cGxhdjJiNUdnVmpmOVp3SmFwUm9n?=
 =?iso-2022-jp?B?QXJnc2dzblhXWlhyZFJmSXhodk5OMEVoLy9hWFk4UU5hRU8ydVNlbEo4?=
 =?iso-2022-jp?B?UERBTzVJNEgzUlB5cEVIeGJnc3hUeXlNVDAyNUJ0YjgvTzdMSmNQb05k?=
 =?iso-2022-jp?B?Sm1Ta0M5VTFuVUJmNmdBZklWVHJJb1EzQkVtN1E5KzlRdm9xZ1RRdElt?=
 =?iso-2022-jp?B?ZTQybjltWjJoNmlMN3RlOXc1NlFCajNQYmpReWE3VWNqT2d2MVU1VURF?=
 =?iso-2022-jp?B?TE9Sc3JmWURPbGZCdTh3cDZLWDVjRlFGUEdzNk5wT1FKaW5KTWZiU1Nm?=
 =?iso-2022-jp?B?cm1qcHdaQlY2N3p6T0xXTzc3Y3R2WlhDUVFjMmRmOU1WZTZkZ204RTNw?=
 =?iso-2022-jp?B?OWxhdndtYUxjUjgzdWFvNGFQbzhET1dRSnEyVFFtRUVNclZGY3BqVldF?=
 =?iso-2022-jp?B?eHNnU3VkSTcwY0lTaFFTYkl6WTBjckkyWjJrSFdqaUFhcTJ3WFR5aEkw?=
 =?iso-2022-jp?B?VitscnJKYUNDSW9yaHY5dFJ5YXlrdVMwbTRtb1RQemNPNC9hTklpQlNy?=
 =?iso-2022-jp?B?WmU4bk5tcGFncFZ3SFBncitKY2ZRdTBLbGMzRmlNT1VMdW5pekRpb1BN?=
 =?iso-2022-jp?B?QjZnTDFHQWszWndFV085MVlLeVV5akx0cnJzWnlvb3B6c3YzTWFBaXl1?=
 =?iso-2022-jp?B?d0NyMXozNXcwZFBDWVpMUUl4TGw1NHZFQ2s5OUFuN2RaM1ZyS2ErdmVq?=
 =?iso-2022-jp?B?TDArOExsWHRGZGZCM01nekpQdCtZamdsTHNiZEJkRWViQ1ZseU94aEVs?=
 =?iso-2022-jp?B?b1Q2ZzJmYzB2RTlVb3pMQ2JDdjBQZE1tWDVLVlI5N0dnVHlYSjNlYU1m?=
 =?iso-2022-jp?B?U0hIQzdPQUY3d0d3RWVEY1M3WVZ4NHRVa21vQjNUaXorSlYzSTF4aklm?=
 =?iso-2022-jp?B?SmZOSHR0alBGNG4wQ2Q5T3hzYysybVFwYTdZSklIZUsvUHpyQzYrUllU?=
 =?iso-2022-jp?B?bVJpc09ZeVo0OTgrOUc2UGdoY0ZVRlYxV3lXZCtGTWJYMjlXaUhIaHNj?=
 =?iso-2022-jp?B?RldHZ1ZYL1BXSlpxQWlYK0xGcmJWQk05WjdRRjZHWXZBWURFemxvN0Zx?=
 =?iso-2022-jp?B?aForQmZSM3I2ODJtZSt6aEl5c0lDZlJDazUrUkZUUmVrZmxLYWxmZy9T?=
 =?iso-2022-jp?B?aGM3MXRwUWk5UTV1TjZpbTcra1h0WmU3UzJHMjBiS1M1S3RUa0prTUxN?=
 =?iso-2022-jp?B?UkwwVFBVL09FQTFsbEtLUVdCb1pLc25ZQ0hSSXlicW1tdjZLZnNvSml5?=
 =?iso-2022-jp?B?S1p5NmFiUWpyNjJpc1BqdlBJRGdMSFZ4d2pnL1hHa29YU3pxcHdjTTZl?=
 =?iso-2022-jp?B?L3A5MjBiNlYzNlB6Q2hFbm1aaUJWZTdqRm5oeFdvOTAwV1dPbFNoVXBl?=
 =?iso-2022-jp?B?WlFKS0xaSm1rVXZJVWxFQ3dhMnc0eWF0ZTZJTVNraWhndkk4YjhZN0J6?=
 =?iso-2022-jp?B?Y2E4UGdleFc4MEhOSDhBVnlsY1hNTVNSTXIveTZMaXZ3QzlkM3podXph?=
 =?iso-2022-jp?B?RVVGV0ZOTGFkMFI3VGQwdVZ5RW5qNWZ5d0pYdC9HZ2dCa0VjMXpacUdz?=
 =?iso-2022-jp?B?Y01wVmtGNDJFb0IxL1k3MGlETEdUdWpGQ1Q3Tmo3aVJvaW9RYkxMY3Q5?=
 =?iso-2022-jp?B?cEd6ZE9QclorVXNXN0hUUElKcFlhZllWdGJRczZSY3lxdGZNanQ5Z3Zw?=
 =?iso-2022-jp?B?UEM4di8wbVUvTFhYb05Pd3dOMTFJZGV6YzJIdXl2OCsrQWh6dThIbHBN?=
 =?iso-2022-jp?B?bmdoaytaaWlXTkhyaE9FT3VRYldiZmRuWS85Rm1YWStzWkZOekRRcFNn?=
 =?iso-2022-jp?B?RXVrc0lkME1XdC9QVjI4VXkxSnJBZlVCcTVpa0dEMndvWUo1VDRaOWU5?=
 =?iso-2022-jp?B?QzRDaDlRQ3FxbDBpRU51NjhhakR1bm9KeTNTZENPeUtvei9iYks5WW1l?=
 =?iso-2022-jp?B?Y3JvVGU1blZCNW9ERmw2MnNTNFZ3UGFRSWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8248a7-dc69-4b8f-57f9-08dd57fa8d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 13:19:37.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7X2+4H4HEyFyfcY/tpei5ZTRSmgJ/MengsBrgpBDySodwQCNvKV6G/FLKI1D16h6dfXMMvNB34XUmAdtg1WdC/C2DoxGDakmBqJ3JTLT2yV9ztuDRoWgH93PnmlVLeGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5716
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 13:19:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17988

Hi,

Thanks for sharing the information.

> I just wanted to mention that we tried some things in the past few days. =
Targets
> like [1] if deployed shall push the rootfs (ltp installed) images to s3. =
I have

As far as I can see in .gitlab-ci.yml, the deploy variable is normally 'ena=
ble', so images created
by jobs such as qemu-amd64-test are always uploaded.

> modified the following job LAVA | Scheduler | Jobs | 1250098
> <https://lava.ciplatform.org/scheduler/job/1250098>  to use the rootfs
> image from cip-core instead of legacy ones and the LTP tests are running =
fine
> of reference hardware.

Yes, as you mentioned, what we need to do is modify the LAVA YAML. I am wor=
king on this.

Also, the image for kernel testing contains the Linux kernel binary. This i=
s not necessary for kernel
testing. I also created a rootfs that does not contain the Linux kernel[0].

Best regards,
  Nobuhiro

[0]: https://lore.kernel.org/cip-dev/1740746806-6557-1-git-send-email-nobuh=
iro1.iwamatsu@toshiba.co.jp/

>=20
> -----Original Message-----
> From: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)
> <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Friday, February 28, 2025 10:06 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org;
> Chris.Paterson2@renesas.com
> Cc: jan.kiszka@siemens.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =
=1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M=1B(B
> =1B$B#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B
> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] Updating root file system used for kernel testing
>=20
> Hello Iwamatsu-san,
>=20
> Thank you so much for your response.
>=20
> I just wanted to mention that we tried some things in the past few days. =
Targets
> like [1] if deployed shall push the rootfs (ltp installed) images to s3. =
I have
> modified the following job LAVA | Scheduler | Jobs | 1250098
> <https://lava.ciplatform.org/scheduler/job/1250098>  to use the rootfs
> image from cip-core instead of legacy ones and the LTP tests are running =
fine
> of reference hardware.
>=20
> [1]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitl=
ab-
> ci.yml?ref_type=3Dheads#L203
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.git=
lab
> -ci.yml?ref_type=3Dheads#L203>
>=20
> Thanks and regards,
> Sai Ashrith
>=20
> ________________________________
>=20
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on be=
half
> of Nobuhiro Iwamatsu via lists.cip-project.org
> <nobuhiro1.iwamatsu=3Dtoshiba.co.jp@lists.cip-project.org>
> Sent: Friday, February 28, 2025 6:26 PM
> To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> Cc: jan.kiszka@siemens.com <jan.kiszka@siemens.com>; hayashi
> kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P=
#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_D=
IT-OST)
> <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] Updating root file system used for kernel testing
>=20
> Hi Sai,
>=20
> > Do you have any plan to keep these rootfs tarballs updated with the
> > latest version of LTP through CI ? If not immediately then we want to
> > make changes so TWG always uses latest rootfs tarballs for kernel testi=
ng.
>=20
> We had talk about this at the kernel team meeting. I'll take care of it.
> As Kaz wrote in another email, I am looking into how to make the cip-core=
 image
> available for kernel testing. I am also working on doing this.
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of sai.sathujoda@toshiba-tsip.com
> > Sent: Wednesday, February 26, 2025 1:28 PM
> > To: Chris.Paterson2@renesas.com
> > Cc: jan.kiszka@siemens.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M=1B(B
> > =1B$B#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar=
(=1B$B#T#S#I#P=1B(B
> > DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;
> > cip-dev@lists.cip-project.org
> > Subject: [cip-dev] Updating root file system used for kernel testing
> >
> > Hi Chris,
> >
> > Hope you are doing good.
> >
> > We noticed that the LTP version being used in the following rootfs
> > tarballs used for kernel testing are not recent ones.
> >
> >
> > 1.
> >
> > https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> > <https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/>
> > cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qem
> > u-
> > arm64.ext4.xz
> > 2.
> >
> > https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> > <https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/>
> > cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qem
> > u-
> > arm.ext4.xz
> > 3.
> >
> > https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> > <https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/>
> > cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64.ext4.x
> > z
> >
> >
> > Do you have any plan to keep these rootfs tarballs updated with the
> > latest version of LTP through CI ? If not immediately then we want to
> > make changes so TWG always uses latest rootfs tarballs for kernel testi=
ng.
> >
> > Thanks and regards,
> > Sai Ashrith
>=20
>=20



