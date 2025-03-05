Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52363C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 04:45:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.6525.1741149927706372441
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 20:45:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=zCjVu1fI;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741149925;x=1742359525;bh=QaSMgehxwDtoPY+v9OgWpGyX6VyzHilhd6WWfbU
	4EWA=;b=zCjVu1fIfqboj0GRHg5a8smppfd3BDFi17bGX6oX7LknKNy6pSHyyd3UcizbumgiCemgN
	YkU3OYDx2IbbdzpRT/cUMU/IcQ3yAPFhuzR+ME5uPWgLKrOGKcf6HJmFC34i9xgMBzcRr6oZJu/HO
	9KbP0narh9viO7SfUbLo93lPxc6FORrb5yY9MkgmSYxL09weLpzaTU5Duqmadb/H4GgkAyxYZ7ztX
	eJfL5ZUmJgG4XdZfJl8NH+jI/HzK7beTMEJsglTPvmFMPl5kUYEc5kzgiv7iy7NJm8X22JqBguw+V
	ABzj1EgtLGff8qo7SM0rQ50b50PHt3vz6JEQlxqPtQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5254jOPC900699; Wed, 5 Mar 2025 13:45:25 +0900
X-Iguazu-Qid: 2yAb5TJlfVnpZnGjKA
X-Iguazu-QSIG: v=2; s=0; t=1741149924; q=2yAb5TJlfVnpZnGjKA; m=hJ+ug6uZlpkhQk5Mz2twES2YmdCGTcWD5Ayck0EXx2U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 5254jN792954062
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 13:45:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR3UBcSIzW5U0QVvX5h8ExlfKMfDbT0mOKz00LRCvDwMr3COTsaKsd2yRW2stecdkY/2EQLmR8eVeXICRNFdVzXxyYUYxRjH+K/rMJJxYtf3gODATVrSMBULee7A0dCYNPlfZPI5OEZXpUuUmte/E6+XBkOEVTrlmn32A69akrdh2MWWOaSYGrxVoy1fLsYp/gBkCg2Z30CpEaRM5rbUDf1dhOnxlQyXE1LNI86QPj40TWbHNOMR2C0BcUzmDKVSdlHxmHpO/kceu+7LkDzLzZ/WYpD4qmVMXOEUwXg3/TVCR6S15hOrWbb+9PF92YYfdu1I1aaKdbqnndPJEl9Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSMgehxwDtoPY+v9OgWpGyX6VyzHilhd6WWfbU4EWA=;
 b=IxCPRpSBKCj+r8vvendi9Ds5kf/5SL3J0ewcyqQPiUO9movvILI97Z9QWolU+zC/KQr8JoeOtm561stqZp3Vu+E3S2pvLb8EP8noDnTgvqmy5nkae1wTXpeOM2II0Eide/FxamNHXupdBDzfwnE+aVuKAsXlYEuGznmtdiztLUOUm3ab0rodDcPxjWeLTIKP1PwF+wBuhTtkvd6ZDgQBzmUFuT2LqHwyLSUs3pqHEIUB5QWq2As/BjT2eArcWeVHov2L7QYVvoTrm4lMcT60bxso8XyqSbpjThNPPZY5xO3u084jaadUm5U0YGBTvXPehS8+u1H5AWkCZ8ToBL65HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not install
 kernel
Thread-Topic: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not install
 kernel
Thread-Index: AQHbid7aiL2g1B6U5EC3Tt6PZG0LZbNc2mcAgAcfP4A=
Date: Wed, 5 Mar 2025 04:45:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818077A700A2DEE3DB42BDC92CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <95dd9e49-59bf-44e4-bc62-6e0195d11300@siemens.com>
In-Reply-To: <95dd9e49-59bf-44e4-bc62-6e0195d11300@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14538:EE_
x-ms-office365-filtering-correlation-id: d2cb0fe2-b657-440a-14a5-08dd5ba089b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZGNiMmF1RndOdFBaUUphZXdDZHdLaE1tcWttV2w2dmZMQnMza3p0R1NDYmJk?=
 =?utf-8?B?ODRpNGdFYm5IVzBoamdLVFhpdmd6ckV3N3hxSm9JTTRwd2VrYXNaZVIvZEdH?=
 =?utf-8?B?aVB1bnpCQkhyM0hMTnR4Q0h4RUk4YVZiQTJ1c2pna1phc3FqV2wwY3o1MitZ?=
 =?utf-8?B?RWNTOWpVM3YrVnF4ZnBjVDV0RjBaOUtyWFBFakx2ZFdib0JjQSt2dkJDQVY0?=
 =?utf-8?B?L2J3ZnNzWHYrbFlOT0NyVHNYY1hSeEYrQ05RcUIwWnZzQWUzU2RRTWhDL003?=
 =?utf-8?B?eURCNThsNG0zQUI1SVpMSnF5NU5yMWdzbHNlcndwL3J0a094U3pZNWc0QmRE?=
 =?utf-8?B?QUp6ZGNkd1BHNVVyTzZsYy9HWFJtbVorRU91SHQyczF2cllPMDllOEZkOVcy?=
 =?utf-8?B?bjRnVVRmQ0J1a3lMcHllWkxqYlRzLy96K2lIYVU3dDUrY2tsclcyZVlYNzh2?=
 =?utf-8?B?ZElSVFhPVjdxdXFCaVRURTFsMzc5SlAyMXBLS1BxMnpKY1VZTWRBLzRHZHRy?=
 =?utf-8?B?WDNlc2RhaEMreUc0Umw1ZThYVFFUVFpFeTBjYmFreGxWaFIxemhla3owYVJm?=
 =?utf-8?B?UGs1TWIxUDFaT1d2Ym5PaWs0OGlyWmM2ZlpMWWdXRmU2NXFMVGRlY08zdDBZ?=
 =?utf-8?B?a29HWmh4cXNqa3NUM1drdkc1eUpEUzFOU09FQ2YzR0FHZ095Nzc2VE1FRUFy?=
 =?utf-8?B?S1JDTm5xU25RSStDUk1VUkpYM3R5Si9DSnNtdzk1SFFZUkNDdHhIK3BXY0hv?=
 =?utf-8?B?emQwbitDbzFPN09lYVA4S01xVTBRTnVpVE1FUWxvTWFvYlV5a1YrNnVPRFdz?=
 =?utf-8?B?NzF1OXdLejhaUkh4WUYyeitxL2ZBVWp6K2JWUGFuVFhyM2l0TXQ1QlFHUm9U?=
 =?utf-8?B?MmFPTkIxMzRCaldiTGJ1eUprL0cvVEdyZFB3bkxoNTM2YlFQQlQ5bHo1ekQ4?=
 =?utf-8?B?bmZJYng1R1ZkaFlKMHZ5c3NxRklmRW1reldGd1piRnJhdWN5SlNkZlZrQWFS?=
 =?utf-8?B?VzBOZERzVVYxbXVJaFpJY0FBd3R6UHdBdUx1SE4vek5oVEpyeGU5TWhUYXk4?=
 =?utf-8?B?NkNCenJZWkpndkladUpJMjg4bk1WVVNXN3hIOGFjTExkQjhTa2J6MVpmT0NW?=
 =?utf-8?B?bVozcW42SlN1VTJrdDVtM3V4RSs5eCs4VjFVQWtDOW0wVkhzWURyOXNRaDdn?=
 =?utf-8?B?bVU2QnhldGR4bXp4OGlUNlhsSTdpMmtXYzVyZUc5TzRsaUJZUVRHYnlDY281?=
 =?utf-8?B?ZmFYTXJ3UUgwelBCbFlSblpvQ1Q5OWhGald1TWR4MlhpeXNjeklkekdqaElx?=
 =?utf-8?B?SDdpV3VYWjhOdkJXUnAwcWFDaENmRkxUZmZGY2tvS1dMRkNiZjcvbmQwRCs1?=
 =?utf-8?B?K2hlZFo2bzV2NWZ3NHRzVzgrQzFrVE5UVzljY01xOTNVaVR5eXZ1eGtUWmpp?=
 =?utf-8?B?R3Bqc2dneGpFTUtuZHJpZGQzRW9veU5PSWZCcUcwVnNhRXBLVDBmdzhJWlEw?=
 =?utf-8?B?dUQxMWVLNjFCdFRHcDlNUWRGSkExRlFmdU5JRTYrdlh0MlhuMC8wc0VnV3Rt?=
 =?utf-8?B?YXNhdE4zSTY4SlMwSTlrbEg2bnBOY1kxdyt6VTFtdTZtako0TXF2Y0w4b0FP?=
 =?utf-8?B?bjVNVHFhbXY0am9nTUNHdkg0RWE2TUs5YWJTaThJelZBUThuK1NpY2N1VHU1?=
 =?utf-8?B?elIzaEdMeElhVGd0R3B0T3JOblBZVldPK0pFTjk2M3hkeTUyOTJwR1AzaTVk?=
 =?utf-8?B?Y0RCVjYwSnRoajFaYndXK1lCOGxCT1JOWmUyN1ZVY0c5c1ZGNWY0Vm1QM055?=
 =?utf-8?B?QW15Yi81V0lrTDdkZGdJaVlJNSttaHdpNC95TFF0aWJZQmlZSFh0YXhkUDIx?=
 =?utf-8?B?UC9VYjFMU2hKMHJFQTh3Rm1UTWEvamJaV3ZiV3E5WS9aTmdFaVhmWnc3V2Jn?=
 =?utf-8?Q?UwKJnLrwZUE35sa8J6PggCeXh63ht8f4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1NSaGZHdVNoKy9SYU5WZWF0VlFBcHFVUWo4bFdDdm9ETW1DWCtOcG9mUHNE?=
 =?utf-8?B?SVZ3bUZROFhCOUZ6Nm0rcDFSVTRzVHNTWHB5dEhteW5DV1VlWlB4L2JJenVu?=
 =?utf-8?B?aWtQSDBySWNuL3pZYU93NUdTWFFYRWlDNElHaklTem1ZV1I0QVNQVXZoOWhk?=
 =?utf-8?B?U2p5Y01EVTlmN2NPU2NXbk9jREZXbmtmRGp3dW5hYXM3TFlwTGRwRi80MWF0?=
 =?utf-8?B?NTRsUUJXdkRzMTdaZXBWcDRSalRYKzJNVjZZQzhqK0wyRGplb3FCZzFnSlJK?=
 =?utf-8?B?SlBuREEvTmEyeWtaeDRKZkM3alZBTzRzR1ZOWnJPb1g4bndIdU5TSHhEY1BC?=
 =?utf-8?B?OVZQaEtzZjlHMG02OWlZN3pFKzZVMzFqODQ4T1ZJQ3BMM01LVzBmTWV1UmdT?=
 =?utf-8?B?VVFlRXN3Qm5WdTEycXZuWEtkOU1KQVNWVm9YNUVtZGVQdHh5cTh1ZHFRRW9O?=
 =?utf-8?B?dUdMM2RlS1VzWDI1bTVlRnNXY24xUzNXcWFYR3d0b3FQdkdwNTcvL242RGoz?=
 =?utf-8?B?eFVpdHdPR1laRW9Md1Vhcis0dUtBTGRKc3phbEk1eDM0cEVad0xYb3IxdWla?=
 =?utf-8?B?ZUVUcVVUank4dnNmNFFOVVpleExvdjlQWDZnbkRhRFM2ZFl0M1JtSVBnK2dK?=
 =?utf-8?B?Z3F0OWtZWFdrc3A3MjM4V2h6czIrbzZxSTY0cmdjZlVrRlVScTJwMHB5blRG?=
 =?utf-8?B?QmpHR0gxVFBMTzk3Vm91MjhzakZPMUhJemRuZTBtWEd4UkRQMDNOYXFSR2lG?=
 =?utf-8?B?MUZtc0x3OXlJZTRVajlBamxCRDJDRDZxcGplY3NsSHpVNVhVaVQ2NWdFQnlS?=
 =?utf-8?B?QnpCTFRFSDBwdCtHbTY4ajhNN0NjUm8xZ0o1YW1xS0kzVmFUT3pkbXg4Wnlp?=
 =?utf-8?B?OVNiblYyUWtlYklidWhSS0IwR0tYcVJiWXFaLzQ0eGl1UUtHeDl2bFZoTnlJ?=
 =?utf-8?B?ZDBKN0hRcC82dVllRUNmL1VndmQ5YlM5K0FORDlNOGZrdks0S0hVZ0llUkdE?=
 =?utf-8?B?ZHlaNzR2NXRYaXFZMHVKSTcxOUZPQ0pNYTQ4YzVTd2k2NVVCNzltdCttOE9F?=
 =?utf-8?B?L2JZTzV1ckdJUktEeGNRSzFWZWIwOFNMbkFBTXV1RDRqZDJMcGwvRzFEZXlT?=
 =?utf-8?B?V3JFMkhwY2ZpQ3F4NFBBSXZZaDBtcWFUV2RZekw1bWRRdjA3a29pekFIaWNO?=
 =?utf-8?B?MXJtNUdQLzVvcjErZEFMZndhOHFiczhSeGZ2Zm96bnJUbk5EMWZndEwxRzA1?=
 =?utf-8?B?aTRJNzdXdTVFNmNZM0dIS0J5bFhianJXMnZvU1VzdHZmb3NsdkdIS0w5VHU5?=
 =?utf-8?B?WHZyQlFmMldKSGRrTG5WUC9OL2ZwNDcwQVB5WFBtbUE3MFpJUjVUZGpnR0da?=
 =?utf-8?B?M1ZWTmNLdVFaS2FURkJXNjN1ZzkxN3luTTEwdFFlcXl2NVREK2ZGalVnbmZZ?=
 =?utf-8?B?K3pna0FNQU01SjlOcTVhQlU5b2xEcWYvVlFjeVF2SGIyZm9ZSW81TFV3MDFS?=
 =?utf-8?B?c1VNUVg5b25yNVhVK0w1RHg5eGRwYVprS0t6WVpMMCt6bG15Z1ZzV1FNVHpF?=
 =?utf-8?B?VDNwdmJnVFd4T29XRVFiMWVQL21UZDNJaURQM1J3eHE1eTFTeE9sbCtISzJR?=
 =?utf-8?B?K1M1RnRoWFExaXJiT0wyZmNUT0JVRjA2WXN1Lzh1NVNYaUwxdzIxV1BIR0NZ?=
 =?utf-8?B?bHJyYzlmb0d4MHhBL0szUmRDK2JIZkRIeEg1SGRYSWRwWE1pdFRTcDY4Y3Y5?=
 =?utf-8?B?Zlpwc1F0aFpzcmcrV09JQk9CSVhVQ21vdFJNTTNuRk02Ylc4eFgzTXlSd0JC?=
 =?utf-8?B?WkRSbWx0NFhWU0gydUZBZlJ1MnlVelJnNVhrdzF3R1hCSDRLbEg3N2h3NWNl?=
 =?utf-8?B?aUd5UFZyeW93dmlFMGhrN01yLzFYa2Q4cjlNL3F0Y2JoZTYwWlJLVDhPNkxU?=
 =?utf-8?B?ZDZHRHNsVXdlaDd1azM1TDBud3BDQVBUSWNIbmxRMFZ1VjN6ZUdKZ2RZYUZo?=
 =?utf-8?B?OGt3cXNXNHMxSE1Qb2YvMmxBUXc4V2lzb2tGRHFQOEZxb1JsSVdXdytMS0FY?=
 =?utf-8?B?aGp0djN1Tno5TytsTTlHL3BZdXhzbld3QjAzVVN2dzltb0wyUVRyeTNiRFAw?=
 =?utf-8?B?eWJqVGtVcWJlamVoSEs5Sk9pYmNzcEZaVk93VlNnRzFCTnpSdDI5V2xnc0ZG?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cb0fe2-b657-440a-14a5-08dd5ba089b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 04:45:21.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6eDMs5G66H7bXlLdpXwj/ZfUxCLj3I/kmCDDGWQJUF1SPnefftoVVuZVjEPXIE8i8q3FeayClaA84gXKmNMOCPlH8C4+VMJrwORSJheqXMp4QgtAR1KflPVzcDqLuRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 04:45:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18027

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxLCAy
MDI1IDEyOjQwIEFNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8
pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVj
dDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzJdIGthcy9vcHQ6IEFkZCBvcHRpb24gZm9y
IG5vdCBpbnN0YWxsDQo+IGtlcm5lbA0KPiANCj4gT24gMjguMDIuMjUgMTM6NDYsIE5vYnVoaXJv
IEl3YW1hdHN1IHdyb3RlOg0KPiA+IFRoaXMgYWRkcyBhbiBvcHRpb24gdG8gY3JlYXRlIGFuIGlt
YWdlIHRoYXQgZG9lcyBub3QgY29udGFpbiB0aGUga2VybmVsLg0KPiA+DQo+IA0KPiBXaGF0IGlz
IHRoZSB1c2UgY2FzZT8gSG93IGRvZXMgdGhpcyByZWxhdGUgdG8ga2FzL29wdC9rZXJuZWxjaS55
bWw/DQo+IA0KDQpUaGlzIGlzIG5vdCByZWxhdGVkIGthcy9vcHQva2VybmVsY2kueW1sLiBUaGlz
IHdpbGwgYmUgdXNlZCB0byBjcmVhdGUgcm9vdGZzIGZvciBDSVAvTEFWQSB0ZXN0aW5nLiANClRo
ZSBjdXJyZW50IHJlY2lwZSBjcmVhdGVzIGFuIGltYWdlIGNvbnRhaW5pbmcgdGhlIGtlcm5lbCBi
aW5hcnkuIEtlcm5lbCBiaW5hcmllcyBhcmUgbm90IG5lZWRlZCBpbg0Kcm9vdGZzIGZvciBrZXJu
ZWwgdGVzdGluZy4gVGhlcmVmb3JlLCB3ZSBoYXZlIGFkZGVkIGFuIG9wdGlvbiB0byByZW1vdmUg
aXQuDQpUaGlzIGlzIGFsc28gdXNlZnVsIGJlY2F1c2Ugc29tZSB1c2VycyBtYXkgbmVlZCByb290
ZnMgd2l0aG91dCBrZXJuZWwgYmluYXJpZXMuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBOb2J1aGly
byBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+ID4gLS0tDQo+
ID4gIC5naXRsYWItY2kueW1sICAgICAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gPiAga2FzL29wdC9ub19rZXJuZWwueW1sICAgICAgfCAxNyArKysrKysrKysrKysrKw0K
PiA+ICBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCB8IDQ3DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGthcy9vcHQv
bm9fa2VybmVsLnltbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdp
dGxhYi1jaS55bWwgaW5kZXggNGRmNTIxYi4uYTA5ZWVkZA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBh
Ly5naXRsYWItY2kueW1sDQo+ID4gKysrIGIvLmdpdGxhYi1jaS55bWwNCj4gPiBAQCAtMjcsNiAr
MjcsNyBAQCB2YXJpYWJsZXM6DQo+ID4gICAgYnVpbGRfc3d1X3YyOiBkaXNhYmxlDQo+ID4gICAg
c3d1cGRhdGVfdmVyc2lvbjogZGVmYXVsdA0KPiA+ICAgIHRlc3RfZnVuY3Rpb246IHN3dXBkYXRl
DQo+ID4gKyAgbm9fa2VybmVsOiBkaXNhYmxlDQo+ID4NCj4gPiAgc3RhZ2VzOg0KPiA+ICAgIC0g
YnVpbGQNCj4gPiBAQCAtNjcsOSArNjgsMTAgQEAgZGVmYXVsdDoNCj4gPiAgICAgIC0gaWYgWyAi
JHt3YXRjaGRvZ30iID0gImRpc2FibGUiIF07IHRoZW4NCj4gYmFzZV95YW1sPSIke2Jhc2VfeWFt
bH06a2FzL29wdC9kaXNhYmxlLXdhdGNoZG9nLnltbCI7IGZpDQo+ID4gICAgICAtIGlmIFsgIiR7
c2VjdXJpdHlfdGVzdH0iID0gImVuYWJsZSIgXTsgdGhlbg0KPiBiYXNlX3lhbWw9IiR7YmFzZV95
YW1sfTprYXMvb3B0L3NlY3VyaXR5X3Rlc3QueW1sIjsgZmkNCj4gPiAgICAgIC0gaWYgWyAiJHtz
d3VwZGF0ZV92ZXJzaW9ufSIgPSAiMjAyMi4xMiIgXTsgdGhlbg0KPiA+IGJhc2VfeWFtbD0iJHti
YXNlX3lhbWx9Omthcy9vcHQvc3d1cGRhdGUtMjAyMi4xMi55YW1sIjsgZmkNCj4gPiArICAgIC0g
aWYgWyAiJHtub19rZXJuZWx9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPiArIGJhc2VfeWFtbD0i
JHtiYXNlX3lhbWx9Omthcy9vcHQvbm9fa2VybmVsLnltbCI7IGZpDQo+ID4gICAgICAtIGVjaG8g
IkJ1aWxkaW5nICR7YmFzZV95YW1sfSINCj4gPiAgICAgIC0ga2FzIGJ1aWxkICR7YmFzZV95YW1s
fQ0KPiA+IC0gICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIgXTsgdGhlbiBzY3JpcHRz
L2RlcGxveS1jaXAtY29yZS5zaA0KPiAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0g
JHtkdGJ9ICR7Q0lfQ09NTUlUX1JFRl9TTFVHfSB3aWM7IGZpDQo+ID4gKyAgICAtIGlmIFsgIiR7
ZGVwbG95fSIgPSAiZW5hYmxlIiBdOyB0aGVuIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoDQo+
ID4gKyAke3JlbGVhc2V9ICR7dGFyZ2V0fSAke2V4dGVuc2lvbn0gJHtub19rZXJuZWx9ICR7ZHRi
fQ0KPiA+ICsgJHtDSV9DT01NSVRfUkVGX1NMVUd9IHdpYzsgZmkNCj4gPiAgICAgIC0gaWYgWyAi
JHtidWlsZF9zd3VfdjJ9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPiAgICAgICAgICAgIG1rZGly
IGJ1aWxkL3ByZXZpb3VzLWltYWdlOw0KPiA+ICAgICAgICAgICAgaWYgWyAiJHtleHRlbnNpb259
IiA9ICJzZWN1cml0eSIgXSB8fCBbICIke2V4dGVuc2lvbn0iID0NCj4gPiAiZWJnLXNlY3VyZS1i
b290LXNuYWtlb2lsIiBdOyB0aGVuIEBAIC0yMjEsNiArMjIzLDMwIEBADQo+IGJ1aWxkOnFlbXUt
YXJtLXRlc3Q6DQo+ID4gICAgICB0YXJnZXQ6ICBxZW11LWFybQ0KPiA+ICAgICAgZXh0ZW5zaW9u
OiB0ZXN0DQo+ID4NCj4gPiArYnVpbGQ6cWVtdS1hbWQ2NC10ZXN0LW5va2VybmVsOg0KPiA+ICsg
IGV4dGVuZHM6DQo+ID4gKyAgICAtIC5idWlsZF9iYXNlDQo+ID4gKyAgdmFyaWFibGVzOg0KPiA+
ICsgICAgdGFyZ2V0OiAgcWVtdS1hbWQ2NA0KPiA+ICsgICAgZXh0ZW5zaW9uOiB0ZXN0DQo+ID4g
KyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+ICsNCj4gPiArYnVpbGQ6cWVtdS1hcm02NC10ZXN0
LW5va2VybmVsOg0KPiA+ICsgIGV4dGVuZHM6DQo+ID4gKyAgICAtIC5idWlsZF9iYXNlDQo+ID4g
KyAgdmFyaWFibGVzOg0KPiA+ICsgICAgdGFyZ2V0OiAgcWVtdS1hcm02NA0KPiA+ICsgICAgZXh0
ZW5zaW9uOiB0ZXN0DQo+ID4gKyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+ICsNCj4gPiArYnVp
bGQ6cWVtdS1hcm0tdGVzdC1ub2tlcm5lbDoNCj4gPiArICBleHRlbmRzOg0KPiA+ICsgICAgLSAu
YnVpbGRfYmFzZQ0KPiA+ICsgIHZhcmlhYmxlczoNCj4gPiArICAgIHRhcmdldDogIHFlbXUtYXJt
DQo+ID4gKyAgICBleHRlbnNpb246IHRlc3QNCj4gPiArICAgIG5vX2tlcm5lbDogZW5hYmxlDQo+
ID4gKw0KPiANCj4gRG8gd2UgYWx3YXlzIG5lZWQgdG8gYnVpbGQgYW5kIGRlcGxveSB0aG9zZSBl
eHRyYSBpbWFnZXM/DQoNCkl0IHdpbGwgbm90IGJlIG5lY2Vzc2FyeSBldmVyeSB0aW1lLg0KSXQg
d2lsbCBuZWVkIHRvIGJlIGJ1aWx0IHdoZW4gTFRQIGlzIHVwZGF0ZWQgb3Igd2hlbiBhIHBvaW50
IHJlbGVhc2UgaXMgaGFkIGluIERlYmlhbi4NClRoZSBjdXJyZW50IGdpdGxhYiBwaXBlbGluZSBp
cyBub3QgdGhhdCB3ZWxsIHRob3VnaHQgb3V0IGFuZCBJIHRoaW5rIGl0IG5lZWRzIHRvIGJlIGNv
bnNpZGVyZWQuDQoNCj4gDQo+ID4gIGJ1aWxkOng4Ni11ZWZpLXNlY3VyZS1ib290Og0KPiA+ICAg
IGV4dGVuZHM6DQo+ID4gICAgICAtIC5idWlsZF9iYXNlDQo+ID4gZGlmZiAtLWdpdCBhL2thcy9v
cHQvbm9fa2VybmVsLnltbCBiL2thcy9vcHQvbm9fa2VybmVsLnltbCBuZXcgZmlsZQ0KPiA+IG1v
ZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAuLjIzMzgxNzcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIva2FzL29wdC9ub19rZXJuZWwueW1sDQo+ID4gQEAgLTAsMCArMSwxNyBAQA0KPiA+ICsj
DQo+ID4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJp
Z2h0IChjKSBUb3NoaWJhIENvcnBvcmF0aW9uIDIwMjUgIyAjIEF1dGhvcnM6DQo+ID4gKyMgIE5v
YnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiAr
Iw0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gPiArIw0KPiA+ICsNCj4g
PiAraGVhZGVyOg0KPiA+ICsgIHZlcnNpb246IDE0DQo+ID4gKw0KPiA+ICtsb2NhbF9jb25mX2hl
YWRlcjoNCj4gPiArICBrZXJuZWwtdmVyc2lvbjogfA0KPiA+ICsgICAgSU1BR0VfSU5TVEFMTDpy
ZW1vdmUgPSAibGludXgtaW1hZ2UtY2lwIGxpbnV4LWltYWdlLWNpcC1ydCINCj4gDQo+IEtFUk5F
TF9OQU1FID0gIiIsIHRoYXQgd2lsbCBhbHNvIGRpc2FibGUgdGhlIG5vdyBwb2ludGxlc3MgYnVp
bGQgb2YgdGhlDQo+IGtlcm5lbC4NCg0KVGhhbmsgeW91Lg0KVGhpcyBpcyBzaW1wbGVyIGFuZCBi
ZXR0ZXIuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


