Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F179CA0EED
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 03:45:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.818.1755834333451220000
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 20:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ScjiDPRX;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1755834312;x=1757043912;bh=X5BNBtZKIuBVjSyX/Bjbn+xysTjLyW66Vvf3Z
	AK6MPA=;b=ScjiDPRX7aOiIjxvbb7oth2vLiAkLJIGwyjr9bfa/XXU+S24HzYzpGiwfja816co68u
	XYWpiWmCtzOGubnhSH0CkgveYkWc+iJ2J/WLKMxKxOFInE0HzefpIR27GY/h/mzwmQvF3W0/x/4U/
	PyOi+7V19SwbMkRKc3PBLLCkL2HO74Ac2TQ1dTVXtqNFMBhNt7j4hRdaKKMTrmW8n4B1yKvqIEF0C
	P97WC9gpe5iwc3HeyEf2TUAPRuer+5sZfeTMWoYCxvN8ZAwbGtxcQoHum1Xdl1ips0CqAJbz4ymda
	nmS4YyIt8QRnD6WBbHmYh7V5SgQxTSNuwRK1bEUhMNBA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 57M3jC0o3690796; Fri, 22 Aug 2025 12:45:12 +0900
X-Iguazu-Qid: 2rWhyCKRA1jjvgnLOa
X-Iguazu-QSIG: v=2; s=0; t=1755834312; q=2rWhyCKRA1jjvgnLOa; m=77Dn9gDMM3PH0QvG+q7++t20xX4VLGtmcM4owE180p0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c7R0R3qH2z1xnZ; Fri, 22 Aug 2025 12:45:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRrcQSNg+R7vgD96one2rE69iNanRfYYIsh6hIon4FjEybEuzJPinrDFw4jolS7FfXPwhxldjfoZi7iCxflyakbMhGVSxlLzYlERJlOSdrF1ZV0QPyDXREaJgFltED6bveM57IfTbAd5e8s6azoFQs65A8pGHMQ3FIm41WT9uWoO64YsfSNIBNgF9rUQKSzalZBx4489kTTNwVHy+Euk0BlzTgRE0eQpt/kHVmcRt6Px2LatslbvW3r3mxlSdrfgAjlkKvPXr93cbNVirISXDeC0T6pLNTx2pCJ7BVHlAhis9qBcRh9wJkjk447HV912gQpDSJo+qhcyRokBXz34Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmkwIs63ZkKaFG9qrNrPtaZhitkc4+18pgiEdWTwdY0=;
 b=q3sSNkyoxiQfW9UbFiTsFQDw6/ycpMi51ayD3kAiKdfm+cLVtaNRYcMdSaqh3zQpaN5fet5VQH7MKLjuwzODnxaLWK/NQH5Wy8Byg/AV/tEkw5U7wm9l23htm22ZRZ0LXOS875J16kTJ35NbFX/7vFikgTRXaqna3yy0nO8SiNlI4YKMyDngNFdcmlqm94IPwscQIUGKY9rVagSNKZboA1XFlHiOmVs3B9MZjOiHhF9Lxj8O48luLNtntP8vwtVL4MNmZnlhQB7+PEqHrBQikt/IuPU+oXWnNwc1vBOjdbcxYZejwmq1v+qc0KUfNzggdSXQPJc+uq+flgG6/cEd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>, <uli@kernel.org>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEdpAOtOsp6RkJ0itXKZdfyV4dbRuCnQA
Date: Fri, 22 Aug 2025 03:45:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DA61316867E1E352884BCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB6927:EE_
x-ms-office365-filtering-correlation-id: f4744dba-4b11-4482-e844-08dde12e4a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SGh5RlpoZy9MRzRnSmg4RXRqTW84SW1SakJJSWlaOGJPZE1UTVNFYXhs?=
 =?iso-2022-jp?B?bU9WRmFXMG5jbXptSW5DSDJwR1JhL3BralZVV2h4OEtLbzNRQllOeG1k?=
 =?iso-2022-jp?B?MFMwaEhUc2JSSmE3aURVU1BjWjRKR3d1RUtOL2xFeERNZnJmUm8vOHlY?=
 =?iso-2022-jp?B?cWgvT1d5SlBIZWJ4MnVVRzY3em4vcnZkZ0Nnc1J2MHlUQ2w1aEk0WkEv?=
 =?iso-2022-jp?B?SlNkeHNFQXFIdWJXV3o4SFYzTWZqZXAxMS82em1VSzdWbExEcVRKUnpa?=
 =?iso-2022-jp?B?ak5MK2ZOemNuenNUQkZOUS9RZkFLNUFJUFh0Y0FmUDNwb3doYUJwanVQ?=
 =?iso-2022-jp?B?ODdlY0Y5L3c3YXg1WVRaY0ZCZU1Ha2xYcnN0bUI5Yk50U1BBRVp3N0ov?=
 =?iso-2022-jp?B?QkhjbXcxWlNhcTdlK0tqU3c2T1h5WnJ1ZEZMSnF1N1Q5RWxHMUl5OWo0?=
 =?iso-2022-jp?B?SnM1SENHRVFvcndOMWFTMCtMa2RBSHFTU3Y2M0RLR0JNSVEzckhEYTNQ?=
 =?iso-2022-jp?B?SGlVVERqay9HSFRQVG9JYVRXM1AyVmdNZ0xUNmhVVTAzcStBamtkcEEz?=
 =?iso-2022-jp?B?RjdkYit5WlBqSjAyWk13ZEFybWJPZHVMUFBYZExtNVBydFduUFpMTGxG?=
 =?iso-2022-jp?B?dkVlM3lZZjF5bkVHYVBJRjBrUVFiTk5rcGM3RER2L3JKelFRUHRWNEx5?=
 =?iso-2022-jp?B?djhGdmE1QmY3RXRJa0dnLzB6T2hsMnVuelRBNEV0V01aaWJOMDZpdWZw?=
 =?iso-2022-jp?B?NDN6cmxBcTBjRVNXelFFYnJOSXBwMlp5VWtZRmhkcWd6UGcxVzBVVk9p?=
 =?iso-2022-jp?B?Wm1qTHlUZ2o0cThORHZmR09xbDJvMVhpYTZjMFg3am80dXl5K2FmZ21Y?=
 =?iso-2022-jp?B?T3VSVGFOU0ZPR1NZd1lQS1JIZ3pEOC9GZ0lZaDhrczB2MWI3RVVPRDJs?=
 =?iso-2022-jp?B?YUp2YnBzazR1Q215cVV6c0dNQTBkQ2J3OXVRSm54R0lzM1N3NjdZanVx?=
 =?iso-2022-jp?B?T3Y5aDlrNXZUSlU3WklXZWFJckNOaXNiZjg1TWdpcDN4Mnp1SmVSMTFv?=
 =?iso-2022-jp?B?a0QyZktYNWQ1ZFNVSHYzcjk0SjRNZDNOVW9uODNIQXdLRmFia0VZaGR2?=
 =?iso-2022-jp?B?VlhOM1pPT0VYRjJMQW5xaFo5NDZ4S05jNmZiS21vUERLb01Xb2pHVEFz?=
 =?iso-2022-jp?B?SGp2anVmZEpBZWpGNFpkSzNMMXZkbW5zSnlSRVRxT2gwRndQN1NKWUpw?=
 =?iso-2022-jp?B?NFgyMGNSQW1PWnkvd3ErZm0xUGpva204LzlvNXpyeVErVHB4TSs0NjJZ?=
 =?iso-2022-jp?B?MDhnaEhzQjlKVWZyNGVWdWUyWjVwYXkreTVuTFkxQmo3dkgvdzJWR0dH?=
 =?iso-2022-jp?B?SGR3aHI3UnYxdFY5aS9uT3RPc0ttbmlrMmJKRDdJRTN4MDkwWTVyZGdH?=
 =?iso-2022-jp?B?RTNYOUd1amNaQkkrSmdWb2luZjVrVEJsb1plaTVxN2xhVTRFK29QVHJD?=
 =?iso-2022-jp?B?L3lQTzBOd1N4NXlSdWxYUy8zaGg4dmhvNTNmV1VMZ1Mra1Evc2E3SUgv?=
 =?iso-2022-jp?B?QnNkaUp4SzFIdERlampUZWhqR3BuY0V1UzFybHp1SG5PNy91MG9wa3dF?=
 =?iso-2022-jp?B?aVVVL25JaU5EZlZYRDcwVXVURkpSM0NZRFlLczJSdU9iMFdsQ2phYWRZ?=
 =?iso-2022-jp?B?L3QyWUhySGsyUXRhMjNFNERweDVyZDd0aVpuZDF6RjAveGo4NC9sSjVZ?=
 =?iso-2022-jp?B?UEJxQnpSbjJLcUZvNUxWeFd3L3lKRTJKN3FVU0E5bmVkdnBDcisvUGtF?=
 =?iso-2022-jp?B?NDZiU2pFcWNiKzF1NTEvTXc0VWtRVzU5ZXk3UmM1NDBPWTF6aW1tYVJP?=
 =?iso-2022-jp?B?VnFSdWhieFFIUUV4dS9odHFlNmdpSkkwZUcwYjhoaWtXby9ldUdrcGF6?=
 =?iso-2022-jp?B?UmtNc3RiTTVuOEw3M2JobmVwdkhETmJ5LzZOUjJxRHp4LzZUdDlXRUpJ?=
 =?iso-2022-jp?B?KzlmbC90Vld4aFo2cDY2Rk5WQTNxc0ovdk83L2Rub1YrNStOdzlLRCtT?=
 =?iso-2022-jp?B?WDEyTy9jT3laTjhoNmNUaUFYUVpPbFl3L2R2VWZBOUhYejVsSzhhUmhJ?=
 =?iso-2022-jp?B?OXowanRnRWRBUElCL0svVnlrdEJOTlRkelRWMkRvYTV1MnlHdkpHNmht?=
 =?iso-2022-jp?B?UXZrPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M0Zld0N4bTh2UXlsdXl1UXVNZFB0S05md2NXdzNONXkzREwvZUVYKzQx?=
 =?iso-2022-jp?B?bVJwVS9mNFl3bk9BU1ROQU1DeTJlRmhZUkl4YUszSkcyT1RXd1E3TFNC?=
 =?iso-2022-jp?B?eXNKMUwvc3FxdGNIWmdCTkxCS1ZkMTk5TFlXRkZQenVScjJBcy8yUCs0?=
 =?iso-2022-jp?B?R0hOWFpEZWVGUnYvWE1BUnJLTGJxNkVoU05FaXdldGtPSThjb2VoMzZE?=
 =?iso-2022-jp?B?VlRLV1FXQU14b0kxUXZTSnBHV0hWQ01RUzhqa29LYmk0YXA4SWdXWnNT?=
 =?iso-2022-jp?B?ZFNydXk1UEdJZDVpa0g2dWNhd1pndTZqdGgrM29sNWo3T2N0QWxXaHVz?=
 =?iso-2022-jp?B?N2JIbWloVXRGbzBhRWloeXlvbThud1Y2T1kvRHdiVUE5VzdGenJwRks0?=
 =?iso-2022-jp?B?RWllbFJhUlJXZXFlYXRHa2ttenZGdFFFUE9qZEdrWnFscGljVVRHbDBT?=
 =?iso-2022-jp?B?NmpIWU9iR3Z3MUhsZDgvaEU0QW5DdW1UN0doSzVHcWNQOURoeWlnbHV4?=
 =?iso-2022-jp?B?RnFMd3VNSndZSG5vQUMxYXBGWSsrd014V3p5UTZ5Qml2YUw4WVZMc3p0?=
 =?iso-2022-jp?B?RnFyTm5UMkNhM3dYcld0NTVTODExdkthOGEvdXBWTDczTWhGb0pxdXg3?=
 =?iso-2022-jp?B?R1NkaldPRmRDREhRSHBsM09reXlRQUEzWEswRXNuQUhYRUx5VldXeGlE?=
 =?iso-2022-jp?B?aGFmTlJqa3JWVk5WdG9QQlFvZitXcXdtYzRIQjVSVVZKN2g2WmE4V1Nh?=
 =?iso-2022-jp?B?K2xSSkRpcDdLOTRISHJsaEZacGIwUHhKQjcyRTQ2dllCVk5JNnY0OUJS?=
 =?iso-2022-jp?B?SWxXbjhlTW80ZVNRRGVkSyszSDljQXAyWVlwYjJiQVMzQ3VYY1E1SjVt?=
 =?iso-2022-jp?B?ZTFmeHZnVjN1YSsxQ3hMUkpSV0NSQ1l2cU5uc1lWVlpjenQ1aW90TER0?=
 =?iso-2022-jp?B?K3psWE5TeWo0NkQzY1ZZODBqQm5NV1pSUmloTG9sVzZFT2NGT2w4cnZw?=
 =?iso-2022-jp?B?cGRMLzcvQ1lwZS9Hb05FakJ1TGNpUVFnNjBaTXN5bXppaGk2cXpiMGMz?=
 =?iso-2022-jp?B?R0RPSVZZMk5SNEVvbVZRcmpSeE16aHluYkplODF3c0tCdytPR1FSUnoy?=
 =?iso-2022-jp?B?ZkZ2Ym5GWWFQSUJwakxkR3ROQWRlMDlGeXVmbzQ4OVNHT1AzQ3dsQzU4?=
 =?iso-2022-jp?B?TS9VVEw2Q09iQWpGRGttWjBjZlViYUk1c2IzN2ZQOGZWVmorY1VZVmFZ?=
 =?iso-2022-jp?B?N2hYQVJWWUhpVzlEWXFTbGFtQ1hhc3Q0RGJGZStNRnlvT2JSMzlpSytM?=
 =?iso-2022-jp?B?eFNSS0dOWXVDN1VkeGJQdEhQd2hHREJKTUNUS0xzMGt0MVhpdmY4cWt4?=
 =?iso-2022-jp?B?VVRBNDNBTDBpYVdOa3gvY3dYcWFyQ014K3NCVmZUSHRtU25jdlZpbjlC?=
 =?iso-2022-jp?B?SGRlMmJlQUJIQUdSRjNWZTkyd29NYmRlTGtlR2ZnMHVWMTU0OU5MNWc3?=
 =?iso-2022-jp?B?aU5rdHUzRW1RakZEVnJIOTlhZDRwMmZ4WlVuRjlxNnlyeS9CT1Y3NGdJ?=
 =?iso-2022-jp?B?VVBrSG9oalY1R1Rlbk0wbWViSEZuZjZvT1Z6S3JSRzBUYXgreE1UYlpC?=
 =?iso-2022-jp?B?a1lnZ3RxTXQ3OHdVQmF6QVNQR1hvMVJ4OHJ3M3hKTzA3d2R2NGFRR2p2?=
 =?iso-2022-jp?B?UFlXL2lJMytXZENUWEZMM2s3WXdOV2VHSUNwaTRQQVYxRG8yZUI2SW12?=
 =?iso-2022-jp?B?V2Z4MGtPVEFJc2g3NFNWMFBScGQ3NTVYWUh5bG9zVGdDT1c4UFlUbDht?=
 =?iso-2022-jp?B?L0xCN2wxUWUvd0Z2bHF0RnNWM1ZCWVlCRThLOVphK3FCaEVhWXVLT1dz?=
 =?iso-2022-jp?B?YnVaMlpLeURER0pYUzJNcjQ4bFQ2SWFWMlhTQnV3b20rM3RQNmVFMGNW?=
 =?iso-2022-jp?B?M0FrVE1ZYXJZZkNCVE5MYytMdjU1clU2UUlUalVYb1B6d0tJaEttU3Ry?=
 =?iso-2022-jp?B?T3lSeVFRQnFFQkVvTktiUkF3SnZ2OERjWWtYWk95YVRrUnd2eFowYWZw?=
 =?iso-2022-jp?B?c0tyOXBZVkczVTlVYlMrdFZCY3NTS2x0NFllTHluMGtNYUJ4YjZtZklD?=
 =?iso-2022-jp?B?RU44L2VVQXdBNURrSkwvS1lVQ040RDgzYkR4REhvcDV2dDN6Ynp0aVRY?=
 =?iso-2022-jp?B?Z0hPbjdKZlllRlhJcXhJRTdyMHFjekNyMDRDNlJnSkM5VGJqY2NNSFZD?=
 =?iso-2022-jp?B?OGNTcmgzcEJHZnRyRmQ3QnFTMEJHU05tdjQ2OEJjazhBL2xWUnkxdUZ4?=
 =?iso-2022-jp?B?UUs3RUNQU093eW11clNNWHhPc2pvS2NxVVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4744dba-4b11-4482-e844-08dde12e4a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 03:45:08.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkO5DAnG2UhEw0Dy4uTMe5A9T6Q+8Mx2SPP0W+JQC2l8OYjYpGV8zxEm2GXAMXgnhd0+SwqCHKgxd0suLIyEo/EyPXUkGX7ZL8NFL2VFpu75Rp6uygjSxRg8pnc6QJrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6927
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 03:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19940


Hi Lad Prabhakar,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Wednesday, August 20, 2025 10:56 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>; Ulrich Hecht <uli@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
>=20
> When performing continuous unbind/bind operations on the USB drivers
> available on the Renesas RZ/G2L SoC, a kernel crash with the message
> "Unable to handle kernel NULL pointer dereference at virtual address"
> may occur. This issue points to the usbhsc_notify_hotplug() function.
>=20
> Flush the delayed work to avoid its execution when driver resources are
> unavailable.
>=20
> Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of
> work_struct")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link:
> https://lore.kernel.org/r/20250225110248.870417-4-claudiu.beznea.uj@bp.re
> nesas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [PL: manually applied the changes]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


