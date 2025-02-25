Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77AC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 10:04:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.5086.1740477839871731765
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 02:04:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 51PA3vlQ1265260; Tue, 25 Feb 2025 19:03:58 +0900
X-Iguazu-Qid: 2yAbpfLvFi2o9n2paT
X-Iguazu-QSIG: v=2; s=0; t=1740477837; q=2yAbpfLvFi2o9n2paT; m=rKw7m8Jn7vFUACFOok/hYG58aQTA0rnZvIcFh4OsOi8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 51PA3u7u2099960
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 19:03:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azLPDJ9rgNIIEKYxdX353HVyYv7l4/vCWmMSWfp5Y8CE3cDoKu9w22ebxpHiKos7+ysiGU9ARxYLAqaI/IKBzJnu4soUxwVof2bccwtbxvvA7OyokoHC70TlUsE4Ke8qYQOmCSxPXU7PgrtTepy4TV8BDa1C3GBAR8K9MPet8HCAJdf0tA+u1wOzHawc98b84SyfuCHB56z1BuKcbbN0lxZSHZuz9izEjDxJ5IPLc7in+GO8coLpCpRtlu4zfnIeDPJmWynJdq0Y9iJWm8AlnNPNmyp8srNt+zC554jCxoufg3OLjOuNfieNw1tb5eFixIf6oAvOlGpfvl82NWjT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrJSKt0NptIEVfExUtswwXA/dW2siemMhRgC22/gyrQ=;
 b=GvfcB9NQnxsn0atSJydT9NcSE3zGHpvkPs8rFqGwaqWD5UXMC+nWYe7Tme3RcLhTQ+73/gqZWwH0xBDpZMZDyt7pzxaufLYpybMpoZRy2DG/zPda1qii95Il/TAgXhqTAj2lwViGNTTmrNi06gjt2dMa8/ltH1deSxcharFwa1gP770CUWcCnESxIBerdqWUZh4zsQjjEQV+pCnw3je0FpUCd9ar9EFeNRmhldu7BvpXZ7F1n2O4ChuUpJUbLhcWgEVVa/INiaS9KDKd1cj7wTxXJrsvZLh+hjg/JJckUWsVLELT9FflXDx9SVnZR7M2pW7iOJUlOJE2lFqR79oJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Test reproducibility of
 wic images
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 0/2] Test reproducibility of
 wic images
Thread-Index: AQHbhpmDhXdHsK/0hUG7CtAjV7JFdbNXyB0AgAAALaU=
Date: Tue, 25 Feb 2025 10:03:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E8D2FCD6B066660B0264C4C32@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
 <ef4331c3-2142-46e8-9503-2c2f04dd376b@siemens.com>
In-Reply-To: <ef4331c3-2142-46e8-9503-2c2f04dd376b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSCPR01MB13642:EE_
x-ms-office365-filtering-correlation-id: 26bec13b-8893-4717-1010-08dd5583b65f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cTlZYlVaenZsckdGSEQvS0NuMzdjMXZmSSsxTjB2K3JVT2ZNa2xYWnll?=
 =?iso-2022-jp?B?OGxmWW92MWp1b1k4MjBvSTQ3WGlzb2VDSmxvM2x1YkRhNFR0MmpVRXM1?=
 =?iso-2022-jp?B?NkpvUzkraDRETThUaXo0RFZQNFZzSDhPKzlIeE5GdHltV3dZbFRMWEpw?=
 =?iso-2022-jp?B?dXRQZDM2eXhNSGl3c25ZVDA4UFRmdllSa2NPZ3hQMEptZzBteklUNkJY?=
 =?iso-2022-jp?B?cGZ4TTJ3SFBJblNNM2NoODRqSzIwU2FnVGJSdWJEUTRYT2NNN2VPWlN2?=
 =?iso-2022-jp?B?Wmxxd3UzdkhDcmNNZ3NTUStXekxXTUUydURVV3A1cTJ2UStOUnA2dlBM?=
 =?iso-2022-jp?B?U1RaRjZBbWtCb0E1Q1Y2bHFwd3VQQ2JWWGhVT1Z5azVOUXlSK2JwU0xT?=
 =?iso-2022-jp?B?a2pySVpTQlRHZkQxTEJoUGdWdko0WHJFU3M3NUFCVnUwUEpYRzRRemo0?=
 =?iso-2022-jp?B?cTNxRnM5R2x6dUpsSktqWGZsQ2JzR0xGdXhiSm1TOG5mVmtlNEZncWNF?=
 =?iso-2022-jp?B?eENFWFAyc3JkdEtSNmR4RTcwZkN3SnN2QmJGai9PMDJOaGZkRUlmSlNS?=
 =?iso-2022-jp?B?WnVHeDlBUXZJU1NhcWxoS003WFZoUkJKc3Z5WkV3OEhQL1pnR1hQM1l1?=
 =?iso-2022-jp?B?eTc4REI5djE2YWJoWUUwTVlsSkRJcnFzaUdLbEtvdmRBRnBqRTJjalhO?=
 =?iso-2022-jp?B?TTJsL3h1cWZrMWRWWGVGNTBxU0toSEhhM0lxUml6OTJxR1BkZWZiUEdu?=
 =?iso-2022-jp?B?M3ZOc0EzQ2xwQlhzcVB3a3ZEakpvQlYyWE5yZjlpRDBneXJzQVYrZnpU?=
 =?iso-2022-jp?B?TGszbGVWTUwxaWZVUFJ3TG9qb1JYT2d3MDVFc2NmZGJqSDBrMTJndXVJ?=
 =?iso-2022-jp?B?Z2pvVEp0OENMeWFibXdzR3ZUVnY2OHdoc1M5eVJTMmxva0oxeUJ6ZGwr?=
 =?iso-2022-jp?B?TnozQURMNnFRSnZmSkI1eUt4bWpoRlkrSVFOdU1jbGZQQmpiWXVuSU1X?=
 =?iso-2022-jp?B?V0IzR0ZyWkF2RS9PdnhScFVEMzhXVEh2cEVzcXRwUUVYMzVPVU1NY29F?=
 =?iso-2022-jp?B?RlBFU2lqT21TempOR09JaWorZjBSbE5Bdmx6cDk2SWlHQjAwRlg0NzZD?=
 =?iso-2022-jp?B?WDZZMkdPUjZvS01tUGdmSEJZWHFBWEZ4N01UQmVaWnpUM1pYbzJKaTQx?=
 =?iso-2022-jp?B?S2QzNElmdHRJaVI1Ymg1M3JxM3VoOHZvNXVhK0lQRW9JK1c5Uk5OaG5h?=
 =?iso-2022-jp?B?dzJnWTJWT0k0MW5zY0l5VnIyNkEwUHlBUXJvR2lURWJpcFlMS3pQRTVy?=
 =?iso-2022-jp?B?bEF4NHJVeXRwekhJTUxRTzV4OUViYTFMSkhVTTVDZThZclVPN2VpdjJ2?=
 =?iso-2022-jp?B?Zk56QzNUVTBLTzNOMWhYTzl2OUV1R1pkaEcrakFyY084Q292OTU5VlRM?=
 =?iso-2022-jp?B?M2F2OWhDMEM2RkF1TXN0TlNuZHBpSzRpWkNMV0N6TEpSM3QwMDFURHRH?=
 =?iso-2022-jp?B?TWI4L1FiMW9wajlXOGsxL2I3cHI5WFBDMzNnb3h0OUVjNTBaTHhlaFNJ?=
 =?iso-2022-jp?B?bFF4QTdVTkJ2dy9NVEg3TjJuTnJ1TjdDNGZqeEdQWG9uQ1NtbVg5QTdj?=
 =?iso-2022-jp?B?QzA0WFhiN1NCRmNtMmxSRDZLdyswaDBGK2l1REp5NnM2QzlTaHdNeTU0?=
 =?iso-2022-jp?B?Mm0rT1VWYWpMeC9QRjJVR1g0YzZLZzJwSG1NZ0tuSXhyNjhjbndqWEM5?=
 =?iso-2022-jp?B?cWRUNzFzOHFwenVCb3N6SUVnQU50dG92QTVFZSsxVWtPNzNjWVFpR251?=
 =?iso-2022-jp?B?aEVidDJrTCs4bi8yUnRQbFp3R0RrdnZwbDJTelJwTUtZd2R6SmZMV0kw?=
 =?iso-2022-jp?B?K3l6UWtEbllmeHgwYTkxT0hxelByTnNSWGVFcjJXcExkdktCT0haNENu?=
 =?iso-2022-jp?B?YmFwczU5QkhoSzZqcUxoMWxBdXQ3WTBqeXpsL0ZQc3JTanZHN0Q4OUFs?=
 =?iso-2022-jp?B?RnRMRWwxSktya2RNQmVmOVZZNCt2WUV2YTlEdVpBZDhnV2xaYjBKTkZE?=
 =?iso-2022-jp?B?aGY2d28wZVVqOXkxSFFaRkVpTHhpSVpLYXM1ckZJd0tJbWcrOFo5Z2pR?=
 =?iso-2022-jp?B?Mmo=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YWFnekhyUXhIM3NrNGR5L041NTNLZzdvU2F3NDRsNGI3MDF3alYvclkw?=
 =?iso-2022-jp?B?c3l0Umd6VzRnWnUrMVMxejN6MlIzRnVtZWRzeDhKWk84ZHdVZGx6bEx1?=
 =?iso-2022-jp?B?NGQ3NlBYaTc5MlpJRnVGaFVPeEZoWFBnQTEzZTZHK0xUK1p4MGRvNGtV?=
 =?iso-2022-jp?B?OUNUdm5HWjFLTnppdzhhSVJ3SjY2UkdiT2dSbnRiUkRqYkR2Mk0rOXdL?=
 =?iso-2022-jp?B?YXZEaVVHQm0xcDJ1eEs4UlR4ai80WXZ3bVM3aVczcjAvUFVUWktPSHNI?=
 =?iso-2022-jp?B?VUU5ZzRKRGhHSkl2Y3BWaUVST2huNkkrZ2xZN2d4bFRGbnhLS0g2eXdh?=
 =?iso-2022-jp?B?SHdWV2VwdVBQZDhCcTZIUDRxcHJIZ3RyalJWYkdUL2JDNUd1MzdodzR3?=
 =?iso-2022-jp?B?VnEwYlJYNFJlSDNPQUYzYkxxbXBNMTFtZUxaRTdMY2ZXcktSMk44empj?=
 =?iso-2022-jp?B?SnNjV3Z0eld4UjU2dVBldXBuT2dWY3V3bU1LL2FFRmwrQU5RZ3A0RVNt?=
 =?iso-2022-jp?B?cHRmb1JEb09YWE13R0c1M0luaGtHTjJQVEFQZ3lmWTFJdXBKQk5aVVJh?=
 =?iso-2022-jp?B?VTgrRTY2QkFEendTYUV5T1VVaUc1S3lEREtiU1AzK3B4UC9vZll3a0Uw?=
 =?iso-2022-jp?B?YzFUcEp0SUpCOFFzeDBZM25PMHh6U1E1NERZZTl3bStqbXEzN1dDajFY?=
 =?iso-2022-jp?B?eGllMUhhclM4aS9UM2ZoWHFVdkFqQWxCWUtjdi9MTFNXdHFxVWNzZFl5?=
 =?iso-2022-jp?B?Si8xaVo1UXhCVnY3Rkxobi91U2tqbGJNT2xqemQ4M0loTFR3d1Z4Q0kw?=
 =?iso-2022-jp?B?RWlPTGFRb3dHODB3YjB6bDBESVdVdVJoMmFHN2J6NU1LL0hKa0tOREN3?=
 =?iso-2022-jp?B?eWdRWnVyQ1N6UlJkVk5XOUNIRlVpaXlFeitrZVRVVnRldUcxeHhMR1hp?=
 =?iso-2022-jp?B?eTFoQnJmL000Nmx4czY5MEJ4QUJWbmtsL2ZTbFRTUjJ4aVNKU1F4UXpT?=
 =?iso-2022-jp?B?OGp2d2ZBbkVDMmdyUHJPQzEyeGJXNDV3SWVvZk5ZVVBnbW1ydHhNRWpi?=
 =?iso-2022-jp?B?dGVDYy8zZVZGelFIM2JrRlAybElkOGFNdVdicTMvaVdrYXVXbXBzNjZi?=
 =?iso-2022-jp?B?MDhXcXZnZUJYOVZmMFRMNWlyYWYvQ2pOS1RDdGdSanNDS3c0UmZvZ0lR?=
 =?iso-2022-jp?B?d081N09DSkpzSmJBM1BZL21FZzI5OWhNcjdnRk5EYnl4Tk41ak81Zml4?=
 =?iso-2022-jp?B?bmhHWmR3UmxaQnpsZy9nbEFEaTNaaHVIR3lWdldhays1OS93MisvaXhh?=
 =?iso-2022-jp?B?ZWJGd0RteFFvUGpTT21sQWNxOS9PU0xzQStscXNub0VUK082bUFGSVVw?=
 =?iso-2022-jp?B?dE9ZZVNxM1laTVluWmZmN3J3NWlQKzlEWHNPTnkwbjloUlFnSlBqRy9G?=
 =?iso-2022-jp?B?bTZDN3hHRzE5MUEyM3RkQjI1dzJXL2prQ3ZEczZTR2xSampyR0FkWkNZ?=
 =?iso-2022-jp?B?eWRUWGNwa2NoOHpFa2VNOHZWKzh5ckZzVXMzRnU1alNmVG0xU2FOTDJm?=
 =?iso-2022-jp?B?QW0vMG11eU96ZjRQOFVMekdpTEVBNkJxVVBidVlhQlIyUTlwQUFVVkxx?=
 =?iso-2022-jp?B?Lzd2TkNNa0FGbzd3eTc1YzJYejN1Rm5zRnJLT3J4bzZiWitnUVRZeExL?=
 =?iso-2022-jp?B?QjVUL3dVZDhtMHlkU0gwc290cm93QWtKMFhSTHFpV2hjTWhIL1Z0SmtB?=
 =?iso-2022-jp?B?QlR3TFRYTzdoWHN1aXE5YnRjMHlHOUhpbW9ZOEVTbkVVN2d4ck5OS0xL?=
 =?iso-2022-jp?B?Y3dIcEhIVlN4LzVCVlVVTVh0U25PVitRU1p5QTd4K0J1cklUc2VTQ0NP?=
 =?iso-2022-jp?B?TlJaMjF6citUS2Flak55bmF2VU9WaWt0WmRXSGJ5RVlRRzF1cFZqSTdH?=
 =?iso-2022-jp?B?SVdYenBBWGl6OUZTUnBJakhDMS9zZTVEWlUzd283dkxPRXlqbEZXR3JW?=
 =?iso-2022-jp?B?L0d3SlJpY2lEVDZLZGl6V3J0QmU0TmhKaG9uVFJuSjZCN3pRd2R6eTlE?=
 =?iso-2022-jp?B?c1NRb1l5WkUxUUNDTG1DQ2VQSHhpdFRhM0hOSHBXTGV4N3RiQkhnb0RN?=
 =?iso-2022-jp?B?VmtIRlAyMmN6d0Q3SksxMDVhZVNsTnJkZ3pDYy9zc2NCOFdiamRYVGNk?=
 =?iso-2022-jp?B?N1NBLytIRUVMTWE5bDVNVUN5VTRTOExqT1A1TUFtODIvMWNWbFhvYUpp?=
 =?iso-2022-jp?B?VFJ3SVVWUFRMbENScVJpa3pBcGtuTTROTURIRzVsbE9WbHMxbzhNWTJL?=
 =?iso-2022-jp?B?NmlsRGkyYzhreW85OHlzd3RwZWhlUkw0Y3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bec13b-8893-4717-1010-08dd5583b65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 10:03:54.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFUAE38LU/x2Tngcmw4yQZZkawIc+IZlC0403RSAYwmtuJa2x11mRCrjyw1iKTpNsYCTzkbMRSidV1IZUOt1KBe78ieoiJvMEYc6UUC19bm/zbDOBQtfE1RZWgBmeywU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 10:04:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17908

Hi,=0A=
=0A=
>Are we now testing both, partitions and full images? Or are we rather=0A=
>moving from partition testing to image testing with these patches?=0A=
=0A=
I would say the higher priority is to check if the full images are reproduc=
ible (As those are the artifacts often released/used).=0A=
=0A=
I retained the partition wise check (if the full image are not reproducible=
) just as way of quick debugging to see in which partition the reproducible=
 issue lies (if one exists). And also running a diffoscope scan on a comple=
te image has problems like I mentioned in the patch=0A=
=0A=
If you prefer to keep things simple, we can just full do the repro-test on =
full images and drop the partition wise check entirely.=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar=0A=
________________________________________=0A=
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>=0A=
Sent: Tuesday, February 25, 2025 3:20 PM=0A=
To: balakumar adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST); cip-dev@lists.cip-p=
roject.org=0A=
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST); ashrith sai(=1B$B=
#T#S#I#P=1B(B DITC_DIT-OST); dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST);=
 hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#=
G""#M#P#S!{#M#P#4=1B(B)=0A=
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Test reproducibility o=
f wic images=0A=
=0A=
On 24.02.25 10:00, Adithya.Balakumar@toshiba-tsip.com wrote:=0A=
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>=0A=
>=0A=
> Currently only the individual partition images are checked in the=0A=
> reproducibility test. This patch set tests reproducibility of entire=0A=
> disk image too.=0A=
>=0A=
=0A=
Are we now testing both, partitions and full images? Or are we rather=0A=
moving from partition testing to image testing with these patches?=0A=
=0A=
Jan=0A=
=0A=
> Adithya Balakumar (2):=0A=
>   .reproducible-check-ci.yml: Upload wic files for reproducibility test=
=0A=
>   scripts/repro-tests.sh: Update script to check wic file=0A=
>     reproducibility=0A=
>=0A=
>  .reproducible-check-ci.yml | 10 ++++-=0A=
>  scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------=
=0A=
>  2 files changed, 68 insertions(+), 34 deletions(-)=0A=
>=0A=
=0A=
--=0A=
Siemens AG, Foundational Technologies=0A=
Linux Expert Center=0A=


