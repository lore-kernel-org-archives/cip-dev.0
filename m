Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A3CA0EED
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 04:38:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.1410.1755837486897113193
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 21:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=pX3W0eLh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1755837477;x=1757047077;bh=yG6qfFP+U+DHn+C5oclAjANtG/1V9QlaRcKZY
	p9QfgA=;b=pX3W0eLhGqomzgykEilnOqS4PMhgl/Y87J2t/olIIKKMl7NkZITlCYpqn/eO3Yt80zu
	bZTTsP49fGBLZTviUEIATWL9kAlsP29D37PdCVmINGaCxPRNPOZDRCWg+NBewLlaynX46rLaDupyW
	BBPz7+SD8gBYlN5vsD7jnczWy0EaZjDqTGgq/RXwclkgfOzEPgxv9ba+0y2TVHZaTawDVZUfEDp75
	Qf/wPuaN6F7OQRp+5f3VO/GYjitWkbZtAeeHflR8kpkxDyLFarqeuHzw81dU0PbbMLSkstgfoT+Yu
	MBgl+y0+g8HFjBG5ck+3GdTiJg7x06ESRLbhFHIUEWvA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 57M4buvB3611631; Fri, 22 Aug 2025 13:37:57 +0900
X-Iguazu-Qid: 2yAbyr8UtE7z40nJvw
X-Iguazu-QSIG: v=2; s=0; t=1755837475; q=2yAbyr8UtE7z40nJvw; m=dJdAB7zH6P0nRME+iwdFb1sFi92FI/2yWf5nnV8mRck=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c7S9H1rp3zyPQ; Fri, 22 Aug 2025 13:37:55 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTF4Q/u/5y66SO9DWRYDmgNVy9zoIiOehC6S1BojXe7ZIimONK1XfjqF1pbCVyJ4T4MYdsesk15zeKDd+Q+XxUj4GIjsJWaNHdBmEEOP7YZIBgK2Lcsh0XZNwZs50NYVt60N8Bukucy7wkRwN4v4wOIq0L5gH0Od8dLYKfC5kVbFZqb9yYtAZxZ10Exhg+I9oGVfQLYKBaFhmATafuRjmDtoVA/9iitCucjK1jJwfpEmBfmis1aHYLKyrMPL7LdJYxMKPVsDOlTjmlU95qGTAEXMG/EllKpLK7F0uz+V8PlLC6ZmHV9IWob4+OZ8JwQNhcosJXPDehHWlejc3vtd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdipQGTrp2bxeI8QMeJE9wjoFNGW0kgSLpbHT/fbBZI=;
 b=jkCiRhfAc4KV4defM5aAYQPXGfIGqPXIg8aZ80AIoXvcfg8lMwcEAVIJ+YmEjxMH3BjJyD+2mc1y2j7Doj4NVCQLGqg3r+Vp/aKkOfDxhh2MEO1gDUPpHC5wkW477PX+QOs9UQL3KLgLtBOJwteLvd4dEcWpm29fVNqHkr+FBVSD7KmKY6SAmBZlzWY8GI1MqqbxbM9/+y4z7PTqAGS1GYBjE1+UGh4BfhG8CtBnsQkMdwTlfDbDSzr8blUW9Y2PkY1ugjWRAEiE6BFGon47+6rNV1qo0pt7Y87AkLaoQ0mSs5TODR0MRe5KERxujlP8rcJkkCKmeBqkYqbzlt9Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
Thread-Topic: [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
Thread-Index: AQHcEa3ulrpzj+6iuUCxtPi/J536ibRuEkMQ
Date: Fri, 22 Aug 2025 04:37:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BF96A3A6A3EE1DB97694CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15682:EE_
x-ms-office365-filtering-correlation-id: 59599af1-cffa-40b9-44c7-08dde135a7b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?THpYeUVXRlVmakNHS1ZQcXFsb1orWk02RFdNSkJqNVl4cTU4Z2lCQWtZ?=
 =?iso-2022-jp?B?aW4rZkpobXRpc2k0TTFZOFdRWExoZEQzSWZpbnJwdFNYV2c2WjBmV2Z1?=
 =?iso-2022-jp?B?czh1dnhid0tmMFlobjNvTkhLdjNsT3c4ejFYaVV4U3ZrQ3JLSHhlalcv?=
 =?iso-2022-jp?B?bG5GNElEZkZSejlrbHdQWEJzcnFyU0p6TEdEUzdvYmNSYVgwSlpUTVZP?=
 =?iso-2022-jp?B?WE1DN0hnK3E5NThvU1RQUFJOWmpib25lVHQxZ3NpYlNnbEFoSmJPYm9H?=
 =?iso-2022-jp?B?RjJiMXJzM2xEalduN005SFlQdjVzYllmaUIxSXB3azBUSTc5ZWk3VDlQ?=
 =?iso-2022-jp?B?R0QwSVl5TEpGcnUzK3BqakhoeEdpS1VONlN3dEZESCtYaVFwU1l2STd3?=
 =?iso-2022-jp?B?T05jd1VEaWJURERJaG0yVDJrSTlkMjYyVncyUDBQRE1UZWh2S01OaEhn?=
 =?iso-2022-jp?B?ejBjUUp3Z0hrcWtmR2pQcWwrZUU2QUpDektFZ0lCUTJaL2NBbmFIeFhI?=
 =?iso-2022-jp?B?eXBXTkluVEk1NXJzd2pLYTNwK0JodkRsOUUwTElKZkVNaFNmV05uZlNu?=
 =?iso-2022-jp?B?YWZPSUJuMWVJRWVGZFlCSkk4c3gvSTYxQ0lFbHphKzlxaEs0ZTU2RjJW?=
 =?iso-2022-jp?B?S045VExodkJ5RGlPQnFMRlgydThNRGEyRDBsaW5ReDZ1UHNEellmRW93?=
 =?iso-2022-jp?B?RVdPYm9qR1hNL3Z2VDRpbEJoOGNONzRVdHBxbGFPSEJNMVRudlhHdVFu?=
 =?iso-2022-jp?B?V1h2Y2V5QkZ3MmVZK21XMFZvU2N4WTRlMVpWeW9MUVhydzZvVUZDUlJx?=
 =?iso-2022-jp?B?b0JjS2NveEFXV2pQbER0SnFqaXNQNXQwb3MyeGd4RTI2YUZDSWdQaVVW?=
 =?iso-2022-jp?B?NzNYODNkL1VIdEw5ak1yN2lPemt0VXlYdTU4THVQYmMybW4rL1VRRzJX?=
 =?iso-2022-jp?B?OHJmcGtrd1MxWDIzbkttWFVvVTh2bDNlS3lZckliVG52VzBaTythcHZ4?=
 =?iso-2022-jp?B?TDZWT0htWDFnRzJHVm12SElHWXNRQjg0NXh6V3d4UlA4NGdyTXJ2ckNn?=
 =?iso-2022-jp?B?NXk1NkNDUEdMcUtrTUJGOVBENy81SWpWU1ExN3NWdC9LR3VCNkpKTDR2?=
 =?iso-2022-jp?B?QXFRUVBLdk9PajZDa09RSmhHRzRmaDV6WGMrU053OUlzK09IVmNiS1Ju?=
 =?iso-2022-jp?B?czJyVldPM3UwQlNXSmxEOEhZMjYzVG05aldWYTE4ZjZzQjRUUGgxaXpX?=
 =?iso-2022-jp?B?cm1sbThCVkVJcjRmQldWbVI2ai90T2wyOTZ2S0VNTGhhUFd2VUVETlFZ?=
 =?iso-2022-jp?B?OEhhN3owMFRTY2pEM3FCeVEvdTd0aDdPWEx3a3Q1Q1MwS1RuVG9vTTJm?=
 =?iso-2022-jp?B?WnRKbFR4MGgwZ3FMUzRaTlA2OStIVTd3bUd2eWJKZ1gzNTd2NnNHSlpO?=
 =?iso-2022-jp?B?Zi9KUFBlMTFuTndKZmFqRWRORHpONnhiN0p0ZFNhWi93ZkllOW9KWk5I?=
 =?iso-2022-jp?B?a09tWTdQa1hmQWs5TTRSb3dOUm9UNVdIaTcvYU1Idm9QeVVIRStSK2RR?=
 =?iso-2022-jp?B?b21MUXdZazh2anZDSTNYTlE0Tjk0M2ZSdkJCS0t3VWd0TXRWT2w1UG93?=
 =?iso-2022-jp?B?TGpITVdVMkFwMDluQWdDYVZ1R1JBRzdmRVFFWjJORlFoZzJMNS8rUnpN?=
 =?iso-2022-jp?B?WVMxU2NuUllUMDdySGpiMXIzL2dWdlljcFpNcmxTMzdYcmNzaWpwOE5N?=
 =?iso-2022-jp?B?ZUh5b01ZSDJhNTR3ejNJcG1aVVlGeUNkc1JJSEJWU0hBM0FIYlhwS2Ey?=
 =?iso-2022-jp?B?K1doS0lWN2kweWhBaVFhY1JLWHJ0RzByK3FyT3NEVG5NRjNQQlF4YVZJ?=
 =?iso-2022-jp?B?b2JPQVkyYlNBNzcxN0ZYamtxRzA1YlRyelFOYzYzR01hMUhzQlhrZXdu?=
 =?iso-2022-jp?B?dUx2ZEZzNnZDSVQvUmx6c3NIdEg0NDZydGluTldETlEyV1FuTjJVY0VT?=
 =?iso-2022-jp?B?Sk13akZFSzNKQXZ2dGFFUWtVenlVM1lhTFBtWjFMd2kzTjQ4N2I0eDZs?=
 =?iso-2022-jp?B?dmlrT2hMQzF0ZCtmQXNBNzViU2QyUDkxTmNqSHRjUEFXM21hRlljaWQz?=
 =?iso-2022-jp?B?YmRIVVEvbnMzTmF1YVMvYk5ma1ZlU0dtZkdvU04rTndBa3h4d3FVVjNh?=
 =?iso-2022-jp?B?ZnMwPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a3M1dTA3MlFVVEw3Z0ZISnBOdFp5a0szSXRIYW1PaDBuK0RUZit1TlNS?=
 =?iso-2022-jp?B?eVk4RDhvVlpvVGpoc3hMQm1rRDdtZzZFekZzWVJieEFXdUx4RFJDZTJG?=
 =?iso-2022-jp?B?YWVtZ0tiRVl6YlR4RjNZendScjNvODdYVUtyQkQ4THY0cXp2bFpQMUpB?=
 =?iso-2022-jp?B?T1Yxei94bWV1aVZ2RXBEdUZnM3l5bDVyVDN2cklITEVQRjdYUXN6dEJi?=
 =?iso-2022-jp?B?ODdqSVhVVG1GS1N3VXpHajN5RlZERzN2OUFNVTUxb3hjVThWY3JsNmdw?=
 =?iso-2022-jp?B?VzV3ZUpZWllBQkFoODhFR3J6UkFuRUlQdzQ0bVhCOHk0NFdZL2xESXV0?=
 =?iso-2022-jp?B?djI5czhOSW12di9tOXgzS0QvQmtkR3RIdEdxd1hJQzZ6MTRsOXl4ekNX?=
 =?iso-2022-jp?B?OGRlNlIySlRWMzdIbWU5a2Y2QnVWOG5aaXZuMjYzUXlkbE5pZDBodWIv?=
 =?iso-2022-jp?B?RDlNdnkzMkNuUlA4aVl5SFM3a0lDTDJLZUdWWXpJQjBXcjdoM0V6RzRk?=
 =?iso-2022-jp?B?YjhjelZZNUZNdUVBdk9IVmVPaDBRWkZadDliR1NlbUQ4RFMxbDR5Qjcz?=
 =?iso-2022-jp?B?NzI4elpSc243V0FiVWxYUDJiQWNETDAyU1FFeWdvdDBsTDFTRWxZZ0Q3?=
 =?iso-2022-jp?B?Zzk1dkdFUys0M2k1NU5PNDBDd1R0RGtOSS9RUmFCYTFTc1B1VThtR1pu?=
 =?iso-2022-jp?B?c0lhMCtOam1ISStCdGE3NC9IYWt2RWVwWFh3UzhCOEJWVW9qRDJOdnBK?=
 =?iso-2022-jp?B?N2FCYXFDdVhmZlRxVGRWbStCbk1LYmRTcnlXUjQwOHh2MmJ2eVJ1aVY3?=
 =?iso-2022-jp?B?S2hlN1ptUW5MYkU4c2tKbHRoQUwzYjZXZW5rNDVFNzVnNDF3QUtEVmVn?=
 =?iso-2022-jp?B?RXFBa3BtSFFqM3Y2MDd4K3dUcmMxTkMxNFNDcTNzVEhMaE1uclNJSDRS?=
 =?iso-2022-jp?B?ajZqWUI3a3NZdHE1VlNoSnR6YmdGVE9nSkpHYmJ0YjltSkRDaTZzYVdX?=
 =?iso-2022-jp?B?NVRFcTB0dUdHUndmVnlnakFUUTNQL045VUFlb1B1azJaNFNTdjBoMjU1?=
 =?iso-2022-jp?B?UEhkUzZQSGRleDFGbDQ0SElMNytpQjh1c1dWaGQ5MUo2bXFrWGJJV1Bh?=
 =?iso-2022-jp?B?bVVST3ZCb1JkTndrS1d5TkdTbDlseEF6b0haeVNzVWdhRHppVXppNW9h?=
 =?iso-2022-jp?B?YStma1I1ZnFCNk43L3dPWHJ1N2hBaHdVYk5WbUFpNW9ra1d5VExWYXpx?=
 =?iso-2022-jp?B?VVlrTjkvcEI1RWU3YnczS0hNci96TU9zVlFWUXpPV1UwcEg2VndEdXJw?=
 =?iso-2022-jp?B?WWFTYVNJRFU1SDZnUUh2clphWCtTQ0dJbW9Oa0g3eUxYYTRVYVVPY09H?=
 =?iso-2022-jp?B?Y0cwNDZPZk9SN1NoSHo5RS9OWlFJNGpaWmhDWVpoam1paGw1aGZLVGJP?=
 =?iso-2022-jp?B?OEtyYnZBSE4yenIzUnNlSVBkYzIxY1hZZWFvVXROUC92TlpIdHBBL09l?=
 =?iso-2022-jp?B?VHpURWZiRDJTNHFGVHJtbWVpM1EyZmh0dHZFZzdBMm9kVmhpekhVZjQ0?=
 =?iso-2022-jp?B?QzFiQ2tRbE5DZCtLa2FpM3VhZ2FhTU5YSGQ3dWp5b0ZMS2FEMmRxMTRD?=
 =?iso-2022-jp?B?OURDeTdla2V6Tk0vL213N0ZzMTUvMmUrS2lzbmV3WVluSytZcThQZ3Fi?=
 =?iso-2022-jp?B?SSs3aW84TzVFd3I4SVMrREFnT2lGMDMxOGUxcGk0aUtwS0diNm9oUW1I?=
 =?iso-2022-jp?B?MGE0NVlVNFNBVFJCMVA1NXdLYWNyZk9udng5aUszUjhqbmRUR0g2VFhn?=
 =?iso-2022-jp?B?cll0S3MrdmZTYXRzZ2dDdU96bCtVdnNLcG01cU84amJ1ZURqRjhiZjlJ?=
 =?iso-2022-jp?B?R1c0TDFXblJUcnJCQW1UL3NwWS9iLzRRUkh5cDJjL2ZuT3lSaitrVHd6?=
 =?iso-2022-jp?B?ZDdET2M0a3F4SnV1azc3d3YySUZHMWtYNXA1bFg1U0NYRXFBN2JNU1lC?=
 =?iso-2022-jp?B?WExDUk40TDVBblZPMWJDRXJ4Z3QwRk9DVkFkMDlTdXMzN01EekVZWmJV?=
 =?iso-2022-jp?B?Y0QxOG4va1kvaWIrd1Q2Y21aQ2NsRERyZXM4QVV6SUI5UnVuVzllZllE?=
 =?iso-2022-jp?B?ZjltNmRFbjYzaDlHWjVPQVFBdXFmSFBOdWtRMVNxdGlyMEVhY2dNZjFx?=
 =?iso-2022-jp?B?MWhvOGp5MzlqMTh0d3NuUWJkY251WW9JWDVvcnk0M3Z3VmNJVUUvRGhV?=
 =?iso-2022-jp?B?aURDSjZURFdhMy84OGNIczlVbTl6RTFacE9GSUJzbjdQckV5S3lxVVha?=
 =?iso-2022-jp?B?djcwSHhySzJBRnZZd1ExcGtnZDhhcFZEZUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59599af1-cffa-40b9-44c7-08dde135a7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 04:37:51.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRbED6OOAU35ky6JRanpFn9A4f4qETuUQ5vIZUMcWpQe5nmtZmJOVdisead8qm5AJnKDRkut2va/PZlZIL3cdcmhYZnb6OCdUQC4FIZf0NfU2Bb/wog8sXRlF52XdQ62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 04:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19941

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, August 20, 2025 5:38 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
>=20
> Add RZ/G3E XSPI support to cip-6.1. Also backported clk and irq patches.
>=20
> All the patches in the series are cherry-picked from mainline.
>=20
> Biju Das (15):
>   dt-bindings: clock: renesas,r9a09g047-cpg: Add XSPI and GBETH PTP core
>     clocks
>   clk: renesas: r9a09g047: Add support for xspi mux and divider
>   clk: renesas: r9a09g047: Add XSPI clock/reset
>   memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
>   memory: renesas-rpc-if: Move rpcif_info definitions near to the user
>   dt-bindings: memory: Document RZ/G3E support
>   memory: renesas-rpc-if: Move rpc-if reg definitions
>   memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
>   memory: renesas-rpc-if: Add regmap to struct rpcif_info
>   memory: renesas-rpc-if: Add wrapper functions
>   memory: renesas-rpc-if: Add RZ/G3E xSPI support
>   spi: rpc-if: Add write support for memory-mapped area
>   irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
>   arm64: dts: renesas: r9a09g047: Add XSPI node
>   arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH
>=20
> Fabrizio Castro (1):
>   clk: renesas: rzv2h: Add missing include file
>=20
> Geert Uytterhoeven (1):
>   clk: renesas: Use str_on_off() helper
>=20
> John Madieu (1):
>   arm64: dts: renesas: r9a09g047: Add SYS node
>=20
> Lad Prabhakar (4):
>   clk: renesas: rzv2h: Skip monitor checks for external clocks
>   clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv
>     clocks
>   clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
>   clk: renesas: rzv2h: Add fixed-factor module clocks with status
>     reporting
>=20
>  .../renesas,rzg3e-xspi.yaml                   | 135 ++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  28 +
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  46 ++
>  drivers/clk/renesas/r9a09g047-cpg.c           |  39 +-
>  drivers/clk/renesas/renesas-cpg-mssr.c        |   3 +-
>  drivers/clk/renesas/rzg2l-cpg.c               |   5 +-
>  drivers/clk/renesas/rzv2h-cpg.c               | 126 +++-
>  drivers/clk/renesas/rzv2h-cpg.h               |  47 +-
>  drivers/irqchip/irq-renesas-rzv2h.c           |   4 +-
>  drivers/memory/renesas-rpc-if-regs.h          | 146 ++++
>  drivers/memory/renesas-rpc-if.c               | 689
> +++++++++++++-----
>  drivers/memory/renesas-xspi-if-regs.h         | 105 +++
>  drivers/spi/spi-rpc-if.c                      |  16 +-
>  .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   3 +
>  include/memory/renesas-rpc-if.h               |   4 +
>  15 files changed, 1201 insertions(+), 195 deletions(-)  create mode 1006=
44
> Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.
> yaml
>  create mode 100644 drivers/memory/renesas-rpc-if-regs.h
>  create mode 100644 drivers/memory/renesas-xspi-if-regs.h
>=20

I reviewed this series, LGTM.
I can apply, if there are no other comments and test was OK.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/199774253=
2

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


