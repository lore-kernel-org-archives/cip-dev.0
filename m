Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF6D1CA39
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 06:32:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.11898.1730788352369546522
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Nov 2024 22:32:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=iLqrPS6n;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1730788333;x=1731997933;bh=Z+
	XW/ZNR1EVPWV3oKvDo52nrr+WZ4aomlaZH6NsRUog=;b=iLqrPS6njf2by39qkNsHVZ/CGOTlovr3
	jM0kgul/sejFaT6lQ3qWx7WW6ISrXmOlHh3bPGI/d/bIK1qV42LO+J9jpB86MI0UqZDJrEFcymwU5
	2T8/Rs9LSJP9aAnmPcxG/sdI8GcWcxPDIvmg6Q51EdWf8Q/MGzW8Sg/qxunvjmwUaFe6i2rAbH7rl
	b6/ByXHfBe4fc2KayuMFuKE0NtLFZ7YbYKXXT5hqHsQLico5wuy7Qp119AhHdOUaAhg+eIJwRRdVT
	sbLvi8jTD4B2+aGzr8ZKzqQEBK9RAUSkaXSoatRp9Zf98d5T3EVPl6Owo69jwAD7SpD/wBa7RmPC+
	PQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4A56WD3N2089801; Tue, 5 Nov 2024 15:32:13 +0900
X-Iguazu-Qid: 2yAb2N10aktMBz84ut
X-Iguazu-QSIG: v=2; s=0; t=1730788332; q=2yAb2N10aktMBz84ut; m=2FA3rJ4H5EJIvrYpMbvPXNbPa3Ud4yNFh/8r3gqlX+4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4A56WA7Q1923409
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 15:32:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6saOAubHb3eFH4XfLiHQICkYvCPwdj8qXM5D794NqFyBFTcSB12Fp9iT+3oiRS29hcRQLsXpulKH74R5lTVebYu6bQeX9aR5zFR1u/5Bl9GvPL0FfMhRNgBShDQvwKdtBq/s2MunPYRX5i7u4JR781sISjPah0UGstq8B5C/7FFwKBRIT4CKjofc+BJ8aYbPcbI66Og1ljZMDMhIoHmsSz4OJ3kTWlAaIQENHfUh7VNPQkgAOYZEKa+NVovf5KLAv82aXwM2yjRdfDN/Iy9m7kgizoTXhCldTxCOLm02JEfNpA7pNOo3/aylcDPwNAIYANmE/LzPP0aRfC17nIuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR0qH1MlnkIpGilAhxkELus6aOo4XEgPBuKd2QujRzg=;
 b=I1451Fv77MVB7yAN22Tszm9ldm4neX/kORyQv0MwdO0eck/tbuJ7cNbrnVbQ6no+CyKHTFLwCkr+zANEXMc3id1gLo+DQuzyytPhkwFqrB77TYqlNWuGqT1f97WP82bci4nx0XuDWgSzS/Z76T/Mrmwf/+0gobRe1rAk906ci+85aLESr26IRSIxZSWyA+KF17W2i1wmwCeFyLXW82WEw++AYRWM/aY7GSIxPySeKXXp1Iqtx2sVb0DqFW690Q6Y4TTFov8l89tQniu+QMChsE48PZaY2ouZTwdDtv22D3qnMGRx6EgkhzEu3G3w8WG0+KNNehDRoj9CAHRwyBSbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.115-cip31
Thread-Topic: [ANNOUNCE] Release v6.1.115-cip31
Thread-Index: AdsvTGmY+92CKGRtTu6/ymtvAGUNEA==
Date: Tue, 5 Nov 2024 06:32:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638842A7BD6318E7BD833E4A92522@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB10631:EE_
x-ms-office365-filtering-correlation-id: 67d24e24-88e0-4f46-9350-08dcfd6391cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UUxzVGYrNTd2R0hWMWxYMlFMMjJhSU1PQVRTVndTUU9DZ3RDS2dpa0RY?=
 =?iso-2022-jp?B?RGhkOEZ2RWlZNVZrYjduWWZnWFlrN3l1RW9DVFRpeGZJK0dabFk3STNO?=
 =?iso-2022-jp?B?aHhOMTJKQXRtYVkrTTdnWm5pZUdKR2srYnp5MmxDTGpuZHF0ZHRyaWNG?=
 =?iso-2022-jp?B?cnh6NzJISG1TZnBGRWNleStMNFR4dTExWXNYOWRUQjZtci8ySnRHS3hh?=
 =?iso-2022-jp?B?OVp5eEVVa3dIWVlXakU0bCtNWFhPeGtZN0ZZcUxMUjhpTXhZTkZQaTdP?=
 =?iso-2022-jp?B?aTRTNmVjbHptOGI1UForajlYbDZkZkhaK3A3WlN3UzJoTnhPdk44UnFQ?=
 =?iso-2022-jp?B?c1FaS2NDNWVuMm1uWWNCNVVaelBEdHY2UnN4SVJ5MlA4SDBpdm44eW9Z?=
 =?iso-2022-jp?B?RHRjQlRsSUlVVHpYMDMyQkFqY3Y0TDhZMm15eGNnS0ZGSVU5OFRxWlN4?=
 =?iso-2022-jp?B?aDRvcjhpd1ZGWjNBSnlBaWxHTGRFSlRXdmgrU1RVSWZ5N25hdnF5UkFp?=
 =?iso-2022-jp?B?OXB5MUdKL21GeEFUOE52YXdTL0NHMFlLQUNVK1dwNVh2VDJOMVA0Q2ZG?=
 =?iso-2022-jp?B?eHpBYnBVNmFWMnFXL3BUa3hOM21xNG1SSEJlaVlmN1NxcVpXUVlqUjhV?=
 =?iso-2022-jp?B?dFlvNFA0V2VrZENFdjlmbUpJMFY1alo0RHlqQzlWNHY2T29wcHJ5d25p?=
 =?iso-2022-jp?B?eGp3SGEzN3dtZ2xFWlIwRlRGRzVHZUtLVzMrWjk0Q0xBakM5YnVrU1dW?=
 =?iso-2022-jp?B?T3ZFQlN2MDh6VDFuZkNLMGJJNUwyNTlzTzBoSDE1blZTRlE4cHN1VGJC?=
 =?iso-2022-jp?B?RFFldGZ1R2pUeURGaEJwNTUyYndpSHRoWVF5RG1kaGJlN2NmK1V2VG5B?=
 =?iso-2022-jp?B?UmswdG1aSFliNk5LeFE2VXlXSFJWb21ZbHVWSDFPRU5jZFArcUcweHNH?=
 =?iso-2022-jp?B?RkFxZzh3Z1M0T1dYMDZEVVJnWTdRSnBJb1BEVkJJemdMaVBwbXZFbjhM?=
 =?iso-2022-jp?B?YTVhRFRrL05KOTIydjRPVWRJQU5jMzdLbW5sbXEvRmNRc2NqQ0piZ1NU?=
 =?iso-2022-jp?B?U1BIREk4QmU1YmozT0p3dGVJZVVteHd1S25SUzIxeDNHVmRyWFFVbytn?=
 =?iso-2022-jp?B?aTQ3eDZqTFg0d2cyc0FKZWhRZk15aE93WkdWRXZ3Qk5lKzh1OWtmQWlu?=
 =?iso-2022-jp?B?R25Rb2l1Tk9ubXZPSTVmL3Bwb2EvYzQ4aG04UFU3M21MaDcxUWY1OXk1?=
 =?iso-2022-jp?B?eVFCd2dNSWpWcjFuTXpSU1FiUWtCY2orTmN0TXRrQWh6RGRCZTFNR0hH?=
 =?iso-2022-jp?B?VEtWSmR6dWx1eXFjL2Jva1d3bUFvbzNXaWNTY2oyVk5NNVEzamNXTmU1?=
 =?iso-2022-jp?B?V2xPcDM2eUFIaldjL2ppTTZLY2U3ODdjbTdXNVBvWWhMN1dUVGxtUEY1?=
 =?iso-2022-jp?B?ajBodEM2c1NtM2R2eDNFV3EyYi9IbkdWNWxCajdSWUMvQXZxZUFPczZE?=
 =?iso-2022-jp?B?cDV1Z0RqY0VBL1kya2ZTRzBOT0c0RkV1OVNpd1dUWUhTdjlhTWI2dFBX?=
 =?iso-2022-jp?B?c2dLQ1pFdC85SHdmOG1XMFdYUFB1NHhaNjVOcDZwR3JmQmJHam5QQUpS?=
 =?iso-2022-jp?B?N1RocmRSS2d0SzRmenE4ZXVQZGN0TS9yR2QzTG05ZGRuNzJBaTBqZjIr?=
 =?iso-2022-jp?B?R2xWZ1VwR0JNTmFUOXZTbm5kMGtickpjR0c2Y0hYdG5IaEhHY1cvSjVI?=
 =?iso-2022-jp?B?cWNKaW1LU3YxR05BS09xNXREbHNqSXA2dlo2Uk1hY1YxL2lkanR0Q1VC?=
 =?iso-2022-jp?B?RnVweDNIMm5IUXBGMWY1ckU4VWw0cGJZdHZVdVNhZTN6TzhVV29RV3gw?=
 =?iso-2022-jp?B?K0dKZVdMV21TZ1kwSk1heWJ3bFdjeW01a1lNVVIrT081SUdzOHBnS2ZF?=
 =?iso-2022-jp?B?R3M4b3NpN3ZlY1JtTDMzeFFmRXFCd0VwLzErcjlPRTdybGN3SE54aFZ6?=
 =?iso-2022-jp?B?QVVWam1sc082UXRqV2V5ZC9jQ3ByN2VSSHRJZ3ZuWG1aVUM2K2JnWDZP?=
 =?iso-2022-jp?B?dEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UjltWEVGN1ZQcXZNQ2RXNzVXeDUwUjN3aHFPOWd2Z205MisweFFZZUlG?=
 =?iso-2022-jp?B?dHlxQjZWM2lHMUtablZyR3RGNHZtaGUvWmQ3RWo1WGNUQkFvemEvamZZ?=
 =?iso-2022-jp?B?YUc0L2JYZFZJZlE5M0ZLTGdNb1pmamZJYXA1OHIwOHZ1akNHeWZYNjly?=
 =?iso-2022-jp?B?T1VEZnlSS2gvdyszNndFa1hMdU5BNSsyaDgybU9iMndvWjlrVUFvMHN2?=
 =?iso-2022-jp?B?MVp5T1k0RXJmSHU4eVFiMEZoeUFXQ2krSDM5VlBIb1BIRjlDSlJMei84?=
 =?iso-2022-jp?B?T3FJVkNZN0Fkd1FndzZKUU5sTGxZTWI2ajFja2lMYis3M0hVMnptcjFW?=
 =?iso-2022-jp?B?WjNuaEE5bnpVdVFhd0Rub0RoaVN1dE8vSDhGK3l3RG5FQjArNDE2RjhW?=
 =?iso-2022-jp?B?V3hZSVR5eVptTjI4YzIwRHFtZ21wYzRoN1MxcHV6S20zTExuNGRMVysr?=
 =?iso-2022-jp?B?enZ6VmpHNFhpbjdaNXVTb3BpNkRTaVhUdURJVFo1WGt1Mm1yUEFuM2Vn?=
 =?iso-2022-jp?B?MkRjbU10NjRVL2V1Y1lzTzZXQnA0cm1jQlBjYnNHa3c4SFliVFZub1BP?=
 =?iso-2022-jp?B?ZzhzTEE2QU9ZVzJxRDV2R2FaVTZLKzFYbStPSnJoY0czWXRCZy83VzFp?=
 =?iso-2022-jp?B?WnFBT1c2TmdOdlNXemhqWkZJaUNLTkhqRjFTaEpZWUN6bEZZNjdpL1pv?=
 =?iso-2022-jp?B?WUMvK3FGM3U3R2hoOGN2VWQ3aXVKbnBEOW5pcTBsRW82bWx1R1hwRFVy?=
 =?iso-2022-jp?B?Snc0WWxuMTRBWG02dzVLUFViUnJrLzJhNHo3RVVjN01uSFJ0Zmk2eDU0?=
 =?iso-2022-jp?B?THNwR2NCYmZhRVRPbjJVb0diRHEzOFhOWGhvRXVzV1lRQzg3bktWSE9h?=
 =?iso-2022-jp?B?N0UvQTFtV2RJY3FHU05xOHV5UE5Ib1NxT0VLQXlCRGlsbElmYVpUSFhE?=
 =?iso-2022-jp?B?cmtaTXdGUWdOSG5kNXBsVmN6aFdldXZJSktsb0FVNlcwL1JLSXVmR2JI?=
 =?iso-2022-jp?B?TnIvNEwycU91OEdIUE55OVQxbmpGUFY1MHNrcyt2RGxWYTNmdnd1RDBC?=
 =?iso-2022-jp?B?blVoMWZRUEJhVlVyN0xhM1RHYlBkVElVNUx6TFRYcTVjUE9OT1JJa2dX?=
 =?iso-2022-jp?B?OXdRR2ozbDU1bnd2TjNId0xsQlBJdVFFQkIyeUowTHc4TjBXWG5pWEp4?=
 =?iso-2022-jp?B?QWRDSUJRdFVtcDFka25CUFUwWTZaMndzbEthdTRuVkxwWnF4UVNObG04?=
 =?iso-2022-jp?B?L2NmVVFhcXU3Uzd5Vk5jWUEyOEJteEd4dmJoZVV4OURhQW56U1VtR3BK?=
 =?iso-2022-jp?B?dVFjOEhzZlJuOWhUUEVoMm9ER0VjZ3pKWGVibGRhbFpKZ2xkL0g4ZzRn?=
 =?iso-2022-jp?B?V3VxZkhCbFRUbTR5bkd3MHB6UmtDRkpTTUs4ckxqcDNDWExRdDhSMlp3?=
 =?iso-2022-jp?B?MmF5dkE4RmdrejR1dkg2dEdWWTRWWlNlNU43aWZVNUxGTEZBMzBsaVBu?=
 =?iso-2022-jp?B?OWd0b3Z2SlFBL2d5WDllT2pXLzBRS09wTXlqaWw3Q1hac051ejdBRVU2?=
 =?iso-2022-jp?B?RWtQYmNWWEs0K0laTElCbmJYTWFlZ1VvREZ0ZnkySmpGNmVia0JDNWor?=
 =?iso-2022-jp?B?VmJyaEdLSnUyNEU4MEl0cmZrWkNRTnZLQytydGR5eXFqMzZUbGZMS1lD?=
 =?iso-2022-jp?B?bU4rNjh6YzBSWkJ5a2JWS2VsQWtLQXcvTGpzOWJINjAvcnJmbnBhMEdG?=
 =?iso-2022-jp?B?YThJczErRzBKOVdMVzlCZWFaV3FiRmlFeEdSVjE3R1dLQ0pxeWdWMWlW?=
 =?iso-2022-jp?B?NE9UZUlqNmF1Rjg2Q0ljSzNveGlQZTZXRHZvN3VQQUZycFVRQmpPcnBZ?=
 =?iso-2022-jp?B?YW1HVGUyTmxxM1VlMzFEdUdSYkp6Szd5dnJqanpTZmxyb0hyeGVSODBZ?=
 =?iso-2022-jp?B?S1h2VXlWdGV4YnBUUmlCL0V2RE9mSmwxOFdUQVRKeEpvSWgyT0ZUMlpn?=
 =?iso-2022-jp?B?NEVZSjhTaWIyMFJrUHNONUJrdEVrMzJFZ1ArTG56aWplTWFscjk5R3pk?=
 =?iso-2022-jp?B?RjFSN1Vyek5KbjlMMW5WVk1ZTFRQVm1KSlVpbFNiUVUwL3Q5aGpDSEZ2?=
 =?iso-2022-jp?B?WTM2VjVlNjlPcnpCWjJUNDZQN3RoTEFWOFdka1puV0c4bEEwU2hSd0li?=
 =?iso-2022-jp?B?YzQzRW5FUmo1RlgxVlo1cmFnVy9iRlU3VkpKRlJvbnpBbHJUUm5UblRm?=
 =?iso-2022-jp?B?MEF1VjBzSmhnVWRoK2tsZU5BWmRMSjNLckxQN1VkdVZnSUcyMXRUL2Ft?=
 =?iso-2022-jp?B?OTNzSGJHTVA3dXhrVGpMS0x4U1Boc2ZPakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d24e24-88e0-4f46-9350-08dcfd6391cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:32:06.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYsIpkPblBRhC6CcWgyqHfs6KbJbDoajfhvsKE9XXhZyboSKEtp+bXkaZ/gkU2aiSbKMV1UKf/VIz3QgUJnUOQ03y4vwn9Bu9Pic+kv/KbObEg+YNdXSQIZbqYGMx1eL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Nov 2024 06:32:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17170

Hi all,

CIP kernel team has released Linux kernel v6.1.115-cip31.
The linux-6.1.y-cip tree has been updated base version from v6.1.112 to v6.=
1.115.
In this release, small fixes for Renesas ARM64 SoC have been included for C=
IP.

You can get this release via the git tree at:

  v6.1.115-cip31:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      b6d95e014d750e23690fcd0c6e630d2b34587e48
    fixed CVEs:
      - CVE-2023-45896: fs/ntfs3: Add more attributes checks in mi_enum_att=
r()
      - CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for debugf=
s_create_dir()
      - CVE-2024-27072: media: usbtv: Remove useless locks in usbtv_video_f=
ree()
      - CVE-2024-35963: Bluetooth: hci_sock: Fix not validating setsockopt =
user input
      - CVE-2024-38632: vfio/pci: fix potential memory leak in vfio_intx_en=
able()
      - CVE-2024-39497: drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, =
MAP_PRIVATE)
      - CVE-2024-41071: wifi: mac80211: Avoid address calculations via out =
of bounds array indexing
      - CVE-2024-43866: net/mlx5: Always drain health in shutdown callback
      - CVE-2024-46695: selinux,smack: don't bypass permissions check in in=
ode_setsecctx hook
      - CVE-2024-46710: drm/vmwgfx: Prevent unmapping active read buffers
      - CVE-2024-47678: icmp: change the order of rate limits
      - CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode=
()&iput()
      - CVE-2024-47682: scsi: sd: Fix off-by-one error in sd_read_block_cha=
racteristics()
      - CVE-2024-47683: drm/amd/display: Skip Recompute DSC Params if no St=
ream on Link
      - CVE-2024-47684: tcp: check skb is non-NULL in tcp_rto_delta_us()
      - CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr=
_put()
      - CVE-2024-47686: ep93xx: clock: Fix off by one in ep93xx_div_recalc_=
rate()
      - CVE-2024-47690: f2fs: get rid of online repaire on corrupted direct=
ory
      - CVE-2024-47692: nfsd: return -EINVAL when namelen is 0
      - CVE-2024-47693: IB/core: Fix ib_cache_setup_one error flow cleanup
      - CVE-2024-47695: RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in =
bounds
      - CVE-2024-47696: RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check=
_flush_dependency
      - CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an out-o=
f-bounds write error
      - CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an out-o=
f-bounds write error
      - CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree=
_insert()
      - CVE-2024-47701: ext4: avoid OOB when system.data xattr changes unde=
rneath the filesystem
      - CVE-2024-47705: block: fix potential invalid pointer dereference in=
 blk_add_partition
      - CVE-2024-47706: block, bfq: fix possible UAF for bfqq->bic with mer=
ge chain
      - CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_lis=
t_flush_dev()
      - CVE-2024-47709: can: bcm: Clear bo->bcm_proc_read after remove_proc=
_entry().
      - CVE-2024-47710: sock_map: Add a cond_resched() in sock_hash_free()
      - CVE-2024-47712: wifi: wilc1000: fix potential RCU dereference issue=
 in wilc_parse_join_bss_param
      - CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in ie=
ee80211_do_stop()
      - CVE-2024-47718: wifi: rtw88: always wait for both firmware loading =
attempts
      - CVE-2024-47720: drm/amd/display: Add null check for set_output_gamm=
a in dcn30_set_output_transfer_func
      - CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      - CVE-2024-47727: x86/tdx: Fix "in-kernel MMIO" check
      - CVE-2024-47728: bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case=
 of error
      - CVE-2024-47730: crypto: hisilicon/qm - inject error before stopping=
 queue
      - CVE-2024-47731: drivers/perf: Fix ali_drw_pmu driver interrupt stat=
us clearing
      - CVE-2024-47734: bonding: Fix unnecessary warnings and logs from bon=
d_xdp_get_xmit_slave()
      - CVE-2024-47735: RDMA/hns: Fix spin_unlock_irqrestore() called with =
IRQs enabled
      - CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns N=
ULL
      - CVE-2024-47738: wifi: mac80211: don't use rate mask for offchannel =
TX either
      - CVE-2024-47739: padata: use integer wrap around to prevent deadlock=
 on seq_nr overflow
      - CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls
      - CVE-2024-47742: firmware_loader: Block path traversal
      - CVE-2024-47743: KEYS: prevent NULL pointer dereference in find_asym=
metric_key()
      - CVE-2024-47747: net: seeq: Fix use after free vulnerability in ethe=
r3 Driver Due to Race Condition
      - CVE-2024-47748: vhost_vdpa: assign irq bypass producer token correc=
tly
      - CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid
      - CVE-2024-47750: RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      - CVE-2024-47751: PCI: kirin: Fix buffer overflow in kirin_pcie_parse=
_port()
      - CVE-2024-47755: [REJECTED]: nvdimm: Fix devs leaks in scan_labels()
      - CVE-2024-47756: PCI: keystone: Fix if-statement expression in ks_pc=
ie_quirk()
      - CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check=
_delete()
      - CVE-2024-49850: bpf: correctly handle malformed BPF_CORE_TYPE_ID_LO=
CAL relos
      - CVE-2024-49851: tpm: Clean up TPM space after command failure
      - CVE-2024-49852: scsi: elx: libefc: Fix potential use after free in =
efc_nport_vport_del()
      - CVE-2024-49853: firmware: arm_scmi: Fix double free in OPTEE transp=
ort
      - CVE-2024-49854: block, bfq: fix uaf for accessing waker_bfqq after =
splitting
      - CVE-2024-49855: nbd: fix race between timeout and normal completion
      - CVE-2024-49856: x86/sgx: Fix deadlock in SGX NUMA node search
      - CVE-2024-49858: efistub/tpm: Use ACPI reclaim memory for event log =
to avoid corruption
      - CVE-2024-49859: f2fs: fix to check atomic_file in f2fs ioctl interf=
aces
      - CVE-2024-49860: ACPI: sysfs: validate return type of _STR method
      - CVE-2024-49863: vhost/scsi: null-ptr-dereference in vhost_scsi_get_=
req()
      - CVE-2024-49866: tracing/timerlat: Fix a race during cpuhp processin=
g
      - CVE-2024-49867: btrfs: wait for fixup workers before stopping clean=
er kthread during umount
      - CVE-2024-49868: btrfs: fix a NULL pointer dereference when failed t=
o start a new trasacntion
      - CVE-2024-49870: cachefiles: fix dentry leak in cachefiles_open_file=
()
      - CVE-2024-49871: Input: adp5589-keys - fix NULL pointer dereference
      - CVE-2024-49875: nfsd: map the EBADMSG to nfserr_io to avoid warning
      - CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buf=
fer_uptodate
      - CVE-2024-49878: resource: fix region_intersects() vs add_memory_dri=
ver_managed()
      - CVE-2024-49879: drm: omapdrm: Add missing check for alloc_ordered_w=
orkqueue
      - CVE-2024-49881: ext4: update orig_path in ext4_find_extent()
      - CVE-2024-49882: ext4: fix double brelse() the buffer of the extents=
 path
      - CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_exten=
t()
      - CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_=
at()
      - CVE-2024-49886: platform/x86: ISST: Fix the KASAN report slab-out-o=
f-bounds bug
      - CVE-2024-49889: ext4: avoid use-after-free in ext4_ext_show_leaf()
      - CVE-2024-49890: drm/amd/pm: ensure the fw_info is not null before u=
sing it
      - CVE-2024-49892: drm/amd/display: Initialize get_bytes_per_element's=
 default to 1
      - CVE-2024-49894: drm/amd/display: Fix index out of bounds in degamma=
 hardware format translation
      - CVE-2024-49895: drm/amd/display: Fix index out of bounds in DCN30 d=
egamma hardware format translation
      - CVE-2024-49896: drm/amd/display: Check stream before comparing them
      - CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer
      - CVE-2024-49902: jfs: check if leafidx greater than num leaves per d=
map tree
      - CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      - CVE-2024-49905: drm/amd/display: Add null check for 'afb' in amdgpu=
_dm_plane_handle_cursor_update (v2)
      - CVE-2024-49907: drm/amd/display: Check null pointers before using d=
c->clk_mgr
      - CVE-2024-49912: drm/amd/display: Handle null 'stream_status' in 'pl=
anes_changed_for_existing_stream'
      - CVE-2024-49913: drm/amd/display: Add null check for top_pipe_to_pro=
gram in commit_planes_for_stream
      - CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_=
task()
      - CVE-2024-49927: x86/ioapic: Handle allocation failures gracefully
      - CVE-2024-49930: wifi: ath11k: fix array out-of-bound access in SoC =
stats
      - CVE-2024-49933: blk_iocost: fix more out of bound shifts
      - CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
      - CVE-2024-49936: net/xen-netback: prevent UAF in xenvif_flush_hash()
      - CVE-2024-49937: wifi: cfg80211: Set correct chandef when starting C=
AC
      - CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetti=
ng urb before resubmit
      - CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails=
 in sctp_listen_start
      - CVE-2024-49946: ppp: do not assume bh is held in ppp_channel_bridge=
_input()
      - CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()
      - CVE-2024-49949: net: avoid potential underflow in qdisc_pkt_len_ini=
t() with UFO
      - CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated cor=
ruption
      - CVE-2024-49954: static_call: Replace pointless WARN_ON() in static_=
call_module_notify()
      - CVE-2024-49955: ACPI: battery: Fix possible crash when unregisterin=
g a battery hook
      - CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.
      - CVE-2024-49958: ocfs2: reserve space for inline xattr before attach=
ing reflink tree
      - CVE-2024-49959: jbd2: stop waiting for space when jbd2_cleanup_jour=
nal_tail() returns error
      - CVE-2024-49961: media: i2c: ar0521: Use cansleep version of gpiod_s=
et_value()
      - CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED()=
 in acpi_db_convert_to_package()
      - CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode
      - CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_blo=
cks
      - CVE-2024-49966: ocfs2: cancel dqi_sync_work before freeing oinfo
      - CVE-2024-49967: ext4: no need to continue when the number of entrie=
s is 1
      - CVE-2024-49969: drm/amd/display: Fix index out of bounds in DCN30 c=
olor transformation
      - CVE-2024-49973: r8169: add tally counter fields added with RTL8125
      - CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma
      - CVE-2024-49977: net: stmmac: Fix zero-division error when disabling=
 tc cbs
      - CVE-2024-49978: gso: fix udp gso fraglist segmentation after pull f=
rom frag_list
      - CVE-2024-49981: media: venus: fix use after free bug in venus_remov=
e due to race condition
      - CVE-2024-49982: aoe: fix the potential use-after-free problem in mo=
re places
      - CVE-2024-49983: ext4: drop ppath from ext4_ext_replay_update_ex() t=
o avoid double-free
      - CVE-2024-49985: i2c: stm32f7: Do not prepare/unprepare clock during=
 runtime suspend/resume
      - CVE-2024-49992: drm/stm: Avoid use-after-free issues with crtc and =
plane
      - CVE-2024-49993: iommu/vt-d: Fix potential lockup if qi_submit_sync =
called with 0 count
      - CVE-2024-49995: tipc: guard against string buffer overrun
      - CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure
      - CVE-2024-50000: net/mlx5e: Fix NULL deref in mlx5e_tir_builder_allo=
c()
      - CVE-2024-50001: net/mlx5: Fix error path in multi-packet WQE transm=
it
      - CVE-2024-50002: static_call: Handle module init failure correctly i=
n static_call_del_module()
      - CVE-2024-50003: drm/amd/display: Fix system hang while resume with =
TBT monitor
      - CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migra=
te()
      - CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access
      - CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write wa=
rning in mwifiex_cmd_802_11_scan_ext()
      - CVE-2024-50010: exec: don't WARN for racy path_noexec check
      - CVE-2024-50013: exfat: fix memory leak in exfat_load_bitmap()
      - CVE-2024-50015: ext4: dax: fix overflowing extents beyond inode siz=
e when partially writing
      - CVE-2024-50019: kthread: unpark only parked kthread
      - CVE-2024-50022: device-dax: correct pgoff align in dax_set_mapping(=
)
      - CVE-2024-50024: net: Fix an unsafe loop on the list
      - CVE-2024-50026: scsi: wd33c93: Don't use stale scsi_pointer value
      - CVE-2024-50031: drm/v3d: Stop the active perfmon before being destr=
oyed
      - CVE-2024-50033: slip: make slhc_remember() more robust against mali=
cious packets
      - CVE-2024-50035: ppp: fix ppp_async_encode() illegal access
      - CVE-2024-50038: netfilter: xtables: avoid NFPROTO_UNSPEC where need=
ed
      - CVE-2024-50039: net/sched: accept TCA_STAB only for root qdisc
      - CVE-2024-50040: igb: Do not bring the device up after non-fatal err=
or
      - CVE-2024-50041: i40e: Fix macvlan leak by synchronizing access to m=
ac_filter_hash
      - CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_=
sk_state_change
      - CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_ds=
t skb
      - CVE-2024-50046: NFSv4: Prevent NULL-pointer dereference in nfs42_co=
mplete_copies()
      - CVE-2024-50048: fbcon: Fix a NULL pointer dereference issue in fbco=
n_putcs
      - CVE-2024-50049: drm/amd/display: Check null pointer before derefere=
ncing se
      - CVE-2024-50058: serial: protect uart_port_dtr_rts() in uart_shutdow=
n() too
      - CVE-2024-50059: ntb: ntb_hw_switchtec: Fix use after free vulnerabi=
lity in switchtec_ntb_remove due to race condition
      - CVE-2024-50060: io_uring: check if we need to reschedule during ove=
rflow flush
      - CVE-2024-50062: RDMA/rtrs-srv: Avoid null pointer deref during path=
 establishment
      - CVE-2024-50069: pinctrl: apple: check devm_kasprintf() returned val=
ue
      - CVE-2024-50073: tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
      - CVE-2024-50074: parport: Proper fix for array out-of-bounds access
      - CVE-2024-50077: Bluetooth: ISO: Fix multiple init when debugfs is d=
isabled
      - CVE-2024-50078: Bluetooth: Call iso_exit() on module unload
      - CVE-2024-50082: blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wak=
e_function race
      - CVE-2024-50083: tcp: fix mptcp DSS corruption due to large pmtu xmi=
t
      - CVE-2024-50085: mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_s=
ubflow
      - CVE-2024-50086: ksmbd: fix user-after-free from session log off
      - CVE-2024-50087: btrfs: fix uninitialized pointer free on read_alloc=
_one_name() error
      - CVE-2024-50088: btrfs: fix uninitialized pointer free in add_inode_=
ref()
      - CVE-2024-8805: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring=
 with LE
    added commits:
      CIP: Bump version suffix to -cip31 after merge from stable
      media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in parenthe=
ses
      media: rzg2l-cru: Remove unneeded semicolon

Best regards,
   Nobuhiro



