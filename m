Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B9C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 12:42:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.35724.1737376919817586696
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 04:42:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 50KCfv3P1247226; Mon, 20 Jan 2025 21:41:57 +0900
X-Iguazu-Qid: 2rWhyCKR4Af4KFaQuu
X-Iguazu-QSIG: v=2; s=0; t=1737376917; q=2rWhyCKR4Af4KFaQuu; m=Mqb1MFglO5EKrzjFBPtKc0ltaYGtiPSYojzQND87xMQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 50KCfu573789292
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 21:41:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCP4DTV51oJ7P8VDMMzJcOekTzozCitsyiHt28ZG/EF+pElDvL8xN+xYxmiYqNL0Wg0Dxw9IUMeuMPmnDcfjcN1Nmk5gK+SZnegiLq6007c5OJBSYIjK3a2brJi7oGGzM6sVa8oZVdmsPwgykeeeMpa1lo256T7Mwt2Xig/4IWvSpgxqIqa9Pu+Bv22KsGypJBFWsTZKyacoTxZGKNECryTVCqopJYGOxaNPRi1uD95YQefCeivbD8XWwBYvKv0R/Vj8TMFcS/vycEP++aieW9vAS+2rktkbPN/s2vqILFy39M5DI6P83psfyTISUvPPdZN3bL5k2v/NxoHv7+3orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4WxJRxq/O2aDcVNiAdLTWtJ0rTz6T+tgKKa8gkTGLc=;
 b=n4f7xuUE8z2Pe73eGHIxYXnCNQc62gboJY2RhWBuAwt8X2uxKvRjQvlQJCk+7faLi2wdtPx3mWadZHO9ALaflkEL9Cz07guWciSAm/87+9ULwJU/huamhmXC/ukPWMjzNl1LcHJU1ryyaP+Hhi+Er1s06sqQpYaZnx9yUE06E3FS+qvY9bOOlTZBnXdWDQO1QJlvE6k8vhQ54wGmxteHzohhFqN7dgDZmIOFwO40wVtnQYauTND4Dubwv+9Fvcit2AmuJWTLUmUBfb8lYOpogYy5JErFvvht+01Q3Uxcv4OFEQ+jogF0brjxT58NUZpKznD5aVc06vLL6FeuQ5Uo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <christian.storm@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <koshiro1.onuki@toshiba.co.jp>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Topic: [cip-dev] Regarding support for WFX backend for software updates
 in CIP Images
Thread-Index: 
 AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAALvlaAAS1PbFAAEtUdAAERYfYQAAUzvoAm6f/SaQAJBZyAAMLxhqw=
Date: Mon, 20 Jan 2025 12:41:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966913481F3B849D736C277BC4E72@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
 <TYCPR01MB9669740DA683EAE4C6E8ADBFC4D62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <6FC4E265-2F94-4144-A714-784FAC157CBD@siemens.com>
 <TYCPR01MB96699778EBAC2E3FA6E11FF4C4DC2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <5A591B53-A5CA-4F84-B055-1C9843037F36@siemens.com>
 <TYCPR01MB9669FD137BC7D188F1D7558EC41A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <0D555EDC-271E-4EAE-A67B-7A02D9CF021B@siemens.com>
In-Reply-To: <0D555EDC-271E-4EAE-A67B-7A02D9CF021B@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYYPR01MB14661:EE_
x-ms-office365-filtering-correlation-id: 73146ee4-b8d1-4969-ec53-08dd394fd187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?gb2312?B?cnJWcEJlODdwQk1ZMEtueEdqTnpBdG9hUTJ3VHVuSGhPV3g3MWNLK3B2VEQx?=
 =?gb2312?B?c1J2bE96UXp5VzdqeXBxZlhONG1RcHZnbXNLUWttM3ZlQVRRN0pqVG9mRmVV?=
 =?gb2312?B?WmQ2dzBMRFpsb0hWTWRqWlZpV29sNnZJNTVwY21YZHBRQjBwYkZlWTB3eEtX?=
 =?gb2312?B?TE9RcXJwdDFVdnBXK2tqWkRobnRVTWV4RkZNMlZONUtkYk4rbyt1SUErUGdj?=
 =?gb2312?B?bStia0NuOGhnNVg1VTROaXJpYlZCQnh3NzlGZ2xROUpWUHVkMGt2L2tUaTZK?=
 =?gb2312?B?TzBKOUlRdk1SZW5lWkZXQ3o3REkwTUlFb1BMWkhFeWNkbHphVmpVV2VqL0hm?=
 =?gb2312?B?V2FTNDFZNWhQd1hYOVl5NFJ3NEljazFSSWkxSm03Y3IrdFJrL1k2NGF3czRB?=
 =?gb2312?B?REpXOFg2L0FLbkoreDBpZndESEJUWXB2T2RlWW1WK1VxR0t4dnJPTVJZcndi?=
 =?gb2312?B?LzFxQVh3bmVWZVBwRkMrbE9vek5HWk1oekJiOVRJbU5pN0hDNDRoUFJYT05M?=
 =?gb2312?B?a0xtbVg3b3pweHN2cWc3OXpNRk85WkhFbVRKMU0rSFIxQk81bDMyTFVOK29s?=
 =?gb2312?B?bmdsVklRajdVM2VVTFU1TFpqV1RralM2WDVQbEhDQWx6RTV2cDRJdE9lZ0Fn?=
 =?gb2312?B?YjF1NTF5VVVtZUJCMEFDcStuamZBWVdESXJ0NEJTUW1vVnZIYm8wb2JXVWRV?=
 =?gb2312?B?SzMzUWJQWk1HQWJyZ01PR1NsLzE4bXYyck13R2F5K0hzdmpRUEFxWExuclpz?=
 =?gb2312?B?eDhBT3FnUzQ4UVpMNEJseGtJQ3ArU0psT1JuY1RlcFpoOHFwU0RLTUpqNjFX?=
 =?gb2312?B?Nnk2b0ROOGRocHlieFJlaytoTjRyNHJKZWE1b1lnbFc1N0o1Z1dKNUNyMEdy?=
 =?gb2312?B?OFlVVk55L2pwMjFvWFhMTHpKNE1ZSDdrb1pRY1VqcjZKZGpKdGxDS3EyM3pM?=
 =?gb2312?B?L2Y1MUR5M2NJeksvZFVnbkVVUVhTVjMxU3JHZmExLzJPMDNUWFRuYm9kaDRy?=
 =?gb2312?B?SnNpQnFzcXZKM050SU9RaWdKMXphWnViRlZUM29QNHhRRHJpd1ZBQzhZZ3JR?=
 =?gb2312?B?a3RvSHl5TDkrV0VlaDdhalZZNEt0WXRaRkQxTHpaaHlNMjRQckV1Uythb1J5?=
 =?gb2312?B?OVo4M3ByNFo1bHU4My9UZkxUVEppSFk3amFkUk1uN1BVZ25ydVpMUk1WdmJm?=
 =?gb2312?B?ZUVQeGNUUlNCWDZRTDZTUWlVSzMxcldqcGJVZEVXSDRrWmZJZy9SZ2dWVkVN?=
 =?gb2312?B?TkF6bnZNVzEvcGFXbDZMVEh5OEpad28vVHl6TkNZYUlYZjhRK3JBYVlUbno4?=
 =?gb2312?B?U2wzaWFwNWovOWR6bis2VGhzeWRSVVAwZHF4Mk1xTDN1NWFDMmcwQXhVWnRw?=
 =?gb2312?B?WXNjUjBCYVQ1V2lXSFV1c2FTeXo1SDVIRlJENGk0aU1hWU5URXZWWHVpTTRO?=
 =?gb2312?B?eTdZRCt3ekEzWENXTzQ0YlRMUm9RWlZxbWhlNXFGamcrYWZpUzNNaU5qWnUv?=
 =?gb2312?B?RU0wVmI5OHA1ODJ2OU1PbWNVK2VIMDZkdWFVSUNhb2o5Wi96NURrSVBGMGxP?=
 =?gb2312?B?Zk1aSzVmT2Fza1lDeEdWcWh6VWV5RWR5VllGd3UyTTRQbGxqQzVQTUIvQ0Vz?=
 =?gb2312?B?eXJmaktxSlNZZzNMeS9LS01MUlZrQXlTK2lnYnYwVHRlczBkank5clNSL2lk?=
 =?gb2312?B?OEptNFFCK0Z3TWsxOVFnc0poUCtINUp5enJjTlZnTEhSYm1mNHBUZzVabFM0?=
 =?gb2312?B?Rlcyck9ubTBmNytVM0FwenE1YXB5SWtvcVFXR3hkRU1xcTFadTF2MVFtNFBM?=
 =?gb2312?B?YUN3R1pQZWhZRWdXK0E0a3AzUnVkcWk3aFJiYVY1UHJvcmQ2elA3dkc0NTZF?=
 =?gb2312?Q?CV2QwzUVvEPQe?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?U0p5L3pvU1Z2TjRtL0FvM1Z4RUwzTDhBV21tN1RnQnJORVB1Nk80aHZXZzFn?=
 =?gb2312?B?ZG5xNjhrWGp5MTdiU0FRUVoxYlhkY0dtUjcrSDc3OXdkVzAyWjU4SmhzUHNj?=
 =?gb2312?B?b1k5SktFRXZ2MHppUUhQSjZUMkJlK2hSTWdSRFFxY2gvZDBuU00relFJeFMw?=
 =?gb2312?B?bWtyZ1VYVlVndTlXc0ZxREMxZWpvenhSY0hZUTJ1QVE0VUV0Tk5xdnRyQ3h5?=
 =?gb2312?B?dU40MDhOdUk5c01hb0xPL09ZSG9EbzFFeGQvZnZjMDdrY21vYlJvZW43QW4z?=
 =?gb2312?B?ZGk1cnkybTlXOXRCR2l5TElBL1llTHppMjJISlF1T3JOOUtpMExPSGh0eHhu?=
 =?gb2312?B?eDRPVlZqdWo1Ry9CaGpWMVJpTU54a0EvL2Z0RHZyMkd2TFM3OTJiNVRtamtZ?=
 =?gb2312?B?UEJUNVJCYVFQZ0FxazNmWm5FRWRCWDZ1MVBya3dVMm0xQWNsaUpvT01GbFBx?=
 =?gb2312?B?VERMT2pKUmR3ei91V3VTbFJ0ZEhiOEpRc3pWeHF3RjhUMkdBWU41YTV6TE5W?=
 =?gb2312?B?aGpHL21qbm02MlMxOXFHL1NjbDJGVzNucnZnK091ejI4NnFPSkZlelJxRk16?=
 =?gb2312?B?RHg5b3FRSE1EenpvSWFOZ1ZPa1lENWRCNzZEM3QxT3Y4WHdVRTUyR095NnpY?=
 =?gb2312?B?V25ZdWVhbWxzZkdWYjJLbkxTV3d0RUVINjY0UlNqZ3R4ZVB1ZEZqSGlLQVdm?=
 =?gb2312?B?cVlFTExGNmo2RXVmRkxOd2QrMno2V0ZkZVJ4UThGYkU3eXR0Z3pUZkFSK2Iv?=
 =?gb2312?B?MFpwWUs1T2VJSWRvcWd6bEZ3TkxUUUM4RG9pNEVnUWtDMmw2c0xHWmR0ZU9F?=
 =?gb2312?B?VTRCNjJxQWV3RU9XQUY4dmVLMWNaUFFLQ3VJMUdrOERCNUt3ZzlYVmhVdFNh?=
 =?gb2312?B?RlVuZm9tQjVRdDJxREI0TXR5VnRjZWtoc1dMZFh1YWNrK3ZoalZ4S21uVmJI?=
 =?gb2312?B?U1FHdk5odjZPa0ZDcWpHcGYzaituVXU5YzFWYnZYd3Z4MlZ4UDRQZlYxVFlH?=
 =?gb2312?B?N0YxUXNGK1FGN2s4UEYwOG96SGpZdm5lN3VHMUErbEVMWXdJNmpvbHBSMkI2?=
 =?gb2312?B?Q2lqR1ptR0xVK2VSTEFIR1FFQU1nODBBMTlONzhwT2hMYzJjMDcxRU9BR0FC?=
 =?gb2312?B?N2NaenYxK0d2SFhrdE01QjE0NC9qeUI1Vk5sUWpwTTBheUM3d3JZS2ViSXdn?=
 =?gb2312?B?amZUOTNTR2pNQ2pyZW8wUUU2VkdvOElZQjlJa1hsNWVpRkRIcG9vRjJ6MTd2?=
 =?gb2312?B?c285Y2RkTk54czlHZ3BCeTJVMjFHdkRHVUMxM1lKZldmZVRxUGk2bHVndHpT?=
 =?gb2312?B?b1hHZTBFZWRpalRWS0FoVjJ0VlU5SlVKVmZxNERqdWV3K1gzSXZobEVYa1J6?=
 =?gb2312?B?azBIZTg1MUxxT2NJNEF4YlJmdTJwMmNVYTVVa2lkVGgyNGQrdjdHamphUUpL?=
 =?gb2312?B?R0NwODVDWFo3c0pic3hRbTBYdll3dzNFbHpuaTgxT09PZnVhSGZRQlNJZnpX?=
 =?gb2312?B?NjNWR09qR0R0RThKOXA5QWN0Ums3VXB4N3l2d1kzUzNQMkU4blRpSXdSMG13?=
 =?gb2312?B?cmZOQ3UwajJlUGpXODAzSVJuVmh4TjdMb1V3V1NJdWVXbkpyUjM4NE9KYjNQ?=
 =?gb2312?B?OXMxL3ZNeHJXaHFJZUc4LzZvY2IzUmtjdC9neHhZdjhOVnVsOUppZjFCSS8z?=
 =?gb2312?B?a29laU4rSTRSbGVtdzh4OU9SNkZzYWJ0VWUxbTlkK3pmR015UEdqYXprM3VF?=
 =?gb2312?B?cFVELzBUUVhtS1hGai9Wd2lrb0pGZHlwWVNBVmNrSHBYZEsreFRBaUhQZ1J6?=
 =?gb2312?B?MllOeG5XeFpUeElPaWpCWkwxc2k3TVQ2MC9lSU9BLzdqQXRodU5XNTczVFJp?=
 =?gb2312?B?RlYvT2hlN01rNDZUekdxOEtmbEFCYW9pVmFwVUV6Rjhtb2FDWFdJNDdWVUZp?=
 =?gb2312?B?VzZIWndrNDhuR1IxejRnYk5TbDlFNGRFYVN6V0xuUXA2Z09VcFkrTzAvVGw3?=
 =?gb2312?B?MldlTk9FRkx5QWhaRlU5WGRrMTZ0T1dFTlYyRExLaFZ2cGVrN1hWK3ZWTm4r?=
 =?gb2312?B?eUR5ckcvRHNJWUd6VGJNTmEvSzg5ZGl6QXhTczFwRmFnd1poYWtEclJBTWhR?=
 =?gb2312?B?em1KSjU0T1RPR21DUlY4cXNtWlJzRkNwcll2WFZZYUNnUCt1NGtWOHZFY2Np?=
 =?gb2312?B?d3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB966913481F3B849D736C277BC4E72TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73146ee4-b8d1-4969-ec53-08dd394fd187
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 12:41:53.6943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz/JKBEpRzUkMpo+Kl6qhf5L9uoc5v0cKGf2NJZeQH9DQP6hk/bDddIIblNf3pKrOFTjRMzeJXss2jy9k2XsPF0USgqNI+NaoTzz/+o5m76jfDw9ubjfWj51q9HUy6s2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14661
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 12:42:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17549

--_000_TYCPR01MB966913481F3B849D736C277BC4E72TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHRoaXMgZGV0YWlsZWQgZXhwbGFuYXRpb24u
IFRoaW5ncyBhcmUgbW9yZSBjbGVhcmVyIG5vdy4NCg0KSnVzdCBhIHNtYWxsIHF1ZXJ5LA0KDQog
ICoNCigqMikgVGhlIG5hbWluZyBpcyByYW5kb20gYnV0IHNob3VsZCBiZSB1bmlxdWUsIGkuZS4s
IHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSBhIGRldmljZSBjYW5ub3QgaGF2ZSB0aGlzIGFzIGFjdHVh
bCBkZXZpY2UgSUQsIHNlZSBteSBhbnN3ZXIgb24gQSBhbmQgQiBhYm92ZSBmb3IgdGhlIHJlYXNv
bmluZy4NCg0KRGlkIHlvdSBtZWFuIG5vIDIgZGV2aWNlcyBzaG91bGQgaGF2ZSB0aGlzIGFzIHRo
ZSBhY3R1YWwgZGV2aWNlIElEID8gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPw0KDQpU
aGFua3MgYW5kIFJlZ2FyZHMsDQpBZGl0aHlhDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCkZyb206IFN0b3JtLCBDaHJpc3RpYW4gPGNocmlzdGlhbi5zdG9ybUBzaWVtZW5z
LmNvbT4NClNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE2LCAyMDI1IDk6MDUgUE0NClRvOiBiYWxh
a3VtYXIgYWRpdGh5YSij1KPTo8mj0CBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10
c2lwLmNvbT4NCkNjOiBkaW5lc2gga3VtYXIoo9Sj06PJo9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxk
aW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGt1bmlqYWRhciBzaGl2YW5hbmQoo9Sj06PJ
o9AgVE1JRUMgT0RHIFBvcnRpbmcpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5j
b20+OyBhc2hyaXRoIHNhaSij1KPTo8mj0CkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNv
bT47IGhheWFzaGkga2F6dWhpcm8owdYgus266iCjxKPNo8UgofCjxKPJo8eh9aPNo9Cj06Hwo82j
0KO0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD47IEtpc3prYSwgSmFuIDxqYW4u
a2lzemthQHNpZW1lbnMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsgb251a2kga29zaGlybyi085JpIIKGy77AyiCh8KPE
o8mj1KPDofWjxKPJo9Sh8KPPo9Oj1CkgPGtvc2hpcm8xLm9udWtpQHRvc2hpYmEuY28uanA+DQpT
dWJqZWN0OiBSZTogW2NpcC1kZXZdIFJlZ2FyZGluZyBzdXBwb3J0IGZvciBXRlggYmFja2VuZCBm
b3Igc29mdHdhcmUgdXBkYXRlcyBpbiBDSVAgSW1hZ2VzDQoNCkhpIEFkaXRoeWEsDQoNCkkgd2Fz
IHJlZmVycmluZyBiYWNrIHRvIGEgZmV3IGlkZWFzIHN1Z2dlc3RlZCBieSB5b3Ugb24gaG93IHdl
IGNhbiBpbnRlZ3JhdGUgV0ZYIGJhY2tlbmQgc3VwcG9ydCBmb3IgaXNhci1jaXAtY29yZS4NCg0K
SW4gdGhlIHByZXZpb3VzIG1haWwgKEFwb2xvZ2llcywgdGhlIGNvbnZlcnNhdGlvbiB3YXMgcXVp
dGUgc29tZSB0aW1lIGFnbyksIHlvdSBoYWQgc3VnZ2VzdGVkIHRvIHVzZSBhbiBvbmJvYXJkaW5n
IHdmeCBjbGllbnQgd2hpY2ggYXBwbGllcyB0aGUgY29uZmlndXJhdGlvbiByZWNvcmRlZCAoZXg6
IGNsaWVudC1pZCBmb3Igc29mdHdhcmUgdXBkYXRlIHVzZSBjYXNlKSBpbiB0aGUgd2Z4IGpvYiBj
cmVhdGVkIGZvciBhIHBhcnRpY3VsYXIgZGV2aWNlLiBOb3csIGZvciB0aGUgb25ib2FyZGluZyB3
ZnggY2xpZW50IHRvIGZldGNoIGEgam9iLCB0aGUgb25ib2FyZGluZyBjbGllbnQgbXVzdCBhbHNv
IGhhdmUgYSBjbGllbnQtaWQgYmVjYXVzZSAgd2Z4IGpvYnMgYXJlIGxpbmtlZCB0byBhIGNsaWVu
dC4NCg0KWWVzLCBpbiBzbyBmYXIgYXMgY2xpZW50cyBxdWVyeSAidGhlaXIiIHdvcmtmbG93IGlu
c3RhbmNlcyAoPSBqb2JzKSBvbiB0aGUgd2Z4LCBpLmUuLCB0aGUgY2xpZW50IElEIGlzIGEgZGlz
Y3JpbWluYXRvciBmb3IgYWxsIGpvYnMgYWN0aXZlIG9uIHdmeC4gVGhlcmUgaXMgqEMgYnkgaW50
ZW50aW9uIKhDIG5vIGJ1aWx0LWluIG1lY2hhbmlzbSBpbiB3ZnggdGhhdCB3b3VsZCBwcmV2ZW50
IGEgY2xpZW50IEEgZnJvbSAidG91Y2hpbmciIGNsaWVudCBCJ3Mgam9icyBhcyB0aGlzIGlzIHdo
YXQgeW91IHdvdWxkIGhhdmUgdG8gd3JpdGUgYSBwbHVnaW4gZm9yIHRoYXQgcHJldmVudHMgc3Vj
aCBiZWhhdmlvciwgYmFzZWQsIGUuZy4sIG9uIGNsaWVudCBjcmVkZW50aWFscyBzZW50IHRvIHdm
eCB3aXRoaW4gdGhlIHJlcXVlc3RzLg0KDQpZb3UgaGFkIHN1Z2dlc3RlZCB0byB1c2UgcGx1Z2lu
cyBpbnNpZGUgd2Z4IHRvIHJvdXRlIHRoZSByZXF1ZXN0IGJhc2VkIG9uIHRoZSBpbmZvcm1hdGlv
biBpbiB0aGUgb25ib2FyZGluZyByZXF1ZXN0J3MgSFRUUCBoZWFkZXIgKGV4OiBzZXJpYWwgbnVt
YmVyKS4NCklzIHRoZSBpZGVhIHRvIHVzZSB0aGUgcGx1Z2lucyB0byByZXR1cm4gYSByZXNwb25z
ZSB3aXRoIHRoZSBjbGllbnQtaWQgYW5kIG9uYm9hcmRpbmcgam9iIGlkIHRvIGJlIHVzZWQgYnkg
dGhlIG9uYm9hcmRpbmcgY2xpZW50PyBPciBhbSBJIG1pc3Rha2VuIGluIG15IHVuZGVyc3RhbmRp
bmcgaGVyZT8NCg0KTm8sIGFsbW9zdCB0aGVyZSA6KSBXaGF0IEkgc3VnZ2VzdGVkIGlzIHRvIGhh
dmUgYW4gb25ib2FyZGluZyB3b3JrZmxvdywgbGV0J3MgY2FsbCBpdCAib25ib2FyZGluZyIuIE5v
dywgYSBmcmVzaCBjbGllbnQgY29ubmVjdHMgdG8gdGhlIHdmeCAoKjEpIGFuZCBxdWVyaWVzIGZv
ciBqb2JzIHdpdGggZGV2aWNlIElEID09ICJvbmJvYXJkaW5nX25ld19kZXZpY2UiICgqMiksIHNl
bmRpbmcgd2l0aCB0aGlzIHJlcXVlc3QgY2xpZW50IGNyZWRlbnRpYWxzLCBpZGVudGlmaWVycywg
c2VyaWFsIG51bWJlcnMsIHlvdSBuYW1lIGl0LiBUaGUgqEMgdG8gYmUgd3JpdHRlbiCoQyB3Zngg
cGx1Z2luIGludGVyY2VwdHMgdGhpcyByZXF1ZXN0LA0KKDEpIGNvbWVzIHVwIHdpdGggdGhlIGRl
dmljZSdzIGFjdHVhbCBkZXZpY2UgSUQgKGUuZy4sIGJ5IHF1ZXJ5aW5nIGFub3RoZXIgc3lzdGVt
KSwNCigyKSBjcmVhdGVzIGFuIGluc3RhbmNlIG9mIHRoZSAib25ib2FyZGluZyIgd29ya2Zsb3cg
Zm9yIHRoaXMgbmV3IGRldmljZSBJRCwgYW5kDQooMykgc2VuZHMgYmFjayB0aGUgbmV3L2FjdHVh
bCBkZXZpY2UgSUQgaW4gaXRzIHJlc3BvbnNlIGJvZHksIHRoZXJlYnkgdGVybWluYXRpbmcgdGhl
IHJlcXVlc3QgdG8gd2Z4LCBpLmUuLCB0aGlzIHF1ZXJ5IGRvZXNuJ3QgcmVhY2ggdGhlIHdmeCwg
aS5lLiwgaXQncyBhbnN3ZXJlZCBhbmQgdGVybWluYXRlZCBieSB0aGUgcGx1Z2luLg0KTm93LCB0
aGUgZGV2aWNlLCBnZXR0aW5nIGl0cyBhY3R1YWwgZGV2aWNlIElEIGluIHRoZSByZXNwb25zZSwg
Y2FuIHF1ZXJ5IHRoZSB3ZnggZm9yIGl0cyByZWFsIG9uYm9hcmRpbmcgam9iIHRoYXQgd2FzIGp1
c3QgY3JlYXRlZCBieSB0aGUgcGx1Z2luLiBXaXRoaW4gdGhpcyB3b3JrZmxvdywgeW91IGNhbiBk
byB3aGF0ZXZlciBpcyBuZWNlc3NhcnkgdG8gYWN0dWFsbHkgb25ib2FyZCB0aGUgbmV3IGRldmlj
ZS4NCg0KSW5zdGVhZCBvZiAoMSkgeW91IGNhbiBhbHNvIGdlbmVyYXRlLCBlLmcuLCBhIFVVSUQg
YW5kIGRvIHRoZSBhY3R1YWwgZGV2aWNlIElEIGluZm9ybWF0aW9uIGdhdGhlcmluZyBpbiB0aGUg
d29ya2Zsb3csIFlNTVYsIGJ1dCB0aGlzIGlzIHRoZSBnZW5lcmFsIHByb2NlZHVyZSBob3cgdG8g
cmVhbGl6ZSB0aGlzIHdpdGggd2Z4Lg0KDQooKjEpIFlvdSBjb3VsZCBmb3IgZXhhbXBsZSByZWdp
c3RlciBhIEROUyB1cGRhdGUuY2lwLXByb2plY3Qub3JnPGh0dHA6Ly91cGRhdGUuY2lwLXByb2pl
Y3Qub3JnPiB0aGF0IHBvaW50cyB0byB0aGUgd2Z4IGluc3RhbmNlIHRoaXMgZGV2aWNlIHNob3Vs
ZCBpbml0aWFsbHkgY29ubmVjdCB0by4gVGhpcyBpbmZvcm1hdGlvbiBpcyB0aGVuIGJ1cm5lZCBp
bnRvIHRoZSByb290ZnMgYW5kIGRlcGVuZGluZyBvbiBuZXR3b3JrL0ROUyBzZXR1cCwgeW91IGNh
biBwb2ludCBkZXZpY2VzIHRvIGRpZmZlcmVudCB3ZnggaW5zdGFuY2VzIGJ5IHRoZSBETlMgcmVz
b2x1dGlvbiB0byBJUC4NCigqMikgVGhlIG5hbWluZyBpcyByYW5kb20gYnV0IHNob3VsZCBiZSB1
bmlxdWUsIGkuZS4sIHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSBhIGRldmljZSBjYW5ub3QgaGF2ZSB0
aGlzIGFzIGFjdHVhbCBkZXZpY2UgSUQsIHNlZSBteSBhbnN3ZXIgb24gQSBhbmQgQiBhYm92ZSBm
b3IgdGhlIHJlYXNvbmluZy4NCg0KDQpLaW5kIHJlZ2FyZHMsDQpDaHJpc3RpYW4NCg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBvbiBiZWhhbGYgb2YgQ2hy
aXN0aWFuIFN0b3JtIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNocmlzdGlhbi5zdG9ybT1z
aWVtZW5zLmNvbUBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQpTZW50OiBUdWVzZGF5LCBKdWx5IDIs
IDIwMjQgMjo0NCBQTQ0KVG86IGJhbGFrdW1hciBhZGl0aHlhKKPUo9OjyaPQIFRFVVIpIDxBZGl0
aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPg0KQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz47IGRpbmVzaCBrdW1hciij
1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29t
Pjsga3VuaWphZGFyIHNoaXZhbmFuZCij1KPTo8mj0CBUTUlFQyBPREcgUG9ydGluZykgPFNoaXZh
bmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGFzaHJpdGggc2FpKKPUo9OjyaPQKSA8
U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjB1iC6zbrq
IKPEo82jxSCh8KPEo8mjx6H1o82j0KPTofCjzaPQo7QpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3No
aWJhLmNvLmpwPjsgS2lzemthLCBKYW4gPGphbi5raXN6a2FAc2llbWVucy5jb20+DQpTdWJqZWN0
OiBSZTogW2NpcC1kZXZdIFJlZ2FyZGluZyBzdXBwb3J0IGZvciBXRlggYmFja2VuZCBmb3Igc29m
dHdhcmUgdXBkYXRlcyBpbiBDSVAgSW1hZ2VzDQoNCkhpIEFkaXRoeWEsDQoNCkJhc2VkIG9uIHdo
YXQgeW91IGV4cGxhaW5lZCwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZXJlIHdvdWxkIGJl
IHNvbWUgc2VydmljZSAvIHNjcmlwdCB0aGF0IHdvdWxkIHJ1biB1cG9uIGltYWdlIGJvb3QgKHBy
b2JhYmx5IGZpcnN0IGJvb3QpLCB0byBjb21tdW5pY2F0ZQ0Kd2l0aCB0aGUgYmFja2VuZCAob24t
Ym9hcmRpbmcpIHNlcnZlci4gVGhlIG9uLWJvYXJkaW5nIHNlcnZlciB3b3VsZCByZXNwb25kIHdp
dGggdGhlIGRldGFpbHMgbGlrZSBkZXZpY2UtaWQgZXRjLiB1cG9uIHN1Y2Nlc3NmdWwgcmVnaXN0
cmF0aW9uIG9mIHRoZSBkZXZpY2UuDQoNClllcywgdGhhdCBpcyBvbmUgb3B0aW9uLiBZb3UgcG93
ZXIgb24gdGhlIGRldmljZSBhbmQsIG9uY2UgaXQncyBjb25uZWN0ZWQsIGl0IHNlY3VyZWx5IGZl
dGNoZXMgaXRzIGNvbmZpZ3VyYXRpb24gZGF0YSBmcm9tIGFuIG9uLWJvYXJkaW5nIGJhY2tlbmQg
c2VydmljZSwgcHJvYmFibHkgd2l0aCB0aGUgZGV2aWNlIGJlaW5nIGF1dGhlbnRpY2F0ZWQgYnkg
c29tZSBodW1hbiBpbiB0aGUgbG9vcCBjbG9zZSB0byB0aGUgbWFjaGluZS4gT3IgdGhpcyB0ZWNo
bmljaWFuIHBsdWdzIGluIGEgdHJ1c3RlZCBVU0IgU3RpY2sgb3IgLi4uIFRoZXJlIGFyZSBtYW55
IG9wdGlvbnMgd2l0aCBzb21lIGJldHRlci93b3JzZSB0aGFuIHRoZSBvdGhlcnMgZGVwZW5kaW5n
IG9uIHlvdXIgdXNlIGNhc2UgYW5kIGRlbWFuZHMuIEFsbCBvZiB0aG9zZSBhcmUgZGVwbG95ZWQg
aW4gdGhlIGZpZWxkLCBmb3Igc3VyZSA6KQ0KDQpBbnl3YXksIGFsbCBvZiB0aGVtIGhhdmUgaW4g
Y29tbW9uIHRoYXQgdGhlIGRldmljZSBnZXRzIGl0cyBjb25maWd1cmF0aW9uIGRhdGEgc29tZWhv
dyBhbmQgZnJvbSB0aGVyZW9uIGlzIHJlZ2lzdGVyZWQgYW5kIGNhbiBtYWtlIGF1dGhlbnRpY2F0
ZWQgdXNlIG9mIHRoZSAob3RoZXIpIGJhY2tlbmQgc2VydmljZXMsIGlnbm9yaW5nIHJlLWF1dGhl
bnRpY2F0aW9uLg0KDQoNClNvLCB0byBhY2hpZXZlIGEgbWVhbmluZ2Z1bCBpbnRlZ3JhdGlvbiBv
ZiBXRlggd2l0aCBDSVAgSW1hZ2VzLCB3ZSBoYXZlIHRvIG5vdyBzdXBwb3J0IHRoaXMgb24tYm9h
cmRpbmcgcHJvY2VzcyBhcyB3ZWxsICh3aGljaCB3b3VsZCBtZWFuIGhhdmluZyBhbiBvbi1ib2Fy
ZGluZyBzZXJ2ZXIgZXRjLik/IE9yIGlzIHRoZXJlIGFub3RoZXIgd2F5IHRvIGFjaGlldmUgdGhp
cyBpbnRlZ3JhdGlvbj8gIFdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB5b3VyIG9waW5pb24gb24g
dGhpcy4NCg0KV2VsbCwgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGVyZSBhcmUgc28gbWFueSB3YXlz
IHRvIG9uYm9hcmQgZGV2aWNlcyBhbmQgZXZlbiBzdGFuZGFyZHMsIGUuZy4sIGh0dHBzOi8vZmlk
b2FsbGlhbmNlLm9yZy9kZXZpY2Utb25ib2FyZGluZy8gKyBTZWN1cmUgRGV2aWNlIE9uYm9hcmRp
bmcgKFNETykuIFNvLCBvbmUgd2F5IG9mIGRvaW5nIHRoaXMgaXMgdG8gYmxlc3Mgc29tZSBzb2x1
dGlvbiBhcyBDSVAgc3RhbmRhcmQgYW5kIGludGVncmF0ZSB0aGF0IChpbmNsdWRpbmcgaGF2aW5n
IGEgcnVubmluZyBzZXJ2aWNlIGZvciBkZW1vaW5nIHRoZSBzb2x1dGlvbikuIEhvd2V2ZXIsIEkg
dGhpbmsgaXQncyBiZXR0ZXIgdG8gc2lkZS1zdGVwIHRoZSBwcm9ibGVtOiBzaG93Y2FzZSB0aGUg
aW50ZWdyYXRpb24gb2YgYW4goaogZXZlbiBjb250cml2ZWQgoaogb25ib2FyZGluZyBtZWNoYW5p
c20gaW50byB3aGljaCByZWFsIG9uZXMgY2FuIGJlIGhvb2tlZCBpbnRvIGVhc2lseS4NCg0KU28s
IGFzc3VtaW5nIHdlIGRvIG9uYm9hcmRpbmcgc3VwcG9ydGVkIGJ5IGFuIG9uYm9hcmRpbmcgYmFj
a2VuZCBzZXJ2aWNlLCB3ZSBuZWVkIHRvIGtub3cvZGVmaW5lIGhvdyB0aGlzIG9uYm9hcmRpbmcg
c2VydmljZSBjYW4gYmUgcmVhY2hlZCBieSB0aGUgZGV2aWNlIGFuZCB3aGF0IGNvbmZpZ3VyYXRp
b24gZGF0YSBpcyB0byBiZSBwdXQgd2hlcmUgb24gdGhlIGRldmljZSChqiB0aGUgbGF0dGVyIGlz
IHRvIGJlIGRvbmUgY3VzdG9tIGFueXdheSwgcmVnYXJkbGVzcyBvZiB3aGF0IHNvbHV0aW9uIHdl
IGNob29zZS4gVGhpcyBtZWFucywgd2UgYmFrZSBhIChkZWZhdWx0LCBlLmcuLCBkZWZpbmVkIGJ5
IGEgYml0YmFrZSB2YXJpYWJsZSkgYmFja2VuZCBzZXJ2aWNlIElQIGFkZHJlc3MvRE5TIG5hbWUg
aW50byB0aGUgQ0lQIGltYWdlLiBUaGlzIG1heSBiZSBvdmVycmlkZGVuIG1hbnVhbGx5IGluIHRo
ZSBmaWVsZCBidXQgd2UgbmVlZCB0byBoYXZlIGEgc2FuZSBkZWZhdWx0LiBQcm9iYWJseSwgeW91
IHdvdWxkIHdhbnQgdG8gYmFrZSBpbiBvdGhlciBjcmVkZW50aWFsIGRhdGEgdG8gZW5hYmxlIHNl
Y3VyZS90cnVzdGVkIGNvbW11bmljYXRpb24gYnV0IGxldCdzIGlnbm9yZSB0aGF0IGZvciBub3cu
IFRoZW4sIG9uIG9uYm9hcmRpbmcsIHRoZSBkZXZpY2UgZmV0Y2hlcyB0aGUgY29uZmlndXJhdGlv
biBkYXRhIGZyb20gdGhlIGJhY2tlbmQgc2VydmljZSBpbiB3aGF0ZXZlciBmb3JtYXQgYW5kIGEg
Y3VzdG9tIGNvZGUgc25pcHBldCBwbGFjZXMgdGhpcyBjb25maWd1cmF0aW9uIGluZm9ybWF0aW9u
IG9uIHRoZSBkZXZpY2Ugd2hlcmUgYXBwcm9wcmlhdGUgKHJlYWQ6IC9ldGMvc3d1cGRhdGUuY2Zn
LCAvZXRjLzx3aGF0ZXZlcj4sIC4uLikuDQoNClRoaXMgY2FuIGJlIHBlcmZlY3RseSBtb2RlbGVk
IHdpdGggYW4gb25ib2FyZGluZyB3b3JrZmxvdyBpbiB0aGUgZXhpc3Rpbmcgd2Z4IHdlIHVzZSBm
b3IgZmlybXdhcmUgdXBkYXRlcyA6KSChqiB3ZSBqdXN0IG5lZWQgYW4gb25ib2FyZGluZyB3Zngg
Y2xpZW50IHRoYXQgdGFsa3MgdG8gdGhlIHdmeCByZWFjaGFibGUgdW5kZXIgdGhlIChkZWZhdWx0
IG9yIGFkYXB0ZWQpIElQL0ROUyBuYW1lIGFuZCBhcHBsaWVzIHRoZSBjb25maWd1cmF0aW9uIHJl
Y29yZGVkIGluIHRoZSB3Znggam9iIGNyZWF0ZWQgZm9yIGEgcGFydGljdWxhciBkZXZpY2UuIEdy
YW50ZWQsIG9uZSBjYW4gYm9sdCBvbiBzZWN1cml0eSBtZWFzdXJlcyBidXQgZm9yIGRlbW9pbmcg
dGhpcywgd2UgY2FuIGtlZXAgaXQgc2ltcGxlIGluaXRpYWxseS4gTm93LCBob3cgZG9lcyB0aGlz
IG9uYm9hcmRpbmctd2Z4LWNsaWVudCBrbm93IHdoYXQgam9iIChJRCkgdG8gYXNrIHRoZSB3Zngg
Zm9yPyBPbmUgY291bGQgaW1hZ2luZSBhbm90aGVyIHNlcnZpY2UgdGhhdCByZXR1cm5zIHRoZSB3
Znggam9iIElEIGZvciBhIHBhcnRpY3VsYXIgZGV2aWNlIGRlcGVuZGluZyBvbiB0aGUgZGF0YSBp
dCBzZW5kcyB3aXRoIHRoZSBmaXJzdCBvbmJvYXJkaW5nIHJlcXVlc3QgdG8gdGhpcyBzZXJ2aWNl
IChlLmcuLCBzZXJpYWwgbnVtYmVyLCAuLi4sIGkuZS4sIGFueXRoaW5nIHRoYXQgaXMgaW5kaXZp
ZHVhbCB0byBhIGRldmljZSkuIFRvIGtlZXAgaXQgc2ltcGxlLCBhbmQgc3BhcmluZyB0aGUgZXh0
cmEgc2VydmljZSwgeW91IGNhbiBzZW5kIHRoYXQgaW5mb3JtYXRpb24gaW4gdGhlIG9uYm9hcmRp
bmctd2Z4LWNsaWVudCByZXF1ZXN0J3MgSFRUUCBoZWFkZXIgYW5kIHVzZSBwbHVnaW5zICggaHR0
cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvd2Z4L2Jsb2IvbWFpbi9kb2NzL29wZXJhdGlvbnMubWQj
cGx1Z2lucykgdG8gKHJlLSlyb3V0ZSBhY2NvcmRpbmdseS4NCmhpcyB3YXksIHlvdSdyZSBub3Qg
dXJnZWQgdG8gY3JlYXRlIGluZGl2aWR1YWwgQ0lQIGltYWdlcyBidXQgdGhleSBnZXQgdGhlaXIg
ImlkZW50aXR5IiB3aGlsZSBvbmJvYXJkaW5nIHdpdGgganVzdCBwcm92aWRpbmcgdGhlIGNhbm9u
aWNhbCBmYWxsYmFjayBJUC9ETlMgbmFtZSBmb3IgdGhlIG9uYm9hcmRpbmcgc2VydmVyLg0KDQpO
b3csIGFsbCB0aGF0IGNhbiBiZSBkb25lIGluIFNXVXBkYXRlIGFzIHdlbGwgc28gdGhhdCBvbmJv
YXJkaW5nIGNhbiBiZSBoYW5kbGVkIGp1c3QgbGlrZSBhIGZpcm13YXJlIHVwZGF0ZS4gVGhlbiwg
aG93ZXZlciwgaG9va2luZyBleGlzdGluZyBzb2x1dGlvbnMgaW50byB0aGlzIG1lY2hhbmlzbSBi
ZWNvbWVzIGEgYml0IGhhcmRlci4uLi4NCg0KDQpBcG9sb2dpZXMgaWYgbXkgdW5kZXJzdGFuZGlu
ZyBpcyB3cm9uZy4NCg0KVGhhbmtzIGZvciByZWFkaW5nIHRoaXMgbG9uZ2lzaCBhbnN3ZXIuLi4g
YW5kIEkgaG9wZSB0aGlzIGhhcyBoZWxwZWQ/IDopDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFN0b3JtLCBDaHJpc3RpYW4gPGNocmlzdGlhbi5zdG9ybUBzaWVtZW5zLmNv
bT4NClNlbnQ6IFRodXJzZGF5LCBKdW5lIDI3LCAyMDI0IDE6NDcgQU0NClRvOiBiYWxha3VtYXIg
YWRpdGh5YSij1KPTo8mj0CBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNv
bT4NCkNjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgZGluZXNoIGt1bWFyKKPUo9Oj
yaPQIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBr
dW5pamFkYXIgc2hpdmFuYW5kKKPUo9OjyaPQIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5k
Lkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPjsgYXNocml0aCBzYWkoo9Sj06PJo9ApIDxTYWku
U2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKMHWILrNuuogo8Sj
zaPFIKHwo8SjyaPHofWjzaPQo9Oh8KPNo9CjtCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEu
Y28uanA+OyBLaXN6a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClN1YmplY3Q6IFJl
OiBbY2lwLWRldl0gUmVnYXJkaW5nIHN1cHBvcnQgZm9yIFdGWCBiYWNrZW5kIGZvciBzb2Z0d2Fy
ZSB1cGRhdGVzIGluIENJUCBJbWFnZXMNCg0KSGksDQoNClRoZSBtYW5kYXRvcnkgY29uZmlncyB0
aGF0IGFyZSByZXF1aXJlZCBhcmUgdGhlIHdmeCBzZXJ2ZXIgKGJhY2tlbmQpIFVSTCBhbmQgdGhl
IGNsaWVudC1pZC4gQXMgcGVyIHlvdXIgc3VnZ2VzdGlvbiwgZm9yIHRoZSBiYWNrZW5kIFVSTCwg
cHJvdmlkaW5nIGEga2NvbmZpZyB2YXJpYWJsZSBzbyB0aGF0IHVzZXJzIGNvdWxkIGVudGVyIHRo
YXQgdmFsdWUgYmVmb3JlIHRoZSBidWlsZCBzZWVtcyBhIGxpa2UgZ29vZCBhcHByb2FjaC4NCg0K
VGhpcyB3b3VsZCBiZSB0aGUgaGFyZHdpcmVkIGRlZmF1bHQgZm9yIHRoZSB1cHN0cmVhbSB3Zngg
c2VydmVyIFtzZWUgYmVsb3ddLg0KDQoNCkhvd2V2ZXIsIEN1cnJlbnRseSBJIGFtIG5vdCBjbGVh
ciBhYm91dCBzZXR0aW5nIHRoZSBjbGllbnQtaWQuIFRoZSBjbGllbnQtaWQgaXMgcmVxdWlyZWQg
Ynkgd2Z4IHdoaWxlIGNyZWF0aW5nIHRoZSBqb2JzIGZvciB0aGUgc3BlY2lmaWMgY2xpZW50cyBh
bmQgYWxzbyB0byBtb25pdG9yIHRoZSBzdGF0dXMgb2YgZWFjaCBjbGllbnQgZGV2aWNlIChsaWtl
IHVwZGF0ZSBzdGF0dXMgZXRjLikNCg0KWWVzLg0KDQoNClNldHRpbmcgYSBjbGllbnQtaWQgYWxz
byB2aWEgYSBrY29uZmlnIHZhcmlhYmxlIHdvdWxkIG1lYW4gYmUgdG8gYnVpbGQgYSBuZXcgaW1h
Z2UgZm9yIGV2ZXJ5IG5ldyBjbGllbnQtaWQgd2hpY2ggZG9lc24ndCBzZWVtIGxpa2UgYSByZWFz
b25hYmxlIHNvbHV0aW9uIGZvciBwcm9kdWN0aW9uLg0KDQpFeGFjdGx5Lg0KDQoNCkkgYW0gbm90
IHZlcnkgZmFtaWxpYXIgd2l0aCBob3cgc3VjaCBkZXZpY2UgcmVnaXN0cmF0aW9uIC8gaWRlbnRp
ZmljYXRpb24gcmVxdWlyZW1lbnRzIGFyZSBoYW5kbGVkIGluIGEgcHJvZHVjdGlvbiBlbnZpcm9u
bWVudC4gRG8geW91IGhhdmUgYW55IHBvaW50ZXJzIGluIHRoaXMgcmVnYXJkPw0KDQpVc3VhbGx5
LCB5b3UgaGF2ZSBlbmdyYXZlZCBpbiB0aGUgImdvbGRlbiBpbWFnZSIgc2FuZSBkZWZhdWx0cyB0
aGF0IHlvdSB3b3VsZCB3YW50IHRvIHJvbGwtb3V0IHRvIGFsbCB5b3VyIGRldmljZXMuIFRoZW4s
IGluZGl2aWR1YWxpemluZyB0aGUgZGV2aWNlIGlzIGRvbmUgYnkgb25ib2FyZGluZyBpdCB0byBz
b21lIGRldmljZSBtYW5hZ2VtZW50IGJhY2tlbmQuIFdoaWxlIHRoaXMgcHJvY2VzcywgdGhlIGRl
dmljZSBnZXRzIGFuIElEIGFuZCBpcyBoZW5jZWZvcnRoIGtub3duIHRvIHRoZSBkZXZpY2UgbWFu
YWdlbWVudC4gQWxzbyB3aGlsZSB0aGlzIHByb2Nlc3MsIHlvdSBjYW4gZG8gZnVydGhlciB0aGlu
Z3MgdGhhdCBhcmUgZGV2aWNlLXNwZWNpZmljLCBpLmUuLCBjb25maWd1cmluZyBTV1VwZGF0ZSB0
byB1c2UgYW4gaW5kaXZpZHVhbCBjbGllbnQtaWQgZm9yIHdmeC4gTm90ZSB0aGF0IHRoZXJlIGFy
ZSBtYW55IHdheXMgb2YgaG93IHRvIGFjdHVhbGx5IG9uYm9hcmQgYSBkZXZpY2UgYnV0IHRoZSBw
cmluY2lwbGUgcmVtYWlucy4NCg0KDQotLQ0KRHIuIENocmlzdGlhbiBTdG9ybQ0KU2llbWVucyBB
RywgRlQgUlBEIENFRA0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMsIDg1NzQ4IEdhcmNo
aW5nLCBHZXJtYW55DQoNCg==

--_000_TYCPR01MB966913481F3B849D736C277BC4E72TYCPR01MB9669jpnp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Christian,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
Thanks for this detailed explanation. Things are more clearer now.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Just a small query,&nbsp;</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:4}" style=3D"text-align: left; flex-direction: colu=
mn; display: flex;">
<li style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot;S=
egoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica N=
eue&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); align-self: st=
art; margin-right: 0px; margin-left: 0px; list-style-type: &quot;&#10146; &=
quot;;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin-top: 0px; margin-bottom: 0px;">
(*2) The naming is random but should be unique, i.e., you need to make sure=
 a device cannot have this as actual device ID, see my answer on A and B ab=
ove for the reasoning.</div>
</li></ul>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Did you mean no 2 devices should have this as the actual device ID ? Or am =
I missing&nbsp;something here?<br>
<br>
Thanks and Regards,<br>
Adithya</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr" style=3D"color: inherit;"><span style=
=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
"><b>From:</b>&nbsp;Storm, Christian &lt;christian.storm@siemens.com&gt;<br=
>
<b>Sent:</b>&nbsp;Thursday, January 16, 2025 9:05 PM<br>
<b>To:</b>&nbsp;balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithy=
a.Balakumar@toshiba-tsip.com&gt;<br>
<b>Cc:</b>&nbsp;dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TMIEC ODG Porting) &l=
t;dinesh.kumar@toshiba-tsip.com&gt;; kunijadar shivanand(=A3=D4=A3=D3=A3=C9=
=A3=D0 TMIEC ODG Porting) &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; ash=
rith sai(=A3=D4=A3=D3=A3=C9=A3=D0) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; =
hayashi kazuhiro(=C1=D6 =BA=CD=BA=EA =A3=C4=A3=CD=A3=C5 =A1=F0=A3=C4=A3=C9=
=A3=C7=A1=F5=A3=CD=A3=D0=A3=D3=A1=F0=A3=CD=A3=D0=A3=B4)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; Kiszka, Jan &lt;jan.kiszka@siemen=
s.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; onuki koshiro(=B4=F3=92i =82=86=CB=BE=C0=CA =A1=F0=A3=C4=A3=C9=A3=D4=
=A3=C3=A1=F5=A3=C4=A3=C9=A3=D4=A1=F0=A3=CF=A3=D3=A3=D4) &lt;koshiro1.onuki@=
toshiba.co.jp&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] Regarding support for WFX backend for so=
ftware updates in CIP Images</span>
<div>&nbsp;</div>
</div>
<div>Hi Adithya,</div>
<div><br>
</div>
<blockquote>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt;">
I was referring back to a few ideas suggested by you on how we can integrat=
e WFX backend support for isar-cip-core.</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 11pt;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 11pt;">
In the previous mail (Apologies, the conversation was quite some time ago),=
 you had suggested to use an onboarding wfx client which applies the config=
uration recorded (ex: client-id for software update use case) in the wfx jo=
b created for a particular device.
 Now, for the onboarding wfx client to fetch a job, the onboarding client m=
ust also have a client-id because &nbsp;wfx jobs are linked to a client.</d=
iv>
</blockquote>
<div><br>
</div>
<div>Yes, in so far as clients query &quot;their&quot; workflow instances (=
=3D jobs) on the wfx, i.e., the client ID is a discriminator for all jobs a=
ctive on wfx. There is =A8C by intention =A8C no built-in mechanism in wfx =
that would prevent a client A from &quot;touching&quot; client
 B's jobs as this is what you would have to write a plugin for that prevent=
s such behavior, based, e.g., on client credentials sent to wfx within the =
requests.</div>
<br>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 11pt;">
You had suggested to use plugins inside wfx to route the request based on t=
he information in the onboarding request's HTTP header (ex: serial number).=
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 11pt;">
Is the idea to use the plugins to return a response with the client-id and =
onboarding job id to be used by the onboarding client? Or am I mistaken in =
my understanding here?</div>
</blockquote>
<div><br>
</div>
<div>No, almost there :) What I suggested is to have an onboarding workflow=
, let's call it &quot;onboarding&quot;. Now, a fresh client connects to the=
 wfx (*1) and queries for jobs with device ID =3D=3D &quot;onboarding_new_d=
evice&quot; (*2), sending with this request client credentials,
 identifiers, serial numbers, you name it. The =A8C to be written =A8C wfx =
plugin intercepts this request,&nbsp;</div>
<div>(1) comes up with the device's actual device ID (e.g., by querying ano=
ther system),</div>
<div>(2) creates an instance of the &quot;onboarding&quot; workflow for thi=
s new device ID, and</div>
<div>(3) sends back the new/actual device ID in its response body, thereby =
terminating the request to wfx, i.e., this query doesn't reach the wfx, i.e=
., it's answered and terminated by the plugin.</div>
<div>Now, the device, getting its actual device ID in the response, can que=
ry the wfx for its real onboarding job that was just created by the plugin.=
 Within this workflow, you can do whatever is necessary to actually onboard=
 the new device.</div>
<div><br>
</div>
<div>Instead of (1) you can also generate, e.g., a UUID and do the actual d=
evice ID information gathering in the workflow, YMMV, but this is the gener=
al procedure how to realize this with wfx.</div>
<div><br>
</div>
<div>(*1) You could for example register a DNS <a href=3D"http://update.cip=
-project.org" id=3D"OWAb068399b-6507-8f24-0c5e-136172ef978e" class=3D"OWAAu=
toLink" data-auth=3D"NotApplicable">
update.cip-project.org</a>&nbsp;that points to the wfx instance this device=
 should initially connect to. This information is then burned into the root=
fs and depending on network/DNS setup, you can point devices to different w=
fx instances by the DNS resolution to
 IP.</div>
<div class=3D"elementToProof">(*2) The naming is random but should be uniqu=
e, i.e., you need to make sure a device cannot have this as actual device I=
D, see my answer on A and B above for the reasoning.</div>
<div><br>
</div>
<div><br>
</div>
<div>Kind regards,</div>
<div>Christian</div>
<div><br>
</div>
<div><br>
</div>
<blockquote>
<hr style=3D"text-align: left; text-indent: 0px; display: inline-block; wid=
th: 638.953px;">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr" style=3D"font-family: SFProText-Reg=
ular; font-size: 14px; text-decoration: none; color: inherit;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt;"><b>From:=
</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&g=
t; on behalf of Christian Storm via lists.cip-project.org &lt;christian.sto=
rm=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, July 2, 2024 2:44 PM<br>
<b>To:</b>&nbsp;balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithy=
a.Balakumar@toshiba-tsip.com&gt;<br>
<b>Cc:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TMIEC ODG Porting) &lt;dine=
sh.kumar@toshiba-tsip.com&gt;; kunijadar shivanand(=A3=D4=A3=D3=A3=C9=A3=D0=
 TMIEC ODG Porting) &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; ashrith s=
ai(=A3=D4=A3=D3=A3=C9=A3=D0) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;;
 hayashi kazuhiro(=C1=D6 =BA=CD=BA=EA =A3=C4=A3=CD=A3=C5 =A1=F0=A3=C4=A3=C9=
=A3=C7=A1=F5=A3=CD=A3=D0=A3=D3=A1=F0=A3=CD=A3=D0=A3=B4) &lt;kazuhiro3.hayas=
hi@toshiba.co.jp&gt;; Kiszka, Jan &lt;jan.kiszka@siemens.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] Regarding support for WFX backend for so=
ftware updates in CIP Images</span>
<div>&nbsp;</div>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Hi Adithya,</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Based on what you explained, my understanding is that there would be some s=
ervice / script that would run upon image boot (probably first boot), to co=
mmunicate&nbsp;<br>
with the backend (on-boarding) server. The on-boarding server would respond=
 with the details like device-id etc. upon successful registration of the d=
evice.</div>
</blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Yes, that is one option. You power on the device and, once it's connected, =
it securely fetches its configuration data from an on-boarding backend serv=
ice, probably with the device being authenticated by some human in the loop=
 close to the machine. Or this technician
 plugs in a trusted USB Stick or ... There are many options with some bette=
r/worse than the others depending on your use case and demands. All of thos=
e are deployed in the field, for sure :)</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Anyway, all of them have in common that the device gets its configuration d=
ata somehow and from thereon is registered and can make authenticated use o=
f the (other) backend services, ignoring re-authentication.</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
So, to achieve a meaningful integration of WFX with CIP Images, we have to =
now support this on-boarding process as well (which would mean having an on=
-boarding server etc.)? Or is there another way to achieve this integration=
? &nbsp;Would like to understand your
 opinion on this.</div>
</blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Well, the problem is that there are so many ways to onboard devices and eve=
n standards, e.g.,
<a href=3D"https://fidoalliance.org/device-onboarding/" id=3D"OWA24bf85de-d=
11a-19f9-0310-6fdab3560ed5" class=3D"OWAAutoLink" data-auth=3D"NotApplicabl=
e">
https://fidoalliance.org/device-onboarding/</a>&nbsp;+ Secure Device Onboar=
ding (SDO). So, one way of doing this is to bless some solution as CIP stan=
dard and integrate that (including having a running service for demoing the=
 solution). However, I think it's better
 to side-step the problem: showcase the integration of an =A1=AA even contr=
ived =A1=AA onboarding mechanism into which real ones can be hooked into ea=
sily.&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
So, assuming we do onboarding supported by an onboarding backend service, w=
e need to know/define how this onboarding service can be reached by the dev=
ice and what configuration data is to be put where on the device =A1=AA the=
 latter is to be done custom anyway,
 regardless of what solution we choose. This means, we bake a (default, e.g=
., defined by a bitbake variable) backend service IP address/DNS name into =
the CIP image. This may be overridden manually in the field but we need to =
have a sane default. Probably, you
 would want to bake in other credential data to enable secure/trusted commu=
nication but let's ignore that for now. Then, on onboarding, the device fet=
ches the configuration data from the backend service in whatever format and=
 a custom code snippet places this
 configuration information on the device where appropriate (read: /etc/swup=
date.cfg, /etc/&lt;whatever&gt;, ...).</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
This can be perfectly modeled with an onboarding workflow in the existing w=
fx we use for firmware updates :) =A1=AA we just need an onboarding wfx cli=
ent that talks to the wfx reachable under the (default or adapted) IP/DNS n=
ame and applies the configuration recorded
 in the wfx job created for a particular device. Granted, one can bolt on s=
ecurity measures but for demoing this, we can keep it simple initially. Now=
, how does this onboarding-wfx-client know what job (ID) to ask the wfx for=
? One could imagine another service
 that returns the wfx job ID for a particular device depending on the data =
it sends with the first onboarding request to this service (e.g., serial nu=
mber, ..., i.e., anything that is individual to a device). To keep it simpl=
e, and sparing the extra service,
 you can send that information in the onboarding-wfx-client request's HTTP =
header and use plugins (
<a href=3D"https://github.com/siemens/wfx/blob/main/docs/operations.md#plug=
ins" id=3D"OWAe9ab7326-5fd1-8f74-e901-a4ef70f137ce" class=3D"OWAAutoLink" d=
ata-auth=3D"NotApplicable">
https://github.com/siemens/wfx/blob/main/docs/operations.md#plugins</a>)&nb=
sp;to (re-)route accordingly.&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
his way, you're not urged to create individual CIP images but they get thei=
r &quot;identity&quot; while onboarding with just providing the canonical f=
allback IP/DNS name for the onboarding server.</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Now, all that can be done in SWUpdate as well so that onboarding can be han=
dled just like a firmware update. Then, however, hooking existing solutions=
 into this mechanism becomes a bit harder....</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Apologies if my understanding is wrong.</div>
</blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Thanks for reading this longish answer... and I hope this has helped? :)</d=
iv>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
<br>
</div>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
-----Original Message-----<br>
From: Storm, Christian &lt;christian.storm@siemens.com&gt;&nbsp;<br>
Sent: Thursday, June 27, 2024 1:47 AM<br>
To: balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithya.Balakumar@=
toshiba-tsip.com&gt;<br>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=A3=D4=A3=D3=A3=C9=A3=D0 TM=
IEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; kunijadar shivanand=
(=A3=D4=A3=D3=A3=C9=A3=D0 TMIEC ODG Porting) &lt;Shivanand.Kunijadar@toshib=
a-tsip.com&gt;; ashrith sai(=A3=D4=A3=D3=A3=C9=A3=D0) &lt;Sai.Sathujoda@tos=
hiba-tsip.com&gt;; hayashi kazuhiro(=C1=D6
 =BA=CD=BA=EA =A3=C4=A3=CD=A3=C5 =A1=F0=A3=C4=A3=C9=A3=C7=A1=F5=A3=CD=A3=D0=
=A3=D3=A1=F0=A3=CD=A3=D0=A3=B4) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; Ki=
szka, Jan &lt;jan.kiszka@siemens.com&gt;<br>
Subject: Re: [cip-dev] Regarding support for WFX backend for software updat=
es in CIP Images<br>
<br>
Hi,<br>
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
The mandatory configs that are required are the wfx server (backend) URL an=
d the client-id. As per your suggestion, for the backend URL, providing a k=
config variable so that users could enter that value before the build seems=
 a like good approach.</div>
</blockquote>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
This would be the hardwired default for the upstream wfx server [see below]=
.<br>
<br>
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
However, Currently I am not clear about setting the client-id. The client-i=
d is required by wfx while creating the jobs for the specific clients and a=
lso to monitor the status of each client device (like update status etc.)</=
div>
</blockquote>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
Yes.<br>
<br>
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
Setting a client-id also via a kconfig variable would mean be to build a ne=
w image for every new client-id which doesn't seem like a reasonable soluti=
on for production.</div>
</blockquote>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
Exactly.<br>
<br>
<br>
</div>
<blockquote>
<div style=3D"text-align: left; text-indent: 0px; font-family: SFProText-Re=
gular; font-size: 14px;">
I am not very familiar with how such device registration / identification r=
equirements are handled in a production environment. Do you have any pointe=
rs in this regard?</div>
</blockquote>
<div style=3D"text-align: left; font-family: SFProText-Regular; font-size: =
14px;"><br>
Usually, you have engraved in the &quot;golden image&quot; sane defaults th=
at you would want to roll-out to all your devices. Then, individualizing th=
e device is done by onboarding it to some device management backend. While =
this process, the device gets an ID and is
 henceforth known to the device management. Also while this process, you ca=
n do further things that are device-specific, i.e., configuring SWUpdate to=
 use an individual client-id for wfx. Note that there are many ways of how =
to actually onboard a device but
 the principle remains.</div>
</blockquote>
</blockquote>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; color: rg=
b(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; color: rg=
b(0, 0, 0);">
<br>
--&nbsp;<br>
Dr. Christian Storm<br>
Siemens AG, FT RPD CED</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; color: rg=
b(0, 0, 0);">
Friedrich-Ludwig-Bauer-Str. 3,&nbsp;85748 Garching,&nbsp;Germany</div>
<br>
</body>
</html>

--_000_TYCPR01MB966913481F3B849D736C277BC4E72TYCPR01MB9669jpnp_--


