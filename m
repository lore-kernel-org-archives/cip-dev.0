Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A1C77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 06:59:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.2763.1750748361474068366
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 23:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=kdlBrQrb;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750748347;x=1751957947;bh=EDBU2qcwXXta3FwcJzUD1zaq/PGPf4xzq3vGNCa
	q9RI=;b=kdlBrQrbzan6PqD/SHh/URoT8iLoZmyLPmCtaZdBAhCk+VHd5AnGUMmCr94Yjv7H2Tyll
	Rd0ye9f1S9AvLaoUj9LXg3PCzeNYzJeiqpeqfSzQHsgVPX4PoPEYnKLsTAre1bj1c+1nffj/fsCrs
	fZt1jAXd1g/f8IitkDBJOO/HrDb81uKJyU75uSd8Q4dr5LQIQ/urFtT4z94jSrhmlG1eTqCLL9G7E
	kxM5Ujok/dt25I81lj0KPGCp1lXWx2ly2MJZ0mbPcvsvARrtCrXG/TPl50wE19nVUqE8NY3jDzbHQ
	z4WrZam0yrfKyQ8vJaK9F1c+5AvrjzGk2QNSleSSYQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55O6x6Ye100928; Tue, 24 Jun 2025 15:59:06 +0900
X-Iguazu-Qid: 2yAbUt1VHaR068SyVu
X-Iguazu-QSIG: v=2; s=0; t=1750748345; q=2yAbUt1VHaR068SyVu; m=FdSI/kCWcNkn1HsWtjFL0ceB4WdUzFFliFWkmFwgAEM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 55O6x3wx2836662
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 15:59:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDoo80B5dTK58t2hCSr7frqxT0pCJoyjsAGvknmFiiNhgdyHrFAJ5wJmBuu9GbrmDy4LtbVirVj+lSJXH7ZrspBO0Ruhdo1tDyHN5KI1xaCVPbRqBWCUFPm/5wfOAodmRZY/p9FJqbnkSsXjUCA0S3iw5xoFMoCIfJFrnlkMdKxam0Nn3xJ6W9j5nuDAmkLz6GjrpUqK1yV2QkjPqxuIVXr4h5lPyB+RUzWiaCpcri7zTb1HVOZNkHyZ6T1i00XfsgnBboE7gkbacvfnmgThQ4C8i6fk/eSHikfqAKN7sVsurHujIPq+9JW/kxrIvpjegUB5OEzjuRDGeFl4XNzg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zazJMRgun9dy77wH4/Sy6kX//lRLFNkVvhR1TTUjGjw=;
 b=ZrZxgy+tOcRONOQ7Ui2qV2sV8wmlxq9yuONEQI+N7nq9V20IZDzkrWrg7nM6V16YWONx9WHa/f58DdLpYPuNG021HJSyrm5NGAec2bJMh1GJux89SrEe5U+nF63whhEXbOF29QF35tF6GUDjhzmPJXkdlKMzN7gAPb8H1FbB2MVo8jPHa5ouydj+p++flUNYx1luuCoxhGfqK27U2xB+DxTPPpbZxf7tyMqTW0GGM6dSJ1weZBPskTOYXCZ21fwpw5dGRP6HXRHx5iFOceI4VMPWTXrqwIaXtvLDD6yBChvGd29fJgH8j1wijO+7y25x5NTSEyK9QPBDnGBpssmWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <tommaso.merciai.xr@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Thread-Index: AQHb5CmyRf4waXBPokqJIE4BHVKXe7QRsx5AgAAvGbA=
Date: Tue, 24 Jun 2025 06:59:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481844D4BBBF0FDB5E6CA0789278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
 <184BDF27BCEEC92E.10318@lists.cip-project.org>
In-Reply-To: <184BDF27BCEEC92E.10318@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6614:EE_
x-ms-office365-filtering-correlation-id: f396eee9-2534-4d2f-c79f-08ddb2ec99b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?c0thU1VQb2VwZ3RuZEJmY3hYdDQ2enhhc05qbjcxRXlCRmppYkZCNnI5?=
 =?iso-2022-jp?B?VllPRFFPdk1XQ0hjN0kzbzhQNWZYVllWbTc0bnVqQTkrSnYzb3lUT2Fq?=
 =?iso-2022-jp?B?REhDVjRrUGlsOXkwZmwyeWdyVExDT29JSWJEN095KzAwQmdhR3JQdmda?=
 =?iso-2022-jp?B?U0xEUVU4bFR6enN1WFp6UzhjaWFIYmREYncvNm1PVlUrN3ZhSzRua3py?=
 =?iso-2022-jp?B?VlBXRmNVc3dHUys2cTI0bjRvV0hyUFFyRVN5dHg3UDdQRUF1V1hITElo?=
 =?iso-2022-jp?B?TzVjanZxREs2YTZBN2lDd0Qwa3hmWE1LcVFkdk9rM2lHSTN0Q1BZaUUx?=
 =?iso-2022-jp?B?MForOWlramJkNjV5N01ST1FTL0F5cnJHeFZMK3RGUVlKWjRVZmtjbk56?=
 =?iso-2022-jp?B?UGtUSXNYMFVBenpYOHFCZm9zRWY5Um4rRTZiVzJ6WVhkOEtFdVo5cFZa?=
 =?iso-2022-jp?B?R0J0Y3R6M1A5ZkUxWXl4OTJXU2QxaVRRQndjdG9NZFFtdE0rQUUyWFZP?=
 =?iso-2022-jp?B?NmlVUWxvanFhZUUyQUxIK055OE8wSDRUOGRwcUlFSG1zN3g0V3hlbDdG?=
 =?iso-2022-jp?B?WFBFdTQyQXBYYkZGanJ2cG9RTXdhb1hSN1BLV2FFMy96cnRFN05tNEpm?=
 =?iso-2022-jp?B?VGI5dVR6RUtXYUNWZDQ3Yjh4cloxTjVpS0JiRVBiSlUzRm4rSFJ5RWFr?=
 =?iso-2022-jp?B?eVQ0YU82YjM5NlA2elpZaG1qNFFrSUlUd0d3ZnFGay9qMi9MLzFzNmZH?=
 =?iso-2022-jp?B?eUJabStOZmZjdk5WaklPN3RMeE8xbUVRYmNDZk9yVjM1Z2lLek9lTHF4?=
 =?iso-2022-jp?B?dmlzdHhZWVlWUGxGclRXR1BacWtIMjRkaFZHUHJwTlFGdjNqeStjayt2?=
 =?iso-2022-jp?B?QnVLaGZRVTViVDZXcHI2VmxDN3NKam1JTGYveGM5RVZpa25xbjA1UWN5?=
 =?iso-2022-jp?B?ZWgzemE1OTFBZ2VieCtlZjBiMDhKMEtkVWM3bEpGWmdWOGdxektSWDlC?=
 =?iso-2022-jp?B?N3dDZzRLdzJINGhhUDRHWW81eGszdTNRM0h3d3ZuL0lkc1ZVc0oxUFZu?=
 =?iso-2022-jp?B?T041aUhEVGtsVnZhSG5MaE9wTUdWWHVNNXFOd0p3UjZGRm1LY2IrNnpt?=
 =?iso-2022-jp?B?a0l6b1dteWJ3aGE0N1NsM1Fkb2xMSWhVSjJvS1poeUg2bjd0RlNvdzNT?=
 =?iso-2022-jp?B?QW1xMmtEUjh1SXlMdDJLUjI0eGJpaFJrQUtYang3Y1BzdDgzZGVmS1Y3?=
 =?iso-2022-jp?B?enQvZlhWaEpqbXhBcmsvTjE5VnV5SFpFY0hZSS82dWNhYkVLWmhWYUlJ?=
 =?iso-2022-jp?B?L0dMU1dOWWNieTgreEl0MHBMcElBekd5b3pnZ0hwR0VlK0xZZEx0cGtX?=
 =?iso-2022-jp?B?dWtOUFFRbmZBVlY5WC9hWkVsVkhzZWJkNDZwNTRHRGJ5Y0dTR1c5SjVX?=
 =?iso-2022-jp?B?LzQrQUhoVVRiWTVneS9VR29SK3Y2VnI3VkZPdVZBYlBkNDVIcnNEM3RJ?=
 =?iso-2022-jp?B?akxqUWR0N3RRVllYcS94Tm9rU1ZuYzlPRlZEVXV2Q1pMSng0MU9FbE5Q?=
 =?iso-2022-jp?B?WHRtMjZVTlhneVFDKzdyUzU2all6S1hiSi9vbzdJUDZxQ3ZXQTRqUzlv?=
 =?iso-2022-jp?B?bUJSdCtqN0FqT25VbXlzTEFYRVh2ZUdFQXBzQmVoSTVibTV2YUlTL01o?=
 =?iso-2022-jp?B?cVBrYmU5SlN0K3FwZERZS0dieDZWZUV5SjZTZ1NxZTFrV0ErbDQrci9s?=
 =?iso-2022-jp?B?d3A4MzluTGZWVkNoV2ZiWUpQUDlOSkV5Ym5HTTdNU3NHSFVqd051VWVD?=
 =?iso-2022-jp?B?bk8zMkllZXh5THVlMzJmN3FDd2M1Yk5uVDQ0NjdReEdQVjFwclltQlQv?=
 =?iso-2022-jp?B?TmJoclh3Zm9YMlI3SFNQV2VNMGlsa2dtRURVRkw0eVpEdHJ4MkV2ZEpr?=
 =?iso-2022-jp?B?VmRTdko5eDVXaGxtYlpTQUJtQTJaQlh4N1NGRHo5Z3pmc0NHcU1zdnBU?=
 =?iso-2022-jp?B?WjBaN0gvRDc4U0tLcFdlMUNUZHVXcHFWZTZIQWxwR0szV09PYnVSbmxj?=
 =?iso-2022-jp?B?N0xtdlRQSnBReVlqdTdIUlYvcmUxaDdwYTQ3djZPV01MYXM2NkRmUlA1?=
 =?iso-2022-jp?B?d01FMVQrT3NUVXIxMlN0a3Fia0JROGVRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cWo5VG1iMGIwNzYvd3BJN3BJNXJIR2JvbjJuelcwR1ZPeUhzcjRzdkhR?=
 =?iso-2022-jp?B?Q0JYQVZ2ZGF2U2RGdlh2eUdJblNUZDJNdGFrdmtJR1hJY1dUaHdhcmhi?=
 =?iso-2022-jp?B?VitMaVUxeXMzSEJRc29mM1BNeEJUWC8xdTBiL040OFlHcmxwUjZGY2hO?=
 =?iso-2022-jp?B?Y3J0ZjJDVndCbjNSQ2lTQnZyRHVmdEN5b2ZqZjFZdE1RNFdpQkF0aW12?=
 =?iso-2022-jp?B?YWEzWDR0WE1vcmR3ODdQUlQ3TFJyZ0NERmhUK245NjdoM0lhQWhJenpD?=
 =?iso-2022-jp?B?RndtejlTQ21BRzRIR3JpZjQ1Tm9ZcmZ5bGM1RmcxZzY1UWVicHN0OXZ2?=
 =?iso-2022-jp?B?QU1DV1BZUHQxL3Q0eEw5NzYvMUJjWVRzZFpsSzVLcS8xOGkrQjVTOWxw?=
 =?iso-2022-jp?B?MzJMczBZRHV0WURLVnhkdm8rYUdLQnV2WFdJR0xxVnR6dVNsTmFlVFo5?=
 =?iso-2022-jp?B?SzVrc2d6VTE4TU02a0pVempEQzJCR2lMU3JmNFlhRDJOZlg2NEo3RFpx?=
 =?iso-2022-jp?B?bWplNXRRWmw3Z3VRVFRiRFAvc21mWjE2bGJLNW45amdEdnVXK1Z4cjZl?=
 =?iso-2022-jp?B?QmZBOS9NT0lTajJ4aWV6U093VitmT0N5bWhsTzdONUZSTHdFd3JnaUQz?=
 =?iso-2022-jp?B?M2dWU1hqTFZ2U2tDdFdQdnc4dDV1OXhSdmQveE9JT2xVVEQ3RE5JS0lW?=
 =?iso-2022-jp?B?WFpwRXVsY2lOazlGSFFmV2JJelBieDhTRVNub2oyWGRONFhjMkFibnJK?=
 =?iso-2022-jp?B?SFZQcDZDdmlmRndkcDRwQVBESjhEUFB2KzEyRW85NTVzSDdSaEp2RUF5?=
 =?iso-2022-jp?B?M2UxOVNlWEpia2dnNHVYRlVKZzgyMG5FdTM2ektOMjE4U1RUVGlUQllp?=
 =?iso-2022-jp?B?bm1SUnE2b0wwc3EyK3Q3aEZXYjRXaXp5UGczRXlvdjV2WEFEdXdjSmRs?=
 =?iso-2022-jp?B?cmw1aTJKQWl5TnJrT1Q0azZ3VHg2cmp1ZkpsZXVIR0lBdjd4aFd4cDVR?=
 =?iso-2022-jp?B?UjF5TDh6ZkxDd1N6UFYvamR2VFRFNk5EUnQwdWlHWTQzNTZxUGphVWV5?=
 =?iso-2022-jp?B?Y21kVUIyZ0p0V0lvS1NTaDlXVmovQWUydm1MdnhKMjdkZjF4amJXeW03?=
 =?iso-2022-jp?B?Zko1dW51LzJTTWFLK1RNWExoUXNLelJQc3dMNmt5WCtWMm9rWVYxUDVs?=
 =?iso-2022-jp?B?cTJ0VDd5aFNkK2dXL0RlL250NnRMTkliU3AyNVlMMFJjei9GTXVDZEhy?=
 =?iso-2022-jp?B?QnpYWDN2cWN3T2FIYzhkTDNtbStCN0xsSnFvTExvT2tmVDZWanhtOVBT?=
 =?iso-2022-jp?B?ODArMEFBWHZvWGZWdzVlMnpBZ3NGei82eWNrTkg3VDFvMmxubXZuK0Vz?=
 =?iso-2022-jp?B?UnhuUk9MVS9jOEIvQ25CbUdGeldKZ05ZV2I2ZjRRVWlwSzhGMi9wZ1B1?=
 =?iso-2022-jp?B?YytPOERERnp6UWJ4dzVQMXJXRVB3QzNyM05lbWgwNkl0WnBiQUtQY0NG?=
 =?iso-2022-jp?B?L1IyeWE5L2t4QTFYSmVqVWxhT1hENjVEL0U1WUZ6Mkg5a3ZlWHAxNndK?=
 =?iso-2022-jp?B?dlUvN1ZPeVdQWnNteWJoOEEvZ3hib2xUcjRjL2hDUHdxMXltemtJYlAr?=
 =?iso-2022-jp?B?a2tNOGczcGJreG42NVN4Q2VPbENFWFBDeXFkQXlaQ0tteEk3bVRrZ09M?=
 =?iso-2022-jp?B?VUhKZUV4QVpEemFCVUpEelQwQWdVc0JOYnovM2RzbDJudlFheWt1NVMw?=
 =?iso-2022-jp?B?ZW14Nm51SjArSmR5dkpiK2dGSzgybmgzcGhZS3VRN2tNNkxvaHJDZG94?=
 =?iso-2022-jp?B?ZTJ4S0ZJRDE0UHYxc0l6T3VMVlhDY2FyZFhwamxhZVJ2dWdOT3ZlNUxV?=
 =?iso-2022-jp?B?RzBIYjdaRzB6ZmlTeFVwMFp3Rkt2a1E2NzJRaWhOWmZPNTVoWERDcWxY?=
 =?iso-2022-jp?B?RFQwRGJHZi9VUTlCTjZ2NVJxNWdPcjRTTXVBZ3RIdDJITS9tUE9vTzVv?=
 =?iso-2022-jp?B?bVRlbklmR1A1MHcrR2xKMS9UU0hSMUpzOFpIYnRQT2c5MkhjMTRCVWtn?=
 =?iso-2022-jp?B?aHJQT3FvRDF0ZWJiVlVzYlIzSldxYUoyemROR0ZEYjZnQ2xjaGdOSWVJ?=
 =?iso-2022-jp?B?d2JrMEU1NFArNk15LzNvdm9VSEMxT1VWV3RIb29rbFAzZmZleUxtdDFw?=
 =?iso-2022-jp?B?MGpaWmZmdWFvWHNtazlBdnpEVWRXWkppTC9TZ3p0cEpNVkZBbVQyckFP?=
 =?iso-2022-jp?B?U00vZ3p3RGUzRWc3aWlQOHRITEd6SXRXYXdtc2VyMUZaYWJxc01WL1h5?=
 =?iso-2022-jp?B?cnFkdjFNcnBVSGJrbUxuSWUvZ2JQY1g3QkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f396eee9-2534-4d2f-c79f-08ddb2ec99b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:59:01.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIbM5XHxBCm99AsZaJh+CH0JJqrVNxpkZ+GzBCXIF4xxeA+PPaN8GNazc5hgv+4ewDLoQ6R4nrVCfDACa46nVKyf7CsFjFomu/cU+EguZd+RTkSZSColqY1Lwz4b5JO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6614
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 06:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19221

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: Tuesday, June 24, 2025 1:10 PM
> To: tommaso.merciai.xr@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Cc: biju.das.jz@bp.renesas.com; prabhakar.mahadev-lad.rj@bp.renesas.com;
> tomm.merciai@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: Monday, June 23, 2025 7:29 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> > =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> > Subject: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
> >
> > Hi All,
> >
> > This patch series aims to add Watchdog Timer (WDT) support for the
> > Renesas RZ/G3E SoCs.
> >
> > The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33
> > cold reset, system reset and asserting WDTUDFCM pin where as WDT1 can
> > be used for CA55 cold reset, system reset and asserting WDTUDFCA pin.
> > Other 2 watchdogs can be used for system reset. So define WDT{1..3} in =
SoC
> dtsi.
> >
> > Thanks & Regards,
> > Tommaso
> >
> > Biju Das (5):
> >   clk: renesas: r9a09g047: Add WDT clocks and resets
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
> >   watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
> >   arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
> >   arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
> >
> > Lad Prabhakar (2):
> >   watchdog: rzv2h_wdt: Use local `dev` pointer in probe
> >   arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
> >
> >  .../bindings/watchdog/renesas,wdt.yaml        |  4 +++
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 30
> > +++++++++++++++++++
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  4 +++
> >  arch/arm64/configs/defconfig                  |  1 +
> >  drivers/clk/renesas/r9a09g047-cpg.c           | 15 ++++++++++
> >  drivers/watchdog/Kconfig                      |  7 +++--
> >  drivers/watchdog/rzv2h_wdt.c                  | 16 +++++-----
> >  7 files changed, 66 insertions(+), 11 deletions(-)
>=20
> I reviewed this series, looks good to me.
> I can apply, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


