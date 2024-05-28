Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B32C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 18:23:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.29787.1716920584279258263
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 11:23:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 44SIN0f91280955; Wed, 29 May 2024 03:23:01 +0900
X-Iguazu-Qid: 2rWhclmqRqK3hy1Ce8
X-Iguazu-QSIG: v=2; s=0; t=1716920580; q=2rWhclmqRqK3hy1Ce8; m=FAzLaspj6uNSPvOSnrTbjCk4VulJRoAMfnL3wEVniIA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 44SIMwhU3867867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 29 May 2024 03:22:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz0nWeUofH+Y7kSj3L436lHW8CXA6m/Fzm+mBRM3XQ6XQ02QOR72JKG5NQ7AV8FdUBJbc5QzSWtIFNmv8ji2T3Cf1fTpAdFZ7tbyQSNBgfLT9tWghCHkLU79xytrT3KxDwPRHDYOqJVDn/ppycapmxjAVquKrb9Cd+qAVR45Y4V2bAnNLVvhql0pz0YGcXUG/6wupZx8T2ao8bFbJlGded8wd6vQDH/HDvBMljvUp+E7OuXaq2M2oE0lcOAeyV06sL+yyH1GYUzAVpwLP2IjQx+g8lOYaMKBFM6arnF/C+GCfAc5qt1N78q5TYmxTFcV+CIevbLuQ2KFgKDBE9UwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VHxhnK3Cqa5MVgQUB5OEzaWGgPtR8lBmdRORg4yc28=;
 b=Cf1JMWzQ1bX0l7SuT+BlwwpjrK4gCUF5Yl+nXjEjuyibqQRBNrds5XUnAxClFg/JeTJE5F70/o1MDpowFhm4kFzSJLBtNtUpIyQDQQmy0MJcibSP0noxQpnOAJseH6Nz8gPIewrOfbRGVJLt2l7TobKUcg3Vc8HUzWT81r3Um627GrDTOtxUYw3wfgDV9CrDZykAJS3twu3a1001WOqDjHQBxk3mrza4SeVLIrUrxXmQ2KNDe+l40damrjA6RTFUEkOFg1HlCbxQLDL7yhta91u5ck2wAskUrkPhO3s8T0KB8keGKaIAsuYenIf8P3yJmW608oluKDIqkCjcBypi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: 
 AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAIHQ4ABsGuiAACP4ZqAA3sUFkA==
Date: Tue, 28 May 2024 18:22:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103AF590A9C795BD550C65BC2F12@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610353B51E2D66C802A5104DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB9539:EE_
x-ms-office365-filtering-correlation-id: c519188c-eed9-4e50-111c-08dc7f433179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TG1Ga1JndjVlaHh0S3R4U2ZzdUJVT0JKd2lmdW45ejlqTDRYUFdZQzZS?=
 =?iso-2022-jp?B?YXNFNTJ1bmltWllDSGYzLzQzR28vUUlYZlVYdkZsbkNqSnRRUXo5Tnhk?=
 =?iso-2022-jp?B?cnBsd2E4MXEzUUl4SE5hYW92N0h6dit0UG9KZzJvYnNYVFlXVXRGRHlO?=
 =?iso-2022-jp?B?elZCbUZQWU5sNzJlYXM4N2R2Wnh3OEIrUGNZaUtOMitoSTFmSlI0OXlC?=
 =?iso-2022-jp?B?T2F5S2pVL1BiYzhrMHVWelVqNGVycTExYWxrQVlJTEQvNWs0N0thUzdt?=
 =?iso-2022-jp?B?dFZlVlVMclp6VDRpRFU0RFlrWHU3QjBtYnFpdUxDOWNpcHJSYWEwWVJj?=
 =?iso-2022-jp?B?amFSWnZIT29kWU5sYnVrMDlFNFBQY2dBTXhoWExSNzhpcnRoS2FKeUd6?=
 =?iso-2022-jp?B?aGJSS3RKU3BqVzI2V2U4Y1hwdHozV0pGM2dJcDVXemhId2FwM1RMZEVR?=
 =?iso-2022-jp?B?U0RtdVVXaThIY09FL0RMTTRUZVZSVjhOWFZ1bytIcFBEMkhwdjlicmov?=
 =?iso-2022-jp?B?R0g3R3IzQnB6cVZOV1dsd3N6aXZTN1llclpid2JQV0VPTVVhZnFxR3BM?=
 =?iso-2022-jp?B?VE5PUVRHa3FZeVE4N0VuS09BN0FwanVQNU13cmpvMStWeWtEQXJScWVW?=
 =?iso-2022-jp?B?cEpFK2hoS1NTT2U4SEpRUE9oOUV3ZXJaMkRqSEdEYkIvWi9xMFFsMmZl?=
 =?iso-2022-jp?B?ZExabXdmekN5YnVOTDB6aWxFSytXNG5hVVcyY0F4TytEVVg2dlpiaW1u?=
 =?iso-2022-jp?B?TkdhMThFOVRSQ203U2x1SEFLWmJacEcxMHVRR3ZhcVRDVVlwdWxOek5Y?=
 =?iso-2022-jp?B?OWNFaDVKKzZXb0pNS0p2U2FRTkhpTk1pd2czc2Q1VUM5N204dXFzamVv?=
 =?iso-2022-jp?B?bkZ1Z1lLTlhVMC9yZC9OWU1SVVRHYmJvZU5wRmRWSWtlUXo3RnBUWVJM?=
 =?iso-2022-jp?B?bHVqNmNKTDdaeGJqL25hUDBnaitqdktTemduaXppWE1lYjRaZXM1dWR6?=
 =?iso-2022-jp?B?OVBLa2FUblRNSmd4WjhOYmlCQ3diRHBLWGd2Q2hsVnhxZ0xVRmZwUno5?=
 =?iso-2022-jp?B?dnk2aERlSGE3dzgzTGY1ZlZRMkR4WHJhd1E4VXVNTzI5QkorelVGdHVR?=
 =?iso-2022-jp?B?RjRycGxPYlpqUzZ1dVU0ZVN0dXowTVB0blhFb1FaeUZMTmNnSDRrblFB?=
 =?iso-2022-jp?B?alZZUG9kSDhmcWpUdEgzU091MCtmVURDN0ttbFo4MTcwSDNYcDB2blV6?=
 =?iso-2022-jp?B?aTBRaGhjUEZ1Uzg5azBqd2c0UUZneWhGc1J6bHNYK0ZFYS8xc3JNOVdE?=
 =?iso-2022-jp?B?US9pdzZFWTAvR2l2THRyUk8yUi81R0piVFl0bTZyYTNxVzdzOWlOUW1r?=
 =?iso-2022-jp?B?L09sQkhsYUd5a1p4VmtTVFQ1Nk5rVEROc290V0xDU1VqalRrTGlCeEZE?=
 =?iso-2022-jp?B?R2tHU2VHczUwK2NSVElTckZvWEdQNkpEVkV3bEtwdW13TFN5RVl2eTNR?=
 =?iso-2022-jp?B?Z1RpMVJScGprZCt4dEFPaEFJVEh0RHRKVlNQZkNFcTBiTXZhUUJFQW11?=
 =?iso-2022-jp?B?V0txQmVpSTI5TnNleFhlOHVFcUwycTNobk9uOUplbTRYS001aDlVU3dR?=
 =?iso-2022-jp?B?Q0tIS2lGdE4vVCtXREdnVWlUVUJNaDdVUFFSdDBWU0hPQUE4blhIZXdJ?=
 =?iso-2022-jp?B?VUJ0NWVISWg2OFB3dHdhM3ppU2tWbHNXL1RHKy9OSXlTL3RjSlkwb1Nq?=
 =?iso-2022-jp?B?UWhBMUtPUUlpWkdnL2dGZy9ycCtlTUc4NzFLTWxDa2twNWZpWkxPeFo0?=
 =?iso-2022-jp?B?a21tRkRYVHMycEpKUDNNWEFnRHBGbzRESlhJRWZ0Z21RaXY0ejhaWmFy?=
 =?iso-2022-jp?B?NWgydHdHVE1aNzkvTTRLd1JRTi80PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bkFkSkVJNkVycWhaN0RUMEZuQnQ0Ykh0V2VIdEl3TlFtMFlrWFdYc1Qz?=
 =?iso-2022-jp?B?UEo2TjJ4QUlWTWhXaG5OQ3llZ3Z1WVpCZENkQVc1ZEVEaFlhemsrUDRM?=
 =?iso-2022-jp?B?dTUyM0ZKejNGNjBraVpJU1p5aVg5UmxTckhaRHJMN2QvZ2FvbkVPN2RW?=
 =?iso-2022-jp?B?MFlvTUxvOTEwVnJHa1B0eGJ2dmc0VVJ3bUFDUFUxYW10amhrTWFkN2NL?=
 =?iso-2022-jp?B?WCtJbktOdnJmWW82c1NlbitaNElERFZaamZPMGJZV2lIQTBOYXJaSmtk?=
 =?iso-2022-jp?B?anJQNlFJdGF5QVNiU3dJNUxyT1M0WHN6WmtwcU1YbzhWK2pvQ2RHd2JY?=
 =?iso-2022-jp?B?YmF3UWZxUjIrbkYxeEMwSTQxRUx5T3FVSndodDBjb0hpUXRQM3VtYjlF?=
 =?iso-2022-jp?B?Ri9kRG5XWVVPOE95dnBJb2krQnM0RUpyMEdKM2tlMkFUUVNDUWtvRXpa?=
 =?iso-2022-jp?B?TmZ5Z1VMVmJnMUlTNnlYenVjUjVyL0NFT3hvZnF5eFpOMk9ZMzkvTUpw?=
 =?iso-2022-jp?B?OW5nSkJMVGN1SkFvbVo2VXYvZFNDOUY5L3Y5ZXlDQU1wL05CWnhOeGtT?=
 =?iso-2022-jp?B?clJ5dkRQMXpxN3Q3RGM3bmk5MlYreS9HSE8zU1BnaEJCTHBuTTRweHdB?=
 =?iso-2022-jp?B?TWUyZW5UM3BkMkFxaTE3L1YvakpNa2p1cGJTZnRBa2ZCU0hvZlk0TERM?=
 =?iso-2022-jp?B?d3dVbk5uSUN1ZU1JY2ZNaU9ZVGpZZ2cyYk1NK0p1QU1ISVdBNHhES0Vv?=
 =?iso-2022-jp?B?em5iUE83Qm1Wd0xpSE5XTHJBRkFyZWZ3U2JKRllETjFobGxjcnEza0Fi?=
 =?iso-2022-jp?B?U0JtYW53RnZtemVrYTlXcW11aUkxTHJ2YVBWeFhoc2d2em9ML1FPTi9s?=
 =?iso-2022-jp?B?ZDk4M3JYWVhyZFN6Y3JvVGZ1eCtWcklDWENkNi9GY1lCMjYrMS9ZeXdN?=
 =?iso-2022-jp?B?a0VPNS85KzVhQlRzenRHZ3NkOEFhWERyc0U3aDZuWWdoRUJWNHJIQnNp?=
 =?iso-2022-jp?B?RVl1aGVPNzlrZXEvaU15R0ZNRVMvaUJ2d0NtOTREWm5kOFZ4UHNWWTVD?=
 =?iso-2022-jp?B?clptVDdxcVhodWd1OFBJQmovakJwdStKOFV2ZTNPT2Q3Zmxuckp2bVJ4?=
 =?iso-2022-jp?B?Q20yVGR3UGgzcnJQTzNtNnJ0YlBwbENSMzE2ZkExa0lKaWJMRGQzY3M2?=
 =?iso-2022-jp?B?NXJacUUvOTMvM3l2c2FITjYyczY5WHN1OHV0ZThwOFJwRGpXQ3kxd28y?=
 =?iso-2022-jp?B?bGlURCtXUnV2RlRxNks2OURreHp4Sk5rdWZSUHBYT0Q3UUMweDQ2NzZS?=
 =?iso-2022-jp?B?eldpS2NhRzM0Z0h3NkFzOGozeXB2TWJPYkZWNkM1UjFFWHFDVWpFK1BZ?=
 =?iso-2022-jp?B?U1U5WC9qeklJa2hvbDMvWHh3a1FNNlEyaVBoRVZvMjVRYmhCOTM2aWJm?=
 =?iso-2022-jp?B?eE1Ka3VBR3dQTEkvQUwwM0xhSUxISDhrU09xbGkzU0FpaVBMbnNxV3Aw?=
 =?iso-2022-jp?B?NW04NDJmcFVQcWMwUXh0Q2ZDSTY1MUFlMTBEWVRHSWwvV1lyNHgrbVJu?=
 =?iso-2022-jp?B?R0pGOG5OcjdsTlpueUVyOVJLWHZYeC9xSGIraktsZGxXRUJyL3FYZHBi?=
 =?iso-2022-jp?B?Q1FjOVlZYUtlUFNYMWNUUVcyOHZBWHRnTU9Yems3Yk9wMSs3Q0tNKzc5?=
 =?iso-2022-jp?B?SzFEOXA3MzFmYnNBSFpYb3RESGJiekxZWUZXR1RTdEJlRFFwSjBIdW14?=
 =?iso-2022-jp?B?QUZyZDZlSkFvRUxwV1RNZkM5azV6MUFLd2h1VkFqUEJvbXc5RjE1U0kv?=
 =?iso-2022-jp?B?UEZtLzRpLy9qWUJjSWE1VFRkYmNQUkgxNElRUjRqV0hLdGhNNWlvdlNu?=
 =?iso-2022-jp?B?ZmZ6SjFxdy83RFBJdjNPTUVDWmw1bWFlOWhSK0lQTEc1WVZZME45S3l5?=
 =?iso-2022-jp?B?a0tBbUtwOGtYdkxONkhIdXlqa21RR3ZEeDBsSFg2TFNSejRRM0h2RnVy?=
 =?iso-2022-jp?B?cW45ZHNKYUpkamVtRURlL1FpQWpuRFZqUWpyeEtaYkhXeGk3SmhUdTJO?=
 =?iso-2022-jp?B?OW54RHpzOTVBNjhWa1ltZ1Bab01FTlVOSHBJQXJvSW41TG81RXhINm91?=
 =?iso-2022-jp?B?cE1KUUxHKzR3dkRSWlRNeHJNZk03OG5YejVUTUp6SXBHWjVKcSs1YndG?=
 =?iso-2022-jp?B?OG0yeVh1elpxcE4vRG1uZEZnTFU2bWtEcCtEUUVvVG1pWmpEaWtuZnJx?=
 =?iso-2022-jp?B?ZFNQZCtzRGdIaXdLR3BxNjZUbk01elBYMGlpSEZObzhqQ1VLZGVOeWUx?=
 =?iso-2022-jp?B?RmNPUFhGcDVaNDZZbnJZTUZvUDRCbWY2SE9RWXk2c0wrRTd4bTRtbHpk?=
 =?iso-2022-jp?B?OHErSk5QcHNoWnFMTDBOd3czVjRJenJEdHp1dCt2N1Z5ZDNKUiswYVdy?=
 =?iso-2022-jp?B?UXFNeFFnPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103AF590A9C795BD550C65BC2F12OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c519188c-eed9-4e50-111c-08dc7f433179
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 18:22:54.8796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ml0F0ytkQIlRdJQWKAs4K4YpZihWcmFyIgmMFVMoPfUFdmbJJ+fXZvNRY6fpjq5w7/n3odLFwTYYFJ1jVi8V1tIcaJdy33Xe/eAhNZBDOoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9539
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 18:23:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15974

--_000_OS3PR01MB6103AF590A9C795BD550C65BC2F12OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Today while I was testing isar-cip-core LAVA job trigger pipeline, I notice=
d that the one and only device (qemu-renesas-01) which has custom device di=
ctionary changes to use swtpm related scripts to boot CIP security image ar=
e gone. LAVA | Scheduler | Devices | qemu-renesas-01 | dictionary (ciplatfo=
rm.org)<https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/device=
dict> . Because of this none of the QEMU devices present will be able to te=
st Swupdate, secure boot and IEC layer.

Chris, I am about to send patches to isar-cip-core to trigger LAVA jobs. Fo=
r every pipeline it must run 11 jobs on CIP LAVA QEMU devices. So, I reques=
t you to please update device dictionaries of only one QEMU device in each =
lab so that we can have 3 to 4 QEMU devices able to run CIP Core jobs and t=
his also makes test stage runs faster in isar-cip-core pipelines.

I have already created an MR https://gitlab.com/cip-project/cip-testing/lav=
a-docker/-/merge_requests/35 to include required scripts in all CIP LAVA wo=
rkers. I mentioned the reason why we need to manually update the dictionari=
es instead of updating the dictionaries of all the available QEMU devices h=
ere https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests=
/35#note_1921132805 . Please have a look at this.

I request you to consider this as high priority because we are working to e=
nable this LAVA job triggers from isar-cip-core as soon as possible. We wil=
l not be able to test if none of the QEMU devices are able to run any of th=
e CIP Core jobs.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Friday, May 24, 2024 1:15 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org
Subject: RE: Request for updating device dictionaries


Hi Chris,

I updated the corresponding MR lava-slave/scripts: Add scripts needed to ru=
n for booting CIP QEMU security target (!35) * Merge requests * cip-project=
 / cip-testing / lava-docker * GitLab<https://gitlab.com/cip-project/cip-te=
sting/lava-docker/-/merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c=
62c4c5d4fd504b3>

This MR only adds the scripts in the workers. Updating device dictionaries =
on only one QEMU device in each worker has to be done manually.

If you have further review comments, please provide them in the MR.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)
From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Thursday, May 23, 2024 8:04 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=
=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <=
kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; j=
an.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Subject: RE: Request for updating device dictionaries

Hello Sai,

I can update the device dictionaries, however each lab would need to update=
 it=1B$B!G=1B(Bs worker docker image to include the swtpm*.sh scripts.
Before we do this, we should really finish and merge the corresponding MR: =
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35/
Please could you check the remaining threads?
Once merged I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I o=
nly have access to my own worker).

I=1B$B!G=1B(Bll remove the swtpm-jobs tags I added the other day, so at lea=
st your pipelines don=1B$B!G=1B(Bt fail - they=1B$B!G=1B(Bll just run slowe=
r.

Thanks, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Tuesday, May 21, 2024 12:05 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; jan.=
kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Subject: RE: Request for updating device dictionaries

Hi Chris,

Thank you so much for adding the tags to one qemu for each worker. But the =
device dictionaries for these tagged devices need to be updated with the be=
low snippet. Without these changes we cannot boot the security image in LAV=
A.

{% set user_commands =3D {'start_tpm': {'do':'"/usr/bin/sh /usr/local/bin/s=
wtpm_start.sh"',

                                      'undo':'"/usr/bin/sh /usr/local/bin/s=
wtpm_finish.sh"' },

                        'manual_kill': {'do':'"/usr/bin/pkill -15 swtpm"'}}=
 %}

Just like it is updated for this device LAVA | Scheduler | Devices | qemu-r=
enesas-01 | dictionary (ciplatform.org)<https://lava.ciplatform.org/schedul=
er/device/qemu-renesas-01/devicedict> .

Can you kindly update the device dictionaries for the below =1B$B!H=1B(Bswt=
pm-jobs=1B$B!I=1B(B tagged devices ?


  *   https://lava.ciplatform.org/scheduler/device/qemu-03
  *   https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
  *   https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01

I will contact the maintainers of isar-cip-core project regarding CI/CD var=
iables.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Tuesday, May 21, 2024 4:24 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=
=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <=
kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; j=
an.kiszka@siemens.com<mailto:jan.kiszka@siemens.com>
Subject: RE: Request for updating device dictionaries

Hello Sai,

You need to talk to the maintainers of the isar-cip-core project to get CI/=
CD variables set there. It=1B$B!G=1B(Bs not my project so I shouldn=1B$B!G=
=1B(Bt make such changes.

I=1B$B!G=1B(Bve added the swtpm-jobs tag to one qemu from each worker. Chec=
k the =1B$B!H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page: https://=
lava.ciplatform.org/scheduler/device_type/qemu

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Monday, May 20, 2024 11:23 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; di=
nesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; kazuhiro=
3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries

Hello Chris,

Any updates on 2nd and 3rd requests I made in the below mail ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Wednesday, May 15, 2024 4:41 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; di=
nesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip=
.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=1B(B =
=1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhi=
ro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>
Subject: Request for updating device dictionaries

Hello Chris,

Hope you are doing well.

Sorry to disturb you with these extra things I need on CIP LAVA Lab. Let me=
 consolidate my requests in this mail.

I am preparing a patch to trigger LAVA job definitions from isar-cip-core. =
Currently I am working on that in a custom branch. Before sending that patc=
h, I have created an MR to update the cip-core-ci repository which is requi=
red to run the test jobs in isar-cip-core. I will assign it for your review=
 soon.

I will be able to send the patch to add test jobs in isar-cip-core once the=
 below mentioned things are done.

  1.  This MR needs to merge build-bookworm.Dockerfile: Include lava.sh and=
 templates in the docker image. (!3) * Merge requests * cip-playground / ci=
p-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/merge_re=
quests/3> which I shall assign to you soon after some internal review.
  2.  I need some variables in isar-cip-core CI/CD setting section like LAV=
A_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privilege =
to do that. I will mail them to you personally. Please hide them in isar-ci=
p-core Gitlab CI/CD section so that I can use them while running lava.sh sc=
ript.
  3.  Since we need to run these LAVA jobs when pipelines are triggered in =
isar-cip-core, I am making changes in such a way that pipeline keeps runnin=
g until all the jobs are done and we report the health as a result. It will=
 take around 120 mins to run all the jobs. We have only device (qemu-renesa=
-01) under lab-cip-renesas. So, I request you to please add the swtpm devic=
e dictionary changes and swtpm-jobs tag to only one QEMU device in every LA=
VA lab you can access. By this will be able to reduce the pipeline run-time=
 due to simultaneous runs.

It will be very helpful if you provide your support with the above-mentione=
d items.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103AF590A9C795BD550C65BC2F12OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:166672004;
	mso-list-template-ids:601633490;}
@list l1
	{mso-list-id:512649885;
	mso-list-type:hybrid;
	mso-list-template-ids:-1842836820 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1959749534;
	mso-list-type:hybrid;
	mso-list-template-ids:-1796337264 67698703 -1 -1 -1 -1 -1 -1 -1 -1;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:5.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1988700606;
	mso-list-template-ids:744243384;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Today whi=
le I was testing isar-cip-core LAVA job trigger pipeline, I noticed that th=
e one and only device (qemu-renesas-01) which has custom device dictionary =
changes to use swtpm related scripts
 to boot CIP security image are gone. </span><a href=3D"https://lava.ciplat=
form.org/scheduler/device/qemu-renesas-01/devicedict">LAVA | Scheduler | De=
vices | qemu-renesas-01 | dictionary (ciplatform.org)</a> . Because of this=
 none of the QEMU devices present
 will be able to test Swupdate, secure boot and IEC layer.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Chris, I am about to send patches to isar-cip-core t=
o trigger LAVA jobs. For every pipeline it must run 11 jobs on CIP LAVA QEM=
U devices. So, I request you to please update device dictionaries of only o=
ne QEMU device in each lab so that
 we can have 3 to 4 QEMU devices able to run CIP Core jobs and this also ma=
kes test stage runs faster in isar-cip-core pipelines.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have already created an MR <a href=3D"https://gitl=
ab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35<=
/a> to include required scripts in all CIP LAVA workers. I mentioned the re=
ason why we need to manually update the dictionaries instead of updating th=
e dictionaries of all the available
 QEMU devices here <a href=3D"https://gitlab.com/cip-project/cip-testing/la=
va-docker/-/merge_requests/35#note_1921132805">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/35#=
note_1921132805</a> . Please have a look at this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I request you to consider this as high priority beca=
use we are working to enable this LAVA job triggers from isar-cip-core as s=
oon as possible. We will not be able to test if none of the QEMU devices ar=
e able to run any of the CIP Core
 jobs.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<span style=3D"mso-fa=
reast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Friday, May 24, 2024 1:15 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I updated=
 the corresponding MR
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/=
merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c62c4c5d4fd504b3">lav=
a-slave/scripts: Add scripts needed to run for booting CIP QEMU security ta=
rget (!35) &middot; Merge requests &middot; cip-project
 / cip-testing / lava-docker &middot; GitLab</a> <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This MR only adds the scripts in the workers. Updati=
ng device dictionaries on only one QEMU device in each worker has to be don=
e manually.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If you have further review comments, please provide =
them in the MR.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<span style=3D"mso-fa=
reast-language:EN-US"><o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">From:</span></b><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:ZH-TW"> Chris Paterson &lt;</span><a href=3D"mailto:Chr=
is.Paterson2@renesas.com"><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">Chris.Paterson2@ren=
esas.com</span></a><span style=3D"font-family:&quot;Calibri&quot;,sans-seri=
f;mso-ligatures:none;mso-fareast-language:ZH-TW">&gt;
<br>
<b>Sent:</b> Thursday, May 23, 2024 8:04 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-TW" style=3D"font-family:&qu=
ot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$=
B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:ZH-TW">) &lt;</span><a href=3D"=
mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"font-family:&quot;Cal=
ibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">Sai.Sa=
thujoda@toshiba-tsip.com</span></a><span style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-TW" style=3D"font-family:&q=
uot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:ZH-TW"> TMIEC ODG Porting)
 &lt;</span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span style=3D=
"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-=
language:ZH-TW">dinesh.kumar@toshiba-tsip.com</span></a><span style=3D"font=
-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-langu=
age:ZH-TW">&gt;;
 hayashi kazuhiro(</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PM=
ingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$BNS=
=1B(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;Calibri&quot;,s=
ans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$BOB9(=1B(B</span><span =
lang=3D"ZH-TW" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none;mso-fareast-language:ZH-TW">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B#D#M#E=1B(B</span><spa=
n lang=3D"ZH-TW" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-li=
gatures:none;mso-fareast-language:ZH-TW">
</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:ZH-TW">=1B$B!{=1B(B</span><span lang=3D"ZH-TW=
" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fa=
reast-language:ZH-TW">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=
=1B$B""=1B(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU=
&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B#M#P#S=1B(=
B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligat=
ures:none;mso-fareast-language:ZH-TW">=1B$B!{=1B(B</span><span lang=3D"ZH-T=
W" style=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-f=
areast-language:ZH-TW">=1B$B#M#P#4=1B(B</span><span style=3D"font-family:&q=
uot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW"=
>)
 &lt;</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:ZH-TW">kazuhiro3.hayashi@toshiba.co.jp</span></a><span style=3D=
"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-=
language:ZH-TW">&gt;;
</span><a href=3D"mailto:jan.kiszka@siemens.com"><span style=3D"font-family=
:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-=
TW">jan.kiszka@siemens.com</span></a><span style=3D"font-family:&quot;Calib=
ri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW"><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I can update=
 the device dictionaries, however each lab would need to update it=1B$B!G=
=1B(Bs worker docker image to include the swtpm*.sh scripts.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Before we do=
 this, we should really finish and merge the corresponding MR:
</span><a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/=
merge_requests/35/"><span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-fareast-language:EN-US">https://gitlab.com/cip-projec=
t/cip-testing/lava-docker/-/merge_requests/35/</span></a><span lang=3D"EN-G=
B" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0;mso-fa=
reast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Please could=
 you check the remaining threads?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Once merged =
I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I only have acc=
ess to my own worker).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bll remove the swtpm-jobs tags I added the other day, so at least your pipe=
lines don=1B$B!G=1B(Bt fail &#8211; they=1B$B!G=1B(Bll just run slower.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Thanks, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lang=
uage:KO">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO=
">
 &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:KO">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lang=
uage:KO">&gt;
<br>
<b>Sent:</b> Tuesday, May 21, 2024 12:05 PM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none;mso-fareast-language:KO">Chris.Paterson2@renesas.com</span></a><=
span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
;mso-fareast-language:KO">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span st=
yle=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fa=
reast-language:KO">dinesh.kumar@toshiba-tsip.com</span></a><span style=3D"f=
ont-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-la=
nguage:KO">;
</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lan=
guage:KO">kazuhiro3.hayashi@toshiba.co.jp</span></a><span style=3D"font-fam=
ily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:=
KO">;
</span><a href=3D"mailto:jan.kiszka@siemens.com"><span style=3D"font-family=
:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"=
>jan.kiszka@siemens.com</span></a><span style=3D"font-family:&quot;Calibri&=
quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thank you=
 so much for adding the tags to one qemu for each worker. But the device di=
ctionaries for these tagged devices need to be updated with the below snipp=
et. Without these changes we cannot
 boot the security image in LAVA.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">{% set user_comma=
nds =3D {'start_tpm': {'do':'&quot;/usr/bin/sh /usr/local/bin/swtpm_start.s=
h&quot;',</span><span style=3D"font-size:10.5pt;font-family:&quot;Helvetica=
&quot;,sans-serif;color:#333333;mso-ligatures:none;mso-fareast-language:EN-=
US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'undo':'&quot;/usr/=
bin/sh /usr/local/bin/swtpm_finish.sh&quot;' },</span><span style=3D"font-s=
ize:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;color:#333333"><o:p>&nb=
sp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333">&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'manual_kill': {'do':'&quot;=
/usr/bin/pkill -15 swtpm&quot;'}} %}<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.5pt;font-family:&quot;Courier New&quot;;color:#333333"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#333=
333">Just like it is updated for this device
</span><span style=3D"color:black"><a href=3D"https://lava.ciplatform.org/s=
cheduler/device/qemu-renesas-01/devicedict">LAVA | Scheduler | Devices | qe=
mu-renesas-01 | dictionary (ciplatform.org)</a> .
</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Can you kindly update the device dictionaries for the below =1B$B!H=1B(B=
swtpm-jobs=1B$B!I=1B(B tagged devices ?</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3;background:white">
<a href=3D"https://lava.ciplatform.org/scheduler/device/qemu-03">https://la=
va.ciplatform.org/scheduler/device/qemu-03</a><o:p></o:p></li><li class=3D"=
MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 lfo3;backgrou=
nd:white">
<a href=3D"https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-mu=
c">https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc</a><o:=
p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-li=
st:l1 level1 lfo3;background:white">
<a href=3D"https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01">=
https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01</a><o:p></o:=
p></li></ul>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">I will contact the maintainers of isar-cip-core project regarding CI/CD =
variables.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Thanks and regards,</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Sai Ashrith Sathujoda (T S I P)</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#333=
333"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO"> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Pat=
erson2@renesas.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if;mso-ligatures:none;mso-fareast-language:KO">Chris.Paterson2@renesas.com<=
/span></a><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-lig=
atures:none;mso-fareast-language:KO">&gt;
<br>
<b>Sent:</b> Tuesday, May 21, 2024 4:24 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"KO" style=3D"font-family:&quot;=
Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T#=
S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">) &lt;</span><a href=3D"mailto:=
Sai.Sathujoda@toshiba-tsip.com"><span style=3D"font-family:&quot;Calibri&qu=
ot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">Sai.Sathujoda@to=
shiba-tsip.com</span></a><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif;mso-ligatures:none;mso-fareast-language:KO">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"KO" style=3D"font-family:&quot=
;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B#T=
#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif=
;mso-ligatures:none;mso-fareast-language:KO"> TMIEC ODG Porting) &lt;</span=
><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO=
">dinesh.kumar@toshiba-tsip.com</span></a><span style=3D"font-family:&quot;=
Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">&gt;;
 hayashi kazuhiro(</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim=
&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$BNS=1B(B<=
/span><span lang=3D"KO" style=3D"font-family:&quot;Calibri&quot;,sans-serif=
;mso-ligatures:none;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$BOB9(=1B(B</span><span lang=
=3D"KO" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:n=
one;mso-fareast-language:KO">
</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:KO">=1B$B#D#M#E=1B(B</span><span la=
ng=3D"KO" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures=
:none;mso-fareast-language:KO">
</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:KO">=1B$B!{=1B(B</span><span lang=3D"KO" styl=
e=3D"font-family:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareas=
t-language:KO">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=1B$B""=1B=
(B</span><span lang=3D"KO" style=3D"font-family:&quot;Gulim&quot;,sans-seri=
f;mso-ligatures:none;mso-fareast-language:KO">=1B$B#M#P#S=1B(B</span><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">=1B$B!{=1B(B</span><span lang=3D"KO" style=3D"font-fam=
ily:&quot;Gulim&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO=
">=1B$B#M#P#4=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif;mso-ligatures:none;mso-fareast-language:KO">)
 &lt;</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:KO">kazuhiro3.hayashi@toshiba.co.jp</span></a><span style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lan=
guage:KO">&gt;;
</span><a href=3D"mailto:jan.kiszka@siemens.com"><span style=3D"font-family=
:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"=
>jan.kiszka@siemens.com</span></a><span style=3D"font-family:&quot;Calibri&=
quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO"><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">You need to =
talk to the maintainers of the isar-cip-core project to get CI/CD variables=
 set there. It=1B$B!G=1B(Bs not my project so I shouldn=1B$B!G=1B(Bt make
 such changes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=1B(=
Bve added the swtpm-jobs tag to one qemu from each worker. Check the =1B$B!=
H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page:
</span><a href=3D"https://lava.ciplatform.org/scheduler/device_type/qemu"><=
span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso=
-fareast-language:EN-US">https://lava.ciplatform.org/scheduler/device_type/=
qemu</span></a><span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot=
;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;<=
/o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none;mso-fareast-language:KO">From:</span></b><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:KO">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lang=
uage:KO">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO=
">
 &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:KO">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lang=
uage:KO">&gt;
<br>
<b>Sent:</b> Monday, May 20, 2024 11:23 AM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none;mso-fareast-language:KO">Chris.Paterson2@renesas.com</span></a><=
span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
;mso-fareast-language:KO">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:cip-dev@lists.cip-project.org"><span st=
yle=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fa=
reast-language:KO">cip-dev@lists.cip-project.org</span></a><span style=3D"f=
ont-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-la=
nguage:KO">;
</span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span style=3D"font=
-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-langu=
age:KO">dinesh.kumar@toshiba-tsip.com</span></a><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">=
;
</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-lan=
guage:KO">kazuhiro3.hayashi@toshiba.co.jp</span></a><span style=3D"font-fam=
ily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:=
KO"><br>
<b>Subject:</b> RE: Request for updating device dictionaries<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Any updat=
es on 2<sup>nd</sup> and 3<sup>rd</sup> requests I made in the below mail ?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, May 15, 2024 4:41 PM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-liga=
tures:none">Chris.Paterson2@renesas.com</span></a><span style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:cip-dev@lists.cip-project.org"><span st=
yle=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">cip-d=
ev@lists.cip-project.org</span></a><span style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-ligatures:none">; dinesh kumar(</span><span lang=3D"J=
A" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:non=
e">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;mso-ligatures:none">
 TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.=
com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligature=
s:none">dinesh.kumar@toshiba-tsip.com</span></a><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none">&gt;; hayashi
 kazuhiro(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&qu=
ot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B</span><span lang=3D"JA" sty=
le=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span lang=3D"JA" style=3D"=
font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;M=
S PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#D#I#G=1B(B</span><span=
 style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=
=1B$B""=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&=
quot;,sans-serif;mso-ligatures:none">=1B$B#M#P#S=1B(B</span><span style=3D"=
font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=1B$B!{=1B(B=
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#M#P#4=1B(B</span><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none">)
 &lt;</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">kazuhiro=
3.hayashi@toshiba.co.jp</span></a><span style=3D"font-family:&quot;Calibri&=
quot;,sans-serif;mso-ligatures:none">&gt;<br>
<b>Subject:</b> Request for updating device dictionaries<o:p></o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry to disturb you with these extra things I need =
on CIP LAVA Lab. Let me consolidate my requests in this mail.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am preparing a patch to trigger LAVA job definitio=
ns from isar-cip-core. Currently I am working on that in a custom branch. B=
efore sending that patch, I have created an MR to update the cip-core-ci re=
pository which is required to run
 the test jobs in isar-cip-core. I will assign it for your review soon.<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.25in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will be able to send the patch to add test jobs in=
 isar-cip-core once the below mentioned things are done.
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.75in;mso-list:l2 level=
1 lfo6">This MR needs to merge
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/3=
">build-bookworm.Dockerfile: Include lava.sh and templates in the docker im=
age. (!3) &middot; Merge requests &middot; cip-playground / cip-core-ci &mi=
ddot; GitLab</a> which I shall assign to you soon after
 some internal review.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:.75in;mso-list:l2 level1 lfo6">I need some variables in isa=
r-cip-core CI/CD setting section like LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN=
. We don=1B$B!G=1B(Bt have the privilege to do that. I will mail them to yo=
u personally.
 Please hide them in isar-cip-core Gitlab CI/CD section so that I can use t=
hem while running lava.sh script.<o:p></o:p></li><li class=3D"MsoListParagr=
aph" style=3D"margin-left:.75in;mso-list:l2 level1 lfo6">Since we need to r=
un these LAVA jobs when pipelines are triggered in isar-cip-core, I am maki=
ng changes in such a way that pipeline keeps running until all the jobs are=
 done and
 we report the health as a result. It will take around 120 mins to run all =
the jobs. We have only device (qemu-renesa-01) under lab-cip-renesas. So, I=
 request you to please add the swtpm device dictionary changes and
<b>swtpm-jobs</b> tag to <b><i>only one</i></b> QEMU device in every LAVA l=
ab you can access. By this will be able to reduce the pipeline run-time due=
 to simultaneous runs.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It will be very helpful if you provide your support =
with the above-mentioned items.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB6103AF590A9C795BD550C65BC2F12OS3PR01MB6103jpnp_--


