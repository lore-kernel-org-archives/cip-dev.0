Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C5BCF6BF8
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 08:08:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1489.1767773317458873980
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 00:08:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=tlvlnlSD;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767773299;x=1768982899;bh=U19NSyrsfrQ7sZFfEyRBFTLm5HWaJmZWBHcAH
	41Ttl0=;b=tlvlnlSDHhKr7L4h3CoFQ96I+LVqKnXhwpBoGP441s1tMrZyE6DaxFmbKFfOiC+D5nf
	P7K2+HkD7Uy4h/768pclGdtLbIKopZAgRK2LSzkqGa38+kX/SscpZfxKOAtEElmUGilxa0ZRdjvLt
	egD25VYHi+fYXIL0ZXexZzctHBpgzKJ1bGA72hJhSWUyRnN9zOETQUwUR+7jQ07ly1r6hZn7VDZlv
	jXpcrT/45Rvfytx+A4b2ktXyuIdWxE3+P0IIYlxuNrekRe/75H54oE09DnMhxa0CuhxKweQkZbI37
	Kbk9K7drEEq4cI+o08y16aPyAcH+zixrgVguQfFCOkZQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60788JdF3501333; Wed, 7 Jan 2026 17:08:19 +0900
X-Iguazu-Qid: 2rWhnGXnD0Pnv2Eg4T
X-Iguazu-QSIG: v=2; s=0; t=1767773298; q=2rWhnGXnD0Pnv2Eg4T; m=kX5Ih2ACyIRoP/lrA1DihtJMQvUlRd+3dSgfPIRSduI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dmLJL2M4Kz1xnc; Wed,  7 Jan 2026 17:08:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE9SK2axlmuLwKkLsmO0GUAnhJU1J4yq0r5SnpXtbB9dGdm/nC+RRzxprGfVheZloVA/6WJAgFKJjBo5tTQ9WVs/It82d5Jr1RbxyP8MNOfaKAOmUwXCA9tk5lXJSjFe63uDwWt8B2Cd1np+0b4dl5yHVDRC4OSKzzYkHXfO4IT/YIBvkchCI/M2LLSjhstIICQpj7H9Gk9WboI9L+jjHx+ThE/48/8wV7UoSTKV6/3LsSngNoj7qKJbvAGCphq8i4Vcl39GEPEeLHl0fIBRI8cKlswpGn5P4hFBM1Ml85/Vpm+bGX+A93K9HIpqauTstxi+ZCD6pJT2yQV1HfaMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28TCM9YwRO2J7u8gBwekQqsKxa1yRnFZIPJhMrcnS+k=;
 b=dfE4aLtCanqs5OPuDGhb/PfdcZ2CYXFJmCIZIC0RmyqJbOvMfROull1rQAt+oOiCYDVQ7YphrDY5m6iMLN6N2EobuD+9xrfV69MmDkrovZ0azvmQH9WE5sOGyln0h3gt69dsuwj0F/m5/CcVdSlDfNzLL/7xPV4g2RK4qd2iHNMzxkLSuPm5iG7huySoojqI20W5Yoc6CcF7oHr5+aQk0UcbFIHbdydG37oL0yP40n/JwMlWheifoPG4aLaEIv2oGNC6lobFxE+6zCFWySfIty5jbzA8YSq3y3iR6+XP4eUsm7tryefNc2PYNSZU72OaGRggv24F/Lz8HYo8iOek6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <biju.das.au@gmail.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add
 .init() callback
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth:
 Add .init() callback
Thread-Index: AQHcbyL4DmJjqOqchEed88ckdIQ/A7Uxni9AgBHGC4CAAxbbcA==
Date: Wed, 7 Jan 2026 08:08:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A82CD7ED715901F511C6CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB148186310F13C51C8FCF15658CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346085A1D0ADA73A4FE5AC08686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11346085A1D0ADA73A4FE5AC08686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10666:EE_
x-ms-office365-filtering-correlation-id: 71d1f6e7-b1c3-477a-9b83-08de4dc3e8d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dHgvUjYvSnRQZkdwa1ZWV2RhcUZKTGRiOFRWM3IzWmQ5RGpUY2lveDVw?=
 =?iso-2022-jp?B?SjVHSURwUE9DMHc5Z0NKS05OWGRKQmtXcnhRMEhWUDZGRGZHanhkR0V5?=
 =?iso-2022-jp?B?cDNxYUZaSlFJMGVDbkZzenpsa0sxVlZrL2JTUnFYaFVLd09ROWx0T2Ju?=
 =?iso-2022-jp?B?VTBiSTRUaVhJeU5hb2lQU21jY2xXQVdsQU9Zb1VETmlMcFBDL3Z5NE5T?=
 =?iso-2022-jp?B?dU8wMTBlM3ZMT2xOKzAvWlQrL0h6b0JNcmJpZHFLeTlRLzN3UlVnSlpM?=
 =?iso-2022-jp?B?bFY1K1hobHZDWlgyUTdBSDV5eFYrUFZzcDZSQ21sazE1Q24yNEdBRFl3?=
 =?iso-2022-jp?B?YWFTd3JWT1J6bVdmb1YxMVpZam52VHpnTHdWK0Z0NVNOdmNFcWwzUXZo?=
 =?iso-2022-jp?B?cG5BanAvaFVvUnA5R2ovb05qK0JYZTUwanpYUlRoM2FNaWcwNkxxaGpi?=
 =?iso-2022-jp?B?ZURoNXBSNDRQK1FxQ3BHZ3V2RG4wdmNvU0syL2dPL2RJSzZ5UWw2Zit4?=
 =?iso-2022-jp?B?TTZLdjNUd3hhanZ2M0JwaTJlRGdmaUxyVTRTblhITVVLcXlJMVB1S254?=
 =?iso-2022-jp?B?SUNodGhLbVkzSzI0WERkV01mdWpMZUNwT3MwSTRoY0tDWDBZOExMRVNB?=
 =?iso-2022-jp?B?VG4wYkZQdGlxKzluZUU3VU9JY2V0RnN2RHA0R3Z5N2l6a3BnTnZENVVm?=
 =?iso-2022-jp?B?bHNsWHFwcUtiT3l0TzZaMVEzakV6eW8yUlVmU1ltVGxGM1ZEVE11VnU3?=
 =?iso-2022-jp?B?anFZbEplQjJ0cW5QVFZSY2lLaEdSUk9hdnFINVd3SExJY0VnQ0M3Tndj?=
 =?iso-2022-jp?B?RUlqcEhrK01FT09nd3NUdGUweWZOdVU2dGRIUW1nQ05WcUozM2thSUNK?=
 =?iso-2022-jp?B?R0dYYVNlWGx1UFIzbDFpd0ZxeFRKVWd5aXd0dW1Ed0FWZTJoYVM2NjFn?=
 =?iso-2022-jp?B?SWpIaXlwRHZMM1kxd0JHcDVhbUg2NnNMYUdhNk9za3U2bTlVc21HRlgr?=
 =?iso-2022-jp?B?a25sTHE2ZW13bTd6NEJZNWRyeEsyLzdGOFh1Q2E0YWNHenZxNWY0Y2t3?=
 =?iso-2022-jp?B?NFFIQnpxUExMdmI5Tm85MXdpOWs0Skd4WGprOUtnMXpNRzNUTUZrdjVF?=
 =?iso-2022-jp?B?U2dDLzJPc3dCSCtTRGp2VWQyRzhYWDNVQURFMFo1QkdkOXNiQVVmbE9U?=
 =?iso-2022-jp?B?VFJCeGJlQWlIWHdmZG5MUWJGbXN5anRqRFBWVWxDaHNrYnUxMng5aGhF?=
 =?iso-2022-jp?B?NVViUzFRMEk1YmE2ZzNMRVcrUWZDVXJTSWRoV0FXNzlRcXlZcnAvK3J1?=
 =?iso-2022-jp?B?NGdXS0F2enFreG9XR2dITkNHM2lmWm44ZXlYeGxmM0tvSHNyL2JJNjE1?=
 =?iso-2022-jp?B?TzZSUzJ0dWI5SlRFcmVhOUtoeFpucjBWbU4rTjk2VFJJSHJQUys0NDc2?=
 =?iso-2022-jp?B?T1JCKzFTTVJ2SnoxcFFqMmtUbGk0Rk1FVjd2SldNSHgzYW5PVHRBNm9l?=
 =?iso-2022-jp?B?d3NkVFB6b2hJelVjdFNQYkhKSGw3cncxWW9xaFdZSGZLVTNLakR3d0to?=
 =?iso-2022-jp?B?ZjQ1WXpTTXViSldZYjlGWXEyRkVHS0RrTjVKYlJSOG5DYTFrQ3FKMDR6?=
 =?iso-2022-jp?B?cG4wTURRS2Y0ZUNqcnFnYlFaaStSRFZGUE1wS1l3WTA5ejFGcmJyRlpS?=
 =?iso-2022-jp?B?TmwyQkhVQkFDS2k0d2dpTzJoL3F5RGo3dFR4VVgwWnhrUFJhQXNCYUdN?=
 =?iso-2022-jp?B?aHMzYXBoQjhzVFdySjlKRnBNSEhJTjgzdDJXbjIvVnlkN3FmUmNjM01U?=
 =?iso-2022-jp?B?V0YzdjcvcGg3WVA0VzZIckJnaDNnNHhrczZTQ3RUU2dxMmtpOXpNSlcz?=
 =?iso-2022-jp?B?Q0xjYlE4Wi9nQVVoaXRGSGJOeEJVY1NXdnNiTlFKcnZBazlxcnpKQTBv?=
 =?iso-2022-jp?B?cjRFbmVZOWtvQzdjcC9uak4wbzRndVZtWTVTVURVdEt5VGVDV3N0N0Fs?=
 =?iso-2022-jp?B?QUtKZVdZQkRpYVdZNVZQbHVNOVJBMmw1N0RHb3krSFFlNytoWUM1dGc1?=
 =?iso-2022-jp?B?RFJybFNBV3M3V3VscEc3OUh4dTBGSnBwWklJOHpHM2czR3JTaHpMUmFj?=
 =?iso-2022-jp?B?S0hDVzUvd0p1VFd5dU5UM01jd2RDK0pMTWNwTmlieHhCUXdDL0JVZElQ?=
 =?iso-2022-jp?B?T1JQVDZqRTk2RU9INkdkQkdDOVozUGYw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Wno5QjVJano4dmp6ZlRIb3gxdHdiY2lVbGl4TG1BSUJRQlNRUUhhWklk?=
 =?iso-2022-jp?B?K1F6cXkyL0lIdnZrdnkrQ1JNMDQzQ1hGOEY0SU5CTjhnM2xpb2pieG9P?=
 =?iso-2022-jp?B?OG1tMERvbXdmWGI2WmRZTzQ5cFZWOHFaYWdDbktPWnZkM1FZVmJJMTZY?=
 =?iso-2022-jp?B?YnY1b0lLMUJzMUorZFBtZmFUR1FZTXNKcWYrNXNNeVJJcEpOZ2QrczFa?=
 =?iso-2022-jp?B?c0NkL2ZUUUFTRFRyei9tbnJqQW94elpaaWhMYmJZRU8rcm5VbXVibHZV?=
 =?iso-2022-jp?B?SDI4MHROZ2ZaMmtNUUhIellxRzZRQTVONGt2S1A3VUlTZzFUYUg5ZFVP?=
 =?iso-2022-jp?B?YVlHS296Sm13NmxIUFZyN1dqdHJhR0g3V0d3UDd5b3hnNXFvM3JVeWFo?=
 =?iso-2022-jp?B?L1kyZnQ4aUhNVUhjSTNKZzR5RVU4bWV5QjNhT2dXbzN4MHp5bGRVYU1h?=
 =?iso-2022-jp?B?dmdrcUhkUU00K2dQREJ6RjhPbDhaZGFSeHFJaEx3MkNjQWVqU2tpdndH?=
 =?iso-2022-jp?B?R0JhZ0ZQK1N1TlpWSzUxdmwxRXBIa3k0TnBqMm5HZUtjYTZCSnpHaG85?=
 =?iso-2022-jp?B?ZnBSdEVzSFlEWFU1aEFHbis4aHhnanVVejIxZWFCWGJJQWQxS1R5SzFQ?=
 =?iso-2022-jp?B?V2V6elMzZEdnSGtPaDJzVWlvU3h1aldEUzRnU2JnY1ZVb05lMmluNFZw?=
 =?iso-2022-jp?B?bmZKN1NqbVRvK1FUS0lsWTRsY1RsRkNGNFQxcENYeHRBb05XQXFRSFhj?=
 =?iso-2022-jp?B?QlZhT3cydDl2dnpPMXVNL3hYUTNBSlMyTnNERGdNWDRyV3dUQkRHZk41?=
 =?iso-2022-jp?B?bTE0UXA5RUpzU3JnS2Z0NTVSRHhnc3p6R28rYXV0UU1qblNJVFE1TnVL?=
 =?iso-2022-jp?B?ZzEzVGZDRC90NW9iajREOWdRYXNMdk9qUHBXa0lOb2MzZEhLY1dEM0E0?=
 =?iso-2022-jp?B?cnc1Y1JZbTRHNEVVMkRaNHNydThjaFk1djZxN1VrbXNzNlBNNHUwUHJU?=
 =?iso-2022-jp?B?UmlqbGhwQXBuUUp4RlcySGhjRy9QNG1SQ1pWQ3E4bXBMTkxrUEZpQldP?=
 =?iso-2022-jp?B?R2E3T0xIR1ZtVHlLb2pnR015QXlzVkVEeDZxTGJSeDd2dVZobU5ONnZF?=
 =?iso-2022-jp?B?U3VOOXp0NCs4OFdFWUU0VnhWWWFKVkh6aU14RVRBdno5bXh2SFBITnY4?=
 =?iso-2022-jp?B?MU5lbVk5SlF5b21OM01keWVKUlZQUk5uMDZ3b1RRRWgrQVVQbStCVURT?=
 =?iso-2022-jp?B?S3U0d3BMRDI4bHp5MUVja1NYM2t4cmxnK1RTcnE4cmg2VHZOSmw0RjFk?=
 =?iso-2022-jp?B?V21JS2hSZnJKRzI3ZldndW5pdS9SMjk4WWx1Z1g4KzAvOUU0Z0dNRkhJ?=
 =?iso-2022-jp?B?bWZXOXlMRml2azFadk1qOHhtQ2Nyd0p0THVUWHQvSTl0bDJsVXFOeEt2?=
 =?iso-2022-jp?B?eGJoLzNLOTN2MjYxVVFZbUcwWXFtUTJkUkZyUXo4aS9hemdUdzF0bld0?=
 =?iso-2022-jp?B?M2VNTUtwY1Nvb3JDbWlFdzVJRUJqSzZFOW1Vd1p6NDRuZWpBU1U2bTF4?=
 =?iso-2022-jp?B?a0hka0FKS2U1TEE3YTQ2Q0VJVDJTVWpDdDByTlkzeWk5S1JKVWExc3dB?=
 =?iso-2022-jp?B?aG9GYk9jSmhZdWtFaDBHd0pLNHpNczQ3N1pUOFd1a0puMWpoUGZDbDRk?=
 =?iso-2022-jp?B?VUc5bWtuMTVVZ3BWQllnaVRnQXZ0UTAyMUhFZTNhNnYzZmtSc1g3Uktu?=
 =?iso-2022-jp?B?Vis2OHVRUXlNOUNjRUR5NGZLVDJ2NEdveHBZWDdmM0lWbGhDa3R0U0Fk?=
 =?iso-2022-jp?B?Mll1dWVSaHdGZDNQRUx5MkVmOTd1UFpUTlhNRkF5UFdNSWxETVFWMElv?=
 =?iso-2022-jp?B?WlJSemFPdVdYNnd1RFRhdnpEeXpDbmxHa2d4SytzZENhTE5DNUs4bVAz?=
 =?iso-2022-jp?B?ZnQrM2RhNlRjQmMxQVQwQU1DUTZ5YS84VDVOLzRCV0t0YXl1VUtobnRr?=
 =?iso-2022-jp?B?Tk9EQWhZRVNJRnFYcDhoUXBaYjZtMko0V0R4RENBWjg0ZHJ2VFZPWVFN?=
 =?iso-2022-jp?B?QzUwZkxXZ2dNMU5TZVdpVkdnd202ZGUxaHdBMmdGQ0JGZGVNYUdkYWlw?=
 =?iso-2022-jp?B?Rm9WbmJYZ2M2QzlrQk9SOFNJVWtKUncvbjFEb2ZKdjVqMFFOLzgwZHg3?=
 =?iso-2022-jp?B?SWR6RDhWME91Y2tQV0I2RXJoTnFobUYrK0FMZ294L0RXRjMwNnVyNENV?=
 =?iso-2022-jp?B?NkJCRXh4dXhKNzVvTVVTNVIyVWpFVmRZakNjNEVPZG12ODBNTmdUTXBZ?=
 =?iso-2022-jp?B?L2pEMkdOTkdVRTYxTDE3NUh5aiswenNsOThQYklFOUkvS2hWRlVyeS9Y?=
 =?iso-2022-jp?B?Qm02RVUxYVBNZnowY3NNZURZRzlhMXoxT284SlhSWlczOG1VUHRhUlpo?=
 =?iso-2022-jp?B?MEtLRHNqMysrcXEvTVhUY0x3dU8xRjkzQlZ3ZXZMRjk1c0JNdHlNQjBv?=
 =?iso-2022-jp?B?alJCcUlGbzlCUGZ4TUdoRlVhL2o4UGdiRnljSithUXdCTERDcnJUSlRR?=
 =?iso-2022-jp?B?MDE2YTl3Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d1f6e7-b1c3-477a-9b83-08de4dc3e8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 08:08:15.3186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dQHrDiiIvYkZh0W1s/x8fdHYmtrc8xJUYXlYTkhP6dXVWDcT70JGjue2RbQNb4AiTtTRKoO2//7dIo7mGLvPxz59NPS5fuGM9EDt/lAjXJqjviSmCKJ6UolzIkYL9PF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10666
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 08:08:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21396

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, January 5, 2026 5:57 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; biju.das.au <biju.das.au@gmail.com>=
;
> pavel@denx.de
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth=
:
> Add .init() callback
>=20
> Hi Nobuhiro-San,
>=20
> > -----Original Message-----
> > From: nobuhiro.iwamatsu.x90@mail.toshiba
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Sent: 25 December 2025 01:37
> > Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac:
> > dwmac-renesas-gbeth: Add .init() callback
> >
> > Hi Biju,
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Biju Das via lists.cip-project.org
> > > Sent: Wednesday, December 17, 2025 4:01 PM
> > > Subject: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth=
:
> > > Add .init() callback
> > >
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Currently clock usage counter imbalance occurs as .exit() is called
> > > during
> > > suspend() and there is no corresponding .init() during resume().
> > >
> > > Add .init() callback to support balanced calls across suspend/resume =
cycle.
> > > While at it, avoid code duplication by reusing renesas_gbeth_init()
> > > in renesas_gbeth_probe().
> > >
> > > Fixes: 709bdc1cafe2 ("net: stmmac: Add DWMAC glue layer for Renesas
> > > GBETH")
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 37
> > > ++++++++++++++-----
> > >  1 file changed, 27 insertions(+), 10 deletions(-)
> > >
> > > diff --git
> > > a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > > index 42cba9dd967c..5c591c7215bb 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > > @@ -31,6 +31,28 @@ static const char *const renesas_gbeth_clks[] =3D =
{
> > >  	"tx", "tx-180", "rx", "rx-180",
> > >  };
> > >
> > > +static int renesas_gbeth_init(struct platform_device *pdev, void
> > > +*priv) {
> > > +	struct plat_stmmacenet_data *plat_dat;
> > > +	struct renesas_gbeth *gbeth =3D priv;
> > > +	int ret;
> > > +
> > > +	plat_dat =3D gbeth->plat_dat;
> > > +
> > > +	ret =3D reset_control_deassert(gbeth->rstc);
> > > +	if (ret) {
> > > +		dev_err(gbeth->dev, "Reset deassert failed\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D clk_bulk_prepare_enable(plat_dat->num_clks,
> > > +				      plat_dat->clks);
> > > +	if (ret)
> > > +		reset_control_assert(gbeth->rstc);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static void renesas_gbeth_exit(struct platform_device *pdev, void *p=
riv)
> {
> > >  	struct plat_stmmacenet_data *plat_dat; @@ -91,22 +113,17 @@ static
> > > int renesas_gbeth_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(gbeth->rstc))
> > >  		return PTR_ERR(gbeth->rstc);
> > >
> > > -	err =3D reset_control_deassert(gbeth->rstc);
> > > -	if (err)
> > > -		return dev_err_probe(dev, err, "Reset deassert failed\n");
> > > -
> > > -	err =3D clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks)=
;
> > > -	if (err) {
> > > -		reset_control_assert(gbeth->rstc);
> > > -		return dev_err_probe(dev, err, "Failed to enable clocks\n");
> > > -	}
> > > -
> > >  	gbeth->dev =3D dev;
> > >  	gbeth->plat_dat =3D plat_dat;
> > >  	plat_dat->bsp_priv =3D gbeth;
> > >  	plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> > > +	plat_dat->init =3D renesas_gbeth_init;
> > >  	plat_dat->exit =3D renesas_gbeth_exit;
> > >
> > > +	err =3D renesas_gbeth_init(pdev, gbeth);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	err =3D stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> > >  	if (err)
> > >  		renesas_gbeth_exit(pdev, gbeth);
> > > --
> > > 2.43.0
> >
> > Looks good to me.
> > I can apply this if testing is no issue and there are no other comments=
.
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/223210
> > 8556
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Gentle ping. Can we apply this patch.

Sorry, I just applied. Thanks!

>=20
> Cheers,
> Biju

Nobuhiro


