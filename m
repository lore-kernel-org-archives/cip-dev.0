Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7AFD41C1D
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 10:42:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6599.1765449761050815544
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Dec 2025 02:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ceUXyVgG;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1765449757;x=1766659357;bh=qktBzxz2wJtxcDrjJ9Mx2wIzotODbeetpE/DE
	wLsKy0=;b=ceUXyVgGtKr/Y0XpTIt/vA8iSc9KmZMrGEwgAhjNqDcdeOv344GkBiG7F1ExXjJRUcW
	t6Qu0T2JKGRLSikdR/Aggg3g5qm2sL7li41HTNenVGJkXEM4BEv4u2a8t35ptX/NSw8i/C572p9Rl
	03n/K6ACrE2Zb9vkqIVhBfSSsim2ZrdJorl+F68SIt78F1Bgw+Mw2cT72CA2TuDgfFlIJjQFq0D5R
	bUq5P7WUDkIYFJK3vcepxw6b2jFNyVB6wbt8T0PwrqyWsIrrh90au78yFE7aRcCXHF3HpMFRhBHWT
	eMoMJsnzK6Y+2Uepar3oEdfsJcGgqxM2ixDlZSPT5LzA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5BBAgbIe4115742; Thu, 11 Dec 2025 19:42:37 +0900
X-Iguazu-Qid: 2yAazhAVNrg09B7veK
X-Iguazu-QSIG: v=2; s=0; t=1765449757; q=2yAazhAVNrg09B7veK; m=vJ5DELZF/m4f2PczbMxZZcFrrL7g1iEWKseFFAGS5zU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dRq0r6J1gzyPZ; Thu, 11 Dec 2025 19:42:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3eCDIvivJNXjf4OeJikup4W0wKxmaZViBBRbj5S3USofhoSaqNDtsZ8G/I3DG82Smd8IIja12t1biFCXFpo6S4GGnOaa9cOkpWLq7b9vTpVZVZkB9hXvxyN8PSoCyisPPBqQWvUS4Fn6eKscZTJ0QjnQdlv048PjK+9dGbK0+3P5s5oiqy1F38rJy2IiWn/E4Yhd20lzm73w+PlW6eK+LnkeZKiaflstg6dgl0uKKoP4rCz+be5P6+qSLzEeMV4V5a+NncO51tSOrkfQXKZ836Zfs3x6ZAcZz5TfvW2FA4nEdsAiVvNf9sBDys/l5jOJ/7+M/ySJVoN2uSuTBLLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qktBzxz2wJtxcDrjJ9Mx2wIzotODbeetpE/DEwLsKy0=;
 b=O5ZLydLTMwjTSXwIaNFdirXsL5feV6XTUGxd9cjSeDuIn2R3DMYoE0gv2cybReKzs/O4GNEgSGx++zpnTG7v9ooKNgdOYyLOHo+oxM3cD/R07Xzx5J/Khn6TBdQQs35Ejoqbu+3rV3701+0ntKc3Omyt6qHZB5kkn0zxyEF+ASJYrNB1SQQxnDI0+G5YH8/hn0ERcYV0mfyEmjxEeQguYHtM451SjE6YSWkuZXKKo2KuZMyC0tFbL4Cs6gFz+MPTJ176hLD7zqNgF4fWw9L327Qd9XqrnyAIDy8UOXEjQ4ziFZowhjkTuWPc0k9LKpq4T9dgmiVSrlFkFNkbPor0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcamMPMM5tPMIzfkyPV44DPXJM07Ub8Y4AgABN4XA=
Date: Thu, 11 Dec 2025 10:42:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB148081ECA8ED0EEA7BCC0526BCDA1A@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <77cca9d7-bc24-459a-9694-0d522d3ef90a@siemens.com>
 <6273c86f-b6e3-4709-bb88-66398b4a6df3@siemens.com>
In-Reply-To: <6273c86f-b6e3-4709-bb88-66398b4a6df3@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYRPR01MB13324:EE_
x-ms-office365-filtering-correlation-id: ef0467fc-b26d-413b-2e74-08de38a1fe44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QTFpc1dMMXArVnNjUDhwL0tKb1VMTnNwS0JvY3JsTkRqL1RSWTZHdVg5K3NW?=
 =?utf-8?B?T01wTUtEc1lVelNUeHVBYjByK1hISlUzVlNwZnZqQlcyOGJ1azRDVDhTdGdJ?=
 =?utf-8?B?SU1QK011SnIvZkRZZWlndGNQbHlnNkcyMkdxTkxJdjZoMmE5ekdxYUpQcEs5?=
 =?utf-8?B?WU9oa0ZQVm9GeUszOSs3WmRHWStRd2JvNFB2NVJBSFNEaTF6d1phSVo3Z3No?=
 =?utf-8?B?djB4ZCttNmNiVlJYUEJweE54a2xzaC8xS3Z5Q1FPZDZoVVk1bHkrSUZ3RXhq?=
 =?utf-8?B?cTJRMlRGMmFpMHhGRWVheEI5S1FjWWdMbWttLyt5K0c5TS92NlFDUGlBWDBy?=
 =?utf-8?B?QytmaWdrU0xnRVRYbGlPM1l1Rld0czFqMTllYjErMG5sTGtWNlNrdlBhY0FO?=
 =?utf-8?B?WGU4dk15RG9LUU8xdmlMU3J3SHdpUlVSQ1BkZEhHZmlObGJKdHpTdGdlbElu?=
 =?utf-8?B?c1E2KzRseUgwb1FxU2Qzc0pNTXcxd3hhbXk5NXp5ckNCcmphK3dZODR2QjZ1?=
 =?utf-8?B?VVBzaEYxTm0vSCtDcUxjajhkcEJoYU5jUVQ4KzBlbWpUQVdpMkJLdjBYUkdR?=
 =?utf-8?B?WU1UNFhCQ3JRRmxORllJK1p4SDdaTFJzaXREQlViMFc3aEdmSlZjaEpGZkN1?=
 =?utf-8?B?d1UxTVZaZkU1a1pQQ041a2JUekxhMmNJdDdvaDREeEw0Nkh6ei9LMUxKNU80?=
 =?utf-8?B?a0V1QXlMb2pBNS9hQkxOM1dWTlViaHlGYmc0QUk5ajU1Q2JvMWN2Zm8rS3Fj?=
 =?utf-8?B?bXdQM0ZCK3o0WHdCVWQ1d3dpTEQ4YVVvdmVZMENNNFhLdVRFL2hXaTZUb0ty?=
 =?utf-8?B?TEpmSHJvUmRaUjN1MmhpdmEvUkNRa3lsQjVEdk9TSUdOTTNsNmJnUEwvWTk1?=
 =?utf-8?B?Sm1HOEZGa2xiMWNIT2VLOElvREFucTFhWHBpbFcrQlFqOGlnODJsV1BHNVF0?=
 =?utf-8?B?UDR4andYYlY0bVZ2RUU3MHlxSnJ3aGhKd0tUTklwVkVSWVE5N2ZQdEV6Zm95?=
 =?utf-8?B?d3hsQ1JVaks3cFNpSWV6Sm9qMVNKcElrRGlFanhCT3A5NU9FaGFWUTZXc1pE?=
 =?utf-8?B?S3VFVGJSTG9QSWRydXdRM2FXRFZxTzJoOU5jRlNpeHpCUlR2bC8xdkNnQnBk?=
 =?utf-8?B?aGNYaE1pcGhUSk5lY0JxdG5hWk44T2M3UHA3OVFLSzBZeWx2eUZBc0lZMmRM?=
 =?utf-8?B?ZFpIWFNOaTdpR3VyTUZVZVhKei9qdEhWaEN1bG9ZS1A0cml6NytOYktaZTEx?=
 =?utf-8?B?aHJvN1JldWdFNFcvYWwwSlJWa0Z3R25aaGlpVzRPU1NqTDRBc0xVVFMyUFRL?=
 =?utf-8?B?amZ3L2JZb0tRL0dudGxMYktZZEZjd0hvMnhvN1VQVlVtaUVmc1F6NXMwL0JB?=
 =?utf-8?B?d3lFN0xmMzZzaGt0Y0VBcEpNc0VrbEErM0dFUGtsak04YkxZRURHSzZsTkU4?=
 =?utf-8?B?dlhEUzJ3WW5JR1ArblY0MzI0SEJKa29TN21JRHJ3UVZFZkhURVdGZWhYME5F?=
 =?utf-8?B?a2hwRmdBMk1NcXJyd242djdZa2lCVU9VckkzZGJWalRGRzltT3JJREF2S05C?=
 =?utf-8?B?OFQvMTdWUHBBSTBLeFJPSE9vWE9rTExnNTVIY0ZFb001WURCYVZSNW9pMnhW?=
 =?utf-8?B?QzdxcUJwcXk1L0k3dnhlRGE4R1BiRGkxV01QSnR3RWV1bzc4LzhiN3FLMHRK?=
 =?utf-8?B?RlFycjJBL0xjMDUyQ1k3VjFVT1JGMlNWV241QTdmVGIwWTdDaXdMQzk3TzBI?=
 =?utf-8?B?NTc0QXVBRTl5MzgwNVY0RDV2UXB1cXlVVmZTV3lZYWp0Tmd2eGVLWXc0dkxx?=
 =?utf-8?B?TXpqYnZjZmlmdUJPSTJDbGZUUkFKbEp1alhuUCs1QTRmRVlscEFTdzdPdzJ6?=
 =?utf-8?B?NnBqRnlENWg1cDJ4dk03bXZGOE1tbXozMlAvWW85S0VFZGxkNmRCcnA1VlZS?=
 =?utf-8?B?WkJhbkxSY29GajRHbkd2bTg5Yi81cU0vUm1IRjJ6Um9nMzJYU1laUFJZQThh?=
 =?utf-8?B?cktVYWpkVXBnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NHlGUXczK1h3bGNKTnkwYnhnLzNRTFI4WEdqRmF5dUN1Q0JWY1Q1RDFDNW5i?=
 =?utf-8?B?NXkyVEFDTW14eWVMcERNdTl4RmcrQ2dTb2xNa2d2ZlNwRDRaZmM3RVQvU28v?=
 =?utf-8?B?cFFZeGZDRCtzKzE5Sm91RG1MeGNMRjIyNWpwT0ZEN3hSNkkwWDJKQUhLQWJH?=
 =?utf-8?B?K28wT3Eyc2ZhQ25ZQ3liRkVObWdWN1lFWVYwVnhSM3FMdkppcFhmQ3Y3L1hY?=
 =?utf-8?B?TzZJRXEvNkQ5ZkJOMzNnQS81MDdkcHNidVA0aUwvc0lzb2d4cDhZRnJKVm95?=
 =?utf-8?B?a0RDUFR0elQ5dDd1OGNCMXlNQllGYmc4OW5NbVVRYy9nR3E4NG9uVitFT3lX?=
 =?utf-8?B?YzlRbEhTYngvVkJKU1RwSDRxYmFIN1Z4MjVFUjY0cFE3bVZ5ZHpBVXVZV0FF?=
 =?utf-8?B?VXVFeWVKODF4V1N0NmUrdTVyQk80c210L2x6WlBCUkwrSFpxZXlXVER2MFdR?=
 =?utf-8?B?dWNaRmVtaEV5UFd1YVgxWlBjNHFoeTN6b3hFTFJzRHdTTkZ0QVJNZkF3V1E1?=
 =?utf-8?B?cjZpWVJ1TG9XNHNFMExiY0kweVR3cFllTXF2MXRpa1JJODFXWVRoQm1UZHhK?=
 =?utf-8?B?WGQ4Y05IVVUrTTFPK01ob3h4UWVNY0svcWRYTjB3UWlxQ2o0MFA5RlhLdkZC?=
 =?utf-8?B?N25KdHhaM1pwL2xSTUxOZXNEYnVpRWN1M0NjQXRScGpzNkZmc3RvRGp6VS9i?=
 =?utf-8?B?VXVZSzhFUDZhTDI0NEdsT2VOcFduQ2swNXZ3MXJ1cGZJUmlKd0hUN0tXZUQv?=
 =?utf-8?B?bDBIWWF1cXVPelByd0Q2Z0l5MHgyWDlmMnVKbnJua0lDWlhuVmNsRlU1NDVl?=
 =?utf-8?B?WkNaRmJKNFFUblk0S09NZEJxSW14WEZCRzRnY2Uva3lZUDdUdEZzeTVnSi8z?=
 =?utf-8?B?bmNtZ0JvVTZod21hTm5iUldlWkZwZHF6ZUtEYTVMQ0RFQkdNTUlUZkxQeEls?=
 =?utf-8?B?Q1VzUzVQcG5SZHZlY2R5MXdyQTNjMkFZS2RHd3poOEVtZWo4bmM5d2ZJdHF0?=
 =?utf-8?B?UUorVDNXQjVuZ2pxSTdsZTM1V0Fta2ljWjhsVDB4c3ZucDg3bjc3R1BEcEs3?=
 =?utf-8?B?MEhVVWliemw0YkYrZmZOWnlUZDlRQzBNbEpkQjFOVEwwRjlVZVNQVVhIRDNP?=
 =?utf-8?B?ODFmMVExUVhYZXBJeDNXNXlwaG84WjZvQlF2YTVaNXVJYTNmRFpOcnhnM1hj?=
 =?utf-8?B?b3NSQmJtRWdhOHVsOGZIK2IxTVUxWlpPc1NaMmswa200bUZjYTl1SE5CTXhN?=
 =?utf-8?B?RjBmWkh5QjJLb3VPanM4QUZpQVN1ZWpkeDhVNEljWjRlNWRqblhCaFl1SDRL?=
 =?utf-8?B?ZUpvN1E4akp5L3FHSE51M3Vwa2RzK1dFQ2xTR0thVGorK0tMOE5uZEc3OUda?=
 =?utf-8?B?Q1hVTTJiOXl6MHFsclBsZXRDQXhyME5Dc0lvRXMreWZGbHlLeXdqK1VWZ3Fp?=
 =?utf-8?B?VDQyUTdIc0tOcTh5MVpMWEZlRC9JbjJweTM3TGE1bk00ZGtxNVdNU2M1bTVD?=
 =?utf-8?B?TFZoTkJKaEYxUlNhYmhQdmNBNEhYeE5rTlRlak9ZWXJnTTNCUjQ4cUgyVW02?=
 =?utf-8?B?aFhUMWZVa2hpeUVBNU5KWG5LeUdlTzlhZWZpcW5hYzh6ZDVLdlhIU2oxcmdh?=
 =?utf-8?B?MzdxcHByRWdaMCtlR2x3M1h0cUFVclZjQk9TM3JFM1lRelZDam9ieENVbVRx?=
 =?utf-8?B?SjBnNzJDREVJN09hTFlxN0RMQXZkaHVjV2pEVFQ2eHhhUzJFSnUvYUVpS1p3?=
 =?utf-8?B?WEZla05lMk9LOFIrZytVVU9tWWpsdytPN1ZCWXRkV29LK0I5THpjbEhDYWhE?=
 =?utf-8?B?THMva2RKSHdVOGhHbERYZTJBM1p3b1NHZU9Vc2Zpak1MSG5QM2g1R1pONEdQ?=
 =?utf-8?B?RW5VL2VLdXNpcEprd2xwckh3a21kQlJoaWUxdVYzbEJLc2ZUWjdTSXdRV1hr?=
 =?utf-8?B?S3A3Zjdyc3N5aUJTelR6V1lkbE1aS3d3cERlMWphaTFxSGk5YXVqSnNXancz?=
 =?utf-8?B?TVR4Z1AzSjRHTkQra3AybGZYUGg5Y2IweVpRREV6OVZvaXF2a1gxdFU5ZXJD?=
 =?utf-8?B?ZXRKYnA5SlJvSHh6eldxQUpNU21DOVlTVWkrcVp3TkNYMGtmZkV0S3ZFN0Zl?=
 =?utf-8?B?WlFIQklCZWYrNlJPcXYzajdRMWJVZDJDSmNsSHZ4QkdGWmp3L0FVSTl6ZHpO?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0467fc-b26d-413b-2e74-08de38a1fe44
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 10:42:33.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfLWswwkOY8gh3Hb6wYjzStJHeFnjW6OMqHBakigFp4qRKya04mK8mbAfdTyR6UqY3QvhPiRQ9A7g2z+ZbSUeYmXrZ4Lrp/m5psMcTFr1ySvJMHdZQ49dlCk6QvA/mRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13324
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Dec 2025 10:42:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20968

SGkgSmFuLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgdG9kYXkncyBtZWV0aW5nIGZvciBwZXJz
b25hbCByZWFzb24uDQoNCj4gPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQoNCkkgcmV2
aWV3ZWQgNi4xMi42MC4NCg0KPiA+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KDQpJIGFt
IHByZXBhcmluZyByZWxlYXNlIDUuMTAueS1jaXAuDQpJIGFtIGdvaW5nIHRvIHJlbGVhc2UgaXQg
dG9tb3Jyb3cuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBKYW4gS2lzemthIHZp
YSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDExLCAy
MDI1IDI6NTggUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkg
b24gbGliZXJhLmNoYXQNCj4gDQo+IE9uIDExLjEyLjI1IDA2OjU3LCBKYW4gS2lzemthIHdyb3Rl
Og0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQgdGhl
IHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MNCj4gPiB0ZWNobmljYWwgdG9w
aWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4gT3VyIGNoYW5uZWwgaXMgdGhlIGZvbGxvd2luZzoN
Cj4gPg0KPiA+ICAgICBpcmM6aXJjLmxpYmVyYS5jaGF0OjY2NjcvY2lwDQo+ID4NCj4gPiBUaGUg
SVJDIG1lZXRpbmcgaXMgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMjowMDoNCj4gPg0KPiA+DQo+
IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0
bWw/eWVhcj0yMDI1Jg0KPiBtDQo+ID4NCj4gb250aD0xMiZkYXk9NCZob3VyPTEyJm1pbj0wJnNl
Yz0wJnAxPTIyNCZwMj0xNzkmcDM9MTM2JnA0PTMNCj4gNyZwNT0yNDEmcDYNCj4gPiA9MjQ4DQo+
ID4NCj4gDQo+IFNvcnJ5LCBpdCdzDQo+IA0KPiBodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20v
d29ybGRjbG9jay9tZWV0aW5nZGV0YWlscy5odG1sP3llYXI9MjAyNSYNCj4gbW9udGg9MTImZGF5
PTExJmhvdXI9MTImbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQNCj4gPTM3JnA1
PTI0MSZwNj0yNDgNCj4gDQo+IEphbg0KPiANCj4gPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVLICAg
ICAgICBERSAgICAgICAgVFcgICAgICAgIEpQDQo+ID4gMDQ6MDAgICAgIDA3OjAwICAgICAxMjow
MCAgICAgMTM6MDAgICAgIDIwOjAwICAgICAyMTowMA0KPiA+DQo+ID4gTGFzdCBtZWV0aW5nIG1p
bnV0ZXM6DQo+ID4gaHR0cHM6Ly9pcmNib3Qud2wubGludXhmb3VuZGF0aW9uLm9yZy9tZWV0aW5n
cy9jaXAvMjAyNS8xMi9jaXAuMjAyNS0xMg0KPiA+IC0wNC0xMi4wMy5sb2cuaHRtbA0KPiA+DQo+
ID4gKiBBY3Rpb24gaXRlbXMNCj4gPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQo+ID4g
KiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ID4gKiBLZXJuZWwgdGVzdGluZw0KPiA+ICog
QU9CDQo+ID4NCj4gPiBKYW4NCj4gPg0KPiA+IFsqXQ0KPiA+IERhdGUgdGhlIGRhdGEgaXMgY3Jl
YXRlZDogVGh1IERlYyAxMSAwNTo1Njo1NiBBTSBVVEMgMjAyNQ0KPiA+IGxpbnV4LTQuNC55LWNp
cDogaW50ZXJ2YWwgMzAgZGF5DQo+ID4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRo
dSBOb3YgMjcgMTI6NTI6MTEgQU0gVVRDIDIwMjUNCj4gPiAgIGxpbWl0IGRhdGU6IFNhdCBEZWMg
MjcgMTI6NTI6MTEgQU0gVVRDIDIwMjUNCj4gPiAgIFN0YXR1czogT24gdHJhY2sNCj4gPiBsaW51
eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiA+ICAgbGF0ZXN0IHZlcnNpb24gcmVs
ZWFzZSBkYXRlOiBXZWQgTm92ICA1IDEwOjA3OjAwIEFNIFVUQyAyMDI1DQo+ID4gICBsaW1pdCBk
YXRlOiBTdW4gSmFuICA0IDEwOjA3OjAwIEFNIFVUQyAyMDI2DQo+ID4gICBTdGF0dXM6IE9uIHRy
YWNrDQo+ID4gbGludXgtNC4xOS55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ID4gICBsYXRlc3Qg
dmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBOb3YgMjAgMTA6MjA6MDggQU0gVVRDIDIwMjUNCj4g
PiAgIGxpbWl0IGRhdGU6IFNhdCBEZWMgMjAgMTA6MjA6MDggQU0gVVRDIDIwMjUNCj4gPiAgIFN0
YXR1czogT24gdHJhY2sNCj4gPiBsaW51eC00LjE5LnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkN
Cj4gPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIFNlcCAyMyAxMDo1MzowNyBB
TSBVVEMgMjAyNQ0KPiA+ICAgbGltaXQgZGF0ZTogU2F0IE5vdiAyMiAxMDo1MzowNyBBTSBVVEMg
MjAyNQ0KPiA+ICAgU3RhdHVzOiAqTGF0ZSoNCj4gPiBsaW51eC01LjEwLnktY2lwOiBpbnRlcnZh
bCAzMCBkYXkNCj4gPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1IE5vdiAgNiAw
OTowMDoyNSBQTSBVVEMgMjAyNQ0KPiA+ICAgbGltaXQgZGF0ZTogU2F0IERlYyAgNiAwOTowMDoy
NSBQTSBVVEMgMjAyNQ0KPiA+ICAgU3RhdHVzOiAqTGF0ZSoNCj4gPiBsaW51eC01LjEwLnktY2lw
LXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4gPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
RnJpIE5vdiAgNyAwOTo0NTo1NyBBTSBVVEMgMjAyNQ0KPiA+ICAgbGltaXQgZGF0ZTogVHVlIEph
biAgNiAwOTo0NTo1NyBBTSBVVEMgMjAyNg0KPiA+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiA+IGxp
bnV4LTYuMS55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ID4gICBsYXRlc3QgdmVyc2lvbiByZWxl
YXNlIGRhdGU6IFR1ZSBEZWMgIDkgMDk6NDg6MjEgUE0gVVRDIDIwMjUNCj4gPiAgIGxpbWl0IGRh
dGU6IFRodSBKYW4gIDggMDk6NDg6MjEgUE0gVVRDIDIwMjYNCj4gPiAgIFN0YXR1czogT24gdHJh
Y2sNCj4gPiBsaW51eC02LjEueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiA+ICAgbGF0ZXN0
IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgTm92ICA1IDA2OjUwOjEzIFBNIFVUQyAyMDI1DQo+
ID4gICBsaW1pdCBkYXRlOiBTdW4gSmFuICA0IDA2OjUwOjEzIFBNIFVUQyAyMDI2DQo+ID4gICBT
dGF0dXM6IE9uIHRyYWNrDQo+ID4gbGludXgtNi4xMi55LWNpcDogaW50ZXJ2YWwgMTUgZGF5DQo+
ID4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFR1ZSBEZWMgIDIgMDU6Mjk6MTIgQU0g
VVRDIDIwMjUNCj4gPiAgIGxpbWl0IGRhdGU6IFdlZCBEZWMgMTcgMDU6Mjk6MTIgQU0gVVRDIDIw
MjUNCj4gPiAgIFN0YXR1czogT24gdHJhY2sNCj4gDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBG
b3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg==


