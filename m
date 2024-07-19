Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE43C3DA5D
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 09:33:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.web10.15167.1721381620170948743
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jul 2024 02:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jk7u3H27;
 spf=pass (domain: renesas.com, ip: 52.101.125.6, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlVFlT6z0q0PBXJxQNs12lGeXdWQ2VSH6QBRk/xz5q3yyW628EqwYCQr/EGxPQkS7V0WP4KxTb8dpFrL+4Z2oecb0p1TV03wcwpdhp1zHGwCFBTNFF+GWdnWEH1SwJJiwEQdFgHKjU1Ju+naQSdIsEWXTCGPgjVgiIIe/AwEPfMWeeaD0fBjukmJWvGby1Nk1fTJ2mXVmpladtCQ7IFSfudR5BeMtTVIlIORNThsM55yEdGS11qoSd2ZvT3Dcklj2rBrQzOCOD/HMwA+VbFdMWZ7QKeKfvXCGxxW4YVLsDV0j9jzjL0YMScipG1xih/Hfb5Vs0BUtc7qwr9QtbT/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amn7sAsEw6n97b9440wnhzYWvidztv3IcaYP1d2TqIk=;
 b=f5s+zTi199tCwbkvPSJ+uHz7JyjofEzbBAwot6/qMz/nXucwCq+DzTFvL+HgmW4tF3lX4q7CE2+ZWRJ5P9HtmEuilmZ3hxLqDht4v59mJOljBWE8Wg7gEkh9JQtOwWi6Gmdx56uykYlWg3D3pC9JOqPpm4PaqSf70ibnR65WoHTWB2AuYb0s/itNDVb42MVO6DTDp3GEK2l0Pm290z0DFbovr2VfCqUFj7laSWJWbOCKG8P0RkitjrfLPuesQWA7PpMDkWNtf46oNIbHyDRAhV5ibqunPTW5Vr/vzoSq5jVoY1XB1Ssu/6jqLGyPLFjw0ZumGyH0dSqs+C0v9Vx7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amn7sAsEw6n97b9440wnhzYWvidztv3IcaYP1d2TqIk=;
 b=jk7u3H27BeNEHho0PPYrVicCkI2OqZ2dM7ZM6luiD/A1JcbhQaB2ONm+XKy9KCNKVHHSfreFHBEylvv+ad/55M0NGJuJoBl5UhymxK1UQlqHBThdEg9j9KYAJ14Me8rWZS/f7/3Tbx44UaLw/T6FvPblbQ+W/T4xJzXaKZCyZrU=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYWPR01MB10613.jpnprd01.prod.outlook.com (2603:1096:400:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 09:33:35 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%5]) with mapi id 15.20.7784.015; Fri, 19 Jul 2024
 09:33:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Arisu Tachibana
	<arisu.tachibana@miraclelinux.com>
Subject: RE: isar-cip-core upload to kernelci fails
Thread-Topic: isar-cip-core upload to kernelci fails
Thread-Index: AQHa2SxLZyZZK93/s0Kt0sPq3vhFn7H9yt9Q
Date: Fri, 19 Jul 2024 09:33:35 +0000
Message-ID: 
 <TYWPR01MB11862284319606A9ECB41D25CB7AD2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <4ec5461c-ff4c-43f5-b868-576cbb295bc9@siemens.com>
In-Reply-To: <4ec5461c-ff4c-43f5-b868-576cbb295bc9@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYWPR01MB10613:EE_
x-ms-office365-filtering-correlation-id: da066c93-9bec-4c63-e140-08dca7d5dcfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cjN1Uk1ndnIwNkxXTmFEcjF4RTlIZCtJWit3V1IyY0lCQlhqMnFxemF2eTl6?=
 =?utf-8?B?RVBBTnVic1dlY3F4QmJSNkYvU1ZMMk40YU9vSG5Bak1TQ2ZhQVh2ZUZPSVkv?=
 =?utf-8?B?YzUzTWtRbTN3eStSQlQydWNyd3BVSzUxOE5XNit3b3MvZW5EQnpyUTVFKzAw?=
 =?utf-8?B?L3g3TDh0YTNJc2FteFNQV08xVFhHejJvQlB0Y095R0tDL0l1UGQ2cVZnZGl4?=
 =?utf-8?B?Y3NET29NZHVNeHJqdUQzbjlGRVNEREdjSmlzcDZqY3Y5dFhSeUUwVURUVFY5?=
 =?utf-8?B?WGdoY2Z6OHhRU1dCdDgvZFBPSEpiRENnTHJYdW1RMnE1RFU4TUVHVC9nWEhk?=
 =?utf-8?B?UjFib2pLc2JVN21RRmxQZlpGTjc2eDdIaWYrM1FXQnQxVkNvMWt6NGRzMmdx?=
 =?utf-8?B?WndITzlqWUM4N2liSUxiTFFBQkwvZVVDZkZUdmpQOGdKajh1MUlXQWcrdE1C?=
 =?utf-8?B?MjlIVDhDMEozd1U4eVNnZVVPMkVhV1hnVzVvWXVLeUh0b3Jwc1J3T0d1MkN2?=
 =?utf-8?B?WWhITzcvL3c4NnJZTm42NjRaZ1M3Um5zR1d3ekR1M20yWjg2YVhoQnZCRk83?=
 =?utf-8?B?SkROVGZhQnd3ZjlhWU1VK2RxbXpkZVUxSXFuQ29SUTBFY3h3TzNQdUEwSTdD?=
 =?utf-8?B?Si9ZbTduTkY3Umh4Nlo3d3RpUVkzR3BTdWdJTVFRSEs0aDN3NFhsWEtCRmFT?=
 =?utf-8?B?dmo3UEtPTytFanNycmtmTWVYQ0VmdGpJTWlrZTYwa05mbStONUJTTXk2SnVo?=
 =?utf-8?B?eERFelN5L2RwY0xtcEFvcnRLT1JmZnJHSGVBNVkxbFM2RVVkY0dpZFYxbGMy?=
 =?utf-8?B?eW1RUU1XR2pTTGxHMURWZzhjMk1KUXFhZ2o0YUZ4dll5QnE3djlWbkhNK0dT?=
 =?utf-8?B?L3M1UjNyNFpWb0huSEE0d1lNbWdZN2JwYmIwTmw0ZnF0dlVraTZGT0JBZmVt?=
 =?utf-8?B?eU53TGkrQWhlc3ZRM3l1NEs0Y0Q3VzJtOXdYV3J3YlFjVFFoWkduSXE2UHNR?=
 =?utf-8?B?T3g5UkdORUt1ZW95V0lLWTdkaVhzU2pKVlJsVTJMS2xHWWIrMnhHMGNQYXF5?=
 =?utf-8?B?ejQybm9iN240aWlKRnBiVCtTK3Q4K3hKSTM0NFZjWEh0aFJGMElBK1l1OVRU?=
 =?utf-8?B?S2FqclczSDVZeXUrbjkrUkJaRm5UKzdwRkM5UTFiais4Zm4wTDhGdU9mYnhN?=
 =?utf-8?B?cXE0eHMrdDkvaEJhWjJxVkRScVVpeG5OU3NFSVZ3UkR2RDhPYlIvbFVlUDVV?=
 =?utf-8?B?UnJOc1kvVGxaY3dUTkZlWDVuY2xDUXZKNGtwRktHMUg0MHFGcWJrMEVkYkRo?=
 =?utf-8?B?RGcwVW1TVHg5SlVPY251YzNRSE96QllPckZGUXcrVHpmNmdHUUE4ZXI0WStl?=
 =?utf-8?B?cmpGUTN4bTJUY2RXSUw4RVBkM25NdUNTU1pOVkNiaXdRT3lIRmRpbCtJNFo1?=
 =?utf-8?B?U1MxM2I3MDgzMnZ1dE5uTVJ6UHM5UlQxOXVYZTdJM2VieXFtN0RvVFJOazlU?=
 =?utf-8?B?a2pBZ1pINEVyTVN0d3ZmUDRVTFp5dVQxV2k5ZnhxK3d3YkNLdlVteml2RTVN?=
 =?utf-8?B?dC9WMy9sUktaYU9aU3d2dzlseTBiNHAzbjA5TklmV2JKSEtHZ3V4ZEpDbE51?=
 =?utf-8?B?ZnJkckFOTWVTYnhvUXlnM3JtRkJZVGROdEFSZnd2VzI5MWlzME4wWE1pV1Qv?=
 =?utf-8?B?Q3I4em94T0JRZ0RxeUQxNnVZU0ZyU1dtamdLYlY3RlRqRUNONGNDZzJZOGlO?=
 =?utf-8?B?TytVd3JuQzJaQWptbStCK3lOMWE1L2NaQmhMTS94OU1pL29YeldCLy9ZZjdG?=
 =?utf-8?B?elZyeXlHNnF6K2lMTHdUUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b2g3U2ZBUjNqYXVaMWx3UlhQeU1Kdml6VXQrWkd5NmN4MUJWektaQTZib2dM?=
 =?utf-8?B?YkJsNCt5RllwQzJDL0R2TW9mVzNyaHVJSGdNSlg4ZzVPWWZUM3RTamI3TE1F?=
 =?utf-8?B?M0p4VExxUkl5Vy9oZGM3RUhFVG5KbTRnWDNncnkzV3dUYWlHM1dGWW45ZHVk?=
 =?utf-8?B?bG1GSlBLYk1mYUI5TDRaTTNKV1U3Z21ERmN3UkdkVUI2Yy9raDFWd201Njht?=
 =?utf-8?B?VFBSbzdYSk9LWGxjTVNOWmJZV3BGYncrejcyaEhqejFDWk1VZE4ra0tzNmcr?=
 =?utf-8?B?YkVwUWs1MHAyUFlJNytHSVhMZFJJVUZQaTBVeWtHWGhLRDNFS1ZWU05LOWcx?=
 =?utf-8?B?K1FJS0sxYUpOV2R5NS9LRjZHSE53cm9KYTFmb1N3dVJlT0F6Qlk0YTRXWTJZ?=
 =?utf-8?B?MFU2YTRobWNJN0VoQVJuSFZxTVlQQXQweC94eXJDWTFlLzZlbkF5dTh5dExq?=
 =?utf-8?B?ZzA5Q1ZucmNabmlNUGt4Q2FjOWh2eEYyWjFiY3ZxdXo2dElWdWV4R21idVN1?=
 =?utf-8?B?cG9RZlBacUpETmdvRWs5a3Y2WjIrSWNvUG5jQ09IMFZsM1Q5TmF2VE4rYmto?=
 =?utf-8?B?bDdEOGFvbWhna3NiejNqZ1JUdE03NEwvR2hyK3o2dXVsNzNqNWdqUnZiZXRO?=
 =?utf-8?B?R1RxL0VnQm1ZOUVhMkU5b3dxTmMvWDRHeGw1MUwzV2gySW1lWldRaS9WRktr?=
 =?utf-8?B?c2xGMTFER2NnU21rMUtONWU4NjZLWGw5WTVmQUErK2pKNVFRWWdmYlBoMGE0?=
 =?utf-8?B?VTQxRHYvWFRPc3JDdjdtcnUrMUx2d2Vld1BYYUNsblVvejZTK3JEZTVVK0Vo?=
 =?utf-8?B?YWVSQ3VxVWNZMVhOV0RRZ0IyVTQ5MTdCOUZMOW9zY1VMVFUxRFo0cFIvUUxB?=
 =?utf-8?B?VThyanM0U0d0V0R5ZS82RGgyRlpmcnMxdW9DK3hzNEtiZ2R6c3NDTlJOTWpR?=
 =?utf-8?B?bENCbEdiTC9naVYwSiswVmlxcTR3dFJBVEcxMlZJQ2VUU3FEQkhFcEgyS01F?=
 =?utf-8?B?b2xrTHJSZkFnUTNma3FWeGt2MjltdVdHdUNYRXVObXZTZEh1Vm5mb0JCK1ov?=
 =?utf-8?B?dHFVSEFkRHJXZCtvdCtyTjdNL1lSMjcrNUZ2M0ZCRHBucXdpTXFMa0VDazdj?=
 =?utf-8?B?dlRDczMzWG1oVU1XblV1MURKdkU1Q2tIZklmUFZIV1lwdDB1b2lmWElNN0c1?=
 =?utf-8?B?dmRoaHhseFpSZGViNklyYmYzVzh0Z2dqb3dDRE5hKzZkSHJybXQ3RENUYVR1?=
 =?utf-8?B?Z0k3cVF4YmJXSzRoa0NoWDRBWWR5Yi96ZVMwTEl4ZXhRUnUwa3VtQ0l4NmRJ?=
 =?utf-8?B?dFUxMHZrcUNLTlFQRmNiend5N1RxcWV1U1dnbzdJTXBwaFNDYWV6bUtKaVgx?=
 =?utf-8?B?WkRqcFNUNi96c1NkOHl5QUVpMVM3MXlYQ2I2a0sxWGhiczN6RExaK2ZIdnNB?=
 =?utf-8?B?RE1zL2hZeGhrWkpvbkw3NGYzYzNuc081ZitvS3l5UjdtYUJSOFlYNFhQTDNZ?=
 =?utf-8?B?YjdvVTE5NUlCV3dQaG40V1FibzFxMmZDcW8wa1Q4WGF3ZThDYUFFQ0FIc2VW?=
 =?utf-8?B?Z09BdFlIUFZDSHZKRUdKdUYyVzhHRVBjYkk3bnNtV2xwaXNzY0tkS3oyOE1N?=
 =?utf-8?B?T2diTVVza3crL2JvZkcrT2NDN3hqQVVCdmdNK2YwSDdydlB4TmpoYmVER0g1?=
 =?utf-8?B?QVdESHdpUy82QTNmcTZIYTh5dmpKODlrNlJTcndudHdGTW1NVnd5a0N0TjRh?=
 =?utf-8?B?V2hvOUhQZWlRRXJNaWZTbUw0bnlVMEtOcHgrSzVmNUd3TzhYakN3WlZ6azBv?=
 =?utf-8?B?bFVmUFFIbDJzYWI5SGdwSGVzS1JIMVdVYXF3L3g1akNHcmExaG11YnEwVmxs?=
 =?utf-8?B?ZFpUMExtTFBlTzZCek9lRFZoVkhiamRQQU01eXlWSGVUdVlCcEUzdEt1aTBp?=
 =?utf-8?B?ZzZGR1d4WHhHejFYeEU2V2w0enNybDdXcTZOVnpiN2VUS2JJZlZGY3NNemF6?=
 =?utf-8?B?Z0Fwd1N5L2Riek8yYllsRzNKaFhVT0RmNVFtNmhNMEZhQmVndm9OVGxBMFY2?=
 =?utf-8?B?K2xBSUNRdGJOYTd1cTN3RW8vbjRidVdUcDJXaGQrU1lOQ24wcmRZMnNWUWRh?=
 =?utf-8?B?a0I2QWczb1JETFBQU1NHMit4TWhrNll4MWZDQzJMcXhQTFdaRVNaSVNkWEhv?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da066c93-9bec-4c63-e140-08dca7d5dcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 09:33:35.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJI6a8+Gu03BNt4kTpuZPDnpNdXbr3WoC3748XlyYmp0iLl3L2ibMioKQZDlXwWzeajF6EmxQTexm+JltSzUAvgRP+UGUurBD0rqVNU4OZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jul 2024 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16593

SGVsbG8sDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMjQgNTowNSBQTQ0KPiANCj4gSGkgYWxsLA0KPiAN
Cj4gd2hvIGNhbiBoZWxwIHdpdGggdW5kZXJzdGFuZGluZyAvIHJlc29sdmluZyB0aGlzIGlzc3Vl
Pw0KDQpJdCdzIHByb2JhYmx5IGR1ZSB0byBzd2l0Y2hpbmcgb3ZlciB0byB0aGUgbmV3IEtlcm5l
bENJIEFQSS4NCkkndmUgc2VudCBhIHF1ZXJ5IHRvIHRoZSBLZXJuZWxDSSBmb2xrcy4NCg0KS2lu
ZCByZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiByZXF1ZXN0cy5leGNlcHRpb25zLkhUVFBFcnJvcjog
NTAwIFNlcnZlciBFcnJvcjogVW5hYmxlIHRvIGNyZWF0ZQ0KPiBkZXN0aW5hdGlvbiBkaXJlY3Rv
cnkgJ2ltYWdlcy9yb290ZnMvY2lwLzIwMjQwNzE4L3FlbXUtYW1kNjQvJyBmb3IgdXJsOg0KPiBo
dHRwczovL2FwaS5rZXJuZWxjaS5vcmcvdXBsb2FkDQo+IChodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL2pvYnMvNzM3NTQzNjQ0NSkNCj4gDQo+
IEFsbCBrZXJuZWxjaSBpbWFnZXMgZmFpbCB0byBkZXBsb3kgcmlnaHQgbm93LCBzZWUNCj4gaHR0
cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLQ0KPiAv
cGlwZWxpbmVzLzEzNzg5NTA2ODMNCj4gDQo+IFRoYW5rcyBpbiBhZHZhbmNlLA0KPiBKYW4NCj4g
DQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K

