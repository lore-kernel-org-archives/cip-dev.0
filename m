Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27EC3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 01:47:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.6022.1721267244809759664
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 18:47:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=oIirQGlZ;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1721267238;x=1722476838;bh=r73ZSFM9JZ3egzTjbw1f3xALcDillzWk7Yhu59w
	vPyo=;b=oIirQGlZcEeRB7tA0pAI4Mg4hs9HvaD2aymXG4qcMIhLbmXRUlcHtdO2MXlv9fEaCaILM
	CcQzAo6O7zzzjmezAs67TB2+RCrxmtaKq+DsD8tO+kxy4rVDDBuPr2M6Zoaan8mQIGRh8S+KQo0+S
	g7y6shIbU3Qqn/ywB1cUg32YqEruWQHeurVmDUCtgjrmOi1FKGI2959f5wdA+PwmHYYvotxhh5lrL
	u8T1dNWOhdggPG403ufbl1eKRXSzGMa9C9mZ9/9qA+ItT4E2lzfaiGT2AlEhghGTZ2vIUZFCrywkD
	m5afuNp4sVPH0g6meXCsir1ni6kE+ORdfxOIwBhwmQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 46I1lII42108664; Thu, 18 Jul 2024 10:47:18 +0900
X-Iguazu-Qid: 2rWhoo1A0AXJuQ9r2X
X-Iguazu-QSIG: v=2; s=0; t=1721267237; q=2rWhoo1A0AXJuQ9r2X; m=6G0xdanAds8rWQLA7/TzEm7isFyTfDZ14YEcXWgMHls=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 46I1lGLP3976647
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:47:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yANWoqyQvG3SGl5tL2desKEv0ToUyhoKHcOhoCmqd2TGCzbGkVwBg6143/0YOxGoilTXzTBxSNMRLEZ2orD+oG6q6Yzz6EW6dwLQUchauT4ffoO/WcCHtuDHJDFtuIAaQSDkuIlpfOjP6nbXoS5crv4IePEMoDT4qkzbM7nXVgDo1hAGT2Z2//LrkbVQwixl7cYUkd+pojDl0CS3TH4u25pLW1UDRTPBSi/GYKnMsDVVCuefZAml2/hkm0pVnwMP8l8bMuLVOfSKA+F/tAkDoPRHZsxjgVEsJ0l/bm0xRjm3kKqjWImXVTCNGQ7OxCiD9RQQaYevL8gkO7LTh3z5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzanJzwWXDGU1Pqq1NqV5PZ4931PN2tRdT7pqInuqbs=;
 b=loeSRFOpY/7anDKYv5zz2TFwp0ugVDcpc+wUQBTcx+hc0ra4XmQxI5a5EF/oxDV7Pn1tXbfrGY6dVYtZq0/k7A3/PnCnI+kijoRNuSrarXF7DsxDPR3euUhcTVHrQSJE+hlZNB5PaYrKx4GagDT0wCL2HimsRALWt2jWJ9YPRhOIolzmB0pXlmFBmxZy2vWAWTP7oRBkR6/G+3WU8FQd1ZBxnOY/Ts4GOeyF6+AmUAbbl4JlSFPMNYRfFmU659FRFmXTG/2XKeBhGZJkyRf6NifJ0Ih7iI5xZKn73qAO9zcOnzVbLNpZduy48WsClZo2XEGY+Qv0IqhzT/7FtEROjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
Thread-Topic: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
Thread-Index: AQHa11W8gYbp5J5R2EaqLmqDyvjj9rH7ufxw
Date: Thu, 18 Jul 2024 01:47:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB639111E831D0C816B954D7C892AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OS0PR01MB5811:EE_
x-ms-office365-filtering-correlation-id: aa6f4741-91b9-46e9-863a-08dca6cb8bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V1ZYKzlLc215VDFmbUMzaHFGZGFvMlRDdDd5Zk82eFJxdlc3ZEFCQTlH?=
 =?iso-2022-jp?B?bUVDSFI0dFRrVW5wa2ZneDR5RDBiZE83NGJzdUhFa1dnaGc5MlJNZG5Q?=
 =?iso-2022-jp?B?NWVrcWJza1JadElpYlR2TzkwU0hGczl2UmQ1Y1o5NVpDaWZ2ZHAra2dH?=
 =?iso-2022-jp?B?a1JvMW8vUVdCVld1eW5PVzVRSFBCaTlORWJWcXJiZzRJOHpUNUVlU1Bs?=
 =?iso-2022-jp?B?Wi8rRGNxKzlBdi9UL0JFdG8vOTdFbmsyd216UXQ1UGQ2OXdUWXJCMm1k?=
 =?iso-2022-jp?B?a2JLTjg0aE5YN0hQNlVwY0hIQTk1WEl5Sk1XZUtqTG9TVnc2WFlSaC9x?=
 =?iso-2022-jp?B?MUVaOGJrd1lJbEtndTlLQUlueHJSWWFHU3psRFZIUVlFNk9hWGljMXFu?=
 =?iso-2022-jp?B?VFVGbVcwaDBHUTI0R2pHNmZqUXl0MDUvQitSSklSaUh0b2tpUUFQS1Vk?=
 =?iso-2022-jp?B?bVpybUkxeG1NbVJJOEdXY05lckZlR3EvcUVGdmxzTjVGMDBDNXFFMjRv?=
 =?iso-2022-jp?B?bWlmWTBOWi9seFoxMzFBazlrZmlkc0E3Y2prZjlXQnRkZWlpWHNSQUVn?=
 =?iso-2022-jp?B?VDUvbU11cHlWTG1wOGowdmsrN0UvSUNsSlQ3V1FGdWcrbzBGRGdmSW95?=
 =?iso-2022-jp?B?Sk03VlAxdlpvOVBDcnZ3Tm9TMW5YbzdUOWE1R3Z4aXFJR1VURlo3bDF2?=
 =?iso-2022-jp?B?Q3IydkZRVnptRGc3NStobWc4SGRTNm9VTXpZRllXdDJOUnJ2MEh6cyth?=
 =?iso-2022-jp?B?TVN1M1VCUXdSNjBtSVR6RWRSNkw0SC9SVjNQT3BKMEt1MGtBWTUzbCtT?=
 =?iso-2022-jp?B?eUJvWVFvaGY5OGMyZzVBekdyZ1E4Nk5lSUhOT1U4REhSa2REd0FZVWdV?=
 =?iso-2022-jp?B?UVBoN3plTXl6cDdSckl2NENWY3JKaU5EaDU4SmJEbjVVRlR4dDJEUy82?=
 =?iso-2022-jp?B?dUhNeml0YjVLbmNnVnQyUUk0OWJJcXZQb0J2YVBzU3JjV2xERVlyK1pM?=
 =?iso-2022-jp?B?aTZqQmpWYkJEbFg3Ny80ZlFNQW8zY3JMTFdFb0lJZC9MZytza2dpSWNX?=
 =?iso-2022-jp?B?RWkxeTJ1VVo2U3FGR05nOWViTDBUU2VMQUJMV3NOSUJpa2JiREs3aGZQ?=
 =?iso-2022-jp?B?cTVIWGVFY0NvbmRTSWVSZ3lpdWZwUGhJZjRoS0crVkVKWlROU0EwOFRX?=
 =?iso-2022-jp?B?Y3dkQUMwQmdLd3NkMHZjVkNNd3lZUURvck5VbVkrUmxtVERKQUtpRlhS?=
 =?iso-2022-jp?B?TmoxaU9rQXdTSllQa1J5bFJLN3E4YjlzZSt6RFgyV0JyYXhoWFU4WnYr?=
 =?iso-2022-jp?B?MWpaL0FUWm93RXpmVm9xWjg2ZnU2M25qMytVTG1FZTBDTmhQbk95OWEr?=
 =?iso-2022-jp?B?RmNQVnUyUWhMaXIrL3RiL3ordHpSb1BIR0FJdmZOTEJtUnVTbmYvZisy?=
 =?iso-2022-jp?B?WWRUSTZyd3FkSk40S0tFQkFGdzU4NFFoOTNHRFN2SjVDTlNLTHpsc0tS?=
 =?iso-2022-jp?B?bGVuRlVaamVtV1NmNFVEaVp1UVJjMmpVU25rU3lQM3lodDh1STBEY2ly?=
 =?iso-2022-jp?B?WWRxY3o3SFJlY1MrRWZNc091aGVONThpcXhJSmRPc0VpZHZBTkRyV1ZR?=
 =?iso-2022-jp?B?SW45ZlA3MlNIKzNWUHRNK043YW9IMFZKTVNkd3BzVU5LRFNIZTJSMHlt?=
 =?iso-2022-jp?B?TGVOREdpa3hTUWdIdW0zVWg5Qi9jQmcvR2NIaXZkU3dSMC93c3Ryakdx?=
 =?iso-2022-jp?B?K04vRFFpZUw2U0JYY0JjRzlrUUc4UDRnbTNIUG10US9FR3A0WVgvc2Yx?=
 =?iso-2022-jp?B?dmt6MjVFZlZmVG9KWHRRb09CSW5yUGRZZjU4OUQwU3JjMUhwc1poaVNx?=
 =?iso-2022-jp?B?V0FFcm1aa2RFbDl5aHpCaS81RFQ0NXIxaHZoVDAzRWFGNVBmYUI5NFNw?=
 =?iso-2022-jp?B?UXMzWDRha2t3WXg5VldCelFQNlYvQml0NzQzcURRQmRUM2RycWNmbjA3?=
 =?iso-2022-jp?B?N0E2WUg1K0xBR043SHdTSklVUmhDc0JTRi96M3BPYzBxYm9LaEFxRXVi?=
 =?iso-2022-jp?B?dUU1WXp4Z0xsSHRRYzhNdnBhVWNhUXFJVS96bFBZbTVoR0RoNEpSMmto?=
 =?iso-2022-jp?B?ZkE=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K2p4Q0FhcUQwYUs5LzRmRFpjLzNEYWJOaVBXN0NraWIwZHJBZXhIVHJk?=
 =?iso-2022-jp?B?YmxTbWkzejFIZWpzUSs0OXpibzUwT0VYeU04RWo3Z0ZJUFdHSmVjRW54?=
 =?iso-2022-jp?B?QVZCUGdEVmFST0tTbDgvSHJxU3hGSmlyWkNNbVN3M2N4emh6QTBiR002?=
 =?iso-2022-jp?B?U3YvbHNmTm1OancrMmREdGxVeVZnYU83c0hNWXZOek1Pbzc4ZmJsdEZ0?=
 =?iso-2022-jp?B?cFZXWTdZbFdBRE1KMGFJVWxzU04rMGxoaXFObFhpRU9GazZpbnlVRkFx?=
 =?iso-2022-jp?B?eU1vOUFUV0huK3FRdGdNS1M3ZjFUc3NQZUpSdTcxZVhERmE4ak51ZWpI?=
 =?iso-2022-jp?B?a2I0dzR3V01SUnNhM1hGUUREQkVoRWtybVNQQXg2dWtaa2s0L3V4b3BR?=
 =?iso-2022-jp?B?a3hhOGtGVnh6dGpxbUJCK2hLTzQ0TXZmSUo4ZmlQMEtaZCtGdXI0MFFH?=
 =?iso-2022-jp?B?MkJsbTJzTkhtK2lrRlMwNm1WUEtmdkNkRWhQOCtMVmJmSFJqUUlvb2Vk?=
 =?iso-2022-jp?B?TkFEMHdGb3JNQnpNTElZQ0NwWUVWeGJmSzdqZVBsMFhibE02SHZ1QmtX?=
 =?iso-2022-jp?B?ZDFvWGVweGRlVjJlMllKRkg1MlNobzVwTWR6U3ZhM2NORm5iQ3pmRmJV?=
 =?iso-2022-jp?B?ZUNKeDBsWlJJT3Y4ZUFvUys1SHRmcHF3ZCtuR3JSeFQ1TnZyenVxaHds?=
 =?iso-2022-jp?B?ZmViRUpvYTJaQUpqM0ZRR2F0NkZ5L0NrRk5aSjF5ODNuODdsK1d5NHJG?=
 =?iso-2022-jp?B?eEtNeGlEY2VSUjJ1N0NJdGlvUTdISjVZQ29GQStmVWxhSVBSM1RkV3Jn?=
 =?iso-2022-jp?B?UHhSZ0FEcExrQmg2VmxCRHAzSEtrQ1BPaERrR0dHQlA0YmwwYlJFRDFh?=
 =?iso-2022-jp?B?ZzZLUXA0M2RNOWVkS3ZVUXlDQStYcVFhOTBVbU4wUlBOdFhsUExwcjF2?=
 =?iso-2022-jp?B?cDc1dlVvRk45UGxCcGJZOWIrcmlxWGZjY2p3cERrNEdtNG5YKzQvSGVp?=
 =?iso-2022-jp?B?OU5HamtyUDVzM1NwaEpyS3pIbGprZzhpanBaVStDQzNubThKWlRjQVky?=
 =?iso-2022-jp?B?V0dON3NEMWZ0YmhtVnp4UHZXUnM1WUYySFdHK0lJajNYaWdIZkRZTUJl?=
 =?iso-2022-jp?B?T1FLVHoxaWoyMjN4b2hndUpwTkE1TWhTVU9TRENWRHJDSFRtSHZLNjZv?=
 =?iso-2022-jp?B?RWpDUXB0Y1RTd3k4aTlsb0U3cEJ6VlE1Qis0YXRaMy96U3prK3EvbXhp?=
 =?iso-2022-jp?B?R1RkbDJTWGFTN3JmNXZjTDVMNzhoNEJwYVhFUzI5WTdUUzA3TFoyOVll?=
 =?iso-2022-jp?B?ZUlMT0ZpQkFPZ2prYS80ZERUOXRjTHNmZXN1TXpqSi9ycWxDYnNlSVl4?=
 =?iso-2022-jp?B?RW1mU29naUtNb2FIc1RoVWQxMHorb1Y2TE5oRWVWcnVHMlJMcFdEbWdm?=
 =?iso-2022-jp?B?SGU0T2NvNDNDajl4cjluTzdPUkM5SmE3ZEptK1ltbW9GSjhvdm9MVXdq?=
 =?iso-2022-jp?B?MkptenVGKzFNbVlVZWdVMzRka1R3dkVkUXdPNXFnR3FSUkZIcnRQS3Jo?=
 =?iso-2022-jp?B?MExkTEk2N1RqTE04Z081TjZYV2tHcGxVVUFJeC9DOTRnRjlLajlpdEJ1?=
 =?iso-2022-jp?B?OE8rU0MyU1B3M0U0MWN4V1RyZ3d3cU15NS9tYUlVR29oVnk0STJ0azhm?=
 =?iso-2022-jp?B?QmhGd1RyTWh6b3FaL01Xb0ljQnk1SFpidnRhQjh3YVhqU3l0M0FJbC9D?=
 =?iso-2022-jp?B?eElBck5DWE55bm05RUp5MW1VRUhKbXBJYnN5c1Fwa2FUNEFLS1gxZG1z?=
 =?iso-2022-jp?B?T01jdVg5VWhHQkpQdkRzbDhOVUVUQTh0T1l2SjRkWGdoSlZJRlRZT3Rn?=
 =?iso-2022-jp?B?UGY2WW9KR1NDeVhLTWFwQzM2ZDA1QkZoM25LWERnNjl4U2pNZWcra2VZ?=
 =?iso-2022-jp?B?NGhORHBMa2t1ZCttTWNxTmRpRkFjd3dON3ArSHZKYlo1Mm5mVmZEL1Ru?=
 =?iso-2022-jp?B?c0RyTTcxYlgvQ1BJTDJJZXF5UENSSjIyTVdlWnlFZ3hGM0dhczBuaUJ3?=
 =?iso-2022-jp?B?dlFNNlYyUk4zQkVpSWpJRDFQWDdybnNKd21ZL1JoUVhRUlplWVBXSzBx?=
 =?iso-2022-jp?B?TTNhcGt4TnFVZmhYcnBwYnpvVGF2N0tKTWxqSy9nT3BodHd6NXQ3OWsy?=
 =?iso-2022-jp?B?UTRoY3NDVVJ2OFNiVGoxMEVLdnhqV0E1OVllTXdaYmtnRGljRENLczBx?=
 =?iso-2022-jp?B?ck91UGhUNGh0aVQ0dVZaampnSzdzUVByUUxLVzJWaEthbkNaQkNkbjZy?=
 =?iso-2022-jp?B?RUJtb3lhNmllOWNhbHVPVmtSR2ltclVINWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6f4741-91b9-46e9-863a-08dca6cb8bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:47:13.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XamJv5ei9GmZaSFk06fsW7YQ+lKht+q79kR4dLsRDHwJ16e1dglZLAGHLbief7OlkNwReahjPG8NUV10o7Zb/jv0oUrvnFJApS84U1HmN+2VgzqdLuQLAaROfEYQMdFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5811
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 01:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16572

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, July 16, 2024 4:56 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
>=20
> This patch series aims to add PMIC DA9062 support for SMARC
> RZ/{G2UL,Five} EVK platforms.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (18):
>   mfd: da9062: Simplify obtaining I2C match data
>   rtc: da9063: Make IRQ as optional
>   rtc: da9063: Use device_get_match_data()
>   rtc: da9063: Use dev_err_probe()
>   pinctrl: da9062: Add OF table
>   Input: da9063 - simplify obtaining OF match data
>   Input: da9063 - drop redundant prints in probe()
>   Input: da9063 - use dev_err_probe()
>   dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
>     watchdog
>   dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
>   dt-bindings: mfd: da9062: Update watchdog description
>   dt-bindings: mfd: dlg,da9063: Update watchdog child node
>   dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>   dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
>   dt-bindings: mfd: dlg,da9063: Sort child devices
>   dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
>   arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO
>     and ONKEY
>   arm64: defconfig: Enable Renesas DA9062 PMIC
>=20
> Christoph Niedermaier (2):
>   mfd: da9062: Use MFD_CELL_OF macro
>   mfd: da9062: Remove IRQ requirement
>=20
> Nik Bune (1):
>   dt-bindings: watchdog: da9062-wdt: convert txt to yaml
>=20
> Samuel Holland (2):
>   rtc: da9063: Mark the alarm IRQ as a wake IRQ
>   Input: da9063 - add wakeup support
>=20
>  .../bindings/input/da9062-onkey.txt           |  47 ----
>  .../bindings/input/dlg,da9062-onkey.yaml      |  38 +++
>  .../devicetree/bindings/mfd/da9062.txt        | 123 ---------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 248
> +++++++++++++++---
>  .../bindings/thermal/da9062-thermal.txt       |  36 ---
>  .../bindings/thermal/dlg,da9062-thermal.yaml  |  35 +++
>  .../bindings/watchdog/da9062-wdt.txt          |  34 ---
>  .../watchdog/dlg,da9062-watchdog.yaml         |  54 ++++
>  MAINTAINERS                                   |   6 +-
>  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  58 ++++
>  arch/arm64/configs/defconfig                  |   4 +
>  drivers/input/misc/da9063_onkey.c             |  70 +++--
>  drivers/mfd/da9062-core.c                     | 197 +++++++-------
>  drivers/pinctrl/pinctrl-da9062.c              |   7 +
>  drivers/rtc/rtc-da9063.c                      |  83 +++---
>  15 files changed, 573 insertions(+), 467 deletions(-)  delete mode 10064=
4
> Documentation/devicetree/bindings/input/da9062-onkey.txt
>  create mode 100644
> Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
>  delete mode 100644
> Documentation/devicetree/bindings/thermal/da9062-thermal.txt
>  create mode 100644
> Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
>  delete mode 100644
> Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>  create mode 100644
> Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
>=20

I reviewed this series, looks good to me.
I can apply this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


