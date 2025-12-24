Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB7E75446
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 09:30:30 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.117483.1766568621423996544
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Dec 2025 01:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=IQE4/6jZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.54, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWT7Fs913kZO2nM+7V/XfMHVtk9hmMD2mN3K9eaCT99GcPlc/mamQFwb1hlTZpC0J/yLava6k3asB8KgZNbqydI37bTwrL4WZ7POcyoBPE9zPS7oOC+Rqxq+KSQ59LC4hvvkc34SAbrT9HBO/7IgIbNqtqpjARvPh8NQlSydqqmEiCT+BIrZkIl6+JnRfTWWTomGNzbbu/6I/dYiyZtSQ3QyY779wRhO6geCveMxyFLXYf4sCiIpyMMkrmklUR8UdRangLQjltjvnGaMF5SL62Iq++Tj2GumVfu51ci/ORuIZ5hIHGLUTVCM+FoYN0prAK6RW5DbzPlQyVt/IRRZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmBDQh9IlibFK9DScN3QWZHwXm8zxYXbOsTbJUYu/p8=;
 b=yg0RizOpsdH73zBF25PtUutxxBx4O497ko7YfWXySzJ4VbpkdHFrN23ZGIfNT6qSIRAp7PG+ZwOSzW2TLD9CRoiHbjsdANtn7kV9NrncRcBvcchl3MJOhFFFlUmppGNuyxBwkADh6g8B75U1t1zvc3mf28RkaHBOyvNYP3ozafoO0q7i79z0m+H+Ft56wWnpq+/hxGrowM96UU5h//GBWSIEUbHYQ1KF8nrhxehVvV5RDyy3FfbknDIAtmMTfhB7E7bwonlyn1fVQJObwwn1WS2A/CC1KJ4eRqNjA6SbgmoQ+LUYMxTmuDlYCI9CbnY+H1559KHvnPdhW1gaKJZdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmBDQh9IlibFK9DScN3QWZHwXm8zxYXbOsTbJUYu/p8=;
 b=IQE4/6jZB5stuQXJs6YO74u2YgZ57ZERF21IP3+1KetClcjxnf5aEwqSmsDmZVMv+g0Y6wWGbfl14LZllVHqEe1Aty6MT+1CBXQCHN9I2VVWNvNE5B2akCsTfLLqI55HrSLFHyznJ+V03I1CtBPFXwAWsUppfBLaVGLRb8KA0U8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB14580.jpnprd01.prod.outlook.com (2603:1096:604:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 09:30:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 09:30:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Topic: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Thread-Index: AQHccOMcm1fSE7Ivv0Om27G62g4SN7UwR2eAgABGFnA=
Date: Wed, 24 Dec 2025 09:30:14 +0000
Message-ID: 
 <TY3PR01MB1134650A811981E9B7EBCC1CD86B2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
 <TY7PR01MB1481814158E5E8E076C44B8DFCDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB1481814158E5E8E076C44B8DFCDB2A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB14580:EE_
x-ms-office365-filtering-correlation-id: af0b146c-4bb5-450f-8a4d-08de42cf0b66
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?andxS1JmQU5DRFhEWk9ESERLODdTSnI5WHpUTWNySmlIUmdGaU9yaWUy?=
 =?iso-2022-jp?B?Ris0RDk3QnNtZW90eTJHaVBNbHB0MGRXT1RYNGJwdDdNeDl1aTdyZW85?=
 =?iso-2022-jp?B?ek45cjBCYkNYakNLSytZMUlsZ2lUNXZvNHR1SlpKSHJhRldIUWNQWE0x?=
 =?iso-2022-jp?B?TEJpbDlsWGhHOGYrVEsvU0RJWVFCYjh3SVFIOS9IbzhYTk5SMDRpVzFK?=
 =?iso-2022-jp?B?U1VpTHpnVEhDYXZhTHFKN3lmZjFOaFlIU3R1VWR0YjFQMWRlalg1MDhI?=
 =?iso-2022-jp?B?bUlLQ1l6RjFJRVpNcFROOGxBLzFCZUtmanF0bHNJN0lHaVdGT01ybU1m?=
 =?iso-2022-jp?B?cHJPVkhDRnpKM3htZ08ydGpQaHJtQ2hWNXpqemRCTEN4NmZZUm1ENTRV?=
 =?iso-2022-jp?B?R0wyS0FqZ3J2VUlQdGdsdXdPczB3enhtZ1A0TVpDQkRLUVN3eEVIR3JI?=
 =?iso-2022-jp?B?OHVyMXY4YWtQMVZwL0xmQXd5dWZBWGpGdzZYVnZxV0MvQlpjSXU4RmhT?=
 =?iso-2022-jp?B?WnBZWHozRlBnZlB1ZFJ4QXRSemY3T1U4c1Q4M292ZTVpdmdxYUo3YWkv?=
 =?iso-2022-jp?B?VklYcldnNVZYUnJ0aXN0a3BYVTgrcGF2bVhibHBoT2dDT2FrclNNOE00?=
 =?iso-2022-jp?B?RUkzcW8vdGpvNEJhR3M2NElLcVhSWFhVTldUOTA5SjVMRXJtREM3bG4y?=
 =?iso-2022-jp?B?RlhyYjlJWUozREh4aCtvVCtpT1EwR2RiSWs3OHdXOEM5cmpJdGlFVVhq?=
 =?iso-2022-jp?B?elhJWFB4anliaW12YjRnaTUxb29aNEZubGdERDRCOWM0cXE4U2JQaXRs?=
 =?iso-2022-jp?B?aWxJSEFEaEw4TWswU2srb1JZYlZtV3JxbWtBVWt3bHBJZkhVN1JSQlRZ?=
 =?iso-2022-jp?B?ck02dnROK0pzZ0J2bWlzcVcva29uc0RNZXBsZnZob3Vvd0VNSktFL0xy?=
 =?iso-2022-jp?B?Y1J1NjNJM2Fzbks2YmF6ajVoeXFWTVJ5citkdkV1UzBLL0pQNkxjdDF2?=
 =?iso-2022-jp?B?U09rcjlzYjlDR1NOZmJwSVF2N09kWWVlZHBxcVd0eUYvU3ZkWjFPUVVV?=
 =?iso-2022-jp?B?NHpFMTIrQ3Zld1hNNk12ODFCeUpmZTFRdXA4eGVqN1RkV1VwR0JrOGhx?=
 =?iso-2022-jp?B?ZkhYNGE4QjJTL3dBS01HKzJabnBaclYvZEU2YzlhZFUyWm02MEptdkhJ?=
 =?iso-2022-jp?B?alVVZzlMdVYzbWR1a3U4VVpyMkk0TlFKTkZ1bmk4bkEwVFpFZ3pJQVpq?=
 =?iso-2022-jp?B?ZWUwb0htb1lnMEhkRWtoMEVvcldOLy9HT3pjYTA4UUtVVnNOZ3dOZXJU?=
 =?iso-2022-jp?B?TlJOdjlDNStvYzJ4aGRLd0NYNmJ2UUhMZ2Mzc2hsSFdocVg4MUJHTnRk?=
 =?iso-2022-jp?B?d1JjUGMvOUpEcFhCZXdzcDM5Q0N2dUUxT1VRcmluN0dJbU1kdnZVb2l4?=
 =?iso-2022-jp?B?NGdESnNXWEd0RW50REM5YWZTMUI2WEdwR3hvTzJLWEFmL282VnFGUURs?=
 =?iso-2022-jp?B?WUpQRkNCb0U0VTYrZmRNam40dzczMmwrbjVDTVBYN1dQVlBzZDd0RWhr?=
 =?iso-2022-jp?B?b2ZiS2JkelQ5VUlqT3BYb2hLdW4vZDIrMlV5QW9iMUN0cDRRSTI0ZHVK?=
 =?iso-2022-jp?B?S1NEaVJJdXFUSFY4OU5BdDg1NXJ1b080ejlPK2JmbTAza0gwdnVrcWtP?=
 =?iso-2022-jp?B?bktHekNYeWRId2YySVVIL213YW5UZTh6b1hFZlc4VXpqT1FxOWtocUt6?=
 =?iso-2022-jp?B?ZnNZa0FTL0k0Szkram1tWGUvdjIvdEVWbWpXMVpUYldoUGMxdlg2aDlk?=
 =?iso-2022-jp?B?eUVvdWc5MkJneGk4VFJjeiszaFBma1VGRXc5MVdtMGJRV3JuSzdSeDNz?=
 =?iso-2022-jp?B?Y2ZyUEdaVy9ZNGQ3bjhTNCtHOWRENlRtYVM3TGU0SENjbklQQy9TZnZZ?=
 =?iso-2022-jp?B?UCtNUmtUUnFDRjB2enk5cWtnTVpJS2I0Qk93aEJKeXRzOFVkVjBMdXgy?=
 =?iso-2022-jp?B?MnBvSVdjOHdhWWFVclNMUHhtSi9FeThJc005SHN4TERLUXBxbjFYdGRl?=
 =?iso-2022-jp?B?bGVXSHVYbVl1cnRSS3A5VWRZZlNZTHJFWkplTzVxM2pIUG1nR1l6azRZ?=
 =?iso-2022-jp?B?Rm5vOEJNdnZ6bWRpbTdRMkc1N1pRV3RMUWN0NzhJOVlaeitLUHhXRXh3?=
 =?iso-2022-jp?B?Y1poRlduOGJlSnNTbnR1ZGFtTFM4TEFm?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WlRXR05Xa0pwRWVWanBKb1ZDN3JQRVJtbXE5QTZpS2o2d2VuRlNWMGdV?=
 =?iso-2022-jp?B?ekpraXRsczlVdXE5MGU1RklRRXhUcnVYVVB1ZlJPU0lOeG9tVEcrdUpt?=
 =?iso-2022-jp?B?SWhqWW1qTWtTVWw3WS9JdTVRWkF3bUhJR1Y2cHdubnhuSWxnV21rUnl2?=
 =?iso-2022-jp?B?ekFKMzNTOVVKSXJvY0pzT3AxNzAwT2RpWGJnc3FIRUhwalByL2VPa284?=
 =?iso-2022-jp?B?RzJBd2VoVDZHM3kzZUVNdEIxWW4zOUtQNkQ3TUN6K1FxR20yQTcwN01z?=
 =?iso-2022-jp?B?WXk0elVONFpuVUlFTWNaSWVDNm9xcmEzbFZDRWNxMVlpTm0xMWpXZWlx?=
 =?iso-2022-jp?B?RTk5ZHU3ajE5N1ZJaXBUNk01a0Jad09GK1RSeFBrWFRKRjdlc3pLRHVk?=
 =?iso-2022-jp?B?MkZRSGl5VWc3RlhSbGVNcjR4dnZ1WDRvZlRKd0FNcWJXZFkvWjZudCt3?=
 =?iso-2022-jp?B?S0JCYStxc1VDZXFQZDNSRVlmNXhFWjNQUXBXdUQ5Yk1IM0pGay9aTUtu?=
 =?iso-2022-jp?B?WC9neG5uNFY3VWlqc2d4L0tWMkNLOHVoSmRrVURZZTk4RHdTRVE3Znly?=
 =?iso-2022-jp?B?eml1UFJET3l5dXhnWlhlZFdvaFdIRk1hMkp5ekFPcXc1WGNRMndkWHBP?=
 =?iso-2022-jp?B?allxTnJpWE5uL3FIN1NleUF2Z3dwSHpURGpWd1BPMGNnSE9pY1E1OGxy?=
 =?iso-2022-jp?B?M1dxUjBwTWhud04wKzdCWHczNnkxVEZOdXpNSUpUYzBYYzFGQWxaczA2?=
 =?iso-2022-jp?B?VmJqNjlrYWRnMURCZ25mTFhhVEQxcVlMai9tZ1lXQkxWcy90THVGcUJn?=
 =?iso-2022-jp?B?Z3p6WDQ0MHhIeTFrSktudndhRnhkdkpCdkRlMktiMFQ5VHhPS3BPb2VY?=
 =?iso-2022-jp?B?eWc5YWNVZGFNR0I3NDNwRDdOdlpEV2xIUXkzYVJ5UkxIbnlyMkFJOE54?=
 =?iso-2022-jp?B?YW5yMUU4eElreXhjU1J6b21XYkhiN25SQnV1Q0R2b21ROEo2cVNPcDdq?=
 =?iso-2022-jp?B?bXF2RXVkeDhXTzgxS0ZEOVBHeTNKQTVDQWVFQmVjVlBOUmtSVzJzZVc5?=
 =?iso-2022-jp?B?bmFDRi8wMmxmbzZNSEYrS2JsM3dVcnU1aGRZQ3BPam1zdjJOT2dtOG9N?=
 =?iso-2022-jp?B?TUVUdUc4eFlmeXVXZHdyOXpVWjVLaERjdmVnQmExc2tnUi9INUYzWU1S?=
 =?iso-2022-jp?B?TVoxckR6T0dERStYR2ZxYnFzbGxEdFlLSVNBemZlR2NHU29Dc29SZy84?=
 =?iso-2022-jp?B?SmhlWm04aUl0dm03RVFjbnF6Z0pZbkNBNEFPZ0NycFdmb1NxbGEwNEJY?=
 =?iso-2022-jp?B?TnRLRUx1dlJEM0liRlVnZjMwSElDM0NMeE9wM3MvQ3piU3BLZW1RUThy?=
 =?iso-2022-jp?B?N3E5MGQwdXMyQ2syVlMxaUxTQkVkZkZiem9OalhxYkJlUXBpeHlZVWpW?=
 =?iso-2022-jp?B?b3ZKMDFSbmcyeVBxaHFaOXkzSmZvSFZNaVNFQXhlZjNrR0I3SVgzUkNC?=
 =?iso-2022-jp?B?OWJlOWlpeGVwQitLVW9DMWJ2VG10clhLNHVJNFhKT0IyblR3K0xDcFQ2?=
 =?iso-2022-jp?B?LzhFalhqeXQ5Z1IzUWl2S0k1eWF2ZmMxNVNtQU5DNFZtVWdTOVlvZ1lt?=
 =?iso-2022-jp?B?eHFuREtWODRsWWJRRWU5YmdQSUxQWDZRZW91WVk3K1hzN3l1V2pRMGZx?=
 =?iso-2022-jp?B?OERqWFJBenBESnpLVzJrdkxuOVJmb0JSSmNreTJvZGdrejdkL1pBQU0v?=
 =?iso-2022-jp?B?Q051VzNNalJrdUUxNTltaHdLL1hjNXNEZTcwTHpoemRyaTJjOXFVSGx5?=
 =?iso-2022-jp?B?N2txWTNraTdTOTVRTWZ2LzlVa0ZsVVkyMHpUOUxxRzhGd3U5anJMR1FH?=
 =?iso-2022-jp?B?T0R2SzVLakF4ODl0WDMrRnZTd2ZJbDJ1ckx2TkY1UUF1cm43bFJ3dnRJ?=
 =?iso-2022-jp?B?Mk9DTFFrYU54UU9PQ2hIcmMydWNGbVh0Q3lldmorZ1pHelptejQ3Y05q?=
 =?iso-2022-jp?B?TkhkOGtjbFEyTDdOcUVJR0hTblF4OUNsN3ROeHc3T1BjS241ZjJUcXp6?=
 =?iso-2022-jp?B?MlVuaUZPUGNwRTFLeFpVNFY4cjUxLzdPaDJsQnMvdCtGa3BZSm1NNm93?=
 =?iso-2022-jp?B?ZnU4Q3F0OU1ZQXY3ZnpUVkNGelBiWlRjMXVCN3BuWTVtQXI2VHhNbFVj?=
 =?iso-2022-jp?B?U3pMNGQzT0lpeHlseHIxUFYwYUhyQXlJTzhhcnVFM3kxRmhKdTNEZnVX?=
 =?iso-2022-jp?B?WjNkVng1bEFXdzIrbkp0Z2NjQnE3eUZFZllvd29xbExaZGx2MVZFaHg1?=
 =?iso-2022-jp?B?ZmFOZWFiR0hpM3pYdDFCUlZYOVZQVmxNc0VrVUtIb3ZjMHlqeGNDVkhR?=
 =?iso-2022-jp?B?OS9SdU10T1hFRDhMQ0pQK0l6K2hKQ3BCR1VkanhsWERuL1YzUWI4eVpQ?=
 =?iso-2022-jp?B?MkZXejVMTEtPcXZoTG9PQ2dPRmE4RjFrTkFKb2Y4UXZMVU14QmV4L3Vt?=
 =?iso-2022-jp?B?cmZZMnozYzVBTUFzYzVPbWhNdVBnUEdFRXVvQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0b146c-4bb5-450f-8a4d-08de42cf0b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 09:30:14.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDwJdrdSmALUeN8cKd0k6tkx7eBgPQAl38DdKceLZI3HOg+Vd+aJGSdccWsP+aYHn5/YeuIDO0ga8JZGBReHzHf2Dw7OBiuNJ+aZZE7cvHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14580
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Dec 2025 09:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21213

Hi Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro.iwamatsu.x90@mail.toshiba <nobuhiro.iwamatsu.x90@mail.tosh=
iba>
> Sent: 24 December 2025 05:17
> Subject: RE: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-sma=
rc: Add gpio keys
>=20
> Hi Biju,
>=20
> Thank for your patch.
>=20
> > -----Original Message-----
> > From: Biju <biju.das.au@gmail.com>
> > Sent: Friday, December 19, 2025 9:29 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> > =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pav=
el@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc=
:
> > Add gpio keys
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
> >
> > RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
> > USER_SW3 and SLEEP button with NMI support. Add a DT node in device
> > tree to instantiate the gpio-keys driver for these buttons.
> >
> > The system can enter into STR state by pressing the sleep button and
> > wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
> > configured as wakeup-source, so it can wakeup the system during s2idle.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://lore.kernel.org/20250702092755.70847-1-biju.das.jz@bp.renesas.
> > com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > [Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
> > r9a09g047e57-smarc: Fix gpio key's pin control node"]
>=20
> Why did you need to squash the commit?

Previously Pavel mentioned to squash fixes patches like this
So that cip-kenel have clean functional patch.

Cheers,
Biju

>=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37
> > +++++++++++++++++++
> >  .../boot/dts/renesas/renesas-smarc2.dtsi      | 31
> > ++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > index 2454a9743df2..9f6716fa1086 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> > @@ -8,6 +8,7 @@
> >  /dts-v1/;
> >
> >  /* Switch selection settings */
> > +#define SW_LCD_EN		0
> >  #define SW_GPIO8_CAN0_STB	0
> >  #define SW_GPIO9_CAN1_STB	0
> >  #define SW_LCD_EN		0
> > @@ -15,7 +16,16 @@
> >  #define SW_SD0_DEV_SEL		0
> >  #define SW_SDIO_M2E		0
> >
> > +#define PMOD_GPIO4		0
> > +#define PMOD_GPIO6		0
> > +#define PMOD_GPIO7		0
> > +
> > +#define KEY_1_GPIO		RZG3E_GPIO(3, 1)
> > +#define KEY_2_GPIO		RZG3E_GPIO(8, 4)
> > +#define KEY_3_GPIO		RZG3E_GPIO(8, 5)
> > +
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> >  #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
> >  #include "r9a09g047e57.dtsi"
> >  #include "rzg3e-smarc-som.dtsi"
> > @@ -79,6 +89,29 @@ &i2c0 {
> >  	pinctrl-names =3D "default";
> >  };
> >
> > +&keys {
> > +	pinctrl-0 =3D <&nmi_pins>;
> > +	pinctrl-names =3D "default";
> > +
> > +	key-sleep {
> > +		interrupts-extended =3D <&icu 0 IRQ_TYPE_EDGE_FALLING>;
> > +		linux,code =3D <KEY_SLEEP>;
> > +		label =3D "SLEEP";
> > +		debounce-interval =3D <20>;
> > +	};
> > +#if PMOD_GPIO4
> > +	/delete-node/ key-1;
> > +#endif
> > +
> > +#if SW_LCD_EN || PMOD_GPIO6
> > +	/delete-node/ key-2;
> > +#endif
> > +
> > +#if SW_LCD_EN || PMOD_GPIO7
> > +	/delete-node/ key-3;
> > +#endif
> > +};
> > +
> >  &pinctrl {
> >  	canfd_pins: canfd {
> >  		can1_pins: can1 {
> > @@ -97,6 +130,10 @@ i2c0_pins: i2c0 {
> >  			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
> >  	};
> >
> > +	nmi_pins: nmi {
> > +		pinmux =3D <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
> > +	};
> > +
> >  	scif_pins: scif {
> >  		pins =3D "SCIF_TXD", "SCIF_RXD";
> >  		renesas,output-impedance =3D <1>;
> > diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > index 3cac292f20b3..58561da3007a 100644
> > --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > @@ -23,6 +23,9 @@
> >   * SW_GPIO9_CAN1_STB:
> >   *	0 - Connect to GPIO9 PMOD (default)
> >   *	1 - Connect to CAN1 transceiver STB pin
> > + *
> > + * GPIO keys are enabled by default. Use PMOD_GPIO macros to disable
> > + them
> > + * if needed.
> >   */
> >
> >  / {
> > @@ -53,6 +56,34 @@ can_transceiver1: can-phy1 {
> >  		max-bitrate =3D <8000000>;
> >  		status =3D "disabled";
> >  	};
> > +
> > +	keys: keys {
> > +		compatible =3D "gpio-keys";
> > +
> > +		key-1 {
> > +			interrupts-extended =3D <&pinctrl KEY_1_GPIO
> > IRQ_TYPE_EDGE_FALLING>;
> > +			linux,code =3D <KEY_1>;
> > +			label =3D "USER_SW1";
> > +			wakeup-source;
> > +			debounce-interval =3D <20>;
> > +		};
> > +
> > +		key-2 {
> > +			interrupts-extended =3D <&pinctrl KEY_2_GPIO
> > IRQ_TYPE_EDGE_FALLING>;
> > +			linux,code =3D <KEY_2>;
> > +			label =3D "USER_SW2";
> > +			wakeup-source;
> > +			debounce-interval =3D <20>;
> > +		};
> > +
> > +		key-3 {
> > +			interrupts-extended =3D <&pinctrl KEY_3_GPIO
> > IRQ_TYPE_EDGE_FALLING>;
> > +			linux,code =3D <KEY_3>;
> > +			label =3D "USER_SW3";
> > +			wakeup-source;
> > +			debounce-interval =3D <20>;
> > +		};
> > +	};
> >  };
> >
> >  &canfd {
> > --
> > 2.43.0
>=20
> Best regards,
>   Nobuhiro


