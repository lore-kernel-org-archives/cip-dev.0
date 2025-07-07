Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21958C83030
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 20:50:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.3135.1751921418900870256
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 13:50:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=DDku7PZk;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1751921407;x=1753131007;bh=Pblx+ZJxU4y76b2S25iVW5aGrYI24YbPm5xguK6
	VZ3E=;b=DDku7PZkuz0wYLBlx8FsCW9rPa2aNa2d8dc9+nJCgGbZ6Z9APEYUTuuWae9gYnpuOlK53
	l8YGiwJacN2SqsYvcKkQhvLJcBaMSFksVJ+VW980z6/aGVgsWHoJrJ06l856cg4cdBi8M5bHGKSSr
	5Iq2LiAX4Uiy+MpFrbPQQ0RO4jSxMowCpdJsyC+5ldPzpMUtM6J0FY+JGE2CcEfWvwMZyJES+swD/
	gpn2KHOsBOSMm6dV+L2fSRSCRdYb8lz/5kq66a4CfRKwuiykr6EF4jpeymxi34e43O2+pQ788DpNl
	3bLTPtqQhCMSIx2HAV+NJupj/Vvrp5/yoUSRVt/y2A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 567Ko6PD512363; Tue, 8 Jul 2025 05:50:06 +0900
X-Iguazu-Qid: 2yAbaKzOjsevZeBagz
X-Iguazu-QSIG: v=2; s=0; t=1751921406; q=2yAbaKzOjsevZeBagz; m=vfk245199SNDfs+Z1BPT5H6yvKJoUK3YJ5dzj+ojqLA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 567Ko4633689610
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 8 Jul 2025 05:50:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntu38vKes+chIM/PkIYaWe7RGX/m5FgSrpRixwGoVE+Ciz0Iy523nQ15TkwTD/IRe8i4sry025eyHCiy0QhfapH7kMXeyvUNvooOoaf8iSifbSqRMhn8nTh5AjzW5s78/+cG3Vz1XZhjA0C1CGwreyDO1UlRLkIkj+Aiq85m563k1KSwwKk9iyVKbw0jS2xIpOa64NFE7xA8WocSAWvlA/6hQV24AfG7k5TS4PQQEt6yWzxbReFSFbh7Hq6XQz0OqnvgOjX8F02dGqXHPh94d8do2NekIZX9RfmI2W63RGLEF32QtCFEE73Pu7z8Pm/5TkUXtL+XQC40paW/UFw6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkFGMXlOCjsqyp3uuIkAVqcLxfRRS0xXxJ1VcAuOXR8=;
 b=EweFzJXmYGuD/ZSw+FV2Dr3sOGkYAU79/08SQaJ81qs0eurEAIrZQMXeN23m4Ogou2ZTeg12bVkuh8rWg74R0A8LZroxKAI3BeGaP2Z3ZfEHRRcOxJpfi0z36zTzfOc2w7GqnOIhDZf4IPhEioFDHceKK6GR6uMiBPrg1oxAuxBhbaAXLuI8qeyOuEWdRTEoe2LIOxq8mG0b9Ff3U/dCtG4aFd9Z2S7EpdRNuxXylXvj6ozKrPHphweaAWpLyxFL9s0O6v4vo+6x+GD7OA54O5JIAYHxnzN53ZcU25Ec06mlP0IFbqTxz/ZPWkKccgZ/afeFe+2VlCTkVYUvLn/CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Testing -- plathome_obsvx2 has problems?
Thread-Topic: [cip-dev] Testing -- plathome_obsvx2 has problems?
Thread-Index: AQHb7yanKyVAJF1jIEOW5+D3TNVs6rQnId2A
Date: Mon, 7 Jul 2025 20:50:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CE73D1A4198D3C4C9745924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <aGubmZMZYf7Ww9EP@duo.ucw.cz>
In-Reply-To: <aGubmZMZYf7Ww9EP@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13698:EE_
x-ms-office365-filtering-correlation-id: a7cfa17d-b548-489a-ba43-08ddbd97d790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NjIwWlh2c3AwQnVzMU9Ic2lMdVExKzlBL0Y0SXdhOUhMZ0xOaHRmU053?=
 =?iso-2022-jp?B?d1dHN2t3V1A5VlcvSnIvSmcrM21WcDAwVEpZWGF0eExacDVMQXVTMy8v?=
 =?iso-2022-jp?B?ZlcwOC9xaGlnUWJQUlhkSStETDN4dmZ2Mm1WVmNKVE5CVWdlMi9sNXJN?=
 =?iso-2022-jp?B?S3owTEtNUEMxMzF0STZaV0ZSUk9nTU1McDIzNDZkVkpzdWdkWmNIQXhJ?=
 =?iso-2022-jp?B?azNTV2drWUEzakRCUkQ4QVZVb0JGN0l5UDFjR1NZVVlwMTh3TEZPMTR3?=
 =?iso-2022-jp?B?VDFYbmxMd3VWbStmZEhZbTN3ZlBEUnBjSVlDT1JrZVBCWmxqbXBSUlNp?=
 =?iso-2022-jp?B?ZHp6NUVNejQ4OElOSXlCQjhtM2VGWnFGZ0g1cnJ1eXM5VFB2UDdROFhZ?=
 =?iso-2022-jp?B?ejA2ekg0Qm0xT3RBd3FJeE04Yk8vR2p3OVhVNkI5SGttU1hSQ2N0N0NB?=
 =?iso-2022-jp?B?dGJXRXIzZkxKNzA0N3dFOXhHR0o1dnBDL3NSaFhwWXZCaGRBTmhRYUdH?=
 =?iso-2022-jp?B?RmhrdGR4dEsvV3BxaTRIWldBcGRqdWtqd3BNc251bGMxdWtvSjhoR08z?=
 =?iso-2022-jp?B?QUF5cm9kS210eUZia2VseW9LZ2dmY25UUmVES1NqRGduQWRJbjZDZ2tk?=
 =?iso-2022-jp?B?VFVkdmlCa2dlSDZ0RUdUdlpod2YvMU5Xb2hscnp4a1Q5TWRhYVQyeTNL?=
 =?iso-2022-jp?B?N0lUTzlOWEswWnpkN0dGc3lZcGtXV2g4Rmw5YjBUSVBNRktRd05Ta1RJ?=
 =?iso-2022-jp?B?SmhvY0pERUk2R3ppSGxqc0ExaC9DZGh6UjlnbERaTVpYWUxHZFpYSnJr?=
 =?iso-2022-jp?B?aG81R1c0TzJtVWRwRkxKMjZ2ZmZwTUYxNTNqS2cweWd4MTIwV0cxVzRN?=
 =?iso-2022-jp?B?VkNNT2taam5WblJuTUZOcmR3cThKakJGRDMvTHZiUE4rYS9ZVGhSOUlp?=
 =?iso-2022-jp?B?NlNQazhSTkx4RTQveGczaVk2YzdnSXZabTZVWnA4Q21qemFBMGt5c3NH?=
 =?iso-2022-jp?B?S3kxZk1NdkFUazJBVCtjbWN1Yit2bUs3RzBlb09CUjR6aFdzeFliN0kx?=
 =?iso-2022-jp?B?SlUzNmVVazYxY2Y3Znp5N3NMYU5XN1gzdE5lV3VqMER4VWhHQjZPSE1i?=
 =?iso-2022-jp?B?c3krdEFENmhPdHRzS3hHVXZmV2NIYVlLVjdpZlRuQXFxd3YxcnNjMWc0?=
 =?iso-2022-jp?B?Zit0OWwwR21XbFFHSkNJRTI5emI3Zm54eTdGMm9saFpycGJ3Um5rYU5v?=
 =?iso-2022-jp?B?S0tnUkppTmZzRlBxRGtoZ3duckZIbE1pSE11Y3ZReTBOc3FzaTFUVkx1?=
 =?iso-2022-jp?B?UUpIajZTK1BmL1V2TVNRWWlFSTVYaWRWeGpNWVVZTWh0S3hvcllmM1p2?=
 =?iso-2022-jp?B?WHZYL0ZNVm1zOWdTRzEzMnZxN0hrMkFRNWtJVlZSeSsrcGg1WWdYU2tl?=
 =?iso-2022-jp?B?c01OTzVFYU9uMldHellWQ056L2F0VTBtYklCTi9BalJwKzZQZHZHYVVk?=
 =?iso-2022-jp?B?M0F3d29PNCtlblBIaU1nbGswVSs5S2p2V0NPZksvYVpIeXZLOTZGbXFo?=
 =?iso-2022-jp?B?YTRkTGcwQnNleXpuQlV5SXNaL1ZmdTlXNzNtUCtYd1R0cW12TVRuQzI2?=
 =?iso-2022-jp?B?ZTJyeHlicFhtNi9ua1hyVmtmT0xYNmlvYXJhcHJTajJ0d0NhN0dnbW9Z?=
 =?iso-2022-jp?B?V2g1TEFpK2VQZTNOT0F1ZEZENEl2WDIrWlFKalQ0emp3cUhCNXRjOVNU?=
 =?iso-2022-jp?B?aWxrdHlndkpodkx1TGJTUG9qUDlqUTY5Q28rUW5BSElLb0wzb2ZTMy8v?=
 =?iso-2022-jp?B?NkJVYkhSS3RrU2ozaDh1SlNKVDVnRzZvU25vMEVlR0hGcGNaOUdMd3Bv?=
 =?iso-2022-jp?B?aWNZZkZ3Q1hSSFRBQllMMkZSZHRNaDRnS3ZncmRTa1RzS1huM094SnJT?=
 =?iso-2022-jp?B?aGVyb1h2MSsyQVloajFOQWRJd1IwT0E0Q1JrUDFla254S081S25GSTNV?=
 =?iso-2022-jp?B?SGpLNWZtMTdPUG9USmFFOGdkS3djT04vZlN2elkrZmVudmxvNEdJdzZZ?=
 =?iso-2022-jp?B?NGN1em0renpNTGI5eEZ3NEY2VXE2eW89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?emxwQnUvOGVTR0lYeHhHcWdISFFnSkszZTROWU1UVXVzaFJnck1iTExL?=
 =?iso-2022-jp?B?Vm5CN3Y4TUlIcWdxNlByZ0VqSmtZSkdwQ2QzWTY3YjdlendoUUxNZUNz?=
 =?iso-2022-jp?B?MUVQOFdCaFN5L2Mxc0hUUkdWWHh6YVdNbVZVaFE2TkdCdUdTSEtCMkxP?=
 =?iso-2022-jp?B?ZWl4SXQ2K2UzSFhYNDRseXZnMGw5bHJjbTMvYkp1cTR5SEtodGxOa083?=
 =?iso-2022-jp?B?ZUhzTEtCQWFwQlcvaEorNW5HSnpkWld4WW83MFdGcHFpdHZsLzBJZEs0?=
 =?iso-2022-jp?B?WDFjd3E3ak0zTlcvRUtqVUE1K0M5MFZ6a2lRcDRwR0V4bDZDam5XaEx5?=
 =?iso-2022-jp?B?UWlMbGhZeG5KdVhMR3g2UEdxYnEvSG5zdUQvU1Y2b29MN0hhM0xOM2ZP?=
 =?iso-2022-jp?B?emIvUm1SREx0ZTZnVHlxTm9uek9iUXE1djRGeXBVeTFlZ2hGWGNzK2M0?=
 =?iso-2022-jp?B?SDVJa0F5NnZLek00eGluenVNZ1I3SmtRcUpUSVE3SUV4UjQ5RkFnY0xV?=
 =?iso-2022-jp?B?VzREcDhYSmdxa2ZGOUlGOVM3aVdRVW0zUmxpZyt4L2pVTFY3SmhqYVFV?=
 =?iso-2022-jp?B?TmlTei96eGJZcC9DaDFzeEF4U3k2cXRtdXJLSFFneTk0aHB6R3R3bXRO?=
 =?iso-2022-jp?B?NzYrdm9BUENtcjU4RWdZQjV6ZmFBMW9MaEZlR2lYbG9QbWlMTk4vNWIw?=
 =?iso-2022-jp?B?bkdGd29aSnAyakk1Qmt6ZG1lUHRVU2FkeHRKTVRsSE1ZSk9xT0RPUWM1?=
 =?iso-2022-jp?B?VlRJQ3FlTDlnaFlQd2s1VHlabEJJQjRIYk9xMmpoZ0x5cnovOUZ2ZUd0?=
 =?iso-2022-jp?B?MUdpZkhZRk5WZ01ZdzdwV0hVUGk0TG5lR244ZEEyMzk5b1FVMFhNN2dp?=
 =?iso-2022-jp?B?QlUyR2dJOE1vTkZxS2xVQzNlUmlrd3FJOHRJMWhHQy9FcUQ3N3JDNUxl?=
 =?iso-2022-jp?B?c0xUajlyNjM5SGI5M1VHQ1lQa1hMTVJaQWxJRVkzMWhXenUzQjhXOTcv?=
 =?iso-2022-jp?B?eE93Z0ZhMXA0NnpGU2laTTNsQlNERm01bVorbVFyQkYwZC9uMTBYRHp2?=
 =?iso-2022-jp?B?NzRZM0duN01EaWNaSlJZZjNscnd4Mnk2TzBTdlVhcnpMeTZoeTBHL3dO?=
 =?iso-2022-jp?B?SnpHN0NBRmhuTENXT3Ayc29FL242YlBGWU4rNnp4czJXZDRnRUR1SnFt?=
 =?iso-2022-jp?B?cjZOVlF2cEUyaDJ1dWlDWFBJb2Q1bHVRUUZSU1dhR09Jb1gxbnl6SzRD?=
 =?iso-2022-jp?B?WkZ4MVZULzlYc3g3N05NVzBWUmlsYktaRG82cTNEQlZJZWx0dU43S2p6?=
 =?iso-2022-jp?B?L2dWRW1kd0p4MUNFYVhZYTRvVzZ2VERrQ0N3Tno4d2poZU0zNDFKSE9I?=
 =?iso-2022-jp?B?a0xJN0wyS3Jtc1VXMUw2RVNzUTFmNGw0cXZLT3BZN0RpUkVCb0tLYW56?=
 =?iso-2022-jp?B?dG1NZ2NsbC9qZkFtWmk3b1NXMjgrN09ockt0ajVSL1hZWE1PQ2dTQ25Q?=
 =?iso-2022-jp?B?NndWS0YzNEhoUnFsSmwrNU40R3NrVzBmdlZ6SitwQ2JnSDgwbHFmYldH?=
 =?iso-2022-jp?B?eE9FT0RnUWdPc3NVUG42SGdwN0N2V3lSOFUwclZIOUhjcnh0bmF6ZG9Q?=
 =?iso-2022-jp?B?QVZvUHUveHpRa2haUU5ZUmwzMWNmUWxVM0thNzNXQVB2Ym5JK0pEb0tR?=
 =?iso-2022-jp?B?U0VMMkhKYXZiRmdwY3JaZWlsU3ZMN2xwQVdBQlVyTUVIeUZoRVJNZkFV?=
 =?iso-2022-jp?B?UXd3c0xFN1VrSHJ1Nng2SnVuNXBOazgvbGZkcFJQTzlieWszdjQ2ZnBN?=
 =?iso-2022-jp?B?enZ4d1RONTVDc2l0R1RGM1VrOVpIYWNiUnk1bk9nbEVEOHNhZGg2blY3?=
 =?iso-2022-jp?B?QXhaenIrL1NQcXA5L3NOZys0YWp5MFYwWG9yMWR1aGxrejUxQVVETU8x?=
 =?iso-2022-jp?B?TUJjcFVxbDE1YTRpNXNSRCtCN0w1MVBJNUNIbmwvK1FlSHNSWWRaMHJF?=
 =?iso-2022-jp?B?bkNucUN0dm1sYjVodkQxT0Q5Qi82TUtVSFlXWWRNT0tUd01BWUhXMTQ0?=
 =?iso-2022-jp?B?MTZ0VGZFTTlJcUNIV3NEZGxVOVR5czdxc0tEZzBoSGloQXZZUEtYSFZP?=
 =?iso-2022-jp?B?M1pBZVduTkRBa3VLMFp3NTNxZmZoTjBhU3g2M1l1N3Q3MDlzTS9HdUYr?=
 =?iso-2022-jp?B?WDBONkhRSTlYM1ZFeDEzeDRXR3lNbnRoYTM3MGZOQ0h4dUNtWDBYYzBz?=
 =?iso-2022-jp?B?UVZ3bS8xRUtTMTF5NXl0TjkzNlZQN01NVnc4L0VGV00yVGJ2czByU1Vx?=
 =?iso-2022-jp?B?RWhvRmdDc3ltc2VQQ1NTTE1ObmFoSnVvQ1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cfa17d-b548-489a-ba43-08ddbd97d790
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 20:50:01.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez0RQDc2tzomGvbavS4vMejMNBqcwhfSk0TKnY689P4uhodjhZc0K/BxxI1njvHEFVVbsAGFnJIEM/OB2zmp3AItN+9WwgSQ9RNPYCTA5Wz27cMPwBzijLVaSXylLN1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 20:50:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19386

Hi,

It seems that openblocks-iot-vx2-02 has not been hardware reset and continu=
es to work.
Therefore, if the test is run on openblocks-iot-vx2-02, it will always fail=
.

https://lava.ciplatform.org/scheduler/job/1288792

Chris, could you fix this ?

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Monday, July 7, 2025 7:04 PM
> To: Chris.Paterson2@renesas.com; cip-dev@lists.cip-project.org
> Subject: [cip-dev] Testing -- plathome_obsvx2 has problems?
>=20
> Hi!
>=20
> I'm getting a lot of failures in -stable-rc testing... it looks like
> plathome_obsvx2 is always failing. One example is here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/190
> 4974561
>=20
> Newer pipelines just show it as "running".
>=20
> Is it okay to just ignore that config for now?
>=20
> Best regards,
> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany


