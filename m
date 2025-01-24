Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4638C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 11:30:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.9714.1737718216617981076
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 03:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 50OBUDpY3513982; Fri, 24 Jan 2025 20:30:14 +0900
X-Iguazu-Qid: 2yAbUt1VDS7QekgCY4
X-Iguazu-QSIG: v=2; s=0; t=1737718213; q=2yAbUt1VDS7QekgCY4; m=BFCOKy6BggvWcgLp4pIcAzL9g/XpsTfsIa4tq0DT2kA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 50OBUB9i3742839
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:30:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIq51iHKipRInRQoJvxG1omgQNJ651QjfpUb73S+IqoKGMUYB/Nmf3HxLiG3SYfnnZ+rudNYKyelDt9TccL6V4v+Zs3R3J9fDOAogsVfMQt7E4MUwoWp2LxzERODxebEUC6t8TobeirDzQCVgl7SGHuocsWG/pWlm4eOGgEHraMYDTcs3TzNmon7xKknnOBdrEbxA4FqrPESx5YG6Yz/nMUmXnb0xG3M/CRLsX/ylKbbDKep61fPcQ3DV74SP1snr0xS+/8sBQ5GWA2RQJGVcGR5JW3ABnN/A22n5qvbrkgyPmH/uufaRB5NfyTqhDV7mZPnGWwXcy6r1XkP72UOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuPSvV1LNRWdGCXCXPvuah5ijnpKjE2dxPqYE9JzrDM=;
 b=ACqM3ZvrvAJcoQoRaCt9+sIp0n2cQXf6R9JJkt0hjsk+1Hh3Q1qM+aA8O7Py1gUH0lZmMyogLaNSN0jhkAs7camylJw7ij202VxgzUkpyj9QpIOq4i53Auv/9f+Ktfytz2FPbdy4r4lGrfC3eS2lsYjM/nFvq91JkYCIGpP39ZXEgAQsR6zuiXkrGI7lWJVpfGHZWRNYAVmCIQizp88bQKjgNxd6hmMT81PZUXbyNoSy2DmElyp9DPX5o9TB2UFJ2VKVAk09Rd5mTla7oZas9nK4vssvlnb4V57H9JzCaxqZuED2dA73eLVg50s1Y5JpgsbD/aUvest4+CicphDOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Quirin.Gylstorff@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] customizations-security: add
 curl to download LAVA overlay
Thread-Topic: [cip-dev][isar-cip-core][PATCH 3/3] customizations-security: add
 curl to download LAVA overlay
Thread-Index: AQHbbjb+Cy/KqMCBWUydtHAViqoRyLMlwvFQ
Date: Fri, 24 Jan 2025 11:30:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB610020B92F7B4C6A64A62F6CC2E32@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
 <20250124080659.469424-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124080659.469424-4-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|TYCPR01MB8405:EE_
x-ms-office365-filtering-correlation-id: db001c46-0111-4130-7ffb-08dd3c6a7621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?a1RIWlpmQWJJTTNsTHF5UTV5OTM3dVlJRUM4NDRBTWtjdXJBZVFXMm1m?=
 =?iso-2022-jp?B?SDNHZlh3TEJIUEpmeWJVNCtXUjkzN1prOUFYMDQzNEFjemR1b2NOWnlz?=
 =?iso-2022-jp?B?NVU4Qldsck5CZjlWKzhncVIyMUdFSXhyaVhmWjlXSXYrWk90Rzg1SUg4?=
 =?iso-2022-jp?B?bGVIRVg4QjdBQlpwYXFLTzRJYTBnN3Z3NWtHOFVGL1oydzhINHRvTGNE?=
 =?iso-2022-jp?B?a2xyNFlxN2wzc0hMMlFOQmhWL3M2Rko0d09TK01kUXpRdTRMOHc1VUdI?=
 =?iso-2022-jp?B?cHNxMlRadHMwRWd5d1hqVlMvMTg1ellBUklLemIxNXE3SVIwTVJIeEZD?=
 =?iso-2022-jp?B?YUN4ZjlCWURjemp1WS9pMVVwanpHaWRqWWlBUG9pUDJVM1AyZzhkZlQ2?=
 =?iso-2022-jp?B?dnIxVGgxQ0tnRXh2SEJoNmVLZ1BCMlpwOFIzS2FwZWh6R0FlTlFlYXBW?=
 =?iso-2022-jp?B?Q2UrOWhTdDhNSHEvcVZxOHNndCtWT01sL2Nqc3gzbWFLWlk3L2FjMTQv?=
 =?iso-2022-jp?B?ajc3bEdEUlhDVEFQSFQ4MGpsMGZvdkI5TEdaTVcvbTgwZ3Nsd0FZTzJJ?=
 =?iso-2022-jp?B?aDJESjVxVUtDcytvU0txTi9YMTI5dGNOczJ5Wlp0V3l6N09FbjJZRUg5?=
 =?iso-2022-jp?B?MHF0ZlVZWHFMbjMveUdwUGtYV1Y0VDMvVXBmNXZvN1lXU0Q0QnFCVnpG?=
 =?iso-2022-jp?B?cVMyTDYvdU1IM2wwNHl0QndIci9xVS84NDNYckpZcUlmeEVkVW9pSXIx?=
 =?iso-2022-jp?B?VHMvSXNKa3VsdEJHT1BFRytKRGF5djNBWWtxbUc2VUVtRDNtMEttVis2?=
 =?iso-2022-jp?B?UDZsS05xL1o2RkNJSFVCL21xR3RjRjZPdVFkMzJsNk5lRExHWVVaYWls?=
 =?iso-2022-jp?B?T0VHeGRUM0xqRHRpc3Nzb1EyNW9BUTNvNkV0Rnl2VENiQlFaZDVVUFRF?=
 =?iso-2022-jp?B?bWhwZjM5MDlQSVlyWjN3dkdxOUZFYWxzZFF4OXRNSjZqd1RSd3B6WUJr?=
 =?iso-2022-jp?B?LzQwR0gza05qMHE4bHFva3k2eVJtdnZ3RFZDVXA1ZkNPQU0yTkpKNVlj?=
 =?iso-2022-jp?B?c0l1amhxRzNlR1kwUUYvaGtqaFd5aEFZZ0VzcVFrMGZmeDByR3RibjhJ?=
 =?iso-2022-jp?B?N2tRdGkwNnNMU1JVQ0luN0NGc085cE1sbXNpNTJQb2EyZEhraUU3Nll2?=
 =?iso-2022-jp?B?RXFxWUtFblhHczFxaTF4OTVDenBsSExaWllEbUZWK2tkcElWN24rSC8z?=
 =?iso-2022-jp?B?Zm9oSXNJWmFMSlgwMmVMZnhtc0VKU3g1NDRyVGcxMmhUdWk5M2thbWpm?=
 =?iso-2022-jp?B?dVI3cmFRQ0FRNUtHOEJ5S0UveTk4Tytpd2JNUEtoMU1IVms0VjgwNnZ5?=
 =?iso-2022-jp?B?cTVpT0ErU3k2SVJHYUJKY0txVTlJcU9mTmNqL3lEWVN4VjFrQmp3RWM0?=
 =?iso-2022-jp?B?dWcrcGRiUEpCWGpjZ3VZN0IxYkFLOVVjcXZPM3dkTTZPdUpZSi9YVDBH?=
 =?iso-2022-jp?B?SGlRK216aHA5SERLb3FER1Nld1FBRGZrVWtjbFVtNkxzNU5NZmsyTG03?=
 =?iso-2022-jp?B?eXY4eHg2N0xoQnBQVVJLcWNwNzFxaWlycmFwbjE2WjFBSWRSekFOVW9p?=
 =?iso-2022-jp?B?TEt5dUovbk1YVEVFdFl0S0lJelpzN3NkbU1DOVRVOHFpNXh0cnRFMjM5?=
 =?iso-2022-jp?B?OTBhTk5JamVNMHkxcFg0eko3NkZ2LytDazl5M3RiS09aTHlnTnNvajJt?=
 =?iso-2022-jp?B?eXpKejVQc09NSGs3dUJSbEZrRWdQTHVuSHlOUXJtMDJPVHNyVy91UUVo?=
 =?iso-2022-jp?B?TzVlR2h1VUM2TzN3WDVnekh4aVVwRFRmOUN3Mm8yMzZweDNPZUlkVDJS?=
 =?iso-2022-jp?B?WWt6Y1VCSE01WFVsNkMyZUxWeE9MZmUvOTVPMXRUOXUzd29qT2w1djdI?=
 =?iso-2022-jp?B?cUQ1M3pFZUJHYm9VQjhPN2NaUTd0NFMrcm5aT0pUeDViUDR5alp3eGFo?=
 =?iso-2022-jp?B?Q0RIVXJFazQyWGZJSGtMOGVHSXRnY24zREk3MzhjbTB0c24rejIvUVVm?=
 =?iso-2022-jp?B?VTBDWDdBdXY1NXl6SDFZT2FxT0VYZTRzUTRlTjZZMzBKeFV2NDR4dFdZ?=
 =?iso-2022-jp?B?dHE=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TUxrSWZNbnAyeTBGcU10M1FyQ2hSR3lXUEFiYnhCRFZ2MTdnZU1pcTdx?=
 =?iso-2022-jp?B?OTFXenk4aGpzeERFdXZoSVk0Y3JhSVZHQ1I4S0JrbTBadHJBRUxmaGFw?=
 =?iso-2022-jp?B?VzBFQjg2ZXhkakd2aCtQNUZENS9rYzltRlVyZkZENmZMTndVeEh5eVVx?=
 =?iso-2022-jp?B?SmtvWWpYK28rVlhGNzNTV3Y5eXZkVkw3VFpabWE4Z3RLcHZYVWtIUHRi?=
 =?iso-2022-jp?B?RkRHU0RoMXhXQ2hJOWNaNWZNWVJtQkFsbmEreTB5a082TTVzQTlCOXFD?=
 =?iso-2022-jp?B?RDZ4bURGM2UybnI2Y2tveU83OCtzNUp0MU9OZ0dJekMvbEd3NmlkU05L?=
 =?iso-2022-jp?B?QmdnWk13QTNxZ0MrS1Myc0kyc1d3T282SHZ0andRcUFSRGdCTXhONVlr?=
 =?iso-2022-jp?B?Z0dSeTR1R0JRU2tJRTRJK3J0OTdTTm02SFJRU0ZNYmEvM1ZubDBKQUNy?=
 =?iso-2022-jp?B?eG1Ja0k1YzNBd3FTREVKNUx2VEpTUFM3bGdmbm5KeDBsY1RxQmE5Z2Ji?=
 =?iso-2022-jp?B?SXA5bUhkUjFwOURhZXVPajRLVXlZLzliUEFndFg0bjVTZDFsZWlReW4z?=
 =?iso-2022-jp?B?WktRdnhtY3RoYldkR3h0Nkx2NDFreFJ3QUpkdHh5WVkwckxDeUJkaGdN?=
 =?iso-2022-jp?B?bFdEVVhseGJ4OS91b0ZIZ1hGRUhvWkFQMVphK3VTWXJyajlXRnl2dFNs?=
 =?iso-2022-jp?B?czlGSS9lWW5LMklJNDZKU2tncHE1dTd3R1N5UVVGQUxHTS9ZcGNPTjA2?=
 =?iso-2022-jp?B?U09NS0Q0M29mREE5WU0wcm9lUFlRdzJodDNwaG1Layt6dS9lUnh6SUhJ?=
 =?iso-2022-jp?B?NG5LaVVKdVlkUUhVWXRGK0VxS05VNEY0RXhnU2d5MWxKZk1lT01RVzdi?=
 =?iso-2022-jp?B?Q0g2M0pGVGoyUWRVVll4WDRxRmUwbUpoT3lxZkU0YmhJZlJWN3p1VWpq?=
 =?iso-2022-jp?B?bERGcGtPeHFYcm0yZzlBa28wZXBoWC9STEllUXhJSHZGY3U3TFUyUU01?=
 =?iso-2022-jp?B?UVdoRkQyY00xTXZqMVE5eXNrZmFOSEhZN1hmNlFVY2J0YXBqNkpBc2s2?=
 =?iso-2022-jp?B?RUpyRGJCOWpnbjV3d3JKbGdPRVBqZjM3L1I5MFJXS0ljWjVBeXZLK1Vk?=
 =?iso-2022-jp?B?enFnODRLSTBVUkpWQlJzVktxVVNLeXQ3TkpUb0R1dmwxUmljQWNrbWtU?=
 =?iso-2022-jp?B?a2I2RnNWdnA3Y2JlMmxPRUNOSnFPOHZjNU5GL0tySlk5TFhCanViYW80?=
 =?iso-2022-jp?B?dy9Xa0hUd1RtZEFZR2JOYnVNblQ0enlxZmhIMUlQMUhNaXNiMjY5ZmV6?=
 =?iso-2022-jp?B?aVVEMGZzWlZtd3paZ3g4UjFyMHlWaWgyRDI2MmxqSXFRa25WNWdXNnBU?=
 =?iso-2022-jp?B?UFQ2TXl1S2VsdHJ1Vlg5UDZYMklEb1AyUVl0b3dHSjErZkV4a2xPV1lx?=
 =?iso-2022-jp?B?ZTF4S0xlY05YQlZ3SjFJclhFTWVSNnhUaC9GTDJmL1FSa05OYXRTYW8y?=
 =?iso-2022-jp?B?Vk9wR2xMRzZnWkMwMVhOaUpaZ1dyZXloUVk5Y0l4ZE8yU3RhM2FGSXE3?=
 =?iso-2022-jp?B?VzlxWXJjOGZUMGhta043a1lzNmVOdWdRS1lWb0N3WUhERlg4ZWFXcjJo?=
 =?iso-2022-jp?B?NEQxLzBXYloxcXVlZitFVENFa1RTaVNucVpWdDBEZ2wvYVdWQ0ZRMjlr?=
 =?iso-2022-jp?B?WTdRUnM4WkovdFFHZHNpVmtSMkxGWHhpT3ZTcFM0S1VLRnVPa0tvRmJ4?=
 =?iso-2022-jp?B?MERTZ2l5QTNNdHNLb1RIMzBCSUFSVzdtS09nbFlRQnM3eGUrL3drcC9w?=
 =?iso-2022-jp?B?RUpYYjBoNnRPT0xLUSt4ZmNRbGl0bDdlOEJJNlZ0dU5Gb1JQTUhIbnNs?=
 =?iso-2022-jp?B?eDk5TFJIY0pnYndCM1diSTFTcmFsTUwvbEVqbU94YmtDdFVLTU1DSnhT?=
 =?iso-2022-jp?B?T3FJY3RHR1diVHVoZDRVTHJiWURNKysxWXhNd1ZBVmxJOElLcHk3NEVu?=
 =?iso-2022-jp?B?M25JcVp0RkFITDJXRXVUbURITHpOVzhxMXNSM05NMGRZVDIxditwSGZn?=
 =?iso-2022-jp?B?cm1XNFZaem9NVjRYNUg4VXlwcmJCaFdkNVk1MDFEd0tOV1J2QUh1d1Ry?=
 =?iso-2022-jp?B?eFdDYVc2N3k2clhXaVpNSzV4N1hIdG1OZGw2d3haOXJlbjJldVdKdjZx?=
 =?iso-2022-jp?B?cDBTaWNYdXVCTUcwUHJDTHhrSWZEMUZ6c25ZREJocEszL2hucjF5WFRh?=
 =?iso-2022-jp?B?VGJGK0w5OEk0VGlEU2w2azJoa0llNzJNVTFLWGU4UW5aLzkyVW50TzVH?=
 =?iso-2022-jp?B?L2wya05vM0dqU2FxVFo5cnZNNDA1U3ZtN3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB610020B92F7B4C6A64A62F6CC2E32OS0PR01MB6100jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db001c46-0111-4130-7ffb-08dd3c6a7621
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 11:30:10.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0yqsTThshTcGXPy1vBQcT/JoB/JG1ZdWvyiqT4DEApCXvc5C5QA+v59YqeEpTc0WuwBaGmaS7qFQSg5TLKHTTMvuqc+3I+m4V8DLDg3ogA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8405
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 11:30:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17655

--_000_OS0PR01MB610020B92F7B4C6A64A62F6CC2E32OS0PR01MB6100jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

Based on my understanding curl is required in the security image only if we=
 want to test its features on LAVA. As Jan mentioned we can install it in t=
he test version of the image and add build target like:

build:x86-uefi-test-security:
  extends:
    - .build_base
  variables:
    target: x86-uefi
    extension: security
    test: enable
    use_rt: disable
    targz: disable
    disable_watchdog: enable

Note:  Since test is treated an extension value, we can declare a new varia=
ble like test (disabled by default) so that we can have both security & tes=
t extensions in one target.

This target can be used mainly for LAVA testing use-case.

Thanks and regards,
Sai Ashrith

________________________________
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
Sent: Friday, January 24, 2025 1:36 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; jan.k=
iszka@siemens.com <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org <=
cip-dev@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core][PATCH 3/3] customizations-security: add c=
url to download LAVA overlay

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates an directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The Device-under-test
needs to be instrumented with with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download to the overlay from a http server.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/security-customizations/security-customizations.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/security-customizations.b=
b b/recipes-core/security-customizations/security-customizations.bb
index 75a6a99..9fbc2a5 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -18,7 +18,7 @@ SRC_URI =3D "file://postinst \
            [file://ssh-pam-remote.conf"]file://ssh-pam-remote.conf"

 DEPENDS =3D "customizations sshd-regen-keys"
-DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-authent=
icator, libpam-modules, libpam-runtime, auditd"
+DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-authent=
icator, libpam-modules, libpam-runtime, auditd, curl"

 # Package names based on the distro version
 DEBIAN_DEPENDS:append:buster =3D ", libpam-cracklib"
--
2.47.0

--_000_OS0PR01MB610020B92F7B4C6A64A62F6CC2E32OS0PR01MB6100jpnp_
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
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Based on my understanding curl is required in the security image only if we=
 want to test its features on
<b>LAVA</b>. As Jan mentioned we can install it in the test version of the =
image and add build target like:</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
build:x86-uefi-test-security:</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp; extends:</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; - .build_base</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp; variables:</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp;&nbsp;&nbsp; target: x86-uefi</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp;&nbsp;&nbsp; extension: security</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp;&nbsp;&nbsp; test: enable</div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp;&nbsp;&nbsp; use_rt: disable</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; targz: disable</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; disable_watchdog: enable</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Note:&nbsp; Since test is treated an extension value, we can declare a new =
variable like test (disabled by default) so that we can have both security =
&amp; test extensions in one target.</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
This target can be used mainly for LAVA testing use-case.</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quirin Gylstorff &lt;=
Quirin.Gylstorff@siemens.com&gt;<br>
<b>Sent:</b> Friday, January 24, 2025 1:36 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;; cip-dev@list=
s.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Subject:</b> [cip-dev][isar-cip-core][PATCH 3/3] customizations-security=
: add curl to download LAVA overlay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Quirin Gylstorff &lt;quirin.gylstorff@siemen=
s.com&gt;<br>
<br>
Lava generates an directory, in LAVA called overlay, which contains<br>
all scripts and tests of the test stage. The Device-under-test<br>
needs to be instrumented with with this overlay.&nbsp; LAVA provides the<br=
>
possibility to download the overlay via http or NFS. We use curl<br>
to download to the overlay from a http server.<br>
<br>
Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
---<br>
&nbsp;recipes-core/security-customizations/security-customizations.bb | 2 +=
-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-core/security-customizations/security-customizations.b=
b b/recipes-core/security-customizations/security-customizations.bb<br>
index 75a6a99..9fbc2a5 100644<br>
--- a/recipes-core/security-customizations/security-customizations.bb<br>
+++ b/recipes-core/security-customizations/security-customizations.bb<br>
@@ -18,7 +18,7 @@ SRC_URI =3D &quot;file://postinst \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [file://=
ssh-pam-remote.conf&quot;]file://ssh-pam-remote.conf&quot;<br>
&nbsp;<br>
&nbsp;DEPENDS =3D &quot;customizations sshd-regen-keys&quot;<br>
-DEBIAN_DEPENDS =3D &quot;customizations, sshd-regen-keys, libpam-google-au=
thenticator, libpam-modules, libpam-runtime, auditd&quot;<br>
+DEBIAN_DEPENDS =3D &quot;customizations, sshd-regen-keys, libpam-google-au=
thenticator, libpam-modules, libpam-runtime, auditd, curl&quot;<br>
&nbsp;<br>
&nbsp;# Package names based on the distro version<br>
&nbsp;DEBIAN_DEPENDS:append:buster =3D &quot;, libpam-cracklib&quot;<br>
-- <br>
2.47.0<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS0PR01MB610020B92F7B4C6A64A62F6CC2E32OS0PR01MB6100jpnp_--


