Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F79CCF9E9
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 09:13:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.2731.1761729221022865817
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 02:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=o3eAl8TC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1761729197;x=1762938797;bh=3nXV8J4zVPBoIvSCYMFXYevAA09a0rOe8z9LX
	XvZZ6U=;b=o3eAl8TC1UPEA10IhYaHG2E0D6NQyRRj33zVUR5UU2iBxqpczeXhd0qSTl0OHMvjYY/
	b8YGcDLLqVmlbZz2Tx8mIL3uDozjx+b7XJ47A9Zb+xwhQ39JM0ZNxila9M6Kk8ixxpo9H045tHrKM
	cPrNGQbFPLP89YaHrOZw0c4rTf46QkmIoMOr6QO5aO+5XgZBifbptsyRmZoe/Ry2qFooiu0WSbEna
	QIOeR7yhPHY2qtzHx6B2wS6aAFqiBTyUoBA2Vae+uDy/1xgozYPt+j117s7iKop2sNoxybdxKpVeo
	72HR30ivldbQM/5bcDMwKUEYEAe6b0szJpLaGhWnwW7g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 59T9DHOR2360852; Wed, 29 Oct 2025 18:13:17 +0900
X-Iguazu-Qid: 2rWhKtyZUYm9G9Zci9
X-Iguazu-QSIG: v=2; s=0; t=1761729197; q=2rWhKtyZUYm9G9Zci9; m=K9WhNjBNNrJGPYVDptogx37dn3bApYGIJ/akVEbfi4A=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxM3c3NGGz4vyh; Wed, 29 Oct 2025 18:13:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRiOd/yIcWQFU28dQjVL3S1+ftl1L1sNfrgwWVK55sGSBDy+9kF7rWK0zzy6/AKv1dKhdykkoOBWdtlRlChE5JCmisMbrr7P1qE8JYi/h630sOjTg/OB+azIj0dPardDfzcvnA0nQAXKYWeGKhWR8tfC9V4s4sNxiJlvbYD8sB/NPTM+w7tztdf7iA+DPWLjSNhuTDEEcxgFsF9UP9K2lvADLheYioVYgWY8TsB2WOsZR8kQ84vtglpynAeWSJiRIEdVyVLbJeSBgIGcMzChWCQKQVc2wW5+4fbKs4aqG4xxfMl8q2tjTS7eZuHKjEAbcHK5O3gkbKoaiMcVJQVYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ERRJrPsZ4rHd95492MmUicDL9LypoRBBvvnPV+cMhA=;
 b=MOBfFePdr+t7C8sTYTt4084+atRsRE9el2bsRAtR8oVIgSu69obGwtqKzOrsR/ElZqbB2o0acoFtlPuQCvjj1B3/VHK3buRPT0zgeu1okc9PBSVfgsB5J3tLIz/4BUeJvQbFYBtJso/Y9BhiXC+ntU5HCzyQCzxAHjGiVt3+baHhekdPdZ0qDO4vRmBCE2VoreexeaKAHRcAWDGWHaV3okPP3priTdo5j2CPx+jzC5gPRxBUcPeV4gq31/+b/pqTTJ3OWZdQRcmLsRgCwI3bcBlnd8ad8Nk9IvCW0Da8q0dapF6IKfSkGsn7drtilDHlNi6XpxDE76uslmoM6Dz6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>
Subject: RE: [ANNOUNCE] Release v4.4.302-cip102
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip102
Thread-Index: AQHcG+pbfwnyb+jhWEiR4LOnXQdTwLTZL07A
Date: Wed, 29 Oct 2025 09:13:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481806DFD83FC78B45EF2CC9CDFAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <2089869981.61985.1756804608743@webmail.strato.de>
In-Reply-To: <2089869981.61985.1756804608743@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8147:EE_
x-ms-office365-filtering-correlation-id: be26d964-ec33-4898-bcfd-08de16cb63a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?L21uUStIdkx4bmVhNkpDUXNyMk0rUlRYY0NIMTBIOEZmQmRPaFlJS2Zj?=
 =?iso-2022-jp?B?dU85M0tqRG56YXZ2UEloZTZjSlRYY1FpaHErd3orNUFieElxODYrcG9x?=
 =?iso-2022-jp?B?MzIyMk1oRmVrNCtYYXU0bm85c1ZjMzA0TXpZVTRuNXpGSldPYXZLc3dG?=
 =?iso-2022-jp?B?dVRrVHNFdUh3OGtSRS9tUllhKzFJV3lTK29KdUxvYUtjZTkwQ29OV0x0?=
 =?iso-2022-jp?B?a0UrZ3I4QmhLRUJTYVAzWFVITUU4TFhCRnVOMmR2YnR3bUt4c0ZsWHl1?=
 =?iso-2022-jp?B?SFlLOVVodU9oK1NsNWhpUEMvMTJGMnl6THFwSVI0N0NjbjQrL3FmbDZU?=
 =?iso-2022-jp?B?UTZHUHUrbkdzTXJLcG1aOWptYzBnTkZSYytUcmhsUXI5RE9pM1RYQTVN?=
 =?iso-2022-jp?B?TjFFc2F5TjJhTWV5VWVGdUM5a2ErR2xRaXg4VDNHVGlqUEVETzJvV25j?=
 =?iso-2022-jp?B?ZTdjMUY4aWNROGFmRDdtelRQNmQxamhHUjEyL0VEejRuNGlacjAzUkR1?=
 =?iso-2022-jp?B?UWJ4eTdydE16akVXNVpXY0J6a2ZVSGNZTzVGRno0YjU3d0lCcjBGMVZS?=
 =?iso-2022-jp?B?SWVmazQvLzlJLzQ2OFBoaU1qZmd4MXFLdjhYUWowLzV3SzFWc3VkRGZo?=
 =?iso-2022-jp?B?MjRaZmV5L0tXWFR2Q2VPQWVBQU9SY0FPVVRLMVJCOUY5eXNZUDk5OFVF?=
 =?iso-2022-jp?B?dlE2L1dVdW9vNE1Vd0o1TXAzdUJFNzhQbXg0czBmUHBPeWFSWUs4WUxI?=
 =?iso-2022-jp?B?K2Z2TTY2a2FGbmJMcE5PWTZxamJscE5hTjVXQUdSNkVxdU9KeTdTakRw?=
 =?iso-2022-jp?B?ZHhtZjg1aGRjTE1qdEJsY0NYMUJkbUg4Q01NSVVQWXUzOC9PRDE5Ukh5?=
 =?iso-2022-jp?B?a0h0M1dNODhjdURNV3NtVmZtV2hNZzR0bWthSmlZb21BSE1GUkFpMHc4?=
 =?iso-2022-jp?B?MEw1Q1FPY0xNTnhBSnRQN2VNZ2x2UXRkZWtFVk8xTHhlQjR2cnNKZlF1?=
 =?iso-2022-jp?B?YmNTUCtqSFI4R1ByY2N3OEpxRlhEMmdDR2dMbnR1MG5tUjEyT2xRN3o1?=
 =?iso-2022-jp?B?aWptODZPQWc4eUZ5bTh2LzQ2cXhBNVNYRXVsMndjVlM5c3BvZThhN0xq?=
 =?iso-2022-jp?B?M2c0alh3eTFpQjZQRTQ3Qm0rM2FnOUExT1pzaWJBYUQ2UjVHd2RRcDBD?=
 =?iso-2022-jp?B?K3FLbW9PK2hodi9ZN1M0NUhWb1BRR3h4dllSVS8rdUM5NDR3Yllad1Nr?=
 =?iso-2022-jp?B?a1ZoRzlwaWlTcU13eUxxWjd3d2JqVGdiNUd2K2Q0cjgwSFE0QWVLYUNE?=
 =?iso-2022-jp?B?WlZNL2VnQ0w0NXFHYi8yN01GbzNHbnB2blVqeWpsTTQ0SmI1VDA4U2w2?=
 =?iso-2022-jp?B?N2g3RjRtTHRKYlFTV21OM1VMUncvMnNMRHgvbXQ5dWdKaktvS2V4b2VV?=
 =?iso-2022-jp?B?ZVBXSnF1dkNqK0NRbnBCMEFORUhKa2psWlFPZ0RmQkpNL0twZTNYRFgv?=
 =?iso-2022-jp?B?czhCdTd1TlVZbFVBTnNpdURSU21aWEtFU3BmZmdUYnNYbzNXOGJaL3Jr?=
 =?iso-2022-jp?B?Y2xIQll5NVhQWEVwOW9Wakk1b3NHditIVE5EbmhrcU5EM2ZoTkxRUVpi?=
 =?iso-2022-jp?B?T050TkRBQzBNTm13WENpbU1KK2cwT0c4anRGVHl4Vm9DQmdlQzdxQncy?=
 =?iso-2022-jp?B?ZEwvYVFQR2F5REFuN3BSMVlDUTBjSGdZTFMva3d6azRVMHBtSTFlNlpC?=
 =?iso-2022-jp?B?TU94K2tpNlB4WGlCV3dUajN3NnBWc2pSZGlwN0h5MlBPY0dnSXR4NXY5?=
 =?iso-2022-jp?B?WWlVZ2RybTlHeVJyU2xDNzZza0hGZm1oVUNFYzNadUdYeGF0RndsUnor?=
 =?iso-2022-jp?B?c2k0NUdoaDZqeWQxZnNMOVRkK1FyOHp5eTdMTXR1Q3NrU1RaUGhSZjVw?=
 =?iso-2022-jp?B?TWdzSGxabWZpSzlER1pUMzZGQXhDRElEa1NnNVBIaUhLQm1hZzBpSk94?=
 =?iso-2022-jp?B?aTJWUm5jRmFGWll1RlF2bVErTDBRUnh2TlIwT042WHg1clBtSitTYis5?=
 =?iso-2022-jp?B?aC81a3A5R21tRjV4V3NMY0JVd1lJeTFIdGYydFlmQ1JMc293WEZoRmQr?=
 =?iso-2022-jp?B?aHFzNmNGSFU1RjJFcVRFUzB6ZFFTSGxzdTJLZjVXaVZRR2VKVXdwSFA0?=
 =?iso-2022-jp?B?eVhQbFZaYnZldTdXNjUvS3JZUkRzcVJ4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c1BqOEZnTE1xei9OQ3BKelFzalc2KzdDQkhYbHFuZWVKNzNLVlcyRUhR?=
 =?iso-2022-jp?B?RGs0TzB0Vmk2a01Qa3NuY1B6TmpGRndWNWZUTjU2dExPQUhQSHZpSHlN?=
 =?iso-2022-jp?B?RUMrRW1YZDFzSEJzV1FmOCt6ZW9KRnpYRHBTZkRDS2pRa1UyYkVLbzZx?=
 =?iso-2022-jp?B?RUJtQStiUVY5czdMYUVEYk9TalJzWjhmSjFyZTBkbUIyS2VVZ1BsMmVS?=
 =?iso-2022-jp?B?djdobXErTHkrYVd4bkc3MEI1STRENEZrL0Z0cUJOTUFlV2dLK25TNmlj?=
 =?iso-2022-jp?B?dHcrYmFveCtDQWovVTEvQld1SitueXMzK1ViRkRMcDQ0WHR4RVZQek1n?=
 =?iso-2022-jp?B?VU11N2JZTkhzTGM3NjVSZ2g1eVYySXhTbi9udmI1TXFocTZvSXpGb24v?=
 =?iso-2022-jp?B?eFBLa01lUHJsK0xsSHJST3BISFlnUXhjNXJ4T09hSTFLMjdhYjNycHd0?=
 =?iso-2022-jp?B?dnBYN3R5TFAwQUlFT3pxUXhYRVJHbFdGWDRtZmVqdEE4SEpOTUZRT2cz?=
 =?iso-2022-jp?B?VHN6Q1RXSDlsTXpqQm1PSlFadFZEaldhMzFxdEQ2a1BnMFBBZEc1MjVt?=
 =?iso-2022-jp?B?djBLNFRkb2VCWlEvTG4xWmtldm5pSE8ybENxR1lCTkRmSmRnM1FrRXhy?=
 =?iso-2022-jp?B?NFIycngvMzQ1UlREYVJmUm5mSHNqUzFCQUQ1bFJqdUhYeXVzNVE5Y2FM?=
 =?iso-2022-jp?B?QXd3anVMM2FqRy84MER1UGRqdXMxZDl6UENDUVMydytxaS9DYWhDMktu?=
 =?iso-2022-jp?B?NTZJQitidHV3aFdQVWRveHVVZlJxQ2g4a2RkUS8rSVVDMCtiR0prUncr?=
 =?iso-2022-jp?B?R3dzbGU3RVRFR2lMR1hxN3N3YzNvZHFjMFFIbVhhbGxFVjF1Q1hUcng1?=
 =?iso-2022-jp?B?VU43VHFjYlVpRi9HYjl6WkJOdmZqQ3ZBVUlmdVpld2pOd01hQ1kyOU9J?=
 =?iso-2022-jp?B?QmF6MkhiL0lVUVJFbGFFbWMwUDc1ZDgwRkN0T01UbUdiamh1Z1luMXN3?=
 =?iso-2022-jp?B?Smdlem9uMzdPS1NyMElnRDRUdExmNk9GWGFKREloY0Jzcm5iRTJQaWdQ?=
 =?iso-2022-jp?B?WEg5bGF1L2hUTVpHYXJuczM1TDg1NlkwMmRrRmVZVUg0dHd4dTJ6NWsz?=
 =?iso-2022-jp?B?QlYzWG9NQlY4YzhSUk9kanVkTlhrQWhkaTU5eEkzRStML21HUHJURUhY?=
 =?iso-2022-jp?B?Y3FQQ21TU0drUVJLTXpCaEZaeUY5bXJMVm5WWDlwaVVIYzNqMFlyb3Fl?=
 =?iso-2022-jp?B?c1dydFBFM1Vmd2tHN3JVMXJGa0NTSW11Ny9jWWhLbkFhcytVNGErR3Vu?=
 =?iso-2022-jp?B?RjkycExRMzE4dDF4M0NWUGp3MWdmWk80RFlKcXlRL3laUlA3M3JVWWxO?=
 =?iso-2022-jp?B?WHRQZEJLOUwrNUVFd3BYNWlnN0wzckpka1JYS0diUnhYQlJ6QzY3RWt5?=
 =?iso-2022-jp?B?Y1Ywc1R6cFYxMW93NUh3RFBlU0hPVTZpVzh4NFhLVFRGSGRSdHB3K2ow?=
 =?iso-2022-jp?B?cXRUT3pVN3JYSng2dzFGZDl4THBEM3R3RW4rZCtxWUtuRWY4RVZIaGt2?=
 =?iso-2022-jp?B?ZjJPMnhib0E5UEkzejBXUnBJYWh1TzBGcW9EZUp3WHJyRVpqN1Mvc1BJ?=
 =?iso-2022-jp?B?c3E3KytQdC8rdVk5UVAwbTQvejVpbjdaRWlEa2JlSGlRcStPY1hHb29Z?=
 =?iso-2022-jp?B?OXVjc21DU3F0d3FEbFI0bUpvcE9ZdzZJRktNVndwWVc4V3N2R2VkMXdT?=
 =?iso-2022-jp?B?UzJMT1Fpbml6ZnRYQXZ6QU1mdkF2QzZQbmNpSUZzSjFPTThTZEVYZFow?=
 =?iso-2022-jp?B?bHhqK2J5empKc3pnZmY1d1FicmEwZDRoWSt3Slp0d3htMVdvcFMvNUt2?=
 =?iso-2022-jp?B?S1VsTFQxK0FuUlo0K0t1TCsxMGppVHdPa0FqbktvVHhVQVBzSFRxZi9Z?=
 =?iso-2022-jp?B?UGlhQThzdnozOWozSGdkNFA2L2dBc2VTemh4QkFOdHRiZFkwaVp5L2pN?=
 =?iso-2022-jp?B?ejBFbStPN3U1OGp2a1U1Nldob0Y3SXR0WXkvOFhEL3F1Vy9XNmRHV1JP?=
 =?iso-2022-jp?B?T0g0MlNJVkxIdnpva2RMazlQd2FNVDV0NXdXbUZZQmxRVDdlN0E3LzJh?=
 =?iso-2022-jp?B?ZStONy9aVXdWU1FVMytOaWs1VUkzdVNkS3hjMUNDcU9Od3V2dElFQng2?=
 =?iso-2022-jp?B?NlNrQThTRVlONUhtYyt3c3dWcTZtL2ZhREk5QXpmRGxEbVVnOE1odGM3?=
 =?iso-2022-jp?B?OGFPRnZ3SWFGNFRnWE1KZGxJNTlYREpDcFl0UG9VZDJsZUlLMGMzR3JV?=
 =?iso-2022-jp?B?bDVRWEZEb2M4L3pYTlI5T1g2dTlSV3NlMGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be26d964-ec33-4898-bcfd-08de16cb63a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:13:13.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cN7OdspE9Yf5usJzsvV8+R+WdTJhkvFkW5rKCdgcoUDZjMDRRokW+9wbN3jFelC5oJEWhNvg0Q/LlEjHvmbWLk1rKgSvPFhx6XvllZdCvuNwD1whHrFdTxy9ydmI5rXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8147
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 09:13:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20270

Hi all,

I've noticed that this version has the following build errors.
Could you please revert each commit?

1. commit 5e40d64e57eb ("HSI: ssi_protocol: Fix use after free vulnerabilit=
y in ssi_protocol Driver Due to Race Condition")

```
drivers/hsi/clients/ssi_protocol.c: In function 'ssip_reset':
drivers/hsi/clients/ssi_protocol.c:413:30: error: 'struct ssi_protocol' has=
 no member named 'work'
  413 |         cancel_work_sync(&ssi->work);
      |                              ^~
make[3]: *** [scripts/Makefile.build:286: drivers/hsi/clients/ssi_protocol.=
o] Error 1
```

2. commit c547946f8c82 ("media: omap3isp: use sgtable-based scatterlist wra=
ppers")

```
drivers/media/platform/omap3isp/ispstat.c: In function 'isp_stat_buf_sync_f=
or_device':
drivers/media/platform/omap3isp/ispstat.c:164:9: error: implicit declaratio=
n of function 'dma_sync_sgtable_for_device'; did you mean 'dma_sync_single_=
for_device'? [-Werror=3Dimplicit-function-declaration]
  164 |         dma_sync_sgtable_for_device(stat->isp->dev, &buf->sgt, DMA_=
FROM_DEVICE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         dma_sync_single_for_device
```

3. commit 65e5abd22423 ("watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handli=
ng")

```
  CC [M]  drivers/watchdog/bcm2835_wdt.o
drivers/watchdog/bcm2835_wdt.c:119:10: error: 'struct watchdog_device' has =
no member named 'max_hw_heartbeat_ms'
  119 |         .max_hw_heartbeat_ms =3D  WDOG_TICKS_TO_MSECS(PM_WDOG_TIME_=
SET),
      |          ^~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:286: drivers/watchdog/bcm2835_wdt.o] E=
rror 1
make[1]: *** [scripts/Makefile.build:487: drivers/watchdog] Error 2
```

These are reproduced with 'make allmodconfig'.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Tuesday, September 2, 2025 6:17 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; jan.kiszka@siemens.com;
> masami.ichikawa@cybertrust.co.jp; chris.paterson2@renesas.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [ANNOUNCE] Release v4.4.302-cip102
>=20
> Hi,
>=20
> the CIP kernel team has released Linux kernel v4.4.302-cip102. The
> linux-4.4.y-cip tree's base version has been updated to v4.4-st67. The tr=
ees are
> up-to-date with kernel 4.19-st7.
>=20
> You can get this release via the git tree or as a tarball from
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/
>=20
>   v4.4.302-cip102:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.4.y-cip
>     commit hash:
>       1135330e0fe33041a44f5cd14819866b2aab7a08
>     Fixed CVEs:
>       CVE-2025-21917: usb: renesas_usbhs: Flush the notify_hotplug_work
>       CVE-2024-26644: btrfs: don't abort filesystem when attempting to
> snapshot deleted subvolume
>       CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
>       CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and
> vmci_ctx_unset_notify
>       CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent
> crashes
>       CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in
> atm_dev_deregister().
>       CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments ar=
e
> missing
>       CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map
> failure
>       CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properl=
y
> when initializing it
>       CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
>       CVE-2025-38445: md/raid1: Fix stack memory use after return in
> raid1_reshape
>       CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY
> wakeup
>       CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push=
().
>       CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmar=
pd().
>       CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
>       CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer derefere=
nce
> in zd_mac_tx_to_dev()
>       CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_c=
reate()
>       CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.
>=20
> Best regards,
> Ulrich Hecht


