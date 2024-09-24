Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C6CF9C5B
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 00:34:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.2787.1727138049080029720
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Sep 2024 17:34:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=dsdQBpld;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727138040;x=1728347640;bh=qaeIw5k/qEF1QI6iqUGBd/tlvFBv4FghGZUbDM7
	nkEo=;b=dsdQBpld6xH+Q1f7yy+DbqKyo82I0llk2VMhKSy28SzhDCgr7FG9Mgam2D7nS8sP9lgqA
	UjX+2Kd9XofPQMQ5QjYDTmXjBGgVvz3YCfRMI8wk8NCVi4O0l3pJ4KbukKndCC0N08PkTOL7BIu56
	iG/E2//AQxyGLnoSlX6M9per+ILvTob2DPK6x+ayZIUEjZcSZqIoSd8xwzakIPlF8Qysffpzk5Xy0
	/0qeLgxm8HvRdhX0B76WSoi4yaY2D8uyxZ68c0MobOW6RVC7cWTd9YIy0IthQ4HAj/0WDtUtAMAbT
	oc9eGnHdy/zpwTGbG3y0ZnQJbvHvs6nmxGLk/x2slg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 48O0Y0L93772060; Tue, 24 Sep 2024 09:34:00 +0900
X-Iguazu-Qid: 2yAa7nzfazDbPArGsM
X-Iguazu-QSIG: v=2; s=0; t=1727138040; q=2yAa7nzfazDbPArGsM; m=yDKTvgut1x4YBl2epX6vAnMdBOdXxwoKJ6+/rhfOhVg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 48O0Xxsj1576536
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:33:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5ILkUfu7zJAPN5i6WR6L/ZboTWooPQLl6nzXWR3ysO6x6YAHOKc9AgouFjqq6fAGco92jM+0idx7CcrugUFZ6Ep4mTHrOamj6n+BhRj6jDZQKLcvEzM2yXWwP5bzI/Mm9WYXX9Py3gGx1IRvmaizdXWJLXlln8RMRmRetL/PsqtvvLkEUI1JxpzdYmGbIcvXfyu32DMAGfRibubpYOsndNaENgByoSQsQNh98Ihor4Bg3nt/Z+3fGO3s841J2C2KTojsmdXuXPQ8j45KoAS/li0tfD7y/z4HXwUcvjgZKfG3NOHNsJpfQEsyNcyUN/8zgS8Ls5WPYO3AzHBuGtfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6i62stEM0Wj+9eSWXC1ovIW0cIywdnyspazs/LgiKY=;
 b=lYbajw4uN5ypNb6P6VW6Jt/CgI2ZSD5E/miPfgo5Lts1wXP0dnQBn5oOjp81Uv7+EbOhmS1xn37LkfkQvgM1psA/RgfxizOot+qGTX8SD0SSq6/o0aI1P7k4JtCjPpsTlnpPgKo55OY0v2d6eHzmVtHm4WLpWodEYxft8ngdxkMQ6DRtWytRQS1f/iBU0MnQFO8VO8kPHlryLGQiftePDIYdpCmKg6IikVUEaoyu3/ZsM3EAl03ZiU/G1E7vs7XvPNbb/0axfYvVEoRrBDnFA2PPMo1Ov+4tqZ9Y8r1OJxZkKNcwmJjyxbKR7qYY8KIPPEGsiV2kypD84vHzXrRalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: -cip version corresponding to 4.19.322-rt138
Thread-Topic: -cip version corresponding to 4.19.322-rt138
Thread-Index: AQHbDY0MrFFJlrJzBkelwSXw1ea747JmFwZw
Date: Tue, 24 Sep 2024 00:33:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F845529689D5F34B76CF92682@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZvEdWAvSziP2CXqP@duo.ucw.cz>
In-Reply-To: <ZvEdWAvSziP2CXqP@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB11400:EE_
x-ms-office365-filtering-correlation-id: 3b059d5a-f764-4d2e-4786-08dcdc3093e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OENwb3ZjQmx6NVNiT000T1RGSnhwd2xHUTZ5MGZFbll5RWpCOXA4UzNu?=
 =?iso-2022-jp?B?MkUvWWRlZHFBeElzRFR2RVZVRFJ6WnBDbnVHMEZEQmNrZFMxNGQzTFJx?=
 =?iso-2022-jp?B?MGZLQzVMaDEyU0Mwc200SFBPZmpYYlZyanpIUFBkd0lQcmM0cGJUdk0y?=
 =?iso-2022-jp?B?dXNsczR5Q1dNekVOS3NSU1hCSEc1UmNsYW1SWHZwRDJaQlJKRWxuL0Fs?=
 =?iso-2022-jp?B?WnV5RzFUVk5laGJIMmhFem9MaXVhMVZNK1VZYUtITEJNb2hGbTF2NWVE?=
 =?iso-2022-jp?B?dWE3YS95YmhSQjdyZzlad08zZEtNWTB2Q25tekhzeGZYN0RjRVZyNTUx?=
 =?iso-2022-jp?B?VG1GbzUzdld0anBsSjk2SXlwYlY5eHd4bU5Ccnc2clIydkt2M2F3V2lx?=
 =?iso-2022-jp?B?N21qMU9MR3h6UUE1QVJrT0JBMzRaTkRlZ2FxVnVyOVloc3V2NzdPckw1?=
 =?iso-2022-jp?B?VDE0VEw5emUwRDhWbW8rQnJEV1JmdjhhY1hkVXNIdWNpQ2U1STZYR3dU?=
 =?iso-2022-jp?B?TlVTanRpQ2ZsclpCRFZBcmhuSnJJUUhHSFY1OFplT2Fmc09NVytoWTZX?=
 =?iso-2022-jp?B?K3htNmpkR00rL3hjcGkrNDBoRm5FT2pvTnlDaFR6Z1kvL3pEdVNnV2ll?=
 =?iso-2022-jp?B?TmVhZWg1WG5xT25YcTJZUXFlazVCU3JyNm1EYTY4WVgwZ3hNNlZoNVNn?=
 =?iso-2022-jp?B?NDJCZG52NkVremFjajBKakdNK20rRVlLd21CNGhpZ252eFNmK2M3Ym13?=
 =?iso-2022-jp?B?emp2Q1lkcXViTFQveHR3QkxZODZUQlk4OWVCUldkeFJZRmZ3ZmQ4Mlh2?=
 =?iso-2022-jp?B?dVdiYTFYcWFCdGVTMnhwOW11UTcwK2FkVU54R1lXMUM1KzllaEY3SjlI?=
 =?iso-2022-jp?B?Mm9qTU13UndmSFRGdzlSaVRFSXBtNndyMDUvREhXRXgxWlpxMC9STEZN?=
 =?iso-2022-jp?B?RHh0VlBaZ2gyZCtsQlR6MDlmYTNsY1ZwTlQrWmpodkdpbWxTVlNSd1lZ?=
 =?iso-2022-jp?B?eGZReUtHOGd5S3cydHB1VUtjcTRobCs4NnZrSmFObDNzaGo3eUkxQVEv?=
 =?iso-2022-jp?B?TVh3VHp2VTZGYXBVWEN4VzFDbWpDc0VOY3h0bU1ST1BQUU9ZYUlqMEVE?=
 =?iso-2022-jp?B?OVBsQ3U4ajJKSlFlMVFNaGZuSHpWT3N6Q1Nwdy9SV29lcE9hUndHQUFa?=
 =?iso-2022-jp?B?anhFUE5mc2s2UGRML1h2MThabzZMVmliZklma1h4czVSRzZ2a2FRbjRv?=
 =?iso-2022-jp?B?YjJza0lzNmg3Z2d4OG1Xc0dVTGRhQW9taG45T1JnVFgyeTNMeTROUEh3?=
 =?iso-2022-jp?B?SUNhakpWRHQ3Vmp6R3huLzVDK2tyY2VQNzlJNitjRmdPN2JwU0tIMUpT?=
 =?iso-2022-jp?B?bXF4VFhSa1JJRWd1alg5TGNuS3lFamh1L2p4eXdiZDVGWXBYbkVKeS84?=
 =?iso-2022-jp?B?TDhTSWZEME94ZVM0Q1Zzb21mTUkzaGFPeDN3WTFOZENNZGV4UGIzV0NF?=
 =?iso-2022-jp?B?MjJjdk9qbjV3OEM1YUM4eWlzRkZCTlVxcjk2VitwWXE0TGN5aWRBSHZY?=
 =?iso-2022-jp?B?cUUvMnNlbTBoRldRRFFHZ3lKWU51Y2V3a0hTWG1DLzJzQzBrYXVpa0xq?=
 =?iso-2022-jp?B?b0kzRmp4YjcwZm5YWXdUeDQrSTh5OEllc05tUVR2aDEyY1FnQS9QMHo3?=
 =?iso-2022-jp?B?cExYVEtZK2RSUFN0RDNNaG9kUTBISWpHUy9wUG1hVVFDQng3WEdDaC9Q?=
 =?iso-2022-jp?B?U1A0QXVibHMveEg5cm1admIzWTVCSmdObG9FOHRYeTFCNjhWbU5xTXpS?=
 =?iso-2022-jp?B?VXFjR2dpQzVLZ0ZKRGh6UFg1RlBSbkt6WFBic2lMaTBJbmJ4QnVac0Yz?=
 =?iso-2022-jp?B?bzBhcU15eExnckxJV29ZYjNsS2I0S1pjNXpwYTJ6RFBVeTAzeEpWc0xk?=
 =?iso-2022-jp?B?V01yd2JqaDgyZldvQVJKRytrdU9UdDYzMTE3VUtSUTN6cjJJOElmdWZ6?=
 =?iso-2022-jp?B?MD0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bHJIekRFSXdGcGdSTHJvVGF4eVV3Yko0OW5LTzBDOWFLZGlvOENpcGdn?=
 =?iso-2022-jp?B?bThTMWxoNFN0QzltQjVBSHhYL1hNZE5uYVNEUUZXYXJhalloQnFFd1VL?=
 =?iso-2022-jp?B?Zk84cElidGZHdXdreHFZSnpqK21Lb090Y3lBemtlYTJxZU5zcy91QkVO?=
 =?iso-2022-jp?B?eVBmNUdaL3ZpdW5rd3N1ZVlYc29KUS9wUGQvSXMwanRhdGFjazVJWWQ5?=
 =?iso-2022-jp?B?UVVQNXNGYzBOU1RwV1JWeDRJYlVhQjFjbCtHZ05lMGZqOW5FazY5cTRx?=
 =?iso-2022-jp?B?bXBhQit0YzBQSm9GYmpobkZqNnR4YWhRNThXcTZ1TFpCTjNqYkprTU0r?=
 =?iso-2022-jp?B?R0phOTZpV2tLVGxXTVVvazc1MXc3V2MreXptWlpIVGVGSExVUEZ2KzJk?=
 =?iso-2022-jp?B?WTZHek9udmlwRklPUVR4bUVrMmNvazlLa3pBZXNMNnFHUk1tNytPS00z?=
 =?iso-2022-jp?B?T2FKQmtPWldkNnJRYkxsMmRyaGliR2hFbHdNVHRuS0hybVBJTkNRcUI3?=
 =?iso-2022-jp?B?VThCbDVBZ0NGb3VaZE41NWNXbmlIRzVWazRlbUhLMWp1dHZYMjR6SGZY?=
 =?iso-2022-jp?B?ZFNTc0NRZEJhSlpDYzhPTnNnVTJkbEFaZXh0WE10VVdnNytXSS9sR1RX?=
 =?iso-2022-jp?B?U1EzQmtxa1Jjcy9OY2MzRFQ5aTc3TzFoN29qalNuMmFWcTMzZHptUzlE?=
 =?iso-2022-jp?B?Ti9WM3g0YmVKLzQzOXJ2Yk43WW1ONGNUNjJlZjF3S2ZoZFR3bkprVzhS?=
 =?iso-2022-jp?B?VUlQaVJqaWFod1lpMnpRd3hFMWNiUTNteWs5RG5EdXBzOUFneTdHUjhy?=
 =?iso-2022-jp?B?UjBHUm5WMUkrenM5SjdjWjZzZDRQeXV4MXY5KzNpSFRPaWl0QVBEcCtF?=
 =?iso-2022-jp?B?NjIxT1hxaWNpUnArZGV1amVPTGFQMjMzK3pNMWRwNW11bERsY0JVOTNW?=
 =?iso-2022-jp?B?VjRTUWluSkJCRmFXUERRdVZvTGtFMmpZaWJmL0JSOHdsRjE5ZzJKOWJx?=
 =?iso-2022-jp?B?VTdMTXhZb2xqbmljdk5vSDIwNjA1Z0YxQVg4Njk1bjR4KzBHZzJTMDl3?=
 =?iso-2022-jp?B?bHEvVmdMVUl5MW5uR21sK3RWd1NmbE84VWR1ZUZsRTdiMGVaR3VOUmRi?=
 =?iso-2022-jp?B?VjNvOFQvM1JGcDNsNlJCZFdPSXltd3FvaWtkNTVTV3RHUlBRQ3NSR3Fn?=
 =?iso-2022-jp?B?WFJGVGo5Q3RnNFY2eTViTnlLZmJEMWh3RFhLdmRGNW5yQzhaTnF2RUY2?=
 =?iso-2022-jp?B?a3VvN2txaHVFY1ZPdEsrMlI5MFRjMnBtamxPWDdsd2ZOUzJYUGU0ZnYr?=
 =?iso-2022-jp?B?TnBpeUQ0UEtORlpNNVY3MjhNKzNKc2tYTXJHdEZibkxrRG5ORENQWlhj?=
 =?iso-2022-jp?B?R01TOGJDSzFXZkppdGo1WW1rbENkajU3c3EwUEtCc2xCbVV1VGprVmcr?=
 =?iso-2022-jp?B?RFZPZ0tTYWZBUU1FTU1HZVRyaTY4VVU3aGxRc1JENm9LOTkxeVhMYisr?=
 =?iso-2022-jp?B?a0o3ei9zeUhFTnBxL3hpYXhJUzlpTS9ZODFON1VkeldtbW5peElHaGNJ?=
 =?iso-2022-jp?B?cDlsMExkR2M5TVArZCtvdjhWc3RtbzVmcHJxQ0RKWXhCZXd1RkJtZ0o3?=
 =?iso-2022-jp?B?dzROQjRGR1VMYW0va1BsaUNVSkR3S0pzMVNLNFlnZDg4RkEyMjlGRVh5?=
 =?iso-2022-jp?B?NloyRWpMNk51cWdXRnFFMmF3U0RkVUdIRFB2eGtEUHVhcnRhREtzWmE0?=
 =?iso-2022-jp?B?MjZNWDRybXAwOW9jSytCKytVS3VoQ3VONWxOSmt4WGw5cFdoMWpMNjd2?=
 =?iso-2022-jp?B?TmdCMXE5bFJxdFY5bWNiTU5hZUNyZnBGTmFkS2FmN0p0Q3dUSG4za1lF?=
 =?iso-2022-jp?B?bDdrdDkvTDR2L3ZoYmJrZ2cwS004YWJsVTB1YzZ2UXNCd1J1SVlZTUJK?=
 =?iso-2022-jp?B?VFZmOVQxbTYzZkd2YzA1eVR6cTRhUFcvejFDTDkrSFI4WlRxazlPQkxU?=
 =?iso-2022-jp?B?VmM1U2Zsend2SkNyWlUzN0ZwaGsrZmFCM1FIMGJVSE12Y2pjRTlObW1Y?=
 =?iso-2022-jp?B?cVFEQkp6NURUODhJeWtVd2l4TXVtZk5GNVBYaG1YUi8wN1FySGZOYStW?=
 =?iso-2022-jp?B?eENSbGNnR2tvNlViVXJqVjhpR1VkRTI2akJXUllDUlB4Vm1aNExjNlly?=
 =?iso-2022-jp?B?TVpFZzh3RFdINnh3NS9uTDNMUmtnMk9RNUtvWFAyWG1UdWovYmxEZWc1?=
 =?iso-2022-jp?B?L0VJVCtoNEx3ZHpPZWdERW52NW5pRmpVUjRqTTJEKzdGRC9vWUdJd2lM?=
 =?iso-2022-jp?B?V0FuQUhpNGlRN3FKelJsU3ZBYzg3TlRONnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b059d5a-f764-4d2e-4786-08dcdc3093e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 00:33:57.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fV1AfgX88reiw08efYiycYizW78Ws+Qj57vG9ZhpfKD5tcv2GvXmbjTg0C9zEE7GJDJOOtDfCdBzulhtZFDM55rJmMzXl78iH7hnMGIOz1KDFUh8bHKQf53MrkZ7Vs57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11400
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Sep 2024 00:34:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16912

Hi Pavel,

> Could I get 4.19.322-cip release? I'd like to do -rt release. Alternative=
ly, if it is not
> a problem, I can just do release myself.

Thanks for your suggestions. Please go ahead.
Merge testing of .322 has also been completed.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1450569769

Best regards,
  Nobuhiro


> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, September 23, 2024 4:49 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Subject: -cip version corresponding to 4.19.322-rt138
>=20
> Hi!
>=20
> Could I get 4.19.322-cip release? I'd like to do -rt release. Alternative=
ly, if it is not
> a problem, I can just do release myself.
>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


