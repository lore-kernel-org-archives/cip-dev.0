Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05BC02192
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 02:55:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.107588.1738637721833437518
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 18:55:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=Y3Y4r+0p;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1738637720;x=1739847320;bh=nguxhrs/db1HpQO8juj2DMUp9stqjnj+KwSJfgs
	L2WI=;b=Y3Y4r+0pqdzNjdnzvLQiXd7RLF5NAoLJIKGOtt2Rq99cb9ereaVkZqBBCK04Ek2L4uIRw
	i3gTh1uR90q7goQ+tzEqJsYHbQpJ+IHhZ3W6kkVTpIvKsa6fPeao4OTEUaFsW31LqcOkyyaO1UyZw
	2Q2+91sm7072NscAEw4lTDWkljqaqar5hq1fpK9uZiz7jXOW0MEVPyvC9OIwGSmsKlsOZA0YoUynE
	hgO54my4+iCA4uAclMxwrNGfcxp3d8VLz3nJC/WKsy77tN4MDfbYj5Fo62vc3kuh4HWnhhJAjBnAz
	al3EOIhoBBJeaxpXLDeWzfhUntDulQXjibN/sPiShw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5142tJ7m708891; Tue, 4 Feb 2025 11:55:19 +0900
X-Iguazu-Qid: 2yAbAvUQLBk7F9jqTZ
X-Iguazu-QSIG: v=2; s=0; t=1738637719; q=2yAbAvUQLBk7F9jqTZ; m=yHrx4FJFRX/4ZDPcauZHvhqIAau6eA4o0xgbBJWiGS4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 5142tIsH1986626
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 11:55:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOpxj52z1WGsrImM/wNn/Bp8ZihAKkOrlkCYxpdbLSDWnrH569ojXGVvoQbT9zO6UKyStit2R1wYPAo+jQ8IgC6MBUMPjf8LPUbBuxOIcz4J5TWrQIps1xfRNKIqClfksgycjH+yiQ/I0NHN2WDZYFWXuWjWu3tPldy95DB1NGVh4wjUmNKFIl+SDM//cf2rZLuVMIzvaQ/l7gLGQIDyFrCW1TJC2vXeuI6T8XxHv5qE4XdUAA6whHvmHgYpFg+VoGghP4oF1tcYElfgcN9LwqIELRKhBjeno3BgPEyx/WHmESi4zez7Yn9l+JhU95uT7sqN9RwkMHNh5LaAjZPTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nguxhrs/db1HpQO8juj2DMUp9stqjnj+KwSJfgsL2WI=;
 b=PtNvxspuc5Y5EjE6nfz1J5A/2P66fdThScLtL55PZIgr4D2NFkyLUyqUvW+qiD2iFpnoJj67yNUuOoF13Nn8w6m+5sWhUszFEncqFnUeb5o8ox3RzhjCtQ4sd3qfyqVzBeInjWXfH0x1Usej4ESiqSLsim8TtLRhnc0cYP/A2/cm7153l388rZf1kwA8h8uaOGKBFFNNtRIPm058yaUxDowwb7X1n3ue3/FdCcGZOS8BRmP+mrZSB/HGk3MZcMQJz1FvtvF1rJ79bTj2VRSC8JYunqAXvuy8/aEipbSaaEYDmBcRRrpDk25A2Ljnn873ZTp2Zqh8DaR+LRXIf6p/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzgBe04HoAA8CxzMAAdclSAAAvSl9ABozn5EAAHqe8AAK60BEAABDzHQA==
Date: Tue, 4 Feb 2025 02:55:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385FD70540FAF1AB43F8FD3E1F42@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <Z0mVe42i41SXemYu@duo.ucw.cz>
 <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz> <181D46DD0F426F98.25327@lists.cip-project.org>
 <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5zP3BaPnG5x/d6/@duo.ucw.cz> <1820DE7A882DDE50.15786@lists.cip-project.org>
In-Reply-To: <1820DE7A882DDE50.15786@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYBPR01MB5422:EE_
x-ms-office365-filtering-correlation-id: 5c0cb0fa-cacb-4fcc-5232-08dd44c75acc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UmtXVExaNG5HN2xybEx6d01EVWgvbVA2WW5nYk5vMnliaG0vRndLZGVz?=
 =?iso-2022-jp?B?V0VzejlZMUlaLzkyNDZ2R1Nod3FRMVFDcE5sOFJWZmcvUlNCbjVpWFFt?=
 =?iso-2022-jp?B?Y1I1NGhKVHBWdGxnd0U5RTNxdFp1UVRoYkV4U1g1dy9hRXJpSUN4L1lh?=
 =?iso-2022-jp?B?VEVpWm9vK2owNDhMZ2gvcDY0cWc1c3g5OEhPbXB4TlUrSXNtMzdML0xX?=
 =?iso-2022-jp?B?TG90SnFTOEwvMVpKdkEyeUo5dDU2UzFueFZ0bUttZVZPbDZGTFNnODYz?=
 =?iso-2022-jp?B?ZWZmR2JnS0ZiZFo5a2UyYlFzRWRQMDFvRnVxaFJUck5nNjFCVldyVVpW?=
 =?iso-2022-jp?B?V3lYemoxQmVxbWMxd3F3WVZXaTBEblM0WjNIOHVTOHJhb0ZBckRQcVNN?=
 =?iso-2022-jp?B?THpmV1Z4RFBqS2dkay9CUnJ0Ty9jay9pUzFsWXRaNjNTOUNJTFpZTFd6?=
 =?iso-2022-jp?B?UzIyL1czNDhCTlcvOVRXd3BRMXpYd0hHS2JPMWloL0pmMjJZSG5MTTRL?=
 =?iso-2022-jp?B?LzlabGZhK3pSWktETUxBNk5LMDViZTJLYk4zTE1WYlNqMFZQZk93RXR4?=
 =?iso-2022-jp?B?UHdtWmI3Rjc1ZUxzMG95SjVIU3VzSS90dWxnZ0VWNTFsZnYxbUxtanVJ?=
 =?iso-2022-jp?B?aDFtREsvcnE3NTREbzZnYnpYbkxXT01Gb2E1U3dKcjA5Yk1PY3JtVDBP?=
 =?iso-2022-jp?B?ZVFaSUdsamdOUVdkelZIYitBcEhwUjlMK1VBWkRKc0hYQ0NtMXdNZ0hw?=
 =?iso-2022-jp?B?N2ZmV1dncGZPKzY2YWlZNWlPczQxcGY2clFPamNDaEhnalBuRUdEWUQx?=
 =?iso-2022-jp?B?THl6SHg2Tm9kVDBTTEt0MlJ4SUtMUUJSc0FEZ2ZpWTZMTFFnbkp3aUFR?=
 =?iso-2022-jp?B?bjNNUWsvY1VWejBRSGN2VmdLNzNUUStRNjZoWTVyZFl2YUh5YzBUdVI2?=
 =?iso-2022-jp?B?RVc3N1RBNjkzaTg1cDkxMnovazZ6ampnNERGWW1majJhNXkwd1lHTlNL?=
 =?iso-2022-jp?B?aFdUYzZvSmMwQisrQnMvd0xJSFBvU0xrVGFrbHh1Qmxsb084YUNvd0RH?=
 =?iso-2022-jp?B?QTI3YU44T1dzV3QrRlFhV3JGeUtNWnZUVWkwMG9EUXcrVy8xQ2tmcU9Z?=
 =?iso-2022-jp?B?ZmwwL0wrVlBPaHFCSVVYRUEybWxvVkZDYmgxeTdTY2k0L2E2MWRNQm95?=
 =?iso-2022-jp?B?NUZIR2drM1BHenNUNENWamp4VXVCOXBNbnRQSE9EeG5JOVhrT3pEVEdk?=
 =?iso-2022-jp?B?NUtXNlA1a2crL2FqSWhNZFptTDU5UTBtWktyS3FXRmlWOWJod3J2ZDhj?=
 =?iso-2022-jp?B?cXgyUlBTOHduUzB0ZEg1SmgvaGVIWWZ3VVVIY25odSt3N0h5S2dFenZF?=
 =?iso-2022-jp?B?MHhpamJIeklsRWd0Zm9lTHc5QjRuaHBBQzE2V3NLQW80cithL1ROVUs2?=
 =?iso-2022-jp?B?Z092aG9wZmxNZU9HZE92eURGWi9UMktJaTBhQVRBTVh3aDFaNnZEekhm?=
 =?iso-2022-jp?B?b1VORHBnM3d1MGpxOGdsTGFjOWl2N2ZkY3ZpMUQ4aC85SngyaTYyVjNU?=
 =?iso-2022-jp?B?bjB1UkJlbXNGUDhsSmxScGtETGhSRlhqVDVQVXh3SWxudERGN3B6M2gx?=
 =?iso-2022-jp?B?Sk9kZ1Z0emtHOHprZ0ZsbXJuQmRzTmZuY1R1K2RmNkFsNlNkYzM0S2Vl?=
 =?iso-2022-jp?B?eFR1QmtWN0tMa240TmVBR2kvUElvWkN4bW43ZjNkNTByRVdWZWtQam1h?=
 =?iso-2022-jp?B?d0JabVQ0dHVHNnVVbVVTTTJaWXZaQmpCd2NnbEl2RldZRjROSFFOWERh?=
 =?iso-2022-jp?B?TXEvdk02OFN2VzNwNXZFSHFDV0dkaWRQYU0zVmtkemM3Q3hVR2dkN3JT?=
 =?iso-2022-jp?B?UUZkZTBhNWEvMGRFNVZEM0pqMXFPWUpGdW9mcWw3bHpDZlZvbW84RVNy?=
 =?iso-2022-jp?B?b1FzanJleUxueXFRRHJMOVZlREFWWWgrYWZIQS9US01qUGZuWFhVTXFn?=
 =?iso-2022-jp?B?azM4dml6Z29ZVGJSR1FuQythckd2SE1LVHZ2MnlTSzFxaW9VcklRTUVi?=
 =?iso-2022-jp?B?OW9CendQU3o5M1pEUGdLU1UwUCtKTEk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UGdOT0U4SVlTblBIYXlwYUVjekZrVU8rMmswd2s2REZDWFRHQldOYjBp?=
 =?iso-2022-jp?B?WUtTc2hhVDQ2YUJrUnMrQzVDWDFtLzYzMjFPN1lBY3gvWWZmajFQV2NX?=
 =?iso-2022-jp?B?Y1dkTHdxL2lnd1dmaTFYczBvdkN3eVVmM1BUZ2IyU3pNVEVHOXhNQ1lM?=
 =?iso-2022-jp?B?TmtFai9abkRlNm00aStKa3RyNS9ORXh1dmF0bkVKaUVDL3RKdTljRHJH?=
 =?iso-2022-jp?B?VzNBcTZ5TTlRd0RseW5RQ092MlBaZXo3TXFDQVdtVktTeG5pNUJDcDBs?=
 =?iso-2022-jp?B?SmFqSThhdlhTR0hONEl6NjcxeFNEdFh1OFQ1RUVEWnV3N1U5R0tPRHU2?=
 =?iso-2022-jp?B?b0s3L2ZhTWtZWWYwN0FDRElQa1BJYis0S2xXbkNvc2Ewb2dBYWpoWGRB?=
 =?iso-2022-jp?B?VElRVVlFYnpBTjdOOEtublBIa1ZnWGR0L3lOb2lNYmlaV2xZY29VdkpD?=
 =?iso-2022-jp?B?RTNqc0ttelZHazcvSXZHS1c5elpHZTFPaFdCS1BrVjFVWG1NYVZKdTV2?=
 =?iso-2022-jp?B?c25NZVAzQnhwUDZ5NTRNMXFzNE8xeGF6T0Y5T0owY2txckR3OGdlYlFU?=
 =?iso-2022-jp?B?ZEg3bEpBMTdZWXF2U2kwemw2RnhPK21YdmpiOXVsYVhJa1M0dWlVV3M1?=
 =?iso-2022-jp?B?dDVmZ2lSWmZta3hyRmxRV1Bnd29FVHh4RFY1aUlLUldORHFrWHZYOW4z?=
 =?iso-2022-jp?B?WTcrOVh4eE81RGRQMHRlL1ZVcTNRL0tWK2dIOXp3Qlc3cjJYN29BaCtz?=
 =?iso-2022-jp?B?V2ZFa2dMb3EvQWlZMjR5TVR6Y1NBUXRudkZlWnZkREtRUDBnZURNYk9V?=
 =?iso-2022-jp?B?L3dvRDlmcC9SYjFlUlp3YjNSTGdVa0Yxc1gyaWUwRjNhb3duNGlsbXdI?=
 =?iso-2022-jp?B?NFJyMGVzV2NSUFczUnJFZG9Ld0RTMElUbU13cHp2L0lkenJHWlp1bGg5?=
 =?iso-2022-jp?B?eVo1SVFRTGtjc3lLenJ5a01URW1BbEExYjVXcWU4N3NVSnhkbjVGeUdM?=
 =?iso-2022-jp?B?WG9TZThoakZsUHBNNEZFUFEzSDhFdUEwbnpoUWxCdEgwaU04SXRWa0hX?=
 =?iso-2022-jp?B?aEI0MW1NamtEdFJ4QzBBVW9hWisyaW5QZXZONnZJT1F2eHZuNUFGT2gw?=
 =?iso-2022-jp?B?Q0hRUFZjdTN4czRnR1NJdzFxWGNLeXB3bzNEMXptWG9qUDBWV2FCZ01D?=
 =?iso-2022-jp?B?ODZSczM4NVNpeU1CUjlJK0YwbVpwMW8vWWtzRnFzTmVFa0ZXQ2tTTytJ?=
 =?iso-2022-jp?B?dDFuNkpzaGg0RVZIbmdnMGQ3ekxxZkx3OW9iZ2x0UEVVVjBXNjhWRGlt?=
 =?iso-2022-jp?B?RWp0NkdoNERqYld6cVl2Slo1bWtFU3N5d1hLT0EyU2diUVlxUkZWaFFq?=
 =?iso-2022-jp?B?UzRhRlVjeWlsRk9PQ2hVU0plZnF3YVZmbys4VE16OVBac2NKQUhnbVN4?=
 =?iso-2022-jp?B?YkhQZGJVT1BXVjFkNTdoajQzejd5YnM4UEhtR29aQlVxaXpuQW9BUEw4?=
 =?iso-2022-jp?B?RFZHcHJPa1NITFVvNFNFYU9oaFBMTDRrYlFrQ2syUWh4b0hoWStOMDVj?=
 =?iso-2022-jp?B?aFhuT1JGSGRKWlBzYmtmYmRzZXgzbERobHFmMllQcHdrUVJHT3lxMkMv?=
 =?iso-2022-jp?B?MzlXWjhsSDFHT290NGIzMFlkNUd3V0VTV3QzL1dXUkxsQyswT1NYaWlm?=
 =?iso-2022-jp?B?WEdkcnZhRHo0eWRLRlRrK2h3T1AwTE1EdUpNSDJ2bzEwTDVORXVSRmxI?=
 =?iso-2022-jp?B?Z05RWUlvQUxXTWVuaUtYaWlDVjRiUjNZVEUwWlhWUWY4bER5NEk1TkUy?=
 =?iso-2022-jp?B?TXBiVFFyTlcxNzI0N3lWaS91S2xrdFF3enpSSzVseFdOZVZWL0k2Nkdi?=
 =?iso-2022-jp?B?RkxqN2pQZTJWUm9nQ2Y0Y3hiQkh3NEt1ckF4bkJ6dnVrV1ZHOUpUcFps?=
 =?iso-2022-jp?B?S0ZwcUwrT1cyMkhhV2pQT3NiNjZRTzVvZkFiNGM4SFpoYTJTc25OL29P?=
 =?iso-2022-jp?B?TEFrUy9zREZyM2p2RTJSZlRHMnhkMWxQU0JRb2YwUW5SUnNFZWJad1ox?=
 =?iso-2022-jp?B?d0oyUzhQT0pPWVVYRTBIN2I2eWtzK1pLazEzcVAvK1l5cWVQNUlmZGFs?=
 =?iso-2022-jp?B?eXFqOEJYK0ZzR0tTcEZQNEZlMUUzSjZqeVdkSW5PSDBhWnVTRFNIUzRp?=
 =?iso-2022-jp?B?R01OSmVFN1c3bWhXL3lhTmhTc2pVWGNnMWd0OG1UTEt1eW9uVlFRNXZr?=
 =?iso-2022-jp?B?YXNWeHVaR0dyRWQrc0FaTDBpbVA2aWpXK2k1SjN4RDFVYWROTzhQaVRN?=
 =?iso-2022-jp?B?bVN5VWpvWWtiaExGSkdIR0hTaHl3ZnM0UEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0cb0fa-cacb-4fcc-5232-08dd44c75acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 02:55:16.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSNMfrKa/cYl0EOSvCCJbey+MW9QE6amMOBrOXxAmo4j/P2JlLLkgh43l1CVRIQUeyysgfvugXxsWFhpkic0I0rELvOKmvIgAWqu4atMPzpyTK1mjixDBf7PqTTheBLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5422
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 02:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17743

Hello,

> However, I could not find the posts in archives except cip-dev.
> [...]
> https://lore.kernel.org/linux-rt-devel/
> https://lore.kernel.org/linux-rt-users/
> https://lore.kernel.org/linux-kernel/

Now the posts are visible.
It seems to take several hours to appear in archives.
Sorry for the noise.

Kazu



