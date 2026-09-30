Return-Path: <kumar.dinesh.h95@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA67C9830E
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 05:34:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6690.1790746496526947349
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 22:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.dinesh.h95@mail.toshiba header.s=key2.smx header.b=vbHABE0M;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: kumar.dinesh.h95@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kumar.dinesh.h95@mail.toshiba;s=
	key2.smx;t=1790746486;x=1791956086;bh=rmo6cakbZkTiKaQ+HGQXP9dVYcqUa4HMy06SebP
	uj9k=;b=vbHABE0MDmLwh1oz2H8fN4FrqwecaP/lPE0AKkSBilhe1DGbRRBqLcawXnCGhD0f2zmkH
	iuc3Ay9L/C/Gj8bmqSsnV+ttEGunjudPxUqgVN1W8BKlD5kl6JI7i7WTHykRt3Q0kNEsa0zvqLxQg
	+nNXd6byBQDIe1ZLDHBSYRKhqDUhUF+mD+4z/3C+LHJZOi51aj7+ToucVWeHyFT9EuHHFgxfM+zzs
	E5cGZNm3F0iDamy9ZvsDd5VH8lpp6cnfRrPBgZNSSJXR2jdoxY4ziHC4P8Ws663eW8rXk3iRmIklq
	JcsvsRL7oMit+LZJdIeoSH1BNU8++jdkDy1uzLrArA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68U5Yk5W739791; Wed, 30 Sep 2026 14:34:46 +0900
X-Iguazu-Qid: 2yAahSAkWuSgDtN7YO
X-Iguazu-QSIG: v=2; s=1; t=1790746484; q=2yAahSAkWuSgDtN7YO; m=enfN1BgGmxdqkNc/wgblYnwBBP+f3SlrvX+06gu6U+Q=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hvkJM2QkGzyPg; Wed, 30 Sep 2026 14:34:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Yys+M4r0lAcRN7leigPsIbQAW1bDyHkYpk2qJ9whCwDdUFaczjgIKUBGs8b7TeioEO+7J6Yo9BKJKKaEvvXvDcvo5gB12z1JFcX6qVFgqrJ/yfLmhor/SQDZPlq0ENpV0ZzAFDU2OH5owANaLWmtsk/k5mdlFSu6iIAEL3qLoz94a2FNDhU7xrp22SxkTSWiN0jPMKinPo1DDRypVyyvbOsxUw8fNIaB9dSptWbc3QPwwBJ5vXagHCmHKd3j7OEXtFO3RoCQmsTDze15vPm7455czsL6H9DdTvEZRhBqLR8nm64V0/iA6gYzYmoyQbJCjdVizGlWrTa0FG8/L4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmo6cakbZkTiKaQ+HGQXP9dVYcqUa4HMy06SebPuj9k=;
 b=LJDoiZpWGkjVy2NqaZG3KOGGqbyp0Y1BLP5GLHN9g9CIfhOf045fq9lfAWQ4kkxltdGlIFFR7+lSBF7w9/x/ATu60DpFFwEm9PBWIRz2Cvk8xQIYrEGZ0324sdRHIa9TCROPrsZkl4Q9UjrOsRajVQ5ODQeIOd/zI6+WMUjP+Pc29V3CCgMK0joBC4u2pm/q+w7HRANDQj53/fdydJWLF50t3j3a7Aits9/6B67yRUzOkygh213lfNoc2xI8E5SLkzZacIGzy1vwIQyCxKKTxVzx1pQ2bfRSrC/Gk7VTXr9fd2JBAJiBVlAeitwIyfaBd9rD3NTlCDxXFOT3eV/1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <kumar.dinesh.h95@mail.toshiba>
To: <jan.kiszka@siemens.com>, <nobuhiro.iwamatsu.x90@mail.toshiba>,
        <pavel@nabladev.com>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>,
        <arisu.tachibana@miraclelinux.com>, <masami.ichikawa@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP kernel lunch
Thread-Topic: [cip-dev] CIP kernel lunch
Thread-Index: AQHdUAkmun+3HW/X2UWDkZIjxvUw5Lbmmmkg
Date: Wed, 30 Sep 2026 05:34:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB8515E414C09282AE62CE1C79AE8B2@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
In-Reply-To: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|OSCPR01MB15895:EE_
x-ms-office365-filtering-correlation-id: ba2ac687-b2a1-4700-329a-08df1eb48602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 7MIlq4LcgbQLs8sVDELLskNPHhfBx2/XRtn+yCNyAXY8HJO1DtDPyKASZrbPHxLPgPCLKYjwIcyrrfNWUkRzQ7fdERVcNOJy4/vPi5/ZVIM144CgjH74KdCR3c3s2GW06UDdWOmuFOFCnJQ2j/MczGjXQeopd+V3dUzKxWy0I75Oy/cHLqfxokbUPOp2hIhHcgjUTorhd1Oqnh9fN2eKWaILd4sUWk/OaSRutjv000shb4V/1RuNuUJr+D4RqBNSP7pFD/v4DMgsVmnxaW1tBvwQiZDl6KcNfiZMQmfBVGQFAF6AvsHLBzUg6A/NuzPQiWp25KrdWo0h6Urwr+gD4aX55QvsCh2cenLdYOMitQfVu7EemoCs/nAdSKloO+ZSTq3oA4cy8LqhCHaBFjWvEGMzfBTKEhPfKg9IOikD3vSGMOg0yOV3ryir5tUg7VrQqdxSGDWvklksvQBTUVRP6KQtA4thRTnMtKDR6nYHKWn1Ny83C7zgaSl/CZKX5AGgf1kbi+me2CleilnXTMGnjKhvhF0zPe9ZbX1llvEg14Vxtas1VWSTaITRDT+IxfZ7r1FEMPwG/PHt21XQtPJwMOF+IUUUXJ6e6IvJwsCLLEM2u3dY4tCHDXJYlFMV8Yad3W7E2Jen46hG9Ca7sf8m5cGWZdpZiKU55tWZb0I7l93fRELroIsLnnsGH1mbcswzC+TDgjMWfCfdcfg3ukWAaA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZXRHYVlqRTRBYjdGN0pBS3lNVVJxampjV21XMTZiQ3h4Qyt6anBDbm9GM241?=
 =?utf-8?B?c2JFV3NYM2Z4UXpkZGllRUpTWWo2eHhTZHdSSlFROHVTN2NjekJnR1lZT3pM?=
 =?utf-8?B?WUlBUUpvc2xTSmlIc1AxMkVQdGRHdlc0LzhqU1lVbVFQdWF6S1J5cjl5dkRH?=
 =?utf-8?B?SDFSSjh4OEV2enZYVWdGeTVIeW1oNHJlNWljMG1KYzMzTkJhaGJsQzFTVTRF?=
 =?utf-8?B?RGllUHJjVURCLzJhamp6YXdHeTM0SlZqaG5qSkxUMmNlSEhqa3lIcFFRY3Bs?=
 =?utf-8?B?bHpvWHFPZFc1WkZWL01XREZPOVdGU2RiNTdmWmExb3JtVGRpY3JrZTdnUWFt?=
 =?utf-8?B?cHFyd0dJdE95Zm9ya2c1bTBuWStWWjZvcEovSGR3WkdIeHg1SlFVV1d0TzE0?=
 =?utf-8?B?SCtUNXkwRlNlOUc2bURHbFFLMlZSTDJIeXprbHZ0bk1Hd3Y4U3lmVU03NjlK?=
 =?utf-8?B?YlQrVG1LL1E5SVNsaVZHQnFHa0ZnZm1teE1pVkN0Nzg3YzRuUW9HOU9US2cw?=
 =?utf-8?B?ZzVwbkQ4NWl2eitwYVdrSTc1TXdXK1ZWMUV0bVA4eGQ0S2hpTFBZc0ZoSXN5?=
 =?utf-8?B?VjlnRzYzZS90TUNqTkdIa3ZNYjlTY2FUNGpIOTNXOVFSbHN5U2VqcXdwOXJR?=
 =?utf-8?B?SGRMaW9FTDQ4MXZLMjhvWUcwL0RlSDdUVjZpZ1VhTUZ1QjlNNkZKdndTZUJl?=
 =?utf-8?B?ZlhSS2hPNDViMDdVc0wwbTBTZ0EyZ0xUUDJjaGVQakJQdXZRL0FOSVVqUGI3?=
 =?utf-8?B?ckdLTU1vR1dtWVFGN1EvRDYzZnIzQVl1NmtkVmY3TUtuOVYxRmpEckxRSElz?=
 =?utf-8?B?RUU5NjRPRk4rQmx4ZXZ6RDloUGEyOGdjVXVwaFNMckE4dmRpbndhVkRKakFp?=
 =?utf-8?B?OXRWOW5zU1BZTmozT3FoWjZ6VTN4WUZPU1FIMElVWGdDZFZCUCtURXlhTXBr?=
 =?utf-8?B?b2x5cU90TmMwbUlPWUlXc2g5TTBBbFZiSWM2L1AzMHBaRjI4cDNkR3d0aXAr?=
 =?utf-8?B?ekZ5c1NiVDg4MW1xOHkxR1REZTNxaEo2T2JhSEx3SVFaSnVCTlVVV3cvZldz?=
 =?utf-8?B?KzRyZ3IrN2JTQUxLaVV5NjgxMm5vMjlxQXZPb1NSMkxWblJrcGdaQ0VhdUlF?=
 =?utf-8?B?S2hFWGNEd2hVWGxjZzUwVVNvTnljd29oZUxVUGR2OUtVQ0lRcWxlL0tzZWhl?=
 =?utf-8?B?c3NwZyt2dkc4NGEzQjJHZ3NyTXQydUVvVHNlcDZ2ZXpMcG9HWnBDUkRmME9R?=
 =?utf-8?B?a3dQdVAwcmV2ZGhrODR6VDkyZkI4Z2tRVWtVVE9ubHBlWmd6ZzJoZVRObTFT?=
 =?utf-8?B?VjJ5TUdLU2ZsYWFCUWJDN3N6RExGeStsNUZEcUIxTmJVZG0xdzFGT1RXYXY4?=
 =?utf-8?B?Nm1uMExlNGt2bzdUYzJlQWpFU3U0dTZkK3E1b1lMaGFLazVXSVYreVJuTUkw?=
 =?utf-8?B?Q0tZQlJ5Y0ZIanZHK2pZK2ZDdzlpa1QvdDc4WXdNZ0xyV0NTeGRYcEp6Zmt3?=
 =?utf-8?B?UllraVYrV1Z3aDJhYW9sR003ajNobUw5aFJrOFpQMzRQU1RBbnlIMFd1OVcx?=
 =?utf-8?B?TU44anlWNGhSWmpwTnBMSmJ3WEN2RGVyOUVHMFJZRDBjSk52VC8vTy9XL1Fs?=
 =?utf-8?B?R3ZRZDFuM2tSZVhiSzB3dnRxVWNtU0x1SzUwT2xsWXJobjJ2ak1jUGtJUkdG?=
 =?utf-8?B?dUlIQWVqMThzK1djd3RJUWhCdWF0ZWgvWGFjQi93NjBKY2prNXhSbHViQ0Fk?=
 =?utf-8?B?SDdFOE5BbkU1dzFiVjlXUkJST1ZMYXFHUXBya3dHRk9LdzN1MzQ3OHhTMVI2?=
 =?utf-8?B?SHorZ1BDcVpsMWw1NjNxTWFVU0Q1NmFqbE5xNm5hcDI0WFc2RHNiQlJENEdK?=
 =?utf-8?B?OU1GYTNMMFdDU2owRnJERzhDcWdiM1kwMVdNaGIzd25lc3RJdUNZTlJKN2pW?=
 =?utf-8?B?MUxjYW5tTGtoTFBYNytycy91SnNkampVSEJlZG1ueXBxeFVLdk5sSGZHUWFB?=
 =?utf-8?B?OURTWTgwTllWZThhMDVDQVZWeVF5bmxVZEFOaWFjY1JLZmFRYkV4SThXeW1K?=
 =?utf-8?B?dVBtTTJxUFhGeUJIcFY1Q0pvR3dXaUtlSHhvRUpFeXVMSTRqQlZYc0hMT0E5?=
 =?utf-8?B?QkRZTGt1KzE3UlRFNm5XUDh4Ukp6Y0dTMmtCdjhYc2ZpY2F5Nnl1UHBST29i?=
 =?utf-8?B?M0ZtUXg5VnFITDhPQitZa0hRU21icWZPTk1IWUs3WjRCcVRBNmFsZXVvWHZo?=
 =?utf-8?B?blJybjVsbU1BR2pLb2tqYlh0SWRVdSs4bWZzT080TzBvV2QyZXdxMldzQjlI?=
 =?utf-8?B?TEk5aHhtajAyZWFYRjE3eDd4RklNUDIzOENxZERkMFNtaXhlWFBDQnpjYXlF?=
 =?utf-8?Q?HsXvsV0E4ECXp3qQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	1D/E/WRY6X0FADuXiSjzF05Urg3TGSIsVLQ/isMCYfUIkN0MozTDxT9aNUe8x1Nfve1sXvUdvfgqoe77Yjl8zRCSdP47ZUit3Ha8GSKJvx7VwK60OicFGjpgz1Jpsrym9IMNsv/Q+j7nk5Xz3FEJGHAVn10V3Dd8wcVwpPjwU+eqvf26/Mqk4wt0jJfmNXE1LWwcS+jt956c+9lc81qCRYums1GCtfwvOEtFCdSEQrnTGs9fCtoXhKuWfs5XiH7leDwbJwG0yH+1TPG7wPzx5eP7Wt8utGh9zGo32Y61La8MedJQnxadqUrHebrE+qcp1AOYDS/rdNj11PWFjkw1mQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2ac687-b2a1-4700-329a-08df1eb48602
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 05:34:40.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zr/udN68A65tMW11PHWFDw31eDXVE293v/WomkXjl3phV672sC9W+gbLOtJ34CK5d3iW+hAUgEIy/2qYnxmlbIqQu4qEWMwKMB1smIXITDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15895
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 05:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24377

SSB3b3VsZCBsaWtlIHRvIGpvaW4gYXMgd2VsbC4NCg0KUmVnYXJkcywNCkRpbmVzaCBLdW1hcg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgSmFu
IEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMjksIDIwMjYgNToyMyBQTQ0KVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg
4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwu
dG9zaGliYT47IFBhdmVsIE1hY2hlayA8cGF2ZWxAbmFibGFkZXYuY29tPjsgVWxyaWNoIEhlY2h0
IDx1bGlAZnBvbmQuZXU+OyBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMu
Y29tPjsgQXJpc3UgVGFjaGliYW5hIDxhcmlzdS50YWNoaWJhbmFAbWlyYWNsZWxpbnV4LmNvbT47
IE1hc2FtaSBJY2hpa2F3YSA8bWFzYW1pLmljaGlrYXdhQG1pcmFjbGVsaW51eC5jb20+DQpDYzog
Y2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQpTdWJqZWN0OiBbY2lwLWRl
dl0gQ0lQIGtlcm5lbCBsdW5jaA0KDQpIaSBhbGwsIENJUCBrZXJuZWwgV0cgbWVtYmVycyBhbmQg
YmV5b25kLA0KDQppZiB5b3VyIGFyZSBhdHRlbmRpbmcgT1NTIFByYWd1ZTogSG93IGFib3V0IGhh
dmluZyBsdW5jaCB0b2dldGhlciBvbiBUaHVyc2RheSAoT2N0IDgsIDEyOjIwKSBhbmQgY2hhdHRp
bmcgYWJvdXQgQ0lQIGtlcm5lbCB0b3BpY3MgYSB0aGlzIGNoYW5jZT8NCg0KSmFuDQo=


