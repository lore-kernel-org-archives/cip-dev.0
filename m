Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC50C369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 05:11:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.6119.1744953062986887988
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 22:11:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=jT9yrUTU;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1744953046;x=1746162646;bh=o3
	76jlpq3/N0H9jYKt6IRcOP2oNtRBy5Cmi96T94kdg=;b=jT9yrUTUM3rt3nSl0v7cRo9SW6X8BQxu
	8ixYZ7ARjtpLAg/FcPACXJuDMII72gSKLkRsAYBkzE5sKnmhWo8lJrlqZG+EkjjS4GFFl9R+gg3wS
	KSt88/d3jR7v88dBe20EGhN5b/KWSYtKUw1MgwiHRiD86DS5zEFo3aujuOHHm9OA1M2IQa9gce7wv
	rBnOn6afey2uZ8yuELxJyahoLkEqAWDsKVtipTYx/V5r7mimArY9og87Yqk+vOF7AweaA0KK5uIbW
	oMKf0o+QGuQyaaqYDUiETTFkq8u7sLdZfc53CBtwC1d6LakkIolOjQSq5FR11L0qAoTclEAvjzZeI
	hA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 53I5Akx01986701; Fri, 18 Apr 2025 14:10:46 +0900
X-Iguazu-Qid: 2yAbRDIdvKfiQtE07V
X-Iguazu-QSIG: v=2; s=0; t=1744953045; q=2yAbRDIdvKfiQtE07V; m=GTEa+oP65q77NQ4LVPUE574LpFg02r1iJczIToGTTDQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 53I5AikH1451174
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:10:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktal6SyteMlP0dGnKaAXFhgqmb0v3qoHkPdjCtc8MRiBFreLrjMeffV87aQIcQbdILVlAs5OwWNIxs0TSJ7OeY20/gHW1sz7hNcAsMLIIT4evx3g6DI7CTZ9WHv9Zn3IqVWGNK+NKDyRLnSizFZcvh9fM50WtmocT2QgtTUza/u/FUjaqIU3EaFrQ+fmin2nQaQz9iHSeY6TQw5CnfDvM/dg775ZkAj4xaFqynz4jnn+M+cz8iEJ9Yue6YgoS10BzlEDdUwA4dTEiBhGzQlfq/hnsIVxD4wHupDrLQRY4ct7XBWXDySiF8ichdmazAcWD98BOaCyGLvCk2gwvdhSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEzfyj6PMwDvoJb354BYfRjWKPEAt57BpWgwjlt8LmE=;
 b=XQal62fvqNOGB5uCJK4LLFzV9IRuLrCXgX3f2NbZ8DGRVjVJPSHEYPrAHPqq4r68bnNg/4gVV8hPYYPNustezhxvSSzgPlS/MPQ/q4k01DqdL+CQ+XwMmO0sGI/G63vM44te4JI7d2bf7gLE7uDsM1C6yxoleGBHLIxX3DwwM1QcWkzrHvbqmRq5Je95vGDH0n/rjINeeIDdrnZLPj8kVouTyWJn01JreznUy07E8AMPJM7fHgxRtNzE2xbSccI5RHIaoYvAY1vFqW/gG2qER/4YHghF8iLZiMnjgYQeuXOKUDH9YvVZnRg5QK6au5lUGzpPUXOZK5FFvJ0T3aHaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.236-cip59
Thread-Topic: [ANNOUNCE] Release v5.10.236-cip59
Thread-Index: AduwICAxJMd7x5naTpuy3rvZjDxSag==
Date: Fri, 18 Apr 2025 05:10:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481800CE8C1C512814A57F3592BF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB7176:EE_
x-ms-office365-filtering-correlation-id: 26281db3-4977-4656-fc72-08dd7e375ae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Yy9QNlN5UStndFkxa1E2VC8raWVHbDJGQ0xzRmJQc0RWUTNzTzR5dFBp?=
 =?iso-2022-jp?B?VDNOT2orTndBTHNjODFaaEhoU1NNTTk4Y3cxZ0NyNnE4cGJxeFdybTE3?=
 =?iso-2022-jp?B?NHJ1UU11ZEQzYzArdXNHZmc4QnNRS3hEMC9TQ0RzdWtUWnlFVDVraEZ3?=
 =?iso-2022-jp?B?bnY3VjI1UnJHVWQ4SzFFazIyc2R4KzQrM29wajJVK2hWK0xGT1VYVDFQ?=
 =?iso-2022-jp?B?Y3lWc09tREtjSXNzVWhrU2ExdUhJVi96cXlZSzRlaDV1aVpDYnQ3L1JH?=
 =?iso-2022-jp?B?WnJsbHpiK2x0L05nSTZhMFZVdlhtOTY3aE9OZklJc3EvODBiWkdDM0ZY?=
 =?iso-2022-jp?B?L1BhQTJqQmoyYW5lRlg4T0FqNUFoN0NUQzJ1SkdwV3plbDZCZElveURs?=
 =?iso-2022-jp?B?RllCM0VGYktLNVE5NURBbmpXUWtxeUZNdG9JMU52MERkV1BDOHZBY2FT?=
 =?iso-2022-jp?B?Q051VlJMbDQ5OVhKbHRWY3VuUElTQlRSdjd6MnFMN25ocVlGYkdCWHBh?=
 =?iso-2022-jp?B?ZDNiQXkyUDN5ZUY1VDUvMnBvYkZnZjc1TlBoNVFNOWpraGJobXVuWEF3?=
 =?iso-2022-jp?B?QjNGVm5hL3JRd3NCTzBVU05VQUdMSHZFRFl6WXh0S2VjWWUzRFQ5ZkFG?=
 =?iso-2022-jp?B?RGpkU1dqSDJadUpMbDlmTnZ2YVNiOHRaMkxTRFA5TTM0aHlVTFhLRkVW?=
 =?iso-2022-jp?B?UXEzWEdoZzQrMzNPUnd1NklRRVczaTFpMHJnQjVuY0hVc2ZrZzNRODR1?=
 =?iso-2022-jp?B?WXZOemVORUFhVncxcWVCd1dlNHBsWmdPVmczUW5PNi8rSjZZdWdRQ2cy?=
 =?iso-2022-jp?B?a1VIM3daODlWUVRZV1hnSUN3MExWVDYvTk5NYTJybHFnc2Q0VFZiVkdR?=
 =?iso-2022-jp?B?SHluQ2w5R0FNWjNFOHpXVU82LzZhdS9oN0JmbVpublQveUlHYndFb2Jy?=
 =?iso-2022-jp?B?WWRrbHpNMkxFbG9URS83RmUzQWl2K1ZRTzdDMUFlaFdpWHN3S1RHZ3dZ?=
 =?iso-2022-jp?B?TlZzUjIvbWZBeWZlRVA1WHpwSFpLRlVlSzI5bjArQkFxU0lBMjZzNE9D?=
 =?iso-2022-jp?B?WHBmejlSWTBvekpneU9KSUNmMkdNa082YnA1djlBVzJNZzcxZUJuclUw?=
 =?iso-2022-jp?B?a2Ivc245UkhFVUZWR2NOVi9QMDBQa0lRQ2xGVnAvbFVja1REREhvL1VI?=
 =?iso-2022-jp?B?ZVFEUk9xR285NnViOEs0ZGJQYnBsQjY1cFBlL2w2bmdDTW1EWmE3a1F5?=
 =?iso-2022-jp?B?L3ZFci9TSlFUbDFjMWxzbGFTNVNOb3c1R1ZGdGZHaVI4NjQ4K1FxUU03?=
 =?iso-2022-jp?B?ekVZdWJyNm5xZ3NMQVUwZU1jMTBRNFZONmwzenJKY1YzblNFV2JEZi9E?=
 =?iso-2022-jp?B?bGJVQURlRnJBUzZsRXBlcXJhMnhMK01kTXZTNkpjRXROODlyTVprZStz?=
 =?iso-2022-jp?B?TW4ycGxvd00zdEg0bXRuOFNxSXMvRFMyRHpLU3ZieVB6MTlTVk9DSEhp?=
 =?iso-2022-jp?B?aEovUDgrUkxCQWxPa2pFeW5MMDJSYXNKSTZzbjR4Y25yNXhneWVIUHQ0?=
 =?iso-2022-jp?B?d2t5SHNNRzVKT1lCWHNVMXRTMitGaUFmeTlrb0FodlF4a2dFaWRCb3lw?=
 =?iso-2022-jp?B?REZBNUZjamthSkVGM0JtMVBBQlZJOHhpTzFmMXpiNHoxejZCUVdITUdp?=
 =?iso-2022-jp?B?a3ZING1idWg1TDR5MlJoMHVFR0REQm1PR3cwV2NDSThLZDhPNWxRQXpj?=
 =?iso-2022-jp?B?OHRRbzdJaFlEYTFnTHprTzlOZm1qOGdLcmZCcERYQzEzQzhkZ0p2Q2tw?=
 =?iso-2022-jp?B?VmlXdWlMaFhPOER6MUwzcWlqQVY5UndBZUQ2RTNyNi9LZWRkMGh0MUha?=
 =?iso-2022-jp?B?dTlPVWR6NlZ0NFVlSFhhNmtsVU1MankxYzA3NG9ET2U2NzMvRFRGR0F1?=
 =?iso-2022-jp?B?cFpRaWpFVzBmUXFwem5GdE9ZU3BObTRWVk9zaG1oMzFLbDY4Yk9GR3E5?=
 =?iso-2022-jp?B?NTVWSEF6SlBNbFE4dzh3ek81QXlyQWZHcUR5ZVovQUpoS21XMUZPQzJH?=
 =?iso-2022-jp?B?amNiMWptbVhNZWZJTGhBZ3haUnhUQlFmM3gvVEo4MngyRHg1Mkx4ak54?=
 =?iso-2022-jp?B?RXVyKytmdmltSGhPazV2c2daa3RnNFo0UnVFZmVsK0poTW9BNGdBQ2Z5?=
 =?iso-2022-jp?B?NjVjPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SVRxRG9RVkwzV0FHT1dwN1MwVFFtclR2ZDh5eTVKd3c1M0l6c0JRaE9N?=
 =?iso-2022-jp?B?VFlodHF2bm5XWmtIVUwwNE9iRjc1aFFOWHREcEEzRE1obWxCSE1SQk9x?=
 =?iso-2022-jp?B?OThEVmxZS3JkQzdqc1VVMnJBYVl1ZWw1WEdYbGZvMFJnMzV0bFBnSGlD?=
 =?iso-2022-jp?B?RzE2aHdvVnQ1Z1VvaUxKWVNWM2wzaFA2bWd5bTdzeUZhS2VSMGtEMTA1?=
 =?iso-2022-jp?B?bXNQNFpqWnorMXVMVUFZQWVFRU9ZVEMrYjMybklXdmhDWUl4azNnQTdz?=
 =?iso-2022-jp?B?UG5yTEc1WXIzUmtBR2ZibXpHZ2F2c1F4V09TRVNVUHR1bTRmVVJud2J4?=
 =?iso-2022-jp?B?cGwwOGZneVdZVW12WFBoVVN0Ni9TUjFBTjlUNyswaFBRWkI4bjVyZ3Zo?=
 =?iso-2022-jp?B?VDZLZUxNVXo2MlhYbmU2TFNwT2dkVlhKa0IwcnpFUWtRNDJNVmFkZ29r?=
 =?iso-2022-jp?B?aHkxSVp4dU5hdStmaU96YW03eUc2c1ZUU2UyeXRzdXY3SXFCSVJsY0tq?=
 =?iso-2022-jp?B?d083UnY4SVhNbi83b3kxSVE1SFEyaGFjS3dQU002UDZ6YWxCTnFOYmJQ?=
 =?iso-2022-jp?B?cmFXdS9FZHZwelBoVVBiOHZuY2ZZbXpoUEduMyt1a25jTDVmTzI2TFZ5?=
 =?iso-2022-jp?B?R0pHVmJFNDFicDc4WkVyTmREaG5RaTR0QUlPWWkvTDJianAyQ2hKNm9j?=
 =?iso-2022-jp?B?TFFJUWRJcjYwL01pVXZBRDBGbUlrK1JXWG5qYTFVYmxWbk03WEdkSGxV?=
 =?iso-2022-jp?B?ZGNVaW00aW5WRkxoeHQ3dXBsZXppOVp5UVIzNnR5QjJURFVrclYzM0h5?=
 =?iso-2022-jp?B?U3pWbE5XV3RXVkJQOE5nd1NSK3BvUWhPQytrdVF5UVNqSTFLeHN1aW5o?=
 =?iso-2022-jp?B?WXdmWlRFdUptUURVbnRtazRxT1U4WC9PYm9QUmxQOXUvSy9VRlpwdHcy?=
 =?iso-2022-jp?B?cXBkNmRySys3UFZLL0lLTmFNdklBbTFLK3pVZnc0ZHNYaGp4dDBKY3Rn?=
 =?iso-2022-jp?B?RkZFRHpjSVNBNmM4OWQ2K0FzRGVkcjZwSTA1SWNHVHVXWlY1eVZoWFpx?=
 =?iso-2022-jp?B?WGExd1NVSHFFNlV4all1RFZ0TTB4YVJEMVBIaS9WTCsxZURNRGgva1Jt?=
 =?iso-2022-jp?B?OFgzMnJ0MHlkQm9nQnVFODc1emdPNmI1WVoxei9Rcm13MlNKZWpRSkVS?=
 =?iso-2022-jp?B?MTByN3BZbGxpQy9oYXdIMHZXZm0zR0M4T2pRZ3NEeXVaN0UyaDZ0Q3A4?=
 =?iso-2022-jp?B?YXdSTlcrKy9vNHljSnFQbG54bXFMMzJEOEthcjRqNHYrNkp4bTdEMDdm?=
 =?iso-2022-jp?B?OWxSODNGSkluQkZNN1hvQXovRDRGSkcyZHlReEJkTm51MkNwWG9RRGVq?=
 =?iso-2022-jp?B?M0JWNSsyWlVCOFBhbUJMWGtFdmZEUzFtVDFSVHdDLzdRTTVsa2g1WjBv?=
 =?iso-2022-jp?B?WmxKa0QxUXRwb2hXa1NCYVBGdUJmNWVrREFuTzJKb0FqZmV5dzZma2FR?=
 =?iso-2022-jp?B?dXRyQmFkQUZZdS9rem10R2pPa2pXdldLNzFiK3pZNDVQL09kOTJYbnJU?=
 =?iso-2022-jp?B?N2g0OWpZeUlBWEU3ZDYvQmlyTHhhMUVvQzJjYXpGa1RiWmhPT0VNRGh0?=
 =?iso-2022-jp?B?N25FR09TcHdRNTAzZ3MyaXpWeWZxaEgxbVcyS3FxK1paUUJ5cC9iR1lK?=
 =?iso-2022-jp?B?UktwYWdSdnVrYitXd05UbXlubmpLWDJ2R1lCd2gya3NMTVJGYnNMRTJh?=
 =?iso-2022-jp?B?SHFZbUVoQzlqTXNJdEdEMjBBTUNzQ3cvVE1ValhSS2NDUk5pYmQ4dFp3?=
 =?iso-2022-jp?B?ajdaRlR3b3NUaS9mZFhYbVBBVU9WWkRSUURQQ21nZVBLRXJ1NUc3Uk42?=
 =?iso-2022-jp?B?ZWo1YS9pYmx3dHdZK2pQMW5rUUNZb1VHUWRXZUE3OFNXUDRjYmMvVXk2?=
 =?iso-2022-jp?B?bWl0WisrdDllMm1PelJDdjRRMzczcFFTU3ZQeFhGd2FBOFZlN1JINkFD?=
 =?iso-2022-jp?B?U3N3ckdxSE5tTlI3bVhoQ0ZaUzBaUlJGclMrMVkzUkkzUUI5TzFqMnVZ?=
 =?iso-2022-jp?B?djl0MVEvQk5VUm92dVVMa3NuWE5vZWZpQ3ByZWw5RGZEb2FTd0VUNTYw?=
 =?iso-2022-jp?B?Y2dNak9rOVdkbUFQeVdEV2RmR3FKQWpPcWJtV3pMNk9OU01DVU5NQlE5?=
 =?iso-2022-jp?B?ei9FdjAxK2N0V1REWXpGOVdQTXJvZW9zSW5DL09uSFRwaks3MHpPWGVl?=
 =?iso-2022-jp?B?ZVVheGRvcjRKZFozQlc5czRRSzlvdGFWL1AxdFFUSXpXYW1JS21ObUpu?=
 =?iso-2022-jp?B?Rm5JZmJYeDJiK0VPSVhKNUhpRzJ4MUtiMGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26281db3-4977-4656-fc72-08dd7e375ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 05:10:36.9726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V26M7AdKzeGUDGWgZhm7Ia0onuqEC6+C7UUjmmEih77Y1znMlJnZoHMganr43batn8MEW/Kd5LYJg4onK0LNaXC8AgOaXuvFpSNQa5BOhRbeQvFRfHm1E21+OYrk/eoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7176
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Apr 2025 05:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18526

Hi all,

CIP kernel team has released Linux kernel v5.10.236-cip59.
The linux-5.10.y-cip tree has been updated base version from v5.10.235 to v=
5.10.236.

You can get this release via the git tree at:

  v5.10.236-cip59:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      dd908a8bc2a5540570d8e47f852d108d7e31f56d
    fixed CVEs:
      CVE-2025-22008: regulator: check that dummy regulator has been probed=
 before using it
      CVE-2024-8805: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring w=
ith LE
      CVE-2022-49728: ipv6: Fix signed integer overflow in __ip6_append_dat=
a
      CVE-2025-22079: ocfs2: validate l_tree_depth to avoid out-of-bounds a=
ccess
      CVE-2024-58093: PCI/ASPM: Fix link state exit during switch upstream =
function removal
      CVE-2025-21992: HID: ignore non-functional sensor in HP 5MP Camera
      CVE-2025-22055: net: fix geneve_opt length integer overflow
      CVE-2025-21975: net/mlx5: handle errors in mlx5_chains_create_table()
      CVE-2025-22071: spufs: fix a leak in spufs_create_context()
      CVE-2025-21968: drm/amd/display: Fix slab-use-after-free on hdcp_work
      CVE-2024-46821: drm/amd/pm: Fix negative array index read
      CVE-2022-49546: x86/kexec: fix memory leak of elf header buffer
      CVE-2025-22018: atm: Fix NULL pointer dereference
      CVE-2024-56664: bpf, sockmap: Fix race between element replace and cl=
ose()
      CVE-2025-21779: KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if loc=
al APIC isn't in-kernel
      CVE-2025-22010: RDMA/hns: Fix soft lockup during bt pages loop
      CVE-2025-22020: memstick: rtsx_usb_ms: Fix slab-use-after-free in rts=
x_usb_ms_drv_remove
      CVE-2022-49046: i2c: dev: check return value when calling dev_set_nam=
e()
      CVE-2025-21941: drm/amd/display: Fix null check for pipe_ctx->plane_s=
tate in resource_build_scaling_params
      CVE-2025-21999: proc: fix UAF in proc_get_inode()
      CVE-2025-23136: thermal: int340x: Add NULL check for adev
      CVE-2025-21981: ice: fix memory leak in aRFS after reset
      CVE-2025-22021: netfilter: socket: Lookup orig tuple for IPv6 SNAT
      CVE-2025-22004: net: atm: fix use after free in lec_send()
      CVE-2025-22035: tracing: Fix use-after-free in print_graph_function_f=
lags during tracer switching
      CVE-2023-53034: ntb_hw_switchtec: Fix shift-out-of-bounds in switchte=
c_ntb_mw_set_trans
      CVE-2025-22045: x86/mm: Fix flush_tlb_range() when used for zapping n=
ormal PMDs
      CVE-2025-22086: RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow
      CVE-2025-21996: drm/radeon: fix uninitialized size issue in radeon_vc=
e_cs_parse()
      CVE-2025-23138: watch_queue: fix pipe accounting mismatch
      CVE-2025-22044: acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
      CVE-2025-21956: drm/amd/display: Assign normalized_pix_clk when color=
 depth =3D 14
      CVE-2025-22063: netlabel: Fix NULL pointer exception caused by CALIPS=
O on IPv4 sockets
      CVE-2025-22014: soc: qcom: pdr: Fix the potential deadlock
      CVE-2025-22025: nfsd: put dl_stid if fail to queue dl_recall
      CVE-2024-38611: media: i2c: et8ek8: Don't strip remove function when =
driver is builtin
      CVE-2025-22075: rtnetlink: Allocate vfinfo size for VF GUIDs when sup=
ported
      CVE-2025-22005: ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check=
_nh_v6_gw().
      CVE-2025-22007: Bluetooth: Fix error code in chan_alloc_skb_cb()
      CVE-2025-21991: x86/microcode/AMD: Fix out-of-bounds on systems with =
CPU-less NUMA nodes
      CVE-2025-21971: net_sched: Prevent creation of classes with TC_H_ROOT
      CVE-2025-21959: netfilter: nf_conncount: Fully initialize struct nf_c=
onncount_tuple in insert_tree()
      CVE-2025-22056: netfilter: nft_tunnel: fix geneve_opt type confusion =
addition
      CVE-2021-47489: drm/amdgpu: Fix even more out of bound writes from de=
bugfs
      CVE-2025-22054: arcnet: Add NULL check in com20020pci_probe()
      CVE-2025-22073: spufs: fix a leak on spufs_new_file() failure
      CVE-2025-21993: iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in =
ibft_attr_show_nic()
      CVE-2024-46812: drm/amd/display: Skip inactive planes within ModeSupp=
ortAndSystemConfiguration
      CVE-2022-49636: vlan: fix memory leak in vlan_newlink()
      CVE-2025-21957: scsi: qla1280: Fix kernel oops when debug level > 2
      CVE-2024-46753: btrfs: handle errors from btrfs_dec_ref() properly
      CVE-2024-53144: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring =
with LE
    added commits:
      CIP: Bump version suffix to -cip59 after merge from stable

Best regards,
   Nobuhiro


