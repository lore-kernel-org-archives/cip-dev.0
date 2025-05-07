Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EFC3ABBE
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 01:54:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.1773.1746582874288497890
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 18:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=yoshitake.kobayashi@toshiba.co.jp header.s=key1.smx header.b=NzXXNDVJ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: yoshitake.kobayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:MIME-Version;i=
	yoshitake.kobayashi@toshiba.co.jp;s=key1.smx;t=1746582872;x=1747792472;bh=8ow
	uGrwRSdMuvdWhFlpYxPicGEhJ4nyVUs0DpmgdF38=;b=NzXXNDVJoEsCSXzxT26XLIriDL8hMOPBm
	y/RQ66rnvAWvjKtMnC4GSdo1uOyMyVR1NjBypwZrN1sqz7SajxLk4Jq+3/kJtN0i+vl80Jj0+uKJ0
	hJJwHV4GIRhfIp93NNGItzMO/T5msDGfuLhJd1KyrsIs/+n04Jpp28JsCl+tptoChVxv0EtepYSqD
	3YfhMwEvDgu++cAGxnTNhqXZ1D91qOEes4cjEFdkC+w6EAXkpoIzXCeqfBkIPOUtoN8Q1NkXmXtaQ
	khYjFKXjBjkoyNuFXC/BlMkwrw8Wakfdt6+t1zy5xKE1R5kqhHOlEJdhDdsjq92ckVsHitazo2RDY
	w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5471sVDK2233782; Wed, 7 May 2025 10:54:31 +0900
X-Iguazu-Qid: 2yAbJ3LJ4ICqxCSjzH
X-Iguazu-QSIG: v=2; s=0; t=1746582870; q=2yAbJ3LJ4ICqxCSjzH; m=+wqer/g3wl9v7jtZI57xC7o0ongbN35QJ14lo/b8eSI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 5471sTcv2170797
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 10:54:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCJcBo9qpbRHDSk/+ikw44aR9JEplnuy4LrKFTVsGDbY9clDZicyz2wjuMjYw+iXaMlgR9qhUVDjObRIeuchA5zVvO7Gh8wkJdCDzX8DpXgaul4r7RcYjVvKPalbs+A2dYUE/HfS3lDDhNMeei1FrLwNac8Ysya3P0u/EdZXiI6scJDmbNqec+aTUqpnh0fMyYc4gQS0FgYNwkGAG1KToGC5s3qVDhYIIXC4PjVggD7GDsQh44bfnhEwMunMGHLBo7N7paOUSwv2h7N27dLsIIaYLdqW+hXYhKUvbaJVVpxsmXHcuypxUj0z5y+VFR/DVPD2yIl2rW3OaXRnT03qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8owuGrwRSdMuvdWhFlpYxPicGEhJ4nyVUs0DpmgdF38=;
 b=RlpjS+eQwFd/cie60gRwel7GyL+4BMFKwoyEr5X1zhpfS4TuP0O2XcEX9Om8POedZCdZO91lYMl8Jhb1JoryhD+UBf3SK8/tyk5h7NdbJIiaIyJcwWk8nMqEbSb8/JTK9Md+iT1rilLAmFHXFX6Wtd5p0YZvXrsypmx/f7r28dKqmg3qwzMiLnk65lX7hsM9lcx5ELxV/iXj2ewrBs5/rIs3lcBEJA2sP/kf/mNn/bEPBlCcEuZCc/TpvW9pX55+ONeXdErbGf/H3ar8qdJDed0YO5zvcDCfc4fMtOrAitBwl0DzPtIzVi+7I6101FDzcDkQ3Sr9yNZQSL9qHsT5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <yoshitake.kobayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: 
 =?utf-8?B?Rnc6IFtFeHRlbmRlZCBMVFNdIERlYmlhbiA4IOKAnGplc3NpZeKAnSByZWFj?=
 =?utf-8?Q?hing_its_Extended_LTS_period?=
Thread-Topic: 
 =?utf-8?B?W0V4dGVuZGVkIExUU10gRGViaWFuIDgg4oCcamVzc2ll4oCdIHJlYWNoaW5n?=
 =?utf-8?Q?_its_Extended_LTS_period?=
Thread-Index: AQHbuTK9HBtZx37t6EuqNpzi6Hrt4rPGc0AT
Date: Wed, 7 May 2025 01:54:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB851877338EA2783C362272E1BA88A@TYCPR01MB8518.jpnprd01.prod.outlook.com>
References: <aBEXSNTtDdZFrsMX@voleno>
In-Reply-To: <aBEXSNTtDdZFrsMX@voleno>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8518:EE_|TYCPR01MB10891:EE_
x-ms-office365-filtering-correlation-id: 3349939d-f020-4350-c5b6-08dd8d0a19ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|13003099007|8096899003;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OUhPV1V2UWFUcURnMTB6dXlYSE9XcndBRXhobVdmQlFlMmpKM2xuUXBRanZa?=
 =?utf-8?B?TVAxc0ZaYVRSTmRkVjVNUmNiQ3RRQjZ6N0NoT0hzUGF3emVwQWR2dzdvOGxR?=
 =?utf-8?B?YVlDamRubkgyT0tQQUtCMUFHSmJkZEpMenl0TmRPbCt1YUlwMko4eFBMZzJ4?=
 =?utf-8?B?RnBiVzFoZTJ0MCtEKzhYL2lYWXV0bnpQREtVT21GOUVkUHYrVHl1dm82Mmx6?=
 =?utf-8?B?ZVlsTHg4YW5MUFBFMGR1R0FwaW4xQkQzTkdnUE9ucnBaZWtDOXp5Z25QYXNw?=
 =?utf-8?B?eXRmdXAyYit1cHNVNGFRV0ZOdHhYb0FEa0MrTGVTTHVUaXZXNDFmdU9abzlU?=
 =?utf-8?B?bDdTcG0ycGtZZE1naUJkRnhtcEFXSEJUNUJKYTdtQjZXWXVmaE1MRmViUzd3?=
 =?utf-8?B?S1ptT3RtRDkvS3JvR3pnT0xYTmpQWnBuMXVtdHJGR1dSUUZrSHJDUEtiTmJw?=
 =?utf-8?B?dkdVOEpxRTZObFYwMmdpTzFpN1piZENybHQ0cS81TVRzWnBkNCt6dU5FTmxv?=
 =?utf-8?B?NVZRY3hhblJ0Q1BSV3pVc1RpSVQ4UnhRNEVSS1h0TjAxbmtaRHlaRlIxdkdv?=
 =?utf-8?B?Sy9CZkFjQlRTeEIvUmxVbTZ2RHJFY2RjQVlabW5qRnV5Y01Zd0Z5YmhRTFRT?=
 =?utf-8?B?MFJDUXUzODNUQXdSRkY1RUQ3WXJVOGtZOTVxMXNPV1J5U3ByNjhQaFQ4TE1T?=
 =?utf-8?B?RGVCUE1EdnZUNUhZajN5ZVdKVDZ0cTNhY2JpNUc0Y3VxQTdpd0NhWWVSUi9t?=
 =?utf-8?B?azRqZm0yWm51OWdLV3NOUzZUTzQ0UkRnNXQxakVKYURkc295Q0xyNjZTbTNY?=
 =?utf-8?B?dXJYeTZTMThMYVRWNncyVGMxU2dSczVicVlac052amtJb3QvclJZeUwrUEZF?=
 =?utf-8?B?d3JYR2lNcGhyYjdGZlNyS0IzR3A0aUJ3akN3UGo4WkMzVnBEWEdDc0Fpbk9T?=
 =?utf-8?B?dTFORldaNVIyMUMzczF2akFxUE41RWNFRUhzbzhuN3czaFZiZ1ZIb1N3MkNF?=
 =?utf-8?B?SlZnZW1UVEJlM3Bvem1xQk1meFowVjlPSis5elVjRjFtYzNuVFZSZE1zcEl0?=
 =?utf-8?B?VXRzVjlpb1IweG1BVlowTHpEMnlwb29pZ2x1eE5PWWhmVC9taGV1ZUJPVjUy?=
 =?utf-8?B?YWZPRlF2a1RUTWU5OGNaM0FIOXlEUi9sSm9ud1hsZkw5OVdJaFEzOVRzWTBD?=
 =?utf-8?B?YWhIR0ZML2pRZDlldmVqZ1JNTjNZZWQ2cEJWNEl5VXhqQUFBNDI3bHRYNWsv?=
 =?utf-8?B?ZDNjSWEwUHFXbmc1RFN6TDl5b24vRlM2RHdzY1NKZzNxZGIwQjRBSkdqbWRr?=
 =?utf-8?B?ZE9XK0FmWkc1RXlybmdTNXpDaUplWnFUMTZuY3RxOVdUQ1RBOXNPalM0RTBV?=
 =?utf-8?B?SUxNVXh0YmloTGo4UHp0TnhGVCtuQXl1OTVrYlRsZFBuV3NHMmI5QnlRd0M5?=
 =?utf-8?B?Vmp2S2xsZVVMVnAwV2J0S2pZcFUzY3JSbldBZnMxVUdxZEg1dE00MTZSMEQ0?=
 =?utf-8?B?c3l6TVRRWkxybWEvbnhKYVlsVTFCMWxxTUVZZllEYjNrdUxkNHh6OStqMklj?=
 =?utf-8?B?K0xmU0FsNmwzVElKYkk5SGFmZVJIbW1xdVUzMmFsU0hnYzRJUzlsb3E2Slpp?=
 =?utf-8?B?L0R2MGNsYWZMZGJPbng1SEg0OFNORld1MWtzUUg5WGJVdkUrK0JOYWx5Slp3?=
 =?utf-8?B?SEUvUDBNbGM5SjZWM3RGRlZ6di9RREdteGZzaVlxY2NHR3cyNjhKMnE2ZWxM?=
 =?utf-8?B?bFNHZkJMMXdaRXN0M1dhc2svK29yMDhZNnhJeCtFd2c0RVhxWCtTcnBWOFhO?=
 =?utf-8?B?VVIwWCswd21sbnlneDBEWWZmYjR1QTFYc1Voa0RUc0VnS09hcWVVWTdYOTRv?=
 =?utf-8?B?M3JwSSt6YmQ4bDNEVGtuc1ByanJMTzZSdFJUaG9nemFyVnJZMkszYU9sSUpj?=
 =?utf-8?Q?p2o8BKBzrVw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8518.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(13003099007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SGN5OHdYWjBkTmJITXE5UUdHSVdFTDdXSlF5TmZ1MnFKWi9oU3pibWZTSm5z?=
 =?utf-8?B?cW1veFVyclBjSUhjMnlMQ21GQTBOTjlFMWJmNzNIWnlLU3kzN3dqRVVsVjR6?=
 =?utf-8?B?dzl4dXBTSnQ4Z2ZjUmEydnB6V2xhckF0RWczM0JhSzBXWm9LUldpaDNaTUtP?=
 =?utf-8?B?aGNNRDBQeXh2L2NRZ2ZpdXp4ZDNDRWw1UFpvT0o4N1NtcHo3S1VQd3VCVit0?=
 =?utf-8?B?ZjEvZS9ONFcvTmtuVkhsS0tqU3REZ2RDQzVKaXI5eDVXallGVVVHR2M2SHk4?=
 =?utf-8?B?THIraFlyaXdxUDZ0V2xDeDhCUXlTTGt2dXBMTGVUK01rMHZYNklzR053S1c1?=
 =?utf-8?B?V1MvbTJXeXltSEN6eHBRdk0rMzV2ejVscGJMM3VTemMvUElEU2JZQU9kaVla?=
 =?utf-8?B?YVh4dnAyK1ZubXM0T0czaitoRmdSaTB4QS84WFpKcExxdXlqVFRQelRFajJl?=
 =?utf-8?B?SGtiaHQ4bUJHc0Q0cUt1ckJkci9HL21XdW9zaS9RSkxuRVRZNjMwZzBWNHA1?=
 =?utf-8?B?ZHhYd0dqMEVOb3NOamVTM0gyaFNDNTJZeGorMytuUVBCY1RwRFQyUUJjbzdC?=
 =?utf-8?B?TWNHdUpFVnNqWTVPZmhKMENtblN2dXNJN2hldGoraDdEUnpFYjllMWpQdDVY?=
 =?utf-8?B?bllWMnZFZDRuK2VibFN5WHpaenR1OC9RN2gwRHhFNDVMU2J4L1hIM3RUeVVx?=
 =?utf-8?B?Z3BCWk4wZVBkSjlucW5UWDhSb0pUTlcyYjV5S2w4M2NvUTNWbUg2ZDhWYmtW?=
 =?utf-8?B?OGlxQnJHaXZkUk95YXVHN1RJVUpUYWYyYklnMG0xSmxtQ2xTWi9jdlAvb1Nm?=
 =?utf-8?B?QlRsZzJrdllCMWM2MytnVzR5YllsM2Q0TzRTSnhxa1AyRHFpNUg0VWNTbXQ5?=
 =?utf-8?B?bXlSc3ZLdWYxdkpBUEwySGpaZ200ek9FOWxOcnNiVkRYRk1mUG9MdGh6bGR6?=
 =?utf-8?B?VkVHSVJ0UGVKend3NnFucHltOE4yRWNpSHZidThlZE1FbG4waWZqUlRibjZq?=
 =?utf-8?B?dnFydFpva1N4ZFpxdnpiVVJWOVR2b0w4ckhtdGNnVENFWGlWUDVhUkJJbkhS?=
 =?utf-8?B?b1U2c21PcDVvUEdBbnBSdGJORVhpWUNwMjcrdGk2QzBqeVBKVTdWR1BQbWJP?=
 =?utf-8?B?NUlXcDZaUzhiVExOS2hRdU4yQWlFZ3BhZDExdVZRZmhzVDdvMlkyT1g4Z1BI?=
 =?utf-8?B?WkliU1NlK0tIRXdSTk4vdno4ayt2VDloT2ZCNjlGTERRa2xSY3dZNHFXSUtP?=
 =?utf-8?B?eUQ3TWRmbUI5OU1nYnlDNzMxdElUdTNRbG4vZ2grZnBzR2xDRFIvSU5DVzJW?=
 =?utf-8?B?WGltOGF3UXBFdG4zYmxRRTBNeklXSGg4b0U2VWpMNkptNVV3UjZWNVBBQjQ1?=
 =?utf-8?B?dzZDa2x6SVAwVDBaSmtyVFErRDFFbVMvQ0V4WVBHYXNlY29KWEZPODk1VVlJ?=
 =?utf-8?B?UzlkcUpRWDdYOElyQ21IVlYwWjk4R090TUtYU0xKS1N1cVRFRDJEVUtOMlgy?=
 =?utf-8?B?eXNab2hoOGtXeVpQWThWSmVmVG95bWtGdHBHOWRyb2c0TFduOUtKYTMyV25O?=
 =?utf-8?B?aFFzZ21SZG1zczcyUHltUEpEaUhmOElFMmtTSlg5VWFHanJGRUFtcEhXSDBC?=
 =?utf-8?B?V05lNUNxdzJnWUxEdVNhTVBEckdiTzRIK0xDMjVVQ1dpRmNLbVltbkZyRXox?=
 =?utf-8?B?a3padHlaUGZMakRhWU56aXNZb2xxaDgyWlcwNFpFYmwrbEprellrQmxreGFl?=
 =?utf-8?B?TFhJNnowcE0xVHlNOU1OWExvZjJuNXhrVWpnSUlaOUltQjNMSmdkS08vZFRM?=
 =?utf-8?B?Y2VMVEJhZFdNZTJFZ3lwWmpoVTY1UkN1Smp4Y2djMzlqMWhCNUdyN3JEMFdY?=
 =?utf-8?B?eGVtdXh4N1hGTCs2UlFnMFByNkMxQ01Oa2l6T1lKQnBVb0UreWQzbGpDY09T?=
 =?utf-8?B?ZmRVc0pYd3g5SGt1M0xSWFhyY3puU3BRbEpLWkwzOVo5a1ZkWFB1YmpuNDQ4?=
 =?utf-8?B?SXFPdWlqdHdUSXpjYXBJeGh6S09nQ25ha3lQd3VtR1BrOENDdW91RU9LZkIv?=
 =?utf-8?B?Q0VtczR3U3ZkMUM3bVdOTzRpcEJBbVdZS2VhNjNIV0xmOXdoeUZtYklVU1Z1?=
 =?utf-8?B?YXYzSWNwVFBRZGk2U3pLWTBBeVhsZkQ3M3FzeVFLYzVYS2pON1hpbGZzL3E3?=
 =?utf-8?Q?nCPgMMBWvrZTSGh4QarE4do=3D?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB851877338EA2783C362272E1BA88ATYCPR01MB8518jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8518.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3349939d-f020-4350-c5b6-08dd8d0a19ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 01:54:27.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0Zqig7pDWycjAKM+gxb4fvRwENZ9YmoS60KVwC4Z093MB1kyJlZ6kuiu4aOXUEqGnpaITRItvk0dOJs441VSy8N/aYsEz6yj8Y7UK8jHbw6DQOFKxDrURxzsT6GUnJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10891
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 01:54:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18771

--_000_TYCPR01MB851877338EA2783C362272E1BA88ATYCPR01MB8518jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RllJDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCuW3ruWHuuS6ujogU2Fu
dGlhZ28gUnVhbm8gUmluY8Ozbg0K6YCB5L+hOiAyMDI1IOW5tCA0IOaciCAzMCDml6UgKOawtOab
nOaXpSkgMDM6MTUNCuWum+WFiDogTFRTIENvb3JkaW5hdG9yDQrku7blkI06IFtFeHRlbmRlZCBM
VFNdIERlYmlhbiA4IOKAnGplc3NpZeKAnSByZWFjaGluZyBpdHMgRXh0ZW5kZWQgTFRTIHBlcmlv
ZA0KDQpFc3RlZW1lZCBEZWJpYW4gRXh0ZW5kZWQgTFRTIHN1YnNjcmliZXJzLA0KDQpBcyB5b3Ug
bWF5IGJlIGF3YXJlLCB0aGUgRXh0ZW5kZWQgTFRTIHBlcmlvZCBvZiBEZWJpYW4gOCDigJxqZXNz
aWXigJ0gd2lsbCByZWFjaA0KaXRzIGVuZCBvZiBzdXBwb3J0IG9uSnVuIDMwLCAyMDI1LCBhIGxp
dHRsZSBtb3JlIHRoYW4gMTAgeWVhcnMgYWZ0ZXIgdGhlDQppbml0aWFsIHJlbGVhc2UuIE5vIG1v
cmUgc2VjdXJpdHkgdXBkYXRlcyB3aWxsIGJlIG1hZGUgZm9yIERlYmlhbiA4IGFmdGVyIHRoZQ0K
bW9udGggb2YgSnVuZS4NCg0KV2Ugd291bGQgbGlrZSB0byBlbmNvdXJhZ2UgeW91IHRvIHVwZ3Jh
ZGUgdG8gRGViaWFuIDkg4oCcc3RyZXRjaOKAnSBvciBhIG1vcmUNCnJlY2VudCByZWxlYXNlIG9m
IERlYmlhbi4gSWRlYWxseSwgdG8gdGhlIGN1cnJlbnQgc3RhYmxlIHJlbGVhc2UsIERlYmlhbiAx
Mg0K4oCcYm9va3dvcm3igJ0uDQoNCkZyZWV4aWFuIHdpbGwgY29udGludWUgcHJvdmlkaW5nIHNl
Y3VyaXR5IHVwZGF0ZXMgZm9yIERlYmlhbiA5IGFuZCBEZWJpYW4gMTANCuKAnGJ1c3RlcuKAnSwg
dW5kZXIgb3VyIEV4dGVuZGVkIExUUyBzZXJ2aWNlLCB1bnRpbCBKdW5lIDMwLCAyMDI3IGFuZCBK
dW5lIDMwLA0KMjAyOSwgcmVzcGVjdGl2ZWx5LiBJZiB5b3Ugd291bGQgbGlrZSB0byB1cGdyYWRl
IHlvdXIgRGViaWFuIDggc3lzdGVtcyB0bw0KRGViaWFuIDkgb3IgRGViaWFuIDEwIGFuZCBiZW5l
Zml0IGZyb20gRXh0ZW5kZWQgTFRTLCBkb27igJl0IGhlc2l0YXRlIHRvIGNvbnRhY3QNCnVzIGF0
IHNhbGVzQGZyZWV4aWFuLmNvbSwgc28gd2UgY2FuIHByb3ZpZGUgeW91IHdpdGggYSBxdW90ZS4N
Cg0KV2Ugd2lsbCBhbHNvIGNvbnRpbnVlIHN1cHBvcnRpbmcgRGViaWFuIDExIOKAnGJ1bGxzZXll
4oCdIGFuZCBEZWJpYW4gMTIgdW5kZXIgdGhlDQpEZWJpYW4gTFRTIHNlcnZpY2UuIFBsZWFzZSBy
ZWZlciB0byBodHRwczovL3d3dy5mcmVleGlhbi5jb20vbHRzL2RlYmlhbi8gZm9yDQptb3JlIGlu
Zm9ybWF0aW9uIGFib3V0IERlYmlhbiBMVFMuDQoNCklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMs
IHBsZWFzZSBkbyBub3QgaGVzaXRhdGUgdG8gcmVhY2ggb3V0IHRvIHVzLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQoNCk5vdGU6ICBBcyBhIHJlbWluZGVyLCBEZWJpYW4gb25seSBzdXBwb3J0cyB1cGdyYWRl
cyBmcm9tIG9uZSByZWxlYXNlIHRvIHRoZQ0KbmV4dCwgd2l0aG91dCBza2lwcGluZyBpbnRlcm1l
ZGlhdGUgcmVsZWFzZXMuIFRoYXQgaXMsIGlmIHlvdSB3b3VsZCBsaWtlIHRvDQp1cGdyYWRlIHRv
IERlYmlhbiAxMiBmcm9tIERlYmlhbiA4LCB5b3UgbmVlZCB0byBmdWxseSB1cGdyYWRlIHRvIGFs
bCB0aGUNCnJlbGVhc2VzIGZvdW5kIGluIGJldHdlZW4sIHN0ZXAtYnktc3RlcC4NCg0KLS0NClNh
bnRpYWdvIFJ1YW5vIFJpbmPDs24g4peIICBGcmVleGlhbiBTQVJMDQpodHRwczovL3d3dy5mcmVl
eGlhbi5jb20NCg==

--_000_TYCPR01MB851877338EA2783C362272E1BA88ATYCPR01MB8518jpnp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0iZm9udC1mYW1pbHk6ICZxdW90O0JJWiBVREdvdGhpYyZxdW90OzsgZm9udC1zaXpl
OiAxMXB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpGWUk8L2Rpdj4NCjxkaXYgY2xhc3M9ImVs
ZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6ICZxdW90O0JJWiBVREdvdGhpYyZxdW90
OzsgZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4N
CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5z
LXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwv
ZGl2Pg0KPGhyIHN0eWxlPSJkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IHdpZHRoOiA5OCU7Ij4NCjxk
aXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFy
aWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigw
LCAwLCAwKTsiPg0KPGI+5beu5Ye65Lq6OjwvYj4mbmJzcDtTYW50aWFnbyBSdWFubyBSaW5jw7Nu
PC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGlj
YSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8
Yj7pgIHkv6E6PC9iPiZuYnNwOzIwMjUg5bm0IDQg5pyIIDMwIOaXpSAo5rC05puc5pelKSAwMzox
NTxicj4NCjxiPuWum+WFiDo8L2I+Jm5ic3A7TFRTIENvb3JkaW5hdG9yPGJyPg0KPGI+5Lu25ZCN
OjwvYj4mbmJzcDtbRXh0ZW5kZWQgTFRTXSBEZWJpYW4gOCDigJxqZXNzaWXigJ0gcmVhY2hpbmcg
aXRzIEV4dGVuZGVkIExUUyBwZXJpb2QgPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTog
Q2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBj
b2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRU
b1Byb29mIiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyI+RXN0ZWVtZWQgRGViaWFuIEV4dGVuZGVk
IExUUyBzdWJzY3JpYmVycyw8YnI+DQo8YnI+DQpBcyB5b3UgbWF5IGJlIGF3YXJlLCB0aGUgRXh0
ZW5kZWQgTFRTIHBlcmlvZCBvZiBEZWJpYW4gOCDigJxqZXNzaWXigJ0gd2lsbCByZWFjaDxicj4N
Cml0cyBlbmQgb2Ygc3VwcG9ydCBvbkp1biAzMCwgMjAyNSwgYSBsaXR0bGUgbW9yZSB0aGFuIDEw
IHllYXJzIGFmdGVyIHRoZTxicj4NCmluaXRpYWwgcmVsZWFzZS4gTm8gbW9yZSBzZWN1cml0eSB1
cGRhdGVzIHdpbGwgYmUgbWFkZSBmb3IgRGViaWFuIDggYWZ0ZXIgdGhlPGJyPg0KbW9udGggb2Yg
SnVuZS48YnI+DQo8YnI+DQpXZSB3b3VsZCBsaWtlIHRvIGVuY291cmFnZSB5b3UgdG8gdXBncmFk
ZSB0byBEZWJpYW4gOSDigJxzdHJldGNo4oCdIG9yIGEgbW9yZTxicj4NCnJlY2VudCByZWxlYXNl
IG9mIERlYmlhbi4gSWRlYWxseSwgdG8gdGhlIGN1cnJlbnQgc3RhYmxlIHJlbGVhc2UsIERlYmlh
biAxMjxicj4NCuKAnGJvb2t3b3Jt4oCdLjxicj4NCjxicj4NCkZyZWV4aWFuIHdpbGwgY29udGlu
dWUgcHJvdmlkaW5nIHNlY3VyaXR5IHVwZGF0ZXMgZm9yIERlYmlhbiA5IGFuZCBEZWJpYW4gMTA8
YnI+DQrigJxidXN0ZXLigJ0sIHVuZGVyIG91ciBFeHRlbmRlZCBMVFMgc2VydmljZSwgdW50aWwg
SnVuZSAzMCwgMjAyNyBhbmQgSnVuZSAzMCw8YnI+DQoyMDI5LCByZXNwZWN0aXZlbHkuIElmIHlv
dSB3b3VsZCBsaWtlIHRvIHVwZ3JhZGUgeW91ciBEZWJpYW4gOCBzeXN0ZW1zIHRvPGJyPg0KRGVi
aWFuIDkgb3IgRGViaWFuIDEwIGFuZCBiZW5lZml0IGZyb20gRXh0ZW5kZWQgTFRTLCBkb27igJl0
IGhlc2l0YXRlIHRvIGNvbnRhY3Q8YnI+DQp1cyBhdCBzYWxlc0BmcmVleGlhbi5jb20sIHNvIHdl
IGNhbiBwcm92aWRlIHlvdSB3aXRoIGEgcXVvdGUuPGJyPg0KPGJyPg0KV2Ugd2lsbCBhbHNvIGNv
bnRpbnVlIHN1cHBvcnRpbmcgRGViaWFuIDExIOKAnGJ1bGxzZXll4oCdIGFuZCBEZWJpYW4gMTIg
dW5kZXIgdGhlPGJyPg0KRGViaWFuIExUUyBzZXJ2aWNlLiBQbGVhc2UgcmVmZXIgdG8gPGEgaHJl
Zj0iaHR0cHM6Ly93d3cuZnJlZXhpYW4uY29tL2x0cy9kZWJpYW4vIiBpZD0iT1dBMzJlODI0ZmQt
NTU5Ni1jZTc4LTI3OTItNjgwYzM0MzZlMzJmIiBjbGFzcz0iT1dBQXV0b0xpbmsiIGRhdGEtYXV0
aD0iTm90QXBwbGljYWJsZSI+DQpodHRwczovL3d3dy5mcmVleGlhbi5jb20vbHRzL2RlYmlhbi88
L2E+Jm5ic3A7Zm9yPGJyPg0KbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBEZWJpYW4gTFRTLjxicj4N
Cjxicj4NCklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMsIHBsZWFzZSBkbyBub3QgaGVzaXRhdGUg
dG8gcmVhY2ggb3V0IHRvIHVzLjxicj4NCjxicj4NCkJlc3QgcmVnYXJkcyw8YnI+DQo8YnI+DQpO
b3RlOiZuYnNwOyBBcyBhIHJlbWluZGVyLCBEZWJpYW4gb25seSBzdXBwb3J0cyB1cGdyYWRlcyBm
cm9tIG9uZSByZWxlYXNlIHRvIHRoZTxicj4NCm5leHQsIHdpdGhvdXQgc2tpcHBpbmcgaW50ZXJt
ZWRpYXRlIHJlbGVhc2VzLiBUaGF0IGlzLCBpZiB5b3Ugd291bGQgbGlrZSB0bzxicj4NCnVwZ3Jh
ZGUgdG8gRGViaWFuIDEyIGZyb20gRGViaWFuIDgsIHlvdSBuZWVkIHRvIGZ1bGx5IHVwZ3JhZGUg
dG8gYWxsIHRoZTxicj4NCnJlbGVhc2VzIGZvdW5kIGluIGJldHdlZW4sIHN0ZXAtYnktc3RlcC48
YnI+DQo8YnI+DQotLTxicj4NClNhbnRpYWdvIFJ1YW5vIFJpbmPDs24g4peIJm5ic3A7IEZyZWV4
aWFuIFNBUkw8YnI+DQo8YSBocmVmPSJodHRwczovL3d3dy5mcmVleGlhbi5jb20iIGlkPSJPV0Fi
MmFmM2Y3NC03MjdjLTg3ZDktNjVhOC05Mjk1YjIwNjMyZjYiIGNsYXNzPSJPV0FBdXRvTGluayIg
ZGF0YS1hdXRoPSJOb3RBcHBsaWNhYmxlIj5odHRwczovL3d3dy5mcmVleGlhbi5jb208L2E+PGJy
Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_TYCPR01MB851877338EA2783C362272E1BA88ATYCPR01MB8518jpnp_--


