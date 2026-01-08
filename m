Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83949D14893
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:41:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23468.1767840086670603228
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:41:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=mHmf8PQt;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767840075;x=1769049675;bh=bW3NLNglrHOIw5bL4AkcjAQ2YlQVfffE6HRqu
	ZDV0CY=;b=mHmf8PQtJXpknO0OAleaQLRLnVUpbJewrw2OiWe4q9M4Q/WtCVhL0L/WVFBnJ0meRpk
	4T+x2xp/0FRBMQhvjJSvxnB06msQy8pEl+XoCkvaeLoy7KMiGR7UDtKexEnmS3WAkdUOZod4McCOz
	MpsN8GkSBHn5N4/XTqkB6VUeIMjVsYFfX96Fj4ZfQE+uRWlqHSrOtq5V53X+FxR9EziZ280IljgGp
	qmjxuQldIZQlekfaQmsX6XakrveE+rsNgmvW9DsbBO24BMTzZ9JycmTV1OzroIaHfTZB8jNyZOmAv
	x35nZH3qSxeIdZoT+U1zrMyt4JdL/ZrP0MlwfhKfNhVw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6082fEoe2253199; Thu, 8 Jan 2026 11:41:14 +0900
X-Iguazu-Qid: 2yAby6tgrl3NsG1yq7
X-Iguazu-QSIG: v=2; s=0; t=1767840074; q=2yAby6tgrl3NsG1yq7; m=Ii6XfBtQLg2a8PxGmCmY58CYSEiGM1PkrRI0SHgvrO4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmq0V0bKnz1xnf; Thu,  8 Jan 2026 11:41:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O27pUh9P6ElDyeXIJ8F4vHGURkowkGxckpLpxXZ+S61CVSM40Pv40bFGnTEBG4DZ4ixHf8/qX08FELvzbxIR8tm0/TMSXfxP5whKuQ21EmYDro/Y5YFoiFrCOpNOvt7peGP1QxoCzBDrtFzvaP8MnmT4DYTzFLWtqIvz1u9D0w4xbCot1XzihQ3EFbmt/vJQA7IHXez+hshO5QJWpms12hfOig1UiBtCmMii/S4qKtO8z8MkHa4uLBb50RQ2cAA/Ckwej/adBP6wEEzg9k1YyUyo+PMmIaOSBB4rGfLUIxuV74d7tg8V9aap1s+OJHJm32ROteS1Aq4p1a60sGbnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC3tU32VSXbqUG39BLLdOyBwfDwJ76fYYLwuQclYzRM=;
 b=WhqVNU1vXJi+Mw9hiT5flKgVtmGnHrt3u+6cXd+cdZ0uhu+FycwZB+weuW2vcMsdZ9ETtpnvS0MRzcsnbFdaIFkHOv7Ej531O4WhTJXgBqbn6TnxEbU65/hNJdL80DOeHjnvDgypqDf9SoCt4tWmvYtWgQL2AQ7d11C1xZsIdKtBEwxxdtLKtX3PsuYZ1gXiStwpfvxV4JLqdbzSwIwj9ryXUDJee7qodjFYz0K1X3mSah3FLvgEDjLoIC5xLVkAKyrqS2LpgTIsOhXpH1IO5MyRiPGT2TDmgtPQiozxZ1BnzK67Fp98340FJVF+5KRLmaQM8vOYZsbxrCpVCrArdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Topic: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Index: AQHca6+901AOmKmFuk2g14dCjt2QIrUxovtAgAbEfsCAD03bMA==
Date: Thu, 8 Jan 2026 02:41:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481868337786F2899D114B02CD85A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818E30D0E0BED5C4B7E5D04CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TYWPR01MB9277158B5CFE55D2B24CF0F8D3BFA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9277158B5CFE55D2B24CF0F8D3BFA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9591:EE_
x-ms-office365-filtering-correlation-id: de75ba51-db71-4c22-6792-08de4e5f62c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?R2Z3bkhSd3h3T3VJMzlESmdWeVBBWUJpZWNBUTNUQks0aXVDc240TWtk?=
 =?iso-2022-jp?B?b0xaZXFwNDhXV3R0MWZGeFNDdThGVlpHNUNXSmxLL21QR09zVm5hR2ZL?=
 =?iso-2022-jp?B?cFBtN01yR2xNdWRlaWRvSTllWVRCUWpDRFdxVlZ2Q2RHNzN4emNFWmVp?=
 =?iso-2022-jp?B?RW9jUy9yazRuZnpjMUNFaHZXMkxlYmhqc1p4dGIwc3BUUjFlR0NrVmRt?=
 =?iso-2022-jp?B?ZnFJbXdBVG1kdmE0YUc0dDRjYmtWMEt0dGhZRGdTMmloYXhBRFJZSDkv?=
 =?iso-2022-jp?B?anhsZjlyb1o4dlphdVRkMmM3aXNabUFnQ2p3UTNGUU1kSDdzMFU1Rlds?=
 =?iso-2022-jp?B?MkhudWg0MVlHekFqcFVuMVFzaDJVMWNmV1pMYzdNaEw2cXhmWEZzN1FS?=
 =?iso-2022-jp?B?NHNBT3doTzloMURpMXo4RkZ4RTBWM3B6Zk1wbDZkU0JMN3pBaGloUldJ?=
 =?iso-2022-jp?B?UTEzaTFDcUFOSHhyWDUrZWhBcTIwOE40YllMeTMxN3ZmbGlVSWNjZ1VO?=
 =?iso-2022-jp?B?dWl4cExOUFNSdGFDUVIxekVkNGFJS2pBTDJWZ29UbkxEOWRWR2tLaDdD?=
 =?iso-2022-jp?B?V0g4QTdIN3A2RTAzU3FNWmovSU1SdXV6L2NIN3ZiUitidzZRUVgzR3ZU?=
 =?iso-2022-jp?B?R0xoUDhPbC9iaThQcHU1VTNlQUFrRmZDSEN4czdGcVhZQlF1OEJTYllI?=
 =?iso-2022-jp?B?WWs1dDBBVDU5ZTRiWG9FYTNZd3paU3N6N1JGUVpiLzRLQ2ZyeGJpZDNC?=
 =?iso-2022-jp?B?SEZPUU1xWkVkNmpZRDRMK3R3TlFpbm9mbVY2aU5KU1FObDZwMG5LNDVD?=
 =?iso-2022-jp?B?QXFmaDljbXY4TzA5WG5pOXRUUHRodGhkSGVaRWg3OUNRbUNzclc0R21k?=
 =?iso-2022-jp?B?N1NEZGsxSnllVFBFaEY1amllKzhncHVycTkxRWVwUm5EY25kVUtTaFZE?=
 =?iso-2022-jp?B?bVVUMU5Pcjk5UVBUTFFkUkdYclRLc3MvM1BtcDJYSFBwdysxSngrTlE5?=
 =?iso-2022-jp?B?S3JELytoUmdCdXRGRkdHNXpkSE5LeVpIV1pnc25MMWFSVGNQdDZJNmVo?=
 =?iso-2022-jp?B?bVpwUVZkNk96YUt2RURKUkJaeWxVZ1NQcGpGRHFvWGw3NzZrZGI0THNL?=
 =?iso-2022-jp?B?dHQ2MSt3T01XNFNES1doN1dxMkhKaWRoZlZ3cUFOeGlJMlFyUHZTbTZ2?=
 =?iso-2022-jp?B?UU54dDlXNFdZa0hnTnZVd1hTdTJOOHhTdmJyVlpBVW9EekJIY1FqM3dE?=
 =?iso-2022-jp?B?TTJRTTc0ZUtTSVN3V0lRUTl3K1ltZGJqcUtRWnFGaWYrVzFGNTllYkZH?=
 =?iso-2022-jp?B?NWI3djBGNzgzdEtIOHc3UGhyV25lbm10STJyY1FBeStyZzlMUkU0VjJJ?=
 =?iso-2022-jp?B?b3BrMTk3WHgrWnNNZmV6RXdwSFUxSkR0UzNKLzJZTWNXRFkvOTJZU2p6?=
 =?iso-2022-jp?B?Nll1Q2E1UG94Y2dWWlF2K1pmOCtIcGhOVXpnWUYyL0FhdE8vRVBWY25J?=
 =?iso-2022-jp?B?VjR3OHhtRDArdzgyblVOcHhkazR5TXVpN2xRZldyTndxdkoxWWtFZkJ6?=
 =?iso-2022-jp?B?TGtoVzdoaXlSOTJuVFFQZ1ErUWZJRW03dzhzbXRMQ0xoaFB5SWxTWmE5?=
 =?iso-2022-jp?B?bmRMVityU2dOcHJyTHFtY1lTQVdNTjBxMERaQmJ1VkdMeEVOazhrSFFr?=
 =?iso-2022-jp?B?TnhBRnRsclMyTTlCYmFkbGM0SFp4aDBwTWRSd1pvWWEwOENlWHp2amtC?=
 =?iso-2022-jp?B?RzRZN1FXZ2RXd1k5YzBYTmZYUWkveTIyZWxnQXhMcXVvRERTZUJTdUow?=
 =?iso-2022-jp?B?YzV1bURCOFhQamhJTHIyZXdnWFJNS3RpR2NPendBdWVUTmhUMHJaOWh0?=
 =?iso-2022-jp?B?enI2eWRscmYrVW9VTFQrZDRoWGc5a0d5QzJYbDVPS1NQZ2t5dVBmWTla?=
 =?iso-2022-jp?B?ZlNuMklpQ2FOVE1aeG1VamVyVFhqRXR6MEZvSWxDREtIUGhFQmc1Y2gz?=
 =?iso-2022-jp?B?NzZBUmhONkZZSXhWRmd3MWJiWExYemZKc0VHQTZRSHd5UndmSEd4SGZ2?=
 =?iso-2022-jp?B?ZEhYWVRRMVBIeG5WZU5JVng4cWN6NU5HeUl4bk85b2QwR0E3R21pSVZZ?=
 =?iso-2022-jp?B?eUc1YXhHekdVREpjS1FDd2NjeVFKeDYxODN0Z0o4RzhNY0Z1Y2RWaWg1?=
 =?iso-2022-jp?B?ZzRBR0JLQTlKTHM1ZlpSNGI1SE0yN3FQ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eU81MzN4dDFrZEV0QWFFdjVDb2NuSmxLeUMyUGsrRVZUaFhreVRVZndy?=
 =?iso-2022-jp?B?MzN5Yy9DMGF6VVVleXZUSzI4RWVmSkkvYnp1Z2dHMnZCN20yM1c5MS85?=
 =?iso-2022-jp?B?aFZvRG1tNVhrN0lmNzl4YlN2ZUxzVjIrOUIzbWdOY0x2dGRtZVVUL2J4?=
 =?iso-2022-jp?B?R0dJTnAyRWhyVmIyNDd3U1M5UGUxeVl0L0wxR01hazRyTTluYVV4T3ZG?=
 =?iso-2022-jp?B?Tyt1MjFRUlQ0RE8rMXRkbS9kNGVEczIwS0RzSGttWXh5aVNzbXZSYWtQ?=
 =?iso-2022-jp?B?dWhmVUJNTUVlZzMxQVJqYXpRSW9acTV4ZWFrZ0MxQXZiOUphSEROZ2Y2?=
 =?iso-2022-jp?B?akk3Mld2K2dzS0JSMmIrb2FiMksvejdCRitYa05VTjNXaW1wWlhRTVJ3?=
 =?iso-2022-jp?B?ZVpJZitmQzR2QTZpUXp4NThBZFY4L0praWZZYktxTmJ4b1FNMlNCNHdY?=
 =?iso-2022-jp?B?NGU0aEhSRkY2eXJMOVdEYVhhZktRSVVhL0hFcGN1YUhnalFPVmtILzF6?=
 =?iso-2022-jp?B?NGoxanFLeDNma090MmlWdEVaOUpNMHQxU3QwNWpIZllQZlQ1WmwrVHpo?=
 =?iso-2022-jp?B?YmQ3UUtRT1c3U3hvWnQzN2pmYXRHNWR0V3J2ZWxMcG44bzJJUC9LY083?=
 =?iso-2022-jp?B?ZkZ5NCtXRlMyaW13b25tM0M1YnY1SUZvV210bFhlZUhLSTlkVFI1YTZ3?=
 =?iso-2022-jp?B?azNQbjg0QWRWZ0RZOHpYQjBhNEIyVHRXcmkxR3FkMmllYnhVTERnc1B6?=
 =?iso-2022-jp?B?YkNGRlNGSGJzb2FpL2tvMnRWVU5lKzdoVm9VeUJLOW1KejByaDU5a2Zp?=
 =?iso-2022-jp?B?UzNDUk5YQzkxT1l4dWs4TVpMVklKQUREZ09KYlVGNnJzV01odUk0UEgr?=
 =?iso-2022-jp?B?M0F4SDQxOVBPR1FaZGxZUmpSVzhmZ0kvRnI1bFRnc0dnNTl2UUVYeHNU?=
 =?iso-2022-jp?B?UXlicDhscC9jRnlRZUZqSGx6a0d5ekhmUkVlRktJNUgzeTBmaVpoZlJR?=
 =?iso-2022-jp?B?NzNiNVAwUjhGYmlaUHlsNkVOQ2x3S2hQTWFwUFkyNXYvT2VEM09acExn?=
 =?iso-2022-jp?B?dm1BUW5CRVU2MUNGbU5pV01WU25jUituQWZYKzhqQlUyeFNvOXY0dU9m?=
 =?iso-2022-jp?B?NGVrUUpWb0NDQXlsNjVsZUFTdElNZVBMaHdLbndkMTJXdG9ORFVZSnJS?=
 =?iso-2022-jp?B?RENKaUdQMUJJV3c2NUE3eFljWGNndTF1amkvaTcvazFqYURtSVp4Y1Qv?=
 =?iso-2022-jp?B?VW56R0tJa0tSUGdMYitVRk5uWjNEakdZazNEMXNScWozaXJCRnBiT1Rl?=
 =?iso-2022-jp?B?RTR4ZUNZcGpWVEtrSVB6RXlnaHZvVkhPZVo2cnBBQlkyWEVTV0VtaGl3?=
 =?iso-2022-jp?B?dWprQzNkNDkwWWpUaFlyMHFBUm9wbVJ6VGh5VW8rK0JMNVo3bGY3M3dS?=
 =?iso-2022-jp?B?WFFGVTZBOUdyby9iYWpaWk05UVc3WTF3bWs3ZlduYmlzODNlRm9rdFRy?=
 =?iso-2022-jp?B?YWFkWmRYbEpXdjdER0dIbU5hQVFWWGhFRjdJZ0s4RTJadFREWGl2bW5y?=
 =?iso-2022-jp?B?ZEtESUo1bG9LcWJtM2V1SUNJTVArUDB5TGhJemRQakVnRFBldUpCd25J?=
 =?iso-2022-jp?B?WDlraWQvTXVhRWNERVRvWHVEWUpWOEhvZ3hVUlpwN1ZJWWFpQm5FOFpY?=
 =?iso-2022-jp?B?NGxLZHd6ZTUwajlpY3JHdTNtQmhmUHBTRFVyUm15ZEVFWGd1OW9tZUdW?=
 =?iso-2022-jp?B?THorSkFVV1ZIQy94Q0orRmt0OGJvQnEwbzNPcXFIdDdWQm56WHR3a0p2?=
 =?iso-2022-jp?B?ZFV2YnY2MS9CYTBvYU53YXJmcWN3dHQ5ak5TSUZpTEI2bGZlclJJajFl?=
 =?iso-2022-jp?B?M2htUFpXY0t4UXg5NHk3K1lIbkJ0a25TblZ2SElMY2ZJcEdDNjdzLzZ5?=
 =?iso-2022-jp?B?Q1dtQmk4Qm1qOVhqRWhaNkloKzlvdCsrN2tUdFFTRWk3WWVzMTEyalZM?=
 =?iso-2022-jp?B?dC9OQ0kvRDlZemV4dmFybHZEdXlrcmtudW0wU0lOcnVtMGZZSVZCWkpY?=
 =?iso-2022-jp?B?bWZTYW04MGhxbjVRVHdiaml5Y1ZORVhaREhVTlFVajFpWGk1KzFJaTNE?=
 =?iso-2022-jp?B?VHd4eDVuV3pzeTd5MEtUdE1Cdmd1NE5OVmEyelZyazZiQ0pwY0FkRXFw?=
 =?iso-2022-jp?B?ZW9lNjVKTjJ2RnIxaTdkWTZDYm1jSHBIdWs0eHJWZ2IzUFRaRkI1Y29G?=
 =?iso-2022-jp?B?SFlxTlRhMGdMVTFROGlnUkNmanAyTmNVZlU5cDhIK2s1R05BUW5HbUFp?=
 =?iso-2022-jp?B?bDczUGNSVFlMZFNET0N4VW5rRUVsSFpEVEoxbWZTcW4yWG16bmRETkc3?=
 =?iso-2022-jp?B?MzM2b3BSQnhVSmVYeEdRRUU0d0thOTc2SnVsUlhuZk4vMENFWElobnF2?=
 =?iso-2022-jp?B?MU1WY05odmJscTBIbEhURWJTVGt2QnR2Y2hDek5WenVRcEJmUGxwS1FV?=
 =?iso-2022-jp?B?cE9WNXJPWjFURkh6Wkw0Q0RUTkpBMmo3SC9rMWR6RHEvUnJtZjhkaFNl?=
 =?iso-2022-jp?B?d1hvQ2VNRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de75ba51-db71-4c22-6792-08de4e5f62c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:41:11.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8bPWnH3MNr/tk6Dtj+zY97jpJoEttT6AP0oxHoR57f+I++qp/hKy6JSkL5kvMAdgkdnrYX5gcqAqc3tPiH0lY6v34NgqgSuqhiFsAWnTziIewuQ7OKHHTvX8wVb7nnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21427

Hi Ovidiu,

Sorry for reply was too late.

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, December 29, 2025 5:52 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Subject: RE: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
>=20
> Hi Nobuhiro-San,
>=20
> > Hi Ovidiu,
> >
> > Could you rebase to HEAD of each branches (6.1.y-cip and 6.12.y-cip),
> > and resend ?
> > I can not apply to each HEAD.
> >
>=20
> Thanks for the heads up! It seems the WDT series were applied already to =
both
> 6.1-cip and 6.12-cip by Pavel, so no further action is needed.

It was my fault, thank you for letting me know.

>=20
> Thanks!
> Ovidiu
>=20
Best regards,
  Nobuhiro

> >
> > > -----Original Message-----
> > > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > > Sent: Saturday, December 13, 2025 6:39 AM
> > > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu
> > > nobuhiro(=1B$B4d>>=1B(B
> > =1B$B?.MN=1B(B
> > > =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> > > Subject: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
> > >
> > > Hi,
> > >
> > > This series adds watchdog timer support for the Renesas RZ/V2N SoC.
> > >
> > > Patches were cherry-picked from mainline kernel.
> > >
> > > Best regards,
> > > Ovidiu
> > >
> > > Lad Prabhakar (4):
> > >   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
> > >     support
> > >   clk: renesas: r9a09g056: Add clock and reset entries for WDT
> > >     controllers
> > >   arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
> > >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
> > >
> > >  .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
> > >  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40
> > > +++++++++++++++++++
> > >  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
> > >  drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
> > >  4 files changed, 67 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.51.0
> >



