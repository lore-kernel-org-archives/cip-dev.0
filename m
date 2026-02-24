Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176AAEFB7E9
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 02:23:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11694.1771899835248827619
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 18:23:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=JXZfMPvS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1771899833;x=1773109433;bh=+BJ+4/Tdn60bp2XeOMtx3B/d7Zc8M54ZV84SB
	s96o1Q=;b=JXZfMPvSiaUX+BVaGC9ddmV6KZ6/ZWPm2FZvUmq28qNVgCvVmXfSbPb1ZaqlTllwTyZ
	RW0qJe9cJ5xbRa6y8Cw3F8vFaVVSmOPW/atFswPvBck/tLDOYAXHd1y8cnpyRXsHhP/BaJxrvmHlH
	qtp0z1+BHhxQRaxHyuWobg2qcBuJLK/PbAsW1BjsRFWEXlTivNm4/xH3rRvSTjeu0xpEt0/kULYE5
	ZcfihcKG5i0KOEBFQLA1Rl6QxjpN3tg4nGKOO2CiOTzGfEnvI//ERPlBINw5wYRtT2+GaN0i4fr2Q
	UxSDfNW+6Cg0wKR17a6V1pNNIhJb/VPVW4cRcLriKbWw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 61O2NrPc2746032; Tue, 24 Feb 2026 11:23:53 +0900
X-Iguazu-Qid: 2yAb9zgpPTV0y3tmFg
X-Iguazu-QSIG: v=2; s=0; t=1771899833; q=2yAb9zgpPTV0y3tmFg; m=LHRuOjy8YT3yIO8Z8XyXuClyrHAfpAOYvAPnl/9Yv9I=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fKhNm6CjzzyPQ; Tue, 24 Feb 2026 11:23:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAXZKBHCAz2wMo7u6gMQsPjkr5x7FrDFAep6YFz5f/ELQ/r+3P7YReAqL2CPW9Lj3pkg+Op6AxopWx9lPH1tp/8G+BKq0uZXoQYZ/tqbd7DZt97gh2sdbwUpLh+2EW0KeHtBYg0R1wVXlgYqJvOZ77qhi9Zu5QIePGQMS5bjZ3ETamqD0MqvXx/hGRNlSAK0npFsnDaPdLx3WqdbIy15WGnyoVvqWUkyXVhNpcQwdDZ2bOz46KorQ7MdVI908881y/4E1kHzFvry2CgHSWIStvASImOwSgJQ8/ePHaYpt93cIV3X8RKmuOmPzAWoTxJdggSu0LiQoqXpw/xELZ1bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY8Che3WYwoKO13Mt+b/UzYJibqjoYEH+AWLiV43lKQ=;
 b=KF1bcixOKIYdPQg8imVgvX5YnngBoInon6MjogdyTnB6Gi1GwXl0o4ZY63OWgOoJIYqfpdvf9xFa8EGt7CsZxL8/dAwF6mk34kKmH1yjFEkfaaxZ+ofI2eIfs/Sxp8SJzcuBSRehT02rKYT+2aAMiJxJZFEXIouYGlPeVkYcTDW0ag586/NBA3L8Y7yZXLm7EjXa5Bxle92iVXzPgPUI6qQcIN/PxYEJvRbiu1afNtW7MaPIsEOtW8yzNhL/nfMZWC++HvebBWlTxJEUe01mkbCSKvhGSpq237jvqljBb1pDghRLX5tW+guGK3Yq/7m7nty2h1+nQE/x7G9VKIwGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N GPU support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N GPU support
Thread-Index: AQHcpK8P9ufpbAqmmU6X8E+6J9iPf7WQO5kAgADkGFA=
Date: Tue, 24 Feb 2026 02:23:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481888F710C7387AF6E47F7ACD74A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260223102738.119897-1-ovidiu.panait.rb@renesas.com>
 <aZxMPILbB/pLPwH/@duo.ucw.cz>
In-Reply-To: <aZxMPILbB/pLPwH/@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB16001:EE_
x-ms-office365-filtering-correlation-id: f3249177-1d38-4e00-d31c-08de734bbf6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|14052099004|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RytlZGh3N0NYbFZZQUxoZjlmeGVaVUxWeE5yUGxkSncxdW1tM0VpVjJ4?=
 =?iso-2022-jp?B?UStqTDNoZitIaStQcGtOVXNUWWxqcjZPNEFwZUVuTDh0S2VRUlFZRjBG?=
 =?iso-2022-jp?B?NnI0Y2VSc3VmQzEzcC9TbWxyM2pkcXBzclJlNFRWNkRWMkRuNVhacUVi?=
 =?iso-2022-jp?B?Mi91REZjM1N5QnVGS3d4dDJUUTFjN0I1V1RaY0o4RkJuek9uRUhNL3BU?=
 =?iso-2022-jp?B?b3hQaGppcm9jamgyOEQra3hrb0hDUHYrNE51Q2o0MkpHaEFITGRRWGxy?=
 =?iso-2022-jp?B?WFBwYkdFb3dQZWFnRDU1dG5OYzM5TmlEUEI1V3VFZmxtUmRVcEZ1OHAy?=
 =?iso-2022-jp?B?REt1SDZZQU40Unk0WVJxQ2VJTXZnTWpEbVlpVkh2MzdlRHJFbVB6dzhh?=
 =?iso-2022-jp?B?MjdPc3d0THI5Slg3ZlViOUhGUGE4azEyTi84a1RGZVBHU2J6SzdaUW56?=
 =?iso-2022-jp?B?QUNxV3NONndDaFRSY1cvemEwR2VvcnZMeHVsMzB3bWhMSHp5UnBUalQ0?=
 =?iso-2022-jp?B?KzNKMlI1SFliNWhGZTJkblFhRnZTbDVnL1RQb1BFbm9oU2EvN0NJWGhJ?=
 =?iso-2022-jp?B?dkx2czljcVNZcy96Tm5HUUlCUmlNck5DVXdNUDhXZGtVZDQ0cFd0MDBy?=
 =?iso-2022-jp?B?ajVicTVjOGZqOW0rMjlvbStMak5NNVN5cnF6TUR1bk1Qb1FFTWN6Q0dq?=
 =?iso-2022-jp?B?dmJrZUUrWFNHTG9YcC96NHBNOTlFUzAzMFh6VXdBL2dpTlp1OVB2VmJO?=
 =?iso-2022-jp?B?WXRFN2hBMngra1NvN0dxU0h1OTZVeWtWS0ZMQTZVOVJ6N3dmOUtZeXl0?=
 =?iso-2022-jp?B?UWZSUjJtSlNsazlhbHAwN3BkSXh0MTBCbDdUZjRCUlgxQnV6OTl6aFlV?=
 =?iso-2022-jp?B?OERzWVNhWlZ3SUhrZmRCUXUvNU5qVzVSdVpjdHFmWmpzUVRHQlJxK2FP?=
 =?iso-2022-jp?B?bU5YMzJrRUJKZlc4T3lMbmdwenQwazY2ckt0YktWWHdVNVJSNkE1aEFi?=
 =?iso-2022-jp?B?VUhOMDdIOEIvU2E0cEduMmdKRC8xajF5ZjJ5MUNGeFlYWVVueGZsN1Zu?=
 =?iso-2022-jp?B?Q0xTVVhwN2RDLzFFTkhZMDRNSGFGL25RVUhxZ000Zjk2b0IrekVPTnNq?=
 =?iso-2022-jp?B?N3Q4SzNvdTlldUpTbHliVE1rU2swOGp1SFpoOEhTTWx3WUwvMGNTYmpG?=
 =?iso-2022-jp?B?WC91REVQZVFxYVlxbzk1dCtjTXVFa2lmSU9BTUZyTDNsMG5vbWQ3RG9G?=
 =?iso-2022-jp?B?YlpzMWpVSG96akF6YTN2dllQV2E1WW5hVjZ3V1hMaEl2NFk3eTZGSmQ1?=
 =?iso-2022-jp?B?clZneGRma2FlUXRUenoxQk9DUzhNR3RReEx0MWs1V0I0QWUxYzJKOUda?=
 =?iso-2022-jp?B?Qk9kSDIzZTlRREV0S2pHSTQrMlp3MG96N0Y1bXhxYjdDSHAvTDEwMkw0?=
 =?iso-2022-jp?B?QS9kYmovbm9mMDB6TnNDQzNDOG51eTQ0cXE4R2JOb2NPSmhPMWRVYk5D?=
 =?iso-2022-jp?B?TjlSZ3IzS3hqYTRSeFpHRXBLQXBHWGF1WnpjNkxhNHhoRkNrVXBtMHJC?=
 =?iso-2022-jp?B?dnk2NXR1QmRRN3lCR0RFbmd1a3BYbndNTFNXcUFMakZxOXZPVkFuWnlV?=
 =?iso-2022-jp?B?cmFqZGc1bzhPeGhaNmhCT09rZ0FkanJRK2hxN25hdmI2U0dyR1RRZDZy?=
 =?iso-2022-jp?B?dVVKUnNnZTlaSnAvRU1rUGN0eWFXVzFRL2pMKzRMMUxhT2hTZjVjazVN?=
 =?iso-2022-jp?B?SVJycGExb1dCRXNXbXJ4K2x6ampoN0RnOFBoeVNwZGRYbVMwNWVvTFVY?=
 =?iso-2022-jp?B?K1MvUGt4TkVlbzlVc2FzUFE0dU5sbllVT2pBMXErbEhvUFErRnZrSmVr?=
 =?iso-2022-jp?B?M0JOZzVHdmNSM0MrWnBQME9EdW8za0gydDdaZGlmcFZvVGxnSTRTcEM2?=
 =?iso-2022-jp?B?RStCM0VtVzFOWGFzdStFZFNUdWNtYWlrMHNXYzdNd1FhOGMxVisvT1h0?=
 =?iso-2022-jp?B?R0IyRy9PT21PYzVwSTBNbWNNc3Y1Tk5vTmJBUUwySkpOSllVU24reDU4?=
 =?iso-2022-jp?B?N1FISjdQVHQzbVk3MW5KUW9yMTFhTmVOZ0gySFJJeUZTN21CRkNmand3?=
 =?iso-2022-jp?B?cnE1aDFXaXpCWkJFTXdaSmY2NmNLTHl0dndsYThuSlZwaVhxeXdiZFhG?=
 =?iso-2022-jp?B?WUhOVWFIb3JkUVcrWlNjcnc2cWluYk9sdDVwMHFrREhPNEdNWkwvdExr?=
 =?iso-2022-jp?B?Qmptb2RaNUJ4MjBybHJ3NXlkeWtoS3VoNXY0cWhXcUhQZXFZc25GSHBX?=
 =?iso-2022-jp?B?elhrMWR2dERPL05McE0xTWlLUWlBSFE3RG5jZWxkWDVyc3Q2Szl6MU4w?=
 =?iso-2022-jp?B?SFhjYm89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(14052099004)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bFh4eTBBbythSEVJV3FCVnFiMzlTSVYrT1dDZzJkeTh3Z2xLdnlaYjNM?=
 =?iso-2022-jp?B?MkpoYTlIUDJ1dXRlSGpGbnRaY2QyeVFoT1haRGJRMVF3RnVScmljQ2Ra?=
 =?iso-2022-jp?B?amNnNldKeEI1U0JkNWdkQW1XMVlMbHJ4NVkrY2VvcWVzaXhTWWFKTHds?=
 =?iso-2022-jp?B?a0UvcmdYMnU1dldabDY3SzFCdFlyOGlkdGtnTU82N2dLbVNQS3Y3WCs0?=
 =?iso-2022-jp?B?Ym1UVGxVcWFYbmNHWUJZcEo1dVJDWngrM24xRWpEZC9ETmtoczRTVzFV?=
 =?iso-2022-jp?B?OGN5cG9BYlY1c0ZFU0NVcEhlb2JWRklPejBYY3JaRGZtdmVtTnMwanYr?=
 =?iso-2022-jp?B?T1NjRFhsNHhIYytTMmRrY0IwL3hUS3YwaWxWUXN4cTZWSG5hZEswaGdQ?=
 =?iso-2022-jp?B?c1k0emdEWGdZTGp1SndPSXBPRlNiZUFxZE1KZWYzR2wrSUo3eFhxNVdC?=
 =?iso-2022-jp?B?Umw5WmZSK1E2Qk11cTJDZ1pGVC9VdGNYS0ZBZ1Z0TVp2YllqNHpOaGIz?=
 =?iso-2022-jp?B?YkVMWVVsbVdsNUlMQUpZbXRXbVd3RzVzcWhlNUdDUyt2NG9FWWJUVzhq?=
 =?iso-2022-jp?B?a0QwaEtqby9CZE1lcGx2UHRkNXlHZ09pZitRUklWdjJrRFp3eFlKRjFI?=
 =?iso-2022-jp?B?WlgrUmsrMXc0WHJSRmcxcjkxZzZhVHZjY2hnaTFINFBWT1FZKzBLZFo3?=
 =?iso-2022-jp?B?cUFaWURETHlSdFNMRVFiRmJETjErVjNMV2VaSnd2N1gyUFE5QlVYZHFX?=
 =?iso-2022-jp?B?S0RlcU53bllvWEpyTkpLaERkMlExOG9nNW1FZjRTV29SdUJsdllwYmo0?=
 =?iso-2022-jp?B?dW81K0FseXh6bittbTFqRjNTUXoxQXJYQWx0ZVNTRG9tdVRpV1RzMGd2?=
 =?iso-2022-jp?B?SmRKckxzblJxNEtMbkRiTlorYzdiaEhVejJ2aldyQWFuWkI3a2t1SVRu?=
 =?iso-2022-jp?B?eU9CMWdkT0hJYThFVTdIMWc1d3A3WmV6cG53YndmMjlGc21kTnBVTHVk?=
 =?iso-2022-jp?B?QzUwV3p6aUNhT3RsWEJ4RFVFS0E3TytWclVsQ1hNSWtTM2RiVkRrQnNU?=
 =?iso-2022-jp?B?MmhpMVUrMjZFTnhHdmVkdUUxcDBZMyt6bUZxTVpqQjVWQVdmaCtia1Fh?=
 =?iso-2022-jp?B?SDlyNFczZjRwSTFWMzFzU2ppRjJOejhHdHBCUjNJK3d1aGhVejg0RlJT?=
 =?iso-2022-jp?B?Y0FPSW9kaUVWV3RZem5rdEJuTzFoQTkxTG1OekJKTkNQTWgwMmNDS2Nl?=
 =?iso-2022-jp?B?c1pyZkQ5QWs0ellNMDRoVlRqT0YyMEErc3VydFgzczUrUGZDbExONW10?=
 =?iso-2022-jp?B?OFd2VEo5Smg3SklJMFhFK29lM2I2VE9wK01kQmRBcHoyRXB6T2gzTXBI?=
 =?iso-2022-jp?B?OWY1MXk3bGQzaURTZjVjeFBXbitNanpWaFVrWmc0YlV4Mm1Bc0Ewb3Fr?=
 =?iso-2022-jp?B?ZEwyUjRKZmRCTzVVUm5Md2dIV1Y5cUd6Z2l4MXhXb3RyNkcyWi9rMm01?=
 =?iso-2022-jp?B?ZDZyeTR4MGlnMEtyWXNEcHR6WDhDcHAvSjZTRXRzS0lpL2dIcFZyczVF?=
 =?iso-2022-jp?B?UmNkTDNXbDZBSlBTb010RFRwTU5OTWxBcU0zSUlMcUpiUzBjMGVUN3Bu?=
 =?iso-2022-jp?B?MlU4c0c0V0JXbU9CVU1KanFoQ3hHOW1KYjN5UDFjU1M1Vm04eEtDVzUv?=
 =?iso-2022-jp?B?SGNzY3FodW5yZm05cFppUXd4SmIrQmNGODhKQ0FtbkZOM2NjVEhtZndv?=
 =?iso-2022-jp?B?cDlXSWpBSWN0QWxoTmpUVk96Wkg3Y1VaM3RuTkdCSVZTclhKV243Titu?=
 =?iso-2022-jp?B?aUJUYzBmUzRWUkxaTDN4V1NyUDNMb2hQdXcwT2hhdmpoeFRKbEhJV3ox?=
 =?iso-2022-jp?B?bDBobXVtallGQ0pLdnpRWE5xYzdha1NpSEp4c1pwb0FhM3NTRHBselpJ?=
 =?iso-2022-jp?B?WVlNb2IwUHREcnlSSmYzRUhzZzVra2lYYnBrclV6NHhrZmNmOHkzTG1B?=
 =?iso-2022-jp?B?SDdzZmE0TFdkVEd5Y1FvRmVXN0NacUh3MGd6OEZaQjVLOFByMDNjTDFU?=
 =?iso-2022-jp?B?NHJJQ0U2NEtTMHJScmhmak5ZQXBiV0xkUm4wc1NPUEcvVXhUbk1oL2Q2?=
 =?iso-2022-jp?B?R1dpVC9CTkhxaDVoTmU4cHFobjJEU3BXanBLbWdXZGhDUUN3Ym9JUTZR?=
 =?iso-2022-jp?B?OXowUXBFMTBReHkwaFBjZSt5eFFYQ1pXYU95ZEhGV055UGk0RDd3VUxw?=
 =?iso-2022-jp?B?V1hyR1QvL3FoYkNMd01xVTZ2N0lOOE44dzhhUlR2K0szWCtoUXgrY0ln?=
 =?iso-2022-jp?B?Mlo1YmpMVU1RbDRlQ3pPVEtzcC9mdEUyR0FoK3VjYnRTYjgzYnVGKzlE?=
 =?iso-2022-jp?B?eHllOWVJckZuQnNXREpNNUkyTFNhMkprcG5QQmMwMG9JcmwwWFV5bU84?=
 =?iso-2022-jp?B?WWlVa28yKzBEbnFLc3pvOWNXdTY3QlgyWXYwNzU3M1p2bHJ1RzVzNjJT?=
 =?iso-2022-jp?B?NGpKYXBEVHZXK1JTQUFpdURiamFMTWlIV3hybmlWYnVyL3FjdWFoTW9a?=
 =?iso-2022-jp?B?akZ2UXJ0OD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3249177-1d38-4e00-d31c-08de734bbf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 02:23:50.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4t8tkjM33zTQV1giBAftsPKkPsqDjFRYZLgorRB5UzRf1jNwRH6T1RWBfgszjiaVn6hy/61M42FK0yB7SROCnlydQ6Nxu/ol8hxmiDJHJX+b5scy3S05pRWCW50ZH/Z3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 02:23:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21920

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, February 23, 2026 9:47 PM
> To: ovidiu.panait.rb@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N GPU support
>=20
> Hi!
>=20
> > This series adds GPU (Mali-G31) support for the Renesas RZ/V2N SoC.
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

I reviewed this series, looks good to me too.
I will apply and push with Pavel's reviewed-by tag.


> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


