Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F57C25B7E
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 02:17:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.6816.1717035444698389919
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 19:17:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=SDFg9aa4;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717035435;x=1718245035;bh=jVzTWSscmcFnoh0rP1B/5fIWMvo9o6l2zglD5LH
	qKrk=;b=SDFg9aa4pDCF8TBYf7jVtR4wVn3lfSexYDLEW3+ePqL7QCkV6dtAuRXcXzmeOBavRjSf6
	eKcuq4HoXSaSJlH0GupqKma8vJZsPzCrq/s7zqNkkprocbI5pWlaOfEDyA5RWadJ4uOLj4pE5dUxq
	QNITzZSf3E+zbEylch42ijAo7q8eifx0wR0Tx3FbcFuhSsSXL4mjps86ld90ziwL58jH1MKfs6U6i
	bBzjlLCT2VFH8zhZtTFo1tbJSIsmg4W1a3HXespg0FVDy/MsbKYF/ZCLN6NDMwMdE0bOuxOgcXKho
	jhLbRxG1rBG1IC9eKakd1EspGbaROR0N0eVbL3sjmg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 44U2HE4d1267846; Thu, 30 May 2024 11:17:14 +0900
X-Iguazu-Qid: 2yAbXhlxOdofvp83SY
X-Iguazu-QSIG: v=2; s=0; t=1717035434; q=2yAbXhlxOdofvp83SY; m=9yijUEeDcBRMa7NgK4hRDVIw1nvqQWrQAj3BPUZne4k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 44U2HDZo2057538
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 11:17:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgVS8zyuSvDwzOu4SBIGWxHN9hFo39L5rp0YUOCacoc74XUY4wWyNaslAB2DlVKKqdwbv8bY8tGTR3wj05Ctbir8qwBBv2z2BwfNNEQ9anyEjMf/XX4O01c/Ow+BV7TlUeCq2b3RZLT+5bhPMFePCiVJ5DWNlLPxaCStz52gSVNN5U44L8YVvy1YxI5IxPan8E0xAcRKzAGy55VLbSLuwsaOlUZGT7ouAQiZHgfhCAwdEQV19tRtmHPa4rose18x7VyS6f5MmKC2DFI/2zjwdTaohrlto1njAcGR16BBH6tOMsm5cQDTl+Fg+69uAsHiR0H4KjjubEm7V23xhQAJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVzTWSscmcFnoh0rP1B/5fIWMvo9o6l2zglD5LHqKrk=;
 b=huVbCB0hJQctXX9aLa34aMw+X9yrYPvB73UfN4hfF7ofgY+5Z1R1oTwlN122ibeoLfoho0Hjukv82stMgMPTeB+aL148oz/eLVpqMc9C0uPQ05iw57vaMm1D75jh8b0pN0SRoPlO0uoTT/Un3JXlW+BXw3k9+IJHSJPAlUQUZlMxCiwZNs5eOk45Bn+69TeaXwBI0vqwVnYRRIcxzO37k3pdeThfjgTOiVcWIdl3PF7znSmVx9mQgQHQPmkWhHdq1NlWPTwfj6QtJgBeTcrIYyyc393gAeGDk7Pyo4porLBU2j3jkLMx+K0y6pUFx1aNZaXXB8iC5qxqVG+QvlB4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/33] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Topic: [PATCH 6.1.y-cip 00/33] Add Ethernet support for Renesas RZ/G3S
 SoC
Thread-Index: AQHasaBEbO8dfrOi9U+zxwY+svUCGLGvCmHQ
Date: Thu, 30 May 2024 02:17:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388FD37BAFD725020BEB60992F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8434:EE_
x-ms-office365-filtering-correlation-id: 09b0f9b0-1816-47f0-35fd-08dc804e9d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dWdIU1N4eDN4SWpKcHBnVkszUUZsSTFjVkpWdURrbXFiM2dZS0k4UDk5bmt2?=
 =?utf-8?B?aWxVdEV5L2NzcWg3RWwyUkhiNXVuYmJzT2pTejBLR3RNQjIrMTBBR081c3JN?=
 =?utf-8?B?Qk8wSmtQb01rUENBNytWdjcvVjAzNWFQbWlobGZ0Tm8rWHBDRlBHbWZRVlhj?=
 =?utf-8?B?U1VSRm16aXhtOVdNa3NRTFlrR2FvUEhWT2J4WlR4VkFDb1FEM0pmd3VOYkxP?=
 =?utf-8?B?Y09SWFB3eXZ3azY4THpJTGRNMGlPMGN3b2dhY09iKytKTVBTaGVrV1RnQVJ2?=
 =?utf-8?B?cVE4RC83NUl5UTFJQmg0YkplbVpVVGlCZXg2TjdXZE8vMlBrYWgxY2JPZWZU?=
 =?utf-8?B?ekt4V2FCWFRLN0w1MzVCT0VnOXFuY0h0VUxuekl6VTNFNkFEaWtxdDljczZo?=
 =?utf-8?B?Wmd4aUZ2RmZISDF6TW1uR2Ntc3BjUlhDa0hDYlZrOU5ueW1uZ3VtVzFnR1Bx?=
 =?utf-8?B?Z3ljWGZ3N2hjbCt0ZDltNm5ieDJOVTBoMFdYdlpZdW1oWWlFNmxkR3JQTVdW?=
 =?utf-8?B?SVlDY2dxT2NrdmdkVGNBVklIZ3RjRHNXRlh0THVwN1RXUHJKS1NJTDhTZ1VE?=
 =?utf-8?B?dU5GZm42UnE2TnRnVWVhZmRlanBBNzFHNkdodldwUmNaVWJ0VENSQm1neWlG?=
 =?utf-8?B?TUJGOXgzemRrL3ByRVNPendqK00vYzcybnlvdTBFM1VqT1YxYW8vYlRLc1g5?=
 =?utf-8?B?UEdML25GQ1JpMkw2NHAzTXJiQUgyUUhXUitSV1RwUXFjbmZIL3MyZjVKZzFs?=
 =?utf-8?B?VEhGZ2NLOTVXNytaYjBRcmdLUGo0ZDJJc3VnM1pEc0tZRlF2K3pxVnB6b2s0?=
 =?utf-8?B?ZTl0YXJwOGdlM1AxYUpvN3JjSXh5L1BXMkRhNUo5MW1sSTZUUjM1QUZnOVAw?=
 =?utf-8?B?dUVhc1VBNVNkaHBmM3Z1bkJYQndJTEpjUXNodmpJZ0NadkV5cTBSY2dqd3Jp?=
 =?utf-8?B?ZG5XSm80VmNaajhJVW10eks4UVEwQWcyNVRuTXJNL1VYaWhLYk9vOTE4eG1F?=
 =?utf-8?B?bWZNRVpNNTgrd0paTENPeXFwNEFMTmloOHV6QXBTRW8xZE4vN2lpM0xrWC9n?=
 =?utf-8?B?Vk9Cblc5bnpDT0ZXWnZhNE1kT0x1RXhlc1R2bkFtM1V6a252enBIRFFLL2cv?=
 =?utf-8?B?cmdndWsrbXdibU9INWpLNFVTTW95MHRoV3FZWnlkMXBvVEx2NGF3M3NZc3ps?=
 =?utf-8?B?ODNuUkFYMlRQUFJHb3Z4ZlVDRDFBUy9oenA3Z285UXB2KzRQU0wrWVdYeitO?=
 =?utf-8?B?c1IveXhodE5GS0dRRWVnRXVDVVRhWFB4Rjloc3NtYlcrLzFZNVIwVlZvMXV6?=
 =?utf-8?B?UkoyaDh6MWovaVk4VFZUMGZUd0dndE0vaFNTUllFMnJwME8xNW96QmpWc3N0?=
 =?utf-8?B?eFJNekc3OUVzUHdLSHo3aGN5akJTemV4SFFZOEFKTWZVVFJjUlNRdUpSb25z?=
 =?utf-8?B?b2Y0djNDdkRwcVh0YlRobitzS2YvWXpNYXEwcTJuVkk2YzA1NjRVL2kyeXNQ?=
 =?utf-8?B?NjVkVi85V0J6TGw0c29Lb0cvVUhYa3VUUGRJdXBWT2tZelYwY2VsR05OcmhI?=
 =?utf-8?B?ZGpWZDE3Q1F1dnlVK0s4VE0wV1BQTVVibkJUTlJRQ0F4bTEzRkJra3NkT2Qx?=
 =?utf-8?B?cDlmelR0bCsyZ08vVVZFc3RyRnFaSEVGZmJqZm5KNktYR2ZMWng5Ry83ZDZG?=
 =?utf-8?B?NnNKZlV1c1J6ODUvRjkxZjB0NFNyZlJyVExxY2JHU1RoTVg0bXdMM2Z1bUpM?=
 =?utf-8?B?eHFnWEVueUF0cVliU3BsOUhSMVUwYTdSRTVIUUpRL283N3B3YXhQNE1tTUIw?=
 =?utf-8?B?Qk1NTnVXV0ZYenprdURZZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S1ZXV1IyUWd6VFVYeDFiNWoremUvclZtUlNxSXVFNEJFdldtM2F6MW5kNzJr?=
 =?utf-8?B?WmFTZzA2VUVxYlIxSHI3Nit4TlRxbWxTSExUdjBhRm04K0J1aCsyb3pFRW1T?=
 =?utf-8?B?cldlUmdrVmU3cjZaMUV5VFIzZlRqUi9sS3ptOFQzak12cFNhMVYxdzNTSWZP?=
 =?utf-8?B?bi9TTnZRSFo2TFRWbC9QMHpUUG0vYTI2cEZuZkF5N2pMVlFQaFN1amk5WHhi?=
 =?utf-8?B?VDBRaG5BbVZraTViWkF4MjdPa1d6dHlhWTh4WjdWSC8yUTI2eUR5SHMycU13?=
 =?utf-8?B?dkpRdDAxdU5FbjJDeTdxWEYxdE5UTS9FZy82eE50QTM2QzJDMVJqVVdrWVF0?=
 =?utf-8?B?cjhXTHUxVFVOZ1d5WE9qTmNQcmZnM2d3QVhUTlgwMEZlNlA4Rkh3Z0xMSDg1?=
 =?utf-8?B?SlNpU2lDU1BFS2gvSm8rakR2TlZnZlBTbmlTVnJRRE50QWYxcFJialM4S1gr?=
 =?utf-8?B?ZTNWVUVXWTlCQXJST2FaaVZvMUFQOFlUWWJoYWh6a1ZJODdnN3dLT2s4eXFH?=
 =?utf-8?B?dVNpVzYwZm05U2ErNWthanBWRS9WRnRJOE5ycFBKL2xMQXpHTmJWQ2ZvYldP?=
 =?utf-8?B?SitZZS9QV0gzV2wySk1DWkx2S2tEeVFTVmVkTTkzMld5QjU2WjZnZlRwMTRT?=
 =?utf-8?B?NWxod0g4U3RicmExTmhIN0NwVzg4Rnd5MXZFRzZNZUZMMzFzYTFzR2QwZTUz?=
 =?utf-8?B?OExLTVkwTnFEdGQrNEM4a09JSEJ5ckZoVm5ZbXBXbFpZcHZyUXlNbTBsTkRR?=
 =?utf-8?B?a2JPVVJtYVUwSmJwUXFKSVhZL0pncFA3bGpQVjlyNXAzajNJOUdZTFYrNnJT?=
 =?utf-8?B?emlPeHlPcEZ6VzZnQkFHWldRcmYxc2VSaEJIVzh2OGJUZXU5c0VCUE52ckZy?=
 =?utf-8?B?c3JqVTRGTzFDaDFjamZYOUd2UkN0SlozQi9XKzBBL05CakpQV3JyS2ZyTDQv?=
 =?utf-8?B?aDJFZzBKZFRiUWZrNWh6a1RYcWN1SHErV1A4VUNYaERmdlkzRXFzQ0xYS0ZE?=
 =?utf-8?B?ZDRpeTB0UXVrajdmWlZPNmJhVnkxTlR3Mm1zckVZNmQ4SFVrN3BpOGVHM0tU?=
 =?utf-8?B?SEExcEJVY2ROaTdzZHEzbDdTRG40QnA1VFZFZkFjQUlnaHNKSTJlR2pkaGxP?=
 =?utf-8?B?VzA2T2FHbGxpaE5pT0k3MGxSYkNUcmFrN3M2dlB5VGhnd3hyWm1FZXkzejNW?=
 =?utf-8?B?Q0NZLzdXVzl4TWJWWEhKbUlGaFVQVlp4UDRwOFZyQ2tsVEh6OXZYS3BVSmpC?=
 =?utf-8?B?R0hHaDJ4eVhNMG5sdS9GV1RWZVVYUXBUbFU1T1lyT1lwaGljZjlmRkgvTitM?=
 =?utf-8?B?bkNJUXJSL0FoQjVkMmFmcm1lc0lhT0tOUkRIYTNCZ1R4cnBKRDIvRnBYelc2?=
 =?utf-8?B?aUJ2ekpaV21NMFF1V3E4UWY0K0xlTTc3cUxMVUliYTNEZDV6WmVuRWtHbHBr?=
 =?utf-8?B?YXpIMGtlanRoZVlMbmhIWlhYMUQzZkFEN2pYR0kyNXlrQi9vT013NkxTaytr?=
 =?utf-8?B?SVZqd3FwcEVTQ3hxUFdyazllM2wrRlVMU3pIeFZxa0V3RG4veVhBSU5ic1Rr?=
 =?utf-8?B?ZjRzRmxnSVBWTEdBS1p3K2hEUnV3UkVGN2ltSjNDSks0QUxqb213TkZoclkz?=
 =?utf-8?B?bFJndjVkbVpnQUt2cVhzMFBGZUthYXd0dEJZTVRuMk9RUTZ5WFpxU2JYTTZC?=
 =?utf-8?B?UFJEeVBGYjE1L2pKcFJoUytIYllValB4Uk1ydmZ3NHpSZ2VGV2lGdUdVUHFI?=
 =?utf-8?B?ZWJIZGNNdzJwaytMZm1leHpYZkEyMWhGQ2RZT0hGZ1FrSlM1c2k1Wjg4SEdh?=
 =?utf-8?B?VUtxeHB6S3RsREZpQmpTdVZNL2UvamxMY0diNUh5Qzd1VmpEOGsyN1VYOTEv?=
 =?utf-8?B?Nm4yT3dDbkVHbUJqM3QxVTQzR1AzWU1pYWNVMm43eDcveEExbjVUTDBSalFR?=
 =?utf-8?B?bjBsNWxCNGRZc2dlRmtOemRIT2lLM25VY05GaHpaTCtYWk5JTEg1NnQvSUIz?=
 =?utf-8?B?dWFYSWtzMGhUelQ4Y2RXT2F4ZU1WejVpcXQ3ajJGYkxzQks3a1pxbWQvbmJE?=
 =?utf-8?B?YVloeG1YUWVGb0s5R29kZ2F5Z3BEYWx5YWFNQjdnOVB3dkFUSW1sUWZ2S01K?=
 =?utf-8?B?QlFDWERISFFYVWtZaSszZmZzRnFmNnM3RUJ3MUg0ZHZJNUM4VHBrTDdCcWQ3?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0f9b0-1816-47f0-35fd-08dc804e9d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 02:17:11.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kpMxvj336zdvxb7xdT4tF4W7EI0Wl28hgZoKFs6Tl06yEwfWO2TvG9WnIIvliT4ZdJ5pAhJmknTc9Ijy8jd8JzH/W65s8qlFTZxvekIIT+kbFO37g3iRfA9ffI0yXjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8434
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 May 2024 02:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16070

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSA8Y2xh
dWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAyNCA1
OjE0IFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8
tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPjsgcGF2ZWxAZGVueC5kZQ0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc7IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tOw0KPiBwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb207IHBhdWwuYmFya2VyLmN0QGJwLnJlbmVzYXMuY29tDQo+IFN1
YmplY3Q6IFtQQVRDSCA2LjEueS1jaXAgMDAvMzNdIEFkZCBFdGhlcm5ldCBzdXBwb3J0IGZvciBS
ZW5lc2FzIFJaL0czUw0KPiBTb0MNCj4gDQo+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEhpLA0KPiANCj4gU2VyaWVzIGFkZHMg
RXRoZXJuZXQgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HM1MgU29DLiBFdGhlcm5ldCBkcml2ZXIg
aGFzDQo+IGJlZW4gZW5oYW5jZWQgd2l0aCBydW50aW1lIFBNIHN1cHBvcnQuIFRoZSBzdXNwZW5k
IHRvIFJBTSBzdXBwb3J0IHdhcw0KPiBhbHNvIGltcHJvdmVkLg0KPiANCj4gU2VyaWVzIGlzIHNw
bGl0IGFzIGZvbGxvd3M6DQo+IC0gcGF0Y2ggICAwMTogICAgYWRkIGNsb2NrIGFuZCByZXNldCBz
dXBwb3J0IGZvciB0aGUgRXRoZXJuZXQgSVBzDQo+IC0gcGF0Y2hlcyAwMi0wNzogYWRkIHBpbmN0
cmwgc3VwcG9ydCBmb3IgdGhlIEV0aGVybmV0IElQcw0KPiAtIHBhdGNoZXMgMDgtMjk6IGFkZCBz
dXBwb3J0IGZvciBzdXNwZW5kIHRvIFJBTSBhbmQgcnVudGltZSBQTSBvbg0KPiAgICAgICAgICAg
ICAgICAgIHRoZSBFdGhlcm5ldCBkcml2ZXI7IGluIHRoaXMgc2V0IHRoZXJlIGFyZSBtYW55IHBy
ZXBhcmF0b3J5DQo+IAkJIHBhdGNoZXMgZm9yIHJ1bnRpbWUgUE0gc3VwcG9ydCAoYXMgcnVudGlt
ZSBQTQ0KPiBlbmFibGUvZGlzYWJsZXMNCj4gCQkgdGhlIEV0aGVybmV0IG1vZHVsZSBjbG9jayBh
bmQgdGhpcyBpbmZsdWVuY2VzIHRoZSBFdGhlcm5ldA0KPiAJCSBtb2R1bGUgc3RhdGUgbGVhbmRp
bmcgdG8gcmVnaXN0ZXJzIHNldHVwIGJlaW5nIGxvc3QpDQo+IAkJIGFsb25nIHdpdGggaW1wcm92
ZW1lbnRzDQo+IC0gcGF0Y2hlcyAzMC0zMzogYWRkIGRldmljZSB0cmVlIHN1cHBvcnQNCj4gDQo+
IFRoYW5rIHlvdSwNCj4gQ2xhdWRpdSBCZXpuZWENCj4gDQo+IEJpanUgRGFzICgyKToNCj4gICBy
YXZiOiBBZGQgUnggY2hlY2tzdW0gb2ZmbG9hZCBzdXBwb3J0IGZvciBHYkV0aA0KPiAgIHJhdmI6
IEFkZCBUeCBjaGVja3N1bSBvZmZsb2FkIHN1cHBvcnQgZm9yIEdiRXRoDQo+IA0KPiBDbGF1ZGl1
IEJlem5lYSAoMzApOg0KPiAgIGNsazogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgY2xvY2sgYW5k
IHJlc2V0IHN1cHBvcnQgZm9yIEVUSDAgYW5kIEVUSDENCj4gICBwaW5jdHJsOiByZW5lc2FzOiBy
emcybDogTW92ZSBhcmcgYW5kIGluZGV4IGluIHRoZSBtYWluIGZ1bmN0aW9uIGJsb2NrDQo+ICAg
cGluY3RybDogcmVuZXNhczogcnpnMmw6IEFkZCBwaW4gY29uZmlndXJhdGlvbiBzdXBwb3J0IGZv
ciBwaW5tdXgNCj4gICAgIGdyb3Vwcw0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBBZGQg
c3VwcG9ydCB0byBzZWxlY3QgcG93ZXIgc291cmNlIGZvcg0KPiAgICAgRXRoZXJuZXQgcGlucw0K
PiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBBZGQgb3V0cHV0IGVuYWJsZSBzdXBwb3J0DQo+
ICAgcGluY3RybDogcmVuZXNhczogcnpnMmw6IEFkZCBpbnB1dCBlbmFibGUgdG8gdGhlIEV0aGVy
bmV0IHBpbnMNCj4gICBwaW5jdHJsOiByZW5lc2FzOiByemcybDogRml4IGxvY2tpbmcgaW4gcnpn
MmxfZHRfc3Vibm9kZV90b19tYXAoKQ0KPiAgIGR0LWJpbmRpbmdzOiBuZXQ6IHJlbmVzYXMsZXRo
ZXJhdmI6IERvY3VtZW50IFJaL0czUyBzdXBwb3J0DQo+ICAgbmV0OiByYXZiOiBSZWx5IG9uIFBN
IGRvbWFpbiB0byBlbmFibGUgZ3B0cF9jbGsNCj4gICBuZXQ6IHJhdmI6IE1ha2UgcmVzZXQgY29u
dHJvbGxlciBzdXBwb3J0IG1hbmRhdG9yeQ0KPiAgIG5ldDogcmF2YjogQXNzZXJ0L2RlLWFzc2Vy
dCByZXNldCBvbiBzdXNwZW5kL3Jlc3VtZQ0KPiAgIG5ldDogcmF2YjogTW92ZSByZWZlcmVuY2Ug
Y2xvY2sgZW5hYmxlL2Rpc2FibGUgb24gcnVudGltZSBQTSBBUElzDQo+ICAgbmV0OiByYXZiOiBN
b3ZlIGdldHRpbmcvcmVxdWVzdGluZyBJUlFzIGluIHRoZSBwcm9iZSgpIG1ldGhvZA0KPiAgIG5l
dDogcmF2YjogU3BsaXQgR1RJIGNvbXB1dGF0aW9uIGFuZCBzZXQgb3BlcmF0aW9ucw0KPiAgIG5l
dDogcmF2YjogTW92ZSBkZWxheSBtb2RlIHNldCBpbiB0aGUgZHJpdmVyJ3MgbmRvX29wZW4gQVBJ
DQo+ICAgbmV0OiByYXZiOiBNb3ZlIERCQVQgY29uZmlndXJhdGlvbiB0byB0aGUgZHJpdmVyJ3Mg
bmRvX29wZW4gQVBJDQo+ICAgbmV0OiByYXZiOiBNb3ZlIFBUUCBpbml0aWFsaXphdGlvbiBpbiB0
aGUgZHJpdmVyJ3MgbmRvX29wZW4gQVBJIGZvcg0KPiAgICAgY2NjX2dhYyBwbGF0b3Jtcw0KPiAg
IG5ldDogcmF2YjogU2V0IGNvbmZpZyBtb2RlIGluIG5kb19vcGVuIGFuZCByZXNldCBtb2RlIGlu
IG5kb19jbG9zZQ0KPiAgIG5ldDogcmF2YjogU2ltcGxpZnkgcmF2Yl9zdXNwZW5kKCkNCj4gICBu
ZXQ6IHJhdmI6IFNpbXBsaWZ5IHJhdmJfcmVzdW1lKCkNCj4gICBuZXQ6IHJhdmI6IEdldCByaWQg
b2YgdGhlIHRlbXBvcmFyeSB2YXJpYWJsZSBpcnENCj4gICBuZXQ6IHJhdmI6IEtlZXAgdGhlIHJl
dmVyc2Ugb3JkZXIgb2Ygb3BlcmF0aW9ucyBpbiByYXZiX2Nsb3NlKCkNCj4gICBuZXQ6IHJhdmI6
IFJldHVybiBjYWNoZWQgc3RhdGlzdGljcyBpZiB0aGUgaW50ZXJmYWNlIGlzIGRvd24NCj4gICBu
ZXQ6IHJhdmI6IE1vdmUgdGhlIHVwZGF0ZSBvZiBuZGV2LT5mZWF0dXJlcyB0byByYXZiX3NldF9m
ZWF0dXJlcygpDQo+ICAgbmV0OiByYXZiOiBEbyBub3QgYXBwbHkgZmVhdHVyZXMgdG8gaGFyZHdh
cmUgaWYgdGhlIGludGVyZmFjZSBpcyBkb3duDQo+ICAgbmV0OiByYXZiOiBBZGQgcnVudGltZSBQ
TSBzdXBwb3J0DQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjlhMDhnMDQ1OiBBZGQgRXRoZXJu
ZXQgbm9kZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IFVzZSBz
d2l0Y2hlcycgbmFtZXMgdG8gc2VsZWN0DQo+ICAgICBvbi1ib2FyZCBmdW5jdGlvbmFsaXRpZXMN
Cj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IEVuYWJsZSB0aGUgRXRo
ZXJuZXQgaW50ZXJmYWNlcw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNv
bTogR3VhcmQgRXRoZXJuZXQgSVJRIEdQSU8gaG9ncw0KPiANCj4gR2VlcnQgVXl0dGVyaG9ldmVu
ICgxKToNCj4gICBuZXQ6IHJhdmI6IEZpeCByZWdpc3RlcmVkIGludGVycnVwdCBuYW1lcw0KPiAN
Cj4gIC4uLi9iaW5kaW5ncy9uZXQvcmVuZXNhcyxldGhlcmF2Yi55YW1sICAgICAgICB8ICAgMSAr
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhnMDQ1LmR0c2kgICAgfCAgMzgg
Kw0KPiAgLi4uL2Jvb3QvZHRzL3JlbmVzYXMvcnpnM3Mtc21hcmMtc29tLmR0c2kgICAgIHwgMTc3
ICsrKy0NCj4gIGRyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDhnMDQ1LWNwZy5jICAgICAgICAgICB8
ICAxMCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL0tjb25maWcgICAgICAgICAg
fCAgIDEgKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiLmggICAgICAgICAg
IHwgIDQwICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZW5lc2FzL3JhdmJfbWFpbi5jICAg
ICAgfCA5NDcNCj4gKysrKysrKysrKystLS0tLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVuZXNh
cy9waW5jdHJsLXJ6ZzJsLmMgICAgICAgfCAxNjQgKystDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDk2
MCBpbnNlcnRpb25zKCspLCA0MTggZGVsZXRpb25zKC0pDQo+IA0KVGhhbmtzIGZvciB5b3VyIHdv
cmsuDQpJIHJldmlld2QgdGhpcyBzZXJpZXMsIHNvIEkgaGF2ZSBubyBjb21tZW50cy4NCg0KUmV2
aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


