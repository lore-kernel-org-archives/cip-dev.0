Return-Path: <jimmy.chen@moxa.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E0C4708C
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (APC01-SG2-obe.outbound.protection.outlook.com [40.107.215.55])
 by mx.groups.io with SMTP id smtpd.web09.3949.1649839515085205681
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 01:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail, err=mail: missing word in phrase: charset not supported: "big5";
 spf=pass (domain: moxa.com, ip: 40.107.215.55, mailfrom: jimmy.chen@moxa.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URRTrBo8Xomi19cK9ji37lARiSsmLvBLpdqtqRps3m0lb5vgOVxxijnb08nF3zrl8tUSjqlQzl+otHB6rXO8S0QqcJO3fwcIyf2MhOonabhnLrsjHafSUA5mosqtk5yhxwsplxxhWBfsPxfElb/XQeiR06Jwwk+ID3VsOqGknVFHdEcCUDwaxZWnenmYRDVXmZyaBi9YdeJYq7jftWEAGZUDbrQ666OU3+TOR6sLL2PeeDm26vz3J/EUrSE37XTlgDKk0lVi+Hww5We4aOlGXOLLR1zhl6ULGBCZ4wO53ZXU5uFcNDHwA8swxvalWJO6HAjPkOUp1oqBQi9ir8lDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maKrnubRbEXo5rHlU2cwsWpoEVx2niLcc1ppcr6HP9c=;
 b=SAYihJgvekhpg3/0imku5/DssA3hXD6KkIm/GzX5JY4YzAoHARWgsQmD7GwuTmYyNA9h2hAls7JJ0PzbKUCaFxyXITduWoGOv/7mOPsi4r/FoL2WdfWLpsWI7yJNocAkR1Zfi4z5hcQlShJp6NejE5rxPSzRnOxBtXtDJks5CGRtTZVtDevprwCRePqGBdupAIAk7Qp/kBcXsRpThMT4BhVD4RMVbTMFleAIs0OTyPOYXVM9UTGVSb0qF4hO+fmvOSFW/L0JLQMC03LhXvRMl2dgm6Y41NdntW64NDiOk0OfdnyvCuuiJbJBf5k+jzsUZklE1b9uNlPibhFFWO4F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maKrnubRbEXo5rHlU2cwsWpoEVx2niLcc1ppcr6HP9c=;
 b=fOvKkidHhsE4UhduUz+h+Y1GPZGocJyaUGszfldMs2WwzCBQiLzST2insg3ISgfu6XX6I+bkev3MMAgOpYeJRlR+tPpkfwDC/PZKaGZCSBkFelB3q40eXgo5k3enc2dWktV04rlnxUkWQ5/e1mx/EaQqmL1jr2I6TIUD3q4fgPQ=
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5c::14) by SG2PR01MB2330.apcprd01.prod.exchangelabs.com
 (2603:1096:4:44::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 08:45:10 +0000
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::6991:a986:a5b4:b648]) by SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::6991:a986:a5b4:b648%5]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 08:45:10 +0000
From: =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [PATCH linux-4.4.y-cip-rt 1/2] arm: dts: moxa:
 am335x-moxa-uc-8100-me: Add new MOXA model
Thread-Topic: [PATCH linux-4.4.y-cip-rt 1/2] arm: dts: moxa:
 am335x-moxa-uc-8100-me: Add new MOXA model
Thread-Index: AdhE6AGHbtVr0uEWTkGm0vVbxo26SAKKrvwQ
Date: Wed, 13 Apr 2022 08:45:10 +0000
Message-ID: 
 <SEYPR01MB427277235B66D7F0856B5E79FAEC9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
References: 
 <SEYPR01MB42723C86A5D4FCC894BE3AFFFAED9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
In-Reply-To: 
 <SEYPR01MB42723C86A5D4FCC894BE3AFFFAED9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61067f3d-5467-41b5-7b0d-08da1d29eb53
x-ms-traffictypediagnostic: SG2PR01MB2330:EE_
x-microsoft-antispam-prvs: 
 <SG2PR01MB23302DF9A3BE8F153AB4ABC5FAEC9@SG2PR01MB2330.apcprd01.prod.exchangelabs.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RH6oCyuMYjfHxd5WpIYF7XZ/OI+yJXpXLkgF3/g1C9TBQL/jjC97zG00RKRxbtqIW62zJx4ruJYPNN9+Hl4PW3FuYbZXy4QE33S8F6rrwVms8KsMu+imH7oRBxxcF+oON2itxB2J6U5dK4PAMDSlNgkGTJche4XvAqGaMN9ftOmzcNcE3bWBgBP6S9k80lmqXVX/iHig3Koh5fujszw3akIqJf/As1n5F82Ce4x5aJMS3CgmqSb8kSX8Sb2xDBdHyA4TPELI/yWH2sqDIDLpLE2IuL9aIDsOVcfpsJa2WXBtzLBiIZblYHYScPPYGDNxzRjpG7N4H2DMBeM25nqOLK4K5oiY4BFD+aobiMhjvxlqFCd7hlk3AnjTlIEV/SReOdKV+mtnOVlOLB4b71+Px9PB5fgSkWu7ffpHrt9JnorRupgH30/9LdGQ5sv8uXbcgqiCffw1YkBTQ0oUoWzc92XwFE5w776+quOjrJk3HcSGxuenjBPCLgzFr8CYWPhuyEH3QUuUdcp39rj6wsp9++r8IpV2Isug2t+R3EklrAmJfsJ0oZFwV+qtmQyBRBNJDIYw3Jkl636X8BfkTDt4kzBMgCXz8bLfCtxQFpm8V/vhBV4o3VFg17hA3pfluyI1aTFo18PtRZLLBG4GrMcYMiXe/7ubo1uHtNEJGwNT3FnuPVdKgB7Fahd1Sq+Jaapt3NX7yW0vIeGukPkA7tueEw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB4272.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(38100700002)(66476007)(52536014)(33656002)(55016003)(186003)(26005)(508600001)(6506007)(64756008)(316002)(9686003)(7696005)(71200400001)(2906002)(8676002)(38070700005)(86362001)(66556008)(66946007)(66446008)(85182001)(6916009)(76116006)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?big5?B?cTdYci9mUkdkaVdwOWUwZHpGWGRSWG1rZUhMS1RLcnN4eGd2TU00SFFGMStMcXM5?=
 =?big5?B?dm9XNHFML0cyc1EySjl5eUpVQ2pFNWRsQXZsRDBaRXB1MXU0MzZaQWpnWk9xMzh6?=
 =?big5?B?bTVwUzEvNS9jb2JWUG9SRUhRQTkyRGZFNVphdm82akI1ZnpobFg3Qy9KMTdTL0I1?=
 =?big5?B?WHBieTByYzdPemVTSUduL1Z1NHo5emdKVlJwOGdTaWJtQW9CSi9rcDNBZ3R3UWlu?=
 =?big5?B?LzU3NjRRZGxqWStLamZNa3JUeDlzSVJhZVFQaDlqeVVNbDMzSWg2dGlURTZIb2s3?=
 =?big5?B?Q3pFcDFNUjZ5ZnhDSXZGMXcvNlJ5Z3VsZ3BCcElVaGhkRlhMNzVsWVlXK0pUanYx?=
 =?big5?B?THpDQmFqWXZ2S25CN0dzc1BMQ2NJZktqZytmVVc2eVhSRzJ4QWpqSVBWQ3NBaXlT?=
 =?big5?B?RjFEVTF6a2p6a2M0TENuMFVrbTc2RnB1VFlMMmxnd2hVVFJTSXZYaTcxT2VRVXd1?=
 =?big5?B?dWplTktGbnVvVEdFQzdtYlprbTREc3RaOStXNHdMV0xTSjhPMXRZdFhURjBBSlRV?=
 =?big5?B?NzRXWEZmQlhBZVRacFlvb1pHMTdBeitWTVV1RW5yVjJCMFZFT1VYcVMxenpjZlVx?=
 =?big5?B?MTh0NHhLUFQ4cWFMemt5bUtlMHNpdTdhVDFmUXdnSW5sVzJvMjJ1SlNsTUtqZVdK?=
 =?big5?B?QlZZay93b3FSRXZGYWtWNXVQUWkzeXhCN0xERkQ4dUMrTkNYcC81NHNaNFViQXgx?=
 =?big5?B?dkJWZHMwL3Yxb3pwankyL2dWTkdmNWdLZnI5UFUrdDlaODVmbi8wSlEzUmJXYkkr?=
 =?big5?B?d2xIMW1BajZpUW0vdWVwZk9MVWZ3UnNHZkxFSE5VTmNrM3Q0RHdvSUNoMmZ5WkR3?=
 =?big5?B?ZHh1a21iSGRVbFJLOUpIRDZQZWV3WUVJUThqd25nVVdhTlRTTkpwWkpFMkFmaFI2?=
 =?big5?B?eUxkTzhuUzhqa1ZLSjBJS0JjRWlsM3E0cm1pZ2kvSHE1dGkyRDVaTnRTK2tXL0tP?=
 =?big5?B?QU00UU9YR3ZCa2tqbC9Ma1B2VjBmdVJLT2p5WFczalFsY3FZc0JvM2x0NStQdFI2?=
 =?big5?B?VnZzak1yUHpLTVk1ZkpMbXFjWlRGc0RWc3pMNkNDUFJVUjMrOUNiUjRkdDhBc1FQ?=
 =?big5?B?Ym1VWVFZUkJVclJHUDNGL2NOQ0xmOVdOZ0Vxb1pkaDlBQWxjVjNzWUptZEI0SFQ0?=
 =?big5?B?Tk5tN0ppUk52bkFRcTFydFI3ZWlRMDg3ZUNhKzlWSXgrUFNjQWdINnk4VmhiRWUx?=
 =?big5?B?OWpPMHRkK1R4K3hxRGJ5VFcwbGpRQlJzd3Q1MVNWb3drMHBxdFhNQ1Q5L1NBYytB?=
 =?big5?B?QUxmQyt6ckp2MDZXeFlvZStsR2FsbmVMSUxDR3liZWNHZDhpdkZwNlpmbjhMM1VK?=
 =?big5?B?cWxiQlRKa0hPdHpCUnVkYUg0SmtuVlNMcUhxNU9BQXVxSWcvYlVtODArT09zN0xB?=
 =?big5?B?azZKaDJnaTFLVFlNckNDTmQzVnFWaEhkRDFZTFhVYjFZc0czRnhvVXBjcVdpOUNx?=
 =?big5?B?RjBkUkxjWW51N0JCVCtjL0VSS2psUW5VVml3eDVrUHFrWlh2cUNrMVVFTkpUeWpC?=
 =?big5?B?VmphWW4zQ0JhTEpXTTZ0VFUzcFVTY0tIb2pXcmw4MkQ0MmJ5QTBnQXNzZU8wTmsr?=
 =?big5?B?ckt5em5xcENMNld1TnZCL2RDRkhTZE45UHIyRkZaQmNEMXNlbnNBaHFqcVNpVURB?=
 =?big5?B?YjYvT3BjN3NOejI0Yk9ERk1odzcwc1BNKzVCRGxQa1pJdlNIVkhvZDhidnpZYk1K?=
 =?big5?B?UmZNNTd0VkQ5eVl6WVMvRERBU1ZMdk1icW9KWjFsemYyUnZVMHpjenVEb0NzWHJS?=
 =?big5?B?NnRJVUk2T2J2MVFhWEpOcml3aVRDYmhHQmxHOUtYNkUrSHpMeGVPVXVWdVJsTkxP?=
 =?big5?B?TGVCQWFTcGNWSndPdEp3YUpPbHhabU9KSnNGeHBpNGkvdWk4aTkzVEM5UFJFYVo0?=
 =?big5?B?UGVtSzVzS0o2RFJhNVVWakZJLzFvYTkzdWZnWEhxUGdWRzFLYTcwUzRxcHc2aHU1?=
 =?big5?B?RmREVjNDdjc1eDBqeFJHOW1waFJoMTdmYXFJZGg0clMrQXFVN0NCVFByMGZtbmxD?=
 =?big5?B?aFozcGNZMGh6SlRwUDNmTXpHbHBDdGdUQU44bjcySVUramFkUU83QWpMdlF4cDd5?=
 =?big5?B?WXpSb2VqcG9Zd0lqZ3VXenI1dHhCVTQyWTB0d3RSTnFTZzdsNFdKYVBKUm5Vcmw1?=
 =?big5?B?V3djM1p0M1BFdE5zcU0vWldLVDBDc1IzUUdWbVByOUFLanFKZVBZQnZWeE5TelZP?=
 =?big5?B?c3JRUElwQ0x1Q3REUkV3UVVWT2duZz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 SEYPR01MB4272.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 61067f3d-5467-41b5-7b0d-08da1d29eb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 08:45:10.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 AT5adOhzC0kEGM1lkV0j9G+c/oXYlJFoYS8fOgeFpm3kZNwiuUdZhUKaSkhF8NyEL5M32EJSz7NOzdaUmmD/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2330
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8070

QWRkIERUUyBmaWxlIHRvIHN1cHBvcnQgbmV3IE1PWEEgbW9kZWwgKG5vbmUgLXQgdmVyc2lvbiku
DQoNClNpZ25lZC1vZmYtYnk6IEppbW15IENoZW4gPGppbW15LmNoZW5AbW94YS5jb20+DQotLS0N
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL01ha2VmaWxlIGluZGV4IDBiYzdhZTkyY2RmNy4uYjcwNmQ0NzQxM2ZmIDEwMDY0NA0KLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01h
a2VmaWxlDQpAQCAtNDY0LDYgKzQ2NCw3IEBAIGR0Yi0kKENPTkZJR19TT0NfQU0zM1hYKSArPSBc
DQogICAgICAgIGFtMzM1eC1ldm0uZHRiIFwNCiAgICAgICAgYW0zMzV4LWV2bXNrLmR0YiBcDQog
ICAgICAgIGFtMzM1eC1tb3hhLXVjLTgxMDAtbWUtdC5kdGIgXA0KKyAgICAgICBhbTMzNXgtbW94
YS11Yy04MTAwLW1lLmR0YiBcDQogICAgICAgIGFtMzM1eC1uYW5vLmR0YiBcDQogICAgICAgIGFt
MzM1eC1wZXBwZXIuZHRiIFwNCiAgICAgICAgYW0zMzV4LWx4bS5kdGIgXA0K

