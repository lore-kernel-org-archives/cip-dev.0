Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F625C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 14:09:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web11.37165.1737382175796272064
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 06:09:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VzKEEY6K;
 spf=pass (domain: siemens.com, ip: 40.107.22.48, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSU8r2b/K6aVSAOC40hUKgQwypKXKruiWVxaZaQxtu8t4+lywg2llJmszc8o2W738jOO5rta/eZGPX9hhT+hngw9qk5EEtNfQ2TGMRpUdjNxncZfdEyisG9zeXtfgZEwXi4aRrHTA3Xie49bqalCIwu/Ot6ZVYANRp6DmjKmcCacBXD/Tbbt3wkNnflaa2G621RqT8fM9xiQ8Zrcg3XQEvhBAVFI6nLvVRxoSpTmU/JZoa2/kIQNH2XUVGyZdSDrMTWjE1y1IgbEDt+A99BVOhdceIXODIAKkpFrkGhgGg+1Mhiindc5+pqRYXzBYjkeblSVWrCHpLVRppS9Qxi5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP4tLNww71IAQ5hx4ZhSLm9y9skqTdNoEurqec9JNeM=;
 b=H99ZUMe/jdVAYq0PU6TXP/4VWjPh2ceiLYVz4t9I8SA4LY5TewxxZdGHjsCHfhetCDsKQ78ojHVYMso58+ybSmYWTQTJjaB7NU7g3im1oi5CLQPqeh2MRYaaesJ3KhuoFlk1cORJWU1N1WpIjzAHp83Paq/gBjqj783J0559X75HqnlqhtoGDLKW6y8YrVDlrZ9/G0EMJ5V3QvYEocASeP6jNv7WFWQb9WV+ySYdOdTLSivy6O0JY6y2alop0YtMi6NaIVtLRqI08K3a4R/8eGtPHF1XuxYAv5tDXjIDIX83v00FtycnOGCYZMYxDcuTUEShtmWzuwP5ovkdUgiQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP4tLNww71IAQ5hx4ZhSLm9y9skqTdNoEurqec9JNeM=;
 b=VzKEEY6KhoPHZXVnI97FyPjS2yuvrQOik45Ynrxj0hJojGLDhVyXgkoFdL/f8OoS+XYgx3uFIq77bfLLQWcMytsf8vrL1wBNi4DJLJB36w5KSRmH7PwYSTyTmPl2ZGKRTtB2c4m1ADO1+HeUYw+HuuHE6XbXr8lzARGR/WUzGjoYiz9tzbHNcClZiHqNEjin0xDFNEDw1y46K0jDrZjbscZ3IsNMRWb5ni+rFPL7KBwQ4UfMZ94W/YjqdI4UsQWCwbx18ZkoB3Lj+bZY69YH9e0DTlN3q7cuEJFD+u8pBeAObIvcrKapajOJ+kW7L5NjER+aaXVHQHQUXJCuYEHVGg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by GVXPR10MB8862.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Mon, 20 Jan
 2025 14:09:32 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 14:09:32 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Topic: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Index: AQHbazezIiI7wjl+fkqPTcspEMyCx7MfnawAgAAQqQCAAAUUgA==
Date: Mon, 20 Jan 2025 14:09:32 +0000
Message-ID: <59ebca3ae43ddc47918de2aca962991db517fb43.camel@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
	 <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
	 <612ec933-6036-4df7-bda2-c07e4989a6c8@siemens.com>
In-Reply-To: <612ec933-6036-4df7-bda2-c07e4989a6c8@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|GVXPR10MB8862:EE_
x-ms-office365-filtering-correlation-id: 358698a1-220f-4072-81b2-08dd395c103c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RFZqS1JONGc4TzlFSU9zQWFvQW9VV0RCOWZGTFhvVU05WGRtaDJoTnA0L0Vw?=
 =?utf-8?B?ZFk4aXVCdXJqQjVscFd4WDhOcHNZcHYyMGlJOUdyaSsrSkIySlFSYTM5aHNR?=
 =?utf-8?B?c3JmcXVBSzZwVE45RmxiWDR0SzhjdEVWSzlsODZ0QTdhQ3JrcWVNY3lOOTUw?=
 =?utf-8?B?Nkp5UmFyaEQ2ZjJWZ0crNHV1emwyWFFZUk9iQ21EVzdDWFVOcEdUMWxWdGNh?=
 =?utf-8?B?aVBRRVc1Q2tMZzlUa0t0SjV4U1BxT1BodHVBc1pXUjNmUGhXOWxxbDBSMlNJ?=
 =?utf-8?B?ait3VUJsd0g3NnV3VGk0ck9acEhHTkp5dFJ1V0ZOTUpDL1dMMk5veGNYendx?=
 =?utf-8?B?elJrZTYwZEx5RDJFQ3VMWWNEdmw0QnZmQUhQS1NNWDNPUWpnOTg0bHRidWxL?=
 =?utf-8?B?OUs4dUgzVEs4ZEp1eE9ZQU9XSXA2elNFeGdrY2l3QUs3RGJiTnArOE9JOE9j?=
 =?utf-8?B?K0NqN05xTHVnTTZiS1d6N2l2Zndlc1pZd2VxcHBtV1J4YXY4SEVzelZVU296?=
 =?utf-8?B?aVFSeEdzR2JTMW14Wi8wUnFHYkx5UzVveGZZSm9XdnYyRUtPbHN1cmE5TG5J?=
 =?utf-8?B?MGVTNVhWL2pqUjdIWVgwZm5kTFNCVERtc1ArSVRieWJzU1NxanAxL1VqTHVQ?=
 =?utf-8?B?eGw3T1JyS3lPaWF2RFdpZ2pEYjEyMjRsd2E3aVpCQnJIUmtqQnNlN1ZoMGlZ?=
 =?utf-8?B?T3NXaG9Ba25hdzJZbUpQZU1CWDRMVmcxMHd6VmNTU2k1blVFUGJjOGUyUjZP?=
 =?utf-8?B?MFg0dXY5SEZSOXBVZk83NHBGdm5na2llTEdvNm15UUt0ai9ldlR6ZHJ1V2hr?=
 =?utf-8?B?UWp6U1NITDVOdlhsdWhZYzNsenRSTm9yMXgzZzhBcU1POXUwOVZoTW00L0JR?=
 =?utf-8?B?Vm1nMzhycms4KzlGbitlL3BRL3J3bXh3bUlyVVN4TGdKR1BESyt6a2QrTXJR?=
 =?utf-8?B?MXh0VmlOZUYvaHVTNnVYbzBSakVrSmsxTXRCMzN0YUYrMCsyTGRram41WWNy?=
 =?utf-8?B?d1lrOVJ5SGFDeWJ3bnlkWmFZNmJGbEVMaDRYK3JxRlFiRnlnY2tjRjRIbWtG?=
 =?utf-8?B?T1o2RHNnZmFibEpzeXJhc096SitrR1l2dHRha1VKbEpob05xZ2xGQ1pNc3pQ?=
 =?utf-8?B?ZG9FSGhOVHp3SWUzZEovZWh5bFFNK1djdUVGRDBpM2lVTjRvVW1EMTBlVFlZ?=
 =?utf-8?B?TWFWREphM3Bpa2R0NlhZaFRkK21ibTNJMFptb0FZYy9yY0x6cWhCYkdRMUFU?=
 =?utf-8?B?ZG1FdFlHVGVNaFVhMkNMVjJxQmQ1QXBBbTcvMEtlUGsxMkIzSGtTMFduUm1i?=
 =?utf-8?B?cUFkWHRQdHVDV3NkKy95Y2tadlh5bUNQbE8yc204V3lRWGx1VktBb1kzU2E3?=
 =?utf-8?B?WldxYVVtRW5mVFA2MDNSOE1TN0w2QTBhdFU2cm5nUUF3WmlYSkxXbHNEbGxv?=
 =?utf-8?B?T3Q4eVZGUTRzWUJRekZ1VGVCbW5lL3lQcGw0NkR4ZndTSFB6T2J5SXlsdjZz?=
 =?utf-8?B?eG4wZThpMURoOFVhV3dCaWh1RTlmc1BoWTRRRks2UFVYV0ZNaXNyRU81b1gv?=
 =?utf-8?B?OFBnSFdaUHoyVGxJZGo2Z2NzekVDalB4VnhEUTVES3QvSW5NeXpOdUJKM3Rp?=
 =?utf-8?B?c250YWgwd1lZbGwvaHVTTFdLZ3doZktYcXVKa2hia1J0YjN1S3N3aUpRNWZC?=
 =?utf-8?B?NXovZUZZc2dqWUFFR0ZXT0hscUlYSUMweVRZbXYyaUVNMldwQnV0ZEZzT0Yz?=
 =?utf-8?B?RGQxUmJIeDcwOVNJNUNuRVExZ3NxclYzUXc2OGQ0U2doVEN2SXZDZ3RETmVh?=
 =?utf-8?B?cEFSeWFia0oxT25lRTlFdThVT1lCRGRUeElhS1JXYklka2tXalAxWk5NM0xR?=
 =?utf-8?B?K2tsSXF4TXhQMUtIWDhaNjlmZi93UHlqNEVtZUlITjBKb21SaWorQ2dJNElC?=
 =?utf-8?Q?mg9RJTDlHOxbNEx0fgyttUVao9udQjVf?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WjFHYXZqanppb2d3R0hYMjVBaCtSQkxmQ2tYUStsZGU1UGtwWWRRZmlRb01J?=
 =?utf-8?B?NjBTMVVBeTlUWmltZnA5bzNyWHE3ZG5XR3B6NG9ScHh6QzgxNDczWERuaHpD?=
 =?utf-8?B?M1NKbGlpby9qRGh4M2xBT2NCOXJGYysxSC9ZbFV1TkZxSFBsbmRaMUxEKytK?=
 =?utf-8?B?QUxaVXpwUjVWTzFYM3NPZUl0YWJUM2JMTU1GUnNxS1hiU2hGZVRid2xvOVFY?=
 =?utf-8?B?UUk3a3RFTzBLZVpIa21ybkZrTkxGYUZtMWV4SzMveGVOQWl5Mkl0OWRwMFJv?=
 =?utf-8?B?NHFSdWRQZmx2a0JGZ0xQeWV6OGMrVTZPVVhOOXg1dDIzcVV1T2NPbUw4ZTJB?=
 =?utf-8?B?SHdKYmRlS2JwTjVySit6WmczMjBNcHVUM3p5ZG5OQ05GL1RVMUlSVlFNUDVC?=
 =?utf-8?B?TTNNVC9GRkFENzZNRHAxQzFWdWppWlcwVnBINE9RRE95cUdod29KWEdoTHY2?=
 =?utf-8?B?V09HMnpvMStIYVFIaTRqaUpvMENSWWU4dzdFTVUxdG9EYVRZZ3F2c0xrMzNq?=
 =?utf-8?B?bkg4UGxlbVJ4YVFiaU5BdTl2cDVVUU5PdkViS1Z5QnNFMHFrSzJrZElRSy9i?=
 =?utf-8?B?dUorZE01cVZZRnZDc1llUURHaTZ5YlpMU0JIN0J4eUFYUE82R0U3cjBVSk5M?=
 =?utf-8?B?VU5VOExqSWsrbHpya3BSTXFwSnVHMkRiQ1JYdVEzL3BYMVZFblZHNjNhU0w0?=
 =?utf-8?B?OGxKdVllK2V4RVB2bXFIdkRFSGtNRnc1ZXVjNDdOK3J5TUJGYmpNaFhTSUpW?=
 =?utf-8?B?MDAxMTlXQ1NDRGpXRkhMbS9EcGFtS25qcmJXQ0llVVMxaHdVRHAyNkhWSzVN?=
 =?utf-8?B?VEJHWld0U2N2dGNta1RpTmg3VXNVeHBQZG5UQXhNMytMazVrZ2Irem9MZ1dj?=
 =?utf-8?B?cGwrYlUxMzg5a0xHVEJzelVDeVAzdThkcGVSNmVpVk1SdWxzNUQ0RC9mcDBO?=
 =?utf-8?B?dWVUdHlyenNtUjdMWTN4eFU4MnBmc0tLbVhPbE9NeU1jcjdWK3VCRzBwSjRl?=
 =?utf-8?B?L0Fvc3hqVEZtaWdNWE95b0wzMGtHaGFrRHdSUStyc005MUhQakpNU3p1NEJC?=
 =?utf-8?B?QjhlckFyUjNoMXAxK0NqbjZJL3dwN1Z3aFNRN1hXUXdNYWZrTThBd0E2NXNr?=
 =?utf-8?B?Y1d3T0c4cDRGdXBwMnNlazJGN2FaeThxcndFeHNJOS9rMlJ6WEU4ME1US0RP?=
 =?utf-8?B?WlV6eWZIdUxWbm8raVUyOWRpNk5hZFBKNk5ieTk3NXdPN2FPQTdONjBVOGNP?=
 =?utf-8?B?d0RhZ3ppR29EZ2lRSXlCQ1hVb1JJdmhtZFZIVHJWR2VlY2psMFBxYUgvdDVi?=
 =?utf-8?B?TFpYSTc4NEN5b1lvays2SFE4bjlQNi9xS3lldTNhRlBHaFhLRzQwUi9qeU1h?=
 =?utf-8?B?MjZibEoxVmJlYTZyVUs5Z2xkNlg5clBTMHZJNjd1MlhoM2YwSUxiY0tmVk8w?=
 =?utf-8?B?MXJJMWRsc3RHNlRPSjBvdlBSNVljSEEydVhPbXloVzRaa3AySWFjelVLVXdD?=
 =?utf-8?B?bjlMbnBkOWd5NTI5SWg3WUVRTTQ0WU9hMU9qOE5VY3Y2amRXL2dvdG82TFow?=
 =?utf-8?B?YzV1dThLOW8vdUd1dlFDL29wSkRRTEpKRStXdEp2WTZNbWdMeXNUTHZERXIr?=
 =?utf-8?B?c3h4NU8wRW0xaWRIelZtN0R4SW5iZGFZbnFYeWxBV3J6NWlDRTh3L09yOGFt?=
 =?utf-8?B?RTVnb2lBYjg3Q0RhTWowSm1td29DMmUwK3g1cXBGQ25Wai9nd0dhS2pJZVAx?=
 =?utf-8?B?azRzQ0E4STk5aFVFbXlGci9PckNSNmN5NHNjSmxlVGpacjhGSU1SbVVLbGdR?=
 =?utf-8?B?MVlOU3pLZU1wMDdlUDhzMHR2Sm8yTFlDYlYvS244dkpDSkpJZ0hDa0lBN3dh?=
 =?utf-8?B?SkNhTUJDUTUyVVNuWkZ1cGdLYW5iTFpWOEtFTTNLRm05Umlob2VrYjZzSXZs?=
 =?utf-8?B?Sm5oMVFxYlgyV0x4WUErY0NlVGxLb0c0eERnVG1qN3VhOGNPSHpsVW91YnB2?=
 =?utf-8?B?YmVoT3kya2crNURqd082R0UxdG9Cb1RUa21semQrd0UyR05hdVBncHRNcTlq?=
 =?utf-8?B?OUtzamRFN05JUjBveWgveFVWRzI0V3ljRU9sa2xYVE9xQnowUDRtS2NmTDhy?=
 =?utf-8?B?UVRwSyt3NHMzV0tReHArUkE4RUczZXhCR0g2YTdiYWVQdnZGY0owRTZVL3Fv?=
 =?utf-8?Q?nljpaFdf67lFZIB+Mcv4iUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC5C2237666CF7498773D06B1D4F5712@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 358698a1-220f-4072-81b2-08dd395c103c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 14:09:32.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq6DmPKmF88UOHNR+I+uNgqrPuwmuGsSa3HkQAEsmjHd6t14R28c7f9Ct0sKfTH6zsNHJYaPEIaJ177xAyuoP27agXshszlWmX9PMmyiQFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8862
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 14:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17553

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDE0OjUxICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMC4wMS4yNSAxMzo1MSwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQgUlBEIENFRCBTRVMtQVQp
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNS0wMS0yMCBhdCAxMzozNCArMDEwMCwgYWxleGFuZGVy
LmhlaW5pc2NoQHNpZW1lbnMuY29tDQo+ID4gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbGV4YW5kZXIg
SGVpbmlzY2ggPGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5zLmNvbT4NCj4gPiA+IA0KPiA+ID4g
SW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gKHNpbmNlOiAyODQxNzVjMykgZGlzayBleHBh
bnNpb24NCj4gPiA+IGxvZ2ljDQo+ID4gPiBpcyBkb25lIGJlZm9yZSB0aGUgYWN0dWFsIGRpc2sg
ZW5jcnlwdGlvbi4NCj4gPiA+IA0KPiA+ID4gVGhpcyByZXN1bHRzIGluIHJlZW5jcnlwdGluZyB0
aGUgZnVsbCBleHBhbmRlZCBzaXplIG9mIHRoZSBkaXNrLA0KPiA+ID4gaW5zdGVhZA0KPiA+ID4g
b2Ygb25seSByZWVuY3J5cHRpbmcgdGhlIHNlY3Rpb25zIGNvbnRhaW5pbmcgdGhlIGFjdHVhbCBk
YXRhLg0KPiA+ID4gVGhpcw0KPiA+ID4gcmVzdWx0cw0KPiA+ID4gaW4gYSBkcmFzdGljIGluY3Jl
YXNlIG9mIHRpbWUgKGFwcHJveCAyMHggb24gb3VyIHN5c3RlbXMgKSBuZWVkZWQNCj4gPiA+IGZv
cg0KPiA+ID4gcmVlbmNyeXB0aW9uIQ0KPiA+ID4gDQo+ID4gPiBTaW5jZSByZWxldmFudCBkaXNr
IGNvbnRlbnRzIGFyZSBvbmx5IGF2YWlsYWJsZSBpbiB0aGUgc2VjdGlvbnMNCj4gPiA+IG9mDQo+
ID4gPiB0aGUgZGlzaw0KPiA+ID4gYXZhaWxhYmxlIGJlZm9yZSB0aGUgZXhwYW5zaW9uLCBpdCBp
cyBzdWZmaWNpZW50IHRvIHJlZW5jcnlwdA0KPiA+ID4gdGhlbQ0KPiA+ID4gb25seS4NCj4gPiA+
IA0KPiA+ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIG9yZGVyIG9mIGVuY3J5cHRpb24gYW5kIGRpc2sg
ZXhwYW5zaW9uDQo+ID4gPiByZXN1bHRpbmcNCj4gPiA+IGluDQo+ID4gPiBmYXN0ZXIgZW5jcnlw
dGlvbiAoc2luY2Ugb25seSB0aGUgbmVjZXNzYXJ5IHBhcnRzIGFyZSBlbmNyeXB0ZWQpLg0KPiA+
ID4gVGhlIHJlc2l6ZSBvcGVyYXRpb24gZG9lcyBub3QgcmVlbmNyeXB0IHRoZSBhZGRlZCBkaXNr
IHBhcnRzIGJ1dA0KPiA+ID4ganVzdA0KPiA+ID4gZXh0ZW5kcyB0aGUgTFVLUyBjb250YWluZXIg
KGNyeXB0c2V0dXAgcmVzaXplKSB0byByZWZsZWN0IHRoZQ0KPiA+ID4gbWF4aW11bQ0KPiA+ID4g
YXZhaWxhYmxlIGRpc2sgc3BhY2UuDQo+ID4gDQo+ID4gVGhlIHRoaW5nIEkgYW0gbm90IHN1cmUg
YWJvdXQgdGhpcyBwYXRjaCBpcywgaWYgZXhlY3V0aW5nIHRoZSBkaXNrDQo+ID4gZXhwYW5zaW9u
IGhlcmUgaXMgcmVhbGx5IHRoZSB3YXkgdG8gZ28sIG9yIGlmIHdlIHNoYWxsIGp1c3QgcmV1c2UN
Cj4gPiB0aGUNCj4gPiBleHBhbmQtb24tZmlyc3QtYm9vdCBmcm9tIGlzYXIgKGluY2wuIGZpeGVz
IHByb3Bvc2VkIGVhcmxpZXIgLQ0KPiA+IFsxXSk/DQo+ID4gDQo+IA0KPiBJZiB5b3UgZmluZCBh
IGdvb2Qgd2F5IHRvIGZhY3RvciBvdXQgdGhlIGNvbW1vbiBjb2RlIGFuIHJldXNlIHRoYXQNCj4g
aW5zaWRlIHRoZSBpbml0cmFtZnMsIEknbSBvcGVuIGZvciBwYXRjaGVzLiBIb3dldmVyLCBhcyB3
ZSBkaXNjdXNzZWQNCj4gb24NCj4gdGhlIGlzYXIgbGlzdCBhcyB3ZWxsLCB1c2luZyB0aGUgc3lz
dGVtZCBzZXJ2aWNlIGxhdGVyIG9uIHdpbGwgbm8NCj4gbG9uZ2VyDQo+IHdvcmsgb25jZSB3ZSBw
cm9wZXJseSBoaWRlIHRoZSBrZXlzIHdoZW4gaW5pdHJhbWZzIGVuZHMuDQo+IA0KDQpUcnVlIQ0K
DQpSZWZhY3RvcmluZyB0aGF0IHBhcnQgb3V0LCBwcm9iYWJseSBpbnRyb2R1Y2VzIG1vcmUgYm9p
bGVycGxhdGUsIHRoYW4NCnRoZSBhY3R1YWwgcmVmYWN0b3Jpbmcgd2lsbCBzYXZlLiBBbnlob3cs
IG9uY2UgdGhlIG5ldyBzZWFsaW5nIGlzIGluDQpwbGFjZSB0aGUgc3lzdGVtZCBzZXJ2aWNlIHN1
cHBvcnQgZm9yIGNyeXB0IGhhcyB0byBiZQ0KcmVjb25zaWRlcmVkL2Ryb3BwZWQgYW55d2F5cy4N
CldpbGwga2VlcCBpdCBhcyBwcm9wb3NlZCBpbiB0aGUgcGF0Y2guDQoNCkJSIEFsZXhhbmRlcg0K
DQo+IEphbg0KPiANCg0K

