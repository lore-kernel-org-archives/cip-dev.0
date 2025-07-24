Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F51C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 13:19:03 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.40])
 by mx.groups.io with SMTP id smtpd.web10.12564.1753363136667056811
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jul 2025 06:18:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t5C023j+;
 spf=pass (domain: siemens.com, ip: 52.101.83.40, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE64uAbUEvkv2GYGN3FOOa6dQbD2RMiN/nT1ZI7w896iZuE9D796RTYzY4NQkt/SQu6od/dfUMxp5Wg7YYRCJeVtvjCwsavGVkDktVaWvUqiEEMBDXfC42Hf53qc1xATei3bj4WkzZfqRJAfwQFewZSIoUngVgUbdKXT8/UXBSMgE0BmMu89FsrWhbDd/7t+eQDdssHNQIAXw8IV1d9oi48gHdxYJCMiCnOSDG20DWJePJBEBr+91GIjMXSunvMBlSv3/As/n74XZl3mL/SWORDM1hcztoXePP4CiJTPHMw4zWnza7GdXNG1MiBNjLxYe5hox7M8M59CZVTTC9jeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c9MtcX26ddDua1Z/hsZow2JI9Zt5hjiWW50iRagbd0=;
 b=M+ybRN0ZedjBan6C1cg0xz5F6J7f+bomVAtbn8XKq6HSr1Cm+NW0qIaFnakhx3dbZuGpVutH+5V1qTS8lMB7o7YkbzXkzCfJCCCxr/K5KPEpXk9MiKDNEnAQ/ECB8CiuyQ95Za7uhX9Gfc/wc5P/GWgl1LSqxA6EABja6bvJNT1sY774plr2G4rYHbEFpOtMMq4VLiO25l3GlH30dgOkB+kPnK4y+xu0hHoOHwQUQtbMwo/xHgLI37bXujNIsU3ZDJ0MpKvlpCv1HxDAa5yIZdfiIruEF1isSEaA8WquQj4fSTA9/+0g8OWVKi7db5K0H7M9KuSzjqm50NtOli5x7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c9MtcX26ddDua1Z/hsZow2JI9Zt5hjiWW50iRagbd0=;
 b=t5C023j+J3YKyX6ryuavEsHls3wtzf3v67U1swGap85Sti6mErjYFFCTd35+1t/U9rVFJJqKX4JSy5vn7A7dOwAjwaQyOxYceR9zcM/SgAshgzJwWjGqrX6g37+Punc5HG/sApKNBqP250NlLOcyoub8DPdQsW/5AtDt5SWvZQdBQvLnFCzlJssTfsH9ZGxHyyf8pMCLOcDHq1G+jkEZ/gPcXuc2TvG9tPjk7aXPvLi6Kp585U8lU96h9VeYWfrz3gRb1u7pB8Vcccfl0BsaXGRNWCpWHVNJ8kcFaK1PcgketxL7ubKcK3BFVGianUGoXjLFekS7V+DOu/pjFj+cDw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by BESPR10MB9381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.41; Thu, 24 Jul
 2025 13:18:53 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 13:18:53 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Debian: kernel 6.12 breaks cgroup awareness of openjdk 21
Thread-Topic: Debian: kernel 6.12 breaks cgroup awareness of openjdk 21
Thread-Index: AQHb/J2Ab3cwHKWQ8EqReeoTvWH1Nw==
Date: Thu, 24 Jul 2025 13:18:52 +0000
Message-ID: <dc63acc86c4e9a343a783682225ff849095bd547.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|BESPR10MB9381:EE_
x-ms-office365-filtering-correlation-id: 68c5b537-951c-497c-8c7e-08ddcab4a2cb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YVJZbnlicFJkdFBWTEJPbGhOcjJxd21ieWk4ZGthS09oVU5CMzhSRWlQUmZh?=
 =?utf-8?B?cnpwM1FsRnpib3p4S1RLWFBYS2ZHLzRuZy9kNlU4SnFlVlRxb20vU0xBU2tP?=
 =?utf-8?B?QlZScGNrUG1wNzhESFFYWFFrdFA3eXNObkdqL1NqVEE0WktRVndFd2pUZFB2?=
 =?utf-8?B?eFM4clVqUmFLUG1RN3lzTmtHQXhTNkhyOTVhSkZxR0taMDVnVUdXbXlSVzFL?=
 =?utf-8?B?U0FGcEIyQ3d1QUtKUHphS3ZucVh4UzlXeXhFbEVkaG1QSG92eXFEQWtoVTNw?=
 =?utf-8?B?Zjh0MS9BV095MFhhZ1dCMWVHTDFjeXU1L2l5SThoM2pNazllcE1lRnVrWm9H?=
 =?utf-8?B?MENmelN4MUE3WWlJNlYzMWVBOGNkWjJ4QzJtSUxxZ0FpWEoyd0o3UkxYOCtJ?=
 =?utf-8?B?aGU4dzN6WGk1MnE4dGZ2K3JoNHNVbWw4Z3lVNktDVVlHRTQxUEx2WUNOVGYy?=
 =?utf-8?B?YWtXN0NoeGtBVm9FUkozYXpJVStnUlFQNDQ1L0tFNUk4V0lJVEdNZlpBVjVq?=
 =?utf-8?B?U0dWc3RFVFlrSkd4NnoxaXpSSzZrYU96V3RBTDdxMnhQaDl0QUtwektNQ1o1?=
 =?utf-8?B?aitoZjF1KzhyeFBiWFNhazZRR3hla1VJejdNQU9XWVZVZkQ2YVZNbm5WSlcw?=
 =?utf-8?B?UnhrWXlXaElyTjFFalA2cmhCT0ZUdmNITEJHRklWTm9ySk5tY1hFMzZjL2RU?=
 =?utf-8?B?dmdHYms0a01rcFVWZm1JT2JrZUhOM0lzajduT1JUV0JVakZGWGFmKzVTa3BY?=
 =?utf-8?B?MU1pQlI3Vkg3SUxJVVNBUDFhN3kxTXVBdERRemFxKzBhNkpSbVpqejFINm1V?=
 =?utf-8?B?dHkzRDVhUzRhRTMzN0lnR0IvWWZ0dlg4b0pnVWVKeUVsVDFvSDZDRG9LQ1Ar?=
 =?utf-8?B?Z1dNY3B4aGJlQURVRlh0NFF1c0tUSXY2SkpncWVJOGl2eE51cWFLdUt6R3FX?=
 =?utf-8?B?ZGJpUFBIdGM4cndxRXM4MzlSeWF2VDhSZHpsUmVqZUNONGFuNUw5eXJkMGpM?=
 =?utf-8?B?QnZlY3lBcmJxbGlZaXVvalFzaHorTkZQNXZ0R3JwdkZvQjlYWkFKS3RLYnpB?=
 =?utf-8?B?NDFNUElrTTdFb0FkNUhqc0cyTjFYdUUzZzR6VitkUGRFKzZ5ZUlYWUdxMXpX?=
 =?utf-8?B?OTRwV3hhRHBNUi9OSnljTHl6YkVUY3V0ckd2b01LU2lwbG5LZVo5M1hOM1Fr?=
 =?utf-8?B?Sjh1UHBRUFFQdTY1bzRNa0NrQXZDUHp2eXhqMUR4QjVYM3NadGFUSHNiWFNo?=
 =?utf-8?B?ZnVPY0lRdHRUU2hSTHQ3bW14MXpjU0lRcVMzNGFSeUIwa3NMS3JFS0RVRE83?=
 =?utf-8?B?bHVrVFk1eEdYQ2FGZ0JKbktlQUZBQlJ6MEpSRU42V1Q2QWZrRjlqdjI0bEZa?=
 =?utf-8?B?Q1JrMXVWeFkwMU4zbUp5aG5wenJyUW12VHVVS1VEbXl0Tjl1eTQySHcvQmVT?=
 =?utf-8?B?VEhvd0ZwY2tDSUZUblNaVkRibU9GcnpiOG0rSTBPQjRkMTdkYjVSeCtDaG9S?=
 =?utf-8?B?akR0YXVNUTNUYTh4aHVRc0lZWFZDUzlZR1ZKMFhBME8veFQxbXp3Ky8wWW51?=
 =?utf-8?B?WlBVeS91N0JqWEJPb3F6YmVQZVRNUlZYaEFxUzYwU1EwUDQ2QVdiZHNZemV4?=
 =?utf-8?B?REoxVm5OTC9PNmcrdnltM2lZblRrd1FBaU1MVlp3M1ZPM0tlTml1UXVZb09z?=
 =?utf-8?B?U05lTDlVY3RzTXRDV3pTWmoyQWlYajk2ZWVXR3d1ZGZJdER0RVpYZUlyTWFS?=
 =?utf-8?B?UUdENk9VWjhDL3ZyVkUrY1U0VDA3dWJPSVEwZit6YjlxT1V1Tmgva0xFMFl0?=
 =?utf-8?B?c2NBekphK0hTRWIvU3pqNW1FMkZtT2ZvM0JaYXBRTTRXWmZOZlJzMmNNOG5T?=
 =?utf-8?B?K1ZsUzR5QzlaMUNVV0lPRlFVYlNmMlhiamxudmVxUTI5WWVMeGZINHhQQnRp?=
 =?utf-8?B?NG16dDJIN1YzRFZQcExUY0UvamxOVHdHRnZVUnBvUzJ5L1VuRmFTaHdHeFd3?=
 =?utf-8?Q?XcCeq1giBSlTqbhJnXBQdrdM8aZyss=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVF4Q2MwaWJla2YvY242WUFOWEVzcURrd2h1MWdnVkZOODJGK2tRZ1dGTW5N?=
 =?utf-8?B?K1JkdWk3VGRCaGtqR2ovYzNVZHl4SndVQSt5SU4ySDJxMDU5WkZ3STFSK1Nu?=
 =?utf-8?B?RXdBcEVycHpvUG8waFVLeWJIN3N3TXZzV3hYd2FvdS9HLzF1VnhXMU9DQWsz?=
 =?utf-8?B?dlhkK0NwVVRPdTRXeDZBanQ0c3YzVUpnMTVHb3l1dGFvTWtNZm43VW0rT0Uy?=
 =?utf-8?B?aVhPdTBKQUc0SmtGSnRVSHVuWkNiMG95VVJFN2NETWNFcnFrZmZnTmFvaS80?=
 =?utf-8?B?V1MxOG1JT3ZBSnVpN1hiemx1Sk1KM2pzSE04Y0hxTlc0V2NraW14OC9GcGlT?=
 =?utf-8?B?Tms5ODlqWERWMGg1bU1pcE1GVnRzWGtIU0FiZWh3eVAyVGVZUTdDeW5RSFI0?=
 =?utf-8?B?NDJ5Ump4TVgvbGZQNng2M1RmL3BRdXR0UmxPeGJwSUhBWlNEcUVWeWZmQWxD?=
 =?utf-8?B?SlpRUDBwZGRkOHpMSUM3VDU1a0hDS2JLRENybk1RYWhDdFJkSmxkaU0zUEZP?=
 =?utf-8?B?bm1vV1V0TnpKVFg2RVVmbWtTY3A4Qm9UZTdzcEhDb3ZRWE5oUnNSV0N4My92?=
 =?utf-8?B?NWEvU1EvcmJmVVlHMVI2WWJ3RWRsY0tHMFZ4SFRDelhTRkxhcVMybXEzam9j?=
 =?utf-8?B?TzBBV1NsRytkbUJuWmxzbTJ5MFhseHEvU003Vm0yR2J2anAxZi9rREFaTHNN?=
 =?utf-8?B?OWtHc0RBdTZLMlFna1dqNjB0ZGZvVEhvcTc5ZHJ2WlFwYWpwVTE4M3J3K1Q1?=
 =?utf-8?B?TEtKRzM0T2V3R21ORXhqRXZ5OWttcks5OXJ0R2NlZ2p6YVdNbVdDMDVtaDQ2?=
 =?utf-8?B?NTk2K25INFVWOG94ZVVJRUlFMExDalBTMmZPclRwUFhnQmlqaXo4cHZVcUxH?=
 =?utf-8?B?Q0p2Tm1sNTJjWGFSRVBJNTNlS3k0MXU4MWE0MG0wcVpmRDdBOVJqVExKaXRl?=
 =?utf-8?B?Q1h5VFBMZDFwdVNkejRKY29wSjZUUm9LeXNXbWhYOHN5UzU2OCttUmdIMG5i?=
 =?utf-8?B?ZDdSdXBPVjRQcUVmMGQzLzFJQVFERU9nc1JaeUh1cDloZXpQc0txWXMxWktZ?=
 =?utf-8?B?SmFsV1M5a1hlZ2g1SnJNVVVtbHdXbDVUeXkrV2p6b0JVdnNQTWRaejlQc3pP?=
 =?utf-8?B?MzdZWTI2OVFLV3I5aEVscC9xdzJ4OVNZYlEwbXd5amU3ZWIwbGVPVDZBNVU0?=
 =?utf-8?B?UTVvUDQzMktxMU9TUlVodmF4U25MdEJlQ0tsZXVUTFhLd0FpMXdBcHBrcTBa?=
 =?utf-8?B?UEhKb3FuWVpYZUV0VUNROUpTUlUwS0cvN3FDVkhIVWxhVEFwNEl4NVl2UU4r?=
 =?utf-8?B?NGhMSUo2WXhGZ0loUkZFN1htMjdGb2xUalo2aUxadDVVQnllemVNRmthUVZk?=
 =?utf-8?B?ODBLOVdNMUJ4MWJLWTVjemZic3dMVzliZG04VXR1VDNWVHRrMGsvd3NJRk1h?=
 =?utf-8?B?bjNyeVE3NDZwOWdKOEtCbGE1TUtBUUZJL081UXpjdVJhUGs3QjNQeG9GblJW?=
 =?utf-8?B?NC9jd0lWZG82VHVxTG1JZVJaR1VDeW0zKzR6TUR5RHZURVdQczA0Yk16VXRl?=
 =?utf-8?B?UnJPUU5GZm00ZHFZVHAzam5DcjhSYzlTRk5nWXVlV1d6V2Q0a3RpTStzNVVF?=
 =?utf-8?B?aDdLdkExZUpRWUp6dXdoMDgwaVpMbkhhVmV6RGtzOXFWTXg0eFVrRXd1Tmpk?=
 =?utf-8?B?QmdVRFZEa1pMSm84Wkh4OWg0UHgvRHh3YmJFU3VYb2ZQRFBXZFFMYXNXTlZs?=
 =?utf-8?B?ODBleHkzVmU3KzBEVmdEcDZ5OW5qVCtiL2pCMlh4THZxSGp4Y2FjaHJXVWhH?=
 =?utf-8?B?dTEwRmRpdkV0MFR1SGsycFZVMnFNV2V6WXVoclpLZjZoT21DR1JIY2hsZWNo?=
 =?utf-8?B?NjVtRVhQTDlNelNqcTFla2VURmdrVGM0NEE2MWhrNUxxZEllckZtV3YxaDlG?=
 =?utf-8?B?WGk5S25pdHRxYk9GUmRyd2RncFQyM1pJbUg5LzB3OWtqYXpYM2xBcExDK2Zi?=
 =?utf-8?B?MzZ0M0hRWWxEeWJDNzRrazhGbkI2Nm5HdzhwcFErTU5Kdk1lZnYxWnM1MVhB?=
 =?utf-8?B?VVZ6d2JzZkx6MkF4a244Z2J0SnROZW8vVzBGOHZQR3V2ZGVRMnA4dTVtWTZq?=
 =?utf-8?B?YW9pc2ZOc0RiNm0xK09lOGQ0ZXY1TTJWa0tRdDdBV29HY01nYVEvMHFJVFRa?=
 =?utf-8?Q?wzEB9cQhREbJTTGqxAk+7SA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28DA7DF72AAD494ABDAD7E96BAF40CF4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5b537-951c-497c-8c7e-08ddcab4a2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 13:18:53.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36Rk1AcMRxJJPRXcx/LrdeUs4/RHUFniBaOJgQIthxNG6l9RyK+AWyRCLd1pj3tpxli+QTfUzIlCru7k48DoRLZ98Ed/AfXNyeB15yMpJS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 13:19:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19586

SGkgYWxsLA0KDQpJIHdhbnQgdG8gbWFrZSB5b3UgYXdhcmUsIHRoYXQgY29udGFpbmVycyB1c2lu
ZyBvcGVuamRrMjEgKGluIGZhY3QgPD0NCm9wZW5qZGsyNCkgb3IgZWFybGllciBtaWdodCBPT00g
d2hlbiBydW5uaW5nIG9uIGtlcm5lbCA2LjEyIGFuZA0KcmVzdHJpY3RpbmcgdGhlIG1lbW9yeS4N
Cg0KVGhpcyB0b3BpYyB3YXMgYnJvdWdodCB1cCBvbiB0aGUgRGViaWFuIGtlcm5lbCBNTCBbMV0u
DQoNCkFzIG9mIG5vdywgZGlzdHJvIG1haW50YWluZXJzIGFyZSBleHBlY3RlZCB0byBzaGlwIHRo
ZSByZXZlcnQgWzJdIG9mDQp1cHN0cmVhbSBjb21taXQgYWYwMDBjZTg1MjkzYjhlNjA4ZjY5NmYw
YzZjMjgwYmMzYTc1ODg3ZiwgaWYgbmVlZGVkLg0KDQpJIHByb3Bvc2UgdG8gYWRkIHRoaXMgY29t
bWl0IGFzIGEgbG9jYWwgcGF0Y2ggdG8gaXNhci1jaXAtY29yZSwgYXMgSQ0KZXhwZWN0IHRoYXQg
b3VyIGRvd25zdHJlYW0gdXNlcnMgcnVuIGNvbnRhaW5lcnMgd2l0aCBvcGVuamRrIHVwIHRvDQoo
aW5jbHVkaW5nKSB0cml4aWUuDQoNClsxXSBodHRwczovL2J1Z3MuZGViaWFuLm9yZy9jZ2ktYmlu
L2J1Z3JlcG9ydC5jZ2k/YnVnPTExMDgyOTQNClsyXQ0KaHR0cHM6Ly9zYWxzYS5kZWJpYW4ub3Jn
L2tlcm5lbC10ZWFtL2xpbnV4Ly0vYmxvYi9iZWFkZjYzNWZkMDY1MmU1ZTNmMjg1ZTkzMTVlODZi
MjFkOTBhODliL2RlYmlhbi9wYXRjaGVzL2RlYmlhbi9yZXZlcnQtY2dyb3VwLWRvLW5vdC1yZXBv
cnQtdW5hdmFpbGFibGUtdjEtY29udHJvbGxlLnBhdGNoDQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4
DQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdp
Zy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55DQoNCg==

