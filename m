Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13ACF6C00
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 08:16:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1542.1767773758547314042
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 00:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=eNInpp94;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767773746;x=1768983346;bh=vbHsO/YAG7Xk/FwPpg6RopApHo6IwkUs9ZeBM
	Yf8/y0=;b=eNInpp946zbeCeNS9LSCqwdNKOcsqvn56V+1S02w49UvCWgd+Q2e+YR/8xL8kyVNblS
	yLsi5AX/Xpg1dOD03iS4IR7AmjK28qVe2PcpuRTWe78MgeCGyP86yjCZDqIfz5HcCIFybUmA9Jrwa
	HBowoCtynXp6xzOPerFZP34ifhQPCItxP4e2MusUrVnZD4Aj0XCYhHCw99dpYyC++xSsNGVcv/s1a
	SI4hDTWsSdZGFimMK5Qf6e5RQ88gh+lORh0HkffQOwe2bimoda61sttSU548a8XXvr5FzkzlXJ3e2
	FiciE80nBT3VKWeC+bub5TUl3kcR6c+4LmEWy8O5O2SA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6078FjWc2023382; Wed, 7 Jan 2026 17:15:45 +0900
X-Iguazu-Qid: 2rWhaDm0CQ63MR1eNk
X-Iguazu-QSIG: v=2; s=0; t=1767773745; q=2rWhaDm0CQ63MR1eNk; m=8PrvA5ktatt619msEcknQsCoAW4MgoZjgbr8xFdgUeo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmLSx1tZwz1xnj; Wed,  7 Jan 2026 17:15:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXlKj7SzLsV/xZm1yxmLhi706yjMB5Y7pn1eTIce5vnUjh6kRRBSYplR7Wkr2g7mzpRaeHhs/WvgeCbWFG0/ajwcReFwmUENIV/2AunNkxxE6dufnhWztrZZRSlShRoVv2INc8m+COo7Ic7tDTbw5fNbAPEI/DeakKCw4HAakQE2wYzlUgM96rnfngtTKc2xhNekPbsuNY2pIsVwwRVhmtiuabww6GQJq8LqAkY6gU34RUNDsLnnc7s4bAmQuczUCFxU7RwutwBZubjqfAn8iNv1oHCDN1TDWE/I/TFhrtAE0q0fHYniIMLSzopkJ0rfVUHn1sdl+Ekpq3t3YWlNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rg6NyOvPfR5YGSTN8TEjjSsZfnATkRzzFG3eblIF/k=;
 b=BgujsObyTXD/XH4AEn2jnjUKVDKP3uBo6IpUxqPfFCi37gfUfOxYJM8m1TdQ6wfIYWw+dLMq46ShVoc8CnGPnYP0BrDaJCHmJhXR6gqfSMHTNyQr1/4Ff2UYPNd93B/tqUv1Y0Gq0LCelkAqzbDmgRdylJ9hWZQepkoyxd1tC5ckVLOLhaXJIRxPY+G0/QFXzt2a38IWbjXEcqU0JZJ+TSmyix02WIwS3GTsJLD4ndgxKnG5UCDfedk6YtC0pU8tNPQOG3fM1gFOroxRLjtn4GFoP2WZx3qppQbm1SbQPYIsLt8wa09ZlkxIE6wkhke7gSkCaiPEpSmjXGHmG4KLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
 where one address is zero
Thread-Topic: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
 where one address is zero
Thread-Index: AQHccxkBwEWmW2YtGEStGoEfrZkWNLUxo2FQgBTRbtA=
Date: Wed, 7 Jan 2026 08:15:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DB3065F2F9E6A32080CBCD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251222075949.58472-1-ovidiu.panait.rb@renesas.com>
 <20251222075949.58472-2-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818C473B91740921A3069E3CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818C473B91740921A3069E3CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB16003:EE_
x-ms-office365-filtering-correlation-id: 163d5964-a647-4b24-44fa-08de4dc4f22f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dkRUZVhZRDJmQjQrcUxHOTVEVzVLdnBtTjEzOEU3dG4vRkFDNCttVjlw?=
 =?iso-2022-jp?B?SWs5Z2s5N293Ymk4My9uWG82aFNTdm1nWC84aXNhTVp1RE9jMS9YNWxn?=
 =?iso-2022-jp?B?RUhOQU9pNEZCb1pmalFuTnFjclRoZ0lBQWxNaGpEa1hmZERvSGxidXEr?=
 =?iso-2022-jp?B?ZmRBMFJ0WDlyWURPb2h4d2ltdjRGamFyOGh4NURmUy9EMnAxL0RSNmNN?=
 =?iso-2022-jp?B?VEtrYUlWNnBtN3lyR3laa2JwUENTa0hPN3FJcFRuSHEzZ2ZCRTh3WWQr?=
 =?iso-2022-jp?B?b0VFRVNzTVdXSkFLQmVaeU9Qd1NqQnJHRHdkMVRleXlycWZzakR5eDBo?=
 =?iso-2022-jp?B?b0owd1I4aXVmdE4zQjRsb0k1RlNlZE5palBubkJlUXg0VXpPRW1Jam5j?=
 =?iso-2022-jp?B?QVFkakJMazJvaDFXRGxuVjV5SnNQZDhKanFic2ZZdVFVWTlUNlZUYkpB?=
 =?iso-2022-jp?B?NVA1YWhVRmRNOXpDQUlRMFRiYUJUNHBwLzNHQkkyMDZSM1pHTjZjeGlM?=
 =?iso-2022-jp?B?eWR0eStFSy9lMS84L3prOWV5NzFqYm54cXNGQ0R3L0VFOGhpRitCNUpW?=
 =?iso-2022-jp?B?ajYzN0NTajBtcnZtUTkyZnRmWjZIUzM0cXRvV2N3VEhtSjg4NHlEUG5p?=
 =?iso-2022-jp?B?VFErN3o4SHpyWm8zWUxnTmRETlhibGVmR3RWaHc3dGxiaU50azl3UGE3?=
 =?iso-2022-jp?B?NEZ1ZWVSM0FLSldMZWFacGVzdUxaTjdXRHZzUjJScEg5TFd0Vnc3R1I3?=
 =?iso-2022-jp?B?dnhHeEpFMnl1bTFURjJOY0p2YnQzNk9uSEJGY2ZzK2VQcG9JN1lyZUlr?=
 =?iso-2022-jp?B?R0NRanB3Q3dUYnB0K0ZhUTdqcW1yaGZaZ3M3NGRmY0w2bS8yOEZ5RmJP?=
 =?iso-2022-jp?B?bXE2S3k4ckZVeXFnVFBHUnhGY0U4VlFRT2RMUDJ1R1g3Q3NTRDY4dWZV?=
 =?iso-2022-jp?B?c1FmYVpDS0UyYmNOQkRqNXdxZzV5SExjV3ptTmJWQ0w0Zm1JUTBZZ01x?=
 =?iso-2022-jp?B?dzcwWjUzNjN4dmVLU0xSZmxTcmY2ajNMTHN3dGRPRDg5a1pHSXdPNzdw?=
 =?iso-2022-jp?B?YnJVTHdvTWplZTJCQTVUcFhSY1BmdXVONWphTU1UT09jZlQ5UFFhcG1W?=
 =?iso-2022-jp?B?L3drRUlabWVyd0w1OXEvNGljaVJSQ2pDVW9VZisrbnI5N2hCM1plRHZF?=
 =?iso-2022-jp?B?bDhMeXdHa2t0TjBWY3NycEw3dUVuWUhteWdzVElSQUx1aHJEWnZtTkYw?=
 =?iso-2022-jp?B?U0JFd0NRNEwzVmt6SXpuMElBNndsZ1V6S3lGYUFDU0kvWThueHhUMk5E?=
 =?iso-2022-jp?B?aldJVVRRM3A2V3plZTJhMDJsYmhIZWg3L3l3UGY3bkcyOUNOMnpLWVhk?=
 =?iso-2022-jp?B?cytWSFQrTnF5S0xTMTZtMkxRWVNycUVVSFRJOU1UN1Y3RGJweFR6VW5M?=
 =?iso-2022-jp?B?WTRjQ3B6bEtzK1R4b0MyN1ZyaDN4WWxmWk05UkducXN0TjZsWVlnVVds?=
 =?iso-2022-jp?B?Q1ZNU3VOSEtrZ3lpZEhnZzRmNytRNzQ2andhNnpabFB5dTd6aEFyMzQ0?=
 =?iso-2022-jp?B?WkNGR05VRFZmZk01V2d4c0JwanBMcXJQNk5EVlR3b0NBYUlLallXOC94?=
 =?iso-2022-jp?B?SDlTY2ZERXJzQTZYM1lobnpUanFVNFRSU0pBSVRLSUtOMjRlUUhkVWRr?=
 =?iso-2022-jp?B?L3gwaVhKWDkzTVJKcGRNNEF6V20wRlkrdE5kbmtaSHVma2lXOVp4bDdK?=
 =?iso-2022-jp?B?NVZnY0VFeU5KN3crdC8rck5JazJDSm9DdW51T0tsZzBzUlI5aGdrdGlm?=
 =?iso-2022-jp?B?YURLRFk4U3RrRUNmbmg5c0EwdFNXUkQrN3JzS0pLWW1vbFFMOFUvWWFM?=
 =?iso-2022-jp?B?UFIwUCtoZ3ZPUDY1M2pKc1VndnN5VGxpQmVCRWdaTkZxZ0NQUFF6aVdk?=
 =?iso-2022-jp?B?MGdQeXVGMkxlM3NYZEU3dW55QW1XOHQzcVBuVEU3Y1YyM2tIT3BTekFh?=
 =?iso-2022-jp?B?ZW5adnljaGxieUhwYk9EU2RQVkxid3E2RHlmd09KcElQM0lxT2dYbGFq?=
 =?iso-2022-jp?B?Z0RvRUp1cjBQeWQrWkhDY0J5eFRLQWNrUVRldnhMWW85Y3doSEVkRHlS?=
 =?iso-2022-jp?B?Mmc5b2NWN25jWTVFME1wUlFNK1ZYZXhJYnAvS0ZUT0RlL3c4R3dMQ0s5?=
 =?iso-2022-jp?B?bTFpUll5RlpPUFRidkhyZVJ6SkN5S3NV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U2NZN2llTGJWSGcvMm9vWEcxNndEN2NML1A0YUdaSHRoQmFNYndrd2Jy?=
 =?iso-2022-jp?B?WkJyUk80UzgwZHdnTVFxQnM5KzFqRjlkbFk5Ky9uN3ZZeW5YWU9xMmZS?=
 =?iso-2022-jp?B?eEVnblJxTnZBWTkzN3BZUCsxU21qWktXSE9RaWdnSzB3WDI4K2NEZXRS?=
 =?iso-2022-jp?B?anlzQktnNW52M2wyK2xRbHJjMmFoa0RhYk4yUlhJbm1hamozSlY3dVVJ?=
 =?iso-2022-jp?B?cWg2TllEYjBSL3p2TkswR3pMd2Y1WjdkcDFkUWlES2d1Q0hBKzkwMTVo?=
 =?iso-2022-jp?B?VEFTM3VVVERQamFDTzRuUXQwZm01TTF4eUF5WXhXYUNjRkNwbGxDR0Nn?=
 =?iso-2022-jp?B?OGRGU0g5akJKeTdKNWplUzRPUlV1WEhWc0xlb0djY0s4d1ZBVWxFMzl4?=
 =?iso-2022-jp?B?TDNXbkRIOTJ4bktIeGRITEdqek1zNlZSTWI1WmIxZGdqZTRYRE9NMTJ2?=
 =?iso-2022-jp?B?aWZwQjhQSm9JQ1pSNEVsWEVhbTE2US9xd21HKzlYY2RZNnhhcXA4Ry9M?=
 =?iso-2022-jp?B?K242cUdCOFF4VVZIekdjWHFWMHgrcE52ZDJnNi90Q1JMSnNwVnJWT09I?=
 =?iso-2022-jp?B?NTlQZFJ0YnhoWjJIUU9HMGprY1FFcDhEZG9iQjVUZVc1QjE3amZsc1d4?=
 =?iso-2022-jp?B?b0dZVmZsTmkwNHdQQmdNTXRKV1QyTGZGM2xCdm9BNmZYMy9TOWNoT1Ar?=
 =?iso-2022-jp?B?N3l0MG1rSWRObUZicmp3Nk1RdWpRWHp4RVFNdldValdYajdycS9oMVBj?=
 =?iso-2022-jp?B?YklSVkZ6ZUxKZEozNG56d2hnd0dGY1hiQWxrUTBNTW5wcHJtSDRrYXlN?=
 =?iso-2022-jp?B?RmxZbnpTN0ZWb2NSV0llTVQ0M3hVM0xPOGVLQjNYY3VjYlJKdVdJUTcw?=
 =?iso-2022-jp?B?UmVmWUpqTHhNa3Z2TloxLzdxQlBDajFMK1JFbWtwa2NHQUEzV2VLRWM1?=
 =?iso-2022-jp?B?bjQ0NTBnUXoyQ1hwUWx2ZWZZMEcvWEd1QjU5TUVmSGNRZlc5VzlBcWM3?=
 =?iso-2022-jp?B?MUxOUkpXQzM3M0U5U3NRTnBrTzdDUWp5TVFyK3FNczdGYmRPZS9pdTRv?=
 =?iso-2022-jp?B?ZHJIcTFLdFpMR1pjeG5tUUFHcERwOGtiamNWcEZHU3VjbnBnWFAzS2tR?=
 =?iso-2022-jp?B?eVFZQmhzYktjbTZUeGk4VWJkRGFZQmhoT2dRTnFOQjIwSmFpRWxLQi9G?=
 =?iso-2022-jp?B?ZTVWcExLSCtvRlVCcXJvMjJQbC9tYjhTYVhYNEtNRWFybVpmL0k2U3Ur?=
 =?iso-2022-jp?B?ZFc5M0U2SE81ZnhOZzA1TUY4VG43eUVYZVZmZk9rNjdocFl4T3VGbUdD?=
 =?iso-2022-jp?B?TS94MkpHdWdWTEgzN0J1L0hrTVY0cG1FWUYrYk4zemZkUlRFNnVKdWlV?=
 =?iso-2022-jp?B?SFZodWU0bDhIKzZJQ1VOM3ArWnJGdWZFQzZYTjhzVk82Um1JalFLZk1V?=
 =?iso-2022-jp?B?bXFHQ1R1TERxeEVTQ1lmeHIzK2cxL1dnc09UK1Flbjh2UFBVbVZjQ0Zv?=
 =?iso-2022-jp?B?VCtSNjE0L1FDQ2xuVDNBVUVobk1ESVp3eTFhYkM0TTZrcXdMcU5HZ2No?=
 =?iso-2022-jp?B?d0VYSTU1T2Z2Ny9pbENhNWMvZEtxcjVzdGVYVklWc3JmcHh3bGNwRndv?=
 =?iso-2022-jp?B?Ykl3bE0rWk9ZS2svTDBpM21BWFNkLzFYOVNHWkVHQ2NPbEZ1SXRHK1dt?=
 =?iso-2022-jp?B?SXVxUFQvbko2cndKTjN5TWdwU1Vsa3hQb0MyaWN3YlNhd3lEZ20rdEpH?=
 =?iso-2022-jp?B?aWhpY0s3WWljVklJbUpWaFhaR0REV3cyUWk1bGVzYUphaDdmZU5tRzR1?=
 =?iso-2022-jp?B?c2FIbXR4b2h4dC96MWpHUHNURXEyT29WcXlTbWlFZ0piSVlMNFBDekJ1?=
 =?iso-2022-jp?B?dkZHWFE5cWxtQktoTnZhckZ3aUJxOHE1OC9NeWFsa0Y0MFJGVUdwZS82?=
 =?iso-2022-jp?B?am0wemRjZzdWQXp6RnZMMmUzSHNTTDFJUzlrV3ZJakk0UzlzMzNqVEJO?=
 =?iso-2022-jp?B?RXJiQUhRMDYzY1J5UTRaNjZFWWc2anVSY2lTQXlpelFXOWQvMWlEMytK?=
 =?iso-2022-jp?B?L2x1cmkvVzZQUVl1QVg2ZkFzSW5jYllYaDY5ZTJ4YUtUOUhnN0pyWW9i?=
 =?iso-2022-jp?B?TXJIbUgzeHo1MXBWSGRKaVE2a2NUVWFSVWNudXBGOXFnZU5QTmp5azNZ?=
 =?iso-2022-jp?B?eEFGSkpTUDA2MUZ4d25Qdm1YbjE3ZHNuQTVPaXpIMjFiOE04VGNWcjhI?=
 =?iso-2022-jp?B?MjF2Qkl4LzNvU1BKSzVGNVZIdEF2NEhVd1hmZnc4Skp4UFRNaTBDSWh6?=
 =?iso-2022-jp?B?Q2RnYlhPdWpSQUxLYkhCUGFoK3BNeWZpOStTZkZEWEd2OVMwU0xXYzNS?=
 =?iso-2022-jp?B?dkM4RTh5czNkTXl5VWVrQ1ZWVGMwdW9udG11UDJTOWRZUldXZE5Zdkk5?=
 =?iso-2022-jp?B?cDBoUUZ3cE54amtBQXUzZy9sTTM1YnBmS29icnNTM0JQeXNrdkFtcmx6?=
 =?iso-2022-jp?B?YlpqNi81eURIaFVDK1NnQzJxeC9NRTJQWlRYUEZUOEk4YllFVUdLN1l6?=
 =?iso-2022-jp?B?Yk9TanQxVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163d5964-a647-4b24-44fa-08de4dc4f22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 08:15:40.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFFD6ZM42K/CXbAhKSlKiWu8k2DL8I+CWDve8LFWcIbveUVy/wtUIMEJ6vdzzfwHpRCuaqN5c/vmUxZdugVWREYwM51G6SAweynvfJu+fLu6OwDwetH+S8JxX3s5lT1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16003
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 08:16:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21397

Hi,


> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Thursday, December 25, 2025 11:20 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>;
> cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: RE: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
> where one address is zero
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Monday, December 22, 2025 5:00 PM
> > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B=
$B4d>>=1B(B
> > =1B$B?.MN=1B(B
> > =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Subject: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs
> > where one address is zero
> >
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit 6e9c5c8ef2820d18492d07172ac52f23ea8a54d9 upstream.
> >
> > Configs like the ones coming from the MMC subsystem will have either
> > 'src' or 'dst' zeroed, resulting in an unknown bus width. This will
> > bail out on the RZ DMA driver because of the sanity check for a valid
> > bus width. Reorder the code, so that the check will only be applied whe=
n the
> corresponding address is non-zero.
> >
> > Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Link:
> > https://lore.kernel.org/r/20241007110200.43166-6-wsa+renesas@sang-engi
> > n
> > eering.com
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Applied, thanks.

Best regards,
  Nobuhiro

> > ---
> >  drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > 32850608d4c4..40bccd1746d5 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -625,22 +625,25 @@ static int rz_dmac_config(struct dma_chan *chan,
> >  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> >  	u32 val;
> >
> > -	channel->src_per_address =3D config->src_addr;
> >  	channel->dst_per_address =3D config->dst_addr;
> > -
> > -	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> > -	if (val =3D=3D CHCFG_DS_INVALID)
> > -		return -EINVAL;
> > -
> >  	channel->chcfg &=3D ~CHCFG_FILL_DDS_MASK;
> > -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> > +	if (channel->dst_per_address) {
> > +		val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> > +		if (val =3D=3D CHCFG_DS_INVALID)
> > +			return -EINVAL;
> >
> > -	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> > -	if (val =3D=3D CHCFG_DS_INVALID)
> > -		return -EINVAL;
> > +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK,
> > val);
> > +	}
> >
> > +	channel->src_per_address =3D config->src_addr;
> >  	channel->chcfg &=3D ~CHCFG_FILL_SDS_MASK;
> > -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> > +	if (channel->src_per_address) {
> > +		val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> > +		if (val =3D=3D CHCFG_DS_INVALID)
> > +			return -EINVAL;
> > +
> > +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK,
> > val);
> > +	}
> >
> >  	return 0;
> >  }
> > --
> > 2.51.0
>=20
> Loks good to me.
> I can apply this if testing is no issue and there are no other comments.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232140=
939
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Best regards,
>   Nobuhiro


