Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8EBCA0EE4
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 04:34:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.57415.1756182842827906025
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Aug 2025 21:34:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=MS9U84ZG;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1756182821;x=1757392421;bh=
	Sl46lkcw39xWd3bY/R4eo2CftdrpJVCvtvNJJgQs+yo=;b=MS9U84ZGLHbMdgDzcsE3++Jc5+d1p8
	mc2GYmQjBg9hXCiMUKHAFSt9F3PoMzVhfGUNqenbqRWzY3UhMul1Q4FM0to9MNp/oLHqtMsvhqUbc
	xqY1ncaE0+aA5BcA4Zo717LBRURwK6fxixYSAmer3tVonoVsV7ZnG6EY5mPRFIeonMxIDoeHJaLTG
	+PuZuu5qx8kWU5JKcWXsRxVvFOduHCBp5NEOeh2x4fzrxR9E7oXjNJriG0nFEr4lneSjYKRvAaG3w
	Il3NC03zV8a4VzD61rd/t1kKzYt3YjDCgeicB7lvX57RLTCudkxm7uVYOqg4iIZnqlEckjuX1MT+S
	jtKg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57Q4XeXP3625179; Tue, 26 Aug 2025 13:33:40 +0900
X-Iguazu-Qid: 2yAbuzQy695mvxJWXC
X-Iguazu-QSIG: v=2; s=0; t=1756182819; q=2yAbuzQy695mvxJWXC; m=/Tnt51sr81Cwlp4wszngY6hw4DEkgYFdIXYp3/EQYJo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c9vtT5BZKzyPm; Tue, 26 Aug 2025 13:33:37 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opCP/ZcT3W/Nd4kq3hLGQreJuGVHKi1uR5uyKpASJbYeHV+q015GBaKWRKpIMbhIhJTOgDkAMfJc63BLgxLNBoPqq41NS4FYUFZVk6pC7WEx64VO+paIR3J5XY86/bbJSgpjT+p0c7IDTyVEJGHLtiSeJnzM6jjtv0SFVOYUoHvd++IG9VR14BOxMTqxWC7flwTGErr8u9HyU7W+17btzYrUAyzo7sOadNXkchIylulN+HA35Ox4ZxqUvN1IoqNmbD+0GglqaO8ghLQk3LeWZTCfpzFBZ0oExl7fp5MLPGZJzcC4kOrY1yp+9Xu6JUioT+XixIhJTuBnl7oAq1MUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylr/fUzIAOyTy74ni3nq1N02FZg4vbgjNHTi8nVc4KA=;
 b=SU/w1AIN6lA1wGIeWOQUKjb5Bk6gGt0VrxkMUyCAI9luJq8PzxLcEmR0FVMFDjfmr/WvPj3c7mibYqvi2Go+MnBxzfFrZrNEujXNX/Gv3lmeIPFR7W4cPVT9ikNl1yO6ApNesZcGs5dr2dv1oGZUvXGcxEG64mmDxejgwOKCfYYUDgttDVW/rBU9oVoY3rKDu3FFJ5T31itqjRtts00Cd2x4gXR052nQqVh0jWUnjanw1kSzBYcWM+JeG7dL/sX+/RWsTs/UeZZNb9p6KBpgZtGCX9Y934EM28TNLdR033CF7dm9k3DG3jaqY6+f9v5c8z0yGqS6yG87PfodPkvADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.43-cip7
Thread-Topic: [ANNOUNCE] Release v6.12.43-cip7
Thread-Index: AdwWQoLdRVtEd8iqQjyzYU0NMEevpQ==
Date: Tue, 26 Aug 2025 04:33:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184BB1A00AB48A858F4BC6CD39A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB7449:EE_
x-ms-office365-filtering-correlation-id: 1d829a09-775a-4e13-ea10-08dde459b7da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dUhoN29RVUIyN29TNW9iNmlSeURSMFFMUkVBYUxtVWx6Y2xLSEhicXdZ?=
 =?iso-2022-jp?B?NmRnYnQzQUd4bWl1ZkpEeGErZmF3eStTeE1lZ1hJZ2dFek93YkNmNWRy?=
 =?iso-2022-jp?B?ajl3bWNTZGZwL2I0TWoyUlJrOFRjTlYyeWNxQ0dXUFExd0MvcHdaVFJW?=
 =?iso-2022-jp?B?Z3J5SUxyLzZLNU05a0FmSGhuRzIxT3Aya3RWYUVaRjE1Y21Gd2hCK3JS?=
 =?iso-2022-jp?B?cXdhbmlrN2tVczhvRk44U0FDK2hYTllwTmZRcHk1WHZoeDN5bjg3Y3Ey?=
 =?iso-2022-jp?B?NTdremgvd3dPZ2ZhOTlFWGRYbHFYbDZ2dkkzZWs3S3ZJWHpHWjdQQU9h?=
 =?iso-2022-jp?B?ZDhKOGFlMnc5dmkyQjY5R213anVQNXhnZW15Uk4vbGw0Y3BtYTBnRERO?=
 =?iso-2022-jp?B?OGNuOFBzb3hxNFZWazRjVTIwWndQR3pIZS9lWUlOaWhtYnhBOVAreXgv?=
 =?iso-2022-jp?B?aUZxR0FxUndaR0xwUFo2blkrWmhkRjBtYVRvSnlNMXgyQ3AreXZZOTAz?=
 =?iso-2022-jp?B?Q1c0OXEvY0JRYkxiWWF2cVhtMitna0VQN2I3VjVXbFVZa2ZhR2VBbnFY?=
 =?iso-2022-jp?B?Z3NHNzduRHdETURWYXhOUzh3NTE2SmYvYUlQY2hpOXNvazVUcEtVTEZi?=
 =?iso-2022-jp?B?VzUvcE1DbER5Y0haVWZPYklyeElCaVg1S0I1L1VsalNMNnFyckhGc2tW?=
 =?iso-2022-jp?B?UnRQdjl2MWlmb0VyakFhd084UWhIQzNaUWMzQjMxNHl6cXoxSHFPdzIx?=
 =?iso-2022-jp?B?Z05xdi92S3NjRUFuTWxCdHIvMWNwcktGQmxHMldCU1huMldhd214ZGx5?=
 =?iso-2022-jp?B?a1RRd1h6UkRuRzB2eC9XZW9RWWJEUU4xMkRHVjgwR1g2eWJoR2Y1dDFJ?=
 =?iso-2022-jp?B?SUZCMnRMSjU0cU15RWdZWEo3OWJ0a2phWDM5RVljckR4YlVrUjlzL2Fa?=
 =?iso-2022-jp?B?K2owbElkSlZ0SXBYNkJDelYwczFYNnVsYjVHeW51TGRzR0RWYXprTnUv?=
 =?iso-2022-jp?B?dkcrTHBZM0sxRGNWQ2gxeWRZMDFodU03OXZLTzZia044NTVzM2c5SE9C?=
 =?iso-2022-jp?B?NzJDTjNhN3h0OEtjRGdXZXlPN3doNy9xeFRLWFljbnRoazJ5c2JaSzVl?=
 =?iso-2022-jp?B?b0w5OEVaSUhnYXR1SGpTQmY4UlpvS1FVaDFsajVVczlxekFRZjhrREZv?=
 =?iso-2022-jp?B?dEViZlRJUytPM0tkNnpCOWdjelBRZGI1TzkyaGdXYkJZVjVDMGpzQWho?=
 =?iso-2022-jp?B?dDJwcjVLZ1YyZVZkLzQwY0RMSU1DeFRJeittbi9kMWg3NVFqZjhXRzJk?=
 =?iso-2022-jp?B?Q3dxem9YL0ZQbHhmUlhYMXVRU2htWkxkQ2dsSEJuQnRXaGVNZXhVOFBB?=
 =?iso-2022-jp?B?dHMwZHpCS1NNRFBSSHJ2SFF6bktmcFdWcWVqYmFuMm1ZeGhCQWI3elJh?=
 =?iso-2022-jp?B?NlBHa09qN2ltVjZqVVoweDBOaUhyOGZHRS9lMVZmSmptN0xnVjR3c0Jn?=
 =?iso-2022-jp?B?M2N3UXlsbXZ1MWZ0NnZoZGQzZjM3QStvTDZnaXFJM3JsNVU2L3lvbkNU?=
 =?iso-2022-jp?B?bXVzT0lPbEsxZjZLby9aWVUzRXhpNWtpa0hLYlA0L2ZUcTluVFRGbG0w?=
 =?iso-2022-jp?B?Nmo3UFZ5TlZ3dndzeEhFbjF5N1BXQm5Tc3JpUmtxRW00T1grVGZzVmlq?=
 =?iso-2022-jp?B?K3dCR2pzZkd1ZnI0MGh4TkJWNlg3SGdMaGY5aHBGM2x4MjBqQWdQdFNa?=
 =?iso-2022-jp?B?eGFUM1FBdElpb1NjdFpZaENiR3dvU28wUk5RN3NMVkkvczU5aUlLNE1K?=
 =?iso-2022-jp?B?Zi9MYXlHNTFzZzVnSytyNHJRYUVESzlvWTJGckdyNnBpUG9DNmY3Qjgz?=
 =?iso-2022-jp?B?Zk03ME40M3VOY3RDMzNPakF6b3VrYWZnWTc0Z1dqbFpYbXBPd3U2Zys3?=
 =?iso-2022-jp?B?a09hcFBVRlNSYUJDR2Jaay9UaUMxbmxGYnN6QWpNdTdEWlpYaEhyWkc3?=
 =?iso-2022-jp?B?bEdEa01XVTJJTnQvSyt6NUlFd2FVMk0zb28yRGRJZWVGbktTR2RNZHU5?=
 =?iso-2022-jp?B?MDBmMWEyTFArQitHZ3NaaEQ5U2thbmhaQ1dtOHhmRWFMK2xWTjhveFBv?=
 =?iso-2022-jp?B?bXRaOXNkMmJXWHVkbTVFbmorZTNka25xblczbTNlMmtxalRmaCs0Nkww?=
 =?iso-2022-jp?B?Y09jPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N0hPcnJIdmZqcmYvaVMzUTJpUGdaSjdVbk5kVHNnUm9rK2xPVUc0TW5Y?=
 =?iso-2022-jp?B?b0tnRmR6WGhQZHo5R2Vncko1ZUFDMmUvUWN3ek9DQkdTcEpIQ1pOUWdt?=
 =?iso-2022-jp?B?Uk1XSWViZWw3cDdyU1B0TEdMSG9KeXlWb1BqV3NxdkRTNHRRSnR1dVVZ?=
 =?iso-2022-jp?B?dXZKcU1FL2M1TmswYyt5UWo1VTFSM2hvR3VkMWtEbzZIcEdxQ1R3M3Fx?=
 =?iso-2022-jp?B?NTFBZkNidnBDSURFQkFMVE1XYzYrb3UzQVB4NDdmTlRxMUx2WlBaRTJo?=
 =?iso-2022-jp?B?NDR6UHYrZXdaQnZJWDAwdnVmT0MyRTFKR3ZDM3B4OU52RXFMTGFKQS9t?=
 =?iso-2022-jp?B?QnoySm1OWCtvSGhucVlnNmFaakRHRDFYdDlqSE9SQ1AyRVRtTGo5WC9q?=
 =?iso-2022-jp?B?QTZXN2UvV1piSmhwWU1adUxaYUdXZlJEQWdXMTdjVWtyK1pQRk1MSysv?=
 =?iso-2022-jp?B?Q0IvczR1dmhqckIxb3E1ZXZVQ3g5dzF2dkljYjBoblFvbXlOb1NmL1NH?=
 =?iso-2022-jp?B?TGxBMHh2b1lCbUJFSVhOSndwSE9ucGR6YVZYQlQ0VHI0VG5pWG1Xby9i?=
 =?iso-2022-jp?B?TXpmMWxiNStpTW9udGNSWFBBbUxscnJuNXNhR2hyRzdGRk5aR1ZFT1JI?=
 =?iso-2022-jp?B?OFB4SW9qWEVzVEFkTU1uUEZ0Z1plTXpZdHVCcGwraTBuU240UndPVi9m?=
 =?iso-2022-jp?B?V3dWcTNUUUh2ajBUM3JDaUhJdkRtR2pwTXJUb1hjNk1Tb0FRUWFDckZi?=
 =?iso-2022-jp?B?ZnVvNW9OaHdZUkl4NDdRdTVGZkhUUVVVNEYvd2hMb0l6dEhXelpqQXNj?=
 =?iso-2022-jp?B?SjVqKzM2dktSdkRVY2ZOWnFMcGdqdUdaOXRBSmVnTUZxTkVJZk53Y2NG?=
 =?iso-2022-jp?B?aFZyR1pRdnJ0KzBuRXBkUHdhTFBqL3cvMk1JSzlxa2lyMzJIRGZWZDV2?=
 =?iso-2022-jp?B?ajduM2cvTVM3K25wUi9FTjBtSDVMeitFZHlWamRXM1lUOHlIOWlZd0Fr?=
 =?iso-2022-jp?B?QjVWamVCbzVJb1pRNnptRzBpMGZ2c1J5Y3BVN2pHczRudGIwZHI4ei9u?=
 =?iso-2022-jp?B?ZXJxNFdPWFU4RWlJMWF6VHVHUWJUWWY0akV6bTA2Z3Y4Z01qZWg5a1Bt?=
 =?iso-2022-jp?B?am9LNHY0RlFtdThZbnYxT3k5V2Nma0pUQlE0VU83MmNmdWRFR0NuYU5Z?=
 =?iso-2022-jp?B?cXlxTW0yaU5xc2FsSXJFeVFHT1UyT0IxdlNkMG5pZWpielZRYi9maDRM?=
 =?iso-2022-jp?B?ZXBhaGFXUVU1eWVsdVpYM0ZzT3dWaGVFNFRkRmdMS1dTYlp2RXJiK3Q1?=
 =?iso-2022-jp?B?TXJ4WVJtQ0sxaXNuSVljNFBTYVBMQnIvSzFCVnhna1FSbDRBN1BOVWk1?=
 =?iso-2022-jp?B?aUtDSXNPU2pFQmx2bkV6Y09Hdmc2aDRJSGlFUEsvRTFhdzFnQUd2NkNX?=
 =?iso-2022-jp?B?aHhOSk9HbkIwM0k3WlFzeHk2L2xhbDA1QU8zbUNrZzgzbSs4alZIRjZi?=
 =?iso-2022-jp?B?RmxYQWxBQ3E3TXZrZ2w5RFBCYVBQdi9qUm52Z1Z4YVkvemJ4N3VLOThj?=
 =?iso-2022-jp?B?OTRSRVJLUW9May9QMnZtUTUrdzcwMUtic3ZBRnZFR2FDZEd5TmNrMS9C?=
 =?iso-2022-jp?B?b3p0d0tyZk1udjh0ZkIyT25nYnAwVkREV3U2bWpFbDhxSHduWXNjMHR5?=
 =?iso-2022-jp?B?dlZibkx1Zy9ZYVZmL0hxQTlKQjFZNE8zd2NpekRwb1Zjbk4rLzJ4eHdJ?=
 =?iso-2022-jp?B?bDh6cmRTZXcvdEdUTzVBN0pYRko2a04wZ2NwdFgvdXhxZkNHV2xzd092?=
 =?iso-2022-jp?B?M05MK05EV3dMWmFiUTlhNVVoUVJ4cndYTmtad21uKzRyMURGVVlBRDNq?=
 =?iso-2022-jp?B?eUtwUjBUZUtncDFGNG9ucTNCN28wdlpCOEdaUnhuRXhTVXVwNmwxWlR2?=
 =?iso-2022-jp?B?M0RaSkY0V2d2c2dzaXV2ZkVWTktOY3lLb1E3cnFQbndvNkNXREpIZFpJ?=
 =?iso-2022-jp?B?K0c5TGlCdjFnZEdOMFpvNHRST29VOHFQQ2JzU2dIeWU0NzQ4VUN3Tk9W?=
 =?iso-2022-jp?B?UnNiN0dFbjZKMXFPYlE0eDc4RUZORkNIclBmTHprNjJiUjFiNFdXU0dC?=
 =?iso-2022-jp?B?TXJJYm5ub3NaTU42QXdHNW4xUDI0QzVXSzhKZUpBaUZ6ckRhMU1PbjM1?=
 =?iso-2022-jp?B?SXZuMVhCMnVkb0tJWW0zcEFPTjZFU3VvSklWbDI1eUIwak9yc2VianFR?=
 =?iso-2022-jp?B?Mnc3V0ZyYlRITFVHbEptY2lpTmJ5MnBXTUZ5TkU3aWVWb0s5Rmhhb0hz?=
 =?iso-2022-jp?B?OGROeFpBWlhnVzcxSUhEVVpVZlgwbzd0RUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d829a09-775a-4e13-ea10-08dde459b7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 04:33:34.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TVzzk1PtoJEi4G03iojrivBOaUfoFeQgNsofre1S/IKhgUeSjJXvfqNtNmG7cox60WM01bc25GqpAFjBpRtdx0MrvQ9v1U6uO/LE3hcwIotbWMSP+sO/aV25IIPGhwI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7449
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 04:34:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19961

Hi all,

CIP kernel team has released Linux kernel v6.12.43-cip7.
The linux-6.12.y-cip tree has been updated base version from v6.12.41 to v6=
.12.43.
This release also adds support XSPI for Renesas ARM64.

Information about this release is as follows:

  v6.12.43-cip7:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      368d84a5ca367192469eec6834e8cc02bbd9f538
    fixed CVEs:
      CVE-2025-38566: sunrpc: fix handling of server side tls alerts
      CVE-2025-38640: bpf: Disable migration in nf_hook_run_bpf().
      CVE-2025-38622: net: drop UFO packets in udp_rcv_segment()
      CVE-2025-38626: f2fs: fix to trigger foreground gc during f2fs_map_bl=
ocks() in lfs mode
      CVE-2025-38578: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      CVE-2025-38648: spi: stm32: Check for cfg availability in stm32_spi_p=
robe
      CVE-2025-38630: fbdev: imxfb: Check fb_add_videomode to prevent null-=
ptr-deref
      CVE-2025-38653: proc: use the same treatment to check proc_lseek as o=
nes for proc_read_iter et.al
      CVE-2025-38612: staging: fbtft: fix potential memory leak in fbtft_fr=
amebuffer_alloc()
      CVE-2025-38595: xen: fix UAF in dmabuf_exp_from_pages()
      CVE-2025-38608: bpf, ktls: Fix data corruption when using bpf_msg_pop=
_data() in ktls
      CVE-2025-38623: PCI: pnv_php: Fix surprise plug detection and recover=
y
      CVE-2025-38571: sunrpc: fix client side handling of tls alerts
      CVE-2025-38602: iwlwifi: Add missing check for alloc_ordered_workqueu=
e
      CVE-2025-38632: pinmux: fix race causing mux_owner NULL with active m=
ux_usecount
      CVE-2025-38559: platform/x86/intel/pmt: fix a crashlog NULL pointer a=
ccess
      CVE-2025-38628: vdpa/mlx5: Fix release of uninitialized resources on =
error path
      CVE-2025-38579: f2fs: fix KMSAN uninit-value in extent_info usage
      CVE-2025-38644: wifi: mac80211: reject TDLS operations when station i=
s not associated
      CVE-2025-38601: wifi: ath11k: clear initialized flag for deinit-ed sr=
ng lists
      CVE-2024-36331: x86/sev: Evict cache lines during SNP memory validati=
on
      CVE-2025-38557: HID: apple: validate feature-report field count to pr=
event NULL pointer dereference
      CVE-2025-38561: ksmbd: fix Preauh_HashValue race condition
      CVE-2025-38610: powercap: dtpm_cpu: Fix NULL pointer dereference in g=
et_pd_power_uw()
      CVE-2025-38501: ksmbd: limit repeated connections from clients with t=
he same IP
      CVE-2025-38635: clk: davinci: Add NULL check in davinci_lpsc_clk_regi=
ster()
      CVE-2025-38577: f2fs: fix to avoid panic in f2fs_evict_inode
      CVE-2025-38569: benet: fix BUG when creating VFs
      CVE-2025-38639: netfilter: xt_nfacct: don't assume acct name is null-=
terminated
      CVE-2025-38660: [ceph] parse_longname(): strrchr() expects NUL-termin=
ated string
      CVE-2025-38581: crypto: ccp - Fix crash when rebind ccp device for cc=
p.ko
      CVE-2025-38576: powerpc/eeh: Make EEH driver device hotplug safe
      CVE-2025-38625: vfio/pds: Fix missing detach_ioas op
      CVE-2025-38646: wifi: rtw89: avoid NULL dereference when RX problemat=
ic packet on unsupported 6 GHz band
      CVE-2025-38565: perf/core: Exit early on perf_mmap() fail
      CVE-2025-38619: media: ti: j721e-csi2rx: fix list_del corruption
      CVE-2025-38611: vmci: Prevent the dispatching of uninitialized payloa=
ds
      CVE-2025-38618: vsock: Do not allow binding to VMADDR_PORT_ANY
      CVE-2025-38615: fs/ntfs3: cancle set bad inode after removing name fa=
ils
      CVE-2025-38586: bpf, arm64: Fix fp initialization for exception bound=
ary
      CVE-2025-38572: ipv6: reject malicious packets in ipv6_gso_segment()
      CVE-2025-38634: power: supply: cpcap-charger: Fix null check for powe=
r_supply_get_by_name
      CVE-2025-38568: net/sched: mqprio: fix stack out-of-bounds write in t=
c entry parsing
      CVE-2025-38563: perf/core: Prevent VMA split of buffer mappings
      CVE-2025-38553: net/sched: Restrict conditions for adding duplicating=
 netems to qdisc tree
      CVE-2025-38560: x86/sev: Evict cache lines during SNP memory validati=
on
      CVE-2025-38604: wifi: rtl818x: Kill URBs before clearing tx status qu=
eue
      CVE-2025-38583: clk: xilinx: vcu: unregister pll_post only if registe=
red correctly
      CVE-2025-38590: net/mlx5e: Remove skb secpath if xfrm state is not fo=
und
      CVE-2025-38624: PCI: pnv_php: Clean up allocated IRQs on unplug
      CVE-2025-38585: staging: media: atomisp: Fix stack buffer overflow in=
 gmin_get_var_int()
      CVE-2025-38609: PM / devfreq: Check governor before using governor->n=
ame
      CVE-2025-38593: Bluetooth: hci_sync: fix double free in 'hci_discover=
y_filter_clear()'
      CVE-2025-38588: ipv6: prevent infinite loop in rt6_nlmsg_size()
      CVE-2025-38631: clk: imx95-blk-ctl: Fix synchronous abort
      CVE-2025-38573: spi: cs42l43: Property entry should be a null-termina=
ted array
      CVE-2025-38617: net/packet: fix a race in packet_set_ring() and packe=
t_notifier()
      CVE-2025-38650: hfsplus: remove mutex_lock check in hfsplus_free_exte=
nts
      CVE-2025-38587: ipv6: fix possible infinite loop in fib6_info_uses_de=
v()
      CVE-2025-38574: pptp: ensure minimal skb length in pptp_xmit()
      CVE-2025-38582: RDMA/hns: Fix double destruction of rsv_qp
      CVE-2025-38555: usb: gadget : fix use-after-free in composite_dev_cle=
anup()
      CVE-2025-38562: ksmbd: fix null pointer dereference error in generate=
_encryptionkey
      CVE-2025-38645: net/mlx5: Check device memory pointer before usage
      CVE-2025-38652: f2fs: fix to avoid out-of-boundary access in devs.pat=
h
      CVE-2025-38659: gfs2: No more self recovery
      CVE-2025-38616: tls: handle data disappearing from under the TLS ULP
      CVE-2025-38614: eventpoll: Fix semi-unbounded recursion
      CVE-2025-21884: net: better track kernel sockets lifetime
    added commits:
      CIP: Bump version suffix to -cip7 after merge from stable
      arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g047: Add XSPI node
      arm64: dts: renesas: r9a09g047: Add SYS node
      irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
      spi: rpc-if: Add write support for memory-mapped area
      memory: renesas-rpc-if: Add RZ/G3E xSPI support
      memory: renesas-rpc-if: Add wrapper functions
      memory: renesas-rpc-if: Add regmap to struct rpcif_info
      memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
      memory: renesas-rpc-if: Move rpc-if reg definitions
      dt-bindings: memory: Document RZ/G3E support
      memory: renesas-rpc-if: Move rpcif_info definitions near to the user
      memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
      clk: renesas: rzv2h: Add fixed-factor module clocks with status repor=
ting
      clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
      clk: renesas: rzv2h: Add missing include file
      clk: renesas: rzv2h: Use devm_kmemdup_array()
      clk: renesas: rzv2h: Skip monitor checks for external clocks
      clk: renesas: r9a09g047: Add XSPI clock/reset
      clk: renesas: r9a09g047: Add support for xspi mux and divider
      dt-bindings: clock: renesas,r9a09g047-cpg: Add XSPI and GBETH PTP cor=
e clocks
      clk: renesas: Use str_on_off() helper

Best regards,
  Nobuhiro


