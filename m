Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A9E74902
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 05:17:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115186.1766553465057276582
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Dec 2025 21:17:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=vqMaUaSK;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766553449;x=1767763049;bh=sh7gbN5NtcTT2NjbUjuO1quGTnzuw3OqI0CIH
	B3OKwc=;b=vqMaUaSKq2jrIo3j0jApFk2pEmdVcdktaeJSHe8vI8clSAcZ+sWJSbOUkEzhP15wa5e
	ca2mwESXUOcJ/Z/7WjHvEhYG6TOL6szXEADZO7z+Pm9iVkmEj7x5JiDHoGq/o4wvR0Ff1EbD4mIBs
	1hU5XhoE6c3I+AqYmvN8ttceFrhJ9ddrd6o8Kd2Hi+CkPd1vJ/CIqLbqNcWVGdyrqlxSZ1qpUL8TK
	XbvRZHPgKCtt8p21vVgPv5Q5ok/5TctNQzS+0h+E/x6gbOPu7SPVksfdZfXI+ViTRKqaFVdC+qt2d
	nQn7jtngWjFuUx2G4PPuuwcuy7EAjfcVBU6jyGb3Ix5A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5BO5HSes030150; Wed, 24 Dec 2025 14:17:28 +0900
X-Iguazu-Qid: 2yAaQEIyi8YcQc289d
X-Iguazu-QSIG: v=2; s=0; t=1766553448; q=2yAaQEIyi8YcQc289d; m=7kxwy9S2ckroec9CUJiCY/QUXGYIdZkY+TkHBAp/ZjM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dbg9h0bDDz1xnc; Wed, 24 Dec 2025 14:17:28 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leRb5mN8NsC+smkX8qEPvVJxpEwwqhKirYgdK+r2yT5D4d0cZY2/GlS+ATlH8jH8r6IHT3kcedBG1/qKCF2aSKkchZQ91BZIndlvwhSc6rJNUi0sDCYq3dP3jen+9pu4qW4UWwZlUjV+B9YyUaQQdQZi/Hw8jbe+pWQBtUb90Bs9+Oe31vxN1QTa2eWz4GSpuIGlS6mQCO9XX06ZxVZrwfhTHM6uElGq052S89a3Gvq8KvD85nBOAOgF2RnYphlVnCgUP+FrKUB7m9mDFvZXveO2AvKRlrownANT2UT8umA0hkdycv4vsB2UC4QHh+JWZhKYzXD/k+KNVN/L7jfbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adW848lrsqMVPeubUBP0Q6bb/JRtoC+olVzNUHoyw1s=;
 b=axAFHNH9SFF2agitkMlV6bVXmWuweO/l6OF/fxP7rYx3qIgg8xsXxJ1ZjnrxFutO2LZkWK49JmOog5DPSvLDFNzQtbTIF9+GPpuQqG8RoPqGkfntT2db6V0EXom4g6z/7VtVHR9M4bIi9aNEobM15fdtz69o8mbvySoGQgW1LGgXDtF08Ezezb+TVyLltabboSkDV6TgclfTxbu+ui32HFXggcTAALEBjkqF11pRxlAgLY9aPM3rW3/iUrT/WZ1as1hOZVkHbwGCUV0yEaiAl6NuMGgrgEIV+k3K5AE+4LHdQVLIXS5VTT0x9dPQcoCCmyLvZBsvQ0L7SB6OXnORqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.au@gmail.com>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Topic: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Index: AQHccOMgldaLwgJTckC1CNQRTLYfTbUwRZZQ
Date: Wed, 24 Dec 2025 05:17:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481814158E5E8E076C44B8DFCDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8780:EE_
x-ms-office365-filtering-correlation-id: 9d47bf89-5647-46c1-1fd2-08de42abb99e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V1FlbFllRFhlUncveU9wK2pxMmxsT21QV0U0U3hCN0RRZUxvTmRZVDJ1?=
 =?iso-2022-jp?B?ZGpydWdVdmFscTZtU0R2K2s0c2lWVXRMVUdZRHVFVFJNSmJMT0RWaXVz?=
 =?iso-2022-jp?B?QmFidmVuKzJKbFhLUE5TN0pBTXVzaW1wdEVNWklFZHlHRUNvWndEakdJ?=
 =?iso-2022-jp?B?cDBmTVliRXJzY0FwSnpsa0wrUE9tdHVOWW83MFE3WVVJL0M0dnF3VEE5?=
 =?iso-2022-jp?B?YXA5K29vUHp3dG1Vam9ER1A5UUs2SFRMc2xXU2ZSUk55a25nMVcwRE1z?=
 =?iso-2022-jp?B?a2JYOXBRY0ZDYWRUaFd2WU9ybGRiSkJvcSt5R09LRG03N0lodFRIeFIv?=
 =?iso-2022-jp?B?aWxncy80RDhaQjluMEpVbk9yTk9lRkpDa3FyMUwyZ01ScUw4cWorbGhR?=
 =?iso-2022-jp?B?ekJldk85VGRYTFppYnBGWndWcnhMdmlRSm84ZWpoNThqeENrV3Z1dk1u?=
 =?iso-2022-jp?B?cTdYV3hteEtPVjFPSUJyT3NHeVlZYnd6K1NMeEJ0U1lWa2tLeVIybk4y?=
 =?iso-2022-jp?B?S2VDNTV1ODVHamt4QXFFRjlJQXNnYjM1L2swdEJvMnVkUmVEZWRUbWk4?=
 =?iso-2022-jp?B?M201K1ZiTmJ1Q1B4NDJ3L05QRVJOWS9OeE9LOHRDSnJTbS8yMjBRT1Jp?=
 =?iso-2022-jp?B?WWdqUjk1TldzaUwzd0lFNXRSd00yMFlLcm5Hd1VBeVcvaDRCa1o3MVB4?=
 =?iso-2022-jp?B?c0w2MVpTdEsva2xyWUtaTjRUbFJNWitUVG01T1RDUlFNZDdTMkJMSzNG?=
 =?iso-2022-jp?B?M1QyVVU0WGh2QTdiN005Z3lhQmZwZ3FaZjJJdWVPcmRWeStldHJQSTA0?=
 =?iso-2022-jp?B?MFU3QURWRzYyTmpMZ3J1Y2p5eFZoQTViQ0RIMitUclhCdWlPbWVKZU8v?=
 =?iso-2022-jp?B?WG4yMkdPdzlWQkhYU2RmMlI5ak5kWjVEb1VkN3haQjlGZHNxNkt4Y0ZW?=
 =?iso-2022-jp?B?OVR5b3hPN29wNENEV3B2UDhra21uTkhPaGRLVzBBRXdWNHBuTHNCNXVS?=
 =?iso-2022-jp?B?OEYvVFpmYmpyNWNkNjUrWVFTZXdnTEJNTXlVWnJjOHVVcFkxdjR6a2tB?=
 =?iso-2022-jp?B?K3pZcVdaVlpQRUtGZnZldHlSL1AzckxqTEwxRHZnR0Q1VFRxcUlSVW9U?=
 =?iso-2022-jp?B?OUVDL2JiaDdod3NnSG5TcVhDN0NPenFPMnBPSng1VCsxYVFETGxJNG1P?=
 =?iso-2022-jp?B?NnMvbnBXdWlqZ1cwbzBCRUlGZDRpOU9SSE0xQllIWkhKNTc1ZDBNM3ZR?=
 =?iso-2022-jp?B?RHl3OGI2SE1FZ0hpVGNuVjFDRDBCM0UzVUhpbUZsNDg5dlZoQ25TUGV4?=
 =?iso-2022-jp?B?QlFOb042YVdBdFM1MkpuejE5bE4zV3dQbUs4eU5YajBPQ1NOSnVaVStn?=
 =?iso-2022-jp?B?UHRSYjJXSDJTSGNUcnhiSElPS0FibkxtbnN1L2tITTI0bHQ0ZVhLN0tr?=
 =?iso-2022-jp?B?Z1crRXlabFFpZVdjcTkyNlliUUhQVlRHakgwSnh3NkY3SlBYbEk2NlpZ?=
 =?iso-2022-jp?B?NGR5aHJPeVc3TC9IZlU1MVFyeU1DaWtjT0xqWmovakpBNCtSdklyMVkv?=
 =?iso-2022-jp?B?Q1ZKRVVKRjUzTlJYM1RjWGFidzBhakx6MnptUWVzVGU1RWwrOEU3T2hB?=
 =?iso-2022-jp?B?MFBEME4xZDVJVkdSWmRDaWVxbE1FTy93ams1eFdoNm9CZEVKNWhRUHgv?=
 =?iso-2022-jp?B?WDFiNG5PaExtaGprMjVGL3crQXNmUENKaktucURSQjB6VllMQWpBWFJn?=
 =?iso-2022-jp?B?SDN6NDlmVXdwVitaLzhHVktGZUVTTXNOTjZDZTBIV0U1V2pXK2ZISVRY?=
 =?iso-2022-jp?B?WWxaRGs5aW5mRUk1YmR6Z0oydDVjcGtFZGh6eVA0MG1NM1FTemtGWkZQ?=
 =?iso-2022-jp?B?akYyY1VMb2F4V0xhdFFsRDVwcnpic3k2a1JKUUl2c25jcEw2V1dvWm1i?=
 =?iso-2022-jp?B?aUxpOEVXam9VNG1XbHNJbXIrNGw4bHpwQVVrMU9MUGo3TXIrM3dNN25u?=
 =?iso-2022-jp?B?cUl1dGZwNXEySUZNb3BkNlZpY054U2dFZXhBYk1rbERnazZtSWM3RUk1?=
 =?iso-2022-jp?B?WnVrN055a3hLbnMvRFo2R2V3RWxpakJRZ3VTTjB2VGw3dGp3WGtpL0Fi?=
 =?iso-2022-jp?B?d1pvUXFBUFprYkp5aVN2QStpbGlHZnZSbmRHM29kVktOUnN1UXA0WEpU?=
 =?iso-2022-jp?B?U3JmLzJkM0FudFNqVUNKVzlOQlNjUXZs?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WmM5S25RT09LYzJIWSsvSmE0VXBxMit5ZUlWUmg3TWFyZ1BoM1NXcDdS?=
 =?iso-2022-jp?B?bjducWNtQnZWeDVjZnlqVEt5YWVGbXNQU25uYVRBNHUxWFdlY2JEbEVU?=
 =?iso-2022-jp?B?ZThCYjhsaXJjYllwSThQanlxcGlMVkRKNmwxS1NjYW45R2R4T1lOaEVi?=
 =?iso-2022-jp?B?b2ZLZWxHc2xTUGNtOFBVSUx4Wkw5RDRvT29QcGl3YkgwU3ZsRU1LTHlF?=
 =?iso-2022-jp?B?TitkblYvV3NXU0MwM2tKYmJHelgxNkxqVjh5RXZZZEMrN0tORXBReS9h?=
 =?iso-2022-jp?B?T1hFMmM4VDZtekRQU1BDRTRXOUx4L0o2NHZ6a2hZSWxqWUloQzJxQ2RW?=
 =?iso-2022-jp?B?WjdMcGU2RkxaQ054SjFuWVpPUmUwNk5ZZGxVaCs3bENkaCtBUmRQMFZP?=
 =?iso-2022-jp?B?cVdiSXZpV3pTOXQ1Mk4rVGp2TzMvTm56ZEkyRFNQaTJIa3dQL0w0UmNs?=
 =?iso-2022-jp?B?U01tMGcyTXY3c1ZYNkhVcnN4WlMwQWVyZXlNdzZoTzNxb2loK2pTV25W?=
 =?iso-2022-jp?B?VE41U3BMVlg5MGtGQTQrQmhQZHl2T0J0SXE1ei9YaCsvbTR2cEFGUWR4?=
 =?iso-2022-jp?B?L3VTMzJvZy92TVBhQzgyZWg0UktjVDMrdnFHVlhrSy9SdDRKYVdOQ3gv?=
 =?iso-2022-jp?B?NUcyK3VFWFMyMWRDU2FxKytmdlhoY3BDVm5zazdsZzJXOGpSZ05za3l0?=
 =?iso-2022-jp?B?dm92Q2kvbEpBclAyWVI4TmNYNzdkUzR2VVQ5cVhaQ3NyeUltUkFEdU1w?=
 =?iso-2022-jp?B?RmYxWi9aVC9RbHdhYWs4RGRsV2NMaVBjMUZoZnlzRDlHMmEvN1RiVVpi?=
 =?iso-2022-jp?B?cWVJMzVScGtTekV1eWRCSGVsYkwyRk84TVFKOTlQOHFrWGVlVDdXR09s?=
 =?iso-2022-jp?B?MVh6THRRaDlnL1BlM2plQ1RKTHZvblJ2R3RMVFBPZHVTdUc3dlRvOW1B?=
 =?iso-2022-jp?B?b3FzeWhNcGwxSTI0MU5iamRUY3psUDYvWDJYQWRJUVBaMmQ3R2d3K1NL?=
 =?iso-2022-jp?B?N1U2RWd0YWZ1Wjd5QlBDUVVzc0pCL1QzWTFVTm1PWTVOcURsN3ZYaGkr?=
 =?iso-2022-jp?B?RVJGWU5sQXIrc1pXZ2VnMUxHMnl6ZDNjVGNSalhqK2dGYXd5eExVTGhF?=
 =?iso-2022-jp?B?VWVmRENGNXRKSXNaRk5DbCtYTGdpb3BnYzEvZ1hjT3VUazBPNGdzMGJC?=
 =?iso-2022-jp?B?VWtiU0tvT2JuSEsvaU01bzRzNUN4YWtKZDFtS0RNS3ZPNUZmejdXRW5O?=
 =?iso-2022-jp?B?T1doMEpjeHlFTXVyN2lUUTUwem9qMkpnNUNjLzhNY3ltL09RWVM2eDI3?=
 =?iso-2022-jp?B?WVh6MVQ0V1JKVmFhK3VHWkhwTjVGenh3bDJIVWFMQ0lRSXptWFhHQ3Vp?=
 =?iso-2022-jp?B?dk1jMmI2aCsvZFVYZ0hVRGFNTCtjbjArOG9lUGc2bTYzN0JwUHpLdVJK?=
 =?iso-2022-jp?B?bU1KRFdGR3E1TGw1T2xlOTlZL05lL2h0bDd5akZHSFYxWWdOUmJMTlRR?=
 =?iso-2022-jp?B?WDI0UmpGZHF0cmQvamF6N000QXNpaWN0QVhqU2pmSllIVFRNWWJZSWtt?=
 =?iso-2022-jp?B?MVgzR3NYanRNdG1xd3BlNDBzZi9aVnI4aG5JdmVQdjlJcmZRSnFxa3FG?=
 =?iso-2022-jp?B?Z2FuamZiTlRWZVN4YWI0ZTFWYXFXN2hjamhvRzNjSUdXL3FKVUl0SGVN?=
 =?iso-2022-jp?B?KzNOWlBJWHFJbE8rdUhqV0ZxSjViOXRxL3lvTGUxZ3EwQmpmTDZ3ZmQy?=
 =?iso-2022-jp?B?U3UyTGQ2YkJBbUZ4MnZyL3lTQk9lVGlJRDR2T2YxdXFnd1NQUGh3Y1lB?=
 =?iso-2022-jp?B?TFo0Z0pUV2lLRlVEeUQ1NWk2TjZBelZwdnppL1JTREViUFM5bFF6Kys3?=
 =?iso-2022-jp?B?dHdPMFNCVExvN1Vzd0dveVRjNDRQZkZuYUg2YlNMWWN3NXFMN1NFQmho?=
 =?iso-2022-jp?B?K2lsZlpYUit4T2NBcHJRSnA0cFRRa3JIbGpiV0Q0S2FRNVVKZXRTTXJ1?=
 =?iso-2022-jp?B?VHlpUW9US3F1Qjlxa0JWMmQyVUhmM25MY0Q2RDg2ajlvR3RFdDVRdUxp?=
 =?iso-2022-jp?B?N2ZldXA1QlRnUVRTLy9jcmcxY0tOeDdMQURLWThFR3cwVWxBamRoUjRX?=
 =?iso-2022-jp?B?RWkwd2EwalVlbWZUNXFSYlRoZnByT2lVaFUreWlJQUFyY3J3ZDlmanJD?=
 =?iso-2022-jp?B?VW9XQWlZUjNDNWtIV1Jyc0lTR3ozdSt1T004MWRRTEZVdEVRdEZlTEFQ?=
 =?iso-2022-jp?B?WEZKNFBSU1pkVzRlTWdqdGd0VU0wZlVJY0M3MjR2YkhRcGNJZ1pXc0RO?=
 =?iso-2022-jp?B?cUhpL1o5cTE5YnFSQm5Tc2QxNWVjTVpja3NaMWtWcElMQU0vb2ZlbFZi?=
 =?iso-2022-jp?B?cnlPbVkrT2V3U0lZNlpDVHlSSm9HZndoQks3NmVQckFiOUhjVTg2V1A1?=
 =?iso-2022-jp?B?S3ROM0tiQ1VGL296TytYbXpoWDBkTEw3TmtEbzNCK3MxN1VGN2owVVln?=
 =?iso-2022-jp?B?bThNRmRURlZsbmtrUEZZTE5IeWJQTFlWQ0xCZ1dXNnQzMHplbG5wWERl?=
 =?iso-2022-jp?B?TjB1cThvbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d47bf89-5647-46c1-1fd2-08de42abb99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 05:17:25.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvzbgWBEdpscM+P2FihkM4kY7IiiTUraF9Ax6qkynwQUUrQQccU6V10fkQ9nynEsNUlbVq5gqpKuNrTwA+L8sscVWhrMSsd5c9C0Tg+4lSuEUgqpuZri7OB0zjOuvwxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8780
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Dec 2025 05:17:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21212

Hi Biju,

Thank for your patch.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: Friday, December 19, 2025 9:29 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
> Add gpio keys
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
>=20
> RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
> USER_SW3 and SLEEP button with NMI support. Add a DT node in device tree
> to instantiate the gpio-keys driver for these buttons.
>=20
> The system can enter into STR state by pressing the sleep button and wake=
up
> from STR is done by pressing power button. The USER_SW{1,2,3} configured =
as
> wakeup-source, so it can wakeup the system during s2idle.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/20250702092755.70847-1-biju.das.jz@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
> r9a09g047e57-smarc: Fix gpio key's pin control node"]

Why did you need to squash the commit?

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37
> +++++++++++++++++++
>  .../boot/dts/renesas/renesas-smarc2.dtsi      | 31
> ++++++++++++++++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> index 2454a9743df2..9f6716fa1086 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>=20
>  /* Switch selection settings */
> +#define SW_LCD_EN		0
>  #define SW_GPIO8_CAN0_STB	0
>  #define SW_GPIO9_CAN1_STB	0
>  #define SW_LCD_EN		0
> @@ -15,7 +16,16 @@
>  #define SW_SD0_DEV_SEL		0
>  #define SW_SDIO_M2E		0
>=20
> +#define PMOD_GPIO4		0
> +#define PMOD_GPIO6		0
> +#define PMOD_GPIO7		0
> +
> +#define KEY_1_GPIO		RZG3E_GPIO(3, 1)
> +#define KEY_2_GPIO		RZG3E_GPIO(8, 4)
> +#define KEY_3_GPIO		RZG3E_GPIO(8, 5)
> +
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
>  #include "r9a09g047e57.dtsi"
>  #include "rzg3e-smarc-som.dtsi"
> @@ -79,6 +89,29 @@ &i2c0 {
>  	pinctrl-names =3D "default";
>  };
>=20
> +&keys {
> +	pinctrl-0 =3D <&nmi_pins>;
> +	pinctrl-names =3D "default";
> +
> +	key-sleep {
> +		interrupts-extended =3D <&icu 0 IRQ_TYPE_EDGE_FALLING>;
> +		linux,code =3D <KEY_SLEEP>;
> +		label =3D "SLEEP";
> +		debounce-interval =3D <20>;
> +	};
> +#if PMOD_GPIO4
> +	/delete-node/ key-1;
> +#endif
> +
> +#if SW_LCD_EN || PMOD_GPIO6
> +	/delete-node/ key-2;
> +#endif
> +
> +#if SW_LCD_EN || PMOD_GPIO7
> +	/delete-node/ key-3;
> +#endif
> +};
> +
>  &pinctrl {
>  	canfd_pins: canfd {
>  		can1_pins: can1 {
> @@ -97,6 +130,10 @@ i2c0_pins: i2c0 {
>  			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
>  	};
>=20
> +	nmi_pins: nmi {
> +		pinmux =3D <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
> +	};
> +
>  	scif_pins: scif {
>  		pins =3D "SCIF_TXD", "SCIF_RXD";
>  		renesas,output-impedance =3D <1>;
> diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> index 3cac292f20b3..58561da3007a 100644
> --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> @@ -23,6 +23,9 @@
>   * SW_GPIO9_CAN1_STB:
>   *	0 - Connect to GPIO9 PMOD (default)
>   *	1 - Connect to CAN1 transceiver STB pin
> + *
> + * GPIO keys are enabled by default. Use PMOD_GPIO macros to disable
> + them
> + * if needed.
>   */
>=20
>  / {
> @@ -53,6 +56,34 @@ can_transceiver1: can-phy1 {
>  		max-bitrate =3D <8000000>;
>  		status =3D "disabled";
>  	};
> +
> +	keys: keys {
> +		compatible =3D "gpio-keys";
> +
> +		key-1 {
> +			interrupts-extended =3D <&pinctrl KEY_1_GPIO
> IRQ_TYPE_EDGE_FALLING>;
> +			linux,code =3D <KEY_1>;
> +			label =3D "USER_SW1";
> +			wakeup-source;
> +			debounce-interval =3D <20>;
> +		};
> +
> +		key-2 {
> +			interrupts-extended =3D <&pinctrl KEY_2_GPIO
> IRQ_TYPE_EDGE_FALLING>;
> +			linux,code =3D <KEY_2>;
> +			label =3D "USER_SW2";
> +			wakeup-source;
> +			debounce-interval =3D <20>;
> +		};
> +
> +		key-3 {
> +			interrupts-extended =3D <&pinctrl KEY_3_GPIO
> IRQ_TYPE_EDGE_FALLING>;
> +			linux,code =3D <KEY_3>;
> +			label =3D "USER_SW3";
> +			wakeup-source;
> +			debounce-interval =3D <20>;
> +		};
> +	};
>  };
>=20
>  &canfd {
> --
> 2.43.0

Best regards,
  Nobuhiro


