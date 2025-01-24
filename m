Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8CBC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 06:07:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.5731.1737698863006474059
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 22:07:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=P8O6w5r6;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1737698861;x=1738908461;bh=/GccdhJWkaV/YZkj2+OCPUSSx4j7wivzeSTAvlD
	42Ws=;b=P8O6w5r6FYoFSdbbi3S4VlcUbxgRUXD01Gpa6rjT9lp3m3+TPzrfOfg5Ltz3Tc+W9r2Ig
	IdIowR9N0jPdzH8dxCU6k6R+eLy1NxrYm/cy38zmo9u0uJFTBf327nOn99n/KT60T7trsMLXe+pql
	HRdkLAJggTFIVQP5PV4ovlg6ugcHmPWSSl57s6GHahvLKBk8PK4NCYWFkV75K9OKCIzxSUh3DWYz1
	DHx/GZwcM5ggn1UsnHU+2gpljjlqQqJjQA9QSnONFgsX08RBSY2W2WKLn2S94BgL4U5CFk0RM/Ztc
	HLVP93ciA/8ztZtYmYUDK90AAkA//VpfajaGpwzzJw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 50O67eew957485; Fri, 24 Jan 2025 15:07:41 +0900
X-Iguazu-Qid: 2rWhMjEQHqtnBgHC5d
X-Iguazu-QSIG: v=2; s=0; t=1737698860; q=2rWhMjEQHqtnBgHC5d; m=9RUbde/kJxZ+W+PMQM+B4Pu0MtF/ZFpkACaNypbuK0c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 50O67cuM3202414
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 15:07:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnb1vR3juIrpYX4qEbQJ9a+3d67YtNQLjl1tcnhJpyTExjOcSyizwOMirPy1YnW4AqX3NyttO4kZjVUzIIq98ZYvPUZWwRbZwX5iV8iJDmGMZP7eVewEa5d+reCkfr/hV4p4oWLMS87Q01YGT+A8UnBQIsyvwGbWSVCRVYQJh8KYlD9KGdbsIuHE7eIwHInGYKjTUX37WwmCqYfXm78mTysO2CrJrmOCPD4j+HXpdhqe1e+3MdjsRMyPSWyT7ecDg1NicsNaUnXhxqsDClYTtXsZJu8SNV96Ze3NG/9j4k/cKTcKyaOHEl49eaM19HlFo9W6xta6kDHO3p5Oq1g9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GccdhJWkaV/YZkj2+OCPUSSx4j7wivzeSTAvlD42Ws=;
 b=GyIFvSK4+QF0VZfZfIq7KxMoyGkuMiltOh4t/JrHHGWwNU5WppH9aZE8voXx8/9VXuxS6eq4/2kDsjb035MnM2IeoVcFiN/TX2aN6EuPGXs871nLXHhQeC9bZEQll6SnwUAVwb/WhLYE03DBtv2ELUC4l/EjdbgUjRq+0jt/Jw5yf5EEcB8DI/ImM+UNZzpusd+5iGKLhxt2ghAv5PBFf+Qd7wF3NR9Swwc+gRulmrnlFfXJf8S4h9f5oylm2tPEWWXKqFdcMYvBYirv7nVc4m4uPKl2ZYyO22v6L10/+uWUqCUAg8+Jl3jjkIR2qZx7PIeBEtkH0FJLxhDErO+zeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <felix.moessbauer@siemens.com>, <cip-dev@lists.cip-project.org>,
        <michael.adler@siemens.com>
Subject: RE: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Thread-Topic: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Thread-Index: AQHbYbaODFOpOFly3ECuHYa35vdkyLMlh57Q
Date: Fri, 24 Jan 2025 06:07:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638822A2AA063548128D1A8192E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20250108100755.55673-1-michael.adler@siemens.com>
 <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
In-Reply-To: <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB11552:EE_
x-ms-office365-filtering-correlation-id: 9d5e4038-2aea-4dd7-44ce-08dd3c3d66ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zkt5VDg0UnRHUEFOY2oyakovZFFxWitTcmlQbXVxK3RxZzNESTBiSjg1d1JR?=
 =?utf-8?B?Y2kvMDFYU1B2UTR2ODk2NmgyVi83VWt1b1lyVFJpZVBnN283d013QkhINXln?=
 =?utf-8?B?UElwKzZ0MUwyUmdWcnY2cTNHODFSTTZ1RzBVQ2lKRVpjOTdBVFlpYjg4cmJz?=
 =?utf-8?B?RnFKcURWdTJ4aU1ieGxwUTBMWnBiZmREL29IMUlkTXN4NmM0akREbkQzNTlJ?=
 =?utf-8?B?c0ZsY3RYTnBXTzR2aVdYT3NQRlJaeHlQT2o0MFU3R2hmQlA0YXdVQkMyWkFs?=
 =?utf-8?B?YUIza0dRdTNjNWpSSHFxekdRWG9CKys1UWp6UTg4RWpOTGxrQXlTMFJEUDlS?=
 =?utf-8?B?RDRmVnZhbWo0dVY3ai9ZL1krVURqQlV0OTY0SW5tQStWS2Yzc0hpbHRLK3Fn?=
 =?utf-8?B?VTVVL241TXVSQUVMdlg2SEpxSFdtejVqYXZ5VnVJZXpEN2hwMjVoL3pFQTg2?=
 =?utf-8?B?aG1TeGlvdmtuSE9qSFdBcXFISFMyME5Gb1E3WnRkTXlHQ3NOUXBzQ1dIMUZJ?=
 =?utf-8?B?eVljZFdlRU1mbWpiQk83TkFvWDJMRnJUR1J5cTY1K3I5cUFkWWd1Z0RLRFBY?=
 =?utf-8?B?YWZyOWZIeE9hTnd1S1pOUlpFTWg1OW1ra3dua0wxeUtzdXNkanRXRUN2V0RU?=
 =?utf-8?B?U2lETlF0SVhUZTkyUlFYWUJaL1hYTUIrNHB4Sm4vbWVEMk9iZ0duQ0MxU3VM?=
 =?utf-8?B?NHBMQWxnSSsxZ2w1dmJkamVDd3dsM3ZaRmJpQUFYOXhXeWNHSjVoOTNXb1N6?=
 =?utf-8?B?YzZqa3NiRXZsWjJQK0J5NEpjb3pEZ1BCd2g1RVJWamRjS0ZqN3BiN1A0bzNq?=
 =?utf-8?B?cWtnYVZSdFFhL3dseEtSQzN2WFFFQ0l5d3hudHZVdUhpbmVqbDNpYzMvTkxn?=
 =?utf-8?B?RlpETmVKdkNvMWtsVFZTb1JGQjRvd0U5UC9wVDFjZnhYNDB3RlRtRG5JOVcx?=
 =?utf-8?B?NVpkWnY3UGYwOE85Q0Q1ZTZSKzFlQ3gySURsb0xCa1dHY3BXdXF3Q2Z4V2Jl?=
 =?utf-8?B?QnVQbTU2QWNxeDZ6cTVQb1dGRlQvN1JLR0hFMlg4MGhQWnUrUVNUcHRNRFky?=
 =?utf-8?B?M0R6R2doK1N1Y0tjWDRFR0FpYkEvTDNCUUFTcmduKzJhQTNZN0pyaDJhQ0Ir?=
 =?utf-8?B?bCtWVDdhVWJqWDBudDk0VVc1N1NCMFhNMVFUMFdCYytxc1U1dkpHSDlHYnFw?=
 =?utf-8?B?azVubUh5NFkxV1FaK0pqdkxRTFZVOHJYMmlTWVR0MWh3UndzWVBqU0hZSi92?=
 =?utf-8?B?WjhtRmgzQ0hUcWI1TU53L3BsR1dmMktYdGRMQXJHQlRPWDliM3dNLzgxOUo3?=
 =?utf-8?B?dDJwcjlESUx2Rnk4V0wydFpSSzRRZExnRVZjSXVJL0VWUUVTZ01Mc1ZPRUJV?=
 =?utf-8?B?dUNoTEg2bTFPemQ3RlZjNy9GekpSUXQwWHBablQva1g1QnBSWEUrd083ZzRu?=
 =?utf-8?B?RWw1bXZNWEVvYUJUamV4NVdHOFpnL3ZtaGtTZ21nUmNSNm1aLzNjRnhYRUwr?=
 =?utf-8?B?ZGtGWVpVQzh3dDFCWU9XdHViaGI3emVtL20rTnAyZlRHTU5zaTV4aHZKVXQw?=
 =?utf-8?B?aDlSWnYzZ1lUNWhVaGFVcEQzeEg3b0tLd3JPdVlZbG1SeXhSRmZQNzg2c3Np?=
 =?utf-8?B?Y3pEQTNZbklveDVoUmV3eWMxZkt4N0xrakZSdEtPcENzMjZ4K2UwbkQ3RmJp?=
 =?utf-8?B?RHJjQmZETndYV3BNaTJsTTAxS0RFVHBDM0k3VHlyVThZclcyS3JLZHZIbHpx?=
 =?utf-8?B?c2lIeWFoR0IxVERQUXFSRFNrbjduU2NaRTR6UytFVVJCY1FiT0g4MGVyTHFS?=
 =?utf-8?B?WjlMMXhhQ1RtbkR6c0FEZ1BoL0JsN3EzeHp5UkwwZGhicGQ2TGtGckFTN1lv?=
 =?utf-8?B?dGE1dEw5OUxOZlFXQUEyQVVMOTUvclp1Y1BhVUdsWUVmRU0zVDJhbjdGQnVH?=
 =?utf-8?Q?S+oQ43OXODjH5zdsQnkiJhWxm1W7LN/o?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHpYZG85NElrRFJ2ZkQreVM5M2RmWGU5eE9FdncyRTdYTmNCWjlnbTV6b2FT?=
 =?utf-8?B?WEI3a1luTEJXWFVpU2MvakY4eE56WWlVdnlMUEVPYk9EdU9wTFRxYjgvYkFl?=
 =?utf-8?B?ZzNQZjZyVGg4NGRJVVdtRUJvbmRsUUh1ak1obnhCN3R4K0FsS3V2V0E1dGdl?=
 =?utf-8?B?bkw0K3U3TUdwYVlTQ3ppd1g5cFdIVHEzbzdBYTNHVmVzakg1ZWEvOXBrc01D?=
 =?utf-8?B?MjlRNlBubTNBN2JPeGRPQ0hRMzVIeEZtdTFNL0ppUnNDTzNSR0FzdFJsT3hi?=
 =?utf-8?B?VUVhZ3lKNDE4d2oxNFlISlJTVy9nMXE0NGdWSzF1dXFiZGt1cUpKcmR0aHE2?=
 =?utf-8?B?VUYwSktlZlZUT3VpRVRpOFBXcDNSTXRXeFUwVm9Sck5aOTNHTUJXSVk4d1A3?=
 =?utf-8?B?VWl1Yy9LK253SnF1b3R0Z3lHSnV5MTdFcHE1cnNoMStjRElYdVJFVWlRa2l2?=
 =?utf-8?B?S1NXR01Mc3d6UVJwRk9uWXh0N095djRXaXlYRDIzMVg5dDhWUVR2WTk2OXVP?=
 =?utf-8?B?Mm1IaXJYNG9rWDRLbzM0U0pNeHlDRnhNMHM3bHNEU3RGeFZnWUp2NTlLZEVy?=
 =?utf-8?B?SFBDNEFzVmltelVWa0JwRVFuVDNWQzY3bS8yR2hqSk8xY1RMeExjdGFGWWNU?=
 =?utf-8?B?UnFDeGRoY1FpeitsaWNFekxPR2VtVzlVZEpPUXMzclFla2FMbnFJNEJVWDNk?=
 =?utf-8?B?Z3JDdjR5NGVhSXU2KytiTG9MVVZnRk9mOEsvVG9ZSlBoNzNvZGFibTRORkRl?=
 =?utf-8?B?bEREakRZNytqRTZHcENXOGZvQkJDRnNoWUxRRHUxdENHandLeTU3dmcyWHhD?=
 =?utf-8?B?Q1oyVHY5c0EzNndRWXluWDBEMWp6VzB6ZEs3TlJoTDVRblRLS0F1SXE5TzhH?=
 =?utf-8?B?TUp4ZDFhTHdkMkhlTUtqYkN3dUVRVENpUTdObEVDSGozanlmeGJNTld3VTRY?=
 =?utf-8?B?T0FSRWtEb0hEeFpacm40WWQyUGk1NjduVjN5c0tzejhFcTdYejg5VWpmNkVz?=
 =?utf-8?B?YXhHYWVRREx5VjU5VDg2MzFCYnN3Vm44bjYzYnIvRGs3RGRoelpPTkpUSlNh?=
 =?utf-8?B?cHkxVmZOYXo0OEFzQzhsK1ZlRmxTQWVHajVlSmFpSisxaTNtTGx2NkpGREJS?=
 =?utf-8?B?REpsU2RLTUpCNmJRY0ZvR0xVTGpJL00vQlBWbG9YQlk3dXpYWkp2S2RYVWdz?=
 =?utf-8?B?eGtwR3gwZ2xWUzY2UGplN2JPU3pYeUg3V0V1TmRhS2tQNDNDVll6bUV1djg5?=
 =?utf-8?B?Nmdva3NBMU9lRFFkWHc3R3dLY3RpYjM3bE5QMzRjeGExWXdTbVowbThCNCtC?=
 =?utf-8?B?UTN2UVBQWVo3VzFuNkpiMTZ1bWRNb0o3QXNYU1dCaTF3Y3Q3SGt6K3NyNTB3?=
 =?utf-8?B?ejkvUi9aZ2F0djlPWC9KZkhXMEpIeWVoK2F2Vkd4RllPM0NtNHdBdWVmYjNk?=
 =?utf-8?B?VkwxZllIRFpRSDRTbzFKWSswTG1jTUx4Mnd4WnZkZVVBZjh1Z0tVUWx0a0lL?=
 =?utf-8?B?TUNQNm9XMXZpdEhjd01UeUdGR1JDZFpPeit6SE16MzFESVZzVnpROCtpR1lv?=
 =?utf-8?B?YXR2RDBkb3VHdTBUNkhxSGdnY2c5Vko1eWM0ZHNSQUNoSTNDbzM5Nm4zN0U2?=
 =?utf-8?B?NVEwSEI5WXVPRnNubkFJalF0ZkhBR0xiODBhRG12K0h4endvMm8yVy9XS3h4?=
 =?utf-8?B?akRHRUJ3VXNLZml5UDlBRFhGOVNKcDYxYVY2dWxZRTFaVnUxdzVWcS9qN1Zv?=
 =?utf-8?B?bnBnSXRGYnRqK0NzYktaZ3VFRjdNTXk4VEVZZmxVRlFvTEVYODU4VlRwWGRx?=
 =?utf-8?B?QnovaUZ0aVNJSnc5bXdDTXBRNGZ1SXhRQUJBdnRpRHNLVXhaa0piRW9hNUlh?=
 =?utf-8?B?YjNlWGFnNStiUjhVSUNMSzBtdnF0cUFvcnVTODQwc0FTbDRKK2JoQi9uT0JG?=
 =?utf-8?B?bk1uYjYzWEREOS9sUzVoT3hSRGtwelJiSHVSVjRYaG9WdGpzZXQ1RUt3dnVZ?=
 =?utf-8?B?WWYxQmNlU0RUUW13eU85UUdQWk53dno0UDBZWmREaGhJZWJGL0Q4NkY4ejNT?=
 =?utf-8?B?c0t0WW1RV2RtWlRJWExSVEVWekoxUDkxN2J6RUpFQXRUZUhrdW5IMTRTTE90?=
 =?utf-8?B?Y0pZY2JyUktaZTA3aTk0QmZsaHZqU2lsSFdOSEt5K2YyUUJCMkgwT0NBOUs4?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5e4038-2aea-4dd7-44ce-08dd3c3d66ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 06:07:37.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMgC9lk1Is1wmicOzgsEWNYvJFAniFY+JawOpcsgP0ynO00iXbW1AnsNHbspo7f20RpIsL02mqbbEGN4L4duj7pG401aM1CBcqVu54POYK89ljisTEVJtOQRqm2AKl6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11552
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 06:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17613

SGkgYWxsLA0KDQpTb3JyeSBmb3IgcmVwbHkgd2FzIGxhdGUuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTU9FU1NCQVVFUiwgRmVsaXggPGZlbGl4Lm1vZXNzYmF1ZXJA
c2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA4LCAyMDI1IDc6MTcgUE0N
Cj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBBZGxlciwgTWljaGFlbA0KPiA8
bWljaGFlbC5hZGxlckBzaWVtZW5zLmNvbT4NCj4gQ2M6IGl3YW1hdHN1IG5vYnVoaXJvKOWyqead
viDkv6HmtIsg4peL77yk77yp77y077yj4pah77yk77yp77y04peL77yv77yz77y0KQ0KPiA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8x
XSBsaW51eC1jaXA6IGFkZCBrZXJuZWwgY29uZmlnIHNuaXBwZXQgZm9yIGNvbnRhaW5lcg0KPiBj
b21wYXRpYmlsaXR5DQo+IA0KPiBPbiBXZWQsIDIwMjUtMDEtMDggYXQgMTE6MDcgKzAxMDAsIE1p
Y2hhZWwgQWRsZXIgd3JvdGU6DQo+ID4gV2hpbGUgdGhlIGNpcC1jb3JlIHg4Ni02NCBrZXJuZWwg
Y29uZmlndXJhdGlvbiBpbmNsdWRlcyB0aGUgbmVjZXNzYXJ5DQo+ID4gb3B0aW9ucyBmb3IgY29u
dGFpbmVyIGVuZ2luZXMgbGlrZSBEb2NrZXIsIHRoZSBhcm02NCBjb25maWd1cmF0aW9uDQo+ID4g
ZG9lcyBub3QuDQo+ID4gSSBoYXZlIGlkZW50aWZpZWQgdGhlIHJlcXVpcmVkIGtlcm5lbCBjb25m
aWd1cmF0aW9uIG9wdGlvbnMgdG8gZW5zdXJlDQo+ID4gY29tcGF0aWJpbGl0eSB3aXRoIERvY2tl
ciBhbmQgUG9kbWFuLg0KPiA+IEluc3RlYWQgb2YgaW50ZWdyYXRpbmcgdGhlc2Ugb3B0aW9ucyBk
aXJlY3RseSBpbnRvIHRoZSBhcm02NA0KPiA+IGNvbmZpZ3VyYXRpb24sIEkgYW0gcHJvdmlkaW5n
IHRoZW0gYXMgYSBkcm9wLWluIHNuaXBwZXQgdG8gc3VwcG9ydA0KPiA+IGN1c3RvbSBrZXJuZWwg
Y29uZmlndXJhdGlvbnMuDQo+ID4NCj4gPiBOb3RlOiBJIGFtIG9wZW4gdG8gZmVlZGJhY2sgb24g
d2hldGhlciB0aGlzIHNob3VsZCByZW1haW4gYSBkcm9wLWluDQo+ID4gc25pcHBldCBvciBiZSBt
ZXJnZWQgaW50byB0aGUgZGVmYXVsdCBjb25maWd1cmF0aW9uLg0KPiANCj4gSGksIElNSE8gdGhp
cyBzaG91bGQgYmUgbWVyZ2VkIGludG8gdGhlIGNpcCBkZWZjb25mLiBBdCBsZWFzdCB0aGUgbm9u
LSBhcmNoDQo+IHNwZWNpZmljIGZlYXR1cmVzIHNob3VsZCBiZSBjb25zaXN0ZW50IGFjcm9zcyBh
cmNoaXRlY3R1cmVzLg0KPiANCj4gUHV0dGluZyBOb2J1aGlybyBpbiBDQywgYXMgaGUgbWFpbnRh
aW5zIHRoZSBjaXAga2VybmVsIGNvbmZpZy4NCj4gDQoNClllcywgcGxlYXNlIHNlbmQgdXMgcGF0
Y2hlcy4NClRoZXJlIGlzIG5vIHJlYXNvbiB0byBkaXN0cmlidXRlIGFuZCBtYW5hZ2UgQ0lQIGtl
cm5lbCBjb25maWdzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


