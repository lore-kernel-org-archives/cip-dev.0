Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6727C98331
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 07:23:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85310.1767684176070855663
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 23:22:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=R42m0GeY;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1767684151;x=1768893751;bh=
	mwzmCkmOvWSYDPr0JkZbzLvBeVn9OHwVnHGI2CHYDvk=;b=R42m0GeYS9WAPdhKvoawL2Qeu1lj7n
	05xFOCJd5sm/0ZaMpiI1DwsuNeexoDWTP50TpSOaMkbMJ036+csTPmafZZvir/BGkklOf6We982Fm
	tldie7o6lbRHRcZkIKQpkfylnJ/miGYsf3kfi70OOuJwE+GUyJB4viz7+aShHyh9dnswYOA8XT72z
	1rbOjRUTMDOE74RQ7gYUE1mMD6U7aM6XgR5h30KadL6TUFTjk7OUv8jPulWFrSN7Nv4Uqwtbj3k6u
	19OKcrpflo3X/Bt1DZvR9NvtjkrWtBEsHcoA2k3qPyBxRTjQI8xKBK/amZK9EKE+vEUcnPxZf5NgG
	hSIQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6067MVLI1549340; Tue, 6 Jan 2026 16:22:31 +0900
X-Iguazu-Qid: 2yAaLE8zt6cQrQiShF
X-Iguazu-QSIG: v=2; s=0; t=1767684150; q=2yAaLE8zt6cQrQiShF; m=jsxryyuLKo2RrmRBBQuX5+Ltewu91AkGpDMnLJhixQs=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dljKy0vYWz1xnZ; Tue,  6 Jan 2026 16:22:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vudSiKtTolfv6MLT1CwxyHJX1VIRkJAHIydOeRYMIgyd3Xrfbldyx5qEehDB9PHEP+can9D536ou6aVzimdqk9P3uGM3tbY7nunoJ7pVSkpdlutCQJtDbwo6JiCyBVJSQvosAJT+Rf1TIfK2picXo6f0xktoDLljQKFE866kXvkQX9707M6QiH4MVVk41w8Hz2InK7Mnfiq3MCRFYkpj9s2p3vciMX+zvIEWa/2tOpqeLeY/quRhHKGFy8qFAVYY8YtWPeNGvrXXSe8edV2+Wz8iDqG4leAAwR5haoldWgScicGdmrkzeOF1CU+fQ2ZCzj3vX8VoSXRCiqwr3Y0Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Nqkr+MNz2FLMAJqPm9he544BpgcS+d0BGOIJ6WN3g=;
 b=rEensA9W7gAYLlhndJrhlrBKNK25qozuebU4svuMzr/tYiVaIzdVWFOiiPKwRQLDFCQcxjsDM0dkDAwY5CFgIsqE5n7E5XoUrmLF8USCnC3U5OesCXYh4s7pKpWFD+T2S9dkynas8wul3ed/JAyGCGlKUjtkhKYCQiP5oLQKblcraSUBP7hMqV/RaYT/Klj9bDHYNxbbtVZfLVpGyzm43Oenmyw6WDVHi2oZE+eNDueYIUCbzHXAB01tWXnVvt5WrzyKtXvo3SuNp4tt4NGFjtu6BHtxJ+ngZAvNS3ROWHqxOfyZV54Z8xS7WFbvbob6F+xCb43xu9xQ4Pr5JmcSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.63-cip15
Thread-Topic: [ANNOUNCE] Release v6.12.63-cip15
Thread-Index: Adx+3SGJhGUiqBHKRiWv1ZV7ZryLvQ==
Date: Tue, 6 Jan 2026 07:22:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C3D371486C687E5793F7CD87A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB12880:EE_
x-ms-office365-filtering-correlation-id: 7e402a8d-668c-415c-32ed-08de4cf4588d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7142099003|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M1diWWNlRFMyV3FGcVBpcTlSNkRKV0ZnQlkyd2xYVDl6Vkl0SEJtVWxs?=
 =?iso-2022-jp?B?OWI5UE5KcXRHUk9RUlFiVVZDbE1MUHZUMjFKUGhMUUl2Qm5KQ1BWUDc1?=
 =?iso-2022-jp?B?ZmRoUHp3WlNLMUJFQmloUDRNdk9xeUN2Tm9ZeVlCNFlIQVJrV1FPVHM4?=
 =?iso-2022-jp?B?VjJrOVhtSll4c2E5QUtLTm5jUlBjcTFvaUhqK3Z0SUtXNStUbU9ESk9H?=
 =?iso-2022-jp?B?SFd3NXBYUDZ4ODBJWmVIL3U0bnl0Y0xOa1IyQ0NYcGhmL1VUdFliQm5a?=
 =?iso-2022-jp?B?cFZlY0R0NFlJeFdMelh1Ri94d29NaThLb3RFUmsyQmsvVW5IQnhLaXdV?=
 =?iso-2022-jp?B?VmVNNTE4T1VVNXJqWlE5TWUrU1owQzA4cmR3ZE5sTFFLRFM5Ym1vdHN4?=
 =?iso-2022-jp?B?RXNTaVV6R0dqUERib3dobytLODhFMVJiRGRhdmRQNlVkb0xhVkNQVUZ1?=
 =?iso-2022-jp?B?VzljOU9RTUkzZFF0bU95eXFmQW4vb3FmRzBDeFBPcTNWWmxVQWcrSkN0?=
 =?iso-2022-jp?B?elJwbjlSb1gyS2VmeHZtcXY5UEYrQmNPdmZ6TE14WmtpUE9STnRZS3RU?=
 =?iso-2022-jp?B?MHZLbDVDV1lGMTFzTWRtY1R5TUIxc0tObkNud3JRV0hkWDN5bzg2Wk13?=
 =?iso-2022-jp?B?cGFZajNIUnAyVTg1YXhsemFXdk8ycW9aYVp2amlrak9aSkhKM2c4Wmxn?=
 =?iso-2022-jp?B?bzNDaFV3ZC9iTXFwcmw2RlRaSGp5K2kxdWVsUGJoamliZ2VnNGcxOFd1?=
 =?iso-2022-jp?B?SDNNa3EvTlE4Z0NQdGpEaHpIOU56TkJJYVQ1MElJWERuZXJZR2psRzVq?=
 =?iso-2022-jp?B?Rmt6VjVlSUtQSXNhbmd6eGszUU80N0JDL0FTaTcycnhHVW1ta1RLMmJL?=
 =?iso-2022-jp?B?MkxXMnd0dHoxakkwakJZbG1qUEVwZ3Z3WVUyRkdVeEVLYTRVdVFjeWh3?=
 =?iso-2022-jp?B?VW5QWlRQY0pmaXpzK2l2WFlBVXhvbnB2dWZGejdLVUI1cVMrd1YwZEE3?=
 =?iso-2022-jp?B?N2lLdTFoWVNFOW5vOTgxMXdZbDhtdmc5MnlNUUQ2V2g2OGV2VEtxTWt0?=
 =?iso-2022-jp?B?NS9QcDBnUXkxWUl5TjhLeWZxdmxEN2pkZ3h6UmJESXFzZnZzSWxKbWtN?=
 =?iso-2022-jp?B?RG9jWW4rTVpkWGo2UzJUT040WnJNdlRtOEMxalBJOHZTazBEdjlZYThn?=
 =?iso-2022-jp?B?amIrREJLVU96NndhNzNtZ1R6eDhYc3BmdytFK1dma1oxVEN3MEEzakhW?=
 =?iso-2022-jp?B?QnNISzlhaE1vdGhmMkdZUkc3ajRBTlQzOXJtNUZJV1VzV3lITmo2MElT?=
 =?iso-2022-jp?B?eDc2Zk9RRWNtZXdEc1dFQTBWYWJ1cjhJZEhscGlLUzloZVRidzJ4aVg4?=
 =?iso-2022-jp?B?dHlTS2hLUS92aHRlM2VGcy9oWXVWQXJvSWd0NVVZRTdRU3FzVmgxT3dB?=
 =?iso-2022-jp?B?M2V1YXB5U3I0eW1ya1pLQXY3aUVHUSs0blJnSTA3MjZ5dzFvYUhPajl5?=
 =?iso-2022-jp?B?c3ZsUFM0UUhnRlNVVzdvREdvZk12VTFpWkNIVEFiUDE1czFCTnd2V3hL?=
 =?iso-2022-jp?B?RUdmZlcyR0U2c1lLK2ZwelpjOTRYNXRVQjFNT3F2L0plc201T0J1WExo?=
 =?iso-2022-jp?B?U2dlcklja2lDbmZDZXA1c0hjZE0zMHRMWktpZWlLWVhWbmV0VmVaU2p5?=
 =?iso-2022-jp?B?aU0rd3ZXMEV4ay9ULzdxUWZwQ1lObnpzdjFsNDY3TmFnZk5PTFFmcXhV?=
 =?iso-2022-jp?B?YnpjWUVhZU5FemJLTkdaNzFMK2pqV2R3UEpmdENvVW5rNVR4cURBeE81?=
 =?iso-2022-jp?B?d1FVY0laaGtvbCtDVVBPZnhqd1ZoTUp5NGkyMElpRmllMnJrT2Z2aDV5?=
 =?iso-2022-jp?B?Sm9WcEdqdncyaEtONXA5SWQyM21PSVFaWnFxaXI3RXpyTjRNS0hyOTRQ?=
 =?iso-2022-jp?B?citHNjJnaHlpRFRCZVI5akM1cE1PMHFKZStvbnZieUQ2bWFWYWFuajF3?=
 =?iso-2022-jp?B?dC9Hb1Y4eTc1OGpoSlRHY2FVQzkwUDhIRjFxWVdHenZHMkZKUndTSVlL?=
 =?iso-2022-jp?B?d3ptWmEvMzY1WGM0ditnUXZTQnVuZ0ZFVFZnUjhhWVkxUjcxUG9scXFC?=
 =?iso-2022-jp?B?bStEWEVFTWxybko4MEJBdmo2Y0JoWnJ1UFJ0Wll4YjdWc2Uzd3NZcXMy?=
 =?iso-2022-jp?B?SnhseVZNdGFKUlhjVm9DNmlHdDBkRVhV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZlRzbDZvOHROME1QblNOckFDSTJ3WThsTUV2QkhSbCsrRVIyb2tWbUJ6?=
 =?iso-2022-jp?B?aUZYYUZOM1lidlc2UkNId1B0b1AwSko4dnpGeVE0YnM2Rk1SbWR1QlE2?=
 =?iso-2022-jp?B?eG5FSVZZMVdoTElwR2JJYVczVmV4MzgzUWhtU2pKaHkyaGJqVFgzcW5K?=
 =?iso-2022-jp?B?ZitsNDVtMHQ2OE5TTTFwTGFmVE1pbzBUUTV4VVpKZXVlWEFmNmNrZFJC?=
 =?iso-2022-jp?B?K0JoNnpGZEF1Z1Y1MkV3Z0N5SUZPaFNCMDliWVhteUpwQUxVYVhGUVpQ?=
 =?iso-2022-jp?B?VzlLYkNDUGhqM0tucnByZmxTMUl1cXo0U2N5dmxVdm1qWXdIS2pCclly?=
 =?iso-2022-jp?B?VC9yeUNnNUNQZVBrdWc4M2hZRzlSdkdVVlVGS3NHcm4yRnpETTlTRkdT?=
 =?iso-2022-jp?B?bEZTSzl2ZTBXSERIdXViZHJPL2F6c3B0TWtEQ0ZFUGRNeWg4czhjR25R?=
 =?iso-2022-jp?B?ckNJc2R4NGVNczdPbTlUSU1kQ2Zud2ErUHRtTUFUb2pOZlVNcjZXYXVH?=
 =?iso-2022-jp?B?QmRCOHk2bThZTlpXSG9hYnAwS2FjMy9yZXFSQkt5TFlpaGxpNnNaY3Fo?=
 =?iso-2022-jp?B?eDl6SDYrQ29iT0k3bTlSL3BhUXRSMW5kU3BuNU4xRGZRdWtWQzd0MnU5?=
 =?iso-2022-jp?B?MkJNQTJMaDRrazkwWUpya1ZOa3B4NFowNDdMTGsyYVBUdk5QN2RQZDNr?=
 =?iso-2022-jp?B?SVlUaGExTjVSZHJzU2ozQVNlN0hFcmFra21mTE0xSFlWcGxGalp5MHZN?=
 =?iso-2022-jp?B?U2NsZlJkelF5NDA3SUJrOWpVR2JTaFFHc1JsV2xZSDM3YUFZN3BHUE0y?=
 =?iso-2022-jp?B?ZHlaakgvcGREQUYzM0wrdEVldG54N0FLaVFRN2NpVnJ1R1ZjSXdmUXFq?=
 =?iso-2022-jp?B?YytRbktqZ01jZThoNW9TYmh4dStjYkhTOVBoVXZBTTZxSDY0a2dCTHNr?=
 =?iso-2022-jp?B?TWhvVCtwcVB5QytWSXpZV0JLTFZ2MWhmU205TlVmcUdBN25KamdTcjFm?=
 =?iso-2022-jp?B?MEZFUTVpaHR4QzNYN3lkYitLWmpXNXNIWEVXV0lqYUErYU5PQTZnanhw?=
 =?iso-2022-jp?B?OW1NWmFhSnlRN3RSb1FGbEl1UzJlcXFLdmxTRE1QaWZjbENkeXFpTGtj?=
 =?iso-2022-jp?B?ZmVZMFFwN1pmWlBnU0pWZ29uK25PZmtlRVdYcnY1QVVuMmpTRGJrRjdk?=
 =?iso-2022-jp?B?TzJ5QWhJNjFoNlN4YlQ2U0sxSFpaOTdtUldFNzZmRDB0YmpDR2pwOTNW?=
 =?iso-2022-jp?B?a2FPVXc5Szd1Y0kzMkpLSVhsUVE2MkNWaVJSakxDRHVrNUhlTStSVU9p?=
 =?iso-2022-jp?B?L29VVDY2aWd1RVNOYTNNdncyWnJHeUI5aFZoSm5ieUxXOWJwT2czNE8v?=
 =?iso-2022-jp?B?VmQ3N2RjNEthdFBRa2pLc21xK09seXAzUlE0ZWY1M0lpU0p4U3lleFVp?=
 =?iso-2022-jp?B?NDZLQng5V09UWXNRZHR2c1Nlb1VaMG1kKyt6WEdJQ3lJVTQ0UGxTRzFE?=
 =?iso-2022-jp?B?RDdrWWdkaXBhRUZ5MWRCd2lJdGJVNEtESklGSHg3T0FqMHR5Q1hvUXRX?=
 =?iso-2022-jp?B?dlZyc2x4R3NDR1BlN252Q1dDVmFleitEQ3BpYkxRSk0wbnpBZ2x5ZGJH?=
 =?iso-2022-jp?B?WDdwbGdVSzdzdGJacXd4R0dHNm93SFYxUlRCMzA1YTErTXcvei9TWVZn?=
 =?iso-2022-jp?B?dUZwL2p3eURNendrMDlwdXJVMGZhdFNYblNjRVpPZUNwTWVyZ1ZnaUZ0?=
 =?iso-2022-jp?B?NThTT29mVTBlZDZNeDdDQ3V0Q05VajVQbCt3OStVTDNta2ovd3hSVkt3?=
 =?iso-2022-jp?B?THIwVTdvSkFKdEI3MVY4OUFRVXRXRFlwOWxibUZIMVdBbVNaSnJXZzM5?=
 =?iso-2022-jp?B?Q0dMVkE3T3NhYUtsOVZ1MXpMYnczTjVhc3lXZWtHVmFpTW56cG9KcjRY?=
 =?iso-2022-jp?B?cWkrTk1jVWpYRHR5b2hhYXhNNG5rZC9PRTNMcmRXRzVBOEpQOWV4TUJX?=
 =?iso-2022-jp?B?ZGdTZlhRTWx3R05sc24zb3RrSU5DbHV4MWVYelVkL1FzZjFTTEZPVXlD?=
 =?iso-2022-jp?B?K2QzblJzcEQ4Qkk2MG1RV014Y2tFbmN0eHlBb2VlaWVRdXNjQjVOYVdQ?=
 =?iso-2022-jp?B?TEhDcUdPcWcyQTRPTTRmbjVpWVRKOC9CN2dQYldhZk4rMkVjZFpvMVBz?=
 =?iso-2022-jp?B?YWtkR1dBUi95Vjl3c3ltZEg3ejFaQXBZUHlCSC8yZUFaMHRuM0pucDkw?=
 =?iso-2022-jp?B?TjFkMTk5TWI0bElFWnh3U3NNb2NMU3RvUU9TMWdENTByclhHdzEvQWZH?=
 =?iso-2022-jp?B?QWxlN0lxSFpHUzdWUm81K082ZWdySC9YeFoweTR5c0FCS2k0ZWdhcE5s?=
 =?iso-2022-jp?B?OEpaK3V5WVVMWjVJNVRTMnVZay9pQklHakg2Tk5yYUJIWTBSdGtOQmVO?=
 =?iso-2022-jp?B?N2psNHlLVWE1Tm5rclA5MllSaksvV2ZjQUdwYVdxWVhnMkxIRmxVVWFu?=
 =?iso-2022-jp?B?RXMrZTBjaGl6ZlV6dmpmWEtURnBDZlpxdnRrYzN0bW1LUTQvdnU3TDE5?=
 =?iso-2022-jp?B?d090bTZmUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e402a8d-668c-415c-32ed-08de4cf4588d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:22:27.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5FlRb+ik5EKhTJshypBn/jt9X3b1FRNOhrn/U0XKLzmAaWQddKvqpWaNOvUXzaU1cyK5AOO6MwHA6usWewhnbavfvpnLn1xdAfpzeoWvaEVUroM0/aduav6dOWo8QhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 07:23:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21320

Hi all,

CIP kernel team has released Linux kernel v6.12.63-cip15.
The linux-6.12.y-cip tree has been updated base version from v6.12.59 to v6=
.12.63.
This release adds support for Renesas ARM64 SoCs RZ/T2H, RZ/N2H, and RZ/V2N=
.

Information about this release is as follows:

  v6.12.63-cip15:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      778d7f4596e10f90bd6045adf3f1b1fd83374354
    fixed CVEs:
      CVE-2025-68237: mtdchar: fix integer overflow in read/write ioctls
      CVE-2025-40250: net/mlx5: Clean up only new IRQ glue on request_irq()=
 failure
      CVE-2025-40254: net: openvswitch: remove never-working support for se=
tting nsh fields
      CVE-2025-40251: devlink: rate: Unset parent pointer in devl_rate_node=
s_destroy
      CVE-2025-40262: Input: imx_sc_key - fix memory corruption on unload
      CVE-2025-40253: s390/ctcm: Fix double-kfree
      CVE-2025-68223: drm/radeon: delete radeon_fence_process in is_signale=
d, no deadlock
      CVE-2025-68214: timers: Fix NULL function pointer race in timer_shutd=
own_sync()
      CVE-2025-68227: mptcp: Fix proto fallback detection with BPF
      CVE-2025-68222: pinctrl: s32cc: fix uninitialized memory in s32_pinct=
rl_desc
      CVE-2025-68217: Input: pegasus-notetaker - fix potential out-of-bound=
s access
      CVE-2025-68215: ice: fix PTP cleanup on driver removal in error path
      CVE-2025-68226: smb: client: fix incomplete backport in cfids_invalid=
ation_worker()
      CVE-2025-40252: net: qlogic/qede: fix potential out-of-bounds read in=
 qede_tpa_cont() and qede_tpa_end()
      CVE-2025-68235: nouveau/firmware: Add missing kfree() of nvkm_falcon_=
fw::boot
      CVE-2025-68213: idpf: fix possible vport_config NULL pointer deref in=
 remove
      CVE-2025-40246: xfs: fix out of bounds memory read error in symlink r=
epair
      CVE-2025-40261: nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nv=
me_fc_delete_ctrl()
      CVE-2025-68218: nvme-multipath: fix lockdep WARN due to partition sca=
n work
      CVE-2025-68229: scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_=
address_show()
      CVE-2025-68230: drm/amdgpu: fix gpu page fault after hibernation on P=
F passthrough
      CVE-2025-40259: scsi: sg: Do not sleep in atomic context
      CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC
      CVE-2025-40257: mptcp: fix a race in mptcp_pm_del_add_timer()
      CVE-2025-40263: Input: cros_ec_keyb - fix an invalid memory access
      CVE-2025-68219: cifs: fix memory leak in smb3_fs_context_parse_param =
error path
      CVE-2025-40248: vsock: Ignore signal/timeout on connect() if already =
established
      CVE-2025-40266: KVM: arm64: Check the untrusted offset in FF-A memory=
 share
      CVE-2025-68220: net: ethernet: ti: netcp: Standardize knav_dma_open_c=
hannel to return NULL on error
      CVE-2025-68233: drm/tegra: Add call to put_pid()
      CVE-2025-68238: mtd: rawnand: cadence: fix DMA device NULL pointer de=
reference
      CVE-2025-68231: mm/mempool: fix poisoning order>0 pages with HIGHMEM
      CVE-2025-68224: scsi: core: Fix a regression triggered by scsi_host_b=
usy()
      CVE-2025-40258: mptcp: fix race condition in mptcp_schedule_work()
      CVE-2025-68290: most: usb: fix double free on late probe failure
      CVE-2025-68293: mm/huge_memory: fix NULL pointer deference when split=
ting folio
      CVE-2025-68342: can: gs_usb: gs_usb_receive_bulk_callback(): check ac=
tual_length before accessing data
      CVE-2025-40345: usb: storage: sddr55: Reject out-of-bound new_pba
      CVE-2025-68339: atm/fore200e: Fix possible data race in fore200e_open=
()
      CVE-2025-68291: mptcp: Initialise rcv_mss before calling tcp_send_act=
ive_reset() in mptcp_do_fastclose().
      CVE-2025-68286: drm/amd/display: Check NULL before accessing
      CVE-2025-68340: team: Move team device type change at the end of team=
_port_add
      CVE-2025-68305: Bluetooth: hci_sock: Prevent race in socket write ite=
r and sock bind
      CVE-2025-68308: can: kvaser_usb: leaf: Fix potential infinite loop in=
 command parsers
      CVE-2025-68298: Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso=
_intf() NULL deref
      CVE-2025-68327: usb: renesas_usbhs: Fix synchronous external abort on=
 unbind
      CVE-2025-68283: libceph: replace BUG_ON with bounds check for map->ma=
x_osd
      CVE-2025-68289: usb: gadget: f_eem: Fix memory leak in eem_unwrap
      CVE-2025-68287: usb: dwc3: Fix race condition between concurrent dwc3=
_remove_requests() call paths
      CVE-2025-68343: can: gs_usb: gs_usb_receive_bulk_callback(): check ac=
tual_length before accessing header
      CVE-2025-68295: smb: client: fix memory leak in cifs_construct_tcon()
      CVE-2025-68284: libceph: prevent potential out-of-bounds writes in ha=
ndle_auth_session_key()
      CVE-2025-68307: can: gs_usb: gs_usb_xmit_callback(): fix handling of =
failed transmitted URBs
      CVE-2025-68303: platform/x86: intel: punit_ipc: fix memory corruption
      CVE-2025-68296: drm, fbcon, vga_switcheroo: Avoid race condition in f=
bcon setup
      CVE-2025-68331: usb: uas: fix urb unmapping issue when the uas device=
 is remove during ongoing data transfer
      CVE-2025-68341: veth: reduce XDP no_direct return section to fix race
      CVE-2025-68329: tracing: Fix WARN_ON in tracing_buffers_mmap_close fo=
r split VMAs
      CVE-2025-68302: net: sxgbe: fix potential NULL dereference in sxgbe_r=
x()
      CVE-2025-68301: net: atlantic: fix fragment overflow handling in RX p=
ath
      CVE-2025-68288: usb: storage: Fix memory leak in USB bulk transport
      CVE-2025-68328: firmware: stratix10-svc: fix bug in saving controller=
 data
      CVE-2025-68306: Bluetooth: btusb: mediatek: Fix kernel crash when rel=
easing mtk iso interface
      CVE-2025-68292: mm/memfd: fix information leak in hugetlb folios
      CVE-2025-68338: net: dsa: microchip: Don't free uninitialized ksz_irq
      CVE-2025-68300: fs/namespace: fix reference leak in grab_requested_mn=
t_ns
      CVE-2025-68285: libceph: fix potential use-after-free in have_mon_and=
_osd_map()
      CVE-2025-68330: iio: accel: bmc150: Fix irq assumption regression
      CVE-2025-68282: usb: gadget: udc: fix use-after-free in usb_gadget_st=
ate_work
      CVE-2025-68297: ceph: fix crash in process_v2_sparse_read() for encry=
pted directories
      CVE-2025-68232: veth: more robust handing of race to avoid txq gettin=
g stuck
      CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistrati=
on
      CVE-2025-68257: comedi: check device's attached status in compat ioct=
ls
      CVE-2025-68266: bfs: Reconstruct file type when loading from disk
      CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy t=
ime for states that were never added
      CVE-2025-68264: ext4: refresh inline data size before write operation=
s
      CVE-2025-68265: nvme: fix admin request_queue lifetime
      CVE-2025-68259: KVM: SVM: Don't skip unrelated instruction if INT3/IN=
TO is replaced
      CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in OnAs=
socReq IE parsing
      CVE-2025-40215: xfrm: delete x->tunnel as we delete x
      CVE-2025-68261: ext4: add i_data_sem protection in ext4_destroy_inlin=
e_data_nolock()
      CVE-2025-68263: ksmbd: ipc: fix use-after-free in ipc_msg_send_reques=
t
      CVE-2025-68335: comedi: pcl818: fix null-ptr-deref in pcl818_ai_cance=
l()
      CVE-2025-68256: staging: rtl8723bs: fix out-of-bounds read in rtw_get=
_ie() parser
      CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_a=
ttach()
      CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write=
_lock
      CVE-2025-68254: staging: rtl8723bs: fix out-of-bounds read in OnBeaco=
n ESR IE parsing
      CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access(=
) when file system corrupted
      CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in asymmet=
ric_key_generate_id
      CVE-2025-68371: scsi: smartpqi: Fix device resources accessed after d=
evice removal
      CVE-2025-40075: tcp_metrics: use dst_dev_net_rcu()
      CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size =
validation
      CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in =
cake_drop
      CVE-2025-68348: block: fix memory leak in __blkdev_issue_zero_pages
      CVE-2025-68378: bpf: Fix stackmap overflow check in __bpf_get_stackid=
()
      CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect
      CVE-2025-68379: RDMA/rxe: Fix null deref on srq->rq.queue after resiz=
e failure
      CVE-2025-68369: ntfs3: init run lock for extend inode
      CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_e=
xtent()
      CVE-2025-68748: drm/panthor: Fix UAF race between device unplug and F=
W event processing
      CVE-2025-68747: drm/panthor: Fix UAF on kernel BO VA nodes
      CVE-2025-68352: spi: ch341: fix out-of-bounds memory access in ch341_=
transfer_one
      CVE-2025-68374: md: fix rcu protection in md_wakeup_thread
      CVE-2025-68733: smack: fix bug: unprivileged task can create labels
      CVE-2025-68363: bpf: Check skb->transport_header is set in bpf_skb_ch=
eck_mtu
      CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_l=
ayout_stateid_invalid
      CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_togg=
le_emumouse
      CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_form=
ats()
      CVE-2025-68347: ALSA: firewire-motu: fix buffer overflow in hwdep rea=
d for DSP events
      CVE-2025-68742: bpf: Fix invalid prog->stats access when update_effec=
tive_progs fails
      CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflo=
w in rtl8187_rx_cb()
      CVE-2025-68380: wifi: ath11k: fix peer HE MCS assignment
      CVE-2025-68732: gpu: host1x: Fix race in syncpt alloc/free
      CVE-2025-68324: scsi: imm: Fix use-after-free bug caused by unfinishe=
d delayed work
      CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list =
with regulator_list_mutex
      CVE-2025-68728: ntfs3: fix uninit memory after failed mi_read in mi_f=
ormat_new
      CVE-2025-68372: nbd: defer config put in recv_work
      CVE-2025-68741: scsi: qla2xxx: Fix improper freeing of purex item
      CVE-2025-68727: ntfs3: Fix uninit buffer allocated by __getname()
      CVE-2025-68740: ima: Handle error code returned by ima_filter_rule_ma=
tch()
      CVE-2025-68361: erofs: limit the level of fs stacking for file-backed=
 mounts
      CVE-2025-68356: gfs2: Prevent recursive memory reclaim
      CVE-2025-68746: spi: tegra210-quad: Fix timeout handling
      CVE-2025-68744: bpf: Free special fields when update [lru_,]percpu_ha=
sh maps
    added commits:
      CIP: Bump version suffix to -cip15 after merge from stable
      can: rcar_canfd: Fix build error caused by is_gen4()
      arm64: defconfig: Enable Renesas RZ/G3S thermal driver
      arm64: dts: renesas: r9a08g045: Add TSU node
      arm64: dts: renesas: r9a08g045: Add OPP table
      thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/=
G3S SoC
      dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the TSU IP
      mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_cl=
ock()
      mmc: renesas_sdhi: Enable 64-bit polling mode
      mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
      net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
      arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
      clk: renesas: r9a09g056: Add clock and reset entries for WDT controll=
ers
      dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056) suppo=
rt
      arm64: dts: renesas: rzt2h-n2h-evk-common: Add pinctrl for SCI0 node
      arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add user LEDs
      arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add user LEDs
      arm64: dts: renesas: Add initial support for the RZ/N2H EVK
      arm64: dts: renesas: r9a09g087: Add pinctrl node
      arm64: dts: renesas: Add DTSI for R9A09G087M44 variant of RZ/N2H
      arm64: dts: renesas: Refactor RZ/T2H EVK device tree
      arm64: dts: renesas: Add initial SoC DTSI for the RZ/N2H SoC
      arm64: defconfig: Enable Renesas RZ/T2H serial SCI
      arm64: dts: renesas: r9a09g077: Add pinctrl node
      arm64: dts: renesas: Add initial support for the Renesas RZ/T2H eval =
board
      arm64: dts: renesas: Add initial support for the Renesas RZ/T2H SoC
      pinctrl: renesas: rzt2h: Add support for RZ/N2H
      pinctrl: renesas: Add support for RZ/T2H
      dt-bindings: pinctrl: renesas: Document RZ/T2H and RZ/N2H SoCs
      clk: renesas: Add CPG/MSSR support to RZ/N2H SoC
      clk: renesas: r9a09g077: Add PCLKL core clock
      clk: renesas: Add support for R9A09G077 SoC
      clk: renesas: Pass sub struct of cpg_mssr_priv to cpg_clk_register
      dt-bindings: clock: renesas,r9a09g077: Add PCLKL core clock ID
      dt-bindings: clock: renesas,cpg-mssr: Document RZ/N2H support
      dt-bindings: clock: renesas,cpg-mssr: Document RZ/T2H support
      soc: renesas: Add RZ/N2H (R9A09G087) config option
      soc: renesas: Add RZ/T2H (R9A09G077) config option
      dt-bindings: soc: renesas: Document RZ/T2H Evaluation Board part numb=
er
      dt-bindings: soc: renesas: Document RZ/N2H (R9A09G087) SoC
      dt-bindings: soc: renesas: Add Renesas RZ/T2H (R9A09G077) SoC
      dt-bindings: soc: renesas: Sort SoC entries based on part number
      serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in=
 sci_shutdown()
      serial: sh-sci: Add support for RZ/T2H SCI
      serial: sh-sci: Use private port ID
      serial: sh-sci: Introduced sci_of_data
      serial: sh-sci: Introduced function pointers
      serial: sh-sci: Fix a comment about SCIFA
      dt-bindings: serial: renesas,rsci: Document RZ/N2H support
      dt-bindings: serial: rsci: Update maintainer entry
      dt-bindings: serial: renesas,rsci: Add optional secondary clock input
      dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on RZ=
/V2N EVK
      arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
      clocksource/drivers/renesas-ostm: Unconditionally enable reprobe supp=
ort
      dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support
      clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM ins=
tances
      arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/=
V2N EVKs
      arm64: dts: renesas: Add initial device tree for RZ/V2N EVK
      arm64: dts: renesas: Add initial SoC DTSI for RZ/V2N
      clk: renesas: rzv2h: Add support for RZ/V2N SoC
      dt-bindings: clock: renesas: Document RZ/V2N SoC CPG
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2N support
      dt-bindings: serial: renesas: Document RZ/V2N SCIF
      soc: renesas: rz-sysc: Add SoC identification for RZ/V2N SoC
      dt-bindings: soc: renesas: Document SYS for RZ/V2N SoC
      soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
      dt-bindings: soc: renesas: Document Renesas RZ/V2N SoC variants and E=
VK
      arm64: dts: renesas: r9a09g057: Add DMAC nodes
      dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
      dmaengine: sh: rz-dmac: Allow for multiple DMACs
      irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
      dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs

Best regards,
  Nobuhiro



