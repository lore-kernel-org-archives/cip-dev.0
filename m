Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EAC369BD
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 09:57:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.12083.1727258244568644023
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 02:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 48P9vMav2327272; Wed, 25 Sep 2024 18:57:22 +0900
X-Iguazu-Qid: 2rWgGN9FKJEgNzCnLS
X-Iguazu-QSIG: v=2; s=0; t=1727258241; q=2rWgGN9FKJEgNzCnLS; m=csn5zP6FBVKanfZQvEC/WUS1FY4XpSXqqOaOWn09jxU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 48P9vKix3082001
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 18:57:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUaT2rbY6SiUG7gJ0EfbBSXa8ShCkZAJn/YAmshxFqtqTuVl2QIxdjpZ6qAMvOsX+udVZgUtJZFb8SmEXbgjdq7wWbevCjB8LJVZap7ukr4AvSK1SVtfUFE8I+2xWwIPdBKBC+FSLv4vCfxicKr7VF0IGaCoo4j1TIP9LFI+sIkKlswi0Pw+3fXTpAnIyyTr2xkUVLJsiIZbjZsxycaV6z8X3pELdZKMlK276OIJk/nm8ax5WkxoNlcEzjLyrNFOZP7Jaaw+IsO72W9rrL9bdFxEblEVX2/RwNtVBtjtQorGVSVJA7xR5lb6wHK8VKvFRzCu7AR9+mXw+/uLcWeFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6wmT/AolFdmOVUu1OAs2gWUv8EkB8GrSNlrUFjSsHo=;
 b=od4iPXpgDq75VfKslka0W0Ren3/fmgOeWMhBcRHj88tcLiClpe+papcgTjBMfbULoPBbyfgcFN8px1hPwAHDHDJ+bkjn9KUdwNaaEN8OvQMzLNUjaiTUnu9AvJrcN0qsDYcfelg9yFjMfvwS1j0pbZwh3CYVY3d7DYOWsu3CB+O2IKBsZeFCKKDU1PxY/YyDk2hyKICDz/7PD+KtDyYXki0UhbqB0Z3gJeUl8mRoFeeCxoP5vqNEctPtiC1YNo8sSZsuFiIe/C2m5ltz/uK39dLRz6KJNy4BwD9I/meDskaCSOMs+IxgXKI4MYcxgr3AG0Oz8T8iuzMrjO12trJU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>, <michael.adler@siemens.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: 
 Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQBBtW1XAAAKEVoQ==
Date: Wed, 25 Sep 2024 09:57:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB9610:EE_
x-ms-office365-filtering-correlation-id: 0a1682e3-dae1-49f7-a94c-08dcdd487090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MGxFVm9tQUtYR1hZeFBtVHRwVWFCektmMEhvckxVQWVjaW5KMHBTSXhr?=
 =?iso-2022-jp?B?OTcrdExwYkhhZXlXM3diTkN6ZjZIZ0NNL2FYWDNsY0hpRGZ1S3JiaEFz?=
 =?iso-2022-jp?B?SFBKNFhNeU4yNEUzcVNXYUVnNzJWeDVOWkxTbXJ3U1RxT0tWOURpeThJ?=
 =?iso-2022-jp?B?VTN5Tnhob2Jya08ydVpmMVpoN1Z6dU9CYlR0K1kvdFUvNG5DRy9heFg0?=
 =?iso-2022-jp?B?ZDZNcVhXSVZZcEd4TmtWeHNZNkhoaTh3UHh5emxtTWRocjJPVXgxRjRx?=
 =?iso-2022-jp?B?dWFSNTJHNGgrZnNjYk5lKzRBY3hmRXFlblFlWjFTbGhMSkhwSnNwanVk?=
 =?iso-2022-jp?B?V2VNT3dKQTlpc2dVS1preTNXYmQyUE1uUENaYTNnbGxobUlVdTgyQlFk?=
 =?iso-2022-jp?B?Nm9OTVR1SGhhdXVuYUErNzdBZGNKN1ZsUC9FSlhHRUFRK0dUNHlUVGZm?=
 =?iso-2022-jp?B?M0U2SFpYaUdxRWlEZ2QyZXJtc3hLSTE3TWdUL0FMZXZmSzdxU2ZDYzMr?=
 =?iso-2022-jp?B?NHVTZ3B4b3NMWHBzbkxDZFZrb3NiblhkcmdiY0c0cHYydVJQemhxUWhh?=
 =?iso-2022-jp?B?TzFsOHhOWENIMkFVZ1I3cXRoK2MzaTkxL3ZTU2N5d2p0ZmI2emZUb2lN?=
 =?iso-2022-jp?B?Z0NZdmJ3dW02MXF3NVhhbWcxVGlYa0FOTGZraVl4T0VxY29HL0xjaUhu?=
 =?iso-2022-jp?B?UEJzUlIyMDVHdmdYREhJNGpRblBZQk95OWdKTFhFV1NId3ZWOFczcnRo?=
 =?iso-2022-jp?B?NWV4VWtSTkVZVWQvbVB5S1pSTGwxa1ZsSDZnWHM3Y1MzTkhzeHVIMFla?=
 =?iso-2022-jp?B?ZCtXMG84QlVzeUFLcS9pSy81cGlxUFM0TmVPcWM4dHhSYkliVTZrTEp5?=
 =?iso-2022-jp?B?K2lwZWNoWFh3dDQ2RThibE5OTTViWDVXQXFVOUN6OWllMXQ2YmJRMUtK?=
 =?iso-2022-jp?B?Qkl3TVNyV3A3OEI2SXVKQWE5bWJic2RhNkMrTklSeHJMV0tRenA2ZlNO?=
 =?iso-2022-jp?B?c25XQzRoeWFKN3BHRlZVbHp2TXpxNUZnTFhIZGh6OXJEUCtHZlZpVkMw?=
 =?iso-2022-jp?B?YmZuSkZ6QUpGTXZKYWNKd3NtbEE0bFhTZEMvL0FwZTk3MDg5NERrVFc1?=
 =?iso-2022-jp?B?L01iM1h0NS9GTDBtT21ZT05sWmY3U2kvOUpRSmtMMmJkcGNiZ3hiVjhp?=
 =?iso-2022-jp?B?N3RLSjZQZmErZUh3MDhHR1QrZ09YVE1rcDVpdkFseUlkWUhXV2tCSm1E?=
 =?iso-2022-jp?B?VDlJbWpFY0x0NS9LZDVMemIxaDYyTldoSGlGMGtxeDhlOHJYVTFRVEN5?=
 =?iso-2022-jp?B?bC80TncxU1BTc1BRQ0NqMk1lempaVWRtb2dHbUg2M050MUxKLzE5ZTVX?=
 =?iso-2022-jp?B?bDNnSm1nVm1OZElZSHN1ckVsczlHeG1lL1BlWTBJQ0VsRUc5bGc1eTBt?=
 =?iso-2022-jp?B?Yno5Q2ZDWlp5Y0F3dWtyM2VwOHVxL3lsZ0E4LzdTYk1Jai9ZUmptb21C?=
 =?iso-2022-jp?B?Y0Q3UVYzZlplNDJtTkg2YVoxM29oVm8wZWxteUN5dnFwT3Q3U2pLWVc1?=
 =?iso-2022-jp?B?azVIK0Mxc0o2d29qS1g4bnFvK1VWMnVZSHZvTFBtMXNnSGlIY2w0UUkv?=
 =?iso-2022-jp?B?a2lSd0dkS1FJbFI4aGV6djZ0Z2o2czgrQ2hyMzZxeFhmMkI3SHdkYVQ3?=
 =?iso-2022-jp?B?aDNyZHJOWTZrK0p1clVTWFRWM2FmMDRiYllQekZuWUtvQ1NZTjI1N2ZY?=
 =?iso-2022-jp?B?OHg0WUhVcFBtYmNuNnlqTlRSckowS01vd28xZzFnajRZUXkwVHg5Z0Zu?=
 =?iso-2022-jp?B?bEh0VyswYVI2KzJyVWJXY09NTEtCTmpoemh5RDhraUM4NWF6dWRIenFQ?=
 =?iso-2022-jp?B?V21BUW1xSkx3c2RTbHZlYm5KWWtBPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U0FLQUQ1bWRrQnVZdzVWQ3RMQjlxaC9neGN5a3V1aEdhcFc0dTR6QUhL?=
 =?iso-2022-jp?B?Lyt0d1lRUmovQUFpOGhjUTJLd2UvbG4zR2taZERaeFZyREhjY3d4MlhI?=
 =?iso-2022-jp?B?cWVzNzBKcTI5ZVBvZVFsNzloeFl2Y3NNTzdxYkJJaHBVd3gzcVg4cGcw?=
 =?iso-2022-jp?B?cG1HVWpXL1d3VjlabGZ2Q3VuOW1PRWNlTmlCZ1Z1ZEsrSldIbzhxWHNG?=
 =?iso-2022-jp?B?aGlFZzNhaG9lRDRONkNSbXRVdlF5ZmtMMnhHKzdMOWNOQlNLVDgxbEFn?=
 =?iso-2022-jp?B?MkZjNmlXa3FPbkN2TGtXa1IwcHBUUGJPQVJCeUhxZUJwNy9HNGFzZkR5?=
 =?iso-2022-jp?B?KzRQWjZHTVNiVjdFcC9Qc1BLbjJhdUh3MUVqZEN3ZHoycEx3ZzFKZDZv?=
 =?iso-2022-jp?B?QU5qRE5lNHQvYU1KbUxVcW4wODJYMjBleThVRHJHWkErQWdOTENVR0Jo?=
 =?iso-2022-jp?B?OEVTVFA4TlBMUU5wbk5KNTlyQUQwQmp5M3RPUDVXNE9MSHAwaFJMSVF4?=
 =?iso-2022-jp?B?cVBxWUYzWFVqaGhDVmVwQXZ5TjF6VUFWWUJqeldjMjRxeWUzUVdsVG9D?=
 =?iso-2022-jp?B?cnVPR2I0R2k4WFhaanA1RnNNVzRjaUx6dmNldkovN0hFeU92RWZKL3I0?=
 =?iso-2022-jp?B?eUYycDJ1RkJjOW1IZ1RwUlBkMFdnTjUvT0NRVk50SUw1YU9uRnFlQTk0?=
 =?iso-2022-jp?B?b2cyZ0hlRzUvcHZqQjFBWXpxSXZaSnNEem5ZcDlNR0E5NXV2a2dPRjE4?=
 =?iso-2022-jp?B?dHZ3OTBkUVNnL1RBTjFmcHdSN2JXUVR6S1FkKzE3K2pCMUZlT3lJdXRm?=
 =?iso-2022-jp?B?VTc3c29EejNra09Ec1B2QmF2aU50dUVvR0dBRjNIMnFJRmJiVEU1NW5q?=
 =?iso-2022-jp?B?ZFo0WCtUc3U0WkZ0NG9MOFl5NVhPd0w1YWpINldrcjdBVDFPb0V1WnFX?=
 =?iso-2022-jp?B?by9SUEI0V2hudjYwVUZHQ25KVXBBTTVkS0RYNEJUd3Z1WVp2RkpWMU5C?=
 =?iso-2022-jp?B?bHVqMDZXR3F1dkhXQ09BU1Vwd2tvK0ZzK3ZPbDlZWFhsa1JvckIzbFQ5?=
 =?iso-2022-jp?B?MWhxS0hMUFc5UDZjeUJ3S3kzMmRiWFFGSlZNMnlzRlFwS2lGdm43a3Vo?=
 =?iso-2022-jp?B?RXZRaWRXRWxRMjRjMVVBTS9KS3pLdlN2Z0lFM0ljd1RkNEowWHNaeVhv?=
 =?iso-2022-jp?B?VVhXaUFFSE5BaVhVR3EzMEs3VVZINjhZUDZvWUJoMEVYOXE0RmNBWnVC?=
 =?iso-2022-jp?B?aFNwSWRjYW5KSjNKbUdsNFJJUnJxNk9HTmo0WWxqMUVVUzlJQk9jQ1Jt?=
 =?iso-2022-jp?B?MlFodEVWUEVtV3Zwdi8yWXlQaXB6T0c3amJMclZKd29Vc1hVTjBobVF6?=
 =?iso-2022-jp?B?ZEZoQm9scDg3Y2t3T2VnV2dHWElRenlCdE5vYW1qUWJOQ1FIQU1XakpN?=
 =?iso-2022-jp?B?dDZRTVY1WkZFMHVQQllsa2hmOXdxWU1HM2NuNklKSVlGeFpTNTBXZFBV?=
 =?iso-2022-jp?B?djc4SjRNVWQwSDlaaVgzZ1N0WnJSYVFwN2ZQTnJtS0hwS0w0NG5rOEUy?=
 =?iso-2022-jp?B?c1hVZVVva2xMMVVaWFFwM0RZSTMxWGxMT2l3QS8xMEtOMEpVZDJXekZl?=
 =?iso-2022-jp?B?TFNibHUvSkFBK3QzQXprWjlFaVRWVG1NNUVJSVRmTnROaWNaaWR5SUFG?=
 =?iso-2022-jp?B?QVdUTnZPWFN1Ylhtc3lzS2hXUFE0cEJvNFN4bXJmVWNzbVV0Wm5oZkdN?=
 =?iso-2022-jp?B?ZFNqQlBaTDM0TG83Qnh3U3ZYRXgyTDE3Q29CcUc0YTFnQ01qVFNMMTBK?=
 =?iso-2022-jp?B?ekdyRlk0V05OSWtpQ1ljMWhFdGZZb3JjVTNGU2JielB5aFF3QmZJby9n?=
 =?iso-2022-jp?B?WGRtbmlPLy9VZHRDd1YydkZoL0U3UmFnVTMxV09MRnFQcHJjc1N6VS9s?=
 =?iso-2022-jp?B?dlMrUWVlaWMrWGYwVU9oeEtEQWpnK0ZCamtPRkhrdTh6NGFYUzJsMVRZ?=
 =?iso-2022-jp?B?TjcyMXlaekhxbUUrUXREdGFycWtMQWthS3FCU0lFNFB5MHZDSGVYVmRw?=
 =?iso-2022-jp?B?Mms3amFybnpMYWZUeW1ldzVFTEtnRm5hNXhpeGlXb0ZEcDVmTjZzaFp4?=
 =?iso-2022-jp?B?ajJFVm1RZjZYV1R4VVU4MnhSV015Q1NCSjYrM0dnRkQ2UGtVREFSTGd3?=
 =?iso-2022-jp?B?UldraGRmS1NWakVqL2M4RmtYMFNpNW82RC9Sd0grdlNOMXNCdlpCbDJG?=
 =?iso-2022-jp?B?M2xoUzBBMHJSSmRYMzlBTUQ5Wk05U2ViVXEwL2VVYVYwOE9JblBFdlJt?=
 =?iso-2022-jp?B?dFNVS3hCSkNLdjJsakxkUXd5aHIzeEhVaEE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610365D7958F2829214B6BF1C2692OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1682e3-dae1-49f7-a94c-08dcdd487090
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 09:57:17.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dz2hN3Jr7Zgnq6KUa1CUq+gnih/hvSuICTka/af4L8bQtOsDpD50rA99lYpTiuicO/3EF7HwlimdMZsjGg+Ej9DpxMfgN/bNiI9aB2VmGxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9610
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 09:57:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16915

--_000_OS3PR01MB610365D7958F2829214B6BF1C2692OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

This issue is still present in small runners. I ran the cve-checks job toda=
y. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#=
L655

It still shows 'Job failed (system failure): pods "runner-zwslwy9eu-project=
-10191315-concurrent-0-ulyylb1h" not found'.

Thanks and regards,
Sai Ashrith Sathujoda
________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, September 25, 2024 3:06 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; micha=
el.adler@siemens.com <michael.adler@siemens.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, September 4, 2024 12:53 PM
>
> Hello Michael,
>
> I ran this job multiple times recently. I am seeing 'pods runner-
> zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' again
> while using small runner. https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/7740352129

Are you still seeing these issues?

Kind regards, Chris

>
> When I run with large runners, the job is successful ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984 .
> That is why I suspected there might be an issue with small runners. Can
> you please provide your opinion on this ?
>
> Regards,
> Sai Ashrith Sathujoda (T S I P)
>
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Michael Adler via lists.cip-project.org
> Sent: Monday, September 2, 2024 2:28 PM
> To: cip-dev@lists.cip-project.org
> Cc: Chris.Paterson2@renesas.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; di=
nesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
>
> Hi Sai,
>
> > I thought there might be some issue with the runners as the job failure
> message said, =1B$B!H=1B(BThere has been a runner system failure, please =
try again.=1B$B!I=1B(B
>
> maybe there was a temporary issue. I just looked at the cluster and it
> seems to be (idling) fine. So I'd suggest to try it again.
>
> Kind Regards,
>   Michael
>
> --
> Michael Adler
>
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas=
,
> Judith Wiese; Registered offices: Berlin and Munich, Germany; Commercial
> registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

--_000_OS3PR01MB610365D7958F2829214B6BF1C2692OS3PR01MB6103jpnp_
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
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This issue is still present in small runners. I ran the cve-checks job toda=
y. <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/=
7885795173#L655" id=3D"LPlnk357700">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#L65=
5</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
It still shows '<span style=3D"font-weight: 600;">Job failed (system failur=
e): pods &quot;runner-zwslwy9eu-project-10191315-concurrent-0-ulyylb1h&quot=
; not found'.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-weight: 600;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith Sathujoda</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chris Paterson &lt;Ch=
ris.Paterson2@renesas.com&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:06 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; michael.adler@siemens.com &lt;michael.adler@siemens.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshi=
ba-tsip.com&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Sai,<br>
<br>
&gt; From: Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.co=
m&gt;<br>
&gt; Sent: Wednesday, September 4, 2024 12:53 PM<br>
&gt; <br>
&gt; Hello Michael,<br>
&gt; <br>
&gt; I ran this job multiple times recently. I am seeing 'pods runner-<br>
&gt; zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' agai=
n<br>
&gt; while using small runner. <a href=3D"https://gitlab.com/cip-project/ci=
p-core/isar-">
https://gitlab.com/cip-project/cip-core/isar-</a><br>
&gt; cip-core/-/jobs/7740352129<br>
<br>
Are you still seeing these issues?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; When I run with large runners, the job is successful -&gt;<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/job=
s/7742283984">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984</a>=
 .<br>
&gt; That is why I suspected there might be an issue with small runners. Ca=
n<br>
&gt; you please provide your opinion on this ?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith Sathujoda (T S I P)<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt; On<br>
&gt; Behalf Of Michael Adler via lists.cip-project.org<br>
&gt; Sent: Monday, September 2, 2024 2:28 PM<br>
&gt; To: cip-dev@lists.cip-project.org<br>
&gt; Cc: Chris.Paterson2@renesas.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB=
9(=1B(B =1B$B#D#M#E=1B(B<br>
&gt; =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.j=
p&gt;; dinesh<br>
&gt; kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-t=
sip.com&gt;<br>
&gt; Subject: Re: [cip-dev] Issue with 'small' Gitlab runners<br>
&gt; <br>
&gt; Hi Sai,<br>
&gt; <br>
&gt; &gt; I thought there might be some issue with the runners as the job f=
ailure<br>
&gt; message said, =1B$B!H=1B(BThere has been a runner system failure, plea=
se try again.=1B$B!I=1B(B<br>
&gt; <br>
&gt; maybe there was a temporary issue. I just looked at the cluster and it=
<br>
&gt; seems to be (idling) fine. So I'd suggest to try it again.<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt;&nbsp;&nbsp; Michael<br>
&gt; <br>
&gt; --<br>
&gt; Michael Adler<br>
&gt; <br>
&gt; Siemens AG<br>
&gt; Technology<br>
&gt; Connectivity &amp; Edge<br>
&gt; Open Source Embedded Systems<br>
&gt; T CED OES-DE<br>
&gt; Friedrich-Ludwig-Bauer-Str. 3<br>
&gt; 85748 Garching, Germany<br>
&gt; <br>
&gt; Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim<br>
&gt; Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and<=
br>
&gt; Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Tho=
mas,<br>
&gt; Judith Wiese; Registered offices: Berlin and Munich, Germany; Commerci=
al<br>
&gt; registries:<br>
&gt; Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE<b=
r>
&gt; 23691322<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB610365D7958F2829214B6BF1C2692OS3PR01MB6103jpnp_--


