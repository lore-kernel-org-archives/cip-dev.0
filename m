Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C5DC54E5D
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 16:13:32 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.84])
 by mx.groups.io with SMTP id smtpd.web10.443.1710260009682128312
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 09:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Y58GcnyV;
 spf=pass (domain: renesas.com, ip: 40.107.113.84, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU40Qsd0g++niWeWwTwBWXKEuRLZiZrCGit6inFUX4Zvtuv7jHMzua2HpBH8mk3qwpuOu5WeGdB988ytD2xrXQKJUiBB8308Yj/AyVyTQb2oSs/KBeOOjAdIXpUy/wxwGk1ct7xG427L1xWWszljwuVQ4H5VffVE73Wrp1Mb5hEfapQsXR5sC9HHbfFGim5K4zfjvAcM2yn0LB1QUpD0L8Lmm6k7DtEemt9JwzSWIzF/q9IzglAMJ5R7Z+9NGCQey/8D0O9am5ngNq+0fq7FgsHengqWqtJ3RlKo1LtXzuMzAihS9fGPYvOkfDD+pNH1CWxUt1s7apWAeC6ZrVG9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE0AM7cMYss34ORsOpyV0EMoZBJs/FEiXO159UbWMdY=;
 b=KXUCIylDYf/lJIeHHKckzcHyBMjGTLi4O0ZxnI96O0Z25ZXtZ+1RdPbFZJC20RSjH8+w6zf8nijTIAJWE2D1lEj1aRZqBasuQIS2fz9QMKdEV+lPJirWxXanX+UteG2DLQvWqon8RoA+dV5MlAKrSamkZWxERaSqhRKEoKLySIwc+yYvIUPQxvFVfR7O7B1RD8AOjjQLuY+DUveCe0PagIt6bEc78VxfxIh/K/EEpISnmUjUO9pmpbC933I5ybEYPChVFeIRJpj1pm/+Gsi+da0QCS3WpU8Ui47YTBPEM80t4crjbZnvl4oBTF29Lr5YLSnYiu8kRUfqb1ABe54O2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE0AM7cMYss34ORsOpyV0EMoZBJs/FEiXO159UbWMdY=;
 b=Y58GcnyVwQZOMJWKciCqcOqBuU4Qq5/+SaUajadRRkU0ATej/LiS3R0g5cA/70HgX35lmxGmyzmF4t2BTQSuwOuW0QF7ljAsVLd70QaKCmkMlVhxSTuBSGBYc2sWY++tty0S+J3P+UlwIy5iAGJk1XBiB4QLmxadc30R7T2wfgQ=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB9924.jpnprd01.prod.outlook.com (2603:1096:400:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 16:13:25 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:13:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Denys Fedoryshchenko <denys.f@collabora.com>, "kernelci@lists.linux.dev"
	<kernelci@lists.linux.dev>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Alice
 Ferrazzi <alice.ferrazzi@miraclelinux.com>
CC: Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux
	<llvm@lists.linux.dev>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Migration to Debian Bookworm and compiler updates for KernelCI
Thread-Topic: Migration to Debian Bookworm and compiler updates for KernelCI
Thread-Index: AQHacH7/n2Ag13u5ZUyTcceS9/RhyLE0TpDw
Date: Tue, 12 Mar 2024 16:13:25 +0000
Message-ID: 
 <TYWPR01MB11862CF20936D7CD75B2BDF87B72B2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <42c7f5a3e07c274c2a9d2e45a973c6306b2ba74f.camel@collabora.com>
In-Reply-To: <42c7f5a3e07c274c2a9d2e45a973c6306b2ba74f.camel@collabora.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB9924:EE_
x-ms-office365-filtering-correlation-id: 62f4e30f-92cf-4669-4c6b-08dc42af589b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gtE1rsDnLyGXZHKLwHYs/V0rY/tTOcDdqqemjmVzK3///AQ73HV+BYsv3nFWB8++IqPFpoyOejvSaiWXn+dJEsM2s33I5GEMfSVqOihf39+v0jcKctjI9AO99sYo17lfa9xKUL4EVpEKfrM4ySf5GiaPZoolr4JSAQSSgbebWXpjt3vh3QCPWsUaw4Mtj9ZY8m7LMpY6NbwSyfZd3XJ93eH+cIcL8Pb6NJ254LDagjP0eB56z/Q0DlisnNZGAHNNODlbQAJ+48OOjLn18wp7gCU+O0vNmipJCcUbOVfgMlB7+9/rj+fZGzs/uGGfWUIRCn8YzRNcUy+JeU45GgxzaUGjNBrfpmU/Ixud+PoFWC7P+/O5LZZiGlgqS1nBufiv5C0u1R4X22ceuPy8ZqWbXMfNEfayWbqMIaRwqShFD+EhU51IRZa4JX1oDFksu8yqH8r51EbsXp9MNsnVPnl0fYSQCViQfLetH0kF5/RGUA1rMmVlaxyo9aUwS/beKs+nZPyf56XuTCVZrjrTG9QAiyULHqluitwIMGoDQ8HpPte7LUdDeNxFSUrGs0LMnb8Ss5K+HSz7SXKBhhHWPqhx+SE1Q17bkHpKT7VVMWDO2vfOP6uKl/3L88wwJun5pvhI2tuEEbS8LzriIavwiWW2C3w7uChVLd4KqyIPb4NM6xk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ajAwa2ppQzZINEpCRDhXM1dyRVRlV1o2V0tBMzNjZWY2VXlXUEVTd3RFa05r?=
 =?utf-8?B?U2lBbkU5eVVrWTJUSENQdUt6SzR5NnRjSlZFeHJuTlN0N1dzOUFuS3lQSFZ5?=
 =?utf-8?B?SEFnaHBZU2V0ZFd3TUh6UTJZVE9Jdk0wMmZLbXh6M1dzSExrVHNUVkw5aW1Y?=
 =?utf-8?B?cEl0ZlZyRjlvalNCemx2d0ZlWEs2K1pZbXNLL21sRkpQUmFxaFRSN3V2NFVT?=
 =?utf-8?B?T2s3ZFpPYlNWdnowdkc3dDdZUXNWNTlISE1Wd1Z6dGxPUkxhcVhtT3QvY1FB?=
 =?utf-8?B?Ykx5b25nRmJDOTAxTnh6ZDhiVHZBU0hoV2l2SXI5dmd2SUY3V0wzTHB0eGF1?=
 =?utf-8?B?SHB1dXNtNzZwaXpNdUsvZ3FMT29hY2dXUVV5Wkg1Sm5WMXY5eXdUR1hSUUJn?=
 =?utf-8?B?S1dpaExDUEswdnZodUpKVEdLRFZhWFk4UVplSlBLL1BuZ0VLWjMyK0ZsZEwx?=
 =?utf-8?B?TVd0dlR2YVZUOXp5eDNkSmdXa2pOZWM4OXllSzZGYzNwemNkTGJmY2JFZE5n?=
 =?utf-8?B?NG5LdkxkT25CV3BwTVh0dXlFbXdiTzV2Y2VnU0crV3dPZVdmcDdyR2ErRHdG?=
 =?utf-8?B?TjZsenp5SVQ5TDlLT3htS0ZYeUhvVVg0aG85THdUNWR6QUM0NFF6K01ZUjhR?=
 =?utf-8?B?QzdBcWJnYmNQZkhiN1JJcDYzaU5QajNmeUVUSG9uUUNrenl1bWNoSGgzTTcr?=
 =?utf-8?B?bjFNdjh4UXNQMXR1NFVqVW5vUEpJb3RETFhDVHl1Nm56YVZvRkd6Y1FvQ2pM?=
 =?utf-8?B?SDh6K0lKYnNML3Bsb3QwbS9XbU95REI3Y3lGQkVRKzRZdDJ6RzUrOHNuVjB3?=
 =?utf-8?B?Mk1sK2t4WkFVcnZqVnV2N2VUQUtjajRXdElWT1o0TnZRWUliQUhDV3YzZVc5?=
 =?utf-8?B?UndLUUtINlFqamdFSFQ5VTJZZS9zWlg3MHc4WUpDdjM1cTZnM1JqWnhXZlB1?=
 =?utf-8?B?VXBKNEV6UVdqdmRQT3VoSVM5N1RqaHBUQks0Qm1NZlBla3I0UGwvUVRFTGpW?=
 =?utf-8?B?OXl6a0NpbnExTCtRQ2ZvNlhWREM1b0d2RDNnS2duajJQS04yWlh2QzB4REZ4?=
 =?utf-8?B?Y0MyaWxEenQxd2hUK25CTDlKODhkcDVNN2xiSG0vc2IzSmlLeXpPM2tCd3BY?=
 =?utf-8?B?dDhjalk0RnJiUkVCUlJLMTA1M0U3dHNEUGFkUHAySGRCc01tbzhwNHEvY1lj?=
 =?utf-8?B?aDVodi9UenRla1NnSmJWREwrcVYzUU9MUEJwRGFrS1lXc3lhYVpYRnR5cFRi?=
 =?utf-8?B?cVU3ZjZKVkw2QXcrbVB3dmNFMUNPcE5JL0YvMjhaWFBtRE05cXo2OXhZQ3B6?=
 =?utf-8?B?aVQ5YTEzWElsRm1DYUs1djU3SXB0QTJCZ0lEQjM0dU0zZXZEOUlDc0pldlRO?=
 =?utf-8?B?UWd6SVc5K2JDUVgxeE9MSXZINzBuOEZ6Wi8wbU5JajF0dDcwS2RQeFR5UUpN?=
 =?utf-8?B?cEh6UC9qdU03MHFFMlBvZ09uSFZHa2JNRkRacGtXWEJiT21FTE52U0hTSEYv?=
 =?utf-8?B?TUlvbWI2YkxFVHZNZHRRaDU2S1czZVRVR0NsUkFScllwQVo5d1dicHR2S2Vk?=
 =?utf-8?B?RlFIcFZMdzU4RWc2VzVKanU0M093MjdqRVVwY1VTbW1mL2QzY003MlRYME1Y?=
 =?utf-8?B?bWFXeGc3eVY2eXVDdDVBNWdkUnRuRmxaKzRKQU5QNWU1V0h2ckxZVGIzRHNG?=
 =?utf-8?B?cGd0Z0UrZ3R1ZzZpTUJYa0U4WHNxVGlLa1J0K1owY0Mwb2lOOU5pY2xrSGIy?=
 =?utf-8?B?S3RaRlh6VVJheFl3OUtvVUk5VUpzVHdNNFZ5blFjeTFNWk14aDc0Z1QxMmlZ?=
 =?utf-8?B?WmlGTkhGQmxxZWkxeWhpYU5YajJ0NEZhSkJKYkxpTXRPMG45WVFtcjlsakMr?=
 =?utf-8?B?citqdUdHQVBKM050d0dQZklBYVUwT3VSQWNhU21nN29rUVBSRFROOFVoQi9w?=
 =?utf-8?B?N1dMbkR0aGU2bDlJVDlqRmYxWjFQTlJ5NXRZRXpJL0tKSUtBRlhvYzJ6azhW?=
 =?utf-8?B?c3p6enlEU0FnUEpZTzRhT29EME04aS9maC9PVE53WFlzNVQrQ2FlYWNMZmkz?=
 =?utf-8?B?L1Q5NDBYeGpKUEpvQ1liNUpKLzlVUzJ0TWpURXg0YWdkQXk4VkJNZkZ4cGxk?=
 =?utf-8?B?S3preXJMZ0VSalBjbjdVLzNiYnNES0RmeGlodjJMdXJIeGZnT3NuYjE3Qnh3?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f4e30f-92cf-4669-4c6b-08dc42af589b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 16:13:25.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1HY8lFjjbQAVfan5C90rDGGYk0V/LCmxDM06MTM7rFofg2k/sa/0Q16ibPZlaEdJvKsN5ubAuB50/iju/4jCwJF1mgmyDDvcFLnV4wlREQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9924
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 16:13:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15278

KyBDSVAgcGVvcGxlIA0KKHNvcnJ5IGZvciB0aGUgZGVsYXkpDQoNCj4gRnJvbTogRGVueXMgRmVk
b3J5c2hjaGVua28gPGRlbnlzLmZAY29sbGFib3JhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDcsIDIwMjQgMTE6MDIgQU0NCj4gDQo+IEhlbGxvLA0KPiANCj4gSSdtIHJlYWNoaW5nIG91
dCBvbiBiZWhhbGYgb2YgdGhlIEtlcm5lbENJIHByb2plY3QgdGVhbSB0byBkaXNjdXNzIG91cg0K
PiBjdXJyZW50IGNvbXBpbGVyIHNldHVwIGFuZCBwbGFubmVkIG1pZ3JhdGlvbiB0byBEZWJpYW4g
Qm9va3dvcm0uDQo+IA0KPiBBcyB5b3UgbWF5IGtub3csIG91ciBjb21waWxlciBpbWFnZXMgYXJl
IGN1cnJlbnRseSBiYXNlZCBvbiBEZWJpYW4NCj4gQnVsbHNleWUsIHdoaWNoIGlzIGFwcHJvYWNo
aW5nIGl0cyBlbmQgb2YgbGlmZSBpbiBKdWx5IDIwMjQuIFdlIGhhdmUNCj4gYmVlbiB0ZXN0aW5n
IHVzaW5nIGdjYy0xMCwgd2hpY2ggaGFzIHByZXNlbnRlZCB1cyB3aXRoIHNvbWUgcmVjZW50DQo+
IGNoYWxsZW5nZXMsIG5vdGFibHkgYSBzaWduaWZpY2FudCBidWcgdGhhdCByZXN1bHRzIGluIGZh
bHNlIHBvc2l0aXZlDQo+IGNvbXBpbGF0aW9uIGVycm9ycyAoc3BlY2lmaWNhbGx5LCB0aGUgLVdl
cnJvciBtZW1jcHkgaXNzdWUgaW4NCj4gc2VjdXJpdHkuYykuIFRoaXMgc2l0dWF0aW9uIGhhcyBw
cm9tcHRlZCB1cyB0byBjb25zaWRlciBhbiB1cmdlbnQNCj4gbWlncmF0aW9uIHRvIERlYmlhbiBC
b29rd29ybS4gQWRkaXRpb25hbGx5LCB0aGUgbWlncmF0aW9uIGlzDQo+IG5lY2Vzc2l0YXRlZCBi
eSBvdXIgcmVxdWlyZW1lbnQgdG8gdXBncmFkZSB0byBhIG5ld2VyIFB5dGhvbiB2ZXJzaW9uIHRv
DQo+IHN1cHBvcnQgS2VybmVsQ0kgdjIgZGV2ZWxvcG1lbnQgZWZmb3J0cy4NCj4gDQo+IEhvd2V2
ZXIsIGJlZm9yZSB3ZSBwcm9jZWVkLCB3ZSBoYXZlIGEgY291cGxlIG9mIHBlbmRpbmcgcXVlc3Rp
b25zIHRoYXQNCj4gd2UgaG9wZSB0byBnZXQgY2xhcml0eSBvbjoNCj4gDQo+IDEpIFdlJ3ZlIG5v
dGljZWQgdGhhdCB0aGUgbWluaW1hbCBhdmFpbGFibGUgdmVyc2lvbiBvZiBjbGFuZyBvbg0KPiBo
dHRwczovL2FwdC5sbHZtLm9yZy9ib29rd29ybS9kaXN0cy8gaXMgMTUsIHdoZXJlYXMgb3VyIGN1
cnJlbnQgbWluaW1hbA0KPiByZXF1aXJlbWVudCBmb3IgdGhlIExpbnV4IGtlcm5lbCBjb21waWxh
dGlvbiBpcyBjbGFuZy0xMy4wLjENCj4gKGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bmV4dC9wcm9jZXNzL2NoYW5nZXMuaHRtbCkuIEhvdw0KPiBjcml0aWNhbCBpcyBpdCB0byBjb250
aW51ZSBwcm92aWRpbmcgY29tcGlsZSB0ZXN0cyBmb3IgY2xhbmctMTMgKGFuZA0KPiBwb3RlbnRp
YWxseSBjbGFuZy0xNCk/IFRoaXMgaW5mb3JtYXRpb24gd291bGQgYmUgdml0YWwgZm9yIHVzIGlu
DQo+IHBsYW5uaW5nIG91ciBjb21waWxlciBzdXBwb3J0IHN0cmF0ZWd5IG1vdmluZyBmb3J3YXJk
Lg0KPiANCj4gMikgV2UgYXJlIGFsc28gY29uc2lkZXJpbmcgbWlncmF0aW5nIHRvIGdjYy0xMiBh
bmQgd291bGQgbGlrZSB0bw0KPiBpbnF1aXJlIGlmIHRoZSBDSVAgKENpdmlsIEluZnJhc3RydWN0
dXJlIFBsYXRmb3JtKSBjb3VsZCBwcm92aWRlIHRoZWlyDQo+IGVuZG9yc2VtZW50IGZvciB0aGlz
IG1vdmUuIFNob3VsZCB0aGVyZSBiZSBhbnkgcmVzZXJ2YXRpb25zIGFib3V0DQo+IHRyYW5zaXRp
b25pbmcgdG8gZ2NjLTEyLCB3ZSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgZGV2ZWxvcG1lbnQN
Cj4gc3VwcG9ydCBpbiBidWlsZGluZyBnY2MtMTAgZm9yIEJvb2t3b3JtLiBJbiB0aGUgaW50ZXJp
bSwgd2Ugd291bGQgbGlrZQ0KPiB0byBpbnF1aXJlIGlmIGl0J3MgYWNjZXB0YWJsZSB0byBjb250
aW51ZSB1c2luZyBvdXIgY3VycmVudCBnY2MtMTANCj4gaW1hZ2VzIGJhc2VkIG9uIEJ1bGxzZXll
IHVudGlsIHN1Y2ggYSBtaWdyYXRpb24gaXMgZmVhc2libGUuDQoNCkphbiwgSXdhbWF0c3Utc2Fu
LCBBcmlzdS1zYW4sDQpEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHMgaGVyZT8NCg0KVGhhbmtzLCBD
aHJpcw0KDQoNCj4gDQo+IFdlIGJlbGlldmUgdGhhdCBhZGRyZXNzaW5nIHRoZXNlIHF1ZXN0aW9u
cyBpcyBjcnVjaWFsIGZvciBvdXIgcHJvamVjdCdzDQo+IHByb2dyZXNzaW9uIGFuZCBlbnN1cmlu
ZyB0aGF0IHdlIG1haW50YWluIGEgcm9idXN0IGFuZCByZWxpYWJsZSBidWlsZA0KPiBlbnZpcm9u
bWVudCBmb3IgdGhlIExpbnV4IGtlcm5lbC4gV2UgZWFnZXJseSBhd2FpdCB5b3VyIGZlZWRiYWNr
IGFuZA0KPiBhbnkgcmVjb21tZW5kYXRpb25zIHlvdSBtYXkgaGF2ZSByZWdhcmRpbmcgb3VyIG1p
Z3JhdGlvbiBwbGFuIGFuZA0KPiBjb21waWxlciB2ZXJzaW9uIHN1cHBvcnQuDQo+IA0KPiBUaGFu
ayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbi4NCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gDQo+IERlbnlzIEZlZG9yeXNoY2hlbmtvDQoNCg==

