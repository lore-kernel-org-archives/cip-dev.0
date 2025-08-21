Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1858CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 01:31:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.1463.1755739879719519046
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 18:31:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=FjrPb02T;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1755739854;x=1756949454;bh=
	yvDUT5MdwO4Y27uy3JBI4EtkjBqFZ5MTHFxRuVdlsMo=;b=FjrPb02TRr0PDa72xSTFuMe0PwXgrT
	uLiI5ha8hUbOmcwsfDgYeLX3dBF162FhS7Ve2LKeG2dYQDAEMzltmRdlgid13Pnpl3YmudqPtVidT
	hzfK7/UtuSOXml1Oe+2hirJOSeNNf9M1rLO0x+4FsbIyohVTW+z5UsffHKrsbDDJdsBPMXPSXQyOR
	0kiAQxmv9NoMfTD+C/KF3zt0P+jvY24uV3KM+pt7pKrzfM4yNmn2XVOekXeU1OCY0QqCORhnctPgX
	BChRPSrW32EgG61xoQx7Dhjb7aVy6nIFPmHm+Jxd5kRV7x1YV53sogWwU+dCbHtHrNN1nmhIWkl4q
	L39Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 57L1UrRV4192856; Thu, 21 Aug 2025 10:30:53 +0900
X-Iguazu-Qid: 2yAbAvUQQc9uMysV73
X-Iguazu-QSIG: v=2; s=0; t=1755739853; q=2yAbAvUQQc9uMysV73; m=Riq2QxTJt35iwj73+adnwTZxR4HXDSIeQuFUqqVKfEU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c6m3v5NBXz1xnk; Thu, 21 Aug 2025 10:30:51 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0/Ep1eP53X9/XWQniLCsAg7UMpGdkzdzSWf7ikswNleJunnizsilupFQH2DQN+H0t4kBbmgK1wXlGSjjHbVuRsgBC28F4AlujSU6WpNMWe1/7+KtRbcYRVPOqhfUFX/t0MoFYwwp1dgB4592t2u9Njw5nQsc9j+qwQvLp4aZggGEEvXsN5jR6AziPtzXgWLDPIBQR6KjXawDeAKEOQSU1sdW423/aNOCq/cFFmfK4TIDtZ8fLdJ1SQDzT1o0LqNAwj561kpJc/RaxCvrRJoZpyDqLW6E5HrBYBq8KjKpg6uBI95/a8UzWZxSvqXJu9NZpgBdWymW2KqimR3udJNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUp6rXtxG05IBEWbgTlt4gs6zXkYD8aSGmJTiD0nmts=;
 b=PY/HQyPbVMu1dpWaPjDjroh/BnR8x3e+4fh4Zgy8F+CEP3jtzF9FkMTEAMAH3a37W6+G2Wdt/dydHuqbzq5/3z2NpC6r5vjVsyyN0juAeTpi3g+3ojxom2L/1LTWtNCiqZ+XtYRLlvgQ52xbyG5q8uIylkhq8TTh8wVNi00dE+WhT6ZIvFSvCYWUc01GCx2EOTxTuYR3Fql3pb5tKf8Pc98Y2qeSAJrCV59V+IW3gBciINE0Zz3R/RumTMaX7M/SzcmZOR2h5EtbBuwgXwOU5vgZ1hWwe5LaZJJ6DZy45Pbuo0aeXXXwH5VRXke1UuVQnVGuMwayBNQEHeHH1Bc7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <chris.paterson2@renesas.com>, <pavel@denx.de>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.240-cip63
Thread-Topic: [ANNOUNCE] Release v5.10.240-cip63
Thread-Index: AdwSOyZwn3tE6cWQTUGRI2KhXPB6ng==
Date: Thu, 21 Aug 2025 01:30:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818858E4DE54D6BCF107162CD32A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15017:EE_
x-ms-office365-filtering-correlation-id: c1b0b8e6-05d0-47a9-ffbc-08dde0525c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TEY4MnVQOGNMbVF1YnQ3KzBTelhoSWs1dHRBMkhGUG4xRjhEY2MybHlq?=
 =?iso-2022-jp?B?NHExd0dVRTBlL0JIODZCVXpaMXllUDcyZjJBVjFYc2RUMGlNanErTVp4?=
 =?iso-2022-jp?B?eEllOWpJbHp4SlZscStIdVAzUU4rWUoxUTVJNUN2UFEvY2ZHYVVRQWJG?=
 =?iso-2022-jp?B?VFNMSjN5Z2hBNm1SVkZQckl6Qjc4SmlIVGU4L3ZCK0FaVDNuL0E4c1o3?=
 =?iso-2022-jp?B?QU9SYUVTVFZTR2FHRmJxQy8wUmpUVUtHTDhHTVd0SHJEN1dIMzJ1cG1l?=
 =?iso-2022-jp?B?L2p5VzlvODEzWmk1REl1dzQydDdLOHo1MU9ROGFxb3c3MXpoaWJDM05P?=
 =?iso-2022-jp?B?WEFhaTB2SlhhUmJ0MGpYczAxWi9nWnY2ancyODJ4MWR1QzBkUzB2K2tC?=
 =?iso-2022-jp?B?YzlXdXpWM0c0ano3K3dMOVA4N3VPUjd2WEZ5Wm9majF1aG1yK1A5Qklo?=
 =?iso-2022-jp?B?YkVHSlZwQ3pxK3B3dEtldG9mMjZOK09lTFlhV01YaCtNRHEyN0c3aEox?=
 =?iso-2022-jp?B?QmZhZWRISm5iR01HQzkzREhEL0tReFVIZFVFTGJObitCN0NDM3diNmt3?=
 =?iso-2022-jp?B?SnY1NCtJRU5VeE1wOHBrMW90djFYQy9ISXJwQmt5QnZZTTFOdDBmNVM3?=
 =?iso-2022-jp?B?N3JWaG5yWkpmSnpBK2JxYkIzejdxdzZlSkZQRTJrTzd0TlE4ZFkyK0N3?=
 =?iso-2022-jp?B?TncvUGEyZVhSZGFUNnJGWmFmWFg5ZDIvRkZDb25QK3B0SG9DY1NpNTV4?=
 =?iso-2022-jp?B?VUd4WllOdUlPR09nWHdaSWRaWTJFZEhXN1ZLVUxrb1ZrRkZrNHFqRVVP?=
 =?iso-2022-jp?B?SUdpN1o5dTAwakJjSGZ3UTJsZGNUV3ptOWJFVWhsUk1EUHNHbGRSUXUv?=
 =?iso-2022-jp?B?VHY3OFNpVmFqUFpyY3YyOFBmaGx4T2Q3TXZRNzJySGhsNXQwdG5uRjk3?=
 =?iso-2022-jp?B?Mzd3QW5yaGN0YldGL0dBOUMycm9MUVB1cXZGTGRzSnc5dXJHN2xyaXN1?=
 =?iso-2022-jp?B?cEhsbU5GQ3NuZ0p1dW9wc3VZcVEyWkgwc0JLSmwwR3k3N2FLaHZ0ckpI?=
 =?iso-2022-jp?B?Y2FVR1BPNnZ3d2txWFJWU3kvVUNzVDR6Mk1xY2UzOW04ZUxrbkdYL2lF?=
 =?iso-2022-jp?B?bFZ3Q0tsSE1XUGE5MTdQaUlqQVJZSGtjdTZrVDkvNkxDQ3poRk5TaEt4?=
 =?iso-2022-jp?B?YmJ0OEFicDZyWjl1UERDL25MQ1VuRGZPVjVKenE2b01OY3VBcW5iR3Rk?=
 =?iso-2022-jp?B?bEtFK3drejNCeW9mRWtPNXdNR3ltdlUvckFkcjN0dGV1NkZQeWpHRFNB?=
 =?iso-2022-jp?B?YXNwbU1SOXhqTmtlSHoyUFRQeElFYUxLZHFxdWZicFRlc21jRW90aEtJ?=
 =?iso-2022-jp?B?MGVOTUJlZGNMdWVrWHVNci9kNXFjdUFmWC9JNDAxU09iT0xZVFFqQzZD?=
 =?iso-2022-jp?B?Sy9LY21jQndkYjdtQ3RSRUhJajAvNXRzM2JXSW93c2QxRzRyanJWUG9W?=
 =?iso-2022-jp?B?aHhmU21pUEE3cGlyNkozVk9ZQ1pwWXpyc3FYdTBzSWpmVFByeVplR3I0?=
 =?iso-2022-jp?B?SWJDY3VTeUVYVkRVRHVzcE45bXVNNDhlVXNXeGZmT21XOUM2dTdxT0tp?=
 =?iso-2022-jp?B?KzNyWDlzRWJaMXhwejJQcWlEaE1Kd0h4bmVGcDFXc1RXdXc3c0dGWUNR?=
 =?iso-2022-jp?B?dDBVbzBwb2J1ZHRFTElOcW1CWXgwcUw1THlFa3c0WUN0enQzSnBrV0ht?=
 =?iso-2022-jp?B?T3E0Tm5hMXMrdzJ1OVhhaUdudXNuV3hidjIzNnJmVjA2cTF4QnNrNzJj?=
 =?iso-2022-jp?B?cFVzTVRLYTNMTmI4Ulgwb1EwRVdBVFlETmhwYllJMGZlRlJHMG5VbTJj?=
 =?iso-2022-jp?B?aHVzTWt0TCthZDFqbkQ2L0xQNE5OVU4rUmxWbHN2ekozZHVtQk14QlB3?=
 =?iso-2022-jp?B?dW1ITFBTNCtaZ2VpVXRrbjU1UWU3cEJMbWpld0NaZWJ4UjkyaUorRmoy?=
 =?iso-2022-jp?B?aEhOTnJleFAzQWZGSmJBZnZ4alBrY3lZTitrRXZlWm1NQjFQYmJUTnpy?=
 =?iso-2022-jp?B?d0ZocVFzcUtTeVRKaU1MU2hLdnNTalhsNkFRek8yNzA5aFFId2gvUjB3?=
 =?iso-2022-jp?B?T0U3NnJVR2ZiTnhWM2dBckVpUGM2anB0Z0w1cXdzc2FVaGdKaXVlYmQy?=
 =?iso-2022-jp?B?RUNZPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dndPYlZOZVhYZ1l6WVpLZFU0bFVESkdEZTk4TVFwTDZXbFhwQXJaUkIw?=
 =?iso-2022-jp?B?eHl6bEpTVDFITWIwbmpoYkJzN1BCdFkxRjlsWWFjbWpzZ2NXNm5rNWRu?=
 =?iso-2022-jp?B?ZGIyYUZBTGF1Tnl5eDRiQ21uNjlVU3ZsMHZNZmQydXZiaW9DYjloaFV1?=
 =?iso-2022-jp?B?bTUwVTFnbTJjeU9EQ0lTMFFqYlo0bndXbHhYbUpkVDg1ajUvUzhxTlpm?=
 =?iso-2022-jp?B?NUtLTUJVdmZzdFdXRmxpWTFkSGVqeURUb2VYRDhJWEZnNVNMU0VpdnJt?=
 =?iso-2022-jp?B?VkFIM0RwRko0RERXVmZrUkVhcjVaWi82WDJlV3YxUE9Zb3V6L09UT0Mz?=
 =?iso-2022-jp?B?ZjRRZ1NDZ3ZkNnZSU3ZmbURPTXFoeFVHL3JPdk5zd0FYWThJQ0tMNnVr?=
 =?iso-2022-jp?B?cVg3d1BoQkViQ0lidkRhYm1LUENHVkdBZ0lEK2lsN3QzK0tnZWh2c2My?=
 =?iso-2022-jp?B?ZFZRbkNON1I1ektjRGs1M0lZSWNHNDNNdjJ5WURrSmFjUFo1MDdxSmdN?=
 =?iso-2022-jp?B?N2tlYk1peUQwY3BreHZadkRMQUpSb20zYUVqTWxub2hNbGRSaFllK0Zn?=
 =?iso-2022-jp?B?cms1T3BuczUxN1ROZ1oxc09QVC9VRFNPU2g5S092MVNGRGloU1lEcXln?=
 =?iso-2022-jp?B?aUt1VVhiTTltazA1eXZOUHlEZGE0T2RKbjZ5bzRYVlFrb3JIQmFIZWRL?=
 =?iso-2022-jp?B?c3FPWFNLMmVXNThxRHVWOTRrTmtPSC9aNGZJVWJVUDFsaGRHMWxjSVdu?=
 =?iso-2022-jp?B?MG5rZm13aGd3SUtsUEg3WlIza3JxVm1NbXJlamh3T01lV0RKRnUrV25t?=
 =?iso-2022-jp?B?bE40cEJabzQyb1VENXVlcXl2NE10R09yREFUNTFjSDBMdEFxanY0SHRr?=
 =?iso-2022-jp?B?YUg5bnpRUWxJNXpUVzQ5d0h6NVBuN1hOdStNdHBlUUJNeTdNeSs0ZWJk?=
 =?iso-2022-jp?B?aktOMFpKQ1lGRUhxSnBTZTRKWXNiQ3ZCVG9vdjBkMlhRNTVPSWQwU1Q4?=
 =?iso-2022-jp?B?eXpEOVZmMFJWTGIwTEpCblpKNXdxS21vUEdFOUozRmZuakVQL2l2elhH?=
 =?iso-2022-jp?B?dFQvVWpFQ2pFcVdhS09ZeVpMbVQwRmlzMGt4MEhzZXl4QXgvbGJDOVlt?=
 =?iso-2022-jp?B?SDJ6MkFWZjZkOE0rcHFsRTNUZVcyQmJiUFpMeENrZno4Q1IrWTRGQksz?=
 =?iso-2022-jp?B?TFB0ZTJKc25GOFFyako0WFNBellHUG1JcEp0T1ZoSGwzRWRnMTFTT25T?=
 =?iso-2022-jp?B?bGhqbkloSUlnOXlEL2xEekNmc1FyWkZHQUZvSXJabjRGNWovQmd6TkhG?=
 =?iso-2022-jp?B?cDhYZUdrdkRtMmNMdUVhU21RU0MyY2FuclF2UjFlTFZPY3hKRmpEMEFY?=
 =?iso-2022-jp?B?WldXVTJ6Q2hFbnZsWUlJUndtMTkvNVZFb2lTbU5sNll6eWM3Rmo1QzR4?=
 =?iso-2022-jp?B?RDVCVWNXYzNHSk1YNzQ4bkNtTXU3RHhWNmYrYVFpQzh0YVdlR29EQk42?=
 =?iso-2022-jp?B?QzN1ZlpMMmRPYlhLQ2xlbWN5SkxCWnFCNTRxay80bXJTQ0ZzTzYzMnJu?=
 =?iso-2022-jp?B?NDdBWm1xWTM0c2FhTm01NW5LaytXaE1ZaU4zT3hIaHEyRWY0VjFQZWZD?=
 =?iso-2022-jp?B?dlpQekQ2TkNRK1dPTmV6WGs2ai82WXhYZnF1a3pnNkhPb0tuNWU3N2c3?=
 =?iso-2022-jp?B?MDV5QlpIMTRMVGI5RHpxUkZlV1lvSHlVV2lOSUhBbW1JOWI2dC9WQkNZ?=
 =?iso-2022-jp?B?T0hiZ1FLWk42aEJ2M0RTRlBzdkZId0VNcGlvSHd3bGJJQ2NsTCtiZHYy?=
 =?iso-2022-jp?B?d282NFIwVjJveWV5MlVNdmxVRGExd25BVC9zb1BtQnQ3bVY0UVFFa1A4?=
 =?iso-2022-jp?B?R1NaQnRyMGYvNzZ1WWd5aTNGYXFXcjJIdUdWdnFvRmNqTFlKdmdtUXJo?=
 =?iso-2022-jp?B?M0FiU2RzTmR4WklZNUlpSWNSd2JvckZZWG00ZXJUa3F5MVVwR205TU5w?=
 =?iso-2022-jp?B?S2ZOcit0WjJoUnlNOGROclZUL1pvWVpTa1RvNkRyNk1wb3ordE1jQkpn?=
 =?iso-2022-jp?B?MlRnY3ZxNXZ6MDBsem5IS3RwUWxEUHpEYzUySmd5V3ZNWDNxeUxqOVgw?=
 =?iso-2022-jp?B?cmtjZXVBMXRPaDZLR01BQVNmOXZrTityT1N5RUFheHRVd1hpTVgxVW9s?=
 =?iso-2022-jp?B?N0R5em9DOEE4UVhKdnI3ejgzTEM1a29vRXpycGZqK2NyUjA4NzRYUVZa?=
 =?iso-2022-jp?B?d3lVRTBRMUVjSHFtMkZMd2J2TUY0cWh6eWJvYVEwc0RGOTFVdno0eGFZ?=
 =?iso-2022-jp?B?dWs2cU4rYndnUnF1eXl3SXdnRkRubDhDQWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b0b8e6-05d0-47a9-ffbc-08dde0525c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 01:30:49.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F56k7CNHuw+7QaDKBhGzfQmYym57Ycv9s1LXTef9s2ywehOa+VFqKDFeatB1FApv/WxtEurxJYeqCSYnx3DBdR8aHabMdfqSIEVPXRLpG0sEwzcOkwq1zfPlPhHZPrtQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 01:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19928

Hi all,

CIP kernel team has released Linux kernel v5.10.240-cip63.
The linux-5.10.y-cip tree has been updated base version from v5.10.239 to v=
5.10.240.

Information about this release is as follows:

  v5.10.240-cip63:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      aed025ea2b4be27479946d3fd09245877fa68357
    fixed CVEs:
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in a=
tm_dev_deregister().
      CVE-2025-38467: drm/exynos: exynos7_drm_decon: add vblank check in IR=
Q handling
      CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendms=
g()
      CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push()=
.
      CVE-2025-38350: net/sched: Always pass notifications when child class=
 becomes empty
      CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period
      CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are =
missing
      CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class do=
es not exist
      CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
      CVE-2025-38395: regulator: gpio: Fix the out-of-bounds access to drvd=
ata::gpiods
      CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after c=
m_id destruction
      CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent c=
rashes
      CVE-2025-38462: vsock: Fix transport_{g2h,h2g} TOCTOU
      CVE-2025-38074: vhost-scsi: protect vq->log_used with vq->mutex
      CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()
      CVE-2024-28956: x86: Indirect Target Selection
      CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()
      CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_devi=
ce_down()
      CVE-2025-38461: vsock: Fix transport_* TOCTOU
      CVE-2025-38363: drm/tegra: Fix a possible null pointer dereference
      CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
      CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
      CVE-2025-38371: drm/v3d: Disable interrupts before resetting the GPU
      CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd=
().
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2025-38067: rseq: Fix segfault on registration when rseq_cs is no=
n-zero
      CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmc=
i_ctx_unset_notify
      CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly =
when initializing it
      CVE-2025-38404: usb: typec: displayport: Fix potential deadlock
      CVE-2025-38389: drm/i915/gt: Fix timeline left held on VMA alloc erro=
r
      CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failur=
e
      CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_=
reshape
      CVE-2025-38399: scsi: target: Fix NULL pointer dereference in core_sc=
si3_decode_spec_i_port()
      CVE-2025-38466: perf: Revert to requiring CAP_SYS_ADMIN for uprobes
      CVE-2025-38400: nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_=
init() fails.
      CVE-2025-38387: RDMA/mlx5: Initialize obj_event->obj_sub_list before =
xa_insert
      CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_ge=
t_audioformat_uac3()
      CVE-2025-38393: NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
      CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wake=
up
      CVE-2025-38391: usb: typec: altmodes/displayport: do not index invali=
d pin_assignments
      CVE-2025-38439: bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
    added commits:
      CIP: Bump version suffix to -cip63 after merge from stable

Best regards,
  Nobuhiro


