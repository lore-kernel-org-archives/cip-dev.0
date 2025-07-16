Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899DAC83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 06:06:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.15275.1752645984412830157
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 23:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ANaB06EC;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752645963;x=1753855563;bh=CtuVkxUdVAmd4m0KcD8/qgpbhjA5x2G1gdNQA6E
	IQT0=;b=ANaB06EC/rwctr0pvfp7OyUML030jwoaAEIa89d9ug4vTtRa5pMQrBBjICC/5iZcGkg0s
	k5qWh47r12XSh/9USZYSilonxTqjMZ/+nN295fXwrlWBKDC0sYRX2payLYsmHVovkyCbb5IevW5Mf
	fXi0nhVU4dnQoGjml0XLx3echxyjLTJJKlMbaYswvKC/Y2UIL4pwb70xw8L+Sh9sW2CypF7zodQR8
	Q8ZjNOogQDBACU9avjsNKYjiADfCJUDEtvYLpVI9f7Pb8tsSon0kxJhpezoZcynYL1tHIHAvTCfYR
	Bun1/29KammZGKQ6DG+gkt9H8KyvAUfM0vub1+ccNg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56G662Eu1082833; Wed, 16 Jul 2025 15:06:02 +0900
X-Iguazu-Qid: 2yAbyr8UsDLbpGhPhi
X-Iguazu-QSIG: v=2; s=0; t=1752645962; q=2yAbyr8UsDLbpGhPhi; m=hGMnNZGfooagFGs9xTL1H3Pvm2ctuT8gqpoWssmd53Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 56G660JC444029
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 15:06:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVbrUSRPy8dr71yo4n7GIEEE3cULWICMHOgpLmblO6akB80A5w5CZ5qZvssUbmNEGE5+4k/HONCtCK3iE4WHpI2WXNMSQLr8oj6GLB+ZT/Mo8Dy50/tuEwH0qoAG4acZq72ddcULdkVroZLJu/tazgPp5+Glnf7IGBXLq2JhwG0HifHFFaq8Re9q9oSlDb1j2Rffw9YdFFlNDqbQ8ZqiZQnjn0vkzh4K2s4KEiRlkDvCAAEVNfRs0Xn3nsM3MZO84wXY9j4CmCaeicVwzxcuEFzfw0GfJ1y1PQ3C8ejt0jEn0fgGVkm5F9jABz1GG7izPR8EMloLRPHegYUmyJX1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtuVkxUdVAmd4m0KcD8/qgpbhjA5x2G1gdNQA6EIQT0=;
 b=ukJnbo/wH6ykvZRyohAgnzr/nm+We+Cno0XwdthGaZXuMnUry1/puf2gGaOZ6Yn+H1rXSfgGN6NbYbhFEtO2+DgrQs5lkJcDDBvRxrHMJM4KxtsfXFKAkO5ynSwa3DtxbGUBzTOUbIUIFom7EoDb3e8J4pliAN5S8qH0nhhtdauKhGYUF87lGJe8LFeDRRUS0YkbSJC5pC6ETD19QgTIT3qFfHEoMYEigkZiRaSW7t5FfthQZcsVGaNcUtUyu0t3O/9rNtg5oMimxelPZitW2uMhEtvRa+zX2ZFY4JsHZAXQTTLYwMKG6tB521A+SkMKDd0mHTtUZZ2hMMr1rgpg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>, <uli@fpond.eu>
Subject: RE: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
Thread-Topic: [cip-dev] [ANNOUNCE] Release v6.1.145-cip44
Thread-Index: Adv1Xy1UoXCELFAwR9m2r1kNXnVaDAALny+AAADOEfAABShCAAAcNAkw
Date: Wed, 16 Jul 2025 06:05:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148180519D07A20B95D5EC3729256A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
 <TY7PR01MB148189F17388801D22C715E0C9257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <c89f2459-5841-43d4-beff-fc25c9bd6520@siemens.com>
In-Reply-To: <c89f2459-5841-43d4-beff-fc25c9bd6520@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13026:EE_
x-ms-office365-filtering-correlation-id: d8e68dfc-7f2c-4644-403f-08ddc42ed46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SmxUY3dGZm5na2U3TzhwMUQyMEkzTXVaMDNINXF0VXlXT0NacHFWL3NCb1VD?=
 =?utf-8?B?cUZidHpHMzFqT0JZenRBMllhNkpIVVZRV0lQaUFicTdrVEtoRzZEUnh1SHEz?=
 =?utf-8?B?eEFWU1pEaFU2UG9NcWtTNjhOZUZhSkNEVm1pclJGZVZmQzNnY28vUDR6SFli?=
 =?utf-8?B?TnVibldMZGpZZGFjVzhrL1ZDa0xkZCtjWUlldnQ3R1ZaNG5BeGFYZGdyNnNJ?=
 =?utf-8?B?ZHpBOVR1MWpyYW00ZHFGR1FXK1B5Wkd5eU9mRHFFaXNPWHR1SitzVVN0ZXF1?=
 =?utf-8?B?Y1dXSVNvdnB3ckxySDIzNnVPSFFlVlpqQTRXM3lFZEdDSlBBdW90S29RdTY2?=
 =?utf-8?B?b2hnZVJsTWdmZlE3NUszMEpqdEJ0c1NaS0t6Ymw3UEd2am5UNkV1dDZVRU5t?=
 =?utf-8?B?MGxqWFU4ZXJNbUlIQlJ0K2crTGJXanJGUmFYZ2U1TE5DM1hHSU4rWktoVFY4?=
 =?utf-8?B?OTFpcE91ZitJdlh3T0d1VUtBa2tabk9wVG9aTFczeFFZaWRwQklTUjh0Wkhk?=
 =?utf-8?B?M0VTRlJZdXdpSHZmME82endiZi9CUDk4Vy9KODUwNWZMekhKeWxhd0dTSExh?=
 =?utf-8?B?eUhpQVZmR0xyL2JjNGNOMFlOTzVYeHpEVEZlT1BUR3RGVGtHSk52R3d2UFh5?=
 =?utf-8?B?dEMvZFNHaWRmdUR4RU1VRjlvd2pvVHAwNldXL2MvdlFSdS9Tc25nV0NtNDlo?=
 =?utf-8?B?SHRzVWRxdHROSWtza3RkZ2c1RUN4NkdlMldlZU9sM3Q0RmQxUU9Bcys0YSs5?=
 =?utf-8?B?U1dnQmJvMlNPdFdqLys0Yk0zbjZkQTRIalpmRXk3OWVLd2NlbW9ZakhpYU5S?=
 =?utf-8?B?YXQwNE12R1VZenNZdVJjelM3K0h4b1Q3Wi9wekhjSGxmNkg2SlZuOGZPdVhk?=
 =?utf-8?B?b1F3cnVma2FIMThzRGRiQURpZCtZazhsbkFSa0E0RkxlNzA4bmhUR2FPc0RY?=
 =?utf-8?B?N3p6Sjl5NXF3azFMTEpCamNiRzl2enc1bHc3eHl4YWZNbmxtRUR1NFdwczZZ?=
 =?utf-8?B?TjlCUzhTQWhieW9XMlFRZkJjTjdQOVBoRnVIUTMybzRkVDBMSkZwU3NlTkkv?=
 =?utf-8?B?VDlDVWVtWlg1THdxRUw5cVVZWDN3dnBiTXlCZWUweStpMGtFWXd3TzVXOXNI?=
 =?utf-8?B?dGtleXhjM0NCcmQ5MGYwWGU0UmplQUxyamtRUVdTZkZ2eG4wUERES0toN3ZV?=
 =?utf-8?B?WUVtbDJwdlNjeTNoaU03KzE2d1dmNDk3ZU5WcW1RT3ZRaXZ3eDVYY1hMNi84?=
 =?utf-8?B?TmYwVDByaktSMVQxbE4wWjAwNVk5V0h0Ymdud3Q4UFIrK3J2L0hEaUdxclJG?=
 =?utf-8?B?bTlTSlhBVC9lSnlIWnZCODkyQ3hidktMbHE0WEpvS01oMHR3ZHBISXNUU0Z2?=
 =?utf-8?B?ZUFJd1BBMzYwckJvWkdVMlI5RUZFMFlhb3FnL3VNWEx0TmpkdVk3Snp4ODhy?=
 =?utf-8?B?SWZCZjUxOUt5RmZUWWl4T0hzZWhXRGhyVnBUd3lQaHdxdDUzMndoNjBQRUN2?=
 =?utf-8?B?dCttZ1haNHR5YWJnU0VaWXRvZzBDWW9tck91c1gvckhpTk5hMWVtQytMSmta?=
 =?utf-8?B?WTFUUjBjUWZ2b3VSQ3dUU1RQRG4wUVlESWZqNVd3cktUMENsOXZKc1NKalJN?=
 =?utf-8?B?OHdoVUNDaXBsTENhTHk5MVE2L0NnaVRTOFRUdDd5NEcrWlMzdCt1YU9WUzBN?=
 =?utf-8?B?UWFzbk5kSmxFT0dOaWFqS2NDZnNoODR2dHZRWEV4Slk1RFZrY0RtV05uZHA0?=
 =?utf-8?B?R1g5T29QSmVOd0lxSkN1QWNTdWhzbkZINXM5UHZSQisrK2lVVkNRV05EY3U2?=
 =?utf-8?B?d3JvWE0xaFVKYk9BS0krdlkyUEQ3YkRtVGljNGsvQzYvL3RCWFBQRnphQ2VY?=
 =?utf-8?B?ZVhJTHRxdnZRdGQxdmVGaGNHWkI3Y0NoeWZTa1NXaURIaTVFZXI0N25lSzdz?=
 =?utf-8?B?ZkNFbzRZSUhHdlk1Y3kxSy9WQ1EyRkZMRjdzTDc1WjhvYTVVdUVMdUZ6N1p5?=
 =?utf-8?Q?1S5Pl2Pb4gTTBrWfIhnm/ipv2FiLKI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WWF5RzY3SmhCN3E5VUlnUU1CVjZNdGkxTklwWTRBT3ErL0VYWnQwVjV2U1dr?=
 =?utf-8?B?c1VaKzg3S1A3cWU3UngrUXlEWW9OWUFtaFY4emJVN0wwTTFHV1A1cm5teFVj?=
 =?utf-8?B?TVNtbUcraCt0VU16Z21NWUJxVzJ6Y3F1Zk5ueXgwM3pTWlRxK0c0RzR0cnR5?=
 =?utf-8?B?QjlXdVkrTnZTekZaL3VXV3BoK2tpME5WcVNBN0lLTXBBeEgxdlBIZlo2WE8x?=
 =?utf-8?B?WExNeXFMaWUzUHlxQmpNN0l4am5uRUt3bFY2bEoybjJkOUErZzBEdmdtc2NH?=
 =?utf-8?B?T1hMTzdSNzNEaU9hbkxRYm40TlM0MjJtNnp3eG11M2cvTkR0S3J0MG1yU1lE?=
 =?utf-8?B?M1dEeGFqdDR2SHRkQlBiN1ZTWVRUR2dkU1VPS0ZGODNrUUhGY2NyQWRTamRn?=
 =?utf-8?B?QVV2SGR6cjF4bGRWdTNpN3NHVWovUWFSc2RiMkVnSHR3aVM4bEUxN2NqMEZO?=
 =?utf-8?B?VkZFaWlPMzlQMHNjRTdIbFRZeFo2QUYrTnNVa2tsdUZYRitjY0h5RXpsRXVx?=
 =?utf-8?B?bUxFMG5Rd3Y3WDMxTjlKTnZKcW9lTFZWeXZnM2duZ2tmTlhVWHFlY3JyT0R5?=
 =?utf-8?B?OWJBRndzWjZ5Q2d2SngzeHJHTVRUY3pwSjhGUTBOd1Y1KzZYaUkvaHF1bXQ5?=
 =?utf-8?B?ZldwWllPUkhZRFdNbExOV0NGUml1NWFDSXF0RnRZdmcvTG9yaUdTeVo0UFRo?=
 =?utf-8?B?cldmRFBYbEFJYnQ0OVVObU9BeWowazFiQTlNbWgrV1ZIME53R2N4WGdYdXBH?=
 =?utf-8?B?TDlGc0EvVlhNMDYrTHZaYWF1SUh4RmtiR3huaFFQbUFoWjJPdWVZUlpObEpK?=
 =?utf-8?B?YVY0RmhkeHE0S0FBRjdEOHh3THJ4WFJFazQvWjRydXIyZEJzOHgvbG9wZUsw?=
 =?utf-8?B?M29BK3pqNHplYkZFdGRidUhjL1lIbkZ1cXJZTURWQjBRQWltcld3N2xkUjIw?=
 =?utf-8?B?eUtnR1Nlem0xSzFjR2dUdk9uaTE3Q25PTnhhZjR3eXVrUXB2eE55VWg5Q3NP?=
 =?utf-8?B?M3pZcVFwZ1QwUVBBQTZsME9VOFdRUzNHQUdOL1QzRm9Ob2ZSR0NwWFZLcU1S?=
 =?utf-8?B?NHRmUkR1aFREZWhwL2JYdjhDMlR2Z1JGSVVnVFB4OHV5eW82RUVXL0dOM3RC?=
 =?utf-8?B?amVoeTJSM1k1U3gyWjJMb0NuYWZ5N1hnYTluOXZjRGYyZHNEOGR5MG1jbERD?=
 =?utf-8?B?UUZYR1N0VUJadjJRd3BpR1RSMm0wakN3V2RWelU5emNMTTF1SE5JcUFpYUhR?=
 =?utf-8?B?NUVWc01lWEY0UUdxS3lObStYOEhFRjd5NG5pbjRZQTRidU44Y3VjTWVZYkxz?=
 =?utf-8?B?bTZodVU0RmYxamw4dEQ0NVhTdW83S3BwUmQvempLVEJlbnd5Njh5Y3gwbGhL?=
 =?utf-8?B?SjZTcFYxTEt5TlRQb3VNK05ZK1pxNG10eExtdUF6c3k2Z3kreXJROUxpQmN3?=
 =?utf-8?B?NU1QcEJBV3F4ZHdXZlZXaU9FT2NkNjdGMk9KdnhKUjFycWpDTzdkSDVmeHZl?=
 =?utf-8?B?STJLUDI0KytQbGRNemJJSjFGZHNZS0I1TlZTYWJTTjZGSFAyUDF0ZUgvQ2Np?=
 =?utf-8?B?bG1Nem93YVhESE5NbWROVUpIMHZEU1MzWVY5Z01VZG52cVBEOXU0akpYMWxV?=
 =?utf-8?B?cENmREU5ekg2djQwZmx0STE4SW9zTHN5amtPN2xqWFZ1M1QrRTF2b2ZkK21l?=
 =?utf-8?B?MzFBZlF2TGtNSTBMRW0yTExUc2FzTXQ2RlVzMUtUWDNJbUUrWVVPTnU3NmVG?=
 =?utf-8?B?MkdKNWxnM3pZU1NTSTJwNzBBbHYxZHZpZC9UakNqc2UrYTdtRFIzSDZ3Mmsx?=
 =?utf-8?B?Q2Zoa3lmRTN5MkdjU2lhejZTdDJia282aFRkVVRVamkzUktHc1E1ei9zZkp3?=
 =?utf-8?B?dzBpQm1peXVwUEZqbjgycDN5N2c3bDhWbXdVWUpJRkUvRm5UMDR0Z1lycmhP?=
 =?utf-8?B?eUN3UkJJSEtKck1tRjQxaitMSW5hWlVETS8yejVUaG9SbE5Rd29kNy9WcXh3?=
 =?utf-8?B?elN5MTYxcHNHRUtDTXk3RjFacmhWTlVpaXRXUVgvMDVSd2xsWm4xUFVGNnZV?=
 =?utf-8?B?dkpuVTU4dTNwVmpxL0ZaeW1wck5YMG95cytZOWc5WVk5TStVTVZPNW43SldD?=
 =?utf-8?B?WGdEK0xsQkRvNU1PZnZwU1RQeG4wR1pKMzJwdy9IMHpUWGdpMXh5dEFBeE1J?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e68dfc-7f2c-4644-403f-08ddc42ed46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:05:56.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mY4EMt2lAbdMbPQIlA/aLRqS8sZegV7YwL4Z/0Ccy+xyZoe72YCnYrjbGqV68zj24AkEZkxubxmyuvVG799rZaUb0CEkJkmzhxz8cywbvzMZFdFtD1tL4ubym2X5kruF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 06:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19547

SGkgSmFuLA0KDQo+ID4+IElzIHRoZXJlIGFuIGluZnJhc3RydWN0dXJlIGhpY2t1cD8gSSdtIG5v
dCB5ZXQgZmluZGluZyB0aGUgdGFyYmFsbCBvbg0KPiA+PiBodHRwczovL2Nkbi5rZXJuZWwub3Jn
L3B1Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvY2lwLzYuMS8NCj4gPg0KPiA+IFNvcnJ5ICwgSSBm
b3Jnb3QgaXQuIEkgcmFuIHRoZSBjcmVhdGluZyBwcm9ncmFtLg0KPiA+DQo+IA0KPiBUaGFua3Mu
IE1heWJlIHNjcmlwdCB0aGlzIC0gb3IgaGF2ZSBhdCBsZWFzdCBzb21lIHJlbWluZGVyIFsxXSBp
biB0aGUgZXhpc3RpbmcNCj4gc2NyaXB0IG9mIHRoaXMgY2FuJ3QgYmUgY292ZXJlZCBhdXRvbWF0
aWNhbGx5PyA6KQ0KPiANCg0KSSBoYXZlIGFkZGVkIGEgZnVuY3Rpb24gdG8gY3JlYXRlIGFuIGFy
Y2hpdmUgaW4gdGhlIHNjcmlwdCB0aGF0IHB1c2hlcyB0byB0aGUgZ2l0IHJlcG9zaXRvcnkNCnRv
IGFkZHJlc3MgdGhpcyBpc3N1ZS4NClRoaXMgd2lsbCBhdXRvbWF0aWNhbGx5IGNyZWF0ZSB0aGUg
YXJjaGl2ZSBpZiB0aGUgcHVzaCB0byB0aGUgcmVwb3NpdG9yeSBpcyBzdWNjZXNzZnVsLg0KDQpb
MF06IGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9jaXAta2VybmVsLXRvb2xzLy0vYmxvYi9t
YXN0ZXIvY2lwLXB1c2gtcmVsZWFzZT9yZWZfdHlwZT1oZWFkcyNMOTkNCg0KQmVzdCByZWdhcmRz
LA0KICBOb2J1aGlybw0K


