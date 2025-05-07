Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F9C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 09:07:32 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web10.4170.1746608847983805279
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 02:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QR8dM7Mo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUEv1MuKV1sgacuYcLR33Wu1vcQSvxyA6xXrkeoL36GCAuwDhNEFMYmFB9V1giZXgi/kjOW+SvPKGxzvN3oOdJgbCxT8BgGRp22vOesZzvR/2EVrhGyCiW80pTK0/1/hmvwcNnPGPLRq1nPO78QaUjm9fiS86ZdiOMXlCKcQ8Fy/NYWyutihOfAyJF/pIyGc3tdye0SDWOGYqZauVime5bjRclYHY9NKaWPYQKYCb5MyqwIQahQRLbyLbTTSq+B1UcQpwD3+TUzBSGFXSiLBMhI6pfbeW2ElENBzqNlENaKabSYrNLkF3KFxIafMZ1dTLE3I9qYzCuTdion0VDeMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9kDK9U1Tnk4P5zyEEss6WbjhBqKxoO8woWhTwV3DdM=;
 b=agPaf9ZsSwLctunIXujb6TIA2iX7/WVbvTe30GS6Q+pqRf2K1n9rDS22xwZO9bhjg3rhQz+GkX8S97WLAOnRxPd5OSy9wNQN8yjtsuzFpGBsPLLNEf864tLuYKR/Qg1ojWhi6YrM3esX+vm4cMrIE8Vnwe6SiHMD6lC1DpqMS1OoHqTZVS/J7NM3FARle/43sORFqz0iJkMTUwa+vGGQuKrQD9yeUoTajH6+VIqaORIvHGOPENPEX9lc8SCMmKPl+aFLO/JxKJ8MHX2gBJ8KSWAr7MH+EsqDVsMQSr7LvO59ZTDvy75+j5aE6BTsMM48BITCPOcVdfAj1K/TY48NaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9kDK9U1Tnk4P5zyEEss6WbjhBqKxoO8woWhTwV3DdM=;
 b=QR8dM7MoSVzQ1FDw8bVMtKFdkZeJyL0+LlaEnVOjqYfOxA312kQspFTrPpNKnhZQHCmJ2TSPnVG4t5FxITWXA+MRBUPczZeJsmvuIcgKKBjCfxqbGwb7TE8fZOw4ehiJkewHNlviq1swPLJJ8gjwd/C7JowFF5JjfnZ6FKTLbCI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB8333.jpnprd01.prod.outlook.com (2603:1096:604:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 09:07:21 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:07:18 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulrich Hecht <uli@fpond.eu>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Nobuhiro Iwamatsu via
 lists.cip-project.org
	<nobuhiro1.iwamatsu=toshiba.co.jp@lists.cip-project.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "pavel@denx.de" <pavel@denx.de>
Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: 
 AQHbpUgQJ4XZlFPttEOjVvE3iV3PDLOmMT4QgAFA6XCAEJsfkIAOfH4AgACEVQCAAAVWcA==
Date: Wed, 7 May 2025 09:07:18 +0000
Message-ID: 
 <OSZPR01MB701905C1353E36631BD00B1FAA88A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019C7990FA3543B1F69A6CFAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <TY7PR01MB1481851C84944731CC67B05D19288A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <1012487320.262646.1746607506076@webmail.strato.de>
In-Reply-To: <1012487320.262646.1746607506076@webmail.strato.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB8333:EE_
x-ms-office365-filtering-correlation-id: b9d3b7bb-a613-42ae-85b6-08dd8d469192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?azRXT0NpSUE1YTkranFHSFgzOVlNY0hJeDRyTnZtVTlVeDJvSXQ1b3M0aldS?=
 =?utf-8?B?OEFVZmpNQ3NWMEk0SlVjbkQvdW1EbldDR0VReXNDSkhPZXNaUnZlV29lZWdr?=
 =?utf-8?B?MmxScnlQRHdqUm1wZ09NcnR0Y1MyVnVuZ2pBeUhsKzB5d0JQZU10dUNaR3FZ?=
 =?utf-8?B?d3RZRHRjc3VncmdmdSt5d2pnZDk3aTNuYyt4ams5ZGNRVEhmQVQzRWk0NWM2?=
 =?utf-8?B?VS9lQ0pEZHNYd0pucWhSYmp2WmVjZ0lnNytOVHpFM0lSek5ITE01WXZIMXhK?=
 =?utf-8?B?OXdROTZuZGE3ckZkQnYxMWErRzI5WllaRC9OT25aMW1CNmM0U1Exck9WU0cx?=
 =?utf-8?B?Tld5MUdoQUZ4TmJWT3h6K0ltRnE4VTBCanZma1A0cjBSejNCd2RmbnZxZjY5?=
 =?utf-8?B?ei9nUnp3ZE9tMEUzbHBvQlFJNVdYQlF1cTF6N1U2YWZkZTl4STh6aUlHb2pJ?=
 =?utf-8?B?MGpKb1VnTzhrL0trUk04VG1pMnNkVUhOR1RZQmZadGxNVUdLai8rOXFvclp6?=
 =?utf-8?B?ZndvWGs2eWhEK2dYYTdDU1JieDBkbVF3U056dEE3K3F6ZlM1RThiS0cyb2k3?=
 =?utf-8?B?UUtDTHk3TkpnRTh5OTdDWkdValRnSFJaRVV4NGxXcHUzMVhJQ3VlMEkwTURy?=
 =?utf-8?B?bWxLbnhoam5DQ3FlcWltZXlvaXJNZmdLbFdEZU9RNExRT1VzcWNwS0ZJUzl5?=
 =?utf-8?B?dVhnNk5MQjdqOWNwcUdFdUxEbHJwT2p1SXpVdlRoUXpmalE1K0RGRVA0bm1L?=
 =?utf-8?B?T0tZa0VsbGQxQm54aTlNQ2EyajZNWnVub3FidlAxMkx4ZTZFaW9HdjN1MGJP?=
 =?utf-8?B?VW9rOTREUmhLeVNsT2NwQXZVRkdYclVNR0laQXhsYXM3WVRmZnlEZEFSNGN5?=
 =?utf-8?B?NFZRZk5wVFJoV2p2Tzd1UWt3ZktIdndxczdBSGRkN1FXK1NtT2d5emVFVmZO?=
 =?utf-8?B?cU1wQzNzL2FzUVFJdWt5K3F2b2JpTzQxT1pDUXpqVFNHOGtCbWZ5L2E3Tjl6?=
 =?utf-8?B?eTBqOGhaL2FndnRXSTRWOS91OWZ5VjUwTllRVlMwVUo0ZVNUUUM0SEd2RmlM?=
 =?utf-8?B?RWk1NkpxTEtYaEdtQVdVc3lmK1NFMEx5bzc4TEJuSWVpanp2Mlg4eGVCUGlQ?=
 =?utf-8?B?MEFOYllRNkRKN01ZbmNoM0hLU25wdTQwb1lCaTBSQW54anpkWjlmWncxamlx?=
 =?utf-8?B?U1JkeXQvOGdzUDlqRVJTOFROWC8rNjhIY21RL3F0dS92Ui9YNjRMdmJMeXhF?=
 =?utf-8?B?V1N1QldlWmo1VXVTMTM4OEI3eVpGK0hSS2ZubEYycU92bGVWeUk0WkZCUTQ2?=
 =?utf-8?B?NUl1cmU3MkJudTYyeHhSakNMZ3B4dDZjSUtNaERidWtBZmVoVVMxRWtEL1lJ?=
 =?utf-8?B?Y3QwWDhGRnI4UlFIRDd3Y24vbFhncmROUEM4TkdhNVY3RTZwMlltWUpXamhR?=
 =?utf-8?B?MFRzMW9aQXlVNldySGI5cm1vZXBkaGh4VFZHMC9FUUJHOGt6QnRGWi9FeVJj?=
 =?utf-8?B?ek1lQVZiYyt1OWM4WTF0blV2YTVVc0RFM3B6M2pMbnFZV002cE04c29tSDIx?=
 =?utf-8?B?UkJjb21CSVEzZ2ZpQzlRczZTOWJQL20zUmZGb2RBanpVQ0hDbis1RW9CY21E?=
 =?utf-8?B?SXNaY0E5WVJkSTh1NkJSaTRocHJEVXArWXg2MUVmbXNvSXNuYjFFMGVTckpC?=
 =?utf-8?B?Vzh4bzR2QmNBYzNpMUFVSE14U3BYbmorRFlxN0d5MTVLdU9LcXU5YWNqTUxz?=
 =?utf-8?B?a3FsZWVsb0Q1WFlYV3lsck94UDJtUkU2UndEYllTNVhtZHhJaGhZcVlkZER1?=
 =?utf-8?B?ZTZqN2NwanJMbEhLcXVmOEc1T1h5NHRDMkh6TjZIZ0ZqbUxLYzdiZzljM3Uz?=
 =?utf-8?B?QjFUbHRhOFU2bnlYRGVVVUVJSnllVnBaUTlhdkg0OTAycWF4dU4rVnBMVk1S?=
 =?utf-8?B?NTAycWJLQTBuU3BBczRvb2w1bXFoMEtJbGJubmtjQk5LR0JlRW1TK095RDBr?=
 =?utf-8?B?SmVnYWw0UWRnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEhrdFNOdWprQ0dzc1phVm1XVjdDVlRxQ1JtRzJjd2t6TVVJUlR0MnJPTVFo?=
 =?utf-8?B?M1NRUGpmZkFGVmFsMWxBdkp5TEIzSjc4bmRCWGMxQWVvNXVYR0kyek1NTFBN?=
 =?utf-8?B?MC92eS9lbklkQ3UrNlUyOWdxeEc5OXllMTVkUHpQQVRUaW9QUnI5cnZFandY?=
 =?utf-8?B?bFIrR0Z0VVEzWFE1QVlhVHpBTkF0UWF2dnJTK1JNWTNCODEvcDl1WVk1L1Zh?=
 =?utf-8?B?bEtlV1RWVWdtMFQxeEhyYXYyUUFLQUMrUkFXT0g1T1FHeHVVWE0zMEZhYnMr?=
 =?utf-8?B?VDhHQjJwSUhQN2UzeCsyQ010MkQvWlN2ODJTand2ckJMZFN3SjBlamdUa1JQ?=
 =?utf-8?B?dE0wbnkxRTk4L3MwWC9hcFk3YTBYRDQ1ZHVBcG9qV3JVVm0xMDVVOHJTRzBU?=
 =?utf-8?B?QzgzMW1nVEZjTUZ5N2l4T01tcmRXUlR6U3RMYmdWTFhNK01zYkVSV2RLUzdQ?=
 =?utf-8?B?UmIvckh3NEZHK1Bxb0FyMXFLSURwbGdMS3F3Uk5NVG1nVHplLyt4K2xIcUc5?=
 =?utf-8?B?TVJ1NlFYKy9oMHVGdlc5OTBXVmlZajFFY0ovTGllRWZnR1JGdm1KWjBQb2VN?=
 =?utf-8?B?VFVPOE9VcDlWVzJqdVZFOGNTZkErbVdQTS82Z3hldXR4alh5NDdsdlpZM0Ri?=
 =?utf-8?B?TVBPNUtGN1JrRnR1MUd6MDRCMWNIcGJuK2JudFZESkZ5UGR2L3dYbE93Zm5X?=
 =?utf-8?B?cHgzRm9HNzlBNDFZajhFMkdvaXowTUVmM0RiTGp2N3ZGQUlEVTFJdUFRSXJN?=
 =?utf-8?B?V1lFaE5GMDMxUGtGakwxZGw2RGkwWkIvdjcwTGVSdmp3R0owdXNPcThLeEF4?=
 =?utf-8?B?OElrSnc2bVJnd3d1bVdWZGRUU05GT0dBczAvbUQyeHpYeGZSbEhORlJIRmFD?=
 =?utf-8?B?amVkUG1ZV2w2dWFaQmE0QlRIQktFUUk5aWZrRHU5OEY1ajNhbHZtenBOTTZT?=
 =?utf-8?B?VnMzZmhNRXlpTWtsMjRkSnFWU01LRXp0MncyNGxKaUNFclQ3UGRTZlBSc21t?=
 =?utf-8?B?aXE3cFMwYUJxdDlRM2o3bmhrbFgxTUtYaU01ZktuVUV5Z3VUTUFhZm5PU2NH?=
 =?utf-8?B?L2NrMFY2TWYzV1Vlb1lTQ1QzNGZUaGNHZ1JtY25nOGVkb2ZrbHdYR2NleTFk?=
 =?utf-8?B?cFRuNUsvN2xOVDAvdVd6dHR5dTlobGRYN2FNcnpuZWRJeDA5K04ra1RKZjI5?=
 =?utf-8?B?WXArQ1lkYUZ4ZEZoNkkxcTRmNTVvaGQ3MjhNWFhwSXRmRHQyRytrSTRZbWtB?=
 =?utf-8?B?OXREWGNJY0VJd0NlN0VNcmlxeFdKOEYvSDZRSm1zck9lL0FDZnVtdWFzaS9H?=
 =?utf-8?B?TElsaVIzTkllczRBdzZ0T2R3cVQ0VnM2K2Evbnc1aytRVjhwNC8xdUtsa2xv?=
 =?utf-8?B?Q1lCbTdoWk9ORzlJbEFML0tjbUZSNWlteitRUzNyWEdWQkJUbTBpTUwrV3B3?=
 =?utf-8?B?dXVzeElvVHRkNFh2aEhjVUdRZENyTXhhQnBNNEVQbnpoeG1ldTUyM3NOVmI1?=
 =?utf-8?B?N2ovMUR5UW4xZGg1cVVyb2RzaWFVTVZUYTUxVm5FbnNrQk8yOS9TNVVLS2Nu?=
 =?utf-8?B?N0NxK0oweXBXL0lrblMzdUgweWRDZlhYWFNhTngxLzB2U3B3YWpidXFGU25N?=
 =?utf-8?B?WENDQTQzemRIVnI5MlM2cjlpY0NrbVZJR09FM3RZcklBQkEyRUQ5QVpCM1V5?=
 =?utf-8?B?blFkY0pubFN6YmlJYzEwTGZVaGZ3KzJMTlVpMlcyRE1XMEYrY3FGeGdzMklC?=
 =?utf-8?B?a1hjbWZqSjBCL0xQTlFHazNKVTNGWVd1bGs5b1VmbktJKzVxdzY1cWhHNEt6?=
 =?utf-8?B?MnJKL0N1SkJlc3J0RnVSTGdoOWhrS3RrUDBzWHBkamcrL0xldFN6eVU0NC9w?=
 =?utf-8?B?dnAwQ3RwZ2dFclI1V1czQjRveG9jSkNuT0hhelhPdlZOa1d1TFNjak02WThh?=
 =?utf-8?B?Uk9rSTBJRXd2NVpOWEE4bTlsZ2oxZGh1Tk4rZTkyRGpQSlUyMENGTCtrK3JT?=
 =?utf-8?B?QWJDQ25YbUcxUlFneWdWOW84NkIxd0FZbTl1SUxSL0RMNXdqZjNFMExEbERa?=
 =?utf-8?B?dUdLbjhpZVYwcWNKMkIvbm1DeXgxdnloKzlHOG9xT3VFMjVFV1VHMjhTelN6?=
 =?utf-8?B?ZG8yN2U3VndVWTlObXRFa0xCMGF5MTJrK0syRnFSeUVIN0hkTEZBaGpaY3Rw?=
 =?utf-8?Q?7U86o6cuPMO2lEYE6OCM75Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d3b7bb-a613-42ae-85b6-08dd8d469192
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 09:07:18.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEpiI6xsasSLPKi7yLsVr3Sic49wgn7FETUmfYdHNDp5NWFkAyw0oOVXRys4hocnc4XvMXeeDSioE1TzXrMIAdYqBz5Rc8B0DralbMfnLoIyInUy5YIc/5Qq/Db3BAh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8333
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 09:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18776

SGkgVWxyaWNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmlj
aCBIZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiAwNyBNYXkgMjAyNSAwOTo0NQ0KPiBUbzog
bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA7IE5vYnVoaXJvIEl3YW1hdHN1IHZpYSBs
aXN0cy5jaXAtDQo+IHByb2plY3Qub3JnIDxub2J1aGlybzEuaXdhbWF0c3U9dG9zaGliYS5jby5q
cEBsaXN0cy5jaXAtcHJvamVjdC5vcmc+Ow0KPiBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJo
YWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOw0K
PiBwYXZlbEBkZW54LmRlDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDQuNC55LWNp
cF0gQVJNOiBzaG1vYmlsZTogc21wOiBFbmZvcmNlDQo+IHNobW9iaWxlX3NtcF8qIGFsaWdubWVu
dA0KPiANCj4gDQo+ID4gT24gMDUvMDcvMjAyNSAyOjU1IEFNIENFU1QgTm9idWhpcm8gSXdhbWF0
c3UgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA8bm9idWhpcm8xLml3YW1hdHN1PXRvc2hp
YmEuY28uanBAbGlzdHMuY2lwLXByb2plY3Qub3JnPiB3cm90ZToNCj4gPiA+ID4gPiBHZW50bGUg
cGluZyBmb3IgcmV2aWV3Lg0KPiA+ID4gPiBMR1RNLg0KPiA+ID4gPg0KPiA+ID4gPiBSZXZpZXdl
ZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiA+ID4gPg0KPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBUaGlzIHBhdGNoIGlz
IG1pc3NpbmcgaW4gNC40LWNpcC4NCj4gPg0KPiA+IFBlcmhhcHMgVWxpIGRvZXMgbm90IG5vdGlj
ZSBiZWNhdXNlIGhlIGlzIG5vdCBpbiBUTyBhbmQgQ0MuDQo+IA0KPiBZZXMsIHBsZWFzZSBpbmNs
dWRlIG1lIHdoZW4gc2VuZGluZyBwYXRjaGVzIGZvciA0LjQgYW5kIDQuMTkga2VybmVscy4NCj4g
DQpTdXJlLCBJIHdpbGwgdGFrZSBjYXJlIG9mIGl0IG5leHQgdGltZS4NCg0KPiA+IFVsaSwgY291
bGQgeW91IHBpY2sgdGhpcyBwYXRjaCB0byBuZXh0IDQuNC55LWNpcCByZWxlYXNlPw0KPiANCj4g
Q2FuIGRvLiBBbSBJIGNvcnJlY3QgdG8gYXNzdW1lIHRoYXQgdGhpcyBpcyBzcGVjaWZpY2FsbHkg
Zm9yIC1jaXAgYW5kIGRvZXMNCj4gbm90IGFwcGx5IHRvIC1zdD8NCj4gDQpZZXMgZm9yIC1jaXAs
IHRoZSBvZmZlbmRpbmcgY29tbWl0IDRlOTYwZjUyZmNlMTZhM2IgaXMgbm90IHByZXNlbnQgaW4g
djQuNA0KcmVsZWFzZSBzbyB0aGlzIHBhdGNoIHdvbnQgYmUgYmFja3BvcnRlZCBpbnRvIDQuNC1j
aXAgYnkgc3RhYmxlIGhlbmNlIGp1c3QNCnNlbmRpbmcgdGhpcyBmb3IgNC40LWNpcCBvbmx5Lg0K
DQpDaGVlcnMsDQpQcmFiaGFrYXINCg0K

