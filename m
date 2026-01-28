Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF6BD2FEE6
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 00:24:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2179.1769559878717248955
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 16:24:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=n8+s8Yer;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769559875;x=1770769475;bh=0uLxBu+4qVWrrS04Vd2ITeuWJurAsernZMYVt
	X5Wyvo=;b=n8+s8YerM7xghJkZVw1t00ClJOl9EnwmFxi+a4V4NIm0spQ2dE09n/yLg685U39dp2E
	R1eENM0t6r21gQe5BF+eh50c+ytlJzXIa5QBZ2R5dkb4rfKrnPAKRyBf49HQW5vPYxyjy1F15EQJ+
	JeHW9oGZK+6zu28FEfoodDPYen0rx1aF7Jkr2hWbL7PtP0MTXyKYCPREA4zxXY359Rfn24TG+QJRB
	y7xamksbpu4gUjDIc1AdLWZc/jS8z/GbmJythcLk8IhNAajU3iRSl1CjhD5hkj6VU7Ep/sNcUNvnl
	maSMCX6ANysCuaDSIas6JLwQtxKY9ZkpbI6Jj+Xz+27A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60S0OYet1722611; Wed, 28 Jan 2026 09:24:35 +0900
X-Iguazu-Qid: 2rWhaDm0CzEQ3T4SNp
X-Iguazu-QSIG: v=2; s=0; t=1769559874; q=2rWhaDm0CzEQ3T4SNp; m=jAMK/ZRID/7MbauopBxLEw/ajJVFgpPlSWJE9caJZVI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f131Z0S1Nz4vys; Wed, 28 Jan 2026 09:24:33 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv/EpvJ1M5OOUiGD3Z66/8OlbWeIp51zZgX8h3vOgG42f6IIEsVfE1mysGIdKLeAPKRFeTE/simoldy6DiHdbifT5YCAFoWkej86dA0kRexIjGH2ZjKLn/zafNvFWRN3OmLWPTeECO1Zpv5S+/teLAazrimqnJY4qiiGjzMyljBYFP4Fi+hk9guwUhxdT+EWDNHSAvKQEwQt4QLJq9hJ8t2TZwc/1naIyEU2uv/JSqwmS6IvwkSIZK1DLC9s6TvrFavTvhQan6VO+rGZfHnxkJhKmKcs+4jLaq5unvCdiNpLSeJE2KLap8FBFZrrSvhncEmztyOStoskazo9nnxR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbApDc9CqqZKhr4mWB6y1mzeyz/ai6r9iyhL73ClLps=;
 b=RjN5qTNrb5iPXThm49YI8vNAWPPOOW3K6jfrKrUictKxEM+K3ve3HVCxPz8us7gZtRWPjKsiL3JeRp/jsE/qzA/BE6kq8ocSAjUaL+GD0/JR/FMT+1b3HTyYx0b6v/AIg0O7pX6pYRzAlOR/z//jSaZtfYQU53845RP6CpjBShGOohsKL+T5HbWHw69uCjLjwN9SivQqhUxbZ4vlEDmNz0uwBTYmwHro/kzCrIuE+aQsNGJ8q8LawiH9hJSXdenaHpmBb1uPyk4XBvHLEC8EoiGdpkFuXvPxTBk7EJbMlkPUeccv6QOAPQgj1n7YbpHvS2MN++nDQEbStjeSidkLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Thread-Topic: [PATCH 6.1.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Thread-Index: AQHcjqhF1n+KyZXUSEenrgY1UkgZUbVl4MUAgADZ7+A=
Date: Wed, 28 Jan 2026 00:24:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185218342D3BDFBD4BE549CD91A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
 <aXifqIbi111kBo2w@duo.ucw.cz>
In-Reply-To: <aXifqIbi111kBo2w@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14378:EE_
x-ms-office365-filtering-correlation-id: 602ca834-e181-43f2-1a23-08de5e039b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?R0VudVh1RGpvS0QzOWQ3cXFqenRrblBIS09HRDNuVzNyZ2dheEJWT2Uw?=
 =?iso-2022-jp?B?MGhnZmRXUFpNTDlqVkw0UWNwZWJxQlFpRFh4TWJKOUYrbURxMnN0L1li?=
 =?iso-2022-jp?B?R3BacERZZW44QTdpK01NRzBZKzBodWJHZkthSGZlRHZDNFlmb2MvRnJ3?=
 =?iso-2022-jp?B?WktkVHNPUkMvSC9YM2tyd2k2WWlIVHF4c2hKc3Y0RnpYVUk3SVNIRWo3?=
 =?iso-2022-jp?B?eVl4ZDlQUzNlNTBPUE1HNldGNU91NDFsdi8wcmIzQ3JtMVI3QzkyeXNR?=
 =?iso-2022-jp?B?NmI2RWsxZi9GQkxWTlYvNFRZNjhiOGVuMGNNbkZ1ZzlKWVVkNU5mZlhX?=
 =?iso-2022-jp?B?ODdvTmwwcFQwSjlMcXpDTXA5YzB3bUxkS2VIc082OTdkWUhSMlZaR0hC?=
 =?iso-2022-jp?B?UVlwRHFUc2hTZzV2dUZ6QjFqckFTanNGTXdzalEwMmhrMFd1cnNSY0dW?=
 =?iso-2022-jp?B?MlJVRFJ1d01wOGM5M2x6Qlo1eFUzZTBuMjZlTldDM3VuZTFsUHNVYWVX?=
 =?iso-2022-jp?B?VDU1RHZNZ0VnNUZNcEJ0aEVESUVPbVNBblVzMVBYdUpuTWFHdUx0a05z?=
 =?iso-2022-jp?B?SG54b3Y2Z0FCdVIwVGxRV3dKRUowaEZic3lNaHNnSVZmWHI1VlJ5RU9V?=
 =?iso-2022-jp?B?U0Z2aVI5RW8xRTVMR0xTMXVvVmM1UU5UKzkxWXFTZkR6c1VuUDBFMVp5?=
 =?iso-2022-jp?B?Tjd3eXplQThHSFBZTG5Lc1p0VXlZSU8zVE9BcDY2cisxRHI0WXZ1Q09q?=
 =?iso-2022-jp?B?QmF0ai9heG1INHZHbGxQbGlLanVkTTU1cTl2L3BzWnFOQTNsSURZd0lF?=
 =?iso-2022-jp?B?VlFJNkJVaC9TQXYzZjdiWDVmekt1Y2RCM1d3VjlBNS9GZ21uN0x1aGhF?=
 =?iso-2022-jp?B?T2R1WWlZcU5oeUpqblFjVjdWeS8zQ3p5dzhXSWhnZEY5K3hGaTFVT0Va?=
 =?iso-2022-jp?B?UUYwKzdLa2VVRGxoYitRcEZYL1hYT0N1a2ZSSjlFMVhkMER3Wk9MT3p0?=
 =?iso-2022-jp?B?bVFuQmliblAyUWFocVNLZ2RGa1Y5QTltSkw4bjI5TU5YSjllOTMyQXlj?=
 =?iso-2022-jp?B?ZGtsbHE4WHlnRzgzZklJdzBLVGhuNnN6Qk5HZk16a1FqUUdWU3F5bkxq?=
 =?iso-2022-jp?B?eXMyenZyL3pxeUI4RWl3TWNNTEd3d0NzdzgzY2FvVWlMQXBqMk0ySUFO?=
 =?iso-2022-jp?B?eWhvWUlEaUFpdHQ4eDFKNE42clNPRWorNnpUVWQ5bmhWUE9sMFhZWTBE?=
 =?iso-2022-jp?B?bGxXRGNWeWZxZ25VSlVmbjRRM3hpb21ZSDBRWk1MdXJVOHFFbm0wL2VX?=
 =?iso-2022-jp?B?Q0FCSFRWZy9aN25MR3BVRjRqR1pMdWZKdlRrdzZ2Zk1Qd1ZEWXR1akg2?=
 =?iso-2022-jp?B?azZSUXplSW5qUTdEOGZxTy9wOExrbWpOSzh6aWdETlZwb3JjRGxWSHJh?=
 =?iso-2022-jp?B?MlhYOGN6b0VZNUd0bTB5aFBMRXM0V3Fpdm9mOEJBTktadGZoaHI2eldh?=
 =?iso-2022-jp?B?REswclRreU1UcjROL1IxczFqYzkzT3lXMDcycEhodDQxTFNHSHBRWGZu?=
 =?iso-2022-jp?B?UWRjUjk3SGxzVDdKbmtQZmlXVXB4dGtmRlNKTW1GVjZERUwvUkVTUENl?=
 =?iso-2022-jp?B?WVRidkFEMTJWeFgzZm9STUNlMWhHZUR2M3NaOUxidy9lTXN3R0V0bFhs?=
 =?iso-2022-jp?B?UXNmMVlwWnVrekpXYWVVdTVlUkdZV3JSeVhNVjlrcmgrRDM0Tk8yR3Vv?=
 =?iso-2022-jp?B?dGFLK2R2ajdmZHVaNnFVT0RrM05GWHhScW5xTmF3U3ZESU1ldlJlbUJG?=
 =?iso-2022-jp?B?K0RsWUQwS1hHTk81TlF6YnpCYlorTU1NbUlnL3dESHkzRnVyM21KeXlm?=
 =?iso-2022-jp?B?MTBndTRpWWlpOUIvUzRaS0IzN2p2Q2wyRGhTVkxXcmd1TXp5NTFyQXhN?=
 =?iso-2022-jp?B?TEFRZ1VocnBvOUlhZjdhZFgrZDJ4TnZ6cEpIT1Rjc1JmZ1pPZC90SzFp?=
 =?iso-2022-jp?B?eXhyNjhlVnlkVUFFeThZSkRRY2U0bHQwb3ZQcVFxWjZkbXBEVmZGc3J1?=
 =?iso-2022-jp?B?Q3A3NzNPK0VCQWloSzlyT3BJMWk1RWovL01KNSs1aXppMkpEeW1ZSEJM?=
 =?iso-2022-jp?B?OFBNOWR0Z3A1VUZlWmFEeHppQ1BZdVRTcU1hSWJNNFNhZjVRNTBzcXVy?=
 =?iso-2022-jp?B?NytHN2JlMGRybmlvWjY5U1JGeW44RWQ3NmZscGxFbTJXRnZYbVZUbGpB?=
 =?iso-2022-jp?B?WjNpZUNhdktkZ3ZKbldjQVJBeTVVOUpNd0VlL2xSNk9vY1YzKzJnUjBU?=
 =?iso-2022-jp?B?VU9oSUt2ZFc0YlU1VGlWVzFrOFp2OU1KWWZSSlB2aGZRZnM4dnA5SWkz?=
 =?iso-2022-jp?B?Z0I1RDg9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MXhYNWxyRUR4L3k1VmhWVEpSUFZldzNJWkZtZ0tlZE1BczJvU0tYeG8z?=
 =?iso-2022-jp?B?Z0lUeVM5M2kyM1IvRjFZQnFTSElZMEJwM3hFN2swWmVkbVl3Q3B1c3FU?=
 =?iso-2022-jp?B?QS9TTkVwWDVlK3ZLdENSU1Q4ZSthd2MySlovL3RRSlVBSlJRR1ZEdEVw?=
 =?iso-2022-jp?B?YVBTOGJoZHhrdTVwYjRjM3FxVGtSMjZtbVBtQ0lkRm5xNTVEYm5MMG1G?=
 =?iso-2022-jp?B?ajMrOEVxSThwdjV3QzB6d25FR0MwdmtJNjQ3NGJzTjRxeWtWLzgyL2s4?=
 =?iso-2022-jp?B?T3NSMm55eHEzQk5jL2tBR3BSRzloVUlaRWhoNENDNXlhcXZMd09GcFhH?=
 =?iso-2022-jp?B?elpRdWhsSkF2NEh0MW1YeTlDT09YY0dFaFMwcElxTHVCempCMTFLcTl3?=
 =?iso-2022-jp?B?NG1ndXhVVm81UWthNDRhR3p5VUo5ZDdlZTlCbktBQWRxNTFMNDhZL2Fk?=
 =?iso-2022-jp?B?eCsxaE5tQ1NQOVZLOGtLSVpIb1B2VGp1Rk55L1VNVVRleDdtYm1jbzBm?=
 =?iso-2022-jp?B?eDMvRkpad3NuTWNDdGZkVnpxVmllVXpmZFB3SXE4TkhNaTF4VDdQOGhK?=
 =?iso-2022-jp?B?SHUzOHpOdzZ4MURtS1BWd0p6SUZCVTVYV3luZTA2YXpQN2w5Wlo2emcy?=
 =?iso-2022-jp?B?b3gzNmdNUThmS2IyVi9Fd0FUNzREM0VGSExEaFFVY3d4d3poU2prYVRp?=
 =?iso-2022-jp?B?aUplRDdHUERra3lCd2dnTjJLKzg4N1h4Z0pwZE9ZRU51MkN3bmZTdFps?=
 =?iso-2022-jp?B?dEhDMURUSkxmRjQwanZuVVpMbnZlRHNGMnRxaW9MWE5rN3F0MWJxZTJC?=
 =?iso-2022-jp?B?UUlyZWQvbFZ0TktlQWk3M1JCLzVmbnlHR0dJejE2a01sd09MOTV3VFI1?=
 =?iso-2022-jp?B?eWFMVlg2Q25mN0NET1NJRzhoaGNJY0lqNmtCOGI2eGtyYVNaNEpieTc0?=
 =?iso-2022-jp?B?QXVmdGYzSFY2SXQ4R09nUjY4TlFTVkRibUJwQXVWZnNBT1prNHB1NUpY?=
 =?iso-2022-jp?B?V09Cazd0dWFDb1Z3UlJhUnlNalhaclA4YUFCbjJFdXpKa01yNUZiYnAz?=
 =?iso-2022-jp?B?dzh6d2prRzMvaEhMNUVyNlJFVy9QN0ZVa2Ira0Fyc3U4YUpDL1ZBVXZB?=
 =?iso-2022-jp?B?aTB4L1FYaTZtaG5McXFadVg2NGtWV1dBQWdoMVg1eG9rU0NQRVlGRTNo?=
 =?iso-2022-jp?B?dU43UGNaOUVob0x4eHJLN0dYcXE5SzcrU1djSGpTKzYzbzkwajhPSGp4?=
 =?iso-2022-jp?B?VS9jK3B6UTBIZUkzZlM4WGs3VzZPd3ByWWVmWjZPUERtdXBiRk5JY0lx?=
 =?iso-2022-jp?B?cWtYaVlhQXNSSnAycHZmVW1ubENZdkN3enE1QmVaQjA2TE9QTUNuZ2dX?=
 =?iso-2022-jp?B?ZXNhb0w0TDkvcE5Id1NwcExwVUlHNU1lRHhYWForRXFFeTFZMXZQMG1G?=
 =?iso-2022-jp?B?S3owRTcwS3IvNjYrZXpBaW1iZmMxdFdqMEhnWHVaRk44Y29LUmVjRkxU?=
 =?iso-2022-jp?B?T29zbnpTdm96YkJwdWsxUHhLM0EzVEE2SERaVk1RVW8rRHNLS3BOeXJx?=
 =?iso-2022-jp?B?ZUZzL3hJM3pYb0ZraUFYZXZiTVd0V0pxK09OVmpvRjM5ek5JZDAra2pZ?=
 =?iso-2022-jp?B?ZGd4K21Eb3BQaFUwZWJIUU1iZjU5a3ZiTGRDaTM2cHBNOGxzcCtGSktx?=
 =?iso-2022-jp?B?RlArdFFLSEVBb1VMWDdNQ3FhSXBZMUU1OWdyRUtNNzh1Qy9sMDRFaXlH?=
 =?iso-2022-jp?B?VzN6OFZGYWMzVURaZ3B3VDcvb2FFenRJUGZGMExUVDBra1BwSXFQZWRG?=
 =?iso-2022-jp?B?UUI0am5PdXFHTENaM0lueG1aUDB3RlBlczl5YkdJQkxWZ2tJQTRvL3da?=
 =?iso-2022-jp?B?K3Z5N0ZvSERUS3hzR2lTWkpRYVFIakJsMjhlSnN1NWtTN2Zaak1KMVh3?=
 =?iso-2022-jp?B?WmFFR2V1Wm9mRm5taHFqTzJMdC9NcGxObmJLeUVTeVVyakhQMnorN3Bp?=
 =?iso-2022-jp?B?RE1FK0dnSy9JSXBJeFc3bHBoU2daTks4Yk9ERlliQkNlTWNXRWhmYURo?=
 =?iso-2022-jp?B?QWRETUN5OVRQeEZHWFRCZGpZb2xtM3VlNVh3NXZnTHlHdUhiZ1IvUWJ2?=
 =?iso-2022-jp?B?Q2FLTDFQYmgwRUF0NkoyNFNvd3ZZNWVjTm9Xam9reXNVS1lEUytNSUNp?=
 =?iso-2022-jp?B?UjZoZGlLWC8yYVkyZ0RqOXl4WldWZStmSVZGdUZ4SG9xRUdoRFUxb2VM?=
 =?iso-2022-jp?B?K2NLT0N1VUd4V0tqZUpGaEVYSnNrbC9uZk5jRG9DMFY0VDZBdE1pVy9i?=
 =?iso-2022-jp?B?Tk9QQklYNDBFcDFOeGRXVENKUnRJaUJ3Y1VxQ2lIMlkyV0RNZzhnRlEw?=
 =?iso-2022-jp?B?ZDBLTzc0V3Z0R2daVXVUZFV0aWxwVHBuRkEzWHpKamRPRmQ0TWpXSnRZ?=
 =?iso-2022-jp?B?UnZzdnBEc0Y5UjZWVTZiNVpZTzVyM3lwWjMrOU5NZ3MyM1JYSXpmZ0Zn?=
 =?iso-2022-jp?B?M0kva0pXWUMyOVk0ZC94d2pGU2NzQUdXclNYWHl2WkN2akZqbysyTTFB?=
 =?iso-2022-jp?B?SkZpeHA2RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602ca834-e181-43f2-1a23-08de5e039b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:24:31.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5VaZFqCKgj9R96qeNHkfrkwjVN5MaOh0lhb3EN6xXQLqotF4DhtZ+u7cj/LEF/xuuCIugg2I944/hUrXtFLn+49Lpiuo393B0fMsey30uUQKUwxGEyEnmDc0dIfsZHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 00:24:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21730

HI all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, January 27, 2026 8:21 PM
> To: Claudiu <claudiu.beznea@tuxon.dev>
> Cc: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =
=1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 6.1.y-cip 0/3] mmc: renesas_sdhi: Backport reset cont=
rol
>=20
> Hi!
>=20
> > This series backports patches to control the reset signal of the
> > Renesas SDHI IP during probe and suspend/resume.
>=20
> Same as 6.12: looks good.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, so looks good to me too.
I applied with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


