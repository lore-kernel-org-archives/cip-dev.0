Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C1C3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 07:04:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.27944.1723014254705143470
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 00:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=hS3j4tzM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1723014238;x=1724223838;bh=tfRie7mCkA5LmFBZh+jqUhgCmZMBW3Dj9oWC554
	wEVQ=;b=hS3j4tzMI0f6EUyziDsQjqCGXv5H9rPMuC//XLx+qy1jueE0WYwkTZv1y4Gw3ytOE/Kdq
	JO2FSIjyPIbt5seyUADzALnHBW94ynbGR88Km+iSeLBZhkclmBP3jkq5aMuqjWaPKztlDnUnsuhqh
	TEIjpLv5pe27ZM86oQ8TLiDU+cTxGqi6q2FTbVs9M4V6OPmeZ/qiYJIPulXxs6wb1Gn6vj2iZ4r13
	WjqcSWBSGMFdu5YYOeP2tCSK1jEeAbaltUuXda5GfKQVdLNenZ9Zfb8m+mxJ1VKWnAiI2yZbJdlie
	chLUh1xB2DfkodOnPOimXb0LLOsSvd5cDHtetHlbFw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 47773vnd3453607; Wed, 7 Aug 2024 16:03:57 +0900
X-Iguazu-Qid: 2rWg67yer2yclnrloW
X-Iguazu-QSIG: v=2; s=0; t=1723014237; q=2rWg67yer2yclnrloW; m=j1VWm3zDEqk3XhZvvSRsgJE9tjeHrVLNaj/1vDiJ7D4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 47773tiE393964
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 16:03:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0pIuaagMxbeh6vIxWnWtDrTA/ITYYHvTJHt4uyCjje7sfF3OgAbJ65UqAnPgvBh7Fof3DEvkkUeMhAB76DG6hC4vc/KXsPW7DGHsUYTy0dvUvoKQ9rWtl9MAgZEw0ZhcwTQH2EbR7qgMGjUs6893Fc/yJ0qGd1Lgp5ylR7qmmZWB3lOhFtxlETh+KawwIZitbPFVLe2JwObOl/jgXhySuo1rKYcuJREtZCi+ANJZdJF6p4eAe7Jv9mkz540uLAF2rskZNs07qf5tm1Xr2Rojt45bt+PgSpxAs4d0KQs3MpMWaRaJ4+ml7Lpnmqud7V92E9kvI9/EM6i+1AcuaNJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14w0Vyn77mQ3T5X35xEf7Qv1fKPTQX/hdfpcghrV+wI=;
 b=whK7snsOmK27enVn5WEBi+T0owVaaB6jcIrPXhFMtaDwz9neVooR5Jq7KhbwZ2E0Goizac1HETya7VVfxxlJAfSRYI1bOhRQ0IiLyibtHBoEVWZiXoL9aodcPGjYytj+YKef60kAyTCYtUKGCb9eeG64dby51RDDGusX+FUOejdZTZCTO2qdPoFvvF2rkM+7bLQd4Rm3Lby0wU6wW5Xsm/ETSCf8vnwE/mXsbNgvmm71EkL2RUVxDduNqzdJbHnw7a3L9Aoqm5dZDoTcVLsVwZOfUkC76K0VKNlBkrgO7HsrzSAp0tIXv08id5iOt811FkpZFTjPOhMeoY4b+3w3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L}
 Camera Data Receiving Unit
Thread-Topic: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L}
 Camera Data Receiving Unit
Thread-Index: AQHa51apKn7WFzCyikeWyZX+55phiLIbYI+A
Date: Wed, 7 Aug 2024 07:03:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63883C1108CBAA81E8063BCB92B82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB10361:EE_
x-ms-office365-filtering-correlation-id: bb4aa799-1690-4933-cfa8-08dcb6af18a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cFlPWEpXeTY4R1BWMkdSVUtNdmwra2lWOVZaT3Zha2htcUNuMllxSVRv?=
 =?iso-2022-jp?B?azVGTkI3d0xDTkloSFFYczZUNUJlOTNFdzhBSE1HaHhiRG43M0QwNGd6?=
 =?iso-2022-jp?B?QU9keGRtcmlvT09TZzdDdFlab2kzSUJ3WU5Gekc0TjBBc3JKR21zMVJk?=
 =?iso-2022-jp?B?UTBRYkxyNEVTQ2puZXJ2Z2VLNXNxYndCT0xYdy9NMnoveVRDYzhTbUpD?=
 =?iso-2022-jp?B?SThDYkVkY1NvNmN5NGwxSHVGOXZQaHpYeXU4a3lCNW1WakpMeUxNSmwx?=
 =?iso-2022-jp?B?TWh5djdqV1RvMUNzNCtkTFNiSjlNSjE4OTFJZ3h1R3FubmZKdzNIV3Jn?=
 =?iso-2022-jp?B?djA5VnhYeVNQSzRTdzFHS2llak1QY2d6L05tMzBhTkhrZHRTWkFTdDRE?=
 =?iso-2022-jp?B?ZXJHdlB6OHJkeWVNcUlCVjJrSWd5SlYrY1JmRmd5R1luL2hWMmU4SHF5?=
 =?iso-2022-jp?B?RzU5TFVjSjlUVTZERWlsa2ZkVXFxVkF1R3JkRDBUNDN5Mmp3NThGKzFM?=
 =?iso-2022-jp?B?RTVweTJRMmZWbjE4K2kraHU5NE4yOHNUaDJ6aDU1RXhIUU9QVVFPMnZr?=
 =?iso-2022-jp?B?NHdjQnMwQm1lQUp0Qm9CandaU1NFeWQ1YkRhOG9qb2M5blJ3ZkRQZ09i?=
 =?iso-2022-jp?B?Nm1PYXRzd0k2KytSWDhkalh1c241M0Y1dXl4cm1jb05KUTFsRjFiMGR2?=
 =?iso-2022-jp?B?SEpUbEg2V2lGVW5nci90YmNvVWpjazZocVo2bjVaajZSK3JMOWsvV2k3?=
 =?iso-2022-jp?B?ZitEcDBrdzNTeEVHSGdJVDFGRnZaVk5rR1NWOE5jdUJoT0FuMEZ3YjZL?=
 =?iso-2022-jp?B?M3ZJWDdRd2t1RVg3QjFjZFdEVXRvY0pUdEc2ZlFlWm1YWUNIa0RXaWFj?=
 =?iso-2022-jp?B?NmdGV3dIS0JXTEpweStyNXUwdXVIdkhuQ0tHb2RScEFQV3VldXg4RTJK?=
 =?iso-2022-jp?B?U2JZbC9md2lIL0xyRXMvR2hTUnUxZW5DQjltdlVoY1ZjN2JqNGgxVlFU?=
 =?iso-2022-jp?B?SmFQdERDc0ovYmZHeEMwVDVVM2J5YmhJWis4citjbWtUK3hFa09CZkps?=
 =?iso-2022-jp?B?YnJyVUdSSHNtR3VsUktabHI0L2pGektQT2ZXYk51Q1EwTXUzeklIaTQ1?=
 =?iso-2022-jp?B?Y3VWcGRIMjQ4QjZMQmVFWitGUHFHWGxHRVBITEJJd2thL2UxQkpERTVK?=
 =?iso-2022-jp?B?UEpoZjNsU3NHcVgvbitGL2MvT0NsU1lmQ0FYZEdObU5lYS9sTlI0QkZR?=
 =?iso-2022-jp?B?Q3lSTW9wZDlFZFpyaEdWYkgxQmZhVU42UElKaVRtbG9qVGVKTXFrMFN5?=
 =?iso-2022-jp?B?UGhxY0ZIM0NTMTBBSCtENWtzMlYwQ0puZUVOaFZBZHNFbFBQTXhMRUhk?=
 =?iso-2022-jp?B?dHhhWGRDMHU3aWNuSGg5aHpRUHJucEdKWVNRbHF2Z0xhZ3dNSFpERExJ?=
 =?iso-2022-jp?B?QTJlbEZNT0RYQktMeXBtSUduTVZ3KzJrdC9qL3FuUnBpeDFsMlo2WStn?=
 =?iso-2022-jp?B?T2JTRXA4cGg2TkthY3VOdTRUd2N3YmQvaVZHM0gwRkxhTlVMb3NVdmlj?=
 =?iso-2022-jp?B?d2t5a1VKOVhNZm4zL0ZacXFMamlzL1MyV1ZLdzVHbllscTYxNzNBOUlB?=
 =?iso-2022-jp?B?T21CSkpGWEs4TkhXayt3d0RnY3gxY1JucEJsMHhJamV6OFdoMTNzOE4v?=
 =?iso-2022-jp?B?RXkxTHV1eWdDZ2daNXRETHhXZXpPS3hpcXhFNk0zTzV6cUZYQmFQVHBF?=
 =?iso-2022-jp?B?Q05vbjFBZlFwOTJTbG4wQjBROTN2ek9rcEorQTJTWVFxQTRWQzZTQjZ1?=
 =?iso-2022-jp?B?OUZHWlZBbGxMM05xWTUvZEFuVXpRNktLYUo2OGt6eFNIZDBkODJsWStU?=
 =?iso-2022-jp?B?azNYVGdndm1ENHJFVzVxb055MDRhaVBPTDdIRFA3WGxqUGM0ano1aEVl?=
 =?iso-2022-jp?B?ZWI2ZWttTWF6K0w0OEZKTmdLbjc0RVJNUExPZlA3MndpNHEwZktyK3VY?=
 =?iso-2022-jp?B?NnNNUDViS2RpU2ptdGc1ZGJmTFQ3bDFqSFhlNHdOc0NMamRidjdGaHJV?=
 =?iso-2022-jp?B?VndGT1JoTDVHMEF1ZWxoZ2psbzNGRFBFa3d5cXJNNjlmTnNQQlYwbnBX?=
 =?iso-2022-jp?B?clE=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R2ZGa3lDU0dvYnBCS2RqN2RXdU96WUxEd2hES1ZNN01lNEJaU1BLR2l0?=
 =?iso-2022-jp?B?bWRqbW4za1Y3eERJaGY2cnoxY1NRSFAvUHZIL3A3a3oxaUJKSmhWb1RW?=
 =?iso-2022-jp?B?TlV4cUhvdXJVWEdQbzNHZDQ3ZFIyNXB6M3RXd0k5NWU3RCtGUlp3MFdT?=
 =?iso-2022-jp?B?aTFDWU0vdks0T05vK3lkbndSK3dwMHQ0N0NXUy9KU3JZMFBMZHdyV2RD?=
 =?iso-2022-jp?B?MlBGcG82UkVheXFBVmdoMGo3c2tqSlBpeThXdHZVUmFQNzRkUTdtYXFt?=
 =?iso-2022-jp?B?VmxUdFNaVWd5MDZJUEVZZ1hEL05vN1F5NGw2aTA2QTlhRkhRaWJBYjFp?=
 =?iso-2022-jp?B?d1FWSlN2T3lxYTZ3THpobGhZNkI4UmR1UEUvT2Q4Z0wvSDQ1cDJCdGFl?=
 =?iso-2022-jp?B?VzMyekcrdDYycDRMcWkvdyt5ZEY4ZzRwODZ6SE1pNTV4Wi9UWHlIY094?=
 =?iso-2022-jp?B?aTFaRmw4Qi90bXRuVUZsaXhXKytGRkNrTVBYc0xLcUtZZHUvTWZ4bUF1?=
 =?iso-2022-jp?B?Uklrc1dYNWxLSXpMeHk4eVVUL1JEcEN6YkxzWmJMQmdtQWxJTWdMaktL?=
 =?iso-2022-jp?B?NEYvNFFrWHE3MTFkNDB3empXSzJISmZ0WGF5ZUJjenlHa1RVdnNMWTZB?=
 =?iso-2022-jp?B?Q3hYSll0QkZ2RlRRY2p5M1JkbnZQV3pVS2Y5akxYYjdQdVNyb2dxWTAr?=
 =?iso-2022-jp?B?OVVkdmxEUkhqWmtGTHBLRkdDbU5YSlNVMTN1WG0zVkJ6NG1QSUI2NHAz?=
 =?iso-2022-jp?B?ZTJoUXpJaklLTGtGNEZYbVMzRGhybm8wTWtrUngxOThEbWhybnpKdmZ5?=
 =?iso-2022-jp?B?MjkrdmU4Nmc1YnBFZWVGU25RdFZOSTFLNVQvcFJST1c5bkNzUUkwSmp2?=
 =?iso-2022-jp?B?R2s5eHhHRmNhclZiZ3F4NGZGcjJWeFpCVEZ6OVVPc252ek1MUDQ3U1Aw?=
 =?iso-2022-jp?B?aW1nV0hjSEV4LzJNZXJyQWFia1M4Rnh1allmeE5iNzQ0VUxheWU1d2FH?=
 =?iso-2022-jp?B?QzNLbnViREhqVWRISXVmZUNEMG5uVVhOVkttdndlMGNCcUtwSVh2bThR?=
 =?iso-2022-jp?B?VnUzM0F0a1NERzEwSlRIU283d2tQalBoMktOam9ER3k4N2s2Z0xja2Nw?=
 =?iso-2022-jp?B?R1Zxc1NDS1FzZDE0VUo4TWNuTFovYklOdEhBNjR4VlBxN2h2a3dXckds?=
 =?iso-2022-jp?B?Sk5qOFRiZlY3a1c0Z0JLOHBEcGRDZnZ2VTgwWUlBZGhuY2loVzlIdjFG?=
 =?iso-2022-jp?B?RU1KWTkvRzRoWXpqVS9XZXhiT2IzZHFaSDF1SUlFd21mRlRiaWF3MGpP?=
 =?iso-2022-jp?B?YWJjczR3bndnUGJCNGRJajRWT0RScll6NmFaSjQ1L3g4OW9sc1hpek9k?=
 =?iso-2022-jp?B?Wmdja0pESnpnS2VyRFIxZXBpbkNRdHFua1hvdUhIMVhTemljWTRTVmtq?=
 =?iso-2022-jp?B?WERUaVNjL3ZJZ2lPcmNGd1V0T3V6N1REN2JjYTJJaFBpeVkwTTZZMnJw?=
 =?iso-2022-jp?B?UzE4UzV2andRY3FBSUlZWWUvSWxOK25kdHBMUHBWbEVuNzUrRGpOakR5?=
 =?iso-2022-jp?B?SjRZcDdzTC9BRmJvd2hjR3V2Ymo3Q0FBMGZVcFdZcW1uK2sxS2Q2SWR5?=
 =?iso-2022-jp?B?N0RDS0JPMzBiVU9tN3FDL3p0c0tlNnFybVJkSXNXTFZVUi9kOWFmQm13?=
 =?iso-2022-jp?B?b2MzTXZCbWhSMTVvcnR6N00xeWs4dFZIdE1ucmJyNkwxSWhNRmI5c1FM?=
 =?iso-2022-jp?B?YzdrUnZlRHVvQ2s3Y3BycWV2WkU2VGUweEFVUmNtNXZUNEdvbGZBNUhU?=
 =?iso-2022-jp?B?cGZsYjlKVXhoSnc5VlNUQnpwek5WN2dvSUE4VEY0Yks1bHFkZTh3d2xj?=
 =?iso-2022-jp?B?WUUvSlZlY2pYbjBFZWdXcE96cmJNUkx4VUdoVkxka3ovd2ptQmVMRVBQ?=
 =?iso-2022-jp?B?NDdXbDNlekVQckczWVZWZytYVE9uaWpiQnd4Wm5FVjFUYnB3TVZzWjFD?=
 =?iso-2022-jp?B?ZjB2VEJBZllOZXFsRmpyKzN1UUxqWUpXYklwRU1tNWR4aUk1cVp1Tmhr?=
 =?iso-2022-jp?B?SlpJUmxJNitUVGluVmUxOTdhV084U1ovZk9pSm82YVZKd3NmbUgvSFpU?=
 =?iso-2022-jp?B?VUNBNGNRbUlWOGU3cjR5cmVLTW1BZnpMbEV1ZEhVdFNMZUFUYzF5U0pM?=
 =?iso-2022-jp?B?NXVBcmJZWENzTmNhTXZxRG9ZOHhnL1k1enNSZWY4Mm9UcXpKQm45OVV1?=
 =?iso-2022-jp?B?STdHTWo5eWhxR05HTHZzVUYzOVVMSFh6RlRJUGlFUFoyb2xMTCtiSFNQ?=
 =?iso-2022-jp?B?bzJsY2M3N3hKb1J6dnl4QVh5TkFQMSthekE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4aa799-1690-4933-cfa8-08dcb6af18a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 07:03:52.8567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMcnUA4chAM/aKvm2HkIvzh0nii77T3SgjWaNLN7LtcC5L/Dj+X0Od/Sp8lhDiMCAXuTl8AvAbLubq7ZwOdZ7dKxXQqXRRswm+E17wLk5riW+UsBNK6VMnp4NhRual81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 07:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16755

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, August 6, 2024 1:43 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L}
> Camera Data Receiving Unit
>=20
> This patch series aim to add support for RZ/{G2L,G2LC,G2UL,V2L} Camera
> Data Receiving Unit(a.k.a CRU)
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (11):
>   media: i2c: ov5645: Remove software reset entry from
>     ov5645_global_init_setting
>   clk: renesas: r9a07g043: Add clock and reset entries for CRU
>   media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
>   media: platform: rzg2l-cru: rzg2l-ip: Add delay after D-PHY reset
>   media: platform: rzg2l-cru: rzg2l-video: Fix image processing
>     initialization
>   media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
>   media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedure
>   media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2
>     block
>   media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU
>     block
>   arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
>   arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
>=20
> Dan Carpenter (1):
>   media: rzg2l-cru: fix a test for timeout
>=20
> Geert Uytterhoeven (1):
>   arm64: defconfig: Enable RZ/G2L MIPI CSI-2 and CRU support
>=20
> Jiapeng Chong (1):
>   media: rzg2l-cru: Fix missing error code in
>     rzg2l_cru_start_streaming_vq()
>=20
> Lad Prabhakar (15):
>   media: i2c: ov5645: Drop fetching the clk reference by name
>   media: i2c: ov5645: Use runtime PM
>   media: i2c: ov5645: Drop empty comment
>   media: i2c: ov5645: Make sure to call PM functions
>   media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
>     the subdev
>   media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
>   media: dt-bindings: Document Renesas RZ/G2L CRU block
>   clk: renesas: r9a07g044: Add clock and reset entries for CRU
>   media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
>   media: platform: Add Renesas RZ/G2L CRU driver
>   media: platform: renesas: rzg2l-cru: Add missing documentation for
>     image_conv_irq
>   arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
>   arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
>   arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
>   arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support
>=20
> Nathan Chancellor (1):
>   media: rzg2l-cru: Remove unnecessary shadowing of ret in
>     rzg2l_csi2_s_stream()

I reviewed this series, there are no problems.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


