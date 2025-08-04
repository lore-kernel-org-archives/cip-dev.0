Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF0C87FD3
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 07:02:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.12421.1754290962868549132
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Aug 2025 00:02:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 57472eIk4116670; Mon, 4 Aug 2025 16:02:41 +0900
X-Iguazu-Qid: 2rWhSHZE8mJxsDBEv2
X-Iguazu-QSIG: v=2; s=0; t=1754290960; q=2rWhSHZE8mJxsDBEv2; m=l3CxckA16VkYG11GojX2aqoB6gmdWBZzTQImsd3sB7Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 57472cQ92264969
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 16:02:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGcP/m/2hVwO8oaMxpmtXUvwuklU7rHcLNldTrO9rmku90cJlxrn7HT529q23xY1gdCjjeYBtiMrk1L3ghkjCGrdbwCgdLeCunKNjJB3d+yXkV+2BqKwYJH2rsgyNgm/ffAOOmNZoKTSVhVnCW4lml6X1cA4XYWB2eywn5a+J4tymerSVLo6krdo8NVAMrxTvRed2hc9XeLXd43LtnCg+jv5xYfYFRBDqBjQshAZUdkgdvIUN5zDI/InF1LXdFRfJd8uL9z1aO4i/OVfscjgpS02ikOWMRAR478zNQOVxpCBuG0DoHnAG2xCDpBPS8VQ0HrBVvNIjr4qTPGhkLtt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z77tV6+ml6RACwGH0impxHSC073YGYmnzWohQVbg/4Q=;
 b=N9dTd5I/piriiDQ0wmRRIl3BnDVYwSLbHkdGX3EsWccm57MmoSZcJk8m7RcEJDdDBM7ftq9qFSQMJbZrPCk4z7bU+8mdT3COrmOa2Gly8gtifp10t3b9hNQZ9RV29O/ODZrJlE+QuEYH0ICz3i8wdcAV9pTCvT4MjRs6VMRsXcnq8Tvxw5O2Eq9ihx+74Btp7KFNSRDLQYXMQYAsyPQendvilbsJEHY/LwkpbUjDSn1o6D93Bv5TRdEGKn1gzsuU5FMUngslkGjXA1G3OL/p3TftKixDAJgIa5QyzGxuSEyw1LW/1Y4xDdvpACb7DdbRnzz/A1iGEA7z3Ogmz+FBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] Add additional test for secure
 boot to test rootfs corruption
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Add additional test for secure
 boot to test rootfs corruption
Thread-Index: AQHcATOsQyCYmKsM/0Wv+B5ZNp8mF7RSGJrw
Date: Mon, 4 Aug 2025 07:02:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110757927DD95F16932732110C723A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <1856FD20DDB468DE.21808@lists.cip-project.org>
In-Reply-To: <1856FD20DDB468DE.21808@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS9PR01MB14077:EE_
x-ms-office365-filtering-correlation-id: 8be0b6ac-b03d-4793-113b-08ddd324e3bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SG5pMStmWmg5REZ4eGVlT3kyMVZvdVM1bXJwRFhkYUdiMGJWeGhGbzVC?=
 =?iso-2022-jp?B?NHRneTlmTWcxY0dQWVR1dE5EMkR4c0ZGK2ZteWc0VmlxRkJCNXBWS0lM?=
 =?iso-2022-jp?B?TFIrL2tRVDNXc1RsVDNITzlpa2l5V3Q2NEN2UEtEOTU2S1QrNEYzUE9l?=
 =?iso-2022-jp?B?NHhObGh1aVRxVjROZWNtRlVITGt5Nm9oYlc4bExac1dxUDZMbjNLVE04?=
 =?iso-2022-jp?B?Q3ZWRFg0ektHaGJadUp0YW1pOVBsK1pDakhHdnZydXBmcnY3ZTYyYU0y?=
 =?iso-2022-jp?B?eHU2VkVrb1R5SzBkRVJXUWpiQkJBYjZSenk5NFF2REhzUjRvTnNXNzVY?=
 =?iso-2022-jp?B?M3FOUUg5SGdERTd6WUx1TzRFOVdTT21oSFIzUmY3eStUa3R4R1NxUjRx?=
 =?iso-2022-jp?B?S2ZpbXFrYTBlN1lYN0dTMXRDZld4Tjl6UjJtZ0FTaStCNnZrQWpjdlc2?=
 =?iso-2022-jp?B?eG5HdnpPVXFic1BYVmJUNytTWDI0c3hCWFhSZmtLb1RoYnRaTTI1YXdQ?=
 =?iso-2022-jp?B?UitPSUt4OXRJYlBzZ25EUHkyMktQbmVKWmlXandDOTV5K3pSaTdaWVZV?=
 =?iso-2022-jp?B?aVdHWW9mZWtnWGNrb1RyK012UnM3NXdVRWhSME9GNkt4ZmYxdnprcTlM?=
 =?iso-2022-jp?B?MGcrVGZKbmFvOEFEUTEzajJnNzM2NFFZaG5zdXRpQ0VPSkRCR2YxM0x1?=
 =?iso-2022-jp?B?KzZRbnErbm1TQlVocXlhVmpxaTFQOEFtaGlLUHNnMHNHMFB5eG1yQXpu?=
 =?iso-2022-jp?B?TkhCeC9yV09qN2licUdvVWZEaVkwUVFsR1A5eXhpTzBweXJQMEN0TVlZ?=
 =?iso-2022-jp?B?dW04T3pFSFpyRDRHOC9HckU1MklyK2xvT01rZnhSVGVteUdMS1Bvc2NK?=
 =?iso-2022-jp?B?b3lRdkdBQUlRQ20wMG5BY2pXbVFYcmw3enc3UmRzdStxTVA3Mm5Uby9o?=
 =?iso-2022-jp?B?Tlh2dFlTdzV4QTFSQVlhOHlKbmw2ekpJRHBaeWdZSHBRMW9Hc2lIMS9S?=
 =?iso-2022-jp?B?QlVIYVdXRVd0UmZwWVhzQVN6M3BxWEE1REtsenZYQ09qd1A3R3NaS2dr?=
 =?iso-2022-jp?B?K0QzcHNhTjM2S3hOYWxNeHJ4SGdMVms1ZDduUVBkVU9wTWZlN0hNVnc4?=
 =?iso-2022-jp?B?UVVRSUt4cXRmS0tidGpMZVNLV3ZqSXlzUi9VK1BIRHBSOTJkdVZRMlVr?=
 =?iso-2022-jp?B?azNWUmpSUG9ORUVSNEtQcEZGeTlrRWF6SnRZQXlsZTdtTWJxdlFwd2FC?=
 =?iso-2022-jp?B?cGpLdFRINkVldlJuUUFrdUdtajJxZ0NQUmJhNkRRaTFadWhhMXFxbGlF?=
 =?iso-2022-jp?B?UHVBUm5kZ3hnQW4xT1N5RFBVNHFrY2ptOEJCWTBmd085aDdyMkN2Si93?=
 =?iso-2022-jp?B?NUc5SnBIWC8xNlY2MkRhaTVZaUJkeDVmbE0wT3JaaHVSU0NzU2VuSkJq?=
 =?iso-2022-jp?B?TUVaVDgzbDUvU0VyOE00N0hRMDdjd29wQkVMaUQwUDVLNVJHTEdQenFD?=
 =?iso-2022-jp?B?N1hpYi9EdGJCcUpMN1dZT0FEaDlQVXVUbmM1bXdPNXZReThTVEUvcnA4?=
 =?iso-2022-jp?B?U1grLzVBQldFeUw3dDY4bEhCTDMxeFhoVkxzT2RJcTZubzVUSDVuS2k5?=
 =?iso-2022-jp?B?THBRa1Z5UUZNMDYyMmd0dVV5NGNtQjUzdTNYUGlIaXZ0Sll2YkxocjFW?=
 =?iso-2022-jp?B?UTBjN0pnM2JOU0VicUtRNTM4b2Q0RXgvT3ZwYXpmMDVnVlk3Ty9oa3Ja?=
 =?iso-2022-jp?B?OGNKeHdidDdmZy9wdjZxd2ZWN05oaVRhSkxLYm9idER1Z3dleDB6dTVF?=
 =?iso-2022-jp?B?NnVuZWp2cGN5dmVDWWRsaDJhV01nbE9LZWg1NUk2cm5ld09OV1ZOcTVJ?=
 =?iso-2022-jp?B?dUVZc1ZnQXU0STVLSlRUZ0MyamtKWEFHUE1BRDQwZFdmNExXRkYwUGJU?=
 =?iso-2022-jp?B?ZDNmUlA3bFFRVmRkVWZaaTJSWS9WWU9xYWRreHQrcG9uL3Q5UmFUbXRv?=
 =?iso-2022-jp?B?Z1hzL0FSSVhieFVyLyt4NzVRODY3Sjhpa3dSM29OQ2h5b1B2WU9UZk1S?=
 =?iso-2022-jp?B?QUVlWDc3Mk5vYitCZ09ab1JaV3V6OVVaK05qZ2FMTEt4QTZDb3BaVUpy?=
 =?iso-2022-jp?B?c2xUTHU3bHlWMDlPbnFzUTczYUM1L1hnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZmhLUGJUcVhOOUovd2hIZVF3TkRKUGhIT0pweXVRMk8zMDk0UTExVDhC?=
 =?iso-2022-jp?B?RXZpS1NqNnVNU0dVYWVYb2RJTnkzMmdtZWpkZTNEUTh3bkd4aTdaai9F?=
 =?iso-2022-jp?B?TzdEQmg4b1VOR3ZCVG5uNjliME8vSDZzeEFmdjdPRjdtSFA4bjFmc1l3?=
 =?iso-2022-jp?B?dDJ5MkI0T2FlNFdNbGNyUmljQjFsWjExb3cwRHhMYzVKVHZzQUhjeEY1?=
 =?iso-2022-jp?B?NEZ0dDhQbWI3bENhb1FUUlBQWCs2VmVWZzVVVDlFN2lOcGo1aEVIZWRK?=
 =?iso-2022-jp?B?cmdScjF2di9lZDZRRVBnaS91emNyZTl5QTBTTjNGSVBMVE1WYTlEalA2?=
 =?iso-2022-jp?B?MzM2T2JvZ3p4QnkrZFl1MFdreTVhWE5TOGgrWS9XVFdSR2VLajZZYldI?=
 =?iso-2022-jp?B?aEdaU1RPTHlzOGtXNmRLT09GVUNGYnlidjhlR3k0bW15M3R3RHZONUhr?=
 =?iso-2022-jp?B?QnBQZGdKNkNrNFJNWHJhbzBJalBRbGJuajNiZzI2eTFJTkVoajJEV1Bi?=
 =?iso-2022-jp?B?dEZFeEhXeEFmb1BSVXJOTGtlL1U2RzU1VllXdkk4WWptZS8vNzVMQWxj?=
 =?iso-2022-jp?B?K0ZBYngvWTJOdGwwWUVOaTlQQkhwREVXTlZKeUNFT0xpY3JUdTZoMUNW?=
 =?iso-2022-jp?B?YjVRTUQzaFFiOURIV29ETHUrc2NKTEV0NGh5bXBYdk4yZzV0dk5lUkVJ?=
 =?iso-2022-jp?B?RUt4R2Z4aDJjY0ZHMUprTGVKQkovVkJpUENKeW1rdVVYS0ZYdEY1Y3c3?=
 =?iso-2022-jp?B?NEg0TmFSdEhrRElJUGhhK1hSVURHSFRqSHg5NGZNL29wVDI2SEI4MWhz?=
 =?iso-2022-jp?B?ZE1SMENQS0I4M3dBVkVjaGx6K3FoQ05rdUNUR1RDVUtFbEw5anRyQkJi?=
 =?iso-2022-jp?B?bjZQUjBORVlBNVJlM3RnZ1ljY1JmWk5IeGxsYXJ0d0pEd2tydEJsVTZ0?=
 =?iso-2022-jp?B?L2pERjBiZ0ZqV1ZVNEtHT0JVYnN0c21sS1ZtdVN1ZGQ2OGxsVk43ends?=
 =?iso-2022-jp?B?SDI4SVRSL2xQWWEzWEJ3NCtTNElobFhpQ2tVRXBQUzVVT3dJb0VhNjRQ?=
 =?iso-2022-jp?B?WjZTYUljN0R5VEF5L3UxZzVaZ2pLSmRtUUYrZ3ZmeDhKeEVQZVUzVFM4?=
 =?iso-2022-jp?B?ZFZ0eEdQeVIzRmxmUzdpRVZ4ZWVQTW16OEpTanp1Ly9aVEgwdGsxSGhP?=
 =?iso-2022-jp?B?UituUWUvcnF2dU94WDkxT0lGUFgycVQ0T3FHbTZlL0o5TUJjTmZjWFox?=
 =?iso-2022-jp?B?TXgxWFJKUHptL0Q1K1JUdWZmVzJLUDZqdU9QVVk4Q21RbG5vS3dFd0pa?=
 =?iso-2022-jp?B?QVJscTNoUjlnZThYSk8xYTVpY3BOMm53MEFsaHNkU1dLNm5xL0FUakNp?=
 =?iso-2022-jp?B?cWo4eGpxTU83N2lJTEphSFRVVTFwSVRvbXE3WFRoR2JYcklUbDRtamJx?=
 =?iso-2022-jp?B?T2lOb3luYU43NG5vaWJYVnZub3o0QWRyZzdIZ0JjdUxuclhqRTliZXhm?=
 =?iso-2022-jp?B?ODRLampBTS9vRFI4VVd6TU5wUUxQSktWL01RNlNrZTdBZGlCOVpCYkpX?=
 =?iso-2022-jp?B?L1lMdndNM2tsaHFTWWdZbXR4M1JtU3NsK0R3Sm05cmI1eVJodnFWa0p1?=
 =?iso-2022-jp?B?R0lZMHNJOGhhNFVieDVja0R3UzEyZ0RSVTJUNTZJMUUzSGNuay9pOTFu?=
 =?iso-2022-jp?B?OFRDd2tkUlhHYTdFVU1MeFBhYTdsMm9mUHBOQU8xTy9xWW9rUTlJVUJK?=
 =?iso-2022-jp?B?Nk5CcnArOXgxU3AyS1VtWWYrUW5tRms1YkV2TzJrV3R6TmdwZXVqSlRK?=
 =?iso-2022-jp?B?WXdRZ1F0d2lWVkZxYUxKdVJVSVE4K0UzU3ZxbmxXNHBpaXIybCttbDV0?=
 =?iso-2022-jp?B?WjFKZnR6Q0FNaUNISVFwV2VjWGVuNHRQZ1loSHZPUUdYTEJxWEhUYkw0?=
 =?iso-2022-jp?B?aS80eHpJeVJMcWU2alo4T09jYlFtMkZkWFVoNDNwajRqOUhqeVhhT0xT?=
 =?iso-2022-jp?B?bHN3ekg0d2xQYjh4VTNqekNKcnpkYVpkWGhJWWxiVGpWU2VpZmt2YVF4?=
 =?iso-2022-jp?B?bU8xWHNOOWRFUTZOOEQvV0luaG10ejBaOU94SS8wb1hYcjE2RG1BVDlW?=
 =?iso-2022-jp?B?ZjVZRFI2RUl0MVpudnBCb3NmK0dvMlU5dlhOYmhQYTdnbHl5K085OURZ?=
 =?iso-2022-jp?B?MGg5cnpPM2dEN1FNUVF0TGRDVEE1U2hVaWpDWm1temtJS1h5RnV3MmlN?=
 =?iso-2022-jp?B?UmRZdkVkMGc1Q3Rza0ZwTjJWbGtpaG44NDlQVCtOQmdHQUJveVhQRUx6?=
 =?iso-2022-jp?B?K0xDcnNJWVVNc3JncTV3d1NFdTAyV2ZCWUFkZmdJdmxlQ2VYRUMzQlFu?=
 =?iso-2022-jp?B?TExRRnM9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be0b6ac-b03d-4793-113b-08ddd324e3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 07:02:34.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MK1hkkdWMTTVaKLDxTqLmdiTx6iUqwmYN5vtC/fLuqY5SJ0pTpMnBNZFzO/gfVcyoGsC7KXlGW9Sed/hePMZ9tdLQ1slvm7lMq8VGMQzQtygRWhOuJpmAqaoAJ8f5bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Aug 2025 07:02:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19658

Hi Jan,=20

Sorry to bother you,  any feedback on this patch?

Thanks & Regards
Shivanand K

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Kunijadar Shivanand
Sent: 30 July 2025 14:44
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh=
.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$=
B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH] Add additional test for secure bo=
ot to test rootfs corruption

Add a test case to verify and detect rootfs corruption i.e dm-verity corrup=
t case.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml                                | 24 +++++++++++++++++++
 scripts/submit_lava.sh                        | 16 +++++++++++++
 .../secureboot_corrupt_rootfs_steps.yml       |  7 ++++++
 3 files changed, 47 insertions(+)
 create mode 100644 tests/templates/secureboot_corrupt_rootfs_steps.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 7c05ad4..628e624 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -508,6 +508,30 @@ test:qemu-arm-secure-boot-unsigned-bootloader:
     target: qemu-arm
     test_function: secure-boot-unsigned-bootloader
=20
+test:qemu-amd64-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot-corrupt-rootfs
+
+test:qemu-arm64-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot-corrupt-rootfs
+
+test:qemu-arm-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: secure-boot-corrupt-rootfs
+
 test:qemu-amd64-secure-boot-mismatch-keys:
   extends:
     - .test-cip-core
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh index 6cb0837.=
.5cb4430 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -118,6 +118,22 @@ create_job_qemu () {
 		if [ "$2" =3D "qemu-arm" ]; then
 			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootload=
er_${2}.yml"
 		fi
+	elif [ "$1" =3D "secure-boot-corrupt-rootfs" ]; then
+		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_corrupt=
_rootfs_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_corrupt_rootfs_steps.y=
ml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		cd -
+
+		sed -i "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verit=
y device corrupted'@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		sed -i "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" "${j=
ob_dir}/${1}_corrupt_rootfs_${2}.yml"
+		sed -i "s@#ARTIFACT#@rootfs@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+
+		if [ "$2" =3D "qemu-arm64" ]; then
+			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_corrupt_rootfs_$=
{2}.yml"
+		fi
+		if [ "$2" =3D "qemu-arm" ]; then
+			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_corrupt_rootfs_${=
2}.yml"
+		fi
 	elif [ "$1" =3D "secure-boot-mismatch-keys" ]; then
 		if [ "$2" =3D "qemu-amd64" ]; then
 			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismat=
ch_keys_${2}.yml"
diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/te=
mplates/secureboot_corrupt_rootfs_steps.yml
new file mode 100644
index 0000000..b6f6628
--- /dev/null
+++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
@@ -0,0 +1,7 @@
+          - "apt-get update"
+          - "apt install -y fdisk"
+          - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-image=
-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Dsystem=
a '$0 ~ name {print $2}')"
+          - "rootfs_start=3D$((${rootfs_start_sector} * 512))"
+          # The value 96 is squashfs superblock header size, so skip heade=
r and corrupt the data after that.
+          - "offset=3D$((${rootfs_start} + 96))"
+          - "dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-#dist=
ribution#-#architecture#.wic bs=3D1 seek=3D${offset} count=3D8 conv=3Dnotru=
nc"
--
2.39.5




