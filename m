Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43DD1F9C6
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 19:40:41 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.web11.5939.1729021231440906903
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 12:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gN4MPkjg;
 spf=pass (domain: renesas.com, ip: 52.101.228.71, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdIk/sFw92Hx47Z4ovMmFIaTm+G7juMfCC2kT5F2PGVBgA81FBqBZKuSUpbyr3A5Nqsr4s8R79F0DLqRplglJ/0BoOOmdZNTzAwOZymWJL58R9Zf593PQZJUlsFatKSfte5w+m7YXLXQpGwp/ftdmwlOR1IornBj0Qdu1Dyfy78kbL2SlnD9sOo5ql3cKdImV4+YPv4LkazW/gAsQptFq1Q/n7yeMizyVgMI5EKsnF2hnrSykgzIcWMZw6F18Szr/J6zPEG2kOXRWPOuxKQJEpsjTizLrUKLunCYvx2/lMaG+F0oJPnWH2RZdGY5Xoonl5iedzaCX8gYzurZf8IB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJxULt6ys6bz1fgD9kbbfAqI9bTw42buzUVF/UK5N20=;
 b=Ax661jesKY/j9J/0psomch+UsNq127zi1bPEVgshx3vJyzLOM8sFjzzdB2b36V6HrqjqxaFZctW6FYXEW2d4i20thE9ziZgF9gPddh3YQHcYfe6bp4wiL3KfUPIyy98iBj7vDKphFyUFmD76kiyiZiWSruymAwjA6WV/BP/g9XSL3ZcCy0nDzjdzQZfIq7xthqv5omcvOZOS9qWrZJqU8k4cP0x/blA4mN91SB02nGWmsT9MVJ+Ty+E8cpdGkTHQ9oAI3ym6Ikulq14HvZWcmNLs9CHZe07u/Ry5+GRNCV0+zcmUcdSIFdWOPVE3weTDJCvlhrJOgGdBTtD47Bz4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJxULt6ys6bz1fgD9kbbfAqI9bTw42buzUVF/UK5N20=;
 b=gN4MPkjgUXi/9lqtCg4fim4v4xpWST52bFdFuKoj+1CiPN6fvKdjbkAU3/i7SM3gkE6tQWVajcWyap7F/jhlSzjoIID5oB6ZZ87KFgZLPKnzYHFgzYeSDnfDNhin9FgUZ3wBBmwQ+Fqhl9TYXBMprNCOwsXdv6d4tDm4FhWLk4k=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYYPR01MB12492.jpnprd01.prod.outlook.com
 (2603:1096:405:194::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:40:25 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 19:40:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: gitlab mirroring slow? Re: [cip-dev] lab-cip-renesas offline
Thread-Topic: gitlab mirroring slow? Re: [cip-dev] lab-cip-renesas offline
Thread-Index: AdsaKgOu1+fH4iYTQ/ipcTRm11rUKQAGNb8wASdLSIAACdxZAAAKVcOAAAIs2VA=
Date: Tue, 15 Oct 2024 19:40:25 +0000
Message-ID: 
 <OS9PR01MB12389D0D99508ED98BA6F0460B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz>
 <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw61nUmWBkUfH9rN@duo.ucw.cz>
In-Reply-To: <Zw61nUmWBkUfH9rN@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYYPR01MB12492:EE_
x-ms-office365-filtering-correlation-id: 171bc771-d50d-4b69-7084-08dced51373e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?by9SYVpxRjVjNjZ2R21yK21tOGhhbTh6dHc1QmRiRk5UY3VQVVRPZk8rcTAv?=
 =?utf-8?B?dUpYNHNid3lJdUdGTHh6TGF5VmtxeU1mcEtnK1FtTGorMEh1UWhUOG1iVFJk?=
 =?utf-8?B?QU9NU2U4SkIwSW50VmUvU0hwTG5RWUxPZGtneUtjcnY0cURveXArMithZHhI?=
 =?utf-8?B?NnBacFJWcGRPN0thbi9FbFhCMitzUlRNbWM4dDZQY05pKzZid0EwVjlxU2xq?=
 =?utf-8?B?MUQ5YTBjTE1YZXJhWEZ4NGZRREFXOVlRSjhUeUFpbndLL2hlaklMMWFLbXVz?=
 =?utf-8?B?Z3FFbnR1NXVnbnFldk9lZ1pWK1JuWmRWSkRYM1BHaTZUTWJ0RGhFWGQ0bTEy?=
 =?utf-8?B?a2c3NzVDK1VydmF1MDJMcFIvRjZVYU44Q2ZvTzFsaWVwSEhTM09wVW5VVk9C?=
 =?utf-8?B?SEhTcXdaM08ycnZtcTZmRE1rTzVEZzE0emR4WHgxMWEyeVAxcWV3ck5HU1dT?=
 =?utf-8?B?ZUNFNEhiZk5yUXBRRWs2Y1ZrRjdxN0FoTjZRL1hWcngvYU9aVFRWSlRSODhQ?=
 =?utf-8?B?clpuRVhKeVdhQnU3dEdPQTRUdmFkbS8yL0E0czcwQWF2WUUzTW9pMXR5QkYx?=
 =?utf-8?B?cElmN0lhaDhDRWxPY085a2Q4NGdHRVRaWmpicjJhdFRwWEp1alhlQ1pHOUsz?=
 =?utf-8?B?OEZpdEhya2o0OHFGOUhwaTBtc0RDenZBV1g4dmJTR014OHZ4YWVNclhSL0Rj?=
 =?utf-8?B?QXJ5NFdXYTN1QkswNkJ5YTRsQnNMaEE5cCtFR0hyUkIrMk1mdFJQUkZMT1NW?=
 =?utf-8?B?elJHYkcxbUhpTElDKzh0ZUFqNmFIeGVBMEhjcFU5dXFtejhOSStWRnB0aVpM?=
 =?utf-8?B?Wm1RMXdOR0crWStJSmJ1QjRqZERsb2dIMEJmamhGdGVPenZrc3RsVEQ4NnlH?=
 =?utf-8?B?L3FsZis5aC9iSVpVdU93cFZVeG9rWDAwUHZLTmg0K1laOG43M00yVUh0MEpN?=
 =?utf-8?B?TzFsUkFhSzVSVU4xWmZqQ1pzRnNDVXRtV3dCMXAxeUNGVmk1MEU2Ny9zVnFu?=
 =?utf-8?B?TlA5ZU1OTHdZNmRsV05QSG5aSklwa0ZlWWtSS0hLeVVmTEpBZUh1SFYzODVL?=
 =?utf-8?B?L1lhdnpnYm54d1RtdHF1MXhFODdCZlFpSXVLdkxlYU5FZXR4NFE1Qko1V3hn?=
 =?utf-8?B?dllvQkplYmdVRElUcU9VeU52SjUzMmxoK3RnZHFqUVh2VjR6czF6Z3pGcXkw?=
 =?utf-8?B?MWZvaFpLRFdpWFBTZWREbFFjZjRjRDQ2dWc5Qm5qZ25BMkJ0aFZ2bTNNTEVx?=
 =?utf-8?B?UmN1VHJLSjZsYkFPKzE3cFB4cmZzOTBEM1AzK21WbG5nbld2T0lMYkxCNEpS?=
 =?utf-8?B?VE5IVDZPeE5CNzJpNHR0ZmFBQzZ6NGxZSDdWNXVGSFVmODcwaXNvT0hPN0Nt?=
 =?utf-8?B?TnR0SDJnTERMQkxZWjVHMXNZZlFZS1B2ZG5DUGk5SklxeHFVZDVNVDZabXZp?=
 =?utf-8?B?RlEvN0pWbVI2dEg5eDd5cXlvUnoxS1lTVVc0VFBlQ0ZlVXdoWTNYaExsbU5J?=
 =?utf-8?B?VC9FNUs2TTJNdHlEeWRFRXUzbEcxbWRiZExNYU1LbkpQOTVZQ0ZBT2N5Z0wz?=
 =?utf-8?B?bUcrZGdFNk1jRC9LN25lT1djVGtPUmtFYm9aMGlXVG9oWURPdU1oMWpXVTZG?=
 =?utf-8?B?ZUdnVmt5eW53NDRDOWNndGxIZ3VHMFc4QlZwMzFIRUVRNXVWRzFYS09WSUVs?=
 =?utf-8?B?Mk1jYTdmYXhwUm9XTk56dmFaR01iQURwUEppVDVPSjVxVWUrSjFSd1FBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RGFucnE2NldCeHphdXU0aFQ3czdqRjhWWUxuWFJVM2lWZkQ2MkRRS3JYYlhy?=
 =?utf-8?B?TzFLd0w2Q3dhNHVvVll3WUY4cHgyVldpTFJiMnVmNnFhdEl4L04rcEtnckRz?=
 =?utf-8?B?TDVOaFJKTE55RFMwWXc5R1RBQjVmaThteWpNcjVONDhDNDk5dG83UTJ4ckcy?=
 =?utf-8?B?MmFPVEJ6ZEIxNC9CUFd1djhPbHN4K0JlVVVIelZYZVVVYWtpSmd2b25hbGs4?=
 =?utf-8?B?MEJxK2VpTnNEU1FaU3dPeHpuK1c4d0NpQTRVTHM2aFdDb0YrRjZUM2xCcEVO?=
 =?utf-8?B?VWdMTE1Pc1ZYc1RhU2VzVHlsSUE5QmpHdWF5RUw0K0Jvd2k5czRsb1JuQWxG?=
 =?utf-8?B?THloczVCWVpUWTRRL1JBZ3Vtb1Q0RzcrZnJPU3RyS0UrcXo0UnB3VHp5MUE5?=
 =?utf-8?B?RXFyZnVseS9wRGVJQ25jeUY2dXUzTFF3NmZkTXJYV01NakphWVRLaWJrbndu?=
 =?utf-8?B?cUZJdDhtdm0zSi9OVU5TTXloKzJCNEYrOWdYVDNwZ2VLZFA1Sy90SldTSHJq?=
 =?utf-8?B?Z2JhZStSTmQzQzYxYzFuZTdzOWt3VjV6SnI3V2MvNFVhbFJ4Ym8wdkYwUUYx?=
 =?utf-8?B?ajN0WW5QMkNnZWdyeUdFeGVwemRvRmZSUjZvOUZhUzdLcUMyWUkvamViZGRr?=
 =?utf-8?B?S1AzQ094MUUyblJPbktyT2hKWTFIcHZjZHN3eGhDS3QwNDU2QVVzYVFCN2VX?=
 =?utf-8?B?N3QwRWt2c21UWDB1NWR6Z3Y1RTdXYTZIRVA3MUdxT0l0dHZIS01HWUNnQ0lR?=
 =?utf-8?B?UnZ3VmNsem9MbjFOd21pOGQwc0Npa2VvcHpFRUhTVUZRSURmVklTOXBLM09s?=
 =?utf-8?B?SDcweTU0dmFZS2pFNGtPYjVVUzZVbnBQUUExMzg5QTRSUWlVRG4wcUV3TmU5?=
 =?utf-8?B?Wk5JYWNJM2Q0ZVRDQXpROEhWZjhYbTNRZ0FXV01kVjlnNVhMWUUxaUJxRWFu?=
 =?utf-8?B?YWMxUnN3SXhxZEt2eDcwS3VRdWl0ZmtqSHVIMWVqbWJTa2R0VkxzaE5jZXBQ?=
 =?utf-8?B?ZmNjRzEwQjUyNUxXTE5qR3IyWUpkOGZZZjF5N0hBTEhiN3NoR0tVc01CVlZJ?=
 =?utf-8?B?Tkw2TGVjM3lYZHo3N1BnUWxWZUt1V2t2akJCN2Y1NW9qbkZMeG5CZ0tLaWw0?=
 =?utf-8?B?Q1ZMSVdrdFRlOTJLeTRRbUNDbkRmRG5tb3VJQ1VtL2M2NzJydW0zTzBHV1hB?=
 =?utf-8?B?bG0yakFNMDFTNGw3NW9kNTdHWXdBOXJURUJmNjYyT29mRzM4OHY0dnI5Q01v?=
 =?utf-8?B?aWZFQkl6WWVxNy9OaWdNZG5oTUsybkNiQzE5K3h2NkZ5a2xCczlVNUtEY0RU?=
 =?utf-8?B?TEJmeXhBZTV3NGhta1I4QmwrM0dnYWhkMG5GdWZLOW1kQURFSS9XMkZELzI5?=
 =?utf-8?B?S3pqaVJXVHNUaUFlM0RxNzN1MkpVT3RsS2MyT3BjL043Y3hxak43cGxuYmZy?=
 =?utf-8?B?WkFVaXVQa3R1eGdTWGVhOWVhL2VLYy9mbDdBdzdyWmxVZWFtUGhMQVhIZS9C?=
 =?utf-8?B?czlYb3hVYWVjQ1RUbWhPNUFLanBpWFlVYXhKMG1lNHVha3ZyYmZnSzMrSkxt?=
 =?utf-8?B?RFRkaFZOZmNYSlVFVDFwZ295bXphQmRFUU1WYitiUklHa0w5c29mVUh1Qjd1?=
 =?utf-8?B?S1diTGZpK09Ta2RBRHpYWXVGeE5OSGRIQm80SnhRZ0hONm9RK2dhQXJZZllP?=
 =?utf-8?B?WWpOMG1uVExKRUxMcDFSTXUrK2VjUkkzWGhzelluY2VBT05DbG03UWRNMzZQ?=
 =?utf-8?B?cWVCcjV4Mm9Qa0VEY1kzbWhXWXl0UDk2NWFxZXZaRldTRlpTK2g3d0wyemhL?=
 =?utf-8?B?WVBUYnorZ2pVYkpQV2grbytUQmRWSkhYZFBGY1RJYmdTaEZKczdLaHp0VlR6?=
 =?utf-8?B?akxPdy9XRFNzT1hNdkRiNmNtSTd2RzZkUWVNbVQ0SFlrcUlyUnNQcXQvWUJ2?=
 =?utf-8?B?V3QxSTJWYnBnZit4UFQ1UGc3VklTZlhCemRJRmRwOEZsZTkrL2FoY1E4Q2Ix?=
 =?utf-8?B?L1orcmtPKzZXNGp3dmM1UUd1dFQ4ajVvcCtyYkJaZkgwS3AzMmV6WjVtMGNq?=
 =?utf-8?B?eG5QMHlzNU9tZjh5cHd2dnByRjBGazR1OTJ0a2xEMWVhTUdqTEJrOWc2VnVF?=
 =?utf-8?B?ZHVzRHQraEViY283c3FFVFZBV28vbTJQNUNWZzU2ekF2LzVIMWFyK1VIRVBD?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171bc771-d50d-4b69-7084-08dced51373e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 19:40:25.4103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXTGmzbWa5naVRJrF7yH7NHNF8hm4zn7mSzwmxjOYnhZJHSw0CVKarxlmtLIY1e8O/xyWUyy1n4nzKgZsyM5qpCggYvk/cjbra02pTWL/rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12492
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 19:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17043

SGkgUGF2ZWwsDQoNCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgUGF2ZWwgTWFjaGVrIHZp
YSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2VudDogMTUgT2N0b2JlciAyMDI0IDE5OjM0DQo+
IA0KPiBIaSENCj4gDQo+IGdpdGxhYiBtaXJyb3JpbmcgaXMgZWl0aGVyIHNsb3cgb3Igbm90IHdv
cmtpbmcuIDYuMS4xMTMtcmMyIGlzIGFscmVhZHkNCj4gYXZhaWxhYmxlIGZvciBhIHdoaWxlLA0K
PiANCj4gY29tbWl0IDdlM2FhODc0MzUwZTUyMjJhODhhYWM5ZDAyZDhiYzVhOGZmNDRmODAgKG9y
aWdpbi9saW51eC02LjEueSkNCj4gQXV0aG9yOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPg0KPiBEYXRlOiAgIFR1ZSBPY3QgMTUgMTM6MjQ6NDIgMjAyNCAr
MDIwMA0KPiANCj4gICAgIExpbnV4IDYuMS4xMTMtcmMyDQo+IA0KPiANCj4gQnV0IHRoZXJlJ3Mg
c3RpbGwgLXJjMSBhdCBnaXRsYWIuDQo+IA0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2pl
Y3QvY2lwLXRlc3RpbmcvbGludXgtc3RhYmxlLXJjLWNpLy0NCj4gL3RyZWUvbGludXgtNi4xLnkN
Cj4gDQo+IExpbnV4IDYuMS4xMTMtcmMxIChjMDYwMTA0YzA2NWQpDQoNClRoYW5rcyBmb3IgcmVw
b3J0aW5nIHRoaXMuDQoNCldlIHN3aXRjaGVkIHRvIHVzaW5nIHRoZSBnb29nbGVzb3VyY2UgbWly
cm9yIG9mIGxpbnV4LXN0YWJsZS1yYyBiZWNhdXNlIHdlIGhhZCBhIGxvdCBvZiBmZXRjaCBpc3N1
ZXMgd2l0aCBrZXJuZWwub3JnLg0KSXQgbG9va3MgbGlrZSB0aGlzIG1pcnJvciBpc24ndCBhcyB1
cCB0byBkYXRlIGFzIEkgdGhvdWdodCwgd2l0aCB0aGUgbGF0ZXN0IGNvbW1pdCBzdGlsbCBiZWlu
ZyBMaW51eCA2LjEuMTEzLXJjMSAoYzA2MDEwNGMpOg0KaHR0cHM6Ly9rZXJuZWwuZ29vZ2xlc291
cmNlLmNvbS9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LXN0YWJsZS1yYy5n
aXQvKy9yZWZzL2hlYWRzL2xpbnV4LTYuMS55DQoNCkkgb3JpZ2luYWxseSBhc3N1bWVkIHRoZXkg
d2VyZSBrZXB0IGluIHN5bmMgYXMgdGhlIG1pcnJvciBpcyBsaXN0ZWQgYXMgYSBjbG9uZSBhZGRy
ZXNzIGluIHRoZSB3ZWIgdmVyc2lvbiBvZiBsaW51eC1zdGFibGUtcmMuZ2l0Lg0KDQpNYXliZSB3
ZSBuZWVkIHRvIHN3aXRjaCBiYWNrIHRvIGtlcm5lbC5vcmcgaWYgd2UgbmVlZCB0byByZWFjdCBm
YXN0ZXIuLi4NCg0KQ2hyaXMNCg0KDQo+IO+/vA0KPiBHcmVnIEtyb2FoLUhhcnRtYW4gYXV0aG9y
ZWQgMTggaG91cnMgYWdvDQo+IA0KPiBQaXBlbGluZSBzY2hlZHVsZSBzYXlzIG5leHQgcnVuIGlu
IDIgaG91cnM6DQo+IA0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3Rp
bmcvbGludXgtc3RhYmxlLXJjLWNpLy0NCj4gL3BpcGVsaW5lX3NjaGVkdWxlcw0KPiANCj4gSSBj
YW4gdHJ5IHRvIHRyaWdnZXIgaXQsIGJ1dCBJIGFscmVhZHkgdHJpZWQgdGhhdCBhbmQgbm8gbHVj
ay4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gCQkJCQkJCQlQYXZlbA0KPiAtLQ0KPiBERU5YIFNv
ZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgICBNYW5hZ2luZyBEaXJlY3RvcjogRXJpa2Eg
VW50ZXINCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0
IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

