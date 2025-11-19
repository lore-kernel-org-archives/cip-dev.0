Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C1CF258C
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 06:01:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.506.1763532112686227868
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 22:01:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=MkuGSbHT;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763532103;x=1764741703;bh=x0iyrBZ9rLZXFeUrAnwWhi4Ff+zzgYBTtJ6Lh
	UhBjnk=;b=MkuGSbHTs6Ccety8swxRVkUsqIF3wznWhhHSB8QKejNmHAhFDm7oVRqgb3yci/8cwlN
	yh4njJEOHNRiPmUyc2JckzHK4P9OAp4e0pnIhQFx2c0WKaM8IQhkVu3CIQq0qgqOWmLXudiTBRTAo
	31soRtbJKNNj/JvyzBKCVkUbcKCwRV6EWPlSZ4tAwUA/I4WzUs9TXOd85ShtJVltHOiT6jDZr9GCe
	mJZijLXTusOb3bzPys3cKqia9mbyJu58cpNE+rnTE2kc2liXu4wtMbzHmovVm80ehfAiYmUoM0ixr
	Li0+Y/3A89aS8zWh60QcIoqBMtlatiQMHZUArOcrJI1g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5AJ61goH3050305; Wed, 19 Nov 2025 15:01:42 +0900
X-Iguazu-Qid: 2rWgP4I4zf6ffdHjgX
X-Iguazu-QSIG: v=2; s=0; t=1763532102; q=2rWgP4I4zf6ffdHjgX; m=rh55N1Ngi29iDrC9TdrWE8PiwiKJhsXCZCloqxffYAY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dB9pt2vpZz1xnf; Wed, 19 Nov 2025 15:01:42 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si8VV93zctwrfKd2RRcCXwq6Jg3zSVFeo1QNn58uZyGgxw1zUI+LYInuVkhbNbMDr48Ry+OP26TXdcraFqvY5Ch5AwnuF+rJPDkjQwyyuRKTMootB1bam/bT/m/vaioJ20TdplYIct1eeoBuyMA9wa/uBfLqQmwJsTQELAYxc4r0rKR/hWgV5tivVAgnsehBQKejvf+Q8CMT9aH/w72hMTy7Phpq89xSeKhIOyxHBXPHQA8hd2fX0yRgLx4pdqSRi6rzIeEmNZ/FTzUVZ57lgYGG2tHrPSZPi0dm/3OL8ev82kiqWXOy2CHV8Q7Edko4YiUoTFIv9Dmrr50f6DAZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE+wd8ntMgQxxRQU+pKyAQYOuKyABt93WpxOTqy3MuA=;
 b=rxZaF0p62X3gkpxLC3qFLN3Acc/Ba7tprO1xmdb7QYfOjH519BoGwZLOwfYA934GmnxK+X/7BwbK4hc4XsxKQycRNhs8Z/mQ7WDFpTbV+U6hUn7eHaDSSKK8ohuTjqZh6tdMsm9QJfCC9JBj6XcwxGDr8iOSQwrwVdPy7YWV1dirblHlh2JgRrI0tjKvjmHgtWOVbHXyvDBESbxQAunyb1Gsiyxf7fsnHLoQuPt5we9cyDuumBean0LmXeolB6MjKqPPFp0Dhs6+juMyTWCbXHEI9/uyCo2cVXiY7BgFJhUJNi5JYip3IM1cVkq0H5NLOc/03FJ3PSgVUIgFWC/w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
Thread-Topic: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
Thread-Index: AQHcVVfQ+av7spvSOEuLySZw0HOnb7T5iSXA
Date: Wed, 19 Nov 2025 06:01:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186CD256FDE1796064D52ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB8640:EE_
x-ms-office365-filtering-correlation-id: 18fce4ba-feba-45b2-b22d-08de273119ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bkVhcW5sOGJhSUZyQWRyeDh2V2FDZWRZUFBaNUxMNDFnYU5BbGFpWEhx?=
 =?iso-2022-jp?B?Rit4NUJNSjhQdDI2aGJDOGRMcVJIZVg4MnlzRWZtdHhCNGJURVN5VDVa?=
 =?iso-2022-jp?B?V0p6ZTlPSE9sdGNBbytXMWI4N0VLOEFxMGU4Rys0NTJmb1U5QzZLbk9U?=
 =?iso-2022-jp?B?cHVIdHdia0g5cGkvNGs4MUJONWd2aHorQ25KUW4xYUZzanBMZjVGb2xy?=
 =?iso-2022-jp?B?aGxsU2JDdFp1czBycEhjWDZnckVuR1o5M1pOK1lQdFE4UUIrZlF3OUp0?=
 =?iso-2022-jp?B?dGtYU0V5Q05uTTBBUy9VbnF3cUVNd0ZnWVhPN1JoTEdRdjNHM0lad2FK?=
 =?iso-2022-jp?B?eFljamhpanBSbEc0QUxKUXJVMlF4eVgzaUJsSll3NDUzK0FwMWNsTmlH?=
 =?iso-2022-jp?B?dUg0RTVlSSt4K0tHdTl4SHpKQTJicGpWRDZGYlF6UkNJd2hOYzZlajVG?=
 =?iso-2022-jp?B?aVlpd1RqMFpPQ1BMZm5wcmlYTi9vaU5ya2syVW1tNDFLWnh3WGZqVGJt?=
 =?iso-2022-jp?B?RlV0cDNjdERNNVJDVTFjR0xoamFMZ3pCbXhLR3BBZEQyUDdleE50RVpU?=
 =?iso-2022-jp?B?T28rc3d4M0JCWjl1dW15ZG5FNDM4Z0NYbTFHbk95clJzQXNZVXRHQjBS?=
 =?iso-2022-jp?B?Y3p0MFIvMEo2YjlGTjJLdHAraFpOQlJaYmUrK0lWWmJvMjUweS83RGV4?=
 =?iso-2022-jp?B?Q2ZlU0tpZ2QvcUhsUTA3VFFLWmplT1M4aFcvRUNSR0YxYlN3NTdzc25G?=
 =?iso-2022-jp?B?S1EydTd4UzJtYU1aUC9Ta1RqUEdVZlZwb0kzWlpla1BzMWNoQnJrRE9L?=
 =?iso-2022-jp?B?UHhpMXBtbnA0Q2RvYkNzSm0ydEdnUk4yQWIyaVkraENtdFNDbDR5akxz?=
 =?iso-2022-jp?B?Q1hMRkkyOWJoN2xCNWtVcW5xTEx4Tk5pM0pySzhJQ1dNbS9HOE9QUGxV?=
 =?iso-2022-jp?B?YWFvNldGS1JUYldXdVZGelpyZ1hYUkQyTnM3TnBDSTlXSVJwcHF2Z3hx?=
 =?iso-2022-jp?B?UFQzSG9RZkkwZnFFSlFRTjhpdW1jSFRaRGU3Q3pGSXFYRnIrME5tNHEw?=
 =?iso-2022-jp?B?dk1KQ1JiT1Voc1JJY2NLeU5RNjdDUWY2WjZUWXh1cWJPcmVtUWp4NFhy?=
 =?iso-2022-jp?B?TERkTFZ5d1g4UEp2WFpCL2k1blhBY2RsalZDNTBvZmg3S3NaczFtY2g1?=
 =?iso-2022-jp?B?a2MxYnhCUlh4VWc0ekxoLzRwZ1gxVTFvWk5HKzJMeUdpeTNjelV5d283?=
 =?iso-2022-jp?B?WGZPOFhFdHlPWklCN0N3UEdMRVhZTmdjRitHTFNNbGNrYWhkSnFMeGFm?=
 =?iso-2022-jp?B?SDFMd0ZEa04rU051RDdmT0NMMVlWNUkrTUtFeXhQOElnN0ZLQkVNRm1L?=
 =?iso-2022-jp?B?YzZJZVEzZDRjc1l0MWNQQjdrMzAwRG9vTm9uUFkvMjZ1cG1FSU51Sjhj?=
 =?iso-2022-jp?B?UE92TjBnWTEzNkp5RDNIZXFBKzFpVDUyUzhRbndsOXQzY1ZxUE9YRzRp?=
 =?iso-2022-jp?B?ZTVidDlQOFRmOFZQNWUyT3JZQzRwLzJsaGlSL0ZsTHNoSmF0eEFaN1Nz?=
 =?iso-2022-jp?B?NnpoRkpqT3A1cURHcFZ3eXU4T0M2V25UVGFteWFMa0lLY29qNHNnbmdo?=
 =?iso-2022-jp?B?U2h0NU81emdnSlNlei9ieXJES2hLVkVsbG9WSWdPSWJyRlNVWnAyZ2Fv?=
 =?iso-2022-jp?B?ZXZyTkJGWmRqOUpwVmV4UFJwdFgyY3JNMzFGRm11eTVoNE5hbDg5ZjBS?=
 =?iso-2022-jp?B?d2JIby9Xc1o4c3Jwems1aEZOWHhHNnlmUXpNU3BDMXRxR2dsSitCU29k?=
 =?iso-2022-jp?B?MVdYeGRGbHFlSnpTRW1IRnZ3RU40OXZTcmROWHllbXMxQzZUempxeGlj?=
 =?iso-2022-jp?B?WTd4VGtBUnNlZTFWbUFudHdIQXVybXBsOXJjWncrUnFSNFBvdG1RaUh1?=
 =?iso-2022-jp?B?MlRvV1BVVFh3WmFaekFsR2d2WUY1dUI4bHozcWJTdGZaNU1VZUdRb3p5?=
 =?iso-2022-jp?B?cVdSbldSU09QM2gyelpCUFB4V050MFFxcVY4alZqKzB2T2Fnd1ZVRWxT?=
 =?iso-2022-jp?B?V3BhWHpnMkcxZG0vN2c1SzBGMk4ybmpvWDZBQUIwRW42NmJSWWQ2M0l6?=
 =?iso-2022-jp?B?dzN0eG9zbHZkd2lYbzVkWldoSWJqSjg2aU4zSDJoOEZjUnRvZDFhY3JF?=
 =?iso-2022-jp?B?N2J0alpraERJZ0FKTUErZHp5OTgwR3pD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YlZnY2dudTRGTFBIeFY4NG5XODZ0Mm84MUFqeklXMHhFdDlvcGlrS0pR?=
 =?iso-2022-jp?B?amt1TTB2aFhmaUpYVDV3VnZhRGxzRThrZDZCNVJtZ1ZEMTVnb3Z0TlZp?=
 =?iso-2022-jp?B?Y0VNeG82eWhDV1FTK3U0VHRQL1NKZjUwNG4rQjE5ampHckxiZm5nM040?=
 =?iso-2022-jp?B?eVhKTXFiZjYySFpIakNSQVl0T3BMUmZRS2htbGdxM2hUVUpmZEFja1Ex?=
 =?iso-2022-jp?B?YzY3UkdrK1VPUUdWS3dURldhVnJrUVJKcC9iUlM0Y20waUlhendxVlN1?=
 =?iso-2022-jp?B?ZWQ4SWN0WjJRL0xOakRYVzM4dExCMzZrdmd6Ymh4YkE3Y0pzZXJXQlB2?=
 =?iso-2022-jp?B?UmF4cVBNV3FWa1J1QWl5c0RJYXhLQkVrYlI2RkM4Y3MvaTFrTCt3MlIz?=
 =?iso-2022-jp?B?MitSaG12czBydVFBNDYwdVltNnZNNThtTjBRSGc2cldhellQenBkM1dE?=
 =?iso-2022-jp?B?d2tOTFNCL0dJQXdOS1VqVzlZdEp5a20rZzNnbDZDMWJxdi9WQjluQlhV?=
 =?iso-2022-jp?B?dnYyUk50RllTYk02NUdrVFU0aVUrQUMvRitEVU5pdlBqTHBvRmwvc2Vj?=
 =?iso-2022-jp?B?ZGU0QlYrWVdvZi9vSnlDZEZBU1VMVGUrTHNEOTBMaENJRENUNE5TSk5V?=
 =?iso-2022-jp?B?QmNFRlV2UGY5dEs5UElGeDhBU3pRTFFGd0dRUHJLVjFRcis1ZjdlMjlZ?=
 =?iso-2022-jp?B?bkJIMFpkT2huVk4xdENnWVZNSDVMZWswU2dVSDU2WXRKSnh2d3ZRQU44?=
 =?iso-2022-jp?B?Zk9hV05LWjYycXpqOStOMDMvZFBaM1JxU2owdFlsMTgwckZ6Skx4RGE0?=
 =?iso-2022-jp?B?R051TVNwUERsb3pzRlJIYm9BbSsxZ3g4UFl2VG9wbzFTWTE2S0NhTXVC?=
 =?iso-2022-jp?B?dmUwOHplM2NHMGlqeFlCbGduZjlXUDh6UTRkZjF0SnRXbGtya3dCVGJS?=
 =?iso-2022-jp?B?b2xacE1vRnlDU1J6a1lvMk52dnJsV1owNTkreDlYcDVHOXU1M29Db2ZP?=
 =?iso-2022-jp?B?VnhUUHRqMGJPRFhuUXZXMjMwcnAxRklybGUvTWdGRHcyWDBzSlUxYW9y?=
 =?iso-2022-jp?B?NEsrQnZISU1YRERsaVpjWlNKMzF6c01LVitnSXp2ZjJjb2ZteVFIYnVX?=
 =?iso-2022-jp?B?Y3VUWlI2QklucWkwdVpoZjc5enFpUU40d2hBdG9HQ2tlNi8yZ1I4ZjdP?=
 =?iso-2022-jp?B?L2ZsK0Q0dCtxV1ZmLzZSSkkvS0FKSGk1RndzU0FIUFY2SzlYTWc2UUVT?=
 =?iso-2022-jp?B?bG5wOEF0SzM3c2FMeTd2cWlsRDJEazB0SG9HQVZleFk0V3AyZ3Naa1h3?=
 =?iso-2022-jp?B?VWhBSWsyYXBVd3ZUNGtiZmJoNzl1NUt0S2h1M3V4YzJLYy9pUjhIK1VT?=
 =?iso-2022-jp?B?ZmlUSGI2TS9TRXBuOHJDVGliM004RHZUWGlCYVZ3dDFkZ0tGK2p0QlNw?=
 =?iso-2022-jp?B?aWdOdFhWM0E3Y2I2NUcrU0dUSENhVWNjRkljR0xsRmExdnRIc2gzS09l?=
 =?iso-2022-jp?B?dWhmUFhaZUdTUGNqT241ZVJhUVVYTEk1VEYybGY5aWhjVi9lSVhQWFpV?=
 =?iso-2022-jp?B?VnZSVHBWTy9BQUZMT3VmS1FaT0ZDQW1UL2F5bnJtL3gyd1grWEhqeGxW?=
 =?iso-2022-jp?B?d1g3MUFYd1I2NllpbnQ1TDAyTjIwV1JoUjEzTDJGeEtZaGtvK1E3ejhY?=
 =?iso-2022-jp?B?WGRWZnp3OGRvOTNKTC9Ed1IwSGtvN05HdkxMRmY1QjBWNjFqR1dyWFZJ?=
 =?iso-2022-jp?B?KzV4cnd2SlhvMEt5WG8zRDlIRFpqQnRLeC9QVzMvRHdkUFNscTRjN3RP?=
 =?iso-2022-jp?B?UlBNeTZNZXBCSjhLRWxkMWxTTzZ5NjVCWkY2U1BKZFFDTUVVR2Vacml4?=
 =?iso-2022-jp?B?QkxJbWpIUG12MlVBdFZXTy9jOC84WGFSZnUycW5ubGIvWEtFakJDQ293?=
 =?iso-2022-jp?B?ZERPTkFJRjdUM2ZhTVFvWHFOQkZRU1BSQnN5Y3ZQQnd3bWxsazFkbXN1?=
 =?iso-2022-jp?B?a2VQNUlHTDJoQ3lISEVyZWdxRC81cW05VUsxc2N4TWF1ME9aTWE3cTd3?=
 =?iso-2022-jp?B?bTdjL0FXU0YvdlpFNFc3NUpPeEQrWDJGRHN5K0VsU0hTRFdhb2JqMnVE?=
 =?iso-2022-jp?B?NzFPOUZMZ1VlZkJYNCtOVUVTSzFRZGtOTDIrUFc1QmlQU2dDU0xPTEtW?=
 =?iso-2022-jp?B?ZDkvYkpwQTV3VFFlcmdNNFpKcUhRK0NaQVd1bmtTZ3gwdW4wS01RWlVq?=
 =?iso-2022-jp?B?UHg0c0sxdzRCY1JnY0pYMGQxMkphMnJEbit6WWNhR0pGOTVJQVpYajQ0?=
 =?iso-2022-jp?B?UXlmVWo2aGJVclV2YXBGQjFjWlluMFJqV1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fce4ba-feba-45b2-b22d-08de273119ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 06:01:37.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: na7xvsSpIEY8wQsIS5cBX9P19Iz8CFvoun+0B+vrv3xuRCCyq06i7bFENB1UEBjksa1p+lYqlzgjw9AEs6cFVUwP5p/4f+5k9G7RUwU11eqETjUz6Jfvua9uXYbc/0uM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8640
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 06:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20624

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Friday, November 14, 2025 8:14 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
>=20
> Hi,
>=20
> This series adds support in 6.12.y-cip for the eMMC and microSD sub-board=
s
> connected via the CN15 connector on the RZ/V2H evaluation kit.
>=20
> Patch was cherry-picked from mainline kernel. Note that only the RZ/V2H p=
art
> of the patch was backported, as there is no support currently for the RZ/=
V2N
> SoC in 6.12.y-cip.
>=20
> Best regards,
> Ovidiu
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and
>     RZ/V2N EVKs
>=20
>  arch/arm64/boot/dts/renesas/Makefile          |  6 ++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
>  .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
>  .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69
> +++++++++++++++++++
>  4 files changed, 134 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
>=20
I reviewed this patch, looks good to me.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


