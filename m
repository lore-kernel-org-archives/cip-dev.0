Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2ECD609D5
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 11:07:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.69465.1732705664655580777
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Nov 2024 03:07:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4ARB7g2M2231762; Wed, 27 Nov 2024 20:07:42 +0900
X-Iguazu-Qid: 2yAa5GSxJAHeIDcuPo
X-Iguazu-QSIG: v=2; s=0; t=1732705662; q=2yAa5GSxJAHeIDcuPo; m=tnj/ug80BUuZ7/AKccHaWFj8He/bAJB75skfJPE8hH4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 4ARB7fDm1126027
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 20:07:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKDf3fLqTKrgYGMJa4rIBr+sJ5tKQu9d+5Ycy/tx6TcCrKa7Inx/RIsWLJgBOy4Qu3G7HeYfl4LZEwytHA37xBAKICTyShacKAcvOCkkw88eACToMjYSbQBxUVviRgddbs02V5AzsODpCCY1qIlPfK82bsTjTnT43YNz54yurJ9P2gtf2LuSGtWvi3u60BY+X7Hf+5z9CILzSS03/wFrIFUrawRerZYmb24opSRo/olfumjsesalbzLt9ryC1A7j8k7hMWL0VVNh/qphWjZMJS9Mzh6ryzP9rzt13/HzYph7/BEMwLgAuV8fNOpSvkUpnsDhlM7cI7OzBtj1zKD/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/MFHLIaJWewau7DLgpOcSGt1UH46249JuT8O2qf8W8=;
 b=jpV3iYI2OxZa8Xz1F6bayvZTnhhUz75BH0kfsmbUqj7x9kI3AE9w9n5uzvH35n5eJTJD0VxsQUCqXPP4B6890pBVwp/R9KQ9QSCmwFxStJLYWpfO2ns1QfUbYihXuDt+SC+3y+U7mFmKP3u9NwxTjkiF8Lro3/A04n0mymSM6AitZ3ebW00+v22ntnKFHN4PTGnYIxMy0YyXe8sfc3sXGNo8ARR3dIvpo25Z+i/byiOaPwCManEvhBX3BtrCQhhTwsj1G5i0gUEbvdUWBzxmqgYkoIxn3+PwhqK60+4Dokq97Y/mMdqrcZHdeHH8y9OFpqHqWfbwtvuwO1XZT2VeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyAg==
Date: Wed, 27 Nov 2024 11:07:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYRPR01MB12773:EE_
x-ms-office365-filtering-correlation-id: ecfab606-5b84-4e72-e8c2-08dd0ed3b4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NVcrYjFENDAxYzhUV0hEOVQ0dXV0Z3M3SXlTamRmOWNDNDg3dHB3ZWtq?=
 =?iso-2022-jp?B?RHRzUUNYMEVHNjBxL3lmSytiNnBYdG5wa0s2Q3JFb1JJcjdnYUxQL2Jy?=
 =?iso-2022-jp?B?OWZac2RheWdxWmtRcHNRbUN6RHo2QXZ0WjlRZmJOa001L0ZuSUZUdVNl?=
 =?iso-2022-jp?B?QXNXQmQ4SzA5N2xGa1ZmTksyTTltZ2pXVHpFeHg3RnlqS05raUxoY2pN?=
 =?iso-2022-jp?B?clM2M0VJeTVGemFpV2t6N0dUejlZcTY5NkhBdnBnQU1wS3RzRDMzZUY0?=
 =?iso-2022-jp?B?T1g1VTN2MDY0SFliQm1tYktDV2UvaDB6ZjZXYmxBMjE2RGptWFFnc1lI?=
 =?iso-2022-jp?B?RWNyNzhVaytab09PczRBNDVUKzNPSkZ3ZGZ6K3lqRVF2clhXUm5ReWxl?=
 =?iso-2022-jp?B?Rm41RlF5SkF5SllBclBCOWJ1ZXB1S3I4cHdNRDlTRTZYVFl0b1pXTVFV?=
 =?iso-2022-jp?B?Wi9Bcms5TXk0TUYzRW5OUSt2anBIbktZMjVMYlFSaHI3RzhFWnFLeGNu?=
 =?iso-2022-jp?B?ZzhPdFRJN0ZUcldUdTNsNnBtejlXbVc0ajlyUkpuYVBaRFNwbzdVMkMx?=
 =?iso-2022-jp?B?bWZBQi9ad0NhQjh3eGZOSDhCeGZpT1Z6dnZHM1VnMTd3T3QxN0FsTlN4?=
 =?iso-2022-jp?B?ZUxIN2tmQjNQTHc2bHd1aktsd2lDcG9TeUNXUi9FL1AvYVdiL21tc3JD?=
 =?iso-2022-jp?B?WmpGT3ByemhGbWN4M0R6RzlodUk0eVBGZExuOFM4RVlWRjN6d2oyRjh3?=
 =?iso-2022-jp?B?V0hSbEhFdFkyd3MzVjJLTnB3c1FBZGU3QTFRV0JmQVpyYUlvakU5RDAz?=
 =?iso-2022-jp?B?R1kxT21FLzRCSWJkcTZZZUVMckxYdklJN0pTdmk3eHo0OVpoWE90SjUy?=
 =?iso-2022-jp?B?QjVnVWN5L256azcxZElvdjgyMnBNenlNU2NYLzV2MDE1YzFKVFQ1R2I4?=
 =?iso-2022-jp?B?eWNzVEZLditjSG1POEorU3dXd2tCK0dXVUorUXoxR3lRZGZMMEN5SXRp?=
 =?iso-2022-jp?B?NUczTEFMcXhwUzNSaHVGbnpnRkhhYXRnWEZpZ2VzOEVuSnBoWWFIUlBN?=
 =?iso-2022-jp?B?WmlXTDhuMTZ0ZkpTU21xTENKNmRHOUZ6ZEhucGc4UDYxUmU1bzJrT3Fu?=
 =?iso-2022-jp?B?S3B2a05CeEVvaGFDWkhYRHZJdEhQV3B0dWhTYkJIUExLVFFWMHQ2M2dl?=
 =?iso-2022-jp?B?TzE5SU9hbkh2OXJyekNrQ3VLQ2RXWjZXelpSNVAwTHdESEpxSmx0cnl6?=
 =?iso-2022-jp?B?bFlsUy9wTVZxQ3duVmNDVDEza21hcVduM1MxNWJwYlR6N0tCdFhTNmZS?=
 =?iso-2022-jp?B?S0NwalZiSUx1WFVhMXhMTWRZYTI5YkpzYTRXYzliN3dSYnZsUEdnK1o5?=
 =?iso-2022-jp?B?ZHZkbzZyQUxDSWJyeDJ6RHJEVzNCQ0lqVFZ5SVVWbDhVeXhwWllYS2Rn?=
 =?iso-2022-jp?B?eWY0VHMxQTIxL25MZ1Zqenk0R3FaamI1SUJJcm1iSy8xUUpRV3pGdEN0?=
 =?iso-2022-jp?B?TjJXSXVYaUxCTXBsRFhEUXVYU0l2YjFGR3dEUHQxd1BDVGpvMkorb1dx?=
 =?iso-2022-jp?B?OEdxaDdOMnJwQXZSeWxVazBxU3FHclZpSE4rMXRrd09Bdm5vT1JiQWsz?=
 =?iso-2022-jp?B?NWlWeXplOGQ4Tm9KaEZiNVNnUUw5VWMzbGNjaVNTYWRrOUNQQ1laL01Q?=
 =?iso-2022-jp?B?V1hYWCtSb2JhdjkrelBsRy9HZnZqQW9DUlhDbW1YWHd0Yk5rS2pTeTB4?=
 =?iso-2022-jp?B?a1kzWkhzb3plc3A1SEFuQjZ5M2NMS3FKSngySDBXaVJ4MkRBWk1GYlhw?=
 =?iso-2022-jp?B?eVVGeGo2ZjJqY1RETUhZYllZcmxWV0xSZ2hEU2Z3aGRxSmRyYllLalI3?=
 =?iso-2022-jp?B?cVlHZSttTFUzVzQxdDBTb1pIdjhZcG5jYVVQYm5YbXFxWHEyNmVwZHJ3?=
 =?iso-2022-jp?B?YlI4QnlpZGxwTVlFVk4vWGprNDFoaEpFTmtWTTR6M05vbDJnZlhPeGs4?=
 =?iso-2022-jp?B?aFFQTnJLQ25sVGVSaWtIZHZTMGVMajkvZVkvb1ptWG1zeEhrcmRWSFhi?=
 =?iso-2022-jp?B?cEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y1JFbmtqWFVjRTJ1WkVzYWJBUzlXMmoybG9MTGZTUUR2WFZzajlvWDZX?=
 =?iso-2022-jp?B?QzFIemRyY25wZHBGbFY1TExSdXhTVzlZR1VpYlpWRFdSMHAveVpJdTJI?=
 =?iso-2022-jp?B?RXRaSzhlUjVLdnAxa29VL3I0ZG1XUlBodHJWNzhhZjhJbHpFZG5PZno5?=
 =?iso-2022-jp?B?bUNtRUpDbENNMTBtVE5kLzJwcTR3R0NubWNQWlVpOVVWUUFONnhGODU0?=
 =?iso-2022-jp?B?dXZvUWZYTEJSYXNIU0RWMW56QVkwRTVQVFFMK0lwbGZDS0F4dzdieTgv?=
 =?iso-2022-jp?B?UEgwUDUvZmc4QURueWhkNVpNWVlJQmRzaVErL2VrRFcyQ2ozNXNaT2tn?=
 =?iso-2022-jp?B?aDZ4N2V5b1I3TmhwUHhOZFRLQ2dZNXBpT0EzTzc1MUcrbjM3UWwrc1A1?=
 =?iso-2022-jp?B?dWw5TzZ6cXE5RURVSzRVVnRFbXZ6YnN1ejlZM29WV1VyOG9TTHluOVhW?=
 =?iso-2022-jp?B?VVJKckNZQWJNKzk1eEhsNE15NnJxaERLQWRTelRMMnJpa0MwTDF0SFk2?=
 =?iso-2022-jp?B?azh1SW5JZVBHdlpXTFRBNGxOeGY4alhIMmY0RFEvakl3d1MyZTNuUzJw?=
 =?iso-2022-jp?B?SnV5a2EzOE9xL3pzdm9YOW5NZ0VEVUhBUVBVUTJ2WU5LazlXa0d3VWNk?=
 =?iso-2022-jp?B?cWUzVWI2ZlFNM2N3d3lvV2JTNXArS1dncU9GY1pVU2V5MjRFSW1EWGxl?=
 =?iso-2022-jp?B?eFdQWCtRSTJvSXNlTldJUnpxMzRZbkUyclV0WEtacXNnQjBmZWtXYmFH?=
 =?iso-2022-jp?B?WmtFUnZ4WXM0aFNQR0RURmdzRzdvUnhsTEJ6di8xUzVESndadlNhQVp5?=
 =?iso-2022-jp?B?ZFlISUxnSmtCME8wZGQwSk94RE8vUXJhUnA1NGkxMFJwWDU1RXpjcUZa?=
 =?iso-2022-jp?B?NTlZcXk0VWhxaytvVFYwRUU1M0t4L1FWZmlMcFdIaC84ak9WRkdNK1Qx?=
 =?iso-2022-jp?B?QU1YWWd6Zi9wMlBKVGpCWlhDVXdYdFg3RXNkVllPOHNWR2UwSUcweHN6?=
 =?iso-2022-jp?B?L0M4YTFQOFdmZTFya2tJVUQ4RUJ0WGlydGRLV3ZTVlVoRFJ3R3hlaWt6?=
 =?iso-2022-jp?B?cjNsU2daSTJWTWtwcVpaOXhTek5UTW9tV0VaeVB0YXliTzlrTDVEZFJY?=
 =?iso-2022-jp?B?Y2VFUW5HNjNsdTErL2FlNEIwOWVxOGJEK1hWSGIwbVlEbkxTNDRlOUg2?=
 =?iso-2022-jp?B?anZEaXlCa2xKZEltODJJQmNrSU9TZFliRjJSLzlneEwzZnBqVmMyUkRo?=
 =?iso-2022-jp?B?UzZ2aGQ5Z2w1Y2EzbHVBS1plQ0tDNzdHa0JmbUIyUzhUME0yMCs4a2Mv?=
 =?iso-2022-jp?B?YVNneFhYam10dFdOdWZxNk85YmdQYWhYOUJZVEdHTlVBN21tMlNRanhX?=
 =?iso-2022-jp?B?YkdQU3M0V1VOU0t1U1c5ZVpITFZ3NWJ4QU41ZHJrZXdnOSswUFV5VnZ2?=
 =?iso-2022-jp?B?WU9aZy83cnNtOG1WQVQvUnVIMUprd2JlcEwza0RUTlNzd1o3RU5rMnYr?=
 =?iso-2022-jp?B?YXYyVjhuU0ljSHBWT25TeTFXdERRUFlQcVVKeDltRy9YTUMwTHNJTHR2?=
 =?iso-2022-jp?B?Q0JYc09FR0FmVTI2L3FWNjZhK3ZoeWNwVFdvSW5NTzZuODNCQjNTeTNE?=
 =?iso-2022-jp?B?QVNRTzh6K3BxZ3lDQ0U2TFh5TWRldXlOTzVCM2NkTWNrZEREdFY0ek1S?=
 =?iso-2022-jp?B?NnEvamlKZmZFRExwS3Zib0NSa2tZQk5MS2JTK3RkTjc3RHRKWnoyWnJ6?=
 =?iso-2022-jp?B?WnBwd2NJTHcxSVM1dmIwaUdyNWJhZUtnYUVUQ0w1dXJMRTE5cnZvUGdY?=
 =?iso-2022-jp?B?RGxoTjkwc3lGNWJWTkowL2JyNkdBSEVOcWU0b3pFN1lSMVVtTUE1OUll?=
 =?iso-2022-jp?B?aWhwN3RUSDZmMnBjK00rQmxPMUQ1UlFmTjZaVzM4QXREck1Ka2pnczJW?=
 =?iso-2022-jp?B?Q0o3cmxURmlpY25kVHdvY1kvMTdjbTNnaFk5eDM2bE5MNGRiNzJXajNm?=
 =?iso-2022-jp?B?aVBkMFpUWTIvbnkzMnl2QS8rOVhMbUZ1aW8rSytJWjM4UWRKbi96dU1h?=
 =?iso-2022-jp?B?T1Yyam0wRjBvdXFxNlJBUEVEK3RTSnlOQVM1SG02QkhGZHJNOEk0cGNh?=
 =?iso-2022-jp?B?RVNEdzRiUmRFb2ovazE1elpQYWh0T3dPR01ZZ1liVEVGZUhSUW4yNzBT?=
 =?iso-2022-jp?B?c3FVYUk1UlAyVXNRdmEzUFhDY245QXdzdzgyb2FTVlgySm96U0hoVWUv?=
 =?iso-2022-jp?B?Rng3em93bFZHc3lwaFRVOWY4NXhkQlpNSkR2cWkzVnRXaG9HR1paL0Y3?=
 =?iso-2022-jp?B?NWY5dWc0S1VqZjZRdXhMODJKMWRhSTZBWWc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103FB47A8576B2CFA3275F6C2282OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfab606-5b84-4e72-e8c2-08dd0ed3b4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 11:07:38.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo6cUIL6N7jvdz5SvVkcaLjmU8bnbUXqOwApyBOVXioCWq5+BQWCV2RX2GkZ7aHjfxY43BO965EJaGufJeqkdDEIpuXt6KJudxHChHye7Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 11:07:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17287

--_000_OS3PR01MB6103FB47A8576B2CFA3275F6C2282OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

We are planning to run software update, secure boot verification and IEC la=
yer tests on M-COM x86 device in CIP LAVA.  To achieve this we believe ther=
e are two main challenges.

Booting a disk image (.wic) on M-COM x86 in LAVA

We went through the existing job definitions running on CIP reference hardw=
are on LAVA to re-use if any disk image is being booted on them but did not=
 find any. In every job definition, the root file system tarball and kernel=
 image are deployed separately to tftp. We are going through LAVA documenta=
tion to figure out proper method to boot   entire disk images on LAVA.

Can you please provide your suggestions on how to do this, if you have any =
?
Once we are able to boot a disk image, then next task is to boot a security=
 image.

Configuration of BIOS settings on the device's firmware to boot a security =
image

Basically, CIP security image has secure boot feature enabled, so before bo=
oting such image there are some settings that need to be done in BIOS such =
as:


  1.
Enabling secure boot option
  2.
Adding secure boot keys in EFI storage.

Only after these steps, a security image can be booted on M-COM x86 hardwar=
e. I am mentioning these steps based on our current experience with local s=
etup. But I am not sure how to achieve this on LAVA.

One idea is to pre-configure the above-mentioned settings in the device pre=
sent in lab-cip-siemens-prag but in that case I believe health-checks and a=
ll other tests running on M-COM x86 can boot only secure images.

Is there a way to change the bios settings through some arguments in the LA=
VA job definition ? If not, then can you please provide your opinion on the=
 above-mentioned approach.

Thanks and regards,
Sai Ashrith (T S I P)




--_000_OS3PR01MB6103FB47A8576B2CFA3275F6C2282OS3PR01MB6103jpnp_
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
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hello Chris,</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
We are planning to run software update, secure boot verification and IEC la=
yer tests on M-COM x86 device in CIP LAVA.&nbsp; To achieve this we believe=
 there are two main challenges.</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14pt=
; color: rgb(0, 0, 0);">
<b>Booting a disk image (.wic) on M-COM x86 in LAVA</b></div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
We went through the existing job definitions running on CIP reference hardw=
are on LAVA to re-use if any disk image is being booted on them but did not=
 find any. In every job definition, the root file system tarball and kernel=
 image are deployed separately to
 tftp. We are going through LAVA documentation to figure out proper method =
to boot&nbsp; &nbsp;entire disk images on LAVA.</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
Can you please provide your suggestions on how to do this, if you have any =
?</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
Once we are able to boot a disk image, then next task is to boot a security=
 image.</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14pt=
; color: rgb(0, 0, 0);">
<b>Configuration of BIOS settings on the device's firmware to boot a securi=
ty image</b></div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14pt=
; color: rgb(0, 0, 0);">
<b><br>
</b></div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
Basically, CIP security image has secure boot feature enabled, so before bo=
oting such image there are some settings that need to be done in BIOS such =
as:</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"direction: ltr; text-align: =
left; list-style-type: decimal; background-color: rgb(255, 255, 255);">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"direction: ltr; margin: 0px;">Enabling secure boot option</di=
v>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"direction: ltr; margin: 0px;">Adding secure boot keys in EFI =
storage.</div>
</li></ol>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
Only after these steps, a security image can be booted on M-COM x86 hardwar=
e. I am mentioning these steps based on our current experience with local s=
etup. But I am not sure how to achieve this on LAVA.</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
One idea is to pre-configure the above-mentioned settings in the device pre=
sent in
<b>lab-cip-siemens-prag </b>but in that case I believe health-checks and al=
l other tests running on M-COM x86 can boot only secure images.&nbsp;</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; backgroun=
d-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Is there a way to change the bios settings through some arguments in the LA=
VA job definition ? If not, then can you please provide your opinion on the=
 above-mentioned approach.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Sai Ashrith (T S I P)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; background-color: rgb(255, 255, 255); margin: 0px; font-fam=
ily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sa=
ns-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OS3PR01MB6103FB47A8576B2CFA3275F6C2282OS3PR01MB6103jpnp_--


