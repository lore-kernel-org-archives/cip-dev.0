Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9929CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 04:07:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.622.1760587661737300326
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 21:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=dR6PgkBg;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1760587637;x=1761797237;bh=
	DEIwefCD1Nt2QArSKt2jm8jjfBHB+A+QtnsMjdbeo/A=;b=dR6PgkBg+h2acqu1oXbew6Tc4M0bcX
	hxf7TGmQ/njbeU+eICeKALgBteynfPl6eLaAV09zR2JKOQVz5yuq6/U3O9BJVxxJCF0E7vHafLG22
	nuYlGjzgHcPQ4v6p497JCS/61qVdrfpbdU98UA+9ntlGYKL0Y9etLW5G20tBBXDxtLr4VpSRD243r
	/k1vr0xNEymzXDpmeY5gVZjkfkLSK72zr5RijaoJYiZvuA0Y4gwzL9eVJcCQeVY6mZApEZKzvGpu6
	LqJasmT7CYXnpDmcMZvIjBbGq/v+zNpeEBxu318+St58fuBBPukKdch8QSmYFmLAGFwDsRmYabCiC
	xzQg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59G47Hli2884438; Thu, 16 Oct 2025 13:07:17 +0900
X-Iguazu-Qid: 2rWhTMh0bNDX9YmZXv
X-Iguazu-QSIG: v=2; s=0; t=1760587636; q=2rWhTMh0bNDX9YmZXv; m=/SzhZgFx56GtS4hO3D3Jnrh9hmpnOXxm3nl4nf0wxZo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cnDtW4Rctz4vyk; Thu, 16 Oct 2025 13:07:15 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls3A4INHu8Ff9SCO0LlTNOfOhJafwBn6T6QbSCsOVPZdYV+U4BlggyIYkTy5jQ0iqB9rNudOZ6IMbOSvVGnkNVluoV4pZ2lTfZB2YDfwTsaqYSiMy1IpYrY3V6hR02QDfqfXEp4E5QVFghl8VpxENAQ1KxBlcYttyIEB7nGnlAUMR5ZAXOvrUOvp5HXfsXJ+pohMIVlHBDdT2BHS8gr49RcFOLY+L2FeCcmmZHtcjAJtpLCupftmmfP1bSmy2ru3vrQwQ9xYlTujfe35+2ygTuXFNf1DXcYX/DULifmudIpIIkboStCCk/V6LeJ+mk54t74GDZCKDgGxI3c1dY+x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txByIrOl9rAgClNNeo597JZhEuakmBfcNm4tlwp+OLY=;
 b=duaVgUm0LSfP9SMzENJ5UcBwDj4E7Bn2lENUR4oMEItjIPMWgIlFjQvMoRwtsBH/CUlBXA78maPkI14a/k4zn7uiPkylCs+/WYqaD8mqqgZgUT/QzZ/LBwBCspGe4ulR8/C7jFGOOnh5CuybUcYeaHfpGRZSNMhBflTNcVgk4u1+aOsIatwZtpmJ9RJ92iOhrKbWxGej1rm8P2SAkGyXNGKwgllWoXUqq+Cgpvyz7pQu8oh9dD1uLeidUqGVqsSKMw/d2yPCyg6tidL9NruZ4KBb4FzP/YKnXVSJnoH1G5Qq/rwymnjqd6yOVBGji0GBPG/l5pXijChXerxszE6/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.245-cip65
Thread-Topic: [ANNOUNCE] Release v5.10.245-cip65
Thread-Index: Adw+UkxeltA+ALxnQXmk9B/d++/k5g==
Date: Thu, 16 Oct 2025 04:07:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148187AB90CCD8FA638C7841ACDE9A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB12228:EE_
x-ms-office365-filtering-correlation-id: c7eb4819-2e5e-42c6-a93d-08de0c697c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dWxtODhZcndYNDlTYklRb1lFL1FvRjJOVWJyN1VjajNjZ2ZMVUdGV0VW?=
 =?iso-2022-jp?B?U3Z2Rm1NQVZ1V0hYNytqcm8yRWdPUUdtSnNWWUorR3ptKzA5Um91WFFI?=
 =?iso-2022-jp?B?N29SS25FUlRJcmlWNUdqOW0wVDVhRHJKdjNTUS9NNnNGbkhTWTZxeVlv?=
 =?iso-2022-jp?B?RnNYT2ZNZDhuRGVzM1dUQmNFQktYTWNHRU0rbEw3R0pmZUZCZVlHZ2x6?=
 =?iso-2022-jp?B?WS91cDZiei9xTktEZnFZVVJkemhWL3h0YTFJZVdZWjdwMWVyVkh5cyty?=
 =?iso-2022-jp?B?aG9lbWJkN1BFS3RjQzJpU04wUmVXTDJzY0VUL1BPMk00OXdueGxQVHcx?=
 =?iso-2022-jp?B?N3VqdU0zMVZ3N2JtT0ZXTEFMUVFsWTZNVmU1UktNQkVGZ2lidWFQWlhB?=
 =?iso-2022-jp?B?SmVFZzdJWkNWWXk4RjNwWGlZMGVNaVV0TU1vTnR3NkhCc1FEQ0JsSUVs?=
 =?iso-2022-jp?B?QXlKeWxGaU53RXk2MEdNeWwyalplSmNQMFhKcWZyMjBVdU9ETzZZTFJI?=
 =?iso-2022-jp?B?dGRqUnZzdTF4NFFXaWl6YjVDNnk5MzF5MlRCenZHZENqTVpGWnNlZVNx?=
 =?iso-2022-jp?B?R1hpU0dzc053T2ZEV0o0TDUwRmM5TTVIdnplby9aWWhlbHd4RVBLMk1p?=
 =?iso-2022-jp?B?Q3Y2b1d5YVczV1Q4eEs2ZmpqcElsZHFJb2k0Nm9nL0MrMVYvVkhKVlNX?=
 =?iso-2022-jp?B?TVVJdHNubVhFTzFjUytXUGJDNFpkM3dyVzlWTXBXVERrSUEvSloxUTFQ?=
 =?iso-2022-jp?B?eFhObUF3WEJ1Vm9URk4yWEQzQlUzMXNBSGlzbUZROEhncXJhOEpuLzFK?=
 =?iso-2022-jp?B?NFd5emR4Y2UxeXpyRk5EOWhFM1NZUFB3WEhyTjJJc0FVTk5qSE42Nkor?=
 =?iso-2022-jp?B?cmFwRmJZSk5RcVd2dTRJMTM2bXVyYlVqWjlSL1NMbXozWnFqakx3cmJE?=
 =?iso-2022-jp?B?L2Z2TnQrRXFLQ2FyakNabGVnR0dTaWNmdUZsN1BKem9YaDlHYTZ6dG1C?=
 =?iso-2022-jp?B?djVpYTE2U1Q0VUtPY1J1V2NMZVlaRUZZTnh3cmlWRWZzc1I2d0lYWE02?=
 =?iso-2022-jp?B?NUI2WWhtY3huRTJnMFE2b2pYUE9PYUtzdmZzYXcxeEtLdEZOTForODB6?=
 =?iso-2022-jp?B?NC9UWGRYdmtjZWZRMnZHS1Ntd21TSE1DRHEyY3pGZ290bTg1emowdTB3?=
 =?iso-2022-jp?B?S0pDd0R0SStEL0hMbUQwV1VZRE5XdlNpSkZTb2FGczFlWjY2VU5pUm5m?=
 =?iso-2022-jp?B?R3E0SzJoYlZRelgvT0dqZC9PY1UvdEpZK2s0TnBPcmlmUmttT2g0ZDFX?=
 =?iso-2022-jp?B?YTB5NFFhb2ZEWmNyVnI5bXlIYko0UnZmU20xTEtlSXdycnlrOTVlTjV2?=
 =?iso-2022-jp?B?QjQ3WHRmVThrdmtHZWxhNDJDR1JhRTdKeWQyYTRMVS9ab0hWclMrdExK?=
 =?iso-2022-jp?B?YUh6eHJsYlZqRWFETXVuSGxhS2xyZ3hWUXg1ZWNHT2NrdE5OdnRkTGc2?=
 =?iso-2022-jp?B?bTd1akdTMjI3N3NZSFFJc2dWalJ0bUlGYmV4WEU0MTdYeFp6WWpTbjN4?=
 =?iso-2022-jp?B?L3RKTHFZNjFaSnk2dnZ6SVd6NVNzMHdGYm9Ib2xINUFBMktBSURHQUxq?=
 =?iso-2022-jp?B?aUowRFlRTTEvQ0JnZ1hsRGhUVUNxU3BnZ1drRStoVDg2a3NZSk9NbEhx?=
 =?iso-2022-jp?B?ZzZxMVVwVUtxanc3aXNyQW82Z2VzL3NadHVObyswYk5XZllvS01xMkRt?=
 =?iso-2022-jp?B?SXBlblVaUURCdDdmcGl1Ty9QbmZNeGFSRXVKbnJGSjB4OE1jTDB1eTUr?=
 =?iso-2022-jp?B?ejdyRWNTU1hGVzBLOW8vc0dhc1hJQW9XZCtwVGlLM21lczVESkZreVFS?=
 =?iso-2022-jp?B?NEZmeXdtVXlGeStuNkRDMkRoZHduT0dEMk5uU1lEOW9mM3E0UjUwcXA0?=
 =?iso-2022-jp?B?em5WVDFJaWg0cFN4M3F2OXVJZVY4UjArNmExREdTQWFvZ3VRK2xyY0JO?=
 =?iso-2022-jp?B?SzUzb2I2d1JhQVh3UkRvTDdiOXVhSko4K2VGbUQyRlRZWS9Kc0xaZ2hS?=
 =?iso-2022-jp?B?eitlV1BvVEpYcllxcVM2QXJoc0hxWGpBTnUvVUoyZVQvaElYVHVvVktP?=
 =?iso-2022-jp?B?QWR0TkJwYlVkdlg4ZmJ2aTZUUXBwUjdnblVzRWNpMkc1Q3ZNZXpHVnBt?=
 =?iso-2022-jp?B?OXBYVlZCdmQvS05jWUtlcVF2MWtrNVZx?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MUpzSFNtNUcydUlOY0Y2NnNsYkRvWUFWeFNjRjFiT0dsR1ZkRzlJQlhh?=
 =?iso-2022-jp?B?WGZ0d0RPTUQvMVJZRVBFS09pZGxVYnYxLzMzWGJoZUttNG5XaVpZWmtl?=
 =?iso-2022-jp?B?OGMxd1cxbXQwSjROS1NtUVZseTUrZ2U2dVNLWHZ5OHBqc1RsMldzc3Zv?=
 =?iso-2022-jp?B?VERhbVhtVVd1OHVhRDdoZmtMd3NHWS9zVzBuUWxFRGNuM2xvUllDdW1B?=
 =?iso-2022-jp?B?bDNhNkVqVU81U1B0THQvNzdtQWdFVmhSZURORFpGMkkxL0ZYcldUTzNs?=
 =?iso-2022-jp?B?enJKbTFlbCs5aVZKOHBISUJPSTFUaXAva1ZwdnVRUEN5a25tSUFEOGZ3?=
 =?iso-2022-jp?B?Snhnckw0YVZEeEVWbXVQTXlxUUlwWWJ5V29ILytUdE9Zbm54SDVNdEh1?=
 =?iso-2022-jp?B?TkhnM3ZuR2xxbTNCeWk5YkxHSmtHMEVGOFNUM3RaekRpMGkyYVAzNXFP?=
 =?iso-2022-jp?B?bDVkcFk0T2huRzhzVnArWEpwUHZCUU1hOXBzSnZyZVFJNldxL09sMjYz?=
 =?iso-2022-jp?B?RE9MaHVjZTNyNmRIS1Y3MW8xYTlDS2gzZlY4M2hrSFZXMjRYeHRGV2Ra?=
 =?iso-2022-jp?B?QytPQm1PTzMyMnZXbmZxUS9lUEFiUjRjQUcwQmlPMjJyanZ0Z3d4V0JY?=
 =?iso-2022-jp?B?SXNEUjRWOTdTL0xFWEtscDMvL2Noc1hUTHlVR0wxTXhaMnFZZHU2UjlL?=
 =?iso-2022-jp?B?by9OYzRsVDJmc2RJNnhSOXV0WVkrSmd5MlB4VEIwRWFPN1NId2c3YmpV?=
 =?iso-2022-jp?B?NUl3bTZVeDdLRXhFbVRjaVR1M20wK2hXSWlKTUlscGZNeHRpVzNkbExq?=
 =?iso-2022-jp?B?ZG5uVVFpTVFIQUxsTmVWN0R6M0ZpT2sxVWtqMEJ5cTE5V3BBL1B4cUFR?=
 =?iso-2022-jp?B?djZXb29mSW03NkNKdDZHRVMvdTUvY3FVczhCak1UOW5vRGw5Tk95MDZL?=
 =?iso-2022-jp?B?NFBJY2lRRzZOZmtDNC9hVkg2WDFTWW1UbkVSSWNLWjZBS01TYld2cUVZ?=
 =?iso-2022-jp?B?Z0ZadFZjQ01GMklwNGl4VVJQZTArSktKVXFrSFl3b0pkb1VhU3k3K3JU?=
 =?iso-2022-jp?B?RllEZ2NOMmNUSW94a3owU2NJSEozVGR6ckxHaVVRS1UvSVZwK0ZNNVVw?=
 =?iso-2022-jp?B?dmNuYlR6enNyM3I0YURiQVZZVWhLUG5RMjR5azMrRHFtM24yekI4Q2VB?=
 =?iso-2022-jp?B?a0w5VFZSZkQ4WHZGMnNKRlVsZ1NKS0pBSlg3YmhYWjhCTkFma21vOGxy?=
 =?iso-2022-jp?B?bUd1TEJCc29OTHcxeEh0aWhOSmxGNVZMbTNUcXNFT2JxeWZhT2poVjRr?=
 =?iso-2022-jp?B?Y1VpNmlpK3N0K0wzMHgwYTU2Y3UrTDIxMW1RSEFrWkdNdjN6TGVEd3ho?=
 =?iso-2022-jp?B?aWpxWURJWURWYmN0aWcvL1ZsdTE5ZlpMZnl1VVMyVVhjM2EyQmpBd1Ja?=
 =?iso-2022-jp?B?NW5KU2Z1NklrZGZkTmMwUUUxWDZVRnlqWXlIanVvV2JJUFBtMlpqNHlD?=
 =?iso-2022-jp?B?QVZrcUhJTy8rWnNpY0dqUWNMN1hmay9wZWdIM05JZXcxRW4xL1VjV3ha?=
 =?iso-2022-jp?B?VUptc3pXWDdHUWpQWnExQXpwbWhhU3l3Y2NzWElwd2lmOEptd0oyM1pm?=
 =?iso-2022-jp?B?NkV4NDJaRnc4TmpBYjJSV2Y5NUd1L1doeE5TQ1JYdFBJZDV0NFR4dXll?=
 =?iso-2022-jp?B?ckpjMzBkaDJnOVVDZm1uYUhnaGJQVXJtR1NKNGtjTjlRUFQ3Z2Frdnp6?=
 =?iso-2022-jp?B?QytEaEt4NkhITjk1aVBVRXRwNnA5cjZNY01OeUxobXFUOTRkczJDbnpW?=
 =?iso-2022-jp?B?RWlsQ3BKT1FPb29GTXc2Qnh3RDJDRENkLzRjUGwvZmI5Um1UY2IrZFNU?=
 =?iso-2022-jp?B?WURBdjBVQzlZd1AxLzk3MTFlcElDRXlQZDNFd2RaS0JxczdXUVpEQ2U0?=
 =?iso-2022-jp?B?clIybGtrVkM5cldYdlNZTHkyT2JwMU9zZjJ4SVNvME84Q0FnQzFLT2J4?=
 =?iso-2022-jp?B?Ym1WRW84TzMxeDE0YnBtbjBGaXMyNXFGczg5TTFHZ255WnBBaUJ0Smx5?=
 =?iso-2022-jp?B?L3Z6T0pPNGNtcXhrK0l6R0xMN0ovclYrZVIzc2JzejNwd00yWEhFbzdy?=
 =?iso-2022-jp?B?K2V1Z2pIVWs1TExCbVVueGs1dnpHbnhVZldsVVlOUTJPblVoN214dzdG?=
 =?iso-2022-jp?B?MllPdWFhNkJSVUlzdGJ1ZTVmMlI2bXVPMXZYL2JHaTN5STFLcTNQSHI5?=
 =?iso-2022-jp?B?Q2F4L01RamlscHpoeFgraS9sMC9ESkNoYTZHNGN6MDVldXJ1S01CT2k3?=
 =?iso-2022-jp?B?R01uME14QmJTSWRMZXdtbFZadkJyWnROZ2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eb4819-2e5e-42c6-a93d-08de0c697c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 04:07:13.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JQydzRWg0Isuw2ncYUIbLfvheYB/EjfGPqGTS9VHTLIz8KLe/9y6mVt5g0cAEDURekwxzHaVMvCdFeGH01wXyWbHIrOz06O8iNYi+RB0O1r2foLX52Fcw3Tll6rUL5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 04:07:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20181

Hi all,

CIP kernel team has released Linux kernel v5.10.245-cip65.
The linux-5.10.y-cip tree has been updated base version from v5.10.241 to v=
5.10.245.

Information about this release is as follows:

  v5.10.245-cip65:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      b498ef8f495d37c2c5c2e190140f0c46cfa52f5b
    fixed CVEs:
      CVE-2025-39697: NFS: Fix a race when updating an existing write
      CVE-2025-39824: HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      CVE-2025-39823: KVM: x86: use array_index_nospec with indices that co=
me from guest
      CVE-2025-39808: HID: hid-ntrig: fix unable to handle page fault in nt=
rig_report_version()
      CVE-2025-39817: efivarfs: Fix slab-out-of-bounds in efivarfs_d_compar=
e
      CVE-2025-39835: xfs: do not propagate ENODATA disk errors into xattr =
code
      CVE-2025-39812: sctp: initialize more fields in sctp_v6_from_sk()
      CVE-2025-39681: x86/cpu/hygon: Add missing resctrl_cpu_detect() in bs=
p_init helper
      CVE-2025-39828: atm: atmtcp: Prevent arbitrary write in atmtcp_recv_c=
ontrol().
      CVE-2025-39813: ftrace: Fix potential warning in trace_printk_seq dur=
ing ftrace_dump
      CVE-2025-39891: wifi: mwifiex: Initialize the chan_stats array to zer=
o
      CVE-2025-39848: ax25: properly unshare skbs in ax25_kiss_rcv()
      CVE-2025-39839: batman-adv: fix OOB read/write in network-coding deco=
de
      CVE-2025-39860: Bluetooth: Fix use-after-free in l2cap_sock_cleanup_l=
isten()
      CVE-2025-39841: scsi: lpfc: Fix buffer free/clear order in deferred r=
eceive path
      CVE-2025-39847: ppp: fix memory leak in pad_compress_skb
      CVE-2025-39853: i40e: Fix potential invalid access when MAC list is e=
mpty
      CVE-2025-37968: iio: light: opt3001: fix deadlock due to concurrent f=
lag access
      CVE-2025-39846: pcmcia: Fix a NULL pointer dereference in __iodyn_fin=
d_io_region()
      CVE-2025-39920: pcmcia: Add error handling for add_interval() in do_v=
alidate_mem()
      CVE-2025-39902: mm/slub: avoid accessing metadata when pointer is inv=
alid in object_err()
      CVE-2023-52935: mm/khugepaged: fix ->anon_vma race
      CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
      CVE-2025-39864: wifi: cfg80211: fix use-after-free in cmp_bss()
      CVE-2025-39865: tee: fix NULL pointer dereference in tee_shm_put
      CVE-2025-40300: x86/vmscape: Enable the mitigation
      CVE-2025-39913: tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict=
() fails to allocate psock->cork.
      CVE-2025-39964: crypto: af_alg - Disallow concurrent writes in af_alg=
_sendmsg
      CVE-2025-39967: fbcon: fix integer overflow in fbcon_do_set_font
      CVE-2025-39911: i40e: fix IRQ freeing in i40e_vsi_request_irq_msix er=
ror path
      CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap cal=
l
      CVE-2025-21861: mm/migrate_device: don't add folio to be freed to LRU=
 in migrate_device_finalize()
      CVE-2025-39876: net: fec: Fix possible NPD in fec_enet_phy_reset_afte=
r_clk_enable()
      CVE-2025-39972: i40e: fix idx validation in i40e_validate_queue_map
      CVE-2025-39907: mtd: rawnand: stm32_fmc2: avoid overlapping mappings =
on ECC buffer
      CVE-2025-39970: i40e: fix input validation logic for action_meta
      CVE-2025-39968: i40e: add max boundary check for VF filters
      CVE-2025-39985: can: mcba_usb: populate ndo_change_mtu() to prevent b=
uffer overflow
      CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for q=
ueue_priority_map
      CVE-2025-39951: um: virtio_uml: Fix use-after-free after put_device i=
n probe
      CVE-2025-39969: i40e: fix validation of VF state in get resources
      CVE-2025-39955: tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect=
().
      CVE-2025-39923: dmaengine: qcom: bam_dma: Fix DT error handling for n=
um-channels/ees
      CVE-2025-39937: net: rfkill: gpio: Fix crash due to dereferencering u=
ninitialized pointer
      CVE-2025-39883: mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(pa=
ge)) when unpoison memory
      CVE-2025-39987: can: hi311x: populate ndo_change_mtu() to prevent buf=
fer overflow
      CVE-2025-39953: cgroup: split cgroup_destroy_wq into 3 workqueues
      CVE-2025-23143: net: Fix null-ptr-deref by sock_lock_init_class_and_n=
ame() and rmmod.
      CVE-2025-39986: can: sun4i_can: populate ndo_change_mtu() to prevent =
buffer overflow
      CVE-2025-39945: cnic: Fix use-after-free bugs in cnic_delete_task
      CVE-2025-39980: nexthop: Forbid FDB status change while nexthop is in=
 a group
      CVE-2025-39949: qed: Don't collect too many protection override GRC e=
lements
      CVE-2025-39973: i40e: add validation for ring_len param
      CVE-2025-39971: i40e: fix idx validation in config queues msg
    added commits:
      CIP: Bump version suffix to -cip65 after merge from stable

Best regards,
  Nobuhiro


