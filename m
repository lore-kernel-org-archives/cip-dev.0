Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A1BC19F32
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 00:14:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.632.1741220093605633094
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 16:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=jb8Ecm5M;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=1741220069;x=1742429669;bh=t1
	W7SMeDe6lyKyUtiKlfd7JtIGwU6+d3m8SSI4l79nY=;b=jb8Ecm5Mtg8lVWOwSe9n8upjOF2gIFcT
	tEChvKpqmNu4DjcHxXeNnaDzILSChENQKXRnjqyxfRkt3fDn6nU7cKBghsq0uKdh0hStiEAa8ppAA
	lO2iv7vyapIOkxiwjTSntoExtA0Oje1F/27VrkKYzk4D5Ybzo/T2KYkUct7xULEOFZcBobSXZck1X
	bIq8Ntpy+YRYh6Fc0rUYjTweHKEcnZAUUseqGlQlB/raighPfTrMgY64XvCUPMnE2ku+Mp5YJTuVe
	CBzLJnvQ3yPa2HPwmwrd2X1EnBkNhx9w9qgyTQlWTNOxqo1dU8Np2cU8N+8OtLtLupRMEGZf/G5tY
	0g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5260ETJE2654142; Thu, 6 Mar 2025 09:14:29 +0900
X-Iguazu-Qid: 2rWhqikydRn1d2EWf8
X-Iguazu-QSIG: v=2; s=0; t=1741220068; q=2rWhqikydRn1d2EWf8; m=sTca/A5zJtXgddSKvwEf4X3+4E+YiuiLOhfjl00Hsx4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5260EQdY4155277
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 09:14:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT0kbUAZENGqD34w+tV5pZklzZE9Hd/z3HVcCBOWa4cx2MH3JTt6aHq6aBR8MAXSYuMX4yQFVGJ8W+CzPRAR965mKJERtcBDxLJuRE8l2imMKSGVJPnPz6PlJbkpaCeni6W3KqJngY0FE5pk0h8J9Y1yvxibS4jBv3p9POLYjB1UsC2sfmFxbp8zz0B+wgebg6D+piHZZJn3b6+8Zqavr1FiokYLd8ALwZGtPqHnQYindmOyNTX34koobVXn/JEszzxFVRR2Ma/q2+Cp7HyY1v8tHxm7qxSxqN/J9mNCiCeQE2aivTAeSC9gcShKaOrX8ZWj10K8zCNwqQ/Bn5x+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hWZUMR7A8jxjRajmthUExRNcUf3S4CtuigKwItVtBk=;
 b=eM7Xq1bTCOW2XJK3upXhjIyhBZ6rs5lTZAZ4Kx5Wy5yhfDUaLK5KEFgrz5vONOwIt0kyWDGaBykMPQDXKuM6r5A9C4QKg/iSjxpLtM9upTxiHhFSO6rhX6W05T+oD4UiQ3K+jFYFpGK4lQ4bwclHLMHMsaEBMuPPJ3ysGGKOXsUnphv9xTS+1bkOKTSCaejuXfpDoMLM8Hm12uGNvSlUwmdAo8MAEwKj/jAYo3MrKrjEkebrpKB1oWBa4+ZFSpigUoWMZY9ciZiOiO2VIpeR13TK5y7QGXSeUBijCSEDqm3L9uz2BLh8nypkCr6JyiarM+qJinrQHekVmxl5nzPunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.129-cip38
Thread-Topic: [ANNOUNCE] Release v6.1.129-cip38
Thread-Index: AduOLKTb9SVYNK7VSBeG6QUIS6aq+A==
Date: Thu, 6 Mar 2025 00:14:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F07204ED3009D5034BDD92CA2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7818:EE_
x-ms-office365-filtering-correlation-id: 4f7b2737-9564-46b9-2f15-08dd5c43da05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?S1RNdkM5b1hoVzVZWTBNOU93T2tEVzZYckttMU13K2FuRnBOQkJ3MlN4?=
 =?iso-2022-jp?B?OUZtMHFtTjZGN2xMVWJBWWttVGZ0dllqRm5KTHFGbDhVVkRRSXh4alpr?=
 =?iso-2022-jp?B?WlRmR0dzUDBNQVNQWHJFVzJMVmVPV0pWQ3dwWURsbHVHeGh4TmlCVGFp?=
 =?iso-2022-jp?B?aTBSdmdlN096dVRjdURlLzljNFlidkw3V3VyTzJrOXNrdTRTcFBwMDZN?=
 =?iso-2022-jp?B?UzFVQm8xLytQUlIyTld3U3lpZjBneUp0VFN0bVhwNTNwTnhMNzFzVEF1?=
 =?iso-2022-jp?B?amNHVy8ybXQ3d2FtMmt5M1RTMlZDVmo2SUx3RTluOVdBc2J4SGFybng2?=
 =?iso-2022-jp?B?SE1oa0NjY0V4YmtsZVg3a0QzbWJsQ2xMajNnNHNTeG4xUEc4NTQ4T2F5?=
 =?iso-2022-jp?B?blgvVDBCUVl3NzJTY1B2aCtLSDFJZlVSRkJ4YzR5RmZSWUxyOFVXWlYy?=
 =?iso-2022-jp?B?cjBISDIxUmRhdWlzUzF6TldBRmVTd0pJaVVob08zMFVML0FiOEpCTW11?=
 =?iso-2022-jp?B?NHRqaitwc3V6di9WN0xrbmY4bTdLN1Vra3FPNVYxc1NWek5jS1hmMXNi?=
 =?iso-2022-jp?B?eHlUYUNIMWJFdExnUkI0TVdSK1RudURFMTRnVmh5YVB4OUV0SHBZbVg3?=
 =?iso-2022-jp?B?aFBnS0hJdTBOM3MyN3ozMUVQMWhsQytjSGNGeTRiRFNCUDBEK3RCdFRE?=
 =?iso-2022-jp?B?NHZvWkkyVlBrclg3Ulg1TUN0RUFOYWlFSzgwR0Z5Zkx1QnBDSFhma0RX?=
 =?iso-2022-jp?B?L0JnbDM4UWRnNW5LaUZjRTR2MCtQc21hTEtpaUJUUFQ4VU9aNzZPQllt?=
 =?iso-2022-jp?B?d0o0eVhrWDQ2TGJMMU9nYkJydCtaSHNqdU44cmR2eElBaUptcWw4VFBB?=
 =?iso-2022-jp?B?dE5iM21FT2orMnRCLy80TzBxbkhScnB4YklUSkZ0MThrbk81blVIRmNC?=
 =?iso-2022-jp?B?SVNJdTZOMDZ4bUYvMzYzQzJvOUFnQUMyd3pSWWNXaW9MaDFEdWF0NlZS?=
 =?iso-2022-jp?B?dTdZcGVhRit6eDFLM0cya2R5VGRHSlArWjh3T3pFRGl6ak1BQ2hXUm1z?=
 =?iso-2022-jp?B?clpPUlllVXVTby92Sy9XTXpVMm1pNWdhVzRDeWZaVHRRNDNINVJBQVlM?=
 =?iso-2022-jp?B?MnlVSml3cDhKdVFZZlF6V2lhc2laWE5lTTZTWll2T0MvcmpXWWh1YWR1?=
 =?iso-2022-jp?B?TkE4cGJyMFJoaitId1RmeGJWTkd2dGFTZHlnVUw3bS9ZcnpaOVBLam5Q?=
 =?iso-2022-jp?B?SlUyWU92NnFVaExRNGVuSXVwU2FHbjZCTk10Wnhrb2hjTGZIVExNQnJF?=
 =?iso-2022-jp?B?bHRCS25oZ0UweFQ5dlorSWdHUTQrZTRhZ25OKzlMZFdrOEdIVkpFSks4?=
 =?iso-2022-jp?B?NmQvUkp4bGEwUU1sNXp1OFEvdE5kaTF0TDRCNkIwU3M1N0pZQ0VIUW51?=
 =?iso-2022-jp?B?VXlMVDg0UXMwd2g2NW5qdmlNU3BGWHlaS1JvM3Npak5VbS83bDRCV0NG?=
 =?iso-2022-jp?B?RGp0STlzL3ZsME5vZWRFbitpUTRmVG5nWWkyVUJmRkk4YmRXMU84bnRC?=
 =?iso-2022-jp?B?N1psdkw5MWFWNjRUb2FQUnJtMURDRkhsczk3aWo3dE10ZmVzS1ZPdjUw?=
 =?iso-2022-jp?B?YXFaSWRENG5IbTViL1hYRUlFMVd0L0N0RnE0NjQzd3FyNStIVHVnYnBo?=
 =?iso-2022-jp?B?VlFNNS9ScEQ3UFBROTNqQVRiS3VNMFlYblpHKzdRRDAwMFpiaDVOazBa?=
 =?iso-2022-jp?B?SHk0R3NTR21wWWlyS0V1R3dMV3h4RUc2RE94bkxwTXZWaGkzcXFnd3Q0?=
 =?iso-2022-jp?B?VXdTVTMrdmZueHA2bFdVR2tuSVVaTUlHb2VISGVuQ2tBdFBJQW90VjhP?=
 =?iso-2022-jp?B?eTNKaHZYVUEybjVDdUtORFJmUmhXRk1LYWhDMUNCbmVmUFJlandLMEtl?=
 =?iso-2022-jp?B?S1VKVmFxZW5iWWUwamJGSWVJaTE3c1hVMDczRWhCcFIrN05WRnlFdGx4?=
 =?iso-2022-jp?B?OVZLTmwrYktQL29sVVRMYjFDK2VNaHVkVXBRemg5aS9rT2llYkJmOWcv?=
 =?iso-2022-jp?B?c0dIeGJaYWQweU5ZYURFN04vUzJxN1lDWjNmM1U1WnJTbHNibDNXaFVC?=
 =?iso-2022-jp?B?SlVnSU5UZlE5Wlh5SWJpajlmZGxRWkV3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SFRxdW9SSDVTSXp2TzdxbWJXRmFqeXdEekZsQklkNVJ6VEl3K05mVGxj?=
 =?iso-2022-jp?B?RGtGSVFNS1ZKZkg1eUROQmtOUXhNeDNYQ0ZncUpkK2ZpcWJTd2pxaUxO?=
 =?iso-2022-jp?B?aG9oYjhUaWJla0V6dzU1SUdwdFc3V2FuVWpHNWhpRUNkWGhyMENYTmdX?=
 =?iso-2022-jp?B?eGQyNkY3S21kb0dHWXkrNTVWcmZqTjZYWnVBclFJM1gveWYvMVh6TlJD?=
 =?iso-2022-jp?B?bk9ab0d3Ym5JSDRSREw1QjcrMWlWd2tnZzFzTU1zbDNLZmxwa0RHYWFY?=
 =?iso-2022-jp?B?RGRUUzlnZGtsd0ZUakxnK20ycm4zei9scFl2Y3hXdjdKSk5TamZ3YVBB?=
 =?iso-2022-jp?B?eFcxY3BYTlk5K1RieXhqR0FRYjI5eFM0T2xRSC9udHlaRjgrTyswckFG?=
 =?iso-2022-jp?B?SWRQUVdOUWY2VXdaNGd1VzJYeGRnWlBXWWJ4TFQ5N1FSSW9MSXZ6RVlS?=
 =?iso-2022-jp?B?L0NPdnRnVElVcWN6d2JXVkEzRHp5OU1teU9UaWwyR1hmR3psdVljSVVL?=
 =?iso-2022-jp?B?czBndWNEOXZuSHk5YitQMmFzT1lCVm9WeFpzYTRiNmdlNndWdE1QQnJ3?=
 =?iso-2022-jp?B?cVpZeEJKY0hkay92a0QvdnRJTjE5TUl3Z3JGTDFzWlNRNDZQUkV6U3Vo?=
 =?iso-2022-jp?B?eWFDZkNTSy9FM0srQUd0cmpYVDRUWFUvMzl6aDFTZEtYOGgyQ2xSZGk3?=
 =?iso-2022-jp?B?UnFXSTV5QlpuQVdiZ0VuMGNTS2pDMkFKbG5VbWR2dXY2bzg1Nno2QU5w?=
 =?iso-2022-jp?B?VVd1Y0M5RE54Q2RENk80b0NRQ0Rtay8rQ014aVlUUjBtWEdwMzRXVUVk?=
 =?iso-2022-jp?B?ekJ6d0VLWUZ1Q3RVM1FyRE1Eb2JpY1FmemFGMWtMbGVQbG5abDM3a05q?=
 =?iso-2022-jp?B?U1U4dFREaExsUE02VU9vRkpkVXk3OGE0RmczT1dkNng0WmZuQWdTUDdM?=
 =?iso-2022-jp?B?bFl6L2VZZjUrQkNPZGdsOTFSbk1uY2M1dHkrZTlRT04zR0Q4UTJlNTBN?=
 =?iso-2022-jp?B?VmVFRHdGOGpHUGFOQU10ajdBbTFobG1XZTVxWUdiWnV0eVQ2eS94dkl2?=
 =?iso-2022-jp?B?N2FmQXFyNFN2eE1XbzhmOTQ2VkxCczZqcHNza0p2cGxEcXcrMW02YzRI?=
 =?iso-2022-jp?B?VXowdGpMTW9yZ29WUEYvdUVveUJmUlp4YkhHRGxyYUlVNE54cUtVeElO?=
 =?iso-2022-jp?B?UzIwd3EwK0FDTTlTcGdLKzJSWHZQUk5FbFRlbUxQWmp2Wm5rYkVCcjBl?=
 =?iso-2022-jp?B?dnhSaTN1NUJ4OEpQejRkU0ZPS2hXNGorQWtyRWp0djZGNWlYbFJBMk9z?=
 =?iso-2022-jp?B?NFRjTkZlcFlYN25LS0h6OURldHQycE50MWE1OG5zMVJCb3VsbHNNd3Z1?=
 =?iso-2022-jp?B?dWdkM2pPVW9xRExwc284aGZGSDhKVk1yVVM0d1JUR1Fiek42STdSZDE0?=
 =?iso-2022-jp?B?MVNNREVXckRFS3dxeE9ZWFFpd1NmTWtubEtjOWhiUjBwbUlDTjRTRmhp?=
 =?iso-2022-jp?B?eUpYdkVORFNuWjVWQnlZT0N5TU9OZE5FNWJBaFVxTE5TTUwrMkw1bW9R?=
 =?iso-2022-jp?B?S0puaHhXcHB0N1pLV1BrQXVlMzFZZkpLWjFmaGJSTDIwVnArRFBwYkJ0?=
 =?iso-2022-jp?B?bi9ocjlEdXJsUE54QUpjcVNpKy9mS2hEeitIYnF0THpzSVZvd3RKaHlV?=
 =?iso-2022-jp?B?OFJFVXJHZTRNRzBGY2dLRFh5T2NEOTN1OHNkdmwrSmFuU3JyOGluK1cx?=
 =?iso-2022-jp?B?bWp0aGdhTWVGYUVUMnJKTVEzck1taVE0QU1YQ3BMRnQyMnQ1THp2Y1Jx?=
 =?iso-2022-jp?B?SVl0R0xKNVJvWVlqNWJtVFAwVDFMVm1wdjkzdTRCYzExUVNldzUycGQ3?=
 =?iso-2022-jp?B?ZGFYUW1BaEs0b2txa1Y3TWlYZEx5ZnZUWlBaVWEwUFNqU3BXcThGb0o4?=
 =?iso-2022-jp?B?Y2hOR1h2czVHQ0tjVU5iVWI5SEd3ckFrdW50R1JWZVFOTGQzZHlnVjd1?=
 =?iso-2022-jp?B?QjAvQkhnRERkYkpWMW8reUl2LzIvK0dKRExZY2dIYjYxTC9XSGZMSlE2?=
 =?iso-2022-jp?B?VENIcnhwMHB0SmpjcVJrZk03U3JLZFZtNzl0bmFCV2pSY3RsUEwyYjFk?=
 =?iso-2022-jp?B?SUdDT04ybUJZVjJzK210S2FWbUE2WFR4LzdJL2o2bDhjN2pKNERXNmxJ?=
 =?iso-2022-jp?B?K0V5dGYrc3YvbC9YNjVYa29UNFNNZlMyUlJLOHBwaE1zOTVCdElTU3cz?=
 =?iso-2022-jp?B?Z0J4V3BmQ0VpblVRcldwa1ZEeGJGeDQ0QnIreitaUFJ1VlRyd2NlQVZQ?=
 =?iso-2022-jp?B?TXRWMWx1SnB6VTlmYnR2VGt5V0RiWFBybmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7b2737-9564-46b9-2f15-08dd5c43da05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 00:14:24.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJeo0+ibv/GK3YGunRq/kP6wCqxvMh3gXvZelxGeN6dSOWm43/githSgC27XvlFrZdZpQ2AeqpIwp6QeO2ipYJcnLePuqB6Z3BteA66u6PZUeekhViwaT3AhuSG3Z+Wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7818
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 00:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18048

Hi all,

CIP kernel team has released Linux kernel v6.1.129-cip38.
The linux-6.1.y-cip tree has been updated base version from v6.1.128 to v6.=
1.129.
This release includes fixes for the Renesas ARM64 SoC ethernet device.

You can get this release via the git tree at:

  v6.1.129-cip38:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      8da62141b20bae3e0cfb12c3537d530d14f02441
    fixed CVEs:
      CVE-2025-21703: netem: Update sch->q.qlen before qdisc_tree_reduce_ba=
cklog()
      CVE-2025-21748: ksmbd: fix integer overflows on 32 bit systems
      CVE-2025-21719: ipmr: do not call mr_mfc_uses_dev() for unres entries
      CVE-2024-58034: memory: tegra20-emc: fix an OF node reference bug in =
tegra_emc_find_node_by_ram_code()
      CVE-2025-21761: openvswitch: use RCU protection in ovs_vport_cmd_fill=
_info()
      CVE-2025-21806: net: let net.core.dev_weight always be non-zero
      CVE-2025-21718: net: rose: fix timer races against user threads
      CVE-2025-21823: batman-adv: Drop unmanaged ELP metric worker
      CVE-2025-21727: padata: fix UAF in padata_reorder
      CVE-2025-21818: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
      CVE-2025-21781: batman-adv: fix panic during interface removal
      CVE-2025-21753: btrfs: fix use-after-free when attempting to join an =
aborted transaction
      CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configure=
d
      CVE-2025-21704: usb: cdc-acm: Check control transfer buffer size befo=
re access
      CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_s=
ock_alloc
      CVE-2025-21716: vxlan: Fix uninit-value in vxlan_vnifilter_dump()
      CVE-2025-21775: can: ctucanfd: handle skb allocation failure
      CVE-2024-57986: HID: core: Fix assumption that Resolution Multipliers=
 must be in Logical Collections
      CVE-2024-47726: f2fs: fix to wait dio completion
      CVE-2025-21749: net: rose: lock the socket in rose_bind()
      CVE-2025-21772: partitions: mac: fix handling of bogus partition tabl=
e
      CVE-2025-21779: KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if loc=
al APIC isn't in-kernel
      CVE-2024-57979: pps: Fix a use-after-free
      CVE-2025-21701: net: avoid race between device unregistration and eth=
nl ops
      CVE-2025-21802: net: hns3: fix oops when unload drivers paralleling
      CVE-2024-58017: printk: Fix signed integer overflow when defining LOG=
_BUF_LEN_MAX
      CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many =
configs or interfaces
      CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain co=
mmand aborts
      CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in brcmf=
_txfinalize()
      CVE-2025-21706: mptcp: pm: only set fullmesh for subflow endp
      CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()
      CVE-2025-21814: ptp: Ensure info->enable callback is always set
      CVE-2024-42122: drm/amd/display: Add NULL pointer check for kzalloc
      CVE-2024-50070: pinctrl: stm32: check devm_kasprintf() returned value
      CVE-2025-21707: mptcp: consolidate suboption status
      CVE-2025-21795: NFSD: fix hang in nfsd4_shutdown_callback
      CVE-2025-21780: drm/amdgpu: avoid buffer overflow attach in smu_sys_s=
et_pp_table()
      CVE-2025-21782: orangefs: fix a oob in orangefs_debug_write
      CVE-2024-58013: Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt=
_remove_adv_monitor_sync
      CVE-2024-57978: media: imx-jpeg: Fix potential error pointer derefere=
nce in detach_pm()
      CVE-2025-21700: net: sched: Disallow replacing of child qdisc from on=
e parent to another
      CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()
      CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()
      CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32b=
it
      CVE-2025-21762: arp: use RCU protection in arp_xmit()
      CVE-2025-21792: ax25: Fix refcount leak caused by setting SO_BINDTODE=
VICE sockopt
      CVE-2025-21820: tty: xilinx_uartps: split sysrq handling
      CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove
      CVE-2024-56549: cachefiles: Fix NULL pointer dereference in object->f=
ile
      CVE-2025-21728: bpf: Send signals asynchronously if !preemptible
      CVE-2025-21821: fbdev: omap: use threaded IRQ for LCD DMA
      CVE-2025-21724: iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_=
bitmap_offset_to_index()
      CVE-2025-21705: mptcp: handle fastopen disconnect correctly
      CVE-2025-21766: ipv4: use RCU protection in __ip_rt_update_pmtu()
      CVE-2024-58016: safesetid: check size of policy writes
      CVE-2024-58011: platform/x86: int3472: Check for adev =3D=3D NULL
      CVE-2024-58007: soc: qcom: socinfo: Avoid out of bounds read of seria=
l number
      CVE-2025-21734: misc: fastrpc: Fix copy buffer page size
      CVE-2025-21708: net: usb: rtl8150: enable basic endpoint checking
      CVE-2025-21794: HID: hid-thrustmaster: fix stack-out-of-bounds read i=
n usb_check_int_endpoints()
      CVE-2025-21711: net/rose: prevent integer overflows in rose_setsockop=
t()
      CVE-2025-21726: padata: avoid UAF for reorder_work
      CVE-2024-57980: media: uvcvideo: Fix double free in error path
      CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe(=
)
      CVE-2024-58010: binfmt_flat: Fix integer overflow bug on 32 bit syste=
ms
      CVE-2025-21811: nilfs2: protect access to buffers with no active refe=
rences
      CVE-2025-21767: clocksource: Use migrate_disable() to avoid calling g=
et_random_u32() in atomic context
      CVE-2025-21812: ax25: rcu protect dev->ax25_ptr
      CVE-2025-21796: nfsd: clear acl_access/acl_default after releasing th=
em
      CVE-2025-21750: wifi: brcmfmac: Check the return value of of_property=
_read_string_index()
      CVE-2024-54458: scsi: ufs: bsg: Set bsg_queue to NULL after removal
      CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()
      CVE-2024-50061: i3c: master: cdns: Fix use after free vulnerability i=
n cdns_i3c_master Driver Due to Race Condition
      CVE-2024-58001: ocfs2: handle a symlink read error correctly
      CVE-2024-57997: wifi: wcn36xx: fix channel survey memory allocation s=
ize
      CVE-2025-21804: PCI: rcar-ep: Fix incorrect variable used when callin=
g devm_request_mem_region()
      CVE-2025-21725: smb: client: fix oops due to unset link speed
      CVE-2025-21799: net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65=
_cpsw_nuss_remove_tx_chns()
      CVE-2024-40945: iommu: Return right value in iommu_sva_bind_device()
      CVE-2024-57993: HID: hid-thrustmaster: Fix warning in thrustmaster_pr=
obe by adding endpoint check
      CVE-2025-21819: Revert "drm/amd/display: Use HW lock mgr for PSR1"
      CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()
      CVE-2025-21790: vxlan: check vxlan_vnigroup_init() return value
      CVE-2025-21791: vrf: use RCU protection in l3mdev_l3_out()
      CVE-2024-58014: wifi: brcmsmac: add gain range check to wlc_phy_iqcal=
_gainparams_nphy()
      CVE-2025-21684: gpio: xilinx: Convert gpio_lock to raw spinlock
      CVE-2025-21758: ipv6: mcast: add RCU protection to mld_newpack()
      CVE-2024-26596: net: dsa: fix netdev_priv() dereference before check =
on non-DSA netdevice events
      CVE-2025-21745: blk-cgroup: Fix class @block_class's subsystem refcou=
nt leakage
      CVE-2025-21731: nbd: don't allow reconnect after disconnect
      CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cachei=
nfo array
      CVE-2024-49989: drm/amd/display: fix double free issue during amdgpu =
module unload
      CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation
      CVE-2025-21722: nilfs2: do not force clear folio if buffer is referen=
ced
      CVE-2024-57834: media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_=
thread
      CVE-2024-57998: OPP: add index check to assert to avoid buffer overfl=
ow in _read_freq()
      CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit
      CVE-2025-21738: ata: libata-sff: Ensure that we cannot write outside =
the allocated buffer
    added commits:
      CIP: Bump version suffix to -cip38 after merge from stable
      net: ravb: Add VLAN checksum support
      net: ravb: Enable IPv6 TX checksum offload for GbEth
      net: ravb: Enable IPv6 RX checksum offloading for GbEth
      net: ravb: Simplify UDP TX checksum offload
      net: ravb: Disable IP header TX checksum offloading
      net: ravb: Simplify types in RX csum validation
      net: ravb: Combine if conditions in RX csum validation
      net: ravb: Drop IP protocol check from RX csum verification
      net: ravb: Disable IP header RX checksum offloading
      net: ravb: Factor out checksum offload enable bits
      net: ravb: Fix R-Car RX frame size limit
      net: ravb: Fix maximum TX frame size for GbEth devices

Best regards,
   Nobuhiro


