Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF30CEBF8C
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 09:18:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.65071.1727428708926858130
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Sep 2024 02:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=q/Ewx37e;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1727428690;x=1728638290;bh=VB
	wK3wru/vdpxkO2HS9Rc4LXwfCz/b8d2qVwYBa2nYQ=;b=q/Ewx37euYhsU5WrJ3DEpmiOZFDk0Wm9
	dzZ7zd6+pW8MLN5zh+aq/2VO+6KGosdSGoRKOzTcyiBAPFRZbw550Z3prELfRolET9gbPBGwnFaNv
	995rvKA5RchaAJJdaRK8XKMR/KAclNQLMfk3bf0n5YbkhKC1prXEHtef9LdKnoikGRiYYkj1js8QA
	JCIPtozvW9l/vqQ0UYDM2EjF6UF3C0XmSciJEjv1hGScw4z/Pdd32Np+VMfnIXnSck+R5a2DoAvQl
	xJiihI96zSu1VZwdKc6z++DG75SdlB6he0DfDhAqS5eBPSxVuWtMLmSFx0tKUCL41Hal1GZ52tr4f
	JA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 48R9I9Zd227294; Fri, 27 Sep 2024 18:18:09 +0900
X-Iguazu-Qid: 2yAawTGyOe6VLZhDK8
X-Iguazu-QSIG: v=2; s=0; t=1727428688; q=2yAawTGyOe6VLZhDK8; m=tXM+VxlhiNgOdtsA8hI4u0ZZ0UkVKC/wvVlzX7R4iKk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 48R9I63J1531440
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 18:18:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8BpXzGIF1vcljTxEwygsOFpOqqGFky5sqlIu/OtGCV7KP9uQIg1yBf5Vxnf0yk7ceyvqylnP29nrE+GlMV6/zt4HUKepoE6DHyAuN+VxCqnNR6VRLnxeY1sQtejlz5hoLE06Spo931I9qMDF1DVenaO8s/QHexdEkHEUVu5i6lCtqUjfckzQq6F2SCp4rnNoH6XFPVP4Tkopzfica1AD0/cbEYozC6GG+Dnq6XXcGfMBBxsyjIYfm0+IVGNfvfe5FLMAM9vQPocoicixCHAiwtRUopxz+O7lVhFJgyWYKUj7goRovIcb00g0G1rSETAUrCs8ETdeB5JyDB+oIZ6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G2EtwlOrfJdgZzcFnOumd4T26U52VmBORXnAbcWrpc=;
 b=WtWw442SpeUxolYAB5dfs8XYTzoYGTI3cXE7MVs+BbQLL6jwDMjDgg0dRPaROlIXupzDOz6r3iWcXfWKLJa1R8s44g04fwXNy0F+bUJNxGKwTRMBUERRor0Tcf7sTJJpeFRHmZIjdJVsWf6frYExKpmE9yA2STOCAC54euWUL8AsRsX3CjQIQb7yaDPw7bWZ7/HNNksAmRn/DuAmTR/0bnbfpm+n9/1gYgc9SNutMkuweCNBZtAZD+HgPF+MP8PjGoZgMo0s01IYX2+YIUCKYubGBYLKQ4GmyASyYWnHFURSVrxcpAlvZx2ZdNkmk3mWhMBmCiaevKvuO7GxcJRIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.111-cip29
Thread-Topic: [ANNOUNCE] Release v6.1.111-cip29
Thread-Index: AdsQvhJYZWwtwJgvThW1qaEVldvzlw==
Date: Fri, 27 Sep 2024 09:18:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388E1A12A3A6AB83B86B636926B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB10387:EE_
x-ms-office365-filtering-correlation-id: 049d8501-bf71-4f1e-913d-08dcded54aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WUU0Wm52REo3NmZEbGpBR21QS3lVZEtReTh2MjVLYlozRzZSOUtyRE81?=
 =?iso-2022-jp?B?RnJqcSt6U2RkeTNOOGN6dDNrZ2NucXViTkttR0J4M3B0U2tMS2JoRWVs?=
 =?iso-2022-jp?B?NFNFL3pUbHJSNURDVzQ5VkUycm5SY2dPSjA5U0UxRkRxU08rMFBaTGR3?=
 =?iso-2022-jp?B?ZW1iS1ExOGFhTTZhdmxGdGVLSnRYVDVLVHpjeUNPSDRYQW9Sc1haTDl0?=
 =?iso-2022-jp?B?VlR2akVwWkVYaHpCWklwR2xHZy9TTW9rRzQ3VjlTaWZTZVhoSy95TmY2?=
 =?iso-2022-jp?B?SzYwUVlaK0kxdWlML0dpeitPUFROSzZHVEliY3JqT0cvZjJ1TVhtMGc0?=
 =?iso-2022-jp?B?eVVJUnpSdkExL05hcGY3Wm9Vd3paQmlnMWdkSDRGazZkeTZDNnJZRUNS?=
 =?iso-2022-jp?B?dUVKL2Vxd0hDVDQwQU5sRUxLK2NLcmFlZzF0R3puNnB4QXNRNHA4NWc3?=
 =?iso-2022-jp?B?ZkdocGo2YTdyTzRBOGc4NU04Y2xZeFkvOTVjSUpOZFRKMjFzRzYxREor?=
 =?iso-2022-jp?B?TngxTG1IdnFnU3dGZkx6ZFBDMUh5K2F4MG9rVGVGZllGOU5TTmh2Yjcy?=
 =?iso-2022-jp?B?cFVVMVJOaFRSS1NhSzFQNTRrU3dCa0J4QTBnM2ZCbkcyS2ZKbFFGQ0k3?=
 =?iso-2022-jp?B?cWJYWmJVRWVtNWxwSE9Ub0tPamY4MGlOc20rcWV5SmlqaUdJc1RVVHhs?=
 =?iso-2022-jp?B?R0lraEc1MnJZODBZRlBtdHNFNzRjUkdCMTVaU3FkUWhtNER5M1poQTJx?=
 =?iso-2022-jp?B?NVI2N1I0WG1YTnVrWS9uZVRpR3VOUEdzbGlxK05IUTN2ZW1YRFQ3L3ZB?=
 =?iso-2022-jp?B?V3dEaHBWOGh4ZmJyU0hlaDBPYktjQzFRaEcxM3lzNVdJV0FRVjdYZjNy?=
 =?iso-2022-jp?B?SUpZVzV6eVZSNjZpZTA2L0xFTENvekJrZWRmVDVzeUx0bW5iRFF4MVRV?=
 =?iso-2022-jp?B?WVZZdTRKNGR2QXpiSUt3QVBYd3ZQczB0STdZZFJ0WHowNDRqYnZvMFVs?=
 =?iso-2022-jp?B?bktVc1Q4cWN1YlBmZVN2NWdpTzJyTHAxMUV2eEx6TElWbGlvU25pR0ZP?=
 =?iso-2022-jp?B?UU5oQTBjUVh6aXowajMwMW40OHZUYjVoVmg5K3lsZE1vYm04SWYxYVZs?=
 =?iso-2022-jp?B?Z0NvV0tPc2RCc2doNWw1R0d4aHBGWk1HdEpBdUc1QkpLNkR3R2ZPTVQ5?=
 =?iso-2022-jp?B?allLNVVJdC9KSWc0L1ZOazR2RUZBTFV6ZmpCWk04ZEdZZXRGSjZabHkx?=
 =?iso-2022-jp?B?SU9IODlJTjBaR3p3eVVpaTZlU1d1bFJEbjZGYktoTWp4YzNDcko1VGJl?=
 =?iso-2022-jp?B?YTZVRkl4OE02VzVuNnZ1NDJ2Nm1HZ0k4Wjh3U0FFeDQ0WVQ0QytQc213?=
 =?iso-2022-jp?B?TUJzaXBLakZLQy9GcUZ0eHBtY1h3aCttc3RoQWtua3VVclpFazFpNnlj?=
 =?iso-2022-jp?B?Sk9XczViUWxwNWJVTkVScVF6dmRWODVrNWNJZGpQbDgyblhYRXNTUVpH?=
 =?iso-2022-jp?B?cGtWWHdOWWtXaThkWWJFMmtjU3R6LzV0R29XTXl1ZHErRXR6dWNKbzhx?=
 =?iso-2022-jp?B?N2xqVU40N1VMNUZRQUFhbkVGeVc2NHBVOVIzd0c0YW41WTNKTllQVjN0?=
 =?iso-2022-jp?B?amJkemgweEcreEdNcGdpUlFCZ3lDSmQyMXRaUktEcHMwT0JSMjJkNXBZ?=
 =?iso-2022-jp?B?YmRwZlAzWkJDMEh1eUhlRWFWb2plaUNFdFQwdFE0d2trUFJIR2FqeE5O?=
 =?iso-2022-jp?B?cVZaTDFDOFBxVTVvSnY4SWdsOFJwQWJERms2WlNHeWtudHk2RURFNytP?=
 =?iso-2022-jp?B?d2wvSnRNSUxJNzNEOGVoZGJLaWRIQUo3L0lyNmFnV1l1OE1GbithVHkx?=
 =?iso-2022-jp?B?dS92OTRMb1pFTmY1YjFhcnZlbVBvbll1MjdkT2M1eVlGTTlEWXNyeDJW?=
 =?iso-2022-jp?B?WmhBLzFxcDdaMFJYcjFTOHJRaFB6YlQzaVZEQVFlT1JSTkZVeFdjVHNU?=
 =?iso-2022-jp?B?ZHdvQXpJUmtSTFVEYm5vTHBwWlA2VGlreW5xMlhRNzJOemd0QU0zM2xo?=
 =?iso-2022-jp?B?bzMyRDRjMXJnSWlETmNFNmh3ektIRzUwZi91dWJZdFlob1FwSjUrNlUv?=
 =?iso-2022-jp?B?Wms=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bjZ5VWh1Y3JzTlpxbndsYWpxWkZuZGZMTEtwZGhzblAxVVFpRFFUTGVZ?=
 =?iso-2022-jp?B?OXd1U2d3ZDNIQSt5cm9KdENxV0NLK2hIVmJVdXgzNHZSbUFwYkRXR1Iz?=
 =?iso-2022-jp?B?VEhzS1hYWlc5eElEOEEycm5rVGpaSWluUzV1NzJhU3BqZkFTTDFUTkc3?=
 =?iso-2022-jp?B?cjhHcWxlWVNJOFFPRSsyQmUzUHB0cmRSQWN1MUswMEpjaC8wV3hiY3NT?=
 =?iso-2022-jp?B?S3ZHQXZ1amlPMkdZNjhMcURzQS8rR3ZmdVAzNFNKSnpiZXB1dDF6Z0s1?=
 =?iso-2022-jp?B?Yi81Tm9SYnJwSU1QSEZkeThhR1ByZ2Q5WjNlTnVBQUM1eWhyRFJBSHo3?=
 =?iso-2022-jp?B?d1VtbXgrVDRoejZMK3NJakx4WkFjTE9LbDQwRlZCSGNTVEkyR1pWZGFB?=
 =?iso-2022-jp?B?QjBpSGoraFJYWXZYL0ZYK2ZWSjdCY3I4all0MzRzbVFKaU1PN3I3Z1JN?=
 =?iso-2022-jp?B?a1Y5NFNGdndTOEFFMWo4M0JZWnh6S0ljT2xMcFJ1YzR3c2lLWVNTYmZZ?=
 =?iso-2022-jp?B?MzRvckJJMHpBbmRWdDJQenlGMFVTTGZqeldIR2pETkJ1VW5yWDhuakQx?=
 =?iso-2022-jp?B?N3RIc2RqRmNGczdwYW52WU5RWkpOQUpuUXhodFRWU1BjeUcyRFZjNE8v?=
 =?iso-2022-jp?B?alVHK2diZU9XNFU2REdDbWgxWDNyNUNLZlRnZXB3KzE1UGVGUEVxRjJP?=
 =?iso-2022-jp?B?RENFYmlOdDJ4MWNHZ0JMMW9FSk1XOERtUGQvTGNSSE9qUWxZc2NObEZK?=
 =?iso-2022-jp?B?RjJKMTIxYjJOeklpM0NhS0dmb3MydlRPYXI5WG1aTkQwanhWSFF2V0Uy?=
 =?iso-2022-jp?B?MG1qRGg4TGtpWE9TNDNRWjg4M0tCRGNhVmFBNjh1Q3RmQWl4TlBsVWtT?=
 =?iso-2022-jp?B?T0o1RTBYZDQrTGtOYzBlWXVUNTI2WXlyUkJ2V2VOSkc2NUMvcnc3dFJt?=
 =?iso-2022-jp?B?WEVEMHExY1VSVFI3ZzFuZGxsS2IxdVZVMEFoVjN2RUVxREhMS09WVmRV?=
 =?iso-2022-jp?B?dHBxNGxQWFBGRnEra3l3MExRYXVQUDBiczdiZ1h6TFhPWWFFU1ZEZVJv?=
 =?iso-2022-jp?B?NFV5bGExY202Y0dtSmZacGZ4cE8xL1U4UlpnVTU2b0RQYWRHeFE4SXUw?=
 =?iso-2022-jp?B?ZWIrL2tabWsyWXJha01FZGV1M0p3cnMvWm12SzhDdjY0VnZtTm9qSVdv?=
 =?iso-2022-jp?B?VXRzMVloMk9hOWpLRXZ2MTR5T282RmdpVTJOSThrc0JWOGJnY3JPZzNB?=
 =?iso-2022-jp?B?d2UrdmJQL25xYXFmVWd0REZYYlk1OXlESklNTlJpS21WK096SlNaM29N?=
 =?iso-2022-jp?B?L0RPdFd3V1IwSkRKNG02RDBWWG5pVVBVN0w5d1h0Rm1JWUxUNU1MUFFR?=
 =?iso-2022-jp?B?Z3BWVWNxUEo0dkoyKzJRamtvZllnSVEzRUpFWmlENHVHT2p3OEV3aHFJ?=
 =?iso-2022-jp?B?N1Z0VE0vMUxjRlc5VFlOREQzTVNSbnM3SGE5eUxmSE51dVE0RGhzTjBv?=
 =?iso-2022-jp?B?SnJlUXd1ZUlsYnR4dXpYcmdnOWVUYmZMZFZQWktGcVBQN3h1SUhhNzlH?=
 =?iso-2022-jp?B?QXFOOWJNRG0xZzRtSjA2cklOb3pGZjI3aXZlY2VseTVqVGIwazBXS2tL?=
 =?iso-2022-jp?B?VGhSSW1jNHFuckViOXFaK08rODk2OVhpLzNFaUhhTmVnem9VanlyZWU1?=
 =?iso-2022-jp?B?TXlZOFFodWtSMEhtbGhUejFJd3A3aSt5b1c3RjFnS1JEVjU2OG5PWnNN?=
 =?iso-2022-jp?B?TDk3Q0pMRzhSdzE3TW94MW1JdzB6d1ZUNXpOdDNWUVRIc1l3N2hUcDdV?=
 =?iso-2022-jp?B?RDNoK2FaWTZqdENhTzZFOHJtdEppRCsrOVc5VHBibUxlZWRPYldZdDlv?=
 =?iso-2022-jp?B?SmdaQW1lMGY1ZnFzd0FlcEZJcTJ0WXgvWVVRdnRlOEt6eWlsTDFodnJ6?=
 =?iso-2022-jp?B?K0kvei8yZDVickNFT2pzMmdjNXBZTWp1bTByKzdBZVJQakRHM1N6Nllu?=
 =?iso-2022-jp?B?Sk5mblJWdDZHb3ZGcjhkRUw0ZXZCRVBXTk53MnpnaW1DajZkVSt6bFBQ?=
 =?iso-2022-jp?B?SCtoQ3QvNzduWGNja1R2b0lROWdmZit2ckx4VzQzNjloMDhIL2JpVHVm?=
 =?iso-2022-jp?B?NjFrWCtqOGtFY1pMQ0ZIaG1WdjA0UXFkN29wUm1Kb0g5cnBOSlJmcEl0?=
 =?iso-2022-jp?B?NTJVS3VFdjFSZHMvNXltZEJySFJIZk4xUis4S2VISkZrWHFtV3pIVVFj?=
 =?iso-2022-jp?B?WjBkN2hkYVZhM0RIbWUraHQvQkt0R2Y1Wi85Y0poU0JqR1RTTWo0SW1y?=
 =?iso-2022-jp?B?Y0g4ZmN3RkdlSDRrQVZoUDVoT2o0ajQxR0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049d8501-bf71-4f1e-913d-08dcded54aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 09:18:04.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEvaA5gi9mO9z3bpsBFeiiLoOaBlml226MJ8gZOI7wYBwMG+7046xQ8GyK0sq6ahvU2QeQjttEtdgJE2k7t6hiqxvo05vU6FvrCZJZhtod1rjGgxSUylF0UepUjc9vYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Sep 2024 09:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16924

Hi all.

CIP kernel team has released Linux kernel v6.1.111-cip29.
The linux-6.1.y-cip tree has been updated base version from v6.1.107 to v6.=
1.111.

You can get this release via the git tree at:

  v6.1.111-cip29:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      0f19f32122651a230b262ce09853c6e604e18a23
    Fixed CVEs:
      CVE-2024-35943: pmdomain: ti: Add a null pointer check to the omap_pr=
m_domain_init
      CVE-2024-41096: PCI/MSI: Fix UAF in msi_capability_init
      CVE-2024-41098: ata: libata-core: Fix null pointer dereference on err=
or
      CVE-2024-42228: drm/amdgpu: Using uninitialized value *size when call=
ing amdgpu_vce_cs_reloc
      CVE-2024-42314: btrfs: fix extent map use-after-free when adding page=
s to compressed bio
      CVE-2024-43835: virtio_net: Fix napi_skb_cache_put warning
      CVE-2024-43859: f2fs: fix to truncate preallocated blocks in f2fs_fil=
e_open()
      CVE-2024-43892: memcg: protect concurrent access to mem_cgroup_idr
      CVE-2024-44974: mptcp: pm: avoid possible UaF when selecting endp
      CVE-2024-45010: mptcp: pm: only mark 'subflow' endp as available
      CVE-2024-46673: scsi: aacraid: Fix double-free on probe failure
      CVE-2024-46674: usb: dwc3: st: fix probed platform device ref count o=
n probe error path
      CVE-2024-46675: usb: dwc3: core: Prevent USB core invalid event buffe=
r address access
      CVE-2024-46676: nfc: pn533: Add poll mod list filling check
      CVE-2024-46677: gtp: fix a potential NULL pointer dereference
      CVE-2024-46679: ethtool: check device is present when getting link se=
ttings
      CVE-2024-46685: pinctrl: single: fix potential NULL dereference in pc=
s_get_function()
      CVE-2024-46686: smb/client: avoid dereferencing rdata=3DNULL in smb2_=
new_read_req()
      CVE-2024-46689: soc: qcom: cmd-db: Map shared memory as WC, not WB
      CVE-2024-46694: drm/amd/display: avoid using null object of framebuff=
er
      CVE-2024-46711: mptcp: pm: fix ID 0 endp usage after multiple re-crea=
tions
      CVE-2024-46713: perf/aux: Fix AUX buffer serialization
      CVE-2024-46714: drm/amd/display: Skip wbscl_set_scaler_filter if filt=
er is null
      CVE-2024-46715: driver: iio: add missing checks on iio_info's callbac=
k access
      CVE-2024-46716: dmaengine: altera-msgdma: properly free descriptor in=
 msgdma_free_descriptor
      CVE-2024-46717: net/mlx5e: SHAMPO, Fix incorrect page release
      CVE-2024-46719: usb: typec: ucsi: Fix null pointer dereference in tra=
ce
      CVE-2024-46720: drm/amdgpu: fix dereference after null check
      CVE-2024-46721: apparmor: fix possible NULL pointer dereference
      CVE-2024-46722: drm/amdgpu: fix mc_data out-of-bounds read warning
      CVE-2024-46723: drm/amdgpu: fix ucode out-of-bounds read warning
      CVE-2024-46724: drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel=
_number
      CVE-2024-46725: drm/amdgpu: Fix out-of-bounds write warning
      CVE-2024-46726: drm/amd/display: Ensure index calculation will not ov=
erflow
      CVE-2024-46731: drm/amd/pm: fix the Out-of-bounds read warning
      CVE-2024-46732: drm/amd/display: Assign linear_pitch_alignment even f=
or VM
      CVE-2024-46734: btrfs: fix race between direct IO write and fsync whe=
n using same fd
      CVE-2024-46735: ublk_drv: fix NULL pointer dereference in ublk_ctrl_s=
tart_recovery()
      CVE-2024-46737: nvmet-tcp: fix kernel crash if commands allocation fa=
ils
      CVE-2024-46738: VMCI: Fix use-after-free when removing resource in vm=
ci_resource_remove()
      CVE-2024-46739: uio_hv_generic: Fix kernel NULL pointer dereference i=
n hv_uio_rescind
      CVE-2024-46740: binder: fix UAF caused by offsets overwrite
      CVE-2024-46743: of/irq: Prevent device address out-of-bounds read in =
interrupt map walk
      CVE-2024-46744: Squashfs: sanity check symbolic link size
      CVE-2024-46745: Input: uinput - reject requests with unreasonable num=
ber of slots
      CVE-2024-46746: HID: amd_sfh: free driver_data after destroying hid d=
evice
      CVE-2024-46747: HID: cougar: fix slab-out-of-bounds Read in cougar_re=
port_fixup
      CVE-2024-46750: PCI: Add missing bridge lock to pci_bus_lock()
      CVE-2024-46752: btrfs: replace BUG_ON() with error handling at update=
_ref_for_cow()
      CVE-2024-46755: wifi: mwifiex: Do not return unused priv in mwifiex_g=
et_priv_by_id()
      CVE-2024-46756: hwmon: (w83627ehf) Fix underflows seen when writing l=
imit attributes
      CVE-2024-46757: hwmon: (nct6775-core) Fix underflows seen when writin=
g limit attributes
      CVE-2024-46758: hwmon: (lm95234) Fix underflows seen when writing lim=
it attributes
      CVE-2024-46759: hwmon: (adc128d818) Fix underflows seen when writing =
limit attributes
      CVE-2024-46761: pci/hotplug/pnv_php: Fix hotplug driver crash on Powe=
rnv
      CVE-2024-46763: fou: Fix null-ptr-deref in GRO.
      CVE-2024-46770: ice: Add netif_device_attach/detach into PF reset flo=
w
      CVE-2024-46771: can: bcm: Remove proc entry when dev is unregistered.
      CVE-2024-46773: drm/amd/display: Check denominator pbn_div before use=
d
      CVE-2024-46777: udf: Avoid excessive partition lengths
      CVE-2024-46780: nilfs2: protect references to superblock parameters e=
xposed in sysfs
      CVE-2024-46781: nilfs2: fix missing cleanup on rollforward recovery e=
rror
      CVE-2024-46782: ila: call nf_unregister_net_hooks() sooner
      CVE-2024-46783: tcp_bpf: fix return value of tcp_bpf_sendmsg()
      CVE-2024-46784: net: mana: Fix error handling in mana_create_txq/rxq'=
s NAPI cleanup
      CVE-2024-46791: can: mcp251x: fix deadlock if an interrupt occurs dur=
ing mcp251x_open
      CVE-2024-46794: x86/tdx: Fix data leak in mmio_read()
      CVE-2024-46795: ksmbd: unset the binding mark of a reused connection
      CVE-2024-46798: ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object
      CVE-2024-46800: sch/netem: fix use after free in netem_dequeue
    added commits:
      CIP: Bump version suffix to -cip29 after merge from stable

Best regards,
   Nobuhiro


