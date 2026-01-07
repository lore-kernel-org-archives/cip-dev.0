Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC7CF6BE2
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 00:41:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5048.1767746488490467156
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 16:41:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=XEvmqDfp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767746456;x=1768956056;bh=cAuW7neXpzl6HYHn5grj7lcLrheO3XnoROIfC
	cuXXD0=;b=XEvmqDfpLnPpwL4iyH1hnLLIZV9cVQKPIZHxRa25PpsrbONbOgs1oG8hKtpe45NSEQL
	GK83mkr4Q2At991yV6DvyrBS1FLDE10aQpgHe0AvXavQJ71dqgr6anW92kTZ0YMTGR9NioHooniSj
	JEicLL82ajtmgYX8FnDvwdSKEdJTscR4351Z5V8D4SF/ff7eKs7tX2/vjClq3EYP60YDMsiue4ALb
	cO51BcOiBrFy10DFdcvRZ1cHgwAWO4Sj6/K/e0a551Yc7EEm5WRjJ2KgaeZdPzZJIBhjZ7plUIE3M
	AG6+VgQYn5qWszsWt6AmLMCig6ln5s1s51XokrWfO3xg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6070euc52683375; Wed, 7 Jan 2026 09:40:56 +0900
X-Iguazu-Qid: 2yAbnhzkb3oOn8AsCu
X-Iguazu-QSIG: v=2; s=0; t=1767746456; q=2yAbnhzkb3oOn8AsCu; m=bP7quLAUFuWPC/fe46RLbNfGijrI/WvY2wT+3YziLXk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dm8N75vxbzyPQ; Wed,  7 Jan 2026 09:40:55 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/wNpd4KLgL6NMo6qkttNQATV4DdyIYP7938gI8MK9VHRjQOpW6cECxaWCdekSPTAQ2E8LeBey8FSB2bJEANOxhErOVjk0UouKGHlxRDJVEv3okFLQrhpNeKKj2QeP06my5Hi10LnuEkzuo5B9SBSNasSd/XuNrmCavHdzj/VwGG64ozWEuGo9OmgdrHi+jFhJ6KfXhXqUWQ+5Z3TrHcUW2/C8q/96IEJJbpOZVy+et6dznV/2U6/u1quu0ovOnmCf9B/RcTgpTF4IPt5nzxu6xrmQ2zVx6nQU2//BJpPZkZcRe4pCAZyG+bY5M+wiDFVn4aLlYZX70uzmZ+Xt9e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsiJCTUvT0qEmPvDPX6Rx0IFapOR8Sb0u01l8u6ICuo=;
 b=tdTyj5ydIiOn5pRjvUWfxLgQDDrBGejo20JiTWs6gDgm91C5iz/PW6FAlwE+0PYLe7mIPcPi1fvYVC8jq/B/AQtdBUc1ywzO1176J+qaW3Kok8rBaK6VmQGVwoxz4AUbcIKJ/++h/VLuFzvJP86yz4cR8TKVw09ddx9gVKYixrsOM6qGaQByjQY4m0k9FvfQ1wiRdl2saTvd9qWjm+s+XAOu74ajk1lj2o5C2Wf9NoVWsDPOwy+cU2caGKtfD1qqT9v2vuyRkHT+QeUVeIQ7KdA3qDadJABkbtF/6kG3/MLYAoLGm0PGZwAHgPX3+lTaS871hOefP7jZzmUPftiqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.4-st71, 4.4-cip106
Thread-Topic: Request for review for 4.4-st71, 4.4-cip106
Thread-Index: AQHceIf0i/Ay+zgChUeGix6O078BibVEb1cw
Date: Wed, 7 Jan 2026 00:40:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BAA5CD71ACE6FAAB4236CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1675394165.12181.1766987804067@webmail.strato.de>
In-Reply-To: <1675394165.12181.1766987804067@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYTPR01MB11034:EE_
x-ms-office365-filtering-correlation-id: 9dbc8089-7049-43b5-f1be-08de4d85698f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NVJDWUlVWTlWZzBJbDd0YnEwUHdIWDhuTGx0N0VEUS9oTWNNOEhNMS84?=
 =?iso-2022-jp?B?QWVsaWx6MWlVSi8zWnhNQzhrWm5Rc2xwWjFTaldDalBuZERMMUdvTWdt?=
 =?iso-2022-jp?B?NTA2ZUdwNE5VUTV3T2dMcmdUdERvYVpJMWFDVENLR01pbGdpd1p4VCtX?=
 =?iso-2022-jp?B?MWxUSlIvb1EzQjJKN3p2WTVNQ1Z4cVJNYS9BNzRPUWZvSnprWUF2M25D?=
 =?iso-2022-jp?B?SEwvV3dydlBtSmM4djZsaUp4M1BEc0FGN29tZlE1RHhodXNtSC9qWmJL?=
 =?iso-2022-jp?B?bUxtTFdSOTg5TkQvMHlTMTF4UmZrSlNWb3pwK0wrK0FaZ0pndm02N25W?=
 =?iso-2022-jp?B?R3F0RFVtZEN5TG84TzJWZm02NTQ3ZWFmTzJ4S1hnU3NMTUtVRUtZMDly?=
 =?iso-2022-jp?B?d1JwNEgyNUJPT3I5bVR6TkwrTG5XbEN3S1VXZDhJeWtkTjBPemE5cEsr?=
 =?iso-2022-jp?B?V3JmeWFqSE94dHpKT0RQOTExU1FKMjlTbjd1T2hzWDlMZlhrYmNVVHN3?=
 =?iso-2022-jp?B?VEZvdkUvTWhtQkxxbnFmbEtndnFyNEN5ZGc5ZnkrRkx2MGJ3a3p5a3dY?=
 =?iso-2022-jp?B?bmhkY3g5djNML3VJNWVjMStVME84TVFaUUllNlBzR0JOaUg0clJFNTNo?=
 =?iso-2022-jp?B?TUkzN2hlbE02b2UwRXErMDBURmlRd0hoWUhwZTdUK2tpZDJlSmdGeVRh?=
 =?iso-2022-jp?B?bEhXNXVNQWQ2SWp3MnE3eDI1R3BxcFp0QWZwczRrTXVXZitDQUZrb2U0?=
 =?iso-2022-jp?B?UmxGcUhSYk5DczBpL3pzeldsQzZsLzB6NkpsVTI0MVlEWVV6aWJuNGxW?=
 =?iso-2022-jp?B?d282U0lNS3BoRzRKOEtDZ3hZR0JEQVBRdFhldjJoYjRTczNML1FPaTBD?=
 =?iso-2022-jp?B?K0FqcDVKcTVDNThOZE5sd1NIaUVZNzdIOVZsQmx4aEFPTW5yaTlKcHox?=
 =?iso-2022-jp?B?MkFlNlM2M3ZnMDh4Y1g0a2NDa3ZTT3Q3MWhmNWI5dTVuNzBEbHZ5dXVN?=
 =?iso-2022-jp?B?MU94cDdmMUVLVlFDajNLNmd1WWgzaWM0WDNXTlJqekZaVVd0WWtlMUxx?=
 =?iso-2022-jp?B?RXFQZUFMWGdFaE5TNCttWUN1QS9iRlp1OE9ZczlDcU13R1gvNGxZdTVD?=
 =?iso-2022-jp?B?dC9IaCtiVGRGSUU2aDVSdC9jSHIyWHZockF6Ymo1YWVqUWdvbFpkK3l5?=
 =?iso-2022-jp?B?dEdBUnBRTUxBWkNlVFJZSDBydFE5QVRzQnRSN21HVHhkN0lQMzVsbklZ?=
 =?iso-2022-jp?B?WkZlQ3lOM3REU1hkYnN2Mk4vSkoyeVRkMG04QjQ3ZDIwbld5RFdKK0RX?=
 =?iso-2022-jp?B?ZjNUTWhUcTdXQ3gydC9CampUTjJLQk1yVGpmalJtODhUYUI3dVpFb2E0?=
 =?iso-2022-jp?B?Wk5TajROUnh4UDBUc1B6aVlYSitrVittZE5Fc1crN21ZdkJ5bDdBcTdT?=
 =?iso-2022-jp?B?WWtQekJpZUZFQVdmcnpuem8weVNWUW1JMWNJdjVWekFiNXg5TG40Nkdx?=
 =?iso-2022-jp?B?VFlIT2FVaGhlQUV2djNOUjdYYTRMSEtlZmZsaWh2Q2U5VitodUh6aTFW?=
 =?iso-2022-jp?B?Y2dFU3cyakJlK2NDNWlLVDZQQktjZ2FmZEg3R0FJTUszWm10MW9lTVNy?=
 =?iso-2022-jp?B?TU5EdjRhQnEzdHNHdE1oMGZQU1dMMmVKc1VCYWI2OGlvSUkvMzdURGVS?=
 =?iso-2022-jp?B?eEVtcGxVeHRvZEt2ZkhWRmhVbVlzTldPSEtBNFFveDZGMUpQcHd5ZVZa?=
 =?iso-2022-jp?B?dVpnSzdXWmowVEFLQnpPL1AxYXZvQk42cXdUNXpvSVlhV2pSbHN5U2Nt?=
 =?iso-2022-jp?B?TVNwRk9xbDRDVkh6VSt6VlFYcWw3emcvV0xkaUNiUFUxOTdJOEVjT1BQ?=
 =?iso-2022-jp?B?U3Y0N1ZOTWJrdERjaXd4eVArRERIcHowUHd4a2lEeTdhYWRQTnd1ak0x?=
 =?iso-2022-jp?B?ZERlMHBpVG41TjdhdEdKUXM4dmVuZVM5dnpjYTFCM0JrQm8yNWo3ZHdF?=
 =?iso-2022-jp?B?MXpKNEdFdndJUDJ3NndUbHJIWXFSSzFmOCs3c05MNGxVYW82T2pvdE0y?=
 =?iso-2022-jp?B?STJmWTE0S0J5RHBIQ1dJcVkrODZtNnlJRkNzRkdQNFBwcmxaRVlwbFF5?=
 =?iso-2022-jp?B?STgya3pGNTFtSURiSStmOUNZckk4VktUTC9xMWNzM0RSclZvTWdBd0dG?=
 =?iso-2022-jp?B?UG9teUFFdkk1MHBRQlhVSFkwTm1uNjNm?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TWVidkxhWjJnMCs0OGw3VjdGMjlmV2tWRnZndnVxSW5kN0RaTEh6ckhD?=
 =?iso-2022-jp?B?WFRMU2V6eXpPNjdOVUd5YlUraWRON1lDZ1B0QUZDTG5wSG9KcDhncVQv?=
 =?iso-2022-jp?B?SzJIR1hmbEIwQk82UktKMmlQdTN1VjVJTld3YWZWdjQ0Z3ZRNnNaM1FY?=
 =?iso-2022-jp?B?TFdiQmpzSldLUHVDRndnakQrZ0VKbDh0c1BlSEJrVzU1S3ErcmlLMlBk?=
 =?iso-2022-jp?B?WnZOdnJuOXZCQnVNNEdQbDlLWnoxWkRRM3hKK3pIeERSUThoTVhCUVNi?=
 =?iso-2022-jp?B?YnlUTXFaRFZldXRiamIyZnR1b2dsdnUvZFV3VE5yZnNQOGlIQWg4ZGtV?=
 =?iso-2022-jp?B?SmczUEhzK2VpNmo0dE9PMWd0by8xNWl1TzYvUjFvMGMrM05pZW54Nys5?=
 =?iso-2022-jp?B?ODhQNjRCV3ptTmJzeFcyd0pibWY4ZXBUWkNtU3BEblZLazBzbWFpUitw?=
 =?iso-2022-jp?B?NXJMODhYOUZiN2l6SnFyQ29lZjJlajk3d21GUUZVenBIY3gvNmhlVlpt?=
 =?iso-2022-jp?B?QjRZTXNnYU1BVWw1SnRKcmhCSDA0cnJkQzI4RjJPeTlIS1BKelMrNHBY?=
 =?iso-2022-jp?B?RGMxSDRlZEhOTzUvVDBWZWdKV3AyQ1JGaldjeHhodlQ0UWhHSWlWVlNj?=
 =?iso-2022-jp?B?WkVmKzB2QlE0cnBuNXZJRGJqbGRCMzlqM0RHTXAwWVpOK3pJeWRrODhR?=
 =?iso-2022-jp?B?UURKN2hrMHlnM2lhKzFURjlPaytlRmxaZDFYR3F5SHZvb0lJY1BZQTd2?=
 =?iso-2022-jp?B?cEdTQkV1WklOd0cyY3poTmdaTFV0b2dFWERPeVdzY3hTTzl5ZXNBalVy?=
 =?iso-2022-jp?B?UXorT3lRT3NHSnJNYVpaMDYwazQvMm1HVlN0MjVKbGg2dHNjdUQ5aGF1?=
 =?iso-2022-jp?B?N291RE1QbzlJVW4wODRWVkphdDRLMWU2MWx4TWdVb0dhOXE4SnMyUHFE?=
 =?iso-2022-jp?B?aVVDOHV5Q0ZSV1dYbnY0a0Y3UjlnVnhwVnczUWJ2cFpkK3lRNUpkMWxU?=
 =?iso-2022-jp?B?cTROMjdReUQycU9sZmNpdkN1UmNDUkpIWFFRNHBPTVlJWEtlb05ReXRS?=
 =?iso-2022-jp?B?TnJWNmgrTU91Mk9TeWZaQ2RjNFdFQTdmUjU0UUxUeVhWaHNmUTk4WDEv?=
 =?iso-2022-jp?B?eC9NY0VjZElZWW1WMVpiU1RBNzVzMW1OQkc4MXptTFkrWlVHdDZxTEtp?=
 =?iso-2022-jp?B?VWY1Z1ZyNmtZS29Pb0pqbSt3TE1xL1BiWmo3eHBjRUxPN0JBc3JUTjd6?=
 =?iso-2022-jp?B?bU5lTWRkWDJHWmVRaGYzZDVIc0lkbENKSUFTNG9BV0RtOHN3eEhVK3Zl?=
 =?iso-2022-jp?B?dDdreVAvWmQzR1NBT1Irb2gyNHlzRVhVYXo2Qkt1bWg3ak1PNmN0Znpt?=
 =?iso-2022-jp?B?bFFQcU5kMWNKR01iRDh3TXF2c0ZTZUgrUG5OMDltU0hPNlNnd3A4ZTZM?=
 =?iso-2022-jp?B?WTZydSt1cG9DUE9ISmcwYVBXanphUHBqT3Vkc3d2ZG9Xb1E4cHU0eEwy?=
 =?iso-2022-jp?B?bmJSQTQxaVZhVFlwL1dDNVlENjhBOUZyLzdFQTZXd3dzOEhQN2Y1b1Zs?=
 =?iso-2022-jp?B?eWU0Nmk1b0hSUkJJZ0JqZkhycHErTUY2RnBkNzZtU3ZVSkhrNUwxVzk2?=
 =?iso-2022-jp?B?eUlJNkVWVm5KQWsrTXJoelk2NDFEVzQ4aXFrWGxRQVZKSDBYN0prY25L?=
 =?iso-2022-jp?B?d1hmWGlvTXN1WVErYnNLaXdUNG55SHUvaWhXMmNsTi8yeFVCcENQTDRR?=
 =?iso-2022-jp?B?S3pBTHptNDRKczdDa3ZXQlBrSWR4ZkhCOG1YbUZBZi94bUpXWjRNNU1m?=
 =?iso-2022-jp?B?WkdlYkRGVnJiY2htWm92L0tLTTFBYkxjdnNzd2RjZEFNOEFod050SFdy?=
 =?iso-2022-jp?B?N2VNeHdwL2xXV3JlRDN5TEc1RnQ3Z0YyTjM4aFU0WkdESW05ckFnN0hk?=
 =?iso-2022-jp?B?Tk5kc0dZRERPK0R1ZmRQblF5aTBzcVA5SnhHbHZzTXREV1hUTEJuUFYw?=
 =?iso-2022-jp?B?WitPNFNWbXpCZ3JVakcvWGpTaEdxRFU1SVgwUzE4R2tWK0N3K3RzWHpm?=
 =?iso-2022-jp?B?R2hLU2xEbmtSQ25STTZGM1kyRFNKSkRldmxMTnVOV2dhUUpQSy9rbTJo?=
 =?iso-2022-jp?B?ZGc2L1U0TElaTms2dUtJY1p1c0pSWjZNUWprd0RVZlRlTmtIdkZ5SG5E?=
 =?iso-2022-jp?B?blhScVpTc1U0WHU2L01vRWFDejJZMDhXQjhWY0dPbkQxOURJY3pjSmkw?=
 =?iso-2022-jp?B?cmxObzJ2YUR5Slk2bUFFdTQ5VmgrZlNkT1UwNG5xRTYvQUIwQk83dE9i?=
 =?iso-2022-jp?B?UThTMzR5QU81MFhFL0svRzR4aGs1VTdPVloweXlUUzlLZWxTenBLWUsv?=
 =?iso-2022-jp?B?bDl5MVJKWHBUV1pjT1NzM3hoOXBiVVBJSlpMdWxNRlNUSytXSmtJQSsr?=
 =?iso-2022-jp?B?WWtHV1dtWG5kcTVQejB5NDQycmVyZUxFcUdiZmRNdlZraWtxd1k5WXE2?=
 =?iso-2022-jp?B?MFNxb295NEl5eUdTY2VMNkVLRVdaRkdGVzNyVEJhUzh2SjlWRVVNeVZZ?=
 =?iso-2022-jp?B?Zmk1WGhUVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbc8089-7049-43b5-f1be-08de4d85698f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 00:40:52.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRts+T/2MURwDmqzJKTOmAuJzpQFqABGeAwJHBGntI0XzHxvZAPKXMToJ1fSLzyFnFindw+WD9RBRdzDbrZuQdH11yezm1MSilVGZlqU41ZeHglCeR9QXPFg9ryhZDwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 00:41:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21393

Hi Uli,

Thanks for your update!

f0a41ac1bb6fd iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sa=
mple before setting register
bitfield.h does not provided 4.4.y kernel. Please drop this commit.

The other commits seem to be fine.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Monday, December 29, 2025 2:57 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Request for review for 4.4-st71, 4.4-cip106
>=20
> Hi!
>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays
> they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-
> 4.4.y-st-rc
>=20
> eec045863d21a wifi: ath10k: Fix connection after GTK rekeying a48589643bf=
dd
> iommu/amd: Skip enabling command/event buffers for kdump
> ff08d7a8c5806 net: netpoll: fix incorrect refcount handling causing incor=
rect
> cleanup 713eab81a91ae net: ravb: Enforce descriptor type ordering
> e5614027881ba net/sched: sch_qfq: Fix null-deref in agg_dequeue
> 05a9484527b6c ata: libata-scsi: Fix system suspend for a security locked =
drive
> 7af6c5e760217 fs/proc: fix uaf in proc_readdir_de()
> a3c1eb2bab5a6 Bluetooth: 6lowpan: Don't hold spin lock over sleeping func=
tions
> 648881139872a Bluetooth: bcsp: receive data only if registered
> a84ba2b7b6f69 nfs4_setup_readdir(): insufficient locking for
> ->d_parent->d_inode dereferencing
> 31db58f15a066 net/cls_cgroup: Fix task_get_classid() during qdisc run
> 2711f9d9013eb usb: gadget: f_ncm: Fix MAC assignment NCM ethernet
> 9d0655d33b789 net: usb: asix_devices: Check return value of
> usbnet_get_endpoints
> 8299fa5409dc6 Bluetooth: btusb: reorder cleanup in btusb_disconnect to av=
oid
> UAF
>=20
> Thanks for having a look!
>=20
> CU
> Uli


