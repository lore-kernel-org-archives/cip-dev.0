Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D94E784B8
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 02:14:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.131906.1766628848696877299
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 18:14:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=V4CuJJLD;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766628839;x=1767838439;bh=Dn6czM7BTBJAGuV1c01qwXv+goFA8wVS1D/It
	CcAJOQ=;b=V4CuJJLDohNJI8DlvTDV4B7WkEIEZFDM0ehtmNq6LzpEXVXWJb39SgX7riMu93Q9GBV
	knUuKDzSenPNUE1zFWiFadSbAuLzbw7fttS2wsX5kn1SPfqIOzraRH4L+1C2bllF+hNlz9RQGUzMt
	b3pstkvl3NQ0c4DTPqn2sPECQsEHSgApaBksvyDyDMzUs37hi63XphcEM0bLyvK67EuYM4KzpZi1g
	qgUxGJ3o9NlQ7TPuEBJ4gnW/z+EHnBZCRibIUCurPOXDPoZFFg8+1A5Xyv+bCKG7i+RZOhlAH4g3R
	E7lXzvUZ3tV4m8oc43rLCNp40ZnYj5Bb10FHLpAjE3xQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5BP2Dxo1522724; Thu, 25 Dec 2025 11:13:59 +0900
X-Iguazu-Qid: 2yAakGMokr5PKQj6pS
X-Iguazu-QSIG: v=2; s=0; t=1766628839; q=2yAakGMokr5PKQj6pS; m=Xqc+eB/sk+U1+j9KNV5svY1DyJXglrETCFkV+smvtKM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dcC3W02VQz1xnZ; Thu, 25 Dec 2025 11:13:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1EW30ck850oaj7fl/+AYMGxC8+8ZTModGm823byU48haf5ijZkXJpNTZPHUsBPNnBfy8MSuQFWeAnKYvbvLVfL1B5mCYCNgG4UFUpK5VxthJQuvwMYxMZCOUsNrRSnLZ9v/sACj+5FQJ70Ifg1W4ZyVKHrm0QCyF1r3UO5qZ1qNnfIc2mdjuDHSOVQBF7CEo5/Pz4kLEj+a9Aus45jheu87mZQ5xITeQzXYeb/uqywAVzA0iG4CEwfI8RYbO5Os4ynyLIR2farmpI7eRPNxOVLKVg4hF4d/qpDNiC52uvYjGB5ocLsILX1m21m1+zFS12sIM/zZoI/uqvjFO8ePUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkWw/YonO6//yDsLz/XUHRUMnXZls2v9mq3ojsf+G4I=;
 b=dmeqp5v6ANXo3JRiE4+4ertY2N7LiRrjSBxNmWNSXRL+eqzbD23bjtnnRL0r9plqeOKyERB4XjmCaFM68pgn9BEUVOUWB5WCljOEZCXNpWsfa15iesqO8t5iEDK/3fSZ4VXyg3kwF+cs7rEph/JTr/KJ336ZiYsV/JlFZRmUwLW8q39epLKN7Y93h7F8RJ5h0OR8GNOPRHI6z5q6f/skagXn4n4ABHALEYf/MSbJmKTeVe56A45K+OAo577tPG8otCQB68KdMJ6SO3FxTwnfCi4wGVoCX5VwH3aJmvxes+Cc7vry5xK/UCr3VNR7ckwKX5+jDkOJZYtPiZfdARwurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Thread-Topic: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Thread-Index: AQHcb0B2S5WiqidmNEKcvGyiDwvRarUxoEYw
Date: Thu, 25 Dec 2025 02:13:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB10057:EE_
x-ms-office365-filtering-correlation-id: 55716642-63bc-49ff-3efe-08de435b41eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M3BkTDRvWmFtMVViYU0yVFZiemRKYk5hcmdoUjJHeUZ5d2IwRjhRUmFH?=
 =?iso-2022-jp?B?Vi9ZbHZyYXU1RUJuSm8rR0VuRk1zakJ6RkEyRFdWWXdadnkxenZiQVdu?=
 =?iso-2022-jp?B?YTMwU1AzOCtCUHkwcGJBSEl0NWhhQzRQSTlhOWlTL1RnQkEwdTZtbTY1?=
 =?iso-2022-jp?B?R1VCZ1h0VlU1aFFFNWlrd0Nvb1F6M3NJMEtTRU5qTVBJUjF4RGNqOXVS?=
 =?iso-2022-jp?B?M2pFS0tNZ255SUQvazh0UDNUb2NsT3MxWGxWWmt5SUlzbVJmbmhkcWlZ?=
 =?iso-2022-jp?B?eFRESFo1MDQweEk2MTF0RW1wZU9MdHpzTHNtT2VJd1VyRTVRZFQvMWZl?=
 =?iso-2022-jp?B?UFh6TnRyUzByZzk2SkRSenBjcVptRU1sem82NnpxVlgwWE9oZERQamdm?=
 =?iso-2022-jp?B?TUNNODJURkk1VitMdTJ5cGRpSWplUWhpM0M2c0xXMFVRbjhyaVY5L3V2?=
 =?iso-2022-jp?B?OTZpdXUrRGVYR0FDcyt6L29XRXpPT2dsY1hPUWhwUVIwVUtMZXFHZTIx?=
 =?iso-2022-jp?B?L01SRFRXZmJKVUFPVEdidDI3ZmpSbGxGWHVVYkJMWEx1VXdQSTFUTFll?=
 =?iso-2022-jp?B?YU1ISk83QmhyaFQ5UmFPSC8vRnVWWWJBU0xwSmVFRWVFR2p3QzZ4MUlI?=
 =?iso-2022-jp?B?dUdmczhLQ0VCYmdWVnpYWGoyaVB5RjJxZkFqOCsxQ1ZkZ3ZBVjJoT2FT?=
 =?iso-2022-jp?B?VHNNQWE3dW9OaXN2YTByZ2NkQk1KUWJ1aFU5MVlJbER6ZWxONEZETEUx?=
 =?iso-2022-jp?B?MmRUR3o3dEp6ZStUNmtiRW9pNHZUMGhaQjBEOGhudUd0ZkVjclVYVVUw?=
 =?iso-2022-jp?B?REViNGx6d2JtZlBhMUFsekgrTk9VRDhaZEhCMWFrODhabG9CSEUzYU5P?=
 =?iso-2022-jp?B?TFFlTnlwckxDcXEvZEJVUkdSR3hIYm11TFYyWGVONWF5aUNPT2RHS0lS?=
 =?iso-2022-jp?B?bFpoTGtKMFllQUpNVnl2aDYzcG45SWtkZC9jc09zZldnVllobXBDOCtr?=
 =?iso-2022-jp?B?V1liR3V2ZlFVcGRCc3VSd0ozVGZtTnladVdwcWtNWndFZndxMWgxOHRy?=
 =?iso-2022-jp?B?ZmVJbXJDeE50dTVidkkvaHhjaXVjS2tTNlhtQWZwTDg4STVHNVZ5WWpS?=
 =?iso-2022-jp?B?Zk9nWTlSOHlDSjR5VHJFTVl2MkhwempYUHIvNFdOWUtCVzhlVFVIaC9E?=
 =?iso-2022-jp?B?VnNQcDJPQzE3YVQ2ekRPazFoWDdNazg1ZVBwOTF2ZHNHTEZTZFZlTTRB?=
 =?iso-2022-jp?B?VFdpVVhlazFRT1JwdkxnaHUwSWY0OE1VR2N2YWp5K1E3R0FVMitzMXU4?=
 =?iso-2022-jp?B?RE9PQWNQWjhsYXhGMmtuU0RlSHF0WlYzYTRtcVY3M3FUMTJKWDFadGRh?=
 =?iso-2022-jp?B?WmdHV0V5QmpCWTA4NzRuTjhZYk9YcjA1YmcxMDh1OHdXRTdJd2ppUlE2?=
 =?iso-2022-jp?B?eVZCYktXbE1tV0hJK0Z4cUo5Z211QVVZcG9QNVUxb3ZhSUlKNGJleE1l?=
 =?iso-2022-jp?B?NEtHNHJYMDV4NTh3eE92bTVOdWZQMHVUc3BXUmtFdHJ2S0doQWZvUDdS?=
 =?iso-2022-jp?B?WDVqaWhEaGx2eGRGckxYaHlPKzZweUdkVkpEMWxHWG9kWk91ODN3N2kz?=
 =?iso-2022-jp?B?dmZxTTVJU2I5ak9wQjdqakFENGg3NVppTHN4TG1ROERQQk1TZDA0TUJE?=
 =?iso-2022-jp?B?UlN4WUxqS1hwT1ZvNklmMmc1aTM3NWVwNFIzMVBCVlVZUDhEaDNzTGVh?=
 =?iso-2022-jp?B?UnZIRUhQaUVqZEJ1VXVqNjR3SFhZOERjWlBUNDNOTU8wRzBManJmS3RV?=
 =?iso-2022-jp?B?WHpXeWFEK0s4STFyMzZ1cUo3dmliVkJITzQ5Ulc2RXFnaVk5REJqWFRI?=
 =?iso-2022-jp?B?aTZGbk14VEhzSU1ubTlIUUZZMlh2R1VFMU1kb0FQK200YURRU3BUSnJx?=
 =?iso-2022-jp?B?a0hnckRpZXRxTThyK0ZhdWRUUTZNMGlKZXVWaHpjQXA3Q0F0ZmtRTHB3?=
 =?iso-2022-jp?B?N1p6WFA2Y1VYbzUzajlGbTJTNDdza3lwTzU2WEdZeWVOSnBzL04zVS9L?=
 =?iso-2022-jp?B?VnZTT2hROU1iZlRSN2UrVjROemFpNkJTeFBXYzh4Q1RYdlNiMWYzbWFC?=
 =?iso-2022-jp?B?cytoWkJRZjFBUUovZS8rYzQvOXp3dExMbWFQaHl5VnBBT1J5UUs4K1dz?=
 =?iso-2022-jp?B?UDJER2xvTUVoSldqRlBRQ0ZLQU1KTmxzRnh2VUs1RTRZSTk2dmltUVpP?=
 =?iso-2022-jp?B?bWo0Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OGROblZIOVQ3ZHdYRjBXMXVKelRrWHhNbmd1dkY3R1VGZFhKdE14SS9Y?=
 =?iso-2022-jp?B?ME4xZXB4QmJwc0RGNVpJMWxjZG9mdTR6UWlOTkxQcDg5Z28vSUN2MlNz?=
 =?iso-2022-jp?B?V2ZBYmc3eE85R2tNdjBEUkJWekNQVWdXb21vYks2NkRaalVLTXVVSjFB?=
 =?iso-2022-jp?B?T2o3Z2dNYkpnZFpvY3VBY25wRG8rNEZFSzFmQW9ISmE2WG9vYnNudVJT?=
 =?iso-2022-jp?B?bWw3WWRJdENrb2VBK3cwSjdaNDN1RFF5Z2l2d0IrNEQzVG5yamlsTEUv?=
 =?iso-2022-jp?B?TCs2b2VXZjVGSW1mUUhZWEVqZGR5ZkZHVlExYzVlTitNSjF6aVFBL0hh?=
 =?iso-2022-jp?B?Vnp3WFJYSGw5T1lzbEdHSVVNU1pzamxVYzM1VGY2MGZuWWllTFo3YmU4?=
 =?iso-2022-jp?B?RkhGenJtSFJBNllsY0hDc1lRaFM3NGR4QlNtVjh2c0RUcmFOSjJmQzZ3?=
 =?iso-2022-jp?B?bjN6eXU4ZzFPMExRV2p1cnlkWXlicmpjcmU0Z1ovaVpXNXZmM0FPN3FN?=
 =?iso-2022-jp?B?bCt6d0E0NGllOWZMdmdyQUxSODhTRU9IL2I3NXQ5Si8vME82VXJMcWVn?=
 =?iso-2022-jp?B?QWpYdSt1eG8zSzN3UUJCRFZMc0FLQWU1WDVVakJIR3Q0OEFwODlnVlNn?=
 =?iso-2022-jp?B?NUg0Ti9PY3VnOEpDL1pxd2ZIejdtWUg4R2YvQ05zRVlnVWFGckNsbWJI?=
 =?iso-2022-jp?B?ZGt0SHBWTGVVUWFmZXFZbk9pS0hWUlNGeU80VXZzb0pwdkhzeDFJeFl0?=
 =?iso-2022-jp?B?OVd2cXhIYityeGkzNkJBcDdoY0pHWEJDZDNHQ3cyT3dNazVHTlpjd1cw?=
 =?iso-2022-jp?B?RGowWnduK0FSSjFVVEpaM3B2Z3lXTXdVRG5SZENhRVc0b1psaXFJTlpI?=
 =?iso-2022-jp?B?cjlTSDcrSFp1eTIyY3dsR3JhTEExaC92SWtSZm5VWWRXQ1loNnpmNGp4?=
 =?iso-2022-jp?B?OUJsYWY2MkFETjRpdkFxOWlGSzJ1TUp0NkJSUVQ2OTRBM2lXK0Y0d2hB?=
 =?iso-2022-jp?B?TWhmY051alNsbjRHNkNOUVNqU0JvUnlWNXAyVVRXWGxMRThUSFdIT29l?=
 =?iso-2022-jp?B?dVB5V1hzN0xpZktSZ0RkNlFCL2Nqd205dXhZRU4zUnRWdGdnd3FGQUYr?=
 =?iso-2022-jp?B?UXdmL09CclV6RDhRYlUrUk4xanFPZi9Id3FZc0ZHTkMwQnVMcUlsejI0?=
 =?iso-2022-jp?B?ak9UUGRuMVJWL0FQcEtUa2tSdEFJTzFHOStPbGRrWnpNUDlEMjd3ejNZ?=
 =?iso-2022-jp?B?SEo2OUZmQkR2VlQ2MU16S2s1blNnTzdzZFp1RldXZlRhd09YQ3hjZENl?=
 =?iso-2022-jp?B?bWI2L2F3QlFvelpzU1hoZU1RQjllR1NCQlhTVkRhckZqbTJZYzEwOGR3?=
 =?iso-2022-jp?B?Y1c3ZURlcC9VNjIvb3FiRUorbFJEWnozelZEZW5lMXV0LzFLSU5YQ3Nv?=
 =?iso-2022-jp?B?aVQwbzU2V3c5L0dGMlJvSUtoMzFwcFgzV0ZHRnJlU051RHJKYVZqejhi?=
 =?iso-2022-jp?B?L3RtSGpzdy9XRDcrbDBNMlVqZ25rd0x0TTg4MHFCQVhRT1pEdkNUMlN6?=
 =?iso-2022-jp?B?VTJrWjBvYWpTT1VuWno3VWl0NXJxSHJ1d0RtY2kzMGVCWUpkVU9oenlt?=
 =?iso-2022-jp?B?ZXIwM2NDdVAvNTN2NFBKNmJwMmFPK1BWU2lLVTUySEFUUjVkRzdXaXlX?=
 =?iso-2022-jp?B?anQ4RllwSndaREFPVGdzTURKTWVTb256Znh1eE9CUDE0Y0xPZ244allL?=
 =?iso-2022-jp?B?Z0V3ZnlyNm1GRllhakxiVlhuN1huWW9OVFhvTG5KUjducmQxWTBNczh4?=
 =?iso-2022-jp?B?WHhGekVhTHZoMlVpTGVQUDBlU3pyZW1Nb3lUdzZFeTAvN2VZdDg2V3dH?=
 =?iso-2022-jp?B?bFlNV2g5aVh6N3IvU2lZMWZtdHFodmptaHlXam1GN0d3dit4Z3MyN25J?=
 =?iso-2022-jp?B?U0VjZDBRZEFjQnRJcVVlSXBLc1F4bTh4UGRHb2dWWFMzQWprWjIzVUQ5?=
 =?iso-2022-jp?B?NlJWZTBkSlc4M1BmenJjVWtxTU1yYzcyUFNFbzE1QjJySlovV0ZzajVr?=
 =?iso-2022-jp?B?aFJSNUx0RThGWjQyMmdpeStQQmMwRHlzRGh4TjNXMVU0UktJVDBQeVd5?=
 =?iso-2022-jp?B?bXhGU2xoSForR3pTK3RIU3lBUmlOVlJhYkYzVEY1S2xSSEk5dHRpQUZi?=
 =?iso-2022-jp?B?WlZrQ2xOWkN1M3RoMUNWRllrTkJPUVlpVkVYNis1MHJiWnkvRDF0ajY2?=
 =?iso-2022-jp?B?eXJ0RU5VaEt0ZW41WHp4R0ozUnNNOWJtcVNkd2RJTlRDcWJKKzdMOWZp?=
 =?iso-2022-jp?B?UXI5MS80YUswdktNRm1MSXRZRXBlUDdBQ3dBVVFMMjRHWXpZMkhwYlR2?=
 =?iso-2022-jp?B?d2kwYldIQUo1bWhpdEVIUGhONU9lVjdxVGpLQ1E3MDhGZGtpT082dFlz?=
 =?iso-2022-jp?B?Y3JudDNyaHkzWExDOEY3dUcwNDJuZHcyMFRGM2RIbHc1OFNLcjEzYzlI?=
 =?iso-2022-jp?B?Tk0yYlpkZ1JHcER4T1J5U3FFVlprdWdaZnVCVnhvZmJ4a2d1Y3RSM2Zm?=
 =?iso-2022-jp?B?ZzdvWGRsST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55716642-63bc-49ff-3efe-08de435b41eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 02:13:55.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqMQXYeUVq+l2fwuoKtnf+9BFsB0sqc/BvID7ubCDq8kQvESv2FjDzYXFjG5R4kWjEqymItqQCznq0sjJzPOl+Pnyw1ocdtp7ZJfeOe0DraP0WPvtvXpzE3nOAp0kYRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10057
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Dec 2025 02:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21217

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, December 17, 2025 7:32 PM
> To: pavel@denx.de; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B"=
"#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.
>=20
> Thank you,
> Claudiu
>=20
> Claudiu Beznea (6):
>   clk: renesas: r9a08g045: Add clocks, resets and power domain support
>     for the TSU IP
>   dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
>   thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas
>     RZ/G3S SoC
>   arm64: dts: renesas: r9a08g045: Add OPP table
>   arm64: dts: renesas: r9a08g045: Add TSU node
>   arm64: defconfig: Enable Renesas RZ/G3S thermal driver
>=20
>  .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++++-
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
>  drivers/thermal/renesas/Kconfig               |   8 +
>  drivers/thermal/renesas/Makefile              |   1 +
>  drivers/thermal/renesas/rzg3s_thermal.c       | 274
> ++++++++++++++++++
>  9 files changed, 465 insertions(+), 5 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
>  create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c
>=20

I reviewed this series for each branches, looks good to me.
I can apply this if testing is no issue and there are no other comments.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223211991=
3
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223212062=
9
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223212071=
3

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>


