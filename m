Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8AD14890
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:11:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23005.1767838254092572942
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:10:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=m/1UcHl2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767838247;x=1769047847;bh=fM6pcD+jiJVsFyZ+hx5GA7ylq2JQCkZ4w0mIm
	j/64Ww=;b=m/1UcHl29T/9+na8gijtDXM2sVOSlwtTkdxJ8ZGJ2K438MhsTbzWcb80daV+0gaHgXr
	tCco0byRNukO+9S5K/JUBEc34mXTzBgHucigcM/QfC8ky/fJfRjmKkxWS/XxTA27Ebp2WxDNVYtQu
	3YY31TjzcV/0wubrYZaiWnv8p7o0jcKxED0ezSY6GbwqLaUSNxMGIEVBXxFHpGzDVAMdxqY5znQBt
	PNR3SAcskCWyGVxFDCBMiujYvx6QZdrkLEN/226X+/tTMkSkTQE5ykGVTIGxwEVFbIN5HdYth9h1U
	8pwfQN62gm5L2wsXJV3m51+QkGvWYqGZSbMzyCFSWNFA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6082AlFL1105966; Thu, 8 Jan 2026 11:10:47 +0900
X-Iguazu-Qid: 2rWhPDSx0AtSU9iKBP
X-Iguazu-QSIG: v=2; s=0; t=1767838246; q=2rWhPDSx0AtSU9iKBP; m=PfoDIFJ2ZHyhpg4kIT0gyxxe9tQsFE4hm5og7eA2VHA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmpKK74Pyz4vyq; Thu,  8 Jan 2026 11:10:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqPWn9K/+H1nRtprM7x9HjrncR2fT/AW1vZOQscgrvvcbFK8Gyhyk4912WflVevE/Pt+RSv74ashW2HAKllgrVu1AQK4Ln0IuePVohRAJM0igUyngxdUhOmcNlCUbVeB2KOK2g+/lmpOTC5NbuVsIIkMIhKz8oH9qnRD5VgoXC12noes7ooMRC8lqjg3YHp2ALtS3OEY9+6xuUfvj0gmB9+85vfykGl1X5XwC1b2inS1zDShXe8pt6/Y1KJjODxNPX8QFdL0El7djYni24sJfNP64l9grC94oaQm9Ucvb0IEo5Dcci44JEFg4fRhdJohClrXniUNByg5dy9Lcr4Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtNAkK1OzFpRfs/Jm3xPon5YpFwJnJ2lERTMHIsvzRE=;
 b=dBt0TzxE5JKxkqCT1oRdxuzFgdQAMvSXM1MIBCIgrjqiJXthtsSIbIuxXpZriy1eVZQ9yquLemO8DSqreNS8h+8jsteT9pHU6fsAhmRZixpmheBNfXn6WzZTwZ2MSuiqvs/NQTR5GOn9HS+TL8pUUMpVGeqJYzEY3BchIr+Tm4rNKQyRmWd8lbmkb8V8Gmfq9bPwACkz5uWk+pfi3WEHKx8/C7Sh2jA/C4Xr1Sk7YzCE+5RlD20pz40CKoJVQgyVu1fLHEPBnIRyQ0qn6A3lMb9ewiN0PLjohYgTOKC2br3mvsYS/a/dfN/zdZuJgUGEi4n83zqbfagZxMTcdpynPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip v2 00/13] Add gpio keys/sleep button support for
 RZ/G3E
Thread-Topic: [PATCH 6.1.y-cip v2 00/13] Add gpio keys/sleep button support
 for RZ/G3E
Thread-Index: AQHcfwTnfiCs45Gtd0W/p8w9FYtY6LVGuPkAgADQmNA=
Date: Thu, 8 Jan 2026 02:10:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188D432AD2A0D41BEC1315CD85A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
 <aV5i1sDiHHgfuICx@duo.ucw.cz>
In-Reply-To: <aV5i1sDiHHgfuICx@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14332:EE_
x-ms-office365-filtering-correlation-id: d085c833-2b4e-4e95-f993-08de4e5b20c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YnNaSXdaUUtPQnlTSlludXRBaHpjSHZaVnB0WEV3SHdBRWJMZUd4dVVl?=
 =?iso-2022-jp?B?YUZnN01NLzUvVGxYMzVwZmQ2b3psLzdMUjRweTZnNzk3WnVFaFNONTIz?=
 =?iso-2022-jp?B?cmVIb0RWeXFmdWYza1FnV2Y1bS9jdmhVbm5pODhqT1BFc3pBb3lsd291?=
 =?iso-2022-jp?B?aVZVRVNScXlJVkwyOW5UbHd1NFV6WWk0SVF6WXBCMVBITXdiSVZUTUw4?=
 =?iso-2022-jp?B?UU1QelYvM2dTMm9QbmRoTnRHUmRKanh3czFQcHB3dHlHeFBVYys1b2Fr?=
 =?iso-2022-jp?B?TDdPRE1YbDFkT2cvNmlLTXdkQXRURWFxck85YUpYcjcyNW9qZzV6ZkRq?=
 =?iso-2022-jp?B?Y25CWVNnZGh5MUVuQWhjMzVSaktZWHQyRnc5OTRzWS9acEdJNWVNWWtX?=
 =?iso-2022-jp?B?MWtMUUhJb2NEQmtpZHRkbHNHNVNSM3V6d0REUC9XQ2gzRlRwMjFoTldw?=
 =?iso-2022-jp?B?QmVBaHNvZlV6QWRYWXhLcUo0RnNFc0RzWGtFcjJydVBhaGVaZE9VaE5i?=
 =?iso-2022-jp?B?YWhqdFZTZG9kL1FpT2VKbW1Zc2tCM0ZFN1drNXZEZzJxbzcvQTVlRFNH?=
 =?iso-2022-jp?B?VndiaG1QRHRQdzVwQWRMYm9DazJKOGxYeU1lZUI1VmdBa2hmUjZEdHF0?=
 =?iso-2022-jp?B?T1pYZU5HN1JjWXhtZEZKNFIvRi9RTXRQaG9pcGhvZ3ZqZ0VjRUFQQkRD?=
 =?iso-2022-jp?B?d0xOT1dZK1Izc2kyM3JDTjhDUUZwQ0RBcFcvWHRTNkZUcDJnTHllQ3Ay?=
 =?iso-2022-jp?B?ck52M3MvZHRlS1V2b0RseFVvbzNyWDFwbTJBOE9ic0c0VysyVDBpS0VE?=
 =?iso-2022-jp?B?enB3MVRDQmdERmJOZ1liSkFtR2RPVXRMM00xdEhiZEZ2aVBXeUxFZytv?=
 =?iso-2022-jp?B?aVlLbEdNTG9TS0c1dld0VW1KK2dtR1JXRytMWHo4VmRkWldBb3d1MElX?=
 =?iso-2022-jp?B?eE5ocGZ2cUtsM1E2dmE0bFlLVWluckVrYkp5cGlYcnYvS1Q0TUtNSVBj?=
 =?iso-2022-jp?B?Z0tKWWVKc25ZNzI4aWVqc3dTV3VCZVZONjc2QTlsUWRib0sxWVVtOFdT?=
 =?iso-2022-jp?B?MWxmMFlkUllHNFZpcisxV0xjMWRIajhhZVpvNzgrcWdHRUwxQkdXTjZW?=
 =?iso-2022-jp?B?NnVzMGZoQXIvenVZUm84Zi9ZU1F5NStYckIzMUxuRmJwU2Q2L2o3SUJv?=
 =?iso-2022-jp?B?OG5aUlExeUpVTldMOVJtNkpGUS9rWnRrTVhlUE5QajVER01Yd2lvRWNy?=
 =?iso-2022-jp?B?SUszejRYYXJBSjhwWHFKbE1BYUIrTEdFdHI5cEd0S2pEd0M2ci9NY1hX?=
 =?iso-2022-jp?B?bnFKdWI5eERNcGd1VVRzWEs1WXZFSTJQL3FCalRoWUo1dGw5M1ZkaUQx?=
 =?iso-2022-jp?B?MHRxYTdOTFNDQjVhMDFCazZibW02MGFacTBPYVVZdGtweUtiTkVjbnJ6?=
 =?iso-2022-jp?B?ODdUbC9DY1EvWXZzblIyUHhSVUk2Z2lVTENHUytQUGUvQXJVWEFCV1Rq?=
 =?iso-2022-jp?B?SCs5SGVPcVlsNGtsRkY2UHVSRWM0WlIzSFEydFRSVE1MM0FqVXZkOFJ4?=
 =?iso-2022-jp?B?eFVWdjlUQjB3QlVBMWJ4bnZsMTBXQmRGTUJ2MUVqNG5mU2tLL2l1dGVj?=
 =?iso-2022-jp?B?YldIUlJjaTZ3bW55TmVIcThxMDNWNFhYWXlCQk5FM2d3NExRRWNpcnEv?=
 =?iso-2022-jp?B?MXBMUzZkb1RGTllleVR6YWxzR3hGK2FWdlc4QnFYT0I5VHlibVhwbzg2?=
 =?iso-2022-jp?B?YWlmcU10azRZQ21VUC8zOUFlTWtDZERLYkx5bnE1eGVRdVg4T0t5SGh6?=
 =?iso-2022-jp?B?ZG9GKzltQ3JsU01iSXo3czRqcVY2ZmI4OUZxNkxTSUs5UU8wODY2WFZp?=
 =?iso-2022-jp?B?UmpSOEk3ZVAzR2Jya2dIR04yamtyV3lybWZodFVpNHpYK2xHK09kRHJU?=
 =?iso-2022-jp?B?NUdsY3I5ODNJaVVlM1NsWTdlSnIzWG5LV2c3U0ZRYkdxaDVIeWZtMW42?=
 =?iso-2022-jp?B?N0dlQlhSTVdOWlBJc0NtK3JtK2RSZkpaRVNBWDdXSXMwczRVZkU5MXJo?=
 =?iso-2022-jp?B?QmN2UjhwY01EeTBmNjNEMEVuWnNLRUN3dEc4WDZqM3g3bGoyNDZIMkF2?=
 =?iso-2022-jp?B?OG81NU9nOW1vTVdNdnFBcjZQaXVyWkVacnlHTUpuZFM0K0ZScW9HWlJC?=
 =?iso-2022-jp?B?bUFvb3M2dHhqYithRVAwWGN0M1BPNFdM?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RnJGTjFXN1lzeWs3NU1hUWpZVzNuNUFHNjBLMmdWVFJSS09QZjUrUkpj?=
 =?iso-2022-jp?B?V2ZjSEVOS3BrR3loS2k1TW1Xa1lHOEM4cmZ2TlJoQ1B4TkNFb25tZUJT?=
 =?iso-2022-jp?B?ZzFrVmNVUUwxN0Q5OXZYOW0vT3k2djdOWmhuWEZIVVJIQ2twTDJOUWpR?=
 =?iso-2022-jp?B?M2tCeEUvcWV3QmZBcDNyT0dkaGQ4MnpvS3dZTCtQZDZUb3pCNkw0NS9H?=
 =?iso-2022-jp?B?OVVtb0pZRE9wOVpXMjMzSllLTEhFcUExcUo5b0c5dUUrZXdhYXpOOStO?=
 =?iso-2022-jp?B?Z1FTNm81UnFaUXZhNy80eUFoMjdVYU9kTmhzYnhndExkclFQRHJFUk9a?=
 =?iso-2022-jp?B?UmIxa0grVEFnQnVzUS9Memp3T3A3VGNDRHZVTHFWcE1ub2FRVnBLTzJU?=
 =?iso-2022-jp?B?dE9aZDY0Tkp4NitFTGsyOFlNdy9Eb1RqcnhkT1ZQMUZ6c2pYU0IxcHN2?=
 =?iso-2022-jp?B?TjErdVJZZUJ0RHJLMFVJUVJ1WTRrcmxETUViK00xRVh2RHVBR3k5Rzho?=
 =?iso-2022-jp?B?VjJ6cUF4d1VBSEFZZ09kV0tzU0pLNmV4MjV5ajVxbk0zQlg5RXE5WGtM?=
 =?iso-2022-jp?B?dzJVeDA0eTRuVjBYRVBKYjA0Z3o4eXJYRGRROTRBUFhzVTE5dEtKQm52?=
 =?iso-2022-jp?B?RGRDNVlXVHhCRTBsb1FUTVlHNzJFOHRpS0tOWEZvd3dFYnFvNHQvZlMr?=
 =?iso-2022-jp?B?NmZoaGVlTHNodGZrL0VzZGt5S3U2L1BWaTNvdDIzQmVQbmd4ditHaUw4?=
 =?iso-2022-jp?B?cDIxWEZpdHBneXl0Y2lEdkw4RUtvakJGTWRhUmlWK1YyVitKZFp3M2hk?=
 =?iso-2022-jp?B?YWEvQ3BWTTZoS0w2ZUtpV1JMNjlEckh2ZDQ3VUxoMmZMNVhJekFENEJr?=
 =?iso-2022-jp?B?QzBHcElaMGZML2xObWdMdnl1Nk1QREJnY2dHbU5Vekc5KzkvbDZuZFNT?=
 =?iso-2022-jp?B?Q2dQVGt2aWtnNVJFbDBaTmhTYzljby9tQnlZc1Jzbm44dHNOOWU2aG1I?=
 =?iso-2022-jp?B?L3hncGk2ZU51cHZkUlFiQmNudzN2MUlQK2pNM0VtOG0vU2xrdVlkZkNw?=
 =?iso-2022-jp?B?MHBybDJhSGRMb0kzZlRRWHB5Q0FSZDRWcEZRL2F2aEhiQXBVVzczTGRm?=
 =?iso-2022-jp?B?d3dHVHJNV25oMzJZYXhiYnZibmNWTGpKcEViZ0FGNTVRVFNnWDRYQklk?=
 =?iso-2022-jp?B?QVdiSmYyVTNsdXFJSU90YjdSWWRiZXZzcmt6VmlNbmZHdzk3T0dqSTNH?=
 =?iso-2022-jp?B?MTlibkRIYXRPc1RpMTY0UE85OGhMc2k1WkxOM2VoMGVXRWtrVCtUUksx?=
 =?iso-2022-jp?B?dldYM2FHZzBTekdWSnFHNW9HcXNvYVVBay9GSmJIaG9hTzlDaEs2VGRo?=
 =?iso-2022-jp?B?NHpvbmxncER1d0M1RFdpaExxVXR3TThRN0RFa3NjbVRvdFNWa3hQam9r?=
 =?iso-2022-jp?B?bVU1Zmp3aEh0VENraEhjeHZBTE9rdGtaRTlTZVZhbWtLKzl1b0VqTHc2?=
 =?iso-2022-jp?B?b1REd3lOT0JIbDdROG54cW1PRkFBZVVoQzBSM01BOFl2NWp6dDd4cWRn?=
 =?iso-2022-jp?B?cXdzNHoyWHpPNFNGUTlPbVV2dkJndDYzSnRDRXI5djcvaVRZdHpZeUpI?=
 =?iso-2022-jp?B?cHFoYlZQYS9GQTdZMGUxOGs4ODErM0RyNXQzdnc4R2J6eHk4TElRaXVY?=
 =?iso-2022-jp?B?S2xDWC9EUVFBVDlBNnlkL05QbmpzUnM1Q2tlb1UwY05ILzhISkYweGtW?=
 =?iso-2022-jp?B?OVRYbStaY3VhUTlrUEdLTWc2UXRMVktQZXM5YzVrZTFyVUVHczdFdmdD?=
 =?iso-2022-jp?B?VUlwT1cra3JMMHNCRzJlSHQxZWE4d0ljeE5CZnRkKytva1g0aDVhZUwx?=
 =?iso-2022-jp?B?WmQyREJnU1lqT05YMHFlTERrYnIwK01hTUIxWHg4OEd1TmIvZDdBS0E4?=
 =?iso-2022-jp?B?bDdYR0R2MkJSajdIdjdlUTRyNFZPc2ljWWQrdXY5TC9pdXVMM0thMmtm?=
 =?iso-2022-jp?B?R241S0JPNHFrK0lrcUpLYXhMK0JYcHhqUWg3aTRMbEhZUGpmSTBnRUlY?=
 =?iso-2022-jp?B?V255eE1LcG9BWWdvLzlUSTBTZEs5NCtVeUh3NXlHdFkrRzRJS2NOYnlJ?=
 =?iso-2022-jp?B?ZFlqRnp1MGs0NFczcEJUeVQ4bHA3VTIybnA1Ukw4QnVHUVpBQTU0OHVr?=
 =?iso-2022-jp?B?TFNVWXAyTUZDQitEZTZWZzV5SWl5Z3IrZXFOWmU0NXJ2TDByQW1LZlhZ?=
 =?iso-2022-jp?B?TWsrWXk5ZVRIUnVTazlTK05oa2VGNmw2Mi92eGdKTVhaQzZnbHFBaVh6?=
 =?iso-2022-jp?B?NjliZUhhS1hwSWRjNTR6R0pSOHdHdUx2bEJlTFdHd0w5SzM4dVBmeGFC?=
 =?iso-2022-jp?B?VWJjQmZxU3IxcVF5RlFraDRudk1abVNuVSsrNHZlazBaeDdCMCtENHQw?=
 =?iso-2022-jp?B?Z3JabmVJN3FYU2xsSUZ1RVJ4MElDOTUzSUVYUmMxaXhUSC9NdnhIVndY?=
 =?iso-2022-jp?B?b0VjRU8vLzdWM0JGZStBeHlUM2lsNjA0V050RWk2c3p4YVJseDVTREdy?=
 =?iso-2022-jp?B?NTIxUXFETT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d085c833-2b4e-4e95-f993-08de4e5b20c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:10:43.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LZUY98A5Ers4BYA/qGtkjGMYFzVkQYHdYrHQGdlDWumKjkETt0hjjEsG67B18S9AKaQHlrb2YDihD0NzSp9UbRITRYxnCkTrGF3YvvZs6Zb4+d3JszARRQEUXjVyJNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:11:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21425

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Wednesday, January 7, 2026 10:43 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip v2 00/13] Add gpio keys/sleep button suppor=
t for
> RZ/G3E
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add gpio keys support for waking up from s2idle and sleep button
> > support for entering to STR. Wakeup of STR is by pressing and holding
> > power button. All the patches in this series are cherry-picked from
> > mainline.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks OK to me too.
I applied this with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


