Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62394C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 04:06:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.7744.1746677202213396651
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 21:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=VEPFESOS;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1746677182;x=1747886782;bh=Lg+bGZuoqFscbyyh9MyqjGRilxjN96TuVk1KdR9
	2nsg=;b=VEPFESOSy1ALjcWzLz8ivKs/sREJM7PjHwtuzDvJfoqGScHjac2bgrdrgx4gZMYtspKc2
	T0lVzXu7zhEXSskGACdXjUIo46hnbvnXfrQtCUeWQ8GolcILTy2N9lNT9v307a6xESBMdgJoyl6/b
	mOW3fp/bScZmHf9ntyG0oBmu+vBkaedg7FBChsOcKT/KgqXblvjG8tXcC90IdBKiUpTuQfrZGgVSP
	z95u2M8qwGxHQfTNcKKJ3aV6rVTyc8OkB+giXoDep7EVoVB/oNg0Mss0dk1AONj7cPC0P7uUZz0pY
	Xyn0Gr+MU67aH6bnRN0fNr+cvZkNuK3VuSY+wkBL4g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 54846MAp3582998; Thu, 8 May 2025 13:06:22 +0900
X-Iguazu-Qid: 2yAbuzQy386hBsweEG
X-Iguazu-QSIG: v=2; s=0; t=1746677181; q=2yAbuzQy386hBsweEG; m=bzqnwFHWYuhQ4162FJcEYkC4AR0LRH4OvkfPgxmerVA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 54846KdS364159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 13:06:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCgj8HjoUFHcs0BgaMYKkZk/PWZm/eAL8s6dKQy2skqHEWAKBeOAeSRuwPkyHMgXUwv9ipJU2M+hG7qoM7X0X9rSFlyLLbLtTpa+iaWYtH4N3/vQWf2H7bLBWREfqO13PkjGnoT8GRpwrnCfO4Xho3sv+5qWceU4ZAGSzfTdxWLZYPXzKVMslEkn+xdZQk1a03gkNH0HdXxk8vyIGg/bvBIoVsndrNCB7ZgPAC0++zOMzlxtVEAj+8tZ6s5lDhnpReXzoWefdrFs18ufLjsbnc/l6cP9rzB86zbSGns2PDAIgc7iL3niU0q8JbHA4EjXFXbxsrjYVcjFQCBTepJzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg+bGZuoqFscbyyh9MyqjGRilxjN96TuVk1KdR92nsg=;
 b=H+BFBjOpzjxocMB/bzZY1wzZjk4jeTTMoKewkHQVSLb6cCLkpQhLky+cJKtlvkIsBSC7aeThiDbt/w8Z+I6jSpOIMsZLDsSd8/jua17rghe/RjwYL70khK9upzdc7c5bYrfegcZrkgOtftZEtrQCNOZ7b0TKW6vKcfaR35ucqYowd4oFn4LMXd+Iw7U4cprOnxXGn/18R53WOnfH6s6P+gfczTvUKaXnmn3z0Y45O84PzTuCgkrKimotQCOJPbpqShXxA3ddzhr02EMGYoYsHpsGtmyB7eKanxR5/H3UGJg7fNgte/geSbMyjh5FBjLk5Zigl1l59uEP8Jvc1Pxc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.19-st4, 4.19-cip120
Thread-Topic: Request for review for 4.19-st4, 4.19-cip120
Thread-Index: AQHbvpmI/zm+Ibh0XESElnGPIEtk17PIH4yQ
Date: Thu, 8 May 2025 04:06:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818349616B2C5291E6557B8928BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <781807518.215591.1746544433020@webmail.strato.de>
In-Reply-To: <781807518.215591.1746544433020@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB6831:EE_
x-ms-office365-filtering-correlation-id: 0140f5a2-4bc4-4a49-3634-08dd8de5af05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RGVqdkI2bjNscVNnRHpVblJYZlpJN0FObmxNUzFTNjl2MmpSNndhYzF1T1px?=
 =?utf-8?B?Mnd3blFLU294VzBDZmkvSnFzQWJuVG4xUzFNMGczZXVwNmEyTTlLWVFzT1Vp?=
 =?utf-8?B?c20zSGJXNzBsMG0xZ0taTHNuVjRNN09DMWNkeDdjOFJPb0ZnK045TmpRQ0Rw?=
 =?utf-8?B?L0ZqS09SdGxKYTVlR0hKYkEwclllUXM5WWlVR2pRSmlHNUZhcVQrWTBPVjEz?=
 =?utf-8?B?V1BmeWIwTmdONHRYVm9vZ2pKd3pnSGNDbnQrUXNvQ0w4S3E3ckMzTzk0QVNU?=
 =?utf-8?B?akJyUVBxWlA4bGZlTDNUdXRnWlRFdWE3MW82TmdndVduSmpNRWhwcHdEb2Zu?=
 =?utf-8?B?T0ZnT0hhcVpLVzRpSWJINDhDaTBPNlAxZ0ZoQWpoclBiVTlvSFZCMTVJSHlF?=
 =?utf-8?B?Z0U5Ymlhb1RlQ20yeUxJRjhCc2JzYkIvRmtQMWRySmVCMU9aSWxCR1hnd0s3?=
 =?utf-8?B?amtCN0EzS1dERTIwR1ZvdzRZTnc5ODdqTDZsOFJZYVN4dTlnUENJdTgrYVFl?=
 =?utf-8?B?MmdzSVlscTdiVWc1TEtWMHhLY05RamRPSjZnNlhqR09yZ253QzBnekNld2hO?=
 =?utf-8?B?bEhYQlFxSGp6ejdyWi9zaVo1aFUzdURmUEtYd09tcXdJWENTZk9CLy9mSlV3?=
 =?utf-8?B?cVZETnN0Vm0wVGFEa0lzMHJJd3kwMHYrbHUzN3J0WURyQzZRVmpnUktVZnIw?=
 =?utf-8?B?UXhDZG5BTStMWU1DQy8zUi9UaExQNjR2emNuOWpuYTRYMmp1VG15cm4wMm90?=
 =?utf-8?B?NGI4RTE0MVFuNUxZdnhlb3VmZ3JnZjhRN1c4YXZVZVZnUEpCNW5hNFNVdjVp?=
 =?utf-8?B?WXA4ZnVTK2NkTENROHN1RTl1ZE00NGk4cENCYWNJeVVqQ2YweDd2QmFYa3BD?=
 =?utf-8?B?UFFWMnVKamRyRFNMUkJlcUhTUkdIdFlqb1VnTWRrNFFrTDBqTmRGa04zR2xm?=
 =?utf-8?B?c0dxUmFuSVRqT2U3dGVWZEMwOWNqWEZmTTFjeDQwV1doOXY1amFPQThjWTNt?=
 =?utf-8?B?YlhnMEVSZ1FIVlJ2czMwcC9hNWpGd2U4azEyMUM3OFprMzRXNENHSnZURXk1?=
 =?utf-8?B?SWtYdHdJOFV2V2lleUt6c2RpMktrYUdKZUZ4SG0xdUw0aEJ3V2NCL2VhYzcy?=
 =?utf-8?B?RFpRSUVTdXM1UTVYUGVzNW0rZjFldjBxMjl3enhlRTNJTHptSkVtVGJRRUc1?=
 =?utf-8?B?ZG5wUGxxbzBaYmVoRDVrbzlsWGRvakx2dDBhOUI4YTMzekcwK2NSUUFWSE9u?=
 =?utf-8?B?LzhiRk9qZzhlKzdveEUwc2ZzL0NyZHBJdHFIdHliaDlNSGUxYVVxNUorb2FI?=
 =?utf-8?B?ZDRVTFhZaXhrSFpPcTV2TFNlQWJjQk14VEJkN3BDSHpNK2hVYXZGUW80NEI3?=
 =?utf-8?B?Sjh3a0hkTFMrVjVhMXg0ZnFoWjJrbENjUXl5dWFIRW9TZStJdHZodGpXWkpw?=
 =?utf-8?B?aEJKL2hrUnlNRDdpenhoaWV3ZkMvL2lZY1NERTNsNnFOS1hHLy8vRTBTQXJl?=
 =?utf-8?B?MndZRkdIblY2b1ZTYjBibkFKUE1Ec0lpOGgvYUhxeXc3ZXd6dWhTVXNEcnFO?=
 =?utf-8?B?YTNVQkl3ZzdyQzZiNDR1cXVteDFqNXpNWGg3WVluVENlOHJVSEpRNGhrOWUv?=
 =?utf-8?B?dVMrS1J6MUJMb1htbHZCTlRpMlhOTUN5NmFoZjljeU5IQWZZdTkxaEF1ZTJv?=
 =?utf-8?B?anhlRmxPUUY4aksvcUtBT0E3VFBLWFJoczFjQzdKd0x0bTZzQWw5MXpJZkl4?=
 =?utf-8?B?dTRLM0JrUzJuL1VLelpHVlpjbmdpZ3ZMQ0VuVWdtY3NtSVNlUFhkd3ZlYkhN?=
 =?utf-8?B?bTNWMzdaZm9NN2QrNkVUQktJK1RZNWdwTVdiZjY3RWMrVGRXdWgzc2x2RUs2?=
 =?utf-8?B?QzdORXkyRGZjeVoxdVhURlRCY2s0NDM2NCs5V2lzdTdhNlQ4ZG1zbnMzNFcz?=
 =?utf-8?B?dFlCMXpadXNwbllnVzUzeUhob3VudndYVi80bDRYdUJib0VQcjlsY0NHQ0t0?=
 =?utf-8?Q?WUzj6YmYrU+xVazH7/Ap02kDkb8OQc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZU9iK2hTWHRKVlRoenlpaGYwRHAyY0NBcGI0aTRucHd2V1E2TXhZc0lBWWZn?=
 =?utf-8?B?bEhoZGp5bDlNSU9uSnpOeEhKNXZzNlFYbTZJN1RXMG94cFBjMzVaN3dROGxK?=
 =?utf-8?B?Y1hxVmNTL2RNbElhUTZLVHVZWWNncUI5UEJwQjdSRy9BUjZiaTlZV2g5dEV4?=
 =?utf-8?B?bnBQTHFWU0wzeDRLNUFVWEN5aUVZamk2QVZtVXkzRjBoYk1hRkxYTlY4MTlC?=
 =?utf-8?B?SGJuZ3hoVU5WVXhMRWMybHNBZzRQUXFvZVhQSVRzbEgxTU5neDVzWlJYU2ps?=
 =?utf-8?B?d1J3V1lOcnFaQTFISkZDZmF0YkJXSmtPSWtjdnJvSEtub3FlV2RlYWRlc3BZ?=
 =?utf-8?B?eExnTW90Vzd5ZnVVeVE0R1Vjd2J5cENjbWpRa09GRHQzbGtnUGwyZWhrSEJI?=
 =?utf-8?B?Rm93dGx5R214TnIzRGxWU0R0ZHdLaGNuaTY2MjkvVW8zd1dCMUN1MDczNDRZ?=
 =?utf-8?B?cXBIUDhvbU40dkROM0oydzh0N2hXOFVKek9Rd2RDcVBDN3NLbjdnTHhCL25k?=
 =?utf-8?B?R2NLdmZMMjJDYXFyTHVxNDlUcTNXY21aYnkvR1JuQ0lYanVmUVBpdkF5bU1V?=
 =?utf-8?B?ZDhpc3gyUjRicHYrYk92eGU3YjAzSzFGeFo4bXRwMlFFWFE2MWpyRkZUTGR5?=
 =?utf-8?B?Ky9ML20yRkFDdExmSDlwdCs3eTg5ZThoVHJTSnRmUWZpNWo3NXgxM3pMNW1P?=
 =?utf-8?B?ckk5MW9JNC8xY3owYWxhTVFFN0dMUEdXMmY5aXMyV1FsWCs4LzZ3a0p6d2NV?=
 =?utf-8?B?SzBzWkhuc1JETnlBOXdEcWY2S1piUDRFa0RNNHZGT2gyYWRScjRoSHE3MFNy?=
 =?utf-8?B?RkdCUldtdS9tYXo4TU5LOEZQUEhGSjJTUk5YbVdvaXZSdE83RVZpSFZlbVRj?=
 =?utf-8?B?TlBvVERWTDNrMGh5M2piR1AwbTVHalZyVzF3SzB2TXM0ZWZsbUc3bmhya01V?=
 =?utf-8?B?bGthREpyNDBmR1RBMG10Mk56YXdSRGZZWVNNeVJYNEwxMGdtQjlFWm1HUHR3?=
 =?utf-8?B?b3FHVFBtWENwVndMV3IwWmx6SW44eWdUUlhPZkdrSnhyblgwTWRWUzhCc3JW?=
 =?utf-8?B?NWFOYktxRDFpVEJ3cTMyQmsvcFhyc0s2QmNjU3ZHTjU1NEZWd2JhRTNHVjlE?=
 =?utf-8?B?WjhFaGE5Wkl4b29BV05pMDBzdk5ZY1d3dklsbG1uNWo0SVBVNGl2TDZUbC9D?=
 =?utf-8?B?bGgydGhMbnI1Z1R4TXNwNTRDTWxLVHQ1eGMybUFkNmFQOU9MM3pmTUFmR3JK?=
 =?utf-8?B?MWxRUE5EVEZXeVF6a3c5eDlQV2dvcS9tWHZrSEJYdDBhT0pobGgvcERiVUl0?=
 =?utf-8?B?M2YyNGRhcC92cDkxTGxMSUE3WEhPVnBrZ2NKUmo0TzFsZyt3VDVLUFZzbTA2?=
 =?utf-8?B?Qi9HSkxFdGNOb3RjZ0hmcHg2bmVCRGptcW9IVlFIYVZ0eTFrSEl2YnkzNGRy?=
 =?utf-8?B?RkRIS2lpUGdDUHBaVS9ZYVZnZFhKbU91dlhsZUNvcXQ3N3dMYVB4amFBM0Jq?=
 =?utf-8?B?Y3hLL1JZcHc2WFBkR1A1WlVrZXpxeG1QR1ZOU0V0cCtGYkozZjlDOXVXaHZB?=
 =?utf-8?B?VVUwWjJnSDRRVEFYZjNraUxWcDgxTHhjWjdMZ3ZRTHlnQnN3M1hFV1FwRVJG?=
 =?utf-8?B?L29GN3VkZDhRNmJqWXlzaW5vN3RrZGFub0VXREdjWG5PZElRamhrbU81cVNn?=
 =?utf-8?B?NDRtamp5SElPQnYxeFo3cE9Wayt2ajJoUXo1MmF3S1VITVIwTzZaZnViWWNC?=
 =?utf-8?B?Tm1Eb3BRZGlnYTV3a1oydVk4L0k5cGE3OGdTblZNQmpDTzFZSzRoQlNFRnRQ?=
 =?utf-8?B?c0Y5ZzZGOEV6em9zTWRQUTRocXcvcCs2cnpPVHN2N2V1UUpQRXNqUHl3a3V4?=
 =?utf-8?B?cnIvc2s3L0JEbW5FVUh3ZTV3N2lMRkxUYndrUER5Sis4VzVaSnVZT3g2RUhn?=
 =?utf-8?B?TThMYXVMV3dhcEIwZ1dabHIzSG1ZeFRqeEhSOWdrRVRUSi82NWtwUk9JUmp1?=
 =?utf-8?B?OTA0TzhXeU1waC9sSDFZTm53QWVkcEtMc3dURzJWZ0dDaHJBcmpPSlV0RTJ6?=
 =?utf-8?B?OWRZRS81UXZOSUNOL1FGZC9xTFhYQW04WGJicjl6Rk5zOTRzbWFNaldnYkht?=
 =?utf-8?B?VVdzZFQ5NFFvTXQ1YnA3bFVlS1lUMHM1RVZlbG9kd0lWalR2anBBaEZIYlFJ?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0140f5a2-4bc4-4a49-3634-08dd8de5af05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 04:06:17.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6IIBQ1v/698f5LBsdVt8rTlHjAKO6fZlbLsR5ydqg9jXrtT02VM5tu8zpdy5+n1cCnfoOvyezjcemRdFTYor/EKq3zQ1IEIsKewWOPrniAoLm576TSuBxnwNlhPeQo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 04:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18778

SGkgVWxpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBI
ZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA3LCAyMDI1IDEyOjE0
IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgcGF2ZWxAZGVueC5kZTsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oQ0KPiDmtIsg4pah77yk77yp77y077yj4peL77yj
77yw77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFJl
cXVlc3QgZm9yIHJldmlldyBmb3IgNC4xOS1zdDQsIDQuMTktY2lwMTIwDQo+IA0KPiBIaSENCj4g
DQo+IEhlcmUncyB0aGUgc2luZ2xlIG1hbnVhbCBiYWNrcG9ydCBmb3IgdGhlIHVwY29taW5nIDQu
MTkga2VybmVsIHJlbGVhc2UuIEFzDQo+IGFsd2F5cyBpdCBjYW4gYmUgZm91bmQgaW4NCj4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNp
cC5naXQvbG9nLz9oPWxpbnUNCj4geC00LjE5Lnktc3QtcmMNCj4gDQo+IGI2YzNkNjcyYzU1ZWEg
bmV0OiBkc2E6IG12ODhlNnh4eDogcHJvcHBlcmx5IHNodXRkb3duIFBQVSByZS1lbmFibGUgdGlt
ZXINCj4gb24gZGVzdHJveQ0KPiANCj4gVGhhbmtzIGZvciBoYXZpbmcgYSBsb29rIQ0KDQpUaGFu
a3MgZm9yIHVwZGF0ZSA0LjE5LnkgdHJlZS4gSSByZXZpZXdlZCBwYXRjaGVzLCBsb29rcyBnb29k
IHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


