Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8AC369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 06:30:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.33919.1745303411699325184
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 23:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 53M6U8a13887668; Tue, 22 Apr 2025 15:30:09 +0900
X-Iguazu-Qid: 2yAb5TJlgpVQXzxjUn
X-Iguazu-QSIG: v=2; s=0; t=1745303408; q=2yAb5TJlgpVQXzxjUn; m=Jr7So0ztA9mjV+jYlPcKxz2J4Jk7wPGBuyB5g3O6+zo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 53M6U73B3706715
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 15:30:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIn99Qu89b7z/tBGNtBK2giWqnyP07J2gMuLkKsm6/FjAaz0fOC+YV8OXOhBbH8b8n587BvVwLWU2BK/r/HZrR/c93+y5rinnyCUIZGfJZDhXM1+ZW9VCUgD8MQKvTQoHuyduK0m/U5+padWzJH08rms09ntBDo+9H1J6L3PK59t2KpU6VNT686M91kd+uoTybBh3TlplZyFyovNJdGhXJqB4MdZBg3JQMXtl60wDa74c11BpnPkoKZQdHoEwYlnbU4n9FN+Zj2K+OJHoNZdEkD9i+zKwnkYOn/hmoS9XSzXsAcZP9EojSGZzZqJFSS4o/U96WwBoBnI7XooIh1m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0DKnARjxgzPRUxq9GiiCxzgHcBaup6rzy1K9vxYp+k=;
 b=H9bHcwR7/oAHTWiuSqYkdlvQVnYMYXe/Zs1egQKIz3NEue9/xw72osMvF+DUSk8Asyx8Zeao9fl6HY9xdjXo96G1Cm4UFohgefqhxbmOJ6i/U2sshKsGTQepwyyVzM/etwFlwN0TL7+xelhsZEPyPzsRZJ2pPFOge+j1RqBwAvDzw3QQZ1K7gVxlQ+m1uq5BTFH+ssidUsxEcR6GX+ENQiTVLBj+dg/tar8dKVw6jU8B6a6rfBOzpFxRdNx5GVHFbojFhGF7bj3nB7Zk3WXAkRDQCAtVKrk70p7cw2MYb7/qFf9tqGNynGVAagcu7aQrTj7xuGUPUKGFJC7UM2QcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC
 layer tests revision
Thread-Topic: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC
 layer tests revision
Thread-Index: AQHbr2q0ZOh8sB9CrUSc3RmEHYx6W7On2MoAgABItoCAAMCu3oAGWhiAgAAEHvY=
Date: Tue, 22 Apr 2025 06:30:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838E9EF72576D7F94613FFDC2BB2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
 <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
 <825618d2-d3f6-44f3-b1f0-625f7256dd38@siemens.com>
 <OSCPR01MB14838EF80E946D2BCB02E8208C2BF2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
 <0db1aab1-18ea-4bea-97a9-b85159487a1b@siemens.com>
In-Reply-To: <0db1aab1-18ea-4bea-97a9-b85159487a1b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYXPR01MB15311:EE_
x-ms-office365-filtering-correlation-id: c2fdc526-6ffb-4d59-c439-08dd81671c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|8096899003|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?d1AyS1RhWDZlRENzYjR1YlVKMnhnL2VGOU9zOWFERnNsaWVadnZjQlYv?=
 =?iso-2022-jp?B?ZFhLSVQ3THBvc1dIdmFDODE2NTBxbEhldit6Wm9jMFZrM1I4NWtSYlFi?=
 =?iso-2022-jp?B?b2hNeXRMdEVubFU3ak1HNXkyR25rUlBlMjZ0cDlLQkZtSnZRM3dlSFJT?=
 =?iso-2022-jp?B?RnJMUzQvZUl4TnNKT20vNlpuSHlKTFRpYWZMaDFjQ2F1Q29EcTdaVTg0?=
 =?iso-2022-jp?B?eC9TRENIdzM5YVZiSlRLRmU2YnRRemR2REVrbnBldXhSQzY3UWo0N0tl?=
 =?iso-2022-jp?B?YjNQMVFKTXFzRzRxY0FRVnZKVkNTbWtnb3BXWTlmRWp5Y3pZRmNpUm5m?=
 =?iso-2022-jp?B?bExPdGlFUm9CYTdHMVZnZ2pMZGVLand0QjRWaWFKUHdaL0FZY0NIWlRQ?=
 =?iso-2022-jp?B?T01sQ1RmamF4TnQvYmJINXJHdzhDWmh1ajJNRFIyWERCaG9UeVNvY1ho?=
 =?iso-2022-jp?B?Zlk0TldPbCtsQUY5bmI2TjJjOW1qMHd6OWpBeWttOUxqWEtVWWNtNFZG?=
 =?iso-2022-jp?B?SGc1blFuTlBoSWI2dWFMSU4zb294ZDVxVTFSUFVpWUhBNWxNS1VvZ0x4?=
 =?iso-2022-jp?B?bG9taTU3czVrcnorZVJBZkVNVERvZWU0NXJoekdMbk1lSElOYnR1eXpM?=
 =?iso-2022-jp?B?S29tZFRXdm9obmFSckF1cEErZUhuOW9hUFJVVDI1UFZrMDl4bVJMRXVW?=
 =?iso-2022-jp?B?UkgzRTJCTnBHdndyQkN2OWp6Z2NkMTlZRDdEWW1lWFBLUUJvYWszMUR4?=
 =?iso-2022-jp?B?TUhiK0lxZUI3dXZWZXh2bFc0ekxKb1BGQXhMU3lJN3I0VGJrUk41R0JM?=
 =?iso-2022-jp?B?ME53S0Q2L1YwMHZQejNQM0VzR0ZjZDdTUzBnTWlUZG15SHZrZFhCb2VP?=
 =?iso-2022-jp?B?QUVzN2JKUjNONG1sOHN5bDdOVlYyWWk2bzV2eXlTekJZemh2WmdUQzJH?=
 =?iso-2022-jp?B?OHlPYkdZNlZ6QS96TnRVMWxYUkh3SHI1dXg3TENaMmRkZEgxMHlhSm0w?=
 =?iso-2022-jp?B?YjFIVEtPTmRBcWpxZkxHQVNqbStINlpKK2VBTHVGUUhxQm50MmV5U0Nx?=
 =?iso-2022-jp?B?d2QzUHRsTEVZakpEVXJIRWRoUzRWQVFGR00wMjZPckNaU1FJTmhnZjBW?=
 =?iso-2022-jp?B?UHlGbzV0K1pTZ0dZcjFhc05pamI1eXBabGJ0YXpqQkppeUs5bXdBRy9n?=
 =?iso-2022-jp?B?czdTWmowdXlidWNaUHpwK1dTM2ZTS1ZjRWpWRDBTRzF2cHhNaEpSbzVo?=
 =?iso-2022-jp?B?ZVo0MjFjQXVYZDZMMHhqSnVNV3BkRy9DTE5JSTVTbURHSEdKbW01b1p3?=
 =?iso-2022-jp?B?SDZ3QlMyWEpMMmRlSFZjV1diY0NaNlJLdks2WUJsckFrSGVmd1Eray9X?=
 =?iso-2022-jp?B?WnlsamJMdnBBYjgwQTl3TlpxUUgyTlNKbDl6M3h0SXRNd0thL1gvWmVr?=
 =?iso-2022-jp?B?UUtWQkYrcDFLNFpMei9mbjFLWndVSk8yQVRqQXhydFVVUExJeG1rQkZu?=
 =?iso-2022-jp?B?d3owN0h2YURsU1NBb005dHBFTmNkQUdpaTVybk05UURCb1BYcE16NnE1?=
 =?iso-2022-jp?B?QVBQbjJZcnRCRG51cHhCNDZEZ1FnSUdKZGd4TFM3VTI0S2NlSFFVMmZK?=
 =?iso-2022-jp?B?ZEUwY2lDTmNZaGViQm1EcTBjRmRRN1VNZ2JPcW1HRkpsTytNY1FHTVVX?=
 =?iso-2022-jp?B?WERDdWdoN0lrOW9OblE4cFFsaXB0RGlpVG5SWlFSOHV1aDhiUFA4UVJQ?=
 =?iso-2022-jp?B?OGpwWXlnYWNUVHBjUWcrOHl6Tm92dmppV1BFV0RZeU44a3ZGMkF4UGtH?=
 =?iso-2022-jp?B?YktMWWdqVmZyb1FURDlpWTk5NTFKQmZNM09GM3NGMjYxZndVNGVYN0Vy?=
 =?iso-2022-jp?B?QnhYQzV4SWpoNGM4Y1FYS0dRdEViZStMYk5IYUhnQXJndk0rSU04RU4v?=
 =?iso-2022-jp?B?KzdTRGl3aUFxYkUxSGRnNHZWa29DNGtlcCtwbVI0aThRQVlPWTNIUXJX?=
 =?iso-2022-jp?B?WW9yL0ZPL3hwQ0xSek52dk5PSnB1UG90WTlVMkp5czF4RGI2eVpmZVds?=
 =?iso-2022-jp?B?LzRCUVNVNjlKMFNJKy9PeGVMYVkwbHEzeFllSjZMdFNZaXZpRjNKT2RT?=
 =?iso-2022-jp?B?V2M=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eWFSSXBwbTRndHIraXhlZFZQZytTb1Z1S2QxTFpOUGZ0ZmJucnF3VnN5?=
 =?iso-2022-jp?B?ZnlDelJJQ1U0NytEMEpJRlhLR3hMenE4OXJkOEYrb3owaFB0dWhHaXNG?=
 =?iso-2022-jp?B?cHN0WHFRdE9wTm05RHJQMW9lbzZhbHRNK2dZNldHN1MrQTRFMmwwaWZk?=
 =?iso-2022-jp?B?L3U1ZUhEZy9kcGdWNjR5WVRYOEUwZkFkYXNVMkFWSi9uMjkxWGdtV3pT?=
 =?iso-2022-jp?B?REFwN0hmVjFlOFIrMTliRktHcS9QWHlrTTRaSlJHcGtpVkNvenJqNkdL?=
 =?iso-2022-jp?B?bkJnbnpDUFl6V1hqYmN5YjNCbzQ4TmE1QUtaL0xuSEpIZ1VCT04wa293?=
 =?iso-2022-jp?B?ZHU3S1pEcmtXcmQ4elU1S2VYQkh6UzN5UXh2dXZPUUxyWVFmR3QyaTJo?=
 =?iso-2022-jp?B?ZjVtMmZES0lCaWhDaTZtYzJTZEZuckc2SzgrMWUyZ3RkT3Z6VDV4UGd3?=
 =?iso-2022-jp?B?T2RpcEQrMzZJdTNvUXJLeHAvTzJvZ21yczRGM3N1SkZSNnhLWng2eElq?=
 =?iso-2022-jp?B?eUtCL3AxRlR6YjI4VHM0TFdrN3hzN3ZFcnB3bHc0WmVtbDZmb1Q0MFRW?=
 =?iso-2022-jp?B?MTlxcG5JTlg3YVBvdW9iRThrVkJsNVdVTU5Ub0FNQ2E0TUpGSW1GanRT?=
 =?iso-2022-jp?B?RWpTbFNZNEN0eFhtblNRVFFtVWhuMmVvSWRXemZzdTdBZDNzZ09nWnN4?=
 =?iso-2022-jp?B?Z1NLMTdyeWk2aHBBbEk1RVRabVZQamJZeTVzQUZwdFJlZFFQQjkzTVAv?=
 =?iso-2022-jp?B?UGNxZUVwazFuQUxkTGYram1PYjNGSWFKcVRWTlhUaTRoZnR1bmUxcmJD?=
 =?iso-2022-jp?B?WEZCUGtvVmFoN053YmZJYXV3K3dJdThXZ2lwaS9nbG1LekdqTXE2Vmsv?=
 =?iso-2022-jp?B?T1VDNm96VFpSQ0ZzdzZoeVVOY0ZEd2FSY2taaTU1R25nRm9MUFpjUjJJ?=
 =?iso-2022-jp?B?Z1NRTjZSZm9MeEFyS1hTRUZnWWVLbXUrZkJnN2JGQTE4L05BaGFxTm9P?=
 =?iso-2022-jp?B?bWo0dFJ0ZWQ4dmJiMlgwalIzbkNWTzk5cGsvUVV6M0tQTklKc0NmQzhj?=
 =?iso-2022-jp?B?clZhVzVzVlFjVHlrUDU5Rk82dFoySjM5NThjSUNhaVFPZ2d3QmRFcHJy?=
 =?iso-2022-jp?B?d3gvUGQ2OTB6YzR4ZGRyOHEvQjBpVHVsWlhNcVdNZkNGWGd0UnR5WTBL?=
 =?iso-2022-jp?B?RURQeGhRMVdlYVVjV1NoNHNoK0JtSnhPY1NjNjU3QTFXQ05FSXBpMEgv?=
 =?iso-2022-jp?B?OEFuVnR2eHgxWkd2NE5JMmtweHhZZThvdkVydzk3L3pXUTRuWmU5SXRN?=
 =?iso-2022-jp?B?eEd3eGdqUkF3UFRsUlY3QVNzaWJJdjN3ZFk4SG85L1RwdVd4TW9wbHlw?=
 =?iso-2022-jp?B?eHNVUWtlbllpZHZqNHp5R2txVzdrK2ZwUTBxRUptd296SGZaUDFrOTdn?=
 =?iso-2022-jp?B?YUdLQ0hxZnA1WWhrUzJTTzhUOE5PMGVPNEwxeGNqT1d5Zm9Cd1AzMTR2?=
 =?iso-2022-jp?B?Nm9Od1NqaHR6c2UxKy9KL1FZZ0tGdnhlbEFaSHE4L3JLa3VPdHFhc01p?=
 =?iso-2022-jp?B?L3NzTzFNbkFQcVF3cUtuYnBxbnFaNnlhQ2ZYL0V3UWp3MTgrYWVpUTdQ?=
 =?iso-2022-jp?B?VmZYaVdxVy9sU05oaGNSbFdQcTBCekZ5ZzM1UUE1TU9FbFB4RkhUVVht?=
 =?iso-2022-jp?B?am4xblBqbTVWcVNjVlo5SUx5VE01bjFrMXRvTCtxN29mcHZKSUF2SzQy?=
 =?iso-2022-jp?B?UVl6MmV6dHBoVUpqV0tSQ3Frd3FVazh6aCtuai9wTFhxUmxjdERaSEVu?=
 =?iso-2022-jp?B?TlY3ZmpsR3FKYzRyK2YwYjAzY1cwakU1V3paTkFxY3JzNE4wMllPUkNV?=
 =?iso-2022-jp?B?UEpwSVdrU01kVjhSM1F4U0VhTXVITXYvL0ttQlNsbFpMTmNjbjFVcWFn?=
 =?iso-2022-jp?B?QlljWTJqMTlpSHFSaE1VQ3VLeE1rRlZIOEtrdjk4Wnd3SEdpZlROdFA0?=
 =?iso-2022-jp?B?UkRXeUp4S2orN3EwQ1RkOVlON0tla0wzZ3lNVGxYRXFLNmpURStTZFE0?=
 =?iso-2022-jp?B?UTlGSmNBU3hpOUpjSDIxQWdSbDVtaDc2blpkNk41aTY1Vjg2SlVsSGw0?=
 =?iso-2022-jp?B?emxnVHZJZGE1ZFhraUk2U0pZeUxOOWNmRUVrV2FJbGdJRGlTcUFtUXVq?=
 =?iso-2022-jp?B?Tm1EVE84UzRKNGdmRElqS3JuT1RwS2t0YTYwWlgrb0JOKzFtdk5hTEpB?=
 =?iso-2022-jp?B?NnVkdzd3SnJ0a2QxTjQrT1IxbjNBakNIaGNVVjFmLzBINkxOSW1URTJU?=
 =?iso-2022-jp?B?RkI1bkhUK2xycEZ4NFlDcXlCcTdZN2MzNkE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838E9EF72576D7F94613FFDC2BB2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fdc526-6ffb-4d59-c439-08dd81671c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:30:00.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDQ1Thjn0Qn5b2kuEteCTsJxODSYxqHup8dk0j9wtRlpIO9qlYADYnVmyhwvlrdrSZq89hBFk09jPM7IRfgv0IE8hJNbETWstdCBqKjSi/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 06:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18541

--_000_OSCPR01MB14838E9EF72576D7F94613FFDC2BB2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Yes, the flashing problem is still present.  This is the status from the la=
test health check ran today. https://lava.ciplatform.org/scheduler/job/1266=
076#L109

The fix for envsubst issue in v4 is ready. I will send it as soon as the fl=
ashing problem has been fixed.

Thanks and regards,
Sai Ashrith


________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Tuesday, April 22, 2025 11:42 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC =
layer tests revision

On 18.04.25 07:20, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>
> envsubst tool is replacing the value with null in case if it is not
> finding the exported variable in that template file. That is why it was
> unable to pull the swupdate file from the dispatcher because
> lava_dispatcher_id and lava_job_id are replaced with null. https://
> lava.ciplatform.org/scheduler/job/1264806/definition#defline74 <https://
> lava.ciplatform.org/scheduler/job/1264806/definition#defline74>
>
> So I made the following change to the envsubst command to handle this,
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/
> fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa=
068ce6dc_337_342 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/c=
ommit/fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0=
e3aa068ce6dc_337_342>
>
> Now I can see those two variables are not replaced in the job
> definition, and I am sure the x86-uefi swupdate job will not fail now.

Just send a v5 of the patch series once you have a fix, and I will
replace v4 with it in next.

> But just now noticed that there was problem with flashing the device
> https://lava.ciplatform.org/scheduler/job/1265073#L236 <https://
> lava.ciplatform.org/scheduler/job/1265073#L236>. Can you please look
> into this issue ? Once it has been resolved I will send patch to update
> the envsubst command.


Is that flashing problem still present?

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB14838E9EF72576D7F94613FFDC2BB2OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yes, the flashing problem is still present.&nbsp; This is the status from t=
he latest health check ran today.
<a href=3D"https://lava.ciplatform.org/scheduler/job/1266076#L109" id=3D"LP=
lnk355366">
https://lava.ciplatform.org/scheduler/job/1266076#L109</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The fix for envsubst issue in v4 is ready. I will send it as&nbsp;soon as t=
he flashing problem has been fixed.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br>
<b>Sent:</b> Tuesday, April 22, 2025 11:42 AM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D=
#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Upda=
te IEC layer tests revision</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 18.04.25 07:20, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; Hi Jan,<br>
&gt; <br>
&gt; envsubst tool is replacing the value with null in case if it is not<br=
>
&gt; finding the exported variable in that template file. That is why it wa=
s<br>
&gt; unable to pull the swupdate file from the dispatcher because<br>
&gt; lava_dispatcher_id and lava_job_id are replaced with null. https://<br=
>
&gt; lava.ciplatform.org/scheduler/job/1264806/definition#defline74 &lt;htt=
ps://<br>
&gt; lava.ciplatform.org/scheduler/job/1264806/definition#defline74&gt;<br>
&gt; <br>
&gt; So I made the following change to the envsubst command to handle this,=
<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/com=
mit/">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/</a><b=
r>
&gt; fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e=
3aa068ce6dc_337_342 &lt;<a href=3D"https://gitlab.com/cip-project/cip-core/=
isar-cip-core/-/commit/fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e5=
62e29e60bd9b5edf0e3aa068ce6dc_337_342">https://gitlab.com/cip-project/cip-c=
ore/isar-cip-core/-/commit/fb13471312e6909483addb78e0c7644997383e66#a2c400c=
a9e562e29e60bd9b5edf0e3aa068ce6dc_337_342</a>&gt;<br>
&gt; <br>
&gt; Now I can see those two variables are not replaced in the job<br>
&gt; definition, and I am sure the x86-uefi swupdate job will not fail now.=
<br>
<br>
Just send a v5 of the patch series once you have a fix, and I will<br>
replace v4 with it in next.<br>
<br>
&gt; But just now noticed that there was problem with flashing the device<b=
r>
&gt; <a href=3D"https://lava.ciplatform.org/scheduler/job/1265073#L236">htt=
ps://lava.ciplatform.org/scheduler/job/1265073#L236</a> &lt;https://<br>
&gt; lava.ciplatform.org/scheduler/job/1265073#L236&gt;. Can you please loo=
k<br>
&gt; into this issue ? Once it has been resolved I will send patch to updat=
e<br>
&gt; the envsubst command.<br>
<br>
<br>
Is that flashing problem still present?<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB14838E9EF72576D7F94613FFDC2BB2OSCPR01MB14838jp_--


