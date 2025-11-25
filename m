Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3DD0E6CC
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:05:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15256.1764072310693979714
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:05:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=r9Ez/pc8;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1764072287;x=1765281887;bh=M4CkPBf/5DuDMwsjCPcfDvty131pFDFWu2qzM
	BhYcTw=;b=r9Ez/pc8sRRHMpKSa5cw+kobY1DztgmrgBsqtZnjQUVJlAqGbDrqtZLv1vaq7kbG62u
	VsMl4RtS6wj7E6R8ABYVzJ11KHrVskP4FISn+oOLg3NByr2q6khsNxnDKK0lRtK3KgL+zgnrojSNt
	wNqvDCDf1uIdbgpYLLtacejk0BvAYV7dkUoq6Kgp8Kn6rkcSVgma/Ruup40yn9y0/t3mxYw7E3O80
	A+bpm0wBbuWj29dCi5JQAl1XY45bVxpL7U1oHQ9CT4+RW4vs8RlJyCaOegxrYhGyqdMrnyrRnU8Jn
	Gk+FQ83iYe4LzRaLUjKzJ1SY5AktkYDN+SNwBGt+2mSA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5APC4kBk3811425; Tue, 25 Nov 2025 21:04:46 +0900
X-Iguazu-Qid: 2yAaGFzRZwv6viAT9E
X-Iguazu-QSIG: v=2; s=0; t=1764072286; q=2yAaGFzRZwv6viAT9E; m=/2tZFPVVQoACWTghJ5C798cNpmWMWxc59vWgA/g4+3c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dG1b20hG9zyPQ; Tue, 25 Nov 2025 21:04:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0oKyh6XyRZN7ntW9/sOisPZ9AsACanCu5wteeZhtQ99FuRHh0137fJyBFsw0A9ZuY+wDA1f9TkkSv/XvmJ4qmfwQYh3+hF4kF6S08MoA5Oqm/WTaQmC9YodcE8J4EJuRPuRvlFbJaWgBBegQ7kH/TKgMn/OGbQQlv2PaxqNWWrXZgPqlIuB1n+1/lJHdHPR0HVnaGc7gowbJHCEEq63lmvfqn4KMeMRT1bR2wUduRrDvgCxRVwDJaam7hppZR3nzwV+wPuoLDlwdPcROZu9DuFOUqCKciDW5dS0S/rEWx92kSTgW13z7BZv6WeFiDAGV44n4+cmMpvEdRPxeYVLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRfW6nAY/CiOMMoXlhekRsZGrPhF/kOMEZL/ndvp8q0=;
 b=oK1FIJI6np8ihefEbLyoDHtBkzJ7HAkO+VOYlANsLRtVrpAvUs43vpiFUHKO0c2ILBazFSXRdvJhOT9n6wiNUKKwAMU2/T+tNMQxNlGmK+aM8wYQ+Uf7gXWLJT43mGMJPWmwcr0ImMd9FY17FcWO8VB6uD1bxEZ3hrBtwv5MyTRZUxE4kamHvZOQ3cUu2nZrJh8xPcBKzey+aCLGKdiAyDeP0ymxf1sFkss7tSp3Vbf6oR3YXydfqNj3lXM9Er5bzOuKmApg2iD09xMNXVaEn3FqeyNWc95zDELy7gF00lTCxpfqo3XIv+X55QuKx/a1ujlpkTusqa3xu3Ss54xNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.4-st70, 4.4-cip105
Thread-Topic: Request for review for 4.4-st70, 4.4-cip105
Thread-Index: AQHcWhvf+/FOzJa59EWmioimDK4557UDTiSQ
Date: Tue, 25 Nov 2025 12:04:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185625E58896E61DB442F4CDD1A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <88055065.32862.1763642846447@webmail.strato.de>
In-Reply-To: <88055065.32862.1763642846447@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9849:EE_
x-ms-office365-filtering-correlation-id: 561215e4-41d4-440f-2aea-08de2c1ad169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NzRkMDJLaWM0c3pKK0N4VTBiU1RJR1NMc2xkZmFWMmI5N1NJek5YRHl3?=
 =?iso-2022-jp?B?eWNZK3ZHQlk0d3VjMFlnN1UrZlY3dlJHTWNEVTlsaE5PMWd3QnlrRGM3?=
 =?iso-2022-jp?B?OGJmSmpkQVZ1WjlKQThOUjVnOCtTQ0dVMzhjeHVpVEI5RnFtNEIzeGRD?=
 =?iso-2022-jp?B?aVRQaUNXNFlsOHpGWmFhYm1yQ2JmeU5LUFUrVGo5SkU0emtvTDBjbGNH?=
 =?iso-2022-jp?B?Y01ic3BhM0pCcFYzbjZJaFNLZlhSS243TXVuWG1Id2FLRG9kUVFCZStS?=
 =?iso-2022-jp?B?dlBPSFc5M3oza1FReEtXVzBlK2hPTEdXc2xTMXNSVnUvZnErbDFEOWdj?=
 =?iso-2022-jp?B?OGlYbVJyZFU0WFJmUTl1RElFYmpQNCs1THY1c2xqMXFkdlVqczV0cHR3?=
 =?iso-2022-jp?B?WVAyYVRtOU95QXk1aDZ2eHlaSmRXL1E0aWxsckJOQThURkxwdFdnckh4?=
 =?iso-2022-jp?B?QmxLU3F0akpCeHVadForOW1ja1lqNGg3Skw4cFJTOGdKbml6MGhLQ1B4?=
 =?iso-2022-jp?B?MVh2OXpJNnBmV3gxZy95M1RoVUFTMzBWM3N2emFYYWZVZlh1NkFaa3dX?=
 =?iso-2022-jp?B?Q1l3YTU4NEdhZEtab2lUQzA5T3N2Qm9aZ0dTRzFxMVlkYmxGejFvNksr?=
 =?iso-2022-jp?B?Q29sUXh4ZU54a1kwTFNFc1FNQUJIdGFod1VBMm9wY0tRTXo1L1hQYk5q?=
 =?iso-2022-jp?B?am1ENFF0dTgrTWtsMjI5OVF1cndMdThmam8xRmc3QUJlNElkR25VNENm?=
 =?iso-2022-jp?B?MVJWaEc1UnVkRWt5NkRZSVNWUDNJTTVQRXdhV3Zvb1pxc0lzcFN6NFBm?=
 =?iso-2022-jp?B?RHhudnQ0K1pUWUVjeVk2ZWtCdXU1eFdZS2s5UEpHZGR6NTJnandvTkkv?=
 =?iso-2022-jp?B?NDJLcHZMSlRZUlIzeTZrdWZKMVNGc0U2RENBUFRiMjdsTWhYNDhDdE9y?=
 =?iso-2022-jp?B?eVFkSEhjcEx0cHI3cFlUTUR2ekg0Rmh2TFBTZmh2RDRLYzlVL3hHcnBU?=
 =?iso-2022-jp?B?c2p4dnJJQmZRVXl1TGNwdmQrYktaaEwrQUppVk9HNG5LbEt1ZXNJZlh3?=
 =?iso-2022-jp?B?T05TdGI3K1NkbzNJRkVGeVNEUjYxbnpmUkxxOEU4eXY4bm1zUWV2Y2JV?=
 =?iso-2022-jp?B?VDJ6dHB0SUFWdU1kaDZvL2N2UWFzMklkaG5ZMEF1ZkFCZk81TGh3UzF4?=
 =?iso-2022-jp?B?c1VjaWtVSWRxS2NUQUFhYytsYWprM0hOY29vV2FNQzgrMEJqeE5icDRu?=
 =?iso-2022-jp?B?WTBOVWVYSHdFVVY2WkJWWFNkUVFwMFUxR242Q3ZkZjM5WU1UMjlDQmdh?=
 =?iso-2022-jp?B?d3hmUzNIdlo5bmRiNXFaeHpEaWg2eVhHMnB0eElQam4zRWJTUm9XaUpD?=
 =?iso-2022-jp?B?N2FwMFdwOXlLL1VnTXVUMnR2blpwd3o2OEVnYkNTWHVkaVIwVWlEM09a?=
 =?iso-2022-jp?B?NWN0VUVxMC9vTW9IUEVpSzZoWFM3ODVhQS9CMUR2OGROcFFBWXhSZ2d1?=
 =?iso-2022-jp?B?THRpbWlVMkdnQWdkSzdMV2R0N1B5UGJ3NFFNNVMyWDNKam9QbytzbUwv?=
 =?iso-2022-jp?B?N2lxRzBrV0t5UzV2TCtYZmoyQThHaXhzb3AxRVZUYmVxYWtOL3lrV0xQ?=
 =?iso-2022-jp?B?bVl3Mi95aWR0Wmx6RHZtYmN0dWIydldvWGVETFR5VVk4SGxoNXhlU2VU?=
 =?iso-2022-jp?B?TysvemV4dWVPMjdoekFZVWUxdnhjTzVSRXduTmhxaUVRenBtaU9ja1dH?=
 =?iso-2022-jp?B?ODVNQUhNVzlRc1FQaCthWHU5dmNHdjlFa0dyclN3MENHSWUyaVUwZGZO?=
 =?iso-2022-jp?B?c0NMOXM3NVdXamdTa0ZHd0FKV3Rzc2ZEcytxMWRTU1hEMC9nQldzVVFV?=
 =?iso-2022-jp?B?YjFqbnpNVCt0UDBrdVRGWSswQ256YTVuNmc0ZkI0VGprMDZldU5yRlNH?=
 =?iso-2022-jp?B?SENmUEluZWQ1UnhHU1BBNGJ2TVlOY2JVZUhJTDlkejI3M1RRZW9ySkxy?=
 =?iso-2022-jp?B?dXBqZXp5MGIvTThKYmVIejErWFZ3a1V2eityY2hYNW1TN0NFY0RhdFB5?=
 =?iso-2022-jp?B?dXdJUDhveWptTkFCYk9NcmdSV3RkbzR0SGhNcG8vUjlzSlIwcURRQ2Vr?=
 =?iso-2022-jp?B?TDNlSURyQjFGOXlOU2JDTklPaWFEcjg0ajdPRjY4SlkwQVBMakw1TUxY?=
 =?iso-2022-jp?B?THFhdGRCWjIvbFJDSElLWjJVT1Ayc0Ri?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U3FuUjBwMVEvRUVQSUR0K0N0ejM2OFk0QW1KdzJVUVY3Z05MTStnK3la?=
 =?iso-2022-jp?B?RVF2L1hrOG9LQkFZVDV1SW5XMWswbVhBTCs5ajA0ZXRFa0FQRUJUcWpx?=
 =?iso-2022-jp?B?QjNSdFozcnhQQ01pbnh2My82TzJmQjVWOWdsODI1M051WG9UZWJDNENj?=
 =?iso-2022-jp?B?RjFPallPcWIzMFhIblFlUEhtZ1QzOGM4WmRSbDNuN0VMcHBMRzVZSW5w?=
 =?iso-2022-jp?B?ZCt4dGZ3SXFLNFhUb2x0VmovejNNcU0zWitNQjZMVDVERUNRYisyZDYx?=
 =?iso-2022-jp?B?UlBJbzBUcWpMbVhQNjVuWU1kNUlua0dQdHY4R01leWl0azcwSWg5QXFF?=
 =?iso-2022-jp?B?aXNkRlBJM3czTVpyRXc5Z01Wd1FKeG84VjlCSDllajl6MVA0ZUJRejMx?=
 =?iso-2022-jp?B?N1dyR205SDFLbUh0ZVRxRTU0N20yTGc0aDJpUEFac3VQc05BbndKR3Mr?=
 =?iso-2022-jp?B?T1RrakMxd2lHd1laS09OdWt2UVR1VjVMWGp6VnZrNkZIUDMwd0ZKLytr?=
 =?iso-2022-jp?B?K1pTR1phNTZlczRHYjgyRVk0eDROdG5Ic1JiaDNRSExQdGU5YitwK1dx?=
 =?iso-2022-jp?B?MmZ4cnU2Nnl2czQ4eDdBbEJPaXdYL0NENHd6dXV5bWpkUFcwWUY3cVJS?=
 =?iso-2022-jp?B?SWJhczhNT05ldFB2VVJRQUp4ZFZ2dDZ3djUrU29CVnZLY0hFQ3A5SUoz?=
 =?iso-2022-jp?B?bXhHR2l3SjUyY3F2UUJTTFRTMXR5SzVLOGtGZ2hRYk9BZFR4c2JoQW93?=
 =?iso-2022-jp?B?Qmt5UjE0TloxZDVrNkJMSEZmWDV5SHl2NkdXRGJYaW9uS0kxckI0YVhW?=
 =?iso-2022-jp?B?RFJ4bmQwUjBZdjhZdzU0bVQwV0FYNDZkV2FzV1V6RFg0aHpjRDAzTFJu?=
 =?iso-2022-jp?B?UzdnTlNvU1EzQm55Rkh1QjRIbGhvakM3WDZtQ2EyT05VTThmQTlOODBE?=
 =?iso-2022-jp?B?eG04RDFlaDgxUnpZcDFZSXFCUWo3Y0c5VGdjREpubUppMW5XS05kdzZX?=
 =?iso-2022-jp?B?Yjh3WVQvOUk5NjZ6SUxjTnA0ZDAvLzIwV2l0RExXVGZKUlJSanNSZEhv?=
 =?iso-2022-jp?B?b3U2RzV0VW8rNFpidGJjY09xdnVmRENXL1psdnNBRHdCSGFXazEremJE?=
 =?iso-2022-jp?B?amRPd1ViR1dnai9pZ1ZjYWdiYVh5S0hFaXptaFQvMnhJTU4xZFFaZ0xz?=
 =?iso-2022-jp?B?NFNKdnBlN0t6b3c3L0ZacXFyaW13TW80N0lKWlJ6Sm52OGVBZ0dXdG9o?=
 =?iso-2022-jp?B?bEFKZmVGS3NzRnQrWStDZTM0YndrcCtYYitmR0JNTDlER1d1YlBnU1R3?=
 =?iso-2022-jp?B?bkdOS0RVWktwanBiSThqVVhwZVA0THU4YXIzSyt0aGd2aWFjSnZIT2s3?=
 =?iso-2022-jp?B?K3ZjY1YzQUxKNFNSTHVVL1kxZ05OZDd1UnVFdUtnTlhETWt1b1BNeUtX?=
 =?iso-2022-jp?B?QjYrL05xbkNqOVdObWs3MlZUNGlQak9Mb1A3QVpVK3VOZXUxTUNoMHQy?=
 =?iso-2022-jp?B?c09CRkFRUGlmRWJzSzVwOUg0ZWtlWUYzdHJxZlBIY1BKUFN1S3I5UkRH?=
 =?iso-2022-jp?B?eEgzbnFkWXdJTjg1NEk3RDJyRG9WQlhNanQ4dUVzUGJES0N0T0hMdXRW?=
 =?iso-2022-jp?B?cDhmY2l5THVya2FWSXYxSUEzeGllOHZPeWM3RUFLWnVTeWVVQjBRWG04?=
 =?iso-2022-jp?B?c2VnckIwRVZ2NmRjYnJYbm9EUDlKWUNsL0J5MUNPWTZYY0VBNmV4VzFY?=
 =?iso-2022-jp?B?ZXA0cDJOdkh6RmpkZXRBZXYvWUJrb1NGelBjR1g0cERDbnNzOVFUNmFl?=
 =?iso-2022-jp?B?bUY4OG9PLzRabmR4OVBWTkZoTnFHM2FEWUgrbExtTHZvc1M4SGZQUGdu?=
 =?iso-2022-jp?B?a0FJOVAwMzVWanZpZSsvNUtjM3JPZEQ0S2JEOVJNU083WnloTXNUU1Zz?=
 =?iso-2022-jp?B?YzUwcENCTUN4Q0NLVGxHUlh6WFJ5Y1YybWFqeTczV0Q2alFhdnc0R0p4?=
 =?iso-2022-jp?B?NWVmYXVlZE9BYi9WKzFlTnhmcFFyRFBhd0ZRWnZrUi9vN05neTdFd1FH?=
 =?iso-2022-jp?B?S25naW5ZTE90VFUwdDRmK1I4SjkrZ2JERmRTZUdmWXVLQjQ3R0N1ZUcw?=
 =?iso-2022-jp?B?WWtYNnNpTEs4OXJvNkwxcEJpU0FWNGovblFxOS9QVjVkZ25TazN1UERy?=
 =?iso-2022-jp?B?VFc4ME1tRm5xOVpaMFQrZWZ4cXAwalo4OFR1aWJCM2lINjV2S1FVdUFu?=
 =?iso-2022-jp?B?NktTL3FIQnY5WHM5NDdSUDlNbmJ4MlVjV1JEcEJlOGt2MlBpWjl2MHpG?=
 =?iso-2022-jp?B?YXZuTmlzM0hpUU9hMm5RcnRTeDFVd3lZTWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561215e4-41d4-440f-2aea-08de2c1ad169
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 12:04:42.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xhgjqq66Q1MYH2TjE9pG2lK0gGvZW3OYTT3ivRhaaHFZYK32n+WC7lHIhSEY+fYz10eShaVVXccksLIyiKbaL+v8Mb0rMwWHj7OBwOjyclN2aWl3W7us3+sxvMVgVio0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20724

Hi,

Thanks for your update.

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Thursday, November 20, 2025 9:47 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: Request for review for 4.4-st70, 4.4-cip105
>=20
> Hi!
>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays
> they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-st-rc
>=20
> 54c5af41f0647 net: ravb: Ensure memory write completes before ringing TX
> doorbell
> 697d8a82e0984 tracing: Fix race condition in kprobe initialization causin=
g
> NULL pointer dereference 21116d340963b KEYS: trusted_tpm1: Compare
> HMAC values in constant time
> b804b894ade38 mfd: vexpress-sysreg: Check the return value of
> devm_gpiochip_add_data()
> 319a1a1ce7366 KVM: x86: Don't (re)check L1 intercepts when completing
> userspace I/O 5e4cb116f19af rtc: interface: Fix long-standing race when
> setting alarm
> 8c9a884e8adf5 pwm: tiehrpwm: Fix corner case in clock divisor calculation
> 0894b95293ccd media: tuner: xc5000: Fix use-after-free in xc5000_release
> 9d5dd367ddc15 ext4: increase i_disksize to offset + len in
> ext4_update_disksize_before_punch()
>=20

I reviewed this update, looks good to me.
And I built with allmodconfig, allnoconfig, allyesconfig and defconfig, the=
se was no issues.

> Thanks for having a look!
>=20
> CU
> Uli

Best regards,
  Nobuhiro


