Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF70E78496
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 21:20:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.128157.1766611212477212722
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 13:20:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=YWcvrCkn;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1766611195;x=1767820795;bh=PWMCcd5Uj/8POBizGGPxFcuJM/VX9ahip/vuE
	A2coCo=;b=YWcvrCknUU8HHH+xvdHqMkeFK53P7EGh8X7RPe11VmIljwo9sBaZ0CvF2VmaSW0T2rX
	YANpzeac3qTOUsajy7TIlpbvy0n9lMcNuipa1IiX58ARgt4v191LMet3/bZ1Dpap16V8rxzsAHjjr
	A2AmcYperpSOzvsIUIx9wJrhEFnAiBo9OR0vjBKb0kdcIC7rHaRSiZ/Nov8PmfHyVSG5lizbsDWR8
	XTFjqK1ja9xorqXTWsClu9Wy3PSouEOJkiBJlgZGrX+bsy6cpxOjVzLj35D0ftlfCBrPF5zi5dzLT
	WNGdEe1G7xAYu46kTMX9q1d3lxorewkw+C0rOI3VAHdA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5BOLJtmL3976403; Thu, 25 Dec 2025 06:19:55 +0900
X-Iguazu-Qid: 2yAapjLoQAMYR5eGIr
X-Iguazu-QSIG: v=2; s=0; t=1766611194; q=2yAapjLoQAMYR5eGIr; m=mpxYxSRZxRGqQRm9o9JHZStXuHaLucaWkCdQ3T7PO8s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dc4XB1zSgz1xnZ; Thu, 25 Dec 2025 06:19:54 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8s1H2dSjS2GBFmPXfxWIGEFNj5f3A4QRGPDIapxBxMHeqTsiGlG7V2jd37TboV1Cm7EH8dgMDFCtD0vDYOfv2bH4yThzrYZzIR/PTd+6VCK5jlkIe3o7gniZfrr7leCIzjDoTt7pwoToWza937+twDzsiZSNcuHE+NQVghXk9pkW2fVhmiUcxh/aiK8qDf/pkL3GlT3oHqKmgvMtjA/sLDc4i44ZeXjtMVIdVaGo8j96ElJnrG2aCk8+VLyQb0KbyJowFGVeY7qrOozzILgGQtmeFcw8NH7QeYaUeyVKh1xsAnVxBh6083KqWBixjTVg21dHn12sttNI/LsUe+C2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9AQnGND4TgDtuhMlznIoLKrtxgB0SDDBc9mpub1Tl0=;
 b=BPiMwHlfWkoIMRHJ6LY5QUQG2mznTTMXe0b+nwJreQT2hnCVyY7YczWSfGJleK4QSDyakmgzTigV0A4l1ip/msljKX8QaoVTxkCLZ/pzI8bZzrkTuHtn3hz0Nuc5TF8T5sOlX7JTw3Xm9PmVPz41ptQbJPMNWsBfAHvZNgbGcmFn0J9JECEbBZgVsdx+HGiuYiacjbuoc2O2KQXE0UGA77UtLzD56wMhIK/crulo0Xh8+q2PZBjTiN9JBVIKDVzZ501IleETx3WhO4myXEnc5v55vojBqFxbSutC8eAK/iaQ/7jnGc61ih9sP6kX8fzgu69KP1p20iJjN1ko0/Ofrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <biju.das.au@gmail.com>,
        <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Topic: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Index: AQHccOMgldaLwgJTckC1CNQRTLYfTbUwRZZQgABIdACAAMMnoA==
Date: Wed, 24 Dec 2025 21:19:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C14C2178B54B956B9B90CDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
 <TY7PR01MB1481814158E5E8E076C44B8DFCDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134650A811981E9B7EBCC1CD86B2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1134650A811981E9B7EBCC1CD86B2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB7128:EE_
x-ms-office365-filtering-correlation-id: d1add6ca-e7b6-46a4-bf78-08de43322d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?c3FhbFBoS0M4azdYaGdoOENUSEJ2TFZkN0x6bXhDZDNETkt3NElBWjN0?=
 =?iso-2022-jp?B?SEJJWXZPNk0wQysxcEpPRGV5cVdGQUJLc25kZ3Rrd2lQQ2dVMXpNTVBz?=
 =?iso-2022-jp?B?UEhsOHBsWVA3MHQ0Y2o1LzhRQTh5b1VZZ0w0NVhzNXZOVmJkM2VmMEtN?=
 =?iso-2022-jp?B?Wk9RK3hIM3lKdVMrOGFBbFdrQ1hrMHVTNHBxVS92N1E5b1B3N2ZWSWNi?=
 =?iso-2022-jp?B?RGdTWVZ3YWVWWTNIYkVzeDFGYS8yS0VBaXZEWDdlQU5iTy9hdXFUdUNo?=
 =?iso-2022-jp?B?YjBOQm9TbGloWkNseFd4S0hFdU5GY3VsYW13M1oxUjZxbnZlTFhiVlJS?=
 =?iso-2022-jp?B?SjJiUHRtczhTSVVWelhFaDdUTXVzV05RcnJaaEJCMDhTUld6TjBGaGcx?=
 =?iso-2022-jp?B?UzVhZlkrUEdPbHR4UXo4aHBwc2ZYcytaNFA0SGFNR3JjcHNYaFV3VDFC?=
 =?iso-2022-jp?B?SUcrWjY1TGx1RDg1OVlEZnpnUG0xbmdKMEFncWMvQmZYcVFyQVUvVjN6?=
 =?iso-2022-jp?B?SXdEZ1JzWldSMG9JOVpNZDFTUVA3NFFmVTB3MHRVSVNMb2FPWEVoaW5X?=
 =?iso-2022-jp?B?Nk13dklnLzZpWmZsb2w3NzVLTUpRRHk2emlmMWZBSjNDN0FST3dxWnAr?=
 =?iso-2022-jp?B?a0pSbkdYKzZsUzMyWTFZQlZUUDVGWHY5K3JEUEVENkxoZXZwa0x0Mjlq?=
 =?iso-2022-jp?B?Y053aE1SclhSZXFQb2s2OG41U0NqaSt6WnlYbzJNakNZQ0s0UHcrbjVF?=
 =?iso-2022-jp?B?bmYxWkdmbmVzK2VrNHo1N2U5NkFRYmNYUXR0SFdPSk5IY1Y2azRJaS9u?=
 =?iso-2022-jp?B?N0lXc2lHek0vd2RXc1QxZnUxdVBDNnBsRkpFdGVsazNoeVNsTU5zVFJk?=
 =?iso-2022-jp?B?ZVZYTFVVRDdFMGNqa1AwdkJGZklvNnBiUTBBTXVtbk1zV0EvZXZtYmFr?=
 =?iso-2022-jp?B?MTFWMU1SNjVqWTJBcWlOTCtWV0lXbUZWbm44ZkphRTB5ekRPVG9YZzUy?=
 =?iso-2022-jp?B?aCtpMU1haGZSSURlNnRSTDMwbWxIM1E5UHozNDY2ZjZ0SzBSSEd4OXhI?=
 =?iso-2022-jp?B?TVpaNHZZUHlYQzVodUd0ZGhRVWR5eUZSa1B0UFFHZWxuQ2x4YmNvRmNl?=
 =?iso-2022-jp?B?eVJURldUWFBuWDBqM0c3YlZGbVFPVXJIcndUTnhFWWc0QzluRFlOa2VG?=
 =?iso-2022-jp?B?eXVsR1pHSWhzU2pVSUxWUjh3WnNtVUtkT0UzVmczRmNKWWx6eE5McW9w?=
 =?iso-2022-jp?B?Q2FSVll3OVpVVHB1M25XRHNYdlAxTDNFOERnTG42cDlINVgva3lPL3pY?=
 =?iso-2022-jp?B?cUJUb2p5UHZzT2RLVHNEaUVFbVhMb2NkZmhwNFRMakdjWUdueUdxazZR?=
 =?iso-2022-jp?B?Tk03WjRzVUhSbHFkd3MyS2ZZejFCdmw2Sk5CSXBFbkRyL2ZxcVdJU3dw?=
 =?iso-2022-jp?B?MmZSWkdKcHhmbnJWbXlDQTlCcFd4S1drNFI2WkhTOFdiQVFLY0NvSHIy?=
 =?iso-2022-jp?B?eGtJUWkwWS9DOHoyanRQUW9LSzNLcXpOUzJ6QVZ0RDU3bDJEUXJibG1L?=
 =?iso-2022-jp?B?SjYzUmt3c2FySE5CSVB2emM4dmVVZmtqdkgyUTRCckRkc0R2QUlQREdr?=
 =?iso-2022-jp?B?enhQdTFVNkJlQlVEYzM0QUFhV3JyS1EwSUduemdnc1pFQ08yckh1UWdP?=
 =?iso-2022-jp?B?clBEVzR3b1VLNWpxbE9JWXgyV0d1Q2REVWZSQTJNVWVhbWl6bko0YXl4?=
 =?iso-2022-jp?B?ckpZWUZhUDVqbHJIWGpqbCtIVW9GYUd5ZEFjZUpvbG1LTU1ONFkxVUtI?=
 =?iso-2022-jp?B?Wm95dytYTXpGblh2RlA1MWxEczgvbkQxbzY0bWJ4ZXd0eTAxbTB5VWdF?=
 =?iso-2022-jp?B?VmNoWi9wYit4SDhJM3lEL1UvNCsrSVpiNGVuMllROW5LdnZVZjY1alpS?=
 =?iso-2022-jp?B?VzZRTS9oRk9CNEtBbjFpalhKWElyNGdnYTJQUi9ZOGN6RzN1N1dWOUZ2?=
 =?iso-2022-jp?B?amdwbGgybERldmNMS21Ha1NsSXRDU1JQRUw3eGVGcFM3WHd1cS9rQlBy?=
 =?iso-2022-jp?B?T0NTM2syaktJcHdKVm95Mi9FY1N3Nkc3MHhGdE1hcXJJMnNKRi9IREN2?=
 =?iso-2022-jp?B?VEJGQUFaYXQrN2RJcElpd1BGYktoSE55TGNPbVV0SEVPSmVjZTRMcjJq?=
 =?iso-2022-jp?B?dndZbFkyYlJ0WForUktoSmU5aFkrMHpr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MmQ5SXVSQnJ0cTliMnRPWmUzeVNUMkdjdUE5UEtrYzhUaUx4TXR0M1Vn?=
 =?iso-2022-jp?B?dTBCckVJWHBvUURHZzBja3dDeENyTmhVakVxMktwQlI2SXl3bmhZUVAv?=
 =?iso-2022-jp?B?bGlmRld1WEVnNTNXR3BFaEs5TFdWSStpa3JTbC91aGNwMTRBT3dOVFU2?=
 =?iso-2022-jp?B?Zlp2MmUrMU92QmlETGhKNnZNazNsV2xWbXFiV0w4dWRjVUZkTU9SOWJU?=
 =?iso-2022-jp?B?Z2Y1Q3ovMW5MSVBzd1VycWc1Y0ltcnQ3YUt3UEhjRVpNc1d2MERIUlNJ?=
 =?iso-2022-jp?B?U3JWS0orQnBVVjROV1pKWWFlRlBQaHRUT1RHa0t3MU8reXNETkFRRmZt?=
 =?iso-2022-jp?B?dXBlQW5tcDE5dmhWLzVDSE5BS2JsTkIxL3EvNjFEYk12SEwzZ1RXeHRu?=
 =?iso-2022-jp?B?T2hZUngzQW0vU2YwbkRBWkVCbFgxd2ZKYkducE52TEVIKzliWUhudVI1?=
 =?iso-2022-jp?B?S2FFWUtKd3hjb0t2ZkliS2dlYjJQRExnVGZUMW5nQjVVaEpjWWtzRHUx?=
 =?iso-2022-jp?B?cDJ1dHJBcWhkN0FSWW5VZk1Ib05yNkgyK1RtaVBpeHJGd1ltb3d2Ky9u?=
 =?iso-2022-jp?B?aHZ5bjVlSEhhKzBPTXJkRnBqYU9kQTZmUStMd2lERjlKbEVMaHZaOFMx?=
 =?iso-2022-jp?B?MUNQOTZRVW53bGhGdTdFWUxLREVxNlFGQnhqR25zc2hYRTk1Um9BUC9o?=
 =?iso-2022-jp?B?ZFROOFBrbU5qNG42UHVtWUxLY20weFVyWWZkZWF6TFJoRU9yR3ZsemtC?=
 =?iso-2022-jp?B?S05BYWVPa0k0aWtiYW5JeFlxSkpNejJYK2FKMm9HL3oyQTNFZXNIS2ZO?=
 =?iso-2022-jp?B?L0ZycEJieXBQNHBSQ0FtcytZUnI4NzlmV01LNGJGNXBEQlhCSDFpaDRy?=
 =?iso-2022-jp?B?b3NnR0tPNi90TTEraTFLaFFNYmExZERWYW5Xamk3YTVqMG43K2VtZXZL?=
 =?iso-2022-jp?B?WjVKWVMxZ0d2Zm5rbWhUdTVYM3V6ZGo1Q0RBL1lmLzY1UTd0UFQ3Nmly?=
 =?iso-2022-jp?B?WkpCbTRabkNuZ3ZFVWI2dmJrMTA0TWJJNURYV3ZBT3pSR2ZIaVY3K1JF?=
 =?iso-2022-jp?B?UXp0WnZBdDZZTEJ2MzhTRGY0OEJsc0M2Rkd4UFVZNU1pOU0yR1pvdjU0?=
 =?iso-2022-jp?B?ay85V05ZVzY5QVM4L0ZEaG1vL0sreDlJUGZRRyszUWRtZURvZWlXbEU3?=
 =?iso-2022-jp?B?NnRXbWZxb0VZdmFwdGF3WStBQXZLWEdFYkN3THovRXdJS25SbmcwTHpR?=
 =?iso-2022-jp?B?ODhiODBEajRsTmloMHAyOGY3TnNvV0JBOUQ5TGVJTGNHeG02VXFlak9i?=
 =?iso-2022-jp?B?Rko4bENXVXNBWGFYaFpUQmNMekhSc3l5Um5tT280MGI3YlkvNEcxRjB4?=
 =?iso-2022-jp?B?M0RjbERtbDlDSE9sVWZxL2ZoSE8xOHg0TG9Ddm9GcVVSMVNyeGtzTFFt?=
 =?iso-2022-jp?B?anBHL09UaTdDT3FzWjdSRU13QkZ1b25ZTkUzbTFTOFVTZEYvbDdyNHZ1?=
 =?iso-2022-jp?B?OWdTRHNvc280c1B0V2huT0pQV0dJWkhqcit3VWY2aFU5WCtBWmJQRHo4?=
 =?iso-2022-jp?B?dEkxZzVmZDdvRXlCVDAvU0JuRlpSSmpReXFCa1g2bk5OdzEwT0tONUI0?=
 =?iso-2022-jp?B?d3B6U2h4c3h1eHl6cTk0djJQejU0UjhzUlRocmVaZmEydkhtZmtvc0NR?=
 =?iso-2022-jp?B?RitiV3Y1c0JKOVlVUlE5U1NUUGtzMy9pWUJRanBqN3I5V09ORVhkdUpN?=
 =?iso-2022-jp?B?UTZzUFJDQVYwelRtT3RyOFFuMXZZS1Rib1VmK3NWNkp0djJaYWE4ZG5E?=
 =?iso-2022-jp?B?Qlg3SEtvbWVSNWk1dEFMclYxWVVaQkdwZFhlc3pXSWxXcVdKWkkrMVpG?=
 =?iso-2022-jp?B?YnZLM0dOSDQ2azVXMjl6QmtpclUyV283bmQ3MFBTM2dBeWp5NEM5cDky?=
 =?iso-2022-jp?B?UmhWMnRBUW5GUXdqR3pUWHdKMVBTbGNiY2JuLzA2d012UitkTGo4RDFN?=
 =?iso-2022-jp?B?M3A0cGNGSE5JQk5Sc0lVNmVIWWtBUGJ6WDFZODNKV1hUdklrVXRXM2Jz?=
 =?iso-2022-jp?B?MUFRajkvdWNHU3ZrVzl1NjVEWTd6WU1YWHBRUzF2dlRrT1E4TVBYMnlu?=
 =?iso-2022-jp?B?eW9VZkhEa2psaldON2Vwby9BMDFGaFpDSnZ0YjRNU0N4ZzNWMXJWTk54?=
 =?iso-2022-jp?B?K2U0emJTUXcrMldmYUFNWlFiQnZIWjFNSWZ3ODNVRlNxdnhndmRRd29a?=
 =?iso-2022-jp?B?ajZuakVWYUx0c2JwQndqTi90TFRpaHE1YWdUa3RJR0h4QzNrcHpwZUN3?=
 =?iso-2022-jp?B?bk9nMmRWbzI4aUZnM0pINFV3T1E3SFZNNk5BRSt1RW5qVXZ2NTJKbDYv?=
 =?iso-2022-jp?B?M3Jqa2t3VzkxampDb05oYmlvcG80T2dMUVQ4MlducGtVWDVDMGllYThY?=
 =?iso-2022-jp?B?WWJoVlVsRi9OdFRuTVZtOWo2c0VHWmg4TDFEM2M4NjZ1ZURZYzB5bS83?=
 =?iso-2022-jp?B?TUlHSE1zSnpXRmMrUDhuUWRLeHR6OC81Vk9RbU45eW9PZWV0Ym5oWkxt?=
 =?iso-2022-jp?B?Z3c2cGpvYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1add6ca-e7b6-46a4-bf78-08de43322d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 21:19:52.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rttAi/f0yFfx3/fIbxeLVklmbczTadvHY3JBDWf25nfHNvWcgnRQ/3FC3c4hNrtNNHmDhoDE2GZ7wTmW2SlbkRb+b5dtVZtfZK56DcJw3JNbrApWlPDSpwSS3UqcaOJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7128
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Dec 2025 21:20:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21214

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, December 24, 2025 6:30 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; biju.das.au <biju.das.au@gmail.com>=
;
> cip-dev@lists.cip-project.org; pavel@denx.de
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-sma=
rc:
> Add gpio keys
>=20
> Hi Nobuhiro-San,
>=20
> > -----Original Message-----
> > From: nobuhiro.iwamatsu.x90@mail.toshiba
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Sent: 24 December 2025 05:17
> > Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas:
> > r9a09g047e57-smarc: Add gpio keys
> >
> > Hi Biju,
> >
> > Thank for your patch.
> >
> > > -----Original Message-----
> > > From: Biju <biju.das.au@gmail.com>
> > > Sent: Friday, December 19, 2025 9:29 PM
> > > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =
=1B$B?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C=1B(B
> > > =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > > <pavel@denx.de>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas:
> r9a09g047e57-smarc:
> > > Add gpio keys
> > >
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
> > >
> > > RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2
> and
> > > USER_SW3 and SLEEP button with NMI support. Add a DT node in device
> > > tree to instantiate the gpio-keys driver for these buttons.
> > >
> > > The system can enter into STR state by pressing the sleep button and
> > > wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
> > > configured as wakeup-source, so it can wakeup the system during s2idl=
e.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Link:
> > > https://lore.kernel.org/20250702092755.70847-1-biju.das.jz@bp.renesas=
.
> > > com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > [Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
> > > r9a09g047e57-smarc: Fix gpio key's pin control node"]
> >
> > Why did you need to squash the commit?
>=20
> Previously Pavel mentioned to squash fixes patches like this So that cip-=
kenel
> have clean functional patch.

I see. Thank you for letting me know.

>=20
> Cheers,
> Biju
>=20

Best regards,
  Nobuhiro

> >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37
> > > +++++++++++++++++++
> > >  .../boot/dts/renesas/renesas-smarc2.dtsi      | 31
> > > ++++++++++++++++
> > >  2 files changed, 68 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > > b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > > index 2454a9743df2..9f6716fa1086 100644
> > > --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > > @@ -8,6 +8,7 @@
> > >  /dts-v1/;
> > >
> > >  /* Switch selection settings */
> > > +#define SW_LCD_EN		0
> > >  #define SW_GPIO8_CAN0_STB	0
> > >  #define SW_GPIO9_CAN1_STB	0
> > >  #define SW_LCD_EN		0
> > > @@ -15,7 +16,16 @@
> > >  #define SW_SD0_DEV_SEL		0
> > >  #define SW_SDIO_M2E		0
> > >
> > > +#define PMOD_GPIO4		0
> > > +#define PMOD_GPIO6		0
> > > +#define PMOD_GPIO7		0
> > > +
> > > +#define KEY_1_GPIO		RZG3E_GPIO(3, 1)
> > > +#define KEY_2_GPIO		RZG3E_GPIO(8, 4)
> > > +#define KEY_3_GPIO		RZG3E_GPIO(8, 5)
> > > +
> > >  #include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/input/input.h>
> > >  #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
> > >  #include "r9a09g047e57.dtsi"
> > >  #include "rzg3e-smarc-som.dtsi"
> > > @@ -79,6 +89,29 @@ &i2c0 {
> > >  	pinctrl-names =3D "default";
> > >  };
> > >
> > > +&keys {
> > > +	pinctrl-0 =3D <&nmi_pins>;
> > > +	pinctrl-names =3D "default";
> > > +
> > > +	key-sleep {
> > > +		interrupts-extended =3D <&icu 0 IRQ_TYPE_EDGE_FALLING>;
> > > +		linux,code =3D <KEY_SLEEP>;
> > > +		label =3D "SLEEP";
> > > +		debounce-interval =3D <20>;
> > > +	};
> > > +#if PMOD_GPIO4
> > > +	/delete-node/ key-1;
> > > +#endif
> > > +
> > > +#if SW_LCD_EN || PMOD_GPIO6
> > > +	/delete-node/ key-2;
> > > +#endif
> > > +
> > > +#if SW_LCD_EN || PMOD_GPIO7
> > > +	/delete-node/ key-3;
> > > +#endif
> > > +};
> > > +
> > >  &pinctrl {
> > >  	canfd_pins: canfd {
> > >  		can1_pins: can1 {
> > > @@ -97,6 +130,10 @@ i2c0_pins: i2c0 {
> > >  			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
> > >  	};
> > >
> > > +	nmi_pins: nmi {
> > > +		pinmux =3D <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
> > > +	};
> > > +
> > >  	scif_pins: scif {
> > >  		pins =3D "SCIF_TXD", "SCIF_RXD";
> > >  		renesas,output-impedance =3D <1>;
> > > diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > index 3cac292f20b3..58561da3007a 100644
> > > --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > @@ -23,6 +23,9 @@
> > >   * SW_GPIO9_CAN1_STB:
> > >   *	0 - Connect to GPIO9 PMOD (default)
> > >   *	1 - Connect to CAN1 transceiver STB pin
> > > + *
> > > + * GPIO keys are enabled by default. Use PMOD_GPIO macros to
> > > + disable them
> > > + * if needed.
> > >   */
> > >
> > >  / {
> > > @@ -53,6 +56,34 @@ can_transceiver1: can-phy1 {
> > >  		max-bitrate =3D <8000000>;
> > >  		status =3D "disabled";
> > >  	};
> > > +
> > > +	keys: keys {
> > > +		compatible =3D "gpio-keys";
> > > +
> > > +		key-1 {
> > > +			interrupts-extended =3D <&pinctrl KEY_1_GPIO
> > > IRQ_TYPE_EDGE_FALLING>;
> > > +			linux,code =3D <KEY_1>;
> > > +			label =3D "USER_SW1";
> > > +			wakeup-source;
> > > +			debounce-interval =3D <20>;
> > > +		};
> > > +
> > > +		key-2 {
> > > +			interrupts-extended =3D <&pinctrl KEY_2_GPIO
> > > IRQ_TYPE_EDGE_FALLING>;
> > > +			linux,code =3D <KEY_2>;
> > > +			label =3D "USER_SW2";
> > > +			wakeup-source;
> > > +			debounce-interval =3D <20>;
> > > +		};
> > > +
> > > +		key-3 {
> > > +			interrupts-extended =3D <&pinctrl KEY_3_GPIO
> > > IRQ_TYPE_EDGE_FALLING>;
> > > +			linux,code =3D <KEY_3>;
> > > +			label =3D "USER_SW3";
> > > +			wakeup-source;
> > > +			debounce-interval =3D <20>;
> > > +		};
> > > +	};
> > >  };
> > >
> > >  &canfd {
> > > --
> > > 2.43.0
> >
> > Best regards,
> >   Nobuhiro



