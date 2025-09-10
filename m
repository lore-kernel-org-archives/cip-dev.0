Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE36ACA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 08:09:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.12173.1757491755886587617
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 01:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=bsvbaJUM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1757491732;x=1758701332;bh=
	ZMk0/6LhgtuIb+LjRZJQufjJ+tvws3q4nObgK4TGwvE=;b=bsvbaJUM9aUtZfUXhC9bN+gNXi6Vrh
	0ceiCeck0GCT+sDtUF4PMIdk8KrhxW/lUqhsJ2On4dRAVH/421QBIhQE4v9sOj1aiqFxY9fWTx/wu
	nJOgGIqpmHuARZXfwy8GudDzclrOJjlb/2blai8RfSnEl3XgkSpJg4Wyo1uXFfkuOaprHF5Oqfy6P
	ni/H/NdFxgpVGomOm36R9TiafK+jmyuKB0MkXZpqtsymYb02S9eWBavLaNPWXNRPk0C6DkwPjx7e5
	kKQTSwUmLYbnryHX6O9ZgEp5IzchCp5oF1D96Hh3wa/G0oKhFSTETpHbs1b7fHuG9f13HosDlCUNC
	tinA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 58A88psn424469; Wed, 10 Sep 2025 17:08:51 +0900
X-Iguazu-Qid: 2rWgOBcOEWqxaw3hdR
X-Iguazu-QSIG: v=2; s=0; t=1757491731; q=2rWgOBcOEWqxaw3hdR; m=BaYb9xOvF8nEViRCUzI6rfnjOW4Fj378KXaHzbEVBw4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cMCxt3RVFz1xnj; Wed, 10 Sep 2025 17:08:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBFfflBlxD3ilMtP8CIKVurmLuY2PD2GNN/Ce2fMjjTJBqw0rc/mtAIfDiHgoTqrWmdwq8UDl0cY38OdRmkOGh47tSFs9tfCHAKF69hNtGW5DEb88mBONvxzpi8RWkKyOeY7G+IXHMUZi/I+3sZOCy4bHFcSJv7ClvyiNXWuqBHZRqTR5pu7ZNymwydJrXfdKMUZ2ael6jExT83L+YJP+Jvz1AmcWtnVUf4k4UkhxEqLUQuhfzcV/rEYzGGvViChRQv0A9987FC1TMIQxHJcU7d9UOYUzZfMei4Cy1UKtmJ//WQ/kB1l1UTVijfMNvIKLxHaKVhMeEXSE71JFqHDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PYxDioNZkSlDRjlFcMPRaxDRxFm/SiXHftBA/CUHvs=;
 b=Iu049zfcJwGkqtFNbhcxJweOPyvYJ/+EBmL5tAjC+oDO6+DstBzxEzU/3rF21zwcs982r9896q2dckiaraOXSdfxNyYyyAkFkx1okt3v42ZDen1A3fA2rPYHJPEoy4FEiCtRthSHepLh86hoEXIxSO3MlG9ebd4Pp1gnT2c1fZTd8Cu4RQWhK/WQCLGGHvhB/hRE9ky5KzCwj1Es5X/oFbZhQ9aMJBIpMwSl8rodb8j/6P6SHWMQAfC3Yh1ZB0U6lsplaFBEot5BWo3c+syOD3PdJXd7Y8KSIgLFrIWtEYdXvEdVtonomGFr61wdOpnMRPWNC2eur3aKi3Av/XtUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.46-cip8
Thread-Topic: [ANNOUNCE] Release v6.12.46-cip8
Thread-Index: Adwh5tO1Y/kmlqkMR2qoqC+O/4Kf5w==
Date: Wed, 10 Sep 2025 08:08:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818651F016DEFDD67CD137FCD0EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11674:EE_
x-ms-office365-filtering-correlation-id: 8c9ee0dd-9c47-4a21-0f4a-08ddf041452b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MG1vT09TQzdxV3VBcy9GTlZTUlkrQVdiZGZ5azRvb042MXlXcXNPclhu?=
 =?iso-2022-jp?B?TkJxL3kxWGpsOGxUTG44eW9iY09mRHFCeG5VMkxhWE5ZU3RuR3hIMnVa?=
 =?iso-2022-jp?B?S0JGcS9yRzBPMXJReVVLUjhKbXNzZTBvREM4d1Z1TlM3WXo4STA1eVIw?=
 =?iso-2022-jp?B?NVV2TkJYcU90Nm8yUGVhYU0xbWxzbTdkMGsrMHcxblVSbEdxTlEwU3Q2?=
 =?iso-2022-jp?B?QWhXR3FiQXAvNTVHQU9UNTV0T0pKVCttenpNUnkySCtXNE0yTVBHQmJL?=
 =?iso-2022-jp?B?Z1JCZ1MxQ0Q3QVpvVVFjRGE4NTYxKzMrRUIwNUxuOEY0anlCZmdUZFZs?=
 =?iso-2022-jp?B?U1BDM05NWFRKZlRBTExCcDFpWnZwRUMwczhVcDNsaDZmQXpXYlJUZWdN?=
 =?iso-2022-jp?B?NkMwUSs2UE5lSS84T1M3WDdoclNkV0dmWFNqUXoxNktReHRvY1FyVnpT?=
 =?iso-2022-jp?B?cisxdDlJMWRDRm9zNnl3U1NLVlNpVmpSK2ZiMGlqQml6RUZMOWdGd3pI?=
 =?iso-2022-jp?B?cXJOdmRXY3NZSUoycXdudFU4UGk1UDlXb2hJT0Q2VUs4VjhYaVZ0NDRC?=
 =?iso-2022-jp?B?SmR4TjJJdnZ5QzRQRCs0YmgwSzQ0WC93SW5yenk0cFRUV1hsNko4bVU1?=
 =?iso-2022-jp?B?TzNEU1pWbVUvaExaTmJBR21waDYyOCt5ZUJpdjV3dDdvTFg4SkZsa3N5?=
 =?iso-2022-jp?B?dlNyMzhBUWh5REI2MStRK0tYaFBNVWdsNGllZ2doLzBvZnhTMHdrcExp?=
 =?iso-2022-jp?B?K0RUUitwQi9Fak1RNUJ1VmhCQnpYd3lXQituQjF6VlZDWCsvK2RrakNP?=
 =?iso-2022-jp?B?NzVmdituMVJSZWc2eDBiNG50RlE3OHB1Qjc0NjY4Wlc1K1FCVlF1K25X?=
 =?iso-2022-jp?B?cHlqUzgxcFdIS1hjb0p0am5hUHR0RG15L2lpYm81eVVXNWlsYUN6YWd3?=
 =?iso-2022-jp?B?UW9PMjg3Zk9vVWRGWTQ4aHJDdmxZT3kvZi9USmtISlZoZUtyMVIrdVNR?=
 =?iso-2022-jp?B?MTFOWFNsNkhuR2hvUkg2Tk83czV5UWNwU1lxbVEwZkZCb1FTSFNMOG1D?=
 =?iso-2022-jp?B?OGsyVVhFUkZYZGFCSGlYa2l1b3ZjSFNkOUZEcW4xSWFXNjBIb0lUdkNU?=
 =?iso-2022-jp?B?aXg0bHhQK1BlTVg1L0pkcjdUVDlNMmhlTGwyOXF0NmhYYUlaR3pUSUtl?=
 =?iso-2022-jp?B?Y010ZGFIakNSUEJXdTJkS255eGordEZIRlU3YmFsODQzRFBPSGhNdGM1?=
 =?iso-2022-jp?B?ZjFKZlJIRktEd0haVm5sT1piREtGbW9DQUZCTEJsR0tLL0gvdFhoMGdV?=
 =?iso-2022-jp?B?UFh1SzBZZDB0QngyOE5LR2tmbWFTV3AxdzVYdDRna1FydEdmQjlyK1VF?=
 =?iso-2022-jp?B?OG5LcEx4RDhBRTNNYUxTTVhXbTQrcUluTnM2Qk53K0xxSGYzS3drMk5r?=
 =?iso-2022-jp?B?bG9HbGdlcmFEQkorbytuWHJHdDBhZjErRW5seit4d2g1c1lQUUd6MW0z?=
 =?iso-2022-jp?B?ckdlazlwM3pxZGVER2FaYU1zWm56WFlmWWhESHdTRU40bklyMVkvY1g0?=
 =?iso-2022-jp?B?S0FpVUlmMHVZTzl2VEpwb2tWVjduYU5TdE13Rnh6SWdvWnRDRitCYWts?=
 =?iso-2022-jp?B?VnlLczNwOEI2V2hSR1EyWnVFRmlBRkFjdTJBYkoxM284dHFPUUh1a3M2?=
 =?iso-2022-jp?B?bGtxSVdpSEtrVVEzUDIxSVB3blA3OVpWSmwyUnpPRXhPUytaUjlGK1ZR?=
 =?iso-2022-jp?B?L2FEMjYvaEVDYjgzSTlrMlRucVhyRksraWJJRXNhLzFOeHpCV2RJQlJW?=
 =?iso-2022-jp?B?TzJXcG9qMS9XWGpoZkd6TE55TTBoaFZTU0ZMblQzeW5jcGxmOWVObW0x?=
 =?iso-2022-jp?B?MWdlSzZPMzUxMXVXWFVwZzExNkJFYTdEU2NhQ3duVjBGZ3VaODJELytP?=
 =?iso-2022-jp?B?WHRrNVI0UlRnajNLOE9ZOVdNVzQ2OG90RVpTZkhtMTZWMmF0OW5iL0Fa?=
 =?iso-2022-jp?B?RHRwcFVYZ1puSFFqY3I2TXhVM3RRcU1CaWhhMTNIOU9ncHNOVGR6bS9V?=
 =?iso-2022-jp?B?TVBVUkg2WU15V1FSMXdjMGxUNThUVVo5c1prcGFBYVNkWmgwc0dkWkYr?=
 =?iso-2022-jp?B?OEt2MWpoeGxMSytsRnhFM3JKaGhDcVFJVFhXYm9YR3Y3Z3NjU3FxNHlD?=
 =?iso-2022-jp?B?ZW8wPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UXlUblUwYm0rcEcySklrbFFDTlUzamYvdUQwR3hUalhhbGpPV0I1ZFVP?=
 =?iso-2022-jp?B?TGhWWXBEQ1pPeXpQVnVyVVlqTzFINTJLenZLMVgyL3lINWh0RUxSWFdR?=
 =?iso-2022-jp?B?bHdFWTU3US8xZGZKajFsTmdEV2ZvVWJXSW4yZkY1VldGRGQ1bW94N0FS?=
 =?iso-2022-jp?B?L3hZUDJOZlNkUGtQY1dMZ0NBMFhTemMrT1NwalMwRVM5a3k5UzhxMlNa?=
 =?iso-2022-jp?B?dFc0eEJDNzZJVmhqQjlFeTBtNnk4R2lhM055ZDdWUWtTRW9qdTEvSysz?=
 =?iso-2022-jp?B?YjNHQkZNbGFBKzRVN3ptNjJXWFFiQjdocUhRcmRPVUpLa1JXSHRLcWFw?=
 =?iso-2022-jp?B?aFJHa3p2cmd5SVl2V3NicU1mKzM3UURVOXREanllOEszQU5LNlZXaWJj?=
 =?iso-2022-jp?B?MmRDQklKd3ZYN2lIcThyeFFXaDhvWE84VXRreXdXdURDOHEzK3JOTDlw?=
 =?iso-2022-jp?B?Y1JiRGkvOVFhSmljbUpQdFcwWVF2MXo5MnhMUFQvWTJINll6SGlBM3p3?=
 =?iso-2022-jp?B?Ukp3ZmE1QStxdGRRTmNSSkJtOHFVRFdGeXBjeGVwVlVhbHJrMWxGTE9Z?=
 =?iso-2022-jp?B?L25ZdWk5eGlwRzF3QkRJSm91eFNOcjhmM2FUVkh2NGg5VzVpZnN4ZlZ0?=
 =?iso-2022-jp?B?NmZzb1d2RmR6dzBNaEN5RXNWWEFMS1dNMW84RkdwTVF0WTJNMkJ1Q0hN?=
 =?iso-2022-jp?B?WWc2Q2Z1OXl1cGp6SGU1MXpWclRKUW5kakNRb2Rxa1VhSThqdHpld2xE?=
 =?iso-2022-jp?B?MmpXVGkrYUFZTG9yTjByQkYyYXR3VFJXaTBROUdvQ2QyNUk1VC9mcFoz?=
 =?iso-2022-jp?B?NGEvdDNWUnZ0MXFMMnRJc1hPMytibXJmOHlsaGZpMCtVbTdBSjQwODBP?=
 =?iso-2022-jp?B?eVliMzc5dmZxYktia2RiOGFSVS9sRzVBMHIzT3hkR1k1U0JocHF3SDZV?=
 =?iso-2022-jp?B?ZVpjdXBLZGVzZVozR1BwQ0R6eElLZlEzdzMwL2F6WVg3T0x4SWkwaVdp?=
 =?iso-2022-jp?B?VzVLNXZndS9qNjAxTFBibXczRTVFa3UvOUFzTFkyREtIaExOWHFRMWY5?=
 =?iso-2022-jp?B?OU1ibm9TaDZlTDFlSkRCY09Vc2VUeFU4NnNWM2tvZ1ZIV1BBakFtR3h2?=
 =?iso-2022-jp?B?U0szRWRzZS9wUWJIdVFWa2VZaTFTRHl2SWxua05GV0VpKzdtM1lLNlBy?=
 =?iso-2022-jp?B?Q2l1akx1UU5jUFczU1dSUG80a3VDWmRFWmYxZ2Z1WU5TeitpM2lpb1dz?=
 =?iso-2022-jp?B?TUxYTjVabUI2T2FQdGNPQWVEd0t5TWxHODVieUZHTWlFcjNqbDU1RTBM?=
 =?iso-2022-jp?B?ZmxDUWRkbWJyakRKQkZueUkvOW83TDk3bWNMdlM0Ykc2RkU3T2RObzBU?=
 =?iso-2022-jp?B?aXNhelJubHVZdG5MRndrV1EwRk1pY1ZydG9ndWFZUmhaVU5YR1p1dnFv?=
 =?iso-2022-jp?B?bi9udjI1WWVtdDlFZjMyVUNPLytwdGdTUEtPQlcrS3c4Tmtwc0JTbkZ4?=
 =?iso-2022-jp?B?YS9WSEtHb01jR0V0K3VpeENoL1pzSE4xb2Q0WStENUxRYnAyN0FsenAv?=
 =?iso-2022-jp?B?WE5laUJucHJyenRNclZIa0lNMW4wQzdNUEtHbDhVcGYwdTJBd2ZCSU03?=
 =?iso-2022-jp?B?VnFyTUE1Q05HbVVjQm00MTN3cTdTQkxnQkdoczRqTk4rSU9saDQ0UmNX?=
 =?iso-2022-jp?B?NTk5eGU5Rk4vSnBSeWdxNy9kaFpET1pueWhGdFNoaGJ6aEMyMjFaMC9k?=
 =?iso-2022-jp?B?SVRsS3ZOTjhTZGIyVVMwNzBLaGpiNHFzQUFWVlJwT0tNZjFZLzB3YWtF?=
 =?iso-2022-jp?B?aWY4SHJXK2xZZCt3UTZvMlhITFVjWXArM2tJcCtrb3ZFdlRPclgyZGxX?=
 =?iso-2022-jp?B?TWU2Ui9TekdIR0JnRzMvS00yV1VPT256L1htKzR1VUxpSTZsT0dNQnFV?=
 =?iso-2022-jp?B?dWt6YWhMMVJKVTF2R1F5WXduY1BVdGZBODdiN01xZkZROHd1T3V6OWFZ?=
 =?iso-2022-jp?B?OWo1UnBRSUpIcGdubW9aSHliMzVXa0xZU0pXNHBDWXpXTEkyMDU3RHpP?=
 =?iso-2022-jp?B?OWVkTFFkVnRLdlZaOURoOXVYWDJHcmp3MkMxN0ppQUlTZlJ0eGRNczlG?=
 =?iso-2022-jp?B?aFZDWW9aMlJlODUzTm1QTkFVZDd5OHhxT0JvT0dla1pyaDVuNmYyQ2tm?=
 =?iso-2022-jp?B?TENVVFlMVEZmVHhQTUpkSDVtSDlJODI0SjVwMk5rWlVYWm5XN3N6b2s2?=
 =?iso-2022-jp?B?RFMxbFVLaFdCRzBNMjR0S0pHNTR2bnEzSnlkNkRZZXdON01Yb05naWxw?=
 =?iso-2022-jp?B?amNhcUJkZ0ZBd08xTkx0MmFGNUZ6VU41eHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9ee0dd-9c47-4a21-0f4a-08ddf041452b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 08:08:47.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y88uwkyrlRAoN8pTXrFyPUKjFtYuL6wnOIdnBENw9WtJtiVRQcLSIwDgOgHb6uas24t+nWoePOI/uDYPCYKRuXPzqSf0eUgP1DxVVD9MsgJsLco4ND/sldHZiNR8wbec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 08:09:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20031

Hi all,

CIP kernel team has released Linux kernel v6.12.46-cip8.
The linux-6.12.y-cip tree has been updated base version from v6.12.43 to v6=
.12.46.
This release adds CRU and CSI device drivers for Renesas ARM64 SoC.

Information about this release is as follows:

  v6.12.46-cip8:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      7bbd509bd1edc32120cf3e551f887e4e6d75da72
    fixed CVEs:
      CVE-2025-38732: netfilter: nf_reject: don't leak dst refcount for loo=
pback packets
      CVE-2025-39676: scsi: qla4xxx: Prevent a potential error pointer dere=
ference
      CVE-2025-38733: s390/mm: Do not map lowcore with identity mapping
      CVE-2025-39693: drm/amd/display: Avoid a NULL pointer dereference
      CVE-2025-39707: drm/amdgpu: check if hubbub is NULL in debugfs/amdgpu=
_dm_capabilities
      CVE-2025-39686: comedi: Make insn_rw_emulate_bits() do insn->n sample=
s
      CVE-2025-38736: net: usb: asix_devices: Fix PHY address mask in MDIO =
bus initialization
      CVE-2025-39685: comedi: pcl726: Prevent invalid irq number
      CVE-2025-39673: ppp: fix race conditions in ppp_fill_forward_path
      CVE-2025-39697: NFS: Fix a race when updating an existing write
      CVE-2025-39710: media: venus: Add a check for packet size after readi=
ng from shared memory
      CVE-2025-39709: media: venus: protect against spurious interrupts dur=
ing probe
      CVE-2025-39714: media: usbtv: Lock resolution while streaming
      CVE-2025-39716: parisc: Revise __get_user() to probe user read access
      CVE-2025-39683: tracing: Limit access to parser->buffer when trace_ge=
t_user failed
      CVE-2025-39689: ftrace: Also allocate and copy hash for reading of fi=
lter files
      CVE-2025-39723: netfs: Fix unbuffered write error handling
      CVE-2025-39692: smb: server: split ksmbd_rdma_stop_listening() out of=
 ksmbd_rdma_destroy()
      CVE-2025-39687: iio: light: as73211: Ensure buffer holes are zeroed
      CVE-2025-39713: media: rainshadow-cec: fix TOCTOU race condition in r=
ain_interrupt()
      CVE-2025-39682: tls: fix handling of zero-length records on the rx_li=
st
      CVE-2025-38734: net/smc: fix UAF on smcsk after smc_listen_out()
      CVE-2025-39711: media: ivsc: Fix crash at shutdown due to missing mei=
_cldev_disable() calls
      CVE-2025-38730: io_uring/net: commit partial buffers on retry
      CVE-2025-39675: drm/amd/display: Add null pointer check in mod_hdcp_h=
dcp1_create_session()
      CVE-2025-39694: s390/sclp: Fix SCCB present check
      CVE-2025-39719: iio: imu: bno055: fix OOB access of hw_xlate array
      CVE-2025-38735: gve: prevent ethtool ops after shutdown
      CVE-2025-39679: drm/nouveau/nvif: Fix potential memory leak in nvif_v=
mm_ctor().
      CVE-2025-39695: RDMA/rxe: Flush delayed SKBs while releasing RXE reso=
urces
      CVE-2025-39718: vsock/virtio: Validate length in packet header before=
 skb_put()
      CVE-2025-39722: crypto: caam - Prevent crash on suspend with iMX8QM /=
 iMX8ULP
      CVE-2025-39724: serial: 8250: fix panic due to PSLVERR
      CVE-2025-39721: crypto: qat - flush misc workqueue during device shut=
down
      CVE-2025-39684: comedi: Fix use of uninitialized memory in do_insn_io=
ctl() and do_insnlist_ioctl()
      CVE-2025-39703: net, hsr: reject HSR frame if skb can't hold tag
      CVE-2025-39712: media: mt9m114: Fix deadlock in get_frame_interval/se=
t_frame_interval
      CVE-2025-39681: x86/cpu/hygon: Add missing resctrl_cpu_detect() in bs=
p_init helper
      CVE-2025-38737: cifs: Fix oops due to uninitialised variable
      CVE-2025-39705: drm/amd/display: fix a Null pointer dereference vulne=
rability
      CVE-2025-38677: f2fs: fix to avoid out-of-boundary access in dnode pa=
ge
      CVE-2025-39715: parisc: Revise gateway LWS calls to probe user read a=
ccess
      CVE-2025-39720: ksmbd: fix refcount leak causing resource not release=
d
      CVE-2025-38676: iommu/amd: Avoid stack buffer overflow from kernel cm=
dline
      CVE-2025-39700: mm/damon/ops-common: ignore migration request to inva=
lid nodes
      CVE-2025-39706: drm/amdkfd: Destroy KFD debugfs after destroy KFD wq
      CVE-2025-39701: ACPI: pfr_update: Fix the driver update version check
      CVE-2025-39691: fs/buffer: fix use-after-free when call bh_read() hel=
per
      CVE-2025-39698: io_uring/futex: ensure io_futex_wait() cleans up prop=
erly on failure
      CVE-2025-39702: ipv6: sr: Fix MAC comparison to be constant-time
      CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bi=
ts
      CVE-2025-38502: bpf: Fix oob access in cgroup local storage
      CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv
      CVE-2025-22124: md/md-bitmap: fix wrong bitmap_limit for clustermd wh=
en write sb
      CVE-2025-38272: net: dsa: b53: do not enable EEE on bcm63xx
      CVE-2025-23133: wifi: ath11k: update channel list in reg notifier ins=
tead reg worker
      CVE-2025-38453: io_uring/msg_ring: ensure io_kiocb freeing is deferre=
d for RCU
      CVE-2025-22125: md/raid1,raid10: don't ignore IO flags
      CVE-2025-22113: ext4: avoid journaling sb update on error if journal =
is destroying
      CVE-2025-38306: fs/fhandle.c: fix a race in call of has_locked_childr=
en()
    added commits:
      CIP: Bump version suffix to -cip8 after merge from stable
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CRU, CSI support
      arm64: dts: renesas: renesas-smarc2: Enable I2C0 node
      arm64: dts: renesas: r9a09g047e57-smarc: Add I2C0 pincontrol
      arm64: dts: renesas: r9a09g047: Add CRU, CSI2 nodes
      media: rzg2l-cru: Add vidioc_enum_framesizes()
      media: rzg2l-cru: Add support for RZ/G3E SoC
      media: rzg2l-cru: Add function pointer to configure CSI
      media: rzg2l-cru: Add function pointer to check if FIFO is empty
      media: rzg2l-cru: Add IRQ handler to OF data
      media: rzg2l-cru: Add image_conv offset to OF data
      media: rzg2l-cru: Pass resolution limits via OF data
      media: rzg2l-cru: Add register mapping support
      media: rzg2l-cru: csi2: Add support for RZ/V2H(P) SoC
      media: rzg2l-cru: csi2: Skip system clock for RZ/V2H(P) SoC
      media: rzg2l-cru: csi2: Introduce SoC-specific D-PHY handling
      media: rzg2l-cru: rzg2l-core: Use devm_pm_runtime_enable()
      media: rzg2l-cru: rzg2l-core: Use local variable for struct device in=
 rzg2l_cru_probe()
      media: rzg2l-cru: csi2: Use devm_pm_runtime_enable()
      media: rzg2l-cru: csi2: Use local variable for struct device in rzg2l=
_csi2_probe()
      media: platform: rzg2l-cru: rzg2l-video: Fix the comment in rzg2l_cru=
_start_streaming_vq()
      media: renesas: rzg2l-cru: Add 'yuv' flag to IP format structure
      media: rzg2l-cru: Move register definitions to a separate file
      media: rzg2l-cru: Add support to capture 8bit raw sRGB
      media: rzg2l-cru: Refactor ICnDMR register configuration
      media: rzg2l-cru: csi2: Use rzg2l_csi2_formats array in enum_frame_si=
ze
      media: rzg2l-cru: video: Implement .link_validate() callback
      media: rzg2l-cru: csi2: Remove unused field from rzg2l_csi2_format
      media: rzg2l-cru: Use `rzg2l_cru_ip_formats` array in enum_frame_size
      media: rzg2l-cru: Make use of v4l2_format_info() helpers
      media: rzg2l-cru: Inline calculating bytesperline
      media: rzg2l-cru: Simplify handling of supported formats
      media: rzg2l-cru: Inline calculating image size
      media: rzg2l-cru: Simplify configuring input format for image process=
ing
      media: rzg2l-cru: Remove unnecessary WARN_ON check in format func
      media: rzg2l-cru: Remove unused fields from rzg2l_cru_ip_format struc=
t
      media: rzg2l-cru: Use MIPI CSI-2 data types for ICnMC_INF definitions
      media: rzg2l-cru: Remove `channel` member from `struct rzg2l_cru_csi`
      media: rzg2l-cru: Retrieve virtual channel information
      media: rzg2l-cru: csi2: Implement .get_frame_desc()
      media: rzg2l-cru: csi2: Use ARRAY_SIZE() in media_entity_pads_init()
      media: rzg2l-cru: csi2: Mark sink and source pad with MUST_CONNECT fl=
ag
      media: rzg2l-cru: Mark sink and source pad with MUST_CONNECT flag
      media: rzg2l-cru: Use RZG2L_CRU_IP_SINK/SOURCE enum entries
      media: platform: rzg2l-cru: rzg2l-video: Set AXI burst max length
      media: platform: rzg2l-cru: rzg2l-video: Move request_irq() to probe(=
)
      media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G3E SoC
      media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G3E CSI-2=
 block
      media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/V2H(P) So=
C

Best regards,
  Nobuhiro



