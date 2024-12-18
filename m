Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9066E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 22:16:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.117186.1734560182822978073
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 14:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Hsev6Jsg;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1734560170;x=1735769770;bh=85fnrtNWfJbErigOqEB7d/XzefjHQ+Un4GFtner
	/Dp0=;b=Hsev6Jsgr6ocjIVaHHKaruGIXjZoq3BtZpI3tx1BtykXOqZTHX9YpppJ/Plgo8Riqb7Rb
	Awmebot2yUib9IEhkc/Vd1/L8kgBhriAGhQ4hVFtA0Vv1WLeJU0Er883GjCpJ0UQmFDzK5SIfp1+b
	lLQFMHXMihmrCw1xRn+F227lZysJR0nFogDRp875XIusqt4B7+iUO4uINd48IxiJ5+FgJU0LdWf2t
	0Z9WLWbY3LSaMoyX0Mxdbl6wBQ5rP2LyaG3fycJvwXtgkoEJWLYEH42dQusvzRy1khLMeaaOB7HxB
	esbm4B2HkwU9soM1T2HCd2h7xd9bsJV/khMQZE9Knw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BIMGAL42756838; Thu, 19 Dec 2024 07:16:10 +0900
X-Iguazu-Qid: 2rWhg4sxzD0ulIqObE
X-Iguazu-QSIG: v=2; s=0; t=1734560170; q=2rWhg4sxzD0ulIqObE; m=uJQUqROJWDP+sB6oBTGTROLdQMPx7WWc6FwyB4O0PcQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4BIMG8RU758773
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:16:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYejmx5VAtdjbcufarpG8nE5Wf2A6mWQdqDdFC1xcL03kO9Y2nRRicqdk9+3Tp+GAsi0mhSphK0S3eKeZhKbaoKewvvOFmPq48D1sjTjHUAUAuCO25rXHMz9SBbpB86cKnINLQwKNcBnga1Qgt/kquaK46kBifzrqoGU7Rz/fVDwn6ClMMbHryTCsAuf5uSQ04Qv68PyfcGLEEYm+X4yQ8MLEK/kH7qtKC5TVYURltRcQh5Psv3RSeyU5yVoLgmIA7ZgnOZlizDa+RZUYCeNRNdTYkmvTpiq6lKdxbd6euTYxierx9FtRbMlNHe7xtd5qSxhhV/AmIlBj7OWwfIQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb62TuYm7ovVLhv+KuGPfGVcqd2Kc6IMLwo84RvQCa4=;
 b=t4JZr/3GuZ97Np1rVTKQNLDfPP4WXBwXrGJAoqUJereOoFIz6agqgHS74fpZQq1HtIQ0QAby/LzRXf9M9Tws7hK4CUhfZUDNBTX9dsTw/S2CEdpjKid/AnTUI1b0D2kbiRBRWBLJgCbMGVfrRvurD2LmuiZ2vI5gWaCEEU7AM14TH1HOxZjr/lQcBgBSQbGoeJgU5otIYvYigNAGtx18VGDELzUY9msWPTORzSdgeEVR6o+ne9TxFdL1VCfsHMjnrmXYy9fjV7TQu/LWOzMCCKkv66e2W5M6BYrlw9Fysffkz5UgyUAt/7bDtZTMTbG+9TECv2oEXKxAuPPIGfqdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV
 clk
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Thread-Index: AQHbS/isN1RpgMbtP0GwjyqLJDZ/ubLr2iTwgABXpYCAAGn7wA==
Date: Wed, 18 Dec 2024 22:16:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638877D188928DFFA6D68C6792052@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <181032168C715C4E.8579@lists.cip-project.org>
 <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
In-Reply-To: <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8403:EE_
x-ms-office365-filtering-correlation-id: c78c973f-9627-4934-9b04-08dd1fb19159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NzRMWjR0RWxqWUNHNEdBMUg1d2lOanVlSzA0K3FzR2prSmJJRHl1SFps?=
 =?iso-2022-jp?B?RmZMWExVK1ZlVmE5M05NQWFlTDZyRDBnK0lKdThWcXFmbURUV2kyZ3Bl?=
 =?iso-2022-jp?B?bDkvQWtHMkNqZjdYVjRtcW9nT1p5U3kxaEYzSWRFOThVSElFVmgraHha?=
 =?iso-2022-jp?B?Um1zOFVDRGhkVDVlVjNabnE4MFA1M3p4cmt5cFFEYjA4cFFyYlJvSnVo?=
 =?iso-2022-jp?B?cEJxSVhIbHgyaG5TUXBJWjlDL0tJVWRBaDh3MEZYTHBBVW1vamc5NmEv?=
 =?iso-2022-jp?B?N1gwVEUrVmNPYkRhZGtwYWZDQ0xMVzBiYUNyYlhZUDd3MFdhR2xRcFdF?=
 =?iso-2022-jp?B?dTZyeFd6RkhJZEVSLzdXdkpRT0xFaS9nRjkrMnRpdE9ZK3hmMlVmc1dZ?=
 =?iso-2022-jp?B?VkxrZlJDQ2xzdk11eDUwajRlSGRGN1F3Vk8rZ0NUbnlHbnpIbWEvZXNJ?=
 =?iso-2022-jp?B?cGFyZ2ZXN3lqdVBTNTVaWTRSdG9hc2xEMkdvaDNtYlRmWFp3bW54V2l6?=
 =?iso-2022-jp?B?WDlQVE1SMDljZWdaWDJpcEh0Ung5U0JDa3RRYndLZWk0NzBHK2kvSk8y?=
 =?iso-2022-jp?B?VFQvZTJXQTNWMHd5S0d0UU8zZ1BqZjBKWENpOFk4V0oycWVWTmtmYVNm?=
 =?iso-2022-jp?B?Yit3QkxveVNQSnc3dE93aEx4MUQzV0x2aUY0V3dCblZkR1JOYmsyY2Na?=
 =?iso-2022-jp?B?NHZ5dWwxV1hqQzVKT0lrQ3RSQU8zYVp6aGtXRzJlTUpIM2Y3K2pEdCt4?=
 =?iso-2022-jp?B?NGFjZXNSK2xhdlJUV2VFMTFsdnN6Z0wzOXFERGNobTBaRlBKWWlKWDN6?=
 =?iso-2022-jp?B?eUQ1ZTM1OFJZUk9DTXh5dW4zWlo1K2ljeFhKQ01UanY3ZDgxWjVWT3p4?=
 =?iso-2022-jp?B?U3hvMERSTW14YkQvSHJmMWFGTWNUNCtWeVFLdlVpQWYwVWMxeWpXWXZv?=
 =?iso-2022-jp?B?Z3hLNHJtUmp5SWZXb0pIMXUwcXVpN0t3WVlQLzZCSG9RMENJdjBOcmhT?=
 =?iso-2022-jp?B?Y0RjRjk1NzlvZWxLYkdDZUN4b21oWlJiLzBVVEhyZ21jWDFxOUowajF3?=
 =?iso-2022-jp?B?ZVJwR3RLbVZaYVVoakdiMjMrb1lEbGl2UWoxSmdoYld3bUQ2UHRCSWIz?=
 =?iso-2022-jp?B?Vnk5RVdxWXZzK3cvS0lrUmdzR3pFaGVMSUxYNnA3K1BnNU9WemNjQWV0?=
 =?iso-2022-jp?B?YWl0QmNTeGRteDBLNnUvUU1oRThBbVl3dFAwQkNkU0hjallDUmlrcllI?=
 =?iso-2022-jp?B?emhXWjIrdGtSYTFYTFpxWjNEZlJtQmVmYzZ0UEtienppaEgxdWFOc3p1?=
 =?iso-2022-jp?B?akc3bVhtSWkzcytOc3o0Mmp6WGd3S0ZobzhELytjSWVnR3RnR1RsUEV5?=
 =?iso-2022-jp?B?UlJjSzdFV3duU0RqS0hrU2RKZDh3dVgwSDE5eHlwVlE0TFc3Y29zNzFT?=
 =?iso-2022-jp?B?NlRuUThmcHZMZ09kbGNOcE1rTnZ2Rk44eVhQQ3BLQ1NvVVA5Vm91WGJy?=
 =?iso-2022-jp?B?dnJhSmFjamViVjFORnQwT1g2b0JkZ3pBUlloWWF0VmprV3Vjdi9Za3VV?=
 =?iso-2022-jp?B?UjdydmV4TDdxMHFhZkd1dE1kc2hCRml3TUc2c3BTMWw4MFBadHp5bVJk?=
 =?iso-2022-jp?B?d1VRL2N4cEZyT1cxb3Fab3hXZjRrSEpaM2FzVndFeVkwU1ZKQmQvS1da?=
 =?iso-2022-jp?B?bEI3bDhnZ1VNZlh3TEVmOSs3UXFmWXVMcDJERWVaTXZBWW1obEhYajNa?=
 =?iso-2022-jp?B?aTRkSkREdzBJbHQzM3BCcjZKR3pDZDFnVU9kZWFoR0kwTGFsWm5zR09K?=
 =?iso-2022-jp?B?VldIeUpESzlNTGUwTjRPT0tpY0hTRlJQa3RzVUs5R0JjZlpyWXpxMDNL?=
 =?iso-2022-jp?B?MCtWbktFZmtIWFFHeExBQWc3cER2WkFGUW50a0VBMDJFaHlQUUg4K2pn?=
 =?iso-2022-jp?B?QVVNRk1SczJhTS9FdHNPNmp5a1p4MDl5dktYWG9DODJCWFJBRyt2VmNO?=
 =?iso-2022-jp?B?VHVvOEpOT1VDaWc5YS9Jbks5dTRFOHpjOUxEc3JRcmU1d3NVczhJLyt2?=
 =?iso-2022-jp?B?QTFBMkxHSVFTaEdPY0VNRW8vTGxibkE9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L0JzZXMzTDZ3dDVtU1NhVzd3OHlSVmU5dS93WDNQeDN4QitOTE9VVGVD?=
 =?iso-2022-jp?B?dHp3c1g2Z0lLaWlOUDFUMXNmclFDRW1TQ1NaUE5Ua0xWV1p1K3Y0OCsx?=
 =?iso-2022-jp?B?cTVPa0ZMRGlUcmxTTmRCa1paWktuZ3FHa3ZLN1E2aG50Nlh0ckR1bkJF?=
 =?iso-2022-jp?B?TWkrcy9vOUV6Mm5yUTU3d2lKeDMwMzFlTGpidHZaWm5IVStUZFp6bVhz?=
 =?iso-2022-jp?B?TGlZa3ZMcWNScGxHM2grb2dxcXE5QXk0bVZtWWsycFBBUi9rMldEZ1lO?=
 =?iso-2022-jp?B?d09YYVU3MFVRUlIyNEo3UlIya3paZHpWTGdXRXpFb1cxRUR6ZWdvaG5N?=
 =?iso-2022-jp?B?UXFHN0lhTDc3NHRMWjZidEp2SlRrNmFJbEJIb3RFNkJmbStuaDNuNUdD?=
 =?iso-2022-jp?B?RElQdWxsRWJ1a1NnSUZ6dEJhYmFCbUhzb0dUbzM0OUJHNE42UFAyMFFT?=
 =?iso-2022-jp?B?eHVTLzdIeE9LRyt4bXVDRDZpRDl3M09oZFViOU1tMmlTeDYwZTQwNytk?=
 =?iso-2022-jp?B?Zi9XSjZ3d1JQRE1vUGVyTVluMlNlNEpKMUU4NWxweGVweEx5WXB2Y0JB?=
 =?iso-2022-jp?B?Sm1od1JYQi9xeDcrR0FXZDB1dnMwSURoMmZFQzNkUTdUSERCQk9DZFk4?=
 =?iso-2022-jp?B?TGVDV284OG41VXcwZEZuT1l6dmRxcU0yMWpCOU00bzVEOFh2dmxENU1x?=
 =?iso-2022-jp?B?TEVDSm5kS2RFTC9iaUNtdHM0SnZRdzNvRU1tajFHQTJwYWhCdTdoV2Fv?=
 =?iso-2022-jp?B?V2c4M29hODhCRjhqbWJSOThkYnMrQTd5cVlVc1hsa042TWRBTWxTZ1Fs?=
 =?iso-2022-jp?B?Uk43a1dUdXpPWEFSQnMxT1RHWURuUFBSNkk1L2RHTWJDemdjQ1ZsQWxx?=
 =?iso-2022-jp?B?VGptaFlkYTk3U0VPYno3anZPK1k0RkxXNjh1cnJhajRaZUYwWUpjdnJt?=
 =?iso-2022-jp?B?M05MdFRXc09SS3ppQzZoMlk1ZTNKTlcxYVlLcEc2NjFJbGxwVmtDZkM0?=
 =?iso-2022-jp?B?Njc5U3kvNVB2RmoxRzZ1ZmJ3UngyNzh2bkljdExOL0ZlMG96VnNVcitZ?=
 =?iso-2022-jp?B?a1BTdGVzZjBuUzMvTG83dloydE5PQit6V2VDVjJOVkdZN1puSEl1eksw?=
 =?iso-2022-jp?B?dDVqbUVCdjROb1ZZdVUvakVtQW16TnV2RStJRzk3OGRTLzdEWVJOL3NR?=
 =?iso-2022-jp?B?WkZoZFlkWDFRSjMrdXR2aEovNFRqdVE3MXJWYy9lVkdPblRZMFB5N1R6?=
 =?iso-2022-jp?B?bnduTUZoMHBMS2Q4SkE5YjV0ODJScGlDRUtoanJqYlljMFZhcHdvd0hk?=
 =?iso-2022-jp?B?bnM0WEh6ZWMzaWJDbVpLMmpVUHNRV25wTVkxT3JJS0ZZOGR5ejg0N2NL?=
 =?iso-2022-jp?B?UXl3d0xydXhucmM0Y2wyOFFjeFc3WEc0b3JxWEZibHhCYlhCeDY0UEUx?=
 =?iso-2022-jp?B?K1g1UUlNc0cvWkhGZVcwVzdqQ1VzN0xId0N5cEFjT3paL3VGOVlPWnRQ?=
 =?iso-2022-jp?B?cExIenlPMG9ONHROYUptVC9lSFVKaTZ3K094OWFRY1hRWVczbGRkMGJ4?=
 =?iso-2022-jp?B?UWhlM2NyQXorR21CdWNrOFJxQ0RUZDBzOHhVVG5OVmFUa29ialZjYW9I?=
 =?iso-2022-jp?B?LytRVmRBNWs1WjRreUpVeU9pUm85TFRqb2g3L1RzRHBoV1ZRN2tONHRo?=
 =?iso-2022-jp?B?Q1dzSXVoYlc1Wmdwd0hXNUZVVERSZDhyOHFlK0JrblB2b1hpbFp4ajdx?=
 =?iso-2022-jp?B?eVBuRkNhYk5RU2k1R1J1dVpGTEV6aFgreGFNZW1SRlpoTWErcDVxWkpv?=
 =?iso-2022-jp?B?bmJGSmVvWGg2TEtlUW9lbGVQRW9pNjZ1OWVRQ0dyM0p6dnN2cjZPRUN6?=
 =?iso-2022-jp?B?dGFkUDBpWHNMOFlxaUdsdWg1Wkd3SFlpeXFPV05pTXllb2tGQndSaWxz?=
 =?iso-2022-jp?B?OE1YUTBwRG02K003SENqMzJSWU9Gc0ZuRjF3aWcvS0xBV1picjZUYnRI?=
 =?iso-2022-jp?B?UnUrSlJxM2tYV0Zjc0NFVDU1eVFxaExHa1dhM2szeGlrYmpGRWUwSWlu?=
 =?iso-2022-jp?B?N3ErSE1BcHhEZjRRUFFTV0VmUnRjenVwRjUvM0NDUzJLU1gwOUppcFNu?=
 =?iso-2022-jp?B?a0tVdi8xZ3BqalNmd3oyaWZnVE94UEFCVEliZGVscFRyZlo4c3Rkc29z?=
 =?iso-2022-jp?B?VEhZN1VHSS9TaHdyTGp5T20xU0JqL0k1WDlrNG5QdXZZQjNwb3paNWhE?=
 =?iso-2022-jp?B?UUtLcDBTNXZMZkFTNXJ4NFJuMEN6cEhjU3pQa3ZmZTU1UDEvQ2l1alhQ?=
 =?iso-2022-jp?B?T1BkeStNeUg2b21KWmpYcGFCRE1oT2tNeXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78c973f-9627-4934-9b04-08dd1fb19159
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 22:16:06.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55Wtr7v1Zy8Qc43iXEnaOrhLK8+JY23TL4B4R/Of5Di4+J28J1NJYuuPtCvJx/UitLsk/JmvW5M/iocGc9nfehLYUedR3wMAyzOrdA9cEcIpFmahzCr+/xRAeea9ehos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 22:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17469

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, December 19, 2024 12:53 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
> FOUTPOSTDIV clk
>=20
> Hi!
>=20
> > > While computing foutpostdiv_rate, the value of params->pl5_fracin is
> > > discarded, which results in the wrong refresh rate. Fix the formula
> > > for computing foutpostdiv_rate.
> > >
> > > Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk
> > > support")
> > > Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Link: https://lore.kernel.org/20241024134236.315289-1-
> > > biju.das.jz@bp.renesas.com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/clk/renesas/rzg2l-cpg.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > Gentle ping for review.
>=20
> Again, sorry for the delay. Should we have similar patch for 6.1? I can't=
 seem to
> find that in my mailbox...
>=20

I could not find it either from mailbox and patchwork.
Perhaps a patch for 6.1.y-cip has not been posted.

Prabhakar, If we need this patch to 6.1.y-cip, could you send it ?

Best regards,
  Nobuhiro


