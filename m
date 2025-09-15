Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC99CAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 23:47:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7173.1757980073847805405
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Sep 2025 16:47:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=B0/ARFJx;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1757980049;x=1759189649;bh=WiP3tt309uzyIxfWmovrrpKpyUBnL7oONKU1A
	iiPVFA=;b=B0/ARFJxuUG6Ea4SqDITIvaq/oVWDwvipWzqyL921tNAREhyICOYUwA/WaPcei8SKsC
	6HVn2uW8fKVzwMpZZ1XuFQPf3wqiGm+db2AbaXBnRrcP9E/KNSj7x4VdjiMZRC5PBJRQV9nyKbmkT
	sCCdA4ItzML/+GLsVKdGZQ4SAWRfa6oRUBdNj+KmqgNKp+CoE4AjIU0u13N9jMOG31XNiFkVNPhfB
	3N+OuxO3U7dJyFSzIYQch/E8k+SU7YNyVjlhTIoEOOXPPncchlaaj8fZoIlsCzUmhBPB7gdbwL0/v
	beX3Bti6e0toy6y5EkvMiI4fHc7VLXbtgS1WQK+Lb5Kw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 58FNlTVN2976371; Tue, 16 Sep 2025 08:47:29 +0900
X-Iguazu-Qid: 2rWgc1lFgHM9JmKhfn
X-Iguazu-QSIG: v=2; s=0; t=1757980048; q=2rWgc1lFgHM9JmKhfn; m=M9mVOIjlRorTGpNu9oOje8xi9TpInea9+Qz0xls45rQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cQhXc0fgpz1xnc; Tue, 16 Sep 2025 08:47:28 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTLJ7FTtWkpBi3tdvdosaKbUsukUWo5DqJ+fuTI+TL0NVG9rKz/kcSYFnK8JHCuKtP9Q5uy9CidRyXsCWS9Di/BFKMV0lzoAzZEjYVj25bw48AO9ZE9rq0s0anKFW/dPit7IINbS7bqMwja5RiHF/oHRJina6zPSICjX8EJK1lVnDDjmN4bA0OT9u2Pgyu956oGyvK8btvPkizlreoST6LQ6bg4eC0BHwOeMn9p3dRnotxOuiEWdSsptSIGnSUkIbIhJgrQ/t0CtI6Yv6ZM0eK2shngVMYAfbRAUl5U5a4ykKY7vrEwdUkGqD3nNzFdjbocdruL/vX2Uawqw4zIcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwqXzJfBq4RTwzYhR8kLBdCec4wf55pcl0BFe8v0OCw=;
 b=ARHLeoKmyXIOTFRhUZJFsd2uGRFWsxY09IH6dpH7XhqRaTdkjJAtEInKb6vlEuR2JgqJhtLlHW3PahhOG1gOCQFsurvzWMPfAzQtyQGKLbQZVtkmj5qaOx8kieUhQxbSJ0JhOP60ayDgRKYu8tDDA0ic0U5/6iuc51D86WcpAeTh8B2Z5jcngEz4LScqP8CJGP8EQflX9fgpaQTHro8p9Lw3JkcKtFdDXQnXdbx5METFaHU29HoQntHJSQtkuqxY6iW5TrhtKLgzM2y5xzYW+8HHZ+MRKfZ+iRFTMDoF/nVKzP6iNWlBSiNQonaoLMX9+0A0VN0vJf6hWQF7kBGBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>, <uli@kernel.org>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEdpAOtOsp6RkJ0itXKZdfyV4dbRuCnQAgCU21bCAAdCp8A==
Date: Mon, 15 Sep 2025 23:47:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189622558F21F62EF509D6CD15A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818DA61316867E1E352884BCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019FA6A5FF05E33976274BCAA0AA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB7019FA6A5FF05E33976274BCAA0AA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB11719:EE_
x-ms-office365-filtering-correlation-id: 6128c927-4c05-497e-9fda-08ddf4b238f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UWcrWFJCSThqQWxQd1N1OC9RNUNwdjFQNWhzTnhZLzY0RUlSc09KcXVr?=
 =?iso-2022-jp?B?OVppcmtwQXVodEtJMW5vMGNpdHByTVo2cnVvdWEySys3TTFXV0dCOHZt?=
 =?iso-2022-jp?B?bEdNZUpra1NDUVNEUWpVL2RzYWFWVnRkY2RYWjJnWHRMa1pKMkFyMzBu?=
 =?iso-2022-jp?B?RnpHTmtsL0IrUWtwM1BOOFo3UVZ4SS9uTTA3b25QN056ZzlQM09US2pV?=
 =?iso-2022-jp?B?UkxpaDh5Q3BWVHRmOU52WHhOQmVVeklmNUt6N2dXTEZLTkp6L0Z2cjNN?=
 =?iso-2022-jp?B?T1dmRllwT25lR2VwNklxc2F2RzVkTER1RlV0eFNjSWRHMm1qM3laUnMw?=
 =?iso-2022-jp?B?T3REUDlSNWlnUlY3dUpHOGtpWFM5M3BYL1cxMDdReXY3WEhuZ1R1dWVs?=
 =?iso-2022-jp?B?TGlQYWtlTkRmUFVsUU16T09OVFhiMmovNUFkdkZROUJjQldwempDbjNh?=
 =?iso-2022-jp?B?eG9pOXpWLzdKeGRDditKQnRQeDFab3BWQlpaN0lVNUJObXh6UEdVRzF4?=
 =?iso-2022-jp?B?YUpaOXB5VmRKNVJNa0dTYTRFc1pyaUJsbmhESlJibEFXd1ZQeXpXYjFa?=
 =?iso-2022-jp?B?MlVTRjVkQlh1b1RFMXF5VFV6d1hpVGZwcCtzaG9iMDhkVC9PNVAyYWZs?=
 =?iso-2022-jp?B?WERHMHU5amZ2SUFSRW0vczJMRkNxeEwyRVl6YVhMelJGeTJ6ME1VTWZ4?=
 =?iso-2022-jp?B?M21RdWV1aHNFRUtpQ09DMVVmOTVWYStiWno2blJpampCSFRkYTJIc0ZY?=
 =?iso-2022-jp?B?TTlRcjVpSERROVB0eVFqTlFEbkNuaVVDUjR2eW9Fa2NYUGd4cXNlZFRu?=
 =?iso-2022-jp?B?ODFldmppU3FwSmV4Y3BKTUpiZ2ZRcE5lNXY4M2h3U3kyU29WanFxMjFk?=
 =?iso-2022-jp?B?TDNmUnZIeWkvYU9Kb2hYY25vQisrZFFlRWJuTlZ1eDRDWjVVY0cwc2c5?=
 =?iso-2022-jp?B?ZGRJNmJwQUxvQjJtVGp2TlF5ajV6cmE2TkNUcUI5WDVVWEdTcUhKajg5?=
 =?iso-2022-jp?B?QXRoQlg0cjdQL29VeitFenBQRGE3TDc4QWhSWVNaRUsya2R6NTloT1Fp?=
 =?iso-2022-jp?B?N2dSK0E1YkhJeWlmMWpJcC9MZ01PbzN2NXAyZ2wydkE3Rm01cnhRV0wy?=
 =?iso-2022-jp?B?cXJ5aXA0WHA1OCtua1J0emdEK0xKMDRIWnR2RDFsUTg0RFo1cWtLK0NZ?=
 =?iso-2022-jp?B?aG1nL2djTHY5UGYwaUYwTUo2NWozYVkyMlJOTkhERHJSVXZTVkxWWUJy?=
 =?iso-2022-jp?B?N1JSTzRRbEVaSGQrU1VObFNkTVdyVHhCQU5XRjUvdmpDZWRWVEdzSHFY?=
 =?iso-2022-jp?B?S3VIRFJJMktVcUE5cTBEb0htdmRTd0h6WVZZQ0FpRWJQYzVNNlJuRSsv?=
 =?iso-2022-jp?B?SnVNWnZzaEE3WmNORVF0cXZDMXV1WVNFVEE3ZGRjOTFRWHRybkZKUUJE?=
 =?iso-2022-jp?B?UmsyRGtsd2NOS1FIQSs4Q1EwWGhHQkJ2ZXo3Y0VIOEFPYWtmcmVmKzd4?=
 =?iso-2022-jp?B?Yk1BWXlvTmx3NSsxYU5BcjBydTlkbzBFY0YyTDNQWHF5S2tTcDFzVUhm?=
 =?iso-2022-jp?B?NjJCOE0wdm1IWHNXdUdDMzM0QmxYbkhvM1EybC9oekhiUnNwSkNXazdI?=
 =?iso-2022-jp?B?UmRvQXVEZHZjSTFod0haNllmcUxXZ055Y3ZnVVo1UlB4YUlHWkRDdHJ6?=
 =?iso-2022-jp?B?cHcwSWFjRXcxOTVYQVBKdDMwYmdlcW02TkE3b0tSallYUG1WNGpZZkky?=
 =?iso-2022-jp?B?enErWUtsVjlWUWVDZlJhOFF4Zng3eHltS0xMRVd5NXVoSFFIclFvbjRB?=
 =?iso-2022-jp?B?ekdlaDRseURZdXVoNUFUTnhUTWRrRmM2QWRxakc5N1lmMnRLVlNaangy?=
 =?iso-2022-jp?B?cFFrb0NLZmx2aHlRNnE4QXpYOEhPWmFQeVZIL2YzOTFadDl2MWtWWTd5?=
 =?iso-2022-jp?B?SEdUK2VqWEZNTXJjZ2xiZlpuRWt3NitJeTJQNXowa1BhR2VXTlJNNzAw?=
 =?iso-2022-jp?B?QUo0M0ZkbDJCd3VlclZZbTJ3R3FuZmNYNVo3N1lTUVlnMEFsYmdmK0x4?=
 =?iso-2022-jp?B?dS9iTjRYNUNMMVl6ZXBrRDF2cFYwZ1k9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OHFYYWZDZVg4d284QkE1TUtkQjQ1MHAzdUh6ZXYwTy81eklSUkVZcFZY?=
 =?iso-2022-jp?B?RGxFRG54aGtURHlBRThtRWRZWmNJcGR2THl4c2h0NFNHMXM3UTA2cC9j?=
 =?iso-2022-jp?B?bGpaRE9oOXQrYlVvaFc3WitPMFhud2VzNitGMlBsNFRDNlRvc0xXSVNj?=
 =?iso-2022-jp?B?d0RrTXpDWHQ0VEtVSjYrdVpTVk5sZU8yVVRNKzR1NHpnWElpamxLQkxt?=
 =?iso-2022-jp?B?VjhmUWxIRVEvM0pVaTlUeUp0eUdPUUF2TGRpTlJ2UlJzMXFidFM0bFBo?=
 =?iso-2022-jp?B?NU5ZZU9wYm5FbTRpekJZK0FjcU1XdjlublJ1WStrUFoxd2paakNkZTg0?=
 =?iso-2022-jp?B?SzlWNDRhU29VYnFrdllkejdiT3BteW1MRHdEYWE2WUcvS1FrREMzYkxu?=
 =?iso-2022-jp?B?RFBsVDFXdFBDYUpGM1hzK0pKZU9CcnBsSnhKdGJkc0RSZjRveDNieGM3?=
 =?iso-2022-jp?B?Nit0eEJaR1l1RlpwNStuWVhtVzA3anZTQlp0T0l0aWFacFNUenFKajdj?=
 =?iso-2022-jp?B?cnpka2pYdDczdGFDN0NBV0k2RHhuTnp0R2pUNk94R2RXYmVsMTVNb3gx?=
 =?iso-2022-jp?B?cDg4YldJOU80OHZrVnBLWWhKc05sVDNDS29MQzNVRVdia3hxUm5Jc0ZC?=
 =?iso-2022-jp?B?TnJoYkRtZnorTDk2RVRRNmtQdjI5bkIyTytiKytBdTdQcHNQUnVISE1v?=
 =?iso-2022-jp?B?SzVFN29uWjFZelpmOTltU3pZUkJuQ2JEaHhUTlJaUTVIVzQzMDBlOHgz?=
 =?iso-2022-jp?B?ZUFUcXRqWFRBM3hjc2xqMDRFOXdPS1Bic0JiODZvYVNESFdOclRrbE13?=
 =?iso-2022-jp?B?UjVSSFR3U2lFcWVZR3VHYlRiNTU5OXFVaGdoc05HcW5HcDBqNkltN2gr?=
 =?iso-2022-jp?B?R0lQWk1wOCt0akE4aERtRkZhNXVuQS9ad0dNbVVqT01rQjlYUmJYanEz?=
 =?iso-2022-jp?B?OWdPdFlsQTZydXYzUGRBK3hPcTdPcGMyUGJZQml0cVdxa3YxNURTNzE1?=
 =?iso-2022-jp?B?UzlUK0RnTUFwQTBVMFFIMDZvVHhJdlVQclYzMGs5eHFxMEpnUytEak1r?=
 =?iso-2022-jp?B?cXBPYzlGWVVjSkQ2QnIydzdtYm1VUkFjV0txM3poSjl4MTNGbWVFVkJX?=
 =?iso-2022-jp?B?THlYZWhuZndvcUI3UEk3ZHFidTNwWWRrMzBuUjZjeDB5bnFsQU5peVVF?=
 =?iso-2022-jp?B?NFNqdnN3VzFOM1pabklTOWpTK3M0T2JuOUFnQnhITUdBSjhhUk5HQlVo?=
 =?iso-2022-jp?B?Zy9jbWtUZldDLzl6TDErdDZHQXhxb1RqWUxia3JBRENRT1hiMmdabEZ2?=
 =?iso-2022-jp?B?U3lTZUkyS3U5eWlvRzl0QVRhSE8wMnZFa096QmMyN0N1QU0xaDZjZ0Nu?=
 =?iso-2022-jp?B?bzVRNkRwK3h3b0c3N0ZhRUV1NGYxckh3S1dKWlBISUN2U3JuMlB4aVh2?=
 =?iso-2022-jp?B?ejF1OENVOUc2cm9wK0VORmlSaWpOMHlOaWNNcmYwUmd2SUplMytKNHUv?=
 =?iso-2022-jp?B?N0U2MGM2NEozd1E0YnRKQzQwd05GTUJaaTFISUdpRWc2S2tvMlRRS0tY?=
 =?iso-2022-jp?B?S2FYUnppcHNnZzFNenozQjFkc0RKd1diK2Voa09zc0RCd3hrWlFwRHNx?=
 =?iso-2022-jp?B?L3F6M041cGREUE1TMWxGaW9pSStzajF5RjJZZGp2eHdmczRKSG1mZTg3?=
 =?iso-2022-jp?B?TFRSU2hLWDYxZEZYUy8rNlJ1Nk94VFNkeWZ4QWVhb1FhVFAvcFFQNERo?=
 =?iso-2022-jp?B?Y29VRU5Qa0FoVnczQVlXeHZFa1lnWUtUbDdCZ1JLZHZhalRZSjA0aHps?=
 =?iso-2022-jp?B?V0IxTUhrT0lkNEN0M2VyV3NyRjNPNmxyZ05HN3BzcHlnNW1GQmtBb2JI?=
 =?iso-2022-jp?B?aFo1dGREb0RBNW9aaVFUbjVOcGc1Zmx5VHVKeDFPTXZQc1ZCV3ArNDN0?=
 =?iso-2022-jp?B?ZHpTMU5EZTNBMlRVTld5U2oyMHFVNmZKcW9BZ1pkd2t3cmlMMDZSSmtK?=
 =?iso-2022-jp?B?VUorcWJpQ292ZWVDc1NndCtDSUl6REMyK0hvaTNmVGF6MndpNGYxZ3ZD?=
 =?iso-2022-jp?B?WFgxNk0yNHJrcXFETnBEWTVEYnBRN2ZzQ0VqOHc5Wkw5Zkd3QjBwL2Rp?=
 =?iso-2022-jp?B?K091aWlpWkZ4WXozQkhiOHFVcUVWVjNTNWdBc3hhOEswSjhmT1pEckM5?=
 =?iso-2022-jp?B?Q09tRlV2cTB6QU5DRGZjZm1KZ05kNnpmUyt2TndZeEJCbWxlQXNlU3FQ?=
 =?iso-2022-jp?B?U1BDNVNRayttcy9SbitZTFJCQzYyM1EzYm5va3hGaDdIOTdoTUJMdjFE?=
 =?iso-2022-jp?B?S0c4ai9WQ1NnMnF6TUpjNnJtTXJmN3dGM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6128c927-4c05-497e-9fda-08ddf4b238f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 23:47:25.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AERoqQf+DaDufZqzzKYpj5a0kQWnQLcTgkZjsYnUmDupXtTpfPamtNjWcRpLgTPh1OErSev+AeHeC1x7Rf7i2H2B7DbbRIGaObZsTE9P6qTaxyJRs8AQcUxDl/RRyfeF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11719
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Sep 2025 23:47:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20053

Hello,

This patch has been applied -rc.
  https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h=3Dlinux-4.19.y-st-rc&id=3Dac8dc358d156923de6193967988f0741aeda8995

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, September 15, 2025 5:04 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org;
> pavel@denx.de; uli@kernel.org
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
> Hi All,
>=20
> > Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> > notify_hotplug_work
> >
> >
> > Hi Lad Prabhakar,
> >
> > > -----Original Message-----
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Sent: Wednesday, August 20, 2025 10:56 PM
> > > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =
=1B$B?.MN=1B(B =1B$B""#D#I#T=1B(B
> =1B$B#C!{=1B(B
> > > =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > > <pavel@denx.de>; Ulrich Hecht <uli@kernel.org>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > > Subject: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> > > notify_hotplug_work
> > >
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
> > >
> > > When performing continuous unbind/bind operations on the USB drivers
> > > available on the Renesas RZ/G2L SoC, a kernel crash with the message
> > > "Unable to handle kernel NULL pointer dereference at virtual address"
> > > may occur. This issue points to the usbhsc_notify_hotplug() function.
> > >
> > > Flush the delayed work to avoid its execution when driver resources
> > > are unavailable.
> > >
> > > Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead
> > > of
> > > work_struct")
> > > Cc: stable <stable@kernel.org>
> > > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > Link:
> > > https://lore.kernel.org/r/20250225110248.870417-4-claudiu.beznea.uj@
> > > bp
> > > .re
> > > nesas.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > [PL: manually applied the changes]
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >
> Gentle ping, this patch has not been merged into 4.19-cip yet.
>=20
> Cheers,
> Prabhakar


