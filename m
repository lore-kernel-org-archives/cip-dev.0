Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B61E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 16:56:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.156431.1734713791129496343
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 08:56:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4BKGuS5U2676670; Sat, 21 Dec 2024 01:56:29 +0900
X-Iguazu-Qid: 2yAbAvUQJwYTzdbJmk
X-Iguazu-QSIG: v=2; s=0; t=1734713788; q=2yAbAvUQJwYTzdbJmk; m=TM1o1gdix8aVEki5Twr+ZeMXroxS/eVornRP+vioBZk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 4BKGuRPw1649437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 01:56:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soht9xU1kmgkFjCQOXmDM6S8L5mzkwLa/qxsK/S+m/CWPvP9Mx4mr0tDG7CgmExU4s79ufkq8/nIcJYbCuAalSpkPvGHlvpu/8sMXpBIT+O4A9wUjl5J9hCa7NiDmHiXygClKdcgcvjctxYk6Sk63mM8QEQqprkkUMMP6eDGttQUKX9A3OSCLujag+FYkBXXBNs9i7tGYRCK2sQEA6809df65qTxsOWWKwwffRIxrcpk7whXP4zI0p1jueJyb8iQ2M/vr6VGJJEBZHtNJSZaTk/FNQqBWPjjhEO6RoqimZ3Wb34VKxhY7vOa1mR91x0Bbw16QxUaeqVDXwFKr0rONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT8upIr3ys4n+sgNvsgUGhpDgqAtDA42XgCiVi4o9Zw=;
 b=Lg1EXEOYNt5E3XAEk9dLl9ICvovqPcW/imzGp3jJh06Om8ZKor2q5sXNZNug4J+uFA/ygv5FAoIHIq4cyjd4GIIoBsXnMKtW4xmpcqdzcADUNouF7IwzOr8zCaabKwoLv2jPgfzzl+fN6ufU2viIaNHizzrXgzeX1oo5oRPL592H56wHNehsu+/31M0fV4HkZUbZi8Cl9l7Tx9zAAL3WqBfxVNaeGwjhjT1xfQ7sldcO84CLV7QbWMuvDZYxEjw/D8oiC8NESrOaXoPPRHSb+XJ9QyUoVPrryl3elLzY2Al7t7p6Ed5vTQYTXZUc6dcqsxuF7Seu64cocRn3TMwCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
        <Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Topic: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Index: AQHbUuTAhee4QvOabkGKuX6gapV/KLLvWeRw
Date: Fri, 20 Dec 2024 16:56:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|TYAPR01MB5628:EE_
x-ms-office365-filtering-correlation-id: 2d64068c-4868-4f40-f3e4-08dd21173d81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZkVqSGtHVzZaTXpYL3doUHlaYnNXeGdHNFFxdEhiSjlHcXNsRE45Tlcr?=
 =?iso-2022-jp?B?aFhka05sTGdsNDNadUlSRG53dnRFWWx1cDFha1pCNUY0S3RwQlUwYnUw?=
 =?iso-2022-jp?B?WkR2dnc1UGFtZzBFMWJvaTBjTFZiZzJCVHlLTXVEdHdab2V4Y2dacUdo?=
 =?iso-2022-jp?B?OFF5cWVpUEgrNDFUMzVmNVFMVkJYdFhlWnNFaStqK3NCMkZzNGhrSEhl?=
 =?iso-2022-jp?B?SXF6dmFTTTEzOTVPNlB0NzZKemFPWC9zUjAwR0ZRVkRLeVJzbE9NTHhS?=
 =?iso-2022-jp?B?MTlEMFc4blRURUZ6SjZIZ2swODFzdU5iOGRwdytBM2pzbFFCZnJGajM4?=
 =?iso-2022-jp?B?dlloWmVMc3hZbFUzUjUzMGw4ZjhYQXdtcG9LVXE3cmF1QndQNU9lWWlO?=
 =?iso-2022-jp?B?QVI3YUJLY1kzdnpRcnpYV2FiQ0NjQWsrbTkrdFdkNEJOaHhLOWNFdENI?=
 =?iso-2022-jp?B?U1Q1dytSVDhRcmRqb1RmdEwwejJZdnZnQXlTYloySVFMellYdUxMTmhC?=
 =?iso-2022-jp?B?YmpFRTNzSWpLcFB6YVVaYVRnOUN6L280YmZXRi9CMTA4bW9ZSkRJNWlx?=
 =?iso-2022-jp?B?TDdHcVRSNFlndjBKRUJCNXJwMTd1M1pkamNLSDZad2YyUU42Tm14WGhE?=
 =?iso-2022-jp?B?TUJPUkRsSDRZNWVjWkE4emw2WXVmOWIrSElBd0Z4NzUvZUhXTnd6TUN1?=
 =?iso-2022-jp?B?dHozdEczcSt0TWFSc3dOZ2dmQi85cmo3SC9LNGZpMTIzUWd0OGxyR0R0?=
 =?iso-2022-jp?B?R2o3Q2FESHdONjZjNDNjd3ptbno0ZDlNT0lXTlBsRUpoQkNFVk1yR3Rl?=
 =?iso-2022-jp?B?YjdBQmdEK1BLcU1ydDhyNUpDR2hJSmplY2FyZHBkdUNrQXYrUzhZbkVR?=
 =?iso-2022-jp?B?RVlaNHZaaXVHK3Q4SVhxaEIweFdoVVppWGtoQnkwSmZJV1NTSloyMkY4?=
 =?iso-2022-jp?B?NGxzazgvWVVXT212U21xMm0vYUt4aW4yODVheStxNjc4Q1NWRVR5bml1?=
 =?iso-2022-jp?B?UlRsZ1RMWGIwTjNtcHp0bW8zcjV2VnFqQm5iU3lhVllaTGNRTlV6alV5?=
 =?iso-2022-jp?B?RnNnT2FWNlZYR0s3QU1kS1RmK1lhb0wwYURjbjZ1WWlTU2Irc1p5TUNB?=
 =?iso-2022-jp?B?SUZ3Zm9DRlRCTWtZWnRHank5MFd5KzJKUzdPY1haZ1lXZ1lDeU5zSmQ1?=
 =?iso-2022-jp?B?MUE4cHo3UERsb3E0YnFzLzAwdVYyY1UvL3RaWTdoQTVQV2V4a29JRUpV?=
 =?iso-2022-jp?B?NG9zaGo1ODltZ3p6RTN2bm1lc1ZocGMxVWNYMlQvVUd4SWY0VW42MHQ4?=
 =?iso-2022-jp?B?OUw4VEROWTVXNnVoSlpkeEMra1FVVmdLWllRU0xwQ0N5TWMwdmpKV1lJ?=
 =?iso-2022-jp?B?Q201bzViU0NGRzRjcThRaHFFVm9MTnFkanFkcXJmS1hUcFY2WHFqNGpk?=
 =?iso-2022-jp?B?NDFETDU3SHEvcjdDN0VNN0dzeTdxNERNOUc3bnhPRHZXUWN1QlVmbUNC?=
 =?iso-2022-jp?B?bVFOZmZ5RVhiMUJHaU9hQmtZWEM2OUVSNHhkajBrL1hxVktSLzZuNGVD?=
 =?iso-2022-jp?B?eGNlWU5YR2J3a0hjZ25iV3BMczRQY29JRXBETVpIaWl5Uzc1alRjOG1N?=
 =?iso-2022-jp?B?SldwUU5NQzZaSlUwYnNLV0tKeUJhZVphM2xQb0h0V0VndDBSajBnaDY0?=
 =?iso-2022-jp?B?VC9zTjR2ZVJXOHZNQVBwUWpjU25sQ2pUaDlhLzRlL3JTeDJTcnRWYUNu?=
 =?iso-2022-jp?B?c242NjZ1S2UvdnZJaitLWVZmSnNEV2dSSjBLakJZQkpwQ2I3U1pyTzE4?=
 =?iso-2022-jp?B?MEg2Q2o3QkNQTzNlV1RvdEgzM0Z6b2NGOUhEaWVqL0ViRlBjZE1CSHJr?=
 =?iso-2022-jp?B?VE1kLzlsaFB6eEdRN2Zuak1SQk1nQ0M4UXp5V08zb3ZGMS8yTm5abmRN?=
 =?iso-2022-jp?B?bGNVMTcydUVoZC9ZL2FQbHpDYzBHaTN5RXFETzIvMXRuY0ZsN2MzckRl?=
 =?iso-2022-jp?B?T3AxNG5QQkJJdCs5TDgvY2cvdkQ1aTcydlZZR2JYNTRVOFhiT3RFSW94?=
 =?iso-2022-jp?B?M0llUGx2LysxaXhkaFpEQUhnM2s0blFVcVprbm1tSFZWeFpRNjJNZ0E5?=
 =?iso-2022-jp?B?eW8=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MGxzbkw4TjI1OFdlSWFuZzBKVFBIdE8zRTc1SHFjazJuajR2akdMSU1t?=
 =?iso-2022-jp?B?S2xUS2NIOW96YkptM0NHTlpCWmxBUE13ekJPcUJUdnE4ZW9mSDhLRjVa?=
 =?iso-2022-jp?B?aUZ1NmlSUUZuYkVScmJWbkgyZHlKalQrblZ6UW1tS0c2WUlxNzRvdzR0?=
 =?iso-2022-jp?B?UnVCUWYwQjdRYW9GeFFCTlQrKzhaWG5DTnVaM0o2d1VQOXphK2dEbEJS?=
 =?iso-2022-jp?B?K1dqNS8wbkZ1U0FOVWoxZndieUZna3BVblFtcDJRMVNMak1DTnhOMjJs?=
 =?iso-2022-jp?B?M0NRYXdjUmRHNFcyenp6L1hBckZSK2UyWDdzeUdTMzZHZ1l1UTVzRjBY?=
 =?iso-2022-jp?B?STlqODJibzJCNXZ5eTJjajN1VXk0VUVvWWp3dUNlUXJxMlI1K3E0WFFH?=
 =?iso-2022-jp?B?MkhSK0hrQ0pZWnk0SXhmVHRESktNSmQ2VHdLNjhZVzAwam0vNTR4UVNn?=
 =?iso-2022-jp?B?TFFaR2prc1l5TXR2c3hESk8rUDBGbk11UUJQbGduRGkxZDBydkpMV1Ft?=
 =?iso-2022-jp?B?eExrdm5JT3lGOUZFT1JXMjAxZG5zRDZQOUYvcUZrdVoyWmhpNFVUSzNM?=
 =?iso-2022-jp?B?Q0t6aHF5anpheWxYcmpLbHptTUlHbGVDRFg5Q3I2NXNNcG8vQlA3RmhU?=
 =?iso-2022-jp?B?UXB5R1IraXphKzBoK3dkV2NCdm5GYW9kRW43UXNGbENEMGx6OUxjSWtT?=
 =?iso-2022-jp?B?amtKWHU1R3Q2RTlqV01GQUxCVXRjYU1tdHhoVGFpRFVEc3NvNER0ZDJ4?=
 =?iso-2022-jp?B?cmVrUktQdW9MTFVTVXlZeHRqYU5pUnZxSnJILzZKYXhqWkdvbWtzZ05X?=
 =?iso-2022-jp?B?ZGNKbkNFTDZ5TGkrWHVSd2EyWmpXWEd3cnNOQnlzUDA3eVJ1SzZhdFE0?=
 =?iso-2022-jp?B?WTBDTXdPaFlDQkk5QUxBY0Y2eE04NE5vSHlJVjdWUWg3TUVScHNodkhJ?=
 =?iso-2022-jp?B?czZvV1U0MS8yUVFJWC95SW1HUFkrT1JlUDhjRUl2WFY0dVVka0dvWW03?=
 =?iso-2022-jp?B?ZjQxb0Noek9yMUxrcGhsamlLYXdZeE1ySzJYcDgzY2FPZnhLdndhK3pz?=
 =?iso-2022-jp?B?UWQxOFh4UUtNSFRTMHVHdUphOGpTeUs5Y0U0R0trU2FNWUxiRW9CRjY5?=
 =?iso-2022-jp?B?bU0zODEzREpxTk1MQks3YnNncWFkRzhyYkt6RmV5TkRwSXBtbUthR2Jq?=
 =?iso-2022-jp?B?VWNPdUszZWIwcG9iK0xKdTV3SjVtNU9BYzZPTm96YTM4NTd4T0dUYVRr?=
 =?iso-2022-jp?B?MFRXY1F2T2ZRWnJZUE1JRUNFQjQ0eENINVFqUHFFZ0lidlN5WnFVVEdD?=
 =?iso-2022-jp?B?TXVSWUdiekFUc3pOL0RMakxhODBOcmhUN25DZTBJaDBGTWtuR09ZOC94?=
 =?iso-2022-jp?B?SFB2cld1YlJpWk13OFIwOVJtWUdMUWczcGRrNHhlek5GQTZYZ3JVbFJv?=
 =?iso-2022-jp?B?d0JTRGl3dDJYL3c2ME5EQ3Vua2taeVlYM2k4NTNaYzBlZzMwWHh4WS9i?=
 =?iso-2022-jp?B?NkJQUFRsWnJ1OC9lanhlRzFQVzdhN1dHVFdFZkNWRGlwYXpJVTMrK2JN?=
 =?iso-2022-jp?B?a0NpTDQvTUJXa0VmYzkwbGtVblVMN001K25laEdEZW9yYllLZis1dXdY?=
 =?iso-2022-jp?B?aWNPbFNRaStTcFNtR0s3U0lxc2krWjZJMDBEVlNVcWtzT3hhVmFnUW5j?=
 =?iso-2022-jp?B?aUpZUEpzN1dxSGsvNithc3Q4eE5ETmRhNFVYeHE4MHM3MnhyVENGVDlQ?=
 =?iso-2022-jp?B?WTF3cTZ2QVdoWnhjSVdWMXZHMEVqR0o2N25td3M4L3pLMFN1TDdqV2VU?=
 =?iso-2022-jp?B?VnRINzBzRjRIaytjYkFrdkdGQWRRYkRMUVU3Vk43Mmo1MzJJc2JwSmph?=
 =?iso-2022-jp?B?UEhtZU5iSFUzbkNOU25wR2FyV0RiMnY2RUxrSUZyUXM3VXZ6UEpnd0dp?=
 =?iso-2022-jp?B?QWc0aFp5bFF2RUk5dEpweEhXTFZuOVZhbVpRcnlBRytGM3JvU3Znb2xT?=
 =?iso-2022-jp?B?MEZxME1jRm1Na3VuZnllWU9HQ05MZ2FnWU5ySUtJUkhLUk1YSUdqb2c3?=
 =?iso-2022-jp?B?RG5HR3RjNDhzWlNRZlplSEpFUCs4MWpzbUNUTS9VZUdJNmNUMU1PRDNq?=
 =?iso-2022-jp?B?VlRqS1djK3FZamwyMDJHNXczdldmNTNzZ3ErWE4zWktyK0RXTEV1SzZD?=
 =?iso-2022-jp?B?SEhHL2RlcS9qUk4rMXk2R05idzRpQWh1Nmx3OCtodFdxZWJqUXVURkJZ?=
 =?iso-2022-jp?B?WkdobzF4WmxOWGIwcFlTT1V0aFRsdTk2Tjh6OFVoTXltUERLcnRWNVZq?=
 =?iso-2022-jp?B?dmJ1cXVOcXAya0UwSjh3NUxocXlJT3ZLTnc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB85159B1B29203FFAC3458D6ABF072OSZPR01MB8515jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d64068c-4868-4f40-f3e4-08dd21173d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 16:56:25.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBRndLvhdtY/Uvp8u3hJf21pcrXb4VQ1aObYB8yITLNNKHObbM3PE2o11MoK41oLbpxjdfL+H5NggUh+M1nbX58uNT8vkpRJ34FxUt8pnn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 16:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17487

--_000_OSZPR01MB85159B1B29203FFAC3458D6ABF072OSZPR01MB8515jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Please reply to this email as by mistake Ashrit included SWG.

Regards,
Dinesh Kumar

From: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Sent: Friday, December 20, 2024 7:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>; cip-members@lists.cip-pro=
ject.org
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; cip-=
security@lists.cip-project.org; cip-dev@lists.cip-project.org
Subject: ltp (syscall) failed test in CIP Security image with isar-cip-core=
 v1.6 on M-COM

Hello Chris,

Hope you are doing great.

SWG locally executed LTP tests on M-COM x86 device booted with CIP security=
 image. The kernel used in this image is built with cip x86 merged defconfi=
g<https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master=
/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads>. After generating the=
 results, we found some failed tests in the syscalls suite.

We wanted to compare them with kernel test results in LAVA and noticed that=
 cip x86 merged  defconfig<https://gitlab.com/cip-project/cip-kernel/cip-ke=
rnel-config/-/blob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dhea=
ds> is not being used to run LTP tests on x86 targets. Can you please look =
into that ?

I am attaching a document with the results summary of LTP tests when run on=
 M-COM x86 device with v1.6 security image. Please have a look at it. I am =
also attaching the failed test cases in syscalls suite.

We need opinion from members if we need to hold back from sharing the v1.6 =
x86 generic isar-cip-core evaluation to BV members in case those LTP test f=
ailures are effective.

Thanks and regards,
Sai Ashrith


--_000_OSZPR01MB85159B1B29203FFAC3458D6ABF072OSZPR01MB8515jpnp_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Please reply to this ema=
il as by mistake Ashrit included SWG.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Kumar<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I=
#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif">)
 &lt;Sai.Sathujoda@toshiba-tsip.com&gt; <br>
<b>Sent:</b> Friday, December 20, 2024 7:43 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; cip-members@=
lists.cip-project.org<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(</span><span lang=3D=
"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-U=
S" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> T=
MIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; cip-security@lists=
.cip-project.org;
 cip-dev@lists.cip-project.org<br>
<b>Subject:</b> ltp (syscall) failed test in CIP Security image with isar-c=
ip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black">Hope you are doing great.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">SWG locally executed LTP tests =
on M-COM x86 device booted with CIP security image. The kernel used in this=
 image is built with
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged defconfig</a>. After generating the results, we found some f=
ailed tests in the
<b>syscalls </b>suite.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">We wanted to compare them with =
kernel test results in LAVA and noticed that
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged&nbsp; defconfig</a>&nbsp;is not being used to run LTP tests =
on x86 targets. Can you please look into that ?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">I am attaching a document with =
the results summary of LTP tests when run on M-COM x86 device with v1.6 sec=
urity image<b>.</b>&nbsp;Please have a look&nbsp;at it. I
 am also attaching the failed test cases in syscalls suite.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">We need opinion from members if=
 we need to hold back from sharing the v1.6 x86 generic isar-cip-core evalu=
ation to BV members in case those LTP test failures
 are effective.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Aptos&quot;,sans-serif;color:black">Sai Ashrith<o:p></o:p></span></=
p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_OSZPR01MB85159B1B29203FFAC3458D6ABF072OSZPR01MB8515jpnp_--


